---
name: ralphinho-rfc-pipeline
description: RFC-driven multi-agent DAG execution pattern with quality gates, merge queues, and work unit orchestration.
origin: ECC
---

# Ralphinho RFC Pipeline

Inspired by [humanplane](https://github.com/humanplane) style RFC decomposition patterns and multi-unit orchestration workflows.

Use this skill when a feature is too large for a single agent pass and must be split into independently verifiable work units.

## When to use ralphinho-rfc-pipeline vs alternatives

| Situation | Use |
|---|---|
| You need RFC intake, DAG decomposition, unit specs, merge queues, and integration scoring | `ralphinho-rfc-pipeline` |
| You need the higher-level operating model for AI-assisted engineering | `agentic-engineering` |
| You need a generic continuous loop selector rather than an RFC DAG | `continuous-agent-loop` |
| You need a concrete runtime to dispatch missions or panes | `claude-devfleet`, `dmux-workflows` |
| You need a project plan for humans/agents across multiple sessions | `blueprint` |

## Pipeline Stages

1. RFC intake
2. DAG decomposition
3. Unit assignment
4. Unit implementation
5. Unit validation
6. Merge queue and integration
7. Final system verification

## Unit Spec Template

Each work unit should include:
- `id`
- `depends_on`
- `scope`
- `acceptance_tests`
- `risk_level`
- `rollback_plan`

## Complexity Tiers

- Tier 1: isolated file edits, deterministic tests
- Tier 2: multi-file behavior changes, moderate integration risk
- Tier 3: schema/auth/perf/security changes

## Quality Pipeline per Unit

1. research
2. implementation plan
3. implementation
4. tests
5. review
6. merge-ready report

## Merge Queue Rules

- Never merge a unit with unresolved dependency failures.
- Always rebase unit branches on latest integration branch.
- Re-run integration tests after each queued merge.

## Recovery

If a unit stalls:
- evict from active queue
- snapshot findings
- regenerate narrowed unit scope
- retry with updated constraints

## Outputs

- RFC execution log
- unit scorecards
- dependency graph snapshot
- integration risk summary
