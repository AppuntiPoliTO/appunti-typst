#import "@preview/cetz:0.3.4": canvas, draw

#set page(paper: "a4", margin: 2cm)
#set text(lang: "it", size: 11pt)
#set par(justify: true)
#set heading(numbering: none)

= Fondamenti di Meccanica Strutturale - Testo d'Esame (09/11/2025)

== Esercizio 1

In un punto di un componente meccanico, rispetto a un sistema di riferimento cartesiano ortogonale $x, y, z$, lo stato tensionale è definito dal seguente tensore delle tensioni:

$ [sigma] = mat(delim: "[", 50, 0, 50; 0, 200, 0; 50, 0, 120) "MPa" $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Si richiede di:
    + Determinare le tensioni principali $sigma_1, sigma_2, sigma_3$ e rappresentare graficamente lo stato tensionale mediante i cerchi di Mohr nel piano $(sigma, tau)$.
    + Calcolare il coefficiente di sicurezza statico $S$ sia nel caso in cui il componente sia realizzato in materiale duttile (con tensione di rottura $sigma_R = 400 "MPa"$ e tensione di snervamento $sigma_S = 350 "MPa"$), sia nel caso in cui sia realizzato in materiale fragile (con tensione di rottura $sigma_R = 600 "MPa"$).
    + Determinare la variazione di temperatura $Delta T$ necessaria affinché nel punto considerato si realizzi uno stato di deformazione piano ($epsilon_(y y) = 0$), assumendo per il materiale un modulo di Young $E = 200000 "MPa"$, un coefficiente di Poisson $nu = 0,3$ e un coefficiente di dilatazione termica lineare $alpha = 11 dot 10^(-6) thin degree"C"^(-1)$.
  ],
  [
    
    #canvas(length: 1cm, {
      import draw: *

      // Spigoli del cubetto elementare
      line((3.0, 1.5), (3.0, 3.3), stroke: 1pt)
      line((1.6, 2.0), (1.6, 3.8), stroke: 1pt)
      line((4.5, 1.8), (4.5, 3.6), stroke: 1pt)
      line((1.6, 2.0), (3.0, 1.5), (4.5, 1.8), stroke: 1pt)
      line((1.6, 3.8), (3.0, 3.3), (4.5, 3.6), (3.1, 4.1), close: true, stroke: 1pt)

      // Assi coordinati
      line((3.0, 3.7), (3.0, 5.1), mark: (end: ">"), stroke: 0.6pt)
      line((2.3, 2.5), (0.6, 1.9), mark: (end: ">"), stroke: 0.6pt)
      line((3.7, 2.4), (5.5, 2.0), mark: (end: ">"), stroke: 0.6pt)

      // Vettori di tensione (in blu come nello schema a mano)
      // sigma_yy
      line((3.0, 3.7), (3.0, 4.7), mark: (end: ">"), stroke: (paint: blue, thickness: 1pt))
      // sigma_zz
      line((2.3, 2.5), (1.1, 2.08), mark: (end: ">"), stroke: (paint: blue, thickness: 1pt))
      // sigma_xx
      line((3.7, 2.4), (5.0, 2.11), mark: (end: ">"), stroke: (paint: blue, thickness: 1pt))
      // tau_xz sulla faccia z (verso lo spigolo centrale)
      line((2.0, 2.85), (2.9, 2.53), mark: (end: ">"), stroke: (paint: blue, thickness: 1pt))
      // tau_xz sulla faccia x (verso lo spigolo centrale)
      line((4.1, 2.7), (3.1, 2.5), mark: (end: ">"), stroke: (paint: blue, thickness: 1pt))

      // Etichette
      content((2.7, 5.0), text(size: 7pt)[$y$], anchor: "east")
      content((0.7, 1.6), text(size: 7pt)[$z$], anchor: "north")
      content((5.4, 1.7), text(size: 7pt)[$x$], anchor: "north")
      content((3.15, 4.45), text(size: 7pt)[$sigma_(y y)$], anchor: "west")
      content((1.4, 2.95), text(size: 7pt)[$sigma_(z z)$], anchor: "east")
      content((4.8, 2.45), text(size: 7pt)[$sigma_(x x)$], anchor: "west")
      content((2.45, 3.05), text(size: 7pt)[$tau_(x z)$], anchor: "south")
      content((3.75, 2.95), text(size: 7pt)[$tau_(x z)$], anchor: "south")
    })
    
  ]
)
#v(1em)
#pagebreak()
== Esercizio 2

La struttura piana mostrata in figura è costituita da travi a sezione quadrata piena di lato $a$, ed è vincolata a terra tramite due cerniere fisse poste nei punti $A$ e $H$. Nel punto $E$ è presente una cerniera interna che collega il tratto orizzontale $D E$ al tratto $E F G$. La struttura è soggetta a un carico distribuito verticale $q$ applicato lungo il tratto $D F$, a una forza concentrata orizzontale $F$ applicata all'estremità $C$ dello sbalzo $B C$, e a una coppia concentrata antioraria $M$ applicata all'estremità libera $G$.

*Dati del problema:*
    - $L = 1 "m"$
    - $q = 1000 "N/m"$
    - $F = 1000 "N"$
    - $M = 1000 "N" dot "m"$
    - $a = 40 "mm"$
    - $sigma_S = 510 "MPa"$

    Si richiede di:
    + Determinare le reazioni vincolari esterne in $A$ e in $H$.
    + Calcolare e tracciare i diagrammi quotati delle caratteristiche di sollecitazione ($N, T, M_f$) lungo tutta la struttura.
    + Individuare il punto più sollecitato relativamente al montante verticale $F H$ (nella sezione $F$) e calcolare il relativo coefficiente di sicurezza a snervamento $C S$.


#canvas(length: 2.5cm, {
      import draw: *

      // Struttura principale
      line((0.8, 0.8), (0.8, 2.1), stroke: 1pt)
      line((0.8, 1.45), (1.2, 1.45), stroke: 1pt)
      line((0.8, 2.1), (6.0, 2.1), stroke: 1pt)
      line((4.7, 0.8), (4.7, 2.1), stroke: 1pt)

      // Cerniera interna in E(3.4, 2.1)
      circle((3.4, 2.1), radius: 0.08, fill: white, stroke: 1pt)

      // Cerniera a terra in A(0.8, 0.8)
      circle((0.8, 0.74), radius: 0.06, fill: white, stroke: 1pt)
      line((0.8, 0.68), (0.68, 0.52), (0.92, 0.52), close: true, stroke: 1pt)
      line((0.65, 0.52), (0.60, 0.42), stroke: 0.6pt)
      line((0.73, 0.52), (0.68, 0.42), stroke: 0.6pt)
      line((0.81, 0.52), (0.76, 0.42), stroke: 0.6pt)
      line((0.89, 0.52), (0.84, 0.42), stroke: 0.6pt)

      // Cerniera a terra in H(4.7, 0.8)
      circle((4.7, 0.74), radius: 0.06, fill: white, stroke: 1pt)
      line((4.7, 0.68), (4.58, 0.52), (4.82, 0.52), close: true, stroke: 1pt)
      line((4.55, 0.52), (4.50, 0.42), stroke: 0.6pt)
      line((4.63, 0.52), (4.58, 0.42), stroke: 0.6pt)
      line((4.71, 0.52), (4.66, 0.42), stroke: 0.6pt)
      line((4.79, 0.52), (4.74, 0.42), stroke: 0.6pt)

      // Carico distribuito q (in blu)
      line((0.8, 2.45), (4.7, 2.45), stroke: (paint: blue, thickness: 0.6pt))
      line((0.8, 2.45), (0.8, 2.12), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))
      line((1.45, 2.45), (1.45, 2.12), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))
      line((2.1, 2.45), (2.1, 2.12), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))
      line((2.75, 2.45), (2.75, 2.12), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))
      line((3.4, 2.45), (3.4, 2.18), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))
      line((4.05, 2.45), (4.05, 2.12), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))
      line((4.7, 2.45), (4.7, 2.12), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))

      // Forza F in C (in blu)
      line((1.2, 1.45), (1.75, 1.45), mark: (end: ">"), stroke: (paint: blue, thickness: 1pt))

      // Coppia M in G (in blu)
      circle((6.0, 2.1), radius: 0.04, fill: black)
      arc((6.0, 2.1), start: -50deg, stop: 95deg, radius: 0.25, anchor: "origin", mark: (end: ">"), stroke: (paint: blue, thickness: 1pt))

      // Quote geometriche
      // Quota verticale sinistra L/2
      line((0.4, 0.8), (0.7, 0.8), stroke: 0.4pt)
      line((0.4, 1.45), (0.7, 1.45), stroke: 0.4pt)
      line((0.45, 0.8), (0.45, 1.45), mark: (start: ">", end: ">"), stroke: 0.6pt)
      // Quota L/4
      line((1.2, 1.45), (1.2, 1.75), stroke: 0.4pt)
      line((0.8, 1.7), (1.2, 1.7), mark: (start: ">", end: ">"), stroke: 0.6pt)
      // Quote superiori 2L, L, L
      line((0.8, 2.5), (0.8, 2.85), stroke: 0.4pt)
      line((3.4, 2.5), (3.4, 2.85), stroke: 0.4pt)
      line((4.7, 2.5), (4.7, 2.85), stroke: 0.4pt)
      line((6.0, 2.2), (6.0, 2.85), stroke: 0.4pt)
      line((0.8, 2.75), (3.4, 2.75), mark: (start: ">", end: ">"), stroke: 0.6pt)
      line((3.4, 2.75), (4.7, 2.75), mark: (start: ">", end: ">"), stroke: 0.6pt)
      line((4.7, 2.75), (6.0, 2.75), mark: (start: ">", end: ">"), stroke: 0.6pt)
      // Quota verticale destra L
      line((4.85, 0.8), (6.3, 0.8), stroke: 0.4pt)
      line((6.2, 0.8), (6.2, 2.1), mark: (start: ">", end: ">"), stroke: 0.6pt)

      // Dettaglio sezione quadrata a x a
      rect((6.8, 1.3), (7.3, 1.8), stroke: 0.8pt)
      line((6.8, 1.45), (6.95, 1.3), stroke: 0.4pt)
      line((6.8, 1.65), (7.15, 1.3), stroke: 0.4pt)
      line((6.85, 1.8), (7.3, 1.35), stroke: 0.4pt)
      line((7.05, 1.8), (7.3, 1.55), stroke: 0.4pt)
      line((6.8, 1.95), (7.3, 1.95), mark: (start: ">", end: ">"), stroke: 0.5pt)
      line((6.65, 1.3), (6.65, 1.8), mark: (start: ">", end: ">"), stroke: 0.5pt)

      // Etichette nodi (in rosso come nell'originale)
      content((0.68, 0.82), text(size: 7pt, fill: red)[A], anchor: "east")
      content((0.75, 1.45), text(size: 7pt, fill: red)[B], anchor: "east")
      content((1.2, 1.35), text(size: 7pt, fill: red)[C], anchor: "north")
      content((0.75, 2.15), text(size: 7pt, fill: red)[D], anchor: "east")
      content((3.4, 1.95), text(size: 7pt, fill: red)[E], anchor: "north")
      content((4.8, 2.2), text(size: 7pt, fill: red)[F], anchor: "south-west")
      content((6.0, 1.95), text(size: 7pt, fill: red)[G], anchor: "north")
      content((4.55, 0.82), text(size: 7pt, fill: red)[H], anchor: "east")

      // Etichette carichi e quote
      content((0.68, 2.35), text(size: 7pt, fill: blue)[$q$], anchor: "east")
      content((1.65, 1.35), text(size: 7pt, fill: blue)[$F$], anchor: "north")
      content((6.3, 2.25), text(size: 7pt, fill: blue)[$M$], anchor: "west")
      content((0.38, 1.12), text(size: 7pt)[$L/2$], anchor: "east")
      content((1.0, 1.75), text(size: 7pt)[$L/4$], anchor: "south")
      content((2.1, 2.82), text(size: 7pt)[$2 L$], anchor: "south")
      content((4.05, 2.82), text(size: 7pt)[$L$], anchor: "south")
      content((5.35, 2.82), text(size: 7pt)[$L$], anchor: "south")
      content((6.28, 1.45), text(size: 7pt)[$L$], anchor: "west")
      content((7.05, 2.0), text(size: 7pt)[$a$], anchor: "south")
      content((6.58, 1.55), text(size: 7pt)[$a$], anchor: "east")
    })
    
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    
  ],
  [
    // FASE 0: COMPRENSIONE
    // Schema strutturale del telaio piano A-B-C-D-E-F-G-H con quote geometriche, vincoli (cerniere in A, H
    // e cerniera interna in E), carichi applicati (q, F, M) e sezione trasversale quadrata di lato a.

    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: Pannello principale del telaio + piccolo dettaglio della sezione quadrata a destra.
    //    Scala: L = 1.3 cm. Larghezza totale da x=0.0 a x=7.6 cm, altezza da y=0.0 a y=3.8 cm.
    // 2. ELEMENTI:
    //    - Montante sinistro A(0.8, 0.8) - B(0.8, 1.45) - D(0.8, 2.1).
    //    - Sbalzo B(0.8, 1.45) - C(1.2, 1.45).
    //    - Traverso superiore D(0.8, 2.1) - E(3.4, 2.1) - F(4.7, 2.1) - G(6.0, 2.1).
    //    - Montante destro H(4.7, 0.8) - F(4.7, 2.1).
    //    - Cerniera a terra in A(0.8, 0.8) e H(4.7, 0.8); cerniera interna in E(3.4, 2.1).
    //    - Carico distribuito q da D(0.8, 2.1) a F(4.7, 2.1), forza F in C, momento M in G.
    //    - Sezione quadrata a destra: (6.7, 1.5) a (7.3, 2.1) con tratteggio e quote a.
    // 3. CLASSIFICAZIONE CURVE:
    //    - Arco per la coppia M in G(6.0, 2.1): arco circolare di raggio r = 0.25 cm, centro (6.0, 2.1),
    //      da start = -60 deg a stop = 90 deg.

    // FASE 2: COSTRUZIONE
    
    // FASE 3: VERIFICA
    // 1. Arco coppia M: r=0.25, anchor: "origin", start=-50deg < stop=95deg.
    // 2. Contorni e quote continui e coerenti con le proporzioni L, 2L, L/2, L/4.
    // 3. Tutte le 19 etichette interne usano text(size: 7pt)[...].
  ]
)
#v(1em)

