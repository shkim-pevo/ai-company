#!/usr/bin/env python3
"""
AI Company 팀 앱 진단 및 수정 도구
- 바탕화면의 .app 번들을 검사하고 문제를 수정합니다
- 실행: python3 diagnose_and_fix_apps.py
"""

import os
import sys
import plistlib
import stat
import subprocess
import shutil

DESKTOP = os.path.expanduser("~/Desktop")
AI_COMPANY_DIR = os.path.join(DESKTOP, "ai-company")
LAUNCHERS_DIR = os.path.join(AI_COMPANY_DIR, "app", "launchers")

# 팀 정보: (key, korean_name, emoji, launcher_script)
TEAMS = [
    ("research",         "조사팀",       "🔍", "launch-research.sh"),
    ("debate",           "토론팀",       "💬", "launch-debate.sh"),
    ("synthesis",        "종합팀",       "🧩", "launch-synthesis.sh"),
    ("quality",          "퀄리티팀",     "✅", "launch-quality.sh"),
    ("planning",         "기획팀",       "📋", "launch-planning.sh"),
    ("design",           "디자인팀",     "🎨", "launch-design.sh"),
    ("development",      "개발팀",       "💻", "launch-development.sh"),
    ("devops",           "DevOps팀",     "⚙️", "launch-devops.sh"),
    ("security",         "보안팀",       "🔒", "launch-security.sh"),
    ("marketing",        "마케팅팀",     "📢", "launch-marketing.sh"),
    ("sales",            "세일즈팀",     "🤝", "launch-sales.sh"),
    ("customer-support", "고객지원팀",   "🎧", "launch-customer-support.sh"),
    ("data-analytics",   "데이터분석팀", "📊", "launch-data-analytics.sh"),
    ("legal",            "법무팀",       "⚖️", "launch-legal.sh"),
    ("finance",          "재무팀",       "💰", "launch-finance.sh"),
    ("leadership",       "리더십팀",     "👔", "launch-leadership.sh"),
    ("documentation",    "문서화팀",     "📝", "launch-documentation.sh"),
    ("strategy",         "전략팀",       "🎯", "launch-strategy.sh"),
]


def find_app_on_desktop(team_name):
    """바탕화면에서 팀 .app 찾기"""
    if not os.path.exists(DESKTOP):
        return None
    for entry in os.listdir(DESKTOP):
        if entry.endswith(".app") and team_name in entry:
            return os.path.join(DESKTOP, entry)
    return None


def check_app_structure(app_path):
    """앱 번들 구조 검사"""
    issues = []

    contents = os.path.join(app_path, "Contents")
    macos_dir = os.path.join(contents, "MacOS")
    info_plist = os.path.join(contents, "Info.plist")

    # 1. Contents 디렉토리
    if not os.path.isdir(contents):
        issues.append(("CRITICAL", "Contents 디렉토리 없음"))
        return issues

    # 2. Info.plist
    if not os.path.isfile(info_plist):
        issues.append(("CRITICAL", "Info.plist 없음"))
    else:
        try:
            with open(info_plist, "rb") as f:
                plist = plistlib.load(f)

            # CFBundleExecutable 확인
            executable = plist.get("CFBundleExecutable")
            if not executable:
                issues.append(("CRITICAL", "Info.plist에 CFBundleExecutable 미설정"))
            else:
                exec_path = os.path.join(macos_dir, executable)
                if not os.path.exists(exec_path):
                    issues.append(("CRITICAL", f"실행 파일 없음: {exec_path}"))
                else:
                    # 실행 권한 확인
                    st = os.stat(exec_path)
                    if not (st.st_mode & stat.S_IXUSR):
                        issues.append(("ERROR", f"실행 권한 없음: {exec_path}"))

                    # 스크립트 내용 확인
                    try:
                        with open(exec_path, "r", encoding="utf-8") as f:
                            content = f.read()

                        # shebang 확인
                        if not content.startswith("#!/"):
                            issues.append(("WARNING", "shebang(#!/...) 없음"))

                        # 경로 확인
                        if "/Users/sanghyunkim/" in content:
                            # 현재 사용자와 일치하는지
                            current_user = os.path.expanduser("~")
                            if "/Users/sanghyunkim/" not in current_user and "sanghyunkim" not in current_user:
                                issues.append(("ERROR", "사용자 경로 불일치"))

                        # 런처 스크립트 경로 확인
                        for line in content.split("\n"):
                            if "launch-" in line and ".sh" in line:
                                # 런처 스크립트 참조 추출
                                for word in line.split():
                                    if "launch-" in word and ".sh" in word:
                                        script_path = word.strip('"').strip("'")
                                        if script_path.startswith("/") and not os.path.exists(script_path):
                                            issues.append(("ERROR", f"런처 스크립트 경로 오류: {script_path}"))

                        # Terminal 열기 방식 확인
                        if "open -a Terminal" in content or "osascript" in content:
                            pass  # Terminal.app 방식
                        elif "open -a Warp" in content:
                            if not os.path.exists("/Applications/Warp.app"):
                                issues.append(("ERROR", "Warp.app이 설치되어 있지 않음"))

                        # claude CLI 확인
                        if "claude" in content:
                            claude_path = shutil.which("claude")
                            if not claude_path:
                                issues.append(("WARNING", "claude CLI가 PATH에 없음"))

                    except UnicodeDecodeError:
                        pass  # 바이너리 파일

        except Exception as e:
            issues.append(("ERROR", f"Info.plist 읽기 실패: {e}"))

    # 3. MacOS 디렉토리
    if not os.path.isdir(macos_dir):
        issues.append(("CRITICAL", "MacOS 디렉토리 없음"))

    return issues


