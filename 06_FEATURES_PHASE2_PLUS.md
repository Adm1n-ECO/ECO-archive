# ECO Features — Phase 2 (Organizational Push) and Phase 3+

---

## PHASE 1 — STICKINESS AND ENGAGEMENT FEATURES (Build Stage 5)

These features were identified in original design as Phase 1
stickiness drivers. Built in Stage 5 alongside the AI question system.

### Memory Prompts (F-STICK-01)
Weekly or monthly email: "You haven't added anything about [person]
in a while — here is a question worth asking while you still can."
Cadence: PromptFrequency in People_Master. Opt-in only.
Delivery: Resend.

### The Current — Activity Feed (F-STICK-02)
Live feed of network activity on the dashboard. New profiles,
stories, milestones, photos, relationships confirmed. Shows
last 20 events. Single-tap reaction (no text required).
Fed by Activity_Log table.

### Milestone Notifications (F-STICK-03)
Birthday month and anniversary emails to opted-in Conductors.
Sent at the start of the relevant month — not the exact day.
Opt-in: MilestoneOptIn in People_Master. Delivery: Resend.

### Legacy Q&A — The Pulse (F-GEN-07)
Specific questions submitted to a named Conductor.
"Why did you move to Fiji in 1965?" "What was the street you
grew up on?" Answers flaggable for conversion into structured
DB fields. Time-sensitive: elders first.
New schema: PULSE_QA (QuestionID, AskerUserID, RecipientUserID,
QuestionText, AnswerText, Status, ConvertedToData, network_id).

### Conductor Profiles — Living Biography (F-STICK-04)
Each Conductor has a self-authored profile page. First person.
Who I am, where I have been, what I care about. Distinct from
structured data. VisibleTo-filtered. Builds emotional investment.

### Accomplishments Feed (F-STICK-05)
Light celebration layer. Conductors share non-milestone wins.
Network reacts. Network pride without social media noise.

### Question Board (F-STICK-06)
Crowdsourced data completion. "Does anyone know where Krishan
Datta worked before Partition?" Any Conductor can answer.
Answers filling structured fields flagged for conversion.
Feeds EngagementScore of the profile being asked about.

---

## ITEMS PULLED INTO PHASE 2 FROM PHASE 1 DEFERRALS

These were originally Phase 1 but moved to Phase 2 during the March 2026
phase consistency restructure.

| Item | Why deferred |
|---|---|
| Legacy View — full implementation | Very high complexity (3+ sessions, custom GLSL, three scoring dimensions). Revenue must be flowing. |
| AI Triangulation — Tier 1 + Tier 2 | Tier 3 (social triangulation) ships Phase 1. Full landmark library and confidence scoring add significant complexity. |
| Discovery Banner — full feedback algorithm + topic focus pills | Basic banner ships Phase 0. Feedback controls ship Phase 1. Full WantLess weighting and topic algorithm deferred here. |

---

## PHASE 2 — ORGANIZATIONAL PUSH

### Gate condition
Phase 1 stable. Cultural vocabulary seeded for CA tribes.
≥1 CA tribal partner interest confirmed.

### Org Admin Tier ($14.99/month)
- 1–3 admins per organization (org decides)
- Single invoice to organization
- Features: health dashboard, user counts, login activity, seat allocation, seat management
- Keeper and Moderator nomination rights
- Network health metrics
- Usage analytics
- NOT for individual family networks — org networks only

### Institutional Billing Model
- Single invoice to organization monthly
- Org manages seat allocation internally
- Members receive access — no individual invoices
- Unused seats carry forward (no "use it or lose it")
- Org Admin seats charged separately at $14.99/mo

### Founding Partner Pricing (First 10 Orgs Nationally)
- Seats 1-100: $3.00/month (50% off $5.99)
- Seats 101-200: $4.49/month (25% off $5.99)
- Seats 201+: regular $5.99
- Founding partner pricing is PERMANENT — no 12-month expiry
- Orgs 11+: standard pricing from day one of their contract

### Org Network Freeze/Recharge
- Lapsed subscription: 90-day window → freeze indefinitely
- Rechargeable at any time, network intact
- Explicit deletion: formal written org request only

---

## PHASE 2 — TRIBAL CALIFORNIA OUTREACH

### Four Priority Targets

**Graton Resort & Casino (FIGR — Coast Miwok/Southern Pomo)**
- ~1,438 members, Sonoma County
- Key contact: Melissa, Tribal Council Secretary — language revitalization, passionate about genealogy
- FIRST contact. Highest fit. Melissa's role IS ECO's mission.

