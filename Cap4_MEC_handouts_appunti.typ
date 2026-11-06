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

#let scala-schemi = 0.75

// Funzione che disegna Circuito + Diagramma Fasoriale per R, C, L, Z
#let schema-fasoriale(tipo, scala: scala-schemi) = scale(
  x: scala * 100%,
  y: scala * 100%,
  reflow: true
)[
  #zap.circuit({
    import zap: *
    import zap.cetz.draw: *

    // Coordinate del bipolo a sinistra
    let xT = 0.0   // X dei morsetti aperti
    let xC = 0.85  // X del ramo verticale del componente
    let yB = 0.0   // Y inferiore
    let yA = 2.2   // Y superiore

    // Fili orizzontali dai morsetti al componente
    wire((xT, yA), (xC, yA))
    wire((xT, yB), (xC, yB))

    // Componente verticale in base al tipo ("R", "C", "L", "Z")
    if tipo == "R" {
      resistor("comp", (xC, yA), (xC, yB), variant: "ieee")
      content((xC + 0.4, 1.1), anchor: "west", $R$)
    } else if tipo == "C" {
      capacitor("comp", (xC, yA), (xC, yB))
      content((xC + 0.45, 1.1), anchor: "west", $j X_C$)
    } else if tipo == "L" {
      inductor("comp", (xC, yA), (xC, yB), variant: "ieee")
      content((xC + 0.4, 1.1), anchor: "west", $j X_L$)
    } else if tipo == "Z" {
      resistor("comp", (xC, yA), (xC, yB), variant: "iec")
      content((xC + 0.4, 1.1), anchor: "west", $overline(Z)$)
    }

    // Morsetti aperti a sinistra
    node("t_top", (xT, yA), fill: false)
    node("t_bot", (xT, yB), fill: false)

    // Freccia della corrente I in alto a sinistra
    line((-0.85, yA), (-0.22, yA), stroke: 0.8pt, mark: (end: "stealth", fill: black, scale: 1.1))
    content((-0.53, yA + 0.15), anchor: "south", $overline(I)$)

    // Arco della tensione V tra i morsetti
    bezier(
      (xT - 0.05, yB + 0.15),
      (xT - 0.05, yA - 0.15),
      (xT - 0.48, 1.1),
      stroke: 0.7pt,
      mark: (end: "stealth", fill: black, scale: 1.1)
    )
    content((xT - 0.48, 1.25), anchor: "east", $overline(V)$)

    // Freccia ondulata della potenza complessa S in basso
    bezier((-0.9, 0.45), (-0.55, 0.45), (-0.72, 0.65), stroke: 0.8pt)
    bezier((-0.55, 0.45), (-0.2, 0.45), (-0.38, 0.25), stroke: 0.8pt)
    line((-0.2, 0.45), (0.15, 0.45), stroke: 0.8pt, mark: (end: "stealth", fill: black, scale: 1.1))
    content((-0.95, 0.45), anchor: "east", $overline(S)$)

    // --- DIAGRAMMI FASORIALI A DESTRA ---
    if tipo == "R" {
      // V e I in fase (collineari)
      let p0 = (2.4, 0.3)
      line(p0, (3.6, 1.14), stroke: 0.8pt, mark: (end: "stealth", fill: black, scale: 1.1))
      line(p0, (4.3, 1.63), stroke: 0.8pt, mark: (end: "stealth", fill: black, scale: 1.1))
      content((3.2, 0.95), anchor: "south-east", $overline(V)$)
      content((3.9, 1.45), anchor: "south-east", $overline(I)$)

    } else if tipo == "C" {
      // I in anticipo di 90° rispetto a V
      let p0 = (3.1, 0.3)
      line(p0, (4.7, 1.42), stroke: 0.8pt, mark: (end: "stealth", fill: black, scale: 1.1))
      line(p0, (2.4, 1.3), stroke: 0.8pt, mark: (end: "stealth", fill: black, scale: 1.1))
      content((4.3, 1.3), anchor: "south-east", $overline(V)$)
      content((2.6, 1.35), anchor: "south-west", $overline(I)$)

    } else if tipo == "L" {
      // V in anticipo di 90° rispetto a I
      let p0 = (3.1, 0.3)
      line(p0, (4.7, 1.42), stroke: 0.8pt, mark: (end: "stealth", fill: black, scale: 1.1))
      line(p0, (2.4, 1.3), stroke: 0.8pt, mark: (end: "stealth", fill: black, scale: 1.1))
      content((4.3, 1.3), anchor: "south-east", $overline(I)$)
      content((2.6, 1.35), anchor: "south-west", $overline(V)$)

    } else if tipo == "Z" {
      // V verticale e I sfasato di un angolo phi
      let p0 = (2.8, 0.1)
      line(p0, (2.8, 1.8), stroke: 0.8pt, mark: (end: "stealth", fill: black, scale: 1.1))
      line(p0, (3.85, 1.55), stroke: 0.8pt, mark: (end: "stealth", fill: black, scale: 1.1))
      // Archetto dell'angolo phi
      bezier((2.8, 0.95), (3.3, 0.78), (3.08, 0.93), stroke: 0.6pt)
      content((2.8, 1.88), anchor: "south", $overline(V)$)
      content((3.92, 1.5), anchor: "west", $overline(I)$)
      content((3.12, 0.98), anchor: "south", $phi$)
    }
  })
]

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

= Potenza in regime sinusoidale

== Introduzione

Nelle applicazioni industriali, le reti elettriche operanti in regime sinusoidale sono impiegate per trasferire potenza dai generatori ai carichi utilizzatori. In condizioni di regime sinusoidale permanente, l'espressione della potenza assume una forma particolare, ottenuta mediante manipolazioni trigonometriche della formula generale della potenza istantanea, che consente di mettere in evidenza i meccanismi fisici peculiari di questo regime di funzionamento.

== Potenza istantanea e angolo di sfasamento

Considerando un generico bipolo elettrico per il quale si adotta la convenzione degli utilizzatori, la potenza istantanea assorbita al tempo $t$ è definita dal prodotto tra la tensione ai morsetti e la corrente entrante:

$ p(t) = v(t) i(t) $

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *

    // --- Bipolo a sinistra ---
    node("t1", (0, 2.6), fill: false)
    node("t2", (0, 0.2), fill: false)
    wire((0, 2.6), (1, 2.6))
    wire((0, 0.2), (1, 0.2))
    resistor("b1", (1, 2.6), (1, 0.2), variant: "iec")

    // Corrente i(t)
    line((-1.1, 2.6), (-0.25, 2.6), mark: (end: "stealth", fill: black), stroke: 1pt)
    content((-0.65, 3.05), $i(t)$)

    // Tensione v(t)
    bezier((0, 0.45), (-0.1, 2.4), (-0.55, 1.4), mark: (end: "stealth", fill: black), stroke: 0.7pt)
    content((-0.95, 1.45), $v(t)$)

    // Freccia ondulata p(t)
    bezier((-0.7, 0.65), (-0.45, 0.65), (-0.57, 0.85), stroke: 1.8pt)
    bezier((-0.45, 0.65), (-0.2, 0.65), (-0.32, 0.45), stroke: 1.8pt)
    line((-0.2, 0.65), (0.35, 0.65), mark: (end: "stealth", fill: black), stroke: 1.8pt)
    content((-1.15, 0.65), $p(t)$)

    // --- Piano di Gauss a destra ---
    let ox = 3.2
    let oy = 0.2
    line((ox, oy), (ox + 3.8, oy), mark: (end: "stealth", fill: black), stroke: 0.8pt)
    line((ox, oy), (ox, oy + 3.0), mark: (end: "stealth", fill: black), stroke: 0.8pt)
    content((ox + 3.5, oy - 0.35), $R e$)
    content((ox - 0.45, oy + 2.65), $I m$)

    // Fasore V (60 gradi, lunghezza 3.1)
    let vx = ox + 3.1 * calc.cos(60deg)
    let vy = oy + 3.1 * calc.sin(60deg)
    line((ox, oy), (vx, vy), mark: (end: "stealth", fill: black), stroke: 1.1pt)
    content((vx - 0.55, vy - 0.1), $macron(V)$)

    // Fasore I (22 gradi, lunghezza 2.4)
    let ix = ox + 2.4 * calc.cos(22deg)
    let iy = oy + 2.4 * calc.sin(22deg)
    line((ox, oy), (ix, iy), mark: (end: "stealth", fill: black), stroke: 1.1pt)
    content((ix + 0.4, iy + 0.15), $macron(I)$)

    // Archi degli angoli
    arc((ox + 1.5, oy), start: 0deg, stop: 22deg, radius: 1.5, mark: (end: "stealth", fill: black), stroke: 0.5pt)
    content((ox + 1.95, oy + 0.3), $varphi_I$)

    arc((ox + 1.0, oy), start: 0deg, stop: 60deg, radius: 1.0, mark: (end: "stealth", fill: black), stroke: 0.5pt)
    content((ox + 1.15, oy + 0.85), $varphi_V$)

    arc((ox + 1.9 * calc.cos(22deg), oy + 1.9 * calc.sin(22deg)), start: 22deg, stop: 60deg, radius: 1.9, mark: (end: "stealth", fill: black), stroke: 0.5pt)
    content((ox + 1.75, oy + 1.55), $varphi$)
  })
]

In condizioni di regime sinusoidale, indicando con $V$ e $I$ i valori efficaci e con $varphi_V$ e $varphi_I$ le fasi iniziali (rappresentate nel piano complesso dai fasori $macron(V) = V e^(j varphi_V)$ e $macron(I) = I e^(j varphi_I)$), le grandezze temporali di tensione e corrente si esprimono come: // VERIFICA: dedotto dall'equazione

$ cases(
  v(t) = sqrt(2) V sin(omega t + varphi_V),
  i(t) = sqrt(2) I sin(omega t + varphi_I)
) $

L'andamento nel tempo su un periodo delle grandezze istantanee di tensione, corrente e della risultante potenza $p(t)$ è riportato nel grafico seguente.

#align(center)[
  #canvas({
    import draw: *
    let w = 9.0
    let h = 5.6
    let y0 = h / 2

    // Griglia orizzontale tratteggiata
    for dy in (-2.1, -1.4, -0.7, 0.7, 1.4, 2.1) {
      line((0, y0 + dy), (w, y0 + dy), stroke: (paint: gray.lighten(30%), thickness: 0.5pt, dash: "densely-dashed"))
    }
    // Asse t centrale
    line((0, y0), (w, y0), stroke: 0.8pt)
    // Riquadro esterno
    rect((0, 0), (w, h), stroke: 0.8pt)

    // Tacche e label asse X
    for k in range(0, 6) {
      let x = k * 0.2 * w
      let lbl = str(calc.round(k * 0.2, digits: 1))
      line((x, 0), (x, -0.12), stroke: 0.8pt)
      line((x, h), (x, h + 0.12), stroke: 0.8pt)
      content((x, -0.35), text(size: 8.5pt, sans(lbl)))
      content((x, h + 0.35), text(size: 8.5pt, sans(lbl)))
    }
    content((w / 2, -0.8), text(size: 9.5pt, weight: "bold", sans("periodo")))

    // Campionamento curve: v(t) = 0.65 sin(2pi x), i(t) = 0.45 sin(2pi x + 0.6), p(t) = 2.8 v(t) i(t)
    let N = 120
    let pts_v = ()
    let pts_i = ()
    let pts_p = ()
    for k in range(0, N + 1) {
      let u = k / N
      let ang = 2 * calc.pi * u
      let vv = 1.3 * calc.sin(ang)
      let ii = 0.9 * calc.sin(ang + 0.62)
      let pp = 1.85 * vv * ii
      pts_v.push((u * w, y0 + vv))
      pts_i.push((u * w, y0 + ii))
      pts_p.push((u * w, y0 + pp))
    }
    line(..pts_v, stroke: (paint: rgb("#007000"), thickness: 1.4pt))
    line(..pts_i, stroke: (paint: rgb("#c81010"), thickness: 1.4pt))
    line(..pts_p, stroke: (paint: rgb("#0010c8"), thickness: 1.4pt))

    // Legenda
    rect((0.2, 0.2), (2.6, 1.55), fill: white, stroke: 0.7pt)
    line((0.35, 1.25), (0.85, 1.25), stroke: (paint: rgb("#007000"), thickness: 1.4pt))
    content((1.0, 1.25), anchor: "west", text(size: 8.5pt, sans("tensione")))
    line((0.35, 0.85), (0.85, 0.85), stroke: (paint: rgb("#c81010"), thickness: 1.4pt))
    content((1.0, 0.85), anchor: "west", text(size: 8.5pt, sans("corrente")))
    line((0.35, 0.45), (0.85, 0.45), stroke: (paint: rgb("#0010c8"), thickness: 1.4pt))
    content((1.0, 0.45), anchor: "west", text(size: 8.5pt, sans("p(t)")))
  })
]

