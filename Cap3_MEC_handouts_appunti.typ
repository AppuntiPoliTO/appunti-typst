

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
#let scala-tabella = 0.8  // Scala tutta la tabella (es. 0.8 = 80%, 1.2 = 120%)
#let scala-circuiti = 1.0  // Scala SOLO i disegni dei circuiti dentro le celle
// =========================================================================

// Helper sicuro per il testo Sans-Serif (zero warning sui font)


// Funzione per generare ciascun bipolo con parametro "scala" personalizzabile
#let schema-bipolo(tipo, etichetta, scala: 1.0) = scale(
  x: scala * 100%,
  y: scala * 100%,
  reflow: true, // Ricalcola automaticamente gli ingombri nella pagina/tabella!
)[
  #zap.circuit({
    import zap: *
    import zap.cetz.draw: *

    // Stile IEEE (zig-zag per R e spire ad occhiello per L)
    set-style(zap: (variant: "ieee"))

    // 1. Freccia della corrente I staccata a sinistra del morsetto
    line((-1.4, 0), (-0.55, 0), stroke: 0.9pt, mark: (end: "stealth", fill: black, scale: 1.3))
    content((-1.0, 0.25), anchor: "south", text(size: 16pt)[$macron(I)$])

    // 2. Componente centrale con morsetti aperti nativi (n: "o-o")
    if tipo == "R" {
      resistor("comp", (0, 0), (2.2, 0), n: "o-o")
    } else if tipo == "L" {
      inductor("comp", (0, 0), (2.2, 0), n: "o-o")
    } else if tipo == "C" {
      capacitor("comp", (0, 0), (2.2, 0), n: "o-o")
    }

    // Etichetta (R, L, C) sotto il componente
    content((1.1, -0.5), anchor: "north", text(size: 16pt, etichetta))

    // 3. Freccia curva della tensione V sopra il componente (da destra a sinistra)
    bezier(
      (2.0, 0.4),
      (0.1, 0.4),
      (1.05, 0.95),
      stroke: 0.6pt,
      mark: (end: "stealth", fill: black, scale: 1.2)
    )
    content((0.95, 0.72), anchor: "south", text(size: 16pt)[$macron(V)$])
  })
]
#let varphi = $phi$
 = Circuiti in regime sinusoidale

== Introduzione alle grandezze variabili nel tempo

Le reti elettriche analizzate in regime stazionario sono dette _statiche_ o _adinamiche_, in quanto la variabile tempo non interviene nelle relazioni circuitali. In tali condizioni, essendo nulle le derivate temporali delle grandezze elettriche, i componenti dinamici (induttori $L$ e condensatori $C$) sono caratterizzati dalle seguenti equazioni costitutive:

$ i_C = C ("d"v_C) / ("d"t) = 0, quad v_L = L ("d"i_L) / ("d"t) = 0 $ // VERIFICA: dedotto dall'equazione

Quando invece le correnti e le tensioni sono grandezze variabili nel tempo, ovvero $i = i(t)$ e $v = v(t)$, anche i bipoli dinamici $L$ e $C$ intervengono attivamente nel funzionamento della rete elettrica (ad esempio durante i fenomeni transitori). Tra tutte le possibili leggi di variazione temporale di $i(t)$ e $v(t)$, rivestono particolare importanza in ambito ingegneristico le variazioni di tipo periodico.

== Funzioni periodiche e grandezze caratteristiche

Una grandezza variabile nel tempo $a(t)$ si definisce _periodica_ di periodo $T$ se soddisfa la condizione:

$ a(t_0 + T) = a(t_0) quad forall t_0 $

Al periodo $T$ (misurato in secondi, $"s"$) è associato un valore di frequenza $f$ (misurato in hertz, $"Hz"$), definito come il numero di cicli compiuti nell'unità di tempo:

$ f = 1 / T quad ["Hz" = "s"^(-1)] $

Si definisce _valore medio_ $a_"ave"$ (o $a_m$) della funzione periodica $a(t)$ sul periodo $T$ l'integrale:

$ a_"ave" = a_m = 1 / T integral_(t_0)^(t_0 + T) a(t) "d"t $

#nota[
Le funzioni periodiche aventi valor medio nullo sul periodo ($a_"ave" = 0$) sono denominate *funzioni alternate*.
]

Per le funzioni alternate risulta particolarmente significativo introdurre il _valore efficace_ (detto anche valore _root mean square_, o $"rms"$), indicato con la lettera maiuscola $A$ e definito come la radice quadrata del valor medio del quadrato della funzione sul periodo $T$:

$ A = sqrt(1 / T integral_(t_0)^(t_0 + T) a^2(t) "d"t) $ // VERIFICA: dedotto dall'equazione

Di seguito sono riportati tre esempi di forme d'onda periodiche alternate di periodo $T$ (onda triangolare, onda quadra e onda cosinusoidale):

#align(center)[
  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 1em,
    align: center + horizon,
    [
      #canvas({
        import draw: *
        line((0, -1.5), (0, 1.8), mark: (end: "stealth", fill: black))
        line((-0.3, 0), (4.2, 0), mark: (end: "stealth", fill: black))
        content((4.1, -0.3), $t$)
        content((-0.3, 1.7), $a(t)$)
        line((0, 0), (0.8, 1.1), (2.4, -1.1), (3.2, 0), (3.6, 0.55), stroke: 1.2pt + black)
        line((0, 1.3), (3.2, 1.3), mark: (start: "stealth", end: "stealth", fill: black), stroke: 0.7pt)
        content((1.6, 1.55), $T$)
      })
    ],
    [
      #canvas({
        import draw: *
        line((0, -1.5), (0, 1.8), mark: (end: "stealth", fill: black))
        line((-0.3, 0), (4.2, 0), mark: (end: "stealth", fill: black))
        content((4.1, -0.3), $t$)
        content((-0.3, 1.7), $a(t)$)
        line((0, 1.0), (1.3, 1.0), (1.3, -1.0), (2.6, -1.0), (2.6, 1.0), (3.6, 1.0), (3.6, -1.0), (3.9, -1.0), stroke: 1.2pt + black)
        line((0, -1.3), (2.6, -1.3), mark: (start: "stealth", end: "stealth", fill: black), stroke: 0.7pt)
        content((1.3, -1.6), $T$)
      })
    ],
    [
      #canvas({
        import draw: *
        line((0, -1.5), (0, 1.8), mark: (end: "stealth", fill: black))
        line((-0.3, 0), (4.2, 0), mark: (end: "stealth", fill: black))
        content((4.1, -0.3), $t$)
        content((-0.3, 1.7), $a(t)$)
        bezier((0, 1.1), (1.5, -1.1), (0.6, 1.1), (0.9, -1.1), stroke: 1.2pt + black)
        bezier((1.5, -1.1), (3.0, 1.1), (2.1, -1.1), (2.4, 1.1), stroke: 1.2pt + black)
        line((0, 0.5), (3.0, 0.5), mark: (start: "stealth", end: "stealth", fill: black), stroke: 0.7pt)
        content((1.5, 0.8), $T$)
      })
    ]
  )
]

== Funzioni sinusoidali

Le funzioni sinusoidali costituiscono le forme d'onda principalmente utilizzate nell'ambito dell'elettrotecnica per la generazione, la trasmissione, la distribuzione e il consumo dell'energia elettrica. Due generiche grandezze sinusoidali isofrequenziali si esprimono analiticamente nella forma:

$ a(t) = hat(A) sin(omega t + varphi) $ // VERIFICA: dedotto dall'equazione
$ b(t) = hat(B) sin(omega t + psi) $ // VERIFICA: dedotto dall'equazione

dove i parametri caratteristici assumono il seguente significato fisico:
- $hat(A), hat(B)$: _ampiezza_ o _valore di picco_ (o valore massimo) della sinusoide;
- $omega = 2 pi f = (2 pi) / T$: _frequenza angolare_ o _pulsazione_, misurata in $"rad/s"$;
- $varphi, psi$: _angolo di fase_ (o fase iniziale), misurato in radianti ($"rad"$) o gradi ($circ$).

#nota[
Nella trattazione seguente si farà riferimento unicamente a funzioni di tipo seno, poiché qualunque funzione coseno può essere ricondotta immediatamente a una funzione seno sfruttando l'identità trigonometrica:
$ cos(alpha) = sin(alpha + pi / 2) $
]

=== Esempio di funzione sinusoidale e valore medio

Si consideri una funzione sinusoidale $a(t) = hat(A) sin(omega t + varphi)$ caratterizzata da un valore di picco $hat(A) = 3$, frequenza $f = 50 "Hz"$, periodo $T = 1 / f = 20 "ms"$ e pulsazione $omega = 2 pi f approx 314 "rad/s"$ (o multipli interi come $628 "rad/s"$).

Il valore medio $a_m$ della funzione sinusoidale calcolato su un intero periodo $T$ è identicamente nullo, poiché l'area sottesa dalla semionda positiva compensa esattamente l'area sottesa dalla semionda negativa:

$ a_m = 1 / T integral_(t_0)^(t_0 + T) a(t) "d"t = 1 / T [ integral_(t_0)^(t_0 + T / 2) a(t) "d"t + integral_(t_0 + T / 2)^(t_0 + T) a(t) "d"t ] = 0 $ // VERIFICA: dedotto dall'equazione

L'andamento temporale di $a(t)$ in funzione dell'argomento angolare $omega t in [0, 2 pi]$ per tre differenti valori della fase iniziale ($varphi = 0$, $varphi = pi/2$, $varphi = -pi/2$) è rappresentato nel grafico seguente:

#align(center)[
  #canvas({
    import draw: *
    // Riquadro e griglia
    rect((0, -3), (8, 3), stroke: 0.6pt + black)
    for y in (-2, -1, 0, 1, 2) {
      line((0, y), (8, y), stroke: (paint: gray.lighten(50%), thickness: 0.4pt))
      content((-0.35, y), $#y$)
    }
    content((-0.35, 3), $3$)
    content((-0.35, -3), $-3$)
    content((-0.8, 0), $a(t)$)

    for x in (2, 4, 6) {
      line((x, -3), (x, 3), stroke: (paint: gray.lighten(50%), thickness: 0.4pt))
    }
    content((0, -3.4), $0$)
    content((2, -3.4), $pi / 2$)
    content((4, -3.4), $pi$)
    content((6, -3.4), $(3 pi) / 2$)
    content((8, -3.4), $2 pi$)
    content((4, -4.0), [angolo ($"rad"$)])

    // Asse zero evidenziato
    line((0, 0), (8, 0), stroke: 0.6pt + black)

    // Curva phi = 0: 3 * sin(x)
    bezier((0, 0), (2, 3), (0.8, 1.5), (1.3, 3), stroke: 1.5pt + rgb("#007256"))
    bezier((2, 3), (4, 0), (2.7, 3), (3.2, 1.5), stroke: 1.5pt + rgb("#007256"))
    bezier((4, 0), (6, -3), (4.8, -1.5), (5.3, -3), stroke: 1.5pt + rgb("#007256"))
    bezier((6, -3), (8, 0), (6.7, -3), (7.2, -1.5), stroke: 1.5pt + rgb("#007256"))

    // Curva phi = pi/2 (anticipo): curva traslata a sinistra
    bezier((0, 2.6), (0.67, 3), (0.2, 2.9), (0.4, 3), stroke: 1.2pt + rgb("#d95319"))
    bezier((0.67, 3), (2.67, 0), (1.37, 3), (1.87, 1.5), stroke: 1.2pt + rgb("#d95319"))
    bezier((2.67, 0), (4.67, -3), (3.47, -1.5), (3.97, -3), stroke: 1.2pt + rgb("#d95319"))
    bezier((4.67, -3), (6.67, 0), (5.37, -3), (5.87, -1.5), stroke: 1.2pt + rgb("#d95319"))
    bezier((6.67, 0), (8, 2.6), (7.2, 1.1), (7.7, 2.2), stroke: 1.2pt + rgb("#d95319"))

    // Curva phi = -pi/2 (ritardo): curva traslata a destra
    bezier((0, -2.6), (1.33, 0), (0.3, -2.2), (0.8, -1.1), stroke: 1.2pt + rgb("#edb120"))
    bezier((1.33, 0), (3.33, 3), (2.13, 1.5), (2.63, 3), stroke: 1.2pt + rgb("#edb120"))
    bezier((3.33, 3), (5.33, 0), (4.03, 3), (4.53, 1.5), stroke: 1.2pt + rgb("#edb120"))
    bezier((5.33, 0), (7.33, -3), (6.13, -1.5), (6.63, -3), stroke: 1.2pt + rgb("#edb120"))
    bezier((7.33, -3), (8, -2.6), (7.6, -3), (7.8, -2.9), stroke: 1.2pt + rgb("#edb120"))

    // Freccia ampiezza A_hat
    line((2, 0), (2, 3), mark: (end: "stealth", fill: red), stroke: 1.5pt + red)
    content((2, 3.4), text(fill: red)[$hat(A)$])

    // Freccia periodo T
    line((0, -0.4), (8, -0.4), mark: (start: "stealth", end: "stealth", fill: black), stroke: 0.9pt)
    content((2.3, -0.8), $T$)

    // Legenda
    rect((5.8, 1.3), (7.7, 2.8), fill: white, stroke: 0.5pt + black)
    line((6.0, 2.5), (6.5, 2.5), stroke: 1.5pt + rgb("#007256"))
    content((7.1, 2.5), $varphi = 0$)
    line((6.0, 2.0), (6.5, 2.0), stroke: 1.2pt + rgb("#d95319"))
    content((7.1, 2.0), $varphi = pi / 2$)
    line((6.0, 1.5), (6.5, 1.5), stroke: 1.2pt + rgb("#edb120"))
    content((7.1, 1.5), $varphi = -pi / 2$)
  })
]

=== Valore efficace di una funzione sinusoidale

Applicando la definizione generale di valore efficace a una grandezza sinusoidale $a(t) = hat(A) sin(omega t + varphi)$ si ottiene:

$ A = sqrt(1 / T integral_(t_0)^(t_0 + T) hat(A)^2 sin^2(omega t + varphi) "d"t) $ // VERIFICA: dedotto dall'equazione

Ricordando la formula trigonometrica di Werner:

