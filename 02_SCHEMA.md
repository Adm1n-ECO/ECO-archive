# ECO Schema Reference
**Database:** Supabase (PostgreSQL UTF-8)
**Network:** lightning-001 (pilot)
**Rule:** network_id on EVERY row from day one.

---

## PERMANENT DATA RULES
1. BirthMonthYear = MM/YYYY only — never the day
2. network_id = lightning-001 on every row
3. Ghost Node filter = `WHERE status != 'Placeholder'`
4. No street addresses — city-level only
5. No SSNs, passport numbers, government IDs ever
6. UserIDs locked after first Save
7. Email NEVER returned in any API browser response — server-side only
8. EmailOptIn and MilestoneOptIn default FALSE — explicit opt-in required
9. PassedMonthYear = MM/YYYY only (same rule as BirthMonthYear)
10. DisplayLabel in Relationships_Linker is Conductor-owned — system never overwrites
11. Data gaps are intentional — conversation starters, not errors

---

## PEOPLE_MASTER
```
UserID                text        Primary key. Locked after first Save.
FullName              text
FirstName             text
MiddleName            text        null ok
LastName              text
Nickname              text        null ok
Role                  text        SuperUser / NetworkOwner / Moderator / Keeper / Conductor / Guest
Status                text        Living / Passed / Placeholder
Tier                  text        Conductor / ProConductor / OrgAdmin / Free_Forever
Gender                text
Origin                text        Cultural origin — user-defined, never assigned
BioParent             text        For adopted/complex lineage — see VisibleTo rules
BirthMonthYear        text        MM/YYYY only
BirthLoc              text        City-level only
CurrentLoc            text        City-level only
CurrentLat            float       Auto-geocoded from CurrentLoc
CurrentLng            float       Auto-geocoded from CurrentLoc
BirthLat              float       optional fallback
BirthLng              float       optional fallback
GeoConfidenceBirth    float       0.0–1.0. Confidence of BirthLoc geocode. LOW <0.40 / MED 0.40–0.74 / HIGH ≥0.75
GeoResolutionBirth    text        Country / Region / City / Landmark / Exact
GeoConfidenceCurrent  float       0.0–1.0. Confidence of CurrentLoc geocode.
GeoResolutionCurrent  text        Country / Region / City / Landmark / Exact
HouseholdID           text
ParentID              text
CoParentID            text
PartnerID             text
PartnerType           text
SocialLinks           text
PhotoID               text        FK → PHOTOS.PhotoID. Active profile photo. null = no photo set.
InviteStatus          text        Pending / Opened / Registered / Completed
VisibleTo             text        'public' / 'network' / [UserID,UserID] / 'owner' / 'archive'
Notes_Bio             text
network_id            text        lightning-001 on every row
Email                 text        NEVER returned to browser — server-side only
EmailOptIn            boolean     FALSE default — explicit opt-in required
PromptFrequency       text        Weekly / Monthly / Never
MilestoneOptIn        boolean     FALSE default
PassedMonthYear       text        MM/YYYY only
AccountStatus         text        Active / Grace / Frozen / Deleted
GraceStartDate        date
ArchiveDate           date
DeletionDate          date
SponsorUserID         text        UserID of billing sponsor; null = self-pay
HouseholdLabel        text        Billing group display name
EventWindowOptIn      boolean     FALSE default
TrialStartDate        date
TrialEndDate          date
TrialStatus           text        Active / Expired / Converted
HasEverLoggedIn       boolean     FALSE default
OnboardingProgress    text        null = not started
StorySessionNotes     text        AI populates during onboarding session
ModeratorSince        MM/YYYY
NominatedBy           text        UserID
ModeratorStatus       text        Active / Inactive
KeeperRole            boolean     FALSE
KeeperTitle           text        null until designated (Elder, Storyteller, etc.)
KeeperSince           MM/YYYY
KeeperScore           float       Behavioral metric — NEVER displayed to any user
EngagementScore       float       Community-sourced accumulation score
TemporalDistanceIndex float       Generations from viewer — drives Legacy View sky position
LegacyViewHash        text        Network state hash at last render
LegacyViewRendered    timestamp   When last render was generated
LastDeltaAt           timestamp   Updated whenever this profile or its relationships change.
                                  The nightly job uses this to determine who needs fresh content.
                                  Set by DB trigger on any write to People_Master or
                                  Relationships_Linker rows where SubjectID = this UserID.
NetworkContentHash    text        Hash of profile + relationship state at last content generation.
                                  Compared against current state to detect stale questions.
```

---

## RELATIONSHIPS_LINKER
```
SubjectID             text        UserID — the person holding this view of the relationship
TargetID              text        UserID — the person being described
RelationType          text        Child / Parent / Sibling / Spouse / Friend / Cousin /
                                  BioParent / BioChild
                                  This is the structural truth — how a family tree
                                  would categorise the relationship.
Branch                text        Paternal / Maternal / Step / Adopted / Cultural / etc.

DisplayLabel          text        Conductor-defined. The word actually used in this family.
                                  System NEVER overwrites. Always takes display priority
                                  over RelationType. This is the experienced truth.
                                  e.g. "Bhayia" / "Jij" / "Nana" / "Bhabbi" / "Mama"
                                  Can be any word in any language.

DisplayLabelSource    text        Who established this label — how did it come to be used?
                                  Self = the TargetID chose this label for themselves
                                  Peer = peers of the same generation established it
                                  Inherited = the label came from a prior generation
                                    and transferred down (the most common case for
                                    aunt/uncle labels in South Asian families)
                                  Cultural = the label is standard for this relationship
                                    in this cultural context (no individual choice involved)
                                  null = not recorded

DisplayLabelOriginID  text        If DisplayLabelSource = Inherited: which relationship
                                  row is the label inherited from?
                                  FK → RELATIONSHIPS_LINKER (SubjectID + TargetID composite)
                                  Lightning network examples:
                                  — Vikas is called "Bhayia" by Isaiah and by the
                                    children of Reema's sisters. The label originated
                                    with Pragati (Vikas's younger sister) and Amit
                                    (Vikas's younger brother) — they called him Bhayia
                                    as younger siblings naturally would. The label then
                                    transferred to anyone who grew up around them.
                                    DisplayLabelOriginID points to Pragati → Vikas row
                                    (or Amit → Vikas row — either is valid as the origin).
                                  — Reema is called "Jij" by her sisters Karishma and
                                    Seema, and by Reema's other cousins. Their children
                                    inherited the label from them.
                                    Isaiah (Vikas's adopted son) calls Reema "Jij" —
                                    not a maternal term — because he grew up seeing
                                    Karishma, Seema, and Reema's cousins use it.
                                    Pragati's daughters do the same.
                                    DisplayLabelOriginID for Isaiah → Reema points to
                                    Karishma → Reema row (or Seema → Reema).
                                    RelationType = Parent (structural truth).
                                    DisplayLabel = Jij (experienced truth).
                                    Both are correct. Neither overrides the other.
                                  null if not Inherited or not known.

DisplayLabelCulturalContext text  The cultural tradition this DisplayLabel comes from.
                                  Should match a CulturalContext value in
                                  CULTURAL_VOCAB_LIBRARY where possible.
                                  e.g. "Hindi / Punjabi" for Bhayia
                                      "Fijian-Indian" for Jij
                                  null if not culturally specific or not known.

DisplayLabelVocabID   text        Optional FK → CULTURAL_VOCAB_LIBRARY.VocabID
                                  Links this DisplayLabel to the vocabulary entry
                                  for that term if one exists.
                                  Enables: banner cards that reference real usage
                                  ("Your family calls Vikas 'Bhayia' — here is
                                  what that word carries in Punjabi tradition.")

Note                  text        Freeform context — any nuance not captured by the fields above.
                                  e.g. "Label stuck because Reema's sisters used it first —
                                  even Isaiah uses it now."
VisibleTo             text        Same values as People_Master
network_id            text
```

