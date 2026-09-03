// Compile-only: doctoral thesis in English — verifies all translated strings
// resolve without error when lang: "en".
#import "/lib.typ": doctoral-title-page, thesis

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Test Dissertation in English],
    lang: "en",
    abstract-en: [English abstract.],
    show-list-of-figures: true,
    show-list-of-tables: true,
    bibliography: bibliography(
        "/examples/bib/references.bib",
        title: none,
        style: "ieee",
    ),
    title-page: doctoral-title-page.with(
        author-title: "M.Sc.",
        author-male: true,
    ),
)

= Introduction

Content. @example2024

== Background

More content.
