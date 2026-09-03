// ── kinetic-kit — KIT Thesis Template ──────────────────────────────────
//
// Quick start:
//   1. Fill in your metadata in the thesis.with(...) call below.
//   2. Replace the abstract placeholders with your own text.
//   3. Add your chapters below the #show: line.
//   4. Optionally set draft: true while writing to stamp a "DRAFT" watermark.
//
// Documentation: https://github.com/ll-nick/kinetic-kit

#import "@preview/kinetic-kit:0.1.1": doctoral-title-page, flex-caption, thesis

// ── Document configuration ─────────────────────────────────────────────────
#show: thesis.with(
    // ── Author ────────────────────────────────────────────────────────────────
    author-firstname: "Vorname",
    author-surname: "Nachname",

    // ── Title ─────────────────────────────────────────────────────────────────
    title: [Titel der Arbeit],

    // ── Title page ────────────────────────────────────────────────────────────
    // Everything printed on the title page is configured here. Replace this whole
    // argument with your own function or content for a fully custom title page.
    title-page: doctoral-title-page.with(
        author-title: "M.Sc.", // Academic title preceding your name
        author-male: true, // true → male grammatical forms on the title page

        // Adjust the degree name to match your faculty's convention.
        doc-degree: "Doktors der Ingenieurwissenschaften (Dr.-Ing.)",
        doc-degree-f: "Doktorin der Ingenieurwissenschaften (Dr.-Ing.)",
        department: "KIT-Fakultät für Maschinenbau",
        university-genitive: "des Karlsruher Instituts für Technologie (KIT)",

        // Use status-approved: false while writing. Switch to true once approved
        // and fill in the exam details below.
        status-approved: false,
        // status-approved: true,
        // exam-date:         "12. Dezember 2025",
        // main-advisor:      "Prof. Dr.-Ing. Vorname Nachname",
        // main-advisor-male: true,
        // co-advisor:        "Prof. Dr. Vorname Nachname",
        // co-advisor-male:   false,
    ),

    // ── Language & layout ─────────────────────────────────────────────────────
    lang: "en", // "de" or "en" — affects all auto-generated headings
    format: "a5", // "a5" (148×210 mm) | "17x24" (170×240 mm) | "a4" (210×297 mm)
    margin-preset: "short", // "short" (<200 pp) | "medium" (200–399) | "long" (≥400)
    binding-correction: 0mm, // Add 8–10 mm for physically bound print copies (BCOR)
    colored-links: true, // Set to false for the black-link print copy submitted to KSP
    serif-headings: false, // true = Libertinus Serif headings; false = Libertinus Sans
    heading-numbering-depth: 3, // Deepest numbered level: 3 = 1.1.1, 4 = 1.1.1.1

    // ── Draft watermark ───────────────────────────────────────────────────────
    // Set to true while writing to stamp "DRAFT" / "ENTWURF" on every page.
    draft: false,
    // draft-info: "v0.1 — 2025-06-01", // Optional extra info next to the watermark, e.g. version, date or commit hash.

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

    // Pass your abbreviations list here. You can optionally use the glossarium package
    // for automatic first-use expansion. See the full example in the documentation.
    // abbreviations: [...],

    // ── Back matter ───────────────────────────────────────────────────────────
    show-list-of-figures: true,
    show-list-of-tables: true,
    show-list-of-listings: false, // List of Listings (set true if you include code listings)

    // Supply additional figure kinds here if required.
    // figure-kinds: (
    //     (
    //         kind: "algorithm",
    //         supplement: (de: [Algorithmus], en: [Algorithm]),
    //         list-title: (de: [Algorithmenverzeichnis], en: [List of Algorithms]),
    //         show-list: true,
    //     ),
    // ),

    bibliography: bibliography("refs.bib", title: none, style: "ieee"),

    // own-publications: [...],
    // own-patents:      [...],
    // supervised-theses:[...],

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

