---
description: Code intelligence preferences — prefer LSP over grep, check diagnostics after edits
applyTo: "**/*"
---
# Code Intelligence

Use Grep only when LSP isn't available or for text/pattern searches (comments, strings, config). LSP is faster, precise, and avoids reading entire files:
- `workspaceSymbol` to find where something is defined
- `findReferences` to see call usages across the codebase
- `goToDefinition` / `goToImplementation` to jump to source
- `hover` for type info without reading the file

After writing or editing code, check LSP diagnostics and fix errors before proceeding.
