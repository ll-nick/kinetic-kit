#import "src/dissertation.typ": dissertation
#import "src/thesis.typ": thesis
#import "src/outlines.typ": flex-caption

// ── Component exports ─────────────────────────────────────────────────────
//
// Individual building blocks for custom document composition.
// Import only what you need, e.g.:
//   #import "@preview/kinetic-kit:0.1.0": setup-page, setup-front-matter, print-toc

#import "src/page-setup.typ": (
    setup-appendix, setup-content, setup-front-matter, setup-page,
)
#import "src/title-page.typ": print-dissertation-title, print-thesis-title
#import "src/outlines.typ": print-lof, print-lol, print-lot, print-toc
