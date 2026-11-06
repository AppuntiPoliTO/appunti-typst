#import "@preview/cetz:0.3.4": canvas, draw
#set page(paper: "a4", margin: 2cm)
#set text(lang: "it", size: 11pt)
#set par(justify: true)
#set heading(numbering: none)
#set page(margin: 1.5cm)
#let immagine-originale = image
#let image(nome-file, ..args) = immagine-originale("images/" + nome-file, ..args)
// Nota / osservazione
#let nota(body) = block(
  width: 100%, fill: luma(240), inset: 8pt, radius: 3pt, body,)
#let circ = sym.degree
#let varphi = $phi$
#set page(
  numbering: "1",
  number-align: bottom + right,
)


#set heading(numbering: "1.")
= *Meccanica del Contatto (Teoria di Hertz)*

== Ipotesi del contatto hertziano
// [DA AUDIO]
Si esamina il contatto tra due corpi premuti l'uno contro l'altro in contatto tra di loro attraverso superfici curve, a causa dell'elasticità dei materiali questo contatto avviene fra aree finite e non in un singolo punto o lungo una linea. Nel nostro studio verranno analizzati solo i casi di contatto sfera-sfera e cilindro-cilindro.
L'obiettivo dello studio del contatto hertziano è determinare l'andamento della pressione e l'estensione dell'area di impronta a seguito dell'accostamento sotto carico. Noti questi parametri, è possibile calcolare la distribuzione di tensione all'interno dei corpi solidi per verificare la resistenza strutturale nei punti critici, confrontandola con i limiti di rottura, di snervamento o con le condizioni di innesco per fatica superficiale e usura (come ad esempio il fenomeno del _pitting_ nei fianchi delle ruote dentate).

=== Ipotesi della Teoria di Hertz
<ipotesi-della-teoria-di-hertz>
La formulazione del contatto hertziano si basa su una serie di precise assunzioni geometriche e relative al materiale: 

- *Geometria:* Si analizzano due corpi a contatto modellati analiticamente come superfici tridimensionali (identificate come $Z_1$ e $Z_2$). Si ipotizza che il contatto iniziale avvenga in un punto $O$ non singolare e che esista un piano tangente comune ad entrambe le superfici, nel quale si svilupperà e dilaterà l'impronta al crescere del carico. 

- *Materiale:* Il materiale dei corpi è considerato elastico (si escludono effetti di plasticizzazione nella fase iniziale di accostamento), omogeneo (proprietà chimico-fisiche stabili e costanti in ogni macro-punto del volume, quindi sostanzialmente non poroso) e isotropo (il modulo di Young $E$ e il coefficiente di Poisson $nu$ sono indipendenti dalla direzione di sollecitazione). È inoltre assunta la totale assenza di attrito, ipotizzando che la pressione si scambi unicamente in direzione normale al piano tangente, senza scorrimenti. 

- *Dimensionalità dell'Area:* Si verifica, a posteriori, che la superficie di contatto formatasi sia sufficientemente piccola rispetto ai raggi di curvatura dei corpi affinché lo stato tensionale locale non interferisca con quello globale dell'intera struttura, ma non così infinitesima da generare singolarità tensionali, cioè in modo che non si possa definire una misura di tensione locale nel punto di contatto.

// [DA AUDIO]


#grid(
  columns: (0.7fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [*Superfici $Z_1$ e $Z_2$ a contatto* \
   A livello locale, la geometria delle due superfici può essere modellata tramite due apparenti ellissoidi, identificando per ciascuno due curvature sui rispettivi piani principali. Si definisce un sistema di riferimento locale in cui il punto di primo contatto $O$ è l'origine; l'asse $z$ rappresenta la direzione normale alle superfici (lungo la quale si sviluppa la pressione), mentre il piano $x y$ è il piano di tangenza su cui andrà a formarsi l'impronta di contatto.
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  // Assi cartesiani
  line((0, 0), (-3.5, -1.75), mark: (end: ">"), stroke: 1pt)
  line((0, 0), (4, 0), mark: (end: ">"), stroke: 1pt)
  line((0, -3.5), (0, 4), mark: (end: ">"), stroke: 1pt)

  // Tacca di riferimento sull'asse z inferiore
  line((-0.15, -3.1), (0.15, -3.1), stroke: 1pt)

  // SUPERFICIE SUPERIORE Z1 (Sfera)
  // Profilo esterno (arco di cerchio perfetto, metà inferiore)
  arc((0, 2.2), start: 180deg, stop: 360deg, radius: 2.2, anchor: "origin", stroke: 1pt)
  
  // Bordo ellittico superiore (sezione orizzontale, curvatura regolarizzata)
  bezier((-2.2, 2.2), (2.2, 2.2), (-2.2, 1.1), (2.2, 1.1), stroke: 1pt) // metà anteriore continua
  bezier((2.2, 2.2), (-2.2, 2.2), (2.2, 3.3), (-2.2, 3.3), stroke: 1pt) // metà posteriore continua
  
  // Linee di curvatura interne (tangenti esatte all'asse x in O, terminano esattamente sull'ellisse)
  bezier((0, 0), (-1.6, 1.6), (-1.7, 0.6), stroke: (dash: "dashed", thickness: 1pt)) // anteriore
  bezier((0, 0), (1.6, 2.8), (1.0, 0.5), (1.6, 1.7), stroke: (dash: "dashed", thickness: 1pt)) // posteriore

  // SUPERFICIE INFERIORE Z2 (Sfera)
  // Profilo esterno (arco di cerchio perfetto, metà superiore)
  arc((0, -2.2), start: 0deg, stop: 180deg, radius: 2.2, anchor: "origin", stroke: 1pt)
  
  // Bordo ellittico inferiore (sezione orizzontale, curvatura regolarizzata)
  bezier((-2.2, -2.2), (2.2, -2.2), (-2.2, -3.3), (2.2, -3.3), stroke: 1pt) // metà anteriore continua
  bezier((2.2, -2.2), (-2.2, -2.2), (2.2, -1.1), (-2.2, -1.1), stroke: (dash: "dashed", thickness: 1pt)) // metà posteriore tratteggiata
  
  // Linee di curvatura interne (tangenti esatte all'asse x in O, terminano esattamente sull'ellisse)
  bezier((0, 0), (-1.6, -2.8), (-1.0, -0.5), (-1.6, -1.7), stroke: (dash: "dashed", thickness: 1pt)) // anteriore
  bezier((0, 0), (1.2, -1.6), (0., 0), (1.2, -0.3), stroke: (dash: "dashed", thickness: 1pt)) // posteriore

  // Etichette
  content((-3.3, -1.3), [$x$])
  content((3.8, -0.3), [$y$])
  content((-0.3, 3.8), [$z$])
  content((0.3, -0.3), [$O$])
  content((-1.1, 1.0), [$Z_1$])
  content((1.5, -1.0), [$Z_2$])
})
  ]
)

