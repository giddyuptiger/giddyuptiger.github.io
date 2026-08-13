# Maestro app — Vault tab tests

Automated checks for `maestro/index.html`. They run the **real** page code in headless Chromium at a
phone viewport (390×844) and a desktop one (1280×900) — not a mock of it — so a regression in the
shipped file fails here.

Written 2026-08-13 alongside the "note opens full screen / the Vault screen never scrolls" change.
They were run before that change shipped; committing them so the next change to this file has
something to run, instead of the checks living and dying inside one session.

## Run

```bash
npm i -D playwright tailwindcss@3     # tailwind only for the layout suite (see below)
node maestro/test/build-harness.js && npx tailwindcss -c maestro/test/tailwind.config.js \
  -i maestro/test/tw.in.css -o maestro/test/tw.css --minify
node maestro/test/test-vault.js       # 18 layout checks

node maestro/test/build-func.js       # then serve this dir over http (ES modules need an origin)
npx http-server maestro/test -p 8099 -s &
node maestro/test/test-behavior.js    # 16 behaviour checks
```

`PLAYWRIGHT_PATH=/path/to/playwright` overrides the module location if it isn't a local dependency.

## What each suite does

**`build-harness.js` + `test-vault.js` — 18 layout checks.** Extracts the real `renderVault()` markup
and the page's own `<style>`, renders it inside the real app shell with a locally compiled build of
the page's Tailwind config (the Tailwind CDN can't be used in CI), then measures geometry:

- the document never exceeds the viewport and `scrollY` stays 0, in **both** graph and list mode
- the graph box fills the space above the bottom nav without overshooting it
- the file list scrolls *inside itself* and doing so doesn't move the page
- the fullscreen reader parents outside the graph pane, renders while the List tab is showing,
  covers the viewport exactly, and — via `elementFromPoint` — paints over the header and bottom nav
- desktop still fits with list and graph side by side at equal height

**`build-func.js` + `test-behavior.js` — 16 behaviour checks.** Serves a copy of the real page with
the Supabase import and `3d-force-graph` swapped for local stubs (CDNs are unreachable in CI) and the
module's functions exposed on `window.__T`, then drives them:

- tapping a list row opens the fullscreen reader, stays on the List tab, and opens no bottom sheet
- the note's content and its structure section are present; the reader measures the full viewport
- ×, browser back, and a synthesised rightward swipe each close it — a **vertical** drag does not
- a background tap fires exactly one `zoomToFit` when a node is focused, and none when nothing is
- desktop still opens the side panel and never the modal

## Notes

- The stubs (`sb-stub.mjs`, `fg-stub.js`) and build outputs (`harness.html`, `func.html`, `tw.css`,
  screenshots) are generated — they're gitignored, not committed.
- These cover the Vault tab only. The other ten views have no tests.
- Nothing runs these automatically yet; there is no CI on this repo beyond the Pages deploy, so a
  push to `main` goes live unchecked. Wiring these into a pre-deploy job is the obvious next step.
