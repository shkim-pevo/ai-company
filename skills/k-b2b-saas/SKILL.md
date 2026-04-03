---
name: k-b2b-saas
description: Build trustworthy Korean B2B SaaS interfaces — product landing pages paired with documentation sites. Single brand color (teal/mint default), product screenshots shown directly, numbered feature sections, GitBook-style docs with emoji sidebar. Use for accounting tools, finops, HR platforms, CRM, ERP, or any Korean enterprise SaaS.
---

# K-B2B SaaS Design

Build interfaces that say "We handle your serious business, reliably." This is the standard design language of Korean B2B software — clean, product-first, trust-oriented. No marketing fantasies, just the real product.

## When to Use

- B2B SaaS landing pages (finance, HR, CRM, ERP)
- Accounting, tax, and bookkeeping tools
- Enterprise data management platforms
- Finops and treasury management
- Product + documentation site pairs
- Any Korean B2B software that needs to feel trustworthy

## The Aesthetic

**White canvas + single brand color + real product screenshots.** Show what the user will actually use. No device mockups, no lifestyle imagery. The product IS the hero.

## Foundation

### Colors
```css
:root {
  /* Brand — teal/mint default, replace with your brand color */
  --brand: #2ec4b6;
  --brand-hover: #25a89c;
  --brand-active: #1e8f85;
  --brand-light: rgba(46, 196, 182, 0.08);

  /* Backgrounds */
  --bg-white: #ffffff;
  --bg-gray: #f5f5f5;
  --bg-subtle: #fafafa;

  /* Text */
  --text-heading: #1a1a1a;
  --text-body: #333333;
  --text-secondary: #666666;
  --text-muted: #999999;

  /* Borders */
  --border: #e5e5e5;
  --border-light: #f0f0f0;
}
```

### Typography
```css
body {
  font-family: 'Pretendard', 'Inter', -apple-system, sans-serif;
  word-break: keep-all;
  color: var(--text-body);
}
```

| Element | Size | Weight | Line Height |
|---------|------|--------|-------------|
| Hero Heading | 40–48px | 700 | 1.2 |
| Section Heading | 28–36px | 700 | 1.3 |
| Card Title | 18–20px | 600 | 1.4 |
| Body | 15–16px | 400 | 1.7 |
| Nav/Button | 14–16px | 500–600 | 1.0 |
| Banner | 14px | 500 | 1.0 |

## Core Components

### Top Announcement Banner
Full-width brand color bar for news/partnerships.
```css
.banner {
  width: 100%;
  background: var(--brand);
  color: #ffffff;
  text-align: center;
  padding: 10px 16px;
  font-size: 14px;
  font-weight: 500;
}
```

### Dual CTA Buttons
Solid brand (primary) + Ghost white (secondary), always paired.
```css
.btn-primary {
  padding: 14px 28px;
  background: var(--brand);
  color: #fff;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 600;
}
.btn-ghost {
  padding: 14px 28px;
  background: #fff;
  color: var(--text-body);
  border: 1.5px solid var(--border);
  border-radius: 8px;
  font-size: 16px;
  font-weight: 500;
}
.btn-ghost:hover {
  border-color: var(--brand);
  color: var(--brand);
}
```

### Product Screenshot Card
No device frames. Show the real product UI.
```css
.screenshot-card {
  background: #fff;
  border: 1px solid var(--border);
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}
.screenshot-card img { width: 100%; display: block; }
```

### Docs Sidebar (GitBook-style)
Emoji category icons + hierarchical menu.
```css
.sidebar-category {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 12px;
  font-size: 14px;
  font-weight: 600;
  color: var(--brand);
}
.sidebar-item {
  padding: 6px 12px 6px 36px;
  font-size: 14px;
  color: var(--text-secondary);
  border-radius: 6px;
}
.sidebar-item.active {
  background: var(--brand-light);
  color: var(--brand);
  font-weight: 500;
}
```

### Numbered Feature Section (Docs)
```css
.feature-section h2 {
  font-size: 24px;
  font-weight: 700;
  color: var(--text-heading);
  margin-bottom: 16px;
}
.feature-section li {
  font-size: 15px;
  line-height: 1.7;
  margin-bottom: 6px;
}
.guide-link {
  color: var(--brand);
  font-size: 14px;
  font-weight: 500;
}
```

## Layout

### Landing Page
- **Container**: `max-width: 1140px; margin: 0 auto;`
- **Hero**: Centered heading + dual CTAs, 120px+ vertical padding
- **Product showcase**: 2-column screenshot grid, `gap: 24px`
- **Alternating sections**: `#ffffff` ↔ `#f5f5f5`
- **Section spacing**: 80–100px vertical padding

### Documentation Site
- **3-column**: Sidebar (260px) + Content (flex, max 720px) + TOC (200px)
- **Sidebar**: Fixed, scrollable, emoji categories, hierarchical
- **Content**: Numbered sections, bullet lists, guide links
- **TOC**: Fixed right, auto-generated from headings
- **Search**: Top area, `⌘ K` shortcut

## Depth

Almost flat. Borders > shadows.

| Level | Surface | Effect |
|-------|---------|--------|
| 0 | `#fff` / `#f5f5f5` | Flat |
| 1 (Card) | `#fff` | `border + 0 2px 8px rgba(0,0,0,0.06)` |
| 2 (Nav) | `#fff` | `border-bottom: 1px solid #f0f0f0` |
| 3 (Modal) | `#fff` | `0 8px 30px rgba(0,0,0,0.12)` |

## Rules

### Do
- Show actual product UI in screenshots — real dashboards, real data
- Single brand color across landing + docs
- Announcement banner at top in brand color
- Pair landing with branded documentation site
- Emoji icons in doc sidebar categories
- Number feature sections (1, 2, 3...)
- Guide links after each feature description
- Moderate border-radius (8–12px)
- Dual CTA: solid brand + ghost white

### Don't
- Device mockups — show raw product UI
- Decorative gradients, blobs, or textures
- Lifestyle photos or large hero imagery
- Oversized body text — 15–16px is practical for B2B
- Pill-shaped buttons — 8px radius is professional
- Excessive animation — subtle scroll reveals only
- Multiple accent colors — one brand color
- Over-styled docs — GitBook defaults + brand color

## Responsive

### Landing
- **Desktop (1140px+)**: 2-col screenshots, centered hero
- **Tablet (768px+)**: Screenshots may stack
- **Mobile (< 768px)**: Single column, stacked CTAs

### Docs
- **Desktop (1024px+)**: 3-column (sidebar + content + TOC)
- **Tablet**: Sidebar → hamburger, TOC hidden
- **Mobile**: Full-width content only