$ sin(alpha) dot sin(beta) = 1 / 2 [cos(alpha - beta) - cos(alpha + beta)] arrow.r.double sin^2(alpha) = 1 / 2 [1 - cos(2 alpha)] $

e sostituendo $alpha = omega t + varphi$, l'integrale del termine cosinusoidale a pulsazione doppia $2 omega$ esteso a un intero periodo $T$ risulta nullo. Si ricava pertanto la relazione fondamentale tra valore di picco e valore efficace di una sinusoide:

$ A = sqrt(hat(A)^2 / T integral_(t_0)^(t_0 + T) 1 / 2 [1 - cos(2(omega t + varphi))] "d"t) = hat(A) / sqrt(2) $ // VERIFICA: dedotto dall'equazione

== Operazioni sulle grandezze sinusoidali

In un circuito elettrico lineare (costituito da bipoli con parametri $R$, $L$, $C$ costanti nel tempo) alimentato da sorgenti sinusoidali isofrequenziali, tutte le correnti e le tensioni di lato a regime sono anch'esse funzioni sinusoidali caratterizzate dalla medesima pulsazione $omega$.

Le leggi di Kirchhoff e le equazioni costitutive devono essere soddisfatte istante per istante dalle grandezze temporali:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(resistor: (variant: "ieee"))
      resistor("r1", (0, 0), (3.5, 0), n: "o-o", label: (content: $R$, anchor: "south", distance: 6pt), i: (content: $i(t)$, anchor: "south", invert: true, distance: 15pt))
      bezier((3.3, -0.3), (0.2, -0.3), (1.75, -1.2), mark: (end: "stealth", fill: red), stroke: red + 1pt)
      content((1.75, -1.1), text(fill: red)[$v(t) = R i(t)$])
    })
  ],
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      node("n0", (0, 0))
      wire((-1.5, 1.5), (0, 0), i: (content: $i_3(t) med thin$, anchor: "south-west"))
      wire((1.8, 1.0), (0, 0), i: (content: $i_2(t)$, anchor: "north-west"))
      wire((1.2, -1.5), (0, 0), i: (content: $i_1(t)$, anchor: "south-west"))
      wire((0, 0), (-1.5, -1.2), i: (content: $ med thin med thin i_4(t)$, anchor: "north-west"))
    })
    $ i_1(t) + i_2(t) + i_3(t) - i_4(t) = 0 $
  ]
)

Si pone quindi il problema operativo di eseguire somme algebriche (per le leggi di Kirchhoff ai nodi e alle maglie) e derivate temporali (per le equazioni costitutive di induttori e condensatori) su funzioni sinusoidali, determinando il valore efficace e la fase della sinusoide risultante.

=== Somma di due funzioni sinusoidali

Si considerino due funzioni sinusoidali isofrequenziali sfasate tra loro di $pi / 2$:

$ s(t) = sqrt(2) sin(omega t) quad arrow.r.double quad S = sqrt(2) / sqrt(2) = 1 $ // VERIFICA: dedotto dall'equazione
$ c(t) = sqrt(2) cos(omega t) = sqrt(2) sin(omega t + pi / 2) quad arrow.r.double quad C = sqrt(2) / sqrt(2) = 1 $ // VERIFICA: dedotto dall'equazione

La somma istantanea delle due sinusoidi è data da:

$ r(t) = s(t) + c(t) = sqrt(2) sin(omega t) + sqrt(2) sin(omega t + pi / 2) $ // VERIFICA: dedotto dall'equazione

Applicando la formula di prostaferesi:

$ sin(alpha) + sin(beta) = 2 sin((alpha + beta) / 2) cos((alpha - beta) / 2) $

e ponendo $alpha = omega t$ e $beta = omega t + pi / 2$, si ottiene che la grandezza risultante è ancora una sinusoide di pulsazione $omega$:

$ s(t) + c(t) = 2 sqrt(2) sin(omega t + pi / 4) cos(-pi / 4) = 2 sin(omega t + pi / 4) $ // VERIFICA: dedotto dall'equazione

Il valore efficace della sinusoide risultante è pertanto pari a:

$ R = 2 / sqrt(2) = sqrt(2) $

#nota[
Si osservi che il valore efficace della somma di due sinusoidi *non* è uguale alla somma algebrica dei singoli valori efficaci ($R = sqrt(2) != S + C = 1 + 1 = 2$), e il calcolo trigonometrico diretto nel dominio del tempo non risulta immediato.
]

#align(center)[
  #canvas({
    import draw: *
    rect((0, -2), (6.28, 2), stroke: 0.6pt + black)
    for y in (-1.5, -1, -0.5, 0, 0.5, 1, 1.5) {
      line((0, y), (6.28, y), stroke: (paint: gray.lighten(60%), thickness: 0.4pt))
    }
    for y in (-2, -1, 0, 1, 2) {
      content((-0.4, y), $#y$)
    }
    for x in (1, 2, 3, 4, 5, 6) {
      line((x, -2), (x, 2), stroke: (paint: gray.lighten(60%), thickness: 0.4pt))
      content((x, -2.35), $#x$)
    }
    content((0, -2.35), $0$)
    content((3.14, -2.85), [angolo ($"rad"$)])
    line((0, 0), (6.28, 0), stroke: 0.6pt + black)

    // s(t) = sqrt(2) sin(x) (rosso)
    bezier((0, 0), (1.57, 1.41), (0.6, 0.7), (1.0, 1.41), stroke: 1.2pt + red)
    bezier((1.57, 1.41), (3.14, 0), (2.14, 1.41), (2.54, 0.7), stroke: 1.2pt + red)
    bezier((3.14, 0), (4.71, -1.41), (3.74, -0.7), (4.14, -1.41), stroke: 1.2pt + red)
    bezier((4.71, -1.41), (6.28, 0), (5.31, -1.41), (5.71, -0.7), stroke: 1.2pt + red)
    content((3.4, 0.4), text(fill: red)[$s(t)$])

    // c(t) = sqrt(2) cos(x) (verde/nero)
    bezier((0, 1.41), (1.57, 0), (0.57, 1.41), (0.97, 0.7), stroke: 1.2pt + rgb("#00a000"))
    bezier((1.57, 0), (3.14, -1.41), (2.17, -0.7), (2.57, -1.41), stroke: 1.2pt + rgb("#00a000"))
    bezier((3.14, -1.41), (4.71, 0), (3.71, -1.41), (4.11, -0.7), stroke: 1.2pt + rgb("#00a000"))
    bezier((4.71, 0), (6.28, 1.41), (5.31, 0.7), (5.71, 1.41), stroke: 1.2pt + rgb("#00a000"))
    content((1.2, -0.6), text(fill: rgb("#00a000"))[$c(t)$])

    // s(t) + c(t) = 2 sin(x + pi/4) (blu)
    bezier((0, 1.41), (0.785, 2.0), (0.25, 1.8), (0.5, 2.0), stroke: 1.4pt + blue)
    bezier((0.785, 2.0), (2.356, 0), (1.35, 2.0), (1.75, 1.0), stroke: 1.4pt + blue)
    bezier((2.356, 0), (3.927, -2.0), (2.95, -1.0), (3.35, -2.0), stroke: 1.4pt + blue)
    bezier((3.927, -2.0), (5.498, 0), (4.5, -2.0), (4.9, -1.0), stroke: 1.4pt + blue)
    bezier((5.498, 0), (6.28, 1.41), (5.8, 0.5), (6.05, 1.0), stroke: 1.4pt + blue)
    content((2.6, 1.65), text(fill: blue)[$s(t) + c(t)$])
  })
]

=== Derivata temporale di una funzione sinusoidale

Si consideri ora una generica funzione sinusoidale a fase iniziale nulla, avente valore efficace $S$:

$ s(t) = sqrt(2) S sin(omega t) $ // VERIFICA: dedotto dall'equazione

La sua derivata rispetto al tempo (operazione richiesta, ad esempio, nelle equazioni costitutive di un induttore o di un condensatore) vale:

$ d(t) = ("d"s(t)) / ("d"t) = omega sqrt(2) S cos(omega t) $ // VERIFICA: dedotto dall'equazione

Ricordando dalla trigonometria l'identità $cos(alpha) = sin(alpha + pi / 2)$, la derivata può essere riscritta nella forma:

$ d(t) = ("d"s(t)) / ("d"t) = omega sqrt(2) S sin(omega t + pi / 2) $ // VERIFICA: dedotto dall'equazione

La derivata temporale di una sinusoide di pulsazione $omega$ e valore efficace $S$ è dunque una nuova sinusoide avente la stessa pulsazione $omega$, valore efficace amplificato di un fattore $omega$ (ossia pari a $omega S$) e sfasata in anticipo di $pi / 2$ radianti ($90 circ$).

== Dalle funzioni sinusoidali al metodo simbolico

Le proprietà analitiche verificate negli esempi precedenti consentono di enunciare due risultati generali:
1. La somma algebrica di più funzioni sinusoidali di pulsazione $omega$ è anch'essa una funzione sinusoidale di identica pulsazione $omega$.
2. La derivata rispetto al tempo di una funzione sinusoidale di pulsazione $omega$ è anch'essa una funzione sinusoidale di identica pulsazione $omega$.

Questi due fatti rivestono un'importanza fondamentale nell'analisi dei circuiti lineari (ovvero i circuiti in cui i parametri $R$, $L$ e $C$ sono costanti). Per studiare in modo algebricamente semplice le reti elettriche in regime sinusoidale, evitando di risolvere equazioni integro-differenziali nel dominio del tempo, si ricorre al concetto di *vettore rotante* introdotto da Steinmetz, rappresentando le grandezze sinusoidali mediante numeri complessi (*metodo simbolico*).

=== Richiami sui numeri complessi

Il metodo simbolico stabilisce una corrispondenza biunivoca fra le grandezze sinusoidali isofrequenziali, i vettori rotanti nel piano e i numeri complessi, definendo un formalismo algebrico diretto per la risoluzione dei circuiti.

#grid(
  columns: (1.1fr, 0.9fr),
  column-gutter: 1.5em,
  align: (left + horizon, center + horizon),
  [
    Nel piano complesso di Gauss (avente l'asse reale $"Re"$ in ascissa e l'asse immaginario $"Im"$ in ordinata), definita l'unità immaginaria $j = sqrt(-1)$ (tale che $j^2 = -1$), un generico numero complesso $macron(z)$ può essere espresso in due forme equivalenti:

    - *Forma cartesiana (o binomia)*:
      $ macron(z) = a + j b $
      dove $a = "Re"[macron(z)]$ è la parte reale e $b = "Im"[macron(z)]$ è la parte immaginaria.

    - *Forma polare (o esponenziale)*:
      $ macron(z) = |macron(z)| e^(j theta) = z e^(j theta) $
      dove $z = |macron(z)| = sqrt(a^2 + b^2)$ rappresenta il _modulo_ del numero complesso e $theta = angle macron(z)$ ne rappresenta l'_argomento_ (o anomalia).
  ],
  [
    #canvas({
      import draw: *
      // Assi Re e Im
      line((-0.8, 0), (4.2, 0), mark: (end: "stealth", fill: black), stroke: 0.8pt)
      line((0, -0.6), (0, 3.6), mark: (end: "stealth", fill: black), stroke: 0.8pt)
      content((4.0, -0.4), sans("Re", size: 11pt))
      content((-0.45, 3.4), sans("Im", size: 11pt))

      // Proiezioni tratteggiate
      line((0, 2.3), (3.0, 2.3), stroke: (paint: red, dash: "dashed", thickness: 0.8pt))
      line((3.0, 0), (3.0, 2.3), stroke: (paint: red, dash: "dashed", thickness: 0.8pt))
      content((3.0, -0.35), $a$)
      content((-0.3, 2.3), $b$)

      // Vettore z
      line((0, 0), (3.0, 2.3), stroke: 1.8pt + red)
      circle((3.0, 2.3), radius: 0.08, fill: black, stroke: red + 1pt)
      content((3.3, 2.65), $macron(z)$)
      content((1.3, 1.5), $|macron(z)|$)

      // Versore immaginario j
      line((0, 0), (0, 0.9), mark: (end: "stealth", fill: red), stroke: 2.5pt + red)
      content((-0.35, 0.5), $j$)
      content((-1.1, 1.4), $j = sqrt(-1)$)

      // Arco angolo theta
      arc((1.1, 0), start: 0deg, stop: 37.5deg, radius: 1.1, mark: (end: "stealth", fill: black), stroke: 0.8pt)
      content((2.1, 0.45), $theta = angle macron(z)$)
    })
  ]
)

// ==========================================
// SLIDE 16 - 30
// ==========================================

= Il Metodo Simbolico e i Fasori

== Formula di Gauss e Formule di Conversione

Un numero complesso $macron(z) = a + j b$ può essere rappresentato in forma esponenziale (o polare) mediante la formula di Gauss (o di Eulero):

$ macron(z) = |macron(z)| e^(j phi) = |macron(z)| (cos phi + j sin phi) $

Le relazioni di conversione tra la forma cartesiana (rettangolare) e la forma polare (esponenziale) sono espresse dal seguente sistema:

$ cases(
  |macron(z)| = sqrt(a^2 + b^2) = z,
  phi = arctan(b / a)
) quad arrow.l.r.double quad cases(
  a = "Re"[macron(z)] = |macron(z)| cos phi,
  b = "Im"[macron(z)] = |macron(z)| sin phi
) $

#nota[
Nella determinazione dell'argomento $phi$ tramite la funzione arcotangente, occorre tenere conto del quadrante in cui giace il numero complesso nel piano di Gauss:
- se $a > 0$ (I e IV quadrante): $phi = arctan(b / a)$;
- se $a < 0$ (II e III quadrante): $phi = arctan(b / a) + pi$ (oppure $- pi$).
]

== Analogia tra Funzioni Sinusoidali e Numeri Complessi (Vettori Rotanti)

Un punto nel piano complesso che ruota attorno all'origine su un'orbita circolare di raggio $|macron(z)| = hat(F)$ con velocità angolare $omega$ costante e posizione angolare all'istante $t = 0$ uguale a $phi$, è descritto dal numero complesso funzione del tempo (detto *vettore rotante*):

$ macron(z)(t) = |macron(z)| e^(j (omega t + phi)) = hat(F) e^(j (omega t + phi)) $

