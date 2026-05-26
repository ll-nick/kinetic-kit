// Compile-only: verify kit-style namespace is importable and all fields have
// the expected types by using them in actual Typst set rules and fill arguments.
#import "/lib.typ": kit-style

// fonts — must be arrays of strings usable in set text(font: ...)
#set text(font: kit-style.fonts.serif)
#set text(font: kit-style.fonts.sans)
#set text(font: kit-style.fonts.mono)

// font-sizes — must be lengths usable in set text(size: ...)
#set text(size: kit-style.font-sizes.base)
#set text(size: kit-style.font-sizes.chapter)
#set text(size: kit-style.font-sizes.section)
#set text(size: kit-style.font-sizes.subsection)
#set text(size: kit-style.font-sizes.subsubsection)
#set text(size: kit-style.font-sizes.small)
#set text(size: kit-style.font-sizes.footnote)
#set text(size: kit-style.font-sizes.title)
#set text(size: kit-style.font-sizes.author)
#set text(size: kit-style.font-sizes.title-info)

// leading — must be a length usable in set par(leading: ...)
#set par(leading: kit-style.leading)

// colors — must be color values usable as fill
#rect(fill: kit-style.colors.green)
#rect(fill: kit-style.colors.blue)
#rect(fill: kit-style.colors.red)
