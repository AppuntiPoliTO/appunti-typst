#import "@preview/cetz:0.3.4": canvas as cetz-canvas, draw
#let canvas(..args) = align(center, cetz-canvas(..args))

#set page(paper: "a4", margin: 1.5cm, numbering: "1", number-align: bottom + right)
#set text(lang: "it", size: 11pt)
#set par(justify: true)
#set math.equation(numbering: "(1)")

#let immagine-originale = image
#let image(nome-file, ..args) = immagine-originale("images/" + nome-file, ..args)

// Nota / osservazione
#let nota(body) = block(
  width: 100%, fill: luma(240), inset: 8pt, radius: 3pt, body
)
#let circ = sym.degree
#let varphi = $phi$

#set heading(numbering: "1.")

#pagebreak()



= Linea elastica

== Introduzione e ipotesi di base

La valutazione dello *spostamento elastico massimo* (detto *freccia*) e della *rotazione flessionale massima* di un sistema strutturale è necessaria per evitare interferenze geometriche o funzionali che possano pregiudicarne il corretto funzionamento.

Lo studio della deformabilità delle travi mediante la soluzione della *linea elastica* consente di determinare analiticamente la freccia e la rotazione flessionale in ogni sezione del sistema, individuando in particolare i valori massimi raggiunti. La trattazione si fonda su due ipotesi fondamentali:
- *Sistema lineare elastico*: il materiale segue la legge di Hooke e vi è linearità tra carichi applicati e spostamenti.
- *Piccoli spostamenti (generalizzati)*: gli spostamenti e le rotazioni sono sufficientemente piccoli da permettere di confondere la configurazione deformata con quella indeformata nella scrittura delle equazioni di equilibrio e nelle relazioni cinematiche.

== Deformata di una trave inflessa

Si consideri una trave rettilinea di lunghezza $L$ riferita a un sistema di riferimento cartesiano $(x, y)$, con l'asse $x$ coincidente con l'asse della trave nella configurazione indeformata e l'asse $y$ rivolto verso l'alto.

#align(center)[

#canvas(length: 1.4cm, {
  import draw: *

  // Assi cartesiani
  line((0, 0), (0, 2.2), mark: (end: ">"), stroke: 0.8pt)
  line((0, 0), (7.2, 0), mark: (end: ">"), stroke: 0.8pt)

  // Contorno trave indeformata AB
  line((0, 0), (6.0, 0), stroke: 1.8pt)

  // Deformata (arco circolare esatto per A(0,0), V(3.0,-0.75), B(6.0,0))
  arc((3.0, 5.625), start: 241.93deg, stop: 298.07deg, radius: 6.375, anchor: "origin", stroke: 0.8pt)

  // Vincolo A (cerniera fissa)
  line((-0.25, -0.45), (0.25, -0.45), (0.0, -0.08), close: true, stroke: 0.8pt)
  line((-0.4, -0.45), (0.4, -0.45), stroke: 0.8pt)
  line((-0.35, -0.45), (-0.45, -0.6), stroke: 0.6pt)
  line((-0.2, -0.45), (-0.3, -0.6), stroke: 0.6pt)
  line((-0.05, -0.45), (-0.15, -0.6), stroke: 0.6pt)
  line((0.1, -0.45), (0.0, -0.6), stroke: 0.6pt)
  line((0.25, -0.45), (0.15, -0.6), stroke: 0.6pt)
  line((0.4, -0.45), (0.3, -0.6), stroke: 0.6pt)
  circle((0, 0), radius: 0.08, fill: white, stroke: 0.8pt)

  // Vincolo B (carrello)
  line((5.75, -0.45), (6.25, -0.45), (6.0, -0.08), close: true, stroke: 0.8pt)
  circle((5.85, -0.53), radius: 0.08, stroke: 0.8pt)
  circle((6.15, -0.53), radius: 0.08, stroke: 0.8pt)
  line((5.6, -0.61), (6.4, -0.61), stroke: 0.8pt)
  line((5.65, -0.61), (5.55, -0.76), stroke: 0.6pt)
  line((5.8, -0.61), (5.7, -0.76), stroke: 0.6pt)
  line((5.95, -0.61), (5.85, -0.76), stroke: 0.6pt)
  line((6.1, -0.61), (6.0, -0.76), stroke: 0.6pt)
  line((6.25, -0.61), (6.15, -0.76), stroke: 0.6pt)
  line((6.4, -0.61), (6.3, -0.76), stroke: 0.6pt)
  circle((6.0, 0), radius: 0.08, fill: white, stroke: 0.8pt)

  // Carico P in mezzeria (x = 3.0)
  line((3.0, 2.3), (3.0, 0.05), mark: (end: ">"), stroke: 1.8pt)

  // Frecce spostamenti v(x) e v_max (punte esattamente sulla deformata)
  line((1.8, 0), (1.8, -0.636), mark: (end: ">"), stroke: 0.7pt)
  line((3.0, 0), (3.0, -0.75), mark: (end: ">"), stroke: 0.7pt)

  // Tangente in A e angolo di rotazione theta(x)
  line((0, 0), (1.6, -0.8), stroke: 0.7pt)
  arc((0, 0), start: 333.43deg, stop: 360deg, radius: 1.4, anchor: "origin", stroke: 0.7pt)

  // Quote L/2 e L
  line((0, -0.45), (0, -2.1), stroke: 0.6pt)
  line((3.0, -0.75), (3.0, -1.5), stroke: 0.6pt)
  line((6.0, -0.61), (6.0, -2.1), stroke: 0.6pt)

  line((0, -1.4), (3.0, -1.4), mark: (start: ">", end: ">"), stroke: 0.7pt)
  line((0, -2.0), (6.0, -2.0), mark: (start: ">", end: ">"), stroke: 0.7pt)

  // Etichette
  content((-0.3, 2.1), text(size: 7pt)[$y$])
  content((7.1, 0.3), text(size: 7pt)[$x$])
  content((-0.35, 0.35), text(size: 7pt)[A])
  content((6.35, 0.35), text(size: 7pt)[B])
  content((3.4, 1.9), text(size: 7pt)[$P$])
  content((2.25, -0.35), text(size: 7pt)[$v(x)$])
  content((3.45, -0.95), text(size: 7pt)[$v_("max")$])
  content((1.8, -0.95), text(size: 7pt)[$theta(x)$])
  content((1.5, -1.15), text(size: 7pt)[$L / 2$])
  content((3.0, -1.75), text(size: 7pt)[$L$])
})

]

Si definiscono le seguenti grandezze cinematiche fondamentali:
- *Freccia $v(x)$*: è lo spostamento verticale (in direzione $y$) subito dal generico punto dell'asse $x$ della trave nel passaggio dalla configurazione indeformata a quella deformata. Nel sistema di riferimento scelto, una freccia rivolta verso l'alto è positiva, mentre una freccia rivolta verso il basso è negativa.
- *Rotazione flessionale $theta(x)$*: è l'angolo formato dall'asse $x$ con la retta tangente alla curva deformata nel generico punto relativo alla sezione trasversale considerata. Nel sistema di riferimento adottato, una rotazione in senso antiorario è positiva, mentre una rotazione in senso orario è negativa.

=== Relazioni tra curvatura, rotazione e freccia

Per legare analiticamente la freccia e la rotazione alla geometria della deformata, si considerino due punti infinitamente vicini sull'asse della trave:
1. Un primo punto, posto a distanza $x$ dall'origine del sistema di riferimento, in cui la freccia vale $v$ e la rotazione flessionale vale $theta$.
2. Un secondo punto, posto a distanza $x + d x$ dall'origine, in cui la freccia vale $v + d v$ e la rotazione flessionale vale $theta + d theta$.

