// Compile-only: dissertation with appendix — verifies appendix numbering
// (A, A.1, …) and the page-rules switch don't regress.
#import "/lib.typ": dissertation

#show: dissertation.with(
    author-title: "M.Sc.",
    author-firstname: "Max",
    author-surname: "Mustermann",
    author-male: true,
    title: [Dissertation with Appendix],
    lang: "de",
    bibliography: bibliography(
        "/examples/bib/references.bib",
        title: none,
        style: "ieee",
    ),
    appendix: [
        = Supplementary Material

        #lorem(80)

        == Detail A.1

        #lorem(40)
    ],
)

= Chapter One

Content. @example2024
