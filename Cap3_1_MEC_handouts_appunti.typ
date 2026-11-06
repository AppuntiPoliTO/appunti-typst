#import "@preview/cetz:0.5.3": canvas, draw
#import "@preview/zap:0.6.0"
#import zap: *
#import zap.cetz.draw: bezier, arc, content

// Distingue automaticamente tra #line/#rect/#circle di Typst e quelli dei circuiti CeTZ:
#let line(..args) = if args.pos().len() == 0 { std.line(..args) } else { zap.cetz.draw.line(..args) }
#let rect(..args) = if args.pos().len() <= 1 { std.rect(..args) } else { zap.cetz.draw.rect(..args) }
#let circle(..args) = if args.pos().len() == 0 or type(args.pos().first()) != array { std.circle(..args) } else { zap.cetz.draw.circle(..args) }
#let nota(body) = block(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: (left: 3pt + luma(120)),
  body
)

// === IMPOSTAZIONI GLOBALI COMPONENTI ===
// Cambia qui "ieee" (zig-zag) o "iec" (rettangolo) per modificare TUTTI i circuiti del file!
#let resistor = zap.resistor.with(variant: "ieee")
#let rheostat = zap.rheostat.with(variant: "ieee")
#let potentiometer = zap.potentiometer.with(variant: "ieee")
#let inductor = zap.inductor.with(variant: "ieee")
#let vsource = zap.vsource.with(variant: "iec") // "iec" = cerchio con linea, "ieee" = cerchio con +/-
#let isource = zap.isource.with(variant: "iec")

// === IMPOSTAZIONI PAGINA E TESTO ===
#set page(
  paper: "a4",
  margin: 1.5cm,
  numbering: "1",
  number-align: bottom + right,
)
#set text(lang: "it", size: 11pt)
#set par(justify: true)
#set heading(numbering: "1.")
#let nota(body) = block(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: (left: 3pt + luma(120)),
  body
)

// === FUNZIONI E MACRO ===
#let sans(body, size: 11pt, weight: "regular") = text(
  font: ("Liberation Sans", "Arial", "Helvetica", "DejaVu Sans Mono", "Libertinus Serif"),
  size: size,
  weight: weight,
  body
)

#let immagine-originale = image
#let image(nome-file, ..args) = immagine-originale("images/" + nome-file, ..args)

#let circ = sym.degree
#let varphi = $phi$


// ==========================================
// SLIDE 1 - 15
// ==========================================

= Circuiti in regime sinusoidale: comportamento in frequenza

== Risposta in frequenza e funzione di trasferimento

=== Dipendenza dell'impedenza dalla pulsazione

In regime sinusoidale, il comportamento dei bipoli passivi elementari ($R$, $L$, $C$) in funzione della pulsazione $omega = 2 pi f$ è descritto dalle rispettive impedenze complesse $macron(Z) = |macron(Z)| e^(j theta)$:

// VERIFICA: tabella e relazioni dedotte dal testo e dai simboli della Slide 2
#align(center)[
  #table(
    columns: (auto, auto, auto, auto),
    align: (center + horizon, center + horizon, center + horizon, center + horizon),
    table.header(
      [*Bipolo*], [*Impedenza $macron(Z)$*], [*Modulo $|macron(Z)|$*], [*Fase $theta$*]
    ),
    table.hline(),
    [Resistore ($R$)], [$R$], [$R$], [$0$],
    [Induttore ($L$)], [$j omega L$], [$omega L$], [$pi / 2$],
    [Condensatore ($C$)], [$-j 1 / (omega C) = 1 / (j omega C)$], [$1 / (omega C)$], [$-pi / 2$],
  )
]

Dall'analisi delle espressioni del modulo $|macron(Z)|$ al variare della pulsazione $omega$ si osserva che:
- *Resistore ($R$)*: l'impedenza è puramente reale e non dipende da $omega$.
- *Induttore ($L$)*: il modulo $|macron(Z)| = omega L$ cresce linearmente con $omega$. Per $omega -> 0$ (regime stazionario) si comporta come un *cortocircuito* ($|macron(Z)| -> 0$), mentre per $omega -> infinity$ si comporta come un *circuito aperto* ($|macron(Z)| -> infinity$).
- *Condensatore ($C$)*: il modulo $|macron(Z)| = 1 / (omega C)$ diminuisce in modo inversamente proporzionale a $omega$. Per $omega -> 0$ si comporta come un *circuito aperto* ($|macron(Z)| -> infinity$), mentre per $omega -> infinity$ si comporta come un *cortocircuito* ($|macron(Z)| -> 0$).

#nota[
  La risposta di un circuito elettrico contenente induttori ($L$) e/o condensatori ($C$) dipende pertanto dalla frequenza (o pulsazione $omega$) dei generatori che lo alimentano.
]