#v(1em)


=== Geometria del Contatto e Curvature
<geometria-del-contatto-e-curvature>
Per descrivere la forma dell'area di contatto e l'intensità della pressione, è necessario definire la curvatura locale delle superfici. Ogni superficie solida, nell'intorno del punto di contatto, presenta curvature principali nei due piani ortogonali. La curvatura principale, che in letteratura corrisponde al reciproco del diametro (ovvero la metà del reciproco del raggio di curvatura), si definisce separatamente per il Corpo 1 e per il Corpo 2.

// [DA AUDIO]
Da qui l'introduzione del termine $1/2$ nelle formule. Inoltre, nei pedici delle curvature la coordinata $z$ è volutamente omessa in quanto è la direzione normale comune a tutti i piani di sezione.
#pagebreak()
*Superficie $Z_1$* \
#grid(
  columns: (0.7fr, 1fr,),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    #box((canvas(length: 1cm, {
    import draw: *

  // Assi cartesiani
  line((0, 0), (-3.5, -1.75), mark: (end: ">"), stroke: 1pt)
  line((0, 0), (4, 0), mark: (end: ">"), stroke: 1pt)
  line((0, 0), (0, 3.5), mark: (end: ">"), stroke: 1pt)

  arc((0, 2.2), start: 180deg, stop: 360deg, radius: 2.2, anchor: "origin", stroke: 1pt)
  bezier((0, 0), (-1.6, 1.6), (-1.7, 0.6), stroke: (dash: "dashed", thickness: 1pt)) // anteriore
  bezier((0, 0), (1.6, 2.8), (1.0, 0.5), (1.6, 1.7), stroke: (dash: "dashed", thickness: 1pt)) // posteriore
  bezier((-2.2, 2.2), (2.2, 2.2), (-2.2, 1.1), (2.2, 1.1), stroke: 1pt) // metà anteriore continua
  bezier((2.2, 2.2), (-2.2, 2.2), (2.2, 3.3), (-2.2, 3.3), stroke: 1pt) // metà posteriore continua
  content((-1, 1.0), [$Z_1$])
  content((-3.3, -1.3), [$x$])
  content((3.8, -0.3), [$y$])
  content((0.3, 3.5), [$z$])
  content((0.3, -0.3), [$O$])
  
}))) 
  ],
  move(dy: -8pt)[
  #canvas(length: 1cm, {
  import draw: *

  // ================= GRAFICO SINISTRO (Piano y-z) =================
  
  // Assi cartesiani
  line((0, 0), (3, 0), mark: (end: ">"), stroke: 1pt) // Asse y
  line((0, 0), (0, 3.5), mark: (end: ">"), stroke: 1pt) // Asse z
  
  // Profilo della superficie z1 (parabola esatta z = 0.25*y^2)
  // Estremi in y = -2.4 e y = 2.4. Punti di controllo calcolati per la parabola perfetta.
  arc((0, 2.2), start: 180deg, stop: 360deg, radius: 2.2, anchor: "origin", stroke: 1pt)
  
  // Raggio di curvatura R1y (dal centro di curvatura z=2.0 alla curva in y=1.2)
  line((0, 2.0), (1.2, 0.36), mark: (end: ">"), stroke: 0.6pt)
  
  // Etichette grafico sinistro
  content((2.8, -0.4), [$y$])
  content((0.3, 3.3), [$z$])
  content((-0.3, -0.4), [$bold(O)$])
  content((-2.4, 1.8), [$bold(z)_1$])
  content((0.95, 1.45), [$R_(1y)$])


  // ================= GRAFICO DESTRO (Piano x-z) =================
  
  // Assi cartesiani (Origine traslata a x=7)
  line((7, 0), (4, 0), mark: (end: ">"), stroke: 1pt) // Asse x (punta a sinistra)
  line((7, 0), (7, 3.5), mark: (end: ">"), stroke: 1pt) // Asse z
  
  // Profilo della superficie z1 (parabola esatta z = 0.4*x^2, più stretta)
  // Estremi in x = -1.9 e x = 1.9 rispetto al centro.
  arc((7,3.2), 
    start: -20deg, 
    stop: -160deg, 
    radius: (1.5, 3.2), 
    anchor: "origin"
  )
  
  
  // Raggio di curvatura R1x (dal centro di curvatura z=1.25 alla curva in dx=0.9)
  line((7, 1.25), (7.63, 0.324), mark: (end: ">"), stroke: 0.6pt)
  
  content((7.7, 1.1), [$R_(1x)$])
  content((4.2, -0.4), [$x$])
  content((7.3, 3.3), [$z$])
  content((6.7, -0.4), [$bold(O)$])
  content((5.05, 1.7), [$bold(z)_1$])
  
})
  ]
)
Per la superficie 1, indichiamo con $alpha_x$ e $alpha_y$ rispettivamente la curvatura massima e minima, definite perciò curvature principali per un intorno infinitesimo del punto O:
$ alpha_x = 1 / 2 1 / R_(1 x) quad quad ==> quad quad "curvatura massima" $  
$ alpha_y = 1 / 2 1 / R_(1 y) quad quad ==> quad quad "curvatura minima" $ 

#v(1em)

*Superficie $Z_2$* \


#v(3em)

