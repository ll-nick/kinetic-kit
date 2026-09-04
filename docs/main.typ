// kinetic-kit API Reference
// Generated with tidy (https://typst.app/universe/package/tidy)
//
// Compile from repo root:
//   typst compile --root . docs/main.typ docs/api-reference.pdf

#import "@preview/tidy:0.3.0"

#set document(title: "kinetic-kit API Reference")
#set page(paper: "a4", margin: 2.5cm, numbering: "1")
#set text(font: "Libertinus Serif", size: 11pt)

// Number the manual section headings only; leave tidy's function headings
// unnumbered so they don't read as `1.1.1.1.1`.
#set heading(numbering: (..n) => if n.pos().len() <= 2 { numbering("1.1", ..n.pos()) })

// ── Custom tidy style, closer to the Typst reference docs ──────────────────
// Reuses the default style for everything except the signature block and the
// parameter blocks, which get a lighter, airier treatment: the signature in a
// tinted code box, each parameter separated by a hairline rule with the name in
// bold (not a heading, so parameters stay out of the document outline).

#let _default = tidy.styles.default

#let _show-signature(fn, style-args: (:)) = block(
    fill: luma(250),
    stroke: 0.5pt + luma(224),
    radius: 4pt,
    inset: (x: 1em, y: 0.85em),
    width: 100%,
    above: 0.6em,
    below: 1.4em,
    {
        set text(font: "DejaVu Sans Mono", size: 0.92em)
        text(fn.name, fill: rgb("#4b69c6"))
        "("
        let args = ()
        for (arg-name, info) in fn.args {
            if style-args.omit-private-parameters and arg-name.starts-with("_") {
                continue
            }
            let types = if "types" in info {
                (
                    ": "
                        + info
                            .types
                            .map(t => (style-args.style.show-type)(
                                t,
                                style-args: style-args,
                            ))
                            .join(" ")
                )
            }
            args.push(arg-name + types)
        }
        if args.len() <= 2 {
            args.join(", ")
        } else {
            "\n  " + args.join(",\n  ") + "\n"
        }
        ")"
        if fn.return-types != none {
            [ -> ]
            fn
                .return-types
                .map(t => (style-args.style.show-type)(
                    t,
                    style-args: style-args,
                ))
                .join(" ")
        }
    },
)

#let _show-param(
    name,
    types,
    content,
    style-args,
    show-default: false,
    default: none,
) = block(
    width: 100%,
    above: 1.4em,
    below: 1.4em,
    breakable: style-args.break-param-descriptions,
    {
        line(length: 100%, stroke: 0.5pt + luma(218))
        v(0.7em, weak: true)
        strong(raw(name, lang: none))
        h(0.7em)
        types
            .map(t => (style-args.style.show-type)(t, style-args: style-args))
            .join(
                text(size: 0.7em)[ or ],
            )
        parbreak()
        content
        if show-default {
            parbreak()
            text(size: 0.9em, fill: luma(110))[
                #style-args.local-names.default: #raw(lang: "typc", default)
            ]
        }
    },
)

#let api-style = (
    show-outline: _default.show-outline,
    show-type: _default.show-type,
    show-function: _default.show-function,
    show-variable: _default.show-variable,
    show-reference: _default.show-reference,
    show-example: _default.show-example,
    show-parameter-list: _show-signature,
    show-parameter-block: _show-param,
)

// Render one source module's doc-comments. `filter` optionally restricts which
// functions are shown. `show-module-name: false` drops the redundant wrapper
// heading; `show-outline: false` drops the per-module bullet list (the page has
// its own outline below).
#let api-module(path, name, filter: f => true) = {
    let module = tidy.parse-module(read(path), name: name)
    module.functions = module.functions.filter(filter)
    tidy.show-module(
        module,
        style: api-style,
        show-outline: false,
        show-module-name: false,
        sort-functions: false,
        break-param-descriptions: true,
    )
}

#align(center)[
    #text(size: 22pt, weight: "bold")[kinetic-kit]
    #v(0.4em)
    #text(size: 14pt)[API Reference]
    #v(0.2em)
    #text(size: 10pt, fill: gray)[v0.1.1]
]

#v(1em)
#line(length: 100%)
#v(0.5em)

This document lists all public symbols exported by `kinetic-kit`.

#outline(title: none, indent: auto, depth: 2)

= Template

`thesis()` is the main entrypoint of the package. By default, it assembles a complete
doctoral thesis in the KSP-approved style. The template is fully configurable and can also
be used to produce a bachelor's or master's thesis. Note that the KSP endorsement only
applies to doctoral theses in the default configuration; customized documents are not
covered by it.

#api-module("../src/thesis.typ", "thesis")

= Style Constants

The `kit-style` dictionary exposes the template's visual constants so that custom figures,
diagrams, and other content can match the document's typography and KIT color palette
exactly.

```typst
#import "@preview/kinetic-kit:0.1.1": kit-style

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

= Title Page <title-page>

`doctoral-title-page` is the default `title-page`. It owns every parameter printed on the
page. Pass `doctoral-title-page.with(..)` to configure it, or your own content / function
for anything else.

#api-module("../src/title-page.typ", "title-page")

= Outlines

The `outlines` namespace holds the sections whose body the template generates: the table
of contents and the back-matter list pages. Place them inside the `front-matter` /
`back-matter` content of `thesis()`.

```typst
#import "@preview/kinetic-kit:0.1.1": outlines, thesis

#show: thesis.with(
  front-matter: [
    = Kurzfassung
    …
    #outlines.table-of-contents()
  ],
  back-matter: [
    #outlines.list-of-figures()
    #outlines.list-of("algorithm", [Algorithmenverzeichnis])
    #bibliography("refs.bib", title: [Literaturverzeichnis], style: "ieee")
  ],
)
```

#api-module("../src/outlines.typ", "outlines", filter: f => f.name != "setup-outlines")

= Figure Captions

#api-module("../src/figures.typ", "figures", filter: f => f.name == "flex-caption")

= Figure Kinds

Typst keeps a separate counter and supplement for every figure `kind`. The template
carries strings for Typst's own `image`, `table` and `raw`. Any other kind — pseudocode,
theorems, whatever a document needs — is declared through the `figure-kinds` parameter of
`thesis()`, which supplies the caption supplement. Its list page, if you want one, is a
`#outlines.list-of("algorithm", [List of Algorithms])` call in `back-matter`.

Each entry is a dictionary with `kind` and `supplement`. `supplement` takes either one
value or one per language:

```typst
#show: thesis.with(
  figure-kinds: (
    (kind: "algorithm", supplement: (de: [Algorithmus], en: [Algorithm])),
    (kind: "theorem",   supplement: [Theorem]),
  ),
)
```

Per-chapter counter resets are automatic: they are derived from the figures present in the
document, so every kind restarts each chapter whether or not it has been declared.

