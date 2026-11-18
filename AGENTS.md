# AGENTS.md

## Repository structure
```
.
├── .github/skills                 # Custom skills for GitHub Copilot and Claude Code
```

## Workflow
- Apply the `style` skill from `.github/skills/style` to every user interaction and agentic task.
- Apply the `engrams` skill from `.github/skills/engrams` to every user interaction, for even more tailored styling of responses, but only when the `A_SKILLS_OPERATOR` environment variable is set. Read it once at the start of the session (e.g. `echo "$A_SKILLS_OPERATOR"`), and load only the engrams whose file name matches its value (case-insensitive, ignoring hyphens and spaces). When the variable is unset or no engram matches, load none.
- Apply the `ops` skill from `.github/skills/ops` to every user interaction involving programming, architecture design and 'cloud', 'dev', 'sec' `*ops` tools.
- Apply the `obsidian` skill from `.github/skills/obsidian` to every user interaction involving Obsidian text editor and its `markdown` format files.