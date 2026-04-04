# Pevo Homepage Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build Pevo's company homepage with toss-style design — two pages (Home + Business), Next.js App Router, Tailwind CSS.

**Architecture:** Next.js 14 App Router with static pages. Shared layout (Nav + Footer) wraps two routes: `/` (hero + business cards) and `/business` (3 scrollable sections). Intersection Observer handles scroll-triggered fade-in animations. All styling via Tailwind with custom design tokens in `tailwind.config.ts`.

**Tech Stack:** Next.js 14, React 18, TypeScript, Tailwind CSS 3, Pretendard font (via CDN)

**Spec:** `docs/superpowers/specs/2026-04-04-pevo-homepage-design.md`

---

## File Structure

```
pevo-homepage/
├── app/
│   ├── globals.css           # Tailwind directives + Pretendard import + reveal animation
│   ├── layout.tsx            # Root layout: html/body + Nav + Footer
│   ├── page.tsx              # Home: Hero + BusinessSummary
│   └── business/
│       └── page.tsx          # Business: 3x Section components
├── components/
│   ├── Nav.tsx               # Sticky navigation bar
│   ├── Footer.tsx            # Dark footer
│   ├── Hero.tsx              # Hero section (heading + sub + CTA)
│   ├── BusinessCard.tsx      # White card (title + description + link)
│   ├── Section.tsx           # Reusable section (label + heading + body)
│   └── RevealOnScroll.tsx    # Intersection Observer wrapper
├── tailwind.config.ts        # Custom colors, fonts, spacing
├── package.json
├── tsconfig.json
└── next.config.ts
```

---

### Task 1: Scaffold Next.js Project

**Files:**
- Create: `pevo-homepage/package.json`
- Create: `pevo-homepage/tsconfig.json`
- Create: `pevo-homepage/next.config.ts`
- Create: `pevo-homepage/tailwind.config.ts`
- Create: `pevo-homepage/app/globals.css`
- Create: `pevo-homepage/app/layout.tsx`
- Create: `pevo-homepage/app/page.tsx`

- [ ] **Step 1: Create project with create-next-app**

```bash
cd /Users/sanghyunkim/Desktop/ai-company
npx create-next-app@latest pevo-homepage --typescript --tailwind --app --src-dir=false --import-alias="@/*" --use-npm --eslint
```

Expected: `pevo-homepage/` directory created with Next.js boilerplate.

- [ ] **Step 2: Configure Tailwind with Pevo design tokens**

Replace `pevo-homepage/tailwind.config.ts`:

```typescript
import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./app/**/*.{ts,tsx}",
    "./components/**/*.{ts,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        "toss-blue": "#3182f6",
        "toss-blue-hover": "#2272eb",
        "toss-blue-active": "#1b64da",
        ink: "#191f28",
        "gray-700": "#333d4b",
        "gray-600": "#6b7684",
        "gray-400": "#b0b8c1",
        "gray-300": "#d1d6db",
        "gray-200": "#e5e8eb",
        "gray-100": "#f2f4f6",
        "gray-50": "#f9fafb",
      },
      fontFamily: {
        sans: [
          "Pretendard",
          "-apple-system",
          "BlinkMacSystemFont",
          "Apple SD Gothic Neo",
          "Noto Sans KR",
          "sans-serif",
        ],
      },
      maxWidth: {
        container: "1040px",
      },
    },
  },
  plugins: [],
};

export default config;
```

- [ ] **Step 3: Set up globals.css with Pretendard font + reveal animation**

Replace `pevo-homepage/app/globals.css`:

```css
@import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable-dynamic-subset.min.css");

@tailwind base;
@tailwind components;
@tailwind utilities;

html {
  word-break: keep-all;
  letter-spacing: -0.02em;
}

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

- [ ] **Step 4: Create minimal layout.tsx placeholder**

Replace `pevo-homepage/app/layout.tsx`:

```tsx
import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Pevo — 헬스케어의 AI 전환을 설계합니다",
  description:
    "파트너의 레거시 시스템을 AI로 전환하여 새로운 성장을 만듭니다.",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="ko">
      <body className="font-sans text-ink bg-white">{children}</body>
    </html>
  );
}
```

- [ ] **Step 5: Create minimal page.tsx placeholder**

Replace `pevo-homepage/app/page.tsx`:

```tsx
export default function Home() {
  return (
    <main className="min-h-screen flex items-center justify-center">
      <h1 className="text-4xl font-bold">Pevo</h1>
    </main>
  );
}
```

- [ ] **Step 6: Verify dev server starts**

```bash
cd pevo-homepage && npm run dev
```

Expected: Server starts on `http://localhost:3000`, page shows "Pevo" heading.

