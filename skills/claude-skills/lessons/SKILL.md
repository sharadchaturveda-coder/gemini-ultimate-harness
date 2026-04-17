---
name: lessons
description: Production safety preflight for auth, secrets, payments, DB schema, and API route changes. USE before high-risk implementation work to avoid repeated failure modes.
user-invocable: false
---

# Lessons

Use this skill before editing high-risk surfaces: auth, passwords, API keys/secrets, payment flows, DB schema, and API route design.

## When to use lessons vs alternatives

| Situation | Use |
|---|---|
| You are about to change a high-risk boundary and need a production-safety pass first | `lessons` |
| You need repo mapping before changing code | `codebase-onboarding` |
| You need domain-specific implementation patterns after the safety pass | the relevant domain skill |

## 24 production rules

1. Validate at system boundaries only; do not scatter duplicate validation across layers.
2. Treat auth and authorization as separate decisions; authenticated is not authorized.
3. Never trust client-supplied user IDs, roles, prices, or access scope.
4. Hash passwords with a modern password hasher; never encrypt or log them.
5. Do not return whether an email, account, or reset token exists.
6. Expire and rotate reset, session, and API tokens; make replay hard by default.
7. Keep secrets only in environment variables or a secret manager, never in frontend bundles or source files.
8. Redact secrets, tokens, and PII from logs, traces, and analytics events.
9. Never expose raw stack traces or internal error objects to clients.
10. Make external webhooks and payment callbacks idempotent before shipping them.
11. Recompute price, entitlement, and fulfillment decisions on the server.
12. Persist provider IDs, timestamps, and status transitions for every payment event.
13. Plan database migrations to be forward-safe, retry-safe, and reversible where possible.
14. Backfill in explicit phases; do not combine schema change, data rewrite, and traffic cutover blindly.
15. Add constraints deliberately: nullability, foreign keys, uniqueness, and defaults must match real data.
16. Assume existing rows are dirty until proven otherwise; audit before tightening schema.
17. Prefer append-only audit records for money, identity, and permission changes.
18. Design API routes around stable resources and verbs; avoid action soup endpoints.
19. Version or stage breaking API changes; do not silently mutate existing contracts.
20. Return consistent response envelopes and consistent error shapes across routes.
21. Enforce rate limits and abuse controls on login, reset, token, and public write endpoints.
22. Use least-privilege service credentials for database, storage, and third-party integrations.
23. Do not use SQLite for serverless production workloads that need concurrent writes; use a network database such as Postgres, Supabase, or Neon.
24. Ship high-risk changes with an explicit verification plan: tests, rollback path, and observable success criteria.

## Output contract

Before implementation, produce:
- the main risks for this change
- which rules above are in play
- any required design adjustments before code is written
- the minimum verification needed before calling it done

## Autonomous decision rules

**Use this skill when:**
- the task touches auth, passwords, secrets, payment flows, DB schema, or API route design
- the safest next step is to identify production risks before coding

**Do NOT use when:**
- the task is a low-risk UI tweak or simple file operation
- the change does not cross a security, money, persistence, or API boundary
