# Design System: K-B2B SaaS

## 1. Visual Theme & Atmosphere

K-B2B SaaS is the standard design language of Korean business-to-business software companies — financial tools, accounting platforms, HR systems, and enterprise SaaS. It prioritizes **clarity, trust, and functional simplicity** over visual flair. The design communicates: "We handle your serious business operations, and we do it reliably."

The foundation is pure white (`#ffffff`) with light gray section panels (`#f5f5f5` to `#fafafa`). Against this neutral canvas, a single brand color — typically teal/mint (`#2ec4b6`), but adaptable to any corporate hue — handles all interactive elements: CTA buttons, links, notification banners, active states. The palette is deliberately restrained, because in B2B finance, trust comes from restraint, not spectacle.

What distinguishes this style from consumer fintech (toss-style) is the **product-first presentation**. Instead of lifestyle imagery and device mockups, K-B2B SaaS shows the actual product UI directly — real dashboard screenshots, real sidebar navigation, real data tables. The message is: "This is what you'll actually use, not a marketing fantasy." Screenshots are presented clean and unframed, often in 2-column grid layouts with subtle shadows on white cards.

Typography is bold for headings (36–48px, weight 700) but keeps body text at a practical 15–16px. The tone is informative and direct, not aspirational. Korean text optimization (`word-break: keep-all`) is standard. A top announcement bar in the brand color communicates news/partnerships. Documentation lives on GitBook or similar platforms with the same brand color threaded through links, and uses emoji category icons in the sidebar navigation.

**Key Characteristics:**
- Pure white background with light gray alternating sections
- Single brand color for all interactive elements (commonly teal/mint, adaptable)
- Product screenshots shown directly (no device mockup frames)
- 2-column screenshot grid for feature demonstration
- Top announcement banner bar in brand color
- Bold centered headings with practical body text
- Dual CTA pattern: solid brand button + ghost white button
- Paired documentation site (GitBook) with matching brand color
- Emoji-decorated sidebar navigation in docs
- 3-column doc layout: sidebar + content + TOC
- Numbered feature sections with bullet lists and guide links
- Low decoration — no gradients, no blobs, no textures

## 2. Color Palette & Roles

### Primary
- **White** (`#ffffff`): Page background, card surfaces.
- **Light Gray** (`#f5f5f5`): Alternating section backgrounds, screenshot container panels.
- **Near White** (`#fafafa`): Subtle surface variations.

### Brand (Teal/Mint — Default, Adaptable)
- **Brand Primary** (`#2ec4b6`): CTA buttons, top banner, links, active states. The single interactive color.
- **Brand Hover** (`#25a89c`): Darkened for hover states.
- **Brand Active** (`#1e8f85`): Further darkened for press states.
- **Brand Light** (`rgba(46,196,182,0.08)`): Subtle background tint for badges, selected states.
- **Brand 10%** (`rgba(46,196,182,0.1)`): Link hover backgrounds.

### Text
- **Heading** (`#1a1a1a`): Primary headlines. Near-black.
- **Body** (`#333333`): Body paragraphs, descriptions.
- **Secondary** (`#666666`): Captions, metadata, sidebar items.
- **Muted** (`#999999`): Placeholder text, disabled items.

### Semantic
- **Success** (`#22c55e`): Positive values, increase indicators.
- **Error** (`#ef4444`): Negative values, decrease indicators, errors.
- **Warning** (`#f59e0b`): Caution states.
- **Info** (`#3b82f6`): Informational badges.

### Borders & Shadows
- **Border Default** (`#e5e5e5`): Card borders, input borders, dividers.
- **Border Light** (`#f0f0f0`): Subtle separators.
- **Shadow Card** (`0 2px 8px rgba(0,0,0,0.06)`): Product screenshot cards.
- **Shadow Hover** (`0 4px 16px rgba(0,0,0,0.08)`): Elevated hover state.

