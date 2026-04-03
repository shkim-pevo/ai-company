---
name: soft-corporate
description: Build approachable, premium landing pages and corporate sites with lavender-tinted backgrounds, frosted glass cards, bold headings, and pastel aurora decorations. Use for AI/SaaS landing pages, B2B marketing, healthcare platforms, or any site that needs to feel trustworthy, innovative, and human. The opposite of tactical-dashboard — soft, light, breathing room everywhere.
---

# Soft Corporate Design

Build interfaces that feel like a premium co-working space filled with natural light. This style communicates trust, innovation, and approachability through soft tones, generous whitespace, and frosted glass surfaces.

## When to Use

- AI/SaaS company landing pages and marketing sites
- Healthcare, wellness, or education platforms
- B2B enterprise product pages
- Corporate portfolios and team sites
- Fintech onboarding and product launches
- Any interface where "approachable, premium, trustworthy" is the mood

## The Aesthetic

**Tinted light + frosted surfaces + bold statements.** The background is soft lavender, not white. Cards float on frosted glass. Headings are bold and large. Pastel gradient blobs add warmth. Everything breathes.

## Foundation

### Colors
```css
:root {
  /* Backgrounds */
  --bg-page: #eeedf5;
  --bg-section: #e8e7f0;
  --bg-card: #ffffff;
  --bg-frost: rgba(255, 255, 255, 0.8);

  /* Text */
  --text-heading: #1a1a2e;
  --text-body: #4a4a5a;
  --text-muted: #8b8b9e;

  /* Accent */
  --accent-lavender: #8b5cf6;
  --accent-lavender-light: #c4b5fd;
  --accent-pink: #f9a8d4;
  --accent-cyan: #67e8f9;
  --accent-mint: #6ee7b7;

  /* Aurora gradient */
  --gradient-aurora: linear-gradient(135deg, #c4b5fd 0%, #f9a8d4 50%, #67e8f9 100%);

  /* Borders & Shadows */
  --border-light: rgba(0, 0, 0, 0.06);
  --border-accent: rgba(139, 92, 246, 0.2);
  --shadow-card: 0 8px 30px rgba(0, 0, 0, 0.06);
  --shadow-hover: 0 16px 40px rgba(0, 0, 0, 0.08);
}
```

### Typography
```css
:root {
  /* Korean-first */
  --font-display: 'Pretendard', 'SUIT', 'Apple SD Gothic Neo', sans-serif;
  /* International */
  --font-display-intl: 'Plus Jakarta Sans', 'General Sans', 'Outfit', sans-serif;
}
```

Rules:
- Headings: **bold** (700–800), large (36–56px), sentence case, tight letter-spacing
- Body: **light** (400), generous line-height (1.7), muted color
- Badges/tags: small (12–13px), inside rounded pill chips
- **Never uppercase headings** — sentence case is warmer and more approachable
- Korean text: extra line-height (1.7–1.8)

| Element | Size | Weight | Line Height |
|---------|------|--------|-------------|
| Hero Heading | 48–56px | 800 | 1.15 |
| Section Heading | 36–44px | 700 | 1.2 |
| Card Title | 18–22px | 600–700 | 1.3 |
| Body | 15–17px | 400 | 1.7 |
| Caption | 13–14px | 400 | 1.5 |
| Badge | 12–13px | 500 | 1.0 |

## Core Components

### Section Badge
Small rounded chip above section headings. Provides context.
```css
.section-badge {
  display: inline-flex;
  padding: 6px 16px;
  border-radius: 100px;
  background: rgba(139, 92, 246, 0.08);
  border: 1px solid rgba(139, 92, 246, 0.15);
  color: #8b5cf6;
  font-size: 13px;
  font-weight: 500;
  margin-bottom: 16px;
}
```

### Frost Card
Primary content container. Semi-transparent with backdrop blur.
```css
.card {
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.6);
  border-radius: 20px;
  padding: 32px;
  box-shadow: var(--shadow-card);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-hover);
}
```

