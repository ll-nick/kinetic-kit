// Compile-only: verify kit-style namespace is importable and all fields have
// the expected types by using them in actual Typst set rules and fill arguments.
#import "/lib.typ": kit-style

// fonts — must be arrays of strings usable in set text(font: ...)
#set text(font: kit-style.fonts.serif)
#set text(font: kit-style.fonts.sans)
#set text(font: kit-style.fonts.mono)

// font-sizes-by-format — dict keyed by format; each entry must have length fields
#let font-sizes = kit-style.font-sizes-by-format.at("a5")
#set text(size: font-sizes.base)
#set text(size: font-sizes.chapter)
#set text(size: font-sizes.section)
#set text(size: font-sizes.subsection)
#set text(size: font-sizes.subsubsection)
#set text(size: font-sizes.small)
#set text(size: font-sizes.footnote)
#set text(size: font-sizes.title)
#set text(size: font-sizes.author)
#set text(size: font-sizes.title-info)

// leading — must be a length usable in set par(leading: ...)
#set par(leading: kit-style.leading)

// colors — must be color values usable as fill
#rect(fill: kit-style.colors.green)
#rect(fill: kit-style.colors.blue)
#rect(fill: kit-style.colors.red)
