---
name: block-rm-rf-home
enabled: true
event: bash
action: block
pattern: rm\s+-rf\s+.*(/Users/|~/|\$HOME|/home/)
---

**Blocked: rm -rf targeting home directory**

This command would recursively delete files in a home directory path. This is extremely dangerous and could result in permanent data loss.

**If you need to remove files:**
- Use a more specific path
- Remove files individually
- Double-check the path before running
