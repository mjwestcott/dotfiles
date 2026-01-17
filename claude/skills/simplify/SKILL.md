---
name: simplify
description: Simplifies and refines code for clarity, consistency, and maintainability. Focuses on recently modified code unless instructed otherwise.
user_invocable: true
---

Use the Task tool to spawn a simplify agent with subagent_type "simplify".

The agent will analyze and simplify code, focusing on:
- Clarity and readability
- Consistency in patterns and naming
- Maintainability improvements
- Removing unnecessary complexity

Pass along any specific files or scope the user mentions. If no specific scope is given, the agent will focus on recently modified code.
