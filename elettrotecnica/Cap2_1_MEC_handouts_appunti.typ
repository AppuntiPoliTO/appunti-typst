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


= Fenomeni transitori ed evoluzione nel tempo

== Dinamica dei circuiti ed equazioni differenziali (ODE)

Nello studio dei circuiti elettrici, il tempo rappresenta una dimensione fondamentale che distingue il comportamento delle reti puramente resistive da quello delle reti contenenti elementi dotati di memoria:

- Le *reti resistive* rispondono istantaneamente a qualsiasi ingresso applicato: la risposta in un dato istante è completamente indipendente da quella dell'istante precedente. Questo comportamento *adinamico* è dovuto alla natura puramente algebrica dell'equazione costitutiva del resistore, che lega tra loro variabili circuitali valutate nel medesimo istante:
  $ v(t) = R i(t) $

- Se il circuito contiene anche *condensatori* e *induttori*, il comportamento non è più adinamico. I termini derivativi $d / (d t)$ presenti nelle loro equazioni costitutive (adottando la convenzione degli utilizzatori):
  // VERIFICA: equazioni costitutive complete ricostruite dai frammenti OCR della Slide 3
  $ i_C (t) = C (d v_C (t)) / (d t), quad v_L (t) = L (d i_L (t)) / (d t) $
  risentono della velocità di variazione delle grandezze elettriche; di conseguenza, la risposta del circuito è *dinamica*.

L'insieme delle relazioni utilizzate per risolvere un circuito dinamico è identico a quello impiegato per le reti resistive (equazioni costitutive dei componenti unite alle leggi di Kirchhoff, LKC e LKT), ma il sistema finale risultante è costituito da *equazioni differenziali ordinarie* (*ODE*).

#nota[
Si può dimostrare che un circuito lineare tempo-invariante (LTI) dà sempre luogo a *equazioni differenziali ordinarie lineari a coefficienti costanti*. Tra le diverse classi di ODE, queste equazioni sono le uniche a possedere un metodo analitico standard di soluzione.
]

La soluzione generale di un'ODE lineare a coefficienti costanti si ottiene sommando due contributi distinti:
1. *Soluzione omogenea* (o *risposta naturale*), che dipende dalla struttura interna del circuito.
2. *Soluzione particolare* (o *risposta forzata*), legata alla forma degli ingressi applicati a regime.

=== Equazione differenziale generica del primo ordine

Consideriamo un circuito dinamico del primo ordine (contenente un solo elemento di accumulo energetico, condensatore o induttore), descritto nella generica grandezza circuitale $x(t)$ dal seguente problema di Cauchy a coefficienti costanti:

// VERIFICA: sistema differenziale e passaggi algebrici ricostruiti dalla struttura matematica standard della Slide 5
$ cases(
  tau (d x(t)) / (d t) + x(t) = x_infinity,
  x(0^+) = x_0
) $

dove $tau$ rappresenta la *costante di tempo* del circuito, $x_0$ il valore iniziale all'istante $t = 0^+$ e $x_infinity$ il valore a regime (per $t -> infinity$).

- *Soluzione omogenea*: risolve l'equazione omogenea associata $tau (d x_"om") / (d t) + x_"om" = 0$ ed è esprimibile nella forma esponenziale:
  $ x_"om" (t) = K e^(- t / tau) $

- *Soluzione particolare*: per un termine noto costante $x_infinity$, l'integrale particolare coincide con il valore di regime stazionario:
  $ x_p (t) = x_infinity $

- *Integrale complessivo*: sommando i due contributi e imponendo la condizione iniziale $x(0^+) = x_0$ (da cui si ricava la costante di integrazione $K = x_0 - x_infinity$), si ottiene l'espressione completa dell'evoluzione temporale:
  $ x(t) = x_"om" (t) + x_p (t) = (x_0 - x_infinity) e^(- t / tau) + x_infinity = x_0 e^(- t / tau) + x_infinity (1 - e^(- t / tau)) $

=== Durata del fenomeno transitorio

Teoricamente l'esponenziale $e^(- t / tau)$ si annulla solo per $t -> infinity$; tuttavia, dal punto di vista ingegneristico, dopo un intervallo di tempo pari a $4 tau div 5 tau$ la grandezza $x(t)$ ha praticamente raggiunto il valore di regime $x_infinity$ e il fenomeno transitorio si considera esaurito.

#grid(
  columns: (1fr, 1.6fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #table(
      columns: (auto, auto),
      align: (center, center),
      stroke: 0.5pt,
      table.header([*Tempo ($t$)*], [*Valore $x(t)$*]),
      [$0$], [$x_0$],
      [$4 tau$], [$approx x_infinity$ ($98 %$)],
      [$5 tau$], [$approx x_infinity$ ($99 %$)],
    )
  ],
  [
    #canvas({
      import draw: *
      
      // Griglia di sfondo leggera
      for y in (0.6, 1.2, 1.8, 2.4) {
        line((0, y), (6.5, y), stroke: (paint: luma(220), thickness: 0.5pt))
      }
      
      // Assi cartesiani
      line((0, 0), (6.8, 0), mark: (end: "stealth", fill: black), stroke: 0.8pt)
      content((7.1, 0), $t$)
      line((0, 0), (0, 3.1), mark: (end: "stealth", fill: black), stroke: 0.8pt)
      content((0, 3.4), $x$)
      
      // Linee tratteggiate per x_0 e x_inf
      line((0, 0.6), (1.2, 0.6), stroke: (dash: "dashed", thickness: 0.7pt))
      content((-0.4, 0.6), $x_0$)
      
      line((0, 2.4), (6.5, 2.4), stroke: (dash: "dashed", thickness: 0.7pt))
      content((-0.45, 2.4), $x_infinity$)
      
      // Etichette asse tempi (1 unità = 1 tau)
      content((1.2, -0.3), $tau$)
      content((2.4, -0.3), $2 tau$)
      content((3.6, -0.3), $3 tau$)
      content((4.8, -0.3), $4 tau$)
      content((6.0, -0.3), $5 tau$)
      
      // Tratteggi verticali a 4 tau e 5 tau
      line((4.8, 0), (4.8, 2.367), stroke: (dash: "dashed", thickness: 0.7pt))
      content((4.4, 1.2), sans("98%", size: 9pt))
      
      line((6.0, 0), (6.0, 2.388), stroke: (dash: "dashed", thickness: 0.7pt))
      content((6.45, 1.2), sans("99%", size: 9pt))
      
      // Curva esponenziale x(t) = x_0 + (x_inf - x_0)*(1 - e^(-t/tau))
      let pts = ()
      for i in range(0, 66) {
        let t_val = i * 0.1
        let tau_scale = 1.2
        let y_val = 0.6 + (2.4 - 0.6) * (1.0 - calc.exp(-t_val / tau_scale))
        pts.push((t_val, y_val))
      }
      line(..pts, stroke: (paint: red, thickness: 1.5pt))
      
      // Pallini sui punti a 4 tau e 5 tau
      circle((4.8, 2.367), radius: 1.5pt, fill: black)
      circle((6.0, 2.388), radius: 1.5pt, fill: black)
    })
  ]
)

A titolo di esempio, supponendo $x_0 = 0$, calcoliamo l'istante $t^*$ in cui la risposta raggiunge il $98 %$ del valore asintotico ($x(t^*) = 0.98 x_infinity$):
// VERIFICA: passaggi algebrici con logaritmo naturale dedotti dalla Slide 6
$ 0.98 x_infinity = x_infinity (1 - e^(- t^* / tau)) arrow.r.double e^(- t^* / tau) = 0.02 arrow.r.double t^* = - tau ln(0.02) approx 3.91 tau approx 4 tau $

== Circuiti con interruttori

Un ingresso variabile nel tempo a gradino può essere realizzato connettendo un generatore costante (di tensione o di corrente) al resto della rete mediante un *interruttore*.