=== Partitore di tensione e funzione di trasferimento

Si consideri un partitore di tensione costituito da due impedenze generiche $macron(Z)_1 = R_1 + j X_1$ e $macron(Z)_2 = R_2 + j X_2$, alimentato in ingresso dalla tensione fasoriale $macron(V)_"in"$ e con l'uscita a vuoto prelevata ai capi di $macron(Z)_2$, indicata con $macron(V)_"out"$.

#align(center)[
  #zap.circuit({
    import zap: *
    import zap.cetz.draw: *

    // Impedenza Z1 (rettangolo IEC)
    resistor("z1", (0, 3), (3.5, 3), variant: "iec", label: (content: $macron(Z)_1$, anchor: "south", distance: 6pt))
    // Impedenza Z2 (rettangolo IEC)
    resistor("z2", (3.5, 3), (3.5, 0), variant: "iec", label: (content: $macron(Z)_2$, anchor: "north", distance: 6pt))

    // Fili di collegamento
    wire((3.5, 3), (5.5, 3))
    wire((0, 0), (5.5, 0))

    // Nodo di giunzione centrale
    node("n1", (3.5, 3))

    // Morsetti di ingresso e uscita (aperti)
    node("in_p", (0, 3), fill: false)
    node("in_m", (0, 0), fill: false)
    node("out_p", (5.5, 3), fill: false)
    node("out_m", (5.5, 0), fill: false)

    // Indicazioni di tensione Vin
    content((0, 2.5), sans("+", weight: "bold"))
    content((0, 1.5), $macron(V)_"in"$)
    content((0, 0.5), sans("-", weight: "bold"))

    // Indicazioni di tensione Vout
    content((5.5, 2.5), sans("+", weight: "bold"))
    content((5.5, 1.5), $macron(V)_"out"$)
    content((5.5, 0.5), sans("-", weight: "bold"))
  })
]

Applicando la regola del partitore di tensione, la tensione di uscita a vuoto su $macron(Z)_2$, nota la tensione di ingresso $macron(V)_"in"$, vale:

$ macron(V)_"out" = frac(macron(Z)_2, macron(Z)_1 + macron(Z)_2) macron(V)_"in" $

Dalla relazione precedente si ricava il rapporto complesso tra uscita e ingresso:

$ frac(macron(V)_"out", macron(V)_"in") = frac(macron(Z)_2(j omega), macron(Z)_1(j omega) + macron(Z)_2(j omega)) $

Poiché le impedenze $macron(Z)_1$ e $macron(Z)_2$ dipendono dalla pulsazione $omega$, anche il rapporto tra il fasore di uscita e quello di ingresso dipende da $omega$; essendo tuttavia il circuito lineare, tale rapporto non dipende né dall'ampiezza né dalla fase della tensione di ingresso $macron(V)_"in"$.

#nota[
  *Definizione (Funzione di trasferimento)*: Il rapporto tra il fasore della grandezza di uscita e il fasore della grandezza di ingresso, valutato alla pulsazione $omega$, prende il nome di *funzione di trasferimento* $macron(H)(j omega)$:
  $ macron(H)(j omega) = frac(macron(V)_"out", macron(V)_"in") = |macron(H)(j omega)| e^(j angle macron(H)(j omega)) $
]

La funzione di trasferimento $macron(H)(j omega)$ è un numero complesso funzione di $omega$, caratterizzato da:
- *Modulo $|macron(H)|$*: rappresenta il rapporto tra le ampiezze (o valori efficaci) di uscita e di ingresso:
  $ V_"out" = |macron(H)| V_"in" $
- *Fase $angle macron(H)$*: rappresenta lo sfasamento introdotto dal circuito tra l'uscita e l'ingresso:
  $ angle macron(V)_"out" = angle macron(V)_"in" + angle macron(H) $

Per rappresentare graficamente il comportamento del circuito su un ampio intervallo di frequenze si utilizzano i *diagrammi di Bode*, i quali riportano il modulo espresso in decibel (dB), definito come $|macron(H)|_"dB" = 20 log_10 |macron(H)|$, e la fase $angle macron(H)$ in funzione della pulsazione $omega$ su scala logaritmica.

== Filtro passa-basso (circuito RC)

