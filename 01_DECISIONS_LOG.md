# ECO Decisions Log — Locked Decisions Only
**Format:** Decision | Date locked | Notes
**Rule:** One line per decision. No rationale. For rationale see archive.

---

## BRAND & PHILOSOPHY
- Brand colors locked: Blue #00AAFF (ETERNAL/inputs), Green #00CC44 (CURRENT/outputs), BG #080D14 | Early 2026
- Typography: Arial Black 900 throughout | Early 2026
- Wordmark Direction C: ETERNAL small above, CURRENT large below, same width | Early 2026
- Platform philosophy: Individualist. No fate, no destiny, no afterlife. Present moment is what matters | Early 2026
- ECO is self-centered — every Conductor sees themselves at the center, never a leaf | Early 2026

## TECH STACK
- Production DB: Supabase (PostgreSQL UTF-8). Google Sheets = retired POC | March 2026
- Hosting: Vercel. Domain/email: Cloudflare. Version control: GitHub | March 2026
- Frontend: Plain HTML/CSS/JS. No framework | March 2026
- Visualization: Three.js r128 + custom GLSL shaders | March 2026
- AI portal in-app: claude-haiku-4-5-20251001 via Anthropic API | March 2026
- Globe textures: LOCAL /textures/ only. Never CDN | March 2026
- Web only at launch. No native app until post-revenue | March 2026
- Email-only signup. No phone number required | March 2026
- Full Unicode/UTF-8 support from Phase 0. Non-Latin scripts natively supported | March 2026

## DATA MODEL
- Birth dates: MM/YYYY only. Day never stored | Early 2026
- DisplayLabels: Conductor-defined freeform. System never overwrites | Early 2026
- VisibleTo: per-row scoping. Isaiah BioParent = Network Owner only | Early 2026
- Two-layer relationship system: structural RelationType (DB) + Conductor DisplayLabel | Early 2026
- Cultural exclusion: server-side only, silent, never exposed to any user | Early 2026

## ROLES & PERMISSIONS (7 roles)
- SuperUser / Network Owner / Moderator / Keeper / Conductor / User / Guest | March 2026
- Moderator = permission layer on Conductor account. No added cost | March 2026
- Keeper = permission layer on Conductor account. No added cost. Added visibility only | March 2026
- Founder = permanent designation on Conductor account. No price premium | March 2026
- No single network owner — network belongs to all Conductors collectively | March 2026
- Org Admin = $14.99/mo. Org networks only. Health dashboard, seat mgmt, analytics | March 2026
- Keeper title is community-defined (Elder, Granthi, Sensei, Storyteller, etc.) | Early 2026
- Max 2 Keepers per network | Early 2026
- Keeper Score: behavioral metric, never shown as number, visible only in Legacy View arc shape | March 2026

## PRICING (LOCKED March 2026)
- Conductor: $5.99/month | March 2026
- Pro Conductor: $8.99/month | March 2026
- Org Admin: $14.99/month | March 2026
- Annual billing discount ~17% (pay 10, get 12 equivalent) | March 2026
- No auto-renewal. User makes deliberate choice each period | March 2026
- No cancellation fee. Ever | March 2026
- No refunds mid-commitment period (monthly = 1 month, annual = 12 months) | March 2026
- Freeze not delete: cancelled accounts preserved indefinitely unless explicit deletion request | March 2026
- Explicit deletion = user navigates to specific flow, confirms irreversibility | March 2026

## INSTITUTIONAL/TRIBAL PRICING
- Founding partner pricing: first 10 orgs nationally | March 2026
- Founding partner: seats 1-100 = $3.00/mo (50% off), seats 101-200 = $4.49/mo (25% off) | March 2026
- Founding partner pricing is PERMANENT for those 10 orgs — no 12-month expiry | March 2026
- Org billing: single invoice to organization. Members do not receive individual invoices | March 2026
- Org Admin seats charged separately at $14.99/mo, not counted against seat tiers | March 2026
- Lapsed org subscription: freeze 90 days, then freeze indefinitely. Rechargeable anytime | March 2026
- Org deletion requires formal written organizational request | March 2026

## NETWORK PERSISTENCE
- Network never deleted due to any one person's lapse, passing, or departure | March 2026
- If Founder lapses: network continues with existing Moderators | March 2026
- If last Moderator lapses: network continues, awaiting new Moderator nomination | March 2026
- Network inheritance: Founder can designate successor before it's needed | March 2026

## TRIAL & ONBOARDING
- 60-day penalty-free trial | Early 2026
- WOW before wallet: globe, constellation, AI question visible before any payment prompt | March 2026
- Renewal reminder at 14 days before expiry (not 30) | March 2026
- Secondary renewal notification: opt-in for family member to receive billing reminders | March 2026
- No auto-renewal = renewal reminder is platform's responsibility | March 2026

