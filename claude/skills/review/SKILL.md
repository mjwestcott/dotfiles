---
name: review
description: Reviews code changes for complexity and simplification opportunities. Use before creating PRs or when reviewing changesets.
user_invocable: true
---

Comprehensive code review that spawns two agents **in parallel** using a single message with multiple Task tool calls.

**Note**: This can be used as a self-review before creating PRs. Using separate subagents helps maintain objectivity - they review the code fresh without the context of having written it. You don't have to follow every suggestion (they may be wrong), but think each one through carefully.

1. **Simplify agent** (`subagent_type: "simplify"`) - Tactical concerns: clarity, consistency, naming, readability. **READ-ONLY MODE**: Do not make any edits, only report findings.

2. **Ousterhout code review agent** (`subagent_type: "ousterhout-code-review"`) - Strategic concerns: module depth, information hiding, interface design, abstraction boundaries, layer quality.

## Input

Pass along any context the user provides:
- PR number or branch name (use `git diff` to get changes)
- Specific files or directories
- Commit range (e.g., `main..HEAD`)

If no scope is given, review recent changes (staged + unstaged, or recent commits).

## Output

After both agents complete, synthesize their findings into a **PR review style** summary:

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
