#!/bin/bash

# Starship-style status line for Claude Code
# Matches the user's cross-shell Starship prompt configuration

input=$(cat)
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
model_name=$(echo "$input" | jq -r '.model.display_name')

# Colors (using ANSI codes to match Starship theme - no bold)
RESET="\033[0m"
BLUE="\033[34m"      # Directory color (blue in starship.toml)
WHITE="\033[37m"     # Git branch color (white in starship.toml)
YELLOW="\033[33m"    # Git status color (yellow in starship.toml)
GREEN="\033[32m"     # Virtual env color (green in starship.toml)
RED="\033[31m"       # AWS color (red in starship.toml)
GRAY="\033[38;2;143;143;143m"  # Model name color (RGB gray #8f8f8f)

# Get directory (Starship style with truncation_length = 0)
# Show ~ for home, relative path for subdirs, full path otherwise
if [[ "$current_dir" == "$HOME" ]]; then
    dir="~"
elif [[ "$current_dir" == "$HOME"/* ]]; then
    # Remove home prefix for subdirectories
    dir="${current_dir#"$HOME"/}"
else
    # Full path for directories outside home
    dir="$current_dir"
fi

# Get git info if in a git repository
git_info=""
if command -v git >/dev/null 2>&1 && git -C "$current_dir" rev-parse --git-dir >/dev/null 2>&1; then
    # Get branch name
    branch=$(git -C "$current_dir" symbolic-ref --short HEAD 2>/dev/null || git -C "$current_dir" describe --tags --exact-match 2>/dev/null || git -C "$current_dir" rev-parse --short HEAD 2>/dev/null)

    # Get git status
    git_status=""
    if ! git -C "$current_dir" diff --quiet 2>/dev/null; then
        git_status="*"
    fi
    if ! git -C "$current_dir" diff --cached --quiet 2>/dev/null; then
        git_status="${git_status}+"
    fi

    # Format git info
    git_info=" ${WHITE}${branch}${RESET}${YELLOW}${git_status}${RESET}"
fi

# Get virtual environment info
venv_info=""
if [[ -n "$VIRTUAL_ENV" ]]; then
    venv_name="${VIRTUAL_ENV##*/}"
    venv_info="${GREEN}${venv_name}${RESET} "
fi

# Get conda environment info
conda_info=""
if [[ -n "$CONDA_DEFAULT_ENV" && "$CONDA_DEFAULT_ENV" != "base" ]]; then
    conda_info="${GREEN}${CONDA_DEFAULT_ENV}${RESET} "
fi

# AWS info (basic check for AWS_PROFILE)
aws_info=""
if [[ -n "$AWS_PROFILE" ]]; then
    aws_info="${RED}${AWS_PROFILE}${RESET} "
fi

# Build the prompt line
line1=""

# Add directory (blue to match starship)
line1="${line1}${BLUE}${dir}${RESET}"

# Add AWS info
line1="${line1}${aws_info}"

# Add git info
line1="${line1}${git_info}"

# Add virtual environment
line1="${line1} ${venv_info}"

# Add conda environment
line1="${line1}${conda_info}"

# Add model info in a subtle way
line1="${line1}${GRAY}${model_name}${RESET}"

# Print the final prompt (single line only)
printf '%s' "${line1}"
