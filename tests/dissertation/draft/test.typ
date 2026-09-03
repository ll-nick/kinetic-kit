// Compile-only: draft mode with watermark and draft-info string.
#import "/lib.typ": dissertation, doctoral-title-page

#show: dissertation.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Draft Dissertation],
    lang: "de",
    draft: true,
    draft-info: "v0.1 — 2025-01-01",
    title-page: doctoral-title-page.with(
        author-title: "M.Sc.",
        author-male: true,
    ),
)

= Chapter One

Draft content.
