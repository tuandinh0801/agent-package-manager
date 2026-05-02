---
name: openspec-apply-change
description: Implement tasks from an OpenSpec change. Use when the user wants to start implementing, continue implementation, or work through tasks.
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "2.0"
  generatedBy: "1.2.0"
---

Implement tasks from an OpenSpec change using test-driven development, subagent-driven implementation, and verification gates.

**Input**: Optionally specify a change name. If omitted, check if it can be inferred from conversation context. If vague or ambiguous you MUST prompt for available changes.

**Steps**

1. **Select the change**

   If a name is provided, use it. Otherwise:
   - Infer from conversation context if the user mentioned a change
   - Auto-select if only one active change exists
   - If ambiguous, run `openspec list --json` to get available changes and use the **AskUserQuestion tool** to let the user select

   Always announce: "Using change: <name>" and how to override (e.g., `/opsx:apply <other>`).

2. **Check status to understand the schema**
   ```bash
   openspec status --change "<name>" --json
   ```
   Parse the JSON to understand:
   - `schemaName`: The workflow being used (e.g., "spec-driven")
   - Which artifact contains the tasks (typically "tasks" for spec-driven, check status for others)

3. **Get apply instructions**

   ```bash
   openspec instructions apply --change "<name>" --json
   ```

   This returns:
   - Context file paths (varies by schema - could be proposal/specs/design/tasks or spec/tests/implementation/docs)
   - Progress (total, complete, remaining)
   - Task list with status
   - Dynamic instruction based on current state

   **Handle states:**
   - If `state: "blocked"` (missing artifacts): show message, suggest using openspec-continue-change
   - If `state: "all_done"`: congratulate, suggest archive
   - Otherwise: proceed to implementation

4. **Read context files**

   Read the files listed in `contextFiles` from the apply instructions output.
   The files depend on the schema being used:
   - **spec-driven**: proposal, specs, design, tasks
   - Other schemas: follow the contextFiles from CLI output

5. **Show current progress**

   Display:
   - Schema being used
   - Progress: "N/M tasks complete"
   - Remaining tasks overview
   - Dynamic instruction from CLI

6. **Choose quality mode and workspace**

   **6a. Quality mode** — Use the **AskUserQuestion tool**:

   | Mode | Per Task | End of Session | Best For |
   |------|----------|----------------|----------|
   | **Lightweight** (default) | Implementer subagent (TDD) + verification | Code review (once) | Small/routine changes |
   | **Full** | Implementer + spec reviewer + code quality reviewer | — | Complex/critical changes |

   Default to **Lightweight** if the user skips or doesn't specify.

   **6b. Workspace** — Ask: "Create isolated git worktree for this change?"

   If yes:
   - Create worktree: `git worktree add .claude/worktrees/<change-name> -b openspec/<change-name>`
   - Verify `.claude/worktrees` is in `.gitignore` (add + commit if not)
   - Auto-detect and run project setup (`npm install`, `pip install -e .`, `cargo build`, `go mod download`, etc.)
   - Run baseline tests to confirm clean starting point — if tests fail, warn and ask whether to proceed
   - Report worktree path and baseline test results

   If no: work in current directory.

