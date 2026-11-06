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



= Sistemi Trifase
== Introduzione ai sistemi polifase

=== Definizioni generali

I sistemi polifase sono insiemi di generatori e carichi nei quali sono presenti più sorgenti sinusoidali operanti alla stessa frequenza (isofrequenziali). Tali configurazioni sono largamente impiegate nelle applicazioni industriali grazie a specifici vantaggi intrinseci rispetto al sistema sinusoidale a singola sorgente, denominato *sistema monofase*. Poiché operano in regime sinusoidale permanente, i sistemi polifase vengono analizzati mediante il metodo simbolico (fasoriale).

Un insieme di $N$ generatori di tensione sinusoidali isofrequenziali costituisce un *sistema polifase di generatori* se i generatori sono interconnessi e le rispettive tensioni presentano uno sfasamento reciproco costante pari all'angolo:

$ varphi = (2 pi) / N $

// VERIFICA: dedotto dall'equazione (formula dell'angolo di sfasamento 2*pi/N e caso pentafase 2*pi/5 = 72 gradi)
A titolo di esempio, in un sistema pentafase ($N = 5$) lo sfasamento tra due generatori consecutivi vale:

$ varphi = (2 pi) / 5 = 72 circ $

La disposizione circuitale simmetrica a stella dei cinque generatori e il corrispondente diagramma fasoriale delle tensioni $overline(E)_1, overline(E)_2, overline(E)_3, overline(E)_4, overline(E)_5$ sono riportati di seguito.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(vsource: (variant: "iec"))

      let r = 3.0
      let angles = (0deg, 72deg, 144deg, 216deg, 288deg)
      let labels = ($overline(E)_1$, $overline(E)_2$, $overline(E)_3$, $overline(E)_4$, $overline(E)_5$)

      for i in range(5) {
        let ang = angles.at(i)
        let p_end = (r * calc.cos(ang), r * calc.sin(ang))
        vsource("e" + str(i + 1), (0, 0), p_end, position: 50%)
        circle(p_end, radius: 0.06, fill: black)
      }
      circle((0, 0), radius: 0.07, fill: black)

      // Segni + ed etichette posizionati senza alcuna intersezione
      content((2.15, 0.2), anchor: "south", sans("+", weight: "bold"))
      content((2.3, 0.45), anchor: "south", text(fill: rgb("#007a14"))[$overline(E)_1$])

      content((0.52, 2.05), anchor: "east", sans("+", weight: "bold"))
      content((0.95, 1.85), anchor: "west", text(fill: rgb("#007a14"))[$overline(E)_2$])

      content((-1.8, 1.15), anchor: "north", sans("+", weight: "bold"))
      content((-1.95, 0.75), anchor: "east", text(fill: rgb("#007a14"))[$overline(E)_3$])

      content((-1.65, -1.35), anchor: "south", sans("+", weight: "bold"))
      content((-1.25, -1.75), anchor: "north", text(fill: rgb("#007a14"))[$overline(E)_4$])

      content((0.78, -2.0), anchor: "west", sans("+", weight: "bold"))
      content((1.0, -1.65), anchor: "west", text(fill: rgb("#007a14"))[$overline(E)_5$])
    })
  ],
  [
    #canvas({
      import draw: *
      let gcol = rgb("#007a14")
      let lengths = (3.3, 2.5, 2.7, 2.2, 2.4)
      let angles = (0deg, 72deg, 144deg, 216deg, 288deg)

      for i in range(5) {
        let ang = angles.at(i)
        let len = lengths.at(i)
        let p_end = (len * calc.cos(ang), len * calc.sin(ang))
        line((0, 0), p_end, stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.2))
      }

      arc((1.05, 0), start: 0deg, stop: 72deg, radius: 1.05, stroke: 0.8pt, mark: (end: "stealth", fill: black, scale: 0.8))
      content((1.15, 0.75), anchor: "west", $(2 pi) / 5$)

      content((2.6, 0.25), anchor: "south", text(fill: gcol)[$overline(E)_1$])
      content((0.85, 2.2), anchor: "west", text(fill: gcol)[$overline(E)_2$])
      content((-1.3, 2.05), anchor: "south", text(fill: gcol)[$overline(E)_3$])
      content((-1.0, -1.65), anchor: "north", text(fill: gcol)[$overline(E)_4$])
      content((0.85, -2.2), anchor: "west", text(fill: gcol)[$overline(E)_5$])
    })
  ]
)

=== Sistema puro e sistema simmetrico

In generale, un sistema polifase di tensioni presenta una risultante fasoriale non nulla:

$ sum_(k=1)^N overline(E)_k != 0 $

Un sistema polifase si definisce *puro* (o a risultante nulla) se la somma fasoriale di tutte le sue grandezze è identicamente uguale a zero:

$ sum_(k=1)^N overline(E)_k = 0 $

Un sistema puro nel quale tutte le sorgenti possiedono lo stesso valore efficace è detto *sistema simmetrico*. Geometricamente, i fasori di un sistema simmetrico a $N$ fasi formano un poligono regolare chiuso di $N$ lati.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #canvas({
      import draw: *
      let gcol = rgb("#007a14")
      let rcol = rgb("#e61900")

      let p0 = (0, 0)
      let p1 = (3.4, 0)
      let p2 = (3.9, 1.9)
      let p3 = (2.2, 3.4)
      let p4 = (0.85, 2.2)
      let p5 = (1.35, 0.35)

      line(p0, p1, stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line(p1, p2, stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line(p2, p3, stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line(p3, p4, stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line(p4, p5, stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))

      line(p0, p5, stroke: (paint: rcol, thickness: 2.0pt), mark: (end: "stealth", fill: rcol, scale: 1.2))

      content((2.65, 0.2), anchor: "south", text(fill: gcol)[$overline(E)_1$])
      content((4.05, 1.75), anchor: "west", text(fill: gcol)[$overline(E)_2$])
      content((2.45, 3.35), anchor: "west", text(fill: gcol)[$overline(E)_3$])
      content((1.25, 1.9), anchor: "west", text(fill: gcol)[$overline(E)_4$])
      content((1.45, 0.55), anchor: "west", text(fill: gcol)[$overline(E)_5$])
      content((0.4, 0.9), anchor: "south", text(fill: rcol)[$sum_(k=1)^5 overline(E)_k$])
    })
    *Sistema a risultante non nulla*
  ],
  [
    #canvas({
      import draw: *
      let gcol = rgb("#007a14")
      let L = 2.4

      let q0 = (0, 0)
      let q1 = (L, 0)
      let q2 = (L + L * calc.cos(72deg), L * calc.sin(72deg))
      let q3 = (L / 2, L * calc.sin(72deg) + L * calc.sin(36deg))
      let q4 = (-L * calc.cos(72deg), L * calc.sin(72deg))

      line(q0, q1, stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line(q1, q2, stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line(q2, q3, stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line(q3, q4, stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line(q4, q0, stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))

      arc((L - 1.0, 0), start: 180deg, stop: 72deg, radius: 1.0, stroke: 0.8pt)
      content((L - 0.8, 1.15), anchor: "south", $(2 pi) / 5$)

      content((1.8, -0.2), anchor: "north", text(fill: gcol)[$overline(E)_1$])
      content((3.1, 1.75), anchor: "west", text(fill: gcol)[$overline(E)_2$])
      content((1.65, 3.45), anchor: "west", text(fill: gcol)[$overline(E)_3$])
      content((0.0, 2.95), anchor: "east", text(fill: gcol)[$overline(E)_4$])
      content((-0.25, 0.55), anchor: "east", text(fill: gcol)[$overline(E)_5$])
    })
    *Sistema pentafase simmetrico*
  ]
)

== Il sistema trifase

=== Architettura del sistema elettrico

Tra tutti i sistemi polifase, il *sistema trifase simmetrico* ($N = 3$) è il più largamente utilizzato. Esso trova impiego sistematico nelle diverse fasi di produzione, trasmissione e distribuzione dell'energia elettrica:

