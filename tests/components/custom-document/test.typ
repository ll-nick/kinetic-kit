// Compile-only: full custom document assembled from the internal setup wrappers,
// exercising the complete page-setup wrapper sequence.
#import "/lib.typ": doctoral-title-page, flex-caption, outlines
#import "/src/page-setup.typ": (
    setup-appendix, setup-content, setup-front-matter, setup-page,
)
#import "/src/typography.typ": font-sizes-by-format

#let font-sizes = font-sizes-by-format.at("a5")

#show: setup-page.with(
    margin-preset: "short",
    lang: "de",
    colored-links: true,
)

// ── Front matter ─────────────────────────────────────────────────────────

#show: setup-front-matter

#doctoral-title-page(
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

#outlines.table-of-contents()
#outlines.list-of-figures()

// ── Main content ──────────────────────────────────────────────────────────

#show: setup-content

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

#show: setup-appendix

= Anhang

Anhang-Inhalt.