Sviluppando l'esponenziale complesso secondo la formula di Eulero, si ottengono le proiezioni del vettore rotante sugli assi reale e immaginario:

$ macron(z)(t) = hat(F) cos(omega t + phi) + j hat(F) sin(omega t + phi) $

dove le singole componenti temporali sono:

$ cases(
  a(t) = "Re"[macron(z)(t)] = hat(F) cos(omega t + phi),
  b(t) = "Im"[macron(z)(t)] = hat(F) sin(omega t + phi)
) $

#align(center)[
  #canvas({
    import draw: *
    // Assi
    line((-0.8, 0), (4.5, 0), mark: (end: "stealth", fill: black))
    content((4.5, -0.35), $"Re"$)
    line((0, -0.8), (0, 3.2), mark: (end: "stealth", fill: black))
    content((-0.4, 3.0), $"Im"$)

    // Vettore rotante z(t)
    let ang = 32deg
    let r = 3.0
    line((0, 0), (r * calc.cos(ang), r * calc.sin(ang)), stroke: (paint: red, thickness: 1.5pt))
    circle((r * calc.cos(ang), r * calc.sin(ang)), radius: 0.07, fill: red, stroke: red)
    content((r * calc.cos(ang) + 0.6, r * calc.sin(ang) + 0.25), text(fill: red)[$macron(z)(t)$])

    // Arco angolo wt + phi
    arc((1.2, 0), start: 0deg, stop: ang, radius: 1.2, stroke: (paint: rgb("#006633"), thickness: 1pt))
    content((2.3, 0.55), text(fill: rgb("#006633"))[$omega t + phi$])

    // Freccia di rotazione omega
    arc((1.5 * calc.cos(15deg), 1.5 * calc.sin(15deg)), start: 15deg, stop: 65deg, radius: 1.5, stroke: (paint: rgb("#006633"), thickness: 1.2pt), mark: (end: "stealth", fill: rgb("#006633")))
    content((1.4, 2.0), text(fill: rgb("#006633"))[$omega$])
  })
]

Esiste quindi una corrispondenza biunivoca tra il vettore rotante $macron(z)(t)$ e la funzione sinusoidale $f(t) = hat(F) sin(omega t + phi)$, ottenuta applicando l'operatore parte immaginaria:

$ f(t) = hat(F) sin(omega t + phi) = "Im"[macron(z)(t)] = "Im"[hat(F) e^(j (omega t + phi))] $

== Regola di Derivazione nel Dominio Complesso

La corrispondenza tra funzione sinusoidale e numero complesso si conserva anche per l'operazione di derivazione rispetto al tempo:

$ f(t) arrow.l.r macron(z)(t) quad arrow.r.double quad (dif f(t)) / (dif t) arrow.l.r (dif macron(z)(t)) / (dif t) $

Nel dominio del tempo, la derivata della funzione sinusoidale $f(t) = hat(F) sin(omega t + phi)$ vale:

$ (dif f(t)) / (dif t) = omega hat(F) cos(omega t + phi) = omega hat(F) sin(omega t + phi + pi / 2) $

Derivando direttamente il vettore rotante $macron(z)(t) = hat(F) e^(j (omega t + phi))$ rispetto al tempo si ottiene:

$ (dif macron(z)(t)) / (dif t) = (dif) / (dif t) [hat(F) e^(j (omega t + phi))] = j omega hat(F) e^(j (omega t + phi)) $

#grid(
  columns: (1.3fr, 1fr),
  column-gutter: 1.5em,
  align: (left + horizon, center + horizon),
  [
    Poiché l'unità immaginaria $j$ (ovvero un numero complesso puramente immaginario $macron(c) = 0 + j 1$) ha modulo unitario e argomento pari a $pi / 2$:
    $ j = 1 e^(j pi / 2) = cos(pi / 2) + j sin(pi / 2) $
    la moltiplicazione per $j omega$ equivale a moltiplicare il modulo per $omega$ e ad anticipare la fase di $pi / 2$:
    $ (dif macron(z)(t)) / (dif t) = omega e^(j pi / 2) hat(F) e^(j (omega t + phi)) = omega hat(F) e^(j (omega t + phi + pi / 2)) $
  ],
  [
    #canvas({
      import draw: *
      line((-0.8, 0), (2.2, 0), mark: (end: "stealth", fill: black))
      content((2.2, -0.35), $"Re"$)
      line((0, -0.8), (0, 2.2), mark: (end: "stealth", fill: black))
      content((-0.45, 2.1), $"Im"$)

      // Vettore c = j sull'asse immaginario
      line((0, 0), (0, 1.3), stroke: (paint: red, thickness: 2pt), mark: (end: "stealth", fill: red))
      content((-0.4, 1.2), text(fill: red)[$macron(c) = j$])

      // Angolo retto pi/2
      line((0.25, 0), (0.25, 0.25), (0, 0.25), stroke: (paint: rgb("#006633"), thickness: 1pt))
      content((0.65, 0.5), text(fill: rgb("#006633"))[$pi / 2$])
    })
  ]
)

Prendendo la parte immaginaria della derivata complessa si ritrova esattamente la derivata temporale della funzione sinusoidale:

$ (dif f(t)) / (dif t) = "Im"[(dif macron(z)(t)) / (dif t)] = "Im"[j omega macron(z)(t)] = "Im"[omega hat(F) e^(j (omega t + phi + pi / 2))] = omega hat(F) sin(omega t + phi + pi / 2) $

== Dai Vettori Rotanti ai Fasori

Una qualunque funzione sinusoidale $f(t)$ può essere associata a un vettore rotante $macron(z)(t)$. Esplicitando il valore efficace $F = hat(F) / sqrt(2)$ (da cui $hat(F) = sqrt(2) F$) e applicando le proprietà delle potenze all'esponenziale complesso, si può separare la dipendenza dalla fase iniziale $phi$ da quella temporale $omega t$:

$ macron(z)(t) = hat(F) e^(j (omega t + phi)) = sqrt(2) F e^(j (omega t + phi)) = sqrt(2) underbrace(F e^(j phi), macron(F)) e^(j omega t) = sqrt(2) macron(F) e^(j omega t) $

#grid(
  columns: (1.2fr, 1fr),
  column-gutter: 1.5em,
  align: (left + horizon, center + horizon),
  [
    In un circuito lineare alimentato in regime sinusoidale a pulsazione costante $omega$, tutti i vettori rotanti $macron(z)_1(t), macron(z)_2(t), dots$ ruotano alla stessa velocità angolare $omega$:
    - il fattore di rotazione temporale $e^(j omega t)$ (così come la costante $sqrt(2)$) è identico in ogni numero complesso;
    - la quantità complessa $macron(F) = F e^(j phi)$ *non dipende dal tempo $t$* e racchiude tutta l'informazione caratteristica della sinusoide: il valore efficace $F$ (modulo) e la fase iniziale $phi$ (argomento).
  ],
  [
    #canvas({
      import draw: *
      line((-0.6, 0), (3.8, 0), mark: (end: "stealth", fill: black))
      content((3.8, -0.35), $"Re"$)
      line((0, -0.6), (0, 2.8), mark: (end: "stealth", fill: black))
      content((-0.45, 2.7), $"Im"$)

      let a1 = 18deg
      let r1 = 2.6
      let a2 = 48deg
      let r2 = 2.2

      // Vettore z1(t)
      line((0, 0), (r1 * calc.cos(a1), r1 * calc.sin(a1)), stroke: (paint: rgb("#006633"), thickness: 1.4pt))
      circle((r1 * calc.cos(a1), r1 * calc.sin(a1)), radius: 0.05, fill: rgb("#006633"))
      content((r1 * calc.cos(a1) + 0.5, r1 * calc.sin(a1) + 0.15), text(fill: rgb("#006633"))[$macron(z)_1(t)$])
      arc((1.6, 0), start: 0deg, stop: a1, radius: 1.6, stroke: (paint: rgb("#006633")))
      content((2.4, 0.3), text(fill: rgb("#006633"), size: 9pt)[$omega t + phi_1$])

      // Vettore z2(t)
      line((0, 0), (r2 * calc.cos(a2), r2 * calc.sin(a2)), stroke: (paint: red, thickness: 1.4pt))
      circle((r2 * calc.cos(a2), r2 * calc.sin(a2)), radius: 0.05, fill: red)
      content((r2 * calc.cos(a2) + 0.45, r2 * calc.sin(a2) + 0.2), text(fill: red)[$macron(z)_2(t)$])
      arc((0.8, 0), start: 0deg, stop: a2, radius: 0.8, stroke: (paint: red))
      content((0.7, 1.6), text(fill: red, size: 9pt)[$omega t + phi_2$])
    })
  ]
)

#nota[
*Definizione di Fasore:* La grandezza complessa tempo-invariante
$ macron(F) = F e^(j phi) = F (cos phi + j sin phi) $
è detta *fasore* associato alla funzione sinusoidale $f(t) = sqrt(2) F sin(omega t + phi)$. Esso è rappresentato nel piano complesso da un vettore fisso avente modulo coincidente con il *valore efficace* $F$ della sinusoide e angolo coincidente con la *fase iniziale* $phi$.
L'uso dei fasori consente di studiare i vettori rotanti come se fossero "fotografati" nell'istante $t = 0$ durante la loro rotazione sincrona.
]

#align(center)[
  #canvas({
    import draw: *
    line((-0.8, 0), (3.5, 0), mark: (end: "stealth", fill: black))
    content((3.2, -0.4), sans($"Re"$, size: 12pt))
    line((0, -0.6), (0, 2.5), mark: (end: "stealth", fill: black))
    content((-0.45, 2.2), sans($"Im"$, size: 12pt))

    let ang = 33deg
    let r = 2.6
    line((0, 0), (r * calc.cos(ang), r * calc.sin(ang)), stroke: (paint: red, thickness: 2pt), mark: (end: "stealth", fill: red))
    content((r * calc.cos(ang) + 0.35, r * calc.sin(ang) + 0.1), text(size: 13pt)[$macron(F)$])
    content((1.0, 1.15), text(size: 12pt)[$F$])

    arc((1.1, 0), start: 0deg, stop: ang, radius: 1.1, stroke: (paint: black, thickness: 1pt), mark: (end: "stealth", fill: black))
    content((1.4, 0.35), text(size: 12pt)[$phi$])
  })
]

=== Fasore e Regola di Derivazione

Il fasore è particolarmente efficace per esprimere algebricamente e graficamente la regola di derivazione. Poiché una funzione sinusoidale si scrive in funzione del proprio fasore $macron(F)$ come:

$ f(t) = "Im"[sqrt(2) F e^(j phi) e^(j omega t)] = "Im"[sqrt(2) macron(F) e^(j omega t)] $

la sua derivata temporale vale:

$ (dif f(t)) / (dif t) = "Im"[sqrt(2) j omega F e^(j phi) e^(j omega t)] = "Im"[sqrt(2) (j omega macron(F)) e^(j omega t)] = "Im"[sqrt(2) macron(F)' e^(j omega t)] $

Il fasore $macron(F)'$ associato alla derivata $(dif f(t)) / (dif t)$ si ottiene quindi moltiplicando il fasore originario $macron(F)$ per l'operatore complesso $j omega$:

$ macron(F)' = j omega macron(F) = j omega F e^(j phi) = omega F e^(j (phi + pi / 2)) $

#align(center)[
  #canvas({
    import draw: *
    line((-1.8, 0), (3.2, 0), mark: (end: "stealth", fill: black))
    content((2.9, -0.4), sans($"Re"$, size: 12pt))
    line((0, -0.6), (0, 2.8), mark: (end: "stealth", fill: black))
    content((-0.45, 2.5), sans($"Im"$, size: 12pt))

    let ang = 30deg
    let rF = 2.2
    let rFp = 2.6
    let angp = ang + 90deg

    // Fasore F
    line((0, 0), (rF * calc.cos(ang), rF * calc.sin(ang)), stroke: (paint: red, thickness: 2pt), mark: (end: "stealth", fill: red))
    content((rF * calc.cos(ang) + 0.35, rF * calc.sin(ang) + 0.1), text(size: 12pt)[$macron(F)$])

    // Fasore F' = j omega F (ruotato di 90 gradi)
    line((0, 0), (rFp * calc.cos(angp), rFp * calc.sin(angp)), stroke: (paint: red, thickness: 2pt), mark: (end: "stealth", fill: red))
    content((rFp * calc.cos(angp) - 0.35, rFp * calc.sin(angp) - 0.3), text(size: 12pt)[$macron(F)'$])

    // Angolo retto tra F e F'
    let s = 0.28
    let p1 = (s * calc.cos(ang), s * calc.sin(ang))
    let p2 = (s * calc.cos(ang) + s * calc.cos(angp), s * calc.sin(ang) + s * calc.sin(angp))
    let p3 = (s * calc.cos(angp), s * calc.sin(angp))
    line(p1, p2, p3, stroke: (paint: red, thickness: 0.8pt))

    // Archi angoli
    arc((1.1, 0), start: 0deg, stop: ang, radius: 1.1, stroke: (paint: black, thickness: 0.9pt), mark: (end: "stealth", fill: black))
    content((1.35, 0.3), text(size: 11pt)[$phi$])

    arc((0.7, 0), start: 0deg, stop: angp, radius: 0.7, stroke: (paint: black, thickness: 0.9pt), mark: (end: "stealth", fill: black))
    content((0.75, 1.15), text(size: 11pt)[$phi + pi / 2$])
  })
]

=== Esempi di Trasformazione tra Dominio del Tempo e Dominio dei Fasori

*Esempio 1 (Dal dominio del tempo al fasore):*
Data la corrente sinusoidale $a(t) = 10 sin(omega t + pi / 4) "A"$, il suo valore massimo è $hat(A) = 10 "A"$, da cui il valore efficace è $A = 10 / sqrt(2) approx 7.07 "A"$. Il fasore corrispondente vale:

$ macron(A) = 10 / sqrt(2) e^(j pi / 4) = 7.07 (cos(pi / 4) + j sin(pi / 4)) = 5 + j 5 "A" $

(Analogamente, per un valore massimo pari a $5 "A"$, si ha $macron(A) = 5 / sqrt(2) e^(j pi / 4) = 3.54 + j 3.54 "A"$). // VERIFICA: dedotto dall'equazione