#align(center)[
#canvas(length: 1cm, {
  import draw: *

  // Assi cartesiani
  line((0, 0), (0, 1.95), mark: (end: ">"), stroke: 0.8pt)
  line((0, 0), (6.45, 0), mark: (end: ">"), stroke: 0.8pt)

  // Vincolo A (cerniera fissa con tratteggio a terra)
  line((-0.26, -0.46), (0.26, -0.46), (0, -0.08), close: true, stroke: 0.8pt)
  line((-0.55, -0.46), (0.55, -0.46), stroke: 0.6pt)
  line((-0.45, -0.46), (-0.55, -0.64), stroke: 0.6pt)
  line((-0.35, -0.46), (-0.45, -0.64), stroke: 0.6pt)
  line((-0.25, -0.46), (-0.35, -0.64), stroke: 0.6pt)
  line((-0.15, -0.46), (-0.25, -0.64), stroke: 0.6pt)
  line((-0.05, -0.46), (-0.15, -0.64), stroke: 0.6pt)
  line((0.05, -0.46), (-0.05, -0.64), stroke: 0.6pt)
  line((0.15, -0.46), (0.05, -0.64), stroke: 0.6pt)
  line((0.25, -0.46), (0.15, -0.64), stroke: 0.6pt)
  line((0.35, -0.46), (0.25, -0.64), stroke: 0.6pt)
  line((0.45, -0.46), (0.35, -0.64), stroke: 0.6pt)
  line((0.55, -0.46), (0.45, -0.64), stroke: 0.6pt)
  circle((0, 0), radius: 0.08, fill: white, stroke: 0.8pt)

  // Curva deformata (arco di cerchio da A(0,0) a P3(5.6,-1.27))
  arc((7.189, 18.718), start: 248.99deg, stop: 265.45deg, radius: 20.051, anchor: "origin", stroke: 0.9pt)

  // Freccia coordinata curvilinea s (in prosecuzione a destra)
  line((5.72, -1.32), (7.20, -1.56), mark: (end: ">"), stroke: 0.7pt)

  // Punto P1 (x = 2.0, y = -0.65): freccia v, riferimento orizzontale per theta e normale
  line((2.0, 0), (2.0, -0.65), mark: (end: ">"), stroke: 0.8pt)
  line((2.0, -0.65), (3.20, -0.65), stroke: 0.7pt)
  line((2.0, -0.65), (2.48, 1.75), stroke: 0.7pt)

  // Punto P2 (x = 3.8, y = -1.045): riferimento orizzontale per theta + dif theta, freccia v + dif v e normale
  line((3.8, -1.045), (5.68, -1.045), stroke: 0.6pt)
  line((5.30, 0), (5.30, -1.045), mark: (end: ">"), stroke: 0.8pt)
  line((3.8, -1.045), (3.95, 1.52), stroke: 0.7pt)

  // Arco quotato per d theta tra le due normali
  arc((3.55, 4.55), start: 249.6deg, stop: 277.2deg, radius: 3.12, anchor: "origin", mark: (start: ">", end: ">"), stroke: 0.8pt)

  // Quote x e dx
  line((0, -0.64), (0, -2.35), stroke: 0.6pt)
  line((2.0, -0.72), (2.0, -2.35), stroke: 0.6pt)
  line((3.8, -1.10), (3.8, -2.35), stroke: 0.6pt)

  line((0, -2.10), (2.0, -2.10), mark: (start: ">", end: ">"), stroke: 0.7pt)
  line((2.0, -2.10), (3.8, -2.10), mark: (start: ">", end: ">"), stroke: 0.7pt)

  // Etichette (tutte con text(size: 7pt))
  content((-0.35, 2.05), text(size: 7pt)[y])
  content((6.85, 0.15), text(size: 7pt)[x])
  content((-0.38, 0.28), text(size: 7pt)[A])
  content((1.80, 0.70), text(size: 7pt)[v])
  content((2.52, -0.92), text(size: 7pt)[$theta$])
  content((3.48, 1.88), text(size: 7pt)[$"d"theta$])
  content((5.05, 0.35), text(size: 7pt)[$"v"+"dv"$])
  content((6.45, -1.02), text(size: 7pt)[$theta + "d"theta$])
  content((6.20, -1.68), text(size: 7pt, fill: rgb(30, 80, 160))[$s$])
  content((1.20, -1.72), text(size: 7pt)[x])
  content((3.08, -1.72), text(size: 7pt)[dx])
})7pt)
  content((2.9, -1.8), text(size: 7pt)[$d x$])
})
]

Sull'asse della trave deformata, i due punti si trovano a una distanza infinitesima $d s$, dove $s$ rappresenta la *coordinata curvilinea* lungo la deformata. Si definiscono *raggio di curvatura* $R$ e *curvatura* $1 / R$ della trave deformata le grandezze:

$ R = (d s) / (d theta) quad arrow.r.double quad 1 / R = (d theta) / (d s) $

Introducendo l'ipotesi di piccoli spostamenti, l'elemento d'arco infinitesimo $d s$ si confonde con la sua proiezione sull'asse $x$, e l'angolo di rotazione $theta$ coincide approssimativamente con la sua tangente trigonometrica:

$ d s approx d x , quad theta approx tan theta = (d v) / (d x) $

Sostituendo tali relazioni nell'espressione della curvatura, si ottiene che la curvatura della trave coincide con la derivata prima della rotazione della sezione rispetto a $x$, ovvero con la derivata seconda della freccia:

$ 1 / R = (d theta) / (d s) approx (d theta) / (d x) = (d^2 v) / (d x^2) $

== Equazione differenziale della linea elastica

Dallo studio della flessione nelle travi (problema di De Saint-Venant) è noto il legame costitutivo tra il momento flettente $M_z (x)$, la rigidezza flessionale della sezione $E J_z$ e la curvatura intorno all'asse $z$:

$ k_z = 1 / R = (M_z (x)) / (E J_z) $

Uguagliando l'espressione meccanica della curvatura con quella cinematica ricavata nell'ipotesi di piccoli spostamenti, si ottiene l'*equazione differenziale della linea elastica*:

$ (d^2 v) / (d x^2) = (M_z (x)) / (E J_z) $

Nota la caratteristica di sollecitazione del momento flettente $M_z (x)$ lungo l'asse della trave, la rotazione flessionale $theta(x)$ e la freccia $v(x)$ si ricavano svolgendo una doppia integrazione:

1. *Prima integrazione (rotazione flessionale)*:
   $ theta(x) = (d v) / (d x) = integral_0^x (M_z (x)) / (E J_z) d x + C_1 $

2. *Seconda integrazione (freccia)*:
   $ v(x) = integral_0^x theta(x) d x + C_2 = integral_0^x ( integral_0^x (M_z (x)) / (E J_z) d x ) d x + C_1 x + C_2 $

#nota[
Le *costanti di integrazione* $C_1$ e $C_2$ dipendono dalle *condizioni di vincolo* (condizioni al contorno), ovvero dai valori di spostamento e di rotazione che i vincoli impongono nei rispettivi punti di applicazione.

Nel caso in cui la funzione del momento flettente $M_z (x)$ presenti discontinuità (ad esempio in presenza di carichi concentrati o variazioni di vincolo), il calcolo della rotazione flessionale $theta(x)$ e della freccia $v(x)$ deve essere svolto separatamente in ciascuno dei tratti continui della trave, raccordando poi le soluzioni tramite condizioni di congruenza nei punti di interfaccia.
]

== Esempi applicativi

=== Esempio 1: Trave a mensola incastrata con carico concentrato

La trave a mensola $A B$ di lunghezza $L$ ha sezione trasversale uniforme (rigidezza flessionale $E J$ costante), è incastrata all'estremità $B$ ($x = L$) e sostiene un carico verticale concentrato $P$ rivolto verso il basso all'estremità libera $A$ ($x = 0$). Si vogliono ricavare l'equazione della linea elastica, la freccia $v_A$ e la rotazione $theta_A$ nel punto $A$.

