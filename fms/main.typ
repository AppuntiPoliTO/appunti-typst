#import "@preview/cetz:0.3.4": canvas, draw
#set page(paper: "a4", margin: 2cm)
#set text(lang: "it", size: 11pt)
#set par(justify: true)
#set heading(numbering: none)
#set page(margin: 1.5cm)
#let immagine-originale = image
#let image(nome-file, ..args) = immagine-originale("images/" + nome-file)
// Nota / osservazione
#let nota(body) = block(
  width: 100%, fill: luma(240), inset: 8pt, radius: 3pt, body,)
#let circ = sym.degree
#let varphi = $phi$
// --- INTESTAZIONE ---
#align(center)[
  #v(0.5cm)
  #line(length: 100%, stroke: 1.5pt)
  #v(0.4cm, weak: true)
  #text(size: 20pt, weight: "bold", fill: black)[Appunti del Corso] \
  #v(0.2cm, weak: true)
  #line(length: 100%, stroke: 0.5pt)
  #v(0.4cm, weak: true)
  
  #grid(
    columns: (1fr, 1fr),
    align(left)[
      *Autori:* \
      Marco Vicari \
      Federico Toro
    ],
    align(right)[
      *Istituzione:* \
      Politecnico di Torino \
      #text(size: 9pt)[Anno Accademico 2026/2027]
    ]
  )
  #v(1cm)
]
#outline(indent: auto, depth: 2)

#pagebreak()

= Riassunto FMS

== Geometria delle aree

// [DA SLIDE]

Suc
Nello studio della meccanica delle strutture, una trave è descritta geometricamente attraverso due elementi fondamentali:
- *Asse geometrico della trave:* è la linea formata dal luogo dei baricentri delle sezioni trasversali della trave. In generale può essere una curva qualsiasi nello spazio, ma nella maggior parte delle applicazioni ingegneristiche è una linea piana e, più specificamente, un segmento di retta (*travi ad asse rettilineo*).
- *Sezione trasversale (o sezione retta):* è la figura piana ottenuta tagliando la trave con un piano ortogonale all'asse geometrico. Può variare lungo l'asse, ma molto spesso si mantiene costante.


La resistenza e la deformabilità di una struttura non dipendono soltanto dall'intensità delle caratteristiche di sollecitazione applicate, ma anche da come queste interagiscono con le *proprietà geometriche della sezione retta*:
  1. *Influenza della forma (a parità di area):* due travi costituite dallo stesso materiale e aventi la *stessa area* della sezione trasversale ma *forma diversa* — ad esempio una sezione quadrata piena di lato $4 l$ (area $A = 16 l^2$) e una sezione a doppia T con ali di dimensioni $4 l times l$ e anima $8 l times l$ (area $A = 2 dot (4 l^2) + 8 l^2 = 16 l^2$) — manifestano un comportamento meccanico profondamente diverso (la sezione a doppia T offre una rigidezza a flessione molto superiore perché distribuisce il materiale lontano dall'asse baricentrico).
  2. *Influenza dell'orientazione:* considerando una trave a mensola di lunghezza $l$ e sezione rettangolare di lati $L_1 < L_2$ soggetta a una forza trasversale $F$ all'estremo libero, se la sezione è disposta "di piatto" (altezza verticale $L_1$, base orizzontale $L_2$) subisce una freccia inflessionale $f_1$ molto maggiore rispetto al caso in cui la stessa sezione sia ruotata di $90^circ$ e disposta "di taglio" (altezza verticale $L_2$, base orizzontale $L_1$, con freccia $f_2 << f_1$).

#v(1em)

== Momento Statico

Il *momento statico* è una grandezza geometrica fondamentale del primo ordine che descrive la distribuzione di un'area rispetto a un asse di riferimento. Per comprenderne il significato fisico, consideriamo una sezione piana di area $A$ e *densità superficiale costante* $rho$ ($[rho] = #"kg"/#"m"^2$).

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (left + horizon, center + horizon),
  [
   
      *Definizione analitica* \
      $ S_y = integral_A z dif A $
      - *Dimensioni:* $[L^3]$ ($#"m"^3$ o $#"mm"^3$)
      - *Segno:* può essere $S > 0$, $S < 0$ oppure $S = 0$ in base alla posizione dell'asse rispetto alla sezione.
    
    #v(0.5em)
    / Area elementare ($dif A$): porzione infinitesima della superficie $A$, posta a distanza $z$ dall'asse di riferimento.
    / Forza peso elementare ($dif P$): forza agente su $dif A$ (per unità di lunghezza), di modulo $|dif P| = g rho dif A$.
    / Risultante ($P$): somma integrale delle forze elementari parallele, applicata a distanza $a$ dall'asse, di modulo $|P| = integral_A dif P = g rho A$.
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  // 1. Riempimento elemento infinitesimo dA
  rect((0.83, 0.26), (1.83, 0.86), fill: rgb(198, 217, 241), stroke: none)

  // Contorno di dA (lati verticali continui, orizzontali tratteggiati come nello schizzo)
  line((0.83, 0.26), (0.83, 0.86), stroke: 0.7pt)
  line((1.83, 0.26), (1.83, 0.86), stroke: 0.7pt)
  line((0.83, 0.86), (1.83, 0.86), stroke: (dash: "dashed", thickness: 0.7pt))
  line((0.83, 0.26), (1.83, 0.26), stroke: (dash: "dashed", thickness: 0.7pt))

  // 2. Contorno chiuso della superficie A (4 Bezier C1)
  bezier((-2.77, 0.29), (-0.31, 2.14), (-2.77, 1.55), (-1.60, 2.14), stroke: 1.4pt)
  bezier((-0.31, 2.14), (3.06, 0.14), (1.60, 2.14), (3.06, 1.25), stroke: 1.4pt)
  bezier((3.06, 0.14), (-1.00, -1.80), (3.06, -1.20), (1.10, -1.80), stroke: 1.4pt)
  bezier((-1.00, -1.80), (-2.77, 0.29), (-2.20, -1.80), (-2.77, -0.90), stroke: 1.4pt)

  // 3. Assi e linee di riferimento
  // Retta d'azione tratteggiata sopra P
  line((0, 0.20), (0, 3.20), stroke: (dash: "dashed", thickness: 1.3pt))

  // Asse di riferimento verticale destro tratteggiato
  line((4.46, -3.30), (4.46, 3.20), stroke: (dash: "dashed", thickness: 1.3pt))

  // Linea di riferimento verticale sotto dP per la quota z
  line((1.40, -0.90), (1.40, -2.60), stroke: 0.6pt)

  // 4. Vettori e quote
  // Vettore forza risultante P
  line((0, 0), (0, -3.20), mark: (end: ">", size: 0.3), stroke: 1.6pt)

  // Vettore forza elementare dP
  line((1.33, 0.56), (1.33, -0.25), mark: (end: ">", size: 0.2), stroke: 1.2pt)

  // Quota a
  line((0.12, 2.80), (4.34, 2.80), mark: (start: ">", end: ">", size: 0.18), stroke: 0.7pt)

  // Quota z
  line((1.50, -1.95), (4.34, -1.95), mark: (start: ">", end: ">", size: 0.18), stroke: 0.7pt)

  // 5. Etichette (tutte con text(size: 7pt))
  content((-2.50, 1.85), text(size: 12pt)[$A$], anchor: "east")
  content((2.23, 3.00), text(size: 12pt)[$a$], anchor: "south")
  content((1.92, 0.65), text(size: 12pt, fill: rgb(45, 105, 155))[$d A$], anchor: "west")
  content((1.33, -0.55), text(size: 12pt)[$d P$], anchor: "center")
  content((-0.30, -3.05), text(size: 12pt)[$P$], anchor: "east")
  content((2.92, -2.15), text(size: 10pt)[$z$], anchor: "north")
})
  ]
)

#v(0.5em)
*Derivazione per equivalenza statica:* imponendo che il momento della risultante $P$ rispetto a un asse $m$ (o $y$) parallelo ad essa e posto a distanza $a$ uguagli la somma integrale dei momenti delle forze elementari $dif P$ (poste a distanza $z$), si ottiene la relazione fondamentale:
$ P dot a = integral_A z dif P = g rho integral_A z dif A $

Definendo il *momento statico* rispetto all'asse $m$ come $S_m = integral_A z dif A$, è possibile ricavare la distanza $a$ della retta d'azione di $P$ dall'asse stesso. Analogamente, ruotando idealmente l'area di $90^circ$, si individua una nuova risultante verticale $P'$ rispetto a un secondo asse $m'$:
Distanza rispetto all'asse $m$:*
    $ a = (g rho integral_A z dif A) / P = (g rho S_m) / P = S_m / A $
  ,
  block(fill: luma(245), inset: 10pt, radius: 4pt, width: 100%)[
    *Distanza rispetto all'asse $m'$ (rotazione di $90^circ$):
    $ a' = (g rho S_(m')) / P' = S_(m') / A $


#v(1.5em)
== Baricentro
Dalle relazioni precedenti emerge immediatamente che il momento statico calcolato esattamente rispetto alla retta d'azione della risultante (ovvero imponendo distanza nulla, $a = 0$ oppure $a' = 0$) è *nullo*.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (left + horizon, center + horizon),
  [
    / Baricentro ($G$ o $C$): punto geometrico individuato dall'*intersezione delle rette d'azione* delle due risultanti ortogonali $P$ e $P'$ delle forze peso elementari.
    / Sistema di riferimento ($x y z$): terna cartesiana di riferimento in cui $x$ rappresenta l'asse longitudinale della trave e $y, z$ giacciono nel piano della sezione $A$.

    #v(0.5em)
    
      *Coordinate del baricentro:*
      $ z_C = z_G = (integral_A z dif A) / A = S_y / A $
      $ y_C = y_G = (integral_A y dif A) / A = S_z / A $
    
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  // 1. Contorno chiuso della superficie A (4 Bezier C1)
  bezier((0.00, 2.90), (2.00, -0.80), (1.25, 2.90), (2.00, 0.85), stroke: 1.5pt)
  bezier((2.00, -0.80), (0.05, -2.97), (2.00, -2.15), (1.25, -2.97), stroke: 1.5pt)
  bezier((0.05, -2.97), (-1.87, -0.57), (-1.25, -2.97), (-1.87, -2.05), stroke: 1.5pt)
  bezier((-1.87, -0.57), (0.00, 2.90), (-1.87, 1.20), (-1.15, 2.90), stroke: 1.5pt)

  // 2. Rette baricentriche tratteggiate
  line((0, -0.25), (0, 2.65), stroke: (dash: "dashed", thickness: 0.9pt))
  line((-3.05, 0), (0.15, 0), stroke: (dash: "dashed", thickness: 0.9pt))

  // 3. Vettori P e P'
  line((0, -0.80), (0, -3.70), mark: (end: ">", size: 0.35), stroke: 1.6pt)
  line((0.55, -0.03), (3.75, -0.03), mark: (end: ">", size: 0.35), stroke: 1.6pt)

  // 4. Terna di riferimento (x, y, z)
  line((3.13, -3.00), (3.13, -1.97), mark: (end: ">", size: 0.14), stroke: 0.6pt)
  line((3.13, -3.00), (2.10, -3.00), mark: (end: ">", size: 0.14), stroke: 0.6pt)
  line((3.13, -3.00), (3.93, -3.63), mark: (end: ">", size: 0.14), stroke: 0.6pt)

  // 5. Etichette (tutte con text(size: 7pt))
  content((-1.75, 1.95), text(size: 13pt, fill: rgb(75, 90, 110))[$A$], anchor: "east")
  content((-0.30, 0.25), text(size: 13pt)[G], anchor: "south-east")
  content((3.40, 0.40), text(size: 13pt, fill: rgb(75, 90, 110))[$P'$], anchor: "south")
  content((-0.45, -3.35), text(size: 13pt, fill: rgb(75, 90, 110))[$P$], anchor: "east")

  content((3.28, -2.10), text(size: 9pt, fill: rgb(60, 70, 85))[$y$], anchor: "west")
  content((2.20, -3.18), text(size: 9pt, fill: rgb(60, 70, 85))[$z$], anchor: "north")
  content((3.65, -3.55), text(size: 9pt, fill: rgb(60, 70, 85))[$x$], anchor: "north-east")
})
  ]
)

#v(1em)

  *Proprietà degli assi baricentrici e di simmetria*
  \
  
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.5em,
    [
      *Assi baricentrici:* se gli assi $y$ e $z$ passano per il baricentro (ovvero l'origine coincide con $G$, rendendo $z_C = 0$ e $y_C = 0$), i relativi momenti statici baricentrici sono *identicamente nulli*:
      $ S_y = 0 quad "e" quad S_z = 0 $
    ],
    [
      *Assi di simmetria o antisimmetria:* se la sezione possiede un *asse di simmetria* (es. sezioni a U o a doppia T) o di *antisimmetria* (es. sezione a Z), il momento statico calcolato rispetto a tale asse è nullo per definizione. Pertanto, *ogni asse di simmetria (o antisimmetria) è necessariamente un asse baricentrico*.
    ]
  )

// [DA SLIDE]
#v(1em)
=== Momento statico rispetto a una direzione arbitraria
Consideriamo un sistema di riferimento cartesiano $z y$ con origine nel baricentro $G$ della sezione (*assi baricentrici*, per i quali $S_y = 0$ e $S_z = 0$). Vogliamo calcolare il momento statico $S_r$ della superficie di area $A$ rispetto a una retta generica $r$, inclinata di un angolo $alpha$ rispetto all'asse $z$ e posta a distanza $d_G$ dal baricentro $G$.

    Tracciando la retta passante per $G$ e parallela a $r$, la distanza $d$ dell'area elementare $dif A$ (di coordinate baricentriche $z, y$) dalla retta $r$ si scompone come:
    $ d = d_G + Delta d $
    Per la similitudine dei triangoli rettangoli individuati dalle proiezioni di $z$ e $y$ sulla direzione ortogonale a $r$, vale la relazione geometrica:
    $ Delta d = z sin alpha + y cos alpha $
