# Default recipe - show help
default:
    @just --list

# Install/update dotfiles (idempotent)
install:
    ./install

# Alias for install
update: install

# Run all tests
test: test-shell test-claude-hooks
    @echo "All tests passed!"

# Run shell configuration tests
test-shell:
    @echo "Running shell configuration tests..."
    ./tests/shell.sh

# Run Claude hooks tests
test-claude-hooks:
    @echo "Running Claude hooks tests..."
    ./tests/claude-hooks.sh

# Run all linters
lint: lint-python lint-js lint-shell lint-markdown
    @echo "All linting completed!"

# Lint Python files with ruff
lint-python:
    #!/usr/bin/env bash
    echo "Linting Python files..."
    if command -v ruff >/dev/null 2>&1; then
        # ranger/zenburn.py is an upstream theme kept byte-for-byte for easy
        # replacement; lint first-party Python only.
        find . -name "*.py" -not -path "./tools/*" -not -path "./backup/*" -not -path "./ranger/*" | xargs -r ruff check
    else
        echo "ruff not found - install with: brew install ruff"
    fi

# Lint and format-check JavaScript/TypeScript/JSON/CSS files with Biome
lint-js:
    #!/usr/bin/env bash
    echo "Linting JavaScript/TypeScript files..."
    if command -v biome >/dev/null 2>&1; then
        biome check .
    else
        echo "biome not found - install with: brew install biome"
    fi

# Lint shell scripts with shellcheck
lint-shell:
    #!/usr/bin/env bash
    echo "Linting shell scripts..."
    if command -v shellcheck >/dev/null 2>&1; then
        find . -name "*.sh" -o -name "*.bash" | \
        grep -v tools | grep -v backup | xargs -r shellcheck -x -e SC1090,SC1091
        shellcheck -x -e SC1090,SC1091 shell/profile shell/zsh/* install
        find . -name "*.zsh" | grep -v tools | grep -v backup | grep -v antidote | xargs -r shellcheck -s bash -x -e SC1090,SC1091
    else
        echo "shellcheck not found - install with: brew install shellcheck"
    fi

# Check markdown files with markdownlint
lint-markdown:
    #!/usr/bin/env bash
    echo "Checking markdown files..."
    if command -v markdownlint >/dev/null 2>&1; then
        find . -name "*.md" -not -path "./tools/*" -not -path "./backup/*" | xargs -r markdownlint
    elif command -v prettier >/dev/null 2>&1; then
        find . -name "*.md" -not -path "./tools/*" -not -path "./backup/*" -print0 | xargs -0 prettier --check
    else
        echo "Neither markdownlint nor prettier found - install with: brew install prettier"
    fi
