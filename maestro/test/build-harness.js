// Build a standalone harness page from the REAL maestro/index.html:
//   · the real <style> block (all the .vault-fixed / #brain-wrap / reader rules)
//   · the real app shell (header + <main> + bottom nav)
//   · the real renderVault() markup string, evaluated with stub data
// Tailwind is compiled locally (the CDN is blocked here) using the page's own tailwind.config.
const fs = require("fs");
const path = require("path");
const SRC = path.join(__dirname, "..", "index.html");
const OUT = __dirname;
const html = fs.readFileSync(SRC, "utf8");

// ── 1. the page's own <style> block ──
const styleBlocks = [...html.matchAll(/<style>([\s\S]*?)<\/style>/g)].map(m => m[1]);

// ── 2. the app shell: <header>…</header> and the <main>/<nav> skeleton ──
const shell = html.slice(html.indexOf('<div id="app"'), html.indexOf("</nav>", html.indexOf('id="bnav"')) + 6);

// ── 3. the real renderVault() template, evaluated with stubs ──
const script = [...html.matchAll(/<script type="module">([\s\S]*?)<\/script>/g)][0][1];
const fnAt = script.indexOf("function renderVault(){");
const start = script.indexOf("v.innerHTML=", fnAt);
const end = script.indexOf("vaultSetMobileTab(VAULT.mtab);", start);
let expr = script.slice(start + "v.innerHTML=".length, end);
expr = expr.slice(0, expr.lastIndexOf(";"));

const esc = s => String(s == null ? "" : s).replace(/[&<>"']/g, c => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));
// A realistic tree: enough rows that the list MUST scroll inside itself.
const row = (n, pad) => '<button data-brain-goto="n' + n + '" class="pressable w-full flex items-center gap-2 pr-2 py-1 rounded-lg text-left hover:bg-surface-container-high/50" style="padding-left:' + pad + 'px"><span class="w-1.5 h-1.5 rounded-full shrink-0" style="background:#C5E45C"></span><span class="text-[12.5px] text-on-surface/90 truncate flex-1">Note number ' + n + '</span></button>';
const vaultListHTML = () => Array.from({ length: 220 }, (_, i) => row(i, 8 + (i % 4) * 13)).join("");

const built = new Function(
  "esc", "VAULT", "vaultCountHTML", "vaultListHTML", "vxViewsHTML", "vxLegendHTML",
  "return (" + expr + ")"
)(esc, { mtab: "graph", q: "" }, () => "743 files", vaultListHTML,
  () => '<button class="vx-view">Overview</button>', () => '<div class="vx-legend-row">legend</div>');

if (!/id="brain-reader"/.test(built)) throw new Error("harness: reader markup missing from renderVault output");

const page = `<!doctype html><html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<link rel="stylesheet" href="./tw.css">
${styleBlocks.map(s => "<style>" + s + "</style>").join("\n")}
</head><body class="bg-background text-on-surface relative">
${shell.replace('<div id="app" class="hidden">', '<div id="app">')
       .replace('<section id="view-vault" class="view"></section>', '<section id="view-vault" class="view active">' + built + "</section>")}
</div></body></html>`;

fs.writeFileSync(path.join(OUT, "harness.html"), page);

// ── 4. Tailwind: same config the page feeds the CDN build ──
const cfg = html.match(/tailwind\.config\s*=\s*(\{[\s\S]*?\});\s*<\/script>/);
fs.writeFileSync(path.join(OUT, "tailwind.config.js"),
  "module.exports = Object.assign({content:['./harness.html']}, " + cfg[1] + ");");
fs.writeFileSync(path.join(OUT, "tw.in.css"), "@tailwind base;@tailwind components;@tailwind utilities;");
console.log("harness.html written:", page.length, "bytes");
