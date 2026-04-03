#!/usr/bin/env python3
"""
런처 스크립트 일괄 보완 도구
1. 작업 디렉토리(cd) 자동 설정 추가
2. 시스템 프롬프트에 team_assignments 저장 규칙 추가
"""

import os
import re
import glob
import shutil
from datetime import datetime

LAUNCHERS_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "launchers")
BACKUP_SUFFIX = f".backup_{datetime.now().strftime('%Y%m%d_%H%M%S')}"

# 팀명 매핑 (launcher 파일명 → team_assignments 폴더명)
TEAM_FOLDER_MAP = {
    "research": "research",
    "debate": "debate",
    "synthesis": "synthesis",
    "quality": "quality",
    "planning": "planning",
    "design": "design",
    "development": "development",
    "devops": "devops",
    "security": "security",
    "marketing": "marketing",
    "sales": "sales",
    "customer-support": "customer-support",
    "data-analytics": "data-analytics",
    "legal": "legal",
    "finance": "finance",
    "leadership": "leadership",
    "documentation": "documentation",
    "strategy": "strategy",
}

# 시스템 프롬프트에 추가할 저장 규칙
SAVE_RULES = r"""

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## 작업물 저장 규칙 (Cowork 연동)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### 보고서 저장 위치
결과물을 저장할 때 반드시 아래 경로에 저장하세요:
- 경로: IR Deck/team_assignments/{TEAM_FOLDER}/
- 파일명: YYYYMMDD_{TEAM_ID}_{문서명}.md
- 예시: 20260223_{TEAM_ID}_market_analysis.md

### 참고 자료 위치
- 기존 작업물: IR Deck/team_assignments/ 하위 폴더
- 마스터 지시서: IR Deck/team_assignments/00_MASTER_ASSIGNMENT.md
- 최종 요약: IR Deck/team_assignments/00_FINAL_SUMMARY.md
- 최신 피치덱: IR Deck/Pevo_IR_Pitchdeck_V3_Content.md

### 중요
- 저장된 파일은 Cowork 환경과 자동 동기화됩니다
- 기존 팀 작업물을 먼저 확인하고 중복 작업을 피하세요"""


def patch_launcher(filepath):
    """런처 스크립트 보완"""
    filename = os.path.basename(filepath)

    # launch-research-updated.sh 같은 특수 파일 건너뛰기
    if "updated" in filename or filename.endswith(".backup") or BACKUP_SUFFIX in filename:
        return False

    # 팀 ID 추출 (launch-{team_id}.sh)
    match = re.match(r"launch-(.+)\.sh$", filename)
    if not match:
        return False
    team_id = match.group(1)

    if team_id not in TEAM_FOLDER_MAP:
        print(f"  ⚠️  {filename}: 알 수 없는 팀 ID '{team_id}'")
        return False

    team_folder = TEAM_FOLDER_MAP[team_id]

    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()

    # 이미 패치되어 있는지 확인
    if "작업물 저장 규칙" in content:
        print(f"  ⏭️  {filename}: 이미 패치됨")
        return False

    # 백업 생성
    backup_path = filepath + BACKUP_SUFFIX
    shutil.copy2(filepath, backup_path)

    modified = content

    # 1. AI_COMPANY_DIR 경로 확인 및 cd 추가
    # exec claude 직전에 cd 삽입
    # 패턴: exec claude --system-prompt ...
    cd_line = '    cd "/Users/sanghyunkim/Desktop/ai-company"\n'

    # Claude 실행 부분
    modified = modified.replace(
        '    exec claude --system-prompt "$SYSTEM_PROMPT" --model sonnet',
        cd_line + '    exec claude --system-prompt "$SYSTEM_PROMPT" --model sonnet'
    )

    # Gemini 실행 부분
    modified = modified.replace(
        '    exec "$GEMINI_BIN" -i "$SYSTEM_PROMPT"',
        cd_line + '    exec "$GEMINI_BIN" -i "$SYSTEM_PROMPT"'
    )

    # 2. 시스템 프롬프트에 저장 규칙 추가
    # build_prompt() 함수 내 프롬프트 끝부분 (팀 구성원 프로필 전)에 추가
    save_rules = SAVE_RULES.replace("{TEAM_FOLDER}", team_folder).replace("{TEAM_ID}", team_id)

    # "팀 구성원 프로필" 섹션 직전에 삽입
    insert_marker = '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n## 팀 구성원 프로필'
    if insert_marker in modified:
        modified = modified.replace(
            insert_marker,
            save_rules + "\n\n" + insert_marker
        )
    else:
        # 대체 위치: 응답 규칙 뒤
        alt_marker = '5. 간단한 질문이라도 최소 STEP 1, 2, 5는 포함하세요.'
        if alt_marker in modified:
            modified = modified.replace(
                alt_marker,
                alt_marker + save_rules
            )

    # 파일 저장
    with open(filepath, "w", encoding="utf-8") as f:
        f.write(modified)

    return True


def main():
    print()
    print("=" * 55)
    print("  🔧 런처 스크립트 일괄 보완")
    print("  - 작업 디렉토리(cd) 자동 설정")
    print("  - 시스템 프롬프트에 저장 규칙 추가")
    print("=" * 55)
    print()

    if not os.path.isdir(LAUNCHERS_DIR):
        print(f"  ❌ 런처 디렉토리를 찾을 수 없습니다: {LAUNCHERS_DIR}")
        return

    launchers = sorted(glob.glob(os.path.join(LAUNCHERS_DIR, "launch-*.sh")))
    patched = 0
    skipped = 0

    for launcher in launchers:
        filename = os.path.basename(launcher)
        if "backup" in filename or "updated" in filename:
            continue

        if patch_launcher(launcher):
            print(f"  ✅ {filename}: 패치 완료")
            patched += 1
        else:
            skipped += 1

    print()
    print(f"  완료: {patched}개 패치 / {skipped}개 건너뜀")
    print(f"  백업 접미사: {BACKUP_SUFFIX}")
    print()


if __name__ == "__main__":
    main()
