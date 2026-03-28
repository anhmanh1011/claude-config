# Claude Code Global Config Installer (Windows PowerShell)
$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ClaudeDir = "$env:USERPROFILE\.claude"

Write-Host "=== Claude Code Global Config Installer ===" -ForegroundColor Cyan
Write-Host "Target: $ClaudeDir"
Write-Host ""

if (!(Test-Path $ClaudeDir)) {
    New-Item -ItemType Directory -Path $ClaudeDir | Out-Null
}

# Backup settings
if (Test-Path "$ClaudeDir\settings.json") {
    Copy-Item "$ClaudeDir\settings.json" "$ClaudeDir\settings.json.backup"
    Write-Host "~ Backed up existing settings.json"
}

# Copy settings
Copy-Item "$ScriptDir\settings.json" "$ClaudeDir\settings.json"
Write-Host "- Installed settings.json" -ForegroundColor Green

# Copy CLAUDE.md (global instructions)
if (Test-Path "$ScriptDir\CLAUDE.md") {
    Copy-Item "$ScriptDir\CLAUDE.md" "$ClaudeDir\CLAUDE.md"
    Write-Host "- Installed CLAUDE.md (global instructions)" -ForegroundColor Green
}

# Install skills
if (Test-Path "$ScriptDir\skills") {
    $SkillsDir = "$ClaudeDir\skills"
    if (!(Test-Path $SkillsDir)) { New-Item -ItemType Directory -Path $SkillsDir | Out-Null }
    Copy-Item "$ScriptDir\skills\*" $SkillsDir -Recurse -Force
    Write-Host "- Installed $((Get-ChildItem -Directory $SkillsDir).Count) skills" -ForegroundColor Green
}

# Install agents
if (Test-Path "$ScriptDir\agents") {
    $AgentsDir = "$ClaudeDir\agents"
    if (!(Test-Path $AgentsDir)) { New-Item -ItemType Directory -Path $AgentsDir | Out-Null }
    Copy-Item "$ScriptDir\agents\*" $AgentsDir -Recurse -Force
    Write-Host "- Installed $((Get-ChildItem $AgentsDir -File).Count) agents" -ForegroundColor Green
}

# Install commands
if (Test-Path "$ScriptDir\commands") {
    $CommandsDir = "$ClaudeDir\commands"
    if (!(Test-Path $CommandsDir)) { New-Item -ItemType Directory -Path $CommandsDir | Out-Null }
    Copy-Item "$ScriptDir\commands\*" $CommandsDir -Recurse -Force
    Write-Host "- Installed $((Get-ChildItem $CommandsDir -File).Count) commands" -ForegroundColor Green
}

# Install hooks
if (Test-Path "$ScriptDir\hooks") {
    $HooksDir = "$ClaudeDir\hooks"
    if (!(Test-Path $HooksDir)) { New-Item -ItemType Directory -Path $HooksDir | Out-Null }
    Copy-Item "$ScriptDir\hooks\*" $HooksDir -Recurse -Force
    Write-Host "- Installed hooks" -ForegroundColor Green
}

# Check Claude Code
if (Get-Command claude -ErrorAction SilentlyContinue) {
    Write-Host "- Claude Code detected" -ForegroundColor Green
} else {
    Write-Host "! Claude Code not found. Install: npm install -g @anthropic-ai/claude-code" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Done! All global - available in ALL projects ===" -ForegroundColor Cyan
