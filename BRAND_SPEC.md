# FindMyTree.Online — Brand Specification
_Version 1.0 · 2026-03-19 · FMTO Brand System_

---

## Overview

FindMyTree.Online (FMTO) is a subsidiary of CRUNOD. The brand inherits CRUNOD's electric cyan and neon green identity but applies it through a distinct mark — the dual magnolia tree composition — that communicates family, connection, and living growth.

---

## The Mark

### Concept
Two magnolia trees in composition:
- **Foreground tree** (neon green blooms) — the family tree. Present, dominant, in full light.
- **Background tree** (cyan blooms) — the extended network. Friends, connections, people who orbit the family. Partially visible behind the primary tree.

The magnolia was chosen deliberately:
- Blooms before its leaves appear — a symbol of something new opening
- Meaningful across North India, East Asia, the American South, and the UK — the exact geographies FMTO's founding family spans
- The bloom shape allows clean geometric construction that reproduces at any scale

### Construction principle
The mark is built entirely from **closed filled paths** — no transparency, no gradients in the master file. Every bloom petal is a discrete geometric shape. This means:
- The mark can be rendered in any single color and remain fully legible
- No transparency issues in print (CMYK, Pantone spot)
- No rendering artifacts at small sizes
- Can be cut, embossed, engraved, embroidered, or screen-printed

---

## Master Files

| File | Use |
|------|-----|
| `assets/logo-primary.svg` | Primary full-color lockup — web, presentations, digital |
| `assets/logo-mark.svg` | Icon mark only — app icons, favicons, small use |
| `assets/logo-wordmark.svg` | Text lockup without mark — horizontal compact |
| `assets/logo-mono-white.svg` | Reversed white version — dark backgrounds, embroidery |
| `assets/logo-mono-black.svg` | Black version — letterhead, business cards, print |

**Source of truth:** All master files are SVG. Never export from a rasterized source. When preparing for print, export from SVG to PDF (vector) or EPS — never PNG as master.

---

## Official Colour Values

| Swatch | Name | Hex | Pantone | CMYK | RGB |
|--------|------|-----|---------|------|-----|
| ● | FMTO Green | #00E040 | Pantone 802 C | C:56 M:0 Y:100 K:0 | 0, 224, 64 |
| ● | FMTO Cyan | #00E5CC | Pantone 3255 C | C:67 M:0 Y:22 K:0 | 0, 229, 204 |
| ● | FMTO Black | #070D14 | Pantone Black 6 C | C:80 M:65 Y:40 K:90 | 7, 13, 20 |
| ○ | FMTO White | #E8F4F0 | Pantone 9543 C | C:6 M:1 Y:4 K:0 | 232, 244, 240 |
| ● | Admin Amber | #E09040 | Pantone 137 C | C:0 M:38 Y:78 K:5 | 224, 144, 64 |

