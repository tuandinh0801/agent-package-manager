---
name: protect-env-files
enabled: true
event: all
action: block
conditions:
  - field: file_path
    operator: regex_match
    pattern: (^|/)\.env($|\.(?!example).*)
---

**Blocked: Accessing .env file**

Reading or editing `.env` files is blocked to prevent accidentally exposing secrets.

**Matched patterns:** `.env`, `.env.local`, `.env.production`, `.env.development`, etc.
**Allowed:** `.env.example` (safe for documentation)

**If you need to work with environment variables:**
- Edit `.env` files manually outside of Claude Code
- Use a secrets manager for production credentials
- Use `.env.example` (without real values) for documentation
