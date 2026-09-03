// thesis.typ — KIT Master's / Bachelor's / Diploma thesis template
//
// Public API (re-exported via lib.typ):
//   thesis(...) — Master's / Bachelor's / Diploma thesis

#import "document.typ": _document
#import "title-page.typ": print-thesis-title


/// KIT Master's / Bachelor's / Diploma thesis template.
///
/// - author-firstname (str): Author's first name.
/// - author-surname (str): Author's surname.
/// - title (content): Thesis title.
/// - thesis-type (str): e.g. `"Masterarbeit"`, `"Bachelorarbeit"`.
/// - department (str): Faculty / department name.
/// - university-genitive (str): University name in genitive case.
/// - examiner (str | none): First examiner. `none` if unknown.
/// - supervisor (str | none): Supervisor. `none` if unknown.
/// - date-submitted (str | none): Submission date string. `none` if unknown.
/// - format ("a5" | "17x24" | "a4"): Paper format — `"a5"` (148×210 mm, default),
///   `"17x24"` (170×240 mm), or `"a4"` (210×297 mm). Font sizes and margins are set automatically.
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
/// - bibliography (content | none): Bibliography content. Pass `bibliography("refs.bib", title: none, style: "ieee")`.
///   The template adds a translated heading. `none` = omit.
/// - appendix (content | none): Appendix chapters. Template applies `A`, `A.1`, … numbering
///   and places the appendix before the back-matter lists. `none` = omit.
/// - doc (content): Main document body (chapters only).
/// -> content
#let thesis(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Your Thesis Title],
    thesis-type: "Masterarbeit",
    department: "KIT-Fakultät für Maschinenbau",
    university-genitive: "des Karlsruher Instituts für Technologie (KIT)",
    examiner: none,
    supervisor: none,
    date-submitted: none,
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
    abbreviations: none,
    show-list-of-figures: true,
    show-list-of-tables: true,
    show-list-of-listings: false,
    figure-kinds: (),
    bibliography: none,
    appendix: none,
    doc,
) = _document(
    title-page: print-thesis-title(
        title,
        thesis-type: thesis-type,
        author-firstname: author-firstname,
        author-surname: author-surname,
        department: department,
        university-genitive: university-genitive,
        examiner: examiner,
        supervisor: supervisor,
        date-submitted: date-submitted,
        format: format,
    ),
    title: title,
    author-firstname: author-firstname,
    author-surname: author-surname,
    format: format,
    lang: lang,
    margin-preset: margin-preset,
    binding-correction: binding-correction,
    colored-links: colored-links,
    draft: draft,
    draft-info: draft-info,
    serif-headings: serif-headings,
    heading-numbering-depth: heading-numbering-depth,
    abstract-en: abstract-en,
    abstract-de: abstract-de,
    acknowledgements: acknowledgements,
    abbreviations: abbreviations,
    show-list-of-figures: show-list-of-figures,
    show-list-of-tables: show-list-of-tables,
    show-list-of-listings: show-list-of-listings,
    figure-kinds: figure-kinds,
    bibliography: bibliography,
    appendix: appendix,
    doc,
)
