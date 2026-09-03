// Compile-only: a custom title page replaces the built-in one and still gets the
// template-supplied arguments. Pins two things:
//   - `.with()` cannot override what the template passes (author-surname below),
//   - overriding the page margins does not add a page or restore numbering.
#import "/lib.typ": thesis

#let custom-title-page(
    title,
    author-firstname: "",
    author-surname: "",
    format: "a5",
    lang: "de",
    label: "default",
) = {
    set page(margin: 5mm)
    assert.eq(author-surname, "Mustermann", message: "template must win over .with()")
    assert.eq(format, "a5")
    assert.eq(lang, "de")
    align(center)[#title \ #author-firstname #author-surname \ #label]
}

#show: thesis.with(
    author-firstname: "Max",
    author-surname: "Mustermann",
    title: [Custom Title Page],
    title-page: custom-title-page.with(author-surname: "Overridden", label: "custom"),
)

= Chapter
Body text.
