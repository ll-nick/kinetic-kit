// Compile-only: figure kinds beyond image/table/raw — kinds declared by the
// document with per-language and single-value supplements, per-chapter counter
// resets for all of them, and hand-placed back-matter list pages.
#import "/lib.typ": outlines, thesis

#let box-body = rect(width: 3cm, height: 1cm)

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Eigene Abbildungsarten],
    lang: "de",
    figure-kinds: (
        // Declared by this document, with one string per language.
        (kind: "algorithm", supplement: (de: [Algorithmus], en: [Algorithm])),
        (kind: "theorem", supplement: (de: [Satz], en: [Theorem])),
        (kind: "recipe", supplement: (de: [Rezept], en: [Recipe])),
        // A single value stands in for every language.
        (kind: "vignette", supplement: [Vignette]),
    ),
    back-matter: [
        #outlines.list-of-figures()
        #outlines.list-of-tables()
        #outlines.list-of-listings()
        #outlines.list-of("algorithm", [Algorithmenverzeichnis])
        #outlines.list-of("theorem", [Satzverzeichnis])
    ],
)

= Erstes Kapitel

#figure(box-body, caption: [Ein Bild])
#figure(
    table(
        columns: 2,
        [a], [b],
    ),
    caption: [Eine Tabelle],
)
#figure(
    ```py
    print("hello")
    ```,
    caption: [Ein Quellcode],
)
#figure(box-body, kind: "algorithm", caption: [Ein Algorithmus])
#figure(box-body, kind: "algorithm", caption: [Noch ein Algorithmus])
#figure(box-body, kind: "theorem", caption: [Ein Satz])
#figure(box-body, kind: "recipe", caption: [Ein Rezept])
#figure(box-body, kind: "vignette", caption: [Eine Vignette])

// Pseudocode set as a raw block needs its kind spelled out: Typst would
// otherwise infer `kind: raw` and file it under the listings.
#figure(
    ```
    1: x <- 1
    2: return x
    ```,
    kind: "algorithm",
    caption: [Pseudocode als Raw-Block],
)

// What third-party pseudocode packages emit: an explicit `supplement`, which
// beats the template's show-set rule and so has to be localized here.
#figure(
    box-body,
    kind: "algorithm",
    supplement: [Algorithmus],
    caption: [Aus einem Fremdpaket],
)

= Zweites Kapitel

// Every counter restarts here, not only the three built-in kinds.
#figure(box-body, caption: [Bild im zweiten Kapitel])
#figure(box-body, kind: "algorithm", caption: [Algorithmus im zweiten Kapitel])
#figure(box-body, kind: "theorem", caption: [Satz im zweiten Kapitel])
#figure(box-body, kind: "recipe", caption: [Rezept im zweiten Kapitel])

Querverweise: @alg-two, @thm-two.

#figure(box-body, kind: "algorithm", caption: [Referenzziel]) <alg-two>
#figure(box-body, kind: "theorem", caption: [Referenzziel]) <thm-two>
