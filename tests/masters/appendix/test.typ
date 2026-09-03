// Compile-only: thesis with an appendix — exercises the thesis() back-matter
// appendix branch and setup-appendix (A, A.1 numbering + counter reset).
#import "/lib.typ": thesis
#import "/examples/content/masters-title-page.typ": masters-title-page

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Thesis With Appendix],
    lang: "en",
    appendix: [
        = First Appendix

        Appendix content, numbered A.

        == A Detail

        Numbered A.1.

        = Second Appendix

        Numbered B.
    ],
    title-page: masters-title-page.with(
        thesis-type: "Masterarbeit",
    ),
)

= Introduction

Main content.
