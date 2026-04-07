# FMTO — Feature Specification: Migration Globe
_Feature ID: GLOBE-001 · Priority: High / Phase 2 · Created: 2026-03-19_

---

## Feature name
**Migration Globe** — Living map of where your family came from, where they went, and the paths they traveled to get there.

---

## Origin story
This feature was conceived from a real family story: a family rooted in northern India (Amritsar region) whose members have, over generations and decades, scattered across every continent. The goal is to make that journey visible — not as a list of cities in a profile, but as a living, glowing map of human movement that tells the story of a family in motion.

---

## What it is
A 3D interactive globe (dark background, airline-route-style glowing arcs) that visualizes two things simultaneously:

1. **Current locations** — where every household in the network is today, plotted as nodes on the globe.
2. **Migration history** — the journey each person/household took to arrive at their current location, rendered as curved flight-path arcs connecting city to city, generation by generation.

The visual language is deliberately cinematic — inspired by airline route maps and flight tracking displays. Warm glowing lines on a dark globe. The kind of thing you screenshot and share.

---

## User data model — what each user enters

### Location history (per user, stored in `location_history` table)
Each user can add an unlimited list of places they have lived, in chronological order:

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `user_id` | UUID FK | Yes | Links to users table |
| `household_id` | UUID FK | Yes | Links to households table |
| `city` | TEXT | Yes | City name as entered |
| `country` | TEXT | Yes | Country (ISO alpha-2) |
| `lat` | NUMERIC | Yes | Geocoded from city+country |
| `lng` | NUMERIC | Yes | Geocoded from city+country |
| `moved_month` | INTEGER | No | 1–12 (approximate is fine) |
| `moved_year` | INTEGER | Yes | Year of move |
| `is_birth_place` | BOOLEAN | No | Flags the origin city |
| `is_current` | BOOLEAN | Yes | True for current location |
| `notes` | TEXT | No | Optional story ("moved for work", "partition migration") |
| `created_at` | TIMESTAMPTZ | Auto | |

### UI for entering history
- Users access this from their household profile under a "Life journey" or "Migration history" tab
- Simple add/edit list: city name, country, approximate year (month optional)
- Geocoding runs automatically on save using city + country → lat/lng (Nominatim API)
- Drag to reorder if years are uncertain
- Can mark one entry as "birth city / origin"
- Current location is always auto-linked from households.city + households.country

---

## Globe display modes

### Mode 1 — Current locations
Shows only the final (current) location for each visible household.
Nodes plotted on globe. Connection lines between connected households (faint, not migration arcs).
This is the default view.

### Mode 2 — Migration history
Shows the full journey for each visible household.
Each move is connected by an arced flight-path line — like airline routes — from city A to city B to city C.
All paths visible simultaneously. Color-coded by generation.
The root origin point (e.g. Amritsar) pulses gently to anchor the eye.

### Mode 3 — Animated journey
The migration history plays out chronologically.
Paths draw themselves from oldest to newest move, with a timeline scrubber.
Can be paused, rewound, played at different speeds.
Most emotional mode — designed for family gatherings and presentations.

---

## Tier filter system

The filter controls who appears on the globe. Based on the user's position in the tree.

| Filter | Who is shown |
|--------|-------------|
| Full tree | Every household in the user's entire connected network |
| Myself only | Just the viewing user's household and their personal migration path |
| My tier | The user + all siblings + all direct cousins + friends at the same level |
| 1 tier up | My tier + parents' generation households |
| 2 tiers up | My tier + parents + grandparents generation |
| 3 tiers up | My tier + parents + grandparents + great-grandparents generation |

**Technical note:** "Tier" is defined by graph distance from the user's own household node. Tier 0 = self. Tier 1 = parents/siblings. Tier 2 = grandparents/cousins. Tier 3 = great-grandparents. The filter is inclusive downward — showing N tiers up always includes all tiers below.

---

## Visual design specification

