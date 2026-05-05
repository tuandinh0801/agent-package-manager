---
name: warn-network-exfil
enabled: true
event: bash
action: warn
pattern: (curl|wget|nc|netcat|ncat)\s+|\|\s*(curl|wget|nc|netcat|ncat)\s
---

**Warning: Network command detected**

A command is attempting to use a network tool (`curl`, `wget`, `nc`, `netcat`).

**Risk:** Data exfiltration — sensitive information (secrets, source code, environment variables) could be sent to an external server.

**Check before proceeding:**
- Is the destination URL trusted?
- Is any sensitive data being piped or posted?
- Could this leak credentials or source code?
