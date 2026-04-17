#!/usr/bin/env bash
#
# install.sh -- Gemini Ultimate Harness - Fused Orchestration Setup
#
# One-command setup to instantiate 149+ specialist agents, 20+ core skills,
# and the Antigravity Autonomous Protocol across any repo.
#
# Supported Environments: Linux (x86_64, arm64), macOS (Apple Silicon, Intel)

set -euo pipefail

# ♊ THEMED COLORS ♊
C_GEMINI=$'\033[38;5;33m' # Deep Blue
C_ANTIGRAVITY=$'\033[38;5;127m' # Magenta
C_GREEN=$'\033[0;32m'
C_CYAN=$'\033[0;36m'
C_YELLOW=$'\033[1;33m'
C_RESET=$'\033[0m'

header()  { printf "\n${C_GEMINI}♊ %s${C_RESET}\n" "$*"; }
ok()      { printf "  ${C_GREEN}[OK]${C_RESET} %s\n" "$*"; }
info()    { printf "  ${C_CYAN}[INFO]${C_RESET} %s\n" "$*"; }
warn()    { printf "  ${C_YELLOW}[!!]${C_RESET} %s\n" "$*"; }
divider() { printf "${C_GEMINI}%s${C_RESET}\n" "--------------------------------------------------------------------"; }

# PATHS
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_HOME="${HOME}/.claude"
GEMINI_HOME="${HOME}/.gemini"
CODEX_HOME="${HOME}/.codex"

header "GEMINI ULTIMATE HARNESS -- INITIALIZING FUSED BRAIN"
divider

# 1. CORE SKILLS (Claude Code)
header "INSTALLING CLAUDE CODE SKILLS"
mkdir -p "$CLAUDE_HOME/skills"
info "Migrating 147+ Core Skills from local repository..."
cp -r "$REPO_ROOT/skills/claude-skills/"* "$CLAUDE_HOME/skills/"
ok "Core Skills instantiated in ~/.claude/skills/"

# 2. AGENCY SPECIALISTS (Antigravity)
header "INSTALLING AGENCY SPECIALISTS"
mkdir -p "$GEMINI_HOME/antigravity/skills"
info "Migrating 157+ Agency Specialists from local repository..."
cp -r "$REPO_ROOT/skills/agency-skills/"* "$GEMINI_HOME/antigravity/skills/"
ok "Agency Specialists instantiated in ~/.gemini/antigravity/skills/"

# 3. FUSED CONFIGURATION
header "CONFIGURING AGENT ORCHESTRATION"

# Install Master GEMINI.md
info "Installing GEMINI.md autonomous instructions..."
mkdir -p "$GEMINI_HOME"
cp "$REPO_ROOT/config/GEMINI.md" "$GEMINI_HOME/GEMINI.md"
ok "Gemini CLI system instructions updated."

# Install Unified Settings.json
info "Installing unified Claude Code settings..."
mkdir -p "$CLAUDE_HOME"
cp "$REPO_ROOT/config/settings.json" "$CLAUDE_HOME/settings.json"
ok "Claude Code settings synchronized."

# 4. CROSS-LINKING (Codex)
header "SYMLINKING CROSS-HARNESS SKILLS"
mkdir -p "$CODEX_HOME/skills"

# Symlink everything to Codex for maximum accessibility
info "Linking all specialists to Codex context..."
for skill in "$GEMINI_HOME/antigravity/skills"/*/; do
    skill_name=$(basename "$skill")
    if [ ! -e "$CODEX_HOME/skills/$skill_name" ]; then
        ln -s "$skill" "$CODEX_HOME/skills/$skill_name"
    fi
done
ok "Specialists cross-linked to ~/.codex/skills/"

# 5. ENVIRONMENT INTEGRATION
header "FINALIZING ENVIRONMENT"

# Refresh Antigravity Status
info "Total Specialist Agents: $(ls "$GEMINI_HOME/antigravity/skills" | grep ^agency- | wc -l)"
info "Total Core Skills: $(ls "$CLAUDE_HOME/skills" | wc -l)"

# Instructions
divider
ok "♊ GEMINI ULTIMATE HARNESS INSTALLED SUCCESSFULLY ♊"
info "To activate the new brain:"
info "  1. Restart your terminal."
info "  2. Load a new Gemini CLI or Claude Code session."
info "  3. The 'Best of Everything' protocol is now active."
divider
printf "\n"
