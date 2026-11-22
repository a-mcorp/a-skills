<!-- This skills bundle has been generated using 'A-Skills' (https://github.com/a-mcorp/a-skills). -->
# Comment conventions

## Semantic:
- Keep the comments short and simple.
- Each `code construct` in a programming, scripting or declarative configuration language (such as HCL) should have at most 2 comments.
- Each generated comment cannot be longer than 2 sentences.

## Technical:
- Do not modify existing comments, unless fixing the overall grammatical correctness.
- Comments may only be extended by adding a language-specific comment annotation with the new text next to the old one.
- When adding comments, prefix them with "Auto-generated", followed by the ':' symbol and the content of the comment.
- Source code and configuration that carries the project's work (e.g. `.ts`, `.py`, `.scad`, Dockerfiles, `pyproject.toml`, `deno.jsonc`, `lefthook.yml`, `.pre-commit-config.yaml`) start with the attribution header in the comment syntax of the file, in the same form as the existing files: `Name: '<repository>'/<path>`, `Source: <repository URL>`, `SPDX-License-Identifier: <licence>`, `Year: <year of creation>`, and optionally `Comments:`, between two `================================` lines. In a file copied from a template, `Name` and `Source` keep pointing to the template, and the licence is the current repository's. Documentation, generated files, data and JSON files get no header.
- Agent skills carry a one-line origin comment instead of the full header, at the top of each `SKILL.md` and each extension file, so every file that can be copied on its own still shows where it comes from.
- Do not generate comments if a file matches one in the list: ['outputs.tf', 'versions.tf', 'variables.tf' ]