#grid(
  columns: (1.2fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    
    Sostituendo nell'espressione integrale del momento statico rispetto alla retta $r$ e sfruttando la linearità dell'integrale:
    $ S_r = integral_A d dif A = integral_A (d_G + Delta d) dif A = integral_A d_G dif A + integral_A (z sin alpha + y cos alpha) dif A $
    Portando fuori dal segno di integrale i termini costanti rispetto all'integrazione d'area ($d_G$, $sin alpha$, $cos alpha$):
    $ S_r = d_G integral_A dif A + sin alpha underbrace(integral_A z dif A, S_y = 0) + cos alpha underbrace(integral_A y dif A, S_z = 0) $
    Poiché i momenti statici rispetto agli assi baricentrici sono identicamente nulli ($S_y = 0$ e $S_z = 0$), si ottiene la proprietà generale:
    $ |S_r| = A dot d_G $
  ],
  [
    #canvas(length: 1.2cm, {
      import draw: *

      // Contorno chiuso della sezione A
      bezier((-2.4, 0.2), (-0.2, 1.8), (-2.4, 1.3), (-1.3, 1.8), stroke: 1.3pt)
      bezier((-0.2, 1.8), (2.2, 0.1), (1.2, 1.8), (2.2, 1.1), stroke: 1.3pt)
      bezier((2.2, 0.1), (-0.7, -1.5), (2.2, -1.0), (0.9, -1.5), stroke: 1.3pt)
      bezier((-0.7, -1.5), (-2.4, 0.2), (-1.8, -1.5), (-2.4, -0.8), stroke: 1.3pt)

      // Assi baricentrici z (sinistra) e y (alto) con origine in G(0,0)
      line((0.5, 0), (-3.2, 0), mark: (end: ">", size: 0.2), stroke: 0.8pt)
      line((0, -1.8), (0, 2.6), mark: (end: ">", size: 0.2), stroke: 0.8pt)
      content((-3.1, -0.3), text(size: 9pt)[$z$])
      content((0.3, 2.5), text(size: 9pt)[$y$])
      content((0.3, -0.3), text(size: 9pt)[$G$])

      // Elemento infinitesimo dA in (-1.2, 0.6)
      rect((-1.45, 0.45), (-0.95, 0.75), fill: rgb(198, 217, 241), stroke: 0.6pt)
      content((-1.55, 0.85), text(size: 9pt, fill: rgb(45, 105, 155))[$dif A$])

      // Proiezioni z e y di dA
      line((-1.2, 0), (-1.2, 0.45), stroke: (dash: "dashed", thickness: 0.5pt))
      line((0, 0.6), (-0.95, 0.6), stroke: (dash: "dashed", thickness: 0.5pt))

      // Retta baricentrica parallela a r (inclinata di alpha = 25 gradi)
      line((-2.5, -1.16), (2.2, 1.03), stroke: 0.7pt + gray)

      // Retta parallela passante per dA (-1.2, 0.6)
      line((-2.8, -0.15), (1.5, 1.86), stroke: 0.7pt + gray)

      // Retta r a distanza d_G sotto G
      line((-1.6, -2.65), (3.1, -0.46), stroke: 1.1pt + gray)
      content((2.4, -1.1), text(size: 9pt)[$r$])

      // Quote d_G e Delta d (lungo la normale a r)
      line((-2.1, -0.98), (-1.35, -2.53), mark: (start: ">", end: ">", size: 0.15), stroke: 0.6pt)
      content((-2.1, -1.9), text(size: 8pt)[$d_G$])

      line((-2.1, -0.98), (-2.48, -0.19), mark: (start: ">", end: ">", size: 0.15), stroke: 0.6pt)
      content((-2.75, -0.55), text(size: 8pt)[$Delta d$])

      // Arco angolo alpha
      arc((-0.8, 0), start: 180deg, stop: 205deg, radius: 0.8, stroke: 0.6pt)
      content((-1.05, -0.22), text(size: 8pt)[$alpha$])
    })
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Sezione triangolare*

    $ S_z = integral_A y dif A = (b h^2) / 6 $

    // [DA SLIDE]
    #align(left)[
      Calcoliamo il momento statico di un triangolo rettangolo di base $b$ e altezza $h$ rispetto all'asse $z$ passante per la base.
      Considerando una striscia elementare parallela alla base di spessore $dif y$ e larghezza $z$ (area $dif A = z dif y$), la coordinata del lato obliquo varia linearmente con $y$ secondo la relazione:
      $ z = b dot (1 - y / h) $
      Integrando sull'intera altezza da $0$ a $h$:
      $ S_z = integral_A y dif A = integral_A y dot z dif y = integral_0^h b dot (1 - y / h) dot y dif y = (b h^2) / 6 $
      
    ]
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  // 1. Riempimento e contorno della striscia elementare azzurra
  rect((-1.56, 3.09), (0, 3.69), fill: rgb(195, 214, 238), stroke: 0.5pt + rgb(70, 80, 95))

  // 2. Linee di riferimento sottili per le quote
  // Riferimenti per dy (a sinistra)
  line((-3.85, 3.69), (-1.56, 3.69), stroke: 0.5pt)
  line((-3.85, 3.09), (-1.56, 3.09), stroke: 0.5pt)

  // Riferimento verticale per z (sotto la striscia)
  line((-1.56, 3.09), (-1.56, 2.45), stroke: 0.5pt)

  // Riferimenti per b (in basso)
  line((-3.77, 0), (-3.77, -1.00), stroke: 0.5pt)
  line((0, 0), (0, -1.00), stroke: 0.5pt)

  // Riferimenti per y e h (a destra)
  line((0, 3.09), (0.65, 3.09), stroke: 0.5pt)
  line((0, 6.29), (1.45, 6.29), stroke: 0.5pt)
  line((0, 0), (1.45, 0), stroke: 0.5pt)

  // 3. Assi principali z e y
  line((0, 0), (0, 7.25), mark: (end: ">", size: 0.22), stroke: 0.6pt)
  line((0, 0), (-4.45, 0), mark: (end: ">", size: 0.22), stroke: 0.6pt)

  // 4. Contorno del triangolo rettangolo (spesso)
  line((0, 0), (-3.77, 0), (0, 6.29), close: true, stroke: 1.4pt)

  // 5. Baricentro G e assi baricentrici (z_G, y_G)
  circle((-1.14, 1.80), radius: 0.03, fill: black, stroke: none)
  line((-1.14, 1.80), (-1.14, 2.40), mark: (end: ">", size: 0.12), stroke: 0.5pt)
  line((-1.14, 1.80), (-1.68, 1.80), mark: (end: ">", size: 0.12), stroke: 0.5pt)

  // 6. Frecce delle quote
  // Quota dy
  line((-3.68, 4.45), (-3.68, 3.69), mark: (end: ">", size: 0.20), stroke: 0.5pt)
  line((-3.68, 2.33), (-3.68, 3.09), mark: (end: ">", size: 0.20), stroke: 0.5pt)

  // Quota z (con pallino sull'asse y)
  circle((0, 2.55), radius: 0.07, fill: black, stroke: none)
  line((0, 2.55), (-1.56, 2.55), mark: (end: ">", size: 0.20), stroke: 0.6pt)

  // Quota y (con pallino sulla base)
  circle((0.52, 0), radius: 0.07, fill: black, stroke: none)
  line((0.52, 0), (0.52, 3.09), mark: (end: ">", size: 0.20), stroke: 0.6pt)

  // Quota h
  line((1.30, 0), (1.30, 6.29), mark: (start: ">", end: ">", size: 0.20), stroke: 0.6pt)

  // Quota b
  line((-3.77, -0.82), (0, -0.82), mark: (start: ">", end: ">", size: 0.20), stroke: 0.6pt)

  // 7. Etichette (tutte con text(size: 7pt))
  content((-0.25, 7.15), text(size: 7pt)[$y$], anchor: "east")
  content((-4.30, 0.30), text(size: 7pt)[$z$], anchor: "south")
  content((-1.88, -0.70), text(size: 7pt)[$b$], anchor: "south")
  content((1.48, 3.15), text(size: 7pt)[$h$], anchor: "west")
  content((0.65, 1.55), text(size: 7pt)[$y$], anchor: "west")
  content((-0.78, 2.65), text(size: 7pt)[$z$], anchor: "south")
  content((-3.95, 3.39), text(size: 7pt, fill: rgb(45, 105, 155))[$d y$], anchor: "east")

  content((-1.20, 1.58), text(size: 7pt, fill: rgb(80, 90, 105))[$G$], anchor: "north")
  content((-1.00, 2.15), text(size: 7pt)[$y_("G")$], anchor: "west")
  content((-1.72, 1.75), text(size: 7pt)[$z_("G")$], anchor: "east")
})
  ]
)
_(Nota: dividendo per l'area $A = (b h)/2$, si ricava l'ordinata del baricentro $y_C = S_z / A = h / 3$)._
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Sezione rettangolare*

    $ S_z = (b h^2) / 2 $

    // [DA SLIDE]
    #align(left)[
      Rispetto all'asse $z$ passante per la base del rettangolo, la larghezza della striscia elementare di spessore $dif y$ è costante e pari a $z = b$, per cui $dif A = z dif y = b dif y$. Svolgendo l'integrale:
      $ S_z = integral_A y dif A = integral_A y dot z dif y = integral_0^h y dot b dif y = b integral_0^h y dif y = (b h^2) / 2 $
      _(da cui $y_C = S_z / (b h) = h / 2$)._
    ]
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  // 1. Riempimento e bordi orizzontali della striscia elementare azzurra
  rect((-3.88, 4.16), (0, 4.75), fill: rgb(195, 214, 238), stroke: none)
  line((-3.88, 4.75), (0, 4.75), stroke: 1.2pt + rgb(35, 75, 120))
  line((-3.88, 4.16), (0, 4.16), stroke: 1.2pt + rgb(35, 75, 120))

  // 2. Linee di riferimento sottili per le quote
  // Riferimenti per dy (a sinistra)
  line((-4.70, 4.75), (-3.88, 4.75), stroke: 0.5pt)
  line((-4.70, 4.16), (-3.88, 4.16), stroke: 0.5pt)
  line((-4.58, 4.16), (-4.58, 4.75), stroke: 0.5pt)

  // Riferimenti per b (in basso)
  line((-3.88, 0), (-3.88, -0.95), stroke: 0.5pt)
  line((0, 0), (0, -0.95), stroke: 0.5pt)

  // Riferimenti per h (a destra)
  line((0, 5.62), (1.25, 5.62), stroke: 0.5pt)
  line((0, 0), (1.25, 0), stroke: 0.5pt)

  // 3. Assi principali z e y
  line((0, 0), (0, 6.95), mark: (end: ">", size: 0.22), stroke: 0.6pt)
  line((0, 0), (-5.45, 0), mark: (end: ">", size: 0.22), stroke: 0.6pt)

  // 4. Contorno del rettangolo principale (spesso)
  rect((-3.88, 0), (0, 5.62), stroke: 1.4pt)

  // 5. Baricentro G e assi baricentrici (z_G, y_G)
  circle((-1.94, 2.81), radius: 0.04, fill: black, stroke: none)
  line((-1.94, 2.81), (-1.94, 3.88), mark: (end: ">", size: 0.14), stroke: 0.5pt)
  line((-1.94, 2.81), (-3.05, 2.81), mark: (end: ">", size: 0.14), stroke: 0.5pt)

  // 6. Frecce delle quote
  // Quota dy
  line((-4.58, 5.45), (-4.58, 4.75), mark: (end: ">", size: 0.15), stroke: 0.5pt)
  line((-4.58, 3.46), (-4.58, 4.16), mark: (end: ">", size: 0.15), stroke: 0.5pt)

  // Quota h
  line((1.10, 0), (1.10, 5.62), mark: (start: ">", end: ">", size: 0.20), stroke: 0.6pt)

  // Quota b
  line((-3.88, -0.82), (0, -0.82), mark: (start: ">", end: ">", size: 0.20), stroke: 0.6pt)

  // 7. Etichette (tutte con text(size: 7pt))
  content((0.40, 6.70), text(size: 7pt)[$y$], anchor: "west")
  content((-5.10, 0.25), text(size: 7pt)[$z$], anchor: "south")
  content((0.20, -0.15), text(size: 7pt)[$O$], anchor: "north-west")
  content((-1.94, -0.70), text(size: 7pt)[$b$], anchor: "south")
  content((1.28, 2.81), text(size: 7pt)[$h$], anchor: "west")
  content((-4.78, 4.45), text(size: 7pt, fill: rgb(45, 105, 155))[$d y$], anchor: "east")

  content((-2.15, 2.55), text(size: 7pt)[$G$], anchor: "north")
  content((-2.08, 3.65), text(size: 7pt)[$y_("G")$], anchor: "east")
  content((-2.95, 2.95), text(size: 7pt)[$z_("G")$], anchor: "south")
})
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Sezione circolare*

    $ S = A dot d = pi r^2 d $

    // [DA SLIDE]
    #align(left)[
      Nel caso di un cerchio di raggio $r$ (area $A = pi r^2$) il cui centro — che per simmetria coincide con il baricentro $G$ — si trova a distanza $d$ da una retta assegnata, applicando direttamente la proprietà $S = A dot d_G$ si ottiene $S = pi r^2 d$.
    ]
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  // 1. Contorno del cerchio
  circle((0, 0), radius: 2.47, stroke: 1.4pt)

  // 2. Linee di riferimento verticali
  line((0, 0), (0, 3.60), stroke: 0.7pt)
  line((4.75, -3.00), (4.75, 3.60), stroke: 0.9pt)

  // 3. Vettore raggio r e quota d
  line((0, 0), (2.05, -1.38), mark: (end: ">", size: 0.22), stroke: 1.4pt)
  line((0, 2.55), (4.75, 2.55), mark: (start: ">", end: ">", size: 0.22), stroke: 1.1pt)

  // 4. Etichette (tutte con text(size: 7pt))
  content((2.38, 2.75), text(size: 7pt)[$d$], anchor: "south")
  content((0.10, -1.35), text(size: 7pt)[$r$], anchor: "north")
})
  ]
)
#v(1em)
#pagebreak()
=== Momenti statici: teorema di trasposizione

Noto il momento statico $S_1$ rispetto all'asse $y_1$, vogliamo calcolare il momento statico rispetto all'asse $y_2$. Sono note le distanze:
    - $d$ tra le rette parallele $y_1$ e $y_2$
    - $b_1$ tra la retta $y_1$ e la retta baricentrica
    - $b_2$ tra la retta $y_2$ e la retta baricentrica: $b_2 = b_1 + d$

    $ S_1 = integral_A z_1 dif A $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    

    *Momento di trasporto:*
    $ S_2 = integral_A z_2 dif A = A b_2 = A (b_1 + d) = S_1 + A d $

    // [DA SLIDE]
    dove $S_1 = integral_A z_1 dif A = A b_1$ e il termine additivo $A d$ prende il nome di *momento di trasporto*.

    *Caso particolare ($y_1$ baricentrico):* se l'asse $y_1$ coincide con l'asse baricentrico ($b_1 = 0$), allora $S_1 = 0$ e posto $d = d_G$ si ritrova immediatamente:
    $ |S_2| = A dot d_G $
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  rect((0.69, 0.50), (1.53, 1.03), fill: rgb(198, 217, 241), stroke: none)
  line((0.69, 0.50), (0.69, 1.03), stroke: 0.6pt)
  line((1.53, 0.50), (1.53, 1.03), stroke: 0.6pt)
  line((0.69, 1.03), (1.53, 1.03), stroke: (dash: "dashed", thickness: 0.6pt))
  line((0.69, 0.50), (1.53, 0.50), stroke: (dash: "dashed", thickness: 0.6pt))

  // 2. Contorno chiuso della superficie A (4 Bezier C1)
  bezier((-2.34, 0.28), (-0.25, 1.97), (-2.34, 1.40), (-1.35, 1.97), stroke: 1.4pt)
  bezier((-0.25, 1.97), (2.56, 0.19), (1.35, 1.97), (2.56, 1.15), stroke: 1.4pt)
  bezier((2.56, 0.19), (-0.85, -1.44), (2.56, -0.95), (0.95, -1.44), stroke: 1.4pt)
  bezier((-0.85, -1.44), (-2.34, 0.28), (-1.85, -1.44), (-2.34, -0.75), stroke: 1.4pt)

  // 3. Assi tratteggiati e linea di riferimento
  // Retta d'azione di P
  line((0, 0.15), (0, 3.75), stroke: (dash: "dashed", thickness: 1.2pt))

  // Asse y_1
  line((3.72, -2.85), (3.72, 3.00), stroke: (dash: "dashed", thickness: 1.2pt))

  // Asse y_2
  line((4.59, -2.85), (4.59, 3.75), stroke: (dash: "dashed", thickness: 1.2pt))

  // Linea di riferimento verticale dal centro di dA
  line((1.11, 0.70), (1.11, -1.35), stroke: 0.6pt)

  // 4. Vettore P e quote orizzontali
  // Vettore forza risultante P
  line((0, 0), (0, -2.55), mark: (end: ">", size: 0.30), stroke: 1.6pt)

  // Quota b_2 = b_1 + d
  line((0.10, 3.40), (4.49, 3.40), mark: (start: ">", end: ">", size: 0.16), stroke: 0.6pt)

  // Quota b_1
  line((0.10, 2.40), (3.62, 2.40), mark: (start: ">", end: ">", size: 0.16), stroke: 0.6pt)
  // Quota z_1
  line((1.20, -1.05), (3.62, -1.05), mark: (start: ">", end: ">", size: 0.16), stroke: 0.6pt)
  // Quota d
  line((3.80, -1.05), (4.51, -1.05), mark: (start: ">", end: ">", size: 0.14), stroke: 0.6pt)
  // 5. Etichette (tutte con text(size: 7pt))
  content((-2.10, 1.55), text(size: 7pt, fill: rgb(90, 95, 105))[$A$], anchor: "east")
  content((2.30, 3.52), text(size: 7pt)[$b_2 = b_1 + d$], anchor: "south")
  content((1.86, 2.52), text(size: 7pt)[$b_1$], anchor: "south")
  content((1.62, 0.82), text(size: 7pt, fill: rgb(45, 105, 155))[$d A$], anchor: "west")
  content((-0.28, -2.40), text(size: 7pt)[$P$], anchor: "east")
  content((2.41, -1.20), text(size: 7pt)[$z_1$], anchor: "north")
  content((4.15, -1.20), text(size: 7pt)[$d$], anchor: "north")
  content((3.72, -3.02), text(size: 7pt, fill: rgb(70, 75, 85))[$y_1$], anchor: "north")
  content((4.59, -3.02), text(size: 7pt, fill: rgb(70, 75, 85))[$y_2$], anchor: "north")
})
  ]
)
#v(1em)

Il momento statico di una sezione rispetto a una retta qualsiasi è sempre pari al prodotto dell'area della sezione per la distanza del suo baricentro dalla retta.


=== Momenti statici e baricentro di sezioni composte

Se una sezione complessa di area totale $A = sum_(i=1)^n A_i$ è scomponibile in $n$ figure elementari di area $A_i$ e baricentro noto $(z_(C i), y_(C i))$, per il teorema di trasposizione i momenti statici totali rispetto agli assi coordinati valgono:

$ S_z = sum_(i=1)^n A_i dot y_(C i) wide "e" wide S_y = sum_(i=1)^n A_i dot z_(C i) $

Le coordinate del baricentro della sezione composta rispetto a un qualunque sistema di riferimento $z y$ sono quindi:

$ z_C = S_y / A = (sum_(i=1)^n A_i dot z_(C i)) / (sum_(i=1)^n A_i) wide "e" wide y_C = S_z / A = (sum_(i=1)^n A_i dot y_(C i)) / (sum_(i=1)^n A_i) $

// [DA SLIDE]
#v(1em)
==== Esempio: Baricentro di una sezione a L