def detect_terminal_app():
    """사용 중인 터미널 앱 감지"""
    # Warp 확인
    if os.path.exists("/Applications/Warp.app"):
        return "Warp"
    # iTerm2 확인
    if os.path.exists("/Applications/iTerm.app"):
        return "iTerm"
    return "Terminal"


def get_app_executable_content(app_path):
    """앱의 실행 파일 내용 읽기"""
    info_plist = os.path.join(app_path, "Contents", "Info.plist")
    if not os.path.exists(info_plist):
        return None, None

    try:
        with open(info_plist, "rb") as f:
            plist = plistlib.load(f)
        executable = plist.get("CFBundleExecutable", "")
        exec_path = os.path.join(app_path, "Contents", "MacOS", executable)
        if os.path.exists(exec_path):
            with open(exec_path, "r", encoding="utf-8") as f:
                return exec_path, f.read()
    except:
        pass
    return None, None


def create_fixed_launcher(team_key, team_name, emoji, launcher_sh, terminal_app):
    """수정된 앱 내부 런처 스크립트 생성"""
    launcher_path = os.path.join(LAUNCHERS_DIR, launcher_sh)

    if terminal_app == "Warp":
        # Warp용 런처
        script = f"""#!/bin/bash
# {emoji} {team_name} - AI Company Team App
# Auto-fixed by diagnose_and_fix_apps.py

LAUNCHER="{launcher_path}"

if [ ! -f "$LAUNCHER" ]; then
    osascript -e 'display dialog "{team_name} 런처 스크립트를 찾을 수 없습니다.\\n경로: '$LAUNCHER'" buttons {{"확인"}} default button 1 with icon stop with title "AI Company 오류"'
    exit 1
fi

# Warp에서 새 탭으로 실행
open -a Warp
sleep 0.5
osascript -e 'tell application "System Events" to tell process "Warp" to keystroke "t" using command down'
sleep 0.3
osascript -e 'tell application "System Events" to tell process "Warp" to keystroke "bash \\"'$LAUNCHER'\\"\\n"'
"""
    else:
        # Terminal.app용 런처 (기본)
        script = f"""#!/bin/bash
# {emoji} {team_name} - AI Company Team App
# Auto-fixed by diagnose_and_fix_apps.py

LAUNCHER="{launcher_path}"

if [ ! -f "$LAUNCHER" ]; then
    osascript -e 'display dialog "{team_name} 런처 스크립트를 찾을 수 없습니다.\\n경로: '$LAUNCHER'" buttons {{"확인"}} default button 1 with icon stop with title "AI Company 오류"'
    exit 1
fi

# Terminal.app에서 새 창으로 실행
osascript <<'APPLESCRIPT'
tell application "Terminal"
    activate
    do script "bash \\"{launcher_path}\\""
end tell
APPLESCRIPT
"""
    return script


def fix_app(app_path, team_key, team_name, emoji, launcher_sh, terminal_app):
    """앱 번들 수정"""
    info_plist = os.path.join(app_path, "Contents", "Info.plist")
    macos_dir = os.path.join(app_path, "Contents", "MacOS")

    # Info.plist 읽기
    try:
        with open(info_plist, "rb") as f:
            plist = plistlib.load(f)
    except:
        print(f"    ❌ Info.plist 읽기 실패")
        return False

    executable_name = plist.get("CFBundleExecutable", "launcher")
    exec_path = os.path.join(macos_dir, executable_name)

    # MacOS 디렉토리 생성
    os.makedirs(macos_dir, exist_ok=True)

    # 수정된 런처 작성
    new_content = create_fixed_launcher(team_key, team_name, emoji, launcher_sh, terminal_app)

    with open(exec_path, "w", encoding="utf-8") as f:
        f.write(new_content)

    # 실행 권한 부여
    os.chmod(exec_path, 0o755)

    # Info.plist 보완
    if "CFBundleExecutable" not in plist:
        plist["CFBundleExecutable"] = executable_name
        with open(info_plist, "wb") as f:
            plistlib.dump(plist, f)

    return True


