/* Maestro per-user dashboard — the product command center.
   Strictly single-tenant-per-session: every read is the signed-in user's OWN
   RLS-protected maestro_dashboard row (auth.uid()). No session → no data; we bounce
   to the sign-in page. There is no path here to anyone else's data.

   Data sources, in order:
     1. Live calendar via the calendar-sync edge function (on load + "Sync now").
     2. The user's maestro_dashboard.status row (brain-written projects/pulse + last sync).
   The dashboard no longer DEPENDS on the scheduled brain for fresh calendar reads. */

const cfg = window.MAESTRO_CONFIG;
const sb = window.supabase.createClient(cfg.SUPABASE_URL, cfg.SUPABASE_ANON_KEY, {
  auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: true },
});
const $ = (id) => document.getElementById(id);

/* Where to send an unauthenticated visitor — the password gate lives in the onboarding app. */
function toSignIn() {
  location.href = "./index.html";
}

/* ── boot: auth gate ─────────────────────────────────────── */
(async () => {
  const { data } = await sb.auth.getSession();
  if (!data.session) return toSignIn();
  enterDashboard(data.session);
})();

sb.auth.onAuthStateChange((event, session) => {
  if (event === "SIGNED_OUT" || !session) toSignIn();
});

$("signout").onclick = async () => {
  await sb.auth.signOut();
  toSignIn();
};

/* ── render the stored status row (own row only) ─────────── */
function renderStatus(status) {
  const s = status || {};
  $("brief").textContent = s.brief || "Your dashboard is ready. Connect Google to bring your day to life.";

  const pulse = s.pulse || {};
  $("p-needs").textContent = pulse.needsYou ?? 0;
  $("p-motion").textContent = pulse.inMotion ?? 0;
  $("p-shipped").textContent = pulse.shipped ?? 0;

  const pipeline = Array.isArray(s.pipeline) ? s.pipeline : [];
  const ul = $("pipeline");
  ul.innerHTML = "";
  $("pipeline-empty").classList.toggle("hidden", pipeline.length > 0);
  for (const p of pipeline) {
    const li = document.createElement("li");
    const name = typeof p === "string" ? p : p.name || p.title || "Untitled";
    const sub = typeof p === "object" ? p.shortStatus || p.state || "" : "";
    li.innerHTML = `<div style="font-size:14px">${esc(name)}</div>` + (sub ? `<div class="ev"><div class="what"><div class="c">${esc(sub)}</div></div></div>` : "");
    ul.appendChild(li);
  }

  renderEvents(Array.isArray(s.events) ? s.events : []);
}

/* ── render calendar events grouped by day ───────────────── */
function renderEvents(events) {
  const box = $("calendar");
  const empty = $("cal-empty");
  box.innerHTML = "";
  if (!events.length) {
    box.classList.add("hidden");
    return;
  }
  box.classList.remove("hidden");
  empty.classList.add("hidden");

  const byDay = new Map();
  for (const e of events) {
    const d = e.start ? new Date(e.start) : null;
    const key = d ? d.toLocaleDateString(undefined, { weekday: "long", month: "short", day: "numeric" }) : "Undated";
    if (!byDay.has(key)) byDay.set(key, []);
    byDay.get(key).push(e);
  }
  for (const [day, evs] of byDay) {
    const h = document.createElement("div");
    h.className = "day-head";
    h.textContent = day;
    box.appendChild(h);
    const ul = document.createElement("ul");
    ul.className = "list";
    for (const e of evs) {
      const li = document.createElement("li");
      li.className = "ev";
      const when = e.allDay
        ? "all day"
        : e.start
        ? new Date(e.start).toLocaleTimeString(undefined, { hour: "numeric", minute: "2-digit" })
        : "";
      li.innerHTML =
        `<div class="when">${esc(when)}</div>` +
        `<div class="what"><div class="t">${esc(e.title || "(no title)")}</div>` +
        `<div class="c">${esc(e.calendar || "")}${e.location ? " · " + esc(e.location) : ""}</div></div>`;
      ul.appendChild(li);
    }
    box.appendChild(ul);
  }
}

function esc(s) {
  return String(s).replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));
}

/* ── on-demand live calendar sync ────────────────────────── */
async function liveSync({ silent } = {}) {
  const btn = $("sync-now");
  btn.disabled = true;
  const prev = btn.textContent;
  btn.innerHTML = '<span class="spin">↻</span> Syncing…';
  $("sync-state").textContent = "";
  try {
    const { data: session } = await sb.auth.getSession();
    const res = await fetch(`${cfg.SUPABASE_URL}/functions/v1/calendar-sync`, {
      method: "POST",
      headers: { apikey: cfg.SUPABASE_ANON_KEY, authorization: `Bearer ${session.session.access_token}` },
    });
    if (res.status === 409) {
      // Google not connected yet — not an error, just an empty-until-connected state.
      $("cal-live").textContent = "";
      showConnectPrompt();
      return;
    }
    if (!res.ok) throw new Error((await res.json().catch(() => ({}))).error || `sync failed (${res.status})`);
    const body = await res.json();
    $("cal-live").textContent = "· live";
    $("sync-state").textContent = "synced just now";
    $("brief").textContent = body.brief || $("brief").textContent;
    renderEvents(body.events || []);
  } catch (err) {
    if (!silent) $("sync-state").textContent = "sync failed — showing last saved";
    console.error("live sync:", err);
  } finally {
    btn.disabled = false;
    btn.textContent = prev;
  }
}
$("sync-now").onclick = () => liveSync({});

function showConnectPrompt() {
  const box = $("calendar");
  box.classList.remove("hidden");
  box.innerHTML =
    `<div class="empty">Connect Google to see your live calendar here.` +
    `<br /><a class="btn sm" style="display:inline-flex;margin-top:12px;max-width:240px" href="./index.html">Finish setup → Connect Google</a></div>`;
}

/* ── enter ───────────────────────────────────────────────── */
async function enterDashboard(session) {
  $("gate").classList.add("hidden");
  $("dash").classList.remove("hidden");
  $("acct").textContent = `Signed in as ${session.user.email} · your data, yours alone.`;

  // 1) Paint the stored row immediately (own row via RLS) so the page isn't blank.
  const { data: row } = await sb.from("maestro_dashboard").select("status").maybeSingle();
  renderStatus(row && row.status);
  if (row && row.status && row.status.meta && row.status.meta.lastSync) {
    $("sync-state").textContent = "last synced " + new Date(row.status.meta.lastSync).toLocaleString(undefined, { month: "short", day: "numeric", hour: "numeric", minute: "2-digit" });
  }

  // 2) Then fire a live calendar sync so the calendar reflects reality without waiting
  //    for the scheduled brain. Silent: if Google isn't connected we just show the prompt.
  liveSync({ silent: true });
}
