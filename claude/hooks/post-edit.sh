#!/bin/bash

# Claude Code PostToolUse hook for auto-formatting and linting
# Formats files and provides lint feedback to Claude
# Supports Python, JavaScript/TypeScript, JSON, Go, Shell, Lua, Markdown, and YAML

file_path="$1"

# Exit if no file path provided
if [[ -z "$file_path" ]]; then
    exit 0
fi

# Exit if file doesn't exist
if [[ ! -f "$file_path" ]]; then
    exit 0
fi

# Get file extension and name
extension="${file_path##*.}"
filename=$(basename "$file_path")

# Collect lint errors for feedback
lint_errors=""

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to add lint feedback
add_lint_error() {
    if [[ -n "$lint_errors" ]]; then
        lint_errors="$lint_errors\n$1"
    else
        lint_errors="$1"
    fi
}

# Function to remove trailing whitespace
trim_whitespace() {
    local file="$1"
    sed -i.bak 's/[[:space:]]*$//' "$file" && rm -f "${file}.bak"
}

# Python files
if [[ "$extension" == "py" ]]; then
    echo "Formatting Python file: $filename"
    if command_exists ruff; then
        ruff format --quiet "$file_path" &>/dev/null
        # Lint with ruff
        errors=$(ruff check --output-format=concise "$file_path" 2>&1)
        if [[ -n "$errors" && "$errors" != *"All checks passed"* ]]; then
            add_lint_error "Ruff: $errors"
        fi
    elif command_exists black; then
        black --quiet "$file_path" &>/dev/null
    fi
    # Type check with pyright if available
    if command_exists pyright; then
        errors=$(pyright "$file_path" 2>&1 | grep -E "error:" | head -5)
        if [[ -n "$errors" ]]; then
            add_lint_error "Pyright: $errors"
        fi
    fi

# JavaScript/TypeScript files
elif [[ "$extension" =~ ^(js|ts|jsx|tsx)$ ]]; then
    echo "Formatting JS/TS file: $filename"
    if command_exists biome; then
        biome format --write "$file_path" &>/dev/null
        # Lint with biome
        errors=$(biome lint "$file_path" 2>&1 | grep -E "^.*(error|warning)" | head -5)
        if [[ -n "$errors" ]]; then
            add_lint_error "Biome: $errors"
        fi
    elif command_exists prettier; then
        prettier --write "$file_path" &>/dev/null
    fi
    # TypeScript type checking
    if [[ "$extension" =~ ^(ts|tsx)$ ]] && command_exists tsc; then
        errors=$(tsc --noEmit "$file_path" 2>&1 | grep -E "error TS" | head -5)
        if [[ -n "$errors" ]]; then
            add_lint_error "TypeScript: $errors"
        fi
    fi

# JSON files
elif [[ "$extension" == "json" ]]; then
    echo "Formatting JSON file: $filename"
    if command_exists biome; then
        biome format --write "$file_path" &>/dev/null
    elif command_exists prettier; then
        prettier --write "$file_path" &>/dev/null
    fi

# Go files
elif [[ "$extension" == "go" ]]; then
    echo "Formatting Go file: $filename"
    if command_exists goimports; then
        goimports -w "$file_path" &>/dev/null
    elif command_exists gofmt; then
        gofmt -w "$file_path" &>/dev/null
    fi
    # Lint with golangci-lint or go vet
    if command_exists golangci-lint; then
        errors=$(golangci-lint run "$file_path" 2>&1 | head -5)
        if [[ -n "$errors" && "$errors" != *"no issues"* ]]; then
            add_lint_error "golangci-lint: $errors"
        fi
    elif command_exists go; then
        errors=$(go vet "$file_path" 2>&1)
        if [[ -n "$errors" ]]; then
            add_lint_error "go vet: $errors"
        fi
    fi

# Shell scripts
elif [[ "$extension" =~ ^(sh|bash|zsh)$ ]] || [[ "$filename" =~ ^(zshrc|bashrc|profile)$ ]]; then
    echo "Formatting shell script: $filename"
    if command_exists shfmt; then
        shfmt -w -i 4 "$file_path" &>/dev/null
    fi
    # Lint with shellcheck
    if command_exists shellcheck; then
        errors=$(shellcheck -f gcc "$file_path" 2>&1 | grep -E ":(error|warning):" | head -5)
        if [[ -n "$errors" ]]; then
            add_lint_error "ShellCheck: $errors"
        fi
    fi

# Lua files
elif [[ "$extension" == "lua" ]]; then
    echo "Formatting Lua file: $filename"
    if command_exists stylua; then
        stylua "$file_path" &>/dev/null
    fi

# Markdown files
elif [[ "$extension" == "md" ]]; then
    echo "Formatting Markdown file: $filename"
    if command_exists prettier; then
        prettier --write "$file_path" &>/dev/null
    fi

# YAML files
elif [[ "$extension" =~ ^(yaml|yml)$ ]]; then
    echo "Formatting YAML file: $filename"
    if command_exists prettier; then
        prettier --write "$file_path" &>/dev/null
    fi
fi

# Trim trailing whitespace for text files without dedicated formatters
if [[ "$extension" =~ ^(txt|toml|conf)$ ]]; then
    trim_whitespace "$file_path"
fi

# Output lint feedback to Claude if there were errors
if [[ -n "$lint_errors" ]]; then
    # Escape for JSON
    escaped_errors=$(echo -e "$lint_errors" | jq -Rs '.')
    echo "{\"feedback\": $escaped_errors}"
fi

exit 0
