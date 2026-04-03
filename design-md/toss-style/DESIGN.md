# Design System: Toss Style

## 1. Visual Theme & Atmosphere

Toss Style is the gold standard of Korean fintech design — a system that achieves maximum impact through radical simplicity. The entire visual language is built on three pillars: pure white space, a single blue accent, and confident typography. There are no gradients, no textures, no decorative elements. Every pixel earns its place through function.

The foundation is pure white (`#ffffff`) — not tinted, not warm, not cool. Just white. Content sections alternate between this pure white and an almost-imperceptible light gray (`#f9fafb`), creating subtle rhythm without visual noise. Against this pristine canvas, a single blue (`#3182f6`) does all the heavy lifting: links, buttons, badges, section labels, active states. One color. Maximum recognition.

Typography is the real hero. Headings are enormous (50–60px), bold (700), and set in a custom geometric sans-serif optimized for Korean text. The combination of `word-break: keep-all` and `white-space: pre-wrap` ensures Korean line breaks never split words awkwardly. The result feels like reading a beautifully typeset magazine, not a website.

The most distinctive feature is the whitespace. Sections are separated by 200–250px of vertical space — a luxury that communicates confidence and premium positioning. This isn't empty space; it's intentional breathing room that lets each message land with full impact before the next one begins.

**Key Characteristics:**
- Pure white background (`#ffffff`) — no tints, no warmth, no cool shift
- Single accent color: Toss Blue (`#3182f6`) — one color does everything
- Enormous bold headings (50–60px, weight 700) with Korean text optimization
- Extreme vertical whitespace (200–250px between sections)
- Alternating white/light-gray (`#f9fafb`) section backgrounds
- 7-step neutral gray scale from `#191f28` to `#f9fafb`
- Device mockups (iPhone clay frames) for product demonstrations
- Scroll-triggered reveal animations (fade + translate)
- Small blue section labels above large headings ("홈 · 소비")
- Dark footer section (`#000000`) as dramatic contrast ending
- No gradients, no textures, no decorative elements — function only

## 2. Color Palette & Roles

### Primary
- **Pure White** (`#ffffff`): Page background, card surfaces. The dominant canvas.
- **Toss Blue** (`#3182f6`): THE accent color. CTAs, links, section labels, badges, active states. One color rules everything.

### Neutral Scale (7 steps)
- **Ink** (`#191f28`): Primary headlines, darkest text. Almost-black with warm undertone.
- **Dark Gray** (`#333d4b`): Secondary headings, strong body text.
- **Gray 600** (`#6b7684`): Body text, descriptions.
- **Gray 400** (`#b0b8c1`): Placeholder text, disabled states.
- **Gray 300** (`#d1d6db`): Borders, dividers.
- **Gray 200** (`#e5e8eb`): Hairline borders, section separators.
- **Gray 100** (`#f2f4f6`): Subtle backgrounds, input fields.
- **Gray 50** (`#f9fafb`): Alternating section background. Barely distinguishable from white.

### Semantic
- **Red** (`#f04452`): Error, danger, negative values.
- **Green** (`#03b26c`): Success, positive values, growth.
- **Orange** (`#fe9800`): Warning, caution, pending.
- **Teal** (`#18a5a5`): Informational, secondary accent.

### Backgrounds
- **Section Light** (`#f9fafb`): Alternating section tint.
- **Section Dark** (`#000000`): Footer/premium section — dramatic contrast.

## 3. Typography Rules

### Font Stack
- **Primary**: `'Toss Product Sans', -apple-system, BlinkMacSystemFont, 'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif`
- **Fallback International**: `'Pretendard', 'Inter', 'SF Pro Display', sans-serif`

### Korean Text Optimization
```css
body {
  word-break: keep-all;    /* Never split Korean words */
  white-space: pre-wrap;   /* Preserve intentional line breaks */
  letter-spacing: -0.02em; /* Slightly tighter for Korean */
}
```

