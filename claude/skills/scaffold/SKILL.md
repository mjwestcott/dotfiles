---
name: scaffold
description: Scaffold a new project from the python-react boilerplate. Use when starting a new full-stack codebase.
user_invocable: true
---

Scaffold a new project using my standard boilerplate.

## Boilerplate

The full working boilerplate is at [assets/python-react-boilerplate/](assets/python-react-boilerplate/).

**Stack:**
- Backend: Python 3.12+, FastAPI, SQLAlchemy (async), Alembic, uv, ruff, pytest
- Frontend: React, Vite, TypeScript, TanStack Query, shadcn/ui, Tailwind, vitest
- Infrastructure: Docker Compose, PostgreSQL, Redis, GitHub Actions CI

## Steps

1. **Ask what kind of project** (if not specified):
   - Full-stack (Python + React) — use the full boilerplate
   - Backend-only — use only `backend/` and root configs
   - Frontend-only — use only `frontend/` and adapt root configs

2. **Copy the boilerplate**: Copy the appropriate files from `assets/python-react-boilerplate/` to the project root

3. **Customize**:
   - Update project name in `package.json`, `pyproject.toml`, `README.md`
   - Adjust `docker-compose.yml` service names if needed
   - Remove example Item model/routes if not needed (or keep as reference)

4. **Initialize**:
   - `git init` (if not already a repo)
   - Create initial migration: `just db-migrate "initial"`

5. **Verify it works**:
   - Run `just setup` to build and start services
   - Check http://localhost:5173 (frontend) and http://localhost:8000/docs (API)

## Notes

- The boilerplate is a working starting point—everything should run out of the box
- Adapt as needed for the specific project
- For hackathons: keep the example code as patterns to copy from
