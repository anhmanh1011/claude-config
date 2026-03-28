#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
SKILLS_DIR="$CLAUDE_DIR/skills"

echo "=== Claude Code Global Config Installer ==="
echo "Target: $CLAUDE_DIR"
echo ""

# Tạo ~/.claude nếu chưa có
mkdir -p "$CLAUDE_DIR"

# Backup settings cũ nếu có
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  cp "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.backup"
  echo "~ Backed up existing settings.json"
fi

# Copy settings (global)
cp "$SCRIPT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
echo "- Installed settings.json (global)"

# Install skills (global - áp dụng cho TẤT CẢ projects)
if [ -d "$SCRIPT_DIR/skills" ]; then
  mkdir -p "$SKILLS_DIR"
  cp -r "$SCRIPT_DIR/skills/"* "$SKILLS_DIR/"
  SKILL_COUNT=$(ls -d "$SKILLS_DIR"/*/ 2>/dev/null | wc -l | tr -d ' ')
  echo "- Installed $SKILL_COUNT skills to $SKILLS_DIR (global)"
fi

# Check Claude Code
if command -v claude &> /dev/null; then
  echo "- Claude Code detected"
else
  echo "! Claude Code not found. Install: npm install -g @anthropic-ai/claude-code"
fi

echo ""
echo "=== Done! Skills are global - available in ALL projects ==="
