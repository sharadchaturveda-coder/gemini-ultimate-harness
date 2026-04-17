# Claude Skill Tree

A compact index of the active global Claude skill library after cleanup.

## Core routing anchors

- `codebase-onboarding`: map unfamiliar repos before editing
- `eval-loop`: run score-driven improvement loops
- `chatgpt-apps`: plan focused ChatGPT app outcomes
- `mcp-server-patterns`: build MCP tools, resources, prompts, and transports
- `blueprint`: turn large objectives into dependency-aware execution plans
- `lessons`: preflight high-risk auth, secrets, payments, schema, and API changes
- `verification-loop`: generic post-change quality gate
- `security-review`: generic application-security fallback

## Architecture and backend

- `backend-patterns`: backend boundaries, service layers, API/server structure
- `api-design`: REST contracts, versioning, pagination, error shapes
- `database-migrations`: schema rollout, backfills, migration safety
- `deployment-patterns`: deploy pipelines, health checks, rollback patterns
- `postgres-patterns`: Postgres schema, indexing, and query patterns
- `clickhouse-io`: ClickHouse analytics and high-volume query patterns
- `jpa-patterns`: JPA/Hibernate entity and persistence patterns

## Agent systems and orchestration

- `agent-harness-construction`: action spaces, tool definitions, observation design
- `agentic-engineering`: eval-first execution and agent-sized decomposition
- `ai-first-engineering`: engineering operating model for AI-heavy teams
- `ai-regression-testing`: regression traps common in AI-generated code
- `autonomous loop stack`:
  - `continuous-agent-loop`
  - `claude-devfleet`
  - `dmux-workflows`
  - `ralphinho-rfc-pipeline`
  - `nanoclaw-repl`
  - `team-builder`
- `enterprise-agent-ops`: observability, security, and lifecycle management for long-lived agents
- `continuous-learning-v2`: instinct-based learning and promotion

## Research and knowledge

- `deep-research`: multi-source cited research
- `exa-search`: neural web and company search
- `search-first`: research-before-coding workflow
- `market-research`: market, competitor, and investor research
- `iterative-retrieval`: progressive context retrieval patterns
- `strategic-compact`: manual compaction timing guidance

## Frontend and presentations

- `frontend-patterns`: implementation patterns for React and web apps
- `frontend-slides`: HTML slide decks and PPT-to-web conversion
- `e2e-testing`: Playwright testing patterns
- `liquid-glass-design`: Apple glass-style visual language

## Media and documents

- `ffmpeg`: video/audio manipulation
- `fal-ai-media`: image, video, and audio generation through fal.ai
- `video-editing`: AI-assisted editing workflows
- `videodb`: ingest, search, clip, and transform video/audio
- `nutrient-document-processing`: OCR, conversion, redaction, signing, form fill
- `investor-materials`: decks, memos, fundraising docs
- `article-writing`: long-form written content
- `content-engine`: platform-native multi-channel content systems
- `crosspost`: adapt content across multiple social platforms

## Platform and provider skills

- `claude-api`: Anthropic API patterns
- `vercel-cli`: deployment and production operations on Vercel
- `gh-cli`: GitHub operations
- `x-api`: X/Twitter API integration

## Language and framework clusters

- Python:
  - `python-patterns`
  - `python-testing`
- Go:
  - `golang-patterns`
  - `golang-testing`
- Rust:
  - `rust-patterns`
  - `rust-testing`
- C++:
  - `cpp-coding-standards`
  - `cpp-testing`
- Java / Spring:
  - `java-coding-standards`
  - `springboot-patterns`
  - `springboot-security`
  - `springboot-tdd`
  - `springboot-verification`
- Kotlin:
  - `kotlin-patterns`
  - `kotlin-testing`
  - `kotlin-coroutines-flows`
  - `kotlin-ktor-patterns`
  - `kotlin-exposed-patterns`
- Django:
  - `django-patterns`
  - `django-security`
  - `django-tdd`
  - `django-verification`
- Laravel:
  - `laravel-patterns`
  - `laravel-security`
  - `laravel-tdd`
  - `laravel-verification`
- Swift / Apple:
  - `swiftui-patterns`
  - `swift-concurrency-6-2`
  - `swift-actor-persistence`
  - `swift-protocol-di-testing`
  - `foundation-models-on-device`
- Android / Compose:
  - `android-clean-architecture`
  - `compose-multiplatform-patterns`

## Operational and niche workflows

- `issue-tracker`: shared issue lifecycle across agent tools
- `skill-router`: route work to the right skills
- `skill-stocktake`: audit skills and commands for quality
- `create-skill`: create new reusable global skills
- `configure-ecc`: install and configure Everything Claude Code
- Domain workflows:
  - `carrier-relationship-management`
  - `customs-trade-compliance`
  - `energy-procurement`
  - `inventory-demand-planning`
  - `investor-outreach`
  - `logistics-exception-management`
  - `production-scheduling`
  - `quality-nonconformance`
  - `returns-reverse-logistics`
  - `visa-doc-translate`

## Notes

- This file is a guide, not the source of truth. Routing behavior lives in [`/home/dr_sharad/.claude/skills/skill-router/SKILL.md`](/home/dr_sharad/.claude/skills/skill-router/SKILL.md).
- Removed or broken legacy entries are intentionally not listed here.
