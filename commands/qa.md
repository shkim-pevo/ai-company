---
description: Systematic QA testing with health scores and regression tracking
---

# /qa

Systematically QA test a web application like a real user. Three modes:

- **Full** (default) — systematic exploration, 5-10 documented issues, 5-15 minutes
- **Quick** (`--quick`) — 30-second smoke test: homepage + top 5 nav targets
- **Regression** (`--regression baseline.json`) — compare against previous baseline

Load the `skills/qa-systematic/SKILL.md` skill for the full QA methodology.

Prerequisite: `skills/browse/` must be set up first (`cd skills/browse && ./setup`).