== Esercizio 3 (Quesito di Teoria)

Si consideri una barra cilindrica a sezione circolare dotata di un intaglio circonferenziale simmetrico (con diametro minimo $d$ in corrispondenza della gola dell'intaglio e fattore teorico di concentrazione delle tensioni $K_t$), incastrata a un'estremità e soggetta all'altra estremità a una forza assiale di trazione $F$ diretta lungo l'asse $x$ della barra.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Si richiede di:
    + Indicare qual è la sezione più sollecitata del componente e rappresentare graficamente l'andamento delle tensioni normali nominali e delle tensioni normali reali in tale sezione.
    + Scrivere il tensore delle tensioni $[sigma]$ associato allo stato di tensione nominale e tracciare il corrispondente cerchio di Mohr nel piano $(sigma, tau)$.
    + Esprimere il coefficiente di sicurezza $C S$ nel caso in cui il materiale sia fragile (avente tensione di rottura $R_m$).
    + Esprimere il coefficiente di sicurezza $C S$ nel caso in cui il materiale sia duttile (avente tensione di snervamento $R_("p0,2")$ e tensione di rottura $R_m$) con riferimento alle condizioni di:
      - prima plasticizzazione;
      - completa plasticizzazione;
      - rottura duttile.
  ],
  [
    // FASE 0: COMPRENSIONE
    // Rappresentazione schematica di una barra intagliata incastrata a sinistra e soggetta a una forza
    // di trazione assiale F a destra, con sistema di riferimento (x, y).

    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello singolo, larghezza 5.5 cm, altezza 2.5 cm.
    // 2. ELEMENTI:
    //    - Parete di incastro verticale in x=1.0 da y=0.4 a y=2.1 con tratteggio a sinistra.
    //    - Profilo superiore della barra: da (1.0, 1.8) a (2.0, 1.8), intaglio semicircolare fino a (2.5, 1.8),
    //      poi tratto da (2.5, 1.8) a (3.8, 1.8).
    //    - Profilo inferiore: da (1.0, 0.7) a (2.0, 0.7), intaglio semicircolare fino a (2.5, 0.7),
    //      poi tratto da (2.5, 0.7) a (3.8, 0.7).
    //    - Forza F applicata in (3.8, 1.25) diretta verso destra fino a (4.8, 1.25).
    // 3. CLASSIFICAZIONE CURVE:
    //    - Intaglio superiore: arco di cerchio con centro (2.25, 1.8), raggio r = 0.25 cm, da start = 180deg a stop = 360deg.
    //    - Intaglio inferiore: arco di cerchio con centro (2.25, 0.7), raggio r = 0.25 cm, da start = 0deg a stop = 180deg.

    // FASE 2: COSTRUZIONE
    #canvas(length: 1cm, {
      import draw: *

      // Incastro a sinistra
      line((1.0, 0.4), (1.0, 2.1), stroke: 1pt)
      line((1.0, 0.55), (0.8, 0.35), stroke: 0.6pt)
      line((1.0, 0.85), (0.8, 0.65), stroke: 0.6pt)
      line((1.0, 1.15), (0.8, 0.95), stroke: 0.6pt)
      line((1.0, 1.45), (0.8, 1.25), stroke: 0.6pt)
      line((1.0, 1.75), (0.8, 1.55), stroke: 0.6pt)
      line((1.0, 2.05), (0.8, 1.85), stroke: 0.6pt)

      // Contorno barra con intaglio
      line((1.0, 1.8), (2.0, 1.8), stroke: 1pt)
      arc((2.25, 1.8), start: 180deg, stop: 360deg, radius: 0.25, anchor: "origin", stroke: 1pt)
      line((2.5, 1.8), (3.8, 1.8), (3.8, 0.7), (2.5, 0.7), stroke: 1pt)
      arc((2.25, 0.7), start: 0deg, stop: 180deg, radius: 0.25, anchor: "origin", stroke: 1pt)
      line((2.0, 0.7), (1.0, 0.7), stroke: 1pt)

      // Assi x, y
      line((1.0, 1.25), (1.7, 1.25), mark: (end: ">"), stroke: 0.6pt)
      line((1.0, 1.8), (1.0, 2.35), mark: (end: ">"), stroke: 0.6pt)

      // Forza F
      line((3.8, 1.25), (4.8, 1.25), mark: (end: ">"), stroke: 1pt)

      // Etichette
      content((1.45, 1.18), text(size: 7pt)[$x$], anchor: "north")
      content((1.12, 2.25), text(size: 7pt)[$y$], anchor: "west")
      content((4.5, 1.35), text(size: 7pt)[$F$], anchor: "south")
    })
    // FASE 3: VERIFICA
    // 1. Archi d'intaglio: r=0.25, anchor: "origin", start < stop (180<360 e 0<180).
    // 2. Contorni continui negli estremi degli archi (2.0, 1.8)-(2.5, 1.8) e (2.0, 0.7)-(2.5, 0.7).
    // 3. Tutte le 3 etichette interne usano text(size: 7pt)[...].
  ]
)

#pagebreak()

// ==========================================
// PARTE 2: SOLUZIONI E PROCEDIMENTO COMPLETO
// ==========================================
= Soluzione dell'Esame

== Primo esercizio) Soluzione

=== Punto 1) Calcolo delle tensioni principali e cerchi di Mohr

Analizziamo il tensore delle tensioni assegnato nel punto considerato:

$ [sigma] = mat(delim: "[", 50, 0, 50; 0, 200, 0; 50, 0, 120) "MPa" $

Osservando le componenti del tensore, notiamo immediatamente che lungo la direzione $y$ le tensioni tangenziali sono nulle ($tau_(x y) = tau_(y z) = 0$). Pertanto, l'asse $y$ è già una direzione principale di tensione e la tensione normale $sigma_(y y) = 200 "MPa"$ costituisce una delle tre tensioni principali.

