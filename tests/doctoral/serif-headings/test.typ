// Compile-only: exercises `serif-headings: true` — headings render in Libertinus
// Serif instead of the default Libertinus Sans (drives the `hfont` branch used by
// both the heading show rule and the indent measurement).
#import "/lib.typ": thesis

#show: thesis.with(
    title: [Serif Headings],
    serif-headings: true,
)

= Introduction

Body text under a serif heading.

== A Section

More text.

=== A Subsection

Even more text.
