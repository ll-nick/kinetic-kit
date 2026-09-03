#import "src/thesis.typ": thesis
#import "src/figures.typ": flex-caption
#import "src/title-page.typ": doctoral-title-page

/// Style constants for custom figures and components that need to match the
/// template's visual identity: font families, sizes, line spacing, and KIT colors.
#let kit-style = {
    import "src/typography.typ": font-sizes-by-format, fonts, leading
    import "src/kit-colors.typ": kit-colors
    (
        fonts: fonts,
        font-sizes-by-format: font-sizes-by-format,
        leading: leading,
        colors: kit-colors,
    )
}

/// Table of contents and back-matter list pages, for placing inside the
/// `front-matter` / `back-matter` content of `thesis`.
///
/// Example:
/// ```typst
/// #import "@preview/kinetic-kit:0.1.1": outlines, thesis
/// #show: thesis.with(back-matter: [
///     #outlines.list-of-figures()
///     #bibliography("refs.bib", title: [Literaturverzeichnis], style: "ieee")
/// ])
/// ```
#import "src/outlines.typ"