#grid(
  columns: (0.7fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    #box((canvas(length: 1cm, {
    import draw: *
   // Assi cartesiani
  line((0, 0), (-3.5, -1.75), mark: (end: ">"), stroke: 1pt)
  line((0, 0), (4, 0), mark: (end: ">"), stroke: 1pt)
  line((0, -2), (0, 2), mark: (end: ">"), stroke: 1pt)
  content((0.6, -1.0), [$Z_2$])
  arc((0, -2.2), start: 0deg, stop: 180deg, radius: 2.2, anchor: "origin", stroke: 1pt)
  // Bordo ellittico inferiore (sezione orizzontale, curvatura regolarizzata)
  bezier((-2.2, -2.2), (2.2, -2.2), (-2.2, -3.3), (2.2, -3.3), stroke: 1pt) // metà anteriore continua
  bezier((2.2, -2.2), (-2.2, -2.2), (2.2, -1.1), (-2.2, -1.1), stroke: (dash: "dashed", thickness: 1pt)) // metà posteriore tratteggiata
  
  // Linee di curvatura interne (tangenti esatte all'asse x in O, terminano esattamente sull'ellisse)
  bezier((0, 0), (-1.6, -2.8), (-1.0, -0.5), (-1.6, -1.7), stroke: (dash: "dashed", thickness: 1pt)) // anteriore
  bezier((0, 0), (1.2, -1.6), (0., 0), (1.2, -0.3), stroke: (dash: "dashed", thickness: 1pt)) // posteriore

  content((0.3, 2.0), [$z$])
})))
  ],
  move(dy: -13pt)[
    #canvas(length: 1cm, {
  import draw: *

  // ================= GRAFICO SINISTRO (Piano y-z) =================
  
  // Assi cartesiani
  line((0, 0), (3, 0), mark: (end: ">"), stroke: 1pt) // Asse y
  line((0, -2.1), (0, 2), mark: (end: ">"), stroke: 1pt) // Asse z
  
  
  // Profilo della superficie z1 (parabola esatta z = 0.25*y^2)
  // Estremi in y = -2.4 e y = 2.4. Punti di controllo calcolati per la parabola perfetta.
  arc((0, -2.2), start: 0deg, stop: 180deg, radius: 2.2, anchor: "origin", stroke: 1pt)
  
  // Raggio di curvatura R1y (dal centro di curvatura z=2.0 alla curva in y=1.2)
  line((0, -2.0), (1.2, -0.36), mark: (end: ">"), stroke: 0.6pt)
  
  // Etichette grafico sinistro
  content((2.8, -0.4), [$y$])
  content((0.3, 2.0), [$z$])
  content((-0.3, 0.4), [$bold(O)$])
  content((-2.4, -1.8), [$bold(z)_1$])
  content((0.95, -1.45), [$R_(2y)$])


  // ================= GRAFICO DESTRO (Piano x-z) =================
  
  // Assi cartesiani (Origine traslata a x=7)
  line((7, 0), (4, 0), mark: (end: ">"), stroke: 1pt) // Asse x (punta a sinistra)
  line((7, -2.1), (7, 2), mark: (end: ">"), stroke: 1pt) // Asse z
  
  // Profilo della superficie z1 (parabola esatta z = 0.4*x^2, più stretta)
  // Estremi in x = -1.9 e x = 1.9 rispetto al centro.
  arc((7,-3.2), 
    start: -20deg, 
    stop: -160deg, 
    radius: (1.5, -3.2), 
    anchor: "origin"
  )
  
  // Raggio di curvatura R1x (dal centro di curvatura z=1.25 alla curva in dx=0.9)
  line((7, -1.25), (7.7, -0.324), mark: (end: ">"), stroke: 0.6pt)
  
  // Etichette grafico destro
  content((4.2, -0.4), [$x$])
  content((7.3, 2.0), [$z$])
  content((6.7, 0.4), [$bold(O)$])
  content((5.2, -1.2), [$bold(z)_2$])
  content((7.7, -1.1), [$R_(2x)$])
})
  ]
)
Analogamente, per la superficie 2 definiamo le curvature $beta_x$ e $beta_y$:
$ beta_x = 1 / 2 1 / R_(2 x) quad quad ==> quad quad "curvatura massima" $  
$ beta_y = 1 / 2 1 / R_(2 y) quad quad ==> quad quad "curvatura minima" $ 

#v(1em)
#pagebreak()
=== Convenzione di segno
Nel valutare la geometria relativa dei due corpi, la teoria adotta una specifica convenzione di segno per calcolare gli spostamenti necessari all'accostamento.


#grid(
  columns: (1.6fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + top),
  [- *Corpo 1 convesso, corpo 2 convesso*: Entrambi i raggi di curvatura sono considerati positivi, poiché i centri di curvatura si trovano all'interno dei rispettivi corpi. Se il corpo è convesso (si sviluppa dal lato opposto rispetto al piano tangente), la sua curvatura è positiva. Geometricamente, ciò implica che le superfici convesse si trovino da lati opposti rispetto al piano di tangenza condiviso nel punto di contatto.
    $ alpha_x &= + 1/2 1/R_(1 x) \ 
      beta_x &= + 1/2 1/R_(2 x) $
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  // ================= GRAFICO SINISTRO (Piano y-z) =================
  
  // Assi cartesiani
  line((0, 0), (-3, 0), mark: (end: ">"), stroke: 1pt) // Asse y
  line((0, -2.1), (0, 3.5), mark: (end: ">"), stroke: 1pt) // Asse z
  
  
  // Profilo della superficie z1 (parabola esatta z = 0.25*y^2)
  // Estremi in y = -2.4 e y = 2.4. Punti di controllo calcolati per la parabola perfetta.
  arc((0, -2.2), start: 0deg, stop: 180deg, radius: 2.2, anchor: "origin", stroke: 1pt)
  arc((0, 2.2), start: 180deg, stop: 360deg, radius: 2.2, anchor: "origin", stroke: 1pt)
  
  // Raggio di curvatura R1y (dal centro di curvatura z=2.0 alla curva in y=1.2)
  line((0, 2.0), (1.2, 0.36), mark: (end: ">"), stroke: 0.6pt)
  
  // Raggio di curvatura R1y (dal centro di curvatura z=2.0 alla curva in y=1.2)
  line((0, -2.0), (-1.2, -0.36), mark: (end: ">"), stroke: 0.6pt)
  
  // Etichette grafico sinistro
  content((-2.8, -0.4), [$x$])
  content((0.3, 3.3), [$z$])
  content((-0.3, 0.4), [$bold(O)$])
  content((-0.95, -1.45), [$R_(2x)$])
  content((0.95, 1.45), [$R_(x)$])
})
  ]
)

#v(1em)



