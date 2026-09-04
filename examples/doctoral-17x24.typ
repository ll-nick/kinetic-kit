// KIT Doctoral Thesis — 170×240 mm format example
// The 17×24 format is offered by KSP alongside A5. Font sizes are adjusted
// per KSP Manuscript Handbook p. 13 (chapter headings 20 pt, section 15 pt, etc.);
// margins follow the same page-count-based presets as A5.
//
// Compile: typst compile --root . --font-path fonts examples/doctoral-17x24.typ examples/doctoral-17x24.pdf

#import "/lib.typ": doctoral-title-page, flex-caption, outlines, thesis
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

#show: make-glossary
#register-glossary(abbrevs)

// ── Third-party: drafting (margin annotations) ────────────────────────────
// Set is-draft here so the same value drives both the watermark and the
// visibility of margin notes — set to false before final submission.
#import "@preview/drafting:0.2.2": inline-note, note-outline, set-margin-note-defaults
#let is-draft = true
#set-margin-note-defaults(hidden: not is-draft)

// ── Dissertation ──────────────────────────────────────────────────────────

#show: thesis.with(
    // ── Metadata ───────────────────────────────────────────────────────────
    format: "17x24",
    lang: "de",
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [
        Ein vollständiger Titel der Dissertation -- Über mehrere Zeilen
    ],
    title-page: doctoral-title-page.with(
        // ── Author ──────────────────────────────────────────────────────────────
        author-title: "M.Sc.",
        author-male: true,

        // ── Degree ──────────────────────────────────────────────────────────────
        doc-degree: "Doktors der Ingenieurwissenschaften (Dr.-Ing.)",
        doc-degree-f: "Doktorin der Ingenieurwissenschaften (Dr.-Ing.)",

        // ── Institution ─────────────────────────────────────────────────────────
        department: "KIT-Fakultät für Maschinenbau",
        university-genitive: "des Karlsruher Instituts für Technologie (KIT)",

        // ── Status: submitted ───────────────────────────────────────────────────
        // See doctoral-approved.typ for the approved state, which adds the exam date
        // and referees.
        status-approved: false,
    ),

    // ── Content ────────────────────────────────────────────────────────────
    front-matter: [
        = Danksagung
        #include "content/acknowledgements.typ"

        #include "content/abstract-en.typ"
        #include "content/abstract-de.typ"

        = Nomenklatur
        #include "content/notation.typ"

        = Abkürzungsverzeichnis
        #abbrevs-glossary(abbrevs)

        #outlines.table-of-contents()
    ],

    appendix: [
        = Ergänzendes Material

        #lorem(800)
    ],

    back-matter: [
        #outlines.list-of-figures()
        #outlines.list-of-tables()
        #outlines.list-of-listings()

        #bibliography("bib/references.bib", title: [Literaturverzeichnis], style: "ieee")

        = Eigene Publikationen
        #bibliography("bib/own-publications.bib", title: none, style: "ieee", full: true)

        = Patente
        Mustermann, M. (2024). *Verfahren zur Optimierung von Musterverfahren*. Deutsches
        Patent- und Markenamt, DE 10 2024 000 001 A1.

        = Betreute studentische Arbeiten
        #bibliography("bib/supervised-theses.bib", title: none, style: "ieee", full: true)
    ],

    // ── Formatting ─────────────────────────────────────────────────────────
    serif-headings: true,
    heading-numbering-depth: 4,
    // "short" < 200 pages | "medium" 200–399 | "long" ≥ 400
    margin-preset: "medium",
    colored-links: true,

    // ── Draft watermark ────────────────────────────────────────────────────
    draft: is-draft,
    draft-info: "v0.1 — " + datetime.today().display("[day].[month].[year]"),
)

= Ein erstes Beispielkapitel

// Abbreviations expand on first use. Both @key and #gls("key") syntax are supported.
// First use: "Karlsruher Institut für Technologie (KIT)", subsequent: "KIT".
Diese Arbeit wurde am @kit durchgeführt und über @ksp veröffentlicht. Die Ergebnisse
verbessern den @rmse um 50 %. Das Systemmodell ist eine @ode. Bei erneuter Erwähnung zeigt
@kit nur die Kurzform.

#inline-note[Diesen Abschnitt noch ausbauen.]

#include "content/features-de.typ"
#include "content/chapters-de.typ"

#if is-draft { note-outline() }
