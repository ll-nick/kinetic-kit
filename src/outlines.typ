// Table of contents and list pages

#import "typography.typ": font-sizes, fonts
#import "translations.typ": t

/// Print the table of contents, including a separate appendix outline when present.
///
/// - lang (str): Document language — `"de"` or `"en"`.
/// - serif-headings (bool): Use serif font for the appendix section title when `true`.
/// -> content
#let print-toc(lang: "de", serif-headings: false) = {
    let tr = t.at(lang)
    let hfont = if serif-headings { fonts.serif } else { fonts.sans }

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
