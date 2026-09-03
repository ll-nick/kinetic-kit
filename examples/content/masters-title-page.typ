// An exemplary title page for a Master's / Bachelor's / Diploma thesis.
//
// Use this as a starting point for your own title page.
//
// The template calls this with `title` plus `author-firstname`, `author-surname`, `format`
// and `lang`, and wraps it in the page geometry — margins, and suppressed header, footer
// and page number — so it only has to lay out its own content. `..rest` absorbs any
// argument it does not use.

#import "/lib.typ": kit-style

#let masters-title-page(
    title,
    thesis-type: "Masterarbeit",
    author-firstname: "Max",
    author-surname: "Mustermann",
    department: "KIT-Fakultät für Maschinenbau",
    university-genitive: "des Karlsruher Instituts für Technologie (KIT)",
    examiner: none,
    supervisor: none,
    date-submitted: none,
    format: "a5",
    ..rest,
) = {
    let fonts = kit-style.fonts
    let font-sizes = kit-style.font-sizes-by-format.at(format)

    set text(font: fonts.sans, size: font-sizes.base)

    v(18mm)
    align(center)[
        #set par(justify: false)
        #text(
            font: fonts.serif,
            size: font-sizes.title,
            weight: "bold",
            hyphenate: false,
        )[#title]
    ]

    v(1fr)

    align(center)[
        #text(size: font-sizes.title-info)[#thesis-type]
        \
        #v(3mm)
        #text(size: font-sizes.base)[
            #department \
            #university-genitive
        ]
        \
        #v(5mm)
        #text(size: font-sizes.base)[von]
        \
        #v(2mm)
        #text(size: font-sizes.author, weight: "bold")[
            #author-firstname #author-surname
        ]
    ]

    v(1fr)

    v(4mm)
    grid(
        columns: (auto, 1fr),
        column-gutter: 1em,
        row-gutter: 3mm,
        [Erstprüfer:], if examiner != none { examiner } else { "–" },
        [Betreuer:], if supervisor != none { supervisor } else { "–" },
        [Eingereicht am:], if date-submitted != none { date-submitted } else { "–" },
    )
    v(4mm)
}
