// Compile-only: approved doctoral thesis — exercises the title page code path
// with exam-date, main-advisor, and co-advisor filled in.
#import "/lib.typ": doctoral-title-page, thesis

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Test Dissertation],
    lang: "de",
    abstract-en: [English abstract.],
    abstract-de: [Deutsche Kurzfassung.],
    bibliography: bibliography(
        "/examples/bib/references.bib",
        title: none,
        style: "ieee",
    ),
    title-page: doctoral-title-page.with(
        author-title: "M.Sc.",
        author-male: true,
        status-approved: true,
        exam-date: "12. Dezember 2025",
        main-advisor: "Prof. Dr.-Ing. Hans Musterbetreuer",
        main-advisor-male: true,
        co-advisor: "Prof. Dr. Maria Musterreferentin",
        co-advisor-male: false,
    ),
)

= Chapter One

Content. @example2024