## 3. Typography Rules

### Font Stack
- **Korean**: `'Pretendard', 'SUIT', 'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif`
- **International**: `'Inter', 'Plus Jakarta Sans', -apple-system, sans-serif`

### Scale

| Element | Size | Weight | Line Height | Notes |
|---------|------|--------|-------------|-------|
| Hero Heading | 40–48px | 700 | 1.2 | Centered, 2-3 lines max |
| Section Heading | 28–36px | 700 | 1.3 | Feature section titles |
| Card Title | 18–20px | 600 | 1.4 | Product feature names |
| Body | 15–16px | 400 | 1.7 | Practical, readable |
| Small | 13–14px | 400 | 1.5 | Captions, metadata |
| Nav Item | 14–15px | 500 | 1.0 | Navigation links |
| Button | 15–16px | 600 | 1.0 | CTA text |
| Banner | 14px | 500 | 1.0 | Top announcement bar |

### Rules
- `word-break: keep-all` for Korean text — mandatory.
- Headings bold (700) and centered for hero/CTA sections, left-aligned for feature sections.
- Body text is practical size (15–16px), not oversized like consumer fintech.
- No decorative fonts — clean geometric sans only.

## 4. Component Stylings

### Top Announcement Banner
```css
.banner {
  width: 100%;
  background: var(--brand-primary); /* #2ec4b6 */
  color: #ffffff;
  text-align: center;
  padding: 10px 16px;
  font-size: 14px;
  font-weight: 500;
}
.banner a {
  color: #ffffff;
  text-decoration: underline;
}
```

### Primary CTA Button
```css
.btn-primary {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 14px 28px;
  background: var(--brand-primary);
  color: #ffffff;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: background 0.15s ease;
}
.btn-primary:hover { background: var(--brand-hover); }
.btn-primary .arrow { font-size: 14px; }
```

### Ghost Button (Secondary CTA)
```css
.btn-ghost {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 14px 28px;
  background: #ffffff;
  color: #333333;
  border: 1.5px solid #e5e5e5;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.15s ease;
}
.btn-ghost:hover {
  border-color: var(--brand-primary);
  color: var(--brand-primary);
}
```

### Product Screenshot Card
```css
.screenshot-card {
  background: #ffffff;
  border: 1px solid #e5e5e5;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
}
.screenshot-card img {
  width: 100%;
  display: block;
}
```

### Sidebar Navigation (Docs)
```css
.sidebar-category {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 12px;
  font-size: 14px;
  font-weight: 600;
  color: var(--brand-primary);
}
.sidebar-category .emoji {
  font-size: 16px;
}
.sidebar-item {
  padding: 6px 12px 6px 36px;
  font-size: 14px;
  font-weight: 400;
  color: #666666;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.1s ease;
}
.sidebar-item:hover {
  background: rgba(46, 196, 182, 0.06);
  color: #333333;
}
.sidebar-item.active {
  background: rgba(46, 196, 182, 0.1);
  color: var(--brand-primary);
  font-weight: 500;
}
```

### Feature Section (Numbered)
```css
.feature-section {
  margin-bottom: 48px;
}
.feature-section h2 {
  font-size: 24px;
  font-weight: 700;
  color: #1a1a1a;
  margin-bottom: 16px;
}
.feature-section ul {
  list-style: disc;
  padding-left: 20px;
  margin-bottom: 12px;
}
.feature-section li {
  font-size: 15px;
  color: #333333;
  line-height: 1.7;
  margin-bottom: 6px;
}
.feature-section .guide-link {
  color: var(--brand-primary);
  font-size: 14px;
  font-weight: 500;
  text-decoration: none;
}
.feature-section .guide-link:hover {
  text-decoration: underline;
}
```

## 5. Layout Principles

