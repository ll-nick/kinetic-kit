// KIT Dissertation Template — Approved state example
// Shows only the parameters specific to status-approved: true (exam date,
// advisors, black links for print submission). See dissertation-full.typ
// for a complete example with all features.
//
// Compile: typst compile --root . --font-path fonts examples/dissertation-approved.typ examples/dissertation-approved.pdf

#import "/lib.typ": dissertation

#show: dissertation.with(
    // ── Author ──────────────────────────────────────────────────────────────
    author-title: "M.Sc.",
    author-firstname: "Max",
    author-surname: "Mustermann",
    author-male: true,

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

    lang: "de",
    margin-preset: "short",

    // ── Status: approved ────────────────────────────────────────────────────
    // These fields are required when status-approved: true.
    status-approved: true,
    exam-date: "12. Dezember 2025",
    main-advisor: "Prof. Dr.-Ing. Hans Musterbetreuer",
    main-advisor-male: true,
    co-advisor: "Prof. Dr. Maria Musterreferentin",
    co-advisor-male: false,

    // Black links for the print copy submitted to KSP
    colored-links: false,

    // ── Front matter ────────────────────────────────────────────────────────
    abstract-en: include "content/abstract-en.typ",
    abstract-de: include "content/abstract-de.typ",

    // ── Back matter ─────────────────────────────────────────────────────────
    show-lof: true,
    show-lot: true,

    // ── Bibliography ────────────────────────────────────────────────────────
    bibliography: bibliography(
        "bib/references.bib",
        title: none,
        style: "ieee",
    ),
)

// ── Chapters ──────────────────────────────────────────────────────────────

#include "content/features-de.typ"
