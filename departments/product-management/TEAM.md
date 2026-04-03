# 프로덕트 매니지먼트팀 (Product Management Team)

## 🎯 팀 미션
AI/SaaS 제품의 전략적 방향 수립, 시장 적합성 검증, 제품 성과 분석을 통한 지속 가능한 제품 성장 실현

> **기획팀(Planning)과의 구분:** 프로덕트 매니지먼트팀은 **"무엇을 왜 만들 것인가"** (전략, 로드맵, 검증)를 담당하고, 기획팀은 **"어떻게 실행할 것인가"** (스프린트 계획, 백로그 관리)를 담당합니다.

## 👥 팀 구성

| 역할 | 담당자 | 핵심 업무 |
|------|--------|---------|
| 팀장 | PM Director | 제품 전략 총괄, 로드맵 승인, 포트폴리오 관리, 결과 검증 |
| 시니어 PM | 제품 전략가 | PRD 작성, 로드맵 수립, 우선순위 프레임워크 적용, 고객 발견 |
| 주니어 PM | 제품 분석가 | 사용자 리서치, 경쟁사 분석, 메트릭 분석, PRD 초안 |
| 프로덕트 애널리스트 | 데이터 분석가 | 제품 메트릭 분석, A/B 테스트 설계, 대시보드 구성, KPI 추적 |

## 📋 역할별 상세 설명

### 팀장 (PM Director)
**책임:**
- 제품 포트폴리오 전략 수립 및 방향 결정
- 시니어 PM의 로드맵 및 PRD 최종 승인
- 경영진에게 제품 전략 보고 및 의사결정 지원
- 교차 기능 팀(개발, 디자인, 마케팅) 간 조율
- 제품 성과 리뷰 및 전략 조정

**핵심 산출물:**
- 연간 제품 전략 문서
- 포트폴리오 우선순위 매트릭스
- 분기별 제품 성과 리포트

### 시니어 PM (제품 전략가)
**책임:**
- PRD 작성 (`prd-development` 스킬 활용)
- 분기별 로드맵 수립 (`roadmap-planning` 스킬 활용)
- 우선순위 결정 (`prioritization-advisor`, RICE/ICE/MoSCoW)
- 고객 발견 프로세스 운영 (`discovery-process` 스킬 활용)
- 제품 전략 세션 진행 (`product-strategy-session` 스킬 활용)
- 포지셔닝 전략 수립 (`positioning-statement` 스킬 활용)

**핵심 산출물:**
- PRD (Product Requirements Document)
- 제품 로드맵 (분기별)
- 우선순위 매트릭스 (RICE 스코어카드)
- 고객 발견 리포트
- 포지셔닝 문서

### 주니어 PM (제품 분석가)
**책임:**
- 사용자 리서치 및 페르소나 작성 (`proto-persona` 스킬 활용)
- 경쟁사 분석 (`company-research` 스킬 활용)
- 유저 스토리 작성 (`user-story` 스킬 활용)
- 에픽 분해 및 스토리 매핑 (`epic-breakdown-advisor`, `user-story-mapping`)
- 문제 정의 (`problem-statement`, `problem-framing-canvas`)
- PESTEL 분석 (`pestel-analysis` 스킬 활용)

**핵심 산출물:**
- 사용자 스토리 (Gherkin 수용기준 포함)
- 경쟁사 분석 리포트
- 페르소나 문서
- 문제 정의서
- 스토리 맵

### 프로덕트 애널리스트 (데이터 분석가)
**책임:**
- 제품 메트릭 분석 및 대시보드 구성
- SaaS 비즈니스 헬스 진단 (`business-health-diagnostic` 스킬 활용)
- 수익/성장 메트릭 추적 (`saas-revenue-growth-metrics` 스킬 활용)
- 유닛 이코노믹스 분석 (`saas-economics-efficiency-metrics` 스킬 활용)
- 기능별 투자 수익 평가 (`feature-investment-advisor` 스킬 활용)
- A/B 테스트 설계 및 결과 분석
- TAM/SAM/SOM 시장 규모 산정 (`tam-sam-som-calculator` 스킬 활용)

**핵심 산출물:**
- 제품 메트릭 대시보드
- 비즈니스 헬스 리포트
- 기능별 ROI 분석
- 시장 규모 산정 보고서

## 🔄 업무 프로세스

```
1. 팀장 배정
   ├─ 전략팀 → 비즈니스 전략 인사이트
   ├─ 조사팀 → 시장/경쟁 분석 데이터
   └─ 리더십팀 → 우선순위 방향
       ↓
2. 담당자 실무 (병렬)
   ├─ 시니어 PM → 전략 수립, PRD, 로드맵
   ├─ 주니어 PM → 리서치, 스토리, 분석
   └─ 애널리스트 → 메트릭, 시장 데이터
       ↓
3. 담당자 간 협력
   ├─ 시니어 PM ↔ 주니어 PM: PRD에 리서치 반영
   ├─ 시니어 PM ↔ 애널리스트: 로드맵에 메트릭 기반 우선순위 반영
   └─ 주니어 PM ↔ 애널리스트: 스토리에 데이터 기반 수용기준 반영
       ↓
4. 팀장 검토 및 검증
   ├─ PRD 검토: 요구사항 완성도, 테스트 가능성
   ├─ 로드맵 검토: 전략 정합성, 실현 가능성
   └─ 메트릭 검토: KPI 목표 적절성
       ↓
5. 보고 및 협업 전달
   ├─ → 기획팀: 스프린트 실행을 위한 요구사항 전달
   ├─ → 개발팀: 기술 구현 사양 전달
   ├─ → 디자인팀: UX 요구사항 전달
   └─ → 경영진: 전략 보고
```

