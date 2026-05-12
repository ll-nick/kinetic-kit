// Shared abbreviation renderer for glossarium's print-glossary().
//
// abbrevs-glossary(abbrevs) renders a borderless two-column list:
//   bold abbreviation (left) | plain long form (right)
//

#import "@preview/glossarium:0.5.10": print-glossary

#let _abbrev-entry(entry, ..args) = grid(
    columns: (2cm, 1fr),
    inset: (x: 0pt, y: 3pt),
    align: left,
    strong(entry.short), entry.long,
)

#let abbrevs-glossary(abbrevs) = {
    // The global show figure rule adds space above/below every figure, which
    // would create large gaps between the per-entry grid rows. Reset it here.
    show figure.where(kind: "glossarium_entry"): set block(above: 0.5pt, below: 0.5pt)
    print-glossary(
        abbrevs,
        disable-back-references: true,
        user-print-gloss: _abbrev-entry,
    )
}
