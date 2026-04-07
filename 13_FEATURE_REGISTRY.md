# ECO Feature Registry
**Last updated:** March 2026 — Full phase consistency review
**Purpose:** Complete list of all planned features sorted by phase.
**Use:** Print and review for phase reordering. Update phase assignments here
then reflect changes in 04_BUILD_STAGES, 05_FEATURES_PHASE0_1, 06_FEATURES_PHASE2_PLUS.

---

## STATUS KEY
- Done ✓ — Built and confirmed working
- In progress — Partially built
- Pending — Spec complete, not yet built
- Pulled forward — Originally later phase, moved earlier
- Gap — Referenced in design but needs spec pass before build
- Future — Phase 3+ or post-revenue

## EFFORT KEY
- Low — 0.5–1 session
- Medium — 1–2 sessions
- High — 2–3 sessions
- Very high — 3+ sessions

---

## PHASE 0 — MVP LIGHTNING WOW
Gate: Build Stage 4 complete. ~17 sessions. Family pilot only. No billing.

### Foundation (gate — no feature code until complete)

| Feature | Status | Effort | Notes |
|---|---|---|---|
| Schema finalization — all tables and columns | Gap | High | PHOTOS, PROXIMITY_NOTES, DISCOVERY_CARDS, BANNER_FEEDBACK, QUESTION_TEMPLATES, VALIDATION_LOG, TERM_CONFLICT_REGISTRY, NIGHTLY_JOB_LOG, PENDING_QUESTIONS, PENDING_BANNER_CARDS, USER_PREFERENCES, NETWORK_MESSAGES, CONTENT_STAGING, STAGING_REVIEW_LOG all added this session |
| Supabase migration from Google Sheets | Pending | High | All Stage 0 tables created. Seed data migrated. |
| Vercel + Cloudflare deployment | Pending | Low | All files on HTTPS. Custom domain. Email routing. |
| Terminology sweep — Node/Star → Conductor | Pending | Low | Across all code files |

### Auth and onboarding

| Feature | Status | Effort | Notes |
|---|---|---|---|
| Supabase auth — signup / login | Pending | Medium | Two sequential prompts. No form tag. Row-level security for VisibleTo. |
| AI story session | In progress | Medium | Reads existing record, fills nulls. Open-door question model. Never assumes practice or role. |
| Invite flow | Pending | Low | Pending → Opened → Registered → Completed |

### Data entry (pulled forward from Phase 1)

| Feature | Status | Effort | Notes |
|---|---|---|---|
| People Directory — card view | Pulled forward | Medium | Field picker, sort, filter, click-to-detail. USER_PREFERENCES in localStorage at this stage. |
| Entry portal — Lynch Pin selector + Auto-ID | Pending | Medium | AI-driven, no forms |
| Milestones entry | Pending | Low | Marriage, Graduation, Birthday_Milestone, Custom |

### Visualization (pulled forward from Phase 1)

| Feature | Status | Effort | Notes |
|---|---|---|---|
| Globe — migration arcs | Done ✓ | Done | Fixed this session. Needs local texture confirmation on dev machine. |
| Globe — opens on Conductor CurrentLoc | Pending | Low | Animate to logged-in location on login |
| Constellation — 4 themes | Pending | Medium | Organic (base), Ripple, Circuitry, Cosmic. Plus Conductor terminology sweep. |
| Profile Photos | Pulled forward | Medium | Self-upload + passed/placeholder upload. Supabase Storage. Constellation + card display. No photos in clusters. No photos of minors. |
| Cultural Vocabulary — read-only display | Pulled forward | Low | Seeded North Indian + Fijian-Indian terms in banner |

### Dashboard (pulled forward from Phase 1)

