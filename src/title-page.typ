// KIT Dissertation / Thesis Title Page

#import "page-conf.typ": kit-page, title-page-margins
#import "kit-fonts.typ": font-sizes, fonts
#import "kit-colors.typ": kit-colors
#import "translations.typ": t

// ── Dissertation Title Page ────────────────────────────────────────────────
// All strings are always in German (legal document requirement).

#let print-dissertation-title(
    title,
    author-title,
    author-firstname,
    author-surname,
    author-male,
    place-of-birth,
    doc-degree,
    doc-degree-f,
    department,
    university-genitive,
    status-approved,
    exam-date,
    main-advisor,
    main-advisor-male,
    co-advisor,
    co-advisor-male,
) = {
    set page(
        paper: kit-page.type,
        margin: title-page-margins,
        binding: left,
        header: none,
        footer: none,
        numbering: none,
    )

    set text(font: fonts.sans, size: font-sizes.base)

    // Title page always uses German strings
    let tr = t.at("de")

    let author-name = author-firstname + " " + author-surname
    let author-full = if author-title != none {
        author-title + " " + author-name
    } else {
        author-name
    }

    // ── Zone ①: Title ─────────────────────────────────────────────────────
    v(18mm)
    align(center)[
        #text(font: fonts.serif, size: font-sizes.title, weight: "bold")[#title]
    ]

    // ── Zone ②: Degree claim and author ───────────────────────────────────
    v(1fr)

    align(center)[
        #text(size: font-sizes.base)[
            #tr.degree-preamble
            #if author-male { tr.degree-one } else { tr.degree-one-f }
        ]
        \
        #v(3mm)
        #text(size: font-sizes.title-info)[
            #if author-male { doc-degree } else { doc-degree-f }
        ]
        \
        #v(5mm)
        #text(size: font-sizes.base)[
            #if status-approved { tr.accepted-at } else { tr.submitted-at }
            #department \
            #university-genitive
        ]
        \
        #v(3mm)
        #text(size: font-sizes.base, weight: "bold")[
            #if status-approved { tr.accepted } else { tr.submitted }
        ]
        \
        #v(0.5mm)
        #text(size: font-sizes.title-info)[#tr.dissertation]
        \
        #v(0.5mm)
        #text(size: font-sizes.base)[#tr.by]
        \
        #v(0.5mm)
        #text(size: font-sizes.author, weight: "bold")[#author-full]
        #if place-of-birth != none [
            \
            #v(2mm)
            #text(size: font-sizes.base)[#tr.born-in #place-of-birth]
        ]
    ]

    v(1fr)

    // ── Zone ③: Exam date and advisors (only when approved) ───────────────
    if status-approved {
        v(4mm)
        grid(
            columns: (auto, 1fr),
            column-gutter: 1em,
            row-gutter: 3mm,
            [#tr.exam-date], if exam-date != none { exam-date } else { "–" },
            if main-advisor-male { [#tr.advisor] } else { [#tr.advisor-f] },
            if main-advisor != none { main-advisor } else { "–" },

            if co-advisor-male { [#tr.co-advisor] } else { [#tr.co-advisor-f] },
            if co-advisor != none { co-advisor } else { "–" },
        )
        v(4mm)
    } else {
        v(10mm)
    }
}

// ── Master / Bachelor Thesis Title Page ───────────────────────────────────

#let print-thesis-title(
    title,
    thesis-type,
    author-firstname,
    author-surname,
    department,
    university-genitive,
    examiner,
    supervisor,
    date-submitted,
    lang,
) = {
    set page(
        paper: kit-page.type,
        margin: title-page-margins,
        binding: left,
        header: none,
        footer: none,
        numbering: none,
    )

    set text(font: fonts.sans, size: font-sizes.base)

    let tr = t.at("de") // title page always in German
    let author-name = author-firstname + " " + author-surname

    v(18mm)
    align(center)[
        #text(font: fonts.serif, size: font-sizes.title, weight: "bold")[#title]
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
        #text(size: font-sizes.base)[#tr.by]
        \
        #v(2mm)
        #text(size: font-sizes.author, weight: "bold")[#author-name]
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
