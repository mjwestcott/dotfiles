//! Command-line interface definitions using clap.

use clap::{Parser, Subcommand};

/// A Rust CLI boilerplate demonstrating best practices.
#[derive(Debug, Parser)]
#[command(name = "mycli")]
#[command(version, about, long_about = None)]
pub struct Cli {
    /// Enable verbose output (debug logging).
    #[arg(short, long, global = true)]
    pub verbose: bool,

    /// Path to config file (default: ~/.config/mycli/config.toml).
    #[arg(short, long, global = true, env = "MYCLI_CONFIG")]
    pub config: Option<std::path::PathBuf>,

    #[command(subcommand)]
    pub command: Command,
}

/// Available subcommands.
#[derive(Debug, Subcommand)]
pub enum Command {
    /// Run the example subcommand.
    Example(ExampleArgs),
}

/// Arguments for the example subcommand.
#[derive(Debug, clap::Args)]
pub struct ExampleArgs {
    /// Name to greet.
    #[arg(default_value = "World")]
    pub name: String,

    /// Number of times to greet.
    #[arg(short = 'n', long, default_value = "1")]
    pub count: u32,

    /// Show a progress bar.
    #[arg(short, long)]
    pub progress: bool,
}
