# Frontend Design Skill Upgrade — World-Class Designer

**Date:** 2026-04-04
**Status:** Draft
**Target:** `skills/frontend-design/SKILL.md`

## Context

기존 `frontend-design` 스킬은 비주얼 미학(색채, 타이포, 모션)에만 집중되어 있다. 이를 UX 전략, 디자인 시스템, 인터랙션 디자인, 접근성까지 포괄하는 풀스택 디자인 스킬로 확장하여, 어떤 프로젝트에서든 세계 최고 수준의 디자인을 생산할 수 있는 범용 에이전트를 만든다.

## 접근 방식

기존 SKILL.md를 **레이어드 확장** — 7개 섹션으로 재구성. 기존 "Design Thinking"과 "Frontend Aesthetics Guidelines"는 각각 섹션 1, 3에 흡수/강화.

---

## 1. Design Philosophy (새로 추가)

세계 최고 디자이너의 핵심 원칙을 정의한다.

```
- 의도적 디자인: 모든 결정에는 이유가 있다. "예쁘니까"가 아니라 "이 맥락에서 이 선택이 최적이기 때문에"
- 디테일 집착: 1px, 0.5초 타이밍, 색상 명도 차이 3% — 이 수준의 미세 조정이 프로 vs 아마추어를 가른다
- 제약이 창의를 낳는다: 기술적 제약, 접근성 요구사항은 장애물이 아니라 더 나은 해결책을 찾게 하는 도구
- 사용자 > 미학: 아무리 아름다워도 사용할 수 없으면 실패한 디자인
- 일관성 > 창의성: 하나의 프로젝트 안에서는 체계가 자유를 이긴다
```

**페르소나:**
Claude는 Dieter Rams의 기능주의, Jony Ive의 촉각적 정제, Massimo Vignelli의 체계적 사고, Sagmeister의 대담함을 결합한 디자이너로 행동한다. 트렌드를 따르지 않고, 맥락에 맞는 최적의 해결책을 찾는다.

---

## 2. UX Strategy (새로 추가)

코드를 쓰기 전, 사용자 경험 설계를 먼저 한다.

### 사용자 이해
```
- 누가 사용하는가? (demographics, tech literacy, context of use)
- 어떤 문제를 해결하는가? (job-to-be-done)
- 어떤 감정을 느끼길 원하는가? (confident, delighted, efficient, calm)
- 기존에 어떻게 해결하고 있는가? (현재 대안/경쟁)
```

### 정보 구조
```
- 콘텐츠 우선순위: 가장 중요한 정보가 가장 먼저 보여야 한다
- 인지 부하 최소화: 한 화면에 하나의 핵심 액션
- 진행 경로: 사용자가 "다음에 뭘 하지?"를 고민하지 않는 명확한 흐름
- F-패턴/Z-패턴: 시선 흐름에 맞는 정보 배치
```

### 와이어프레임 우선
```
복잡한 인터페이스는 비주얼 전에 구조를 먼저 잡는다:
1. 콘텐츠 인벤토리 (무엇이 보여야 하는가)
2. 정보 계층 (무엇이 가장 중요한가)
3. 사용자 플로우 (어떤 순서로 경험하는가)
4. 와이어프레임 (어디에 무엇을 배치하는가)
5. 비주얼 디자인 (어떻게 보이는가)
```

---

## 3. Visual Design (기존 강화)

기존 "Frontend Aesthetics Guidelines"를 다음과 같이 체계화:

### 색채 시스템
```
- 60-30-10 법칙: 주색 60%, 보조색 30%, 강조색 10%
- 의미적 색상: success(green), warning(amber), error(red), info(blue) 계열 고정
- 명도 스케일: 각 색상에 50~950 단계 (Tailwind 방식)
- 대비비: 텍스트 최소 4.5:1, 대형 텍스트 3:1 (WCAG AA)
- 다크 모드: 단순 반전이 아닌 별도 팔레트 설계
```

### 타이포그래피
```
- 타입 스케일: Minor Third (1.2) 또는 Major Third (1.25) — 일관된 비율
- 디스플레이 + 바디 페어링: 대비를 통한 계층 구분
- 행간(line-height): 바디 1.5~1.75, 헤딩 1.1~1.3
- 자간(letter-spacing): 헤딩은 타이트(-0.02em), 올캡은 와이드(+0.05em)
- 숫자: tabular-nums (정렬이 필요한 곳), proportional-nums (산문)
- 최대 줄 길이: 45~75자 (가독성 최적)
```

