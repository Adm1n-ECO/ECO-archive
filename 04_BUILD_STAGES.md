# ECO Build Stage Plan
**Last restructured:** March 2026 — Phase consistency pass
**Current stage:** Detail Design complete. Begin Build Stage 0.

---

## RESTRUCTURE SUMMARY — WHAT CHANGED AND WHY

| Decision | Old | New | Reason |
|---|---|---|---|
| People Directory / card view | Phase 1 | Phase 0 — Stage 3 | Zero billing dependency. Immediate value for pilot family. |
| Profile photos | Phase 1 | Phase 0 — Stage 4 | Faces in constellation = WOW moment. Supabase Storage already in stack. |
| Cultural Vocabulary display | Phase 1 | Phase 0 — Stage 4 | Read-only query of seeded terms. Zero complexity. |
| Basic Discovery Banner | Phase 1 | Phase 0 — Stage 4 | Network facts + vocab only. No feedback algorithm. Low cost. |
| Legacy View | Stage 5 + 7 (ambiguous) | Phase 2 — Stage 8 (locked) | Very high complexity. Revenue must be flowing first. |
| AI Triangulation | Phase 1 full | Phase 1 Tier 3 only / Phase 2 full | Tier 3 is highest value, lowest complexity. |
| AI Question System | 5 types at launch | 3 types first, +2 in Stage 7 | Types 4+5 add complexity. Do not block Phase 1 launch. |
| Discovery Banner feedback algorithm | Phase 1 | Phase 2 | Ship basic banner Phase 0, controls Phase 1, full algorithm Phase 2. |
| Data export GEDCOM | Phase 1 | Late Phase 1 after billing stable | Not a launch blocker. Finicky format — no urgency early. |
| Referral tracking | Phase 1 | Immediately before Stripe launch | Zero value before billing is live. Sequence it, not phase it. |
| GDPR/COPPA legal review | Phase 1 build | Start during Phase 0 build | Legal review has its own timeline. Cannot be compressed by code. |

---

## PHASE GATE CONDITIONS

```
Phase 0 gate = Build Stage 4 complete
Phase 1 gate = Phase 0 stable + legal docs live + Stripe integrated
Phase 2 gate = Phase 1 stable + >= 1 CA tribal partner confirmed
Phase 3 gate = Phase 2 stable + revenue flowing
```

---

## BUILD STAGE 0 — Foundation
**Rule: No feature code until every row is complete.**
**Estimated: 3 sessions**

| Task | Status |
|---|---|
| Schema: People_Master all columns finalized | In progress |
| Schema: new columns this session (GeoConfidence, GeoResolution, PhotoID FK updated) | Pending |
| Schema: Relationships_Linker finalized | Done |
| Schema: Journeys_Media finalized | Done |
| Schema: Milestones | Pending |
| Schema: Invites | Pending |
| Schema: Event_Windows | Pending |
| Schema: Cultural_Vocab_Library | Pending |
| Schema: Keeper_Teachings | Pending |
| Schema: Platform_Stats | Pending |
| Schema: PHOTOS (added this session) | Pending |
| Schema: PROXIMITY_NOTES (added this session) | Pending |
| Schema: DISCOVERY_CARDS with full tag set (CulturalContext[], RelatedCity[], Era[], Theme[], GenerationalPattern[], AudienceResonance[], RequiresPersonMatch, SensitivityFlag, ContentDepth) | Pending |
| Schema: CULTURAL_VOCAB_LIBRARY with full tag set (Theme[], GenerationalPattern[], AudienceResonance[], NuanceNote, UsageExample, RelatedVocabIDs[]) | Pending |
| Schema: QUESTION_TEMPLATES with full tag set and slot system | Pending |
| Schema: BANNER_FEEDBACK (added this session) | Pending |
| Schema: USER_PREFERENCES (added this session) | Pending |
| Schema: NIGHTLY_JOB_LOG | Pending |
| Schema: PENDING_QUESTIONS | Pending |
| Schema: PENDING_BANNER_CARDS | Pending |
| Schema: VALIDATION_LOG | Pending |
| Schema: TERM_CONFLICT_REGISTRY — seed with Nana/Nani/Dada/Dadi/Baba/Mama/Chacha at launch | Pending |
| Schema: Activity_Log | Pending |
| Schema: Network_Memberships | Pending |
| Schema: Data_Requests | Pending |
| All UserIDs confirmed and locked | Done |
| Terminology sweep: Node/Star to Conductor across all files | Pending |
| Cloudflare domain + email routing | Pending |
| Vercel deployment | Pending |
| START LEGAL REVIEW in parallel (GDPR, COPPA, Termly or Legalmattic) | Do not wait for Phase 1 |

