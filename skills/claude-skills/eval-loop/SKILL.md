---
name: eval-loop
description: Run score-driven improvement loops. USE when a task has a script, grader, benchmark, or reviewable artifact that can be measured across iterations.
---

# Eval Loop

Use this skill when one-shot changes are weaker than repeated measured improvement.

## When to use eval-loop vs alternatives

| Situation | Use |
|---|---|
| There is a scoring command, grader, benchmark, or review loop | `eval-loop` |
| You only need basic post-change checks | `verification-loop` |
| You are defining a long-term eval framework from scratch | `eval-harness` |

## Workflow

1. Read repo instructions first.
2. Find the current scoring mechanism:
   - test command
   - benchmark script
   - lint/build gate
   - model grader
   - human-review artifact
3. Record the baseline score before changing anything.
4. Improve one thing at a time.
5. Re-run the eval after every meaningful change.
6. Keep a short log of:
   - change made
   - new score
   - whether the change helped
7. Stop when:
   - score target is met
   - results plateau
   - additional gains require a different strategy

## Output contract

Produce:
- baseline
- iteration log
- current best result
- remaining bottlenecks
- final recommendation

## Guardrails

- Prefer deterministic graders over subjective ones when possible.
- Never claim improvement without re-running the eval.
- If there is no real scorer, define the weakest acceptable proxy and say it is a proxy.
- Keep changes focused; avoid refactors that obscure the effect of a single iteration.

## Starter prompts

- Run this as an eval-driven improvement loop. Find the scoring command, baseline it, make focused improvements, and log each score change.
- Improve `<artifact>` until the benchmark stops improving. One focused change per iteration.
- Treat this task as measured optimization, not a one-shot patch.

## Autonomous decision rules

**Use this skill when:**
- the user wants iteration, optimization, or benchmarking
- there is a measurable command or review artifact
- quality depends on repeated attempts rather than a single edit

**Do NOT use when:**
- the task is a simple bug fix with obvious verification
- no meaningful score or review loop exists and inventing one would be artificial
