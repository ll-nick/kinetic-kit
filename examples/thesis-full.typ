// KIT Thesis Template — Full-featured German example
// Demonstrates every thesis() parameter and optional integrations:
// glossarium (abbreviation expansion) and drafting (margin annotations).
//
// Compile: typst compile --root . --font-path fonts examples/thesis-full.typ examples/thesis-full.pdf

#import "/lib.typ": flex-caption, thesis
#import "content/abbreviations.typ": abbrevs-glossary

// ── Third-party: glossarium ───────────────────────────────────────────────
// IMPORTANT: #show: make-glossary must come before #show: thesis.with(...)
// so the show rule wraps the entire rendered document.
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary

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
#import "@preview/drafting:0.2.2": inline-note, note-outline, set-margin-note-defaults
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
    colored-links: true,

    // ── Draft watermark ─────────────────────────────────────────────────────
    draft: is-draft,
    draft-info: "v0.1 — " + datetime.today().display("[day].[month].[year]"),

    // ── Front matter ────────────────────────────────────────────────────────
    abstract-en: include "content/abstract-en.typ",
    abstract-de: include "content/abstract-de.typ",
    acknowledgements: include "content/acknowledgements.typ",

    abbreviations: abbrevs-glossary(abbrevs),

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
        = Ergänzendes Material

        #lorem(400)
    ],
)

// ── Chapters ──────────────────────────────────────────────────────────────

= Einleitung

// Abbreviations expand on first use. Both @key and #gls("key") syntax are supported.
Diese Arbeit wurde am @kit durchgeführt und über @ksp veröffentlicht. Die Ergebnisse
verbessern den @rmse um 50 %. Das Systemmodell ist eine @ode. Bei erneuter Erwähnung zeigt
@kit nur die Kurzform.

#inline-note[Diesen Abschnitt noch ausbauen.]

#include "content/features-de.typ"

#if is-draft { note-outline() }
