#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🆕 신규 팀 바탕화면 앱 설치 도구
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
# 사용법:
#   bash app/setup_new_team.sh
#
# 기능:
#   1. 런처 스크립트(launch-{팀}.sh) 자동 생성
#   2. .app 번들 생성 + 바탕화면 설치
#   3. macOS 네이티브 아이콘 생성
#   4. 관련 파일(diagnose, generate_icons 등) 자동 업데이트
#   5. team_assignments 폴더 생성
#
# 예시:
#   bash app/setup_new_team.sh
#   → 대화형으로 팀 정보 입력
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -e

DESKTOP="$HOME/Desktop"
AI_COMPANY_DIR="$DESKTOP/ai-company"
LAUNCHERS_DIR="$AI_COMPANY_DIR/app/launchers"
TEAMS_DIR="$AI_COMPANY_DIR/teams"

echo ""
echo -e "\033[1;36m╔══════════════════════════════════════════╗\033[0m"
echo -e "\033[1;37m║  🆕 신규 팀 바탕화면 앱 설치 도구       ║\033[0m"
echo -e "\033[1;36m╚══════════════════════════════════════════╝\033[0m"
echo ""

# ━━━ STEP 1: 팀 정보 입력 ━━━
echo -e "\033[1;33m━━━ STEP 1: 팀 정보 입력 ━━━\033[0m"
echo ""

read -p "  팀 영문 키 (예: strategy, brand-council): " TEAM_KEY
read -p "  팀 한글 이름 (예: 전략팀): " TEAM_KR_NAME
read -p "  팀 이모지 (예: 🎯): " TEAM_EMOJI
read -p "  팀 번호 (예: 19): " TEAM_NUM
read -p "  팀장 직함 (예: CSO, 전략팀장): " TEAM_LEADER
read -p "  팀원 목록 (쉼표 구분, 예: 사업전략가,시장전략가,파트너십전략가,성장전략가): " TEAM_MEMBERS
read -p "  아이콘 주 색상 RGB (예: 255,107,53): " TEAM_COLOR_STR

echo ""

# 색상 파싱
IFS=',' read -r COLOR_R COLOR_G COLOR_B <<< "$TEAM_COLOR_STR"

# 변수 검증
if [ -z "$TEAM_KEY" ] || [ -z "$TEAM_KR_NAME" ] || [ -z "$TEAM_EMOJI" ]; then
    echo -e "\033[1;31m  ❌ 필수 정보가 누락되었습니다.\033[0m"
    exit 1
fi

TEAM_FOLDER="${TEAM_NUM}-${TEAM_KEY}"
LAUNCHER_FILE="launch-${TEAM_KEY}.sh"
CLEAN_EMOJI=$(echo "$TEAM_EMOJI" | sed 's/\xef\xb8\x8f//g')
APP_NAME="${CLEAN_EMOJI} ${TEAM_KR_NAME}.app"

echo -e "\033[0;90m  팀 키: $TEAM_KEY\033[0m"
echo -e "\033[0;90m  폴더: teams/$TEAM_FOLDER\033[0m"
echo -e "\033[0;90m  런처: $LAUNCHER_FILE\033[0m"
echo -e "\033[0;90m  앱:   $APP_NAME\033[0m"
echo ""

read -p "  계속 진행하시겠습니까? (y/n): " CONFIRM
if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo "  종료합니다."
    exit 0
fi
echo ""

# ━━━ STEP 2: teams/ 폴더 생성 ━━━
echo -e "\033[1;33m━━━ STEP 2: 팀 프로필 폴더 생성 ━━━\033[0m"

TEAM_DIR="$TEAMS_DIR/$TEAM_FOLDER"
if [ ! -d "$TEAM_DIR" ]; then
    mkdir -p "$TEAM_DIR"

    # 팀장 프로필 생성
    cat > "$TEAM_DIR/팀장.md" << MDEOF
# ${TEAM_KR_NAME}장 (${TEAM_LEADER})

## 역할
- ${TEAM_KR_NAME}의 총괄 책임자
- 업무 접수, 실무자 배분, 취합 보고, 최종 보고 담당
- 리더십팀과의 커뮤니케이션 창구

## 전문 분야
- 팀 운영 및 업무 조율
- 전략적 의사결정 지원
- 보고서 작성 및 경영진 보고

