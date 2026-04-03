#!/bin/bash
# 전략팀 앱을 바탕화면으로 설치하는 스크립트
# 실행: bash ~/Desktop/ai-company/install_strategy_app.sh

DESKTOP="$HOME/Desktop"
AI_COMPANY="$DESKTOP/ai-company"
APP_NAME="🎯 전략팀.app"
SRC="$AI_COMPANY/$APP_NAME"
DEST="$DESKTOP/$APP_NAME"

echo ""
echo "🎯 전략팀 앱 설치"
echo "━━━━━━━━━━━━━━━━━━━━━━━━"

if [ ! -d "$SRC" ]; then
    echo "❌ 소스 앱을 찾을 수 없습니다: $SRC"
    exit 1
fi

# 기존 앱이 있으면 제거
if [ -d "$DEST" ]; then
    echo "🔄 기존 앱 교체 중..."
    rm -rf "$DEST"
fi

# 바탕화면으로 복사
cp -R "$SRC" "$DEST"

# 격리 속성 제거 (Gatekeeper)
xattr -cr "$DEST" 2>/dev/null

# 실행 권한 확인
chmod +x "$DEST/Contents/MacOS/launcher"

echo "✅ 설치 완료: $DEST"
echo ""
echo "💡 바탕화면에서 🎯 전략팀 앱을 더블클릭하세요!"
echo ""

# 아이콘 생성 시도 (generate_team_icons.py가 있으면)
ICON_SCRIPT="$AI_COMPANY/app/generate_team_icons.py"
if [ -f "$ICON_SCRIPT" ]; then
    echo "🎨 아이콘도 생성하시겠습니까? (y/n)"
    read -p "  선택: " gen_icon
    if [ "$gen_icon" = "y" ] || [ "$gen_icon" = "Y" ]; then
        python3 "$ICON_SCRIPT" 2>/dev/null
        echo "✅ 아이콘 생성 완료"
    fi
fi
