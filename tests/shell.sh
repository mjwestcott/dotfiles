#!/usr/bin/env zsh
#
# Dotfiles configuration test
#

set -euo pipefail

test_config() {
    local name="$1" file="$2"

    if source "$file" &>/dev/null; then
        print "✓ $name sources cleanly"
    else
        print "✗ $name has errors" >&2
        exit 1
    fi
}

print "Testing dotfiles configuration..."

test_config "Profile" ~/dotfiles/shell/profile
test_config "Zshrc" ~/dotfiles/shell/zsh/zshrc

print "✓ All tests passed"
