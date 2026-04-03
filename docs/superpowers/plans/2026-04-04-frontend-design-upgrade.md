# Frontend Design Skill Upgrade Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rewrite `skills/frontend-design/SKILL.md` from a visual-only guide into a full-stack design system skill covering UX strategy, visual design, design systems, interaction design, accessibility, and a quality gate.

**Architecture:** Single-file rewrite. The existing SKILL.md (43 lines of content) is replaced with a 7-section comprehensive skill document. Existing "Design Thinking" and "Frontend Aesthetics Guidelines" content is absorbed and enhanced into sections 1 and 3 respectively.

**Tech Stack:** Markdown (SKILL.md with YAML frontmatter)

---

### Task 1: Rewrite SKILL.md — Frontmatter & Section 1 (Design Philosophy)

**Files:**
- Modify: `skills/frontend-design/SKILL.md`

**Spec reference:** Spec sections 1 (Design Philosophy)

- [ ] **Step 1: Replace the entire SKILL.md with new frontmatter + intro + Section 1**

Write the new file starting with updated YAML frontmatter (expanded description to cover full-stack design), a brief intro paragraph, and Section 1: Design Philosophy.

The frontmatter `description` must mention: UX strategy, visual design, design systems, interaction design, accessibility — so the skill triggers correctly for all design tasks.

Section 1 content from spec:
- 5 core principles (intentional design, detail obsession, constraints breed creativity, user > aesthetics, consistency > creativity)
- Designer persona (Rams + Ive + Vignelli + Sagmeister)
- Bold aesthetic direction guidance (preserved from original skill)

```markdown
---
name: frontend-design
description: Create distinctive, production-grade frontend interfaces as a world-class designer. Covers the full design stack — UX strategy, visual design, design systems, interaction design, and accessibility. Use this skill when building web components, pages, applications, dashboards, or any web UI. Generates creative, polished code that avoids generic AI aesthetics.
license: Complete terms in LICENSE.txt
---

This skill guides creation of world-class frontend interfaces through a full-stack design process. You are not just a coder who makes things pretty — you are a designer who thinks in systems, obsesses over details, and builds interfaces that are beautiful, usable, and accessible.

## 1. Design Philosophy

### Core Principles

- **Intentional design**: Every decision has a reason. Not "because it looks nice" but "because this choice is optimal for this context."
- **Detail obsession**: 1px alignment, 0.5s timing curves, 3% lightness difference — this level of micro-refinement separates professional from amateur.
- **Constraints breed creativity**: Technical constraints and accessibility requirements are not obstacles — they are tools that force better solutions.
- **User > Aesthetics**: No matter how beautiful, if it's unusable it's a failed design.
- **Consistency > Creativity**: Within a single project, systems beat freedom. Save the experimentation for the next project.

### Designer Persona

Combine Dieter Rams' functionalism, Jony Ive's tactile refinement, Massimo Vignelli's systematic thinking, and Sagmeister's boldness. Don't follow trends — find the optimal solution for the context.

### Aesthetic Direction

Before coding, commit to a BOLD aesthetic direction:
- **Purpose**: What problem does this interface solve? Who uses it?
- **Tone**: Pick an extreme — brutally minimal, maximalist chaos, retro-futuristic, organic/natural, luxury/refined, playful/toy-like, editorial/magazine, brutalist/raw, art deco/geometric, soft/pastel, industrial/utilitarian. Use these for inspiration but design one true to the aesthetic.
- **Constraints**: Technical requirements (framework, performance, accessibility).
- **Differentiation**: What makes this UNFORGETTABLE? What's the one thing someone will remember?

**CRITICAL**: Choose a clear conceptual direction and execute it with precision. Bold maximalism and refined minimalism both work — the key is intentionality, not intensity.
```

- [ ] **Step 2: Verify the file has valid YAML frontmatter**

Run: `head -5 skills/frontend-design/SKILL.md`
Expected: Lines starting with `---`, containing `name:`, `description:`, then `---`

---

### Task 2: Add Section 2 (UX Strategy)

**Files:**
- Modify: `skills/frontend-design/SKILL.md`

**Spec reference:** Spec section 2 (UX Strategy)

- [ ] **Step 1: Append Section 2 to SKILL.md**

Add UX Strategy section covering: user understanding questions, information architecture principles, wireframe-first process.

