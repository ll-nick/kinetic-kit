// Compile-only: thesis in draft mode — exercises the draft watermark and
// draft-info passthrough through the thesis() orchestrator.
#import "/lib.typ": thesis

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Draft Thesis],
    thesis-type: "Bachelorarbeit",
    lang: "en",
    draft: true,
    draft-info: "v0.1 — test",
)

= Introduction

Content rendered with the draft watermark on every page.
