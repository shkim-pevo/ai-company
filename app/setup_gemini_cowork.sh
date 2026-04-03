#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Gemini CLI - Cowork 환경 설정
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 사용법: bash app/setup_gemini_cowork.sh YOUR_API_KEY
#
# API 키 발급: https://aistudio.google.com/apikey
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo ""
echo -e "\033[1;34m🔵 Gemini CLI - Cowork 환경 설정\033[0m"
echo ""

API_KEY="${1}"

if [ -z "$API_KEY" ]; then
  echo -e "\033[1;33m📋 API 키 발급 방법:\033[0m"
  echo ""
  echo "  1. https://aistudio.google.com/apikey 접속"
  echo "  2. Google 계정 로그인"
  echo "  3. 'Create API Key' 클릭"
  echo "  4. 키 복사"
  echo ""
  read -sp "  발급받은 API 키를 입력하세요: " API_KEY
  echo ""
  echo ""
fi

if [ -z "$API_KEY" ]; then
  echo -e "\033[1;31m❌ API 키가 입력되지 않았습니다.\033[0m"
  exit 1
fi

# Create .gemini settings directory
GEMINI_DIR="$HOME/.gemini"
mkdir -p "$GEMINI_DIR"

# Write settings.json with API key auth
cat > "$GEMINI_DIR/settings.json" <<EOJSON
{
  "theme": "Default",
  "selectedAuthType": "api-key"
}
EOJSON

# Export to shell profiles
for PROFILE in "$HOME/.bashrc" "$HOME/.zshrc"; do
  if [ -f "$PROFILE" ] || [ "$(basename $PROFILE)" = ".bashrc" ]; then
    # Remove old entries
    grep -v "GEMINI_API_KEY" "$PROFILE" > "${PROFILE}.tmp" 2>/dev/null || true
    mv "${PROFILE}.tmp" "$PROFILE" 2>/dev/null || true
    # Add new entry
    echo "" >> "$PROFILE"
    echo "# Gemini CLI API Key (auto-configured)" >> "$PROFILE"
    echo "export GEMINI_API_KEY=\"${API_KEY}\"" >> "$PROFILE"
  fi
done

# Export for current session
export GEMINI_API_KEY="$API_KEY"

echo -e "\033[1;32m✅ Gemini CLI 설정 완료!\033[0m"
echo ""

# Quick test
echo -e "\033[0;90m  테스트 중...\033[0m"
GEMINI_BIN="$(dirname "$0")/../node_modules/.bin/gemini"
if [ ! -f "$GEMINI_BIN" ]; then
  GEMINI_BIN="$(cd "$(dirname "$0")/.." && pwd)/node_modules/.bin/gemini"
fi

RESULT=$(GEMINI_API_KEY="$API_KEY" timeout 15 "$GEMINI_BIN" -p "Say '연결 성공' in Korean" 2>&1)
if echo "$RESULT" | grep -q "연결"; then
  echo -e "\033[1;32m  ✅ Gemini 연결 확인됨!\033[0m"
  echo ""
  echo -e "\033[0;90m  응답: $RESULT\033[0m"
else
  echo -e "\033[1;33m  ⚠️ 응답 확인 필요:\033[0m"
  echo -e "\033[0;90m  $RESULT\033[0m"
fi

echo ""
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;37m  이제 Cowork과 바탕화면 팀 앱에서\033[0m"
echo -e "\033[1;37m  Gemini CLI를 사용할 수 있습니다.\033[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
