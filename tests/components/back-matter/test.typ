// Compile-only: print-lof, print-lot, print-lol — verifies the flex-caption
// state management compiles correctly when list functions are called directly.
#import "/lib.typ": components, flex-caption

#show: components.setup-page.with(lang: "en", margin-preset: "short")
#show: components.setup-content

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

#components.print-lof(lang: "en")
#components.print-lot(lang: "en")
#components.print-lol(lang: "en")
