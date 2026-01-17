---
name: pre-commit
description: Pre-commit checklist that reviews test coverage, simplifies code, reviews for complexity, and validates changes work.
user_invocable: true
---

Run a pre-commit checklist by spawning separate agents for each step. Keep agents separate so each has clean, focused context.

## Steps

1. **Test coverage** - Spawn a general-purpose agent to review test coverage for recent changes (like `/tests`)

2. **Simplify** - Spawn a simplify agent to simplify the changed code (like `/simplify`)

3. **Complexity review** - Spawn an ousterhout-code-review agent to review against Ousterhout's principles (like `/review`)

4. **Validate** - Run the test suite and check for build errors. This can be done directly, no agent needed.

## Output

After all steps complete, summarize findings and provide a PR readiness assessment:
- **Ready**: No blocking issues
- **Needs work**: List items to address
- **Blocked**: Critical issues

Continue through all steps even if issues are found early.
