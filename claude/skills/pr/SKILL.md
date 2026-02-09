---
name: pr
description: Commit current work, push, and open a pull request against main.
user_invocable: true
---

Run the following steps:

1. Check the current branch. If on `main` or `master`, create a new feature branch first:
   - Pick a short, descriptive branch name based on the recent changes (e.g. `add-start-skill`)
   - Fetch latest main: `git fetch origin main` (or `master`)
   - Create the branch from latest main: `git checkout -b <branch> origin/main`
   - Cherry-pick or re-apply any uncommitted/staged work onto the new branch
2. Commit any uncommitted changes with a clear commit message.
3. Push the branch: `git push -u origin HEAD`
4. Open the PR with `gh pr create`, targeting main. Write a concise title and summary based on the changes.
5. Return the PR URL to the user.
