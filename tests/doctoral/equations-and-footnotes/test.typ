// Equation, figure and footnote numbering, none of which the other tests touch.
// A chapter numbers equations and figures `(1.1)` / `1.1`, and every counter
// restarts at the next one. Front and back matter sit outside the chapters, so
// their equations and figures carry no number, in the caption and the list of
// figures alike.
#import "/lib.typ": thesis

#show: thesis.with(
    title: [Numbered Elements],
    lang: "en",
    front-matter: [
        = Abstract

        Before the first chapter, so this equation is unnumbered:
        $ a = b $

        #figure(rect(width: 3cm, height: 1cm), caption: [A figure in front matter])

        #outline()
    ],
    back-matter: [
        #outline(target: figure.where(kind: image))

        = Notes

        #figure(rect(width: 3cm, height: 1cm), caption: [A figure in back matter])
    ],
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
