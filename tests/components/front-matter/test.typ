// Compile-only: setup-front-matter wrapper — verifies Roman numeral pagination
// and heading numbering suppression compile correctly.
#import "/lib.typ": components

#show: components.setup-page.with(lang: "de", margin-preset: "short")
#show: components.setup-front-matter

= Vorwort

Inhalt der Vorseiten.

== Unterabschnitt

Weiterer Inhalt.
