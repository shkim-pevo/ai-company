---
name: tactical-dashboard
description: Build dark-mode real-time monitoring dashboards with military/intelligence command center aesthetics. Use when building OSINT tools, DevOps dashboards, trading terminals, analytics platforms, security operations centers, or any data-dense interface that needs a "tactical ops" feel. Neon-on-black, monospace typography, status badges, live indicators, scrolling tickers.
---

# Tactical Dashboard Design

Build interfaces that look like they belong in a NATO command center or intelligence operations room. This style prioritizes **information density**, **real-time awareness**, and **instant status recognition** through a neon-on-black color system.

## When to Use

- Real-time monitoring dashboards (infrastructure, security, IoT)
- OSINT / intelligence analysis tools
- DevOps observability platforms
- Financial trading terminals
- Crypto/blockchain explorers
- Data analytics with live feeds
- Any interface where "serious, data-first, always-on" is the mood

## The Aesthetic

**Pure black void + neon data.** The background is darkness (`#000`). Data glows against it. Every pixel of color carries meaning. There is no light mode — darkness IS the design.

## Foundation

### Colors
```css
:root {
  /* Backgrounds */
  --bg-void: #000000;
  --bg-surface: #0a0a0f;
  --bg-elevated: #111118;
  --bg-highest: #1a1a24;

  /* Data (Neon Spectrum) */
  --data-blue: #3b82f6;
  --data-cyan: #06b6d4;
  --data-green: #22c55e;
  --data-amber: #f59e0b;
  --data-red: #ef4444;
  --data-pink: #ec4899;

  /* Text */
  --text-primary: #e2e8f0;
  --text-secondary: #94a3b8;
  --text-muted: #64748b;
  --text-highlight: #ffffff;

  /* Borders */
  --border-default: rgba(255,255,255,0.08);
  --border-active: rgba(59,130,246,0.3);
  --border-alert: rgba(239,68,68,0.4);
}
```

### Typography
```css
:root {
  --font-mono: 'JetBrains Mono', 'IBM Plex Mono', 'Space Mono', 'Fira Code', monospace;
}
```

Rules:
- **ALL headers/labels**: uppercase + `letter-spacing: 0.05em–0.15em`
- **ALL numbers**: `font-variant-numeric: tabular-nums`
- **ALL text**: monospace font family
- **No serif, no decorative fonts, ever**

| Element | Size | Weight | Transform |
|---------|------|--------|-----------|
| Page Title | 28–32px | 700 | uppercase, +0.1em |
| Section Header | 18–20px | 600 | uppercase, +0.08em |
| Card Title | 14–16px | 600 | uppercase, +0.05em |
| Body | 13–14px | 400 | normal |
| Label | 11–12px | 500 | uppercase, +0.06em |
| Data Value | 16–24px | 700 | tabular-nums |
| Micro | 10–11px | 400 | muted color |

## Core Components

### Status Badges
Color-coded threat/activity levels. Instantly scannable.

| Level | Color | Background | Example |
|-------|-------|------------|---------|
| NOMINAL | Green `#22c55e` | `rgba(34,197,94,0.15)` | Systems normal |
| ELEVATED | Amber `#f59e0b` | `rgba(245,158,11,0.15)` | Unusual activity |
| CRITICAL | Red `#ef4444` | `rgba(239,68,68,0.15)` | Immediate attention |
| QUIET | Slate `#94a3b8` | `rgba(148,163,184,0.1)` | No activity |
| LIVE | White on Red `#ef4444` | Solid red, pulsing | Real-time feed |

### Data Cards
```css
.card {
  background: var(--bg-surface);
  border: 1px solid var(--border-default);
  border-radius: 8px;
  padding: 20px;
}
.card:hover {
  border-color: var(--border-active);
  box-shadow: 0 0 20px rgba(59,130,246,0.05);
}
```

### Live Indicator (Pulsing Dot)
```css
.live-dot {
  width: 8px; height: 8px;
  border-radius: 50%;
  background: var(--data-green);
  animation: pulse 2s ease-in-out infinite;
}
@keyframes pulse {
  0%, 100% { opacity: 1; box-shadow: 0 0 0 0 rgba(34,197,94,0.4); }
  50% { opacity: 0.8; box-shadow: 0 0 0 6px rgba(34,197,94,0); }
}
```

### Breaking News Ticker
Horizontal scrolling alert bar for critical updates.
```css
.ticker {
  background: rgba(239,68,68,0.1);
  border-top: 1px solid rgba(239,68,68,0.2);
  border-bottom: 1px solid rgba(239,68,68,0.2);
  padding: 8px 0;
  overflow: hidden;
}
.ticker-content {
  display: inline-block;
  white-space: nowrap;
  animation: scroll-left 30s linear infinite;
}
```

### Day/Time Selector
Toggle buttons for timeline navigation.
```css
.toggle-btn {
  padding: 6px 12px;
  border: 1px solid rgba(255,255,255,0.12);
  border-radius: 6px;
  background: transparent;
  color: var(--text-secondary);
  font-family: var(--font-mono);
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}
.toggle-btn.active {
  background: var(--data-blue);
  border-color: var(--data-blue);
  color: #ffffff;
}
```

## Layout

- **Full-viewport dark canvas**: `min-height: 100vh; background: var(--bg-void);`
- **Top status bar**: Live indicators, timestamps, system status — always visible.
- **3-column data grid**: `grid-template-columns: repeat(3, 1fr); gap: 16px;`
- **Information hierarchy**: Alert banner → Feed panel → Data grid → Detail panels.
- **Dense but organized**: Tight gaps between cards (12–16px), generous padding inside (20–24px).

## Depth System

No traditional drop shadows. Use **border glow** instead:

| Level | Background | Border | Effect |
|-------|------------|--------|--------|
| 0 (Page) | `#000000` | — | The void |
| 1 (Card) | `#0a0a0f` | `rgba(255,255,255,0.08)` | Floating on darkness |
| 2 (Modal) | `#111118` | `rgba(255,255,255,0.12)` | Above cards |
| 3 (Tooltip) | `#1a1a24` | Stronger border | Highest |

Hover/focus adds colored glow: `box-shadow: 0 0 20px rgba(color, 0.1);`

## Rules

### Do
- Monospace for ALL data — numbers, labels, headers, values
- Status colors scannable at a glance — green/amber/red
- Pulsing "LIVE" indicators for real-time feeds
- ALL-CAPS with wide letter-spacing for headers
- Pure dark backgrounds — the darkness is the design
- Design for density — skilled users want MORE data visible
- Border glow on hover, not color changes
- Scrolling tickers for breaking alerts

### Don't
- Light mode or light backgrounds — darkness only
- Excessive border-radius — max 8px, no pills
- Decorative illustrations or playful icons — serious, data-first
- Gratuitous animation — motion only for "live" indicators
- Serif or decorative fonts — monospace and geometric sans only
- Large hero sections — every pixel earns its place with data
- Muted/pastel colors — neon on black is the point

## Responsive

- **Desktop (1280px+)**: 3-column grid, full ticker, sidebar visible
- **Tablet (768–1279px)**: 2-column grid, collapsed sidebar
- **Mobile (< 768px)**: Single column, stacked cards, simplified top bar
- Status badges never shrink — they are critical for scanning
- Charts resize fluidly, switch to horizontal on narrow screens
