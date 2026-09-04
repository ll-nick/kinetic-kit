// The title and depth overrides on the outline helpers. Their `auto` defaults are
// covered everywhere else; the explicit forms are covered nowhere, and `depth` has
// no other caller at all.
#import "/lib.typ": outlines, thesis

#show: thesis.with(
    title: [Outline Options],
    lang: "en",
    front-matter: [
        // Chapters only: the sections below must not reach this outline.
        #outlines.table-of-contents(title: [Table of Contents], depth: 1)
    ],
    back-matter: [
        #outlines.list-of-figures(title: [Figures])
        #outlines.list-of-tables(title: [Tables])
        #outlines.list-of-listings(title: [Listings])
    ],
)

= First Chapter

== A Section That Must Not Appear In The Outline

#figure(
    rect(width: 3cm, height: 1cm),
    caption: outlines.flex-caption(short: [Short], long: [The long caption.]),
)

#figure(
    table(
        columns: 2,
        [a], [b],
    ),
    caption: [A table],
)

#figure(
    ```py
    print("hello")
    ```,
    caption: [A listing],
)
