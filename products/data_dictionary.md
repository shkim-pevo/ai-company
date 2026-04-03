# 제품 DB 데이터 사전 (Data Dictionary)

## supplements.csv — 영양제(건강기능식품)

| 컬럼명 | 타입 | 설명 | 예시 |
|--------|------|------|------|
| product_id | string | 제품 고유 ID | SUP-0001 |
| product_name | string | 제품명 | 종근당 비타민C 1000 |
| manufacturer | string | 제조사 | 종근당 |
| category | string | 효능 카테고리 (면역/피로/뼈관절/장건강/비타민/미네랄/오메가/프로바이오틱스/기타) | 비타민 |
| ingredients | string | 주요 성분 (세미콜론 구분) | 아스코르브산;히드록시프로필메틸셀룰로스 |
| active_amount | string | 유효 성분 함량 | 비타민C 1000mg |
| dosage | string | 용법·용량 | 1일 1회, 1회 1정 |
| cautions | string | 주의사항 | 과량 섭취 시 설사 가능 |
| contraindications | string | 금기사항 | 옥살산뇨증 환자 |
| age_restriction | string | 연령 제한 | 만 12세 이상 |
| pregnancy_safe | string | 임부 안전 등급 (안전/주의/금기/미확인) | 주의 |
| interactions | string | 상호작용 성분 (세미콜론 구분) | 와파린;항응고제 |
| dur_tags | string | DUR 관련 태그 (세미콜론 구분) | 중복성분주의;용량초과주의 |
| storage | string | 보관법 | 직사광선 피하고 서늘한 곳 |
| price_range | string | 가격대 | 15000~20000 |
| source | string | 정보 출처 | 식약처 건강기능식품 정보포털 |
| source_date | date | 출처 조사일 | 2026-03-09 |
| reliability | string | 신뢰도 (공인/제조사/자체조사) | 공인 |
| status | string | 상태 (활성/단종/검토중) | 활성 |
| created_at | datetime | 등록일시 | 2026-03-09T10:00:00 |
| updated_at | datetime | 최종 수정일시 | 2026-03-09T10:00:00 |
| updated_by | string | 수정자 | 제품데이터큐레이터 |

## otc_drugs.csv — 일반의약품(OTC)

| 컬럼명 | 타입 | 설명 | 예시 |
|--------|------|------|------|
| product_id | string | 제품 고유 ID | OTC-0001 |
| product_name | string | 제품명 | 타이레놀 500mg |
| manufacturer | string | 제조사 | 한국얀센 |
| category | string | 효능 카테고리 (진통/해열/소화/감기/알레르기/피부/안과/기타) | 진통 |
| approval_no | string | 식약처 허가번호 | 수입-2020-가-012345 |
| ingredients | string | 주요 성분 (세미콜론 구분) | 아세트아미노펜 |
| active_amount | string | 유효 성분 함량 | 아세트아미노펜 500mg |
| dosage | string | 용법·용량 | 1일 3회, 1회 1~2정, 식후 |
| efficacy | string | 효능·효과 | 두통, 치통, 생리통, 근육통, 관절통 해열 |
| cautions | string | 주의사항 | 간장애 환자 주의 |
| contraindications | string | 금기사항 | 이 약 성분 과민반응 환자 |
| age_restriction | string | 연령 제한 | 만 15세 이상 |
| pregnancy_safe | string | 임부 안전 등급 (안전/주의/금기/미확인) | 주의 |
| interactions | string | 상호작용 약물 (세미콜론 구분) | 와파린;메토트렉세이트 |
| dur_tags | string | DUR 관련 태그 (세미콜론 구분) | 병용금기;간독성주의;용량초과주의 |
| storage | string | 보관법 | 기밀용기, 실온보관 |
| price_range | string | 가격대 | 5000~8000 |
| source | string | 정보 출처 | 식약처 의약품안전나라 |
| source_date | date | 출처 조사일 | 2026-03-09 |
| reliability | string | 신뢰도 (공인/제조사/자체조사) | 공인 |
| status | string | 상태 (활성/단종/검토중) | 활성 |
| created_at | datetime | 등록일시 | 2026-03-09T10:00:00 |
| updated_at | datetime | 최종 수정일시 | 2026-03-09T10:00:00 |
| updated_by | string | 수정자 | 제품데이터큐레이터 |

