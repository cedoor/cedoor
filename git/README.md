![Git](https://www.vectorlogo.zone/logos/git-scm/git-scm-ar21.svg)

Git configuration files and some rules to improve development.

## :hammer: Install

Run `install.sh` script with curl to set configuration files in your file system:

```bash
source <(curl -s https://raw.githubusercontent.com/cedoor/cedoor/main/git/install.sh)
```

## Commits rules

For commits it is recommended to use [Conventional Commits](https://www.conventionalcommits.org).

Each commit message consists of a **header**, a **body** and a **footer**. The **header** has a special format that includes a **type**, a **scope** and a **subject**:

    <type>(<scope>): <subject>
    <BLANK LINE>
    <body>
    <BLANK LINE>
    <footer>

The **header** is mandatory and the **scope** of the header is optional.

### Type

The type must be one of the following:

- feat: A new feature
- fix: A bug fix
- docs: Documentation only changes
- style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- refactor: A code change that neither fixes a bug nor adds a feature (improvements of the code structure)
- perf: A code change that improves the performance
- test: Adding missing or correcting existing tests
- build: Changes that affect the build system or external dependencies (example scopes: gulp, npm)
- ci: Changes to CI configuration files and scripts (example scopes: travis, circle)
- chore: Other changes that don't modify src or test files
- revert: Reverts a previous commit

### Scope

The scope should be the name of the npm package affected (as perceived by the person reading the changelog generated from commit messages).

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
