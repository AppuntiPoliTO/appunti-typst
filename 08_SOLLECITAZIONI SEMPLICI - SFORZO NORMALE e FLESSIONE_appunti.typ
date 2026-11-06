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

// ============================================================================
// CODICE TYPST GENERATO DA GEMINI
// ============================================================================



// === Blocco_01_Slide_01-19 ===

= Introduzione al Metodo Semi-Inverso di de Saint Venant

L'andamento delle componenti di tensione su una sezione trasversale e la relazione matematica che le lega alle caratteristiche di sollecitazione (CdS) che le generano si ricavano mediante il *metodo semi-inverso di de Saint Venant*. Tale approccio si articola in cinque passaggi logici sequenziali:

+ *Ipotesi iniziale*: si definisce a priori l'espressione analitica del campo di spostamento della trave sottoposta alla specifica sollecitazione.
+ *Equazioni di congruenza*: si deriva il campo di spostamento ipotizzato per ottenere il corrispondente campo di deformazione.
+ *Equazioni costitutive del materiale*: si applica la legge elastica del materiale (legge di Hooke) al campo di deformazione, ricavando così il campo di tensione.
+ *Equazioni di equivalenza*: si impone la relazione integrale di equilibrio statico tra la componente di tensione agente sulla sezione e la caratteristica di sollecitazione che la genera.
+ *Determinazione dello stato tensionale*: combinando i risultati precedenti, si ottiene l'espressione finale della componente di tensione in funzione della caratteristica di sollecitazione.

= Sforzo Normale

== Campo di spostamento, deformazione e tensione

Applichiamo il procedimento di de Saint Venant a un elemento di trave rettilinea sottoposto esclusivamente a sforzo normale di trazione:

+ *Ipotesi iniziale (campo di spostamenti)*: una trave soggetta soltanto a sforzo normale di trazione subisce un allungamento assiale $u$ direttamente proporzionale alla coordinata longitudinale $x$, accompagnato da una contrazione trasversale lungo l'asse $y$:
  $ u(x) = k x $
  dove $k$ rappresenta una costante di proporzionalità.

#canvas(length: 1cm, {
  import draw: *
  // Assi coordinati
  line((0, -1.2), (0, 2.0), mark: (end: ">"), stroke: 0.7pt)
  content((-0.25, 1.85), text(size: 7pt)[$y$], anchor: "east")
  line((0, 0), (6.8, 0), mark: (end: ">"), stroke: 0.7pt)
  content((6.5, 0.25), text(size: 7pt)[$x$], anchor: "south")

  // Configurazione indeformata (tratteggiata)
  rect((0, -0.95), (4.6, 0.95), stroke: (dash: "dashed", thickness: 1.2pt))

  // Configurazione deformata (continua)
  rect((0, -0.78), (5.7, 0.78), stroke: 1.2pt)

  // Quota spostamento u
  line((4.6, -1.25), (5.7, -1.25), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((5.15, -1.4), text(size: 7pt)[$u$], anchor: "north")
})

+ *Equazioni di congruenza*: derivando lo spostamento assiale rispetto alla coordinata $x$, si ottiene il campo di deformazione longitudinale corrispondente:
  $ epsilon_(x x) = (d u) / (d x) = k $

+ *Equazioni costitutive*: ipotizzando che il materiale sia elastico lineare, omogeneo e isotropo, il campo di tensione normale è legato al campo di deformazione dalla legge di Hooke:
  $ sigma_(x x) = E epsilon_(x x) $
  dove $E$ è il modulo di elasticità longitudinale (o modulo di Young). Sostituendo l'espressione della deformazione assiale $epsilon_(x x) = (d u) / (d x) = k$, la tensione assiale assume la forma:
  $ sigma_(x x) = k E = "cost" $
  La tensione normale $sigma_(x x)$ prodotta dallo sforzo normale presenta dunque una distribuzione costante (uniforme) sull'intera sezione trasversale della trave.

== Equazioni di equivalenza e distribuzione tensionale

Poiché l'elemento di trave è soggetto soltanto a sforzo normale, le caratteristiche di sollecitazione agenti sulla sezione sono:
$ N_x != 0, quad M_y = M_z = M_x = T_y = T_z = 0 $

+ *Equazione di equivalenza*: l'unica componente di tensione in grado di generare lo sforzo normale $N_x$ è la tensione normale $sigma_(x x)$. Imponendo l'equivalenza alla traslazione lungo l'asse $x$ sull'area $A$ della sezione trasversale si ha:
  $ N_x = integral_A sigma_(x x) d A = integral_A k E d A = k E A $
  da cui si ricava il prodotto costante $k E = N_x / A$.

+ *Distribuzione delle tensioni*: sostituendo il valore di $k E$ nell'espressione costitutiva, si ottiene la distribuzione uniforme di tensione normale $sigma_(x x)$ generata dallo sforzo normale $N_x$:
  $ sigma_(x x) = N_x / A $

#canvas(length: 1cm, {
  import draw: *
  // Assi
  line((0, -1.1), (0, 1.8), mark: (end: ">"), stroke: 0.7pt)
  content((-0.2, 1.65), text(size: 7pt)[$y$], anchor: "east")
  line((0, 0), (6.5, 0), mark: (end: ">"), stroke: 0.7pt)
  content((6.1, -0.35), text(size: 7pt)[$x$], anchor: "north")

  // Trave
  rect((0, -0.9), (4.3, 0.9), stroke: 1.5pt)

  // Distribuzione uniforme di tensione (in rosso)
  line((5.4, -0.9), (5.4, 0.9), stroke: (paint: red, thickness: 0.9pt))
  line((4.3, 0.9), (5.4, 0.9), mark: (end: ">"), stroke: (paint: red, thickness: 0.8pt))
  line((4.3, 0.6), (5.4, 0.6), mark: (end: ">"), stroke: (paint: red, thickness: 0.8pt))
  line((4.3, 0.3), (5.4, 0.3), mark: (end: ">"), stroke: (paint: red, thickness: 0.8pt))
  line((4.3, 0.0), (5.4, 0.0), mark: (end: ">"), stroke: (paint: red, thickness: 0.8pt))
  line((4.3, -0.3), (5.4, -0.3), mark: (end: ">"), stroke: (paint: red, thickness: 0.8pt))
  line((4.3, -0.6), (5.4, -0.6), mark: (end: ">"), stroke: (paint: red, thickness: 0.8pt))
  line((4.3, -0.9), (5.4, -0.9), mark: (end: ">"), stroke: (paint: red, thickness: 0.8pt))

  // Formula
  content((5.8, 0.55), text(size: 7pt, fill: red)[$sigma_(x x) = N_x / A$], anchor: "west")
})

La sezione trasversale si sposta dunque assialmente mantenendosi piana e parallela a se stessa, essendo soggetta al solo sforzo normale $N = N_x$.

#canvas(length: 1.5cm, {
  import draw: *
  // --- Pannello Sinistro: Vista laterale ---
  line((0, -1.1), (1.8, -1.1), (1.8, 1.1), (0, 1.1), stroke: 1pt)
  // Linea di frattura a sinistra
  line((0, 1.1), (-0.05, 0.7), (0.04, 0.3), (-0.06, -0.1), (0.03, -0.5), (-0.04, -0.8), (0, -1.1), stroke: 1pt)

  // Terna d'assi
  line((0.4, -0.1), (1.1, -0.1), mark: (end: ">"), stroke: 0.8pt)
  content((1.1, -0.25), text(size: 7pt)[$x$], anchor: "north")
  line((0.4, -0.1), (0.4, 0.65), mark: (end: ">"), stroke: 0.8pt)
  content((0.3, 0.55), text(size: 7pt)[$y$], anchor: "east")
  circle((0.4, -0.1), radius: 0.14, fill: white, stroke: 0.8pt)
  circle((0.4, -0.1), radius: 0.04, fill: black)
  content((0.2, -0.25), text(size: 7pt)[$z$], anchor: "north")

  // Vettore N
  line((1.95, -0.1), (2.5, -0.1), mark: (end: ">"), stroke: 1pt)
  content((2.15, 0.05), text(size: 7pt)[$N$], anchor: "south")

  // Diagramma rettangolare frontale
  rect((2.8, -1.1), (3.35, 1.1), stroke: 1pt)
  line((2.8, 0.9), (3.35, 0.9), stroke: 0.6pt)
  line((2.8, 0.7), (3.35, 0.7), stroke: 0.6pt)
  line((2.8, 0.5), (3.35, 0.5), stroke: 0.6pt)
  line((2.8, 0.3), (3.35, 0.3), stroke: 0.6pt)
  line((2.8, 0.1), (3.35, 0.1), stroke: 0.6pt)
  line((2.8, -0.1), (3.35, -0.1), stroke: 0.6pt)
  line((2.8, -0.3), (3.35, -0.3), stroke: 0.6pt)
  line((2.8, -0.5), (3.35, -0.5), stroke: 0.6pt)
  line((2.8, -0.7), (3.35, -0.7), stroke: 0.6pt)
  line((2.8, -0.9), (3.35, -0.9), stroke: 0.6pt)
  content((3.5, 1.05), text(size: 12pt)[$sigma_(x x) = N / A$], anchor: "west")

  // --- Pannello Destro: Sezione trasversale e proiezione ---
  // Assi sezione (centro in 6.8, 0.0)
  line((5.6, 0.0), (8.0, 0.0), stroke: 0.7pt)
  content((5.75, 0.15), text(size: 10pt)[$z$], anchor: "south")
  line((6.8, -1.4), (6.8, 1.45), stroke: 0.7pt)
  content((6.7, 1.4), text(size: 7pt)[$y$], anchor: "east")

  // Sezione ovoidale (due semicerchi/archi ellittici raccordati)
  arc((6.8, 0.0), start: 0deg, stop: 180deg, radius: (0.95, 1.25), anchor: "origin", stroke: 1pt)
  arc((6.8, 0.0), start: 180deg, stop: 360deg, radius: (0.95, 1.05), anchor: "origin", stroke: 1pt)

  // Linee di proiezione a 45 gradi
  line((6.13, 0.88), (4.95, -0.3), stroke: (dash: "dashed", thickness: 0.7pt))
  line((7.47, -0.74), (6.55, -1.66), stroke: (dash: "dashed", thickness: 0.7pt))

  // Rettangolo diagramma inclinato a 45 gradi
  line((4.95, -0.3), (6.55, -1.9), (6.1, -2.35), (4.5, -0.75), close: true, fill: luma(235), stroke: 1pt)
  line((4.8, -0.45), (6.4, -2.05), stroke: (dash: "dashed", thickness: 0.6pt))
  line((4.65, -0.6), (6.25, -2.2), stroke: (dash: "dashed", thickness: 0.6pt))

  // Segno + nel cerchietto
  circle((5.2, -1.1), radius: 0.16, fill: white, stroke: 0.8pt)
  content((5.2, -1.1), text(size: 7pt)[$+$])
  content((6.4, -2.2), text(size: 7pt)[$sigma_(x x)$], anchor: "north")
})

