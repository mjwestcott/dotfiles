#!/bin/bash

# Claude Code SessionStart hook for context loading
# Output is injected into Claude's initial context

# Helper: relative time from unix timestamp
relative_time() {
    local ts=$1
    local now
    now=$(date +%s)
    local diff=$((now - ts))

    if ((diff < 60)); then
        echo "now"
    elif ((diff < 3600)); then
        echo "$((diff / 60))m"
    elif ((diff < 86400)); then
        echo "$((diff / 3600))h"
    elif ((diff < 604800)); then
        echo "$((diff / 86400))d"
    else
        echo "$((diff / 604800))w"
    fi
}

# Box drawing
WIDTH=80
TOP_LEFT="╭"
TOP_RIGHT="╮"
BOT_LEFT="╰"
BOT_RIGHT="╯"
HORIZ="─"
VERT="│"

draw_line() {
    local left=$1
    local right=$2
    local fill=$3
    printf "%s" "$left"
    printf "%0.s$fill" $(seq 1 $((WIDTH - 2)))
    printf "%s\n" "$right"
}

draw_content() {
    local content=$1
    local len=${#content}
    local padding=$((WIDTH - 6 - len))
    if ((padding < 0)); then
        content="${content:0:$((WIDTH - 9))}..."
        padding=0
    fi
    printf "%s  %s%*s  %s\n" "$VERT" "$content" "$padding" "" "$VERT"
}

draw_empty() {
    printf "%s%*s%s\n" "$VERT" "$((WIDTH - 2))" "" "$VERT"
}

# Start output
echo "Session Context"
if git rev-parse --is-inside-work-tree &>/dev/null; then
    branch=$(git branch --show-current 2>/dev/null)
    [[ -z "$branch" ]] && branch="(detached)"

    # Header with branch
    header=" $branch "
    header_len=${#header}
    right_dashes=$((WIDTH - 3 - header_len))
    printf "%s%s%s" "$TOP_LEFT" "$HORIZ" "$header"
    printf "%0.s$HORIZ" $(seq 1 $right_dashes)
    printf "%s\n" "$TOP_RIGHT"

    draw_empty

    # Check for merge/rebase in progress
    git_dir=$(git rev-parse --git-dir 2>/dev/null)
    if [[ -f "$git_dir/MERGE_HEAD" ]]; then
        conflicts=$(git diff --name-only --diff-filter=U 2>/dev/null | wc -l | tr -d ' \n')
        if [[ $conflicts -gt 0 ]]; then
            draw_content "⚠ MERGING ($conflicts conflicts)"
        else
            draw_content "⚠ MERGING"
        fi
        draw_empty
    elif [[ -d "$git_dir/rebase-merge" ]] || [[ -d "$git_dir/rebase-apply" ]]; then
        # Get rebase progress
        if [[ -d "$git_dir/rebase-merge" ]]; then
            current=$(cat "$git_dir/rebase-merge/msgnum" 2>/dev/null)
            total=$(cat "$git_dir/rebase-merge/end" 2>/dev/null)
        else
            current=$(cat "$git_dir/rebase-apply/next" 2>/dev/null)
            total=$(cat "$git_dir/rebase-apply/last" 2>/dev/null)
        fi
        if [[ -n "$current" && -n "$total" ]]; then
            draw_content "⚠ REBASING ($current/$total)"
        else
            draw_content "⚠ REBASING"
        fi
        draw_empty
    fi

    # Status line: staged, modified, untracked, stash
    changes=$(git status --porcelain 2>/dev/null)
    if [[ -n "$changes" ]]; then
        staged=$(echo "$changes" | grep -c '^[MADRC]')
        modified=$(echo "$changes" | grep -c '^.[MADRC]')
        untracked=$(echo "$changes" | grep -c '^??')
    else
        staged=0
        modified=0
        untracked=0
    fi
    stash_count=$(git stash list 2>/dev/null | wc -l | tr -d ' \n')

    # Ahead/behind and last fetch time
    upstream=$(git rev-parse --abbrev-ref '@{upstream}' 2>/dev/null)
    if [[ -n "$upstream" ]]; then
        ahead=$(git rev-list --count '@{upstream}..HEAD' 2>/dev/null || echo 0)
        behind=$(git rev-list --count 'HEAD..@{upstream}' 2>/dev/null || echo 0)
        # Last fetch time
        fetch_head="$git_dir/FETCH_HEAD"
        if [[ -f "$fetch_head" ]]; then
            if [[ "$OSTYPE" == "darwin"* ]]; then
                fetch_ts=$(stat -f %m "$fetch_head" 2>/dev/null)
            else
                fetch_ts=$(stat -c %Y "$fetch_head" 2>/dev/null)
            fi
            fetch_age=$(relative_time "$fetch_ts")
            remote_status="↑${ahead} ↓${behind} (${fetch_age})  "
        else
            remote_status="↑${ahead} ↓${behind}  "
        fi
    else
        remote_status=""
    fi

    status_line="●${staged}  +${modified}  …${untracked}"
    [[ $stash_count -gt 0 ]] && status_line="$status_line  \$${stash_count}"
    [[ -n "$remote_status" ]] && status_line="${remote_status}${status_line}"

    draw_content "$status_line"
    draw_empty

    # Recent commits with relative time
    while IFS= read -r line; do
        hash=$(echo "$line" | cut -d' ' -f1)
        msg=$(echo "$line" | cut -d' ' -f2-)
        ts=$(git log -1 --format=%ct "$hash" 2>/dev/null)
        age=$(relative_time "$ts")
        # Truncate message to fit: hash(7) + space(1) + msg + space(1) + (age)(max 6) = WIDTH - 6 (for padding)
        max_msg=$((WIDTH - 20))
        if ((${#msg} > max_msg)); then
            msg="${msg:0:$((max_msg - 2))}.."
        fi
        commit_line=$(printf "%s %-${max_msg}s (%s)" "$hash" "$msg" "$age")
        draw_content "$commit_line"
    done < <(git log --oneline -8 2>/dev/null)

    # GitHub PR and issues (if available)
    if command -v gh &>/dev/null && gh auth status &>/dev/null 2>&1; then
        # Check for active PR on current branch
        pr_info=$(gh pr view --json number,title 2>/dev/null)
        if [[ -n "$pr_info" ]]; then
            pr_num=$(echo "$pr_info" | grep -o '"number":[0-9]*' | cut -d: -f2)
            pr_title=$(echo "$pr_info" | grep -o '"title":"[^"]*"' | cut -d'"' -f4)
            if [[ -n "$pr_num" ]]; then
                draw_empty
                draw_content "Open PRs:"
                pr_text="#${pr_num} ${pr_title}"
                draw_content "$pr_text"
            fi
        fi

        # Open issues
        issues=$(gh issue list --limit 3 --state open 2>/dev/null)
        if [[ -n "$issues" ]]; then
            draw_empty
            draw_content "Open Issues:"
            while IFS=$'\t' read -r num _state title _; do
                issue_text="#${num} ${title}"
                draw_content "$issue_text"
            done < <(echo "$issues" | head -3)
        fi
    fi

    draw_empty
    draw_line "$BOT_LEFT" "$BOT_RIGHT" "$HORIZ"

    # Legend for Claude to understand symbols
    echo "Legend: ↑ahead ↓behind (last fetch) ●staged +modified …untracked \$stashed"
else
    # Not a git repo
    draw_line "$TOP_LEFT" "$TOP_RIGHT" "$HORIZ"
    draw_content "Not a git repository"
    draw_line "$BOT_LEFT" "$BOT_RIGHT" "$HORIZ"
fi
