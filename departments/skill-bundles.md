# 부서별 스킬 번들 (Skill Bundles by Department)

**Version**: v1.0 (2026.03.13)
**총 부서**: 20개 | **총 담당자**: 81명 | **매핑된 스킬**: 128개+

각 부서에 **필수 스킬 5~7개**를 배정. 숙련도 레벨(L1~L4)로 목표 수준을 명시.

> **레벨 기준**: L1 인식 → L2 기초 → L3 독립 수행 → L4 전문가/교육 가능

---

## 1. 리더십팀 (4명)

| 스킬 | 설명 | 팀장 | 전략기획 | 운영조율 | 의사결정분석 |
|------|------|:---:|:---:|:---:|:---:|
| `product-strategy-session` | 전략 세션 운영 | L4 | L3 | L2 | L3 |
| `executive-onboarding-playbook` | 리더 온보딩 30-60-90 | L4 | L3 | L3 | L2 |
| `business-health-diagnostic` | SaaS 비즈니스 진단 | L3 | L4 | L2 | L3 |
| `altitude-horizon-framework` | 전략적 시야 확장 | L4 | L3 | L2 | L3 |
| `strategic-compact` | 컨텍스트 관리 | L3 | L3 | L3 | L2 |
| `workshop-facilitation` | 워크숍 진행 | L3 | L2 | L3 | L2 |

**추천 에이전트**: `chief-of-staff`, `planner`
**추천 커맨드**: `/strategy`, `/plan`

---

## 2. 기획팀 (4명)

| 스킬 | 설명 | 팀장 | PM | PO | 요구사항분석 |
|------|------|:---:|:---:|:---:|:---:|
| `prd-development` | PRD 작성 | L4 | L4 | L3 | L3 |
| `roadmap-planning` | 로드맵 수립 | L4 | L3 | L3 | L2 |
| `user-story` | 유저스토리 작성 | L3 | L4 | L4 | L4 |
| `discovery-process` | 고객 발견 프로세스 | L3 | L3 | L3 | L2 |
| `prioritization-advisor` | 우선순위 프레임워크 | L3 | L3 | L3 | L2 |
| `epic-breakdown-advisor` | 에픽 분해 | L2 | L3 | L4 | L3 |

**추천 에이전트**: `planner`, `product-manager`
**추천 커맨드**: `/plan`, `/write-prd`, `/prioritize`

---

## 3. 프로덕트 매니지먼트팀 (4명)

| 스킬 | 설명 | PM Director | Sr PM | Jr PM | 분석가 |
|------|------|:---:|:---:|:---:|:---:|
| `product-strategy-session` | 전략 세션 | L4 | L3 | L2 | L2 |
| `prd-development` | PRD 작성 | L4 | L4 | L3 | L2 |
| `positioning-workshop` | 포지셔닝 워크숍 | L4 | L3 | L2 | L2 |
| `tam-sam-som-calculator` | 시장 규모 산정 | L3 | L3 | L2 | L4 |
| `business-health-diagnostic` | SaaS 진단 | L4 | L3 | L2 | L3 |
| `jobs-to-be-done` | JTBD 분석 | L3 | L4 | L3 | L2 |
| `opportunity-solution-tree` | OST 프레임워크 | L3 | L3 | L2 | L2 |

**추천 에이전트**: `product-manager`, `planner`
**추천 커맨드**: `/write-prd`, `/discover`, `/prioritize`, `/strategy`

---

## 4. 전략팀 (4명)

| 스킬 | 설명 | 팀장 | GTM전략가 | BM분석가 | 사업개발 |
|------|------|:---:|:---:|:---:|:---:|
| `product-strategy-session` | 전략 세션 | L4 | L3 | L3 | L2 |
| `positioning-statement` | 포지셔닝 | L3 | L4 | L2 | L3 |
| `acquisition-channel-advisor` | 채널 전략 | L3 | L4 | L3 | L3 |
| `finance-based-pricing-advisor` | 가격 전략 | L3 | L3 | L4 | L2 |
| `saas-economics-efficiency-metrics` | 유닛 이코노믹스 | L3 | L3 | L4 | L2 |
| `pestel-analysis` | PESTEL 분석 | L3 | L2 | L3 | L3 |
| `investor-materials` | 투자 자료 | L3 | L2 | L3 | L3 |

**추천 에이전트**: `planner`
**추천 커맨드**: `/strategy`, `/plan-roadmap`

---

## 5. 개발팀 (4명)

