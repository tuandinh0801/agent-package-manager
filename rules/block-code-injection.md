---
name: block-code-injection
enabled: true
event: bash
action: block
pattern: base64\s+(-d|--decode).*\|\s*(bash|sh|zsh|eval)|eval\s+.*\$\(|source\s+<\(
---

**Blocked: Code injection pattern detected**

This command matches known code injection / obfuscation techniques:

- `base64 -d | bash` — decodes and executes hidden payloads
- `eval $(...)` — executes dynamically constructed commands
- `source <(...)` — sources output of a subcommand as a script

**Why this is dangerous:**
These patterns are commonly used to bypass security controls by hiding malicious commands in encoded or dynamically generated strings.

**There is no safe use case for these patterns in an AI-assisted workflow.** If you need to run decoded or dynamic commands, do so manually outside Claude Code.