Sostituendo le espressioni temporali di tensione e corrente nella definizione di potenza istantanea si ottiene:

$ p(t) = sqrt(2) V sin(omega t + varphi_V) sqrt(2) I sin(omega t + varphi_I) = 2 V I sin(omega t + varphi_V) sin(omega t + varphi_I) $

Ricordando dalla trigonometria la formula di Werner per il prodotto di due funzioni sinusoidali: // VERIFICA: dedotto dall'equazione

$ sin alpha sin beta = 1 / 2 [cos(alpha - beta) - cos(alpha + beta)] $

e ponendo $alpha = omega t + varphi_V$ e $beta = omega t + varphi_I$, l'espressione della potenza istantanea può essere rielaborata come:

$ p(t) = 2 V I dot 1 / 2 [cos(varphi_V - varphi_I) - cos(2 omega t + varphi_V + varphi_I)] $

#nota[
  Si definisce *angolo di sfasamento* $varphi$ la differenza tra la fase della tensione e la fase della corrente:
  $ varphi = varphi_V - varphi_I $
  Tale angolo è fisicamente molto importante poiché, sebbene indicato talvolta con simbolo differente, coincide con l'argomento dell'impedenza complessa $macron(Z)$ del bipolo: // VERIFICA: dedotto dall'equazione
  $ macron(Z) = macron(V) / macron(I) = (V e^(j varphi_V)) / (I e^(j varphi_I)) = V / I e^(j (varphi_V - varphi_I)) = Z e^(j varphi) $
]

Introducendo l'angolo di sfasamento $varphi$, la potenza istantanea assume la forma:

$ p(t) = V I [cos varphi - cos(2 omega t + varphi_V + varphi_I)] $

== Componenti attiva e reattiva della potenza istantanea

Data la rilevanza fisica dell'angolo caratteristico $varphi = varphi_V - varphi_I$, è opportuno manipolare algebricamente l'argomento del secondo termine coseno affinché compaia esplicitamente l'angolo $varphi$ anche nella parte variabile nel tempo. Sommando e sottraendo la fase della corrente $varphi_I$ si ha:

$ 2 omega t + varphi_V + varphi_I = 2 omega t + varphi_V - varphi_I + varphi_I + varphi_I = 2(omega t + varphi_I) + varphi $

Sostituendo tale identità nella formula della potenza istantanea si ottiene:

$ p(t) = V I {cos varphi - cos[2(omega t + varphi_I) + varphi]} $

Sfruttando la formula trigonometrica di addizione del coseno: // VERIFICA: dedotto dall'equazione

$ cos(alpha + beta) = cos alpha cos beta - sin alpha sin beta $

con $alpha = 2(omega t + varphi_I)$ e $beta = varphi$, è possibile sviluppare il secondo termine raccogliendo a fattor comune i termini dipendenti da $cos varphi$ e da $sin varphi$.

La potenza istantanea viene così suddivisa nella somma di due contributi dotati di un preciso significato fisico e pratico:

$ p(t) = p_a(t) + p_r(t) $

- *Componente attiva della potenza istantanea* $p_a(t)$:
  $ p_a(t) = V I cos varphi [1 - cos 2(omega t + varphi_I)] $

- *Componente reattiva della potenza istantanea* $p_r(t)$:
  $ p_r(t) = V I sin varphi sin 2(omega t + varphi_I) $

Entrambe le componenti oscillano a frequenza doppia rispetto alla tensione $v(t)$ e alla corrente $i(t)$ (pulsazione pari a $2 omega$). Come illustrato nei grafici seguenti, la componente attiva $p_a(t)$ non cambia mai segno (rimane sempre maggiore o uguale a zero se $|varphi| <= pi/2$) e oscilla tra $0$ e il valore massimo $2 V I cos varphi$ attorno al valore medio $V I cos varphi$. La componente reattiva $p_r(t)$ è invece una sinusoide pura a valor medio nullo che oscilla simmetricamente tra $+V I sin varphi$ e $-V I sin varphi$.

#align(center)[
  #canvas({
    import draw: *

    // --- Grafico p_a(t) a sinistra ---
    line((-0.3, 0), (4.5, 0), mark: (end: "stealth", fill: black), stroke: 0.8pt)
    line((0, -0.4), (0, 2.8), mark: (end: "stealth", fill: black), stroke: 0.8pt)
    content((4.6, -0.3), $t$)
    content((-0.55, 2.65), $p_a(t)$)

    line((-0.1, 2.0), (0.1, 2.0), stroke: 0.8pt)
    line((0.1, 2.0), (0.7, 2.0), stroke: (dash: "dashed", thickness: 0.6pt))
    content((-0.85, 2.0), $2 V I cos varphi$)

    let pts_pa = ()
    for k in range(0, 91) {
      let x = k / 90 * 4.0
      let y = 1.0 * (1 - calc.cos(3 * calc.pi * x / 2.0))
      pts_pa.push((x, y))
    }
    line(..pts_pa, stroke: 1.2pt)

    // --- Grafico p_r(t) a destra ---
    let ox = 7.0
    line((ox - 0.3, 0.8), (ox + 4.5, 0.8), mark: (end: "stealth", fill: black), stroke: 0.8pt)
    line((ox, -0.9), (ox, 2.8), mark: (end: "stealth", fill: black), stroke: 0.8pt)
    content((ox + 4.6, 0.5), $t$)
    content((ox - 0.55, 2.65), $p_r(t)$)

    line((ox - 0.1, 1.9), (ox + 0.1, 1.9), stroke: 0.8pt)
    content((ox - 0.8, 1.9), $V I sin varphi$)

    line((ox - 0.1, -0.3), (ox + 0.1, -0.3), stroke: 0.8pt)
    content((ox - 0.9, -0.3), $-V I sin varphi$)

    let pts_pr = ()
    for k in range(0, 91) {
      let x = k / 90 * 4.0
      let y = 0.8 + 1.1 * calc.sin(3 * calc.pi * x / 2.0)
      pts_pr.push((ox + x, y))
    }
    line(..pts_pr, stroke: 1.2pt)
  })
]

== Casi particolari: bipoli passivi elementari

Analizziamo il comportamento energetico dei tre bipoli ideali passivi (resistore, condensatore e induttore) partendo dalle espressioni generali delle componenti attiva e reattiva:

$ p_a(t) = V I cos varphi [1 - cos 2(omega t + varphi_I)], quad p_r(t) = V I sin varphi sin 2(omega t + varphi_I) $

=== Resistore

Per un resistore ideale di resistenza $R$, la relazione fasoriale tra tensione e corrente è puramente reale:

$ macron(V) = R macron(I) arrow.r.double varphi = varphi_V - varphi_I = 0 arrow.r.double cases(sin varphi = 0, cos varphi = 1) $

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *
    set-style(resistor: (variant: "ieee"))

    // Bipolo resistore
    resistor("r1", (0, 2.2), (0, 0), label: (content: $R$, anchor: "east", distance: 6pt), n: "o-o")
    line((0, 2.9), (0, 2.35), mark: (end: "stealth", fill: black), stroke: 0.9pt)
    content((-0.35, 2.65), $macron(I)$)
    bezier((0.25, 0.3), (0.25, 1.9), (0.65, 1.1), mark: (end: "stealth", fill: black), stroke: 0.7pt)
    content((0.8, 1.1), $macron(V)$)

    // Diagramma fasoriale (in fase)
    let ox = 2.6
    let oy = 0.3
    line((ox, oy), (ox + 2.2, oy + 1.4), mark: (end: "stealth", fill: black), stroke: 1.0pt)
    line((ox, oy), (ox + 1.2, oy + 0.76), mark: (end: "stealth", fill: black), stroke: 1.1pt)
    content((ox + 0.55, oy + 0.65), $macron(I)$)
    content((ox + 1.65, oy + 1.35), $macron(V)$)
  })
]

Sostituendo tali valori nelle espressioni generali, la componente reattiva si annulla identicamente mentre la potenza istantanea coincide con la sola componente attiva:

$ cases(
  p_r(t) = 0,
  p_a(t) = V I [1 - cos 2(omega t + varphi_I)] >= 0
) $

#nota[
  Nel resistore ideale, $p_a(t)$ è sempre positiva (o al più nulla negli istanti di passaggio per lo zero di tensione e corrente), presenta valor medio pari a $V I$ e oscilla con ampiezza picco-picco pari a $2 V I$. Il bipolo assorbe sempre energia dalla rete dissipandola per effetto Joule.
]

#align(center)[
  #canvas({
    import draw: *
    let w = 8.4
    let h = 4.6
    let y0 = 1.6

    // Griglia
    for x in (w * 0.25, w * 0.5, w * 0.75) {
      line((x, 0), (x, h), stroke: (paint: gray.lighten(50%), thickness: 0.5pt))
    }
    line((0, y0 + 1.5), (w, y0 + 1.5), stroke: (paint: gray.lighten(50%), thickness: 0.5pt))
    line((0, y0), (w, y0), stroke: 0.7pt)
    rect((0, 0), (w, h), stroke: 0.7pt)

    // Etichette asse X
    content((0, -0.3), text(size: 8.5pt, $0$))
    content((w * 0.25, -0.3), text(size: 8.5pt, $pi / 2$))
    content((w * 0.5, -0.3), text(size: 8.5pt, $pi$))
    content((w * 0.75, -0.3), text(size: 8.5pt, $3 pi / 2$))
    content((w, -0.3), text(size: 8.5pt, $2 pi$))
    content((w / 2, -0.7), text(size: 9pt, sans("angle (rad)")))

    let N = 100
    let pts_v = ()
    let pts_i = ()
    let pts_pa = ()
    for k in range(0, N + 1) {
      let u = k / N
      let ang = 2 * calc.pi * u
      pts_v.push((u * w, y0 + 0.75 * calc.sin(ang)))
      pts_i.push((u * w, y0 + 1.5 * calc.sin(ang)))
      pts_pa.push((u * w, y0 + 1.5 * (1 - calc.cos(2 * ang))))
    }
    line(..pts_v, stroke: (paint: rgb("#0072bd"), thickness: 1.3pt))
    line(..pts_i, stroke: (paint: rgb("#d95319"), thickness: 1.3pt))
    line(..pts_pa, stroke: (paint: rgb("#edb120"), thickness: 1.3pt))

    // Legenda
    rect((5.7, 2.3), (7.15, 3.65), fill: white, stroke: 0.6pt)
    line((5.8, 3.4), (6.2, 3.4), stroke: (paint: rgb("#0072bd"), thickness: 1.3pt))
    content((6.3, 3.4), anchor: "west", text(size: 8pt, $v(t)$))
    line((5.8, 2.98), (6.2, 2.98), stroke: (paint: rgb("#d95319"), thickness: 1.3pt))
    content((6.3, 2.98), anchor: "west", text(size: 8pt, $i(t)$))
    line((5.8, 2.55), (6.2, 2.55), stroke: (paint: rgb("#edb120"), thickness: 1.3pt))
    content((6.3, 2.55), anchor: "west", text(size: 8pt, $p_a(t)$))
  })
]

=== Condensatore

Per un condensatore ideale di capacità $C$, la tensione è in ritardo di $pi/2$ rispetto alla corrente:

