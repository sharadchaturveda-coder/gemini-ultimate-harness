---
name: gh-cli
description: GitHub CLI (gh) — create PRs, manage issues, check CI status, view/merge PRs, clone repos, manage releases. USE autonomously when the task involves GitHub operations. PREFER over raw git or GitHub API for anything UI-facing.
---

# GitHub CLI (gh)

## When to use gh vs alternatives

| Situation | Use |
|---|---|
| Create a PR, add reviewers, set labels | `gh pr create` |
| Check if CI is passing on a branch | `gh pr checks` or `gh run list` |
| View, review, approve, or merge a PR | `gh pr view/review/merge` |
| List or create issues | `gh issue list/create` |
| Clone a repo by name without knowing the URL | `gh repo clone` |
| Create a release / tag | `gh release create` |
| View GitHub Actions workflow runs | `gh run list/view/watch` |
| Re-run failed CI | `gh run rerun` |
| Just push commits, create branches | plain `git` |
| Complex DB queries or webhook config | GitHub REST API directly |

## Auth check

Before using gh in a script or unfamiliar environment:
```bash
gh auth status
```

## Pull Requests

### Create a PR
```bash
# Basic — gh infers base branch from git history
gh pr create --title "feat: add VRM lipsync" --body "Adds audio-driven viseme blending"

# With reviewer, label, draft
gh pr create \
  --title "feat: add VRM lipsync" \
  --body "$(cat <<'EOF'
## Summary
- Audio-driven viseme blending via AnalyserNode
- Syncs with ElevenLabs TTS streaming

## Test plan
- [ ] Test with ElevenLabs voice
- [ ] Test with Web Speech TTS
EOF
)" \
  --reviewer sharadchaturveda-coder \
  --label "enhancement" \
  --draft
```

### List PRs
```bash
gh pr list                          # open PRs on current repo
gh pr list --state merged           # merged
gh pr list --author "@me"           # mine only
```

### View a PR
```bash
gh pr view                          # current branch's PR
gh pr view 42                       # by number
gh pr view 42 --web                 # open in browser
```

### Check CI status
```bash
gh pr checks                        # checks on current branch's PR
gh pr checks 42                     # by PR number
gh run list --branch main           # all workflow runs on branch
gh run watch                        # stream current run live
```

### Review / approve / request changes
```bash
gh pr review 42 --approve
gh pr review 42 --request-changes --body "Need to handle null case in lipsync"
gh pr review 42 --comment --body "Looks good, minor nit on line 47"
```

### Merge a PR
```bash
gh pr merge 42 --squash             # squash merge (preferred for features)
gh pr merge 42 --merge              # merge commit
gh pr merge 42 --rebase             # rebase
gh pr merge 42 --squash --delete-branch  # squash + delete branch
```

## Issues

```bash
gh issue list                       # open issues
gh issue list --label "bug"
gh issue create --title "VRM springbone stutters at 60fps" \
  --body "Steps to reproduce..." \
  --label "bug"
gh issue view 12
gh issue close 12
gh issue close 12 --comment "Fixed in #45"
```

## CI / GitHub Actions

```bash
gh run list                         # recent workflow runs
gh run list --workflow ci.yml       # specific workflow
gh run view 12345678                # detail on a run
gh run view 12345678 --log          # full logs
gh run rerun 12345678               # re-run failed run
gh run rerun 12345678 --failed-only # re-run only failed jobs
gh workflow list                    # all workflows in repo
gh workflow run deploy.yml          # trigger a workflow manually
gh workflow run deploy.yml --field environment=production
```

## Releases

```bash
gh release list
gh release create v1.0.0 --title "v1.0.0 — Initial release" \
  --notes "First stable release of the companion system"
gh release create v1.0.0 --generate-notes   # auto-generate from PRs/commits
gh release view v1.0.0
```

## Repos

```bash
gh repo clone sharadchaturveda-coder/my-repo
gh repo view                        # current repo info
gh repo view --web                  # open in browser
gh repo list                        # your repos
gh repo create my-new-repo --private
gh repo fork upstream/repo --clone  # fork + clone
```

## Autonomous decision rules

**Always use gh (not git or API) when:**
- User says "open a PR", "create a pull request", "submit this" → `gh pr create`
- User says "check CI", "is it passing", "what's the build status" → `gh pr checks` or `gh run list`
- User says "merge the PR", "land this" → `gh pr merge`
- User says "open an issue", "file a bug" → `gh issue create`
- User says "re-run CI", "retry the build" → `gh run rerun`
- User says "create a release", "tag this version" → `gh release create`

**Do not use gh for:**
- Committing, staging, branching, rebasing — use plain git
- Reading file content from GitHub — use git checkout or the API
- Complex automation (webhooks, org settings) — use the REST API

## Common patterns for this project

```bash
# After finishing a feature — create PR and check CI
gh pr create --title "feat: ..." --body "..."
gh pr checks --watch

# Quick status check on open PRs
gh pr list && gh run list --limit 5

# Close a PR branch after merge
gh pr merge --squash --delete-branch

# See what broke in CI
gh run view --log-failed
```
