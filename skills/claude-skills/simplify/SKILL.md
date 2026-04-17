---
name: simplify
description: Simplify code, prompts, docs, plans, or workflows by removing unnecessary complexity while preserving the core outcome. USE when user says simplify, streamline, trim, reduce complexity, or make it easier.
---

# Simplify

## When to use simplify vs alternatives

| Situation | Use |
|---|---|
| User wants fewer moving parts, less indirection, or a smaller solution | `simplify` |
| User wants a shorter explanation without changing the underlying system | concise normal response or summarization |
| User wants visual cleanup or lighter UI styling | `distill`, `normalize`, `clarify`, `polish` |
| User wants optimization through measurement | `eval-loop` |

## Core approach

1. Identify the real outcome that must survive the rewrite.
2. Remove non-essential steps, abstractions, branches, files, or words.
3. Prefer fewer concepts over cleverness.
4. Preserve behavior unless the user explicitly asks for behavioral change.
5. If simplification creates a tradeoff, state it plainly.

## Simplification patterns

### Code

- Collapse unnecessary indirection.
- Remove dead configuration and duplicate helpers.
- Prefer a direct data flow over generic abstraction.
- Keep types and names clear; do not obfuscate for terseness.

### Prompts and docs

- Cut throat-clearing, repetition, and soft qualifiers.
- Replace multi-step prose with crisp instructions when possible.
- Keep the minimum context needed to preserve correctness.

### Plans and workflows

- Reduce handoffs and dependencies.
- Merge steps that do not need separate ownership.
- Prefer the shortest path that is still safe and testable.

## Autonomous decision rules

**Use this skill when:**
- The user says `simplify`, `streamline`, `trim`, `reduce complexity`, `make this easier`, or similar.
- The task is bloated by extra abstraction, copy, steps, or options.

**Do NOT use when:**
- The user wants aggressive optimization, not simplification.
- The task needs feature expansion or architecture exploration.
- Simplification would silently drop required behavior, safety checks, or constraints.

## Output expectations

- Say what got removed or collapsed.
- Preserve the important outcome.
- Keep the new version obviously easier to read, change, or operate.