## PARTNER MODEL
- No advertising on platform. Ever. Architectural, not policy | March 2026
- Partner services: user-prompted only. ECO speaks, partner never appears on ECO pages | March 2026
- Partner redirect: new tab only. No partner tracking pixels on ECO pages | March 2026
- No user data shared with partners without explicit consent | March 2026

## UX PRINCIPLES
- Google homepage principle: one primary element (AI question) post-login. Everything else subordinate | March 2026
- AI drives the UX: question selection logic drives page context, not the other way around | March 2026
- Uncluttered UI: every element earns its presence or doesn't appear | March 2026
- Privacy statement: visible on home page AND user landing page. Minimal, not buried | March 2026
- No disconnected media: every upload connected to at least the uploader at time of entry | March 2026
- Cancellation as easy as signup: same number of clicks | March 2026
- Stories connected to profiles directly: no independent media library | March 2026
- Passed designation: requires two-step confirmation + 7-day dispute window | March 2026

## LANDING PAGE & DEMO
- Landing page: live globe + constellation using representative data. Not screenshot — actual engine | March 2026
- Globe on landing page responds to visitor's geographic location (city-level orient) | March 2026
- Post-login dashboard: 3 miniature visualizations + AI question. Minimal else | March 2026
- Test drive at /demo: fully functional with diverse fictional family. No time limit | March 2026
- Test drive: "This is the [name] family. Yours is waiting." One persistent signup prompt | March 2026

## AI QUESTION SYSTEM
- Landing page AI question: one per visit, never repeated within 6 months for same person/angle | March 2026
- ETERNAL weighting: 70-80% questions about past/passed/historical, 20-30% about current | March 2026
- Four response options on every question (story / learn more / lateral knowledge / not now) | March 2026
- Micro-increment engagement scoring per AI interaction (.0000001 scale, varies by response type) | March 2026
- AI question sensitivity layer required before Phase 1: don't ask politically dangerous history Qs | March 2026
- Unanswerable questions shown as: "Nobody has answered this yet. This is where it belongs." | March 2026

## ENGAGEMENT & LEGACY SCORING
- Engagement Score: community-sourced, open to all contributors, no authority required | March 2026
- Historical engagement scores accumulate only — never decay | March 2026
- Temporal Distance Index: drives sky position in Legacy View (near vs. horizon) | March 2026
- Keeper Score: behavioral, never shown as number, reflects outward-facing + temporal reach | March 2026
- Score bands: 1-5, 6-10, 11-15, 16-20, 21+ (random range within band drives arc uniqueness) | March 2026
- Legacy Weight: any Conductor can propose, any Conductor can support — community-sourced | March 2026

## LEGACY VIEW
- Lightning metaphor: upward propagating arcs from origin Conductor at base | March 2026
- Rendered once per network state. Re-renders only on downstream delta events | March 2026
- Seeded deterministic randomness: same network state = same image. New delta = new seed | March 2026
- Distant/historical = amber/warm, diffuse cloud glow. Close/documented = blue-white, arc visible | March 2026
- Ground point (origin Conductor) = always most luminous element | March 2026
- Living Conductor sky: charged, unsettled atmosphere. Passed Conductor sky: resolved, settled | March 2026
- Arc color: blue-white = direct descendant, green = sponsored, amber = cultural vocab propagated | March 2026
- Faint diffuse glow (not clean arc) = VisibleTo-private profiles contributing to brightness | March 2026
- Keeper Score visible as lateral arc branching — high Keeper = wide not just tall | March 2026

## CULTURAL TRAUMA CONTENT
- Platform creates conditions for recovery. Never names wounds directly | March 2026
- AI question templates developed for pre-displacement period gaps (Partition, internment, etc.) | March 2026
- Cultural trauma widget library: separate tracked section, not surfaced randomly | March 2026
- Keeper role recognized specifically for trauma-preservation function in affected networks | March 2026

## DATA PORTABILITY
- Full data export available at any time — not gated behind cancellation | March 2026
- Export: Type A (user-created) = full content. Type B (own profile) = full. Type C (tagged in) = reference log only | March 2026
- 90-day preservation window after cancellation before any freeze | March 2026
- GEDCOM-compatible export for family structure data | March 2026

## DOCUMENT ARCHITECTURE (META)
- No file outputs during session. Zip only at end when requested | March 2026
- 13 active documents + archive folder | March 2026
- Archive never auto-loaded. Accessed by request only | March 2026
- 12_NEXT_SESSION_BRIEF.md regenerated fresh each session | March 2026

## VIABILITY SCORE
- Overall platform viability: 70.9% (revised from original 52.8%) | March 2026
- For target markets specifically (excl. cultural trauma sub-pop A): ~78-80% | March 2026