| 스킬 | 설명 | 팀장 | AI엔지니어 | FE | BE |
|------|------|:---:|:---:|:---:|:---:|
| `coding-standards` | 코딩 표준 | L4 | L3 | L3 | L3 |
| `tdd-workflow` | TDD 워크플로우 | L4 | L3 | L3 | L3 |
| `api-design` | API 설계 | L3 | L2 | L3 | L4 |
| `frontend-patterns` | FE 패턴 | L2 | L1 | L4 | L2 |
| `backend-patterns` | BE 패턴 | L2 | L2 | L2 | L4 |
| `security-review` | 보안 리뷰 | L3 | L3 | L2 | L3 |
| `docker-patterns` | Docker | L3 | L2 | L2 | L3 |

**추천 에이전트**: `code-reviewer`, `tdd-guide`, `architect`, `security-reviewer`
**추천 커맨드**: `/tdd`, `/code-review`, `/build-fix`, `/refactor-clean`

---

## 6. 추천엔진팀 (5명)

| 스킬 | 설명 | 팀장 | 데이터사이언티스트 | ML엔지니어 | 큐레이터 | 도메인전문가 |
|------|------|:---:|:---:|:---:|:---:|:---:|
| `python-patterns` | Python 패턴 | L3 | L4 | L4 | L2 | L1 |
| `python-testing` | Python 테스트 | L3 | L3 | L4 | L2 | L1 |
| `cost-aware-llm-pipeline` | LLM 비용 최적화 | L3 | L3 | L4 | L1 | L1 |
| `eval-harness` | 평가 프레임워크 | L3 | L4 | L3 | L2 | L3 |
| `postgres-patterns` | DB 패턴 | L3 | L3 | L3 | L3 | L1 |
| `agentic-engineering` | 에이전틱 엔지니어링 | L3 | L3 | L3 | L1 | L1 |

**추천 에이전트**: `code-reviewer`, `python-reviewer`, `database-reviewer`
**추천 커맨드**: `/tdd`, `/code-review`, `/eval`

---

## 7. DevOps팀 (4명)

| 스킬 | 설명 | 팀장 | 인프라 | CI/CD | 모니터링 |
|------|------|:---:|:---:|:---:|:---:|
| `docker-patterns` | Docker/Compose | L4 | L4 | L3 | L3 |
| `deployment-patterns` | 배포 패턴 | L4 | L3 | L4 | L3 |
| `database-migrations` | DB 마이그레이션 | L3 | L3 | L3 | L2 |
| `security-review` | 보안 리뷰 | L3 | L3 | L2 | L2 |
| `verification-loop` | 검증 루프 | L3 | L2 | L4 | L3 |
| `security-scan` | 보안 스캔 | L3 | L3 | L3 | L2 |

**추천 에이전트**: `build-error-resolver`, `architect`
**추천 커맨드**: `/build-fix`, `/verify`, `/quality-gate`

---

## 8. 디자인팀 (4명)

| 스킬 | 설명 | 팀장 | UX | UI | 프로토타이퍼 |
|------|------|:---:|:---:|:---:|:---:|
| `frontend-design` | FE 디자인 | L3 | L3 | L4 | L3 |
| `canvas-design` | 비주얼 디자인 | L3 | L2 | L4 | L3 |
| `lean-ux-canvas` | Lean UX | L3 | L4 | L2 | L3 |
| `customer-journey-map` | 고객 여정 맵 | L3 | L4 | L2 | L2 |
| `storyboard` | 스토리보드 | L2 | L3 | L2 | L4 |
| `brand-guidelines` | 브랜드 가이드 | L3 | L2 | L4 | L2 |

**추천 에이전트**: (없음 — Figma MCP 직접 활용)
**추천 커맨드**: (Figma MCP 도구 사용)

---

## 9. 데이터 분석팀 (4명)

| 스킬 | 설명 | 팀장 | 비즈분석 | 프로덕트분석 | BI엔지니어 |
|------|------|:---:|:---:|:---:|:---:|
| `clickhouse-io` | ClickHouse | L3 | L2 | L2 | L4 |
| `postgres-patterns` | PostgreSQL | L3 | L2 | L2 | L4 |
| `python-patterns` | Python | L2 | L3 | L3 | L4 |
| `saas-revenue-growth-metrics` | SaaS 성장 지표 | L3 | L4 | L3 | L2 |
| `business-health-diagnostic` | 비즈니스 진단 | L3 | L4 | L3 | L2 |
| `tam-sam-som-calculator` | 시장 규모 | L2 | L3 | L2 | L1 |

**추천 에이전트**: `database-reviewer`
**추천 커맨드**: `/eval`

---

## 10. 퀄리티팀 (4명)

