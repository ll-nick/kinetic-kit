// kit-thesis.typ — KIT dissertation and thesis templates
//
// Public API (re-exported via lib.typ):
//   dissertation(...)  — doctoral dissertation
//   thesis(...)        — Master's / Bachelor's / Diploma thesis

#import "kit-colors.typ": kit-colors
#import "kit-fonts.typ": font-sizes, fonts, line-spacing
#import "page-conf.typ": (
    kit-header, kit-page, margins-by-length, par-spacing, title-page-margins,
)
#import "translations.typ": t
#import "title-page.typ": print-dissertation-title, print-thesis-title
#import "front-matter.typ": (
    print-abbreviations, print-abstract, print-acknowledgements,
    print-bibliography, print-cv, print-kurzfassung, print-notation,
    print-own-patents, print-own-publications, print-supervised-theses,
)
#import "content-page.typ": print-lof, print-lol, print-lot, print-toc
#import "@preview/glossarium:0.5.10": (
    make-glossary, print-glossary, register-glossary,
)


// ── Draft indicator ───────────────────────────────────────────────────────

#let _draft-indicator(lang, draft-info, bottom-margin) = place(
    bottom + center,
    dy: -(bottom-margin / 4),
    box(
        inset: (x: 6pt, y: 4pt),
        text(font: fonts.sans, size: font-sizes.small)[
            #t.at(lang).draft#if draft-info != none [ · #draft-info]
        ],
    ),
)

// ── Base page setup ───────────────────────────────────────────────────────

#let _page-base(
    margin-preset: "short",
    lang: "de",
    binding-correction: 0mm,
    colored-links: true,
    draft: false,
    draft-info: none,
    doc,
) = {
    let base-margins = margins-by-length.at(margin-preset)
    let margins = (
        top: base-margins.top,
        bottom: base-margins.bottom,
        inside: base-margins.inside + binding-correction,
        outside: base-margins.outside,
    )

    set page(
        paper: kit-page.type,
        margin: margins,
        binding: left,
        header: kit-header,
        foreground: if draft {
            _draft-indicator(lang, draft-info, base-margins.bottom)
        } else {
            none
        },
        footer: context {
            // Suppress before the very first chapter
            if (
                query(selector(heading.where(level: 1)).before(here())).len()
                    == 0
            ) {
                return
            }
            set text(font: fonts.sans, size: font-sizes.small)
            if calc.odd(here().page()) {
                align(right, counter(page).display())
            } else {
                align(left, counter(page).display())
            }
        },
    )

    set text(font: fonts.serif, size: font-sizes.base, lang: lang)
    set par(
        justify: true,
        first-line-indent: 0pt,
        leading: line-spacing,
        spacing: par-spacing,
    )

    // ── Colored links ─────────────────────────────────────────────────────
    show link: it => {
        if colored-links and type(it.dest) == str {
            text(fill: kit-colors.blue)[#it]
        } else {
            it
        }
    }

    // ── Headings ─────────────────────────────────────────────────────────
    show heading.where(level: 1): it => {
        counter(math.equation).update(0)
        counter(figure.where(kind: image)).update(0)
        counter(figure.where(kind: table)).update(0)
        counter(figure.where(kind: raw)).update(0)
        {
            set page(header: none, footer: none)
            pagebreak(weak: true, to: "odd")
        }
        v(4em)
        block[
            #set text(
                font: fonts.sans,
                size: font-sizes.chapter,
                weight: "bold",
            )
            #it
        ]
        v(1em)
    }

    show heading.where(level: 2): it => {
        v(0.8em)
        block[
            #set text(
                font: fonts.sans,
                size: font-sizes.section,
                weight: "bold",
            )
            #it
        ]
        v(0.4em)
    }

    show heading.where(level: 3): it => {
        v(0.5em)
        block[
            #set text(
                font: fonts.sans,
                size: font-sizes.subsection,
                weight: "bold",
            )
            #it
        ]
        v(0.3em)
    }

    show heading.where(level: 4): it => {
        v(0.3em)
        block[
            #set text(
                font: fonts.sans,
                size: font-sizes.subsubsection,
                weight: "bold",
            )
            #it.body
        ]
        v(0.2em)
    }

    // ── Figures ──────────────────────────────────────────────────────────
    show figure.caption: it => [
        #set text(size: font-sizes.small)
        #text(weight: "bold")[#it.supplement #context it.counter.display(
                it.numbering,
            ):]
        #it.body
    ]

    set figure(numbering: it => {
        let ch = counter(heading.where(level: 1)).at(here()).first()
        if ch > 0 { numbering("1.1", ch, it) } else { numbering("1", it) }
    })

    set figure(gap: 0.8em)

    // ── Equations ────────────────────────────────────────────────────────
    set math.equation(numbering: it => {
        let ch = counter(heading.where(level: 1)).at(here()).first()
        if ch > 0 { numbering("(1.1)", ch, it) } else { numbering("(1)", it) }
    })

    // ── Code listings ─────────────────────────────────────────────────────
    show raw.where(block: true): it => {
        set text(font: fonts.mono, size: font-sizes.small)
        block(
            width: 100%,
            fill: luma(245),
            inset: (x: 1em, y: 0.8em),
            radius: 2pt,
            it,
        )
    }

    doc
}

