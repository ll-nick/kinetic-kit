// Compile-only: title-page: none omits the page entirely; front matter still starts
// at Roman i.
#import "/lib.typ": thesis

#show: thesis.with(
    title: [No Title Page],
    title-page: none,
    abstract-en: [Abstract text.],
)

= Chapter
Body text.
