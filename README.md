# Agent Package Manager

> Comprehensive AI-assisted development environment with security rules, coding standards, and workflow skills for Claude Code.

## Quick Start

```bash
# Install APM CLI first: https://microsoft.github.io/apm/getting-started/quick-start/
apm install tuandinh0801/agent-package-manager
apm compile --target claude
```

After installation, your Claude Code environment gets:
- 14 custom workflow skills
- 15 security rules (hookify)
- 8 coding standard instructions
- Caveman mode (token-compressed communication)

## What's Included

### Custom Skills (14)

#### OpenSpec Workflow (4 skills)

A structured approach to feature development: explore → propose → implement → archive.

| Skill | Trigger | Purpose |
|-------|---------|---------|
| `openspec-explore` | `/opsx:explore` | Thinking partner for exploring ideas and clarifying requirements |
| `openspec-propose` | `/opsx:propose` | Create change proposals with design docs + task breakdown |
| `openspec-apply-change` | `/opsx:apply` | Implement tasks from a proposal using TDD and subagents |
| `openspec-archive-change` | `/opsx:archive` | Finalize and archive completed changes |

**Requires:** `openspec` CLI (`npm install -g openspec`)

#### GitNexus Code Intelligence (7 skills)

Knowledge-graph-powered code understanding for large codebases.

| Skill | Purpose |
|-------|---------|
| `gitnexus-cli` | Index repos, check status, generate wikis |
| `gitnexus-exploring` | Trace execution flows, understand architecture |
| `gitnexus-debugging` | Debug with graph context, trace errors |
| `gitnexus-impact-analysis` | Blast radius analysis before changes |
| `gitnexus-pr-review` | PR review with graph-aware context |
| `gitnexus-refactoring` | Safe rename, extract, split, move |
| `gitnexus-guide` | GitNexus tool reference |

**Requires:** GitNexus MCP server configured

#### Utility Skills (3)

| Skill | Purpose |
|-------|---------|
| `agent-browser` | Browser automation via CDP for testing and scraping |
| `the-fool` | Critical reasoning — devil's advocate, pre-mortem, red team |
| `plugin-structure` | Claude Code plugin scaffolding guide |

### Security Rules (15 rules via hookify)

**Blocking Rules** — prevent dangerous operations:

| Rule | Blocks |
|------|--------|
| `block-code-injection` | `base64 -d \| bash`, `eval $(...)`, `source <(...)` |
| `block-credential-dirs` | Access to `~/.ssh/`, `~/.aws/`, `~/.gnupg/`, `~/.kube/` |
| `block-force-push` | `git push --force` |
| `block-git-destructive` | `git reset --hard`, `git clean -f`, `git checkout -- .` |
| `block-hardcoded-secrets` | Hardcoded API keys, passwords, tokens |
| `block-npm-destructive` | Dangerous npm operations |
| `block-rm-rf-home` | Recursive deletion from home directory |
| `protect-env-files` | Reading/writing `.env` files (allows `.env.example`) |
| `protect-env-files-bash` | Bash-specific `.env` protection |

**Warning Rules** — alert on suspicious operations:

| Rule | Warns On |
|------|----------|
| `warn-git-config-change` | `core.hooksPath`, credential config, aliases |
| `warn-history-exposure` | Shell history file access |
| `warn-home-dir-ops` | Home directory operations |
| `warn-network-exfil` | Network exfiltration patterns |
| `warn-sensitive-files` | `.pem`, `.key`, `.p12`, credentials files |
| `warn-unicode-injection` | Zero-width chars, bidirectional overrides, Cyrillic homoglyphs |

**Requires:** `hookify` plugin installed in Claude Code

### Coding Standards (8 instruction files)

| Instruction | Applies To | Key Rules |
|-------------|------------|-----------|
| `coding-style` | All files | Immutability, <800 line files, <50 line functions |
| `security` | All files | No hardcoded secrets, parameterized queries, XSS prevention |
| `testing` | All files | 80% coverage, TDD mandatory, unit+integration+E2E |
| `git-workflow` | All files | Conventional commits: `feat:`, `fix:`, `refactor:`, etc. |
| `patterns` | All files | Repository pattern, API response envelope |
| `hooks` | All files | TodoWrite for progress tracking |
| `python-coding-style` | `*.py` | PEP 8, type annotations, frozen dataclasses, black/ruff |
| `typescript-coding-style` | `*.ts/tsx/js/jsx` | Strict types, no `any`, Zod validation, React prop interfaces |

### Dependencies

