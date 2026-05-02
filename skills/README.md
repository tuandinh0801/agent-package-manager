# Skills

14 custom skills organized into three categories.

## OpenSpec Workflow (4 skills)

Structured feature development: explore → propose → implement → archive.

| Skill | Trigger | Purpose |
|-------|---------|---------|
| `openspec-explore` | `/opsx:explore` | Thinking partner for exploring ideas and clarifying requirements |
| `openspec-propose` | `/opsx:propose` | Create change proposals with design docs + task breakdown |
| `openspec-apply-change` | `/opsx:apply` | Implement tasks using TDD and subagents |
| `openspec-archive-change` | `/opsx:archive` | Finalize and archive completed changes |

**Requires:** `openspec` CLI (`npm install -g openspec`)

**Example flow:**
```
/opsx:explore    → think through the problem
/opsx:propose    → generate proposal.md, design.md, tasks.md
/opsx:apply      → implement with TDD (RED → GREEN → REFACTOR)
/opsx:archive    → finalize when done
```

See [docs/workflows/openspec-workflow.md](../docs/workflows/openspec-workflow.md) for full guide.

## GitNexus Code Intelligence (7 skills)

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

See [docs/workflows/gitnexus-workflow.md](../docs/workflows/gitnexus-workflow.md) for full guide.

## Utility Skills (3 skills)

| Skill | Purpose |
|-------|---------|
| `agent-browser` | Browser automation via CDP for testing and scraping |
| `the-fool` | Critical reasoning — devil's advocate, pre-mortem, red team |
| `plugin-structure` | Claude Code plugin scaffolding guide |

## Adding a New Skill

1. Create directory: `skills/my-skill/`
2. Add `SKILL.md` with YAML frontmatter (`name`, `description`)
3. Add supporting files (references, templates, scripts) in same directory
4. Run `apm compile --validate`
