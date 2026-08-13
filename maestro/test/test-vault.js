const { chromium } = require(process.env.PLAYWRIGHT_PATH || "playwright");
const path = require("path");

const results = [];
const check = (name, pass, detail) => { results.push({ name, pass, detail }); };

(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage({ viewport: { width: 390, height: 844 }, deviceScaleFactor: 3, hasTouch: true, isMobile: true });
  const errors = [];
  page.on("console", m => { if (m.type() === "error") errors.push(m.text()); });
  page.on("pageerror", e => errors.push(e.message));
  await page.goto("file://" + path.join(__dirname, "harness.html"));

  // The app applies these on entering the Vault view (setView) — mirror that here.
  await page.evaluate(() => {
    document.documentElement.classList.add("vault-fixed");
    document.body.classList.add("vault-fixed");
  });
  await page.waitForTimeout(120);

  const box = sel => page.evaluate(s => { const e = document.querySelector(s); if (!e) return null; const r = e.getBoundingClientRect(); return { top: r.top, bottom: r.bottom, left: r.left, right: r.right, h: r.height, w: r.width, display: getComputedStyle(e).display }; }, sel);

  // ── 1. GRAPH MODE: the page itself must not scroll ──
  const vp = await page.evaluate(() => ({ h: innerHeight, w: innerWidth }));
  let m = await page.evaluate(() => ({ docScroll: document.documentElement.scrollHeight, bodyScroll: document.body.scrollHeight, inner: innerHeight }));
  check("graph: document does not overflow the viewport", m.docScroll <= m.inner + 1, JSON.stringify(m));

  await page.evaluate(() => window.scrollTo(0, 500));
  await page.waitForTimeout(60);
  let sy = await page.evaluate(() => window.scrollY);
  check("graph: page cannot be scrolled (scrollY stays 0)", sy === 0, "scrollY=" + sy);

  // ── 2. the graph box fills the space between the toggle and the bottom nav ──
  const wrap = await box("#brain-wrap");
  const nav = await box("#bnav");
  check("graph: canvas box is on-screen and unclipped", wrap && wrap.bottom <= vp.h + 1 && wrap.h > 400, JSON.stringify(wrap));
  check("graph: canvas box clears the bottom nav", wrap && nav && wrap.bottom <= nav.top + 1, "wrap.bottom=" + (wrap && wrap.bottom.toFixed(1)) + " nav.top=" + (nav && nav.top.toFixed(1)));
  const gap = nav.top - wrap.bottom;
  check("graph: no dead space above the nav (<40px)", gap >= 0 && gap < 40, "gap=" + gap.toFixed(1) + "px");

  // ── 3. LIST MODE: page still locked, list scrolls INSIDE itself ──
  await page.evaluate(() => document.getElementById("vault-root").dataset.mtab = "list");
  await page.waitForTimeout(80);
  m = await page.evaluate(() => ({ docScroll: document.documentElement.scrollHeight, inner: innerHeight }));
  check("list: document still does not overflow the viewport", m.docScroll <= m.inner + 1, JSON.stringify(m));
  const panel = await box("#vault-list-panel");
  check("list: panel fills to the bottom nav", panel && panel.bottom <= nav.top + 1 && panel.h > 500, JSON.stringify(panel));
  const inner = await page.evaluate(() => { const l = document.getElementById("vault-list"); l.scrollTop = 9999; return { scrollH: l.scrollHeight, clientH: l.clientHeight, scrolled: l.scrollTop }; });
  check("list: the file list scrolls inside itself", inner.scrollH > inner.clientH && inner.scrolled > 0, JSON.stringify(inner));
  sy = await page.evaluate(() => { window.scrollTo(0, 500); return window.scrollY; });
  check("list: scrolling the list does not scroll the page", sy === 0, "scrollY=" + sy);

  // ── 4. the fullscreen reader opens over LIST mode (it used to live inside the hidden graph pane) ──
  const readerParent = await page.evaluate(() => document.querySelector("#brain-reader").parentElement.id);
  check("reader: lives outside the graph pane", readerParent === "view-vault", "parent=#" + readerParent);
  await page.evaluate(() => {
    const r = document.getElementById("brain-reader");
    r.classList.remove("hidden"); r.style.opacity = "1";
    document.getElementById("brain-reader-title").textContent = "Writing Career Playbook";
    document.getElementById("brain-reader-body").innerHTML = "<p>x</p>".repeat(80);
  });
  await page.waitForTimeout(80);
  const rd = await box("#brain-reader");
  const card = await box("#brain-reader-card");
  check("reader: visible while the List tab is showing", rd && rd.display !== "none" && rd.w > 0, JSON.stringify(rd));
  check("reader: covers the full viewport", rd && rd.top <= 0.5 && rd.left <= 0.5 && rd.w >= vp.w - 0.5 && rd.h >= vp.h - 0.5, JSON.stringify(rd));
  check("reader: card fills the screen edge-to-edge on a phone", card && card.w >= vp.w - 0.5 && card.h >= vp.h - 0.5, JSON.stringify(card));
  const rbody = await page.evaluate(() => { const b = document.getElementById("brain-reader-body"); b.scrollTop = 400; return { scrollH: b.scrollHeight, clientH: b.clientHeight, scrolled: b.scrollTop }; });
  check("reader: note body scrolls inside the reader", rbody.scrollH > rbody.clientH && rbody.scrolled > 0, JSON.stringify(rbody));

  // the app applies brain-noscroll while the reader is open — mirror it, then check the note
  // actually paints over the header and the bottom nav.
  await page.evaluate(() => document.body.classList.add("brain-noscroll"));
  await page.waitForTimeout(60);
  const over = await page.evaluate(() => {
    const at = (x,y) => { const e=document.elementFromPoint(x,y); return e ? !!e.closest("#brain-reader") : false; };
    return { topStrip: at(195,30), bottomStrip: at(195,820), middle: at(195,400) };
  });
  check("reader: paints over the header and bottom nav", over.topStrip && over.bottomStrip && over.middle, JSON.stringify(over));

  await page.screenshot({ path: path.join(__dirname, "shot-reader-list.png") });

  // ── 5. desktop is untouched: normal page, both panes side by side ──
  await page.evaluate(() => { document.body.classList.remove("brain-noscroll"); const r = document.getElementById("brain-reader"); r.classList.add("hidden"); r.style.opacity = "0"; document.getElementById("vault-root").dataset.mtab = "graph"; });
  await page.setViewportSize({ width: 1280, height: 900 });
  await page.waitForTimeout(150);
  const dm = await page.evaluate(() => ({ docScroll: document.documentElement.scrollHeight, inner: innerHeight }));
  const dList = await box("#vault-list-panel"), dWrap = await box("#brain-wrap");
  check("desktop: still fits the viewport with no page scroll", dm.docScroll <= dm.inner + 1, JSON.stringify(dm));
  check("desktop: list + graph sit side by side, both full height", dList && dWrap && dList.right <= dWrap.left + 1 && Math.abs(dList.h - dWrap.h) < 2 && dWrap.h > 600, "list.h=" + dList.h.toFixed(0) + " wrap.h=" + dWrap.h.toFixed(0));

  await page.screenshot({ path: path.join(__dirname, "shot-desktop.png") });
  check("no console errors", errors.length === 0, errors.join(" | ") || "none");

  await browser.close();
  let bad = 0;
  for (const r of results) { if (!r.pass) bad++; console.log((r.pass ? "PASS  " : "FAIL  ") + r.name + "   [" + r.detail + "]"); }
  console.log("\n" + (results.length - bad) + "/" + results.length + " checks passed");
  process.exit(bad ? 1 : 0);
})();