#align(center)[
#canvas(length: 1cm, {
  import draw: *
  
  // --- PANNELLO SINISTRO: Configurazione indeformata ---
  line((0, 0), (0, 2.2), mark: (end: ">"), stroke: 0.7pt)
  content((0.25, 2.1), text(size: 7pt)[$y$])
  line((0, 0), (4.0, 0), mark: (end: ">"), stroke: 0.7pt)
  content((3.9, -0.25), text(size: 7pt)[$x$])
  
  // Trave AB
  line((0, 0), (3.2, 0), stroke: 1.6pt)
  content((-0.25, 0.35), text(size: 7pt)[$"A"$])
  content((2.95, 0.35), text(size: 7pt)[$"B"$])
  
  // Carico P in A
  line((0, 1.5), (0, 0.05), mark: (end: ">"), stroke: 1.6pt)
  content((0.25, 1.25), text(size: 7pt)[$P$])
  
  // Muro di incastro in B
  rect((3.2, -0.7), (3.55, 0.7), fill: luma(230), stroke: none)
  line((3.2, -0.7), (3.2, 0.7), stroke: 0.8pt)
  
  // Quota L
  line((0, 0), (0, -1.0), stroke: 0.5pt)
  line((3.2, -0.7), (3.2, -1.0), stroke: 0.5pt)
  line((0, -0.85), (3.2, -0.85), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((1.6, -0.65), text(size: 7pt)[$L$])
  
  // --- PANNELLO DESTRO: Configurazione deformata (traslato di +4.8 cm) ---
  line((4.8, 0), (4.8, 2.2), mark: (end: ">"), stroke: 0.7pt)
  content((5.05, 2.1), text(size: 7pt)[$y$])
  line((4.8, 0), (8.8, 0), mark: (end: ">"), stroke: 0.7pt)
  content((8.7, -0.25), text(size: 7pt)[$x$])
  
  // Trave indeformata
  line((4.8, 0), (8.0, 0), stroke: 1.6pt)
  content((7.75, 0.35), text(size: 7pt)[$"B"$])
  
  // Deformata tratteggiata (tangente orizzontale in B=(8.0, 0), passa per (4.8, -0.65) -> R=8.201, cy=-8.201)
  arc((8.0, -8.201), start: 90deg, stop: 112.97deg, radius: 8.201, anchor: "origin", stroke: (dash: "dashed", thickness: 1.2pt))
  
  // Freccia v_A
  line((4.8, 0), (4.8, -0.65), mark: (end: ">"), stroke: 1.2pt)
  content((4.5, -0.35), text(size: 7pt)[$v_A$])
  
  // Muro di incastro in B
  rect((8.0, -0.7), (8.35, 0.7), fill: luma(230), stroke: none)
  line((8.0, -0.7), (8.0, 0.7), stroke: 0.8pt)
  
  // Quota L
  line((4.8, -0.65), (4.8, -1.0), stroke: 0.5pt)
  line((8.0, -0.7), (8.0, -1.0), stroke: 0.5pt)
  line((4.8, -0.85), (8.0, -0.85), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((6.4, -0.65), text(size: 7pt)[$L$])
})
]

La funzione del momento flettente lungo la trave, a partire dall'estremo libero $x = 0$, è data da:

$ M(x) = - P x $

Sostituendo tale espressione nell'equazione differenziale della linea elastica si ottiene:

$ (d^2 v) / (d x^2) = (M(x)) / (E J) = - (P x) / (E J) $

Integrando una prima volta rispetto a $x$ si ricava l'espressione della rotazione:

$ E J (d v) / (d x) = - 1 / 2 P x^2 + C_1 $

All'incastro ($x = L$) la rotazione della sezione è impedita dal vincolo, pertanto la condizione al contorno impone $theta(L) = (d v) / (d x) |_(x=L) = 0$. Sostituendo tale condizione si determina $C_1$:

$ - 1 / 2 P L^2 + C_1 = 0 quad arrow.r.double quad C_1 = 1 / 2 P L^2 $

L'equazione delle rotazioni diventa quindi:

$ E J (d v) / (d x) = - 1 / 2 P x^2 + 1 / 2 P L^2 $

Integrando una seconda volta si ottiene l'espressione generale dello spostamento trasversale:

$ E J v(x) = - 1 / 6 P x^3 + 1 / 2 P L^2 x + C_2 $

All'incastro ($x = L$) anche la freccia è nulla per effetto del vincolo: $v(L) = 0$. Sostituendo $x = L$ nell'equazione della freccia si ricava la seconda costante di integrazione $C_2$:

$ - 1 / 6 P L^3 + 1 / 2 P L^3 + C_2 = 0 quad arrow.r.double quad C_2 = - 1 / 3 P L^3 $

L'equazione definitiva della linea elastica per la mensola caricata all'estremo è pertanto:

$ E J v(x) = - 1 / 6 P x^3 + 1 / 2 P L^2 x - 1 / 3 P L^3 $

Ponendo $x = 0$ nelle equazioni della freccia e della rotazione, si ottengono i valori massimi cercati in corrispondenza dell'estremità libera $A$:

$ v_A = v(0) = - (P L^3) / (3 E J) , quad theta_A = ( (d v) / (d x) )_A = (P L^2) / (2 E J) $

=== Esempio 2: Trave appoggiata con carico uniformemente distribuito

La trave $A B$ di lunghezza $L$, semplicemente appoggiata agli estremi $A$ ($x = 0$) e $B$ ($x = L$), è sottoposta a un carico trasversale per unità di lunghezza uniformemente distribuito $q$ rivolto verso il basso. Si vogliono ricavare l'equazione della linea elastica e lo spostamento massimo $v_"max"$.

#align(center)[
#canvas(length: 1cm, {
  import draw: *
  
  // --- PANNELLO SINISTRO: Trave con carico distribuito q ---
  line((0, 0), (0, 2.0), mark: (end: ">"), stroke: 0.7pt)
  content((0.25, 1.9), text(size: 7pt)[$y$])
  line((0, 0), (4.2, 0), mark: (end: ">"), stroke: 0.7pt)
  content((4.1, -0.25), text(size: 7pt)[$x$])
  
  // Trave AB
  line((0, 0), (3.6, 0), stroke: 1.6pt)
  content((-0.25, 0.2), text(size: 7pt)[$"A"$])
  content((3.85, 0.2), text(size: 7pt)[$"B"$])
  
  // Carico distribuito q
  line((0, 0.55), (3.6, 0.55), stroke: 0.6pt)
  line((0.0, 0.55), (0.0, 0.05), mark: (end: ">"), stroke: 0.6pt)
  line((0.3, 0.55), (0.3, 0.05), mark: (end: ">"), stroke: 0.6pt)
  line((0.6, 0.55), (0.6, 0.05), mark: (end: ">"), stroke: 0.6pt)
  line((0.9, 0.55), (0.9, 0.05), mark: (end: ">"), stroke: 0.6pt)
  line((1.2, 0.55), (1.2, 0.05), mark: (end: ">"), stroke: 0.6pt)
  line((1.5, 0.55), (1.5, 0.05), mark: (end: ">"), stroke: 0.6pt)
  line((1.8, 0.55), (1.8, 0.05), mark: (end: ">"), stroke: 0.6pt)
  line((2.1, 0.55), (2.1, 0.05), mark: (end: ">"), stroke: 0.6pt)
  line((2.4, 0.55), (2.4, 0.05), mark: (end: ">"), stroke: 0.6pt)
  line((2.7, 0.55), (2.7, 0.05), mark: (end: ">"), stroke: 0.6pt)
  line((3.0, 0.55), (3.0, 0.05), mark: (end: ">"), stroke: 0.6pt)
  line((3.3, 0.55), (3.3, 0.05), mark: (end: ">"), stroke: 0.6pt)
  line((3.6, 0.55), (3.6, 0.05), mark: (end: ">"), stroke: 0.6pt)
  content((1.8, 0.8), text(size: 7pt)[$q$])
  
  // Vincolo A (cerniera)
  line((-0.2, -0.4), (0.2, -0.4), (0, -0.06), close: true, stroke: 0.7pt)
  line((-0.3, -0.4), (0.3, -0.4), stroke: 0.7pt)
  circle((0, -0.03), radius: 0.05, fill: white, stroke: 0.7pt)
  
  // Vincolo B (carrello)
  line((3.4, -0.4), (3.8, -0.4), (3.6, -0.06), close: true, stroke: 0.7pt)
  circle((3.5, -0.46), radius: 0.06, stroke: 0.7pt)
  circle((3.7, -0.46), radius: 0.06, stroke: 0.7pt)
  line((3.3, -0.52), (3.9, -0.52), stroke: 0.7pt)
  circle((3.6, -0.03), radius: 0.05, fill: white, stroke: 0.7pt)
  
  // Quota L
  line((0, -0.5), (0, -1.1), stroke: 0.5pt)
  line((3.6, -0.55), (3.6, -1.1), stroke: 0.5pt)
  line((0, -0.95), (3.6, -0.95), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((1.8, -0.75), text(size: 7pt)[$L$])
  
  // --- PANNELLO DESTRO: Deformata (traslato di +4.8 cm) ---
  line((4.8, 0), (4.8, 2.0), mark: (end: ">"), stroke: 0.7pt)
  content((5.05, 1.9), text(size: 7pt)[$y$])
  line((4.8, 0), (9.0, 0), mark: (end: ">"), stroke: 0.7pt)
  content((8.9, -0.25), text(size: 7pt)[$x$])
  
  // Trave AB indeformata
  line((4.8, 0), (8.4, 0), stroke: 1.6pt)
  content((4.55, 0.2), text(size: 7pt)[$"A"$])
  content((8.65, 0.2), text(size: 7pt)[$"B"$])
  
  // Deformata tratteggiata (passa per (4.8,0), (6.6,-0.4), (8.4,0) -> R=4.25, cy=3.85)
  arc((6.6, 3.85), start: 244.98deg, stop: 295.02deg, radius: 4.25, anchor: "origin", stroke: (dash: "dashed", thickness: 1.0pt))
  
  // Freccia v_max in mezzeria (x = 6.6)
  line((6.6, 0), (6.6, -0.4), mark: (end: ">"), stroke: 0.8pt)
  content((6.85, -0.55), text(size: 7pt)[$v_"max"$])
  
  // Vincolo A
  line((4.6, -0.4), (5.0, -0.4), (4.8, -0.06), close: true, stroke: 0.7pt)
  line((4.5, -0.4), (5.1, -0.4), stroke: 0.7pt)
  circle((4.8, -0.03), radius: 0.05, fill: white, stroke: 0.7pt)
  
  // Vincolo B
  line((8.2, -0.4), (8.6, -0.4), (8.4, -0.06), close: true, stroke: 0.7pt)
  circle((8.3, -0.46), radius: 0.06, stroke: 0.7pt)
  circle((8.5, -0.46), radius: 0.06, stroke: 0.7pt)
  line((8.1, -0.52), (8.7, -0.52), stroke: 0.7pt)
  circle((8.4, -0.03), radius: 0.05, fill: white, stroke: 0.7pt)
  
  // Quote L/2 e L/2
  line((4.8, -0.5), (4.8, -1.1), stroke: 0.5pt)
  line((6.6, -0.4), (6.6, -1.1), stroke: 0.5pt)
  line((8.4, -0.55), (8.4, -1.1), stroke: 0.5pt)
  line((4.8, -0.95), (6.6, -0.95), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((5.7, -0.75), text(size: 7pt)[$L / 2$])
  line((6.6, -0.95), (8.4, -0.95), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((7.5, -0.75), text(size: 7pt)[$L / 2$])
})
]


