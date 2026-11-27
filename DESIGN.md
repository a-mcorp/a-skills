# Design
Why 'A-Skills' and its container images are built the way they are. How to build and run them is in the [README](README.md) and [Dockerfiles/README.md](Dockerfiles/README.md).

## Images
- **A base image per agent, optional layers per workflow:** the Claude Code and GitHub Copilot images hold what every session needs, and workflows with heavy or niche tools (hardware, LaTeX) are separate Dockerfiles built `FROM` a base image. The base stays small and quick to rebuild, and each workflow adds only the tools it uses.
- **Layers stack through `BASE_IMAGE`:** each layer takes the image it builds on as an argument, so layers combine (e.g. LaTeX on top of hardware) without a Dockerfile for every combination.
- **Tools from releases are pinned and checked:** a tool that Fedora does not package, or packages in an outdated version (OpenSCAD, Tectonic), is downloaded at a fixed version and verified against its SHA-256 checksum, so a build never takes an unknown file.
- **General-purpose tools in every image:** `ps`, `file` and `jq` are small and used across workflows (debugging, file checks, JSON), so they belong in the base images rather than in a layer.
- **A D-Bus session started by the entrypoint:** Firefox on Wayland passes a new link to its running window only over D-Bus. Without a session bus, every link waits until the previous window is closed.

## Settings
- **Visual Studio Code settings follow the image layers:** `vsc-settings.json` is the base, and each layer merges its own file (`vsc-settings-<layer>.json`) into it with `jq` at build time. A workflow's settings then live next to the layer that installs its tools.
- **Settings applied on every start:** the home directory is a volume, which hides files the image copies into it once the volume exists. The merged settings are kept in `/etc/askillsagent` and copied into the user's `settings.json` by the entrypoint, so the image stays the single source of truth; changes made in the settings UI last until the next start.
- **Extensions synced with a list on every start:** for the same reason, the extensions are listed in `vsc-extensions.txt` and per-image files, combined in `/etc/askillsagent/vsc-extensions.txt`. The entrypoint uninstalls what is not on the list and installs what is missing, so the lists decide exactly which extensions a session has, a removal applies to every volume, and a new layer's extensions reach an existing one.
- **A sync rather than a full reinstall:** reinstalling every extension on each start would download a few hundred megabytes and add minutes, and leave an offline start without extensions; comparing the lists changes only the difference.
- **Plain JSON for settings files:** `jq` cannot read comments, so the settings files carry none; the reasons are recorded here and in the README.

## Agent Access
- **No GitHub CLI and no GitHub credentials in the containers:** the agent has no access to GitHub accounts, repositories or Pull Requests beyond the files mounted into the container. This follows the principle of least privilege: a mistake or a misused agent cannot publish, merge or delete anything on GitHub.
- **The Operator commits and pushes:** the agent prepares changes on a feature branch, along with the changelog and the Pull Request description; the Operator reviews, commits, pushes and merges them. The person who publishes a change takes responsibility for it, and nothing reaches a long-lived branch without review.