| Feature | Status | Effort | Notes |
|---|---|---|---|
| Dashboard shell + three mini-visualizations | Pulled forward | Medium | Globe mini (live), constellation mini (live), network directory entry point. AI question top. Discovery Banner lower. Upcoming features teaser bottom. |
| Basic Discovery Banner | Pulled forward | Medium | Network facts + vocab spotlight. Static weighting. Collapsed/expanded. Non-assumption principle throughout. |
| Rotating Banner — Statement Library | New | Low | Home page. One statement per page load from approved library. Founding set of 15 statements. No repeats on consecutive visits. Engagement tracked per statement. Admin console Mode 5. |
| Rotating Banner — AI Proposal Queue | New | Low-Med | Platform AI proposes new statements (max 3/month) based on vocabulary library patterns, engagement data, and network milestones. Admin approves, edits, or rejects. Human filter is permanent — no statement enters rotation without explicit admin approval. BANNER_STATEMENTS table. |


---

## PHASE 1 — INDIVIDUAL PAID LAUNCH
Gate: Phase 0 stable + legal docs live + Stripe integrated. ~25 sessions from Phase 0.

### Email infrastructure

| Feature | Status | Effort | Notes |
|---|---|---|---|
| Resend integration | New | Low | Production email service. Milestone notifications, memory prompts, network relay, renewal reminders. Replaces any Phase 0 temporary setup. |
| Network Directory + messaging | New | Medium | Filterable sortable table. Multi-select. Platform-mediated relay (no addresses exposed). 3 messages/24hr. Org Admin 10/day. |

### AI question system (Stage 5)

| Feature | Status | Effort | Notes |
|---|---|---|---|
| AI question system — types 1, 2, 3 | Pending | High | Deep history, middle history, living memory. Open-door model. Pre-generated nightly. |
| Nightly batch job | New | High | Supabase Edge Function + pg_cron. Delta detection, validation, staging review, question gen, banner assembly, cleanup. Midnight Pacific. Batch API. |
| Admin console (admin.html) | New | Medium | Content staging. Conversational + paste-and-parse + review queue. Tiered promotion. No forms. |
| Milestone notifications — birthday month emails | Pending | Low | Start of birth month. Opt-in. Resend. |
| Memory prompts — gap emails | Pending | Low | Weekly/monthly. Opt-in. Resend. |

### Stickiness and engagement (Stage 5)

| Feature | Status | Effort | Notes |
|---|---|---|---|
| The Current — activity feed | Gap | Medium | Live network event feed. Last 20 events. Single-tap reaction. Needs spec pass before build. |
| Legacy Q&A — The Pulse | Gap | Medium | Specific questions to named Conductors. Answers convertible to structured data. Elder-first. PULSE_QA table. Needs spec pass. TIME-SENSITIVE. |
| Conductor Profiles — living biography | Pending | Medium | Self-authored narrative. First person. VisibleTo-filtered. |
| Accomplishments Feed | Pending | Low | Light celebration. Non-milestone wins. Network reacts. |
| Question Board | Pending | Medium | Crowdsourced data completion. Feeds EngagementScore. |
| Platform feedback — "What else would you like?" | New | Low | AI question type 6. Once per 90 days. Routes to PLATFORM_FEEDBACK table. Themed response options. |
| Upcoming features teaser banner | New | Low | Rotating emotional previews of planned features. Bottom of dashboard. Very slow rotation. Non-interactive. |

### Academic Partnership Features (Stage 6b — quick wins)

| Feature | Status | Effort | Notes |
|---|---|---|---|
| Comparative Vocabulary Tool | New | Low | One query + display page. Uses existing CULTURAL_VOCAB_LIBRARY. Side-by-side cross-cultural kinship terms by relationship type. Powerful teaching artifact. |
| Oral History Designation | New | Low | One field group on story records + citation formatter. Makes ECO story capture formally citable. Connects to Bancroft, Smithsonian, JANM oral history methodology. |
| Teaching Mode | New | Low–Med | Event Guest Window + TeachingNote field overlay + teaching landing page. Living primary source for classroom use. |
| Migration Arc Export (anonymized) | New | Low | Consent toggle + GeoJSON/CSV formatter. Strips all PII. Consented real diaspora data for classroom mapping. |
| Student Contribution Tracker | New | Low | Institution/course fields on vocab review + printable contribution summary. Documents community engagement credit. |