#grid(
  columns: (1.6fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + top),
  [
   - *Corpo 1 convesso, corpo 2 concavo*: Il raggio di curvatura del corpo concavo viene considerato negativo. Al contrario, se uno dei due corpi presenta una superficie avvolgente e concava che si avvicina alla superficie del primo corpo agevolando il contatto con una minore deformazione, la sua curvatura viene inserita nelle equazioni con segno negativo. In questa configurazione, la superficie concava si sviluppa avvolgendo il piano di tangenza comune, "abbracciando" così la superficie convessa del primo corpo. Il segno negativo per il corpo concavo riflette il fatto che le superfici sono già ravvicinate: l'accostamento richiede quindi una forza minore rispetto al caso di due corpi convessi.
    $ alpha_x &= + 1/2 1/R_(1 x) $
    $ beta_x = - 1/2 1/R_(2 x) $
  ],
  [ #canvas(length: 1.1cm, {
  import draw: *

  // RIEMPIMENTO (Corpo grigio)
  // Arco di raggio intermedio (2.75) e spessore esatto (0.5cm) per riempire l'area senza usare path()
  arc((3, 3.5), start: 225deg, stop: 315deg, radius: 2.75, anchor: "origin", stroke: (paint: rgb("a0a5a9"), thickness: 0.5cm, cap: "butt"))

  // CONTORNI CORPO GRIGIO
  arc((3, 3.5), start: 225deg, stop: 315deg, radius: 2.5, anchor: "origin", stroke: 1pt)
  arc((3, 3.5), start: 225deg, stop: 315deg, radius: 3.0, anchor: "origin", stroke: 1pt)
  line((1.232, 1.732), (0.879, 1.379), stroke: 1pt)
  line((4.768, 1.732), (5.121, 1.379), stroke: 1pt)

  // ASSI
  line((3, 1), (0.5, 1), mark: (end: ">"), stroke: 1pt)
  content((0.5, 0.6), [$x$])

  line((3, 1), (3, 5), mark: (end: ">"), stroke: 1pt)
  content((3.3, 4.8), [$z$])

  // RAGGI DI CURVATURA E CIRCONFERENZE OSCULATRICI
  // R2x (Sinistra, raggio maggiore per il bordo)
  line((3, 4), (1.75, 1.335), mark: (end: ">"), stroke: 1pt)
  content((2.0, 3.2), [$R_(2x)$])
  

  arc((3,4.2), 
    start: -20deg, 
    stop: -160deg, 
    radius: (1.5, 3.2), 
    anchor: "origin"
  )
  
  
  // Raggio di curvatura R1x (dal centro di curvatura z=1.25 alla curva in dx=0.9)
  line((3, 2.25), (3.67, 1.324), mark: (end: ">"), stroke: 0.6pt)
  
  content((3.6, 1.94), [$R_(1x)$])
  
  
})
  ]
)
#v(1em)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    *Ellisse di contatto*\
 Nella realtà, quando i corpi sono premuti uno contro l’altro non c’è compenetrazione, ma si genera una superficie di contatto che la teoria di Hertz dimostra essere ancora un’ellisse chiamata ellisse di contatto.
  ],
   move(dx: 13pt)[
    #canvas(length: 0.8cm, {
  import draw: *

  // Assi cartesiani
  
  line((0, 0), (-3.5, -1.75), mark: (end: ">"), stroke: 1pt)
  line((0, 0), (4, 0), mark: (end: ">"), stroke: 1pt)
  line((0, -3.5), (0, 4), mark: (end: ">"), stroke: 1pt)

  // Tacca di riferimento sull'asse z inferiore
  line((-0.15, -3.1), (0.15, -3.1), stroke: 1pt)

  // SUPERFICIE SUPERIORE Z1 (Sfera)
  // Profilo esterno (arco di cerchio perfetto, metà inferiore)
  arc((0, 2.2), start: 180deg, stop: 360deg, radius: 2.2, anchor: "origin", stroke: 1pt)
  
  // Bordo ellittico superiore (sezione orizzontale, curvatura regolarizzata)
  arc((0,2.2), 
    start: -0deg, 
    stop: 360deg, 
    radius: (2.2, 0.8), 
    anchor: "origin"
  )  
  arc((0,-1.25), 
    start: 180deg, 
    stop: 360deg, 
    radius: (2.2, 0.8), 
    anchor: "origin"
  )
  arc((0, -1.25),
    start: 180deg,
    stop: 0deg,
    radius: (2.2, 0.8),
    anchor: "origin",
    name: "mio_arco",
    stroke: (dash: "dashed", thickness: 1pt)
  )
  arc((0, 0.45),
    start: 0deg,
    stop: 360deg,
    radius: (1.3, 0.3),
    anchor: "origin",
    name: "mio_arco",
    stroke: ( thickness: 1.5pt, paint: red.transparentize(40%)),
    fill: gray.transparentize(70%)
  )
  arc((0, -1.25), start: 0deg, stop: 180deg, radius: 2.2, anchor: "origin", stroke: 1pt)

  line((0, 0.95), (3.6, 0.95), stroke: ( thickness: 1pt, paint: black.transparentize(40%)))
  line((3.4, 0.95), (3.4, 0), mark: (end: ">",start:">"), stroke: 1pt)
  // Bordo ellittico inferiore (sezione orizzontale, curvatura regolarizzata)
  
  // Linee di curvatura interne (tangenti esatte all'asse x in O, terminano esattamente sull'ellisse)
  

  // Etichette
  content((3.8, 0.5), [$h$])
  content((-3.3, -1.3), [$x$])
  content((3.8, -0.3), [$y$])
  content((-0.3, 3.8), [$z$])
  content((0.3, -0.3), [$O$])
  content((-1.2, 1.0), [$Z_1$])
  content((1.3, -1.2), [$Z_2$])
})
  ]
)
#v(1em)

