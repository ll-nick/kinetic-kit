// KIT Doctoral Thesis — Approved state example
// Shows only the parameters specific to status-approved: true (exam date,
// advisors, black links for print submission). See doctoral-full.typ
// for a complete example with all features.
//
// Compile: typst compile --root . --font-path fonts examples/doctoral-approved.typ examples/doctoral-approved.pdf

#import "/lib.typ": doctoral-title-page, outlines, thesis

#show: thesis.with(
    // ── Metadata ───────────────────────────────────────────────────────────
    lang: "de",
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [
        Ein vollständiger Titel der Dissertation --- Über mehrere Zeilen
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

        // ── Status: approved ────────────────────────────────────────────────────
        // These fields are required when status-approved: true.
        status-approved: true,
        exam-date: "12. Dezember 2025",
        main-advisor: "Prof. Dr.-Ing. Hans Musterbetreuer",
        main-advisor-male: true,
        co-advisor: "Prof. Dr. Maria Musterreferentin",
        co-advisor-male: false,
    ),

    // ── Content ────────────────────────────────────────────────────────────
    front-matter: [
        #include "content/abstract-en.typ"
        #include "content/abstract-de.typ"

        #outlines.table-of-contents()
    ],

    back-matter: [
        #outlines.list-of-figures()
        #outlines.list-of-tables()

        #bibliography("bib/references.bib", title: [Literaturverzeichnis], style: "ieee")
    ],

    // ── Formatting ─────────────────────────────────────────────────────────
    margin-preset: "short",
    colored-links: false, // black links for the print copy submitted to KSP
)

// ── Chapters ──────────────────────────────────────────────────────────────

#include "content/features-de.typ"
