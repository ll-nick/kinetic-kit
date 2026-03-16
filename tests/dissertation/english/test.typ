// Compile-only: dissertation in English — verifies all translated strings
// resolve without error when lang: "en".
#import "/lib.typ": dissertation

#show: dissertation.with(
    author-title: "M.Sc.",
    author-firstname: "Max",
    author-surname: "Mustermann",
    author-male: true,
    title: [Test Dissertation in English],
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

== Background

More content.
