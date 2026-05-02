---
name: block-npm-destructive
enabled: true
event: bash
action: block
pattern: npm\s+unpublish
---

**Blocked: Irreversible npm operation**

`npm unpublish` permanently removes a package version from the registry. This action:
- Cannot be undone
- Breaks all projects depending on the unpublished version
- May violate npm's unpublish policy (packages >72 hours old cannot be unpublished)

**If you need to deprecate a package:**
- Use `npm deprecate <package>` instead
- If you truly need to unpublish, do it manually outside Claude Code
