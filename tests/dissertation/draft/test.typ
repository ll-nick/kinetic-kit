// Compile-only: draft mode with watermark and draft-info string.
#import "/lib.typ": dissertation

#show: dissertation.with(
    author-title: "M.Sc.",
    author-firstname: "Max",
    author-surname: "Mustermann",
    author-male: true,
    title: [Draft Dissertation],
    lang: "de",
    draft: true,
    draft-info: "v0.1 — 2025-01-01",
)

= Chapter One

Draft content.
