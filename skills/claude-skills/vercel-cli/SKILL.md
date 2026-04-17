---
name: vercel-cli
description: Vercel CLI — deploy projects, manage env vars, inspect deployments, view logs, manage domains. USE when deploying to Vercel or diagnosing production issues. PREFER over manual dashboard for anything scriptable.
---

# Vercel CLI

## When to use vercel CLI vs alternatives

| Situation | Use |
|---|---|
| Deploy current project | `vercel` or `vercel --prod` |
| Check deployment status / URL | `vercel ls` or `vercel inspect` |
| View production logs | `vercel logs` |
| Add/update env vars without touching dashboard | `vercel env` |
| Pull remote env vars to local `.env` | `vercel env pull` |
| Promote a preview deployment to production | `vercel promote` |
| Rollback production to a previous deployment | `vercel rollback` |
| Link a local folder to a Vercel project | `vercel link` |
| Add a custom domain | `vercel domains` |
| Git push triggers auto-deploy | don't use CLI, just push |

## Auth check

```bash
vercel whoami
```

If not logged in:
```bash
vercel login
```

## Deploy

```bash
# Preview deployment (safe — doesn't affect production)
vercel

# Production deployment
vercel --prod

# Deploy a specific directory
vercel ./dist --prod

# Deploy without prompts (CI/script use)
vercel --prod --yes
```

## Link a project

Run once in a project directory to connect it to a Vercel project:
```bash
vercel link
```

## List and inspect deployments

```bash
vercel ls                          # list recent deployments for linked project
vercel ls my-project               # list for named project
vercel inspect <deployment-url>    # full detail on a deployment
vercel inspect <deployment-url> --wait  # wait until deployment is ready
```

## Logs

```bash
vercel logs <deployment-url>       # logs for a specific deployment
vercel logs <deployment-url> --follow   # stream live logs
vercel logs https://my-app.vercel.app   # production logs
```

## Environment variables

```bash
# List env vars
vercel env ls

# Add an env var
vercel env add SECRET_KEY          # prompts for value + environments

# Add for specific environment (production / preview / development)
vercel env add NEXT_PUBLIC_API_URL production

# Remove an env var
vercel env rm SECRET_KEY

# Pull all env vars to local .env.local (safe — doesn't overwrite .env)
vercel env pull .env.local
```

> CRITICAL: Never commit env vars pulled by `vercel env pull`. Add `.env.local` to `.gitignore`.

## Promote and rollback

```bash
# Promote a preview URL to production (zero-downtime swap)
vercel promote <preview-url>

# Rollback production to previous deployment
vercel rollback

# Rollback to a specific deployment
vercel rollback <deployment-url>
```

## Domains

```bash
vercel domains ls                  # list domains for current project
vercel domains add my-domain.com   # add a domain
vercel domains rm my-domain.com    # remove a domain
```

## Dev server (local)

```bash
vercel dev                         # local dev with Vercel env vars injected
```

Prefer `npm run dev` for Next.js — use `vercel dev` only when you need Vercel-specific middleware or edge function behavior locally.

## Autonomous decision rules

**Use `vercel --prod`** when:
- User says "deploy", "ship this", "push to production", "go live"

**Use `vercel env pull`** when:
- Setting up a fresh clone and need env vars from production

**Use `vercel logs`** when:
- User reports a production error, 500, or unexpected behavior
- Debugging something that only happens in production

**Use `vercel rollback`** when:
- User says "revert", "something broke after deploy", "roll back"

**Use `vercel ls` + `vercel inspect`** when:
- User asks "is it deployed?", "what's the current URL?", "which version is live?"

## Common patterns

```bash
# After finishing a feature — deploy preview, check it, then promote
vercel
vercel ls  # grab preview URL
# ... test the preview ...
vercel promote <preview-url>

# Production is broken — roll back immediately
vercel rollback

# Fresh machine / new clone — pull env vars first
vercel link
vercel env pull .env.local
npm run dev

# Check what's wrong in production
vercel logs https://my-app.vercel.app --follow
```

## Flags reference

| Flag | Meaning |
|---|---|
| `--prod` | Deploy to production |
| `--yes` | Skip all prompts |
| `--follow` | Stream logs live |
| `--wait` | Block until deployment is ready |
| `--name <name>` | Override project name |
| `--env KEY=value` | Pass env var for this deploy only |
| `--build-env KEY=value` | Pass env var only during build |
