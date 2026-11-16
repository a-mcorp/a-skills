# AGENTS.md

## Repository structure
```
.
├── .github/skills                 # Custom skills for GitHub Copilot and Claude Code
```

## Workflow
- Apply the `style` skill from `.github/skills/style` to every user interaction and agentic task.
- Apply the `engrams` skill from `.github/skills/engrams` for even more tailored styling of responses. This skill extends the `style` skill only when requested.
- Apply the `ops` skill from `.github/skills/ops` to every user interaction involving programming, architecture design and 'cloud', 'dev', 'sec' `*ops` tools.
- Apply the `obsidian` skill from `.github/skills/obsidian` to every user interaction involving Obsidian text editor and its `markdown` format files.