- Un *interruttore* è un componente ideale a due terminali che commuta istantaneamente tra lo stato di *circuito aperto* ($i = 0$) e quello di *corto circuito* ($v = 0$).
- Convenzionalmente, l'istante di manovra del interruttore viene assunto come origine dei tempi ($t = 0$). Per distinguere le grandezze immediatamente prima e immediatamente dopo la commutazione, si introducono gli istanti $t = 0^-$ (istante che precede la manovra) e $t = 0^+$ (istante immediatamente successivo alla manovra).

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      
      vsource("e", (0, 0), (0, 2.8), variant: "iec", label: (content: $E$, anchor: "north", distance: 6pt))
      content((-0.25, 2.1), sans("+", weight: "bold"))
      
      wire((0, 2.8), (0.8, 2.8))
      // interruttore che si chiude a t = 0
      line((0.8, 2.8), (1.9, 3.2), stroke: 0.8pt)
      bezier((1.2, 3.3), (1.4, 2.65), (1.35, 3.0), mark: (end: "stealth", fill: black), stroke: 0.6pt)
      content((1.65, 2.25), $t = 0$)
      
      wire((1.9, 2.8), (2.7, 2.8))
      wire((0, 0), (2.7, 0))
      
      node("P", (2.7, 2.8), fill: false, label: (content: sans("P"), anchor: "south", distance: 4pt))
      node("Q", (2.7, 0), fill: false, label: (content: sans("Q"), anchor: "north", distance: 4pt))
      
      // Freccia di tensione tra Q e P
      bezier((2.9, 0.2), (2.9, 2.6), (3.3, 1.4), mark: (end: "stealth", fill: black), stroke: 0.6pt)
    })
  ],
  [
    #canvas({
      import draw: *
      
      // Assi
      line((-1.2, 0), (3.5, 0), mark: (end: "stealth", fill: black), stroke: 0.7pt)
      content((3.4, -0.35), $t$)
      line((0, -0.6), (0, 2.6), mark: (end: "stealth", fill: black), stroke: 0.7pt)
      content((0.55, 2.5), $e(t)$)
      
      // Gradino di tensione e(t)
      line((-1.0, 0), (0, 0), stroke: 1.3pt)
      line((0, 1.5), (3.2, 1.5), stroke: 1.3pt)
      content((-0.3, 1.5), $E$)
      
      // Indicazione istanti 0^- e 0^+
      content((0, -0.45), $0$)
      line((-0.7, -0.2), (-0.15, -0.2), mark: (end: "stealth", fill: black), stroke: 0.7pt)
      content((-0.5, -0.5), $0^-$)
      line((0.7, -0.2), (0.15, -0.2), mark: (end: "stealth", fill: black), stroke: 0.7pt)
      content((0.5, -0.5), $0^+$)
    })
  ]
)

== Studio del circuito RC con interruttore

Consideriamo un circuito costituito da un resistore $R$ e da un condensatore $C$ connessi in parallelo, alimentati da un generatore ideale di corrente costante $A$ attraverso un interruttore $S$ posto in parallelo.
- l'interruttore $S$ è inizialmente *chiuso* e si *apre* all'istante $t = 0$.
- L'obiettivo dell'analisi è determinare l'andamento nel tempo della tensione $v = v(t)$ ai morsetti del condensatore $C$.

#align(center)[
  #zap.circuit({
    import zap: *
    import zap.cetz.draw: *

    set-style(resistor: (variant: "ieee"))

    // Coordinate griglia spaziosa
    let x1 = 0.0   // Ramo 1: Generatore A
    let x2 = 2.8   // Ramo 2: Interruttore S
    let x3 = 5.6   // Ramo 3: Resistore R
    let x4 = 8.2   // Ramo 4: Condensatore C
    let yB = 0.0   // Quota inferiore
    let yA = 3.4   // Quota superiore

    // --- Collegamenti orizzontali ---
    wire((x1, yA), (x4, yA))
    wire((x1, yB), (x4, yB))

    // --- Nodi di giunzione ---
    node("n1", (x2, yA))
    content((x2, yA + 0.25), anchor: "south", sans("B", weight: "bold"))

    node("n2", (x2, yB))
    content((x2, yB - 0.25), anchor: "north", sans("C", weight: "bold"))

    node("n3", (x3, yA))
    node("n4", (x3, yB))

    // --- Ramo 1: Generatore di corrente A ---
    isource("a", (x1, yB), (x1, yA), variant: "iec")
    content((rel: (-0.65, 0), to: "a.center"), anchor: "east", $A$)
    // Freccia verso della corrente impressa sul ramo del generatore
    line((x1, 2.55), (x1, 3.05), mark: (end: "stealth", fill: black, scale: 1.1))

    // --- Ramo 2: Interruttore S che si apre a t = 0 ---
    wire((x2, yA), (x2, 2.2))
    // Contatto superiore e leva dell'interruttore
    line((x2 - 0.08, 2.2), (x2 + 0.42, 2.2), stroke: 0.8pt)
    line((x2, 1.15), (x2 + 0.35, 2.35), stroke: 0.8pt)
    wire((x2, 1.15), (x2, yB))

    // Freccia curva di apertura dell'interruttore a t = 0
    bezier(
      (x2 + 0.18, 1.95),
      (x2 + 0.62, 1.45),
      (x2 + 0.48, 1.82),
      mark: (end: "stealth", fill: black),
      stroke: 0.6pt
    )
    content((x2 - 0.3, 1.7), anchor: "east", $S$)
    content((x2 + 0.65, 1.25), anchor: "west", $t = 0$)

    // Corrente i_S
    line((x2 + 0.22, 3.05), (x2 + 0.22, 2.45), mark: (end: "stealth", fill: black), stroke: 0.6pt)
    content((x2 + 0.38, 2.75), anchor: "west", $i_S$)

    // --- Ramo 3: Resistore R ---
    resistor("r", (x3, yA), (x3, yB))
    content((rel: (-0.45, 0), to: "r.center"), anchor: "east", $R$)

    // Corrente i_R
    line((x3 + 0.22, 3.05), (x3 + 0.22, 2.45), mark: (end: "stealth", fill: black), stroke: 0.6pt)
    content((x3 + 0.38, 2.75), anchor: "west", $i_R$)

    // --- Ramo 4: Condensatore C ---
    capacitor("c", (x4, yA), (x4, yB))
    // Etichetta C a sinistra per lasciare libero il lato destro per la tensione v
    content((rel: (-0.5, 0), to: "c.center"), anchor: "east", $C$)

    // Corrente i_C sul ramo orizzontale superiore
    line((6.5, yA + 0.22), (7.3, yA + 0.22), mark: (end: "stealth", fill: black), stroke: 0.6pt)
    content((6.9, yA + 0.38), anchor: "south", $i_C$)

    // --- Freccia tensione v (a destra del condensatore) ---
    bezier(
      (x4 + 0.45, yB + 0.3),
      (x4 + 0.45, yA - 0.3),
      (x4 + 0.9, 1.7),
      mark: (end: "stealth", fill: black),
      stroke: 0.6pt
    )
    content((x4 + 0.85, 1.7), anchor: "west", $v$)
  })
]

Lo studio dell'evoluzione temporale si articola nell'analisi di due configurazioni circuitali distinte: una valida per $t < 0$ e una valida per $t > 0$ (esattamente in $t = 0$ lo stato del interruttore non è definito in quanto istante di commutazione).

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    *Configurazione per $t < 0$ (interruttore chiuso)*
    #v(0.5em)
    #scale(x: 85%, y: 85%, reflow: true)[
      #zap.circuit({
        
        import zap.cetz.draw: *
        set-style(resistor: (variant: "ieee"))
        
        isource("a", (0, 0), (0, 3), variant: "iec", label: (content: $A$, anchor: "north", distance: 6pt))
        line((0, 2.0), (0, 2.4), mark: (end: "stealth", fill: black))
        
        wire((0, 3), (5.4, 3))
        wire((0, 0), (5.4, 0))
        
        node("n1", (1.8, 3), label: (content: sans("B", weight: "bold"), anchor: "north", distance: 5pt))
        node("n2", (1.8, 0), label: (content: sans("C", weight: "bold"), anchor: "south", distance: 5pt))
        node("n3", (3.6, 3))
        node("n4", (3.6, 0))
        
        // Corto circuito
        wire((1.8, 3), (1.8, 0))
        line((1.6, 2.7), (1.6, 2.1), mark: (end: "stealth", fill: black), stroke: 0.6pt)
        content((1.35, 2.4), $i$)
        bezier((2.0, 0.3), (2.0, 2.7), (2.3, 1.5), mark: (end: "stealth", fill: black), stroke: 0.6pt)
        content((2.6, 2.3), $v = 0$)
        
        resistor("r", (3.6, 3), (3.6, 0), label: (content: $R$, anchor: "east", distance: 6pt))
        capacitor("c", (5.4, 3), (5.4, 0), label: (content: $C$, anchor: "east", distance: 6pt))
      })
    ]
  ],
  [
    *Configurazione per $t > 0$ (interruttore aperto)*
    #v(0.5em)
    #scale(x: 85%, y: 85%, reflow: true)[
      #zap.circuit({
        
        import zap.cetz.draw: *
        set-style(resistor: (variant: "ieee"))
        
        isource("a", (0, 0), (0, 3), variant: "iec", label: (content: $A$, anchor: "north", distance: 6pt))
        line((0, 2.0), (0, 2.4), mark: (end: "stealth", fill: black))
        
        wire((0, 3), (5.4, 3))
        wire((0, 0), (5.4, 0))
        
        node("n1", (1.8, 3), label: (content: sans("B", weight: "bold"), anchor: "north", distance: 5pt))
        node("n2", (1.8, 0), label: (content: sans("C", weight: "bold"), anchor: "south", distance: 5pt))
        node("n3", (3.6, 3))
        node("n4", (3.6, 0))
        
        // Circuito aperto
        wire((1.8, 3), (1.8, 1.9))
        wire((1.8, 1.1), (1.8, 0))
        
        resistor("r", (3.6, 3), (3.6, 0), label: (content: $R$, anchor: "east", distance: 6pt))
        line((3.8, 2.75), (3.8, 2.2), mark: (end: "stealth", fill: black), stroke: 0.6pt)
        content((4.15, 2.45), $i_R$)
        
        capacitor("c", (5.4, 3), (5.4, 0), label: (content: $C$, anchor: "south", distance: 6pt))
        line((4.2, 3.25), (4.8, 3.25), mark: (end: "stealth", fill: black), stroke: 0.6pt)
        content((4.5, 3.6), $i_C$)
        
        bezier((5.75, 0.3), (5.75, 2.7), (6.1, 1.5), mark: (end: "stealth", fill: black), stroke: 0.6pt)
        content((6.2, 1.5), $v$)
      })
    ]
  ]
)