#nota[
  *Osservazione sul punto di applicazione dello sforzo normale*:
  Richiamiamo le equazioni di equivalenza relative ai momenti flettenti $M_z$ e $M_y$, i quali nel caso di sforzo normale puro sono entrambi nulli (essendo presente soltanto $N_x$):
  $ integral_A -sigma_(x x) y d A = M_z = 0, quad integral_A sigma_(x x) z d A = M_y = 0 $
  Dalla geometria delle aree sappiamo che i momenti statici della sezione rispetto agli assi $z$ e $y$ sono definiti rispettivamente come:
  $ integral_A y d A = S_z, quad integral_A z d A = S_y $
  Poiché la tensione $sigma_(x x)$ è costante e diversa da zero, portandola fuori dal segno di integrale si deduce che le relazioni di equivalenza alla rotazione sono soddisfatte se e solo se i momenti statici $S_z$ e $S_y$ sono nulli, ovvero se gli assi $y$ e $z$ coincidono con gli *assi baricentrici* della sezione trasversale. Lo sforzo normale centrato deve quindi essere applicato esattamente nel baricentro della sezione.
]

= Flessione

== Definizioni fondamentali e cinematica qualitativa

La *flessione pura* è una condizione di carico per cui, nelle sezioni trasversali della trave, l'unica caratteristica di sollecitazione presente è il momento flettente. A seconda dell'orientamento della sollecitazione rispetto alla geometria della sezione, si distinguono i seguenti regimi:
- *Flessione retta*: sulla generica sezione agisce un momento flettente contenuto in un piano che contiene a sua volta uno degli assi principali d'inerzia della sezione ($y$ oppure $z$).
- *Flessione deviata*: il piano del momento flettente non contiene alcuno degli assi principali d'inerzia.
- *Flessione semplice*: la sollecitazione di flessione è accompagnata anche da sollecitazioni di taglio.

Consideriamo una *trave rettilinea a sezione costante*, caricata alle estremità da due *momenti flettenti* $M_f$ uguali e contrari. I momenti flettenti agiscono nel *piano di sollecitazione* $pi$, il quale contiene l'asse geometrico longitudinale $x$ e l'*asse di sollecitazione* $y$. Assumiamo inoltre che la sezione trasversale $S$ sia *simmetrica* rispetto all'asse $y$ (definito dall'intersezione tra il piano di sollecitazione $pi$ e il piano della sezione stessa).

#canvas(length: 2cm, {
  import draw: *
  // --- Pannello Sinistro: Cilindro 3D e piano pi ---
  // Piano di sollecitazione pi (parallelogramma tratteggiato/sottile)
  line((-0.8, -1.4), (3.8, -1.4), (5.2, 1.3), (0.6, 1.3), close: true, stroke: (dash: "dashed", thickness: 0.6pt))
  content((5.1, -1.1), text(size: 7pt)[$pi$], anchor: "west")

  // Cilindro: base sinistra
  circle((0.3, 0.0), radius: (0.35, 0.95), stroke: 1.1pt)
  // Sezione centrale S ombreggiata
  circle((2.2, 0.0), radius: (0.35, 0.95), fill: rgb(220, 235, 250), stroke: 0.8pt)
  // Cilindro: base destra
  circle((4.1, 0.0), radius: (0.35, 0.95), stroke: 1.1pt)
  // Generatrici superiore e inferiore
  line((0.3, 0.95), (4.1, 0.95), stroke: 1.2pt)
  line((0.3, -0.95), (4.1, -0.95), stroke: 1.2pt)

  // Assi sul cilindro
  line((-0.4, 0.0), (5.1, 0.0), mark: (end: ">"), stroke: (dash: "dash-dotted", thickness: 0.7pt))
  content((5.0, -0.2), text(size: 7pt)[$x$], anchor: "north")
  line((2.2, -1.2), (2.2, 1.45), mark: (end: ">"), stroke: 0.7pt)
  content((2.05, 1.35), text(size: 7pt)[$y$], anchor: "east")
  line((2.9, 0.95), (1.3, -1.2), mark: (end: ">"), stroke: 0.7pt)
  content((1.4, -1.15), text(size: 7pt)[$z$], anchor: "west")

  // Indicatore sezione S
  line((2.6, 1.35), (2.35, 0.75), mark: (end: ">"), stroke: 0.6pt)
  content((2.65, 1.35), text(size: 7pt)[$S$], anchor: "west")

  // Momenti flettenti M_f agli estremi
  arc((-0.15, 0.0), start: 120deg, stop: 240deg, radius: 0.55, anchor: "origin", mark: (start: ">"), stroke: 1pt)
  content((-0.55, 0.45), text(size: 7pt)[$M_f$], anchor: "east")
  arc((4.55, 0.0), start: -60deg, stop: 60deg, radius: 0.55, anchor: "origin", mark: (end: ">"), stroke: 1pt)
  content((4.95, 0.45), text(size: 7pt)[$M_f$], anchor: "west")

  // --- Pannello Destro: Sezione frontale ---
  circle((6.9, 0.0), radius: 0.95, fill: rgb(220, 235, 250), stroke: 0.9pt)
  line((6.9, -1.25), (6.9, 1.45), mark: (end: ">"), stroke: 0.7pt)
  content((6.75, 1.35), text(size: 7pt)[$y$], anchor: "east")
  line((8.1, 0.0), (5.5, 0.0), mark: (end: ">"), stroke: 0.7pt)
  content((5.55, -0.25), text(size: 7pt)[$n = z$], anchor: "north")
})

Per effetto dell'applicazione dei momenti flettenti, la trave si inflette:
- L'asse geometrico si dispone secondo una curva detta *linea elastica*, che per una trave a sezione costante soggetta a momento flettente $M_f$ costante è approssimabile con un arco di circonferenza.
- La linea elastica giace nel *piano di inflessione* che, grazie alla simmetria della sezione, coincide esattamente con il piano di sollecitazione $pi$.
- Nella parte *convessa* (inferiore) della trave le fibre longitudinali si allungano, mentre nella parte *concava* (superiore) le fibre si accorciano: la sezione risulta quindi in parte tesa e in parte compressa.
- Le fibre che mantengono invariata la propria lunghezza iniziale sono quelle disposte sulla retta $n = z$, denominata *asse neutro*, che risulta perpendicolare all'asse di sollecitazione $y$. Nei punti appartenenti all'asse neutro $z$, la componente di tensione normale generata dalla flessione è pertanto nulla.

