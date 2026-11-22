## As an Operator, I want a hardware image with CAD tools on top of the Claude image
- ~~Add `Dockerfiles/Claude/hardware.dockerfile`, built on top of the Claude image~~ - with the OpenSCAD AppImage (2026.11-RC0, Manifold), F3D, Mesa, `admesh`, `exiftool`, `poppler-utils`, Pillow, `time` and the `tomoki1207.pdf` extension.
- Switch `OPENSCAD_VERSION` and `OPENSCAD_SHA256` to the final 2026.11 release once it is out.
- ~~Check that F3D renders through the `/dev/dri` passthrough~~ - its window needs X11, so it runs offscreen only ("interactive rendering is disabled"); it still writes PNG previews.
- ~~Check that OpenSCAD writes PNG previews without a display~~ - it does, through EGL (tested 2026-11-21).
- Try an STL viewer extension in Visual Studio Code, which renders inside its own Wayland window - F3D's window is not available.
- ~~OpenSCAD window in the container~~ - not possible with the AppImage (Qt 6.2, X11 plugin only); the host's OpenSCAD is used for editing, the container's for the command line.
- ~~Document the build and the image name in `Dockerfiles/README.md`~~.

## As an Operator, I want the container confined by SELinux without breaking the Wayland window
- Generate a dedicated SELinux policy for the container with `udica` (from `podman inspect askillsagent`) and install it with `semodule`.
- Replace `--security-opt label=disable` with `--security-opt label=type:askillsagent.process` in the `podman run` command.
- Add the `:Z` label to the private `$HOME/askillsagent` bind mount.
- Add the `:ro,z` labels to the `.github`, `AGENTS.md` and `CLAUDE.md` bind mounts.
- Do not relabel the Wayland socket mount; allow its access through the `udica` policy instead.
- Check for denials with `ausearch -m avc -ts recent`, then update the READMEs once confirmed working.
