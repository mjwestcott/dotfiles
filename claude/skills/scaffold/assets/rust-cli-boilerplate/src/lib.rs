//! mycli - A Rust CLI boilerplate demonstrating best practices.
//!
//! This library provides the core functionality for the mycli application,
//! including configuration management, error handling, and command implementations.

pub mod cli;
pub mod commands;
pub mod config;
pub mod error;

use anyhow::Result;
use tracing_subscriber::{EnvFilter, layer::SubscriberExt, util::SubscriberInitExt};

use cli::{Cli, Command};
use config::Config;

/// Initialize the tracing subscriber for structured logging.
fn init_tracing(verbose: bool) {
    let filter = if verbose {
        EnvFilter::try_from_default_env().unwrap_or_else(|_| EnvFilter::new("debug"))
    } else {
        EnvFilter::try_from_default_env().unwrap_or_else(|_| EnvFilter::new("info"))
    };

    tracing_subscriber::registry()
        .with(filter)
        .with(tracing_subscriber::fmt::layer().with_target(false))
        .init();
}

/// Run the CLI application with the parsed arguments.
pub fn run(cli: Cli) -> Result<()> {
    init_tracing(cli.verbose);

    let config = Config::load()?;
    tracing::debug!(?config, "Loaded configuration");

    match cli.command {
        Command::Example(args) => commands::example::run(args, &config),
    }
}
