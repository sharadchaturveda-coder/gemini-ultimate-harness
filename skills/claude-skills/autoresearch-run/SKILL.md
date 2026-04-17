---
name: autoresearch-run
description: Run an active autoresearch optimization loop inside a repo with .autoresearch configured. USE when the user wants measured iterations against a scorer, not setup.
---

# Autoresearch Run

## When to use autoresearch-run vs alternatives

| Situation | Use |
|---|---|
| Repo already has `.autoresearch/` and the user wants live score-driven iteration | `autoresearch-run` |
| User wants the reusable install or scaffold added first | `autoresearch-bootstrap` |
| You only need a normal one-off benchmarked improvement pass | `eval-loop` |

## Preconditions

Only run this workflow if all of these exist in the target repo:

- `.autoresearch/program.md`
- `.autoresearch/allowlist.txt`
- `.autoresearch/run-eval.sh`
- `.autoresearch/session.md`

If they do not exist, bootstrap first with:

```bash
autoresearch-init /path/to/repo
```

## Core loop

1. Read `.autoresearch/program.md`
2. Read `.autoresearch/allowlist.txt`
3. Run `.autoresearch/run-eval.sh` to capture the baseline
4. Change one small thing inside the allowlist only
5. Re-run `.autoresearch/run-eval.sh`
6. Keep only score-improving changes
7. Log the attempt in `.autoresearch/session.md`
8. Stop when the score plateaus or the human-defined stop condition is met

## Guardrails

- Never edit files outside `.autoresearch/allowlist.txt`
- Never widen the scope mid-loop without the human approving it
- Prefer 1-3 line weight/rule changes over broad refactors
- Revert regressions immediately
- If the scorer is flaky, stop and report that the loop is not trustworthy

## Recommended command order

```bash
cd /path/to/repo
cat .autoresearch/program.md
cat .autoresearch/allowlist.txt
.autoresearch/run-eval.sh
```

Then iterate with:

- one focused edit
- one eval rerun
- one session log entry

## Session log contract

Each iteration in `.autoresearch/session.md` should record:

- hypothesis
- changed files
- baseline score
- new score
- keep or revert
- short note on what was learned

## Autonomous decision rules

**Use this skill when:**
- User says `run autoresearch`, `start autoresearch`, `optimize with autoresearch`
- The repo already has `.autoresearch/`
- A deterministic scorer exists

**Do NOT use when:**
- The scorer is missing, flaky, or purely subjective
- The target subsystem includes auth, payments, secrets, schema, or infrastructure unless explicitly allowed
- The repo has not been bootstrapped yet
