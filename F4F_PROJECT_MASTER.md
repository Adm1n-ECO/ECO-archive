# Fund4Founders — Project Master Document
_Updated: 2026-03-17 — Session 44 fully complete_

---

## What F4F Is

Fund4Founders is a **vetted introductions platform** connecting six role types:
- 💡 **Founders** (Idea Generators) — seeking funding, talent, advisors, beta customers, partners
- 💰 **Investors** (VC/Angel) — seeking dealflow aligned to their thesis
- 🧩 **Consultants** (Business Consultants) — seeking founder clients
- 🎯 **Potential Employees** (Early Employees) — seeking startup roles
- 🔬 **Beta Customers** (Early Adopters) — seeking products to trial
- 🤝 **Strategic Partners** — seeking co-build or distribution relationships

**Core philosophy:** F4F owns the introduction. NDA auto-executes before every match reveal. No brokering, no equity cut, no middlemen. Revenue = flat subscription + per-connection fee.

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Static HTML/CSS/JS (no framework) |
| Backend | Supabase (PostgreSQL + Edge Functions + Auth) |
| Hosting | Network Solutions (fund4founders.com) |
| Deploy | GitHub Actions → lftp (~60s from push to live) |
| Payments | Stripe (live keys set; F4F_TEST_MODE = true until go-live) |
| Email | Resend (DNS verified for fund4founders.com) |
| AI | Anthropic Claude API via Supabase edge functions |
| Analytics | PostHog + Sentry (injected via site-components.js, disabled by default) |
| Geocoding | zippopotam.us (primary) + Nominatim (fallback) |

---

## Repository & Credentials

```
GitHub:   https://github.com/Vikas-F4F/F4F.git
Branch:   main
PAT:      [F4F_GITHUB_PAT_REDACTED]
Admin:    [F4F_ADMIN_EMAIL_REDACTED]
```

```
Supabase URL:      https://[F4F_SUPABASE_URL_REDACTED]
Supabase Anon Key: [F4F_SUPABASE_ANON_KEY_REDACTED]
BuiltWith API Key: [F4F_BUILTWITH_KEY_REDACTED]
```

---

## Database Schema (key tables)

| Table | Key Columns |
|-------|-------------|
| roles_idea_generator | email, startup_sector, current_stage, city, state, zip_code, lat, lng, amount_sought, readiness_score, readiness_scored_at, brief_pitch, theme_preference |
| roles_investor | email, preferred_sectors, check_size_min, check_size_max, preferred_stages, investment_thesis, lat, lng, city, state |
| roles_consultant | email, primary_skills, preferred_sectors, lat, lng, city, state |
| roles_employee | email, primary_skills, preferred_sectors, lat, lng, city, state |
| roles_adopter | email, sectors_of_interest, lat, lng, city, state |
| roles_partner | email, sectors_served, lat, lng, city, state |
| match_results | email_a, email_b, name_a, name_b, role_a, role_b, score, tier, breakdown_json, opt_in_a, opt_in_b, is_unlocked, created_at — **NO status column** |
| signup_applications | email, role, status, first_name, last_name, city, state, location, is_seed_user, submitted_at |
| admin_superusers | email (only column used for auth checks) |
| admin_notes | email (PK), note, updated_by, updated_at |
| readiness_score_log | founder_id, overall_score, created_at |
| dev_lessons | id, session, category, mistake, fix, tags |
| dev_changelog | id, version, title, body, category |
| marketing_contacts | email, first_name, role, industry, company_name, wave_1/2/3 fields |
| referral_credits | ref_code, referrer_email, referred_email, status |
| auth_activity_log | email, event_type, role, page_url, logged_at |

**CORRECT table names (burned in from errors):**
- `match_results` NOT `matches`
- `signup_applications` NOT `applications`
- `admin_superusers` NOT `superusers`

---

## Column Names (frequently confused)

```
investment_thesis        NOT investment_focus
check_size_min/max       NOT check_size
primary_skills           NOT skills
opt_in_a / opt_in_b      NOT ig_opted_in / vc_opted_in
email_a / email_b        NOT founder_email / investor_email
startup_sector           on roles_idea_generator
sectors_of_interest      on roles_adopter
sectors_served           on roles_partner
current_stage            NOT funding_stage
breakdown_json TEXT      separate from breakdown jsonb
readiness_score INTEGER  on roles_idea_generator (SQL 120)
```

---

## Portal Routing

```js
// Auth.js ROLE_PORTALS map (key entries)
'founder'             → portal-idea-generator.html
'idea generator'      → portal-idea-generator.html
'vc / angel investor' → portal-investor.html
'investor'            → portal-investor.html
'business consultant' → portal-consultant.html
'potential employee'  → portal-employee.html
'beta customer'       → portal-beta.html
'strategic partner'   → portal-partner.html

// Live portal files (auth.js ALL_PORTALS array)
portal-idea-generator.html
portal-investor.html
portal-partner.html
portal-consultant.html
portal-employee.html
portal-beta.html
portal-matches.html

// DEAD files — do NOT route to or inject into
portal-beta-customer.html
portal-strategic-partner.html
```