def create_app_from_scratch(team_key, team_name, emoji, launcher_sh, terminal_app):
    """앱이 없는 경우 새로 생성"""
    app_name = f"{emoji} {team_name}.app"
    app_path = os.path.join(DESKTOP, app_name)

    contents = os.path.join(app_path, "Contents")
    macos_dir = os.path.join(contents, "MacOS")
    resources_dir = os.path.join(contents, "Resources")

    os.makedirs(macos_dir, exist_ok=True)
    os.makedirs(resources_dir, exist_ok=True)

    # Info.plist 생성
    bundle_id = f"com.pevo.ai-company.{team_key}"
    plist = {
        "CFBundleExecutable": "launcher",
        "CFBundleName": f"{emoji} {team_name}",
        "CFBundleDisplayName": f"{team_name}",
        "CFBundleIdentifier": bundle_id,
        "CFBundleVersion": "2.0",
        "CFBundleShortVersionString": "2.0",
        "CFBundlePackageType": "APPL",
        "CFBundleSignature": "????",
        "CFBundleIconFile": "AppIcon",
        "LSMinimumSystemVersion": "12.0",
        "NSHighResolutionCapable": True,
    }

    info_plist = os.path.join(contents, "Info.plist")
    with open(info_plist, "wb") as f:
        plistlib.dump(plist, f)

    # 런처 스크립트 생성
    launcher_content = create_fixed_launcher(team_key, team_name, emoji, launcher_sh, terminal_app)
    exec_path = os.path.join(macos_dir, "launcher")
    with open(exec_path, "w", encoding="utf-8") as f:
        f.write(launcher_content)
    os.chmod(exec_path, 0o755)

    return app_path


