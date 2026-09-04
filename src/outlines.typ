// Outline styling and the short-caption helper.
//
// `setup-outlines` teaches Typst's own `outline` what it is missing
// --- an outlined, bookmarked, localized heading on a list page ---
// so a document places its table of contents and its list pages with the built-in call.

#import "translations.typ": t

// Whether we're rendering inside an outline; lets captions switch to short form.
#let in-outline = state("in-outline", false)

// Typst's `auto` outline title is the *contents* title whatever the outline
// targets, so a list page has to be named. Selector equality identifies the three
// kinds the template carries strings for; any other kind belongs to the document's
// own vocabulary and names itself.
#let _list-page-titles = (
    (selector(figure.where(kind: image)), "list-of-figures"),
    (selector(figure.where(kind: table)), "list-of-tables"),
    (selector(figure.where(kind: raw)), "list-of-listings"),
)

// The heading a list page gets in place of the title Typst would print itself.
#let _list-page-heading(target, title) = context {
    let resolved = if title != auto { title } else {
        let named = _list-page-titles.find(entry => entry.at(0) == target)
        if named == none {
            panic(
                "an outline of "
                    + repr(target)
                    + " needs a title of its own --- the template only names outlines "
                    + "of image, table and raw",
            )
        }
        t.at(text.lang).at(named.at(1))
    }
    heading(level: 1, numbering: none, outlined: true, bookmarked: true)[#resolved]
}

/// Shared outline styling, applied as a show rule so every outline in the
/// document --- including a user's own --- matches.
///
/// -> content
#let setup-outlines(
    /// Document body, injected by the show rule.
    /// -> content
    body,
) = {
    set outline(depth: 3)
    set outline.entry(fill: repeat(".", gap: 0.4em, justify: false))
    show outline: set par(justify: false)

    // Give non-toc listings a custom, localized heading.
    show outline: it => {
        if it.title == none or it.target == selector(heading) {
            it
        } else {
            _list-page-heading(it.target, it.title)
            outline(..it.fields(), title: none)
        }
    }

    show outline.entry: it => context {
        let is-heading-entry = it.element.func() == heading
        let is-chapter = is-heading-entry and it.level == 1
        set block(above: 1.6em) if is-chapter
        set text(hyphenate: true) if not is-heading-entry

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
        let bold = if is-chapter {
            it => if it == none { none } else { strong(it) }
        } else {
            it => it
        }
        // Bracket the entry so @flex-caption renders its short form here.
        in-outline.update(true)
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
        in-outline.update(false)
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

/// Two-part caption: a short version for the list pages, a long one under the
/// figure.
///
/// ```typc
/// figure(image("plot.svg"), caption: outlines.flex-caption(short: [Short], long: [Long.]))
/// ```
///
/// -> content
#let flex-caption(
    /// Caption shown on the list page.
    /// -> content
    short: none,

    /// Caption shown below the figure in the document body.
    /// -> content
    long: none,
) = context if in-outline.get() {
    short
} else {
    long
}
