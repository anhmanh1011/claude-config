# Claude Code Global Config Installer (Windows PowerShell)
$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ClaudeDir = "$env:USERPROFILE\.claude"
$SkillsDir = "$ClaudeDir\skills"

Write-Host "=== Claude Code Global Config Installer ===" -ForegroundColor Cyan
Write-Host "Target: $ClaudeDir"
Write-Host ""

# Tao .claude neu chua co
if (!(Test-Path $ClaudeDir)) {
    New-Item -ItemType Directory -Path $ClaudeDir | Out-Null
}

# Backup settings cu
if (Test-Path "$ClaudeDir\settings.json") {
    Copy-Item "$ClaudeDir\settings.json" "$ClaudeDir\settings.json.backup"
    Write-Host "~ Backed up existing settings.json"
}

# Copy settings (global)
Copy-Item "$ScriptDir\settings.json" "$ClaudeDir\settings.json"
Write-Host "- Installed settings.json (global)" -ForegroundColor Green

# Install skills (global)
if (Test-Path "$ScriptDir\skills") {
    if (!(Test-Path $SkillsDir)) {
        New-Item -ItemType Directory -Path $SkillsDir | Out-Null
    }
    Copy-Item "$ScriptDir\skills\*" $SkillsDir -Recurse -Force
    $SkillCount = (Get-ChildItem -Directory $SkillsDir).Count
    Write-Host "- Installed $SkillCount skills to $SkillsDir (global)" -ForegroundColor Green
}

# Check Claude Code
if (Get-Command claude -ErrorAction SilentlyContinue) {
    Write-Host "- Claude Code detected" -ForegroundColor Green
} else {
    Write-Host "! Claude Code not found. Install: npm install -g @anthropic-ai/claude-code" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Done! Skills are global - available in ALL projects ===" -ForegroundColor Cyan