=== Soluzione per $t < 0$

Per $t < 0$ il interruttore $S$ è chiuso e cortocircuita il generatore di corrente $A$. Di conseguenza:
- La tensione ai capi del parallelo costituito da $R$ e $C$ è identicamente nulla ($i_R = 0$, $i_C = 0$) e l'intera corrente $A$ scorre nel ramo di corto circuito ($i_S = A$).
- In tutto il semi-asse temporale negativo vale pertanto:
  $ v(t) = 0 quad "per" t < 0 $

=== Soluzione per $t > 0$

Per $t > 0$ il interruttore $S$ è aperto ($i_S = 0$); pertanto la corrente impressa $A$ deve fluire interamente attraverso il parallelo di $R$ e $C$. Le equazioni risolutive si scrivono combinando le leggi di Kirchhoff con le relazioni costitutive dei bipoli:

- *Equazioni costitutive*:
  $ v_R = R i_R, quad i_C = C (d v) / (d t) $

- *Leggi di Kirchhoff* (LKT alla maglia in parallelo e LKC al nodo superiore):
  $ v_R = v, quad A = i_R + i_C $

Poiché $R$ e $C$ sono connessi in parallelo, esprimiamo la corrente nel resistore come $i_R = v / R$ e sostituiamo le relazioni costitutive nella LKC:

$ A = i_R + i_C arrow.r.double C (d v) / (d t) + v / R = A $

Moltiplicando ambo i membri per la resistenza $R$, si ottiene l'equazione differenziale risolutiva nella sola incognita $v(t)$:

$ R C (d v(t)) / (d t) + v(t) = R A $

#nota[
L'equazione ottenuta è una *ODE del primo ordine lineare a coefficienti costanti*. Questa proprietà è generale per tutti i circuiti lineari tempo-invarianti (LTI) poiché:
- *Linearità*: le leggi di Kirchhoff sono equazioni lineari e, in presenza di componenti LTI, anche le equazioni costitutive dei bipoli sono lineari.
- *Coefficienti costanti*: i coefficienti dell'ODE sono combinazioni algebriche dei parametri caratteristici dei componenti ($R$, $C$) e risultano pertanto costanti nel tempo.
]

=== Condizioni iniziali e integrale complessivo

Per determinare in modo univoco la soluzione $v(t)$ dell'equazione differenziale per $t > 0$, è necessario fissare una condizione iniziale. Poiché la nuova configurazione circuitale nasce all'istante di apertura del interruttore, lo stato del condensatore deve essere noto in $t = 0^+$.

#nota[
*Continuità della tensione nel condensatore*: la tensione $v(t)$ ai capi di un condensatore è una *variabile di stato* (legata all'energia elettrostatica immagazzinata $W_C = 1 / 2 C v^2$) e non può subire discontinuità a gradino in presenza di correnti finite. Per continuità, essa mantiene all'istante $t = 0^+$ il medesimo valore che possedeva in $t = 0^-$ prima della manovra del interruttore:
$ v(0^+) = v(0^-) = V_0 $
Nel circuito in esame, essendo il condensatore scarico per $t < 0$, risulta $V_0 = v(0^+) = v(0^-) = 0$.
]

Applicando la formula risolutiva generale delle ODE del primo ordine a coefficienti costanti, l'integrale complessivo per $t >= 0$ assume la forma:

$ v(t) = V_infinity + (V_0 - V_infinity) e^(- t / tau) $

dove i parametri caratteristici del transitorio sono:
- $V_infinity = R A$: valore della tensione a regime (per $t -> infinity$, quando il condensatore è carico e si comporta come un circuito aperto, $i_C = 0$);
- $V_0 = v(0^+)$: condizione iniziale nota della variabile di stato;
- $tau = R C$: costante di tempo del circuito $R C$ (espressa in secondi, $[Omega dot "F"] = ["s"]$).

Nel caso specifico in cui il condensatore sia inizialmente scarico ($V_0 = 0$), la risposta si riduce a:
$ v(t) = R A (1 - e^(- t / (R C))) quad "per" t >= 0 $

// ==========================================
// SLIDE 16 - 30
// ==========================================

== Carica del Condensatore nel Circuito RC Parallelo

Il procedimento analizzato per il circuito costituito da un generatore ideale di corrente $A$ in parallelo a un resistore $R$ e a un condensatore $C$ (inizialmente scarico) prende il nome di *carica del condensatore*. La quantità:

$ tau = R C $

rappresenta la *costante di tempo* del circuito ohmico-capacitivo (misurata in secondi, $"s"$).

Supponendo il condensatore inizialmente scarico, per cui $v(0^+) = v(0^-) = 0$, l'espressione analitica della tensione ai capi del condensatore per $t >= 0$ è:

$ v(t) = R A (1 - e^(-t / tau)) $

L'andamento temporale di $v(t)$ mostra come la tensione cresca esponenzialmente tendendo al valore asintotico di regime $v_infinity = R A$. Dal punto di vista ingegneristico, il transitorio si considera esaurito dopo un intervallo di tempo pari a circa $5 tau$, istante in cui la tensione ha raggiunto oltre il $99%$ del proprio valore finale:

#grid(
  columns: (1fr, 1.3fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #table(
      columns: 2,
      align: (center, center),
      table.header([*Costanti di tempo ($t / tau$)*], [*Valore di $v(t) / (R A)$*]),
      table.hline(),
      [$0$], [$0$],
      [$1 tau$], [$approx 0.63$ ($63.2%$)],
      [$2 tau$], [$approx 0.86$ ($86.5%$)],
      [$3 tau$], [$approx 0.95$ ($95.0%$)],
      [$4 tau$], [$approx 0.98$ ($98.2%$)],
      [$5 tau$], [$approx 0.99$ ($99.3%$)],
    )
  ],
  [
    #canvas({
      import draw: *
      // Griglia di sfondo
      for x in range(1, 6) {
        line((x * 1.1, 0), (x * 1.1, 3.3), stroke: (paint: gray.lighten(50%), thickness: 0.5pt, dash: "dotted"))
      }
      for y in (0.6, 1.2, 1.8, 2.4, 3.0) {
        line((0, y), (5.5, y), stroke: (paint: gray.lighten(50%), thickness: 0.5pt, dash: "dotted"))
      }
      // Riquadro e assi
      rect((0, 0), (5.5, 3.3), stroke: 0.8pt + black)
      line((0, 3.0), (0, 3.8), mark: (end: "stealth", fill: black), stroke: 1pt)
      content((0.45, 3.7), $v(t)$)
      content((-0.45, 3.0), $R A$)
      line((-0.1, 3.0), (0, 3.0))

      // Etichette asse x
      for x in range(0, 6) {
        content((x * 1.1, -0.3), str(x))
        line((x * 1.1, 0), (x * 1.1, 0.1))
      }
      content((2.75, -0.75), sans("costanti di tempo ", size: 9pt) + $tau$)

      // Curva esponenziale: v(t) = 0 per t < 0, 3*(1 - e^(-x)) per t >= 0
      line((-1.2, 0), (0, 0), stroke: (paint: red.darken(10%), thickness: 1.8pt))
      let pts = ()
      for k in range(0, 51) {
        let t_val = k * 5.0 / 50.0
        let x_pos = t_val * 1.1
        let y_pos = 3.0 * (1.0 - calc.exp(-t_val))
        pts.push((x_pos, y_pos))
      }
      line(..pts, stroke: (paint: red.darken(10%), thickness: 1.8pt))
    })
  ]
)

=== Andamento delle Correnti di Ramo e Significato Fisico

Nota la tensione $v(t)$ ai capi del parallelo, è possibile ricavare la corrente nel condensatore $i_C(t)$ mediante l'equazione costitutiva del bipolo capacitivo:

$ i_C(t) = C ("d"v(t)) / ("d"t) = C ("d") / ("d"t) [R A (1 - e^(-t / tau))] = R C A (- e^(-t / tau)) (- 1 / (R C)) = A e^(-t / tau) $ // VERIFICA: dedotto dall'equazione