// ── Section-specific page setup (thin wrappers) ───────────────────────────

#let _page-front-matter(doc) = {
    set page(numbering: "i")
    set heading(numbering: none)
    doc
}

#let _page-content(doc) = {
    set page(numbering: "1")
    set heading(numbering: "1.1")
    doc
}

#let _page-appendix(doc) = {
    set heading(numbering: "A.1")
    counter(heading).update(0)
    doc
}

// ── Dissertation Template ─────────────────────────────────────────────────

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
/// - glossary-entries (array): Glossarium entries for auto-expansion. `none` = use manual abbreviations.
/// - show-lof (bool): Include List of Figures.
/// - show-lot (bool): Include List of Tables.
/// - show-lol (bool): Include List of Listings.
/// - own-publications (content): Own publications content (heading added by template). `none` = omit.
/// - own-patents (content): Own patents content (heading added by template). `none` = omit.
/// - supervised-theses (content): Supervised theses content (heading added by template). `none` = omit.
/// - bibliography (content): Bibliography content. Pass `bibliography("refs.bib", title: none, style: "ieee")`.
///   The template adds a translated heading. `none` = omit.
/// - appendix-content (content): Appendix chapters. Template applies `A`, `A.1`, … numbering
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
    glossary-entries: none,
    show-lof: true,
    show-lot: true,
    show-lol: false,
    own-publications: none,
    own-patents: none,
    supervised-theses: none,
    bibliography: none,
    appendix-content: none,
    doc,
) = {
    // Apply glossarium show-rule at the outer scope so it covers the entire
    // dissertation body (front matter, main chapters, back matter). A show:
    // inside an if-block would be scoped only to that block; make-glossary
    // would not be active when print-glossary later renders its figures,
    // causing every entry caption to remain empty.
    // The two show rules in make-glossary are harmless when glossary-entries
    // is none — they never fire if no glossarium figures or refs are present.
    show: make-glossary
    if glossary-entries != none {
        register-glossary(glossary-entries)
    }

    let author-name = author-firstname + " " + author-surname

    set document(
        title: title,
        author: author-name,
        date: datetime.today(),
    )

    let tr = t.at(lang)
    set figure(
        supplement: it => if it.func() == table { tr.table } else { tr.figure },
    )
    show figure.where(kind: raw): set figure(supplement: context t
        .at(text.lang)
        .listing)

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

    if glossary-entries != none {
        heading(level: 1, numbering: none, outlined: true)[#(
            t.at(lang).abbreviations
        )]
        print-glossary(glossary-entries)
    } else if abbreviations != none {
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

    // Appendix goes last so it follows all back-matter lists.
    if appendix-content != none {
        show: _page-appendix
        appendix-content
    }
}

// ── Thesis Template ───────────────────────────────────────────────────────

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
/// - abstract-en (content): English abstract. `none` = omit.
/// - abstract-de (content): German abstract. `none` = omit.
/// - acknowledgements (content): Acknowledgements. `none` = omit.
/// - colored-links (bool): KIT Blue links when `true`, black when `false`.
/// - draft (bool): Show "ENTWURF" watermark when `true`.
/// - draft-info (str): Optional version string below watermark. Default `none`.
/// - show-lof (bool): Include List of Figures.
/// - show-lot (bool): Include List of Tables.
/// - show-lol (bool): Include List of Listings.
/// - bibliography (content): Bibliography content. Pass `bibliography("refs.bib", title: none, style: "ieee")`.
///   The template adds a translated heading. `none` = omit.
/// - appendix-content (content): Appendix chapters. Template applies `A`, `A.1`, … numbering
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
    show-lof: true,
    show-lot: true,
    show-lol: false,
    bibliography: none,
    appendix-content: none,
    doc,
) = {
    let author-name = author-firstname + " " + author-surname

    set document(
        title: title,
        author: author-name,
        date: datetime.today(),
    )

    let tr = t.at(lang)
    set figure(
        supplement: it => if it.func() == table { tr.table } else { tr.figure },
    )
    show figure.where(kind: raw): set figure(supplement: context t
        .at(text.lang)
        .listing)

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

    if abstract-en != none {
        print-abstract(abstract-en)
    }
    if abstract-de != none {
        print-kurzfassung(abstract-de)
    }

    if acknowledgements != none {
        print-acknowledgements(acknowledgements, lang)
    }

    print-toc(lang: lang)

    // ── Main content (Arabic numerals) ──────────────────────────────────────
    show: _page-content
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

    if appendix-content != none {
        show: _page-appendix
        appendix-content
    }
}
