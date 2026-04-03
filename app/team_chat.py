#!/usr/bin/env python3
"""AI Company Team Chat - Claude Code CLI 연동 팀별 대화 앱"""

import os
import sys
import glob
import argparse
import subprocess
import shutil

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TEAMS_DIR = os.path.join(BASE_DIR, "teams")

TEAM_MAP = {
    "research":         ("01-research",         "조사팀",        "🔍"),
    "debate":           ("02-debate",           "토론팀",        "💬"),
    "synthesis":        ("03-synthesis",        "종합팀",        "🧩"),
    "quality":          ("04-quality",          "퀄리티팀",      "✅"),
    "planning":         ("05-planning",         "기획팀",        "📋"),
    "design":           ("06-design",           "디자인팀",      "🎨"),
    "development":      ("07-development",      "개발팀",        "💻"),
    "devops":           ("08-devops",           "DevOps팀",      "⚙️"),
    "security":         ("09-security",         "보안팀",        "🔒"),
    "marketing":        ("10-marketing",        "마케팅팀",      "📢"),
    "sales":            ("11-sales",            "세일즈팀",      "🤝"),
    "customer-support": ("12-customer-support", "고객지원팀",    "🎧"),
    "data-analytics":   ("13-data-analytics",   "데이터분석팀",  "📊"),
    "legal":            ("14-legal",            "법무팀",        "⚖️"),
    "finance":          ("15-finance",          "재무팀",        "💰"),
    "leadership":       ("16-leadership",       "리더십팀",      "👔"),
    "documentation":    ("17-documentation",    "문서화팀",      "📝"),
}


def load_team_members(team_key):
    """팀 디렉토리에서 구성원 정보를 로드"""
    folder_name = TEAM_MAP[team_key][0]
    team_dir = os.path.join(TEAMS_DIR, folder_name)
    members = []
    for md_file in sorted(glob.glob(os.path.join(team_dir, "*.md"))):
        with open(md_file, "r", encoding="utf-8") as f:
            members.append(f.read())
    return members


def build_system_prompt(team_key):
    """팀별 시스템 프롬프트 생성"""
    _, team_name_kr, emoji = TEAM_MAP[team_key]
    members = load_team_members(team_key)
    members_text = "\n\n---\n\n".join(members)

    return f"""당신은 AI 회사의 {emoji} {team_name_kr} 소속 전문가 그룹입니다.
아래는 팀 구성원들의 프로필입니다. 사용자의 질문에 대해 각 구성원의 관점에서 전문적으로 답변하세요.

## 팀 구성원 프로필

{members_text}

## 응답 규칙
1. 각 구성원의 역할과 전문 분야에 맞게 답변하세요.
2. 여러 구성원이 관련된 질문이면, 각자의 관점을 [이름] 형태로 구분하여 답변하세요.
3. 실무적이고 구체적인 조언을 제공하세요.
4. 한국어로 답변하세요.
5. 팀 내부 토론이 필요하면 구성원 간 대화 형식으로 보여주세요.
"""


def check_claude_cli():
    """claude CLI 설치 확인"""
    claude_path = shutil.which("claude")
    if not claude_path:
        print("\033[1;31m[오류] claude CLI를 찾을 수 없습니다.\033[0m")
        print("\033[0;33m설치: npm install -g @anthropic-ai/claude-code\033[0m")
        input("\n아무 키나 눌러 종료...")
        sys.exit(1)
    return claude_path


def launch_claude_interactive(team_key, claude_path):
    """claude CLI 대화형 모드로 실행"""
    system_prompt = build_system_prompt(team_key)
    _, team_name_kr, emoji = TEAM_MAP[team_key]

    cmd = [
        claude_path,
        "--system-prompt", system_prompt,
        "--model", "sonnet",
    ]

    os.execvp(claude_path, cmd)


def print_header(team_key):
    """팀 헤더 출력"""
    _, team_name_kr, emoji = TEAM_MAP[team_key]
    members = load_team_members(team_key)

    width = 60
    print("\033[1;36m" + "=" * width + "\033[0m")
    print(f"\033[1;37m  {emoji}  {team_name_kr} - AI Company Team Chat\033[0m")
    print(f"\033[0;90m  구성원 {len(members)}명 | Claude Code CLI 연동\033[0m")
    print("\033[1;36m" + "=" * width + "\033[0m")

    folder_name = TEAM_MAP[team_key][0]
    team_dir = os.path.join(TEAMS_DIR, folder_name)
    for md_file in sorted(glob.glob(os.path.join(team_dir, "*.md"))):
        name = os.path.splitext(os.path.basename(md_file))[0].replace("-", " ")
        print(f"\033[0;33m  • {name}\033[0m")

    print("\033[1;36m" + "=" * width + "\033[0m\n")


def main():
    parser = argparse.ArgumentParser(description="AI Company Team Chat")
    parser.add_argument("--team", required=True, choices=TEAM_MAP.keys(),
                        help="팀 식별자")
    args = parser.parse_args()

    claude_path = check_claude_cli()
    print_header(args.team)
    launch_claude_interactive(args.team, claude_path)


if __name__ == "__main__":
    main()
