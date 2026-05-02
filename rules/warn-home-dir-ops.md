---
name: warn-home-dir-ops
enabled: true
event: bash
action: warn
pattern: (mv|cp|chmod)\s+.*(\/Users\/|~\/|\$HOME|\/home\/)
---

**Warning: Home directory operation detected**

A `mv`, `cp`, or `chmod` command is targeting a home directory path.

**Risk:** Accidentally moving, overwriting, or changing permissions on personal files can cause data loss or security issues.

**Before proceeding, verify:**
- Is the target path correct and specific?
- Will this overwrite existing files?
- Are the permissions appropriate?

**Note:** `rm -rf` on home paths is hard-blocked by a separate rule.
