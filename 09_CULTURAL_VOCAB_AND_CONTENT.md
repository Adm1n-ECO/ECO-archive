# ECO Cultural Vocabulary & Content Systems

---

## CULTURAL VOCABULARY LIBRARY

### Purpose
Display relationship terms in the words families actually use.
Not English translations. The actual words. "Bhua ji" not "Aunt (Paternal)."
Platform meets people where they are. Never assigns cultural identity.

### Two-Layer Relationship System
- Layer 1: Structural RelationType (DB, graph traversal) — immutable
- Layer 2: DisplayLabel (Conductor-defined freeform) — system NEVER overwrites

### Schema
```
VocabID, CulturalContext, StructuralType, Term, Romanization,
Description, SourceType, ContributedBy, TribalOwner,
RestrictedFlag (boolean — TRUE = requires tribal confirmation),
Status (Pending/Active/Retired), AddedDate
```

StructuralType values: Father / Mother / Grandfather_Paternal / Grandmother_Paternal /
Grandfather_Maternal / Grandmother_Maternal / Older_Sibling / Younger_Sibling /
Uncle_Paternal / Uncle_Maternal / Aunt_Paternal / Aunt_Maternal / Spouse / Child

### Tribal Vocabulary Ownership Rules
- Tribes own their vocabulary entries permanently
- Language contribution agreement: ECO licenses display rights, tribe retains ownership
- NOTHING goes Active without tribal confirmation
- RestrictedFlag catches potentially sacred/ceremonially significant terms
- Academic sources for demo prep only — tribal review is the quality gate

### Coverage Targets
- Launch Phase 1: 50 widgets + core kinship terms for 4 CA tribes
- Phase 2: 150 widgets + all CA tribal targets seeded
- Phase 3+: 500+ widgets + national tribal expansion
- Current: ~54% world population across 11 cultural contexts

### Seeded Cultures (current)
North Indian (Hindi/Punjabi), Fijian-Indian, UK-Indian, Japanese, Korean,
Yoruba, Mandarin, Spanish/Latin American, Arabic, Swahili, German

---

## NORTH INDIAN DISPLAY LABELS (Lightning Network)

| Term | Relationship |
|---|---|
| Dada | Paternal grandfather |
| Dadi | Paternal grandmother |
| Nana | Maternal grandfather |
| Nani | Maternal grandmother |
| Tau | Father's older brother |
| Chacha | Father's younger brother |
| Chachi | Chacha's wife |
| Bhua / Bhua ji | Father's sister |
| Mama | Mother's brother |
| Maami | Mama's wife |
| Maasi | Mother's sister |
| Maasad | Maasi's husband |
| -ji | Respect suffix (Bhua ji, Dada ji, etc.) |

---

## NATIVE AMERICAN VOCABULARY SEEDING

### Phase 1A — Pre-demo seeding (before tribal outreach)
Time: one afternoon. Cost: $0.

| Source | What to get | URL |
|---|---|---|
| native-languages.org/miwok.htm | Plains Miwok/Miwuk kinship | Free |
| native-languages.org/wintu.htm | Patwin/Wintun vocabulary | Free |
| native-languages.org/maidu.htm | Maidu vocabulary | Free |
| native-languages.org/pomo.htm | Southern Pomo vocabulary | Free |
| native-languages.org/cherokee.htm | Cherokee (Tsalagi) | Free |
| native-languages.org/chickasaw.htm | Chickasaw | Free |
| native-languages.org/ojibwe.htm | Ojibwe (Anishinaabe) | Free |
| cla.berkeley.edu → LA 6.003 | Coast Miwok kinship terms | Free |
| A Grammar of Patwin (2021) §4.3 | Patwin kinship terms | ~$50 |

### Minimum 8 terms per tribe for demo:
Father, Mother, Grandfather (paternal), Grandmother (paternal),
Grandfather (maternal), Grandmother (maternal), Older sibling, Younger sibling

### Phase 1B — Tribal review (during outreach)
Ask: "Would your language program review what we have and contribute correct terms?
Your community would own those entries in the library."
Status changes from Pending → Active only after tribal confirmation.

### Prompt L (for ChatGPT/Gemini — produces 80-120 terms)
Use format:
```
CULTURE: [Nation name]
TERM: [word in native language]
ROMANIZATION: [pronunciation guide]
STRUCTURAL_TYPE: [Father/Mother/etc.]
DESCRIPTION: [one sentence]
SOURCE_TYPE: [Academic/Tribal/Linguistic archive]
RESTRICTED: [YES if potentially sacred]
```

---

## CULTURAL CURIOSITY WIDGETS

### Display Rules
- One per session maximum
- 3-day minimum gap between widgets
- 20% random discovery rule (serendipity)
- Three responses: "Tell me more" / "Skip" / "Don't show these"
- Exclusion system: server-side, silent, permanent, never exposed

### Widget Quality Rules
- First sentence = the WOW (could stop a scroll)
- No sentence begins with "In [culture]..." — too academic
- No religious instruction or doctrinal content
- 2-4 sentences maximum
- Universal human interest — anyone should find it curious
- Never preachy, never corrective

### Cultural Trauma Widget Section
Separate tracked section — NOT surfaced randomly.
Gentle background presence for networks with pre-displacement gaps.
Framing: "Many families from this region have gaps in this period —
here's what some have recovered through oral history."
NEVER: "Your family's records were destroyed."

