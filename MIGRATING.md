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

**4. Components lost their `print-` prefix and use the long form.** `print-toc` → `table-of-contents`,
`print-lof` / `print-lot` / `print-lol` → `list-of-figures` / `list-of-tables` /
`list-of-listings`, `print-list-of` → `list-of`, `print-dissertation-title` →
`doctoral-title-page`. The matching parameters renamed too: `show-lof` / `show-lot` /
`show-lol` → `show-list-of-figures` / `show-list-of-tables` / `show-list-of-listings`.

