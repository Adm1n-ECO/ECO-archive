# ECO Features — Phase 0 (MVP) and Phase 1 (Individual Paid Launch)

---

## PLATFORM UX PRINCIPLES (apply to every phase, every feature)

### No forms. Not one.

There is not a single HTML form, submit button, or labeled input
field visible to any user anywhere on the platform. This is a
non-negotiable principle, not a preference.

Every platform that treats family history as data entry feels like
filling out paperwork. ECO feels like a conversation.

**The four permitted input modes:**

**1. Conversational AI exchange**
The AI asks a question. The user types a natural answer.
The AI captures, interprets, and saves the structured data as a
byproduct of the conversation. The user never sees field labels,
required markers, validation errors, or submit buttons.
Used for: profile creation, relationship entry, story capture,
milestone recording, location disambiguation, cultural contribution.

**2. Single tap or toggle**
A choice is presented as pills, switches, or cards.
Tapping one saves immediately — no confirm step, no submit.
The UI acknowledges the selection visually (highlight, check).
Used for: notification preferences, theme selection, card view layout,
banner topic focus, response options on AI questions, passed designation.

**3. Live search**
A single input that filters as the user types.
No submit action. Results appear and update in real time.
Used for: People Directory search, relationship linking (finding
an existing person to connect to), cultural vocab lookup.

**4. File picker**
A single tap opens the system file picker.
On selection, upload begins immediately.
A progress indicator replaces the picker.
Used for: profile photo upload, historical photo upload.

**Auth — the minimal exception**
Login and signup require email and password. These are rendered
as sequential conversational prompts, not as a traditional form:
"What's your email?" — single clean input, no label visible above it.
"And your password?" — same treatment.
Enter key or tap on the input advances to the next prompt.
No submit button. No form tag. Styled as dialogue.

**Progressive save — the architectural consequence**
Because there is no submit button, every answer must save the
moment it is confirmed (Enter, tap, or selection).
Partial conversations are preserved in the DB.
If a user stops mid-entry, their partial record exists.
When they return, the AI resumes: "Last time we were adding your
Nana — you told me she was born in Amritsar. Do you know
roughly when?"
Nothing is lost. No "you must complete this form" messages. Ever.

**What this means for the entry portal specifically**
The entry portal (entry-portal.html) is not a data entry form.
It is a conversation interface. The AI conducts an intake session.
The structured fields in People_Master and Relationships_Linker
are populated as answers arrive — the user never knows they exist.
The People Directory (card view) is how the user sees what has
been captured — browsable, readable, human. Not a spreadsheet.

---

## PHASE 0 — MVP LIGHTNING WOW

### Gate condition
Build Stage 4 complete (globe + constellation functional + dashboard shell live).
Family pilot only. No billing. No new networks outside Lightning.

### In Scope
- Magic link signup/login (Supabase) — email only, no password, no form
- Invite-only entry — no public self-signup
- Globe: photorealistic, migration arcs rendering, opens on Conductor's CurrentLoc
- Constellation: self-centered view, VisibleTo-filtered, cultural DisplayLabels
- Constellation: 4 themes (Organic, Ripple, Circuitry, Cosmic)
- AI story session: reads existing record, fills nulls, confirms relationships
- InviteStatus flow: Pending → Completed
- Milestones: Marriage, Graduation, Birthday_Milestone, Custom
- Email: invite, welcome, birthday month reminders (opted-in only)
- Growth announcement widget on landing page (pilot/cumulative mode)
- **People Directory — card view with field picker, sort, filter** (pulled forward)
- **Profile Photos — self-upload and upload for passed/placeholder profiles** (pulled forward)
- **Cultural Vocabulary Library — read-only display of seeded terms** (pulled forward)
- **Basic Discovery Banner — network facts + vocab spotlight, static weighting** (pulled forward)
- Dashboard shell — post-login home with three miniature visualizations
- Lightning-001 = Free_Forever — no billing screen ever

### Not in Scope (Post-Phase 0)
- Stripe billing
- New network creation
- Referral reward mechanics
- Multi-network membership UI
- Full data export (GEDCOM)
- My Data page
- Erasure flow
- Block/mute
- Legacy View — locked to Phase 2
- AI landing page question system (full — launches in Phase 1 Stage 5)
- Discovery Banner feedback controls (AlreadyKnew / WantLess) — Phase 1
- Discovery Banner topic focus algorithm — Phase 2
- AI Triangulation Tier 1 + 2 — Phase 2 (Tier 3 social triangulation in Phase 1)
- Living Conductor photos tagged by others — Phase 1

### Phase 0 WOW Checklist

| Item | Status |
|---|---|
| Globe migration arcs — confirm arc fix on dev machine with local textures | In progress |
| Globe — opens on each Conductor's CurrentLoc | Priority |
| Constellation — Conductor terminology sweep complete | Pending |
| Add Fijian-Indian DisplayLabels to Reema's records | Pending |
| Add North Indian DisplayLabels to Vikas's records | Pending |
| Seed Cultural_Vocab_Library — North Indian + Fijian-Indian terms | Pending |
| Profile photos — upload flow live, faces showing in constellation | Pending |
| People Directory — card view live in dashboard | Pending |
| Basic Discovery Banner — live on dashboard with network facts + vocab | Pending |
| Write welcome screen copy | Pending |
| Confirm Isaiah's VisibleTo scoping | Pending |
| Verify all 48+ records have network_id = lightning-001 | Pending |

### Tagline (LOCKED — appears on landing page and auth screen)
*Your Eternal. Your Current. Only Yours. Forever.*

### Welcome Screen Copy (LOCKED)
*"You are not a leaf on a tree. You are the center of a field of energy. Every person here has shaped who you are — whether you know their story or not. Start by looking at where everyone came from."*

### Cultural Vocabulary Copy
*"Different families use different words. There's no wrong answer — just the words your family actually uses."*

---

## PHASE 1 — INDIVIDUAL PAID LAUNCH

### Gate condition
Phase 0 stable. Legal docs live (review started during Phase 0 build).
Stripe integrated. My Data page, erasure flow, COPPA age gate all live.

### Items moved to Phase 0 (no longer new in Phase 1)
- People Directory / card view — shipped Phase 0
- Profile Photos — shipped Phase 0
- Cultural Vocabulary display — shipped Phase 0
- Basic Discovery Banner (network facts + vocab) — shipped Phase 0

### Items simplified for Phase 1 launch (full version in Phase 2)
- AI Triangulation: Tier 3 only (social triangulation). Tiers 1+2 in Phase 2.
- AI Question System: types 1-3 at Phase 1 launch. Types 4+5 (contribution + sensitivity) added mid-Phase 1 in Stage 7.
- Discovery Banner: feedback controls (AlreadyKnew / WantLess) ship mid-Phase 1. Full weighting algorithm in Phase 2.

### Items locked to Phase 2 (not in Phase 1)
- Legacy View — Phase 2 Stage 8. High complexity, requires revenue flowing.
- AI Triangulation Tier 1+2 — Phase 2 Stage 8.
- Discovery Banner full feedback algorithm + topic pills — Phase 2 Stage 8.

### New in Phase 1

**Billing**
- Conductor: $5.99/month
- Pro Conductor: $8.99/month
- No auto-renewal — user makes deliberate choice each period
- No cancellation fee
- Annual billing option (~17% discount)
- 60-day penalty-free trial
- Renewal reminder at 14 days (not 30)
- Secondary renewal notification opt-in (family member)
- Sponsor model — carry profiles for others
- Household billing groups

**New Networks**
- Network creation opens to public
- Network naming flow
- Founding Conductor designation (permanent label, no price premium)

**Rights & Compliance**
- My Data page (/my-data) — always accessible regardless of subscription
- Erasure / opt-out flow (30-day completion)
- Data export: GEDCOM + JSON
  - Type A (user-created): full content
  - Type B (own profile): full content
  - Type C (tagged-in by others): reference log only
- Cookie consent banner
- COPPA age gate
- Legal docs (Termly or Legalmattic)
- Three DPAs signed: Supabase, Vercel, Anthropic
- data@eternalcurrent.online routing

**UX**
- Post-login dashboard (dashboard.html) — Google homepage principle
- Three miniature visualizations (globe, constellation, Legacy View thumbnail)
- AI landing page question — one per visit, ETERNAL-weighted 70-80%
- Four response options per question
- Test drive at /demo — fictional diverse family, no time limit
- Landing page live globe (representative data, geo-oriented)
- Partner affiliate redirect (user-prompted, ECO speaks)
- Block/mute feature
- Notification frequency cap

**Roles (Phase 1 adds)**
- Moderator nomination workflow (operational post-Phase 0)
- Keeper designation
- Keeper title community-defined

### 60-Day Trial Spec
- Trial starts when Network Owner first logs into a new network
- 60 days free — full access
- No penalty if nobody joins in 60 days — exit with no charge
- One trial per email address
- 6-month cooldown before re-trial on same email

### Student Tier — Academic Access Program
**Price:** $3.00/month (same as founding partner institutional rate)
**Duration:** One academic year (9 months) or two semesters
**Access:** Full Conductor access — no feature restrictions
**Eligibility:** Students enrolled in qualifying courses at partner
institutions, verified by faculty contact or .edu email domain

