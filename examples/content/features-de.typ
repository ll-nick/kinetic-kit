#import "/lib.typ": flex-caption

= Einleitung

#lorem(40) @example2024. #lorem(20)

Weitere Informationen finden sich unter #link("https://www.kit.edu")[kit.edu].

== Motivation

Wie in @example2023 gezeigt, #lorem(30)

== Forschungsfragen

#lorem(40)

Diese Arbeit befasst sich mit den folgenden Fragen:

+ #lorem(15)
+ #lorem(15)
+ #lorem(15)

== Aufbau der Arbeit

#lorem(60)

=== Gliederung

#lorem(40)

==== Beispiel für eine vierte Gliederungsebene

#lorem(30)

== Abbildungsbeispiel

// flex-caption: Kurztext im Abbildungsverzeichnis, Langtext im Fließtext
#figure(
    rect(width: 6cm, height: 3cm, fill: luma(230), stroke: none),
    caption: flex-caption(
        short: [Eine Platzhaltergrafik.],
        long: [Eine Beispielabbildung mit einer Platzhaltergrafik und einer längeren
            Beschriftung im Fließtext.],
    ),
) <fig:beispiel>

Wie in @fig:beispiel gezeigt, #lorem(20)

== Tabellenbeispiel

#figure(
    table(
        columns: (auto, auto, auto),
        inset: 6pt,
        align: left + horizon,
        table.header([*Methode*], [*RMSE*], [*Laufzeit (s)*]),
        [Basismethode], [0.42], [1.2],
        [Vorgeschlagen], [0.21], [1.5],
    ),
    caption: [Vergleich der Methoden.],
) <tab:beispiel>

@tab:beispiel fasst die Ergebnisse zusammen.

== Fußnotenbeispiel

#lorem(30).#footnote[Dies ist eine kurze Fußnote.] #lorem(20)

// Lange mehrzeilige Fußnote: testet FN4 (zweite Zeile bündig zur ersten) und FN5 (kein Seitenumbruch)
#lorem(20).#footnote[
    #lorem(15) --- #lorem(15). #lorem(20). #lorem(20). #lorem(15).
] #lorem(30)

== Listenbeispiel

// Kurze Einträge (1–2 Zeilen): linksbündig mit frühem Zeilenumbruch (REC E2)
- #lorem(8)
- #lorem(10)
- #lorem(7)

// Lange Einträge (≥ 3 Zeilen): Blocksatz, zweite Zeile bündig zur ersten (REQ E1)
- #lorem(40)
- #lorem(45)
- #lorem(38)

== Beispiel für lange Bildunterschriften

// Kurze Beschriftung: eine Zeile → zentriert
#figure(
    rect(width: 4cm, height: 2cm, fill: luma(220), stroke: none),
    caption: [Eine kurze, zentrierte Beschriftung.],
)

// Lange Beschriftung: drei oder mehr Zeilen → linksbündig
#figure(
    rect(width: 4cm, height: 2cm, fill: luma(220), stroke: none),
    caption: [
        Eine lange Beschriftung, die absichtlich drei oder mehr Zeilen umfasst, um zu
        prüfen, ob die bedingte Ausrichtungslogik auf linksbündigen Text umschaltet, wie
        von KSP für Beschriftungen ab drei Zeilen empfohlen.
    ],
)

== Gleichungsbeispiel

Die Systemdynamik wird beschrieben durch

$ dot(bold(x)) = A bold(x) + B bold(u) $ <eq:system-de>

wobei $bold(x)$ der Zustandsvektor ist. Gleichung @eq:system-de wird diskretisiert als

$ bold(x)_(k+1) = A_d bold(x)_k + B_d bold(u)_k . $

== Quellcodebeispiel

#figure(
    ```python
    def euler_step(x, u, A, B, dt):
        return x + dt * (A @ x + B @ u)
    ```,
    caption: [Euler-Integrationsschritt in Python.],
)
