# Claude Code Config

Global config, skills, agents, commands for Claude Code - sync across machines.

## Quick Install

### Mac
```bash
git clone https://github.com/anhmanh1011/claude-config.git /tmp/claude-config && /tmp/claude-config/install.sh
```

### Ubuntu / Linux Server
```bash
git clone https://github.com/anhmanh1011/claude-config.git /tmp/claude-config && bash /tmp/claude-config/install-linux.sh
```
Auto-installs git, Node.js, Claude Code if missing.

### Windows (PowerShell)
```powershell
git clone https://github.com/anhmanh1011/claude-config.git $env:TEMP\claude-config; & "$env:TEMP\claude-config\install.ps1"
```

## Contents

| Type | Count | Description |
|------|-------|-------------|
| `CLAUDE.md` | 1 | Global instructions - auto-apply skills by language |
| `skills/` | 175 | Golang, Python, Rust, Kotlin, Java, TypeScript, DevOps... |
| `agents/` | 28 | Code reviewers, build resolvers, planners... |
| `commands/` | 60 | Slash commands for common workflows |
| `hooks/` | 1 | Event-driven automation |

## Scripts

| File | Platform |
|------|----------|
| `install.sh` | Mac / Linux |
| `install-linux.sh` | Ubuntu / Linux Server (auto-install dependencies) |
| `install.ps1` | Windows PowerShell |
