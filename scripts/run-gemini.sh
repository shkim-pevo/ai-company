#!/bin/bash

# Gemini API 실행 스크립트
# 사용법: ./run-gemini.sh "작업 내용" "팀명"

set -e

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 인자 확인
if [ "$#" -lt 2 ]; then
    echo -e "${RED}사용법: $0 \"작업 내용\" \"팀명\"${NC}"
    echo "예시: $0 \"AI 시장 조사\" \"research\""
    exit 1
fi

TASK="$1"
TEAM="$2"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
OUTPUT_DIR="$HOME/ai-company/$TEAM/outputs/gemini"
OUTPUT_FILE="$OUTPUT_DIR/${TIMESTAMP}-result.md"

# API 키 확인
if [ -z "$GEMINI_API_KEY" ]; then
    # .env 파일에서 로드 시도
    if [ -f "$HOME/ai-company/.env" ]; then
        source "$HOME/ai-company/.env"
    fi
    
    if [ -z "$GEMINI_API_KEY" ]; then
        echo -e "${RED}오류: GEMINI_API_KEY가 설정되지 않았습니다.${NC}"
        echo "다음 중 하나를 실행하세요:"
        echo "  export GEMINI_API_KEY='your-key'"
        echo "  echo 'GEMINI_API_KEY=your-key' > ~/ai-company/.env"
        exit 1
    fi
fi

# 출력 디렉토리 생성
mkdir -p "$OUTPUT_DIR"

echo -e "${GREEN}🤖 Gemini API 실행 중...${NC}"
echo "팀: $TEAM"
echo "작업: $TASK"
echo ""

# Gemini API 호출 (curl 사용)
API_URL="https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$GEMINI_API_KEY"

# JSON 요청 생성
REQUEST_JSON=$(cat <<EOF
{
  "contents": [{
    "parts": [{
      "text": "당신은 $TEAM 팀의 AI Agent입니다.\n\n팀 역할: $(cat ~/ai-company/$TEAM/TEAM.md 2>/dev/null | head -20)\n\n작업: $TASK\n\n위 작업을 수행하고 상세한 결과를 제공해주세요."
    }]
  }],
  "generationConfig": {
    "temperature": 0.7,
    "topK": 40,
    "topP": 0.95,
    "maxOutputTokens": 2048
  }
}
EOF
)

# API 호출
RESPONSE=$(curl -s -X POST "$API_URL" \
  -H "Content-Type: application/json" \
  -d "$REQUEST_JSON")

# 응답 확인
if echo "$RESPONSE" | grep -q "error"; then
    echo -e "${RED}오류: Gemini API 호출 실패${NC}"
    echo "$RESPONSE" | jq '.'
    exit 1
fi

# 결과 추출 및 저장
echo "$RESPONSE" | jq -r '.candidates[0].content.parts[0].text' > "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ 완료!${NC}"
    echo "결과 저장: $OUTPUT_FILE"
    echo ""
    echo "--- 결과 미리보기 ---"
    head -20 "$OUTPUT_FILE"
    echo ""
    echo -e "${YELLOW}전체 결과 보기: cat $OUTPUT_FILE${NC}"
else
    echo -e "${RED}오류: 결과 저장 실패${NC}"
    exit 1
fi
