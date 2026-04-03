# 🤖 멀티 AI 병렬 실행 시스템

## 개요
모든 주요 업무를 Claude와 Gemini 둘 다 실행하여 결과를 비교하고 최선의 답을 선택

## 🎯 목적
- 다양한 관점 확보
- 품질 향상
- AI별 강점 활용
- 결과 검증

## 📊 병렬 실행 구조

```
CEO 김상현
    ↓ 업무 지시
리더십팀
    ↓ 업무 분배
각 팀장
    ↓ 동시 실행
┌─────────────┬─────────────┐
│  Claude     │   Gemini    │
│  Agent      │   Agent     │
└─────────────┴─────────────┘
    ↓             ↓
  결과 A        결과 B
    ↓             ↓
    └──── 비교 ────┘
         ↓
    최종 결과 선택
         ↓
    팀장 → 리더십팀
```

## 🔄 작업 프로세스

### 1단계: 업무 수령 및 분기
```
팀장이 업무를 받으면:
1. 동일한 작업을 2개로 분리
2. Claude Agent에게 할당 → 결과 A
3. Gemini Agent에게 할당 → 결과 B
```

### 2단계: 병렬 실행
```
Claude Agent:
- 작업 수행
- outputs/claude/ 에 결과 저장

Gemini Agent:
- 동일 작업 수행
- outputs/gemini/ 에 결과 저장
```

### 3단계: 결과 비교 및 선택
```
팀장이:
1. 두 결과 비교 분석
2. 장단점 평가
3. 최선의 결과 선택 또는 통합
4. outputs/final/ 에 최종 결과 저장
```

### 4단계: 보고
```
팀장 → 리더십팀:
- 최종 선택 결과
- 비교 분석 요약
- 선택 이유
```

## 📁 디렉토리 구조

각 팀 폴더에 추가:
```
[팀명]/
├── TEAM.md
├── tasks/
├── outputs/
│   ├── claude/          # Claude 결과
│   ├── gemini/          # Gemini 결과
│   ├── comparison/      # 비교 분석
│   └── final/           # 최종 선택
└── prompts/
    ├── claude/          # Claude용 프롬프트
    └── gemini/          # Gemini용 프롬프트
```

## 🤖 AI별 특성

### Claude 강점
- 긴 문맥 이해
- 코드 작성 및 리뷰
- 논리적 추론
- 구조화된 문서 작성

### Gemini 강점
- 멀티모달 (이미지, 비디오)
- 다국어 처리
- 실시간 정보 접근
- 창의적 아이디어

## 📋 비교 기준

팀장이 결과를 비교할 때:

### 1. 정확성
- 요구사항 충족도
- 사실 정확성
- 논리적 일관성

### 2. 품질
- 완성도
- 깊이
- 창의성

### 3. 실용성
- 실행 가능성
- 명확성
- 효율성

### 4. 종합 평가
```
비교 분석 템플릿:

## Claude 결과
장점: [...]
단점: [...]
점수: [/10]

## Gemini 결과
장점: [...]
단점: [...]
점수: [/10]

## 최종 선택
선택: [Claude/Gemini/통합]
이유: [...]
```

## 🚀 실행 방법

### Claude 실행
```bash
cd ~/ai-company
claude

# Claude에게 작업 지시
```

### Gemini 실행 (API)
```bash
# Gemini API 호출 스크립트
~/ai-company/scripts/run-gemini.sh "[작업 내용]" "[팀명]"
```

### 병렬 실행 스크립트
```bash
# 자동으로 Claude와 Gemini 동시 실행
~/ai-company/scripts/parallel-ai.sh \
  --task "작업 내용" \
  --team "팀명" \
  --compare
```

## 💡 사용 예시

### 예시 1: 시장 조사
```
조사팀장이 업무 수령:
"AI 챗봇 시장 조사"

실행:
1. Claude → 시장 규모, 경쟁사 분석
2. Gemini → 트렌드, 혁신 기술

비교:
- Claude: 데이터 기반 분석 우수
- Gemini: 최신 트렌드 포착 우수

최종: 두 결과 통합
```

### 예시 2: 코드 작성
```
개발팀장이 업무 수령:
"로그인 API 개발"

실행:
1. Claude → 보안성 높은 코드
2. Gemini → 최신 패턴 적용 코드

비교:
- Claude: 보안 및 에러 처리 우수
- Gemini: 모던한 코드 스타일

최종: Claude 선택 (보안 중요)
```

### 예시 3: 디자인
```
디자인팀장이 업무 수령:
"랜딩 페이지 디자인"

실행:
1. Claude → UX 중심 설계
2. Gemini → 비주얼 아이디어 (이미지 생성)

비교:
- Claude: 사용성 높음
- Gemini: 시각적 창의성 높음

최종: 통합 (Claude 구조 + Gemini 비주얼)
```

## ⚙️ 설정

### Gemini API 키 설정
```bash
# ~/.zshrc 또는 ~/.bashrc에 추가
export GEMINI_API_KEY="your-api-key-here"

# 또는 프로젝트별 설정
echo "GEMINI_API_KEY=your-key" > ~/ai-company/.env
```

### Claude Code 설정
```json
// ~/.claude/settings.json
{
  "teammateMode": "tmux",
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1",
    "GEMINI_API_KEY": "${GEMINI_API_KEY}"
  }
}
```

## 📊 성과 측정

### 메트릭
- 작업별 AI 선택 비율
- 통합 비율
- 품질 점수 평균
- 시간 효율성

### 리포트
월별로 리더십팀에 보고:
```
## AI 성과 리포트

Claude 선택: [%]
Gemini 선택: [%]
통합: [%]

품질 향상: [%]
시간 증가: [%]

권장사항: [...]
```

## 🎯 베스트 프랙티스

1. **중요한 작업에만 병렬 실행** - 모든 작업이 아닌 핵심 업무만
2. **명확한 비교 기준** - 주관적 판단 최소화
3. **학습 및 개선** - AI별 강점을 파악하여 최적 배분
4. **비용 고려** - API 비용 vs 품질 향상 trade-off

## 📚 관련 문서
- `CEO-WORKFLOW.md` - CEO 업무 지시
- `scripts/parallel-ai.sh` - 병렬 실행 스크립트
- `scripts/run-gemini.sh` - Gemini 실행 스크립트
- 각 팀의 `TEAM.md` - 팀별 가이드
