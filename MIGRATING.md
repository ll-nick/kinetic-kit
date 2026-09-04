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

**4. The outline helpers are gone; use Typst's own `outline`.** `print-toc`,
`print-lof` / `print-lot` / `print-lol` and `print-list-of` have no replacement in the
package, because the template now styles and names every outline in the document:

```typst
// 0.1.x
#components.print-toc(lang: "de")
#components.print-lof(lang: "de")
#components.print-list-of("algorithm", title: [Algorithmenverzeichnis])

// 0.2.0
#outline()
#outline(target: figure.where(kind: image))
#outline(title: [Algorithmenverzeichnis], target: figure.where(kind: "algorithm"))
```

Omit `title` on a list page and the template supplies the localized name for `image`,
`table` and `raw`; a kind it has no word for still names itself, and omitting the title
there is a compile error. `title: none` suppresses the heading entirely. As before, a list
page is outlined and bookmarked, so it reaches the table of contents and the PDF bookmarks
— which a bare Typst `outline` does not manage on its own.

`print-dissertation-title` → `doctoral-title-page` (top-level).

The `components` namespace is gone, and with it the `setup-page` /
`setup-front-matter` / `setup-content` / `setup-appendix` helpers: `thesis()` is the only
way to assemble a document now.

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

    #outline()
  ],
  back-matter: [
    #outline(target: figure.where(kind: image))
    #bibliography("refs.bib", style: "ieee")
  ],
)
```

The old `bibliography:` parameter took `bibliography(title: none)` and supplied the
heading itself. Now the `bibliography(..)` call goes in `back-matter` and keeps its own
heading, which the template titles for you — see point 7.

**6. `figure-kinds` entries are `(kind:, supplement:)` only.** The `list-title` and
`show-list` fields are gone. To list a declared kind, put
`#outline(title: [List of Algorithms], target: figure.where(kind: "algorithm"))` in
`back-matter` — same as for the built-in `image` / `table` / `raw`, whose `show-lof` /
`show-lot` / `show-lol` booleans are also gone.

**7. The bibliography names itself.** `bibliography(..)` no longer needs a `title:`: the
template titles it *Literaturverzeichnis* in German and *Bibliography* in English, where
Typst's own default would give *Bibliografie*. Passing a `title:` still overrides it, and
`title: none` still suppresses the heading.

**8. `flex-caption` is unchanged and still imported from the package root.** It now works
inside any outline, including one you write by hand, rather than only inside the
template's list-page helpers.
