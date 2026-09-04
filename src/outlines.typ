// Table of contents and list pages

#import "translations.typ": t
#import "figures.typ": in-outline

/// Shared outline styling, applied as a show rule so every outline in the
/// document --- including a user's own --- matches.
///
/// -> content
#let setup-outlines(
    /// Document body, injected by the show rule.
    /// -> content
    body,
) = {
    set outline.entry(fill: repeat(".", gap: 0.4em, justify: false))
    show outline: set par(justify: false)
    show outline.entry: it => context {
        // Measured rather than fixed because Roman front-matter page numbers can
        // exceed a 3-digit Arabic one.
        let page-width = query(outline.entry).fold(0pt, (w, e) => calc.max(
            w,
            measure(e.page()).width,
        ))
        // Bold only the parts, never the leader: `strong` is an additive weight,
        // so bolding the whole entry would also thicken the dots. Passing `none`
        // through unwrapped keeps unnumbered chapters from getting an indent:
        // `strong(none)` is an empty prefix, not an absent one.
        let bold = if it.level == 1 and it.element.func() == heading {
            it => if it == none { none } else { strong(it) }
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

/// Print the table of contents.
///
/// -> content
#let table-of-contents(
    /// Heading of the outline. `auto` uses Typst's localized default for the
    /// document language.
    /// -> content | str | auto
    title: auto,

    /// Deepest heading level to list.
    /// -> int
    depth: 3,
) = {
    set text(hyphenate: false)

    // Extra space above each top-level entry.
    show outline.entry.where(level: 1): set block(above: 1.6em)

    // `auto` resolves against `text.lang`, which `setup-page` has already set.
    outline(title: title, depth: depth, indent: auto)
}

/// Print a back-matter list page for one figure kind.
///
/// Handles the state that switches @flex-caption to its short form, which a
/// hand-rolled `outline(target: …)` would miss.
///
/// -> content
#let list-of(
    /// Figure kind to list --- an element function such as `image`, or a string such
    /// as `"algorithm"`.
    /// -> function | str
    kind,

    /// Heading of the list page.
    /// -> content | str
    title,
) = {
    set text(hyphenate: true)
    heading(level: 1, numbering: none, outlined: true, bookmarked: true)[#title]
    in-outline.update(true)
    outline(
        title: none,
        target: figure.where(kind: kind),
    )
    in-outline.update(false)
}

// The `auto` title is resolved inside a `context` that wraps the whole call, so
// it lands in the heading as a plain string. Resolving it lazily (a bare
// `context` expression passed as the title) would re-resolve against `text.lang`
// wherever the outlined heading is rendered — the list page and, differently, its
// entry in a table of contents that a stray `set text(lang: …)` had switched.

/// Print the list of figures.
///
/// -> content
#let list-of-figures(
    /// Heading of the list page. `auto` uses the localized default for the document
    /// language.
    /// -> content | str | auto
    title: auto,
) = context list-of(
    image,
    if title == auto { t.at(text.lang).list-of-figures } else { title },
)

/// Print the list of tables.
///
/// -> content
#let list-of-tables(
    /// Heading of the list page. `auto` uses the localized default for the document
    /// language.
    /// -> content | str | auto
    title: auto,
) = context list-of(
    table,
    if title == auto { t.at(text.lang).list-of-tables } else { title },
)

/// Print the list of listings.
///
/// -> content
#let list-of-listings(
    /// Heading of the list page. `auto` uses the localized default for the document
    /// language.
    /// -> content | str | auto
    title: auto,
) = context list-of(
    raw,
    if title == auto { t.at(text.lang).list-of-listings } else { title },
)
