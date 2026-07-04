/* =====================================================================
   Shared mobile drawer behaviour for all instruments.
   Turns #panel into a draggable bottom sheet on phones: injects a drag
   handle, toggles collapsed<->expanded on tap, and supports drag-to-snap.
   No-op on desktop (>600px). Pure DOM; no dependencies, no secrets.
   ===================================================================== */
(function(){
  var panel = document.getElementById('panel');
  if(!panel) return;
  var mq = window.matchMedia('(max-width:600px)');

  // inject the handle / peek header once
  var handle = document.getElementById('drawer-handle');
  if(!handle){
    handle = document.createElement('div');
    handle.id = 'drawer-handle';
    handle.innerHTML = '<div class="grip"></div><div class="dlabel"></div>';
    panel.insertBefore(handle, panel.firstChild);
  }
  var label = handle.querySelector('.dlabel');

  var collapsed = false;
  function render(){
    document.body.classList.toggle('drawer-collapsed', collapsed && mq.matches);
    if(label) label.innerHTML = collapsed ? 'CONTROLS &nbsp;<b>&#9650; DRAG UP</b>' : 'CONTROLS &nbsp;<b>&#9660;</b>';
  }
  function setCollapsed(v){ collapsed = v; render(); }

  // default: collapsed on phones (animation front-and-centre), open on desktop
  function applyForViewport(){ setCollapsed(mq.matches); }
  applyForViewport();
  (mq.addEventListener ? mq.addEventListener('change', applyForViewport) : mq.addListener(applyForViewport));

  // ---- interaction: tap toggles; vertical drag snaps ----
  var startY=0, dragging=false, moved=false, startCollapsed=false;
  function peekPx(){ var v=getComputedStyle(document.documentElement).getPropertyValue('--peek'); return parseFloat(v)||58; }

  handle.addEventListener('pointerdown', function(e){
    if(!mq.matches) return;
    dragging=true; moved=false; startY=e.clientY; startCollapsed=collapsed;
    panel.style.transition='none';
    try{ handle.setPointerCapture(e.pointerId); }catch(_){}
  });
  window.addEventListener('pointermove', function(e){
    if(!dragging) return;
    var dy=e.clientY-startY;
    if(Math.abs(dy)>5) moved=true;
    var h=panel.offsetHeight, peek=peekPx();
    var base = startCollapsed ? (h-peek) : 0;
    var ty = Math.max(0, Math.min(h-peek, base+dy));
    panel.style.transform='translateY('+ty+'px)';
  });
  window.addEventListener('pointerup', function(e){
    if(!dragging) return;
    dragging=false;
    panel.style.transition=''; panel.style.transform='';
    if(moved){
      var dy=e.clientY-startY, h=panel.offsetHeight;
      // dragging up (dy<0) opens; down (dy>0) closes; threshold ~18% of sheet
      if(dy < -h*0.18) setCollapsed(false);
      else if(dy > h*0.18) setCollapsed(true);
      else render(); // snap back to current state
    } else {
      setCollapsed(!collapsed); // tap = toggle
    }
  });
  // also allow a plain click (non-pointer environments)
  handle.addEventListener('click', function(){ if(!mq.matches) return; /* handled by pointerup when moved=false; guard double */ });

  // expose for programmatic verification
  window.__drawer = { open:function(){ setCollapsed(false); }, collapse:function(){ setCollapsed(true); }, state:function(){ return collapsed?'collapsed':'open'; } };
})();
