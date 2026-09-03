// Compile-only: thesis in draft mode — exercises the draft watermark and
// draft-info passthrough through the thesis() orchestrator.
#import "/lib.typ": print-thesis-title, thesis

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Draft Thesis],
    lang: "en",
    draft: true,
    draft-info: "v0.1 — test",
    title-page: print-thesis-title.with(
        thesis-type: "Bachelorarbeit",
    ),
)

= Introduction

Content rendered with the draft watermark on every page.
