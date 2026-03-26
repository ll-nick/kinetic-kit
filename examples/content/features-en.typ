#import "/lib.typ": flex-caption

= Introduction

#lorem(40) @example2024. #lorem(20)

Additional information can be found at #link("https://www.kit.edu")[kit.edu].

== Motivation

As shown by @example2023, #lorem(30)

== Research Questions

#lorem(40)

The following questions are addressed in this dissertation:

+ #lorem(15)
+ #lorem(15)
+ #lorem(15)

== Structure of This Work

#lorem(60)

=== Outline

#lorem(40)

==== A Fourth-Level Heading Example

#lorem(30)

== A Figure Example

// flex-caption: short text in the List of Figures, long text in the body
#figure(
    rect(width: 6cm, height: 3cm, fill: luma(230), stroke: none),
    caption: flex-caption(
        short: [A placeholder graphic.],
        long: [An example figure showing a placeholder graphic with a longer caption in
            the body.],
    ),
) <fig:example>

As shown in @fig:example, #lorem(20)

== A Table Example

#figure(
    table(
        columns: (auto, auto, auto),
        inset: 6pt,
        align: horizon,
        table.header([*Method*], [*RMSE*], [*Runtime (s)*]),
        [Baseline], [0.42], [1.2],
        [Proposed], [0.21], [1.5],
    ),
    caption: [Comparison of methods.],
) <tab:example>

@tab:example summarises the results.

== A Footnote Example

#lorem(30).#footnote[This is a short footnote.] #lorem(20)

// Long multi-line footnote: tests FN4 (second line aligned to first) and FN5 (no page-spanning)
#lorem(20).#footnote[
    #lorem(15) --- #lorem(15).
    #lorem(20). #lorem(20).
    #lorem(15).
] #lorem(30)

== A List Example

// Short items (1–2 lines): left-aligned with early line breaks (REC E2)
- #lorem(8)
- #lorem(10)
- #lorem(7)

// Long items (≥ 3 lines): justified, second line aligned to first (REQ E1)
- #lorem(40)
- #lorem(45)
- #lorem(38)

== A Long Caption Example

// Short caption: one line → should be centred
#figure(
    rect(width: 4cm, height: 2cm, fill: luma(220), stroke: none),
    caption: [A short, centred caption.],
)

// Long caption: three or more lines → should be left-aligned
#figure(
    rect(width: 4cm, height: 2cm, fill: luma(220), stroke: none),
    caption: [
        A long caption that intentionally spans three or more lines to verify that the
        conditional alignment logic switches to left-justified text as recommended by KSP
        for very long captions of three lines or more.
    ],
)

== An Equation Example

The system dynamics are described by

$ dot(bold(x)) = A bold(x) + B bold(u) $ <eq:system>

where $bold(x)$ is the state vector. Equation @eq:system is discretised as

$ bold(x)_(k+1) = A_d bold(x)_k + B_d bold(u)_k . $

== A Code Listing Example

#figure(
    ```python
    def euler_step(x, u, A, B, dt):
        return x + dt * (A @ x + B @ u)
    ```,
    caption: [Euler integration step in Python.],
)
