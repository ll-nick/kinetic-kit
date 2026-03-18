// kit-thesis API Reference
// Generated with tidy (https://typst.app/universe/package/tidy)
//
// Compile from repo root:
//   typst compile --root . docs/main.typ docs/api-reference.pdf

#import "@preview/tidy:0.3.0"

#set document(title: "kit-thesis API Reference")
#set page(paper: "a4", margin: 2.5cm, numbering: "1")
#set text(font: "Libertinus Serif", size: 11pt)
#set heading(numbering: "1.1")

#align(center)[
    #text(size: 22pt, weight: "bold")[kit-thesis]
    #v(0.4em)
    #text(size: 14pt)[API Reference]
    #v(0.2em)
    #text(size: 10pt, fill: gray)[v0.1.0]
]

#v(1em)
#line(length: 100%)
#v(0.5em)

This document lists all public functions exported by `kit-thesis` with their parameters
and types, as extracted from the source doc-comments.

= Templates

#let dissertation-src = read("../src/dissertation.typ")
#let module = tidy.parse-module(dissertation-src, name: "dissertation")
#tidy.show-module(module, show-outline: true, sort-functions: false)

#let thesis-src = read("../src/thesis.typ")
#let thesis-module = tidy.parse-module(thesis-src, name: "thesis")
#tidy.show-module(thesis-module, show-outline: true, sort-functions: false)

= Utilities

#let content-page-src = read("../src/content-page.typ")
#let utils-module = tidy.parse-module(content-page-src, name: "content-page")
#tidy.show-module(utils-module, show-outline: true, sort-functions: false)
