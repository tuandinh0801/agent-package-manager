---
name: warn-history-exposure
enabled: true
event: bash
action: warn
pattern: ^\s*(history|printenv|env\b|set\b|cat\s+/proc/self/environ)
---

**Warning: Environment/history exposure**

This command may reveal sensitive environment state including secrets, tokens, or API keys stored in environment variables or shell history.

**Commands detected:**
- `history` — shell command history (may contain secrets typed previously)
- `printenv` / `env` / `set` — dumps all environment variables
- `/proc/self/environ` — raw process environment

**Consider:**
- Use specific variable access (`echo $PATH`) instead of dumping all variables
- Pipe through `grep` to filter for non-sensitive values only