#canvas(length: 1.8cm, {
  import draw: *
  // --- Pannello Sinistro: Trave inflessa divisa in conci 1 e 2 ---
  // Centro di curvatura in (0, 5.2)
  // Bordo superiore (r = 3.8), linea d'asse (r = 4.5), bordo inferiore (r = 5.2)
  // Metà sinistra (concio 1, tratto continuo: 242deg .. 270deg)
  arc((0, 5.2), start: 242deg, stop: 270deg, radius: 3.8, anchor: "origin", stroke: 1.2pt)
  arc((0, 5.2), start: 242deg, stop: 270deg, radius: 5.2, anchor: "origin", stroke: 1.2pt)
  line((-1.78, 1.84), (-2.44, 0.61), stroke: 1.2pt)

  // Metà destra (concio 2, tratto tratteggiato: 270deg .. 298deg)
  arc((0, 5.2), start: 270deg, stop: 298deg, radius: 3.8, anchor: "origin", stroke: (dash: "dashed", thickness: 0.9pt))
  arc((0, 5.2), start: 270deg, stop: 298deg, radius: 5.2, anchor: "origin", stroke: (dash: "dashed", thickness: 0.9pt))
  line((1.78, 1.84), (2.44, 0.61), stroke: (dash: "dashed", thickness: 0.9pt))

  // Linea elastica (tratto-punto)
  arc((0, 5.2), start: 238deg, stop: 302deg, radius: 4.5, anchor: "origin", stroke: (dash: "dash-dotted", thickness: 0.7pt))

  // Assi x e y
  line((-2.7, 0.7), (2.8, 0.7), mark: (end: ">"), stroke: (dash: "dash-dotted", thickness: 0.7pt))
  content((2.75, 0.45), text(size: 7pt)[$x$], anchor: "north")
  line((0.1, -0.3), (-0.15, 2.2), mark: (end: ">"), stroke: 0.7pt)
  content((-0.3, 2.1), text(size: 7pt)[$y$], anchor: "east")

  // Forze interne elementari sulla sezione di separazione
  line((-0.07, 1.25), (-0.55, 1.2), mark: (end: ">"), stroke: 0.7pt)
  content((-0.55, 1.05), text(size: 7pt)[$Delta F_3$], anchor: "north")
  line((0.03, 0.4), (0.35, 0.43), mark: (end: ">"), stroke: 0.7pt)
  content((0.4, 0.55), text(size: 7pt)[$Delta F_2$], anchor: "west")
  line((0.06, 0.15), (0.55, 0.2), mark: (end: ">"), stroke: 0.7pt)
  content((0.6, 0.2), text(size: 7pt)[$Delta F_1$], anchor: "west")

  // Momenti M_f agli estremi
  arc((-2.2, 1.3), start: 120deg, stop: 215deg, radius: 0.55, anchor: "origin", mark: (start: ">"), stroke: 1pt)
  content((-2.6, 1.85), text(size: 7pt)[$M_f$], anchor: "east")
  arc((2.2, 1.3), start: -35deg, stop: 60deg, radius: 0.55, anchor: "origin", mark: (end: ">"), stroke: 1pt)
  content((2.6, 1.85), text(size: 7pt)[$M_f$], anchor: "west")

  // Etichette conci 1 e 2
  circle((-1.5, -0.35), radius: 0.22, stroke: 0.7pt)
  content((-1.5, -0.35), text(size: 7pt)[$1$])
  line((-1.32, -0.2), (-0.9, 0.35), stroke: 0.5pt)

  circle((1.5, -0.35), radius: 0.22, stroke: 0.7pt)
  content((1.5, -0.35), text(size: 7pt)[$2$])
  line((1.32, -0.2), (0.9, 0.35), stroke: 0.5pt)

  // --- Pannello Destro: Sezione circolare con aree elementari ---
  circle((4.7, 0.7), radius: 0.85, fill: luma(230), stroke: 1pt)
  line((5.8, 0.7), (3.4, 0.7), mark: (end: ">"), stroke: (dash: "dash-dotted", thickness: 0.7pt))
  content((3.45, 0.45), text(size: 7pt)[$z$], anchor: "north")
  line((4.7, -0.35), (4.7, 1.85), mark: (end: ">"), stroke: 0.7pt)
  content((4.55, 1.75), text(size: 7pt)[$y$], anchor: "east")

  // Aree elementari Delta A_1, Delta A_2, Delta A_3
  rect((4.85, 1.15), (5.0, 1.3), stroke: 0.7pt)
  line((4.92, 1.22), (5.45, 1.55), stroke: 0.5pt)
  content((5.5, 1.6), text(size: 7pt)[$Delta A_3$], anchor: "west")

  rect((4.3, 0.15), (4.45, 0.3), stroke: 0.7pt)
  line((4.37, 0.22), (4.0, -0.15), stroke: 0.5pt)
  content((3.95, -0.2), text(size: 7pt)[$Delta A_2$], anchor: "east")

  rect((5.0, 0.3), (5.15, 0.45), stroke: 0.7pt)
  line((5.07, 0.37), (5.5, -0.05), stroke: 0.5pt)
  content((5.55, -0.1), text(size: 7pt)[$Delta A_1$], anchor: "west")
})

== Momento flettente nel piano $x y$: trattazione di de Saint Venant

Nello studio della flessione si fa sempre riferimento agli *assi principali d'inerzia* $z$ e $y$ della sezione. Sviluppiamo la trattazione secondo il metodo semi-inverso per un momento flettente agente nel piano $x y$:

+ *Ipotesi iniziale (campo di spostamenti)*: poiché la rotazione della sezione avviene nel piano $x y$ attorno all'asse neutro $z$, lo spostamento assiale $u$ di un punto generico della sezione trasversale dipende linearmente dalla sua distanza $y$ dall'origine degli assi centrali principali d'inerzia e dall'angolo di rotazione $alpha_z$:
  $ u = -alpha_z y $

#canvas(length: 1.5cm, {
  import draw: *
  // Assi
  line((0, -1.1), (0, 2.0), mark: (end: ">"), stroke: 0.7pt)
  content((-0.2, 1.8), text(size: 7pt)[$y$], anchor: "east")
  line((-0.8, 0), (5.8, 0), mark: (end: ">"), stroke: 0.7pt)
  content((5.4, 0.2), text(size: 7pt)[$x$], anchor: "south")

  // Contorno indeformato a destra (tratteggiato)
  line((3.7, 0.9), (4.4, 0.9), (4.4, -0.9), stroke: (dash: "dashed", thickness: 1.1pt))

  // Contorno deformato (trapezio)
  line((0, -0.9), (4.75, -0.9), (3.65, 0.9), (0, 0.9), close: true, stroke: 1.3pt)

  // Quota u e angolo alpha_z
  line((4.4, -0.9), (4.4, -1.8), stroke: 0.6pt)
  line((4.75, -0.9), (4.75, -1.35), stroke: 0.6pt)
  line((4.4, -1.15), (4.75, -1.15), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((4.35, -1.15), text(size: 7pt)[$u$], anchor: "east")

  line((4.75, -0.9), (5.25, -1.72), stroke: 0.6pt)
  arc((4.4, 0.0), start: 270deg, stop: 301deg, radius: 1.65, anchor: "origin", mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((4.85, -1.85), text(size: 7pt)[$alpha_z$], anchor: "north")
})

+ *Equazioni di congruenza*: derivando lo spostamento assiale rispetto a $x$, si ottiene il campo di deformazione longitudinale:
  $ epsilon_(x x) = (d u) / (d x) = -(d alpha_z) / (d x) y = -k_z y $
  dove $k_z = (d alpha_z) / (d x)$ è la derivata della rotazione $alpha_z$ rispetto all'ascissa $x$, ossia la *curvatura* della trave conseguente all'applicazione del momento flettente.

+ *Equazioni costitutive*: ipotizzando il materiale elastico lineare, omogeneo e isotropo, la legge di Hooke fornisce:
  $ sigma_(x x) = E epsilon_(x x) = -E k_z y $
  La tensione assiale $sigma_(x x)$ dovuta alla flessione ha quindi una *distribuzione lineare* lungo l'altezza della sezione trasversale della trave.

=== Interpretazione geometrico-fisica della congruenza

L'equazione di congruenza $epsilon_(x x) = -k_z y$ può essere ricavata anche in modo più diretto ("fisico") considerando un concio elementare di trave di lunghezza iniziale $l$ e osservando una fibra posta a distanza $y$ dall'asse neutro.

#canvas(length: 1.5cm, {
  import draw: *
  // Centro di curvatura O in (0, 4.4)
  content((0.0, 4.65), text(size: 7pt)[$O$], anchor: "south")

  // Raggi tratteggiati dal centro O ai bordi del concio (angoli 248deg e 292deg)
  line((0, 4.4), (-1.8, 0.04), stroke: (dash: "dashed", thickness: 0.6pt))
  line((0, 4.4), (1.8, 0.04), stroke: (dash: "dashed", thickness: 0.6pt))

  // Concio inflesso: bordo superiore (r = 3.2), bordo inferiore (r = 4.4)
  arc((0, 4.4), start: 248deg, stop: 292deg, radius: 3.2, anchor: "origin", stroke: 1.2pt)
  arc((0, 4.4), start: 248deg, stop: 292deg, radius: 4.4, anchor: "origin", stroke: 1.2pt)
  line((-1.2, 1.43), (-1.65, 0.32), stroke: 1.2pt)
  line((1.2, 1.43), (1.65, 0.32), stroke: 1.2pt)

  // Asse neutro CD (r = 3.7) e fibra generica AB (r = 4.05)
  arc((0, 4.4), start: 248deg, stop: 292deg, radius: 3.7, anchor: "origin", stroke: (dash: "dashed", thickness: 0.6pt))
  arc((0, 4.4), start: 248deg, stop: 292deg, radius: 4.05, anchor: "origin", stroke: (dash: "dashed", thickness: 0.6pt))

  // Etichette estremi C, A, D, B e lunghezze l, l + Delta l
  content((-1.45, 1.05), text(size: 7pt)[$C$], anchor: "east")
  content((-1.6, 0.65), text(size: 7pt)[$A$], anchor: "east")
  content((1.4, 1.15), text(size: 7pt)[$D$], anchor: "west")
  content((1.6, 0.55), text(size: 7pt)[$B$], anchor: "west")
  content((-0.15, 0.85), text(size: 7pt)[$l$], anchor: "south")
  content((0.0, 0.3), text(size: 7pt)[$l + Delta l$], anchor: "north")

  // Sistema di riferimento locale (x, y) sull'asse neutro
  line((0.1, 0.36), (0.95, 0.58), mark: (end: ">"), stroke: (paint: rgb(40, 110, 180), thickness: 0.8pt))
  content((0.85, 0.72), text(size: 7pt, fill: rgb(40, 110, 180))[$x$], anchor: "south")
  line((0.1, 0.36), (-0.18, 1.4), mark: (end: ">"), stroke: (paint: rgb(40, 110, 180), thickness: 0.8pt))
  content((-0.3, 1.35), text(size: 7pt, fill: rgb(40, 110, 180))[$y$], anchor: "east")

  // Quota raggio di curvatura R e ordinata y a destra
  line((0.35, 4.54), (1.73, 1.1), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((1.25, 2.85), text(size: 7pt)[$R$], anchor: "west")
  line((1.39, 0.97), (1.9, 1.18), stroke: 0.5pt)
  line((1.52, 0.64), (2.03, 0.85), stroke: 0.5pt)
  line((1.73, 1.1), (1.98, 0.48), stroke: 0.5pt)
  content((2.05, 0.95), text(size: 7pt)[$y$], anchor: "west")
})

