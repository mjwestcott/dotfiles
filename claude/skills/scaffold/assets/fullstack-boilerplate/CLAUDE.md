# CLAUDE.md

## Philosophy

**Be autonomous.** Run tests after every change. Validate your own work. Add tests when you add features or fix bugs.
**Never assume code works without running it.**

## Quick Start

```bash
just dev        # Start all services (backend, frontend, postgres, redis)
just logs       # Tail logs
just test       # Run all tests
just lint       # Run all linters
```

## Code Style

### Ousterhout Principles

- **Deep modules**: Hide complexity behind simple interfaces. Abstractions must earn their keep.
- **No pass-through layers**: If a function just delegates to another, inline it.
- **Pull complexity down**: Handle edge cases in the implementation, not in every caller.
- **Consistency**: Similar things done similarly.

## Backend (Python)

Located in `backend/`.

### Stack

Python 3.12+, uv, ruff, pyright, FastAPI, Pydantic, SQLAlchemy 2.0+ (async), Alembic, PostgreSQL, Redis, structlog, pytest

### Standards

- `ruff check`, `ruff format`, `pyright` must pass
- Complete type hints on all functions
- Pydantic models for all request/response data
- All I/O is async; use `async with` for resource management
- Line length: 100 chars; Google-style docstrings on public functions
- Use `Annotated[T, Depends()]` for dependency injection

### Structure

```
backend/src/
├── api/        # FastAPI routes
├── models/     # SQLAlchemy models
├── schemas/    # Pydantic schemas
├── services/   # Business logic
├── config.py
├── database.py
└── main.py
```

## Frontend (TypeScript/React)

Located in `frontend/`.

### Stack

React 18+, Vite, TypeScript (strict), TanStack Query, shadcn/ui, Tailwind CSS, vitest, React Testing Library

### Standards

- `tsc --noEmit`, `eslint`, `prettier` must pass
- Use `@/` alias for all imports — no relative imports (`./` or `../`)

### File Naming

- Components: `PascalCase.tsx` (e.g., `UserCard.tsx`)
- Hooks: `use-kebab-case.ts` (e.g., `use-auth.ts`)
- Utilities: `kebab-case.ts`
- Tests: `*.test.tsx` colocated with source

### Structure

```
frontend/src/
├── components/    # Shared components
│   └── ui/        # shadcn/ui primitives
├── hooks/         # Custom hooks
├── lib/           # Utilities
├── pages/         # Page components
└── api/           # Generated OpenAPI client
```

### Patterns

- Named exports, props interface above component
- **Server state**: TanStack Query (`useQuery`, `useMutation`)
- **UI state**: `useState` for local; lift up when needed; Context sparingly
- Use `cn()` for conditional Tailwind classes
- Test user behavior with React Testing Library, not implementation details
- Semantic HTML; all interactive elements keyboard accessible; images need `alt`; inputs need labels

## Database

- Every table has `created_at`, `updated_at` (auto-managed)
- Soft deletes via `deleted_at`; use `model.soft_delete()`
- Queries automatically filter `WHERE deleted_at IS NULL`

## Development

| Service  | URL                        |
|----------|----------------------------|
| Frontend | http://localhost:5173      |
| Backend  | http://localhost:8000      |
| API Docs | http://localhost:8000/docs |

```bash
just db-migrate "msg"   # Create migration
just db-upgrade         # Apply migrations
just api-generate       # Regenerate frontend API client from OpenAPI
```

Copy `.env.example` to `.env`. Never commit `.env`.