**Cache Creek Casino (Yocha Dehe Wintun Nation — Patwin)**
- ~500 members, Yolo County
- Chairman Anthony Roberts — Yocha Dehe Wintun Academy
- "Yocha Dehe" = "home by the spring water" — open pitch with this

**Thunder Valley Casino (United Auburn Indian Community — Miwok/Maidu)**
- ~170 members, Lincoln CA
- Tribal Historic Preservation Committee
- At 170 members: entire community network achievable in first 100-seat tier

**Sky River Casino (Wilton Rancheria — Miwuk)**
- ~700 members, Elk Grove CA
- Chair Jesus Tarango: "to preserve our language and culture"
- 40% under 18 — youth focus maps perfectly to ECO

### Pre-Demo Vocabulary Seeding (required before any tribal contact)
- 8 core terms per tribe from native-languages.org and CLA (cla.berkeley.edu)
- Use Prompt L in ChatGPT/Gemini for AI-assisted compilation
- RESTRICTED flag for potentially sacred terms
- Nothing goes Active without tribal confirmation

### Vocabulary Seeding Priority
1. Wilton Rancheria (Plains Miwok) — native-languages.org
2. Yocha Dehe (Patwin) — A Grammar of Patwin (2021, ~$50)
3. FIGR Coast Miwok — CLA archive LA 6.003 + ask Melissa directly
4. UAIC Miwok/Maidu — native-languages.org
5. Cherokee (Oklahoma) — AI compilation
6. Chickasaw, Ojibwe — AI compilation

---

## PHASE 3+ — NATIONAL EXPANSION

### State-by-State Timeline
| State | Target Quarter | Priority Tribes |
|---|---|---|
| California | Y1 Q1-Q2 | Graton, Cache Creek, Thunder Valley, Sky River |
| Oklahoma | Y1 Q3-Q4 | Cherokee Nation (450K+), Chickasaw, Choctaw, Muscogee |
| Washington | Y2 Q1 | Tulalip, Muckleshoot, Suquamish |
| Minnesota | Y2 Q2 | Fond du Lac Ojibwe (model language program) |
| Wisconsin | Y2 Q3 | Oneida Nation |
| Michigan | Y2 Q3 | Anishinaabe tribes, 23 casinos |
| Arizona | Y2 Q4 | Navajo Nation (170K+ members) |
| Connecticut | Y2 Q4 | Foxwoods, Mohegan Sun |
| Florida | Y3 Q1 | Seminole Hard Rock, Miccosukee |

One new state approximately every 2 months after Oklahoma.

### Oklahoma Priority
- Cherokee Nation: Durbin Feeling Language Center — contact the language program, NOT casino marketing
- Principal Chief Chuck Hoskin Jr.: "Every dollar we earn helps us preserve our language"
- Chickasaw, Choctaw, Muscogee all have active language revitalization programs

---

## PHASE 2+ — CULTURAL TRAUMA CONTENT

### Principle
Platform creates conditions for recovery. Never names wounds directly.
"Absence acknowledged, not amplified."

### Implementation
- Separate tracked section in Cultural_Vocab_Library
- AI question templates for pre-displacement period gaps:
  - Punjab Partition 1947
  - Japanese American internment 1942-45
  - Trail of Tears
  - Irish famine
  - Any significant pre-displacement gap in a profile
- Template format: "Did your grandmother ever describe what the house looked like?" NOT "records were lost during X"
- Keeper role recognized for trauma-preservation function
- These widgets NOT surfaced randomly — available as gentle background presence

---

## PHASE 2+ — LEGACY VIEW (see 07_VISUALIZATION_SPECS for full spec)

### Summary
Lightning metaphor. Upward propagating arcs from origin Conductor.
Three scoring dimensions drive visual rendering:
- Engagement Score → brightness + arc density
- Temporal Distance Index → sky position (near vs. horizon)
- Keeper Score → arc shape (lateral branching for high scorers)

Rendered once per network state. Cached until downstream delta event.

---

## PHASE 2+ — PARTNER AFFILIATE MODEL

### Principle
User-prompted only. ECO speaks. Partner never appears on ECO pages.

