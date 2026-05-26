// Thumbnail for Typst Universe gallery.

#import "../src/title-page.typ": print-dissertation-title
#import "../src/typography.typ": font-sizes-by-format
#import "../src/page-conf.typ": title-page-margins-by-format

#let font-sizes = font-sizes-by-format.at("a5")
#let title-page-margins = title-page-margins-by-format.at("a5")

#print-dissertation-title(
    [Dissertation Title],
    none,
    "Max",
    "Mustermann",
    true,
    "Doktors der Ingenieurwissenschaften (Dr.-Ing.)",
    "Doktorin der Ingenieurwissenschaften (Dr.-Ing.)",
    "KIT-Fakultät für Maschinenbau",
    "des Karlsruher Instituts für Technologie (KIT)",
    true,
    [1. Januar 2026],
    [Prof. Dr. Hauptreferentin],
    false,
    [Prof. Dr. Korreferent],
    true,
    font-sizes,
    title-page-margins,
)
