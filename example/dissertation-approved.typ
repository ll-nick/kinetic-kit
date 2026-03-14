// KIT Dissertation Template — Approved state example (German)
// Compile: typst compile --root . --font-path fonts example/dissertation-approved.typ example/dissertation-approved.pdf

#import "/lib.typ": dissertation

#show: dissertation.with(
    // ── Author ──────────────────────────────────────────────────────────────
    author-title: "M.Sc.",
    author-firstname: "Max",
    author-surname: "Mustermann",
    author-male: true,
    place-of-birth: "Musterstadt",

    // ── Thesis ──────────────────────────────────────────────────────────────
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

    // ── Margin preset ───────────────────────────────────────────────────────
    margin-preset: "short",

    // ── Status: approved ────────────────────────────────────────────────────
    status-approved: true,
    exam-date: "12. Dezember 2025",
    main-advisor: "Prof. Dr.-Ing. Hans Musterbetreuer",
    main-advisor-male: true,
    co-advisor: "Prof. Dr. Maria Musterreferentin",
    co-advisor-male: false,

    // ── Front matter ────────────────────────────────────────────────────────
    abstract-en: include "content/abstract-en.typ",
    abstract-de: include "content/abstract-de.typ",
    acknowledgements: include "content/acknowledgements.typ",

    // ── Links: false = all black for print submission ────────────────────────
    colored-links: false,

    // ── Back matter ─────────────────────────────────────────────────────────
    show-lof: true,
    show-lot: true,
    show-lol: false,

    // Heading is added automatically by the template.
    own-patents: [
        Mustermann, M. (2024). *Verfahren zur Optimierung von Musterverfahren*.
        Deutsches Patent- und Markenamt, DE 10 2024 000 001 A1.
    ],

    // ── Bibliography ────────────────────────────────────────────────────────
    // Heading is added automatically; pass title: none to suppress the built-in one.
    bibliography: bibliography("bib/references.bib", title: none, style: "ieee"),
)

// ── Chapters ─────────────────────────────────────────────────────────────

#include "content/introduction.typ"