Dall'equilibrio statico della trave, le reazioni vincolari verticali in $A$ e $B$ valgono entrambe $1 / 2 q L$. La funzione del momento flettente lungo l'asse $x$ è quindi espressa da:

$ M(x) = 1 / 2 L q x - 1 / 2 q x^2 $

Sostituendo l'espressione del momento nell'equazione differenziale della linea elastica si ha:

$ E J (d^2 v) / (d x^2) = - 1 / 2 q x^2 + 1 / 2 L q x $

Procedendo per doppia integrazione successiva rispetto alla variabile $x$:
- Integrando una prima volta si ottiene l'equazione delle rotazioni flessionali:
  $ E J (d v) / (d x) = - 1 / 6 q x^3 + 1 / 4 L q x^2 + C_1 $
- Integrando una seconda volta si ottiene l'equazione generale degli spostamenti verticali:
  $ E J v(x) = - 1 / 24 q x^4 + 1 / 12 L q x^3 + C_1 x + C_2 $


// === Blocco_02_Slide_16-30 ===

Le condizioni di vincolo agli estremi della trave semplicemente appoggiata impongono:
- $v(0) = 0$: spostamento verticale nullo in corrispondenza dell'appoggio fisso $A$;
- $v(L) = 0$: spostamento verticale nullo in corrispondenza dell'appoggio scorrevole $B$.

Sostituendo tali condizioni nell'equazione generale della freccia si ricavano le costanti di integrazione $C_1$ e $C_2$:

$ v(0) = 0 quad arrow.r.double quad C_2 = 0 $

$ v(L) = 0 quad arrow.r.double quad - 1 / 24 q L^4 + 1 / 12 q L^4 + C_1 L + 0 = 0 quad arrow.r.double quad C_1 = - 1 / 24 q L^3 $

L'equazione della linea elastica assume quindi la forma:

$ E J v(x) = - 1 / 24 q x^4 + 1 / 12 L q x^3 - 1 / 24 q L^3 x $

Raccogliendo il fattore comune $- q / (24 E J)$, la deformata si esprime come:

$ v(x) = - q / (24 E J) (x^4 - 2 L x^3 + L^3 x) $

Per la simmetria del sistema e del carico, lo spostamento massimo (in valore assoluto) si verifica in corrispondenza della sezione di mezzeria ($x = L / 2$), nella quale la rotazione flessionale è nulla ($theta(L / 2) = 0$):

$ v_"max" = v(L / 2) = - q / (24 E J) ( (L / 2)^4 - 2 L (L / 2)^3 + L^3 (L / 2) ) = - (5 q L^4) / (384 E J) $

=== Esempio 3: Trave appoggiata con carico concentrato eccentrico

La trave prismatica $A B$ di lunghezza $L$, semplicemente appoggiata agli estremi, è sottoposta a un carico concentrato verticale $P$ applicato nel punto $D$, posto a distanza $L / 4$ dall'appoggio $A$. Si vogliono determinare l'equazione della linea elastica e la freccia $v_D$ nel punto di applicazione del carico.

#align(center)[
#canvas(length: 1cm, {
  import draw: *
  
  // --- PANNELLO SINISTRO: Trave con carico concentrato P in D ---
  line((0, 0), (0, 2.0), mark: (end: ">"), stroke: 0.7pt)
  content((0.25, 1.9), text(size: 7pt)[$y$])
  line((0, 0), (4.2, 0), mark: (end: ">"), stroke: 0.7pt)
  content((4.1, -0.25), text(size: 7pt)[$x$])
  
  // Trave AB
  line((0, 0), (3.6, 0), stroke: 1.6pt)
  content((-0.25, 0.2), text(size: 7pt)[$"A"$])
  content((0.9, -0.25), text(size: 7pt)[$"D"$])
  content((3.85, 0.2), text(size: 7pt)[$"B"$])
  
  // Carico P in D (x = 0.9)
  line((0.9, 1.3), (0.9, 0.05), mark: (end: ">"), stroke: 1.5pt)
  content((1.15, 1.0), text(size: 7pt)[$P$])
  
  // Vincolo A
  line((-0.2, -0.4), (0.2, -0.4), (0, -0.06), close: true, stroke: 0.7pt)
  line((-0.3, -0.4), (0.3, -0.4), stroke: 0.7pt)
  circle((0, -0.03), radius: 0.05, fill: white, stroke: 0.7pt)
  
  // Vincolo B
  line((3.4, -0.4), (3.8, -0.4), (3.6, -0.06), close: true, stroke: 0.7pt)
  circle((3.5, -0.46), radius: 0.06, stroke: 0.7pt)
  circle((3.7, -0.46), radius: 0.06, stroke: 0.7pt)
  line((3.3, -0.52), (3.9, -0.52), stroke: 0.7pt)
  circle((3.6, -0.03), radius: 0.05, fill: white, stroke: 0.7pt)
  
  // Quote L/4 e 3L/4
  line((0, -0.5), (0, -1.1), stroke: 0.5pt)
  line((0.9, -0.4), (0.9, -1.1), stroke: 0.5pt)
  line((3.6, -0.55), (3.6, -1.1), stroke: 0.5pt)
  line((0, -0.95), (0.9, -0.95), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((0.45, -0.7), text(size: 7pt)[$L / 4$])
  line((0.9, -0.95), (3.6, -0.95), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((2.25, -0.7), text(size: 7pt)[$3 L / 4$])
  
  // --- PANNELLO DESTRO: Deformata (traslato di +4.8 cm) ---
  line((4.8, 0), (4.8, 2.0), mark: (end: ">"), stroke: 0.7pt)
  content((5.05, 1.9), text(size: 7pt)[$y$])
  line((4.8, 0), (9.0, 0), mark: (end: ">"), stroke: 0.7pt)
  content((8.9, -0.25), text(size: 7pt)[$x$])
  
  // Trave AB indeformata
  line((4.8, 0), (8.4, 0), stroke: 1.6pt)
  content((4.55, 0.2), text(size: 7pt)[$"A"$])
  content((8.65, 0.2), text(size: 7pt)[$"B"$])
  
  // Deformata asimmetrica tratteggiata
  bezier((4.8, 0), (6.0, -0.38), (5.2, -0.28), (5.6, -0.38), stroke: (dash: "dashed", thickness: 1.0pt))
  bezier((6.0, -0.38), (8.4, 0), (6.7, -0.38), (7.6, -0.15), stroke: (dash: "dashed", thickness: 1.0pt))
  
  // Freccia v_D in x = 5.7
  line((5.7, 0), (5.7, -0.36), mark: (end: ">"), stroke: 0.8pt)
  content((5.95, -0.52), text(size: 7pt)[$v_D$])
  
  // Vincolo A
  line((4.6, -0.4), (5.0, -0.4), (4.8, -0.06), close: true, stroke: 0.7pt)
  line((4.5, -0.4), (5.1, -0.4), stroke: 0.7pt)
  circle((4.8, -0.03), radius: 0.05, fill: white, stroke: 0.7pt)
  
  // Vincolo B
  line((8.2, -0.4), (8.6, -0.4), (8.4, -0.06), close: true, stroke: 0.7pt)
  circle((8.3, -0.46), radius: 0.06, stroke: 0.7pt)
  circle((8.5, -0.46), radius: 0.06, stroke: 0.7pt)
  line((8.1, -0.52), (8.7, -0.52), stroke: 0.7pt)
  circle((8.4, -0.03), radius: 0.05, fill: white, stroke: 0.7pt)
  
  // Quote L/4 e 3L/4
  line((4.8, -0.5), (4.8, -1.1), stroke: 0.5pt)
  line((5.7, -0.4), (5.7, -1.1), stroke: 0.5pt)
  line((8.4, -0.55), (8.4, -1.1), stroke: 0.5pt)
  line((4.8, -0.95), (5.7, -0.95), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((5.25, -0.7), text(size: 7pt)[$L / 4$])
  line((5.7, -0.95), (8.4, -0.95), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((7.05, -0.7), text(size: 7pt)[$3 L / 4$])
})
]

In presenza del carico concentrato in $D$, la caratteristica del momento flettente è una funzione *continua a tratti*:
- Nel tratto $A D$ ($0 <= x <= L / 4$):
  $ M_(A D) (x) = (3 P) / 4 x $
- Nel tratto $D B$ ($L / 4 <= x <= L$):
  $ M_(D B) (x) = (3 P) / 4 x - P (x - L / 4) = - 1 / 4 P x + 1 / 4 P L $

#align(center)[
#canvas(length: 1cm, {
  import draw: *
  
  // Asse trave
  line((0, 0), (6.0, 0), stroke: 2.0pt)
  content((-0.2, 0.35), text(size: 7pt)[$"A"$])
  content((1.8, 0.35), text(size: 7pt)[$"D"$])
  content((6.2, 0.35), text(size: 7pt)[$"B"$])
  
  // Diagramma del momento flettente
  line((0, 0), (1.8, -1.1), stroke: 0.9pt + rgb("#3b6291"))
  line((1.8, -1.1), (6.0, 0), stroke: 0.9pt + rgb("#3b6291"))
  line((1.8, 0), (1.8, -1.1), stroke: 0.8pt + rgb("#3b6291"))
  
  // Segni ed etichette
  content((1.35, -0.45), text(size: 7pt)[$+$])
  content((2.25, -0.45), text(size: 7pt)[$+$])
  content((0.5, -0.85), text(size: 7pt)[$M_(A D)$])
  content((3.8, -1.05), text(size: 7pt)[$M_(D B)$])
})
]


