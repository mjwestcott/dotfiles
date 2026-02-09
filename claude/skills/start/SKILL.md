---
name: start
description: Switch to main branch, pull latest changes, and optionally begin work on a task.
user_invocable: true
---

Run the following steps:

1. Detect if you're in a git worktree: compare `git rev-parse --git-common-dir` with `git rev-parse --git-dir`. If they differ, you're in a worktree.
2. Get to latest main:
   - **If in a worktree:** `git fetch origin main && git reset --hard origin/main` (you cannot checkout `main` — it belongs to the parent worktree)
   - **If not in a worktree:** `git checkout main && git pull`
3. If the user provided an argument, create a feature branch and begin working on it immediately — treat the argument as the task description.
