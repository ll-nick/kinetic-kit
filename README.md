# kinetic-kit

<!-- package:strip-start — Typst Universe shows version and license itself, and CI state is of no interest there -->
[![CI build status](https://github.com/ll-nick/kinetic-kit/actions/workflows/ci.yml/badge.svg)](https://github.com/ll-nick/kinetic-kit/actions/workflows/ci.yml)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](LICENSE)
[![Example PDFs](https://img.shields.io/badge/example%20PDFs-latest%20build-informational.svg)](https://nightly.link/ll-nick/kinetic-kit/workflows/ci/main/pdfs.zip)
[![Current version](https://img.shields.io/github/v/tag/ll-nick/kinetic-kit?sort=semver&label=version)](https://github.com/ll-nick/kinetic-kit/tags)
<!-- package:strip-end -->

The official [Typst](https://typst.app) template[^1] for doctoral theses published through [KIT Scientific Publishing (KSP)](https://www.ksp.kit.edu/).


## Getting Started

Start a new project from the template with:

```bash
typst init @preview/kinetic-kit:0.1.1
```

Or pick **kinetic-kit** from the template gallery in the [Typst web app](https://typst.app).
Either way you get a ready-to-fill `main.typ`.

To add the template to an existing document instead, import it and apply it with a show rule:

```typst
#import "@preview/kinetic-kit:0.1.1": outlines, thesis

#show: thesis.with(
  lang: "de",
  author-firstname: "Max",
  author-surname: "Mustermann",
  title: [Title of the Dissertation],
  front-matter: [
    #include "content/abstract-de.typ"

    #outlines.table-of-contents()
  ],
  back-matter: [
    #outlines.list-of-figures()
    #bibliography("bib/references.bib", title: [Literaturverzeichnis], style: "ieee")
  ],
)

#include "content/01-introduction.typ"
```

See the [`examples/`](examples/) directory for more complete examples;
the [latest release](https://github.com/ll-nick/kinetic-kit/releases/latest) has them attached as rendered PDFs.

### Fonts

The template is set in the [Libertinus](https://github.com/alerque/libertinus) font family.

- **Typst web app:** Libertinus is pre-installed, so no additional steps are required.
- **Local compilation:** The Libertinus font family must be installed on your system for the compiler to find it.
You can get it from the [Libertinus releases](https://github.com/alerque/libertinus/releases).
The bundled copy is version 7.051.

<details>
<summary><strong>Local install</strong></summary>

To use a local checkout of [the template's repository](https://github.com/ll-nick/kinetic-kit) as a package
(e.g. while contributing or to get the bleeding-edge version),
follow these steps to install it into your local Typst package directory.

[mise-en-place](https://mise.jdx.dev) is an optional but recommended prerequisite here.
It can be used to install both the template and Typst itself.
However, assuming Typst is installed, each task is a plain shell script, so you can also run the `bash mise/tasks/…` form directly.

Inside your clone of the repository, run either of the following:

```bash
# copy — changes require re-installation (recommended for stability)
mise run install # or bash mise/tasks/install/_default

# symlink — changes apply immediately (recommended during development)
mise run install:editable # or bash mise/tasks/install/editable
```

When installed this way, imports use `@local/kinetic-kit:0.1.1` in place of `@preview/kinetic-kit:0.1.1`.

The repository also bundles the Libertinus fonts.
Install them into your user font directory with

```bash
mise run install:fonts # or bash mise/tasks/install/fonts
```

</details>

## API Reference

Refer to the [API reference](https://github.com/ll-nick/kinetic-kit/releases/latest/download/api-reference.pdf),
auto-generated from the source code and attached to every release.

<!-- package:strip-start — the nightly build tracks main, not the released version -->
Between releases,
the [nightly build](https://nightly.link/ll-nick/kinetic-kit/workflows/ci/main/api-reference.zip) follows `main`.
<!-- package:strip-end -->

Upgrading from 0.1.x? See [MIGRATING.md](MIGRATING.md).

<details>
<summary><strong>Template: <code>thesis(...)</code></strong></summary>

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `format` | `"a5" \| "17x24" \| "a4"` | `"a5"` | Paper format — `"a5"` (148×210 mm, default), `"17x24"` (170×240 mm), or `"a4"` (210×297 mm) |
| `lang` | `"de" \| "en"` | `"de"` | Document language |
| `author-firstname` | `str` | `"Max"` | |
| `author-surname` | `str` | `"Mustermann"` | |
| `title` | `content` | | Dissertation title |
| `title-page` | `content \| function \| none` | `doctoral-title-page` | Title page. Configure the default with `doctoral-title-page.with(…)` (see below), pass your own content or function, or `none` to omit it |
| `front-matter` | `content \| none` | `outlines.table-of-contents()` | Roman-numeral pages before the body — abstracts, acknowledgements, the TOC, any page of your own, in the order written. Heading numbering suppressed. `none` = no front matter |
| `appendix` | `content \| none` | `none` | Appendix chapters; template applies A, A.1, … numbering, placed directly after the body, before the back matter |
| `back-matter` | `content \| none` | `none` | Pages after the appendix — `outlines.list-of-*()` calls, `bibliography(…)`, own-publications, in the order written. Heading numbering suppressed |
| `serif-headings` | `bool` | `false` | Use Libertinus Serif for headings when `true`, Libertinus Sans-Serif when `false` |
| `heading-numbering-depth` | `int` | `3` | Deepest heading level that receives a number; deeper levels are styled but not numbered |
| `figure-kinds` | `array` | `()` | Figure kinds beyond `image`/`table`/`raw`, as dicts with `kind` and `supplement` |
| `margin-preset` | `"short" \| "medium" \| "long"` | `"short"` | KSP margin profile keyed on final page count — `short` < 200 pp, `medium` 200–399, `long` ≥ 400 |
| `binding-correction` | `length` | `0mm` | BCOR added to inside margin (8–10 mm for physically bound copies) |
| `colored-links` | `bool` | `true` | KIT Blue hyperlinks (screen); `false` = black (print) |
| `draft` | `bool` | `false` | Show "ENTWURF"/"DRAFT" watermark |
| `draft-info` | `str \| none` | `none` | Optional version string next to watermark (e.g. git SHA) |

</details>

<details>
<summary><strong>Doctoral title page: <code>doctoral-title-page(...)</code></strong></summary>

Everything printed on the default doctoral title page.
Pass it to `title-page`, configured with `.with(…)`.
`title`, `author-firstname`, `author-surname`, `format` and `lang`
are supplied by the template — setting them here has no effect.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `author-title` | `str \| none` | `"M.Sc."` | Academic title preceding the name; `none` to omit |
| `author-male` | `bool` | `true` | `true` = male grammatical forms, `false` = female |
| `doc-degree` | `str` | `"Doktors der Ingenieurwissenschaften (Dr.-Ing.)"` | Degree name, masculine |
| `doc-degree-f` | `str` | `"Doktorin der Ingenieurwissenschaften (Dr.-Ing.)"` | Degree name, feminine |
| `department` | `str` | `"KIT-Fakultät für Maschinenbau"` | Faculty / department |
| `university-genitive` | `str` | `"des Karlsruher Instituts für Technologie (KIT)"` | University name, genitive |
| `status-approved` | `bool` | `false` | `false` = submitted, `true` = approved |
| `exam-date` | `str \| none` | `none` | Date of the oral examination; shown when approved |
| `main-advisor` | `str \| none` | `none` | Main referee; shown when approved |
| `main-advisor-male` | `bool` | `true` | Grammatical gender of the main advisor label |
| `co-advisor` | `str \| none` | `none` | Co-referee; shown when approved |
| `co-advisor-male` | `bool` | `true` | Grammatical gender of the co-advisor label |

</details>


## Cookbook

<details>
<summary><strong>Your own title page</strong></summary>

You can fully customize the title page if you need something other than the default.
The `title-page` parameter accepts content, or a function the template calls with the details it already knows:

```typst
#import "@preview/kinetic-kit:0.1.1": thesis

#let your-custom-title-page(
  title,
  author-firstname: "",
  author-surname: "",
  format: "a5",
  lang: "de",
  ..rest,
) = align(center)[
  #v(2cm)
  #text(size: 20pt, weight: "bold")[#title]
  #v(1cm)
  #author-firstname #author-surname
]

#show: thesis.with(
  title: [Titel der Masterarbeit],
  author-firstname: "Max",
  author-surname: "Mustermann",
  title-page: your-custom-title-page,
)
```

The template supplies `title`, `author-firstname`, `author-surname`, `format` and `lang`,
so they stay in step with the PDF metadata — pre-binding them with `.with()` has no effect.
Take only what you need and let `..rest` absorb the others. Page geometry, and the
suppressed header, footer and page number, are applied for you; a `set page` of your own
overrides them.

Pass `title-page: none` to omit the page entirely, or `doctoral-title-page` (exported at
the top level) to build the default page yourself:

```typst
#import "@preview/kinetic-kit:0.1.1": doctoral-title-page, thesis

#show: thesis.with(
  title: [Titel der Dissertation],
  title-page: doctoral-title-page.with(status-approved: true, exam-date: "12. Mai 2026"),
)
```

</details>

<details>
<summary><strong>Outline helpers</strong></summary>

The `outlines` namespace holds the table of contents and the back-matter list pages.
Using the template's helpers instead of the built-in `#outline` makes sure formatting and localization is correct.
For the backmatter listings, these helpers are also required to make `outlines.flex-caption` work.
Place them inside the `front-matter` / `back-matter` content of `thesis()`.

```typst
#import "@preview/kinetic-kit:0.1.1": outlines, thesis

#show: thesis.with(
  back-matter: [
    #outlines.list-of-figures()
    #outlines.list-of-tables()
    // A declared figure kind — the title is required:
    #outlines.list-of("algorithm", [Algorithmenverzeichnis])
    #bibliography("refs.bib", title: [Literaturverzeichnis], style: "ieee")
  ],
)
```

</details>

<details>
<summary><strong>Matching template styles in custom figures</strong></summary>

The `kit-style` namespace exposes the template's visual constants so custom figures and diagrams can match the document's typography and color palette exactly.

```typst
#import "@preview/kinetic-kit:0.1.1": kit-style

// kit-style.fonts                — (serif, sans, mono) font family arrays
// kit-style.font-sizes-by-format  — dict keyed by format: font sizes per format
// kit-style.leading               — paragraph line spacing (0.75em)
// kit-style.colors                — KIT color palette (green, blue, red, …)

#figure(
  {
    set text(font: kit-style.fonts.sans, size: kit-style.font-sizes-by-format.at("a5").small)
    rect(
      fill: kit-style.colors.green15,
      stroke: kit-style.colors.green,
      width: 6cm, height: 3cm,
    )
  },
  caption: [A custom figure using template styles.],
)
```

</details>

<details>
<summary><strong>Custom figure kinds (algorithms, theorems, …)</strong></summary>

Typst gives every figure `kind` its own counter and supplement,
but only styles the ones it knows: `image`, `table` and `raw` (code listings).
The template carries strings for exactly those three.
Anything else is your document's vocabulary, so you declare it.

**Declaring a kind.** Give it a `supplement`, either one value or one per language:

```typst
#show: thesis.with(
  figure-kinds: (
    (kind: "algorithm", supplement: (de: [Algorithmus], en: [Algorithm])),
    (kind: "theorem",   supplement: [Theorem]),
  ),
)
```

Then tag the figure:

```typst
#figure(
  algorithm-body,
  caption: [This is an algorithm.],
  kind: "algorithm",
)
```

**List pages.** Put an `outlines.list-of` call in `back-matter` for each kind you want listed,
in whatever order you want them — the built-in `image`/`table`/`raw` included:

```typst
back-matter: [
  #outlines.list-of-figures()
  #outlines.list-of-tables()
  #outlines.list-of("algorithm", [List of Algorithms])
],
```

`outlines.list-of` also sets the state that switches `outlines.flex-caption` to its short form.

</details>

<details>
<summary><strong>Draft mode with git SHA watermark</strong></summary>

Set `draft: true` to show an "ENTWURF" (German) or "DRAFT" (English) watermark on every page. Pass `draft-info` for an additional version string:

```typst
#show: thesis.with(
  // ...
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

**Important:** `#show: make-glossary` must appear *before* `#show: thesis.with(...)`. Forgetting this causes silent failure — abbreviations will not expand.

```typst
#import "@preview/kinetic-kit:0.1.1": thesis
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary

#let abbrevs = (
  (key: "ml",  short: "ML",  long: "Machine Learning"),
  (key: "cnn", short: "CNN", long: "Convolutional Neural Network"),
)

// Must come before #show: thesis.with(...)
#show: make-glossary
#register-glossary(abbrevs)

#show: thesis.with(
  // ...
  front-matter: [
    = List of Abbreviations
    #print-glossary(abbrevs)

    #outlines.table-of-contents()
  ],
)

// @ml expands to "Machine Learning (ML)" on first use, "ML" thereafter.
```

For a nicer two-column grid layout (bold abbreviation on the left, long form on the right) instead of the default `print-glossary` output, see the custom `abbrevs-glossary()` helper in [`examples/content/abbreviations.typ`](examples/content/abbreviations.typ).

</details>

<details>
<summary><strong>Margin notes for drafts (Drafting)</strong></summary>

Use the [drafting](https://typst.app/universe/package/drafting) package to add margin notes during writing. Tie `is-draft` to both the watermark and note visibility so they are toggled in one place:

```typst
#import "@preview/kinetic-kit:0.1.1": thesis
#import "@preview/drafting:0.2.2": set-margin-note-defaults, margin-note

#let is-draft = true
#set-margin-note-defaults(hidden: not is-draft)

#show: thesis.with(
  // ...
  draft: is-draft,
)

// In your text:
#margin-note[Revisit this paragraph.]
```

Set `is-draft = false` before final compilation to hide all margin notes and remove the watermark.

</details>

## Contributing

Contributions are welcome.
Refer to [CONTRIBUTING.md](https://github.com/ll-nick/kinetic-kit/blob/main/CONTRIBUTING.md)
for details and development setup.

## License

Template code: MIT-0 (no attribution required).
<!-- package:strip-start — the fonts are not part of the published package -->
The Libertinus fonts bundled in this repository (`fonts/`) are licensed under the SIL OFL 1.1.
<!-- package:strip-end -->

## Acknowledgements

This template has been implemented with AI assistance (Claude Code by Anthropic).
The basis for the template are the [KSP handbook](https://www.bibliothek.kit.edu/downloads/KSP/KSP-Manuskripthandbuch.pdf),
the [official KSP LaTeX template](https://gitlab.kit.edu/kit/ksp/ksp-vorlage-a5-de-diss),
as well as [this LaTeX template](https://gitlab.cc-asp.fraunhofer.de/kit-ksp/dissertation-template).
Some inspiration was also drawn from the [TUM-tastic thesis template](https://github.com/santiagonar1/tum-tastic-thesis).


[^1]: This template is provided "as is".
Please note that further technical assistance is currently not available. 

