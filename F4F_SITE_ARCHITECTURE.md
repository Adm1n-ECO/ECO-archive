# Fund4Founders — Site Architecture
Last updated: 2026-03-17 (Session 42 complete)

## Standards
Every HTML page must:
1. Load `js/site-components.js` (injects nav, footer, theme pill, referrer-policy meta automatically)
2. Have `<body>` tag with: `data-nav`, `data-footer`, `data-devbanner`
3. Theme pill (bottom-right) auto-injected by `theme-switcher.js` via site-components
4. Nav + footer injected by site-components based on `data-nav` value

### SEO Standards (added Session 42)
Every **public** HTML page must also have:
- `<title>` — unique, 50–60 chars, keyword-rich
- `<meta name="description">` — unique, 150–160 chars, includes value prop + CTA
- `<link rel="canonical" href="https://fund4founders.com/PAGE.html">`
- `<meta name="referrer">` — injected automatically by site-components.js (no manual tag needed)
- All `<img>` tags must have `loading="lazy"`

## Base Admin Requirements
These tools are required infrastructure for every F4F deployment and must be present and functional before going live.

| Tool | Page | SQL Required | Purpose |
|------|------|-------------|---------|
| **Feature Matrix** | `admin-feature-matrix.html` | — (JS only) | Full roadmap — 259 items |
| **Feature Parking Lot** | `admin-parking-lot.html` | SQL 106 — `parking_lot` | Capture proposed ideas before roadmap |
| **CRM Tracker** | `admin-crm.html` | SQL 107 — `crm_contacts` + `crm_interactions` | External prospect/outreach tracking |
| **Site Blueprint** | `admin-blueprint.html` | SQL 92 — `dev_lessons` | Architecture reference, lessons learned |
| **Dev Ops Monitor** | `admin-dev-ops.html` | — | Uptime, SSL, DNS, Edge Function health |
| **Site Audit Script** | `scripts/audit-site.py` | — | Run after every deploy — 0 FAIL required |
| **Testing Admin** | `testing-admin.html` | SQL 13 + 111 | QA rounds, tester management, results |

### Post-Deploy Checklist
```bash
python3 scripts/audit-site.py --fast    # must show 0 FAIL
node tests/qa_round2.js                 # must show 100% (378/378)
```

## data-nav values
| Value | Nav injected | Footer | Use case |
|-------|-------------|--------|----------|
| `main` | Full marketing nav + logo | ✅ if data-footer=true | Public marketing pages |
| `portal` | Portal nav + notifications | ❌ | Logged-in member portals |
| `admin` | Admin nav | ❌ | Admin.html only |
| `admin-sub` | Admin nav → Back to Admin | ❌ | All admin sub-pages |
| `minimal` | Logo + back link only | ❌ | Signin, auth, utility pages |
| `none` | Nothing injected | ❌ | Special standalone pages |

## Portal System (modal-tab architecture)
All 6 portals use `js/portal-tabs.js` with `modalMode: true`.

| Portal | File | DB Table | Tabs | dashboardFrom |
|--------|------|----------|------|---------------|
| Founder | `portal-idea-generator.html` | `roles_idea_generator` | 9 | 7 |
| Investor | `portal-investor.html` | `roles_investor` | 3 | 2 |
| Consultant | `portal-consultant.html` | `roles_consultant` | 3 | 2 |
| Employee | `portal-employee.html` | `roles_employee` | 3 | 2 |
| Beta Customer | `portal-beta.html` + `portal-beta-customer.html` | `roles_adopter` | 3 | 2 |
| Strategic Partner | `portal-partner.html` + `portal-strategic-partner.html` | `roles_partner` | 3 | 2 |

**Auth routing:** `portal-beta.html` and `portal-partner.html` are the live URLs auth.js routes to.

### portal-tabs.js Critical Rules
- `_cur = idx` MUST be set at the TOP of `_switchTo()` before any UI helpers
- `_switching` guard: add safety reset at top of `goTo()` to prevent stuck state
- `F4FTabs._runMatch()` wraps saveProfile() with visual feedback states
- `dashboardFrom` index: tabs at or above this index don't count toward form completion dots

## Matching Engine
| File | Purpose |
|------|---------|
| `js/matching-v4.js` | Client-side engine — triggered on portal Save & Match |
| `js/auto-match.js` | Auto-trigger on profile save (re-runs matching silently) |
| `supabase/functions/auto-match-cron/index.ts` | **NEW S42** — full engine in Deno, runs every 60 min via pg_cron |

