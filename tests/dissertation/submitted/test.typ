// Compile-only: submitted dissertation with abstract, bibliography,
// and the most commonly used optional sections.
#import "/lib.typ": dissertation

#show: dissertation.with(
    author-title: "M.Sc.",
    author-firstname: "Max",
    author-surname: "Mustermann",
    author-male: true,
    title: [Test Dissertation],
    lang: "de",
    margin-preset: "short",
    status-approved: false,
    abstract-en: [English abstract.],
    abstract-de: [Deutsche Kurzfassung.],
    acknowledgements: [Acknowledgements text.],
    show-lof: true,
    show-lot: true,
    bibliography: bibliography(
        "/examples/bib/references.bib",
        title: none,
        style: "ieee",
    ),
)

= Chapter One

Content. @example2024

== Section One

@example2023
