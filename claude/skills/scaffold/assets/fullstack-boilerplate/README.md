# Project Name

> Brief description of what this project does.

## Quick Start

```bash
# Initial setup
just setup

# Start development
just dev

# View logs
just logs
```

## Development

### Prerequisites

- Docker & Docker Compose
- [just](https://github.com/casey/just) command runner

### Available Commands

Run `just` to see all available commands.

**Development:**
- `just dev` - Start all services
- `just down` - Stop all services
- `just logs` - Tail all logs

**Testing:**
- `just test` - Run all tests
- `just test-backend` - Backend tests only
- `just test-frontend` - Frontend tests only

**Linting:**
- `just lint` - Run all linters
- `just typecheck` - Run all type checkers

**Database:**
- `just db-migrate "description"` - Create migration
- `just db-upgrade` - Apply migrations
- `just db-downgrade` - Rollback migration

### Services

| Service  | URL                          |
|----------|------------------------------|
| Frontend | http://localhost:5173        |
| Backend  | http://localhost:8000        |
| API Docs | http://localhost:8000/docs   |
| Postgres | localhost:5432               |
| Redis    | localhost:6379               |

### Environment Variables

Copy `.env.example` to `.env` and configure as needed.

## Architecture

```
├── backend/          # FastAPI backend
│   ├── src/
│   │   ├── api/      # Route handlers
│   │   ├── models/   # SQLAlchemy models
│   │   ├── schemas/  # Pydantic schemas
│   │   └── services/ # Business logic
│   ├── alembic/      # Database migrations
│   └── tests/
├── frontend/         # React frontend
│   └── src/
│       ├── components/
│       ├── pages/
│       └── lib/
└── docker-compose.yml
```
