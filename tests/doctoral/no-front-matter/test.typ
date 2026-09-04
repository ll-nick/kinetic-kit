// `front-matter: none` — the one path where `setup-content` reaches its
// `pagebreak(to: "odd")` with nothing but the title page in front of it.
// The chapter must still land on a recto numbered 1, not on the title page's
// own sheet and not numbered 2.
#import "/lib.typ": thesis

#show: thesis.with(
    title: [No Front Matter],
    front-matter: none,
)

= Chapter One

#context assert.eq(
    counter(page).at(here()).first(),
    1,
    message: "the first chapter must be page 1",
)

Body.

= Chapter Two

Body.