### Scale & Weight

| Element | Size | Weight | Line Height | Notes |
|---------|------|--------|-------------|-------|
| Hero Heading | 50–60px | 700 | 1.2 | Maximum statement, 1-2 lines |
| Section Heading | 36–48px | 700 | 1.3 | One idea, one heading |
| Subheading | 28–32px | 600 | 1.4 | Supporting statement |
| Body Large | 20–23px | 400–600 | 1.6 | Feature descriptions |
| Body | 17–18px | 400 | 1.6 | General content |
| Small | 14–15px | 400 | 1.5 | Captions, metadata |
| Section Label | 15–17px | 600 | 1.0 | Blue text above heading |

### Rules
- Headlines are LARGE and BOLD — they do most of the visual work.
- Body text is generously sized (17–23px) — never small, never cramped.
- Weight contrast is the primary hierarchy tool: 700 vs 400, not size.
- Korean text gets -0.02em letter-spacing (tighter than Latin default).
- `word-break: keep-all` is mandatory for Korean — never let words break mid-syllable.
- No decorative fonts, no serif, no handwriting — geometric sans only.

## 4. Component Stylings

### Section Label
Small colored text above the main heading. Provides category/context.
```css
.section-label {
  font-size: 16px;
  font-weight: 600;
  color: #3182f6;
  margin-bottom: 12px;
  letter-spacing: -0.01em;
}
```

### Feature Card
```css
.feature-card {
  max-width: 300px;
  background: #ffffff;
  border-radius: 24px;
  padding: 32px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04),
              0 8px 24px rgba(0, 0, 0, 0.06);
}
.feature-card .icon {
  width: 80px;
  height: 80px;
  margin-bottom: 20px;
}
.feature-card .title {
  font-size: 22px;
  font-weight: 700;
  color: #191f28;
  margin-bottom: 8px;
}
.feature-card .description {
  font-size: 17px;
  font-weight: 400;
  color: #6b7684;
  line-height: 1.6;
}
```

### Primary Button
```css
.btn-primary {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 16px 32px;
  background: #3182f6;
  color: #ffffff;
  border: none;
  border-radius: 12px;
  font-size: 17px;
  font-weight: 600;
  cursor: pointer;
  transition: background 0.15s ease;
}
.btn-primary:hover {
  background: #2272eb;
}
.btn-primary:active {
  background: #1b64da;
}
```

### Badge System
```css
.badge {
  display: inline-flex;
  align-items: center;
  padding: 4px 10px;
  border-radius: 8px;
  font-size: 13px;
  font-weight: 600;
}
.badge-blue { background: rgba(49,130,246,0.1); color: #3182f6; }
.badge-green { background: rgba(3,178,108,0.1); color: #03b26c; }
.badge-red { background: rgba(240,68,82,0.1); color: #f04452; }
.badge-teal { background: rgba(24,165,165,0.1); color: #18a5a5; }
.badge-orange { background: rgba(254,152,0,0.1); color: #fe9800; }
```

### Section Divider
```css
.section-divider {
  border: none;
  border-top: 1px solid #e5e8eb;
  margin: 0;
}
```

### Device Mockup Frame
```css
.device-frame {
  position: relative;
  border-radius: 40px;
  overflow: hidden;
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08),
              0 30px 60px rgba(0, 0, 0, 0.05);
}
.device-frame img {
  width: 100%;
  display: block;
}
```

## 5. Layout Principles

- **Container**: `max-width: 1040px; margin: 0 auto; padding: 0 24px;`
- **Section spacing**: 200–250px vertical padding on desktop. This is the signature.
- **Hero pattern**: Full-height or near-full-height with gradient overlay on image/video background.
- **Two-column feature**: Text left (50%) + device mockup right (50%), alternating sides.
- **Card grid**: 3 columns max with generous gap (24–32px).
- **Alternating backgrounds**: `#ffffff` → `#f9fafb` → `#ffffff` → `#f9fafb` → `#000000` (footer).
- **Content alignment**: Left-aligned text is default. Centered for hero and CTA sections.
- **Progressive disclosure**: Scroll-triggered reveals — content appears as user scrolls.

