// document.typ — shared orchestrator behind dissertation() and thesis()
//
// Owns the document structure both templates have in common: global style setup,
// title page, front matter, content, appendix, list pages and back matter.
// The templates differ only in which title page they render and which optional
// sections they offer, so both pass those in.

#import "page-setup.typ": setup-appendix, setup-content, setup-front-matter, setup-page
#import "front-matter.typ": (
    print-abbreviations, print-abstract, print-acknowledgements, print-kurzfassung,
    print-notation,
)
#import "back-matter.typ": (
    print-bibliography, print-own-patents, print-own-publications,
    print-supervised-theses,
)
#import "outlines.typ": print-list-of, print-toc
#import "figure-kinds.typ": resolve-figure-kinds, resolve-localized


// Assemble the document from an already-rendered title page. Parameters mirror the
// public templates; see their doc-comments, which tidy renders into the API reference.
#let _document(
    title-page: none,
    title: [Your Thesis Title],
    author-firstname: "Max",
    author-surname: "Mustermann",
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
    show-lof: true,
    show-lot: true,
    show-lol: false,
    figure-kinds: (),
    own-publications: none,
    own-patents: none,
    supervised-theses: none,
    bibliography: none,
    appendix: none,
    doc,
) = {
    assert(
        format in ("a5", "17x24", "a4"),
        message: "format must be \"a5\", \"17x24\" (170×240 mm), or \"a4\"",
    )
    let author-name = author-firstname + " " + author-surname
    let resolved-figure-kinds = resolve-figure-kinds(
        figure-kinds,
        show-lof: show-lof,
        show-lot: show-lot,
        show-lol: show-lol,
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
    title-page

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

    print-toc(lang: lang)

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
            print-list-of(
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
