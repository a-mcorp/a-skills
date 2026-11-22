<!-- This skills bundle has been generated using 'A-Skills' (https://github.com/a-mcorp/a-skills). -->
# Contributing conventions

## Semantic:
- The 'Maintainer' is the owner of the repository. These conventions apply to every Contributor, the Maintainer included.

## Technical:
- Follow the existing layout, naming and comment style of the repository.
- A new repository copies an existing template where one fits its use case, and includes only the tools it needs.
- Do not use Conventional Commits prefixes (e.g. 'feat:', 'chore:', 'docs:'). Write plain, descriptive commit messages.
- Commit changes on a `feature/<acronym>` branch, then open a Pull Request from the repository's template, with a descriptive title and the new `CHANGELOG.md` entries copied into its description. Pull Requests are squashed into `develop` or the trunk.
- The Operator commits and pushes the changes, and takes responsibility for them.
- Changes reach the trunk branches (`trunk`, `main`) only through Pull Requests, squashed on merge; never commit, merge or force push into them directly.
- When filling in a Pull Request template, keep all of its comments (`<!-- ... -->`) and write each section's content below its comment. Copy the new `CHANGELOG.md` entries into the Changelog section. For a release, start the title with the version (e.g. "1.1.0 - ..."), and use "Release <version>:" as the Changelog section's story line; the version appears only there - the Summary and Comments may name the level (major, minor or patch) instead.
- The Summary is a short description of the work as a whole, in prose, not a list; the Changelog section lists every change. Examples (screenshots of new features, or anything worth showing) and Testing are filled in when they apply, at the Operator's discretion; leave them with only their comment otherwise, e.g. in repositories without a testing routine.
- A Pull Request description describes the changes; it does not tell the Maintainer or other Contributors what to do next (e.g. tagging or merging), since those steps depend on each repository's workflow.
- Tick the "An assistant helped to write these changes" checkbox in the Pull Request template when an assistant helped to write the changes; without such a checkbox, state it in the description.
- Never put personal names or other personal data in code or comments; authorship is recorded in git and the Pull Requests. This keeps the repository compliant with the GDPR and similar data protection rights: personal data in code would have to be found and removed by hand when someone asks for it. Copyright lines, licence notices and the attributions they require are the exception.
- In a repository being contributed to, never change the `LICENSE` or `NOTICE` files, the copyright lines or the existing attributions (file headers, credits, maker's marks). New files take the repository's licence.
- A new project created from a template may choose its own licence only where the template's licence allows it, and keeps the attributions that licence requires.
- New tools and dependencies are welcome, but need the Maintainer's approval, usually in the Pull Request. Name each one and the reason for it in the description.
- Do not edit generated files by hand (marked as generated in their header or the `README.md`, e.g. a `BOM.md` written by a script). Change their source files and run the tool instead. Point out a value that is plainly wrong in the Pull Request.
- Never commit third-party documents (datasheets, drawings, manuals). Link them instead.