## 6. Depth & Elevation

- **Level 0**: Page background (`#ffffff` or `#f9fafb`) — the canvas.
- **Level 1**: Cards (`#ffffff` + subtle dual-layer shadow) — floating content.
- **Level 2**: Sticky navigation (`#ffffff` + hairline border bottom `#e5e8eb`) — above cards.
- **Level 3**: Modals, bottom sheets (`#ffffff` + heavier shadow) — overlay.

Shadow philosophy — always dual-layer, always subtle:
```css
/* Standard card */
box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04),
            0 8px 24px rgba(0, 0, 0, 0.06);

/* Elevated (modal, dropdown) */
box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06),
            0 16px 40px rgba(0, 0, 0, 0.08);
```

No colored shadows. No glow effects. Shadows are neutral and barely visible.

## 7. Do's and Don'ts

### Do
- Use pure white (`#ffffff`) as the primary background — no tints.
- Commit to a single accent color (`#3182f6`) — one color, maximum recognition.
- Make headings enormous and bold — they are the primary communication tool.
- Use extreme whitespace between sections (200px+) — let each message land.
- Alternate section backgrounds subtly (`#fff` ↔ `#f9fafb`).
- Add small blue section labels above large headings for context.
- Use device mockups for product demonstrations.
- Animate on scroll — progressive disclosure, fade + translate up.
- Use the 7-step gray scale consistently — never invent ad-hoc grays.
- End with a dramatic dark footer (`#000`) for contrast.

### Don't
- Add gradients, textures, patterns, or decorative blobs — purity is the point.
- Use multiple accent colors — one blue handles everything.
- Make sections dense or cramped — this style needs 200px+ breathing room.
- Use small text — even body text is 17–18px. Generosity extends to typography.
- Round buttons into pills — use moderate radius (12px), not 100px pills.
- Add heavy shadows or glow effects — all shadows barely visible.
- Use colored backgrounds for sections — only white and near-white gray.
- Break Korean words mid-syllable — always `word-break: keep-all`.
- Add decorative icons or illustrations — show real product screenshots instead.
- Mix fonts — one geometric sans-serif for everything.

## 8. Responsive Behavior

- **Desktop (1040px+)**: Two-column layouts, 250px section spacing, full device mockups.
- **Tablet (640–1039px)**: Narrower container, 150px section spacing, mockups scale down.
- **Mobile (< 640px)**: Single column, stacked layouts, 100px section spacing, full-width cards.
- Hero headings: 56px desktop → 36px mobile (use `clamp()`).
- Body text stays at 17px even on mobile — readability is non-negotiable.
- Device mockups center-align and scale to container width on mobile.
- `flex-wrap-reverse` alternates text/image order on stacked mobile layouts.
- The dark footer section remains full-width at all breakpoints.

## 9. Agent Prompt Guide

When applying this design system, use the following prompt structure:

> "Build a [component/page] using Toss Style. Pure white background (#ffffff), single accent color Toss Blue (#3182f6), bold Korean-optimized headings (50–60px, weight 700, word-break: keep-all), 7-step neutral gray scale (#191f28 to #f9fafb). Extreme whitespace between sections (200–250px). Alternating white/light-gray sections. Device mockups for product shots. Scroll-triggered fade-in animations. No gradients, no textures, no decorations. Clean, confident, premium fintech."

**Best suited for:**
- Fintech and banking applications
- Payment and financial service platforms
- Korean-market SaaS products
- Mobile-first product landing pages
- Premium service marketing sites
- B2C consumer app showcases
- Neobank and digital wallet platforms
- Insurance and investment service sites
