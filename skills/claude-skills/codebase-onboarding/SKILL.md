---
name: codebase-onboarding
description: Map unfamiliar repos before editing. USE when onboarding to a codebase, tracing request flow, finding module ownership, or asking what files to read next.
---

# Codebase Onboarding

Use this skill to understand a system before changing it.

## When to use codebase-onboarding vs alternatives

| Situation | Use |
|---|---|
| You need to understand request flow, boundaries, and file ownership before making changes | `codebase-onboarding` |
| You already know the subsystem and need implementation help | a domain or implementation skill |
| You need a design or architecture proposal rather than repo mapping | an architecture skill |

## Workflow

1. Read any repo instructions first: `AGENTS.md`, `README`, workspace conventions.
2. Find the entrypoint for the user-visible behavior.
3. Trace the full path through routing, handlers, services, data access, side effects, and outputs.
4. Identify:
   - owning modules
   - validation boundaries
   - auth/security boundaries
   - persistence and external integrations
   - feature flags, background jobs, or async edges
5. End with the next files worth reading before editing.

## Output contract

Produce:
- a short system map
- request/data flow in order
- top gotchas and dangerous assumptions
- exact files to read next

Use file references wherever possible.

## Starter prompts

- Explain how requests flow through `<subsystem>` in this repo. Include ownership boundaries, validation points, and the next files I should read.
- Before changing `<feature>`, map the code path from input to persistence to output and list the main risks.
- I’m new to this repo. Trace how `<user action>` works and tell me where changes should and should not be made.

## Autonomous decision rules

**Use this skill when:**
- the user asks how something works
- the task starts in an unfamiliar repo or subsystem
- the safest next step is understanding before editing

**Do NOT use when:**
- the request is already narrowly scoped to a known file change
- the task is primarily product strategy, not codebase understanding