### Feature Card (Icon + Title + Description)
```css
.feature-card {
  background: #ffffff;
  border: 1px solid var(--border-light);
  border-radius: 16px;
  padding: 28px 24px;
}
.feature-card .icon {
  width: 48px; height: 48px;
  margin-bottom: 16px;
  stroke-width: 1.5;
  stroke: #1a1a2e;
  fill: none; /* monoline style */
}
```

### Buttons
Two CTA styles — ghost (light) and solid (dark):
```css
/* Ghost — secondary CTA */
.btn-ghost {
  padding: 12px 28px;
  border: 1.5px solid rgba(0, 0, 0, 0.15);
  border-radius: 100px;
  background: transparent;
  color: #1a1a2e;
  font-size: 15px;
  font-weight: 500;
}
.btn-ghost:hover {
  border-color: #8b5cf6;
  color: #8b5cf6;
}

/* Solid — primary CTA */
.btn-solid {
  padding: 14px 32px;
  border: none;
  border-radius: 100px;
  background: #000000;
  color: #ffffff;
  font-size: 15px;
  font-weight: 500;
}
.btn-solid:hover {
  background: #1a1a2e;
  transform: translateY(-1px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}
```

### Aurora Decoration
Soft gradient blobs in section corners. Atmospheric, not functional.
```css
.aurora-blob {
  position: absolute;
  width: 300px; height: 300px;
  border-radius: 50%;
  background: var(--gradient-aurora);
  filter: blur(80px);
  opacity: 0.4;
  pointer-events: none;
  z-index: 0;
}
```

### Frosted Navigation
```css
.nav {
  position: fixed;
  top: 16px;
  left: 50%;
  transform: translateX(-50%);
  background: rgba(255, 255, 255, 0.7);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.5);
  border-radius: 16px;
  padding: 12px 32px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
  z-index: 100;
}
```

## Layout

- **Centered container**: `max-width: 1140px; margin: 0 auto;`
- **Section spacing**: 80–120px vertical padding between sections
- **Hero**: Two-column — text left (60%), illustration right (40%)
- **Feature grid**: 3 columns max, `gap: 20px`
- **Card stack pattern**: Heading+description left, vertical card list right
- **Prose constraint**: Max 600px width for text blocks
- **Alternating sections**: Page background → tinted panel → page background

## Depth System

No harsh shadows. Everything is subtle and warm:

| Level | Surface | Effect |
|-------|---------|--------|
| 0 (Page) | `#eeedf5` | Ambient canvas |
| 1 (Section) | `#e8e7f0` or `rgba(255,255,255,0.5)` | Subtle panel |
| 2 (Card) | `#ffffff` / frosted glass | Primary content |
| 3 (Nav) | Frosted glass + shadow | Fixed, above all |
| 4 (Modal) | `#ffffff` + `0 20px 60px rgba(0,0,0,0.1)` | Overlay |

## Rules

### Do
- Tinted off-white background — never pure `#ffffff` for the page
- Bold, large headings as primary visual anchors
- Pastel aurora gradient blobs for atmospheric warmth
- Generous whitespace (80px+ between sections)
- Large border-radius on cards (16–24px)
- Section badges above headings
- Thin-line monoline icons (unfilled SVG)
- Frosted glass on nav and overlay elements
- Pill-shaped buttons (`border-radius: 100px`)

### Don't
- Sharp corners or squared-off elements
- Dense, crowded layouts — this style needs breathing room
- Dark or saturated backgrounds — keep it light and airy
- Neon, glowing, or high-contrast effects
- Heavy drop shadows
- Uppercase headings — sentence case is more approachable
- More than 3 card columns
- Monospace for body text (code/data only)

## Responsive

- **Desktop (1280px+)**: 3-col grid, two-column hero, full aurora blobs
- **Tablet (768–1279px)**: 2-col grid, stacked hero, scaled-down blobs
- **Mobile (< 768px)**: Single column, stacked cards, hidden aurora blobs
- Hero headings: `clamp(32px, 5vw, 56px)`
- Section spacing: 100px desktop → 60px mobile
- Card padding: 32px desktop → 20px mobile, border-radius unchanged
