// Build a runnable copy of the REAL page: CDN imports swapped for local stubs, plus a hook that
// exposes the module's functions so a test can drive the actual code paths.
const fs = require("fs");
const path = require("path");
const html = fs.readFileSync(path.join(__dirname, "..", "index.html"), "utf8");
const OUT = __dirname;

let out = html
  .replace('import { createClient } from "https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm";',
           'import { createClient } from "./sb-stub.mjs";')
  .replace('<script src="https://cdn.tailwindcss.com"></script>', '<link rel="stylesheet" href="./tw.css">')
  .replace(/<script src="https:\/\/cdn\.jsdelivr\.net\/npm\/3d-force-graph[^>]*><\/script>/, '<script src="./fg-stub.js"></script>')
  .replace(/<link[^>]*fonts\.googleapis[^>]*>/g, "")
  .replace(/tailwind\.config\s*=/, "window.tailwind = window.tailwind || {}; tailwind.config =");

// expose the module's internals for the test driver
out = out.replace(/\n\(async \(\)=>\{\n  const isRecovery/,
  '\nwindow.__T = { setView, renderVault, vxOpenNode, vxIsPhone, brainSelect, brainOpenReader, brainCloseReader,' +
  ' brainFocus, brainClearFocus, vaultSetMobileTab, get BRAIN(){ return BRAIN; }, VAULT, STATE, loadBrainData, buildBrainGraph };\n' +
  'window.dispatchEvent(new Event("__thooks"));\n' +
  '\n(async ()=>{\n  const isRecovery');

fs.writeFileSync(path.join(OUT, "func.html"), out);

// ── Supabase stub: a chainable query builder over a small synthetic vault ──
fs.writeFileSync(path.join(OUT, "sb-stub.mjs"), `
const FILES = [
  { id:"1", path:"Projects/Tauri Job Search/docs/Writing Career Playbook.md", updated_at:"2026-08-13T10:00:00Z", content_size:800 },
  { id:"2", path:"Projects/Tauri Job Search/docs/Track A Income Routes.md",   updated_at:"2026-08-12T10:00:00Z", content_size:600 },
  { id:"3", path:"Projects/Tauri Job Search/Tauri Job Search.md",             updated_at:"2026-08-11T10:00:00Z", content_size:900 },
  { id:"4", path:"Projects/maestro/README.md",                                 updated_at:"2026-08-10T10:00:00Z", content_size:400 },
  { id:"5", path:"INDEX.md",                                                   updated_at:"2026-08-09T10:00:00Z", content_size:300 },
];
const q = (table) => {
  const o = {
    _sel:"", select(s){ this._sel=s||""; return this; },
    order(){ return this; }, range(){ return this; }, or(){ this._noise=true; return this; },
    eq(){ return this; }, in(){ return this; }, limit(){ return this; }, not(){ return this; },
    filter(){ return this; }, ilike(){ return this; }, like(){ return this; }, is(){ return this; }, neq(){ return this; },
    single(){ return Promise.resolve({ data:{ content:"# Writing Career Playbook\\n\\nThe book is a nonfiction memoir.\\n\\n" + "Body line.\\n\\n".repeat(60) }, error:null }); },
    maybeSingle(){ return this.single(); },
    then(res, rej){
      let data = [];
      if(table === "vault_files"){
        if(this._noise) data = [];                                   // no empty/noise notes
        else if(/content_size|path/.test(this._sel)) data = FILES;
        else if(this._sel.trim() === "id") data = [];
        else data = FILES;
      }
      return Promise.resolve({ data, error:null }).then(res, rej);
    },
  };
  return o;
};
export function createClient(){
  return {
    from: q,
    channel(){ return { on(){ return this; }, subscribe(){ return this; } }; },
    removeChannel(){},
    auth: {
      getSession(){ return Promise.resolve({ data:{ session:null } }); },
      onAuthStateChange(){ return { data:{ subscription:{ unsubscribe(){} } } }; },
      signOut(){ return Promise.resolve({}); },
    },
    functions: { invoke(){ return Promise.resolve({ data:null, error:null }); } },
  };
}
`);

// ── 3d-force-graph stub: chainable, records callbacks, counts camera moves ──
fs.writeFileSync(path.join(OUT, "fg-stub.js"), `
window.__FG = { cbs:{}, calls:{} };
window.ForceGraph3D = function(){
  return function(){
    const g = new Proxy(function(){}, {
      get(_t, k){
        if(k === "then" || typeof k === "symbol") return undefined;   // never look thenable to await
        return function(...args){
          window.__FG.calls[k] = (window.__FG.calls[k]||0) + 1;
          if(typeof args[0] === "function") window.__FG.cbs[k] = args[0];
          if(k === "graphData") return args.length ? g : { nodes:[], links:[] };   // setter chains, getter returns data
          if(k === "cameraPosition") return { x:0, y:0, z:120 };
          if(k === "controls") return { target:{x:0,y:0,z:0} };
          if(k === "d3Force") return { distance(){ return this; }, strength(){ return this; } };
          if(k === "graph2ScreenCoords") return { x:10, y:10 };
          if(k === "scene" || k === "renderer" || k === "postProcessingComposer") return { add(){}, addPass(){}, domElement:document.createElement("canvas") };
          return g;
        };
      },
    });
    return g;
  };
};
`);
console.log("func.html written");
