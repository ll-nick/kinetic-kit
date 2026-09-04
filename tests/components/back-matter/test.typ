// Compile-only: list pages placed in `back-matter` — verifies the
// `flex-caption` state management (short form inside a list page) compiles when
// the list functions run through `thesis()`.
#import "/lib.typ": flex-caption, thesis

#show: thesis.with(
    title: [List Pages],
    lang: "en",
    front-matter: [#outline()],
    back-matter: [
        #outline(target: figure.where(kind: image))
        #outline(target: figure.where(kind: table))
        #outline(target: figure.where(kind: raw))
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