---

## Edge Functions (deployed — all JWT verification OFF)

| Function | Purpose |
|----------|---------|
| ai-help-chat | AI chat widget in portals |
| auto-match-cron | Hourly full-platform matching engine (pg_cron trigger) |
| geocode-location | Geocode member locations for ecosystem map |
| notify-message | Push notifications for messages |
| pitch-outline | AI 10-slide pitch deck outline |
| readiness-score | Founder 12-dimension AI analysis + score sync to roles_idea_generator |
| send-test-invite | Tester invitation system |
| stripe-webhook | Subscription events → subscription_tier |
| welcome-email | New member onboarding + approval emails |

**Anthropic model in edge functions:** `claude-haiku-4-5-20251001`
**readiness-score** redeployed Session 44 (score sync live)
**auto-match-cron** code ready — needs manual deploy + pg_cron enable (Vikas action)

---

## Security DEFINER RPCs (bypass RLS — grant to anon or authenticated)

| Function | Purpose | Grant |
|----------|---------|-------|
| get_ecosystem_locations() | lat/lng for all 6 role tables | anon + authenticated |
| get_market_intelligence_data() | aggregate data for public page | anon + authenticated |
| get_all_match_results() | all match pairs for admin Signal Density | authenticated only |

---

## Stripe Configuration

```js
// In js/auth.js ~line 95
window.F4F_TEST_MODE = true;  // FLIP TO false BEFORE GO-LIVE

// Founding price IDs (live, first 100 per role, locked for life)
STRIPE_SUB_INNOVATOR_FOUNDING   = 'price_1TAkgC8wtE5vav0WzdhYBebm'  // $20/mo
STRIPE_SUB_INVESTOR_FOUNDING    = 'price_1TAkoe8wtE5vav0Wi6fbG5HT'  // $100/mo
STRIPE_SUB_ADVISOR_FOUNDING     = 'price_1TAkwK8wtE5vav0WOniYI5I1'  // $50/mo
STRIPE_SUB_PARTNER_FOUNDING     = 'price_1TAkyS8wtE5vav0WdxR0pjC3'  // $250/mo
STRIPE_SUB_TALENT_FOUNDING      = 'price_1TAl3u8wtE5vav0WzbUx7XX3'  // $5/mo
STRIPE_SUB_BETA_FOUNDING        = 'price_1TAl0K8wtE5vav0Wznj7y9MF'  // $5/mo
```

---

## Deployment & Dev Workflow

```bash
# Session clone
rm -rf /home/claude/repo-live && git clone https://Vikas-F4F:[F4F_GITHUB_PAT_REDACTED]@github.com/Vikas-F4F/F4F.git /home/claude/repo-live

# Standard commit
git add -A && git commit -m "message" && git push
# Live in ~60 seconds

# Pre-commit hook (installed at session start)
cp .githooks/pre-commit .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit
```

---

## PERMANENT ARCHITECTURE RULES

### CSS
- Always CSS variables — NEVER hardcoded hex or rgba with dark values
- `var(--surface-2)` for cards/panels — adapts to all 6 themes
- Never `rgba(8,14,28,*)` — use `var(--surface-2)`
- All 3 light themes (`light`, `light-sage`, `light-mid`) need matching overrides for any nav/button color fix — never patch just one

### RLS / Supabase Auth
- **NEVER use `auth.email()` in RLS policies** — returns NULL in JS client JWT context
- Always use `auth.jwt()->>'email'`
- Pattern: `WHERE LOWER(email) = LOWER(auth.jwt()->>'email')`
- Admin/public data requiring cross-table reads → use SECURITY DEFINER RPC
- `CREATE POLICY IF NOT EXISTS` is INVALID → use `DROP POLICY IF EXISTS` + `CREATE POLICY`
- `DROP FUNCTION IF EXISTS` required before changing return type
- After CREATE FUNCTION: wait ~30s or run `NOTIFY pgrst, 'reload schema';`
- Superuser needs ALL policy, not just INSERT
- **match_results has NO `status` column** — never SELECT it

### JavaScript / Supabase JS Client
- Never `.in()` with null values — use `.or('status.eq.pending,status.is.null')`
- RLS blocks reads after status changes — fetch name+role BEFORE updating status
- Use data attributes on buttons to pass values rather than re-fetching post-update
- `getSupabase()` helper from auth.js available in browser console on admin.html

### CSP
- Every page must include `cdn.jsdelivr.net` in `connect-src`
- Standard connect-src: `'self' https://*.supabase.co wss://*.supabase.co https://api.resend.com https://api.stripe.com https://api.zippopotam.us https://nominatim.openstreetmap.org https://cdn.jsdelivr.net`
- Never use `fetch()` for external CDN resources — use `d3.json()` (uses XHR, bypasses connect-src)
- `<\/script>` in raw HTML closes script block early → SyntaxError. Only use inside JS strings.

