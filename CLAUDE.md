# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**kinetic-kit** is a KIT (Karlsruhe Institute of Technology) dissertation and thesis template for [Typst](https://typst.app/), targeting KIT Scientific Publishing (KSP) formatting requirements. The dissertation template is official / KSP-approved; the thesis template is included as a companion and is not separately KSP-approved. The authoritative requirements are documented in `guidelines.md`.

## Build Commands

This project uses [mise](https://mise.jdx.dev/) for task management, with Typst 0.15.0 pinned in both `mise.toml` (dev/CI toolchain) and `typst.toml` (`compiler`, the minimum supported version).

```sh
# Compile all examples and API docs
mise run build

# Compile only example PDFs
mise run build:examples

# Compile only the API reference PDF
mise run build:docs

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
```

The mise tasks live in `mise/tasks/` and can be run directly without mise if needed.
Most are plain bash; the `package` tasks are stdlib-only Python (3.11+ for `tomllib`, pinned in `mise.toml`).

## Architecture

### Public API (`lib.typ`)

The single entry point re-exports:
- `dissertation()`, `thesis()` — main template functions (from `src/dissertation.typ` and `src/thesis.typ`)
- `doctoral-title-page`, `print-thesis-title` — title pages, for passing to `title-page`; they own every parameter printed on the page (from `src/title-page.typ`)
- `flex-caption` — figure/table caption utility (from `src/figures.typ`)

### Source Modules (`src/`)

| File | Purpose |
|------|---------|
| `document.typ` | `_document()` — the shared orchestrator both templates delegate to |
| `dissertation.typ` | `dissertation()` — doctoral parameters, mapped onto `_document()` |
| `thesis.typ` | `thesis()` — student-thesis parameters, mapped onto `_document()` |
| `page-setup.typ` | Shared style engine — `kit-header`, `_page-base()`, draft indicator, section pagination wrappers |
| `kit-colors.typ` | KIT color palette + syntax highlighting colors |
| `typography.typ` | Font configuration (Libertinus family) and KSP-required sizes per format (`font-sizes-by-format`) |
| `page-conf.typ` | Page layout constants per format: page dimensions, margin presets (`short`/`medium`/`long`) per format, paragraph spacing |
| `translations.typ` | German/English label strings |
| `title-page.typ` | `doctoral-title-page` and `print-thesis-title` (German legal format); either can be passed to `title-page` |
| `front-matter.typ` | Abstract, Kurzfassung, acknowledgements, notation, abbreviations |
| `back-matter.typ` | Bibliography, own publications, own patents, supervised theses |
| `outlines.typ` | TOC, back-matter list pages (`list-of` and the `list-of-figures`/`list-of-tables`/`list-of-listings` shorthands), and their `outline.entry` styling (`setup-outlines`) |
| `figures.typ` | Figure/caption/table styling (`setup-figures`) and `flex-caption` |
| `figure-kinds.typ` | Registry of figure kinds — `resolve-figure-kinds` appends a document's own kinds after Typst's built-in `image`/`table`/`raw` |
| `headings.typ` | Heading styling — per-level sizes/spacing, chapter page breaks, number–body alignment (`setup-headings`) |

### Template Flow

Both `dissertation()` and `thesis()` map their parameters onto `_document()`, which owns the structure:
0. **Title page** — from the `title-page` parameter, defaulting to `doctoral-title-page` / `print-thesis-title`. Rendered inside a scoped `set page` that supplies the title-page margins and suppresses header, footer and numbering
1. **Front matter** — Roman page numbering (i, ii, …), no running headers; includes abstracts, TOC
2. **Content** — Arabic page numbering (1, 2, …), chapter/section running headers
3. **Back matter** — appendix (A, A.1, … numbering), then LoF/LoT/LoL, bibliography, and (dissertation only) own-publications/patents/supervised-theses sections

Headers are suppressed on chapter-opening pages and blank pages. The draft watermark is rendered as a background element on every page when enabled.

### API Documentation (`docs/`)

`docs/main.typ` uses the [tidy](https://typst.universe/package/tidy) package to auto-generate `docs/api-reference.pdf` from doc-comments in `dissertation.typ`, `thesis.typ`, `outlines.typ`, `figures.typ`, `figure-kinds.typ`, and `headings.typ`.

### Examples (`examples/`)

- `doctoral-full.typ` — comprehensive feature showcase (native multi-bibliography via `bibliography(full: true)`); the only example that declares a custom figure kind, via `content/figure-kinds-de.typ`
- `doctoral-full-en.typ` — English doctoral variant
- `doctoral-approved.typ` — approved doctoral variant
- `doctoral-17x24.typ`, `doctoral-a4.typ` — non-default paper formats (the A4 variant uses fixed margins, so `margin-preset` has no effect there)
- `masters-full.typ`, `masters-full-en.typ` — student-thesis variants (`thesis()`)

Shared content in `examples/content/` and bibliographies in `examples/bib/`.

## Key Constraints

- **Typst version**: 0.15.0 — both the minimum supported compiler (`compiler` in `typst.toml`) and the dev/CI toolchain (`mise.toml`).
- **Paper format**: A5 (148×210 mm, default), 17×24 (170×240 mm), or A4 (210×297 mm) — controlled via `format` parameter; KSP recommends A5 for dissertations
- **Base font size**: 10 pt (A5/17×24) or 11 pt (A4) Libertinus Serif — set automatically per format
- **Line spacing**: 1.15× (0.75em leading in Typst)
- **Margins**: Three presets keyed on final page count — short (<200 pages), medium (200–399), long (≥400)
- **Heading font**: Libertinus Sans by default; `serif-headings: true` switches to Libertinus Serif
- **Heading numbering**: Numbered up to level 3 by default; configurable via `heading-numbering-depth`
- All formatting decisions should be validated against `guidelines.md`
