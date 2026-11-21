## As an Operator, I want a hardware image with CAD tools on top of the Claude image
- Add `Dockerfiles/Claude/hardware.dockerfile`, built `FROM localhost/askillsagent`, so the base image stays lean and the extra layer rebuilds in seconds.
- Install `openscad` and `f3d` from the Fedora repositories, and the `tomoki1207.pdf` extension for Visual Studio Code.
- Check that F3D renders through the `/dev/dri` passthrough, or add the missing OpenGL libraries.
- Decide between F3D outside Visual Studio Code and an STL viewer extension inside it.
- Document the build and the image name in `Dockerfiles/README.md`; the `podman run` command only changes the image name.

## As an Operator, I want the container confined by SELinux without breaking the Wayland window
- Generate a dedicated SELinux policy for the container with `udica` (from `podman inspect askillsagent`) and install it with `semodule`.
- Replace `--security-opt label=disable` with `--security-opt label=type:askillsagent.process` in the `podman run` command.
- Add the `:Z` label to the private `$HOME/askillsagent` bind mount.
- Add the `:ro,z` labels to the `.github`, `AGENTS.md` and `CLAUDE.md` bind mounts.
- Do not relabel the Wayland socket mount; allow its access through the `udica` policy instead.
- Check for denials with `ausearch -m avc -ts recent`, then update the READMEs once confirmed working.
