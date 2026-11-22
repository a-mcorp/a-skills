# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<!--
Template
## [{version}] - {YYYY-MM-DD}

### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security
-->

## [2.0.1] - 2026-11-22
### Fixed
- `CHANGELOG.md`: the 2.0.0 entry condensed, as in its Pull Request.

## [2.0.0] - 2026-11-22
### Added
- `hardware` skill with `Dimensions`, `BOM`, `Printing` and `Photos` extensions: design notes in `DESIGN.md`, four CAD roles, measured dimensions, generated bills of materials and support-free printing.
- `style` skill, `Contributing` extension: branches, squashed Pull Requests into `trunk` and `main`, filled-in Pull Request templates, no personal data in code, licences, dependencies, generated files and lean templates.
- `Dockerfiles/Claude/hardware.dockerfile`: an optional hardware image with OpenSCAD (Manifold backend), F3D, `admesh` and PDF tools.
- Optional support for your own custom assistant (the 'engram'), loaded from `.github/skills/engrams` when `A_SKILLS_OPERATOR` is set.

### Changed
- Licence changed to AGPL-3.0-or-later, with attribution and name terms in `NOTICE`; the previous `LICENSE.md` held the LGPL-3.0 text, contradicting the GPL-3.0 in `README.md`.
- `style` skill, `Changelog`: versions chosen by their effect on users, every merge into the trunk is a release, tags are checked before versioning, and projects created from a template start their own changelog.
- `style` skill, `Comment`: attribution headers in source code and configuration; skill files carry a one-line origin comment.
- `style` skill: British spelling, typography and plain wording; directives written as neutral, general rules.
- `ops` skill, `Notation`: words in full, plural collections, entry points named after what the script does.
- `style` skill, `Cloud` and `Planning`: Cloud resource types capitalised; `TO-DO.md` limited to work on the project.
- `obsidian` skill: tables allowed where they give a clearer view.
- `README.md`: 'A-Skills' described as an agent system for the 'a-mcorp' repositories, in the layout of the templates, with screenshots in `docs/`; links point to 'a-mcorp'.
- `Dockerfiles`: attribution headers, and reviewed comments without the "Auto-generated:" prefix.
- Pull Request templates: a checkbox for changes written with the help of an assistant.

## [1.0.0] - 2026-11-12
### Added
- `style` skill with `Cloud`, `Comment`, `Reference`, `Codeowners`, `Changelog`, `Planning` and `Security` extensions.
- `ops` skill with `Notation`, `Terraform` and `Python` extensions.
- `obsidian` skill with the `Obsidian` extension.
- `AGENTS.md`, applying the `style` skill to every agent task and the `ops` and `obsidian` skills to matching tasks, and `CLAUDE.md` importing it.
- `.github/CODEOWNERS`, with `CODEOWNERS_TEMPLATE`, `CHANGELOG_TEMPLATE` and `PULL_REQUEST_TEMPLATE` directories.
- Default `.github/pull_request_template.md` with "Summary", "Changelog", "Examples", "Testing" and "Comments" sections.
- Fedora-based `askillsAgent.dockerfile` image under `Dockerfiles/Copilot`, with Visual Studio Code, GitHub Copilot App, GitHub Copilot CLI and `git`.
- Fedora-based `askillsAgent.dockerfile` image under `Dockerfiles/Claude`, with Visual Studio Code, the Claude Code extension, Claude Desktop App and Claude Code CLI.
- Downloaded installers and cached `.vsix` packages are removed in the same image layer, to keep both images small.
- Firefox as the default browser, with a `vscode://` URL handler and dark mode in the container.
- Optional microphone passthrough for both images through the host's PipeWire/PulseAudio socket, with `alsa-plugins-pulseaudio`, `pulseaudio-libs` and `sox` installed and the default ALSA device routed to that socket in `/etc/asound.conf`, documented in `Dockerfiles/README.md`.
- `entrypoint.sh` for each image, with `copilot-vsc`/`claude-vsc` (default), `copilot-app`/`claude-app`, `copilot-cli`/`claude-cli`, `browser` and `terminal` sub-commands.
- `Dockerfiles/vsc-settings.json` shared by both images, with Copilot settings listed before Claude Code settings.
- `Dockerfiles/vsc-claude.json` with Claude Code settings for the Claude image, enabling voice dictation in tap mode by default.
- `Dockerfiles/SETTINGS.md` with Claude Code and GitHub Copilot extension settings as tables, with ToC and references.
- `Dockerfiles/README.md` with the Podman run command and per-image commands, and `Dockerfiles/PROMPTS.md`.
- `README.md` note that the images are Linux containers only, since native Windows containers do not support GUI passthrough by design.
- `README.md` with metadata, features, setup, usage, repository structure, Podman socket troubleshooting and example screenshots of both images.
- `TO-DO.md` with the planned SELinux confinement of the container.
- `.gitignore` excluding `Dockerfiles/PERSONAL.md`.
- `CHANGELOG.md`.

### Security
- Containers run with `--cap-drop=ALL`, `no-new-privileges` and `--userns=keep-id`, with only the selected folders mounted and `/run/user/1000` as an in-memory `tmpfs`.
- `openssl3-libs` is installed in both images, so Visual Studio Code can verify extension signatures on Fedora 45+.
- The optional PulseAudio socket mount gives the container access to all host audio devices, hence it is left out of the default `podman run` command.
- Known issue: SELinux labelling is disabled with `--security-opt label=disable`, because the default labels block the Wayland socket and `/dev/dri`. Confinement is planned in `TO-DO.md`.