| 스킬 | 설명 | 팀장 | QA | 자동화 | AI QA |
|------|------|:---:|:---:|:---:|:---:|
| `tdd-workflow` | TDD | L4 | L3 | L4 | L3 |
| `e2e-testing` | E2E 테스트 | L3 | L4 | L4 | L2 |
| `webapp-testing` | 웹앱 테스트 | L3 | L4 | L3 | L2 |
| `verification-loop` | 검증 루프 | L4 | L3 | L3 | L3 |
| `eval-harness` | 평가 프레임워크 | L3 | L2 | L2 | L4 |
| `plankton-code-quality` | 코드 품질 | L3 | L3 | L3 | L2 |

**추천 에이전트**: `tdd-guide`, `e2e-runner`
**추천 커맨드**: `/tdd`, `/e2e`, `/verify`, `/quality-gate`, `/test-coverage`

---

## 11. 보안팀 (4명)

| 스킬 | 설명 | 팀장 | 보안분석 | 개인정보 | 컴플라이언스 |
|------|------|:---:|:---:|:---:|:---:|
| `security-review` | 보안 리뷰 | L4 | L4 | L3 | L3 |
| `security-scan` | 보안 스캔 | L4 | L4 | L2 | L2 |
| `django-security` | Django 보안 | L3 | L4 | L1 | L1 |
| `springboot-security` | Spring 보안 | L3 | L4 | L1 | L1 |
| `coding-standards` | 코딩 표준 | L3 | L3 | L1 | L2 |

**추천 에이전트**: `security-reviewer`
**추천 커맨드**: `/code-review`, `/verify`

---

## 12. 마케팅팀 (4명)

| 스킬 | 설명 | 팀장 | 콘텐츠 | 그로스 | 브랜드 |
|------|------|:---:|:---:|:---:|:---:|
| `content-engine` | 콘텐츠 시스템 | L3 | L4 | L2 | L3 |
| `article-writing` | 아티클 작성 | L2 | L4 | L2 | L3 |
| `brand-guidelines` | 브랜드 가이드 | L3 | L3 | L2 | L4 |
| `positioning-statement` | 포지셔닝 | L3 | L2 | L3 | L4 |
| `press-release` | 보도자료 | L3 | L4 | L2 | L3 |
| `investor-outreach` | 투자자 커뮤니케이션 | L3 | L2 | L3 | L2 |

**추천 에이전트**: (없음)
**추천 커맨드**: (없음)

---

## 13. 세일즈팀 (4명)

| 스킬 | 설명 | 팀장 | 파트너십 | 영업 | CRM |
|------|------|:---:|:---:|:---:|:---:|
| `investor-outreach` | 아웃리치 템플릿 | L3 | L3 | L4 | L2 |
| `company-research` | 기업 리서치 | L3 | L4 | L3 | L2 |
| `positioning-statement` | 포지셔닝 | L3 | L3 | L3 | L2 |
| `acquisition-channel-advisor` | 채널 전략 | L3 | L3 | L3 | L3 |
| `customer-journey-map` | 고객 여정 | L2 | L2 | L3 | L3 |

**추천 에이전트**: (없음)
**추천 커맨드**: `/discover`

---

## 14. 고객지원팀 (4명)

| 스킬 | 설명 | 팀장 | CS매니저 | VOC | 온보딩 |
|------|------|:---:|:---:|:---:|:---:|
| `customer-journey-map` | 고객 여정 | L3 | L3 | L4 | L3 |
| `customer-journey-mapping-workshop` | 여정 워크숍 | L3 | L2 | L4 | L2 |
| `internal-comms` | 내부 커뮤니케이션 | L3 | L3 | L2 | L3 |
| `jobs-to-be-done` | JTBD | L2 | L2 | L3 | L2 |
| `doc-coauthoring` | 문서 공동 작성 | L2 | L2 | L2 | L3 |

**추천 에이전트**: (없음)
**추천 커맨드**: `/discover`

---

## 15. 재무팀 (4명)

| 스킬 | 설명 | CFO | IR | 재무모델링 | 회계 |
|------|------|:---:|:---:|:---:|:---:|
| `finance-metrics-quickref` | 재무 지표 참조 | L4 | L3 | L4 | L3 |
| `saas-economics-efficiency-metrics` | SaaS 이코노믹스 | L4 | L3 | L4 | L2 |
| `saas-revenue-growth-metrics` | 매출 성장 지표 | L4 | L4 | L4 | L2 |
| `investor-materials` | 투자 자료 | L3 | L4 | L3 | L2 |
| `business-health-diagnostic` | 비즈니스 진단 | L4 | L3 | L3 | L2 |
| `tam-sam-som-calculator` | 시장 규모 | L3 | L3 | L3 | L1 |

**추천 에이전트**: (없음)
**추천 커맨드**: `/strategy`

---

## 16. 법무팀 (4명)

