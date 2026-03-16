# scholarly-kit

A KIT dissertation and thesis template for [Typst](https://typst.app), designed to comply with the formatting requirements of [KIT Scientific Publishing (KSP)](https://www.bibliothek.kit.edu/ksp-toolbox.php).

> **Disclaimer:** This is an unofficial community template. It is not affiliated with, endorsed by, or approved by KIT (Karlsruhe Institute of Technology) or KIT Scientific Publishing. The template attempts to follow the [KSP Basic Layout Guidelines](https://www.bibliothek.kit.edu/downloads/KSP/KSP-Basic-Layout-Guidelines.pdf) but compliance is not guaranteed. Always verify your final manuscript with KSP before submission.

> **Please note**: This template is in early development and may contain incomplete features, bugs, or formatting issues.
> You should probably not use it yet for your actual dissertation or thesis until it has reached a more mature state.

## Prerequisites

- Typst 0.14.2 (pinned in `mise.toml`)
- Libertinus fonts installed on your system (see below)

[mise](https://mise.jdx.dev) is recommended for managing the Typst version and running build tasks. All tasks are plain shell scripts in `mise/tasks/` and can be run directly without mise.

## Quick Start

```bash
# Install fonts (once)
mise run install:fonts        # or: bash mise/tasks/install/fonts

# Register as a local Typst package
mise run install              # or: bash mise/tasks/install/_default

# Build all examples and API docs
mise run build                # or: bash mise/tasks/build/examples && bash mise/tasks/build/docs
```

### Available tasks

| Task | Description |
|------|-------------|
| `mise run build` | Compile all examples and API docs |
| `mise run build:examples` | Compile example documents only |
| `mise run build:docs` | Compile API reference (`docs/api-reference.pdf`) |
| `mise run install` | Install as local Typst package (copy) |
| `mise run install:editable` | Install as local Typst package (symlink, editable) |
| `mise run install:fonts` | Install bundled Libertinus fonts to user font directory |

### Editable install

Use `mise run install:editable` during development — changes to the template take effect immediately without reinstalling. Use `mise run install` for a stable copy that persists if the repository is deleted.

In `dissertation/main.typ`:

```typst
#import "@local/scholarly-kit:0.1.0": dissertation, appendix

#show: dissertation.with(
  author-firstname: "Max",
  author-surname:   "Mustermann",
  title:            [Title of the Dissertation],
  lang:             "de",
  abstract-de:      include "content/abstract-de.typ",
  abstract-en:      include "content/abstract-en.typ",
)

#include "content/01-introduction.typ"

#pagebreak()
#bibliography("bib/references.bib", title: "Literaturverzeichnis", style: "ieee")

#show: appendix
= Appendix Chapter
```

See `example/dissertation-approved.typ` for a complete example with all options documented.

## Parameters — `dissertation(...)`

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `author-title` | `str \| none` | `"M.Sc."` | Academic title; `none` to omit |
| `author-firstname` | `str` | `"Max"` | |
| `author-surname` | `str` | `"Mustermann"` | |
| `author-male` | `bool` | `true` | Controls gendered German text |
| `place-of-birth` | `str \| none` | `none` | Place of birth ("aus …"); `none` = omit |
| `title` | `content` | | Thesis title |
| `doc-degree` | `str` | `"Doktors der Ingenieurwissenschaften (Dr.-Ing.)"` | |
| `doc-degree-f` | `str` | `"Doktorin der Ingenieurwissenschaften (Dr.-Ing.)"` | |
| `department` | `str` | `"KIT-Fakultät für Maschinenbau"` | |
| `university-genitive` | `str` | `"des Karlsruher Instituts für Technologie (KIT)"` | |
| `lang` | `"de" \| "en"` | `"de"` | Document language |
| `margin-preset` | `"short" \| "medium" \| "long"` | `"short"` | KSP margin profile (see below) |
| `status-approved` | `bool` | `false` | `false` = eingereicht, `true` = angenommen |
| `exam-date` | `str \| none` | `none` | Required when `status-approved = true` |
| `main-advisor` | `str \| none` | `none` | Hauptreferent |
| `main-advisor-male` | `bool` | `true` | |
| `co-advisor` | `str \| none` | `none` | Korreferent |
| `co-advisor-male` | `bool` | `true` | |
| `abstract-en` | `content \| none` | `none` | |
| `abstract-de` | `content \| none` | `none` | |
| `acknowledgements` | `content \| none` | `none` | |
| `cv-name` | `str \| none` | `none` | Show CV page if set |
| `cv-entries` | `array` | `()` | `(year, description)` tuples |
| `binding-correction` | `length` | `0mm` | BCOR added to inside margin (8–10 mm for print) |
| `colored-links` | `bool` | `true` | KIT Blue hyperlinks (screen); `false` = black (print) |
| `draft` | `bool` | `false` | Show "ENTWURF" watermark on content pages |
| `draft-info` | `str \| none` | `none` | Version string in watermark (e.g. git SHA) |
| `notation` | `content \| none` | `none` | Symbol/notation list |
| `abbreviations` | `content \| none` | `none` | Manual acronym list; ignored when `glossary-entries` is set |
| `glossary-entries` | `array \| none` | `none` | Glossarium entries for auto-expansion via `gls()` |
| `own-publications` | `content \| none` | `none` | Back-matter publications |
| `own-patents` | `content \| none` | `none` | Back-matter patents |
| `supervised-theses` | `content \| none` | `none` | Back-matter supervised theses |
| `show-lof` | `bool` | `true` | List of figures |
| `show-lot` | `bool` | `true` | List of tables |
| `show-lol` | `bool` | `false` | List of listings |

## Parameters — `thesis(...)`

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `author-firstname` | `str` | `"Max"` | |
| `author-surname` | `str` | `"Mustermann"` | |
| `title` | `content` | | Thesis title |
| `thesis-type` | `str` | `"Masterarbeit"` | e.g. `"Bachelorarbeit"`, `"Diplomarbeit"` |
| `department` | `str` | `"KIT-Fakultät für Maschinenbau"` | |
| `university-genitive` | `str` | `"des Karlsruher Instituts für Technologie (KIT)"` | |
| `examiner` | `str \| none` | `none` | Erstprüfer |
| `supervisor` | `str \| none` | `none` | Betreuer |
| `date-submitted` | `str \| none` | `none` | |
| `lang` | `"de" \| "en"` | `"de"` | |
| `margin-preset` | `"short" \| "medium" \| "long"` | `"short"` | |
| `binding-correction` | `length` | `0mm` | BCOR added to inside margin |
| `colored-links` | `bool` | `true` | KIT Blue links (screen); `false` = black (print) |
| `draft` | `bool` | `false` | Show "ENTWURF" watermark on content pages |
| `draft-info` | `str \| none` | `none` | Version string in watermark |
| `abstract-en` | `content \| none` | `none` | |
| `abstract-de` | `content \| none` | `none` | |
| `acknowledgements` | `content \| none` | `none` | |
| `abbreviations` | `content \| none` | `none` | Manual acronym list; ignored when `glossary-entries` is set |
| `glossary-entries` | `array \| none` | `none` | Glossarium entries for auto-expansion via `gls()` |
| `show-lof` | `bool` | `true` | |
| `show-lot` | `bool` | `true` | |
| `show-lol` | `bool` | `false` | |

## Draft Mode

Set `draft: true` to stamp a light "ENTWURF" watermark on every content page. Optionally pass a version string (e.g. the current git SHA) via `draft-info`:

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

## Automatic Abbreviation Expansion (Glossarium)

Pass a `glossary-entries` array to enable automatic first-use expansion of abbreviations via the [glossarium](https://typst.app/universe/package/glossarium) package. The template re-exports `gls` and `glspl` so you only need one import:

```typst
#import "@local/scholarly-kit:0.1.0": dissertation, appendix, gls, glspl

#show: dissertation.with(
  ...
  glossary-entries: (
    (key: "ml",  short: "ML",  long: "Machine Learning"),
    (key: "cnn", short: "CNN", long: "Convolutional Neural Network"),
  ),
)

// In your text: #gls("ml") expands to "Machine Learning (ML)" on first use,
// "ML" on subsequent uses. The abbreviations list is printed automatically.
```

When `glossary-entries` is set, the `abbreviations` parameter is ignored.

## Margin Presets

Choose based on the total page count of the finished dissertation (KSP requirement):

| Preset | Page count | Inner | Outer |
|--------|-----------|-------|-------|
| `"short"` | < 200 | 20 mm | 15 mm |
| `"medium"` | 200–399 | 23 mm | 15 mm |
| `"long"` | ≥ 400 | 25 mm | 15 mm |

## KSP Compliance Notes

- Paper: DIN A5
- Base font: 10 pt (Libertinus Serif)
- Line spacing: 1.15×
- No Computer Modern or LM fonts (forbidden by KSP)
- Chapters start on odd (right-hand) pages
- Blank pages carry no header, footer, or page number
- Page numbers: outside (right on odd, left on even pages)
- Headers: chapter title on left page, section title on right page

## License

Template code: MIT-0 (no attribution required). Bundled fonts (`fonts/`): SIL OFL 1.1.

---

> **Full transparency**: This template has been implemented with AI assistance (Claude Code by Anthropic).
> The basis for the template are the [KSP guidelines](https://www.bibliothek.kit.edu/downloads/KSP/KSP-Basic-Layout-Guidelines.pdf), the [official KSP LaTeX template](https://gitlab.kit.edu/kit/ksp/ksp-vorlage-a5-de-diss), as well as [this great LaTeX template](https://gitlab.cc-asp.fraunhofer.de/kit-ksp/dissertation-template).
