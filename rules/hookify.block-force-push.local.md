---
name: block-force-push
enabled: true
event: bash
action: block
pattern: git\s+push\s+.*(-f|--force|--force-with-lease)
---

**Blocked: Force push detected**

Force pushing rewrites remote history and can destroy teammates' work.

**Safer alternatives:**
- `git push` (normal push — fails if behind remote)
- `git pull --rebase` then `git push` (catch up first)
- If you truly need to force push, do it manually outside Claude Code
