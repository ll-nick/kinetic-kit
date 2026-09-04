// Compile-only: thesis in English — verifies translated strings for thesis.
#import "/lib.typ": outlines, thesis
#import "/examples/content/masters-title-page.typ": masters-title-page

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Test Master's Thesis in English],
    lang: "en",
    front-matter: [
        = Abstract
        English abstract.

        #outlines.table-of-contents()
    ],
    back-matter: [
        #outlines.list-of-figures()
        #outlines.list-of-tables()
        #bibliography(
            "/examples/bib/references.bib",
            title: [Bibliography],
            style: "ieee",
        )
    ],
    title-page: masters-title-page.with(
        thesis-type: "Masterarbeit",
        department: "KIT-Fakultät für Maschinenbau",
        examiner: "Prof. Dr.-Ing. Hans Musterbetreuer",
        supervisor: "M.Sc. Maria Musterbetreuerin",
        date-submitted: "01 March 2026",
    ),
)

= Introduction

Content. @example2024