### 레이아웃 & 공간
```
- 8px 그리드 시스템: 모든 간격은 8의 배수 (4, 8, 12, 16, 24, 32, 48, 64, 96)
- 의도적 여백: 요소 간 관계를 여백으로 표현 (관련 요소 = 가까이, 분리 = 멀리)
- 비대칭 레이아웃: 그리드를 기반으로 하되, 시각적 흥미를 위해 의도적으로 깨트리기
- 컨테이너 최대 너비: 콘텐츠 유형에 따라 (산문: 680px, 대시보드: 1440px)
```

### 모션 & 애니메이션
```
- 의미 있는 모션만: 장식이 아니라 상태 변화, 공간 관계, 피드백을 전달
- 타이밍: 마이크로(100-200ms), 메소(200-400ms), 매크로(400-700ms)
- 이징: ease-out(진입), ease-in(퇴장), ease-in-out(전환) — linear는 기계적
- 스태거 딜레이: 목록 아이템 50-100ms 간격으로 순차 등장
- reduce-motion: 항상 prefers-reduced-motion 미디어 쿼리 존중
```

### 반응형 디자인
```
브레이크포인트 (모바일 퍼스트):
- sm: 640px (모바일 가로)
- md: 768px (태블릿)
- lg: 1024px (소형 데스크탑)
- xl: 1280px (대형 데스크탑)
- 2xl: 1536px (와이드 모니터)

원칙:
- 모바일 퍼스트: 기본 스타일은 모바일, min-width로 확장
- 유동적 타이포: clamp()로 뷰포트에 따라 자동 조절
- 터치 타겟: 모바일에서 최소 44x44px
- 컨텐츠 우선순위: 작은 화면에서는 핵심만, 큰 화면에서 보조 정보 추가
```

### 깊이 & 질감
```
- 그림자: 다중 레이어 (ambient + key light) — 단일 box-shadow 금지
- 배경: 솔리드 단색 대신 미묘한 그라디언트, 노이즈, 패턴, 텍스처
- 글래스모피즘: backdrop-filter + 반투명 배경 (성능 주의)
- 커스텀 일러스트/아이콘: 가능하면 SVG로 브랜드 맞춤 제작
```

---

## 4. Design System (새로 추가)

재사용 가능한 디자인 시스템을 설계한다.

### 디자인 토큰
```
3계층 토큰 구조:
- Global tokens: --color-blue-500, --font-size-16, --spacing-8
- Semantic tokens: --color-primary, --text-body, --space-component-gap
- Component tokens: --button-bg, --card-padding, --input-border-color

토큰은 CSS Custom Properties로 구현. 테마 전환은 :root 또는 [data-theme] 속성으로.
```

### 컴포넌트 아키텍처
```
Atomic Design 원칙:
- Atoms: Button, Input, Badge, Avatar, Icon
- Molecules: SearchBar, FormField, Card, MenuItem
- Organisms: Header, Sidebar, DataTable, Modal
- Templates: DashboardLayout, AuthLayout, MarketingLayout
- Pages: 실제 데이터가 결합된 최종 화면

각 컴포넌트는:
- 명확한 props API (타입 안전)
- 모든 상태 처리 (default, hover, active, focus, disabled, loading, error)
- 컴포지션 가능 (slot/children 패턴)
```

### 테마 전략
```
- Light/Dark 최소 지원
- 색상 모드는 시스템 설정 감지 + 수동 전환
- 테마 토큰은 HSL로 정의 (명도/채도 조절 용이)
- 브랜드 색상은 모드 간 동일 색상 유지, 배경/표면만 전환
```

---

## 5. Interaction Design (새로 추가)

### 상태 & 피드백
```
모든 인터랙티브 요소는 7가지 상태를 가진다:
1. Default — 기본 상태
2. Hover — 커서 올림 (터치에선 없음)
3. Active/Pressed — 클릭/탭 중
4. Focus — 키보드 포커스 (focus-visible 사용)
5. Disabled — 비활성 (opacity 낮추기 + cursor: not-allowed)
6. Loading — 처리 중 (스피너 또는 스켈레톤)
7. Error — 오류 상태 (빨간 테두리 + 에러 메시지)
```

### 피드백 패턴
```
- 즉시 피드백: 버튼 클릭 → 시각적 응답 100ms 이내
- 진행 표시: 0.5초 이상 걸리는 작업은 반드시 로딩 인디케이터
- 성공 확인: 토스트, 체크마크 애니메이션, 색상 변화
- 에러 복구: 에러 메시지 + 해결 방법 제시 (문제만 알려주지 말고 "어떻게 고칠지"도)
- 빈 상태: 데이터 없을 때 일러스트 + CTA ("첫 항목을 추가해보세요")
```

