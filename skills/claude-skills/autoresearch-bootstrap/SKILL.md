---
name: autoresearch-bootstrap
description: Project-agnostic autoresearch setup for any repo with a measurable scorer. USE when the user wants to install, initialize, or run an autoresearch loop on demand.
---

# Autoresearch Bootstrap

## When to use autoresearch-bootstrap vs alternatives

| Situation | Use |
|---|---|
| User wants a reusable local autoresearch install or per-project bootstrap | `autoresearch-bootstrap` |
| Repo already has a scorer and you are actively tuning it | `eval-loop` |
| User wants architecture help for the target subsystem before adding a scorer | `codebase-onboarding` |

## Core idea

Autoresearch is not tied to LLM training.

Treat it as a four-part loop:

1. Define a **tight edit surface**
2. Define a **deterministic scorer**
3. Let the agent propose a small change
4. Keep only changes that improve the score without violating guardrails

For non-ML codebases, the repo needs:

- one command that returns pass/fail or a numeric score
- a file or folder the agent is allowed to edit
- a prompt/program file that states constraints

## Local install layout

Expected local assets:

- `~/.local/share/autoresearch/upstream/`
- `~/.local/share/autoresearch/templates/`
- `~/.local/bin/autoresearch-init`

## Bootstrap command

```bash
autoresearch-init /path/to/repo
```

This should create:

- `.autoresearch/README.md`
- `.autoresearch/program.md`
- `.autoresearch/session.md`
- `.autoresearch/allowlist.txt`
- `.autoresearch/run-eval.sh`

## How to use in a target repo

1. Run `autoresearch-init /path/to/repo`
2. Edit `.autoresearch/run-eval.sh` to call the real scorer
3. Edit `.autoresearch/allowlist.txt` with the exact editable paths
4. Edit `.autoresearch/program.md` with repo-specific constraints
5. Point the coding agent at `.autoresearch/program.md`

## Guardrails

- Do not use autoresearch where no real scorer exists
- Do not let the agent edit auth, secrets, payments, schema, or infra by default
- Prefer one narrow subsystem per session
- Keep the loop local to the target repo, not global

## Autonomous decision rules

**Use this skill when:**
- User says `install autoresearch`, `set up autoresearch`, `make this project autoresearch-ready`
- Task is to make autoresearch reusable across repos
- Repo has or can support a measurable benchmark

**Do NOT use when:**
- The task is just to improve a scorer inside one known repo
- The target work is subjective UX/product design with no deterministic eval
