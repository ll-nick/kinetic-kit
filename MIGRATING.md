# Migrating from 0.1.x

`dissertation()` and `thesis()` were one document engine with two title pages, so 0.2.0
merges them into a single `thesis()` and makes the title page a parameter.

**1. `dissertation(...)` becomes `thesis(...)`.** Rename the import and the show rule.
There is no `dissertation` any more.

**2. Title-page parameters move onto the title page.** These twelve now belong to
`doctoral-title-page`, not the entry point: `author-title`, `author-male`, `doc-degree`,
`doc-degree-f`, `department`, `university-genitive`, `status-approved`, `exam-date`,
`main-advisor`, `main-advisor-male`, `co-advisor`, `co-advisor-male`.

Rename the import from `dissertation` to `thesis`, and add `doctoral-title-page`:

```typst
// 0.1.x
#show: dissertation.with(
  author-firstname: "Max",
  author-surname: "Mustermann",
  author-title: "M.Sc.",
  department: "KIT-Fakultät für Maschinenbau",
  status-approved: true,
  exam-date: "12. Mai 2026",
  lang: "de",
)

// 0.2.0
#show: thesis.with(
  author-firstname: "Max",
  author-surname: "Mustermann",
  lang: "de",
  title-page: doctoral-title-page.with(
    author-title: "M.Sc.",
    department: "KIT-Fakultät für Maschinenbau",
    status-approved: true,
    exam-date: "12. Mai 2026",
  ),
)
```

`title`, `author-firstname`, `author-surname`, `format` and `lang` stay on `thesis()` —
it passes them to the title page, so they are still written once.

**3. Student theses supply their own title page.** `print-thesis-title` and its
`thesis-type` / `examiner` / `supervisor` / `date-submitted` parameters are no longer part of the package: 
Refer to [`examples/content/masters-title-page.typ`](examples/content/masters-title-page.typ) for an example.
Copy it into your project, edit it, and pass it as `title-page`. See
[Your own title page](README.md#cookbook) in the README.

**4. The outline helpers lost their `print-` prefix and moved under the `outlines`
namespace.** `print-toc` → `outlines.table-of-contents`, `print-lof` / `print-lot` /
`print-lol` → `outlines.list-of-figures` / `list-of-tables` / `list-of-listings`,
`print-list-of` → `outlines.list-of`, `print-dissertation-title` → `doctoral-title-page`
(top-level). Add `outlines` to the package import alongside `thesis`.
`table-of-contents` and the `list-of-*` shorthands take `title: auto` (localized default)
and no longer take `lang:`. `list-of(kind, title)` now requires the title as a positional
argument.

The `components` namespace that used to carry them is gone,
and with it the `setup-page` / `setup-front-matter` / `setup-content` / `setup-appendix`
helpers: `thesis()` is the only way to assemble a document now.

**5. Front and back matter are plain content now, not split across several parameters.** These twelve are
gone: `abstract-en`, `abstract-de`, `acknowledgements`, `notation`, `abbreviations`,
`show-lof`, `show-lot`, `show-lol`, `bibliography`, `own-publications`, `own-patents`,
`supervised-theses`.
Write the same sections as ordinary markup in the new `front-matter` and `back-matter`
parameters, each with its own heading, in the order you want them. Heading numbering is suppressed there, so a bare `= Danksagung`
matches what the old `acknowledgements:` parameter produced.

```typst
// 0.1.x
#show: thesis.with(
  abstract-de: include "abstract-de.typ",
  abstract-en: include "abstract-en.typ",
  acknowledgements: [Ich danke …],
  show-lof: true,
  bibliography: bibliography("refs.bib", title: none, style: "ieee"),
)

// 0.2.0
#show: thesis.with(
  front-matter: [
    = Danksagung
    Ich danke …

    = Abstract
    #include "abstract-en.typ"

    = Kurzfassung
    #include "abstract-de.typ"

    #outlines.table-of-contents()
  ],
  back-matter: [
    #outlines.list-of-figures()
    #bibliography("refs.bib", title: [Literaturverzeichnis], style: "ieee")
  ],
)
```

`bibliography(title: none)` used to let the template supply the heading;
now pass the heading you want as `title:`.
Typst's own `auto` default gives "Bibliografie" in German, not "Literaturverzeichnis".

**6. `figure-kinds` entries are `(kind:, supplement:)` only.** The `list-title` and
`show-list` fields are gone. To list a declared kind, put
`#outlines.list-of("algorithm", [List of Algorithms])` in `back-matter` — same as for the
built-in `image` / `table` / `raw`, whose `show-lof` / `show-lot` / `show-lol` booleans
are also gone.

**7. `flex-caption` moved into the `outlines` namespace.** It only does anything on a
list page — `outlines.list-of` is what switches it to its short form — so it now lives
beside them: `flex-caption(...)` → `outlines.flex-caption(...)`. Drop `flex-caption` from
the package import; `outlines` already carries it.

```typst
// 0.1.x
#import "@preview/kinetic-kit:0.1.x": dissertation, flex-caption
#figure(image("plot.svg"), caption: flex-caption(short: [Short], long: [Long.]))

// 0.2.0
#import "@preview/kinetic-kit:0.1.1": outlines, thesis
#figure(image("plot.svg"), caption: outlines.flex-caption(short: [Short], long: [Long.]))
```
