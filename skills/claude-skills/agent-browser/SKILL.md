---
name: agent-browser
description: agent-browser CLI — terminal-native browser automation with accessibility snapshots and shell commands. USE when agents need fast step-by-step web browsing from the terminal.
---

# Agent Browser

Use `agent-browser` when the task is best expressed as shell commands instead of embedded scripts.

## When to use agent-browser vs alternatives

| Situation | Use |
|---|---|
| Agent needs imperative browser actions from the terminal: open, snapshot, click, fill, extract text, screenshot | `agent-browser` |
| Agent should inspect page state after each action and decide the next command | `agent-browser` |
| Agent can work from accessibility refs instead of writing selectors or JavaScript | `agent-browser` |
| Task needs richer Playwright-style scripting, persistent named pages, or attaching to an already-authenticated Chrome session | `dev-browser` |
| A static page can be handled by WebFetch/WebSearch faster | WebFetch/WebSearch |
| A JS-heavy page needs a real browser but neither `agent-browser` nor `dev-browser` is installed | `carbonyl-browser` |

## Installation

```bash
npm install -g agent-browser
agent-browser install
```

## Core commands

```bash
agent-browser open https://example.com
agent-browser snapshot
agent-browser click @e2
agent-browser fill @e3 "test@example.com"
agent-browser get text @e1
agent-browser screenshot
agent-browser close
```

## Operating pattern

1. Open the page.
2. Run `snapshot` to get the accessibility tree and element refs.
3. Act using refs first: `@e2`, `@e3`, etc.
4. Re-snapshot after meaningful UI changes.
5. Use `get text`, `get html`, or screenshots to verify state before taking side effects.

## Autonomous decision rules

**Use this skill when:**
- the user wants terminal-first browsing or browser automation from the shell
- the task is research, extraction, navigation, or form interaction one step at a time
- the browser workflow maps cleanly to CLI verbs instead of a script body
- the agent should prefer accessibility refs over handwritten selectors

**Prefer `dev-browser` instead when:**
- the task needs small sandboxed JavaScript scripts between steps
- the task benefits from Playwright-style locators or custom wait logic
- the agent should attach to the user's existing Chrome session with login state already present

**Do NOT use this skill when:**
- WebFetch/WebSearch can answer faster without a real browser
- the site requires deep custom scripting that would be awkward as many shell invocations
- the tool is not installed and another browser skill can do the job immediately