**Core principle:**
RelationType = structural truth (for graph traversal, relationship distance,
Legacy View scoring, validation).
DisplayLabel = experienced truth (for all display to Conductors).
These are almost always different in real families and both matter.
The system uses RelationType to reason. It uses DisplayLabel to speak.

**Inherited label rules:**
When DisplayLabelSource = Inherited, the AI entry session asks:
"Who did [person] learn to call [target] by this name from?"
The answer populates DisplayLabelOriginID.
The validation run checks that DisplayLabelOriginID points to an
active relationship row — flags if the origin relationship was
deleted or the person has passed with no successor label noted.

---

## JOURNEYS_MEDIA
```
JourneyID             text
PersonID              text
LocationName          text
Category              text        Birth / Residency
Reason                text
Year                  text
MediaID               text
VisibleTo             text
network_id            text
```

---

## MILESTONES
```
MilestoneID           text
PersonID              text
AnnouncedByUserID     text
network_id            text
MilestoneType         text        Marriage / Graduation / Birthday_Milestone / Anniversary / Birth / Custom
Title                 text
Description           text
Location              text
DateMM_YYYY           text        MM/YYYY only
MediaID_1..5          text
ShareWithNetwork      boolean     FALSE default
CelebrationsOptIn     boolean
Status                text        Draft / Published / Archived
CreatedDate           MM/YYYY
LastUpdated           MM/YYYY
```

---

## INVITES
```
InviteID              text
InviterUserID         text
InviteeEmail          text
InviteeUserID         text        null until they register
InviteType            text        Network / Referral
NetworkID             text
SentDate              timestamp
OpenedDate            timestamp
RegisteredDate        timestamp
CompletedDate         timestamp
ReferralCredit        float       Credit earned (tracked for retroactive reward)
Status                text        Pending / Opened / Registered / Completed / Expired
```

---

## EVENT_WINDOWS
```
EventWindowID         text
NetworkID             text
MilestoneID           text
CreatedByUserID       text
ShareableToken        text        Unique URL token
WindowDuration        integer     Days
ExpiryDate            date
ViewCount             integer
Status                text        Active / Expired / Archived
```

---

## CULTURAL_VOCAB_LIBRARY
```
VocabID               text        Primary key
CulturalContext       text        e.g. "North Indian", "Coast Miwok", "Japanese"
Language              text        Language name — used for dropdown in review request system
StructuralType        text        Father / Mother / Grandfather_Paternal /
                                  Grandfather_Maternal / Grandmother_Paternal /
                                  Grandmother_Maternal / Uncle_Paternal / Uncle_Maternal /
                                  Aunt_Paternal / Aunt_Maternal /
                                  Sibling_Older_Male / Sibling_Older_Female /
                                  Sibling_Younger_Male / Sibling_Younger_Female /
                                  Sibling_Older / Sibling_Younger / Cousin /
                                  Spouse / Child_Son / Child_Daughter /
                                  Grandchild / Nephew / Niece / InLaw_Prefix /
                                  Honorific_Suffix / Collective / Family_Friend /
                                  Elder / Other
                                  Note: Japanese and Korean require gender+age on
                                  sibling terms. Other cultures may only need Sibling_Older/
                                  Sibling_Younger. Use the most specific applicable value.
Term                  text        The word in the native language
NativeScript          text        The term in its native writing system
                                  (kanji, Devanagari, Arabic script, etc.)
                                  Optional for languages using Latin script.
Romanization          text        Pronunciation guide
RegisterType          text        Humble / Honorific / Neutral / Archaic / Affectionate
                                  Humble = used for your own family to outsiders
                                  Honorific = used for others' family or direct address
                                  Neutral = no register distinction
                                  Archaic = historically used, now dated
                                  Affectionate = informal/diminutive form (chan, ji, etc.)
                                  This field is critical for Japanese, Korean, Hindi, and
                                  any language where social register is encoded in the word.
                                  English has no equivalent — this is what translation loses.
EnglishApproximation  text        The closest English equivalent — with the understanding
                                  that it is always an approximation. Never call it a
                                  translation. It is a pointer, not an equivalent.
Description           text        Plain text — what the term means and its cultural weight
NuanceNote            text        Older/younger distinction, formal/informal, regional variants.
                                  This is the field that makes it feel like living culture,
                                  not a dictionary. Never leave blank if nuance exists.
UsageExample          text        Optional — one sentence showing the term in natural use.

Theme                 text[]      Kinship / Language / Migration / Displacement / Religion /
                                  Food / Ceremony / Occupation / Grief / Celebration /
                                  Coming_of_Age / Elder_Wisdom / Community

GenerationalPattern   text[]      First_Gen / Second_Gen / Third_Gen_Plus / All_Generations

AudienceResonance     text[]      Under30 / 30_to_50 / Over50 / All_Ages

RelatedVocabIDs       text[]      Optional FKs to related terms in same or other cultures.

SourceType            text        Academic / Tribal / Community / Self_Reported
ContributedBy         text        UserID or org name
TribalOwner           text        Tribe name if tribally owned — null otherwise
RestrictedFlag        boolean     FALSE default. TRUE = requires tribal confirmation
Status                text        Pending / Active / Retired
AddedDate             MM/YYYY

ExpertConfirmed       boolean     FALSE until ≥2 independent expert reviewers confirm
ExpertConfirmCount    integer     Running count of confirming reviewers
ExpertFlagCount       integer     Running count of reviewers who flagged this term
LastReviewedAt        timestamp   Date of most recent expert review action
ExpertNotes           text        Aggregated nuance additions from all expert reviewers
                                  (appended, not overwritten, as new reviews come in)
```

**Matching rules for nightly job:**
- Primary match: CulturalContext against network's active cultural contexts
- Secondary match: StructuralType against viewer's actual relationship graph
  (find who in the network occupies this StructuralType position for this viewer)
- Tertiary filter: GenerationalPattern, AudienceResonance against viewer's profile
- Terms with NuanceNote populated are prioritised over bare definitions
- Terms with RelatedVocabIDs enable cross-cultural bridge cards
  ("Your family uses Nana — here is what other cultures in the ECO community call theirs")

---

## KEEPER_TEACHINGS
```
TeachingID            text
NetworkID             text
KeeperUserID          text
RelatedProfileID      text        null if not annotating a specific person
RelatedMilestoneID    text        null if not annotating a milestone
TeachingType          text        annotation / vocabulary_note / teaching_moment / cultural_card
TeachingText          text
VisibleTo             text
CreatedDate           MM/YYYY
PinnedToNode          boolean     FALSE
```

