# 학습 경로 프레임워크 (Learning Paths)

**Version**: v1.0 (2026.03.13)
**대상**: 전 부서 82명 담당자

---

## 학습 경로 설계 원칙

1. **갭 기반**: 자가진단 결과의 갭이 큰 스킬부터 우선
2. **실무 연동**: 학습 → 즉시 실무 적용 → 피드백 루프
3. **단계별 진행**: L1→L2→L3→L4 순차적 성장
4. **시간 제한**: 스킬당 최대 2주 (L1→L2), 4주 (L2→L3), 8주 (L3→L4)

---

## 레벨별 학습 방법

### L1 → L2 (인식 → 기초) | 2주

| 단계 | 활동 | 도구 |
|------|------|------|
| 1일차 | 스킬 SKILL.md 문서 정독 | Read 도구 |
| 2~3일차 | 예시(examples/) 실습 | 스킬 내 예시 파일 |
| 4~7일차 | 가이드 보며 실제 업무에 1회 적용 | 해당 커맨드 실행 |
| 8~14일차 | 동료 피어리뷰 + 피드백 반영 | 팀 내 공유 |

**완료 기준**: 가이드를 보면서 혼자 1회 이상 수행 완료

### L2 → L3 (기초 → 독립) | 4주

| 단계 | 활동 | 도구 |
|------|------|------|
| 1주차 | 가이드 없이 실무 적용 2회 | 직접 수행 |
| 2주차 | 다른 컨텍스트에서 적용 | 크로스 프로젝트 |
| 3주차 | 에지 케이스 처리 경험 | 실무 |
| 4주차 | 결과물 팀 내 발표 + 피드백 | 팀 미팅 |

**완료 기준**: 가이드 없이 3회 이상 독립 수행, 팀 내 발표 1회

### L3 → L4 (독립 → 전문) | 8주

| 단계 | 활동 | 도구 |
|------|------|------|
| 1~2주차 | 스킬 심화 연구 (원본 프레임워크 학습) | 외부 자료 |
| 3~4주차 | 팀 내 미니 워크숍 1회 진행 | `workshop-facilitation` |
| 5~6주차 | 스킬 개선 제안 or 커스터마이징 | `skill-creator` |
| 7~8주차 | 타 부서 대상 교육 1회 진행 | 크로스팀 세션 |

**완료 기준**: 워크숍 진행 2회 + 스킬 개선 PR 1건

---

## 부서별 우선 학습 경로

### 개발팀 (4명)

```
[신입 개발자 경로] — 12주
Week 1-2:  coding-standards (L1→L2)
Week 3-4:  tdd-workflow (L1→L2)
Week 5-8:  tdd-workflow (L2→L3) + /tdd 커맨드 실전
Week 9-10: api-design (L1→L2)
Week 11-12: security-review (L1→L2)
└→ 에이전트 활용: code-reviewer, tdd-guide

[시니어 경로] — 8주
Week 1-4:  security-review (L3→L4) + 보안팀 협업
Week 5-8:  coding-standards (L3→L4) + 팀 코딩 표준 워크숍 진행
```

### PM팀 (4명)

```
[주니어 PM 경로] — 12주
Week 1-2:  prd-development (L1→L2) + /write-prd 실습
Week 3-4:  user-story (L1→L2)
Week 5-8:  prd-development (L2→L3) + 실제 PRD 작성
Week 9-12: prioritization-advisor (L1→L3) + /prioritize 활용
└→ 에이전트 활용: product-manager, planner

[시니어 PM 경로] — 8주
Week 1-4:  product-strategy-session (L2→L3)
Week 5-8:  positioning-workshop (L2→L3) + 전략팀 합동 워크숍
```

### 디자인팀 (4명)

```
[UX 디자이너 경로] — 8주
Week 1-2:  lean-ux-canvas (L2→L3) + 실제 캔버스 작성
Week 3-4:  customer-journey-map (L2→L3) + 고객지원팀 협업
Week 5-6:  storyboard (L1→L2)
Week 7-8:  customer-journey-mapping-workshop (L2→L3)
└→ Figma MCP 활용

[UI 디자이너 경로] — 8주
Week 1-4:  frontend-design (L3→L4) + 개발팀 합동 리뷰
Week 5-8:  brand-guidelines (L3→L4) + 브랜드 가이드 워크숍
```

### 재무팀 (4명)

