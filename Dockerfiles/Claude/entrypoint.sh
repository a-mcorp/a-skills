#!/usr/bin/env bash
# ================================
# Name: 'a-skills'/Dockerfiles/Claude/entrypoint.sh
# Source: https://github.com/a-mcorp/a-skills
# SPDX-License-Identifier: AGPL-3.0-or-later
# Year: 2026
# ================================

set -euo pipefail

# Start a D-Bus session, then rerun the script inside. Requirement for Ptyxis
# Firefox also needs it to open links as new tabs in its running window, since on Wayland it reaches that window only over D-Bus.
if [[ -z "${DBUS_SESSION_BUS_ADDRESS:-}" ]] && command -v dbus-run-session >/dev/null; then
  exec dbus-run-session -- "$0" "$@"
fi

F=(--no-sandbox --disable-gpu-sandbox --password-store=basic --ozone-platform=wayland --enable-features=UseOzonePlatform,WaylandWindowDecorations)
command="${1:-code}"
if (($# > 0)); then shift; fi

case "$command" in
  claude-vsc)
    # Sync the home volume's extensions with the image's list on every start, as the volume hides the image's files: extensions
    # not on the list are removed and missing ones installed. A failed download (e.g. offline) does not stop the start.
    if [[ -f /etc/askillsagent/vsc-extensions.txt ]]; then
      wanted=$(grep -v '^[[:space:]]*$' /etc/askillsagent/vsc-extensions.txt | tr '[:upper:]' '[:lower:]' | sort -u)
      installed=$(code --list-extensions 2>/dev/null | tr '[:upper:]' '[:lower:]' | sort -u || true)
      comm -13 <(echo "$wanted") <(echo "$installed") | while read -r extension; do
        if [[ -n "$extension" ]]; then code --uninstall-extension "$extension" || true; fi
      done
      comm -23 <(echo "$wanted") <(echo "$installed") | while read -r extension; do
        if [[ -n "$extension" ]]; then code --install-extension "$extension" || true; fi
      done
      rm -rf "$HOME/.config/Code/CachedExtensionVSIXs"
    fi
    # Apply the image's VS Code settings on every start, as the home volume hides files copied into the image. Changes made in the UI last until the next start.
    install -D -m 644 /etc/askillsagent/vsc-settings.json "$HOME/.config/Code/User/settings.json"
    args=("$@")
    ((${#args[@]})) || args=(/workspaces)
    exec /usr/share/code/code --wait "${F[@]}" --extensions-download-dir=/tmp/vsc-vsix "${args[@]}"
    ;;
  claude-app)
    exec claude-desktop "${F[@]}" --no-zygote "$@"
    ;;
  claude-cli)
    exec claude "$@"
    ;;
  browser)
    exec firefox "$@"
    ;;
  terminal)
    exec bash -l
    ;;
  *)
    exec "$command" "$@"
    ;;
esac