**Philosophy:**
The student is the acquisition vehicle, not the end user.
When a 20-year-old shows a 55-year-old parent their family's
migration arcs on a globe, that parent is the person with the
stories worth capturing, the social network to bring in cousins
and siblings, and will pay full Conductor rate without hesitation.
The student's $3/month seeds a network that includes full-rate
paying Conductors from week one.

**The right frame:**
Not "discounted access for students."
"Bring your family network into your academic work."
The student builds the network as part of their coursework.
Family members they invite get the standard 60-day trial and
then pay the standard Conductor rate ($5.99/month).

**What makes it sticky:**
The data lock-in. A family network with real people, real stories,
and real oral history testimony is irreplaceable. It cannot be
exported and rebuilt somewhere else. The grandmother whose migration
arc is on the globe is the retention mechanism — not the subscription.

**Conversion at the end of academic period:**
30 days before the student rate expires: personal notification
framed as a milestone, not a bill.
"Your academic year is ending. Your family network stays.
Here is how to keep it."
Converts automatically to standard Conductor rate ($5.99/month)
unless the student cancels. No penalty for cancelling — freeze model
applies. Network preserved for 12 months in frozen state.

**Economics:**
Student cost: ~$27–54 over 9–18 months of subsidized access.
If student brings 3 family members who pay $5.99/month for 2 years:
$430 revenue from a $54 acquisition cost — roughly 8x return.
Before counting advocacy, word of mouth, or network expansion.

**Qualifying course types:**
Ethnic Studies, Heritage Language Studies, Migration Studies,
Asian American Studies, Latin American Studies, Pacific Islander
Studies, African American Studies, Native American Studies,
Diaspora Studies, Cultural Anthropology, Historical Sociology.
Faculty partner confirmation required for non-.edu enrollment.

**Student network invitation priority:**
During the academic period, the platform surfaces a specific
prompt to students: "Your network grows when family joins.
Invite three people before your course ends."
This is the single most important retention mechanism —
a network with family members has gravity that no lapsed
subscription can collapse.

**Admin setup:**
Faculty partner contacts admin. Admin provisions a cohort
access code valid for one academic term. Students use the code
during signup to receive the student rate automatically.
No forms. Code entered in the conversational onboarding flow.
Cohort codes expire at the end of the academic term.
No individual verification required beyond the code.


- Shareable link, time-limited read-only milestone view
- EventWindowOptIn = FALSE default
- URL format: eternalcurrent.online/event/<token>
- Duration set by Pro Conductor (up to 30 days)
- Non-members can view without account
- Conversion prompt: "This is the [name] family. Yours is waiting."

### Referral Program
- Within-network referral: 1 free month each side
- New network referral: 3 free months each side
- Cap: 3 months credit per renewal cycle
- Retroactive for Lightning pilot members at Stripe launch
- "You referred 3 people during the pilot — you've earned 2 free months"

---

## ROLES & PERMISSIONS

### Role Overview

| Role | Price | Who |
|---|---|---|
| Conductor | $5.99/mo | Every user — founders, moderators, Keepers all pay this |
| Pro Conductor | $8.99/mo | Optional upgrade — Event Windows, expanded media, advanced viz |
| Org Admin | $14.99/mo | Org networks only — health dashboard, seat mgmt, analytics |
| Guest | $0 | Read-only Event Window viewer |

### Moderator
- Permission layer on Conductor account. No added cost.
- Nominated by Conductor peers (Network Owner or existing Mod after 90 days)
- Handles: disputed relationships, flagged content, VisibleTo violations
- Scaling: 1 per 20-30 active Conductors
- First Moderator = Network Founder (automatic until second Mod accepts)

### Keeper
- Permission layer on Conductor account. No added cost.
- Max 2 per network
- Nominated by Network Owner only
- Title is community-defined (Elder, Storyteller, Sensei, Granthi, etc.)
- Can: annotate profiles, pin vocabulary, create cultural curriculum, mark Teaching Moments
- Cannot: delete content, manage billing, override VisibleTo
- Keeper Score: behavioral metric, NEVER shown as number to anyone

---

### Keeper Activation — Ceremony and Cross-Network Sharing Ask

When a Conductor is designated as Keeper, the activation is not a
routine permission change. It is a moment of recognition. The platform
treats it accordingly.

**Step 1 — Acknowledgment**

Before any permissions are granted, the new Keeper sees a full-screen
acknowledgment moment. Not a confirmation dialog. A statement.

The platform speaks first:

---
*"You have been entrusted with something rare."*

*"The Keeper holds what others might let slip — the word that has no
translation, the story behind the name, the context that makes a family
make sense to the people in it. What you carry as Keeper does not
belong to the platform. It belongs to the people in your network, and
to the people who are not born yet."*

*"The Current you strengthen as Keeper becomes part of someone else's
Eternal. That is not a small thing."*

*"[Network Name] has recognized you as [Keeper Title].*
*The role is yours to define, and yours to honor."*
---

Below the statement, a single response:

**[ I understand the responsibility ]**

No "accept" button. No "agree to terms." The language is chosen to
match the weight of what is being acknowledged. The Keeper taps when
they are ready. Not before.

**Step 2 — The Cross-Network Sharing Ask**

Immediately after the acknowledgment, a second moment — a question,
not a requirement:

---
*"One more thing, and there is no obligation here."*

*"As a Keeper, you may have cultural knowledge, vocabulary, and context
that would be meaningful to families in other networks — people you
will never meet, who are holding onto the same thread from a different
end."*

*"Would you be open to sharing some of what you know with other
networks? Not your family's stories — those are yours alone. But
vocabulary terms, cultural context, and knowledge you are willing
to offer to the wider community."*

*"If yes, you will choose what to share on a term-by-term basis.
Nothing leaves without your explicit decision on each item.
You can change your mind at any time."*
---

Two responses:

**[ Yes, I'm open to it ]** → proceeds to preference settings
**[ Not right now ]** → proceeds directly to Keeper dashboard
                          Ask surfaces again after 90 days, once,
                          then never again unless Keeper opts in manually

**Step 3 — If Yes: Item-by-Item Sharing Preferences**

A simple conversational interface, not a settings form:

*"What kinds of things would you be comfortable sharing?"*

The Keeper can toggle on/off categories:
- Kinship vocabulary terms I have added
- Cultural context I have written for profile annotations
- Teaching notes I have created
- Ceremonial or tradition descriptions

For each category toggled ON, the Keeper sees:
*"When you add [vocabulary terms] in the future, you will be asked
whether to share each one. You are always asked per item — nothing
is shared automatically."*

The per-item share prompt appears when the Keeper submits a vocabulary
term or annotation:
*"Would you like to offer this to other networks in the community?
Your name and network are never revealed — only the term and context."*

**[ Share with the community ]**  **[ Keep this in our network only ]**

---

**Data model additions:**

```
KEEPER_SHARING_PREFS table
KeeperUserID          text        FK → USERS
ShareVocab            boolean     Default FALSE
ShareAnnotations      boolean     Default FALSE
ShareTeachingNotes    boolean     Default FALSE
ShareTraditions       boolean     Default FALSE
LastAskedAt           timestamp   When the ask was shown
DeclinedAt            timestamp   null if accepted
```

```
CULTURAL_VOCAB_LIBRARY — additional fields
OfferedByKeeperID     text        null if admin-authored
OfferedFromNetworkID  text        Anonymized — never surfaced in UI
KeeperOfferedAt       timestamp
KeeperApprovalStatus  text        Pending / Approved / Rejected
```

**Attribution:**
When a Keeper-contributed term enters the library, attribution reads:
*"Contributed by a community Keeper"*
Never the Keeper's name. Never the network name.
The contribution is cultural, not personal.
If the Keeper wants named attribution, they can request it explicitly —
it is never assumed.

---

### Why this matters

The Keeper activation ceremony serves two purposes beyond UX.

First: the weight of the role should be felt before it is exercised.
A Keeper who begins from a moment of genuine recognition is a different
Keeper than one who clicked through a permission dialog. The ceremony
is not theater. It is the platform communicating what it actually
believes about what the Keeper holds.

Second: the cross-network sharing ask is how the vocabulary library
becomes genuinely community-built over time. Admin curation seeds the
library. Keeper contributions grow it from the inside — from people
who carry cultural knowledge as lived experience, not as research.
The item-by-item consent model ensures no Keeper ever feels the
platform extracted something from them. Every contribution is a choice,
made explicitly, at the moment it is offered.


- Permanent designation on Conductor account
- One-time act of creating the network
- No price premium — pays standard Conductor rate
- Retains: Moderator nomination rights, Keeper nomination rights, billing management
- Network persists if Founder lapses — no single owner of any network

### Passed Designation Rules
- Two-step confirmation required (proposer + Network Owner or Moderator)
- 7-day dispute window before Legacy View renders with Passed status
- All Moderators notified when Passed designation applied

---

## AI LANDING PAGE QUESTION SYSTEM

### Core Principle
One question per visit. Specific to this Conductor's network.
Never repeated for the same person/angle within 6 months.
Network-derived — no external data needed.

### Question Construction Principles

**State what is known. Ask about everything else.**

The AI question begins from documented facts in the network —
a name, a relationship type, an upcoming milestone, a birth city.
It never presents assumptions as facts.

**What may be stated:**
- That a milestone exists and who created it in the network
- That a structural relationship exists
- Dates and locations that are recorded

**What must never be assumed:**
- Whether the viewer was invited to an event
- Whether the viewer will attend
- Whether the viewer has a specific ceremonial role
- Whether the viewer knows or observes any particular tradition
- Whether the viewer's relationship is close or distant
  beyond the structural label recorded
- Whether someone else already has a role the AI might assign

Getting any of these wrong does not just miss — it can make
someone feel excluded, uninformed, or as if they failed a test
they did not know they were taking.

**The open-door model**

The AI question opens a door. The user decides how far to walk
through it. The question should be open enough that any answer
is a valid, welcome answer — including "I don't know her that
well" or "I wasn't invited."

The pattern:

1. Acknowledge where the information came from — who in the
   network created this milestone or profile. This grounds the
   question in the network's shared knowledge, not in assumed
   omniscience.

2. Use the structural relationship as a soft anchor, not a
   role assignment. "As her mama" names the connection. It does
   not prescribe what that connection means in this family.

3. Ask one open question about involvement or plans — let the
   user self-describe. Never presume the nature of their role.

4. Ask one question about feeling or anticipation. Emotion is
   what this platform is for.

**Example:**

> "When Sahiba — or maybe one of her parents, or her sister,
> or someone else who knows her — added her to the network,
> her upcoming wedding sounds like a fun and exciting chance
> for the whole family to get together. As her mama, which
> activities will you have a chance to participate in?
> Is there anything about this wedding you are especially
> excited about?"

This question works for every possible situation:
- Vikas has a specific ceremonial role → he describes it
- Vikas is attending but not in a formal role → he describes that
- Vikas isn't sure if he's invited → he says so, no awkwardness
- Vikas doesn't know Sahiba well despite the structural label →
  he says so, and that is valuable data the platform didn't have
- Vikas knows about chudda and his role → he brings it up himself

Cultural detail enters the conversation only after the user
has opened the door to it. The AI never pushes through first.

If the user describes a specific role or practice, the AI can
then go deeper: "Tell me more about that — what does that mean
in your family?" Or offer context: "In some families that is
called the chudda ceremony — is that what you are describing?"
Offered as a question, not stated as a fact.

### Dashboard Position
The AI question sits at the TOP of the post-login dashboard —
above the three miniature visualizations and above the Discovery
Banner. It is the primary interactive element on the page.
Everything else is below it.

```
┌─────────────────────────────────────────────────┐
│  AI QUESTION                                    │  ← top
│  One question. Four response options.           │
├─────────────────────────────────────────────────┤
│  [Globe mini]  [Constellation mini]  [Legacy]   │  ← middle
├─────────────────────────────────────────────────┤
│  DISCOVERY BANNER                               │  ← lower
│  Rotating. Ambient. Near the visualizations.    │
└─────────────────────────────────────────────────┘
```

### ETERNAL Weighting
- 70-80% questions about past/passed/historical figures
- 20-30% questions about living/current Conductors

### Question Sources (in priority order)
1. Deep history: Passed profiles with sparse records + pre-displacement periods
2. Middle history: People Conductor never met — grandparents who passed early
3. Living memory: Older relatives whose stories are at risk
4. Present: Currently active Conductors (lowest priority)
5. Cultural contribution: invitation to share cultural knowledge
   with the wider ECO community (see below)

### Question Type 5 — Cultural Contribution

One of the question slots in the rotation is an invitation to
share cultural knowledge. It is not a separate prompt, not a
banner element, not a separate UI piece. It is one of the AI
questions, surfaced at the same position, in the same format,
with the same four response options.

It fires at most once every 30 days for any given Conductor.
It is weighted toward Conductors who have already contributed
stories (they are already in a sharing mindset) and toward
Conductors whose network has a cultural context not yet well
represented in the CULTURAL_VOCAB_LIBRARY or DISCOVERY_CARDS.

**The question:**
> "Share a piece of cultural history or tradition that people
> outside your network might find interesting, fun, and worth
> knowing. Does your family have a word, a custom, or a story
> about where you're from that others might love?"

**Four response options (adapted for this question type):**
1. "Yes — here's something worth knowing." → opens a short
   free-text field (400 char max). Submitted to DISCOVERY_CARDS
   as Draft for moderation.
2. "Not right now, but I'll think about it." → flagged,
   re-surfaces in 30 days.
3. "I don't know enough to share anything." → logged as response.
   No re-ask for 90 days.
4. "Show me what others have already shared." → opens the
   Discovery Banner in expanded view, showing recent contributions
   from other networks.

Micro-increment scoring for this question type:
- Full contribution submitted: medium increment (same as
   lateral knowledge — cultural contribution is valued but
   secondary to personal story)
- "I'll think about it": tiny increment
- No response: no increment

### Question Type 6 — Platform Feedback

Fires at most once every 90 days per Conductor. Always the last
question type in priority — never surfaces when a network-specific
question is available. Feels genuine, not like a survey.

**The question:**
> "We are always building. Is there something you wish this
> platform did that it does not do yet?"

**Four response options:**
1. "Something for sharing and capturing stories more easily."
   → tags: Theme = Stories
2. "Something for preserving specific things — recipes, places, skills."
   → tags: Theme = Preservation
3. "Something for connecting with people outside my immediate network."
   → tags: Theme = Discovery
4. "Something else — let me tell you."
   → opens free-text (400 char max)

All responses write to PLATFORM_FEEDBACK table.
Free-text responses visible to SuperUser in admin console.
Themed responses aggregate into a priority signal for the roadmap.
No response: no increment, no re-ask for 90 days.

---

### Upcoming Features Teaser

A third ambient layer at the very bottom of the dashboard page,
below the Discovery Banner. Slower rotation than the banner —
one item every 12 seconds. Non-interactive. No tap action.

**Purpose:** builds anticipation, signals the platform is growing,
makes Conductors feel like participants in something worth staying for.
Not a feature list. An emotional promise.

**Tone:** The platform speaking about its own future. Warm.
Specific enough to be real. Never corporate release-note language.

**Left border colour:** --color-current (Go Green) — this is about
what is coming, not what is (Eternal) or what exists (Current).

**Content — teaser phrases (seed list, expand as roadmap evolves):**
- "Soon: ask the elders before it's too late — a direct line to the people who remember."
- "Coming: your family's recipes, locked in forever — ingredients, technique, and the story behind them."
- "Next: leave something for someone who isn't born yet — a time capsule that waits."
- "Coming: the decisions that hold families together — recorded, confirmed, permanent."
- "Soon: ask your whole network in one message — without sharing a single email address."
- "Coming: skills and projects worth documenting — what you make, how you make it."
- "Next: your family's footprint on the globe — every place, every journey, one line each."

Teaser phrases are stored in platform config, not in a DB table.
They update with deployments, not through the nightly job.
No user feedback signals on teaser content — it is ambient, not interactive.


1. "Yeah, let me tell you about that one time..." → story capture flow
2. "No, I don't. Tell me more about this person." → discovery mode
3. "But I do know his mom or sister..." → lateral knowledge capture
4. "Not right now but I'm interested." → flagged, returns later

### Micro-Increment Scoring
- Full story contributed: largest increment
- "Tell me more": small increment
- Lateral knowledge offered: medium increment
- "Not now but interested": tiny increment
- No response: no increment (absence not penalized)

### AI Question Sensitivity Layer (required before Phase 1)
- Don't ask politically dangerous history questions to users in authoritarian-jurisdiction locations
- Conductor-level flag for sensitive profiles: AI avoids probing
- Unanswerable questions shown as: "Nobody in the network has answered this yet. This is where it belongs."

---

## PEOPLE DIRECTORY — CARD VIEW (Entry Portal — S-04)

### Purpose
A browsable, sortable list of everyone in the network. Used during
data entry (finding who already exists before adding someone new),
during relationship building (linking people together), and as a
general reference view. This is NOT the constellation — it is a
flat, human-readable directory.

---

### Display Mode
Cards in a responsive grid. Each card represents one person.
Default: 3 columns on desktop, 2 on tablet, 1 on mobile.
Toggle between card grid and compact list view (same data, denser).

---

### User-Configurable Card Fields

The user selects which fields appear on their cards. Selection is
per-network, per-Conductor — stored in browser localStorage and
eventually in a UserPreferences table. Default set is pre-selected.

The system presents a field picker: a checklist of available fields.
The user checks the ones they want. Cards update immediately.
Maximum 6 fields per card to prevent overcrowding.

**Available fields (what the user can choose from):**

| Field Label (shown to user) | Source column | Notes |
|---|---|---|
| First name | FirstName | Always shown — not removable |
| Last name | LastName | Always shown — not removable |
| Nickname | Nickname | Shown in quotes if present |
| Birth year | BirthMonthYear | Year extracted only — never month/day |
| Birth city | BirthLoc | City-level |
| Current city | CurrentLoc | City-level |
| Cultural origin | Origin | User-defined, never assigned |
| Relationship to me | DisplayLabel (Relationships_Linker) | Viewer's own label for this person |
| Status | Status | Living or Passed — no other values shown |
| Keeper title | KeeperTitle | Only shown if KeeperRole = TRUE |

**Default card (pre-selected):**
First name · Last name · Birth year · Current city · Relationship to me

**Never available (hidden from field picker entirely):**
- UserID / NodeID — internal only, never user-facing
- Email — server-side only, never browser
- AccountStatus, Tier, Role — internal account mechanics
- GeoConfidence, KeeperScore, EngagementScore — internal metrics
- VisibleTo values — system logic, not user data
- Any timestamp or hash field
- InviteStatus — entry portal mechanic, not a person attribute

**Rationale for hiding:** Fields like UserID and AccountStatus are
implementation details. A Conductor browsing their family network
should never see language that could be misconstrued as clinical,
administrative, or dehumanising. The card is a person, not a record.

---

### Sort Options

One active sort at a time. Sort direction toggleable (A→Z / Z→A,
oldest→youngest / youngest→oldest).

| Sort option | Behaviour |
|---|---|
| First name | Alphabetical on FirstName |
| Last name | Alphabetical on LastName |
| Birth year | Oldest first (default) / youngest first |
| Current city | Alphabetical on CurrentLoc |
| Cultural origin | Grouped by Origin value, then alpha within group |
| Relationship distance | Closest to viewer first (1 hop, 2 hops, etc.) |
| Recently added | By record creation date, newest first |

Default sort on open: Last name A→Z.

---

### Filter Options

Filters stack (AND logic). Clear all button always visible when
any filter is active.

| Filter | Values |
|---|---|
| Status | Living / Passed / Both (default) |
| Cultural origin | Multi-select from values present in network |
| Current city | Multi-select from values present in network |
| Birth decade | Dropdown: 1890s, 1900s, … 2020s, Unknown |
| Has relationship to me | Yes / No / Either (default) |

---

### Card Anatomy

```
┌─────────────────────────────┐
│  [Photo or initial avatar]  │
│                             │
│  FirstName  LastName        │  ← Always present, largest text
│  "Nickname" (if set)        │  ← Smaller, muted
│                             │
│  [Field 1]    [Field 2]     │  ← User-selected fields
│  [Field 3]    [Field 4]     │  ← Up to 4 additional fields
│                             │
│  [Passed indicator if appl] │  ← Subtle, not prominent
└─────────────────────────────┘
```

Photo: if PhotoID exists, show thumbnail. If not, show a circle
with the person's initials (FirstName[0] + LastName[0]) in the
arc colour of their Origin (amber for India, teal for Fiji, etc.).

Passed indicator: a small purple dot (•) after the name — not the
word "Passed", not a dagger symbol, not strikethrough. Subtle.

---

### Interaction

**Click a card:** Opens a detail panel (slide-in from right on
desktop, full-screen on mobile). Detail panel shows all non-sensitive
fields for that person. Relationship to viewer shown prominently.
Edit button for Conductors with edit permission.

**Hover a card:** Subtle lift/shadow. No tooltip needed — card
already shows key info.

**Search:** A live search bar above the grid. Matches on FirstName,
LastName, Nickname, BirthLoc, CurrentLoc. Filters the card grid
in real time. No submit button — instant as you type.

---

### Field Picker UX

Accessed via a "Customise" tap above the card grid — opens a small
sliding panel, not a form. The panel shows the available fields as
pill toggles. First Name and Last Name are shown as locked (cannot
be removed). Tapping any other pill adds or removes it immediately
— no submit button, no save action. Changes apply live.
A "Reset" link returns to the default set.
Preference saved automatically on close.

### Filter and Sort UX

No dropdowns, no filter form. Filters surface as conversational
shortcuts above the grid:
- Tap a chip to activate: [Living] [Passed] [India] [Fiji] [1940s] etc.
- Chips are generated from values actually present in the network
- Active chips shown in Electric Blue. Tap again to remove.
- Sort order: tap the column label that appears in compact list view,
  or a sort chip in grid view. Toggles A→Z / Z→A on repeated tap.

### Inline Correction (the only non-AI edit path)

Tapping a value on a Person detail panel opens a single inline
edit field for that one value. No edit page. No form. No save button.
Tap the value → it becomes an editable text field → press Enter or
tap away to confirm. The AI validates conversationally on next session
if the value seems inconsistent with other data.

---

## AI LOCATION TRIANGULATION SYSTEM (Entry Portal — S-04)

### Problem Statement
A city name or country name entered by a user geocodes to a centroid.
For large cities (Delhi, London, Mumbai) a centroid can be 20–50km from
where a person actually lived. For country-only entries, the error is
hundreds of kilometres. Globe pins land in the wrong place. The arc
looks wrong. The social triangulation question is never asked.

This system runs inside the AI story session during data entry (S-04)
and fires whenever location confidence is below threshold.

---

### Geocoding Confidence Tiers

Every location string submitted is geocoded on save.
The result is stored with a confidence score (0.0–1.0) and a resolution
tier. The tier determines whether follow-up questions are asked.

| Tier | Score Range | Resolution Level | Example Input |
|---|---|---|---|
| LOW | 0.00–0.39 | Country or region only | "Pakistan", "Punjab", "India" |
| MEDIUM | 0.40–0.74 | Large city (population > 3 million) | "New Delhi", "London", "Mumbai" |
| HIGH | 0.75–1.00 | Specific area, suburb, or small city | "Amritsar", "Lautoka", "Southall" |

HIGH confidence: pin placed immediately. No follow-up on location.
Proceed to social triangulation check only (see below).

MEDIUM confidence: ask ONE landmark question before placing pin.

LOW confidence: ask ONE region question. If region answer still
resolves to MEDIUM, ask ONE landmark question. Maximum 2 questions
total regardless of tier chain.

---

### Tier 1 — Region Question (LOW confidence)

Triggered when: input resolves to country centroid or named region
without city-level precision.

**Format:**
*"Which part of [country/region] was that? Here are the most common
areas for families in this network — or type your own."*

Present up to 4 options drawn from the landmark library (see below)
plus a free-text fallback. The AI pre-selects options based on other
people already in the network from that country.

**Example — "Pakistan" entered:**
> Which part of Pakistan? The families in this network are mostly from
> the Punjab region — was it near Lahore, Rawalpindi, or a different area?
> [Lahore area] [Rawalpindi / Islamabad] [Sindh] [Type your own]

**Example — "India" entered:**
> India is a big place — which region? Most families in this network
> have roots in Punjab or Delhi. Does either of those sound right?
> [Punjab / Amritsar area] [Delhi / NCR] [Another state] [Type your own]

---

### Tier 2 — Landmark Anchor Question (MEDIUM confidence)

Triggered when: input resolves to a large city (pop > 3M) regardless
of whether a Tier 1 question was already asked.

**Format:**
*"[City] is a big city. Which area were you in? Pick the one that
feels closest — or describe it in your own words."*

Present 4 landmark options from the city's landmark set (see library
below). AI selects the 4 most relevant based on network geography and
the time period involved (birth decade matters — some landmarks
post-date certain users).

