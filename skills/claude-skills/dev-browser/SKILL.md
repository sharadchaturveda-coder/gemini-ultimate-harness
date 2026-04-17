---
name: dev-browser
description: dev-browser — sandboxed Playwright-style browser scripts with persistent page state and Chrome attach mode. USE when browsing needs scripted control or existing authenticated Chrome state.
---

# Dev Browser

Use `dev-browser` when the browser task needs small JavaScript scripts, persistent pages, or a live Chrome session.

## When to use dev-browser vs alternatives

| Situation | Use |
|---|---|
| Task needs small scripted browser actions with Playwright-style APIs | `dev-browser` |
| Agent should keep page state across sequential scripts | `dev-browser` |
| Agent should attach to the user's running Chrome with authentication already in place | `dev-browser` |
| Task needs custom waits, locators, evaluate calls, or control flow beyond simple shell verbs | `dev-browser` |
| Agent can work step-by-step with CLI commands and accessibility refs | `agent-browser` |
| A static page can be handled by WebFetch/WebSearch faster | WebFetch/WebSearch |
| A real browser is needed but neither dedicated tool is installed | `carbonyl-browser` |

## Installation

```bash
npm install -g dev-browser
dev-browser install
```

## Core usage

Headless script:

```bash
dev-browser --headless <<'EOF'
const page = await browser.getPage("main");
await page.goto("https://example.com");
console.log(await page.title());
EOF
```

Attach to running Chrome:

```bash
dev-browser --connect <<'EOF'
const tabs = await browser.listPages();
console.log(JSON.stringify(tabs, null, 2));
EOF
```

## Operating pattern

1. Keep each script narrow: one navigation or interaction unit at a time.
2. Re-read state after each script before deciding the next move.
3. Prefer named pages when the session spans multiple scripts.
4. Use `--connect` when auth state or existing tabs matter.
5. Treat `evaluate` and custom locators as a scalpel, not the default move.

## Autonomous decision rules

**Use this skill when:**
- the browsing task needs incremental scripts rather than shell verbs
- the site is complex enough that Playwright-style selectors or waits are the cleanest move
- the agent needs to reuse authenticated browser state from the user's Chrome
- the agent must preserve named pages or tab state across a sequence of script runs

**Prefer `agent-browser` instead when:**
- the task is terminal-native browsing with obvious command verbs
- the agent can navigate from accessibility snapshots and element refs
- the simplest good solution is a sequence of `open`, `snapshot`, `click`, `fill`, and `get` commands

**Do NOT use this skill when:**
- WebFetch/WebSearch can answer the question faster
- the task is simple enough that a script wrapper would add friction
- attaching to the user's Chrome would create unnecessary risk for a non-authenticated task