---

---

## PHOTOS
Stores profile and historical photos. One active profile photo per
person at a time (People_Master.PhotoID points to the active one).
Previous photos are retained — never hard-deleted until 90-day purge
after Removed status.

```
PhotoID               text        Primary key
SubjectUserID         text        FK → People_Master.UserID — person the photo is OF
UploadedByUserID      text        FK → People_Master.UserID — who uploaded it
network_id            text
StoragePath           text        Supabase Storage path — private bucket
ThumbnailPath         text        128×128 resized version path
DisplayPath           text        400×400 resized version path
Caption               text        Optional — free text e.g. "Amritsar, approx. 1955"
ApproxYear            text        Optional — 4-digit year string, not a date type
                                  Stored as text because "approx. 1955" is valid input
PhotoType             text        Profile / Historical
Status                text        Active / Replaced / Disputed / Removed
UploadedDate          timestamp
DisputedByUserID      text        null unless flagged
DisputeReason         text        null unless flagged
DisputeDate           timestamp   null unless flagged
ModeratorUserID       text        null unless actioned
ModeratorAction       text        null / Removed / Cleared
ModeratorActionDate   timestamp   null unless actioned
PurgeAfter            date        Set to 90 days after Status = Removed
```

**Rules:**
- When a new photo is set as active: old PhotoID Status → Replaced,
  People_Master.PhotoID updated to new PhotoID
- Removed photos: StoragePath retained until PurgeAfter date,
  then storage object deleted and StoragePath nulled
- SubjectUserID must exist in People_Master before photo can be uploaded
- Photos where SubjectUserID has Status = Living and
  UploadedByUserID ≠ SubjectUserID are blocked in Phase 0
  (enforced at API layer, not DB constraint)
- ApproxYear is free text — do not cast to integer — "1940s" is valid
- No photos of minors (under 18) — enforced at upload UI with explicit
  confirmation step; API layer also validates Subject BirthMonthYear
  if known

---

## BANNER_STATEMENTS
The rotating statement library for the home page banner.
One statement displayed per page load, drawn from approved statements.
Grows over time through AI proposal and admin approval.

```
StatementID         text        Primary key
Text                text        Statement text. Max 140 chars total.
Status              text        Active / Paused / Retired / Pending
Source              text        Founding / AI_Proposed / Admin_Authored
ProposedAt          timestamp
ApprovedAt          timestamp   null until approved
ApprovedBy          text        Admin UserID. null if founding set.
RetiredAt           timestamp   null until retired
EngagementScore     float       Composite: avg dwell time + manifesto CTR
TimesShown          integer     Running total across all users
AIReasoning         text        Why the AI proposed it. null if admin-authored.
AIConfidence        float       0–1. null if admin-authored.
WeightMultiplier    float       Default 1.0. Admin increases for campaigns.
WeightExpiresAt     timestamp   When multiplier reverts to 1.0. null if default.
```

**Rotation rules:**
- One statement per page load
- No repeat on consecutive page loads for same user
- Full rotation before repeats (weighted shuffle)
- Admin can boost weight of specific statements for a period
- Engagement score updated nightly from BANNER_IMPRESSIONS

## BANNER_IMPRESSIONS
One row per statement shown to a user. Powers engagement scoring.

```
ImpressionID        text        Primary key
StatementID         text        FK → BANNER_STATEMENTS
UserID              text        FK → USERS (anonymized in aggregate)
ShownAt             timestamp
DwellSeconds        integer     How long the banner was visible
ClickedThrough      boolean     Whether user clicked to manifesto
```

---

## BANNER_FEEDBACK
Records each feedback signal from the Discovery Banner.
Event data — one row per button press. Drives rotation weighting
for this user. Never shown to the user in any form.

```
FeedbackID            text        Primary key
UserID                text        FK → People_Master.UserID
network_id            text
CardID                text        FK → DISCOVERY_CARDS.CardID — null for computed content
ContentType           text        Vocabulary / NetworkFact / Historical / KeeperWisdom / Milestone
CulturalContext       text        From the card's CulturalContext — null if not applicable
Signal                text        AlreadyKnew / WantLess
CreatedDate           timestamp
```

**How the rotation algorithm uses this table:**

AlreadyKnew signals:
- The specific CardID is suppressed for this UserID for 90 days
- No effect on ContentType weighting
- Computed content (NetworkFact) cannot be suppressed — no CardID

WantLess signals:
- ContentType weight reduced by 10 percentage points for this UserID
- Minimum floor per ContentType: 5% (cannot be weighted to zero)
- Recalculated each session from cumulative WantLess count
- No ceiling — a user can signal WantLess multiple times for the
  same ContentType, each time reducing by a further 10 points
  until the 5% floor is reached

Focus topic selections (from USER_PREFERENCES banner.focus_topics)
add positive weight — they do not subtract from other types.
WantLess and focus topics operate independently.

---

## DISCOVERY_CARDS
Platform-seeded and Keeper-authored short content pieces for the
Discovery Banner. The long-term value of ECO is in the richness of
this database — every card written once serves every matching network
forever. Tags are the matching engine. Get them right from the start.

```
CardID                text        Primary key
network_id            text        null = platform content (all networks)
                                  set = network-specific (Keeper-authored)
AuthorType            text        Platform / Keeper / Conductor
AuthoredByUserID      text        null if Platform; UserID otherwise
Title                 text        Internal reference only — never displayed

CollapsedText         text        Single hook sentence — shown in collapsed banner state.
                                  Written at authoring time, not generated at display time.
                                  May contain {person_name} slot for name insertion at display.
                                  Max 120 characters.
ExpandedText          text        Full content — 2 to 4 sentences. Plain text only.
                                  May contain {person_name}, {network_name}, {city} slots.
                                  Max 400 characters.
AttributionText       text        Muted credit line. null if platform content.
                                  e.g. "Contributed by Reema · Lightning network"

CulturalContext       text[]      Array — matches against network's active cultural contexts.
                                  e.g. ["North Indian", "Punjabi", "Sikh"]
                                  null = general content, shown to all networks
RelatedCity           text[]      Array — cities this card is about or references.
                                  Matched against BirthLoc / CurrentLoc in network.
                                  e.g. ["Amritsar", "Lahore", "Rawalpindi"]
Era                   text[]      Historical period(s) relevant to this card:
                                  Pre_1900 / 1900_to_1947 / 1947_to_1970 /
                                  1970_to_1990 / 1990_to_2010 / Post_2010 / Timeless
Theme                 text[]      Content themes for matching and filtering:
                                  Displacement / Migration / Language / Food / Ceremony /
                                  Religion / Occupation / Kinship / Grief / Celebration /
                                  Coming_of_Age / Elder_Wisdom / Community / History /
                                  Geography / Nature / Architecture / Trade
GenerationalPattern   text[]      Which generational contexts this resonates with:
                                  First_Gen / Second_Gen / Third_Gen_Plus / All_Generations
AudienceResonance     text[]      Age groups this content lands best with:
                                  Under30 / 30_to_50 / Over50 / All_Ages
RequiresPersonMatch   boolean     TRUE = CollapsedText or ExpandedText contains {person_name}
                                  and a matching person must exist in the network before showing.
                                  FALSE = card works without a specific name inserted.
SensitivityFlag       boolean     FALSE default.
                                  TRUE = cultural trauma, contested history, or politically
                                  sensitive content. Requires AI sensitivity layer check before
                                  showing. Never shown in Phase 0 or Phase 1.
ContentDepth          text        Surface / Medium / Deep
                                  Surface = fun fact or light cultural note.
                                  Medium = meaningful context with some historical weight.
                                  Deep = significant historical event, trauma-adjacent,
                                  or requires care in framing.
RelatedVocabID        text        Optional FK → CULTURAL_VOCAB_LIBRARY.VocabID
Status                text        Draft / Active / Retired
AddedDate             timestamp
RetiredDate           timestamp   null until retired
ApprovedByUserID      text        null for Platform; Moderator/Owner for Keeper/Conductor
TimesShown            integer     Soft metric — used to surface under-shown cards. Default 0.
```