### Landing Page
- **Container**: `max-width: 1140px; margin: 0 auto;`
- **Hero**: Centered heading + dual CTA buttons, generous vertical padding (120px+).
- **Product showcase**: 2-column grid of unframed screenshots, `gap: 24px`.
- **Feature sections**: Alternating white/light-gray backgrounds.
- **Section spacing**: 80–100px vertical padding.
- **Announcement bar**: Fixed at top, full-width, brand color background.

### Documentation Site
- **3-column layout**: Sidebar (260px) + Content (flexible) + TOC (200px).
- **Sidebar**: Fixed left, scrollable, emoji category icons, hierarchical menu.
- **Content area**: Max-width 720px, numbered sections, bullet lists, guide links.
- **TOC**: Fixed right, auto-generated from page headings.
- **Search bar**: Top of sidebar or content area, `⌘ K` keyboard shortcut.
- **Top bar**: Logo + search + nav links + brand CTA button.

## 6. Depth & Elevation

Minimal depth. Almost flat.

| Level | Surface | Effect |
|-------|---------|--------|
| 0 (Page) | `#ffffff` / `#f5f5f5` | Flat background |
| 1 (Card) | `#ffffff` | `border: 1px solid #e5e5e5` + `box-shadow: 0 2px 8px rgba(0,0,0,0.06)` |
| 2 (Nav) | `#ffffff` | `border-bottom: 1px solid #f0f0f0` |
| 3 (Modal) | `#ffffff` | `box-shadow: 0 8px 30px rgba(0,0,0,0.12)` |

Shadows are minimal and functional. The design relies on borders more than shadows for separation.

## 7. Do's and Don'ts

### Do
- Show the actual product UI in screenshots — real dashboards, real data.
- Use a single brand color consistently across landing + docs.
- Keep the announcement banner at top in brand color for news.
- Pair landing page with a branded documentation site.
- Use emoji icons in doc sidebar categories for visual scanning.
- Number feature sections sequentially (1, 2, 3...) in docs.
- Include guide links after each feature description.
- Keep border-radius moderate (8–12px) — professional, not playful.
- Use dual CTA: solid brand + ghost white.

### Don't
- Wrap screenshots in device mockups — show the raw product UI.
- Add decorative gradients, blobs, or textures — pure function.
- Use large hero imagery or lifestyle photos — product-first.
- Make body text too large — 15–16px is practical for B2B.
- Use pill-shaped buttons (100px radius) — 8px radius is professional.
- Add animation beyond subtle scroll reveals — seriousness over delight.
- Use multiple accent colors — one brand color does everything.
- Over-style the documentation — GitBook defaults with brand color are ideal.

## 8. Responsive Behavior

### Landing
- **Desktop (1140px+)**: 2-column screenshot grid, centered hero, full banner.
- **Tablet (768–1139px)**: Screenshots stack or stay 2-col with smaller images.
- **Mobile (< 768px)**: Single column, stacked CTAs, banner text may truncate.

### Documentation
- **Desktop (1024px+)**: 3-column (sidebar + content + TOC).
- **Tablet (768–1023px)**: Sidebar collapses to hamburger, TOC hidden.
- **Mobile (< 768px)**: Full-width content, hamburger nav, no TOC.

## 9. Agent Prompt Guide

> "Build a [component/page] using K-B2B SaaS style. Pure white background, single teal/mint brand color (#2ec4b6) for CTAs, links, and top banner. Show product UI directly in screenshots (no device mockups). Bold centered headings (40–48px, weight 700), practical body text (15–16px). 2-column screenshot grid. Dual CTAs: solid teal + ghost white. For documentation: 3-column GitBook layout with emoji sidebar categories and numbered feature sections. Clean, trustworthy, product-first."

**Best suited for:**
- B2B SaaS platforms (financial, HR, CRM, ERP)
- Accounting and bookkeeping tools
- Enterprise data management dashboards
- Korean-market business software
- Finops and treasury management
- Documentation sites paired with product marketing
- Tax, invoice, and compliance tools
