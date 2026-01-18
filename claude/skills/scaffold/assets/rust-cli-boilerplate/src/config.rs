//! Configuration management using figment.
//!
//! Configuration is loaded from multiple sources in order of precedence:
//! 1. Default values
//! 2. Config file (~/.config/mycli/config.toml)
//! 3. Environment variables (prefixed with MYCLI_)

use anyhow::{Context, Result};
use directories::ProjectDirs;
use figment::{
    Figment,
    providers::{Env, Format, Serialized, Toml},
};
use serde::{Deserialize, Serialize};
use std::path::PathBuf;

/// Application configuration.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Config {
    /// Default greeting prefix.
    pub greeting_prefix: String,

    /// Whether to use colors in output.
    pub use_colors: bool,

    /// Log level (trace, debug, info, warn, error).
    pub log_level: String,
}

impl Default for Config {
    fn default() -> Self {
        Self {
            greeting_prefix: "Hello".to_string(),
            use_colors: true,
            log_level: "info".to_string(),
        }
    }
}

impl Config {
    /// Load configuration from all sources.
    pub fn load() -> Result<Self> {
        let mut figment = Figment::new().merge(Serialized::defaults(Config::default()));

        // Add config file if it exists
        if let Some(config_path) = Self::config_path() {
            if config_path.exists() {
                figment = figment.merge(Toml::file(&config_path));
            }
        }

        // Add environment variables with MYCLI_ prefix
        figment = figment.merge(Env::prefixed("MYCLI_").split("_"));

        figment.extract().context("Failed to load configuration")
    }

    /// Get the path to the config file.
    pub fn config_path() -> Option<PathBuf> {
        ProjectDirs::from("", "", "mycli").map(|dirs| dirs.config_dir().join("config.toml"))
    }

    /// Get the path to the config directory.
    pub fn config_dir() -> Option<PathBuf> {
        ProjectDirs::from("", "", "mycli").map(|dirs| dirs.config_dir().to_path_buf())
    }
}
