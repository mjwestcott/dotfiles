//! Integration tests for the mycli CLI.

use assert_cmd::Command;
use predicates::prelude::*;

#[allow(deprecated)]
fn mycli() -> Command {
    Command::cargo_bin("mycli").unwrap()
}

#[test]
fn test_help() {
    mycli()
        .arg("--help")
        .assert()
        .success()
        .stdout(predicate::str::contains("A Rust CLI boilerplate"));
}

#[test]
fn test_version() {
    mycli().arg("--version").assert().success().stdout(predicate::str::contains("mycli"));
}

#[test]
fn test_example_default() {
    mycli().arg("example").assert().success().stdout(predicate::str::contains("Hello, World!"));
}

#[test]
fn test_example_with_name() {
    mycli()
        .args(["example", "Rust"])
        .assert()
        .success()
        .stdout(predicate::str::contains("Hello, Rust!"));
}

#[test]
fn test_example_with_count() {
    mycli()
        .args(["example", "--count", "3"])
        .assert()
        .success()
        .stdout(predicate::str::contains("[1/3]"))
        .stdout(predicate::str::contains("[2/3]"))
        .stdout(predicate::str::contains("[3/3]"));
}

#[test]
fn test_example_help() {
    mycli()
        .args(["example", "--help"])
        .assert()
        .success()
        .stdout(predicate::str::contains("Name to greet"));
}

#[test]
fn test_verbose_flag() {
    mycli().args(["--verbose", "example"]).assert().success();
}

#[test]
fn test_missing_subcommand() {
    mycli().assert().failure().stderr(predicate::str::contains("Usage:"));
}