```
[IR 담당 경로] — 8주
Week 1-2:  saas-revenue-growth-metrics (L2→L3)
Week 3-4:  investor-materials (L3→L4) + 실제 IR 자료 제작
Week 5-6:  finance-metrics-quickref (L2→L3)
Week 7-8:  business-health-diagnostic (L2→L3)

[재무 모델링 경로] — 8주
Week 1-4:  saas-economics-efficiency-metrics (L3→L4)
Week 5-8:  tam-sam-som-calculator (L2→L3) + 전략팀 협업
```

### 조사팀 (4명)

```
[시장조사 분석가 경로] — 8주
Week 1-2:  market-research (L3→L4) + 리서치 워크숍 진행
Week 3-4:  tam-sam-som-calculator (L3→L4) + 재무팀 협업
Week 5-6:  discovery-interview-prep (L2→L3)
Week 7-8:  pestel-analysis (L2→L3)

[경쟁사 분석가 경로] — 8주
Week 1-4:  company-research (L3→L4) + 분석 프레임워크 워크숍
Week 5-8:  positioning-statement (L2→L3) + 전략팀 협업
```

### 마케팅팀 (4명)

```
[콘텐츠 마케터 경로] — 8주
Week 1-2:  content-engine (L3→L4) + 콘텐츠 전략 워크숍
Week 3-4:  article-writing (L3→L4) + 퍼블리싱 실습
Week 5-6:  press-release (L3→L4) + 실제 보도자료 작성
Week 7-8:  brand-guidelines (L2→L3) + 디자인팀 협업

[그로스 마케터 경로] — 8주
Week 1-4:  acquisition-channel-advisor (L2→L3) + 세일즈팀 협업
Week 5-8:  positioning-statement (L2→L3) + 전략팀 합동 세션
```

### 보안팀 (4명)

```
[보안 분석가 경로] — 8주
Week 1-2:  security-review (L3→L4) + 전사 보안 리뷰 가이드 작성
Week 3-4:  security-scan (L3→L4) + 자동화 파이프라인 구축
Week 5-6:  django-security (L3→L4) + 개발팀 보안 교육
Week 7-8:  springboot-security (L3→L4) + 개발팀 보안 교육
```

### 리더십팀 (4명)

```
[전략기획 담당 경로] — 8주
Week 1-2:  product-strategy-session (L2→L3) + 전략 세션 참관
Week 3-4:  business-health-diagnostic (L2→L3) + SaaS 진단 실습
Week 5-6:  altitude-horizon-framework (L2→L3) + 리더십 워크숍
Week 7-8:  executive-onboarding-playbook (L2→L3) + 온보딩 플레이북 작성

[의사결정 분석가 경로] — 8주
Week 1-2:  product-strategy-session (L1→L2) + 전략 문서 정독
Week 3-4:  business-health-diagnostic (L1→L2) + 진단 보고서 실습
Week 5-8:  altitude-horizon-framework (L2→L3) + strategic-compact (L1→L2)
└→ 에이전트 활용: chief-of-staff, planner
```

### 기획팀 (4명)

```
[PO 경로] — 12주
Week 1-2:  user-story (L2→L3) + /write-prd 실습
Week 3-4:  epic-breakdown-advisor (L2→L3) + 에픽 분해 실전
Week 5-8:  prd-development (L2→L3) + 실제 PRD 작성
Week 9-12: discovery-process (L2→L3) + 고객 인터뷰

[요구사항분석가 경로] — 8주
Week 1-2:  user-story (L2→L3) + 유저스토리 작성 실습
Week 3-4:  epic-breakdown-advisor (L1→L2) + 분해 실습
Week 5-8:  prioritization-advisor (L1→L2) + /prioritize 활용
└→ 에이전트 활용: planner, product-manager
```

### 전략팀 (4명)

```
[GTM 전략가 경로] — 8주
Week 1-2:  positioning-statement (L3→L4) + 포지셔닝 워크숍 진행
Week 3-4:  acquisition-channel-advisor (L3→L4) + 채널 분석 실전
Week 5-6:  finance-based-pricing-advisor (L2→L3)
Week 7-8:  pestel-analysis (L1→L2) + 조사팀 협업

[BM 분석가 경로] — 8주
Week 1-4:  saas-economics-efficiency-metrics (L3→L4) + 유닛 이코노믹스 워크숍
Week 5-8:  finance-based-pricing-advisor (L3→L4) + 재무팀 협업
└→ 에이전트 활용: planner
```

### 추천엔진팀 (5명)

