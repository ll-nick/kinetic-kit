// Compile-only: doctoral thesis in English — verifies all translated strings
// resolve without error when lang: "en".
#import "/lib.typ": doctoral-title-page, thesis

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Test Dissertation in English],
    lang: "en",
    front-matter: [
        = Abstract
        English abstract.

        #outline()
    ],
    back-matter: [
        #outline(target: figure.where(kind: image))
        #outline(target: figure.where(kind: table))
        #bibliography(
            "/examples/bib/references.bib",
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