---

## AI QUESTION GENERATION

### Core Principle
Network-derived — no external data needed.
Even 4 profiles has enough for rich, personal questions.

### Example Questions from Sparse Data
"Your grandfather was born in Amritsar in 1931 — 16 years old during Partition.
Does anyone in the family know where they were during that time?"

"Your grandmother's profile shows she moved from Fiji to California in 1978.
Do you know what brought the family here?"

"Do you know if [grandfather] had brothers or sisters? What happened to them?"

### Question Sources (priority order)
1. Passed profiles with sparse records in pre-displacement periods
2. People the Conductor never met (grandparents who passed early)
3. Living elders whose stories are at risk
4. Currently active Conductors (lowest priority — 20-30% of questions)

### ETERNAL Weighting
70-80% questions about past/historical
20-30% questions about present/living

### AI Question Sensitivity Layer (required before Phase 1)
- Users in authoritarian-jurisdiction locations: avoid politically dangerous history questions
- Conductor-level sensitive flag: AI avoids probing
- Unanswerable: "Nobody in the network has answered this yet. This is where it belongs."

---

## KEEPER_TEACHINGS TABLE
```
TeachingID, NetworkID, KeeperUserID,
RelatedProfileID (null if general),
RelatedMilestoneID (null if not milestone-specific),
TeachingType (annotation/vocabulary_note/teaching_moment/cultural_card),
TeachingText, VisibleTo, CreatedDate (MM/YYYY), PinnedToNode (boolean)
```

---

## WIDGET GENERATION PROMPTS (A-L)
Full prompts in archive: ARCH_10_AI_QUESTION_SYSTEM_DISCUSSION.md

Categories:
A=General kinship, B=American, C=NotebookLM, D=Rapid 50,
E=American deep dive, F=North Indian, G=Fijian-Indian,
H=UK-Indian, I=Hindi multiple meanings, J=Transoceanic,
K=Indo-European, L=Native American kinship vocabulary

---

## ROTATING BANNER — STATEMENT LIBRARY

### Purpose
Short, memorable statements that surface one at a time in the
rotating banner on the home page. Each statement stands alone.
No explanation needed. No context required.

The stickiness comes through repetition over time — the same
statement appearing on visit 3, visit 27, and visit 94 lands
differently each time because the user is in a different place.

### Voice rules
- Never more than two sentences
- Never preachy, never academic
- Never an instruction or a call to action
- Either declarative (states a truth) or observational
  (names something the reader already knows but hasn't said)
- If it needs explaining, it is not ready

### Admin approval flow
The platform AI proposes new statements to the admin on a rolling
basis — surfacing insights from patterns in the vocabulary library,
network data, and cultural connections it has observed.
Admin reviews, edits if needed, and approves or rejects.
Approved statements enter the rotation.
The list grows over time. It is never finished.

---

### APPROVED STATEMENTS — FOUNDING SET (15)

**On the human universal**

01. "No group owns love, grief, hope, or the fear of being forgotten.
    Different words. The same beat."

02. "Every family, in every culture, is trying to climb the same
    ladder. The rungs just have different names."

03. "The recipe, the ceremony, the word for the hour before dawn.
    Different in every kitchen. The impulse to pass it forward:
    identical."

04. "99% of human beings want the same things for their families.
    The 1% that differs is what makes each story worth keeping."

05. "Underneath every kinship word in every language is the same
    question: who are the people I cannot lose?"

**On cultural transmission**

06. "Culture has never asked permission to move."

07. "The child who was not paying attention remembered everything."

08. "A tradition survives when someone loves it enough to carry it.
    Blood is not required."

09. "The neighbor. The teacher. The friend who stayed.
    They are in your field even if they never appear on the branch."

10. "What you carry without knowing where it came from —
    someone put it there on purpose."

**On Eternal and Current**

11. "The story you tell today will be here for the people
    who are not born yet."

12. "Your Current is this moment. It will not come back.
    Say something worth keeping."

13. "Eternal is not the past. It is the record that holds
    the past and the future simultaneously."

14. "What moves through you in this moment becomes part of
    the permanent record. Yours, and someone else's."

**On recognition across difference**

15. "The more precisely you hold your own story,
    the more clearly you will recognize it in someone else's."

---

### AI-PROPOSED STATEMENTS — PENDING ADMIN REVIEW

These would be surfaced by the platform AI as the vocabulary
library and network data grows. Placeholders to illustrate
the mechanism — not approved for rotation yet.

P01. "In your network, the uncle who shows up has a name.
     In every network, he shows up."

P02. "Preservation is not isolation.
     It is how recognition becomes possible."

P03. "The word you use without thinking —
     someone fought to keep it alive long enough to reach you."

P04. "Every culture found a different word for the same irreplaceable
     person. That is not division. That is proof."

P05. "The further you look into your own story,
     the more of humanity you find there."

---

### ROTATION LOGIC (to be implemented in platform)

- One statement visible at a time
- Rotates on each page load, not on a timer
- Never shows the same statement on two consecutive visits
  from the same user
- Weighted toward statements the user has not yet seen
  (full rotation before repeats)
- Admin can weight specific statements higher for a period
  (e.g. during a cultural event or campaign)
- Engagement tracked per statement: dwell time, shares,
  click-through to manifesto
- AI uses engagement data to inform future proposals —
  statements that generate dwell time or manifesto click-through
  are flagged as high resonance