Si consideri il circuito $R C$ mostrato in figura, ottenuto ponendo nel partitore di tensione un resistore in serie ($macron(Z)_1 = R$) e un condensatore in derivazione ($macron(Z)_2 = 1 / (j omega C) = -j / (omega C)$), prelevando in uscita la tensione a vuoto sul condensatore $C$.

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *
    set-style(resistor: (variant: "ieee"))

    // Resistore R in serie
    resistor("r1", (0, 3), (3.5, 3), label: (content: $R$, anchor: "south", distance: 6pt))
    // Condensatore C in parallelo
    capacitor("c1", (3.5, 3), (3.5, 0), label: (content: $C$, anchor: "south", distance: 6pt))

    // Fili di collegamento
    wire((3.5, 3), (5.5, 3))
    wire((0, 0), (5.5, 0))

    // Nodo di giunzione
    node("n1", (3.5, 3))

    // Morsetti aperti
    node("in_p", (0, 3), fill: false)
    node("in_m", (0, 0), fill: false)
    node("out_p", (5.5, 3), fill: false)
    node("out_m", (5.5, 0), fill: false)

    // Tensioni Vin e Vout
    content((0, 2.5), sans("+", weight: "bold"))
    content((0, 1.5), $macron(V)_"in"$)
    content((0, 0.5), sans("-", weight: "bold"))

    content((5.5, 2.5), sans("+", weight: "bold"))
    content((5.5, 1.5), $macron(V)_"out"$)
    content((5.5, 0.5), sans("-", weight: "bold"))
  })
]

Applicando la relazione del partitore di tensione, si ottiene la tensione di uscita a vuoto sul condensatore:

// VERIFICA: passaggi algebrici dedotti dalla Slide 5
$ macron(V)_"out" = frac(frac(1, j omega C), R + frac(1, j omega C)) macron(V)_"in" = frac(1, 1 + j omega R C) macron(V)_"in" $

La funzione di trasferimento del circuito risulta quindi:

$ macron(H)(j omega) = frac(macron(V)_"out", macron(V)_"in") = frac(1, 1 + j omega R C) $

Definendo la *pulsazione di taglio* $omega_0$ (e la corrispondente *frequenza di taglio* $f_0$) come:

$ omega_0 = frac(1, R C) quad arrow.r.double quad f_0 = frac(omega_0, 2 pi) = frac(1, 2 pi R C) $

la funzione di trasferimento assume la forma adimensionale normalizzata:

$ macron(H)(j omega) = frac(1, 1 + j frac(omega, omega_0)) $

=== Modulo, fase e comportamento asintotico

Dall'espressione complessa di $macron(H)(j omega)$ si ricavano immediatamente il modulo e la fase in funzione del rapporto $omega / omega_0$:

// VERIFICA: equazioni di modulo, dB e fase dedotte dalle Slide 6 e 7
$ |macron(H)(j omega)| = frac(1, sqrt(1 + (frac(omega, omega_0))^2)) $

$ angle macron(H)(j omega) = -arctan(frac(omega, omega_0)) $

Esprimendo il modulo in decibel si ha:

$ |macron(H)|_"dB" = 20 log_10 |macron(H)| = 20 log_10 frac(1, sqrt(1 + (frac(omega, omega_0))^2)) = -20 log_10 sqrt(1 + (frac(omega, omega_0))^2) $

Il comportamento limite del filtro nei tre regimi caratteristici di frequenza ($omega lt.double omega_0$, $omega = omega_0$, $omega gt.double omega_0$) è riassunto nella tabella seguente:

#align(center)[
  #table(
    columns: (25%, 25%, 25%, 25%),
    align: (center + horizon, center + horizon, center + horizon, center + horizon),
    table.header(
      [*Regime di pulsazione*], [*$|macron(H)|$*], [*$|macron(H)|_"dB"$ \[dB\]*], [*$angle macron(H)$ \[rad\]*]
    ),
    table.hline(),
    [$omega lt.double omega_0$], [$tilde.eq 1$], [$tilde.eq 0$], [$tilde.eq 0$],
    [$omega = omega_0$], [$frac(1, sqrt(2)) approx 0.707$], [$tilde.eq -3$], [$-frac(pi, 4)$],
    [$omega gt.double omega_0$], [$tilde.eq frac(omega_0, omega)$], [$-20 log_10 frac(omega, omega_0)$], [$tilde.eq -frac(pi, 2)$],
  )
]

#nota[
  Per pulsazioni molto superiori a quella di taglio ($omega gt.double omega_0$), il modulo in decibel decresce linearmente con il logaritmo della pulsazione secondo la legge $|macron(H)|_"dB" tilde.eq -20 log_10 (omega / omega_0)$: il modulo scende quindi con una pendenza asintotica di *-20 dB per ogni decade* di $omega$ (ovvero un fattore $10$ in frequenza riduce il modulo di un fattore $10$). Per basse frequenze ($omega lt.double omega_0$), invece, $|macron(H)| tilde.eq 1$ e $macron(V)_"out" tilde.eq macron(V)_"in"$, lasciando passare inalterato il segnale (da cui il nome di *filtro passa-basso*).
]


=== Diagrammi cartesiani e di Bode del filtro passa-basso

In scala lineare, l'andamento del modulo $|macron(H)|$ in funzione della pulsazione normalizzata $omega / omega_0$ parte dal valore unitario per $omega = 0$, assume il valore $1 / sqrt(2)$ in corrispondenza della pulsazione di taglio $omega / omega_0 = 1$ e tende asintoticamente a zero per $omega -> infinity$:

#align(center)[
  #canvas({
    import draw: *
    // Assi cartesiani
    line((0, -0.3), (0, 3.2), mark: (end: "stealth", fill: black))
    line((-0.3, 0), (5.5, 0), mark: (end: "stealth", fill: black))

    content((-0.5, 3.0), $|macron(H)|$)
    content((5.5, -0.4), $omega / omega_0$)

    // Riferimenti
    line((-0.1, 2.2), (0.1, 2.2))
    content((-0.35, 2.2), $1$)

    line((2.0, -0.1), (2.0, 0.1))
    content((2.0, -0.4), $1$)

    line((0, 1.55), (2.0, 1.55), stroke: (dash: "dashed", paint: gray))
    line((2.0, 0), (2.0, 1.55), stroke: (dash: "dashed", paint: gray))
    content((-0.55, 1.55), $1 / sqrt(2)$)

    // Curva del modulo passa-basso
    bezier((0, 2.2), (2.0, 1.55), (1.0, 2.2), (1.5, 1.9), stroke: 1.5pt + black)
    bezier((2.0, 1.55), (5.0, 0.15), (2.6, 1.0), (3.5, 0.2), stroke: 1.5pt + black)
  })
]



Passando alla rappresentazione semilogaritmica dei *diagrammi di Bode* (modulo $|macron(H)|_"dB"$ e fase $angle macron(H)$ in funzione di $omega / omega_0$), si ottengono gli andamenti riportati di seguito:

#align(center)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    align: center + horizon,
    [
      #canvas({
        import draw: *
        // Riquadro grafico Modulo dB: x da 0 a 4 (4 decadi: 10^-2 .. 10^2), y da 0 a 5 (-40 dB .. +10 dB)
        rect((0, 0), (4.8, 4.0), stroke: 1pt + black)
        content((2.4, 4.4), $|macron(H)|_"dB"$)
        content((2.4, -0.8), $omega / omega_0$)

        // Griglia verticale (decadi: x = 0, 1.2, 2.4, 3.6, 4.8)
        for i in (1, 2, 3) {
          line((i * 1.2, 0), (i * 1.2, 4.0), stroke: 0.5pt + gray.lighten(30%))
        }
        content((0, -0.3), $10^(-2)$)
        content((1.2, -0.3), $10^(-1)$)
        content((2.4, -0.3), $10^0$)
        content((3.6, -0.3), $10^1$)
        content((4.8, -0.3), $10^2$)

        // Griglia orizzontale (dB: -40 -> 0, -30 -> 0.8, -20 -> 1.6, -10 -> 2.4, 0 -> 3.2, 10 -> 4.0)
        for j in (1, 2, 3, 4) {
          line((0, j * 0.8), (4.8, j * 0.8), stroke: 0.5pt + gray.lighten(30%))
        }
        content((-0.4, 0), $-40$)
        content((-0.4, 0.8), $-30$)
        content((-0.4, 1.6), $-20$)
        content((-0.4, 2.4), $-10$)
        content((-0.4, 3.2), $0$)
        content((-0.4, 4.0), $10$)

        // Asintoti tratteggiati
        line((0, 3.2), (2.4, 3.2), stroke: (dash: "dashed", paint: gray))
        line((2.4, 3.2), (4.8, 0), stroke: (dash: "dashed", paint: gray))

        // Curva reale (-3 dB a x=2.4 -> y = 3.2 - 0.24 = 2.96)
        line((0, 3.2), (1.2, 3.2), stroke: 1.5pt + rgb("#0d6e38"))
        bezier((1.2, 3.2), (2.4, 2.96), (1.9, 3.2), (2.2, 3.08), stroke: 1.5pt + rgb("#0d6e38"))
        bezier((2.4, 2.96), (3.6, 1.6), (2.6, 2.8), (3.1, 2.27), stroke: 1.5pt + rgb("#0d6e38"))
        line((3.6, 1.6), (4.8, 0), stroke: 1.5pt + rgb("#0d6e38"))
        circle((2.4, 2.96), radius: 1.5pt, fill: rgb("#0d6e38"), stroke: none)
      })
    ],
    [
      #canvas({
        import draw: *
        // Riquadro grafico Fase: x da 0 a 4.8, y da 0 (-pi/2) a 4.0 (0)
        rect((0, 0), (4.8, 4.0), stroke: 1pt + black)
        content((2.4, 4.4), $angle macron(H)$)
        content((2.4, -0.8), $omega / omega_0$)

        for i in (1, 2, 3) {
          line((i * 1.2, 0), (i * 1.2, 4.0), stroke: 0.5pt + gray.lighten(30%))
        }
        content((0, -0.3), $10^(-2)$)
        content((1.2, -0.3), $10^(-1)$)
        content((2.4, -0.3), $10^0$)
        content((3.6, -0.3), $10^1$)
        content((4.8, -0.3), $10^2$)

        line((0, 2.0), (4.8, 2.0), stroke: 0.5pt + gray.lighten(30%))
        content((-0.4, 4.0), $0$)
        content((-0.45, 2.0), $-frac(pi, 4)$)
        content((-0.45, 0), $-frac(pi, 2)$)

        // Curva di fase
        bezier((0, 3.95), (2.4, 2.0), (1.4, 3.9), (1.9, 2.8), stroke: 1.5pt + rgb("#0d6e38"))
        bezier((2.4, 2.0), (4.8, 0.05), (2.9, 1.2), (3.4, 0.1), stroke: 1.5pt + rgb("#0d6e38"))
        circle((2.4, 2.0), radius: 1.5pt, fill: rgb("#0d6e38"), stroke: none)
      })
    ]
  )
]



