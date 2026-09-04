// Equation, figure and footnote numbering, none of which the other tests touch.
// Both branches of the chapter-relative numbering matter: front matter sits
// before the first chapter, where the counter is 0 and the numbers fall back to
// a flat `(1)` / `1`, while a chapter numbers them `(1.1)` / `1.1` and every
// counter restarts at the next one.
#import "/lib.typ": outlines, thesis

#show: thesis.with(
    title: [Numbered Elements],
    lang: "en",
    front-matter: [
        = Abstract

        Before the first chapter, so this equation is numbered flat:
        $ a = b $

        #figure(rect(width: 3cm, height: 1cm), caption: [A figure in front matter])

        #outlines.table-of-contents()
    ],
    back-matter: [#outlines.list-of-figures()],
)

= First Chapter

$ c = d $ <eq-first>

#figure(rect(width: 3cm, height: 1cm), caption: [A figure])

A short footnote.#footnote[One line.]

A long one.#footnote[
    #lorem(60)
]

= Second Chapter

Counters restart here.

$ e = f $

#figure(rect(width: 3cm, height: 1cm), caption: [Another figure])

Footnote numbering restarts too.#footnote[Back to one.]

A reference across chapters: @eq-first.
