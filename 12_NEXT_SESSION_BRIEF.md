# Next Session Brief
**Generated:** March 2026 — End of Design + Dashboard + Feature Registry session
**Purpose:** Read this first. Load no other documents until you have read this.

---

## WHERE WE ARE

**Project lifecycle:** Detail Design COMPLETE. Build Stage 0 in progress.
**Current data source:** Google Sheets (POC — migrating to Supabase).
**Dashboard mockup:** Complete. Saved as ECO_DASHBOARD_MOCKUP.html in zip.
**Feature registry:** Complete. Saved as 13_FEATURE_REGISTRY.md.

---

## THIS SESSION — WHAT WAS DONE

### Globe
- globe-live.html rebuilt with animated arc system (TubeGeometry + ShaderMaterial)
- Arcs animate from birth city to current city, staggered, with leading glow dot
- Confirmed fixed in Claude — needs local texture test on dev machine

### Schema additions (all new tables this session)
PHOTOS, PROXIMITY_NOTES, DISCOVERY_CARDS (full tag set), CULTURAL_VOCAB_LIBRARY
(full tag set), QUESTION_TEMPLATES, BANNER_FEEDBACK, USER_PREFERENCES,
NIGHTLY_JOB_LOG, PENDING_QUESTIONS, PENDING_BANNER_CARDS, VALIDATION_LOG,
TERM_CONFLICT_REGISTRY, CONTENT_STAGING, STAGING_REVIEW_LOG, NETWORK_MESSAGES,
NETWORK_MESSAGE_RECIPIENTS, PLATFORM_FEEDBACK

### Architecture additions
- Nightly batch job: full 5-step spec, Supabase Edge Function + pg_cron, midnight Pacific
- Content staging pipeline: AI review, tiered promotion (A-E), admin console spec
- Theme system: full 4-theme CSS variable registry, theme selector spec
- Nightly validation rules: 5 categories including inherited label integrity
- Non-assumption principle: roots ≠ practice, locked in all docs

### Dashboard mockup (ECO_DASHBOARD_MOCKUP.html)
- ECO mark (triangle) as navigation icon — white apex, blue bottom-left, green bottom-right
- Slow breathing pulse on input box (3.5s cycle, not heartbeat)
- Rotating placeholder text (13 phrases, 5-8s intervals, 800ms crossfade)
- Four themes (Dawn/Dusk/Depth/Void) — all CSS variables, nothing hardcoded
- Three mini-visualizations: globe, constellation, network directory table
- Discovery Banner with non-assumption voice (geography voice, curiosity voice)
- Upcoming features teaser (green border, 12s rotation, emotional promise language)
- User avatar top-right (photo or initials fallback)
- Role mode switcher (Conductor / Keeper / Moderator)
- Three-dot ECO mark menu

### Key design decisions locked this session
1. No forms anywhere — rule 8 in session start + memory
2. Never assume cultural practice from heritage — rule 9 in session start
3. AI questions use open-door model — state facts, ask everything else
4. Discovery Banner non-assumption principle — present/invite/educate, never assume
5. Tagline locked: "Your Eternal. Your Current. Only Yours. Forever."
6. ECO triangle mark is the navigation icon
7. Legacy View locked to Phase 2 (not Phase 1)
8. Network Directory replaces Legacy View thumbnail in third dashboard slot
9. Resend added to production stack for email
10. Tiered content promotion — Tiers A/B/C auto-promote, D/E need human approval
11. Cultural bridge = full network + world traditions, not just viewer's own origin
12. Inherited label model: DisplayLabel + DisplayLabelSource + DisplayLabelOriginID

### Features added to registry this session
- Platform feedback question (type 6) — once per 90 days
- Upcoming features teaser banner — bottom of dashboard
- Network Directory + messaging (Phase 1, pulled forward)
- Resend email integration (Phase 1)

---

## LAST 10 LOCKED DECISIONS

1. Tagline: "Your Eternal. Your Current. Only Yours. Forever." — LOCKED
2. No forms anywhere. No submit buttons. No labeled input fields. Ever.
3. Never assume cultural practice from heritage. Roots ≠ practice.
4. AI questions: open-door model. State facts. Ask everything else.
5. Discovery Banner: geography voice / curiosity voice / community voice. No assumption.
6. ECO triangle mark (white top, blue bottom-left, green bottom-right) = nav icon.
7. Theme system: theme.css owns ALL tokens. No hardcoded colors in any HTML file.
8. Network Directory (table + messaging) in third dashboard slot. Legacy View → Phase 2.
9. Nightly batch job: midnight Pacific, Supabase Edge Function, Batch API.
10. Content staging: Tier A/B/C auto-promote on AI approval. D needs Moderator. E needs external confirmation.

---

## 3 MOST IMPORTANT NEXT ACTIONS

1. **Schema finalization session** (before ANY build code)
   Load: 02_SCHEMA + 04_BUILD_STAGES
   All new tables from this session need to be created in Supabase.
   CRITICAL: Do this before writing a single line of feature code.

2. **Spec pass — The Current + The Pulse** (Phase 1, Stage 5)
   Load: 05_FEATURES_PHASE0_1 + 06_FEATURES_PHASE2_PLUS
   Both are in 13_FEATURE_REGISTRY as GAP items — no active spec yet.
   The Pulse is TIME-SENSITIVE (elders). Prioritize.

3. **Phase reorder review** (Vikas to do on printed feature registry)
   Load: 13_FEATURE_REGISTRY.md
   Vikas will print and reorder. Bring changes back to next session
   for doc updates.

---

## OPEN DESIGN QUESTIONS

