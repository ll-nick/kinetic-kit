// Compile-only: render both title pages directly via components,
// without any setup-page wrapper (each title page sets its own page geometry).
#import "/lib.typ": print-dissertation-title, print-thesis-title

#print-dissertation-title(
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
)

#print-thesis-title(
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
)