### Auth Flow
- Magic link `emailRedirectTo` must be `/signin.html` not `/index.html`
- `signin.html` has `exchangeCodeForSession` + `getPortalUrl` logic
- `index.html` does NOT — users end up stuck if sent there

### Mobile Menus
- Mobile menus are **hardcoded HTML** in each page — NOT generated by site-components.js
- Any new top-level nav item must be added to EVERY mobile-menu div across all pages via script
- Standard order: Home, How It Works, Roles, Ecosystem, Success, About, Contact, Sign In (class=nav-signin-link), My Portal (class=nav-portal-link, display:none), Get Started button
- Section-nav dots (right side) and Sign In / Get Started buttons are **intentionally hidden on mobile** — replaced by the hamburger (☰) which opens the slide-in menu

### Canvas / Animated Graphics
- Browser Canvas cannot recolor emoji — use custom-drawn SVG-style paths for color-controlled icons
- Hub diagram in how-it-works.html uses Canvas API with custom drawIcon() functions
- White background (#ffffff) on canvas with border-radius on wrapper div for theme compatibility

### SQL Migrations
- Always run in numbered order — never skip
- Next SQL: **127**
- SQLs 1–126 all run

### Matching Engine (js/matching-v4.js)
- Writes `breakdown_json` (TEXT) to match_results
- Sector overlap is HARD FILTER — returns 0 if no overlap
- Score threshold: 25 minimum to store a result
- Superuser needs ALL policy, not just INSERT

### Ecosystem Map
- `get_ecosystem_locations()` RPC returns role, lat, lng, display_location
- All 6 role tables need lat/lng populated
- display_location built from COALESCE(city+state) — NO `location` column on non-founder tables
- Map uses `d3.json()` NOT `fetch()` for TopoJSON

### Export
- Use `safeAppendSheet(wb, ws, name)` guard — never direct `XLSX.utils.book_append_sheet` in export loop
- No duplicate role entries in ROLE_TABS array

---

## Navigation — Current State (Session 44)

### Desktop nav links (site-components.js)
How It Works | Roles | Ecosystem | Success | About | Contact | [Sign In] [Get Started]

### Mobile menu links (hardcoded in every page)
Home | How It Works | Roles | Ecosystem | Success | About | Contact | Sign In | My Portal | Get Started

### Footer columns (site-components.js — Session 44 trimmed)
- **Platform:** Virtual Meetups, Consultant Marketplace, Member Showcase, Founder/Investor/Consultant/Employee/Beta/Partner Showcase
- **Join:** Founders, Investors, Consultants, Early Employees, Beta Customers, Strategic Partners, Member Directory
- **Company:** Blog, What's Moving, FAQ, Why Join, Our Manifesto
- **Legal:** Terms of Use, Privacy Policy, Regulatory Compliance

**Removed from footer (Session 44 — covered by nav):** All Platform Roles, How It Works, Ecosystem Map, Pricing, About Us, Contact, Success Stories

---

## Success Wall (success-wall.html) — Session 44 rebrand

- Nav label: "Wins" → "Success" across all 23 pages + site-components.js
- Hero: "Success is Shared Here" — network-wide framing
- Added 6-role benefit card section (Founder, Investor, Early Employee, Early Adopter, Consultant, Strategic Partner)
- KPIs: added Partnerships Formed, renamed to Outcomes Published
- Story filters: added consulting_engaged category
- Placeholder stories cover all 6 role combinations
- CTA: "Find Your Role / How It Works" — not founder-only

---

## Test Accounts (QA — password login only, no magic links)

**Active QA (auth.users exist, can log in):**
- ig1@fund4founders.com, ig2, ig3 (Founders)
- vc1@fund4founders.com, vc2 (Investors)
- bc1@fund4founders.com, bc2 (Consultants)
- pe1@fund4founders.com, pe2 (Employees)
- ea1@fund4founders.com, ea2 (Beta Customers)
- sp1@fund4founders.com, sp2 (Partners)

**Test-only profiles (no auth.users — profile rows only):**
- t01–t30 (Founders), v01–v30 (Investors), c01–c30 (Consultants)
- e01–e30 (Employees), b01–b30 (Beta), s01–s30 (Partners)
- 846 match pairs seeded

**Superuser:** [F4F_ADMIN_EMAIL_REDACTED]

---

## Vikas Action Items Before Go-Live

| Priority | Item |
|----------|------|
| CRITICAL | Flip `F4F_TEST_MODE = false` in js/auth.js ~line 99 |
| CRITICAL | Set Stripe live Price IDs in auth.js lines 116–117 |
| Deploy | `auto-match-cron` edge function via Supabase Dashboard → Functions |
| Enable | `pg_cron`: Supabase → Database → Extensions → pg_cron |
| Awaiting | Zoho Sign OAuth creds (ZOHO_CLIENT_ID, SECRET, REFRESH_TOKEN, TEMPLATE_ID) |
| Awaiting | Sentry DSN → js/analytics.js line 14 |
| Awaiting | Apollo API key + Propeo API key (admin enrichment) |
| Awaiting | Anthropic API credits at console.anthropic.com |
