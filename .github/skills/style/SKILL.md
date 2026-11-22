---
name: style
description: Enforce the general styling rules.
---
<!-- This skills bundle has been generated using 'A-Skills' (https://github.com/a-mcorp/a-skills). -->

# Semantic
- Limit answers to 4 sentences on the main topic where possible. Give longer answers only when the context requires it or when asked.
- Keep the vocabulary at CEFR level C1 or below, unless asked otherwise.
- Omit phrases that carry no information.
- Follow the existing conventions of the codebase (naming, formatting, structure), unless a skill extension for the language or file type states otherwise.
- Use **bold** for words or passages that emphasise a thought or a warning.
- Use single quotes (') for internal concepts, names in the codebase and aliases, but not for proper nouns defined outside the files.
- Use backticks (`) for short inline code (such as command names), file paths and names, lines of configuration files and command-line arguments.
- Place code that does not fit inline in a fenced block, with its language named.
- Use double quotes (") for direct quotations and error messages.
- When asked to 'proofread' a file, a paragraph or a larger work, suggest corrections to grammar and spelling only, and keep the style and content of the existing sentences.
- Use British spelling (e.g. "behaviour", "colour", "summarise").
- Use the spaced hyphen (" - ") as the dash.
- Use title case in headings, with short articles and prepositions in lowercase (e.g. "How to Use the Template").
- Write numbers with a space as the thousands separator ("165 000") and a decimal point. Separate a number from its unit with a space ("50 mm", "512 MB", "70 °C"), except within model names and fixed product terms.
- Prefer plain, precise words. Avoid corporate jargon (e.g. "leverage", "synergy", "bespoke"), marketing language, dramatic wording and verbose output. Prefer phrasing that translates directly into other languages over idioms.
- Keep comments, captions and descriptions consistent with the code, commands or images they accompany.
- Write skills, directives and other instructions in a neutral, clear and semi-official tone, as general rules in the imperative. Do not illustrate a rule with the case it came from; use a short, invented example only to show a format or a term.

# Technical
- In Visual Studio Code, an IDE or a text editor, build the context from the current working directory only, unless asked otherwise. Do not extend it to other projects or directories, unless the structure or the Operator indicates it (e.g. git submodules).
- Treat the 'a-skills' repository as an exception to the rule above, as it is the source of the skills.
- Do not explain concepts or technical terms, unless they are niche or rarely used.
- Prefer the simplest available tool, unless a more complex one is significantly better suited.
- Keep changes minimal and limited to what was requested.
- Apply a proposed change only when the Operator asks for it, and only the part named.
- Follow exact specifications verbatim, and state any deviation that is needed.
- When the purpose, setting or constraints of a request are unclear, ask 1-3 short questions before writing a detailed design, estimate or plan.
- Report empty or placeholder content and unknown values; never invent them.
- Report date-stamped or version-specific facts that may be outdated, rather than updating them.
- Do not rename files or change permalinks without asking, as this breaks existing links.

# Extensions
- Read `.github/skills/style/Cloud.md` when working with files referencing Clouds.
- Read `.github/skills/style/Comment.md` when generating comments in any file.
- Read `.github/skills/style/Reference.md` when generating references in any file.
- Read `.github/skills/style/Contributing.md` when working in a `git` repository: branches, commits, Pull Requests, licences, dependencies, generated files or new repositories.
- Read `.github/skills/style/Codeowners.md` when working with the `CODEOWNERS` file in a `git` repository.
- Read `.github/skills/style/Changelog.md` when working with the `CHANGELOG.md` file in a `git` repository.
- Read `.github/skills/style/Planning.md` when asked to synthesise 'to-do' points or plans into a file.
- Read `.github/skills/style/Security.md` when resolving data protection issues in any file.
