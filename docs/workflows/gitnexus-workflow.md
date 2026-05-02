# GitNexus Code Intelligence Workflow

GitNexus provides knowledge-graph-powered code understanding. It indexes your codebase into a graph of symbols, relationships, and execution flows.

## Setup

1. Configure GitNexus MCP server in your `.claude/mcp.json`
2. Index your repo: ask Claude "Index this repo with GitNexus"

## Available Skills

### Exploring (`gitnexus-exploring`)

Understand how code works by tracing execution flows.

**Use when:** "How does X work?", "What calls this function?", "Show me the auth flow"

```
> "How does the payment processing flow work?"
# Traces: API endpoint → validation → payment service → Stripe SDK → webhook handler

> "What calls the validateUser function?"
# Shows all callers with file locations and context
```

### Debugging (`gitnexus-debugging`)

Debug with full graph context — trace errors back to root causes.

**Use when:** "Why is X failing?", "Where does this error come from?", "Trace this bug"

```
> "Why is the user session expiring early?"
# Traces session lifecycle through the graph
# Identifies where TTL is set vs where it's checked

> "Where does this NullPointerException come from?"
# Follows the call chain to find the null source
```

### Impact Analysis (`gitnexus-impact-analysis`)

Know what will break before you change something.

**Use when:** "Is it safe to change X?", "What depends on this?", "What will break?"

```
> "What's the blast radius of renaming UserService to AccountService?"
# Returns:
#   d=1 (WILL BREAK): 12 direct importers
#   d=2 (LIKELY AFFECTED): 8 indirect consumers
#   d=3 (MAY NEED TESTING): 4 transitive dependents
#   Affected processes: login, signup, profile-update
```

### PR Review (`gitnexus-pr-review`)

Review PRs with graph-aware context — understand what a change really affects.

**Use when:** "Review this PR", "What does PR #42 change?", "Is this PR safe to merge?"

```
> "Review PR #42"
# Analyzes:
#   - Changed symbols and their dependents
#   - Affected execution flows
#   - Missing test coverage for impacted paths
#   - Risk assessment (LOW/MEDIUM/HIGH)
```

### Refactoring (`gitnexus-refactoring`)

Safe structural changes with graph-guided rename/extract/move.

**Use when:** "Rename this function", "Extract this into a module", "Move this to a separate file"

```
> "Rename validateEmail to isValidEmail across the codebase"
# Uses graph to find all references (not just text matches)
# Handles: imports, type references, string references
# Preview mode by default — shows changes before applying
```

### CLI (`gitnexus-cli`)

Manage the GitNexus index.

```
> "Index this repo"           # Initial analysis
> "Reanalyze the codebase"   # After major changes
> "Generate a wiki"           # Auto-documentation
> "Check GitNexus status"     # Index freshness
```

### Guide (`gitnexus-guide`)

Reference for all GitNexus tools, MCP resources, and graph schema.

```
> "What GitNexus tools are available?"
> "How do I query the knowledge graph directly?"
```

## Workflow Example: Safe Refactoring

```bash
# 1. Understand current state
> "How does the authentication module work?"
# → gitnexus-exploring traces the full flow

# 2. Check impact of planned change
> "What breaks if I split AuthService into TokenService and SessionService?"
# → gitnexus-impact-analysis shows blast radius

# 3. Perform the refactoring
> "Extract token logic from AuthService into a new TokenService"
# → gitnexus-refactoring handles rename + move safely

# 4. Verify nothing broke
> "Review the changes I just made"
# → gitnexus-pr-review checks for issues
```

## Tips

- **Re-index after major changes** — the graph becomes stale after large refactors
- **Use impact analysis before refactoring** — always know what will break
- **Graph queries are faster than file reads** — prefer GitNexus for "where is X used?"
- **Combine with LSP** — GitNexus for cross-file flows, LSP for single-symbol navigation
