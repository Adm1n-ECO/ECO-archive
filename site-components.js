/* ============================================================
   FindMyTree.Online — Site Components
   js/site-components.js
   FMTO · Injects nav, footer, dev banner, referrer-policy.
   Every HTML page must load this script.
   Reads data-nav, data-footer, data-devbanner from <body>.
   ============================================================ */

(function () {
  'use strict';

  /* ── Config ─────────────────────────────────────────────── */
  var SITE_NAME    = 'FindMyTree.Online';
  var SITE_SHORT   = 'FMTO';
  var LIVE_HOST    = 'findmytree.online';
  var DEV_HOST     = 'crunod.com';
  var IS_DEV       = window.location.hostname.indexOf(DEV_HOST) !== -1
                  || window.location.hostname === 'localhost'
                  || window.location.hostname === '127.0.0.1';
  var YEAR         = new Date().getFullYear();

  /* ── Referrer policy (inject into <head> on every page) ─── */
  function injectReferrerPolicy() {
    var meta = document.createElement('meta');
    meta.httpEquiv = 'Referrer-Policy';
    meta.content   = 'strict-origin-when-cross-origin';
    document.head.appendChild(meta);
  }

  /* ── Nav templates ──────────────────────────────────────── */
  var NAV_TEMPLATES = {

    main: function () {
      return [
        '<nav class="site-nav" id="site-nav" role="navigation" aria-label="Main navigation">',
        '  <div class="container">',
        '    <div class="nav-inner">',

        '      <!-- Logo -->',
        '      <a href="/index.html" class="nav-logo" aria-label="' + SITE_NAME + ' home">',
        '        <span class="nav-logo-mark">&#x1F333;</span>',
        '        <span class="nav-logo-text">FindMyTree<span class="nav-logo-dot">.Online</span></span>',
        '      </a>',

        '      <!-- Desktop links -->',
        '      <ul class="nav-links" role="list">',
        '        <li><a href="/features.html"  class="nav-link">Features</a></li>',
        '        <li><a href="/pricing.html"   class="nav-link">Pricing</a></li>',
        '        <li><a href="/about.html"     class="nav-link">About</a></li>',
        '        <li><a href="/blog/index.html" class="nav-link">Blog</a></li>',
        '        <li><a href="/support.html"   class="nav-link">Support</a></li>',
        '      </ul>',

        '      <!-- Auth actions -->',
        '      <div class="nav-actions">',
        '        <a href="/signin.html"  class="btn btn--ghost btn--sm nav-signin-link">Sign in</a>',
        '        <a href="/signup.html"  class="btn btn--primary btn--sm nav-signup-link">Get started</a>',
        '        <a href="/app/dashboard.html" class="btn btn--primary btn--sm nav-portal-link" style="display:none">My tree</a>',
        '      </div>',

        '      <!-- Mobile hamburger -->',
        '      <button class="nav-hamburger" id="nav-hamburger" aria-label="Open menu" aria-expanded="false" aria-controls="nav-mobile">',
        '        <span></span><span></span><span></span>',
        '      </button>',
        '    </div>',
        '  </div>',

        '  <!-- Mobile menu -->',
        '  <div class="nav-mobile" id="nav-mobile" role="dialog" aria-label="Mobile navigation" hidden>',
        '    <ul role="list">',
        '      <li><a href="/index.html"        class="nav-mobile-link">Home</a></li>',
        '      <li><a href="/features.html"     class="nav-mobile-link">Features</a></li>',
        '      <li><a href="/pricing.html"      class="nav-mobile-link">Pricing</a></li>',
        '      <li><a href="/about.html"        class="nav-mobile-link">About</a></li>',
        '      <li><a href="/blog/index.html"   class="nav-mobile-link">Blog</a></li>',
        '      <li><a href="/support.html"      class="nav-mobile-link">Support</a></li>',
        '      <li><a href="/signin.html"       class="nav-mobile-link nav-signin-link">Sign in</a></li>',
        '      <li><a href="/app/dashboard.html" class="nav-mobile-link nav-portal-link" style="display:none">My tree</a></li>',
        '      <li><a href="/signup.html"       class="nav-mobile-link nav-mobile-cta">Get started</a></li>',
        '    </ul>',
        '  </div>',
        '</nav>'
      ].join('\n');
    },

    app: function () {
      return [
        '<nav class="site-nav site-nav--app" id="site-nav" role="navigation" aria-label="App navigation">',
        '  <div class="container">',
        '    <div class="nav-inner">',
        '      <a href="/app/dashboard.html" class="nav-logo" aria-label="' + SITE_NAME + ' dashboard">',
        '        <span class="nav-logo-mark">&#x1F333;</span>',
        '        <span class="nav-logo-text">FindMyTree<span class="nav-logo-dot">.Online</span></span>',
        '      </a>',
        '      <ul class="nav-links" role="list">',
        '        <li><a href="/app/dashboard.html"   class="nav-link">Dashboard</a></li>',
        '        <li><a href="/app/tree.html"        class="nav-link">My tree</a></li>',
        '        <li><a href="/app/globe.html"       class="nav-link">Globe</a></li>',
        '        <li><a href="/app/connections.html" class="nav-link">Connections</a></li>',
        '        <li><a href="/app/events.html"      class="nav-link">Events</a></li>',
        '      </ul>',
        '      <div class="nav-actions">',
        '        <a href="/app/settings.html" class="btn btn--ghost btn--sm">Settings</a>',
        '        <button class="btn btn--ghost btn--sm" id="btn-signout">Sign out</button>',
        '      </div>',
        '      <button class="nav-hamburger" id="nav-hamburger" aria-label="Open menu" aria-expanded="false">',
        '        <span></span><span></span><span></span>',
        '      </button>',
        '    </div>',
        '  </div>',
        '  <div class="nav-mobile" id="nav-mobile" hidden>',
        '    <ul role="list">',
        '      <li><a href="/app/dashboard.html"   class="nav-mobile-link">Dashboard</a></li>',
        '      <li><a href="/app/tree.html"        class="nav-mobile-link">My tree</a></li>',
        '      <li><a href="/app/globe.html"       class="nav-mobile-link">Globe</a></li>',
        '      <li><a href="/app/connections.html" class="nav-mobile-link">Connections</a></li>',
        '      <li><a href="/app/events.html"      class="nav-mobile-link">Events</a></li>',
        '      <li><a href="/app/settings.html"    class="nav-mobile-link">Settings</a></li>',
        '      <li><button class="nav-mobile-link" id="btn-signout-mobile">Sign out</button></li>',
        '    </ul>',
        '  </div>',
        '</nav>'
      ].join('\n');
    },

    admin: function () {
      return [
        '<nav class="site-nav site-nav--admin" id="site-nav">',
        '  <div class="container">',
        '    <div class="nav-inner">',
        '      <a href="/admin.html" class="nav-logo">',
        '        <span class="nav-logo-mark">&#x2699;&#xFE0F;</span>',
        '        <span class="nav-logo-text">FMTO <span class="nav-logo-dot">Admin</span></span>',
        '      </a>',
        '      <ul class="nav-links" role="list">',
        '        <li><a href="/admin-feature-matrix.html" class="nav-link">Features</a></li>',
        '        <li><a href="/admin-blueprint.html"      class="nav-link">Blueprint</a></li>',
        '        <li><a href="/admin-dev-ops.html"        class="nav-link">DevOps</a></li>',
        '      </ul>',
        '      <div class="nav-actions">',
        '        <a href="/index.html" class="btn btn--ghost btn--sm">View site</a>',
        '        <button class="btn btn--ghost btn--sm" id="btn-signout">Sign out</button>',
        '      </div>',
        '    </div>',
        '  </div>',
        '</nav>'
      ].join('\n');
    },

    'admin-sub': function () {
      return [
        '<nav class="site-nav site-nav--admin" id="site-nav">',
        '  <div class="container">',
        '    <div class="nav-inner">',
        '      <a href="/admin.html" class="nav-logo">',
        '        <span class="nav-logo-mark">&#x2190;</span>',
        '        <span class="nav-logo-text">Back to <span class="nav-logo-dot">Admin</span></span>',
        '      </a>',
        '      <div class="nav-actions">',
        '        <a href="/index.html" class="btn btn--ghost btn--sm">View site</a>',
        '        <button class="btn btn--ghost btn--sm" id="btn-signout">Sign out</button>',
        '      </div>',
        '    </div>',
        '  </div>',
        '</nav>'
      ].join('\n');
    },

    minimal: function () {
      return [
        '<nav class="site-nav site-nav--minimal" id="site-nav">',
        '  <div class="container">',
        '    <div class="nav-inner">',
        '      <a href="/index.html" class="nav-logo">',
        '        <span class="nav-logo-mark">&#x1F333;</span>',
        '        <span class="nav-logo-text">FindMyTree<span class="nav-logo-dot">.Online</span></span>',
        '      </a>',
        '    </div>',
        '  </div>',
        '</nav>'
      ].join('\n');
    },

    none: function () { return ''; }
  };

  /* ── Footer template ────────────────────────────────────── */
  function buildFooter() {
    return [
      '<footer class="site-footer" role="contentinfo">',
      '  <div class="container">',
      '    <div class="footer-grid">',

      '      <!-- Brand column -->',
      '      <div class="footer-brand">',
      '        <a href="/index.html" class="footer-logo">',
      '          <span class="footer-logo-mark">&#x1F333;</span>',
      '          <span>FindMyTree<span class="footer-logo-dot">.Online</span></span>',
      '        </a>',
      '        <p class="footer-tagline">Your living family and friends network.<br>Across generations. Across continents.</p>',
      '      </div>',

      '      <!-- Product -->',
      '      <div class="footer-col">',
      '        <h4 class="footer-col-title">Product</h4>',
      '        <ul role="list">',
      '          <li><a href="/features.html">Features</a></li>',
      '          <li><a href="/pricing.html">Pricing</a></li>',
      '          <li><a href="/app/globe.html">Globe view</a></li>',
      '          <li><a href="/signup.html">Get started</a></li>',
      '        </ul>',
      '      </div>',

      '      <!-- Company -->',
      '      <div class="footer-col">',
      '        <h4 class="footer-col-title">Company</h4>',
      '        <ul role="list">',
      '          <li><a href="/about.html">About</a></li>',
      '          <li><a href="/blog/index.html">Blog</a></li>',
      '          <li><a href="/support.html">Support</a></li>',
      '          <li><a href="/contact.html">Contact</a></li>',
      '        </ul>',
      '      </div>',

      '      <!-- Legal -->',
      '      <div class="footer-col">',
      '        <h4 class="footer-col-title">Legal</h4>',
      '        <ul role="list">',
      '          <li><a href="/privacy.html">Privacy policy</a></li>',
      '          <li><a href="/terms.html">Terms of service</a></li>',
      '        </ul>',
      '      </div>',

      '    </div>',

      '    <div class="footer-bottom">',
      '      <p class="footer-copy">&copy; ' + YEAR + ' FindMyTree.Online. All rights reserved.</p>',
      '      <p class="footer-made">Made with family in mind.</p>',
      '    </div>',
      '  </div>',
      '</footer>'
    ].join('\n');
  }

  /* ── Nav CSS (injected once) ────────────────────────────── */
  function injectNavStyles() {
    if (document.getElementById('sc-nav-styles')) return;
    var s = document.createElement('style');
    s.id = 'sc-nav-styles';
    s.textContent = [
      '.site-nav{position:sticky;top:0;z-index:var(--z-nav);background:var(--color-nav-bg);border-bottom:1px solid var(--color-nav-border);height:var(--nav-height);}',
      '.site-nav .container{height:100%;}',
      '.nav-inner{display:flex;align-items:center;gap:var(--space-6);height:100%;}',
      '.nav-logo{display:flex;align-items:center;gap:var(--space-2);font-family:var(--font-display);font-size:var(--text-lg);color:var(--color-text);text-decoration:none;flex-shrink:0;}',
      '.nav-logo-mark{font-size:1.4rem;line-height:1;}',
      '.nav-logo-dot{color:var(--color-primary);}',
      '.nav-links{display:flex;align-items:center;gap:var(--space-1);list-style:none;margin:0;padding:0;flex:1;}',
      '.nav-link{padding:var(--space-2) var(--space-3);font-size:var(--text-sm);font-weight:var(--weight-medium);color:var(--color-nav-text-dim);border-radius:var(--radius-sm);transition:all var(--transition-fast);text-decoration:none;}',
      '.nav-link:hover,.nav-link.active{color:var(--color-nav-active);background:var(--color-primary-bg);}',
      '.nav-actions{display:flex;align-items:center;gap:var(--space-3);margin-left:auto;}',
      '.nav-hamburger{display:none;flex-direction:column;gap:5px;background:none;border:none;cursor:pointer;padding:var(--space-2);}',
      '.nav-hamburger span{display:block;width:22px;height:2px;background:var(--color-text);border-radius:2px;transition:all var(--transition-fast);}',
      '.nav-mobile{display:none;position:absolute;top:var(--nav-height);left:0;right:0;background:var(--color-nav-bg);border-bottom:1px solid var(--color-nav-border);padding:var(--space-4);z-index:var(--z-dropdown);}',
      '.nav-mobile[hidden]{display:none!important;}',
      '.nav-mobile ul{list-style:none;margin:0;padding:0;}',
      '.nav-mobile-link{display:block;padding:var(--space-3) var(--space-4);font-size:var(--text-base);color:var(--color-text);border-radius:var(--radius-sm);transition:background var(--transition-fast);text-decoration:none;width:100%;text-align:left;background:none;border:none;cursor:pointer;font-family:var(--font-body);}',
      '.nav-mobile-link:hover{background:var(--color-surface-2);}',
      '.nav-mobile-cta{color:var(--color-primary)!important;font-weight:var(--weight-medium);}',
      '.site-footer{background:var(--color-footer-bg);padding:var(--space-16) 0 var(--space-8);margin-top:var(--space-20);}',
      '.footer-grid{display:grid;grid-template-columns:2fr 1fr 1fr 1fr;gap:var(--space-12);margin-bottom:var(--space-12);}',
      '.footer-logo{display:flex;align-items:center;gap:var(--space-2);font-family:var(--font-display);font-size:var(--text-lg);color:var(--color-footer-text);text-decoration:none;margin-bottom:var(--space-4);}',
      '.footer-logo-mark{font-size:1.4rem;}',
      '.footer-logo-dot{color:var(--color-footer-link);}',
      '.footer-tagline{font-size:var(--text-sm);color:var(--color-footer-text-dim);line-height:var(--leading-loose);}',
      '.footer-col-title{font-family:var(--font-body);font-size:var(--text-xs);font-weight:var(--weight-semi);color:var(--color-footer-text);letter-spacing:var(--tracking-wider);text-transform:uppercase;margin-bottom:var(--space-4);}',
      '.footer-col ul{list-style:none;margin:0;padding:0;display:flex;flex-direction:column;gap:var(--space-3);}',
      '.footer-col a{font-size:var(--text-sm);color:var(--color-footer-text-dim);text-decoration:none;transition:color var(--transition-fast);}',
      '.footer-col a:hover{color:var(--color-footer-link);}',
      '.footer-bottom{display:flex;justify-content:space-between;align-items:center;padding-top:var(--space-8);border-top:1px solid var(--color-footer-border);}',
      '.footer-copy,.footer-made{font-size:var(--text-xs);color:var(--color-footer-text-dim);}',
      '@media(max-width:768px){.nav-links{display:none;}.nav-hamburger{display:flex;}.nav-mobile:not([hidden]){display:block;}.nav-actions .btn:not(.nav-portal-link){display:none;}.footer-grid{grid-template-columns:1fr 1fr;gap:var(--space-8);}.footer-brand{grid-column:1/-1;}.footer-bottom{flex-direction:column;gap:var(--space-2);text-align:center;}}'
    ].join('');
    document.head.appendChild(s);
  }

  /* ── Dev banner ─────────────────────────────────────────── */
  function injectDevBanner() {
    if (!IS_DEV) return;
    var body = document.body;
    if (body.getAttribute('data-devbanner') === 'false') return;
    var el = document.createElement('div');
    el.className = 'dev-banner';
    el.setAttribute('aria-hidden', 'true');
    el.textContent = SITE_SHORT + ' DEV — ' + window.location.hostname;
    document.body.appendChild(el);
  }

  /* ── Hamburger toggle ───────────────────────────────────── */
  function initHamburger() {
    var btn   = document.getElementById('nav-hamburger');
    var menu  = document.getElementById('nav-mobile');
    if (!btn || !menu) return;

    btn.addEventListener('click', function () {
      var open = menu.hasAttribute('hidden');
      if (open) {
        menu.removeAttribute('hidden');
        btn.setAttribute('aria-expanded', 'true');
      } else {
        menu.setAttribute('hidden', '');
        btn.setAttribute('aria-expanded', 'false');
      }
    });

    document.addEventListener('click', function (e) {
      if (!menu.hasAttribute('hidden') && !btn.contains(e.target) && !menu.contains(e.target)) {
        menu.setAttribute('hidden', '');
        btn.setAttribute('aria-expanded', 'false');
      }
    });
  }

  /* ── Active nav link highlight ──────────────────────────── */
  function highlightActiveNav() {
    var path  = window.location.pathname.replace(/\/$/, '') || '/index.html';
    var links = document.querySelectorAll('.nav-link, .nav-mobile-link');
    links.forEach(function (link) {
      var href = link.getAttribute('href') || '';
      if (href && path.indexOf(href.replace(/^\//, '').replace('.html', '')) !== -1 && href !== '/index.html') {
        link.classList.add('active');
      }
    });
  }

  /* ── Auth state (show/hide sign-in vs portal links) ──────── */
  function initAuthLinks() {
    var isLoggedIn = false;
    try {
      var stored = localStorage.getItem('sb-auth-token') || sessionStorage.getItem('sb-auth-token');
      if (stored) isLoggedIn = true;
    } catch (e) {}

    if (isLoggedIn) {
      document.querySelectorAll('.nav-signin-link').forEach(function (el) { el.style.display = 'none'; });
      document.querySelectorAll('.nav-signup-link').forEach(function (el) { el.style.display = 'none'; });
      document.querySelectorAll('.nav-portal-link').forEach(function (el) { el.style.display = ''; });
    }
  }

  /* ── Main init ──────────────────────────────────────────── */
  function init() {
    var body    = document.body;
    var navType = body.getAttribute('data-nav')    || 'none';
    var hasFooter = body.getAttribute('data-footer') !== 'false';

    injectReferrerPolicy();
    injectNavStyles();

    /* Inject nav */
    var navFn = NAV_TEMPLATES[navType] || NAV_TEMPLATES['none'];
    var navHTML = navFn();
    if (navHTML) {
      var navEl = document.createElement('header');
      navEl.innerHTML = navHTML;
      body.insertBefore(navEl.firstElementChild || navEl, body.firstChild);
    }

    /* Inject footer */
    if (hasFooter && (navType === 'main')) {
      var footerEl = document.createElement('div');
      footerEl.innerHTML = buildFooter();
      body.appendChild(footerEl.firstElementChild || footerEl);
    }

    injectDevBanner();

    /* Wait for DOM settle then run interactions */
    requestAnimationFrame(function () {
      initHamburger();
      highlightActiveNav();
      initAuthLinks();
    });
  }

  /* ── Boot ───────────────────────────────────────────────── */
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

})();
