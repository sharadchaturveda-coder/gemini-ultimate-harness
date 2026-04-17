---
name: repo-knowledge-pack
description: Turn a repo's stable architecture, runbooks, gotchas, and conventions into reusable skills for Claude and Codex. USE when packaging project knowledge for repeated agent use.
---

# Repo Knowledge Pack

## When to use this vs alternatives

| Situation | Use |
|---|---|
| Need a reusable agent-facing knowledge layer for one repo | `repo-knowledge-pack` |
| Need to understand an unfamiliar repo once before editing | `codebase-onboarding` |
| Need to create a general-purpose non-repo skill | `create-skill` |

## What this creates

- Repo docs in `docs/ai/` for stable knowledge:
  - `repo-overview.md`
  - `runbook.md`
  - `gotchas.md`
  - `patterns.md`
- A project-local skill in `.claude/skills/<repo>-knowledge/SKILL.md`
- Global symlinks so both Claude and Codex can see the repo skill:
  - `~/.claude/skills/<repo>-knowledge`
  - `~/.codex/skills/<repo>-knowledge`

## CLI

Run this from a repo root:

```bash
repo-skillify
```

Useful flags:

```bash
repo-skillify --name companion-core
repo-skillify --force
repo-skillify --no-global-links
```

## Autonomous decision rules

**Use this skill when:**
- User asks to package repo knowledge as a skill
- Repo-specific operational knowledge keeps getting repeated manually
- The durable knowledge belongs in docs plus thin routing instructions

**Do NOT use when:**
- The knowledge is one-off and not worth maintaining
- The request is just to inspect a repo right now
- The material is mostly volatile runtime state rather than stable patterns

## Content rules

- Put stable facts in `docs/ai/*`, not in the skill body.
- Keep the skill thin: tell the agent what docs to open and when.
- Document commands and failure recovery in `runbook.md`.
- Document non-obvious invariants and footguns in `gotchas.md`.
- Document local coding conventions in `patterns.md`.