Analogamente, la corrente nel resistore $i_R(t)$ si ottiene applicando la legge di Ohm (oppure per la Legge di Kirchhoff delle Correnti al nodo superiore, essendo $A = i_C(t) + i_R(t)$):

$ i_R(t) = v(t) / R = (R A (1 - e^(-t / tau))) / R = A (1 - e^(-t / tau)) $ // VERIFICA: dedotto dall'equazione

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon, center + horizon),
  [
    #scale(x: 85%, y: 85%, reflow: true)[
      #zap.circuit({
        
        import zap.cetz.draw: *
        set-style(resistor: (variant: "ieee"), isource: (variant: "iec"))

        isource("i1", (0, 0), (0, 3), i: (content: $A$, anchor: "east", distance: 15pt))
        resistor("r1", (2.2, 3), (2.2, 0), label: (content: $R$, anchor: "west", distance: 6pt), i: (content: $i_R$, anchor: "east", distance: 15pt), n: "*-*")
        capacitor("c1", (4.4, 3), (4.4, 0), label: (content: $C$, anchor: "north", distance: 6pt), i: (content: $i_C$, anchor: "east", distance: 15pt))

        wire((0, 3), (4.4, 3))
        wire((0, 0), (4.4, 0))

        // Freccia di tensione v
        line((1.2, 0.4), (1.2, 2.6), mark: (end: "stealth", fill: blue), stroke: (paint: blue, thickness: 1pt))
        content((0.9, 1.5), text(fill: blue)[$v$])
      })
    ]
  ],
  [
    #canvas({
      import draw: *
      line((-0.8, 0), (3.6, 0), mark: (end: "stealth", fill: black))
      line((0, -0.4), (0, 2.6), mark: (end: "stealth", fill: black))
      content((3.8, -0.2), $t$)
      content((0.5, 2.5), $i_C(t)$)
      content((-0.3, 1.9), text(fill: red.darken(10%))[$A$])
      content((2.6, -0.35), text(fill: red.darken(10%))[$5 tau$])

      line((-0.8, 0), (0, 0), stroke: (paint: red.darken(10%), thickness: 1.5pt))
      line((0, 0), (0, 1.9), stroke: (paint: red.darken(10%), thickness: 1.5pt))
      let pts = ()
      for k in range(0, 41) {
        let t_val = k * 5.0 / 40.0
        let x_pos = t_val * 0.55
        let y_pos = 1.9 * calc.exp(-t_val)
        pts.push((x_pos, y_pos))
      }
      line(..pts, stroke: (paint: red.darken(10%), thickness: 1.5pt))
      circle((0, 1.9), radius: 0.06, fill: red.darken(10%), stroke: none)
    })
  ],
  [
    #canvas({
      import draw: *
      line((-0.8, 0), (3.6, 0), mark: (end: "stealth", fill: black))
      line((0, -0.4), (0, 2.6), mark: (end: "stealth", fill: black))
      content((3.8, -0.2), $t$)
      content((0.5, 2.5), $i_R(t)$)
      content((-0.3, 1.9), text(fill: red.darken(10%))[$A$])
      line((0, 1.9), (3.2, 1.9), stroke: (paint: gray, dash: "dashed", thickness: 0.6pt))

      line((-0.8, 0), (0, 0), stroke: (paint: red.darken(10%), thickness: 1.5pt))
      let pts = ()
      for k in range(0, 41) {
        let t_val = k * 5.0 / 40.0
        let x_pos = t_val * 0.55
        let y_pos = 1.9 * (1.0 - calc.exp(-t_val))
        pts.push((x_pos, y_pos))
      }
      line(..pts, stroke: (paint: red.darken(10%), thickness: 1.5pt))
    })
  ]
)

#nota[
  *Comportamento limite del condensatore a $t = 0^+$ e a regime ($t -> infinity$):*
  - Se il condensatore parte *inizialmente scarico*, nell'istante $t = 0^+$ in cui l'interruttore commuta la continuità della variabile di stato impone $v(0^+) = v(0^-) = 0$. Di conseguenza, in $t = 0^+$ il condensatore scarico *si comporta come un cortocircuito*: tutta la corrente del generatore attraversa il condensatore ($i_C(0^+) = A$), mentre nel resistore non circola corrente ($i_R(0^+) = 0$).
  - Esaurito il transitorio ($t >= 5 tau$), la tensione raggiunge il valore costante $v_infinity = R A$: la corrente nel condensatore si annulla ($i_C(infinity) = 0$) e tutta la corrente $A$ fluisce nel resistore ($i_R(infinity) = A$). A regime stazionario il condensatore *si comporta come un circuito aperto*.
]

== Circuito RL (Circuito Ohmico-Induttivo)

Si consideri ora un circuito ohmico-induttivo ($R L$ serie), in cui un induttore di induttanza $L$ è alimentato da una sorgente ideale di tensione costante $E$ collegata in serie a un resistore di resistenza $R$ attraverso un interruttore $S$ che si chiude all'istante $t = 0$.

#grid(
  columns: (1.1fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, left + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(resistor: (variant: "ieee"), vsource: (variant: "iec"))

      vsource("e1", (0, 0), (0, 3), label: (content: $E$, anchor: "north", distance: 6pt))
      content((-0.35, 2.2), sans("+", weight: "bold"))

      switch("s1", (0, 3), (2.5, 3), closed: false, label: (content: $S$, anchor: "north", distance: 8pt))
      content((1.4, 2), $t = 0$)

      node("A", (2.5, 3), fill: true, label: (content: text(fill: red.darken(10%))[#sans("A", weight: "bold")], anchor: "north", distance: 6pt))
      node("B", (2.5, 0), fill: true, label: (content: text(fill: red.darken(10%))[#sans("B", weight: "bold")], anchor: "south", distance: 6pt))

      resistor("r1", (2.5, 3), (5.5, 3), label: (content: $R$, anchor: "south", distance: 6pt))
      inductor("l1", (5.5, 3), (5.5, 0), label: (content: $L$, anchor: "east", distance: 6pt))
      wire((5.5, 0), (0, 0))

      // Corrente i
      line((5.8, 2.8), (5.8, 2.1), mark: (end: "stealth", fill: black))
      content((6.1, 2.45), $i$)

      // Frecce tensioni VR, VL e VAB
      bezier((4.8, 3.4), (3.2, 3.4), (4.0, 3.8), mark: (end: "stealth", fill: black), stroke: 0.7pt)
      content((4.0, 3.95), $v_R$)

      bezier((5.1, 0.6), (5.1, 2.2), (4.7, 1.4), mark: (end: "stealth", fill: black), stroke: 0.7pt)
      content((4.4, 1.4), $v_L$)

      line((2.5, 0.4), (2.5, 2.6), mark: (end: "stealth", fill: blue), stroke: (paint: blue, thickness: 1pt))
      content((2.95, 1.5), text(fill: red.darken(10%))[$V_(A B)$])
    })
  ],
  [
    Le relazioni costitutive dei bipoli passivi (adottando la convenzione degli utilizzatori) sono:
    $ v_R(t) = R i(t) $
    $ v_L(t) = L ("d"i(t)) / ("d"t) $
  ]
)

Analizziamo gli istanti prima e dopo la manovra dell'interruttore:
- *Per $t < 0$*: il interruttore $S$ è aperto, pertanto il circuito è interrotto e, a parte la tensione $E$ del generatore ideale, tutte le variabili di rete sono identicamente nulle ($i(t) = 0$, $v_R(t) = 0$, $v_L(t) = 0$).
- *Per $t > 0$*: il interruttore $S$ si chiude e la corrente $i(t)$ può cominciare a fluire nell'unica maglia del circuito.
- La corrente $i(t)$ che attraversa l'induttore costituisce la *variabile di stato* del circuito (essendo legata all'energia magnetica immagazzinata $W_L = 1/2 L i^2$) e pertanto gode della proprietà di continuità nell'istante di commutazione:

$ i(0^+) = i(0^-) = 0 $

=== Equazione Differenziale e Soluzione (Carica dell'Induttore)

Per $t > 0$, con l'interruttore $S$ chiuso, scrivendo la Legge di Kirchhoff delle Tensioni (LKT) lungo la maglia percorsa in senso orario si ottiene direttamente l'equazione differenziale ordinaria (ODE) risolutiva:

#grid(
  columns: (1fr, 1.2fr),
  column-gutter: 1.5em,
  align: (center + horizon, left + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(resistor: (variant: "ieee"), vsource: (variant: "iec"))

      vsource("e1", (0, 0), (0, 3), label: (content: $E$, anchor: "east", distance: 12pt))
      content((-0.35, 2.2), sans("+", weight: "bold"))
      line((-0.8, 0.6), (-0.8, 2.4), mark: (end: "stealth", fill: blue), stroke: (paint: blue, thickness: 1pt))

      switch("s1", (0, 3), (2.5, 3), closed: false, label: (content: $S$, anchor: "north", distance: 8pt))
      content((1.4, 2), $t = 0$)

      resistor("r1", (2.5, 3), (5.5, 3), label: (content: $R$, anchor: "south", distance: 6pt))
      inductor("l1", (5.5, 3), (5.5, 0), label: (content: $L$, anchor: "east", distance: 6pt))
      wire((5.5, 0), (0, 0))

      line((5.8, 2.8), (5.8, 2.1), mark: (end: "stealth", fill: black))
      content((6.1, 2.45), $i$)

      bezier((4.8, 3.4), (3.2, 3.4), (4.0, 3.8), mark: (end: "stealth", fill: black), stroke: 0.7pt)
      content((4.0, 3.95), $v_R$)

      bezier((5.1, 0.6), (5.1, 2.2), (4.7, 1.4), mark: (end: "stealth", fill: black), stroke: 0.7pt)
      content((4.4, 1.4), $v_L$)

      // Orientamento di maglia
      bezier((2.3, 1.9), (2.3, 0.9), (3.2, 1.4), mark: (end: "stealth", fill: orange.darken(10%)), stroke: (paint: orange.darken(10%), thickness: 1.2pt))
    })
  ],
  [
    $ E - v_R(t) - v_L(t) = 0 $
    Sostituendo le relazioni costitutive:
    $ E - R i(t) - L ("d"i(t)) / ("d"t) = 0 $
    Dividendo per $L$, si ricava la forma normale canonica:
    $ ("d"i) / ("d"t) + R / L i = E / L $ // VERIFICA: dedotto dall'equazione
  ]
)

