---
name: nia-context-router
description: Nia context router — choose local grep, indexed Nia sources, or web discovery with minimal context. USE when tasks need external docs, repos, packages, or source indexing.
user-invocable: false
allowed-tools: Read,Bash
---

# Nia Context Router

Use this skill to keep retrieval tight. The goal is to answer with the smallest correct context, not to shovel whole docs into the prompt.

## When to use Nia vs alternatives

| Situation | Use |
|---|---|
| Need truth from the current repo | `rg`, file reads, local inspection |
| Need truth from a known external docs site or indexed source | Nia |
| Need truth from a known repo outside the current workspace | Nia repo indexing/search |
| Need package source inspection without cloning | Nia package search |
| Need discovery because the source is unknown | web search first, then Nia |
| Need latest news, pricing, schedules, or unstable facts | web search with citations |

## Core rule

Always use this retrieval ladder:

1. Local code
2. Indexed Nia source
3. Index known source into Nia
4. Web search to discover source
5. Index discovered source into Nia if follow-up work will continue

Do not skip to web search if the source is already known.

## Autonomous decision rules

Use this skill when:
- The task needs official docs, package internals, external repo code, or PDFs
- The task mentions a library, framework, API, SDK, CLI, or hosted service not fully present in the repo
- The task needs repeated lookups against the same external source
- The task needs source-grounded answers while keeping context small

Do NOT use when:
- The answer is already in the current repo
- The task is pure editing, rewriting, or local refactoring with no external source dependency
- The task is primarily about current events or broad market discovery

## Tree traversal workflow

Follow this exact order.

### A. Local-first check

Start with local inspection:

```bash
rg "symbol|config|route|env|pattern" .
```

If the repo already contains the answer or a strong implementation pattern, stop here.

### B. Check whether Nia already has the source

For docs and data sources:

```bash
./scripts/sources.sh list
./scripts/sources.sh resolve "<url-or-name>"
```

For repos:

```bash
./scripts/repos.sh list
./scripts/repos.sh status <owner/repo>
```

### C. Traverse structure before reading content

Never read blind. Inspect the tree first, then grep, then read the smallest relevant slice.

Docs:

```bash
./scripts/sources.sh tree <source_id>
./scripts/sources.sh grep <source_id> "<pattern>"
./scripts/sources.sh read <source_id> <path> [line_start] [line_end]
```

Repos:

```bash
./scripts/repos.sh tree <owner/repo>
./scripts/repos.sh grep <owner/repo> "<pattern>" [path_prefix]
./scripts/repos.sh read <owner/repo> <path/to/file>
```

Packages:

```bash
./scripts/packages.sh grep <registry> <package> "<pattern>" [version]
./scripts/packages.sh read <registry> <package> <file_sha256> <start> <end>
```

### D. Index only when the source is known and missing

Docs:

```bash
./scripts/sources.sh index "https://docs.example.com"
```

Repos:

```bash
./scripts/repos.sh index <owner/repo> [branch] [display_name]
```

Papers and datasets:

```bash
./scripts/papers.sh index <arxiv_url_or_id>
./scripts/datasets.sh index <dataset> [config]
```

After indexing, re-run `list` or `status`, then continue with tree -> grep -> read.

### E. Use web only for discovery or freshness

Use web search when:
- You do not know the source yet
- The task depends on current facts
- You need to compare multiple providers or vendors

If web search identifies a canonical docs source and follow-up work depends on it, index that source into Nia before doing deeper retrieval.

## Minimal context rules

- Prefer `tree` before `read`
- Prefer `grep` before large reads
- Read the smallest relevant page or file segment
- Avoid pasting raw docs into the working context unless exact wording matters
- Summarize findings into short notes instead of re-reading the same source repeatedly
- If multiple sources say the same thing, keep the primary source only

## Fast patterns

### Known docs site

```bash
./scripts/sources.sh resolve "https://docs.example.com"
./scripts/sources.sh tree <source_id>
./scripts/sources.sh grep <source_id> "specific API or concept"
./scripts/sources.sh read <source_id> <path> 1 160
```

### Known external repo

```bash
./scripts/repos.sh status owner/repo
./scripts/repos.sh tree owner/repo
./scripts/repos.sh grep owner/repo "symbol_name" src
./scripts/repos.sh read owner/repo src/path/file.ts
```

### Unknown source

1. Web search to find the canonical docs or repo
2. Index it in Nia if the task will continue past one lookup
3. Continue with tree -> grep -> read

## Failure handling

- If Nia scripts are unavailable in the current environment, fall back to direct web/documentation browsing and keep the same retrieval ladder concept
- If indexing is pending, do not guess from memory; use web search temporarily and come back to Nia when ready
- If local code and external docs disagree, prefer the source that controls runtime behavior, then call out the mismatch explicitly