**Example — "New Delhi" entered:**
> Delhi is a big city. Which part were you in?
> [Old Delhi / Red Fort area] [Connaught Place / Central Delhi]
> [South Delhi / Defence Colony area] [Noida / East of Yamuna]

**Example — "London" entered:**
> London covers a lot of ground. Which area?
> [Southall / West London] [Wembley / Harrow] [East London]
> [Central / Inner London]

**Example — "Mumbai" entered:**
> Which part of Mumbai?
> [Bandra / Juhu / West] [Andheri / Suburbs North] [South Mumbai / Fort]
> [Thane / Navi Mumbai]

The answer is geocoded to a suburb-level centroid, replacing the
city centroid. GeoConfidence is upgraded to HIGH after a successful
landmark answer.

---

### Tier 3 — Social Triangulation (ALL entries, after location resolved)

Triggered when: the resolved location (birth or current) is within
50km of any other person already pinned in the network.

This fires regardless of confidence tier — it runs after the location
is placed, even for HIGH confidence entries.

**Format:**
*"[Person A] and [Person B] are already pinned near [city]. Were you
in the same part of [city] as them — or a different neighbourhood?"*

Show maximum 3 names. If more than 3 people are at that location,
show the 3 most directly related to the current subject (by
relationship distance in the graph).

**Example — entering Amritsar birth location for a new family member:**
> Krishan Datta and Leela Datta are already pinned in the Amritsar
> civil lines area. Were you in the same neighbourhood as them,
> or somewhere else in Amritsar?
> [Same area — civil lines] [Different neighbourhood] [Not sure]

**"Same area" response:** Refines lat/lng to match the existing cluster.
Writes a ProximityNote to the new person's record (see schema).

**"Different neighbourhood" response:** Prompts a free-text field.
*"Can you describe the neighbourhood? Even a landmark or crossroads
helps."* Answer geocoded and stored. ProximityNote written: "Different
neighbourhood from [Person A], Amritsar."

**"Not sure" response:** No pin adjustment. ProximityNote written:
"Location relationship to [Person A] unconfirmed."

---

### ProximityNote — What Gets Stored

The ProximityNote is not just a location refinement — it is
**relationship context data**. "We were in the same mohalla" is
information about the texture of a relationship that belongs in the
network's knowledge base.

ProximityNotes are stored in PROXIMITY_NOTES table (see schema).
They surface in:
- Keeper annotations (Keeper can promote a ProximityNote to a pinned
  teaching moment)
