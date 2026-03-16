// dissertation.typ — KIT doctoral dissertation template
//
// Public API (re-exported via lib.typ):
//   dissertation(...) — doctoral dissertation

#import "page-setup.typ": (
    _page-appendix, _page-base, _page-content, _page-front-matter,
)
#import "translations.typ": t
#import "title-page.typ": print-dissertation-title
#import "front-matter.typ": (
    print-abbreviations, print-abstract, print-acknowledgements, print-cv,
    print-kurzfassung, print-notation,
)
#import "back-matter.typ": (
    print-bibliography, print-own-patents, print-own-publications,
    print-supervised-theses,
)
#import "content-page.typ": print-lof, print-lol, print-lot, print-toc


/// KIT doctoral dissertation template.
///
/// - author-title (str): Academic title preceding the author's name (e.g. `"M.Sc."`).
/// - author-firstname (str): Author's first name.
/// - author-surname (str): Author's surname.
/// - author-male (bool): `true` for male, `false` for female grammatical forms.
/// - place-of-birth (str): Author's place of birth. `none` = omit.
/// - title (content): Dissertation title.
/// - doc-degree (str): Degree name in masculine form.
/// - doc-degree-f (str): Degree name in feminine form.
/// - department (str): Faculty / department name.
/// - university-genitive (str): University name in genitive case.
/// - status-approved (bool): `false` = submitted, `true` = approved.
/// - exam-date (content): Date of oral examination (when approved).
/// - main-advisor (content): Main referee (when approved).
/// - main-advisor-male (bool): Grammatical gender for main advisor label.
/// - co-advisor (content): Co-referee (when approved).
/// - co-advisor-male (bool): Grammatical gender for co-advisor label.
/// - lang (str): Document language (`"de"` or `"en"`).
/// - margin-preset (str): `"short"`, `"medium"`, or `"long"`.
/// - binding-correction (length): BCOR added to inside margin. Default `0mm`.
/// - colored-links (bool): KIT Blue links when `true`, black when `false`.
/// - draft (bool): Show "ENTWURF" watermark when `true`.
/// - draft-info (str): Optional version string below watermark. Default `none`.
/// - cv-name (str): Name for CV section heading. `none` = omit CV.
/// - cv-entries (array): List of `(year, description)` pairs for the CV.
/// - abstract-en (content): English abstract. `none` = omit.
/// - abstract-de (content): German abstract. `none` = omit.
/// - acknowledgements (content): Acknowledgements. `none` = omit.
/// - notation (content): Notation list. `none` = omit.
/// - abbreviations (content): Abbreviations list. `none` = omit.
/// - show-lof (bool): Include List of Figures.
/// - show-lot (bool): Include List of Tables.
/// - show-lol (bool): Include List of Listings.
/// - own-publications (content): Own publications content (heading added by template). `none` = omit.
/// - own-patents (content): Own patents content (heading added by template). `none` = omit.
/// - supervised-theses (content): Supervised theses content (heading added by template). `none` = omit.
/// - bibliography (content): Bibliography content. Pass `bibliography("refs.bib", title: none, style: "ieee")`.
///   The template adds a translated heading. `none` = omit.
/// - appendix (content): Appendix chapters. Template applies `A`, `A.1`, … numbering
///   and places the appendix at the very end, after all back-matter lists. `none` = omit.
/// - doc (content): Main document body (chapters only).
/// -> content
#let dissertation(
    author-title: "M.Sc.",
    author-firstname: "Max",
    author-surname: "Mustermann",
    author-male: true,
    place-of-birth: none,
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
    lang: "de",
    margin-preset: "short",
    binding-correction: 0mm,
    colored-links: true,
    draft: false,
    draft-info: none,
    cv-name: none,
    cv-entries: (),
    abstract-en: none,
    abstract-de: none,
    acknowledgements: none,
    notation: none,
    abbreviations: none,
    show-lof: true,
    show-lot: true,
    show-lol: false,
    own-publications: none,
    own-patents: none,
    supervised-theses: none,
    bibliography: none,
    appendix: none,
    doc,
) = {
    let author-name = author-firstname + " " + author-surname

    set document(
        title: title,
        author: author-name,
        date: datetime.today(),
    )

    // ── Title page ──────────────────────────────────────────────────────────
    print-dissertation-title(
        title,
        author-title,
        author-firstname,
        author-surname,
        author-male,
        place-of-birth,
        doc-degree,
        doc-degree-f,
        department,
        university-genitive,
        status-approved,
        exam-date,
        main-advisor,
        main-advisor-male,
        co-advisor,
        co-advisor-male,
    )


    // ── Global page/text/heading setup -─────────────────────────────────────
    show: _page-base.with(
        margin-preset: margin-preset,
        lang: lang,
        binding-correction: binding-correction,
        colored-links: colored-links,
        draft: draft,
        draft-info: draft-info,
    )

    // ── Front matter (Roman numerals) ───────────────────────────────────────
    show: _page-front-matter
    counter(page).update(0)

    if cv-name != none {
        print-cv(cv-name, cv-entries, lang)
    }

    if abstract-en != none {
        print-abstract(abstract-en)
    }
    if abstract-de != none {
        print-kurzfassung(abstract-de)
    }

    if acknowledgements != none {
        print-acknowledgements(acknowledgements, lang)
    }

    if notation != none {
        print-notation(notation, lang)
    }

    if abbreviations != none {
        print-abbreviations(abbreviations, lang)
    }

    print-toc(lang: lang)

    // ── Main content (Arabic numerals) ──────────────────────────────────────
    show: _page-content
    counter(page).update(1)

    doc

    if bibliography != none {
        print-bibliography(bibliography, lang)
    }

    // ── Back matter ─────────────────────────────────────────────────────────
    if own-publications != none {
        print-own-publications(own-publications, lang)
    }
    if own-patents != none {
        print-own-patents(own-patents, lang)
    }
    if supervised-theses != none {
        print-supervised-theses(supervised-theses, lang)
    }

    if show-lof {
        print-lof(lang: lang)
    }
    if show-lot {
        print-lot(lang: lang)
    }
    if show-lol {
        print-lol(lang: lang)
    }

    if appendix != none {
        show: _page-appendix
        appendix
    }
}