Si procede quindi all'integrazione dell'equazione della linea elastica separatamente nei due tratti:

1. *Tratto $A D$ ($0 <= x <= L / 4$)*:
   $ E J (d^2 v_(A D)) / (d x^2) = M_(A D) = (3 P) / 4 x $
   Integrando una prima e una seconda volta si ottiene:
   $ E J theta_(A D) (x) = E J (d v_(A D)) / (d x) = (3 P) / 8 x^2 + C_1 $
   $ E J v_(A D) (x) = 1 / 8 P x^3 + C_1 x + C_2 $

2. *Tratto $D B$ ($L / 4 <= x <= L$)*:
   $ E J (d^2 v_(D B)) / (d x^2) = M_(D B) = - 1 / 4 P x + 1 / 4 P L $
   Integrando una prima e una seconda volta si ottiene:
   $ E J theta_(D B) (x) = E J (d v_(D B)) / (d x) = - 1 / 8 P x^2 + 1 / 4 P L x + C_3 $
   $ E J v_(D B) (x) = - 1 / 24 P x^3 + 1 / 8 P L x^2 + C_3 x + C_4 $

Le quattro costanti di integrazione $C_1, C_2, C_3, C_4$ si determinano imponendo quattro condizioni al contorno complessivamente (due di vincolo agli estremi e due di continuità e congruenza nel punto $D$):
- Spostamento nullo sull'appoggio $A$: $v_(A D) (0) = 0$;
- Spostamento nullo sull'appoggio $B$: $v_(D B) (L) = 0$;
- Uguaglianza della freccia in $D$: $v_(A D) (1 / 4 L) = v_(D B) (1 / 4 L)$;
- Uguaglianza della rotazione flessionale in $D$: $theta_(A D) (1 / 4 L) = theta_(D B) (1 / 4 L)$.

Sostituendo tali condizioni nelle espressioni di rotazione e freccia dei due tratti si ottiene il sistema algebrico lineare:

$ cases(
  C_2 = 0,
  1 / 12 P L^3 + C_3 L + C_4 = 0,
  (3 P L^2) / 128 + C_1 = (7 P L^2) / 128 + C_3,
  (P L^3) / 512 + 1 / 4 C_1 L = (11 P L^3) / 1536 + 1 / 4 C_3 L + C_4
) $

Risolvendo il sistema si ricavano le quattro costanti di integrazione:

$ C_1 = - (7 P L^2) / 128 , quad C_2 = 0 , quad C_3 = - (11 P L^2) / 128 , quad C_4 = (P L^3) / 384 $

Sostituendo $C_1$ e $C_2$ nelle equazioni del tratto $A D$, si ottengono le leggi complete della rotazione e della freccia per $0 <= x <= L / 4$:

$ E J theta_(A D) (x) = 3 / 8 P x^2 - 7 / 128 P L^2 $

$ E J v_(A D) (x) = 1 / 8 P x^3 - (7 P L^2) / 128 x $

Valutando infine tali espressioni in $x = L / 4$, si ricavano la rotazione e la freccia nel punto $D$:

$ theta_D = - (P L^2) / (32 E J) , quad v_D = - (3 P L^3) / (256 E J) $


== Principio di sovrapposizione degli effetti e casi notevoli

Nel caso di *travi a singola campata* soggette a condizioni di carico elementari, è sempre possibile calcolare frecce e rotazioni in modo analitico chiuso, creando un *database di casi notevoli* per travi diversamente caricate e vincolate.

Nel caso di *strutture articolate* o più complesse, il momento flettente è generalmente una funzione *continua a tratti*. Per determinare la deformata si può procedere in due modi:
1. Effettuare un'*integrazione analitica a tratti* dell'equazione differenziale della linea elastica;
2. Utilizzare il *principio di sovrapposizione degli effetti*, pienamente valido poiché si opera sotto le ipotesi di linearità elastica e di piccoli spostamenti.

#nota[
Grazie all'ipotesi di piccoli spostamenti è possibile:
- Applicare separatamente le diverse condizioni di carico risolvendo ciascuno schema elementare per calcolare la relativa freccia e rotazione flessionale, sommandone poi algebricamente i contributi.
- Valutare separatamente gli effetti locali dei vincoli (ad esempio cedimenti o rotazioni imposte dalle parti adiacenti della struttura) e sommarne algebricamente gli effetti.
- Riconoscere e scomporre la struttura complessa in schemi elementari presenti nelle tabelle dei *casi notevoli*, sommando infine i singoli spostamenti e rotazioni.
]




=== Esempio applicativo: Trave appoggiata con sbalzo

Si consideri la trave continua $A B C$ appoggiata in $A$ e $B$ (campata $A B$ di luce $2 a$) e dotata di uno sbalzo $B C$ di lunghezza $a$. La struttura è soggetta a un carico verticale $F_1$ applicato nella mezzeria del tratto $A B$, a un carico verticale $F_2$ e a una forza assiale di trazione $F_3$ applicati all'estremo libero $C$. Si vuole determinare lo spostamento verticale totale $v_T$ dell'estremità $C$.