*Esempio 2 (Dal fasore in forma cartesiana al dominio del tempo):*
Dato il fasore di tensione $macron(C) = -3 + j 7 "V"$, si vogliono determinare il modulo (valore efficace $C$), la fase $phi_C$ e l'espressione temporale $c(t)$.

#grid(
  columns: (1.2fr, 1fr),
  column-gutter: 1.5em,
  align: (left + horizon, center + horizon),
  [
    Il modulo del fasore vale:
    $ C = |macron(C)| = sqrt((-3)^2 + 7^2) = sqrt(9 + 49) = sqrt(58) approx 7.62 "V" $
    Poiché la parte reale è negativa ($"Re"[macron(C)] = -3 < 0$) e la parte immaginaria è positiva ($"Im"[macron(C)] = 7 > 0$), il fasore $macron(C)$ si trova nel *secondo quadrante*. La funzione $arctan(7 / (-3))$ fornisce invece l'angolo nel quarto quadrante ($-1.166 "rad" = -66.8^circ$); occorre quindi sommare $pi$ (ovvero $180^circ$):
    $ phi_C = arctan(7 / (-3)) + pi = -1.166 + pi = 1.976 "rad" approx 113.2^circ $
    La corrispondente funzione del tempo è pertanto:
    $ c(t) = sqrt(2) C sin(omega t + phi_C) = sqrt(2) dot 7.62 sin(omega t + 1.976) "V" $
  ],
  [
    #canvas({
      import draw: *
      line((-1.8, 0), (2.2, 0), mark: (end: "stealth", fill: black))
      content((2.2, -0.35), $"Re"$)
      line((0, -1.8), (0, 2.4), mark: (end: "stealth", fill: black))
      content((0.45, 2.2), $"Im"$)

      // Fasore vero nel II quadrante (-0.9, 2.1)
      line((0, 0), (-0.9, 2.1), stroke: (paint: red, thickness: 1.5pt), mark: (end: "stealth", fill: red))
      content((-1.3, 2.1), text(fill: red)[$macron(C)$])
      line((-0.9, 0), (-0.9, 2.1), stroke: (paint: red, dash: "dashed"))
      line((0, 2.1), (-0.9, 2.1), stroke: (paint: red, dash: "dashed"))

      // Fasore errato nel IV quadrante (0.7, -1.6)
      line((0, 0), (0.7, -1.6), stroke: (paint: red, dash: "dotted", thickness: 1.2pt), mark: (end: "stealth", fill: red))

      // Angoli
      arc((0.45, 0), start: 0deg, stop: 113.2deg, radius: 0.45, stroke: (paint: red))
      content((0.8, 0.8), text(fill: red, size: 9pt)[$-1.166 + pi$])
      arc((0.35, 0), start: 0deg, stop: -66.8deg, radius: 0.35, stroke: (paint: red))
      content((1.1, -0.45), text(fill: red, size: 8pt)[$-1.166 "rad"$])
    })
  ]
)

= Equazioni Circuitali e Costitutive in Forma Fasoriale

== Leggi di Kirchhoff in Forma Fasoriale (LKC e LKT)

Considerando una rete lineare tempo-invariante (LTI) alimentata da un ingresso sinusoidale a pulsazione $omega$, a regime tutte le variabili di rete (tensioni e correnti) sono funzioni sinusoidali *isofrequenziali* con l'ingresso (ossia aventi la medesima pulsazione $omega$).

Consideriamo ad esempio un nodo a cui afferiscono tre correnti $i_1(t)$, $i_2(t)$ (entranti) e $i_3(t)$ (uscente). La Legge di Kirchhoff delle Correnti (LKC) nel dominio del tempo e la sua corrispondente forma fasoriale si scrivono:

$ i_1(t) + i_2(t) - i_3(t) = 0 quad arrow.l.r.double quad macron(I)_1 + macron(I)_2 - macron(I)_3 = 0 quad arrow.l.r.double quad macron(I)_3 = macron(I)_1 + macron(I)_2 $

#align(center)[
  #canvas({
    import draw: *
    // --- Nodo nel dominio del tempo (sinistra) ---
    circle((-4.5, 1.0), radius: 0.08, fill: black)
    line((-5.5, 2.0), (-4.58, 1.08), stroke: (paint: red, thickness: 1.3pt), mark: (end: "stealth", fill: red))
    content((-5.5, 2.3), text(fill: red)[$i_1(t)$])
    line((-4.6, -0.2), (-4.51, 0.9), stroke: (paint: red, thickness: 1.3pt), mark: (end: "stealth", fill: red))
    content((-4.0, 0.2), text(fill: red)[$i_2(t)$])
    line((-4.42, 1.05), (-3.3, 1.6), stroke: (paint: red, thickness: 1.3pt), mark: (end: "stealth", fill: red))
    content((-2.9, 1.6), text(fill: red)[$i_3(t)$])

    // --- Diagramma fasoriale (centro) ---
    line((-1.5, 0), (2.0, 0), mark: (end: "stealth", fill: black))
    content((2.35, 0), $"Re"$)
    line((-1.0, -0.4), (-1.0, 2.4), mark: (end: "stealth", fill: black))
    content((-1.35, 2.3), $"Im"$)

    // Origine del piano complesso a (-1.0, 0)
    let ox = -1.0
    let oy = 0.0
    // I1 = (1.1, 0.45)
    line((ox, oy), (ox + 1.1, oy + 0.45), stroke: (paint: rgb("#008000"), thickness: 1.5pt), mark: (end: "stealth", fill: rgb("#008000")))
    content((ox + 1.3, oy + 0.3), text(fill: rgb("#008000"))[$macron(I)_1$])

    // I2 = (0.8, 0.7)
    line((ox, oy), (ox + 0.8, oy + 0.7), stroke: (paint: rgb("#cc6600"), thickness: 1.5pt), mark: (end: "stealth", fill: rgb("#cc6600")))
    content((ox + 0.55, oy + 0.95), text(fill: rgb("#cc6600"))[$macron(I)_2$])

    // Traslazione punta-coda di I2
    line((ox + 1.1, oy + 0.45), (ox + 1.9, oy + 1.15), stroke: (paint: rgb("#cc6600"), dash: "dashed", thickness: 1.2pt), mark: (end: "stealth", fill: rgb("#cc6600")))
    content((ox + 1.95, oy + 0.85), text(fill: rgb("#cc6600"))[$macron(I)_2$])

    // Risultante I3 = I1 + I2 = (1.9, 1.15)
    line((ox, oy), (ox + 1.9, oy + 1.15), stroke: (paint: blue, thickness: 1.6pt), mark: (end: "stealth", fill: blue))
    content((ox + 1.9, oy + 1.55), text(fill: blue)[$macron(I)_3 = macron(I)_1 + macron(I)_2$])

    // --- Nodo nel dominio dei fasori (destra) ---
    circle((4.5, 1.0), radius: 0.08, fill: black)
    line((3.4, 1.7), (4.4, 1.06), stroke: (paint: red, thickness: 1.3pt), mark: (end: "stealth", fill: red))
    content((3.4, 1.1), text(fill: red)[$macron(I)_1$])
    line((4.5, -0.2), (4.5, 0.9), stroke: (paint: red, thickness: 1.3pt), mark: (end: "stealth", fill: red))
    content((5.0, 0.2), text(fill: red)[$macron(I)_2$])
    line((4.58, 1.06), (5.6, 1.8), stroke: (paint: red, thickness: 1.3pt), mark: (end: "stealth", fill: red))
    content((5.8, 1.3), text(fill: red)[$macron(I)_3$])
  })
]

#nota[
Attraverso l'uso del metodo simbolico e dei fasori, la Legge di Kirchhoff delle Correnti (LKC) e la Legge di Kirchhoff delle Tensioni (LKT) si trasformano da equazioni istantanee nel tempo in *somme algebriche di numeri complessi* (ovvero somme vettoriali nel piano di Gauss):
$ sum_k macron(I)_k = 0, quad sum_k macron(V)_k = 0 $
]

== Equazioni Costitutive dei Bipoli in Forma Fasoriale
=== Equazione Costitutiva del Resistore in Forma Fasoriale

Si consideri un resistore lineare tempo-invariante (LTI) di resistenza $R$, governato con la convenzione degli utilizzatori e alimentato da una corrente sinusoidale $i(t) = sqrt(2) I sin(omega t + phi_I)$.

#grid(
  columns: (0.8fr, 1.2fr),
  column-gutter: 1.5em,
  align: (center + horizon, left + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(resistor: (variant: "ieee"))

      resistor("r", (0, 3), (0, 0), n: "o-o", label: (content: $R$, anchor: "west", distance: 8pt))

      // Freccia corrente i(t) dall'alto
      line((0, 3.6), (0, 3.15), stroke: (paint: red, thickness: 1.3pt), mark: (end: "stealth", fill: red))
      content((0.65, 3.4), text(fill: red)[$i(t)$])

      // Freccia curva tensione v(t)
      bezier((-0.35, 0.1), (-0.35, 2.9), (-0.75, 1.5), stroke: (paint: blue, thickness: 1.2pt), mark: (end: "stealth", fill: blue))
      content((-1.05, 1.5), text(fill: blue)[$v(t)$])
    })
  ],
  [
    Nel dominio del tempo la legge di Ohm stabilisce la proporzionalità diretta tra tensione e corrente:
    $ v(t) = R i(t) $
    Passando ai corrispondenti fasori $macron(V) = V e^(j phi_V)$ e $macron(I) = I e^(j phi_I)$, il fasore della tensione ai capi del resistore $R$ diventa:
    $ macron(V) = R macron(I) quad arrow.l.r.double quad V e^(j phi_V) = R I e^(j phi_I) $
    Uguagliando moduli e argomenti dei due membri si ottengono le due relazioni scalari:
    $ cases(
      V = R I,
      phi_V = phi_I
    ) $
  ]
)

#nota[
Poiché in un resistore risulta $phi_V = phi_I$ (lo sfasamento tra tensione e corrente è nullo, $Delta phi = phi_V - phi_I = 0$), i fasori $macron(V)$ e $macron(I)$ sono paralleli e concordi nel piano complesso: si dice pertanto che *in un resistore la tensione e la corrente sono in fase*. Nel dominio del tempo, le due sinusoidi $v(t)$ e $i(t)$ raggiungono contemporaneamente i rispettivi valori massimi, minimi e passaggi per lo zero.
]

#grid(
  columns: (1fr, 1.2fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #canvas({
      import draw: *
      // Diagramma fasoriale del resistore
      line((-0.6, 0), (3.6, 0), mark: (end: "stealth", fill: black))
      content((3.4, -0.4), $italic("Re")$)
      line((0, -0.6), (0, 2.6), mark: (end: "stealth", fill: black))
      content((-0.45, 2.4), $italic("Im")$)

      let ang = 34deg
      let rV = 2.0
      let rI = 3.1

      // Fasore I
      line((0, 0), (rI * calc.cos(ang), rI * calc.sin(ang)), stroke: (paint: black, thickness: 1.5pt), mark: (end: "stealth", fill: black))
      content((rI * calc.cos(ang) - 0.35, rI * calc.sin(ang) + 0.3), text(size: 12pt)[$macron(I)$])

      // Fasore V (collineare)
      line((0, 0), (rV * calc.cos(ang), rV * calc.sin(ang)), stroke: (paint: black, thickness: 1.5pt), mark: (end: "stealth", fill: black))
      content((rV * calc.cos(ang) - 0.35, rV * calc.sin(ang) + 0.25), text(size: 12pt)[$macron(V)$])

      // Arco angolo phi_I = phi_V
      arc((1.15, 0), start: 0deg, stop: ang, radius: 1.15, stroke: (paint: black, thickness: 0.8pt), mark: (end: "stealth", fill: black))
      content((2.15, 0.45), text(size: 11pt)[$phi_I = phi_V$])
    })
  ],
  [
    #canvas({
      import draw: *
      // Grafico temporale v(t) e i(t) in fase
      let w = 4.8
      let h = 2.0

      // Griglia verticale per T/4, T/2, 3T/4, T
      for k in (1, 2, 3) {
        let xk = k * w / 4
        line((xk, -h), (xk, h), stroke: (paint: gray.lighten(40%), thickness: 0.5pt))
      }

      // Riquadro e asse temporale centrale
      rect((0, -h), (w, h), stroke: (paint: black, thickness: 0.7pt))
      line((0, 0), (w, 0), stroke: (paint: black, thickness: 0.7pt))

      // Etichette asse tempi
      content((0, -h - 0.35), $0$)
      content((w / 4, -h - 0.35), $T / 4$)
      content((w / 2, -h - 0.35), $T / 2$)
      content((3 * w / 4, -h - 0.35), $3 T / 4$)
      content((w, -h - 0.35), $T$)

      // Campionamento sinusoidi in fase (phi = 25deg)
      let phi0 = 25deg
      let pts-v = ()
      let pts-i = ()
      let N = 60
      for n in range(0, N + 1) {
        let x = n * w / N
        let theta = 360deg * (n / N) + phi0
        pts-v.push((x, 1.55 * calc.sin(theta)))
        pts-i.push((x, 1.2 * calc.sin(theta)))
      }

      line(..pts-v, stroke: (paint: black, dash: "dashed", thickness: 1.2pt))
      line(..pts-i, stroke: (paint: black, dash: "dotted", thickness: 1.2pt))

      content((0.65, 1.75), $v(t)$)
      content((0.75, 0.85), $i(t)$)
    })
  ]
)

// ==========================================
// SLIDE 31 - 45
// ==========================================

=== Condensatore in regime sinusoidale

Si consideri un condensatore lineare tempo-invariante (LTI) di capacità $C$, per il quale è adottata la convenzione degli utilizzatori, alimentato da una tensione sinusoidale:

$ v(t) = sqrt(2) V cos(omega t + phi_V) arrow.l.r.double macron(V) = V e^(j phi_V) $

