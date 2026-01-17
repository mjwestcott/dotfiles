---
name: tests
description: Reviews test coverage and testing strategy for recent code changes. Use before creating PRs to ensure changes are well-tested.
user_invocable: true
---

Use the Task tool to spawn a general-purpose agent with subagent_type "general-purpose".

The agent should analyze recent code changes (staged, unstaged, or as specified) and evaluate:

1. **Coverage gaps**: Are new/modified code paths tested?
2. **Test quality**: Do tests verify behavior, not just execution?
3. **Edge cases**: Are boundary conditions and error paths covered?
4. **Test organization**: Do tests follow project conventions?
5. **Missing test types**: Would integration, e2e, or other test types add value?

Pass along any specific files, commits, or scope the user mentions.

Output should include:
- Files changed that lack corresponding test coverage
- Specific suggestions for tests that should be added
- Any existing tests that may need updating due to the changes
