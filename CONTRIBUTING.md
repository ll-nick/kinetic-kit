# Contributing to kinetic-kit

Thanks for your interest.
Contributions are welcome!
Please read this document before opening an issue or pull request.

## Scope & KSP approval

kinetic-kit is the official, KSP-approved KIT dissertation template. Because of that
approval, not every change is equally easy to land:

- **Straightforward:** bug fixes, typos, documentation, examples, tests, tooling,
  and any change that does **not** alter the rendered dissertation output.
- **Harder to merge:** anything that changes the dissertation's *layout or
  formatting* (margins, fonts, headings, title page, numbering, …). Output-altering
  changes may need to be re-approved by KSP before they can ship, so they take
  longer and may not be accepted if they conflict with KSP's requirements.
  **Please open an issue to discuss before investing effort.**

The thesis template is a companion and is not separately KSP-approved, so it has
more room for change.

## How to contribute

1. **Open an issue** describing the bug or proposal, especially for anything output-affecting (see above).
2. Fork the repository and create a branch.
3. Make your change and ensure the checks pass locally (see below).
4. Open a pull request referencing the issue.

## Development

This project uses [mise](https://mise.jdx.dev) to manage tasks and pinned tooling
(Typst, tytanic, typstyle). With it installed:

```bash
mise install       # fetch the pinned toolchain
mise run build     # compile examples, API docs, template, and thumbnail
mise run test      # run the tytanic test suite
mise run format    # format all Typst files
```

Before opening a PR, make sure the CI checks pass:
`mise run format:check`, `mise run test`, and `mise run build`.

## Tests

Tests live in `tests/`, organized by template type and scenario
(e.g. `tests/dissertation/approved/`, `tests/thesis/minimal/`).
They are compilation tests run with [tytanic](https://typst-community.github.io/tytanic/).
Add a `test.typ` under a new scenario directory to cover a case:

```bash
mise run test                                          # all tests
tt run --font-path fonts tests/dissertation/appendix   # a single test
```
