/* Maestro onboarding web app — the product signup/onboarding entry point.
   Flow: landing → create account → confirm email → sign in → guided checklist → dashboard.
   Also: forgot-password + reset-password (parity with the personal dashboard).
   No framework, no build step. Talks to: Supabase Auth, the maestro_* tables (via RLS),
   and the google-oauth / link-claim edge functions. */

const cfg = window.MAESTRO_CONFIG;
const configured = cfg.SUPABASE_URL.includes("YOUR_PROJECT_REF") === false;
const sb = window.supabase.createClient(cfg.SUPABASE_URL, cfg.SUPABASE_ANON_KEY, {
  auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: true },
});

// Capture the URL hash/query before supabase-js consumes any auth token in it.
const INITIAL_HASH = location.hash;
const INITIAL_SEARCH = location.search;

const $ = (id) => document.getElementById(id);

const VIEWS = ["landing-view", "auth-view", "confirm-view", "forgot-view", "reset-view", "app-view"];
let mode = "signup"; // auth-view mode: "signup" | "login"
let recovering = false; // true while handling a password-recovery link (don't bounce to app)
let pollTimer = null;

/* ── view switching ─────────────────────────────────────── */
function showView(name) {
  VIEWS.forEach((v) => $(v).classList.toggle("hidden", v !== name));
  if (name === "app-view") startPolling();
  else stopPolling();
  window.scrollTo({ top: 0 });
}

/* ── auth-view mode (signup vs login) ───────────────────── */
function setMode(next) {
  mode = next;
  const signup = mode === "signup";
  $("auth-title").textContent = signup ? "Create your account" : "Sign in";
  $("auth-tagline").textContent = signup
    ? "Start here. Create the account that connects Claude to Maestro."
    : "Welcome back. Sign in to pick up where you left off.";
  $("auth-submit").textContent = signup ? "Create account" : "Sign in";
  $("switch-text").textContent = signup ? "Already have an account?" : "New here?";
  $("switch-link").textContent = signup ? "Sign in" : "Create an account";
  $("password").autocomplete = signup ? "new-password" : "current-password";
  $("password").placeholder = signup ? "At least 6 characters" : "••••••••";
  $("forgot-link").classList.toggle("hidden", signup); // only offer reset on the login form
  authMsg("");
}
function authMsg(text, kind = "") {
  const el = $("auth-msg");
  el.textContent = text;
  el.className = "msg " + kind;
}
function setMsg(id, text, kind = "") {
  const el = $(id);
  el.textContent = text;
  el.className = "msg " + kind;
}

/* ── landing entry points ───────────────────────────────── */
$("cta-signup").onclick = () => {
  setMode("signup");
  showView("auth-view");
};
$("cta-login").onclick = () => {
  setMode("login");
  showView("auth-view");
};
$("auth-back").onclick = () => showView("landing-view");
$("switch-link").onclick = () => setMode(mode === "signup" ? "login" : "signup");

/* ── sign up / sign in ──────────────────────────────────── */
$("auth-form").onsubmit = async (e) => {
  e.preventDefault();
  if (!configured) return authMsg("App not configured yet — set SUPABASE_URL / anon key in config.js.", "err");
  const email = $("email").value.trim();
  const password = $("password").value;
  $("auth-submit").disabled = true;
  authMsg("Working…");
  try {
    if (mode === "signup") {
      const { data, error } = await sb.auth.signUp({
        email,
        password,
        options: { emailRedirectTo: appUrl() },
      });
      if (error) throw error;
      if (data.session) {
        // Email confirmation is disabled on this project — we're already signed in.
        return; // onAuthStateChange routes us into the checklist.
      }
      // Confirmation required: show the "check your email" screen.
      $("confirm-email").textContent = email;
      pendingConfirmEmail = email;
      setMsg("confirm-msg", "");
      showView("confirm-view");
    } else {
      const { error } = await sb.auth.signInWithPassword({ email, password });
      if (error) throw error;
      // onAuthStateChange routes us into the checklist.
    }
  } catch (err) {
    authMsg(friendlyAuthError(err), "err");
  } finally {
    $("auth-submit").disabled = false;
  }
};

function friendlyAuthError(err) {
  const m = (err && err.message) || "Something went wrong.";
  if (/email not confirmed/i.test(m)) return "Please confirm your email first — check your inbox for the link.";
  if (/invalid login credentials/i.test(m)) return "Email or password is incorrect.";
  if (/already registered/i.test(m)) return "That email already has an account — try signing in instead.";
  return m;
}

