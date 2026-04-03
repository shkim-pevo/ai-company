#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Gemini 배치 병행 작업
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 여러 팀에 동시에 Gemini 작업을 배분
#
# 사용법:
#   bash app/gemini_batch.sh "공통 작업 주제"
#
# 예시:
#   bash app/gemini_batch.sh "V3 피치덱 각 팀 관점에서 검토"
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

AI_COMPANY_DIR="/Users/sanghyunkim/Desktop/ai-company"
TASK="$1"

if [ -z "$TASK" ]; then
  echo ""
  echo -e "\033[1;34m🔵 Gemini 배치 병행 작업\033[0m"
  echo ""
  echo "사용법: bash app/gemini_batch.sh \"공통 작업 주제\""
  echo ""
  echo "각 팀(조사/토론/종합)이 동시에 Gemini로 작업합니다."
  echo "결과는 team_assignments 폴더에 자동 저장됩니다."
  echo ""
  exit 0
fi

echo ""
echo -e "\033[1;35m🤖 Gemini 배치 병행 실행\033[0m"
echo -e "\033[0;90m  주제: $TASK\033[0m"
echo ""

# 핵심 3팀 병행 실행
TEAMS=("research" "debate" "synthesis")
TEAM_NAMES=("조사팀" "토론팀" "종합팀")
PIDS=()

for i in "${!TEAMS[@]}"; do
  team="${TEAMS[$i]}"
  name="${TEAM_NAMES[$i]}"
  echo -e "\033[1;34m  🔵 ${name} Gemini 작업 시작...\033[0m"
  bash "$AI_COMPANY_DIR/app/gemini_parallel.sh" "$TASK - ${name} 관점에서 분석" "$team" &
  PIDS+=($!)
done

echo ""
echo -e "\033[0;90m  3개 팀 병행 실행 중... 완료까지 대기\033[0m"
echo ""

# 모든 작업 완료 대기
FAILED=0
for i in "${!PIDS[@]}"; do
  wait ${PIDS[$i]}
  if [ $? -ne 0 ]; then
    FAILED=$((FAILED + 1))
  fi
done

echo ""
if [ $FAILED -eq 0 ]; then
  echo -e "\033[1;32m✅ 전체 완료! 3개 팀 결과 저장됨\033[0m"
else
  echo -e "\033[1;33m⚠️ ${FAILED}개 팀 작업 중 오류 발생\033[0m"
fi

echo ""
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;37m  결과 확인:\033[0m"
echo -e "\033[0;90m  IR Deck/team_assignments/research/  (조사팀)\033[0m"
echo -e "\033[0;90m  IR Deck/team_assignments/debate/    (토론팀)\033[0m"
echo -e "\033[0;90m  IR Deck/team_assignments/synthesis/  (종합팀)\033[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo -e "\033[1;37m  Cowork에서 자동 동기화됩니다.\033[0m"
echo ""
