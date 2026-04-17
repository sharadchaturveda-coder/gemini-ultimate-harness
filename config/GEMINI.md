# Global Preferences

## Approach
- Solve the actual problem; don't pad solutions for impossible cases
- Minimal viable change — no refactors, docstrings, or improvements beyond what's asked
- No trailing summaries; the user can read the diff
- Short, direct responses over long explanations
- Never truncate bash output — run commands raw

## Full-Stack App Checklist
Flag proactively when building or reviewing a full-stack app:
1. SQLite on serverless — gets wiped on Vercel/Netlify. Use Supabase or Neon
2. Exposed API keys — never hardcode sk-... in frontend; .env server-side only
3. Missing loading/error states — always handle the unhappy path
4. Missing Privacy Policy — any user data collection requires /privacy before launch

## Security
- Never expose stack traces to clients
- Validate at system boundaries only
- Secrets in .env, never committed

## Code Style
- Prefer functional patterns
- Types before implementations in TypeScript
- Return shape: { data, error } for APIs unless project convention differs

## What I'm Building
This user builds AI companion experiences and agent systems — NOT games. Projects include VRM avatar companions, VTuber tools, and autonomous agents. Frame suggestions around companion UX, agent behavior, and interactive AI experiences.

---

## Pre-Implementation Protocol — Execute these steps before writing any code

This is not a guideline. These are required steps. Execute them in order.

---

### STEP A — Lessons gate (high-risk domains)

**Trigger:** Task touches any of: auth, passwords, API keys/secrets, payment flows, database schema, API route design.

**Action:** Read this file NOW, before writing a single line:
```
~/.claude/skills/lessons/SKILL.md
```
24 rules from real production mistakes. Non-negotiable. Takes 30 seconds.

If the trigger does not apply → skip to Step B.

---

### STEP B — Skill routing gate (domain implementation or specialist expertise)

**Trigger A — Domain library:** You are about to write code using VRM, Three.js, Supabase, tRPC, GSAP, Framer Motion, Rapier, ElevenLabs, shadcn-ui, Next.js App Router, browser-use, or dev-browser.

**Trigger B — Specialist expertise:** Task needs an expert methodology — architecture, security, devops, SRE, product management, game engine, marketing, AI agents, UX research, data engineering, compliance.

**Trigger C — Skill creation:** User says "make this a skill", "add this as a skill", "create a skill for X", or you identify a reusable pattern worth capturing → use `create-skill` directly (skip the decision tree).

**If either trigger applies, execute these steps in order:**

1. Read the file: `~/.claude/skills/skill-router/SKILL.md`
2. Follow the decision tree. Identify 1–3 matching skills by name.
3. Read each identified skill file: `~/.claude/skills/<skill-name>/SKILL.md`
4. Implement using the exact patterns from those files. Do not deviate.

**If neither trigger applies** (bug fix, explanation, general TS/React/CSS/HTML, file/git ops) → skip skills entirely and proceed.

---

**Never ask the user which library or expert to use.** Read skill-router and decide yourself.

## Gemini Added Memories
- OpenCLAW Mandate: Intentionally maintain a high number of skills (~20+). Do not flag as a violation of beginner tips.
- The user wants the agent to emulate the 'best of everything' from Claude Code and Codex, combining all skills and autonomous routing features. The agent should strictly follow the Antigravity Autonomous Protocol (Perceive-Resolve-Invoke-Execute), dynamically use the skill router to find the most specific specialist for a task, enforce eval-driven development (EDD) and verification loops, and always check high-risk gates (Auth/DB/API) via the 'lessons' skill before implementation.
