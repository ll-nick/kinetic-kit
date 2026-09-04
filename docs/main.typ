// kinetic-kit API Reference
// Generated with tidy (https://typst.app/universe/package/tidy)
//
// Compile from repo root:
//   typst compile --root . docs/main.typ docs/api-reference.pdf

#import "@preview/tidy:0.4.3"

#import "../src/kit-colors.typ": kit-colors
#import "../src/outlines.typ": setup-outlines, table-of-contents
#import "../src/typography.typ": font-sizes-by-format, fonts, leading

#let version = toml("../typst.toml").package.version

#set document(title: "kinetic-kit API Reference")
#set page(paper: "a4", margin: 2.5cm, numbering: "1")
#set text(font: "Libertinus Serif", size: 11pt)

// The template's own outline styling, so the reference matches the thesis.
#show: setup-outlines

// Chapters and subsections carry numbers; tidy's parameter blocks sit deeper.
#set heading(numbering: (..n) => if n.pos().len() <= 2 { numbering("1.1", ..n.pos()) })

// Without a fill, tidy's cross-references are indistinguishable from body text.
#show link: set text(fill: kit-colors.blue)

// The default weights every level almost identically, which flattens the
// hierarchy. Definitions sit at these levels too — see `api-module`.
#show heading.where(level: 1): set text(font: "Libertinus Sans", size: 16pt)
#show heading.where(level: 2): set text(font: "Libertinus Sans", size: 13pt)
#show heading.where(level: 1): set block(below: 1.4em)
#show heading.where(level: 2): set block(above: 2.2em, below: 1.1em)

// Number and body in a two-column grid, as the template does, so heading text
// starts at the same x across levels. Deeper levels are tidy's parameter blocks,
// which its own style lays out.
#show heading: it => context {
    if it.level > 2 { return it }
    let number = numbering(
        it.numbering,
        ..counter(heading).at(it.location()).slice(0, it.level),
    )
    grid(
        columns: (0.95cm, 1fr),
        column-gutter: 0.35em,
        number, it.body,
    )
}

// One label namespace across all modules, so a doc-comment can reference a
// definition in another module. An empty prefix disables cross-referencing.
#let api-prefix = "api-"

// `level` is the heading level each definition gets, so a module holding a single
// definition can occupy a chapter of its own instead of nesting under one.
#let api-module(path, name, filter: definition => true, level: 1) = {
    // The signature block sits directly below tidy's "Parameters" heading and
    // says the same thing. Dropping it from the outline needs its own rule.
    show heading.where(level: level + 1): set heading(outlined: false)
    show heading.where(level: level + 1): none
    // Definition names are code, and would otherwise inherit the prose heading font.
    show heading.where(level: level): set text(font: "DejaVu Sans Mono")

    // A show rule cannot do this: tidy returns its output in a block, and
    // pagebreaks are illegal inside containers.
    if level == 1 { pagebreak(weak: true) }

    let module = tidy.parse-module(read(path), name: name, label-prefix: api-prefix)
    module.functions = module.functions.filter(filter)
    module.variables = module.variables.filter(filter)
    tidy.show-module(
        module,
        first-heading-level: level - 1,
        show-outline: false,
        show-module-name: false,
        sort-functions: none,
        break-param-descriptions: true,
    )
}

// `@` cannot reference tidy's labels from prose: functions are labelled `name()`,
// and parameter labels land on a `strong`, which is not referenceable.
#let api-link(target, display: auto) = link(
    label(api-prefix + target),
    raw(if display == auto { target } else { display }, lang: none),
)

// ── Cover ─────────────────────────────────────────────────────────────────

#align(center)[
    #v(1cm)
    #text(font: "Libertinus Sans", size: 26pt, weight: "bold")[kinetic-kit]
    #v(0.4em)
    #text(font: "Libertinus Sans", size: 15pt)[API Reference]
    #v(0.3em)
    #text(size: 10pt, fill: luma(110))[
        v#version · #link(
            "https://github.com/ll-nick/kinetic-kit",
        )[github.com/ll-nick/kinetic-kit]
    ]
]

#v(1.2em)
#line(length: 100%, stroke: 0.5pt + luma(180))
#v(1em)

Every public symbol exported by `kinetic-kit`, generated from the doc-comments in the
source.

#block(
    fill: kit-colors.blue15,
    stroke: 0.5pt + kit-colors.blue50,
    radius: 4pt,
    inset: (x: 1em, y: 0.85em),
    width: 100%,
    [
        Everything is imported from the package root:

        #raw(
            lang: "typst",
            "#import \"@preview/kinetic-kit:"
                + version
                + "\": doctoral-title-page, flex-caption, kit-style, outlines, thesis",
        )
    ],
)

#v(0.5em)
#[
    // Outline entries are links too; the cross-reference fill would tint the page.
    #show link: set text(fill: black)
    #table-of-contents(title: none, depth: 2)
]

