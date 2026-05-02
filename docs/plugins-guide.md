# Recommended Plugins Guide

This guide explains which Claude Code marketplace plugins to install alongside this APM package, why each is useful, and how to install them.

## Installation

Plugins are installed via Claude Code's built-in plugin system, not via APM. Use the marketplace or add them to your `~/.claude/settings.json`.

## Essential Plugins

### hookify (claude-plugins-official)

**Why:** Required for the 15 security rules in this package to be active. Without hookify, the rules in `rules/` are just documentation.

**What it does:** Intercepts tool calls and file operations, matching them against rule patterns. Blocks dangerous operations and warns on suspicious ones.

**Install:** Add to marketplace `claude-plugins-official`, enable `hookify@claude-plugins-official`

---

### superpowers (claude-plugins-official)

**Why:** Provides structured development workflows that complement our coding standards.

**What it does:**
- `systematic-debugging` — Root-cause analysis before fixing
- `test-driven-development` — Enforces RED→GREEN→REFACTOR
- `brainstorming` — Explores requirements before coding
- `verification-before-completion` — Prevents false "done" claims
- `writing-plans` / `executing-plans` — Multi-step task management

**Install:** Add to marketplace `claude-plugins-official`, enable `superpowers@claude-plugins-official`

---

### code-review (claude-plugins-official)

**Why:** Structured PR review that pairs well with gitnexus-pr-review skill.

**Install:** Add to marketplace `claude-plugins-official`, enable `code-review@claude-plugins-official`

---

### claude-mem (thedotmack)

**Why:** Persistent memory across sessions. Remembers decisions, patterns, and context.

**What it does:** Stores observations (decisions, bugfixes, discoveries) in a searchable database. Build knowledge corpora for specific topics.

**Install:** Add marketplace source:
```json
"thedotmack": {
  "source": { "source": "github", "repo": "thedotmack/claude-mem" }
}
```

## Productivity Plugins

### impeccable (pbakaus/impeccable)

**Why:** Professional-grade UI/UX feedback and enhancement.

**Skills included:** critique, polish, animate, typeset, colorize, arrange, audit, harden, optimize, distill, overdrive

**Install:** Add marketplace source:
```json
"impeccable": {
  "source": { "source": "github", "repo": "pbakaus/impeccable" }
}
```

---

### document-skills (anthropics/skills)

**Why:** Generate professional documents directly from Claude Code.

**What it does:** Create PDFs, Word docs, PowerPoints, spreadsheets, HTML artifacts, algorithmic art, and more.

**Install:** Add marketplace source:
```json
"anthropic-agent-skills": {
  "source": { "source": "github", "repo": "anthropics/skills" }
}
```

---

### codex (openai-codex)

**Why:** Delegate tasks to OpenAI Codex for second opinions or parallel work.

**Install:** Add marketplace source:
```json
"openai-codex": {
  "source": { "source": "github", "repo": "openai/codex-plugin-cc" }
}
```

---

### caveman (JuliusBrussee/caveman)

**Why:** Already included as an APM dependency. Reduces token usage ~75% by speaking concisely.

**Note:** This is automatically installed via `apm install` — no separate plugin installation needed.

## SAP Team Plugins

For team members working with SAP technologies:

### Setup

Add the SAP skills marketplace:
```json
"sap-skills": {
  "source": { "source": "github", "repo": "anthropics/skills" }
}
```

### Available SAP Plugins

| Plugin | Purpose |
|--------|---------|
| `sap-cap-capire` | CAP CDS modeling, service development, deployment |
| `sap-fiori-tools` | Fiori Elements apps, Page Editor, UI annotations |
| `sap-ai-core` | AI Core deployments, orchestration, model management |
| `sap-cloud-sdk-ai` | Cloud SDK AI integration (chat, embeddings, streaming) |
| `sap-btp-developer-guide` | Full BTP application development |
| `sap-btp-connectivity` | Destinations, Cloud Connector, proxies |
| `sap-btp-service-manager` | Service instances, bindings, brokers |
| `sap-btp-best-practices` | Enterprise architecture and operations |
| `sapui5-linter` | UI5 static analysis and deprecated API detection |

### SAP AI Core CLI

For SAP AI Core operations, also install:
```json
"sap-aicore-cli": {
  "source": { "source": "directory", "path": "/path/to/sap-aicore-cli" }
}
```

## Full settings.json Example

```json
{
  "enabledPlugins": {
    "caveman@caveman": true,
    "superpowers@claude-plugins-official": true,
    "hookify@claude-plugins-official": true,
    "code-review@claude-plugins-official": true,
    "claude-mem@thedotmack": true,
    "impeccable@impeccable": true,
    "document-skills@anthropic-agent-skills": true,
    "codex@openai-codex": true
  },
  "extraKnownMarketplaces": {
    "claude-plugins-official": {
      "source": { "source": "git", "url": "https://github.com/anthropics/claude-plugins-official.git" },
      "autoUpdate": true
    },
    "caveman": {
      "source": { "source": "github", "repo": "JuliusBrussee/caveman" },
      "autoUpdate": true
    },
    "impeccable": {
      "source": { "source": "github", "repo": "pbakaus/impeccable" }
    },
    "anthropic-agent-skills": {
      "source": { "source": "github", "repo": "anthropics/skills" },
      "autoUpdate": true
    },
    "openai-codex": {
      "source": { "source": "github", "repo": "openai/codex-plugin-cc" },
      "autoUpdate": true
    },
    "thedotmack": {
      "source": { "source": "github", "repo": "thedotmack/claude-mem" }
    }
  }
}
```
