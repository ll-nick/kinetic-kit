// ── kit-thesis — KIT Dissertation / Thesis Template ────────────────────
//
// Quick start:
//   1. Fill in your metadata in the dissertation.with(...) call below.
//   2. Replace the abstract placeholders with your own text.
//   3. Add your chapters below the #show: line.
//   4. Set draft: false before your final submission.
//
// For a thesis (Masterarbeit / Bachelorarbeit) instead of a dissertation,
// see the commented-out thesis.with(...) block at the bottom of this file.
//
// Documentation: https://github.com/ll-nick/kit-thesis

#import "@preview/kit-thesis:0.1.0": dissertation, flex-caption

// ── Dissertation configuration ─────────────────────────────────────────────
#show: dissertation.with(
    // ── Author ────────────────────────────────────────────────────────────────
    author-title: "M.Sc.", // Academic title preceding your name
    author-firstname: "Vorname",
    author-surname: "Nachname",
    author-male: true, // true → male grammatical forms on the title page
    // place-of-birth: "Musterstadt", // Uncomment if required by your faculty

    // ── Title ─────────────────────────────────────────────────────────────────
    title: [Titel der Dissertation],

    // ── Degree & department ───────────────────────────────────────────────────
    // Adjust the degree name to match your faculty's convention.
    doc-degree: "Doktors der Ingenieurwissenschaften (Dr.-Ing.)",
    doc-degree-f: "Doktorin der Ingenieurwissenschaften (Dr.-Ing.)",
    department: "KIT-Fakultät für Maschinenbau",
    university-genitive: "des Karlsruher Instituts für Technologie (KIT)",

    // ── Status ────────────────────────────────────────────────────────────────
    // Use status-approved: false while writing. Switch to true once approved
    // and fill in the exam details below.
    status-approved: false,
    // status-approved: true,
    // exam-date:         "12. Dezember 2025",
    // main-advisor:      "Prof. Dr.-Ing. Vorname Nachname",
    // main-advisor-male: true,
    // co-advisor:        "Prof. Dr. Vorname Nachname",
    // co-advisor-male:   false,

    // ── Language & layout ─────────────────────────────────────────────────────
    lang: "en", // "de" or "en" — affects all auto-generated headings
    margin-preset: "short", // "short" (<200 pp) | "medium" (200–399) | "long" (≥400)
    binding-correction: 0mm, // Add 8–10 mm for physically bound print copies (BCOR)
    colored-links: true, // Set to false for the black-link print copy submitted to KSP

    // ── Draft watermark ───────────────────────────────────────────────────────
    // Shows "DRAFT" watermark on every page. Set to false before submission.
    draft: true,
    // draft-info: "v0.1 — 2025-06-01", // Optional extra info next to the watermark, e.g. version number, date or commit hash.

    // ── Front matter ──────────────────────────────────────────────────────────
    abstract-en: [
        Here should be your English abstract. It summarizes the research question,
        methodology, key results, and conclusion.
    ],

    abstract-de: [
        Hier steht die deutsche Kurzfassung (Abstract). Sie fasst die Fragestellung,
        Methodik, wichtigsten Ergebnisse und Schlussfolgerung zusammen.
    ],

    // acknowledgements: [
    //   // Uncomment to add an acknowledgements section.
    // ],

    // notation: [
    //   // Uncomment to add a notation / symbol list.
    // ],

    // Pass your abbreviations list here. You can optionally use the glossary module to generate this list.
    // See the examples in the documentation for details:
    // abbreviations: [...],

    // ── Back matter ───────────────────────────────────────────────────────────
    show-lof: true, // List of Figures
    show-lot: true, // List of Tables
    show-lol: false, // List of Listings (set true if you include code listings)

    bibliography: bibliography("refs.bib", title: none, style: "ieee"),

    // own-publications: [...],  // Uncomment for your publications list
    // own-patents:      [...],  // Uncomment for your patents list
    // supervised-theses:[...],  // Uncomment for supervised theses

    // appendix: [
    //   // Uncomment to add appendices — numbered A, A.1, A.2, B, …
    //   = Appendix Title
    //   ...
    // ],
)

// ── Chapters ──────────────────────────────────────────────────────────────
// Add your chapters here. Each = heading starts a new chapter.
// You can write chapters inline or in separate files using #include.
//
// Example:
//   #include "introduction.typ"
//   #include "methods.typ"
//   #include "results.typ"
//   #include "conclusion.typ"

#include "guide.typ"


// ╔═══════════════════════════════════════════════════════════════════════════╗
// ║  THESIS ALTERNATIVE — delete the dissertation block above and            ║
// ║  uncomment the block below for a Masterarbeit / Bachelorarbeit.          ║
// ╚═══════════════════════════════════════════════════════════════════════════╝
//
// #import "@preview/kit-thesis:0.1.0": thesis, flex-caption
//
// #show: thesis.with(
//
//   // ── Author ──────────────────────────────────────────────────────────────
//   author-firstname: "Vorname",
//   author-surname:   "Nachname",
//
//   // ── Title ───────────────────────────────────────────────────────────────
//   title: [Titel der Arbeit],
//
//   // ── Type & institution ──────────────────────────────────────────────────
//   thesis-type:          "Masterarbeit", // or "Bachelorarbeit" / "Diplomarbeit"
//   department:           "KIT-Fakultät für Maschinenbau",
//   university-genitive:  "des Karlsruher Instituts für Technologie (KIT)",
//
//   // ── Supervisors ─────────────────────────────────────────────────────────
//   examiner:       "Prof. Dr.-Ing. Vorname Nachname",
//   supervisor:     "M.Sc. Vorname Nachname",
//   date-submitted: "01. März 2026",
//
//   // ── Language & layout ───────────────────────────────────────────────────
//   lang: "de",
//   margin-preset: "short",
//   binding-correction: 0mm,
//   colored-links: true,
//
//   draft: true,
//
//   // ── Front matter ────────────────────────────────────────────────────────
//   abstract-en: [...],
//   abstract-de: [...],
//   // acknowledgements: [...],
//   // abbreviations: [...],
//
//   // ── Back matter ─────────────────────────────────────────────────────────
//   show-lof: true,
//   show-lot: true,
//   show-lol: false,
//
//   bibliography: bibliography("refs.bib", title: none, style: "ieee"),
//
//   // appendix: [
//   //   = Appendix Title
//   // ],
// )
