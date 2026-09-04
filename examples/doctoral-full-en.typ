// KIT Doctoral Thesis — Full-featured English example
// Mirrors doctoral-full.typ with lang: "en" and a female author
// (author-male: false) to verify gendered German title page strings.
//
// Compile: typst compile --root . --font-path fonts examples/doctoral-full-en.typ examples/doctoral-full-en.pdf

#import "/lib.typ": doctoral-title-page, flex-caption, outlines, thesis
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

#show: make-glossary
#register-glossary(abbrevs)

// ── Third-party: drafting (margin annotations) ────────────────────────────
#import "@preview/drafting:0.2.2": inline-note, note-outline, set-margin-note-defaults
#let is-draft = true
#set-margin-note-defaults(hidden: not is-draft)

// ── Dissertation ──────────────────────────────────────────────────────────

#show: thesis.with(
    // ── Metadata ───────────────────────────────────────────────────────────
    // Body text labels (TOC, LoF, bibliography heading, …) follow `lang`.
    // The title page always uses German strings regardless of it.
    lang: "en",
    author-firstname: "Jane",
    author-surname: "Doe",
    title: [
        A Complete Dissertation Title --- Spanning Multiple Lines
    ],
    title-page: doctoral-title-page.with(
        // ── Author ──────────────────────────────────────────────────────────────
        author-title: "M.Sc.",
        // false = feminine grammatical forms on the German title page
        author-male: false,

        // ── Degree ──────────────────────────────────────────────────────────────
        doc-degree: "Doktors der Ingenieurwissenschaften (Dr.-Ing.)",
        doc-degree-f: "Doktorin der Ingenieurwissenschaften (Dr.-Ing.)",

        // ── Institution ─────────────────────────────────────────────────────────
        department: "KIT-Fakultät für Maschinenbau",
        university-genitive: "des Karlsruher Instituts für Technologie (KIT)",

        // ── Status: submitted ───────────────────────────────────────────────────
        status-approved: false,
    ),

    // ── Content ────────────────────────────────────────────────────────────
    // The German Kurzfassung required for an English thesis (Promotionsordnung
    // §10) lives in abstract-de.typ, which sets `lang: "de"` for correct
    // hyphenation.
    front-matter: [
        = Acknowledgements
        #include "content/acknowledgements.typ"

        #include "content/abstract-en.typ"
        #include "content/abstract-de.typ"

        = Notation
        #include "content/notation.typ"

        = List of Abbreviations
        #abbrevs-glossary(abbrevs)

        #outlines.table-of-contents()
    ],

    appendix: [
        = Supplementary Material

        #lorem(800)
    ],

    back-matter: [
        #outlines.list-of-figures()
        #outlines.list-of-tables()
        #outlines.list-of-listings()

        #bibliography("bib/references.bib", title: [Bibliography], style: "ieee")

        = Own Publications
        #bibliography("bib/own-publications.bib", title: none, style: "ieee", full: true)

        = Patents
        Doe, J. (2024). *A Method for Optimising Sample Processes*. Deutsches Patent- und
        Markenamt, DE 10 2024 000 002 A1.

        = Supervised Student Theses
        #bibliography("bib/supervised-theses.bib", title: none, style: "ieee", full: true)
    ],

    // ── Formatting ─────────────────────────────────────────────────────────
    margin-preset: "medium",
    binding-correction: 5mm, // Add BCOR for physically bound print copies
    colored-links: true,

    // ── Draft watermark ────────────────────────────────────────────────────
    draft: is-draft,
    draft-info: "v0.1 — " + datetime.today().display("[day].[month].[year]"),
)

= A First Example Chapter

// Abbreviations expand on first use. Both @key and #gls("key") syntax are supported.
// First use: "Karlsruhe Institute of Technology (KIT)", subsequent: "KIT".
This work was conducted at @kit and published via @ksp. The results improve the @rmse by
50 %. The system model is an @ode. On second reference, @kit uses only the short form.

#inline-note[Expand this section.]

#include "content/features-en.typ"
#include "content/chapters-en.typ"

#if is-draft { note-outline() }
