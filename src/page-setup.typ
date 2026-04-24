// page-setup.typ — shared document style engine
//
// Provides the dynamic page and style configuration used by both the
// dissertation and thesis templates:
//   _header               — context-aware running header
//   _draft-indicator()   — "ENTWURF"/"DRAFT" watermark
//   setup-page()         — full document style setup (page, headings, figures, equations, code)
//   setup-front-matter() — Roman numeral pagination wrapper
//   setup-content()      — Arabic numeral pagination wrapper
//   setup-appendix()     — A.1 numbering wrapper

#import "kit-colors.typ": kit-colors
#import "kit-fonts.typ": font-sizes, fonts, line-spacing
#import "page-conf.typ": kit-page, margins-by-length, par-spacing
#import "translations.typ": t


// ── Running header ────────────────────────────────────────────────────────
//
// Even page: chapter number and title
// Odd page:  section title, falls back to chapter title.
// Suppressed on chapter-opening pages and before the first chapter.
#let _header = context {
    set text(font: fonts.sans, size: font-sizes.small)
    let this-page = here().page()

    // Suppress on chapter-opening pages
    if query(heading.where(level: 1)).any(h => (
        h.location().page() == this-page
    )) {
        return
    }

    // Suppress before the first chapter
    let chapters-before = query(
        selector(heading.where(level: 1)).before(here()),
    )
    if chapters-before.len() == 0 { return }

    let current-chapter = chapters-before.last()
    let chapter-count = counter(heading).at(current-chapter.location()).first()

    let chapter-label = if current-chapter.numbering != none {
        let lvl1-fmt = current-chapter.numbering.split(".").at(0)
        [#numbering(lvl1-fmt, chapter-count) #current-chapter.body]
    } else {
        current-chapter.body
    }

    if calc.even(this-page) {
        chapter-label
        linebreak()
    } else {
        let sections-in-chapter = query(
            selector(heading.where(level: 2))
                .after(current-chapter.location())
                .before(here()),
        )
        let sec-label = if sections-in-chapter.len() > 0 {
            let s = sections-in-chapter.last()
            if s.numbering != none {
                let sn = counter(heading).at(s.location())
                let sec-fmt = s.numbering.split(".").slice(0, 2).join(".")
                [#numbering(sec-fmt, ..sn.slice(0, 2)) #s.body]
            } else {
                s.body
            }
        } else { chapter-label }
        align(right, sec-label)
    }
    line(length: 100%, stroke: 0.3pt + kit-colors.black)
}


// ── Draft indicator ───────────────────────────────────────────────────────

#let _draft-indicator(lang, draft-info) = place(
    bottom + center,
    dy: -6mm,
    box(
        inset: (x: 6pt, y: 4pt),
        text(font: fonts.sans, size: font-sizes.small)[
            #t.at(lang).draft#if draft-info != none [ · #draft-info]
        ],
    ),
)

// ── Base page setup ───────────────────────────────────────────────────────