$ macron(V) = - j / (omega C) macron(I) arrow.r.double varphi = varphi_V - varphi_I = - pi / 2 arrow.r.double cases(sin varphi = -1, cos varphi = 0) $

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *

    // Bipolo condensatore
    capacitor("c1", (0, 2.2), (0, 0), label: (content: $- j / (omega C)$, anchor: "south", distance: 6pt), n: "o-o")
    line((0, 2.9), (0, 2.35), mark: (end: "stealth", fill: black), stroke: 0.9pt)
    content((-0.35, 2.65), $macron(I)$)
    bezier((0.35, 0.3), (0.35, 1.9), (0.75, 1.1), mark: (end: "stealth", fill: black), stroke: 0.7pt)
    content((0.9, 1.1), $macron(V)$)

    // Diagramma fasoriale (I in anticipo di 90 gradi su V)
    let ox = 3.2
    let oy = 0.2
    let ang_v = 33deg
    let ang_i = 123deg
    line((ox, oy), (ox + 2.2 * calc.cos(ang_v), oy + 2.2 * calc.sin(ang_v)), mark: (end: "stealth", fill: black), stroke: 1.0pt)
    line((ox, oy), (ox + 1.4 * calc.cos(ang_i), oy + 1.4 * calc.sin(ang_i)), mark: (end: "stealth", fill: black), stroke: 1.0pt)
    content((ox + 1.55 * calc.cos(ang_v), oy + 1.55 * calc.sin(ang_v) + 0.35), $macron(V)$)
    content((ox + 1.35 * calc.cos(ang_i) + 0.35, oy + 1.35 * calc.sin(ang_i) + 0.15), $macron(I)$)
  })
]

Sostituendo $varphi = -pi/2$ nelle equazioni della potenza istantanea si ottiene:

$ cases(
  p_a(t) = 0,
  p_r(t) = - V I sin 2(omega t + varphi_I)
) $

Nel condensatore la componente attiva è identicamente nulla, mentre la componente reattiva $p_r(t)$ presenta valor medio nullo e ampiezza pari a $V I$.

#align(center)[
  #canvas({
    import draw: *
    let w = 8.4
    let h = 4.6
    let y0 = h / 2

    for x in (w * 0.25, w * 0.5, w * 0.75) {
      line((x, 0), (x, h), stroke: (paint: gray.lighten(50%), thickness: 0.5pt))
    }
    line((0, y0), (w, y0), stroke: 0.7pt)
    rect((0, 0), (w, h), stroke: 0.7pt)

    content((0, -0.3), text(size: 8.5pt, $0$))
    content((w * 0.25, -0.3), text(size: 8.5pt, $pi / 2$))
    content((w * 0.5, -0.3), text(size: 8.5pt, $pi$))
    content((w * 0.75, -0.3), text(size: 8.5pt, $3 pi / 2$))
    content((w, -0.3), text(size: 8.5pt, $2 pi$))
    content((w / 2, -0.7), text(size: 9pt, sans("angle (rad)")))

    // Se v(t) = sin(x), allora i(t) = cos(x) e p_r(t) = v(t)i(t) = sin(2x)
    let N = 100
    let pts_v = ()
    let pts_i = ()
    let pts_pr = ()
    for k in range(0, N + 1) {
      let u = k / N
      let ang = 2 * calc.pi * u
      pts_v.push((u * w, y0 + 1.05 * calc.sin(ang)))
      pts_i.push((u * w, y0 + 2.3 * calc.cos(ang)))
      pts_pr.push((u * w, y0 + 2.3 * calc.sin(2 * ang)))
    }
    line(..pts_v, stroke: (paint: rgb("#0072bd"), thickness: 1.3pt))
    line(..pts_i, stroke: (paint: rgb("#d95319"), thickness: 1.3pt))
    line(..pts_pr, stroke: (paint: rgb("#edb120"), thickness: 1.3pt))

    // Legenda
    rect((0.2, 0.6), (1.65, 1.95), fill: white, stroke: 0.6pt)
    line((0.3, 1.7), (0.7, 1.7), stroke: (paint: rgb("#0072bd"), thickness: 1.3pt))
    content((0.8, 1.7), anchor: "west", text(size: 8pt, $v(t)$))
    line((0.3, 1.28), (0.7, 1.28), stroke: (paint: rgb("#d95319"), thickness: 1.3pt))
    content((0.8, 1.28), anchor: "west", text(size: 8pt, $i(t)$))
    line((0.3, 0.85), (0.7, 0.85), stroke: (paint: rgb("#edb120"), thickness: 1.3pt))
    content((0.8, 0.85), anchor: "west", text(size: 8pt, $p_r(t)$))
  })
]

=== Induttore

Per un induttore ideale di induttanza $L$, la tensione è in anticipo di $pi/2$ rispetto alla corrente:

$ macron(V) = j omega L macron(I) arrow.r.double varphi = varphi_V - varphi_I = + pi / 2 arrow.r.double cases(sin varphi = 1, cos varphi = 0) $

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *

    // Bipolo induttore
    inductor("l1", (0, 2.2), (0, 0), label: (content: $j omega L$, anchor: "south", distance: 6pt), n: "o-o")
    line((0, 2.9), (0, 2.35), mark: (end: "stealth", fill: black), stroke: 0.9pt)
    content((-0.35, 2.65), $macron(I)$)
    bezier((0.35, 0.3), (0.35, 1.9), (0.75, 1.1), mark: (end: "stealth", fill: black), stroke: 0.7pt)
    content((0.9, 1.1), $macron(V)$)

    // Diagramma fasoriale (V in anticipo di 90 gradi su I)
    let ox = 4.2
    let oy = 0.2
    let ang_i = 57deg
    let ang_v = 147deg
    line((ox, oy), (ox + 1.4 * calc.cos(ang_i), oy + 1.4 * calc.sin(ang_i)), mark: (end: "stealth", fill: black), stroke: 1.0pt)
    line((ox, oy), (ox + 2.2 * calc.cos(ang_v), oy + 2.2 * calc.sin(ang_v)), mark: (end: "stealth", fill: black), stroke: 1.0pt)
    content((ox + 1.35 * calc.cos(ang_i) - 0.15, oy + 1.35 * calc.sin(ang_i) + 0.35), $macron(I)$)
    content((ox + 1.65 * calc.cos(ang_v) + 0.3, oy + 1.65 * calc.sin(ang_v) + 0.35), $macron(V)$)
  })
]

Sostituendo $varphi = +pi/2$ nelle espressioni generali si ottiene:

$ cases(
  p_a(t) = 0,
  p_r(t) = V I sin 2(omega t + varphi_I)
) $

Anche nell'induttore ideale la componente attiva è nulla, mentre la potenza reattiva $p_r(t)$ oscilla con valor medio nullo e ampiezza $V I$.

#align(center)[
  #canvas({
    import draw: *
    let w = 8.4
    let h = 4.6
    let y0 = h / 2

    for x in (w * 0.25, w * 0.5, w * 0.75) {
      line((x, 0), (x, h), stroke: (paint: gray.lighten(50%), thickness: 0.5pt))
    }
    line((0, y0), (w, y0), stroke: 0.7pt)
    rect((0, 0), (w, h), stroke: 0.7pt)

    content((0, -0.3), text(size: 8.5pt, $0$))
    content((w * 0.25, -0.3), text(size: 8.5pt, $pi / 2$))
    content((w * 0.5, -0.3), text(size: 8.5pt, $pi$))
    content((w * 0.75, -0.3), text(size: 8.5pt, $3 pi / 2$))
    content((w, -0.3), text(size: 8.5pt, $2 pi$))
    content((w / 2, -0.7), text(size: 9pt, sans("angle (rad)")))

    // Se v(t) = sin(x), allora i(t) = -cos(x) e p_r(t) = -sin(2x)
    let N = 100
    let pts_v = ()
    let pts_i = ()
    let pts_pr = ()
    for k in range(0, N + 1) {
      let u = k / N
      let ang = 2 * calc.pi * u
      pts_v.push((u * w, y0 + 1.05 * calc.sin(ang)))
      pts_i.push((u * w, y0 - 2.3 * calc.cos(ang)))
      pts_pr.push((u * w, y0 - 2.3 * calc.sin(2 * ang)))
    }
    line(..pts_v, stroke: (paint: rgb("#0072bd"), thickness: 1.3pt))
    line(..pts_i, stroke: (paint: rgb("#d95319"), thickness: 1.3pt))
    line(..pts_pr, stroke: (paint: rgb("#edb120"), thickness: 1.3pt))

    // Legenda
    rect((0.6, 3.15), (2.05, 4.45), fill: white, stroke: 0.6pt)
    line((0.7, 4.2), (1.1, 4.2), stroke: (paint: rgb("#0072bd"), thickness: 1.3pt))
    content((1.2, 4.2), anchor: "west", text(size: 8pt, $v(t)$))
    line((0.7, 3.78), (1.1, 3.78), stroke: (paint: rgb("#d95319"), thickness: 1.3pt))
    content((1.2, 3.78), anchor: "west", text(size: 8pt, $i(t)$))
    line((0.7, 3.35), (1.1, 3.35), stroke: (paint: rgb("#edb120"), thickness: 1.3pt))
    content((1.2, 3.35), anchor: "west", text(size: 8pt, $p_r(t)$))
  })
]

=== Confronto energetico tra induttore e condensatore

Assumendo una comune fase di riferimento (ad esempio ponendo la tensione con fase iniziale nulla $v(t) = sqrt(2) V sin(omega t)$), le potenze reattive istantanee del condensatore e dell'induttore risultano in opposizione di fase: // VERIFICA: dedotto dall'equazione

$ cases(
  p_(r, C)(t) = V I sin(2 omega t),
  p_(r, L)(t) = - V I sin(2 omega t)
) $

#align(center)[
  #canvas({
    import draw: *
    line((-0.3, 0), (6.5, 0), mark: (end: "stealth", fill: black), stroke: 0.8pt)
    line((0, -1.6), (0, 1.9), mark: (end: "stealth", fill: black), stroke: 0.8pt)
    content((6.65, -0.25), $t$)
    content((6.1, 1.5), text(fill: rgb("#0072bd"), $p_(r, C)(t)$))
    content((6.1, -1.5), text(fill: rgb("#d95319"), $p_(r, L)(t)$))

    let pts_c = ()
    let pts_l = ()
    for k in range(0, 101) {
      let x = k / 100 * 5.8
      let y = 1.3 * calc.sin(3 * calc.pi * x / 5.8 * 1.5)
      pts_c.push((x, y))
      pts_l.push((x, -y))
    }
    line(..pts_c, stroke: (paint: rgb("#0072bd"), thickness: 1.3pt))
    line(..pts_l, stroke: (paint: rgb("#d95319"), thickness: 1.3pt))
  })
]

#nota[
  Negli intervalli di tempo in cui la potenza reattiva istantanea del condensatore è positiva (il condensatore assorbe energia immagazzinandola nel campo elettrico), quella dell'induttore è negativa (l'induttore cede l'energia immagazzinata nel campo magnetico), e viceversa. In un bipolo generico con sfasamento $varphi$ qualsiasi, sono invece presenti contemporaneamente sia la componente attiva $p_a(t)$ sia la componente reattiva $p_r(t)$.
]

// ==========================================
// SLIDE 16 - 30
// ==========================================

== Caso Generale: Impedenza Generica ed Energia Scambiata

In generale, se l'angolo di sfasamento verifica la condizione $-pi / 2 <= phi <= pi / 2$, ovvero se l'impedenza $overline(Z)$ presenta sia parte reale sia parte immaginaria, entrambe le componenti $p_a (t)$ e $p_r (t)$ compaiono nell'espressione della potenza istantanea $p(t)$.

Nella figura seguente è riportato l'andamento temporale di $p(t)$, $p_a (t)$ e $p_r (t)$ nel caso esemplificativo in cui $phi_V = 0$, $phi_I = pi / 6$ e quindi $phi = phi_V - phi_I = -pi / 6$:
// VERIFICA: valori di fase dedotti dal grafico e dai frammenti OCR della slide 16

