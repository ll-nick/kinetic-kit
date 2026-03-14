// KIT Thesis Template — Masterarbeit example
// Compile: typst compile --root . --font-path fonts example/thesis.typ example/thesis.pdf

#import "/lib.typ": thesis

#show: thesis.with(
    // ── Author ──────────────────────────────────────────────────────────────
    author-firstname: "Max",
    author-surname: "Mustermann",

    // ── Thesis ──────────────────────────────────────────────────────────────
    title: [
        Ein vollständiger Titel der Bachelorarbeit --- Über mehrere Zeilen
    ],

    // thesis-type options: "Masterarbeit" | "Bachelorarbeit" | "Diplomarbeit"
    thesis-type: "Bachelorarbeit",

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

    // ── Margin preset ───────────────────────────────────────────────────────
    margin-preset: "short",

    // ── Front matter ────────────────────────────────────────────────────────
    abstract-en: include "content/abstract-en.typ",
    abstract-de: include "content/abstract-de.typ",
    acknowledgements: include "content/acknowledgements.typ",

    // ── Back matter ─────────────────────────────────────────────────────────
    show-lof: true,
    show-lot: true,
    show-lol: false,

    // ── Bibliography ────────────────────────────────────────────────────────
    bibliography: bibliography("bib/references.bib", title: none, style: "ieee"),
)

// ── Chapters ─────────────────────────────────────────────────────────────

#include "content/introduction.typ"
