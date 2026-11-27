# ================================
# Name: 'a-skills'/Dockerfiles/Claude/askillsAgent.dockerfile
# Source: https://github.com/a-mcorp/a-skills
# SPDX-License-Identifier: AGPL-3.0-or-later
# Year: 2026
# ================================

# Fedora
# Build context is 'Dockerfiles/'
FROM registry.fedoraproject.org/fedora:latest

# There are 3 types of 'Claude Code' apps
# https://code.claude.com/docs/en/setup

ARG ARCH=amd64
ARG UID=1000
ARG REPOSITORY_CLAUDE_DESKTOP=https://downloads.claude.ai/claude-desktop/apt/stable
ARG REPOSITORY_CLAUDE_CODE=https://downloads.claude.ai/claude-code/rpm/stable
ARG KEY_REPOSITORY_CLAUDE_CODE=https://downloads.claude.ai/keys/claude-code.asc
ARG REPOSITORY_VSC=https://packages.microsoft.com/yumrepos/vscode
ARG KEY_REPOSITORY_VSC=https://packages.microsoft.com/keys/microsoft.asc
ARG REPOSITORY_FLATHUB=https://flathub.org/repo/flathub.flatpakrepo

# Install Flatpak (which is normally included OOB)
# 'openssl3-libs' lets VS Code 'vsce-sign' verify extension signatures, as Fedora 45+ ships only OpenSSL 4.
RUN dnf -y install curl dpkg flatpak git openssl3-libs shadow-utils \
    && dnf clean all

# General-purpose tools: 'ps' for processes, 'file' for file types and 'jq' for JSON.
# 'jq' also merges each image layer's VS Code settings into the base ones.
RUN dnf -y install procps-ng file jq \
    && dnf clean all

# Enable Flatpak repositories
RUN flatpak remote-add --system --if-not-exists flathub \
    "$REPOSITORY_FLATHUB"

# Install Chrome and Gearlever for AppImages
#RUN flatpak install --system --noninteractive flathub \
#      com.google.Chrome it.mijorus.gearlever
#RUN flatpak install --system --noninteractive flathub \
#    it.mijorus.gearlever

# Download Claude Desktop App (Linux beta ships only as .deb, so it is extracted without apt)
RUN mkdir -p /opt/Downloads \
    && DEB_PATH=$(curl -fsSL "$REPOSITORY_CLAUDE_DESKTOP/dists/stable/main/binary-${ARCH}/Packages" \
    | grep '^Filename: pool/main/c/claude-desktop/claude-desktop_' | sort -V | tail -n 1 | cut -d' ' -f2) \
    && curl -fL "$REPOSITORY_CLAUDE_DESKTOP/$DEB_PATH" -o /opt/Downloads/claude-desktop.deb \
    && dpkg-deb -x /opt/Downloads/claude-desktop.deb / \
    && rm -rf /opt/Downloads

# Install the official Visual Studio Code
RUN tee /etc/yum.repos.d/vscode.repo > /dev/null <<EOF
[code]
name=Visual Studio Code
baseurl=$REPOSITORY_VSC
enabled=1
autorefresh=1
type=rpm-md
gpgcheck=1
gpgkey=$KEY_REPOSITORY_VSC
EOF

RUN dnf -y install code \
    && dnf clean all

# Install Claude Code CLI
RUN tee /etc/yum.repos.d/claude-code.repo > /dev/null <<EOF
[claude-code]
name=Claude Code
baseurl=$REPOSITORY_CLAUDE_CODE
enabled=1
gpgcheck=1
gpgkey=$KEY_REPOSITORY_CLAUDE_CODE
EOF

RUN dnf -y install claude-code \
    && dnf clean all

# Install and set Firefox as the default
RUN dnf install -y firefox xdg-utils && \
    dnf clean all

# Writing custom desktop entry handler for opening links with Firefox
RUN printf '%s\n' \
    '[Desktop Entry]' \
    'Name=VS Code URL Handler (container)' \
    'Type=Application' \
    'NoDisplay=true' \
    'Exec=/usr/share/code/code --no-sandbox --disable-gpu-sandbox --password-store=basic --ozone-platform=wayland --open-url %U' \
    'MimeType=x-scheme-handler/vscode;' \
    > /usr/share/applications/code-container-url-handler.desktop \
    && mkdir -p /etc/xdg \
    && printf '%s\n' \
    '[Default Applications]' \
    'x-scheme-handler/http=org.mozilla.firefox.desktop' \
    'x-scheme-handler/https=org.mozilla.firefox.desktop' \
    'text/html=org.mozilla.firefox.desktop' \
    'x-scheme-handler/vscode=code-container-url-handler.desktop' \
    > /etc/xdg/mimeapps.list

# Essentially bypassing tab isolation/sandboxing in Firefox, which does not work in Podman due to '--cap-drop=ALL and no-new-privileges' of container setup.
ENV BROWSER=firefox \
    MOZ_DISABLE_CONTENT_SANDBOX=1 \
    MOZ_DISABLE_RDD_SANDBOX=1 \
    MOZ_DISABLE_SOCKET_PROCESS_SANDBOX=1 \
    MOZ_DISABLE_UTILITY_SANDBOX=1 \
    MOZ_DISABLE_GMP_SANDBOX=1

# Set dark mode for everything in the container
ENV GTK_THEME=Adwaita:dark

# Session setup, incl. Terminal from Fedora Silverblue.
# RUN dnf -y install dbus-daemon ptyxis && dnf clean all
RUN dnf -y install foot && dnf clean all

# D-Bus session bus, started by the entrypoint. Firefox on Wayland passes new links to its open window only over D-Bus; without it, each link waits until the previous window is closed.
RUN dnf -y install dbus-daemon && dnf clean all

# Microphone input through the host's PulseAudio socket, mounted in 'podman run'. The default ALSA device is pointed at that socket, since 'pipewire-alsa' would need the unmounted 'pipewire-0' socket.
RUN dnf -y install alsa-plugins-pulseaudio pulseaudio-libs sox && dnf clean all \
    && printf '%s\n' 'pcm.!default { type pulse }' 'ctl.!default { type pulse }' > /etc/asound.conf

COPY --chmod=755 Claude/entrypoint.sh /usr/local/bin/entrypoint

# VS Code extensions: the shared list plus the Claude Code extension, outside the home volume. Layers append their own lists,
# and the entrypoint syncs the volume with the result on every start.
COPY vsc-extensions.txt vsc-extensions-claude.txt /tmp/
RUN mkdir -p /etc/askillsagent \
    && cat /tmp/vsc-extensions.txt /tmp/vsc-extensions-claude.txt > /etc/askillsagent/vsc-extensions.txt \
    && rm /tmp/vsc-extensions*.txt

# Run with '--userns=keep-id' so this UID maps to the host user and root inside the container is not root on the host.
# Only the folders chosen in 'podman run' are mounted, and '/run/user/1000' is an in-memory 'tmpfs'.
RUN useradd -m -U -u "${UID}" -s /bin/bash agent \
    && mkdir -p /workspaces /mnt/share \
    && chown agent:agent /workspaces /mnt/share

USER agent
WORKDIR /workspaces
RUN code --no-sandbox \
    && mkdir -p /home/agent/.config/Code/User /home/agent/.claude

# Base VS Code settings, kept outside the home volume. Image layers merge their own settings into this file, and the entrypoint applies it on every start.
COPY vsc-settings.json /etc/askillsagent/vsc-settings.json

# Claude Code settings, enabling voice dictation in tap mode by default.
COPY --chown=agent:agent vsc-claude.json \
    /home/agent/.claude/settings.json

ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD ["claude-vsc"]