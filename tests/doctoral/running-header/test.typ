// A title may break across lines so it reads well in the table of contents, but
// the running header is a single line and has to collapse the break. The chapter
// reaches a recto before its first section, so the header carries the chapter
// title on a verso, the fallback to it on a recto, and the section's own title on
// the recto after that.
//
// Explicit page breaks rather than pages of filler text: only the header is under
// test, and near-empty pages keep the reference images small.
#import "/lib.typ": thesis

#show: thesis.with(
    title: [Running Header],
    lang: "en",
    title-page: none,
    front-matter: [#outline()],
)

= Results, Discussion and \ an Outlook on Future Work

Chapter opening recto --- the header is suppressed here.

#pagebreak()

Verso --- the header carries the chapter title.

#pagebreak()

Recto before any section --- the header falls back to the chapter title.

== A Section Whose Title Also \ Breaks in the Contents

#pagebreak()

Verso --- the header still carries the chapter title.

#pagebreak()

Recto --- the header carries the section title.
