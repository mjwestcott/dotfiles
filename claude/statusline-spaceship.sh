#!/bin/bash

# Spaceship-style status line for Claude Code
# Matches the user's zsh Spaceship prompt configuration

input=$(cat)
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
model_name=$(echo "$input" | jq -r '.model.display_name')

# Colors (using ANSI codes to match Spaceship theme)
RESET="\033[0m"
BOLD="\033[1m"       # Bold text
BLUE="\033[34m"      # Directory color (SPACESHIP_DIR_COLOR="4")
GRAY="\033[37m"      # User/host and git branch color (SPACESHIP_*_COLOR="7")
YELLOW="\033[33m"    # Git status color (SPACESHIP_GIT_STATUS_COLOR="3")
GREEN="\033[32m"     # Virtual env color (SPACESHIP_VENV_COLOR="2")
RED="\033[31m"       # AWS color (SPACESHIP_AWS_COLOR="1")

# Get directory (full path like Spaceship with SPACESHIP_DIR_TRUNC="0")
# Replace home directory with ~ for brevity
dir="${current_dir/#$HOME/~}"

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
    
    # Format git info (no symbol prefix like SPACESHIP_GIT_SYMBOL="")
    git_info=" ${BOLD}${GRAY}${branch}${RESET}${YELLOW}${git_status}${RESET}"
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

# Build the prompt line by line like Spaceship
line1=""

# Add directory (blue like SPACESHIP_DIR_COLOR="4")
line1="${line1}${BOLD}${BLUE}${dir}${RESET}"

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
printf "${line1}"
