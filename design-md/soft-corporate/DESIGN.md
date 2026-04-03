# Design System: Soft Corporate

## 1. Visual Theme & Atmosphere

Soft Corporate is the antithesis of aggressive tech aesthetics. Where tactical dashboards scream urgency in neon-on-black, this style whispers trust on lavender-tinted light. It is the visual language of modern AI/SaaS companies, healthcare platforms, and B2B services that need to feel approachable, innovative, and premium without being intimidating.

The foundation is a tinted off-white background — not pure white (`#ffffff`), but a gentle lavender-gray (`#eeedf5` to `#f0eff7`) that feels softer on the eyes and more refined than stark white. Content floats on frost-glass cards with large border-radius (16–24px), subtle shadows, and generous internal padding. The atmosphere evokes a clean, airy workspace — like a high-end co-working space filled with natural light.

Typography is bold and confident for headings (40px+, weight 700–800) with ample line-height, creating a sense of spaciousness and breathing room. Body text is lightweight (weight 400) in a neutral gray. The Korean typographic tradition of large, bold headings with generous spacing works exceptionally well in this style.

Color accents are soft and dreamy — pastel gradients that blend lavender, pink, cyan, and mint. These appear as decorative blobs or aurora-like shapes in section corners, never dominating but adding warmth and visual interest. The overall feeling is: "We are serious about technology, but we are also human and approachable."

**Key Characteristics:**
- Tinted off-white background (`#eeedf5`–`#f0eff7`) — never pure white
- Frost-glass cards: white/semi-transparent with large radius (16–24px) and soft multi-layer shadows
- Bold display headings (40px+, weight 700–800) with generous spacing
- Pastel gradient decorative blobs (lavender→pink→cyan aurora shapes)
- Thin-line geometric icons (unfilled, monoline style)
- Minimal color palette: dark text + lavender accent + pastel decorations
- Section badge/tag labels (small rounded chips above headings)
- Very generous whitespace — 80–120px between sections
- Dual CTA styles: ghost button (light) and solid black button (dark)
- Low information density — one idea per section, let it breathe

## 2. Color Palette & Roles

### Primary
- **Lavender Background** (`#eeedf5`): Page background. The signature tinted off-white.
- **Card White** (`#ffffff`): Card surfaces, elevated content areas.
- **Card Frost** (`rgba(255,255,255,0.8)`): Semi-transparent cards with backdrop blur.

### Text
- **Heading Dark** (`#1a1a2e`): Primary headings. Very dark indigo-black — warm, not harsh.
- **Body Text** (`#4a4a5a`): Body paragraphs, descriptions. Medium gray with warm undertone.
- **Muted Text** (`#8b8b9e`): Captions, metadata, secondary labels. Soft slate.
- **Pure Black** (`#000000`): Dark CTA button backgrounds only.

### Accent (Pastel Spectrum)
- **Lavender** (`#c4b5fd`): Primary accent — tags, badges, subtle highlights.
- **Lavender Deep** (`#8b5cf6`): Active states, link hover, stronger emphasis.
- **Pink Soft** (`#f9a8d4`): Gradient element — blends with lavender.
- **Cyan Soft** (`#67e8f9`): Gradient element — cool complement.
- **Mint** (`#6ee7b7`): Gradient element — fresh accent.
- **Warm Gradient**: `linear-gradient(135deg, #c4b5fd 0%, #f9a8d4 50%, #67e8f9 100%)` — the signature aurora decoration.

### Semantic
- **Success** (`#22c55e`): Confirmation, active status.
- **Warning** (`#f59e0b`): Caution states.
- **Error** (`#ef4444`): Error states, destructive actions.
- **Info** (`#3b82f6`): Informational badges, links.

### Borders & Shadows
- **Border Light** (`rgba(0,0,0,0.06)`): Card borders, dividers — barely visible.
- **Border Lavender** (`rgba(139,92,246,0.2)`): Active/focused element borders.
- **Shadow Soft**: `0 4px 6px -1px rgba(0,0,0,0.05), 0 10px 15px -3px rgba(0,0,0,0.05)` — multi-layer, very subtle.
- **Shadow Card**: `0 8px 30px rgba(0,0,0,0.06)` — card elevation on tinted background.

