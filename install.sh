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
ANTIGRAVITY_REPO_DEST="${HOME}/Global developer folder/antigravity-harness"

# DEPENDENCIES
CLAUDE_CODE_STUFF_REPO="https://github.com/sharadchaturveda-coder/claude_code_stuff.git"
ANTIGRAVITY_HARNESS_REPO="https://github.com/sharadchaturveda-coder/antigravity-harness.git"

header "GEMINI ULTIMATE HARNESS -- INITIALIZING FUSED BRAIN"
divider

# 1. CORE DEPENDENCIES
info "Resolving core dependencies..."

# CLAUDE CODE STUFF
if [ ! -d "$CLAUDE_HOME/.git" ]; then
    info "Cloning Claude Code Stuff..."
    mkdir -p "$CLAUDE_HOME"
    git clone "$CLAUDE_CODE_STUFF_REPO" "$CLAUDE_HOME"
else
    ok "Claude Code Stuff already installed."
fi

# ANTIGRAVITY HARNESS
if [ ! -d "$ANTIGRAVITY_REPO_DEST/.git" ]; then
    info "Cloning Antigravity Global Harness..."
    mkdir -p "$(dirname "$ANTIGRAVITY_REPO_DEST")"
    git clone "$ANTIGRAVITY_HARNESS_REPO" "$ANTIGRAVITY_REPO_DEST"
else
    ok "Antigravity Global Harness already installed."
fi

# 2. FUSED CONFIGURATION
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

# 3. SYMLINKING SPECIALISTS
header "SYMLINKING CROSS-HARNESS SKILLS"

# Create directories if missing
mkdir -p "$CLAUDE_HOME/skills"
mkdir -p "$GEMINI_HOME/antigravity/skills"
mkdir -p "$CODEX_HOME/skills"

# Symlink Claude skills to Antigravity
info "Linking Claude skills to Antigravity..."
for skill in "$CLAUDE_HOME/skills"/*/; do
    skill_name=$(basename "$skill")
    if [ ! -e "$GEMINI_HOME/antigravity/skills/$skill_name" ]; then
        ln -s "$skill" "$GEMINI_HOME/antigravity/skills/$skill_name"
    fi
done

# Copy Agency Specialist Agents
info "Installing Antigravity specialists..."
cp -r "$ANTIGRAVITY_REPO_DEST/agency-skills/"* "$GEMINI_HOME/antigravity/skills/"
ok "149+ Agency Specialists instantiated in ~/.gemini/antigravity/skills/"

# 4. ENVIRONMENT INTEGRATION
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
