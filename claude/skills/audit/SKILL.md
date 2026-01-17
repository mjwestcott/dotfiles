---
name: audit
description: Analyzes codebase architecture for complexity using Ousterhout's "A Philosophy of Software Design" principles. Use for architecture review or identifying technical debt.
user_invocable: true
---

Use the Task tool to spawn an ousterhout-codebase-review agent with subagent_type "ousterhout-codebase-review".

The agent will analyze the codebase (or specified portion) for systemic complexity issues:
- Module depth assessment
- Leaky abstractions and information hiding violations
- Consistency issues and complexity hotspots
- Layer quality and abstraction boundaries
- Signs of tactical vs strategic programming

Pass along any specific directories or scope the user mentions. The agent will provide a summary, module depth assessment table, and prioritized findings.