#align(center)[
  #canvas(length: 1cm, {
    import draw: *
    
    // Riquadro del grafico
    rect((0, -2), (10, 4), stroke: 0.6pt + black)
    // Asse zero
    line((0, 0), (10, 0), stroke: 0.5pt + black)
    
    // Tacche asse x
    for (x, lbl) in ((0, $0$), (2.5, $pi/2$), (5, $pi$), (7.5, $3pi/2$), (10, $2pi$)) {
      line((x, -2), (x, -1.85), stroke: 0.5pt + black)
      line((x, 4), (x, 3.85), stroke: 0.5pt + black)
      content((x, -2.35), lbl)
    }
    content((5, -2.9), sans("angle (rad)", size: 10pt))
    
    // Tacche asse y
    for y in (-1, 0, 1, 2, 3) {
      line((0, y), (0.15, y), stroke: 0.5pt + black)
      line((10, y), (9.85, y), stroke: 0.5pt + black)
    }
    
    // Parametri: phi = -pi/6, phi_I = pi/6
    // pa(t) = A * cos(phi) * (1 - cos(2*theta + pi/3))
    // pr(t) = A * sin(phi) * sin(2*theta + pi/3)
    // p(t) = pa(t) + pr(t)
    let N = 100
    let pts-pa = ()
    let pts-pr = ()
    let pts-p = ()
    for k in range(N + 1) {
      let x = 10.0 * k / N
      let th = 2.0 * calc.pi * k / N
      let arg = 2.0 * th + calc.pi / 3.0
      let pa = 1.9 * (1.0 - calc.cos(arg))
      let pr = -1.1 * calc.sin(arg)
      let p = pa + pr
      pts-pa.push((x, pa))
      pts-pr.push((x, pr))
      pts-p.push((x, p))
    }
    
    line(..pts-p, stroke: 1.5pt + rgb("#0072bd"))
    line(..pts-pa, stroke: 1.5pt + rgb("#d95319"))
    line(..pts-pr, stroke: 1.5pt + rgb("#edb120"))
    
    // Legenda
    rect((3.8, 2.0), (5.3, 3.8), fill: white, stroke: 0.5pt + black)
    line((3.95, 3.45), (4.4, 3.45), stroke: 1.5pt + rgb("#0072bd"))
    content((4.8, 3.45), $p(t)$)
    line((3.95, 2.85), (4.4, 2.85), stroke: 1.5pt + rgb("#d95319"))
    content((4.8, 2.85), $p_a (t)$)
    line((3.95, 2.25), (4.4, 2.25), stroke: 1.5pt + rgb("#edb120"))
    content((4.8, 2.25), $p_r (t)$)
  })
]

L'energia complessiva $w(t)$ scambiata dal bipolo nell'intervallo $[0, t]$ si ottiene integrando nel tempo la potenza istantanea $p(t)$:

$ w(t) = integral_0^t p(t') dif t' = integral_0^t [p_a (t') + p_r (t')] dif t' = integral_0^t p_a (t') dif t' + integral_0^t p_r (t') dif t' $

== Potenza Attiva

L'energia netta scambiata dal bipolo può essere ricavata dall'integrale nel tempo del termine $p_a (t)$. Assumendo per semplicità $phi_I = 0$, l'integrale di $p_a (t)$ fornisce l'andamento temporale rappresentato nel grafico seguente:

#align(center)[
  #canvas(length: 1cm, {
    import draw: *
    
    // Griglia di sfondo
    for x in range(1, 5) {
      line((x * 1.6, 0), (x * 1.6, 5), stroke: 0.4pt + gray.lighten(30%))
    }
    for y in range(1, 5) {
      line((0, y * 1.0), (8, y * 1.0), stroke: 0.4pt + gray.lighten(30%))
    }
    
    // Riquadro
    rect((0, 0), (8, 5), stroke: 0.7pt + black)
    
    // Tacche principali e secondarie
    for i in range(0, 26) {
      let x = i * 8.0 / 25.0
      let len = if calc.rem(i, 5) == 0 { 0.15 } else { 0.08 }
      line((x, 0), (x, -len), stroke: 0.5pt + black)
      line((x, 5), (x, 5 + len), stroke: 0.5pt + black)
    }
    for j in range(0, 26) {
      let y = j * 5.0 / 25.0
      let len = if calc.rem(j, 5) == 0 { 0.15 } else { 0.08 }
      line((0, y), (-len, y), stroke: 0.5pt + black)
      line((8, y), (8 + len, y), stroke: 0.5pt + black)
    }
    
    content((4, -0.55), $italic("tempo")$)
    content((-0.6, 2.5), angle: 90deg, $italic("energia")$)
    
    // Retta media: t * V * I * cos(phi)
    line((0, 0), (8, 5), stroke: 1.5pt + black)
    
    // Curva oscillante: V * I * cos(phi) * (t - 1/(2*omega) * sin(2*omega*t))
    let N = 120
    let pts = ()
    for k in range(N + 1) {
      let x = 8.0 * k / N
      let y = 5.0 * (k / N) - 0.12 * calc.sin(5.0 * 2.0 * calc.pi * k / N)
      pts.push((x, y))
    }
    line(..pts, stroke: (paint: black, thickness: 1pt, dash: "dashed"))
    
    // Punti di richiamo ed etichette
    circle((3.76, 2.35), radius: 0.07, fill: black)
    line((3.76, 2.35), (2.7, 3.3), stroke: 0.6pt + black)
    content((2.1, 3.6), $t V I cos(phi)$)
    
    circle((2.8, 1.66), radius: 0.07, fill: black)
    line((2.8, 1.66), (3.1, 1.05), stroke: 0.6pt + black)
    content((5.5, 1.05), $V I cos phi (t - 1 / (2 omega) sin 2 omega t)$)
  })
]

Il valore di energia scambiato dal bipolo è approssimato dall'integrale del suo termine medio $V I cos phi$, ovvero dalla quantità lineare nel tempo $V I cos phi dot t$.

#nota[
Questa approssimazione è concettualmente importante perché consente di esprimere l'energia scambiata in funzione di una quantità indipendente dal tempo $t$, ottenuta direttamente dai valori efficaci di tensione e corrente e dal fattore di potenza $cos phi$.
]

Tale quantità, che coincide con il valor medio di $p_a (t)$ (e dell'intera potenza istantanea $p(t)$), è denominata *potenza attiva* $P$ ed è definita da:

$ P = V I cos phi $

L'unità di misura della potenza attiva $P$ nel Sistema Internazionale è il *watt* ($"W"$).

== Potenza Reattiva

Nei componenti dinamici o reattivi ($C$ ed $L$), l'unica componente della potenza istantanea è $p_r (t)$. Questo contributo di potenza ha valor medio nullo ($\langle p_r (t) \rangle = 0$) poiché i condensatori e gli induttori immagazzinano e restituiscono alternativamente energia al circuito.

Per tenere conto dell'entità di questi flussi energetici bidirezionali si introduce un nuovo indicatore energetico, denominato *potenza reattiva* $Q$, definito dal fattore moltiplicativo (ampiezza di oscillazione) del termine $sin [2 (omega t + phi_I)]$:

$ Q = V I sin phi $

#nota[
Poiché la potenza reattiva non corrisponde a un lavoro netto convertito (non avendo un diretto significato fisico di potenza media dissipata o prodotta), per distinguerla dalla potenza attiva l'unità di misura di $Q$ non è il watt bensì il *volt-ampere reattivo* ($"VAr"$ o $"var"$).
]

== Potenza Complessa e Triangolo delle Potenze

=== Definizione di Potenza Complessa in un Bipolo

Sia la potenza attiva $P$ sia la potenza reattiva $Q$ sono definite in termini dei valori efficaci $V$ e $I$ e dell'angolo di sfasamento $phi = phi_V - phi_I$ tra di essi. Queste grandezze sono legate ai rispettivi fasori rappresentativi:

$ overline(V) = V e^(j phi_V), quad overline(I) = I e^(j phi_I) ==> overline(I)^* = I e^(-j phi_I) $

#grid(
  columns: (1fr, 2fr),
  column-gutter: 1.5em,
  align: (center + horizon, left + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      
      resistor("z", (0, 0), (0, 3), variant: "iec", n: "o-o")
      
      // Freccia corrente I in alto verso il basso
      line((0.35, 2.9), (0.35, 2.0), mark: (end: "stealth", fill: black, scale: 1.2), stroke: 0.9pt + black)
      content((0.75, 2.45), $overline(I)$)
      
      // Freccia curva tensione V a sinistra dal basso verso l'alto
      bezier((-0.35, 0.2), (-0.35, 2.5), (-0.75, 1.35), mark: (end: "stealth", fill: black, scale: 1.2), stroke: 0.7pt + black)
      content((-1.0, 1.35), $overline(V)$)
    })
  ],
  [
    Moltiplicando il fasore della tensione $overline(V)$ per il complesso coniugato del fasore della corrente $overline(I)^*$, si ottiene:

    $ overline(V) overline(I)^* = V e^(j phi_V) I e^(-j phi_I) = V I e^(j (phi_V - phi_I)) = V I e^(j phi) $

    Applicando la formula di Eulero, tale espressione racchiude in un unico numero complesso sia $P$ sia $Q$ e prende il nome di *potenza complessa* $overline(S)$:

    $ overline(S) = overline(V) overline(I)^* = V I (cos phi + j sin phi) = P + j Q $
  ]
)

Il modulo di $overline(S)$ è chiamato *potenza apparente* $S$:

$ S = |overline(S)| = sqrt(P^2 + Q^2) = V I $

La potenza apparente è misurata in *volt-ampere* ($"VA"$). Dalle definizioni introdotte seguono immediatamente le relazioni tra le componenti della potenza complessa:

$ cases(
  P = "Re"[overline(S)] = S cos phi,
  Q = "Im"[overline(S)] = S sin phi
) $

=== Triangolo delle Potenze

L'espressione algebrica della potenza complessa $overline(S) = P + j Q$ lega geometricamente tra loro $P$, $Q$ ed $S$ nel piano complesso all'interno di un triangolo rettangolo denominato *triangolo delle potenze*:

#align(center)[
  #canvas(length: 1cm, {
    import draw: *
    
    // Triangolo rettangolo
    line((0, 0), (4, 0), (4, 3), close: true, stroke: 1.2pt + black)
    
    // Arco per l'angolo phi
    arc((1.2, 0), start: 0deg, stop: 36.87deg, radius: 1.2, mark: (end: "stealth", fill: black, scale: 0.8), stroke: 0.7pt + black)
    content((1.65, 0.55), $phi$)
    
    // Etichette lati
    content((2, -0.45), $P$)
    content((4.45, 1.5), $Q$)
    content((1.65, 1.85), $S$)
  })
]

#nota[
L'angolo $phi$ del triangolo delle potenze esprime sempre la differenza di fase (sfasamento) fra il fasore della tensione e quello della corrente ($phi = phi_V - phi_I$). Di conseguenza:
- Il cateto orizzontale $P = S cos phi$ ha il segno di $cos phi$ (sempre $P >= 0$ per un bipolo passivo).
- Il cateto verticale $Q = S sin phi$ ha il segno di $sin phi$ ($Q > 0$ per carichi di natura induttiva con $phi > 0$; $Q < 0$ per carichi di natura capacitiva con $phi < 0$).
]

=== Potenza Complessa in un'Impedenza

Consideriamo un bipolo passivo caratterizzato da un'impedenza $overline(Z) = R + j X = Z e^(j phi)$, sottoposto alla tensione $overline(V)$ e attraversato dalla corrente $overline(I)$ secondo la convenzione degli utilizzatori.

==== Espressione di $overline(S)$ in funzione della corrente $I$

#grid(
  columns: (1.2fr, 1.8fr, 1.5fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon, center + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      
      resistor("z", (0, 0), (0, 3), variant: "iec", n: "o-o", label: (content: $overline(Z)$, anchor: "south", distance: 6pt))
      line((0.35, 2.9), (0.35, 2.0), mark: (end: "stealth", fill: black, scale: 1.2), stroke: 0.9pt + black)
      content((0.75, 2.45), $overline(I)$)
      bezier((-0.35, 0.2), (-0.35, 2.5), (-0.75, 1.35), mark: (end: "stealth", fill: black, scale: 1.2), stroke: 0.7pt + black)
      content((-1.0, 1.35), $overline(V)$)
    })
  ],
  [
    Sostituendo la relazione costitutiva dell'impedenza $overline(V) = overline(Z) overline(I)$ nell'espressione della potenza complessa e ricordando che $overline(I) overline(I)^* = |overline(I)|^2 = I^2$, si ottiene:

    $ overline(S) = overline(V) overline(I)^* = (overline(Z) overline(I)) overline(I)^* = overline(Z) I^2 = (R + j X) I^2 = R I^2 + j X I^2 $

    Separando parte reale, parte immaginaria e modulo:
    $ cases(
      P = R I^2,
      Q = X I^2,
      S = |overline(S)| = |overline(Z)| I^2 = Z I^2
    ) $
  ],
  [
    #canvas(length: 0.85cm, {
      import draw: *
      line((0, 0), (4, 0), (4, 3), close: true, stroke: 1.2pt + black)
      arc((1.2, 0), start: 0deg, stop: 36.87deg, radius: 1.2, mark: (end: "stealth", fill: black, scale: 0.8), stroke: 0.7pt + black)
      content((1.65, 0.55), $phi$)
      content((2, -0.5), $R I^2$)
      content((4.65, 1.5), $X I^2$)
      content((1.5, 1.9), $Z I^2$)
    })
  ]
)