## 🤖 AI 프롬프트 (역할별)

### PM Director
```
당신은 AI/SaaS 제품의 PM Director입니다.
제품 포트폴리오 전략을 수립하고, 팀의 PRD와 로드맵을 검토/승인합니다.
항상 비즈니스 성과 메트릭(MRR, NRR, Churn)을 기반으로 의사결정하세요.
안전성이 중요한 제품(약사 AI 등)에서는 안전 메트릭을 최우선으로 고려하세요.
```

### 시니어 PM
```
당신은 AI/SaaS 제품의 시니어 프로덕트 매니저입니다.
검증된 PM 프레임워크(RICE, Teresa Torres OST, Geoffrey Moore 포지셔닝)를 활용합니다.
PRD는 problem-statement → persona → solution → metrics → stories 순서로 작성하세요.
기능 우선순위는 항상 데이터 기반(RICE 점수)으로 결정하고 근거를 문서화하세요.
```

### 주니어 PM
```
당신은 AI/SaaS 제품의 주니어 프로덕트 매니저입니다.
사용자 리서치와 스토리 작성에 집중합니다.
유저 스토리는 Mike Cohn 포맷 + Gherkin 수용기준으로 작성하세요.
경쟁사 분석은 company-research 스킬의 구조를 따르세요.
```

### 프로덕트 애널리스트
```
당신은 SaaS 프로덕트 애널리스트입니다.
비즈니스 헬스를 성장/리텐션/유닛이코노믹스/자본효율 4개 축으로 진단합니다.
메트릭은 항상 벤치마크와 함께 제시하고, 스테이지별(Early/Growth/Scale) 기준을 적용하세요.
TAM/SAM/SOM 산정 시 반드시 가정과 출처를 명시하세요.
```

## 📊 팀 KPI

| KPI | 목표 | 측정 주기 |
|-----|------|----------|
| PRD 완성도 | 엔지니어링 재질문률 < 10% | 분기 |
| 로드맵 달성률 | 분기 로드맵 아이템 80% 이상 완료 | 분기 |
| 고객 발견 빈도 | 월 5회 이상 고객 인터뷰 | 월 |
| 우선순위 정확도 | RICE 기반 결정 비율 > 80% | 분기 |
| 제품-시장 적합성 | NPS > 40, 리텐션 > 80% | 분기 |
| 메트릭 커버리지 | 핵심 기능 100% 메트릭 추적 | 월 |

## 🔗 협업 부서

```
조사팀(Research) ──→ [시장 데이터, 경쟁 분석] ──→ 프로덕트 매니지먼트팀
전략팀(Strategy) ──→ [비즈니스 전략, GTM] ──→ 프로덕트 매니지먼트팀
프로덕트 매니지먼트팀 ──→ [PRD, 요구사항] ──→ 기획팀(Planning)
프로덕트 매니지먼트팀 ──→ [기술 사양] ──→ 개발팀(Development)
프로덕트 매니지먼트팀 ──→ [UX 요구사항] ──→ 디자인팀(Design)
프로덕트 매니지먼트팀 ──→ [제품 가치] ──→ 마케팅팀(Marketing)
퀄리티팀(Quality) ──→ [품질 피드백] ──→ 프로덕트 매니지먼트팀
추천엔진팀(Recommendation) ──→ [모델 성능 데이터] ──→ 프로덕트 매니지먼트팀
```

## 🛠 활용 스킬 (46개 PM Skills)

### Workflow (전략/장기 프로세스)
- `product-strategy-session` - 제품 전략 세션 (2-4주)
- `discovery-process` - 고객 발견 사이클 (3-4주)
- `prd-development` - PRD 작성 워크플로우 (2-4일)
- `roadmap-planning` - 로드맵 수립 (1-2주)
- `executive-onboarding-playbook` - VP/CPO 온보딩 (90일)

### Interactive (가이드형 의사결정)
- `prioritization-advisor` - 우선순위 프레임워크 선택
- `business-health-diagnostic` - SaaS 비즈니스 건강 진단
- `feature-investment-advisor` - 기능 투자 평가
- `tam-sam-som-calculator` - 시장 규모 산정
- `discovery-interview-prep` - 고객 인터뷰 준비
- `epic-breakdown-advisor` - 에픽 분해
- 그 외 14개

### Component (산출물 템플릿)
- `user-story` - 유저 스토리 (Mike Cohn + Gherkin)
- `positioning-statement` - 포지셔닝 (Geoffrey Moore)
- `press-release` - 프레스 릴리스 (Amazon Working Backwards)
- `problem-statement` - 문제 정의서
- `jobs-to-be-done` - JTBD 분석
- 그 외 15개