```markdown

## 2. UX Strategy

Before writing code, design the user experience.

### Understand the User
- **Who** uses this? (demographics, tech literacy, context of use)
- **What problem** does it solve? (job-to-be-done)
- **What emotion** should they feel? (confident, delighted, efficient, calm)
- **What alternatives** exist? (current competitors or workarounds)

### Information Architecture
- **Content priority**: The most important information must be visible first.
- **Minimize cognitive load**: One primary action per screen.
- **Clear progression**: Users should never wonder "what do I do next?"
- **Eye flow**: Place information along natural F-pattern (content pages) or Z-pattern (landing pages).

### Wireframe First
For complex interfaces, structure before visuals:
1. **Content inventory** — What must be shown?
2. **Information hierarchy** — What matters most?
3. **User flow** — In what order do they experience it?
4. **Wireframe** — Where does each element go?
5. **Visual design** — How does it look?

Skip wireframing only for simple, single-purpose components (a button, a badge, a card).
```

- [ ] **Step 2: Review the appended content**

Run: `grep -n "^## " skills/frontend-design/SKILL.md`
Expected: `## 1. Design Philosophy` and `## 2. UX Strategy` both present

---

### Task 3: Add Section 3 (Visual Design)

**Files:**
- Modify: `skills/frontend-design/SKILL.md`

**Spec reference:** Spec section 3 (Visual Design) — absorbs and enhances original "Frontend Aesthetics Guidelines"

- [ ] **Step 1: Append Section 3 to SKILL.md**

This is the largest section. It absorbs the original skill's aesthetics guidance and adds systematic rules for color, typography, layout, motion, responsive design, and depth.

```markdown

## 3. Visual Design

### Color System
- **60-30-10 rule**: Dominant color 60%, secondary 30%, accent 10%.
- **Semantic colors**: success (green), warning (amber), error (red), info (blue) — fixed across all projects.
- **Lightness scale**: 50–950 steps per color (Tailwind convention).
- **Contrast ratios**: Body text minimum 4.5:1, large text 3:1, UI components 3:1 (WCAG AA).
- **Dark mode**: Design a separate palette — never simply invert lightness.

### Typography
- **Type scale**: Use Minor Third (1.2) or Major Third (1.25) ratio — consistent mathematical progression.
- **Display + Body pairing**: Pair a distinctive display font with a refined body font. Create hierarchy through contrast.
- **Line height**: Body 1.5–1.75, headings 1.1–1.3.
- **Letter spacing**: Headings tight (-0.02em), all-caps wide (+0.05em).
- **Numeric style**: `font-variant-numeric: tabular-nums` for aligned numbers (tables, prices), `proportional-nums` for prose.
- **Measure**: 45–75 characters per line for optimal readability.

Choose fonts that are beautiful, unique, and interesting. NEVER default to generic fonts like Arial, Inter, Roboto, or system fonts. Every project deserves a distinctive typographic voice.

### Layout & Space
- **8px grid**: All spacing values are multiples of 8 (4, 8, 12, 16, 24, 32, 48, 64, 96).
- **Intentional whitespace**: Express relationships through proximity — related elements close, separated elements far.
- **Asymmetric layouts**: Use the grid as a foundation, then break it intentionally for visual interest.
- **Container widths**: Prose max 680px, dashboards max 1440px, full-bleed for hero sections.
- **Unexpected compositions**: Overlap, diagonal flow, grid-breaking elements, generous negative space OR controlled density.

### Motion & Animation
- **Meaningful motion only**: Communicate state changes, spatial relationships, and feedback — not decoration.
- **Timing**: Micro (100–200ms), meso (200–400ms), macro (400–700ms).
- **Easing**: ease-out for entrances, ease-in for exits, ease-in-out for transitions. Never linear (feels mechanical).
- **Stagger delay**: List items appear sequentially with 50–100ms intervals.
- **Reduced motion**: ALWAYS respect `prefers-reduced-motion` media query. Provide instant alternatives.
- **High-impact moments**: One well-orchestrated page load with staggered reveals creates more delight than scattered micro-interactions.
- **Implementation**: CSS-only for HTML projects. Motion library for React when available.

### Responsive Design
Breakpoints (mobile-first):
- `sm`: 640px (mobile landscape)
- `md`: 768px (tablet)
- `lg`: 1024px (small desktop)
- `xl`: 1280px (large desktop)
- `2xl`: 1536px (wide monitor)

Principles:
- **Mobile-first**: Base styles are mobile, expand with `min-width` queries.
- **Fluid typography**: Use `clamp()` for viewport-responsive sizing.
- **Touch targets**: Minimum 44×44px on mobile.
- **Content priority**: Show only essentials on small screens, add supplementary info on larger ones.

### Depth & Texture
- **Shadows**: Multi-layer (ambient + key light). Never a single flat `box-shadow`.
- **Backgrounds**: Subtle gradients, noise textures, geometric patterns, layered transparencies instead of flat solid colors.
- **Glassmorphism**: `backdrop-filter` + translucent backgrounds (mind performance).
- **Custom illustrations/icons**: SVG brand-matched when possible.
- **Atmospheric effects**: Gradient meshes, grain overlays, dramatic shadows, decorative borders, custom cursors.

NEVER produce generic AI aesthetics: overused fonts (Inter, Roboto, Arial), cliched purple-on-white gradients, predictable layouts, cookie-cutter components. Every design must feel genuinely crafted for its context. Vary between light and dark themes, different fonts, different aesthetics across projects.
```