### Auto-Match Cron (Session 42)
- **Schedule**: every 60 min (`0 * * * *`) via pg_cron (SQL 115)
- **Optimisation**: only processes founders whose `updated_at` > `platform_config.last_cron_run`
- **Force re-score**: POST with `{ "force": true }`
- **Status check**: `SELECT key, value FROM platform_config WHERE key LIKE 'last%'`
- **Design**: zero user-facing output — fully silent background process

## SEO Infrastructure (Session 42)
| File | Purpose |
|------|---------|
| `sitemap.xml` | 42 correct URLs, `<lastmod>`, priorities, all stale URLs removed |
| `robots.txt` | Disallows admin/portal/testing/auth/temp pages from all crawlers |
| `llms.txt` | AI crawler identity file — ChatGPT, Gemini, Perplexity, Claude |
| `js/site-components.js` `injectReferrerPolicy()` | Adds referrer-policy meta to every page (+5 Observatory) |
| `index.html` JSON-LD | `Organization` schema for Google Knowledge Graph |

### Freshness Loop
`platform_config.last_member_activity` updated by `auto-match-cron` every run.
Feeds sitemap `<lastmod>` for dynamic pages (ecosystem-map, market-intelligence, founder-stats).

## Phantom Table Map (never use these)
| Wrong | Correct |
|-------|---------|
| `applications` | `signup_applications` |
| `matches` | `match_results` |
| `superusers` | `admin_superusers` |
| `roles_beta` | `roles_adopter` |
| `conversations` | *(does not exist)* |
| `investment_focus` | `investment_thesis` |
| `check_size` | `check_size_min` |
| `skills` | `primary_skills` |

## Schema Column Names (confirmed correct)
- `match_results`: `email_a`, `email_b` (not `founder_email`, `investor_email`)
- `roles_idea_generator`: `startup_sector` (not `sector`)
- `roles_investor`: `investment_thesis`, `check_size_min`
- All portals: `opt_in_a`, `opt_in_b` (not `ig_opted_in`, `vc_opted_in`)
- `platform_config`: `key`, `value`, `updated_at` (simple key-value store)

## SQL Migration Index
Next SQL number: **120**

| Range | Purpose |
|-------|---------|
| 1–13 | Core tables, testing system |
| 40–83 | Testing scripts, portal fixes |
| 92 | dev_lessons table |
| 94–95 | marketing_contacts, outreach |
| 105–109 | Dev lessons batches |
| 110 | QA Round 2 reseed (13 accounts) |
| 111 | qa_round column + Round 2 test scripts |
| 111b | Claude automated test history (379 results) |
| 112 | Cleanup old Round 1 test accounts |
| 113 | Dev lessons: Session 41 |
| 114 | 29 simulated members (all 6 roles) + null lat/lng fix |
| 115 | platform_config table + pg_cron 60-min auto-match schedule |
| 116 | Dev lessons: Session 42 (portal bugs, SEO, security, storageKey collision) |
| 117 | Full 180-record test data refresh (30 per role, 10 sector clusters, engineered match scores) |
| 118 | Matching data fix: breakdown_json column, RLS write policies, lat/lng for 5 role tables, 846 match pairs seeded, get_ecosystem_locations() updated |
| 119 | Superuser SELECT policy for match_results (Signal Density showed 0 pairs without it) |

## Edge Functions
All deployed with JWT verification **OFF**.

| Function | Purpose |
|----------|---------|
| `ai-help-chat` | AI chat for member help |
| `auto-match-cron` | **NEW S42** — background matching engine, 60-min pg_cron |
| `bp-email` | Blue Hub event emails |
| `delete-own-account` | Member self-deletion |
| `geocode-location` | ZIP → lat/lng |
| `notify-message` | In-platform message notifications |
| `pitch-outline` | AI pitch outline generator |
| `readiness-score` | Blue Hub readiness scoring |
| `send-test-invite` | QA tester invitations |
| `stripe-webhook` | Stripe payment events |
| `welcome-email` | Approval welcome email |
| `weekly-digest` | Weekly member digest |
| `zoho-sign-nda` | NDA signing (awaiting Zoho OAuth secrets) |

