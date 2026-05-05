---
description: Code style rules — docstrings, comments, blank lines, fail-fast config
applyTo: "**/*"
---
# Code Style

- Don't add needless blank lines in function bodies
- Never use environment/config fallbacks. Fail fast
- Every public/exported function should have a docstring — one concise line describing what it does
- Document params and return values only when their purpose or shape is not obvious from the name/type
- Use inline comments sparingly — only for non-trivial logic that isn't self-explanatory
- Inline comments explain *why*, not *what* — don't restate the code in prose
- Don't leave cruft comments behind when removing code
