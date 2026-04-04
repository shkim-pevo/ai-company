# Pevo 회사 홈페이지 — Design Spec

**Date:** 2026-04-04
**Design Style:** toss-style
**Tech Stack:** Next.js + Tailwind CSS
**Domain:** pevo.care (향후 연결)

## Context

Pevo 회사의 공식 홈페이지를 만든다. 채용, 투자자, 파트너 모두를 대상으로 하되, 최소 구성(히어로 + 사업소개)으로 시작하여 점진적으로 확장한다. toss-style 디자인 스킬을 적용하여 깨끗하고 프리미엄한 느낌을 준다.

## Design Decisions

- **디자인 스타일**: toss-style — 순백 배경, 단일 강조색(#3182f6), 극단적 여백, 볼드 한글 타이포
- **접근 방식**: Statement-First — 한 문장 히어로 + 간결한 사업 카드
- **페이지 구조**: 멀티 페이지 (홈 `/` + 사업소개 `/business`)
- **강조색**: Toss Blue `#3182f6`
- **기술**: Next.js (App Router) + Tailwind CSS

## Pages

### 1. 홈 (`/`)

#### Navigation (공통, 모든 페이지)
- 고정 상단 (`position: sticky`)
- 백색 배경 + 하단 헤어라인 (`border-bottom: 1px solid #e5e8eb`)
- 좌측: Pevo 로고 (텍스트 "Pevo" 또는 로고 이미지)
- 우측: "사업소개", "문의하기" 링크
- `max-width: 1040px` 컨테이너

#### Hero Section
- 순백 배경 (`#ffffff`)
- 중앙 정렬
- 상하 패딩 200px+
- 메인 헤딩: **"헬스케어의 AI 전환을 설계합니다."**
  - 50-56px, weight 700, color `#191f28`
  - `word-break: keep-all`, `letter-spacing: -0.02em`
- 서브텍스트: "파트너의 레거시 시스템을 AI로 전환하여 새로운 성장을 만듭니다."
  - 18-20px, weight 400, color `#6b7684`
  - `margin-top: 24px`
- CTA 버튼: "사업소개 보기 →"
  - `background: #3182f6`, `color: #fff`, `border-radius: 12px`
  - `padding: 16px 32px`, `font-size: 17px`, `font-weight: 600`
  - `margin-top: 40px`
  - 링크: `/business`

#### Business Summary Section
- 배경: `#f9fafb` (라이트 그레이)
- 상하 패딩 120px
- 섹션 레이블: "What We Do" — `color: #3182f6`, `font-size: 16px`, `font-weight: 600`
- 섹션 헤딩: "Healthcare AX Platform" — 36-40px, weight 700
- 2-column 카드 그리드 (`gap: 24px`, `margin-top: 48px`)

**카드 1: 크레소티**
- 배경: `#ffffff`
- `border-radius: 24px`
- `padding: 40px`
- `box-shadow: 0 2px 8px rgba(0,0,0,0.04), 0 8px 24px rgba(0,0,0,0.06)`
- 제목: "크레소티" — 24px, weight 700
- 부제: "약국 16,500곳의 AI 전환 파트너" — 17px, weight 400, `color: #6b7684`
- 링크: "자세히 보기 →" — `color: #3182f6`, 16px, weight 500

**카드 2: 하울팟**
- 동일 스타일
- 제목: "하울팟"
- 부제: "펫 케어 플랫폼의 자동화 파트너"
- 링크: "자세히 보기 →"

#### Footer (공통)
- 배경: `#000000`
- 상하 패딩 80px
- 텍스트 `color: #94a3b8`
- "© 2026 Pevo. All rights reserved."
- "contact@pevo.care"

---

### 2. 사업소개 (`/business`)

스크롤하면 섹션별로 하나의 메시지가 전달되는 구조.

#### Section 1: AX 플랫폼
- 배경: `#ffffff`
- 상하 패딩 200px
- 섹션 레이블: "AX 플랫폼" — `color: #3182f6`
- 헤딩: "파트너의 시스템을 AI로 전환합니다." — 44-48px, weight 700
- 본문: "전환 1건이 매출 3배로 돌아옵니다. Pevo는 파트너의 레거시 시스템에 AI 백본을 구축하여 운영 자동화, 데이터 분석, 고객 커뮤니케이션을 통합 제공합니다." — 18px, weight 400, `color: #6b7684`, max-width 600px

#### Section 2: 크레소티
- 배경: `#f9fafb`
- 상하 패딩 200px
- 섹션 레이블: "크레소티"
- 헤딩: "약국 16,500곳의 AI 전환 파트너"
- 본문: "대한민국 약국 POS 시장점유율 70%. 크레소티의 레거시 POS를 AI 기반 플랫폼으로 전환하는 3년 독점 파트너십."
- 하위 정보 (선택적): PharmPay, PharmView, Advertising 등 간단 설명

#### Section 3: 하울팟
- 배경: `#ffffff`
- 상하 패딩 200px
- 섹션 레이블: "하울팟"
- 헤딩: "펫 케어의 새로운 표준"
- 본문: "대경펫케어의 수기 운영을 자동화 플랫폼으로 전환. 보호자 앱 · 시터 앱 · 관리 대시보드 · 자동 정산."

---

## Design Tokens (toss-style 준수)

```css
/* Colors */
--toss-blue: #3182f6;
--bg-white: #ffffff;
--bg-gray: #f9fafb;
--bg-dark: #000000;
--ink: #191f28;
--gray-600: #6b7684;
--gray-400: #b0b8c1;
--gray-200: #e5e8eb;

/* Typography */
--font: 'Pretendard', -apple-system, 'Apple SD Gothic Neo', sans-serif;

/* Spacing */
--section-padding: 200px;
--container-max: 1040px;
```

## Typography Rules

- 헤딩: 44-56px, weight 700, `word-break: keep-all`, `letter-spacing: -0.02em`
- 서브텍스트: 17-20px, weight 400, `color: #6b7684`, `line-height: 1.6`
- 섹션 레이블: 16px, weight 600, `color: #3182f6`
- 본문 max-width: 600px (가독성)

## Responsive

- Desktop (1040px+): 2-column 카드, 200px 섹션 간격
- Tablet (640-1039px): 2-column 유지, 150px 간격
- Mobile (<640px): 1-column, 100px 간격, 헤딩 `clamp(32px, 6vw, 56px)`

## Scroll Animation

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
Intersection Observer로 스크롤 시 섹션 페이드인.

## File Structure

```
pevo-homepage/
├── app/
│   ├── layout.tsx          # 공통 레이아웃 (Nav + Footer)
│   ├── page.tsx            # 홈
│   └── business/
│       └── page.tsx        # 사업소개
├── components/
│   ├── Nav.tsx
│   ├── Footer.tsx
│   ├── Hero.tsx
│   ├── BusinessCard.tsx
│   └── Section.tsx         # 재사용 섹션 (레이블 + 헤딩 + 본문)
├── tailwind.config.ts
├── package.json
└── next.config.ts
```

## 향후 확장

- `/team` — 팀 소개 (CEO/CTO 프로필 + 조직 구성)
- `/careers` — 채용 (포지션 목록 + 지원 CTA)
- `/contact` — 문의하기 (이메일/폼)

## Verification

1. `npm run dev`로 로컬 실행
2. `/` 페이지: 히어로 + 사업 카드 정상 렌더링
3. `/business` 페이지: 3개 섹션 스크롤 애니메이션
4. 모바일 375px에서 레이아웃 깨짐 없는지 확인
5. toss-style Quality Gate 체크 (순백 배경, 단일 블루, 200px 여백)
