# dotfiles

Configuration for vim, tmux, zsh, and more.

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

### Manual Post-Installation Steps

1. Change default shell: `chsh -s $(which zsh)`
2. Install Vim plugins (:Lazy install, :Lazy update)
3. Install Tmux plugins: `prefix + I`
4. Set up GitHub SSH keys
5. Configure Git signing keys
6. Start any required Homebrew services

### Testing Configuration

Validate your setup with the test suite:
```bash
~/dotfiles/tests/shell.sh    # Verify configs source cleanly
```

Optionally install pre-commit hooks to run tests automatically:
```bash
pre-commit install            # Run tests before each commit
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
