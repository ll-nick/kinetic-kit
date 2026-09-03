// Compile-only: render the doctoral title page directly,
// without any setup-page wrapper (it sets its own page geometry).
#import "/lib.typ": doctoral-title-page

#doctoral-title-page(
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