## 3. Typography Rules

### Font Stack
- **Display/Heading**: `'Pretendard', 'SUIT', 'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif` — for Korean-first projects
- **International**: `'Plus Jakarta Sans', 'General Sans', 'Outfit', 'Inter', sans-serif` — clean geometric sans
- **Monospace** (code/data): `'JetBrains Mono', 'Fira Code', monospace`

### Scale & Weight

| Element | Size | Weight | Line Height | Notes |
|---------|------|--------|-------------|-------|
| Hero Heading | 48–56px | 800 | 1.15 | Maximum impact, 2-3 lines max |
| Section Heading | 36–44px | 700 | 1.2 | One clear statement per section |
| Card Title | 18–22px | 600–700 | 1.3 | Bold enough to anchor the card |
| Body | 15–17px | 400 | 1.7 | Generous line-height for readability |
| Caption | 13–14px | 400 | 1.5 | Muted color, supporting text |
| Badge/Tag | 12–13px | 500 | 1.0 | Inside rounded chip, may be uppercase |
| Button | 14–16px | 500–600 | 1.0 | Centered in pill or rounded rect |

### Rules
- Headings can be extremely bold (700–800) because the soft background counterbalances the weight.
- Body text is never bold — keep it light (400) for contrast with headings.
- Letter-spacing: headings at -0.02em (tight), body at 0 (natural).
- Korean text benefits from slightly more line-height (1.7–1.8) than Latin (1.5–1.6).
- Never use all-caps for headings in this style — sentence case or title case only.

## 4. Component Stylings

### Section Badge (Tag Label)
```css
.section-badge {
  display: inline-flex;
  align-items: center;
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
```css
.card {
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.6);
  border-radius: 20px;
  padding: 32px;
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.06);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.card:hover {
  transform: translateY(-4px);
  box-shadow: 0 16px 40px rgba(0, 0, 0, 0.08);
}
```

### Feature Card (Icon + Title + Description)
```css
.feature-card {
  background: #ffffff;
  border: 1px solid rgba(0, 0, 0, 0.06);
  border-radius: 16px;
  padding: 28px 24px;
}
.feature-card .icon {
  width: 48px;
  height: 48px;
  margin-bottom: 16px;
  /* Thin-line, monoline SVG icon */
  stroke-width: 1.5;
  stroke: #1a1a2e;
  fill: none;
}
.feature-card .title {
  font-size: 18px;
  font-weight: 700;
  color: #1a1a2e;
  margin-bottom: 8px;
}
.feature-card .description {
  font-size: 15px;
  font-weight: 400;
  color: #8b8b9e;
  line-height: 1.6;
}
```

### Ghost Button (Light CTA)
```css
.btn-ghost {
  display: inline-flex;
  align-items: center;
  padding: 12px 28px;
  border: 1.5px solid rgba(0, 0, 0, 0.15);
  border-radius: 100px;
  background: transparent;
  color: #1a1a2e;
  font-size: 15px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}
.btn-ghost:hover {
  border-color: #8b5cf6;
  color: #8b5cf6;
  background: rgba(139, 92, 246, 0.05);
}
```

### Solid Button (Dark CTA)
```css
.btn-solid {
  display: inline-flex;
  align-items: center;
  padding: 14px 32px;
  border: none;
  border-radius: 100px;
  background: #000000;
  color: #ffffff;
  font-size: 15px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}
