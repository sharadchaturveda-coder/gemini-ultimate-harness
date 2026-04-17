---
name: skill-router
description: Route work to the right skills. USE when deciding which global skill or workflow wrapper should handle a task.
user-invocable: false
---

# Skill Router

Use this file to choose the smallest set of relevant skills for a task.

## Quick routing

| What the user is asking for | Route to |
|---|---|
| Understand an unfamiliar repo or subsystem before editing | `codebase-onboarding` |
| Improve something through repeated measurement or scoring | `eval-loop` |
| Plan or scaffold a narrow ChatGPT app outcome | `chatgpt-apps` |
| Build or audit an MCP server or tool surface | `mcp-server-patterns` |
| Review code, PRs, or diffs for bugs and regressions | `verification-loop`, `ai-regression-testing` |
| Browse the web from the terminal or automate a real browser for an agent | `agent-browser`, `dev-browser`, `carbonyl-browser` |
| Generate PPTX, PDF, DOCX, or XLSX artifacts | `frontend-slides`, `nutrient-document-processing`, `investor-materials` |
| Build frontend UI from briefs or screenshots | `frontend-design`, `frontend-patterns` |
| Turn a reference site's look into a reusable repo-root visual spec for agents | `design-md` |
| Simplify code, prompts, docs, plans, or workflows | `simplify` |
| Need current provider/API guidance with citations | `claude-api`, `deep-research`, `exa-search` |
| Need docs-aware retrieval with minimal context across local code, indexed sources, and discovery | `nia-context-router` |
| Turn specs into executable tasks and dependency-aware plans | `blueprint` |
| Keep one live-updating spec file as the active source of truth during planning and implementation | `live-spec` |
| Begin implementing from a plan while maintaining live checklists and sub-checklists | `live-spec` |
| Make a high-risk auth, secrets, payments, schema, or API change safely | `lessons` |
| Choose architecture boundaries, backend contracts, or deploy automation | `backend-patterns`, `api-design`, `deployment-patterns` |
| Install or bootstrap a reusable autoresearch workflow for any repo | `autoresearch-bootstrap` |
| Run a live autoresearch loop inside a repo that already has a scorer and allowlist | `autoresearch-run` |
| Package repo-specific architecture, runbooks, and conventions as reusable agent skills | `repo-knowledge-pack` |

## Repo understanding

| Sub-task | Skill |
|---|---|
| Map request flow and module ownership | `codebase-onboarding` |
| Explain validation/auth/data boundaries | `codebase-onboarding` |
| Propose structural changes after onboarding | `backend-patterns` |
| Scaffold repo docs plus a reusable project knowledge skill for Claude and Codex | `repo-knowledge-pack` |

## Eval and verification

| Sub-task | Skill |
|---|---|
| Repeated improvement against a scorer | `eval-loop` |
| Define a formal eval framework | `eval-harness` |
| Run post-change quality gates | `verification-loop` |
| Catch regressions common in AI-generated code | `ai-regression-testing` |
| Install local autoresearch scaffolding for reuse across repos | `autoresearch-bootstrap` |
| Run measured autoresearch iterations inside an already-bootstrapped repo | `autoresearch-run` |

## Agent and MCP products

| Sub-task | Skill |
|---|---|
| Plan a ChatGPT app around one user outcome | `chatgpt-apps` |
| Design MCP tools/resources/prompts | `mcp-server-patterns` |
| Implement MCP server details and transport patterns | `mcp-server-patterns` |
| Verify current provider behavior and docs | `claude-api`, `deep-research` |

## Browser automation

| Sub-task | Skill |
|---|---|
| Terminal-first browsing with imperative CLI steps like open/snapshot/click/fill/get | `agent-browser` |
| Accessibility-tree-driven browsing where the agent should act on refs and reassess after each step | `agent-browser` |
| Playwright-style scripted control with persistent named pages | `dev-browser` |
| Attach to the user's existing Chrome session with authentication already in place | `dev-browser` |
| Real browser fallback when dedicated browser tools are unavailable or WebFetch cannot handle the page | `carbonyl-browser` |
| Static, fetchable page that does not need a real browser | WebFetch/WebSearch |

## Architecture