/* ── confirm-email screen ───────────────────────────────── */
let pendingConfirmEmail = "";
$("confirm-to-login").onclick = () => {
  setMode("login");
  if (pendingConfirmEmail) $("email").value = pendingConfirmEmail;
  showView("auth-view");
};
$("resend-confirm").onclick = async () => {
  if (!pendingConfirmEmail) return;
  $("resend-confirm").disabled = true;
  setMsg("confirm-msg", "Sending…");
  const { error } = await sb.auth.resend({
    type: "signup",
    email: pendingConfirmEmail,
    options: { emailRedirectTo: appUrl() },
  });
  $("resend-confirm").disabled = false;
  if (error) return setMsg("confirm-msg", error.message || "Couldn't resend — try again shortly.", "err");
  setMsg("confirm-msg", "Sent. Check your inbox (and spam).", "ok");
};

/* ── forgot password ────────────────────────────────────── */
$("forgot-link").onclick = () => {
  if ($("email").value.trim()) $("forgot-email").value = $("email").value.trim();
  setMsg("forgot-msg", "");
  showView("forgot-view");
};
$("forgot-back").onclick = () => {
  setMode("login");
  showView("auth-view");
};
$("forgot-form").onsubmit = async (e) => {
  e.preventDefault();
  const email = $("forgot-email").value.trim();
  $("forgot-submit").disabled = true;
  setMsg("forgot-msg", "Sending…");
  const { error } = await sb.auth.resetPasswordForEmail(email, { redirectTo: appUrl() });
  $("forgot-submit").disabled = false;
  if (error) return setMsg("forgot-msg", error.message || "Couldn't send the email.", "err");
  setMsg(
    "forgot-msg",
    `If an account exists for ${email}, a secure reset link is on its way. Check your inbox (and spam) — it can take a minute.`,
    "ok",
  );
};

/* ── reset password (arrived via recovery link) ─────────── */
$("reset-form").onsubmit = async (e) => {
  e.preventDefault();
  const pw = $("reset-pw").value;
  const pw2 = $("reset-pw2").value;
  if (pw.length < 6) return setMsg("reset-msg", "Password must be at least 6 characters.", "err");
  if (pw !== pw2) return setMsg("reset-msg", "Those passwords don't match.", "err");
  $("reset-submit").disabled = true;
  setMsg("reset-msg", "Updating…");
  const { error } = await sb.auth.updateUser({ password: pw });
  $("reset-submit").disabled = false;
  if (error) {
    return setMsg("reset-msg", error.message || "Couldn't update the password. The link may have expired — request a new one.", "err");
  }
  recovering = false;
  try { history.replaceState({}, "", location.pathname); } catch (_e) {}
  setMsg("reset-msg", "Password updated. Loading your account…", "ok");
  // Session is already active from the recovery link → go straight to the checklist.
  const { data } = await sb.auth.getSession();
  if (data.session) enterApp(data.session);
};

/* ── sign out ───────────────────────────────────────────── */
$("signout").onclick = async () => {
  await sb.auth.signOut();
  setMode("login");
  showView("landing-view");
};

/* ── checklist ──────────────────────────────────────────── */
const STEPS = [
  { key: "__account", el: "step-account" }, // always complete once signed in
  { key: "plugin_linked", el: "step-connector" }, // ticks when Claude connects via the connector (OAuth)
  { key: "dashboard_live", el: "step-dash" },
];

function enterApp(session) {
  $("account-email").textContent = session.user.email;
  showView("app-view");
  refreshChecklist();
}

async function refreshChecklist() {
  const { data } = await sb.from("maestro_onboarding").select("*").maybeSingle();
  const row = data || {};
  let done = 0;
  for (const s of STEPS) {
    const stepEl = $(s.el);
    if (!stepEl) continue;
    // The account step is implicitly complete once the user is signed in (they're in app-view).
    const complete = s.key === "__account" ? true : !!row[s.key];
    if (complete) done++;
    stepEl.classList.toggle("done", complete);
    stepEl.querySelector(".status-pill").textContent = complete ? "Done" : "Pending";
    const bullet = stepEl.querySelector(".bullet");
    bullet.textContent = complete ? "✓" : String(STEPS.indexOf(s) + 1);
  }
  $("progress-bar").style.width = `${(done / STEPS.length) * 100}%`;
  const allDone = done === STEPS.length;
  $("done-banner").classList.toggle("show", allDone);
  if (allDone) $("done-dash-link").href = cfg.DASHBOARD_URL;
}

function startPolling() {
  stopPolling();
  // Light poll so the UI ticks as Claude connects via the connector or Google consent finishes.
  pollTimer = setInterval(refreshChecklist, 4000);
}
function stopPolling() {
  if (pollTimer) clearInterval(pollTimer);
  pollTimer = null;
}
window.addEventListener("focus", () => $("app-view").classList.contains("hidden") || refreshChecklist());

