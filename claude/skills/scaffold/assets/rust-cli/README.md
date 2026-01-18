# mycli

A Rust CLI boilerplate demonstrating best practices for building command-line applications.

## Features

- **Argument Parsing**: clap with derive macros and subcommands
- **Error Handling**: anyhow (app) + thiserror (lib) pattern
- **Configuration**: Layered config with figment (file → env → CLI)
- **Logging**: Structured logging with tracing
- **Progress**: Terminal progress bars with indicatif
- **Colors**: Colored output with colored

## Quick Start

```bash
# Build
cargo build

# Run
cargo run -- --help
cargo run -- example --name "Rust" --count 3
cargo run -- example --progress --count 10

# Install
cargo install --path .
mycli --help
```

## Configuration

Create `~/.config/mycli/config.toml`:

```toml
greeting_prefix = "Hello"
use_colors = true
log_level = "info"
```

Or use environment variables:

```bash
export MYCLI_GREETING_PREFIX="Hi"
export MYCLI_USE_COLORS="false"
```

## Development

```bash
# Run all checks
just check

# Individual commands
just fmt        # Format code
just lint       # Run clippy
just test       # Run tests
just doc        # Generate docs

# Build release
just release
```

## Project Structure

```
src/
├── main.rs           # Entry point
├── lib.rs            # Library root
├── cli.rs            # CLI definitions
├── commands/         # Subcommand implementations
├── config.rs         # Configuration
└── error.rs          # Custom errors
```

## License

MIT