| Sub-task | Skill |
|---|---|
| Choose overall system shape and backend boundaries | `backend-patterns` |
| Design REST APIs and service contracts | `api-design` |
| Plan schema changes and rollout safety | `database-migrations` |
| Build CI/CD or deploy automation | `deployment-patterns` |
| Orchestrate complex multi-session engineering plans | `blueprint` |

## Code review and risk

| Sub-task | Skill |
|---|---|
| Run a pre-implementation safety pass for auth, secrets, payments, schema, or API routes | `lessons` |
| Review diffs for regressions and missing tests | `verification-loop`, `ai-regression-testing` |
| Test APIs, contracts, and integration edges | `api-design`, `verification-loop` |
| Security-focused architecture or threat review | `security-review` |
| Scan Claude configuration for security issues | `security-scan` |
| Evidence-heavy post-change verification | `verification-loop` |

## Data and reporting

| Sub-task | Skill |
|---|---|
| Build document extraction, OCR, redaction, or file conversion flows | `nutrient-document-processing` |
| Package stakeholder-facing decks or fundraising docs | `frontend-slides`, `investor-materials` |
| Do research-backed market or industry reporting | `market-research` |
| Create HTML slide decks | `frontend-slides` |

## Delivery planning

| Sub-task | Skill |
|---|---|
| Maintain a single living spec file during execution | `live-spec` |
| Start planning work by creating or refreshing `docs/live-spec.md` | `live-spec` |
| Start implementation by refreshing the live spec and expanding active sub-checklists | `live-spec` |
| Keep implementation progress, checklists, and sub-checklists live while coding | `live-spec` |
| Break a project into tasks and phases | `blueprint` |
| Sequence dependencies and identify blockers | `blueprint` |
| Coordinate multiple parallel agent sessions | `claude-devfleet`, `dmux-workflows`, `team-builder` |
| Choose evaluation-driven execution strategy | `agentic-engineering` |

## Agent systems

| Sub-task | Skill |
|---|---|
| Define the operating model for AI-assisted engineering work | `agentic-engineering` |
| Design tool schemas, observations, and recovery contracts | `agent-harness-construction` |
| Choose loop architecture and recovery flow | `continuous-agent-loop` |
| Run Claude-native worktree missions with structured reports | `claude-devfleet` |
| Run pane-based parallel work across mixed harnesses | `dmux-workflows` |
| Pick and compose agent personas before dispatch | `team-builder` |
| Decompose a large feature into RFC-scoped DAG work units | `ralphinho-rfc-pipeline` |
| Use or extend a persistent local REPL on top of `claude -p` | `nanoclaw-repl` |
| Operate deployed long-lived agent systems | `enterprise-agent-ops` |
| Give agents autonomous browser choice based on task shape | `agent-browser`, `dev-browser`, `carbonyl-browser` |

## Retrieval routing

| Sub-task | Skill |
|---|---|
| Decide whether to use local grep, Nia, or web search | `nia-context-router` |
| Traverse indexed docs or repos without bloating context | `nia-context-router` |
| Index a known source, then search it deterministically | `nia-context-router` |
| Keep external-doc retrieval minimal and source-grounded | `nia-context-router` |

## Frontend and product

| Sub-task | Skill |
|---|---|
| Create or use a repo-root `DESIGN.md` visual contract for agents | `design-md` |
| Turn a reference site or inspiration board into reusable design guidance | `design-md` |
| Build custom UI from scratch | `frontend-design` |
| Implement app UI in an existing frontend stack | `frontend-patterns` |
| Add responsive behavior and polish | `adapt`, `polish`, `normalize`, `harden` |

## Simplification

| Sub-task | Skill |
|---|---|
| Reduce code indirection without changing the core behavior | `simplify` |
| Trim prompts, docs, or plans to the smallest correct version | `simplify` |
| Remove unnecessary workflow steps or handoffs | `simplify` |

## Routing rules

- Prefer workflow-first skills over broad persona skills when both fit.
- Use the fewest skills that fully cover the job.
- Start with onboarding if the repo or subsystem is unfamiliar.
- Pair `eval-loop` or `verification-loop` with implementation work when quality depends on measurement.
- For browser work: prefer WebFetch/WebSearch first for simple fetchable pages, then `agent-browser` for terminal-native imperative browsing, then `dev-browser` for scripted or authenticated Chrome flows, with `carbonyl-browser` as a real-browser fallback.