## 보고 체계
- CEO 김상현 대표님에게 보고
MDEOF

    # 팀원 프로필 생성
    IFS=',' read -ra MEMBERS <<< "$TEAM_MEMBERS"
    for member in "${MEMBERS[@]}"; do
        member=$(echo "$member" | xargs)  # trim
        cat > "$TEAM_DIR/${member}.md" << MDEOF
# ${member}

## 역할
- ${TEAM_KR_NAME}의 실무 담당자
- ${member} 분야 전문가

## 전문 분야
- (구체적인 전문 분야를 여기에 추가하세요)

## 보고 체계
- ${TEAM_LEADER}에게 보고
MDEOF
    done

    echo -e "  ✅ $TEAM_DIR 생성 완료 (팀장 + ${#MEMBERS[@]}명)"
else
    echo -e "  ⏭️  $TEAM_DIR 이미 존재"
fi

# ━━━ STEP 3: 런처 스크립트 생성 ━━━
echo -e "\033[1;33m━━━ STEP 3: 런처 스크립트 생성 ━━━\033[0m"

LAUNCHER_PATH="$LAUNCHERS_DIR/$LAUNCHER_FILE"
if [ ! -f "$LAUNCHER_PATH" ]; then
    cat > "$LAUNCHER_PATH" << 'LAUNCHEOF'
#!/bin/bash
clear
# EMOJI TEAM_KR_NAME - AI Company Team Chat

TEAM_DIR="TEAM_DIR_PLACEHOLDER"
GEMINI_BIN="GEMINI_BIN_PLACEHOLDER"
WORKFLOW_FILE="WORKFLOW_PLACEHOLDER"
AI_COMPANY_DIR="AI_COMPANY_PLACEHOLDER"
TEAM_ID="TEAM_ID_PLACEHOLDER"


