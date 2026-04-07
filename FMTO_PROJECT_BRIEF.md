# FindMyTree.Online — Project Brief
_Created: 2026-03-18 · Bootstrapped from F4F architecture patterns_

## What FMTO Is

FindMyTree.Online is a family tree / genealogy subscription website.
Co-founded by Vikas Bakshi and Isaiah Bakshi.
Staging: crunod.com subdirectory (planned)
Partner: Isaiah Bakshi (no prior dev experience, PC)

---

## Tech Stack (same as F4F — proven patterns)

| Layer | Technology | Notes |
|-------|-----------|-------|
| Frontend | Static HTML/CSS/JS (no framework) | Same as F4F |
| Backend | Supabase (PostgreSQL + Edge Functions + Auth) | New project needed |
| Hosting | Network Solutions or crunod.com subdirectory | TBD |
| Deploy | GitHub Actions → lftp | Same workflow as F4F |
| Payments | Stripe | New account/keys needed |
| Email | Resend | New account/keys needed |
| AI | Anthropic Claude API via Supabase edge functions | New API credits needed |

---

## Credentials to Set Up (FMTO-specific — fill these in)

```
GitHub repo:     [CREATE NEW REPO]
GitHub PAT:      [GENERATE NEW PAT — never reuse F4F PAT]
GitHub username: [YOUR GITHUB USERNAME]

Supabase URL:    [NEW SUPABASE PROJECT]
Supabase Anon:   [NEW ANON KEY]

Hosting SFTP:    [SFTP HOST]
Hosting User:    [SFTP USERNAME]
Hosting Pass:    [SFTP PASSWORD]

Stripe keys:     [NEW STRIPE ACCOUNT OR NEW PRODUCT]
Resend key:      [NEW RESEND ACCOUNT OR DOMAIN]
```

---

## GitHub Actions Secrets to Set
In GitHub repo → Settings → Secrets → Actions:

| Secret Name | Value |
|------------|-------|
| SFTP_HOST | Your hosting SFTP hostname |
| SFTP_USERNAME | Your hosting SFTP username |
| SFTP_PASSWORD | Your hosting SFTP password |
| SUPABASE_ACCESS_TOKEN | From supabase.com/dashboard → Account → Access Tokens |
| SUPABASE_PROJECT_ID | Your Supabase project ref (e.g. abcdefghijklm.supabase.co → abcdefghijklm) |

---

## Session Start Command Template

_Replace [BRACKETED VALUES] with your actual credentials before using_

```
Let's go — FMTO Session 1.

rm -rf /home/claude/repo-live && git clone https://[GITHUB_USER]:[GITHUB_PAT]@github.com/[GITHUB_USER]/[REPO_NAME].git /home/claude/repo-live && cd /home/claude/repo-live && git config user.email "[YOUR_EMAIL]" && git config user.name "[GITHUB_USER]" && git remote set-url origin https://[GITHUB_USER]:[GITHUB_PAT]@github.com/[GITHUB_USER]/[REPO_NAME].git && cat FMTO_Next_Session_Items.md
```

---

## Key Architecture Decisions (from F4F — apply same)

### 1. No frontend framework
Plain HTML/CSS/JS. No React, no Vue, no build step. This means:
- Claude can write and edit files directly without compilation
- Deploy is a straight file mirror via lftp
- Zero npm dependency hell
- Pages load fast on any hosting

### 2. Supabase for everything backend
- Auth (email magic link or email+password)
- PostgreSQL database with Row Level Security
- Edge Functions (Deno) for server-side logic and AI calls
- Storage for file uploads
- No separate API server needed

### 3. GitHub Actions deploys automatically
Every `git push` to `main` triggers:
1. lftp mirrors files to hosting via SFTP (~60 seconds)
2. Supabase CLI deploys edge functions
See `workflow-templates/` for the exact workflow to copy.

### 4. CSS variables — never hardcode hex
Define all colors in `css/theme.css` as CSS variables.
Every component references `var(--color-primary)` etc.
This enables dark/light mode switching with zero code changes.

### 5. Supabase RLS is mandatory
Every table has Row Level Security enabled.
Members can only read/write their own rows.
Service role key (used only in edge functions) bypasses RLS.

---

## Critical Patterns (hard-won from F4F)

### Supabase JS — null-safe queries
```javascript
// ✅ Correct — handles null status
.or('status.eq.pending,status.is.null')

// ❌ Wrong — .in() with null breaks
.in('status', ['pending', null])
```