- [ ] **Step 7: Commit**

```bash
cd /Users/sanghyunkim/Desktop/ai-company
git add pevo-homepage/
git commit -m "feat: scaffold pevo-homepage Next.js project with Tailwind + Pretendard"
```

---

### Task 2: Navigation Component

**Files:**
- Create: `pevo-homepage/components/Nav.tsx`
- Modify: `pevo-homepage/app/layout.tsx`

- [ ] **Step 1: Create Nav component**

Create `pevo-homepage/components/Nav.tsx`:

```tsx
import Link from "next/link";

export default function Nav() {
  return (
    <nav className="sticky top-0 z-50 bg-white border-b border-gray-200">
      <div className="max-w-container mx-auto px-6 h-16 flex items-center justify-between">
        <Link href="/" className="text-xl font-bold text-ink">
          Pevo
        </Link>
        <div className="flex items-center gap-8">
          <Link
            href="/business"
            className="text-[15px] font-medium text-gray-600 hover:text-ink transition-colors"
          >
            사업소개
          </Link>
          <a
            href="mailto:contact@pevo.care"
            className="text-[15px] font-medium text-gray-600 hover:text-ink transition-colors"
          >
            문의하기
          </a>
        </div>
      </div>
    </nav>
  );
}
```

- [ ] **Step 2: Add Nav to layout.tsx**

Replace `pevo-homepage/app/layout.tsx`:

```tsx
import type { Metadata } from "next";
import "./globals.css";
import Nav from "@/components/Nav";

export const metadata: Metadata = {
  title: "Pevo — 헬스케어의 AI 전환을 설계합니다",
  description:
    "파트너의 레거시 시스템을 AI로 전환하여 새로운 성장을 만듭니다.",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="ko">
      <body className="font-sans text-ink bg-white">
        <Nav />
        {children}
      </body>
    </html>
  );
}
```

- [ ] **Step 3: Verify Nav renders**

Run: `npm run dev` (if not running)
Expected: Sticky white nav bar at top with "Pevo" logo left, "사업소개" and "문의하기" links right.

- [ ] **Step 4: Commit**

```bash
git add pevo-homepage/components/Nav.tsx pevo-homepage/app/layout.tsx
git commit -m "feat: add sticky navigation component"
```

---

### Task 3: Footer Component

**Files:**
- Create: `pevo-homepage/components/Footer.tsx`
- Modify: `pevo-homepage/app/layout.tsx`

- [ ] **Step 1: Create Footer component**

Create `pevo-homepage/components/Footer.tsx`:

```tsx
export default function Footer() {
  return (
    <footer className="bg-black py-20">
      <div className="max-w-container mx-auto px-6">
        <p className="text-gray-400 text-[15px]">
          © 2026 Pevo. All rights reserved.
        </p>
        <a
          href="mailto:contact@pevo.care"
          className="text-gray-400 text-[15px] hover:text-gray-300 transition-colors mt-2 inline-block"
        >
          contact@pevo.care
        </a>
      </div>
    </footer>
  );
}
```

- [ ] **Step 2: Add Footer to layout.tsx**

Edit `pevo-homepage/app/layout.tsx` — add Footer import and render after `{children}`:

```tsx
import type { Metadata } from "next";
import "./globals.css";
import Nav from "@/components/Nav";
import Footer from "@/components/Footer";

export const metadata: Metadata = {
  title: "Pevo — 헬스케어의 AI 전환을 설계합니다",
  description:
    "파트너의 레거시 시스템을 AI로 전환하여 새로운 성장을 만듭니다.",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="ko">
      <body className="font-sans text-ink bg-white">
        <Nav />
        {children}
        <Footer />
      </body>
    </html>
  );
}
```

- [ ] **Step 3: Verify Footer renders**

Expected: Black footer at bottom with copyright and email.

- [ ] **Step 4: Commit**

```bash
git add pevo-homepage/components/Footer.tsx pevo-homepage/app/layout.tsx
git commit -m "feat: add dark footer component"
```

---

### Task 4: Hero Component + Home Page

**Files:**
- Create: `pevo-homepage/components/Hero.tsx`
- Modify: `pevo-homepage/app/page.tsx`

- [ ] **Step 1: Create Hero component**

Create `pevo-homepage/components/Hero.tsx`:

