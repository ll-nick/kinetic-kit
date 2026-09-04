// Compile-only: submitted doctoral thesis with abstract, bibliography,
// and the most commonly used optional sections.
#import "/lib.typ": doctoral-title-page, outlines, thesis

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Test Dissertation],
    lang: "de",
    margin-preset: "short",
    front-matter: [
        = Danksagung
        Acknowledgements text.

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
    title-page: doctoral-title-page.with(
        author-title: "M.Sc.",
        author-male: true,
        status-approved: false,
    ),
)

= Chapter One

Content. @example2024

== Section One

@example2023