---

## BUILD STAGE 1 — Core Infrastructure
**Estimated: 2 sessions**

| Task | File | Est. Sessions |
|---|---|---|
| Cloudflare setup — domain, DNS, email routing | — | 1 |
| Vercel deployment — all files live on HTTPS | All | same |
| Globe — confirm arc fix on dev machine with local textures | globe-live.html | 1 |
| Globe — wire Conductor CurrentLoc as opening position | globe-live.html | same |
| Supabase schema migration — all Stage 0 tables created | SQL migrations | 1 |
| Seed Cultural_Vocab_Library with North Indian + Fijian-Indian terms | Supabase | same |

---

## BUILD STAGE 2 — Authentication and Onboarding
**Estimated: 2 sessions**
**Magic link only — no password, no form**

| Task | File | Est. Sessions |
|---|---|---|
| Supabase magic link auth — email only, no password | auth.html | 1 |
| auth.html — one input, placeholder text only, no label, no form tag, no submit button | auth.html | same |
| Row-level security configured for VisibleTo rules | Supabase | same |
| AI story session — reads existing record, fills nulls, confirms relationships | network-console.html | 1 |
| InviteStatus flow: Pending to Completed — handled conversationally by AI | network-console.html | same |

auth.html behaviour:
User types email. Presses enter. "Check your email" confirmation appears.
That is the entire page. No password. No name fields. No checkboxes.
COPPA age confirmation is one conversational AI question on first login — not a checkbox.

---

## BUILD STAGE 3 — Data Entry and Management
**Estimated: 3 sessions**
**entry-portal.html is retired. All data entry through network-console.html.**

| Task | File | Est. Sessions |
|---|---|---|
| Network console — conversational person entry (name, origin, dates, cities) | network-console.html | 1 |
| Network console — conversational Lynch Pin / relationship selector | network-console.html | same |
| Network console — conversational milestone entry | network-console.html | same |
| People Directory — card view in dashboard with inline tap-to-correct | dashboard.html | 1 |
| Family notes parser — paste text, AI extracts structured rows | network-console.html | 1 |
| Supabase write endpoint — batch row insert from AI session output | API layer | same |

What moved out of separate entry portal:
- Lynch Pin selector: AI asks "Who are you related to?" — presents People Directory results inline
- Milestones: AI asks type, date, description, visibility — writes directly, no form
- Profile editing: inline tap-to-correct in People Directory only — single field, no form
- People Directory preferences stored in localStorage, migrated to Supabase in Stage 6b

---

## BUILD STAGE 4 — Visualization and Phase 0 Dashboard
**Estimated: 6 sessions**
**Pull-forwards included: Profile Photos, Cultural Vocab, Basic Discovery Banner**
**PHASE 0 SHIPS WHEN THIS STAGE IS COMPLETE**

| Task | File | Est. Sessions |
|---|---|---|
| Constellation — Conductor terminology sweep | view-pro-v2.html | 1 |
| Constellation — Ripple theme | view-pro-v2.html | 1 |
| Constellation — Circuitry theme | view-pro-v2.html | 1 |
| Constellation — Cosmic theme | view-pro-v2.html | 1 |
| Profile Photos — upload, Supabase Storage, display in constellation + cards | network-console.html + view-pro-v2.html | 1 |
| Dashboard shell + three miniature visualizations | dashboard.html | 1 |
| Basic Discovery Banner — network facts + vocab spotlight, static 50/50 weighting | dashboard.html | same |
| Cultural Vocabulary — read-only display of seeded terms in banner | dashboard.html | same |

Profile Photos scope for Phase 0:
- Self-upload for own profile
- Upload for passed and placeholder profiles (any Conductor)
- Display in constellation — circle crop + Origin-colour ring
- Display in People Directory cards
- Clusters: rings and dots only, never photos
- No-photos-of-minors rule enforced at upload UI
- Phase 1 addition: living Conductor tagged by others with notification + 7-day acceptance

