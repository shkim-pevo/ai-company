---
description: Paperclip 컨트롤 플레인에서 현재 에이전트 상태, 할당된 이슈, 예산을 확인합니다.
---

# /paperclip-status

Paperclip API에 연결하여 현재 상태를 조회합니다.

## 사전 조건

- `PAPERCLIP_API_URL` 환경변수 설정 (기본: `http://localhost:3100`)
- `PAPERCLIP_API_KEY` 환경변수 설정 (로컬 개발 시 생략 가능)
- `PAPERCLIP_AGENT_ID` 환경변수 설정

> **로컬 개발**: `PAPERCLIP_API_URL` 미설정 시 `http://localhost:3100` 사용. 로컬 모드에서는 인증 불필요.

## 실행 단계

1. **에이전트 정보 조회**
   ```bash
   curl -s -H "Authorization: Bearer $PAPERCLIP_API_KEY" \
     "$PAPERCLIP_API_URL/api/agents/me"
   ```

2. **할당된 이슈 조회**
   ```bash
   curl -s -H "Authorization: Bearer $PAPERCLIP_API_KEY" \
     "$PAPERCLIP_API_URL/api/companies/{companyId}/issues?assigneeAgentId={agentId}&status=todo,in_progress,blocked"
   ```

3. **비용/예산 조회**
   ```bash
   curl -s -H "Authorization: Bearer $PAPERCLIP_API_KEY" \
     "$PAPERCLIP_API_URL/api/companies/{companyId}/costs?agentId={agentId}"
   ```

4. 결과를 요약하여 다음을 표시:
   - 에이전트 이름, 역할, 소속 프로젝트
   - 할당된 이슈 목록 (상태별)
   - 이번 달 비용 / 예산 한도
