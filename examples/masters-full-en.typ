// KIT Master's Thesis — Full-featured English example
// Mirrors masters-full.typ with lang: "en" and colored-links: false
// to verify English labels and black-link print output.
//
// Compile: typst compile --root . --font-path fonts examples/masters-full-en.typ examples/masters-full-en.pdf

#import "/lib.typ": thesis
#import "content/masters-title-page.typ": masters-title-page
#import "content/abbreviations.typ": abbrevs-glossary

// ── Third-party: glossarium ───────────────────────────────────────────────
// IMPORTANT: #show: make-glossary must come before #show: thesis.with(...)
// so the show rule wraps the entire rendered document.
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary

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
#import "@preview/drafting:0.2.2": inline-note, note-outline, set-margin-note-defaults
#let is-draft = true
#set-margin-note-defaults(hidden: not is-draft)

// ── Thesis ────────────────────────────────────────────────────────────────

#show: thesis.with(
    // ── Metadata ───────────────────────────────────────────────────────────
    lang: "en",
    author-firstname: "Jane",
    author-surname: "Doe",
    title: [
        A Complete Master's Thesis Title --- Spanning Multiple Lines
    ],
    title-page: masters-title-page.with(
        thesis-type: "Masterarbeit",

        // ── Institution ─────────────────────────────────────────────────────────
        department: "KIT-Fakultät für Maschinenbau",
        university-genitive: "des Karlsruher Instituts für Technologie (KIT)",

        // ── Supervisors ─────────────────────────────────────────────────────────
        examiner: "Prof. Dr.-Ing. Hans Musterbetreuer",
        supervisor: "M.Sc. Maria Musterbetreuerin",

        // ── Submission date ─────────────────────────────────────────────────────
        date-submitted: "01 March 2026",
    ),

    // ── Content ────────────────────────────────────────────────────────────
    front-matter: [
        = Acknowledgements
        #include "content/acknowledgements.typ"

        #include "content/abstract-en.typ"
        #include "content/abstract-de.typ"

        = Notation
        #include "content/notation.typ"

        = List of Abbreviations
        #abbrevs-glossary(abbrevs)

        #outline()
    ],

    appendix: [
        = Supplementary Material

        #lorem(400)
    ],

    back-matter: [
        #outline(target: figure.where(kind: image))
        #outline(target: figure.where(kind: table))
        #outline(target: figure.where(kind: raw))

        #bibliography("bib/references.bib", style: "ieee")
    ],

    // ── Formatting ─────────────────────────────────────────────────────────
    margin-preset: "short",
    colored-links: false, // black links for print output

    // ── Draft watermark ────────────────────────────────────────────────────
    draft: is-draft,
    draft-info: "v0.1 — " + datetime.today().display("[day].[month].[year]"),
)

// ── Chapters ──────────────────────────────────────────────────────────────

= Introduction

// Abbreviations expand on first use. Both @key and #gls("key") syntax are supported.
This work was conducted at @kit and published via @ksp. The results improve the @rmse by
50 %. The system model is an @ode. On second reference, @kit uses only the short form.

#inline-note[Expand this section.]

#include "content/features-en.typ"

#if is-draft { note-outline() }
