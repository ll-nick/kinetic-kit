// Compile-only: submitted doctoral thesis with abstract, bibliography,
// and the most commonly used optional sections.
#import "/lib.typ": doctoral-title-page, thesis

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

        #outline()
    ],
    back-matter: [
        #outline(target: figure.where(kind: image))
        #outline(target: figure.where(kind: table))
        #bibliography(
            "/examples/bib/references.bib",
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
