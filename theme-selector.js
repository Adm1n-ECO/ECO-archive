/* ============================================================
   FindMyTree.Online — Theme Selector
   js/theme-selector.js · FMTO · 2026-03-19
   ============================================================
   Injects the floating theme selector (bottom-right).
   Admin button floats below it when admin is logged in.
   Usage: include this script in every HTML page.
   The selector respects --z-theme (900) and --z-admin (800).
   ============================================================ */

(function () {
  'use strict';

  var THEMES = [
    {
      id:   'dark-100',
      name: 'Deep space',
      sub:  '100% dark · max contrast',
      bg:   '#070D14', bar: '#0D1820', dot: '#00E5CC', line: '#00E040'
    },
    {
      id:   'dark-75',
      name: 'Night mode',
      sub:  '75% dark · default',
      bg:   '#0D1A24', bar: '#152535', dot: '#00CFBA', line: '#00C838'
    },
    {
      id:   'dark-50',
      name: 'Dusk',
      sub:  '50% dark · softer',
      bg:   '#142030', bar: '#1E2E40', dot: '#00B8A6', line: '#00B030'
    },
    {
      id:   'dark-25',
      name: 'Twilight',
      sub:  '25% dark · accessible',
      bg:   '#1E3040', bar: '#283C50', dot: '#00A090', line: '#009828'
    }
  ];

  var DEFAULT_THEME = 'dark-100';
  var STORAGE_KEY   = 'fmto_theme';

  var panelOpen = false;

  /* ── Read saved theme ────────────────────────────────── */
  function getSavedTheme() {
    try {
      var t = localStorage.getItem(STORAGE_KEY);
      return THEMES.find(function (x) { return x.id === t; }) ? t : DEFAULT_THEME;
    } catch (e) {
      return DEFAULT_THEME;
    }
  }

  /* ── Apply theme to <html> ───────────────────────────── */
  function applyTheme(id) {
    document.documentElement.setAttribute('data-theme', id);
    document.body.setAttribute('data-theme', id);
    try { localStorage.setItem(STORAGE_KEY, id); } catch (e) {}
  }

  /* ── Build swatch HTML ───────────────────────────────── */
  function swatchHTML(t) {
    return [
      '<div class="theme-preview-swatch">',
      '  <div style="position:absolute;inset:0;background:' + t.bg + '"></div>',
      '  <div style="position:absolute;bottom:0;left:0;right:0;height:8px;background:' + t.bar + '"></div>',
      '  <div style="position:absolute;top:5px;right:5px;width:7px;height:7px;border-radius:50%;background:' + t.dot + '"></div>',
      '  <div style="position:absolute;top:12px;left:5px;right:12px;height:1.5px;border-radius:1px;background:' + t.line + ';opacity:.45"></div>',
      '</div>'
    ].join('');
  }

  /* ── Build selector HTML ─────────────────────────────── */
  function buildSelector(currentId) {
    var optionsHTML = THEMES.map(function (t) {
      var active = t.id === currentId ? ' active' : '';
      return [
        '<div class="theme-option' + active + '" data-theme-id="' + t.id + '">',
        '  ' + swatchHTML(t),
        '  <div class="theme-info">',
        '    <div class="theme-name">' + t.name + '</div>',
        '    <div class="theme-sub">' + t.sub + '</div>',
        '  </div>',
        '  <div class="theme-tick">&#10003;</div>',
        '</div>'
      ].join('');
    }).join('');

    return [
      '<div class="theme-selector" id="fmto-theme-selector">',
      '  <div class="theme-panel hidden" id="fmto-theme-panel">',
      '    <div class="theme-panel-title">Theme <span>&#xB7; CRUNOD family</span></div>',
      '    ' + optionsHTML,
      '  </div>',
      '  <button class="theme-toggle-btn" id="fmto-theme-btn" aria-label="Change theme" aria-expanded="false">&#9680;</button>',
      '</div>'
    ].join('');
  }

  /* ── Toggle panel ────────────────────────────────────── */
  function togglePanel() {
    panelOpen = !panelOpen;
    var panel = document.getElementById('fmto-theme-panel');
    var btn   = document.getElementById('fmto-theme-btn');
    if (panel) panel.classList.toggle('hidden', !panelOpen);
    if (btn) {
      btn.classList.toggle('open', panelOpen);
      btn.setAttribute('aria-expanded', panelOpen ? 'true' : 'false');
    }
  }

  /* ── Select a theme ──────────────────────────────────── */
  function selectTheme(id) {
    applyTheme(id);
    document.querySelectorAll('.theme-option').forEach(function (opt) {
      opt.classList.toggle('active', opt.getAttribute('data-theme-id') === id);
    });
    /* Close panel after selection */
    panelOpen = false;
    var panel = document.getElementById('fmto-theme-panel');
    var btn   = document.getElementById('fmto-theme-btn');
    if (panel) panel.classList.add('hidden');
    if (btn)   { btn.classList.remove('open'); btn.setAttribute('aria-expanded', 'false'); }
  }

  /* ── Admin button (shown when admin session active) ─── */
  function initAdminBtn() {
    var btn = document.querySelector('.admin-float-btn');
    if (!btn) return;

    /* Check admin session — looks for fmto_admin flag set by auth.js */
    var isAdmin = false;
    try {
      isAdmin = localStorage.getItem('fmto_is_admin') === 'true';
    } catch (e) {}

    if (isAdmin) {
      btn.classList.add('visible');
      /* Push theme selector up by admin button height + gap */
      var sel = document.getElementById('fmto-theme-selector');
      if (sel) sel.style.bottom = '72px';
    }
  }

  /* ── Init ────────────────────────────────────────────── */
  function init() {
    var saved = getSavedTheme();
    applyTheme(saved);

    /* Inject selector into body */
    var wrap = document.createElement('div');
    wrap.innerHTML = buildSelector(saved);
    document.body.appendChild(wrap.firstElementChild || wrap);

    /* Wire toggle button */
    document.addEventListener('click', function (e) {
      var btn = document.getElementById('fmto-theme-btn');
      if (btn && btn.contains(e.target)) {
        togglePanel();
        return;
      }
      /* Click outside closes panel */
      var sel = document.getElementById('fmto-theme-selector');
      if (panelOpen && sel && !sel.contains(e.target)) {
        panelOpen = false;
        var panel = document.getElementById('fmto-theme-panel');
        if (panel) panel.classList.add('hidden');
        if (btn) { btn.classList.remove('open'); btn.setAttribute('aria-expanded','false'); }
      }
    });

    /* Wire theme options */
    document.addEventListener('click', function (e) {
      var opt = e.target.closest('.theme-option[data-theme-id]');
      if (opt) selectTheme(opt.getAttribute('data-theme-id'));
    });

    /* Init admin button */
    initAdminBtn();
  }

  /* ── Boot ────────────────────────────────────────────── */
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  /* ── Public API (for auth.js to call) ────────────────── */
  window.FMTOTheme = {
    setAdminVisible: function (visible) {
      try { localStorage.setItem('fmto_is_admin', visible ? 'true' : 'false'); } catch (e) {}
      var btn = document.querySelector('.admin-float-btn');
      var sel = document.getElementById('fmto-theme-selector');
      if (btn) btn.classList.toggle('visible', visible);
      if (sel) sel.style.bottom = visible ? '72px' : '20px';
    },
    applyTheme: applyTheme
  };

})();
