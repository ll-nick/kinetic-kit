// Compile-only: list-of-figures, list-of-tables, list-of-listings — verifies the flex-caption
// state management compiles correctly when list functions are called directly.
#import "/lib.typ": flex-caption, outlines
#import "/src/page-setup.typ": setup-content, setup-page

#show: setup-page.with(lang: "en", margin-preset: "short")
#show: setup-content

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

#outlines.list-of-figures()
#outlines.list-of-tables()
#outlines.list-of-listings()
