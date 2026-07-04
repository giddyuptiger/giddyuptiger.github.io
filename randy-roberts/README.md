# Randy Roberts — Instruments (hosted gallery)

Static front-end gallery of five generative visual instruments in the style of Randy Roberts (@rndyrbrts). **No build step, no dependencies, no secrets, no network** — every file is a self-contained HTML page that runs by double-clicking or over any static server.

**Live:** https://giddyuptiger.github.io/randy-roberts/

This `site/` folder is the deploy source of truth. It is pushed verbatim to `randy-roberts/` in the `giddyuptiger.github.io` Pages repo by `../deploy.sh` (fresh /tmp clone, never git-writes on the Drive mount).

## Layout (mirrors the deploy URL structure)
```
site/
├── index.html                 → /randy-roberts/            (the gallery)
├── hyphal-codex/index.html    → /randy-roberts/hyphal-codex/     (Instrument 01)
├── hyphal-codex/tokens.json   → the design-token layer (System→Component→Reuse)
├── data-grid/index.html       → /randy-roberts/data-grid/        (Instrument 02)
├── pixel-sort/index.html      → /randy-roberts/pixel-sort/       (Instrument 03)
├── audio-fingerprint/index.html → /randy-roberts/audio-fingerprint/ (Instrument 04)
└── field-of-view/index.html   → /randy-roberts/field-of-view/    (Instrument 05)
```

## The instruments
1. **Hyphal Codex** — organic black metaball blob-networks with branching hyphal links on cream; autonomous growth + a paint brush. (Gooey = single-pass SVG `feColorMatrix` alpha threshold.)
2. **Data Grid** — animated value-noise field sampled into a green matrix heatmap; value → intensity + mono glyph, hot cells flare, scanline sweep.
3. **Pixel Sort** — threshold pixel-sorting + channel-split datamosh over a posterized magenta-on-black source; drop your own image (local FileReader, no upload).
4. **Audio Fingerprint** — Web Audio FFT (built-in evolving drone by default; opt-in mic/tone) mapped to a radial spoke+ring fingerprint with a fading trail.
5. **Field of View** — a Vision Pro spatial frame: frosted panels at depth with pointer parallax, a perspective horizon grid, and mini-widgets that nod to instruments 01/02/04 (the hub).

## Shared scaffold (System → Component → Reuse)
Every instrument shares the same skeleton — a `TOKENS` design-system object at the top, the same control-panel chrome, keyboard shortcuts, and a PNG export. Re-skin by editing tokens; spin a new instrument by copying a file and swapping the render body.

Verified in-browser (render + screenshot + export) 2026-07-04; live bundles confirmed serving HTTP 200 with the intended code and zero secrets.