== Filtro passa-alto (circuito CR)

Scambiando la posizione del resistore e del condensatore si ottiene il circuito $C R$ mostrato in figura, nel quale $macron(Z)_1 = 1 / (j omega C) = -j / (omega C)$ è posta in serie e $macron(Z)_2 = R$ è posta in derivazione. L'uscita a vuoto $macron(V)_"out"$ viene prelevata ai capi del resistore $R$.

#align(center)[
  #zap.circuit({

    import zap.cetz.draw: *
    set-style(resistor: (variant: "ieee"))

    // Condensatore C in serie
    capacitor("c1", (0, 3), (3.5, 3), label: (content: $C$, anchor: "south", distance: 6pt))
    // Resistore R in parallelo
    resistor("r1", (3.5, 3), (3.5, 0), label: (content: $R$, anchor: "north", distance: 6pt))

    // Fili di collegamento
    wire((3.5, 3), (5.5, 3))
    wire((0, 0), (5.5, 0))

    // Nodo di giunzione
    node("n1", (3.5, 3))

    // Morsetti aperti
    node("in_p", (0, 3), fill: false)
    node("in_m", (0, 0), fill: false)
    node("out_p", (5.5, 3), fill: false)
    node("out_m", (5.5, 0), fill: false)

    // Tensioni Vin e Vout
    content((0, 2.5), sans("+", weight: "bold"))
    content((0, 1.5), $macron(V)_"in"$)
    content((0, 0.5), sans("-", weight: "bold"))

    content((5.5, 2.5), sans("+", weight: "bold"))
    content((5.5, 1.5), $macron(V)_"out"$)
    content((5.5, 0.5), sans("-", weight: "bold"))
  })
]

Applicando il partitore di tensione, la tensione a vuoto sul resistore $R$, nota $macron(V)_"in"$, è data da:

// VERIFICA: passaggi algebrici dedotti dalla Slide 10
$ macron(V)_"out" = frac(R, R + frac(1, j omega C)) macron(V)_"in" = frac(1, 1 - j frac(1, omega R C)) macron(V)_"in" $

Definendo la medesima pulsazione di taglio $omega_0 = 1 / (R C)$, la funzione di trasferimento del filtro passa-alto si scrive come:

$ macron(H)(j omega) = frac(macron(V)_"out", macron(V)_"in") = frac(1, 1 - j frac(omega_0, omega)) = frac(j frac(omega, omega_0), 1 + j frac(omega, omega_0)) $

=== Modulo, fase e comportamento asintotico

Il modulo e la fase della funzione di trasferimento del filtro passa-alto sono espressi da:

// VERIFICA: equazioni dedotte dalla Slide 11
$ |macron(H)(j omega)| = frac(1, sqrt(1 + (frac(omega_0, omega))^2)) $

$ angle macron(H)(j omega) = arctan(frac(omega_0, omega)) $

Il modulo in decibel risulta:

$ |macron(H)|_"dB" = 20 log_10 |macron(H)| = 20 log_10 frac(1, sqrt(1 + (frac(omega_0, omega))^2)) = -20 log_10 sqrt(1 + (frac(omega_0, omega))^2) $

Assumendo una tensione di ingresso con fase nulla, $macron(V)_"in" = V_"in" e^(j 0)$, si ottengono direttamente l'ampiezza e la fase della tensione di uscita:

$ V_"out" = |macron(H)| V_"in" , quad angle macron(V)_"out" = angle macron(H) $

Il comportamento asintotico nei tre regimi di pulsazione è sintetizzato nella tabella seguente:

