# kit-thesis

An unofficial[^1] KIT dissertation and thesis[^2] template for [Typst](https://typst.app), designed to comply with the formatting requirements of [KIT Scientific Publishing (KSP)](https://www.bibliothek.kit.edu/ksp-toolbox.php).

> [!NOTE]
> This template is in early development and may contain incomplete features, bugs, or formatting issues.
> It doesn't have a stable API either.
> You should probably not use it until it has reached a more mature state.


## Getting Started

### Prerequisites

[mise](https://mise.jdx.dev) is recommended for managing tasks and tooling (including Typst itself).

However, all tasks are plain shell scripts in `mise/tasks/` and can be run directly assuming Typst is installed and available in your `PATH`.
The template is developed with Typst `0.14.2`, but it may work with other versions as well.

### Installation

The template is not currently published on the Typst Universe registry, so you need to install it as a local package to use it in your documents.
In the root of the repository, run either of the following:

```bash
# copy — changes require re-installation (recommended for stability)
mise run install # or bash mise/tasks/install/_default

# symlink — changes apply immediately (recommended during development)
mise run install:editable # or bash mise/tasks/install/editable
```

#### Fonts

This template expects the [Libertinus font family](https://github.com/alerque/libertinus) to be installed on the system.
For convenience, this repository includes these fonts.
Install them using `mise run install:fonts` (or `bash mise/tasks/install/fonts`) if you don't have them yet.

### Usage

Import the `dissertation` or `thesis` component from the package in your Typst document and call `with(...)` to set parameters and content:

```typst
#import "@local/kit-thesis:0.1.0": dissertation

#show: dissertation.with(
  author-firstname: "Max",
  author-surname:   "Mustermann",
  title:            [Title of the Dissertation],
  lang:             "de",
  abstract-de:      include "content/abstract-de.typ",
  abstract-en:      include "content/abstract-en.typ",
  bibliography:     bibliography("bib/references.bib", title: none, style: "ieee"),
)

#include "content/01-introduction.typ"
```

See the [`examples/`](examples/) directory for more complete examples.

## API Reference

For complete and up-to-date documentation, refer to [`docs/api-reference.pdf`](docs/api-reference.pdf),
which is auto-generated from the source code.

<details>
<summary><strong>Parameters — <code>dissertation(...)</code></strong></summary>

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `author-title` | `str \| none` | `"M.Sc."` | Academic title preceding the name; `none` to omit |
| `author-firstname` | `str` | `"Max"` | |
| `author-surname` | `str` | `"Mustermann"` | |
| `author-male` | `bool` | `true` | Controls gendered German text on the title page |
| `place-of-birth` | `str \| none` | `none` | Place of birth ("aus …"); `none` = omit |
| `title` | `content` | | Dissertation title |
| `doc-degree` | `str` | `"Doktors der Ingenieurwissenschaften (Dr.-Ing.)"` | Degree in masculine form |
| `doc-degree-f` | `str` | `"Doktorin der Ingenieurwissenschaften (Dr.-Ing.)"` | Degree in feminine form |
| `department` | `str` | `"KIT-Fakultät für Maschinenbau"` | |
| `university-genitive` | `str` | `"des Karlsruher Instituts für Technologie (KIT)"` | University name in genitive case |
| `lang` | `"de" \| "en"` | `"de"` | Document language |
| `margin-preset` | `"short" \| "medium" \| "long"` | `"short"` | KSP margin profile (see [Margin Presets](#margin-presets)) |
| `status-approved` | `bool` | `false` | `false` = eingereicht, `true` = angenommen |
| `exam-date` | `str \| none` | `none` | Date of oral examination; required when `status-approved: true` |
| `main-advisor` | `str \| none` | `none` | Hauptreferent |
| `main-advisor-male` | `bool` | `true` | |
| `co-advisor` | `str \| none` | `none` | Korreferent |
| `co-advisor-male` | `bool` | `true` | |
| `abstract-en` | `content \| none` | `none` | |
| `abstract-de` | `content \| none` | `none` | |
| `acknowledgements` | `content \| none` | `none` | |
| `cv-name` | `str \| none` | `none` | Show CV page with this name as heading; `none` = omit |
| `cv-entries` | `array` | `()` | `(year, description)` tuples |
| `notation` | `content \| none` | `none` | Symbol/notation list |
| `abbreviations` | `content \| none` | `none` | Abbreviations / acronym list |
| `binding-correction` | `length` | `0mm` | BCOR added to inside margin (8–10 mm for physically bound copies) |
| `colored-links` | `bool` | `true` | KIT Blue hyperlinks (screen); `false` = black (print) |
| `draft` | `bool` | `false` | Show "ENTWURF"/"DRAFT" watermark |
| `draft-info` | `str \| none` | `none` | Optional version string next to watermark (e.g. git SHA) |
| `own-publications` | `content \| none` | `none` | Back-matter publications list |
| `own-patents` | `content \| none` | `none` | Back-matter patents list |
| `supervised-theses` | `content \| none` | `none` | Back-matter supervised theses list |
| `show-lof` | `bool` | `true` | List of figures |
| `show-lot` | `bool` | `true` | List of tables |
| `show-lol` | `bool` | `false` | List of listings |
| `bibliography` | `content \| none` | `none` | Pass `bibliography("refs.bib", title: none, style: "ieee")`; template adds a translated heading |
| `appendix` | `content \| none` | `none` | Appendix chapters; template applies A, A.1, … numbering, placed after back-matter lists |

</details>

<details>
<summary><strong>Parameters — <code>thesis(...)</code></strong></summary>

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `author-firstname` | `str` | `"Max"` | |
| `author-surname` | `str` | `"Mustermann"` | |
| `title` | `content` | | Thesis title |
| `thesis-type` | `str` | `"Masterarbeit"` | e.g. `"Bachelorarbeit"`, `"Diplomarbeit"` |
| `department` | `str` | `"KIT-Fakultät für Maschinenbau"` | |
| `university-genitive` | `str` | `"des Karlsruher Instituts für Technologie (KIT)"` | University name in genitive case |
| `examiner` | `str \| none` | `none` | Erstprüfer |
| `supervisor` | `str \| none` | `none` | Betreuer |
| `date-submitted` | `str \| none` | `none` | |
| `lang` | `"de" \| "en"` | `"de"` | Document language |
| `margin-preset` | `"short" \| "medium" \| "long"` | `"short"` | KSP margin profile (see [Margin Presets](#margin-presets)) |
| `binding-correction` | `length` | `0mm` | BCOR added to inside margin (8–10 mm for physically bound copies) |
| `colored-links` | `bool` | `true` | KIT Blue links (screen); `false` = black (print) |
| `draft` | `bool` | `false` | Show "ENTWURF"/"DRAFT" watermark |
| `draft-info` | `str \| none` | `none` | Optional version string next to watermark |
| `abstract-en` | `content \| none` | `none` | |
| `abstract-de` | `content \| none` | `none` | |
| `acknowledgements` | `content \| none` | `none` | |
| `abbreviations` | `content \| none` | `none` | Abbreviations / acronym list |
| `show-lof` | `bool` | `true` | List of figures |
| `show-lot` | `bool` | `true` | List of tables |
| `show-lol` | `bool` | `false` | List of listings |
| `bibliography` | `content \| none` | `none` | Pass `bibliography("refs.bib", title: none, style: "ieee")`; template adds a translated heading |
| `appendix` | `content \| none` | `none` | Appendix chapters; template applies A, A.1, … numbering, placed after back-matter lists |

</details>

## Margin Presets

Choose based on the total page count of the finished document (KSP requirement):

| Preset | Page count | Inner | Outer |
|--------|-----------|-------|-------|
| `"short"` | < 200 | 20 mm | 15 mm |
| `"medium"` | 200–399 | 23 mm | 15 mm |
| `"long"` | ≥ 400 | 25 mm | 15 mm |

## Cookbook

<details>
<summary><strong>Draft mode with git SHA watermark</strong></summary>

Set `draft: true` to show an "ENTWURF" (German) or "DRAFT" (English) watermark on every page. Pass `draft-info` for an additional version string:

```typst
#show: dissertation.with(
  ...
  draft:      true,
  draft-info: sys.inputs.at("git-sha", default: none),
)
```

Compile with the SHA injected:

```bash
typst compile --input git-sha=$(git rev-parse --short HEAD) main.typ
```

Set `draft: false` before submission.

</details>

<details>
<summary><strong>Automatic abbreviation expansion (Glossarium)</strong></summary>

Use the [glossarium](https://typst.app/universe/package/glossarium) package for automatic first-use expansion.

**Important:** `#show: make-glossary` must appear *before* `#show: dissertation.with(...)`. Forgetting this causes silent failure — abbreviations will not expand.

```typst
#import "@local/kit-thesis:0.1.0": dissertation
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary, gls, glspl

#let abbrevs = (
  (key: "ml",  short: "ML",  long: "Machine Learning"),
  (key: "cnn", short: "CNN", long: "Convolutional Neural Network"),
)

// Must come before #show: dissertation.with(...)
#show: make-glossary
#register-glossary(abbrevs)

#show: dissertation.with(
  ...
  // The template adds the translated section heading automatically.
  abbreviations: print-glossary(abbrevs),
)

// #gls("ml") expands to "Machine Learning (ML)" on first use, "ML" thereafter.
```

</details>

<details>
<summary><strong>Separate bibliography sections (Alexandria)</strong></summary>

Use the [alexandria](https://typst.app/universe/package/alexandria) package for separate bibliography sections for own publications, patents, and supervised theses alongside the main bibliography.

```typst
#import "@local/kit-thesis:0.1.0": dissertation
#import "@preview/alexandria:0.2.2": alexandria, bibliographyx

// Must come before #show: dissertation.with(...)
#show: alexandria(prefix: "p:", read: path => read(path))

#show: dissertation.with(
  ...
  own-publications: bibliographyx(
    "bib/own-publications.bib",
    title: none, style: "ieee", full: true,
  ),
  bibliography: bibliography("bib/references.bib", title: none, style: "ieee"),
)
```

In-text citations to own publications use `@p:key` syntax.

</details>

<details>
<summary><strong>Margin notes for drafts (Drafting)</strong></summary>

Use the [drafting](https://typst.app/universe/package/drafting) package to add margin notes during writing. Tie `is-draft` to both the watermark and note visibility so they are toggled in one place:

```typst
#import "@local/kit-thesis:0.1.0": dissertation
#import "@preview/drafting:0.2.2": set-margin-note-defaults, margin-note

#let is-draft = true
#set-margin-note-defaults(hidden: not is-draft)

#show: dissertation.with(
  ...
  draft: is-draft,
)

// In your text:
#margin-note[Revisit this paragraph.]
```

Set `is-draft = false` before final compilation to hide all margin notes and remove the watermark.

</details>

## Contributing

### Prerequisites

This project uses [mise](https://mise.jdx.dev) to manage both development tasks and tooling.
With it installed, you can run all tasks with `mise run <task>` (e.g. `mise run build`).

### Tasks

| Task | Description |
|------|-------------|
| `mise run build` | Compile examples, API docs, template, and thumbnail |
| `mise run build:examples` | Compile example documents only |
| `mise run build:docs` | Compile API reference (`docs/api-reference.pdf`) |
| `mise run build:template` | Compile the Typst Universe template (`template/`) |
| `mise run build:thumbnail` | Compile the template thumbnail |
| `mise run install` | Install as local Typst package (copy) |
| `mise run install:editable` | Install as local Typst package (symlink) |
| `mise run install:fonts` | Install bundled Libertinus fonts to user font directory |
| `mise run test` | Run tytanic test suite |

### Tests

Tests live in `tests/` and are organized by template type and scenario (e.g. `tests/dissertation/approved/`, `tests/thesis/minimal/`). Each test compiles a `.typ` file targeting a specific layout scenario.
As of right now, these tests are pure compilation tests.

```bash
mise run test # run all tests
tt run --font-path fonts tests/dissertation/appendix  # run a single test
```

## License

Template code: MIT-0 (no attribution required). Bundled fonts (`fonts/`): SIL OFL 1.1.

## Acknowledgements

This template has been implemented with AI assistance (Claude Code by Anthropic).
The basis for the template are the [KSP guidelines](https://www.bibliothek.kit.edu/downloads/KSP/KSP-Basic-Layout-Guidelines.pdf),
the [official KSP LaTeX template](https://gitlab.kit.edu/kit/ksp/ksp-vorlage-a5-de-diss),
as well as [this great LaTeX template](https://gitlab.cc-asp.fraunhofer.de/kit-ksp/dissertation-template).


[^1]: This is an unofficial community template, not affiliated with, endorsed by,
or approved by KIT (Karlsruhe Institute of Technology) or KSP (KIT Scientific Publishing).
The template attempts to follow the [KSP Basic Layout Guidelines](https://www.bibliothek.kit.edu/downloads/KSP/KSP-Basic-Layout-Guidelines.pdf) but compliance is not guaranteed.
Always verify your final manuscript with KSP before submission.

[^2]: This template was implemented to ~~procrastinate writing~~ write a dissertation. The thesis template is more of a byproduct and probably less polished.

