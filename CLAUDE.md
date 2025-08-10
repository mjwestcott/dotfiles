# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a comprehensive dotfiles repository that manages shell environments, development tools, and application configurations across macOS systems. All configurations are centrally managed here and symlinked to their expected locations.

## Installation and Setup

**Primary Installation Command:**
```bash
./install_macos
```

This script handles the complete system setup including:
- Homebrew installation and package management
- Development environment setup (Python, Ruby, Rust, Go, Node.js)
- Shell configuration (Zsh with Antidote plugin manager)
- Application configurations (Git, Vim/Neovim, Tmux, etc.)
- Symlink creation for all dotfiles

**Manual Post-Installation Steps:**
- Change default shell: `chsh -s $(which zsh)`
- Install Vim plugins and fzf integration
- Install Tmux plugins: `prefix + I`
- Set up GitHub SSH keys and Git signing keys
- Start required Homebrew services

## Architecture and Organization

### Core Components

**Shell Environment:**
- `shell/profile` - Cross-shell configuration with extensive aliases, functions, and environment variables
- `shell/zsh/zshrc` - Zsh-specific configuration with Antidote plugin management
- `antidote/zsh_plugins.txt` - Plugin configuration (migrated from Prezto to Antidote)

**Development Tools:**
- `vim/` - Neovim configuration with Lua-based setup using lazy.nvim package manager
- `git/gitconfig` - Git configuration with extensive alias system
- `tmux/tmux.conf` - Terminal multiplexer configuration

**Application Configs:**
- `claude/` - Claude Code settings including custom statusline script
- `starship/starship.toml` - Cross-shell prompt configuration
- `alacritty/` - Terminal emulator configuration
- Various tool configs: `pgcli/`, `litecli/`, `ranger/`, `karabiner/`

### Key Features

**Extensive Git Alias System:**
The shell profile includes a comprehensive git alias system with single-letter shortcuts:
- Branch operations: `gb`, `gbc`, `gbl`
- Commit operations: `gc`, `gca`, `gcm`, `gco`
- Log operations: `gl`, `gls`, `gld`, `glo`
- And many more covering all git workflows

**FZF Integration:**
Multiple fuzzy finder functions for enhanced workflow:
- `,t` - Find and edit files
- `,j` - Jump to directories  
- `,a` - Search content with ripgrep
- `,c` - Search git commits
- `,b` - Checkout branches/tags

**Development Environment Management:**
- Python: Poetry, pyenv, conda integration
- Ruby: rbenv support
- Go: GOPATH configuration
- AWS: Profile switching functions (`asp`, `agp`)
- Multiple package managers and tools

## Common Development Tasks

**Environment Setup:**
```bash
# Install all dependencies and configure environment
./install_macos

# Reload shell configuration
source ~/.zshrc
```

**Claude Code Configuration:**
- Settings: `claude/settings.json` with custom statusline
- Statusline script: `claude/statusline.sh` (Starship-style prompt)
- Installation creates symlinks to `~/.claude/`

**Plugin Management:**
- Zsh plugins managed via Antidote: `antidote/zsh_plugins.txt`
- Vim plugins managed via lazy.nvim: `vim/init.lua`
- Tmux plugins via TPM: install with `prefix + I`

## File Structure

All configurations follow a modular structure:
- Application-specific directories contain related configurations
- The `install_macos` script creates appropriate symlinks
- Backup system preserves existing configurations
- Private configurations can be added via `~/dotfiles/private`