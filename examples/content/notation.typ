#table(
    columns: (2cm, 1fr),
    stroke: none,
    // Move entries to the top of the row
    // Since there is no border stroke,
    // there would be additional whitespace between the heading and the first entry otherwise.
    inset: (x: 0pt, top: 0pt, bottom: 0.7em),
    [$bold(x)$], [State vector],
    [$bold(u)$], [Input vector],
    [$bold(y)$], [Output vector],
    [$A$], [System matrix],
    [$B$], [Input matrix],
    [$C$], [Output matrix],
    [$t$], [Time, $t in RR$],
    [$Delta t$], [Sampling interval],
)
