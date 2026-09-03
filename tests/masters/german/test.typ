// Compile-only: full-ish German thesis with the most common optional sections.
#import "/lib.typ": print-thesis-title, thesis

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Test Masterarbeit],
    lang: "de",
    margin-preset: "short",
    abstract-en: [English abstract.],
    abstract-de: [Deutsche Kurzfassung.],
    acknowledgements: [Acknowledgements.],
    show-list-of-figures: true,
    show-list-of-tables: true,
    bibliography: bibliography(
        "/examples/bib/references.bib",
        title: none,
        style: "ieee",
    ),
    title-page: print-thesis-title.with(
        thesis-type: "Masterarbeit",
        department: "KIT-Fakultät für Maschinenbau",
        examiner: "Prof. Dr.-Ing. Hans Musterbetreuer",
        supervisor: "M.Sc. Maria Musterbetreuerin",
        date-submitted: "01. März 2026",
    ),
)

= Einleitung

Inhalt. @example2024

== Grundlagen

Weiterer Inhalt. @example2023