## Critical Architecture Rules (enforce always)
1. **CSS**: always use CSS variables — never inline hex colors
2. **Table names**: see Phantom Table Map above
3. **Edge functions**: all deployed with JWT verification **OFF**
4. **RLS timing**: fetch `first_name` + `role` BEFORE updating status — RLS blocks reads after status changes
5. **Supabase JS**: never `.in()` with null values — use `.or('status.eq.pending,status.is.null')`
6. **Apostrophes**: unescaped `'` in single-quoted JS strings cause SyntaxErrors — use array join pattern
7. **Script tags in JS strings**: `</script>` inside ANY JS string terminates the outer script block — escape as `<\/script>`
8. **Literal newlines**: never put a real `\n` character inside a single-quoted JS string
9. **Duplicate IDs in ITEMS arrays**: cause blank pages silently
10. **`_cur` ordering**: in portal-tabs.js, `_cur = idx` must be set BEFORE calling any UI update functions
11. **CREATE POLICY**: PostgreSQL has no `IF NOT EXISTS` for policies — use `DROP POLICY IF EXISTS` then `CREATE POLICY`
12. **Hosting**: Network Solutions has no server-sent header config — do NOT create new sites here. Use Cloudflare Pages or Vercel for all future projects (LookMeUp, FieldNode)
13. **storageKey uniqueness**: Every portal HTML file MUST have a unique `storageKey` in its `F4FTabs.init()` call. Duplicate keys cause portals to open on each other's last-visited tab. Current keys: `ig`, `investor`, `consultant`, `employee`, `sp`, `sp2`, `bc`, `bc2`
14. **Tab dot restoration**: Every `loadProfile()` that uses portal-tabs MUST restore tab completion dots from DB data using `F4FTabs.markSaved(i)` — never rely on sessionStorage alone (cleared on logout)
15. **Checklist refresh after save**: Every `saveProfile()` MUST call `initProfileChecklist(USER_ROLE)` after `F4FTabs.markSaved()` so strikethrough items update immediately

## Canonical CSP (copy this exactly for every new page)
```html
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://cdnjs.cloudflare.com https://js.stripe.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; font-src 'self' https://fonts.gstatic.com; img-src 'self' data: https:; connect-src 'self' https://*.supabase.co wss://*.supabase.co https://api.resend.com https://api.stripe.com https://api.zippopotam.us https://nominatim.openstreetmap.org; object-src 'none'; frame-ancestors 'none';">
<meta http-equiv="Referrer-Policy" content="strict-origin-when-cross-origin">
```
Never invent a new CSP variant. Copy this block exactly.

## Recurring Bug Checklist (check before every commit)
| # | Bug | Rule |
|---|-----|------|
| 1 | `</script>` inside JS string | Escape as `<\/script>` always |
| 2 | Literal `\n` in single-quoted string | Use `\n` or template literal |
| 3 | Extra comma in ITEMS array | Add `r &&` guard to `.find()` callbacks |
| 4 | Single quote in single-quoted string | Use `\x27` in onclick inside JS strings |
| 5 | Multiple GoTrueClient instances | Never call `createClient()` outside auth.js |
| 6 | `href="#"` placeholder | Always set real fallback URL synchronously first |
| 7 | `_switching` stuck in portal-tabs | Add safety reset at top of `goTo()` |
| 8 | `_cur` set after UI updates | Move `_cur = idx` to top of `_switchTo()` |
| 9 | `CREATE POLICY IF NOT EXISTS` | Not valid PostgreSQL — use DROP+CREATE pattern |
| 10 | New portal file missing unique storageKey | Check against full key list: ig, investor, consultant, employee, sp, sp2, bc, bc2 |
| 11 | loadProfile() doesn't restore tab dots | Add fieldChecks block calling `F4FTabs.markSaved(i)` at end of loadProfile |
| 12 | saveProfile() doesn't refresh checklist | Add `initProfileChecklist(USER_ROLE)` after `F4FTabs.markSaved()` |
| 13 | New portal card with hardcoded rgba(8,14,28) | Replace with `var(--surface-2)` — always test in light theme before commit |
| 14 | New CSP on new page differs from canonical | Copy canonical CSP block from SITE_ARCHITECTURE.md exactly — never invent a variant |
| 15 | DROP FUNCTION missing before return-type change | `CREATE OR REPLACE FUNCTION` cannot change return columns — always `DROP FUNCTION IF EXISTS` first |
| 16 | Superuser RLS covers write but not read | Write (INSERT/DELETE/UPDATE) and SELECT are separate policies — add both when granting superuser access |
| 17 | Export duplicate worksheet name crash | Use `safeAppendSheet()` guard — never two `book_append_sheet` calls with same name string |

## Chip Picker Conversion Checklist
When converting a field from `<select>` to chip picker:
1. Remove the entire `<select>...</select>` block including all `<option>` children
2. Add `<div class="multi-wrap">` with `<div class="multi-item" data-name="..." data-value="...">` children
3. After conversion: grep for orphaned `<option>` tags outside `<select>` blocks
4. Verify `data-name` appears only N times (N = number of options, not 2N)
5. Confirm no `<select <div` pattern on any line

