# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**kinetic-kit** is a KIT (Karlsruhe Institute of Technology) thesis template for [Typst](https://typst.app/), targeting KIT Scientific Publishing (KSP) formatting requirements. A single `thesis()` entry point covers doctoral, Master's, Bachelor's and Diploma theses; the document type is decided by the title page passed to `title-page`. KSP's endorsement covers the doctoral thesis and its default title page (`doctoral-title-page`), not title pages supplied by the user. The authoritative requirements are documented in `guidelines.md`.

## Build Commands

This project uses [mise](https://mise.jdx.dev/) for task management, with Typst 0.15.0 pinned in both `mise.toml` (dev/CI toolchain) and `typst.toml` (`compiler`, the minimum supported version).

```sh
# Compile examples, API reference, template preview and thumbnail
mise run build

# Compile only example PDFs
mise run build:examples

# Compile only the API reference PDF
mise run build:docs

# Compile only template/main.typ (resolves its @preview import against this checkout)
mise run build:template

# Re-render thumbnail.png from the template's title page
mise run build:thumbnail

# Run the tytanic test suite
mise run test

# Install package locally (copy to ~/.local/share/typst/packages/local/)
mise run install

# Install as editable symlink (for active development)
mise run install:editable

# Install Libertinus fonts for the current user
mise run install:fonts

# Format all Typst and Python files in-place
mise run format

# Check formatting without modifying files
mise run format:check

# Show formatting diff
mise run format:diff

# Assemble the Typst Universe submission tree in dist/
mise run package

# Check that tree the way Typst Universe will
mise run package:verify

# Rewrite typst.toml and every pinned @preview/@local reference
mise run bump-version <major|minor|patch>
```

The mise tasks live in `mise/tasks/` and can be run directly without mise if needed.
Most are plain bash; the `package` and `bump-version` tasks are stdlib-only Python (3.11+ for `tomllib`, pinned in `mise.toml`).

## Architecture

### Public API (`lib.typ`)

The single entry point re-exports:
- `thesis()` — the template function (from `src/thesis.typ`)
- `doctoral-title-page` — the KSP doctoral title page, for passing to `title-page`; it owns every parameter printed on the page (from `src/title-page.typ`)
- `kit-style` — visual constants (fonts, sizes, leading, colors) for matching custom content
- `outlines` — namespace re-exporting `src/outlines.typ`: `table-of-contents`, `list-of`, and the `list-of-figures`/`list-of-tables`/`list-of-listings` shorthands, for placing in `front-matter`/`back-matter`, plus `flex-caption`

### Source Modules (`src/`)

| File | Purpose |
|------|---------|
| `thesis.typ` | `thesis()` — the entry point and the document structure it assembles |
| `page-setup.typ` | Shared style engine — `kit-header`, `_page-base()`, draft indicator, section pagination wrappers (`setup-front-matter`/`setup-back-matter`/`setup-content`/`setup-appendix`) |
| `kit-colors.typ` | KIT color palette + syntax highlighting colors |
| `typography.typ` | Font configuration (Libertinus family) and KSP-required sizes per format (`font-sizes-by-format`) |
| `page-conf.typ` | Page layout constants per format: page dimensions, margin presets (`short`/`medium`/`long`) per format, paragraph spacing |
| `translations.typ` | German/English label strings |
| `title-page.typ` | `doctoral-title-page` (German legal format), the default for `title-page` |
| `outlines.typ` | TOC, back-matter list pages (`list-of` and the `list-of-figures`/`list-of-tables`/`list-of-listings` shorthands), their `outline.entry` styling (`setup-outlines`), and `flex-caption` with the `in-outline` state that drives it |
| `figures.typ` | Figure/caption/table styling (`setup-figures`) |
| `figure-kinds.typ` | Registry of figure kinds — `resolve-figure-kinds` appends a document's own kinds after Typst's built-in `image`/`table`/`raw` |
| `headings.typ` | Heading styling — per-level sizes/spacing, chapter page breaks, number–body alignment (`setup-headings`) |

### Template Flow

`thesis()` assembles the document in this order:
0. **Title page** — from the `title-page` parameter, defaulting to `doctoral-title-page`. Rendered inside a scoped `set page` that supplies the title-page margins and suppresses header, footer and numbering
1. **Front matter** — Roman page numbering (i, ii, …), no running headers; includes abstracts, TOC
2. **Content** — Arabic page numbering (1, 2, …), chapter/section running headers
3. **Back matter** — appendix (A, A.1, … numbering), then LoF/LoT/LoL, bibliography, and the optional own-publications/patents/supervised-theses sections

Headers are suppressed on chapter-opening pages and blank pages. The draft watermark is rendered as a background element on every page when enabled.

### API Documentation (`docs/`)

`docs/main.typ` uses [tidy](https://typst.app/universe/package/tidy) 0.4.3 to generate
`docs/api-reference.pdf` from the doc-comments of the public API:
`thesis.typ`, `title-page.typ`, `outlines.typ`, and `kit-style` from `lib.typ`.
Doc-comments follow tidy's 0.4 syntax:
the description sits in front of each parameter inside the signature,
types are annotated with a trailing `/// -> a | b`,
and `@name` / `@function.parameter` cross-reference other definitions.
Types are never inferred — an unannotated parameter renders without a type badge —
while defaults are read from the signature.

`api-module` takes the heading `level` its definitions occupy,
so a module holding a single definition becomes a chapter of its own
rather than nesting one heading under another.
Prose introducing a definition belongs in its doc-comment, not in `main.typ`.

`docs/api-reference.pdf` is generated, not tracked.
It ships as a release asset rather than in the repository or the package,
and the README links it as `/releases/latest/download/api-reference.pdf`.
`mise run package` repoints every `/releases/latest…` link in the published README
at the tagged release — the asset URL and the release page the example PDFs hang off —
and `package:verify` fails if any `latest` link survived.

The tables in the `kit-style` chapter are built by iterating the
imported `fonts`, `font-sizes-by-format` and `kit-colors` dictionaries,
and the cover version is read from `typst.toml`,
so neither can drift from the source.

### Examples (`examples/`)

- `doctoral-full.typ` — comprehensive feature showcase (native multi-bibliography via `bibliography(full: true)`); the only example that declares a custom figure kind, via `content/figure-kinds-de.typ`
- `doctoral-full-en.typ` — English doctoral variant
- `doctoral-approved.typ` — approved doctoral variant
- `doctoral-17x24.typ`, `doctoral-a4.typ` — non-default paper formats (the A4 variant uses fixed margins, so `margin-preset` has no effect there)
- `masters-full.typ`, `masters-full-en.typ` — student-thesis variants; the only examples passing a custom `title-page`, from `content/masters-title-page.typ`

Shared content in `examples/content/` and bibliographies in `examples/bib/`.

### Tests (`tests/`)

[tytanic](https://typst-community.github.io/tytanic/) 0.4.0, run with `mise run test`.
Each scenario is a directory holding one `test.typ`, grouped under `tests/components/`
(a single exported symbol), `tests/doctoral/` and `tests/masters/`
(whole documents, split by which title page they pass).
There are no reference images: every test asserts only that its document compiles,
so an output regression has to be caught by reading the rendered PDFs.
`@template` is tytanic's built-in test for `template/main.typ`;
`package:verify` reruns it against the assembled bundle.

## Key Constraints

- **Typst version**: 0.15.0 — both the minimum supported compiler (`compiler` in `typst.toml`) and the dev/CI toolchain (`mise.toml`).
- **Paper format**: A5 (148×210 mm, default), 17×24 (170×240 mm), or A4 (210×297 mm) — controlled via `format` parameter; KSP recommends A5 for doctoral theses
- **Base font size**: 10 pt (A5/17×24) or 11 pt (A4) Libertinus Serif — set automatically per format
- **Line spacing**: 1.15× (0.75em leading in Typst)
- **Margins**: Three presets keyed on final page count — short (<200 pages), medium (200–399), long (≥400)
- **Heading font**: Libertinus Sans by default; `serif-headings: true` switches to Libertinus Serif
- **Heading numbering**: Numbered up to level 3 by default; configurable via `heading-numbering-depth`
- All formatting decisions should be validated against `guidelines.md`