1. Third mini-visualization — confirm Option A/B/C for WebGL overhead
   (three live canvases vs one live + two static thumbnails vs all SVG)
2. Tagline punctuation — "Only Yours. Forever." vs "Only Yours Forever." — pick one
3. The Current activity feed — needs full spec before Stage 5 build
4. The Pulse — needs PULSE_QA schema finalized, answer conversion flow
5. Phase reorder — Vikas reviewing feature registry for pull-forwards

---

## SESSION QUICK REFERENCE

Build/coding: 00_SESSION_START + 02_SCHEMA + 03_ARCHITECTURE + 04_BUILD_STAGES
Design: 00_SESSION_START + relevant feature doc + 01_DECISIONS_LOG
Visualization: 00_SESSION_START + 07_VISUALIZATION_SPECS + 02_SCHEMA
Marketing: 10_MARKETING_STRATEGY + 11_TRIBAL_OUTREACH
Feature review: 13_FEATURE_REGISTRY
New session start: 00_SESSION_START → 12_NEXT_SESSION_BRIEF → relevant docs

---

## LIGHTNING NETWORK QUICK REFERENCE

Network ID: lightning-001 | Vikas (STAR) at center | 48+ profiles | Free_Forever
Isaiah BioParent (Amit†) = VisibleTo owner only
Ramesh Sewak = Jaiwati's BROTHER (not her child)
Vikas is called "Bhayia" by Isaiah + Pragati's daughters
  → originated with Pragati (younger sister) and Amit (younger brother)
  → Amit has passed — label lives on in Isaiah (documented, poignant)
Reema is called "Jij" by Karishma, Seema, cousins, Isaiah, Pragati's daughters
  → originated with Karishma/Seema/cousins
  → Isaiah's RelationType = Parent (structural), DisplayLabel = Jij (experienced)
Sahiba = Niti Vaid's daughter = highest-leverage acquisition event (wedding upcoming)

---

## MANIFESTO COMPRESSED TEXT — READY FOR HTML UPDATE

Image placement map confirmed. Text below is final — fits between
images. HTML update pending Vikas instruction.

---

**[img_lonetree.png — full hero, no text overlay]**

Other platforms showed you the Root.
They drew the structure and called it your history.

*A tree implies one direction. Culture does not travel that way.*

**[img_container.png — full width]**
*The coworker who brought food during the hard year.*

**[img_teacher.png — full width]**
*The teacher who saw something in a child nobody else noticed.*

The neighbor who encouraged your mother to cook when your busy
schedule kept you away kept the recipes alive for the generation
after you. Culture has never asked permission to move — through
contact, through love, through the long work of living near
each other.

*Here there is no tree. Only energy —*
*Compounding, Communicating, Conjoining.*

**[img_oklahoma.png — full width]**

**[img_teaching.png — full width]**
*Roots, passed forward.*

Your Eternal is what it was, and what it will be.
Your Current is this moment — flowing into you from the people
in your network, and out from you into theirs, simultaneously.
You are always both. What enters gets held.
What you give is already arriving in someone else.

**[img_couple.png — full width]**

Everything in your network came from your network.
It is not ours to hold, sell, or transfer.
You are not the product. You never will be.

**[img_keeper.png — full width]**

Most families do not fit in a tree.
This was built for all of them.

**[img_tradition.png — full width, closing]**
*Different words. The same beat.*

*Your Eternal. Your Current. Only Yours. Forever.*

---

## HOME PAGE IMAGE PLACEMENT MAP — CONFIRMED

| Section | Image filename |
|---|---|
| Hero | img_hands.png |
| Globe section | img_globe2.png |
| Phase 0 card | img_grandma.png |
| Phase 1 card | img_thanksgiving.png |
| Phase 2a card | img_ethnic.png |
| Phase 2b card | img_tribal.png |
| Feature: Globe | img_globe.png |
| Feature: Constellation | img_confluence.png |
| Feature: Vocabulary | img_terms.jpg |
| Feature: Conversation | img_continuum.png |
| Feature: Network Directory | img_noise.png |
| Feature: Discovery | img_tea.png |
| Energy section background | img_streets.png |
| Story row: Your Eternal | img_legacy.png |
| Story row: Your Current | img_passing.png |
| Story row: The Journey | img_horse.png |

## HOW IT WORKS PAGE

| Section | Image filename |
|---|---|
| HIW hero | img_revitalization.png |

## UNPLACED — ROTATING BANNER & FUTURE USE

img_layeredtime.png, img_youngold.png, img_wedding.png,
img_nowruz.png, img_recipe.png, img_oklahoma.png (after manifesto use),
img_language.png, img_confluence.png (after home use)


---

## SITE BUILD STATUS — CURRENT

### Files in eco_final/
- index.html — Home / How It Works / Manifesto (SPA)
- confluence.html — The Confluence (separate URL)
- images/ — 34 files including eco-logo.png

### To complete before launch
- [ ] Replace img_confluence_new.jpg if better image generated
- [ ] Implement Join The Waitlist mailto bridge in index.html
- [ ] Mobile UX review after latest changes
- [ ] Upload eco_final/ contents to Namecheap public_html
- [ ] Point Namecheap DNS to Vercel when Next.js build begins
- [ ] Complete Supabase migration (Sprint S-05b gate)

### Color/brand locked rules (never change)
- E = #00AAFF, C = #00CC44, O = #FFFFFF in all ECO wordmarks
- ETERNAL = #00AAFF, CURRENT = #00CC44, .Online/Forever = #FFFFFF
- These are enforced at spec level in 00_SESSION_START.md
- If any session changes these: revert immediately