```tsx
import Link from "next/link";

export default function Hero() {
  return (
    <section className="bg-white py-[200px] flex flex-col items-center text-center px-6">
      <h1 className="text-[clamp(36px,6vw,56px)] font-bold leading-[1.2] text-ink">
        헬스케어의 AI 전환을
        <br />
        설계합니다.
      </h1>
      <p className="mt-6 text-lg text-gray-600 leading-relaxed max-w-[480px]">
        파트너의 레거시 시스템을 AI로 전환하여
        <br />
        새로운 성장을 만듭니다.
      </p>
      <Link
        href="/business"
        className="mt-10 inline-flex items-center gap-2 bg-toss-blue hover:bg-toss-blue-hover active:bg-toss-blue-active text-white px-8 py-4 rounded-xl text-[17px] font-semibold transition-colors"
      >
        사업소개 보기
        <span aria-hidden="true">→</span>
      </Link>
    </section>
  );
}
```

- [ ] **Step 2: Wire Hero into Home page**

Replace `pevo-homepage/app/page.tsx`:

```tsx
import Hero from "@/components/Hero";

export default function Home() {
  return (
    <main>
      <Hero />
    </main>
  );
}
```

- [ ] **Step 3: Verify Hero renders**

Expected: Centered bold heading "헬스케어의 AI 전환을 설계합니다." with subtitle and blue CTA button. 200px vertical padding.

- [ ] **Step 4: Commit**

```bash
git add pevo-homepage/components/Hero.tsx pevo-homepage/app/page.tsx
git commit -m "feat: add Hero section with toss-style typography"
```

---

### Task 5: BusinessCard Component + Home Business Summary

**Files:**
- Create: `pevo-homepage/components/BusinessCard.tsx`
- Modify: `pevo-homepage/app/page.tsx`

- [ ] **Step 1: Create BusinessCard component**

Create `pevo-homepage/components/BusinessCard.tsx`:

```tsx
import Link from "next/link";

interface BusinessCardProps {
  title: string;
  description: string;
  href: string;
}

export default function BusinessCard({
  title,
  description,
  href,
}: BusinessCardProps) {
  return (
    <div className="bg-white rounded-3xl p-10 shadow-[0_2px_8px_rgba(0,0,0,0.04),0_8px_24px_rgba(0,0,0,0.06)]">
      <h3 className="text-2xl font-bold text-ink">{title}</h3>
      <p className="mt-3 text-[17px] text-gray-600 leading-relaxed">
        {description}
      </p>
      <Link
        href={href}
        className="mt-6 inline-flex items-center gap-1 text-toss-blue text-[16px] font-medium hover:underline"
      >
        자세히 보기
        <span aria-hidden="true">→</span>
      </Link>
    </div>
  );
}
```

- [ ] **Step 2: Add Business Summary section to Home page**

Replace `pevo-homepage/app/page.tsx`:

```tsx
import Hero from "@/components/Hero";
import BusinessCard from "@/components/BusinessCard";

export default function Home() {
  return (
    <main>
      <Hero />

      <section className="bg-gray-50 py-[120px] px-6">
        <div className="max-w-container mx-auto">
          <p className="text-toss-blue text-[16px] font-semibold">
            What We Do
          </p>
          <h2 className="mt-3 text-[clamp(28px,4vw,40px)] font-bold text-ink">
            Healthcare AX Platform
          </h2>

          <div className="mt-12 grid grid-cols-1 md:grid-cols-2 gap-6">
            <BusinessCard
              title="크레소티"
              description="약국 16,500곳의 AI 전환 파트너"
              href="/business#cresotti"
            />
            <BusinessCard
              title="하울팟"
              description="펫 케어 플랫폼의 자동화 파트너"
              href="/business#howlpot"
            />
          </div>
        </div>
      </section>
    </main>
  );
}
```

- [ ] **Step 3: Verify Home page complete**

Expected: Hero + light-gray section with "What We Do" label, "Healthcare AX Platform" heading, 2 white cards.

- [ ] **Step 4: Commit**

```bash
git add pevo-homepage/components/BusinessCard.tsx pevo-homepage/app/page.tsx
git commit -m "feat: add BusinessCard component and home business summary"
```

---

### Task 6: Section Component + RevealOnScroll

**Files:**
- Create: `pevo-homepage/components/Section.tsx`
- Create: `pevo-homepage/components/RevealOnScroll.tsx`

- [ ] **Step 1: Create RevealOnScroll client component**

Create `pevo-homepage/components/RevealOnScroll.tsx`:

```tsx
"use client";

import { useEffect, useRef } from "react";

export default function RevealOnScroll({
  children,
}: {
  children: React.ReactNode;
}) {
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const el = ref.current;
    if (!el) return;

    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          el.classList.add("visible");
          observer.unobserve(el);
        }
      },
      { threshold: 0.15 }
    );

    observer.observe(el);
    return () => observer.disconnect();
  }, []);

  return (
    <div ref={ref} className="reveal">
      {children}
    </div>
  );
}
```