| Feature | Status | Effort | Notes |
|---|---|---|---|
| Stripe — Conductor + Pro tiers | Pending | Medium | $5.99/$8.99. No auto-renewal. 60-day trial. Sponsor model. Household billing. |
| GDPR/COPPA — legal docs live | Pending | Medium | Termly or Legalmattic. Cookie consent. Age gate. START LEGAL REVIEW DURING PHASE 0 — do not wait. |
| My Data page | Pending | Low | Always accessible regardless of billing. GEDCOM + JSON export. |
| Erasure / opt-out flow | Pending | Medium | 30-day SLA. All tables covered. |
| Referral tracking — retroactive credits | Pending | Medium | Build immediately before Stripe goes live. |
| Block / mute | Pending | Low | Per-Conductor content control. |

### Network growth (Stage 6)

| Feature | Status | Effort | Notes |
|---|---|---|---|
| New network creation | Pending | Medium | Public onboarding. Network naming from curated list. |
| Moderator nomination workflow | Pending | Low | Peer-nominated. 90-day eligibility. |
| Keeper designation + KeeperTitle | Pending | Low | Network Owner nomination only. Community-defined title. |
| Event Guest Window | Pending | Medium | Pro Conductor. Shareable link, time-limited read-only milestone view. |

### AI depth (Stages 6b + 7)

| Feature | Status | Effort | Notes |
|---|---|---|---|
| AI Triangulation — Tier 3 (social only) | Pending | Medium | "Were you near [person]?" PROXIMITY_NOTES written on answer. |
| Discovery Banner — feedback controls | Pending | Medium | AlreadyKnew + WantLess. BANNER_FEEDBACK writes. Topic pills in Phase 2. |
| USER_PREFERENCES — migrate to Supabase | Pending | Low | From localStorage to DB when auth is wired. |
| AI question — type 4 (cultural contribution) | Pending | Medium | Free-text field. Submitted to DISCOVERY_CARDS as Draft. 30-day limit. |
| AI question — type 5 (sensitivity layer) | Pending | High | Jurisdiction detection. Conductor-level flags. |
| Keeper tools | Pending | Medium | KEEPER_TEACHINGS write. Pinned annotations. Teaching Moments. |
| Data export — GEDCOM + JSON | Pending | Medium | After billing is stable. GEDCOM is finicky — no urgency before Stripe settled. |

---

## PHASE 2 — ORGANIZATIONAL PUSH
Gate: Phase 1 stable + ≥1 CA tribal partner confirmed. ~15 sessions.

### Deferred from Phase 1

| Feature | Status | Effort | Notes |
|---|---|---|---|
| Legacy View — full implementation | Pending | Very high | Three scoring dimensions. GLSL shaders. Delta-triggered caching. Living vs Passed sky quality. Revenue must be flowing. |
| AI Triangulation — Tier 1 + Tier 2 | Pending | High | Region question + landmark anchor. Full landmark library required first. |
| Discovery Banner — full algorithm | Pending | Medium | WantLess weighting. Topic focus pills. BANNER_FEEDBACK drives rotation weights. |

### Organizational

| Feature | Status | Effort | Notes |
|---|---|---|---|
| Org Admin tier — billing + seat management | Pending | High | $14.99/mo. Founding partner pricing (first 10 orgs, permanent). |
| Org Admin dashboard | Pending | Medium | Health metrics, login activity, seat allocation. |
| Tribal vocabulary seeding — 4 CA tribes | Pending | Medium | 8 terms each. RestrictedFlag workflow. Tribal confirmation required. Graton, Cache Creek, Thunder Valley, Sky River. |

### Content and cultural depth

| Feature | Status | Effort | Notes |
|---|---|---|---|
| Cultural trauma content — AI question templates | Pending | Medium | Partition 1947, Japanese American internment, Trail of Tears. Gentle framing. Not surfaced randomly. |
| Journey Replay | Pending | Medium | Shareable animated globe arc. Extension of arc system built in Phase 0. |

### Platform content

| Feature | Status | Effort | Notes |
|---|---|---|---|
| Living Archive Designation | Pending | Medium | Formal oral history archive frame for tribal / diaspora / academic networks. NEH/IMLS grant-eligible. Public archive URL + methodology statement + academic citation format. |
| /demo — test drive with fictional family | Pending | Medium | South Asian diaspora + Japanese American + Pacific Islander + Native American. No time limit. One conversion prompt. |
| Partner affiliate model | Pending | Low | User-prompted only. ECO speaks. No tracking pixels. Referral signal only. |

