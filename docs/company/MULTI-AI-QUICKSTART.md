# 🚀 멀티 AI 시스템 빠른 시작

## ✅ 설정 완료!

Claude와 Gemini 병렬 실행 시스템이 준비되었습니다!

## 📋 준비 사항

### 1. Gemini API 키 발급
1. https://makersuite.google.com/app/apikey 방문
2. API 키 생성
3. 키 저장

### 2. API 키 설정
```bash
# 방법 1: 환경 변수 (.zshrc에 추가)
echo 'export GEMINI_API_KEY="your-api-key-here"' >> ~/.zshrc
source ~/.zshrc

# 방법 2: .env 파일
echo 'GEMINI_API_KEY=your-api-key-here' > ~/ai-company/.env
```

### 3. 설정 확인
```bash
# API 키 확인
echo $GEMINI_API_KEY

# 스크립트 확인
ls -la ~/ai-company/scripts/
```

## 🎯 사용 방법

### 방법 1: 자동 병렬 실행 (추천)

```bash
cd ~/ai-company

# 예시: 조사팀에 시장 조사 요청
./scripts/parallel-ai.sh \
  --task "AI 챗봇 시장 조사 및 경쟁사 분석" \
  --team "research" \
  --compare
```

이 명령어는:
1. ✅ Gemini를 자동 실행
2. 📝 Claude 실행 방법 안내
3. 📊 비교 템플릿 자동 생성

### 방법 2: 수동 실행

#### 1️⃣ Gemini 실행
```bash
./scripts/run-gemini.sh "작업 내용" "팀명"

# 예시
./scripts/run-gemini.sh "AI 시장 규모 분석" "research"
```

#### 2️⃣ Claude 실행
```bash
cd ~/ai-company
claude

# Claude에게 지시:
당신은 research 팀의 AI Agent입니다.

작업: AI 시장 규모 분석

결과를 ~/ai-company/research/outputs/claude/[날짜]-result.md 에 저장해주세요.
```

#### 3️⃣ 결과 비교
```bash
# Claude 결과
cat ~/ai-company/research/outputs/claude/20260220-*-result.md

# Gemini 결과
cat ~/ai-company/research/outputs/gemini/20260220-*-result.md

# 비교 후 최선의 결과를 final/ 에 저장
```

## 💡 실전 예시

### 예시 1: 신제품 아이디어 검증

```bash
# CEO → 리더십팀 → 조사팀
./scripts/parallel-ai.sh \
  --task "AI 학습 도우미 앱 시장성 검증 (시장 규모, 경쟁사, 고객 니즈)" \
  --team "research" \
  --compare
```

**결과:**
- Claude: 데이터 중심 분석
- Gemini: 트렌드 및 혁신 관점
- 최종: 두 결과 통합하여 종합 보고서

### 예시 2: 코드 리뷰

```bash
./scripts/parallel-ai.sh \
  --task "로그인 API 코드 리뷰 (보안, 성능, 코드 품질)" \
  --team "quality" \
  --compare
```

**결과:**
- Claude: 보안 취약점 상세 분석
- Gemini: 최신 베스트 프랙티스 제안
- 최종: Claude 선택 (보안 중요)

### 예시 3: 마케팅 캠페인

```bash
./scripts/parallel-ai.sh \
  --task "신제품 론칭 캠페인 전략 수립" \
  --team "marketing" \
  --compare
```

**결과:**
- Claude: 논리적 단계별 전략
- Gemini: 창의적 캠페인 아이디어
- 최종: 통합 (Claude 구조 + Gemini 창의성)

## 📁 결과 확인

```bash
# 특정 팀의 모든 결과
ls -la ~/ai-company/research/outputs/

# Claude 결과만
ls -la ~/ai-company/research/outputs/claude/

# Gemini 결과만
ls -la ~/ai-company/research/outputs/gemini/

# 비교 분석
ls -la ~/ai-company/research/outputs/comparison/

# 최종 선택
ls -la ~/ai-company/research/outputs/final/
```

