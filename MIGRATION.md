# Migration Guide: Prezto → Antidote, Spaceship → Starship

This guide helps migrate existing machines from the old Prezto/Spaceship setup to the new Antidote/Starship configuration after pulling the latest changes.

## ⚠️ Important: Follow Steps in Order

The migration is complex due to shell configuration dependencies. **Do not skip steps** or your shell may become temporarily unusable.

## Step 1: Backup Current Shell State

```bash
# Save current working shell session info
echo "Current shell: $0" > ~/migration-backup.txt
echo "Current PATH: $PATH" >> ~/migration-backup.txt

# Keep a terminal window open with your current shell
# (Don't close this until migration is complete)
```

## Step 2: Pull Latest Changes

```bash
cd ~/dotfiles
git pull origin master
```

## Step 3: Clean Up Old Prezto Installation

```bash
# Remove Prezto directory and submodules
rm -rf ~/.zprezto

# Remove old completion cache
rm -f ~/.zcompdump*

# Remove old Prezto-managed completions (if they exist)
rm -f ~/.zprezto/modules/completion/external/src/_poetry
rm -f ~/.zprezto/modules/completion/external/src/_docker
rm -f ~/.zprezto/modules/completion/external/src/_docker-compose  
rm -f ~/.zprezto/modules/completion/external/src/_kind
```

## Step 4: Update Homebrew Packages

```bash
# Remove fasd (replaced by starship + different directory jumping)
brew uninstall fasd 2>/dev/null || true

# Install starship (replaces spaceship prompt)
brew install starship
```

## Step 5: Fix Claude Code Configuration

```bash
# Remove old statusline symlink
rm -f ~/.claude/statusline-spaceship.sh
```

## Step 6: Install New Components

Install only what's needed for the migration:

```bash
# Install Antidote (replaces Prezto)
git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote

# Create new symlinks for Antidote and Starship
ln -sfv ~/dotfiles/antidote/zsh_plugins.txt ~/.zsh_plugins.txt
ln -sfv ~/dotfiles/starship/starship.toml ~/.config/starship.toml

# Update Claude statusline symlink
ln -sfv ~/dotfiles/claude/statusline.sh ~/.claude/statusline.sh
```

**Note**: Existing dotfile symlinks don't need to be recreated - only the content of those files changed.

## Step 7: Start New Shell Session

```bash
# Important: Start a completely new terminal session
# Your current shell may be in a broken state

# In new terminal, verify everything works:
echo "Testing new shell setup..."

# Test git aliases work
git status  # Should work via 'g' alias from profile

# Test starship prompt loads
# (You should see the new starship prompt)

# Test antidote plugins load
# (Should see syntax highlighting, autosuggestions, etc.)
```

## Step 8: Verify Migration Success

Check these key components work:

```bash
# 1. Git aliases from shared profile
g status  # Should work (alias for git)
gws      # Should work (git status --short)

# 2. Starship prompt
# Should see colorized prompt with git info, directory, etc.

# 3. Zsh plugins via Antidote  
# Type partial command and press Tab - should see completions
# Type partial command and press up arrow - should see history search

# 4. Claude Code statusline
claude  # Should show new statusline format

# 5. Python environment detection in prompt
# If in venv/conda env, should show in prompt

# 6. FZF functions
,t  # Should open file finder
,j  # Should jump to directories
```

## Troubleshooting

### Shell Won't Start / Errors on Startup

```bash
# If zsh fails to start, use bash temporarily:
bash

# Then re-run install script:
cd ~/dotfiles && ./install_macos

# Try zsh again:
zsh
```

### Git Aliases Don't Work

```bash
# Verify profile is being sourced:
grep "source.*profile" ~/.zshrc

# Manually source profile:
source ~/dotfiles/shell/profile
```

### Prompt Looks Wrong

```bash
# Verify starship is installed:
which starship

# Verify starship config is linked:
ls -la ~/.config/starship.toml

# Restart starship:
eval "$(starship init zsh)"
```

### Claude Code Statusline Broken

```bash
# Verify new statusline exists:
ls -la ~/.claude/statusline.sh

# Check Claude settings:
cat ~/.claude/settings.json
# Should point to "~/.claude/statusline.sh"
```

### Completions Don't Work

```bash
# Clear completion cache:
rm -f ~/.zcompdump*

# Restart shell to rebuild completions:
exec zsh
```

## Rollback Plan (Emergency)

If migration fails completely:

```bash
# 1. Use backup info from Step 1
cat ~/migration-backup.txt

# 2. Restore previous dotfiles if needed:
cd ~/dotfiles
git log --oneline -10  # Find commit before migration
git reset --hard <previous-commit-hash>

# 3. Re-install Prezto manually (if needed):
git clone --recursive https://github.com/mjwestcott/prezto.git ~/.zprezto

# 4. Run old install process
./install_macos  # (will use old version)
```

## Post-Migration Cleanup

Once everything works:

```bash
# Remove migration backup
rm ~/migration-backup.txt

# Update other machines with same process
```

## Key Changes Summary

- **Shell Plugin Manager**: Prezto → Antidote
- **Prompt**: Spaceship → Starship  
- **Directory Jumping**: fasd → z (via antidote plugin)
- **Git Aliases**: Moved from bash-only to cross-shell in profile
- **Completions**: Auto-managed by antidote plugins vs manual Prezto setup
- **Claude Statusline**: Spaceship-style → Starship-style script