#api-module("../src/thesis.typ", "thesis")

#api-module("../src/title-page.typ", "title-page")

#pagebreak(weak: true)

= Outlines

The `outlines` namespace holds the sections whose body the template generates: the table
of contents and the back-matter list pages. Place them inside the #api-link(
    "thesis.front-matter",
) / #api-link("thesis.back-matter") content of #api-link("thesis()").

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

#api-module(
    "../src/outlines.typ",
    "outlines",
    filter: definition => definition.name != "setup-outlines",
    level: 2,
)

#api-module(
    "../src/figures.typ",
    "figures",
    filter: definition => definition.name == "flex-caption",
)

#pagebreak(weak: true)

= Figure Kinds

Typst keeps a separate counter and supplement for every figure `kind`. The template
carries strings for Typst's own `image`, `table` and `raw`. Any other kind --- pseudocode,
theorems, whatever a document needs --- is declared through #api-link(
    "thesis.figure-kinds",
), which supplies the caption supplement. Its list page, if you want one, is a #api-link(
    "list-of()",
) call in #api-link("thesis.back-matter").

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

#api-module("../lib.typ", "lib", filter: definition => definition.name == "kit-style")

```typst
#import "@preview/kinetic-kit:0.1.1": kit-style

#let font-sizes = kit-style.font-sizes-by-format.at("a5")
#set text(font: kit-style.fonts.sans, size: font-sizes.small)
#rect(fill: kit-style.colors.green15, stroke: kit-style.colors.green)
```

// The tables below are built from the imported values rather than typed out, so
// a new color or a changed size shows up here without an edit.

#let field(name) = raw(name, lang: none)

== Fonts

#let font-roles = (
    serif: [Body text],
    sans: [Headings and running headers],
    mono: [Code listings],
)

#table(
    columns: (auto, auto, 1fr),
    align: (left, left, left),
    table.header([*Field*], [*Value*], [*Description*]),
    ..for (role, families) in fonts {
        (
            field("fonts." + role),
            raw(repr(families), lang: none),
            font-roles.at(role, default: []),
        )
    },
    field("leading"),
    raw(repr(leading), lang: none),
    [Paragraph line spacing (#sym.approx 1.15#sym.times at 10 pt)],
)

== Font Sizes

#field("font-sizes-by-format") is keyed by format string. Reach the sizes for one format
with `kit-style.font-sizes-by-format.at(format)`. All values are `length`.

#let size-roles = (
    base: [Body text],
    chapter: [Chapter heading (level 1)],
    section: [Section heading (level 2)],
    subsection: [Subsection heading (level 3)],
    subsubsection: [Subsubsection heading (level 4+)],
    title: [Title page --- document title],
    author: [Title page --- author name],
    "title-info": [Title page --- info lines],
    small: [Running headers, footnotes, captions],
    footnote: [Footnote text],
)

#let formats = font-sizes-by-format.keys()

#table(
    columns: (auto,) + (auto,) * formats.len() + (1fr,),
    align: (left,) + (right,) * formats.len() + (left,),
    table.header(
        [*Field*],
        ..formats.map(format => raw("\"" + format + "\"", lang: none)),
        [*Description*],
    ),
    ..for role in font-sizes-by-format.at(formats.first()).keys() {
        (
            field(role),
            ..formats.map(format => raw(
                repr(font-sizes-by-format.at(format).at(role)),
                lang: none,
            )),
            size-roles.at(role, default: []),
        )
    },
)

== Colors

KIT brand colors follow a systematic naming scheme: a base name plus an optional opacity
suffix (`70`, `50`, `30`, `15` = 70 %, 50 %, 30 %, 15 % tint). All values are `color`.

#let color-roles = (
    green: [KIT Green --- primary brand color],
    blue: [KIT Blue --- links and accents],
    palegreen: [KIT extended palette],
    keyword: [Syntax highlighting --- keyword],
    comment: [Syntax highlighting --- comment],
    string: [Syntax highlighting --- string literal],
)

// A trailing 70/50/30/15 marks a tint of the base color of the same name.
#let tint-description(name) = {
    let tint = name.trim(regex("[a-z]+"), at: start)
    if tint == "" { return [] }
    [#tint\u{202f}% tint of #raw("colors." + name.trim(tint, at: end), lang: none)]
}

#let swatch(value) = box(
    width: 1em,
    height: 1em,
    baseline: 0.15em,
    radius: 2pt,
    fill: value,
    stroke: 0.4pt + luma(160),
)

#table(
    columns: (auto, auto, auto, 1fr),
    align: (left, center, left, left),
    table.header([*Field*], [], [*Hex*], [*Description*]),
    ..for (name, value) in kit-colors {
        (
            field("colors." + name),
            swatch(value),
            raw(upper(value.to-hex()), lang: none),
            color-roles.at(name, default: tint-description(name)),
        )
    },
)
