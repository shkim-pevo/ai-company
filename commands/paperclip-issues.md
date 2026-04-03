---
description: Paperclip 컨트롤 플레인의 이슈를 조회하고 관리합니다.
---

# /paperclip-issues

Paperclip API를 통해 이슈(태스크)를 조회, 생성, 업데이트합니다.

## 사전 조건

- `PAPERCLIP_API_URL` 환경변수 설정 (기본: `http://localhost:3100`)
- `PAPERCLIP_API_KEY` 환경변수 설정 (로컬 개발 시 생략 가능)
- `PAPERCLIP_COMPANY_ID` 환경변수 설정

> **로컬 개발**: `PAPERCLIP_API_URL` 미설정 시 `http://localhost:3100` 사용. 로컬 모드에서는 인증 불필요.

## 사용법

### 이슈 목록 조회

```bash
curl -s -H "Authorization: Bearer $PAPERCLIP_API_KEY" \
  "$PAPERCLIP_API_URL/api/companies/$PAPERCLIP_COMPANY_ID/issues?status=todo,in_progress"
```

### 이슈 상세 조회

```bash
curl -s -H "Authorization: Bearer $PAPERCLIP_API_KEY" \
  "$PAPERCLIP_API_URL/api/issues/{issueId}"
```

### 이슈 생성

```bash
curl -s -X POST -H "Authorization: Bearer $PAPERCLIP_API_KEY" \
  -H "Content-Type: application/json" \
  "$PAPERCLIP_API_URL/api/companies/$PAPERCLIP_COMPANY_ID/issues" \
  -d '{"title": "...", "description": "...", "priority": "medium", "projectId": "...", "assigneeAgentId": "..."}'
```

### 이슈 상태 변경

```bash
curl -s -X PATCH -H "Authorization: Bearer $PAPERCLIP_API_KEY" \
  -H "Content-Type: application/json" \
  "$PAPERCLIP_API_URL/api/issues/{issueId}" \
  -d '{"status": "done", "comment": "완료 사유"}'
```

## 상태값

`backlog`, `todo`, `in_progress`, `in_review`, `done`, `blocked`, `cancelled`

## 우선순위

`critical`, `high`, `medium`, `low`