#canvas(length: 1cm, {
  import draw: *

  // --- SCHEMA SUPERIORE: Configurazione di carico (y_base = 2.4) ---
  // Contorno trave
  line((0, 2.4), (6.6, 2.4), stroke: 1.6pt)

  // Carrello in A (x = 0)
  line((-0.2, 2.0), (0.2, 2.0), (0, 2.34), close: true, stroke: 0.7pt)
  circle((-0.1, 1.94), radius: 0.06, stroke: 0.7pt)
  circle((0.1, 1.94), radius: 0.06, stroke: 0.7pt)
  line((-0.3, 1.88), (0.3, 1.88), stroke: 0.7pt)
  circle((0, 2.37), radius: 0.05, fill: white, stroke: 0.7pt)

  // Cerniera in B (x = 4.4)
  line((4.2, 1.94), (4.6, 1.94), (4.4, 2.34), close: true, stroke: 0.7pt)
  line((4.1, 1.94), (4.7, 1.94), stroke: 0.7pt)
  circle((4.4, 2.37), radius: 0.05, fill: white, stroke: 0.7pt)

  // Forze F1, F2, F3
  line((2.2, 3.2), (2.2, 2.45), mark: (end: ">"), stroke: 0.9pt)
  line((6.6, 3.2), (6.6, 2.45), mark: (end: ">"), stroke: 0.9pt)
  line((6.65, 2.4), (7.8, 2.4), mark: (end: ">"), stroke: 0.9pt)

  // Quote a, a, a
  line((0, 1.8), (0, 1.2), stroke: 0.6pt)
  line((2.2, 2.3), (2.2, 1.2), stroke: 0.6pt)
  line((4.4, 1.8), (4.4, 1.2), stroke: 0.6pt)
  line((6.6, 1.8), (6.6, 1.2), stroke: 0.6pt)

  line((0, 1.35), (2.2, 1.35), mark: (start: ">", end: ">"), stroke: 0.7pt)
  line((2.2, 1.35), (4.4, 1.35), mark: (start: ">", end: ">"), stroke: 0.7pt)
  line((4.4, 1.35), (6.6, 1.35), mark: (start: ">", end: ">"), stroke: 0.7pt)

  // Etichette schema superiore
  content((0.0, 2.85), text(size: 7pt)[A])
  content((4.4, 2.85), text(size: 7pt)[B])
  content((6.6, 2.0), text(size: 7pt)[C])
  content((1.85, 2.85), text(size: 7pt)[$F_1$])
  content((6.25, 2.85), text(size: 7pt)[$F_2$])
  content((7.3, 2.0), text(size: 7pt)[$F_3$])
  content((1.1, 1.6), text(size: 7pt)[$a$])
  content((3.3, 1.6), text(size: 7pt)[$a$])
  content((5.5, 1.6), text(size: 7pt)[$a$])

  // --- SCHEMA INFERIORE: Deformata qualitativa (y_base = -0.5) ---
  // Contorno trave indeformata
  line((0, -0.5), (6.6, -0.5), stroke: 1.6pt)

  // Carrello in A (x = 0)
  line((-0.2, -0.9), (0.2, -0.9), (0, -0.56), close: true, stroke: 0.7pt)
  circle((-0.1, -0.96), radius: 0.06, stroke: 0.7pt)
  circle((0.1, -0.96), radius: 0.06, stroke: 0.7pt)
  line((-0.3, -1.02), (0.3, -1.02), stroke: 0.7pt)
  circle((0, -0.53), radius: 0.05, fill: white, stroke: 0.7pt)

  // Cerniera in B (x = 4.4)
  line((4.2, -0.96), (4.6, -0.96), (4.4, -0.56), close: true, stroke: 0.7pt)
  line((4.1, -0.96), (4.7, -0.96), stroke: 0.7pt)
  circle((4.4, -0.53), radius: 0.05, fill: white, stroke: 0.7pt)

  // Deformata tratteggiata
  bezier((0, -0.5), (4.4, -0.5), (1.5, 0.75), (3.0, 0.23), stroke: (dash: "dashed", thickness: 0.9pt))
  bezier((4.4, -0.5), (6.6, -1.65), (5.1, -0.87), (5.8, -1.23), stroke: (dash: "dashed", thickness: 0.9pt))

  // Forze F1, F2 e spostamento v_T
  line((2.2, 0.3), (2.2, -0.45), mark: (end: ">"), stroke: 0.9pt)
  line((6.6, 0.3), (6.6, -0.45), mark: (end: ">"), stroke: 0.9pt)
  line((6.6, -0.5), (6.6, -1.65), mark: (end: ">"), stroke: 0.9pt)

  // Etichette schema inferiore
  content((0.0, -0.05), text(size: 7pt)[A])
  content((4.4, -0.05), text(size: 7pt)[B])
  content((6.9, -0.45), text(size: 7pt)[C])
  content((1.85, -0.05), text(size: 7pt)[$F_1$])
  content((6.25, -0.05), text(size: 7pt)[$F_2$])
  content((6.95, -1.1), text(size: 7pt)[$v_T$])
})


Il carico assiale $F_3$ produce esclusivamente una deformazione assiale e non dà alcun contributo alla flessione né allo spostamento verticale $v_T$. Lo spostamento trasversale in $C$ è quindi determinato unicamente dagli effetti flessionali prodotti dai carichi $F_1$ e $F_2$.


// === Blocco_03_Slide_31-33 ===

Applicando il principio di sovrapposizione degli effetti, si analizzano separatamente le due condizioni di carico trasversale:

==== 1. Applicazione del solo carico $F_1$

Considerando attivo unicamente il carico $F_1$ posto nella mezzeria della campata $A B$ (di lunghezza $L = 2 a$), il tratto $A B$ si comporta come una trave inflessa semplicemente appoggiata a singola campata con carico concentrato in mezzeria. Il tratto a sbalzo $B C$, essendo completamente scarico ($M = 0$), rimane rettilineo e subisce una rotazione rigida attorno all
 cerniera $B$ pari alla rotazione d'estremità $theta_B$ della campata $A B$.

#align(center)[#canvas(length: 1cm, {
  import draw: *

  // Contorno trave indeformata ABC
  line((0, 0), (6.6, 0), stroke: 1.6pt)

  // Carrello in A (x = 0)
  line((-0.2, -0.4), (0.2, -0.4), (0, -0.06), close: true, stroke: 0.7pt)
  circle((-0.1, -0.46), radius: 0.06, stroke: 0.7pt)
  circle((0.1, -0.46), radius: 0.06, stroke: 0.7pt)
  line((-0.3, -0.52), (0.3, -0.52), stroke: 0.7pt)
  circle((0, -0.03), radius: 0.05, fill: white, stroke: 0.7pt)

  // Cerniera in B (x = 4.4)
  line((4.2, -0.46), (4.6, -0.46), (4.4, -0.06), close: true, stroke: 0.7pt)
  line((4.1, -0.46), (4.7, -0.46), stroke: 0.7pt)
  circle((4.4, -0.03), radius: 0.05, fill: white, stroke: 0.7pt)

  // Deformata tratteggiata: arco circolare su AB e tratto rettilineo tangente su BC
  arc((2.2, 3.107), start: 234.7deg, stop: 305.3deg, radius: 3.807, anchor: "origin", stroke: (dash: "dashed", thickness: 0.9pt))
  line((4.4, 0), (6.6, 0.85), stroke: (dash: "dashed", thickness: 0.9pt))

  // Carico F1 in mezzeria AB (x = 2.2) e spostamento v1 in C (x = 6.6)
  line((2.2, 0.85), (2.2, 0.05), mark: (end: ">"), stroke: 0.9pt)
  line((6.6, 0), (6.6, 0.85), mark: (end: ">"), stroke: 0.9pt)

  // Etichette
  content((0.0, 0.45), text(size: 7pt)[A])
  content((4.4, 0.45), text(size: 7pt)[B])
  content((6.6, -0.4), text(size: 7pt)[C])
  content((1.85, 0.55), text(size: 7pt)[$F_1$])
  content((6.95, 0.45), text(size: 7pt)[$v_1$])
}).4

), text(size: 7pt)[$v_1$])
})
]

Dalla tabella dei casi notevoli per una trave appoggiata di luce $L = 2 a$ caricata in mezzeria, la rotazione in $B$ vale $theta_B = (F_1 (2 a)^2) / (16 E J)$. La freccia verticale verso l'alto nel punto di estremità $C$ è quindi data dal prodotto della rotazione $theta_B$ per la lunghezza $a$ dello sbalzo $B C$:

$ v_1 = a theta_B = a (F_1 (2 a)^2) / (16 E J) = (F_1 a^3) / (4 E J) $

=== 2. Applicazione del solo carico $F_2$

