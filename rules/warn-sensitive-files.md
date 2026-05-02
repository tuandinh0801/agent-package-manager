---
name: warn-sensitive-files
enabled: true
event: all
action: warn
conditions:
  - field: file_path
    operator: regex_match
    pattern: \.(pem|key|p12|pfx|keystore|jks)$|credentials\.json|secrets/
---

**Warning: Sensitive file access detected**

You are accessing a file that may contain cryptographic keys, certificates, or credentials.

**Matched patterns:**
- Certificate/key files: `.pem`, `.key`, `.p12`, `.pfx`, `.keystore`, `.jks`
- Credential files: `credentials.json`
- Secrets directories: `secrets/`

**Before proceeding, verify:**
- Is this file safe to read/modify in this context?
- Will any secret values be logged or exposed?
- Could this file contain private keys or tokens?