#grid(
  columns: (1fr, 1.5fr),
  column-gutter: 1.5em,
  align: (center + horizon, left + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *

      capacitor("c", (0, 3), (0, 0), n: "o-o", label: (content: $med thin C$, anchor: "west", distance: 8pt))

      // Freccia corrente i(t)
      line((0, 3.8), (0, 3.2), stroke: red + 1pt, mark: (end: "stealth", fill: red))
      content((0.6, 3.5), text(fill: red)[$i(t)$])

      // Freccia tensione v(t)
      bezier((-0.5, 0.2), (-0.5, 2.8), (-0.9, 1.5), stroke: blue + 1pt, mark: (end: "stealth", fill: blue))
      content((-1.2, 1.5), text(fill: blue)[$v(t)$])
    })
  ],
  [
    Applicando l'equazione costitutiva nel dominio del tempo $i(t) = C ("d"v(t))/("d"t)$ e sfruttando la regola di derivazione nel dominio dei fasori, si ottiene:

    $ macron(I) = I e^(j phi_I) = j omega C macron(V) = j omega C V e^(j phi_V) $

    Ricordando l'identità di Eulero per l'unità immaginaria $j = e^(j pi / 2)$, il fasore della corrente ai capi del condensatore $C$ può essere riscritto in forma esponenziale come:

    $ macron(I) = e^(j pi / 2) omega C V e^(j phi_V) = omega C V e^(j (phi_V + pi / 2)) $
  ]
)

Uguagliando modulo e fase dei due membri dell'equazione $I e^(j phi_I) = omega C V e^(j (phi_V + pi / 2))$, si ricavano le relazioni tra i valori efficaci e le fasi iniziali:

$ cases(
  I = omega C V,
  phi_I = phi_V + pi / 2
) $

Invertendo la relazione fasoriale per esprimere la tensione in funzione della corrente (ricordando che $1 / j = -j$), si ha:

$ macron(V) = frac(1, j omega C) macron(I) = - frac(j, omega C) macron(I) $

#nota[
  Poiché in un condensatore vale la relazione di fase $phi_I = phi_V + pi / 2$, si dice che in un condensatore il fasore della corrente $macron(I)$ è in *anticipo* di $pi / 2$ (ovvero in quadratura in anticipo) rispetto al fasore della tensione $macron(V)$.
]

Di seguito sono riportati il diagramma fasoriale nel piano complesso di Gauss e l'andamento temporale delle grandezze $v(t)$ e $i(t)$ su un periodo $T$:

#grid(
  columns: (1fr, 1.3fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *

      // Assi Re e Im
      line((-1.5, 0), (3.2, 0), mark: (end: "stealth", fill: black))
      content((3.1, -0.4), $"Re"$)
      line((0, -0.5), (0, 3.2), mark: (end: "stealth", fill: black))
      content((-0.5, 3.0), $"Im"$)

      // Fasore V (30 gradi)
      line((0, 0), (2.2, 1.27), stroke: 1.2pt + blue, mark: (end: "stealth", fill: blue))
      content((2.6, 1.35), text(fill: blue)[$macron(V)$])

      // Fasore I (120 gradi = 30 + 90)
      line((0, 0), (-1.0, 1.73), stroke: 1.2pt + red, mark: (end: "stealth", fill: red))
      content((-1.35, 1.85), text(fill: red)[$macron(I)$])

      // Simbolo di angolo retto tra V e I
      line((0.35, 0.2), (0.15, 0.55), stroke: 0.8pt + green.darken(30%))
      line((0.15, 0.55), (-0.2, 0.35), stroke: 0.8pt + green.darken(30%))

      // Arco phi_V
      arc((0.9, 0), start: 0deg, stop: 30deg, radius: 0.9, mark: (end: "stealth", fill: black, scale: 0.7))
      content((1.35, 0.35), $phi_V$)

      // Arco phi_I
      arc((0.6, 0), start: 0deg, stop: 120deg, radius: 0.6, mark: (end: "stealth", fill: black, scale: 0.7))
      content((1.1, 1.9), [$phi_I = phi_V + pi / 2$])
    })
  ],
  [
    #zap.circuit({
      
      import zap.cetz.draw: *

      // Riquadro e griglia del grafico temporale
      rect((0, -2), (4.8, 2), stroke: 0.6pt + black)
      line((0, 0), (4.8, 0), stroke: 0.6pt + black)

      for x in (1.2, 2.4, 3.6) {
        line((x, -2), (x, 2), stroke: (paint: gray.lighten(30%), thickness: 0.5pt))
        line((x, -2.1), (x, -2), stroke: 0.6pt + black)
        line((x, 2), (x, 2.1), stroke: 0.6pt + black)
      }
      for y in (-1.5, -1.0, -0.5, 0.5, 1.0, 1.5) {
        line((0, y), (4.8, y), stroke: (paint: gray.lighten(30%), thickness: 0.5pt))
      }

      content((0, -2.35), $0$)
      content((1.2, -2.35), $T / 4$)
      content((2.4, -2.35), $T / 2$)
      content((3.6, -2.35), $3 T / 4$)
      content((4.8, -2.35), $T$)

      // Curva v(t) tratteggiata
      let pts-v = range(0, 61).map(k => {
        let x = k * 4.8 / 60
        let angle = (x / 4.8) * 2 * calc.pi - 2.1
        (x, 1.5 * calc.cos(angle))
      })
      line(..pts-v, stroke: (paint: black, thickness: 1.1pt, dash: "dashed"))
      content((2.6, 1.15), $ v(t)$)

      // Curva i(t) puntinata (in anticipo di pi/2)
      let pts-i = range(0, 61).map(k => {
        let x = k * 4.8 / 60
        let angle = (x / 4.8) * 2 * calc.pi - 2.1 + calc.pi / 2
        (x, 1.25 * calc.cos(angle))
      })
      line(..pts-i, stroke: (paint: black, thickness: 1.1pt, dash: "dotted"))
      content((1.5, 0.8), $i(t)$)
    })
  ]
)

=== Induttore in regime sinusoidale

Si consideri ora un induttore lineare di induttanza $L$, con la convenzione degli utilizzatori, alimentato da una corrente sinusoidale:

$ i(t) = sqrt(2) I cos(omega t + phi_I) arrow.l.r.double macron(I) = I e^(j phi_I) $

#grid(
  columns: (1fr, 1.5fr),
  column-gutter: 1.5em,
  align: (center + horizon, left + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *

      inductor("l", (0, 3), (0, 0), variant: "ieee", n: "o-o", label: (content: $L$, anchor: "west", distance: 8pt))

      // Freccia corrente i(t)
      line((0, 3.8), (0, 3.2), stroke: red + 1pt, mark: (end: "stealth", fill: red))
      content((0.6, 3.5), text(fill: red)[$i(t)$])

      // Freccia tensione v(t)
      bezier((-0.5, 0.2), (-0.5, 2.8), (-0.9, 1.5), stroke: blue + 1pt, mark: (end: "stealth", fill: blue))
      content((-1.2, 1.5), text(fill: blue)[$v(t)$])
    })
  ],
  [
    Applicando l'equazione costitutiva dell'induttore $v(t) = L ("d"i(t))/("d"t)$ e passando al dominio dei fasori tramite la regola di derivazione, il fasore della tensione ai capi di $L$ risulta:

    $ macron(V) = V e^(j phi_V) = j omega L macron(I) = j omega L I e^(j phi_I) $

    Sostituendo $j = e^(j pi / 2)$, si ottiene l'espressione esponenziale:

    $ V e^(j phi_V) = e^(j pi / 2) omega L I e^(j phi_I) = omega L I e^(j (phi_I + pi / 2)) $
  ]
)

Dal confronto tra moduli e argomenti dei due membri si ricavano le relazioni:

$ cases(
  V = omega L I,
  phi_V = phi_I + pi / 2
) $

#nota[
  Poiché in un induttore vale la relazione di fase $phi_V = phi_I + pi / 2$ (ovvero $phi_I = phi_V - pi / 2$), si dice che in un induttore il fasore della corrente $macron(I)$ è in *ritardo* di $pi / 2$ (ovvero in quadratura in ritardo) rispetto al fasore della tensione $macron(V)$.
]

Di seguito sono rappresentati il diagramma fasoriale nel piano di Gauss e l'andamento temporale di $i(t)$ e $v(t)$ per l'induttore:

#grid(
  columns: (1fr, 1.3fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *

      // Assi Re e Im
      line((-1.5, 0), (3.2, 0), mark: (end: "stealth", fill: black))
      content((3.1, -0.4), $"Re"$)
      line((0, -0.5), (0, 3.2), mark: (end: "stealth", fill: black))
      content((-0.5, 3.0), $"Im"$)

      // Fasore I (30 gradi)
      line((0, 0), (2.2, 1.27), stroke: 1.2pt + red, mark: (end: "stealth", fill: red))
      content((2.6, 1.35), text(fill: red)[$macron(I)$])

      // Fasore V (120 gradi = 30 + 90)
      line((0, 0), (-1.0, 1.73), stroke: 1.2pt + blue, mark: (end: "stealth", fill: blue))
      content((-1.35, 1.85), text(fill: blue)[$macron(V)$])

      // Simbolo di angolo retto tra I e V
      line((0.35, 0.2), (0.15, 0.55), stroke: 0.8pt + green.darken(30%))
      line((0.15, 0.55), (-0.2, 0.35), stroke: 0.8pt + green.darken(30%))

      // Arco phi_I
      arc((0.9, 0), start: 0deg, stop: 30deg, radius: 0.9, mark: (end: "stealth", fill: black, scale: 0.7))
      content((1.35, 0.35), $phi_I$)

      // Arco phi_V
      arc((0.6, 0), start: 0deg, stop: 120deg, radius: 0.6, mark: (end: "stealth", fill: black, scale: 0.7))
      content((1.1, 1.9), [$phi_V = phi_I + pi / 2$])
    })
  ],
  [
    #zap.circuit({
      
      import zap.cetz.draw: *

      // Riquadro e griglia del grafico temporale
      rect((0, -2), (4.8, 2), stroke: 0.6pt + black)
      line((0, 0), (4.8, 0), stroke: 0.6pt + black)

      for x in (1.2, 2.4, 3.6) {
        line((x, -2), (x, 2), stroke: (paint: gray.lighten(30%), thickness: 0.5pt))
        line((x, -2.1), (x, -2), stroke: 0.6pt + black)
        line((x, 2), (x, 2.1), stroke: 0.6pt + black)
      }
      for y in (-1.5, -1.0, -0.5, 0.5, 1.0, 1.5) {
        line((0, y), (4.8, y), stroke: (paint: gray.lighten(30%), thickness: 0.5pt))
      }

      content((0, -2.35), $0$)
      content((1.2, -2.35), $T / 4$)
      content((2.4, -2.35), $T / 2$)
      content((3.6, -2.35), $3 T / 4$)
      content((4.8, -2.35), $T$)

      // Curva i(t) puntinata
      let pts-i = range(0, 61).map(k => {
        let x = k * 4.8 / 60
        let angle = (x / 4.8) * 2 * calc.pi - 1.05
        (x, 1.25 * calc.cos(angle))
      })
      line(..pts-i, stroke: (paint: black, thickness: 1.1pt, dash: "dotted"))
      content((1.8, 0.9), $i(t)$)

      // Curva v(t) tratteggiata (in anticipo di pi/2 rispetto a i(t))
      let pts-v = range(0, 61).map(k => {
        let x = k * 4.8 / 60
        let angle = (x / 4.8) * 2 * calc.pi - 1.05 + calc.pi / 2
        (x, 1.5 * calc.cos(angle))
      })
      line(..pts-v, stroke: (paint: black, thickness: 1.1pt, dash: "dashed"))
      content((1.8, -1.0), $v(t)$)
    })
  ]
)

=== Riepilogo delle equazioni costitutive nel dominio dei fasori

Le relazioni costitutive dei tre bipoli passivi fondamentali nel dominio del tempo e nel dominio simbolico (fasoriale) sono riassunte nella tabella seguente:

#align(center)[
  #table(
    columns: 4,
    align: (left + horizon, center + horizon, center + horizon, left + horizon),
    stroke: 0.6pt + gray,
    inset: 5pt,
    table.header(
      [*Componente*], [*Dominio del tempo*], [*Dominio dei fasori*], [*Simbolo*]
    ),
    [Resistore ($R$)], [$v(t) = R i(t)$], [$macron(V) = R macron(I)$], [#schema-bipolo("R", $R$, scala: 0.8)],
    [Induttore ($L$)], [$v(t) = L frac("d"i(t), "d"t)$], [$macron(V) = j omega L macron(I)$],[#schema-bipolo("L", $L$, scala: 0.8)],
    [Condensatore ($C$)], [$i(t) = C frac("d"v(t), "d"t)$], [$macron(I) = j omega C macron(V) arrow.l.r.double macron(V) = - frac(j, omega C) macron(I)$],[#schema-bipolo("C", $C$, scala: 0.8)]
  )
]





== Impedenza e legge di Ohm in forma simbolica

Osservando le equazioni costitutive fasoriali di resistore, induttore e condensatore, si nota che la struttura algebrica dell'equazione è comune a tutti e tre i componenti:

#grid(
  columns: (1fr, 1.5fr),
  column-gutter: 1.5em,
  align: (center + horizon, left + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *

      resistor("z", (0, 0), (3, 0), variant: "iec", n: "o-o", label: (content: $macron(Z)$, anchor: "north", distance: 6pt))

      // Freccia corrente I
      line((-1.0, 0), (-0.25, 0), mark: (end: "stealth", fill: black))
      content((-0.6, 0.45), $macron(I)$)

      // Freccia tensione V
      bezier((2.7, 0.5), (0.3, 0.5), (1.5, 1.1), mark: (end: "stealth", fill: black))
      content((1.5, 1.25), $macron(V)$)
    })
  ],
  [
    $ macron(V) = macron(Z) macron(I) $

    Questa relazione è chiamata *legge di Ohm in forma simbolica* e il numero complesso $macron(Z)$ (che dipende dalla pulsazione $omega$, ma non dai fasori di tensione e corrente) prende il nome di *impedenza* del bipolo:

    - *Resistore*: $macron(Z) = R$
    - *Condensatore*: $macron(Z) = frac(1, j omega C) = - frac(j, omega C)$
    - *Induttore*: $macron(Z) = j omega L$
  ]
)

=== Forma cartesiana e polare dell'impedenza

In forma algebrica (cartesiana), la parte reale dell'impedenza $macron(Z)$ è chiamata *resistenza* ($R$), mentre il coefficiente della parte immaginaria è chiamato *reattanza* ($X$). La forma generale dell'impedenza è pertanto:

$ macron(Z) = R + j X $

