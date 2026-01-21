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
        find . -name "*.py" -not -path "./tools/*" -not -path "./backup/*" | xargs -r ruff check
    else
        echo "ruff not found - install with: brew install ruff"
    fi

# Lint JavaScript/TypeScript files with eslint
lint-js:
    #!/usr/bin/env bash
    echo "Linting JavaScript/TypeScript files..."
    if command -v eslint >/dev/null 2>&1; then
        find . -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" | \
        grep -v node_modules | grep -v tools | grep -v backup | xargs -r eslint
    else
        echo "eslint not found - install with: npm install -g eslint"
    fi

# Lint shell scripts with shellcheck
lint-shell:
    #!/usr/bin/env bash
    echo "Linting shell scripts..."
    if command -v shellcheck >/dev/null 2>&1; then
        find . -name "*.sh" -o -name "*.bash" | \
        grep -v tools | grep -v backup | xargs -r shellcheck -x -e SC1090,SC1091
        shellcheck -x -e SC1090,SC1091 shell/profile shell/zsh/* install 2>/dev/null || true
        find . -name "*.zsh" | grep -v tools | grep -v backup | grep -v antidote | xargs -r shellcheck -s bash -x -e SC1090,SC1091 2>/dev/null || true
    else
        echo "shellcheck not found - install with: brew install shellcheck"
    fi

# Check markdown files with markdownlint
lint-markdown:
    #!/usr/bin/env bash
    echo "Checking markdown files..."
    if command -v markdownlint >/dev/null 2>&1; then
        find . -name "*.md" -not -path "./tools/*" -not -path "./backup/*" | xargs -r markdownlint
    else
        echo "markdownlint not found - install with: npm install -g markdownlint-cli"
    fi
