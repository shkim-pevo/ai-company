# 📱 터미널 앱 사용 가이드

## 🎉 17개 팀별 전용 터미널 앱 생성 완료!

각 팀마다 전용 터미널 앱이 생성되었습니다. 더블클릭으로 바로 실행 가능합니다!

## 📁 위치
```
~/ai-company/terminal-apps/
├── 조사팀.app
├── 토론팀.app
├── 종합팀.app
├── 기획팀.app
├── 디자인팀.app
├── 퀄리티팀.app
├── 개발팀.app
├── DevOps팀.app
├── 보안팀.app
├── 마케팅팀.app
├── 세일즈팀.app
├── 고객지원팀.app
├── 데이터분석팀.app
├── 법무팀.app
├── 재무팀.app
├── 리더십팀.app
└── 문서화팀.app
```

## 🚀 사용 방법

### 방법 1: Finder에서 실행
```bash
# Finder 열기
open ~/ai-company/terminal-apps

# 원하는 팀 앱을 더블클릭!
```

### 방법 2: 명령어로 실행
```bash
# 조사팀 실행
open ~/ai-company/terminal-apps/조사팀.app

# 개발팀 실행
open ~/ai-company/terminal-apps/개발팀.app

# 리더십팀 실행
open ~/ai-company/terminal-apps/리더십팀.app
```

## 💡 각 앱에서 사용 가능한 명령어

터미널 앱을 열면 자동으로 다음 명령어들을 사용할 수 있습니다:

### 1. `claude-start`
Claude를 실행합니다
```bash
claude-start
```

### 2. `gemini-start "작업내용"`
Gemini로 작업을 실행합니다
```bash
gemini-start "AI 시장 조사"
```

### 3. `parallel-start "작업내용"`
Claude와 Gemini를 동시에 실행합니다
```bash
parallel-start "로그인 API 개발"
```

### 4. `team-info`
현재 팀의 정보를 표시합니다
```bash
team-info
```

### 5. `show-results`
최근 작업 결과를 표시합니다
```bash
show-results
```

## 📋 실전 예시

### 예시 1: 조사팀으로 시장 조사

```bash
# 1. 조사팀 앱 열기
open ~/ai-company/terminal-apps/조사팀.app

# 2. 터미널에서 병렬 실행
parallel-start "AI 챗봇 시장 규모 및 경쟁사 분석"

# 3. 결과 확인
show-results
```

### 예시 2: 개발팀으로 코드 작성

```bash
# 1. 개발팀 앱 열기
open ~/ai-company/terminal-apps/개발팀.app

# 2. Claude만 사용
claude-start

# Claude에게:
사용자 인증 API를 개발해주세요.
- JWT 토큰 사용
- 로그인/로그아웃
- 비밀번호 암호화
```

### 예시 3: 마케팅팀으로 캠페인 기획

```bash
# 1. 마케팅팀 앱 열기
open ~/ai-company/terminal-apps/마케팅팀.app

# 2. 병렬 실행 (Claude + Gemini)
parallel-start "신제품 론칭 캠페인 전략"

# 3. 두 AI의 결과를 비교하여 최선 선택
```

## 🎯 워크플로우 예시

### CEO → 리더십팀 → 각 팀

```bash
# 1. CEO가 리더십팀 앱 실행
open ~/ai-company/terminal-apps/리더십팀.app

# 2. 리더십팀에 업무 지시
claude-start
# "새로운 AI 제품 개발 프로젝트를 시작합니다.
#  조사팀, 기획팀, 개발팀에 업무를 배분해주세요."

# 3. 각 팀별로 앱 실행
open ~/ai-company/terminal-apps/조사팀.app
open ~/ai-company/terminal-apps/기획팀.app
open ~/ai-company/terminal-apps/개발팀.app

# 4. 각 팀에서 작업 수행
# 조사팀 → parallel-start "AI 제품 시장 조사"
# 기획팀 → parallel-start "제품 요구사항 정의"
# 개발팀 → parallel-start "기술 스택 선정"
```

