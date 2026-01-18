# CLAUDE.md

This file provides guidance to Claude Code when working with this codebase.

## Philosophy

**Be autonomous.** Run commands to understand the codebase, then implement solutions. Don't ask for permission—just do the work.

**Verify your changes.** Always run `just check` (or `cargo fmt && cargo clippy && cargo test`) before considering a task complete.

**Keep it simple.** Follow Ousterhout's principles: deep modules with simple interfaces, minimize cognitive load, design for the common case.

## Quick Start

```bash
# Build the project
just build

# Run the CLI
just run -- --help
just run -- example --name World --count 3

# Run all checks (format, lint, test)
just check

# Individual checks
just fmt        # Format code
just lint       # Run clippy
just test       # Run tests

# Install locally
just install
```

## Project Structure

```
src/
├── main.rs           # Entry point, minimal - just parses CLI and calls lib
├── lib.rs            # Library root, initializes tracing and dispatches commands
├── cli.rs            # Clap structs and subcommands
├── commands/
│   ├── mod.rs        # Command module exports
│   └── example.rs    # Example subcommand implementation
├── config.rs         # Figment-based config loading
└── error.rs          # Custom error types with thiserror
```

## Adding a New Command

1. Create `src/commands/newcmd.rs` with a `run()` function
2. Add `pub mod newcmd;` to `src/commands/mod.rs`
3. Add variant to `Command` enum in `src/cli.rs`
4. Add match arm in `src/lib.rs`

## Error Handling

- **Library code** (`src/*.rs` except `main.rs`): Use `thiserror` via `crate::error::MyCliError`
- **Application code** (`main.rs`): Use `anyhow::Result` for convenience
- All public functions should return `Result<T, E>` where appropriate

## Configuration

Config is loaded via Figment in order of precedence:
1. Default values (in `Config::default()`)
2. Config file (`~/.config/mycli/config.toml`)
3. Environment variables (`MYCLI_*`)

## Coding Standards

- `cargo fmt` must pass (100 char line width)
- `cargo clippy --all-targets -- -D warnings` must pass
- `cargo test` must pass
- All public functions must have doc comments
- Use `tracing` macros for logging, not `println!` for debug output

## Dependencies

| Crate | Purpose |
|-------|---------|
| clap | CLI argument parsing with derive macros |
| anyhow | Application-level error handling |
| thiserror | Custom error types for library code |
| figment | Layered configuration (file, env, defaults) |
| indicatif | Progress bars and spinners |
| colored | Terminal colors |
| tracing | Structured logging |
| directories | Platform-specific config paths |
| serde | Serialization for config |