#align(center)[
  #canvas({
    import draw: *
    // Fase 1: Produzione
    rect((0, 0), (3.8, 2.6), stroke: (paint: rgb("#2b5c8f"), thickness: 1.2pt), radius: 0.15)
    content((1.9, 2.2), sans("PRODUZIONE", weight: "bold", size: 9.5pt))
    content((1.9, 1.4), align(center)[#sans("Centrale elettrica", size: 8.5pt)\ #sans("(Alternatore + Trasf. elevatore)", size: 8pt)])

    line((3.8, 1.3), (4.8, 1.3), stroke: 1.2pt, mark: (end: "stealth", fill: black))

    // Fase 2: Trasmissione
    rect((4.8, 0), (8.6, 2.6), stroke: (paint: rgb("#2b5c8f"), thickness: 1.2pt), radius: 0.15)
    content((6.7, 2.2), sans("TRASMISSIONE", weight: "bold", size: 9.5pt))
    content((6.7, 1.4), align(center)[#sans("Linea ad Alta Tensione (AT)", size: 8.5pt)\ #sans("e Trasf. AT/MT", size: 8pt)])

    line((8.6, 1.3), (9.6, 1.3), stroke: 1.2pt, mark: (end: "stealth", fill: black))

    // Fase 3: Distribuzione
    rect((9.6, 0), (13.6, 2.6), stroke: (paint: rgb("#2b5c8f"), thickness: 1.2pt), radius: 0.15)
    content((11.6, 2.2), sans("DISTRIBUZIONE", weight: "bold", size: 9.5pt))
    content((11.6, 1.4), align(center)[#sans("Linea a Media Tensione (MT),", size: 8.5pt)\ #sans("Trasf. MT/BT e Utenze BT", size: 8pt)])
  })
]

=== Terna diretta e terna inversa

Un sistema trifase simmetrico è caratterizzato da tre forme d'onda sinusoidali aventi lo stesso valore efficace $E$, sfasate tra loro di un angolo pari a $(2 pi) / 3 = 120 circ$, la cui somma fasoriale è nulla:

$ sum_(k=1)^3 overline(E)_k = overline(E)_1 + overline(E)_2 + overline(E)_3 = 0 $

A seconda dell'ordine ciclico con cui si susseguono le fasi nel piano complesso, si distinguono due sequenze:

// VERIFICA: dedotto dall'equazione (esponenti +/- j 2*pi/3 nelle espressioni della terna diretta e inversa)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 2em,
  align: (center + top, center + top),
  [
    *Sistema trifase simmetrico diretto*
    $ cases(
      overline(E)_1 = E e^(j 0),
      overline(E)_2 = E e^(-j (2 pi) / 3),
      overline(E)_3 = E e^(j (2 pi) / 3)
    ) $
    #v(0.5em)
    #canvas({
      import draw: *
      let gcol = rgb("#007a14")
      let R = 2.4
      line((0, 0), (R, 0), stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line((0, 0), (R * calc.cos(-120deg), R * calc.sin(-120deg)), stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line((0, 0), (R * calc.cos(120deg), R * calc.sin(120deg)), stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))

      content((1.8, -0.2), anchor: "north", text(fill: gcol)[$overline(E)_1$])
      content((-0.9, -1.75), anchor: "west", text(fill: gcol)[$overline(E)_2$])
      content((-0.9, 1.85), anchor: "west", text(fill: gcol)[$overline(E)_3$])
    })
  ],
  [
    *Sistema trifase simmetrico inverso*
    $ cases(
      overline(E)_1 = E e^(j 0),
      overline(E)_2 = E e^(j (2 pi) / 3),
      overline(E)_3 = E e^(-j (2 pi) / 3)
    ) $
    #v(0.5em)
    #canvas({
      import draw: *
      let gcol = rgb("#007a14")
      let R = 2.4
      line((0, 0), (R, 0), stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line((0, 0), (R * calc.cos(120deg), R * calc.sin(120deg)), stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line((0, 0), (R * calc.cos(-120deg), R * calc.sin(-120deg)), stroke: (paint: gcol, thickness: 1.8pt), mark: (end: "stealth", fill: gcol, scale: 1.1))

      content((1.8, -0.2), anchor: "north", text(fill: gcol)[$overline(E)_1$])
      content((-0.9, 1.85), anchor: "west", text(fill: gcol)[$overline(E)_2$])
      content((-0.9, -1.75), anchor: "west", text(fill: gcol)[$overline(E)_3$])
    })
  ]
)

=== Proprietà nel dominio del tempo

La proprietà di simmetria della terna si riflette direttamente nel dominio del tempo: se la terna è simmetrica, la somma istantanea delle tre tensioni $e_1(t)$, $e_2(t)$ ed $e_3(t)$ è identicamente nulla in ogni istante $t$, indipendentemente dal fatto che la sequenza sia diretta o inversa:

$ e_1(t) + e_2(t) + e_3(t) = 0 quad forall t $

#align(center)[
  #canvas({
    import draw: *
    let W = 8.0
    let H = 2.2

    // Riquadro e griglia
    rect((0, -H), (W, H), stroke: 0.7pt)
    for ix in range(1, 8) {
      let x = ix * (W / 8.0)
      line((x, -H), (x, H), stroke: (paint: gray.lighten(40%), thickness: 0.5pt))
    }
    for iy in (-3, -2, -1, 0, 1, 2, 3) {
      let y = iy * (H / 4.0)
      line((0, y), (W, y), stroke: (paint: gray.lighten(40%), thickness: 0.5pt))
    }

    // Assi ed etichette numeriche
    let t_vals = ("0.0", "2.5", "5.0", "7.5", "10.0", "12.5", "15.0", "17.5", "20.0")
    for ix in range(9) {
      let x = ix * (W / 8.0)
      content((x, -H - 0.15), anchor: "north", sans(t_vals.at(ix), size: 7.5pt))
    }
    content((W / 2, -H - 0.6), anchor: "north", sans("time (ms)", size: 8.5pt))

    let v_vals = ("-100", "-75", "-50", "-25", "0", "25", "50", "75", "100")
    for iy in range(-4, 5) {
      let y = iy * (H / 4.0)
      content((-0.15, y), anchor: "east", sans(v_vals.at(iy + 4), size: 7.5pt))
    }
    content((-1.1, 0), angle: 90deg, sans("Voltage (V)", size: 8.5pt))

    // Campionamento delle tre sinusoidi (terna inversa come nel grafico: e2 a +120 deg, e3 a -120 deg)
    let N_pts = 80
    let pts1 = ()
    let pts2 = ()
    let pts3 = ()
    for k in range(N_pts + 1) {
      let x = k * (W / N_pts)
      let phi = k * (360deg / N_pts)
      let y1 = (H * 4.0 / 4.4) * calc.sin(phi)
      let y2 = (H * 4.0 / 4.4) * calc.sin(phi + 120deg)
      let y3 = (H * 4.0 / 4.4) * calc.sin(phi - 120deg)
      pts1.push((x, y1))
      pts2.push((x, y2))
      pts3.push((x, y3))
    }

    line(..pts1, stroke: (paint: rgb("#1f77b4"), thickness: 1.3pt))
    line(..pts2, stroke: (paint: rgb("#ff7f0e"), thickness: 1.3pt))
    line(..pts3, stroke: (paint: rgb("#2ca02c"), thickness: 1.3pt))
    line((0, 0), (W, 0), stroke: (paint: rgb("#d62728"), thickness: 1.5pt))

    // Legenda a destra
    let lx = W + 0.4
    rect((lx, 0.4), (lx + 3.8, H), stroke: (paint: gray, thickness: 0.6pt), radius: 0.08)
    line((lx + 0.15, H - 0.25), (lx + 0.75, H - 0.25), stroke: (paint: rgb("#1f77b4"), thickness: 1.3pt))
    content((lx + 0.9, H - 0.25), anchor: "west", sans("e1(t)", size: 7.5pt))

    line((lx + 0.15, H - 0.65), (lx + 0.75, H - 0.65), stroke: (paint: rgb("#ff7f0e"), thickness: 1.3pt))
    content((lx + 0.9, H - 0.65), anchor: "west", sans("e2(t)", size: 7.5pt))

    line((lx + 0.15, H - 1.05), (lx + 0.75, H - 1.05), stroke: (paint: rgb("#2ca02c"), thickness: 1.3pt))
    content((lx + 0.9, H - 1.05), anchor: "west", sans("e3(t)", size: 7.5pt))

    line((lx + 0.15, H - 1.45), (lx + 0.75, H - 1.45), stroke: (paint: rgb("#d62728"), thickness: 1.5pt))
    content((lx + 0.9, H - 1.45), anchor: "west", sans("e1(t)+e2(t)+e3(t)", size: 7.5pt))
  })
]

=== Componenti trifase: il tripolo

Il componente fondamentale alla base dei sistemi trifase è il *tripolo*. Esso è caratterizzato dalla presenza di tre morsetti (indicati con $1, 2, 3$) e viene rappresentato graficamente mediante un blocco rettangolare, che individua la superficie limite del componente, da cui fuoriescono le tre connessioni esterne. Ciascuna connessione esterna prende il nome di *circuito di fase* (o semplicemente *fase*).

Ai morsetti del tripolo si definiscono le seguenti grandezze elettriche fondamentali:
- *Tensioni di linea (o tensioni concatenate)*: le tensioni $overline(V)_(1 2)$, $overline(V)_(2 3)$ e $overline(V)_(3 1)$ misurate tra coppie di morsetti esterni.
- *Correnti di linea*: le correnti $overline(I)_1$, $overline(I)_2$ e $overline(I)_3$ che attraversano i tre morsetti di linea.

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1.2em,
  align: (center + horizon, center + horizon, center + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *

      rect((0, 0), (1.3, 4.0), stroke: 1.2pt)
      wire((1.3, 3.4), (2.7, 3.4))
      wire((1.3, 2.0), (2.7, 2.0))
      wire((1.3, 0.6), (2.7, 0.6))

      node("m1", (2.7, 3.4), fill: false)
      node("m2", (2.7, 2.0), fill: false)
      node("m3", (2.7, 0.6), fill: false)

      content((2.7, 3.6), anchor: "south", sans("1", weight: "bold"))
      content((2.7, 2.2), anchor: "south", sans("2", weight: "bold"))
      content((2.7, 0.8), anchor: "south", sans("3", weight: "bold"))
    })
    *Tripolo*
  ],
  [
    #zap.circuit({
      
      import zap.cetz.draw: *

      rect((0, 0), (1.3, 4.0), stroke: 1.2pt)
      wire((1.3, 3.4), (2.7, 3.4))
      wire((1.3, 2.0), (2.7, 2.0))
      wire((1.3, 0.6), (2.7, 0.6))

      node("m1", (2.7, 3.4), fill: false)
      node("m2", (2.7, 2.0), fill: false)
      node("m3", (2.7, 0.6), fill: false)

      content((2.7, 3.6), anchor: "south", sans("1", weight: "bold"))
      content((2.7, 2.2), anchor: "south", sans("2", weight: "bold"))
      content((2.7, 0.8), anchor: "south", sans("3", weight: "bold"))

      bezier((2.6, 2.15), (2.6, 3.25), (2.15, 2.7), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((2.2, 2.7), anchor: "east", $overline(V)_(1 2)$)

      bezier((2.6, 0.75), (2.6, 1.85), (2.15, 1.3), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((2.2, 1.3), anchor: "east", $overline(V)_(2 3)$)

      bezier((2.85, 0.7), (2.85, 3.3), (3.65, 2.0), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((3.55, 2.0), anchor: "west", $overline(V)_(3 1)$)
    })
    *Tensioni di linea*
  ],
  [
    #zap.circuit({
      
      import zap.cetz.draw: *

      rect((0, 0), (1.3, 4.0), stroke: 1.2pt)
      wire((1.3, 3.4), (2.7, 3.4))
      wire((1.3, 2.0), (2.7, 2.0))
      wire((1.3, 0.6), (2.7, 0.6))

      node("m1", (2.7, 3.4), fill: false)
      node("m2", (2.7, 2.0), fill: false)
      node("m3", (2.7, 0.6), fill: false)

      content((2.7, 3.6), anchor: "south", sans("1", weight: "bold"))
      content((2.7, 2.2), anchor: "south", sans("2", weight: "bold"))
      content((2.7, 0.8), anchor: "south", sans("3", weight: "bold"))

      line((4.1, 3.4), (3.1, 3.4), stroke: 0.9pt, mark: (end: "stealth", fill: black, scale: 1.1))
      content((3.7, 3.55), anchor: "south", $overline(I)_1$)

      line((4.1, 2.0), (3.1, 2.0), stroke: 0.9pt, mark: (end: "stealth", fill: black, scale: 1.1))
      content((3.7, 2.15), anchor: "south", $overline(I)_2$)

      line((4.1, 0.6), (3.1, 0.6), stroke: 0.9pt, mark: (end: "stealth", fill: black, scale: 1.1))
      content((3.7, 0.75), anchor: "south", $overline(I)_3$)
    })
    *Correnti di linea*
  ]
)

=== Connessione dei generatori a stella (Y) e tensioni concatenate

Un sistema trifase di generatori si ottiene collegando tre generatori sinusoidali a un nodo comune $O$, denominato *centro stella*. Le tensioni impresse dai singoli generatori ($overline(E)_1, overline(E)_2, overline(E)_3$) prendono il nome di *tensioni di fase* (o tensioni stellate).

#align(center)[
  #scale(x: 90%, y: 90%, reflow: true)[
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(vsource: (variant: "iec"))

      // 1) Stella geometrica a sinistra
      let cx = 0.0
      let cy = 2.0
      let R = 2.4
      vsource("eg1", (cx, cy), (cx + R, cy), position: 50%)
      vsource("eg2", (cx, cy), (cx + R * calc.cos(120deg), cy + R * calc.sin(120deg)), position: 50%)
      vsource("eg3", (cx, cy), (cx + R * calc.cos(-120deg), cy + R * calc.sin(-120deg)), position: 50%)
      circle((cx, cy), radius: 0.06, fill: black)
      circle((cx + R, cy), radius: 0.06, fill: black)
      circle((cx + R * calc.cos(120deg), cy + R * calc.sin(120deg)), radius: 0.06, fill: black)
      circle((cx + R * calc.cos(-120deg), cy + R * calc.sin(-120deg)), radius: 0.06, fill: black)

      content((cx + 1.65, cy + 0.15), anchor: "south", sans("+", weight: "bold"))
      content((cx + 1.75, cy + 0.45), anchor: "south", text(fill: rgb("#007a14"))[$overline(E)_1$])

      content((cx - 0.95, cy + 1.35), anchor: "east", sans("+", weight: "bold"))
      content((cx - 0.35, cy + 1.55), anchor: "south", text(fill: rgb("#007a14"))[$overline(E)_2$])

      content((cx - 0.7, cy - 1.55), anchor: "north", sans("+", weight: "bold"))
      content((cx - 0.45, cy - 1.5), anchor: "west", text(fill: rgb("#007a14"))[$overline(E)_3$])

      // 2) Connessione a Y in scatola tratteggiata al centro
      let bx = 4.2
      rect((bx - 0.5, -0.3), (bx + 2.3, 4.3), stroke: (dash: "dashed", thickness: 0.8pt))
      wire((bx, 0.5), (bx, 3.5))
      node("O_mid", (bx, 2.0))
      content((bx - 0.2, 2.0), anchor: "east", $O$)

      vsource("ey1", (bx, 3.5), (bx + 2.8, 3.5), position: 45%)
      vsource("ey2", (bx, 2.0), (bx + 2.8, 2.0), position: 45%)
      vsource("ey3", (bx, 0.5), (bx + 2.8, 0.5), position: 45%)

      node("y1", (bx + 2.8, 3.5), fill: false)
      node("y2", (bx + 2.8, 2.0), fill: false)
      node("y3", (bx + 2.8, 0.5), fill: false)

      content((rel: (0, 0.55), to: "ey1.center"), anchor: "south", $overline(E)_1$)
      content((rel: (0.48, 0.15), to: "ey1.center"), anchor: "south", sans("+", weight: "bold"))
      content((rel: (0, 0.55), to: "ey2.center"), anchor: "south", $overline(E)_2$)
      content((rel: (0.48, 0.15), to: "ey2.center"), anchor: "south", sans("+", weight: "bold"))
      content((rel: (0, 0.55), to: "ey3.center"), anchor: "south", $overline(E)_3$)
      content((rel: (0.48, 0.15), to: "ey3.center"), anchor: "south", sans("+", weight: "bold"))

      content((bx + 2.8, 3.68), anchor: "south", sans("1"))
      content((bx + 2.8, 2.18), anchor: "south", sans("2"))
      content((bx + 2.8, 0.68), anchor: "south", sans("3"))

      // 3) Tripolo equivalente a destra
      let tx = 8.6
      rect((tx, 0.0), (tx + 1.3, 4.0), stroke: 1.2pt)
      wire((tx + 1.3, 3.5), (tx + 2.7, 3.5))
      wire((tx + 1.3, 2.0), (tx + 2.7, 2.0))
      wire((tx + 1.3, 0.5), (tx + 2.7, 0.5))

      node("t1", (tx + 2.7, 3.5), fill: false)
      node("t2", (tx + 2.7, 2.0), fill: false)
      node("t3", (tx + 2.7, 0.5), fill: false)

      content((tx + 2.7, 3.68), anchor: "south", sans("1", weight: "bold"))
      content((tx + 2.7, 2.18), anchor: "south", sans("2", weight: "bold"))
      content((tx + 2.7, 0.68), anchor: "south", sans("3", weight: "bold"))

      bezier((tx + 2.6, 2.15), (tx + 2.6, 3.35), (tx + 2.15, 2.75), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((tx + 2.2, 2.75), anchor: "east", $overline(V)_(1 2)$)

      bezier((tx + 2.6, 0.65), (tx + 2.6, 1.85), (tx + 2.15, 1.25), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((tx + 2.2, 1.25), anchor: "east", $overline(V)_(2 3)$)

      bezier((tx + 2.85, 0.6), (tx + 2.85, 3.4), (tx + 3.65, 2.0), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((tx + 3.55, 2.0), anchor: "west", $overline(V)_(3 1)$)
    })
  ]
]

