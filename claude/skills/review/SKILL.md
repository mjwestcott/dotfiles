---
name: review
description: Reviews code changes for complexity using Ousterhout's "A Philosophy of Software Design" principles. Use before creating PRs or when reviewing changesets.
user_invocable: true
---

Use the Task tool to spawn an ousterhout-code-review agent with subagent_type "ousterhout-code-review".

The agent will review recent code changes (staged, unstaged, or as specified) against Ousterhout's principles:
- Module depth and information hiding
- Complexity management
- Interface design
- Layer quality and abstraction boundaries

Pass along any specific files, commits, or scope the user mentions. The agent will provide findings with confidence scores and concrete suggestions.
