---
name: block-hardcoded-secrets
enabled: true
event: file
action: warn
conditions:
  - field: new_text
    operator: regex_match
    pattern: (API_KEY|SECRET|TOKEN|PASSWORD|PRIVATE_KEY|ACCESS_KEY|CLIENT_SECRET)\s*[:=]\s*['"][^'"]{8,}['"]
---

**Hardcoded secret detected!**

You're writing what appears to be a hardcoded secret or credential into source code.

**Why this is dangerous:**
- Secrets in code get committed to version control
- They can be exposed in logs, error messages, or public repos

**Use instead:**
- Environment variables (`process.env.API_KEY`)
- A secrets manager (Vault, AWS Secrets Manager, etc.)
- `.env` files (which should be in `.gitignore`)
