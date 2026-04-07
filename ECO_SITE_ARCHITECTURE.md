# EternalCurrent.Online — Site Architecture
Last updated: 2026-03-27 (Session 1 — Master Spec established)

## What This Document Is
This replaces F4F_SITE_ARCHITECTURE.md for the ECO project. It covers ECO-specific architecture only. F4F rules apply where noted.

---

## Product Identity
| Field | Value |
|-------|-------|
| Product | EternalCurrent.Online (ECO) |
| Parent | LookMeUp.Online / CRUNOD |
| Dev URL | crunod.com/sites/eco |
| Prod URL | EternalCurrent.Online |
| Hosting | Cloudflare Pages or Vercel (NOT Network Solutions) |
| Database (Phase 0) | Google Sheets — 4 tabs |
| Database (Phase 1+) | Supabase PostgreSQL |
| AI Engine | Claude API (claude-haiku-4-5-20251001) |
| Payments | Stripe — $12/profile/year (Phase 3) |

---

## Standards — Every HTML Page Must
1. Load `css/theme.css` — ECO brand tokens (locked, do not modify)
2. Use CSS variables only — never hardcode hex colors
3. Have `<body data-theme="void">` as default (dark background #080D14)
4. Include canonical CSP (see Section: Canonical CSP below)
5. Include `robots.txt` exclusion for all portal/data pages

---

## Page Inventory

### Public Marketing
| File | Status | Purpose |
|------|--------|---------|
| `index.html` | ✅ Exists | Marketing homepage |

### Portal (Logged-in / Invite-Only)
| File | Status | Purpose |
|------|--------|---------|
| `ai-portal.html` | ✅ Exists | AI Chat primary entry mode |
| `entry-portal.html` | ✅ Exists | Hard Data Entry admin mode |
| `globe-live.html` | ✅ Exists | Live globe — Journeys_Media |
| `tree.html` | 🔵 Needed | Visual family tree |
| `dashboard.html` | 🔵 Needed | Member dashboard |
| `profile.html` | 🔵 Needed | Individual profile view/edit |
| `household.html` | 🔵 Needed | Household grouping |
| `pets.html` | 🔵 Needed | Pets_Extended CRUD |
| `invite.html` | 🔵 Needed | Token-gated invite landing page |

### Admin
| File | Status | Purpose |
|------|--------|---------|
| `admin.html` | 🔵 Needed | Admin hub |
| `ECO_FEATURE_MATRIX.html` | ✅ Exists | Feature registry (this repo) |

---

## Database Architecture

### Phase 0: Google Sheets Tabs
| Tab | Purpose | Key Columns |
|-----|---------|-------------|
| `People_Master` | Core directory | UserID (PK), FullName, Status, Tier, BirthMonthDay (MM-DD only) |
| `Relationships_Linker` | Graph layer | SubjectID, TargetID, RelationType, Branch |
| `Journeys_Media` | Globe dots | PersonID, LocationName (city only), Category, Year |
| `Pets_Extended` | Pet records | PetID, OwnerID, Name, Type, Status |

### Phase 1: Supabase PostgreSQL Tables
| Table | Maps From | Notes |
|-------|-----------|-------|
| `people_master` | People_Master tab | Adds UUID PK, created_at, updated_at, badges JSONB |
| `relationships_linker` | Relationships_Linker tab | FK to people_master.id |
| `journeys_media` | Journeys_Media tab | Adds lat NUMERIC, lng NUMERIC via geocoding |
| `pets_extended` | Pets_Extended tab | Adds created_at |
| `invites` | New | token UUID, invited_by, claimed_by, status, expires_at |
| `households` | New | household_id TEXT PK, name, members JSON |
| `gamification_log` | Gamification Sheet | user_id, action, currents, badge, created_at |

---

## AI Architect

### Model
`claude-haiku-4-5-20251001` — fast, low cost, free tier available.
Swap target: `gemini-2.5-flash` if Claude quota exhausted.

### Edge Function
File: `supabase/functions/eco-ai-architect/index.ts`
JWT verification: OFF (family members use invite tokens, not Supabase JWT)

### System Prompt Pattern
See Master Spec Section 3.2. Never modify the system prompt without updating Master Spec.

### Context Carry (stateless API)
Each session prepends a CONTEXT block with the user's current record, Tier, connection count, and last message. This block is constructed by the web portal before the API call.

---

## Canonical CSP (copy exactly for every new page)
```html
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://cdnjs.cloudflare.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; font-src 'self' https://fonts.gstatic.com; img-src 'self' data: https: https://lh3.googleusercontent.com; connect-src 'self' https://*.supabase.co wss://*.supabase.co https://api.anthropic.com https://sheets.googleapis.com https://www.googleapis.com; object-src 'none'; frame-ancestors 'none';">
<meta http-equiv="Referrer-Policy" content="strict-origin-when-cross-origin">
```
**Note:** Added vs F4F CSP — `https://lh3.googleusercontent.com` (Drive image proxy) and `https://sheets.googleapis.com`.
Never invent a CSP variant. Copy this block exactly.

---

## Critical Architecture Rules (ECO-specific)

1. **Privacy is non-negotiable** — Never store street addresses, full birth years, SSNs, passport numbers, or government IDs. Reject at input layer. Ghost Nodes never surfaced to end users.
2. **CSS variables always** — Never hardcode hex. All colors in `css/theme.css`.
3. **theme.css is locked** — Do not modify brand tokens. Add new utility classes as needed, never change existing variables.
4. **No frontend framework** — Plain HTML/CSS/JS. No React/Vue/build steps. Claude writes directly to files.
5. **UserIDs are permanent** — Lock after first Save. Relationships_Linker uses UserID as foreign key.
6. **Ghost Nodes are internal only** — Status = Placeholder. Never shown in public tree. Filter at query layer.
7. **Google Sheets in Phase 0, Supabase in Phase 1** — Do not skip the migration. Sheets has no RLS.
8. **Branch visibility gating** — Branch A users cannot see Branch B private notes without Common Event or HouseholdID.
9. **robots.txt Disallow all** — No portal page indexed. Privacy mandatory.
10. **Invite-only access** — No public registration. All access via one-time token.

---

## Inherited F4F Rules (still apply)
- No `.in()` with null values — use `.or()` pattern in Supabase
- DROP POLICY before CREATE (no IF NOT EXISTS for policies)
- Apostrophes in JS strings — use array join pattern
- `</script>` in JS strings — escape as `<\/script>`
- Never two tabs/portals with the same storageKey

---

## SQL Migration Index (ECO-specific — starts from 001)
Next SQL number: **010**

| Number | Purpose |
|--------|---------|
| 001 | Core tables (people_master, relationships_linker, journeys_media, pets_extended) |
| 002 | Invites table |
| 003 | Households table |
| 004 | Gamification log table + badges JSONB on people_master |
| 005 | RLS policies — people_master (own record only) |
| 006 | RLS policies — relationships_linker (branch gating) |
| 007 | RLS policies — journeys_media (branch gating) |
| 008 | Admin superuser table + SELECT policies |
| 009 | Seed data — Datta family roots (Tier 0 only) |

---

## Recurring Bug Checklist (ECO-specific additions)
| # | Bug | Rule |
|---|-----|------|
| 1 | `</script>` inside JS string | Escape as `<\/script>` always |
| 2 | Literal `\n` in single-quoted string | Use `\n` or template literal |
| 3 | Hex color hardcoded | Replace with CSS variable |
| 4 | Street address stored in DB | Reject at input, never write |
| 5 | Birth year stored in DB | Write MM-DD only, discard year |
| 6 | Ghost Node shown to user | Add `status != 'Placeholder'` filter |
| 7 | UserID changed after first Save | Lock UserID field after creation |
| 8 | Sheets API called with wrong tab name | Tab names are case-sensitive: People_Master, Relationships_Linker, Journeys_Media, Pets_Extended |
| 9 | Drive image URL constructed from non-File-ID | Always store File ID only; construct URL at render |
| 10 | New page missing robots meta | Add `<meta name="robots" content="noindex, nofollow">` to all portal pages |

---

## Website Archive Files (do not deploy — reference only)
These files exist in `Website-archive/` and contain prototypes for Phase 2+ features:

| File | Phase | Feature |
|------|-------|---------|
| `app/face-morph.html` | P2 | Parent-child face similarity |
| `app/visual-river.html` | P2 | Timeline visual |
| `app/dormant-profiles.html` | P2 | Dormant profile reactivation |
| `app/vendor-marketplace.html` | P2 | Family vendor marketplace |
| `app/moderator.html` | P3 | Moderator merge/dispute tools |
| `app/visual-tree.html` | P1 | Alternative tree layout (reference for tree.html build) |

---

## Session Start Command Template
```bash
# Replace bracketed values before using
git clone https://[USER]:[PAT]@github.com/[USER]/eco.git /home/claude/eco-live
cd /home/claude/eco-live
git config user.email "[EMAIL]"
git config user.name "[USER]"
cat ECO_Next_Session_Items.md
```

_This document is the master architecture reference for EternalCurrent.Online._
_Update after every session that changes structure, adds pages, or makes database decisions._
_Next SQL number tracked at top of SQL Migration Index._
