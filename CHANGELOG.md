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

## [2.0.0] - 2026-11-22
### Added
- `hardware` skill, applied from `AGENTS.md` to devices, CAD, 3D printing, electronics, measurements and bills of materials.
  - The reasoning goes into `DESIGN.md`, each decision as a short, impersonal point - what was settled on, then a short reason.
  - The CAD keeps four roles - parts, layout, printable parts, assembly with fit checks - in any tool and any number of files.
  - `Dimensions`: measured by hand and checked against the makers' drawings, rounded to 0.05 mm, with datasheets linked and never committed.
  - `BOM`: the sections and columns of a generated bill of materials; MPN and SKU are both optional, and shops are never linked, only the makers' datasheets.
  - `Printing`: function before looks, within the project's artistic direction; pointed arches inside a part, teardrop-shaped visible openings (rounded, with a 45-degree point at the end printed last); every support-free slope starts on the bed or a wall; design checks for batteries, PCB edges, speakers, buttons and screws.
  - `Photos`: one crop size per guide, metadata stripped, originals kept out of the repository.
- `style` skill, `Contributing` extension: the 'Maintainer', branches, commit messages, Pull Requests (with a note when an assistant helped), no personal data in code (GDPR), licences and attributions, new dependencies, generated files and third-party documents.
  - Changes reach `trunk` and `main` only through squashed Pull Requests - no direct commits, merges or force pushes.
  - Filled-in Pull Request templates keep their comments, with the content below each one; release titles start with the version, the Summary describes the work in prose, without repeating the version; Examples and Testing are optional; descriptions do not tell anyone what to do next.
  - Templates stay lean: they define the form of a project, not the methods for filling it in.
- `Dockerfiles/Claude/hardware.dockerfile`: an optional hardware image on top of the Claude Code image, with the OpenSCAD AppImage (2026.11-RC0, Manifold backend, SHA-256 checked), F3D, `admesh`, `exiftool`, `poppler-utils`, Pillow, `time` and a PDF viewer, documented in `Dockerfiles/README.md`.
- Optional support for your own custom assistant (the 'engram'): a git submodule in `.github/skills/engrams`, selected with the `A_SKILLS_OPERATOR` variable and loaded from `AGENTS.md` only when it is set; an engram can be a single file or a folder, with a `core.md` read in every session and extensions read only when their topic comes up.

### Changed
- Licence changed to AGPL-3.0-or-later, with the copyright and additional section 7 terms (attribution, name) in `NOTICE`; `LICENSE` (previously `LICENSE.md`) held the LGPL-3.0 text, which contradicted the GPL-3.0 stated in `README.md`.
- `style` skill, `Comment`: source code and configuration start with an attribution header - name, source repository, SPDX licence and year, without a personal name; skill files carry a one-line origin comment instead.
- `style` skill, `Changelog`: how to choose the version number - MAJOR, MINOR or PATCH by the effect on existing users; 1.0.0 is the first release that works; entries are sorted by weight when a version is released.
- `style` skill, `Changelog`: every merge into the trunk is a release with its own version; a fix after a merge is a new version.
- `style` skill, `Changelog`: check the git tags before versioning; for a version without a tag, ask whether it was released with a forgotten tag or never released, and fold it into the first release only in the latter case.
- `style` skill, `Changelog`: a project created from a template repository starts its own changelog from `.github/CHANGELOG_TEMPLATE`, instead of the template's history.
- `ops` skill, `Notation`: words in names are written in full, without abbreviations; collections are named in the plural, their items in the singular; entry-point functions are named after what the script does, not `main`.
- `style` skill: British spelling, the spaced hyphen as the dash, title-case headings, number and unit spacing, plain wording; consistent comments and captions; changes applied only when asked; short questions when a request is unclear; placeholders, outdated facts and renamed files reported instead of changed.
- All skills: directives are written in a neutral, clear and semi-official tone, as general rules in the imperative, with short scope labels (e.g. `OBSIDIAN MARKDOWN:`, `TERRAFORM:`) and without examples from the cases they came from; a new `style` directive applies this to every skill and instruction.
- `style` skill, `Cloud`: Cloud resource types are capitalised as proper nouns (e.g. "Storage Account", "Key Vault"), for every provider.
- `style` skill, `Planning`: `TO-DO.md` holds work on the project itself, each item as a short goal; detailed checklists are left to the Operator.
- `obsidian` skill: tables are allowed where they save space or give a clearer view, or where a template defines them; lists stay preferred for simple data.
- `README.md`: 'A-Skills' is described as an agent system and an interface to the 'a-mcorp' repositories - skills, container images and contribution guidelines - not only a skills bundle.
- `README.md`: the features and the three screenshots in one Features table, and Dependencies and Usage side by side under Setup, like the template repositories; the repository structure is its own section, and the separate Example section was removed.
- Links to the repositories point to the 'a-mcorp' organisation on GitHub.
- `Dockerfiles`: the images and their entrypoints start with the attribution header; their comments no longer carry the "Auto-generated:" prefix, as they have been reviewed.
- `.github/pull_request_template.md` and `PULL_REQUEST_TEMPLATE/Default.md`: a checkbox in the Comments section marks when an assistant helped to write the changes.
- Screenshots moved into a new `docs/` folder, like in the other repositories.

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
