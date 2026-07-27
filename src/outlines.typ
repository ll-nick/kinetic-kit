// Table of contents and list pages

#import "typography.typ": fonts
#import "translations.typ": t
#import "figures.typ": in-outline

/// Shared outline styling, applied as a show rule so every outline in the
/// document — including a user's own — matches.
///
/// - body (content): Document body (injected automatically by the show rule).
/// -> content
#let setup-outlines(body) = {
    set outline.entry(fill: repeat(".", gap: 0.7em, justify: false))
    show outline: set par(justify: false)
    show outline.entry: it => context {
        // Measured rather than fixed because Roman front-matter page numbers can
        // exceed a 3-digit Arabic one.
        let page-width = query(outline.entry).fold(0pt, (w, e) => calc.max(
            w,
            measure(e.page()).width,
        ))
        // Bold only the parts, never the leader: `strong` is an additive weight,
        // so bolding the whole entry would also thicken the dots.
        let bold = if it.level == 1 and it.element.func() == heading {
            strong
        } else {
            it => it
        }
        // Two columns keep the body from wrapping under the page number;
        // right-aligning the leader makes it end at the same x on every row.
        link(
            it.element.location(),
            grid(
                columns: (1fr, page-width),
                column-gutter: 0.5em,
                align: (top + left, bottom + right),
                it.indented(bold(it.prefix()), {
                    bold(it.body())
                    h(0.5em)
                    box(width: 1fr, align(right, it.fill))
                }),
                bold(it.page()),
            ),
        )
    }
    body
}

/// Print the table of contents, including a separate appendix outline when present.
///
/// - lang (str): Document language — `"de"` or `"en"`.
/// - serif-headings (bool): Use serif font for the appendix section title when `true`.
/// - font-sizes (dict): Format-specific font sizes resolved by the template.
/// -> content
#let print-toc(font-sizes, lang: "de", serif-headings: false) = {
    set text(hyphenate: false)
    let tr = t.at(lang)
    let hfont = if serif-headings { fonts.serif } else { fonts.sans }

    // Extra space above each top-level entry.
    show outline.entry.where(level: 1): it => {
        v(1.6em, weak: true)
        it
    }

    // Main content entries
    outline(
        target: heading.where(numbering: "1.1").or(heading.where(numbering: none)),
        title: tr.toc,
        depth: 3,
        indent: auto,
    )

    // Appendix entries
    context {
        let has-appendix = query(heading.where(numbering: "A.1")).len() > 0
        if has-appendix {
            v(0.7em, weak: false)
            // Appendix section title rendered as styled text (not a real heading),
            // so it doesn't register as a level-1 heading and won't suppress
            // running headers on continuation pages of this outline.
            v(1.6em, weak: true)
            block(text(
                font: hfont,
                size: font-sizes.chapter,
                weight: "bold",
                tr.appendix,
            ))
            outline(
                target: heading.where(numbering: "A.1"),
                title: none, // Already manually inserted above
                depth: 3,
                indent: auto,
            )
        }
    }
}

/// Print the list of figures.
///
/// - lang (str): Document language — `"de"` or `"en"`.
/// -> content
#let print-lof(lang: "de") = {
    set text(hyphenate: true)
    in-outline.update(true)
    outline(
        title: t.at(lang).lof,
        target: figure.where(kind: image),
    )
    in-outline.update(false)
}

/// Print the list of tables.
///
/// - lang (str): Document language — `"de"` or `"en"`.
/// -> content
#let print-lot(lang: "de") = {
    set text(hyphenate: true)
    in-outline.update(true)
    outline(
        title: t.at(lang).lot,
        target: figure.where(kind: table),
    )
    in-outline.update(false)
}

/// Print the list of listings.
///
/// - lang (str): Document language — `"de"` or `"en"`.
/// -> content
#let print-lol(lang: "de") = {
    set text(hyphenate: true)
    in-outline.update(true)
    outline(
        title: t.at(lang).lol,
        target: figure.where(kind: raw),
    )
    in-outline.update(false)
}