=== Rappresentazione circuitale della filiera elettrica

Con questa notazione, l'intero sistema elettrico di potenza (che opera a differenti livelli di tensione: Media Tensione $"MT"$, Alta Tensione $"AT"$ e Bassa Tensione $"BT"$) può essere schematizzato in forma circuitale trifase:

#align(center)[
  #scale(x: 85%, y: 85%, reflow: true)[
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(vsource: (variant: "iec"))

      let rcol = rgb("#c41e1e")

      // Alternatore a sinistra
      wire((0, 0.8), (0, 3.2))
      vsource("ea1", (0, 3.2), (2.2, 3.2), position: 50%)
      vsource("ea2", (0, 2.0), (2.2, 2.0), position: 50%)
      vsource("ea3", (0, 0.8), (2.2, 0.8), position: 50%)
      for y in (3.2, 2.0, 0.8) { circle((2.2, y), radius: 0.05, fill: black) }

      content((rel: (0, 0.45), to: "ea1.center"), anchor: "south", $underline(E)_1$)
      content((rel: (0.4, 0.12), to: "ea1.center"), anchor: "south", sans("+", size: 8pt, weight: "bold"))
      content((rel: (-0.4, 0.12), to: "ea1.center"), anchor: "south", sans("-", size: 8pt, weight: "bold"))

      content((rel: (0, 0.45), to: "ea2.center"), anchor: "south", $underline(E)_2$)
      content((rel: (0.4, 0.12), to: "ea2.center"), anchor: "south", sans("+", size: 8pt, weight: "bold"))
      content((rel: (-0.4, 0.12), to: "ea2.center"), anchor: "south", sans("-", size: 8pt, weight: "bold"))

      content((rel: (0, 0.45), to: "ea3.center"), anchor: "south", $underline(E)_3$)
      content((rel: (0.4, 0.12), to: "ea3.center"), anchor: "south", sans("+", size: 8pt, weight: "bold"))
      content((rel: (-0.4, 0.12), to: "ea3.center"), anchor: "south", sans("-", size: 8pt, weight: "bold"))

      content((1.1, 0.1), anchor: "north", align(center)[#text(fill: rcol)[#sans("Alternatore", size: 9pt)\ #sans("(in MT)", size: 9pt)]])

      // Trasformatore elevatore MT/AT
      line((2.2, 3.2), (2.6, 3.2), (2.95, 2.35))
      line((2.2, 2.0), (2.8, 2.0))
      line((2.2, 0.8), (2.6, 0.8), (2.95, 1.65))
      circle((3.2, 2.0), radius: 0.42, stroke: 1.1pt)
      circle((3.65, 2.0), radius: 0.42, stroke: 1.1pt)
      line((3.9, 2.35), (4.25, 3.2), (4.8, 3.2))
      line((4.07, 2.0), (4.8, 2.0))
      line((3.9, 1.65), (4.25, 0.8), (4.8, 0.8))

      content((3.42, 3.8), anchor: "south", align(center)[#text(fill: rcol)[#sans("Trasformatore", size: 8.5pt)\ #sans("elevatore", size: 8.5pt)]])
      content((3.42, 1.3), anchor: "north", sans("MT/AT", size: 8.5pt, weight: "bold"))

      // Linea elettrica AT
      rect((4.8, 0.3), (6.2, 3.7), stroke: 1.1pt)
      content((5.5, 2.0), align(center)[#text(fill: rcol)[#sans("Linea", size: 8.5pt)\ #sans("elettrica", size: 8.5pt)\ #sans("AT", size: 8.5pt)]])
      content((5.5, 0.0), anchor: "north", align(center)[#text(fill: rcol)[#sans("Trasmissione", size: 8.5pt)\ #sans("ad alta tensione (AT)", size: 8.5pt)]])

      // Collegamento e Trasformatore abbassatore AT/MT
      for y in (3.2, 2.0, 0.8) {
        line((6.2, y), (7.0, y))
        circle((7.0, y), radius: 0.05, fill: black)
      }
      line((7.0, 3.2), (7.4, 3.2), (7.75, 2.35))
      line((7.0, 2.0), (7.6, 2.0))
      line((7.0, 0.8), (7.4, 0.8), (7.75, 1.65))
      circle((8.0, 2.0), radius: 0.42, stroke: 1.1pt)
      circle((8.45, 2.0), radius: 0.42, stroke: 1.1pt)
      line((8.7, 2.35), (9.05, 3.2), (9.6, 3.2))
      line((8.87, 2.0), (9.6, 2.0))
      line((8.7, 1.65), (9.05, 0.8), (9.6, 0.8))

      content((8.22, 3.8), anchor: "south", align(center)[#text(fill: rcol)[#sans("Trasformatore", size: 8.5pt)\ #sans("abbassatore", size: 8.5pt)]])
      content((8.22, 1.3), anchor: "north", sans("AT/MT", size: 8.5pt, weight: "bold"))

      // Linea elettrica MT
      rect((9.6, 0.3), (11.0, 3.7), stroke: 1.1pt)
      content((10.3, 2.0), align(center)[#text(fill: rcol)[#sans("Linea", size: 8.5pt)\ #sans("elettrica", size: 8.5pt)\ #sans("MT", size: 8.5pt)]])
      content((10.3, 0.0), anchor: "north", align(center)[#text(fill: rcol)[#sans("Distribuzione", size: 8.5pt)\ #sans("in Media Tensione (MT)", size: 8.5pt)]])

      // Collegamento e Trasformatore abbassatore MT/BT
      for y in (3.2, 2.0, 0.8) {
        line((11.0, y), (11.8, y))
        circle((11.8, y), radius: 0.05, fill: black)
      }
      line((11.8, 3.2), (12.2, 3.2), (12.55, 2.35))
      line((11.8, 2.0), (12.4, 2.0))
      line((11.8, 0.8), (12.2, 0.8), (12.55, 1.65))
      circle((12.8, 2.0), radius: 0.42, stroke: 1.1pt)
      circle((13.25, 2.0), radius: 0.42, stroke: 1.1pt)
      content((12.68, 2.0), text(fill: rcol)[$Delta$])
      content((13.38, 2.0), text(fill: rcol)[#sans("Y", size: 8pt, weight: "bold")])

      content((13.02, 3.8), anchor: "south", align(center)[#text(fill: rcol)[#sans("Trasformatore", size: 8.5pt)\ #sans("abbassatore", size: 8.5pt)]])
      content((13.02, 1.3), anchor: "north", sans("MT/BT", size: 8.5pt, weight: "bold"))

      // Uscita BT a 4 fili (R, S, T, N)
      let y_bt = (2.3, 2.1, 1.9, 1.7)
      let l_bt = ("R", "S", "T", "N")
      for i in range(4) {
        let yb = y_bt.at(i)
        line((13.65, yb), (14.8, yb), stroke: 0.8pt)
        content((14.9, yb), anchor: "west", text(fill: rcol)[#sans(l_bt.at(i), size: 6.5pt, weight: "bold")])
      }
      content((14.4, 1.2), anchor: "north", text(fill: rcol)[#sans("BT", size: 9.5pt, weight: "bold")])
    })
  ]
]

=== Relazione tra tensioni di linea e tensioni di fase

Qualora il centro stella $O$ non sia direttamente accessibile dall'esterno, le tensioni di fase $overline(E)_1, overline(E)_2, overline(E)_3$ non sono misurabili singolarmente. È invece sempre possibile misurare le tensioni di linea (o concatenate) tra le coppie di morsetti esterni $1, 2, 3$.

#grid(
  columns: (1.1fr, 0.9fr),
  column-gutter: 1.5em,
  align: (center + horizon, left + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(vsource: (variant: "iec"))

      wire((0, 0.5), (0, 3.5))
      node("O", (0, 2.0))
      content((-0.2, 2.0), anchor: "east", $O$)

      vsource("e1", (0, 3.5), (3.2, 3.5), position: 45%)
      vsource("e2", (0, 2.0), (3.2, 2.0), position: 45%)
      vsource("e3", (0, 0.5), (3.2, 0.5), position: 45%)

      node("m1", (3.2, 3.5), fill: false)
      node("m2", (3.2, 2.0), fill: false)
      node("m3", (3.2, 0.5), fill: false)

      content((rel: (0, 0.55), to: "e1.center"), anchor: "south", $overline(E)_1$)
      content((rel: (0.48, 0.15), to: "e1.center"), anchor: "south", sans("+", weight: "bold"))
      content((rel: (0, 0.55), to: "e2.center"), anchor: "south", $overline(E)_2$)
      content((rel: (0.48, 0.15), to: "e2.center"), anchor: "south", sans("+", weight: "bold"))
      content((rel: (0, 0.55), to: "e3.center"), anchor: "south", $overline(E)_3$)
      content((rel: (0.48, 0.15), to: "e3.center"), anchor: "south", sans("+", weight: "bold"))

      content((3.2, 3.68), anchor: "south", sans("1", weight: "bold"))
      content((3.2, 2.18), anchor: "south", sans("2", weight: "bold"))
      content((3.2, 0.68), anchor: "south", sans("3", weight: "bold"))

      bezier((3.35, 2.15), (3.35, 3.35), (3.75, 2.75), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((3.68, 2.75), anchor: "west", $overline(V)_(1 2)$)

      bezier((3.35, 0.65), (3.35, 1.85), (3.75, 1.25), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((3.68, 1.25), anchor: "west", $overline(V)_(2 3)$)

      bezier((3.8, 3.4), (3.8, 0.6), (5.1, 2.0), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((4.9, 2.0), anchor: "west", $overline(V)_(3 1)$)
    })
  ],
  [
    Applicando la legge di Kirchhoff delle tensioni (LKT) alle maglie individuate dai morsetti esterni e dal centro stella $O$, si ricavano le relazioni fondamentali tra tensioni concatenate e tensioni stellate:
    $ cases(
      overline(V)_(1 2) = overline(E)_1 - overline(E)_2,
      overline(V)_(2 3) = overline(E)_2 - overline(E)_3,
      overline(V)_(3 1) = overline(E)_3 - overline(E)_1
    ) $
  ]
)

Geometricamente, nel piano di Gauss i fasori delle tensioni concatenate congiungono le punte dei fasori delle tensioni di fase, formando un triangolo equilatero circoscritto alla stella dei generatori:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #canvas({
      import draw: *
      let R = 2.6
      let p0 = (0, 0)
      let p1 = (R, 0)
      let p2 = (R * calc.cos(-120deg), R * calc.sin(-120deg))
      let p3 = (R * calc.cos(120deg), R * calc.sin(120deg))

      // Stella tensioni di fase
      line(p0, p1, stroke: (paint: black, thickness: 1.8pt), mark: (end: "stealth", fill: black, scale: 1.1))
      line(p0, p2, stroke: (paint: black, thickness: 1.8pt), mark: (end: "stealth", fill: black, scale: 1.1))
      line(p0, p3, stroke: (paint: black, thickness: 1.8pt), mark: (end: "stealth", fill: black, scale: 1.1))

      // Triangolo tensioni concatenate
      let gcol = rgb("#555555")
      line(p2, p1, stroke: (paint: gcol, thickness: 1.5pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line(p3, p2, stroke: (paint: gcol, thickness: 1.5pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line(p1, p3, stroke: (paint: gcol, thickness: 1.5pt), mark: (end: "stealth", fill: gcol, scale: 1.1))

      content((0.1, 0.25), anchor: "south", $0$)
      content((R + 0.15, 0.05), anchor: "west", $1$)
      content((p2.at(0) - 0.1, p2.at(1) - 0.1), anchor: "north", $2$)
      content((p3.at(0) - 0.1, p3.at(1) + 0.1), anchor: "south", $3$)

      content((1.65, -0.15), anchor: "north", $overline(E)_1$)
      content((-0.6, -1.6), anchor: "west", $overline(E)_2$)
      content((-0.6, 1.5), anchor: "west", $overline(E)_3$)

      content((2.0, -0.55), anchor: "west", $overline(V)_(1 2)$)
      content((-1.4, -1.65), anchor: "east", text(fill: gcol)[$overline(V)_(2 3)$])
      content((-0.2, 1.95), anchor: "south", text(fill: gcol)[$overline(V)_(3 1)$])
    })
  ],
  [
    #canvas({
      import draw: *
      let R = 3.2
      let p0 = (0, 0)
      let p1 = (R, 0)
      let p2 = (R * calc.cos(-120deg), R * calc.sin(-120deg))
      let pH = ((p1.at(0) + p2.at(0)) / 2, (p1.at(1) + p2.at(1)) / 2)

      line(p0, p1, stroke: (paint: black, thickness: 1.8pt), mark: (end: "stealth", fill: black, scale: 1.1))
      line(p0, p2, stroke: (paint: black, thickness: 1.8pt), mark: (end: "stealth", fill: black, scale: 1.1))
      line(p2, p1, stroke: (paint: black, thickness: 1.8pt), mark: (end: "stealth", fill: black, scale: 1.1))
      line(p0, pH, stroke: 0.9pt)

      // Angolo 30 gradi al vertice 1
      arc((R - 0.85, 0), start: 180deg, stop: 210deg, radius: 0.85, stroke: 0.8pt)
      content((R - 0.95, -0.28), anchor: "east", $30 circ$)

      // Angolo 90 gradi in H
      arc((pH.at(0) + 0.35 * calc.cos(30deg), pH.at(1) + 0.35 * calc.sin(30deg)), start: 30deg, stop: 120deg, radius: 0.35, stroke: 0.8pt)
      content((pH.at(0) + 0.25, pH.at(1) + 0.55), anchor: "south", $90 circ$)

      content((-0.15, 0.15), anchor: "south", $0$)
      content((R + 0.15, 0.1), anchor: "west", $1$)
      content((p2.at(0) - 0.1, p2.at(1) - 0.1), anchor: "north", $2$)
      content((pH.at(0) + 0.15, pH.at(1) - 0.15), anchor: "north", $H$)

      content((R - 0.4, 0.2), anchor: "south", $overline(E)_1$)
      content((p2.at(0) - 0.15, p2.at(1) + 0.85), anchor: "east", $overline(E)_2$)
      content((R - 0.5, -0.55), anchor: "north", $overline(V)_(1 2)$)
    })
  ]
)

// VERIFICA: dedotto dall'equazione (relazione trigonometrica sul triangolo rettangolo 0-H-1: V = 2*E*cos(30) = sqrt(3)*E)
#nota[
  Dal triangolo isoscele $0 - 1 - 2$, diviso dall'altezza $0 H$ in due triangoli rettangoli congruenti con angolo alla base di $30 circ$, si deduce che in un sistema trifase simmetrico il valore efficace $V$ delle tensioni concatenate è legato al valore efficace $E$ delle tensioni di fase dalla relazione:
  $ V = 2 E cos(30 circ) = sqrt(3) E $
  Inoltre, la terna delle tensioni concatenate risulta sfasata in anticipo di $30 circ$ ($pi / 6$) rispetto alla corrispondente terna delle tensioni stellate (nel caso di terna diretta).
]

== Circuiti trifase e analisi dei collegamenti Y-Y e Y-Δ

=== Connessione dei carichi trifase

I carichi trifase sono realizzati collegando tra loro tre bipoli di impedenza $overline(Z)_1, overline(Z)_2, overline(Z)_3$ secondo due configurazioni fondamentali: la connessione a *stella (Y)* e la connessione a *triangolo ($Delta$)*.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 2em,
  align: (center + horizon, center + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *

      resistor("z1", (0, 3.2), (3.4, 3.2), variant: "iec")
      resistor("z2", (0, 1.8), (3.4, 1.8), variant: "iec")
      resistor("z3", (0, 0.4), (3.4, 0.4), variant: "iec")

      wire((3.4, 0.4), (3.4, 3.2))
      node("O_load", (3.4, 1.8))

      node("c1", (0, 3.2), fill: false)
      node("c2", (0, 1.8), fill: false)
      node("c3", (0, 0.4), fill: false)

      content((0, 3.4), anchor: "south", sans("1", weight: "bold"))
      content((0, 2.0), anchor: "south", sans("2", weight: "bold"))
      content((0, 0.6), anchor: "south", sans("3", weight: "bold"))

      content((rel: (0, 0.45), to: "z1.center"), anchor: "south", $overline(Z)_1$)
      content((rel: (0, 0.45), to: "z2.center"), anchor: "south", $overline(Z)_2$)
      content((rel: (0, 0.45), to: "z3.center"), anchor: "south", $overline(Z)_3$)
    })
    *Carico connesso a stella (Y)*
  ],
  [
    #zap.circuit({
      
      import zap.cetz.draw: *

      wire((0, 3.6), (3.4, 3.6))
      wire((0, 1.8), (1.6, 1.8))
      wire((0, 0.0), (3.4, 0.0))

      resistor("z1", (1.6, 3.6), (1.6, 1.8), variant: "iec")
      resistor("z2", (1.6, 1.8), (1.6, 0.0), variant: "iec")
      resistor("z3", (3.4, 3.6), (3.4, 0.0), variant: "iec")

      node("d1", (1.6, 3.6))
      node("d2", (1.6, 1.8))
      node("d3", (1.6, 0.0))

      node("m1", (0, 3.6), fill: false)
      node("m2", (0, 1.8), fill: false)
      node("m3", (0, 0.0), fill: false)

      content((0, 3.8), anchor: "south", sans("1", weight: "bold"))
      content((0, 2.0), anchor: "south", sans("2", weight: "bold"))
      content((0, 0.2), anchor: "south", sans("3", weight: "bold"))

      content((rel: (0.45, 0), to: "z1.center"), anchor: "west", $overline(Z)_1$)
      content((rel: (0.45, 0), to: "z2.center"), anchor: "west", $overline(Z)_2$)
      content((rel: (0.45, 0), to: "z3.center"), anchor: "west", $overline(Z)_3$)
    })
    *Carico connesso a triangolo ($Delta$)*
  ]
)

#nota[
  *Definizione (Carico equilibrato)*: Se le tre impedenze collegate sono uguali tra loro sia in modulo sia in fase ($overline(Z)_1 = overline(Z)_2 = overline(Z)_3 = overline(Z)$), il sistema di carichi è detto *equilibrato*.
]

=== Il circuito stella-stella (Y-Y)

Collegando un sistema trifase di generatori connessi a stella (con centro stella $O$) a un insieme di carichi anch'essi connessi a stella (con centro stella $O'$), si ottiene il *circuito Y-Y*. La struttura risultante è costituita da tre lati (o circuiti di fase) posti in parallelo tra i due centri stella $O$ e $O'$.

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *
    set-style(vsource: (variant: "iec"))

    let y_levels = (4.0, 2.2, 0.4)
    wire((0, 0.4), (0, 4.0))
    wire((8.6, 0.4), (8.6, 4.0))
    node("O", (0, 2.2))
    node("Op", (8.6, 2.2))
    content((-0.25, 2.2), anchor: "east", $O$)
    content((8.85, 2.2), anchor: "west", $O'$)

    for idx in range(3) {
      let y = y_levels.at(idx)
      let k = str(idx + 1)

      vsource("e" + k, (0, y), (3.8, y), position: 45%)
      wire((3.8, y), (5.2, y))
      resistor("z" + k, (5.2, y), (8.6, y), variant: "iec", position: 50%)

      node("m" + k, (3.8, y), fill: false)
      content((3.8, y + 0.2), anchor: "south", sans(k, weight: "bold"))

      // Etichette generatore
      content((rel: (0, 0.55), to: "e" + k + ".center"), anchor: "south", $overline(E)_#k$)
      content((rel: (0.48, 0.15), to: "e" + k + ".center"), anchor: "south", sans("+", weight: "bold"))

      // Freccia corrente di linea
      line((4.25, y + 0.2), (4.95, y + 0.2), stroke: 0.85pt, mark: (end: "stealth", fill: black, scale: 1.1))
      content((4.6, y + 0.35), anchor: "south", $overline(I)_#k$)

      // Etichette impedenza e tensione sul carico
      content((rel: (0, -0.45), to: "z" + k + ".center"), anchor: "north", $overline(Z)_#k$)
      bezier((7.4, y + 0.38), (6.4, y + 0.38), (6.9, y + 0.72), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((6.9, y + 0.72), anchor: "south", $overline(E)'_#k$)
    }

    // Freccia tensione tra i centri stella V_{O'O}
    bezier((0, -0.2), (8.6, -0.2), (4.3, -1.2), stroke: 0.8pt, mark: (end: "stealth", fill: black))
    content((4.3, -0.95), anchor: "north", $overline(V)_(O' O)$)
  })
]

=== Calcolo della tensione tra i centri stella (Teorema di Millman)

// VERIFICA: dedotto dall'equazione (formula di Millman applicata ai tre rami in parallelo tra O e O')
La tensione $overline(V)_(O' O)$ che si manifesta tra il centro stella dei carichi $O'$ e il centro stella dei generatori $O$ può essere determinata direttamente mediante il *teorema di Millman*:

$ overline(V)_(O' O) = (display(sum_(k=1)^3 overline(E)_k / overline(Z)_k)) / (display(sum_(k=1)^3 1 / overline(Z)_k)) = (overline(E)_1 / overline(Z)_1 + overline(E)_2 / overline(Z)_2 + overline(E)_3 / overline(Z)_3) / (1 / overline(Z)_1 + 1 / overline(Z)_2 + 1 / overline(Z)_3) $

Nota la tensione $overline(V)_(O' O)$, ciascun lato $k$ ($k = 1, 2, 3$) può essere studiato isolatamente:

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *
    set-style(vsource: (variant: "iec"))

    let y = 0.0
    vsource("e1", (0, y), (3.8, y), position: 45%)
    wire((3.8, y), (5.2, y))
    resistor("z1", (5.2, y), (8.6, y), variant: "iec", position: 50%)

    node("O", (0, y), fill: false)
    node("m1", (3.8, y), fill: false)
    node("Op", (8.6, y), fill: false)

    content((-0.2, y), anchor: "east", $O$)
    content((3.8, y + 0.2), anchor: "south", sans("1", weight: "bold"))
    content((8.8, y), anchor: "west", $O'$)

    content((rel: (0, 0.55), to: "e1.center"), anchor: "south", $overline(E)_1$)
    content((rel: (0.48, 0.15), to: "e1.center"), anchor: "south", sans("+", weight: "bold"))

    line((4.25, y + 0.2), (4.95, y + 0.2), stroke: 0.85pt, mark: (end: "stealth", fill: black, scale: 1.1))
    content((4.6, y + 0.35), anchor: "south", $overline(I)_1$)

    content((rel: (0, -0.45), to: "z1.center"), anchor: "north", $overline(Z)_1$)
    bezier((7.4, y + 0.38), (6.4, y + 0.38), (6.9, y + 0.72), stroke: 0.75pt, mark: (end: "stealth", fill: black))
    content((6.9, y + 0.72), anchor: "south", $overline(E)'_1$)

    bezier((0, -0.45), (8.6, -0.45), (4.3, -1.45), stroke: 0.8pt, mark: (end: "stealth", fill: black))
    content((4.3, -1.2), anchor: "north", $overline(V)_(O' O)$)
  })
]

Applicando la legge di Kirchhoff delle tensioni e la legge di Ohm simbolica al generico circuito di fase $k$-esimo, si ricavano la tensione di fase sul carico $overline(E)'_k$ e la corrente di linea $overline(I)_k$:

$ overline(E)'_k = overline(E)_k - overline(V)_(O' O) $

$ overline(I)_k = overline(E)'_k / overline(Z)_k = (overline(E)_k - overline(V)_(O' O)) / overline(Z)_k, quad k = 1, 2, 3 $

=== Sistema Y-Y simmetrico ed equilibrato

// VERIFICA: dedotto dall'equazione (sviluppo di Millman con Z1=Z2=Z3=Z e somma delle E_k nulla)
Se il sistema di alimentazione è costituito da una terna simmetrica di generatori ($overline(E)_1 + overline(E)_2 + overline(E)_3 = 0$) e il sistema dei carichi è realizzato mediante una terna equilibrata ($overline(Z)_1 = overline(Z)_2 = overline(Z)_3 = overline(Z)$), la formula di Millman fornisce:

$ overline(V)_(O' O) = (display(sum_(k=1)^3 overline(E)_k / overline(Z))) / (display(sum_(k=1)^3 1 / overline(Z))) = (display(1 / overline(Z) sum_(k=1)^3 overline(E)_k)) / (display(3 / overline(Z))) = (overline(E)_1 + overline(E)_2 + overline(E)_3) / 3 = 0 $

#nota[
  *Proprietà fondamentali del sistema Y-Y simmetrico ed equilibrato*:
  1. Poiché $overline(V)_(O' O) = 0$, la tensione ai capi di ciascuna impedenza di carico coincide esattamente con la tensione impressa dal rispettivo generatore di fase:
     $ overline(E)'_k = overline(E)_k, quad k = 1, 2, 3 $
  2. Essendo $overline(V)_(O' O) = 0$, il centro stella $O'$ di qualsiasi carico equilibrato risulta *equipotenziale* rispetto al centro stella $O$ dei generatori.
]


=== Circuito monofase equivalente

Poiché in un sistema Y-Y simmetrico ed equilibrato i due centri stella $O$ e $O'$ si trovano allo stesso potenziale ($overline(V)_(O' O) = 0$), essi possono essere collegati tramite un cortocircuito ideale senza alterare il regime elettrico della rete. Di conseguenza, ciascun circuito di fase risulta disaccoppiato dagli altri due e può essere ridisegnato come un *circuito monofase equivalente* chiuso tra $O$ e $O'$:

#grid(
  columns: (1.25fr, 0.75fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #scale(x: 90%, y: 90%, reflow: true)[
      #zap.circuit({
        
        import zap.cetz.draw: *
        set-style(vsource: (variant: "iec"))

        let y = 0.0
        vsource("e1", (0, y), (3.6, y), position: 45%)
        wire((3.6, y), (5.0, y))
        resistor("z1", (5.0, y), (8.2, y), variant: "iec", position: 50%)

        node("O", (0, y), fill: false)
        node("m1", (3.6, y), fill: false)
        node("Op", (8.2, y), fill: false)

        content((-0.2, y), anchor: "east", $O$)
        content((3.6, y + 0.2), anchor: "south", sans("1", weight: "bold"))
        content((8.4, y), anchor: "west", $O'$)

        content((rel: (0, 0.55), to: "e1.center"), anchor: "south", $overline(E)_1$)
        content((rel: (0.48, 0.15), to: "e1.center"), anchor: "south", sans("+", weight: "bold"))

        line((4.05, y + 0.2), (4.75, y + 0.2), stroke: 0.85pt, mark: (end: "stealth", fill: black, scale: 1.1))
        content((4.4, y + 0.35), anchor: "south", $overline(I)_1$)

        content((rel: (0, -0.45), to: "z1.center"), anchor: "north", $overline(Z)_1$)
        bezier((7.1, y + 0.38), (6.1, y + 0.38), (6.6, y + 0.72), stroke: 0.75pt, mark: (end: "stealth", fill: black))
        content((6.6, y + 0.72), anchor: "south", $overline(E)'_1$)

        bezier((0, -0.45), (8.2, -0.45), (4.1, -1.45), stroke: 0.8pt, mark: (end: "stealth", fill: black))
        content((4.1, -1.2), anchor: "north", $overline(V)_(O' O)$)
      })
    ]
  ],
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(vsource: (variant: "iec"))

      vsource("e1", (0, 0), (0, 3.2), position: 45%)
      wire((0, 3.2), (3.4, 3.2))
      resistor("z", (3.4, 3.2), (3.4, 0), variant: "iec", position: 55%)
      wire((3.4, 0), (0, 0))

      node("OO", (1.7, 0))
      content((1.7, -0.22), anchor: "north", $O = O'$)

      content((rel: (-0.6, 0), to: "e1.center"), anchor: "east", $overline(E)_1$)
      content((rel: (-0.35, 0.55), to: "e1.center"), anchor: "south", sans("+", weight: "bold"))

      line((1.3, 3.4), (2.1, 3.4), stroke: 0.85pt, mark: (end: "stealth", fill: black, scale: 1.1))
      content((1.7, 3.55), anchor: "south", $overline(I)_1$)

      content((rel: (0.45, 0), to: "z.center"), anchor: "west", $overline(Z)$)
    })
  ]
)

// VERIFICA: dedotto dall'equazione (espressioni fasoriali delle tre correnti di linea per terna diretta e carico equilibrato Z = Z e^(j phi))
Applicando il medesimo circuito monofase equivalente a ciascuna delle tre fasi e ponendo $overline(Z) = Z e^(j varphi)$, si ricavano immediatamente le espressioni delle correnti di linea (nel caso di terna diretta delle tensioni):

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (left + horizon, center + horizon),
  [
    $ cases(
      overline(I)_1 = display(overline(E)_1 / overline(Z)) = display((E e^(j 0)) / (Z e^(j varphi))) = display(E / Z) e^(-j varphi),
      overline(I)_2 = display(overline(E)_2 / overline(Z)) = display((E e^(-j (2 pi) / 3)) / (Z e^(j varphi))) = display(E / Z) e^(j (- (2 pi) / 3 - varphi)),
      overline(I)_3 = display(overline(E)_3 / overline(Z)) = display((E e^(j (2 pi) / 3)) / (Z e^(j varphi))) = display(E / Z) e^(j ((2 pi) / 3 - varphi))
    ) $

    Se il carico connesso a stella è equilibrato, le correnti di linea formano anch'esse una *terna simmetrica* (sfasata di un angolo $varphi$ rispetto alla terna delle tensioni stellate), nella quale il valore efficace della corrente di linea è identico in tutte e tre le fasi e vale:
    $ I = E / Z $
  ],
  [
    #canvas({
      import draw: *
      let R_E = 2.8
      let R_I = 2.2
      let phi = 22deg
      let gcol = rgb("#777777")

      // Archi di sfasamento phi
      arc((0.9, 0), start: 0deg, stop: -phi, radius: 0.9, stroke: 0.75pt)
      content((1.15, -0.22), anchor: "west", $varphi$)

      arc((0.9 * calc.cos(-120deg), 0.9 * calc.sin(-120deg)), start: -120deg, stop: -120deg - phi, radius: 0.9, stroke: 0.75pt)
      content((-0.65, -0.95), anchor: "east", $varphi$)

      arc((0.9 * calc.cos(120deg), 0.9 * calc.sin(120deg)), start: 120deg, stop: 120deg - phi, radius: 0.9, stroke: 0.75pt)
      content((-0.35, 1.15), anchor: "east", $varphi$)

      // Fasori tensione (nero)
      line((0, 0), (R_E, 0), stroke: (paint: black, thickness: 1.8pt), mark: (end: "stealth", fill: black, scale: 1.1))
      line((0, 0), (R_E * calc.cos(-120deg), R_E * calc.sin(-120deg)), stroke: (paint: black, thickness: 1.8pt), mark: (end: "stealth", fill: black, scale: 1.1))
      line((0, 0), (R_E * calc.cos(120deg), R_E * calc.sin(120deg)), stroke: (paint: black, thickness: 1.8pt), mark: (end: "stealth", fill: black, scale: 1.1))

      // Fasori corrente (grigio)
      line((0, 0), (R_I * calc.cos(-phi), R_I * calc.sin(-phi)), stroke: (paint: gcol, thickness: 1.6pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line((0, 0), (R_I * calc.cos(-120deg - phi), R_I * calc.sin(-120deg - phi)), stroke: (paint: gcol, thickness: 1.6pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line((0, 0), (R_I * calc.cos(120deg - phi), R_I * calc.sin(120deg - phi)), stroke: (paint: gcol, thickness: 1.6pt), mark: (end: "stealth", fill: gcol, scale: 1.1))

      content((R_E - 0.2, 0.2), anchor: "south", $overline(E)_1$)
      content((R_E * calc.cos(-120deg) - 0.15, R_E * calc.sin(-120deg) + 0.1), anchor: "east", $overline(E)_2$)
      content((R_E * calc.cos(120deg) - 0.15, R_E * calc.sin(120deg) + 0.1), anchor: "south", $overline(E)_3$)

      content((R_I * calc.cos(-phi) + 0.1, R_I * calc.sin(-phi) + 0.15), anchor: "south", text(fill: gcol)[$overline(I)_1$])
      content((R_I * calc.cos(-120deg - phi) - 0.1, R_I * calc.sin(-120deg - phi) + 0.2), anchor: "south", text(fill: gcol)[$overline(I)_2$])
      content((R_I * calc.cos(120deg - phi) - 0.1, R_I * calc.sin(120deg - phi) + 0.15), anchor: "south", text(fill: gcol)[$overline(I)_3$])
    })
  ]
)

=== Più carichi equilibrati connessi a stella in parallelo

La proprietà di equipotenzialità dei centri stella si estende a un numero arbitrario di carichi equilibrati collegati alla medesima linea trifase. Se due carichi a stella equilibrati di impedenze $overline(Z)_A$ e $overline(Z)_B$ hanno centri stella $O_A$ e $O_B$, i nodi $O$, $O_A$ e $O_B$ si trovano tutti allo stesso potenziale e possono essere cortocircuitati nel circuito monofase equivalente:

#align(center)[
  #scale(x: 90%, y: 90%, reflow: true)[
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(vsource: (variant: "iec"))

      // Schema trifase completo in alto
      let y1 = 4.0
      let y2 = 2.8
      let y3 = 1.6

      wire((0, y3), (0, y1))
      node("O", (0, y2))
      content((-0.2, y2), anchor: "east", $O$)

      vsource("e1", (0, y1), (2.4, y1), position: 50%)
      vsource("e2", (0, y2), (2.4, y2), position: 50%)
      vsource("e3", (0, y3), (2.4, y3), position: 50%)

      content((rel: (0, 0.5), to: "e1.center"), anchor: "south", $overline(E)_1$)
      content((rel: (0.45, 0.15), to: "e1.center"), anchor: "south", sans("+", weight: "bold"))
      content((rel: (0, 0.5), to: "e2.center"), anchor: "south", $overline(E)_2$)
      content((rel: (0.45, 0.15), to: "e2.center"), anchor: "south", sans("+", weight: "bold"))
      content((rel: (0, 0.5), to: "e3.center"), anchor: "south", $overline(E)_3$)
      content((rel: (0.45, 0.15), to: "e3.center"), anchor: "south", sans("+", weight: "bold"))

      wire((2.4, y1), (6.4, y1))
      wire((2.4, y2), (6.4, y2))
      wire((2.4, y3), (6.4, y3))

      resistor("za1", (6.4, y1), (8.8, y1), variant: "iec")
      resistor("za2", (6.4, y2), (8.8, y2), variant: "iec")
      resistor("za3", (6.4, y3), (8.8, y3), variant: "iec")

      wire((8.8, y3), (8.8, y1))
      node("OA", (8.8, y2))
      content((9.0, y2), anchor: "west", $O_A$)

      content((rel: (0, 0.4), to: "za1.center"), anchor: "south", $overline(Z)_A$)
      content((rel: (0, 0.4), to: "za2.center"), anchor: "south", $overline(Z)_A$)
      content((rel: (0, 0.4), to: "za3.center"), anchor: "south", $overline(Z)_A$)

      // Derivazioni verticali verso il secondo carico a stella Z_B
      let xb1 = 3.5
      let xb2 = 4.8
      let xb3 = 6.1

      node("n1", (xb1, y1))
      node("n2", (xb2, y2))
      node("n3", (xb3, y3))

      content((xb1 + 0.15, y1 + 0.15), anchor: "south", sans("1", weight: "bold"))
      content((xb2 + 0.15, y2 + 0.15), anchor: "south", sans("2", weight: "bold"))
      content((xb3 + 0.15, y3 + 0.15), anchor: "south", sans("3", weight: "bold"))

      wire((xb1, y1), (xb1, 0.8))
      wire((xb2, y2), (xb2, 0.8))
      wire((xb3, y3), (xb3, 0.8))

      resistor("zb1", (xb1, 0.8), (xb1, -0.8), variant: "iec")
      resistor("zb2", (xb2, 0.8), (xb2, -0.8), variant: "iec")
      resistor("zb3", (xb3, 0.8), (xb3, -0.8), variant: "iec")

      wire((xb1, -0.8), (xb3, -0.8))
      node("OB", (xb2, -0.8))
      content((xb2, -1.05), anchor: "north", $O_B$)

      content((rel: (-0.35, 0), to: "zb1.center"), anchor: "east", $overline(Z)_B$)
      content((rel: (-0.35, 0), to: "zb2.center"), anchor: "east", $overline(Z)_B$)
      content((rel: (-0.35, 0), to: "zb3.center"), anchor: "east", $overline(Z)_B$)

      // Circuito equivalente monofase in basso
      let y_bot = -4.8
      let y_top = -2.2
      let x_left = 2.4
      let x_mid = 4.6
      let x_right = 7.0

      vsource("e1_eq", (x_left, y_bot), (x_left, y_top), position: 45%)
      wire((x_left, y_top), (x_mid, y_top))
      resistor("za_eq", (x_mid, y_top), (x_right, y_top), variant: "iec")
      wire((x_right, y_top), (x_right, y_bot))
      wire((x_left, y_bot), (x_right, y_bot))
      resistor("zb_eq", (x_mid, y_top), (x_mid, y_bot), variant: "iec")

      node("nt_eq", (x_mid, y_top))
      node("nb_eq", (x_mid, y_bot))

      content((rel: (0.55, 0), to: "e1_eq.center"), anchor: "west", $overline(E)_1$)
      content((rel: (-0.35, 0.55), to: "e1_eq.center"), anchor: "south", sans("+", weight: "bold"))
      content((rel: (0, 0.42), to: "za_eq.center"), anchor: "south", $overline(Z)_A$)
      content((rel: (0.42, 0), to: "zb_eq.center"), anchor: "west", $overline(Z)_B$)

      content((x_left, y_bot - 0.2), anchor: "north", $O$)
      content((x_mid, y_bot - 0.2), anchor: "north", $O_A$)
      content((x_right, y_bot - 0.2), anchor: "north", $O_B$)
    })
  ]
]

=== Il circuito stella-triangolo (Y-$Delta$)

Consideriamo un sistema trifase di generatori connessi a stella che alimenta un carico connesso a triangolo ($Delta$). Nella configurazione a triangolo, ciascuna impedenza di carico è collegata direttamente tra due morsetti di linea ed è pertanto sottoposta alla corrispondente *tensione concatenata* ($overline(V)_(1 2), overline(V)_(2 3), overline(V)_(3 1)$).

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *
    set-style(vsource: (variant: "iec"))

    let y1 = 4.4
    let y2 = 2.2
    let y3 = 0.0

    wire((0, y3), (0, y1))
    node("O", (0, y2))
    content((-0.25, y2), anchor: "east", $O$)

    vsource("e1", (0, y1), (3.4, y1), position: 45%)
    vsource("e2", (0, y2), (3.4, y2), position: 45%)
    vsource("e3", (0, y3), (3.4, y3), position: 45%)

    content((rel: (0, 0.55), to: "e1.center"), anchor: "south", $overline(E)_1$)
    content((rel: (0.48, 0.15), to: "e1.center"), anchor: "south", sans("+", weight: "bold"))
    content((rel: (0, 0.55), to: "e2.center"), anchor: "south", $overline(E)_2$)
    content((rel: (0.48, 0.15), to: "e2.center"), anchor: "south", sans("+", weight: "bold"))
    content((rel: (0, 0.55), to: "e3.center"), anchor: "south", $overline(E)_3$)
    content((rel: (0.48, 0.15), to: "e3.center"), anchor: "south", sans("+", weight: "bold"))

    wire((3.4, y1), (8.4, y1))
    wire((3.4, y2), (6.0, y2))
    wire((3.4, y3), (8.4, y3))

    node("m1", (3.4, y1), fill: false)
    node("m2", (3.4, y2), fill: false)
    node("m3", (3.4, y3), fill: false)

    content((3.4, y1 + 0.2), anchor: "south", sans("1", weight: "bold"))
    content((3.4, y2 + 0.2), anchor: "south", sans("2", weight: "bold"))
    content((3.4, y3 + 0.2), anchor: "south", sans("3", weight: "bold"))

    // Frecce correnti di linea
    line((4.3, y1 + 0.2), (4.9, y1 + 0.2), stroke: 0.85pt, mark: (end: "stealth", fill: black, scale: 1.1))
    content((4.6, y1 + 0.35), anchor: "south", $overline(I)_1$)

    line((4.3, y2 + 0.2), (4.9, y2 + 0.2), stroke: 0.85pt, mark: (end: "stealth", fill: black, scale: 1.1))
    content((4.6, y2 + 0.35), anchor: "south", $overline(I)_2$)

    line((4.3, y3 + 0.2), (4.9, y3 + 0.2), stroke: 0.85pt, mark: (end: "stealth", fill: black, scale: 1.1))
    content((4.6, y3 + 0.35), anchor: "south", $overline(I)_3$)

    // Rami del triangolo
    resistor("z1", (6.0, y1), (6.0, y2), variant: "iec", position: 58%)
    resistor("z2", (6.0, y2), (6.0, y3), variant: "iec", position: 42%)
    resistor("z3", (8.4, y1), (8.4, y3), variant: "iec", position: 50%)

    node("d1", (6.0, y1))
    node("d2", (6.0, y2))
    node("d3", (6.0, y3))

    // Etichette impedenze a sinistra dei rami verticali
    content((rel: (-0.38, 0), to: "z1.center"), anchor: "east", $overline(Z)_1$)
    content((rel: (-0.38, 0), to: "z2.center"), anchor: "east", $overline(Z)_2$)
    content((rel: (-0.38, 0), to: "z3.center"), anchor: "east", $overline(Z)_3$)

    // Frecce tensioni concatenate a destra dei bipoli
    bezier((6.38, y2 + 0.45), (6.38, y1 - 0.75), (6.65, (y1 + y2) / 2 - 0.15), stroke: 0.75pt, mark: (end: "stealth", fill: black))
    content((6.65, (y1 + y2) / 2 - 0.15), anchor: "west", $overline(V)_(1 2)$)

    bezier((6.38, y3 + 0.75), (6.38, y2 - 0.45), (6.65, (y2 + y3) / 2 + 0.15), stroke: 0.75pt, mark: (end: "stealth", fill: black))
    content((6.65, (y2 + y3) / 2 + 0.15), anchor: "west", $overline(V)_(2 3)$)

    bezier((8.78, y2 + 0.5), (8.78, y2 - 0.5), (9.05, y2), stroke: 0.75pt, mark: (end: "stealth", fill: black))
    content((9.05, y2), anchor: "west", $overline(V)_(3 1)$)

    // Frecce correnti di fase
    line((6.2, y1 - 0.15), (6.2, y1 - 0.6), stroke: 0.8pt, mark: (end: "stealth", fill: black))
    content((6.35, y1 - 0.38), anchor: "west", $overline(I)_(1 2)$)

    line((6.2, y3 + 0.6), (6.2, y3 + 0.15), stroke: 0.8pt, mark: (end: "stealth", fill: black))
    content((6.35, y3 + 0.38), anchor: "west", $overline(I)_(2 3)$)

    line((8.6, y1 - 1.15), (8.6, y1 - 0.7), stroke: 0.8pt, mark: (end: "stealth", fill: black))
    content((8.75, y1 - 0.92), anchor: "west", $overline(I)_(3 1)$)
  })
]

// VERIFICA: dedotto dall'equazione (legge di Ohm sui tre lati del triangolo e LKC ai tre nodi)
Le tre correnti $overline(I)_(1 2), overline(I)_(2 3), overline(I)_(3 1)$ che circolano all'interno dei lati del triangolo sono dette *correnti di fase* (di triangolo) e si determinano direttamente tramite la legge di Ohm simbolica:

$ overline(I)_(1 2) = overline(V)_(1 2) / overline(Z)_1, quad overline(I)_(2 3) = overline(V)_(2 3) / overline(Z)_2, quad overline(I)_(3 1) = overline(V)_(3 1) / overline(Z)_3 $

Applicando la legge di Kirchhoff delle correnti (LKC) ai tre nodi del triangolo, si ottengono le *correnti di linea* $overline(I)_1, overline(I)_2, overline(I)_3$ in funzione delle correnti di fase:

$ cases(
  overline(I)_1 = overline(I)_(1 2) - overline(I)_(3 1),
  overline(I)_2 = overline(I)_(2 3) - overline(I)_(1 2),
  overline(I)_3 = overline(I)_(3 1) - overline(I)_(2 3)
) $

=== Sistema Y-$Delta$ simmetrico ed equilibrato

// VERIFICA: dedotto dall'equazione (espressioni di I_12, I_23, I_31 con carico equilibrato Z = Z e^(j phi) e relazione I_linea = sqrt(3) I_fase)
Se il carico a triangolo è equilibrato ($overline(Z)_1 = overline(Z)_2 = overline(Z)_3 = overline(Z) = Z e^(j varphi)$) ed è alimentato da una terna simmetrica di tensioni concatenate di valore efficace $V$, le tre correnti di fase costituiscono una terna simmetrica avente valore efficace $I_"fase" = V / Z$:

$ cases(
  overline(I)_(1 2) = display(overline(V)_(1 2) / overline(Z)) = display((V e^(j varphi_(V_(1 2)))) / (Z e^(j varphi))) = display(V / Z) e^(j (varphi_(V_(1 2)) - varphi)),
  overline(I)_(2 3) = display(overline(V)_(2 3) / overline(Z)) = display((V e^(j varphi_(V_(2 3)))) / (Z e^(j varphi))) = display(V / Z) e^(j (varphi_(V_(2 3)) - varphi)),
  overline(I)_(3 1) = display(overline(V)_(3 1) / overline(Z)) = display((V e^(j varphi_(V_(3 1)))) / (Z e^(j varphi))) = display(V / Z) e^(j (varphi_(V_(3 1)) - varphi))
) $

#grid(
  columns: (1.1fr, 0.9fr),
  column-gutter: 1.5em,
  align: (center + horizon, left + horizon),
  [
    #canvas({
      import draw: *
      let R_V = 3.1
      let R_If = 2.1
      let gcol = rgb("#777777")

      // Tensioni concatenate a +30, -90, +150 gradi
      let aV12 = 30deg
      let aV23 = -90deg
      let aV31 = 150deg

      // Correnti di fase sfasate di phi = 30 gradi (quindi a 0, -120, +120 gradi)
      let aI12 = 0deg
      let aI23 = -120deg
      let aI31 = 120deg

      let p0 = (0, 0)
      let pI12 = (R_If * calc.cos(aI12), R_If * calc.sin(aI12))
      let pI23 = (R_If * calc.cos(aI23), R_If * calc.sin(aI23))
      let pI31 = (R_If * calc.cos(aI31), R_If * calc.sin(aI31))

      // Archi angolo phi
      arc((0.75, 0), start: 0deg, stop: 30deg, radius: 0.75, stroke: 0.75pt)
      content((0.85, 0.25), anchor: "west", $varphi$)

      arc((0, -0.75), start: -90deg, stop: -120deg, radius: 0.75, stroke: 0.75pt)
      content((-0.2, -0.95), anchor: "north", $varphi$)

      arc((0.75 * calc.cos(120deg), 0.75 * calc.sin(120deg)), start: 120deg, stop: 150deg, radius: 0.75, stroke: 0.75pt)
      content((-0.55, 0.7), anchor: "east", $varphi$)

      // Fasori V_12, V_23, V_31 (nero)
      line(p0, (R_V * calc.cos(aV12), R_V * calc.sin(aV12)), stroke: (paint: black, thickness: 1.8pt), mark: (end: "stealth", fill: black, scale: 1.1))
      line(p0, (R_V * calc.cos(aV23), R_V * calc.sin(aV23)), stroke: (paint: black, thickness: 1.8pt), mark: (end: "stealth", fill: black, scale: 1.1))
      line(p0, (R_V * calc.cos(aV31), R_V * calc.sin(aV31)), stroke: (paint: black, thickness: 1.8pt), mark: (end: "stealth", fill: black, scale: 1.1))

      // Fasori I_12, I_23, I_31 (grigio scuro)
      line(p0, pI12, stroke: (paint: gcol, thickness: 1.6pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line(p0, pI23, stroke: (paint: gcol, thickness: 1.6pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line(p0, pI31, stroke: (paint: gcol, thickness: 1.6pt), mark: (end: "stealth", fill: gcol, scale: 1.1))

      // Triangolo delle correnti di linea I_1, I_2, I_3
      line(pI31, pI12, stroke: (paint: gcol, thickness: 1.6pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line(pI12, pI23, stroke: (paint: gcol, thickness: 1.6pt), mark: (end: "stealth", fill: gcol, scale: 1.1))
      line(pI23, pI31, stroke: (paint: gcol, thickness: 1.6pt), mark: (end: "stealth", fill: gcol, scale: 1.1))

      content((R_V * calc.cos(aV12) + 0.1, R_V * calc.sin(aV12) - 0.25), anchor: "west", $overline(V)_(1 2)$)
      content((0.2, -R_V + 0.15), anchor: "west", $overline(V)_(2 3)$)
      content((R_V * calc.cos(aV31) - 0.1, R_V * calc.sin(aV31) - 0.25), anchor: "east", $overline(V)_(3 1)$)

      content((1.2, -0.22), anchor: "north", text(fill: gcol)[$overline(I)_(1 2)$])
      content((-0.45, -0.7), anchor: "east", text(fill: gcol)[$overline(I)_(2 3)$])
      content((-0.1, 1.25), anchor: "east", text(fill: gcol)[$overline(I)_(3 1)$])

      content((1.75, 0.55), anchor: "west", text(fill: gcol)[$overline(I)_1$])
      content((-0.35, -1.85), anchor: "west", text(fill: gcol)[$overline(I)_2$])
      content((-1.15, 1.55), anchor: "east", text(fill: gcol)[$overline(I)_3$])
    })
  ],
  [
    Per dualità geometrica rispetto alle tensioni concatenate in un collegamento a stella, i fasori delle correnti di linea ($overline(I)_1 = overline(I)_(1 2) - overline(I)_(3 1)$, ecc.) formano un triangolo equilatero circoscritto alla stella delle correnti di fase.

    #nota[
      In un carico a triangolo equilibrato, il valore efficace della corrente di linea è legato al valore efficace della corrente di fase dalla relazione:
      $ I_"linea" = sqrt(3) I_"fase" = sqrt(3) V / Z $
    ]
  ]
)

== Potenza nei sistemi trifase

=== Potenza in un generico tripolo

Grazie al *teorema di Boucherot*, in un generico tripolo (anche non equilibrato) la potenza complessa complessiva $overline(S)$ richiesta ai generatori si esprime come la somma delle potenze complesse assorbite dalle singole fasi del tripolo stesso.

#grid(
  columns: (0.9fr, 1.1fr),
  column-gutter: 1.5em,
  align: (center + horizon, left + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *

      rect((0, 0.5), (1.2, 4.1), stroke: 1.2pt)
      wire((1.2, 3.6), (2.2, 3.6))
      wire((1.2, 2.3), (2.2, 2.3))
      wire((1.2, 1.0), (2.2, 1.0))

      node("m1", (2.2, 3.6), fill: false)
      node("m2", (2.2, 2.3), fill: false)
      node("m3", (2.2, 1.0), fill: false)

      content((2.2, 3.78), anchor: "south", sans("1", weight: "bold"))
      content((2.2, 2.48), anchor: "south", sans("2", weight: "bold"))
      content((2.2, 1.18), anchor: "south", sans("3", weight: "bold"))

      // Nodo O in basso
      circle((4.1, -0.8), radius: 0.07, fill: black)
      content((4.1, -0.95), anchor: "north", sans("O", weight: "bold"))

      // Archi tensioni E_1, E_2, E_3 dal nodo O ai morsetti 1, 2, 3
      bezier((4.25, -0.65), (2.5, 3.5), (5.2, 1.2), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((4.1, 1.9), anchor: "east", $overline(E)_1$)

      bezier((4.05, -0.6), (2.5, 2.2), (3.8, 0.8), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((3.4, 0.9), anchor: "east", $overline(E)_2$)

      bezier((3.85, -0.65), (2.45, 0.8), (3.0, -0.1), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((3.0, -0.35), anchor: "east", $overline(E)_3$)

      // Frecce correnti I_1, I_2, I_3
      line((5.4, 3.6), (4.7, 3.6), stroke: 0.9pt, mark: (end: "stealth", fill: black, scale: 1.1))
      content((5.2, 3.75), anchor: "south", $overline(I)_1$)

      line((5.4, 2.3), (4.7, 2.3), stroke: 0.9pt, mark: (end: "stealth", fill: black, scale: 1.1))
      content((5.2, 2.45), anchor: "south", $overline(I)_2$)

      line((5.4, 1.0), (4.7, 1.0), stroke: 0.9pt, mark: (end: "stealth", fill: black, scale: 1.1))
      content((5.2, 1.15), anchor: "south", $overline(I)_3$)

      // Freccia ondulata potenza complessa S
      line((7.2, 1.8), (6.9, 2.0), (6.6, 1.85), (6.2, 2.15), stroke: 1.2pt, mark: (end: "stealth", fill: black))
      content((7.4, 2.15), anchor: "west", $overline(S)$)
    })
  ],
  [
    // VERIFICA: dedotto dall'equazione (dimostrazione dell'invarianza della potenza complessa rispetto al centro stella O)
    Indicando con $overline(E)'_k$ le tensioni ai capi delle singole fasi del tripolo (in generale squilibrato, con centro stella $O'$):
    $ overline(S) = sum_(k=1)^3 overline(E)'_k overline(I)_k^* = overline(E)'_1 overline(I)_1^* + overline(E)'_2 overline(I)_2^* + overline(E)'_3 overline(I)_3^* $
    Esprimendo ciascuna tensione come $overline(E)'_k = overline(E)_k - overline(V)_(O' O)$ rispetto al centro stella $O$ dei generatori (o a un qualunque nodo di riferimento arbitrario $O$), si ottiene:
    $ overline(S) &= (overline(E)_1 - overline(V)_(O' O)) overline(I)_1^* + (overline(E)_2 - overline(V)_(O' O)) overline(I)_2^* + (overline(E)_3 - overline(V)_(O' O)) overline(I)_3^* \
      &= sum_(k=1)^3 overline(E)_k overline(I)_k^* - overline(V)_(O' O) sum_(k=1)^3 overline(I)_k^* $
  ]
)

Poiché in un tripolo a tre fili la terna delle correnti di linea è necessariamente pura per la legge di Kirchhoff delle correnti ($sum_(k=1)^3 overline(I)_k = 0 arrow sum_(k=1)^3 overline(I)_k^* = 0$), il termine moltiplicato per $overline(V)_(O' O)$ si annulla identicamente:

$ overline(S) = sum_(k=1)^3 overline(E)_k overline(I)_k^* = sum_(k=1)^3 E_k I_k cos varphi_k + j sum_(k=1)^3 E_k I_k sin varphi_k = P + j Q $

=== Potenza in un carico trifase equilibrato (a stella e a triangolo)

Nel caso di un *carico trifase equilibrato*, le espressioni della potenza attiva $P$, reattiva $Q$, complessa $overline(S)$ e apparente $S$ si semplificano notevolmente e assumono la medesima forma in funzione dei valori efficaci delle grandezze di linea $V$ (tensione concatenata) e $I$ (corrente di linea), indipendentemente dal fatto che il carico sia connesso a stella o a triangolo.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 2em,
  align: (center + top, center + top),
  [
    *Carico equilibrato connesso a stella (Y)*
    #v(0.4em)
    #zap.circuit({
      
      import zap.cetz.draw: *

      resistor("zy1", (0, 3.2), (3.4, 3.2), variant: "iec")
      resistor("zy2", (0, 1.8), (3.4, 1.8), variant: "iec")
      resistor("zy3", (0, 0.4), (3.4, 0.4), variant: "iec")

      wire((3.4, 0.4), (3.4, 3.2))
      node("Oy", (3.4, 1.8))

      node("m1", (0, 3.2), fill: false)
      node("m2", (0, 1.8), fill: false)
      node("m3", (0, 0.4), fill: false)

      content((-0.2, 3.2), anchor: "east", sans("1", weight: "bold"))
      content((-0.2, 1.8), anchor: "east", sans("2", weight: "bold"))
      content((-0.2, 0.4), anchor: "east", sans("3", weight: "bold"))

      content((rel: (0, 0.45), to: "zy1.center"), anchor: "south", $overline(Z)_Y$)
      content((rel: (0, 0.45), to: "zy2.center"), anchor: "south", $overline(Z)_Y$)
      content((rel: (0, 0.45), to: "zy3.center"), anchor: "south", $overline(Z)_Y$)

      line((0.55, 0.0), (0.55, 3.6), stroke: (dash: "dashed", thickness: 0.8pt))
      line((0.15, 0.1), (0.35, 0.22), (0.55, 0.05), (0.95, 0.15), stroke: 1.2pt, mark: (end: "stealth", fill: black))
      content((0.55, -0.1), anchor: "north", $P, Q$)
    })
  ],
  [
    *Carico equilibrato connesso a triangolo ($Delta$)*
    #v(0.4em)
    #zap.circuit({
      
      import zap.cetz.draw: *

      wire((0, 3.4), (3.4, 3.4))
      wire((0, 1.8), (1.6, 1.8))
      wire((0, 0.2), (3.4, 0.2))

      resistor("zd1", (1.6, 3.4), (1.6, 1.8), variant: "iec")
      resistor("zd2", (1.6, 1.8), (1.6, 0.2), variant: "iec")
      resistor("zd3", (3.4, 3.4), (3.4, 0.2), variant: "iec")

      node("d1", (1.6, 3.4))
      node("d2", (1.6, 1.8))
      node("d3", (1.6, 0.2))

      node("m1", (0, 3.4), fill: false)
      node("m2", (0, 1.8), fill: false)
      node("m3", (0, 0.2), fill: false)

      content((0, 3.6), anchor: "south", sans("1", weight: "bold"))
      content((0, 2.0), anchor: "south", sans("2", weight: "bold"))
      content((0, 0.4), anchor: "south", sans("3", weight: "bold"))

      content((rel: (0.42, 0), to: "zd1.center"), anchor: "west", $overline(Z)_Delta$)
      content((rel: (0.42, 0), to: "zd2.center"), anchor: "west", $overline(Z)_Delta$)
      content((rel: (0.42, 0), to: "zd3.center"), anchor: "west", $overline(Z)_Delta$)

      line((1.22, 3.0), (1.22, 2.2), stroke: 0.85pt, mark: (end: "stealth", fill: black))
      content((1.12, 2.6), anchor: "east", $I_f$)

      line((0.55, -0.1), (0.55, 3.7), stroke: (dash: "dashed", thickness: 0.8pt))
      line((0.15, -0.05), (0.35, 0.08), (0.55, -0.08), (0.95, 0.02), stroke: 1.2pt, mark: (end: "stealth", fill: black))
      content((0.55, -0.22), anchor: "north", $P, Q$)
    })
  ]
)

// VERIFICA: dedotto dall'equazione (sviluppo di P, Q, S per carico equilibrato a Y con E = V/sqrt(3) e a Delta con I_f = I/sqrt(3))
- *Connessione a stella (Y)*: ciascuna impedenza $overline(Z)_Y$ è sottoposta alla tensione di fase $E = V / sqrt(3)$ ed è percorsa dalla corrente di linea $I$, con fattore di potenza $cos varphi$ uguale per tutte le fasi:
  $ P = P_1 + P_2 + P_3 = 3 E I cos varphi = 3 V / sqrt(3) I cos varphi = sqrt(3) V I cos varphi $
  $ Q = Q_1 + Q_2 + Q_3 = 3 E I sin varphi = 3 V / sqrt(3) I sin varphi = sqrt(3) V I sin varphi $

- *Connessione a triangolo ($Delta$)*: ciascuna impedenza $overline(Z)_Delta$ è sottoposta alla tensione concatenata $V$ ed è percorsa dalla corrente di fase $I_f = I / sqrt(3)$:
  $ P = 3 V I_f cos varphi = 3 V I / sqrt(3) cos varphi = sqrt(3) V I cos varphi $
  $ Q = 3 V I_f sin varphi = 3 V I / sqrt(3) sin varphi = sqrt(3) V I sin varphi $

#nota[
  *Potenza complessa e potenza apparente in un sistema trifase equilibrato*:
  In qualunque sistema trifase simmetrico ed equilibrato (sia esso connesso a stella o a triangolo), la potenza complessa e la potenza apparente in funzione dei valori efficaci di linea $V$ e $I$ valgono:
  $ overline(S) = overline(S)_1 + overline(S)_2 + overline(S)_3 = sqrt(3) V I cos varphi + j sqrt(3) V I sin varphi = P + j Q $
  $ S = abs(overline(S)) = sqrt(P^2 + Q^2) = sqrt(3) V I $
]

== Vantaggi del sistema trifase e uso del neutro

L'impiego generalizzato del sistema trifase negli impianti industriali e nella trasmissione dell'energia elettrica è motivato da tre vantaggi fisici e tecnologici fondamentali:
1. *Maggiore efficienza nella trasmissione di potenza su linea* (risparmio di materiale conduttore a parità di potenza trasmessa e perdite per effetto Joule).
2. *Componente attiva della potenza istantanea costante nel tempo*.
3. *Utilizzo efficace nei sistemi elettromeccanici* (generazione diretta del campo magnetico rotante nelle macchine elettriche).

=== Confronto tra linea di trasmissione monofase e trifase

Confrontiamo una linea di trasmissione monofase (a 2 conduttori di sezione $S_"m"$ e resistenza $R_"m"$) e una linea di trasmissione trifase (a 3 conduttori di sezione $S_"t"$ e resistenza $R_"t"$), a parità di lunghezza della linea $l$, resistività del materiale conduttore $rho$, tensione di linea $V$, potenza attiva $P$ e fattore di potenza $cos varphi$ richiesti dal carico:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 2em,
  align: (center + horizon, center + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(resistor: (variant: "ieee"))

      resistor("rm1", (0, 2.4), (3.0, 2.4))
      resistor("rm2", (0, 0.6), (3.0, 0.6))
      rect((3.0, 0.0), (4.5, 3.0), stroke: 1.2pt)
      content((3.75, 1.5), $P$)

      node("m1", (0, 2.4), fill: false)
      node("m2", (0, 0.6), fill: false)

      line((-0.8, 2.4), (-0.25, 2.4), stroke: 0.9pt, mark: (end: "stealth", fill: black, scale: 1.1))
      content((-0.5, 2.55), anchor: "south", $I_"m"$)

      content((rel: (0, 0.45), to: "rm1.center"), anchor: "south", $R_"m"$)
      content((rel: (0, 0.45), to: "rm2.center"), anchor: "south", $R_"m"$)

      bezier((2.8, 0.85), (2.8, 2.15), (2.45, 1.5), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((2.5, 1.5), anchor: "east", $V$)
    })
    *Linea monofase*
  ],
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(resistor: (variant: "ieee"))

      resistor("rt1", (0, 3.0), (3.0, 3.0))
      resistor("rt2", (0, 1.8), (3.0, 1.8))
      resistor("rt3", (0, 0.6), (3.0, 0.6))
      rect((3.0, 0.0), (4.6, 3.6), stroke: 1.2pt)
      content((3.8, 1.8), align(center)[$P$\ $cos varphi$])

      node("t1", (0, 3.0), fill: false)
      node("t2", (0, 1.8), fill: false)
      node("t3", (0, 0.6), fill: false)

      line((-0.8, 3.0), (-0.25, 3.0), stroke: 0.9pt, mark: (end: "stealth", fill: black, scale: 1.1))
      content((-0.5, 3.15), anchor: "south", $I_"t"$)

      content((rel: (0, 0.42), to: "rt1.center"), anchor: "south", $R_"t"$)
      content((rel: (0, 0.42), to: "rt2.center"), anchor: "south", $R_"t"$)
      content((rel: (0, 0.42), to: "rt3.center"), anchor: "south", $overline(R)_"t"$)

      bezier((2.8, 1.95), (2.8, 2.85), (2.5, 2.4), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((2.55, 2.4), anchor: "east", $V$)
    })
    *Linea trifase*
  ]
)