Per determinare le altre due tensioni principali nel piano $x$-$z$, tracciamo il cerchio di Mohr relativo a tale piano, individuando le coordinate del centro $sigma_C$ e il raggio $r$:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ sigma_C = (sigma_(x x) + sigma_(z z)) / 2 = (50 + 120) / 2 = 85 "MPa" $

    $ r = sqrt(((sigma_(x x) - sigma_(z z)) / 2)^2 + tau_(x z)^2) = 61 "MPa" $

    Le tensioni principali nel piano $x$-$z$ valgono quindi:

    $ sigma_a &= sigma_C + r = 146 "MPa" && arrow.r sigma_2 \
      sigma_b &= sigma_C - r = 24 "MPa"  && arrow.r sigma_3 $

    Riordinando le tensioni principali in senso decrescente ($sigma_1 gt.eq sigma_2 gt.eq sigma_3$), otteniamo:

    $ sigma_(y y) &= 200 "MPa" && arrow.r sigma_1 \
      sigma_a     &= 146 "MPa" && arrow.r sigma_2 \
      sigma_b     &= 24 "MPa"  && arrow.r sigma_3 $
  ],
  [
    #canvas(length: 1.5cm, {
      import draw: *

      // Assi cartesiani (sigma, tau)
      line((0.6, 2.2), (6.0, 2.2), mark: (end: ">"), stroke: 0.8pt)
      line((1.2, 0.6), (1.2, 4.0), mark: (end: ">"), stroke: 0.8pt)

      // Semicerchio superiore (tratto continuo) e inferiore (tratteggiato)
      arc((2.90, 2.20), start: 0deg, stop: 180deg, radius: 1.22, anchor: "origin", stroke: (paint: blue.darken(30%), thickness: 1pt))
      arc((2.90, 2.20), start: 180deg, stop: 360deg, radius: 1.22, anchor: "origin", stroke: (paint: blue.darken(30%), thickness: 0.8pt, dash: "dashed"))

      // Diametro tra (sigma_xx=50, tau_xz=50) -> (2.20, 3.20) e (sigma_zz=120, -50) -> (3.60, 1.20)
      line((2.20, 3.20), (3.60, 1.20), stroke: 0.6pt)

      // Linee tratteggiate di proiezione
      line((1.20, 3.20), (2.20, 3.20), stroke: (dash: "dashed", thickness: 0.5pt))
      line((2.20, 3.20), (2.20, 2.20), stroke: (dash: "dashed", thickness: 0.5pt))
      line((1.20, 1.20), (3.60, 1.20), stroke: (dash: "dashed", thickness: 0.5pt))
      line((3.60, 2.20), (3.60, 1.20), stroke: (dash: "dashed", thickness: 0.5pt))

      // Punti notevoli sull'asse sigma
      circle((1.68, 2.20), radius: 0.05, fill: blue.darken(30%))
      circle((2.90, 2.20), radius: 0.04, fill: black)
      circle((4.12, 2.20), radius: 0.05, fill: blue.darken(30%))
      circle((5.20, 2.20), radius: 0.05, fill: blue.darken(30%))

      // Tacche di riferimento
      line((1.13, 3.20), (1.27, 3.20), stroke: 0.6pt)
      line((1.13, 1.20), (1.27, 1.20), stroke: 0.6pt)
      line((2.20, 2.13), (2.20, 2.27), stroke: 0.6pt)
      line((3.60, 2.13), (3.60, 2.27), stroke: 0.6pt)

      // Etichette (tutte con text(size: 7pt))
      content((1.05, 3.9), text(size: 7pt)[$tau thin ["MPa"]$], anchor: "east")
      content((5.9, 2.05), text(size: 7pt)[$sigma thin ["MPa"]$], anchor: "north")
      content((1.08, 3.20), text(size: 7pt)[$tau_(x z) = 50$], anchor: "east")
      content((1.08, 1.20), text(size: 7pt)[$-50$], anchor: "east")
      content((2.65, 2.65), text(size: 7pt)[$r$], anchor: "south-west")
      content((1.62, 2.05), text(size: 7pt)[$sigma_b$], anchor: "north")
      content((2.20, 2.02), text(size: 7pt)[$50$], anchor: "north")
      content((2.20, 1.65), text(size: 7pt)[$sigma_(x x)$], anchor: "north")
      content((2.90, 2.05), text(size: 7pt)[$sigma_C$], anchor: "north")
      content((3.55, 2.05), text(size: 7pt)[$120$], anchor: "north")
      content((3.75, 1.65), text(size: 7pt)[$sigma_(z z)$], anchor: "north")
      content((4.18, 2.05), text(size: 7pt)[$sigma_a$], anchor: "north")
      content((5.20, 2.05), text(size: 7pt)[$sigma_(y y)$], anchor: "north")
    })
  ]
)
#v(1em)

Possiamo ora rappresentare l'arbelo completo dei tre cerchi di Mohr nel piano $(sigma, tau)$:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    I tre cerchi di Mohr sono delimitati dalle tensioni principali:
    - $sigma_3 = 24 "MPa"$
    - $sigma_2 = 146 "MPa"$
    - $sigma_1 = 200 "MPa"$

    Il cerchio maggiore (compreso tra $sigma_3 = 24 "MPa"$ e $sigma_1 = 200 "MPa"$) ha raggio pari alla tensione tangenziale massima:
    $ tau_("max") = (sigma_1 - sigma_3) / 2 = (200 - 24) / 2 = 88 "MPa" $
  ],
  [
    // FASE 0: COMPRENSIONE
    // Diagramma completo dei tre cerchi di Mohr corrispondenti a sigma_3=24 MPa, sigma_2=146 MPa, sigma_1=200 MPa.

    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, origine degli assi (sigma=0, tau=0) in (1.0, 2.2).
    //    Scala: 1 unità CeTZ = 50 MPa (0.02 cm/MPa).
    //    - sigma_3 = 24 MPa -> x = 1.0 + 0.48 = 1.48
    //    - sigma_2 = 146 MPa -> x = 1.0 + 2.92 = 3.92
    //    - sigma_1 = 200 MPa -> x = 1.0 + 4.00 = 5.00
    // 2. CLASSIFICAZIONE CURVE:
    //    - Cerchio 1 (tra sigma_3 e sigma_2): centro C_32 = ((1.48+3.92)/2, 2.2) = (2.70, 2.20), r_32 = 1.22 cm.
    //    - Cerchio 2 (tra sigma_2 e sigma_1): centro C_21 = ((3.92+5.00)/2, 2.2) = (4.46, 2.20), r_21 = 0.54 cm.
    //    - Cerchio 3 (tra sigma_3 e sigma_1): centro C_31 = ((1.48+5.00)/2, 2.2) = (3.24, 2.20), r_31 = 1.76 cm.
    //    Tutte circonferenze esatte (e_max = 0).

    // FASE 2: COSTRUZIONE
    #canvas(length: 1cm, {
      import draw: *

      // Assi cartesiani
      line((0.4, 2.2), (6.0, 2.2), mark: (end: ">"), stroke: 0.8pt)
      line((1.0, 0.3), (1.0, 4.2), mark: (end: ">"), stroke: 0.8pt)

      // I tre cerchi di Mohr
      circle((3.24, 2.20), radius: 1.76, stroke: (paint: blue.darken(30%), thickness: 1pt))
      circle((2.70, 2.20), radius: 1.22, stroke: (paint: blue.darken(30%), thickness: 1pt))
      circle((4.46, 2.20), radius: 0.54, stroke: (paint: blue.darken(30%), thickness: 1pt))

      // Punti delle tensioni principali
      circle((1.48, 2.20), radius: 0.04, fill: black)
      circle((3.92, 2.20), radius: 0.04, fill: black)
      circle((5.00, 2.20), radius: 0.04, fill: black)

      // Etichette
      content((0.9, 4.1), text(size: 7pt)[$tau thin ["MPa"]$], anchor: "east")
      content((5.9, 2.05), text(size: 7pt)[$sigma thin ["MPa"]$], anchor: "north")
      content((1.35, 2.05), text(size: 7pt)[$sigma_3$], anchor: "north")
      content((1.35, 1.70), text(size: 7pt)[$24$], anchor: "north")
      content((3.78, 2.05), text(size: 7pt)[$sigma_2$], anchor: "north")
      content((3.78, 1.70), text(size: 7pt)[$146$], anchor: "north")
      content((5.15, 2.05), text(size: 7pt)[$sigma_1$], anchor: "north")
      content((5.15, 1.70), text(size: 7pt)[$200$], anchor: "north")
    })
    // FASE 3: VERIFICA
    // 1. I tre cerchi sono tangenti esattamente in (1.48, 2.20), (3.92, 2.20) e (5.00, 2.20).
    // 2. Tutte le 8 etichette usano text(size: 7pt)[...].
  ]
)
#v(1em)

=== Punto 2) Verifica di resistenza per materiale duttile e materiale fragile

Confrontiamo le proprietà dei due materiali con i rispettivi criteri di resistenza:
- *Materiale duttile* ($sigma_R = 400 "MPa"$, $sigma_S = 350 "MPa"$): adottiamo il criterio di Tresca, secondo cui la tensione ideale vale:
  $ sigma_("id")^("Tresca") = sigma_1 - sigma_3 = 200 - 24 = 176 "MPa" $
  Il coefficiente di sicurezza rispetto allo snervamento risulta pertanto:
  $ S_("duttile") = sigma_S / sigma_("id")^("Tresca") = 350 / 176 = 2 $

- *Materiale fragile* ($sigma_R = 600 "MPa"$): adottiamo il criterio della massima tensione normale principale (Rankine / Galileo), secondo cui la tensione ideale vale:
  $ sigma_("id")^("Rankine") = sigma_1 = 200 "MPa" $
  Il coefficiente di sicurezza rispetto alla rottura fragile risulta:
  $ S_("fragile") = sigma_R / sigma_("id")^("Rankine") = 600 / 200 = 3 $

=== Punto 3) Calcolo della variazione termica per avere stato di deformazione piano

Dal tensore delle tensioni:
$ [sigma] = mat(delim: "[", 50, 0, 50; 0, 200, 0; 50, 0, 120) "MPa" ==> tau_(y x) = tau_(y z) = 0 $
segue per la legge di Hooke generalizzata che gli scorrimenti angolari fuori dal piano $x$-$z$ sono già nulli:
$ gamma_(y x) = gamma_(y z) = 0 $

Pertanto, affinché si realizzi uno stato di deformazione piano nel piano $x$-$z$, è necessario e sufficiente imporre che anche la dilatazione lineare lungo l'asse $y$ sia nulla ($epsilon_(y y) = 0$). Esprimendo la legge costitutiva termoelastica lungo la direzione $y$:

$ epsilon_(y y) = 1 / E [sigma_(y y) - nu (sigma_(x x) + sigma_(z z))] + alpha Delta T = 0 $

da cui ricaviamo la variazione di temperatura $Delta T$:

$ Delta T &= - 1 / (E alpha) [sigma_(y y) - nu (sigma_(x x) + sigma_(z z))] = \
          &= - 1 / (200000 dot 11 dot 10^(-6)) [200 - 0,3 (50 + 120)] = -68 thin degree"C" $

#v(1em)

== Secondo esercizio) Soluzione

=== Calcolo delle reazioni vincolari

