// Compile-only: thesis in English — verifies translated strings for thesis.
#import "/lib.typ": thesis

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Test Master's Thesis in English],
    thesis-type: "Masterarbeit",
    department: "KIT-Fakultät für Maschinenbau",
    examiner: "Prof. Dr.-Ing. Hans Musterbetreuer",
    supervisor: "M.Sc. Maria Musterbetreuerin",
    date-submitted: "01 March 2026",
    lang: "en",
    abstract-en: [English abstract.],
    show-lof: true,
    show-lot: true,
    bibliography: bibliography(
        "/examples/bib/references.bib",
        title: none,
        style: "ieee",
    ),
)

= Introduction

Content. @example2024
