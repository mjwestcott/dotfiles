//! Custom error types using thiserror.
//!
//! Use these error types in library code for precise error handling.
//! In application code (main.rs), use anyhow for convenience.

use thiserror::Error;

/// Errors that can occur in the mycli library.
#[derive(Debug, Error)]
pub enum MyCliError {
    /// Configuration error.
    #[error("Configuration error: {0}")]
    Config(String),

    /// Invalid argument provided.
    #[error("Invalid argument: {0}")]
    InvalidArgument(String),

    /// I/O error.
    #[error("I/O error: {0}")]
    Io(#[from] std::io::Error),

    /// Generic error with context.
    #[error("{context}: {source}")]
    WithContext {
        context: String,
        #[source]
        source: Box<dyn std::error::Error + Send + Sync>,
    },
}

impl MyCliError {
    /// Create an error with additional context.
    pub fn with_context<E>(context: impl Into<String>, source: E) -> Self
    where
        E: std::error::Error + Send + Sync + 'static,
    {
        Self::WithContext { context: context.into(), source: Box::new(source) }
    }
}