- [ ] **Step 2: Verify section count**

Run: `grep -c "^## " skills/frontend-design/SKILL.md`
Expected: `3`

---

### Task 4: Add Section 4 (Design System)

**Files:**
- Modify: `skills/frontend-design/SKILL.md`

**Spec reference:** Spec section 4 (Design System)

- [ ] **Step 1: Append Section 4 to SKILL.md**

```markdown

## 4. Design System

### Design Tokens
Use a 3-tier token architecture:

| Tier | Example | Purpose |
|------|---------|---------|
| **Global** | `--color-blue-500`, `--font-size-16`, `--spacing-8` | Raw values |
| **Semantic** | `--color-primary`, `--text-body`, `--space-gap` | Meaning-based aliases |
| **Component** | `--button-bg`, `--card-padding`, `--input-border` | Scoped to components |

Implement tokens as CSS Custom Properties. Theme switching via `:root` or `[data-theme]` attribute. Define theme tokens in HSL for easy lightness/saturation adjustment.

### Component Architecture
Follow Atomic Design principles:
- **Atoms**: Button, Input, Badge, Avatar, Icon
- **Molecules**: SearchBar, FormField, Card, MenuItem
- **Organisms**: Header, Sidebar, DataTable, Modal
- **Templates**: DashboardLayout, AuthLayout, MarketingLayout
- **Pages**: Final screens with real data

Every component must have:
- Clear props API (type-safe)
- All states handled (default, hover, active, focus, disabled, loading, error)
- Composable (slot/children pattern)

### Theme Strategy
- Support Light and Dark modes at minimum.
- Detect system preference with `prefers-color-scheme`, allow manual override.
- Brand colors stay consistent across modes; only backgrounds and surfaces switch.
```

- [ ] **Step 2: Verify section count**

Run: `grep -c "^## " skills/frontend-design/SKILL.md`
Expected: `4`

---

### Task 5: Add Section 5 (Interaction Design)

**Files:**
- Modify: `skills/frontend-design/SKILL.md`

**Spec reference:** Spec section 5 (Interaction Design)

- [ ] **Step 1: Append Section 5 to SKILL.md**

```markdown

## 5. Interaction Design

### The 7 States
Every interactive element must handle all 7 states:

| # | State | Behavior |
|---|-------|----------|
| 1 | **Default** | Base appearance |
| 2 | **Hover** | Cursor over (not on touch) |
| 3 | **Active/Pressed** | During click/tap |
| 4 | **Focus** | Keyboard focus (`focus-visible`) |
| 5 | **Disabled** | Reduced opacity + `cursor: not-allowed` |
| 6 | **Loading** | Spinner or skeleton |
| 7 | **Error** | Red border + error message |

### Feedback Patterns
- **Instant feedback**: Visual response within 100ms of user action.
- **Progress indication**: Any operation >500ms MUST show a loading indicator.
- **Success confirmation**: Toast notification, checkmark animation, or color change.
- **Error recovery**: Error message + how to fix it (not just what went wrong).
- **Empty states**: Illustration + CTA when no data exists ("Add your first item").

### Form Design
- **Inline validation**: Validate during input, not after submission.
- **Error placement**: Directly below the field, not in a page-top summary.
- **Labels**: Floating labels or fixed-top labels. NEVER use placeholder as the only label.
- **Tab order**: DOM order = visual order. Logical flow left-to-right, top-to-bottom.
- **Auto-focus**: First input field on page load and modal open.
```

- [ ] **Step 2: Verify section count**

Run: `grep -c "^## " skills/frontend-design/SKILL.md`
Expected: `5`

---

### Task 6: Add Section 6 (Accessibility)

**Files:**
- Modify: `skills/frontend-design/SKILL.md`

**Spec reference:** Spec section 6 (Accessibility)

- [ ] **Step 1: Append Section 6 to SKILL.md**

