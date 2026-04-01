---
name: review
description: Reviews code changes for correctness, complexity, and simplification opportunities. Use before creating PRs or when reviewing changesets.
user_invocable: true
---

Spawn all review agents **in parallel** (single message, multiple tool calls). Subagents review the code fresh without the context of having written it, maintaining objectivity.

## Modes

### Default mode (`/review`, `/review <scope>`)

Report-only. Run all review agents, then synthesize findings into the Output format below. Do not make any edits.

### Self mode (`/review self`, `/review self <scope>`)

Same review agents, but after they return:

1. **Think critically** about every recommendation — subagents may be wrong or overzealous. For each finding, decide: is this actually correct, worth changing, or just churn?
2. **Action the good ones.** Make the edits yourself. Skip the rest. Be opinionated — you're the senior engineer here.
3. **Briefly summarize** what you changed and what you deliberately skipped (and why).

## Review Agents

1. **Simplify agent** (`subagent_type: "simplify"`) - Clarity, consistency, naming, readability. **Read-only** — report findings only.

2. **Ousterhout agent** (`subagent_type: "ousterhout-code-review"`) - Module depth, information hiding, interface design, abstraction boundaries.

3. **Codex review** — Run `/codex:review` for correctness, bugs, vulnerabilities, resource leaks, logic errors. Use `--base main` for branch reviews, or no flags for uncommitted changes. Use `--wait` to block until complete.

4. **Manual test agent** (optional, `subagent_type: "general-purpose"`, `model: "sonnet"`) - Only for complex new features (new endpoints, significant behavioral changes). Instruct it to actually exercise the feature (start servers, make requests, invoke commands) and report pass/fail results. Skip for refactors, config changes, docs, or simple fixes.

## Input

Pass along any context the user provides:
- PR number or branch name (use `git diff` to get changes)
- Specific files or directories
- Commit range (e.g., `main..HEAD`)

If no scope is given, default to all changes on the current branch vs the main branch (committed, staged, and unstaged). Use context to infer the right scope - e.g., if you just finished working on something, review that.

## Scope Detection

Changes may be committed, staged, unstaged, or in untracked files. Ensure all agents cover the full picture:

- **Tracked files**: `git diff main` covers committed + staged + unstaged changes in one command. Do not combine with `git diff` or you'll get duplicate hunks.
- **Untracked files**: `git ls-files --others --exclude-standard` lists new files not yet tracked by git. Agents should read these too.

Tell each agent the scope so it can determine the right commands itself.

## Output

After all review agents complete, synthesize their findings into a **PR review style** summary:

### Summary
Brief overall assessment of code quality.

### Findings

**Correctness & Security** (from Codex)
- List findings with severity and file:line reference
- If Codex found no issues, state that explicitly

**Simplification Opportunities**
- List each finding with file:line reference
- Explain what could be improved and why

**Complexity Concerns**
- List each Ousterhout principle violation
- Include the relevant red flag and specific code location

### Verdict
- **Approve**: No blocking issues, minor suggestions only
- **Request Changes**: Correctness issues or significant complexity/simplification concerns that should be addressed before merge
- **Needs Discussion**: Architectural concerns requiring team input

In **self mode**, append:

### Changes Made
- List each edit with file:line reference and brief rationale

### Deliberately Skipped
- List skipped suggestions with brief reason (e.g., "nitpick", "disagree - current approach is clearer", "not worth the churn")
