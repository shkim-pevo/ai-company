---
name: ship
version: 1.0.0
origin: gstack
description: |
  Ship workflow: merge main, run tests, review diff, bump VERSION, update CHANGELOG, commit, push, create PR.
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - AskUserQuestion
---

# Ship: Fully Automated Ship Workflow

You are running the `/ship` workflow. This is a **non-interactive, fully automated** workflow. Do NOT ask for confirmation at any step. The user said `/ship` which means DO IT. Run straight through and output the PR URL at the end.

**Only stop for:**
- On `main` branch (abort)
- Merge conflicts that can't be auto-resolved (stop, show conflicts)
- Test failures (stop, show failures)
- Pre-landing review finds CRITICAL issues and user chooses to fix (not acknowledge or skip)
- MINOR or MAJOR version bump needed (ask — see Step 4)

**Never stop for:**
- Uncommitted changes (always include them)
- Version bump choice (auto-pick MICRO or PATCH — see Step 4)
- CHANGELOG content (auto-generate from diff)
- Commit message approval (auto-commit)
- Multi-file changesets (auto-split into bisectable commits)

---

## Step 1: Pre-flight

1. Check the current branch. If on `main`, **abort**: "You're on main. Ship from a feature branch."

2. Run `git status` (never use `-uall`). Uncommitted changes are always included — no need to ask.

3. Run `git diff main...HEAD --stat` and `git log main..HEAD --oneline` to understand what's being shipped.

---

## Step 2: Merge origin/main (BEFORE tests)

Fetch and merge `origin/main` into the feature branch so tests run against the merged state:

```bash
git fetch origin main && git merge origin/main --no-edit
```

**If there are merge conflicts:** Try to auto-resolve if they are simple (VERSION, schema.rb, CHANGELOG ordering). If conflicts are complex or ambiguous, **STOP** and show them.

**If already up to date:** Continue silently.

---

## Step 3: Run tests (on merged code)

Detect and run **all** of the project's test suites. Run each detected runner in parallel when multiple apply (e.g., full-stack projects with both backend and frontend tests).

```bash
# Collect all matching test runners (run ALL that apply, not just one)
RUNNERS=()

if [ -f "go.mod" ]; then
  RUNNERS+=("go test ./... 2>&1 | tee /tmp/ship_tests_go.txt")
fi
if [ -f "Cargo.toml" ]; then
  RUNNERS+=("cargo test 2>&1 | tee /tmp/ship_tests_rust.txt")
fi
if [ -f "pyproject.toml" ] || [ -f "setup.py" ]; then
  RUNNERS+=("pytest 2>&1 | tee /tmp/ship_tests_py.txt")
fi
if [ -f "Gemfile" ]; then
  RUNNERS+=("bundle exec rspec 2>&1 | tee /tmp/ship_tests_ruby.txt")
fi
if [ -f "Makefile" ] && grep -q "^test:" Makefile; then
  RUNNERS+=("make test 2>&1 | tee /tmp/ship_tests_make.txt")
fi
if [ -f "package.json" ]; then
  RUNNERS+=("npm test 2>&1 | tee /tmp/ship_tests_js.txt")
fi

# Run all detected runners in parallel
for cmd in "${RUNNERS[@]}"; do
  eval "$cmd" &
done
wait
```

If no test runner is detected, **STOP** and ask the user how to run tests.

After all runners complete, read the output files and check pass/fail.

**If any test fails:** Show the failures and **STOP**. Do not proceed.

**If all pass:** Continue silently — just note the counts briefly.

---

## Step 3.25: Eval Suites (conditional — skip if no eval infrastructure)

If the project has no LLM eval infrastructure, skip this step entirely.

**1. Check if the diff touches prompt-related files:**

```bash
git diff origin/main --name-only
```

Look for patterns like: prompt builders, generation services, system prompt configs, eval infrastructure files. Consult the project's CLAUDE.md or documentation for project-specific prompt file patterns.

**If no prompt-related files changed:** Print "No prompt-related files changed — skipping evals." and continue to Step 3.5.

**2. Identify affected eval suites:**

Find eval runners/tests that declare which source files affect them. Grep for changed filenames across eval test files to determine which suites to run.

**Special cases:**
- Changes to eval judges, support files, or fixtures may affect ALL suites that import them
- Changes to system prompt configs — grep eval runners for the prompt filename
- If unsure which suites are affected, run ALL suites that could plausibly be impacted

**3. Run affected suites at the strictest judge tier:**

`/ship` is a pre-merge gate — always use the highest-fidelity eval tier available.

If multiple suites need to run, run them sequentially. If the first suite fails, stop immediately — don't burn API cost on remaining suites.

**4. Check results:**

- **If any eval fails:** Show the failures and **STOP**. Do not proceed.
- **If all pass:** Note pass counts and cost. Continue to Step 3.5.

**5. Save eval output** — include eval results in the PR body (Step 8).

---

## Step 3.5: Pre-Landing Review

Review the diff for structural issues that tests don't catch.

1. Read `skills/security-review/pre-landing-checklist.md`. If the file cannot be read, try `.claude/skills/security-review/pre-landing-checklist.md`. If neither can be read, **STOP** and report the error.

2. Run `git diff origin/main` to get the full diff (scoped to feature changes against the freshly-fetched remote main).

3. Apply the review checklist in two passes:
   - **Pass 1 (CRITICAL):** SQL & Data Safety, LLM Output Trust Boundary
   - **Pass 2 (INFORMATIONAL):** All remaining categories

