# Agent Package Manager

Shared AI development environment — coding standards, security rules, workflow skills, and plugins managed as a single installable package.

## Setup

### Prerequisites

- [APM CLI](https://microsoft.github.io/apm/getting-started/quick-start/) installed
- Claude Code, Copilot, Cursor, or any supported agent

### Install

**Option A: Per-project** (adds to your project's `apm.yml`)

```bash
apm install tuandinh0801/agent-package-manager
```

**Option B: Global** (available across all your projects)

```bash
apm install -g tuandinh0801/agent-package-manager
```

That's it. APM fetches the package, resolves all plugin dependencies, and deploys skills/rules/instructions into your agent's config directory automatically.

## What's Included

| Directory | Contents | Details |
|-----------|----------|---------|
| `skills/` | 14 custom skills (OpenSpec, GitNexus, utilities) | [skills/README.md](skills/) |
| `rules/` | 15 hookify security rules (block + warn) | [rules/README.md](rules/) |
| `instructions/` | 8 coding standards (common, Python, TypeScript) | [instructions/README.md](instructions/) |
| `docs/` | Workflow guides and plugin reference | [docs/](docs/) |

### Plugin Dependencies (via apm.yml)

| Package | Purpose |
|---------|---------|
| [caveman](https://github.com/JuliusBrussee/caveman) #v1.6.0 | Token-compressed communication (~75% savings) |
| [superpowers](https://github.com/obra/superpowers) | TDD, debugging, brainstorming workflows |
| [hookify-plus](https://github.com/tuandinh0801/hookify-plus) | Security rule enforcement engine |
| [impeccable](https://github.com/pbakaus/impeccable) | UI/UX design polish and critique |
| [anthropics/skills](https://github.com/anthropics/skills) | Document generation (PDF, PPTX, DOCX, XLSX) |
| [claude-mem](https://github.com/thedotmack/claude-mem) | Persistent cross-session memory |


### Optional Dependencies

Some skills require external tools:

| Tool | Required For | Install |
|------|-------------|---------|
| [openspec](https://github.com/openspec-dev/openspec) | OpenSpec workflow skills | `npm install -g openspec` |
| GitNexus MCP | GitNexus code intelligence | Configure in agent MCP settings |
| [RTK](https://github.com/nicolo-ribaudo/rtk) | Token optimization | `cargo install rtk` |

### Useful Commands

```bash
# Install for a specific agent only
apm install --target claude
apm install --target copilot
apm install --target opencode

# Install only a specific skill from this package
apm install tuandinh0801/agent-package-manager --skill openspec-propose

# Update to latest version
apm install --update

# Preview what will be installed (no changes)
apm install --dry-run

# Uninstall
apm uninstall tuandinh0801/agent-package-manager

# List installed dependencies
apm deps list

# Security audit (checks for hidden unicode, lockfile drift)
apm audit

# Compile instructions into agent-native format (optional for Claude/Copilot)
apm compile --target claude    # → CLAUDE.md + .claude/
apm compile --target copilot   # → AGENTS.md + .github/
apm compile --target opencode  # → AGENTS.md + .opencode/
apm compile --target all       # → all formats
```

## Contributing

### Adding a Skill

```bash
mkdir skills/my-skill
```

Create `skills/my-skill/SKILL.md`:

```markdown
---
name: my-skill
description: What this skill does and when to trigger it
---

Instructions for the AI agent when this skill is invoked...
```

Supporting files (references, templates, scripts) go in the same directory.

### Adding a Security Rule

Create `rules/my-rule.md`:

```markdown
---
name: my-rule
enabled: true
event: bash        # bash | file
action: block      # block | warn
pattern: "regex pattern here"
---

**Blocked/Warning: Explanation**

Why this is dangerous and what to do instead.
```

### Adding an Instruction

Create `instructions/my-standard.instructions.md`:

```markdown
---
description: One-line description of this coding standard
applyTo: "**/*"    # or "**/*.py", "**/*.ts,**/*.tsx"
---

# Title

Your coding standards here...
```

### Validation

```bash
apm compile --validate    # Check all primitives are valid
apm compile --dry-run     # Preview what gets generated
```

### Commit Convention

```
<type>: <description>

Types: feat, fix, refactor, docs, test, chore
```

### PR Checklist

- [ ] `apm compile --validate` passes
- [ ] New skills have clear `description` in frontmatter
- [ ] New rules explain WHY the pattern is dangerous
- [ ] New instructions have `description` and `applyTo` fields

## Project Structure

```
.
├── apm.yml              # Package manifest (dependencies, config)
├── skills/              # Custom skills (SKILL.md format)
├── rules/               # Hookify security rules
├── instructions/        # Coding standard files (.instructions.md)
└── docs/                # Workflow guides, plugin reference
```

## License

MIT
