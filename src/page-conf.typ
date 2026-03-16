// page-conf.typ — static page layout constants for KIT dissertation template
// A5 format as recommended by KIT Scientific Publishing (KSP)

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
