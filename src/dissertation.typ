// dissertation.typ — KIT doctoral dissertation template
//
// Public API (re-exported via lib.typ):
//   dissertation(...) — doctoral dissertation

#import "document.typ": _document
#import "title-page.typ": print-dissertation-title


/// KIT doctoral dissertation template.
///
/// - author-title (str | none): Academic title preceding the author's name (e.g. `"M.Sc."`).
/// - author-firstname (str): Author's first name.
/// - author-surname (str): Author's surname.
/// - author-male (bool): `true` for male, `false` for female grammatical forms.
/// - title (content): Dissertation title.
/// - doc-degree (str): Degree name in masculine form.
/// - doc-degree-f (str): Degree name in feminine form.
/// - department (str): Faculty / department name.
/// - university-genitive (str): University name in genitive case.
/// - status-approved (bool): `false` = submitted, `true` = approved.
/// - exam-date (str | none): Date of oral examination (when approved).
/// - main-advisor (str | none): Main referee (when approved).
/// - main-advisor-male (bool): Grammatical gender for main advisor label.
/// - co-advisor (str | none): Co-referee (when approved).
/// - co-advisor-male (bool): Grammatical gender for co-advisor label.
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
/// - supervised-theses (content | none): Supervised theses content (heading added by template). `none` = omit.
/// - bibliography (content | none): Bibliography content. Pass `bibliography("refs.bib", title: none, style: "ieee")`.
///   The template adds a translated heading. `none` = omit.
/// - appendix (content | none): Appendix chapters. Template applies `A`, `A.1`, … numbering
///   and places the appendix before the back-matter lists. `none` = omit.
/// - doc (content): Main document body (chapters only).
/// -> content
#let dissertation(
    author-title: "M.Sc.",
    author-firstname: "Max",
    author-surname: "Mustermann",
    author-male: true,
    title: [Your Thesis Title],
    doc-degree: "Doktors der Ingenieurwissenschaften (Dr.-Ing.)",
    doc-degree-f: "Doktorin der Ingenieurwissenschaften (Dr.-Ing.)",
    department: "KIT-Fakultät für Maschinenbau",
    university-genitive: "des Karlsruher Instituts für Technologie (KIT)",
    status-approved: false,
    exam-date: none,
    main-advisor: none,
    main-advisor-male: true,
    co-advisor: none,
    co-advisor-male: true,
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
    doc,
) = _document(
    title-page: print-dissertation-title(
        title,
        author-title: author-title,
        author-firstname: author-firstname,
        author-surname: author-surname,
        author-male: author-male,
        doc-degree: doc-degree,
        doc-degree-f: doc-degree-f,
        department: department,
        university-genitive: university-genitive,
        status-approved: status-approved,
        exam-date: exam-date,
        main-advisor: main-advisor,
        main-advisor-male: main-advisor-male,
        co-advisor: co-advisor,
        co-advisor-male: co-advisor-male,
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
    notation: notation,
    abbreviations: abbreviations,
    show-list-of-figures: show-list-of-figures,
    show-list-of-tables: show-list-of-tables,
    show-list-of-listings: show-list-of-listings,
    figure-kinds: figure-kinds,
    own-publications: own-publications,
    own-patents: own-patents,
    supervised-theses: supervised-theses,
    bibliography: bibliography,
    appendix: appendix,
    doc,
)
