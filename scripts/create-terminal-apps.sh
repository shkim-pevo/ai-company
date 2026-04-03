#!/bin/bash

# 각 팀별 터미널 앱 생성 스크립트

set -e

APPS_DIR="$HOME/ai-company/terminal-apps"
TEAMS=(
    "research:조사팀"
    "debate:토론팀"
    "synthesis:종합팀"
    "planning:기획팀"
    "design:디자인팀"
    "quality:퀄리티팀"
    "development:개발팀"
    "devops:DevOps팀"
    "security:보안팀"
    "marketing:마케팅팀"
    "sales:세일즈팀"
    "customer-support:고객지원팀"
    "data-analytics:데이터분석팀"
    "legal:법무팀"
    "finance:재무팀"
    "leadership:리더십팀"
    "documentation:문서화팀"
)

echo "🚀 터미널 앱 생성 중..."
echo ""

for team_info in "${TEAMS[@]}"; do
    IFS=':' read -r team_id team_name <<< "$team_info"
    
    APP_NAME="${team_name}.app"
    APP_PATH="$APPS_DIR/$APP_NAME"
    
    echo "📱 $team_name ($team_id) 생성 중..."
    
    # .app 구조 생성
    mkdir -p "$APP_PATH/Contents/MacOS"
    mkdir -p "$APP_PATH/Contents/Resources"
    
    # 실행 스크립트 생성
    cat > "$APP_PATH/Contents/MacOS/run.sh" <<'SCRIPT_EOF'
#!/bin/bash

TEAM_ID="TEAM_ID_PLACEHOLDER"
TEAM_NAME="TEAM_NAME_PLACEHOLDER"

# 터미널 타이틀 설정
echo -ne "\033]0;${TEAM_NAME} - AI Company\007"

# 배너 출력
cat << "EOF"
╔═══════════════════════════════════════════╗
║                                           ║
║          TEAM_NAME_PLACEHOLDER                    ║
║          AI Company                       ║
║                                           ║
╔═══════════════════════════════════════════╗

CEO: 김상현
팀 디렉토리: ~/ai-company/TEAM_ID_PLACEHOLDER
EOF

echo ""
echo "사용 가능한 명령어:"
echo "  1. Claude 실행: claude-start"
echo "  2. Gemini 실행: gemini-start \"작업내용\""
echo "  3. 병렬 실행: parallel-start \"작업내용\""
echo "  4. 팀 정보: team-info"
echo "  5. 최근 결과: show-results"
echo ""

# 팀 디렉토리로 이동
cd ~/ai-company/$TEAM_ID

# 함수 정의
claude-start() {
    echo "🤖 Claude 실행..."
    echo ""
    echo "~/ai-company/$TEAM_ID/TEAM.md 를 참고하여"
    echo "업무를 수행해주세요."
    echo ""
    cd ~/ai-company
    claude
}

gemini-start() {
    if [ -z "$1" ]; then
        echo "❌ 사용법: gemini-start \"작업 내용\""
        return 1
    fi
    echo "🤖 Gemini 실행..."
    ~/ai-company/scripts/run-gemini.sh "$1" "$TEAM_ID"
}

parallel-start() {
    if [ -z "$1" ]; then
        echo "❌ 사용법: parallel-start \"작업 내용\""
        return 1
    fi
    echo "🤖 Claude & Gemini 병렬 실행..."
    ~/ai-company/scripts/parallel-ai.sh --task "$1" --team "$TEAM_ID" --compare
}

team-info() {
    echo "📋 팀 정보"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    head -30 ~/ai-company/$TEAM_ID/TEAM.md
}

show-results() {
    echo "📊 최근 결과"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Claude 결과:"
    ls -lt ~/ai-company/$TEAM_ID/outputs/claude/ | head -5
    echo ""
    echo "Gemini 결과:"
    ls -lt ~/ai-company/$TEAM_ID/outputs/gemini/ | head -5
    echo ""
    echo "최종 결과:"
    ls -lt ~/ai-company/$TEAM_ID/outputs/final/ | head -5
}

export -f claude-start gemini-start parallel-start team-info show-results

# 새 zsh 세션 시작
exec zsh
SCRIPT_EOF

    # TEAM_ID와 TEAM_NAME 치환
    sed -i '' "s/TEAM_ID_PLACEHOLDER/$team_id/g" "$APP_PATH/Contents/MacOS/run.sh"
    sed -i '' "s/TEAM_NAME_PLACEHOLDER/$team_name/g" "$APP_PATH/Contents/MacOS/run.sh"
    
    chmod +x "$APP_PATH/Contents/MacOS/run.sh"
    
    # Info.plist 생성
    cat > "$APP_PATH/Contents/Info.plist" <<PLIST_EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>run.sh</string>
    <key>CFBundleIdentifier</key>
    <string>com.aicompany.${team_id}</string>
    <key>CFBundleName</key>
    <string>${team_name}</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
</dict>
</plist>
PLIST_EOF

    echo "✅ $team_name 생성 완료"
    echo ""
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 모든 터미널 앱 생성 완료!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "위치: $APPS_DIR"
echo ""
echo "사용 방법:"
echo "1. Finder에서 ~/ai-company/terminal-apps 열기"
echo "2. 원하는 팀 앱을 더블클릭"
echo ""
echo "또는 명령어로 실행:"
echo "  open ~/ai-company/terminal-apps/조사팀.app"
echo ""