| Package | Purpose |
|---------|---------|
| [caveman](https://github.com/JuliusBrussee/caveman) | Token-compressed communication mode (~75% savings) |

## Workflow Examples

### OpenSpec: Feature Development

```bash
# 1. Explore the problem space
> /opsx:explore
"I want to add user authentication to the API"

# 2. Create a structured proposal
> /opsx:propose
# Creates: openspec/changes/add-user-auth/
#   - proposal.md (what & why)
#   - design.md (how)
#   - tasks.md (implementation steps)

# 3. Implement with TDD
> /opsx:apply
# Works through tasks one by one:
#   - Writes tests first (RED)
#   - Implements (GREEN)
#   - Refactors (IMPROVE)
#   - Uses subagents for parallel work

# 4. Archive when done
> /opsx:archive
```

### GitNexus: Understanding Code

```bash
# Index your repo first
> "Index this repo with GitNexus"

# Explore how something works
> "How does the authentication flow work?"
# → Uses gitnexus-exploring to trace execution paths

# Check impact before refactoring
> "Is it safe to rename validateUser to verifyUser?"
# → Uses gitnexus-impact-analysis for blast radius

# Review a PR with full context
> "Review PR #42"
# → Uses gitnexus-pr-review with graph-aware analysis
```

See [docs/workflows/](docs/workflows/) for detailed guides.

## Recommended Plugins

These marketplace plugins complement this package. Install via Claude Code:

### Essential

| Plugin | Marketplace | Why |
|--------|-------------|-----|
| `superpowers` | claude-plugins-official | Systematic debugging, TDD, brainstorming workflows |
| `hookify` | claude-plugins-official | **Required** for security rules to be active |
| `code-review` | claude-plugins-official | Structured PR review toolkit |
| `claude-mem` | thedotmack | Persistent cross-session memory |

### Productivity

| Plugin | Marketplace | Why |
|--------|-------------|-----|
| `impeccable` | pbakaus/impeccable | UI/UX design polish and critique |
| `document-skills` | anthropics/skills | Generate PDFs, PPTX, DOCX, spreadsheets |
| `codex` | openai-codex | Delegate tasks to OpenAI Codex |
| `inngest-skills` | inngest-agent-skills | Durable workflow development |

### SAP Teams Only

| Plugin | Marketplace | Why |
|--------|-------------|-----|
| `sap-cap-capire` | sap-skills | CAP application development |
| `sap-fiori-tools` | sap-skills | Fiori app generation and configuration |
| `sap-ai-core` | sap-skills | AI Core model deployment |
| `sap-cloud-sdk-ai` | sap-skills | Cloud SDK AI integration |
| `sap-btp-developer-guide` | sap-skills | BTP application development |
| `sap-btp-connectivity` | sap-skills | Destination/proxy configuration |
| `sap-btp-service-manager` | sap-skills | Service instance management |
| `saic-cli` | sap-aicore-cli | SAP AI Core CLI operations |

See [docs/plugins-guide.md](docs/plugins-guide.md) for full installation instructions.

## Prerequisites

| Dependency | Required For | Install |
|------------|--------------|---------|
| [APM CLI](https://microsoft.github.io/apm/) | Package installation | `npm install -g @anthropic/apm` |
| `hookify` plugin | Security rules | Install via Claude Code marketplace |
| [openspec](https://github.com/openspec-dev/openspec) | OpenSpec skills | `npm install -g openspec` |
| GitNexus MCP | GitNexus skills | Configure in `.claude/mcp.json` |
| [RTK](https://github.com/reachingforthejack/rtk) | Token optimization (optional) | `cargo install rtk` |

## Optional: RTK (Rust Token Killer)

RTK provides 60-90% token savings on dev operations by rewriting CLI output. `RTK.md` is included for users who have it installed. If you don't use RTK, the `@RTK.md` reference in CLAUDE.md can be removed.

## Project Structure

```
.
├── apm.yml                  # Package manifest
├── CLAUDE.md                # Global agent instructions
├── simplify.md              # LLM behavioral guidelines
├── RTK.md                   # RTK usage guide (optional)
├── skills/                  # 14 custom skills
├── rules/                   # 15 hookify security rules
├── instructions/            # 8 coding standard files
└── docs/                    # Workflow guides
```

## Contributing

1. Add new skills to `skills/<skill-name>/SKILL.md`
2. Add new rules to `rules/<rule-name>.md`
3. Add new instructions to `instructions/<name>.instructions.md`
4. Run `apm compile --validate` to verify
5. Submit a PR

## License

MIT
