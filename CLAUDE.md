@RTK.md

@simplify.md

# Code Intelligence
Use Grep only when LSP isn't available or for text/pattern searches (comments, strings, config). it's faster, precise, and avoids reading entire files:
- `workspaceSymbol` to find where something is defined
- `findReferences` to seecall usages across the codebase
- `goToDefinition` / `goToImplementation` to jump to source
- `hover` for type info without reading the file

After writing or editing code, check LSP diagnostics and fix errors before proceeding.

# Code Style
- Don't add needless blank lines in function bodies
- Never use environment/config fallbacks. Fail fast
- Every public/exported function should have a docstring — one concise line describing what it does
- Document params and return values only when their purpose or shape is not obvious from the name/type
- Use inline comments sparingly — only for non-trivial logic that isn't self-explanatory
- Inline comments explain *why*, not *what* — don't restate the code in prose
- Don't leave cruft comments behind when removing code.

# Git & GitHub
- Don't add test plan sections to PR bodies
- Prefer git mv over mv
- Don't amend commits or use --force
- Don't use gh --admin or try to bypass rulesets
- use git -C instead of needlessly changing directories
