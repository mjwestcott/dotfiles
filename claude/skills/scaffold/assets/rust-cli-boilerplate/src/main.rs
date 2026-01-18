//! Entry point for the mycli application.

use anyhow::Result;
use clap::Parser;

fn main() -> Result<()> {
    mycli::run(mycli::cli::Cli::parse())
}
