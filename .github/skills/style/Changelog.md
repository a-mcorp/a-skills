<!-- This skills bundle has been generated using 'A-Skills' (https://github.com/a-mcorp/a-skills). -->
# Changelog conventions

## Semantic:
- Adhere to the [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) framework for `CHANGELOG.md` file updates or creation, unless overridden by the directives.
- Each `version` sub-header of the `CHANGELOG.md` must be a title representing the `git tag` (version) of the project encapsulated in '[]' (square brackets), followed by the ' ' (space), '-' (dash) and ' ' (space) symbols with the tag's date in 'YYYY-MM-DD' format appended right after.
- Each `version` sub-header must contain appropriate sub-sub-headers, which represent the scope of changes in the following keyword-based categories: "Added", "Changed", "Deprecated", "Removed", "Fixed", "Security", but add only categories that contain changes.
- Omit the version comparison links.
- Ignore any comments present in the `CHANGELOG.md` file.
- The changes for each category should be items of a list.
- Version numbers follow Semantic Versioning (MAJOR.MINOR.PATCH), decided by the effect on existing users - projects already built on it, copies made from a template, or anything that integrates with it.
- MAJOR: something existing users rely on is removed, renamed or changed so that they must adapt (files, options, commands, interfaces), or the licence takes rights away. A `Removed` entry, or a `Changed` entry that breaks existing use, usually means a major version.
- MINOR: something is added or changed without breaking existing use - new features or files, a template layout that only affects new copies, a licence that grants more freedom.
- PATCH: fixes only - bugs, typos, broken links - with no new or changed behaviour.
- The highest level among a release's changes decides its version.
- When `Unreleased` becomes a version, sort the entries within each category by weight, the most significant first; until then, new entries are appended.
- 1.0.0 is the first release that works as intended; until then, changes stay under `Unreleased`.
- When the level is unclear, propose a version with a one-line reason and ask the Operator.
- Every merge into the trunk (`main`, `trunk`) is a release, by design: it gets its own version and `CHANGELOG.md` section, and its tag marks that merge. A fix to a release that is already merged is therefore a new version (e.g. 1.0.1), even before the tag is set.
- Before versioning a release, check the repository's git tags, local and on the remote. When a version in `CHANGELOG.md` has no matching tag, ask the Operator whether it was released, pointing to any evidence (a merge commit or Pull Request for it, a GitHub release, a published package): it may have been released with a forgotten tag, which is then added, or never released at all. Only when it was never released, and no earlier version is tagged, does the release become the first one (1.0.0), with the untagged entries folded into it as `Added`, describing the project as it is. When asked for a version whose predecessor has no tag (e.g. 1.1.0 after an untagged 1.0.0), raise the same question before versioning.

## Technical:
- If the `CHANGELOG.md` file is missing and a template exists under the `.github/CHANGELOG_TEMPLATE` directory, then use it for creating the `CHANGELOG.md` file.
- A new project created from a template repository keeps its own history only: when its `CHANGELOG.md` still holds the template's versions, replace it with the template under `.github/CHANGELOG_TEMPLATE`. The project's first release may name the template and its version it was created from.
- If a `CHANGELOG.md` file already exists and the compliant template also exists, then update the `CHANGELOG.md` file according to the template and the scope of changes in the current branch's commits.
- If current changes are a part of a `git tag` not yet present on the remote, then use that tag as the `version` sub-header.
- If such a tag does not exist, then treat all new changes as belonging to the `Unreleased` sub-header, which is put before the latest `version` sub-header.
- The `Unreleased` sub-header uses the current date.
- Should a `git tag` appear after the most recent `version`, the `Unreleased` changes are moved into that tag's sub-header (version).
- The scope of project updates summarised in the file must reflect all commits in the current branch. Notify the Operator of any discrepancy.
- Do not update the `CHANGELOG.md` file if the current work branch is set to any of: `develop`, `dev`, `main`, `production`, `master`, `release`, or `develop/*`, `dev/*`, `main/*`, `production/*`, `master/*`, `release/*`, unless explicitly requested to do so.
- If the current work branch is set to any of: `develop`, `dev`, `main`, `production`, `master`, `release`, or `develop/*`, `dev/*`, `main/*`, `production/*`, `master/*`, `release/*` and the `CHANGELOG.md` appears outdated, then point this out to the Operator and ask how to proceed.
- If neither the `CHANGELOG.md` file nor a template under the `.github/CHANGELOG_TEMPLATE` directory exists, then do not create the file automatically; point this out to the Operator and ask how to proceed.
- The template may take precedence over directives in this skill, but should remain largely consistent with them. If conflicting directives are defined within the template, use the directives from the template.
- If a `CHANGELOG.md` file exists and the template under the `.github/CHANGELOG_TEMPLATE` directory also exists, but is incompatible, then notify the Operator of the conflict and ask how to proceed.
- If a `CHANGELOG.md` file incompatible with the directives exists, then notify the Operator of the conflict. Otherwise, compatible files should be processed as defined by the directives.