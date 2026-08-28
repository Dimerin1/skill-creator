# skill-creator

The meta-skill: a skill that builds other skills.

Agent skills are just a folder with a `SKILL.md` in it — which makes them easy to start and easy to get subtly wrong. The description doesn't trigger, the body dumps 2,000 words into every context, the scripts get rewritten from scratch on each run. This skill encodes the design rules and ships the scaffolding tooling.

## What it does

Walks a six-step process — understand with concrete examples → plan reusable resources → scaffold → write → validate → iterate — and enforces the design principles that make skills actually work:

- **Progressive disclosure.** Metadata is always in context, the body loads on trigger, bundled resources load only when needed. Keep `SKILL.md` under 500 lines and push detail into `references/`.
- **Degrees of freedom.** Match specificity to fragility — prose for open-ended judgment, parameterized scripts for preferred patterns, rigid scripts for error-prone sequences.
- **Concision.** The context window is a public good. Every paragraph has to justify its token cost.
- **The right bucket.** `scripts/` for deterministic code, `references/` for docs read into context, `assets/` for files used in the output. No READMEs, no changelogs, no setup guides inside a skill.

## Tooling

| Script | Purpose |
| --- | --- |
| `scripts/init_skill.py` | Scaffold a new skill folder — `SKILL.md` template, `agents/openai.yaml`, optional `scripts/`, `references/`, `assets/` dirs and example files |
| `scripts/generate_openai_yaml.py` | Generate or regenerate the UI metadata (`display_name`, `short_description`, `default_prompt`) |
| `scripts/quick_validate.py` | Check frontmatter, required fields, and naming rules |

```bash
scripts/init_skill.py my-skill --path ~/.claude/skills \
  --resources scripts,references \
  --interface display_name="My Skill" \
  --interface short_description="Does the thing I keep redoing by hand" \
  --interface default_prompt="Do the thing"

scripts/quick_validate.py ~/.claude/skills/my-skill
```

Note that `--interface` is repeated per key — passing several `key=value` pairs after one flag is an argparse error. `short_description` must be 25–64 characters.

## Install

**PowerShell (Windows):**

```powershell
irm https://raw.githubusercontent.com/Dimerin1/skill-creator/main/install.ps1 | iex
```

**bash (macOS/Linux):**

```bash
curl -fsSL https://raw.githubusercontent.com/Dimerin1/skill-creator/main/install.sh | bash
```

**Manual:**

```bash
git clone https://github.com/Dimerin1/skill-creator.git
mkdir -p ~/.claude/skills/skill-creator
cp -r skill-creator/{SKILL.md,agents,references,scripts,assets,license.txt} ~/.claude/skills/skill-creator/
cp skill-creator/commands/skill-creator.md ~/.claude/commands/
```

Reload your Claude Code window afterwards, then type `/skill-creator`.

## Known quirks

Carried over from upstream, documented rather than patched so this stays a faithful mirror:

- The scaffolded `SKILL.md` has an unquoted `description: [TODO: ...]`, which YAML parses as a list. Running `quick_validate.py` before you replace the TODO fails with `Description must be a string, got list`. Fill in the description first, or quote it.
- `SKILL.md` points at `references/workflows.md` and `references/output-patterns.md` for workflow and output-format patterns. Neither ships in this bundle; only `references/openai_yaml.md` is present.
- The text says "Codex" throughout — it applies unchanged to Claude Code.

## License

Apache-2.0. `license.txt` is preserved from upstream; this repo is a mirror packaged for one-line install.