#align(center)[
  #table(
    columns: (25%, 25%, 25%, 25%),
    align: (center + horizon, center + horizon, center + horizon, center + horizon),
    table.header(
      [*Regime di pulsazione*], [*$|macron(H)|$*], [*$|macron(H)|_"dB"$ \[dB\]*], [*$angle macron(H)$ \[rad\]*]
    ),
    table.hline(),
    [$omega lt.double omega_0$], [$tilde.eq frac(omega, omega_0)$], [$20 log_10 frac(omega, omega_0)$], [$tilde.eq frac(pi, 2)$],
    [$omega = omega_0$], [$frac(1, sqrt(2)) approx 0.707$], [$tilde.eq -3$], [$frac(pi, 4)$],
    [$omega gt.double omega_0$], [$tilde.eq 1$], [$tilde.eq 0$], [$tilde.eq 0$],
  )
]

#nota[
  Per pulsazioni molto inferiori a quella di taglio ($omega lt.double omega_0$), il modulo in dB cresce con pendenza di *+20 dB per ogni decade* di $omega$. Per alte frequenze ($omega gt.double omega_0$), il condensatore si comporta come un cortocircuito e $|macron(H)| tilde.eq 1$ ($macron(V)_"out" tilde.eq macron(V)_"in"$), lasciando passare inalterate le componenti ad alta frequenza (*filtro passa-alto*).
]



=== Diagrammi cartesiani e di Bode del filtro passa-alto

L'andamento del modulo $|macron(H)|$ in scala lineare mostra che la risposta è nulla in continua ($omega = 0$), vale $1 / sqrt(2)$ alla pulsazione di taglio $omega = omega_0$ e tende asintoticamente a $1$ per $omega gt.double omega_0$:

#align(center)[
  #canvas({
    import draw: *
    // Assi cartesiani
    line((0, -0.3), (0, 3.2), mark: (end: "stealth", fill: black))
    line((-0.3, 0), (5.5, 0), mark: (end: "stealth", fill: black))

    content((-0.5, 3.0), $|macron(H)|$)
    content((5.5, -0.4), $omega / omega_0$)

    // Asintoto orizzontale a 1
    line((0, 2.2), (5.0, 2.2), stroke: (dash: "dashed", paint: black))
    content((-0.35, 2.2), $1$)

    line((2.0, -0.1), (2.0, 0.1))
    content((2.0, -0.4), $1$)

    line((0, 1.55), (2.0, 1.55), stroke: (dash: "dashed", paint: gray))
    line((2.0, 0), (2.0, 1.55), stroke: (dash: "dashed", paint: gray))
    content((-0.55, 1.55), $1 / sqrt(2)$)

    // Curva del modulo passa-alto
    bezier((0, 0), (2.0, 1.55), (0.8, 0.05), (1.5, 0.9), stroke: 1.5pt + rgb("#d9381e"))
    bezier((2.0, 1.55), (5.0, 2.15), (2.5, 2.0), (3.5, 2.15), stroke: 1.5pt + rgb("#d9381e"))
  })
]

I corrispondenti diagrammi di Bode del modulo $|macron(H)|_"dB"$ e della fase $angle macron(H)$ sono riportati di seguito:

#align(center)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    align: center + horizon,
    [
      #canvas({
        import draw: *
        rect((0, 0), (4.8, 4.0), stroke: 1pt + black)
        content((2.4, 4.4), $|macron(H)|_"dB"$)
        content((2.4, -0.8), $omega / omega_0$)

        for i in (1, 2, 3) {
          line((i * 1.2, 0), (i * 1.2, 4.0), stroke: 0.5pt + gray.lighten(30%))
        }
        content((0, -0.3), $10^(-2)$)
        content((1.2, -0.3), $10^(-1)$)
        content((2.4, -0.3), $10^0$)
        content((3.6, -0.3), $10^1$)
        content((4.8, -0.3), $10^2$)

        for j in (1, 2, 3, 4) {
          line((0, j * 0.8), (4.8, j * 0.8), stroke: 0.5pt + gray.lighten(30%))
        }
        content((-0.4, 0), $-40$)
        content((-0.4, 0.8), $-30$)
        content((-0.4, 1.6), $-20$)
        content((-0.4, 2.4), $-10$)
        content((-0.4, 3.2), $0$)
        content((-0.4, 4.0), $10$)

        // Asintoti tratteggiati
        line((0, 0), (2.4, 3.2), stroke: (dash: "dashed", paint: gray))
        line((2.4, 3.2), (4.8, 3.2), stroke: (dash: "dashed", paint: gray))

        // Curva reale
        line((0, 0), (1.2, 1.6), stroke: 1.5pt + rgb("#d9381e"))
        bezier((1.2, 1.6), (2.4, 2.96), (1.7, 2.27), (2.2, 2.8), stroke: 1.5pt + rgb("#d9381e"))
        bezier((2.4, 2.96), (3.6, 3.2), (2.6, 3.08), (2.9, 3.2), stroke: 1.5pt + rgb("#d9381e"))
        line((3.6, 3.2), (4.8, 3.2), stroke: 1.5pt + rgb("#d9381e"))
        circle((2.4, 2.96), radius: 1.5pt, fill: rgb("#d9381e"), stroke: none)
      })
    ],
    [
      #canvas({
        import draw: *
        rect((0, 0), (4.8, 4.0), stroke: 1pt + black)
        content((2.4, 4.4), $angle macron(H)$)
        content((2.4, -0.8), $omega / omega_0$)

        for i in (1, 2, 3) {
          line((i * 1.2, 0), (i * 1.2, 4.0), stroke: 0.5pt + gray.lighten(30%))
        }
        content((0, -0.3), $10^(-2)$)
        content((1.2, -0.3), $10^(-1)$)
        content((2.4, -0.3), $10^0$)
        content((3.6, -0.3), $10^1$)
        content((4.8, -0.3), $10^2$)

        line((0, 2.0), (4.8, 2.0), stroke: 0.5pt + gray.lighten(30%))
        content((-0.4, 4.0), $frac(pi, 2)$)
        content((-0.4, 2.0), $frac(pi, 4)$)
        content((-0.4, 0), $0$)

        // Curva di fase passa-alto (da +pi/2 a 0)
        bezier((0, 3.95), (2.4, 2.0), (1.4, 3.9), (1.9, 2.8), stroke: 1.5pt + rgb("#d9381e"))
        bezier((2.4, 2.0), (4.8, 0.05), (2.9, 1.2), (3.4, 0.1), stroke: 1.5pt + rgb("#d9381e"))
        circle((2.4, 2.0), radius: 1.5pt, fill: rgb("#d9381e"), stroke: none)
      })
    ]
  )
]