**Matching rules for nightly job:**

**What "network's active cultural contexts" means — and beyond:**
The banner operates on three expanding circles of relevance:

Circle 1 — Your network's own origins.
Cultural contexts from every person's Origin and CulturalContext
in the viewer's network. Your roots, their roots.

Circle 2 — Cultures entering your network.
New people marrying in, adopted in, connected through milestones.
Sahiba's fiancé brings Mexican tradition into your network.
The banner surfaces el lazo the week before the wedding.
You have never been to a Mexican wedding. Now you will know
something real about what you are walking into.

Circle 3 — General cross-cultural content.
Not connected to anyone specific in the network.
The world is interesting. Traditions are interesting.
The platform surfaces things that interest, inform, and educate —
even if the connection is only "this is a beautiful human tradition
that exists in the world and you didn't know it."
This tier is lower weight in the rotation but always present.
It is the platform saying: your family is part of a larger world.

The banner is a cultural bridge, not a cultural mirror.
It does not only reflect what the viewer already is.
It opens windows.

1. Circle 1 content: highest weight. Always eligible.
2. Circle 2 content: elevated weight when milestone is upcoming
   (wedding, birth, ceremony within 30 days)
3. Circle 3 content: base weight. General cultural content,
   world traditions, cross-cultural curiosities. Always some
   in the rotation. Never zero.
4. RequiresPersonMatch = TRUE only eligible if a matching person exists
5. SensitivityFlag = TRUE excluded until Phase 2+ sensitivity layer
6. Among eligible cards: TimesShown ASC first,
   then ContentDepth weighted by engagement history,
   then random shuffle within same depth tier

**Tag completeness rule:**
Every new card must have at minimum: CulturalContext OR RelatedCity (or both),
at least one Theme, at least one Era, and ContentDepth set.
Cards missing these fields cannot move from Draft to Active.

**Non-assumption rule:**
Card copy must never assume what the viewer practices, believes, or
identifies with based on their heritage or network composition.
Geography and history are for everyone. Cultural practice belongs to
the individual. Cards that contain language like "your tradition,"
"your faith," "families like yours do this," or any phrase that
assigns practice to the viewer are rejected in AI staging review.
Present. Invite. Educate. Never assume.

---

## QUESTION_TEMPLATES
Reusable question patterns for the AI question system. The nightly
job matches these templates against each Conductor's network profile
and fills the {slots} with real names and data. AI generation is only
needed when no matching template exists — which becomes rarer as the
library grows.

The goal: a database rich enough that 90%+ of questions are served
from templates, not generated fresh. Each template written once
serves every matching Conductor forever.

```
TemplateID            text        Primary key
QuestionType          integer     1=DeepHistory / 2=MiddleHistory / 3=LivingMemory /
                                  4=CulturalContribution / 5=Sensitivity (Phase 2)
QuestionText          text        The question with {slots} for name insertion.
                                  Slots: {person_name}, {display_label}, {city},
                                  {relationship}, {birth_year}, {cultural_context},
                                  {network_name}
                                  e.g. "Your {relationship} {display_label} survived
                                  a significant displacement. Do you know what
                                  {person_name} took with them when they left?"
ResponseOption1       text        Response option 1 — may also contain {slots}
ResponseOption2       text        Response option 2
ResponseOption3       text        Response option 3
ResponseOption4       text        Response option 4

CulturalContext       text[]      Cultural contexts this question is relevant to.
                                  null = universal — works for any background.
Era                   text[]      Historical periods this question targets.
                                  e.g. ["Pre_1900", "1900_to_1947"]
Theme                 text[]      Thematic tags — same vocabulary as DISCOVERY_CARDS.
                                  e.g. ["Displacement", "Migration", "Grief"]
GenerationalPattern   text[]      Which generational profile of the SUBJECT this applies to.
                                  e.g. ["Passed-SparseRecord", "Grandparent"]
SubjectStatus         text[]      Status values of the profile this question is about:
                                  Passed / Living / Placeholder / Any
RequiredFields        text[]      Fields that must be non-null on the subject profile
                                  for this question to be valid.
                                  e.g. ["BirthLoc", "BirthMonthYear"]
                                  If any listed field is null, skip this template.
ExcludedIfFields      text[]      Fields that must be null for this template to apply.
                                  e.g. ["StorySessionNotes"] — skip if story already captured.
SensitivityFlag       boolean     FALSE default. Same rules as DISCOVERY_CARDS.
ContentDepth          text        Surface / Medium / Deep
AudienceResonance     text[]      Under30 / 30_to_50 / Over50 / All_Ages
TimesUsed             integer     How many times this template has been matched and served.
                                  Soft metric — not shown to users.
LastUsedAt            timestamp   When this template was last matched to a Conductor.
Status                text        Active / Retired
AddedDate             timestamp
```

**Matching rules for nightly job:**
1. QuestionType matches what's needed for this Conductor's queue
2. CulturalContext overlaps with subject's Origin, or is null
3. Era overlaps with subject's birth period, or is null
4. GenerationalPattern matches subject's position in viewer's graph
5. SubjectStatus matches subject's current Status
6. All RequiredFields are non-null on the subject profile
7. None of ExcludedIfFields are populated
8. SensitivityFlag = FALSE (until Phase 2 sensitivity layer)
9. This exact TemplateID has not been served to this viewer
   about this SubjectUserID before (checked against PENDING_QUESTIONS history)

When a match is found:
- Fill {slots} from DB at match time
- Write to PENDING_QUESTIONS with QuestionText populated
- Increment TimesUsed on the template

When no match is found:
- Fall back to AI generation for this Conductor/subject pair
- Store the AI-generated question in PENDING_QUESTIONS
- Optionally flag for human review as a template candidate
  (if the same pattern recurs across 3+ Conductors, it should
  become a template)

**Template completeness rule:**
Every template must have QuestionType, at least one GenerationalPattern,
SubjectStatus, and ContentDepth set before Status = Active.

---

