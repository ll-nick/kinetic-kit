// Compile-only: thesis with an appendix — exercises the thesis() back-matter
// appendix branch and setup-appendix (A, A.1 numbering + counter reset).
#import "/lib.typ": print-thesis-title, thesis

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
    title-page: print-thesis-title.with(
        thesis-type: "Masterarbeit",
    ),
)

= Introduction

Main content.