**Note on FMTO White:** The brand white is a very slightly warm off-white (#E8F4F0), not pure white. This prevents harshness against the dark backgrounds and reads as a considered choice rather than a default.

**Note on CMYK:** FMTO Green (#00E040) and FMTO Cyan (#00E5CC) are both highly saturated digital colors. When printing CMYK, the Pantone spot color references (802 C and 3255 C) will produce more accurate results than CMYK process. For high-end print work (packaging, signage), always specify Pantone.

---

## Typography

### Display / Headlines
**DM Serif Display** (Google Fonts, free)
- Used for: hero headlines, section titles, feature names
- Style: Regular + Italic
- The italic variant gives the organic feeling appropriate for a family product

### Body / UI
**DM Sans** (Google Fonts, free)
- Used for: body text, UI labels, navigation, buttons
- Weights: 300 Light, 400 Regular, 500 Medium, 600 SemiBold

### Wordmark / Monospaced
**JetBrains Mono** (Google Fonts, free)
- Used for: the FINDMYTREE.ONLINE wordmark only
- Weight: 500 Medium
- Letter spacing: +0.12em in the wordmark
- Inherits from CRUNOD parent brand's tech/terminal aesthetic

---

## Logo Lockup Variants

### 1. Primary (preferred)
Mark + wordmark stacked
- Mark on left, wordmark right
- Tagline: "Your living family network" in DM Sans 8.5px, tracking +0.32em
- Use: website header, presentations, app splash screen

### 2. Compact horizontal
Mark (small) + single-line wordmark
- FINDMYTREE.ONLINE on one line
- Use: narrow headers, email signatures, mobile nav

### 3. Icon mark only
The tree composition without wordmark
- Use: app icon, favicon, social media avatar, embroidery
- Minimum size: 32px × 38px

### 4. Wordmark only
FINDMYTREE.ONLINE text without mark
- Use: very small sizes where the mark loses detail (below 16px height)
- Use: text-only contexts (domain name, document headers)

---

## Colour Usage Rules

| Background | Mark version | Notes |
|-----------|-------------|-------|
| FMTO Black (#070D14) | Full colour | Preferred. Maximum brand impact. |
| Any dark theme (#0D1A24 – #1E3040) | Full colour | All 4 FMTO themes work with full colour mark |
| White / light paper | Black mono | Never use full colour on white — cyan and green wash out |
| Coloured backgrounds | White mono | Reversed white mark on any sufficiently dark colour |
| Photography / imagery | White mono with clear space | Ensure sufficient contrast — test at actual reproduction size |

**Critical rule:** FMTO Green and FMTO Cyan are designed for dark backgrounds. Their entire visual power comes from contrast against dark surfaces. On white or light backgrounds, they become weak. Always use the black mono version for print on white.

---

## Size Rules

| Use case | Minimum size | Version |
|----------|-------------|---------|
| Website header | 80px wide | Primary or compact |
| Mobile header | 60px wide | Compact |
| Favicon | 16×16px | Mark only (simplified) |
| App icon | 64×64px | Mark only |
| Social avatar | 400×400px | Mark only with dark bg padding |
| Business card | 25mm wide | Black mono version |
| Letterhead | 35mm wide | Black mono version |
| Signage | No minimum | Full colour preferred |
| Embroidery | 30mm height minimum | White mono (fewer thread colors) |
| Embossed / debossed | 20mm height minimum | Mark only |

---

## Clear Space

Maintain clear space equal to the cap-height of the letter "F" in the wordmark on all four sides of the full lockup. For the icon mark alone, maintain clear space equal to 25% of the mark's height on all sides.

Never: crowd the mark against other elements, text, or the edge of a container.

---

## What Not To Do

1. **No rotation** — the mark is directional. The trees grow upward.
2. **No distortion or stretching** — always scale proportionally.
3. **No drop shadows on the mark** — the mark is designed to stand alone.
4. **No outlines added to the mark** — do not stroke the exterior of shapes.
5. **No colour substitution** — do not recolour the blooms to match a client brand.
6. **No unapproved colour combinations** — no green mark on cyan background, etc.
7. **No rasterization as master** — always work from SVG source files.
8. **No low-contrast placement** — always verify WCAG AA contrast ratios.
9. **No recreation from memory** — always use the master SVG files.
10. **No mark without permission** — the mark is trademarked. Usage by third parties requires written consent.

---

## File Delivery Checklist (for agencies / designers)

When delivering logo files to an external party, provide:

- [ ] `logo-primary.svg` — full colour, for all digital use
- [ ] `logo-mark.svg` — icon only, for all digital use
- [ ] `logo-mono-white.svg` — for dark backgrounds, print on dark stock
- [ ] `logo-mono-black.svg` — for light backgrounds, standard print
- [ ] `logo-primary.pdf` — vector PDF for print production
- [ ] `logo-primary@2x.png` — 600px wide, transparent bg, for presentations
- [ ] `logo-mark-512.png` — 512px square with dark bg, for app stores
- [ ] This brand specification document (PDF)

---

## Parent Brand Relationship

FMTO is a CRUNOD portfolio company. The relationship is expressed through:
- Shared primary colors (FMTO Green and FMTO Cyan are both CRUNOD brand colors)
- Shared dark background philosophy (all dark themes, never light-first)
- Shared monospace wordmark style (JetBrains Mono in both brands)
- FMTO does NOT use the CRUNOD logotype or mark — it has its own distinct identity

On co-branded materials (e.g. "FMTO, a CRUNOD company"), the FMTO mark leads at full size. The CRUNOD name appears as a smaller supporting credit in the same typeface at reduced weight.

---

## Tree Selection Feature (onboarding UX)

When a new user creates their first tree, they will be presented with a tree selector — choosing the visual style of their network visualization. The dual-magnolia mark serves as the default/hero option. Additional tree styles will be offered (Phase 3). Each style will be rendered in the same two-color FMTO Green + FMTO Cyan system so all trees remain on-brand regardless of which the user selects.

---

_This document is the master brand reference for FindMyTree.Online._
_Update this document whenever brand decisions are made. Version control in GitHub alongside all other FMTO assets._
_Next: export mono SVG variants and prepare app icon set (1024×1024, 512×512, 256×256, 128×128, 64×64, 32×32, 16×16)._