Il triangolo delle potenze risulta dunque simile al triangolo dell'impedenza, ottenuto moltiplicando ciascun lato ($R$, $X$, $Z$) per il quadrato del valore efficace della corrente $I^2$.

==== Espressione di $overline(S)$ in funzione della tensione $V$

In modo duale, ricavando la corrente come $overline(I) = overline(V) / overline(Z)$ (da cui il coniugato $overline(I)^* = overline(V)^* / overline(Z)^*$) e ricordando che $overline(V) overline(V)^* = |overline(V)|^2 = V^2$, la potenza complessa si esprime in funzione della tensione applicata:
// VERIFICA: sviluppo in funzione di V dedotto dal titolo della slide 27 e dalla tabella riassuntiva della slide 28

$ overline(S) = overline(V) overline(I)^* = overline(V) (overline(V)^* / overline(Z)^*) = V^2 / overline(Z)^* = V^2 / (R - j X) = (R + j X) / (R^2 + X^2) V^2 = R / Z^2 V^2 + j X / Z^2 V^2 $

Da cui si ricavano le espressioni duali per un'impedenza generica:

$ cases(
  P = R / Z^2 V^2 = G V^2,
  Q = X / Z^2 V^2 = -B V^2,
  S = V^2 / Z = Y V^2
) $
#pagebreak()


=== Tabella Riassuntiva dei Bipoli Elementari in Regime Sinusoidale

Nella tabella seguente sono riepilogate le relazioni fasoriali ed energetiche per il resistore, il condensatore, l'induttore e l'impedenza generica:

#align(center)[
  #table(
    columns: (2.8cm, 5cm, 2.5cm,3.2cm, auto),
    align: (center + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
    stroke: 0.5pt + gray,
    table.header(
      [*Bipolo*],
      [*Schema e Fasori*],
      [*Sfasamento* $phi$],
      [*Legge di Ohm \ fasoriale*],
      [*Potenza complessa* $overline(S) = overline(V) overline(I)^*$]
    ),

    // RIGA 1: RESISTORE
    [*Resistore* $R$],
    schema-fasoriale("R"),
    [$phi = 0$],
    [$overline(V) = R overline(I)$],
    [$overline(S) = R I^2 = V^2 / R  \ = P quad (#text(fill: red)[$>= 0$])$],

    // RIGA 2: CONDENSATORE
    [*Condensatore* $C$],
    schema-fasoriale("C"),
    [$phi = -pi / 2$],
    [$overline(V) = j X_C overline(I)$  \ con $X_C = -1 / (omega C)$],
    [$overline(S) = j X_C I^2  \= j V^2 / X_C = j Q_C quad (#text(fill: red)[$<= 0$])$],

    // RIGA 3: INDUTTORE
    [*Induttore* $L$],
    schema-fasoriale("L"),
    [$phi = pi / 2$],
    [$overline(V) = j X_L overline(I)$ \ con $X_L = omega L$],
    [$overline(S) = j X_L I^2 = j V^2 / X_L = j Q_L quad (#text(fill: red)[$>= 0$])$],

    // RIGA 4: IMPEDENZA
    [*Impedenza* $overline(Z)$],
    schema-fasoriale("Z"),
    [$-pi / 2 <= phi <= pi / 2$],
    [$overline(V) = overline(Z) dot overline(I)$],
    [$overline(S) = overline(Z) dot I^2 = V^2 / overline(Z)^* \  = P + j Q$]
  )
]


== Caratterizzazione di un Carico Industriale

Un carico industriale (così come un carico civile) è più convenientemente descritto dalla potenza assorbita ai morsetti, invece che dal valore della sua impedenza equivalente. Ciò è dovuto al fatto che, in generale, un utilizzatore elettrico è progettato per assorbire una determinata potenza quando viene alimentato a una specifica tensione di progetto, detta *tensione nominale*, alla quale corrisponde una *potenza nominale assorbita*.

#nota[
_[Illustrazione nelle slide: schema concettuale di un motore elettrico asincrono trifase alimentato dai flussi di potenza attiva $P$ e potenza reattiva $Q$ in ingresso ai morsetti.]_
]

Un carico in regime sinusoidale è pertanto compiutamente descritto dalle seguenti grandezze caratteristiche ai morsetti:

#grid(
  columns: (1.8fr, 1.2fr),
  column-gutter: 1.5em,
  align: (left + horizon, center + horizon),
  [
    + il valore efficace della tensione applicata $V$;
    + il valore efficace della corrente assorbita $I$;
    + la potenza attiva $P = V I cos phi$;
    + la potenza reattiva $Q = V I sin phi$;
    + la potenza apparente $S = sqrt(P^2 + Q^2) = V I$;
    + il fattore di potenza $cos phi$, legato allo sfasamento dalla relazione $phi = arctan(Q / P)$.
  ],
  [
    #canvas(length: 0.9cm, {
      import draw: *
      line((0, 0), (4, 0), (4, 3), close: true, stroke: 1.2pt + black)
      arc((1.2, 0), start: 0deg, stop: 36.87deg, radius: 1.2, mark: (end: "stealth", fill: black, scale: 0.8), stroke: 0.7pt + black)
      content((1.65, 0.55), $phi$)
      content((2, -0.45), $P$)
      content((4.45, 1.5), $Q$)
      content((1.65, 1.85), $S$)
    })
  ]
)

#nota[
Nota la tensione $V$ (o la corrente $I$), è sufficiente conoscere altre *due* grandezze qualsiasi ai morsetti (ad esempio la coppia $(P, cos phi)$ oppure $(P, Q)$) per ricavare univocamente tutte le altre mediante le relazioni trigonometriche del triangolo delle potenze.
]

// ==========================================
// SLIDE 31 - 45
// ==========================================

== Teorema di Boucherot e Bilancio delle Potenze

=== Relazioni tra Potenza Complessa, Attiva e Reattiva

A partire dalle componenti della potenza complessa $macron(S) = P + j Q$, è possibile ricavare l'angolo di sfasamento $varphi$ (e quindi il fattore di potenza) e il modulo della potenza apparente $S$:

$ varphi = tan^(-1) (Q / P) $

$ S = sqrt(P^2 + Q^2) = V I $

Note la potenza attiva $P$ e la potenza reattiva $Q$ assorbite da un bipolo (o da una sezione di rete), è possibile esprimere direttamente il valore efficace della corrente $I$ (nota la tensione $V$) oppure della tensione $V$ (nota la corrente $I$):

$ I = S / V = sqrt(P^2 + Q^2) / V = P / (V cos varphi) = P / (V cos (tan^(-1) (Q / P))) $

$ V = S / I = sqrt(P^2 + Q^2) / I $

=== Conservazione della Potenza Complessa (Teorema di Boucherot)

Lo studio dei flussi di potenza in regime sinusoidale si fonda sul *Teorema di Boucherot*, il quale esprime un'equazione di bilancio per la potenza attiva e per la potenza reattiva nelle reti elettriche. Tale teorema consente inoltre di risolvere in modo agevole i circuiti caratterizzati da una topologia semplice a flusso unidirezionale e mette in luce una problematica tipica dei sistemi di distribuzione industriale, risolvibile mediante la tecnica del *rifasamento*.

Data una rete elettrica operante in regime sinusoidale costituita da $N_"sou"$ componenti descritti con la convenzione dei generatori e da $N_"load"$ componenti descritti con la convenzione degli utilizzatori, vale l'equazione di bilancio della potenza complessa:

$ sum_(k = 1)^(N_"sou") macron(S)_k = sum_(n = 1)^(N_"load") macron(S)_n $

Esplicitando la potenza complessa di ciascun generatore come $macron(S)_k = P_k + j Q_k$ e quella di ciascun utilizzatore come $macron(S)_n = P_n + j Q_n$, la relazione di bilancio diventa:

$ sum_(k = 1)^(N_"sou") (P_k + j Q_k) = sum_(n = 1)^(N_"load") (P_n + j Q_n) $

Uguagliando separatamente le parti reali e le parti immaginarie dei due membri, si ottengono le due equazioni scalari di conservazione della potenza attiva e della potenza reattiva:

$ cases(
  display(sum_(k = 1)^(N_"sou") P_k = sum_(n = 1)^(N_"load") P_n),
  display(sum_(k = 1)^(N_"sou") Q_k = sum_(n = 1)^(N_"load") Q_n)
) $

#nota[
  Il teorema di Boucherot impone il bilanciamento separato delle potenze attive e reattive tra sorgenti e carichi. Mentre le potenze attive assorbite dai carichi passivi sono sempre positive, la potenza reattiva $Q_n$ può avere *segno positivo* (carico induttivo) oppure *segno negativo* (carico capacitivo). Di conseguenza, la sommatoria al secondo membro $sum_(n = 1)^(N_"load") Q_n$ può risultare uguale a zero (o ridursi sensibilmente) anche quando i singoli termini $Q_n$ sono diversi da zero.
]

=== Metodo di Soluzione Circuitale tramite il Bilancio di Potenza

Il teorema di Boucherot costituisce un efficace strumento di calcolo per la risoluzione di circuiti aventi una topologia a *"flusso unidirezionale"* (reti radiali), nei quali sono note le potenze assorbite dai carichi e la tensione ai loro morsetti.

Si consideri il circuito seguente, in cui un generatore alimenta due carichi in parallelo (di cui sono note le potenze attive e reattive $P_1, Q_1$ e $P_2, Q_2$ e il valore efficace della tensione comune $V$) attraverso una linea di trasmissione caratterizzata dall'impedenza longitudinale $macron(Z)_l = R_l + j X_l$:

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *
    set-style(resistor: (variant: "iec"), vsource: (variant: "iec"))

    // Generatore E
    vsource("e", (0, 0), (0, 3.2))
    content((-0.4, 2.5), sans("+", weight: "bold"))
    line((-0.6, 0.7), (-0.6, 2.5), mark: (end: "stealth", fill: black))
    content((-0.95, 1.6), $E$)

    // Ramo superiore e impedenza di linea Z_l
    wire((0, 3.2), (1.5, 3.2))
    line((0.5, 3.2), (1.0, 3.2), mark: (end: "stealth", fill: black))
    content((0.75, 3.55), $I$)

    resistor("zl", (1.5, 3.2), (3.8, 3.2), label: (content: $macron(Z)_l = R_l + j X_l$, anchor: "north", distance: 6pt))
    line((3.5, 3.2), (3.85, 3.2), mark: (end: "stealth", fill: red, stroke: red))

    wire((3.8, 3.2), (6.8, 3.2))
    wire((0, 0), (6.8, 0))

    // Sezione B
    line((1.5, 0), (1.5, 3.2), stroke: (dash: "dashed"))
    content((1.2, 0.4), $B$)
    content((1.0, -0.4), $macron(S)_"gen"$)
    content((2.05, -0.4), $macron(S)_"utl"$)
    bezier((1.0, -0.8), (1.5, -0.8), (1.25, -1.1))
    bezier((1.5, -0.8), (2.0, -0.8), (1.75, -0.5), mark: (end: "stealth", fill: black))

    // Sezione A
    line((3.6, -0), (3.6, 3.2), stroke: (dash: "dashed"))
    content((3.3, 0.4), $A$)
    bezier((3.1, 1.5), (3.6, 1.5), (3.35, 1.8))
    bezier((3.6, 1.5), (4.1, 1.5), (3.85, 1.2), mark: (end: "stealth", fill: black))
    content((4.65, 1.3), $macron(S)_"load"$)

    // Nodi verso il carico 2
    node("n1", (4.0, 3.2))
    node("n2", (5.6, 0))
    wire((4.0, 3.2), (4.0, -1.2))
    wire((5.6, 0), (5.6, -1.2))

    // Carico 2
    rect((3.5, -2.5), (6.1, -1.2))
    content((4.8, -1.85), sans("2", weight: "bold"))
    content((6.7, -1.55), $P_2$)
    content((6.7, -2.15), $Q_2$)

    // Tensione V nota
    line((6.0, 0.15), (6.0, 3.05), mark: (end: "stealth", fill: black))
    content((5.65, 1.6), $V$)

    // Carico 1
    rect((6.8, -0.3), (8.3, 3.5))
    content((7.55, 1.6), sans("1", weight: "bold"))
    content((8.9, 2.2), $P_1$)
    content((8.9, 1.2), $Q_1$)
    content((9.2, 3.3), text(fill: blue)[$V "nota"$])
  })
]

La procedura di risoluzione procede a ritroso dai carichi verso il generatore attraverso i seguenti passaggi:

1. *Bilancio alla sezione $A$ (a monte dei carichi):*
   Applicando il teorema di Boucherot alla sezione $A$, la potenza complessa totale richiesta dall'insieme dei carichi $macron(S)_"load"$ è data dalla somma delle potenze dei singoli utilizzatori:
   $ macron(S)_"load" = macron(S)_1 + macron(S)_2 arrow.r.double cases(
     P_"load" = P_1 + P_2,
     Q_"load" = Q_1 + Q_2
   ) $
   Essendo nota la tensione $V$ ai capi dei carichi, si ricava il valore efficace della corrente di linea $I$:
   $ I = S_"load" / V = sqrt(P_"load"^2 + Q_"load"^2) / V = P_"load" / (V cos varphi_"load") = P_"load" / (V cos (tan^(-1) (Q_"load" / P_"load"))) $

2. *Potenza impegnata sulla linea di trasmissione:*
   La potenza $macron(S)_"load"$ non è l'unica potenza che deve essere erogata dal generatore: procedendo verso la sezione $B$, occorre tenere conto anche della potenza assorbita dall'impedenza di linea $macron(Z)_l = R_l + j X_l$, la quale equivale alla serie di una resistenza $R_l$ e di una reattanza $X_l$:

   #grid(
     columns: (1fr, 1fr),
     column-gutter: 1.5em,
     align: (center + horizon, left + horizon),
     [
       #zap.circuit({
         
         import zap.cetz.draw: *

         // Modello compatto IEC
         resistor("zl", (0, 2.2), (3.6, 2.2), variant: "iec", n: "o-o", label: (content: $macron(Z)_l = R_l + j X_l$, anchor: "north", distance: 6pt))
         line((2.8, 2.2), (3.3, 2.2), mark: (end: "stealth", fill: blue, stroke: blue))
         content((3.05, 1.75), text(fill: blue)[$macron(I)$])
         wire((0, 1.2), (3.6, 1.2), n: "o-o")

         // Modello serie R_l - X_l IEEE
         resistor("rl", (0, 0), (1.8, 0), variant: "ieee", n: "o-", label: (content: $R_l$, anchor: "south", distance: 6pt))
         inductor("xl", (1.8, 0), (3.6, 0), variant: "ieee", n: "-o", label: (content: $X_l$, anchor: "south", distance: 6pt))
         wire((0, -1.0), (3.6, -1.0), n: "o-o")
       })
     ],
     [
       Nota la corrente $I$ che percorre la linea, la potenza complessa $macron(S)_l$ impegnata sulla linea vale:
       $ macron(S)_l = macron(Z)_l I^2 = R_l I^2 + j X_l I^2 $
       da cui si separano le perdite attive e la potenza reattiva di linea:
       $ cases(
         P_l = R_l I^2,
         Q_l = X_l I^2
       ) $
     ]
   )

3. *Bilancio alla sezione $B$ (ai morsetti del generatore):*
   Alla sezione $B$, l'intera rete a valle del generatore (linea più carichi) assorbe una potenza attiva $P_"sou"$ e una potenza reattiva $Q_"sou"$ pari alla somma dei contributi dei carichi e della linea:

   #grid(
     columns: (1fr, 1.3fr),
     column-gutter: 1.5em,
     align: (center + horizon, left + horizon),
     [
       #zap.circuit({
         
         import zap.cetz.draw: *
         set-style(vsource: (variant: "iec"))

         vsource("e", (0, 0), (0, 2.6))
         wire((0, 2.6), (1.8, 2.6), n: "-o")
         wire((0, 0), (1.8, 0), n: "-o")
         line((0.7, 2.6), (1.3, 2.6), mark: (end: "stealth", fill: red, stroke: red))
         content((1.0, 2.95), text(fill: red)[$I$])

         line((1.8, 0.2), (1.8, 2.4), mark: (end: "stealth", fill: blue, stroke: blue))
         content((1.4, 1.3), text(fill: blue)[$E$])

         wire((2.0, 2.6), (2.6, 2.6))
         wire((2.0, 0), (2.6, 0))
         rect((2.6, -0.3), (4.2, 2.9))
         content((3.4, 1.8), $P_"sou"$)
         content((3.4, 0.8), $Q_"sou"$)
       })
     ],
     [
       $ cases(
         P_"sou" = P_"load" + P_l,
         Q_"sou" = Q_"load" + Q_l
       ) $
       $ varphi_"sou" = tan^(-1) (Q_"sou" / P_"sou") $
       Dalla potenza erogata dal generatore $P_"sou" = E I cos varphi_"sou"$ (oppure dalla potenza apparente $S_"sou" = sqrt(P_"sou"^2 + Q_"sou"^2) = E I$) si determina infine il valore efficace della tensione di sorgente $E$:
       $ E = P_"sou" / (I cos varphi_"sou") = sqrt(P_"sou"^2 + Q_"sou"^2) / I $
     ]
   )

= Rendimento di Linea e Rifasamento

== Rendimento di una Linea di Trasmissione

Lo studio dei flussi di potenza mediante il teorema di Boucherot evidenzia il problema dell'efficienza con cui l'energia elettrica viene trasferita dai generatori agli utilizzatori attraverso le linee di distribuzione. Una linea di trasmissione può infatti essere modellata come un dispositivo che trasferisce potenza e al quale è associato un *rendimento di trasmissione* $eta$:

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *

    resistor("zl", (0, 1.8), (5.0, 1.8), variant: "iec", label: (content: $macron(Z)_l = R_l + j X_l$, anchor: "south", distance: 6pt))
    wire((0, 0), (5.0, 0))

    line((0.8, -0.4), (0.8, 2.3), stroke: (dash: "dashed"))
    line((4.2, -0.4), (4.2, 2.3), stroke: (dash: "dashed"))

    line((4.3, 2.05), (4.9, 2.05), mark: (end: "stealth", fill: black))
    content((4.6, 2.45), $macron(I)$)

    // Frecce sinuose P_in e P_out
    content((0.1, 0.9), $P_"in"$)
    bezier((0.5, 0.9), (0.8, 0.9), (0.65, 1.1))
    bezier((0.8, 0.9), (1.2, 0.9), (0.95, 0.7), mark: (end: "stealth", fill: black))

    bezier((3.8, 0.9), (4.1, 0.9), (3.95, 1.1))
    bezier((4.1, 0.9), (4.5, 0.9), (4.25, 0.7), mark: (end: "stealth", fill: black))
    content((5.0, 0.9), $P_"out"$)
  })
]

Indicando con $P_"in"$ la potenza attiva in ingresso alla linea, con $P_"out"$ la potenza attiva ceduta al carico in uscita e con $P_l = R_l I^2$ la potenza attiva dissipata per effetto Joule sulla resistenza di linea $R_l$, per il bilancio delle potenze attive si ha:

$ P_"in" = P_"out" + P_l $

Il rendimento della linea $eta$ è definito come il rapporto tra la potenza attiva utile in uscita e la potenza attiva totale in ingresso:

$ eta = P_"out" / P_"in" = P_"out" / (P_"out" + P_l) $

#nota[
  A parità di potenza attiva $P_"out"$ richiesta dal carico, una diminuzione delle perdite di linea $P_l$ comporta un aumento del rendimento $eta$ della linea di trasmissione.
]

== Importanza ed Effetti della Potenza Reattiva $Q$ sul Circuito

La presenza di una potenza reattiva $Q_"out"$ assorbita a valle della linea incrementa le perdite per effetto Joule nel circuito. Infatti, il valore efficace della corrente $I$ che attraversa la linea di trasmissione dipende sia dalla potenza attiva $P_"out"$ sia dalla potenza reattiva $Q_"out"$ assorbite dal carico alla tensione $V$:

$ I = sqrt(P_"out"^2 + Q_"out"^2) / V $

Esprimendo le perdite di linea $P_"line" = P_l = R_l I^2$ in funzione delle potenze trasmesse a valle, si ottiene:

$ P_"line" = R_l I^2 = R_l (P_"out"^2 + Q_"out"^2) / V^2 $

e il rendimento della linea assume l'espressione:

$ eta = P_"out" / (P_"out" + P_"line") = P_"out" / (P_"out" + R_l I^2) = P_"out" / (P_"out" + R_l display((P_"out"^2 + Q_"out"^2) / V^2)) $

#nota[
  A parità di potenza attiva $P_"out"$ trasferita a valle della linea e a parità di tensione di alimentazione $V$, le perdite di linea $P_"line"$ (e di conseguenza il rendimento $eta$) sono direttamente penalizzate dalla potenza reattiva $Q_"out"$.
]

Un classico esempio industriale di flusso di potenza reattiva riguarda il funzionamento dei *motori elettrici* (come i motori asincroni), i quali sono caratterizzati da una componente di potenza reattiva induttiva $Q > 0$ non trascurabile necessaria per la creazione del campo magnetico. La produzione locale di tale potenza reattiva mediante un *condensatore* collegato in prossimità del carico evita o riduce il transito della potenza reattiva lungo la linea di distribuzione.

== Principio del Rifasamento e Minimizzazione delle Perdite di Linea

La corretta gestione della linea di trasmissione deve mirare a minimizzare la corrente in transito sulla linea stessa, senza però alterare la potenza attiva $P$ trasmessa al carico ($P' = P$) né la sua tensione di alimentazione $V$.
#pagebreak()

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    *Carico non rifasato*
    #canvas({
      import draw: *
      // Freccia P e Q
      rect((0, 1.2), (2.8, 1.8), fill: luma(220), stroke: none)
      rect((0, 0.6), (2.8, 1.2), fill: luma(140), stroke: none)
      line((2.8, 1.8), (2.8, 2.2), (3.5, 1.2), (2.8, 0.2), (2.8, 0.6), fill: luma(180), stroke: gray)
      content((2.2, 1.5), sans("P", weight: "bold"))
      content((2.2, 0.9), text(fill: white, sans("Q", weight: "bold")))
      // Blocco motore stilizzato
      rect((3.6, 0.3), (5.2, 2.1), radius: 0.15)
      content((4.4, 1.2), sans("Motore", size: 9pt, weight: "bold"))
    })
  ],
  [
    *Triangolo delle potenze (non rifasato)*
    #canvas({
      import draw: *
      line((0, 0), (4.5, 0), stroke: 1pt + black)
      content((2.25, -0.35), $P$)
      line((4.5, 0), (4.5, 2.7), stroke: 1.2pt + blue)
      content((4.85, 1.35), text(fill: blue)[$Q$])
      line((0, 0), (4.5, 2.7), stroke: 1.2pt + blue)
      content((4.3, 2.95), text(fill: blue)[$S$])
      arc((1.3, 0), start: 0deg, stop: 31deg, radius: 1.3, stroke: blue, mark: (end: "stealth", fill: blue))
      content((1.6, 0.45), text(fill: blue)[$varphi$])
    })
  ]
)