## rx_drugs.csv — 전문의약품(Rx)

| 컬럼명 | 타입 | 설명 | 예시 |
|--------|------|------|------|
| product_id | string | 제품 고유 ID | RX-00001 |
| product_name | string | 제품명 | 아토르바스타틴정10mg |
| manufacturer | string | 제조사 | 한미약품 |
| category | string | 약효 카테고리 (한글) | 혈압강하 |
| subcategory | string | 세부 분류 (식약처 약효분류 명칭) | 혈압강하제 |
| approval_no | string | 식약처 품목기준코드 (item_seq) | 200400123 |
| prduct_type | string | 식약처 약효분류코드 | [02140]혈압강하제 |
| ingredients | string | 주요 성분 (세미콜론 구분) | 아토르바스타틴칼슘수화물 |
| active_amount | string | 유효 성분 함량 | 아토르바스타틴 10mg |
| dosage | string | 용법·용량 | 1일 1회, 1회 10mg |
| efficacy | string | 효능·효과 | 고콜레스테롤혈증, 고지혈증 |
| cautions | string | 주의사항 | 간기능검사 정기적 시행 |
| contraindications | string | 금기사항 | 활동성 간질환 환자 |
| age_restriction | string | 연령 제한 | - |
| pregnancy_safe | string | 임부 안전 등급 (안전/주의/금기/미확인) | 금기 |
| interactions | string | 상호작용 약물 (세미콜론 구분) | 사이클로스포린;겜피브로질 |
| dur_tags | string | DUR 관련 태그 (세미콜론 구분) | 병용금기;간독성주의 |
| storage | string | 보관법 | 기밀용기, 실온보관 |
| source | string | 정보 출처 | 식약처 의약품안전나라 |
| source_date | date | 출처 조사일 | 2026-03-11 |
| reliability | string | 신뢰도 (공인/제조사/자체조사/미확인) | 자체조사 |
| status | string | 상태 (활성/단종/검토중) | 활성 |
| created_at | datetime | 등록일시 | 2026-03-11T14:00:00 |
| updated_at | datetime | 최종 수정일시 | 2026-03-11T14:00:00 |
| updated_by | string | 수정자 | 제품데이터큐레이터 |

## 코드 체계

### 효능 카테고리 (영양제)
| 코드 | 카테고리 |
|------|----------|
| immunity | 면역 |
| fatigue | 피로 |
| bone_joint | 뼈·관절 |
| gut_health | 장건강 |
| vitamin | 비타민 |
| mineral | 미네랄 |
| omega | 오메가 |
| probiotics | 프로바이오틱스 |
| etc | 기타 |

### 효능 카테고리 (OTC)
| 코드 | 카테고리 |
|------|----------|
| pain | 진통/해열/소염 |
| digestive | 소화/위장 |
| cold | 감기/호흡기 |
| skin | 피부/미용 |
| vitamin | 비타민/순환계 |
| eye | 안과 |
| herbal | 한방제제 |
| urogenital | 비뇨/생식기/항문 |
| oral | 구강/치아 |
| drink | 드링크류 |
| etc | 기타 |

