---
description: Paperclip 컨트롤 플레인의 조직도를 조회합니다.
---

# /paperclip-org

Paperclip API를 통해 회사의 에이전트 조직도를 조회하고 표시합니다.

## 사전 조건

- `PAPERCLIP_API_URL` 환경변수 설정 (기본: `http://localhost:3100`)
- `PAPERCLIP_API_KEY` 환경변수 설정 (로컬 개발 시 생략 가능)
- `PAPERCLIP_COMPANY_ID` 환경변수 설정

> **로컬 개발**: `PAPERCLIP_API_URL` 미설정 시 `http://localhost:3100` 사용. 로컬 모드에서는 인증 불필요.

## 실행 단계

1. **에이전트 목록 조회**
   ```bash
   curl -s -H "Authorization: Bearer $PAPERCLIP_API_KEY" \
     "$PAPERCLIP_API_URL/api/companies/$PAPERCLIP_COMPANY_ID/agents"
   ```

2. **프로젝트(부서) 목록 조회**
   ```bash
   curl -s -H "Authorization: Bearer $PAPERCLIP_API_KEY" \
     "$PAPERCLIP_API_URL/api/companies/$PAPERCLIP_COMPANY_ID/projects"
   ```

3. 결과를 종합하여 **트리 형태 조직도** 표시:
   - 회사명
   - └ 부서(프로젝트)별
   -   └ 에이전트 (역할, 상태, 어댑터 타입)

4. 추가 정보 표시:
   - 총 에이전트 수 / 활성 에이전트 수
   - 부서별 에이전트 수
   - `reportsTo` 관계 기반 계층 구조
