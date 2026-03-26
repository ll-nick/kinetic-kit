// KIT Thesis Template — Full-featured English example
// Mirrors thesis-full.typ with lang: "en" and colored-links: false
// to verify English labels and black-link print output.
//
// Compile: typst compile --root . --font-path fonts examples/thesis-full-en.typ examples/thesis-full-en.pdf

#import "/lib.typ": flex-caption, thesis

// ── Third-party: glossarium ───────────────────────────────────────────────
// IMPORTANT: #show: make-glossary must come before #show: thesis.with(...)
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

// Must precede #show: thesis.with(...)
#show: make-glossary
#register-glossary(abbrevs)

// ── Third-party: drafting (margin annotations) ────────────────────────────
#import "@preview/drafting:0.2.2": margin-note, note-outline, set-margin-note-defaults
#let is-draft = true
#set-margin-note-defaults(hidden: not is-draft)

// ── Thesis ────────────────────────────────────────────────────────────────

#show: thesis.with(
    // ── Author ──────────────────────────────────────────────────────────────
    author-firstname: "Jane",
    author-surname: "Doe",

    // ── Title ───────────────────────────────────────────────────────────────
    title: [
        A Complete Master's Thesis Title --- Spanning Multiple Lines
    ],

    thesis-type: "Masterarbeit",

    // ── Institution ─────────────────────────────────────────────────────────
    department: "KIT-Fakultät für Maschinenbau",
    university-genitive: "des Karlsruher Instituts für Technologie (KIT)",

    // ── Supervisors ─────────────────────────────────────────────────────────
    examiner: "Prof. Dr.-Ing. Hans Musterbetreuer",
    supervisor: "M.Sc. Maria Musterbetreuerin",

    // ── Submission date ─────────────────────────────────────────────────────
    date-submitted: "01 March 2026",

    // ── Language: English ───────────────────────────────────────────────────
    lang: "en",

    // ── Layout ──────────────────────────────────────────────────────────────
    margin-preset: "short",
    binding-correction: 8mm,
    // Black links for print output
    colored-links: false,

    // ── Draft watermark ─────────────────────────────────────────────────────
    draft: is-draft,
    draft-info: "v0.1 — " + datetime.today().display("[day].[month].[year]"),

    // ── Front matter ────────────────────────────────────────────────────────
    abstract-en: include "content/abstract-en.typ",
    abstract-de: include "content/abstract-de.typ",
    acknowledgements: include "content/acknowledgements.typ",
    abbreviations: print-glossary(abbrevs),

    // ── Back matter ─────────────────────────────────────────────────────────
    show-lof: true,
    show-lot: true,
    show-lol: true,

    // ── Bibliography ────────────────────────────────────────────────────────
    bibliography: bibliography(
        "bib/references.bib",
        title: none,
        style: "ieee",
    ),

    // ── Appendix ─────────────────────────────────────────────────────────────
    appendix: [
        = Supplementary Material

        #lorem(400)
    ],
)

// ── Chapters ──────────────────────────────────────────────────────────────

= Introduction

This work was conducted at #gls("kit"). The results improve the #gls("rmse") by 50 %. On
second reference: #gls("kit") uses only the short form.

#margin-note[Expand this section.]

#include "content/features-en.typ"

#if is-draft { note-outline() }