#grid(
  columns: (1.2fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    Vogliamo determinare le coordinate del baricentro della sezione a L mostrata in figura (quote in $#"mm"$), rispetto al sistema di riferimento $z y$ con origine nello spigolo inferiore destro.

    *Procedimento:*
    1. *Scomposizione in figure semplici:* dividiamo la sezione a L in due rettangoli elementari $A_1$ (ala inferiore orizzontale, $30 times 10 #"mm"$) e $A_2$ (tratto verticale superiore, $15 times 20 #"mm"$).
    2. *Baricentri locali:* sfruttando la doppia simmetria di ciascun rettangolo, troviamo subito le coordinate $(z_(C i), y_(C i))$ dei rispettivi baricentri:
       - Per $A_1$: $z_(C 1) = 30 / 2 = 15 #"mm"$, $y_(C 1) = 10 / 2 = 5 #"mm"$.
       - Per $A_2$: $z_(C 2) = 15 / 2 = 7,5 #"mm"$, $y_(C 2) = 10 + 20 / 2 = 20 #"mm"$.
    3. *Momenti statici e area totale:* i momenti statici della sezione a L sono la somma dei momenti statici delle due aree ($S_y = S_(y 1) + S_(y 2)$ e $S_z = S_(z 1) + S_(z 2)$).
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  // Riempimento e contorno della sezione a L
  line((0, 0), (-3, 0), (-3, 1), (-1.5, 1), (-1.5, 3), (0, 3), close: true, fill: rgb(195, 214, 238), stroke: 1.4pt)

  // Separazione interna tratteggiata tra A1 e A2
  line((-1.5, 1), (0, 1), stroke: (dash: "dashed", thickness: 1pt))

  // Assi cartesiani z e y
  line((0, 0), (-4.2, 0), mark: (end: ">"), stroke: 0.8pt)
  line((0, 0), (0, 4.2), mark: (end: ">"), stroke: 0.8pt)
  content((-4.2, -0.35), text(size: 7pt)[$z$])
  content((0.35, 4.1), text(size: 7pt)[$y$])

  // Etichette delle aree
  content((-1.5, 0.5), text(size: 7pt)[$A_1$])
  content((-0.75, 2.0), text(size: 7pt)[$A_2$])

  // Quote orizzontali superiori (15 e 15)
  line((-3, 3.1), (-3, 3.7), stroke: 0.5pt)
  line((-1.5, 3.1), (-1.5, 3.7), stroke: 0.5pt)
  line((-3, 3.5), (-1.5, 3.5), mark: (start: ">", end: ">"), stroke: 0.6pt)
  line((-1.5, 3.5), (0, 3.5), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((-2.25, 3.8), text(size: 7pt)[$15$])
  content((-0.75, 3.8), text(size: 7pt)[$15$])

  // Quota orizzontale inferiore (30)
  line((-3, -0.55), (0, -0.55), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((-1.5, -0.3), text(size: 7pt)[$30$])

  // Quote verticali a sinistra (10 e 20)
  line((-3.1, 1), (-3.6, 1), stroke: 0.5pt)
  line((-3.1, 3), (-3.6, 3), stroke: 0.5pt)
  line((-3.4, 0), (-3.4, 1), mark: (start: ">", end: ">"), stroke: 0.6pt)
  line((-3.4, 1), (-3.4, 3), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((-3.75, 0.5), text(size: 7pt)[$10$])
  content((-3.75, 2.0), text(size: 7pt)[$20$])
})
  ]
)

#v(0.5em)
#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto, auto),
    align: center + horizon,
    inset: 6pt,
    stroke: 0.5pt + luma(160),
    [], [*Area* $[#"mm"^2]$], [$z_(C i)$ $[#"mm"]$], [$S_(y i) = A_i z_(C i)$ $[#"mm"^3]$], [$y_(C i)$ $[#"mm"]$], [$S_(z i) = A_i y_(C i)$ $[#"mm"^3]$],
    [$A_1$], [$300$], [$15$], [$15 dot 300 = 4500$], [$5$], [$5 dot 300 = 1500$],
    [$A_2$], [$300$], [$7,5$], [$7,5 dot 300 = 2250$], [$20$], [$20 dot 300 = 6000$],
    [*Totale $A$*], [*$600$*], [$z_C = 11,25$], [*$S_y = 6750$*], [$y_C = 12,5$], [*$S_z = 7500$*],
  )
]

Le coordinate del baricentro complessivo $G$ della sezione a L risultano quindi:
$ z_C = S_y / A = 6750 / 600 = 11,25 #"mm" wide "e" wide y_C = S_z / A = 7500 / 600 = 12,5 #"mm" $
#v(1em)

=== Momento d'inerzia di area $[#"mm"^4]$

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ I_y = integral_A z^2 dif A $

    $ I_z = integral_A y^2 dif A $

    $ I > 0 $
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  // 1. Riempimento elemento infinitesimo dA
  rect((0.83, 0.26), (1.83, 0.86), fill: rgb(198, 217, 241), stroke: none)

  // Contorno di dA (lati verticali continui, orizzontali tratteggiati come nello schizzo)
  line((0.83, 0.26), (0.83, 0.86), stroke: 0.7pt)
  line((1.83, 0.26), (1.83, 0.86), stroke: 0.7pt)
  line((0.83, 0.86), (1.83, 0.86), stroke: (dash: "dashed", thickness: 0.7pt))
  line((0.83, 0.26), (1.83, 0.26), stroke: (dash: "dashed", thickness: 0.7pt))

  // 2. Contorno chiuso della superficie A (4 Bezier C1)
  bezier((-2.77, 0.29), (-0.31, 2.14), (-2.77, 1.55), (-1.60, 2.14), stroke: 1.4pt)
  bezier((-0.31, 2.14), (3.06, 0.14), (1.60, 2.14), (3.06, 1.25), stroke: 1.4pt)
  bezier((3.06, 0.14), (-1.00, -1.80), (3.06, -1.20), (1.10, -1.80), stroke: 1.4pt)
  bezier((-1.00, -1.80), (-2.77, 0.29), (-2.20, -1.80), (-2.77, -0.90), stroke: 1.4pt)

  // Asse di riferimento verticale destro tratteggiato
  line((4.46, -3.30), (4.46, 3.20), stroke: (dash: "dashed", thickness: 1.3pt))

  // Linea di riferimento verticale sotto dP per la quota z
  line((1.40, -0.90), (1.40, -2.60), stroke: 0.6pt)

  // Quota z
  line((1.50, -1.95), (4.34, -1.95), mark: (start: ">", end: ">", size: 0.18), stroke: 0.7pt)

  // 5. Etichette (tutte con text(size: 7pt))
  content((-2.50, 1.85), text(size: 12pt)[$A$], anchor: "east")
  content((1.92, 0.65), text(size: 12pt, fill: rgb(45, 105, 155))[$d A$], anchor: "west")
  content((1.33, -0.55), text(size: 12pt)[$d P$], anchor: "center")
  content((-0.30, -3.05), text(size: 12pt)[$P$], anchor: "east")
  content((2.92, -2.15), text(size: 10pt)[$z$], anchor: "north")
})
  ]
)
#v(1em)
Il momento d'inerzia di una sezione rispetto a un asse è dato dall'integrale d'area dei prodotti delle aree elementari $dif A$ per la loro distanza al quadrato dall'asse.

// [DA SLIDE]
Più in generale, il momento d'inerzia di una sezione piana (di area $A$) rispetto a una *retta $a$ in posizione qualsiasi* (ad esempio inclinata di un angolo $alpha$ rispetto all'asse $z$) si calcola come:
$ I_a = integral_A d^2 dif A $
dove $d$ rappresenta la distanza ortogonale dell'area elementare $dif A$ dalla retta $a$.

#nota[
  *Segno e dimensioni del momento d'inerzia:*
  - Poiché la distanza compare elevata al quadrato ($d^2 >= 0$) e le aree elementari sono positive ($dif A > 0$), i momenti d'inerzia di area sono *sempre strettamente positivi* ($I > 0$), *a differenza dei momenti statici*, indipendentemente dalla posizione della retta di riferimento rispetto alla sezione.
  - L'unità di misura ha dimensione fisica $[L^4]$ (nel SI $#"m"^4$ oppure, nella pratica tecnica, $#"mm"^4$).
]

#v(1em)
=== Momento d'inerzia centrifugo
$ I_(y z) = integral_A y z dif A wide (I_(y z) > 0, < 0) $

    - Rispetto agli assi baricentrici di simmetria, il momento d'inerzia centrifugo è sempre nullo.

// [DA SLIDE]
#grid(
  columns: (1.2fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    Il *momento d'inerzia centrifugo* (detto anche *momento misto*) di una sezione piana di area $A$ rispetto a una coppia di assi cartesiani $(z, y)$ è definito come l'integrale d'area del prodotto delle distanze coordinate $z$ e $y$ di ciascuna area elementare $dif A$ dagli assi di riferimento:
    $ I_(z y) = I_(y z) = integral_A z y dif A $
    - *Segno:* a differenza dei momenti d'inerzia assiali (sempre positivi perché dipendono dal quadrato della distanza), il momento d'inerzia centrifugo *può essere positivo, negativo oppure nullo*, poiché le coordinate $z$ e $y$ dell'elemento $dif A$ sono prese con il proprio segno a seconda del quadrante in cui cade l'elemento.
    - *Unità di misura:* ha dimensione fisica $[L^4]$ (nel SI $#"m"^4$, nella pratica tecnica $#"mm"^4$).
  ],
  [
    #canvas(length: 0.9cm, {
      import draw: *
      // Contorno chiuso della superficie A
      bezier((-2.5, 0.3), (-0.3, 1.9), (-2.5, 1.4), (-1.5, 1.9), stroke: 1.4pt)
      bezier((-0.3, 1.9), (2.4, 0.2), (1.3, 1.9), (2.4, 1.1), stroke: 1.4pt)
      bezier((2.4, 0.2), (-0.8, -1.5), (2.4, -0.9), (0.9, -1.5), stroke: 1.4pt)
      bezier((-0.8, -1.5), (-2.5, 0.3), (-1.9, -1.5), (-2.5, -0.7), stroke: 1.4pt)

      // Elemento dA
      rect((0.5, 0.3), (1.3, 0.8), fill: rgb(198, 217, 241), stroke: (dash: "dashed", thickness: 0.7pt))
      content((1.35, 0.65), text(size: 9pt, fill: rgb(45, 105, 155))[$dif A$], anchor: "west")
      content((-2.3, 1.6), text(size: 10pt)[$A$], anchor: "east")

      // Assi z (orizzontale inferiore) e y (verticale destro)
      line((3.2, -2.2), (3.2, 2.5), stroke: 1.1pt)
      line((-1.0, -2.2), (3.6, -2.2), stroke: 1.1pt)
      content((2.95, 2.3), text(size: 9pt)[$y$], anchor: "east")
      content((-0.8, -1.95), text(size: 9pt)[$z$], anchor: "south")

      // Quote z e y
      line((0.9, 0.55), (0.9, -2.2), stroke: 0.6pt)
      line((0.9, -1.9), (3.2, -1.9), mark: (start: ">", end: ">", size: 0.15), stroke: 0.6pt)
      content((2.05, -2.1), text(size: 9pt)[$z$], anchor: "north")

      line((0.9, 0.55), (3.2, 0.55), stroke: 0.6pt)
      line((2.8, -2.2), (2.8, 0.55), mark: (start: ">", end: ">", size: 0.15), stroke: 0.6pt)
      content((2.65, -0.8), text(size: 9pt)[$y$], anchor: "east")
    })
  ]
)

#nota[
  *Annullamento del momento centrifugo e simmetria:*
  1. Il momento centrifugo è sempre nullo rispetto agli *assi principali d'inerzia* (che sono assi baricentrici aventi una specifica orientazione, come dimostrato più avanti).
  2. Se la sezione possiede almeno *un asse di simmetria* (che è necessariamente baricentrico), a ogni elemento $dif A$ di coordinate $(z, y)$ ne corrisponde uno identico di coordinate $(-z, y)$ (oppure $(z, -y)$): i due contributi $z y dif A$ sono uguali e opposti e l'integrale su tutta l'area si annulla ($I_(y z) = 0$).
  3. Per una sezione *priva di simmetrie* (come la sezione a L studiata più avanti), il momento centrifugo calcolato rispetto a due assi baricentrici generici $(z_G, y_G)$ *non è nullo* ($I_(y z G) != 0$), ma diventa nullo solo ruotando gli assi baricentrici fino a sovrapporli alle direzioni principali d'inerzia $(zeta, eta)$.
]

#v(1em)

=== Momento d'inerzia polare

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ I_p &= integral_A r^2 dif A = integral_A (z^2 + y^2) dif A \
          &= integral_A z^2 dif A + integral_A y^2 dif A = I_y + I_z $
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  // 1. Riempimento e contorno dell'elemento infinitesimo (rettangolo azzurro)
  rect((-1.93, 0.90), (-0.90, 1.50), fill: rgb(198, 217, 241), stroke: none)
  line((-1.93, 0.90), (-1.93, 1.50), (-0.90, 1.50), (-0.90, 0.90), (-1.20, 0.90), stroke: 0.6pt)
  line((-1.93, 0.90), (-1.62, 0.90), stroke: 0.6pt)

  // 2. Contorno chiuso della superficie (4 Bezier C1)
  bezier((-3.40, 0.20), (-0.20, 2.17), (-3.40, 1.55), (-1.80, 2.17), stroke: 1.5pt)
  bezier((-0.20, 2.17), (2.73, 0.20), (1.45, 2.17), (2.73, 1.40), stroke: 1.5pt)
  bezier((2.73, 0.20), (0.10, -1.73), (2.73, -1.15), (1.50, -1.73), stroke: 1.5pt)
  bezier((0.10, -1.73), (-3.40, 0.20), (-1.85, -1.73), (-3.40, -1.05), stroke: 1.5pt)

  // 3. Assi y, z, a
  line((0, -0.40), (0, 3.55), mark: (end: ">", size: 0.22), stroke: 0.7pt)
  line((0.65, 0), (-4.80, 0), mark: (end: ">", size: 0.22), stroke: 0.7pt)
  line((0, 0), (-4.70, 1.90), mark: (end: ">", size: 0.22), stroke: 0.6pt)

  // 4. Segmenti r, d, punto P e arco alpha
  // Segmento r (da G a V)
  line((0, 0), (-1.42, 1.22), stroke: 0.6pt)

  // Segmento d (da V perpendicolare all'asse a in H)
  line((-1.42, 1.22), (-1.64, 0.66), stroke: 0.6pt)

  // Pallino nero per il punto P
  circle((-1.50, 1.26), radius: 0.08, fill: black, stroke: none)

  // Arco per l'angolo alpha (centro (0,0), raggio 2.38, da 158deg a 180deg)
  arc((0, 0), start: 158deg, stop: 180deg, radius: 2.38, anchor: "origin", mark: (start: ">", end: ">", size: 0.12), stroke: 0.5pt)

  // 5. Etichette (tutte con text(size: 7pt))
  content((0.28, 3.10), text(size: 7pt)[$y$], anchor: "west")
  content((-4.25, -0.22), text(size: 7pt)[$z$], anchor: "north")
  content((-3.95, 1.85), text(size: 7pt)[$a$], anchor: "south")
  content((-2.52, 0.55), text(size: 7pt)[$alpha$], anchor: "east")
  content((-1.32, 1.32), text(size: 7pt)[P], anchor: "south")
  content((-1.38, 0.82), text(size: 7pt, fill: rgb(70, 75, 85))[$d$], anchor: "west")
  content((-0.42, 0.75), text(size: 7pt)[$r$], anchor: "south-west")
  content((0.25, 0.45), text(size: 7pt)[$G$], anchor: "west")
})
  ]
)
// [DA SLIDE]
Il *momento d'inerzia polare* $I_p$ di una sezione di area $A$ è definito rispetto a un *polo* (cioè un *punto* nel piano della sezione, solitamente coincidente con l'origine degli assi o con il baricentro $G$) e *non* rispetto a un asse o a una retta. Esso misura come l'area della sezione è distribuita radialmente attorno al polo considerato.

Indicando con $r$ la distanza radiale dell'area elementare $dif A$ dal centro (origine) degli assi coordinati ortogonali $(z, y)$, per il *teorema di Pitagora* vale la relazione geometrica $r^2 = z^2 + y^2$. Sostituendo tale espressione nell'integrale e sfruttando la linearità dell'operatore di integrazione, si ottiene che *il momento d'inerzia polare rispetto all'origine di una coppia di assi ortogonali è sempre uguale alla somma dei due momenti d'inerzia assiali* calcolati rispetto a quegli stessi assi ($I_p = I_z + I_y$).
#v(1em)

=== Momenti d'inerzia notevoli

*Sezione rettangolare*

Assi non baricentrici (alla base):
$ ($I_z) = (b h^3)) / 3$) $
$ ($I_y = (h b^3)) / 3$) $

Assi baricentrici:
$ I_z = (b h^3) / 12 $
$ I_y = (h b^3) / 12 $

*Sezione circolare*

Piena:
$ I_z = I_y = (pi D^4) / 64 $
$ I_p = I_z + I_y = (pi D^4) / 32 $


#nota[
  *Impostazione degli integrali (rettangolo e cerchio pieno):*
  - *Rettangolo ($b times h$):* riducendo l'integrale doppio a strisce elementari $dif A = b dif y$ (oppure $dif A = h dif z$), rispetto agli assi alla base si ha:
    $ I_z = integral_0^h y^2 b dif y = (b h^3) / 3, wide I_y = integral_0^b z^2 h dif z = (h b^3) / 3 $
    Traslando l'origine nel baricentro ($z_C = b/2, y_C = h/2$), cambiano solo gli estremi di integrazione:
    $ I_(z 0) = integral_(-h/2)^(h/2) y^2 b dif y = (b h^3) / 12, wide I_(y 0) = integral_(-b/2)^(b/2) z^2 h dif z = (h b^3) / 12 $
  - *Cerchio pieno (raggio $R$, diametro $D$):* integrando su corone circolari elementari $dif A = 2 pi r dif r$ si ottiene il momento polare rispetto al centro:
    $ I_p = integral_0^R r^2 (2 pi r dif r) = (pi R^4) / 2 = (pi D^4) / 32 $
    Per assialsimmetria ($I_z = I_y = I_d$ e $I_p = 2 I_d$), il momento d'inerzia diametrale vale $I_d = I_p / 2 = (pi R^4) / 4 = (pi D^4) / 64$.
]