== Parametri dell'ellisse di contatto
Uno degli obbiettivi della teoria di Hertz è quella di individuare la dimensione effettiva dell'ellisse di contatto, per farlo introduce un parametro ausiliario di riferimento che tiene conto delle curvature nei due piani principali che chiama $cos(tau)$, questo coefficiente è un valore numerico che non può mai essere minore di 0 o maggiore di 1 e non ha niente a che fare con le tensioni tangenziali, il parametro condensa le informazioni delle curvature ed è definito come:
$ cos(tau) =abs(gamma_x-gamma_y)/((gamma_x+gamma_y))= abs((alpha_x - alpha_y) + (beta_x - beta_y)) / (alpha_x + alpha_y + beta_x + beta_y) $ 
Applicando un carico normale, il contatto evolve: parte inizialmente come un singolo punto (a carico nullo) e si estende progressivamente deformando in modo elastico le superfici. Sebbene la forma generale dell'impronta sia ellittica, in casi particolari legati alla geometria dei corpi, essa può degenerare in un cerchio o in un rettangolo. \ Le dimensioni dei semiassi $a$ e $b$ dell'ellisse di contatto sono funzione di $cos(tau)$ e si calcolano come:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ cases(
      a = a^* dot f, 
      b = b^* dot f
    ) $
  ],
  [
    #canvas(length: 0.95cm, {
  import draw: *

  // Curva tratteggiata (profilo di pressione) - Dietro il vettore
  bezier((-1.25, -2.165), (0.02, 2.85), (-1.25, -0.19), (-0.690, 1.904), stroke: (dash: "dashed", thickness: 1.5pt))
  bezier((0, 2.8), (1.25, 2.165), (0.55, 3.2), (1, 3.1), stroke: (dash: "dashed", thickness: 1.5pt))

  // Ellisse principale (area di contatto) - 4 tratti continui
  bezier((-1.25, -2.165), (1.3, 0), (-0.532, -2.165), (0.610, -1.196), stroke: 1.5pt)
  bezier((1.3, 0), (1.25, 2.165), (1.990, 1.196), (1.968, 2.165), stroke: 1.5pt)
  bezier((1.25, 2.165), (-1.3, 0), (0.532, 2.165), (-0.610, 1.196), stroke: 1.5pt)
  bezier((-1.3, 0), (-1.25, -2.165), (-1.990, -1.196), (-1.968, -2.165), stroke: 1.5pt)

  // Assi di riferimento
  line((-2.3, 0), (3.2, 0), mark: (end: ">"), stroke: 1pt)
  line((1.6, 2.771), (-2.0, -3.503), mark: (end: ">"), stroke: 1pt)

  // Vettore p_max
  line((0, 2.8), (0, 0), mark: (end: ">", scale: 1.5), stroke: 3pt)

  // Linee di quota e riferimenti
  line((-1.25, -2.165), (1.5, -2.165), stroke: 0.6pt)
  line((2.2, 0), (1.15, -2.165), mark: (start: ">", end: ">"), stroke: 0.6pt)
  
  line((-1.3, 0), (-2.9, -2.8), stroke: 0.6pt)
  line((-2.8, -2.6), (-1.5, -2.6), mark: (start: ">", end: ">"), stroke: 0.6pt)

  // Etichette
  content((3.2, 0.3), [$y$], anchor: "south-east")
  content((-1.5, -3.1), [$x$], anchor: "north-west")
  content((-0.3, 1.6), [$p_"max"$], anchor: "east")
  content((1.95, -1.0), [$a$], anchor: "west")
  content((-2.1, -2.5), [$b$], anchor: "south")
})
  ]
)
#v(1em)