// VERIFICA: dedotto dall'equazione (correnti di linea I_m e I_t, seconda legge di Ohm per R_m e R_t, e bilancio delle perdite Joule)
Le correnti di linea nei due sistemi e le resistenze di ciascun conduttore di lunghezza $l$ valgono rispettivamente:

$ I_"m" = P / (V cos varphi), quad R_"m" = rho l / S_"m" $

$ I_"t" = P / (sqrt(3) V cos varphi), quad R_"t" = rho l / S_"t" $

Imponendo che le due linee presentino il medesimo valore complessivo di perdite per effetto Joule ($P_(J, "m") = P_(J, "t")$), si ottiene:

$ P_(J, "m") = P_(J, "t") arrow.r.double 2 R_"m" I_"m"^2 = 3 R_"t" I_"t"^2 arrow.r.double 2 R_"m" (P / (V cos varphi))^2 = 3 R_"t" (P / (sqrt(3) V cos varphi))^2 $

Semplificando i termini comuni si ricava la relazione tra le resistenze e tra le sezioni dei conduttori:

$ 2 R_"m" = R_"t" arrow.r.double 2 rho l / S_"m" = rho l / S_"t" arrow.r.double S_"m" = 2 S_"t" $

Valutando infine il rapporto tra il volume totale di materiale conduttore richiesto dalla linea trifase ($"Vol"_"t" = 3 S_"t" l$) e quello richiesto dalla linea monofase ($"Vol"_"m" = 2 S_"m" l$):

