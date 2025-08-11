# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Configuration for vim, tmux, zsh, bash, and more. This is a comprehensive dotfiles repository that manages shell environments, development tools, and application configurations across macOS systems.

## Installation

### Clean Install (New Machine)

```bash
git clone https://github.com/mjwestcott/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install
```

This will:
- Install Homebrew if not present
- Install all packages from the Brewfile
- Set up shell environments (Zsh with Antidote, Bash)
- Create symlinks for all configuration files
- Configure development tools (Neovim, Tmux, Git, etc.)

### Manual Post-Installation Steps

1. Change default shell: `chsh -s $(which zsh)`
2. Install Vim plugins (:Lazy install, :Lazy update)
3. Install Tmux plugins: `prefix + I`
4. Set up GitHub SSH keys
5. Configure Git signing keys
6. Create work git config: `~/.gitconfig-work` (see Git section below)
7. Start any required Homebrew services

### Updating Existing Machine

```bash
cd ~/dotfiles
git pull
brew bundle        # Install any new packages
source ~/.zshrc    # Reload shell configuration
```

## Package Management with Brewfile

Homebrew packages are managed declaratively via the `Brewfile`. This ensures reproducible installations across machines.

### Common Commands

```bash
# Install all packages from Brewfile
brew bundle

# Check if all Brewfile dependencies are satisfied
brew bundle check

# List all packages in Brewfile
brew bundle list

# Remove packages not listed in Brewfile
brew bundle cleanup

# Regenerate Brewfile from currently installed packages
brew bundle dump --describe --force
```

## Architecture

- **Shell**: Zsh with Antidote plugin manager, Starship prompt
- **Editor**: Neovim with lazy.nvim package manager
- **Terminal**: Alacritty, Tmux
- **Version Management**: pyenv (Python), rbenv (Ruby), rustup (Rust)
- **Package Managers**: Homebrew, npm, yarn, pipx

## Core Components

### Shell Environment
- `shell/profile` - Cross-shell configuration with extensive aliases, functions, and environment variables
- `shell/zsh/zshrc` - Zsh-specific configuration with Antidote plugin management
- `antidote/zsh_plugins.txt` - Plugin configuration (migrated from Prezto to Antidote)

### Development Tools
- `vim/` - Neovim configuration with Lua-based setup using lazy.nvim package manager
- `git/gitconfig` - Git configuration with extensive alias system and conditional includes
- `tmux/tmux.conf` - Terminal multiplexer configuration

### Application Configs
- `claude/` - Claude Code settings including custom statusline script
- `starship/starship.toml` - Cross-shell prompt configuration
- `alacritty/` - Terminal emulator configuration
- Various tool configs: `pgcli/`, `litecli/`, `ranger/`, `karabiner/`

## Key Features

### Extensive Git Alias System
The shell profile includes a comprehensive git alias system with single-letter shortcuts:
- Branch operations: `gb`, `gbc`, `gbl`
- Commit operations: `gc`, `gca`, `gcm`, `gco`
- Log operations: `gl`, `gls`, `gld`, `glo`
- And many more covering all git workflows

### FZF Integration
Multiple fuzzy finder functions for enhanced workflow:
- `,t` - Find and edit files
- `,j` - Jump to directories  
- `,a` - Search content with ripgrep
- `,c` - Search git commits
- `,b` - Checkout branches/tags

### Development Environment Management
- Python: Poetry, pyenv, conda integration
- Ruby: rbenv support
- Go: GOPATH configuration
- AWS: Profile switching functions (`asp`, `agp`)
- Multiple package managers and tools

## Common Development Tasks

### Claude Code Configuration
- Settings: `claude/settings.json` with custom statusline
- Statusline script: `claude/statusline.sh` (Starship-style prompt)
- Installation creates symlinks to `~/.claude/`

### Plugin Management
- Zsh plugins managed via Antidote: `antidote/zsh_plugins.txt`
- Vim plugins managed via lazy.nvim: `vim/init.lua`
- Tmux plugins via TPM: install with `prefix + I`

### Git Configuration

The git config includes conditional includes for work repositories:
- `~/work/` and `~/repos/work/` directories will use `~/.gitconfig-work`
- Create `~/.gitconfig-work` manually with work-specific settings:

```gitconfig
[user]
    name = Your Name
    email = work@company.com
    signingkey = WORK_KEY_ID
[commit]
    gpgsign = true
```

### Shell Performance Monitoring

Use `bench` alias to measure shell startup time with zsh-bench:
```bash
bench        # Run shell startup benchmark
```

## File Structure

All configurations follow a modular structure:
- Application-specific directories contain related configurations
- The `install` script creates appropriate symlinks
- Backup system preserves existing configurations
- Private configurations can be added via `~/dotfiles/private`
