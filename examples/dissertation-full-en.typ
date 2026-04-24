// KIT Dissertation Template — Full-featured English example
// Mirrors dissertation-full.typ with lang: "en" and a female author
// (author-male: false) to verify gendered German title page strings.
//
// Compile: typst compile --root . --font-path fonts examples/dissertation-full-en.typ examples/dissertation-full-en.pdf

#import "/lib.typ": dissertation, flex-caption

// ── Third-party: glossarium ───────────────────────────────────────────────
// IMPORTANT: #show: make-glossary must come before #show: dissertation.with(...)
// so the show rule wraps the entire rendered document.
#import "@preview/glossarium:0.5.10": (
    gls, glspl, make-glossary, print-glossary, register-glossary,
)

#let abbrevs = (
    (key: "kit", short: "KIT", long: "Karlsruhe Institute of Technology"),
    (key: "ksp", short: "KSP", long: "KIT Scientific Publishing"),
    (key: "ode", short: "ODE", long: "Ordinary Differential Equation"),
    (key: "rmse", short: "RMSE", long: "Root Mean Square Error"),
)

#show: make-glossary
#register-glossary(abbrevs)

// ── Third-party: alexandria (multi-bibliography) ──────────────────────────
#import "@preview/alexandria:0.2.2": alexandria, bibliographyx
#show: alexandria(prefix: "p:", read: path => read(path))
#show: alexandria(prefix: "t:", read: path => read(path))

// ── Third-party: drafting (margin annotations) ────────────────────────────
#import "@preview/drafting:0.2.2": margin-note, note-outline, set-margin-note-defaults
#let is-draft = true
#set-margin-note-defaults(hidden: not is-draft)

// ── Dissertation ──────────────────────────────────────────────────────────

#show: dissertation.with(
    // ── Author ──────────────────────────────────────────────────────────────
    author-title: "M.Sc.",
    author-firstname: "Jane",
    author-surname: "Doe",
    // false = feminine grammatical forms on the German title page
    author-male: false,

    // ── Title ───────────────────────────────────────────────────────────────
    title: [
        A Complete Dissertation Title --- Spanning Multiple Lines
    ],

    // ── Degree ──────────────────────────────────────────────────────────────
    doc-degree: "Doktors der Ingenieurwissenschaften (Dr.-Ing.)",
    doc-degree-f: "Doktorin der Ingenieurwissenschaften (Dr.-Ing.)",

    // ── Institution ─────────────────────────────────────────────────────────
    department: "KIT-Fakultät für Maschinenbau",
    university-genitive: "des Karlsruher Instituts für Technologie (KIT)",

    // ── Language: English ───────────────────────────────────────────────────
    // Body text labels (TOC, LoF, bibliography heading, …) are in English.
    // The title page always uses German strings regardless of lang.
    lang: "en",

    // ── Layout ──────────────────────────────────────────────────────────────
    margin-preset: "medium",
    binding-correction: 5mm, // Add BCOR for physically bound print copies
    colored-links: true,

    // ── Status: submitted ───────────────────────────────────────────────────
    status-approved: false,

    // ── Draft watermark ─────────────────────────────────────────────────────
    draft: is-draft,
    draft-info: "v0.1 — " + datetime.today().display("[day].[month].[year]"),

    // ── Front matter ────────────────────────────────────────────────────────
    abstract-en: include "content/abstract-en.typ",
    abstract-de: include "content/abstract-de.typ",
    acknowledgements: include "content/acknowledgements.typ",
    notation: include "content/notation.typ",
    abbreviations: print-glossary(abbrevs),

    // ── Back matter ─────────────────────────────────────────────────────────
    show-lof: true,
    show-lot: true,
    show-lol: true,

    own-publications: bibliographyx(
        "bib/own-publications.bib",
        prefix: "p:",
        title: none,
        style: "ieee",
        full: true,
    ),
    supervised-theses: bibliographyx(
        "bib/supervised-theses.bib",
        prefix: "t:",
        title: none,
        style: "ieee",
        full: true,
    ),
    own-patents: [
        Doe, J. (2024). *A Method for Optimising Sample Processes*. Deutsches Patent- und
        Markenamt, DE 10 2024 000 002 A1.
    ],

    // ── Bibliography ────────────────────────────────────────────────────────
    bibliography: bibliography(
        "bib/references.bib",
        title: none,
        style: "ieee",
    ),

    // ── Appendix ─────────────────────────────────────────────────────────────
    appendix: [
        = Supplementary Material

        #lorem(800)
    ],
)

= A First Example Chapter

// gls() expands to "Karlsruhe Institute of Technology (KIT)" on first use,
// then "KIT" on subsequent uses. glspl() uses the plural form.
This work was conducted at #gls("kit") and published via #gls("ksp"). The results improve
the #gls("rmse") by 50 %. On second reference: #gls("kit") uses only the short form.

#margin-note[Expand this section.]

#include "content/features-en.typ"
#include "content/chapters-en.typ"

#if is-draft { note-outline() }
