# ECO Architecture Reference

---

## PRODUCTION TECH STACK (LOCKED)

| Layer | Tool | Purpose |
|---|---|---|
| **Database** | Supabase (PostgreSQL) | Production DB + Auth |
| **Hosting** | Vercel | Frontend deployment |
| **Domain/Email** | Cloudflare | DNS + email routing |
| **Version control** | GitHub | Source of truth |
| **Frontend** | Plain HTML/CSS/JS | No framework |
| **Visualization** | Three.js r128 + GLSL | Globe + Legacy View |
| **AI (in-app)** | Claude API (claude-haiku-4-5-20251001) | Network console |
| **Email** | Resend (production) | Transactional email + network messaging relay |

**Google Sheets + Apps Script = retired POC. Archived, not deleted. Never rebuild on it.**

---

## FILE STRUCTURE
```
EternalCurrent.Online/Website/
├── index.html              ← Landing page (pre-login)
├── dashboard.html          ← Post-login home
├── manifesto.html          ← Brand manifesto
├── globe-live.html         ← 3D globe visualization
├── network-console.html    ← AI conversation — ALL data entry happens here
├── auth.html               ← Magic link email entry only (one input, no form)
├── admin.html              ← Content staging + nightly job monitor (SuperUser only)
├── network-directory.html  ← Filterable sortable network table + messaging
├── /demo                   ← Test drive with fictional family (Phase 1)
├── css/
│   └── theme.css           ← ALL color/type tokens. Never hardcode hex.
├── scripts/
│   └── theme-selector.js   ← Floating theme pill
└── textures/               ← NASA Earth textures (LOCAL — required)
    ├── earth-day.jpg
    ├── earth-night.jpg
    ├── earth-clouds.png
    ├── earth-bump.jpg
    └── earth-spec.png
```

Note: entry-portal.html is retired as a concept. There is no entry portal.
All data entry — adding people, relationships, cities, milestones, stories,
cultural contributions, Keeper teachings — happens through network-console.html.
The People Directory (browsing and inline correction) lives in dashboard.html.

---

## CRITICAL RULES

1. **CSS variables always** — never hardcode hex colors, font names,
   font sizes, or font weights in any HTML file. Ever.
   theme.css is the single source of truth for ALL visual tokens.
   HTML files reference variables only: `var(--color-bg)`, `var(--font-size-body)`.
   Violation = the theme selector breaks that element.

2. **theme.css owns everything visual** — backgrounds, text colors,
   border colors, font family, font sizes, font weights, border radius,
   spacing scale, animation durations. If it affects how something looks,
   it lives in theme.css as a variable. Not in the HTML. Not in a
   `<style>` tag. Not inline. Only in theme.css.

See THEME SYSTEM SPECIFICATION below for full variable registry
and four-theme definitions.
2. **No frontend framework** — plain HTML/CSS/JS only
3. **textures/ must be LOCAL** — WebGL + CDN = CORS failure
4. **Local testing:** `python -m http.server 8080` — never open HTML from filesystem
5. **One theme at a time** — parallel theme work = blank renders
6. **One file per coding session** — Claude context is finite
7. **Schema 100% final before any code** — retroactive column additions are expensive
8. **Mobile-first UI from day one** — retrofitting is expensive
9. **Every session ends with test data** — bugs in-session cost nothing
10. **NO FORMS ON THE PLATFORM — EVER**
    Not a single `<form>` tag. Not a single submit button. Not a single
    visible labeled input field in the traditional sense.
    Every data input is one of four modes only:
    - Conversational AI exchange (the AI asks, the user answers,
      the AI writes structured data to the DB as a byproduct)
    - Single tap or toggle (saves immediately, no confirm step)
    - Live search bar (filters as you type, no submit)
    - File picker (single tap, immediate upload on selection)
    Auth exception: email then password as sequential prompts,
    no form tag, Enter advances. No submit button.
    Progressive save: every answer writes to DB immediately.
    Partial conversations preserved. AI resumes where it left off.
    Validation is conversational: "I didn't catch that — which
    city did you mean?" Never a red error message on a field.

---

## ENVIRONMENT VARIABLES (server-side only)
```
SUPABASE_URL                ← Project URL
SUPABASE_ANON_KEY           ← Public anon key (safe for client)
SUPABASE_SERVICE_KEY        ← Service key — NEVER client-side
ANTHROPIC_API_KEY           ← eco_claude_key — NEVER client-side
STRIPE_SECRET_KEY           ← Phase 1 GoLive — NEVER client-side
CLOUDFLARE_EMAIL_TOKEN      ← Email routing
```

---

## BRANCH STRATEGY
```
main    ← production (Vercel deploys from here)
dev     ← active development
```

---

## ARCHITECTURE RULES (PERMANENT)

