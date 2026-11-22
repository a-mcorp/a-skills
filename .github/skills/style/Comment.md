<!-- This skills bundle has been generated using 'A-Skills' (https://github.com/a-mcorp/a-skills). -->
# Comment conventions

## Semantic:
- Keep comments short and simple.
- Give each code construct in a programming, scripting or declarative configuration language (such as HCL) at most 2 comments.
- Limit each generated comment to 2 sentences.

## Technical:
- Do not modify existing comments, except to correct their grammar.
- Extend a comment only by adding a new one next to it, in the comment syntax of the language.
- Prefix new comments with "Auto-generated:", followed by their content.
- Start source code and configuration that carries the project's work (source files, Dockerfiles, build and tool configuration) with the attribution header, in the comment syntax of the file and in the form of the existing files: `Name: '<repository>'/<path>`, `Source: <repository URL>`, `SPDX-License-Identifier: <licence>`, `Year: <year of creation>`, and optionally `Comments:`, between two `================================` lines. In a file copied from a template, `Name` and `Source` keep pointing to the template, and the licence is that of the current repository. Documentation, generated files, data and JSON files take no header.
- Give agent skills a one-line origin comment instead of the full header, at the top of each `SKILL.md` and each extension file, so that every file copied on its own shows its source.
- Do not generate comments in the files 'outputs.tf', 'versions.tf' and 'variables.tf'.
