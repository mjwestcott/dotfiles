.PHONY: test lint lint-python lint-js lint-shell lint-markdown help

# Default target
help:
	@echo "Available targets:"
	@echo "  test          - Run shell configuration tests"
	@echo "  lint          - Run all linters"
	@echo "  lint-python   - Lint Python files with ruff"
	@echo "  lint-js       - Lint JavaScript/TypeScript files with eslint"
	@echo "  lint-shell    - Lint shell scripts with shellcheck"
	@echo "  lint-markdown - Check markdown files with markdownlint (if available)"
	@echo "  help          - Show this help message"

# Run shell configuration tests
test:
	@echo "Running shell configuration tests..."
	@./tests/shell.sh

# Run all linters
lint: lint-python lint-js lint-shell lint-markdown
	@echo "All linting completed!"

# Lint Python files
lint-python:
	@echo "Linting Python files..."
	@if command -v ruff >/dev/null 2>&1; then \
		find . -name "*.py" -not -path "./tools/*" -not -path "./backup/*" | xargs -r ruff check; \
	else \
		echo "ruff not found - install with: brew install ruff"; \
	fi

# Lint JavaScript/TypeScript files
lint-js:
	@echo "Linting JavaScript/TypeScript files..."
	@if command -v eslint >/dev/null 2>&1; then \
		find . -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" | \
		grep -v node_modules | grep -v tools | grep -v backup | xargs -r eslint; \
	else \
		echo "eslint not found - install with: npm install -g eslint"; \
	fi

# Lint shell scripts
lint-shell:
	@echo "Linting shell scripts..."
	@if command -v shellcheck >/dev/null 2>&1; then \
		find . -name "*.sh" -o -name "*.bash" | \
		grep -v tools | grep -v backup | xargs -r shellcheck -x -e SC1090,SC1091; \
		shellcheck -x -e SC1090,SC1091 shell/profile shell/zsh/* install 2>/dev/null || true; \
		find . -name "*.zsh" | grep -v tools | grep -v backup | grep -v antidote | xargs -r shellcheck -s bash -x -e SC1090,SC1091 2>/dev/null || true; \
	else \
		echo "shellcheck not found - install with: brew install shellcheck"; \
	fi

# Lint markdown files
lint-markdown:
	@echo "Checking markdown files..."
	@if command -v markdownlint >/dev/null 2>&1; then \
		find . -name "*.md" -not -path "./tools/*" -not -path "./backup/*" | xargs -r markdownlint; \
	else \
		echo "markdownlint not found - install with: npm install -g markdownlint-cli"; \
	fi
