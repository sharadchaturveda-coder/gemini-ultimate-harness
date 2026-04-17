---
name: live-spec
description: Live spec workflow — create and continuously update a single living spec file while planning and implementing work. USE when starting feature work, executing implementation plans, refactors, or any multi-step task that needs an active source of truth.
---

# Live Spec

Use one living Markdown spec as the current contract for the work. The file is not archival documentation. It is the active control surface for planning, implementation state, decisions, live checklists, sub-checklists, and acceptance checks.

## When to use live-spec vs alternatives

| Situation | Use |
|---|---|
| New feature, refactor, migration, or multi-step implementation with evolving decisions | `live-spec` |
| Small one-shot fix with no branching decisions and no meaningful plan | No live spec required |
| Formal multi-doc RFC flow for broader org review | `blueprint` or RFC workflow, optionally paired with `live-spec` for execution |

## Canonical file location

Prefer the first location that already exists:

1. `docs/live-spec.md`
2. `.agent/live-spec.md`
3. `live-spec.md`

If none exists, create `docs/live-spec.md`.

There must be exactly one active live spec for the task unless the user explicitly asks for separate specs.

## Required operating loop

When this skill is active, follow this sequence in order:

1. Find the canonical live spec file or create it from `templates/live-spec-template.md`.
2. Refresh the live spec before substantial planning, implementation, review work, or resuming an in-progress task.
3. Record scope, constraints, assumptions, and open questions before changing code.
4. Convert the current intent into a concrete execution checklist inside the live spec.
5. Break major checklist items into sub-checklists before starting implementation on that slice.
6. Implement against the live spec, not against stale memory or scattered notes.
7. As each implementation slice progresses, keep parent checklist items and sub-checklists updated in the live spec.
8. After each meaningful milestone, update status, decisions, risks, and acceptance checks in the live spec.
9. If reality diverges from the spec, reconcile the spec first or immediately after the code change in the same work pass.
10. Close the loop by marking completed items, unresolved follow-ups, and final verification results.

## Enforcement rules

**Always do this:**
- Treat the live spec as the source of truth for the current task.
- Update the live spec before coding when the task includes planning, sequencing, tradeoffs, or open questions.
- Expand checklist items into sub-checklists before implementing a non-trivial slice.
- Keep implementation progress reflected in the checklist state while work is underway, not only at the end.
- Update the live spec after coding when behavior, constraints, or decisions changed.
- Keep the spec concise, current, and execution-oriented.
- Preserve a short decision log with dated entries.
- Keep acceptance criteria testable and specific.

**Never do this:**
- Do not create extra planning docs, scratch RFCs, or stale side documents unless the user explicitly asks.
- Do not leave TODOs in code for decisions that belong in the live spec.
- Do not keep private mental state that should be in the live spec.
- Do not keep implementation progress only in terminal chatter while the live spec lags behind.
- Do not start a substantial implementation slice without checklist coverage for that slice.
- Do not let the live spec drift behind the code after a meaningful implementation change.
- Do not mark work complete if the acceptance checklist in the live spec is still unresolved.

## Minimum required sections

The live spec must keep these sections present:

- `# Live Spec: <task name>`
- `## Objective`
- `## Scope`
- `## Constraints`
- `## Assumptions`
- `## Open Questions`
- `## Decision Log`
- `## Execution Plan`
- `## Implementation Checklist`
- `## Current Status`
- `## Acceptance Checks`
- `## Verification Notes`
- `## Follow-ups`

## Update heuristics

Update the live spec immediately when any of the following happen:

- The plan changes shape
- An implementation slice starts or is decomposed further
- A checklist item needs sub-checklists to stay actionable
- A new constraint appears
- The chosen implementation differs from the original approach
- A blocker or risk is discovered
- Acceptance criteria change
- Tests fail in a way that changes the rollout plan
- The user changes direction

## Execution style

- Keep entries short and stateful.
- Prefer checklists, sub-checklists, and concrete bullets over essays.
- Write decisions as facts with rationale, not brainstorming sprawl.
- Timestamp decision log entries as `YYYY-MM-DD`.
- Mark plan items with `[ ]`, `[~]`, or `[x]`.
- Use indented checklist items for sub-steps under the current implementation slice.

## Bootstrap pattern

If no live spec exists, create one with:

1. A one-sentence objective
2. Explicit in-scope and out-of-scope bullets
3. The current execution checklist plus the first active sub-checklist
4. Acceptance checks tied to observable outcomes

Then begin work.

## Autonomous decision rules

**Use this skill when:**
- The user asks for a live spec, living spec, active spec, or always-updated spec file
- The task involves planning plus implementation
- The work spans multiple files, steps, or decisions
- The work is already planned and the agent is now beginning implementation
- The agent would otherwise risk relying on stale docs or ephemeral context

**Do NOT use when:**
- The task is a trivial one-file fix with no real plan
- The user explicitly says not to create or maintain a spec file
- The repo already has a stronger mandatory execution workflow that conflicts with this one

## Suggested kickoff line

Before substantial work, say plainly that you are creating or refreshing the live spec and then executing against it.
