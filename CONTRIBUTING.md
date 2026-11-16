# Contributing to kinetic-kit

Thanks for your interest.
Contributions are welcome!
Please read this document before opening an issue or pull request.

## Scope & KSP approval

kinetic-kit is the official template for doctoral theses published through KIT Scientific Publishing (KSP).
Because of that approval, not every change is equally easy to land:

- **Straightforward:** bug fixes, typos, documentation, examples, tests, tooling,
  and any change that does **not** alter the rendered document output.
- **Harder to merge:** anything that changes the templates *layout or
  formatting* (margins, fonts, headings, title page, numbering, …). Output-altering
  changes may need to be re-approved by KSP before they can ship, so they take
  longer and may not be accepted if they conflict with KSP's requirements.
  **Please open an issue to discuss before investing effort.**

## How to contribute

1. **Open an issue** describing the bug or proposal, especially for anything output-affecting (see above).
2. Fork the repository and create a branch.
3. Make your change and ensure the checks pass locally (see below).
4. Open a pull request referencing the issue.

## Development

This project uses [mise](https://mise.jdx.dev) to manage tasks and pinned tooling
(Typst, tytanic, typstyle, Python, ruff). With it installed:

```bash
mise install       # fetch the pinned toolchain
mise run build     # compile examples, API docs, template, and thumbnail
mise run test      # run the tytanic test suite
mise run format    # format all Typst files
```

Before opening a PR, make sure the CI checks pass:
`mise run format:check`, `mise run test`, and `mise run build`.

## Tests

Tests live in `tests/`, one scenario per directory
(e.g. `tests/doctoral/approved/`, `tests/components/outlines/`),
and are run with [tytanic](https://typst-community.github.io/tytanic/).
Add a `test.typ` under a new scenario directory to cover a case.

```bash
mise run test                                          # all tests
tt run --font-path fonts doctoral/appendix             # a single test, by id
```

Most tests only check that a document compiles;
add a `context assert` where the case can check itself.

A directory with a `ref/` beside its `test.typ` is a **reference test**:
its rendered pages are compared pixel for pixel against the committed PNGs,
which is what keeps the template's output from drifting.

Because of the KSP approval, a diff in those images is the signal that matters:
it means the rendered document changed.
If your change is *meant* to alter the output, regenerate them and read the result
before committing:

```bash
mise run test:update                                   # all reference images
mise run test:update doctoral/submitted                # one test
```

Never regenerate them to make a red test go green —
an unreviewed update blesses a regression permanently.

## Releasing

Publishing is not automated:
Typst Universe takes packages as pull requests against
[typst/packages](https://github.com/typst/packages).
The `Release` workflow is the gate in front of that.
It runs on a pushed `v*` tag, rebuilds and verifies everything,
and attaches the package archive to a GitHub release.

### 1. Bump the version

On a branch, through a regular pull request:

```bash
mise run bump-version patch       # or minor / major
mise run build && mise run test
mise run package && mise run package:verify
git diff                          # only version strings should change
```

`bump-version` rewrites `typst.toml` and every pinned `@preview/kinetic-kit:…` reference.
`package:verify` checks the `dist/` tree the way Typst Universe will,
so problems surface before a tag exists.

### 2. Tag the release

Tag the merge commit on `main` and push the tag:

```bash
git switch main && git pull
git tag v<version> && git push origin v<version>
gh run watch
```

The workflow fails if the tag does not match the version in `typst.toml`,
and creates no release if any step fails.
The release carries the Universe package archive, the example PDFs and `api-reference.pdf`.
Its notes list the merged pull requests only,
so add a line for every change users will see in their documents.

### 3. Set up a sparse checkout of typst/packages

The packages repository holds every version of every package,
so clone your fork sparsely
([tips.md](https://github.com/typst/packages/blob/main/docs/tips.md#sparse-checkout-of-the-repository)).
The first two commands create the fork if you have none yet,
and bring an existing one up to date:

```bash
gh repo fork typst/packages --clone=false
gh repo sync <your-username>/packages
git clone --depth 1 --no-checkout --filter="tree:0" git@github.com:<your-username>/packages
cd packages
git sparse-checkout init
git sparse-checkout set packages/preview/kinetic-kit
git remote add upstream git@github.com:typst/packages
git config remote.upstream.partialclonefilter tree:0
git checkout main
git switch -c kinetic-kit-<version>
```

### 4. Add the package

The archive mirrors `packages/preview/`, so it unzips straight into place:

```bash
gh release download v<version> --repo ll-nick/kinetic-kit \
  --pattern 'kinetic-kit-<version>-universe-package.zip' --dir /tmp
unzip /tmp/kinetic-kit-<version>-universe-package.zip -d packages/preview/
git status                        # only packages/preview/kinetic-kit/<version>/
```

Copy plain files only:
a `.git` directory turns the commit into a submodule reference instead of a package.
Never touch the files at the repository root.

### 5. Open the pull request

```bash
git add packages/preview/kinetic-kit/<version>
git commit -m "kinetic-kit:<version>"
git push -u origin kinetic-kit-<version>
gh pr create --repo typst/packages --head <your-username>:kinetic-kit-<version> \
  --title "kinetic-kit:<version>" --web
```

`--web` opens the pull request form in the browser with the typst/packages template filled in.
Keep the title `kinetic-kit:<version>`.
In the template, tick "an update for a package", summarize what changed,
and drop the checklist meant for new submissions.
Updates must come from the account that submitted the previous version.
After the merge, the version can take up to 30 minutes to appear on Typst Universe.
