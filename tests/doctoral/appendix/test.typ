// Compile-only: doctoral thesis with appendix — verifies appendix numbering
// (A, A.1, …) and the page-rules switch don't regress.
#import "/lib.typ": doctoral-title-page, thesis

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Dissertation with Appendix],
    lang: "de",
    back-matter: [
        #bibliography(
            "/examples/bib/references.bib",
            style: "ieee",
        )
    ],
    appendix: [
        = Supplementary Material

        Numbered A.

        == Detail A.1

        Numbered A.1.
    ],
    title-page: doctoral-title-page.with(
        author-title: "M.Sc.",
        author-male: true,
    ),
)

= Chapter One

Content. @example2024