Inserendo un condensatore $C$ a monte del carico (che assorbe una potenza reattiva negativa $Q_c < 0$, ovvero eroga localmente potenza reattiva induttiva al motore), la potenza reattiva $Q'$ richiesta alla linea si riduce:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    *Carico rifasato con condensatore*
    #canvas({
      import draw: *
      // Freccia P' = P e Q' + Qc = Q
      rect((0, 1.2), (2.8, 1.8), fill: luma(220), stroke: none)
      rect((0, 0.8), (2.8, 1.2), fill: luma(140), stroke: none)
      rect((1.6, 0.6), (2.8, 0.8), fill: luma(140), stroke: none)
      bezier((1.0, 0.0), (1.6, 0.7), (1.0, 0.7), stroke: 10pt + luma(140))
      line((2.8, 1.8), (2.8, 2.2), (3.5, 1.2), (2.8, 0.2), (2.8, 0.6), fill: luma(180), stroke: gray)

      content((0.4, 1.5), sans("P'", weight: "bold"))
      content((2.3, 1.5), sans("P", weight: "bold"))
      content((0.4, 1.0), text(fill: white, sans("Q'", size: 9pt, weight: "bold")))
      content((2.3, 0.9), text(fill: white, sans("Q", weight: "bold")))
      content((1.15, 0.3), text(fill: white, sans("Qc", size: 8pt, weight: "bold")))

      // Box condensatore
      rect((0.5, -0.7), (1.5, 0.0))
      line((0.65, -0.35), (0.93, -0.35), stroke: 1.2pt)
      line((0.93, -0.15), (0.93, -0.55), stroke: 1.2pt)
      line((1.07, -0.15), (1.07, -0.55), stroke: 1.2pt)
      line((1.07, -0.35), (1.35, -0.35), stroke: 1.2pt)

      // Blocco motore stilizzato
      rect((3.6, 0.3), (5.2, 2.1), radius: 0.15)
      content((4.4, 1.2), sans("Motore", size: 9pt, weight: "bold"))
    })
  ],
  [
    *Triangolo delle potenze (rifasato)*
    #canvas({
      import draw: *
      line((0, 0), (4.5, 0), stroke: 1pt + black)
      content((2.25, -0.35), $P$)

      // Cateto Q totale a destra
      line((4.65, 0), (4.65, 2.7), stroke: 1.2pt + blue)
      content((5.0, 1.6), text(fill: blue)[$Q$])

      // Cateto Qc (in arancione) e Q' (in verde)
      line((4.5, 0.9), (4.5, 2.7), stroke: 1.5pt + orange)
      content((4.15, 1.8), text(fill: orange)[$Q_c$])
      line((4.5, 0), (4.5, 0.9), stroke: 1.5pt + rgb("#2e7d32"))
      content((5.65, 0.45), text(fill: rgb("#2e7d32"))[$ quad Q' = Q + Q_c$])

      // Ipotenuse S e S'
      line((0, 0), (4.5, 2.7), stroke: 1.2pt + blue)
      content((4.3, 2.95), text(fill: blue)[$S$])
      line((0, 0), (4.5, 0.9), stroke: 1.2pt + rgb("#2e7d32"))
      content((3.9, 0.55), text(fill: rgb("#2e7d32"))[$S'$])

      // Archi phi e phi'
      arc((1.2, 0), start: 0deg, stop: 31deg, radius: 1.2, stroke: blue, mark: (end: "stealth", fill: blue))
      content((1.4, 0.5), text(fill: blue)[$varphi$])
      arc((1.8, 0), start: 0deg, stop: 11.3deg, radius: 1.8, stroke: rgb("#2e7d32"), mark: (end: "stealth", fill: rgb("#2e7d32")))
      content((2.15, 0.22), text(fill: rgb("#2e7d32"))[$varphi'$])
      content((5.3, 2.4), $varphi' < varphi$)
    })
  ]
)

Il condensatore viene collegato *in parallelo* al carico, in modo da essere sottoposto alla medesima tensione $V$ senza alterare la tensione di alimentazione del carico stesso:

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *
    set-style(resistor: (variant: "iec"), vsource: (variant: "iec"))

    vsource("e", (0, 0), (0, 2.8))
    content((-0.35, 2.1), sans("+", weight: "bold"))
    wire((0, 2.8), (1.2, 2.8), n: "-o")
    wire((0, 0), (1.2, 0), n: "-o")

    resistor("zl", (1.2, 2.8), (3.4, 2.8), label: (content: $macron(Z)_l = R_l + j X_l$, anchor: "north", distance: 6pt))
    wire((3.4, 2.8), (4.8, 2.8), n: "-o")
    wire((1.2, 0), (4.8, 0), n: "-o")

    line((3.5, 2.8), (4.0, 2.8), mark: (end: "stealth", fill: red, stroke: red))
    content((3.75, 2.35), text(fill: red)[$I'$])

    // Condensatore C in parallelo prima dei morsetti del carico
    capacitor("c", (4.2, 2.8), (4.2, 0), n: "*-*", label: (content: text(fill: red)[$ thin med thin  C$], anchor: "east", distance: 6pt))

    // Flusso P, Q' prima di C
    content((3.1, 2.0), $P$)
    content((3.1, 0.8), $Q'$)
    bezier((2.7, 1.4), (3.0, 1.4), (2.85, 1.6))
    bezier((3.0, 1.4), (3.4, 1.4), (3.15, 1.2), mark: (end: "stealth", fill: black))

    // Tensione V e corrente I verso il carico
    line((5.0, 0.2), (5.0, 2.6), mark: (end: "stealth", fill: blue, stroke: blue))
    content((5.3, 2), text(fill: blue)[$V$])

    wire((4.8, 2.8), (6.5, 2.8))
    wire((4.8, 0), (6.5, 0))
    line((5.4, 2.8), (6.0, 2.8), mark: (end: "stealth", fill: red, stroke: red))
    content((5.7, 3.2), text(fill: red)[$I$])

    content((5.7, 2.0), $P$)
    content((5.7, 0.8), $Q$)
    bezier((5.2, 1.4), (5.5, 1.4), (5.35, 1.6))
    bezier((5.5, 1.4), (5.9, 1.4), (5.65, 1.2), mark: (end: "stealth", fill: black))

    rect((6.5, -0.3), (8.0, 3.1))
    content((7.25, 1.9), $P_"load"$)
    content((7.25, 0.9), $Q_"load"$)
  })
]

Confrontiamo infine analiticamente il funzionamento del sistema prima e dopo l'inserimento della capacità di rifasamento $C$, considerando una linea con impedenza $macron(Z)_"linea" = R_"linea" + j X_"linea"$:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    *Senza condensatore di rifasamento*
    #zap.circuit({
      
      import zap.cetz.draw: *

      resistor("zl", (0, 2.4), (3.0, 2.4), variant: "iec", n: "o-", label: (content: $macron(Z)_"linea"$, anchor: "south", distance: 6pt))
      wire((3.0, 2.4), (5.2, 2.4))
      wire((0, 0), (5.2, 0), n: "o-")

      line((3.8, 2.4), (4.3, 2.4), mark: (end: "stealth", fill: black))
      content((4.05, 2.0), $I$)

      line((4.7, 0.2), (4.7, 2.2), mark: (end: "stealth", fill: black))
      content((5.0, 1.2), $V$)

      rect((5.2, -0.3), (6.6, 2.7))
      content((5.9, 1.55), $P$)
      content((5.9, 0.85), $Q$)
    })

    $ I = S / V = sqrt(P^2 + Q^2) / V $
    $ P_"linea" = R_"linea" I^2 = R_"linea" (P^2 + Q^2) / V^2 $
  ],
  [
    *Con condensatore di rifasamento in parallelo*
    #zap.circuit({
      
      import zap.cetz.draw: *

      resistor("zl", (0, 2.4), (2.6, 2.4), variant: "iec", n: "o-", label: (content: $macron(Z)_"linea"$, anchor: "south", distance: 6pt))
      wire((2.6, 2.4), (5.2, 2.4))
      wire((0, 0), (5.2, 0), n: "o-")

      line((2.6, 2.4), (3.0, 2.4), mark: (end: "stealth", fill: black))
      content((2.8, 2.75), $I'$)

      capacitor("c", (3.2, 2.4), (3.2, 0), label: (content: $C$, anchor: "north", distance: 6pt))
      line((3.2, 0.7), (3.2, 0.35), mark: (end: "stealth", fill: black))
      content((3.6, 0.5), $I_c$)

      line((3.9, 2.4), (4.4, 2.4), mark: (end: "stealth", fill: black))
      content((4.15, 2.0), $I$)

      line((4.7, 0.2), (4.7, 2.2), mark: (end: "stealth", fill: black))
      content((5.0, 1.2), $V$)

      rect((5.2, -0.3), (6.6, 2.7))
      content((5.9, 1.55), $P$)
      content((5.9, 0.85), $Q$)
    })

    $ I' = S' / V = sqrt(P^2 + Q'^2) / V < I $
    $ P'_"linea" = R_"linea" I'^2 = R_"linea" (P^2 + Q'^2) / V^2 < P_"linea" $
  ]
)

Poiché il condensatore non assorbe potenza attiva ($P_c = 0$) e assorbe una potenza reattiva $Q_c < 0$, la potenza reattiva complessiva che transita sulla linea si riduce a:

$ Q' = Q + Q_c < Q $

Di conseguenza diminuiscono la corrente di linea ($I' < I$) e le perdite per effetto Joule ($P'_"linea" < P_"linea"$), determinando un incremento del rendimento di trasmissione:

$ eta' = P / (P + P'_"linea") > eta = P / (P + P_"linea") $

// ==========================================
// SLIDE 46 - 52
// ==========================================

== Rifasamento mediante condensatore in parallelo

Per ridurre gli effetti negativi legati all'assorbimento di potenza reattiva induttiva da parte dell'utenza, si ricorre all'operazione di *rifasamento*, che consiste nel connettere un condensatore di capacità $C$ in parallelo al carico utilizzatore $macron(Z)_U$.

#grid(
  columns: (1.1fr, 0.9fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *

      // Impedenza di linea
      resistor("zl", (0.5, 3), (3, 3), variant: "iec", label: (content: $macron(Z)_"l"$, anchor: "south", distance: 6pt))
      wire((0, 3), (0.5, 3))
      
      // Freccia corrente I'
      line((0.1, 3.35), (0.9, 3.35), mark: (end: "stealth", fill: black))
      content((0.5, 3.8), $macron(I)'$)

      // Nodo superiore e inferiore del condensatore
      node("n1", (3.8, 3))
      node("n2", (3.8, 0))
      wire((3, 3), (6.5, 3))
      wire((0, 0), (6.5, 0))

      // Condensatore in parallelo
      capacitor("c", (3.8, 3), (3.8, 0), label: (content: $C$, anchor: "north", distance: 8pt))
      line((4.1, 2.7), (4.1, 1.9), mark: (end: "stealth", fill: black))
      content((4.55, 2.3), $macron(I)_C$)

      // Carico utilizzatore
      resistor("zu", (6.5, 3), (6.5, 0), variant: "iec", label: (content: $macron(Z)_U$, anchor: "north", distance: 6pt))
      line((6.8, 2.8), (6.8, 2.0), mark: (end: "stealth", fill: black))
      content((7.15, 2.4), $macron(I)$)

      // Freccia curva di tensione V
      bezier((5.8, 0.6), (5.8, 2.4), (5.4, 1.5), mark: (end: "stealth", fill: black))
      content((5.2, 1.5), $macron(V)$)
    })
  ],
  [
    #canvas({
      import draw: *

      // Origine
      let O = (0, 0)
      
      // Vettore V (orizzontale)
      line(O, (4.2, 0), stroke: 1.2pt, mark: (end: "stealth", fill: black))
      content((4.4, 0.35), $macron(V)$)

      // Vettore Ic sull'origine
      line(O, (0, 1.5), stroke: 1.2pt, mark: (end: "stealth", fill: black))
      content((0.65, 0.8), $macron(I)_C$)

      // Vettore I (carico non rifasato)
      let I_end = (2.6, -2.8)
      line(O, I_end, stroke: 1.2pt, mark: (end: "stealth", fill: black))
      content((1.3, -2.3), $macron(I)$)

      // Vettore Ic applicato sulla punta di I
      let Ip_end = (2.6, -1.3)
      line(I_end, Ip_end, stroke: 1.2pt, mark: (end: "stealth", fill: black))
      content((3.15, -2.05), $macron(I)_C$)

      // Vettore I' risultante
      line(O, Ip_end, stroke: (paint: blue, thickness: 1.4pt), mark: (end: "stealth", fill: blue))
      content((2.9, -0.85), $macron(I)'$)

      // Archi angoli phi e phi'
      arc((1.3, 0), start: 0deg, stop: -47deg, radius: 1.3, stroke: (paint: red, thickness: 1pt), mark: (end: "stealth", fill: red))
      content((1.4, -1.05), $phi$)

      arc((1.8, 0), start: 0deg, stop: -26.5deg, radius: 1.8, stroke: (paint: blue, thickness: 1pt), mark: (end: "stealth", fill: blue))
      content((2.15, -0.5), $phi'$)
    })
  ]
)

Applicando la legge di Kirchhoff delle correnti al nodo a monte del carico ed effettuando il bilancio energetico, si osservano due effetti fondamentali:
- *Bilancio delle potenze reattive*: per il teorema di Boucherot, la potenza reattiva complessiva $Q'$ richiesta a monte del condensatore è data dalla somma algebrica
  $ Q' = Q + Q_C $
- *Bilancio delle correnti*: la corrente di linea dopo il rifasamento è pari a
  $ macron(I)' = macron(I) + macron(I)_C $
  Come evidenziato dal diagramma fasoriale, la corrente capacitiva $macron(I)_C$ (in quadratura in anticipo rispetto alla tensione $macron(V)$) compensa parzialmente la componente in quadratura in ritardo della corrente del carico $macron(I)$. Di conseguenza, a parità di potenza attiva trasferita all'utilizzatore, si ottiene una riduzione sia dell'angolo di sfasamento sia del valore efficace della corrente di linea:
  $ |macron(I)'| < |macron(I)|, quad phi' < phi $

