// KIT Thesis Template — Masterarbeit example
// Compile: typst compile --root . --font-path fonts example/thesis.typ example/thesis.pdf

#import "/lib.typ": thesis

#show: thesis.with(
    // ── Author ──────────────────────────────────────────────────────────────
    author-firstname: "Max",
    author-surname: "Mustermann",

    // ── Thesis ──────────────────────────────────────────────────────────────
    title: [
        Ein vollständiger Titel der Masterarbeit --- Über mehrere Zeilen
    ],

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

    // ── Margin preset ───────────────────────────────────────────────────────
    margin-preset: "short",

    // ── Front matter ────────────────────────────────────────────────────────
    abstract-en: include "content/abstract-en.typ",
    abstract-de: include "content/abstract-de.typ",

    // ── Back matter ─────────────────────────────────────────────────────────
    show-lof: true,
    show-lot: true,
    show-lol: false,
)

// ── Chapters ─────────────────────────────────────────────────────────────

#include "content/introduction.typ"

// ── Bibliography ─────────────────────────────────────────────────────────

#heading(level: 1, numbering: none, outlined: true, bookmarked: true)[Literaturverzeichnis]
#bibliography(
    "bib/references.bib",
    title: none,
    style: "ieee",
)