## Testing Rounds
| Round | Status | Key result |
|-------|--------|------------|
| Round 1 | ✅ Complete (Mar 2026) | Closed, closure email sent |
| Round 2 | ✅ Complete (Mar 2026) | 379/379 Claude automated tests passed |
| Round 3 | 🔵 Active | Staging QA: data seed, matching, Blue Hub |

## Page Inventory

### Public Marketing
| File | nav | footer | SC | SEO Complete |
|------|-----|--------|-----|-------------|
| `company-about.html` | `main` | ✅ | ✅ | ✅ |
| `company-blog.html` | `main` | ✅ | ✅ | ✅ |
| `company-contact.html` | `main` | ✅ | ✅ | ✅ |
| `company-faq.html` | `main` | ✅ | ✅ | ✅ |
| `company-manifesto.html` | `main` | ✅ | ✅ | ✅ |
| `company-why-join.html` | `main` | ✅ | ✅ | ✅ |
| `ecosystem-map.html` | `main` | ✅ | ✅ | ✅ |
| `founder-stats.html` | `main` | ✅ | ✅ | ✅ |
| `how-it-works.html` | `main` | ✅ | ✅ | ✅ |
| `index.html` | `main` | ✅ | ✅ | ✅ + JSON-LD |
| `market-intelligence.html` | `main` | ✅ | ✅ | ✅ |
| `matching-dimensions*.html` | `main` | ✅ | ✅ | ✅ |
| `recruit.html` | `main` | ✅ | ✅ | ✅ |
| `roles.html` | `main` | ✅ | ✅ | ✅ |
| `showcase-*.html` | `main` | ✅ | ✅ | partial |
| `pricing.html` | `main` | ✅ | ✅ | partial |

### Join / Signup Flows
| File | nav | footer | SC | SEO Complete |
|------|-----|--------|-----|-------------|
| `join-idea-generator.html` | `main` | ✅ | ✅ | ✅ |
| `join-investor.html` | `main` | ✅ | ✅ | ✅ |
| `join-consultant.html` | `main` | ✅ | ✅ | ✅ |
| `join-employee.html` | `main` | ✅ | ✅ | ✅ |
| `join-beta-customer.html` | `main` | ✅ | ✅ | ✅ |
| `join-strategic-partner.html` | `main` | ✅ | ✅ | ✅ |
| `join-directory.html` | `main` | ✅ | ✅ | ✅ |

### Portal (Logged-in)
| File | nav | footer | SC |
|------|-----|--------|-----|
| `data-room.html` | `portal` | ❌ | ✅ |
| `messages.html` | `portal` | ❌ | ✅ |
| `pitch-deck-view.html` | `portal` | ❌ | ✅ |
| `pitch-deck.html` | `portal` | ❌ | ✅ |
| `portal-beta.html` | `portal` | ❌ | ✅ |
| `portal-consultant.html` | `portal` | ❌ | ✅ |
| `portal-employee.html` | `portal` | ❌ | ✅ |
| `portal-idea-generator.html` | `portal` | ❌ | ✅ |
| `portal-investor.html` | `portal` | ❌ | ✅ |
| `portal-matches.html` | `portal` | ❌ | ✅ |
| `portal-partner.html` | `portal` | ❌ | ✅ |

### Admin
| File | nav | Purpose |
|------|-----|---------|
| `admin.html` | `admin` | Main admin hub |
| `admin-blueprint.html` | `admin-sub` | Site architecture + dev lessons |
| `admin-crm.html` | `admin-sub` | CRM lead manager |
| `admin-debug.html` | `admin-sub` | DB debug tools |
| `admin-dev-ops.html` | `admin-sub` | DevOps monitor |
| `admin-email-pipeline.html` | `admin-sub` | Email pipeline |
| `admin-feature-matrix.html` | `admin-sub` | Feature roadmap (259 items) |
| `admin-parking-lot.html` | `admin-sub` | Parking lot |
| `admin-user-creator.html` | `admin-sub` | User creation |
| `email-admin.html` | `admin-sub` | Email builder |
| `testing-admin.html` | `admin-sub` | QA testing rounds |

### SEO / Crawler Files (repo root)
| File | Purpose |
|------|---------|
| `sitemap.xml` | 42 URLs — correct page names, priorities, daily/weekly/monthly changefreq |
| `robots.txt` | Full exclusion list for admin/portal/testing/auth/temp pages |
| `llms.txt` | AI crawler identity — what F4F is and is not |
