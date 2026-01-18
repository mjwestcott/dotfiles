#!/bin/bash

# Claude Code hooks script for auto-formatting
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

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
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
    elif command_exists black; then
        black --quiet "$file_path" &>/dev/null
    fi

# JavaScript/TypeScript files
elif [[ "$extension" =~ ^(js|ts|jsx|tsx)$ ]]; then
    echo "Formatting JS/TS file: $filename"
    if command_exists biome; then
        biome format --write "$file_path" &>/dev/null
    elif command_exists prettier; then
        prettier --write "$file_path" &>/dev/null
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

# Shell scripts
elif [[ "$extension" =~ ^(sh|bash|zsh)$ ]] || [[ "$filename" =~ ^(zshrc|bashrc|profile)$ ]]; then
    echo "Formatting shell script: $filename"
    if command_exists shfmt; then
        shfmt -w -i 4 "$file_path" &>/dev/null
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

exit 0
