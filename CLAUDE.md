# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Claude Code plugin** - a collection of production-ready agents, skills, hooks, commands, rules, and MCP configurations. The project provides battle-tested workflows for software development using Claude Code.

## Running Tests

```bash
# Run all tests
node tests/run-all.js

# Run individual test files
node tests/lib/utils.test.js
node tests/lib/package-manager.test.js
node tests/hooks/hooks.test.js
```

## Architecture

The project is organized into several core components:

- **agents/** - Specialized subagents for delegation (planner, code-reviewer, tdd-guide, etc.)
- **skills/** - Workflow definitions and domain knowledge (coding standards, patterns, testing)
- **commands/** - Slash commands invoked by users (/tdd, /plan, /e2e, etc.)
- **hooks/** - Trigger-based automations (session persistence, pre/post-tool hooks)
- **rules/** - Always-follow guidelines (security, coding style, testing requirements)
- **mcp-configs/** - MCP server configurations for external integrations
- **scripts/** - Cross-platform Node.js utilities for hooks and setup
- **tests/** - Test suite for scripts and utilities

## Key Commands

- `/tdd` - Test-driven development workflow
- `/plan` - Implementation planning
- `/e2e` - Generate and run E2E tests
- `/code-review` - Quality review
- `/build-fix` - Fix build errors
- `/learn` - Extract patterns from sessions
- `/skill-create` - Generate skills from git history
- `/browse` - Headless Chromium CLI (~100ms/command, 50+ commands)
- `/qa` - Systematic QA testing with health scores
- `/retro` - Data-driven engineering retrospective
- `/plan-ceo-review` - Founder-mode plan pressure testing
- `/plan-eng-review` - Engineering manager architecture review
- `/ship` - Automated shipping (merge, test, version bump, PR)

## Development Notes

- Package manager detection: npm, pnpm, yarn, bun (configurable via `CLAUDE_PACKAGE_MANAGER` env var or project config)
- Cross-platform: Windows, macOS, Linux support via Node.js scripts
- Agent format: Markdown with YAML frontmatter (name, description, tools, model)
- Skill format: Markdown with clear sections for when to use, how it works, examples
- Hook format: JSON with matcher conditions and command/notification hooks

## Contributing

Follow the formats in CONTRIBUTING.md:
- Agents: Markdown with frontmatter (name, description, tools, model)
- Skills: Clear sections (When to Use, How It Works, Examples)
- Commands: Markdown with description frontmatter
- Hooks: JSON with matcher and hooks array

File naming: lowercase with hyphens (e.g., `python-reviewer.md`, `tdd-workflow.md`)

## Paperclip Control Plane

The `paperclip/` directory contains the [Paperclip](https://github.com/paperclipai/paperclip) control plane — an orchestration layer for managing AI agent teams.

### Quick Start

```bash
cd paperclip
npx pnpm@9 install   # pnpm 미설치 시

# 안정 모드 (권장 — 포트 충돌 방지)
PORT=3100 PAPERCLIP_UI_DEV_MIDDLEWARE=true npx tsx server/src/index.ts

# Watch 모드 (파일 변경 시 자동 재시작, 포트 충돌 가능)
# npx pnpm@9 dev
```

### Seeding (load 21 departments / 89 agents)

```bash
cd paperclip
npx tsx scripts/seed-from-ai-company.ts
# 커스텀 포트: PAPERCLIP_API_URL=http://localhost:3103 npx tsx scripts/seed-from-ai-company.ts
```

> 시딩 스크립트는 **멱등성** 보장 — 재실행해도 중복 생성하지 않습니다.

### 팀/에이전트 변경 시 필수 체크리스트

팀 추가·삭제·변경 시 **반드시 아래 3곳을 동기화**해야 합니다:

1. **`paperclip/scripts/seed-from-ai-company.ts`** — DEPARTMENTS 배열에 팀/멤버 추가
2. **`teams/XX-{name}/`** — 팀 디렉토리 + 멤버별 `.md` 파일 생성
3. **시딩 재실행** — `cd paperclip && npx tsx scripts/seed-from-ai-company.ts`

> 하나라도 빠지면 Paperclip UI와 로컬 팀 정의가 불일치합니다.

### Port Assignments

| Service | Port |
|---------|:----:|
| Paperclip Server (API + UI) | 3100 |
| PostgreSQL (embedded) | 54329 |
| pharmpay-ui | 5174 |
| pevo-ui | 5175 |

### Paperclip Commands

- `/paperclip-status` - Agent status, assigned issues, budget
- `/paperclip-issues` - Issue management
- `/paperclip-org` - Organization chart

### Paperclip Skills

- `paperclip` - Heartbeat procedure and API interaction
- `paperclip-create-agent` - Agent creation workflow
- `create-agent-adapter` - Custom adapter creation

## 필수 규칙 (반드시 준수)

### 팀/에이전트 동기화 규칙

팀이나 에이전트를 추가·수정·삭제할 때 **다음 3곳을 반드시 함께 업데이트**:

| # | 대상 | 경로 | 설명 |
|---|------|------|------|
| 1 | 시드 스크립트 | `paperclip/scripts/seed-from-ai-company.ts` | DEPARTMENTS 배열 |
| 2 | 팀 디렉토리 | `teams/{번호}-{영문명}/` | 팀장.md + 멤버별 .md |
| 3 | Paperclip DB | `npx tsx scripts/seed-from-ai-company.ts` | 시딩 재실행 |

- 시딩 후 Paperclip UI에서 org tree 확인: `GET /api/companies/:id/org`
- 팀 디렉토리 번호는 기존 마지막 번호 + 1 (현재 23번까지 사용)
- 이 규칙을 어기면 Paperclip ↔ 로컬 정의 불일치 발생

## gstack Integration

[gstack](https://github.com/garrytan/gstack) 기반 스킬 (인지 모드 전환 AI 엔지니어링 툴킷):

- `skills/browse/` - Headless Chromium CLI (~100ms/command, 50+ commands, 0 token overhead)
- `skills/qa-systematic/` - Systematic QA testing (health score, regression tracking)
- `skills/retro/` - Data-driven engineering retrospective (git analysis)
- `skills/plan-ceo-review/` - Founder-mode plan pressure testing
- `skills/plan-eng-review/` - Engineering manager architecture review
- `skills/ship/` - Automated shipping workflow

### Browse Setup

```bash
cd skills/browse && ./setup
```

Requires: bun (>= 1.0.0). Setup auto-installs Playwright Chromium.
