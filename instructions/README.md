# Coding Instructions

8 instruction files that define coding standards applied automatically based on file patterns.

## Common (apply to all files)

| Instruction | Key Rules |
|-------------|-----------|
| `coding-style` | Immutability, <800 line files, <50 line functions, no deep nesting |
| `security` | No hardcoded secrets, parameterized queries, XSS/CSRF prevention |
| `testing` | 80% coverage minimum, TDD mandatory (RED→GREEN→REFACTOR) |
| `git-workflow` | Conventional commits: `feat:`, `fix:`, `refactor:`, `docs:`, etc. |
| `patterns` | Repository pattern, API response envelope, skeleton projects |
| `hooks` | TodoWrite for progress tracking on multi-step tasks |

## Language-Specific

| Instruction | Applies To | Key Rules |
|-------------|------------|-----------|
| `python-coding-style` | `**/*.py` | PEP 8, type annotations, frozen dataclasses, black/ruff |
| `typescript-coding-style` | `**/*.ts,**/*.tsx,**/*.js,**/*.jsx` | Strict types, no `any`, Zod validation, React prop interfaces |

## How Instructions Work

APM compiles these into agent-native formats based on target:
- **Claude** → merged into CLAUDE.md or .claude/ rules
- **Copilot** → merged into AGENTS.md or .github/instructions/
- **Cursor** → merged into .cursor/ rules

The `applyTo` glob determines which files trigger the instruction.

## Adding a New Instruction

Create `instructions/my-standard.instructions.md`:

```markdown
---
description: One-line summary (used for discovery and relevance ranking)
applyTo: "**/*"
---

# Title

Your coding standards in markdown...
```

**Fields:**
- `description` (required) — short summary
- `applyTo` (required) — glob pattern as string (e.g. `"**/*.py"`, `"**/*"`)

For multiple file patterns, comma-separate: `"**/*.ts,**/*.tsx,**/*.js"`