In particolare, per i tre bipoli ideali si ha:
- *Resistore*: $R gt.eq 0$ e $X = 0$;
- *Condensatore*: $R = 0$ e $X = - frac(1, omega C) < 0$ (reattanza capacitiva);
- *Induttore*: $R = 0$ e $X = omega L > 0$ (reattanza induttiva).

Esprimendo l'impedenza in forma esponenziale (polare) come $macron(Z) = Z e^(j theta) = |macron(Z)| e^(j theta)$, con:

$ Z = |macron(Z)| = sqrt(R^2 + X^2), wide theta = arctan(frac(X, R)) $

e sostituendo le rappresentazioni esponenziali dei fasori nella legge di Ohm simbolica $macron(V) = macron(Z) macron(I)$, si ottiene:

$ V e^(j phi_V) = Z e^(j theta) I e^(j phi_I) arrow.r.double macron(Z) = Z e^(j theta) = frac(macron(V), macron(I)) = frac(V e^(j phi_V), I e^(j phi_I)) = frac(V, I) e^(j (phi_V - phi_I)) $

Da tale relazione si deducono il modulo e l'argomento dell'impedenza:

$ cases(
  Z = |macron(Z)| = frac(V, I) quad ["espressa in Ohm" (Omega)],
  theta = phi_V - phi_I quad ["angolo di fase (argomento) di" macron(Z)]
) $

#nota[
  L'angolo caratteristico $theta = phi_V - phi_I$ dell'impedenza rappresenta lo sfasamento tra la tensione e la corrente ai capi del bipolo. Per bipoli passivi ($R gt.eq 0$), l'angolo $theta$ varia nell'intervallo:
  $ - frac(pi, 2) lt.eq theta lt.eq frac(pi, 2) $
]

Si possono verificare analiticamente i casi limite dei tre componenti elementari passando dalla forma esponenziale a quella algebrica $macron(Z) = |macron(Z)| cos(theta) + j |macron(Z)| sin(theta)$:

1. *Resistore*: poiché $phi_V = phi_I$, si ha $theta = 0$ e quindi $macron(Z) = R$.
2. *Condensatore*: poiché $phi_I = phi_V + pi / 2$, risulta $theta = phi_V - phi_I = - pi / 2$. Essendo $R = 0$, il modulo vale $|macron(Z)| = sqrt(R^2 + X^2) = |X| = 1 / (omega C)$, da cui:
   $ macron(Z) = |macron(Z)| e^(-j pi / 2) = |macron(Z)| cos(- frac(pi, 2)) + j |macron(Z)| sin(- frac(pi, 2)) = -j |macron(Z)| = -j |X| = - frac(j, omega C) $
3. *Induttore*: poiché $phi_V = phi_I + pi / 2$, risulta $theta = phi_V - phi_I = + pi / 2$. Essendo $R = 0$ e $|macron(Z)| = |X| = omega L$, si ottiene:
   $ macron(Z) = |macron(Z)| e^(j pi / 2) = |macron(Z)| cos(frac(pi, 2)) + j |macron(Z)| sin(frac(pi, 2)) = j |macron(Z)| = j |X| = j omega L $

== Connessioni canoniche di impedenze

Grazie alla natura puramente algebrica delle leggi di Kirchhoff per i fasori e della legge di Ohm in forma simbolica, per la riduzione di reti di impedenze in regime sinusoidale si ritrovano formule formalmente identiche a quelle valide per i resistori in regime stazionario.

=== Collegamento in serie

Si considerino due impedenze $macron(Z)_1$ e $macron(Z)_2$ collegate in serie tra i morsetti $"A"$ e $"B"$, quindi attraversate dalla medesima corrente fasoriale $macron(I)$:

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *

    resistor("z1", (0, 0), (3, 0), variant: "iec", n: "*-*", label: (content: $macron(Z)_1$, anchor: "north", distance: 6pt))
    resistor("z2", (3, 0), (6, 0), variant: "iec", n: "-*", label: (content: $macron(Z)_2$, anchor: "north", distance: 6pt))

    content((0, 0.45), sans("A", weight: "bold"))
    content((6, 0.45), sans("B", weight: "bold"))

    // Freccia corrente I
    line((-1.0, 0), (-0.25, 0), stroke: red + 1pt, mark: (end: "stealth", fill: red))
    content((-0.6, -0.45), text(fill: red)[$macron(I)$])

    // Tensioni V1 e V2
    line((2.5, -0.6), (0.5, -0.6), stroke: green.darken(30%) + 1pt, mark: (end: "stealth", fill: green.darken(30%)))
    content((1.5, -1.05), text(fill: green.darken(30%))[$macron(V)_1$])

    line((5.5, -0.6), (3.5, -0.6), stroke: green.darken(30%) + 1pt, mark: (end: "stealth", fill: green.darken(30%)))
    content((4.5, -1.05), text(fill: green.darken(30%))[$macron(V)_2$])

    // Tensione totale V
    bezier((5.6, 0.7), (0.4, 0.7), (3.0, 1.5), stroke: green.darken(30%) + 1pt, mark: (end: "stealth", fill: green.darken(30%)))
    content((3.0, 1.6), text(fill: green.darken(30%))[$macron(V)$])
  })
]

Applicando la legge di Ohm simbolica a ciascun bipolo si ha:

$ macron(V)_1 = macron(Z)_1 macron(I), wide macron(V)_2 = macron(Z)_2 macron(I) $

Per la legge di Kirchhoff delle tensioni (LKT) applicata tra i morsetti $"A"$ e $"B"$, la tensione complessiva $macron(V)$ è pari alla somma delle tensioni parziali:

$ -macron(V) + macron(V)_1 + macron(V)_2 = 0 arrow.r.double macron(V) = macron(V)_1 + macron(V)_2 = macron(Z)_1 macron(I) + macron(Z)_2 macron(I) = (macron(Z)_1 + macron(Z)_2) macron(I) $

Pertanto, l'impedenza equivalente $macron(Z)_"eq"$ vista ai morsetti della serie è data dalla somma delle singole impedenze:

$ macron(Z)_"eq" = macron(Z)_1 + macron(Z)_2 $

// ==========================================
// SLIDE 46 - 60
// ==========================================

=== Connessioni Canoniche di Impedenze e Circuiti Elementari

== Collegamento in Serie: Circuiti Ohmico-Induttivo ($R L$) e Ohmico-Capacitivo ($R C$)

Nel dominio simbolico dei fasori, la connessione in serie di più bipoli passivi segue le medesime regole formali viste per i circuiti in regime stazionario: l'impedenza equivalente $macron(Z)_"eq"$ è data dalla somma algebrica delle singole impedenze complesse.

=== Connessione Serie Ohmico-Induttiva ($R L$)

Si consideri il collegamento in serie di un resistore di resistenza $R$ e di un induttore di induttanza $L$, attraversati dalla medesima corrente fasoriale $macron(I)$ e sottoposti alla tensione complessiva $macron(V)$.

#align(center)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 2em,
    align: center + horizon,
    [
      #zap.circuit({
        
        import zap.cetz.draw: *
        set-style(resistor: (variant: "ieee"))

        wire((0, 0), (1, 0))
        resistor("r", (1, 0), (3.5, 0), label: (content: $R$, anchor: "north", distance: 8pt))
        inductor("l", (3.5, 0), (6, 0), label: (content: $L$, anchor: "north", distance: 8pt))
        wire((6, 0), (6.8, 0))

        // Riquadri rossi indicativi delle impedenze come nell'annotazione
        rect((1.4, -0.45), (3.1, 0.45), stroke: (paint: red, thickness: 0.8pt, dash: "dashed"))
        content((2.25, -0.75), text(fill: red)[$macron(Z)_R$])

        rect((3.9, -0.45), (5.6, 0.45), stroke: (paint: red, thickness: 0.8pt, dash: "dashed"))
        content((4.75, -0.75), text(fill: red)[$macron(Z)_L$])

        node("in", (0, 0), fill: false)
        node("out", (6.8, 0), fill: false)

        line((-0.9, 0), (-0.2, 0), stroke: red + 1.2pt, mark: (end: "stealth", fill: red))
        content((-0.55, 0.45), text(fill: red)[$macron(I)$])

        bezier((6.5, -0.35), (0.3, -0.35), (3.4, -1.7), stroke: blue + 1pt, mark: (end: "stealth", fill: blue))
        content((3.4, -1.55), text(fill: blue)[$macron(V)$])
      })
    ],
    [
      #zap.circuit({
        
        import zap.cetz.draw: *
        set-style(resistor: (variant: "ieee"))

        resistor("r", (0, 0), (2.8, 0), n: "*-*", label: (content: $R$, anchor: "north", distance: 8pt))
        inductor("l", (2.8, 0), (5.6, 0), n: "*-*", label: (content: $L$, anchor: "north", distance: 8pt))
      })
    ]
  )
]

Le impedenze dei singoli bipoli sono rispettivamente:
$ macron(Z)_R = R + j 0 = R $
$ macron(Z)_L = 0 + j X_L = j omega L $

L'impedenza equivalente della serie ohmico-induttiva risulta pertanto:
$ macron(Z)_"eq" = macron(Z)_R + macron(Z)_L = R + j omega L $

Esprimendo $macron(Z)_"eq"$ in forma polare (modulo e argomento), si ottengono:
$ |macron(Z)_"eq"| = sqrt(R^2 + (omega L)^2) $
$ varphi_"eq" = theta = arctan(X_L / R) = arctan((omega L) / R) > 0 $ // VERIFICA: dedotto dall'equazione

=== Connessione Serie Ohmico-Capacitiva ($R C$)

In modo duale, si consideri il collegamento in serie di un resistore $R$ e di un condensatore di capacità $C$:

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *
    set-style(resistor: (variant: "ieee"))

    wire((0, 0), (1, 0))
    resistor("r", (1, 0), (3.5, 0), label: (content: $R$, anchor: "north", distance: 8pt))
    capacitor("c", (3.5, 0), (6, 0), label: (content: $C$, anchor: "north", distance: 8pt))
    wire((6, 0), (6.8, 0))

    rect((1.4, -0.45), (3.1, 0.45), stroke: (paint: red, thickness: 0.8pt, dash: "dashed"))
    content((2.25, -0.75), text(fill: red)[$macron(Z)_R$])

    rect((4.1, -0.55), (5.4, 0.55), stroke: (paint: red, thickness: 0.8pt, dash: "dashed"))
    content((4.75, -0.8), text(fill: red)[$macron(Z)_C$])

    node("in", (0, 0), fill: false)
    node("out", (6.8, 0), fill: false)

    line((-0.9, 0), (-0.2, 0), stroke: red + 1.2pt, mark: (end: "stealth", fill: red))
    content((-0.55, 0.45), text(fill: red)[$macron(I)$])

    bezier((6.5, -0.4), (0.3, -0.4), (3.4, -1.75), stroke: blue + 1pt, mark: (end: "stealth", fill: blue))
    content((3.4, -1.6), text(fill: blue)[$macron(V)$])
  })
]

Le impedenze dei due componenti valgono:
$ macron(Z)_R = R + j 0 = R $
$ macron(Z)_C = 0 + j X_C = -j 1 / (omega C) $

L'impedenza equivalente della serie ohmico-capacitiva è data da:
$ macron(Z)_"eq" = macron(Z)_R + macron(Z)_C = R - j 1 / (omega C) $

Il modulo e l'argomento dell'impedenza equivalente risultano quindi:
$ |macron(Z)_"eq"| = sqrt(R^2 + (1 / (omega C))^2) $
$ varphi_"eq" = theta = arctan(X_C / R) = arctan(- 1 / (omega R C)) = -arctan(1 / (omega R C)) < 0 $ // VERIFICA: dedotto dall'equazione

=== Confronto dello Sfasamento Tensione-Corrente nei Circuiti Serie

Assumendo per semplicità la tensione ai morsetti con fase iniziale nulla ($varphi_V = 0$, ossia il fasore $macron(V)$ adagiato sull'asse reale positivo), poiché vale la legge di Ohm simbolica $macron(V) = macron(Z)_"eq" macron(I)$, l'angolo di sfasamento complessivo $theta = varphi_V - varphi_I$ coincide con l'argomento dell'impedenza equivalente. Si hanno pertanto i due casi illustrati nei diagrammi fasoriali seguenti:

#align(center)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.5em,
    align: center + horizon,
    [
      #canvas({
        import draw: *
        // Caso 1: Circuito RL
        content((-1.2, 2.2), text(fill: rgb("#1b5e20"), weight: "bold")[Caso 1 (Serie $R L$)])
        line((-0.5, 0), (3.5, 0), mark: (end: "stealth", fill: black))
        content((3.7, -0.3), $"Re"$)
        line((0, -1.8), (0, 2.0), mark: (end: "stealth", fill: black))
        content((-0.4, 2.0), $"Im"$)

        // Vettore V su asse Re
        line((0, 0), (2.4, 0), stroke: blue + 1.5pt, mark: (end: "stealth", fill: blue))
        content((2.2, 0.4), text(fill: blue)[$macron(V)$])

        // Vettore I in ritardo
        line((0, 0), (1.8, -1.1), stroke: red + 1.5pt, mark: (end: "stealth", fill: red))
        content((2.2, -1.2), text(fill: red)[$macron(I)$])

        // Arco angolo theta
        arc((1.0, 0), start: 0deg, stop: -31.4deg, radius: 1.0, stroke: red + 0.8pt)
        content((1.35, -0.35), text(fill: red)[$theta$])
      })

      $ theta = varphi_V - varphi_I > 0 $
      $ varphi_V = 0 quad ==> quad varphi_I = -theta < 0 $
    ],
    [
      #canvas({
        import draw: *
        // Caso 2: Circuito RC
        content((-1.2, 2.2), text(fill: rgb("#1b5e20"), weight: "bold")[Caso 2 (Serie $R C$)])
        line((-0.5, 0), (3.5, 0), mark: (end: "stealth", fill: black))
        content((3.7, -0.3), $"Re"$)
        line((0, -1.8), (0, 2.0), mark: (end: "stealth", fill: black))
        content((-0.4, 2.0), $"Im"$)

        // Vettore V su asse Re
        line((0, 0), (2.4, 0), stroke: blue + 1.5pt, mark: (end: "stealth", fill: blue))
        content((2.2, -0.4), text(fill: blue)[$macron(V)$])

        // Vettore I in anticipo
        line((0, 0), (1.8, 1.1), stroke: red + 1.5pt, mark: (end: "stealth", fill: red))
        content((2.2, 1.2), text(fill: red)[$macron(I)$])

        // Arco angolo theta
        arc((1.0, 0), start: 0deg, stop: 31.4deg, radius: 1.0, stroke: red + 0.8pt)
        content((1.35, 0.35), text(fill: red)[$theta$])
      })

      $ theta = varphi_V - varphi_I < 0 $
      $ varphi_V = 0 quad ==> quad varphi_I = -theta > 0 $
    ]
  )
]