Discovery Banner scope for Phase 0:
- Sources: network facts (computed) + cultural vocab spotlight only
- Static weighting: 50/50
- Collapsed and expanded card states
- No feedback buttons (AlreadyKnew / WantLess) — Phase 1
- No topic pills — Phase 2
- No BANNER_FEEDBACK writes

---

## PHASE 0 SHIPS HERE
**Gate: Build Stage 4 complete**
**Estimated total from Stage 0: ~17 sessions**

---

## BUILD STAGE 5 — Dashboard and AI Question System
**Estimated: 5 sessions**
**Ships 3 of 5 question types. Types 4+5 in Stage 7.**

| Task | File | Est. Sessions |
|---|---|---|
| Dashboard — complete layout (AI question + mini-vizs + banner positioned correctly) | dashboard.html | 1 |
| **Nightly batch job — Supabase Edge Function + pg_cron** | Supabase Edge Function | 2 |
| — Step 1: delta detection | — | included |
| — Step 1.5: data validation pass → VALIDATION_LOG | — | included |
| — Step 1.8: content staging AI review → CONTENT_STAGING promotion | — | included |
| — Step 2: engagement score recalculation | — | included |
| — Step 3: question generation (template-first, Batch API fallback) | — | included |
| — Step 4: banner card assembly (templates + Batch API) | — | included |
| — Step 5: stale content cleanup + NIGHTLY_JOB_LOG write | — | included |
| — Delta trigger for pools dropping below threshold | — | included |
| **Admin console — content staging interface (admin.html)** | admin.html | 1 |
| — Conversational entry (Mode 1) | — | included |
| — Paste and parse bulk entry (Mode 2) | — | included |
| — NeedsRevision review queue (Mode 3) | — | included |
| AI question system — serve from PENDING_QUESTIONS on login | dashboard.html + API | 1 |
| AI question — four response options wired to story capture | network-console.html | same |
| Milestone notifications — birthday month emails | Email + Milestones | 1 |
| Memory prompts — weekly/monthly gap emails | Prompt_Log + Email | 1 |

Do not build question types 4+5 here. They add complexity that should not block Phase 1 launch.

---

## BUILD STAGE 6 — Billing, Compliance and Network Growth
**Estimated: 11 sessions**
**Legal review must already be running before this stage begins**

| Task | File | Est. Sessions |
|---|---|---|
| Stripe — Conductor + Pro tiers | Vercel + Auth | 2 |
| No auto-renewal billing flow | Stripe | 1 |
| Renewal notification — 14-day, family-aware secondary | Email + Auth | 1 |
| Referral tracking retroactive credits — build immediately before Stripe goes live | Invites + Stripe | 1 |
| GDPR/COPPA — cookie consent, age gate, legal docs live | Legal + UI | 1 |
| My Data page — always accessible regardless of billing status | /my-data | 1 |
| Erasure / opt-out flow — 30-day completion SLA | Data_Requests | 1 |
| New network creation — public onboarding | Auth + Networks | 1 |
| Moderator nomination workflow | Roles + Auth | 1 |
| Keeper designation + KeeperTitle | Roles + Auth | 1 |

---

## BUILD STAGE 6b — Entry Portal AI and Banner Feedback
**Estimated: 3 sessions**
**Triangulation ships Tier 3 only. Tiers 1+2 deferred to Stage 8.**

| Task | File | Est. Sessions |
|---|---|---|
| AI Triangulation — Tier 3 only: social triangulation ("were you near [person]?") | network-console.html + AI | 1 |
| PROXIMITY_NOTES write on Tier 3 answer | API layer | same |
| Discovery Banner — feedback controls (AlreadyKnew + WantLess, BANNER_FEEDBACK writes) | dashboard.html | 1 |
| USER_PREFERENCES — migrate card layout + banner prefs from localStorage to Supabase | API layer | 1 |

---

## BUILD STAGE 7 — Phase 1 Completion
**Estimated: 4 sessions**