## 🎯 워크플로우

### 전체 프로세스
```
1. CEO가 리더십팀에 업무 지시
   ↓
2. 리더십팀이 적절한 팀에 배분
   ↓
3. 팀장이 병렬 실행 스크립트 사용
   ↓
4. Claude와 Gemini가 동시 작업
   ↓
5. 팀장이 결과 비교 및 선택
   ↓
6. 최종 결과를 리더십팀에 보고
   ↓
7. 리더십팀이 CEO에게 최종 보고
```

## ⚙️ 고급 사용법

### 비교 분석 자동화

```bash
# 비교 템플릿 자동 작성 (AI 사용)
cd ~/ai-company
claude

# Claude에게:
다음 두 파일을 비교 분석해주세요:
- research/outputs/claude/[날짜]-result.md
- research/outputs/gemini/[날짜]-result.md

비교 기준:
1. 정확성
2. 품질
3. 실용성

결과를 research/outputs/comparison/[날짜]-comparison.md 에 저장해주세요.
```

### 팀별 AI 선호도 설정

특정 작업에는 특정 AI가 더 적합할 수 있습니다:

```bash
# 각 팀의 prompts/ 폴더에 가이드 추가
cat > ~/ai-company/research/prompts/ai-preference.md <<EOF
# AI 선호도 가이드

## Claude 선호 작업
- 긴 문서 분석
- 논리적 추론
- 코드 작성

## Gemini 선호 작업
- 최신 트렌드 조사
- 이미지/비디오 분석
- 창의적 아이디어

## 병렬 실행 권장 작업
- 중요한 의사결정
- 전략 수립
- 제품 설계
EOF
```

## 📊 성과 추적

```bash
# 월별 AI 성과 리포트
cat > ~/ai-company/leadership/outputs/ai-performance.md <<EOF
# AI 성과 리포트 - 2026년 2월

## 사용 통계
- 총 작업: 50건
- Claude 선택: 25건 (50%)
- Gemini 선택: 10건 (20%)
- 통합: 15건 (30%)

## 팀별 선호도
- 개발팀: Claude 80%
- 마케팅팀: Gemini 60%
- 조사팀: 통합 50%

## 품질 향상
- 평균 품질 점수: 8.5/10
- 병렬 실행 시간: +30%
- 결과 만족도: 95%

## 권장사항
1. 개발 작업은 Claude 단독 사용
2. 창의적 작업은 Gemini 활용 증대
3. 전략 수립은 병렬 실행 유지
EOF
```

## 🛠️ 트러블슈팅

### Gemini API 오류
```bash
# API 키 확인
echo $GEMINI_API_KEY

# API 테스트
curl -s "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$GEMINI_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"contents":[{"parts":[{"text":"Hello"}]}]}'
```

### 스크립트 실행 오류
```bash
# 실행 권한 확인
ls -la ~/ai-company/scripts/

# 권한 부여
chmod +x ~/ai-company/scripts/*.sh

# 재실행
./scripts/parallel-ai.sh --task "테스트" --team "research"
```

## 📚 관련 문서

- `MULTI-AI-SYSTEM.md` - 전체 시스템 설명
- `CEO-WORKFLOW.md` - CEO 업무 지시 방법
- `SETUP-COMPLETE.md` - 회사 구조 설명
- 각 팀의 `TEAM.md` - 팀별 가이드

## 🎊 시작하기

```bash
cd ~/ai-company

# 1. API 키 설정 확인
echo $GEMINI_API_KEY

# 2. 첫 번째 병렬 실행
./scripts/parallel-ai.sh \
  --task "AI 회사 운영 시스템 테스트" \
  --team "research" \
  --compare

# 3. 결과 확인
ls -la research/outputs/
```

**준비 완료! 🚀**
