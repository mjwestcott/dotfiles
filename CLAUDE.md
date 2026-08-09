# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Configuration for vim, tmux, zsh, and more. This is a comprehensive dotfiles repository that manages Zsh shell environment, development tools, and application configurations across macOS systems.

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
- Set up Zsh shell environment with Antidote plugin manager
- Create symlinks for all configuration files
- Configure development tools (Neovim, Tmux, Git, etc.)
- Install the pre-commit hooks, including the machine-state guard
- Install Claude Code managed settings to `/Library/Application Support/ClaudeCode/`
  (prompts for `sudo`; skipped when already current)

### Manual Post-Installation Steps

1. Change default shell: `chsh -s $(which zsh)`
2. Install Vim plugins (:Lazy install, :Lazy update)
3. Install Tmux plugins: `prefix + I`
4. Set up GitHub SSH keys
5. Create per-machine git signing config: `~/.gitconfig-local` (see Git section below)
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
- **Terminal**: Ghostty, Tmux
- **Version Management**: pyenv (Python), rbenv (Ruby), rustup (Rust)
- **Package Managers**: Homebrew, npm, yarn, pipx

## Core Components

### Shell Environment

- `shell/profile` - Cross-shell configuration with extensive aliases, functions, and environment variables
- `shell/zsh/zshrc` - Zsh configuration with Antidote plugin management
- `antidote/zsh_plugins.txt` - Zsh plugin configuration (migrated from Prezto to Antidote)

### Development Tools

- `vim/` - Neovim configuration with Lua-based setup using lazy.nvim package manager
- `git/gitconfig` - Git configuration with extensive alias system and conditional includes
- `tmux/tmux.conf` - Terminal multiplexer configuration

### Application Configs

- `claude/` - Claude Code settings including custom statusline script
- `starship/starship.toml` - Cross-shell prompt configuration
- `ghostty/` - Terminal emulator configuration
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

- Python: uv, pyenv, conda integration
- Ruby: rbenv support
- Go: GOPATH configuration
- AWS: Profile switching functions (`asp`, `agp`)
- Multiple package managers and tools

## Common Development Tasks

### Claude Code Configuration

- Settings: `claude/settings.json` with custom statusline
- Statusline script: `bin/cc-statusline` (Starship-style prompt)
- Permission deny rules: `claude/managed-settings.json`
- Custom agents: `claude/agents/`
- Custom skills: `claude/skills/`
- Installation creates symlinks to `~/.claude/`

Deny rules live in managed settings rather than `settings.json` because Claude
Code writes to user settings (`/model`, `/effort`, `/fast` all persist there)
but only ever reads managed settings, and project settings cannot override them.
`install` copies that file to `/Library/Application Support/ClaudeCode/` as root
— a policy file the invoking user can rewrite is not a policy file.

### Agent Config and Machine State

Codex and Claude Code both write their own state back into config files they
read. Because this repo is public, tracked agent config must hold preferences
only; anything the app writes stays in the untracked file the app owns:

| Tool   | Repo owns (tracked)                                     | App owns (untracked)   |
| ------ | ------------------------------------------------------- | ---------------------- |
| Codex  | `codex/dotfiles.config.toml`, layered via `-p dotfiles` | `~/.codex/config.toml` |
| Claude | `claude/managed-settings.json`                          | `~/.claude.json`       |

The `no-machine-state` pre-commit hook (`tests/no-machine-state.sh`) blocks
trusted project paths, marketplace tables and absolute repo paths from reaching
a commit.

### Plugin Management

- **Zsh**: Antidote plugin manager via `antidote/zsh_plugins.txt`
- **Vim**: lazy.nvim package manager via `vim/init.lua`
- **Tmux**: TPM plugin manager - install with `prefix + I`

### Git Configuration

Commit signing uses SSH, and the key differs per machine, so `user.signingkey`
is not tracked here. Each machine needs `~/.gitconfig-local`:

```gitconfig
[user]
    signingkey = ssh-ed25519 AAAA...this machine's public key
```

Without it, commits fail with `Couldn't find key in agent?`. Also add the
matching public key to `git/allowed_signers` (so its commits verify on every
machine) and register it on GitHub as a _signing_ key — GitHub tracks
authentication and signing keys separately, and the same key must be added
under both to both push and show commits as Verified.

The git config also includes conditional includes for work repositories:

- `~/work/` and `~/repos/work/` directories will use `~/.gitconfig-work`
- Create `~/.gitconfig-work` manually with work-specific settings:

```gitconfig
[user]
    name = Your Name
    email = work@company.com
    signingkey = WORK_KEY_ID
[commit]
    gpgsign = true
# Required: the global config sets format = ssh, which this inherits. Without
# this line git would read the OpenPGP signingkey above as an SSH key.
[gpg]
    format = openpgp
```

### Shell Performance Monitoring

Use `bench` alias to measure shell startup time with zsh-bench:

```bash
bench        # Run shell startup benchmark
```

### Testing Configuration

Run the shell configuration test suite to validate setup:

```bash
just test    # Verify configs source cleanly in zsh
```

The minimal test suite validates that both `shell/profile` and `shell/zsh/zshrc` can be sourced without errors, ensuring your shell configuration is working properly.

### Code Quality and Linting

The repository includes automated formatting and linting capabilities:

#### Formatting & Linting (Automatic)

Claude Code is configured to automatically format and lint files on save via the hook in `claude/hooks/post-edit.sh`:

- **Python**: ruff format + ruff check + pyright
- **JavaScript/TypeScript**: biome format + biome lint + tsc
- **JSON**: biome/prettier formatting
- **Go**: goimports + golangci-lint
- **Shell scripts**: shfmt + shellcheck
- **Markdown/YAML**: prettier formatting
- **All text files**: Trailing whitespace removal

Lint errors are fed back to Claude as JSON feedback for automatic fixing.

#### Linting (Manual)

Use the justfile for comprehensive linting after making multiple changes:

```bash
# Lint all file types
just lint

# Lint specific file types
just lint-python     # Ruff (Python)
just lint-js         # Biome (JavaScript/TypeScript/JSON/CSS)
just lint-shell      # ShellCheck (shell scripts)
just lint-markdown   # markdownlint, or Prettier as a fallback
```

The required tools are declared in the Brewfile. Install or update them with:

```bash
brew bundle
```

`markdownlint` remains optional; when it is absent, `just lint-markdown` uses
the Brewfile's Prettier installation. The other lint recipes also report and
skip tools that are not installed.

## File Structure

All configurations follow a modular structure:

- Application-specific directories contain related configurations
- The `install` script creates appropriate symlinks
- Backup system preserves existing configurations
- Private configurations can be added via `~/dotfiles/private`