Per definizione, la deformazione longitudinale della fibra $A B$ si scrive come:
$ epsilon_(x x) = (Delta l) / l $
Il rapporto $(Delta l) / l$ si ricava per similitudine tra i settori circolari ("triangoli" curvilinei simili) $O A B$ e $O C D$. Tenendo conto che la fibra $A B$ mostrata nella parte tesa inferiore si trova a coordinata $y$ negativa rispetto al verso dell'asse $y$ diretto verso il centro di curvatura $O$, vale la proporzione:
$ (l + Delta l) / l = (R - y) / R = 1 - y / R arrow.double (Delta l) / l = - y / R $
La deformazione assiale si riscrive quindi come:
$ epsilon_(x x) = - 1 / R y $
Riconoscendo che il reciproco del raggio di curvatura $1 / R$ coincide con la curvatura $k_z$ della trave, si ritrova esattamente l'equazione di congruenza:
$ epsilon_(x x) = -k_z y $

=== Equazione di equivalenza e Formula di Navier

Poiché la trave è soggetta soltanto a flessione retta nel piano $x y$, le caratteristiche di sollecitazione sono:
$ M_z != 0, quad N_x = M_y = M_x = T_y = T_z = 0 $

+ *Equazione di equivalenza*: l'unica componente di tensione che può generare il momento flettente $M_z$ è la tensione normale $sigma_(x x)$. L'equilibrio alla rotazione attorno all'asse $z$ impone:
  $ integral_A -sigma_(x x) y d A = M_z $
  Sostituendo l'espressione costitutiva $sigma_(x x) = -E k_z y$ all'interno dell'integrale, si ottiene:
  $ M_z = integral_A E k_z y^2 d A = E k_z integral_A y^2 d A = E k_z I_z $
  dove $I_z = integral_A y^2 d A$ è il *momento d'inerzia* della sezione trasversale calcolato rispetto all'asse principale $z$.

+ *Distribuzione lineare delle tensioni (Formula di Navier)*: ricavando la curvatura $k_z = M_z / (E I_z)$ e sostituendola nella legge di Hooke $sigma_(x x) = -E k_z y$, si giunge alla relazione fondamentale della flessione retta:
  $ sigma_(x x) = -E M_z / (E I_z) y = - M_z / I_z y $

#canvas(length: 1.2cm, {
  import draw: *
  // Assi
  line((0, -1.2), (0, 1.8), mark: (end: ">"), stroke: 0.7pt)
  content((-0.2, 1.65), text(size: 7pt)[$y$], anchor: "east")
  line((0, 0), (6.4, 0), mark: (end: ">"), stroke: 0.7pt)
  content((6.1, -0.35), text(size: 7pt)[$x$], anchor: "north")

  // Trave
  rect((0, -0.95), (4.3, 0.95), stroke: 1.5pt)

  // Diagramma a farfalla (in rosso)
  line((3.2, 0.95), (5.4, -0.95), stroke: (paint: red, thickness: 0.9pt))
  // Fibre superiori compresse (frecce verso sinistra)
  line((4.3, 0.95), (3.2, 0.95), mark: (end: ">"), stroke: (paint: red, thickness: 0.8pt))
  line((4.3, 0.63), (3.57, 0.63), mark: (end: ">"), stroke: (paint: red, thickness: 0.8pt))
  line((4.3, 0.32), (3.93, 0.32), mark: (end: ">"), stroke: (paint: red, thickness: 0.8pt))
  // Fibre inferiori tese (frecce verso destra)
  line((4.3, -0.32), (4.67, -0.32), mark: (end: ">"), stroke: (paint: red, thickness: 0.8pt))
  line((4.3, -0.63), (5.03, -0.63), mark: (end: ">"), stroke: (paint: red, thickness: 0.8pt))
  line((4.3, -0.95), (5.4, -0.95), mark: (end: ">"), stroke: (paint: red, thickness: 0.8pt))

  // Formula
  content((5.2, 0.65), text(size: 11pt, fill: red)[$sigma_(x x) = - M_z / I_z dot y$], anchor: "west")
})

In conclusione, la sezione soggetta al solo momento flettente $M_z$ positivo si inflette comprimendo le fibre superiori ($y > 0$, dove $sigma_(x x) < 0$) e tendendo le fibre inferiori ($y < 0$, dove $sigma_(x x) > 0$) rispetto all'asse neutro $z$, con un caratteristico diagramma tensionale lineare a farfalla.

#canvas(length: 1.8cm, {
  import draw: *
  // --- Pannello Sinistro: Vista laterale e diagramma a farfalla ---
  line((0, -1.1), (1.8, -1.1), (1.8, 1.1), (0, 1.1), stroke: 1pt)
  line((0, 1.1), (-0.05, 0.7), (0.04, 0.3), (-0.06, -0.1), (0.03, -0.5), (-0.04, -0.8), (0, -1.1), stroke: 1pt)

  // Terna d'assi
  line((0.4, -0.1), (1.1, -0.1), mark: (end: ">"), stroke: 0.8pt)
  content((1.1, -0.25), text(size: 7pt)[$x$], anchor: "north")
  line((0.4, -0.1), (0.4, 0.65), mark: (end: ">"), stroke: 0.8pt)
  content((0.3, 0.55), text(size: 7pt)[$y$], anchor: "east")
  circle((0.4, -0.1), radius: 0.14, fill: white, stroke: 0.8pt)
  circle((0.4, -0.1), radius: 0.04, fill: black)
  content((0.2, -0.25), text(size: 7pt)[$z$], anchor: "north")

  // Diagramma a farfalla verticale
  line((2.55, -1.1), (2.55, 1.1), stroke: 0.9pt)
  line((2.05, 1.1), (2.85, -1.1), stroke: 0.9pt)
  line((2.05, 1.1), (2.55, 1.1), stroke: 0.9pt)
  line((2.55, -1.1), (2.85, -1.1), stroke: 0.9pt)
  // Tratteggio orizzontale interno
  line((2.14, 0.85), (2.55, 0.85), stroke: 0.5pt)
  line((2.23, 0.60), (2.55, 0.60), stroke: 0.5pt)
  line((2.32, 0.35), (2.55, 0.35), stroke: 0.5pt)
  line((2.41, 0.10), (2.55, 0.10), stroke: 0.5pt)
  line((2.55, -0.35), (2.63, -0.35), stroke: 0.5pt)
  line((2.55, -0.60), (2.71, -0.60), stroke: 0.5pt)
  line((2.55, -0.85), (2.78, -0.85), stroke: 0.5pt)

  // Arco M_z e formula
  arc((3.2, 0.05), start: -65deg, stop: 75deg, radius: 0.42, anchor: "origin", mark: (end: ">"), stroke: 0.8pt)
  content((3.25, 0.05), text(size: 7pt)[$M_z$], anchor: "east")
  content((3.1, 1.05), text(size: 7pt)[$sigma_(x x) = - M_z / I_z dot y$], anchor: "west")

  // --- Pannello Destro: Sezione ovoidale e proiezione a farfalla ---
  line((5.6, 0.0), (8.0, 0.0), stroke: 0.7pt)
  content((5.75, 0.15), text(size: 7pt)[$z$], anchor: "south")
  line((6.8, -1.4), (6.8, 1.45), stroke: 0.7pt)
  content((6.7, 1.4), text(size: 7pt)[$y$], anchor: "east")

  arc((6.8, 0.0), start: 0deg, stop: 180deg, radius: (0.95, 1.25), anchor: "origin", stroke: 1pt)
  arc((6.8, 0.0), start: 180deg, stop: 360deg, radius: (0.95, 1.05), anchor: "origin", stroke: 1pt)

  // Linee di proiezione a 45 gradi (estremi e asse neutro)
  line((6.13, 0.88), (4.8, -0.45), stroke: 0.6pt)
  line((7.47, -0.74), (6.3, -1.91), stroke: 0.6pt)

  // Diagramma a farfalla inclinato a 45 gradi
  line((4.8, -0.45), (6.3, -1.95), stroke: 0.9pt)
  line((4.5, -0.75), (4.8, -0.45), stroke: 0.9pt)
  line((6.3, -1.95), (6.0, -2.25), stroke: 0.9pt)
  line((4.5, -0.75), (6.0, -2.25), stroke: 0.9pt)
  // Tratteggio interno nei due triangoli
  line((4.65, -0.6), (5.05, -0.7), stroke: 0.5pt)
  line((4.8, -0.75), (5.2, -0.85), stroke: 0.5pt)
  line((5.0, -0.95), (5.35, -1.0), stroke: 0.5pt)
  line((5.75, -1.7), (6.1, -1.75), stroke: 0.5pt)
  line((5.88, -1.88), (6.2, -1.85), stroke: 0.5pt)

  content((6.25, -2.2), text(size: 7pt)[$sigma_(x x)$], anchor: "west")
})


