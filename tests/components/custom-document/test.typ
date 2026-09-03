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
    author-title: "M.Sc.",
    author-firstname: "Max",
    author-surname: "Mustermann",
    author-male: true,
    doc-degree: "Doktor-Ingenieur",
    doc-degree-f: "Doktor-Ingenieurin",
    department: "KIT-Fakultät für Maschinenbau",
    university-genitive: "des Karlsruher Instituts für Technologie (KIT)",
    status-approved: false,
    format: "a5",
)

#components.toc(lang: "de")
#components.list-of-figures(lang: "de")

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