### Mechanics
- ECO detects context signals: upcoming milestone, story mention of travel/wedding
- ECO prompts in its own voice: "You have a wedding coming up — would you like help with invitations, photos, or travel?"
- User clicks → redirected to partner site in new tab
- Nothing from partner renders on ECO pages
- No partner tracking pixels loaded on ECO pages
- No user data shared with partners without explicit consent
- ECO receives affiliate referral signal only

### Partner Categories (Phase 2+)
- Wedding planning and photography
- Travel booking
- Photo album and print services
- Cultural heritage tours
- Document digitization services

---

## PHASE 3+ — PREMIUM FEATURES

| Feature | Phase |
|---|---|
| Journey Replay — shareable animated globe arc | Phase 2 — Stage 8 |
| Legacy View — full implementation | Phase 2 — Stage 8 (locked) |
| Time Capsule | Phase 3 |
| Print/Export products | Phase 3 |
| Workshop/Studio | Phase 3 |
| Kinetic Ledger | Phase 3 |
| Circuit Sprints | Phase 3 |
| Functional Kitchen (recipes) | Phase 3 |
| Global Expedition Log | Phase 3 |
| Cultural affiliate program | Phase 3 |
| Vocabulary skins | Post-Phase 2 |
| Legacy View descendant constellation | Phase 3 |
| Mobile app | Post-revenue |


---

## ACADEMIC PARTNERSHIP FEATURE SET (Phase 1 — quick wins)

These features are low build cost, use existing data and architecture,
and make ECO legible and valuable to Ethnic Studies faculty, oral
history programs, and community-engaged academic research.
They are not a separate product. They are a frame applied to
features ECO already has or is already building.

---

### Comparative Vocabulary Tool (Phase 1 — 1 session)

A single-page tool answering: "What do different cultures call
this relationship?"

Input: StructuralType selector (Mother's Brother, Older Sister,
Maternal Grandfather, etc.) or free-text search.

Output: Every term in CULTURAL_VOCAB_LIBRARY for that relationship
across all languages. Side by side. With:
- Term + NativeScript
- Language + CulturalContext
- RegisterType (Humble / Honorific / Neutral / Affectionate)
- EnglishApproximation
- NuanceNote
- ExpertConfirmed badge if validated

Teaching use: Professor puts this on screen and asks students
what the range of terms reveals about what each culture decided
was worth distinguishing. That is a 45-minute discussion
generated by a search box.

No other platform in this space has this tool.
The data is already in CULTURAL_VOCAB_LIBRARY.
Build: one query, one display page.

---

### Oral History Designation (Phase 1 — 1 session)

Transforms platform story capture into formally citable
oral history records.

New fields on the story/answer record:
```
IsOralHistory         boolean     FALSE default
NarratorName          text        Name of the person whose testimony this is
NarratorRelationship  text        Their relationship to the network center
RecordedDate          date        Date the story was captured
RecordedBy            text        UserID of the person who captured it
                                  (may differ from narrator)
```

When IsOralHistory = TRUE, the story displays with:
- A formal oral history header
- An auto-generated academic citation:
  "[NarratorName]. ([Year], [Month]). Personal oral history testimony:
  [first 8 words of story]. EternalCurrent.Online [NetworkName] Network.
  Recorded [RecordedDate]. Retrieved [today]."
- A methodology note: "First-person testimony recorded on [date]."

This citation is usable in student papers, grant applications,
and community archives. It makes ECO's story capture conform
to oral history citation standards used by the Bancroft Library,
the Smithsonian, the Japanese American National Museum, and
oral history programs nationwide.

Build: one field group on story record, one citation formatter,
one display variant. One session.

---

### Teaching Mode (Phase 1 — 1–2 sessions)

A curated, pedagogically annotated read-only network view
that a Pro Conductor can share with a classroom.

Built on the Event Guest Window architecture (already specced).
Key addition: TeachingNote field on profiles, relationships,
and migration arcs — a text overlay the Network Owner adds
to provide classroom context.

Example TeachingNote on a migration arc:
"This arc represents a family that crossed the 1947 Partition
border. The birth city, Rawalpindi, is now in Pakistan.
The family reached Fiji by 1962, then the Bay Area by 1980."

Students see the live globe, constellation, vocabulary in use,
and oral history records — with TeachingNotes as a guided
layer. They are looking at a documented diaspora family's story,
annotated by someone who lived it, used as a primary source.

The Lightning network becomes a living teaching case study.
No textbook has that.

URL format: eternalcurrent.online/teach/[token]
Duration: set by Pro Conductor (one semester default)
Requires: Pro Conductor tier

