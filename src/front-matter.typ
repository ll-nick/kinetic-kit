// front-matter.typ — front-matter pages
// abstract, kurzfassung, acknowledgements, CV, notation, abbreviations

#import "kit-fonts.typ": font-sizes, fonts, line-spacing
#import "translations.typ": t

// ── Abstract / Kurzfassung ────────────────────────────────────────────────

#let print-abstract(body) = {
    heading(level: 1, numbering: none, outlined: true)[Abstract]
    body
}

#let print-kurzfassung(body) = {
    heading(level: 1, numbering: none, outlined: true)[Kurzfassung]
    body
}

// ── Acknowledgements ──────────────────────────────────────────────────────

#let print-acknowledgements(body, lang) = {
    heading(level: 1, numbering: none, outlined: true)[#(
        t.at(lang).acknowledgements
    )]
    body
}

// ── Curriculum Vitae ──────────────────────────────────────────────────────

#let cv-entry(year: "", description: "") = grid(
    columns: (3cm, 1fr),
    column-gutter: 1em,
    row-gutter: 0.5em,
    text(weight: "bold")[#year], description,
)

#let print-cv(name, entries, lang) = {
    heading(level: 1, numbering: none, outlined: true)[#t.at(lang).cv]
    v(0.5em)
    text(weight: "bold")[#name]
    v(1em)
    for entry in entries {
        cv-entry(year: entry.at(0), description: entry.at(1))
    }
}

// ── Notation / Symbol list ────────────────────────────────────────────────

#let print-notation(body, lang) = {
    heading(level: 1, numbering: none, outlined: true)[#t.at(lang).notation]
    body
}

// ── Abbreviations ─────────────────────────────────────────────────────────

#let print-abbreviations(body, lang) = {
    heading(level: 1, numbering: none, outlined: true)[#(
        t.at(lang).abbreviations
    )]
    body
}
