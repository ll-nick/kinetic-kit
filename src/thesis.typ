// thesis.typ — KIT thesis template
//
// Public API (re-exported via lib.typ):
//   thesis(...)

#import "page-setup.typ": setup-appendix, setup-content, setup-front-matter, setup-page
#import "front-matter.typ": (
    print-abbreviations, print-abstract, print-acknowledgements, print-kurzfassung,
    print-notation,
)
#import "back-matter.typ": (
    print-bibliography, print-own-patents, print-own-publications,
    print-supervised-theses,
)
#import "outlines.typ": list-of, table-of-contents
#import "figure-kinds.typ": resolve-figure-kinds, resolve-localized
#import "page-conf.typ": title-page-margins-by-format
#import "title-page.typ": doctoral-title-page


/// KIT thesis template — doctoral, Master's, Bachelor's and Diploma theses.
///
/// The document type is decided by the title page. `title-page` defaults to the
/// KSP-approved doctoral page; pass your own for anything else.
///
/// - author-firstname (str): Author's first name.
/// - author-surname (str): Author's surname.
/// - title (content): Thesis title.
/// - format ("a5" | "17x24" | "a4"): Paper format — `"a5"` (148×210 mm, default),
///   `"17x24"` (170×240 mm), or `"a4"` (210×297 mm, discouraged by KSP). Font sizes and
///   margins are set automatically.
/// - lang ("de" | "en"): Document language.
/// - margin-preset ("short" | "medium" | "long"): Margin profile keyed on page count.
/// - binding-correction (length): BCOR added to inside margin. Default `0mm`.
/// - colored-links (bool): KIT Blue links when `true`, black when `false`.
/// - draft (bool): Show "ENTWURF" watermark when `true`.
/// - draft-info (str | none): Optional version string below watermark. Default `none`.
/// - serif-headings (bool): Use serif font for headings when `true`. Default `false` (sans-serif).
/// - heading-numbering-depth (int): Deepest heading level to number. Default `3`.
/// - abstract-en (content | none): English abstract. `none` = omit.
/// - abstract-de (content | none): German abstract. `none` = omit.
/// - acknowledgements (content | none): Acknowledgements. `none` = omit.
/// - notation (content | none): Notation list. `none` = omit.
/// - abbreviations (content | none): Abbreviations list. `none` = omit.
/// - show-list-of-figures (bool): Include List of Figures.
/// - show-list-of-tables (bool): Include List of Tables.
/// - show-list-of-listings (bool): Include List of Listings.
/// - figure-kinds (array): Figure kinds beyond `image`, `table` and `raw`, as dictionaries
///   with `kind`, `supplement`, and optionally `list-title` and `show-list`. `supplement`
///   and `list-title` take either one value or one per language, e.g.
///   `(de: [Algorithmus], en: [Algorithm])`. The built-in kinds are not declared here —
///   their list pages are governed by `show-list-of-figures` / `show-list-of-tables` / `show-list-of-listings`. Declared
///   kinds get a list page after the built-in ones, in declaration order.
/// - own-publications (content | none): Own publications content (heading added by template). `none` = omit.
/// - own-patents (content | none): Own patents content (heading added by template). `none` = omit.
/// - supervised-theses (content | none): Supervised theses content (heading added by template).
///   `none` = omit.
/// - bibliography (content | none): Bibliography content. Pass `bibliography("refs.bib", title: none, style: "ieee")`.
///   The template adds a translated heading. `none` = omit.
/// - appendix (content | none): Appendix chapters. Template applies `A`, `A.1`, … numbering
///   and places the appendix before the back-matter lists. `none` = omit.
/// - title-page (content | function | none): Title page. Defaults to the doctoral
///   page; pass `doctoral-title-page.with(..)` to configure it, your own content, a function
///   called as `(title, author-firstname:, author-surname:, format:, lang:)`, or `none`
///   to omit it.
/// - doc (content): Main document body (chapters only).
/// -> content
#let thesis(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Your Thesis Title],
    format: "a5",
    lang: "de",
    margin-preset: "short",
    binding-correction: 0mm,
    colored-links: true,
    draft: false,
    draft-info: none,
    serif-headings: false,
    heading-numbering-depth: 3,
    abstract-en: none,
    abstract-de: none,
    acknowledgements: none,
    notation: none,
    abbreviations: none,
    show-list-of-figures: true,
    show-list-of-tables: true,
    show-list-of-listings: false,
    figure-kinds: (),
    own-publications: none,
    own-patents: none,
    supervised-theses: none,
    bibliography: none,
    appendix: none,
    title-page: doctoral-title-page,
    doc,
) = {
    assert(
        format in ("a5", "17x24", "a4"),
        message: "format must be \"a5\", \"17x24\" (170×240 mm), or \"a4\"",
    )
    let author-name = author-firstname + " " + author-surname
    let resolved-figure-kinds = resolve-figure-kinds(
        figure-kinds,
        show-list-of-figures: show-list-of-figures,
        show-list-of-tables: show-list-of-tables,
        show-list-of-listings: show-list-of-listings,
    )

    set document(
        title: title,
        author: author-name,
        date: datetime.today(),
    )

    // ── Global page/text/heading setup -─────────────────────────────────────
    show: setup-page.with(
        format: format,
        margin-preset: margin-preset,
        lang: lang,
        binding-correction: binding-correction,
        colored-links: colored-links,
        draft: draft,
        draft-info: draft-info,
        serif-headings: serif-headings,
        heading-numbering-depth: heading-numbering-depth,
        figure-kinds: figure-kinds,
    )

    // ── Title page ──────────────────────────────────────────────────────────
    // Scoped so the setup reverts before the front matter. Applied here rather than
    // left to the caller so a custom title page gets the right geometry and no page
    // number without reaching for internal constants.
    {
        set page(
            margin: title-page-margins-by-format.at(format),
            binding: left,
            header: none,
            footer: none,
            numbering: none,
        )
        if type(title-page) == function {
            title-page(
                title,
                author-firstname: author-firstname,
                author-surname: author-surname,
                format: format,
                lang: lang,
            )
        } else if title-page != none {
            title-page
        }
    }

    // ── Front matter (Roman numerals) ───────────────────────────────────────
    show: setup-front-matter
    counter(page).update(0)

    if acknowledgements != none {
        print-acknowledgements(acknowledgements, lang)
    }

    if abstract-en != none {
        print-abstract(abstract-en)
    }
    if abstract-de != none {
        print-kurzfassung(abstract-de)
    }

    if notation != none {
        print-notation(notation, lang)
    }

    if abbreviations != none {
        print-abbreviations(abbreviations, lang)
    }

    table-of-contents(lang: lang)

    // ── Main content (Arabic numerals) ──────────────────────────────────────
    show: setup-content
    counter(page).update(1)

    doc

    // ── Back matter ─────────────────────────────────────────────────────────
    if appendix != none {
        show: setup-appendix
        appendix
    }

    // Titles resolve against the document language rather than `text.lang`: a list
    // page is one back-matter section, unlike a supplement that follows its figure.
    for entry in resolved-figure-kinds {
        if entry.show-list {
            list-of(
                entry.kind,
                title: resolve-localized(
                    entry.list-title,
                    lang,
                    kind: entry.kind,
                    field: "list-title",
                ),
            )
        }
    }

    if bibliography != none {
        print-bibliography(bibliography, lang)
    }

    if own-publications != none {
        print-own-publications(own-publications, lang)
    }
    if own-patents != none {
        print-own-patents(own-patents, lang)
    }
    if supervised-theses != none {
        print-supervised-theses(supervised-theses, lang)
    }
}
