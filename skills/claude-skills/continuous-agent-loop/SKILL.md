---
name: continuous-agent-loop
description: Patterns for continuous autonomous agent loops with quality gates, evals, and recovery controls.
origin: ECC
---

# Continuous Agent Loop

Use this skill to choose and run loop patterns for repeated autonomous execution with evals, gates, and recovery controls.

## When to use continuous-agent-loop vs alternatives

| Situation | Use |
|---|---|
| You are choosing between sequential, RFC-driven, CI-driven, or exploratory continuous loop patterns | `continuous-agent-loop` |
| You need the overall engineering operating model for agent-first delivery | `agentic-engineering` |
| You are designing tool schemas and observation contracts | `agent-harness-construction` |
| You need an RFC/DAG execution pattern specifically | `ralphinho-rfc-pipeline` |
| You need a persistent local REPL session rather than a loop architecture | `nanoclaw-repl` |
| You are running agents in a concrete orchestration runtime | `claude-devfleet`, `dmux-workflows` |

## Loop Selection Flow

```text
Start
  |
  +-- Need strict CI/PR control? -- yes --> continuous-pr
  |                                    
  +-- Need RFC decomposition? -- yes --> rfc-dag
  |
  +-- Need exploratory parallel generation? -- yes --> infinite
  |
  +-- default --> sequential
```

## Combined Pattern

Recommended production stack:
1. RFC decomposition (`ralphinho-rfc-pipeline`)
2. quality gates (`plankton-code-quality` + `/quality-gate`)
3. eval loop (`eval-harness`)
4. session persistence (`nanoclaw-repl`)

## Failure Modes

- loop churn without measurable progress
- repeated retries with same root cause
- merge queue stalls
- cost drift from unbounded escalation

## Recovery

- freeze loop
- run `/harness-audit`
- reduce scope to failing unit
- replay with explicit acceptance criteria