```
[ML 엔지니어 경로] — 12주
Week 1-2:  cost-aware-llm-pipeline (L3→L4) + 비용 최적화 실전
Week 3-4:  eval-harness (L2→L3) + 평가 파이프라인 구축
Week 5-8:  python-testing (L3→L4) + TDD 적용
Week 9-12: agentic-engineering (L2→L3) + 에이전트 설계

[데이터 사이언티스트 경로] — 8주
Week 1-4:  eval-harness (L3→L4) + 평가 프레임워크 워크숍 진행
Week 5-8:  python-patterns (L3→L4) + 코드 품질 개선
└→ 에이전트 활용: code-reviewer, python-reviewer
```

### DevOps팀 (4명)

```
[CI/CD 엔지니어 경로] — 8주
Week 1-2:  deployment-patterns (L3→L4) + 배포 전략 워크숍
Week 3-4:  verification-loop (L3→L4) + 자동 검증 파이프라인
Week 5-6:  security-scan (L2→L3) + 보안팀 협업
Week 7-8:  database-migrations (L2→L3) + 마이그레이션 실전

[인프라 엔지니어 경로] — 8주
Week 1-4:  docker-patterns (L3→L4) + 컨테이너 최적화
Week 5-8:  deployment-patterns (L2→L3) + verification-loop (L1→L2)
└→ 에이전트 활용: build-error-resolver, architect
```

### 데이터 분석팀 (4명)

```
[BI 엔지니어 경로] — 8주
Week 1-2:  clickhouse-io (L3→L4) + ClickHouse 고급 쿼리 워크숍
Week 3-4:  postgres-patterns (L3→L4) + DB 최적화 실습
Week 5-6:  python-patterns (L3→L4) + 분석 자동화
Week 7-8:  saas-revenue-growth-metrics (L1→L2) + 재무팀 협업

[비즈니스 분석가 경로] — 8주
Week 1-4:  saas-revenue-growth-metrics (L3→L4) + 성장 지표 워크숍
Week 5-8:  business-health-diagnostic (L3→L4) + 전략팀 합동 분석
└→ 에이전트 활용: database-reviewer
```

### 퀄리티팀 (4명)

```
[테스트자동화 엔지니어 경로] — 8주
Week 1-2:  tdd-workflow (L3→L4) + TDD 워크숍 진행
Week 3-4:  e2e-testing (L3→L4) + E2E 자동화 구축
Week 5-6:  verification-loop (L2→L3) + DevOps팀 협업
Week 7-8:  plankton-code-quality (L2→L3) + 품질 메트릭 리뷰

[AI QA 전문가 경로] — 8주
Week 1-4:  eval-harness (L3→L4) + AI 평가 프레임워크 워크숍
Week 5-8:  tdd-workflow (L2→L3) + 추천엔진팀 협업
└→ 에이전트 활용: tdd-guide, e2e-runner
```

### 세일즈팀 (4명)

```
[파트너십 매니저 경로] — 8주
Week 1-2:  company-research (L3→L4) + 기업 분석 워크숍
Week 3-4:  investor-outreach (L2→L3) + 아웃리치 실전
Week 5-6:  positioning-statement (L2→L3) + 마케팅팀 협업
Week 7-8:  acquisition-channel-advisor (L2→L3) + 채널 전략 실습

[영업 담당 경로] — 8주
Week 1-4:  investor-outreach (L3→L4) + 영업 피칭 실전
Week 5-8:  customer-journey-map (L2→L3) + 고객지원팀 협업
```

### 고객지원팀 (4명)

```
[VOC 분석가 경로] — 8주
Week 1-2:  customer-journey-map (L3→L4) + 여정 맵 워크숍 진행
Week 3-4:  customer-journey-mapping-workshop (L3→L4) + 디자인팀 협업
Week 5-6:  jobs-to-be-done (L2→L3) + JTBD 인터뷰 실습
Week 7-8:  internal-comms (L1→L2) + 전사 커뮤니케이션 실습

[온보딩 전문가 경로] — 8주
Week 1-4:  customer-journey-map (L2→L3) + 온보딩 여정 설계
Week 5-8:  doc-coauthoring (L2→L3) + 문서화팀 협업
```

### 법무팀 (4명)

```
[의료기기 규제 전문가 경로] — 8주
Week 1-2:  pestel-analysis (L3→L4) + 규제 환경 분석 워크숍
Week 3-4:  company-research (L2→L3) + 규제 기관 리서치
Week 5-6:  doc-coauthoring (L2→L3) + 규제 문서 작성
Week 7-8:  security-review (L1→L2) + 보안팀 협업

[개인정보 전문가 경로] — 8주
Week 1-4:  security-review (L2→L3) + 보안팀 합동 리뷰
Week 5-8:  pestel-analysis (L2→L3) + 개인정보 규제 분석
```

