// KIT Dissertation Template — Example Document
// Compile from this directory:
//   typst compile main.typ
// (Fonts are found automatically via typst.toml font-paths.)

#import "/lib.typ": appendix, dissertation, flex-caption

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
    // "short" < 200 pages | "medium" 200–399 | "long" ≥ 400
    margin-preset: "short",

    // ── Status ──────────────────────────────────────────────────────────────
    // false = submitted ("eingereichte"), true = approved ("angenommene")
    status-approved: false,

    // ── Advisor info — fill in when status-approved = true ──────────────────
    // exam-date:         "12.12.2025",
    // main-advisor:      "Prof. Dr.-Ing. Hauptreferent",
    // main-advisor-male: true,
    // co-advisor:        "Prof. Dr. Korreferent",
    // co-advisor-male:   true,

    // ── Front matter ────────────────────────────────────────────────────────
    abstract-en: include "content/abstract-en.typ",
    abstract-de: include "content/abstract-de.typ",
    acknowledgements: include "content/acknowledgements.typ",
    notation: include "content/notation.typ",
    abbreviations: include "content/abbreviations.typ",

    // ── CV — uncomment to enable ────────────────────────────────────────────
    // cv-name: "Max Mustermann",
    // cv-entries: (
    //   ("1990",      "Born in Musterstadt"),
    //   ("2010–2015", "Studies at KIT"),
    //   ("2015–2025", "Research assistant at KIT"),
    // ),

    // ── Back matter ─────────────────────────────────────────────────────────
    show-lof: true,
    show-lot: true,
    show-lol: false,

    // ── Own publications — uncomment to enable ──────────────────────────────
    // own-publications: bibliography("bib/own-publications.bib",
    //   title: "Eigene Publikationen", style: "ieee"),

    // ── Supervised theses — uncomment to enable ─────────────────────────────
    // supervised-theses: bibliography("bib/supervised-theses.bib",
    //   title: "Betreute studentische Arbeiten", style: "ieee"),
)

// ── Chapters ─────────────────────────────────────────────────────────────

#include "content/introduction.typ"

// ── Bibliography ─────────────────────────────────────────────────────────

#heading(
    level: 1,
    numbering: none,
    outlined: true,
    bookmarked: true,
)[Literaturverzeichnis]
#bibliography(
    "bib/references.bib",
    title: none,
    style: "ieee",
)

// ── Appendix ─────────────────────────────────────────────────────────────

#show: appendix

= Supplementary Material

#lorem(120)