// === Blocco_02_Slide_20-37 ===

#nota[
  *Osservazione sulla baricentricità dell'asse neutro (momento flettente nel piano $x y$)*:
  Richiamiamo l'equazione di equivalenza alla traslazione lungo l'asse $x$, tenendo conto che lo sforzo normale $N_x$ è nullo (poiché agisce soltanto il momento flettente $M_z$):
  $ integral_A sigma_(x x) d A = N_x = 0 $
  Sostituendo l'espressione della tensione $sigma_(x x) = -E k_z y$, la condizione di equilibrio si riscrive come:
  $ -E k_z integral_A y d A = -E k_z S_z = 0 $
  Poiché la tensione $sigma_(x x)$ è diversa da zero ($E k_z != 0$), la relazione precedente è soddisfatta soltanto se il momento statico $S_z$ è nullo, ossia se l'asse $z$ passa per il baricentro della sezione. L'*asse neutro* della sezione (asse $z$) in flessione pura è quindi necessariamente anche un *asse baricentrico*.
]

== Momento flettente nel piano $x z$

Nel caso in cui sulla trave agisca il solo momento flettente $M_y$ (contenuto nel piano $x z$), sviluppando il metodo semi-inverso in modo del tutto analogo a quanto visto per il piano $x y$, si giunge all'espressione della distribuzione lineare della corrispondente tensione normale di flessione:
$ sigma_(x x) = M_y / I_y dot z $
dove $I_y = integral_A z^2 d A$ rappresenta il momento d'inerzia della sezione rispetto all'asse principale baricentrico $y$.

#canvas(length: 1.8cm, {
  import draw: *
  // --- Pannello Sinistro: Vista nel piano xz e diagramma a farfalla ---
  line((0, -1.1), (1.8, -1.1), (1.8, 1.1), (0, 1.1), stroke: 1pt)
  line((0, 1.1), (-0.05, 0.7), (0.04, 0.3), (-0.06, -0.1), (0.03, -0.5), (-0.04, -0.8), (0, -1.1), stroke: 1pt)

  // Terna d'assi (x a destra, z in alto, y entrante con croce)
  line((0.4, -0.35), (1.35, -0.35), mark: (end: ">"), stroke: 0.8pt)
  content((1.2, -0.55), text(size: 7pt)[$x$], anchor: "north")
  line((0.4, -0.35), (0.4, 0.45), mark: (end: ">"), stroke: 0.8pt)
  content((0.28, 0.35), text(size: 7pt)[$z$], anchor: "east")
  circle((0.4, -0.35), radius: 0.14, fill: white, stroke: 0.8pt)
  line((0.3, -0.45), (0.5, -0.25), stroke: 0.9pt)
  line((0.3, -0.25), (0.5, -0.45), stroke: 0.9pt)
  content((0.2, -0.55), text(size: 7pt)[$y$], anchor: "north")

  // Diagramma a farfalla verticale (positivo per z > 0, negativo per z < 0)
  line((2.5, -1.1), (2.5, 1.1), stroke: 0.9pt)
  line((3.05, 1.1), (2.2, -1.1), stroke: 0.9pt)
  line((2.5, 1.1), (3.05, 1.1), stroke: 0.9pt)
  line((2.2, -1.1), (2.5, -1.1), stroke: 0.9pt)
  // Tratteggio interno
  line((2.5, 0.85), (2.95, 0.85), stroke: 0.5pt)
  line((2.5, 0.60), (2.86, 0.60), stroke: 0.5pt)
  line((2.5, 0.35), (2.76, 0.35), stroke: 0.5pt)
  line((2.5, 0.10), (2.66, 0.10), stroke: 0.5pt)
  line((2.40, -0.40), (2.5, -0.40), stroke: 0.5pt)
  line((2.31, -0.65), (2.5, -0.65), stroke: 0.5pt)
  line((2.23, -0.90), (2.5, -0.90), stroke: 0.5pt)

  // Arco M_y (orario, freccia in basso) e formula
  arc((3.0, 0.0), start: -65deg, stop: 75deg, radius: 0.45, anchor: "origin", mark: (start: ">"), stroke: 0.8pt)
  content((3.25, 0.0), text(size: 7pt)[$M_y$], anchor: "east")
  content((3.2, 1.0), text(size: 12pt)[$sigma_(x x) = M_y / I_y dot z$], anchor: "west")

  // --- Pannello Destro: Sezione ovoidale e proiezione ---
  line((5.6, 0.0), (8.0, 0.0), stroke: 0.7pt)
  content((5.7, -0.15), text(size: 7pt)[$z$], anchor: "north")
  line((6.8, -1.4), (6.8, 1.45), stroke: 0.7pt)
  content((6.7, 1.4), text(size: 7pt)[$y$], anchor: "east")

  arc((6.8, 0.0), start: 0deg, stop: 180deg, radius: (0.95, 1.25), anchor: "origin", stroke: 1pt)
  arc((6.8, 0.0), start: 180deg, stop: 360deg, radius: (0.95, 1.05), anchor: "origin", stroke: 1pt)

  // Linee di proiezione a 45 gradi
  line((6.13, 0.88), (4.8, -0.45), stroke: 0.6pt)
  line((7.47, -0.74), (6.3, -1.91), stroke: 0.6pt)

  // Diagramma a farfalla inclinato a 45 gradi
  line((5.0, -0.4), (6.5, -1.9), stroke: 0.9pt)
  line((4.6, -0.8), (5.0, -0.4), stroke: 0.9pt)
  line((6.5, -1.9), (6.2, -2.2), stroke: 0.9pt)
  line((4.6, -0.8), (6.2, -2.2), stroke: 0.9pt)
  // Tratteggio interno
  line((4.75, -0.65), (5.2, -0.6), stroke: 0.5pt)
  line((4.9, -0.85), (5.45, -0.85), stroke: 0.5pt)
  line((5.15, -1.05), (5.65, -1.05), stroke: 0.5pt)
  line((5.9, -1.65), (6.25, -1.65), stroke: 0.5pt)
  line((6.05, -1.85), (6.4, -1.8), stroke: 0.5pt)

  content((6.45, -2.1), text(size: 7pt)[$sigma_(x x)$], anchor: "west")
})

== Momento flettente su sezione generica e moduli di resistenza

Secondo la convenzione di segno adottata per il concio elementare di trave, il momento flettente $M_z$ è considerato positivo quando tende le fibre inferiori ($y < 0$) e comprime quelle superiori ($y > 0$):
$ sigma_(x x) = - M_z / I_z y $

#canvas(length: 1.4cm, {
  import draw: *
  // Concio di trave
  rect((1.0, -0.55), (4.2, 0.55), stroke: 1pt)
  line((0.4, 0), (5.4, 0), mark: (end: ">"), stroke: (dash: "dash-dotted", thickness: 0.7pt))
  content((5.35, -0.2), text(size: 7pt)[$x$], anchor: "north")
  line((1.0, 0), (1.0, 1.5), mark: (end: ">"), stroke: 0.7pt)
  content((0.85, 1.45), text(size: 7pt)[$y$], anchor: "east")

  // Segni facce concio
  content((1.2, 0.35), text(size: 7pt)[$-$])
  content((3.95, 0.35), text(size: 7pt)[$+$])

  // Sforzi normali N
  line((1.0, 0), (0.0, 0), mark: (end: ">"), stroke: 1.2pt)
  content((0.0, -0.2), text(size: 7pt)[$N$], anchor: "north")
  line((4.2, 0), (5.1, 0), mark: (end: ">"), stroke: 1.2pt)
  content((5.0, -0.2), text(size: 7pt)[$N$], anchor: "north")

  // Tagli T
  line((1.0, 0), (1.0, 1.15), mark: (end: ">"), stroke: 1.2pt)
  content((1.15, 1.1), text(size: 7pt)[$T$], anchor: "west")
  line((4.2, 0), (4.2, -1.15), mark: (end: ">"), stroke: 1.2pt)
  content((4.35, -0.95), text(size: 7pt)[$T$], anchor: "west")

  // Momenti flettenti M_f
  arc((0.55, 0.0), start: 60deg, stop: 300deg, radius: 0.32, anchor: "origin", mark: (start: ">"), stroke: 1.2pt)
  content((0.35, 0.45), text(size: 7pt)[$M_f$], anchor: "south")
  arc((4.65, 0.0), start: -120deg, stop: 120deg, radius: 0.32, anchor: "origin", mark: (end: ">"), stroke: 1.2pt)
  content((4.85, 0.45), text(size: 7pt)[$M_f$], anchor: "south")
})