7. **Implement tasks (subagent-driven, with TDD and review gates)**

   **7a. Extract all pending tasks** from the tasks file. Parse every `- [ ]` item with its full description text. Create a **TodoWrite** list from these.

   **7b. For each pending task, run the implementation cycle:**

   Capture `BASE_SHA` with `git rev-parse HEAD` before dispatching the implementer.

   ---

   **Lightweight Mode**

   1. **Dispatch implementer subagent** using `./implementer-prompt.md` template:
      - Fill `{FULL_TASK_TEXT}` with the verbatim task description from tasks.md
      - Fill `{CHANGE_NAME}`, `{SCHEMA_NAME}` from step 2
      - Fill `{PROPOSAL_CONTENT}`, `{DESIGN_CONTENT}`, `{SPECS_CONTENT}`, `{ADDITIONAL_CONTEXT}` from context files read in step 4 (omit sections that don't exist for this schema)
      - Fill `{WORKING_DIRECTORY}` with current working directory (or worktree path)

   2. **Handle implementer status:**
      - **DONE** → proceed to verification gate
      - **DONE_WITH_CONCERNS** → read concerns; if about correctness/scope, address before verification; if observational, note and proceed
      - **NEEDS_CONTEXT** → provide missing context and re-dispatch
      - **BLOCKED** → assess the blocker:
        1. Context problem → provide more context, re-dispatch
        2. Task too complex → break into smaller pieces
        3. Plan itself is wrong → escalate to human
        Never ignore a BLOCKED status or force retry without changes.

   3. **Verification gate** — before marking the task complete:
      - Auto-detect the test command from project files:
        - `package.json` → `npm test`
        - `Cargo.toml` → `cargo test`
        - `pyproject.toml` / `setup.py` → `pytest`
        - `go.mod` → `go test ./...`
        - If uncertain → ask the user
      - Run the full test suite fresh
      - Read the complete output, check exit code
      - **If tests pass**: mark `- [ ]` → `- [x]` in the tasks file, update TodoWrite
      - **If tests fail**: trigger **systematic debugging** (see section below)

   After **all tasks complete**: dispatch one code quality review using `./code-quality-reviewer-prompt.md` for the entire implementation (`BASE_SHA` from before first task, `HEAD_SHA` from current HEAD).

   ---

   **Full Mode**

   Steps 1-2: Same as Lightweight (dispatch implementer, handle status).

   3. **Dispatch spec reviewer subagent** using `./spec-reviewer-prompt.md` template:
      - Fill `{FULL_TASK_TEXT}` with the task description
      - Fill `{RELEVANT_SPEC_CONTENT}` with specification content from openspec artifacts relevant to this task
      - Fill `{IMPLEMENTER_REPORT}` with the implementer's report
      - Reviewer reads actual code, compares to requirements
      - **If issues found** → dispatch implementer to fix → re-dispatch spec reviewer (max 3 cycles, then escalate to human)

   4. **Dispatch code quality reviewer subagent** using `./code-quality-reviewer-prompt.md` template:
      - **Only after spec compliance passes**
      - Fill `{DESCRIPTION}` with task summary, `{TASK_TEXT}` with task description
      - Fill `{BASE_SHA}` (captured before implementer) and `{HEAD_SHA}` (current HEAD)
      - **If Critical or Important issues** → dispatch implementer to fix → re-dispatch reviewer (max 3 cycles, then escalate to human)

   5. **Verification gate**: same as Lightweight step 3.

   ---

   **Systematic Debugging (on test failure)**

   When tests fail after implementation or during the verification gate, **do NOT retry blindly or dispatch another implementer**. Instead:

   1. **Investigate root cause:**
      - Read error messages and stack traces carefully
      - Reproduce the failure consistently
      - Check what changed: `git diff {BASE_SHA}..HEAD`
      - Trace data flow to find where bad values originate

   2. **Pattern analysis:**
      - Find working examples of similar code in the codebase
      - Compare against working references
      - Identify every difference, however small

   3. **Hypothesis and fix:**
      - Form a single hypothesis: "I think X because Y"
      - Test with the minimal change (one variable at a time)
      - Verify fix with a fresh test run

   4. **Escalation:**
      - If 3+ fix attempts fail: **STOP and escalate to the human**
      - Present: what was tried, what failed, what the root cause might be
      - Don't attempt more fixes — question the approach instead

   **7c. Pause conditions:**
   - Task is unclear → ask for clarification
   - Implementation reveals a design issue → suggest updating artifacts
   - Error or blocker encountered → report and wait for guidance
   - User interrupts
   - Implementer BLOCKED after retry → escalate to human
   - Review loop exceeds 3 cycles for same issue → escalate to human
   - 3+ debugging attempts fail → escalate to human

8. **On completion or pause, show status and hand off**

   **8a. If worktree was created and all tasks are done**, present options:
   1. Merge back to base branch locally
   2. Push and create Pull Request
   3. Keep branch as-is (handle later)

   Execute the chosen option. For merge: checkout base → pull → merge → verify tests → delete branch. For PR: push with `-u` → `gh pr create`. For keep: report branch name and location.

   **8b. Archive handoff:**

   Display:
   - Tasks completed this session
   - Overall progress: "N/M tasks complete"
   - Quality mode used
   - If all done: suggest archive
   - If paused: explain why and wait for guidance

**Output During Implementation**

Lightweight mode:
```
## Implementing: <change-name> (schema: <schema-name>, mode: lightweight)

Task 3/7: <task description>
  [Implementer] TDD: 3 tests written, all green. Committed.
  [Verification] npm test — 42/42 passing
  ✓ Task complete

Task 4/7: <task description>
  [Implementer] TDD: 2 tests written, all green. Committed.
  [Verification] npm test — 44/44 passing
  ✓ Task complete
```

Full mode:
```
## Implementing: <change-name> (schema: <schema-name>, mode: full)

Task 3/7: <task description>
  [Implementer] TDD: 3 tests written, all green. Committed.
  [Spec review] ✅ All requirements met
  [Code quality] ✅ Approved — clean implementation
  [Verification] npm test — 42/42 passing
  ✓ Task complete
```

On test failure with debugging:
```
Task 4/7: <task description>
  [Implementer] DONE — implemented X, Y, Z
  [Verification] ❌ npm test — 40/42 passing, 2 failing
  [Debugging] Root cause: missing null check in Y
  [Fix] Applied minimal fix, re-verified
  [Verification] ✅ npm test — 42/42 passing
  ✓ Task complete
```

**Output On Completion**

```
## Implementation Complete

**Change:** <change-name>
**Schema:** <schema-name>
**Mode:** <lightweight|full>
**Progress:** 7/7 tasks complete, all verified ✓

### Completed This Session
- [x] Task 1 — verified ✓
- [x] Task 2 — verified ✓
...

All tasks complete and verified! Run `/openspec-archive-change` (or `/opsx:archive`) to finalize.
```

**Output On Pause**

```
## Implementation Paused

**Change:** <change-name>
**Schema:** <schema-name>
**Mode:** <lightweight|full>
**Progress:** 4/7 tasks complete

### Issue Encountered
<description of the issue>

**Options:**
1. <option 1>
2. <option 2>
3. Other approach

What would you like to do?
```

**Guardrails**
- Keep going through tasks until done or blocked
- Always read context files before starting (from the apply instructions output)
- If task is ambiguous, pause and ask before implementing
- If implementation reveals issues, pause and suggest artifact updates
- Keep code changes minimal and scoped to each task
- Update task checkbox immediately after completing each task
- Pause on errors, blockers, or unclear requirements - don't guess
- Use contextFiles from CLI output, don't assume specific file names
- Never implement directly — always dispatch a fresh implementer subagent per task
- In Full mode: never skip reviews (spec compliance OR code quality) for any task
- In Full mode: spec compliance review must pass before code quality review begins
- Never mark a task complete without fresh verification evidence (run tests, confirm output)
- Implementer must follow TDD: write failing test first, watch it fail, write minimal code, watch it pass
- Evidence before assertions: run verification commands and confirm output before claiming pass
- On test failure: investigate root cause first via systematic debugging — don't retry blindly
- After 3 failed fix or review-loop attempts: stop and escalate to human — don't keep trying
- Do not dispatch multiple implementer subagents in parallel (conflicts)
- Provide full task text and openspec context to subagents — do not make them read files themselves

**Fluid Workflow Integration**

This skill supports the "actions on a change" model:

- **Can be invoked anytime**: Before all artifacts are done (if tasks exist), after partial implementation, interleaved with other actions
- **Allows artifact updates**: If implementation reveals design issues, suggest updating artifacts - not phase-locked, work fluidly