## CONTENT_STAGING
Holding area for all admin-entered content before AI nightly review
and promotion to production tables. Nothing in this table is ever
shown to Conductors. All entries are reviewed by the nightly AI
pass before promotion.

One table handles all content types via the ContentType
discriminator and a JSONB payload. The nightly job knows the
schema for each ContentType and validates accordingly.

```
StagingID             text        Primary key
ContentType           text        Vocab / DiscoveryCard / QuestionTemplate /
                                  TermConflict
EnteredByUserID       text        FK → People_Master.UserID (admin or SuperUser)
network_id            text        null = platform content / set = network-specific
EnteredAt             timestamp   When admin submitted this item
EnteredVia            text        AdminConsole / BulkPaste / APIImport
SourceReference       text        Optional — citation, URL, book title, tribal contact name.
                                  e.g. "native-languages.org/coast-miwok" or
                                  "Melissa, FIGR Tribal Council — confirmed 2026-04-01"
StagedContent         jsonb       The full content payload as JSON.
                                  Schema per ContentType defined below.
AdminNotes            text        Optional context from the admin — anything the AI
                                  reviewer should know. e.g. "Melissa confirmed this
                                  term is not restricted but asked we note the regional
                                  variant in the NuanceNote."
RestrictedFlag        boolean     FALSE default. Set TRUE if tribal or community
                                  confirmation is required before Active.
                                  TRUE items are never promoted until ConfirmedByContact
                                  is populated.
ConfirmedByContact    text        null until tribal/community confirmation received.
                                  e.g. "Melissa Goode, FIGR Tribal Council Secretary"
ConfirmedAt           timestamp   null until confirmed

ReviewStatus          text        Pending / AIApproved / NeedsRevision / Rejected /
                                  AwaitingConfirmation / AwaitingModeratorApproval /
                                  Promoted
PromotionTier         text        A / B / C / D / E
                                  Assigned at entry time based on EnteredByUserID,
                                  ContentType, network_id, and RestrictedFlag.
                                  Determines the promotion path — never changes after set.
                                  A = platform SuperUser content → auto-promote on AI approval
                                  B = question templates (any origin) → auto-promote
                                  C = term conflict registry entries → auto-promote
                                  D = Keeper/Conductor network content → needs Moderator/Owner
                                  E = RestrictedFlag = TRUE → needs external confirmation
ReviewedByJobID       text        FK → NIGHTLY_JOB_LOG.JobID — which run reviewed this
ReviewedAt            timestamp
AIVerdict             text        Approved / NeedsRevision / Rejected
AIVerdictNotes        text        AI's specific feedback — what needs fixing for
                                  NeedsRevision, or why Rejected.
                                  Plain text, readable by admin. e.g.:
                                  "NuanceNote missing — this term has a known
                                  cross-cultural collision (see TERM_CONFLICT_REGISTRY).
                                  Recommend adding: 'In Hindi this means maternal uncle.
                                  In English, Mama means mother. Clarify which context
                                  applies.' CollapsedText is 134 characters — over
                                  120 limit. Trim by 14 characters."
AdminRevisionNotes    text        Admin response to AI feedback — what was changed
                                  on resubmission
RevisionCount         integer     How many review cycles this item has gone through.
                                  Default 0.
PromotedAt            timestamp   null until promoted to production table
PromotedToID          text        The production table row ID created on promotion
                                  e.g. the VocabID or CardID written to production
```

**StagedContent JSON schema per ContentType:**

Vocab:
```json
{
  "CulturalContext": "North Indian",
  "StructuralType": "Uncle_Maternal",
  "Term": "Mama",
  "Romanization": "Maa-maa",
  "Description": "Mother's brother...",
  "NuanceNote": "In Hindi this means maternal uncle...",
  "UsageExample": "...",
  "Theme": ["Kinship"],
  "GenerationalPattern": ["All_Generations"],
  "AudienceResonance": ["All_Ages"],
  "SourceType": "Community"
}
```

DiscoveryCard:
```json
{
  "CollapsedText": "Krishan Datta was born here.",
  "ExpandedText": "Rawalpindi was...",
  "CulturalContext": ["North Indian", "Punjabi"],
  "RelatedCity": ["Rawalpindi"],
  "Era": ["1900_to_1947"],
  "Theme": ["Displacement", "Migration"],
  "GenerationalPattern": ["First_Gen", "Second_Gen"],
  "ContentDepth": "Deep",
  "RequiresPersonMatch": true
}
```

QuestionTemplate:
```json
{
  "QuestionType": 1,
  "QuestionText": "Your {relationship} {display_label} survived...",
  "ResponseOption1": "Yeah, let me tell you...",
  "ResponseOption2": "No, I don't...",
  "ResponseOption3": "But I do know...",
  "ResponseOption4": "Not right now...",
  "CulturalContext": null,
  "Era": ["Pre_1900", "1900_to_1947"],
  "Theme": ["Displacement"],
  "GenerationalPattern": ["Passed-SparseRecord"],
  "SubjectStatus": ["Passed"],
  "RequiredFields": ["BirthLoc"],
  "ExcludedIfFields": ["StorySessionNotes"],
  "ContentDepth": "Deep"
}
```

TermConflict:
```json
{
  "Term": "Mama",
  "Culture1": "Hindi / Punjabi",
  "Meaning1": "Maternal uncle",
  "StructuralType1": "Uncle_Maternal",
  "Culture2": "English",
  "Meaning2": "Mother",
  "StructuralType2": "Mother",
  "Notes": "High collision risk in diaspora households..."
}
```

**Promotion rules — tiered by content origin and sensitivity:**

The system is designed to minimise human overhead.
Human approval is required only where human judgment adds
irreplaceable value. Everywhere else, AI approval is sufficient.

| Tier | Content type | Human approval needed? | Auto-promote on AI approval? |
|---|---|---|---|
| A | Platform-seeded (EnteredByUserID = SuperUser, network_id = null) | No | Yes |
| B | QUESTION_TEMPLATES — any origin | No | Yes |
| C | TERM_CONFLICT_REGISTRY entries | No | Yes |
| D | Keeper-authored or Conductor-contributed (network_id set) | Yes — Moderator or Network Owner | No |
| E | RestrictedFlag = TRUE (tribal / community) | Yes — named external contact | Never without ConfirmedByContact |

**Tier A — Platform content auto-promotes:**
Content entered by the SuperUser (you) for the shared platform
library is already human-authored. The AI review checks structure,
tone, completeness, and non-assumption compliance. If it passes,
it promotes that night. No second human step.
This is the majority of Phase 0 and Phase 1 content seeding.

**Tier B and C auto-promote:**
QUESTION_TEMPLATES and TERM_CONFLICT_REGISTRY entries are
structural data with clear correctness criteria. The AI review
validates all fields. Human review adds no additional value here.

**Tier D requires Moderator or Network Owner approval:**
Content from Conductors and Keepers within a specific network
gets AI review first. If AI approves, a single notification
goes to the network's Moderator (or Network Owner if no Moderator).
They see: the item summary, the AI's verdict notes, one tap to
approve, one tap to reject. Typically 10 seconds per item.
Volume at Phase 0: near zero. At Phase 1 with active Conductors
contributing via Question Type 5: a handful per week per network.