Nel generico punto della sezione trasversale, la tensione normale $sigma_(x x)$ di flessione è direttamente proporzionale alla distanza $y$ dall'asse neutro $z$. Pertanto, i punti più sollecitati della sezione sono quelli situati alla massima distanza dall'asse neutro:
- Indichiamo con $|y'_"max"|$ la distanza massima dall'asse neutro nella zona compressa (punto estremo superiore $A$).
- Indichiamo con $|y''_"max"|$ la distanza massima dall'asse neutro nella zona tesa (punto estremo inferiore $B$).

#canvas(length: 1.6cm, {
  import draw: *
  // --- Sezione generica a sinistra (centro G in 2.0, 0.0) ---
  // Contorno ovoidale con riempimento tratteggiato
  arc((2.0, 0.0), start: 0deg, stop: 180deg, radius: (1.05, 1.35), anchor: "origin", fill: luma(240), stroke: 1.1pt)
  arc((2.0, 0.0), start: 180deg, stop: 360deg, radius: (1.05, 0.95), anchor: "origin", fill: luma(240), stroke: 1.1pt)

  // Tratteggio a 45 gradi sulla sezione
  line((1.15, -0.45), (2.45, 0.85), stroke: 0.4pt)
  line((1.0, -0.1), (2.3, 1.2), stroke: 0.4pt)
  line((1.1, 0.35), (2.05, 1.3), stroke: 0.4pt)
  line((1.35, 0.85), (1.75, 1.25), stroke: 0.4pt)
  line((1.35, -0.75), (2.75, 0.65), stroke: 0.4pt)
  line((1.65, -0.92), (2.95, 0.38), stroke: 0.4pt)
  line((2.05, -0.92), (3.02, 0.05), stroke: 0.4pt)
  line((2.45, -0.8), (2.98, -0.27), stroke: 0.4pt)

  // Assi baricentrici z e y
  line((3.3, 0.0), (0.0, 0.0), mark: (end: ">"), stroke: 0.9pt)
  content((0.05, 0.2), text(size: 7pt)[$z$], anchor: "south")
  line((2.0, -1.35), (2.0, 1.95), mark: (end: ">"), stroke: (dash: "dashed", thickness: 0.8pt))
  content((1.88, 1.85), text(size: 7pt)[$y$], anchor: "east")

  // Punti G, A, B
  content((1.95, 0.22), text(size: 7pt)[$G$], anchor: "east")
  content((1.92, 1.52), text(size: 7pt)[$A$], anchor: "east")
  content((1.92, -1.15), text(size: 7pt)[$B$], anchor: "east")

  // Quote y'_max e y''_max
  line((2.0, 1.35), (0.35, 1.35), stroke: 0.6pt)
  line((2.0, -0.95), (0.35, -0.95), stroke: 0.6pt)
  line((0.5, 0.0), (0.5, 1.35), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((0.45, 0.68), text(size: 7pt)[$y'_"max"$], anchor: "east")
  line((0.5, -0.95), (0.5, 0.0), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((0.45, -0.48), text(size: 7pt)[$y''_"max"$], anchor: "east")

  // --- Diagramma delle tensioni a destra ---
  line((4.5, -0.95), (4.5, 1.35), stroke: 0.8pt)
  line((3.8, 0.0), (5.2, 0.0), stroke: 0.7pt)
  line((3.55, 1.35), (5.2, -0.95), stroke: 0.8pt)

  // Frecce superiori (compressione)
  line((4.5, 1.35), (3.55, 1.35), mark: (end: ">"), stroke: 0.6pt)
  line((4.5, 1.12), (3.71, 1.12), mark: (end: ">"), stroke: 0.6pt)
  line((4.5, 0.90), (3.87, 0.90), mark: (end: ">"), stroke: 0.6pt)
  line((4.5, 0.67), (4.03, 0.67), mark: (end: ">"), stroke: 0.6pt)
  line((4.5, 0.45), (4.18, 0.45), mark: (end: ">"), stroke: 0.6pt)
  line((4.5, 0.22), (4.34, 0.22), mark: (end: ">"), stroke: 0.6pt)

  // Frecce inferiori (trazione)
  line((4.5, -0.24), (4.68, -0.24), mark: (end: ">"), stroke: 0.6pt)
  line((4.5, -0.47), (4.85, -0.47), mark: (end: ">"), stroke: 0.6pt)
  line((4.5, -0.71), (5.02, -0.71), mark: (end: ">"), stroke: 0.6pt)
  line((4.5, -0.95), (5.20, -0.95), mark: (end: ">"), stroke: 0.6pt)

  content((3.95, 1.45), text(size: 7pt)[$sigma'_"max"$], anchor: "south")
  content((5.15, -1.05), text(size: 7pt)[$sigma''_"max"$], anchor: "north")
})

Le tensioni normali massime, espresse in *valore assoluto*, valgono rispettivamente:
$ |sigma'_"max"| = |M_z| / I_z |y'_"max"|, quad |sigma''_"max"| = |M_z| / I_z |y''_"max"| $

Definiamo i *moduli di resistenza a flessione* della sezione trasversale rispetto all'asse $z$ come il rapporto tra il momento d'inerzia assiale e le distanze estreme dall'asse neutro:
$ W'_z = I_z / |y'_"max"|, quad W''_z = I_z / |y''_"max"| $
Mediante tali grandezze geometriche, le tensioni massime in *valore assoluto* si riscrivono in forma compatta come:
$ |sigma'_"max"| = |M_z| / W'_z, quad |sigma''_"max"| = |M_z| / W''_z $

#nota[
  Nel caso particolare di una *sezione simmetrica* rispetto all'asse neutro $z$, le distanze estreme coincidono ($|y'_"max"| = |y''_"max"| = y_"max"$), da cui segue l'uguaglianza dei moduli di resistenza ($W'_z = W''_z = W_z$). Di conseguenza, le tensioni massime di trazione e di compressione risultano uguali in modulo e di segno opposto.
]

=== Esempi notevoli di sezioni simmetriche

Per una sezione simmetrica, il valore assoluto della tensione massima vale in generale:
$ |sigma_"max"| = |M_z| / I_z y_"max" = |M_z| / W_z $

+ *Sezione rettangolare* (di base $b$ e altezza $h$, con assi $z$ e $y$ baricentrici):
  $ I_z = (b h^3) / 12, quad y_"max" = h / 2, quad W_z = I_z / y_"max" = (b h^2) / 6 $
  Sostituendo nella formula di Navier si ricava la tensione massima:
  $ |sigma_"max"| = 6 |M_z| / (b h^2) $

#canvas(length: 1.8cm, {
  import draw: *
  // Sezione rettangolare a sinistra (centro in 1.8, 0.0)
  rect((1.0, -1.1), (2.6, 1.1), stroke: 1.1pt)
  line((3.0, 0.0), (0.5, 0.0), mark: (end: ">"), stroke: (dash: "dash-dotted", thickness: 0.7pt))
  content((0.65, -0.25), text(size: 7pt)[$z$], anchor: "north")
  line((1.8, -1.4), (1.8, 1.55), mark: (end: ">"), stroke: (dash: "dash-dotted", thickness: 0.7pt))
  content((1.68, 1.45), text(size: 7pt)[$y$], anchor: "east")

  // Quota altezza h
  line((1.0, 1.1), (0.2, 1.1), stroke: 0.5pt)
  line((1.0, -1.1), (0.2, -1.1), stroke: 0.5pt)
  line((0.35, -1.1), (0.35, 1.1), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((0.25, 0.0), text(size: 7pt)[$h$], anchor: "east")

  // Quota base b
  line((1.0, -1.1), (1.0, -1.65), stroke: 0.5pt)
  line((2.6, -1.1), (2.6, -1.65), stroke: 0.5pt)
  line((1.0, -1.5), (2.6, -1.5), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((1.8, -1.45), text(size: 7pt)[$b$], anchor: "south")

  // Diagramma a farfalla a destra
  line((3.3, 1.1), (5.9, 1.1), stroke: (dash: "dashed", thickness: 0.5pt))
  line((3.6, 0.0), (5.9, 0.0), stroke: (dash: "dash-dotted", thickness: 0.5pt))
  line((3.3, -1.1), (5.9, -1.1), stroke: (dash: "dashed", thickness: 0.5pt))

  line((4.7, -1.1), (4.7, 1.1), stroke: 0.9pt)
  line((3.8, 1.1), (5.6, -1.1), stroke: 0.9pt)
  line((4.7, 1.1), (3.8, 1.1), mark: (end: ">"), stroke: 0.8pt)
  line((4.7, 0.82), (4.03, 0.82), mark: (end: ">"), stroke: 0.7pt)
  line((4.7, 0.55), (4.25, 0.55), mark: (end: ">"), stroke: 0.7pt)
  line((4.7, 0.28), (4.47, 0.28), mark: (end: ">"), stroke: 0.7pt)
  line((4.7, -0.28), (4.93, -0.28), mark: (end: ">"), stroke: 0.7pt)
  line((4.7, -0.55), (5.15, -0.55), mark: (end: ">"), stroke: 0.7pt)
  line((4.7, -0.82), (5.37, -0.82), mark: (end: ">"), stroke: 0.7pt)
  line((4.7, -1.1), (5.6, -1.1), mark: (end: ">"), stroke: 0.8pt)
})

+ *Sezione circolare piena* (di diametro $D$, con assi $z$ e $y$ baricentrici):
  $ I_z = (pi D^4) / 64, quad y_"max" = D / 2, quad W_z = I_z / y_"max" = (pi D^3) / 32 $
  Sostituendo si ottiene la tensione massima:
  $ |sigma_"max"| = 32 / (pi D^3) |M_z| $

+ *Sezione circolare cava* (di diametro esterno $D$ e diametro interno $d$, con assi $z$ e $y$ baricentrici):
  $ I_z = pi / 64 (D^4 - d^4), quad y_"max" = D / 2, quad W_z = pi / 32 (D^4 - d^4) / D $
  Sostituendo si ricava la tensione massima:
  $ |sigma_"max"| = (32 D) / (pi (D^4 - d^4)) |M_z| $

#canvas(length: 1.8cm, {
  import draw: *
  // --- Pannello Sinistro: Sezione circolare piena ---
  circle((1.3, 0.0), radius: 0.95, stroke: 1.1pt)
  line((2.5, 0.0), (0.0, 0.0), mark: (end: ">"), stroke: (dash: "dash-dotted", thickness: 0.7pt))
  content((0.15, -0.2), text(size: 7pt)[$z$], anchor: "north")
  line((1.3, -1.15), (1.3, 1.4), mark: (end: ">"), stroke: (dash: "dash-dotted", thickness: 0.7pt))
  content((1.18, 1.3), text(size: 7pt)[$y$], anchor: "east")

  // Quota D
  line((0.35, 0.0), (0.35, -1.5), stroke: 0.5pt)
  line((2.25, 0.0), (2.25, -1.5), stroke: 0.5pt)
  line((0.35, -1.35), (2.25, -1.35), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((1.3, -1.3), text(size: 7pt)[$D$], anchor: "south")

  // Diagramma a farfalla (sezione piena)
  line((2.5, 0.95), (4.0, 0.95), stroke: (dash: "dashed", thickness: 0.5pt))
  line((2.6, 0.0), (4.0, 0.0), stroke: (dash: "dash-dotted", thickness: 0.5pt))
  line((2.5, -0.95), (4.0, -0.95), stroke: (dash: "dashed", thickness: 0.5pt))
  line((3.3, -0.95), (3.3, 0.95), stroke: 0.9pt)
  line((2.65, 0.95), (3.95, -0.95), stroke: 0.8pt)
  line((3.3, 0.95), (2.65, 0.95), mark: (end: ">"), stroke: 0.7pt)
  line((3.3, 0.63), (2.87, 0.63), mark: (end: ">"), stroke: 0.6pt)
  line((3.3, 0.32), (3.08, 0.32), mark: (end: ">"), stroke: 0.6pt)
  line((3.3, -0.32), (3.52, -0.32), mark: (end: ">"), stroke: 0.6pt)
  line((3.3, -0.63), (3.73, -0.63), mark: (end: ">"), stroke: 0.6pt)
  line((3.3, -0.95), (3.95, -0.95), mark: (end: ">"), stroke: 0.7pt)

  // --- Pannello Destro: Sezione circolare cava (traslato di +4.6 cm) ---
  circle((5.9, 0.0), radius: 0.95, stroke: 1.1pt)
  circle((5.9, 0.0), radius: 0.45, stroke: 1.1pt)
  line((7.1, 0.0), (4.6, 0.0), mark: (end: ">"), stroke: (dash: "dash-dotted", thickness: 0.7pt))
  content((4.75, -0.2), text(size: 7pt)[$z$], anchor: "north")
  line((5.9, -1.15), (5.9, 1.4), mark: (end: ">"), stroke: (dash: "dash-dotted", thickness: 0.7pt))
  content((5.78, 1.3), text(size: 7pt)[$y$], anchor: "east")

  // Quota diametro interno d e diametro esterno D
  line((5.58, 0.32), (6.22, -0.32), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((5.98, 0.15), text(size: 7pt)[$d$], anchor: "west")
  line((4.95, 0.0), (4.95, -1.5), stroke: 0.5pt)
  line((6.85, 0.0), (6.85, -1.5), stroke: 0.5pt)
  line((4.95, -1.35), (6.85, -1.35), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((5.9, -1.3), text(size: 7pt)[$D$], anchor: "south")

  // Diagramma di tensione sulla corona circolare
  line((7.1, 0.95), (8.6, 0.95), stroke: (dash: "dashed", thickness: 0.5pt))
  line((7.2, 0.0), (8.6, 0.0), stroke: (dash: "dash-dotted", thickness: 0.5pt))
  line((7.1, -0.95), (8.6, -0.95), stroke: (dash: "dashed", thickness: 0.5pt))
  line((7.9, -0.95), (7.9, 0.95), stroke: 0.9pt)
  line((7.25, 0.95), (7.59, 0.45), stroke: 0.8pt)
  line((8.21, -0.45), (8.55, -0.95), stroke: 0.8pt)
  line((7.9, 0.95), (7.25, 0.95), mark: (end: ">"), stroke: 0.7pt)
  line((7.9, 0.70), (7.42, 0.70), mark: (end: ">"), stroke: 0.6pt)
  line((7.9, 0.45), (7.59, 0.45), mark: (end: ">"), stroke: 0.6pt)
  line((7.9, -0.45), (8.21, -0.45), mark: (end: ">"), stroke: 0.6pt)
  line((7.9, -0.70), (8.38, -0.70), mark: (end: ">"), stroke: 0.6pt)
  line((7.9, -0.95), (8.55, -0.95), mark: (end: ">"), stroke: 0.7pt)
})

= Flessione Simultanea nei Piani $x y$ e $x z$ (Flessione Deviata)

== Sovrapposizione degli effetti ed equazione dell'asse neutro

Se sulla sezione trasversale agiscono simultaneamente i momenti flettenti $M_z$ e $M_y$, per la linearità del problema elastico la distribuzione complessiva di tensione normale $sigma_(x x)$ si ottiene applicando il *principio di sovrapposizione degli effetti* (formula binomia di Navier):
$ sigma_(x x) = - M_z / I_z y + M_y / I_y z $

In questa configurazione, l'*asse neutro* non coincide più con uno degli assi coordinati ($z$ o $y$). La sua equazione si determina *imponendo* la condizione di tensione nulla $sigma_(x x) = 0$, dalla quale si ricava l'inclinazione $beta$ dell'asse neutro rispetto all'asse $y$:
$ 0 = - M_z / I_z y + M_y / I_y z arrow.double tan beta = z / y = M_z / M_y dot I_y / I_z $
dove $beta$ indica l'angolo di inclinazione dell'asse neutro misurato a partire dall'asse $y$.

D'altra parte, il *momento flettente totale* (risultante) ha modulo dato dalla *somma vettoriale* delle due componenti ortogonali:
$ M = sqrt(M_z^2 + M_y^2) $
e l'asse attorno a cui agisce il momento risultante forma con l'asse $y$ un angolo di inclinazione $theta$ pari a:
$ tan theta = M_z / M_y $

Confrontando le due inclinazioni $beta$ e $theta$, si distinguono due regimi fondamentali:
- *Momenti d'inerzia uguali ($I_z = I_y$)*: se la sezione trasversale possiede momenti d'inerzia principali uguali, l'inclinazione dell'asse neutro rispetto all'asse $y$ coincide esattamente con l'orientazione del vettore momento flettente risultante:
  $ tan beta = M_z / M_y = tan theta arrow.double beta = theta $
  L'asse attorno a cui ruota la sezione (asse neutro) è parallelo a quello rispetto a cui agisce il momento flettente totale (e quindi perpendicolare all'asse di sollecitazione), con un'orientazione che dipende unicamente dal rapporto tra $M_z$ e $M_y$. In tal caso *la flessione è sempre retta*.
- *Momenti d'inerzia diversi ($I_z != I_y$)*: se i momenti principali d'inerzia sono differenti, l'inclinazione dell'asse neutro differisce dall'orientazione del momento risultante:
  $ tan beta = M_z / M_y dot I_y / I_z != tan theta $
  L'asse neutro attorno a cui ruota la sezione non è più parallelo all'asse del momento flettente totale e la sua giacitura dipende sia dai momenti applicati $M_z$ e $M_y$, sia dalle caratteristiche geometriche ($I_y / I_z$) della sezione. Questo comportamento prende il nome di *flessione deviata*.

== Analisi di una trave a mensola soggetta a flessione deviata

Nella flessione deviata, l'*asse neutro* e l'*asse di sollecitazione non sono tra loro perpendicolari* e non coincidono con gli assi principali d'inerzia ($z$ e $y$) della sezione. Per dimostrarlo concretamente, consideriamo una trave a mensola di lunghezza $l$, a sezione rettangolare, soggetta all'estremità libera a un carico concentrato $P$ applicato nel baricentro e inclinato di un angolo $theta$ rispetto all'asse $z$.

#canvas(length: 1.6cm, {
  import draw: *
  // Parete di incastro e tratteggio
  line((1.2, -0.8), (1.2, 1.8), stroke: 1pt)
  line((1.2, 1.5), (0.9, 1.2), stroke: 0.6pt)
  line((1.2, 1.2), (0.9, 0.9), stroke: 0.6pt)
  line((1.2, 0.9), (0.9, 0.6), stroke: 0.6pt)
  line((1.2, 0.6), (0.9, 0.3), stroke: 0.6pt)
  line((1.2, 0.3), (0.9, 0.0), stroke: 0.6pt)
  line((1.2, 0.0), (0.9, -0.3), stroke: 0.6pt)
  line((1.2, -0.3), (0.9, -0.6), stroke: 0.6pt)
  line((1.2, 1.3), (1.7, 1.8), stroke: 0.6pt)
  line((1.5, 1.3), (2.0, 1.8), stroke: 0.6pt)
  line((1.8, 1.3), (2.3, 1.8), stroke: 0.6pt)

  // Trave a mensola 3D
  // Faccia anteriore (estremità libera): centro in (4.1, -0.3)
  line((3.7, -0.95), (4.5, -0.6), (4.5, 0.35), (3.7, 0.0), close: true, stroke: 1.1pt)
  // Spigoli longitudinali verso l'incastro
  line((3.7, 0.0), (1.2, 1.1), stroke: 1.1pt)
  line((4.5, 0.35), (2.0, 1.45), stroke: 1.1pt)
  line((3.7, -0.95), (1.2, 0.15), stroke: 1.1pt)
  line((1.2, 1.1), (2.0, 1.45), stroke: 1.1pt)

  // Assi coordinati
  line((1.2, 0.62), (1.2, 2.05), mark: (end: ">"), stroke: 0.8pt)
  content((1.05, 1.9), text(size: 7pt)[$y$], anchor: "east")
  line((1.2, 0.62), (0.3, 0.18), mark: (end: ">"), stroke: 0.8pt)
  content((0.55, 0.05), text(size: 7pt)[$z$], anchor: "north")
  line((1.2, 0.62), (5.6, -1.32), mark: (end: ">"), stroke: 0.8pt)
  content((5.35, -1.4), text(size: 7pt)[$x$], anchor: "north")

  // Retta parallela a z sulla sezione libera e asse di sollecitazione (blu)
  line((2.5, -1.1), (5.1, 0.2), stroke: 0.5pt)
  line((3.4, 1.65), (4.1, -0.3), stroke: (paint: blue, thickness: 1.1pt))
  content((3.3, 1.7), text(size: 7pt, fill: blue)[asse di sollecitazione], anchor: "south")

  // Carico P e scomposizione (P sin theta in azzurro, P cos theta in verde)
  line((4.1, -0.3), (4.1, -1.95), mark: (end: ">"), stroke: (paint: rgb(0, 150, 220), thickness: 1.3pt))
  content((3.95, -1.3), text(size: 7pt, fill: rgb(0, 150, 220))[$P sin theta$], anchor: "east")
  line((4.1, -1.95), (4.65, -1.68), mark: (end: ">"), stroke: (paint: rgb(0, 150, 60), thickness: 1.3pt))
  content((4.4, -1.9), text(size: 7pt, fill: rgb(0, 150, 60))[$P cos theta$], anchor: "north")
  line((4.1, -0.3), (4.65, -1.68), mark: (end: ">"), stroke: 1.4pt)
  content((4.55, -0.95), text(size: 7pt)[$P$], anchor: "west")

  // Archi angolo theta
  arc((4.1, -0.3), start: -68deg, stop: 26deg, radius: 0.5, anchor: "origin", stroke: (paint: blue, thickness: 0.9pt))
  content((4.7, -0.35), text(size: 7pt, fill: blue)[$theta$], anchor: "west")

  // Momenti all'incastro M_z (azzurro) e M_y (verde)
  arc((0.5, 0.35), start: -50deg, stop: 55deg, radius: 0.55, anchor: "origin", mark: (end: ">"), stroke: (paint: rgb(0, 150, 220), thickness: 1.8pt))
  content((0.7, 0.95), text(size: 7pt, fill: rgb(0, 150, 220))[$-P sin theta dot l = M_z$], anchor: "east")

  arc((1.35, 1.35), start: 210deg, stop: 330deg, radius: 0.65, anchor: "origin", mark: (end: ">"), stroke: (paint: rgb(0, 150, 60), thickness: 1.8pt))
  content((2.1, 1.35), text(size: 7pt, fill: rgb(0, 150, 60))[$M_y = P cos theta dot l$], anchor: "west")
})

