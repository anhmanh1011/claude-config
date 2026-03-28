#!/bin/bash
set -e

echo "=== Claude Code Config Installer ==="

# Tạo ~/.claude nếu chưa có
mkdir -p ~/.claude

# Backup settings cũ nếu có
[ -f ~/.claude/settings.json ] && cp ~/.claude/settings.json ~/.claude/settings.json.backup

# Copy settings
cp settings.json ~/.claude/settings.json

# Copy skills nếu có
if [ -d "skills" ]; then
  mkdir -p ~/.claude/skills
  cp -r skills/* ~/.claude/skills/
  echo "✓ Skills installed"
fi

# Cài plugin superpowers
echo "Installing superpowers plugin..."
if command -v claude &> /dev/null; then
  claude mcp __plugin_superpowers -- echo "plugin ready" 2>/dev/null || true
  echo "✓ Plugin registered (sẽ tự cài khi mở Claude Code)"
else
  echo "⚠ Claude Code chưa cài. Cài trước: npm install -g @anthropic-ai/claude-code"
fi

echo ""
echo "=== Done! Mở Claude Code để bắt đầu ==="