$ "Vol"_"t" / "Vol"_"m" = (3 S_"t" l) / (2 S_"m" l) = (3 S_"t") / (4 S_"t") = 3 / 4 = 0.75 $

A parità di potenza trasmessa e perdite di linea, la trasmissione trifase a tre fili comporta dunque un *risparmio del $25%$ di materiale conduttore* rispetto alla trasmissione monofase.

=== Componente attiva della potenza istantanea

In un sistema trifase simmetrico ed equilibrato, le tre componenti attive della potenza istantanea assorbita dalle singole fasi danno luogo a una somma istantanea costante nel tempo. Infatti, i tre termini oscillanti a pulsazione doppia ($2 omega$) formano una terna simmetrica a risultante nulla, per cui la potenza attiva istantanea totale coincide in ogni istante con la potenza attiva media $P$:

$ p_a (t) = 3 E I cos varphi = sqrt(3) V I cos varphi = P = "costante" $

=== Sistema trifase a quattro fili (con conduttore di neutro)

Qualora il sistema di carichi connesso a stella sia *squilibrato* ($overline(Z)_1, overline(Z)_2, overline(Z)_3$ diverse tra loro, come avviene tipicamente nella distribuzione in bassa tensione a utenze monofase), si instaura una differenza di potenziale non nulla tra i centri stella ($overline(V)_(O' O) != 0$), provocando indesiderate variazioni delle tensioni sulle singole fasi di carico.

Per ovviare a tale fenomeno si aggiunge un *quarto conduttore*, detto *conduttore di neutro*, che collega direttamente il centro stella dei generatori $O$ al centro stella del carico $O'$:

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *
    set-style(vsource: (variant: "iec"))

    let y1 = 4.4
    let y2 = 2.8
    let y3 = 1.2
    let yN = -0.2

    wire((0, yN), (0, y1))
    wire((8.6, yN), (8.6, y1))
    wire((0, yN), (8.6, yN))

    node("O", (0, y2))
    node("On3", (0, y3))
    node("Op", (8.6, y2))
    node("Op3", (8.6, y3))

    content((-0.25, y2), anchor: "east", $O$)
    content((8.85, y2), anchor: "west", $O'$)

    let y_levels = (y1, y2, y3)
    for idx in range(3) {
      let y = y_levels.at(idx)
      let k = str(idx + 1)

      vsource("e" + k, (0, y), (3.8, y), position: 45%)
      wire((3.8, y), (5.2, y))
      resistor("z" + k, (5.2, y), (8.6, y), variant: "iec", position: 50%)

      node("m" + k, (3.8, y))
      content((3.8, y + 0.2), anchor: "south", sans(k, weight: "bold"))

      content((rel: (0, 0.55), to: "e" + k + ".center"), anchor: "south", $overline(E)_#k$)
      content((rel: (0.48, 0.15), to: "e" + k + ".center"), anchor: "south", sans("+", weight: "bold"))

      line((4.25, y + 0.2), (4.95, y + 0.2), stroke: 0.85pt, mark: (end: "stealth", fill: black, scale: 1.1))
      content((4.6, y + 0.35), anchor: "south", $overline(I)_#k$)

      content((rel: (0.9, -0.75), to: "z" + k + ".center"), anchor: "south", distance: 18pt, $overline(Z)_#k$)
      bezier((7.4, y + 0.38), (6.4, y + 0.38), (6.9, y + 0.72), stroke: 0.75pt, mark: (end: "stealth", fill: black))
      content((6.9, y + 0.72), anchor: "south", $overline(E)'_#k$)
    }

    // Freccia corrente di neutro I_N
    line((5.1, yN + 0.2), (4.4, yN + 0.2), stroke: 0.85pt, mark: (end: "stealth", fill: black, scale: 1.1))
    content((4.75, yN + 0.35), anchor: "south", $overline(I)_"N"$)
  })
]

#nota[
  *Effetti dell'inserzione del conduttore di neutro*:
  1. Vincola rigidamente i due centri stella allo stesso potenziale ($overline(V)_(O' O) = 0$), garantendo che la tensione ai capi di ciascun carico coincida con la rispettiva tensione stellata del generatore indipendentemente dallo squilibrio del carico:
     $ overline(E)'_k = overline(E)_k - overline(V)_(O' O) = overline(E)_k, quad k = 1, 2, 3 $
  2. Consente il ritorno della corrente risultante di squilibrio attraverso il conduttore di neutro, data per la LKC al nodo $O'$ da:
     $ overline(I)_"N" = overline(I)_1 + overline(I)_2 + overline(I)_3 $
  3. La presenza del quarto conduttore comporta la rinuncia al risparmio del $25%$ di materiale conduttore proprio delle linee di trasmissione trifase a tre fili.
]