def main():
    print()
    print("=" * 60)
    print("  🔧 AI Company 팀 앱 진단 및 수정 도구")
    print("=" * 60)
    print()

    # 사전 조건 확인
    if not os.path.isdir(DESKTOP):
        print("  ❌ 바탕화면 디렉토리를 찾을 수 없습니다.")
        sys.exit(1)

    if not os.path.isdir(AI_COMPANY_DIR):
        print(f"  ❌ ai-company 폴더를 찾을 수 없습니다: {AI_COMPANY_DIR}")
        sys.exit(1)

    # 터미널 감지
    terminal_app = detect_terminal_app()
    print(f"  🖥️  감지된 터미널: {terminal_app}")
    print(f"  📁 ai-company 경로: {AI_COMPANY_DIR}")
    print()

    # Claude CLI 확인
    claude_path = shutil.which("claude")
    if claude_path:
        print(f"  ✅ Claude CLI: {claude_path}")
    else:
        print("  ⚠️  Claude CLI를 PATH에서 찾을 수 없습니다.")
        print("     앱에서 claude 실행 시 문제가 될 수 있습니다.")
    print()

    # ===== 진단 =====
    print("━" * 60)
    print("  📋 진단 결과")
    print("━" * 60)
    print()

    found = 0
    missing = 0
    has_issues = 0
    all_results = []

    for key, name, emoji, launcher_sh in TEAMS:
        app_path = find_app_on_desktop(name)

        if not app_path:
            print(f"  ❌ {emoji} {name}: 앱 없음 (바탕화면에서 찾을 수 없음)")
            missing += 1
            all_results.append((key, name, emoji, launcher_sh, None, ["앱 없음"]))
            continue

        found += 1
        issues = check_app_structure(app_path)

        if issues:
            has_issues += 1
            print(f"  ⚠️  {emoji} {name}: {len(issues)}개 문제 발견")
            for level, desc in issues:
                marker = "🔴" if level == "CRITICAL" else "🟡" if level == "ERROR" else "🟠"
                print(f"      {marker} [{level}] {desc}")
            all_results.append((key, name, emoji, launcher_sh, app_path, issues))
        else:
            # 추가 확인: 실행 파일 내용 점검
            exec_path, content = get_app_executable_content(app_path)
            if content and ("open -a Terminal" not in content and "osascript" not in content
                          and "open -a Warp" not in content):
                # 스크립트가 직접 bash 명령을 실행하려 하지만 터미널 앱을 열지 않음
                print(f"  ⚠️  {emoji} {name}: 터미널 열기 로직 누락 (직접 실행 방식)")
                all_results.append((key, name, emoji, launcher_sh, app_path,
                                   [("WARNING", "터미널 열기 로직 누락")]))
                has_issues += 1
            else:
                print(f"  ✅ {emoji} {name}: 정상")
                all_results.append((key, name, emoji, launcher_sh, app_path, []))

    # 런처 스크립트 확인
    print()
    print("━" * 60)
    print("  📋 런처 스크립트 상태")
    print("━" * 60)
    print()

    for key, name, emoji, launcher_sh in TEAMS:
        launcher_path = os.path.join(LAUNCHERS_DIR, launcher_sh)
        if os.path.exists(launcher_path):
            st = os.stat(launcher_path)
            has_exec = bool(st.st_mode & stat.S_IXUSR)
            print(f"  {'✅' if has_exec else '⚠️ '} {launcher_sh} {'(실행 가능)' if has_exec else '(실행 권한 없음)'}")
        else:
            print(f"  ❌ {launcher_sh} (파일 없음)")

    # ===== 요약 =====
    print()
    print("━" * 60)
    print(f"  📊 요약: 발견 {found}개 / 누락 {missing}개 / 문제 {has_issues}개")
    print("━" * 60)
    print()

    if missing == 0 and has_issues == 0:
        print("  ✨ 모든 앱이 정상입니다!")
        print()

        # 추가 제안
        print("  💡 앱이 안 열린다면:")
        print("     1. macOS 보안 설정 확인: 시스템 설정 → 개인 정보 보호 및 보안 → '확인 없이 열기'")
        print("     2. 격리 속성 제거: xattr -cr ~/Desktop/*팀*.app")
        print("     3. 터미널에서 직접 실행: bash ~/Desktop/ai-company/app/launchers/launch-research.sh")
        return

    # ===== 수정 제안 =====
    needs_fix = [(k, n, e, l, p, i) for k, n, e, l, p, i in all_results if i]

    if needs_fix:
        print(f"  🔧 {len(needs_fix)}개 앱에 문제가 있습니다. 수정하시겠습니까?")
        print()
        print("  [1] 자동 수정 (문제 있는 앱만)")
        print("  [2] 전체 재생성 (모든 앱 새로 만들기)")
        print("  [3] 격리 속성만 제거 (Gatekeeper 문제)")
        print("  [4] 종료")
        print()

        choice = input("  선택 (1/2/3/4): ").strip()
        print()

        if choice == "1":
            print("  🔧 문제 앱 수정 중...")
            for key, name, emoji, launcher_sh, app_path, issues in needs_fix:
                if app_path:
                    ok = fix_app(app_path, key, name, emoji, launcher_sh, terminal_app)
                    print(f"  {'✅' if ok else '❌'} {emoji} {name}: {'수정 완료' if ok else '수정 실패'}")
                else:
                    app_path = create_app_from_scratch(key, name, emoji, launcher_sh, terminal_app)
                    print(f"  ✅ {emoji} {name}: 새로 생성됨 → {os.path.basename(app_path)}")

        elif choice == "2":
            print("  🔧 전체 앱 재생성 중...")
            for key, name, emoji, launcher_sh in TEAMS:
                app_path = find_app_on_desktop(name)
                if app_path:
                    ok = fix_app(app_path, key, name, emoji, launcher_sh, terminal_app)
                    print(f"  {'✅' if ok else '❌'} {emoji} {name}: {'수정 완료' if ok else '수정 실패'}")
                else:
                    app_path = create_app_from_scratch(key, name, emoji, launcher_sh, terminal_app)
                    print(f"  ✅ {emoji} {name}: 새로 생성됨")

        elif choice == "3":
            print("  🔧 격리 속성 제거 중...")
            for key, name, emoji, launcher_sh in TEAMS:
                app_path = find_app_on_desktop(name)
                if app_path:
                    result = subprocess.run(
                        ["xattr", "-cr", app_path],
                        capture_output=True, text=True
                    )
                    print(f"  ✅ {emoji} {name}: 격리 속성 제거됨")

        else:
            print("  종료합니다.")
            return

        # touch & refresh
        print()
        print("  🔄 아이콘 캐시 갱신 중...")
        for key, name, emoji, launcher_sh in TEAMS:
            app_path = find_app_on_desktop(name)
            if app_path:
                subprocess.run(["touch", app_path], capture_output=True)

        print()
        print("  ✨ 완료! 앱을 다시 더블클릭해보세요.")
        print()
        print("  💡 여전히 안 열린다면:")
        print("     xattr -cr ~/Desktop/*팀*.app ~/Desktop/*DevOps*.app")
        print("     을 터미널에서 실행해주세요.")


if __name__ == "__main__":
    main()
