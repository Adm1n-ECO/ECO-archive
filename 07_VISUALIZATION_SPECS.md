# ECO Visualization Specifications

---

## DASHBOARD LAYOUT (dashboard.html)

### Design Direction
Minimal. Google-like simplicity. The data and the AI are the product —
not the chrome. Background `#080D14`. No sidebars. No navigation rails.
Everything the user needs is on one screen.

### Header (top bar)

Left: ECO wordmark (ETERNAL small/tracked above, CURRENT large below).
Right: role mode switcher (only if multi-role) + avatar + three-dot menu.

**Avatar:**
Circular. 32px diameter.
If PhotoID exists: circular crop of profile photo.
If no photo: initials circle (FirstName[0] + LastName[0]) in
--color-star (#FF6688 in Void). Font: --font-family-display at
--font-size-xs. Background: --color-star at 20% opacity.
Avatar is always present — it is the user's identity anchor.

**Three-dot triangle menu:**
The navigation trigger is three dots arranged in a triangle —
the ECO mark. Not the standard horizontal three-dot (⋯) pattern.
This is the ECO identity used as a functional UI element.
Top dot at apex, two dots at base left and base right.
Tap opens the dropdown. Same menu contents as specified above.

```
My network
People directory
My data (always accessible)
─────────────
Preferences
Help
─────────────
Sign out
```

Additional items added here as features are built.
Nothing lives in a sidebar. Nothing lives in a top nav bar.
The three-dot menu is the only secondary navigation on the platform.



```
┌─────────────────────────────────────────────────────┐
│  [Logo/wordmark — left]    [Role mode switcher — right] │  ← header
├─────────────────────────────────────────────────────┤
│                                                     │
│         ECO                                         │  ← wordmark center
│  Your Eternal. Your Current. Only Yours. Forever.    │  ← tagline
│                                                     │
├─────────────────────────────────────────────────────┤
│                                                     │
│  AI QUESTION — personalized, ETERNAL-weighted       │  ← dominant
│  2–3 lines of text. Specific. Named. Cultural.      │
│                                                     │
│  ┌─────────────────────────────────────────────┐   │
│  │  ·  [pulsing heartbeat input]  ·  ·  ·      │   │  ← entry box
│  └─────────────────────────────────────────────┘   │
│                                                     │
├─────────────────────────────────────────────────────┤
│                                                     │
│  [Globe mini]    [Constellation mini]  [Visual C]   │  ← live viz row
│   live data       live data             live/thumb  │
│                                                     │
├─────────────────────────────────────────────────────┤
│                                                     │
│  DISCOVERY BANNER — collapsed single sentence       │  ← ambient lower
│  + Learn More                                       │
│                                                     │
└─────────────────────────────────────────────────────┘
```

### AI Question Area
The question is the dominant element. Largest text on the page.
Always opens a door — never pushes through it.
Grounded in what the network actually knows. Open toward everything else.

**The pattern:**
1. Acknowledge where the information came from — who in the network
   created this milestone or profile. The AI is not omniscient.
   It knows this because someone in the network told it.
2. Use the structural relationship as a soft anchor — not a role
   assignment, not a cultural prescription.
3. Ask one open question about involvement or plans. The user
   self-describes. Any answer is a valid, welcome answer —
   including "I don't know her well" or "I wasn't invited."
4. Ask one question about feeling or anticipation. Emotion is
   what this platform is for.

**Example:**
"When Sahiba — or maybe one of her parents, or her sister, or
someone else who knows her — added her to the network, her upcoming
wedding sounds like a fun and exciting chance for the whole family
to get together. As her mama, which activities will you have a
chance to participate in? Is there anything about this wedding
you are especially excited about?"

This question works for every possible situation:
the viewer has a specific role and describes it; they are attending
without a formal role; they are not sure they are invited; they do
not know Sahiba well despite the structural label. All are valid.
Cultural detail enters only after the user opens the door to it.

### Input Box — Slow Breathing Pulse
The input box breathes — a slow, gentle fade of its border glow.
Not a heartbeat pace. Patient. The pace of something alive and
unhurried. One full cycle every 3–4 seconds. Ease in, ease out.

Blue (#00AAFF) on the inhale — ETERNAL arriving.
Settling to near-invisible on the exhale — waiting.
The glow never fully disappears. It rests.

Placeholder text rotates at random intervals of 5–8 seconds.
Transition is a slow cross-fade (800ms) — the text arrives
gently, never snaps. It does not demand attention.
- "Let's talk."
- "Talk to me."
- "What's on your mind?"
- "Tell me more."
- "I'm listening."
- "What do you remember?"
- "Who are you thinking about?"
- "Go ahead."
- "Share something."
- "What happened next?"
- "Tell me about them."
- "I'm here."
- "Start anywhere."

Pulse slows further when the user is actively typing.
No label. No submit button. Enter or tap submits.

### Three Miniature Visualizations
Live, dynamic, linked to the logged-in Conductor's actual data.

**Globe mini** — fully functional Three.js globe at small scale.
Shows the Conductor's real migration arcs, real dots, real colours.
Auto-rotates slowly. Responds to tap/click — opens globe-live.html
full screen. Not a screenshot. The actual engine, smaller.

**Constellation mini** — simplified force-directed graph.
The Conductor's actual network, self-centered, VisibleTo-filtered.
Dots only at this scale — no labels. Shows the shape of the network.
Tap opens full constellation view.

**Network Directory mini** — entry point to the full network table.
A small SVG representation of the directory: a few horizontal
rows suggesting a data table, with colored dots for role indicators.
Not a live data render — a styled icon that communicates "list view."
Tap opens network-directory.html full screen.

The Legacy View gets its own dedicated entry point when it is built
(Phase 2). It does not need a dashboard thumbnail to earn its place —
it earns it through the lightning metaphor and the emotional weight of
the experience. It will be accessed from the three-dot menu or a
dedicated entry on the dashboard at that time.

**Performance note:**
Three live WebGL contexts on one page is heavy. Implementation options:
Option A — Three separate canvas elements, each a reduced-resolution
  instance of the actual engine. Highest fidelity, highest overhead.
Option B — One live globe, two static thumbnails that update daily
  from a server-side render. Recommended for Phase 0/1.
Option C — All three as animated SVG representations of the data,
  not WebGL. Lowest overhead, still personalised and dynamic.
Confirm Option before Stage 4 build begins.

### Role Mode Switcher
Visible only when the logged-in Conductor has more than one active role.
Positioned top-right. Shows current active mode.

```
[Conductor ▾]  ← tap to switch modes
```

Dropdown on tap:
```
● Conductor    ← current (always the base mode)
  Keeper       ← if designated
  Moderator    ← if nominated
```

Switching mode does not change the page or reload anything.
It changes which action overlays are available:
- Conductor mode: standard view, no overlays
- Keeper mode: annotation tools, cultural card authoring visible
- Moderator mode: pending approvals badge, moderation actions visible

Tapping back to Conductor mode removes all overlays instantly.
Mode selection persists for the session only — next login defaults
to Conductor mode regardless.

---



### Stack
Three.js r128 + custom GLSL shaders. NASA textures — LOCAL only.

### Textures (must be in /textures/ folder)
- earth-day.jpg (1.4MB — NASA Blue Marble)
- earth-night.jpg (699KB — NASA city lights)
- earth-clouds.png (362KB)
- earth-bump.jpg (370KB — terrain topology)
- earth-spec.png (421KB — ocean specular mask)

### Shader Details
```glsl
// Day/night terminator
smoothstep(-0.15, 0.20, cosAngle)

// UV fix — required or Earth renders upside-down
vec2 uv = vec2(vUv.x, 1.0 - vUv.y);
```

### Rendering Config
- ACES filmic tone mapping, exposure 0.95
- Two-pass atmosphere: BackSide outer glow + FrontSide additive rim
- 8,000 star field at radius 80-100 units
- Procedural dot sprites (canvas → CanvasTexture)

### Migration Arc Colors
- Amber `0xE09040` — India origins
- Teal `0x40C8E0` — Fiji origins
- Purple `0xAA66FF` — Pakistan origins
- White `0xC0C8D0` — other origins

### Dot Colors
- Blue `#00AAFF` — Birthplace
- Green `#00CC44` — Current home
- Purple `#AA66FF` — Passed members
- Pink `#FF6688` — Logged-in Conductor

### Opening Position
- Login → animate to Conductor's CurrentLoc
- Fallback: BirthLoc → network owner location
- Lat/lng stored in People_Master (CurrentLat/CurrentLng)
- Animate over ~2 seconds using tween

### Landing Page Globe (pre-login)
- Representative/anonymized data — actual engine, not screenshot
- Responds to visitor's geographic location (IP-based city)
- Shows actual migration arc visual language before any login

---

## CONSTELLATION VIEW (view-pro-v2.html)

### Philosophy
Self-centered. The logged-in Conductor is always at the center.
Every other person is present because of their connection to the viewer.
Never hierarchical. No root. No patriarch at the top.

### Themes Available
- Organic (base — ships Phase 0)
- Ripple (Phase 1)
- Circuitry (Phase 1)
- Cosmic (Phase 1)

### VisibleTo Filter
Constellation respects VisibleTo on every node and relationship.
Isaiah's BioParent relationship = owner only.

### Post-Login Dashboard (miniature)
Small, non-interactive version on dashboard.
Clicking opens full constellation view.
Updated when network changes.

---

## LEGACY VIEW — LIGHTNING SPECIFICATION

### Concept
Lightning propagates upward from the origin Conductor (ground point).
The origin Conductor is always at the base — the source.
Arcs propagate up through the sky, representing legacy influence.
Brightness and arc density driven by Engagement Score.
Sky position driven by Temporal Distance Index.
Arc shape driven by Keeper Score.

### Rendering Model
**One render per network state.**
- Generated when first viewed OR when downstream delta event occurs
- Seeded deterministic randomness: same network state = same image
- New delta event → new seed → new unique strike
- Cached as image + network hash in LegacyViewHash / LegacyViewRendered
- Re-render only on: new descendant, new story, new sponsored member, new Keeper annotation
- Never re-renders on timer or page refresh

### The Three Scoring Dimensions

**1. Engagement Score** → brightness + arc density
Drives which score band (1-5, 6-10, 11-15, 16-20, 21+).
Random number within band drives specific visual uniqueness.

Score inputs (open to all contributors, no authority required):
- HIGH: Story/memory naming this Conductor authored by another
- HIGH: Keeper annotation pinned to this Conductor's relationships
- HIGH: Milestone created about this Conductor by someone else
- MEDIUM: Tagged in photo/media by another
- MEDIUM: DisplayLabel specifically chosen for this Conductor
- MEDIUM: Another Conductor invited someone citing connection to this person
- LOWER: Number of direct relationships mapped
- LOWER: Profile completeness (birth city, current location, etc.)

Rules:
- Historical scores accumulate only — NEVER decay
- Community-sourced: any Conductor can contribute, no approval required
- High-Keeper-Score contributors' stories carry more weight toward others' scores
- Event clustering (funerals, weddings, reunions) produces score bursts

**2. Temporal Distance Index** → sky position
Many generations + sparse records = distant sky (horizon, amber)
Many generations + rich records = closer
Recent + any records = relatively close

Movement: As information is added across generations, strike moves closer.
The storm advancing toward the viewer.

**3. Keeper Score** → arc shape (lateral branching)
High Keeper Score = arcs branch laterally, reaching people not in direct line.
Influence that extended beyond blood family is visible in the shape.
Two components:
- Outward-facing ratio: stories about others vs. self
- Temporal reach: how far back their contributions extend

NEVER shown as a number to anyone. Visible only in arc branching pattern.

### Visual Language

**Close, documented (low temporal distance):**
- Individual arcs visible, blue-white color
- Sharp, clear discharge
- Full arc detail showing relationship types

**Distant, sparse records (high temporal distance):**
- Diffuse cloud glow, no individual arcs visible
- Amber/warm color (atmosphere filters blue at distance)
- Scale feels vast
- Suggests magnitude without revealing detail

**Color encoding of arcs (when close):**
- Blue-white: direct blood descendant
- Green: sponsored / brought into network
- Amber/warm: cultural vocabulary propagated downstream
- Faint diffuse glow: VisibleTo-private profiles (contribute to brightness, not individually traceable)

**Ground point:**
Always the most luminous element in the image.
The origin Conductor's node = undeniably the source.
Size increases as temporal distance decreases (gets closer).

**Living vs. Passed sky:**
- Living Conductor: sky quality = charged, unsettled, still accumulating
- Passed Conductor: sky quality = resolved, settled, complete discharge
- NOT animated differently — atmospheric quality differs at render time
- Background charge state = rendering parameter

### Score Bands & Visual Intensity

| Band | Score | Visual |
|---|---|---|
| 1 | 1-5 | Single thin arc, dim, low sky |
| 2 | 6-10 | 2-3 arcs, moderate brightness |
| 3 | 11-15 | Multiple arcs, brighter cloud, mid-sky |
| 4 | 16-20 | Dense arcs, high luminosity, branching |
| 5 | 21+ | Brilliant strike, full sky, arcs reach ceiling |

Above Band 5: brightness maxes out. Cloud HEIGHT continues to grow.
Extraordinary legacy = taller sky, not just brighter.

### Legacy Weight Designation
Any Conductor can propose Legacy Weight for a historical figure.
Any other Conductor can support it — community-sourced, no approval hierarchy.
Sets a base score floor (minimum Band 3) regardless of documented data.
Format: free text noting reason. "Marked as foundational — family survived 1905 Punjab famine."

### Interaction Model
Primary experience: the whole image — gestalt of the strike and brightness.
Tap/hover on arc: minimal tooltip — name, relationship, one cultural term if exists.
Arc is evidence of connection, not navigation entry point.

### Post-Login Dashboard (miniature)
Small static version. Updates on network delta.
If not yet generated: soft prompt "See what your presence has already illuminated."

### Viewing One's Own Legacy View (living Conductor)
Available during lifetime.
Not mourning — inspiration. "Look at what one existence illuminated."
Reframe: sparse arcs = charge differential waiting to discharge, not a deficit.

---

## DEMO / TEST DRIVE (/demo)

### Concept
Fully functional ECO experience with a diverse fictional family.
Actual platform engine — not screenshots or video.
No time limit. Returns infinitely. One persistent conversion prompt.

### Demo Family Requirements
- South Asian diaspora (Punjab → California migration arcs)
- Japanese American (Japan → California, internment period gap visible)
- Pacific Islander (Fiji → Bay Area)
- Native American (tribal membership, kinship vocabulary visible)
- All cultural vocabularies accurate and respectful

### Interaction Available
- Rotate globe, see migration arcs
- Click constellation nodes, view self-centered shifts
- See cultural DisplayLabels in relationships
- Watch AI ask a question about a fictional family member
- See Legacy View of a fictional passed grandmother

### Conversion Prompt
"This is the [name] family. Yours is waiting." — persistent, not intrusive.
Signup button. Nothing else.