- [ ] **Step 2: Create Section component**

Create `pevo-homepage/components/Section.tsx`:

```tsx
import RevealOnScroll from "./RevealOnScroll";

interface SectionProps {
  id?: string;
  label: string;
  heading: string;
  body: string;
  bg?: "white" | "gray";
}

export default function Section({
  id,
  label,
  heading,
  body,
  bg = "white",
}: SectionProps) {
  return (
    <section
      id={id}
      className={`py-[200px] px-6 ${
        bg === "gray" ? "bg-gray-50" : "bg-white"
      }`}
    >
      <div className="max-w-container mx-auto">
        <RevealOnScroll>
          <p className="text-toss-blue text-[16px] font-semibold">{label}</p>
          <h2 className="mt-4 text-[clamp(32px,5vw,48px)] font-bold text-ink leading-[1.3]">
            {heading}
          </h2>
          <p className="mt-6 text-[18px] text-gray-600 leading-[1.7] max-w-[600px]">
            {body}
          </p>
        </RevealOnScroll>
      </div>
    </section>
  );
}
```

- [ ] **Step 3: Commit**

```bash
git add pevo-homepage/components/RevealOnScroll.tsx pevo-homepage/components/Section.tsx
git commit -m "feat: add Section and RevealOnScroll components"
```

---

### Task 7: Business Page

**Files:**
- Create: `pevo-homepage/app/business/page.tsx`

- [ ] **Step 1: Create business page**

Create `pevo-homepage/app/business/page.tsx`:

```tsx
import type { Metadata } from "next";
import Section from "@/components/Section";

export const metadata: Metadata = {
  title: "사업소개 — Pevo",
  description: "Pevo의 Healthcare AX Platform 사업을 소개합니다.",
};

export default function Business() {
  return (
    <main>
      <Section
        label="AX 플랫폼"
        heading="파트너의 시스템을 AI로 전환합니다."
        body="전환 1건이 매출 3배로 돌아옵니다. Pevo는 파트너의 레거시 시스템에 AI 백본을 구축하여 운영 자동화, 데이터 분석, 고객 커뮤니케이션을 통합 제공합니다."
        bg="white"
      />

      <Section
        id="cresotti"
        label="크레소티"
        heading="약국 16,500곳의 AI 전환 파트너"
        body="대한민국 약국 POS 시장점유율 70%. 크레소티의 레거시 POS를 AI 기반 플랫폼으로 전환하는 3년 독점 파트너십."
        bg="gray"
      />

      <Section
        id="howlpot"
        label="하울팟"
        heading="펫 케어의 새로운 표준"
        body="대경펫케어의 수기 운영을 자동화 플랫폼으로 전환. 보호자 앱 · 시터 앱 · 관리 대시보드 · 자동 정산."
        bg="white"
      />
    </main>
  );
}
```

- [ ] **Step 2: Verify business page**

Navigate to `http://localhost:3000/business`.
Expected: 3 sections with scroll-triggered fade-in, alternating white/gray backgrounds, 200px vertical spacing.

- [ ] **Step 3: Verify navigation links work**

Click "사업소개" in nav → goes to `/business`.
Click "Pevo" logo → goes to `/`.
Click "사업소개 보기 →" CTA on home → goes to `/business`.

- [ ] **Step 4: Commit**

```bash
git add pevo-homepage/app/business/page.tsx
git commit -m "feat: add business page with 3 sections (AX, Cresotti, Howlpot)"
```

---

### Task 8: Responsive Testing + Final Polish

**Files:**
- Possibly modify: any component for responsive fixes

- [ ] **Step 1: Test desktop (1040px+)**

Expected: 2-column cards on home, full 200px section spacing, centered hero.

- [ ] **Step 2: Test mobile (375px)**

Expected: Single-column cards, reduced heading size via `clamp()`, no horizontal overflow.

- [ ] **Step 3: Check toss-style Quality Gate**

Run through checklist:
- [ ] Pure white background (no tints)
- [ ] Single accent color (#3182f6) only
- [ ] Section spacing 200px on desktop
- [ ] Bold headings 36px+
- [ ] Dark footer (#000)
- [ ] `word-break: keep-all` on all Korean text
- [ ] Scroll animations working

- [ ] **Step 4: Final commit**

```bash
git add -A pevo-homepage/
git commit -m "feat: responsive polish and toss-style quality gate pass"
```

- [ ] **Step 5: Push to GitHub**

```bash
git push origin main
```
