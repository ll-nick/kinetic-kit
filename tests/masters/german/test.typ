// Compile-only: full-ish German thesis with the most common optional sections.
#import "/lib.typ": outlines, thesis
#import "/examples/content/masters-title-page.typ": masters-title-page

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Test Masterarbeit],
    lang: "de",
    margin-preset: "short",
    front-matter: [
        = Danksagung
        Acknowledgements.

        = Abstract
        English abstract.

        = Kurzfassung
        Deutsche Kurzfassung.

        #outlines.table-of-contents()
    ],
    back-matter: [
        #outlines.list-of-figures()
        #outlines.list-of-tables()
        #bibliography(
            "/examples/bib/references.bib",
            title: [Literaturverzeichnis],
            style: "ieee",
        )
    ],
    title-page: masters-title-page.with(
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