## 🎨 커스터마이징

### 앱 배너 수정
```bash
# 각 팀의 run.sh 파일 수정
vi ~/ai-company/terminal-apps/조사팀.app/Contents/MacOS/run.sh
```

### 추가 명령어 생성
각 팀의 `run.sh` 파일에 새로운 함수를 추가할 수 있습니다:

```bash
# 예: 일일 보고서 생성 명령어
daily-report() {
    echo "📊 일일 보고서 생성 중..."
    date > ~/ai-company/$TEAM_ID/outputs/daily-$(date +%Y%m%d).md
    echo "작업 내역:" >> ~/ai-company/$TEAM_ID/outputs/daily-$(date +%Y%m%d).md
    ls -lt ~/ai-company/$TEAM_ID/outputs/final/ | head -5 >> ~/ai-company/$TEAM_ID/outputs/daily-$(date +%Y%m%d).md
}

export -f daily-report
```

## 📊 Dock에 추가하기

자주 사용하는 팀 앱을 Dock에 추가:

```bash
# 1. Finder에서 terminal-apps 폴더 열기
open ~/ai-company/terminal-apps

# 2. 원하는 앱을 Dock으로 드래그 & 드롭
# 예: 조사팀.app, 개발팀.app, 리더십팀.app
```

## 🔄 앱 재생성

문제가 있거나 업데이트가 필요한 경우:

```bash
# 기존 앱 삭제
rm -rf ~/ai-company/terminal-apps/*.app

# 새로 생성
~/ai-company/scripts/create-terminal-apps.sh
```

## 🎭 테마 설정

### 다크 모드
터미널 앱에서 다크 모드 사용:
1. 터미널 > 설정 > 프로파일
2. 원하는 테마 선택
3. 기본값으로 설정

### 폰트 설정
1. 터미널 > 설정 > 프로파일
2. 텍스트 탭
3. 폰트 변경 (추천: Monaco, Menlo, SF Mono)

## 💡 팁

### 1. 멀티 윈도우
여러 팀을 동시에 작업할 때:
```bash
# 여러 앱을 동시에 열기
open ~/ai-company/terminal-apps/조사팀.app
open ~/ai-company/terminal-apps/기획팀.app
open ~/ai-company/terminal-apps/개발팀.app
```

### 2. tmux와 함께 사용
```bash
# 앱 실행 후 tmux 세션 시작
tmux new -s research-session
```

### 3. 빠른 액세스 alias
`~/.zshrc`에 추가:
```bash
# 팀 앱 빠른 실행
alias research-app='open ~/ai-company/terminal-apps/조사팀.app'
alias dev-app='open ~/ai-company/terminal-apps/개발팀.app'
alias lead-app='open ~/ai-company/terminal-apps/리더십팀.app'
```

## 🛠️ 트러블슈팅

### 앱이 실행되지 않을 때
```bash
# 실행 권한 확인
ls -la ~/ai-company/terminal-apps/조사팀.app/Contents/MacOS/

# 권한 부여
chmod +x ~/ai-company/terminal-apps/*/Contents/MacOS/run.sh
```

### 명령어가 작동하지 않을 때
```bash
# 스크립트 재로드
source ~/.zshrc

# 또는 앱 재시작
```

## 📚 관련 문서

- `MULTI-AI-SYSTEM.md` - 멀티 AI 시스템 설명
- `MULTI-AI-QUICKSTART.md` - 빠른 시작 가이드
- `CEO-WORKFLOW.md` - CEO 업무 지시
- `SETUP-COMPLETE.md` - 전체 시스템 설명

## 🎊 시작하기

```bash
# 1. Finder에서 앱 폴더 열기
open ~/ai-company/terminal-apps

# 2. 리더십팀 앱으로 시작
open ~/ai-company/terminal-apps/리더십팀.app

# 3. 첫 업무 지시
claude-start
```

**모든 준비 완료! 이제 각 팀별 전용 터미널로 작업하세요! 🚀**
