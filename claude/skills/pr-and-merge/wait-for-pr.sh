#!/usr/bin/env bash
# wait-for-pr.sh — poll a PR's CI runs + automated reviews using only the APIs a
# restricted GitHub token can read.
#
# WHY THIS EXISTS: some tokens lack `checks:read`, so `gh pr checks --watch`,
# the check-runs API, and the GraphQL statusCheckRollup all return HTTP 403, and
# the legacy combined-status endpoint reports a useless "pending ()". The Actions
# *runs* API (`gh run list/view`), PR reviews/comments, and PR state ARE readable,
# so we poll those instead.
#
# It waits for every workflow run on the PR head commit to finish (including the
# slow, separate "PR Review" bot workflow — which is advisory and does NOT block
# the merge queue, so you MUST wait for it explicitly or you'll merge before its
# feedback lands), then prints all automated review feedback and the merge state.
#
# Usage:   wait-for-pr.sh <pr-number>
# Env:     REQUIRE_RUN  substring of a run name that must exist+complete before we
#                       declare done (default "PR Review"); set to "" to skip.
#          MAX_MIN      overall timeout in minutes (default 25).
# Run it in the BACKGROUND (it sleeps between polls); read its output when done.
set -uo pipefail

PR="${1:?usage: wait-for-pr.sh <pr-number>}"
REQUIRE_RUN="${REQUIRE_RUN-PR Review}"
MAX_MIN="${MAX_MIN:-25}"

REPO=$(gh repo view --json nameWithOwner --jq .nameWithOwner)
BRANCH=$(gh pr view "$PR" --json headRefName --jq .headRefName)
SHA=$(gh pr view "$PR" --json headRefOid --jq .headRefOid)
echo "PR #$PR  repo=$REPO  branch=$BRANCH  sha=${SHA:0:10}  (require-run='$REQUIRE_RUN')"

deadline=$(( $(date +%s) + MAX_MIN * 60 ))
echo "== Waiting for workflow runs on ${SHA:0:10} (timeout ${MAX_MIN}m) =="
poll=0
while :; do
  # Bail out fast if the PR has gone unmergeable (main moved under it) or was
  # closed/merged — waiting for runs on a conflicted head is wasted time, and
  # a DIRTY PR never enters the merge queue. Check every ~2 min (mergeable is
  # recomputed lazily by GitHub, so don't hammer it).
  if [ $(( poll % 6 )) -eq 0 ]; then
    pr_state=$(gh pr view "$PR" --json state,mergeable,mergeStateStatus \
      --jq '"\(.state) \(.mergeable) \(.mergeStateStatus)"' 2>/dev/null || echo "")
    case "$pr_state" in
      MERGED*) echo "  PR already MERGED"; break ;;
      CLOSED*) echo "  PR is CLOSED — stopping"; break ;;
      *CONFLICTING*|*DIRTY*)
        echo "  PR is CONFLICTING with the base branch (main moved under it)."
        echo "  ACTION NEEDED: rebase onto main, resolve, push — then re-run this script."
        exit 2 ;;
    esac
  fi
  poll=$(( poll + 1 ))
  runs=$(gh run list --branch "$BRANCH" --limit 30 \
    --json name,status,conclusion,headSha \
    --jq "[.[] | select(.headSha==\"$SHA\")]" 2>/dev/null)
  total=$(jq 'length' <<<"$runs" 2>/dev/null || echo 0)
  pending=$(jq '[.[] | select(.status != "completed")] | length' <<<"$runs" 2>/dev/null || echo 1)
  # Guard: if a required run hasn't even been created yet, keep waiting.
  have_required=1
  if [ -n "$REQUIRE_RUN" ]; then
    have_required=$(jq --arg n "$REQUIRE_RUN" \
      '[.[] | select(.name|test($n;"i")) | select(.status=="completed")] | length' <<<"$runs" 2>/dev/null || echo 0)
  fi
  now=$(date +%s)
  if [ "$total" -gt 0 ] && [ "$pending" -eq 0 ] && [ "${have_required:-0}" -ge 1 ]; then
    break
  fi
  if [ "$now" -ge "$deadline" ]; then echo "  TIMEOUT after ${MAX_MIN}m (pending=$pending)"; break; fi
  sleep 20
done

echo "== Run conclusions =="
jq -r '.[] | "  \(.name): \(.status) \(.conclusion // "")"' <<<"$runs" 2>/dev/null

echo "== Automated reviews =="
gh api "repos/$REPO/pulls/$PR/reviews" \
  --jq '.[] | "--- \(.user.login) [\(.state)] \(.submitted_at) ---\n\(.body // "(no body)")\n"' 2>/dev/null || echo "  (none)"

echo "== Inline review comments =="
gh api "repos/$REPO/pulls/$PR/comments" \
  --jq '.[] | "\(.path):\(.line // .original_line) [\(.user.login)]\n\(.body)\n"' 2>/dev/null || echo "  (none)"

echo "== PR state =="
gh pr view "$PR" --json state,mergeStateStatus,reviewDecision \
  --jq '"  state=\(.state)  mergeState=\(.mergeStateStatus)  reviewDecision=\(.reviewDecision)"' 2>/dev/null