Grazie alla continuità della corrente nell'induttore, il problema di Cauchy associato al transitorio per $t > 0$ risulta:

$ cases(
  ("d"i) / ("d"t) + R / L i = E / L,
  i(0^+) = i(0^-) = I_0
) $

L'integrale generale dell'ODE del primo ordine a coefficienti costanti si esprime come somma del contributo di regime e di quello transitorio:

$ i(t) = i_infinity + (i_0 - i_infinity) e^(-t / tau) $

dove i parametri caratteristici valgono:
- $i_infinity = E / R$: *valore a regime* stazionario per $t -> infinity$ (in regime continuo $"d"i / "d"t = 0$, quindi $v_L = 0$ e l'induttore equivale a un cortocircuito);
- $i_0 = i(0^+)$: *condizione iniziale* nota (nel caso di induttore inizialmente scarico, $i_0 = 0$);
- $tau = L / R$: *costante di tempo* del circuito ohmico-induttivo (misurata in secondi, $"s"$).

=== Analisi del Transitorio di Carica dell'Induttore ($i_0 = 0$)

Nel caso in cui l'induttore sia inizialmente scarico ($i(0^+) = 0$), il processo prende il nome di *carica dell'induttore* e la corrente evolve secondo la legge:

$ i(t) = E / R (1 - e^(-t / tau)) quad "per " t >= 0 $

#grid(
  columns: (1fr, 1.3fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #table(
      columns: 2,
      align: (center, center),
      table.header([*Costanti di tempo ($t / tau$)*], [*Valore di $i(t) / (E / R)$*]),
      table.hline(),
      [$0$], [$0$],
      [$1$], [$approx 0.63$],
      [$2$], [$approx 0.86$],
      [$3$], [$approx 0.95$],
      [$4$], [$approx 0.98$],
      [$5$], [$approx 0.99$],
    )
  ],
  [
    #canvas({
      import draw: *
      rect((0, 0), (5.5, 3.3), stroke: 0.8pt + black)
      line((0, 2.8), (5.5, 2.8), stroke: (paint: black, dash: "dashed", thickness: 0.6pt))
      content((-0.45, 2.8), $E / R$)
      content((0.35, 3.0), $i(t)$)

      for x in range(0, 6) {
        content((x * 1.1, -0.3), str(x))
        line((x * 1.1, 0), (x * 1.1, 0.1))
        line((x * 1.1, 3.3), (x * 1.1, 3.2))
      }
      content((2.75, -0.7), sans("costanti di tempo", size: 9pt, weight: "bold"))

      line((-1.2, 0), (0, 0), stroke: (paint: black, thickness: 1.8pt))
      let pts = ()
      for k in range(0, 51) {
        let t_val = k * 5.0 / 50.0
        let x_pos = t_val * 1.1
        let y_pos = 2.8 * (1.0 - calc.exp(-t_val))
        pts.push((x_pos, y_pos))
      }
      line(..pts, stroke: (paint: black, thickness: 1.8pt))
    })
  ]
)

La tensione ai capi dell'induttore $v_L(t)$ per $t > 0$ si ottiene derivando la corrente $i(t)$:

$ v_L(t) = L ("d"i(t)) / ("d"t) = L ("d") / ("d"t) [E / R (1 - e^(-t / tau))] = L E / R (- e^(-t / tau)) (- 1 / (L / R)) = E e^(-t / tau) $ // VERIFICA: dedotto dall'equazione

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(resistor: (variant: "ieee"), vsource: (variant: "iec"))

      vsource("e1", (0, 0), (0, 2.5), label: (content: $E$, anchor: "east", distance: 12pt))
      content((0.35, 1.9), sans("+", weight: "bold"))
      resistor("r1", (0, 2.5), (3.8, 2.5), label: (content: $R$, anchor: "south", distance: 6pt))
      inductor("l1", (3.8, 2.5), (3.8, 0), label: (content: $L$, anchor: "east", distance: 6pt))
      wire((3.8, 0), (0, 0))

      // Condizioni a t = 0+
      bezier((2.6, 2.9), (1.2, 2.9), (1.9, 3.3), mark: (end: "stealth", fill: blue), stroke: (paint: blue, thickness: 0.8pt))
      content((1.9, 3.55), text(fill: blue)[$v_R(0^+) = 0$])

      line((3.8, 2.4), (3.8, 1.9), mark: (end: "stealth", fill: red.darken(10%)), stroke: (paint: red.darken(10%), thickness: 1pt))
      content((4.6, 2.7), text(fill: red.darken(10%))[$i(0^+) = 0$])

      bezier((4.3, 0.3), (4.3, 2.2), (4.5, 1.25), mark: (end: "stealth", fill: blue), stroke: (paint: blue, thickness: 0.8pt))
      content((5.5, 1.25), text(fill: blue)[$v_L(0^+) = E$])
    })
  ],
  [
    #canvas({
      import draw: *
      line((-0.8, 0), (4.2, 0), mark: (end: "stealth", fill: black))
      line((0, -0.4), (0, 2.6), mark: (end: "stealth", fill: black))
      content((4.4, -0.1), $t$)
      content((0.6, 2.5), $v_L(t)$)
      content((-0.35, 1.8), text(fill: red.darken(10%))[$E$])
      content((2.8, -0.35), text(fill: red.darken(10%))[$5 tau$])

      line((-0.8, 0), (0, 0), stroke: (paint: red.darken(10%), thickness: 1.5pt))
      line((0, 0), (0, 1.8), stroke: (paint: red.darken(10%), thickness: 1.5pt))
      let pts = ()
      for k in range(0, 41) {
        let t_val = k * 5.0 / 40.0
        let x_pos = t_val * 0.56
        let y_pos = 1.8 * calc.exp(-t_val)
        pts.push((x_pos, y_pos))
      }
      line(..pts, stroke: (paint: red.darken(10%), thickness: 1.5pt))
      circle((0, 1.8), radius: 0.06, fill: red.darken(10%), stroke: none)
    })
  ]
)

#nota[
  *Comportamento dell'induttore nell'istante iniziale $t = 0^+$:*
  Se l'induttore è inizialmente scarico, per la continuità della corrente vale $i(0^+) = 0$. Di conseguenza, nell'istante $t = 0^+$ la caduta di tensione sul resistore è nulla ($v_R(0^+) = R i(0^+) = 0$) e tutta la tensione del generatore si localizza ai capi dell'induttore ($v_L(0^+) = E$). Pertanto, *un induttore inizialmente scarico si comporta in $t = 0^+$ come un circuito aperto*.
]

== Evoluzione Naturale del Circuito (Soluzione Omogenea)

La soluzione dell'equazione differenziale omogenea associata a un circuito dinamico del primo ordine non possiede soltanto un significato matematico, ma rappresenta fisicamente la *risposta libera* (o *evoluzione naturale*) del circuito quando *non sono applicati generatori indipendenti*.

Questa situazione può dare luogo a un'evoluzione temporale non banale del circuito solo se l'energia inizialmente immagazzinata nell'elemento dinamico all'istante $t = 0$ è diversa da zero. Nel caso di un condensatore carico alla tensione iniziale $v(0) = V_0$, l'energia elettrostatica inizialmente immagazzinata vale:

$ v(0) = V_0 quad arrow.r.double quad W_0 = 1 / 2 C V_0^2 $

