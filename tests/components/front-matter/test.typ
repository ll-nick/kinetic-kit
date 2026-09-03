// Compile-only: setup-front-matter wrapper — verifies Roman numeral pagination
// and heading numbering suppression compile correctly.
#import "/src/page-setup.typ": setup-front-matter, setup-page

#show: setup-page.with(lang: "de", margin-preset: "short")
#show: setup-front-matter

= Vorwort

Inhalt der Vorseiten.

== Unterabschnitt

Weiterer Inhalt.
