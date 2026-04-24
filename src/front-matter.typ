// front-matter.typ — front-matter pages
// abstract, kurzfassung, acknowledgements, CV, notation, abbreviations

#import "kit-fonts.typ": font-sizes, fonts
#import "translations.typ": t

// ── Abstract / Kurzfassung ────────────────────────────────────────────────

/// Print the English abstract section.
///
/// - body (content): Abstract text.
/// -> content
#let print-abstract(body) = {
    heading(level: 1, numbering: none, outlined: true)[Abstract]
    body
}

/// Print the German abstract (Kurzfassung) section.
///
/// - body (content): Kurzfassung text.
/// -> content
#let print-kurzfassung(body) = {
    heading(level: 1, numbering: none, outlined: true)[Kurzfassung]
    body
}

// ── Acknowledgements ──────────────────────────────────────────────────────

/// Print the acknowledgements section.
///
/// - body (content): Acknowledgements text.
/// - lang (str): Document language — `"de"` or `"en"`.
/// -> content
#let print-acknowledgements(body, lang) = {
    heading(level: 1, numbering: none, outlined: true)[#(
        t.at(lang).acknowledgements
    )]
    body
}

// ── Curriculum Vitae ──────────────────────────────────────────────────────

/// Single entry row for use inside `print-cv`.
///
/// - year (str): Year or year range displayed in the left column.
/// - description (content): Description text in the right column.
/// -> content
#let cv-entry(year: "", description: "") = grid(
    columns: (3cm, 1fr),
    column-gutter: 1em,
    row-gutter: 0.5em,
    text(weight: "bold")[#year], description,
)

/// Print the curriculum vitae section.
///
/// - name (str): Author's full name, shown in bold below the heading.
/// - entries (array): Array of `(year, description)` pairs passed to `cv-entry`.
/// - lang (str): Document language — `"de"` or `"en"`.
/// -> content
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

/// Print the notation / symbol list section.
///
/// - body (content): Notation content (typically a table or list).
/// - lang (str): Document language — `"de"` or `"en"`.
/// -> content
#let print-notation(body, lang) = {
    heading(level: 1, numbering: none, outlined: true)[#t.at(lang).notation]
    body
}

// ── Abbreviations ─────────────────────────────────────────────────────────

/// Print the list of abbreviations section.
///
/// - body (content): Abbreviations content (typically a glossarium list or table).
/// - lang (str): Document language — `"de"` or `"en"`.
/// -> content
#let print-abbreviations(body, lang) = {
    heading(level: 1, numbering: none, outlined: true)[#(
        t.at(lang).abbreviations
    )]
    body
}
