// Approved doctoral thesis — exercises the title page code path with exam-date,
// main-advisor, and co-advisor filled in. Its front matter happens to end on an
// odd page, so `setup-content` has to skip a filler sheet to reach the recto the
// first chapter opens on: the case where the body used to start at page 2.
#import "/lib.typ": doctoral-title-page, outlines, thesis

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Test Dissertation],
    lang: "de",
    front-matter: [
        = Abstract
        English abstract.

        = Kurzfassung
        Deutsche Kurzfassung.

        #outlines.table-of-contents()
    ],
    back-matter: [
        #bibliography(
            "/examples/bib/references.bib",
            title: [Literaturverzeichnis],
            style: "ieee",
        )
    ],
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

#context assert.eq(
    counter(page).at(here()).first(),
    1,
    message: "the first chapter must be page 1",
)

Content. @example2024
