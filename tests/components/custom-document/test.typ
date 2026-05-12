// Compile-only: full custom document assembled from individual components,
// exercising the complete page-setup wrapper sequence.
#import "/lib.typ": (
    flex-caption, print-dissertation-title, print-lof, print-toc, setup-appendix,
    setup-content, setup-front-matter, setup-page,
)

#show: setup-page.with(
    margin-preset: "short",
    lang: "de",
    colored-links: true,
)

// ── Front matter ─────────────────────────────────────────────────────────

#show: setup-front-matter

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
    false,
    none,
    none,
    true,
    none,
    true,
)

#print-toc(lang: "de")
#print-lof(lang: "de")

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