### 약효 카테고리 (전문의약품 Rx)
| 카테고리 | 설명 | 건수 |
|----------|------|------|
| 혈압강하 | 고혈압 치료제 (ACE억제제, ARB, CCB, 베타차단제 등) | 2,899 |
| 당뇨 | 당뇨병용제 (메트포르민, 인슐린, DPP-4억제제, SGLT2억제제 등) | 2,845 |
| 항생제 | 세균 감염 치료 (페니실린, 세팔로스포린, 퀴놀론, 마크로라이드 등) | 2,530 |
| 고지혈증 | 동맥경화용제 (스타틴, 에제티미브, 피브레이트 등) | 1,998 |
| 소화성궤양 | 위·십이지장궤양 치료 (PPI, H2차단제, 위점막보호제 등) | 1,878 |
| 진통·해열·소염 | NSAIDs, COX-2억제제, 아세트아미노펜 등 | 1,709 |
| 신경계 | 중추신경계 질환 (파킨슨, 치매, 근이완 등) | 1,508 |
| 항균·항바이러스 | 항균제, 항바이러스제, 항결핵제, 항원충제 | 1,485 |
| 순환기 | 심부전, 부정맥, 혈관확장제, 이뇨제 등 | 1,360 |
| 비뇨생식기 | 전립선비대증, 과민성방광, 발기부전 등 | 1,115 |
| 정신신경 | 조현병, 우울증, 불안장애, 수면장애 등 | 1,060 |
| 대사 | 통풍, 효소제제, 해독제, 기타 대사성 질환 | 989 |
| 호흡기 | 천식, COPD, 기침, 가래 관련 | 923 |
| 알레르기 | 항히스타민제, 면역조절제 등 | 889 |
| 항암 | 항악성종양제 (화학요법, 표적치료, 면역항암제 등) | 879 |
| 안과 | 안약, 녹내장 치료제, 안과 감염치료제 등 | 769 |
| 내분비 | 갑상선, 호르몬, 부신피질호르몬제 등 | 649 |
| 혈액 | 항응고제, 지혈제, 혈액대용제 등 | 978 |
| 피부 | 피부 감염, 염증, 연화제 등 | 377 |
| 영양·대사 | 비타민, 미네랄 전문의약품 | 365 |
| 수액·영양 | 수액, 아미노산, 혈장대용제 등 | 261 |
| 기타 | 분류 외 품목 | 991 |

### DUR 태그
| 태그 | 설명 |
|------|------|
| 병용금기 | 타 약물과 동시 복용 금지 |
| 연령금기 | 특정 연령대 사용 금지 |
| 임부금기 | 임산부·수유부 사용 금지 |
| 용량초과주의 | 일일 권장량 초과 위험 |
| 중복성분주의 | 타 제품과 성분 중복 위험 |
| 간독성주의 | 간 기능 영향 주의 |
| 신독성주의 | 신장 기능 영향 주의 |
| 위장장애주의 | 위장관 장애 발생 위험 |

### 신뢰도 등급
| 등급 | 설명 |
|------|------|
| 공인 | 식약처 등 공인기관 데이터 |
| 제조사 | 제조사 공식 자료 기반 |
| 자체조사 | AI 지식 기반 카테고리 매핑 |
| 미확인 | 정보 미확인 (추가 조사 필요) |

## 데이터 현황 (2026-03-11 기준)

| 항목 | 수치 |
|------|------|
| 영양제 총 건수 | 198건 |
| 영양제 성분 채움률 | 100% |
| OTC 총 건수 | 13,587건 |
| OTC 성분 채움률 | 64.5% |
| OTC 효능 채움률 | 99.4% |
| OTC 신뢰도 — 공인 | 6,900건 |
| OTC 신뢰도 — 자체조사 | 5,409건 |
| OTC 신뢰도 — 미확인 | 1,278건 |
| Rx 총 건수 | 32,482건 |
| Rx 성분 채움률 | 44.5% |
| Rx 효능 채움률 | 97.7% |
| Rx 신뢰도 — 공인 | 39건 |
| Rx 신뢰도 — 자체조사 | 31,697건 |
| Rx 신뢰도 — 미확인 | 746건 |
| **전체 DB 합계** | **46,267건** |
