// thesis.typ — KIT thesis template
//
// Public API (re-exported via lib.typ):
//   thesis(...)

#import "page-setup.typ": (
    setup-appendix, setup-back-matter, setup-content, setup-front-matter, setup-page,
)
#import "outlines.typ": table-of-contents
#import "page-conf.typ": title-page-margins-by-format
#import "title-page.typ": doctoral-title-page


/// The official Typst template[1] for doctoral theses published through KIT Scientific Publishing (KSP).
///
/// - format ("a5" | "17x24" | "a4"): Paper format — `"a5"` (148×210 mm, default),
///   `"17x24"` (170×240 mm), or `"a4"` (210×297 mm, discouraged by KSP). Font sizes and
///   margins are set automatically.
/// - lang ("de" | "en"): Document language.
/// - author-firstname (str): Author's first name.
/// - author-surname (str): Author's surname.
/// - title (content): Thesis title.
/// - title-page (content | function | none): Title page. Defaults to the built-in doctoral
///   page; pass `doctoral-title-page.with(..)` to configure it, your own content, a function
///   called as `(title, author-firstname:, author-surname:, format:, lang:)`, or `none`
///   to omit it.
/// - front-matter (content | none): Roman-numeral pages before the body — abstracts,
///   acknowledgements, the table of contents, any page of your own. Defaults to just
///   `outlines.table-of-contents()`. Pass `none` for no front matter.
/// - appendix (content | none): Appendix chapters. Template applies `A`, `A.1`, … numbering
///   and places the appendix directly after the body, before the back matter. `none` = omit.
/// - back-matter (content | none): Pages after the appendix — list pages, bibliography,
///   own publications, whatever the document needs, in the order written. `none` = omit.
///   Refer to `outlines` for list-page helpers.
/// - serif-headings (bool): Use serif font for headings when `true`. Default `false` (sans-serif).
/// - heading-numbering-depth (int): Deepest heading level to number. Default `3`.
/// - figure-kinds (array): Figure kinds beyond `image`, `table` and `raw`, as dictionaries
///   with `kind` and `supplement`. `supplement` takes either one value or one per language,
///   e.g. `(de: [Algorithmus], en: [Algorithm])`. Declaring a built-in kind is an error.
/// - margin-preset ("short" | "medium" | "long"): Margin profile keyed on page count.
/// - binding-correction (length): BCOR added to inside margin. Default `0mm`.
/// - colored-links (bool): KIT Blue links when `true`, black when `false`.
/// - draft (bool): Show "ENTWURF" watermark when `true`.
/// - draft-info (str | none): Optional version string below watermark. Default `none`.
/// - doc (content): Main document body (chapters only).
/// -> content
#let thesis(
    format: "a5",
    lang: "de",
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Your Thesis Title],
    title-page: doctoral-title-page,
    front-matter: table-of-contents(),
    appendix: none,
    back-matter: none,
    serif-headings: false,
    heading-numbering-depth: 3,
    figure-kinds: (),
    margin-preset: "short",
    binding-correction: 0mm,
    colored-links: true,
    draft: false,
    draft-info: none,
    doc,
) = {
    assert(
        format in ("a5", "17x24", "a4"),
        message: "format must be \"a5\", \"17x24\" (170×240 mm), or \"a4\"",
    )
    let author-name = author-firstname + " " + author-surname

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

    // Each section is `show: setup-*` then the content. The content defaults to
    // empty and is a no-op when absent; every `setup-*` is either overridden by
    // the next one or invisible with no content to style, so none need guarding.

    // ── Front matter (Roman numerals) ───────────────────────────────────────
    show: setup-front-matter
    front-matter

    // ── Main content (Arabic numerals) ─────────────────────────────────────
    show: setup-content
    doc

    // ── Appendix (A, A.1, … numbering) ────────────────────────────────────
    show: setup-appendix
    appendix

    // ── Back matter (unnumbered headings) ────────────────────────────────
    show: setup-back-matter
    back-matter
}