// [DA SLIDE]
#nota[
  *Dimostrazione dettagliata e schemi geometrici di integrazione:*
  Per calcolare un integrale doppio d'area $integral_A ("distanza")^2 dif A$ riducendolo a un integrale semplice, occorre scegliere come elemento infinitesimo $dif A$ una *sotto-area i cui punti si trovino tutti alla medesima distanza* dall'asse (o dal polo) di riferimento:

  1. *Sezione rettangolare ($b times h$) rispetto agli assi non baricentrici $(O, z, y)$:*
     - _Formula corretta per gli assi alla base:_ $I_z = (b h^3) / 3$ e $I_y = (h b^3) / 3$.
     - *Calcolo di $I_z$:* poiché nell'integrale $I_z = integral_A y^2 dif A$ la variabile è la distanza $y$ dall'asse $z$, scegliamo una *striscia elementare orizzontale* (parallela all'asse $z$) di base $b$ e spessore infinitesimo $dif y$, avente area $dif A = b dot dif y$. Su tutta questa striscia la coordinata $y$ è costante e varia da $0$ a $h$:
       $ I_z = integral_A y^2 dif A = integral_0^h y^2 (b dif y) = b [y^3 / 3]_0^h = (b h^3) / 3 $
     - *Calcolo di $I_y$:* analogamente, per $I_y = integral_A z^2 dif A$ scegliamo una *striscia elementare verticale* (parallela all'asse $y$) di altezza $h$ e larghezza $dif z$, di area $dif A = h dot dif z$, con $z$ variabile da $0$ a $b$:
       $ I_y = integral_A z^2 dif A = integral_0^b z^2 (h dif z) = h [z^3 / 3]_0^b = (h b^3) / 3 $

  2. *Sezione rettangolare ($b times h$) rispetto agli assi baricentrici $(G, z_0, y_0)$:*
     Per simmetria, il baricentro $G$ si trova al centro del rettangolo, di coordinate $z_G = b/2$ e $y_G = h/2$. Ponendo l'origine in $G$, la funzione integranda e le strisce elementari non cambiano, ma gli estremi di integrazione diventano simmetrici rispetto all'origine ($y in [-h/2, +h/2]$ e $z in [-b/2, +b/2]$):
     $ I_(z 0) = integral_(-h/2)^(h/2) y^2 b dif y = b [y^3 / 3]_(-h/2)^(h/2) = b / 3 (h^3 / 8 - (- h^3 / 8)) = (b h^3) / 12 $
     $ I_(y 0) = integral_(-b/2)^(b/2) z^2 h dif z = h [z^3 / 3]_(-b/2)^(b/2) = h / 3 (b^3 / 8 - (- b^3 / 8)) = (h b^3) / 12 $

  3. *Sezione circolare piena (raggio $R$, diametro $D = 2 R$):*
     Il calcolo diretto di $integral_A y^2 dif A$ in coordinate cartesiane sarebbe laborioso. È molto più semplice calcolare prima il *momento d'inerzia polare $I_p$* rispetto al centro $P$, suddividendo il cerchio in *corone circolari infinitesime* di raggio interno $r$ e raggio esterno $r + dif r$. Tutti i punti della corona distano $r$ dal polo $P$, e l'area della corona (pari alla circonferenza $2 pi r$ per lo spessore $dif r$) vale $dif A = 2 pi r dif r$:
     $ I_p = integral_A r^2 dif A = integral_0^R r^2 (2 pi r dif r) = 2 pi integral_0^R r^3 dif r = 2 pi [r^4 / 4]_0^R = (pi R^4) / 2 = (pi (D/2)^4) / 2 = (pi D^4) / 32 $
     Poiché il cerchio è assialsimmetrico rispetto a qualunque diametro, tutti gli assi baricentrici (diametrali) hanno lo stesso momento d'inerzia ($I_z = I_y = I_d$). Dalla relazione $I_p = I_z + I_y = 2 I_d$ si ricava immediatamente:
     $ I_d = I_z = I_y = I_p / 2 = (pi R^4) / 4 = (pi D^4) / 64 $

  #v(0.5em)
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    align: (center + horizon, center + horizon),
    [
      #canvas(length: 0.85cm, {
        import draw: *
        // Rettangolo base b, altezza h
        rect((-2.6, 0), (0, 3.4), stroke: 1.4pt)
        // Striscia orizzontale dy (rossa)
        rect((-2.6, 2.1), (0, 2.45), fill: rgb(235, 65, 55, 180), stroke: 0.6pt)
        // Striscia verticale dz (verde)
        rect((-0.95, 0), (-0.55, 3.4), fill: rgb(45, 165, 85, 180), stroke: 0.6pt)

        // Assi z e y centrati in O
        line((0.4, 0), (-3.6, 0), mark: (end: ">"), stroke: 0.8pt)
        line((0, -0.4), (0, 4.2), mark: (end: ">"), stroke: 0.8pt)
        content((-3.5, 0.25), text(size: 8pt)[$z$])
        content((0.3, 4.0), text(size: 8pt)[$y$])
        content((0.3, -0.3), text(size: 8pt)[$O$])

        // Baricentro G e assi baricentrici
        circle((-1.3, 1.7), radius: 0.06, fill: black)
        line((-1.3, 1.7), (-2.1, 1.7), mark: (end: ">", size: 0.14), stroke: 0.6pt)
        line((-1.3, 1.7), (-1.3, 2.5), mark: (end: ">", size: 0.14), stroke: 0.6pt)
        content((-1.45, 1.4), text(size: 8pt)[$G$])
        content((-2.1, 1.9), text(size: 7pt)[$z_0$])
        content((-1.05, 2.4), text(size: 7pt)[$y_0$])

        // Quote b, h, dy, dz
        line((-2.6, -0.5), (0, -0.5), mark: (start: ">", end: ">", size: 0.14), stroke: 0.6pt)
        content((-1.3, -0.75), text(size: 8pt)[$b$])
        line((0.6, 0), (0.6, 3.4), mark: (start: ">", end: ">", size: 0.14), stroke: 0.6pt)
        content((0.85, 1.7), text(size: 8pt)[$h$])
        content((-3.0, 2.27), text(size: 8pt, fill: rgb(180, 30, 30))[$dif y$])
        content((-0.75, 3.75), text(size: 8pt, fill: rgb(30, 130, 60))[$dif z$])
      })
    ],
    [
      #canvas(length: 0.85cm, {
        import draw: *
        // Cerchio esterno di raggio R
        circle((0, 0), radius: 2.0, stroke: 1.4pt)
        // Corona circolare elementare tra r e r + dr
        circle((0, 0), radius: 1.35, fill: rgb(198, 217, 241), stroke: 0.6pt)
        circle((0, 0), radius: 1.05, fill: white, stroke: 0.6pt)

        // Assi z e y centrati nel polo P
        line((2.5, 0), (-2.6, 0), mark: (end: ">"), stroke: 0.8pt)
        line((0, -2.4), (0, 2.6), mark: (end: ">"), stroke: 0.8pt)
        content((-2.5, -0.3), text(size: 8pt)[$z$])
        content((0.3, 2.45), text(size: 8pt)[$y$])
        content((0.25, -0.28), text(size: 8pt)[$P$])

        // Raggi r, r + dr e R
        line((0, 0), (-0.95, 0.45), mark: (end: ">", size: 0.13), stroke: 0.6pt)
        content((-0.35, 0.45), text(size: 8pt)[$r$])
        line((0, 0), (-2.1, 0.75), stroke: 0.5pt)
        content((-2.2, 1.05), text(size: 8pt)[$r + dif r$])
        line((-2.0, 0), (-2.0, -2.1), stroke: 0.5pt)
        line((-2.0, -1.9), (0, -1.9), mark: (start: ">", end: ">", size: 0.14), stroke: 0.6pt)
        content((-1.0, -1.65), text(size: 8pt)[$R$])
      })
    ]
  )
]

Cava:
$ I_z = I_y = pi / 64 (D^4 - d^4) $
$ I_p = I_z + I_y = pi / 32 (D^4 - d^4) $

=== Momenti d'inerzia: teorema di trasposizione (Huygens-Steiner)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    Noto il momento d'inerzia $I_1$ rispetto alla retta $r_1$, vogliamo calcolare il momento d'inerzia rispetto alla retta $r_2$. Sono note le distanze:
    - $d$ tra le rette parallele $r_1$ e $r_2$
    - $a_1$ e $a_2$ con $a_2 = a_1 + d$

    $ I_1 = integral_A a_1^2 dif A $
    $ I_2 = integral_A a_2^2 dif A = integral_A (a_1 + d)^2 dif A $
    $ I_2 &= integral_A (a_1^2 + d^2 + 2 a_1 d) dif A \
          &= integral_A a_1^2 dif A + d^2 integral_A dif A + 2 d integral_A a_1 dif A \
          &= I_1 + A d^2 + 2 S_1 d $
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  // 1. Riempimento e contorno dell'elemento infinitesimo dA
  rect((0.73, 0.31), (1.67, 0.85), fill: rgb(198, 217, 241), stroke: none)
  line((0.73, 0.31), (0.73, 0.85), stroke: 0.7pt)
  line((1.67, 0.31), (1.67, 0.85), stroke: 0.7pt)
  line((0.73, 0.85), (1.67, 0.85), stroke: (dash: "dashed", thickness: 0.7pt))
  line((0.73, 0.31), (1.67, 0.31), stroke: (dash: "dashed", thickness: 0.7pt))

  // 2. Contorno chiuso della superficie A (4 Bezier C1)
  bezier((-2.76, 0.18), (-0.45, 2.13), (-2.76, 1.48), (-1.65, 2.13), stroke: 1.6pt)
  bezier((-0.45, 2.13), (2.87, 0.18), (1.45, 2.13), (2.87, 1.30), stroke: 1.6pt)
  bezier((2.87, 0.18), (-0.95, -1.82), (2.87, -1.15), (1.05, -1.82), stroke: 1.6pt)
  bezier((-0.95, -1.82), (-2.76, 0.18), (-2.15, -1.82), (-2.76, -0.95), stroke: 1.6pt)

  // 3. Tre rette parallele inclinate (23.9 gradi)
  // Retta 1 (superiore)
  line((-4.63, -0.41), (3.23, 3.07), stroke: 0.7pt + rgb(70, 70, 75))
  // Retta 2 (intermedia)
  line((-4.21, -0.97), (3.23, 2.33), stroke: 0.7pt + rgb(70, 70, 75))
  // Retta 3 (inferiore, passa per dA)
  line((-1.46, -0.65), (1.74, 0.77), stroke: 0.7pt + rgb(70, 70, 75))

  // 4. Quote ortogonali alle rette (doppia freccia)
  // Quota d (tra Retta 2 e Retta 1)
  line((-3.71, -0.75), (-3.99, -0.13), mark: (start: ">", end: ">", size: 0.18), stroke: 0.5pt)

  // Quota a_2 (tra Retta 3 e Retta 1)
  line((-1.14, -0.51), (-1.75, 0.86), mark: (start: ">", end: ">", size: 0.18), stroke: 0.5pt)

  // Quota a_1 (tra Retta 3 e Retta 2)
  line((0.14, 0.06), (-0.19, 0.81), mark: (start: ">", end: ">", size: 0.18), stroke: 0.5pt)

  // 5. Etichette (tutte con text(size: 7pt))
  content((-2.55, 1.85), text(size: 7pt, fill: rgb(50, 50, 55))[$A$], anchor: "east")
  content((-4.05, -0.55), text(size: 7pt, fill: rgb(50, 50, 55))[$d$], anchor: "east")
  content((-0.15, 0.35), text(size: 7pt, fill: rgb(45, 60, 75))[$a_1$], anchor: "east")
  content((-1.30, -0.30), text(size: 7pt, fill: rgb(45, 60, 75))[$a_2 =$], anchor: "east")
  content((-0.75, -0.95), text(size: 7pt, fill: rgb(45, 60, 75))[$= a_1 + d$], anchor: "center")
  content((1.78, 0.80), text(size: 7pt, fill: rgb(45, 105, 155))[$d A$], anchor: "west")
})
  ]
)
#v(1em)

Se l'asse 1 è baricentrico, $S_1 = 0$:
- Momento di trasporto: $A d^2$
- Contributo del momento statico: $2 S_1 d = 0$


$ I_2 = I_1 + A d^2 $

Poiché il termine di trasporto $A d^2$ è sempre positivo, *il momento d'inerzia baricentrico è il minimo momento d'inerzia tra tutti quelli calcolati rispetto ad assi tra loro paralleli*.
// [DA SLIDE]
#nota[
  *Teorema di trasposizione per il momento d'inerzia centrifugo:*
  Un principio analogo vale per il trasporto del momento d'inerzia centrifugo tra una coppia di assi baricentrici $(z_0, y_0)$ (con origine nel baricentro locale $G_i$ di coordinate $(z_(C i), y_(C i))$) e una coppia di assi a essi paralleli $(z, y)$ (ad esempio gli assi baricentrici globali $(z_G, y_G)$ di una sezione composta, con origine in $G(z_C, y_C)$).
  Indicando con $Delta z_i = z_(C i) - z_C$ e $Delta y_i = y_(C i) - y_C$ le distanze con segno tra le origini dei due sistemi, il momento centrifugo trasportato vale:
  $ I_(y z) = I_(y_0 z_0) + A dot Delta z_i dot Delta y_i = I_(y_0 z_0) + A (z_(C i) - z_C)(y_(C i) - y_C) $
  In particolare, se i singoli elementi di una sezione composta sono rettangoli con i lati paralleli agli assi di riferimento, il loro momento centrifugo proprio rispetto agli assi baricentrici di simmetria è nullo ($I_(y_0 z_0) = 0$) e sopravvive *soltanto il termine di trasporto* $A (z_(C i) - z_C)(y_(C i) - y_C)$.
]
#v(1em)


=== Momenti e assi principali d'inerzia

Consideriamo una retta generica $a$ ruotata di un angolo $alpha$ rispetto all'asse $z$, e una retta a essa ortogonale $b$ (ruotata di $beta = alpha + pi/2$). La distanza di un'area elementare $dif A(z, y)$ dalla retta $a$ è $d = z sin alpha + y cos alpha$, mentre la distanza da $b$ è $z cos alpha - y sin alpha$.

Sviluppando gli integrali d'area, i momenti d'inerzia assiali e il momento centrifugo rispetto al sistema ruotato $(a, b)$ valgono:

$ I_a &= integral_A (z sin alpha + y cos alpha)^2 dif A = I_z cos^2 alpha + I_y sin^2 alpha + 2 I_(y z) sin alpha cos alpha \
  I_b &= I_z cos^2 beta + I_y sin^2 beta + 2 I_(y z) sin beta cos beta = I_z sin^2 alpha + I_y cos^2 alpha - 2 I_(y z) sin alpha cos alpha \
  I_(a b) &= integral_A (z cos alpha - y sin alpha)(z sin alpha + y cos alpha) dif A = I_(y z) cos 2 alpha - (I_z - I_y) / 2 sin 2 alpha $

*Direzioni principali d'inerzia:*
I valori di $alpha$ che rendono massimo o minimo il momento d'inerzia $I_a$ si ottengono annullando la derivata rispetto ad $alpha$:

$ (dif I_a) / (dif alpha) = -(I_z - I_y) sin 2 alpha + 2 I_(y z) cos 2 alpha = 0 arrow.r.double tan 2 alpha = (2 I_(y z)) / (I_z - I_y) $

Per la periodicità della tangente si ottengono due direzioni tra loro *ortogonali*, dette *assi principali d'inerzia* ($zeta, eta$):

$ alpha_1 = 1 / 2 arctan ((2 I_(y z)) / (I_z - I_y)) wide "e" wide alpha_2 = alpha_1 + pi / 2 $

Sostituendo $alpha_1$ e $alpha_2$ nell'espressione di $I_a$ si ottengono i *momenti principali d'inerzia* (massimo e minimo):

$ I_zeta = I_z cos^2 alpha_1 + I_y sin^2 alpha_1 + 2 I_(y z) sin alpha_1 cos alpha_1 \
  I_eta = I_z cos^2 alpha_2 + I_y sin^2 alpha_2 + 2 I_(y z) sin alpha_2 cos alpha_2 $

#nota[
  *Annullamento del momento centrifugo sugli assi principali:*
  Se $a$ e $b$ sono assi principali d'inerzia, vale $I_(y z) = tan 2 alpha dot (I_z - I_y) / 2$. Sostituendo tale relazione nell'espressione di $I_(a b)$ si ottiene:
  $ I_(a b) = tan 2 alpha (I_z - I_y) / 2 cos 2 alpha - (I_z - I_y) / 2 sin 2 alpha = (I_z - I_y) / 2 sin 2 alpha - (I_z - I_y) / 2 sin 2 alpha = 0 $
  Rispetto agli assi principali d'inerzia il momento d'inerzia centrifugo è sempre *nullo*.
]
// [DA SLIDE]
#v(0.5em)
==== Dimostrazione dei passaggi matematici e interpretazione geometrica

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    #canvas(length: 0.85cm, {
      import draw: *
      // Contorno chiuso della superficie A
      bezier((-3.0, 0.2), (-0.2, 2.0), (-3.0, 1.4), (-1.6, 2.0), stroke: 1.4pt)
      bezier((-0.2, 2.0), (2.5, 0.2), (1.3, 2.0), (2.5, 1.2), stroke: 1.4pt)
      bezier((2.5, 0.2), (0.1, -1.5), (2.5, -1.0), (1.3, -1.5), stroke: 1.4pt)
      bezier((0.1, -1.5), (-3.0, 0.2), (-1.6, -1.5), (-3.0, -0.9), stroke: 1.4pt)
      content((2.3, 1.8), text(size: 9pt)[$A$])

      // Assi originari z e y centrati in O
      line((0.5, 0), (-3.8, 0), mark: (end: ">"), stroke: 0.8pt)
      line((0, -0.4), (0, 2.8), mark: (end: ">"), stroke: 0.8pt)
      content((-3.7, 0.25), text(size: 8pt)[$z$])
      content((0.25, 2.65), text(size: 8pt)[$y$])
      content((0.25, -0.25), text(size: 8pt)[$O$])

      // Assi ruotati a e b (ruotati di alpha = 25 deg come in slide 18)
      line((0.5, 0.23), (-3.5, -1.63), mark: (end: ">"), stroke: 0.8pt + rgb(45, 105, 155))
      line((0.18, -0.4), (-1.2, 2.55), mark: (end: ">"), stroke: 0.8pt + rgb(45, 105, 155))
      content((-3.3, -1.85), text(size: 8pt, fill: rgb(45, 105, 155))[$a$])
      content((-1.45, 2.5), text(size: 8pt, fill: rgb(45, 105, 155))[$b$])

      // Elemento dA nel quadrante (z>0, y>0)
      rect((-1.6, 0.6), (-1.0, 1.0), fill: rgb(198, 217, 241), stroke: 0.6pt)
      content((-1.7, 0.85), text(size: 8pt, fill: rgb(45, 105, 155))[$dif A$], anchor: "east")

      // Proiezioni su z, y (tratteggiate) e su a, b (continue)
      line((-1.3, 0.8), (-1.3, 0), stroke: (dash: "dashed", thickness: 0.5pt))
      line((-1.3, 0.8), (0, 0.8), stroke: (dash: "dashed", thickness: 0.5pt))
      line((-1.3, 0.8), (-0.84, -0.39), stroke: 0.5pt + rgb(45, 105, 155))
      line((-1.3, 0.8), (-0.55, 1.15), stroke: 0.5pt + rgb(45, 105, 155))

      // Arco angolo alpha
      arc((0, 0), start: 180deg, stop: 205deg, radius: 1.7, anchor: "origin", stroke: 0.6pt)
      content((-1.95, -0.42), text(size: 8pt)[$alpha$])
    })
  ],
  [
    #canvas(length: 0.85cm, {
      import draw: *
      // Grafico di I_a in funzione di alpha (Slide 14)
      line((0, 0), (5.8, 0), mark: (end: ">"), stroke: 0.8pt)
      line((0, 0), (0, 3.6), mark: (end: ">"), stroke: 0.8pt)
      content((5.8, -0.35), text(size: 8pt)[$alpha$])
      content((-0.35, 3.4), text(size: 8pt)[$I_a$])

      // Linea media
      line((0, 1.7), (5.2, 1.7), stroke: 0.5pt + luma(120))

      // Curva sinusoidale di periodo pi: minimo in alpha_1 = 0.9, massimo in alpha_2 = 2.9
      bezier((0.1, 1.4), (0.9, 0.85), (0.3, 1.0), (0.6, 0.85), stroke: 1.2pt)
      bezier((0.9, 0.85), (1.9, 1.7), (1.3, 0.85), (1.6, 1.25), stroke: 1.2pt)
      bezier((1.9, 1.7), (2.9, 2.55), (2.2, 2.15), (2.5, 2.55), stroke: 1.2pt)
      bezier((2.9, 2.55), (3.9, 1.7), (3.3, 2.55), (3.6, 2.15), stroke: 1.2pt)
      bezier((3.9, 1.7), (4.6, 1.05), (4.2, 1.25), (4.4, 1.1), stroke: 1.2pt)

      // Tangenti orizzontali di minimo e massimo
      line((0.4, 0.85), (1.4, 0.85), stroke: 0.6pt)
      line((2.4, 2.55), (3.4, 2.55), stroke: 0.6pt)

      // Proiezioni verticali per alpha_1, pi/2, alpha_2, pi
      line((0.9, 0), (0.9, 0.85), stroke: 0.6pt)
      line((2.1, 0), (2.1, 1.98), stroke: 0.6pt)
      line((2.9, 0), (2.9, 2.55), stroke: 0.6pt)
      line((4.1, 0), (4.1, 1.4), stroke: 0.6pt)

      // Etichette
      content((0.15, -0.35), text(size: 8pt)[$0$])
      content((0.9, -0.35), text(size: 8pt)[$alpha_1$])
      content((2.0, -0.35), text(size: 8pt)[$pi / 2$])
      content((2.9, -0.35), text(size: 8pt)[$alpha_2$])
      content((4.1, -0.35), text(size: 8pt)[$pi$])

      content((0.65, 1.15), text(size: 8pt)[$I_(alpha_1)$])
      content((2.9, 2.85), text(size: 8pt)[$I_(alpha_2)$])
    })
  ]
)

