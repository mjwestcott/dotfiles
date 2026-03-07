---
name: pr-and-merge
description: Commit current work, push, open a pull request, wait for CI to pass, then merge.
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
5. Print the PR URL to the user.
6. Poll CI status with `gh pr checks <pr-url> --watch` until all checks complete.
   - If checks pass, proceed to step 7.
   - If checks fail, report the failures to the user and stop. Do not merge.
7. Merge the PR with `gh pr merge <pr-url> --squash --delete-branch`.
8. Switch back to main and pull: `git checkout main && git pull`
9. Confirm the merge to the user.
