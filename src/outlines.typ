// Table of contents and list pages

#import "kit-fonts.typ": font-sizes, fonts
#import "translations.typ": t

/// Print the table of contents, including a separate appendix outline when present.
///
/// - lang (str): Document language — `"de"` or `"en"`.
/// -> content
#let print-toc(lang: "de") = {
    let tr = t.at(lang)

    show outline.entry.where(level: 1): it => {
        v(1.6em, weak: true)
        strong(it)
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
            // Appendix outline title: styled like level 1 headings,
            // but without the page break and counter resets.
            show heading.where(level: 1): it => {
                v(1.6em, weak: true)
                block(text(
                    font: fonts.sans,
                    size: font-sizes.chapter,
                    weight: "bold",
                    it.body,
                ))
            }
            outline(
                target: heading.where(numbering: "A.1"),
                title: tr.appendix,
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
    state("in-outline", false).update(true)
    outline(
        title: t.at(lang).lof,
        target: figure.where(kind: image),
    )
    state("in-outline", false).update(false)
}

/// Print the list of tables.
///
/// - lang (str): Document language — `"de"` or `"en"`.
/// -> content
#let print-lot(lang: "de") = {
    state("in-outline", false).update(true)
    outline(
        title: t.at(lang).lot,
        target: figure.where(kind: table),
    )
    state("in-outline", false).update(false)
}

/// Print the list of listings.
///
/// - lang (str): Document language — `"de"` or `"en"`.
/// -> content
#let print-lol(lang: "de") = {
    state("in-outline", false).update(true)
    outline(
        title: t.at(lang).lol,
        target: figure.where(kind: raw),
    )
    state("in-outline", false).update(false)
}

/// Two-part caption: short version for LoF/LoT, long version under the figure.
///
/// Usage: `#figure(…, caption: flex-caption(short: [Short], long: [Long.]))`
///
/// - short (content): Short caption shown in List of Figures / Tables.
/// - long (content): Full caption shown below the figure in the document body.
/// -> content
#let flex-caption(short: none, long: none) = context if state(
    "in-outline",
    false,
).get() {
    short
} else {
    long
}