Il parametro dimensionale $f$ agisce come termine di scala dell'intera impronta: esso tiene conto del carico normale applicato $F$, della geometria complessiva (espressa dalle curvature $alpha$ e $beta$) e della cedevolezza elastica dei materiali (modulo di Young $E$ e coefficiente di Poisson $nu$). La sua espressione è:
$ f = root(3, (3 F) / (4 (alpha_x + alpha_y + beta_x + beta_y)) ( (1 - nu_alpha^2)/E_alpha + (1 - nu_beta^2)/E_beta )) $
#v(2em)
#align(center)[
#canvas(length: 1cm, {
  import draw: *

  // Griglia - Linee Verticali
  line((0.5, 0), (0.5, 6.5), stroke: 0.6pt)
  line((1.0, 0), (1.0, 6.5), stroke: 0.6pt)
  line((1.5, 0), (1.5, 6.5), stroke: 0.6pt)
  line((2.0, 0), (2.0, 6.5), stroke: 0.6pt)
  line((2.5, 0), (2.5, 6.5), stroke: 0.6pt)
  line((3.0, 0), (3.0, 6.5), stroke: 0.6pt)
  line((3.5, 0), (3.5, 6.5), stroke: 0.6pt)
  line((4.0, 0), (4.0, 6.5), stroke: 0.6pt)
  line((4.5, 0), (4.5, 6.5), stroke: 0.6pt)
  line((5.0, 0), (5.0, 6.5), stroke: 0.6pt)
  line((5.5, 0), (5.5, 6.5), stroke: 0.6pt)
  line((6.0, 0), (6.0, 6.5), stroke: 0.6pt)
  line((6.5, 0), (6.5, 6.5), stroke: 0.6pt)
  line((7.0, 0), (7.0, 6.5), stroke: 0.6pt)
  line((7.5, 0), (7.5, 6.5), stroke: 0.6pt)
  line((8.0, 0), (8.0, 6.5), stroke: 0.6pt)
  line((8.5, 0), (8.5, 6.5), stroke: 0.6pt)
  line((9.0, 0), (9.0, 6.5), stroke: 0.6pt)
  line((9.5, 0), (9.5, 6.5), stroke: 0.6pt)

  // Griglia - Linee Orizzontali
  line((0, 0.5), (10.0, 0.5), stroke: 0.6pt)
  line((0, 1.0), (10.0, 1.0), stroke: 0.6pt)
  line((0, 1.5), (10.0, 1.5), stroke: 0.6pt)
  line((0, 2.0), (10.0, 2.0), stroke: 0.6pt)
  line((0, 2.5), (10.0, 2.5), stroke: 0.6pt)
  line((0, 3.0), (10.0, 3.0), stroke: 0.6pt)
  line((0, 3.5), (10.0, 3.5), stroke: 0.6pt)
  line((0, 4.0), (10.0, 4.0), stroke: 0.6pt)
  line((0, 4.5), (10.0, 4.5), stroke: 0.6pt)
  line((0, 5.0), (10.0, 5.0), stroke: 0.6pt)
  line((0, 5.5), (10.0, 5.5), stroke: 0.6pt)
  line((0, 6.0), (10.0, 6.0), stroke: 0.6pt)

  // Bordo esterno grafico
  rect((0, 0), (10.0, 6.5), stroke: 1.5pt)

  // Curve a* e b* (Bezier per andamenti empirici complessi)
  bezier((0, 0), (4.5, 1.0), (2.0, 0.2), (3.5, 0.6), stroke: 1.5pt)
  bezier((4.5, 1.0), (9.1, 6.5), (6.5, 1.6), (8.2, 3.8), stroke: 1.5pt)

  bezier((0, 6.5), (4.5, 4.0), (1.5, 5.6), (3.0, 4.8), stroke: 1.5pt)
  bezier((4.5, 4.0), (9.65, 0), (6.5, 2.7), (8.2, 1.2), stroke: 1.5pt)

  // Sovrascritture rosse (linee di ricerca valori)
  // Il colore della freccia eredita automaticamente lo stroke in CeTZ
  line((4.5, 0), (4.5, 1.0), mark: (fill:red, end: ">"), stroke: rgb("#FF0000") + 1.5pt)
  line((4.5, 1.0), (4.5, 4.0), mark: (end: ">",fill:red), stroke: rgb("#FF0000") + 1.5pt)
  line((4.5, 4.0), (0, 4.0), mark: (end: ">",fill:red), stroke: rgb("#FF0000") + 1.5pt)
  line((4.5, 1.0), (10, 1.0), mark: (end: ">",fill:red), stroke: rgb("#FF0000") + 1.5pt)

  // Etichette rosse cerchiate

  content((-0.7, 6.5), [$b^*$])
  content((11, 6.5), [$a^*$])

  
  content((5.0, 7.2), [#text(size: 14pt)[Coefficienti $a^*$ e $b^*$ in funzione di $cos tau$]])

  // Valori Asse X (in basso)
  content((0.0, -0.3), [0])
  content((1.0, -0.3), [0.1])
  content((2.0, -0.3), [0.2])
  content((3.0, -0.3), [0.3])
  content((4.0, -0.3), [0.4])
  content((5.0, -0.3), [0.5])
  content((6.0, -0.3), [0.6])
  content((7.0, -0.3), [0.7])
  content((8.0, -0.3), [0.8])
  content((9.0, -0.3), [0.9])
  content((9.7, -0.3), [$cos tau$])

  // Valori Asse Y Sinistro (b*)
  content((-0.4, 0.0), [0.35])
  content((-0.4, 0.5), [0.40])
  content((-0.4, 1.0), [0.45])
  content((-0.4, 1.5), [0.50])
  content((-0.4, 2.0), [0.55])
  content((-0.4, 2.5), [0.60])
  content((-0.4, 3.0), [0.65])
  content((-0.4, 3.5), [0.70])
  content((-0.4, 4.0), [0.75])
  content((-0.4, 4.5), [0.80])
  content((-0.4, 5.0), [0.85])
  content((-0.4, 5.5), [0.90])
  content((-0.4, 6.0), [0.95])
  content((-0.4, 6.5), [1])

  // Valori Asse Y Destro (a*)
  content((10.4, 0.0), [1])
  content((10.4, 0.5), [1.2])
  content((10.4, 1.0), [1.4])
  content((10.4, 1.5), [1.6])
  content((10.4, 2.0), [1.8])
  content((10.4, 2.5), [2.0])
  content((10.4, 3.0), [2.2])
  content((10.4, 3.5), [2.4])
  content((10.4, 4.0), [2.6])
  content((10.4, 4.5), [2.8])
  content((10.4, 5.0), [3.0])
  content((10.4, 5.5), [3.2])
  content((10.4, 6.0), [3.4])
  content((10.4, 6.5), [3.6])
})]
// TODO: inserire figura della slide 1 del PDF, 'Coefficienti a* e b* in funzione di cos(tau)'
// didascalia suggerita: Grafici per la determinazione dei coefficienti a* e b* per l'ellisse di contatto in funzione del parametro ausiliario cos(tau).
// #align(center, image("fig_slide_1_a.png", width: 70%))


==== Distribuzione delle pressioni
La distribuzione della pressione all'interno dell'area ellittica non è uniforme, ma ricalca la geometria di un semi-ellissoide: la pressione è massima al centro dell'impronta (punto di primo accostamento) e si annulla ai bordi. La pressione in un generico punto $(x, y)$ si calcola come:
$ p(x,y) = p_"max" sqrt(1 - x^2/a^2 - y^2/b^2) $

La pressione media si ricava rapportando il carico all'area, ovvero $p_"media" = F / (pi a b)$. Poiché il volume di un emi-ellissoide è pari ai due terzi del cilindro circoscritto, l'integrazione del profilo di pressione mostra che il valore massimo al centro è pari a $1.5$ volte la pressione media:
$ p_"max" = 3/2 F / (pi a b) = 1.5 p_"media" $

Gran parte delle applicazioni pratiche ricade in due casi particolari notevoli: il contatto *sfera-sfera* e il contatto *cilindro-cilindro*. 

== Contatto sfera-sfera
A causa della perfetta simmetria sferica, le curvature nei due piani principali per ciascun corpo coincidono:\ $alpha_x = alpha_y = 1/d$ e $beta_x = beta_y = 1/D$

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Essendo le curvature identiche per asse, il numeratore del parametro di Hertz si annulla, imponendo $cos(tau) = 0$. Questo fa sì che i coefficienti $a^*$ e $b^*$ assumano entrambi valore unitario:
    $ a^* = b^* = 1 quad arrow.r.long quad a = b = f $ 
  ],
  [#canvas(length: 0.6cm, {
import draw: *
circle((0, -2.4), radius: 2.4, stroke: 1pt)
arc((0, -2.4), start: 0deg, stop: 180deg, radius: (2.4, 0.7), anchor: "origin", stroke: (dash: "dashed", thickness: 1pt))
arc((0, -2.4), start: 180deg, stop: 360deg, radius: (2.4, 0.7), anchor: "origin", stroke: 1pt)
circle((0, 1.2), radius: 1.2, stroke: 1pt)
arc((0, 1.2), start: 0deg, stop: 180deg, radius: (1.2, 0.35), anchor: "origin", stroke: (dash: "dashed", thickness: 1pt))
arc((0, 1.2), start: 180deg, stop: 360deg, radius: (1.2, 0.35), anchor: "origin", stroke: 1pt)
line((0, 0), (-2.5, -1.5), mark: (end: ">"), stroke: 1pt)
line((0, 0), (4, 0), mark: (end: ">"), stroke: 1pt)
line((0, 2.4), (0, 5.2), mark: (end: ">"), stroke: 1pt)
line((0, 3.8), (0, 2.4), mark: (end: ">"), stroke: red + 1pt)
line((0, -6.2), (0, -4.8), mark: (end: ">"), stroke: red + 1pt)
content((-2.8, -1.5), [x])
content((4.4, 0), [y])
content((0.4, 5.2), [z])
content((0.4, 3.1), text(fill: red)[F])
content((0.4, -5.5), text(fill: red)[F])
})
  ]
)
#v(1em)