#nota[
  - *Circuito Ohmico-Induttivo ($R L$)*: il fasore della corrente $macron(I)$ è *in ritardo* rispetto al fasore della tensione $macron(V)$.
  - *Circuito Ohmico-Capacitivo ($R C$)*: il fasore della corrente $macron(I)$ è *in anticipo* rispetto al fasore della tensione $macron(V)$.
]

== Collegamento in Parallelo e Concetto di Ammettenza

La medesima struttura formale delle reti resistive si estende alle connessioni in parallelo nel dominio dei fasori. Applicando la Legge di Kirchhoff delle Correnti (LKC) a due impedenze $macron(Z)_1$ e $macron(Z)_2$ connesse in parallelo e sottoposte alla stessa tensione $macron(V)$, si ha:

$ macron(I) = macron(I)_1 + macron(I)_2 = macron(V) / macron(Z)_1 + macron(V) / macron(Z)_2 = (1 / macron(Z)_1 + 1 / macron(Z)_2) macron(V) $

L'impedenza equivalente $macron(Z)_"eq"$ del parallelo soddisfa pertanto la relazione:
$ 1 / macron(Z)_"eq" = 1 / macron(Z)_1 + 1 / macron(Z)_2 $

#nota[
  Si definisce *ammettenza* del componente, indicata con $macron(Y)$ e misurata in Siemens ($"S"$ o $Omega^(-1)$), il reciproco dell'impedenza:
  $ macron(Y) = 1 / macron(Z) = G + j B $
  dove la parte reale $G$ prende il nome di *conduttanza* e la parte immaginaria $B$ prende il nome di *suscettanza*. Per una connessione in parallelo, l'ammettenza equivalente è semplicemente la somma delle ammettenze dei singoli rami:
  $ macron(Y)_"eq" = macron(Y)_1 + macron(Y)_2 = 1 / macron(Z)_1 + 1 / macron(Z)_2 quad ==> quad macron(I) = macron(Y)_"eq" macron(V) $
]

Sviluppando l'espressione dell'impedenza equivalente per due bipoli generici in parallelo si ottiene:
$ 1 / macron(Z)_"eq" = (macron(Z)_1 + macron(Z)_2) / (macron(Z)_1 macron(Z)_2) quad ==> quad macron(Z)_"eq" = (macron(Z)_1 macron(Z)_2) / (macron(Z)_1 + macron(Z)_2) $

=== Collegamento Parallelo Ohmico-Capacitivo ($R C$)

Si consideri il collegamento in parallelo di un resistore $R$ (con conduttanza $G = 1/R$ e impedenza $macron(Z)_R = R$) e di un condensatore $C$ (con impedenza $macron(Z)_C = -j / (omega C)$) ai morsetti $A$ e $B$:

#align(center)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 2em,
    align: center + horizon,
    [
      #zap.circuit({
        
        import zap.cetz.draw: *
        set-style(resistor: (variant: "ieee"))

        wire((0, 3), (4, 3))
        wire((0, 0), (4, 0))
        node("A", (0, 3), fill: false, label: (content: sans("A", weight: "bold"), anchor: "south-east", distance: 5pt))
        node("B", (0, 0), fill: false, label: (content: sans("B", weight: "bold"), anchor: "north-east", distance: 5pt))

        resistor("r", (1.8, 3), (1.8, 0), label: (content: $med thin R$, anchor: "east", distance: 8pt))
        capacitor("c", (4, 3), (4, 0), label: (content: $med C$, anchor: "north", distance: 8pt))

        rect((1.35, 0.7), (2.25, 2.3), stroke: (paint: red, thickness: 0.8pt, dash: "dashed"))
        content((2.65, 1.5), text(fill: red)[$macron(Z)_R$])

        rect((3.5, 0.9), (4.6, 2.1), stroke: (paint: red, thickness: 0.8pt, dash: "dashed"))
        content((4.65, 0.5), text(fill: red)[$macron(Z)_C$])
      })
    ],
    [
      #zap.circuit({
        
        import zap.cetz.draw: *
        set-style(resistor: (variant: "ieee"))

        wire((0, 3), (4, 3))
        wire((0, 0), (4, 0))
        resistor("r", (1.8, 3), (1.8, 0), n: "*-*", label: (content: $R$, anchor: "north", distance: 8pt))
        capacitor("c", (4, 3), (4, 0), n: "*-*", label: (content: $C$, anchor: "north", distance: 8pt))
      })
    ]
  )
]

Valutando prima l'ammettenza equivalente del parallelo si ha:
$ macron(Y)_"eq" = 1 / macron(Z)_R + 1 / macron(Z)_C = 1 / R + j omega C = G + j omega C $

Passando all'impedenza equivalente $macron(Z)_"eq" = 1 / macron(Y)_"eq"$ (ovvero calcolando il prodotto diviso la somma delle impedenze) e razionalizzando il denominatore complesso moltiplicando numeratore e denominatore per il complesso coniugato $(1 - j omega R C)$, si ricava: // VERIFICA: dedotto dall'equazione

$ macron(Z)_"eq" = (macron(Z)_R macron(Z)_C) / (macron(Z)_R + macron(Z)_C) = (R (-j 1 / (omega C))) / (R - j 1 / (omega C)) = 1 / (1 / R + j omega C) = R / (1 + j omega R C) $

$ macron(Z)_"eq" = R / (1 + j omega R C) dot (1 - j omega R C) / (1 - j omega R C) = (R (1 - j omega R C)) / (1 + (omega R C)^2) = R / (1 + omega^2 R^2 C^2) - j (omega R^2 C) / (1 + omega^2 R^2 C^2) $

Separando la parte reale $R_"eq"$ e la parte immaginaria $X_"eq"$ dell'impedenza equivalente $macron(Z)_"eq" = R_"eq" + j X_"eq"$, si ottiene infine:
$ R_"eq" = R / (1 + omega^2 R^2 C^2) , quad X_"eq" = - (omega R^2 C) / (1 + omega^2 R^2 C^2) $

== Teoremi delle Reti Lineari nel Dominio dei Fasori

Poiché nel dominio simbolico le equazioni topologiche (LKT e LKC) e le relazioni costitutive ($macron(V) = macron(Z) macron(I)$) sono puramente algebriche e lineari, tutti i teoremi fondamentali delle reti elettriche lineari si estendono direttamente ai fasori.

=== Teorema di Thévenin

Qualsiasi rete lineare operante in regime sinusoidale isofrequenziale, vista da una coppia di morsetti $A$ e $B$ a cui è collegato un carico generico, può essere sostituita da un generatore ideale di tensione fasoriale $macron(E)_"TH"$ in serie a un'impedenza equivalente $macron(Z)_"TH"$:

#align(center)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 2em,
    align: center + horizon,
    [
      #zap.circuit({
        
        import zap.cetz.draw: *

        rect((0, 0), (2.8, 3.2), stroke: 1.2pt)
        content((1.4, 1.6), sans("Rete\nlineare", weight: "bold"))

        wire((2.8, 2.6), (4.2, 2.6))
        wire((2.8, 0.6), (4.2, 0.6))
        node("A", (4.2, 2.6), fill: false, label: (content: sans("A", weight: "bold"), anchor: "south", distance: 6pt))
        node("B", (4.2, 0.6), fill: false, label: (content: sans("B", weight: "bold"), anchor: "north", distance: 6pt))

        wire((4.2, 2.6), (5.4, 2.6))
        resistor("u", (5.4, 2.6), (5.4, 0.6), variant: "iec")
        wire((5.4, 0.6), (4.2, 0.6))
      })
    ],
    [
      #zap.circuit({
        
        import zap.cetz.draw: *

        vsource("eth", (0, 0.6), (0, 2.6), variant: "iec", stroke: red, label: (content: text(fill: red)[$macron(E)_"TH"$], anchor: "north", distance: 8pt))
        content((0.4, 2.2), text(fill: red)[#sans("+", weight: "bold")])

        resistor("zth", (0, 2.6), (3.2, 2.6), variant: "iec", stroke: red, label: (content: text(fill: red)[$macron(Z)_"TH"$], anchor: "south", distance: 8pt))
        wire((0, 0.6), (3.2, 0.6), stroke: red)

        node("A", (3.2, 2.6), fill: false, stroke: red, label: (content: text(fill: red)[#sans("A", weight: "bold")], anchor: "south", distance: 6pt))
        node("B", (3.2, 0.6), fill: false, stroke: red, label: (content: text(fill: red)[#sans("B", weight: "bold")], anchor: "north", distance: 6pt))

        wire((3.2, 2.6), (4.5, 2.6))
        resistor("u", (4.5, 2.6), (4.5, 0.6), variant: "iec")
        wire((4.5, 0.6), (3.2, 0.6))
      })
    ]
  )
]

=== Formula di Millman

Per una rete binodale in regime sinusoidale costituita da rami in parallelo tra i nodi $A$ e $B$ (contenenti generatori di tensione in serie a impedenze, generatori di corrente e impedenze passive), la tensione fasoriale $macron(V)_(A B)$ tra i due nodi si calcola mediante la formula di Millman:

#grid(
  columns: (1.2fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, left + horizon),
  [
    #scale(x: 85%, y: 85%, reflow: true)[
      #zap.circuit({
        
        import zap.cetz.draw: *

        wire((0, 4.5), (7.5, 4.5))
        wire((0, 0), (7.5, 0))

        // Ramo 1: E1 + Z1
        vsource("e1", (0, 0), (0, 2.2), variant: "iec", label: (content: $macron(E)_1$, anchor: "north", distance: 6pt))
        content((0.35, 1.9), sans("+", weight: "bold"))
        line((0.5, 0.6), (0.5, 1.6), stroke: blue + 1pt, mark: (end: "stealth", fill: blue))
        resistor("z1", (0, 2.2), (0, 4.5), variant: "iec", label: (content: $macron(Z)_1$, anchor: "east", distance: 6pt))

        // Ramo 2: Generatore di corrente I2 + Z2
        isource("i2", (2.5, 0), (2.5, 2.2), variant: "iec", label: (content: $macron(I)_2 med thin $, anchor: "west", distance: 6pt))
        line((2.5, 1.8), (2.5, 2.4), stroke: black + 1.2pt, mark: (end: "stealth", fill: black))
        resistor("z2", (2.5, 2.2), (2.5, 4.5), variant: "iec", label: (content: $macron(Z)_2 med thin med $, anchor: "east", distance: 6pt))
        node("A1", (2.5, 4.5), fill: true, stroke: red, label: (content: text(fill: red)[#sans("A", weight: "bold")], anchor: "north", distance: 6pt))
        node("B1", (2.5, 0), fill: true, stroke: red, label: (content: text(fill: red)[#sans("B", weight: "bold")], anchor: "south", distance: 6pt))

        // Freccia V_AB
        bezier((1.6, 0.3), (2.3, 4.3), (1.3, 2.5), stroke: blue + 1pt, mark: (end: "stealth", fill: blue))
        content((1.6, 4.8), text(fill: blue)[$macron(V)_(A B)$])

        // Ramo 3: E3 (verso opposto) + Z3
        vsource("e3", (5.0, 2.2), (5.0, 0), variant: "iec", label: (content: $macron(E)_3$, anchor: "north", distance: 6pt))
        content((5.35, 0.35), sans("+", weight: "bold"))
        line((4.5, 1.6), (4.5, 0.6), stroke: blue + 1pt, mark: (end: "stealth", fill: blue))
        resistor("z3", (5.0, 2.2), (5.0, 4.5), variant: "iec", label: (content: $macron(Z)_3$, anchor: "east", distance: 6pt))
        node("A2", (5.0, 4.5), fill: true, stroke: red, label: (content: text(fill: red)[#sans("A", weight: "bold")], anchor: "north", distance: 6pt))
        node("B2", (5.0, 0), fill: true, stroke: red, label: (content: text(fill: red)[#sans("B", weight: "bold")], anchor: "south", distance: 6pt))

        // Ramo 4: Z4
        resistor("z4", (7.5, 0), (7.5, 4.5), variant: "iec", label: (content: $macron(Z)_4$, anchor: "west", distance: 6pt))
      })
    ]
  ],
  [
    Applicando la formula di Millman ai nodi $A$ e $B$ dello schema a fianco (in cui il ramo con il generatore di corrente $macron(I)_2$ contribuisce solo al numeratore con la propria corrente impressa, poiché l'impedenza $macron(Z)_2$ in serie a un generatore ideale di corrente non influisce sulla conduttanza equivalente), si ha: // VERIFICA: dedotto dall'equazione

    $ macron(V)_(A B) = (macron(E)_1 / macron(Z)_1 + macron(I)_2 - macron(E)_3 / macron(Z)_3) / (1 / macron(Z)_1 + 1 / macron(Z)_3 + 1 / macron(Z)_4) $
  ]
)

== Diagrammi Vettoriali e Studio dei Circuiti $R L$ e $R C$

=== Rappresentazione Vettoriale nel Piano Complesso

Tutte le grandezze elettriche nel metodo simbolico sono numeri complessi e possiedono pertanto una struttura intrinsecamente bidimensionale: esse possono essere efficacemente rappresentate in forma vettoriale nel piano complesso (piano di Argand-Gauss).

Ogni relazione di somma algebrica tra fasori — ad esempio derivante dall'applicazione di una legge di Kirchhoff (LKT o LKC) — si traduce geometricamente in una *somma vettoriale* eseguita secondo la regola del parallelogramma o punta-coda.

Ad esempio, una Legge di Kirchhoff delle Tensioni definita dalla relazione:
$ macron(V)_3 = macron(V)_1 + macron(V)_2 $
si rappresenta nel piano complesso come:

#align(center)[
  #canvas({
    import draw: *
    let green-vec = rgb("#2e6b4e")
    line((0, 0), (2.8, 0.6), stroke: green-vec + 2pt, mark: (end: "stealth", fill: green-vec))
    content((1.5, -0.3), text(fill: green-vec, size: 13pt)[$macron(V)_1$])

    line((2.8, 0.6), (2.2, 2.8), stroke: green-vec + 2pt, mark: (end: "stealth", fill: green-vec))
    content((3.0, 1.8), text(fill: green-vec, size: 13pt)[$macron(V)_2$])

    line((0, 0), (2.2, 2.8), stroke: green-vec + 2pt, mark: (end: "stealth", fill: green-vec))
    content((0.6, 1.7), text(fill: green-vec, size: 13pt)[$macron(V)_3$])
  })
]

== Analisi del Circuito $R L$ Serie

Si consideri un circuito ohmico-induttivo serie alimentato da un generatore ideale di tensione sinusoidale il cui fasore, scelto come riferimento di fase ($varphi_E = 0$), vale $macron(E) = E e^(j 0) = E$:

#align(center)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 2em,
    align: center + horizon,
    [
      #zap.circuit({
        
        import zap.cetz.draw: *
        set-style(resistor: (variant: "ieee"))

        vsource("e", (0, 0), (0, 4), variant: "ieee", label: (content: $macron(E)$, anchor: "north", distance: 8pt))
        content((-0.35, 2.7), sans("+", weight: "bold"))

        wire((0, 4), (3.5, 4))
        line((0.8, 4.3), (1.8, 4.3), stroke: red + 1.2pt, mark: (end: "stealth", fill: red))
        content((1.3, 4.8), text(fill: red)[$macron(I)$])

        resistor("r", (3.5, 4), (3.5, 2), n: "*-*", label: (content: $ med thin med macron(Z)_1 = R$, anchor: "east", distance: 8pt))
        inductor("l", (3.5, 2), (3.5, 0), n: "-*", label: (content: $med thin med macron(Z)_2 = j omega L$, anchor: "east", distance: 8pt))
        wire((3.5, 0), (0, 0))

        let green-v = rgb("#2e6b4e")
        bezier((3.9, 2.2), (3.9, 3.8), (4.1, 3.0), stroke: green-v + 1pt, mark: (end: "stealth", fill: green-v))
        content((4.6, 3.0), text(fill: green-v)[$macron(V)_R$])

        bezier((3.9, 0.2), (3.9, 1.8), (4.1, 1.0), stroke: green-v + 1pt, mark: (end: "stealth", fill: green-v))
        content((4.6, 1.0), text(fill: green-v)[$macron(V)_L$])
      })
    ],
    [
      #zap.circuit({
        
        import zap.cetz.draw: *

        vsource("e", (0, 0), (0, 4), variant: "ieee", label: (content: $macron(E)$, anchor: "north", distance: 8pt))
        content((0.5, 2.8), sans("+", weight: "bold"))

        wire((0, 4), (3.2, 4))
        line((1.1, 4.25), (2.1, 4.25), stroke: red + 1.2pt, mark: (end: "stealth", fill: red))
        content((1.6, 3.5), text(fill: red)[$macron(I)$])

        resistor("z", (3.2, 4), (3.2, 0), variant: "iec", label: (content: $macron(Z)$, anchor: "north", distance: 8pt))
        wire((3.2, 0), (0, 0))
      })
    ]
  )
]

Adottando la convenzione degli utilizzatori sui bipoli passivi, le equazioni costitutive e l'impedenza equivalente della maglia sono:
$ macron(V)_R = macron(Z)_R macron(I) = R macron(I) , quad macron(V)_L = macron(Z)_L macron(I) = j omega L macron(I) $
$ macron(Z) = macron(Z)_R + macron(Z)_L = R + j omega L $

Applicando la LKT alla maglia si ottiene l'equazione del circuito equivalente:
$ macron(E) = macron(V)_R + macron(V)_L = (R + j omega L) macron(I) = macron(Z) macron(I) $

Da questa relazione è possibile ricavare direttamente il fasore della corrente $macron(I)$:
$ macron(I) = macron(E) / macron(Z) = E / (R + j omega L) = (E e^(j 0)) / (|macron(Z)| e^(j varphi_Z)) = I e^(j varphi_I) $

Pertanto, il modulo (valore efficace) e la fase della corrente risultano:
$ I = |macron(I)| = E / sqrt(R^2 + (omega L)^2) $
$ varphi_I = varphi_E - varphi_Z = 0 - varphi_Z = -arctan((omega L) / R) < 0 $

=== Diagramma Vettoriale per il Circuito $R L$

Una volta calcolato il fasore della corrente $macron(I) = I e^(j varphi_I)$, si possono ricavare analiticamente e graficamente i fasori delle tensioni sui singoli bipoli:
- *Tensione sul resistore*:
  $ macron(V)_R = R macron(I) = R I e^(j varphi_I) $
  Il fasore $macron(V)_R$ ha la stessa fase $varphi_I$ della corrente $macron(I)$ (è *in fase* con $macron(I)$, dunque anch'esso in ritardo di un angolo $|varphi_I|$ rispetto a $macron(E)$).
- *Tensione sull'induttore*:
  $ macron(V)_L = j omega L macron(I) = e^(j pi / 2) omega L I e^(j varphi_I) = omega L I e^(j (varphi_I + pi / 2)) $
  Poiché l'operatore $j = e^(j pi/2)$ introduce una rotazione antioraria di $90 circ$ ($pi/2$ radianti) nel piano complesso, il fasore $macron(V)_L$ è *in quadratura in anticipo* di $pi/2$ rispetto alla corrente $macron(I)$ (e quindi rispetto a $macron(V)_R$).

La LKT impone che la somma vettoriale di $macron(V)_R$ e $macron(V)_L$ ricostruisca esattamente il fasore della tensione impressa $macron(E)$:
$ macron(E) = macron(V)_R + macron(V)_L $

#align(center)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 2em,
    align: center + horizon,
    [
      #canvas({
        import draw: *
        // Piano di Gauss completo (Slide 57)
        line((-0.8, 0), (3.8, 0), mark: (end: "stealth", fill: black))
        content((4.1, -0.2), $"Re"$)
        line((0, -2.0), (0, 2.2), mark: (end: "stealth", fill: black))
        content((0.5, 2.1), $"Im"$)

        // E sull'asse Re
        line((0, 0), (3.0, 0), stroke: blue + 1.5pt, mark: (end: "stealth", fill: blue))
        content((2.9, -0.45), text(fill: blue)[$macron(E)$])

        // V_R e I nel quarto quadrante
        line((0, 0), (1.92, -1.44), stroke: blue + 1.5pt, mark: (end: "stealth", fill: blue))
        content((2.3, -1.5), text(fill: blue)[$macron(V)_R$])

        line((0, 0), (1.3, -0.975), stroke: red + 1.8pt, mark: (end: "stealth", fill: red))
        content((1.4, -1.45), text(fill: red)[$macron(I)$])

        // V_L dall'origine e traslato punta-coda
        line((0, 0), (1.08, 1.44), stroke: blue + 1.2pt, mark: (end: "stealth", fill: blue))
        content((1.2, 1.65), text(fill: blue)[$macron(V)_L$])

        line((1.92, -1.44), (3.0, 0), stroke: blue + 1.5pt, mark: (end: "stealth", fill: blue))
        content((3.1, 0.45), text(fill: blue)[$macron(V)_L$])
      })
    ],
    [
      #canvas({
        import draw: *
        // Triangolo vettoriale RL (Slide 58)
        let green-v = rgb("#2e6b4e")

        // Vettore E orizzontale
        line((0, 0), (3.5, 0), stroke: green-v + 2pt, mark: (end: "stealth", fill: green-v))
        content((2.4, 0.5), text(fill: green-v, size: 13pt)[$macron(E)$])

        // Vettore V_R
        line((0, 0), (2.24, -1.68), stroke: green-v + 2pt, mark: (end: "stealth", fill: green-v))
        content((1.1, -1.6), text(fill: green-v, size: 13pt)[$macron(V)_R$])

        // Vettore I sovrapposto a V_R
        line((0, 0), (1.5, -1.125), stroke: red + 2pt, mark: (end: "stealth", fill: red))
        content((0.5, -0.95), text(fill: red, size: 13pt)[$macron(I)$])

        // Vettore V_L ortogonale
        line((2.24, -1.68), (3.5, 0), stroke: green-v + 2pt, mark: (end: "stealth", fill: green-v))
        content((3.5, -1.0), text(fill: green-v, size: 13pt)[$macron(V)_L$])

        // Simbolo angolo retto
        line((2.0, -1.5), (2.18, -1.26), (2.42, -1.44), stroke: black + 0.9pt)

        // Arco phi_I
        arc((0.9, 0), start: 0deg, stop: -36.87deg, radius: 0.9, stroke: black + 1pt, mark: (end: "stealth", fill: black))
        content((1.25, -0.35), $varphi_I$)
      })
    ]
  )
]

#nota[
  In un circuito *ohmico-induttivo* ($R L$), la corrente $macron(I)$ è sempre *in ritardo* rispetto alla tensione impressa $macron(E)$ di un angolo compreso tra $0$ e $pi/2$.
]

== Analisi del Circuito $R C$ Serie

Si consideri ora un circuito ohmico-capacitivo serie alimentato da un generatore ideale di tensione sinusoidale $macron(E) = E e^(j 0) = E$:

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *
    set-style(resistor: (variant: "ieee"))

    vsource("e", (0, 0), (0, 4), variant: "ieee", label: (content: $macron(E)$, anchor: "north", distance: 8pt))
    content((-0.35, 2.7), sans("+", weight: "bold"))

    wire((0, 4), (3.5, 4))
    line((0.8, 4.3), (1.8, 4.3), stroke: red + 1.2pt, mark: (end: "stealth", fill: red))
    content((1.3, 4.8), text(fill: red)[$macron(I)$])

    resistor("r", (3.5, 4), (3.5, 2), n: "*-*", label: (content: $R$, anchor: "south", distance: 8pt))
    capacitor("c", (3.5, 2), (3.5, 0), n: "-*", label: (content: $-j / (omega C)$, anchor: "south", distance: 8pt))
    wire((3.5, 0), (0, 0))

    let green-v = rgb("#2e6b4e")
    bezier((3.9, 2.2), (3.9, 3.8), (4.1, 3.0), stroke: green-v + 1pt, mark: (end: "stealth", fill: green-v))
    content((4.6, 3.0), text(fill: green-v)[$macron(V)_R$])

    bezier((3.9, 0.2), (3.9, 1.8), (4.1, 1.0), stroke: green-v + 1pt, mark: (end: "stealth", fill: green-v))
    content((4.6, 1.0), text(fill: green-v)[$macron(V)_C$])
  })
]

Applicando la LKT alla maglia si ha:
$ macron(E) = (R - j 1 / (omega C)) macron(I) $

Il fasore della corrente $macron(I)$ vale pertanto:
$ macron(I) = macron(E) / (R - j 1 / (omega C)) = I e^(j varphi_I) $

da cui si ricavano il modulo e la fase della corrente:
$ I = |macron(I)| = E / sqrt(R^2 + (1 / (omega C))^2) $
$ varphi_I = varphi_E - angle (R - j 1 / (omega C)) = 0 - (-arctan(1 / (omega R C))) = arctan(1 / (omega R C)) > 0 $

=== Diagramma Vettoriale per il Circuito $R C$

Noto il fasore della corrente $macron(I) = I e^(j varphi_I)$, si ricavano le tensioni sui componenti:
- *Tensione sul resistore*:
  $ macron(V)_R = R macron(I) = R I e^(j varphi_I) $
  che risulta in fase con la corrente $macron(I)$.
- *Tensione sul condensatore*:
  $ macron(V)_C = -j 1 / (omega C) macron(I) = e^(-j pi / 2) 1 / (omega C) I e^(j varphi_I) = (I / (omega C)) e^(j (varphi_I - pi / 2)) $
  Poiché $-j = e^(-j pi/2)$, la tensione sul condensatore $macron(V)_C$ è *in quadratura in ritardo* di $pi/2$ rispetto alla corrente $macron(I)$ (e quindi rispetto a $macron(V)_R$).

Sommando vettorialmente le due tensioni secondo la LKT si ottiene il fasore del generatore:
$ macron(E) = macron(V)_R + macron(V)_C $

#align(center)[
  #canvas({
    import draw: *
    // Triangolo vettoriale RC (Slide 60)
    let green-v = rgb("#2e6b4e")

    // Vettore E orizzontale
    line((0, 0), (3.5, 0), stroke: green-v + 2pt, mark: (end: "stealth", fill: green-v))
    content((2.2, -0.55), text(fill: green-v, size: 13pt)[$macron(E)$])

    // Vettore V_R nel primo quadrante
    line((0, 0), (2.24, 1.68), stroke: green-v + 2pt, mark: (end: "stealth", fill: green-v))
    content((1.3, 1.9), text(fill: green-v, size: 13pt)[$macron(V)_R$])

    // Vettore I sovrapposto a V_R
    line((0, 0), (1.5, 1.125), stroke: red + 2pt, mark: (end: "stealth", fill: red))
    content((0.65, 1.05), text(fill: red, size: 13pt)[$macron(I)$])

    // Vettore V_C ortogonale
    line((2.24, 1.68), (3.5, 0), stroke: green-v + 2pt, mark: (end: "stealth", fill: green-v))
    content((3.4, 1.15), text(fill: green-v, size: 13pt)[$macron(V)_C$])

    // Simbolo angolo retto
    line((2.0, 1.5), (2.18, 1.26), (2.42, 1.44), stroke: black + 0.9pt)

    // Arco phi_I
    arc((0.9, 0), start: 0deg, stop: 36.87deg, radius: 0.9, stroke: black + 1pt, mark: (end: "stealth", fill: black))
    content((1.25, 0.3), $varphi_I$)
  })
]

#nota[
  In un circuito *ohmico-capacitivo* ($R C$), la corrente $macron(I)$ è sempre *in anticipo* rispetto alla tensione impressa $macron(E)$ di un angolo compreso tra $0$ e $pi/2$ _(Nota: nella slide 60 è presente un refuso di stampa che riporta "ohmico induttivo" anziché "ohmico-capacitivo")_.
]