### 폼 디자인
```
- 인라인 유효성 검사 (제출 후가 아닌 입력 중)
- 에러 메시지는 필드 바로 아래에 (페이지 상단 요약 아님)
- 플로팅 레이블 또는 상단 고정 레이블 (placeholder를 레이블로 사용 금지)
- 논리적 탭 순서 (DOM 순서 = 시각 순서)
- 자동 포커스: 페이지 첫 입력 필드에 (모달 열릴 때도)
```

---

## 6. Accessibility (새로 추가)

WCAG 2.1 Level AA를 기본으로 한다.

### 핵심 원칙
```
- 키보드 완전 조작 가능: Tab, Enter, Space, Escape, 화살표키
- 스크린리더 호환: 시맨틱 HTML + ARIA (필요시만)
- 색상에 의존하지 않기: 색상 + 아이콘/텍스트로 이중 전달
- 충분한 대비: 일반 텍스트 4.5:1, 대형 텍스트 3:1, UI 컴포넌트 3:1
- 터치 타겟: 최소 44x44px (모바일)
```

### 시맨틱 HTML 우선
```
- <button> (클릭 가능한 것) vs <a> (이동하는 것)
- <nav>, <main>, <aside>, <header>, <footer> 랜드마크
- <h1>~<h6> 순서 스킵 없이
- <ul>/<ol> 리스트에, <table> 표형 데이터에
- div/span에 role 붙이기 전에 네이티브 요소가 있는지 확인
```

### ARIA 가이드
```
- aria-label: 시각적 레이블 없는 요소 (아이콘 버튼 등)
- aria-live="polite": 동적 콘텐츠 업데이트 알림
- aria-expanded: 드롭다운, 아코디언 열림/닫힘
- aria-describedby: 에러 메시지를 입력 필드에 연결
- role="dialog" + aria-modal: 모달 창
```

### 포커스 관리
```
- focus-visible: 키보드 포커스만 표시 (마우스 클릭엔 안 보임)
- 포커스 트랩: 모달 안에서 Tab이 모달 밖으로 나가지 않음
- 포커스 복원: 모달 닫힐 때 트리거 버튼으로 돌아감
- skip-to-content 링크: 키보드 사용자가 반복 네비게이션 건너뛰기
```

---

## 7. Quality Gate (새로 추가)

모든 디자인 작업 완료 시 통과해야 하는 체크리스트.

```
□ 비주얼 체크
  - 타입 스케일이 일관적인가?
  - 색상이 60-30-10 비율에 가까운가?
  - 모든 간격이 8px 그리드 위에 있는가?
  - 다크 모드에서도 정상인가?

□ UX 체크
  - 사용자의 핵심 태스크가 3클릭 이내에 완료되는가?
  - 빈 상태, 로딩 상태, 에러 상태가 모두 처리되었는가?
  - 정보 계층이 명확한가? (5초 테스트: 처음 보는 사람이 5초 안에 핵심을 파악?)

□ 접근성 체크
  - 키보드만으로 모든 기능 사용 가능한가?
  - 색상 대비 4.5:1 이상인가?
  - 모든 이미지에 alt 텍스트가 있는가?
  - 폼 필드에 연결된 레이블이 있는가?

□ 인터랙션 체크
  - 모든 클릭 가능한 요소가 hover/focus/active 상태를 가지는가?
  - 0.5초 이상 걸리는 작업에 로딩 표시가 있는가?
  - 에러 메시지가 해결 방법을 제시하는가?

□ 코드 품질
  - CSS 변수로 토큰화되었는가?
  - 시맨틱 HTML을 사용했는가?
  - prefers-reduced-motion을 존중하는가?
  - 반응형 (최소 모바일 375px ~ 데스크탑 1440px)?
```

---

## 기존 스킬과의 연계

- `design-system-reference` (54개 브랜드): 섹션 3, 4에서 "레퍼런스 시스템 선택 후 어댑트" 워크플로우 유지
- `frontend-slides`: 프레젠테이션 특화 — 이 스킬과 독립적으로 유지
- `paperclip/design-guide`: Paperclip 전용 — 이 스킬의 원칙을 따르되 자체 토큰 유지

## 수정 대상 파일

- `skills/frontend-design/SKILL.md` — 전체 재작성 (기존 내용 흡수 + 6개 섹션 추가)

## 검증 방법

1. SKILL.md 작성 후 node tests 통과 확인
2. 실제 프로젝트(예: 간단한 랜딩 페이지)에 스킬 적용하여 품질 체크
3. Quality Gate 7개 항목 전부 통과하는지 검증
