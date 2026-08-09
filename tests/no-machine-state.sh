#!/usr/bin/env bash
# Block machine-local or private state from reaching this public repo.
#
# Agent tools (Codex, Claude Code) write their own state back into the config
# files they read. Where this repo tracks such a file, an app write can land
# private data — trusted project paths, absolute home paths, marketplace cache
# locations — in a commit. This hook is the backstop for that.
set -euo pipefail

# Patterns that should never appear in a tracked agent config.
patterns=(
    'trust_level'       # Codex per-project trust, names real repo paths
    '^\[projects\.'     # Codex [projects."/Users/.../work-repo"] tables
    '^\[marketplaces\.' # local cache paths + churning timestamps
    'installation_id'
    '/Users/[^/]*/repos/' # absolute paths into checked-out work
)

status=0
for file in "$@"; do
    [[ -f "$file" ]] || continue
    for pattern in "${patterns[@]}"; do
        if grep -nE "$pattern" "$file" >/dev/null 2>&1; then
            echo "ERROR: $file contains machine-local state matching /$pattern/" >&2
            grep -nE "$pattern" "$file" | sed 's/^/    /' >&2
            status=1
        fi
    done
done

if [[ $status -ne 0 ]]; then
    cat >&2 <<'EOF'

This repo is public. Agent config tracked here must contain preferences only —
machine state belongs in the untracked base config the app owns.
EOF
fi

exit $status
