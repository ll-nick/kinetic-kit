// Page layout for KIT dissertation template
// A5 format as recommended by KIT Scientific Publishing (KSP)

#import "kit-colors.typ": kit-colors
#import "kit-fonts.typ": font-sizes, fonts, line-spacing

#let kit-page = (
    type: "a5",
    width: 148mm,
    height: 210mm,
)

// Margin presets — KSP Basic Layout Guidelines, A5 (not scaled)
// Choose based on total page count of the finished dissertation.
#let margins-by-length = (
    short: (top: 25mm, bottom: 22mm, inside: 20mm, outside: 15mm), // < 200 pages
    medium: (top: 25mm, bottom: 22mm, inside: 23mm, outside: 15mm), // 200–399 pages
    long: (top: 25mm, bottom: 22mm, inside: 25mm, outside: 15mm), // ≥ 400 pages
)

#let title-page-margins = (
    top: 20mm,
    bottom: 25mm,
    inside: 22mm,
    outside: 18mm,
)

#let par-spacing = 1.0em

// ── Header ─────────────────────────────────────────────────
//
// Even page: chapter number and title
// Odd page:  section title, falls back to chapter title.
// Suppressed on chapter-opening pages and before the first chapter.
#let kit-header = context {
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
        let sections-before = query(
            selector(heading.where(level: 2)).before(here()),
        )
        let sec-label = if sections-before.len() > 0 {
            let s = sections-before.last()
            let sn = counter(heading).at(s.location())
            if sn.first() == chapter-count {
                if s.numbering != none {
                    let sec-fmt = s.numbering.split(".").slice(0, 2).join(".")
                    [#numbering(sec-fmt, ..sn.slice(0, 2)) #s.body]
                } else {
                    s.body
                }
            } else { chapter-label }
        } else { chapter-label }
        align(right, sec-label)
    }
    line(length: 100%, stroke: 0.4pt + kit-colors.black)
}