L'ellisse degenera in un cerchio perfetto di raggio $a = f$. L'area di contatto diventa pari a $pi a^2$, semplificando la pressione massima in:
$ p_"max" = (3 F) / (2 pi a^2) quad p_"max" = F / pi a^2 $
#pagebreak()
== Contatto cilindro-cilindro
Nel contatto tra due cilindri appoggiati con assi paralleli, l'impronta si sviluppa per la loro intera lunghezza $L$.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
     #canvas(length: 1cm, {
  import draw: *

  // --- GUSCIO SUPERIORE ---
  // Arco frontale
  arc((-1.62, 0.56), start: 180deg, stop: 360deg, radius: 1.15, anchor: "origin", stroke: 1.5pt)
  // Bordi longitudinali superiori
  line((-2.77, 0.56), (0.15, 1.72), stroke: 1.5pt)
  line((-0.47, 0.56), (2.45, 1.72), stroke: 1.5pt)
  // Arco posteriore (metà sinistra tratteggiata, metà destra piena)
  arc((1.30, 1.72), start: 180deg, stop: 270deg, radius: 1.15, anchor: "origin", stroke: (dash: "dashed", thickness: 1.5pt))
  arc((1.30, 1.72), start: 270deg, stop: 360deg, radius: 1.15, anchor: "origin", stroke: 1.5pt)

  // --- LINEA DI CONTATTO CENTRALE ---
  line((-1.62, -0.59), (1.30, 0.57), stroke: 1.5pt)

  // --- GUSCIO INFERIORE ---
  // Arco frontale
  arc((-1.62, -1.74), start: 0deg, stop: 180deg, radius: 1.15, anchor: "origin", stroke: 1.5pt)
  // Bordo longitudinale destro
  line((-0.47, -1.74), (2.45, -0.58), stroke: 1.5pt)
  // Bordo longitudinale sinistro (visibile all'esterno, tratteggiato all'interno)
  line((-2.77, -1.74), (-0.91, -1.00), stroke: 1.5pt)
  line((-0.91, -1.00), (0.15, -0.58), stroke: (dash: "dashed", thickness: 1.5pt))
  // Arco posteriore (metà destra piena, metà sinistra tratteggiata)
  arc((1.30, -0.58), start: 0deg, stop: 90deg, radius: 1.15, anchor: "origin", stroke: 1.5pt)
  arc((1.30, -0.58), start: 90deg, stop: 180deg, radius: 1.15, anchor: "origin", stroke: (dash: "dashed", thickness: 1.5pt))

  // --- ASSI CARTESIANI ---
  // Asse x
  line((0, 0), (-3.30, -1.16), mark: (end: ">", size: 0.25), stroke: 1.1pt)
  // Asse y
  line((0, 0), (3.00, -0.25), mark: (end: ">", size: 0.25), stroke: 1.1pt)
  // Asse z
  line((0, 0), (0, 2.55), mark: (end: ">", size: 0.25), stroke: 1.1pt)

  // --- VETTORI FORZA F ---
  // Forza superiore (verso il basso)
  line((-1.62, 2.05), (-1.62, 0.42), mark: (end: ">", fill: black, size: 0.35), stroke: 2.4pt)
  // Forza inferiore (verso l'alto)
  line((-1.62, -2.35), (-1.62, -0.82), mark: (end: ">", fill: black, size: 0.35), stroke: 2.4pt)

  // --- ETICHETTE ---
  content((-1.20, 1.85), [#text(size: 16pt)[F]])
  content((-1.20, -2.05), [#text(size: 16pt)[F]])
  content((0.42, 2.35), [#text(size: 16pt)[z]])
  content((-3.40, -0.68), [#text(size: 16pt)[x]])
  content((3.20, -0.68), [#text(size: 16pt)[y]])
})
  ],
  [
   #canvas(length: 1.2cm, {
  import draw: *
  line((0.5, 1.0), (0.5, -0.5), stroke: 0.6pt)
  line((2.5, 0.0), (2.5, -1.5), stroke: 0.6pt)
  line((5.5, 1.0), (5.5, -0.5), stroke: 0.6pt)
  line((0.5, -0.2), (2.5, -1.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
  line((2.5, -1.2), (5.5, -0.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((1.2, -1.0), [$2b$])
  content((4.2, -0.9), [$L$])
  line((0.5, 1.0), (-0.7, 1.6), stroke: 0.6pt)
  line((1.5, 2.5), (0.3, 3.1), stroke: 0.6pt)
  line((-0.2, 1.35), (-0.2, 3.35), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((-0.9, 2.35), [$p_"max"$])
  line((5.5, 1.0), (3.5, 2.0), (0.5, 1.0), stroke: (dash: "dashed", thickness: 1.5pt))
  line((0.5, 1.0), (2.5, 0.0), (5.5, 1.0), stroke: 1.5pt)
  bezier((3.5, 2.0), (4.5, 3.5), (3.5, 3.104), (3.948, 3.776), stroke: (dash: "dashed", thickness: 1pt))
  bezier((4.5, 3.5), (5.5, 1.0), (5.052, 3.224), (5.5, 2.104), stroke: 1pt)
  line((1.5, 2.5), (4.5, 3.5), stroke: 1pt)
  bezier((0.5, 1.0), (1.5, 2.5), (0.5, 2.104), (0.948, 2.776), stroke: 1pt)
  bezier((1.5, 2.5), (2.5, 0.0), (2.052, 2.224), (2.5, 1.104), stroke: 1pt)
  line((0.7, 2.1), (0.7, 0.9), mark: (end: ">"), stroke: 0.6pt)
  line((0.9, 2.4), (0.9, 0.8), mark: (end: ">"), stroke: 0.6pt)
  line((1.1, 2.533), (1.1, 0.7), mark: (end: ">"), stroke: 0.6pt)
  line((1.3, 2.56), (1.3, 0.6), mark: (end: ">"), stroke: 0.6pt)
  line((1.5, 2.5), (1.5, 0.5), mark: (end: ">"), stroke: 0.6pt)
  line((1.7, 2.36), (1.7, 0.4), mark: (end: ">"), stroke: 0.6pt)
  line((1.9, 2.133), (1.9, 0.3), mark: (end: ">"), stroke: 0.6pt)
  line((2.1, 1.8), (2.1, 0.2), mark: (end: ">"), stroke: 0.6pt)
  line((2.3, 1.3), (2.3, 0.1), mark: (end: ">"), stroke: 0.6pt)
})
  ]
)
Poiché la curvatura assiale dei cilindri è nulla (raggio infinito), questa condizione impone $cos(tau) = 1$. Di conseguenza, $a^*$ diverge all'infinito e $b^*$ tende a zero. Fisicamente, l'ellisse degenera in un rettangolo di larghezza $2b$ e lunghezza assiale pari a $L$.
    $ alpha_x &= beta_x = 0 \ 
      cos(tau)=0 arrow.r
      (a^* &arrow.r oo quad b^* arrow.r 0) $ 
#v(1em)




Il valore della semi-larghezza $b$ è descritto da una formulazione specifica:
$ b = root(2, (4 F) / (pi dot L dot 2(alpha_y + beta_y)) ( (1 - nu_1^2)/E_1 + (1 - nu_2^2)/E_2 ) ) $

In questa configurazione, la distribuzione di pressione assume un profilo parabolico esteso lungo la semi-larghezza $b$. La pressione media si calcola come $p_"media" = F / (2 L b)$, e il picco massimo è:
$ p_"max" = (2 F) / (pi L b) $
== Analogia con le ruote dentate
Le premesse teoriche di Hertz trovano applicazione progettuale fondamentale nella stima della resistenza al "pitting" dei denti degli ingranaggi. La geometria dei fianchi a evolvente di cerchio si assimila con grandissima coerenza al contatto tra due cilindri elastici. 

Utilizzando direttamente la formula per la geometria cilindro-cilindro ($p_"max" = (2 F) / (pi L b)$) e sostituendo il semiasse $b$, associando i termini alle rispettive grandezze ingranaggistiche (il carico alla forza tangenziale, le deviazioni ai fattori dinamici, e la cedevolezza ai fattori materiali), si ricava la formula normalizzata d'usura:
$ sigma_"max,USURA" = Z_E sqrt( (F K_0 K_v K_s K_H Z_R) / (L dot d_1) ) $ 
In questa elaborazione si apprezza come l'effetto elastico composito del materiale venga condensato nel fattore strutturale $Z_E$, le grandezze base geometriche distribuiscano la spinta, le deviazioni si racchiudano nelle costanti di correzione $K_i$.
=== Tensioni sub-superficiali e cedimento
Un aspetto fondamentale dell'azione di contatto, responsabile del danneggiamento per "butteratura" (o pitting), è l'andamento sub-superficiale delle tensioni. Sebbene le tensioni normali siano massime in superficie, la dilatazione trasversale del materiale compresso è ostacolata dalle zone circostanti, creando un forte vincolo tridimensionale. 

Per questo motivo, il valore massimo della tensione ideale di von Mises ($sigma_id$) non si registra sulla superficie di contatto, ma ad una profondità $z$ misurata dal piano di carico:
- *Cilindro*: la massima $sigma_id$ si verifica a $z approx 0.78b$ e vale circa il $60\%$ della $p_"max"$.
- *Sfera*: la massima $sigma_id$ si verifica a $z approx 0.48a$ e vale circa il $62\%$ della $p_"max"$.

I materiali sembrano sopportare pressioni massime di contatto apparentemente superiori al loro limite di snervamento $R_(\eH)$. 
Il cedimento per snervamento avviene sotto la superficie dove la
$sigma_id$ è massima, quando:\
$sigma_id = R_(\eH)$. Imponendo la condizione di snervamento nel punto critico sub-superficiale $sigma_{i d} = R_(\eH)$, si calcola che il cedimento inizia a $p_"max" =R_(\eH)/0.60=1.67 R_(\eH)$ per il cilindro e $p_"max" =R_(\eH)/0.62= 1.61 R_(\eH)$ per la sfera.
//reminder fede mancano 11 minuti alla videolezione
=== Pressione di riferimento e confronto applicativo
A fini progettuali si utilizza una _pressione nominale di riferimento_ $p_"rif" = F / A$, calcolata supponendo l'indentazione totale del corpo, dividendo il carico per la macro-area proiettata (per la sfera $pi D^2 / 4$, per il cilindro $L D$). Confrontando le due geometrie a parità di carico:
- *Cuscinetti a rulli (contatto cilindrico)*: Distribuiscono il carico su un'area rettangolare allungata, mantenendo il rapporto $p_"max" / p_"rif"$ basso. Questo garantisce di sopportare carichi elevati senza snervamento locale.
- *Cuscinetti a sfere*: Concentrano il carico su un'area molto ristretta, generando picchi di pressione massimi elevati. Tuttavia, l'area di contatto limitata minimizza le forze di attrito, rendendoli insostituibili per rotolamenti ad altissima velocità.



 


==== Fatica da rotolamento (Rolling Contact Fatigue)
In condizioni di rotolamento reciproco, l'elemento di volume sub-superficiale non sperimenta solo una compressione. Spostandosi lateralmente lungo la retta d'azione del carico, il materiale subisce azioni tangenziali $tau_(\yz)$ provocate dalla spinta del corpo sovrastante. A causa della rotazione, queste tensioni tangenziali alternano continuamente la loro direzione (pulsazione), innescando complessi fenomeni di fatica locale.


*Limiti del modello:* La teoria di Hertz trascura totalmente l'impatto del moto relativo tangenziale o dello strisciamento. La cinematica reale aggiunge azioni di attrito che alterano profondamente lo stato tensionale locale descritto.

#let aggiunta(body) = block(fill: rgb("#eef6ff"), stroke: (left: 2pt + rgb("#2f6fdb")), inset: 8pt, width: 100%, body)


#pagebreak()