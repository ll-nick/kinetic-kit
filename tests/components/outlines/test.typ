// The title handling `setup-outlines` adds to Typst's own `outline`:
//   - omitted on a built-in kind → the localized name for the document language,
//   - given → used verbatim,
//   - `none` → no heading at all,
// and on the contents outline, Typst's own title, which must not list itself.
// The list-page headings are outlined, so the contents outline below names them.
#import "/lib.typ": flex-caption, thesis

#show: thesis.with(
    title: [Outline Titles],
    lang: "de",
    front-matter: [
        // Chapters only: the section below must not reach this outline.
        #outline(depth: 1)
    ],
    back-matter: [
        // Named by the template: Abbildungsverzeichnis.
        #outline(target: figure.where(kind: image))
        // Overridden.
        #outline(title: [Eigene Tabellenliste], target: figure.where(kind: table))
        // No heading of its own.
        = Quellcode
        #outline(title: none, target: figure.where(kind: raw))
    ],
)

= Erstes Kapitel

// Long enough to wrap in the contents: heading entries must not hyphenate at any
// level, while caption entries on the list pages must.
== Ein Abschnitt, der bei depth 1 fehlen muss und dessen Donaudampfschifffahrtsgesellschaft die Zeile umbricht

#figure(
    rect(width: 3cm, height: 1cm),
    caption: flex-caption(short: [Kurz], long: [Die lange Fassung der Beschriftung.]),
)

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
