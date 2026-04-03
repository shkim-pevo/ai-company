#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Gemini 병행 작업 스크립트
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Cowork에서 작업 지시 → Gemini가 실행 → 결과 자동 저장
#
# 사용법:
#   bash app/gemini_parallel.sh "작업 내용" [팀명]
#
# 예시:
#   bash app/gemini_parallel.sh "피치덱 Slide 2 Problem 대안 분석" research
#   bash app/gemini_parallel.sh "시장 규모 재검증" research
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

AI_COMPANY_DIR="/Users/sanghyunkim/Desktop/ai-company"
GEMINI_BIN="$AI_COMPANY_DIR/node_modules/.bin/gemini"
ASSIGNMENTS_DIR="$AI_COMPANY_DIR/IR Deck/team_assignments"
TASK="$1"
TEAM="${2:-general}"
DATE=$(date +%Y%m%d)
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

if [ -z "$TASK" ]; then
  echo ""
  echo -e "\033[1;34m🔵 Gemini 병행 작업 도구\033[0m"
  echo ""
  echo "사용법: bash app/gemini_parallel.sh \"작업 내용\" [팀명]"
  echo ""
  echo "팀명 옵션:"
  echo "  research, debate, synthesis, quality, planning,"
  echo "  design, development, devops, security, marketing,"
  echo "  sales, customer-support, data-analytics, legal,"
  echo "  finance, leadership, documentation, general"
  echo ""
  echo "예시:"
  echo "  bash app/gemini_parallel.sh \"경쟁사 분석\" research"
  echo "  bash app/gemini_parallel.sh \"법적 리스크 검토\" legal"
  echo ""
  exit 0
fi

# 결과 저장 디렉토리
if [ "$TEAM" = "general" ]; then
  OUTPUT_DIR="$ASSIGNMENTS_DIR"
else
  OUTPUT_DIR="$ASSIGNMENTS_DIR/$TEAM"
  mkdir -p "$OUTPUT_DIR"
fi

# 출력 파일명
SAFE_TASK=$(echo "$TASK" | tr ' ' '_' | tr -cd '[:alnum:]_' | head -c 50)
OUTPUT_FILE="$OUTPUT_DIR/${DATE}_gemini_${TEAM}_${SAFE_TASK}.md"

echo ""
echo -e "\033[1;34m🔵 Gemini 병행 작업 시작\033[0m"
echo -e "\033[0;90m  작업: $TASK\033[0m"
echo -e "\033[0;90m  팀:   $TEAM\033[0m"
echo -e "\033[0;90m  저장: $OUTPUT_FILE\033[0m"
echo ""

# 시스템 프롬프트 구성
SYSTEM_PROMPT="당신은 페보(Pevo) AI Company의 ${TEAM}팀 Gemini AI 어시스턴트입니다.

## 회사 정보
- 페보(Pevo): 약국 복약지도 자동화 AI Agent 기술 회사
- 핵심 제품: PharmPay (크레소티 플랫폼 앱)
- 3가지 AI 엔진: Vision AI, Voice AI, AI Curation
- 핵심 기술: Drug Mugger DB (2만개 약물 × 영양소 매핑)

## 응답 규칙
1. 한국어로 답변하세요
2. 마크다운 형식으로 구조화해서 답변하세요
3. 데이터와 출처를 포함하세요
4. 실행 가능한 권고사항을 포함하세요
5. 답변 마지막에 '---\n**AI**: Gemini\n**팀**: ${TEAM}\n**일시**: $(date +%Y.%m.%d %H:%M)'를 추가하세요"

# Gemini 실행 및 결과 저장
echo -e "\033[0;90m  Gemini 실행 중...\033[0m"

# 헤더 작성
cat > "$OUTPUT_FILE" <<EOHEADER
# [Gemini] $TASK
**작업 일시**: $(date +"%Y.%m.%d %H:%M")
**팀**: $TEAM
**AI 엔진**: Gemini
**상태**: 작업 중...

---

EOHEADER

# Gemini 실행
RESULT=$("$GEMINI_BIN" -p "$SYSTEM_PROMPT

다음 작업을 수행해주세요:

$TASK

참고: 현재 IR 피치덱 V3(After-Care 중심)를 작업 중입니다.
- Problem: After-Care 공백 (78% 환자 추가질문 필요)
- Solution: 3가지 AI 엔진 (Vision/Voice/Curation)
- Market: TAM 15조 → 50조+
- Key Tech: Drug Mugger DB (국내 유일)" 2>&1)

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ] && [ -n "$RESULT" ]; then
  # 결과 파일 업데이트
  cat > "$OUTPUT_FILE" <<EOFINAL
# [Gemini] $TASK
**작업 일시**: $(date +"%Y.%m.%d %H:%M")
**팀**: $TEAM
**AI 엔진**: Gemini

---

$RESULT
EOFINAL

  echo -e "\033[1;32m✅ 완료! 결과 저장됨\033[0m"
  echo -e "\033[0;90m  파일: $OUTPUT_FILE\033[0m"
  echo ""
  echo -e "\033[1;36m📋 Cowork에서 확인:\033[0m"
  echo -e "\033[0;90m  이 파일은 Cowork 환경에서 자동으로 보입니다.\033[0m"
else
  # 에러 기록
  cat > "$OUTPUT_FILE" <<EOERROR
# [Gemini] $TASK
**작업 일시**: $(date +"%Y.%m.%d %H:%M")
**팀**: $TEAM
**AI 엔진**: Gemini
**상태**: ⚠️ 오류 발생

---

## 오류 내용
\`\`\`
$RESULT
\`\`\`

## 해결 방법
1. Gemini API 키 확인: \`echo \$GEMINI_API_KEY\`
2. 네트워크 확인: \`curl -s https://generativelanguage.googleapis.com\`
3. 수동 실행: \`gemini -p "질문"\`
EOERROR

  echo -e "\033[1;33m⚠️ Gemini 실행 중 오류 발생\033[0m"
  echo -e "\033[0;90m  오류 로그: $OUTPUT_FILE\033[0m"
fi

echo ""
