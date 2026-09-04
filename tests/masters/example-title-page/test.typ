// Compile-only: the student-thesis path. `thesis()` itself is shared with the
// doctoral tests — the only thing that makes a document a Master's thesis is the
// title page — so this pins the one part that differs: the example title page in
// `examples/content/`, driven through `thesis()` with every parameter it takes.
#import "/lib.typ": outlines, thesis
#import "/examples/content/masters-title-page.typ": masters-title-page

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Test Masterarbeit],
    lang: "de",
    front-matter: [
        = Danksagung
        Acknowledgements.

        = Kurzfassung
        Deutsche Kurzfassung.

        #outlines.table-of-contents()
    ],
    appendix: [
        = Ergänzendes Material

        Numbered A.

        == Ein Detail

        Numbered A.1.
    ],
    back-matter: [
        #outlines.list-of-figures()
        #bibliography(
            "/examples/bib/references.bib",
            title: [Literaturverzeichnis],
            style: "ieee",
        )
    ],
    title-page: masters-title-page.with(
        thesis-type: "Masterarbeit",
        department: "KIT-Fakultät für Maschinenbau",
        university-genitive: "des Karlsruher Instituts für Technologie (KIT)",
        examiner: "Prof. Dr.-Ing. Hans Musterbetreuer",
        supervisor: "M.Sc. Maria Musterbetreuerin",
        date-submitted: "01. März 2026",
    ),
)

= Einleitung

Inhalt. @example2024

#figure(rect(width: 3cm, height: 2cm), caption: [Eine Abbildung])
