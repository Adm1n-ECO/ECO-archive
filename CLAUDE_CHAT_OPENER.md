# How to Start the FMTO Claude Chat

## Step 1 — What to upload
Upload these files to the new Claude chat:
- `FMTO_PROJECT_BRIEF.md` — this file is the primary reference
- `F4F_SITE_ARCHITECTURE.md` — page standards, nav system, portal patterns
- `F4F_PROJECT_MASTER.md` — tech stack, DB patterns, critical naming rules
- `workflow-templates/deploy.yml` — exact GitHub Actions deploy workflow to copy
- `githooks/pre-commit` — syntax checking hook

## Step 2 — Opening message to Claude

Paste this as your first message (fill in the bracketed parts):

---

I'm starting a new web project called FindMyTree.Online (FMTO).

I've uploaded several reference files from an existing project (Fund4Founders / F4F) that uses the exact same tech stack we'll use for FMTO. Please read all uploaded files carefully — they contain architecture patterns, critical naming conventions, and proven code patterns we must follow.

**The tech stack:**
- Static HTML/CSS/JS frontend (no framework)
- Supabase (PostgreSQL + Edge Functions + Auth + Storage)
- GitHub Actions → lftp deploy to [HOSTING PROVIDER]
- Stripe payments
- Resend transactional email
- Anthropic Claude API via Supabase edge functions

**About FMTO:**
FindMyTree.Online is a family tree and genealogy subscription website. [ADD MORE DETAIL ABOUT WHAT THE SITE DOES]

**My credentials (already set up):**
- GitHub repo: [REPO URL]
- GitHub PAT: [YOUR PAT]
- Supabase URL: [YOUR SUPABASE URL]
- Supabase Anon Key: [YOUR ANON KEY]

**First tasks this session:**
1. Clone the repo and set up the development environment
2. Build the feature matrix admin page
3. Build SQL 001 — initial database schema
4. Build the homepage

The session start command is:
```
rm -rf /home/claude/repo-live && git clone https://[GITHUB_USER]:[PAT]@github.com/[GITHUB_USER]/[REPO].git /home/claude/repo-live && cd /home/claude/repo-live && git config user.email "[YOUR_EMAIL]" && git config user.name "[GITHUB_USER]" && git remote set-url origin https://[GITHUB_USER]:[PAT]@github.com/[GITHUB_USER]/[REPO].git
```

---

## Step 3 — Notes for Isaiah (non-developer partner)

The F4F architecture was specifically chosen because:
- No build tools — files can be edited directly
- GitHub Desktop handles all version control (no command line needed day to day)
- Supabase dashboard is a full UI — no command line for DB management
- Netlify or similar can be used instead of Network Solutions if easier

For the staging environment, the plan was to use a crunod.com subdirectory.
Ask Claude to set up the GitHub Actions deploy to point at that path.
