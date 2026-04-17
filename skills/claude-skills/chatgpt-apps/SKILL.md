---
name: chatgpt-apps
description: Plan and scaffold focused ChatGPT apps. USE when defining MCP tools, optional widgets, auth, and deployment for a narrow ChatGPT app outcome.
---

# ChatGPT Apps

Use this skill to turn a narrow user outcome into a ChatGPT app plan or implementation.

## When to use chatgpt-apps vs alternatives

| Situation | Use |
|---|---|
| You are defining tools, MCP resources, widgets, auth, and deployment for a ChatGPT app | `chatgpt-apps` |
| You only need generic MCP server implementation details | `mcp-server-patterns` |
| You need current product/API guidance from provider docs | `deep-research` or `exa-search` |

## Workflow

1. Pull current provider guidance first with `deep-research` or `exa-search`.
2. Start with one core user outcome, not a platform-sized scope.
3. Define the tool surface:
   - 3-5 tools max for v1
   - clear names
   - exact inputs and outputs
   - obvious error cases
4. Decide whether v1 needs:
   - data-only tools
   - a widget
   - auth
   - external state
5. Scaffold the MCP server only after the tool contract is clear.
6. Call out deployment, local testing, and production risks.

## Output contract

Produce:
- core user outcome
- tool plan
- widget decision
- auth decision
- proposed file tree
- test plan
- deployment notes

## Guardrails

- Prefer the smallest useful v1.
- Avoid adding widgets unless the user outcome actually benefits from UI.
- Keep tool descriptions agent-friendly and specific.
- Separate product planning from implementation details.

## Starter prompts

- Plan a ChatGPT app for `<use case>`. Start with one core outcome, propose 3-5 tools, decide whether v1 needs a widget, and call out auth and deployment.
- Scaffold the MCP server for this ChatGPT app after defining the tool contract.
- Audit this repo and tell me whether it should become a ChatGPT app, an MCP server, or both.

## Autonomous decision rules

**Use this skill when:**
- the user mentions ChatGPT apps, Apps SDK, MCP tools for ChatGPT, widgets, or developer mode
- the task is productizing a narrow tool flow into ChatGPT

**Do NOT use when:**
- the task is just a generic API integration
- the user only needs a standalone MCP server with no ChatGPT app surface
