---
name: design-md
description: DESIGN.md workflow for AI-built UI using Google Stitch style design-system markdown. USE when a task needs a reusable visual spec, style cloning, or repo-root design guidance for agents.
---

# DESIGN.md

## When to use DESIGN.md vs alternatives

| Situation | Use |
|---|---|
| User wants a site/page to match a specific visual style across multiple prompts or files | `design-md` |
| Project needs a repo-root style contract agents can read before generating UI | `design-md` |
| User shares a design inspiration site and wants it operationalized for agents | `design-md` |
| Work is one isolated component with no reusable visual system | `frontend-design` or direct implementation |
| Existing project already has strong design tokens/components and only needs small polish | `normalize`, `polish`, `arrange`, `typeset` |

## What DESIGN.md is

`DESIGN.md` is a plain markdown design-system file popularized by Google Stitch. It gives coding agents a compact visual contract for how a project should look and feel.

Treat it as:
- A repo-root visual specification
- A style guardrail for future UI work
- A bridge between inspiration sites and implementation prompts

Do not treat it as:
- A replacement for product requirements
- A substitute for accessibility review
- A magic pixel-perfect guarantee without implementation judgment

## Core workflow

1. Identify the visual target.
2. Create or select a `DESIGN.md` that captures the target system.
3. Place `DESIGN.md` in the project root when the guidance should steer the whole repo.
4. Read it before generating UI.
5. Implement UI using the stack already present in the repo.
6. Keep the resulting code aligned to the document unless the user asks to diverge.

## Sourcing a DESIGN.md

When the user wants an existing style quickly, prefer the VoltAgent collection:
- Repo: `https://github.com/VoltAgent/awesome-design-md`
- Path pattern: `design-md/<site>/DESIGN.md`

Useful examples from the collection:
- `vercel`
- `claude`
- `supabase`
- `linear.app`
- `framer`
- `notion`
- `stripe`

If no close match exists, write a project-specific `DESIGN.md` from the user brief or reference site.

## Implementation rules

- Put the file at project root as `DESIGN.md` when it should influence the whole product.
- Preserve the existing stack, component model, and routing structure.
- Translate the document into local tokens, CSS variables, typography scales, spacing rules, and component states.
- Prefer exact color, spacing, and type rules from `DESIGN.md` over generic design instincts.
- If the repo already has a design system, merge carefully instead of replacing it blindly.
- Keep accessibility intact even when the reference style is visually extreme.

## Recommended prompt pattern

Use prompts in this shape when implementing:

```text
Read DESIGN.md from the project root and implement this UI to match it closely.
Preserve the existing stack and component architecture.
Follow the typography, color, spacing, radius, shadow, and interaction rules from DESIGN.md.
```

For a specific page:

```text
Use DESIGN.md as the visual source of truth and build <page/component>.
Match the mood and component styling, but keep the product requirements and accessibility behavior intact.
```

## Pairing rules

Pair `design-md` with:
- `frontend-design` when building new UI from scratch
- `frontend-patterns` when adapting within an existing frontend codebase
- `adapt` for responsive behavior
- `polish` after the core implementation is in place

Do not use `design-md` alone as a replacement for implementation skills.

## Autonomous decision rules

**Use this skill when:**
- User says `DESIGN.md`
- User references Google Stitch design markdown
- User wants to clone or emulate a site's visual language in a reusable way
- User wants a style guide that coding agents can follow from repo context

**Do NOT use when:**
- The task is backend-only
- The user only wants a one-line color suggestion
- The project already has a settled design system and the user only asked for a tiny fix