| Task | File | Est. Sessions |
|---|---|---|
| Data export — GEDCOM + JSON (after billing is stable) | /my-data | 1 |
| AI question type 4 — cultural contribution question + submission flow | dashboard.html + AI | 1 |
| AI question type 5 — sensitivity layer (jurisdiction detection, Conductor flags) | dashboard.html + API | 1 |
| Keeper tools — KEEPER_TEACHINGS write, pinned annotations, Teaching Moments | network-console.html | 1 |

---

## PHASE 1 SHIPS HERE
**Gate: Build Stage 7 complete + Stripe live + legal docs live**
**Estimated total from Phase 0 ship: ~25 sessions**

---

## BUILD STAGE 8 — Phase 2 Features
**Estimated: 15 sessions**
**Legacy View is locked to this stage. Do not attempt before revenue is flowing.**

| Task | File | Est. Sessions |
|---|---|---|
| Legacy View — full implementation | legacy-view.html | 3 |
| — Three scoring dimensions: Engagement / Temporal Distance / Keeper | — | included |
| — Custom GLSL shaders, delta-triggered caching, LegacyViewHash | — | included |
| — Living vs Passed sky quality parameter | — | included |
| AI Triangulation — Tier 1 region question + Tier 2 landmark anchor | network-console.html + AI | 1 |
| Discovery Banner — full algorithm (WantLess weighting + topic pills) | dashboard.html | 1 |
| Org Admin tier — billing, seat management, single invoice | Stripe + Admin | 3 |
| Org Admin dashboard — health metrics, login activity, seat allocation | /admin | 2 |
| Tribal vocabulary seeding — 4 CA tribes, 8 terms each, RestrictedFlag workflow | Supabase | 1 |
| Cultural trauma content — AI question templates (Partition, internment, Trail of Tears) | AI + Config | 1 |
| Journey Replay — shareable animated globe arc | globe-live.html | 2 |
| /demo — test drive with fictional diverse family | /demo | 1 |

---

## BUILD STAGE 9 — Phase 3 and Beyond
**Post-revenue. Build only when Phase 2 is stable.**

| Feature | Est. Sessions |
|---|---|
| Time Capsule | 2 |
| Print/Export products (partner redirect) | 1 |
| Kinetic Ledger | 2 |
| Circuit Sprints | 2 |
| Functional Kitchen | 2 |
| Global Expedition Log | 2 |
| Legacy View descendant constellation | 2 |
| Vocabulary skins | 1 |
| Mobile app | Post-revenue — separate project |
| Voice input — microphone icon in network console | Post-revenue — see note below |

**Voice input note (return to this when mobile app is in scope):**
A microphone icon in the network console input area — tap to speak,
AI processes identically to typed input. Technically: browser Web
Speech API at minimum, Deepgram for accent robustness. Custom
vocabulary hint list assembled from each network's names and cultural
terms to handle proper nouns (Bhayia, Amritsar, Lautoka, Nirupma).
No audio stored — transcription only. Designed for older family
members for whom typing is a barrier, and for capturing the
emotional register of how people speak about family.
Phase 3 at earliest. Bundle with mobile app build.

Load for every coding session:
00_SESSION_START + 02_SCHEMA + 03_ARCHITECTURE + 04_BUILD_STAGES

```
"Working on Stage [X], Task: [name].
File: [filename]. Do not touch any other file.
Depends on: [list what must already be built].
End the session with test data confirming this feature works."
```

---

## SPRINT STATUS

| Sprint | Status | Stage | What it covers |
|---|---|---|---|
| S-01 | Done | — | Google Sheets DB, seed data |
| S-02 | Done | — | Apps Script API, globe live data |
| S-03 | Done | — | Claude AI portal wired |
| S-04 | Next | Stage 3 | Lynch Pin selector, People Directory |
| S-05 | Pending | Stage 4 | Profile photos — Supabase Storage |
| S-05b | Pending | Pre-launch gate | **Supabase migration + Apps Script retirement** — export Lightning-001 JSON, migrate to Supabase, replace all Apps Script fetch calls, smoke test. Nothing launches until this is done. |
| S-06 | Pending | Stage 1 | Vercel + Namecheap DNS deployment |
| S-07 | Pending | Stage 2 | Auth — Supabase signup/login |
| S-08 | Pending | Stage 4 | Dashboard shell + Basic Discovery Banner + Cultural Vocab |
| S-09 | Pending | Stage 4 | Constellation themes (Ripple, Circuitry, Cosmic) |