#grid(
  columns: (1fr, 1.2fr),
  column-gutter: 1.5em,
  align: (center + horizon, left + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(resistor: (variant: "ieee"))

      capacitor("c1", (0, 3), (0, 0), label: (content: $C$, anchor: "north", distance: 8pt))
      content((-0.35, 2.0), sans("+", weight: "bold"))
      content((-0.35, 1.0), sans("-", weight: "bold"))

      // Corrente iC
      line((0.35, 2.4), (0.35, 1.7), mark: (end: "stealth", fill: black))
      content((0.75, 2.05), $i_C$)

      // Freccia v
      bezier((-0.6, 0.4), (-0.6, 2.6), (-0.9, 1.5), mark: (end: "stealth", fill: black), stroke: 0.7pt)
      content((-1.15, 1.5), $v$)

      switch("s1", (0, 3), (4, 3), closed: false, label: (content: $S$, anchor: "north", distance: 8pt))
      content((2.0, 2), $t = 0$)

      resistor("r1", (4, 3), (4, 0), label: (content: $R$, anchor: "west", distance: 8pt))
      bezier((3.4, 2.5), (3.4, 0.5), (3.1, 1.5), mark: (end: "stealth", fill: black), stroke: 0.7pt)
      content((2.8, 1.5), $v_R$)

      wire((4, 0), (0, 0))
    })
  ],
  [
    Alla chiusura del interruttore $S$ in $t = 0$, applicando la LKT alla maglia si ottiene:
    $ v_R(t) + v(t) = 0 $
    Poiché $i_R(t) = -i_C(t) = -C ("d"v) / ("d"t)$ (ovvero adottando i riferimenti indicati in figura con $v_R = R i_C$):
    $ R C ("d"v) / ("d"t) + v = 0 $
  ]
)

Unendo l'equazione differenziale omogenea alla condizione iniziale di continuità della tensione sul condensatore, il problema di Cauchy diventa:

$ cases(
  ("d"v) / ("d"t) + 1 / (R C) v = 0,
  v(0^+) = v(0^-) = V_0
) $

Poiché non vi sono sorgenti applicate per $t > 0$, il valore di regime forzato è nullo ($v_infinity = 0$). Applicando la formula risolutiva generale con $tau = R C$:

$ v(t) = v_infinity + (v_0 - v_infinity) e^(-t / tau) quad arrow.r.double quad v(t) = V_0 e^(-t / tau) quad "per " t >= 0 $

#align(center)[
  #canvas({
    import draw: *
    line((-1.8, 0), (4.5, 0), mark: (end: "stealth", fill: black))
    line((0, -0.4), (0, 2.5), mark: (end: "stealth", fill: black))
    content((4.7, -0.1), $t$)
    content((0.5, 2.4), $v(t)$)
    content((-0.4, 1.7), text(fill: red.darken(10%))[$V_0$])
    content((2.8, -0.35), text(fill: red.darken(10%))[$5 tau$])

    line((-1.6, 1.7), (0, 1.7), stroke: (paint: red.darken(10%), thickness: 1.6pt))
    let pts = ()
    for k in range(0, 41) {
      let t_val = k * 5.0 / 40.0
      let x_pos = t_val * 0.56
      let y_pos = 1.7 * calc.exp(-t_val)
      pts.push((x_pos, y_pos))
    }
    line(..pts, stroke: (paint: red.darken(10%), thickness: 1.6pt))
  })
]

=== Bilancio Energetico nella Scarica del Condensatore

La corrente che circola nel circuito durante la scarica per $t > 0$ (presa positiva nel verso di scarica dal morsetto positivo del condensatore verso il resistore) vale:

$ i(t) = - C ("d"v(t)) / ("d"t) = - C V_0 (- 1 / (R C)) e^(-t / tau) = V_0 / R e^(-t / tau) $ // VERIFICA: dedotto dall'equazione

Integrando la potenza istantanea dissipata per effetto Joule sul resistore $p_R(t) = R i^2(t)$ sull'intero intervallo temporale $t in [0, +infinity)$:

$ W_R = integral_0^(+infinity) R i^2(t) "d"t = integral_0^(+infinity) R (V_0^2 / R^2 e^(- (2 t) / tau)) "d"t = V_0^2 / R [- tau / 2 e^(- (2 t) / tau)]_0^(+infinity) = V_0^2 / R (R C) / 2 = 1 / 2 C V_0^2 = W_0 $ // VERIFICA: dedotto dall'equazione

#nota[
  *Estinzione dell'evoluzione naturale:*
  Tutta l'energia elettrostatica $W_0 = 1/2 C V_0^2$ inizialmente immagazzinata nel condensatore viene integralmente dissipata in calore sulla resistenza $R$. Di conseguenza, l'evoluzione naturale di un circuito passivo reale si estingue completamente in un tempo pratico limitato (circa $5 tau$).

  Se un condensatore viene prima caricato tramite un generatore per una durata di $5 tau$ e successivamente lasciato scaricare, l'intero ciclo di carica e successivo mantenimento o scarica si sviluppa su scale temporali multiple di $5 tau$ (ad esempio da $5 tau$ a $10 tau$).
]

== Rendimento di Carica (Circuito RC Serie)

Consideriamo infine il processo di carica di un condensatore inizialmente scarico ($v(0^-) = 0$) alimentato da un generatore ideale di tensione costante $E$ attraverso un resistore in serie $R$, chiudendo l'interruttore in $t = 0$.

#grid(
  columns: (1.1fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, left + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(resistor: (variant: "ieee"), vsource: (variant: "iec"))

      vsource("e1", (0, 0), (0, 3), label: (content: $E$, anchor: "east", distance: 12pt))
      content((-0.35, 2.2), sans("+", weight: "bold"))

      switch("s1", (0, 3), (2.2, 3), closed: true)
      content((1.1, 2.3), $t = 0$)

      resistor("r1", (2.2, 3), (5.0, 3), label: (content: $R$, anchor: "south", distance: 6pt), n: "*-*")
      bezier((4.4, 3.4), (2.8, 3.4), (3.6, 3.7), mark: (end: "stealth", fill: green.darken(30%)), stroke: (paint: green.darken(30%), thickness: 0.8pt))
      content((3.6, 3.95), text(fill: green.darken(30%))[$v_R$])

      capacitor("c1", (5.0, 3), (5.0, 0), label: (content: $C$, anchor: "south", distance: 6pt))
      line((5.35, 2.7), (5.35, 2.0), mark: (end: "stealth", fill: red.darken(10%)), stroke: (paint: red.darken(10%), thickness: 0.9pt))
      content((5.75, 2.35), text(fill: red.darken(10%))[$i_C$])

      bezier((5.45, 0.3), (5.45, 1.9), (5.65, 1.1), mark: (end: "stealth", fill: green.darken(30%)), stroke: (paint: green.darken(30%), thickness: 0.8pt))
      content((5.9, 1.1), text(fill: green.darken(30%))[$v$])

      wire((5.0, 0), (0, 0))

      bezier((2.2, 1.8), (2.2, 0.8), (2.9, 1.3), mark: (end: "stealth", fill: orange.darken(10%)), stroke: (paint: orange.darken(10%), thickness: 1.2pt))
    })
  ],
  [
    Per la continuità della tensione sul condensatore:
    $ v(0^+) = v(0^-) = 0 $
    Scrivendo la LKT alla maglia per $t > 0$ ed esprimendo $v_R = R i = R C ("d"v) / ("d"t)$:
    $ E - v_R(t) - v(t) = 0 $
    $ E - R C ("d"v) / ("d"t) - v = 0 $
    $ R C ("d"v) / ("d"t) + v = E $
  ]
)

Il sistema differenziale che governa il circuito RC serie per $t > 0$ è pertanto:

$ cases(
  ("d"v) / ("d"t) + 1 / (R C) v = E / (R C),
  v(0^+) = 0
) $

Con costante di tempo $tau = R C$, valore a regime $v_infinity = E$ e condizione iniziale $v_0 = 0$, la tensione sul condensatore e la corrente di carica risultano:

$ v(t) = v_infinity + (v_0 - v_infinity) e^(-t / tau) = E (1 - e^(-t / tau)) $
$ i_C(t) = C ("d"v(t)) / ("d"t) = E / R e^(-t / tau) $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #canvas({
      import draw: *
      line((-0.8, 0), (3.6, 0), mark: (end: "stealth", fill: black))
      line((0, -0.4), (0, 2.5), mark: (end: "stealth", fill: black))
      content((3.8, -0.2), $t$)
      content((0.35, 2.4), $v(t)$)
      content((-0.35, 1.8), text(fill: red.darken(10%))[$E$])
      line((0, 1.8), (3.2, 1.8), stroke: (paint: red.darken(10%), dash: "dashed", thickness: 0.7pt))

      line((-0.8, 0), (0, 0), stroke: (paint: red.darken(10%), thickness: 1.5pt))
      let pts = ()
      for k in range(0, 41) {
        let t_val = k * 5.0 / 40.0
        let x_pos = t_val * 0.55
        let y_pos = 1.8 * (1.0 - calc.exp(-t_val))
        pts.push((x_pos, y_pos))
      }
      line(..pts, stroke: (paint: red.darken(10%), thickness: 1.5pt))
    })
  ],
  [
    #canvas({
      import draw: *
      line((-0.8, 0), (3.6, 0), mark: (end: "stealth", fill: black))
      line((0, -0.4), (0, 2.5), mark: (end: "stealth", fill: black))
      content((3.8, -0.2), $t$)
      content((0.45, 2.4), $i_C(t)$)
      content((0.65, 1.95), text(fill: red.darken(10%))[$E / R$])

      line((-0.8, 0), (0, 0), stroke: (paint: red.darken(10%), thickness: 1.5pt))
      line((0, 0), (0, 1.8), stroke: (paint: red.darken(10%), thickness: 1.5pt))
      let pts = ()
      for k in range(0, 41) {
        let t_val = k * 5.0 / 40.0
        let x_pos = t_val * 0.55
        let y_pos = 1.8 * calc.exp(-t_val)
        pts.push((x_pos, y_pos))
      }
      line(..pts, stroke: (paint: red.darken(10%), thickness: 1.5pt))
    })
  ]
)

=== Calcolo dell'Energia e del Rendimento di Carica

Valutiamo il bilancio energetico complessivo dell'intero processo di carica da $t = 0$ a $t -> +infinity$:

1. *Potenza istantanea fornita dal generatore*:
   $ p_E(t) = E i_C(t) = E^2 / R e^(-t / tau) $ // VERIFICA: dedotto dall'equazione

2. *Energia totale erogata dal generatore nel processo di carica*:
   $ W_E = integral_0^(+infinity) p_E(t) "d"t = integral_0^(+infinity) E^2 / R e^(-t / tau) "d"t = E^2 / R [- tau e^(-t / tau)]_0^(+infinity) = E^2 / R (R C) = C E^2 $ // VERIFICA: dedotto dall'equazione

3. *Energia elettrostatica immagazzinata nel condensatore a fine carica*:
   $ W_C = 1 / 2 C (V_"fin"^2 - V_"in"^2) = 1 / 2 C (E^2 - 0) = 1 / 2 C E^2 $

4. *Rendimento energetico del processo di carica*:
   $ eta_"ene" = W_C / W_E = (1 / 2 C E^2) / (C E^2) = 1 / 2 = 50% $ // VERIFICA: dedotto dall'equazione

#nota[
  *Proprietà fondamentale del rendimento di carica:*
  Nel processo di carica di un condensatore mediante un generatore di tensione costante in serie a un resistore $R$, il rendimento energetico è sempre pari al $50%$, *indipendentemente dal valore della resistenza $R$*. La restante metà dell'energia erogata dal generatore ($W_R = W_E - W_C = 1/2 C E^2$) viene inevitabilmente dissipata per effetto Joule sul resistore durante il transitorio.
]

// ==========================================
// SLIDE 31 - 32
// ==========================================

= Generatore Reale di Tensione e Adattamento del Carico

== Caratteristica esterna del generatore reale di tensione

Un generatore reale di tensione è modellato mediante la connessione in serie di un generatore ideale di tensione di forza elettromotrice $E$ e di un resistore $R$, detto *resistenza interna* del generatore, che tiene conto delle cadute di tensione interne al dispositivo.

#grid(
  columns: (1.2fr, 0.8fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(resistor: (variant: "ieee"), vsource: (variant: "ieee"))

      // Generatore E e resistenza interna R
      vsource("e", (0, 0), (0, 3), label: (content: $E$, anchor: "east", distance: 6pt))
      resistor("r", (0, 3), (3.5, 3), label: (content: $R$, anchor: "south", distance: 6pt))
      wire((0, 0), (3.5, 0))

      // Nodi interni ed esterni A e B
      node("n1", (0, 3), fill: false)
      node("n2", (0, 0), fill: false)
      node("A", (3.5, 3), fill: false, label: (content: sans("A", weight: "bold", size: 10pt), anchor: "north", distance: 5pt))
      node("B", (3.5, 0), fill: false, label: (content: sans("B", weight: "bold", size: 10pt), anchor: "south", distance: 5pt))

      // Segno + e freccia blu di E
      content((0.45, 2.3), sans("+", weight: "bold"))
      line((0.65, 0.8), (0.65, 2.1), stroke: blue + 1.2pt, mark: (end: "stealth", fill: blue))

      // Freccia curva blu su R
      bezier((2.3, 3.65), (1.1, 3.65), (1.7, 3.95), stroke: blue + 1.2pt, mark: (end: "stealth", fill: blue))

      // Orientamento orario della maglia (arancione)
      bezier((1.5, 1.8), (1.7, 1.0), (2.2, 2.1), stroke: orange + 1.2pt, mark: (end: "stealth", fill: orange))

      // Tensione V e corrente I ai morsetti A-B (rosso)
      line((3.5, 0.2), (3.5, 2.75), stroke: red + 1.2pt, mark: (end: "stealth", fill: red))
      content((3.9, 1.8), text(fill: red)[$V$])
      line((3.7, 3), (4.6, 3), stroke: red + 1.2pt, mark: (end: "stealth", fill: red))
      content((4.9, 3), text(fill: red)[$I$])
    })
  ],
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(resistor: (variant: "iec"))

      // Bipolo generico con convenzione degli utilizzatori
      resistor("b", (0, 2.6), (0, 0), n: "o-o")
      line((0, 2.4), (0, 1.9), stroke: red + 1.2pt, mark: (end: "stealth", fill: red))
      content((-0.5, 2.2), text(fill: red)[$I$])
      line((0.55, 0.3), (0.55, 2.2), stroke: red + 1.2pt, mark: (end: "stealth", fill: red))
      content((0.95, 1.25), text(fill: red)[$V$])
    })
  ]
)

Adottando ai morsetti $"A"$ e $"B"$ la convenzione dei generatori (corrente $I$ uscente dal morsetto positivo della tensione $V$) e applicando la legge di Kirchhoff delle tensioni (LKT) alla maglia in senso orario, si ottiene l'equazione caratteristica del generatore reale:

$ E - R I - V = 0 quad arrow.r.double quad V = E - R I $

Nel piano $(I, V)$ la caratteristica esterna è rappresentata da una retta con pendenza negativa, individuata da due condizioni limite di funzionamento:
- *Funzionamento a vuoto (circuito aperto)*: quando i morsetti $"A"$ e $"B"$ sono aperti, la corrente erogata è nulla ($I = 0$) e la tensione a vuoto coincide con la forza elettromotrice: $V = E$.
- *Funzionamento in cortocircuito*: collegando direttamente tra loro i morsetti $"A"$ e $"B"$ tramite un filo ideale, la tensione ai morsetti si annulla ($V = 0$) e il generatore eroga la *corrente di cortocircuito* $I_"cc"$:

$ E - R I_"cc" = 0 quad arrow.r.double quad I_"cc" = E / R $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(resistor: (variant: "ieee"), vsource: (variant: "ieee"))

      vsource("e", (0, 0), (0, 3), label: (content: $E$, anchor: "east", distance: 6pt))
      resistor("r", (0, 3), (3.2, 3), label: (content: $R$, anchor: "south", distance: 6pt))
      wire((0, 0), (3.2, 0))

      // Ramo di cortocircuito
      wire((3.2, 3), (4.3, 3), (4.3, 0), (3.2, 0))

      node("n1", (0, 3), fill: false)
      node("n2", (0, 0), fill: false)
      node("A", (3.2, 3), fill: false, label: (content: sans("A", weight: "bold", size: 10pt), anchor: "north", distance: 5pt))
      node("B", (3.2, 0), fill: false, label: (content: sans("B", weight: "bold", size: 10pt), anchor: "south", distance: 5pt))

      content((0.45, 2.3), sans("+", weight: "bold"))
      line((0.65, 0.8), (0.65, 2.1), stroke: blue + 1.2pt, mark: (end: "stealth", fill: blue))
      bezier((2.2, 3.65), (1.0, 3.65), (1.6, 3.95), stroke: blue + 1.2pt, mark: (end: "stealth", fill: blue))
      bezier((1.4, 1.8), (1.6, 1.0), (2.1, 2.1), stroke: orange + 1.2pt, mark: (end: "stealth", fill: orange))

      line((3.2, 0.2), (3.2, 2.75), stroke: red + 1.2pt, mark: (end: "stealth", fill: red))
      content((3.55, 1.9), text(fill: red)[$V$])

      // Corrente di cortocircuito
      line((4.3, 2.0), (4.3, 1.3), stroke: red + 1.2pt, mark: (end: "stealth", fill: red))
      content((5.1, 3.3), sans("cto cto", size: 9pt, weight: "bold"))
      content((5.25, 1.7), text(fill: red)[$I_"cc", V = 0$])
    })
  ],
  [
    #canvas({
      import draw: *
      // Assi cartesiani
      line((-0.4, 0), (4.2, 0), mark: (end: "stealth", fill: black), stroke: 1.2pt)
      line((0, -0.6), (0, 3.2), mark: (end: "stealth", fill: black), stroke: 1.2pt)
      content((4.5, -0.2), $I$)
      content((-0.35, 3.0), $V$)

      // Retta caratteristica V = E - R I
      line((-0.4, 2.46), (2.9, -0.35), stroke: orange + 1.5pt)

      // Punti notevoli
      circle((0, 2.12), radius: 0.08, fill: rgb("#006633"), stroke: none)
      content((0.35, 2.3), text(fill: rgb("#006633"))[$E$])
      circle((0.15, 2.2), radius: (0.45, 0.35), stroke: rgb("#006633") + 1pt)
      line((0.55, 2.55), (0.95, 2.95), stroke: rgb("#006633") + 1pt, mark: (end: "stealth", fill: rgb("#006633")))
      content((2.1, 3.3), text(fill: rgb("#006633"))[#sans("circuito aperto", size: 9pt)])

      circle((2.5, 0), radius: 0.08, fill: rgb("#006633"), stroke: none)
      content((2.7, -0.55), text(fill: rgb("#006633"))[$I_"cc" = E / R$])
    })
  ]
)