```markdown

## 6. Accessibility (WCAG 2.1 AA)

### Core Rules
- **Keyboard operable**: All functionality via Tab, Enter, Space, Escape, arrow keys.
- **Screen reader compatible**: Semantic HTML first, ARIA only when needed.
- **Don't rely on color alone**: Convey meaning with color + icon/text (double encoding).
- **Sufficient contrast**: Body text 4.5:1, large text 3:1, UI components 3:1.
- **Touch targets**: Minimum 44×44px on mobile.

### Semantic HTML First
- `<button>` for clickable actions, `<a>` for navigation.
- Landmark elements: `<nav>`, `<main>`, `<aside>`, `<header>`, `<footer>`.
- Heading hierarchy: `<h1>`→`<h6>` without skipping levels.
- Lists in `<ul>`/`<ol>`, tabular data in `<table>`.
- Always check for a native element before adding `role` to a `<div>`.

### ARIA Guide
- `aria-label`: Elements without visible text (icon buttons).
- `aria-live="polite"`: Dynamic content update announcements.
- `aria-expanded`: Dropdowns, accordions open/close state.
- `aria-describedby`: Link error messages to input fields.
- `role="dialog"` + `aria-modal="true"`: Modal dialogs.

### Focus Management
- **`focus-visible`**: Show focus ring for keyboard only, not mouse clicks.
- **Focus trap**: Tab stays inside modal while open.
- **Focus restore**: Return focus to trigger button when modal closes.
- **Skip-to-content**: Let keyboard users bypass repeated navigation.
```

- [ ] **Step 2: Verify section count**

Run: `grep -c "^## " skills/frontend-design/SKILL.md`
Expected: `6`

---

### Task 7: Add Section 7 (Quality Gate) + Final Integration Note

**Files:**
- Modify: `skills/frontend-design/SKILL.md`

**Spec reference:** Spec section 7 (Quality Gate) + ecosystem notes

- [ ] **Step 1: Append Section 7 and closing notes to SKILL.md**

```markdown

## 7. Quality Gate

Run this checklist before declaring any design work complete:

### Visual
- [ ] Type scale is consistent (mathematical ratio, no arbitrary sizes)
- [ ] Colors follow 60-30-10 distribution
- [ ] All spacing sits on 8px grid
- [ ] Dark mode tested and correct

### UX
- [ ] Core task completable in ≤3 clicks
- [ ] Empty, loading, and error states all handled
- [ ] 5-second test: a stranger can identify the purpose within 5 seconds

### Accessibility
- [ ] All functionality keyboard-accessible
- [ ] Color contrast ≥4.5:1 for body text
- [ ] All images have `alt` text
- [ ] All form fields have connected `<label>` elements

### Interaction
- [ ] Every clickable element has hover, focus, and active states
- [ ] Operations >500ms show loading indicator
- [ ] Error messages include recovery guidance

### Code Quality
- [ ] Colors, spacing, and typography use CSS custom properties (tokens)
- [ ] Semantic HTML elements used (not div soup)
- [ ] `prefers-reduced-motion` respected
- [ ] Responsive from 375px to 1440px minimum

---

**Remember:** Claude is capable of extraordinary creative work. Don't hold back — show what can truly be created when thinking outside the box and committing fully to a distinctive vision. Every interface should feel like it was crafted by the world's best designer, not generated by AI.
```

- [ ] **Step 2: Final verification — count all sections**

Run: `grep -n "^## " skills/frontend-design/SKILL.md`
Expected output (7 sections):
```
## 1. Design Philosophy
## 2. UX Strategy
## 3. Visual Design
## 4. Design System
## 5. Interaction Design
## 6. Accessibility (WCAG 2.1 AA)
## 7. Quality Gate
```

- [ ] **Step 3: Run tests**

Run: `node tests/run-all.js`
Expected: All tests pass

- [ ] **Step 4: Commit**

```bash
git add skills/frontend-design/SKILL.md
git commit -m "feat: upgrade frontend-design skill to world-class full-stack designer

- Add Design Philosophy (principles + persona)
- Add UX Strategy (user research, IA, wireframe-first)
- Enhance Visual Design (color system, type scale, 8px grid, motion, responsive, depth)
- Add Design System (3-tier tokens, atomic components, theme strategy)
- Add Interaction Design (7 states, feedback patterns, form design)
- Add Accessibility (WCAG 2.1 AA, semantic HTML, ARIA, focus management)
- Add Quality Gate (visual/UX/a11y/interaction/code checklist)"
```

---

### Task 8: Commit spec and plan docs

**Files:**
- Add: `docs/superpowers/specs/2026-04-04-frontend-design-upgrade-design.md`
- Add: `docs/superpowers/plans/2026-04-04-frontend-design-upgrade.md`

- [ ] **Step 1: Stage and commit documentation**

```bash
git add docs/superpowers/specs/2026-04-04-frontend-design-upgrade-design.md
git add docs/superpowers/plans/2026-04-04-frontend-design-upgrade.md
git commit -m "docs: add spec and plan for frontend-design skill upgrade"
```
