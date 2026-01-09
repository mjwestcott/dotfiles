# dotfiles

Configuration for vim, tmux, zsh, and more.

## Installation

```bash
git clone https://github.com/mjwestcott/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install
```

This will:
- Install Homebrew if not present
- Install all packages from the Brewfile
- Set up Zsh shell environment with Antidote plugin manager
- Create symlinks for all configuration files
- Configure development tools (Neovim, Tmux, Git, etc.)

The install is idempotent, so run `make install` (or `make update`) anytime to pull in changes.

### Post-Installation Steps

1. Change default shell: `chsh -s $(which zsh)`
2. Install Vim plugins: `:Lazy install`
3. Install Tmux plugins: `prefix + I`
4. Set up GitHub SSH keys
5. Configure Git signing keys

### Make Targets

```bash
make install  # Install/update dotfiles
make test     # Verify configs source cleanly
make lint     # Run all linters
make help     # Show all available targets
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
