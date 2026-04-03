# Design System: Tactical Dashboard

## 1. Visual Theme & Atmosphere

The Tactical Dashboard aesthetic draws from military command centers, OSINT monitoring stations, and intelligence agency interfaces. The design language communicates urgency, precision, and real-time awareness. Think of a NATO operations room reimagined for the web — dark environments where data glows against void-black backgrounds, where every pixel of color carries meaning, and where information density is a feature, not a problem.

The foundation is pure black (`#000000` or `#0a0a0f`) — not dark gray, not navy, but true darkness. Against this void, data elements emerge in electric blues (`#3b82f6`), tactical greens (`#22c55e`), warning ambers (`#f59e0b`), and alert reds (`#ef4444`). The overall effect is a screen that feels alive with real-time intelligence, where the interface itself seems to be monitoring something important.

Typography is monospaced or semi-monospaced — fonts like JetBrains Mono, IBM Plex Mono, or Space Mono. All-caps headers with wide letter-spacing (+0.1em to +0.15em) evoke military stencil lettering. Numbers are always tabular. Data feels like it's being transmitted, not displayed.

**Key Characteristics:**
- Pure black (`#000000`/`#0a0a0f`) background — no dark gray compromise
- Monospace/technical typography with wide letter-spacing on headers
- Neon-on-dark color system: electric blue, tactical green, warning amber, alert red
- Semi-transparent card surfaces with subtle border glow (`border: 1px solid rgba(59,130,246,0.2)`)
- Real-time data indicators: pulsing dots, live badges, scrolling tickers
- Information density as a design goal — not minimal, but organized density
- Status badge system with color-coded threat/activity levels
- Bar charts and data visualizations in brand neon colors against dark backgrounds

## 2. Color Palette & Roles

### Primary
- **Void Black** (`#000000`): Page background. Pure black for maximum contrast with data elements.
- **Surface Dark** (`#0a0a0f`): Card backgrounds, elevated surfaces. Nearly black with a hint of blue.
- **Surface Elevated** (`#111118`): Secondary cards, nested containers. Subtle distinction from background.

### Data Colors (Neon Spectrum)
- **Electric Blue** (`#3b82f6`): Primary data color. Charts, active indicators, links, primary actions. The dominant information color.
- **Cyan** (`#06b6d4`): Secondary data, info badges, OSINT feed indicators. Cooler complement to blue.
- **Tactical Green** (`#22c55e`): Positive status — NOMINAL, ACTIVE, ONLINE, SUCCESS.
- **Warning Amber** (`#f59e0b`): Caution states — ELEVATED, UNUSUAL, WATCH.
- **Alert Red** (`#ef4444`): Critical states — CRITICAL, ALERT, BREAKING, ERROR.
- **Signal Pink** (`#ec4899`): Anomaly indicators, highlighted data points, current-time markers in charts.

### Text
- **Primary Text** (`#e2e8f0`): Main body text. Light gray, not pure white (reduces eye strain on dark backgrounds).
- **Secondary Text** (`#94a3b8`): Labels, descriptions, metadata. Muted slate.
- **Muted Text** (`#64748b`): Timestamps, tertiary info. Low-contrast by design.
- **Highlight Text** (`#ffffff`): Emphasized values, active states, critical data. Pure white for maximum attention.

### Interactive
- **Button Primary** (`#3b82f6`): Primary action background.
- **Button Hover** (`#2563eb`): Darkened blue for hover.
- **Button Active** (`#1d4ed8`): Further darkened for press state.
- **Focus Ring** (`rgba(59,130,246,0.5)`): Blue glow for keyboard focus.
- **Selected State** (`rgba(59,130,246,0.15)`): Subtle blue wash for selected items.

### Borders & Dividers
- **Border Default** (`rgba(255,255,255,0.08)`): Barely visible dividers.
- **Border Active** (`rgba(59,130,246,0.3)`): Blue-tinted border for active cards.
- **Border Alert** (`rgba(239,68,68,0.4)`): Red-tinted border for critical elements.
- **Glow Effect** (`0 0 20px rgba(59,130,246,0.15)`): Subtle blue glow on key elements.

