// kit-thesis.typ — KIT dissertation and thesis templates
//
// Public API (re-exported via lib.typ):
//   dissertation(...)  — doctoral dissertation
//   thesis(...)        — Master's / Bachelor's / Diploma thesis
//   appendix           — show-rule to switch to appendix numbering

#import "kit-colors.typ": kit-colors
#import "kit-fonts.typ": font-sizes, fonts, line-spacing
#import "page-conf.typ": (
    kit-page, margins-by-length, par-spacing, title-page-margins,
)
#import "translations.typ": t
#import "title-page.typ": print-dissertation-title, print-thesis-title
#import "front-matter.typ": print-abstract, print-acknowledgements, print-kurzfassung

// ── Appendix show-rule ────────────────────────────────────────────────────

/// Show-rule that switches heading numbering to appendix style (`A`, `A.1`, …).
/// Apply with `#show: appendix` immediately before the first appendix heading.
///
/// - doc (content): Content of the appendix.
/// -> content
#let appendix(doc) = {
    set heading(numbering: "A.1")
    counter(heading).update(0)
    doc
}

// ── Shared content-page rules ─────────────────────────────────────────────

#let _setup-content-page(
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
        numbering: "1",
        header: context {
            set text(font: fonts.sans, size: font-sizes.small)

            let this-page = here().page()

            // Suppress header on blank pages (no headings at all on this page)
            let all-headings-here = query(heading).filter(h => (
                h.location().page() == this-page
            ))
            if all-headings-here.len() == 0 and calc.even(this-page) { return }

            // Suppress header on chapter-opening pages
            let chapter-pages = query(heading.where(level: 1)).filter(h => (
                h.location().page() == this-page
            ))
            if chapter-pages.len() > 0 { return }

            // Suppress header on pages with no chapter yet
            let chapters-before = query(
                selector(heading.where(level: 1)).before(here()),
            )
            if chapters-before.len() == 0 { return }

            let current-chapter = chapters-before.last()
            let chapter-count = counter(heading.where(level: 1))
                .at(current-chapter.location())
                .first()
            let chapter-name = current-chapter.body

            // Derive the level-1 numbering specifier from the heading's pattern
            // e.g. "1.1" → "1" (regular), "A.1" → "A" (appendix)
            let lvl1-fmt = if current-chapter.numbering != none {
                current-chapter.numbering.split(".").at(0)
            } else {
                "1"
            }
            let chapter-display = numbering(lvl1-fmt, chapter-count)

            if calc.even(this-page) {
                // Left page: chapter title
                [#chapter-display #chapter-name]
                linebreak()
                line(length: 100%, stroke: 0.4pt + kit-colors.black30)
            } else {
                // Right page: section title, fall back to chapter title
                let sections-before = query(
                    selector(heading.where(level: 2)).before(here()),
                )
                let (sec-display, sec-name) = if sections-before.len() > 0 {
                    let s = sections-before.last()
                    let sn = counter(heading).at(s.location())
                    // Only use section if it belongs to the current chapter
                    if sn.first() == chapter-count {
                        let sec-fmt = if s.numbering != none {
                            s.numbering.split(".").slice(0, 2).join(".")
                        } else {
                            "1.1"
                        }
                        (numbering(sec-fmt, ..sn.slice(0, 2)), s.body)
                    } else {
                        (chapter-display, chapter-name)
                    }
                } else {
                    (chapter-display, chapter-name)
                }
                align(right)[#sec-display #sec-name]
                linebreak()
                line(length: 100%, stroke: 0.4pt + kit-colors.black30)
            }
        },
        footer: context {
            // Suppress page number on blank pages
            let this-page = here().page()
            let headings-here = query(heading).filter(h => (
                h.location().page() == this-page
            ))
            if headings-here.len() == 0 and calc.even(this-page) { return }
            set text(font: fonts.sans, size: font-sizes.small)
            if calc.odd(here().page()) {
                align(right, counter(page).display())
            } else {
                align(left, counter(page).display())
            }
        },
    )

    set text(
        font: fonts.serif,
        size: font-sizes.base,
        lang: lang,
    )

    set par(
        justify: true,
        first-line-indent: 0pt,
        leading: line-spacing,
        spacing: par-spacing,
    )

    if colored-links {
        show link: it => {
            if type(it.dest) == str {
                text(fill: kit-colors.blue)[#it]
            } else {
                it
            }
        }
    }

    // ── Draft watermark ───────────────────────────────────────────────────
    if draft {
        let watermark-label = if draft-info != none {
            [ENTWURF\ #text(size: 14pt)[#draft-info]]
        } else {
            [ENTWURF]
        }
        set page(background: rotate(
            -45deg,
            text(
                font: fonts.sans,
                size: 80pt,
                weight: "bold",
                fill: luma(220),
            )[#watermark-label],
        ))
    }

    // ── Headings ────────────────────────────────────────────────────────────
    set heading(numbering: "1.1")

    show heading.where(level: 1): it => {
        counter(math.equation).update(0)
        counter(figure.where(kind: image)).update(0)
        counter(figure.where(kind: table)).update(0)
        counter(figure.where(kind: raw)).update(0)

        pagebreak(weak: true, to: "odd")
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

    // ── Figures ─────────────────────────────────────────────────────────────
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

    // ── Equations ───────────────────────────────────────────────────────────
    set math.equation(
        numbering: it => {
            let ch = counter(heading.where(level: 1)).at(here()).first()
            if ch > 0 { numbering("(1.1)", ch, it) } else {
                numbering("(1)", it)
            }
        },
    )

    // ── Code listings ───────────────────────────────────────────────────────
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

// ── Front-matter page setup ───────────────────────────────────────────────

#let _front-matter-page(
    margin-preset: "short",
    lang: "de",
    binding-correction: 0mm,
    body,
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
        numbering: "i",
        header: context {
            set text(font: fonts.sans, size: font-sizes.small)
            let this-page = here().page()

            // Suppress on pages where a section heading appears (section opener)
            let headings-here = query(heading.where(level: 1)).filter(
                h => h.location().page() == this-page,
            )
            if headings-here.len() > 0 { return }

            // Show current section title (continuation pages)
            let sections-before = query(
                selector(heading.where(level: 1)).before(here()),
            )
            if sections-before.len() == 0 { return }
            let current = sections-before.last()

            if calc.even(this-page) {
                [#current.body]
                linebreak()
            } else {
                align(right)[#current.body]
            }
            line(length: 100%, stroke: 0.5pt + kit-colors.black)
        },
        footer: context {
            let sections-before = query(
                selector(heading.where(level: 1)).before(here()),
            )
            if sections-before.len() == 0 { return }
            set text(font: fonts.sans, size: font-sizes.small)
            if calc.odd(here().page()) {
                align(right, counter(page).display("i"))
            } else {
                align(left, counter(page).display("i"))
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
    set heading(numbering: none)

    show heading.where(level: 1): it => {
        v(4em)
        block[
            #set text(
                font: fonts.sans,
                size: font-sizes.chapter,
                weight: "bold",
            )
            #it
        ]
        v(0.8em)
    }

    body
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
/// - own-publications (content): Own publications block. `none` = omit.
/// - own-patents (content): Own patents block. `none` = omit.
/// - supervised-theses (content): Supervised theses block. `none` = omit.
/// - doc (content): Main document body.
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

    pagebreak(to: "odd")

    // ── Front matter (Roman numerals) ───────────────────────────────────────
    show: _front-matter-page.with(
        margin-preset: margin-preset,
        lang: lang,
        binding-correction: binding-correction,
    )
    counter(page).update(1)

    if abstract-en != none {
        print-abstract(abstract-en)
        pagebreak()
    }

    if abstract-de != none {
        print-kurzfassung(abstract-de)
        pagebreak()
    }

    if acknowledgements != none {
        print-acknowledgements(acknowledgements, lang)
        pagebreak(to: "odd")
    }

    // TODO: CV, TOC, notation, abbreviations

    // ── Main content (Arabic numerals) ──────────────────────────────────────
    counter(page).update(1)
    show: _setup-content-page.with(
        margin-preset: margin-preset,
        lang: lang,
        binding-correction: binding-correction,
        colored-links: colored-links,
        draft: draft,
        draft-info: draft-info,
    )

    doc

    // ── Back matter ─────────────────────────────────────────────────────────
    // TODO: LoF, LoT, LoL, own-publications, patents, supervised-theses
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
/// - doc (content): Main document body.
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

    pagebreak(to: "odd")

    // ── Front matter (Roman numerals) ───────────────────────────────────────
    show: _front-matter-page.with(
        margin-preset: margin-preset,
        lang: lang,
        binding-correction: binding-correction,
    )
    counter(page).update(1)

    if abstract-en != none {
        print-abstract(abstract-en)
        pagebreak()
    }

    if abstract-de != none {
        print-kurzfassung(abstract-de)
        pagebreak()
    }

    if acknowledgements != none {
        print-acknowledgements(acknowledgements, lang)
        pagebreak(to: "odd")
    }

    // TODO: TOC

    // ── Main content (Arabic numerals) ──────────────────────────────────────
    counter(page).update(1)
    show: _setup-content-page.with(
        margin-preset: margin-preset,
        lang: lang,
        binding-correction: binding-correction,
        colored-links: colored-links,
        draft: draft,
        draft-info: draft-info,
    )

    doc

    // TODO: LoF, LoT, LoL
}
