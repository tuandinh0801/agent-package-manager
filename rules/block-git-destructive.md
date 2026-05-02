---
name: block-git-destructive
enabled: true
event: bash
action: block
pattern: git\s+(reset\s+--hard|clean\s+-[a-z]*f|checkout\s+--\s+\.|restore\s+\.)
---

**Blocked: Destructive git operation detected**

This command would irreversibly discard uncommitted work or untracked files.

**Detected patterns:**
- `git reset --hard` — discards all uncommitted changes
- `git clean -f` — permanently deletes untracked files
- `git checkout -- .` — discards all working tree changes
- `git restore .` — discards all working tree changes

**Safer alternatives:**
- `git stash` to save changes temporarily
- `git diff` to review what would be lost
- If you truly need this, run it manually outside Claude Code
