# ================================
# Name: 'a-skills'/Dockerfiles/Claude/latex.dockerfile
# Source: https://github.com/a-mcorp/a-skills
# SPDX-License-Identifier: AGPL-3.0-or-later
# Year: 2026
# ================================

# Fedora - LaTeX tools on top of the Claude Code image, or on top of another layer through BASE_IMAGE
# Build context is 'Dockerfiles/'; build the Claude Code image first (see README.md)
ARG BASE_IMAGE=docker.io/library/askillsagent
FROM ${BASE_IMAGE}

# Tectonic from its GitHub release, as Fedora does not package it. It downloads only the TeX packages a document
# uses, and caches them in the home volume, instead of a full TeX Live install.
ARG TECTONIC_VERSION=0.17.0
ARG TECTONIC_SHA256=8533d07f9ccbd7a65824b9e0459041bca34af1eb33daba48f59215593753a3b7

USER root

# The static 'musl' build runs without extra libraries.
RUN curl -fsSL -o /tmp/tectonic.tar.gz \
      "https://github.com/tectonic-typesetting/tectonic/releases/download/tectonic%40${TECTONIC_VERSION}/tectonic-${TECTONIC_VERSION}-x86_64-unknown-linux-musl.tar.gz" \
    && echo "${TECTONIC_SHA256}  /tmp/tectonic.tar.gz" | sha256sum -c - \
    && tar -xzf /tmp/tectonic.tar.gz -C /usr/local/bin tectonic \
    && chmod 755 /usr/local/bin/tectonic \
    && rm /tmp/tectonic.tar.gz

# 'latexindent' formats LaTeX files on save in LaTeX Workshop; Tectonic does not include it.
RUN dnf -y install texlive-latexindent \
    && dnf clean all

# VS Code settings for LaTeX work, merged into the base settings that the entrypoint applies.
COPY vsc-settings-latex.json /etc/askillsagent/vsc-settings-latex.json
RUN jq -s '.[0] * .[1]' /etc/askillsagent/vsc-settings.json /etc/askillsagent/vsc-settings-latex.json \
      > /tmp/vsc-settings.json \
    && mv /tmp/vsc-settings.json /etc/askillsagent/vsc-settings.json

# VS Code extensions for LaTeX work, appended to the image's list that the entrypoint syncs on every start.
COPY vsc-extensions-latex.txt /tmp/vsc-extensions-latex.txt
RUN cat /tmp/vsc-extensions-latex.txt >> /etc/askillsagent/vsc-extensions.txt \
    && rm /tmp/vsc-extensions-latex.txt

USER agent

ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD ["claude-vsc"]
