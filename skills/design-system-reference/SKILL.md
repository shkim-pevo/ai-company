---
name: design-system-reference
description: Use when building UI, creating components, styling pages, or applying a specific brand's design language. Provides 54 production-grade DESIGN.md references (Stripe, Linear, Vercel, Airbnb, Apple, etc.) with color palettes, typography, components, and layout patterns.
---

# Design System Reference Library

## Overview

54개 글로벌 브랜드의 디자인 시스템을 DESIGN.md 형식으로 제공합니다. UI 작업 시 참조 디자인으로 활용하여 프로덕션 레벨의 일관된 UI를 생성합니다.

**Keywords**: design system, UI design, color palette, typography, components, layout, branding, DESIGN.md, Stitch, styling, theme, dark mode, responsive

## When to Use

- 새 UI 페이지/컴포넌트를 만들 때
- 기존 UI의 디자인 방향을 잡을 때
- 특정 브랜드 스타일을 참조하고 싶을 때
- 디자인 토큰(색상, 폰트, 간격, 그림자) 결정이 필요할 때
- 다크 모드/라이트 모드 설계 시

## How It Works

### 1. 프로젝트별 추천 디자인 시스템

| Pevo 프로젝트 | 추천 참조 | 이유 |
|---------------|----------|------|
| **pharmpay-ui** | Stripe, Revolut, Wise | 핀테크/결제 UI, 신뢰감 있는 디자인 |
| **howlpot-ui** | Airbnb, Intercom, Cal | 마켓플레이스/서비스 매칭 UI |
| **paperclip/ui** | Linear, Cursor, Notion | 개발자 도구/프로덕트 관리 UI |
| **ad-dashboard** | PostHog, Sentry, Airtable | 대시보드/분석 UI |

### 2. DESIGN.md 파일 위치

```
design-md/{브랜드명}/
  DESIGN.md          # 디자인 시스템 (9개 섹션)
  preview.html       # 라이트 모드 프리뷰
  preview-dark.html  # 다크 모드 프리뷰
```

### 3. DESIGN.md 9개 섹션

| # | 섹션 | 내용 |
|---|------|------|
| 1 | Visual Theme & Atmosphere | 무드, 밀도, 디자인 철학 |
| 2 | Color Palette & Roles | 시맨틱 네임 + hex + 기능적 역할 |
| 3 | Typography Rules | 폰트 패밀리, 계층 테이블 |
| 4 | Component Stylings | 버튼, 카드, 입력, 네비게이션 + 상태 |
| 5 | Layout Principles | 간격 스케일, 그리드, 여백 철학 |
| 6 | Depth & Elevation | 그림자 시스템, 표면 계층 |
| 7 | Do's and Don'ts | 디자인 가드레일 |
| 8 | Responsive Behavior | 브레이크포인트, 터치 타겟 |
| 9 | Agent Prompt Guide | 빠른 색상 참조, 프롬프트 |

### 4. 사용 패턴

**패턴 A: 특정 브랜드 스타일 적용**
```
1. design-md/{브랜드}/DESIGN.md 읽기
2. 색상 팔레트, 타이포그래피, 컴포넌트 스타일 추출
3. Tailwind CSS / CSS 변수로 변환
4. 프로젝트에 적용
```

**패턴 B: 혼합 참조 (추천)**
```
1. 2-3개 브랜드의 DESIGN.md 비교
2. 색상 체계는 A 브랜드, 타이포는 B 브랜드처럼 선별 적용
3. Pevo 브랜드 색상으로 커스터마이즈
```

**패턴 C: Pevo 전용 DESIGN.md 생성**
```
1. 가장 적합한 참조 브랜드 선정
2. Pevo 브랜드 컬러/폰트로 치환
3. 프로젝트 루트에 DESIGN.md 배치
4. 모든 UI 작업에서 자동 참조
```

## 사용 가능한 디자인 시스템 (54개)

### SaaS & Developer Tools
Airtable, Cal, ClickHouse, Composio, Cursor, Expo, HashiCorp, Linear, Lovable, Mintlify, MongoDB, Notion, OpenCode, PostHog, Raycast, Replicate, Resend, Sanity, Sentry, Supabase, Vercel, VoltAgent, Warp, Zapier

### AI & ML
Claude, Cohere, ElevenLabs, MiniMax, Mistral.ai, NVIDIA, Ollama, RunwayML, Together.ai, x.ai

### Design & Creative
Figma, Framer, Miro, Webflow

### Fintech & Commerce
Coinbase, Kraken, Revolut, Stripe, Wise

### Consumer & Marketplace
Airbnb, Intercom, Pinterest, Spotify, Superhuman, Uber

### Enterprise & Hardware
Apple, BMW, IBM, SpaceX, Clay

## Common Mistakes

- 참조 브랜드를 그대로 복사하지 말 것 - Pevo 브랜드에 맞게 커스터마이즈
- 한 프로젝트에 여러 디자인 시스템을 섞지 말 것 - 1-2개만 참조
- DESIGN.md의 hex 값을 직접 사용하지 말고 CSS 변수/Tailwind 테마로 변환
- preview.html은 참고용이지 프로덕션 코드가 아님
