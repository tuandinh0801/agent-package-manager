# OpenSpec Workflow

OpenSpec provides a structured approach to feature development that ensures thorough design before implementation.

## Overview

```
explore → propose → apply → archive
```

Each stage produces artifacts that feed the next, creating a traceable path from idea to implementation.

## Stage 1: Explore (`/opsx:explore`)

Use when you need to think through a problem before committing to a solution.

**What it does:**
- Acts as a thinking partner
- Helps investigate problems
- Clarifies requirements
- Surfaces edge cases

**Example:**
```
> /opsx:explore
"We need to add rate limiting to our API. Not sure if we should do it at
the gateway level, middleware level, or per-endpoint."
```

The skill will help you explore tradeoffs, ask clarifying questions, and converge on an approach.

## Stage 2: Propose (`/opsx:propose`)

Creates a full change proposal with all artifacts needed for implementation.

**What it produces:**
- `proposal.md` — What and why (problem statement, goals, non-goals)
- `design.md` — How (architecture, data flow, API contracts)
- `tasks.md` — Implementation steps (ordered, testable)

**Example:**
```
> /opsx:propose
"Add JWT-based authentication with refresh tokens"
```

This creates `openspec/changes/add-jwt-auth/` with all three artifacts.

**Tips:**
- Be specific about what you want to build
- The skill will ask clarifying questions if needed
- Review the generated artifacts before proceeding

## Stage 3: Apply (`/opsx:apply`)

Implements tasks from the proposal using TDD methodology.

**How it works:**
1. Reads `tasks.md` for the work breakdown
2. For each task:
   - Writes tests first (RED)
   - Implements minimal code (GREEN)
   - Refactors (IMPROVE)
3. Uses subagents for parallel independent tasks
4. Runs code quality review after each task

**Example:**
```
> /opsx:apply
# If multiple changes exist, it asks which one to implement
# Then works through tasks sequentially
```

**Key behaviors:**
- Won't skip tests
- Asks for clarification on ambiguous tasks
- Creates new tasks if it discovers missing work
- Reports progress via todo list

## Stage 4: Archive (`/opsx:archive`)

Finalizes a completed change.

**What it does:**
- Verifies all tasks are complete
- Moves the change to `openspec/archive/`
- Cleans up working artifacts

```
> /opsx:archive
```

## Full Example: Adding Search

```bash
# 1. Explore
> /opsx:explore
"Users want full-text search across documents. We have PostgreSQL.
Should we use pg_trgm, tsvector, or an external service like Typesense?"

# (Discussion happens, converge on tsvector with pg_trgm fallback)

# 2. Propose
> /opsx:propose
"Add full-text search using PostgreSQL tsvector with pg_trgm for fuzzy matching"

# Creates:
# openspec/changes/add-fulltext-search/
#   proposal.md  - Goals, non-goals, success criteria
#   design.md    - Schema changes, query patterns, indexing strategy
#   tasks.md     - 6 implementation tasks

# 3. Implement
> /opsx:apply
# Task 1: Add tsvector column migration
# Task 2: Create search index
# Task 3: Implement search query builder
# Task 4: Add search API endpoint
# Task 5: Integration tests
# Task 6: Performance benchmarks

# 4. Archive
> /opsx:archive
```

## Prerequisites

- Install openspec CLI: `npm install -g openspec`
- The CLI manages the `openspec/` directory structure
- Changes live in `openspec/changes/<name>/` until archived

## Tips

- **Start with explore** if you're unsure about the approach
- **Skip to propose** if requirements are already clear
- **Review artifacts** before applying — editing `tasks.md` is cheaper than re-implementing
- **One change at a time** — complete and archive before starting the next
