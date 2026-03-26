// KIT Dissertation Template — Full-featured German example
// Demonstrates every dissertation() parameter and optional integrations:
// glossarium (abbreviation expansion), alexandria (multi-bibliography),
// and drafting (margin annotations during the draft stage).
//
// Compile: typst compile --root . --font-path fonts examples/dissertation-full.typ examples/dissertation-full.pdf

#import "/lib.typ": dissertation, flex-caption

// ── Third-party: glossarium ───────────────────────────────────────────────
// IMPORTANT: #show: make-glossary must come before #show: dissertation.with(...)
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

#show: make-glossary
#register-glossary(abbrevs)

// ── Third-party: alexandria (multi-bibliography) ──────────────────────────
// Allows bibliographyx() alongside the main bibliography() for own-publications,
// supervised-theses, and own-patents. Citations use @prefix:key syntax.
#import "@preview/alexandria:0.2.2": alexandria, bibliographyx
#show: alexandria(prefix: "p:", read: path => read(path))
#show: alexandria(prefix: "t:", read: path => read(path))

// ── Third-party: drafting (margin annotations) ────────────────────────────
// Set is-draft here so the same value drives both the watermark and the
// visibility of margin notes — set to false before final submission.
#import "@preview/drafting:0.2.2": margin-note, note-outline, set-margin-note-defaults
#let is-draft = true
#set-margin-note-defaults(hidden: not is-draft)

// ── Dissertation ──────────────────────────────────────────────────────────

#show: dissertation.with(
    // ── Author ──────────────────────────────────────────────────────────────
    author-title: "M.Sc.",
    author-firstname: "Max",
    author-surname: "Mustermann",
    author-male: true,
    place-of-birth: "Musterstadt",

    // ── Title ───────────────────────────────────────────────────────────────
    title: [
        Ein vollständiger Titel der Dissertation --- Über mehrere Zeilen
    ],

    // ── Degree ──────────────────────────────────────────────────────────────
    doc-degree: "Doktors der Ingenieurwissenschaften (Dr.-Ing.)",
    doc-degree-f: "Doktorin der Ingenieurwissenschaften (Dr.-Ing.)",

    // ── Institution ─────────────────────────────────────────────────────────
    department: "KIT-Fakultät für Maschinenbau",
    university-genitive: "des Karlsruher Instituts für Technologie (KIT)",

    // ── Language ────────────────────────────────────────────────────────────
    lang: "de",

    // ── Layout ──────────────────────────────────────────────────────────────
    // "short" < 200 pages | "medium" 200–399 | "long" ≥ 400
    margin-preset: "medium",
    // Add 8–10 mm BCOR for physically bound print copies
    binding-correction: 8mm,
    colored-links: true,

    // ── Status: submitted ───────────────────────────────────────────────────
    // Switch to status-approved: true and fill in the fields below once approved.
    // See dissertation-approved.typ for the approved title page.
    status-approved: false,
    // exam-date:         "12. Dezember 2025",
    // main-advisor:      "Prof. Dr.-Ing. Hans Musterbetreuer",
    // main-advisor-male: true,
    // co-advisor:        "Prof. Dr. Maria Musterreferentin",
    // co-advisor-male:   false,

    // ── Draft watermark ─────────────────────────────────────────────────────
    draft: is-draft,
    draft-info: "v0.1 — " + datetime.today().display("[day].[month].[year]"),

    // ── CV ───────────────────────────────────────────────────────────────────
    cv-name: "Max Mustermann",
    cv-entries: (
        ("1990", "Geboren in Musterstadt"),
        ("2010–2015", "Studium Maschinenbau, KIT"),
        ("2015–2025", "Wissenschaftlicher Mitarbeiter, KIT"),
    ),

    // ── Front matter ────────────────────────────────────────────────────────
    abstract-en: include "content/abstract-en.typ",
    abstract-de: include "content/abstract-de.typ",
    acknowledgements: include "content/acknowledgements.typ",
    notation: include "content/notation.typ",

    // Glossarium: pass print-glossary() as the abbreviations content.
    // The template adds the translated section heading automatically.
    abbreviations: print-glossary(abbrevs),

    // ── Back matter ─────────────────────────────────────────────────────────
    show-lof: true,
    show-lot: true,
    show-lol: true,

    // alexandria: use bibliographyx() for sections alongside the main bibliography.
    // full: true lists all entries regardless of in-text citations.
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
        Mustermann, M. (2024). *Verfahren zur Optimierung von Musterverfahren*. Deutsches
        Patent- und Markenamt, DE 10 2024 000 001 A1.
    ],

    // ── Bibliography ────────────────────────────────────────────────────────
    bibliography: bibliography(
        "bib/references.bib",
        title: none,
        style: "ieee",
    ),

    // ── Appendix ─────────────────────────────────────────────────────────────
    appendix: [
        = Ergänzendes Material

        #lorem(800)
    ],
)

= Ein erstes Beispielkapitel

// gls() expands to "Karlsruher Institut für Technologie (KIT)" on first use,
// then "KIT" on subsequent uses. glspl() uses the plural form.
Diese Arbeit wurde am #gls("kit") durchgeführt und über #gls("ksp") veröffentlicht. Die
Ergebnisse verbessern den #gls("rmse") um 50 %. Bei erneuter Erwähnung: #gls("kit") zeigt
nur die Kurzform.

#margin-note[Diesen Abschnitt noch ausbauen.]

#include "content/introduction.typ"

#if is-draft { note-outline() }
