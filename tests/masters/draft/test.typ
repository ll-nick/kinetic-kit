// Compile-only: thesis in draft mode — exercises the draft watermark and
// draft-info passthrough through the thesis() orchestrator.
#import "/lib.typ": thesis
#import "/examples/content/masters-title-page.typ": masters-title-page

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Draft Thesis],
    lang: "en",
    draft: true,
    draft-info: "v0.1 — test",
    title-page: masters-title-page.with(
        thesis-type: "Bachelorarbeit",
    ),
)

= Introduction

Content rendered with the draft watermark on every page.
