#!/bin/bash

# 바탕화면 팀 앱들에 병렬 실행 기능 추가

LAUNCHERS_DIR="/Users/sanghyunkim/Desktop/ai-company/app/launchers"
AI_COMPANY_DIR="/Users/sanghyunkim/ai-company"

# 팀 매핑 (launcher파일명:팀ID)
declare -A TEAM_MAP
TEAM_MAP["launch-research.sh"]="research"
TEAM_MAP["launch-debate.sh"]="debate"
TEAM_MAP["launch-synthesis.sh"]="synthesis"
TEAM_MAP["launch-planning.sh"]="planning"
TEAM_MAP["launch-design.sh"]="design"
TEAM_MAP["launch-quality.sh"]="quality"
TEAM_MAP["launch-development.sh"]="development"
TEAM_MAP["launch-devops.sh"]="devops"
TEAM_MAP["launch-security.sh"]="security"
TEAM_MAP["launch-marketing.sh"]="marketing"
TEAM_MAP["launch-sales.sh"]="sales"
TEAM_MAP["launch-customer-support.sh"]="customer-support"
TEAM_MAP["launch-data-analytics.sh"]="data-analytics"
TEAM_MAP["launch-legal.sh"]="legal"
TEAM_MAP["launch-finance.sh"]="finance"
TEAM_MAP["launch-leadership.sh"]="leadership"
TEAM_MAP["launch-documentation.sh"]="documentation"

echo "🔄 바탕화면 팀 앱 업데이트 중..."
echo ""

for launcher in "${!TEAM_MAP[@]}"; do
    LAUNCHER_PATH="$LAUNCHERS_DIR/$launcher"
    TEAM_ID="${TEAM_MAP[$launcher]}"
    
    if [ ! -f "$LAUNCHER_PATH" ]; then
        echo "⚠️  $launcher 파일이 없습니다. 건너뜁니다."
        continue
    fi
    
    echo "📝 $launcher 업데이트 중..."
    
    # 백업 생성
    cp "$LAUNCHER_PATH" "${LAUNCHER_PATH}.backup"
    
    # AI_COMPANY_DIR과 TEAM_ID 변수 추가 (파일 상단에)
    if ! grep -q "AI_COMPANY_DIR=" "$LAUNCHER_PATH"; then
        sed -i '' '4a\
AI_COMPANY_DIR="/Users/sanghyunkim/ai-company"\
TEAM_ID="'"$TEAM_ID"'"\
' "$LAUNCHER_PATH"
    fi
    
    # 메뉴에 병렬 실행 옵션 추가
    if ! grep -q "병렬 실행" "$LAUNCHER_PATH"; then
        # [2] 🔵 Gemini 다음에 병렬 실행 추가
        sed -i '' 's/echo -e "\\033\[1;34m║    \[2\] 🔵 Gemini.*$/&\
echo -e "\\033[1;35m║    [3] 🤖 병렬 실행 (Claude + Gemini)    ║\\033[0m"/' "$LAUNCHER_PATH"
        
        # [3] 종료 -> [4] 종료로 변경
        sed -i '' 's/\[3\] 종료/[4] 종료/' "$LAUNCHER_PATH"
        
        # 선택 프롬프트 변경
        sed -i '' 's/read -p "  선택 (1\/2\/3): "/read -p "  선택 (1\/2\/3\/4): "/' "$LAUNCHER_PATH"
    fi
    
    # case문에 병렬 실행 로직 추가
    if ! grep -q "병렬 실행 모드" "$LAUNCHER_PATH"; then
        # 3) 케이스 추가 (2) 다음에)
        sed -i '' '/exec.*GEMINI_BIN.*/a\
    ;;\
  3)\
    echo -e "\\033[1;35m🤖 병렬 실행 모드\\033[0m"\
    echo ""\
    read -p "작업 내용을 입력하세요: " task\
    echo ""\
    \
    if [ -z "$task" ]; then\
      echo "작업 내용이 비어있습니다."\
      exit 1\
    fi\
    \
    # 병렬 실행 스크립트 호출\
    exec "$AI_COMPANY_DIR/scripts/parallel-ai.sh" --task "$task" --team "$TEAM_ID" --compare\
' "$LAUNCHER_PATH"
        
        # 3|*) -> 4|*) 변경
        sed -i '' 's/3|\*)/4|*)/' "$LAUNCHER_PATH"
    fi
    
    echo "✅ $launcher 완료"
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 모든 팀 앱 업데이트 완료!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "이제 바탕화면의 팀 앱에서:"
echo "  [1] Claude"
echo "  [2] Gemini"
echo "  [3] 병렬 실행 ⭐ NEW!"
echo "  [4] 종료"
echo ""
echo "를 선택할 수 있습니다!"
