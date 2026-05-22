// Compile-only: full custom document assembled from individual components,
// exercising the complete page-setup wrapper sequence.
#import "/lib.typ": components, flex-caption
#import "/src/typography.typ": font-sizes-by-format
#let font-sizes = font-sizes-by-format.at("a5")

#show: components.setup-page.with(
    margin-preset: "short",
    lang: "de",
    colored-links: true,
)

// ── Front matter ─────────────────────────────────────────────────────────

#show: components.setup-front-matter

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
    false,
    none,
    none,
    true,
    none,
    true,
    font-sizes,
)

#components.print-toc(font-sizes, lang: "de")
#components.print-lof(lang: "de")

// ── Main content ──────────────────────────────────────────────────────────

#show: components.setup-content

= Einleitung

Inhalt des ersten Kapitels.

#figure(
    rect(width: 4cm, height: 2cm),
    caption: flex-caption(short: [Kurze Bildunterschrift], long: [Lange
        Bildunterschrift.]),
)

== Unterabschnitt

Weiterer Inhalt.

// ── Appendix ─────────────────────────────────────────────────────────────

#show: components.setup-appendix

= Anhang

Anhang-Inhalt.