| 스킬 | 설명 | 팀장 | 의료기기 | 개인정보 | 계약/IP |
|------|------|:---:|:---:|:---:|:---:|
| `security-review` | 보안 리뷰 | L2 | L2 | L3 | L1 |
| `company-research` | 기업/규제 리서치 | L3 | L3 | L3 | L3 |
| `doc-coauthoring` | 문서 공동 작성 | L3 | L3 | L3 | L3 |
| `internal-comms` | 내부 커뮤니케이션 | L3 | L2 | L2 | L3 |
| `pestel-analysis` | PESTEL (규제 환경) | L3 | L4 | L3 | L2 |

**추천 에이전트**: (없음)
**추천 커맨드**: (없음)

---

## 17. 조사팀 (4명)

| 스킬 | 설명 | 팀장 | 시장조사 | 경쟁사 | 트렌드 |
|------|------|:---:|:---:|:---:|:---:|
| `market-research` | 시장 조사 | L4 | L4 | L3 | L3 |
| `company-research` | 기업 리서치 | L3 | L3 | L4 | L2 |
| `tam-sam-som-calculator` | TAM/SAM/SOM | L3 | L4 | L2 | L2 |
| `pestel-analysis` | PESTEL | L3 | L3 | L3 | L4 |
| `positioning-statement` | 포지셔닝 | L2 | L2 | L3 | L2 |
| `discovery-interview-prep` | 인터뷰 준비 | L3 | L3 | L2 | L3 |

**추천 에이전트**: (없음)
**추천 커맨드**: `/discover`

---

## 18. 문서화팀 (4명)

| 스킬 | 설명 | 팀장 | 테크라이터 | 프로세스 | 지식관리 |
|------|------|:---:|:---:|:---:|:---:|
| `doc-coauthoring` | 문서 공동 작성 | L4 | L4 | L3 | L3 |
| `article-writing` | 아티클 작성 | L3 | L4 | L2 | L2 |
| `internal-comms` | 내부 커뮤니케이션 | L3 | L3 | L4 | L3 |
| `skill-authoring-workflow` | 스킬 문서화 | L4 | L3 | L3 | L3 |
| `continuous-learning` | 학습 패턴 추출 | L3 | L2 | L2 | L4 |

**추천 에이전트**: `doc-updater`
**추천 커맨드**: `/update-docs`, `/learn`

---

## 19. 토론팀 (5명)

| 스킬 | 설명 | 팀장 | 찬성 | 반대 | 중립 | 전문가 |
|------|------|:---:|:---:|:---:|:---:|:---:|
| `problem-framing-canvas` | 문제 프레이밍 | L4 | L3 | L3 | L3 | L3 |
| `recommendation-canvas` | 추천 캔버스 | L3 | L3 | L3 | L4 | L3 |
| `pestel-analysis` | PESTEL | L2 | L2 | L3 | L3 | L3 |
| `workshop-facilitation` | 워크숍 진행 | L4 | L2 | L2 | L3 | L2 |
| `pol-probe-advisor` | PoL 프로브 | L3 | L3 | L4 | L3 | L3 |

**추천 에이전트**: (없음)
**추천 커맨드**: `/strategy`

---

## 20. 종합팀 (4명)

| 스킬 | 설명 | 팀장 | 통합분석 | 인사이트 | 문서편집 |
|------|------|:---:|:---:|:---:|:---:|
| `doc-coauthoring` | 문서 공동 작성 | L4 | L3 | L3 | L4 |
| `internal-comms` | 내부 커뮤니케이션 | L3 | L3 | L3 | L3 |
| `workshop-facilitation` | 워크숍 진행 | L3 | L2 | L2 | L2 |
| `skill-stocktake` | 스킬 인벤토리 | L3 | L3 | L2 | L2 |
| `continuous-learning-v2` | 인스팅트 학습 | L3 | L3 | L3 | L2 |

**추천 에이전트**: `doc-updater`
**추천 커맨드**: `/learn`, `/update-docs`

---

## 전사 공통 필수 스킬 (84명 전원)

모든 담당자가 **L2 이상** 달성해야 하는 기본 스킬:

| 스킬 | 설명 | 목표 레벨 |
|------|------|:---:|
| `continuous-learning-v2` | AI 인스팅트 학습 | L2 |
| `search-first` | 검색 우선 워크플로우 | L2 |
| `workshop-facilitation` | 워크숍 참여 | L2 |
| `internal-comms` | 내부 커뮤니케이션 | L2 |
| `doc-coauthoring` | 문서 공동 작성 | L2 |

---

## 다음 단계

1. **스킬 갭 자가진단**: 각 담당자가 현재 레벨 자가 평가
2. **학습 경로 생성**: 갭 기반 개인별 학습 플랜
3. **AI 챔피언 선정**: 부서당 1명, 스킬 활용 촉진
4. **분기별 리포트**: 숙련도 변화 추적