1. *Sviluppo del momento d'inerzia assiale $I_a$:*
   Scomponendo le coordinate $(z, y)$ dell'elemento $dif A$ lungo la direzione ortogonale alla retta $a$ (ruotata di $alpha$ rispetto a $z$), la distanza di $dif A$ dalla retta $a$ risulta $d = b = z sin alpha + y cos alpha$. Elevando al quadrato e portando fuori dall'integrale i fattori trigonometrici (che dipendono solo da $alpha$ e non dalla posizione di $dif A$):
   $ I_a &= integral_A d^2 dif A = integral_A (z sin alpha + y cos alpha)^2 dif A \
         &= sin^2 alpha integral_A z^2 dif A + cos^2 alpha integral_A y^2 dif A + 2 sin alpha cos alpha integral_A z y dif A \
         &= I_y sin^2 alpha + I_z cos^2 alpha + 2 I_(y z) sin alpha cos alpha $

2. *Ricerca di massimo e minimo (derivazione rispetto ad $alpha$):*
   Per trovare le direzioni estreme poniamo a zero la derivata prima di $I_a (alpha)$ rispetto ad $alpha$, applicando la regola della catena e la regola del prodotto:
   $ (dif I_a) / (dif alpha) &= (dif) / (dif alpha) (I_y sin^2 alpha + I_z cos^2 alpha + 2 I_(y z) sin alpha cos alpha) \
     &= 2 I_y sin alpha cos alpha + 2 I_z cos alpha (-sin alpha) + 2 I_(y z) cos alpha cos alpha + 2 I_(y z) sin alpha (-sin alpha) = 0 $
   Raccogliendo i termini simili e ricordando le *formule trigonometriche di duplicazione* ($2 sin alpha cos alpha = sin 2 alpha$ e $cos^2 alpha - sin^2 alpha = cos 2 alpha$), l'equazione si semplifica in:
   $ I_y sin 2 alpha - I_z sin 2 alpha + 2 I_(y z) (cos^2 alpha - sin^2 alpha) = 0 \
     arrow.r.double -(I_z - I_y) sin 2 alpha + 2 I_(y z) cos 2 alpha = 0 $
   Dividendo ambo i membri per $cos 2 alpha$ si ottiene la condizione fondamentale per gli *assi principali d'inerzia*:
   $ tan 2 alpha = (2 I_(y z)) / (I_z - I_y) $
   *Perché gli assi principali sono ortogonali?* Poiché la funzione tangente è periodica di periodo $pi$, l'equazione $tan(2 alpha) = "costante"$ ammette due famiglie di soluzioni per l'argomento $2 alpha$ sfasate di $pi$:
   $ 2 alpha_2 = 2 alpha_1 + pi arrow.r.double alpha_2 = alpha_1 + pi / 2 $
   Di conseguenza, le due direzioni $alpha_1$ e $alpha_2$ rispetto a cui il momento d'inerzia assume il valore minimo e il valore massimo formano sempre tra loro un angolo retto ($90^circ$).

3. *Sviluppo dell'integrale per il momento centrifugo $I_(a b)$:*
   Considerando la coppia di rette ortogonali $(a, b)$ ruotate di $alpha$ rispetto a $(z, y)$, le coordinate di $dif A$ nel sistema ruotato sono $a = z cos alpha - y sin alpha$ e $b = z sin alpha + y cos alpha$. Sviluppando il prodotto all'interno dell'integrale del momento centrifugo $I_(a b) = integral_A a b dif A$:
   $ I_(a b) &= integral_A (z cos alpha - y sin alpha)(z sin alpha + y cos alpha) dif A \
             &= integral_A z^2 sin alpha cos alpha dif A + integral_A z y cos^2 alpha dif A - integral_A z y sin^2 alpha dif A - integral_A y^2 sin alpha cos alpha dif A \
             &= integral_A z y (cos^2 alpha - sin^2 alpha) dif A - integral_A y^2 (sin 2 alpha) / 2 dif A + integral_A z^2 (sin 2 alpha) / 2 dif A \
             &= cos 2 alpha integral_A z y dif A - (sin 2 alpha) / 2 integral_A (y^2 - z^2) dif A \
             &= I_(y z) cos 2 alpha - (I_z - I_y) / 2 sin 2 alpha $
   Quando $(a, b)$ coincidono con gli assi principali d'inerzia, vale $tan 2 alpha = 2 I_(y z) / (I_z - I_y)$, da cui $I_(y z) = tan 2 alpha dot (I_z - I_y) / 2$. Sostituendo tale espressione:
   $ I_(a b) = (sin 2 alpha) / (cos 2 alpha) (I_z - I_y) / 2 cos 2 alpha - (I_z - I_y) / 2 sin 2 alpha = (I_z - I_y) / 2 sin 2 alpha - (I_z - I_y) / 2 sin 2 alpha = 0 quad ("c.v.d.") $
#v(1em)


=== Circonferenza di Mohr per i momenti d'inerzia

#grid(
  columns: (1.1fr, 0.9fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    In un piano cartesiano con i momenti d'inerzia assiali $I_i$ in ascissa e i momenti centrifughi $I_(i j)$ in ordinata (orientata verso il basso), lo stato d'inerzia rispetto a una coppia di assi ortogonali $(a, b)$ è rappresentato dai due punti diametralmente opposti:
    $ P(I_a, -I_(a b)) wide "e" wide Q(I_b, I_(a b)) $
    Al variare dell'angolo di rotazione $alpha$, i punti $P$ e $Q$ descrivono una *circonferenza* (Cerchio di Mohr) avente centro sull'asse delle ascisse.
    - Le intersezioni della circonferenza con l'asse delle ascisse ($I_(i j) = 0$) individuano i *momenti principali d'inerzia* $I_"MAX" = I_zeta$ e $I_"min" = I_eta$.
    - La costruzione grafica a partire dai punti noti $(I_z, -I_(y z))$ e $(I_y, I_(y z))$ permette di determinare rapidamente $I_zeta, I_eta$ e l'angolo di rotazione $alpha$ degli assi principali $zeta, eta$.
  ],
  [
    #canvas(length: 1.1cm, {
      import draw: *
      // Assi
      line((0, 0), (6.5, 0), mark: (end: ">"), name: "x")
      content((6.5, -0.4), $I_i$)
      line((0.5, 2.8), (0.5, -2.8), mark: (end: ">"), name: "y")
      content((0.9, -2.7), $I_(i j)$)

      // Cerchio di Mohr (centro in (3.5, 0), raggio 2.1)
      let cx = 3.5
      let R = 2.1
      circle((cx, 0), radius: R, stroke: 1.2pt)
      circle((cx, 0), radius: 0.07, fill: black)

      // Punti P e Q (angolo 50 gradi)
      let px = cx + R * calc.cos(50deg)
      let py = R * calc.sin(50deg)
      let qx = cx - R * calc.cos(50deg)
      let qy = -R * calc.sin(50deg)

      // Linee tratteggiate di proiezione
      line((0.5, py), (px, py), stroke: (dash: "dashed", thickness: 0.6pt))
      line((px, 0), (px, py), stroke: (dash: "dashed", thickness: 0.6pt))
      line((0.5, qy), (qx, qy), stroke: (dash: "dashed", thickness: 0.6pt))
      line((qx, 0), (qx, qy), stroke: (dash: "dashed", thickness: 0.6pt))

      // Diametro PQ
      line((qx, qy), (px, py), stroke: 0.8pt)

      // Rette direzioni principali (passanti per P e per I_min / I_max)
      line((cx - R, 0), (px, py), stroke: (dash: "dotted", thickness: 0.8pt))
      line((cx + R, 0), (px, py), stroke: (dash: "dotted", thickness: 0.8pt))

      // Punti notevoli
      circle((px, py), radius: 0.1, fill: black)
      content((px + 0.35, py + 0.25), $P$)
      circle((qx, qy), radius: 0.1, fill: black)
      content((qx - 0.35, qy - 0.3), $Q$)
      circle((cx - R, 0), radius: 0.09, fill: black)
      circle((cx + R, 0), radius: 0.09, fill: black)

      // Etichette
      content((0.0, py), $-I_(y z)$)
      content((0.0, qy), $I_(y z)$)
      content((px, -0.35), $I_z$)
      content((qx + 0.25, -0.35), $I_y$)
      content((cx - R - 0.3, 0.35), $I_"min" (I_eta)$)
      content((cx + R + 0.9, 0.35), $I_"MAX" (I_zeta)$)
    })
  ]
)
// [DA SLIDE]
#nota[
  *Costruzione geometrica e lettura dell'angolo $alpha$ sul Cerchio di Mohr (Slide 21-22):*
  #grid(
    columns: (1.25fr, 0.95fr),
    column-gutter: 1em,
    align: (left + horizon, center + horizon),
    [
      1. *Centro e raggio della circonferenza:* sommando le espressioni di $I_a$ e $I_b$ (con $beta = alpha + pi/2$), si verifica che la somma dei momenti d'inerzia rispetto a due assi ortogonali è costante al variare di $alpha$ ($I_a + I_b = I_z + I_y = I_p$). Di conseguenza, il segmento $P Q$ ha punto medio fisso sull'asse delle ascisse nel *centro*:
         $ I_C = (I_z + I_y) / 2 $
         La distanza di $P(I_z, -I_(y z))$ dal centro $(I_C, 0)$ fornisce il *raggio* della circonferenza:
         $ R = sqrt(((I_z - I_y) / 2)^2 + I_(y z)^2) $
      2. *Momenti principali d'inerzia ($I_zeta, I_eta$):* le ascisse dei punti di intersezione con l'asse orizzontale ($I_(i j) = 0$) valgono:
         $ I_("MAX", "min") = I_(zeta, eta) = I_C plus.minus R = (I_z + I_y) / 2 plus.minus sqrt(((I_z - I_y) / 2)^2 + I_(y z)^2) $
      3. *Individuazione grafica di $alpha$ e degli assi $zeta, eta$:* come illustrato in figura, tracciando la retta tratteggiata che congiunge il punto $P(I_z, -I_(y z))$ con il punto di minimo $(I_eta, 0)$, si individua direttamente la direzione principale *$zeta$*, la quale risulta inclinata dell'angolo *$alpha$* rispetto all'asse delle ascisse (poiché l'angolo al centro è $2 alpha$, l'angolo alla circonferenza sotteso dallo stesso arco vale esattamente la metà, cioè $alpha$). La retta ortogonale passante per $P$ e per $(I_zeta, 0)$ individua invece la direzione principale *$eta$*.
    ],
    [
      #canvas(length: 0.95cm, {
        import draw: *
        // Assi I_i e I_ij
        line((0, 0), (6.4, 0), mark: (end: ">"), stroke: 0.8pt)
        content((6.3, -0.4), text(size: 8pt)[$I_i$])
        line((0.5, 2.7), (0.5, -2.7), mark: (end: ">"), stroke: 0.8pt)
        content((0.9, -2.6), text(size: 8pt)[$I_(i j)$])

        let cx = 3.4
        let R = 2.0
        circle((cx, 0), radius: R, stroke: 1.3pt)
        circle((cx, 0), radius: 0.07, fill: black)

        let px = cx + R * calc.cos(54deg)
        let py = R * calc.sin(54deg)
        let qx = cx - R * calc.cos(54deg)
        let qy = -R * calc.sin(54deg)

        // Proiezioni continue come in slide 22
        line((0.5, py), (px, py), stroke: 0.6pt)
        line((px, 0), (px, py), stroke: 0.6pt)
        line((0.5, qy), (qx, qy), stroke: 0.6pt)
        line((qx, 0), (qx, qy), stroke: 0.6pt)

        // Diametro PQ
        line((qx, qy), (px, py), stroke: 0.7pt)

        // Rette tratteggiate per le direzioni principali zeta e eta (Slide 22)
        // Retta zeta: passa per (cx - R, 0) e (px, py)
        line((cx - R - 1.1, -0.58), (px + 1.3, py + 0.68), stroke: (dash: "dotted", thickness: 0.8pt), mark: (end: ">"))
        content((px + 1.25, py + 0.35), text(size: 9pt)[$zeta$])

        // Retta eta: passa per (cx + R, 0) e (px, py)
        line((cx + R + 0.7, -1.35), (px - 0.75, py + 1.45), stroke: (dash: "dotted", thickness: 0.8pt), mark: (end: ">"))
        content((px - 0.5, py + 1.4), text(size: 9pt)[$eta$])

        // Arco per l'angolo alpha tra l'asse I_i e la retta zeta
        arc((cx - R, 0), start: 0deg, stop: 27deg, radius: 1.4, anchor: "origin", mark: (end: ">", size: 0.14), stroke: 0.6pt)
        content((cx - R + 1.65, 0.38), text(size: 9pt)[$alpha$])

        // Punti di intersezione I_eta e I_zeta
        circle((cx - R, 0), radius: 0.08, fill: black)
        circle((cx + R, 0), radius: 0.08, fill: black)

        // Etichette
        content((0.0, py), text(size: 8pt)[$-I_(y z)$])
        content((0.05, qy), text(size: 8pt)[$I_(y z)$])
        content((px, -0.35), text(size: 8pt)[$I_z$])
        content((qx + 0.25, -0.35), text(size: 8pt)[$I_y$])
        content((cx - R - 0.25, 0.38), text(size: 9pt)[$I_eta$])
        content((cx + R + 0.3, 0.38), text(size: 9pt)[$I_zeta$])
      })
    ]
  )
]
#v(1em)


=== Esempio svolto: Sezione composta a L

Si consideri una sezione a L (quote in $"mm"$) con sistema di riferimento $z y$ avente origine nell'angolo inferiore destro ($z$ verso sinistra, $y$ verso l'alto), scomposta in due rettangoli:
- *Rettangolo $A_1$ (ala orizzontale inferiore, $30 times 10$):* $A_1 = 300 #"mm"^2$, baricentro $z_(C 1) = 15 #"mm"$, $y_(C 1) = 5 #"mm"$.
- *Rettangolo $A_2$ (anima verticale superiore, $15 times 20$):* $A_2 = 300 #"mm"^2$, baricentro $z_(C 2) = 7,5 #"mm"$, $y_(C 2) = 20 #"mm"$.

*1. Area totale, momenti statici e baricentro:*
$ A = A_1 + A_2 = 600 #"mm"^2 $
$ S_y = A_1 z_(C 1) + A_2 z_(C 2) = 300 dot 15 + 300 dot 7,5 = 4500 + 2250 = 6750 #"mm"^3 $
$ S_z = A_1 y_(C 1) + A_2 y_(C 2) = 300 dot 5 + 300 dot 20 = 1500 + 6000 = 7500 #"mm"^3 $
$ z_C = S_y / A = 6750 / 600 = 11,25 #"mm", wide y_C = S_z / A = 7500 / 600 = 12,5 #"mm" $

*2. Momenti d'inerzia assiali e centrifugo baricentrici ($z_C, y_C$):*
Applicando il teorema di trasposizione (Huygens-Steiner) a ciascun rettangolo rispetto al baricentro globale $C$:
$ I_(z 1) &= 1/12 dot 30 dot 10^3 + (12,5 - 5)^2 dot 300 = 19375 #"mm"^4 \
  I_(z 2) &= 1/12 dot 15 dot 20^3 + (20 - 12,5)^2 dot 300 = 26875 #"mm"^4 \
   arrow.r.double I_(z C) &= I_(z 1) + I_(z 2) = 46250 #"mm"^4 $