### 문서화팀 (4명)

```
[테크니컬 라이터 경로] — 8주
Week 1-2:  doc-coauthoring (L3→L4) + 공동 문서 작성 워크숍
Week 3-4:  article-writing (L3→L4) + 기술 블로그 작성
Week 5-6:  skill-authoring-workflow (L2→L3) + 스킬 문서 작성
Week 7-8:  internal-comms (L2→L3) + 전사 문서 표준 제안

[지식관리 담당 경로] — 8주
Week 1-4:  continuous-learning (L3→L4) + 학습 패턴 워크숍
Week 5-8:  doc-coauthoring (L2→L3) + 지식 베이스 구축
└→ 에이전트 활용: doc-updater
```

### 토론팀 (5명)

```
[중립 담당자 경로] — 8주
Week 1-2:  problem-framing-canvas (L2→L3) + 문제 프레이밍 실습
Week 3-4:  recommendation-canvas (L3→L4) + 의사결정 워크숍 진행
Week 5-6:  workshop-facilitation (L2→L3) + 토론 진행 실습
Week 7-8:  pol-probe-advisor (L2→L3) + PoL 분석 실전

[찬성/반대 담당자 경로] — 8주
Week 1-4:  problem-framing-canvas (L2→L3) + 논증 구조화 실습
Week 5-8:  pestel-analysis (L1→L2) + pol-probe-advisor (L2→L3)
```

### 종합팀 (4명)

```
[통합 분석가 경로] — 8주
Week 1-2:  doc-coauthoring (L2→L3) + 크로스팀 문서 통합
Week 3-4:  skill-stocktake (L2→L3) + 전사 스킬 인벤토리 실습
Week 5-6:  continuous-learning-v2 (L2→L3) + 학습 시스템 구축
Week 7-8:  workshop-facilitation (L1→L2) + 종합 리포트 워크숍

[문서 편집 담당 경로] — 8주
Week 1-4:  doc-coauthoring (L3→L4) + 편집 품질 워크숍
Week 5-8:  internal-comms (L2→L3) + 문서화팀 협업
└→ 에이전트 활용: doc-updater
```

---

## 크로스팀 학습 프로그램

부서 간 협업을 통한 시너지 학습:

| 프로그램 | 참여 부서 | 스킬 | 주기 |
|---------|---------|------|------|
| **보안 부트캠프** | 개발 + 보안 + DevOps | `security-review`, `security-scan` | 월 1회 |
| **프로덕트 싱크** | PM + 기획 + 디자인 | `prd-development`, `lean-ux-canvas` | 격주 |
| **데이터 리터러시** | 전략 + 재무 + 데이터분석 | `saas-economics`, `tam-sam-som` | 월 1회 |
| **고객 인사이트** | 조사 + 세일즈 + 고객지원 | `customer-journey-map`, `discovery-process` | 월 1회 |
| **AI 스킬업** | 전 부서 AI 챔피언 20명 | `continuous-learning-v2`, `agentic-engineering` | 월 1회 |

---

## 학습 완료 인증

### 인증 기준

| 레벨 | 인증 방법 | 인증자 |
|:---:|----------|--------|
| L2 | 실무 적용 결과물 1건 제출 | 팀장 |
| L3 | 독립 수행 결과물 3건 + 팀 발표 1회 | 팀장 + 피어 |
| L4 | 워크숍 진행 2회 + 스킬 기여 1건 | 리더십팀 |

### 인증 보상

- L3 달성: 해당 스킬 **부서 내 담당자** 지정
- L4 달성: 해당 스킬 **전사 멘토** 지정 + AI 챔피언 후보
- 전 스킬 L3+: **부서 스킬 마스터** 칭호

---

## 학습 추적

### 개인 학습 로그 (월별)

```
이름: _______________
월: 2026년 __월

[학습 활동]
1. 스킬: _______________ | L_→L_ | 진행률: ___%
   - 이번 달 활동: _______________
   - 다음 달 계획: _______________

2. 스킬: _______________ | L_→L_ | 진행률: ___%
   - 이번 달 활동: _______________
   - 다음 달 계획: _______________

[크로스팀 참여]
- 프로그램: _______________ | 참석 여부: Y/N

[AI 도구 활용]
- 가장 많이 사용한 커맨드: _______________
- 가장 많이 사용한 에이전트: _______________
```
