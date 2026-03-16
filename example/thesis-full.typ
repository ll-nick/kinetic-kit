// KIT Thesis Template — Full-featured German example
// Demonstrates every thesis() parameter and optional integrations:
// glossarium (abbreviation expansion) and drafting (margin annotations).
//
// Compile: typst compile --root . --font-path fonts example/thesis-full.typ example/thesis-full.pdf

#import "/lib.typ": flex-caption, thesis

// ── Third-party: glossarium ───────────────────────────────────────────────
// IMPORTANT: #show: make-glossary must come before #show: thesis.with(...)
// so the show rule wraps the entire rendered document.
#import "@preview/glossarium:0.5.10": (
    gls, glspl, make-glossary, print-glossary, register-glossary,
)

#let abbrevs = (
    (key: "kit", short: "KIT", long: "Karlsruher Institut für Technologie"),
    (key: "ksp", short: "KSP", long: "KIT Scientific Publishing"),
    (key: "ode", short: "ODE", long: "Gewöhnliche Differentialgleichung"),
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
    author-firstname: "Max",
    author-surname: "Mustermann",

    // ── Title ───────────────────────────────────────────────────────────────
    title: [
        Ein vollständiger Titel der Masterarbeit --- Über mehrere Zeilen
    ],

    // thesis-type options: "Masterarbeit" | "Bachelorarbeit" | "Diplomarbeit"
    thesis-type: "Masterarbeit",

    // ── Institution ─────────────────────────────────────────────────────────
    department: "KIT-Fakultät für Maschinenbau",
    university-genitive: "des Karlsruher Instituts für Technologie (KIT)",

    // ── Supervisors ─────────────────────────────────────────────────────────
    examiner: "Prof. Dr.-Ing. Hans Musterbetreuer",
    supervisor: "M.Sc. Maria Musterbetreuerin",

    // ── Submission date ─────────────────────────────────────────────────────
    date-submitted: "01. März 2026",

    // ── Language ────────────────────────────────────────────────────────────
    lang: "de",

    // ── Layout ──────────────────────────────────────────────────────────────
    margin-preset: "short",
    binding-correction: 8mm,
    colored-links: true,

    // ── Draft watermark ─────────────────────────────────────────────────────
    draft: is-draft,
    draft-info: "v0.1 — " + datetime.today().display("[day].[month].[year]"),

    // ── Front matter ────────────────────────────────────────────────────────
    abstract-en: include "content/abstract-en.typ",
    abstract-de: include "content/abstract-de.typ",
    acknowledgements: include "content/acknowledgements.typ",

    // Glossarium: pass print-glossary() as the abbreviations content.
    // The template adds the translated section heading automatically.
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
    appendix-content: [
        = Ergänzendes Material

        #lorem(400)
    ],
)

// ── Chapters ──────────────────────────────────────────────────────────────

= Einleitung

Diese Arbeit wurde am #gls("kit") durchgeführt. Die Ergebnisse verbessern den
#gls("rmse") um 50 %. Bei erneuter Erwähnung: #gls("kit") zeigt nur die
Kurzform.

#margin-note[Diesen Abschnitt noch ausbauen.]

#include "content/introduction.typ"

#if is-draft { note-outline() }
