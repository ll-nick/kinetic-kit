// Compile-only: render both title pages directly via components,
// without any setup-page wrapper (each title page sets its own page geometry).
#import "/lib.typ": components
#import "/src/typography.typ": font-sizes-by-format
#let font-sizes = font-sizes-by-format.at("a5")

#components.print-dissertation-title(
    [Titel der Dissertation],
    "M.Sc.",
    "Max",
    "Mustermann",
    true,
    "Doktor-Ingenieur",
    "Doktor-Ingenieurin",
    "KIT-Fakultät für Maschinenbau",
    "des Karlsruher Instituts für Technologie (KIT)",
    true,
    "12. Dezember 2025",
    "Prof. Dr.-Ing. Hans Musterbetreuer",
    true,
    "Prof. Dr. Maria Musterreferentin",
    false,
    font-sizes,
)

#components.print-thesis-title(
    [Titel der Masterarbeit],
    "Masterarbeit",
    "Max",
    "Mustermann",
    "KIT-Fakultät für Maschinenbau",
    "des Karlsruher Instituts für Technologie (KIT)",
    "Prof. Dr.-Ing. Hans Musterbetreuer",
    "M.Sc. Maria Musterbetreuerin",
    "01. März 2026",
    "de",
    font-sizes,
)
