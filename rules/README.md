# Security Rules

15 hookify rules that protect against dangerous operations during AI-assisted development.

**Requires:** [hookify-plus](https://github.com/tuandinh0801/hookify-plus) plugin (installed automatically via APM dependencies).

## Blocking Rules (9)

These prevent the operation entirely.

| Rule | Blocks |
|------|--------|
| `block-code-injection` | `base64 -d \| bash`, `eval $(...)`, `source <(...)` |
| `block-credential-dirs` | Access to `~/.ssh/`, `~/.aws/`, `~/.gnupg/`, `~/.kube/` |
| `block-force-push` | `git push --force` |
| `block-git-destructive` | `git reset --hard`, `git clean -f`, `git checkout -- .` |
| `block-hardcoded-secrets` | Hardcoded API keys, passwords, tokens in code |
| `block-npm-destructive` | Dangerous npm operations |
| `block-rm-rf-home` | Recursive deletion from home directory |
| `protect-env-files` | Reading/writing `.env` files (allows `.env.example`) |
| `protect-env-files-bash` | Bash-specific `.env` protection |

## Warning Rules (6)

These alert but allow the operation to proceed.

| Rule | Warns On |
|------|----------|
| `warn-git-config-change` | `core.hooksPath`, credential config, aliases |
| `warn-history-exposure` | Shell history file access |
| `warn-home-dir-ops` | Home directory operations |
| `warn-network-exfil` | Network exfiltration patterns (curl/wget to suspicious targets) |
| `warn-sensitive-files` | `.pem`, `.key`, `.p12`, credentials files |
| `warn-unicode-injection` | Zero-width chars, bidirectional overrides, Cyrillic homoglyphs |

## Rule Format

Each rule is a markdown file with YAML frontmatter:

```markdown
---
name: my-rule
enabled: true
event: bash           # bash | file
action: block         # block | warn
pattern: "regex"      # for simple regex matching
# OR for complex conditions:
conditions:
  - field: new_text
    operator: regex_match
    pattern: "regex"
---

**Blocked/Warning: Human-readable explanation**

Why this pattern is dangerous and what the user should do instead.
```

## Adding a New Rule

1. Create `rules/my-rule.md` following the format above
2. Choose `action: block` for dangerous operations, `action: warn` for suspicious ones
3. Write a clear explanation of WHY the pattern is dangerous
4. Run `apm compile --validate`
