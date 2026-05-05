---
name: protect-env-files-bash
enabled: true
event: bash
action: block
pattern: (cat|head|tail|less|more|grep|sed|awk|source|\.)\s+.*\.env($|\.\w+)
---

**Blocked: Bash command accessing .env file**

Reading `.env` files via shell commands is blocked to prevent accidentally exposing secrets.

**Matched patterns:** `.env`, `.env.local`, `.env.production`, `.env.development`, etc.

**If you need to work with environment variables:**
- Inspect `.env` files manually outside of Claude Code
- Use a secrets manager for production credentials