$ I_(y 1) &= 1/12 dot 10 dot 30^3 + (15 - 11,25)^2 dot 300 = 26718,75 #"mm"^4 \
  I_(y 2) &= 1/12 dot 20 dot 15^3 + (11,25 - 7,5)^2 dot 300 = 9843,75 #"mm"^4 \
  arrow.r.double I_(y C) &= I_(y 1) + I_(y 2) = 36562,5 #"mm"^4 $

Poiché i momenti centrifughi propri dei singoli rettangoli rispetto ai loro assi di simmetria sono nulli, resta il solo termine di trasporto:
$ I_(1 y z) &= 0 + (15 - 11,25) dot (5 - 12,5) dot 300 = -8437,5 #"mm"^4 \
  I_(2 y z) &= 0 + (7,5 - 11,25) dot (20 - 12,5) dot 300 = -8437,5 #"mm"^4 \
  arrow.r.double I_(y z C) &= I_(1 y z) + I_(2 y z) = -16875 #"mm"^4 $

*3. Orientazione degli assi principali d'inerzia:*
$ alpha_1 = 1 / 2 arctan ((2 I_(y z C)) / (I_(z C) - I_(y C))) = 1 / 2 arctan ((2 dot (-16875)) / (46250 - 36562,5)) = -36,99^circ $
Il sistema principale d'inerzia $(zeta, eta)$ è quindi ruotato di $36,99^circ$ in senso orario ($alpha_1 < 0$) rispetto al sistema baricentrico $(z_C, y_C)$.

// [DA SLIDE]
#v(0.5em)
#grid(
  columns: (1.2fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    *4. Calcolo dei momenti principali d'inerzia ($I_zeta, I_eta$):*
    Individuati gli angoli principali $alpha_1 = -36,99^circ$ e $alpha_2 = alpha_1 + 90^circ = 53,01^circ$, i momenti principali d'inerzia rispetto agli assi $zeta$ e $eta$ si ottengono sostituendo tali angoli nella formula di rotazione:
    $ I_zeta &= I_(z C) cos^2 alpha_1 + I_(y C) sin^2 alpha_1 + 2 I_(y z C) sin alpha_1 cos alpha_1 \
             &approx 58958,1 #"mm"^4 quad (I_"MAX") $
    $ I_eta  &= I_(z C) cos^2 alpha_2 + I_(y C) sin^2 alpha_2 + 2 I_(y z C) sin alpha_2 cos alpha_2 \
             &approx 23854,4 #"mm"^4 quad (I_"min") $

    
    
  ],
  [
    #canvas(length: 0.95cm, {
      import draw: *
      // Sezione a L (origine dello schizzo nello spigolo inferiore destro (0,0))
      line((0, 0), (-3, 0), (-3, 1), (-1.5, 1), (-1.5, 3), (0, 3), close: true, fill: rgb(195, 214, 238), stroke: 1.4pt)
      line((-1.5, 1), (0, 1), stroke: (dash: "dashed", thickness: 1pt))

      // Baricentri locali (+)
      content((-1.5, 0.5), text(size: 8pt)[$+$])
      content((-2.1, 0.5), text(size: 8pt)[$A_1$])
      content((-0.75, 2.0), text(size: 8pt)[$+$])
      content((-0.75, 2.45), text(size: 8pt)[$A_2$])

      // Baricentro globale G in (-1.125, 1.25)
      let gx = -1.125
      let gy = 1.25
      circle((gx, gy), radius: 0.14, fill: white, stroke: 0.8pt)
      arc((gx, gy), start: 90deg, stop: 180deg, radius: 0.14, mode: "PIE", fill: black)
      arc((gx, gy), start: 270deg, stop: 360deg, radius: 0.14, mode: "PIE", fill: black)

      // Assi baricentrici z_G e y_G
      line((gx, gy), (-3.8, gy), mark: (end: ">"), stroke: 0.8pt)
      line((gx, gy), (gx, 3.6), mark: (end: ">"), stroke: 0.8pt)
      content((-3.7, gy + 0.3), text(size: 8pt)[$z_G$])
      content((gx + 0.35, 3.45), text(size: 8pt)[$y_G$])

      // Assi principali d'inerzia zeta e eta (ruotati di 36.99 deg in senso orario rispetto a z_G, y_G)
      line((gx + 0.6, gy - 0.45), (gx - 2.6, gy + 1.96), mark: (end: ">"), stroke: 1.3pt + rgb(210, 30, 30))
      line((gx - 0.55, gy - 0.73), (gx + 1.85, gy + 2.45), mark: (end: ">"), stroke: 1.3pt + rgb(210, 30, 30))
      content((gx - 2.35, gy + 2.15), text(size: 9pt, fill: rgb(210, 30, 30))[$zeta$])
      content((gx + 2.05, gy + 2.25), text(size: 9pt, fill: rgb(210, 30, 30))[$eta$])

      // Arco per alpha_1 tra z_G e zeta
      arc((gx, gy), start: 180deg, stop: 143deg, radius: 1.1, anchor: "origin", mark: (end: ">", size: 0.14), stroke: 1.1pt + rgb(210, 30, 30))
      content((gx - 1.35, gy + 0.42), text(size: 8pt, fill: rgb(210, 30, 30))[$alpha_1$])

      // Quote baricentro 11,25 e 12,5
      line((gx, 0), (gx, -0.95), stroke: 0.5pt)
      line((0, 0), (0, -0.95), stroke: 0.5pt)
      line((gx, -0.8), (0, -0.8), mark: (start: ">", end: ">", size: 0.12), stroke: 0.6pt)
      content((gx / 2, -0.58), text(size: 7pt)[$11,25$])

      line((-3.5, 0), (-3.5, gy), mark: (start: ">", end: ">", size: 0.12), stroke: 0.6pt)
      content((-3.95, gy / 2), text(size: 7pt)[$12,5$])
    })
  ]
)
Osservazione sui segni nel trasporto di $I_(y z C)$:
      Nel calcolo di $I_(1 y z)$ e $I_(2 y z)$, gli spostamenti tra i baricentri locali $G_i (z_(C i), y_(C i))$ e il baricentro globale $G(11,25; 12,5)$ hanno segni discordi:
      - Per $A_1$: $Delta z_1 = 15 - 11,25 = +3,75 #"mm"$ e $Delta y_1 = 5 - 12,5 = -7,5 #"mm"$ (oppure nelle slide $-12,5 + 5$), per cui il prodotto $(+3,75)(-7,5) dot 300 = -8437,5 #"mm"^4$ è negativo.
      - Per $A_2$: $Delta z_2 = 7,5 - 11,25 = -3,75 #"mm"$ e $Delta y_2 = 20 - 12,5 = +7,5 #"mm"$, per cui anche $(-3,75)(+7,5) dot 300 = -8437,5 #"mm"^4$ è negativo.
