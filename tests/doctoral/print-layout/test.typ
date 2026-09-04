// The bound-print combination: the widest margin preset, a binding correction on
// top of it, and black links. `"long"` is the only preset no example uses, and
// `colored-links: false` is the branch of the link show rule the others skip.
#import "/lib.typ": outlines, thesis

#show: thesis.with(
    title: [Print Layout],
    lang: "en",
    margin-preset: "long",
    binding-correction: 10mm,
    colored-links: false,
    front-matter: [#outlines.table-of-contents()],
    back-matter: [
        #bibliography(
            "/examples/bib/references.bib",
            title: [Bibliography],
            style: "ieee",
        )
    ],
)

= Introduction

An external link: #link("https://www.ksp.kit.edu/")[KIT Scientific Publishing]. An
internal one: @example2024.