/* ── Step 2: add the Maestro connector in Claude ────────── */
// Copy the connector URL the user pastes into Claude → Settings → Connectors.
const copyConnectorBtn = $("copy-connector");
if (copyConnectorBtn) {
  copyConnectorBtn.onclick = async () => {
    const url = $("connector-url").textContent.trim();
    try {
      await navigator.clipboard.writeText(url);
      copyConnectorBtn.textContent = "Copied ✓";
      setTimeout(() => (copyConnectorBtn.textContent = "Copy"), 1600);
    } catch (_e) {
      /* clipboard blocked — the URL stays selectable as a fallback */
    }
  };
}
// This step ticks ✓ automatically when Claude connects via the connector (sets plugin_linked).
// Offer a manual confirm too, so nobody is stranded if that signal lags.
const connectorDone = $("connector-done");
if (connectorDone) {
  connectorDone.onclick = async () => {
    connectorDone.textContent = "Saving…";
    const { data: session } = await sb.auth.getSession();
    if (session.session) {
      await sb
        .from("maestro_onboarding")
        .update({ plugin_linked: true })
        .eq("user_id", session.session.user.id);
    }
    await refreshChecklist();
  };
}

/* ── Step 2 (and 3): Google OAuth — one consent connects both ─ */
async function connectGoogle(btn) {
  btn.disabled = true;
  const original = btn.textContent;
  btn.innerHTML = '<span class="spin">↻</span> Redirecting…';
  setMsg("google-msg", "");
  try {
    const { data: session } = await sb.auth.getSession();
    const res = await fetch(`${cfg.SUPABASE_URL}/functions/v1/google-oauth/start`, {
      method: "POST",
      headers: {
        apikey: cfg.SUPABASE_ANON_KEY,
        authorization: `Bearer ${session.session.access_token}`,
      },
    });
    const body = await res.json();
    if (!res.ok || !body.url) throw new Error(body.error || "could not start Google connect");

    // Known gap: the hosted Web OAuth client may not be configured yet. If so, the consent
    // URL comes back with an empty client_id — bounce the user to a broken Google page would
    // be confusing, so surface a clear status instead.
    const clientId = new URL(body.url).searchParams.get("client_id");
    if (!clientId) {
      btn.disabled = false;
      btn.textContent = original;
      setMsg(
        "google-msg",
        "Google connect isn't wired up yet — the hosted Google Web OAuth client still needs to be set up by the Maestro team. Everything else is ready; this step will light up once it's configured.",
        "err",
      );
      return;
    }
    window.location.href = body.url; // → Google consent → callback → back here
  } catch (err) {
    btn.disabled = false;
    btn.textContent = original;
    setMsg("google-msg", "Couldn't start Google connect: " + err.message, "err");
  }
}
$("connect-google").onclick = () => connectGoogle($("connect-google"));

/* ── Step 4: dashboard ──────────────────────────────────── */
$("open-dashboard").onclick = async () => {
  const { data: session } = await sb.auth.getSession();
  await sb.from("maestro_onboarding").update({ dashboard_live: true }).eq("user_id", session.session.user.id);
  await refreshChecklist();
  window.open(cfg.DASHBOARD_URL, "_blank", "noopener");
};

/* ── helpers ────────────────────────────────────────────── */
function appUrl() {
  return location.origin + location.pathname; // redirect target for confirm + recovery links
}

/* ── boot ───────────────────────────────────────────────── */
setMode("signup");

// Surface the result of a Google consent round-trip.
const params = new URLSearchParams(INITIAL_SEARCH);
if (params.get("connected") === "google") {
  history.replaceState({}, "", location.pathname);
} else if (params.get("connected") === "error") {
  history.replaceState({}, "", location.pathname);
  // Will show once we're in the app view; queue it.
  setTimeout(() => setMsg("google-msg", "Google connection failed — please try again.", "err"), 400);
}

// Recovery links carry `type=recovery`; show the set-new-password screen and don't bounce to app.
const isRecovery =
  /(?:^|[#&?])type=recovery(?:&|$)/.test(INITIAL_HASH) || /(?:^|[#&?])type=recovery(?:&|$)/.test(INITIAL_SEARCH);
if (isRecovery) {
  recovering = true;
  setMsg("reset-msg", "");
  showView("reset-view");
}

sb.auth.onAuthStateChange((event, session) => {
  if (event === "PASSWORD_RECOVERY") {
    recovering = true;
    showView("reset-view");
    return;
  }
  if (recovering) return; // stay on the reset screen until the password is updated
  if (session) enterApp(session);
  else if ($("app-view").classList.contains("hidden") === false) showView("landing-view");
});

// Initial route (skip if a recovery link is being handled).
if (!isRecovery) {
  sb.auth.getSession().then(({ data }) => {
    if (data.session) enterApp(data.session);
    else showView("landing-view");
  });
}
