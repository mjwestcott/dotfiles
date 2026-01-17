---
name: coverage
description: Comprehensive analysis of testing strategy and coverage across the codebase. Evaluates all test types and identifies gaps.
user_invocable: true
---

Use the Task tool to spawn a general-purpose agent with subagent_type "general-purpose".

Think deeply about testing strategy. This is a comprehensive audit - consider delegating to multiple subagents if the codebase is large or spans different domains (e.g., one for backend, one for frontend, one for infrastructure).

The agent should analyze the entire codebase (or specified portion) for testing health:

## Test Types to Consider

Evaluate whether each type is appropriate and adequately covered:

- **Unit tests**: Individual functions/methods in isolation
- **Integration tests**: Component interactions, database queries, API calls
- **End-to-end tests**: Full user flows through the system
- **Contract tests**: API contracts between services
- **Snapshot tests**: UI components, serialization formats
- **Property-based tests**: Invariants that hold across random inputs
- **Performance tests**: Benchmarks, load tests, regression detection
- **Security tests**: Input validation, auth flows, vulnerability scanning
- **Smoke tests**: Critical path verification for deployments

## Analysis Approach

1. Map the codebase structure and identify testable boundaries
2. Locate existing test files and understand current coverage
3. Identify critical paths that must not break
4. Find complex logic that warrants thorough testing
5. Assess test infrastructure (frameworks, CI integration, mocking patterns)
6. Look for flaky tests or testing anti-patterns

## Output

**Summary**: Overall testing health and primary gaps.

**Coverage by Area**:
| Area | Unit | Integration | E2E | Notes |

**Critical Gaps**: High-risk code lacking tests.

**Quick Wins**: Easy tests that would add significant value.

**Strategic Improvements**: Testing infrastructure or patterns to adopt.

**Test Quality Issues**: Flaky tests, poor assertions, maintenance burdens.

Be specific - cite files and suggest concrete test cases.
