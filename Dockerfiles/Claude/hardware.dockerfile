# Fedora - hardware tools on top of the Claude Code image
# Build context is 'Dockerfiles/'; build the Claude Code image first (see README.md)
ARG BASE_IMAGE=docker.io/library/askillsagent
FROM ${BASE_IMAGE}

# OpenSCAD from its GitHub release: the Manifold backend renders in a fraction of a second where Fedora's
# 2021.01 (CGAL) takes minutes, and it writes PNG previews through EGL, without an X server.
# A release candidate for now - change both values once the final release is out.
ARG OPENSCAD_VERSION=2026.11-RC0
ARG OPENSCAD_SHA256=78c2050aedcf52cca0186151cdcda1118a771491e3bec934b3172d0b03a9de96

USER root

# CAD: F3D views STL and 3MF files; Mesa's EGL and software renderer draw the previews without a display.
# Meshes, photos and datasheets: 'admesh' checks STL files for holes and broken surfaces, 'exiftool' reads and
# strips photo metadata, 'poppler-utils' turns PDF drawings into text or images, Pillow crops and scales photos.
# 'time' measures how long a render takes.
RUN dnf -y install f3d mesa-dri-drivers mesa-libEGL admesh perl-Image-ExifTool poppler-utils python3-pillow time \
    && dnf clean all

# The AppImage cannot mount itself without FUSE in the container, so it is unpacked once and linked as 'openscad';
# the unpacked folder is private to root, so it is opened up for the 'agent' user
RUN curl -fsSL -o /tmp/openscad.AppImage \
      "https://github.com/openscad/openscad/releases/download/openscad-${OPENSCAD_VERSION}/OpenSCAD-${OPENSCAD_VERSION}-x86_64.AppImage" \
    && echo "${OPENSCAD_SHA256}  /tmp/openscad.AppImage" | sha256sum -c - \
    && chmod +x /tmp/openscad.AppImage \
    && cd /opt && /tmp/openscad.AppImage --appimage-extract >/dev/null \
    && mv /opt/squashfs-root /opt/openscad \
    && chmod -R a+rX /opt/openscad \
    && ln -s /opt/openscad/AppRun /usr/local/bin/openscad \
    && rm /tmp/openscad.AppImage

USER agent

# PDF viewer inside VS Code; the cached '.vsix' is removed in the same layer, like in the base image
RUN code --install-extension tomoki1207.pdf \
    && rm -rf /home/agent/.config/Code/CachedExtensionVSIXs

ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD ["claude-vsc"]
