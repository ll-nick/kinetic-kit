// Compile-only: figure kinds in an English document — per-language dictionaries
// must resolve to `en`, the `show-lo*` booleans alone govern the built-in list
// pages, and a document kind's list page follows them.
#import "/lib.typ": dissertation

#let box-body = rect(width: 3cm, height: 1cm)

#show: dissertation.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Custom Figure Kinds],
    lang: "en",
    show-lol: true,
    figure-kinds: (
        (
            kind: "algorithm",
            supplement: (de: [Algorithmus], en: [Algorithm]),
            list-title: (de: [Algorithmenverzeichnis], en: [List of Algorithms]),
            show-list: true,
        ),
        // A single value stands in for every language.
        (kind: "vignette", supplement: [Vignette]),
    ),
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
