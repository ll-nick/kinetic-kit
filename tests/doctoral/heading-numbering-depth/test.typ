// Compile-only: exercises `heading-numbering-depth`. Set to 4 (non-default), so
// levels 1–4 are numbered and level 5 is styled but unnumbered. The contents
// outline follows it, listing down to level 4 and stopping short of level 5.
// Also stresses the heading-grid indent measurement, which folds over every level.
#import "/lib.typ": thesis

#show: thesis.with(
    title: [Heading Numbering Depth],
    heading-numbering-depth: 4,
)

= Level One

Numbered at depth 1.

== Level Two

Numbered at depth 2.

=== Level Three

Numbered at depth 3.

==== Level Four

Numbered at depth 4 (equal to `heading-numbering-depth`).

===== Level Five

Deeper than `heading-numbering-depth`: styled but not numbered.
