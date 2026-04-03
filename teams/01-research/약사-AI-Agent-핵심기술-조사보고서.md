# 약사 AI Agent 핵심 기술 조사 보고서

**작성자:** 기술 연구원 (조사팀)
**작성일:** 2026-02-20
**문서 분류:** 기술 조사 보고서

---

## 목차

1. [LLM 기반 약물 상호작용 분석](#1-llm-기반-약물-상호작용-분석)
2. [NLP 기반 처방전 분석 (OCR + NLP 파이프라인)](#2-nlp-기반-처방전-분석)
3. [약물 데이터베이스 연동](#3-약물-데이터베이스-연동)
4. [복약지도 자동화 기술](#4-복약지도-자동화-기술)
5. [약물 이상반응(ADR) 예측 AI](#5-약물-이상반응adr-예측-ai)
6. [RAG 활용 가능성](#6-rag-활용-가능성)
7. [AI 의료기기 인허가 기술 요구사항](#7-ai-의료기기-인허가-기술-요구사항)
8. [기술 성숙도(TRL) 평가](#8-기술-성숙도trl-평가)
9. [종합 결론 및 권고사항](#9-종합-결론-및-권고사항)

---

## 1. LLM 기반 약물 상호작용 분석

### 1.1 현재 기술 수준

대규모 언어 모델(LLM)을 활용한 약물-약물 상호작용(DDI, Drug-Drug Interaction) 예측은 2025-2026년 사이에 급격한 발전을 보이고 있다.

#### 핵심 연구 결과

| 모델/접근법 | 정확도 | 민감도 | 비고 |
|---|---|---|---|
| Phi-3.5 (2.7B) 파인튜닝 | 0.919 | 0.978 | 균형 데이터셋 기준 |
| BioBERT + 구조적 특성 융합 | 0.9655 (분류 정확도) | - | 다중모달 프레임워크 |
| Zero-shot LLM (평균) | - | 0.5463 | 사전 학습만으로는 제한적 |
| 기존 ML 기법 대비 | 개선 | 개선 | 파인튜닝 시 우위 |

- **Zero-shot 한계:** LLM을 그대로 사용할 경우 DDI 예측의 평균 민감도가 0.5463에 불과하여, 임상 적용에는 부적합하다.
- **파인튜닝의 효과:** 소형 모델(Phi-3.5, 2.7B 파라미터)도 파인튜닝 후 민감도 0.978, 정확도 0.919를 달성하여 대형 모델보다 우수한 성능을 보였다.
- **다중모달 융합:** BioBERT 임베딩과 분자 구조적 특성을 결합한 프레임워크가 최고 분류 정확도(0.9655)를 달성하여, 도메인 특화 언어 모델의 약리학적 의미 인코딩 역량이 검증되었다.

#### In-Context Learning 접근법
최근 연구에서는 LLM의 문맥 내 학습(In-Context Learning)과 판단(Judging) 능력을 활용하여 DDI 예측 정확도를 개선하는 방법이 제안되었다. 이는 파인튜닝 없이도 적절한 프롬프트 설계만으로 성능을 향상시킬 수 있는 가능성을 보여준다.

### 1.2 약사 AI Agent 적용 시사점

- 약물 상호작용 확인은 약사 AI의 **핵심 기능**으로, 현재 기술 수준(파인튜닝 기준 정확도 92% 이상)은 보조 도구로서 충분히 활용 가능한 수준이다.
- 다만, 최종 판단은 반드시 약사(인간)의 검증을 거치는 **"Co-pilot" 모드**가 권장된다.
- 지식 그래프(Knowledge Graph) 기반 LLM-DDI 접근법은 생물의학 지식 그래프와 LLM을 결합하여 더욱 정교한 예측이 가능하다.

### 출처
- [LLMs for Drug-Drug Interaction Prediction: A Comprehensive Comparison (arXiv, 2025)](https://arxiv.org/abs/2502.06890)
- [LLM-Enhanced Multimodal Framework for DDI Prediction (MDPI, 2025)](https://www.mdpi.com/2227-9059/13/10/2355)
- [Improving DDI Prediction via In-Context Learning (Frontiers, 2025)](https://www.frontiersin.org/journals/pharmacology/articles/10.3389/fphar.2025.1589788/full)
- [LLM-DDI on Biomedical Knowledge Graph (PubMed, 2025)](https://pubmed.ncbi.nlm.nih.gov/40601466/)
- [ML Models for DDI: From Discovery to Clinical Application (Nature, 2026)](https://www.nature.com/articles/s41746-026-02400-3)

---

## 2. NLP 기반 처방전 분석

### 2.1 OCR + NLP 파이프라인 아키텍처

```
[처방전 이미지/스캔]
    --> [전처리(노이즈 제거, 회전 보정)]
    --> [OCR 엔진(텍스트 추출)]
    --> [NLP 파이프라인(개체명 인식, 관계 추출)]
    --> [약물명/용량/용법 구조화]
    --> [검증 및 교차 확인]
    --> [구조화된 처방 데이터]
```

### 2.2 현재 기술 수준

#### OCR 기술
- **비전 모델 기반 OCR:** 최신 비전 모델은 불명확한 필기체와 비정형 서식의 처방전도 높은 정확도로 인식 가능하다.
- **약학 문서 AI 벤치마크:** 제약 분야 문서 AI 및 OCR 정확도에 대한 벤치마크 분석이 활발히 수행되고 있다.
- **낱알 식별:** 한국 식약처의 의약품 낱알식별 정보 API를 통해 OCR로 인식된 알약 외형 정보와 매칭이 가능하다.

#### NLP 기술
- **개체명 인식(NER):** 약물명, 용량, 투여 경로, 투여 빈도 등의 핵심 정보를 자동 추출한다.
- **관계 추출:** 약물-용량, 약물-적응증 간 관계를 자동으로 파악한다.
- **임상 의사결정 지원:** 환자의 병력, 현재 복용 약물, 검사 결과, 알레르기, 잠재적 약물 상호작용을 자동으로 분석할 수 있다.

### 2.3 실세계 성과

| 지표 | 개선율 | 출처 |
|---|---|---|
| 약물 순응도(Drug Adherence) 향상 | 40% | 지역약국 AI 도입 사례 |
| 처방 누락 리필 감소 | 55% | 지역약국 AI 도입 사례 |
| 처방 배포 오류 감소 | 75% | 병원 AI 도입 사례 |
| 이상약물반응 탐지 향상 | 65% | 병원 AI 도입 사례 |
| 처방 처리 혁신적 검증 도구 채택률 | 73% | 미국 병원 |

### 2.4 약사 AI Agent 적용 시사점

- 한국의 전자처방전 시스템(DUR 등)과 연계 시, OCR 필요 없이 구조화된 데이터를 바로 수신할 수 있어 정확도가 극대화된다.
- 수기 처방전이나 해외 처방전 처리를 위한 OCR+NLP 파이프라인은 부가 기능으로 구현 가능하다.
- 처방전 분석 후 자동으로 약물 상호작용 검사, 용량 적절성 평가를 연계하는 통합 파이프라인이 핵심이다.

### 출처
- [Pharma Document AI & OCR Accuracy: A Benchmark Analysis (IntuitionLabs)](https://intuitionlabs.ai/pdfs/pharma-document-ai-ocr-accuracy-a-benchmark-analysis.pdf)
- [AI-Based OCR System for Handwritten Medical Prescription Recognition (ResearchGate, 2025)](https://www.researchgate.net/publication/395110562_AI-Based_OCR_System_for_Handwritten_Medical_Prescription_Recognition_and_Interpretation)
- [AI in Clinical Pharmacy: Systematic Review (PMC, 2025)](https://pmc.ncbi.nlm.nih.gov/articles/PMC12553886/)
- [Clinical and Operational Applications of AI/ML in Pharmacy (PMC, 2025)](https://pmc.ncbi.nlm.nih.gov/articles/PMC11932220/)
- [Top 3 AI Pharmacists in 2026 (Sully.ai)](https://www.sully.ai/blog/top-3-ai-pharmacists-in-2025)

---

## 3. 약물 데이터베이스 연동

### 3.1 주요 데이터베이스 비교

| 데이터베이스 | 국가/기관 | 주요 내용 | API 제공 | 활용도 |
|---|---|---|---|---|
| **DrugBank** | 캐나다 | 약물 정보, 상호작용, 타겟, 대사경로 | REST API (상용) | 글로벌 표준 |
| **KEGG DRUG** | 일본 | 승인 약물 정보, 대사경로, 분자 네트워크 | REST API (공개) | 경로 분석 |
| **의약품안전나라** | 한국 식약처 | 국내 허가 의약품 정보, DUR 정보 | Open API (공개) | 국내 필수 |
| **식의약 데이터 포털** | 한국 식약처 | 식품/의약품 종합 데이터 | Open API (공개) | 국내 보조 |
| **e약은요** | 한국 식약처 | 일반의약품 제품 개요 정보 | Open API (공개) | 일반의약품 |
| **PubChem** | 미국 NIH | 화학 물질/생물학적 활성 정보 | REST API (공개) | 화학 정보 |

### 3.2 한국 공공데이터 API 현황

식약처는 다음과 같은 의약품 관련 Open API를 제공하고 있다:

1. **의약품 제품 허가정보:** 품목, 주성분, 제조원, 포장단위, 저장방법, 성상, 허가일자, 허가번호 (XML/JSON)
2. **의약품개요정보(e약은요):** 일반의약품 중 공급실적이 있는 제품의 주요 정보
3. **의약품 낱알식별 정보:** 낱알(알약) 식별에 필요한 기본 정보 (모양, 색상, 마크 등)
4. **DUR(Drug Utilization Review) 정보:** 약물 상호작용, 연령금기, 임부금기 등

### 3.3 데이터 연동 아키텍처 제안

```
[약사 AI Agent Core]
    |
    ├── [한국 의약품 DB 레이어]
    |     ├── 의약품안전나라 API (국내 허가 정보, DUR)
    |     ├── 식의약 데이터 포털 API
    |     └── 건강보험심사평가원 API (급여 정보)
    |
    ├── [글로벌 약물 DB 레이어]
    |     ├── DrugBank API (상호작용, 약물 타겟)
    |     ├── KEGG DRUG API (대사경로, 분자 네트워크)
    |     └── PubChem API (화학 구조, 생물학적 활성)
    |
    └── [크로스매핑 레이어]
          └── 약물 ID 통합 매핑 (DrugBank ID <-> KEGG ID <-> 식약처 품목코드)
```

### 3.4 약사 AI Agent 적용 시사점

- 한국 시장을 위해서는 **식약처 의약품안전나라 API가 필수적**이며, DUR 정보를 통한 약물 상호작용 검사가 핵심이다.
- DrugBank와 KEGG는 글로벌 수준의 약물 정보와 대사경로 분석을 제공하므로 **보완적으로 활용**해야 한다.
- 크로스매핑 레이어를 통해 국내외 약물 ID를 통합 관리하는 것이 중요하다.

### 출처
- [DrugBank API Reference](https://docs.drugbank.com/)
- [KEGG DRUG Database](https://www.genome.jp/kegg/drug/)
- [의약품안전나라 공공데이터](https://nedrug.mfds.go.kr/cntnts/80)
- [식의약 데이터 포털](https://data.mfds.go.kr/)
- [공공데이터포털 - 의약품개요정보](https://www.data.go.kr/data/15075057/openapi.do)
- [Drug ID Mapping (GitHub)](https://github.com/iit-Demokritos/drug_id_mapping)

---

## 4. 복약지도 자동화 기술

### 4.1 현재 기술 현황

#### 다국어 지원
- AI 기반 실시간 번역 기술을 활용한 다국어 복약지도가 구현 가능한 단계이다.
- Harmoni와 같은 HIPAA 준수 AI 의료 커뮤니케이션 솔루션은 텍스트 및 음성에 대한 실시간 번역을 제공하며, 약국 환경에서 다국어 커뮤니케이션을 지원한다.
- 의약품 설명, 부작용, 복용 방법 등의 표준화된 약학 용어에 대한 다국어 데이터베이스 구축이 진행 중이다.

#### 고령자 맞춤형 기술
- **음성 기반 인터페이스:** 음성 어시스턴트를 통한 복약 안내 및 리마인더 기능이 활성화되고 있다.
- **인지 장애 대응:** 인지 장애가 있는 개인을 위한 커뮤니케이션 스타일 자동 조절 기술이 개발되었다.
- **복약 순응도 향상:** 캘리포니아 소재 시니어 케어 네트워크에서 음성 어시스턴트 도입 후 복약 순응도가 **22% 향상**된 사례가 보고되었다.

#### AI 기반 약물 관리 자동화
- AI 알고리즘이 환자의 연령, 신장 기능, 잠재적 약물 상호작용 등을 고려하여 최적의 복약 스케줄을 산출한다.
- 자동 복약 리마인더, 보호자 알림, 건강 위험 모니터링 기능이 통합된 솔루션이 등장하고 있다.

### 4.2 시장 전망

- AI 기반 고령자 케어 솔루션 시장은 2025~2030년 사이 **연평균 성장률(CAGR) 약 9.73%**로 성장하여, 2030년까지 약 **22.5억 달러(약 3조 원)** 규모에 도달할 전망이다.

### 4.3 주요 과제

- **환각(Hallucination) 문제:** LLM 기반 도구의 환각 비율이 2025년 초 기준 **5%~30%**로 추정되며, 의약 정보에서의 오류는 치명적일 수 있다.
- **개인화 수준:** 환자의 건강 상태, 복용 약물 목록, 생활 습관을 종합적으로 고려한 초개인화 복약지도가 요구된다.
- **접근성:** 고령자의 디지털 리터러시 격차를 고려한 UI/UX 설계가 필수적이다.

### 4.4 약사 AI Agent 적용 시사점

- 복약지도 자동 생성 시 **환각 방지를 위한 RAG 기반 접근**이 필수적이다.
- 고령자를 위한 **대형 글씨, 음성 출력, 그림/픽토그램** 활용이 권장된다.
- 다국어 지원은 한국 거주 외국인 및 다문화 가정을 위해 **영어, 중국어, 베트남어, 태국어** 등을 우선 지원해야 한다.

### 출처
- [AI Healthcare Assistant for Seniors in 2025](https://3bhealthcare.us/ai-healthcare-assistant-for-seniors-2025/)
- [AI-based Tools for Patient Support to Enhance Medication Adherence (Frontiers, 2025)](https://www.frontiersin.org/journals/digital-health/articles/10.3389/fdgth.2025.1523070/full)
- [AI in Medication Management for Older Adults (PMC, 2025)](https://pmc.ncbi.nlm.nih.gov/articles/PMC12576577/)
- [AI Telepharmacy: Extends Care Access (Harmoni)](https://harmonitranslate.com/blog/ai-telepharmacy-remote-access.html)
- [Redefining Elderly Care with Agentic AI (arXiv, 2025)](https://arxiv.org/html/2507.14912v1)

---

## 5. 약물 이상반응(ADR) 예측 AI

### 5.1 최신 연구 동향

#### 딥러닝 기반 접근법

| 기술/모델 | 성능 | 주요 특징 |
|---|---|---|
| CNN (합성곱 신경망) | 정확도 85% | 로지스틱 회귀(78%), SVM(80%) 대비 우위 |
| PreciseADR (이종 GNN) | 환자 수준 ADR 예측 | 환자-질병-약물-ADR 관계 통합 |
| 융합 딥러닝 모델 | ROC-AUC 0.7002, AUPR 0.6619 | 4개 모듈 통합 (1D/2D 분자 구조, 약물-단백질 상호작용, 약물 유사성) |
| SVM + Morgan Fingerprints | AUC-PR 0.75 | 대사/영양 장애 ADR 특화 |
| 하이브리드 AI 프레임워크 | 65% 이상 효율 향상 | 구조화+비구조화 데이터 통합 (NLP) |

#### 주요 기술 발전

1. **이종 그래프 신경망(Heterogeneous GNN):** PreciseADR은 환자, 질병, 약물, ADR 간의 복잡한 관계를 그래프로 모델링하여 환자 수준의 ADR을 예측한다. 기존 방법의 한계를 극복하는 새로운 접근법이다.

2. **다차원 융합 모델:** 약물의 1차원/2차원 분자 구조 정보, 약물-단백질 상호작용 데이터, 약물 유사성 데이터를 4개 모듈로 추출하고 융합하여 ADR 확률을 예측한다. AUPR이 34.65%에서 68.82%로 대폭 개선되었다.

3. **해석 가능한 AI(Interpretable AI):** 버밍엄 대학교(2026년) 연구에서 수백만 건의 실세계 안전성 보고서와 최신 약리학 데이터베이스를 활용한 해석 가능한 ML 프레임워크를 개발했다. 약물이 생물학적 타겟과 어떻게 상호작용하는지 분석하여 부작용을 예측한다.

4. **AI 기반 약물감시(Pharmacovigilance):** 랜덤 포레스트, 그래디언트 부스팅 머신, CNN 등을 활용한 고급 약물감시 시스템이 개발되고 있으며, 구조화 데이터(환자 인구통계, 검사 결과)와 비구조화 데이터(임상 노트)를 통합하여 ADR을 탐지한다.

### 5.2 약사 AI Agent 적용 시사점

- ADR 예측은 약사 AI Agent의 **핵심 안전 기능**으로, 처방 검토 시 자동으로 ADR 위험을 평가하고 경고를 제공해야 한다.
- **환자별 맞춤 예측**을 위해 연령, 성별, 신장/간 기능, 유전적 요인을 고려하는 모델이 필요하다.
- 해석 가능한 AI 접근법을 채택하여 약사가 **경고의 근거를 이해**할 수 있도록 해야 한다.

### 출처
- [AI-driven Pharmacovigilance: Enhancing ADR Detection (ScienceDirect, 2025)](https://www.sciencedirect.com/science/article/pii/S221501612500305X)
- [Fusion Deep Learning Model for Predicting ADR (PMC, 2025)](https://pmc.ncbi.nlm.nih.gov/articles/PMC11944162/)
- [PreciseADR: Heterogeneous GNN (Wiley, 2025)](https://advanced.onlinelibrary.wiley.com/doi/10.1002/advs.202404671)
- [ML Framework for Drug Side Effects Prediction (Univ. of Birmingham, 2026)](https://www.birmingham.ac.uk/news/2026/machinelearning-framework-could-transform-prediction-of-drug-side-effects)
- [Interpretable ML Framework for ADR Prediction (PMC, 2025)](https://pmc.ncbi.nlm.nih.gov/articles/PMC12858017/)

---

## 6. RAG (Retrieval-Augmented Generation) 활용 가능성

### 6.1 약학 분야 RAG 현황

#### DrugRAG -- 약학 특화 RAG 파이프라인

**DrugRAG**는 2025년 12월에 발표된 약학 LLM 성능 향상을 위한 3단계 RAG 파이프라인이다.

**아키텍처:**
```
[임상 질의]
    --> [Step 1: o3 모델 - 3~6개 핵심 추론 용어 추출]
    --> [Step 2: Medical Chat API를 통한 의약 근거 검색]
    --> [Step 3: 구조화된 근거 스니펫으로 프롬프트 증강]
    --> [타겟 LLM - 최종 임상 답변 생성]
```

**성능 벤치마크 결과 (141문항 약학 데이터셋):**

| 모델 | 기본 정확도 | DrugRAG 적용 후 | 개선폭 |
|---|---|---|---|
| GPT-5 | 92% | 향상 | +α |
| o3 | 89% | 향상 | +α |
| Gemma 3 27B | 61% | 71% | +10%p |
| Llama 3.1 8B | 46% | 67% | +21%p |

- **핵심 장점:** 모델 아키텍처나 가중치 수정 없이 외부에서 작동하므로, 어떤 LLM에도 적용 가능하다.
- **개선 범위:** 모든 테스트 모델에서 7~21% 포인트의 정확도 향상을 달성했다.

#### 약물 부작용 검색을 위한 RAG 아키텍처

2025년 7월에 발표된 연구에서는 약물 부작용 검색에 특화된 RAG 아키텍처가 제안되었으며, LLM의 부작용 정보 제공 정확도를 크게 향상시켰다.

### 6.2 RAG의 약학 분야 핵심 장점

1. **최신 정보 반영:** 새로운 FDA/식약처 가이드라인, 최신 논문, 업데이트된 SOP를 재학습 없이 즉시 반영 가능하다.
2. **도메인 지식 주입:** 일반 LLM에 약학 전문 지식을 재학습 없이 주입할 수 있다.
3. **환각 감소:** 검증된 외부 소스에서 검색한 근거를 기반으로 답변을 생성하므로 환각이 크게 줄어든다.
4. **추적 가능성:** 답변의 근거 출처를 명시할 수 있어 약사의 검증이 용이하다.

### 6.3 실세계 성과

- 약물감시 영역에서 RAG 적용 시 **65% 이상의 효율 향상** 및 **90% 이상의 데이터 추출 정확도**를 달성했다.
- 2022~2024년 바이오메디컬 도메인 벤치마크에서 RAG 강화 모델이 비검색 모델보다 일관되게 높은 정확도를 보였다.

### 6.4 한계점

- **복합 시나리오 한계:** RAG 강화 모델도 복잡한 환자 사례(Patient Case Vignettes)에서는 단순 사실 기반 질문 대비 성능이 떨어진다.
- **검색 품질 의존성:** RAG의 성능은 검색 데이터베이스의 품질과 검색 알고리즘의 정확도에 크게 의존한다.

### 6.5 약사 AI Agent 적용 시사점

- **RAG는 약사 AI Agent의 핵심 아키텍처로 채택해야 한다.** 약학 지식의 빈번한 업데이트(신약 승인, 가이드라인 변경 등)를 고려하면 RAG 없이는 최신성을 유지하기 어렵다.
- 국내 약학 문서(식약처 허가사항, 대한약전, 복약지도 가이드라인)를 RAG 지식 베이스로 구축해야 한다.
- DrugRAG의 3단계 파이프라인을 참조하여 국내 환경에 맞는 맞춤형 RAG 파이프라인을 설계할 것을 권장한다.

### 출처
- [DrugRAG: Enhancing Pharmacy LLM Performance (arXiv, 2025)](https://arxiv.org/abs/2512.14896)
- [RAG-based Architectures for Drug Side Effect Retrieval (arXiv, 2025)](https://arxiv.org/abs/2507.13822)
- [Performance of RAG on Pharmaceutical Documents (IntuitionLabs)](https://intuitionlabs.ai/articles/rag-performance-pharmaceutical-documents)
- [RAG-Enhanced Collaborative LLM Agents for Drug Discovery (arXiv, 2025)](https://arxiv.org/html/2502.17506v3)
- [LLM as CDSS Augments Medication Safety (PMC, 2025)](https://pmc.ncbi.nlm.nih.gov/articles/PMC12629785/)

---

## 7. AI 의료기기 인허가 기술 요구사항

### 7.1 한국 식약처(MFDS)

#### 세계 최초 생성형 AI 의료기기 가이드라인 (2025.01.24)

식품의약품안전처는 2025년 1월 24일 **세계 최초**로 '생성형 인공지능 의료기기 허가.심사 가이드라인'을 발표했다.

**적용 범위:**
- 대규모 기초 모델(LLM/LMM) 기반 의료기기
- 주요 기능이 텍스트 출력 생성인 AI 도구
- 환자의 진단, 치료, 예후에 직접 관여하는 소프트웨어

**핵심 기술 요구사항:**

| 항목 | 세부 요구사항 |
|---|---|
| 모델 성능 검증 | LLM 성능 검증지표, 임상평가 점수 자료 제출 |
| 데이터 품질 | 훈련 데이터 품질 관리, 데이터 편향 평가 |
| 설명가능성 | 모델의 설명가능성(Explainability) 확보 |
| 결과 일관성 | 동일 입력에 대한 출력 일관성 검증 |
| 위해 요소 관리 | 생성형 AI 특유의 환각, 편향, 일관성 문제 평가 |
| 안전성/유효성 | 기준 충족 여부 검증 |

**혁신 의료기기 Fast-Track (2026.01.26):**
- 보건복지부와 식약처가 공동으로 **"시장 즉시 진입 의료기술"** 경로를 신설했다.
- MFDS의 국제 수준 임상평가를 통과한 혁신 의료기기는 별도의 신의료기술(NMT) 평가 없이 시장 진입이 가능하다.

**디지털 의료기기 분류:**
- 199개 의료기기 범주 중 113개 디지털 장치가 포함되며, AI 기반 SaMD가 핵심 대상이다.

### 7.2 미국 FDA

#### AI/ML 기반 의료기기 규제 프레임워크 (2025-2026)

**주요 가이드라인 (2025.01.07 초안):**

| 항목 | 세부 요구사항 |
|---|---|
| 모델 설명 | AI/ML 모델 구조, 알고리즘 상세 기술 |
| 데이터 계보(Lineage) | 훈련/검증/테스트 데이터의 출처와 분할 방법 |
| 성능과 주장의 연결 | 의도된 용도에 맞는 성능 지표 제시 |
| 편향 분석/완화 | 인구통계학적 편향 분석 및 완화 전략 |
| 인간-AI 워크플로 | 사용자와 AI 간 상호작용 방식 명시 |
| 시판 후 모니터링 | 배포 후 성능 모니터링 계획 |
| PCCP | 사전결정변경관리계획(Predetermined Change Control Plan) |
| SBOM | 소프트웨어 구성요소 명세서(Software Bill of Materials) |
| Secure by Design | 위협 모델링, 위험 평가, 업데이트 메커니즘 |

**SaMD(Software as a Medical Device) 분류:**
- 독립형 소프트웨어로서 의료 목적으로 사용되는 제품
- 클라우드 시스템, 모바일 기기, 데스크톱 컴퓨터에서 작동
- 2025년 7월 기준 FDA 승인 AI 의료기기 **1,250개 이상** (2024년 8월 950개 대비 증가)

**품질시스템 규정 변경 (2026.02.02 시행):**
- 기존 Part 820 요구사항을 철회하고 **ISO 13485:2016**을 준용한다.

### 7.3 약사 AI Agent 인허가 전략

**분류 기준 판단:**
- 약사 AI Agent의 기능에 따라 인허가 분류가 달라진다.
  - **의사결정 보조 도구** (약사에게 정보 제공): 상대적으로 낮은 등급
  - **자율적 처방 검토/경고** (직접 임상 판단): 높은 등급, 엄격한 요구사항
- 초기에는 **약사 보조 도구(Co-pilot)**로 포지셔닝하여 인허가 부담을 최소화하는 전략이 유리하다.

**한국 시장 우선 전략:**
- 식약처의 세계 최초 생성형 AI 가이드라인은 **선점 기회**이다.
- Fast-Track 경로를 활용하면 빠른 시장 진입이 가능하다.
- 국제 임상평가 기준을 충족하면 NMT 평가 면제 혜택을 받을 수 있다.

### 출처
- [식약처 생성형 AI 의료기기 가이드라인 (MFDS)](https://www.mfds.go.kr/brd/m_1060/view.do?seq=15628)
- [식약처 세계최초 생성형 AI 가이드라인 공개 (보도자료)](https://www.mfds.go.kr/brd/m_99/view.do?seq=48833)
- [South Korea Fast Track for Innovative Medical Devices (Thema-Med, 2026)](https://www.thema-med.com/en/2026/02/17/south-korea-launches-fast-track-pathway-for-innovative-medical-devices/)
- [Overview of South Korean Guidelines for LLM/LMM Medical Devices (PMC, 2025)](https://pmc.ncbi.nlm.nih.gov/articles/PMC12123075/)
- [FDA AI-Enabled Device Software Functions (Draft Guidance, 2025)](https://www.fda.gov/media/184856/download)
- [FDA AI-Enabled Medical Devices List](https://www.fda.gov/medical-devices/software-medical-device-samd/artificial-intelligence-enabled-medical-devices)
- [AI Medical Devices: FDA Draft Guidance Guide (Complizen, 2025)](https://www.complizen.ai/post/fda-ai-medical-device-regulation-2025)

---

## 8. 기술 성숙도(TRL) 평가

### 8.1 TRL 프레임워크 개요

| TRL | 단계 | 설명 |
|---|---|---|
| TRL 1 | 기초 원리 관찰 | 기본 원리가 관찰/보고됨 |
| TRL 2 | 기술 개념 수립 | 기술 개념/적용 분야 정의 |
| TRL 3 | 개념 증명 | 핵심 기능의 실험적 증명 |
| TRL 4 | 연구실 검증 | 실험실 환경에서 기술 검증 |
| TRL 5 | 관련 환경 검증 | 유사 환경에서 기술 검증 |
| TRL 6 | 실제 환경 시연 | 실제 운영 환경에서 시연 |
| TRL 7 | 운영 환경 시연 | 실제 운영 환경에서 프로토타입 시연 |
| TRL 8 | 시스템 완성/검증 | 실제 시스템에 통합 및 검증 완료 |
| TRL 9 | 실제 운영 | 실제 운영 환경에서 검증 완료 |

### 8.2 약사 AI Agent 핵심 기술별 TRL 평가

| 핵심 기술 | 현재 TRL | 근거 | 목표 TRL (1년 내) |
|---|---|---|---|
| **LLM 기반 DDI 분석** | TRL 5-6 | 파인튜닝 모델 정확도 92%, 연구실/유사 환경 검증 완료, 일부 실제 환경 시연 | TRL 7 |
| **OCR+NLP 처방전 분석** | TRL 6-7 | 다수 병원에서 실제 환경 배포, 오류 감소 75% 검증 | TRL 8 |
| **약물 DB 연동** | TRL 7-8 | DrugBank/KEGG API 성숙, 식약처 API 운영 중, 실제 시스템 통합 사례 다수 | TRL 8-9 |
| **복약지도 자동화** | TRL 4-5 | 환각 문제(5-30%), 연구실/유사 환경 검증 단계, 고령자 맞춤 연구 진행 중 | TRL 6 |
| **ADR 예측 AI** | TRL 4-5 | CNN 정확도 85%, GNN 연구 진행 중, 대부분 연구실 환경 검증 단계 | TRL 6 |
| **RAG 파이프라인** | TRL 5-6 | DrugRAG 발표(2025.12), 약물감시 영역 파일럿 90% 정확도, 본격 임상 배포 전 | TRL 7 |
| **AI 인허가 대응** | TRL 3-4 | 가이드라인 발표(2025.01), Fast-Track 신설(2026.01), 인허가 사례 축적 초기 | TRL 5-6 |
| **통합 시스템 (AI Agent)** | TRL 3-4 | 개별 기술은 성숙하나 통합 약사 AI Agent는 개념 증명/초기 프로토타입 단계 | TRL 5-6 |

### 8.3 TRL 향상을 위한 핵심 과제

**TRL 6 달성 요건 (실제 환경 시연):**
- 의료 AI 프로젝트에서 TRL 6 달성을 위해서는 약 120개 이상의 기술 검증 항목(TRL 5 단계)을 충족해야 하며, TRL 4에서 5로의 전환에도 97개 항목이 필요하다.
- TRL 4-6 구간은 가장 집중적인 검증이 요구되는 단계로, 제한된 자원 투입 전에 광범위한 검토가 선행되어야 한다.

**MLTRL(Machine Learning Technology Readiness Level) 프레임워크:**
- ML 모델 개발의 비선형적, 순환적 특성을 반영한 "스위치백(Switchbacks)" 개념이 도입되었다.
- 기존 TRL의 직선적 진행과 달리, ML 모델은 성능 저하 시 이전 단계로 회귀할 수 있음을 인정한다.

### 출처
- [CARE Agent: AI-driven TRL Assessment Tool (PMC, 2025)](https://pmc.ncbi.nlm.nih.gov/articles/PMC12236009/)
- [Technology Readiness Assessment Guidebook (DoD, 2025)](https://www.cto.mil/wp-content/uploads/2025/03/TRA-Guide-Feb2025.v2-Cleared.pdf)
- [AI Technology Readiness Levels Guide (Espiolabs)](https://espiolabs.com/blog/posts/ai-technology-readiness-levels-guide)
- [TRL-IS Checklist for Implementation Sciences (ScienceDirect)](https://www.sciencedirect.com/science/article/pii/S2405844024059619)

---

## 9. 종합 결론 및 권고사항

### 9.1 기술 실현 가능성 종합 평가

약사 AI Agent 구현에 필요한 핵심 기술은 대부분 **TRL 4-7 수준**에 도달해 있어, 기술적으로 실현 가능한 단계에 진입했다. 다만, 개별 기술의 성숙도와 통합 시스템으로서의 성숙도 사이에는 격차가 존재한다.

```
[기술 성숙도 맵]

높음 ████████████  약물 DB 연동 (TRL 7-8)
     ███████████   OCR+NLP 처방전 분석 (TRL 6-7)
     ██████████    LLM 기반 DDI 분석 (TRL 5-6)
     ██████████    RAG 파이프라인 (TRL 5-6)
     ████████      ADR 예측 AI (TRL 4-5)
     ████████      복약지도 자동화 (TRL 4-5)
     ███████       AI 인허가 대응 (TRL 3-4)
낮음 ███████       통합 AI Agent 시스템 (TRL 3-4)
```

### 9.2 핵심 권고사항

#### (1) 아키텍처 전략
- **RAG 기반 아키텍처를 핵심으로 채택**하여 환각 문제를 최소화하고, 약학 지식의 최신성을 유지해야 한다.
- DrugRAG의 3단계 파이프라인을 참조하되, 국내 약물 DB(의약품안전나라, DUR)를 지식 베이스로 구축해야 한다.

#### (2) 개발 우선순위
1. **1단계 (0-6개월):** 약물 DB 연동 + RAG 파이프라인 구축 (가장 성숙한 기술부터 시작)
2. **2단계 (6-12개월):** LLM 기반 DDI 분석 + 처방전 분석 파이프라인 통합
3. **3단계 (12-18개월):** ADR 예측 + 복약지도 자동화 + 고령자/다국어 지원
4. **4단계 (18-24개월):** 인허가 준비 + 임상 검증 + 시장 진입

#### (3) 인허가 전략
- 초기에는 **약사 보조 도구(Co-pilot)**로 포지셔닝하여 인허가 부담을 최소화한다.
- 식약처의 생성형 AI 의료기기 가이드라인을 선제적으로 준수하며, Fast-Track 경로를 활용한다.
- Co-pilot 모드에서 약사+AI CDSS의 정확도가 약사 단독 대비 32% 향상된 연구 결과를 활용하여 임상적 유효성을 입증한다.

#### (4) 리스크 관리
- LLM 환각 비율(5-30%)을 약학 도메인에서는 **1% 미만**으로 관리해야 하며, RAG + 인간 검증(Human-in-the-Loop) 이중 안전장치가 필수적이다.
- 개인정보보호(PIPA), 의료 데이터 보안(HIPAA 준용), 윤리적 AI 원칙 준수가 요구된다.

#### (5) 경쟁 우위 확보
- 한국 식약처의 세계 최초 생성형 AI 가이드라인은 **한국 시장 선점 기회**를 의미한다.
- 국내 약학 데이터(식약처 API, DUR, 건강보험심사평가원)에 대한 깊은 통합이 해외 경쟁사 대비 핵심 경쟁력이 될 수 있다.
- 2025년 기준 제약사의 약 50%가 AI를 도입하고 있으며, 글로벌 AI in Pharma 시장이 2034년까지 **164.9억 달러**로 성장할 전망이므로 시장 기회는 충분하다.

---

**보고서 끝.**

*본 보고서는 2026년 2월 20일 기준 최신 논문, 기술 동향, 사례를 조사하여 작성되었습니다.*
