---
name: scaffold
description: Scaffold a new project from the fullstack or Rust CLI boilerplate. Use when starting a new codebase.
user_invocable: true
---

Scaffold a new project using my standard boilerplates.

## Available Boilerplates

### 1. Full-Stack (Python + React)

Located at [assets/fullstack-boilerplate/](assets/fullstack-boilerplate/).

**Stack:**
- Backend: Python 3.12+, FastAPI, SQLAlchemy (async), Alembic, uv, ruff, pyright, pytest
- Frontend: React, Vite, TypeScript, TanStack Query, shadcn/ui, Tailwind, vitest
- Infrastructure: Docker Compose, PostgreSQL, Redis, GitHub Actions CI

### 2. Rust CLI

Located at [assets/rust-cli-boilerplate/](assets/rust-cli-boilerplate/).

**Stack:**
- Rust 2024 edition, MSRV 1.85+
- clap (derive) — argument parsing with subcommands
- anyhow + thiserror — error handling (app + lib pattern)
- figment — layered config (file → env → CLI)
- indicatif + colored — progress bars and terminal colors
- tracing — structured logging
- GitHub Actions CI, pre-commit hooks

## Steps

1. **Ask what kind of project** (if not specified):
   - Full-stack (Python + React) — use fullstack-boilerplate
   - Backend-only — use only `backend/` from fullstack-boilerplate
   - Frontend-only — use only `frontend/` from fullstack-boilerplate
   - Rust CLI — use rust-cli-boilerplate

2. **Copy the boilerplate**: Copy the appropriate files from `assets/` to the project root

3. **Customize**:

   For Full-Stack:
   - Update project name in `package.json`, `pyproject.toml`, `README.md`
   - Adjust `docker-compose.yml` service names if needed
   - Remove example Item model/routes if not needed (or keep as reference)

   For Rust CLI:
   - Update project name in `Cargo.toml`, `README.md`
   - Rename binary if needed (update `[[bin]]` in `Cargo.toml`)
   - Adjust config paths in `config.rs` (defaults to `mycli`)

4. **Initialize**:

   For Full-Stack:
   - `git init` (if not already a repo)
   - Create initial migration: `just db-migrate "initial"`

   For Rust CLI:
   - `git init` (if not already a repo)
   - `cargo build` to verify setup

5. **Verify it works**:

   For Full-Stack:
   - Run `just setup` to build and start services
   - Check http://localhost:5173 (frontend) and http://localhost:8000/docs (API)

   For Rust CLI:
   - Run `just check` (fmt + clippy + test)
   - Run `cargo run -- --help` to see CLI help
   - Run `cargo run -- example` to test example subcommand

## Notes

- Both boilerplates are working starting points—everything should run out of the box
- Adapt as needed for the specific project
- For hackathons: keep the example code as patterns to copy from
