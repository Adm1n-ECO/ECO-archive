# FMTO — Feature Specification: Globe Day/Night Satellite View
_Feature ID: GLOBE-002 · Priority: High / Phase 2 · Created: 2026-03-19_
_Depends on: GLOBE-001 (Migration Globe)_

---

## Feature name
**Globe Day/Night Satellite View** — The globe renders in real time based on the user's local time zone. Day side appears as a deep ocean/terrain view. Night side shows city lights glowing amber and white against darkness — a photorealistic satellite representation. The terminator line (day/night boundary) moves live as time passes.

---

## Concept
The inspiration is NASA's "Black Marble" satellite imagery — Earth at night, city lights visible from space, the curved terminator line separating day from night. Every user who opens the globe sees a unique view depending on exactly when they open it. Someone in San Jose at 10pm sees a mostly-dark Americas with Asia and Europe lit up in blue morning haze. Someone in Delhi at 7am sees the subcontinent in daylight while the Americas glow with city lights.

This makes the globe feel alive. It is not a static map. It breathes with real time.

---

## How it works technically

### Solar position calculation
The sun's position (latitude and longitude on Earth's surface directly below it) is calculated in real time using standard astronomical formulas:

```javascript
function getSunLatLng(timestampMs) {
  // Julian Date
  var JD  = timestampMs/86400000 + 2440587.5;
  var n   = JD - 2451545.0;  // days since J2000.0

  // Sun's mean longitude and mean anomaly
  var L   = (280.46 + 0.9856474*n) % 360;
  var g   = (357.528 + 0.9856003*n) * Math.PI/180;

  // Ecliptic longitude
  var lam = (L + 1.915*Math.sin(g) + 0.020*Math.sin(2*g)) * Math.PI/180;

  // Obliquity of ecliptic
  var eps = 23.439 * Math.PI/180;

  // Declination (sun's latitude)
  var dec = Math.asin(Math.sin(eps)*Math.sin(lam)) * 180/Math.PI;

  // Greenwich Mean Sidereal Time → sun's longitude
  var GMST = (6.697375 + 0.0657098242*n + (timestampMs%86400000)/3600000) % 24;
  var lng  = -(GMST/24*360 + (L + 180)) % 360;

  return { lat: dec, lng: ((lng%360)+540)%360 - 180 };
}
```

Accuracy: within ~1 degree of true solar position. More than sufficient for visual purposes.

### Night-side darkness calculation
For any point on the globe, the darkness level is derived from the dot product of that point's 3D vector with the sun's 3D vector:

```javascript
function nightDepth(lat, lng, sun) {
  var pointVec = latLngTo3D(lat, lng);
  var sunVec   = latLngTo3D(sun.lat, sun.lng);
  var dot = pointVec.x*sunVec.x + pointVec.y*sunVec.y + pointVec.z*sunVec.z;
  // dot = 1 at subsolar point (full day), -1 at antipodal point (deep night)
  return Math.max(0, Math.min(1, -dot * 2.5 + 0.5));
}
```

`nightDepth = 0` → full daylight. `nightDepth = 1` → full night. The transition zone (0.05–0.35) creates the soft terminator gradient (twilight/dusk/dawn band).

### Pixel-level surface rendering (Canvas ImageData)
The globe surface is painted pixel by pixel using `ctx.createImageData()`. For every pixel inside the globe circle, the screen coordinates are reverse-projected back to lat/lng on the sphere, then colored based on night depth:

