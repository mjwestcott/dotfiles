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
6. **Wait for CI AND the automated reviewers, then handle feedback — before merging.**
   Use the helper: run **`wait-for-pr.sh <pr-number>`** (in this skill dir) in the
   BACKGROUND, then read its output. It waits for every workflow run on the PR head
   commit to finish and prints all review feedback + the merge state.
   - **Why the helper instead of `gh pr checks --watch`:** some tokens lack
     `checks:read`, so `gh pr checks --watch`, the check-runs API, and GraphQL
     `statusCheckRollup` all return HTTP 403 (and the legacy combined-status
     endpoint reports a useless `pending ()`). The helper polls the readable
     Actions-runs API (`gh run list/view`) plus reviews/comments/PR-state instead.
     If the token is unrestricted, `gh pr checks <pr-url> --watch` also works.
   - **There is usually more than one automated reviewer, with different timing.**
     Expect BOTH: a fast one (e.g. Codex `chatgpt-codex-connector[bot]`, ~2 min,
     inline P-badge comments) and a slower "**PR Review**" GitHub Actions workflow
     (`github-actions[bot]`, ~7–8 min, a tiered review with an Approve/verdict).
     **Wait for the slow "PR Review" workflow to complete at least once** — the
     helper's default `REQUIRE_RUN="PR Review"` guard does this.
   - **Do NOT enable auto-merge before the reviews are in and handled.** These bot
     reviews are advisory (they post `COMMENTED`, not `CHANGES_REQUESTED`) and do
     **not** block the merge queue, which gates only on CI. So if you enable
     auto-merge, the queue will merge on green CI _before_ the slow PR Review
     workflow finishes, and you'll lose the chance to act on its feedback.
   - If CI runs fail, report the failures to the user and stop. Do not merge.
7. Handle the automated review feedback. For each item, respond thoughtfully: take it
   (make the change, commit, push) or reject it (reply with rationale via
   `gh pr comment` or a review-thread reply). Judge each on its merits — don't blindly
   accept. If a fix triggers fresh CI + re-review, re-run `wait-for-pr.sh` and allow
   further rounds. Draw a line once feedback is addressed or down to trivial nits.
   - If a stale `CHANGES_REQUESTED` review blocks the merge (its feedback is already
     addressed), dismiss it with
     `gh api -X PUT repos/{owner}/{repo}/pulls/<number>/reviews/<review-id>/dismissals -f message="..."`.
8. Merge once CI is green and reviews are handled.
   - This repo uses a **merge queue**. `--delete-branch` is **rejected** with a merge
     queue enabled (the queue deletes the branch), and the merge method is set by the
     queue — so use `gh pr merge <pr-url> --squash` (add `--auto` to let the queue land
     it when CI goes green). Only do this _after_ step 7.
   - Then poll PR state until merged: `gh pr view <pr-url> --json state --jq .state`
     (readable even with a restricted token). `MERGED` = done.
9. Sync main. **In a git worktree, `git checkout main` fails if `main` is checked out in
   another worktree** — in that case run `git fetch origin` and tell the user to
   `git pull` in their primary checkout. Otherwise `git checkout main && git pull`.
10. Confirm the merge to the user, summarizing how each piece of review feedback was handled.