Quando agisce il solo carico $F_2$ all'estremità dello sbalzo $C$, lo spostamento verticale complessivo verso il basso del punto $C$ risulta dalla somma di due effetti distinti:
1. L'effetto del momento flettente $C = a F_2$ trasmesso dallo sbalzo sull'appoggio $B$, che fa incurvare verso l'alto la campata $A B$ provocando una rotazione oraria della sezione in $B$ e un conseguente abbassamento rigido $v_2$ dell'estremo $C$.
2. L'inflessione elastica propria dello sbalzo $B C$, che si deforma come una mensola incastrata in $B$ sottoposta al carico di estremità $F_2$, producend
 un ulteriore abbassamento $v_3$.

#align(center)[
#canvas(length: 1cm, {
  import draw: *

  let blu = rgb(35, 95, 165)
  let rosso = rgb(185, 45, 45)
  let grigio = rgb(140, 140, 140)

  // =========================================================
  // PANNELLO 1 (SUPERIORE, y_base = 0): Rotazione rigida v2
  // =========================================================
  
  // Asse indeformato di riferimento
  line((0, 0), (6.5, 0), stroke: (paint: grigio, dash: "dashed", thickness: 0.7pt))

  // Appoggio sinistro A in (0, 0)
  line((-0.26, -0.35), (0.26, -0.35), (0, 0), close: true, stroke: 0.8pt)
  line((-0.32, -0.35), (0.32, -0.35), stroke: 0.8pt)
  line((-0.22, -0.35), (-0.08, -0.50), stroke: 0.6pt)
  line((-0.05, -0.35), (0.09, -0.50), stroke: 0.6pt)
  line((0.12, -0.35), (0.26, -0.50), stroke: 0.6pt)

  // Appoggio destro B in (4.4, 0)
  line((4.14, -0.35), (4.66, -0.35), (4.4, 0), close: true, stroke: 0.8pt)
  line((4.08, -0.35), (4.72, -0.35), stroke: 0.8pt)
  line((4.18, -0.35), (4.32, -0.50), stroke: 0.6pt)
  line((4.35, -0.35), (4.49, -0.50), stroke: 0.6pt)
  line((4.52, -0.35), (4.66, -0.50), stroke: 0.6pt)

  // Deformata campata AB (curva continua con pendenza a B pari a quella dello sbalzo)
  bezier((0, 0), (4.4, 0), (1.5, 0.85), (3.08, 0.85), stroke: 1.5pt)

  // Sbalzo BC ruotato rigidamente (prolungamento rettilineo tangente in B)
  line((4.4, 0), (6.5, -1.35), stroke: (dash: "dashed", thickness: 1.4pt))

  // Arco angolo di rotazione theta_B
  arc((4.4, 0), start: -32.7deg, stop: 0deg, radius: 1.15, anchor: "origin", mark: (start: ">"), stroke: (paint: rosso, thickness: 0.7pt))
  content((5.82, -0.32), text(size: 8pt, fill: rosso)[$theta_B$])

  // Freccia circolare della coppia M = BC * F2 applicata in B
  arc((4.4, 0), start: -50deg, stop: 145deg, radius: 0.42, anchor: "origin", mark: (start: ">"), stroke: (paint: blu, thickness: 0.9pt))
  content((5.15, 0.68), text(size: 9pt, fill: blu)[$M = B C dot F_2$])

  // Quota luce l = 2a e sbalzo a
  line((0, -0.60), (0, -1.05), stroke: (paint: grigio, thickness: 0.6pt))
  line((4.4, -0.60), (4.4, -1.05), stroke: (paint: grigio, thickness: 0.6pt))
  line((0, -0.85), (4.4, -0.85), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((2.2, -0.65), text(size: 8pt)[$l = 2 a$])

  // Quota abbassamento rigido v2
  line((6.55, 0), (7.05, 0), stroke: (paint: grigio, thickness: 0.7pt))
  line((6.55, -1.35), (7.05, -1.35), stroke: (paint: grigio, thickness: 0.7pt))
  line((6.90, 0), (6.90, -1.35), mark: (start: ">", end: ">"), stroke: (paint: rosso, thickness: 0.8pt))
  content((7.25, -0.68), text(size: 8.5pt, fill: rosso)[$v_2$])

  // Etichette nodi A, B, C
  content((-0.25, 0.25), text(size: 8pt)[$A$])
  content((4.15, 0.35), text(size: 8pt)[$B$])
  content((6.5, 0.25), text(size: 8pt)[$C$])

  // =========================================================
  // SEGNO PIÙ CENTRALE
  // =========================================================
  line((2.00, -1.95), (2.40, -1.95), stroke: 1.5pt)
  line((2.20, -1.75), (2.20, -2.15), stroke: 1.5pt)

  // =========================================================
  // PANNELLO 2 (INFERIORE, y_base = -3.60): Inflessione elastica v3
  // =========================================================
  let yb = -3.60

  // Orizzontale di riferimento
  line((0, yb), (6.5, yb), stroke: (paint: grigio, dash: "dotted", thickness: 0.6pt))

  // Appoggio sinistro A
  line((-0.26, yb - 0.35), (0.26, yb - 0.35), (0, yb), close: true, stroke: 0.8pt)
  line((-0.32, yb - 0.35), (0.32, yb - 0.35), stroke: 0.8pt)
  line((-0.22, yb - 0.35), (-0.08, yb - 0.50), stroke: 0.6pt)
  line((-0.05, yb - 0.35), (0.09, yb - 0.50), stroke: 0.6pt)
  line((0.12, yb - 0.35), (0.26, yb - 0.50), stroke: 0.6pt)

  // Deformata campata AB (tratteggiata, già avvenuta nel pannello 1)
  bezier((0, yb), (4.4, yb), (1.5, yb + 0.85), (3.08, yb + 0.85), stroke: (dash: "dashed", thickness: 1.2pt))

  // Incastro inclinato in B (ortogonale alla tangente ruotata di theta_B)
  line((4.16, yb - 0.38), (4.64, yb + 0.38), stroke: 1.1pt)
  line((4.20, yb - 0.32), (3.96, yb - 0.28), stroke: 0.6pt)
  line((4.28, yb - 0.19), (4.04, yb - 0.15), stroke: 0.6pt)
  line((4.36, yb - 0.06), (4.12, yb - 0.02), stroke: 0.6pt)
  line((4.44, yb + 0.06), (4.20, yb + 0.10), stroke: 0.6pt)
  line((4.52, yb + 0.19), (4.28, yb + 0.23), stroke: 0.6pt)
  line((4.60, yb + 0.32), (4.36, yb + 0.36), stroke: 0.6pt)

  // Tangente rigida di riferimento (tratteggiata) e curva elastica inflessa (piena)
  line((4.4, yb), (6.5, yb - 1.35), stroke: (paint: grigio, dash: "dashed", thickness: 0.9pt))
  bezier((4.4, yb), (6.5, yb - 2.10), (5.24, yb - 0.54), (5.95, yb - 1.45), stroke: 1.5pt)

  // Forza concentrata F2 all'estremo C
  line((6.5, yb - 0.85), (6.5, yb - 2.05), mark: (end: ">"), stroke: (paint: blu, thickness: 1.0pt))
  content((6.20, yb - 0.95), text(size: 9pt, fill: blu)[$F_2$])

  // Quota v2 (riferimento superiore tratteggiato) e quota v3 (inflessione elastica)
  line((6.55, yb), (7.05, yb), stroke: (paint: grigio, thickness: 0.6pt))
  line((6.55, yb - 1.35), (7.05, yb - 1.35), stroke: (paint: grigio, thickness: 0.7pt))
  line((6.55, yb - 2.10), (7.05, yb - 2.10), stroke: (paint: grigio, thickness: 0.7pt))

  line((6.90, yb), (6.90, yb - 1.35), mark: (start: ">", end: ">"), stroke: (paint: grigio, dash: "dashed", thickness: 0.7pt))
  content((7.25, yb - 0.68), text(size: 8pt, fill: grigio)[$v_2$])

  line((6.90, yb - 1.35), (6.90, yb - 2.10), mark: (start: ">", end: ">"), stroke: (paint: rosso, thickness: 0.8pt))
  content((7.25, yb - 1.73), text(size: 8.5pt, fill: rosso)[$v_3$])

  // Etichette nodi
  content((-0.25, yb + 0.25), text(size: 8pt)[$A$])
  content((4.10, yb + 0.40), text(size: 8pt)[$B$])
})
]

