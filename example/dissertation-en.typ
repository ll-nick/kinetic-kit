// KIT Dissertation Template — English language example
// Verifies: English body text labels, German title page strings,
// and automatic abbreviation expansion via glossarium.
// Compile: typst compile --root . --font-path fonts example/dissertation-en.typ example/dissertation-en.pdf

#import "/lib.typ": dissertation, gls, glspl

#show: dissertation.with(
    // ── Author ──────────────────────────────────────────────────────────────
    author-title: "M.Sc.",
    author-firstname: "Jane",
    author-surname: "Doe",
    author-male: false,

    // ── Thesis ──────────────────────────────────────────────────────────────
    title: [
        A Complete Dissertation Title --- Spanning Multiple Lines
    ],

    // ── Degree ──────────────────────────────────────────────────────────────
    doc-degree: "Doktors der Ingenieurwissenschaften (Dr.-Ing.)",
    doc-degree-f: "Doktorin der Ingenieurwissenschaften (Dr.-Ing.)",

    // ── Institution ─────────────────────────────────────────────────────────
    department: "KIT-Fakultät für Maschinenbau",
    university-genitive: "des Karlsruher Instituts für Technologie (KIT)",

    // ── Language: English ───────────────────────────────────────────────────
    // Title page always uses German strings regardless.
    lang: "en",

    // ── Margin preset ───────────────────────────────────────────────────────
    margin-preset: "short",

    // ── Status ──────────────────────────────────────────────────────────────
    status-approved: false,

    // ── Automatic abbreviation expansion via glossarium ─────────────────────
    // When set, abbreviations are expanded on first use with gls()/glspl().
    // The manual "abbreviations" parameter is ignored when this is set.
    glossary-entries: (
        (key: "kit",  short: "KIT",  long: "Karlsruhe Institute of Technology"),
        (key: "ksp",  short: "KSP",  long: "KIT Scientific Publishing"),
        (key: "ode",  short: "ODE",  long: "Ordinary Differential Equation"),
        (key: "rmse", short: "RMSE", long: "Root Mean Square Error"),
    ),

    // ── Front matter ────────────────────────────────────────────────────────
    abstract-en: include "content/abstract-en.typ",
    abstract-de: include "content/abstract-de.typ",

    // ── Back matter ─────────────────────────────────────────────────────────
    show-lof: true,
    show-lot: true,
    show-lol: false,

    // ── Bibliography ────────────────────────────────────────────────────────
    bibliography: bibliography("bib/references.bib", title: none, style: "ieee"),
)

// ── Chapters ─────────────────────────────────────────────────────────────

= Introduction

// gls() expands to "Karlsruhe Institute of Technology (KIT)" on first use,
// then "KIT" on subsequent uses. glspl() uses the plural form.
This work was conducted at #gls("kit") and published via #gls("ksp").
The results improve upon the baseline #gls("rmse") by 50%.
On second reference: #gls("kit") uses only the short form.

#include "content/introduction.typ"
