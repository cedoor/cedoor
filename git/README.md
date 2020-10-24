# Git

Git configuration files and some rules to improve development.

## Commits rules

Each commit message consists of a header and a body. The header has a special format that includes a type and a subject:

    [<type>] <subject>
    <BLANK LINE>
    <body>

### Type

The type must be one of the following:

- init: Initial commit, usually a commit to set up a basic structure to start from
- asset: A new asset
- feat: A new feature
- test: Adding missing or correcting existing tests
- drop: A feature/test or asset removal
- fix: A bug fix
- docs: Documentation changes
- reformat: Changes that do not affect the meaning of the code (e.g. indent line, trim space)
- optimize: Changes that improve the performance of the code
- refactor: A code change that neither fixes a bug nor adds a feature (improvements of the code structure)
- conf: Changes to configuration files (e.g. build process or auxiliary tools, libraries such as documentation generation)
- deps: A dependency removal or changes to dependency versions

### Subject

The subject contains a succinct description of the change:

- Use the imperative, present tense: "change" not "changed" nor "changes"
- Don't capitalize the first letter
- No dot (.) at the end

### Body

Just as in the subject, use the imperative, present tense: "change" not "changed" nor "changes". The body should include the motivation for the change and contrast this with previous behavior.

## Branch rules

- There must be a `master` branch, used only for the releases
- There must be a `dev` branch, used to merge all the branches under `dev`
- Avoid long descriptive names for long-lived branches
- Use kebab-case (no CamelCase)
- Use grouping tokens (words) at the beginning of your branch names (in a similar way to the `type` of commit)
- Define and use short lead tokens to differentiate branches in a way that is meaningful to your workflow
- Use slashes to separate parts of your branch names
- Remove branch after merge if it is not important

Examples:

```bash
git branch -b docs/readme
git branch -b test/a-feature
git branch -b feat/sidebar
git branch -b fix/b-feature
```