Build: Event Guest Window + TeachingNote field + teaching
landing page. One to two sessions.

---

### Migration Arc Export — Anonymized (Phase 1 — 1 session)

For geography, migration studies, and visual sociology courses:
export a network's migration arcs as GeoJSON or CSV for classroom
mapping exercises.

Consent toggle: Network Owner checks "Allow anonymized migration
data to be used for educational purposes" in Preferences.

Export strips all names and identifiers. Output contains:
- BirthLat / BirthLng (city centroid, not address)
- CurrentLat / CurrentLng
- CulturalOrigin (e.g. "North Indian", "Fijian-Indian")
- GenerationApprox (derived from birth decade)
- No UserID, no name, no email, no household

Format: GeoJSON (compatible with Google Earth, QGIS, ArcGIS,
Mapbox) and CSV. One-click download from Network Owner dashboard.

Teaching use: A class maps aggregate migration patterns from
10 consented ECO networks. They compare diaspora dispersion.
They visualize Partition displacement vs Fijian indenture
migration vs Japanese American internment relocation.
All from real, consented, anonymized family data.

This is community-engaged research methodology — exactly what
Ethnic Studies programs argue institutions should do.

Build: consent toggle, one query, one GeoJSON formatter. One session.

---

### Student Contribution Tracker (Phase 1 — 1 session)

When a professor assigns vocabulary review as a course exercise,
each student's submissions are attributed and trackable.

The ECO_VOCAB_REVIEW.html page already captures reviewer name
and session data. Adding:
- Institution field
- Course name / semester field
- Instructor name field

Generates a printable one-page contribution summary:
"[Student Name] contributed [N] vocabulary reviews to the
EternalCurrent.Online Cultural Vocabulary Library as part of
[Course Name], [Institution], [Semester]. Terms reviewed: [list].
Terms confirmed: [N]. Terms flagged: [N]."

Students download this for course portfolios and community
engagement transcripts. Many universities now require documented
community engagement for graduation. ECO provides the documentation.

Professors receive an aggregate class summary showing how many
terms their class reviewed and validated — a community engagement
metric for their own annual review.

Build: add institution/course fields to vocab review page,
one report formatter, one admin export. One session.

---

### Living Archive Designation (Phase 2 — medium effort)

A formal designation for networks that have been structured
according to oral history methodology — with narrator attribution,
recording dates, citation standards, and academic methodology
statements throughout.

Not a new feature set. A frame applied to existing features.

A Living Archive network receives:
- A public-facing archive URL: eternalcurrent.online/archive/[name]
- A methodology statement (admin-authored, network-specific)
- A partnership acknowledgment (if affiliated with an academic
  institution or cultural org)
- Academic citation format for the archive itself:
  "[Network Name] Living Archive. EternalCurrent.Online.
  Est. [date]. [URL]. Accessed [date]."

Why this matters beyond the platform:
A tribal nation or diaspora community with a Living Archive
ECO network can apply for National Endowment for the Humanities
(NEH) grants, IMLS (Institute of Museum and Library Services)
grants, or state humanities council funding to support their
oral history work. That funding goes to the community, not ECO —
but it deepens the relationship, validates the platform as
infrastructure rather than a product, and positions ECO alongside
the Bancroft Library, the Smithsonian, and established oral
history programs as a legitimate preservation methodology.

Requires: Network Owner designation, at least 5 IsOralHistory
records, admin approval. Pro Conductor or Org Admin tier.

Build: one designation workflow, one public landing page,
one methodology statement editor. Two to three sessions.

---

### Academic Feature Summary

| Feature | Phase | Build cost | Primary audience |
|---|---|---|---|
| Comparative Vocabulary Tool | 1 | 1 session | Faculty, students, any user |
| Oral History Designation | 1 | 1 session | Network Owners, researchers |
| Teaching Mode | 1 | 1–2 sessions | Faculty with Pro Conductor |
| Migration Arc Export | 1 | 1 session | Faculty, geographers |
| Student Contribution Tracker | 1 | 1 session | Faculty, students |
| Living Archive Designation | 2 | 2–3 sessions | Tribal, diaspora, academic orgs |

All Phase 1 items use existing data and existing architecture.
None require new infrastructure. Together they make ECO
legible to academic institutions, oral history programs, grant
bodies, and community-engaged researchers — audiences that
will advocate for the platform in ways paid advertising cannot.

