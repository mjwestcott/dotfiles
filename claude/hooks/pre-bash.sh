#!/bin/bash

# Claude Code PreToolUse hook for blocking dangerous bash commands
# Exit 0 = allow, Exit 2 = block (message to stderr shown to Claude)

input=$(cat)
cmd=$(echo "$input" | jq -r '.tool_input.command // empty')

# Exit if no command
if [[ -z "$cmd" ]]; then
    exit 0
fi

# Destructive git operations
if echo "$cmd" | grep -qE 'git\s+reset\s+--hard'; then
    echo "Blocked: git reset --hard destroys uncommitted changes" >&2
    exit 2
fi

if echo "$cmd" | grep -qE 'git\s+clean\s+-f'; then
    echo "Blocked: git clean -f permanently removes untracked files" >&2
    exit 2
fi

if echo "$cmd" | grep -qE 'git\s+checkout\s+--\s'; then
    echo "Blocked: git checkout -- discards uncommitted changes" >&2
    exit 2
fi

if echo "$cmd" | grep -qE 'git\s+stash\s+(drop|clear)'; then
    echo "Blocked: git stash drop/clear permanently deletes stashed work" >&2
    exit 2
fi

if echo "$cmd" | grep -qE 'git\s+branch\s+-D'; then
    echo "Blocked: git branch -D force-deletes without merge check. Use -d instead." >&2
    exit 2
fi

# Dangerous filesystem operations
if echo "$cmd" | grep -qE 'rm\s+(-[rf]+\s+)*(/|~|\$HOME)'; then
    echo "Blocked: rm targeting root or home directory" >&2
    exit 2
fi

if echo "$cmd" | grep -qE 'rm\s+-rf?\s+\.\.' ; then
    echo "Blocked: rm targeting parent directories" >&2
    exit 2
fi

if echo "$cmd" | grep -qE 'chmod\s+777'; then
    echo "Blocked: chmod 777 is overly permissive" >&2
    exit 2
fi

if echo "$cmd" | grep -qE 'find\s+.*-delete'; then
    echo "Blocked: find -delete can cause unintended file removal" >&2
    exit 2
fi

if echo "$cmd" | grep -qE '(xargs|parallel)\s+.*rm\s+-rf'; then
    echo "Blocked: piped rm -rf with dynamic targets is dangerous" >&2
    exit 2
fi

# Dangerous network operations
if echo "$cmd" | grep -qE 'curl.*\|\s*(bash|sh|zsh)'; then
    echo "Blocked: piping curl to shell is a security risk" >&2
    exit 2
fi

if echo "$cmd" | grep -qE 'wget.*\|\s*(bash|sh|zsh)'; then
    echo "Blocked: piping wget to shell is a security risk" >&2
    exit 2
fi

# Interpreter one-liners that might hide dangerous commands
if echo "$cmd" | grep -qE "(python|python3|ruby|node|perl)\s+-[ec]\s+.*\b(rm|git reset|chmod|chown|curl.*\|)" ; then
    echo "Blocked: interpreter one-liner containing potentially dangerous command" >&2
    exit 2
fi

# Check for shell wrappers hiding commands (basic check)
if echo "$cmd" | grep -qE "(bash|sh|zsh)\s+-c\s+.*\b(rm -rf|git reset --hard|git push.*-f)"; then
    echo "Blocked: shell wrapper hiding dangerous command" >&2
    exit 2
fi

# Allow everything else
exit 0
