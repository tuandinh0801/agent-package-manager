---
name: warn-unicode-injection
enabled: true
event: file
action: warn
conditions:
  - field: new_text
    operator: regex_match
    pattern: "[\u200b-\u200f\u202a-\u202e\ufeff\u0400-\u04ff]|\\\\x1b\\[|\\\\x00"
---

**Warning: Suspicious Unicode characters detected**

The text being written contains characters commonly used in prompt injection or homoglyph attacks.

**Detected character classes:**
- **Zero-width characters** (U+200B-200F) — invisible, used to hide payloads
- **Bidirectional overrides** (U+202A-202E) — can reverse displayed text direction
- **BOM / zero-width no-break space** (U+FEFF) — invisible marker
- **Cyrillic characters** (U+0400-04FF) — visual lookalikes for Latin letters (homoglyph attacks: Cyrillic 'a' looks identical to Latin 'a')
- **ANSI escape sequences** (`\x1b[`) — terminal manipulation
- **Null bytes** (`\x00`) — can truncate strings or cause parsing errors

**Verify:** Is this content legitimate, or could it be an injection attempt?