== Circuito RLC serie e risonanza

Si consideri ora un circuito costituito dal collegamento in serie di un resistore $R$ ($macron(Z)_1 = R$), un induttore $L$ ($macron(Z)_2 = j omega L$) e un condensatore $C$ ($macron(Z)_3 = -j / (omega C)$), alimentato da una tensione $macron(V)$ e percorso dalla corrente $macron(I)$, come rappresentato nello schema seguente:

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *

    // Stile IEEE (zig-zag per R e spire tonde per L)
    set-style(zap: (variant: "ieee"))

    // --- 1. RAMO VERTICALE SERIE: R, L, C ---
    resistor("r1", (2, 6), (2, 4))
    inductor("l1", (2, 4), (2, 2))
    capacitor("c1", (2, 2), (2, 0))

    // Etichette a DESTRA dei componenti (R, L, C)
    content((2.45, 5.0), anchor: "west", $R$)
    content((2.45, 3.0), anchor: "west", $L$)
    content((2.55, 1.0), anchor: "west", $C$)

    // Etichette a SINISTRA dei componenti (Z1, Z2, Z3)
    content((1.55, 5.0), anchor: "east", $macron(Z)_1$)
    content((1.55, 3.0), anchor: "east", $macron(Z)_2$)
    content((1.45, 1.0), anchor: "east", $macron(Z)_3$)

    // --- 2. MORSETTI DI INGRESSO (a sinistra) ---
    wire((0, 6), (2, 6))
    wire((0, 0), (2, 0))

    // Freccia della corrente I sul ramo superiore d'ingresso
    line((0.8, 6), (1.2, 6), mark: (end: "stealth", fill: black, scale: 1.2))
    content((1.0, 6.25), anchor: "south", $macron(I)$)

    // --- 3. MORSETTI DI USCITA AI CAPI DI R (a destra) ---
    wire((2, 6), (4.0, 6))
    wire((2, 4), (4.0, 4))

    // --- 4. NODI DI GIUNZIONE E MORSETTI APERTI ---
    // Nodi pieni (giunzioni ai capi di R)
    node("n_top", (2, 6))
    node("n_mid", (2, 4))

    // Morsetti aperti (fill: false in Zap disegna il pallino con sfondo bianco coprendo il filo)
    node("in_p", (0, 6), fill: false)
    node("in_m", (0, 0), fill: false)
    node("out_p", (4.0, 6), fill: false)
    node("out_m", (4.0, 4), fill: false)

    // --- 5. FRECCE DI TENSIONE V e VR ---
    // Tensione totale d'ingresso V
    line((0, 0.35), (0, 5.65), stroke: 0.7pt, mark: (end: "stealth", fill: black))
    content((-0.25, 3.0), anchor: "east", $macron(V)$)

    // Tensione d'uscita VR ai capi del resistore
    line((4.0, 4.35), (4.0, 5.65), stroke: 0.7pt, mark: (end: "stealth", fill: black))
    content((4.25, 5.0), anchor: "west", $macron(V)_R$)
  })
]


L'impedenza equivalente complessiva vista ai morsetti di ingresso vale:

// VERIFICA: equazioni della risonanza serie dedotte dalla Slide 15
$ macron(Z)(j omega) = macron(Z)_1 + macron(Z)_2 + macron(Z)_3 = R + j (omega L - frac(1, omega C)) $

Il modulo dell'impedenza è dato da:

$ |macron(Z)(j omega)| = sqrt(R^2 + (omega L - frac(1, omega C))^2) $

La parte immaginaria dell'impedenza (reattanza totale $X(omega) = omega L - 1 / (omega C)$) si annulla quando la reattanza induttiva eguaglia in modulo quella capacitiva:

$ omega L - frac(1, omega C) = 0 quad arrow.r.double quad omega^2 = frac(1, L C) $

Si definisce pertanto *pulsazione di risonanza* $omega_0$ il valore:

$ omega_0 = frac(1, sqrt(L C)) $

Al variare della pulsazione $omega$ rispetto a $omega_0$, il circuito presenta tre comportamenti distinti:
- *Per $omega < omega_0$*: risulta $omega L - 1 / (omega C) < 0$; prevale la reattanza capacitiva e il circuito ha comportamento *ohmico-capacitivo* ($R - C$).
- *Per $omega = omega_0$ (condizione di risonanza)*: risulta $omega_0 L - 1 / (omega_0 C) = 0$; gli effetti reattivi di induttore e condensatore si compensano esattamente e il circuito presenta comportamento *puramente resistivo* ($macron(Z)(j omega_0) = R$).
- *Per $omega > omega_0$*: risulta $omega L - 1 / (omega C) > 0$; prevale la reattanza induttiva e il circuito ha comportamento *ohmico-induttivo* ($R - L$).

#nota[
  Alla pulsazione di risonanza $omega = omega_0$, il modulo dell'impedenza $|macron(Z)|$ raggiunge il suo *valore minimo assoluto*, pari alla sola resistenza $|macron(Z)(j omega_0)|_"min" = R$. Di conseguenza, a parità di ampiezza della tensione di alimentazione $V$, il modulo della corrente $|macron(I)| = V / |macron(Z)|$ e il modulo della tensione sul resistore $|macron(V)_R| = R |macron(I)|$ raggiungono il loro *valore massimo* ($|macron(I)|_"max" = V / R$, $|macron(V)_R|_"max" = V$).
]

Gli andamenti qualitativi del modulo dell'impedenza $|macron(Z)|$ e della grandezza $R |macron(I)| = |macron(V)_R|$ in funzione della pulsazione $omega$ sono illustrati nei grafici seguenti:


#align(center)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.5em,
    align: center + horizon,
    [
      #canvas({
        import draw: *
        // Grafico |Z| vs omega
        line((0, -0.3), (0, 3.5), mark: (end: "stealth", fill: black))
        line((-0.3, 0), (5.0, 0), mark: (end: "stealth", fill: black))

        content((-0.5, 3.3), $|macron(Z)|$)
        content((5.0, -0.4), $omega$)

        // Minimo a R per omega = omega_0
        line((2.3, -0.1), (2.3, 0.1))
        content((2.3, -0.4), $omega_0$)

        line((0, 0.9), (2.3, 0.9), stroke: (dash: "dashed", paint: rgb("#005bb5")))
        content((-0.4, 0.9), $R$)

        // Curva a V di |Z|
        bezier((0.8, 3.2), (2.3, 0.9), (1.3, 1.8), (1.9, 0.9), stroke: 1.5pt + rgb("#005bb5"))
        bezier((2.3, 0.9), (4.2, 3.2), (2.7, 0.9), (3.4, 2.0), stroke: 1.5pt + rgb("#005bb5"))
      })
    ],
    [
      #canvas({
        import draw: *
        // Grafico R|I| = |V_R| vs omega
        line((0, -0.3), (0, 3.5), mark: (end: "stealth", fill: black))
        line((-0.3, 0), (5.0, 0), mark: (end: "stealth", fill: black))

        content((-0.6, 3.2), $R |macron(I)|$)
        content((5.0, -0.4), $omega$)

        line((2.3, -0.1), (2.3, 0.1))
        content((2.3, -0.4), $omega_0$)

        line((0, 2.6), (2.3, 2.6), stroke: (dash: "dashed", paint: gray))
        line((2.3, 0), (2.3, 2.6), stroke: (dash: "dashed", paint: gray))
        content((-0.4, 2.6), $V$)

        // Curva a campana di risonanza
        bezier((0, 0), (2.3, 2.6), (1.2, 0.05), (1.8, 2.6), stroke: 1.5pt + rgb("#005bb5"))
        bezier((2.3, 2.6), (4.6, 0.15), (2.8, 2.6), (3.3, 0.25), stroke: 1.5pt + rgb("#005bb5"))
      })
    ]
  )
]