- **Day side:** Deep blue-green (#14324A range) representing ocean/terrain from altitude
- **Night side:** Near black (#040710) representing the dark Earth
- **Twilight band:** Smooth interpolation between the two
- **Resolution:** Rendered at 2×2 pixel blocks for performance (still sharp at globe scale)

### City lights (night side only)
37 major metro areas are stored as lat/lng + brightness weight. On the night side (nightDepth > 0.05), each city renders as a radial gradient glow:

- Core: warm white/amber (rgba 255,230,160)
- Mid halo: orange-amber fade
- Outer halo: warm red fade to transparent
- Size: proportional to globe radius × city brightness weight
- Only drawn when nightDepth > threshold — they fade in and out naturally as the terminator passes

### Atmosphere rim
A subtle radial gradient sits just outside the globe edge — blue-tinted, low opacity — simulating the atmospheric scattering visible from space (the thin blue line at Earth's edge in astronaut photography).

### Specular shimmer
A very subtle radial gradient overlay simulates reflected sunlight on the day side — slightly brighter toward the subsolar point, slightly darker at the limb.

---

## Visual specification

### Color palette — day side
| Element | Color | Notes |
|---------|-------|-------|
| Deep ocean (full day) | #1A3E5A | Blue-teal, mid-depth |
| Shallow water / land | #162E40 | Slightly different to suggest terrain |
| Twilight band | Interpolated | Smooth gradient across ~15° of arc |

### Color palette — night side
| Element | Color | Notes |
|---------|-------|-------|
| Deep night sky/ground | #040710 | Near black with blue hint |
| City light core | rgba(255,230,160) | Warm white — sodium lamp color |
| City light mid halo | rgba(255,200,100) | Amber |
| City light outer glow | rgba(255,100,20) | Warm red fade |

### Node and arc colors (night mode)
Family network nodes and migration arcs shift to warmer tones on the dark globe to remain legible and beautiful:

| Generation | Day mode color | Night mode color |
|-----------|----------------|-----------------|
| Root origin | #5DCAA5 (teal) | #FFD580 (warm gold) |
| Gen 1 | #4DA8D8 (blue) | #F0A050 (amber) |
| Gen 2 | #E09A5A (amber) | #70C0E8 (ice blue) |
| Gen 3 | #C97DB5 (purple) | #C097D8 (lavender) |
| Friends | #7B8FD4 (slate) | #90B890 (sage) |

---

## Time badge
A small overlay in the top-left corner of the globe shows:
- The user's current local time (HH:MM)
- Their timezone name (from `Intl.DateTimeFormat().resolvedOptions().timeZone`)

This reinforces the "alive right now" feeling. Every time the user opens the globe, the time is different and the globe looks different.

---

## Performance considerations

| Factor | Approach |
|--------|---------|
| Pixel rendering cost | 2×2 pixel blocks — 4× fewer calculations, visually identical at globe size |
| Frame rate target | 30fps (draw only if >33ms since last frame) |
| City lights | Only calculated for visible hemisphere (z > 0 check before rendering) |
| ImageData reuse | New ImageData each frame — acceptable at globe dimensions |
| Mobile | Same Canvas API, same performance — no WebGL required |
| Large screens | Globe size capped by zoom level, not viewport — performance constant |

---

## City lights data set (37 metros — Phase 2 launch)

The initial city lights set covers all major light pollution centers visible from space:

**Americas:** New York, Los Angeles, Chicago, Houston, Phoenix, Seattle, San Jose, Toronto, Montreal, São Paulo, Buenos Aires

**Europe:** London, Paris, Berlin, Moscow, St Petersburg, Kyiv, Minsk, Istanbul

**Middle East / Africa:** Dubai, Riyadh, Tehran, Baghdad, Cairo, Lagos, Nairobi

**Asia:** Delhi, Mumbai, Bangalore, Dhaka, Beijing, Shanghai, Hong Kong, Seoul, Tokyo, Singapore, Sydney, Melbourne

### Phase 3 expansion
Additional 150+ cities added from NASA VIIRS night light intensity data. Brightness weights calibrated from actual satellite luminosity measurements.

---

## SQL additions for this feature
None required beyond what GLOBE-001 specified. The day/night rendering is entirely client-side using the user's local browser time. No server data needed.

The user's timezone is inferred from the browser (`Intl.DateTimeFormat().resolvedOptions().timeZone`) and optionally stored in `users.timezone` for server-side use in notifications and event scheduling.

### Optional: store user timezone
```sql
ALTER TABLE users ADD COLUMN IF NOT EXISTS timezone TEXT;
```

---

## Feature matrix entries

| ID | Title | Area | Value | Build time | Components |
|----|-------|------|-------|-----------|------------|
| GLOBE-002a | Globe day/night surface rendering | UI | High | L (3–8 hrs) | HTML Canvas |
| GLOBE-002b | Real-time solar position math | UI | High | S (< 1 hr) | HTML/JS |
| GLOBE-002c | City lights (37 metros) | UI | High | M (1–3 hrs) | HTML Canvas |
| GLOBE-002d | Atmosphere rim + specular shimmer | UI | Medium | S (< 1 hr) | HTML Canvas |
| GLOBE-002e | Time badge + timezone display | UI | Medium | S (< 1 hr) | HTML/JS |
| GLOBE-002f | City lights expansion (150+ cities) | UI | Low | M (1–3 hrs) | HTML Canvas |

---

## Open questions / decisions

| # | Question | Notes |
|---|----------|-------|
| 1 | Day-side terrain detail | Current: flat ocean color. Option: add subtle continent outlines (very faint, low contrast). Keeps it looking like satellite altitude not a political map. |
| 2 | Update frequency | Currently redraws every 33ms. Solar position only needs recalculating every ~60 seconds. Optimization: separate solar calc from render loop. |
| 3 | Screenshot mode lighting | When user screenshots the globe for sharing, should it always render in night mode for maximum visual impact? Or capture current state? Recommendation: current state — authenticity is the appeal. |
| 4 | Aurora simulation | Faint green shimmer near the poles (especially visible during high solar activity). A nice Phase 3 touch — not essential. |

---

_Related: GLOBE-001_MIGRATION_SPEC.md_
_Next step: Finalize continent outline approach, then build app/globe.html in Phase 2_

---

## Prototype render status (2026-03-19)

The following sub-features have been fully prototyped and confirmed working in Claude chat:

| ID | Feature | Status |
|----|---------|--------|
| GLOBE-001 | Migration globe — 3D canvas engine | ✅ Prototyped |
| GLOBE-001 | Migration arc routes (airline style) | ✅ Prototyped |
| GLOBE-001 | Tier filter system (6 levels) | ✅ Prototyped |
| GLOBE-001 | Mode switcher (Paths / Current / Animate) | ✅ Prototyped |
| GLOBE-001 | Home button + north-up reset | ✅ Prototyped |
| GLOBE-001 | Zoom in/out + scroll wheel | ✅ Prototyped |
| GLOBE-001 | Momentum physics (flick + decelerate) | ✅ Prototyped |
| GLOBE-001 | Touch drag (mobile) | ✅ Prototyped |
| GLOBE-001 | Node hover tooltip with migration history | ✅ Prototyped |
| GLOBE-002 | Real-time solar position math | ✅ Prototyped |
| GLOBE-002 | Day/night surface pixel rendering | ✅ Prototyped |
| GLOBE-002 | City lights — 37 metros | ✅ Prototyped |
| GLOBE-002 | Terminator glow (twilight band) | ✅ Prototyped |
| GLOBE-002 | Atmosphere rim + specular shimmer | ✅ Prototyped |
| GLOBE-002 | Time badge (local time + timezone) | ✅ Prototyped |

### Still to build (app/globe.html)
- Location history entry UI in household profile
- SQL 002 — location_history table + RLS
- Geocoding edge function (Nominatim)
- Screenshot / share button
- Wire to real Supabase data via get_migration_paths() RPC
- Continent outlines (Phase 3)
- City lights expansion 150+ (Phase 3)
- Aurora simulation (Phase 3)

### Implementation note
The entire globe engine (3D math, day/night render, city lights, arc routes, controls) runs in ~350 lines of pure vanilla JavaScript with zero external dependencies. No Three.js, no Mapbox, no WebGL. This is a deliberate architectural decision: instant load, no CDN risk, no cost at any scale, works on all devices.

