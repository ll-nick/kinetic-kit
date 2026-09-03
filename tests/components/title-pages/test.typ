// Compile-only: render both title pages directly via components,
// without any setup-page wrapper (each title page sets its own page geometry).
#import "/lib.typ": components

#components.doctoral-title-page(
    [Titel der Dissertation],
    author-title: "M.Sc.",
    author-firstname: "Max",
    author-surname: "Mustermann",
    author-male: true,
    doc-degree: "Doktor-Ingenieur",
    doc-degree-f: "Doktor-Ingenieurin",
    department: "KIT-Fakultät für Maschinenbau",
    university-genitive: "des Karlsruher Instituts für Technologie (KIT)",
    status-approved: true,
    exam-date: "12. Dezember 2025",
    main-advisor: "Prof. Dr.-Ing. Hans Musterbetreuer",
    main-advisor-male: true,
    co-advisor: "Prof. Dr. Maria Musterreferentin",
    co-advisor-male: false,
    format: "a5",
)
