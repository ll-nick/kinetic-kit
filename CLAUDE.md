# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**kinetic-kit** is an unofficial KIT (Karlsruhe Institute of Technology) dissertation and thesis template for [Typst](https://typst.app/), targeting KIT Scientific Publishing (KSP) formatting requirements. The authoritative requirements are documented in `guidelines.md`.

## Build Commands

This project uses [mise](https://mise.jdx.dev/) for task management with Typst pinned to v0.14.2.

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

# Format all Typst files in-place
mise run format

# Check formatting without modifying files
mise run format:check

# Show formatting diff
mise run format:diff
```

The mise tasks are plain bash scripts in `mise/tasks/` and can be run directly without mise if needed.

## Architecture

### Public API (`lib.typ`)

The single entry point re-exports:
- `dissertation()`, `thesis()` — main template functions (from `src/dissertation.typ` and `src/thesis.typ`)
- `flex-caption` — figure/table caption utility (from `src/outlines.typ`)

### Source Modules (`src/`)

| File | Purpose |
|------|---------|
| `dissertation.typ` | `dissertation()` orchestrator — front/back matter, glossarium wiring |
| `thesis.typ` | `thesis()` orchestrator — front/back matter, glossarium wiring |
| `page-setup.typ` | Shared style engine — `kit-header`, `_page-base()`, draft indicator, section pagination wrappers |
| `kit-colors.typ` | KIT color palette + syntax highlighting colors |
| `typography.typ` | Font configuration (Libertinus family) and KSP-required sizes per format (`font-sizes-by-format`) |
| `page-conf.typ` | Page layout constants per format: page dimensions, margin presets (`short`/`medium`/`long`) per format, paragraph spacing |
| `translations.typ` | German/English label strings |
| `title-page.typ` | Dissertation/thesis title page (German legal format) |
| `front-matter.typ` | Abstract, Kurzfassung, acknowledgements, notation, abbreviations |
| `back-matter.typ` | Bibliography, own publications, own patents, supervised theses |
| `outlines.typ` | TOC, List of Figures/Tables/Listings, `flex-caption` |

### Template Flow

Both `dissertation()` and `thesis()` share the same structure:
1. **Front matter** — Roman page numbering (i, ii, …), no running headers; includes title page, abstracts, TOC
2. **Content** — Arabic page numbering (1, 2, …), chapter/section running headers, bibliography injected at end
3. **Back matter** — own-publications/patents/supervised-theses sections, LoF/LoT/LoL, appendices with A.1 numbering

Headers are suppressed on chapter-opening pages and blank pages. The draft watermark is rendered as a background element on every page when enabled.

### API Documentation (`docs/`)

`docs/main.typ` uses the [tidy](https://typst.universe/package/tidy) package to auto-generate `docs/api-reference.pdf` from doc-comments in `dissertation.typ`, `thesis.typ`, and `outlines.typ`.

### Examples (`examples/`)

- `dissertation-full.typ` — comprehensive feature showcase (multi-bibliography via alexandria)
- `dissertation-full-en.typ` — English dissertation variant
- `dissertation-approved.typ` — approved dissertation variant
- `thesis-full.typ`, `thesis-full-en.typ` — master's/bachelor's/diploma thesis variants

Shared content in `examples/content/` and bibliographies in `examples/bib/`.

## Key Constraints

- **Typst version**: Must use 0.14.2 (pinned in `mise.toml` and `typst.toml`)
- **Paper format**: A5 (148×210 mm, default), 17×24 (170×240 mm), or A4 (210×297 mm) — controlled via `format` parameter; KSP recommends A5 for dissertations
- **Base font size**: 10 pt (A5/17×24) or 11 pt (A4) Libertinus Serif — set automatically per format
- **Line spacing**: 1.15× (0.75em leading in Typst)
- **Margins**: Three presets keyed on final page count — short (<200 pages), medium (200–399), long (≥400)
- **Heading font**: Libertinus Sans by default; `serif-headings: true` switches to Libertinus Serif
- **Heading numbering**: Numbered up to level 3 by default; configurable via `heading-numbering-depth`
- All formatting decisions should be validated against `guidelines.md`