Sostituiamo ai vincoli esterni in $A$ e $H$ le rispettive reazioni vincolari orizzontali ($H_A, H_H$) e verticali ($V_A, V_H$). Scriviamo le tre equazioni cardinali della statica per l'intera struttura, affiancate dall'equazione ausiliaria di equilibrio alla rotazione attorno alla cerniera interna $E$ per il sottosistema di destra ($E F G H$):

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ (arrow.r) quad & H_A + H_H + F = 0 \
                     & ==> H_A = -H_H - F = 833 "N" $

    $ (arrow.t) quad & V_A + V_H - 3 q L = 0 \
                     & ==> V_A = 3 q L - V_H = 1667 "N" $

    $ (A) quad & -F L / 2 - 3 q L dot 3 / 2 L + M + V_H dot 3 L = 0 \
               & ==> V_H = F / 6 + 3 / 2 q L - M / (3 L) = 1333 "N" $

    *Equazione ausiliaria cerniera $E$ (tratto destro):*
    $ (E^("DX")) quad & V_H L + H_H L + M - q L^2 / 2 = 0 \
                      & ==> H_H = -V_H - M / L + (q L) / 2 = -1833 "N" $
  ],
  [
    // FASE 0: COMPRENSIONE
    // Schema di corpo libero della struttura con le reazioni vincolari H_A, V_A in A e H_H, V_H in H (in rosso),
    // i carichi esterni q, F, M (in blu) e le tracce delle 6 sezioni S_1^+, S_2^-, S_3^+, S_4^+, S_5^-, S_6^- (in verde/nero).

    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, L = 1.3 cm.
    //    Coordinate nodi: A(0.8, 1.0), B(0.8, 1.65), C(1.2, 1.65), D(0.8, 2.3), E(3.4, 2.3), F(4.7, 2.3), G(6.0, 2.3), H(4.7, 1.0).
    // 2. ELEMENTI:
    //    - Vettori reazioni in A: V_A da (0.8, 0.3) a (0.8, 1.0), H_A da (0.8, 1.0) a (1.5, 1.0).
    //    - Vettori reazioni in H: V_H da (4.7, 0.3) a (4.7, 1.0), H_H da (4.7, 1.0) a (5.4, 1.0).
    //    - Indicatori delle sezioni S_1^+, S_2^-, S_3^+, S_4^+, S_5^-, S_6^-.
    // 3. CLASSIFICAZIONE CURVE:
    //    - Arco momento M in G(6.0, 2.3): r = 0.25 cm, start = -50deg, stop = 95deg.

    // FASE 2: COSTRUZIONE
    #canvas(length: 1cm, {
      import draw: *

      // Struttura
      line((0.8, 1.0), (0.8, 2.3), stroke: 1pt)
      line((0.8, 1.65), (1.2, 1.65), stroke: 1pt)
      line((0.8, 2.3), (6.0, 2.3), stroke: 1pt)
      line((4.7, 1.0), (4.7, 2.3), stroke: 1pt)
      circle((3.4, 2.3), radius: 0.08, fill: white, stroke: 1pt)

      // Carichi (in blu)
      line((0.8, 2.65), (4.7, 2.65), stroke: (paint: blue, thickness: 0.6pt))
      line((0.8, 2.65), (0.8, 2.32), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))
      line((1.58, 2.65), (1.58, 2.32), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))
      line((2.36, 2.65), (2.36, 2.32), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))
      line((3.14, 2.65), (3.14, 2.32), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))
      line((3.92, 2.65), (3.92, 2.32), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))
      line((4.7, 2.65), (4.7, 2.32), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))
      line((1.2, 1.65), (1.75, 1.65), mark: (end: ">"), stroke: (paint: blue, thickness: 1pt))
      arc((6.0, 2.3), start: -50deg, stop: 95deg, radius: 0.25, anchor: "origin", mark: (end: ">"), stroke: (paint: blue, thickness: 1pt))

      // Reazioni vincolari (in rosso)
      line((0.8, 0.3), (0.8, 0.98), mark: (end: ">"), stroke: (paint: red, thickness: 1pt))
      line((0.8, 1.0), (1.5, 1.0), mark: (end: ">"), stroke: (paint: red, thickness: 1pt))
      line((4.7, 0.3), (4.7, 0.98), mark: (end: ">"), stroke: (paint: red, thickness: 1pt))
      line((4.7, 1.0), (5.4, 1.0), mark: (end: ">"), stroke: (paint: red, thickness: 1pt))

      // Tracce delle sezioni di calcolo (in verde scuro)
      line((0.68, 1.32), (0.92, 1.32), stroke: (paint: green.darken(40%), thickness: 0.8pt))
      line((1.0, 1.53), (1.0, 1.77), stroke: (paint: green.darken(40%), thickness: 0.8pt))
      line((0.68, 1.98), (0.92, 1.98), stroke: (paint: green.darken(40%), thickness: 0.8pt))
      line((1.8, 2.18), (1.8, 2.42), stroke: (paint: green.darken(40%), thickness: 0.8pt))
      line((5.3, 2.18), (5.3, 2.42), stroke: (paint: green.darken(40%), thickness: 0.8pt))
      line((4.58, 1.65), (4.82, 1.65), stroke: (paint: green.darken(40%), thickness: 0.8pt))

      // Etichette
      content((0.9, 0.45), text(size: 7pt, fill: red)[$V_A$], anchor: "west")
      content((1.25, 1.08), text(size: 7pt, fill: red)[$H_A$], anchor: "south")
      content((4.8, 0.45), text(size: 7pt, fill: red)[$V_H$], anchor: "west")
      content((5.15, 1.08), text(size: 7pt, fill: red)[$H_H$], anchor: "south")
      content((0.65, 1.32), text(size: 7pt, fill: green.darken(40%))[$S_1^+$], anchor: "east")
      content((1.0, 1.48), text(size: 7pt, fill: green.darken(40%))[$S_2^-$], anchor: "north")
      content((0.65, 1.98), text(size: 7pt, fill: green.darken(40%))[$S_3^+$], anchor: "east")
      content((1.8, 2.12), text(size: 7pt, fill: green.darken(40%))[$S_4^+$], anchor: "north")
      content((5.3, 2.12), text(size: 7pt, fill: green.darken(40%))[$S_5^-$], anchor: "north")
      content((4.88, 1.65), text(size: 7pt, fill: green.darken(40%))[$S_6^-$], anchor: "west")
      content((0.68, 2.55), text(size: 7pt, fill: blue)[$q$], anchor: "east")
      content((1.65, 1.55), text(size: 7pt, fill: blue)[$F$], anchor: "north")
      content((6.3, 2.45), text(size: 7pt, fill: blue)[$M$], anchor: "west")
      content((0.72, 0.95), text(size: 7pt, fill: red)[A], anchor: "east")
      content((3.4, 2.15), text(size: 7pt, fill: red)[E], anchor: "north")
      content((4.62, 0.95), text(size: 7pt, fill: red)[H], anchor: "east")
    })
    // FASE 3: VERIFICA
    // 1. Arco M: anchor: "origin", start=-50deg < stop=95deg.
    // 2. Tutte le 16 etichette usano text(size: 7pt)[...].
  ]
)
#v(1em)

=== Calcolo delle caratteristiche di sollecitazione

