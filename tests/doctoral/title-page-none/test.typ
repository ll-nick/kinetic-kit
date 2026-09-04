// Compile-only: title-page: none omits the page entirely; front matter still starts
// at Roman i.
#import "/lib.typ": outlines, thesis

#show: thesis.with(
    title: [No Title Page],
    title-page: none,
    front-matter: [
        = Abstract
        Abstract text.

        #outlines.table-of-contents()
    ],
)

= Chapter
Body text.
