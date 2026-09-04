// Compile-only: doctoral thesis in English — verifies all translated strings
// resolve without error when lang: "en".
#import "/lib.typ": doctoral-title-page, outlines, thesis

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Test Dissertation in English],
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
    title-page: doctoral-title-page.with(
        author-title: "M.Sc.",
        author-male: true,
    ),
)

= Introduction

Content. @example2024

== Background

More content.
