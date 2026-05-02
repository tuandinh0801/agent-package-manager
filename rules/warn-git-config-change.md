---
name: warn-git-config-change
enabled: true
event: bash
action: warn
pattern: git\s+config\s+.*(core\.hooksPath|credential|alias|url\.\S+\.insteadOf)
---

**Warning: Security-sensitive git config change**

This command modifies a git configuration key that can alter security behavior:

- `core.hooksPath` — redirects git hooks to a different directory (can execute arbitrary code on commit/push)
- `credential.*` — changes how git stores/retrieves credentials
- `alias.*` — creates command aliases (can shadow legitimate commands)
- `url.*.insteadOf` — rewrites remote URLs (can redirect pushes to malicious repos)

**Verify:** Is this change intentional and from a trusted source?
