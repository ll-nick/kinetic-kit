// Compile-only: submitted doctoral thesis with abstract, bibliography,
// and the most commonly used optional sections.
#import "/lib.typ": doctoral-title-page, thesis

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Test Dissertation],
    lang: "de",
    margin-preset: "short",
    abstract-en: [English abstract.],
    abstract-de: [Deutsche Kurzfassung.],
    acknowledgements: [Acknowledgements text.],
    show-list-of-figures: true,
    show-list-of-tables: true,
    bibliography: bibliography(
        "/examples/bib/references.bib",
        title: none,
        style: "ieee",
    ),
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
