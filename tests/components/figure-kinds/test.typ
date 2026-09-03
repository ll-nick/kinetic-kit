// Compile-only: figure kinds on the components path — `setup-page` supplies the
// supplements, and the list pages are placed by hand with `list-of` rather
// than by the back matter of `dissertation()`.
#import "/lib.typ": components, flex-caption

#let box-body = rect(width: 3cm, height: 1cm)

#show: components.setup-page.with(
    margin-preset: "short",
    lang: "de",
    figure-kinds: (
        (
            kind: "algorithm",
            supplement: (de: [Algorithmus], en: [Algorithm]),
            list-title: (de: [Algorithmenverzeichnis], en: [List of Algorithms]),
            show-list: true,
        ),
        (
            kind: "theorem",
            supplement: (de: [Satz], en: [Theorem]),
            list-title: (de: [Satzverzeichnis], en: [List of Theorems]),
            show-list: true,
        ),
    ),
)

#show: components.setup-front-matter

#components.table-of-contents(lang: "de")

#show: components.setup-content

= Einleitung

#figure(box-body, kind: "algorithm", caption: [Ein Algorithmus])
#figure(
    box-body,
    kind: "theorem",
    caption: flex-caption(short: [Kurzer Satz], long: [Ein Satz mit langer
        Unterschrift.]),
)

= Zweites Kapitel

#figure(box-body, kind: "algorithm", caption: [Algorithmus im zweiten Kapitel])
#figure(box-body, kind: "theorem", caption: [Satz im zweiten Kapitel])

// `list-of` sets the state that switches `flex-caption` to its short form;
// a hand-written `outline(target: …)` would not.
#components.list-of("algorithm", title: [Algorithmenverzeichnis])
#components.list-of("theorem", title: [Satzverzeichnis])