#pagebreak()
#include "RISPOSTA_GEMINI.typ"
#include "27-50_appunti.typ"
#include "07_RELAZIONI di EQUIVALENZA CdS-COMPONENTI di TENSIONE_appunti.typ"
#include "08_SOLLECITAZIONI SEMPLICI - SFORZO NORMALE e FLESSIONE_appunti.typ"
#include "06-4_SOLLECITAZIONI SEMPLICI - TORSIONE e TAGLIO_appunti.typ"
#include "09-1_LINEA ELASTICA_appunti.typ"
/*
== Ipotesi di De Saint-Venant

- Continuità
- Perfetta elasticità
- Omogeneità
- Isotropia

+ Sezionando un corpo:
  - Forze esterne generalizzate
  - Forze interne generalizzate
+ Il sistema di forze esterne provoca condizioni di sollecitazione; ma la condizione di equilibrio impone che il corpo sia in equilibrio in ogni sua sezione trasversale. Le forze interne devono mantenere in equilibrio la sezione stessa.
+ Calcolo delle tensioni normali e tangenziali.
+ Per descrivere lo stato di sollecitazione in un punto serve definire grandezze puntuali:
  $ ($arrow(t) = lim(dif A -> 0) (dif bold(F)) / (dif A)$) $
+ $arrow(t) = arrow(t)(bold(n), P)$
+ Solido di De Saint-Venant:
  - Materiale elastico, lineare, omogeneo, isotropo
  - Geometria cilindrica o prismatica
  - Ciascuna sezione normale all'asse del cilindro
  - Solido libero e in equilibrio sotto l'azione del sistema di forze esterne applicate
  - Forze di volume nulle e forze di superficie applicate solo sulle basi
+ Considerando l'asse del solido di De Saint-Venant allineato all'asse $x$:
  - $sigma_(y y) = sigma_(z z) = tau_(y z) = 0$

Le caratteristiche della sollecitazione risultano:
$ N_x = integral_A sigma_(x x) dif A $
$ M_z = - integral_A sigma_(x x) y dif A $
$ M_y = integral_A sigma_(x x) z dif A $
$ T_z = integral_A tau_(x z) dif A $
$ T_y = integral_A tau_(x y) dif A $
$ M_x = integral_A (- tau_(x y) z + tau_(x z) y) dif A $

== Sollecitazioni semplici: sforzo normale e flessione

*Metodo semi-inverso di De Saint-Venant:*
- Si definisce l'espressione del campo di spostamento
- Si deriva il campo di spostamento e si ottiene il campo di deformazione
- Si applica la legge costitutiva del materiale e si ottiene il campo di tensione
- Si applica la relazione tra la componente di tensione e la caratteristica di sollecitazione (CdS) che la genera
- Si ottiene l'espressione della componente di tensione in funzione della CdS che la genera

=== Sforzo normale

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    + $u(x) = k x$
    + $epsilon_(x x) = (dif u) / (dif x) = k$
  ],
  [
    #image("image 12.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    + Ipotizzando materiale elastico, lineare, omogeneo, isotropo:
      $ sigma_(x x) = E epsilon_(x x) $
      $ epsilon_(x x) = k ==> sigma_(x x) = "cost." $
      $ N_x eq.not 0, quad M_y = M_z = M_x = T_y = T_z = 0 $

    + $N_x = integral_A sigma_(x x) dif A = integral_A k E dif A = k E A$

    + $sigma_(x x) = N_x / A$

    + $integral_A - sigma_(x x) y dif A = M_z = 0 ==> sigma_(x x) eq.not 0 ==> S_z = 0$\
      $integral_A sigma_(x x) z dif A = M_y = 0 ==> sigma_(x x) eq.not 0 ==> S_y = 0$\
      Cioè gli assi sono riferiti agli assi baricentrici $==>$ lo sforzo normale è applicato nel baricentro della sezione trasversale.
  ],
  [
    #image("image 13.jpg", width: 70%)
  ]
)
#v(1em)

=== Flessione retta

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    + Il momento flettente $M_f$ agisce nel piano di sollecitazione $pi$, che contiene:
      - Asse $x$
      - Asse di sollecitazione $y$
    + L'asse geometrico si dispone su una linea elastica approssimabile con un arco di circonferenza:
      - La linea elastica giace nel piano di inflessione che, per simmetria della sezione, coincide con il piano di sollecitazione.
      - Parte convessa: le fibre si allungano.
      - Parte concava: le fibre si accorciano.
    + Nei punti dell'asse neutro $z$, la componente di tensione generata dalla flessione è nulla.
  ],
  [
    #image("image 14.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    + Spostamento assiale: $u = - alpha_z y$
    + Deformazione: $epsilon_(x x) = (dif u) / (dif x) = - (dif alpha_z) / (dif x) y = - kappa_z y$
    + Legge di Hooke:
      $ sigma_(x x) = E epsilon_(x x) = - E kappa_z y $
      $ M_z eq.not 0, quad N_x = M_y = M_x = T_y = T_z = 0 $
    + Relazione con il momento flettente:
      $ M_z &= - integral_A sigma_(x x) y dif A = integral_A E kappa_z y^2 dif A \
            &= E kappa_z integral_A y^2 dif A = E kappa_z I_z $
    + Sostituendo $kappa_z = M_z / (E I_z)$ in $sigma_(x x) = - E kappa_z y$:
      $ sigma_(x x) = - (M_z / I_z) y $
  ],
  [
    #image("image 15.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    + Poiché $N_x = integral_A sigma_(x x) dif A = 0$ e $sigma_(x x) eq.not 0 ==> S_z = 0$, ne consegue che l'asse neutro $z$ è un asse baricentrico.
  ],
  [
    #image("image 16.jpg", width: 70%)
  ]
)
#v(1em)

=== Momento flettente: tensione massima e modulo di resistenza

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ sigma_max = abs((M_z y_max) / I_z) = abs(M_z / W_z) $

    $ W_z = I_z / abs(y_max) $
  ],
  [
    #image("image 17.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Sezione rettangolare*

    $ I_z = (b h^3) / 12, quad y_max = h / 2 $

    $ ($W_z = (b h^2) / 6$) quad sigma_max = (6 M_z) / (b h^2) $
  ],
  [
    #image("image 18.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Sezione circolare piena*

    $ I_z = (pi D^4) / 64, quad y_max = D / 2 $

    $ W_z = (pi D^3) / 32, quad sigma_max = (32 M_z) / (pi D^3) $
  ],
  [
    #image("image 19.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Sezione circolare cava*

    $ I_z = (pi (D^4 - d^4)) / 64, quad y_max = D / 2 $

    $ W_z = (pi (D^4 - d^4)) / (32 D), quad sigma_max = (32 D M_z) / (pi (D^4 - d^4)) $
  ],
  [
    #image("image 20.jpg", width: 70%)
  ]
)
#v(1em)



$ underline(sigma_(x x) = - M_z / I_z y + M_y / I_y dot z) $

- L'asse neutro non coincide più con l'asse coordinato $z$.
- La sua posizione si determina imponendo $sigma_(x x) = 0$:

$ 0 = - M_z / I_z y + M_y / I_y dot z $

$ tan beta = z / y = M_z / M_y dot I_y / I_z $

$beta :=$ inclinazione dell'asse neutro rispetto all'asse $y$.

- $M = sqrt(M_z^2 + M_y^2)$
- $tan theta.alt = z / y = M_z / M_y$

$theta.alt :=$ inclinazione del momento flettente totale rispetto all'asse $y$.

$
  arrow.r "Se" I_z = I_y quad & tan beta = tan theta.alt = M_z / M_y quad && dot quad & "Asse neutro e asse di sollecitazione:" \
  & && & "sono" perp "tra loro" \
  & && & "sono assi principali d'inerzia" quad ==> quad bold("Flessione retta")
$

$
  arrow.r "Se" I_z eq.not I_y quad & tan beta eq.not tan theta.alt quad && dot quad & "Asse neutro e asse di sollecitazione:" \
  & && & "non sono" perp "tra loro" \
  & && & "non sono assi principali d'inerzia" quad ==> quad bold("Flessione deviata")
$

== Dimostrazione flessione deviata

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    #image("image 20.jpg", width: 70%)
  ],
  [
    #image("image 21.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ - P sin theta dot l = M_z $
  ],
  [
    #image("image 22.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    1) L'asse neutro è dove:
    $ - M_z / I_z y + M_y / I_y z = 0 $
    $ ==> z - M_z / M_y dot I_y / I_z y = 0 $

    2) Inclinazione dell'asse neutro:
    $ tan beta = z / y = M_z / M_y dot I_y / I_z $
  ],
  [
    #image("image 23.jpg", width: 70%)
  ]
)
#v(1em)

== Sollecitazioni semplici - Torsione e taglio

=== Torsione in travi a sezione circolare

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    - Vale l'ipotesi di conservazione delle sezioni piane:
      - ogni sezione trasversale ruota rigidamente nel suo piano;
      - sulla generica sezione trasversale è presente solo $tau$.
  ],
  [
    #image("image 24.jpg", width: 70%)
  ]
)
#v(1em)

3) $tau$ è legata con proporzionalità diretta allo scorrimento $gamma$ (legge di Hooke):

$ tau = G gamma = G r theta.alt / l $

$ G = E / (2 (1 + nu)) $

Modulo di elasticità tangenziale per materiali omogenei e isotropi.

4) In tutti i punti della sezione trasversale agisce $dif F_i = tau_i dif A_i$;

5) Equilibrio alla rotazione:

$ M_t = sum_(i=1)^infinity tau_i dif A_i r_i = integral_A tau r dif A = integral_A G gamma r dif A = integral_A G r theta.alt / l r dif A = G theta.alt / l integral_A r^2 dif A = G theta.alt / l I_p $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    6) Relazioni fondamentali:
    - Momento torcente:
      $ M_t = G I_p / l theta.alt $
    - Angolo di rotazione torsionale:
      $ theta.alt = (M_t l) / (G I_p) $
    - Rigidezza torsionale:
      $ (G I_p) / l $
  ],
  [
    #image("image 25.jpg", width: 70%)
  ]
)
#v(1em)

=== Torsione in travi a sezione rettangolare

1) L'ipotesi di conservazione delle sezioni piane non è valida:
- Le travi si ingobbano e la distribuzione della tensione tangenziale di torsione si studia tramite l'analogia idrodinamica.

2) Recipiente con fondo orizzontale, con contorno rettangolare come la sezione della trave, con dentro un liquido in rotazione:
- Tra velocità del liquido in un punto e tensione tangenziale di torsione nel punto corrispondente c'è proporzionalità diretta.
- L'andamento della distribuzione della $tau$ di torsione corrisponde alle linee di flusso della velocità del liquido nel recipiente.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    3) Distribuzione delle tensioni:
    - La velocità del fluido è massima nel punto di mezzo dei lati lunghi del recipiente. Analogamente $tau$:
    $ tau_max = tau_A = M_t / (a b^2 / alpha) = alpha M_t / (a b^2) $
  ],
  [
    #image("image 26.jpg", width: 70%)
  ]
)
#v(1em)

4) Fattore di rigidezza torsionale:

$ I_t = (a b^3) / beta $

=== Torsione in travi a sezione aperta sottile

1) I flussi delle $tau$ di torsione non si chiudono sulla sezione, ma percorrono i lati di ogni tratto rettangolare che costituisce la sezione.

2) Partendo dal presupposto che gli angoli unitari di torsione devono essere uguali all'angolo di torsione dell'intera sezione, in ogni tratto:

$ tau_(max, i) = M_t / I_t b_i $

- Per $a_i >> b_i ==> alpha = beta = 3$:

$ I_t = sum_(i=1)^n 1 / 3 a_i b_i^3 $

=== Torsione in travi a sezione chiusa sottile

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    1) Piccolo spessore $=>$ si può assumere la tensione tangenziale costante e pari al valore medio della tensione tangenziale in corrispondenza della linea mediana tra bordo interno e bordo esterno della parete: $tau = tau_m$.

    2) Consideriamo un tratto di sezione trasversale di lunghezza infinitesima, su cui agisce la forza infinitesima $dif F = tau dif A = tau s dif ell$.

    3) $dif Omega = 1 / 2 delta dif ell quad ==> quad dif M_t = dif F dot delta = tau s dif ell dot delta = 2 tau s dif Omega$
  ],
  [
    #image("image 27.jpg", width: 70%)
  ]
)
#v(1em)

4) Formula di Bredt e angolo unitario di torsione:

$ tau = tau_m = M_t / (2 Omega s) $

$ theta.alt_u = M_t / (4 G Omega^2) integral.cont 1 / s dif ell $

=== Taglio nelle travi

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ T(x) = (dif M(x)) / (dif x) $
  ],
  [
    #image("image 28.jpg", width: 70%)
    #image("image 29.jpg", width: 70%)
  ]
)
#v(1em)

- Si è in condizioni di taglio puro solo quando il momento flettente $M(x)$ è nullo o passa per lo $0$.
- Affinché ci sia taglio puro, la direzione di $T$ deve passare per il centro di taglio (CT), non sempre coincidente col baricentro della sezione.
- Come per la torsione, le tensioni tangenziali $tau$ causate dallo sforzo di taglio si dispongono lungo linee di flusso secondo un'analogia idrodinamica.
- Lo sforzo di taglio produce tensioni tangenziali parallele ($parallel$) e altre non parallele allo sforzo di taglio.

$ tau_m = T_y / A $

- Le $tau$ dovute al taglio hanno distribuzione non uniforme e valor medio $tau_m$.
- Il comportamento sotto l'azione del taglio si studia separatamente nei piani $x y$ e $y z$.

=== Taglio

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Studio dell'equilibrio di un elemento di trave soggetto a taglio e flessione.
  ],
  [
    #image("image 30.jpg", width: 70%)
  ]
)
#v(1em)

=== Taglio $T_y$

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Il flusso della tensione tangenziale $tau_(x y)$ attraverso la corda $b$:
    $ t_(x y) = integral_b tau_(x y) dif z $
    Per la proprietà di reciprocità delle tensioni tangenziali ($tau_(x y) = tau_(y x)$):
    $ t_(y x) = integral_b tau_(y x) dif z quad ==> quad t_(x y) = t_(y x) $
  ],
  [
    #image("image 31.jpg", width: 70%)
  ]
)
#v(1em)

Equilibrio lungo $x$ dell'elemento di trave di lunghezza $dif x$ compreso tra le 2 porzioni $A^*$ delle sezioni trasversali:

$ integral_(A^*) sigma_(x x) dif A quad arrow.l dif x arrow.r quad integral_(A^*) (sigma_(x x) + (dif sigma_(x x)) / (dif x) dif x) dif A $

$ t_(x y) dif x + integral_(A^*) sigma_(x x) dif A - integral_(A^*) (sigma_(x x) + (dif sigma_(x x)) / (dif x) dif x) dif A = 0 $

$ t_(x y) = integral_(A^*) (dif sigma_(x x)) / (dif x) dif A $

Sostituendo $sigma_(x x) = M_z / I_z y$ e ricordando che $T_y = (dif M_z) / (dif x)$, si ha:

$ t_(x y) = integral_(A^*) dif / (dif x) (M_z / I_z y) dif A = integral_(A^*) (dif M_z) / (dif x) y / I_z dif A = integral_(A^*) T_y / I_z y dif A = T_y / I_z S_z^(A^*) $

Sostituendo $t_(x y) = integral_b tau_(x y) dif z$:

$ integral_b tau_(x y) dif z = T_y / I_z S_z^(A^*) ==> overline(tau)_(x y) dot b = T_y / I_z S_z^(A^*) ==> overline(tau)_(x y) = (T_y S_z^(A^*)) / (I_z dot b) $

=== Taglio $T_z$

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ overline(tau)_(x z) = (T_z dot S_y^(A^*)) / (I_y dot b) $
  ],
  [
    #image("image 32.jpg", width: 70%)
  ]
)
#v(1em)

NB:
- Superficie della trave:
  - tensioni tangenziali di taglio: nulle
  - tensioni di trazione, torsione, flessione: massime
- Centro della trave (asse neutro):
  - tensioni tangenziali di taglio: massime
  - tensioni diflessione e torsione: nulle

==== Valore puntuale della $tau$ parallela al taglio

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ tau_(x y) (y) = (T_y dot S_z (y)) / (I_z dot b(y)) $
  ],
  [
    #image("image 33.jpg", width: 70%)
  ]
)
#v(1em)

- $tau_(x y) (y) =$ tensione tangenziale di taglio, per una data coordinata $y$.
- $S_z (y) =$ momento statico della porzione di sezione limitata dalla coordinata $y$, rispetto all'asse baricentrico $z$ dell'intera sezione.
- $I_z =$ momento d'inerzia dell'area dell'intera sezione (rispetto all'asse $z$).
- $b(y) =$ lunghezza della corda della sezione ortogonale a $T_y$ alla quota $y$.

*Sezione spessa:* le $tau$ non parallele ($not parallel$) allo sforzo di taglio sono trascurabili rispetto alle $tau$ parallele ($parallel$) al taglio.

*Sezione sottile:* le $tau$ non parallele ($not parallel$) allo sforzo di taglio non sono trascurabili rispetto alle $tau$ parallele ($parallel$) al taglio e vanno quindi calcolate.

#set page(paper: "a4", margin: 2cm)
#set text(lang: "it", size: 11pt)
#set par(justify: true)
#set math.equation(numbering: "(1)")
#set heading(numbering: none)

== Linea elastica

=== Ipotesi:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    - Sistema lineare elastico
    - Piccoli spostamenti

    1) _Ipotesi di piccoli spostamenti_
    - Raggio di curvatura:
      $ rect(rho = (dif s) / (dif theta.alt)) $
    - Curvatura:
      $ rect(1 / rho = (dif theta.alt) / (dif s)) $
    $ dif s = (dif x) / (cos theta.alt) approx dif x $
    $ (dif v) / (dif x) = tan theta.alt approx theta.alt $
    $ 1 / rho = (dif theta.alt) / (dif s) approx (dif theta.alt) / (dif x) = (dif^2 v) / (dif x^2) $
  ],
  [
    #image("image 34.jpg", width: 70%)
  ]
)
#v(1em)

2) Dallo studio della trave inflessa:

$ k_z = 1 / rho = (M_z (x)) / (E I_z) $

Sostituendo:

$ (dif theta.alt) / (dif x) = (M_z (x)) / (E I_z) $

$ (dif^2 v) / (dif x^2) = (M_z (x)) / (E I_z) $

3) Integrando la $1^a$ volta:

$ theta.alt (x) = (dif v(x)) / (dif x) = integral_0^x (M_z (x)) / (E I_z) dif x + C_1 $

Integrando la $2^a$ volta:

$ v(x) = integral_0^x theta.alt (x) dif x + C_2 = integral.double_0^x (M_z (x)) / (E I_z) dif x^2 + C_1 x + C_2 $

- Nel caso di caratteristica di sollecitazione (CdS) $M_z (x)$ discontinua, il calcolo della rotazione flessionale $theta.alt (x)$ e della freccia $v(x)$ dovrà essere svolto in ciascuno dei tratti della trave.

== Meccanica del continuo - Stato di tensione

1) Dato un corpo continuo, il vettore tensione in un generico punto $P$ che giace sulla superficie $Delta A$ di normale $\{n\}$ è:

$ arrow(t) = lim_(Delta A arrow.r 0) (Delta arrow(F)) / (Delta A) = (dif arrow(F)) / (dif A) $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    2) $\{t\}$ ha 3 componenti:
    - 1 tensione normale $sigma$
    - 2 tensioni tangenziali $tau$
    - $\{t\}$ è funzione sia dell'orientazione della superficie sia di $P$: $arrow(t) = arrow(t)(arrow(n), P)$
    - Quindi le componenti di tensione variano al variare dell'orientazione della superficie.
  ],
  [
    #image("image 35.jpg", width: 70%)
  ]
)
#v(1em)

3) Consideriamo un tetraedro elementare che contiene il punto $P$, ottenuto sezionando il cubetto elementare col piano $\{n\}$:
- L'equazione di equilibrio si scrive:
  $ arrow(t) dif A + arrow(t)_(-x) dif A_x + arrow(t)_(-y) dif A_y + arrow(t)_(-z) dif A_z + arrow(F)_V dif V = arrow(0) $
- Consente di trovare il legame tra vettore tensione $\{t\}$ e normale $\{n\}$ tramite la definizione di una matrice detta tensore delle tensioni nel punto $P$.

4) Esplicitando le componenti dei vettori (con il termine di volume $arrow(F)_V dif V$ trascurabile) si ottiene:

$
  arrow(t) dif A - arrow(t)_x dif A_x - arrow(t)_y dif A_y - arrow(t)_z dif A_z + cancel(arrow(F)_V dif V) = arrow(0) \
  mat(delim: "{", t_x; t_y; t_z) dif A - mat(delim: "{", sigma_(x x); tau_(x y); tau_(x z)) dif A n_x - mat(delim: "{", tau_(y x); sigma_(y y); tau_(y z)) dif A n_y - mat(delim: "{", tau_(z x); tau_(z y); sigma_(z z)) dif A n_z = arrow(0)
$

5) Semplificando $dif A$ si ricavano le componenti del vettore tensione e le componenti dello stato di tensione nel punto $P$ del corpo:

$
  cases(
    t_x = sigma_(x x) n_x + tau_(y x) n_y + tau_(z x) n_z,
    t_y = tau_(x y) n_x + sigma_(y y) n_y + tau_(z y) n_z,
    t_z = tau_(x z) n_x + tau_(y z) n_y + sigma_(z z) n_z
  )
$

6) Riordinando in forma matriciale:

$
  mat(delim: "{", t_x; t_y; t_z) = mat(delim: "[", sigma_(x x), tau_(y x), tau_(z x); tau_(x y), sigma_(y y), tau_(z y); tau_(x z), tau_(y z), sigma_(z z)) mat(delim: "{", n_x; n_y; n_z) quad ==> quad rect(\{t\} = [sigma] \{n\})
$

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    7) $[sigma] = \{sigma_(x x), sigma_(y y), sigma_(z z), tau_(x y), tau_(x z), tau_(y z)\}$ poiché $tau_(i j) = tau_(j i)$, cioè le componenti indipendenti sono soltanto 6.

    8) Imponendo l'equilibrio alla rotazione del cubetto elementare centrato sull'asse $x$ si ottiene $tau_(y z) = tau_(z y)$.
    - Analogamente imponendo l'equilibrio alla rotazione rispetto agli altri 2 assi si ottiene $tau_(x y) = tau_(y x)$ e $tau_(x z) = tau_(z x)$.

    9) Quindi, per conoscere lo stato di tensione del punto $P$ nello spazio $x y z$ è sufficiente conoscere $3 sigma$ e $3 tau$.
  ],
  [
    #image("image 36.jpg", width: 70%)
  ]
)
#v(1em)

== Tensioni e direzioni principali

- Esiste una particolare orientazione della faccia del tetraedro di Cauchy, i cui assi coordinati sono detti direzioni principali, per cui le componenti di tensione tangenziale sono nulle ($tau_(i j) = 0$).
- Nel sistema di riferimento principale $p_1, p_2, p_3$, il vettore tensione su ogni faccia è parallelo ($parallel$) alla normale $\{n\}$ alla superficie, le sue componenti di tensione sono proporzionali alle componenti di $\{n\}$ e il tensore delle tensioni è diagonale.
- Le uniche tensioni non nulle sono le tensioni normali sulla diagonale principale.

1) Le tensioni principali (autovalori) si ricavano valutando le 3 radici del polinomio caratteristico oppure calcolando gli invarianti e risolvendo l'equazione:

$
  det [[sigma] - sigma_p [I]] = 0 & wide & I_1 = op("tr")[sigma] \
  det mat(delim: "[", sigma_(x x) - sigma_p, tau_(y x), tau_(z x); tau_(x y), sigma_(y y) - sigma_p, tau_(z y); tau_(x z), tau_(y z), sigma_(z z) - sigma_p) = 0 & wide & I_2 = op("tr")[op(" cof")[sigma]] \
  & wide & I_3 = det [sigma]
$

$ sigma_p^3 - I_1 sigma_p^2 + I_2 sigma_p - I_3 = 0 $

2) Le direzioni principali si trovano risolvendo per ogni $sigma_p$ ($sigma_i$):

$
  mat(delim: "[", sigma_(x x) - sigma_i, tau_(y x), tau_(z x); tau_(x y), sigma_(y y) - sigma_i, tau_(z y); tau_(x z), tau_(y z), sigma_(z z) - sigma_i) mat(delim: "{", p_x; p_y; p_z) = mat(delim: "{", 0; 0; 0)
$

=== Sostituendo i valori numerici

$
  mat(delim: "[", a, b, c; d, e, f; g, h, i) mat(delim: "{", p_x; p_y; p_z) = mat(delim: "{", 0; 0; 0) quad cases(a p_x + b p_y + c p_z = 0, d p_x + e p_y + f p_z = 0, g p_x + h p_y + i p_z = 0, p_x^2 + p_y^2 + p_z^2 = 1) quad \{p_i\} = mat(delim: "{", dots.v; dots.v; dots.v)
$

Poi:
1) Angolo nel piano $x y$: $theta.alt = arctan(p_y / p_x)$
2) Inclinazione rispetto a $z$: $alpha = arctan(sqrt(p_x^2 + p_y^2) / p_z)$
3) Disegno direzioni e tensioni principali:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
      "es." quad +45 degree & quad sigma_1 > 0 \
      -45 degree & quad sigma_3 < 0
    $
    NB:
    - Trazione: verso l'esterno
    - Compressione: verso l'interno
  ],
  [
    #image("image 37.jpg", width: 70%)
    #image("image 38.jpg", width: 70%)
  ]
)
#v(1em)

== Tensore sferico e deviatorico

- Il tensore delle tensioni $[sigma]$ può essere pensato come somma di 2 tensori: $[sigma] = [sigma_s] + [sigma_d]$
- La tensione media vale: $sigma_m = I_1 / 3 = (sigma_(x x) + sigma_(y y) + sigma_(z z)) / 3$

$
  [sigma_s]_(x y z) = mat(delim: "[", sigma_m, 0, 0; 0, sigma_m, 0; 0, 0, sigma_m) wide [sigma_s]_(1 2 3) = mat(delim: "[", sigma_m, 0, 0; 0, sigma_m, 0; 0, 0, sigma_m)
$

$
  [sigma_d]_(x y z) = mat(delim: "[", sigma_(x x) - sigma_m, tau_(y x), tau_(z x); tau_(x y), sigma_(y y) - sigma_m, tau_(z y); tau_(x z), tau_(y z), sigma_(z z) - sigma_m) wide [sigma_d]_(1 2 3) = mat(delim: "[", sigma_1 - sigma_m, 0, 0; 0, sigma_2 - sigma_m, 0; 0, 0, sigma_3 - sigma_m)
$

$ I_2 := 2 degree "invariante del tensore iniziale" $

$ I'_2 := 2 degree "invariante del tensore deviatorico" $

$ I'_2 = I_2 - 3 sigma_m^2 = - ((sigma_1 - sigma_2)^2 + (sigma_1 - sigma_3)^2 + (sigma_2 - sigma_3)^2) / 6 $

$ tau_("ott") = sqrt(- 2 / 3 I'_2) = sqrt(2 / 3 ((sigma_1 - sigma_2)^2 + (sigma_1 - sigma_3)^2 + (sigma_2 - sigma_3)^2) / 6) $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    1) I piani ottaedrici sono piani le cui normali hanno coseni direttori uguali rispetto alle direzioni principali.

    2) Rispetto alla terna di riferimento principale $p_1 p_2 p_3$ la normale che identifica un piano ottaedrico è:
    $ \{n\} = mat(delim: "{", 1 / sqrt(3); 1 / sqrt(3); 1 / sqrt(3)) $
  ],
  [
    #image("image 39.jpg", width: 70%)
  ]
)
#v(1em)

3) Su un piano ottaedrico, la componente normale $sigma_("ott")$ (tensione ottaedrica o idrostatica) vale:

$
  sigma_("ott") &= \{n\}^T \{t\} = \{n\}^T [sigma] \{n\} = mat(delim: "{", 1 / sqrt(3), 1 / sqrt(3), 1 / sqrt(3)) mat(delim: "[", sigma_1, 0, 0; 0, sigma_2, 0; 0, 0, sigma_3) mat(delim: "{", 1 / sqrt(3); 1 / sqrt(3); 1 / sqrt(3)) = \
  &= (sigma_1 + sigma_2 + sigma_3) / 3 = sigma_m = I_1 / 3 quad arrow.r "proporzionale al" 1 degree "invariante del tensore sferico"
$

$arrow.r$ La tensione normale ottaedrica è la componente di tensione che cambia il volume del componente, ma non ne cambia la forma (non lo distorce).

4) La tensione tangenziale ottaedrica $tau_("ott")$ vale:

$
  tau_("ott") &= sqrt(t^2 - sigma_("ott")^2) = sqrt(\{t\}^T \{t\} - sigma_("ott")^2) = sqrt(\{n\}^T [sigma]^T [sigma] \{n\} - sigma_("ott")^2) = \
  &= sqrt((sigma_1^2 + sigma_2^2 + sigma_3^2) / 3 - (sigma_1 + sigma_2 + sigma_3)^2 / 3^2) = sqrt((2 ((sigma_1 - sigma_2)^2 + (sigma_2 - sigma_3)^2 + (sigma_1 - sigma_3)^2)) / 18) = \
  &= sqrt(2 / 3 ((sigma_1 - sigma_2)^2 + (sigma_1 - sigma_3)^2 + (sigma_2 - sigma_3)^2) / 6) = sqrt(- 2 / 3 I'_2) quad arrow.r "proporzionale al" 2 degree "invariante del tensore deviatorico" [sigma_d]
$

$arrow.r$ La $tau_("ott")$ è la componente di tensione che cambia la forma del componente (è quindi legata all'energia di distorsione).

$arrow.r$ Si può anche scrivere come:

$ tau_("ott") = 1 / 3 sqrt((sigma_1 - sigma_2)^2 + (sigma_1 - sigma_3)^2 + (sigma_2 - sigma_3)^2) = sqrt(t^2 - sigma_("ott")^2) quad ("nel criterio di Von Mises") $

== Costruzione inversa dei cerchi di Mohr

=== Devi sapere:
- Una direzione principale
- La tensione principale corrispondente alla direzione principale nota
- Le componenti di tensione su 2 facce del cubetto elementare, tra loro ortogonali ($perp$) e appartenenti al fascio di piani incardinato sulla direzione principale nota.

=== Caso $z$ direzione principale nota
- $sigma_(z z)$ è la corrispondente tensione principale nota $sigma_(p 1)$
- Sono note le tensioni $sigma$ e $tau$ su 2 facce tra loro $perp$ e appartenenti al fascio di piani incardinato su $z$, cioè siano note $sigma_(x x)$, $sigma_(y y)$ e $tau_(x y)$:

$
  [sigma] = mat(delim: "[", sigma_(x x), tau_(y x), 0; tau_(x y), sigma_(y y), 0; 0, 0, sigma_(z z))
$

$z$ è direzione principale perché su questa faccia non ci sono $tau$.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ abs(tan (2 alpha)) = abs((2 tau_(x y)) / (sigma_(x x) - sigma_(y y))) $
    $ C = (sigma_(x x) + sigma_(y y)) / 2 $
    $ r = sqrt(((sigma_(x x) - sigma_(y y)) / 2)^2 + tau_(x y)^2) $
    $
      sigma_a = C + r \
      sigma_b = C - r
    $
  ],
  [
    #image("image 40.jpg", width: 70%)
    #image("image 41.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Trazione pura*
    $ sigma_1 eq.not 0, quad sigma_2 = sigma_3 = 0 $
  ],
  [
    #image("image 42.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Torsione pura*
    $ sigma_1 = - sigma_3 = tau_(x y), quad sigma_2 = 0 $
  ],
  [
    #image("image 43.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Flesso-torsione / sforzo normale*
    $ [sigma] = mat(delim: "[", sigma, 0, tau; 0, 0, 0; tau, 0, 0) $
    $ sigma_1 = sigma_C + r = sigma / 2 + sqrt((sigma / 2)^2 + tau^2) $
    $ sigma_2 = sigma_(y y) = 0 $
    $ sigma_3 = sigma_C - r = sigma / 2 - sqrt((sigma / 2)^2 + tau^2) $
  ],
  [
    #image("image 44.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Tensione piana*
    $ [sigma] = mat(delim: "[", sigma_(x x), tau_(y x), 0; tau_(x y), sigma_(y y), 0; 0, 0, 0) $
  ],
  [
    #image("image 45.jpg", width: 70%)
  ]
)
#v(1em)

#set page(paper: "a4", margin: 2cm)
#set text(lang: "it", size: 11pt)
#set par(justify: true)
#set math.equation(numbering: "(1)")
#set heading(numbering: none)

== Meccanica del continuo - Stato di deformazione

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    1) Sotto l'azione dei carichi applicati i sistemi cambiano la propria forma.
    - Nella configurazione indeformata il punto $P$ è definito dal vettore delle sue coordinate $\{X\}^T = \{X, Y, Z\}$.
    - Nella configurazione deformata il punto $P'$ è definito come $\{x\}^T = \{x, y, z\}$.
  ],
  [
    #image("image 46.jpg", width: 70%)
  ]
)
#v(1em)

3) Spostamento del generico punto (grandezza vettoriale):

$ \{U\}^T = arrow(U) = \{u, v, w\} = \{x - X, y - Y, z - Z\} $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    4) Moto di un corpo:
    - Moto rigido:
      - traslazione rigida
      - rotazione rigida
    - Moto di deformazione:
      - dilatazione
      - scorrimento
    - Ipotesi di piccoli spostamenti
  ],
  [
    #image("image 47.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    5) Dilatazione:
    $ u = ell' - ell $
    $ epsilon = (dif ell' - dif ell) / (dif ell) = (dif u) / (dif ell) $
    - $dif ell :=$ lunghezza prima
    - $dif ell' :=$ lunghezza dopo

    Si usano grandezze infinitesime per evitare che il suo valore dipenda dalla lunghezza del segmento considerato.
  ],
  [
    #image("image 48.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    6) Scorrimento:
    $
      rect(O P arrow.r O P' \ O Q arrow.r O Q') quad rect(alpha approx v / ell) quad rect(beta approx u / h)
    $
    $
      rect(gamma = alpha + beta = v / ell + u / h) quad rect(gamma = (dif v) / (dif ell) + (dif u) / (dif h))
    $
  ],
  [
    #image("image 49.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    7) Tensore delle deformazioni:
    - Nel sistema di riferimento cartesiano si consideri un segmento vettore infinitesimo $dif arrow(X)$ che dopo spostamento si trasforma nel vettore $dif arrow(x)$:
      - Coda di $dif arrow(X)$: si sposta di $arrow(U)$
      - Punta di $dif arrow(X)$: si sposta di $arrow(U) + dif arrow(U)$
    - $arrow(U) + dif arrow(X) + dif arrow(U) = arrow(U) + dif arrow(x) ==> dif arrow(x) = dif arrow(X) + dif arrow(U)$
  ],
  [
    #image("image 50.jpg", width: 70%)
  ]
)
#v(1em)

8) Matrice Jacobiana:
- Scrivendo lo spostamento infinitesimo $dif arrow(U)$ come differenziale del campo di spostamenti, compare la matrice Jacobiana:

$
  dif arrow(U) = \{dif U\} = mat(delim: "{", dif u; dif v; dif w) = mat(delim: "[", (partial u) / (partial x), (partial u) / (partial y), (partial u) / (partial z); (partial v) / (partial x), (partial v) / (partial y), (partial v) / (partial z); (partial w) / (partial x), (partial w) / (partial y), (partial w) / (partial z)) mat(delim: "{", dif X; dif Y; dif Z) = [J] \{dif X\}
$

9) Riscrivendo $[J]$:

$ [J] = (1 / 2 [J] - 1 / 2 [J]^T) + (1 / 2 [J] + 1 / 2 [J]^T) = [Omega] + [epsilon] $

- $[Omega]$: contributi di rotazione rigida (antisimmetrico)
- $[epsilon]$: contributi di dilatazione e scorrimento (simmetrico)

10) Tensore delle deformazioni:

Dilatazioni:

$ rect(epsilon_(x x) = (partial u) / (partial x)) wide rect(epsilon_(y y) = (partial v) / (partial y)) wide rect(epsilon_(z z) = (partial w) / (partial z)) $

Scorrimenti:

$ rect(gamma_(x y) = (partial u) / (partial y) + (partial v) / (partial x)) wide rect(gamma_(y z) = (partial v) / (partial z) + (partial w) / (partial y)) wide rect(gamma_(x z) = (partial u) / (partial z) + (partial w) / (partial x)) $

$
  [epsilon] = mat(delim: "[", epsilon_(x x), 1 / 2 gamma_(x y), 1 / 2 gamma_(x z); 1 / 2 gamma_(x y), epsilon_(y y), 1 / 2 gamma_(y z); 1 / 2 gamma_(x z), 1 / 2 gamma_(y z), epsilon_(z z))
$

11) Deformazioni principali e direzioni principali di deformazione:

$
  det mat(delim: "[", epsilon_(x x) - epsilon_p, 1 / 2 gamma_(y x), 1 / 2 gamma_(z x); 1 / 2 gamma_(x y), epsilon_(y y) - epsilon_p, 1 / 2 gamma_(z y); 1 / 2 gamma_(x z), 1 / 2 gamma_(y z), epsilon_(z z) - epsilon_p) = 0
$

$ epsilon_p^3 - I_1 epsilon_p^2 + I_2 epsilon_p - I_3 = 0 $

== Relazione tra stato di tensione e stato di deformazione

- In campo lineare elastico esiste proporzionalità diretta tra dilatazione assiale e tensione assiale. Per un materiale lineare elastico isotropo si ha (Legge di Hooke generalizzata):

$
  epsilon_(x x) &= 1 / E sigma_(x x) - nu / E sigma_(y y) - nu / E sigma_(z z) \
  epsilon_(y y) &= 1 / E sigma_(y y) - nu / E sigma_(x x) - nu / E sigma_(z z) \
  epsilon_(z z) &= 1 / E sigma_(z z) - nu / E sigma_(x x) - nu / E sigma_(y y)
$

$
  gamma_(x y) &= 1 / G tau_(x y) \
  gamma_(x z) &= 1 / G tau_(x z) \
  gamma_(y z) &= 1 / G tau_(y z)
$

1) In un generico stato di tensione e deformazione, nel riferimento cartesiano, la legge costitutiva del materiale può essere riscritta in forma matriciale:

$ rect(\{epsilon\} = [D] \{sigma\}) quad "con" [D] "tensore di cedevolezza (deformabilità)" $

$ rect(\{sigma\} = [E] \{epsilon\}) quad "con" [E] "tensore di rigidezza (elasticità)" $

2) Per materiali isotropi, il numero di coefficienti indipendenti di $[D]$ si riduce a 2:
- $E :=$ modulo di elasticità normale (di Young)
- $nu :=$ coefficiente di contrazione trasversale di Poisson

$
  [D] = 1 / E mat(delim: "[",
    1, -nu, -nu, 0, 0, 0;
    -nu, 1, -nu, 0, 0, 0;
    -nu, -nu, 1, 0, 0, 0;
    0, 0, 0, 2(1 + nu), 0, 0;
    0, 0, 0, 0, 2(1 + nu), 0;
    0, 0, 0, 0, 0, 2(1 + nu)
  )
$

3) In forma compatta:

$ rect(epsilon_(i i) = 1 / E sigma_(i i) - nu / E sigma_(j j) - nu / E sigma_(k k)) $

$ rect(gamma_(i j) = 1 / G tau_(i j) = (2 (1 + nu)) / E tau_(i j)) $

4) Deformazione termica:
- $arrow.r$ Solo deformazione per dilatazione ($epsilon_("th") = alpha Delta T$)
- $arrow.r$ Nessuna deformazione per scorrimento ($gamma_("th") = 0$)

Stato di deformazione totale: $\{epsilon\} = \{epsilon\}_("mec") + \{epsilon\}_("th")$

*Stato di tensione piana:*
- $arrow.r$ Tutte le $sigma$ e le $tau$ stanno nello stesso piano ($x y$)
- $arrow.r$ Tutto il resto è zero:

$
  sigma_(x x) eq.not 0 & wide sigma_(z z) = 0 \
  sigma_(y y) eq.not 0 & wide tau_(x z) = 0 \
  tau_(x y) eq.not 0 & wide tau_(y z) = 0
$

*Stato di deformazione piana:*
- $arrow.r$ Gli scorrimenti fuori da un certo piano sono nulli
- $arrow.r$ La dilatazione fuori da quel piano è nulla o costante:

$
  epsilon_(x x) eq.not 0 & wide epsilon_(z z) = "cost" = 0 \
  epsilon_(y y) eq.not 0 & wide gamma_(x z) = 0 \
  gamma_(x y) eq.not 0 & wide gamma_(y z) = 0
$

== Criteri di cedimento statico

=== Rankine (Massima tensione normale)
- $sigma_max arrow.r$ Materiali fragili
- Cedimento dominato da meccanismi di crescita della cricca:

$ sigma_max = sigma_1 = R_m $

$ sigma_("id") = sigma_1 lt.eq R_m $

Caso di flesso-trazione-torsione:

$ rect(sigma_("id") = sigma / 2 + sqrt((sigma / 2)^2 + tau^2)) $

=== Tresca (Massima tensione tangenziale)
- $tau_max arrow.r$ Materiali duttili

$ tau_max = abs(sigma_1 - sigma_3) / 2 = R_(p 0,2) / 2 $

$ sigma_("id") = abs(sigma_1 - sigma_3) lt.eq R_(p 0,2) $

Caso di flesso-trazione-torsione:

$ rect(sigma_("id") = sqrt(sigma^2 + 4 tau^2)) $

=== Von Mises (Energia di distorsione)
- $tau_("ott") arrow.r$ Materiali duttili

$ sigma_("id") = 1 / sqrt(2) sqrt((sigma_1 - sigma_2)^2 + (sigma_2 - sigma_3)^2 + (sigma_1 - sigma_3)^2) lt.eq R_(p 0,2) $

Caso di flesso-trazione-torsione:

$ rect(sigma_("id") = sqrt(sigma^2 + 3 tau^2)) $

== Coefficiente di sicurezza

- *A resistenza statica:*
  $ sigma_("id") lt.eq sigma_lim / ("CS") quad ==> quad rect("CS" = sigma_lim / sigma_("id")) $

- *A rigidezza:*
  $ v lt.eq v_lim = ell / 200 div ell / 300 quad ==> quad rect("CS" = v_lim / v) $

- *A instabilità elastica:*
  $ P lt.eq P_("cr") / ("CS") quad ==> quad rect("CS" = P_("cr") / P) $

== Instabilità elastica

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    1) L'asta di Eulero può assumere una configurazione stabile in presenza di disturbi laterali:
    - Può raggiungere, per un carico assiale definito, una configurazione di equilibrio instabile anche per piccole perturbazioni.
    - La condizione critica di instabilità può avvenire al di sotto dei limiti di snervamento o di rottura del materiale $arrow.r$ si parla di problema dell'instabilità per carico di punta.
  ],
  [
    #image("image 51.jpg", width: 70%)
  ]
)
#v(1em)

2) Matematicamente, il problema si studia considerando una trave semplicemente appoggiata, sollecitata da una forza assiale di compressione $P$, per cui possa esistere una configurazione inflessa di equilibrio:

$ (dif^2 y) / (dif x^2) = (M(x)) / (E I_z) = - (P y(x)) / (E I_z) $

3) Ponendo $alpha^2 = P / (E I_z)$ si riscrive:

$ (dif^2 y(x)) / (dif x^2) + alpha^2 y(x) = 0 $

La soluzione è del tipo $y(x) = C_1 sin(alpha x) + C_2 cos(alpha x)$, a cui si devono imporre le condizioni al contorno.

4) Imponendo l'appoggio in $A$: $y(0) = C_2 = 0 ==> y(x) = C_1 sin(alpha x)$

Imponendo la cerniera in $B$: $y(ell) = C_1 sin(alpha ell) = 0$
- Se $C_1 = 0 ==>$ non si inflette (soluzione banale)
- Se $sin(alpha ell) = 0 ==> alpha ell = n pi ==>$ si inflette

5) Sostituendo $alpha ell = n pi$ in $alpha^2 = P / (E I_z)$ si riscrive:

$ alpha^2 = P / (E I_z) = (n^2 pi^2) / ell^2 $

Da qui si ricava il carico critico euleriano:

$ P_("cr") = (n^2 pi^2 E I_z) / ell^2 quad arrow.r quad "con" n = 1 "si ha la prima forma critica di inflessione" $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    6) Per diverse condizioni di vincolo si ha:
    $ P_("cr") = (pi^2 E I_z) / ell_0^2 $
    dove $ell_0$ è la lunghezza libera di inflessione (dipende dal tipo di vincolo).
  ],
  [
    #image("image 52.jpg", width: 70%)
  ]
)

// --- PRIMA IMMAGINE ---

- Si definisce snellezza dell'asta: #box(stroke: 1pt, inset: 6pt)[$lambda = l_0 / rho_z$] #h(1em) #box(stroke: 1pt, inset: 6pt)[$rho_z = sqrt(I_z / A)$] #h(1em) $rho_z$: raggio d'inerzia della sezione trasversale

- Tensione critica: #box(stroke: 1pt, inset: 6pt)[$sigma_"cr" = (pi^2 E) / lambda^2$]

- Snellezza limite: #box(stroke: 1pt, inset: 6pt)[$lambda_"lim" = pi sqrt(E / sigma_"lim")$]


// --- SECONDA IMMAGINE ---


// *Nota: negli appunti è scritto "maggiore", ma fisicamente è "minore" (coerentemente con il momento d'inerzia minore indicato subito dopo).
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    7) Dal carico critico si ricava la tensione critica (euleriana):
    $ sigma_("cr") = P_("cr") / A = (pi^2 E I_z) / (A ell_0^2) $
    - Sicurezza all'instabilità elastica: aumenta scegliendo un materiale con modulo elastico $E$ più elevato e ottimizzando la geometria della sezione ($I_z$).
    - Il coefficiente di sicurezza deve essere più elevato rispetto al caso del cedimento per snervamento: $"CS"_("inst.el") > "CS"_s$.
  ],
  [
    *7)*
// [Grafico P-y: per P < P_cr "soluzione stabile", per P > P_cr "soluzione instabile"]

- $y != 0$ asta inflessa
- $y = 0$ asta rettilinea non inflessa

$P < P_"cr"$ (condizioni subcritiche): l'unica configurazione possibile è l'asta rettilinea non inflessa.

$P >= P_"cr"$:
- (condizioni critiche): diventa possibile anche la configurazione inflessa
- la condizione rettilinea è instabile ed è sufficiente una piccola perturbazione perché si verifichi l'inflessione dell'asta

$->$ Il problema dell'instabilità elastica per carico di punta è stato impostato considerando il comportamento nel piano $x y$.

$->$ Nella realtà, l'inflessione avviene nel piano in cui l'asta ha maggiore\* rigidezza flessionale e quindi nel piano in cui il momento d'inerzia della sezione trasversale è minore.
  ]
)
#v(1em)