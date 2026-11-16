// Doctoral thesis with appendix — pins the A, A.1, … numbering of headings,
// figures and equations, the Appendix supplement in references, the page-rules switch,
// and the appendix following the back matter.
#import "/lib.typ": doctoral-title-page, thesis

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Dissertation with Appendix],
    lang: "en",
    back-matter: [
        #bibliography(
            "/examples/bib/references.bib",
            style: "ieee",
        )
    ],
    appendix: [
        = Supplementary Material <app:supplementary>

        Numbered A.

        == Detail A.1

        Numbered A.1.

        #figure(rect(), caption: [Numbered A.1.])

        $ x = 1 $
    ],
    title-page: doctoral-title-page.with(
        author-title: "M.Sc.",
        author-male: true,
    ),
)

= Chapter One

Content. @example2024 See @app:supplementary.

#context assert(
    query(bibliography).first().location().page() < locate(<app:supplementary>).page(),
    message: "the appendix must follow the back matter",
)