**Tier E requires external confirmation:**
Tribal and community vocabulary with RestrictedFlag = TRUE
never promotes without ConfirmedByContact populated.
This is not bureaucracy — it is the platform's commitment
to those communities. The admin records the confirmation
(name + date) once they receive it from the tribal contact.
The next nightly run promotes it automatically.

**NeedsRevision path (any tier):**
AI flags specific issues. Admin fixes inline in the conversational
editor. Item resubmits as Pending. Reviewed next night.
No human approval needed if AI approves on the second pass
(Tiers A, B, C). Tier D and E still go through their respective
approval step after AI re-approval.

**RevisionCount > 3 (any tier):**
Something structural is wrong that neither the admin nor the AI
can resolve in three cycles. Escalate to SuperUser review.
In practice this should be extremely rare.

---

## STAGING_REVIEW_LOG
One row per AI review action. More granular than StagingID allows.
Useful for auditing AI review quality over time.

```
ReviewLogID           text        Primary key
StagingID             text        FK → CONTENT_STAGING.StagingID
JobID                 text        FK → NIGHTLY_JOB_LOG.JobID
ContentType           text
AIVerdict             text        Approved / NeedsRevision / Rejected
ChecksPassed          text[]      List of checks that passed
ChecksFailed          text[]      List of checks that failed with reasons
TokensUsedInput       integer     Tokens used for this specific review call
TokensUsedOutput      integer
ReviewedAt            timestamp
```

---

## VALIDATION_LOG
One row per finding per nightly run. Never modifies user data.
Permanent record — findings are never deleted, only superseded
when a subsequent run clears or changes the status.

```
LogID                 text        Primary key
JobID                 text        FK → NIGHTLY_JOB_LOG.JobID
network_id            text
FindingType           text        TermConflict / TimelineError / TimelineWarning /
                                  StructuralError / DuplicateCandidate /
                                  ContentIntegrityError / CompletenessSignal /
                                  MissingNuance
Severity              text        Error / Warning / Info
SubjectUserID         text        The profile this finding is about — null if network-level
RelatedUserID         text        Secondary profile involved (e.g. parent in timeline check)
RelatedVocabID        text        FK → CULTURAL_VOCAB_LIBRARY.VocabID if term-related
FindingDetail         text        Human-readable description of the finding.
                                  e.g. "DisplayLabel 'Nana' on SubjectID JS-RRB-STAR
                                  (relationship: Grandfather_Maternal) conflicts with
                                  common English usage where Nana = grandmother.
                                  CulturalContext is Fijian-Indian. NuanceNote recommended."
ActionTaken           text        None / MarkedStale / MarkedDraft / NotifiedModerator /
                                  QueuedForAI
ResolvedAt            timestamp   null until a Moderator, Conductor, or AI exchange
                                  has addressed the finding
ResolvedBy            text        UserID of who resolved, or 'AI' if resolved via conversation
DetectedAt            timestamp
PreviousLogID         text        FK to prior run's finding for the same issue —
                                  tracks how long an issue has persisted
```

---

## TERM_CONFLICT_REGISTRY
Platform-maintained list of vocabulary terms known to have
cross-cultural or cross-linguistic collision risk. Used by the
validation run to flag DisplayLabel mismatches.
Seeded by platform. Expanded as new conflicts are discovered.
Never shown to users — internal reference only.

```
ConflictID            text        Primary key
Term                  text        The phonetic term — e.g. "Nana"
Culture1              text        First cultural context
Meaning1              text        What it means in Culture1
StructuralType1       text        StructuralType in Culture1
Culture2              text        Second (conflicting) cultural context
Meaning2              text        What it means in Culture2
StructuralType2       text        StructuralType in Culture2
Culture3              text        Optional third conflict
Meaning3              text
StructuralType3       text
Notes                 text        Context for validators and Keepers
AddedDate             timestamp
```

**Seed data — initial entries at Phase 0 launch:**

| Term | Culture 1 | Meaning 1 | Culture 2 | Meaning 2 |
|---|---|---|---|---|
| Nana | Hindi / Punjabi | Maternal grandfather | English colloquial | Grandmother (either) |
| Nani | Hindi / Punjabi | Maternal grandmother | — | Document alongside Nana |
| Dada | Hindi / Punjabi | Paternal grandfather | Bengali | Elder brother |
| Dadi | Hindi / Punjabi | Paternal grandmother | — | Document alongside Dada |
| Baba | Hindi / Urdu | Father or grandfather | Turkish | Father |
| Mama | Hindi / Punjabi | Maternal uncle | English | Mother |
| Chacha | Hindi / Punjabi | Paternal uncle | Urdu | Same — no conflict |
| Bhayia | Hindi / Punjabi | Older brother (structural) | Hindi / Punjabi | Husband's older brother or elder male figure (experienced — label frequently inherits across generations and applies beyond blood siblings) |
| Jij / Bhabbi | Hindi / Punjabi / Fijian-Indian | Older brother's wife (structural) | Fijian-Indian | Older sister figure — applied to wife's elder sister by siblings and their children | 

---

## NIGHTLY_JOB_LOG
One row per job run. Permanent audit trail. Never deleted.

```
JobID                 text        Primary key — format: YYYYMMDD-HH (e.g. 20260401-07)
JobType               text        NightlyBatch / ManualTrigger / DeltaTrigger
ScheduledAt           timestamp   When the job was supposed to run (midnight Pacific)
StartedAt             timestamp   Actual start time
CompletedAt           timestamp   Actual completion time — null if failed or running
Status                text        Running / Completed / Failed / PartialSuccess
ConductorsProcessed   integer     How many Conductors had content generated
QuestionsGenerated    integer     Total new PENDING_QUESTIONS rows written
BannerCardsGenerated  integer     Total new PENDING_BANNER_CARDS rows written
ScoresRecalculated    integer     Conductors whose EngagementScore was updated
TokensUsedInput       integer     Total input tokens consumed across all API calls
TokensUsedOutput      integer     Total output tokens consumed
EstimatedCostUSD      float       Calculated from token counts at Haiku 4.5 rates
ErrorLog              text        JSON array of any errors — null if clean run
NetworksProcessed     text        JSON array of network_ids processed
```

---

## PENDING_QUESTIONS
Pre-generated AI questions ready to serve on next login.
One row per question. Questions are consumed (status → Served) when shown.
Served questions are retained for 30 days then purged.

```
QuestionID            text        Primary key
UserID                text        FK → People_Master.UserID — who this question is for
network_id            text
SubjectUserID         text        The person this question is about (FK → People_Master)
QuestionType          integer     1=DeepHistory / 2=MiddleHistory / 3=LivingMemory /
                                  4=CulturalContribution / 5=Sensitivity (Phase 2)
QuestionText          text        The question as it will be shown to the user
ResponseOption1       text        "Yeah, let me tell you..."
ResponseOption2       text        "No, I don't..."
ResponseOption3       text        "But I do know..."
ResponseOption4       text        "Not right now..."
GeneratedByJobID      text        FK → NIGHTLY_JOB_LOG.JobID
GeneratedAt           timestamp
NetworkHashAtGeneration text      Hash of network state when generated — used to detect stale questions
Status                text        Ready / Served / Stale / Skipped
ServedAt              timestamp   null until shown
PurgeAfter            date        30 days after ServedAt, or 90 days after GeneratedAt if never served
Priority              integer     1 = show first. Lower = show later. Assigned at generation time.
                                  Type 1 questions (deep history, passed profiles) get Priority 1.
```

