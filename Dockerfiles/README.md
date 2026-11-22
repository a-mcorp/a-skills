# ToC
- [ToC](#toc)
- [Podman](#podman)
  - [Operator](#operator)
  - [Microphone](#microphone)
  - [Commands](#commands)
    - [GitHub Copilot image](#github-copilot-image)
    - [Claude Code image](#claude-code-image)
  - [Hardware image](#hardware-image)
- [Extensions](#extensions)

# Podman
In order to start the container, first build the container using one of the Docker images under `Dockerfiles`.

There are two types of images:
- Claude Code based agent
- Copilot based agent

Subsequently, in order to run a built image, run Podman with the following command. It starts the image's default entrypoint (`copilot-vsc` or `claude-vsc`), see [Commands](#commands):

```Bash
podman run --rm -it --name askillsagent \
  --userns=keep-id:uid=1000,gid=1000 \
  --cap-drop=ALL --security-opt=no-new-privileges --security-opt label=disable \
  --device /dev/dri --shm-size=1g --hostname sandbox \
  --mount type=tmpfs,destination=/run/user/1000,tmpfs-mode=0700,U=true \
  -e WAYLAND_DISPLAY -e XDG_RUNTIME_DIR=/run/user/1000 \
  -v "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/run/user/1000/$WAYLAND_DISPLAY" \
  -e ELECTRON_OZONE_PLATFORM_HINT=wayland -e MOZ_ENABLE_WAYLAND=1 \
  -v askillsagent-home:/home/agent \
  -v askillsagent-workspaces:/workspaces \
  -v "$HOME/askillsagent:/workspaces/main-workspace" \
  -v "{host-path}/a-skills/.github:/workspaces/.github" \
  -v "{host-path}/a-skills/AGENTS.md:/workspaces/AGENTS.md" \
  -v "{host-path}/a-skills/CLAUDE.md:/workspaces/CLAUDE.md" \
  docker.io/library/askillsagent
```
Files may be dropped into the host's `$HOME/askillsagent` directory, or multiple different directories can be mounted under their own appropriate names.

In this simple way entire working directories can be easily exposed to the agent ad-hoc, while making sure it does not crawl into every file of the host by default.

> **Known issue:** The `--security-opt label=disable` flag turns off SELinux labelling for the container, because the default labels block access to the Wayland socket and `/dev/dri`, which the window needs. The container stays isolated by namespaces, dropped capabilities and `--userns=keep-id`.

## Operator
The `A_SKILLS_OPERATOR` variable selects the engram - your own custom assistant - loaded from `.github/skills/engrams`; left empty or unset, none is loaded. In order to set it, add this line to the `podman run` command above, before the image name:

```Bash
  -e A_SKILLS_OPERATOR={engram} \
```

## Microphone
Wayland does not carry audio, so the microphone is passed through the host's PulseAudio socket (served by `pipewire-pulse` on Fedora). In order to enable voice input (e.g. `/voice` in the Claude Code CLI, or dictation in the Visual Studio Code extension), add these two lines to the `podman run` command above, before the image name:

```Bash
  -e PULSE_SERVER=unix:/run/user/1000/pulse/native \
  -v "$XDG_RUNTIME_DIR/pulse/native:/run/user/1000/pulse/native" \
```

Check that the microphone works inside the container with `rec -c 1 /tmp/test.wav` (stop with `Ctrl+C`), then play it back on the host or with `play /tmp/test.wav`.

> **Warning:** The socket gives the container access to all of the host's audio inputs and outputs, at any time while it runs. Leave these lines out when voice input is not needed.

The Claude Code image enables voice dictation in tap mode by default, via [vsc-claude.json](vsc-claude.json) copied to `~/.claude/settings.json`.

> **Note:** Claude Code voice dictation needs a Claude.ai account login (not an API key), and it sends the recorded audio to Anthropic for transcription.

## Commands
Each image starts one app as entrypoint (VSC by default), which may be overwritten by one of the entrypoint's options passed at the end of the `podman run` command (e.g. `copilot-cli` instead of `copilot-vsc`). The same entry options can be run in VSC's terminal inside a running container using the system paths and they are documented in the table below.

### GitHub Copilot image
| Entrypoint | App | Direct command in the container |
|---|---|---|
| `copilot-vsc` (default) | Visual Studio Code | — |
| `copilot-app` | GitHub Copilot App | `copilot-app` |
| `copilot-cli` | GitHub Copilot CLI | `copilot` |
| `browser` | Firefox | `firefox` |
| `terminal` | Bash login shell | `foot` |

### Claude Code image
| Entrypoint | App | Direct command in the container |
|---|---|---|
| `claude-vsc` (default) | Visual Studio Code | — |
| `claude-app` | Claude Desktop App | `claude-desktop --no-sandbox --no-zygote --disable-gpu-sandbox --password-store=basic --ozone-platform=wayland` |
| `claude-cli` | Claude Code CLI | `claude` |
| `browser` | Firefox | `firefox` |
| `terminal` | Bash login shell | `foot` |

> **Note:** GitHub Copilot is built into Visual Studio Code and enabled by default, also in the Claude Code image. To (optionally) avoid confusion between the Copilot and Claude Code tools, it may be the best to disable some settings in the personal `settings.json` (see [SETTINGS.md](SETTINGS.md)):
> - `"chat.agent.enabled": false` disables only the Copilot agent mode, which runs tools and terminal commands.
> - `"chat.disableAIFeatures": true` disables all built-in AI features, including Copilot chat, inline suggestions and the Copilot extensions.

The GitHub Copilot CLI (`copilot`), the GitHub Copilot App (`copilot-app`) and the Claude Code CLI (`claude`) start without any extra parameters.

> **Known issue:** the Claude Desktop App is the only exception in this image. It needs the `--no-sandbox`, `--no-zygote` and `--disable-gpu-sandbox` flags, because the container's `--cap-drop=ALL` and `no-new-privileges` options prevent the Chromium sandbox from starting. Without them, it fails with "Zygote process exited prematurely with exit code -1".

## Hardware image
An optional layer on top of the Claude Code image, for hardware projects: OpenSCAD (the AppImage from its GitHub release, with the fast Manifold backend), F3D for viewing STL and 3MF files, `admesh` for checking them, `exiftool` for photo metadata, `poppler-utils` for PDF datasheets and drawings, Pillow for photos, `time`, and a PDF viewer in Visual Studio Code. Build the Claude Code image first, then:

```Bash
podman build --pull=never -f Dockerfiles/Claude/hardware.dockerfile \
  -t docker.io/library/askillsagent-hardware Dockerfiles/
```

`--pull=never` makes sure the build uses the local Claude Code image and never looks it up on a registry. Run it with the `podman run` command above, replacing only the image name with `docker.io/library/askillsagent-hardware`. The entrypoints are the same as in the Claude Code image.

The OpenSCAD version is set by `OPENSCAD_VERSION` and checked against `OPENSCAD_SHA256` at the top of the file; change both for a newer release. OpenSCAD renders and writes PNG previews without a window, e.g.:

```Bash
openscad --backend=manifold -D 'part="back"' -o back.stl cad/enclosure.scad
openscad -D 'part="back"' --viewall --autocenter --imgsize=1200,1200 -o back.png cad/enclosure.scad
```

> **Note:** OpenSCAD runs from the command line only. The AppImage bundles Qt 6.2 with an X11 plugin and no Wayland one, so its window cannot open in this Wayland-only container; edit in OpenSCAD on the host, while the container renders, checks and previews.

> **Note:** the `askillsagent-home` volume keeps the extensions it already holds, so the PDF viewer only appears in a new volume, or after installing it once with `code --install-extension tomoki1207.pdf`.

# Extensions
In order to adjust `vsc-settings.json` either have a look personally into the [SETTINGS.md](SETTINGS.md) file, where all up-to-date (more or less) settings for both Claude and Copilot are defined, or task the agent with updating it itself.