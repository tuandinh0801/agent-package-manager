# Agent Package Manager

Shared AI development environment — coding standards, security rules, workflow skills, and plugins managed as a single installable package.

## Setup

### Prerequisites

- [APM CLI](https://microsoft.github.io/apm/getting-started/quick-start/) installed
- Any coding agent (Claude, Copilot, OpenCode, etc.)
- Git (to clone this repo)

### Install

```bash
# Clone the repo
git clone https://github.com/tuandinh0801/agent-package-manager.git
cd agent-package-manager

# Install globally (available across all projects)
apm install -g

# Claude code ONLY - Deploy security rules
apm run deploy-rules-global
```

This installs all plugin dependencies, deploys skills/instructions into `~/.claude/`, and activates 15 hookify security rules globally.

### Per-project Install

```bash
apm install tuandinh0801/agent-package-manager
apm run deploy-rules
```

### Security Rules

15 hookify rules that block or warn on dangerous operations. Requires [hookify-plus](https://github.com/tuandinh0801/hookify-plus) (installed automatically as dependency).

**Blocking (9):** force push, `rm -rf ~`, git destructive ops, code injection, credential dir access, hardcoded secrets, npm destructive, `.env` file access.

**Warning (6):** git config changes, shell history exposure, home dir ops, network exfiltration, sensitive file access, unicode injection.

Rules are deployed to `~/.claude/` (global) or `.claude/` (project) as `hookify.*.local.md` files.

## What's Included

| Directory            | Contents | Details |
|----------------------|----------|---------|
| `skills/`            | 14 custom skills (OpenSpec, GitNexus, utilities) | [skills/README.md](skills/) |
| `rules/`             | 15 hookify security rules (block + warn) | [rules/README.md](rules/) |
| `.apm/instructions/` | 11 coding standards (common, Python, TypeScript) | [instructions/README.md](instructions/) |
| `docs/`              | Workflow guides and plugin reference | [docs/](docs/) |

### Plugin Dependencies (via apm.yml)

| Package | Purpose |
|---------|---------|
| [caveman](https://github.com/JuliusBrussee/caveman) #v1.6.0 | Token-compressed communication (~75% savings) |
| [superpowers](https://github.com/obra/superpowers) | TDD, debugging, brainstorming workflows |
| [hookify-plus](https://github.com/tuandinh0801/hookify-plus) | Security rule enforcement engine |
| [impeccable](https://github.com/pbakaus/impeccable) | UI/UX design polish and critique |
| [anthropics/skills](https://github.com/anthropics/skills) | Document generation (PDF, PPTX, DOCX, XLSX) |
| [claude-mem](https://github.com/thedotmack/claude-mem) | Persistent cross-session memory |
| [mattpocock/skills](https://github.com/mattpocock/skills) | Engineering workflows (TDD, diagnosis, grilling, triage, architecture) |

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
apm install -g --target claude
apm install -g --target copilot
apm install -g --target opencode

# Install only a specific skill from this package
apm install -g tuandinh0801/agent-package-manager --skill openspec-propose

# Update to latest version
apm install --update

# Uninstall
apm uninstall tuandinh0801/agent-package-manager

# List installed dependencies
apm deps list

# Security audit (checks for hidden unicode, lockfile drift)
apm audit

# Compile instructions into agent-native format
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

Create `rules/hookify.my-rule.local.md`:

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

Create `.apm/instructions/my-standard.instructions.md`:

```markdown
---
description: One-line description of this coding standard
applyTo: "**/*"    # or "**/*.py", "**/*.ts,**/*.tsx"
---

# Title

Your coding standards here...
```

### Commit Convention

```
<type>: <description>

Types: feat, fix, refactor, docs, test, chore
```

## Project Structure

```
.
├── apm.yml              # Package manifest (dependencies, config)
├── .apm/instructions/   # Instructions deployed to .claude/rules/ on install
├── skills/              # Custom skills (SKILL.md format)
├── rules/               # Hookify security rules (hookify.*.local.md)
├── instructions/        # Coding standards source (.instructions.md)
├── scripts/             # Lifecycle scripts (deploy-rules.sh)
└── docs/                # Workflow guides, plugin reference
```

## License

MIT