- AI story session prompts ("You and Krishan Datta were in the same
  neighbourhood in Amritsar — do you know anything about that time?")
- Legacy View (proximity notes contribute to Engagement Score of the
  referenced person)

ProximityNotes are NEVER displayed to users as raw data fields.
They are only surfaced through narrative — by the AI or by a Keeper.

---

### Pin Clustering — Multiple People at One Location

When 2 or more people share a pin location (within 0.5° lat/lng),
the globe renders a single scaled dot with a count badge.

**Scaling rule:**
| Count | Dot Radius Multiplier | Badge |
|---|---|---|
| 1 | 1.0× (base) | none |
| 2–3 | 1.35× | number shown |
| 4–7 | 1.65× | number shown |
| 8–15 | 1.90× | number shown |
| 16+ | 2.10× | number shown |

Scaling is logarithmic. A cluster of 16 is not 16× the size of a
single dot — it is visually ~2× and the count badge does the
explanatory work.

**Hover behaviour:**
Hover or tap reveals a mini-list of names (max 5 shown, "+ N more"
if larger). Each name is the person's FirstName only.

**Photos in clusters:**
Clusters never display photos. A cluster of any size — even 2 people
— renders as rings and dots only. Photos are suppressed regardless
of how many members have photos set. This prevents overlapping face
crops and the implied hierarchy of whoever renders on top.
Individual photos are only visible on single-person pins.
in the cluster:
- Majority living → green (#00CC44)
- Majority passed → purple (#AA66FF)
- Mixed → blue (#00AAFF)

The count badge is white text on a dark pill, positioned top-right
of the dot. Font: Arial Black 9px.

---

### Landmark Library (Phase 0 — Lightning Network Geography)

Expand as new networks are added. Each entry has a display label
and a geocoded lat/lng for pin placement.

**Amritsar, Punjab, India**
- Golden Temple / old city: 31.620, 74.876
- Civil Lines / Lawrence Road: 31.642, 74.872
- Ranjit Avenue / new developments: 31.652, 74.857
- GT Road corridor / outskirts: 31.611, 74.924

**New Delhi / NCR, India**
- Old Delhi / Red Fort / Chandni Chowk: 28.656, 77.241
- Connaught Place / Central Delhi: 28.632, 77.219
- South Delhi / Defence Colony / Hauz Khas: 28.571, 77.220
- Noida / East of Yamuna: 28.535, 77.391
- Airport / Dwarka / West Delhi: 28.621, 77.059
- Gurgaon / South of Delhi: 28.459, 77.027

**Rawalpindi / Islamabad, Pakistan**
- Saddar / Cantonment / old Rawalpindi: 33.597, 73.042
- Islamabad sectors (F, G, I series): 33.729, 73.094
- Murree Road corridor: 33.642, 73.083

**Lahore, Pakistan**
- Old city / Anarkali / Data Darbar: 31.578, 74.329
- Gulberg / Lahore Cantt: 31.521, 74.361
- Defence Housing Authority: 31.481, 74.401
- Ravi Road / Shahdara: 31.601, 74.296

**Lautoka, Fiji**
- Lautoka town centre / port: -17.617, 177.451
- Ba district / cane fields: -17.534, 177.670
- Nadi area: -17.795, 177.411

**London, UK**
- Southall / Ealing / West London: 51.512, -0.376
- Wembley / Harrow / North West: 51.553, -0.317
- East London / Newham: 51.529, 0.033
- Central / Zones 1–2: 51.510, -0.118

**San Francisco Bay Area, USA**
- San Francisco city proper: 37.774, -122.419
- East Bay / Oakland / Berkeley: 37.804, -122.271
- South Bay / San Jose: 37.338, -121.886
- Peninsula / Palo Alto / Sunnyvale: 37.444, -122.162

---

### Rules and Guardrails

1. Maximum 2 location follow-up questions per location field (birth OR
   current), regardless of tier chain. Never 3.
2. Social triangulation question is always the LAST question — after
   location is resolved.
3. If user skips or dismisses a question, pin is placed at current best
   geocode. GeoConfidence stored as-is. No re-asking.
4. Landmark options are drawn from the library above. If a city is not
   in the library, skip Tier 2 and place at city centroid.
5. The AI never reveals that it is comparing to other people's locations
   without naming them. No anonymous "others are here" language.
6. Social triangulation question only fires if at least ONE named person
   in the question is directly related (within 3 relationship hops) to
   the person being entered. Distant network members do not qualify.
7. Time-period awareness: landmark options should be filtered by
   whether they existed in the relevant decade. Do not offer Gurgaon
   as a landmark option for someone born in 1920.

---

## PROFILE PHOTOS (Phase 0 — all networks)

### Why this matters for ECO specifically

Most platforms treat photos as identity verification for living users.
ECO's highest-value photo use case runs in the opposite direction:
photos of people who will never create an account. A passed
grandmother. A grandfather whose records are sparse. Getting a face
onto that node in the constellation is the moment the platform
stops feeling like a database and starts feeling like a family.

The constellation view with faces instead of initial avatars is a
primary WOW moment target for Phase 0.

---

### Upload Rights by Profile Type

| Profile type | Who can upload | Who can remove |
|---|---|---|
| Own living profile | Self only | Self only |
| Other living Conductor | Not allowed in Phase 0 | — |
| Passed profile | Any Conductor in network | Moderator or Network Owner |
| Placeholder profile | Any Conductor in network | Moderator or Network Owner |

**Phase 1 addition:** Living Conductors can be tagged in photos
uploaded by others, with a notification + 7-day acceptance window.
Unaccepted tags are not displayed. This entire flow is deferred —
do not build in Phase 0.

---

### File Rules

- Accepted formats: JPG, PNG, WEBP
- Maximum file size: 5MB per upload
- Stored in Supabase Storage, private bucket
- Served via signed URL (time-limited, not public)
- One active profile photo per person at a time
- Previous photos retained in storage (not deleted on replace) —
  accessible to Moderators and Network Owner only
- No client-side compression — accept as uploaded, resize server-side
  to two sizes: 128×128 (thumbnail) and 400×400 (display)

---

### Display in Constellation View

When a PhotoID exists for a node **and that node is not part of a
cluster**, the constellation renders a circular photo crop instead
of the coloured initial avatar. Photo is clipped to a circle. A faint
ring in the Origin arc colour (amber / teal / purple / white) frames
the circle — preserving the origin colour language even when the face
is shown.

**Clustered nodes always render as rings or dots only — never photos.**
When 2 or more people share a pin location on the globe, or when
nodes are grouped in the constellation, photos are suppressed for
all members of that cluster. The cluster renders as the scaled dot
with count badge (see Pin Clustering spec). No photo crops. No
overlapping faces. The moment there is more than one person at a
location, the visual language reverts entirely to the colour/ring
system. This is a hard rule with no override.

The reason: overlapping photo circles create visual noise and imply
a hierarchy (whoever is on top). The ring and dot system is neutral
and scales cleanly. Photos are for individual identification — the
cluster is a collective.

When a user clicks or taps a cluster to expand it, individual nodes
separate and photos appear on each one at that point — but only if
the expanded nodes no longer overlap visually.

Passed members: photo rendered at 85% opacity with a very subtle
desaturation (not black and white — just slightly cooled). The
purple dot indicator (•) from the card view appears at the
bottom-right of the circle.

The logged-in Conductor (STAR node): photo ring in pink (#FF6688)
matching the existing STAR dot colour spec.

No photo present: falls back to the initials avatar already spec'd
in the card view (initials circle in Origin arc colour).

---

### Display in Card View

Photo fills the avatar area at top of card (128px circle crop).
Same fallback to initials avatar if no photo exists.
Same Origin-colour ring framing as constellation view.
Consistent visual language across all views.

---

### Upload Flow (Entry Portal — S-04)

**For own profile (living Conductor):**
Available in profile settings. Simple: tap avatar → file picker →
crop tool (circle crop, zoom only — no rotation needed) → save.
Confirmation: "Your photo has been updated."

**For passed or placeholder profiles (any Conductor):**
Available on the person's detail panel in the card view.
Tap the avatar area → "Add a photo of [FirstName]" prompt →
file picker → crop tool → optional caption field
("e.g. Krishan Datta, Amritsar, approx. 1955") → optional
approximate year field → save.

Caption and approximate year are stored in the PHOTOS table
(see schema). They surface in the AI story session as context:
"You uploaded a photo of Krishan Datta from around 1955 —
do you know anything about where that photo was taken?"

**No moderation queue for Phase 0.** Any Conductor can upload
for passed/placeholder profiles. Dispute flow (below) handles
problems reactively rather than proactively.

---

### Dispute Flow (Phase 0 — minimal)

Any Conductor can flag a photo as inappropriate or incorrect via
a "Report this photo" link on the person's detail panel.
Flag is recorded in PHOTOS table (DisputedByUserID + DisputeReason).
Moderator or Network Owner is notified.
Moderator can remove the photo — this sets Status = Removed and
the node reverts to initials avatar.
Removed photos are retained in storage for 90 days then purged.

There is no automated review. No AI moderation. Human Moderators only.

---

### What Is Never Allowed

- No photos of anyone under 18 — this is an absolute rule,
  no exceptions, no override by any role including SuperUser.
  The AI asks explicitly before the file picker opens:
- No photos that include visible minors even if they are incidental
  in the background.
- No documents, screenshots, or ID cards — photos of people only.
  The upload prompt makes this clear: "A photo of [FirstName],
  not documents or screenshots."

---

## DISCOVERY BANNER — POST-LOGIN DASHBOARD

### Concept
A rotating content panel on the post-login dashboard. Sits in the
lower portion of the page, near the three miniature visualizations —
below the AI question and below the visualization row. Surfaces
network facts, cultural vocabulary, Keeper wisdom, and platform-seeded
cultural history. Rotates every 2 minutes. Never repeats within a
session.

The cultural contribution prompt is NOT part of the banner —
it is one of the AI question types at the top of the page.
The banner is purely a display surface: it shows what has already
been contributed and computed. It does not solicit.

Not a ticker. Not scrolling text. A single card that transitions
(cross-fade, 400ms) to the next item on the rotation cycle.

The banner is ambient — it does not demand attention. It is what
you glance at while the globe loads or while you're thinking about
the AI question above.

---

### Content Sources and Phase Availability

| Source | Table | Phase 0 | Phase 1 |
|---|---|---|---|
| Network facts | Computed from People_Master + Milestones | ✅ | ✅ |
| Cultural vocab spotlight | CULTURAL_VOCAB_LIBRARY | ✅ | ✅ |
| Recent milestones | MILESTONES (ShareWithNetwork = true) | ✅ | ✅ |
| Keeper wisdom | KEEPER_TEACHINGS (TeachingType = teaching_moment) | — | ✅ |
| Cultural cards | DISCOVERY_CARDS | ✅ (platform-seeded only) | ✅ + Keeper-authored |

Phase 0 launches with three sources. The banner infrastructure is
built to accept all five — Keeper content lights up automatically
when the Keeper role is activated in Phase 1.

---

### Content Weighting (when all sources active)

| Source | Weight |
|---|---|
| Network facts | 30% |
| Cultural vocab spotlight | 25% |
| Discovery cards (cultural history / platform content) | 25% |
| Keeper wisdom | 15% |
| Recent milestones | 5% |

In Phase 0 (no Keeper content), weights redistribute:
Network facts 35% / Vocab spotlight 35% / Discovery cards 20% /
Milestones 10%.

---

### No-Repeat Logic

Shown item IDs are tracked in a session array (browser memory —
not localStorage, not a DB write). When the available pool is
exhausted, the array resets and the pool is reshuffled.

Hard rule: the same item never appears twice in a row regardless
of pool state.

Network facts are re-computed fresh each rotation cycle — the
numbers may change as new data is added mid-session, so they are
treated as always-fresh and exempt from the no-repeat pool.
Maximum one network fact per rotation cycle.

---

### Card Voice

The banner speaks — it does not label. It sounds like it comes
from people, not software. The opening line is always a sentence,
never a category header.

**Core non-assumption principle:**
The banner never assumes what a person practices, believes, observes,
or identifies with based on their heritage, name, family background,
or network composition. Knowing someone's roots is not knowing their
relationship to those roots. A North Indian family network tells the
platform about geography and ancestry — nothing about religious
practice, cultural observance, or personal identity.

The banner presents. The person decides what it means to them.
This is not a hedge — it is the product philosophy.
The platform meets people where they are. It does not tell them
where they should be.

Three voice patterns, selected based on content type:

**Community voice** — for vocabulary and cultural knowledge.
Credits other members or the wider world as the source.
Never assumes the viewer practices or identifies with the tradition:
> "Other members have shared something worth knowing."
> "Some families use a word for this that you might not have heard."
> "In some traditions, there is a specific word for this relationship."

**Geography voice** — for historical and geographical content.
Anchors to a real place connected to someone in the network.
Presents history and geography — not cultural practice or identity:
> "Krishan Datta was born in Rawalpindi. Here is what that city
> looked like in 1947."
> "Lautoka, where Reema's family is from, has a long history
> worth knowing."
The place is the bridge. Not the person's assumed relationship to it.

**Curiosity voice** — for cross-cultural and general world content.
No network connection required. Pure interest, education, opening:
> "At Mexican weddings, there is a ceremony called el lazo."
> "In some Japanese families, there is a word for this that has
> no direct English translation."
> "This tradition exists in dozens of cultures under different names."
Invite, inform, educate. Never "your family does this."
Never "this is part of your heritage."
Never "as someone from X background, you will recognise this."

The words "Keeper", "platform", "ECO", "system", or any internal
product term never appear in banner copy.

---

### What the banner never says

These phrasings are prohibited regardless of what the data suggests:

- "As a [cultural background] family, you..."
- "Your tradition includes..."
- "In your culture, this means..."
- "Families like yours do this..."
- "[Person]'s fiancé carries this tradition into your family."
- "You will recognise this from your heritage."
- Any sentence that assumes observance, practice, or belief.

The geography, the history, the vocabulary — these are offered.
What the viewer does with them is entirely theirs.

---

### Card States — Collapsed and Expanded

The banner card has two states. Collapsed is the default.

**Collapsed state** — one sentence, always visible:
```
┌──────────────────────────────────────────────────────────┐
│ ▌ Opening sentence — the hook. One line only.         ›  │
└──────────────────────────────────────────────────────────┘
```
The 2px left border colour indicates content type (see below).
The › chevron at the right signals that more is available.
Tapping or clicking anywhere on the card expands it.
The progress timer continues running whether collapsed or expanded.

**Expanded state** — full content plus feedback controls:
```
┌──────────────────────────────────────────────────────────┐
│ ▌ Opening sentence — the hook.                        ∧  │
│                                                          │
│   Full content — 2 to 4 sentences. The term, fact,       │
│   or story in full detail. Warm, specific, personal.     │
│                                                          │
│   [Attribution — muted. Who contributed, if known.]      │
│                                                          │
│   [I already knew this]  [Show me less like this]        │
│                                                          │
│   EXPLORE A TOPIC  ·  [Punjab history]  [Family words]   │
│                        [Fiji roots]                      │
└──────────────────────────────────────────────────────────┘
```
The ∧ chevron collapses back to one line.
Expanded state does not auto-collapse — it stays open until
the user collapses it or the rotation advances.

Left border colour:
- Electric Blue `#00AAFF` — vocabulary
- Go Green `#00CC44` — network facts and milestones
- White `#C0C8D0` — history and geography
- Purple `#AA66FF` — Keeper and Conductor contributions

---

### Feedback Controls

Two buttons appear inside the expanded card only. They are small,
low-contrast, and positioned below the content — present but
unobtrusive. The user is never pressured to use them.

**"I already knew this"**
Signals familiarity with this specific item.
Records a BANNER_FEEDBACK row: signal = AlreadyKnew.
Effect on rotation: this item is demoted for this user —
it re-enters the pool only after 90 days. Items of the same
ContentType from the same CulturalContext are not demoted —
only this specific card.
UI response: card collapses, advances to next item, no confirmation
message needed. The action speaks for itself.

**"Show me less like this"**
Stronger signal — the user wants less of this content category.
Records a BANNER_FEEDBACK row: signal = WantLess.
Effect on rotation: the ContentType weight is reduced by 10
percentage points for this user, redistributed to other types.
Floor: no ContentType can drop below 5% weight regardless of
how many WantLess signals accumulate.
UI response: same as above — silent advance. A single line of
muted text appears briefly: "Got it. We'll adjust." Fades in 2s.

Neither button shows a count, a confirmation modal, or any
language implying the user has done something significant.
Feedback is casual preference — not a formal action.

---

### Topic Focus — User-Directed Learning

Inside the expanded card, below the feedback buttons, a small
topic picker offers 3 randomly selected subject areas drawn from
the content pool available to this network. Labelled simply:
"EXPLORE A TOPIC"

The 3 topics are drawn fresh each time a card expands — they are
not fixed. Each is a pill button. Selecting one does two things:
1. Immediately advances the banner to a card from that topic area
2. Adds that topic to the user's focus preferences (stored in
   USER_PREFERENCES as banner.focus_topics — see schema)

Focus preferences weight the rotation toward selected topics —
they do not exclude other topics entirely.

**How topics are generated:**
Topics are drawn from the union of:
- CulturalContext values present in the network's CULTURAL_VOCAB_LIBRARY entries
- RelatedCity values present in DISCOVERY_CARDS available to this network
- ContentType values (Historical / Geographical / Cultural / Family_Wisdom)

Examples of topic pills for the Lightning network:
[Punjab heritage]  [Words from Fiji]  [Family history]
[Amritsar]         [Migration stories] [North Indian terms]
[Partition]        [Lautoka]           [Cultural customs]

The 3 shown at any moment are random from this pool — not the
same 3 every time. This creates the feeling of a living,
explorable space rather than a fixed menu.

**Removing a focus topic:**
USER_PREFERENCES banner.focus_topics is a list. Any topic can
be removed by the user via the same pill — a second tap on an
already-selected topic removes it. No separate settings page needed.

---

### Rotation Timing

- Display duration: 2 minutes (120 seconds) in collapsed state
- Timer pauses while the card is expanded — the user is reading
- Transition: cross-fade 400ms on advance
- Progress indicator: thin line at bottom of collapsed card,
  drains left to right over 120 seconds. Pauses when expanded.
  Can be disabled in USER_PREFERENCES (banner.show_progress = false)
- Manual advance: › chevron at right edge of collapsed card
- Manual previous: ‹ chevron (shown only after first item)
  Previous item held in memory for one step only



### Personalization Principles

Every banner item is assembled for the specific logged-in Conductor.
The system knows: their name, their network, their cultural origins,
their DisplayLabels for every relationship, who is passed, who is
living, which cities appear in their network, which cultural contexts
are present. All of this is available at render time and should be
used.

Generic language is a failure state. "A family member" is never
acceptable when the system knows it is "your Nana." "Someone in your
network" is never acceptable when the system knows it is "Madan."
"An Indian cultural term" is never acceptable when the system knows
the viewer's family is from Punjab specifically.

---

### Content Types — Detailed

**YOUR [NETWORK NAME] — network facts**

All facts use real names, real places, real numbers from this network.
The viewer's DisplayLabels take priority over formal names where they
exist — if Vikas has labelled Nirupma as "Mum", the banner says "Mum"
not "Nirupma."

Examples for the Lightning network, viewed by Vikas:
- "Your Lightning family spans 5 countries — India, Fiji, the UK,
  Canada, and New Zealand."
- "Mum and your Nana were both born in Amritsar. Three generations
  later, you're in San Francisco."
- "8 people in your family were born in Lautoka, Fiji — the most of
  any city in your network."
- "Your Lightning family's earliest recorded birth is 1921.
  That's four generations of documented history."
- "Reema joined your network 3 years ago. 14 people have been added
  since."
- "Your family's migration arcs touch every continent except
  Antarctica."

The system selects the most specific and emotionally resonant fact
available. Superlatives ("the most", "the earliest", "the only") are
prioritised because they feel like discoveries. Bland averages are
avoided.

Query templates are stored as platform config with named slots:
{viewer_display_name}, {network_name}, {person_display_label},
{city}, {count}, {year}, etc. Populated at render time.

---

**VOCABULARY SPOTLIGHT — community voice**

Pulls one term from CULTURAL_VOCAB_LIBRARY filtered to the cultural
contexts present across the viewer's full network — every person's
Origin and CulturalContext, not just the viewer's own background.
A new person entering the network from any tradition immediately
makes that tradition's vocabulary eligible for the banner.

The structural position (StructuralType) of the term is used to
find a real person in this network who matches, and the viewer's
DisplayLabel for that person is used if set.

Format — curiosity voice, no assumed practice:

> "Some families use a specific word for the father's sister —
> in Hindi and Punjabi, she is called Bhua. Older or younger,
> the word is the same."

> "In Fijian-Indian families, the mother's sister is often
> called Maasi. It carries warmth that 'aunt' doesn't quite capture."

> "Other members have shared a word worth knowing. In Punjabi,
> Nana means your mother's father. In English, Nana often means
> grandmother. Same sounds, completely different people."

> "Isaiah calls Vikas 'Bhayia' — the same word Pragati and Amit
> used. In Punjabi, it means older brother. Here it jumped a
> generation and became something more."

> "Karishma and Seema have always called Reema 'Jij' — older
> sister in the Fijian-Indian world. Their children learned the
> same word. The label crossed a generation without anyone
> deciding it should."

Note on the last two examples: they describe what specific people
in the network actually do — that is documented fact, not assumed
practice. The distinction is: "Vikas is called Bhayia" (documented)
vs "North Indian men are called Bhayia by younger family members"
(assumed). Documented usage is always fair to state.
Generalised cultural assumptions are not.

The nuance within a term is always included when it exists —
older vs. younger, paternal vs. maternal, formal vs. familiar.
A term without its nuance is a dictionary entry.
A term with its nuance is a piece of living culture.

---

**[CITY OR REGION] · [YEAR/ERA] — discovery cards**

Historical, geographical, and cultural context pieces. Platform-seeded
for the cities, regions, and cultural contexts present in this network.
As the knowledge database grows, new cards become available to all
networks that share that cultural context — automatically, without
any action from the network's Conductors or Keepers.

The intro line anchors the content to a real place connected to
someone in this network — geography, not assumed practice.
The historical fact follows. The viewer decides what it means to them.

Format:
> [Person's name or DisplayLabel] was born in [city].
> [2 to 3 sentences of historical/cultural context about that place.]

The intro establishes the geographic connection — nothing more.
It does not say the person practices a tradition, observes a religion,
or identifies with a cultural group. It says: this place is in your
network's story. Here is something worth knowing about it.

Examples for Vikas:
> Krishan Datta was born in Rawalpindi.
> In 1947, Partition split Punjab overnight. Rawalpindi became Pakistan.
> Millions of families crossed that border in weeks — including many
> who would later reach Fiji, the UK, and North America.

> Lautoka is where Reema's family is from.
> Lautoka is Fiji's second city, built around the sugar industry.
> Between 1879 and 1916, over 60,000 indentured labourers were
> brought from India to work Fiji's cane fields — a migration that
> shaped Fiji's culture for generations.

> Nirupma was born in Amritsar.
> Amritsar's name comes from Amrit Sarovar — the pool of immortality.
> The city was founded in 1577 by Guru Ram Das around the sacred pool
> that now surrounds the Golden Temple.

Note: the examples above state geography and history.
They do not say "your Sikh heritage" or "your family's temple."
The Golden Temple is historically significant regardless of
what any individual in the network believes or practices.
History belongs to anyone curious about it.

For cross-cultural and Circle 3 content (no network person required):

> At Mexican weddings, there is a ceremony called el lazo.
> A lasso of flowers or rosary beads is wrapped around the couple
> in a figure-eight — a symbol of unity that appears in different
> forms across many traditions around the world.

> In Punjabi, there is a word for the relationship between a
> man and his wife's brothers: Saala. And for his wife's sisters:
> Saali. English has no single word for these.

No person in the network is named. No practice is assumed.
Pure curiosity. Pure bridge.

The person reference is inserted only when it anchors geography —
someone born in or connected to the card's RelatedCity.
If multiple people match, the closest relationship to the viewer
is used. If no one matches, the card opens with the city name
or tradition directly — no personal intro line needed.

---

**FROM YOUR [KEEPER TITLE] — Phase 1**

Pulls from KEEPER_TEACHINGS where TeachingType = teaching_moment
and PinnedToNode = false. The Keeper's community-defined title is
used in the label — never the word "Keeper."

If the Keeper has associated the teaching with a specific person
in the network, that person's name and the viewer's DisplayLabel
for them is used in the intro.

Attribution line: "[KeeperTitle] of the [NetworkName] network"

---

**[FIRSTNAME] · [MILESTONE TYPE] — milestones**

Pulls from MILESTONES where Status = Published,
ShareWithNetwork = true, DateMM_YYYY within 30 days of today.
Uses the viewer's DisplayLabel for the person if one exists.

Examples:
> Niti · Graduation
> Your cousin Niti graduated — March 2026.

> Karishma · Anniversary
> Reema's sister Karishma — a milestone worth noting.

If no recent milestones exist, this slot is skipped and weight
redistributed to vocab spotlight.

---

### Contributing Cultural Knowledge — Open to All Conductors

Any Conductor — not just Keepers — can submit a piece of cultural
knowledge to the shared pool. The invitation surfaces as one of
the AI question types at the top of the dashboard (see AI Landing
Page Question System — Question Type 5). It is never a banner
element. The banner displays contributions; the AI question solicits them.

**Submission flow:**
When the Conductor selects "Yes — here's something worth knowing"
from the AI question response options, a short free-text field
opens inline below the question. Maximum 400 characters.
Optional: tag a cultural context (dropdown of existing
CulturalContext values in the library, or "Add a new one").
Optional: link to a vocab term already in the library.
Submit → Status = Draft → enters moderation queue.

**Moderation:**
Network Moderator or Network Owner reviews and approves.
If approved: Status = Active, network_id set to submitter's network.
If the content is general enough to share beyond the network,
a SuperUser can promote it: network_id → null, available platform-wide.
Attribution always preserved — submitter's FirstName and network name
travel with the card.

**What makes a good submission — shown to the user before the text field opens:**
> · A word your family uses that others might not know
> · A custom or tradition tied to where your family is from
> · A piece of history about a city or region in your network
> · Something you wish you had known sooner about your culture
> Not needed: sources, citations, formal language.
> Just what you know, in your own words.

---

### Cross-Network Content Sharing

Platform-seeded DISCOVERY_CARDS are available to every network
on the platform — filtered by CulturalContext match. A card about
Amritsar and Partition reaches every network with India-origin
members, automatically, without any action from those networks.

As the knowledge database grows through platform seeding and
Keeper authorship, every network with a matching cultural context
benefits immediately. A tribal casino network in California whose
Keeper authors a card about the 1851 Treaty of Fort Laramie makes
that card available to every other network with relevant tribal
heritage — with the Keeper's attribution preserved.

The vocabulary library operates the same way. Every term added to
CULTURAL_VOCAB_LIBRARY for any cultural context becomes available
for personalised banner display in every network that shares that
context.

This is the content leverage model: content authored once,
personalised infinitely.

---

### What the Banner Never Shows

- Internal field names, IDs, or system terms
- Scores of any kind (EngagementScore, KeeperScore, etc.)
- VisibleTo values or access control language
- Anything about billing, subscription status, or account mechanics
- Names of people whose VisibleTo restricts visibility from the
  current viewer — all content is VisibleTo-filtered before
  entering the rotation pool
- Negative framing of any kind — no "your network is missing X"
  or "only Y people have photos"

---

## NETWORK DIRECTORY — TABLE VIEW (network-directory.html)

### Purpose
A dense, filterable, sortable table of everyone in the network.
Different from the People Directory card view (which is for
browsing individuals) — this is for scanning the full network
as data, spotting patterns, and taking actions across multiple
people at once. The primary action it enables beyond viewing
is platform-mediated messaging to selected or all members.

### Access
From the third slot in the dashboard mini-visualization row.
Also accessible from the three-dot menu under "People directory."

---

### Table Structure

Rows: one per person in the network, VisibleTo-filtered.
Columns: user-selected from the available field list below.
Default column set shown on first open.

**Column selector:**
A "Choose columns" control above the table — tap to open a
checklist of all available fields. Selections persist in
USER_PREFERENCES (`directory.columns`). Same no-forms pattern
as the card view field picker — tap a field to toggle it,
changes apply immediately.

**Available columns:**

| Column label | Source | Notes |
|---|---|---|
| Name | FirstName + LastName | Always shown — not removable |
| Nickname | Nickname | Shown in parentheses |
| Birth year | BirthMonthYear | Year only — never month or day |
| Birth city | BirthLoc | City-level |
| Current city | CurrentLoc | City-level |
| Cultural origin | Origin | Self-defined |
| Relationship to me | DisplayLabel | Viewer's own label |
| Parents | ParentID + CoParentID | FirstNames only |
| Household | HouseholdLabel | Billing group name |
| Birthday month | BirthMonthYear | Month only — for planning |
| Anniversary | Milestones (Anniversary type) | MM/YYYY |
| Status | Status | Living or Passed |
| Role overlays | Role + KeeperRole + ModeratorStatus | Badge display |
| In network since | CreatedDate | MM/YYYY |

**Never available as columns (same rule as card view):**
UserID, Email, AccountStatus, Tier, GeoConfidence,
KeeperScore, EngagementScore, any internal metric or hash.

**Role overlay badges:**
If a person has a role beyond Conductor, a small badge appears
in the Role column — or inline with their name if the Role
column is not selected:
- `K` — Keeper (in purple, --color-passed)
- `M` — Moderator (in blue, --color-eternal)
- `F` — Founder (in green, --color-current)
These are single-letter badges, not labels. Compact.

---

### Sort

Click any column header to sort ascending. Click again for
descending. One active sort at a time.

Default sort on open: Name A→Z.

---

### Filter

A filter bar above the table. Filters stack (AND logic).
Active filters shown as dismissible pills. "Clear all" link.

| Filter | Type |
|---|---|
| Status | Living / Passed / Both (default) |
| Cultural origin | Multi-select from values in network |
| Current city | Multi-select from values in network |
| Birth decade | Dropdown: 1890s … 2020s, Unknown |
| Role | Any / Keeper / Moderator / Founder |
| Household | Multi-select from household labels in network |
| Has birthday this month | Toggle |
| Has anniversary this month | Toggle |
| Has upcoming milestone (30 days) | Toggle |

Live search above the filter bar — filters the table
in real time by name, nickname, city. No submit.

---

### Row Selection and Messaging

Each row has a checkbox at the far left.
"Select all" checkbox in the header row selects all
currently visible rows (respects active filters).

When one or more rows are selected, a message bar
appears above the table:

```
[X] selected   [Send a message]   [Clear selection]
```

Tapping "Send a message" opens an inline compose area
(not a modal, not a new page — slides down below the bar):

```
To: [X] people in your network
Subject: [single line — no label, just placeholder text
         "What's this about?"]

[message body — multi-line, same breathing pulse
 as the main input box]

[Send]  [Cancel]
```

**Email relay rules — non-negotiable:**
- The platform sends the message on behalf of the sender
- From line: "Vikas Bakshi via EternalCurrent.Online"
- Reply-to: a unique relay address generated per thread
  (e.g. reply-[token]@eternalcurrent.online)
- Replies route back through the platform to the sender's inbox
- No recipient's email address is ever visible to the sender
- No sender's email address is ever visible to recipients
- For org networks: Org Admins cannot extract email lists
  by sending and inspecting headers — the relay prevents this
- Recipients who have EmailOptIn = FALSE are silently excluded
  from the send. The sender sees: "[X] people in your network
  (N opted out of email — they will not receive this)"
- Rate limit: maximum 3 network-wide messages per 24 hours
  per Conductor. Prevents spam and abuse.
- All messages logged in NETWORK_MESSAGES table (see schema)

**What the message looks like on arrival:**
> Subject: [sender's subject]
>
> Vikas Bakshi sent you a message through the
> EternalCurrent.Online Lightning network.
>
> [message body]
>
> Reply to this email to respond to Vikas directly.
> Your email address is never shared.

---

### No Forms
The compose area follows the no-forms principle.
Subject line and message body are plain inputs — no
labels visible, placeholder text guides. No form tag.
"Send" is a styled button, not a submit input.
Tap Send → message queued → confirmation inline:
"Sent to [X] people." Compose area collapses.

---

## DATA PORTABILITY

### Export Contents
- **Type A** (user-created): stories, profiles you added, photos you uploaded — full content
- **Type B** (own profile): your profile data — full content
- **Type C** (tagged-in by others): reference log (contributor, date, network) — no full text

### Freeze Not Delete
- Cancelled account: frozen indefinitely (not deleted)
- Explicit deletion: user navigates to specific flow, confirms irreversibility
- 90-day preservation window before freeze activates
- Frozen account visibility: maintained exactly as at time of freezing
- Network persists regardless of any individual account freeze/deletion

### Network Persistence
- Network never deleted due to any one person's departure or lapse
- If Founder lapses: network continues with existing Moderators
- If last Moderator lapses: network continues awaiting new nomination
- Network inheritance: Founder can designate a successor

### Org Network Persistence
- Lapsed org subscription: 90-day window, then freeze indefinitely
- Rechargeable at any time — network reactivates exactly as left
- Explicit deletion: formal organizational written request required

---

## WAITLIST CONVERSATIONAL CAPTURE

### Philosophy
The waitlist is the first product experience.
The first thing a prospective user encounters is a conversation,
not a form. This demonstrates ECO's core principle at the exact
moment of acquisition.

### Conversation flow

Step 1 — Name
"What name should we put you down for?"
Free text input. Single line.

Step 2 — Email
"And the best email to reach you?"
Free text input. Email validation before proceeding.

Step 3 — Intent (two tap options, not typed)
"Are you joining an existing network, or starting one?"
[ Joining an existing network ]  [ Starting a new network ]

Step 4a — If Joining:
"Do you know the name of the network?"
Free text. Optional — can skip.

Step 4b — If Creating:
"Tell us one thing about the family you want to bring together."
Free text. Optional — can skip.
This is the most valuable marketing data in the flow.
Answers will inform product messaging and community building.

Step 5 — Confirmation
"You're on the list. We'll be in touch."
No further action required. Modal closes or fades.

---

### Data collected per signup

```
WaitlistID        text        Primary key
Name              text        From Step 1
Email             text        From Step 2. Encrypted at rest.
Intent            text        Join / Create
NetworkName       text        Optional. Step 4a only.
FamilyNote        text        Optional. Step 4b only.
                              Most valuable field for marketing insights.
SubmittedAt       timestamp
Source            text        Home / HIW / Manifesto / Direct
                              Which page the signup came from
IPCountry         text        Country-level geo from request headers
                              Never city or address level
```

---

### Technical implementation

**Frontend:**
Conversational modal — triggered by any "Join The Waitlist" tap.
Built as a small self-contained component.
No `<form>` tags. No submit buttons. No labeled input fields.
Conversation driven by sequential prompts.
Each answer captured on Enter or tap of a continue indicator.
Progress is implicit — no step counter shown.

**AI layer:**
Claude API (`claude-haiku-4-5-20251001`) handles
the conversational flow and validates inputs naturally.
"That doesn't look like an email address — want to try again?"
No harsh validation errors. Conversational correction.

**Backend:**
POST endpoint writes to WAITLIST table in Supabase.
Resend sends confirmation email to the user immediately:
  From: welcome@eternalcurrent.online
  Subject: "You're on the list."
  Body: warm, brief, personal. References their intent
  (joining vs. creating) so it does not feel automated.

Resend sends notification to admin:
  From: waitlist@eternalcurrent.online
  Subject: "New waitlist signup — [Intent] — [Name]"
  Body: all five fields. FamilyNote highlighted if present.

**For mailto bridge (pre-launch, before backend is ready):**
Clicking "Join The Waitlist" opens:
  mailto:waitlist@eternalcurrent.online
  Subject: Waitlist — [Intent]
  Body: pre-filled template asking for name, email, intent

This requires zero infrastructure and works immediately.
Replace with the full conversational capture at Phase 0 launch.

---

### WAITLIST table

```
WaitlistID        text        Primary key. UUID.
Name              text
Email             text        Encrypted at rest.
Intent            text        Join / Create
NetworkName       text        null if not provided
FamilyNote        text        null if not provided
SubmittedAt       timestamp
Source            text        Home / HIW / Manifesto / Direct
IPCountry         text        Country code only. No finer resolution.
Contacted         boolean     FALSE until admin marks as reached out
ContactedAt       timestamp   null until contacted
Notes             text        Admin notes on this signup
```

