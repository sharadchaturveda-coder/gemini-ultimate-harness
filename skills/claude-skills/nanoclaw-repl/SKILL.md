---
name: nanoclaw-repl
description: Operate and extend NanoClaw v2, ECC's zero-dependency session-aware REPL built on claude -p.
origin: ECC
---

# NanoClaw REPL

Use this skill when running or extending `scripts/claw.js`.

## When to use nanoclaw-repl vs alternatives

| Situation | Use |
|---|---|
| You need a persistent local markdown-backed REPL session on top of `claude -p` | `nanoclaw-repl` |
| You need continuous autonomous loop selection or recovery strategy | `continuous-agent-loop` |
| You need multi-agent orchestration across worktrees or panes | `claude-devfleet`, `dmux-workflows` |
| You need the overall AI-engineering operating model | `agentic-engineering` |

## Capabilities

- persistent markdown-backed sessions
- model switching with `/model`
- dynamic skill loading with `/load`
- session branching with `/branch`
- cross-session search with `/search`
- history compaction with `/compact`
- export to md/json/txt with `/export`
- session metrics with `/metrics`

## Operating Guidance

1. Keep sessions task-focused.
2. Branch before high-risk changes.
3. Compact after major milestones.
4. Export before sharing or archival.

## Extension Rules

- keep zero external runtime dependencies
- preserve markdown-as-database compatibility
- keep command handlers deterministic and local
