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

This document lists all public symbols exported by `kinetic-kit`.

= Templates

#let dissertation-src = read("../src/dissertation.typ")
#let module = tidy.parse-module(dissertation-src, name: "dissertation")
#tidy.show-module(module, show-outline: true, sort-functions: false)

#let thesis-src = read("../src/thesis.typ")
#let thesis-module = tidy.parse-module(thesis-src, name: "thesis")
#tidy.show-module(thesis-module, show-outline: true, sort-functions: false)

= Style Constants

The `kit-style` dictionary exposes the template's visual constants so that custom figures,
diagrams, and other content can match the document's typography and KIT color palette
exactly.

```typst
#import "@local/kinetic-kit:0.1.0": kit-style

#let font-sizes = kit-style.font-sizes-by-format.at("a5")
#set text(font: kit-style.fonts.sans, size: font-sizes.small)
#rect(fill: kit-style.colors.green15, stroke: kit-style.colors.green)
```

== Fonts

#table(
    columns: (auto, auto, 1fr),
    table.header([*Field*], [*Value*], [*Description*]),
    [`fonts.serif`], [`("Libertinus Serif",)`], [Serif body text],
    [`fonts.sans`], [`("Libertinus Sans",)`], [Sans-serif headings and headers],
    [`fonts.mono`], [`("Libertinus Mono",)`], [Code listings],
    [`leading`], [`0.75em`], [Paragraph line spacing (≈ 1.15× at 10 pt)],
)

== Font Sizes

`font-sizes-by-format` is a dictionary keyed by format string (`"a5"`, `"17x24"`, `"a4"`).
Each entry contains the sizes below. Access them with
`kit-style.font-sizes-by-format.at(format)`.

All fields are `length`. Example values shown for the `"a5"` format (10 pt base).

#table(
    columns: (auto, auto, auto, 1fr),
    table.header([*Field*], [*A5 / 17×24*], [*A4*], [*Description*]),
    [`base`], [`10pt`], [`11pt`], [Body text],
    [`chapter`], [`18pt`], [`25pt`], [Chapter heading (level 1)],
    [`section`], [`14pt`], [`17pt`], [Section heading (level 2)],
    [`subsection`], [`12pt`], [`14pt`], [Subsection heading (level 3)],
    [`subsubsection`], [`10pt`], [`11pt`], [Subsubsection heading (level 4+)],
    [`small`], [`8pt`], [`9pt`], [Running headers, footnotes, captions],
    [`footnote`], [`8pt`], [`9pt`], [Footnote text],
    [`title`], [`18pt`], [`25pt`], [Title page — document title],
    [`author`], [`14pt`], [`14pt`], [Title page — author name],
    [`title-info`], [`14pt`], [`14pt`], [Title page — info lines],
)

== Colors

All values are `color`. KIT brand colors follow a systematic naming scheme: base name plus
optional opacity suffix (`70`, `50`, `30`, `15` = 70 %, 50 %, 30 %, 15 % tint).

#table(
    columns: (auto, auto, 1fr),
    table.header([*Field*], [*Hex*], [*Description*]),
    [`colors.green`], [`#009682`], [KIT Green — primary brand color],
    [`colors.green70`], [`#4CB5A7`], [],
    [`colors.green50`], [`#7FCAC0`], [],
    [`colors.green30`], [`#B2DFD9`], [],
    [`colors.green15`], [`#D9EFEC`], [],
    [`colors.blue`], [`#4664AA`], [KIT Blue — links and accents],
    [`colors.blue70`], [`#7D92C3`], [],
    [`colors.blue50`], [`#A2B1D4`], [],
    [`colors.blue30`], [`#C7D0E5`], [],
    [`colors.blue15`], [`#E3E8F2`], [],
    [`colors.black`], [`#000000`], [],
    [`colors.black70`], [`#4D4D4D`], [],
    [`colors.black50`], [`#808080`], [],
    [`colors.black30`], [`#B3B3B3`], [],
    [`colors.black15`], [`#D9D9D9`], [],
    [`colors.palegreen`], [`#82BE3C`], [KIT extended palette],
    [`colors.yellow`], [`#FAE614`], [],
    [`colors.orange`], [`#DCA01E`], [],
    [`colors.brown`], [`#A08232`], [],
    [`colors.red`], [`#A01E28`], [],
    [`colors.lilac`], [`#A00078`], [],
    [`colors.cyanblue`], [`#50AAE6`], [],
    [`colors.keyword`], [`#0000C8`], [Syntax highlighting — keyword],
    [`colors.comment`], [`#3F7F5F`], [Syntax highlighting — comment],
    [`colors.string`], [`#700055`], [Syntax highlighting — string literal],
)

= Components

The `components` module exports the individual building blocks for assembling a document
without the full `dissertation()` / `thesis()` orchestrator. All symbols are accessed
through the `components` namespace:

```typst
#import "@local/kinetic-kit:0.1.0": components, kit-style

#let format = "a5"
#let font-sizes = kit-style.font-sizes-by-format.at(format)

#show: components.setup-page.with(format: format, margin-preset: "short", lang: "de")
#show: components.setup-front-matter
#components.print-toc(font-sizes, lang: "de")
```

You are responsible for applying the wrappers in the correct order: `setup-page` →
`setup-front-matter` → content → `setup-content` → (optionally) `setup-appendix`.

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

