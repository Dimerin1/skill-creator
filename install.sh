#!/usr/bin/env bash
# skill-creator installer (macOS / Linux)
set -euo pipefail

repo="https://raw.githubusercontent.com/Dimerin1/skill-creator/main"
skill_dir="$HOME/.claude/skills/skill-creator"
cmd_dir="$HOME/.claude/commands"

files=(
  "SKILL.md"
  "license.txt"
  "agents/openai.yaml"
  "references/openai_yaml.md"
  "scripts/init_skill.py"
  "scripts/generate_openai_yaml.py"
  "scripts/quick_validate.py"
  "assets/skill-creator-small.svg"
  "assets/skill-creator.png"
)

mkdir -p "$cmd_dir"
for f in "${files[@]}"; do
  mkdir -p "$skill_dir/$(dirname "$f")"
  curl -fsSL "$repo/$f" -o "$skill_dir/$f"
done
curl -fsSL "$repo/commands/skill-creator.md" -o "$cmd_dir/skill-creator.md"
chmod +x "$skill_dir"/scripts/*.py

echo "installed skill-creator -> $skill_dir"
echo "reload your Claude Code window, then type /skill-creator"