Poiché la linea di trasmissione è caratterizzata da una propria impedenza $macron(Z)_"l" = R_"l" + j X_"l"$, la diminuzione del modulo della corrente da $I$ a $I'$ riduce sensibilmente le perdite di potenza attiva per effetto Joule e l'impegno di potenza reattiva sulla linea stessa:
$ P_"l" = R_"l" I'^2, quad Q_"l" = X_"l" I'^2 $ // VERIFICA: dedotto dall'equazione

=== Calcolo della capacità di rifasamento

La potenza reattiva assorbita dal condensatore è negativa ($Q_C < 0$) e compensa quella positiva ($Q > 0$) assorbita dal carico induttivo. Nella pratica ingegneristica, una compensazione totale ($Q_C = -Q$, ovvero $phi' = 0$) non è quasi mai necessaria: è sufficiente ridurre l'angolo di sfasamento da $phi$ a un valore obiettivo $phi'$ tale da garantire un prefissato fattore di potenza $cos phi'$.

Il problema del dimensionamento del condensatore di rifasamento si formula pertanto come segue: noti il valore efficace della tensione di alimentazione $V$, la potenza attiva $P$ e la potenza reattiva $Q$ assorbite dal carico (oppure il suo fattore di potenza iniziale $cos phi$), determinare la capacità $C$ necessaria affinché il complesso carico-condensatore presenti un fattore di potenza pari a $cos phi'$.

#grid(
  columns: (1fr, 1.1fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #canvas({
      import draw: *

      let O = (0, 0)
      let B = (4.5, 0)
      let T_old = (4.5, 3.4)
      let T_new = (4.5, 1.3)

      // Base P
      line(O, B, stroke: 1.2pt)
      content((2.25, -0.4), $P$)

      // Ipotenusa S (blu)
      line(O, T_old, stroke: (paint: blue, thickness: 1.2pt))
      content((4.2, 3.65), text(fill: blue)[$S$])

      // Ipotenusa S' (verde)
      line(O, T_new, stroke: (paint: rgb("#2e7d32"), thickness: 1.2pt))
      content((4.1, 0.85), text(fill: rgb("#2e7d32"))[$S'$])

      // Cateto verticale Q' (verde)
      line(B, T_new, stroke: (paint: rgb("#2e7d32"), thickness: 1.5pt))
      content((5.55, 0.65), text(fill: rgb("#2e7d32"))[$quad quad Q' = Q + Q_C$])

      // Segmento Qc (arancione)
      line(T_new, T_old, stroke: (paint: rgb("#d97706"), thickness: 2pt))
      content((4.15, 2.35), text(fill: rgb("#d97706"))[$Q_C$])

      // Linea di quota totale Q (blu)
      line((4.65, 0), (4.65, 3.4), stroke: (paint: blue, thickness: 1pt))
      content((4.95, 1.8), text(fill: blue)[$Q$])

      // Archi angoli
      arc((1.5, 0), start: 0deg, stop: 37deg, radius: 1.5, stroke: (paint: blue, thickness: 0.9pt), mark: (end: "stealth", fill: blue))
      content((1.7, 0.75), text(fill: blue)[$phi$])

      arc((2.1, 0), start: 0deg, stop: 16.1deg, radius: 2.1, stroke: (paint: rgb("#2e7d32"), thickness: 0.9pt), mark: (end: "stealth", fill: rgb("#2e7d32")))
      content((2.45, 0.32), text(fill: rgb("#2e7d32"))[$phi'$])
    })
  ],
  [
    #zap.circuit({
      
      import zap.cetz.draw: *

      // Impedenza di linea
      resistor("zl", (0.5, 3), (2.5, 3), variant: "iec", label: (content: $macron(Z)_"l"$, anchor: "south", distance: 6pt))
      wire((0, 3), (0.5, 3))
      
      // Corrente I'
      line((0.1, 3.35), (0.8, 3.35), mark: (end: "stealth", fill: black))
      content((0.45, 3.8), $macron(I)'$)

      // Fili principali e nodi
      node("n1", (4.2, 3))
      node("n2", (4.2, 0))
      wire((2.5, 3), (6.8, 3))
      wire((0, 0), (6.8, 0))

      // Sezioni tratteggiate per il bilancio di Boucherot
      line((3.1, -0.5), (3.1, 3.6), stroke: (dash: "dashed", thickness: 0.8pt))
      line((2.7, -0.4), (3.5, -0.4), mark: (end: "stealth", fill: black), stroke: 1.2pt)
      content((3.1, -0.9), $P', Q'$)

      line((5.3, -0.5), (5.3, 3.6), stroke: (dash: "dashed", thickness: 0.8pt))
      line((4.9, -0.4), (5.7, -0.4), mark: (end: "stealth", fill: black), stroke: 1.2pt)
      content((5.3, -0.9), $P, Q$)

      // Condensatore
      capacitor("c", (4.2, 3), (4.2, 0), label: (content: $C$, anchor: "south", distance: 8pt))
      line((4.5, 2.7), (4.5, 1.9), mark: (end: "stealth", fill: black))
      content((4.9, 2.3), $macron(I)_C$)

      // Carico
      resistor("zu", (6.8, 3), (6.8, 0), variant: "iec", label: (content: $macron(Z)_U$, anchor: "west", distance: 6pt))
      line((7.1, 2.8), (7.1, 2.0), mark: (end: "stealth", fill: black))
      content((7.45, 2.4), $macron(I)$)

      // Tensione V
      bezier((6.1, 0.6), (6.1, 2.4), (5.7, 1.5), mark: (end: "stealth", fill: black))
      content((5.5, 1.5), $macron(V)$)
    })
  ]
)

Applicando il teorema di Boucherot alle sezioni a monte e a valle del condensatore (avendo supposto il condensatore ideale, ossia privo di dissipazione attiva $P_C = 0$), il sistema di equazioni di bilancio risulta:
$ cases(
  P' = P,
  Q' = Q + Q_C,
  tan phi' = display(Q' / P')
) quad ==> quad Q' = P' tan phi' = P tan phi' quad ==> quad Q + Q_C = P tan phi' $

Esplicitando la potenza reattiva $Q_C$ che deve essere fornita dal condensatore e ricordando che per il carico non rifasato vale $Q = P tan phi$, si ottiene:
$ Q_C = P tan phi' - Q = P tan phi' - P tan phi = P (tan phi' - tan phi) $

D'altra parte, la potenza reattiva assorbita da un condensatore di capacità $C$ sottoposto alla tensione efficace $V$ alla pulsazione $omega = 2 pi f$ (con sfasamento tensione-corrente pari a $phi_C = -pi / 2$) vale:
$ Q_C = V I_C sin(- pi / 2) = V (omega C V) (-1) = - omega C V^2 $

Uguagliando le due espressioni di $Q_C$, si ricava la formula di progetto per la capacità di rifasamento:
$ - omega C V^2 = P (tan phi' - tan phi) quad ==> quad C = frac(P (tan phi - tan phi'), omega V^2) $

#nota[
  Se nei dati del problema sono assegnati i fattori di potenza iniziale $cos phi$ e finale $cos phi'$, gli angoli corrispondenti si determinano mediante la funzione inversa:
  $ phi = arccos(cos phi), quad phi' = arccos(cos phi') $
  Nei sistemi industriali, qualora l'assorbimento del carico vari nel tempo, anziché impiegare un unico condensatore fisso si utilizza una *batteria di condensatori* in parallelo inseribili tramite interruttori, così da modulare a gradini la capacità complessiva collegata alla rete.
]

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *

    wire((0, 3), (6, 3))
    wire((0, 0), (6, 0))

    // Ramo 1
    node("n1t", (1.5, 3))
    node("n1b", (1.5, 0))
    switch("sw1", (1.5, 3), (1.5, 1.8), closed: false)
    capacitor("c1", (1.5, 1.8), (1.5, 0), label: (content: $C$, anchor: "north", distance: 6pt))

    // Ramo 2
    node("n2t", (3.2, 3))
    node("n2b", (3.2, 0))
    switch("sw2", (3.2, 3), (3.2, 1.8), closed: false)
    capacitor("c2", (3.2, 1.8), (3.2, 0), label: (content: $C$, anchor: "north", distance: 6pt))

    // Ramo 3
    node("n3t", (4.9, 3))
    node("n3b", (4.9, 0))
    switch("sw3", (4.9, 3), (4.9, 1.8), closed: false)
    capacitor("c3", (4.9, 1.8), (4.9, 0), label: (content: $C$, anchor: "north", distance: 6pt))
  })
]

=== Scelta del fattore di potenza obiettivo e aspetti normativi

Il valore obiettivo del fattore di potenza rifasato $cos phi'$ non è fissato in base ai valori istantanei delle potenze, bensì in relazione alle grandezze energetiche integrate sull'intero periodo di fatturazione $T$:
- *Energia attiva* (misurata in chilowattora, $"kWh"$):
  $ W_P = integral_T P dif t $
- *Energia reattiva* (misurata in chilovarora, $"kvarh"$):
  $ W_Q = integral_T Q dif t $

A partire dal 2016, in recepimento della Direttiva Europea 2012/27/UE sull'efficienza energetica (attuata in Italia tramite la Delibera AEEG 180/2013/R/EEL), l'energia reattiva viene fornita gratuitamente dal distributore senza applicazione di penali economiche se il fattore di potenza medio è almeno pari a:
$ cos phi' >= 0.95 quad <==> quad frac(W_Q, W_P) = tan phi' <= 0.33 $

#nota[
  La normativa prescrive inoltre che *in nessun caso l'utente possa immettere potenza reattiva capacitiva nella linea di distribuzione* (divieto di sovracompensazione, ovvero deve essere sempre $Q' >= 0$). Per evitare che una batteria di condensatori rimanga inserita a vuoto quando i carichi induttivi sono spenti, negli impianti con più macchine utilizzatrici (ad esempio motori asincroni $M$) si adotta frequentemente il *rifasamento distribuito*, collegando un condensatore dedicato direttamente ai morsetti di ciascun motore.
]

#align(center)[
  #zap.circuit({
    
    import zap.cetz.draw: *

    // Impedenza di linea a monte
    wire((0, 3), (1.2, 3))
    resistor("zl", (1.2, 3), (3.2, 3), variant: "iec", label: (content: $macron(Z)_"l"$, anchor: "south", distance: 6pt))
    wire((3.2, 3), (10.2, 3))
    wire((0, 0), (10.2, 0))

    // Gruppo Motore 1 + Condensatore 1
    node("g1a", (4.5, 3))
    node("g1b", (4.5, 0))
    capacitor("c1", (4.5, 3), (4.5, 0), label: (content: $C_1$, anchor: "south", distance: 2pt))
    node("m1a", (5.6, 3))
    node("m1b", (5.6, 0))
    wire((5.6, 3), (5.6, 2.0))
    wire((5.6, 1.0), (5.6, 0))
    circle((5.6, 1.5), radius: 0.5, fill: white, stroke: 1pt)
    content((5.6, 1.5), sans("M", weight: "bold"))

    // Gruppo Motore 2 + Condensatore 2
    node("g2a", (7.0, 3))
    node("g2b", (7.0, 0))
    capacitor("c2", (7.0, 3), (7.0, 0), label: (content: $C_2$, anchor: "south", distance: 2pt))
    node("m2a", (8.1, 3))
    node("m2b", (8.1, 0))
    wire((8.1, 3), (8.1, 2.0))
    wire((8.1, 1.0), (8.1, 0))
    circle((8.1, 1.5), radius: 0.5, fill: white, stroke: 1pt)
    content((8.1, 1.5), sans("M", weight: "bold"))

    // Gruppo Motore 3 + Condensatore 3
    node("g3a", (9.4, 3))
    node("g3b", (9.4, 0))
    capacitor("c3", (9.4, 3), (9.4, 0), label: (content: $C_3$, anchor: "south", distance: 1pt))
    wire((10.2, 3), (10.5, 3))
    wire((10.2, 0), (10.5, 0))
    wire((10.5, 3), (10.5, 2.0))
    wire((10.5, 1.0), (10.5, 0))
    circle((10.5, 1.5), radius: 0.5, fill: white, stroke: 1pt)
    content((10.5, 1.5), sans("M", weight: "bold"))
  })
]