# Homebrew Bundle file for dotfiles environment
# Run with: brew bundle

# Taps. These are intentional third-party sources: core's `goku` is an
# unrelated load tester, and its MinIO formula is deprecated.
tap "minio/stable"
tap "yqrashawn/goku"

# Core tools
brew "bash"
brew "coreutils"
brew "git"
brew "gnupg"
brew "openssl"
brew "wget"
brew "zsh"

# Search and file tools
brew "ripgrep"                    # Modern grep replacement
brew "fd"                         # Modern find replacement
brew "fzf"                        # Fuzzy finder
brew "eza"                        # Modern ls replacement
brew "bat"                        # Cat with syntax highlighting
brew "broot"                      # Tree-based file browser
brew "ranger"                     # File browser
brew "highlight"                  # Syntax highlighting
brew "hexyl"                      # Hex viewer

# Development tools
brew "cmake"
brew "ctags"
brew "shellcheck"                 # Shell script linter
brew "shfmt"                      # Shell script formatter
brew "tokei"                      # Fast code statistics
brew "jq"                         # JSON processor
brew "yq"                         # YAML processor
brew "just"                       # Modern task runner
brew "hyperfine"                  # Benchmarking tool
brew "tldr"                       # Simplified man pages
brew "ccusage"                    # Claude Code usage tracker

# Editors
brew "neovim"

# Terminal and shell
cask "ghostty"                    # GPU-accelerated terminal
brew "tmux"
brew "starship"                   # Cross-shell prompt
brew "zoxide"                     # Smarter cd

# Cloud and containers
brew "awscli"
brew "terraform"
brew "sops"                       # Encrypted file editor
brew "lazydocker"                 # Docker TUI
brew "dive"                       # Docker image explorer

# Kubernetes
cask "docker-desktop"
brew "helm"
brew "kind"
brew "k3d"
brew "k9s"
brew "kubectl"
brew "kubectx"

# Languages and package managers
brew "go"
brew "node"
brew "yarn"
brew "pnpm"
brew "python"
brew "pipx"
brew "uv"                         # Fast Python package installer and resolver
brew "ruff"                       # Fast Python linter/formatter

# Databases
brew "postgresql@18"              # Unversioned `postgresql` is deprecated
brew "redis"
brew "sqlite"
brew "litecli"                    # SQLite CLI with autocomplete
brew "pgcli"                      # PostgreSQL CLI with autocomplete

# Data tools
brew "graphviz"

# HTTP tools
brew "httpie"
brew "websocat"                   # WebSocket client

# Git tools
brew "gh"                         # GitHub CLI (official)
cask "gitify"                     # GitHub notifications
brew "delta"                      # Better git diffs with syntax highlighting

# Monitoring
brew "bottom"                     # Modern system monitor
brew "procs"                      # Modern ps replacement
brew "dust"                       # Modern du replacement

# Media tools
brew "yt-dlp"                     # youtube-dl fork (actively maintained)
brew "exiftool"

# Other tools
brew "pre-commit"                 # Git hooks framework
brew "stylua"                     # Lua formatter
brew "biome"                      # JavaScript/TypeScript formatter
brew "prettier"                   # Markdown/YAML formatter

# Custom taps (explicitly trusted by the install script before brew bundle).
brew "minio/stable/minio"         # Object storage
brew "minio/stable/mc"            # MinIO client
brew "yqrashawn/goku/goku"        # Karabiner configurator
