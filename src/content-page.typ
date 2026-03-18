// Table of contents and list pages

#import "kit-fonts.typ": font-sizes, fonts
#import "translations.typ": t

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
        indent: 1.6em,
    )

    // Appendix entries
    context {
        let has-appendix = query(heading.where(numbering: "A.1")).len() > 0
        if has-appendix {
            v(0.7em, weak: false)
            // Add a title for the appendix section that does not trigger a page break
            show outline: set heading(level: 2)
            show heading.where(level: 2): it => block(
                text(size: font-sizes.subsection, weight: "bold", it.body),
            )
            outline(
                target: heading.where(numbering: "A.1"),
                title: tr.appendix,
                depth: 3,
                indent: 1.6em,
            )
        }
    }
}

#let print-lof(lang: "de") = {
    state("in-outline", false).update(true)
    outline(
        title: t.at(lang).lof,
        target: figure.where(kind: image),
    )
    state("in-outline", false).update(false)
}

#let print-lot(lang: "de") = {
    state("in-outline", false).update(true)
    outline(
        title: t.at(lang).lot,
        target: figure.where(kind: table),
    )
    state("in-outline", false).update(false)
}

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
