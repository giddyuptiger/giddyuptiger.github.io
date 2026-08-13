// Drives the REAL vault code paths in Chromium: open-from-list, no tab switch, no bottom sheet,
// X / back / swipe close, and background-tap zoom-out.
const { chromium } = require(process.env.PLAYWRIGHT_PATH || "playwright");
const path = require("path");

const results = [];
const check = (n, p, d) => results.push({ n, p, d });

(async () => {
  const browser = await chromium.launch();

  async function open(width, height) {
    const page = await browser.newPage({ viewport: { width, height }, hasTouch: true, isMobile: width < 640 });
    const errors = [];
    page.on("pageerror", e => errors.push(e.message));
    page.on("console", m => { if (m.type() === "error" && !/ERR_TUNNEL_CONNECTION_FAILED|ERR_(NAME|CONNECTION)|Failed to load resource/.test(m.text())) errors.push(m.text()); });
    await page.goto("http://127.0.0.1:8099/func.html");
    await page.waitForFunction(() => !!window.__T, null, { timeout: 15000 });
    await page.evaluate(() => { document.getElementById("app").classList.remove("hidden"); window.__T.setView("vault"); });
    await page.waitForFunction(() => window.__T.BRAIN && window.__T.BRAIN.byId && window.__T.BRAIN.byId["1"], null, { timeout: 15000 });
    await page.waitForTimeout(400);
    return { page, errors };
  }

  // ══ PHONE ══
  {
    const { page, errors } = await open(390, 844);

    // page lock is applied by setView
    const locked = await page.evaluate(() => document.body.classList.contains("vault-fixed") && document.documentElement.classList.contains("vault-fixed"));
    check("phone: entering Vault locks the page", locked, String(locked));

    // switch to the List tab, then tap a note in the list
    await page.evaluate(() => window.__T.vaultSetMobileTab("list"));
    await page.waitForTimeout(150);
    const rowSel = '#vault-list [data-brain-goto]';
    await page.waitForSelector(rowSel);
    await page.click(rowSel);
    await page.waitForTimeout(500);

    const st = await page.evaluate(() => ({
      mtab: window.__T.VAULT.mtab,
      rootTab: document.getElementById("vault-root").dataset.mtab,
      readerOpen: !document.getElementById("brain-reader").classList.contains("hidden"),
      sheetOpen: document.getElementById("brain-side").classList.contains("open"),
      title: document.getElementById("brain-reader-title").textContent,
      bodyLen: document.getElementById("brain-reader-body").innerHTML.length,
      noscroll: document.body.classList.contains("brain-noscroll"),
      structShown: !document.getElementById("brain-reader-struct").classList.contains("hidden"),
      structRows: document.querySelectorAll("#brain-reader-struct [data-brain-goto]").length,
    }));
    check("phone: tapping a list row opens the fullscreen reader", st.readerOpen, JSON.stringify(st));
    check("phone: it does NOT bounce you to the Graph tab", st.mtab === "list" && st.rootTab === "list", "mtab=" + st.mtab);
    check("phone: no bottom-sheet sub-window opens", st.sheetOpen === false, "sheetOpen=" + st.sheetOpen);
    check("phone: the note's content is in the reader", st.bodyLen > 200 && st.title.length > 0, st.title + " / " + st.bodyLen + " chars");
    check("phone: structure (parent/children/links) still reachable", st.structShown && st.structRows > 0, JSON.stringify({ shown: st.structShown, rows: st.structRows }));

    const rd = await page.evaluate(() => { const r = document.getElementById("brain-reader").getBoundingClientRect(); return { w: r.width, h: r.height, top: r.top, left: r.left }; });
    check("phone: reader is full size", rd.w === 390 && rd.h === 844 && rd.top === 0 && rd.left === 0, JSON.stringify(rd));

    // X closes it and returns you to the List tab you were on
    await page.click("[data-brain-reader-close]");
    await page.waitForTimeout(450);
    const afterX = await page.evaluate(() => ({
      readerOpen: !document.getElementById("brain-reader").classList.contains("hidden"),
      mtab: document.getElementById("vault-root").dataset.mtab,
      sheetOpen: document.getElementById("brain-side").classList.contains("open"),
      noscroll: document.body.classList.contains("brain-noscroll"),
    }));
    check("phone: X closes the reader back to the List tab", !afterX.readerOpen && afterX.mtab === "list" && !afterX.sheetOpen, JSON.stringify(afterX));

    // reopen, then SWIPE right to dismiss
    await page.click(rowSel);
    await page.waitForTimeout(400);
    await page.touchscreen.tap(200, 400).catch(() => {});
    await page.evaluate(() => {
      const el = document.getElementById("brain-reader-card");
      const t = (type, x, y) => { const tt = new Touch({ identifier: 1, target: el, clientX: x, clientY: y }); el.dispatchEvent(new TouchEvent(type, { touches: type === "touchend" ? [] : [tt], changedTouches: [tt], bubbles: true })); };
      t("touchstart", 40, 400); t("touchmove", 120, 405); t("touchmove", 240, 408); t("touchend", 240, 408);
    });
    await page.waitForTimeout(450);
    const afterSwipe = await page.evaluate(() => !document.getElementById("brain-reader").classList.contains("hidden"));
    check("phone: swiping right dismisses the reader", afterSwipe === false, "readerOpen=" + afterSwipe);

    // vertical drag must NOT dismiss (scrolling the note still works)
    await page.click(rowSel);
    await page.waitForTimeout(400);
    await page.evaluate(() => {
      const el = document.getElementById("brain-reader-card");
      const t = (type, x, y) => { const tt = new Touch({ identifier: 2, target: el, clientX: x, clientY: y }); el.dispatchEvent(new TouchEvent(type, { touches: type === "touchend" ? [] : [tt], changedTouches: [tt], bubbles: true })); };
      t("touchstart", 200, 600); t("touchmove", 208, 480); t("touchmove", 214, 300); t("touchend", 214, 300);
    });
    await page.waitForTimeout(300);
    const afterVertical = await page.evaluate(() => !document.getElementById("brain-reader").classList.contains("hidden"));
    check("phone: a vertical drag does NOT dismiss it", afterVertical === true, "readerOpen=" + afterVertical);

    // hardware/browser BACK closes it
    await page.goBack().catch(() => {});
    await page.waitForTimeout(400);
    const afterBack = await page.evaluate(() => !document.getElementById("brain-reader").classList.contains("hidden"));
    check("phone: browser/hardware back closes the reader", afterBack === false, "readerOpen=" + afterBack);

    // ── background tap zooms back out ──
    const zoom = await page.evaluate(() => {
      const before = window.__FG.calls.zoomToFit || 0;
      window.__T.BRAIN.focusId = "1";                    // pretend we're zoomed in on a node
      window.__FG.cbs.onBackgroundClick();
      const after = window.__FG.calls.zoomToFit || 0;
      const focusCleared = window.__T.BRAIN.focusId === null;
      // and a background tap with nothing focused must NOT yank the camera
      const before2 = window.__FG.calls.zoomToFit || 0;
      window.__FG.cbs.onBackgroundClick();
      return { fired: after - before, focusCleared, idleFired: (window.__FG.calls.zoomToFit || 0) - before2 };
    });
    check("phone: tapping empty space zooms back out", zoom.fired === 1 && zoom.focusCleared, JSON.stringify(zoom));
    check("phone: tapping empty space when NOT zoomed leaves the camera alone", zoom.idleFired === 0, JSON.stringify(zoom));

    check("phone: no page errors", errors.length === 0, errors.slice(0, 3).join(" | ") || "none");
    await page.close();
  }

  // ══ DESKTOP: unchanged three-pane behaviour ══
  {
    const { page, errors } = await open(1280, 900);
    await page.waitForSelector('#vault-list [data-brain-goto]');
    await page.click('#vault-list [data-brain-goto]');
    await page.waitForTimeout(500);
    const st = await page.evaluate(() => ({
      readerOpen: !document.getElementById("brain-reader").classList.contains("hidden"),
      sheetOpen: document.getElementById("brain-side").classList.contains("open"),
      panelHTML: document.getElementById("brain-scroll").innerHTML.length,
    }));
    check("desktop: still opens in the side panel, not the modal", st.sheetOpen && !st.readerOpen && st.panelHTML > 500, JSON.stringify(st));
    check("desktop: no page errors", errors.length === 0, errors.slice(0, 3).join(" | ") || "none");
    await page.close();
  }

  await browser.close();
  let bad = 0;
  for (const r of results) { if (!r.p) bad++; console.log((r.p ? "PASS  " : "FAIL  ") + r.n + "   [" + r.d + "]"); }
  console.log("\n" + (results.length - bad) + "/" + results.length + " checks passed");
  process.exit(bad ? 1 : 0);
})();
