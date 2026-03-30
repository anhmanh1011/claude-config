#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "=== Claude Code Global Config Installer (Linux) ==="
echo "Target: $CLAUDE_DIR"
echo ""

# Check git
if ! command -v git &> /dev/null; then
  echo "Installing git..."
  if command -v apt-get &> /dev/null; then
    sudo apt-get update -qq && sudo apt-get install -y -qq git
  elif command -v yum &> /dev/null; then
    sudo yum install -y git
  elif command -v dnf &> /dev/null; then
    sudo dnf install -y git
  fi
fi

# Check node/npm
if ! command -v node &> /dev/null; then
  echo "Installing Node.js..."
  if command -v apt-get &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y -qq nodejs
  elif command -v yum &> /dev/null; then
    curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
    sudo yum install -y nodejs
  elif command -v dnf &> /dev/null; then
    curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
    sudo dnf install -y nodejs
  fi
fi

# Check Claude Code
if ! command -v claude &> /dev/null; then
  echo "Installing Claude Code..."
  npm install -g @anthropic-ai/claude-code
fi

mkdir -p "$CLAUDE_DIR"

# Backup settings
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  cp "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.backup"
  echo "~ Backed up existing settings.json"
fi

# Copy settings
cp "$SCRIPT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
echo "- Installed settings.json"

# Copy CLAUDE.md (global instructions)
if [ -f "$SCRIPT_DIR/CLAUDE.md" ]; then
  cp "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
  echo "- Installed CLAUDE.md (global instructions)"
fi

# Install skills
if [ -d "$SCRIPT_DIR/skills" ]; then
  mkdir -p "$CLAUDE_DIR/skills"
  cp -r "$SCRIPT_DIR/skills/"* "$CLAUDE_DIR/skills/"
  echo "- Installed $(find "$CLAUDE_DIR/skills" -maxdepth 1 -type d | tail -n +2 | wc -l | tr -d ' ') skills"
fi

# Install agents
if [ -d "$SCRIPT_DIR/agents" ]; then
  mkdir -p "$CLAUDE_DIR/agents"
  cp -r "$SCRIPT_DIR/agents/"* "$CLAUDE_DIR/agents/"
  echo "- Installed $(ls "$CLAUDE_DIR/agents/" | wc -l | tr -d ' ') agents"
fi

# Install commands
if [ -d "$SCRIPT_DIR/commands" ]; then
  mkdir -p "$CLAUDE_DIR/commands"
  cp -r "$SCRIPT_DIR/commands/"* "$CLAUDE_DIR/commands/"
  echo "- Installed $(ls "$CLAUDE_DIR/commands/" | wc -l | tr -d ' ') commands"
fi

# Install hooks
if [ -d "$SCRIPT_DIR/hooks" ]; then
  mkdir -p "$CLAUDE_DIR/hooks"
  cp -r "$SCRIPT_DIR/hooks/"* "$CLAUDE_DIR/hooks/"
  echo "- Installed hooks"
fi

# Install rules
if [ -d "$SCRIPT_DIR/rules" ]; then
  mkdir -p "$CLAUDE_DIR/rules"
  cp -r "$SCRIPT_DIR/rules/"* "$CLAUDE_DIR/rules/"
  echo "- Installed $(ls "$CLAUDE_DIR/rules/" | wc -l | tr -d ' ') rules"
fi

echo ""
echo "=== Done! All global - available in ALL projects ==="
echo ""
echo "Claude Code version: $(claude --version 2>/dev/null || echo 'not found')"
echo "Node version: $(node --version 2>/dev/null || echo 'not found')"
