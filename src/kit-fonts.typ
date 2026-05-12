// Font configuration for KIT dissertation template
// A5 paper, 10 pt base — as recommended by KIT Scientific Publishing (KSP)

#let fonts = (
    serif: ("Libertinus Serif",),
    sans: ("Libertinus Sans",),
    mono: ("Libertinus Mono",),
)

#let font-sizes = (
    base: 10pt,
    // Headings (sans-serif) — KSP table, A5 / 10 pt base
    chapter: 18pt,
    section: 14pt,
    subsection: 12pt,
    subsubsection: 10pt,
    // Title page
    title: 18pt,
    author: 14pt,
    title-info: 14pt,
    // Auxiliary — 2 pt below body text per KSP requirement
    small: 8pt, // headers, footnotes, captions
    footnote: 8pt,
)

// Line spacing: 1.15× at 10 pt = ~11.5 pt total line height.
// Typst `leading` is the gap between baseline and next baseline minus cap-height,
// so 0.75em ≈ 7.5 pt, giving ~11.5 pt total.
#let leading = 0.75em
