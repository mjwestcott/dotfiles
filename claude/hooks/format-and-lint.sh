#!/bin/bash

# Claude Code hooks script for auto-formatting and linting
# Supports Python, JavaScript/TypeScript, and shell scripts

file_path="$1"

# Exit if no file path provided
if [[ -z "$file_path" ]]; then
    exit 0
fi

# Exit if file doesn't exist
if [[ ! -f "$file_path" ]]; then
    exit 0
fi

# Get file extension
extension="${file_path##*.}"
basename=$(basename "$file_path")

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to remove trailing whitespace (safe for all file types)
trim_whitespace() {
    local file="$1"
    # Use sed to remove trailing whitespace, create backup
    sed -i.bak 's/[[:space:]]*$//' "$file" && rm -f "${file}.bak"
}

# Python files
if [[ "$extension" == "py" ]]; then
    echo "Formatting Python file: $basename"

    # Format with Black if available
    if command_exists black; then
        black --quiet "$file_path" 2>/dev/null
    fi

    # Lint with Ruff if available
    if command_exists ruff; then
        ruff check --fix --quiet "$file_path" 2>/dev/null
    fi

# JavaScript/TypeScript files
elif [[ "$extension" =~ ^(js|ts|jsx|tsx|json)$ ]]; then
    echo "Formatting JS/TS file: $basename"

    # Format with Prettier if available
    if command_exists prettier; then
        prettier --write "$file_path" 2>/dev/null
    fi

    # Lint with ESLint if available and fix auto-fixable issues
    if command_exists eslint; then
        eslint --fix --quiet "$file_path" 2>/dev/null
    fi

# Shell scripts
elif [[ "$extension" =~ ^(sh|bash|zsh)$ ]] || [[ "$basename" =~ ^(zshrc|bashrc|profile)$ ]]; then
    echo "Linting shell script: $basename"

    # Check if file has shell shebang
    first_line=$(head -n 1 "$file_path")
    if [[ "$first_line" =~ ^\#\!.*/(bash|zsh|sh) ]] || [[ "$extension" =~ ^(sh|bash|zsh)$ ]]; then
        # Lint with ShellCheck if available
        if command_exists shellcheck; then
            # Run shellcheck but don't fail on warnings
            shellcheck -x "$file_path" 2>/dev/null || true
        fi

        # Format with shfmt if available
        if command_exists shfmt; then
            shfmt -w -i 4 "$file_path" 2>/dev/null
        fi
    fi

# Markdown files
elif [[ "$extension" == "md" ]]; then
    echo "Formatting Markdown file: $basename"

    # Format with Prettier if available
    if command_exists prettier; then
        prettier --write "$file_path" 2>/dev/null
    fi
fi

# Always trim trailing whitespace for text files
if [[ "$extension" =~ ^(py|js|ts|jsx|tsx|sh|bash|zsh|md|txt|yaml|yml|json|toml|conf|lua)$ ]]; then
    trim_whitespace "$file_path"
fi

exit 0
