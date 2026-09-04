// Compile-only: the gendered branches of `doctoral-title-page`, which the
// doctoral document tests never take — they all pass the masculine forms.
// `author-male: false` selects "einer" plus `doc-degree-f`, the two advisor
// flags pick their labels independently, and `author-title: none` drops the
// academic title in front of the author's name.
#import "/lib.typ": doctoral-title-page, thesis

#show: thesis.with(
    author-firstname: "Maria",
    author-surname: "Musterfrau",
    title: [Titel der Dissertation],
    lang: "de",
    title-page: doctoral-title-page.with(
        author-title: none,
        author-male: false,
        doc-degree: "Doktors der Ingenieurwissenschaften (Dr.-Ing.)",
        doc-degree-f: "Doktorin der Ingenieurwissenschaften (Dr.-Ing.)",
        status-approved: true,
        exam-date: "12. Dezember 2025",
        main-advisor: "Prof. Dr. Maria Musterreferentin",
        main-advisor-male: false,
        co-advisor: "Prof. Dr.-Ing. Hans Musterbetreuer",
        co-advisor-male: true,
    ),
)

= Kapitel

Inhalt.