**Rules:**
- A Conductor always has at least 3 Ready questions in the pool before next login
- If pool drops below 3, a DeltaTrigger job runs immediately (not waiting for midnight)
- Questions become Stale if SubjectUserID's profile or relationships changed
  significantly since GeneratedAt (network hash mismatch)
- Stale questions are skipped — never shown — but retained for audit
- Type 4 (cultural contribution) is generated at most once per 30 days per Conductor
- The question shown on login is always the highest-Priority Ready question

---

## PENDING_BANNER_CARDS
Pre-assembled banner cards ready to rotate on the dashboard.
Mix of AI-generated and template-assembled. Both look identical to the user.

```
CardID                text        Primary key
UserID                text        FK → People_Master.UserID
network_id            text
ContentType           text        Vocabulary / NetworkFact / Historical / Milestone /
                                  KeeperWisdom / CulturalContribution
SourceID              text        FK to the source row — VocabID, DiscoveryCardID,
                                  MilestoneID, or null for NetworkFacts
CollapsedText         text        Single sentence shown in collapsed state (hook line)
ExpandedText          text        Full content shown when card is expanded (2–4 sentences)
AttributionText       text        Muted attribution line — null if not applicable
GenerationMethod      text        AIGenerated / TemplateAssembled / DBQuery
GeneratedByJobID      text        FK → NIGHTLY_JOB_LOG.JobID — null for DBQuery cards
GeneratedAt           timestamp
Status                text        Ready / Shown / Expired
ShownAt               timestamp   null until displayed
PurgeAfter            date        7 days after ShownAt, or 14 days after GeneratedAt if never shown
PoolPosition          integer     Order within the Ready pool for this user.
                                  Randomized at generation time — re-randomized on pool refill.
```

**Rules:**
- Target pool size per Conductor: 20–30 Ready cards
- Refill triggered when pool drops below 8 Ready cards
- NetworkFact cards are never stored — generated at display time from live DB queries
  (they must reflect today's actual counts, not yesterday's)
- Milestone cards are generated same-day when ShareWithNetwork = true and
  DateMM_YYYY is within 30 days — not batched nightly
- Shown cards are retained for 7 days (for BANNER_FEEDBACK correlation), then purged
- A card is never shown twice to the same user regardless of pool state

---

## VOCAB_REVIEW_REQUESTS
Tracks every expert vocabulary review request sent by admin.
One row per request. Links to language, reviewer, and import status.

```
RequestID             text        Primary key
Language              text        FK to Language values in CULTURAL_VOCAB_LIBRARY
Round                 integer     1–4
ReviewerName          text
ReviewerEmail         text        Encrypted at rest. Never displayed in platform UI.
ReviewerBackground    text        Optional admin notes on this reviewer's credentials
IncentiveOffered      text        None / FreeProfile / TwoFreeProfiles / Custom
IncentiveNote         text        Details of offer if custom
SentAt                timestamp
ResponseReceivedAt    timestamp   null until response received
ResponseStatus        text        Sent / Responded / NoResponse / Bounced
TermsReviewed         integer     Count of terms reviewer actually reviewed
TermsConfirmed        integer
TermsFlagged          integer
TermsUnsure           integer
AdminNotes            text        Any context about this reviewer or session
ConfirmedByAdmin      boolean     FALSE until admin manually imports response
```

**Expert confirmation rule:**
A term is confirmed when ≥2 independent reviewers have confirmed it.
Single confirmation is logged but ExpertConfirmed stays FALSE.
This prevents a single well-intentioned but incorrect reviewer
from certifying inaccurate content.

**Incentive tiers:**
- Academic/professional reviewer (1 round): 1 free Conductor account
- Community college professor / JACL / diaspora org contact: 2 free accounts
- Tribal language authority (RestrictedFlag content): 3 free accounts
  + founding partner pricing on any future org network

Accounts provisioned manually by admin after response received.
No auto-provisioning.

---

## PLATFORM_FEEDBACK
Responses to AI question type 6 — "What else would you like to see?"
Visible to SuperUser in admin console. Aggregates into roadmap signals.

```
FeedbackID            text        Primary key
UserID                text        FK → People_Master.UserID
network_id            text
ResponseTheme         text        Stories / Preservation / Discovery / FreeText
FreeTextResponse      text        null unless ResponseTheme = FreeText
GeneratedAt           timestamp
ReviewedByAdmin       boolean     FALSE default
AdminNotes            text        null until reviewed
```

---

## NETWORK_MESSAGES
Platform-mediated messages sent through the network directory.
No email addresses are stored here — only relay tokens and
platform-side records. All routing happens through the relay.

```
MessageID             text        Primary key
SenderUserID          text        FK → People_Master.UserID
network_id            text
Subject               text
Body                  text
SentAt                timestamp
RecipientCount        integer     How many people the message was addressed to
DeliveredCount        integer     How many actually received it (after OptOut exclusion)
ExcludedCount         integer     How many were excluded (EmailOptIn = FALSE)
RelayToken            text        Unique token for this message thread's reply-to address
                                  e.g. "reply-abc123@eternalcurrent.online"
Status                text        Queued / Sent / Failed / PartialSuccess
FilterSnapshot        text        JSON — the active filters at time of send.
                                  Records exactly who was selected and why.
                                  e.g. {"filter":"currentCity:London","count":4}
```

**NETWORK_MESSAGE_RECIPIENTS**
One row per recipient per message. Separate table to avoid
bloating the main message record.

```
RecipientID           text        Primary key
MessageID             text        FK → NETWORK_MESSAGES.MessageID
RecipientUserID       text        FK → People_Master.UserID
DeliveryStatus        text        Delivered / Excluded / Failed / Bounced
ExclusionReason       text        OptedOut / NoEmail / Frozen / null
SentAt                timestamp
```

**Rules:**
- No email address stored in either table
- FilterSnapshot is write-once — records state at send time
- Relay token is generated per MessageID, never reused
- Replies received at relay token are forwarded to
  SenderUserID's email and logged as a reply thread
  in a future NETWORK_MESSAGE_REPLIES table (Phase 2)
- Rate limit enforced at API layer: 3 messages per Conductor
  per 24-hour window. Tracked via SentAt on MessageID.
- Org network override: Org Admin rate limit is 10/day
  but requires Org Admin role — not standard Conductor

---

## USER_PREFERENCES
Stores per-Conductor, per-network UI preferences. JSON blob pattern
keeps this table stable as preferences expand over time without
schema migrations.

```
PreferenceID          text        Primary key
UserID                text        FK → People_Master.UserID
network_id            text
PreferenceKey         text        Namespaced key — see key registry below
PreferenceValue       text        JSON string — parse on read
LastUpdated           timestamp
```

**Key registry (expand as features are built):**

