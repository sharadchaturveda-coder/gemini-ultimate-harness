---
name: create-skill
description: 'Create a new skill file for the global skill library. USE when a reusable CLI tool, library pattern, or domain workflow is worth capturing so all agents can use it autonomously in future. Triggers on: "make this a skill", "add this as a skill", "create a skill for X", or when you identify a pattern worth capturing after repeated use.'
---

# Create Skill

## When to create a skill (vs not)

**Create a skill when:**
- A CLI tool is being used that agents would benefit from knowing autonomously
- A library has non-obvious API patterns, gotchas, or exact method signatures
- A workflow has been done manually more than once and could be triggered contextually
- User says "make this a skill" or "add this as a skill"

**Do NOT create a skill for:**
- One-off tasks or project-specific logic
- Things already well-covered by agent training data (e.g. basic git commands)
- Anything under 10 meaningful lines of guidance

---

## Step 1 — Decide scope

| Scope | Path |
|---|---|
| Global (available to all projects + all tools) | `~/.claude/skills/<name>/SKILL.md` |
| Project-only | `.claude/skills/<name>/SKILL.md` in project root |

Default to global unless the skill is tightly coupled to one codebase.

---

## Step 2 — Choose a name

- Lowercase, hyphenated: `gh-cli`, `ffmpeg`, `vercel-cli`, `browser-use`
- For CLI tools: use the binary name or `<tool>-cli`
- For library patterns: use the library name: `supabase`, `framer-motion`
- For agency personas: prefix `agency-`: `agency-security-engineer`

---

## Step 3 — Write SKILL.md

```markdown
---
name: <skill-name>
description: <one tight sentence — what it does and the exact trigger condition>
---

# <Skill Name>

## When to use <tool/pattern> vs alternatives

| Situation | Use |
|---|---|
| <specific trigger> | <this skill> |
| <alternative case> | <alternative> |

## <Core usage / commands / API>

<Exact commands, method signatures, patterns. No fluff.>

## Autonomous decision rules

**Use this skill when:**
- User says "<trigger phrase>"
- Task involves <specific context>

**Do NOT use when:**
- <counter-case>
```

### Description field rules (most important)

The `description` is what agents read to decide whether to invoke this skill. It must:
- State exactly what the tool/pattern does
- Include the trigger condition: `USE when...`
- Be one sentence, under 200 characters
- Include key synonyms users might say

Good: `"FFmpeg CLI — transcode video/audio, extract frames, clip segments. USE when task involves video/audio file manipulation."`

Bad: `"A skill for FFmpeg"` — too vague, won't trigger

### Optional frontmatter fields

| Field | When to use |
|---|---|
| `disable-model-invocation: true` | Skill should only run when user explicitly invokes it (e.g. destructive ops) |
| `user-invocable: false` | Background knowledge only, hidden from / menu |
| `allowed-tools: Read, Bash` | Tools pre-approved when skill is active |
| `context: fork` | Run in a subagent (for long/isolated tasks) |

---

## Step 4 — Wire it up

After writing the skill file, always do all of these:

### 1. Symlink into Codex
```bash
ln -s ~/.claude/skills/<name> ~/.codex/skills/<name>
```

### 2. Add to skill-router

Open `~/.claude/skills/skill-router/SKILL.md` and:

a) Add a row to the **Step 1** table:
```markdown
| <What the user is asking for> | → [<Section Name>](#<anchor>) |
```

b) Add or update a section with a routing table:
```markdown
## <Section Name>

| Sub-task | Skill |
|---|---|
| <specific need> | `<skill-name>` |
```

### 3. Commit and push
```bash
cd ~/.claude
git add skills/<name>/ skills/skill-router/SKILL.md
git commit -m "Add <name> skill + <Section> section to skill-router"
git push
```

---

## Step 5 — Verify

Check the skill appears in the skill list and description is correct:
```bash
head -4 ~/.claude/skills/<name>/SKILL.md
```

Check the symlink works:
```bash
ls -la ~/.codex/skills/<name>
```

---

## Full example — creating a skill for `imagemagick`

```bash
mkdir -p ~/.claude/skills/imagemagick
```

```markdown
---
name: imagemagick
description: ImageMagick CLI (convert/magick) — resize, crop, convert format, composite images, generate thumbnails. USE when task involves image file manipulation without a browser or canvas.
---

# ImageMagick

## When to use imagemagick vs alternatives
...
```

```bash
ln -s ~/.claude/skills/imagemagick ~/.codex/skills/imagemagick
# Add to skill-router Step 1 table + Media Processing section
cd ~/.claude && git add . && git commit -m "Add imagemagick skill" && git push
```
