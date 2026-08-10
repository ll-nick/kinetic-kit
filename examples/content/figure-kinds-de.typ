// Demonstriert eine selbst deklarierte Abbildungsart.
// Wird nur von dissertation-full.typ eingebunden und setzt die passende
// `figure-kinds`-Deklaration im Dokumentkopf voraus.

= Eigene Abbildungsarten

Typst führt für jede Abbildungsart (`kind`) einen eigenen Zähler. Die Vorlage kennt
`image`, `table` und `raw`. Weitere Arten deklariert das Dokument selbst über
`figure-kinds`.

Pseudocode zählt so unabhängig von den Quellcodes und erscheint im Algorithmenverzeichnis.
Dafür genügt `kind: "algorithm"` an der Abbildung. Ohne diese Angabe leitet Typst aus
einem Raw-Block `kind: raw` ab, und der Algorithmus landet unter den Quellcodes.

#figure(
    ```
    1: x ← x₀
    2: solange nicht konvergiert:
    3:     x ← x + dt · f(x, u)
    4: gib x zurück
    ```,
    kind: "algorithm",
    caption: [Explizite Integration bis zur Konvergenz.],
)

Verweise funktionieren wie bei jeder anderen Abbildungsart, siehe @alg:regelkreis.

#figure(
    ```
    1: für jeden Zeitschritt k:
    2:     u ← regler(x)
    3:     x ← euler_step(x, u)
    ```,
    kind: "algorithm",
    caption: [Regelkreis über einen endlichen Horizont.],
) <alg:regelkreis>
