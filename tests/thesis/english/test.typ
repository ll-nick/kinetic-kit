// Compile-only: thesis in English — verifies translated strings for thesis.
#import "/lib.typ": print-thesis-title, thesis

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Test Master's Thesis in English],
    lang: "en",
    abstract-en: [English abstract.],
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
        date-submitted: "01 March 2026",
    ),
)

= Introduction

Content. @example2024
