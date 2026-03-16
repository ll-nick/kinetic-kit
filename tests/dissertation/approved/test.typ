// Compile-only: approved dissertation — exercises the title page code path
// with exam-date, main-advisor, and co-advisor filled in.
#import "/lib.typ": dissertation

#show: dissertation.with(
    author-title: "M.Sc.",
    author-firstname: "Max",
    author-surname: "Mustermann",
    author-male: true,
    title: [Test Dissertation],
    lang: "de",
    status-approved: true,
    exam-date: "12. Dezember 2025",
    main-advisor: "Prof. Dr.-Ing. Hans Musterbetreuer",
    main-advisor-male: true,
    co-advisor: "Prof. Dr. Maria Musterreferentin",
    co-advisor-male: false,
    abstract-en: [English abstract.],
    abstract-de: [Deutsche Kurzfassung.],
    bibliography: bibliography(
        "/examples/bib/references.bib",
        title: none,
        style: "ieee",
    ),
)

= Chapter One

Content. @example2024
