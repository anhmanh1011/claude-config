# Claude Code Config

Cau hinh Claude Code ca nhan - sync across machines.

## Mac / Linux

```bash
git clone https://github.com/anhmanh1011/claude-config.git /tmp/claude-config && /tmp/claude-config/install.sh
```

## Windows (PowerShell)

```powershell
git clone https://github.com/anhmanh1011/claude-config.git $env:TEMP\claude-config; & "$env:TEMP\claude-config\install.ps1"
```

## Noi dung

- `settings.json` - Cau hinh Claude Code (plugins, permissions, marketplaces)
- `skills/` - 52 global skills (Golang + Anthropic official)
- `install.sh` - Script cai dat cho Mac/Linux
- `install.ps1` - Script cai dat cho Windows
