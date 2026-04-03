#!/bin/bash

# Claude와 Gemini 병렬 실행 스크립트
# 사용법: ./parallel-ai.sh --task "작업" --team "팀명" --compare

set -e

# 색상
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 기본값
TASK=""
TEAM=""
COMPARE=false

# 인자 파싱
while [[ $# -gt 0 ]]; do
    case $1 in
        --task)
            TASK="$2"
            shift 2
            ;;
        --team)
            TEAM="$2"
            shift 2
            ;;
        --compare)
            COMPARE=true
            shift
            ;;
        *)
            echo "알 수 없는 옵션: $1"
            exit 1
            ;;
    esac
done

# 필수 인자 확인
if [ -z "$TASK" ] || [ -z "$TEAM" ]; then
    echo "사용법: $0 --task \"작업 내용\" --team \"팀명\" [--compare]"
    exit 1
fi

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
OUTPUT_DIR="$HOME/ai-company/$TEAM/outputs"
COMPARISON_DIR="$OUTPUT_DIR/comparison"
FINAL_DIR="$OUTPUT_DIR/final"

# 디렉토리 생성
mkdir -p "$OUTPUT_DIR"/{claude,gemini,comparison,final}

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}   🤖 병렬 AI 실행${NC}"
echo -e "${BLUE}======================================${NC}"
echo "팀: $TEAM"
echo "작업: $TASK"
echo "시간: $(date)"
echo ""

# 1. Gemini 실행 (백그라운드)
echo -e "${GREEN}🟢 Gemini 실행 중...${NC}"
~/ai-company/scripts/run-gemini.sh "$TASK" "$TEAM" > /tmp/gemini-$$.log 2>&1 &
GEMINI_PID=$!

# 2. Claude 실행 안내
echo -e "${GREEN}🔵 Claude 실행 필요${NC}"
echo ""
echo "다음 명령으로 Claude를 실행하세요:"
echo -e "${YELLOW}cd ~/ai-company && claude${NC}"
echo ""
echo "Claude에게 다음과 같이 지시하세요:"
echo "---"
echo "당신은 $TEAM 팀의 AI Agent입니다."
echo ""
echo "작업: $TASK"
echo ""
echo "결과를 ~/ai-company/$TEAM/outputs/claude/${TIMESTAMP}-result.md 에 저장해주세요."
echo "---"
echo ""

# Gemini 완료 대기
echo -e "${YELLOW}⏳ Gemini 결과 대기 중...${NC}"
wait $GEMINI_PID

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Gemini 완료!${NC}"
    cat /tmp/gemini-$$.log
else
    echo -e "${RED}❌ Gemini 실패${NC}"
    cat /tmp/gemini-$$.log
fi

rm -f /tmp/gemini-$$.log

# 비교 분석
if [ "$COMPARE" = true ]; then
    echo ""
    echo -e "${BLUE}======================================${NC}"
    echo -e "${BLUE}   📊 결과 비교 분석${NC}"
    echo -e "${BLUE}======================================${NC}"
    echo ""
    
    # 비교 템플릿 생성
    cat > "$COMPARISON_DIR/${TIMESTAMP}-comparison.md" <<EOF
# 결과 비교 분석

**작업**: $TASK
**팀**: $TEAM
**일시**: $(date)

## Claude 결과
**파일**: \`outputs/claude/${TIMESTAMP}-result.md\`

### 장점
- [ ] 작성 필요

### 단점
- [ ] 작성 필요

### 점수
[ ] / 10

---

## Gemini 결과
**파일**: \`outputs/gemini/${TIMESTAMP}-result.md\`

### 장점
- [ ] 작성 필요

### 단점
- [ ] 작성 필요

### 점수
[ ] / 10

---

## 비교 분석

### 정확성
- Claude: [ ]
- Gemini: [ ]

### 품질
- Claude: [ ]
- Gemini: [ ]

### 실용성
- Claude: [ ]
- Gemini: [ ]

---

## 최종 선택

### 선택
- [ ] Claude
- [ ] Gemini
- [ ] 통합

### 선택 이유


### 최종 결과 위치
\`outputs/final/${TIMESTAMP}-final.md\`

---

## 액션 아이템
1. 
2. 
3. 
EOF

    echo -e "${GREEN}📝 비교 템플릿 생성됨:${NC}"
    echo "$COMPARISON_DIR/${TIMESTAMP}-comparison.md"
    echo ""
    echo "템플릿을 작성한 후 최종 결과를 final/ 에 저장하세요."
fi

echo ""
echo -e "${GREEN}✅ 병렬 실행 완료!${NC}"
echo ""
echo "결과 위치:"
echo "  Claude:  $OUTPUT_DIR/claude/"
echo "  Gemini:  $OUTPUT_DIR/gemini/"
if [ "$COMPARE" = true ]; then
    echo "  비교:    $COMPARISON_DIR/"
    echo "  최종:    $FINAL_DIR/"
fi
