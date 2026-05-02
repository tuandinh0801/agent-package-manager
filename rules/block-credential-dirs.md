---
name: block-credential-dirs
enabled: true
event: bash
action: block
pattern: (cat|head|tail|less|more|grep|sed|awk|cp|mv|scp|source|\.)\s+.*(\.ssh|\.aws|\.gnupg|\.kube\/config)
---

**Blocked: Credential directory access detected**

This command is attempting to read or copy files from a sensitive credential directory.

**Protected directories:**
- `~/.ssh/` — SSH private keys and known hosts
- `~/.aws/` — AWS credentials and config
- `~/.gnupg/` — GPG private keys
- `~/.kube/config` — Kubernetes cluster credentials

**These files contain secrets that must never be exposed.**

If you need to work with these files, do so manually outside Claude Code.