/// Apply the full KIT document style: page geometry, running headers, KSP
/// typography, heading styles, figure captions, equations, and code blocks.
/// Use as a show rule: `#show: setup-page.with(...)`.
///
/// - margin-preset (str): Margin profile keyed on expected page count —
///   `"short"` (under 200 pp), `"medium"` (200–399 pp), `"long"` (400+ pp).
/// - lang (str): Document language — `"de"` or `"en"`.
/// - binding-correction (length): Extra inside margin added for binding (e.g. `3mm`).
/// - colored-links (bool): Render external hyperlinks in KIT blue when `true`.
/// - draft (bool): Show the draft watermark on every page when `true`.
/// - draft-info (content): Optional extra text appended to the watermark (e.g. a git SHA).
/// - doc (content): Document body (injected automatically by the show rule).
/// -> content
#let setup-page(
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
        header: _header,
        foreground: if draft {
            _draft-indicator(lang, draft-info)
        } else {
            none
        },
        footer: context {
            // Suppress before the very first chapter
            if (
                query(selector(heading.where(level: 1)).before(here())).len() == 0
            ) {
                return
            }
            set text(font: fonts.serif, size: font-sizes.base)
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
        counter(footnote).update(0)
        {
            set page(header: none, footer: none)
            pagebreak(weak: true, to: "odd")
        }
        v(4em)
        block[
            #set par(justify: false)
            #set text(
                font: fonts.sans,
                size: font-sizes.chapter,
                weight: "bold",
                hyphenate: false,
            )
            #it
        ]
        v(1em)
    }

    show heading.where(level: 2): it => {
        v(0.8em)
        block[
            #set par(justify: false)
            #set text(
                font: fonts.sans,
                size: font-sizes.section,
                weight: "bold",
                hyphenate: false,
            )
            #it
        ]
        v(0.4em)
    }

    show heading.where(level: 3): it => {
        v(0.5em)
        block[
            #set par(justify: false)
            #set text(
                font: fonts.sans,
                size: font-sizes.subsection,
                weight: "bold",
                hyphenate: false,
            )
            #it
        ]
        v(0.3em)
    }

    show heading.where(level: 4): it => {
        v(0.3em)
        block[
            #set par(justify: false)
            #set text(
                font: fonts.sans,
                size: font-sizes.subsubsection,
                weight: "bold",
                hyphenate: false,
            )
            #it.body
        ]
        v(0.2em)
    }

    // ── Outline entries ───────────────────────────────────────────────────

    set outline.entry(fill: repeat(".", gap: 0.4em))
    show outline: set par(justify: false)
    show outline: set text(hyphenate: false)

    // ── Figures ──────────────────────────────────────────────────────────
    set figure(
        supplement: it => if it.func() == table { t.at(lang).table } else {
            t.at(lang).figure
        },
    )
    show figure.where(kind: raw): set figure(supplement: context t.at(text.lang).listing)
    show figure.where(kind: table): set figure.caption(position: top)

    show figure.caption: it => layout(container => context {
        let body = [
            #set text(size: font-sizes.small)
            #text(
                weight: "bold",
            )[#it.supplement #it.counter.display(it.numbering):]
            #it.body
        ]
        // left-align captions ≥ 3 lines, center shorter ones.
        // Threshold sits between 2-line (~15.7 pt) and 3-line (~26.2 pt) heights
        // measured at 8 pt Libertinus Serif with 0.75 em leading.
        let h = measure(body, width: container.width).height
        if h > font-sizes.small * 2.5 {
            align(left, body)
        } else {
            align(center, body)
        }
    })

    show footnote.entry: it => {
        set text(size: font-sizes.footnote)
        context {
            let n = counter(footnote).at(it.note.location()).first()
            grid(
                columns: (auto, 1fr),
                column-gutter: 0.3em,
                align: top,
                super[#n], it.note.body,
            )
        }
    }

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
            radius: 5pt,
            it,
        )
    }

    doc
}

// ── Section-specific page setup (thin wrappers) ───────────────────────────

/// Switch to Roman numeral page numbering and remove heading numbering.
/// Apply before front-matter content: `#show: setup-front-matter`.
///
/// - doc (content): Document body (injected automatically by the show rule).
/// -> content
#let setup-front-matter(doc) = {
    set page(numbering: "i")
    set heading(numbering: none)
    doc
}

/// Switch to Arabic page numbering and enable `1.1` heading numbering.
/// Apply before the main content: `#show: setup-content`.
///
/// - doc (content): Document body (injected automatically by the show rule).
/// -> content
#let setup-content(doc) = {
    set page(numbering: "1")
    set heading(numbering: "1.1")
    doc
}

/// Switch to `A.1` heading numbering and reset the heading counter.
/// Apply before appendix chapters: `#show: setup-appendix`.
///
/// - doc (content): Document body (injected automatically by the show rule).
/// -> content
#let setup-appendix(doc) = {
    set heading(numbering: "A.1")
    counter(heading).update(0)
    doc
}