Scomponendo il carico $P$ lungo gli assi principali d'inerzia, le caratteristiche di sollecitazione flettenti nella sezione d'incastro valgono:
$ M_z = -P sin theta dot l, quad M_y = P cos theta dot l $
Per sovrapposizione degli effetti, la tensione normale totale nella sezione d'incastro è data dalla somma dei contributi generati da $M_z$ e da $M_y$:
$ sigma_(x x) = sigma_(x x, M_z) + sigma_(x x, M_y) = - M_z / I_z y + M_y / I_y z = (P l sin theta) / I_z y + (P l cos theta) / I_y z $

Imponendo la condizione di annullamento della tensione $sigma_(x x) = 0$ per individuare l'asse neutro, si ottiene:
$ - M_z / I_z y + M_y / I_y z = 0 arrow.double z = M_z / M_y dot I_y / I_z y $
Il coefficiente angolare di tale retta fornisce la tangente dell'angolo d'inclinazione $beta$ dell'asse neutro rispetto all'asse $y$:
$ tan beta = M_z / M_y dot I_y / I_z = (P l sin theta) / (P l cos theta) dot I_y / I_z = tan theta dot I_y / I_z $
Al contempo, il momento flettente totale $M = sqrt(M_z^2 + M_y^2)$ presenta un'inclinazione $theta$ rispetto all'asse $z$ (che equivale all'angolo formato dall'asse di sollecitazione con l'asse $y$) definita da:
$ tan theta = M_z / M_y $

#canvas(length: 1.3cm, {
  import draw: *
  // Sezione rettangolare centrata nell'origine (0, 0)
  rect((-0.95, -1.45), (0.95, 1.45), stroke: 1.4pt)

  // Assi principali z e y
  line((1.2, 0.0), (-2.0, 0.0), mark: (end: ">"), stroke: 0.7pt)
  content((-1.85, 0.15), text(size: 7pt)[$z$], anchor: "south")
  line((0.0, -1.95), (0.0, 2.3), mark: (end: ">"), stroke: 0.7pt)
  content((0.15, 2.1), text(size: 7pt)[$y$], anchor: "west")

  // Asse di sollecitazione (blu, secondo quadrante) e carico P (quarto quadrante, 18 gradi da y)
  line((-0.95, 2.8), (0.0, 0.0), stroke: (paint: blue, thickness: 1.1pt))
  content((-0.9, 2.85), text(size: 7pt, fill: blue)[asse di sollecitazione], anchor: "south")
  line((0.0, 0.0), (0.72, -2.15), mark: (end: ">"), stroke: 1.5pt)
  content((0.8, -1.95), text(size: 7pt)[$P$], anchor: "west")

  // Retta perpendicolare all'asse di sollecitazione (tratteggiata, inclinata di 18 gradi su z)
  line((-2.7, -0.9), (3.1, 1.03), stroke: (dash: "dashed", thickness: 0.7pt))
  content((3.15, 0.9), text(size: 7pt)[$perp$ all'asse di sollecitazione], anchor: "west")

  // Asse neutro (rosso, meno inclinato sull'orizzontale perché I_z > I_y => beta > theta)
  line((-2.3, -0.52), (2.3, 0.52), stroke: (paint: red, thickness: 1.2pt))
  content((-2.35, -0.52), text(size: 7pt, fill: red)[asse neutro], anchor: "east")

  // Archi per gli angoli theta (blu) e beta (rosso)
  arc((0, 0), start: 18deg, stop: 90deg, radius: 0.75, anchor: "origin", stroke: (paint: blue, thickness: 0.9pt))
  content((0.28, 0.42), text(size: 7pt, fill: blue)[$theta$])

  arc((0, 0), start: -72deg, stop: 0deg, radius: 0.75, anchor: "origin", stroke: (paint: blue, thickness: 0.9pt))
  content((0.68, -0.62), text(size: 7pt, fill: blue)[$theta$])

  arc((0, 0), start: 13deg, stop: 90deg, radius: 1.15, anchor: "origin", stroke: (paint: red, thickness: 1.1pt))
  content((1.15, 1.0), text(size: 7pt, fill: red)[$beta$], anchor: "west")
})

Poiché per una sezione rettangolare con $h > b$ risulta $I_z > I_y$, si ha $beta > theta$: l'asse neutro si avvicina all'asse principale avente momento d'inerzia maggiore (asse $z$). Ciò dimostra sia graficamente sia analiticamente che l'asse neutro e l'asse di sollecitazione non sono tra loro perpendicolari e non coincidono con gli assi principali d'inerzia della sezione.

#nota[
  *Condizione di assenza di flessione deviata*:
  Dalla relazione generale:
  $ tan beta = M_z / M_y dot I_y / I_z = tan theta dot I_y / I_z $
  si deduce che l'asse neutro e l'asse di sollecitazione sono tra loro perpendicolari ($beta = theta$) se e solo se $I_z = I_y$, condizione che si verifica per le *sezioni circolari* (piene o cave) e *quadrate* (o poligonali regolari). In tali sezioni, qualunque sia l'inclinazione del carico flettente, *non si verifica mai flessione deviata*.
]