# Build system prompt with hierarchy workflow
build_prompt() {
  local prompt="당신은 AI 회사의 EMOJI TEAM_KR_NAME입니다.
당신은 **TEAM_LEADER_PLACEHOLDER** 역할을 중심으로 팀을 운영합니다.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## 업무 처리 프로세스 (반드시 이 순서로 응답)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### STEP 1: [TEAM_LEADER_PLACEHOLDER] 업무 접수
- 김상현 대표님의 요청을 분석하고, 관련 실무자를 배정합니다.
- 형식: \"📋 TEAM_LEADER_PLACEHOLDER: 업무를 접수했습니다. [실무자 이름]에게 배분합니다.\"

### STEP 2: [실무자들] 실무 작업
- 배정된 각 실무자가 자신의 전문 분야에서 의견/분석을 제시합니다.
- 형식: \"[실무자 이름]: (전문적 의견)\"

### STEP 3: [TEAM_LEADER_PLACEHOLDER] 취합 보고
- 팀장이 실무자들의 결과를 종합합니다.
- 형식: \"📊 TEAM_LEADER_PLACEHOLDER 취합: (종합 정리)\"

### STEP 4: [리더십] 경영진 검토
- 리더십팀(CEO, CTO, COO, CMO, CPO, CSO 중 관련자)이 전략적 관점에서 코멘트합니다.
- 형식: \"👔 [리더십 직함]: (전략적 피드백)\"

### STEP 5: [TEAM_LEADER_PLACEHOLDER] 최종 보고
- 팀장이 리더십 피드백을 반영한 최종 결과를 김상현 대표님에게 보고합니다.
- 형식:
  ┌─────────────────────────────┐
  │  📋 TEAM_KR_NAME 최종 보고서       │
  ├─────────────────────────────┤
  │  1. 핵심 요약                │
  │  2. 실무진 분석 결과           │
  │  3. 리더십 피드백              │
  │  4. 권고 사항 / 액션 아이템     │
  └─────────────────────────────┘

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## 응답 규칙
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. 반드시 위 5단계를 순서대로 시뮬레이션하세요.
2. 각 실무자는 자신의 전문 분야에 맞게 발언하세요.
3. 팀장은 중립적으로 취합하고, 리더십은 전략적 관점에서 코멘트하세요.
4. 한국어로 답변하세요.
5. 간단한 질문이라도 최소 STEP 1, 2, 5는 포함하세요.


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## 워크플로우 설계
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### 1. 기본은 계획 모드
- 사소하지 않은 모든 작업은 계획 모드로 시작
- 뭔가 잘못되면 즉시 멈추고 다시 계획 세우기

### 2. 서브에이전트 활용
- 메인 컨텍스트 창을 깔끔하게 유지하려면 서브에이전트를 적극적으로 활용

### 3. 자기개선 루프
- 사용자에게 수정을 받을 때마다: 해당 패턴을 tasks/lessons.md에 기록

### 4. 완료 전 반드시 검증
- 작동한다는 걸 증명하기 전까지 절대 작업 완료로 표시하지 말 것

### 5. 우아함을 추구할 것 (균형 있게)
- 사소하지 않은 변경이라면: \"더 우아한 방법이 있지 않을까?\" 자문

### 6. 자율적인 버그 수정
- 버그 리포트를 받으면: 그냥 고칠 것

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## 핵심 원칙
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
- **단순함 우선**: 모든 변경은 최대한 단순하게.
- **게으름 금지**: 근본 원인을 찾을 것.
- **최소 영향**: 꼭 필요한 부분만 수정.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## 작업물 저장 규칙 (Cowork 연동)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### 보고서 저장 위치
결과물을 저장할 때 반드시 아래 경로에 저장하세요:
- 경로: IR Deck/team_assignments/TEAM_ID_PLACEHOLDER/
- 파일명: YYYYMMDD_TEAM_ID_PLACEHOLDER_{문서명}.md

### 중요
- 저장된 파일은 Cowork 환경과 자동 동기화됩니다
- 기존 팀 작업물을 먼저 확인하고 중복 작업을 피하세요

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## 팀 구성원 프로필
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  for md_file in "\$TEAM_DIR"/*.md; do
    if [ -f "\$md_file" ]; then
      prompt="\${prompt}
---
\$(cat "\$md_file")"
    fi
  done
  echo "\$prompt"
}

# Header display
echo ""
echo -e "\033[1;36m╔══════════════════════════════════════════╗\033[0m"
echo -e "\033[1;37m║  EMOJI  TEAM_KR_NAME - AI Company Team Chat     ║\033[0m"
echo -e "\033[1;36m╠══════════════════════════════════════════╣\033[0m"
echo -e "\033[1;33m║  👤 팀장: TEAM_LEADER_PLACEHOLDER                       ║\033[0m"
echo -e "\033[1;36m╠══════════════════════════════════════════╣\033[0m"
echo -e "\033[0;37m║  실무자:                                 ║\033[0m"
for md in "\$TEAM_DIR"/*.md; do
  name=\$(basename "\$md" .md | tr '-' ' ')
  if [[ "\$name" != *"팀장"* ]]; then
    echo -e "\033[0;33m║    • \$name\033[0m"
  fi
done
echo -e "\033[1;36m╠══════════════════════════════════════════╣\033[0m"
echo -e "\033[0;90m║  보고체계: 실무자 → 팀장 → 리더십 → 김상현 대표님 ║\033[0m"
echo -e "\033[1;36m╠══════════════════════════════════════════╣\033[0m"
echo -e "\033[1;37m║  AI 엔진 선택:                           ║\033[0m"
echo -e "\033[1;32m║    [1] 🟣 Claude                         ║\033[0m"
echo -e "\033[1;34m║    [2] 🔵 Gemini                         ║\033[0m"
echo -e "\033[1;35m║    [3] 🤖 병렬 실행 (Claude + Gemini)    ║\033[0m"
echo -e "\033[0;90m║    [4] 종료                              ║\033[0m"
echo -e "\033[1;36m╚══════════════════════════════════════════╝\033[0m"
echo ""
read -p "  선택 (1/2/3/4): " choice
echo ""

SYSTEM_PROMPT=\$(build_prompt)

case \$choice in
  1)
    echo -e "\033[1;32m🟣 Claude + EMOJI TEAM_KR_NAME 시작...\033[0m"
    echo ""
    cd "CD_PLACEHOLDER"
    exec claude --system-prompt "\$SYSTEM_PROMPT" --model sonnet
    ;;
  2)
    echo -e "\033[1;34m🔵 Gemini + EMOJI TEAM_KR_NAME 시작...\033[0m"
    echo ""
    cd "CD_PLACEHOLDER"
    exec "\$GEMINI_BIN" -i "\$SYSTEM_PROMPT"
    ;;
  3)
    echo -e "\033[1;35m🤖 병렬 실행 모드\033[0m"
    echo ""
    read -p "작업 내용을 입력하세요: " task
    echo ""
    if [ -z "\$task" ]; then
      echo "작업 내용이 비어있습니다."
      exit 1
    fi
    exec "\$AI_COMPANY_DIR/scripts/parallel-ai.sh" --task "\$task" --team "\$TEAM_ID" --compare

    ;;
  4|*)
    echo -e "\033[0;90m종료합니다.\033[0m"
    exit 0
    ;;
esac
LAUNCHEOF

    # Replace placeholders
    sed -i "s|TEAM_DIR_PLACEHOLDER|$TEAM_DIR|g" "$LAUNCHER_PATH"
    sed -i "s|GEMINI_BIN_PLACEHOLDER|$AI_COMPANY_DIR/node_modules/.bin/gemini|g" "$LAUNCHER_PATH"
    sed -i "s|WORKFLOW_PLACEHOLDER|$AI_COMPANY_DIR/app/workflow.md|g" "$LAUNCHER_PATH"
    sed -i "s|AI_COMPANY_PLACEHOLDER|$HOME/ai-company|g" "$LAUNCHER_PATH"
    sed -i "s|CD_PLACEHOLDER|$AI_COMPANY_DIR|g" "$LAUNCHER_PATH"
    sed -i "s|TEAM_ID_PLACEHOLDER|$TEAM_KEY|g" "$LAUNCHER_PATH"
    sed -i "s|TEAM_LEADER_PLACEHOLDER|$TEAM_LEADER|g" "$LAUNCHER_PATH"
    sed -i "s|TEAM_KR_NAME|$TEAM_KR_NAME|g" "$LAUNCHER_PATH"
    sed -i "s|EMOJI|$TEAM_EMOJI|g" "$LAUNCHER_PATH"

    chmod +x "$LAUNCHER_PATH"
    echo -e "  ✅ $LAUNCHER_FILE 생성 완료"
else
    echo -e "  ⏭️  $LAUNCHER_FILE 이미 존재"
fi

# ━━━ STEP 4: .app 번들 생성 ━━━
echo -e "\033[1;33m━━━ STEP 4: .app 번들 생성 ━━━\033[0m"

APP_PATH="$DESKTOP/$APP_NAME"
if [ -d "$APP_PATH" ]; then
    echo -e "  ⏭️  $APP_NAME 이미 존재, 덮어씁니다"
    rm -rf "$APP_PATH"
fi

# 디렉토리 구조
mkdir -p "$APP_PATH/Contents/MacOS"
mkdir -p "$APP_PATH/Contents/Resources"

# Info.plist
cat > "$APP_PATH/Contents/Info.plist" << PLISTEOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>launcher</string>
    <key>CFBundleName</key>
    <string>${TEAM_EMOJI} ${TEAM_KR_NAME}</string>
    <key>CFBundleDisplayName</key>
    <string>${TEAM_KR_NAME}</string>
    <key>CFBundleIdentifier</key>
    <string>com.pevo.ai-company.${TEAM_KEY}</string>
    <key>CFBundleVersion</key>
    <string>2.0</string>
    <key>CFBundleShortVersionString</key>
    <string>2.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleSignature</key>
    <string>????</string>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string>
    <key>LSMinimumSystemVersion</key>
    <string>12.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
PLISTEOF

# 실행 스크립트
cat > "$APP_PATH/Contents/MacOS/launcher" << EXECEOF
#!/bin/bash
# ${TEAM_EMOJI} ${TEAM_KR_NAME} - AI Company Team App

LAUNCHER="$LAUNCHER_PATH"

if [ ! -f "\$LAUNCHER" ]; then
    osascript -e 'display dialog "${TEAM_KR_NAME} 런처 스크립트를 찾을 수 없습니다.\n경로: '\$LAUNCHER'" buttons {"확인"} default button 1 with icon stop with title "AI Company 오류"'
    exit 1
fi

# Terminal.app에서 새 창으로 실행
osascript <<'APPLESCRIPT'
tell application "Terminal"
    activate
    do script "bash \"$LAUNCHER_PATH\""
end tell
APPLESCRIPT
EXECEOF

chmod +x "$APP_PATH/Contents/MacOS/launcher"

# 격리 속성 제거
xattr -cr "$APP_PATH" 2>/dev/null

echo -e "  ✅ $APP_NAME 바탕화면에 설치 완료"

# ━━━ STEP 5: 아이콘 생성 ━━━
echo -e "\033[1;33m━━━ STEP 5: 아이콘 생성 ━━━\033[0m"

ICNS_PATH="$APP_PATH/Contents/Resources/AppIcon.icns"

# generate_team_icons.py를 활용하여 단일 팀 아이콘 생성
python3 -c "
import subprocess, os, tempfile, sys
sys.path.insert(0, '$AI_COMPANY_DIR/app')

emoji = '${TEAM_EMOJI}'.replace('\ufe0f', '')
label = '${TEAM_KR_NAME}'
primary = (${COLOR_R:-128}, ${COLOR_G:-128}, ${COLOR_B:-128})
secondary = (min(255, ${COLOR_R:-128}+30), min(255, ${COLOR_G:-128}+30), min(255, ${COLOR_B:-128}+30))
accent = (min(255, ${COLOR_R:-128}+90), min(255, ${COLOR_G:-128}+90), min(255, ${COLOR_B:-128}+90))
sub_icons = '🧭📐🚀'
output = '$ICNS_PATH'

try:
    from generate_team_icons import create_team_icon, png_to_icns
    with tempfile.TemporaryDirectory() as tmpdir:
        master = os.path.join(tmpdir, 'master.png')
        ok = create_team_icon(emoji, label, sub_icons, primary, secondary, accent, master)
        if ok:
            png_to_icns(master, output)
            print(f'✅ 네이티브 아이콘 생성 완료: {os.path.getsize(output):,} bytes')
        else:
            raise Exception('AppKit 렌더링 실패')
except Exception as e:
    # Fallback: generate_icons.py의 방식
    try:
        from generate_icons import create_iconset
        create_iconset(emoji, label, primary, output)
        print(f'✅ 아이콘 생성 완료 (fallback): {os.path.getsize(output):,} bytes')
    except:
        print(f'⚠️  아이콘 자동 생성 실패: {e}')
        print('   수동 생성: python3 app/generate_team_icons.py')
" 2>/dev/null

if [ -f "$ICNS_PATH" ]; then
    echo -e "  ✅ 아이콘 적용 완료"
else
    echo -e "  ⚠️  아이콘 생성 실패 — 수동으로 실행하세요:"
    echo -e "     python3 app/generate_team_icons.py"
fi

# ━━━ STEP 6: team_assignments 폴더 ━━━
echo -e "\033[1;33m━━━ STEP 6: team_assignments 폴더 ━━━\033[0m"

ASSIGN_DIR="$AI_COMPANY_DIR/IR Deck/team_assignments/$TEAM_KEY"
if [ ! -d "$ASSIGN_DIR" ]; then
    mkdir -p "$ASSIGN_DIR"
    echo -e "  ✅ $ASSIGN_DIR 생성"
else
    echo -e "  ⏭️  이미 존재"
fi

# ━━━ STEP 7: 아이콘 캐시 갱신 ━━━
echo -e "\033[1;33m━━━ STEP 7: 아이콘 캐시 갱신 ━━━\033[0m"

touch "$APP_PATH"
killall Dock 2>/dev/null || true
echo -e "  ✅ Dock 갱신 완료"

# ━━━ 완료 ━━━
echo ""
echo -e "\033[1;36m╔══════════════════════════════════════════╗\033[0m"
echo -e "\033[1;32m║  ✅ ${TEAM_EMOJI} ${TEAM_KR_NAME} 설치 완료!               ║\033[0m"
echo -e "\033[1;36m╠══════════════════════════════════════════╣\033[0m"
echo -e "\033[0;37m║  생성된 파일:                             ║\033[0m"
echo -e "\033[0;33m║    📁 teams/$TEAM_FOLDER/              ║\033[0m"
echo -e "\033[0;33m║    📄 app/launchers/$LAUNCHER_FILE     ║\033[0m"
echo -e "\033[0;33m║    📱 ~/Desktop/$APP_NAME              ║\033[0m"
echo -e "\033[0;33m║    📂 IR Deck/team_assignments/$TEAM_KEY/ ║\033[0m"
echo -e "\033[1;36m╠══════════════════════════════════════════╣\033[0m"
echo -e "\033[0;90m║  💡 바탕화면에서 앱을 더블클릭하세요!     ║\033[0m"
echo -e "\033[0;90m║                                          ║\033[0m"
echo -e "\033[0;90m║  ⚠️  앱이 안 열리면:                     ║\033[0m"
echo -e "\033[0;90m║  xattr -cr ~/Desktop/${CLEAN_EMOJI}*.app  ║\033[0m"
echo -e "\033[1;36m╚══════════════════════════════════════════╝\033[0m"
echo ""
