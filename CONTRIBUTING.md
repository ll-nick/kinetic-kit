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