## 3. Typography Rules

### Font Stack
- **Primary**: `'JetBrains Mono', 'IBM Plex Mono', 'Space Mono', 'Fira Code', monospace`
- **Display Alternative**: `'Space Grotesk', 'Inter', sans-serif` (for marketing sections only — dashboards stay monospace)

### Scale & Weight
- **Page Title**: 28–32px, weight 700, all-caps, letter-spacing +0.1em
- **Section Header**: 18–20px, weight 600, all-caps, letter-spacing +0.08em
- **Card Title**: 14–16px, weight 600, all-caps, letter-spacing +0.05em
- **Body**: 13–14px, weight 400, normal case
- **Label**: 11–12px, weight 500, all-caps, letter-spacing +0.06em
- **Data Value**: 16–24px, weight 700, tabular-nums, normal case
- **Micro**: 10–11px, weight 400, muted color, timestamps and metadata

### Rules
- All headers and labels are ALL-CAPS with positive letter-spacing.
- Numbers always use `font-variant-numeric: tabular-nums`.
- Line height: Body 1.5, headings 1.2, data values 1.0.
- Monospace creates the "data transmission" feel — never switch to serif for any element.

## 4. Component Stylings

### Status Badge
```css
.badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 4px 10px;
  border-radius: 4px;
  font-size: 11px;
  font-weight: 600;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  font-family: 'JetBrains Mono', monospace;
}
.badge-nominal { background: rgba(34,197,94,0.15); color: #22c55e; border: 1px solid rgba(34,197,94,0.3); }
.badge-elevated { background: rgba(245,158,11,0.15); color: #f59e0b; border: 1px solid rgba(245,158,11,0.3); }
.badge-critical { background: rgba(239,68,68,0.15); color: #ef4444; border: 1px solid rgba(239,68,68,0.3); }
.badge-quiet { background: rgba(148,163,184,0.1); color: #94a3b8; border: 1px solid rgba(148,163,184,0.2); }
.badge-live { background: rgba(239,68,68,0.9); color: #ffffff; animation: pulse 2s infinite; }
```

### Data Card
```css
.card {
  background: #0a0a0f;
  border: 1px solid rgba(255,255,255,0.08);
  border-radius: 8px;
  padding: 20px;
  transition: border-color 0.2s ease;
}
.card:hover {
  border-color: rgba(59,130,246,0.3);
  box-shadow: 0 0 20px rgba(59,130,246,0.05);
}
.card-header {
  font-size: 14px;
  font-weight: 600;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  color: #e2e8f0;
  margin-bottom: 16px;
}
```

### Live Indicator
```css
.live-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #22c55e;
  animation: pulse 2s ease-in-out infinite;
}
@keyframes pulse {
  0%, 100% { opacity: 1; box-shadow: 0 0 0 0 rgba(34,197,94,0.4); }
  50% { opacity: 0.8; box-shadow: 0 0 0 6px rgba(34,197,94,0); }
}
```

### News Ticker
```css
.ticker {
  background: rgba(239,68,68,0.1);
  border-top: 1px solid rgba(239,68,68,0.2);
  border-bottom: 1px solid rgba(239,68,68,0.2);
  padding: 8px 0;
  overflow: hidden;
  white-space: nowrap;
}
.ticker-content {
  display: inline-block;
  animation: scroll-left 30s linear infinite;
}
@keyframes scroll-left {
  0% { transform: translateX(100%); }
  100% { transform: translateX(-100%); }
}
.ticker-tag {
  background: #ef4444;
  color: white;
  padding: 2px 8px;
  border-radius: 2px;
  font-size: 10px;
  font-weight: 700;
  letter-spacing: 0.08em;
}
```

### Day Selector / Toggle Buttons
```css
.day-btn {
  padding: 6px 12px;
  border: 1px solid rgba(255,255,255,0.12);
  border-radius: 6px;
  background: transparent;
  color: #94a3b8;
  font-family: 'JetBrains Mono', monospace;
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.05em;
  text-transform: uppercase;
  cursor: pointer;
  transition: all 0.15s ease;
}
.day-btn:hover { border-color: rgba(59,130,246,0.4); color: #e2e8f0; }
.day-btn.active { background: #3b82f6; border-color: #3b82f6; color: #ffffff; }
```