Analizzando quantitativamente i due contributi mediante i casi notevoli si ha:

#align(center)[
#canvas(length: 1cm, {
  import draw: *

  let blu = rgb(35, 95, 165)
  let rosso = rgb(185, 45, 45)
  let grigio = rgb(140, 140, 140)
  
  // =========================================================
  // PANNELLO SINISTRO: Contributo v2 (coppia C = a F2 in B)
  // =========================================================
  
  // Trave indeformata ABC
  line((0, 0), (5.1, 0), stroke: 1.5pt)
  content((-0.2, 0.35), text(size: 8pt)[$A$])
  content((3.5, 0.48), text(size: 8pt)[$B$])
  content((5.1, 0.35), text(size: 8pt)[$C$])
  
  // Carrello in A
  line((-0.20, -0.35), (0.20, -0.35), (0, -0.04), close: true, stroke: 0.7pt)
  circle((-0.09, -0.41), radius: 0.05, stroke: 0.7pt)
  circle((0.09, -0.41), radius: 0.05, stroke: 0.7pt)
  line((-0.26, -0.46), (0.26, -0.46), stroke: 0.7pt)
  circle((0, -0.02), radius: 0.04, fill: white, stroke: 0.7pt)
  
  // Cerniera in B
  line((3.30, -0.35), (3.70, -0.35), (3.5, -0.04), close: true, stroke: 0.7pt)
  line((3.22, -0.35), (3.78, -0.35), stroke: 0.7pt)
  line((3.28, -0.35), (3.40, -0.48), stroke: 0.6pt)
  line((3.44, -0.35), (3.56, -0.48), stroke: 0.6pt)
  line((3.60, -0.35), (3.72, -0.48), stroke: 0.6pt)
  circle((3.5, -0.02), radius: 0.04, fill: white, stroke: 0.7pt)
  
  // Coppia concentrata C = a F2 in B (senso orario)
  arc((3.5, 0), start: -45deg, stop: 155deg, radius: 0.36, anchor: "origin", mark: (start: ">"), stroke: (paint: blu, thickness: 0.9pt))
  content((3.5, -0.75), text(size: 8pt, fill: blu)[$C = a F_2$])
  
  // Deformata tratteggiata (continua in B con rotazione theta_B)
  bezier((0, 0), (3.5, 0), (1.2, 0.65), (2.45, 0.65), stroke: (paint: rosso, dash: "dashed", thickness: 0.9pt))
  line((3.5, 0), (5.1, -0.95), stroke: (paint: rosso, dash: "dashed", thickness: 0.9pt))
  
  // Indicazione angolo theta_B
  arc((3.5, 0), start: -30.7deg, stop: 0deg, radius: 0.75, anchor: "origin", stroke: (paint: rosso, thickness: 0.6pt))
  content((4.45, -0.22), text(size: 7.5pt, fill: rosso)[$theta_B$])

  // Freccia spostamento v2
  line((5.15, 0), (5.45, 0), stroke: (paint: grigio, thickness: 0.6pt))
  line((5.15, -0.95), (5.45, -0.95), stroke: (paint: grigio, thickness: 0.6pt))
  line((5.35, 0), (5.35, -0.95), mark: (end: ">"), stroke: (paint: rosso, thickness: 0.9pt))
  content((5.68, -0.48), text(size: 8pt, fill: rosso)[$v_2$])

  // Quote geometriche 2a e a
  line((0, -1.10), (0, -1.40), stroke: (paint: grigio, thickness: 0.6pt))
  line((3.5, -1.10), (3.5, -1.40), stroke: (paint: grigio, thickness: 0.6pt))
  line((5.1, -1.10), (5.1, -1.40), stroke: (paint: grigio, thickness: 0.6pt))
  line((0, -1.28), (3.5, -1.28), mark: (start: ">", end: ">"), stroke: (paint: grigio, thickness: 0.6pt))
  line((3.5, -1.28), (5.1, -1.28), mark: (start: ">", end: ">"), stroke: (paint: grigio, thickness: 0.6pt))
  content((1.75, -1.10), text(size: 7.5pt)[$2 a$])
  content((4.30, -1.10), text(size: 7.5pt)[$a$])

  // =========================================================
  // SEGNO PIÙ TRA I DUE SCHEMI
  // =========================================================
  line((6.15, -0.25), (6.45, -0.25), stroke: 1.2pt)
  line((6.30, -0.10), (6.30, -0.40), stroke: 1.2pt)
  
  // =========================================================
  // PANNELLO DESTRO: Contributo v3 (mensola BC incastrata in B)
  // =========================================================
  let xb = 7.2
  let xc = 9.0

  // Incastro verticale in B
  line((xb, -0.65), (xb, 0.65), stroke: 1.0pt)
  line((xb, 0.55), (xb - 0.25, 0.38), stroke: 0.6pt)
  line((xb, 0.30), (xb - 0.25, 0.13), stroke: 0.6pt)
  line((xb, 0.05), (xb - 0.25, -0.12), stroke: 0.6pt)
  line((xb, -0.20), (xb - 0.25, -0.37), stroke: 0.6pt)
  line((xb, -0.45), (xb - 0.25, -0.62), stroke: 0.6pt)
  
  // Trave mensola BC indeformata
  line((xb, 0), (xc, 0), stroke: 1.5pt)
  content((xb + 0.2, 0.35), text(size: 8pt)[$B$])
  content((xc, 0.95), text(size: 8pt)[$C$])
  
  // Carico concentrato F2 in C
  line((xc, 0.75), (xc, 0.05), mark: (end: ">"), stroke: (paint: blu, thickness: 0.9pt))
  content((xc - 0.32, 0.50), text(size: 8pt, fill: blu)[$F_2$])
  
  // Deformata elastica della mensola (tangente orizzontale in B)
  bezier((xb, 0), (xc, -0.80), (xb + 0.75, 0), (xb + 1.30, -0.42), stroke: (paint: rosso, dash: "dashed", thickness: 0.9pt))

  // Freccia spostamento v3 (leggermente traslata per non sovrapporsi al nodo C)
  line((xc + 0.05, 0), (xc + 0.35, 0), stroke: (paint: grigio, thickness: 0.6pt))
  line((xc + 0.05, -0.80), (xc + 0.35, -0.80), stroke: (paint: grigio, thickness: 0.6pt))
  line((xc + 0.25, 0), (xc + 0.25, -0.80), mark: (end: ">"), stroke: (paint: rosso, thickness: 0.9pt))
  content((xc + 0.58, -0.40), text(size: 8pt, fill: rosso)[$v_3$])

  // Quota geometrica a
  line((xb, -1.10), (xb, -1.40), stroke: (paint: grigio, thickness: 0.6pt))
  line((xc, -1.10), (xc, -1.40), stroke: (paint: grigio, thickness: 0.6pt))
  line((xb, -1.28), (xc, -1.28), mark: (start: ">", end: ">"), stroke: (paint: grigio, thickness: 0.6pt))
  content(((xb + xc) / 2, -1.10), text(size: 7.5pt)[$a$])
})
]

- *Primo contributo ($v_2$)*: Per una trave appoggiata di luce $L = 2 a$ soggetta a una coppia concentrata $C = a F_2$ sull'appoggio $B$, la rotazione della sezione $B$ vale $theta_B = (C L) / (3 E J)$. Moltiplicando tale rotazione per il braccio $a$ dello sbalzo si ottiene:
  $ v_2 = a theta_B = a (C (2 a)) / (3 E J) = a (2 a^2 F_2) / (3 E J) = (2 F_2 a^3) / (3 E J) $

- *Secondo contributo ($v_3$)*: Per una mensola di lunghezza $a$ incastrata in $B$ e soggetta al carico concentrato $F_2$ all'estremo libero $C$, la freccia vale:
  $ v_3 = (F_2 a^3) / (3 E J) $

==== 3. Sovrapposizione totale degli effetti

Sommando algebricamente i tre contributi (assumendo positivi gli spostamenti rivolti verso l'alto e negativi quelli rivolti verso il basso, come indicato nella deformata complessiva della sezione precedente), si ottiene la freccia totale $v_T$ nel punto di estremità $C$:

$ v_T = v_1 - v_2 - v_3 = a (F_1 (2 a)^2) / (16 E J) - a (2 a^2 F_2) / (3 E J) - (F_2 a^3) / (3 E J) = (F_1 a^3) / (4 E J) - (F_2 a^3) / (E J) $