4. **Always output ALL findings** — both critical and informational. The user must see every issue found.

5. Output a summary header: `Pre-Landing Review: N issues (X critical, Y informational)`

6. **If CRITICAL issues found:** For EACH critical issue, use a separate AskUserQuestion with:
   - The problem (`file:line` + description)
   - Your recommended fix
   - Options: A) Fix it now (recommend), B) Acknowledge and ship anyway, C) It's a false positive — skip
   After resolving all critical issues: if the user chose A (fix) on any issue, apply the recommended fixes, then commit only the fixed files by name (`git add <fixed-files> && git commit -m "fix: apply pre-landing review fixes"`), then **STOP** and tell the user to run `/ship` again to re-test with the fixes applied. If the user chose only B (acknowledge) or C (false positive) on all issues, continue with Step 4.

7. **If only non-critical issues found:** Output them and continue. They will be included in the PR body at Step 8.

8. **If no issues found:** Output `Pre-Landing Review: No issues found.` and continue.

Save the review output — it goes into the PR body in Step 8.

---

## Step 4: Version bump (auto-decide)

1. Read the current `VERSION` file (4-digit format: `MAJOR.MINOR.PATCH.MICRO`)

2. **Auto-decide the bump level based on the diff:**
   - Count lines changed (`git diff origin/main...HEAD --stat | tail -1`)
   - **MICRO** (4th digit): < 50 lines changed, trivial tweaks, typos, config
   - **PATCH** (3rd digit): 50+ lines changed, bug fixes, small-medium features
   - **MINOR** (2nd digit): **ASK the user** — only for major features or significant architectural changes
   - **MAJOR** (1st digit): **ASK the user** — only for milestones or breaking changes

3. Compute the new version:
   - Bumping a digit resets all digits to its right to 0
   - Example: `0.19.1.0` + PATCH → `0.19.2.0`

4. Write the new version to the `VERSION` file.

---

## Step 5: CHANGELOG (auto-generate)

1. Read `CHANGELOG.md` header to know the format.

2. Auto-generate the entry from **ALL commits on the branch** (not just recent ones):
   - Use `git log main..HEAD --oneline` to see every commit being shipped
   - Use `git diff main...HEAD` to see the full diff against main
   - The CHANGELOG entry must be comprehensive of ALL changes going into the PR
   - If existing CHANGELOG entries on the branch already cover some commits, replace them with one unified entry for the new version
   - Categorize changes into applicable sections:
     - `### Added` — new features
     - `### Changed` — changes to existing functionality
     - `### Fixed` — bug fixes
     - `### Removed` — removed features
   - Write concise, descriptive bullet points
   - Insert after the file header (line 5), dated today
   - Format: `## [X.Y.Z.W] - YYYY-MM-DD`

**Do NOT ask the user to describe changes.** Infer from the diff and commit history.

---

## Step 6: Commit (bisectable chunks)

**Goal:** Create small, logical commits that work well with `git bisect` and help LLMs understand what changed.

1. Analyze the diff and group changes into logical commits. Each commit should represent **one coherent change** — not one file, but one logical unit.

2. **Commit ordering** (earlier commits first):
   - **Infrastructure:** migrations, config changes, route additions
   - **Models & services:** new models, services, concerns (with their tests)
   - **Controllers & views:** controllers, views, JS/React components (with their tests)
   - **VERSION + CHANGELOG:** always in the final commit

3. **Rules for splitting:**
   - A model and its test file go in the same commit
   - A service and its test file go in the same commit
   - A controller, its views, and its test go in the same commit
   - Migrations are their own commit (or grouped with the model they support)
   - Config/route changes can group with the feature they enable
   - If the total diff is small (< 50 lines across < 4 files), a single commit is fine

4. **Each commit must be independently valid** — no broken imports, no references to code that doesn't exist yet. Order commits so dependencies come first.

5. Compose each commit message:
   - First line: `<type>: <summary>` (type = feat/fix/chore/refactor/docs)
   - Body: brief description of what this commit contains
   - Only the **final commit** (VERSION + CHANGELOG) gets the version tag and co-author trailer:

```bash
git commit -m "$(cat <<'EOF'
chore: bump version and changelog (vX.Y.Z.W)

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
EOF
)"
```

---

## Step 7: Push

Push to the remote with upstream tracking:

```bash
git push -u origin <branch-name>
```

---

## Step 8: Create PR

Create a pull request using `gh`:

```bash
gh pr create --title "<type>: <summary>" --body "$(cat <<'EOF'
## Summary
<bullet points from CHANGELOG>

## Pre-Landing Review
<findings from Step 3.5, or "No issues found.">

## Eval Results
<If evals ran: suite names, pass/fail counts, cost dashboard summary. If skipped: "No prompt-related files changed — evals skipped.">

## Test plan
- [x] All tests pass (N runs, 0 failures)

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

**Output the PR URL** — this should be the final output the user sees.

---

## Important Rules

- **Never skip tests.** If tests fail, stop.
- **Never skip the pre-landing review.** If checklist.md is unreadable, stop.
- **Never force push.** Use regular `git push` only.
- **Never ask for confirmation** except for MINOR/MAJOR version bumps and CRITICAL review findings (one AskUserQuestion per critical issue with fix recommendation).
- **Always use the 4-digit version format** from the VERSION file.
- **Date format in CHANGELOG:** `YYYY-MM-DD`
- **Split commits for bisectability** — each commit = one logical change.
- **The goal is: user says `/ship`, next thing they see is the review + PR URL.**