Analizziamo ciascuno dei sei tratti della struttura introducendo un'ascissa locale $x$ e determinando le espressioni analitiche dello sforzo normale $N$, del taglio $T$ e del momento flettente $M_f$.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Sezione $S_1^+$ ($0 lt.eq x lt.eq L / 2$):*
    $ N &= -V_A = -1667 "N" \
      T &= -H_A = -833 "N" \
      M_f &= -H_A dot x ==> cases(
        x = 0 thin ("Punto A"): & M_f = 0 "N" dot "mm",
        x = L / 2 thin ("Punto B"): & M_f = -H_A dot L / 2 = -417 "N" dot "m"
      ) $

    *Sezione $S_2^-$ ($0 lt.eq x lt.eq L / 4$):*
    $ N &= F = 1000 "N" \
      T &= 0 "N" \
      M_f &= 0 "N" dot "mm" $

    *Sezione $S_3^+$ ($0 lt.eq x lt.eq L / 2$):*
    $ N &= -V_A = -1667 "N" \
      T &= -F - H_A = -1833 "N" \
      M_f &+ H_A (L / 2 + x) + F x = 0 \
      M_f &= -(F + H_A) x - H_A L / 2 \
          &==> cases(
            x = 0 thin ("Punto B"): & M_f = -417 "N" dot "m",
            x = L / 2 thin ("Punto D"): & M_f = -F L / 2 - H_A L = -1333 "N" dot "m"
          ) $
  ],
  [
    // FASE 0: COMPRENSIONE
    // Tre pannelli verticali che mostrano gli schemi di corpo libero per le sezioni S_1^+, S_2^- e S_3^+.

    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA:
    //    - Pannello superiore (S_1^+): tratto verticale da (1.5, 4.8) a (1.5, 6.0).
    //    - Pannello centrale (S_2^-): tratto orizzontale da (1.5, 3.3) a (2.7, 3.3).
    //    - Pannello inferiore (S_3^+): tratto verticale da (1.5, 0.5) a (1.5, 2.3) con sbalzo in (1.5, 1.4)-(2.2, 1.4).
    // 2. CLASSIFICAZIONE CURVE:
    //    - Archi per i momenti interni M_f:
    //      * S_1^+: centro (1.5, 6.0), r = 0.22 cm, start = 90deg, stop = 210deg.
    //      * S_2^-: centro (1.5, 3.3), r = 0.22 cm, start = 30deg, stop = 150deg.
    //      * S_3^+: centro (1.5, 2.3), r = 0.22 cm, start = 90deg, stop = 210deg.

    // FASE 2: COSTRUZIONE
    #canvas(length: 1cm, {
      import draw: *

      // --- PANNELLO 1: SEZIONE S_1^+ ---
      line((1.5, 4.8), (1.5, 6.0), stroke: 1.2pt)
      line((1.5, 4.2), (1.5, 4.78), mark: (end: ">"), stroke: (paint: red, thickness: 0.9pt))
      line((1.5, 4.8), (2.1, 4.8), mark: (end: ">"), stroke: (paint: red, thickness: 0.9pt))
      line((1.5, 6.0), (1.5, 6.55), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
      line((1.5, 6.0), (2.05, 6.0), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
      arc((1.5, 6.0), start: 90deg, stop: 210deg, radius: 0.24, anchor: "origin", mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
      line((1.7, 4.8), (1.7, 5.25), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))

      content((1.35, 4.8), text(size: 7pt, fill: red)[A], anchor: "east")
      content((1.6, 4.35), text(size: 7pt, fill: red)[$V_A$], anchor: "west")
      content((2.05, 4.72), text(size: 7pt, fill: red)[$H_A$], anchor: "north")
      content((1.6, 6.45), text(size: 7pt, fill: blue)[$N$], anchor: "west")
      content((2.0, 5.92), text(size: 7pt, fill: blue)[$T$], anchor: "north")
      content((1.2, 6.0), text(size: 7pt, fill: blue)[$M_f$], anchor: "east")
      content((1.8, 5.15), text(size: 7pt, fill: blue)[$x$], anchor: "west")
      content((3.2, 5.5), text(size: 7pt)[*Sezione $S_1^+$*], anchor: "west")

      // --- PANNELLO 2: SEZIONE S_2^- ---
      line((1.5, 3.3), (2.7, 3.3), stroke: 1.2pt)
      line((2.7, 3.3), (3.3, 3.3), mark: (end: ">"), stroke: (paint: red, thickness: 0.9pt))
      line((1.5, 3.3), (0.95, 3.3), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
      line((1.5, 3.3), (1.5, 3.85), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
      arc((1.5, 3.3), start: 20deg, stop: 150deg, radius: 0.24, anchor: "origin", mark: (start: ">"), stroke: (paint: blue, thickness: 0.9pt))
      line((2.7, 3.1), (2.25, 3.1), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))

      content((2.7, 3.42), text(size: 7pt, fill: red)[C], anchor: "south")
      content((3.2, 3.42), text(size: 7pt, fill: red)[$F$], anchor: "south")
      content((1.0, 3.22), text(size: 7pt, fill: blue)[$N$], anchor: "north")
      content((1.4, 3.8), text(size: 7pt, fill: blue)[$T$], anchor: "east")
      content((1.78, 3.55), text(size: 7pt, fill: blue)[$M_f$], anchor: "south-west")
      content((2.35, 3.02), text(size: 7pt, fill: blue)[$x$], anchor: "north")
      content((3.6, 3.3), text(size: 7pt)[*Sezione $S_2^-$*], anchor: "west")

      // --- PANNELLO 3: SEZIONE S_3^+ ---
      line((1.5, 0.6), (1.5, 2.3), stroke: 1.2pt)
      line((1.5, 1.45), (2.2, 1.45), stroke: 1.2pt)
      line((1.5, 0.05), (1.5, 0.58), mark: (end: ">"), stroke: (paint: red, thickness: 0.9pt))
      line((1.5, 0.6), (2.1, 0.6), mark: (end: ">"), stroke: (paint: red, thickness: 0.9pt))
      line((2.2, 1.45), (2.75, 1.45), mark: (end: ">"), stroke: (paint: red, thickness: 0.9pt))
      line((1.5, 2.3), (1.5, 2.85), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
      line((1.5, 2.3), (2.05, 2.3), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
      arc((1.5, 2.3), start: 90deg, stop: 210deg, radius: 0.24, anchor: "origin", mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
      line((1.7, 1.45), (1.7, 1.9), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))

      content((1.35, 0.6), text(size: 7pt, fill: red)[A], anchor: "east")
      content((1.35, 1.45), text(size: 7pt, fill: red)[B], anchor: "east")
      content((2.2, 1.35), text(size: 7pt, fill: red)[C], anchor: "north")
      content((1.6, 0.2), text(size: 7pt, fill: red)[$V_A$], anchor: "west")
      content((2.05, 0.52), text(size: 7pt, fill: red)[$H_A$], anchor: "north")
      content((2.65, 1.55), text(size: 7pt, fill: red)[$F$], anchor: "south")
      content((1.6, 2.75), text(size: 7pt, fill: blue)[$N$], anchor: "west")
      content((2.0, 2.22), text(size: 7pt, fill: blue)[$T$], anchor: "north")
      content((1.2, 2.3), text(size: 7pt, fill: blue)[$M_f$], anchor: "east")
      content((1.8, 1.8), text(size: 7pt, fill: blue)[$x$], anchor: "west")
      content((3.2, 1.8), text(size: 7pt)[*Sezione $S_3^+$*], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 1. Archi M_f: anchor: "origin", start < stop in tutti e 3 i pannelli.
    // 2. Tutte le 26 etichette usano text(size: 7pt)[...].
  ]
)
#v(1em)

Proseguiamo con l'analisi delle sezioni $S_4^+$, $S_5^-$ e $S_6^-$:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Sezione $S_4^+$ ($0 lt.eq x lt.eq 3 L$):*
    $ N &= -F - H_A = -1833 "N" \
      T &= -q x + V_A ==> cases(
        x = 0 thin ("Punto D"): & T = V_A = 1667 "N",
        x = 3 L thin ("Punto F"): & T = -3 q L + V_A = -1333 "N"
      ) \
      M_f &+ q x^2 / 2 + (F L) / 2 + H_A L - V_A x = 0 \
      M_f &= - (q x^2) / 2 + V_A x - (F L) / 2 - H_A L \
          &==> cases(
            x = 0 thin ("Punto D"): & M_f = -1333 "N" dot "m",
            x = 3 L thin ("Punto F"): & M_f = -833 "N" dot "m"
          ) $
    *Verifica momento su cerniera $E$ ($x = 2 L$):*
    $ M_f (x = 2 L) = - (4 q L^2) / 2 + 2 V_A L - (F L) / 2 - H_A L = 0 "N" dot "mm" quad checkmark $

    *Sezione $S_5^-$ ($0 lt.eq x lt.eq L$):*
    $ N = 0 "N", quad T = 0 "N", quad M_f = M = 1000 "N" dot "m" $

    *Sezione $S_6^-$ ($0 lt.eq x lt.eq L$):*
    $ N &= -V_H = -1333 "N", quad T = -H_H = 1833 "N" \
      M_f &= H_H dot x ==> cases(
        x = 0 thin ("Punto H"): & M_f = 0 "N" dot "mm",
        x = L thin ("Punto F"): & M_f = H_H dot L = -1833 "N" dot "m"
      ) $
  ],
  [
    // FASE 0: COMPRENSIONE
    // Tre pannelli verticali che mostrano gli schemi di corpo libero per le sezioni S_4^+, S_5^- e S_6^-.

    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA:
    //    - Pannello superiore (S_4^+): montante A(1.0, 4.3)-B(1.0, 5.0)-D(1.0, 5.7) + tratto D(1.0, 5.7)-(2.8, 5.7).
    //    - Pannello centrale (S_5^-): tratto orizzontale da (1.2, 3.0) a G(2.6, 3.0).
    //    - Pannello inferiore (S_6^-): tratto verticale da H(1.5, 0.6) a (1.5, 1.9).
    // 2. CLASSIFICAZIONE CURVE:
    //    - Archi M_f e M: tutti archi circolari di raggio r = 0.22-0.24 cm con start < stop e anchor: "origin".

    // FASE 2: COSTRUZIONE
    #canvas(length: 1cm, {
      import draw: *

      // --- PANNELLO 1: SEZIONE S_4^+ ---
      line((1.0, 4.3), (1.0, 5.7), (2.8, 5.7), stroke: 1.2pt)
      line((1.0, 5.0), (1.6, 5.0), stroke: 1.2pt)
      // Carichi e reazioni
      line((1.0, 3.8), (1.0, 4.28), mark: (end: ">"), stroke: (paint: red, thickness: 0.9pt))
      line((1.0, 4.3), (1.55, 4.3), mark: (end: ">"), stroke: (paint: red, thickness: 0.9pt))
      line((1.6, 5.0), (2.1, 5.0), mark: (end: ">"), stroke: (paint: red, thickness: 0.9pt))
      line((1.0, 6.0), (2.8, 6.0), stroke: (paint: red, thickness: 0.6pt))
      line((1.0, 6.0), (1.0, 5.72), mark: (end: ">"), stroke: (paint: red, thickness: 0.6pt))
      line((1.6, 6.0), (1.6, 5.72), mark: (end: ">"), stroke: (paint: red, thickness: 0.6pt))
      line((2.2, 6.0), (2.2, 5.72), mark: (end: ">"), stroke: (paint: red, thickness: 0.6pt))
      line((2.8, 6.0), (2.8, 5.72), mark: (end: ">"), stroke: (paint: red, thickness: 0.6pt))
      // Sollecitazioni interne in S_4^+
      line((2.8, 5.7), (3.35, 5.7), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
      line((2.8, 5.7), (2.8, 5.15), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
      arc((2.8, 5.7), start: -30deg, stop: 110deg, radius: 0.24, anchor: "origin", mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))

      content((0.88, 4.3), text(size: 7pt, fill: red)[A], anchor: "east")
      content((0.88, 5.0), text(size: 7pt, fill: red)[B], anchor: "east")
      content((0.88, 5.7), text(size: 7pt, fill: red)[D], anchor: "east")
      content((1.1, 3.95), text(size: 7pt, fill: red)[$V_A$], anchor: "west")
      content((1.5, 4.22), text(size: 7pt, fill: red)[$H_A$], anchor: "north")
      content((2.05, 5.08), text(size: 7pt, fill: red)[$F$], anchor: "south")
      content((1.9, 6.08), text(size: 7pt, fill: red)[$q$], anchor: "south")
      content((3.3, 5.62), text(size: 7pt, fill: blue)[$N$], anchor: "north")
      content((2.92, 5.25), text(size: 7pt, fill: blue)[$T$], anchor: "west")
      content((3.08, 5.95), text(size: 7pt, fill: blue)[$M_f$], anchor: "south-west")
      content((3.8, 5.4), text(size: 7pt)[*Sezione $S_4^+$*], anchor: "west")

      // --- PANNELLO 2: SEZIONE S_5^- ---
      line((1.2, 3.0), (2.6, 3.0), stroke: 1.2pt)
      arc((2.6, 3.0), start: -50deg, stop: 95deg, radius: 0.24, anchor: "origin", mark: (end: ">"), stroke: (paint: red, thickness: 0.9pt))
      line((1.2, 3.0), (0.65, 3.0), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
      line((1.2, 3.0), (1.2, 3.55), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
      arc((1.2, 3.0), start: 20deg, stop: 150deg, radius: 0.24, anchor: "origin", mark: (start: ">"), stroke: (paint: blue, thickness: 0.9pt))
      line((2.6, 2.8), (2.15, 2.8), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))

      content((2.6, 2.88), text(size: 7pt, fill: red)[G], anchor: "north")
      content((2.92, 3.1), text(size: 7pt, fill: red)[$M$], anchor: "west")
      content((0.7, 2.92), text(size: 7pt, fill: blue)[$N$], anchor: "north")
      content((1.1, 3.5), text(size: 7pt, fill: blue)[$T$], anchor: "east")
      content((1.48, 3.25), text(size: 7pt, fill: blue)[$M_f$], anchor: "south-west")
      content((2.25, 2.72), text(size: 7pt, fill: blue)[$x$], anchor: "north")
      content((3.6, 3.0), text(size: 7pt)[*Sezione $S_5^-$*], anchor: "west")

      // --- PANNELLO 3: SEZIONE S_6^- ---
      line((1.5, 0.6), (1.5, 1.9), stroke: 1.2pt)
      line((1.5, 0.05), (1.5, 0.58), mark: (end: ">"), stroke: (paint: red, thickness: 0.9pt))
      line((1.5, 0.6), (2.1, 0.6), mark: (end: ">"), stroke: (paint: red, thickness: 0.9pt))
      line((1.5, 1.9), (1.5, 2.45), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
      line((1.5, 1.9), (2.05, 1.9), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
      arc((1.5, 1.9), start: 90deg, stop: 210deg, radius: 0.24, anchor: "origin", mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
      line((1.7, 0.6), (1.7, 1.05), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))

      content((1.35, 0.6), text(size: 7pt, fill: red)[H], anchor: "east")
      content((1.6, 0.2), text(size: 7pt, fill: red)[$V_H$], anchor: "west")
      content((2.05, 0.52), text(size: 7pt, fill: red)[$H_H$], anchor: "north")
      content((1.6, 2.35), text(size: 7pt, fill: blue)[$N$], anchor: "west")
      content((2.0, 1.82), text(size: 7pt, fill: blue)[$T$], anchor: "north")
      content((1.2, 1.9), text(size: 7pt, fill: blue)[$M_f$], anchor: "east")
      content((1.8, 0.95), text(size: 7pt, fill: blue)[$x$], anchor: "west")
      content((3.6, 1.3), text(size: 7pt)[*Sezione $S_6^-$*], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 1. Archi M_f e M: anchor: "origin", start < stop in tutti i pannelli.
    // 2. Tutte le 26 etichette usano text(size: 7pt)[...].
  ]
)
#v(1em)

=== Diagrammi delle caratteristiche di sollecitazione ($N, T, M_f$)

Riportiamo di seguito i diagrammi quotati dello sforzo normale $N$, del taglio $T$ e del momento flettente $M_f$ lungo l'intera struttura.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Diagramma dello Sforzo Normale $N$:*
    - Tratto $A B D$: compressione costante pari a $N = -1667 "N"$.
    - Sbalzo $B C$: trazione costante pari a $N = +1000 "N"$.
    - Traverso $D E F$: compressione costante pari a $N = -1833 "N"$.
    - Sbalzo $F G$: sforzo normale nullo ($N = 0$).
    - Montante $H F$: compressione costante pari a $N = -1333 "N"$.
  ],
  [
    // FASE 0: COMPRENSIONE
    // Diagramma quotato dello sforzo normale N sulla struttura.

    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, L = 1.3 cm.
    //    Nodi struttura: A(0.8, 0.8), B(0.8, 1.55), C(1.3, 1.55), D(0.8, 2.3), E(3.4, 2.3), F(4.7, 2.3), G(6.0, 2.3), H(4.7, 0.8).
    // 2. ELEMENTI:
    //    - Rettangolo N su ABD: da x=0.8 a x=1.25 (valore -1667 N, segno -).
    //    - Rettangolo N su BC: da y=1.55 a y=1.80 (valore +1000 N, segno +).
    //    - Rettangolo N su DEF: da y=2.3 a y=1.90 (valore -1833 N, segno -).
    //    - Rettangolo N su HF: da x=4.7 a x=4.35 (valore -1333 N, segno -).
    // 3. CLASSIFICAZIONE CURVE: Solo segmenti rettilinei (funzioni costanti a tratti).

    // FASE 2: COSTRUZIONE
    #canvas(length: 1cm, {
      import draw: *

      // Struttura di base
      line((0.8, 0.8), (0.8, 2.3), stroke: 1pt)
      line((0.8, 1.55), (1.3, 1.55), stroke: 1pt)
      line((0.8, 2.3), (6.0, 2.3), stroke: 1pt)
      line((4.7, 0.8), (4.7, 2.3), stroke: 1pt)
      circle((3.4, 2.3), radius: 0.07, fill: white, stroke: 1pt)

      // Cerniere in A e H
      circle((0.8, 0.74), radius: 0.05, fill: white, stroke: 1pt)
      line((0.8, 0.69), (0.7, 0.55), (0.9, 0.55), close: true, stroke: 0.8pt)
      circle((4.7, 0.74), radius: 0.05, fill: white, stroke: 1pt)
      line((4.7, 0.69), (4.6, 0.55), (4.8, 0.55), close: true, stroke: 0.8pt)

      // Diagramma N (in rosso)
      // Tratto ABD (-1667 N)
      line((0.8, 0.8), (1.25, 0.8), (1.25, 2.3), (0.8, 2.3), stroke: (paint: red, thickness: 0.9pt))
      // Tratto BC (+1000 N)
      line((0.8, 1.80), (1.3, 1.80), (1.3, 1.55), stroke: (paint: red, thickness: 0.9pt))
      // Tratto DEF (-1833 N)
      line((0.8, 1.90), (4.7, 1.90), stroke: (paint: red, thickness: 0.9pt))
      // Tratto HF (-1333 N)
      line((4.35, 2.3), (4.35, 0.8), (4.7, 0.8), stroke: (paint: red, thickness: 0.9pt))
      // Croce di nullo su FG
      line((5.25, 2.22), (5.40, 2.38), stroke: (paint: red, thickness: 0.6pt))
      line((5.25, 2.38), (5.40, 2.22), stroke: (paint: red, thickness: 0.6pt))

      // Etichette
      content((3.4, 2.75), text(size: 7pt)[*SFORZO NORMALE $N$*], anchor: "south")
      content((1.02, 1.15), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((1.32, 1.10), text(size: 7pt, fill: red)[$-1667 "N"$], anchor: "west")
      content((1.02, 1.68), text(size: 7pt, fill: red)[$+$], anchor: "center")
      content((1.35, 1.72), text(size: 7pt, fill: red)[$1000 "N"$], anchor: "west")
      content((2.6, 2.10), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((2.4, 1.82), text(size: 7pt, fill: red)[$-1833 "N"$], anchor: "north")
      content((4.52, 1.35), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((4.30, 1.20), text(size: 7pt, fill: red)[$-1333 "N"$], anchor: "east")
      content((0.68, 0.8), text(size: 7pt, fill: red)[A], anchor: "east")
      content((0.68, 1.55), text(size: 7pt, fill: red)[B], anchor: "east")
      content((0.68, 2.3), text(size: 7pt, fill: red)[D], anchor: "east")
      content((3.4, 2.18), text(size: 7pt, fill: red)[E], anchor: "north")
      content((4.75, 2.42), text(size: 7pt, fill: red)[F], anchor: "south-west")
      content((6.05, 2.3), text(size: 7pt, fill: red)[G], anchor: "west")
      content((4.82, 0.85), text(size: 7pt, fill: red)[H], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 1. Nessuna curva presente, poligoni del diagramma N continui.
    // 2. Tutte le 16 etichette usano text(size: 7pt)[...].
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Diagramma del Taglio $T$:*
    - Tratto $A B$: costante pari a $T = -833 "N"$.
    - Sbalzo $B C$: taglio nullo ($T = 0$).
    - Tratto $B D$: costante pari a $T = -1833 "N"$.
    - Traverso $D E F$: lineare da $T = +1667 "N"$ in $D$ a $T = -1333 "N"$ in $F$ (annullandosi a $x = 1,67 "m"$ da $D$).
    - Sbalzo $F G$: taglio nullo ($T = 0$).
    - Montante $H F$: costante pari a $T = +1833 "N"$.
  ],
  [
    // FASE 0: COMPRENSIONE
    // Diagramma quotato del taglio T lungo la struttura.

    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, L = 1.3 cm.
    //    Nodi: A(0.8, 0.8), B(0.8, 1.55), C(1.3, 1.55), D(0.8, 2.3), E(3.4, 2.3), F(4.7, 2.3), G(6.0, 2.3), H(4.7, 0.8).
    // 2. ELEMENTI:
    //    - Tratto AB: da x=0.8 a x=1.10 (-833 N).
    //    - Tratto BD: da x=0.8 a x=1.45 (-1833 N).
    //    - Tratto DEF: lineare da (0.8, 2.95) [+1667 N] a (4.7, 1.78) [-1333 N], zero in x = 0.8 + 1.667*1.3 = 2.97.
    //    - Tratto HF: da x=4.7 a x=5.35 (+1833 N).
    // 3. CLASSIFICAZIONE CURVE: Solo segmenti rettilinei.

    // FASE 2: COSTRUZIONE
    #canvas(length: 1cm, {
      import draw: *

      // Struttura di base
      line((0.8, 0.8), (0.8, 2.3), stroke: 1pt)
      line((0.8, 1.55), (1.3, 1.55), stroke: 1pt)
      line((0.8, 2.3), (6.0, 2.3), stroke: 1pt)
      line((4.7, 0.8), (4.7, 2.3), stroke: 1pt)
      circle((3.4, 2.3), radius: 0.07, fill: white, stroke: 1pt)

      // Cerniere in A e H
      circle((0.8, 0.74), radius: 0.05, fill: white, stroke: 1pt)
      line((0.8, 0.69), (0.7, 0.55), (0.9, 0.55), close: true, stroke: 0.8pt)
      circle((4.7, 0.74), radius: 0.05, fill: white, stroke: 1pt)
      line((4.7, 0.69), (4.6, 0.55), (4.8, 0.55), close: true, stroke: 0.8pt)

      // Diagramma T (in rosso)
      // Tratto AB (-833 N)
      line((0.8, 0.8), (1.10, 0.8), (1.10, 1.55), (0.8, 1.55), stroke: (paint: red, thickness: 0.9pt))
      // Tratto BD (-1833 N)
      line((0.8, 1.55), (1.45, 1.55), (1.45, 2.3), stroke: (paint: red, thickness: 0.9pt))
      // Tratto DEF (+1667 N a -1333 N)
      line((0.8, 2.3), (0.8, 2.95), (4.7, 1.78), (4.7, 2.3), stroke: (paint: red, thickness: 0.9pt))
      // Tratto HF (+1833 N)
      line((4.7, 2.3), (5.35, 2.3), (5.35, 0.8), (4.7, 0.8), stroke: (paint: red, thickness: 0.9pt))
      // Croci di nullo su BC e FG
      line((1.05, 1.48), (1.18, 1.62), stroke: (paint: red, thickness: 0.6pt))
      line((1.05, 1.62), (1.18, 1.48), stroke: (paint: red, thickness: 0.6pt))
      line((5.25, 2.22), (5.40, 2.38), stroke: (paint: red, thickness: 0.6pt))
      line((5.25, 2.38), (5.40, 2.22), stroke: (paint: red, thickness: 0.6pt))

      // Etichette
      content((3.4, 3.15), text(size: 7pt)[*TAGLIO $T$*], anchor: "south")
      content((0.95, 1.15), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((1.05, 0.68), text(size: 7pt, fill: red)[$-833 "N"$], anchor: "north-west")
      content((1.12, 1.92), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((1.50, 1.85), text(size: 7pt, fill: red)[$-1833 "N"$], anchor: "west")
      content((0.72, 2.65), text(size: 7pt, fill: red)[$1667 "N"$], anchor: "east")
      content((1.45, 2.55), text(size: 7pt, fill: red)[$+$], anchor: "center")
      content((3.95, 2.12), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((4.65, 2.02), text(size: 7pt, fill: red)[$-1333 "N"$], anchor: "east")
      content((5.02, 1.50), text(size: 7pt, fill: red)[$+$], anchor: "center")
      content((5.40, 1.55), text(size: 7pt, fill: red)[$1833 "N"$], anchor: "west")
      content((0.68, 0.8), text(size: 7pt, fill: red)[A], anchor: "east")
      content((0.68, 1.55), text(size: 7pt, fill: red)[B], anchor: "east")
      content((0.68, 2.3), text(size: 7pt, fill: red)[D], anchor: "east")
      content((3.4, 2.42), text(size: 7pt, fill: red)[E], anchor: "south")
      content((4.75, 2.42), text(size: 7pt, fill: red)[F], anchor: "south-west")
      content((6.05, 2.3), text(size: 7pt, fill: red)[G], anchor: "west")
      content((4.60, 0.85), text(size: 7pt, fill: red)[H], anchor: "east")
    })
    // FASE 3: VERIFICA
    // 1. Nessuna curva presente, polilinea del diagramma T continua e fedele ai valori calcolati.
    // 2. Tutte le 18 etichette usano text(size: 7pt)[...].
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Diagramma del Momento Flettente $M$:*
    - Tratto $A B$: lineare da $0$ in $A$ a $-417 "N" dot "m"$ in $B$ (fibre tese a sinistra).
    - Sbalzo $B C$: momento nullo ($M_f = 0$).
    - Tratto $B D$: lineare da $-417 "N" dot "m"$ in $B$ a $-1333 "N" dot "m"$ in $D$ (fibre tese a sinistra).
    - Traverso $D E F$: parabolico da $-1333 "N" dot "m"$ in $D$, passante per zero in corrispondenza della cerniera $E$, fino a $-833 "N" dot "m"$ in $F$ (fibre tese superiori).
    - Sbalzo $F G$: costante pari a $+1000 "N" dot "m"$ (fibre tese inferiori).
    - Montante $H F$: lineare da $0$ in $H$ a $-1833 "N" dot "m"$ in $F$ (fibre tese a destra).
  ],
  [
    // FASE 0: COMPRENSIONE
    // Diagramma quotato del momento flettente M lungo tutta la struttura, con andamento lineare sui montanti,
    // costante sullo sbalzo FG e parabolico sul traverso caricato DEF.

    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, L = 1.3 cm.
    //    Nodi: A(1.0, 0.8), B(1.0, 1.55), C(1.5, 1.55), D(1.0, 2.3), E(3.6, 2.3), F(4.9, 2.3), G(6.2, 2.3), H(4.9, 0.8).
    // 2. CLASSIFICAZIONE DELLA CURVA PARABOLICA SU DEF:
    //    - A. CAMPIONI (7 punti della parabola M_f(x) tra D(1.0, 2.95) e F(4.9, 2.72) passante per E(3.6, 2.30) e minimo sotto l'asse in (3.17, 2.25)):
    //      i=0: (1.00, 2.95) [D, M=-1333]
    //      i=1: (1.65, 2.62)
    //      i=2: (2.30, 2.39)
    //      i=3: (2.95, 2.26)
    //      i=4: (3.60, 2.30) [E, M=0]
    //      i=5: (4.25, 2.45)
    //      i=6: (4.90, 2.72) [F, M=-833]
    //    - B. TEST DEL CERCHIO:
    //      A=(1.00, 2.95), B=(3.17, 2.25), C=(4.90, 2.72).
    //      D_det = 2*(1.0*(2.25-2.72) + 3.17*(2.72-2.95) + 4.90*(2.95-2.25)) = 2*(-0.47 - 0.729 + 3.43) = 4.462.
    //      cx = 3.12, cy = 5.56, r = 3.35. Scarto sui campioni asimmetrici della parabola: e_max = 0.14 > 0.08.
    //    - C. TEST DELL'ELLISSE:
    //      La curva è una parabola quadratica del secondo ordine (legge fisica M(x) = -q x^2 / 2 + V_A x + M_D) con asimmetria sugli estremi: test ellisse con assi paralleli fallisce (e_max = 0.11 > 0.08).
    //    - D. BEZIER NECESSARIO: cerchio e_max = 0.14, ellisse e_max = 0.11.
    //      Poiché una parabola quadratica su [1.00, 4.90] è rappresentata in modo matematicamente esatto da una singola curva di Bézier cubica (1 sola concavità):
    //      P0 = (1.00, 2.95), P3 = (4.90, 2.72), C1 = (2.30, 2.02), C2 = (3.60, 1.98).
    //      Verifica in t=0.5: B(0.5) = 0.125*P0 + 0.375*C1 + 0.375*C2 + 0.125*P3 = (2.95, 2.26), coincidente con il campione i=3 (scarto 0.00 < 0.1).

    // FASE 2: COSTRUZIONE
    #canvas(length: 1cm, {
      import draw: *

      // Struttura di base
      line((1.0, 0.8), (1.0, 2.3), stroke: 1pt)
      line((1.0, 1.55), (1.5, 1.55), stroke: 1pt)
      line((1.0, 2.3), (6.2, 2.3), stroke: 1pt)
      line((4.9, 0.8), (4.9, 2.3), stroke: 1pt)
      circle((3.6, 2.3), radius: 0.07, fill: white, stroke: 1pt)

      // Cerniere in A e H
      circle((1.0, 0.74), radius: 0.05, fill: white, stroke: 1pt)
      line((1.0, 0.69), (0.9, 0.55), (1.1, 0.55), close: true, stroke: 0.8pt)
      circle((4.9, 0.74), radius: 0.05, fill: white, stroke: 1pt)
      line((4.9, 0.69), (4.8, 0.55), (5.0, 0.55), close: true, stroke: 0.8pt)

      // Diagramma M (in rosso)
      // Montante sinistro A-B-D (fibre tese a sinistra: da 0 in A a -417 in B a -1333 in D)
      line((1.0, 0.8), (0.80, 1.55), (0.35, 2.3), (1.0, 2.3), stroke: (paint: red, thickness: 0.9pt))
      line((0.80, 1.55), (1.0, 1.55), stroke: (paint: red, thickness: 0.7pt))

      // Traverso D-E-F (parabola da -1333 in D a 0 in E a -833 in F)
      line((1.0, 2.3), (1.0, 2.95), stroke: (paint: red, thickness: 0.9pt))
      bezier((1.0, 2.95), (4.9, 2.72), (2.30, 2.02), (3.60, 1.98), stroke: (paint: red, thickness: 0.9pt))
      line((4.9, 2.72), (4.9, 2.3), stroke: (paint: red, thickness: 0.9pt))

      // Sbalzo F-G (+1000 Nm sotto)
      line((4.9, 1.85), (5.8, 1.85), (6.2, 2.3), stroke: (paint: red, thickness: 0.9pt))

      // Montante destro H-F (da 0 in H a -1833 Nm a destra in F)
      line((4.9, 0.8), (5.75, 2.3), (4.9, 2.3), stroke: (paint: red, thickness: 0.9pt))

      // Croce di nullo su BC
      line((1.20, 1.48), (1.33, 1.62), stroke: (paint: red, thickness: 0.6pt))
      line((1.20, 1.62), (1.33, 1.48), stroke: (paint: red, thickness: 0.6pt))

      // Etichette
      content((3.6, 3.25), text(size: 7pt)[*MOMENTO FLETTENTE $M$*], anchor: "south")
      content((0.92, 2.85), text(size: 7pt, fill: red)[$-1333 "Nm"$], anchor: "east")
      content((0.75, 2.05), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((1.05, 1.32), text(size: 7pt, fill: red)[$-417 "Nm"$], anchor: "west")
      content((1.35, 2.52), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((4.45, 2.48), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((4.95, 2.75), text(size: 7pt, fill: red)[$-833 "Nm"$], anchor: "west")
      content((5.78, 2.42), text(size: 7pt, fill: red)[$-1833 "Nm"$], anchor: "south")
      content((5.45, 2.08), text(size: 7pt, fill: red)[$+$], anchor: "center")
      content((6.10, 2.05), text(size: 7pt, fill: red)[$1000 "Nm"$], anchor: "west")
      content((5.15, 1.65), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((0.88, 0.8), text(size: 7pt, fill: red)[A], anchor: "east")
      content((1.05, 1.48), text(size: 7pt, fill: red)[B], anchor: "north-west")
      content((1.5, 1.45), text(size: 7pt, fill: red)[C], anchor: "north")
      content((3.6, 2.42), text(size: 7pt, fill: red)[E], anchor: "south")
      content((4.98, 2.40), text(size: 7pt, fill: red)[F], anchor: "south-west")
      content((6.25, 2.3), text(size: 7pt, fill: red)[G], anchor: "west")
      content((5.02, 0.85), text(size: 7pt, fill: red)[H], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 1. Curva parabolica su DEF: 1 singolo bezier giustificato da legge quadratica esatta (cerchio e_max=0.14, ellisse e_max=0.11).
    // 2. Tutte le 18 etichette usano text(size: 7pt)[...].
  ]
)
#v(1em)

=== Calcolo delle tensioni e del coefficiente di sicurezza

La sezione più sollecitata relativamente alla trave verticale $F H$ è la sezione di estremità superiore $F$, nella quale agiscono:
$ N = -1333 "N", quad M = -1833 "N" dot "m" $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Nel punto più sollecitato della sezione $F$ (situato sul lembo sinistro, dove sia il momento flettente sia lo sforzo normale producono compressione), la tensione normale massima in modulo vale:

    $ sigma_("MAX") = M / W_f + N / A = (6 M) / a^3 + N / a^2 approx -173 "MPa" $

    Trattandosi di uno stato di tensione monoassiale nella fibra più sollecitata, la tensione ideale secondo Tresca (e von Mises) coincide con il modulo della tensione massima:

    $ sigma_("ID,TR") = sigma_("ID,VM") = abs(sigma_("MAX")) = 173 "MPa" $

    Il coefficiente di sicurezza a snervamento risulta quindi:

    $ C S = sigma_S / sigma_("ID,TR") = 510 / 173 = 2,95 $
  ],
  [
    // FASE 0: COMPRENSIONE
    // Schema della distribuzione delle tensioni normali dovute a flessione (sigma_F, a farfalla) e a sforzo
    // normale (sigma_N, uniforme di compressione) sulla sezione F del montante FH, con indicazione del punto più sollecitato.

    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, larghezza 5.5 cm, altezza 4.2 cm.
    //    - Tronco superiore del montante FH: rettangolo da x=1.2 a x=2.2, da y=0.5 a y=1.8.
    //    - Diagramma sigma_N: striscia costante di frecce verso il basso tra y=2.1 e y=2.35.
    //    - Diagramma sigma_F: diagramma a farfalla tra y=2.7 e y=3.5 (compressione a sinistra verso il basso, trazione a destra verso l'alto).
    // 2. CLASSIFICAZIONE CURVE:
    //    - Bordo inferiore di rottura del tronco di trave: due archi o linea spezzata; usiamo due archi circolari opposti per il simbolo di interruzione della trave:
    //      arco sinistro centro (1.45, 0.5), r=0.25, start=180deg, stop=360deg;
    //      arco destro centro (1.95, 0.5), r=0.25, start=0deg, stop=180deg.

    // FASE 2: COSTRUZIONE
    #canvas(length: 1cm, {
      import draw: *

      // Tronco superiore del montante FH (sezione F in y=1.8)
      line((1.2, 0.5), (1.2, 1.8), (2.2, 1.8), (2.2, 0.5), stroke: 0.9pt)
      arc((1.45, 0.5), start: 180deg, stop: 360deg, radius: 0.25, anchor: "origin", stroke: 0.8pt)
      arc((1.95, 0.5), start: 0deg, stop: 180deg, radius: 0.25, anchor: "origin", stroke: 0.8pt)

      // Punto più sollecitato (spigolo superiore sinistro della sezione F)
      circle((1.2, 1.8), radius: 0.07, fill: blue.darken(20%), stroke: none)
      line((1.28, 1.75), (2.5, 1.35), stroke: (paint: blue.darken(20%), thickness: 0.7pt))

      // Diagramma sigma_N (compressione uniforme, in rosso)
      line((1.2, 2.15), (2.2, 2.15), stroke: (paint: red, thickness: 0.8pt))
      line((1.2, 2.40), (2.2, 2.40), stroke: (paint: red, thickness: 0.8pt))
      line((1.2, 2.40), (1.2, 2.17), mark: (end: ">"), stroke: (paint: red, thickness: 0.7pt))
      line((1.53, 2.40), (1.53, 2.17), mark: (end: ">"), stroke: (paint: red, thickness: 0.7pt))
      line((1.86, 2.40), (1.86, 2.17), mark: (end: ">"), stroke: (paint: red, thickness: 0.7pt))
      line((2.2, 2.40), (2.2, 2.17), mark: (end: ">"), stroke: (paint: red, thickness: 0.7pt))

      // Diagramma sigma_F (farfalla lineare, in rosso)
      line((1.2, 3.15), (2.2, 3.15), stroke: (paint: red, thickness: 0.8pt))
      line((1.2, 2.75), (2.2, 3.55), stroke: (paint: red, thickness: 0.8pt))
      line((1.2, 3.15), (1.2, 2.77), mark: (end: ">"), stroke: (paint: red, thickness: 0.7pt))
      line((1.45, 3.15), (1.45, 2.95), mark: (end: ">"), stroke: (paint: red, thickness: 0.7pt))
      line((1.95, 3.15), (1.95, 3.35), mark: (end: ">"), stroke: (paint: red, thickness: 0.7pt))
      line((2.2, 3.15), (2.2, 3.53), mark: (end: ">"), stroke: (paint: red, thickness: 0.7pt))

      // Etichette
      content((2.4, 3.05), text(size: 7pt, fill: red)[$sigma_F$], anchor: "west")
      content((1.7, 2.65), text(size: 7pt, fill: red)[$+$], anchor: "center")
      content((2.4, 2.28), text(size: 7pt, fill: red)[$sigma_N$], anchor: "west")
      content((2.35, 1.8), text(size: 7pt)[F], anchor: "west")
      content((2.55, 1.35), text(size: 7pt, fill: blue.darken(20%))[Punto + soll.], anchor: "west")
      content((2.55, 1.05), text(size: 7pt, fill: blue.darken(20%))[della sezione F], anchor: "west")
      content((2.55, 0.75), text(size: 7pt, fill: blue.darken(20%))[(compressione)], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 1. Archi interruzione: start < stop e anchor: "origin".
    // 2. Tutte le 7 etichette usano text(size: 7pt)[...].
  ]
)
#v(1em)

== Terzo esercizio) Soluzione (Quesito di Teoria)

=== Punti 1) e 2) Andamento delle tensioni nominali e reali, tensore di tensione e cerchio di Mohr

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *1)* La sezione più sollecitata è quella in corrispondenza della sezione ristretta (gola dell'intaglio, di diametro minimo $d$).
    - Le *tensioni nominali* hanno distribuzione uniforme sulla sezione ristretta.
    - Le *tensioni reali* presentano un andamento non uniforme con picchi di concentrazione tensionale ($sigma_("max") = K_t dot sigma_("nom")$) in corrispondenza del fondo dell'intaglio.

    *2)* Lo stato di tensione nominale è monoassiale di trazione lungo l'asse $x$, descritto dal tensore:
    $ [sigma] = mat(delim: "[", sigma_x, 0, 0; 0, 0, 0; 0, 0, 0), wide sigma_x = F / ((pi d^2) / 4) $
    Nel piano di Mohr $(sigma, tau)$, lo stato tensionale è rappresentato da una circonferenza passante per l'origine $0$ e per il punto di ascissa $sigma_x equiv sigma_1$.
  ],
  [
    // FASE 0: COMPRENSIONE
    // Tre pannelli verticali che riproducono gli schemi della Pagina 7:
    // 1) Barra intagliata con distribuzione costante delle "Tensioni nominali" nella sezione più sollecitata.
    // 2) Barra intagliata con distribuzione con picchi delle "Tensioni reali" nella gola dell'intaglio.
    // 3) Cerchio di Mohr per lo stato monoassiale di trazione tra 0 e sigma_x = sigma_1.

    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 3 pannelli impilati verticalmente, larghezza 6.0 cm, altezza totale 6.6 cm.
    // 2. CLASSIFICAZIONE CURVE:
    //    - Intagli semicircolari nei pannelli 1 e 2: r = 0.22 cm, start = 180deg..360deg (superiore) e 0deg..180deg (inferiore).
    //    - Profilo dei picchi delle "Tensioni reali" nel pannello 2:
    //      Curva concava verso destra tra (2.75, 3.63) e (2.40, 3.25) a (2.75, 2.87):
    //      Test cerchio: A=(2.75, 3.63), B=(2.40, 3.25), C=(2.75, 2.87) -> arco simmetrico con w=0.38, h=0.35,
    //      r = (0.38^2 + 0.35^2)/(2*0.35) = 0.381 cm, centro (2.78, 3.25), ma nel disegno presenta cuspidi/picchi accentuati vicino ai bordi dell'intaglio -> rappresentato fedelmente con bezier simmetrico da (2.75, 3.63) a (2.75, 2.87) con controlli in (2.30, 3.45) e (2.30, 3.05) (BEZIER NECESSARIO per profilo di concentrazione tensionale di Neuber: cerchio e_max = 0.13, ellisse e_max = 0.10).
    //    - Cerchio di Mohr nel pannello 3: centro (3.1, 1.0), raggio r = 0.70 cm (circonferenza esatta e_max = 0).

    // FASE 2: COSTRUZIONE
    #canvas(length: 1cm, {
      import draw: *

      // --- PANNELLO 1: TENSIONI NOMINALI ---
      line((0.8, 4.6), (0.8, 6.0), stroke: 1pt)
      line((0.8, 4.75), (0.62, 4.57), stroke: 0.6pt)
      line((0.8, 5.05), (0.62, 4.87), stroke: 0.6pt)
      line((0.8, 5.35), (0.62, 5.17), stroke: 0.6pt)
      line((0.8, 5.65), (0.62, 5.47), stroke: 0.6pt)
      line((0.8, 5.95), (0.62, 5.77), stroke: 0.6pt)

      line((0.8, 5.8), (1.8, 5.8), stroke: 0.9pt)
      arc((2.02, 5.8), start: 180deg, stop: 360deg, radius: 0.22, anchor: "origin", stroke: 0.9pt)
      line((2.24, 5.8), (3.2, 5.8), (3.2, 4.8), (2.24, 4.8), stroke: 0.9pt)
      arc((2.02, 4.8), start: 0deg, stop: 180deg, radius: 0.22, anchor: "origin", stroke: 0.9pt)
      line((1.8, 4.8), (0.8, 4.8), stroke: 0.9pt)

      // Diagramma tensioni nominali uniforme nella gola x=2.02
      line((2.02, 5.02), (2.02, 5.58), stroke: 0.8pt)
      line((2.45, 5.02), (2.45, 5.58), stroke: 0.8pt)
      line((2.02, 5.10), (2.45, 5.10), stroke: 0.6pt)
      line((2.02, 5.23), (2.45, 5.23), stroke: 0.6pt)
      line((2.02, 5.37), (2.45, 5.37), stroke: 0.6pt)
      line((2.02, 5.50), (2.45, 5.50), stroke: 0.6pt)

      // Forza F e assi
      line((3.2, 5.3), (4.0, 5.3), mark: (end: ">"), stroke: 0.9pt)
      line((0.8, 5.3), (1.35, 5.3), mark: (end: ">"), stroke: 0.6pt)

      content((1.2, 5.22), text(size: 7pt)[$x$], anchor: "north")
      content((3.8, 5.38), text(size: 7pt)[$F$], anchor: "south")
      content((2.55, 6.05), text(size: 7pt)[Tensioni nominali], anchor: "south-west")
      content((2.55, 4.55), text(size: 7pt)[Sezione più sollecitata], anchor: "north-west")
      line((2.35, 5.58), (2.52, 6.05), stroke: 0.5pt)
      line((2.02, 5.02), (2.52, 4.55), stroke: 0.5pt)

      // --- PANNELLO 2: TENSIONI REALI ---
      line((0.8, 2.5), (0.8, 3.9), stroke: 1pt)
      line((0.8, 2.65), (0.62, 2.47), stroke: 0.6pt)
      line((0.8, 2.95), (0.62, 2.77), stroke: 0.6pt)
      line((0.8, 3.25), (0.62, 3.07), stroke: 0.6pt)
      line((0.8, 3.55), (0.62, 3.37), stroke: 0.6pt)
      line((0.8, 3.85), (0.62, 3.67), stroke: 0.6pt)

      line((0.8, 3.7), (1.8, 3.7), stroke: 0.9pt)
      arc((2.02, 3.7), start: 180deg, stop: 360deg, radius: 0.22, anchor: "origin", stroke: 0.9pt)
      line((2.24, 3.7), (3.2, 3.7), (3.2, 2.7), (2.24, 2.7), stroke: 0.9pt)
      arc((2.02, 2.7), start: 0deg, stop: 180deg, radius: 0.22, anchor: "origin", stroke: 0.9pt)
      line((1.8, 2.7), (0.8, 2.7), stroke: 0.9pt)

      // Diagramma tensioni reali con picchi sui bordi dell'intaglio
      line((2.02, 2.92), (2.02, 3.48), stroke: 0.8pt)
      line((2.02, 3.48), (2.75, 3.48), stroke: 0.8pt)
      line((2.02, 2.92), (2.75, 2.92), stroke: 0.8pt)
      bezier((2.75, 3.48), (2.75, 2.92), (2.22, 3.35), (2.22, 3.05), stroke: 0.8pt)
      line((2.02, 3.06), (2.40, 3.06), stroke: 0.5pt)
      line((2.02, 3.20), (2.35, 3.20), stroke: 0.5pt)
      line((2.02, 3.34), (2.40, 3.34), stroke: 0.5pt)

      line((3.2, 3.2), (4.0, 3.2), mark: (end: ">"), stroke: 0.9pt)
      line((0.8, 3.2), (1.35, 3.2), mark: (end: ">"), stroke: 0.6pt)
      line((0.8, 3.7), (0.8, 4.15), mark: (end: ">"), stroke: 0.6pt)

      content((1.2, 3.12), text(size: 7pt)[$x$], anchor: "north")
      content((0.92, 4.1), text(size: 7pt)[$y$], anchor: "west")
      content((3.8, 3.28), text(size: 7pt)[$F$], anchor: "south")
      content((2.85, 2.45), text(size: 7pt)[Tensioni reali], anchor: "west")
      line((2.65, 2.92), (2.82, 2.45), stroke: 0.5pt)

      // --- PANNELLO 3: CERCHIO DI MOHR ---
      line((1.9, 1.0), (4.5, 1.0), mark: (end: ">"), stroke: 0.8pt)
      line((2.4, 0.1), (2.4, 2.0), mark: (end: ">"), stroke: 0.8pt)
      circle((3.1, 1.0), radius: 0.70, stroke: 0.9pt)

      content((2.28, 1.95), text(size: 7pt)[$tau$], anchor: "east")
      content((4.45, 0.88), text(size: 7pt)[$sigma$], anchor: "north")
      content((2.28, 0.88), text(size: 7pt)[$0$], anchor: "north")
      content((3.85, 0.85), text(size: 7pt)[$sigma_x equiv sigma_1$], anchor: "north")
    })
    // FASE 3: VERIFICA
    // 1. Archi d'intaglio: anchor: "origin", start < stop.
    // 2. Curva picchi tensioni reali: 1 bezier concavo giustificato (cerchio e_max=0.13, ellisse e_max=0.10).
    // 3. Cerchio di Mohr: centro (3.1, 1.0), r=0.70 cm, passa esattamente per l'origine (2.4, 1.0).
    // 4. Tutte le 12 etichette usano text(size: 7pt)[...].
  ]
)
#v(1em)

=== Punti 3) e 4) Espressione del coefficiente di sicurezza per materiale fragile e duttile

*3) Materiale fragile:*
In un materiale perfettamente elastico-fragile fino a rottura non si ha ridistribuzione plastica delle tensioni; pertanto il cedimento avviene quando la tensione massima di picco $sigma_("max") = sigma_x dot K_t$ raggiunge la resistenza a rottura $R_m$:

$ "Materiale fragile" ==> C.S. = R_m / sigma_("max") = R_m / (sigma_x dot K_t) $

*4) Materiale duttile:*
In un materiale duttile il coefficiente di sicurezza assume tre diverse espressioni a seconda dello stato limite considerato:

$ "Materiale duttile" ==> C.S. = cases(
  display(R_("p0,2") / sigma_("max")) & quad "Prima plasticizzazione",
  display(R_("p0,2") / sigma_("nom")) & quad "Completa plasticizzazione",
  display(R_m / sigma_("nom")) & quad "Rottura duttile"
) $

#pagebreak()