---

## PHASE 3+ — PREMIUM AND SCALE
Gate: Phase 2 stable. Revenue flowing.

| Feature | Effort | Notes |
|---|---|---|
| Time Capsule | Medium | Write to a future recipient + date. Platform delivers. Permanent archive. |
| Functional Kitchen | Medium | Shared family recipe archive. 'Found' recipes locked permanently. |
| Global Expedition Log | Medium | Travel footprint on the globe. Photo + city + one line. |
| Workshop / Studio | Medium | Elder skill documentation. Ongoing projects. Progress photos. |
| Kinetic Ledger | Medium | Permanent joint family decisions. Double-signed. Immutable. |
| Circuit Sprints | Medium | Short-term collaboration rooms with hard deadline. Archives to Kinetic Ledger. |
| Legacy View descendant constellation | High | Downstream view from a passed Conductor. |
| Vocabulary skins | Low | Cultural theme overlays. Community-defined. |
| Print / Export products | Low | Partner redirect. 1 free per year for Pro Conductor. |
| Mobile app | Very high | Post-revenue. Separate project. Voice input bundled here. |
| Voice input | Medium | Microphone in network console. Browser Web Speech API + Deepgram. Custom vocabulary hints. |
| National tribal expansion | Very high | Oklahoma, Washington, Minnesota, Wisconsin, Michigan, Arizona. Sequential. ~2 months per state after Oklahoma. |

---

## OPEN SPEC ITEMS (need pass before build)

1. **The Current — activity feed** (Phase 1, Stage 5)
   In original design, not yet in active spec. Needs: Activity_Log table spec, feed rendering spec, reaction model.

2. **Legacy Q&A — The Pulse** (Phase 1, Stage 5)
   In original design, not yet in active spec. Needs: PULSE_QA table finalized, question submission flow, answer conversion to structured data flow. TIME-SENSITIVE — elders first.

3. **Platform feedback question — type 6** (Phase 1)
   New this session. Needs: PLATFORM_FEEDBACK table in schema, response theme taxonomy, 90-day frequency logic.

4. **Upcoming features teaser banner** (Phase 0 dashboard)
   New this session. Needs: content list written, rotation spec, placement spec on dashboard.

---

## PHASE REORDER NOTES
*(Use this space when reviewing the printed list)*





---

### Waitlist Capture

| Feature | Status | Effort | Notes |
|---|---|---|---|
| Waitlist — mailto bridge | New | Low | Pre-launch. Opens pre-filled mailto. Zero infrastructure. Replace at Phase 0 launch. |
| Waitlist — Conversational capture | New | Medium | Claude API modal. No form tags. Collects: name, email, intent (Join/Create), network name or family note. Writes to WAITLIST table. Confirmation + admin notification via Resend. FamilyNote is the highest-value marketing insight field. |


---

### Keeper Activation Ceremony + Cross-Network Sharing

| Feature | Status | Effort | Notes |
|---|---|---|---|
| Keeper activation ceremony | New | Low | Full-screen acknowledgment moment before permissions granted. Platform speaks first. Single tap to proceed — "I understand the responsibility." Not a dialog. Not a form. A moment. |
| Keeper cross-network sharing ask | New | Low | Immediately after ceremony. Optional. Item-by-item consent model. Categories: vocabulary, annotations, teaching notes, traditions. Per-item prompt on each future submission. Two-response only: "Yes, open to it" or "Not right now." 90-day re-ask if declined, then never again unless manual opt-in. |
| KEEPER_SHARING_PREFS table | New | Low | Schema table. Tracks preferences, decline timestamp, re-ask timestamp, manual opt-in flag. |
| Keeper vocabulary contribution flow | New | Medium | When Keeper submits vocab term with ShareVocab=TRUE, per-item prompt appears: "Share with the community?" or "Keep in our network only." Approved items enter CULTURAL_VOCAB_LIBRARY with anonymous attribution: "Contributed by a community Keeper." Named attribution available on explicit request only. |