#align(center)[
  #table(
    columns: 2,
    align: (center, center),
    table.header([$I$], [$V$]),
    table.hline(),
    [$0$], [$E$],
    [$I_"cc" = E / R$], [$0$],
  )
]

== Punto di lavoro con carico resistivo

Collegando ai morsetti $"A"$ e $"B"$ del generatore reale un resistore utilizzatore $R_u$, la corrente $I$ che circola nel circuito e la tensione $V$ ai morsetti sono determinate dal sistema costituito dalla caratteristica del generatore e dalla legge di Ohm sul carico:

$ cases(V = E - R I, V = R_u I) $

Uguagliando le due espressioni della tensione $V$, si ricava la corrente del punto di lavoro:

$ R_u I = E - R I quad arrow.r.double quad (R + R_u) I = E quad arrow.r.double quad I = E / (R + R_u) $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (center + horizon, center + horizon),
  [
    #zap.circuit({
      
      import zap.cetz.draw: *
      set-style(resistor: (variant: "ieee"), vsource: (variant: "ieee"))

      vsource("e", (0, 0), (0, 3), label: (content: $E$, anchor: "east", distance: 6pt))
      resistor("r", (0, 3), (3.2, 3), label: (content: $R$, anchor: "north", distance: 4pt))
      wire((0, 0), (3.2, 0))

      // Carico Ru
      wire((3.2, 3), (4.6, 3))
      resistor("ru", (4.6, 3), (4.6, 0), label: (content: $R_u$, anchor: "west", distance: 6pt))
      wire((4.6, 0), (3.2, 0))

      node("n1", (0, 3), fill: false)
      node("n2", (0, 0), fill: false)
      node("A", (3.2, 3), fill: false, label: (content: sans("A", weight: "bold", size: 10pt), anchor: "north", distance: 5pt))
      node("B", (3.2, 0), fill: false, label: (content: sans("B", weight: "bold", size: 10pt), anchor: "south", distance: 5pt))

      content((0.45, 2.3), sans("+", weight: "bold"))
      line((0.65, 0.8), (0.65, 2.1), stroke: blue + 1.2pt, mark: (end: "stealth", fill: blue))
      bezier((2.2, 3.65), (1.0, 3.65), (1.6, 3.95), stroke: blue + 1.2pt, mark: (end: "stealth", fill: blue))
      bezier((1.4, 1.8), (1.6, 1.0), (2.1, 2.1), stroke: orange + 1.2pt, mark: (end: "stealth", fill: orange))

      // Annotazione resistenza interna
      circle((1.6, 3.45), radius: 0.35, stroke: red + 1pt)
      line((1.1, 3.5), (0.2, 4.1), stroke: red + 1pt, mark: (end: "stealth", fill: red))
      content((0.0, 4.35), text(fill: red)[#sans("R interna", size: 8pt)])

      line((3.2, 0.2), (3.2, 2.75), stroke: red + 1.2pt, mark: (end: "stealth", fill: red))
      content((3.55, 1.9), text(fill: red)[$V$])
      line((3.6, 3), (4.2, 3), stroke: red + 1.2pt, mark: (end: "stealth", fill: red))
      content((3.9, 3.35), text(fill: red)[$I$])
    })
  ],
  [
    #canvas({
      import draw: *
      // Assi cartesiani
      line((-0.4, 0), (4.2, 0), mark: (end: "stealth", fill: black), stroke: 1.2pt)
      line((0, -0.6), (0, 3.2), mark: (end: "stealth", fill: black), stroke: 1.2pt)
      content((4.5, -0.2), $I$)
      content((-0.35, 3.0), $V$)

      // Retta generatore (arancione) e retta carico V = Ru I (blu)
      line((-0.4, 2.46), (2.9, -0.35), stroke: orange + 1.5pt)
      line((0, 0), (2.0, 2.5), stroke: blue + 1.5pt)

      // Punto di lavoro (rosso)
      let px = 1.01
      let py = 1.26
      line((px, 0), (px, py), stroke: (paint: red, thickness: 1pt, dash: "dashed"))
      line((0, py), (px, py), stroke: (paint: red, thickness: 1pt, dash: "dashed"))
      circle((px, py), radius: 0.09, fill: red, stroke: none)
      content((px, -0.35), text(fill: red)[$I$])

      // Punti notevoli generatore
      circle((0, 2.12), radius: 0.08, fill: rgb("#006633"), stroke: none)
      content((0.35, 2.3), text(fill: rgb("#006633"))[$E$])
      circle((2.5, 0), radius: 0.08, fill: rgb("#006633"), stroke: none)
      content((2.7, -0.55), text(fill: rgb("#006633"))[$I_"cc" = E / R$])
    })
  ]
)

== Trasferimento di potenza e condizione di carico adattato

La potenza elettrica $P_u$ trasferita dal generatore al resistore utilizzatore $R_u$ è data da:

$ P_u = R_u I^2 = R_u (E / (R + R_u))^2 $

Al variare della resistenza di carico $R_u$ (mantenendo fissati $E$ ed $R$), si osserva che:
- per $R_u = 0$ (cortocircuito), si ha $P_u = 0$;
- per $R_u >> R$ (tendente al circuito aperto), la corrente tende a zero e la potenza $P_u$ tende nuovamente a zero.

#align(center)[
  #canvas({
    import draw: *
    // Assi
    line((-0.3, 0), (4.8, 0), mark: (end: "stealth", fill: black), stroke: 1.2pt)
    line((0, -0.3), (0, 2.8), mark: (end: "stealth", fill: black), stroke: 1.2pt)
    content((5.3, -0.15), $R_u$)
    content((-0.4, 2.6), $P_u$)

    // Curva della potenza P_u(R_u)
    bezier((0, 0), (1.8, 2.1), (0.8, 1.8), stroke: (paint: red, thickness: 1.4pt, dash: "dashed"))
    bezier((1.8, 2.1), (3.6, 0.1), (2.5, 2.0), stroke: (paint: red, thickness: 1.4pt, dash: "dashed"))

    // Punto di massimo Ru = R
    line((1.8, 0), (1.8, 2.1), stroke: (paint: red, thickness: 1pt, dash: "dashed"))
    circle((0, 0), radius: 0.09, fill: red, stroke: none)
    circle((3.6, 0), radius: 0.09, fill: red, stroke: none)

    content((1.8, -0.45), text(fill: red)[$R_u = R$])
    content((3.7, -0.45), $R_u >> R$)
  })
]

Per determinare il valore di $R_u$ che rende massima la potenza trasferita al carico, si calcola la derivata di $P_u$ rispetto a $R_u$ e la si pone uguale a zero:

$ (d P_u) / (d R_u) = (E^2 (R + R_u)^2 - R_u E^2 (2 R + 2 R_u)) / (R + R_u)^4 = 0 $

Sviluppando il binomio al quadrato $(R + R_u)^2 = R^2 + 2 R R_u + R_u^2$ al numeratore, si ottiene:

$ (E^2 R^2 + 2 E^2 R R_u + E^2 R_u^2 - 2 E^2 R R_u - 2 E^2 R_u^2) / (R + R_u)^4 = (E^2 R^2 - E^2 R_u^2) / (R + R_u)^4 = 0 $

Annullando il numeratore e dividendo per $E^2$, si ricava la condizione di massimo trasferimento di potenza:

$ R^2 - R_u^2 = 0 quad arrow.r.double quad R^2 = R_u^2 quad arrow.r.double quad R_u = R $

#nota[
  *Condizione di carico adattato*: un generatore reale di tensione trasferisce la massima potenza al carico quando la resistenza dell'utilizzatore eguaglia la resistenza interna del generatore ($R_u = R$).
]