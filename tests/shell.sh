#!/bin/bash
#
# Dotfiles configuration test
#

set -euo pipefail

test_config() {
    local name="$1" file="$2"

    if source "$file" &>/dev/null; then
        echo "✓ $name sources cleanly"
    else
        echo "✗ $name has errors" >&2
        exit 1
    fi
}

test_zsh_config() {
    local name="$1" file="$2"

    if command -v zsh >/dev/null 2>&1; then
        # Test with output capture to see actual errors
        local output
        if output=$(zsh -c "source '$file'; echo 'CONFIG_LOADED'" 2>&1) && [[ "$output" == *"CONFIG_LOADED"* ]]; then
            echo "✓ $name sources cleanly in zsh"
        else
            echo "✗ $name has errors in zsh:" >&2
            echo "$output" >&2
            exit 1
        fi
    else
        echo "⚠ Skipping $name (zsh not available)"
    fi
}


echo "Testing dotfiles configuration..."

test_config "Profile" ~/dotfiles/shell/profile
test_zsh_config "Zshrc" ~/dotfiles/shell/zsh/zshrc

echo "✓ All tests passed"
