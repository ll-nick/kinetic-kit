// Compile-only: figure kinds in an English document — per-language dictionaries
// must resolve to `en`, a single-value supplement stands in for every language,
// and a passage in another language keeps its own supplement while the
// hand-placed list page stays English.
#import "/lib.typ": thesis

#let box-body = rect(width: 3cm, height: 1cm)

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Custom Figure Kinds],
    lang: "en",
    figure-kinds: (
        (kind: "algorithm", supplement: (de: [Algorithmus], en: [Algorithm])),
        // A single value stands in for every language.
        (kind: "vignette", supplement: [Vignette]),
    ),
    back-matter: [
        #outline(target: figure.where(kind: raw))
        #outline(title: [List of Algorithms], target: figure.where(kind: "algorithm"))
    ],
)

= First Chapter

#figure(box-body, caption: [An image])
#figure(
    ```py
    print("hello")
    ```,
    caption: [A listing],
)
#figure(box-body, kind: "algorithm", caption: [An algorithm])
#figure(box-body, kind: "vignette", caption: [A vignette])

= Second Chapter

#figure(box-body, kind: "algorithm", caption: [An algorithm in chapter two])

// A passage in another language: supplements follow `text.lang`, so this figure
// is captioned "Algorithmus" while the list page stays English.
#[
    #set text(lang: "de")
    #figure(box-body, kind: "algorithm", caption: [Ein deutscher Einschub])
]
