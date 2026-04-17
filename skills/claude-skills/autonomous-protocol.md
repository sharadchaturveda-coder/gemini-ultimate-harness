# 🛠️ Antigravity Autonomous Skill Protocol

Protocol for AI agents to intelligently resolve and invoke specialized skills.

## 1. Perceive (Planning Phase)
Before implementing any feature, analyze the requirements for domain-specific keywords:
- **3D/Avatars**: VRM, Three.js, glTF, rigging, expressions.
- **Frontend**: shadcn, Tailwind, Framer Motion, animations, GSAP.
- **Backend**: Supabase, tRPC, Next.js Server Actions, API routes.
- **Agent/AI**: LLM streaming, personality, companion, voice, TTS/STT.

## 2. Resolve (Mapping)
Consult the **Global Skill Tree** (`~/.claude/skills/skill-tree.md`) to identify the required skills.
- Use the hierarchical structure to find specific modules (e.g., `vrm-companion` → `threevrm-lipsync`).
- **Always** include `lessons` for high-risk domains (Auth/DB/API).

## 3. Invoke (Loading)
Load the identified `SKILL.md` files **at the start of the task**.
- Use `view_file` to read the specific instructions and patterns.
- Do **not** read all skills at once; only those resolved in step 2.

## 4. Execute
Implement using the exact patterns and guards found in the invoked skills.
- Prioritize skill patterns over generic coding practices.
- Use `audit` or `critique` skills for post-implementation verification.