.btn-solid:hover {
  background: #1a1a2e;
  transform: translateY(-1px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}
```

### Aurora Decoration Blob
```css
.aurora-blob {
  position: absolute;
  width: 300px;
  height: 300px;
  border-radius: 50%;
  background: linear-gradient(135deg, #c4b5fd 0%, #f9a8d4 50%, #67e8f9 100%);
  filter: blur(80px);
  opacity: 0.4;
  pointer-events: none;
  z-index: 0;
}
```

## 5. Layout Principles

- **Centered content container**: `max-width: 1140px; margin: 0 auto; padding: 0 24px;`
- **Section rhythm**: 80–120px vertical padding between major sections.
- **Two-column hero**: Left-aligned text (60%) + right illustration/graphic (40%).
- **Feature grid**: 3 columns for feature cards, 2 columns for product showcases.
- **Card stacking on right**: Feature list pattern — heading/description left, vertical card stack right.
- **Full-width tinted sections**: Alternate between pure background and slightly darker tinted panels (`#e8e7f0`).
- **Content width constraint**: Prose blocks max 600px for readability, even within wider containers.
- **Floating navigation**: Fixed top nav with frosted glass effect, rounded corners, subtle shadow.

## 6. Depth & Elevation

- **Level 0**: Page background (`#eeedf5`) — the ambient canvas.
- **Level 1**: Tinted section panels (`#e8e7f0` or `rgba(255,255,255,0.5)`) — subtle distinction.
- **Level 2**: Cards (`#ffffff` or `rgba(255,255,255,0.8)`) — primary content containers.
- **Level 3**: Navigation bar (frosted glass + shadow) — fixed, always above content.
- **Level 4**: Modals, dropdowns (`#ffffff` + stronger shadow `0 20px 60px rgba(0,0,0,0.1)`) — highest.

Shadows are always multi-layer, warm-toned, and subtle. Never harsh, never dark:
```css
/* Preferred shadow pattern */
box-shadow:
  0 4px 6px -1px rgba(0, 0, 0, 0.04),
  0 10px 15px -3px rgba(0, 0, 0, 0.06);
```

## 7. Do's and Don'ts

### Do
- Use a tinted off-white background — never pure white for the page canvas.
- Make headings bold and large — they are the primary visual anchors.
- Add pastel gradient blobs as atmospheric decoration in section corners.
- Use generous whitespace between sections (80px+). Let content breathe.
- Round card corners significantly (16–24px) — softness is the brand.
- Use section badge/tag labels above headings to provide context.
- Keep icons thin-line, monoline, geometric — unfilled SVG style.
- Apply frosted glass (`backdrop-filter: blur`) on navigation and overlay cards.
- Use pill-shaped buttons (`border-radius: 100px`) for CTAs.

### Don't
- Use sharp corners or squared-off elements — everything should feel rounded and soft.
- Make the page busy or dense — this style thrives on breathing room.
- Use saturated or dark colors for large areas — keep everything light and airy.
- Add neon, glowing, or high-contrast effects — this is soft, not electric.
- Use heavy drop shadows — all shadows should be barely perceptible.
- Place too many items per row — 3 columns maximum for cards.
- Use uppercase headings — sentence case is more approachable.
- Mix too many accent colors simultaneously — 1-2 pastel accents per section.
- Use monospace fonts for body text — save monospace for code/data only.

## 8. Responsive Behavior

- **Desktop (1280px+)**: 3-column feature grid, two-column hero, full aurora decorations.
- **Tablet (768–1279px)**: 2-column grid, hero stacks vertically, aurora blobs scale down.
- **Mobile (< 768px)**: Single column, cards stack, navigation becomes hamburger menu.
- Card padding reduces from 32px to 20px on mobile, but border-radius stays the same.
- Hero headings scale from 48–56px desktop to 32–36px mobile (use `clamp()`).
- Section spacing reduces from 100px to 60px on mobile.
- Aurora decoration blobs may be hidden on mobile for performance (`display: none` below 768px).

## 9. Agent Prompt Guide

When applying this design system, use the following prompt structure:

> "Build a [component/page] using the Soft Corporate aesthetic. Lavender-tinted background (#eeedf5), frosted glass cards (white, backdrop-blur, border-radius: 20px, subtle shadow), bold display headings (weight 700–800, 48px+), pastel aurora gradient decorations. Section badges above headings. Ghost pill buttons for secondary CTAs, solid black pill buttons for primary. Thin-line monoline icons. Generous whitespace (80–120px between sections). Approachable, premium, trustworthy."

**Best suited for:**
- AI/SaaS company landing pages
- Healthcare/wellness platforms
- B2B enterprise product marketing
- Corporate portfolio sites
- Fintech onboarding flows
- Educational technology platforms
- Consulting firm websites
- Product launch pages