### Auth headers in fetch calls
```javascript
// ✅ Correct
headers: { 'Authorization': 'Bearer ' + session.access_token }

// ❌ Wrong — do NOT send apikey header from JS
headers: { 'apikey': ANON_KEY }
```

### Edge functions — JWT verification OFF
All Supabase edge functions should be deployed with `--no-verify-jwt`.
Auth is handled manually in the function body using the Bearer token.

### RLS timing — read before write
If you update a row's status, RLS may block your ability to read it back.
Always fetch the data you need BEFORE updating status fields.

### Chip/multi-select UI — use `.sel` class not `.active`
`.active` is reserved for nav links and tab states.
Selected state for chip multi-selects: `.sel`

### Unescaped apostrophes in JS strings
```javascript
// ❌ SyntaxError
var text = 'it's broken';

// ✅ Correct
var text = "it's fine";
// or
var text = 'it\\'s fine';
// or for long strings with many apostrophes, use array join:
var text = ['first part', 'can', 't break'].join(' ');
```

---

## Supabase Edge Function Template

```typescript
// supabase/functions/my-function/index.ts
import { serve } from 'https://deno.land/std@0.177.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const CORS = {
  'Access-Control-Allow-Origin':  '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization',
};

serve(async (req: Request) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: CORS });

  try {
    const { param1, param2 } = await req.json();

    const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
    const SERVICE_KEY  = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
    const sb = createClient(SUPABASE_URL, SERVICE_KEY);

    // Your logic here

    return new Response(JSON.stringify({ ok: true }), {
      headers: { ...CORS, 'Content-Type': 'application/json' },
    });
  } catch (e) {
    return new Response(JSON.stringify({ error: String(e) }), {
      status: 500,
      headers: { ...CORS, 'Content-Type': 'application/json' },
    });
  }
});
```

---

## Feature Matrix (start here)

Ask Claude to build an `admin-feature-matrix.html` as the first admin tool.
This tracks every feature in a searchable JS array. Pattern from F4F:

```javascript
const FEATURES = [
  {id:1, done:false, cat:'auth',   title:'User signup + email verification',   body:'...', src:'...', effort:'S'},
  {id:2, done:false, cat:'portal', title:'Member profile page',                body:'...', src:'...', effort:'M'},
  // ...
];
```

---

## SQL Migration Convention

Number all migrations sequentially: `sql/001_initial_schema.sql`
Always use `IF NOT EXISTS` so migrations are safe to re-run.
Run in Supabase dashboard → SQL Editor, in order.

```sql
-- SQL 001 — Initial schema
-- FMTO · Session 1

CREATE TABLE IF NOT EXISTS users (
  id    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT NOT NULL UNIQUE,
  ...
);
```

---

## CSS Theme Template

```css
/* css/theme.css */
:root {
  --color-primary:    #YOUR_PRIMARY;
  --color-secondary:  #YOUR_SECONDARY;
  --color-bg:         #YOUR_BG;
  --color-surface:    #YOUR_SURFACE;
  --color-text:       #YOUR_TEXT;
  --color-text-dim:   #YOUR_MUTED;
  --color-border:     rgba(255,255,255,0.1);
  --color-gold:       #YOUR_ACCENT;

  --radius-sm:  8px;
  --radius-md:  12px;
  --radius-lg:  16px;
}

/* Always reference variables — never hardcode hex in components */
.btn-primary {
  background: var(--color-primary);  /* ✅ */
  /* background: #1a73e8; */         /* ❌ */
}
```

---

## Pre-Commit Syntax Hook

Copy `githooks/pre-commit` to `.githooks/pre-commit` in your repo.
Run once after clone:
```bash
cp .githooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```
This checks JS syntax on every commit — catches SyntaxErrors before they go live.

---

## Checklist: First Session Setup

- [ ] Create GitHub repo (private)
- [ ] Generate GitHub PAT (repo + workflow scopes)
- [ ] Create Supabase project
- [ ] Add GitHub Actions secrets (SFTP_HOST, SFTP_USER, SFTP_PASS, SUPABASE_ACCESS_TOKEN, SUPABASE_PROJECT_ID)
- [ ] Copy GitHub Actions workflow from `workflow-templates/`
- [ ] Set up Resend account + verify domain DNS
- [ ] Set up Stripe account + test keys
- [ ] Add Supabase secrets: RESEND_API_KEY, STRIPE_SECRET_KEY, ANTHROPIC_API_KEY
- [ ] Build `admin-feature-matrix.html` as first page
- [ ] Build `sql/001_initial_schema.sql`
- [ ] Push first commit — confirm deploy works end to end
