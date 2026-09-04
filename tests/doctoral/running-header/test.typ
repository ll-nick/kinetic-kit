// Compile-only: a title may break across lines so it reads well in the table of
// contents, but the running header is a single line and has to collapse the
// break. The chapter reaches a recto before its first section, so the header
// carries the chapter title on a verso, the fallback to it on a recto, and the
// section's own title on the recto after that.
#import "/lib.typ": thesis

#show: thesis.with(
    title: [Running Header],
    lang: "en",
    title-page: none,
    front-matter: [#outline()],
)

= Results, Discussion and \ an Outlook on Future Work

#lorem(620)

== A Section Whose Title Also \ Breaks in the Contents

#lorem(900)
