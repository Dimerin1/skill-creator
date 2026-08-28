# skill-creator installer (Windows / PowerShell)
$ErrorActionPreference = 'Stop'

$repo     = 'https://raw.githubusercontent.com/Dimerin1/skill-creator/main'
$skillDir = Join-Path $HOME '.claude\skills\skill-creator'
$cmdDir   = Join-Path $HOME '.claude\commands'

$files = @(
  'SKILL.md',
  'license.txt',
  'agents/openai.yaml',
  'references/openai_yaml.md',
  'scripts/init_skill.py',
  'scripts/generate_openai_yaml.py',
  'scripts/quick_validate.py',
  'assets/skill-creator-small.svg',
  'assets/skill-creator.png'
)

New-Item -ItemType Directory -Force -Path $cmdDir | Out-Null
foreach ($f in $files) {
  $dest = Join-Path $skillDir ($f -replace '/', '\')
  New-Item -ItemType Directory -Force -Path (Split-Path $dest -Parent) | Out-Null
  Invoke-WebRequest "$repo/$f" -OutFile $dest
}
Invoke-WebRequest "$repo/commands/skill-creator.md" -OutFile (Join-Path $cmdDir 'skill-creator.md')

Write-Host "installed skill-creator -> $skillDir" -ForegroundColor Green
Write-Host "reload your Claude Code window, then type /skill-creator"
