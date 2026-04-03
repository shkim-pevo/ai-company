---
description: Automated shipping — merge main, run tests, version bump, changelog, PR
---

# /ship

Fully automated ship workflow. Non-interactive — runs straight through to PR creation.

Steps:
1. Pre-flight (branch check)
2. Merge main
3. Run tests
4. Pre-landing review
5. Version bump (auto MICRO/PATCH, ask for MINOR/MAJOR)
6. CHANGELOG (auto-generated from diff)
7. Bisectable commits
8. Push + PR

Load the `skills/ship/SKILL.md` skill for the full shipping procedure.
