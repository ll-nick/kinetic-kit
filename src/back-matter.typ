// back-matter.typ — back-matter pages
// bibliography, own publications, own patents, supervised theses

#import "translations.typ": t

// ── Bibliography ──────────────────────────────────────────────────────────

#let print-bibliography(body, lang) = {
    heading(level: 1, numbering: none, outlined: true, bookmarked: true)[#(
        t.at(lang).bibliography
    )]
    body
}

// ── Back-matter publication lists ─────────────────────────────────────────

#let print-own-publications(body, lang) = {
    heading(level: 1, numbering: none, outlined: true, bookmarked: true)[#(
        t.at(lang).own-publications
    )]
    body
}

#let print-own-patents(body, lang) = {
    heading(level: 1, numbering: none, outlined: true, bookmarked: true)[#(
        t.at(lang).patents
    )]
    body
}

#let print-supervised-theses(body, lang) = {
    heading(level: 1, numbering: none, outlined: true, bookmarked: true)[#(
        t.at(lang).supervised
    )]
    body
}