1. **Email never in browser** — People_Master.Email excluded from all API responses
2. **robots.txt Disallow all portal pages** (/network-console, /entry-portal, /admin/*)
3. **Ghost Node filter:** `WHERE status != 'Placeholder'` (not `= 'Living'`)
4. **network_id on every DB row** from day 1
5. **/my-data accessible regardless of subscription status** — payment lapse never locks data access
6. **Erasure requests completed within 30 days** (GDPR)
7. **Passed profile 3-step confirmation:** stewardship → pets → lock
8. **DisplayLabel is Conductor-owned** — system never overwrites
9. **UTF-8 encoding specified everywhere** — Unicode support is native, don't break it
10. **Cancellation as easy as signup** — same click count

---

## GLOBE TECHNICAL DETAILS

**Three.js r128** + custom GLSL shaders

### Shader
```glsl
// Day/night terminator
smoothstep(-0.15, 0.20, cosAngle)

// UV fix — required or Earth renders upside-down
vec2 uv = vec2(vUv.x, 1.0 - vUv.y);
```

### Arc Colors (migration arcs — birth→current)
- Amber `0xE09040` — India origins
- Teal `0x40C8E0` — Fiji origins  
- Purple `0xAA66FF` — Pakistan origins
- White `0xC0C8D0` — other origins

### Dot Colors
- Blue `#00AAFF` — Birthplace
- Green `#00CC44` — Current home
- Purple `#AA66FF` — Passed members
- Pink `#FF6688` — Logged-in Conductor

### Globe Opening Position
On login → animate to Conductor's CurrentLoc → fallback to BirthLoc → fallback to network owner

```javascript
function latLngToVector3(lat, lng, R) {
  const phi   = (90 - lat)  * Math.PI / 180;
  const theta = (lng + 180) * Math.PI / 180;
  return new THREE.Vector3(
    -R * Math.sin(phi) * Math.cos(theta),
     R * Math.cos(phi),
     R * Math.sin(phi) * Math.sin(theta)
  );
}
```

### Data Loading (dual mode)
- Tries live Supabase first
- Falls back to embedded snapshot silently
- Status indicator: "Live · Supabase" or "Snapshot mode"

---

## AI PORTAL TECHNICAL DETAILS

**File:** network-console.html
**Model:** claude-haiku-4-5-20251001

### Required Headers
```javascript
{
  'Content-Type': 'application/json',
  'x-api-key': CLAUDE_KEY,
  'anthropic-version': '2023-06-01',
  'anthropic-dangerous-direct-browser-calls': 'true',
}
```

### Key Validation
Key must start with `sk-ant-` and be ≥ 30 chars.
Stored in localStorage as `eco_claude_key`.

---

## NIGHTLY BATCH JOB — ECO CONTENT PIPELINE

### Purpose
One job runs nightly at midnight Pacific Time. It pre-generates all
AI-dependent content for the following day so that every user
interaction is served from a pre-computed pool — not from a live
API call. The result: every AI-powered moment on the platform
feels instant. No user ever waits for generation.

### Schedule
Midnight Pacific Time (08:00 UTC in winter, 07:00 UTC in summer).
Implemented as a Supabase Edge Function triggered by a Supabase
pg_cron schedule.

Why midnight Pacific: the Lightning pilot network spans India,
Fiji, UK, Canada, NZ, and USA. Midnight Pacific is:
- 08:00 London (before UK morning logins)
- 13:30 India (after Indian afternoon lull)
- 20:00 Fiji
This window catches the lowest concurrent login activity across
all time zones in the network.

### Infrastructure
- **Trigger:** Supabase pg_cron (built-in scheduler)
- **Runtime:** Supabase Edge Function (Deno)
- **AI calls:** Anthropic Batch API — 50% discount, 24-hour
  return window (all content is ready well within the window)
- **Fallback:** If Batch API result not returned within 4 hours,
  fall back to standard API for that night's incomplete Conductors
- **Logging:** Every run writes to NIGHTLY_JOB_LOG (see schema)

### Job Sequence (runs in order, stops on fatal error)

```
00:00 PT  JOB STARTS — write NIGHTLY_JOB_LOG row, Status = Running

STEP 1 — DELTA DETECTION (DB only, no AI, ~2 min)
  For each network:
    Identify Conductors where LastDeltaAt > yesterday midnight PT
    These are "changed" Conductors — they get fresh content
    Conductors not changed in >7 days still get a pool refill
    if their PENDING_QUESTIONS pool < 3 or PENDING_BANNER_CARDS < 8
    Everyone else: skip (existing pool is sufficient)

STEP 1.5 — DATA VALIDATION PASS (DB only, no AI, ~5 min)
  See NIGHTLY VALIDATION RULES below.
  Writes to VALIDATION_LOG. Never modifies user data directly.
  Flags issues for human review or AI-assisted resolution.

STEP 1.8 — CONTENT STAGING AI REVIEW (Batch API, ~5 min to submit)
  See CONTENT STAGING AI REVIEW CRITERIA below.
  Reviews all CONTENT_STAGING rows where ReviewStatus = Pending.
  Each item gets one Batch API call with ContentType-specific criteria.
  Writes AIVerdict + AIVerdictNotes to CONTENT_STAGING.
  Writes detail to STAGING_REVIEW_LOG.
  Promotes Approved + non-Restricted items to production tables.
  Notifies admin of NeedsRevision and AwaitingConfirmation items.
  If no Pending items: step completes in seconds (no API calls).

STEP 2 — ENGAGEMENT SCORE RECALCULATION (DB only, ~5 min)
  For each Conductor in any active network:
    Sum story contributions, Keeper annotations, media tags,
    DisplayLabel assignments, milestone creations (all weighted)
    Update EngagementScore in People_Master
    Note: scores only increase — never decay (per spec)
    Update TemporalDistanceIndex for each changed Conductor

STEP 3 — QUESTION GENERATION (template-first, Batch API fallback)
  For each Conductor needing fresh questions:
    Query their network — passed profiles, sparse records,
    relationship structure, cultural contexts

    For each question slot to fill:
      ATTEMPT TEMPLATE MATCH FIRST:
        Query QUESTION_TEMPLATES with all matching criteria:
          QuestionType, CulturalContext, Era, GenerationalPattern,
          SubjectStatus, RequiredFields, ExcludedIfFields
        If match found:
          Fill {slots} from DB (names, DisplayLabels, cities)
          Write to PENDING_QUESTIONS, GenerationMethod = TemplateMatch
          Increment QUESTION_TEMPLATES.TimesUsed
          Cost: zero AI tokens

      IF NO TEMPLATE MATCH:
        Generate via Batch API
        Write to PENDING_QUESTIONS, GenerationMethod = AIGenerated
        Flag TemplateCandidate = true if same pattern seen for 3+
        Conductors this run (queue for human review as future template)
        Cost: ~4,000 input + 400 output tokens per question

    Target: 3–5 questions per Conductor
    As template library grows, AI fallback rate drops toward zero

STEP 4 — BANNER CARD ASSEMBLY (mix of DB + Batch API, ~15 min)
  For each Conductor whose pool < 8 Ready cards:

  TEMPLATE CARDS (no API cost — assembled from DB):
    NetworkFact cards: SKIPPED — always live from DB at display time
    Vocabulary cards:
      Query CULTURAL_VOCAB_LIBRARY filtered to network's CulturalContext
      Find who in the network matches StructuralType
      Assemble CollapsedText + ExpandedText from templates
      Insert viewer's DisplayLabel for matching person
      Write to PENDING_BANNER_CARDS, GenerationMethod = TemplateAssembled
    Milestone cards:
      Query MILESTONES where ShareWithNetwork = true
      and DateMM_YYYY within 30 days of today
      Assemble from template: "[FirstName] · [MilestoneType]"
      Write to PENDING_BANNER_CARDS, GenerationMethod = DBQuery

  AI-GENERATED CARDS (Batch API — only when no pre-written card matches):
    Historical/Discovery cards:
      Query DISCOVERY_CARDS with full tag matching:
        CulturalContext, RelatedCity, Era, Theme, GenerationalPattern
        filtered to content not yet shown to this Conductor
        RequiresPersonMatch = TRUE → verify matching person exists
        SensitivityFlag = FALSE (until Phase 2)
        ORDER BY TimesShown ASC (surface least-shown first)
      If matching cards exist: fill {person_name} slot from DB.
        GenerationMethod = TemplateAssembled. Zero AI cost.
      If no matching card exists AND Conductor has a cultural
        context not yet covered in DISCOVERY_CARDS:
        Generate a new card via Batch API.
        Write to DISCOVERY_CARDS as Platform content (Status = Active).
        This new card is now available to ALL networks with that
        cultural context — permanent compounding value.
        GenerationMethod = AIGenerated.
    Target: as DISCOVERY_CARDS library grows, AI generation rate
    drops. Each new card permanently reduces future AI costs.

STEP 5 — STALE CONTENT CLEANUP (DB only, ~2 min)
  Mark PENDING_QUESTIONS as Stale where:
    NetworkContentHash != current hash for SubjectUserID
    (The person the question is about has changed significantly)
  Purge PENDING_QUESTIONS where PurgeAfter < today
  Purge PENDING_BANNER_CARDS where PurgeAfter < today
  Purge BANNER_FEEDBACK where CreatedDate < 90 days ago
  Flag PHOTOS where PurgeAfter < today → delete from Supabase Storage
  Update NIGHTLY_JOB_LOG: Status = Completed, all counts, cost estimate

00:15–00:30 PT  JOB TYPICALLY COMPLETE
```

### Delta Trigger (outside of nightly schedule)
If any Conductor's PENDING_QUESTIONS pool drops below 3 Ready
questions (e.g. they logged in multiple days in a row and consumed
the pool), a Delta Trigger fires immediately using the standard
API (not Batch — needs to be ready within minutes, not 24 hours).
This is a rare edge case. The nightly job prevents it for most users.

### Cost Model
At 500 Conductors:
- Step 3 (questions): ~50–100 Conductors need fresh questions/night
  Each needs 3–5 questions × ~4,000 input + 400 output tokens
  = ~50 Conductors × 4 questions × 4,400 avg tokens × Haiku rate
  = ~$0.10–0.20/night at Batch API pricing (50% discount)
- Step 4 AI cards: ~50 Conductors × 6 AI cards × 3,200 avg tokens
  = ~$0.05–0.10/night at Batch API pricing
- Total nightly AI cost at 500 Conductors: ~$0.15–0.30/night
  = ~$5–10/month
- At 5,000 Conductors: ~$50–100/month

### Failure Handling
- NIGHTLY_JOB_LOG records all errors in ErrorLog (JSON)
- Partial success: a Conductor whose content failed generation
  gets flagged for retry in next night's run
- If the job fails entirely: existing pools serve users normally.
  The pool is designed to last 2–3 days without refill.
  Users experience no degradation unless the job fails 3+ nights.
- Alert: send to data@eternalcurrent.online if Status = Failed
  or if EstimatedCostUSD exceeds $50 in a single run (cost spike alert)

### What the Nightly Job Does NOT Do
- Does not send any user-facing emails (separate email job)
- Does not modify user data or profiles
- Does not write to Relationships_Linker or People_Master
  (except LastDeltaAt and NetworkContentHash — read-only otherwise)
- Does not run Legacy View renders (those are delta-triggered
  separately when a network state change occurs)
- Does not process payment or billing operations

---

## CONTENT STAGING AI REVIEW CRITERIA

Runs as Step 1.8 of the nightly batch job. Uses Batch API for
efficiency — all staged items submitted in one batch request.
The AI reviewer is given each item's StagedContent JSON plus
AdminNotes, and evaluates against the criteria below.

### What the AI reviewer checks — and does not check

**AI checks (structural and stylistic):**
- Field completeness against the ContentType's required fields
- Character limits (CollapsedText ≤ 120, ExpandedText ≤ 400)
- Slot syntax validity in QuestionTemplates ({slots} are recognised)
- NuanceNote presence for any term that appears in TERM_CONFLICT_REGISTRY
- Tone consistency — warm, conversational, never clinical or academic
- RequiredFields / ExcludedIfFields logical coherence
- Tag completeness (Theme[], Era[], ContentDepth all present)
- CollapsedText reads as a genuine hook sentence, not a title
- ExpandedText can stand alone without CollapsedText

**AI does not check (human responsibility):**
- Cultural accuracy of vocabulary terms — only a speaker or
  Keeper from that culture can confirm this
- Whether a tribal term is sacred or restricted — only the
  tribe can confirm this (hence ConfirmedByContact requirement)
- Whether a historical fact is accurate — admin cites SourceReference;
  accuracy is the admin's responsibility
- Whether a term "feels right" to speakers of that culture —
  that is what Keepers are for

**The AI is explicit about this distinction in its verdict notes.**
A vocab term submitted without NuanceNote gets: "NuanceNote missing —
add cultural nuance before promoting." That is an AI-checkable issue.
A term submitted with a SourceReference of "native-languages.org" gets
a note: "SourceReference present — cultural accuracy not verified by AI.
Ensure tribal confirmation obtained if RestrictedFlag should be TRUE."

---

### Review criteria by ContentType

**Vocab review checklist:**
- CulturalContext is populated
- StructuralType is a recognised value from the StructuralType vocabulary
- Term is populated and non-empty
- Description is at least 20 characters and does not start with
  the term itself ("Nana is..." → flag: "Description should not
  open with the term. Reframe as what it means.")
- NuanceNote populated IF Term appears in TERM_CONFLICT_REGISTRY
- NuanceNote populated IF StructuralType implies older/younger
  distinction (Sibling_Elder, Sibling_Younger, Cousin, etc.)
- Romanization present if Term is non-Latin script
- At least one Theme[] value
- At least one GenerationalPattern[] value
- SourceType is one of: Academic / Tribal / Community / Self_Reported
- If SourceType = Tribal: check that RestrictedFlag = TRUE
  (flag if not — tribal content requires confirmation)
- Tone: Description and NuanceNote do not use clinical or
  overly formal language. Flag: "Reads like a dictionary entry
  — reframe in the voice of someone explaining to family."

**DiscoveryCard review checklist:**
- CollapsedText ≤ 120 characters
- CollapsedText reads as a hook sentence — not a topic title,
  not a question, not a statement that gives away the content
- ExpandedText ≤ 400 characters
- ExpandedText is 2–4 sentences
- ExpandedText does not use markdown or HTML
- ExpandedText does not open with a year or date
  (flag: "Opens with date — reframe. The historical weight should
  land after the human connection is made.")
- CulturalContext[] or RelatedCity[] is populated (not both null)
- At least one Theme[] value
- At least one Era[] value
- ContentDepth is set
- RequiresPersonMatch = TRUE if CollapsedText or ExpandedText
  contains {person_name} — flag if mismatch
- SensitivityFlag = TRUE if ContentDepth = Deep AND Theme[]
  includes Displacement, Grief, or Trauma
- Tone: warm, curious, never lecture-like. Flag if sentences
  feel like a Wikipedia excerpt.

**QuestionTemplate review checklist:**
- QuestionType is 1–5
- QuestionText is a genuine question (ends with ?)
- All four ResponseOptions are populated
- All {slots} in QuestionText and ResponseOptions are from
  the recognised slot vocabulary:
  {person_name}, {display_label}, {city}, {relationship},
  {birth_year}, {cultural_context}, {network_name}
- Flag any unrecognised slot: "Unknown slot {X} — not in
  recognised vocabulary. Rename or remove."
- At least one GenerationalPattern[] value
- SubjectStatus[] is populated
- RequiredFields is logical — flag if a slot used in
  QuestionText requires a field not listed in RequiredFields
  (e.g. uses {city} but BirthLoc not in RequiredFields)
- ContentDepth is set
- QuestionText does not name a specific person (questions
  must be template-generic, not person-specific)
- Tone: the question sounds like something a thoughtful person
  would actually ask at a family gathering. Flag if clinical.
- Non-assumption check: the question does not assume the viewer
  was invited, will attend, has a specific ceremonial role,
  knows a particular tradition, or has any relationship quality
  beyond the structural label recorded in the network.
  Questions that begin from assumed involvement rather than
  asking about it are flagged: "This assumes [X]. Reframe as
  a question about whether [X] applies."

**TermConflict review checklist:**
- Both Culture1 + Meaning1 + StructuralType1 are populated
- Both Culture2 + Meaning2 + StructuralType2 are populated
- The Term does not already exist in TERM_CONFLICT_REGISTRY
  (flag duplicate: "Term already registered. Review existing
  entry — add Culture3 field if this is a third conflict.")
- StructuralType1 and StructuralType2 are recognised values
- Notes field populated with context for validators

---

### Admin notification after review

After Step 1.8 completes, the nightly job sends a summary
to data@eternalcurrent.online:

```
Nightly content staging review — [date]

Reviewed: [N] items
Approved and promoted: [N]
Awaiting tribal/community confirmation: [N]
Needs revision: [N]
  - [StagingID]: [brief AIVerdictNotes summary]
Rejected: [N]
  - [StagingID]: [reason]

Total AI tokens used for review: [N] input / [N] output
Estimated cost: $[X]
```

Plain text email. No links. No attachments. Admin reviews in
the admin console where full detail is available.

---

## NIGHTLY VALIDATION RULES

Runs as Step 1.5 of the nightly batch job. Pure DB reads and flag
writes — never modifies user data. All findings go to VALIDATION_LOG.

### Principle
The platform trusts the user. A Conductor who calls their maternal
grandfather "Nana" is not wrong — that is their word. Nana means
maternal grandfather in Hindi. In English, Nana often means
grandmother. In some families it means something else entirely.
The platform never corrects this. It flags ambiguity for human
context — a Keeper, a Moderator, or the Conductor themselves — to
resolve conversationally.

Validation is not enforcement. It is intelligence. The output of
the validation run is a richer understanding of where the data
needs attention, surfaced through the AI at the right moment.

---

### Category 0 — Inherited label integrity

**What it is:**
A DisplayLabel with DisplayLabelSource = Inherited points to a
DisplayLabelOriginID — the relationship row where the label was
first established. Over time that origin row may be deleted,
the origin person may have passed, or the chain may have broken.

**Checks:**
- DisplayLabelSource = Inherited but DisplayLabelOriginID = null
  Severity: Info. Surface to AI: "You call [target] '[label]' —
  do you know who in the family used that name first?"
  Answer populates DisplayLabelOriginID.

- DisplayLabelOriginID points to a relationship where the
  SubjectID has Status = Passed or Status = Deleted
  Severity: Info. Not an error — inherited labels survive the
  person who originated them. This is the point.
  Lightning network example: Amit (AB-STAR) passed. He was one
  of the two people who originated the "Bhayia" label for Vikas.
  The label continues — Isaiah and others still use it.
  The validation run notes this as context for the AI question pool:
  "The label 'Bhayia' for Vikas was partly established by Amit,
  who has passed. Would you like to record anything about that?"

- DisplayLabelOriginID is a broken FK (row no longer exists)
  Severity: Warning. Flag for Moderator review.

**What the validation run never does:**
It never questions whether a label is "correct" for a structural
relationship. Bhayia for an uncle, Jij for a wife's elder sister,
Nana for a grandmother — these are all valid. The platform does
not arbitrate family language. It preserves it.

---

### Category 1 — Vocabulary term conflicts

**Cross-language phonetic collision:**
Terms that share a phonetic root across cultural contexts but mean
different things are flagged when a Conductor has used one as a
DisplayLabel and the structural relationship doesn't match the
term's StructuralType in the library.

Examples requiring NuanceNote and disambiguation:
- Nana: Hindi = maternal grandfather (Grandfather_Maternal)
  English colloquial = grandmother (either)
  Punjabi variant = sometimes used interchangeably with Nanu
- Nani: Hindi = maternal grandmother (Grandmother_Maternal)
  Must not be confused with Nana
- Dada: Hindi = paternal grandfather (Grandfather_Paternal)
  Bengali = elder brother
  English colloquial = grandfather (either)
- Dadi: Hindi = paternal grandmother (Grandmother_Paternal)
- Baba: Hindi/Urdu = father OR grandfather (context-dependent)
  Turkish = father
  Multiple Slavic languages = grandmother
- Mama: Hindi = maternal uncle (Uncle_Maternal)
  English = mother
  Swahili = mother
- Chacha: Hindi = paternal uncle (Uncle_Paternal)
  Urdu = same
- Nunu, Nunu, Nana: Fijian-Indian variants (multiple meanings)

**Validation check:**
For each Conductor who has a DisplayLabel matching a known
cross-cultural collision term, check whether the structural
relationship (RelationType in Relationships_Linker) matches
the CulturalContext-specific StructuralType for that term.
If mismatch: write to VALIDATION_LOG as TermConflict.
Do not change anything. Surface to AI question pool:
"You call [person] '[DisplayLabel]' — in your family, does
that mean [StructuralType A] or [StructuralType B]?"

**Missing NuanceNote check:**
Any CULTURAL_VOCAB_LIBRARY term known to have cross-cultural
collision risk (flagged in a separate TERM_CONFLICT_REGISTRY
table — see schema) that has NuanceNote = null:
Write to VALIDATION_LOG as MissingNuance. Notify platform admin.

---

### Category 2 — Relationship timeline plausibility

**Parent born after child:**
Flag any relationship where ParentID person's BirthMonthYear
is later than ChildID person's BirthMonthYear.
Severity: Error. Write to VALIDATION_LOG. Notify Moderator.

**Parent implausibly young at child's birth:**
Flag if parent was under 12 or over 75 at child's birth.
Under 12: Severity Error.
Over 75: Severity Warning — unusual but possible (adoption,
late parenthood, data entry error). Surface to AI for context.

**Sibling born before stated parent:**
Flag if a sibling's birth year predates a shared parent's
birth year.
Severity: Error.

**Spouse age gap > 40 years:**
Severity: Info only — surface to AI as gentle context check.
"We have [Person A] and [Person B] listed as partners —
there's quite a gap in their birth years. Does that look right?"
Never flag to Moderator. Conductor-only visibility.

**Passed date before birth date:**
Flag if PassedMonthYear is earlier than BirthMonthYear.
Severity: Error.

---

### Category 3 — Network structural integrity

**Orphaned profiles:**
Profiles with network_id = lightning-001 (or any network) but
zero rows in Relationships_Linker as either SubjectID or TargetID.
Severity: Warning. These are probably incomplete entries.
Surface to AI: "We have [person] in your network but no
relationships mapped yet. Would you like to add those now?"

**Circular parent relationships:**
A → parent of B → parent of A.
Severity: Error. Flag for Moderator review.

**Duplicate profile candidates:**
Two profiles in the same network with:
  - Same FirstName + LastName + BirthMonthYear (within 2 years)
  - OR same FirstName + BirthLoc + similar BirthMonthYear
Severity: Warning. Surface to AI: "We may have two entries for
the same person — [Person A] and [Person B] look similar.
Are they the same person?"

**VisibleTo inconsistency:**
A relationship row marked VisibleTo = 'owner' where the owner
UserID does not match any active Conductor.
Severity: Warning.

---

### Category 4 — Content database integrity

**DISCOVERY_CARDS missing required tags:**
Any Active card missing CulturalContext (when not null-intended),
Theme[], Era[], or ContentDepth.
Severity: Warning. Card demoted to Draft until fixed.

**QUESTION_TEMPLATES with broken slot references:**
Any Active template containing a {slot} that is not in the
recognised slot vocabulary.
Severity: Error. Template demoted to Draft until fixed.

**PENDING_QUESTIONS pointing to deleted profiles:**
Any Ready question where SubjectUserID no longer exists or
has Status = Deleted.
Severity: Error. Mark question Stale immediately.

**PENDING_BANNER_CARDS with broken person references:**
Any Ready card where RequiresPersonMatch = TRUE but the
referenced UserID no longer exists or is no longer visible
to the target Conductor.
Severity: Error. Mark card Expired immediately.

---

### Category 5 — Data completeness signals

These are not errors. They are gaps that are valuable as
conversation starters (per platform design). They are tracked
so the AI can surface them at the right moment — not to
pressure users, but to invite them.

**Tracked signals (written to VALIDATION_LOG as Info only):**
- Profile with no BirthLoc
- Profile with no BirthMonthYear
- Profile with no CurrentLoc
- Profile with no Origin
- Profile with Status = Passed and no PassedMonthYear
- Profile with no relationships mapped
- Relationship with DisplayLabel = null (system default used)
- Profile photo missing for a passed member who has been
  in the network > 90 days (gentle prompt opportunity)

These are never shown to the user as warnings or missing fields.
They feed the AI question system: "Your grandmother Leela Datta —
do you know roughly what year she was born?"

---

### Validation run output

All findings write to VALIDATION_LOG (see schema).
No user data is modified.
Error-severity findings notify the network Moderator (or Network
Owner if no Moderator exists) via the platform notification system.
Warning-severity findings feed the AI question pool.
Info-severity findings feed AI questions at low priority.

---
```
Globe read: https://script.google.com/macros/s/AKfycbwMwGJkx9Bw835uNe9r33Fwngxd9gQqmLxi2bP0e9o6fi6ljRSpwAYqkxNUML6obB4fSA/exec
Network console write: https://script.google.com/macros/s/AKfycbyTTLmITxQh9BwN87E_exKPGS5FSSdmU7MJkXd3IC2hsmXxSiHnoX1XduMGdt3cAxQi/exec
```
These endpoints are preserved for reference. All production work uses Supabase.

---

## THEME SYSTEM SPECIFICATION

### Principle
theme.css is the only file that contains color values, font names,
font sizes, font weights, or spacing values. Every HTML file on the
platform references CSS custom properties (variables) only.
A developer should be able to read any HTML file and see zero hex
codes, zero rgb() values, zero font-family declarations, zero px
sizes on text. Zero.

This ensures:
- The theme selector works on every element without exception
- A future rebrand or accessibility audit touches one file
- No regressions when themes switch

### Four Themes

Themes increment from offwhite to black in approximately 20–25%
luminosity steps. Each theme is a complete set of variable overrides
on the `:root` or `[data-theme="N"]` selector.

| Theme | Name | Background | Character |
|---|---|---|---|
| 1 | Dawn | `#F4F2ED` | Warm offwhite — paper, light, open |
| 2 | Dusk | `#2A2D35` | Slate — mid-dark, readable |
| 3 | Depth | `#14171E` | Near-dark — focused, calm |
| 4 | Void | `#080D14` | Full dark — the default ECO aesthetic |

Theme 4 (Void) is the brand default and the design reference.
All mockups are built at Theme 4 first, then verified at Theme 1.

### Variable Registry

Every variable must be defined in all four themes.
No variable may have a fallback value that is a hardcoded color.

```css
/* ── APPLIED SEMANTICALLY — never use raw hex in HTML ── */

/* Backgrounds */
--color-bg               /* Page background */
--color-bg-surface       /* Cards, panels, input areas */
--color-bg-surface-2     /* Hover states, nested surfaces */
--color-bg-overlay       /* Modal overlays, dropdowns */

/* Text */
--color-text-primary     /* Body text, headings */
--color-text-secondary   /* Subtext, labels, captions */
--color-text-muted       /* Placeholder text, disabled */
--color-text-inverse     /* Text on brand-color backgrounds */

/* Brand colors — these shift subtly across themes */
--color-eternal          /* ETERNAL blue — #00AAFF in Void */
--color-current          /* CURRENT green — #00CC44 in Void */
--color-star             /* STAR pink — #FF6688 in Void */
--color-passed           /* Passed purple — #AA66FF in Void */

/* Borders */
--color-border           /* Default border */
--color-border-strong    /* Emphasis border */
--color-border-brand     /* Brand-colored border (input pulse) */

/* Status */
--color-success
--color-warning
--color-error

/* Typography */
--font-family-display    /* Arial Black, Arial, sans-serif */
--font-family-body       /* Arial, sans-serif */
--font-size-xs           /* 9px */
--font-size-sm           /* 11px */
--font-size-base         /* 13px */
--font-size-md           /* 15px */
--font-size-lg           /* 18px */
--font-size-xl           /* 24px */
--font-size-2xl          /* 36px */
--font-size-hero         /* 52px */
--font-weight-regular    /* 400 */
--font-weight-bold       /* 900 */
--letter-spacing-tight   /* 0.02em */
--letter-spacing-normal  /* 0.06em */
--letter-spacing-wide    /* 0.12em */
--letter-spacing-wider   /* 0.20em */

/* Spacing */
--space-xs    /* 4px */
--space-sm    /* 8px */
--space-md    /* 14px */
--space-lg    /* 20px */
--space-xl    /* 32px */

/* Shape */
--radius-sm   /* 6px */
--radius-md   /* 10px */
--radius-lg   /* 14px */
--radius-pill /* 20px */
--radius-circle /* 50% */

/* Animation */
--duration-fast    /* 200ms */
--duration-normal  /* 400ms */
--duration-slow    /* 800ms */
--duration-breathe /* 3500ms — input box pulse */
--ease-default     /* ease-in-out */
```

### Theme 4 — Void (default, brand reference)
```css
[data-theme="4"], :root {
  --color-bg:           #080D14;
  --color-bg-surface:   rgba(255,255,255,0.04);
  --color-bg-surface-2: rgba(255,255,255,0.08);
  --color-bg-overlay:   rgba(8,13,20,0.92);
  --color-text-primary:   #FFFFFF;
  --color-text-secondary: rgba(255,255,255,0.55);
  --color-text-muted:     rgba(255,255,255,0.28);
  --color-text-inverse:   #080D14;
  --color-eternal:  #00AAFF;
  --color-current:  #00CC44;
  --color-star:     #FF6688;
  --color-passed:   #AA66FF;
  --color-border:        rgba(255,255,255,0.10);
  --color-border-strong: rgba(255,255,255,0.20);
  --color-border-brand:  rgba(0,170,255,0.40);
}
```

### Theme 3 — Depth
```css
[data-theme="3"] {
  --color-bg:           #14171E;
  --color-bg-surface:   rgba(255,255,255,0.06);
  --color-bg-surface-2: rgba(255,255,255,0.10);
  --color-bg-overlay:   rgba(20,23,30,0.94);
  --color-text-primary:   #F0F2F5;
  --color-text-secondary: rgba(240,242,245,0.55);
  --color-text-muted:     rgba(240,242,245,0.30);
  --color-text-inverse:   #14171E;
  --color-eternal:  #00AAFF;
  --color-current:  #00CC44;
  --color-star:     #FF6688;
  --color-passed:   #AA66FF;
  --color-border:        rgba(255,255,255,0.12);
  --color-border-strong: rgba(255,255,255,0.22);
  --color-border-brand:  rgba(0,170,255,0.42);
}
```

### Theme 2 — Dusk
```css
[data-theme="2"] {
  --color-bg:           #2A2D35;
  --color-bg-surface:   rgba(255,255,255,0.07);
  --color-bg-surface-2: rgba(255,255,255,0.12);
  --color-bg-overlay:   rgba(42,45,53,0.95);
  --color-text-primary:   #ECEEF2;
  --color-text-secondary: rgba(236,238,242,0.58);
  --color-text-muted:     rgba(236,238,242,0.32);
  --color-text-inverse:   #2A2D35;
  --color-eternal:  #00AAFF;
  --color-current:  #00CC44;
  --color-star:     #FF6688;
  --color-passed:   #AA66FF;
  --color-border:        rgba(255,255,255,0.14);
  --color-border-strong: rgba(255,255,255,0.25);
  --color-border-brand:  rgba(0,170,255,0.45);
}
```

### Theme 1 — Dawn
```css
[data-theme="1"] {
  --color-bg:           #F4F2ED;
  --color-bg-surface:   rgba(0,0,0,0.04);
  --color-bg-surface-2: rgba(0,0,0,0.08);
  --color-bg-overlay:   rgba(244,242,237,0.96);
  --color-text-primary:   #0D1117;
  --color-text-secondary: rgba(13,17,23,0.58);
  --color-text-muted:     rgba(13,17,23,0.32);
  --color-text-inverse:   #F4F2ED;
  --color-eternal:  #0066CC;   /* print variant — legible on light */
  --color-current:  #007A2A;   /* print variant — legible on light */
  --color-star:     #CC2244;
  --color-passed:   #6633BB;
  --color-border:        rgba(0,0,0,0.10);
  --color-border-strong: rgba(0,0,0,0.20);
  --color-border-brand:  rgba(0,102,204,0.45);
}
```

Note: --color-eternal and --color-current use the print variants
(`#0066CC` / `#007A2A`) in Theme 1 so they remain legible on the
warm offwhite background. The brand identity is preserved in feel
even though the exact hex shifts for accessibility.

### Theme Selector — Persistent UI Element

Position: bottom-right corner of every page. Always visible.
Four dots in a row. Current theme dot is filled/active.
Tapping a dot: sets `data-theme` attribute on `<html>` element,
saves selection to USER_PREFERENCES `ui.theme` key.
Loads persisted theme on every page load before first paint
(inline script in `<head>` — prevents flash of wrong theme).

```html
<!-- In <head> — prevents theme flash -->
<script>
  const t = localStorage.getItem('eco-theme') || '4';
  document.documentElement.setAttribute('data-theme', t);
</script>
```

```html
<!-- Theme selector pill — same markup on every page -->
<div class="theme-selector" role="group" aria-label="Theme">
  <button data-t="1" aria-label="Dawn theme"></button>
  <button data-t="2" aria-label="Dusk theme"></button>
  <button data-t="3" aria-label="Depth theme"></button>
  <button data-t="4" aria-label="Void theme"></button>
</div>
```

All styling for `.theme-selector` lives in theme.css.
The selector itself must work correctly in all four themes.

---

## ADMIN CONSOLE — CONTENT STAGING INTERFACE

**File:** admin.html (SuperUser and designated admins only)
**Access:** Supabase Row Level Security — Role = SuperUser only
**Phase:** Build Stage 5 alongside nightly batch job

No forms. Same principle as the rest of the platform.
Content is entered through a conversational AI interface and
through paste-and-parse bulk entry.

### Mode 1 — Conversational entry (one item at a time)

Admin taps a content type:
[Vocabulary term]  [Discovery card]  [Question template]  [Term conflict]

AI walks through each required field conversationally:
> "What cultural context is this term from?"
Admin: "North Indian"
> "What structural relationship does it describe?"
Admin: "Maternal uncle"
> "What's the term?"
Admin: "Mama"
...and so on.

Admin can say "skip" on optional fields.
Admin can say "done" at any point — partial entry saves as Pending.
AI shows a summary for confirmation before staging.
On confirm: writes to CONTENT_STAGING, ReviewStatus = Pending.

### Mode 2 — Paste and parse (bulk entry)

Admin pastes raw text — research notes, a linguistic reference
table, a list from a tribal consultation.
Admin taps the content type.
AI parses the paste and presents each extracted item for
confirmation one at a time. Ambiguous entries are flagged.
Each confirmed item writes to CONTENT_STAGING as Pending.

This is the workhorse for initial library seeding — paste from
native-languages.org or a tribal vocabulary document, AI does
the field extraction, admin confirms or corrects inline.

### Mode 3 — Staged content review queue

After each nightly run, admin sees items that came back as
NeedsRevision or AwaitingConfirmation.

NeedsRevision: item summary + AI verdict notes + tap to open
in the conversational editor (pre-populated). Admin fixes
inline, confirms, item resubmits as Pending for next night.

AwaitingConfirmation: item summary + waiting-for contact name.
Tap to mark confirmed once external confirmation is received.
Single text input for ConfirmedByContact name — not a form field,
just an inline text capture in the conversation flow.

---

### Mode 4 — Expert Review Request (Vocabulary Validation)

Admin triggers a vocabulary review session to send to a named
subject matter expert. The expert receives a self-contained HTML
page (ECO_VOCAB_REVIEW.html) with 15 randomly selected terms from
the CULTURAL_VOCAB_LIBRARY for their language. They review, confirm
or flag each term, and email the response back. Admin imports
the response, and confirmed terms promote automatically.

**The trigger flow (admin side — no forms):**

Admin taps: [Send expert review request]

AI prompt: "Which language?"
Admin selects from a dropdown list of all languages currently
in the CULTURAL_VOCAB_LIBRARY (auto-generated from Language field).

AI prompt: "Who are you sending this to?"
Admin: types name + email address of the expert.

AI prompt: "Any notes about this reviewer's background?
  (optional — helps calibrate the review)"
Admin: types or skips.

AI prompt: "Which round? (1–4)"
Admin selects. Round number seeds which 15 terms are shown.

Platform generates a personalised review URL:
`vocab-review.eternalcurrent.online/review?lang=ja&round=2&token=[token]`

Or for Phase 0 where there is no hosted URL: the platform
emails the expert the ECO_VOCAB_REVIEW.html file as an
attachment with the round parameter pre-configured.

Platform sends the email via Resend:
  From: vocab@eternalcurrent.online
  Subject: "Vocabulary review request — Japanese (Round 2)"
  Body: personal note from admin, link or attachment,
        brief explanation of ECO's mission (3 sentences max),
        expected time commitment (5–10 minutes),
        and the incentive offer if applicable.

**Review request logged in VOCAB_REVIEW_REQUESTS table
(see schema — add this table in next schema pass).**

---

### VOCAB_REVIEW_REQUESTS table (add to schema)

```
RequestID             text        Primary key
Language              text        FK to Language values in CULTURAL_VOCAB_LIBRARY
Round                 integer     1–4
ReviewerName          text        Name entered by admin
ReviewerEmail         text        Encrypted at rest — never displayed in UI
ReviewerBackground    text        Optional notes on reviewer's background
IncentiveOffered      text        None / FreeProfile / TwoFreeProfiles / Custom
IncentiveNote         text        Details of offer, if any
SentAt                timestamp
ResponseReceivedAt    timestamp   null until response comes back
ResponseStatus        text        Sent / Responded / NoResponse / Bounced
TermsReviewed         integer     Count of terms the reviewer actually reviewed
TermsConfirmed        integer
TermsFlagged          integer
TermsUnsure           integer
AdminNotes            text        Any context about this reviewer
ConfirmedByAdmin      boolean     FALSE until admin imports response
```

**Import flow (when email response arrives):**
Admin pastes the JSON block from the expert's email into
the admin console conversational interface.
AI parses the JSON, presents a summary:
  "[Name] reviewed 12 of 15 terms.
   8 confirmed, 2 flagged, 2 unsure.
   2 terms have correction notes."
Admin reviews flagged items and corrections inline.
Admin confirms import → CULTURAL_VOCAB_LIBRARY entries updated:
  - Confirmed terms: ExpertConfirmed = TRUE,
    ConfirmedByName = reviewer name, ConfirmedAt = timestamp
  - Flagged terms: ReviewStatus = NeedsRevision,
    AdminNotes updated with reviewer's correction
  - NuanceNotes appended where reviewer added nuance
VOCAB_REVIEW_REQUESTS row updated with response stats.

**Rule:** A term is considered expert-confirmed when it has
been confirmed by at least 2 independent reviewers.
Single confirmations are logged but do not change the
ExpertConfirmed flag to TRUE. This prevents a single
well-intentioned but incorrect reviewer from certifying
inaccurate content.

---

### Expert Incentive Model

**Pricing philosophy: market rate for everyone.**
ECO does not discount or give away access as a transactional
exchange for vocabulary review. The right partners respond to
mission alignment first. Economics follows.

**What reviewers actually receive:**

Attribution — the primary form of reciprocity.
Every expert reviewer is credited in the CULTURAL_VOCAB_LIBRARY:
"Validated by [Name], [Title], [Department], [Institution]"
This is citable professional credit. For Ethnic Studies and
linguistics faculty, community engagement contributions like this
appear on CVs and matter in tenure and review processes.
A free subscription does not do that. Attribution does.

One Conductor account — as a gesture, not a payment.
A single free account offered as: "We would love for you to
experience what your expertise is helping build."
Standard pricing applies if they want to continue after that.
Everyone pays the same rate. No exceptions, no tiers.

**For classroom partnerships:**
Professor integrates the vocabulary review into course curriculum.
The professor receives a free teaching license for the active term.
Students acting as reviewers are not Conductors — they pay nothing.
If the department wants ongoing institutional access, Org Admin
founding partner pricing applies ($3/seat/month, permanent for
first 10 institutional partners nationally).

**How to present it:**
Lead with mission and attribution. Mention the account last,
briefly, as an invitation to experience the platform — not as
an incentive. The professors who are the right partners will
not be motivated by free software. They will be motivated by
the opportunity to contribute to something that does what their
discipline argues for.

Never negotiate pricing. Never frame it as a transaction.
The rate is what it is because the platform respects its users.
That respect applies equally to everyone.

---

### Community College Professor Strategy

Community college professors are an underused and highly credible
source for vocabulary validation across many languages. They are:
- Native speakers or heritage scholars by definition
- Accessible (office hours, department email, public contact info)
- Motivated by community impact, not fee structures
- Connected to diaspora communities ECO wants to reach
- Often teaching courses specifically on diaspora culture,
  heritage language, or intergenerational family dynamics

**Target departments:**
- Modern Languages and Linguistics
- Asian American Studies / South Asian Studies
- Pacific Islander Studies
- Chicano/Latino Studies (for Spanish kinship terms)
- Native American Studies
- Ethnic Studies (broad)

**Outreach approach:**
Not a cold sales email. A research partnership inquiry.
Frame it as: "We are building a culturally accurate kinship
vocabulary library and are looking for native-speaker experts
to review our terms for accuracy, nuance, and regional variation.
This is unpaid volunteer scholarship — we offer free platform
accounts as reciprocity. Would you be open to a 10-minute review?"

Bay Area community colleges to target for Japanese vocabulary:
De Anza College (Cupertino), Foothill College (Los Altos),
Chabot College (Hayward), City College of San Francisco.

All have Japanese language departments with native-speaking instructors.
De Anza in particular has a large Japanese American student and faculty
population — it is within 10 miles of San Jose Japantown.

**Add to marketing strategy:** community college professor outreach
as a Phase 1 / pre-launch activity. No cost. High credibility.
Builds relationships with educators who may also become platform
advocates for their diaspora students.


## KNOWN ISSUES (pre-launch)
1. **Globe migration arcs not rendering** — highest priority pre-Phase 0 fix
2. **Globe UV fix** — `vec2 uv = vec2(vUv.x, 1.0 - vUv.y)` must be in shader
3. **Supabase migration** — Google Sheets is current data source for Lightning-001.
   Migration to Supabase is the final pre-launch task. See checklist below.
4. **Entry portal Lynch Pin selector not built** (Sprint S-05 pending)
5. **Apps Script CORS on redirect** — use local HTTP server for remaining
   POC development only. Retired entirely at Phase 0 launch.

---

## APPS SCRIPT / GOOGLE SHEETS RETIREMENT CHECKLIST

Google Sheets + Apps Script is the Phase 0 POC data layer.
It retires the moment Phase 0 launches with real users.
Supabase becomes the permanent and only data source from that point.
This is not a workaround to revisit — it is a migration to complete.

**Execute in this order:**

1. Export full Lightning-001 Google Sheet as JSON.
   Save as `lightning-001-export-[date].json` — permanent archive.
   Do this before touching anything else. This is the safety net.

2. Run Supabase migration.
   All tables in 02_SCHEMA.md created in Supabase.
   Seed with Lightning-001 data from the JSON export.
   Verify every profile, relationship, and birth date is intact.

3. Update globe-live.html and dashboard.
   Replace all `fetch(APPS_SCRIPT_URL)` calls with Supabase client.
   The `.catch(()=>null)` snapshot fallback can be removed once
   Supabase is confirmed stable.

4. Remove the snapshot fallback mode.
   The "Snapshot mode / Live from Google Sheets" indicator was a
   development tool. Remove it. In production, data is Supabase only.

5. Archive the Apps Script endpoints.
   Do not delete — archive. Endpoint URLs are preserved in this
   document for reference. They will never be called in production.

6. Archive the Google Sheet.
   Rename to `lightning-001-ARCHIVED-[date]`. Move to archive folder
   in Google Drive. Do not delete — original source of truth.

7. Update environment variables.
   Remove `APPS_SCRIPT_URL` from all configs.
   Confirm `SUPABASE_URL` and `SUPABASE_ANON_KEY` are set
   in Vercel environment variables for production.

8. Smoke test.
   Globe renders with live Supabase data.
   All 48 Lightning-001 profiles load correctly.
   Migration arcs display for all profiles with birth cities.
   Constellation view renders the full network.
   Network directory shows all profiles.

**This checklist is the gate for Phase 0 launch.**
Nothing goes live until all 8 steps are complete and verified.

---

## RESEARCH DATA GOVERNANCE FRAMEWORK

### Core principle
Individual network data: never shared, sold, or provided to
any researcher, institution, or third party under any circumstances.
This is non-negotiable. It is the literal meaning of "Only Yours. Forever."

Aggregate statistical patterns: publishable, with governance.
The distinction is the entire framework.

### The 23andMe lesson applied
23andMe's research-consented database of 15 million people ended up
in a bankruptcy auction. ECO's brand promise is the direct answer
to that story. Any data strategy that could one day produce a
similar headline — "ECO user data sold to highest bidder" —
destroys the platform's core value proposition.

The safe zone: ECO as publisher of insights, not vendor of data.

---

### What ECO can do with aggregate data

**ECO Annual Diaspora Report**
Published annually. Freely available. Citable by researchers.
Aggregate findings only — no individual, no network, no household.
Potential findings:
- Which kinship terms survive across how many diaspora generations
- Migration dispersion patterns by cultural origin and era
- Network size distribution across cultural groups
- Intergenerational story capture rates by network age
- Vocabulary preservation correlation with Keeper presence
- Geographic clustering patterns among diaspora communities

This is the model: Pew Research Center, not 23andMe.
ECO produces the report. Academics cite it. Nobody accesses raw data.

**Research collaboration model**
A researcher proposes a specific analysis question to ECO.
ECO's technical team runs the query internally against aggregate data.
ECO shares results — numbers, patterns, aggregate findings.
The researcher never sees the data. The data never leaves ECO's systems.
This is how the US Census Bureau handles researcher access
to microdata — the researcher proposes, the bureau runs it.

**What this enables academically:**
Ethnic Studies faculty can cite ECO's published findings in papers.
Students can build coursework around ECO's aggregate diaspora data.
Researchers can propose collaboration studies where ECO provides
aggregate results to specific research questions.
Grant applications can reference ECO as a data source for
diaspora research — where ECO is the publisher, not a database vendor.

---

### Governance structure (Phase 2)

A formal Research Advisory Board — 3 to 5 members from:
- Academic ethnic studies or diaspora studies
- Oral history methodology
- Privacy law / data ethics
- A community representative from a partner tribal or diaspora org

The board reviews:
- Annual Diaspora Report methodology before publication
- Any proposed research collaborations
- Any changes to data governance policy

Board members serve voluntarily. Attribution in all published reports.
No compensation — same principle as vocabulary reviewers.
The right people will do this because the mission is right.

---

### What ECO will never do with data

Never sell, license, or provide individual network data to anyone.
Never provide network-level data (even anonymized) without
a formal governance review.
Never allow researchers direct database access.
Never include behavioral or usage data in any research output.
Never partner with pharmaceutical, insurance, law enforcement,
or immigration enforcement entities for any data purpose.
Never monetize data in any form. The subscription is the revenue.
The data is the user's.

These prohibitions are permanent and unconditional.
They survive any future ownership, investment, or partnership.
Any term sheet or investment document should reflect this.


---

## ROTATING BANNER — ADMIN CONSOLE SPEC

### What it is
A single statement displayed in a rotating banner on the home
page. One statement per page load. Drawn from an approved library
that grows over time through an AI-proposal / admin-approval cycle.

### Admin interface — Mode 5: Banner Statement Management

**View current rotation:**
Admin sees the full approved statement library with:
- Statement text
- Status: Active / Paused / Retired
- Engagement score (dwell time + manifesto click-through rate)
- Times shown (total)
- Date approved
- Source: Founding set / AI proposed / Admin authored

**Approve a proposed statement:**
Platform AI surfaces proposed statements in a review queue.
Each proposal shows:
- The statement text
- Why the AI proposed it (pattern observed: e.g. "Three networks
  this month added kinship terms for 'the uncle who shows up' —
  this appears to be a cross-cultural recognition point")
- A confidence score (how strongly the AI believes this will
  resonate based on engagement patterns from similar statements)

Admin options per proposal:
- Approve as written → enters rotation immediately
- Edit and approve → admin edits inline, then approves
- Reject → removed from queue, AI notes the rejection to
  calibrate future proposals

**Author a statement manually:**
Admin can write and submit a statement directly.
No AI involvement required. Admin approval is the submission.

**Retire a statement:**
Any statement can be paused (removed from rotation temporarily)
or retired (archived permanently). Retired statements are kept
in the archive for reference — never deleted.

**Weight a statement:**
Admin can increase the rotation frequency of any statement
for a defined period. Use case: cultural events, seasonal
relevance, campaign alignment.

---

### AI proposal mechanism

The platform AI observes three signal sources:

1. **Vocabulary library patterns**
   When multiple cultures have terms for the same relational
   role (e.g. the protective uncle, the keeper of recipes,
   the elder who bridges generations), the AI identifies the
   cross-cultural resonance and proposes a statement that
   names it without naming any specific culture.

2. **Engagement data from existing statements**
   Statements that generate longer dwell time or manifesto
   click-throughs are analyzed for their structural and
   semantic properties. The AI learns what resonates and
   proposes new statements with similar qualities.

3. **Network milestone events**
   When aggregate network data shows a pattern — e.g. a surge
   in oral history designations, or a wave of new cultural
   backgrounds entering existing networks — the AI may propose
   a statement relevant to that moment.

**Proposal frequency:**
The AI proposes no more than 3 statements per month to avoid
admin fatigue. Quality over volume. Each proposal is accompanied
by clear reasoning so the admin can evaluate it quickly.

**The human filter is permanent.**
No AI-proposed statement enters rotation without explicit admin
approval. This is not a moderation safeguard — it is a design
principle. The statements are the platform's voice. The platform's
voice belongs to the people who built it.

---

### Statement format rules (enforced by the admin interface)

- Maximum 2 sentences
- Maximum 35 words per sentence
- No question marks (statements, not questions)
- No brand mentions (EternalCurrent, ECO, etc.)
- No product features mentioned
- No calls to action
- Plain text only — no formatting, no emphasis

The interface shows a live word count and flags violations
before the admin can approve. These rules are not advisory —
they are enforced at the interface level.

---

### Database table: BANNER_STATEMENTS

```
StatementID         text        Primary key
Text                text        The statement. Max 140 chars total.
Status              text        Active / Paused / Retired / Pending
Source              text        Founding / AI_Proposed / Admin_Authored
ProposedAt          timestamp
ApprovedAt          timestamp   null until approved
ApprovedBy          text        Admin UserID
RetiredAt           timestamp   null until retired
EngagementScore     float       Composite: dwell time + manifesto CTR
TimesShown          integer     Running total across all users
AIReasoning         text        Why the AI proposed it. Null if admin-authored.
AIConfidence        float       0–1. Null if admin-authored.
WeightMultiplier    float       Default 1.0. Admin can increase for campaigns.
WeightExpiresAt     timestamp   When the weight multiplier reverts to 1.0
```


---

## MARKETING SITE — CMS AND FRAMEWORK DECISION (LOCKED)

### Framework: Next.js on Vercel
The marketing site (Home, How It Works, Manifesto) and the
platform shell are built in Next.js deployed on Vercel.

Why not WordPress:
ECO is a web application — user accounts, live database, AI
conversation, visualizations, billing, role-based permissions.
WordPress is a content management system built for blogs.
Fighting it into application shape creates more problems than
it solves. Next.js handles both static marketing pages and
dynamic application pages in one codebase.

The ECO_SITE_V4.html mockup is a direct blueprint for the
Next.js build. Every section, class, and image reference
translates. No redesign required — structural conversion only.

### CMS: None for Phase 0/1, Sanity for Phase 2

**Phase 0/1:**
Static pages hard-coded in Next.js, updated through GitHub.
Content is stable — manifesto is locked, banner statements
are managed through the BANNER_STATEMENTS table in the admin
console. No CMS overhead needed.

**Phase 2:**
Add Sanity (headless CMS) when tribal organizations or academic
partners need to update their own content, or when marketing
copy changes frequently enough to warrant a non-technical
editing interface.

Sanity is preferred over Contentful because its flexible content
model can handle the vocabulary library and banner statement
library as structured data — not just text fields. The admin
console could be partially built in Sanity rather than from
scratch.

Next.js has native Sanity integration. The addition is
straightforward and does not require restructuring the site.

### Deployment
Domain registrar: Namecheap (eternalcurrent.online, lookmeup.online, crunod.com)
Hosting: Vercel (free tier covers Phase 0 and Phase 1)

DNS configuration: Namecheap DNS → point to Vercel nameservers.
Domain ownership stays at Namecheap. Application runs on Vercel.
This is standard practice — registrar and host do not need to
be the same company. The change takes 5 minutes to configure
and up to 24 hours to propagate.

Why not Namecheap shared hosting for the application:
Namecheap shared hosting runs cPanel/PHP — designed for
WordPress and static sites. It cannot run Next.js which
requires a Node.js server environment. Namecheap VPS can
run Node.js but requires manual server administration
(Nginx, PM2, SSL) that Vercel handles automatically for free.

Pre-launch option (available right now):
Upload ECO_SITE_V4.html and the images/ folder directly to
Namecheap shared hosting via cPanel. The static HTML site
works immediately with no framework required. Move to Vercel
when the Next.js application build begins.

Production:
eternalcurrent.online → Vercel (main branch auto-deploy)
Staging: crunod.com → Vercel preview deployments
SSL: Vercel provisions automatically via Let's Encrypt

### What this means for the HTML mockup
ECO_SITE_V4.html is the design source of truth.
When ready to build: developer converts HTML to Next.js
components. Estimated conversion time: 1–2 days.
The design work is already done.


---

## SITE PAGES — AS BUILT

### index.html
Main SPA — three pages in one file, JS show() function handles routing.
Pages: Home, How It Works, Manifesto.
All images in images/ subfolder relative to index.html.

**Home page sections (in order):**
1. Hero — img_hands.png, full viewport height
2. Globe section — img_globe2.png, full width with caption overlay
3. Phase strip — 4 cards: img_grandma / img_thanksgiving / img_ethnic / img_tribal
4. Feature grid — 6 cards: img_globe / img_confluence / img_terms / img_continuum / img_noise / img_tea
5. Energy section — img_streets.png full bleed, text overlay left
6. Rotating banner — 15 founding statements, 6s rotation, JS-driven
7. Story row — 3 panels: img_legacy / img_passing / img_horse
8. Promise rows — "What we will never do" (3 cards) + "What we always will" (4 cards)
9. Footer

**How It Works sections:**
1. HIW hero — img_revitalization.png
2. 5 steps
3. Roles section — Conductor / Keeper / Moderator
4. Ownership section — 3 commitment cards
5. Footer

**Manifesto sections (image-driven, minimal text):**
1. Hero — img_lonetree.png, full height
2. Text block 1 — the Root paragraph
3. Image + caption — img_container.png "The coworker who brought food"
4. Image + caption — img_teacher.png "The teacher who saw something"
5. Text block 2 — pollinators paragraph + energy pull quote
6. Image — img_oklahoma.png + caption
7. Image + caption — img_teaching.png "Roots, passed forward"
8. Image + caption — img_couple.png — Eternal/Current text
9. Text block 3 — you are not the product
10. Image + caption — img_keeper.png "Most families do not fit in a tree"
11. Closing image — img_tradition.png "Different words. The same beat."
12. CTA — Join The Waitlist

### confluence.html
Separate URL: eternalcurrent.online/confluence
Standalone page — not part of the index.html SPA.
Nav links back to index.html sections.

**Confluence sections (in order):**
1. Hero — img_confluence_new.jpg (bidirectional energy, ECO brand colors)
   PLACEHOLDER: img_confluence2.png available as alternate
2. What is the Confluence — prose + pull quote
3. Vocabulary library — language filter pills + 6 sample vocab cards
   Cards: Japanese / Yoruba / Arabic / Lakota / Korean / Hindi-Punjabi
   Badge types: Scholar verified / Keeper contributed / Community reviewed
4. Methodology — 3 steps: Keeper contribution / Scholar review / Two-reviewer confirmation
   Key rule: Network's own Keeper is never subject to outside review
5. Contributor section — split grid: why contribute + conversational how-it-works
   CTA: mailto:vocab@eternalcurrent.online
6. Attribution tiers — Anonymous / Initials+field / Named citable
7. Annual Diaspora Report — stats grid + mailto:research@eternalcurrent.online
8. Footer

---

## IMAGE LIBRARY — FULL MANIFEST

### In use — index.html

| Filename | Section | Description |
|---|---|---|
| eco-logo.png | Nav (all pages) | ECO brand logo |
| img_hands.png | Home hero | Electric hands — bidirectional current |
| img_globe2.png | Home globe section | Migration arcs globe (wider) |
| img_grandma.png | Phase 0 card | Grandmother + grandchild |
| img_thanksgiving.png | Phase 1 card | Black/Chinese/American Thanksgiving |
| img_ethnic.png | Phase 2a card | Ethnic Studies classroom |
| img_tribal.png | Phase 2b card | Tribal language revitalization |
| img_globe.png | Feature: globe card | Migration arcs globe (darker) |
| img_confluence.png | Feature: constellation card | Confluence of culture painting |
| img_terms.jpg | Feature: vocabulary card | Kinship words star field |
| img_continuum.png | Feature: conversation card | Grandfather watching child run |
| img_noise.png | Feature: network directory | Multigenerational gathering |
| img_tea.png | Feature: discovery | Anglo-Colombian tea time |
| img_streets.png | Energy section background | Diverse market street scene |
| img_legacy.png | Story row: Your Eternal | Young woman + ancestral photo |
| img_passing.png | Story row: Your Current | Hands passing photo mid-transfer |
| img_horse.png | Story row: The Journey | Painted horse over highway |
| img_lonetree.png | Manifesto hero | Lone tree in vast empty field |
| img_container.png | Manifesto | Food container on doorstep |
| img_teacher.png | Manifesto | Teacher crouched to child |
| img_oklahoma.png | Manifesto | Oklahoma plains to city skyline |
| img_teaching.png | Manifesto | Roots being passed forward |
| img_couple.png | Manifesto | Old couple + younger photo of themselves |
| img_keeper.png | Manifesto | Indigenous elder under stars |
| img_tradition.png | Manifesto closing | Four-panel tradition passing |

### In use — confluence.html

| Filename | Section | Description |
|---|---|---|
| img_confluence_new.jpg | Confluence hero | Bidirectional energy, ECO brand colors (FINAL) |
| img_confluence2.png | Alternate/reserve | Particle starburst variant |

### Unplaced — available for future use

| Filename | Description | Best use |
|---|---|---|
| img_layeredtime.png | Line of ancestors in misty field | Rotating banner / Phase 0 deeper page |
| img_youngold.png | Two hands + ancestral photo across table | Rotating banner |
| img_wedding.png | Desi/white wedding baraat | Discovery feature / rotating banner |
| img_nowruz.png | Iranian Nowruz cultural exchange | Discovery feature / rotating banner |
| img_recipe.png | Recipe card being passed in kitchen | Rotating banner |
| img_language.png | Language mashup illustration | Rotating banner / vocab section |
| img_confluence.png | Original warm-toned confluence painting | Interior sections / rotating banner |
| img_revitalization.png | Seedling with roots passed between generations | HIW hero (currently assigned) |

