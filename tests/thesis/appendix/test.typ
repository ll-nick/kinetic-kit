// Compile-only: thesis with an appendix — exercises the thesis() back-matter
// appendix branch and setup-appendix (A, A.1 numbering + counter reset).
#import "/lib.typ": thesis

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Thesis With Appendix],
    thesis-type: "Masterarbeit",
    lang: "en",
    appendix: [
        = First Appendix

        Appendix content, numbered A.

        == A Detail

        Numbered A.1.

        = Second Appendix

        Numbered B.
    ],
)

= Introduction

Main content.
