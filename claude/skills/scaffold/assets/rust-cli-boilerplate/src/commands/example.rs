//! Example subcommand implementation.

use anyhow::Result;
use colored::Colorize;
use indicatif::{ProgressBar, ProgressStyle};
use std::{thread, time::Duration};

use crate::cli::ExampleArgs;
use crate::config::Config;

/// Run the example subcommand.
pub fn run(args: ExampleArgs, config: &Config) -> Result<()> {
    tracing::info!(name = %args.name, count = args.count, "Running example command");

    if args.progress {
        run_with_progress(&args, config)?;
    } else {
        run_simple(&args, config)?;
    }

    Ok(())
}

fn run_simple(args: &ExampleArgs, config: &Config) -> Result<()> {
    for i in 1..=args.count {
        let greeting = format!("{}, {}!", config.greeting_prefix, args.name);
        let output = if config.use_colors {
            format!("[{}/{}] {}", i, args.count, greeting.green().bold())
        } else {
            format!("[{}/{}] {}", i, args.count, greeting)
        };
        println!("{output}");
    }
    Ok(())
}

fn run_with_progress(args: &ExampleArgs, config: &Config) -> Result<()> {
    let pb = ProgressBar::new(args.count as u64);
    pb.set_style(
        ProgressStyle::default_bar()
            .template(
                "{spinner:.green} [{elapsed_precise}] [{bar:40.cyan/blue}] {pos}/{len} {msg}",
            )?
            .progress_chars("#>-"),
    );

    for i in 1..=args.count {
        let greeting = format!("{}, {}!", config.greeting_prefix, args.name);
        pb.set_message(greeting.clone());
        pb.inc(1);

        // Simulate some work
        thread::sleep(Duration::from_millis(100));

        tracing::debug!(iteration = i, greeting, "Completed iteration");
    }

    pb.finish_with_message("Done!");
    Ok(())
}