| PreferenceKey | Value shape | Default | Set by |
|---|---|---|---|
| card_view.fields | ["FirstName","LastName","BirthYear","CurrentLoc","DisplayLabel"] | Default set | Field picker UI |
| card_view.sort | {"field":"LastName","direction":"asc"} | LastName asc | Sort control |
| card_view.layout | "grid" or "list" | "grid" | Layout toggle |
| card_view.filters | {"status":"both","origin":[],"decade":null} | All shown | Filter panel |
| directory.columns | ["Name","BirthYear","CurrentLoc","DisplayLabel","RoleOverlay"] | Default set | Column selector |
| directory.sort | {"field":"Name","direction":"asc"} | Name asc | Column header click |
| directory.filters | {"status":"both","role":"any"} | All shown | Filter bar |
| banner.focus_topics | ["Punjab heritage","Words from Fiji"] | [] (no focus) | Topic pill selection |
| banner.show_progress | true or false | true | Progress bar toggle |
| banner.content_weights | {"Vocabulary":25,"NetworkFact":30,...} | Default weights | Computed from WantLess signals — do not write directly |

**Rules:**
- One row per UserID + network_id + PreferenceKey combination
- Upsert on change — never insert duplicates
- If a key is missing, the UI falls back to the default listed above
- PreferenceValue is always valid JSON — validate before write
- Never store sensitive data in preferences (no emails, no IDs of others)

---

## PLATFORM_STATS
```
StatDate              date
NetworkCount          integer
ConductorCount        integer
CountryCount          integer
CityCount             integer
PassedCount           integer
MilestoneCount        integer
```

---

## PROXIMITY_NOTES
Generated by the AI triangulation system during entry portal sessions.
Never displayed as raw data — surfaced only through AI narrative and Keeper annotations.

```
NoteID                text        Primary key
SubjectUserID         text        Person being entered / located
AnchorUserID          text        The network person they were compared against
network_id            text
LocationType          text        Birth / Current
AnchorCity            text        The shared city (display name)
ProximityResult       text        SameArea / DifferentNeighbourhood / Unconfirmed
SubjectNeighbourhood  text        Free text — what the user described (null if SameArea or Unconfirmed)
LatAdjusted           float       Refined lat after triangulation (null if Unconfirmed)
LngAdjusted           float       Refined lng after triangulation (null if Unconfirmed)
NoteText              text        Human-readable summary — AI-generated at session time
                                  e.g. "Born in same neighbourhood as Krishan Datta, Amritsar civil lines."
CreatedDate           timestamp
CreatedBySessionID    text        The AI story session that generated this note
PromotedByKeeperID    text        null unless a Keeper has promoted to Teaching Moment
```

**Rules:**
- One NoteID per Subject + Anchor + LocationType combination
- If re-entered in a later session, existing note is overwritten (not duplicated)
- SubjectNeighbourhood has no validation — store exactly what the user said
- NoteText is generated by the AI at session time, stored as written (not regenerated later)
- LatAdjusted / LngAdjusted, when populated, replace BirthLat/BirthLng or CurrentLat/CurrentLng in People_Master

---

## PARENT RELATIONSHIP EDGE CASES

| Situation | How to Store | How to Display |
|---|---|---|
| Both parents known | ParentID + CoParentID + 4 Relationships_Linker rows | Both shown |
| One parent unknown | Known parent in ParentID; CoParentID = null | Only known shown |
| Both unknown | Both null | No parent connections shown |
| Birth parent unacknowledged | RelationType = BioParent, VisibleTo = owner | Owner only |
| Isaiah's case | Vikas = Parent (visible); Reema = Parent (visible); Amit = BioParent (VisibleTo = owner) | Owner discretion |

**Core principle:** Absence is always silent. Never render "Unknown Parent" node.

---

## KEY PEOPLE (Lightning Network)

| UserID | Person | Notes |
|---|---|---|
| STAR | Vikas Bakshi | Center node |
| RRB-STAR | Reema Bakshi | Wife |
| IB-STAR | Isaiah Bakshi | Adopted son; birth father = AB-STAR |
| AB-STAR | Amit Bakshi | Vikas's brother, Passed, birth father of Isaiah |
| NB-STAR | Nirupma "Neeru" Bakhshi | Vikas's mother |
| MMB-STAR | Madan Bakhshi | Vikas's father, Passed |
| KD-NB-STAR | Krishan Datta | Nirupma's father, Passed |
| LD-NB-STAR | Leela Datta | Nirupma's mother, Passed |
| AV-STAR | Anu Vaid | Nirupma's younger sister |
| NV-STAR | Niti Vaid | Anu+Satish's daughter = Vikas's first cousin |
| NS-RRB-STAR | Narendra Singh | Reema's father |
| JS-RRB-STAR | Jaiwati Singh | Reema's mother |
| RMSH-JS-RRB | Ramesh "Mesu" Sewak | Jaiwati's BROTHER (not her child) |

**Family structure:**
- Krishan + Leela → Nirupma, Babloo, Anu (in order)
- Madan + Nirupma → Vikas, Amit†, Pragati
- Narendra + Jaiwati → Reema, Karishma, Seema (3 daughters only)

---

## WAITLIST
Pre-launch signup capture. One row per submission.

```
WaitlistID        text        Primary key. UUID.
Name              text
Email             text        Encrypted at rest. Never displayed in UI.
Intent            text        Join / Create
NetworkName       text        Optional. Provided when Intent = Join.
FamilyNote        text        Optional. Provided when Intent = Create.
                              Most valuable marketing insight field.
SubmittedAt       timestamp
Source            text        Home / HIW / Manifesto / Direct
IPCountry         text        Country code only (e.g. "US"). No finer resolution.
Contacted         boolean     FALSE default. Admin marks TRUE after outreach.
ContactedAt       timestamp   null until contacted.
Notes             text        Admin notes on this signup.
```

**Resend triggers on submission:**
1. Confirmation to user — warm, brief, references their intent.
2. Notification to admin — all fields, FamilyNote highlighted if present.

**Admin view:**
Sortable by SubmittedAt, Intent, IPCountry.
Filter by Contacted = FALSE to see uncontacted signups.
FamilyNote column visible when Intent = Create.


---

## KEEPER_SHARING_PREFS
Records each Keeper's cross-network sharing preferences.
Set during the Keeper activation ceremony.
One row per Keeper. Updatable at any time from Keeper settings.

```
KeeperUserID          text        Primary key. FK → USERS.
ShareVocab            boolean     Default FALSE.
ShareAnnotations      boolean     Default FALSE.
ShareTeachingNotes    boolean     Default FALSE.
ShareTraditions       boolean     Default FALSE.
LastAskedAt           timestamp   When the sharing ask was shown.
DeclinedAt            timestamp   null if accepted. Set if [ Not right now ] chosen.
ReAskedAt             timestamp   null until the 90-day re-ask fires.
OptedInManually       boolean     FALSE default. TRUE if Keeper later opts in via settings.
```

**Re-ask logic:**
If Keeper chose [ Not right now ], the ask surfaces once more after
90 days, then never again unless Keeper opts in manually via settings.
ReAskedAt records when the 90-day ask fired.
After that: OptedInManually is the only path to sharing.