### Globe appearance
- Dark background: deep navy/teal (#0D1E2A or similar)
- Globe surface: dark ocean color with subtle latitude/longitude grid lines in very low opacity teal
- No country fill colors — just the grid and arcs. Clean. Not a political map.

### Node dots (current location)
- Color-coded by generation: root = teal, gen1 = blue, gen2 = amber, gen3 = purple, friends = lavender
- Size: root origin larger (10px), regular households standard (6px), self slightly larger (8px) with outer ring
- Hover: shows name + city + year arrived tooltip
- Click: opens household profile panel (slides in from right)

### Migration arc lines
- Curved great-circle arcs elevated above the globe surface (lifted 12–20% above sphere)
- Line weight: 1.5–2px
- Color: matches the node/generation color of the person making the journey
- Opacity: varies along the arc (brighter at midpoint, fading at endpoints) — like a glowing trail
- Direction: subtle arrowhead or brightening at the destination end
- Multiple moves for one person form a connected chain of arcs

### Animate mode additions
- Timeline bar at bottom showing year range
- Play/pause button
- Speed control (1x, 2x, 5x)
- Year counter displayed on globe
- Arcs draw themselves with a traveling bright dot (like a plane on a flight tracker)

---

## Interaction design

| Action | Behavior |
|--------|----------|
| Drag globe | Rotates on both axes |
| Scroll / pinch | Zoom in/out |
| Hover node | Shows name, current city, brief migration summary in info bar |
| Click node | Opens household detail panel |
| Click arc | Shows whose migration path this is, with year |
| Toggle tier filter | Immediately updates visible nodes and arcs with smooth fade transition |
| Screenshot button | Captures current globe view as PNG for sharing |

---

## Technical components required

| Component | Purpose |
|-----------|---------|
| HTML5 Canvas API | Globe rendering (no external map library needed for globe) |
| Three.js (optional) | If we want true 3D with better performance at scale |
| Nominatim / OpenStreetMap | Geocoding city + country → lat/lng (free, no API key) |
| Supabase `location_history` table | Stores all migration records |
| Supabase RLS | Users can only see location history of connected households |
| Supabase Edge Function | Geocoding endpoint (server-side to avoid CORS) |
| `html2canvas` or Canvas API | Screenshot/share feature |

---

## SQL schema additions (SQL 002)

```sql
CREATE TABLE IF NOT EXISTS location_history (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  household_id  UUID NOT NULL REFERENCES households(id) ON DELETE CASCADE,
  city          TEXT NOT NULL,
  country       TEXT NOT NULL,
  lat           NUMERIC(9,6),
  lng           NUMERIC(9,6),
  moved_month   INTEGER CHECK (moved_month BETWEEN 1 AND 12),
  moved_year    INTEGER NOT NULL,
  is_birth_place BOOLEAN DEFAULT false,
  is_current    BOOLEAN DEFAULT false,
  notes         TEXT,
  sort_order    INTEGER DEFAULT 0,
  created_at    TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_loc_history_user      ON location_history(user_id);
CREATE INDEX IF NOT EXISTS idx_loc_history_household ON location_history(household_id);
CREATE INDEX IF NOT EXISTS idx_loc_history_year      ON location_history(moved_year);
CREATE INDEX IF NOT EXISTS idx_loc_history_latlng    ON location_history(lat, lng)
  WHERE lat IS NOT NULL AND lng IS NOT NULL;

ALTER TABLE location_history ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "loc_history_select" ON location_history;
CREATE POLICY "loc_history_select" ON location_history
  FOR SELECT USING (
    user_id = auth.uid()
    OR household_id IN (
      SELECT household_a FROM connections
        WHERE household_b IN (SELECT id FROM households WHERE owner_id = auth.uid())
        AND status = 'accepted'
      UNION
      SELECT household_b FROM connections
        WHERE household_a IN (SELECT id FROM households WHERE owner_id = auth.uid())
        AND status = 'accepted'
    )
  );

DROP POLICY IF EXISTS "loc_history_own" ON location_history;
CREATE POLICY "loc_history_own" ON location_history
  FOR ALL USING (user_id = auth.uid());
```

---

## Security DEFINER RPC for globe data

```sql
DROP FUNCTION IF EXISTS get_migration_paths(UUID);
CREATE OR REPLACE FUNCTION get_migration_paths(requesting_user UUID)
RETURNS TABLE (
  household_id  UUID,
  household_name TEXT,
  person_name   TEXT,
  city          TEXT,
  country       TEXT,
  lat           NUMERIC,
  lng           NUMERIC,
  moved_year    INTEGER,
  moved_month   INTEGER,
  is_birth_place BOOLEAN,
  is_current    BOOLEAN,
  sort_order    INTEGER
)
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  RETURN QUERY
  SELECT
    lh.household_id,
    h.name AS household_name,
    COALESCE(u.display_name, u.first_name || ' ' || u.last_name) AS person_name,
    lh.city, lh.country, lh.lat, lh.lng,
    lh.moved_year, lh.moved_month,
    lh.is_birth_place, lh.is_current, lh.sort_order
  FROM location_history lh
  JOIN households h ON h.id = lh.household_id
  JOIN users u ON u.id = lh.user_id
  WHERE lh.household_id IN (
    SELECT id FROM households WHERE owner_id = requesting_user
    UNION
    SELECT household_a FROM connections
      WHERE household_b IN (SELECT id FROM households WHERE owner_id = requesting_user)
      AND status = 'accepted'
    UNION
    SELECT household_b FROM connections
      WHERE household_a IN (SELECT id FROM households WHERE owner_id = requesting_user)
      AND status = 'accepted'
  )
  AND lh.lat IS NOT NULL AND lh.lng IS NOT NULL
  ORDER BY lh.household_id, lh.sort_order, lh.moved_year;
END;
$$;

GRANT EXECUTE ON FUNCTION get_migration_paths(UUID) TO authenticated;
```

---

## Feature matrix entry

| Field | Value |
|-------|-------|
| ID | GLOBE-001 |
| Phase | 2 — Growth |
| Area | UI + Database + Network |
| Value | High / Immediate (key differentiator, viral moment) |
| Build time | 8+ hours (XL) |
| Components | HTML Canvas, Supabase, Nominatim geocoding |

---

## Open questions / decisions needed

| # | Question | Notes |
|---|----------|-------|
| 1 | Canvas vs Three.js for rendering | Canvas is simpler, Three.js is more capable at scale. Start with Canvas, migrate if performance degrades with 50+ nodes. |
| 2 | Mapbox for the base globe? | Mapbox Globe mode is gorgeous but adds cost + complexity. Canvas DIY globe is free and fully controllable. Decision: start with Canvas. |
| 3 | Privacy — should migration history be visible to all connected users? | Default: migration history visible to accepted connections. User can set each location to "private" (self only) or "network" (all connections). |
| 4 | What is the root / "top of tree"? | For alpha/beta test: Amritsar, Punjab, India. In production: the user defines their earliest known ancestor location as the origin. |
| 5 | Animate mode speed and timeline range | Timeline: oldest recorded year to current year. Speed: 1x = real time (1 second per year), 5x = 5 years per second. |
| 6 | Screenshot sharing | "Share your family's journey" button exports a 1200×800 PNG of the current globe state. Include family name watermark at bottom. |

---

_This document is part of the FMTO product bible. Update as decisions are made._
_Related files: sql/002_location_history.sql (to be created), app/globe.html (Phase 2)_
