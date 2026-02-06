---
name: review
description: Reviews code changes for complexity and simplification opportunities. Use before creating PRs or when reviewing changesets.
user_invocable: true
---

Comprehensive code review that spawns agents **in parallel** using a single message with multiple Task tool calls.

**Note**: Using separate subagents helps maintain objectivity - they review the code fresh without the context of having written it.

## Modes

Check the user's arguments to determine the mode:

### Default mode (`/review`, `/review <scope>`)

Report-only. Spawn the two review agents, then synthesize findings into the Output format below. Do not make any edits.

### Self mode (`/review self`, `/review self <scope>`)

Act on the review. Same two review agents, but after they return:

1. **Think critically** about every recommendation. The subagents may be wrong, overzealous, or suggest changes that don't fit the context. For each finding, decide:
   - Is this actually correct?
   - Is this worth changing, or is it a nitpick?
   - Will this change improve the code or just churn it?

2. **Action the good ones.** Make the edits yourself for findings you judge to be correct and worthwhile. Skip the rest. Be opinionated - you're the senior engineer here, not the subagents.

3. **Briefly summarize** what you changed and what you deliberately skipped (and why).

### Manual test agent (both modes, optional)

After reviewing the changes, assess whether the changeset is a **complex new feature** that warrants manual testing (e.g., new API endpoints, significant behavioral changes, complex integrations). If so, spawn a third agent:

3. **Manual test agent** (`subagent_type: "general-purpose"`) - Instruct it to functionally test the feature by actually exercising it (e.g., calling API endpoints locally, running the CLI, triggering the new behavior). The agent should:
   - Determine how to test the feature based on the code changes
   - Actually run the tests (start servers, make HTTP requests, invoke commands, etc.)
   - Report whether the feature works correctly, with specific pass/fail results

Do NOT spawn this agent for minor refactors, config changes, documentation, or simple bug fixes. Use your judgement.

## Review Agents

1. **Simplify agent** (`subagent_type: "simplify"`) - Tactical concerns: clarity, consistency, naming, readability. **READ-ONLY MODE**: Do not make any edits, only report findings.

2. **Ousterhout code review agent** (`subagent_type: "ousterhout-code-review"`) - Strategic concerns: module depth, information hiding, interface design, abstraction boundaries, layer quality.

## Input

Pass along any context the user provides:
- PR number or branch name (use `git diff` to get changes)
- Specific files or directories
- Commit range (e.g., `main..HEAD`)

If no scope is given, default to all changes on the current branch vs the main branch (committed, staged, and unstaged). Use context to infer the right scope - e.g., if you just finished working on something, review that.

## Output

After both review agents complete, synthesize their findings into a **PR review style** summary:

### Summary
Brief overall assessment of code quality.

### Findings

**Simplification Opportunities**
- List each finding with file:line reference
- Explain what could be improved and why

**Complexity Concerns**
- List each Ousterhout principle violation
- Include the relevant red flag and specific code location

### Verdict
- **Approve**: No blocking issues, minor suggestions only
- **Request Changes**: Issues that should be addressed before merge
- **Needs Discussion**: Architectural concerns requiring team input

In **self mode**, append:

### Changes Made
- List each edit with file:line reference and brief rationale

### Deliberately Skipped
- List skipped suggestions with brief reason (e.g., "nitpick", "disagree - current approach is clearer", "not worth the churn")
