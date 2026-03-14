// KIT Dissertation Template — Submitted state example (German)
// Compile: typst compile --root . --font-path fonts example/dissertation-submitted.typ example/dissertation-submitted.pdf

#import "/lib.typ": dissertation

#show: dissertation.with(
    // ── Author ──────────────────────────────────────────────────────────────
    author-title: "M.Sc.",
    author-firstname: "Max",
    author-surname: "Mustermann",
    author-male: true,

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

    // ── Status ──────────────────────────────────────────────────────────────
    status-approved: false,

    // ── Binding correction — add for physically bound print copies ──────────
    binding-correction: 8mm,

    // ── Draft watermark ─────────────────────────────────────────────────────
    draft: true,
    draft-info: "v0.1 — " + datetime.today().display("[day].[month].[year]"),

    // ── Front matter ────────────────────────────────────────────────────────
    abstract-en: include "content/abstract-en.typ",
    abstract-de: include "content/abstract-de.typ",
    acknowledgements: include "content/acknowledgements.typ",
    notation: include "content/notation.typ",
    abbreviations: include "content/abbreviations.typ",

    // ── Back matter ─────────────────────────────────────────────────────────
    show-lof: true,
    show-lot: true,
    show-lol: true,

    // ── Bibliography ────────────────────────────────────────────────────────
    bibliography: bibliography("bib/references.bib", title: none, style: "ieee"),

    // ── Appendix — placed after all back-matter lists ───────────────────────
    appendix-content: [
        = Supplementary Material

        #lorem(120)
    ],
)

// ── Chapters ─────────────────────────────────────────────────────────────

#include "content/introduction.typ"
