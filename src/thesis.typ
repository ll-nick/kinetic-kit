// thesis.typ — KIT Master's / Bachelor's / Diploma thesis template
//
// Public API (re-exported via lib.typ):
//   thesis(...) — Master's / Bachelor's / Diploma thesis

#import "page-setup.typ": setup-appendix, setup-content, setup-front-matter, setup-page
#import "translations.typ": t
#import "title-page.typ": print-thesis-title
#import "front-matter.typ": (
    print-abbreviations, print-abstract, print-acknowledgements, print-kurzfassung,
)
#import "back-matter.typ": print-bibliography
#import "content-page.typ": print-lof, print-lol, print-lot, print-toc


/// KIT Master's / Bachelor's / Diploma thesis template.
///
/// - author-firstname (str): Author's first name.
/// - author-surname (str): Author's surname.
/// - title (content): Thesis title.
/// - thesis-type (str): e.g. `"Masterarbeit"`, `"Bachelorarbeit"`.
/// - department (str): Faculty / department name.
/// - university-genitive (str): University name in genitive case.
/// - examiner (content): First examiner. `none` if unknown.
/// - supervisor (content): Supervisor. `none` if unknown.
/// - date-submitted (content): Submission date string. `none` if unknown.
/// - lang (str): Document language (`"de"` or `"en"`).
/// - margin-preset (str): `"short"`, `"medium"`, or `"long"`.
/// - binding-correction (length): BCOR added to inside margin. Default `0mm`.
/// - colored-links (bool): KIT Blue links when `true`, black when `false`.
/// - draft (bool): Show "ENTWURF" watermark when `true`.
/// - draft-info (str): Optional version string below watermark. Default `none`.
/// - abstract-en (content): English abstract. `none` = omit.
/// - abstract-de (content): German abstract. `none` = omit.
/// - acknowledgements (content): Acknowledgements. `none` = omit.
/// - abbreviations (content): Abbreviations list. `none` = omit.
/// - show-lof (bool): Include List of Figures.
/// - show-lot (bool): Include List of Tables.
/// - show-lol (bool): Include List of Listings.
/// - bibliography (content): Bibliography content. Pass `bibliography("refs.bib", title: none, style: "ieee")`.
///   The template adds a translated heading. `none` = omit.
/// - appendix (content): Appendix chapters. Template applies `A`, `A.1`, … numbering
///   and places the appendix at the very end, after all back-matter lists. `none` = omit.
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
    lang: "de",
    margin-preset: "short",
    binding-correction: 0mm,
    colored-links: true,
    draft: false,
    draft-info: none,
    abstract-en: none,
    abstract-de: none,
    acknowledgements: none,
    abbreviations: none,
    show-lof: true,
    show-lot: true,
    show-lol: false,
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

    // ── Global page/text/heading setup -─────────────────────────────────────
    show: setup-page.with(
        margin-preset: margin-preset,
        lang: lang,
        binding-correction: binding-correction,
        colored-links: colored-links,
        draft: draft,
        draft-info: draft-info,
    )

    // ── Title page ──────────────────────────────────────────────────────────
    print-thesis-title(
        title,
        thesis-type,
        author-firstname,
        author-surname,
        department,
        university-genitive,
        examiner,
        supervisor,
        date-submitted,
        lang,
    )

    // ── Front matter (Roman numerals) ───────────────────────────────────────
    show: setup-front-matter
    counter(page).update(0)

    if abstract-en != none {
        print-abstract(abstract-en)
    }
    if abstract-de != none {
        print-kurzfassung(abstract-de)
    }

    if acknowledgements != none {
        print-acknowledgements(acknowledgements, lang)
    }

    if abbreviations != none {
        print-abbreviations(abbreviations, lang)
    }

    print-toc(lang: lang)

    // ── Main content (Arabic numerals) ──────────────────────────────────────
    show: setup-content
    counter(page).update(1)

    doc

    if bibliography != none { print-bibliography(bibliography, lang) }

    // ── Back matter ─────────────────────────────────────────────────────────
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
        show: setup-appendix
        appendix
    }
}
