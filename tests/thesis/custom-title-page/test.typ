// Compile-only: the same custom title page hook on thesis().
#import "/lib.typ": thesis

#let custom-title-page(title, ..rest) = align(center)[#title]

#show: thesis.with(
    title: [Custom Title Page],
    title-page: custom-title-page,
)

= Chapter
Body text.
