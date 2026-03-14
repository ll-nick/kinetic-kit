= Introduction

#lorem(40) @example2024. #lorem(20)

== Motivation

#lorem(50) As shown by @example2023, #lorem(30)

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

== A Figure Example

#figure(
    rect(width: 6cm, height: 3cm, fill: luma(230), stroke: none),
    caption: [An example figure showing a placeholder graphic.],
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
