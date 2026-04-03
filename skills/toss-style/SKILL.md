---
name: toss-style
description: Build premium fintech interfaces with radical simplicity — pure white backgrounds, a single blue accent (#3182f6), bold Korean-optimized typography, and extreme whitespace. Use for fintech, banking, payment platforms, or any product that needs to feel clean, confident, and trustworthy. Inspired by Korea's leading fintech design language.
---

# Toss Style Design

Build interfaces that communicate confidence through radical simplicity. One accent color. Enormous typography. Extreme whitespace. No decorations. Every element earns its place through function, not ornament.

## When to Use

- Fintech, banking, and payment platforms
- Mobile-first product landing pages
- Korean-market SaaS and consumer apps
- Insurance, investment, and financial services
- Neobank and digital wallet interfaces
- Any product where "clean, confident, premium" is the mood

## The Aesthetic

**Pure white + single blue + bold type + extreme space.** The background is white. The accent is blue. The headings are massive. The whitespace is generous. There is nothing else. That's the point.

## Foundation

### Colors
```css
:root {
  /* The accent — one color rules everything */
  --toss-blue: #3182f6;
  --toss-blue-hover: #2272eb;
  --toss-blue-active: #1b64da;

  /* Backgrounds */
  --bg-white: #ffffff;
  --bg-gray: #f9fafb;
  --bg-dark: #000000;

  /* Neutral scale (7 steps) */
  --ink: #191f28;
  --gray-700: #333d4b;
  --gray-600: #6b7684;
  --gray-400: #b0b8c1;
  --gray-300: #d1d6db;
  --gray-200: #e5e8eb;
  --gray-100: #f2f4f6;
  --gray-50: #f9fafb;

  /* Semantic */
  --red: #f04452;
  --green: #03b26c;
  --orange: #fe9800;
  --teal: #18a5a5;
}
```

### Typography
```css
:root {
  --font-family: 'Toss Product Sans', 'Pretendard', -apple-system,
    'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif;
}

body {
  font-family: var(--font-family);
  word-break: keep-all;     /* Never split Korean words */
  letter-spacing: -0.02em;  /* Tighter for Korean */
  color: var(--ink);
}
```

| Element | Size | Weight | Line Height |
|---------|------|--------|-------------|
| Hero Heading | 50–60px | 700 | 1.2 |
| Section Heading | 36–48px | 700 | 1.3 |
| Subheading | 28–32px | 600 | 1.4 |
| Body Large | 20–23px | 400–600 | 1.6 |
| Body | 17–18px | 400 | 1.6 |
| Small | 14–15px | 400 | 1.5 |
| Section Label | 15–17px | 600 | 1.0 |

Rules:
- Headings are **large and bold** — they do 80% of the visual work
- Body text is **generously sized** (17px+) — never small
- **Weight contrast** is the hierarchy tool: 700 vs 400, not size differences
- `word-break: keep-all` is **mandatory** for Korean text
- One geometric sans-serif for everything — no font mixing

## Core Components

### Section Label
Small blue text above the main heading. Provides category context.
```css
.section-label {
  font-size: 16px;
  font-weight: 600;
  color: var(--toss-blue);
  margin-bottom: 12px;
}
/* Example: "홈 · 소비" above "금융의 모든 것, 토스에서" */
```

### Primary Button
```css
.btn-primary {
  padding: 16px 32px;
  background: var(--toss-blue);
  color: #ffffff;
  border: none;
  border-radius: 12px;
  font-size: 17px;
  font-weight: 600;
  transition: background 0.15s ease;
}
.btn-primary:hover { background: var(--toss-blue-hover); }
.btn-primary:active { background: var(--toss-blue-active); }
```

### Feature Card
```css
.card {
  background: #ffffff;
  border-radius: 24px;
  padding: 32px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.04),
              0 8px 24px rgba(0,0,0,0.06);
}
```

### Badge System
Color-coded tags. Background is 10% opacity of the text color.
```css
.badge {
  padding: 4px 10px;
  border-radius: 8px;
  font-size: 13px;
  font-weight: 600;
}
.badge-blue   { background: rgba(49,130,246,0.1);  color: #3182f6; }
.badge-green  { background: rgba(3,178,108,0.1);   color: #03b26c; }
.badge-red    { background: rgba(240,68,82,0.1);   color: #f04452; }
.badge-orange { background: rgba(254,152,0,0.1);   color: #fe9800; }
.badge-teal   { background: rgba(24,165,165,0.1);  color: #18a5a5; }
```

### Device Mockup
```css
.device-frame {
  border-radius: 40px;
  overflow: hidden;
  box-shadow: 0 8px 30px rgba(0,0,0,0.08),
              0 30px 60px rgba(0,0,0,0.05);
}
```

## Layout

- **Container**: `max-width: 1040px; margin: 0 auto;`
- **Section spacing**: **200–250px** vertical padding — the signature
- **Alternating backgrounds**: `#ffffff` → `#f9fafb` → `#ffffff` → `#000000` (footer)
- **Two-column feature**: Text (50%) + device mockup (50%), alternating sides
- **Card grid**: 3 columns max, `gap: 24px`
- **Hero**: Full-height with image/video background + white gradient overlay
- **Progressive disclosure**: Scroll-triggered reveals (fade + translateY 30px)

### Scroll Animation Pattern
```css
.reveal {
  opacity: 0;
  transform: translateY(30px);
  transition: opacity 0.6s ease, transform 0.6s ease;
}
.reveal.visible {
  opacity: 1;
  transform: translateY(0);
}
```

## Depth System

Shadows are always dual-layer, always neutral, always subtle:

| Level | Surface | Shadow |
|-------|---------|--------|
| 0 (Page) | `#ffffff` / `#f9fafb` | None |
| 1 (Card) | `#ffffff` | `0 2px 8px rgba(0,0,0,0.04), 0 8px 24px rgba(0,0,0,0.06)` |
| 2 (Nav) | `#ffffff` | Hairline border `#e5e8eb` bottom |
| 3 (Modal) | `#ffffff` | `0 4px 12px rgba(0,0,0,0.06), 0 16px 40px rgba(0,0,0,0.08)` |

No colored shadows. No glow. Neutral only.

## Rules

### Do
- Pure white (`#fff`) primary background — no tints
- Single accent color (`#3182f6`) — one color does everything
- Enormous bold headings (50px+) — primary communication tool
- Extreme whitespace (200px+ between sections)
- Alternate `#fff` ↔ `#f9fafb` section backgrounds
- Blue section labels above headings
- Device mockups for product demos
- Scroll-triggered fade-in animations
- 7-step gray scale — use it consistently
- Dark footer (`#000`) for dramatic ending
- `word-break: keep-all` for Korean text

### Don't
- Gradients, textures, patterns, decorative blobs — purity is the point
- Multiple accent colors — one blue, period
- Dense or cramped layouts — 200px+ breathing room
- Small text — body starts at 17px
- Pill buttons (100px radius) — use moderate 12px radius
- Heavy or colored shadows — barely visible, neutral only
- Colored section backgrounds — only white and near-white
- Decorative icons — show real product screenshots
- Font mixing — one sans-serif for everything
- All-caps headings — sentence case, natural Korean

## Responsive

- **Desktop (1040px+)**: Two-column, 250px sections, full mockups
- **Tablet (640–1039px)**: Narrower, 150px sections, scaled mockups
- **Mobile (< 640px)**: Single column, 100px sections, full-width cards
- Hero: `clamp(36px, 6vw, 60px)` for headings
- Body stays 17px on mobile — readability is non-negotiable
- `flex-wrap-reverse` for alternating text/image on mobile
- Dark footer remains full-width at all sizes