## 5. Layout Principles

- **Full-viewport dark canvas**: `min-height: 100vh; background: #000000;`
- **Dense 3-column grid** for data cards: `grid-template-columns: repeat(3, 1fr); gap: 16px;`
- **Top status bar**: Full-width, 40px height, contains live indicators, timestamps, market status.
- **Information hierarchy**: Alert level banner → OSINT feed → data card grid → detail panels.
- **Generous internal padding** within cards (20–24px), tight gaps between cards (12–16px).
- **Fixed ticker bar** at top or between sections for breaking news/alerts.
- **Sidebar optional**: If used, narrow (240px) with icon-only collapsed state.

## 6. Depth & Elevation

- **Level 0**: Page background (`#000000`) — the void.
- **Level 1**: Cards and containers (`#0a0a0f` + border `rgba(255,255,255,0.08)`) — floating on darkness.
- **Level 2**: Modals, dropdowns (`#111118` + border `rgba(255,255,255,0.12)`) — above cards.
- **Level 3**: Tooltips, popovers (`#1a1a24` + stronger border) — highest elevation.
- **No traditional shadows**: Instead of drop shadows, use border glow effects (`box-shadow: 0 0 Npx rgba(color, alpha)`).
- **Glow on interaction**: Hover/focus adds subtle colored glow matching the element's semantic color.

## 7. Do's and Don'ts

### Do
- Use monospace for ALL data display — numbers, labels, headers, values.
- Make status colors immediately scannable — green/amber/red must be distinguishable at a glance.
- Include "LIVE" pulsing indicators for real-time data feeds.
- Use all-caps with wide letter-spacing for headers and labels.
- Keep backgrounds pure dark — the darkness is the design.
- Design for information density — skilled users want more data visible, not less.
- Add subtle border glow on hover instead of color changes.
- Use scrolling tickers for alerts and breaking updates.

### Don't
- Use light backgrounds or light mode — this aesthetic only works in darkness.
- Round corners excessively — max `border-radius: 8px`. No pills, no circles except for indicators.
- Use decorative illustrations or playful icons — this is a serious, data-first interface.
- Add gratuitous animation — motion is reserved for "live" indicators and state changes.
- Mix serif or decorative fonts — monospace and geometric sans only.
- Use large hero sections or marketing-style layouts — every pixel earns its place with data.
- Soften the palette — neon on black is the point. Don't mute it into pastel territory.

## 8. Responsive Behavior

- **Desktop (1280px+)**: 3-column data grid, full ticker, sidebar visible.
- **Tablet (768–1279px)**: 2-column grid, ticker wraps, sidebar collapses to icons.
- **Mobile (< 768px)**: Single column, cards stack vertically, ticker scrolls horizontally, top bar simplified.
- Data cards maintain internal layout at all sizes — card padding may reduce but content structure stays.
- Charts resize fluidly — bar charts switch to horizontal on narrow screens.
- Status badges stay fixed-size — they are critical for scanning and must not shrink.

## 9. Agent Prompt Guide

When applying this design system, use the following prompt structure:

> "Build a [component/page] using the Tactical Dashboard aesthetic. Pure black background (#000000), monospace typography (JetBrains Mono), neon data colors (blue #3b82f6, green #22c55e, amber #f59e0b, red #ef4444) on dark surfaces (#0a0a0f). Include status badges, live indicators with pulse animation, and dense data card layouts. All headers uppercase with +0.05em letter-spacing. Use border glow instead of traditional shadows. Information density is a feature — show more data, not less."

**Best suited for:**
- Real-time monitoring dashboards
- Data analytics platforms
- OSINT/intelligence tools
- DevOps/infrastructure monitoring
- Financial trading terminals
- Security operations centers (SOC)
- IoT sensor dashboards
- Crypto/blockchain explorers
