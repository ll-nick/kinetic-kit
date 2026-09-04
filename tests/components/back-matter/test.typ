// Compile-only: the outlines list pages placed in `back-matter` — verifies the
// `flex-caption` state management (short form inside a list page) compiles when
// the list functions run through `thesis()`.
#import "/lib.typ": flex-caption, outlines, thesis

#show: thesis.with(
    title: [List Pages],
    lang: "en",
    front-matter: [#outlines.table-of-contents()],
    back-matter: [
        #outlines.list-of-figures()
        #outlines.list-of-tables()
        #outlines.list-of-listings()
    ],
)

= Chapter One

#figure(
    rect(width: 3cm, height: 2cm),
    caption: flex-caption(short: [Short caption], long: [Long caption for the figure
        body.]),
)

#figure(
    table(
        columns: 2,
        [A], [B],
    ),
    caption: [A table.],
    kind: table,
)
