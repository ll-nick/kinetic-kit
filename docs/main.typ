// kinetic-kit API Reference
// Generated with tidy (https://typst.app/universe/package/tidy)
//
// Compile from repo root:
//   typst compile --root . docs/main.typ docs/api-reference.pdf

#import "@preview/tidy:0.3.0"

#set document(title: "kinetic-kit API Reference")
#set page(paper: "a4", margin: 2.5cm, numbering: "1")
#set text(font: "Libertinus Serif", size: 11pt)
#set heading(numbering: "1.1")

#align(center)[
    #text(size: 22pt, weight: "bold")[kinetic-kit]
    #v(0.4em)
    #text(size: 14pt)[API Reference]
    #v(0.2em)
    #text(size: 10pt, fill: gray)[v0.1.0]
]

#v(1em)
#line(length: 100%)
#v(0.5em)

This document lists all public functions exported by `kinetic-kit` with their parameters
and types, as extracted from the source doc-comments.

= Templates

#let dissertation-src = read("../src/dissertation.typ")
#let module = tidy.parse-module(dissertation-src, name: "dissertation")
#tidy.show-module(module, show-outline: true, sort-functions: false)

#let thesis-src = read("../src/thesis.typ")
#let thesis-module = tidy.parse-module(thesis-src, name: "thesis")
#tidy.show-module(thesis-module, show-outline: true, sort-functions: false)

= Components

Individual building blocks for custom document composition. Import only what you need.

== Page Setup

#let page-setup-src = read("../src/page-setup.typ")
#let page-setup-module = tidy.parse-module(page-setup-src, name: "page-setup")
#tidy.show-module(page-setup-module, show-outline: true, sort-functions: false)

== Title Pages

#let title-page-src = read("../src/title-page.typ")
#let title-page-module = tidy.parse-module(title-page-src, name: "title-page")
#tidy.show-module(title-page-module, show-outline: true, sort-functions: false)

== Outlines

#let outlines-src = read("../src/outlines.typ")
#let outlines-module = tidy.parse-module(outlines-src, name: "outlines")
#tidy.show-module(outlines-module, show-outline: true, sort-functions: false)

