#import "@preview/cetz:0.3.4": canvas, draw

#set page(paper: "a4", margin: 2cm)
#set text(lang: "it", size: 11pt)
#set par(justify: true)
#set heading(numbering: none)

#align(center)[
  #v(0.5cm)
  #line(length: 100%, stroke: 1.5pt)
  #v(0.4cm, weak: true)
  #text(size: 20pt, weight: "bold", fill: black )[Esami di Fondamenti di Maccanica Strutturale  ] \
  #v(0.4cm, weak: true)
  #text(size: 12pt, style: "italic")[] \
  #v(0.2cm, weak: true)
  #line(length: 100%, stroke: 0.5pt)
  #v(0.4cm, weak: true)
  
  // Equivalente delle due minipage affiancate
  #grid(
    columns: (1fr, 1fr),
    align(left)[
      *Autori:* \
      Marco Vicari 
    ],
    align(right)[
      *Istituzione:* \
      Politecnico di Torino \
      #text(size: 9pt)[Anno Accademico 2026/2027]
    ]
  )
  #v(1cm)
]
#outline(depth: 1, indent: auto, title: "indice")

#pagebreak()

= Fondamenti di Meccanica Strutturale - Testo d'Esame (19/01/2026)

=suca
== Esercizio 1
Si consideri una trave a parete sottile con sezione trasversale a T, le cui dimensioni geometriche sono riportate in figura: larghezza dell'ala superiore $b = 120 "mm"$, altezza complessiva della sezione $h = 120 "mm"$ e spessore costante di parete $s = 10 "mm"$. La trave è realizzata in materiale metallico duttile con tensione di snervamento $R_("p0,2")$.

    *Dati geometrici della sezione:*
    - Larghezza dell'ala: $b = 120 "mm"$
    - Altezza totale: $h = 120 "mm"$
    - Spessore di parete: $s = 10 "mm"$

    *Quesiti (Caso 1 - Flessione e Torsione):*
    + Calcolare l'area $A$ della sezione trasversale e determinare la posizione $y_G$ del baricentro $G$ rispetto alla base inferiore dell'anima (asse $x$).
    + Supponendo la sezione soggetta a un momento flettente $M_x$ (negativo), calcolare il momento d'inerzia baricentrico $I_(x_G)$, tracciare l'andamento delle tensioni normali $sigma_(z z)$ ed esprimere la tensione normale massima di trazione $sigma_("max")$, individuando il punto più sollecitato.
    + Supponendo la sezione soggetta anche a un momento torcente $M_z$, determinare il fattore di rigidezza torsionale $I_t$ (tenendo conto dell'effetto di bordo per sezioni a parete sottile aperta) e l'espressione della tensione tangenziale massima $tau_z$.
    + Individuare il punto critico della sezione e formulare la verifica di resistenza statica calcolando la tensione ideale e il coefficiente di sicurezza $C S$ secondo il criterio di resistenza più restrittivo (Tresca).

#align(center)[#canvas(length: 1.6cm, {
      import draw: *

      // Contorno della sezione a T
      line((-0.17, 0), (0.17, 0), (0.17, 3.66), (2.0, 3.66), (2.0, 4.0), (-2.0, 4.0), (-2.0, 3.66), (-0.17, 3.66), close: true, stroke: 1pt)

      // Tratteggio leggero nell'ala superiore (come nello schizzo a mano)
      line((-1.8, 3.72), (-1.65, 3.94), stroke: 0.6pt)
      line((-1.4, 3.72), (-1.25, 3.94), stroke: 0.6pt)
      line((-1.0, 3.72), (-0.85, 3.94), stroke: 0.6pt)
      line((-0.6, 3.72), (-0.45, 3.94), stroke: 0.6pt)
      line((-0.2, 3.72), (-0.05, 3.94), stroke: 0.6pt)
      line((0.2, 3.72), (0.35, 3.94), stroke: 0.6pt)
      line((0.6, 3.72), (0.75, 3.94), stroke: 0.6pt)
      line((1.0, 3.72), (1.15, 3.94), stroke: 0.6pt)
      line((1.4, 3.72), (1.55, 3.94), stroke: 0.6pt)
      line((1.75, 3.72), (1.9, 3.94), stroke: 0.6pt)

      // Assi di riferimento e baricentrici
      line((-2.2, 0), (2.2, 0), stroke: (dash: "dashed", thickness: 0.6pt), mark: (end: ">"))
      line((-2.2, 2.88), (2.2, 2.88), stroke: (dash: "dashed", thickness: 0.6pt), mark: (end: ">"))
      line((0, -0.3), (0, 4.5), stroke: (dash: "dashed", thickness: 0.6pt), mark: (end: ">"))

      // Baricentro G
      circle((0, 2.88), radius: 0.05, fill: black, stroke: none)

      // Quota superiore b = 120 mm
      line((-2.0, 4.55), (-2.0, 4.85), stroke: 0.6pt)
      line((2.0, 4.55), (2.0, 4.85), stroke: 0.6pt)
      line((-2.0, 4.7), (2.0, 4.7), stroke: 0.6pt)

      // Quota laterale destra h = 120 mm
      line((2.45, 0), (2.75, 0), stroke: 0.6pt)
      line((2.45, 4.0), (2.75, 4.0), stroke: 0.6pt)
      line((2.6, 0), (2.6, 4.0), stroke: 0.6pt)

      // Quota sinistra y_G
      line((-1.35, 0), (-1.05, 0), stroke: 0.6pt)
      line((-1.35, 2.88), (-1.05, 2.88), stroke: 0.6pt)
      line((-1.2, 0), (-1.2, 2.88), stroke: 0.6pt)

      // Quota spessore s = 10 mm
      line((-0.55, 1.6), (-0.17, 1.6), stroke: 0.6pt, mark: (end: ">"))
      line((0.55, 1.6), (0.17, 1.6), stroke: 0.6pt, mark: (end: ">"))
      line((-0.17, 1.6), (0.17, 1.6), stroke: 0.6pt)

      // Etichette di testo (tutte con text(size: 7pt))
      content((0, 4.95), text(size: 7pt)[$b = 120 "mm"$], anchor: "south")
      content((0.12, 4.4), text(size: 7pt)[$y_G$], anchor: "west")
      content((-0.12, 2.68), text(size: 7pt)[$G$], anchor: "east")
      content((0.62, 1.6), text(size: 7pt)[$10 "mm" = s$], anchor: "west")
      content((2.15, 2.65), text(size: 7pt)[$x_G$], anchor: "north")
      content((2.75, 2.0), text(size: 7pt)[$h = 120 "mm"$], anchor: "west")
      content((2.15, -0.15), text(size: 7pt)[$x$], anchor: "north")
      content((-1.3, 1.44), text(size: 7pt)[$y_G$], anchor: "east")
    })
  ]


Si consideri la medesima trave con sezione a T dell'Esercizio 1 (avente $b = 120 "mm"$, $h = 120 "mm"$, $s = 10 "mm"$), già sottoposta al momento flettente $M_x$ (negativo) e al momento torcente $M_z$, alla quale viene aggiunto un carico assiale centrato di compressione $N$ ($N < 0$).

*Quesiti (Caso 2 - Pressoflessione e Torsione):*
+ Determinare il contributo di tensione normale dovuto allo sforzo normale $N$ e scrivere le espressioni della tensione normale risultante massima $sigma_z^("max")$ sia sul lato inferiore ($y = -y_G$) sia sul lato superiore ($y = h - y_G$) della sezione.
+ Individuare il nuovo punto critico della sezione confrontando il valore assoluto delle tensioni normali estreme ai lembi inferiore e superiore.
+ Ricalcolare la tensione ideale $sigma_("id")^T$ e il coefficiente di sicurezza $C S$ adottando il criterio di resistenza più restrittivo.


== Esercizio 2 
Si consideri la struttura a telaio piano isostatica $A B C D E F$ riportata in figura, costituita da due ritti verticali $A B$ ed $E F$ di altezza $2 L$ e da un traverso orizzontale $B E$ di lunghezza complessiva $4 L$.
Il sistema è vincolato a terra mediante un carrello ad asse verticale in $A$, un appoggio intermedio (carrello ad asse verticale) in $D$ posto a distanza $3 L$ da $B$ (e $L$ da $E$), e una cerniera fissa in $F$. In corrispondenza della sezione $C$, posta a distanza $2 L$ da $B$, è presente una cerniera interna.
Sul nodo $B$ agisce una forza concentrata orizzontale $F$ diretta verso destra, mentre lungo l'intero traverso orizzontale $B E$ agisce un carico distribuito costante $q$ diretto verticalmente verso il basso.

*Dati geometrici e di carico:*
    - Luce di riferimento: $L = 2 "m"$
    - Forza concentrata in $B$: $F = 500 "N"$
    - Carico distribuito sul traverso: $q = 2000 "N/m"$
    - Allungamento percentuale a rottura del materiale: $A = 4 %$
    - Tensione limite di rottura a trazione: $R_m = 360 "MPa"$
    - Coefficiente di sicurezza: $S = 3$
    - Sezione trasversale delle travi: quadrata piena di lato $a$

    *Quesiti:*
    + Determinare le reazioni vincolari esterne in $A$, $D$ e $F$ tramite le equazioni cardinali della statica e l'equazione ausiliaria alla cerniera interna $C$.
    + Scrivere le espressioni analitiche delle azioni interne (sforzo normale $N$, taglio $T$ e momento flettente $M_f$) nei quattro tratti della struttura e tracciarne i relativi diagrammi quotati.
    + Individuare la sezione più sollecitata della struttura e procedere al dimensionamento del lato $a$ della sezione quadrata piena adottando il criterio di resistenza appropriato per il materiale assegnato, eseguendo infine la verifica a pressoflessione/tensoflessione.

#align(center)[#canvas(length: 2.5cm, {
      import draw: *

      // Struttura principale (ritti e traverso)
      line((0, 0), (0, 2.0), (4.0, 2.0), (4.0, 0), stroke: 1pt)

      // Cerniera interna in C (2.0, 2.0)
      circle((2.0, 2.0), radius: 0.08, fill: white, stroke: 1pt)

      // Carrello in A (0, 0)
      circle((0, -0.08), radius: 0.08, fill: white, stroke: 0.6pt)
      line((-0.2, -0.16), (0.2, -0.16), stroke: 0.6pt)

      // Carrello intermedio in D (3.0, 2.0)
      circle((3.0, 1.92), radius: 0.08, fill: white, stroke: 0.6pt)
      line((2.8, 1.84), (3.2, 1.84), stroke: 0.6pt)

      // Cerniera fissa in F (4.0, 0)
      line((4.0, 0), (3.85, -0.2), (4.15, -0.2), close: true, stroke: 0.6pt)
      line((3.75, -0.2), (4.25, -0.2), stroke: 0.6pt)

      // Forza concentrata F in B
      line((-0.75, 2.0), (-0.02, 2.0), stroke: 1pt, mark: (end: ">"))

      // Carico distribuito q su BE
      line((0, 2.45), (4.0, 2.45), stroke: 0.6pt)
      line((0, 2.45), (0, 2.02), stroke: 0.6pt, mark: (end: ">"))
      line((0.5, 2.45), (0.5, 2.02), stroke: 0.6pt, mark: (end: ">"))
      line((1.0, 2.45), (1.0, 2.02), stroke: 0.6pt, mark: (end: ">"))
      line((1.5, 2.45), (1.5, 2.02), stroke: 0.6pt, mark: (end: ">"))
      line((2.0, 2.45), (2.0, 2.1), stroke: 0.6pt, mark: (end: ">"))
      line((2.5, 2.45), (2.5, 2.02), stroke: 0.6pt, mark: (end: ">"))
      line((3.0, 2.45), (3.0, 2.02), stroke: 0.6pt, mark: (end: ">"))
      line((3.5, 2.45), (3.5, 2.02), stroke: 0.6pt, mark: (end: ">"))
      line((4.0, 2.45), (4.0, 2.02), stroke: 0.6pt, mark: (end: ">"))

      // Quote geometriche
      line((0, -0.55), (4.0, -0.55), stroke: 0.6pt)
      line((0, -0.45), (0, -0.65), stroke: 0.6pt)
      line((2.0, -0.45), (2.0, -0.65), stroke: 0.6pt)
      line((3.0, -0.45), (3.0, -0.65), stroke: 0.6pt)
      line((4.0, -0.45), (4.0, -0.65), stroke: 0.6pt)

      line((4.55, 0), (4.55, 2.0), stroke: 0.6pt)
      line((4.45, 0), (4.65, 0), stroke: 0.6pt)
      line((4.45, 2.0), (4.65, 2.0), stroke: 0.6pt)

      // Etichette (tutte con text(size: 7pt))
      content((-0.18, 0.05), text(size: 7pt)[$A$], anchor: "east")
      content((0.12, 1.82), text(size: 7pt)[$B$], anchor: "north")
      content((1.88, 1.82), text(size: 7pt)[$C$], anchor: "north")
      content((2.82, 1.82), text(size: 7pt)[$D$], anchor: "north")
      content((4.15, 1.85), text(size: 7pt)[$E$], anchor: "west")
      content((4.18, 0.05), text(size: 7pt)[$F$], anchor: "west")
      content((-0.45, 2.15), text(size: 7pt)[$F$], anchor: "south")
      content((2.2, 2.55), text(size: 7pt)[$q$], anchor: "south")
      content((1.0, -0.65), text(size: 7pt)[$2 L$], anchor: "north")
      content((2.5, -0.65), text(size: 7pt)[$L$], anchor: "north")
      content((3.5, -0.65), text(size: 7pt)[$L$], anchor: "north")
      content((4.7, 1.0), text(size: 7pt)[$2 L$], anchor: "west")
    })]


#pagebreak()

= Soluzione dell'Esame

== Primo esercizio) Soluzione

=== 1) Calcolo dell'area e della posizione del baricentro
Per determinare la posizione verticale $y_G$ del baricentro $G$ rispetto all'asse $x$ posto alla base inferiore dell'anima (mentre per simmetria il baricentro giace sull'asse verticale centrale $y_G$), scomponiamo la sezione a T per sottrazione tra un rettangolo pieno circoscritto di dimensioni $b times h$ (indicato con l'apice $P$, "pieno") e i due rettangoli laterali vuoti di altezza $(h - s)$ e larghezza complessiva $(b - s)$ (indicati con l'apice $V$, "vuoto").

#grid(
  columns: (1.1fr, 1fr),
  column-gutter: 1.8em,
  align: (left + horizon, center + horizon),
  [
    Calcoliamo innanzitutto l'area complessiva $A$ della sezione trasversale come differenza tra l'area piena $A^P$ e l'area vuota $A^V$:
    $ A^P = h dot b = 120 dot 120 = 14400 "mm"^2 $
    $ A^V = (h - s)(b - s) = (120 - 10)(120 - 10) = 12100 "mm"^2 $
    $ A = A^P - A^V = 14400 - 12100 = 2300 "mm"^2 $

   
  ],
  [
    
    #canvas(length: 1.3cm, {
      import draw: *

      // Contorno della sezione a T
      line((-0.17, 0), (0.17, 0), (0.17, 3.66), (2.0, 3.66), (2.0, 4.0), (-2.0, 4.0), (-2.0, 3.66), (-0.17, 3.66), close: true, stroke: 1pt)

      // Tratteggio leggero nell'ala superiore
      line((-1.8, 3.72), (-1.65, 3.94), stroke: 0.6pt)
      line((-1.4, 3.72), (-1.25, 3.94), stroke: 0.6pt)
      line((-1.0, 3.72), (-0.85, 3.94), stroke: 0.6pt)
      line((-0.6, 3.72), (-0.45, 3.94), stroke: 0.6pt)
      line((-0.2, 3.72), (-0.05, 3.94), stroke: 0.6pt)
      line((0.2, 3.72), (0.35, 3.94), stroke: 0.6pt)
      line((0.6, 3.72), (0.75, 3.94), stroke: 0.6pt)
      line((1.0, 3.72), (1.15, 3.94), stroke: 0.6pt)
      line((1.4, 3.72), (1.55, 3.94), stroke: 0.6pt)
      line((1.75, 3.72), (1.9, 3.94), stroke: 0.6pt)

      // Assi di riferimento e baricentrici
      line((-2.2, 0), (2.2, 0), stroke: (dash: "dashed", thickness: 0.6pt), mark: (end: ">"))
      line((-2.2, 2.88), (2.2, 2.88), stroke: (dash: "dashed", thickness: 0.6pt), mark: (end: ">"))
      line((0, -0.3), (0, 4.5), stroke: (dash: "dashed", thickness: 0.6pt), mark: (end: ">"))

      // Baricentro G
      circle((0, 2.88), radius: 0.05, fill: black, stroke: none)

      // Quote
      line((-2.0, 4.55), (-2.0, 4.85), stroke: 0.6pt)
      line((2.0, 4.55), (2.0, 4.85), stroke: 0.6pt)
      line((-2.0, 4.7), (2.0, 4.7), stroke: 0.6pt)

      line((2.45, 0), (2.75, 0), stroke: 0.6pt)
      line((2.45, 4.0), (2.75, 4.0), stroke: 0.6pt)
      line((2.6, 0), (2.6, 4.0), stroke: 0.6pt)

      line((-1.35, 0), (-1.05, 0), stroke: 0.6pt)
      line((-1.35, 2.88), (-1.05, 2.88), stroke: 0.6pt)
      line((-1.2, 0), (-1.2, 2.88), stroke: 0.6pt)

      line((-0.55, 1.6), (-0.17, 1.6), stroke: 0.6pt, mark: (end: ">"))
      line((0.55, 1.6), (0.17, 1.6), stroke: 0.6pt, mark: (end: ">"))
      line((-0.17, 1.6), (0.17, 1.6), stroke: 0.6pt)

      // Etichette
      content((0, 4.95), text(size: 7pt)[$b = 120 "mm"$], anchor: "south")
      content((0.12, 4.4), text(size: 7pt)[$y_G$], anchor: "west")
      content((-0.12, 2.68), text(size: 7pt)[$G$], anchor: "east")
      content((0.62, 1.6), text(size: 7pt)[$10 "mm" = s$], anchor: "west")
      content((2.15, 2.65), text(size: 7pt)[$x_G$], anchor: "north")
      content((2.75, 2.0), text(size: 7pt)[$h = 120 "mm"$], anchor: "west")
      content((2.15, -0.15), text(size: 7pt)[$x$], anchor: "north")
      content((-1.3, 1.44), text(size: 7pt)[$y_G$], anchor: "east")
      content((0.25, -0.18), text(size: 7pt)[$*$], anchor: "west")
    })
    // FASE 3: VERIFICA
    // Tutte le 9 etichette usano text(size: 7pt). Nessun comando proibito.
  ]
)
 Allo stesso modo, calcoliamo il momento statico $S_x$ rispetto all'asse di base $x$ sottraendo al momento statico del rettangolo pieno $S_x^P$ quello della parte vuota $S_x^V$:
    $ S_x^P = (h dot b) dot h / 2 = 14400 dot 60 = 864000 "mm"^3 $
    $ S_x^V &= (h - s)(b - s) dot (h - s) / 2 \
            &= 1 / 2 (h - s)^2 (b - s) = 665500 "mm"^3 $
    $ S_x = S_x^P - S_x^V = 864000 - 665500 = 198500 "mm"^3 $

    La quota verticale $y_G$ del baricentro rispetto alla base inferiore risulta quindi:
    $ y_G = S_x / A = 198500 / 2300 = 86,3 "mm" $
#v(1em)

=== 2) Momento flettente $M_x$ (negativo) e distribuzione delle tensioni normali
Determiniamo ora la distribuzione delle tensioni normali $sigma_(z z)$ dovute al momento flettente $M_x$ (negativo). Per la formula di Navier, la tensione normale varia linearmente con l'ordinata baricentrica $y$:
$ M_x arrow.r.double sigma_(z z) = + M_x / I_(x_G) dot y $


Per calcolare il momento d'inerzia baricentrico $I_(x_G)$, calcoliamo dapprima il momento d'inerzia $I_x$ rispetto all'asse di base $x$ (sfruttando il teorema di Huygens-Steiner per il rettangolo pieno $P$ e per la parte vuota $V$) e poi trasportiamo al baricentro $G$.
Per il rettangolo pieno di base $b$ e altezza $h$:
    $ I_x^P &= I_(x^P)^P + I_("trasp")^P = (b h^3) / 12 + (b h) (h / 2)^2 
            &= (b h^3) / 12 + (b h^3) / 4 = 4 / 12 b h^3 = (b h^3) / 3 = 69,12 dot 10^6 "mm"^4 $

    Per la parte vuota di larghezza $(b - s)$ e altezza $(h - s)$:
    $ I_x^V &= I_(x^V)^V + I_("trasp")^V = ((h - s)^3 (b - s)) / 12 + [(h - s)(b - s)] [(h - s) / 2]^2 \
            &= ((h - s)^3 (b - s)) / 12 + ((h - s)^3 (b - s)) / 4 \
            &= ((h - s)^3 (b - s)) / 3 = 48,80 dot 10^6 "mm"^4 $
#v(0.5em)

Pertanto, il momento d'inerzia complessivo rispetto all'asse di base $x$ vale:
$ I_x = I_x^P - I_x^V = (69,12 - 48,80) dot 10^6 = 20,32 dot 10^6 "mm"^4 $

Applicando la formula inversa di Huygens-Steiner per passare dall'asse di base $x$ all'asse baricentrico $x_G$, otteniamo:
$ I_(x_G) = I_x - A dot y_G^2 = 20,32 dot 10^6 - 2300 dot (86,3)^2 = 3187 dot 10^3 "mm"^4 $

Poiché il momento flettente $M_x$ è negativo e la distanza del lembo inferiore dal baricentro ($y_G = 86,3 "mm"$) è molto maggiore rispetto a quella del lembo superiore ($h - y_G = 33,7 "mm"$), il punto più sollecitato a trazione (indicato con $*$) si trova sul lato inferiore dell'anima ($y = -y_G$), dove la tensione normale massima vale:
$ sigma_("max") = sigma_z (y = -y_G) = - M_x / I_(x_G) y_G $

=== 3) Momento torcente $M_z$ e distribuzione delle tensioni tangenziali
Passiamo al calcolo della distribuzione delle tensioni tangenziali dovute al momento torcente $M_z$. Per una sezione sottile aperta composta da rettangoli di spessore $s$, la tensione tangenziale massima di torsione alla Bredt/Saint-Venant vale:
$ M_z arrow.r.double tau_z = M_z / I_t dot s $

Tenendo conto del termine correttivo di bordo ($3 dot 0,2 dot s$) per i tre bordi liberi della sezione a T, il fattore di rigidezza torsionale $I_t$ si calcola come:
$ I_t &= 1 / 3 s^3 dot [(b + (h - s)) - (3 dot 0,2 dot s)] = 1 / 3 s^3 [(b + h - s) - 3 dot 0,2 dot s] \
      &= 1 / 3 dot 10^3 dot [(120 + 120 - 10) - 3 dot 0,2 dot 10] = 74667 "mm"^4 $
*(Nota: nel foglio manoscritto l'unità di misura è indicata come $"mm"^3$, ma dimensionalmente il momento d'inerzia torsionale $I_t$ è espresso in $"mm"^4$, mentre il modulo di resistenza torsionale $W_t = I_t / s$ è in $"mm"^3$).*

=== 4) Individuazione del punto critico e coefficiente di sicurezza
Adottando il criterio di resistenza più restrittivo per materiali duttili, ovvero il criterio di Tresca (dello sforzo tangenziale massimo), la tensione ideale equivalente $sigma_("id")^T$ nel punto critico sul lembo inferiore dell'anima è data da:
$ sigma_("id")^T = sqrt(sigma_("max")^2 + 4 tau_("z,max")^2) $
da cui il relativo coefficiente di sicurezza statico a snervamento risulta:
$ C S = R_("p0,2") / sigma_("id")^T $

#v(1em)

== Secondo esercizio) Soluzione (Aggiunta di un carico assiale di compressione)

=== 1) Tensioni normali con carico assiale $N$ di compressione
Aggiungiamo ora alla sezione un carico assiale centrato $N$ di compressione ($N$ negativo). Tale sforzo normale genera sulla sezione una tensione normale uniforme pari a:
$ sigma_z = N / A $

Sovrapponendo gli effetti della flessione ($M_x < 0$) e dello sforzo normale ($N < 0$), calcoliamo la tensione normale totale sul lato inferiore ($y = -y_G$, dove il momento flettente produce trazione e lo sforzo normale produce compressione) e sul lato superiore ($y = h - y_G$, dove sia il momento flettente sia lo sforzo normale producono compressione):
$ sigma_z^("max") ("lato inferiore") = sigma_(z z)^("max") (y = -y_G) + N / A = - M_x / I_(x_G) y_G + N / A $
$ sigma_z^("max") ("lato superiore") = sigma_(z z)^("max") (y = h - y_G) + N / A = + M_x / I_(x_G) (h - y_G) + N / A $

=== 2) Individuazione del nuovo punto critico e verifica di sicurezza
Poiché lo sforzo normale di compressione riduce in modulo la trazione al lembo inferiore mentre incrementa in modulo la compressione al lembo superiore, per individuare il punto critico occorre confrontare il valore assoluto delle due tensioni normali estreme:
$ sigma_("max")^* = max [abs(sigma_z^("max") ("lato inferiore")), abs(sigma_z^("max") ("lato superiore"))] $

Nota la tensione normale massima in modulo $sigma_("max")^*$, calcoliamo la tensione equivalente ideale secondo il criterio più restrittivo (Tresca):
$ sigma_("id")^T = sqrt((sigma_("max")^*)^2 + 4 tau_("z,max")^2) $
e infine determiniamo il coefficiente di sicurezza statico:
$ C S = R_("p0,2") / sigma_("id")^T $

== Secondo esercizio) Soluzione

=== 1) Calcolo delle reazioni vincolari
Sostituiamo ai vincoli esterni le rispettive reazioni vincolari: la forza verticale $V_A$ in corrispondenza del carrello in $A$, la forza verticale $V_D$ in corrispondenza dell'appoggio in $D$, e le due componenti orizzontale $O_F$ e verticale $V_F$ in corrispondenza della cerniera in $F$. Suddividiamo inoltre la struttura nei quattro tratti regolari $"I"$, $"II"$, $"III"$ e $"IV"$.


    

    Sostituendo i dati numerici della *Versione D* ($L = 2 "m"$, $F = 500 "N"$, $q = 2000 "N/m"$), otteniamo:
    - $O_F = -F = -500 "N"$
    - $V_A = q L = 2000 dot 2 = 4000 "N"$
    - $V_F = -3000 "N"$ e $V_D = 15000 "N"$

  #align(center)[#canvas(length: 2.5cm, {
      import draw: *

      // Telaio A-B-C-D-E-F
      line((0, 0), (0, 2.0), (4.0, 2.0), (4.0, 0), stroke: 1pt)

      // Cerniera in C e vincoli tratteggiati
      circle((2.0, 2.0), radius: 0.08, fill: white, stroke: 1pt)
      circle((0, 0), radius: 0.06, fill: white, stroke: 0.6pt)
      circle((3.0, 2.0), radius: 0.06, fill: white, stroke: 0.6pt)
      circle((4.0, 0), radius: 0.06, fill: white, stroke: 0.6pt)

      // Forza F e carico distribuito q
      line((-0.7, 2.0), (-0.02, 2.0), stroke: 1pt, mark: (end: ">"))
      line((0, 2.45), (4.0, 2.45), stroke: 0.6pt)
      line((0, 2.45), (0, 2.02), stroke: 0.6pt, mark: (end: ">"))
      line((0.5, 2.45), (0.5, 2.02), stroke: 0.6pt, mark: (end: ">"))
      line((1.0, 2.45), (1.0, 2.02), stroke: 0.6pt, mark: (end: ">"))
      line((1.5, 2.45), (1.5, 2.02), stroke: 0.6pt, mark: (end: ">"))
      line((2.0, 2.45), (2.0, 2.1), stroke: 0.6pt, mark: (end: ">"))
      line((2.5, 2.45), (2.5, 2.02), stroke: 0.6pt, mark: (end: ">"))
      line((3.0, 2.45), (3.0, 2.02), stroke: 0.6pt, mark: (end: ">"))
      line((3.5, 2.45), (3.5, 2.02), stroke: 0.6pt, mark: (end: ">"))
      line((4.0, 2.45), (4.0, 2.02), stroke: 0.6pt, mark: (end: ">"))

      // Reazioni vincolari V_A, V_D, O_F, V_F
      line((0, -0.55), (0, -0.06), stroke: 1pt, mark: (end: ">"))
      line((3.0, 1.35), (3.0, 1.94), stroke: 1pt, mark: (end: ">"))
      line((3.35, 0), (3.94, 0), stroke: 1pt, mark: (end: ">"))
      line((4.0, -0.55), (4.0, -0.06), stroke: 1pt, mark: (end: ">"))

      // Segni di sezione e cerchi dei tratti I, II, III, IV
      line((-0.15, 0.9), (0.15, 0.95), stroke: 0.6pt)
      circle((0.38, 0.85), radius: 0.18, stroke: 0.6pt)

      line((2.15, 1.85), (2.2, 2.15), stroke: 0.6pt)
      circle((2.22, 1.45), radius: 0.18, stroke: 0.6pt)

      line((3.7, 1.85), (3.75, 2.15), stroke: 0.6pt)
      circle((3.7, 1.55), radius: 0.18, stroke: 0.6pt)

      line((3.85, 0.9), (4.15, 0.95), stroke: 0.6pt)
      circle((4.42, 0.9), radius: 0.18, stroke: 0.6pt)

      // Etichette (tutte con text(size: 7pt))
      content((-0.4, 2.12), text(size: 7pt)[$F$], anchor: "south")
      content((0.15, 1.85), text(size: 7pt)[$B$], anchor: "north")
      content((1.82, 1.85), text(size: 7pt)[$C$], anchor: "north")
      content((2.4, 2.55), text(size: 7pt)[$q$], anchor: "south")
      content((2.82, 1.88), text(size: 7pt)[$D$], anchor: "north")
      content((3.08, 1.55), text(size: 7pt)[$V_D$], anchor: "west")
      content((4.15, 1.88), text(size: 7pt)[$E$], anchor: "west")
      content((-0.15, 0.1), text(size: 7pt)[$A$], anchor: "east")
      content((0.1, -0.35), text(size: 7pt)[$V_A$], anchor: "west")
      content((3.55, 0.12), text(size: 7pt)[$O_F$], anchor: "south")
      content((4.15, 0.15), text(size: 7pt)[$F$], anchor: "west")
      content((4.1, -0.35), text(size: 7pt)[$V_F$], anchor: "west")
      content((0.38, 0.85), text(size: 7pt)[$"I"$], anchor: "center")
      content((2.22, 1.45), text(size: 7pt)[$"II"$], anchor: "center")
      content((3.7, 1.55), text(size: 7pt)[$"III"$], anchor: "center")
      content((4.42, 0.9), text(size: 7pt)[$"IV"$], anchor: "center")
    })]


Scriviamo le tre equazioni cardinali della statica per l'intera struttura (equilibrio alla traslazione orizzontale, alla traslazione verticale e alla rotazione attorno al polo $A$) affiancate dall'equazione ausiliaria di equilibrio alla rotazione attorno alla cerniera interna $C$ per la sottostruttura di sinistra ($"AUX" arrow.r C^("sx")$):
    $ cases(
  gap: #0.8em,
  (+) arrow.r &quad O_F + F = 0 wide arrow.r.double wide O_F = -F,
  (+) arrow.t &quad V_A + V_D + V_F - q dot 4 L = 0,
  (+) A^"orario" &quad -F dot 2 L - q dot 4 L dot 2 L + V_D dot 3 L + V_F dot 4 L = 0,
  "AUX" arrow.r C^"sx" &quad -V_A dot 2 L + q dot 2 L dot L = 0 wide arrow.r.double wide V_A = (q dot 2 L^2)  (2 L) = q L
) $
#v(1em)

=== 2) Calcolo delle azioni interne per ciascun tratto

*Tratto I ($0 < x < 2 L$):*
Percorriamo il ritto verticale di sinistra partendo dall'estremo inferiore $A$ verso $B$ con ascissa locale $x$.

#grid(
  columns: (0.75fr, 1.25fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  [
    
    #canvas(length: 2cm, {
      import draw: *

      // Spezzone verticale Tratto I
      line((0, 0), (0, 1.2), stroke: 1pt)
      circle((0, 0), radius: 0.05, fill: black)

      // Reazione V_A
      line((0, -0.55), (0, -0.05), stroke: 1pt, mark: (end: ">"))

      // Quota x
      line((-0.45, 0), (-0.25, 0), stroke: 0.6pt)
      line((-0.45, 1.2), (-0.25, 1.2), stroke: 0.6pt)
      line((-0.35, 0), (-0.35, 1.2), stroke: 0.6pt, mark: (end: ">"))

      // Azioni interne in cima allo spezzone
      line((-0.15, 1.2), (0.15, 1.2), stroke: 0.6pt)
      line((0, 1.25), (0, 1.75), stroke: 0.6pt, mark: (end: ">"))
      line((0.05, 1.1), (0.55, 1.1), stroke: 0.6pt, mark: (end: ">"))
      arc((0, 1.2), start: 30deg, stop: 150deg, radius: 0.35, anchor: "origin", stroke: 0.6pt, mark: (end: ">"))

      // Etichette
      content((0.1, -0.35), text(size: 7pt)[$V_A$], anchor: "west")
      content((-0.45, 0.6), text(size: 7pt)[$x$], anchor: "east")
      content((0.12, 1.7), text(size: 7pt)[$N$], anchor: "west")
      content((0.45, 0.98), text(size: 7pt)[$T$], anchor: "north")
      content((-0.38, 1.38), text(size: 7pt)[$M$], anchor: "east")
    })
    // FASE 3: VERIFICA
    // Arco per M con start=30deg < stop=150deg e anchor: "origin". 5 etichette con text(size: 7pt).
  ],
  [
    Dall'equilibrio del tronco inferiore di lunghezza $x$ ricaviamo:
    - *Sforzo normale ($N$):*
      $ N + V_A = 0 arrow.r.double N = -V_A = -4000 "N" $
    - *Taglio ($T$):*
      $ T = 0 "N" $
    - *Momento flettente ($M$):*
      $ M = 0 "Nm" $
  ]
)
#v(0.5em)

*Tratto II ($0 < x < 3 L$):*
Tagliamo il traverso orizzontale ad ascissa $x$ misurata a partire dal nodo $B$ verso il vincolo in $D$ ($0 < x < 3 L$).

#grid(
  columns: (0.75fr, 1.25fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  [
    
    #canvas(length: 2cm, {
      import draw: *

      // Struttura spezzone Tratto II
      line((0, 0), (0, 1.5), (1.2, 1.5), stroke: 1pt)

      // Forza F e reazione V_A
      line((-0.6, 1.5), (-0.02, 1.5), stroke: 1pt, mark: (end: ">"))
      line((0, -0.5), (0, -0.02), stroke: 1pt, mark: (end: ">"))

      // Carico distribuito q
      line((0, 1.85), (1.2, 1.85), stroke: 0.6pt)
      line((0.2, 1.85), (0.2, 1.52), stroke: 0.6pt, mark: (end: ">"))
      line((0.6, 1.85), (0.6, 1.52), stroke: 0.6pt, mark: (end: ">"))
      line((1.0, 1.85), (1.0, 1.52), stroke: 0.6pt, mark: (end: ">"))

      // Quota x
      line((0, 1.15), (1.2, 1.15), stroke: 0.6pt, mark: (end: ">"))

      // Azioni interne nella sezione x
      line((1.2, 1.3), (1.2, 1.7), stroke: 0.6pt)
      line((1.25, 1.5), (1.75, 1.5), stroke: 0.6pt, mark: (end: ">"))
      line((1.1, 1.45), (1.1, 0.95), stroke: 0.6pt, mark: (end: ">"))
      arc((1.2, 1.5), start: -60deg, stop: 60deg, radius: 0.35, anchor: "origin", stroke: 0.6pt, mark: (end: ">"))

      // Etichette
      content((-0.35, 1.38), text(size: 7pt)[$F$], anchor: "north")
      content((0.1, -0.3), text(size: 7pt)[$V_A$], anchor: "west")
      content((0.6, 1.08), text(size: 7pt)[$x$], anchor: "north")
      content((1.7, 1.38), text(size: 7pt)[$N$], anchor: "north")
      content((1.1, 0.9), text(size: 7pt)[$T$], anchor: "north")
      content((1.45, 1.88), text(size: 7pt)[$M$], anchor: "south")
    })
    // FASE 3: VERIFICA
    // Arco M con start=-60deg < stop=60deg e anchor: "origin". 6 etichette con text(size: 7pt).
  ],
  [
    Imponendo l'equilibrio della porzione di struttura a sinistra della sezione otteniamo:
    - *Sforzo normale ($N$):*
      $ N + F = 0 arrow.r.double N = -F = -500 "N" $
    - *Taglio ($T$):*
      $ T + q dot x - V_A = 0 arrow.r.double T = V_A - q dot x = cases(
        T(x = 0) = V_A = 4000 "N",
        T(x = 2 L) = -4000 "N",
        T(x = 3 L) = -8000 "N"
      ) $
    - *Momento flettente ($M$):*
      $ M + q dot x^2 / 2 - V_A dot x = 0 arrow.r.double M = V_A dot x - q dot x^2 / 2 $
      Valutando il momento nei punti notevoli:
      $ cases(
        M(x = 0) = 0 "Nm",
        M(x = L) = 4000 "Nm" quad ("massimo relativo"),
        M(x = 2 L) = 0 "Nm" quad ("VERIFICA in " C),
        M(x = 3 L) = -12000 "Nm"
      ) $
  ]
)
#v(0.5em)

*Tratto III ($0 < x' < L$):*
Studiamo il tratto $E D$ procedendo da destra verso sinistra con ascissa locale $x'$ avente origine in $E$ ($0 < x' < L$).

#grid(
  columns: (0.75fr, 1.25fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Schema di corpo libero del Tratto III (ritto EF completo + tratto orizzontale di lunghezza x' da E verso D), con reazioni O_F, V_F in F, carico q su x' e azioni interne N, T, M.
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, F=(1.2, 0), E=(1.2, 1.5), sezione in (0, 1.5).
    // 2. ELEMENTI: Asta da (1.2,0) a (1.2,1.5) a (0,1.5), O_F, V_F, carico q, quota x', frecce N, T, M.
    // FASE 2: COSTRUZIONE
    #canvas(length: 2cm, {
      import draw: *

      // Spezzone Tratto III
      line((0, 1.5), (1.2, 1.5), (1.2, 0), stroke: 1pt)

      // Reazioni O_F e V_F in F
      line((0.65, 0), (1.18, 0), stroke: 1pt, mark: (end: ">"))
      line((1.2, -0.55), (1.2, -0.02), stroke: 1pt, mark: (end: ">"))

      // Carico distribuito q su x'
      line((0, 1.85), (1.2, 1.85), stroke: 0.6pt)
      line((0.2, 1.85), (0.2, 1.52), stroke: 0.6pt, mark: (end: ">"))
      line((0.6, 1.85), (0.6, 1.52), stroke: 0.6pt, mark: (end: ">"))
      line((1.0, 1.85), (1.0, 1.52), stroke: 0.6pt, mark: (end: ">"))

      // Quota x'
      line((1.2, 1.1), (0, 1.1), stroke: 0.6pt, mark: (end: ">"))

      // Azioni interne sulla faccia sinistra (0, 1.5)
      line((0, 1.3), (0, 1.7), stroke: 0.6pt)
      line((-0.05, 1.5), (-0.55, 1.5), stroke: 0.6pt, mark: (end: ">"))
      line((0.1, 1.0), (0.1, 1.48), stroke: 0.6pt, mark: (end: ">"))
      arc((0, 1.5), start: 120deg, stop: 240deg, radius: 0.35, anchor: "origin", stroke: 0.6pt, mark: (start: ">"))

      // Etichette
      content((1.3, 0.1), text(size: 7pt)[$O_F$], anchor: "west")
      content((1.3, -0.35), text(size: 7pt)[$V_F$], anchor: "west")
      content((0.6, 1.05), text(size: 7pt)[$x'$], anchor: "north")
      content((-0.5, 1.38), text(size: 7pt)[$N$], anchor: "north")
      content((-0.05, 1.15), text(size: 7pt)[$T$], anchor: "east")
      content((-0.2, 1.88), text(size: 7pt)[$M$], anchor: "south")
    })
    // FASE 3: VERIFICA
    // Arco M con start=120deg < stop=240deg e anchor: "origin". 6 etichette con text(size: 7pt).
  ],
  [
    Scriviamo le equazioni di equilibrio per il blocco di destra:
    - *Sforzo normale ($N$):*
      $ N - O_F = 0 arrow.r.double N = O_F = -500 "N" $
    - *Taglio ($T$):*
      $ T - q dot x' + V_F = 0 arrow.r.double T = q dot x' - V_F = cases(
        T(x' = 0) = -V_F = 3000 "N",
        T(x' = L) = q L - V_F = 7000 "N"
      ) $
    - *Momento flettente ($M$):*
      $ M + q dot (x'^2) / 2 - O_F dot 2 L - V_F dot x' = 0 $
      $ arrow.r.double M = V_F dot x' + O_F dot 2 L - q dot (x'^2) / 2 = cases(
        M(x' = 0) = O_F dot 2 L = -2000 "Nm",
        M(x' = L) = -12000 "Nm"
      ) $
  ]
)
#v(0.5em)

*Tratto IV ($0 < x' < 2 L$):*
Percorriamo infine il ritto verticale di destra partendo dalla cerniera $F$ verso il nodo $E$ con ascissa locale $x'$ ($0 < x' < 2 L$).

#grid(
  columns: (0.75fr, 1.25fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Schema di corpo libero del Tratto IV (da F a x', con 0 < x' < 2L), con reazioni O_F, V_F in F e azioni interne N, T, M nella sezione x'.
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, F=(0,0), sezione in (0, 1.2).
    // 2. ELEMENTI: Asta verticale da (0,0) a (0,1.2), reazioni O_F e V_F in F, quota x' a sinistra, frecce N, T, M.
    // FASE 2: COSTRUZIONE
    #canvas(length: 2cm, {
      import draw: *

      // Spezzone verticale Tratto IV
      line((0, 0), (0, 1.2), stroke: 1pt)
      circle((0, 0), radius: 0.05, fill: black)

      // Reazioni O_F e V_F
      line((-0.55, 0), (-0.05, 0), stroke: 1pt, mark: (end: ">"))
      line((0, -0.55), (0, -0.05), stroke: 1pt, mark: (end: ">"))

      // Quota x'
      line((-0.45, 0), (-0.25, 0), stroke: 0.6pt)
      line((-0.45, 1.2), (-0.25, 1.2), stroke: 0.6pt)
      line((-0.35, 0), (-0.35, 1.2), stroke: 0.6pt, mark: (end: ">"))

      // Azioni interne in cima allo spezzone
      line((-0.15, 1.2), (0.15, 1.2), stroke: 0.6pt)
      line((0, 1.25), (0, 1.75), stroke: 0.6pt, mark: (end: ">"))
      line((-0.2, 1.1), (0.4, 1.1), stroke: 0.6pt, mark: (end: ">"))
      arc((0, 1.2), start: 30deg, stop: 150deg, radius: 0.35, anchor: "origin", stroke: 0.6pt, mark: (end: ">"))

      // Etichette
      content((0.15, 0.05), text(size: 7pt)[$O_F$], anchor: "west")
      content((0.1, -0.35), text(size: 7pt)[$V_F$], anchor: "west")
      content((-0.45, 0.6), text(size: 7pt)[$x'$], anchor: "east")
      content((-0.1, 1.7), text(size: 7pt)[$N$], anchor: "east")
      content((0.42, 0.98), text(size: 7pt)[$T$], anchor: "north")
      content((-0.38, 1.38), text(size: 7pt)[$M$], anchor: "east")
    })
    // FASE 3: VERIFICA
    // Arco M con start=30deg < stop=150deg e anchor: "origin". 6 etichette con text(size: 7pt).
  ],
  [
    Dall'equilibrio del tronco inferiore di altezza $x'$ ricaviamo:
    - *Sforzo normale ($N$):*
      $ N + V_F = 0 arrow.r.double N = -V_F = +3000 "N" $
    - *Taglio ($T$):*
      $ T + O_F = 0 arrow.r.double T = -O_F = +500 "N" $
    - *Momento flettente ($M$):*
      $ M + O_F dot x' = 0 arrow.r.double M = -O_F dot x' = cases(
        M(x' = 0) = 0 "Nm",
        M(x' = 2 L) = -O_F dot 2 L = -2000 "Nm"
      ) $
  ]
)
#v(1em)

=== 3) Diagrammi delle caratteristiche di sollecitazione ($N$, $T$, $M_f$) - Versione D
Riportiamo di seguito i tre diagrammi completi dello sforzo normale $N$, dello sforzo di taglio $T$ e del momento flettente $M_f$ per la *Versione D* (come da pagina 4 dell'elaborato).

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Diagramma dello sforzo normale N sul telaio A-B-C-D-E-F (Versione D):
    // - Tratto AB: N = -4000 N (rettangolo esterno a sinistra).
    // - Tratto BE: N = -500 N (rettangolo superiore sul traverso).
    // - Tratto EF: N = +3000 N (rettangolo esterno a destra con segno +).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, A=(0,0), B=(0,2.0), E=(3.6,2.0), F=(3.6,0).
    // 2. ELEMENTI: Telaio di base, campiture a righe perpendicolari all'asse della trave, contorni dei diagrammi, quote -4000N, -500N, 3000N, lettere A, B, C, D, E, F e titolo N.
    // FASE 2: COSTRUZIONE
    #canvas(length: 1.5cm, {
      import draw: *

      // Telaio di riferimento
      line((0, 0), (0, 2.0), (3.6, 2.0), (3.6, 0), stroke: 0.6pt)
      circle((1.8, 2.0), radius: 0.06, fill: white, stroke: 0.6pt)

      // Diagramma N su AB (-4000 N)
      rect((-0.55, 0), (0, 2.0), stroke: 1pt)
      line((-0.55, 0.25), (0, 0.25), stroke: 0.6pt)
      line((-0.55, 0.5), (0, 0.5), stroke: 0.6pt)
      line((-0.55, 0.75), (0, 0.75), stroke: 0.6pt)
      line((-0.55, 1.0), (0, 1.0), stroke: 0.6pt)
      line((-0.55, 1.25), (0, 1.25), stroke: 0.6pt)
      line((-0.55, 1.5), (0, 1.5), stroke: 0.6pt)
      line((-0.55, 1.75), (0, 1.75), stroke: 0.6pt)

      // Diagramma N su BE (-500 N)
      rect((0, 2.0), (3.6, 2.45), stroke: 1pt)
      line((0.3, 2.0), (0.3, 2.45), stroke: 0.6pt)
      line((0.6, 2.0), (0.6, 2.45), stroke: 0.6pt)
      line((0.9, 2.0), (0.9, 2.45), stroke: 0.6pt)
      line((1.2, 2.0), (1.2, 2.45), stroke: 0.6pt)
      line((1.5, 2.0), (1.5, 2.45), stroke: 0.6pt)
      line((1.8, 2.0), (1.8, 2.45), stroke: 1pt)
      line((2.1, 2.0), (2.1, 2.45), stroke: 0.6pt)
      line((2.4, 2.0), (2.4, 2.45), stroke: 0.6pt)
      line((2.7, 2.0), (2.7, 2.45), stroke: 1pt)
      line((3.0, 2.0), (3.0, 2.45), stroke: 0.6pt)
      line((3.3, 2.0), (3.3, 2.45), stroke: 0.6pt)

      // Diagramma N su EF (+3000 N)
      rect((3.6, 0), (4.15, 2.0), stroke: 1pt)
      line((3.6, 0.25), (4.15, 0.25), stroke: 0.6pt)
      line((3.6, 0.5), (4.15, 0.5), stroke: 0.6pt)
      line((3.6, 0.75), (4.15, 0.75), stroke: 0.6pt)
      line((3.6, 1.0), (4.15, 1.0), stroke: 0.6pt)
      line((3.6, 1.25), (4.15, 1.25), stroke: 0.6pt)
      line((3.6, 1.5), (4.15, 1.5), stroke: 0.6pt)
      line((3.6, 1.75), (4.15, 1.75), stroke: 0.6pt)

      // Etichette (con text(size: 7pt))
      content((-0.65, 1.0), text(size: 7pt)[$-4000 "N"$], anchor: "east")
      content((1.8, 2.55), text(size: 7pt)[$-500 "N"$], anchor: "south")
      content((4.25, 1.0), text(size: 7pt)[$3000 "N"$], anchor: "west")
      content((-0.27, 1.12), text(size: 7pt)[$-$], anchor: "center")
      content((0.9, 2.22), text(size: 7pt)[$-$], anchor: "center")
      content((3.88, 1.12), text(size: 7pt)[$+$], anchor: "center")
      content((0.12, 0.05), text(size: 7pt)[$A$], anchor: "west")
      content((0.12, 1.85), text(size: 7pt)[$B$], anchor: "north")
      content((1.8, 1.75), text(size: 7pt)[$C$], anchor: "north")
      content((2.7, 1.75), text(size: 7pt)[$D$], anchor: "north")
      content((3.45, 1.85), text(size: 7pt)[$E$], anchor: "north")
      content((3.48, 0.05), text(size: 7pt)[$F$], anchor: "east")
      content((1.8, 0.9), text(size: 7pt)[*N*], anchor: "center")
    })
    // FASE 3: VERIFICA
    // 13 etichette tutte con text(size: 7pt).
  ],
  [
    #canvas(length: 1.5cm, {
      import draw: *

      // Telaio di riferimento
      line((0, 0), (0, 2.0), (3.6, 2.0), (3.6, 0), stroke: 0.6pt)
      circle((1.8, 2.0), radius: 0.06, fill: white, stroke: 0.6pt)

      // Segno X su AB (T = 0)
      line((-0.12, 0.88), (0.12, 1.12), stroke: 1pt)
      line((-0.12, 1.12), (0.12, 0.88), stroke: 1pt)

      // Diagramma T su BD: da (0, 2.45) a (0.9, 2.0) a (1.8, 1.55) a (2.7, 1.1)
      line((0, 2.0), (0, 2.45), (2.7, 1.1), (2.7, 2.0), stroke: 1pt)
      line((1.8, 2.0), (1.8, 1.55), stroke: 1pt)
      line((0.2, 2.0), (0.2, 2.35), stroke: 0.6pt)
      line((0.4, 2.0), (0.4, 2.25), stroke: 0.6pt)
      line((0.6, 2.0), (0.6, 2.15), stroke: 0.6pt)
      line((1.2, 2.0), (1.2, 1.85), stroke: 0.6pt)
      line((1.5, 2.0), (1.5, 1.7), stroke: 0.6pt)
      line((2.1, 2.0), (2.1, 1.4), stroke: 0.6pt)
      line((2.4, 2.0), (2.4, 1.25), stroke: 0.6pt)

      // Diagramma T su DE: da (2.7, 2.8) a (3.6, 2.35)
      line((2.7, 2.0), (2.7, 2.8), (3.6, 2.35), (3.6, 2.0), stroke: 1pt)
      line((2.9, 2.0), (2.9, 2.7), stroke: 0.6pt)
      line((3.15, 2.0), (3.15, 2.57), stroke: 0.6pt)
      line((3.4, 2.0), (3.4, 2.45), stroke: 0.6pt)

      // Diagramma T su EF (+500 N)
      rect((3.6, 0), (4.05, 2.0), stroke: 1pt)
      line((3.6, 0.3), (4.05, 0.3), stroke: 0.6pt)
      line((3.6, 0.6), (4.05, 0.6), stroke: 0.6pt)
      line((3.6, 0.9), (4.05, 0.9), stroke: 0.6pt)
      line((3.6, 1.2), (4.05, 1.2), stroke: 0.6pt)
      line((3.6, 1.5), (4.05, 1.5), stroke: 0.6pt)
      line((3.6, 1.8), (4.05, 1.8), stroke: 0.6pt)

      // Etichette (con text(size: 7pt))
      content((0, 2.55), text(size: 7pt)[$4000 "N"$], anchor: "south")
      content((1.75, 1.45), text(size: 7pt)[$-4000 "N"$], anchor: "north")
      content((2.7, 1.0), text(size: 7pt)[$-8000 "N"$], anchor: "north")
      content((2.7, 2.9), text(size: 7pt)[$7000 "N"$], anchor: "south")
      content((3.65, 2.45), text(size: 7pt)[$3000 "N"$], anchor: "south")
      content((4.15, 1.0), text(size: 7pt)[$500 "N"$], anchor: "west")
      content((0.25, 2.12), text(size: 7pt)[$+$], anchor: "center")
      content((1.55, 1.85), text(size: 7pt)[$-$], anchor: "center")
      content((3.15, 2.2), text(size: 7pt)[$+$], anchor: "center")
      content((3.82, 1.05), text(size: 7pt)[$+$], anchor: "center")
      content((0.12, 0.05), text(size: 7pt)[$A$], anchor: "west")
      content((0.12, 1.85), text(size: 7pt)[$B$], anchor: "north")
      content((3.48, 0.05), text(size: 7pt)[$F$], anchor: "east")
      content((1.8, 0.65), text(size: 7pt)[*T*], anchor: "center")
    })
    // FASE 3: VERIFICA
    // 14 etichette tutte con text(size: 7pt).
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    Osservando il diagramma del momento flettente $M_f$ (disegnato dalla parte delle fibre tese):
    - Sul ritto $A B$ il momento flettente è identicamente nullo ($M_f = 0$).
    - Sul traverso $B D$ l'andamento è parabolico: parte da $0$ in $B$, raggiunge un massimo positivo di $+4000 "Nm"$ (fibre inferiori tese) a metà del tratto $B C$ ($x = L$), si annulla nella cerniera $C$ ($x = 2 L$) e scende fino al picco negativo di $-12000 "Nm"$ (fibre superiori tese) sull'appoggio $D$ ($x = 3 L$).
    - Sul tratto $D E$ l'andamento parabolico risale da $-12000 "Nm"$ in $D$ a $-2000 "Nm"$ nel nodo $E$.
    - Sul ritto $E F$ il momento varia linearmente da $0$ nella cerniera $F$ fino a $-2000 "Nm"$ in $E$.
  ],
  [
    #canvas(length: 1.5cm, {
      import draw: *

      // Telaio di riferimento
      line((0, 0), (0, 2.0), (3.6, 2.0), (3.6, 0), stroke: 0.6pt)
      circle((1.8, 2.0), radius: 0.06, fill: white, stroke: 0.6pt)

      // Segno X su AB (M_f = 0)
      line((-0.12, 0.88), (0.12, 1.12), stroke: 1pt)
      line((-0.12, 1.12), (0.12, 0.88), stroke: 1pt)

      // Arco parabolico BC (4000 Nm)
      bezier((0, 2.0), (1.8, 2.0), (0.6, 1.53), (1.2, 1.53), stroke: 1pt)
      line((0.3, 2.0), (0.3, 1.79), stroke: 0.6pt)
      line((0.6, 2.0), (0.6, 1.69), stroke: 0.6pt)
      line((0.9, 2.0), (0.9, 1.65), stroke: 0.6pt)
      line((1.2, 2.0), (1.2, 1.69), stroke: 0.6pt)
      line((1.5, 2.0), (1.5, 1.79), stroke: 0.6pt)

      // Ramo parabolico CD (fino a -12000 Nm in D)
      bezier((1.8, 2.0), (2.7, 3.05), (2.1, 2.25), (2.4, 2.6), stroke: 1pt)
      line((2.1, 2.0), (2.1, 2.27), stroke: 0.6pt)
      line((2.4, 2.0), (2.4, 2.62), stroke: 0.6pt)
      line((2.7, 2.0), (2.7, 3.05), stroke: 1pt)

      // Ramo parabolico DE (da -12000 Nm in D a -2000 Nm in E)
      bezier((2.7, 3.05), (3.6, 2.25), (3.0, 2.65), (3.3, 2.38), stroke: 1pt)
      line((3.0, 2.0), (3.0, 2.69), stroke: 0.6pt)
      line((3.3, 2.0), (3.3, 2.43), stroke: 0.6pt)
      line((3.6, 2.0), (3.6, 2.25), stroke: 1pt)

      // Diagramma triangolare su EF (da 0 in F a -2000 Nm in E)
      line((3.6, 0), (4.25, 2.0), (3.6, 2.0), stroke: 1pt)
      line((3.6, 0.4), (3.73, 0.4), stroke: 0.6pt)
      line((3.6, 0.8), (3.86, 0.8), stroke: 0.6pt)
      line((3.6, 1.2), (3.99, 1.2), stroke: 0.6pt)
      line((3.6, 1.6), (4.12, 1.6), stroke: 0.6pt)

      // Etichette (con text(size: 7pt))
      content((0.9, 1.55), text(size: 7pt)[$4000 "Nm"$], anchor: "north")
      content((2.65, 3.15), text(size: 7pt)[$-12000 "Nm"$], anchor: "south")
      content((3.45, 2.48), text(size: 7pt)[$-2000 "Nm"$], anchor: "south")
      content((4.3, 2.05), text(size: 7pt)[$-2000 "Nm"$], anchor: "west")
      content((0.12, 0.05), text(size: 7pt)[$A$], anchor: "west")
      content((-0.12, 1.88), text(size: 7pt)[$B$], anchor: "east")
      content((1.8, 1.8), text(size: 7pt)[$C$], anchor: "north")
      content((2.7, 1.8), text(size: 7pt)[$D$], anchor: "north")
      content((3.48, 0.05), text(size: 7pt)[$F$], anchor: "east")
      content((1.8, 0.75), text(size: 7pt)[*Mf*], anchor: "center")
    })
    // FASE 3: VERIFICA
    // 3 bezier per i tre rami parabolici di momento flettente. 10 etichette tutte con text(size: 7pt).
  ]
)
#v(1em)

=== 4) Individuazione della sezione più sollecitata e dimensionamento
Dall'analisi dei diagrammi delle azioni interne per la *Versione D*, la sezione più sollecitata risulta essere la *sezione $D$*, nella quale agiscono:
$ abs(M_f) = 12000 "Nm" = 12 dot 10^6 "N" dot "mm", wide abs(N) = 500 "N" $

*Caratteristiche del materiale e tensione ammissibile:*
Poiché l'allungamento percentuale a rottura è $A = 4 % < 5 %$, il materiale ha comportamento *fragile*:
$ A = 4 % arrow.r.double "Materiale Fragile" arrow.r.double sigma_("lim") = R_m = 360 "MPa" $
Con un coefficiente di sicurezza $S = 3$, la tensione ammissibile vale:
$ S = 3 arrow.r.double sigma_("amm") = sigma_("lim") / S = 360 / 3 = 120 "MPa" $

*Criterio di resistenza e dimensionamento della sezione quadrata:*
Trattandosi di materiale fragile soggetto a sforzo normale e flessione, adottiamo il *Criterio di Galileo* (della massima tensione principale):
$ sigma_("id") = sigma_("lim") / S arrow.r.double "CRITERIO GALILEO" arrow.r.double sigma_("id") = sigma_1 = sigma_N + sigma_(M_f) $
Esprimendo l'area $A = a^2$ e il modulo di resistenza a flessione $W_f = a^3 / 6$ di una sezione quadrata piena di lato $a$:
$ N / A + M_f / W_f = sigma_("amm") arrow.r.double N / a^2 + M_f / (a^3 / 6) = sigma_("amm") $

Per risolvere l'equazione di terzo grado, *si trascura inizialmente $sigma_N$* (essendo il contributo dello sforzo normale molto piccolo rispetto a quello flettente):
$ M_f / (a^3 / 6) = sigma_("amm") arrow.r.double a = root(3, (6 M_f) / sigma_("amm")) = root(3, (6 dot 12 dot 10^6) / 120) = 84,3 "mm" arrow.r.double a approx 85 "mm" $

*Verifica finale con $a = 85 "mm"$:*
Tenendo ora conto anche del contributo dello sforzo normale $N = 500 "N"$, verifichiamo che la tensione ideale non superi la tensione ammissibile:
$ sigma_("id") lt.eq sigma_("amm") arrow.r.double N / a^2 + M_f / (a^3 / 6) = 500 / 85^2 + (12 dot 10^6) / (85^3 / 6) = 0,069 + 117,15 = 117,2 "MPa" lt.eq 120 "MPa" arrow.r.double "OK" $
Il dimensionamento con lato $a = 85 "mm"$ è pertanto verificato.
#pagebreak()


= Fondamenti di Meccanica Strutturale - Testo d'Esame (09/02/2026)

== Esercizio 1 
Un componente meccanico realizzato in ghisa ($E = 180000 "MPa"$, coefficiente di Poisson $nu = 0,3$, allungamento percentuale a rottura $A_r = 4 %$, tensione di rottura a trazione $R_m = 600 "MPa"$) si trova in uno stato di deformazione piana nella direzione dell'asse $y$.
In un punto del componente è noto che le tensioni normali lungo gli assi $x$ e $z$ sono uguali ($sigma_(z z) = sigma_(x x)$), che la tensione media idrostatica vale $sigma_m = 100 "MPa"$ e che il coefficiente di sicurezza a rottura è pari a $s = 2$.

*Dati del problema:*
    - Materiale: Ghisa ($E = 180000 "MPa"$, $nu = 0,3$)
    - Allungamento a rottura: $A_r = 4 %$
    - Tensione limite di rottura: $R_m = 600 "MPa"$
    - Stato di deformazione piana in direzione $y$ ($epsilon_(y y) = 0$, $gamma_(x y) = gamma_(y z) = 0$)
    - Relazione tra le tensioni normali: $sigma_(z z) = sigma_(x x)$
    - Tensione media idrostatica: $sigma_m = 100 "MPa"$
    - Coefficiente di sicurezza a rottura: $s = 2$

    *Quesiti:*
    + Calcolare le componenti di tensione normale $sigma_(x x)$, $sigma_(y y)$ e $sigma_(z z)$ sfruttando la condizione di deformazione piana e il valore della tensione media $sigma_m$.
    + Determinare le componenti di tensione tangenziale $tau$ agenti sull'elementino di materiale sapendo che il coefficiente di sicurezza a rottura è $s = 2$.
    + Scrivere il tensore degli sforzi completo, rappresentare lo stato tensionale sull'elementino cubico con la costruzione inversa e tracciare l'arbelo dei cerchi di Mohr determinando le tensioni principali $sigma_1$, $sigma_2$, $sigma_3$.
    + Determinare, tramite i cerchi di Mohr e per via analitica, l'angolo $alpha$ compreso tra la direzione principale $1$ e l'asse $x$.


#pagebreak()



== Esercizio 2
Si consideri la struttura piana isostatica $A B C D E F$ rappresentata in figura, costituita da aste aventi tutte sezione circolare piena di diametro $D = 45 "mm"$ e realizzata in acciaio con tensione di snervamento $sigma_S = 300 "MPa"$.
La struttura è vincolata a terra mediante un carrello ad asse orizzontale in $A$, una cerniera fissa in $D$ e un carrello ad asse verticale in $E$. Nel nodo $C$ il tratto orizzontale di sinistra $B C$ si innesta sul montante verticale continuo $F C E$ tramite una cerniera interna, immediatamente a sinistra della quale agisce una coppia concentrata oraria $M$. Nei nodi $B$ ed $F$ agiscono due forze orizzontali concentrate di intensità $F$ dirette verso destra, mentre lungo il tratto verticale superiore $C E$ agisce un carico distribuito orizzontale uniforme $q$ diretto verso sinistra.
 *Dati del problema:*
    - Lunghezza caratteristica: $L = 1000 "mm" = 1 "m"$
    - Carico distribuito: $q = 1000 "N/m"$
    - Forze concentrate: $F = 1000 "N"$
    - Coppia concentrata: $M = 1000 "Nm"$
    - Diametro della sezione circolare piena: $D = 45 "mm"$
    - Tensione di snervamento del materiale: $sigma_S = 300 "MPa"$

    *Quesiti:*
    + Calcolare le reazioni vincolari esterne in $A$, $D$ ed $E$.
    + Determinare analiticamente le caratteristiche di sollecitazione ($N$, $T$, $M_f$) in tutti i tratti della struttura e tracciarne i relativi diagrammi quotati.
    + Individuare la sezione e il punto più sollecitato della struttura, tracciare l'andamento delle tensioni normali sulla sezione critica e calcolare il coefficiente di sicurezza a snervamento $C S$.
    
    #align(center)[#canvas(length: 3cm, {
      import draw: *

      // Struttura principale
      line((0, 0), (0, 1.6), (1.42, 1.6), stroke: 1pt)
      line((1.6, 0), (1.6, 3.2), stroke: 1pt)
      line((1.6, 1.6), (3.2, 1.6), stroke: 1pt)

      // Cerniera interna a sinistra di C
      arc((1.51, 1.6), start: 90deg, stop: 270deg, radius: 0.09, anchor: "origin", stroke: 1pt)
      circle((1.51, 1.6), radius: 0.03, fill: black)

      // Vincolo in A (carrello ad asse orizzontale)
      line((0, 0), (-0.2, 0.12), (-0.2, -0.12), close: true, stroke: 0.6pt)
      circle((-0.24, 0.07), radius: 0.04, stroke: 0.6pt)
      circle((-0.24, -0.07), radius: 0.04, stroke: 0.6pt)
      line((-0.28, -0.18), (-0.28, 0.18), stroke: 0.6pt)

      // Vincolo in D (cerniera fissa a terra)
      line((3.2, 1.6), (3.08, 1.38), (3.32, 1.38), close: true, stroke: 0.6pt)
      line((3.02, 1.38), (3.38, 1.38), stroke: 0.6pt)

      // Vincolo in E (carrello ad asse verticale in alto)
      line((1.6, 3.2), (1.48, 3.38), (1.72, 3.38), close: true, stroke: 0.6pt)
      circle((1.53, 3.42), radius: 0.04, stroke: 0.6pt)
      circle((1.67, 3.42), radius: 0.04, stroke: 0.6pt)
      line((1.42, 3.46), (1.78, 3.46), stroke: 0.6pt)

      // Carichi applicati (in rosso come nell'originale)
      line((-0.65, 1.6), (-0.02, 1.6), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      line((0.95, 0), (1.58, 0), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      arc((1.3, 1.6), start: 110deg, stop: 250deg, radius: 0.28, anchor: "origin", stroke: (paint: red, thickness: 1pt), mark: (start: ">"))

      // Carico distribuito q su CE
      line((2.05, 1.6), (2.05, 3.2), stroke: (paint: red, thickness: 0.6pt))
      line((2.05, 1.6), (1.62, 1.6), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((2.05, 2.0), (1.62, 2.0), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((2.05, 2.4), (1.62, 2.4), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((2.05, 2.8), (1.62, 2.8), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((2.05, 3.2), (1.62, 3.2), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))

      // Quote L
      line((0, -0.45), (3.2, -0.45), stroke: 0.6pt)
      line((0, -0.35), (0, -0.55), stroke: 0.6pt)
      line((1.6, -0.35), (1.6, -0.55), stroke: 0.6pt)
      line((3.2, -0.35), (3.2, -0.55), stroke: 0.6pt)

      line((3.75, 0), (3.75, 3.2), stroke: 0.6pt)
      line((3.65, 0), (3.85, 0), stroke: 0.6pt)
      line((3.65, 1.6), (3.85, 1.6), stroke: 0.6pt)
      line((3.65, 3.2), (3.85, 3.2), stroke: 0.6pt)

      // Sezione circolare piena di diametro D (a destra)
      circle((4.85, 0.7), radius: 0.52, stroke: 1pt)
      line((4.8, 0.7), (4.9, 0.7), stroke: 0.6pt)
      line((4.85, 0.65), (4.85, 0.75), stroke: 0.6pt)
      line((4.2, 0.05), (4.46, 0.31), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((5.5, 1.35), (5.24, 1.09), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))

      // Etichette (tutte con text(size: 7pt))
      content((0.12, -0.05), text(size: 7pt)[$A$], anchor: "west")
      content((0.05, 1.72), text(size: 7pt)[$B$], anchor: "south")
      content((1.45, 1.38), text(size: 7pt)[$C$], anchor: "north")
      content((3.2, 1.72), text(size: 7pt)[$D$], anchor: "south")
      content((1.48, 3.15), text(size: 7pt)[$E$], anchor: "east")
      content((1.72, -0.05), text(size: 7pt)[$F$], anchor: "west")
      content((-0.45, 1.72), text(size: 7pt, fill: red)[$F$], anchor: "south")
      content((1.2, 0.12), text(size: 7pt, fill: red)[$F$], anchor: "south")
      content((1.05, 1.92), text(size: 7pt, fill: red)[$M$], anchor: "south")
      content((2.15, 2.55), text(size: 7pt, fill: red)[$q$], anchor: "west")
      content((0.8, -0.55), text(size: 7pt)[$L$], anchor: "north")
      content((2.4, -0.55), text(size: 7pt)[$L$], anchor: "north")
      content((3.9, 0.8), text(size: 7pt)[$L$], anchor: "west")
      content((3.9, 2.4), text(size: 7pt)[$L$], anchor: "west")
      content((5.55, 1.4), text(size: 7pt, fill: red)[$D$], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 1. Curve: archi per cerniera C e coppia M con start < stop e anchor: "origin"; cerchio per sezione circolare (r = 0.52).
    // 2. Tutte le 15 etichette usano text(size: 7pt). Nessun comando proibito.
  ]


// ==========================================
// PARTE 2: SOLUZIONI E PROCEDIMENTO COMPLETO
// ==========================================
= Soluzione dell'Esame

== Primo esercizio A) Soluzione

=== 1.1) Calcolo delle tensioni normali $sigma$
Poiché il componente si trova in uno *stato di deformazione piana in direzione $y$*, la deformazione normale lungo l'asse $y$ è identicamente nulla ($epsilon_(y y) = 0$). Applicando la legge di Hooke generalizzata per la componente $epsilon_(y y)$, possiamo esprimere $sigma_(y y)$ in funzione di $sigma_(x x)$ e $sigma_(z z)$:
$ epsilon_(y y) = 1 / E (sigma_(y y) - nu (sigma_(x x) + sigma_(z z))) = 0 $
Ricordando che dai dati del problema $sigma_(z z) = sigma_(x x)$, otteniamo:
$ sigma_(y y) = nu (sigma_(x x) + sigma_(z z)) = nu (sigma_(x x) + sigma_(x x)) = 2 nu sigma_(x x) $

Sfruttiamo ora la definizione di tensione media idrostatica $sigma_m = 100 "MPa"$:
$ sigma_m = (sigma_(x x) + sigma_(y y) + sigma_(z z)) / 3 = (sigma_(x x) + 2 nu sigma_(x x) + sigma_(x x)) / 3 $
Raccogliendo $sigma_(x x)$ a fattor comune al numeratore:
$ sigma_(x x) (2 + 2 nu) = 3 dot sigma_m $
da cui ricaviamo immediatamente il valore numerico di $sigma_(x x)$, $sigma_(y y)$ e $sigma_(z z)$:
$ sigma_(x x) = (3 dot sigma_m) / (2 + 2 nu) = (3 dot 100) / (2 + 0,6) = 115 "MPa" $
$ sigma_(y y) = 2 nu sigma_(x x) = 0,6 dot 115 = 69 "MPa" $
$ sigma_(z z) = sigma_(x x) = 115 "MPa" $

=== 1.2) Calcolo delle tensioni tangenziali $tau$
Il materiale assegnato è una ghisa con allungamento a rottura $A_r = 4 % < 5 %$, pertanto presenta un comportamento *fragile*. Adottando il criterio di Galileo-Rankine (della massima tensione principale), la tensione ideale coincide con la tensione principale massima $sigma_1$:
$ s = R_m / sigma_("id") = R_m / sigma_1 quad ("perché mat. fragile :" quad sigma_("id") = sigma_1) $
Imponendo il coefficiente di sicurezza a rottura $s = 2$, ricaviamo la tensione principale massima $sigma_1$:
$ sigma_1 = R_m / 2 = 600 / 2 = 300 "MPa" $

D'altra parte, la condizione di stato di deformazione piana in direzione $y$ implica che gli scorrimenti angolari associati alla direzione $y$ siano nulli ($gamma_(x y) = gamma_(y z) = 0$), e quindi:
$ "stato def piana in dir " y : quad tau_(x y) = tau_(y z) = 0 $
L'unica componente di tensione tangenziale non nulla è pertanto $tau_(x z)$, per cui il tensore degli sforzi assume la forma:
$ [sigma] = mat(delim: "[",
  sigma_(x x), 0, tau_(x z);
  0, sigma_(y y), 0;
  tau_(x z), 0, sigma_(z z)
) $

Per determinare l'incognita $tau_(x z)$, scriviamo l'*equazione caratteristica* (annullando il determinante della matrice $[sigma - sigma_1 I]$ in corrispondenza dell'autovalore noto $sigma_1 = 300 "MPa"$):
$ det mat(delim: "[",
  sigma_(x x) - sigma_1, 0, tau_(x z);
  0, sigma_(y y) - sigma_1, 0;
  tau_(x z), 0, sigma_(z z) - sigma_1
) = 0 $
Sviluppando il determinante rispetto alla seconda riga otteniamo:
$ (sigma_(y y) - sigma_1) ((sigma_(x x) - sigma_1)(sigma_(z z) - sigma_1) - tau_(x z)^2) = 0 $
Poiché $sigma_(y y) = 69 "MPa" eq.not sigma_1 = 300 "MPa"$, deve necessariamente annullarsi il secondo fattore, da cui ricaviamo $tau_(x z)$:
$ tau_(x z) = sqrt((sigma_(x x) - sigma_1)(sigma_(z z) - sigma_1)) = sqrt((-185)(-185)) = 185 "MPa" $

=== 1.3) Cerchi di Mohr con costruzione inversa e tensioni principali
Nota la componente $tau_(x z) = 185 "MPa"$, il tensore degli sforzi completo risulta:
$ [sigma] = mat(delim: "[",
  115, 0, 185;
  0, 69, 0;
  185, 0, 115
) "MPa" $

Nel piano principale $(x, z)$, il cerchio di Mohr associato ha centro di ascissa $C$ e raggio $r$ pari a:
$ C = (sigma_(x x) + sigma_(z z)) / 2 = 115 "MPa" $
$ r = sqrt(((sigma_(x x) - sigma_(z z)) / 2)^2 + tau_(x z)^2) = tau_(x z) = 185 "MPa" $
Le tre tensioni principali ordinate ($sigma_1 gt.eq sigma_2 gt.eq sigma_3$) valgono quindi:
$ sigma_1 = C + r = 115 + 185 = 300 "MPa" $
$ sigma_2 = sigma_(y y) = 69 "MPa" $
$ sigma_3 = C - r = 115 - 185 = -69 "MPa" $

#grid(
  columns: (0.9fr, 1.1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Elementino cubico 3D con costruzione inversa: sulla faccia di normale x (contrassegnata dal pallino vuoto o) la tensione tangenziale tau_xz (verticale verso l'alto) tende a far ruotare l'elementino in senso antiorario attorno a y, quindi sul piano di Mohr il punto rappresentativo della faccia x ha ordinata positiva (+tau_xz, pallino vuoto o in alto). Sulla faccia superiore di normale z (contrassegnata dal pallino pieno) la tau_xz tende a ruotare in senso orario, quindi ha ordinata negativa (-tau_xz, pallino pieno in basso).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, stessa geometria del cubo in prospettiva con aggiunta dei contrassegni circolare vuoto (-0.45, 0.65) sulla faccia x e circolare pieno (0.05, 1.35) sulla faccia z.
    // 2. ELEMENTI: 3 facce del cubo, assi x, y, z, vettori sigma_xx, sigma_yy, sigma_zz, tau_xz, pallino vuoto e pallino pieno. Tutte le 8 etichette con text(size: 7pt).
    // FASE 2: COSTRUZIONE
    #canvas(length: 1cm, {
      import draw: *

      // Facce del cubo
      line((-0.7, -0.55), (0.9, -0.55), (0.9, 1.05), (-0.7, 1.05), close: true, stroke: 1pt)
      line((-0.7, 1.05), (0.9, 1.05), (1.6, 1.6), (0, 1.6), close: true, stroke: 1pt)
      line((0.9, -0.55), (1.6, 0), (1.6, 1.6), (0.9, 1.05), close: true, stroke: 1pt)

      // Contrassegni facce per costruzione di Mohr: pallino vuoto su faccia x, pallino pieno su faccia z
      circle((-0.45, 0.65), radius: 0.08, fill: white, stroke: 1pt)
      circle((0.05, 1.35), radius: 0.08, fill: black, stroke: 1pt)

      // Assi e tensioni
      line((0.45, 1.32), (0.45, 2.35), stroke: 1pt, mark: (end: ">"))
      line((1.25, 0.52), (2.5, 0.52), stroke: 1pt, mark: (end: ">"))
      line((0.1, 0.25), (-0.95, -0.58), stroke: 1pt, mark: (end: ">"))

      line((0.65, 1.32), (0.65, 2.15), stroke: 0.6pt, mark: (end: ">"))
      line((1.25, 0.72), (2.15, 0.72), stroke: 0.6pt, mark: (end: ">"))
      line((-0.1, 0.09), (-0.65, -0.35), stroke: 0.6pt, mark: (end: ">"))

      line((0.45, 1.32), (1.2, 1.92), stroke: 0.6pt, mark: (end: ">"))
      line((0.1, -0.35), (0.1, 0.65), stroke: 0.6pt, mark: (end: ">"))

      // Etichette (con text(size: 7pt))
      content((0.3, 2.3), text(size: 7pt)[$z$], anchor: "east")
      content((2.4, 0.35), text(size: 7pt)[$y$], anchor: "north")
      content((-1.0, -0.62), text(size: 7pt)[$x$], anchor: "north")
      content((0.75, 2.1), text(size: 7pt)[$sigma_(z z)$], anchor: "west")
      content((2.0, 0.85), text(size: 7pt)[$sigma_(y y)$], anchor: "south")
      content((-0.45, -0.38), text(size: 7pt)[$sigma_(x x)$], anchor: "north")
      content((1.25, 1.95), text(size: 7pt)[$tau_(x z)$], anchor: "west")
      content((0.2, -0.15), text(size: 7pt)[$tau_(x z)$], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 2 cerchi di raggio 0.08 per i contrassegni delle facce, 8 etichette con text(size: 7pt).
  ],
  [
    
    #canvas(length: 1.8cm, {
      import draw: *

      // Assi sigma e tau
      line((-1.1, 0), (3.1, 0), stroke: 0.6pt, mark: (end: ">"))
      line((0, -1.8), (0, 2.1), stroke: 0.6pt, mark: (end: ">"))

      // Tre cerchi di Mohr
      circle((0.925, 0), radius: 1.475, stroke: 1pt)
      circle((0, 0), radius: 0.55, stroke: 0.6pt)
      circle((1.475, 0), radius: 0.925, stroke: 0.6pt)

      // Diametro verticale passante per C = 0.925
      line((0.925, -1.475), (0.925, 1.475), stroke: 0.6pt)
      line((-0.08, 1.475), (0.08, 1.475), stroke: 0.6pt)

      // Poli delle facce x (pallino vuoto in alto) e z (pallino pieno in basso)
      circle((0.925, 1.475), radius: 0.07, fill: white, stroke: 1pt)
      circle((0.925, -1.475), radius: 0.07, fill: black, stroke: 1pt)

      // Crocette sulle tensioni principali sigma_3, sigma_2, sigma_1
      line((-0.62, -0.07), (-0.48, 0.07), stroke: 0.6pt)
      line((-0.62, 0.07), (-0.48, -0.07), stroke: 0.6pt)
      line((0.48, -0.07), (0.62, 0.07), stroke: 0.6pt)
      line((0.48, 0.07), (0.62, -0.07), stroke: 0.6pt)
      line((2.33, -0.07), (2.47, 0.07), stroke: 0.6pt)
      line((2.33, 0.07), (2.47, -0.07), stroke: 0.6pt)

      // Etichette (con text(size: 7pt))
      content((3.05, -0.15), text(size: 7pt)[$sigma$], anchor: "north")
      content((-0.15, 2.0), text(size: 7pt)[$tau$], anchor: "east")
      content((-0.15, 1.475), text(size: 7pt)[$tau_(x z)$], anchor: "east")
      content((-0.6, -0.18), text(size: 7pt)[$sigma_3$], anchor: "north")
      content((0.42, -0.18), text(size: 7pt)[$sigma_2$], anchor: "north")
      content((1.35, -0.18), text(size: 7pt)[$sigma_(x x) = sigma_(z z)$], anchor: "north")
      content((2.5, -0.18), text(size: 7pt)[$sigma_1$], anchor: "north")
    })
    // FASE 3: VERIFICA
    // 3 cerchi di Mohr tangentemente inscritti in (-0.55, 0), (0.55, 0), (2.40, 0). 7 etichette con text(size: 7pt).
  ]
)
#v(1em)

=== 1.4) Angolo tra la direzione principale $1$ e l'asse $x$
Determiniamo infine l'angolo $alpha$ di cui occorre ruotare l'asse $x$ per sovrapporlo alla direzione principale $1$ (associata a $sigma_1$).

#grid(
  columns: (1.1fr, 0.9fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    Sul cerchio di Mohr nel piano $(x, z)$, il punto rappresentativo della giacitura di normale $x$ ha coordinate $(sigma_(x x), tau_(x z)) = (115, 185) "MPa"$ e si trova esattamente sulla verticale del centro $C = 115 "MPa"$.

    L'angolo al centro $2 alpha$ compreso tra il raggio diretto verso $(sigma_1, 0)$ e il raggio diretto verso il polo della faccia $x$ di coordinate $(sigma_(x x), tau_(x z))$ soddisfa la relazione trigonometrica:
    $ tan (2 alpha) = tau_(x z) / (sigma_(x x) - C) = 185 / (115 - 115) = infinity $
    da cui segue immediatamente:
    $ 2 alpha = 90^degree arrow.r alpha = 45^degree $
  ],
  [
    
    #canvas(length: 1.8cm, {
      import draw: *

      // Assi sigma e tau
      line((-1.1, 0), (3.1, 0), stroke: 0.6pt, mark: (end: ">"))
      line((0, -1.8), (0, 2.1), stroke: 0.6pt, mark: (end: ">"))

      // Tre cerchi di Mohr
      circle((0.925, 0), radius: 1.475, stroke: 1pt)
      circle((0, 0), radius: 0.55, stroke: 0.6pt)
      circle((1.475, 0), radius: 0.925, stroke: 0.6pt)

      // Raggio verticale C -> (sigma_xx, tau_xz) e arco angolo 2*alpha
      line((0.925, 0), (0.925, 1.475), stroke: 0.6pt)
      arc((0.925, 0), start: 0deg, stop: 90deg, radius: 0.42, anchor: "origin", stroke: 0.6pt)

      // Tacche su tau_xz e -tau_xz e poli
      line((-0.08, 1.475), (0.08, 1.475), stroke: 0.6pt)
      line((-0.08, -1.475), (0.08, -1.475), stroke: 0.6pt)
      circle((0.925, 1.475), radius: 0.07, fill: white, stroke: 1pt)
      circle((0.925, -1.475), radius: 0.07, fill: black, stroke: 1pt)

      // Crocette sulle tensioni principali
      line((-0.62, -0.07), (-0.48, 0.07), stroke: 0.6pt)
      line((-0.62, 0.07), (-0.48, -0.07), stroke: 0.6pt)
      line((0.48, -0.07), (0.62, 0.07), stroke: 0.6pt)
      line((0.48, 0.07), (0.62, -0.07), stroke: 0.6pt)
      line((2.33, -0.07), (2.47, 0.07), stroke: 0.6pt)
      line((2.33, 0.07), (2.47, -0.07), stroke: 0.6pt)

      // Etichette (con text(size: 7pt))
      content((3.05, -0.15), text(size: 7pt)[$sigma$], anchor: "north")
      content((-0.15, 2.0), text(size: 7pt)[$tau$], anchor: "east")
      content((-0.15, 1.475), text(size: 7pt)[$tau_(x z)$], anchor: "east")
      content((-0.15, -1.475), text(size: 7pt)[$-tau_(x z)$], anchor: "east")
      content((0.95, 1.62), text(size: 7pt)[$(sigma_(x x), tau_(x z))$], anchor: "south")
      content((1.25, 0.35), text(size: 7pt)[$2 alpha$], anchor: "south")
      content((-0.6, -0.18), text(size: 7pt)[$sigma_3$], anchor: "north")
      content((0.42, -0.18), text(size: 7pt)[$sigma_2 equiv sigma_(y y)$], anchor: "north")
      content((1.2, -0.18), text(size: 7pt)[$sigma_(x x) equiv C$], anchor: "north")
      content((2.5, -0.18), text(size: 7pt)[$sigma_1$], anchor: "north")
    })
    
  ]
)

#pagebreak()


#pagebreak()

// ==========================================
// PARTE 2: SOLUZIONI E PROCEDIMENTO COMPLETO
// 

== Secondo esercizio) Soluzione

=== 1) Calcolo delle reazioni vincolari
Svincoliamo la struttura sostituendo ai vincoli esterni le rispettive reazioni: la forza orizzontale $H_A$ in $A$, le componenti orizzontale $H_D$ e verticale $V_D$ in $D$, e la forza verticale $V_E$ in $E$.

#align(center)[
    #canvas(length: 3cm, {
      import draw: *

      // Struttura
      line((0, 0), (0, 1.5), (1.32, 1.5), stroke: 1pt)
      line((1.5, 0), (1.5, 3.0), stroke: 1pt)
      line((1.5, 1.5), (3.0, 1.5), stroke: 1pt)

      // Cerniera interna a sinistra di C
      arc((1.41, 1.5), start: 90deg, stop: 270deg, radius: 0.09, anchor: "origin", stroke: 1pt)
      circle((1.41, 1.5), radius: 0.03, fill: black)

      // Reazioni vincolari H_A, V_E, H_D, V_D
      line((-0.55, 0), (-0.02, 0), stroke: 1pt, mark: (end: ">"))
      line((1.5, 3.0), (1.5, 3.65), stroke: 1pt, mark: (end: ">"))
      line((3.0, 1.5), (3.55, 1.5), stroke: 1pt, mark: (end: ">"))
      line((3.0, 0.9), (3.0, 1.48), stroke: 1pt, mark: (end: ">"))

      // Carichi attivi F, M, q
      line((-0.6, 1.5), (-0.02, 1.5), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      line((0.9, 0), (1.48, 0), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      arc((1.22, 1.5), start: 110deg, stop: 250deg, radius: 0.26, anchor: "origin", stroke: (paint: red, thickness: 1pt), mark: (start: ">"))

      line((1.92, 1.5), (1.92, 3.0), stroke: (paint: red, thickness: 0.6pt))
      line((1.92, 1.5), (1.52, 1.5), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((1.92, 1.88), (1.52, 1.88), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((1.92, 2.25), (1.52, 2.25), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((1.92, 2.62), (1.52, 2.62), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((1.92, 3.0), (1.52, 3.0), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))

      // Etichette (con text(size: 7pt))
      content((-0.3, 0.12), text(size: 7pt)[$H_A$], anchor: "south")
      content((0.12, -0.05), text(size: 7pt)[$A$], anchor: "west")
      content((0.05, 1.62), text(size: 7pt)[$B$], anchor: "south")
      content((1.35, 1.28), text(size: 7pt)[$C$], anchor: "north")
      content((2.9, 1.62), text(size: 7pt)[$D$], anchor: "south")
      content((1.38, 2.95), text(size: 7pt)[$E$], anchor: "east")
      content((1.62, -0.05), text(size: 7pt)[$F$], anchor: "west")
      content((1.62, 3.45), text(size: 7pt)[$V_E$], anchor: "west")
      content((3.35, 1.62), text(size: 7pt)[$H_D$], anchor: "south")
      content((3.12, 1.15), text(size: 7pt)[$V_D$], anchor: "west")
      content((-0.4, 1.62), text(size: 7pt, fill: red)[$F$], anchor: "south")
      content((1.15, 0.12), text(size: 7pt, fill: red)[$F$], anchor: "south")
      content((0.98, 1.8), text(size: 7pt, fill: red)[$M$], anchor: "south")
      content((2.02, 2.35), text(size: 7pt, fill: red)[$q$], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 14 etichette tutte con text(size: 7pt).
  ]
  
Scriviamo le tre equazioni cardinali della statica per l'intera struttura (traslazione orizzontale, traslazione verticale e rotazione attorno al polo $D$):
    $ cases(
      arrow.r quad H_A + H_D + F + F - q L = 0 quad &(1),
      arrow.t quad V_D + V_E = 0 quad &(2),
      D^("orario") quad H_A dot L + F L - V_E L + (q L^2) / 2 - M = 0 quad &(3)
    ) $

    Aggiungiamo l'equazione ausiliaria di equilibrio alla rotazione attorno alla cerniera interna $C$ per la sottostruttura di sinistra ($C_("AUX")^("sx")$):
    $ C_("AUX")^("sx")) quad H_A dot L - M = 0 arrow.r.double H_A = M / L = 1000 "N" quad (4) $

    Sostituendo a cascata nelle equazioni globali otteniamo:
    - *Da eq. (1):*
      $ H_D = -H_A - 2 F + q L = -1000 - 2000 + 1000 = -2000 "N" $
    - *Da eq. (3):*
      $ V_E = H_A + F + (q L) / 2 - M / L = 1000 + 1000 + 500 - 1000 = 1500 "N" $
    - *Da eq. (2):*
      $ V_D = -V_E = -1500 "N" $
#v(1em)

=== 2) Determinazione delle caratteristiche di sollecitazione
Per determinare le azioni interne nei cinque rami della struttura, pratichiamo le cinque sezioni $S_1^+$, $S_2^+$, $S_3^-$, $S_4^-$ e $S_5^-$ indicate nello schema seguente.

#align(center)[
    // FASE 0: COMPRENSIONE
    // Schema globale della struttura con indicazione delle 5 sezioni di calcolo S_1^+, S_2^+, S_3^-, S_4^-, S_5^- (pagina 2 in basso).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, stessa scala (L = 1.5 cm).
    // 2. ELEMENTI: Struttura, carichi, reazioni e 5 linee di taglio ondulate in rosso per S_1^+, S_2^+, S_3^-, S_4^-, S_5^-.
    // FASE 2: COSTRUZIONE
    #canvas(length: 3cm, {
      import draw: *

      // Struttura
      line((0, 0), (0, 1.5), (1.32, 1.5), stroke: 1pt)
      line((1.5, 0), (1.5, 3.0), stroke: 1pt)
      line((1.5, 1.5), (3.0, 1.5), stroke: 1pt)

      arc((1.41, 1.5), start: 90deg, stop: 270deg, radius: 0.09, anchor: "origin", stroke: 1pt)
      circle((1.41, 1.5), radius: 0.03, fill: black)

      // Reazioni e carichi
      line((-0.5, 0), (-0.02, 0), stroke: 1pt, mark: (end: ">"))
      line((1.5, 3.0), (1.5, 3.6), stroke: 1pt, mark: (end: ">"))
      line((3.0, 1.5), (3.5, 1.5), stroke: 1pt, mark: (end: ">"))
      line((3.0, 0.95), (3.0, 1.48), stroke: 1pt, mark: (end: ">"))

      line((-0.55, 1.5), (-0.02, 1.5), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      line((0.95, 0), (1.48, 0), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      arc((1.22, 1.5), start: 110deg, stop: 250deg, radius: 0.25, anchor: "origin", stroke: (paint: red, thickness: 1pt), mark: (start: ">"))

      line((1.88, 1.5), (1.88, 3.0), stroke: (paint: red, thickness: 0.6pt))
      line((1.88, 1.5), (1.52, 1.5), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((1.88, 2.0), (1.52, 2.0), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((1.88, 2.5), (1.52, 2.5), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((1.88, 3.0), (1.52, 3.0), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))

      // Segni delle 5 sezioni S_1^+, S_2^+, S_3^-, S_4^-, S_5^-
      line((-0.18, 0.75), (0.18, 0.8), stroke: (paint: red, thickness: 0.6pt))
      line((0.62, 1.32), (0.67, 1.68), stroke: (paint: red, thickness: 0.6pt))
      line((1.32, 0.75), (1.68, 0.8), stroke: (paint: red, thickness: 0.6pt))
      line((2.22, 1.32), (2.27, 1.68), stroke: (paint: red, thickness: 0.6pt))
      line((1.32, 2.35), (1.68, 2.4), stroke: (paint: red, thickness: 0.6pt))

      // Etichette (con text(size: 7pt))
      content((0.22, 0.68), text(size: 7pt, fill: red)[$S_1^+$], anchor: "west")
      content((0.65, 1.78), text(size: 7pt, fill: red)[$S_2^+$], anchor: "south")
      content((1.72, 0.68), text(size: 7pt, fill: red)[$S_3^-$], anchor: "west")
      content((2.3, 1.25), text(size: 7pt, fill: red)[$S_4^-$], anchor: "north")
      content((1.28, 2.45), text(size: 7pt, fill: red)[$S_5^-$], anchor: "east")
      content((-0.28, 0.12), text(size: 7pt)[$H_A$], anchor: "south")
      content((1.62, 3.4), text(size: 7pt)[$V_E$], anchor: "west")
      content((3.3, 1.62), text(size: 7pt)[$H_D$], anchor: "south")
      content((3.1, 1.15), text(size: 7pt)[$V_D$], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 9 etichette tutte con text(size: 7pt).
  ]

Le cinque sezioni sono scelte in modo da semplificare al massimo le equazioni di equilibrio di ciascun sottosistema:
    - *Sezione $S_1^+$ ($0 lt.eq x lt.eq L$):* lungo il ritto sinistro $A B$, partendo da $A$ verso $B$.
    - *Sezione $S_2^+$ ($0 lt.eq x lt.eq L$):* lungo il traverso $B C$, partendo da $B$ verso la cerniera in $C$.
    - *Sezione $S_3^-$ ($0 lt.eq x lt.eq L$):* lungo il tratto verticale inferiore $F C$, partendo dall'estremo libero $F$ verso $C$.
    - *Sezione $S_4^-$ ($0 lt.eq x lt.eq L$):* lungo il traverso di destra $D C$, partendo dalla cerniera $D$ verso il nodo $C$.
    - *Sezione $S_5^-$ ($0 lt.eq x lt.eq L$):* lungo il tratto verticale superiore $E C$, partendo da $E$ verso il nodo $C$.
#v(1em)

*Sezione $S_1^+$ ($0 lt.eq x lt.eq L$):*

#grid(
  columns: (0.7fr, 1.3fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Schema di corpo libero per la sezione S_1^+ (da A verso B, 0 <= x <= L).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, A=(0,0), S_1^+=(0, 1.3).
    // 2. ELEMENTI: Asta verticale, reazione H_A, ascissa x, azioni interne N, T, M_f in rosso.
    // FASE 2: COSTRUZIONE
    #canvas(length: 2cm, {
      import draw: *

      line((0, 0), (0, 1.3), stroke: 1pt)
      circle((0, 0), radius: 0.05, fill: black)

      // Reazione H_A e ascissa x
      line((-0.55, 0), (-0.05, 0), stroke: 1pt, mark: (end: ">"))
      line((0.45, 0), (0.65, 0), stroke: 0.6pt)
      line((0.55, 0), (0.55, 0.35), stroke: 0.6pt, mark: (end: ">"))

      // Azioni interne in S_1^+
      line((0, 1.3), (0, 1.85), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      line((0, 1.3), (0.55, 1.3), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      arc((0, 1.3), start: 110deg, stop: 240deg, radius: 0.3, anchor: "origin", stroke: (paint: red, thickness: 1pt), mark: (end: ">"))

      // Etichette
      content((-0.3, -0.15), text(size: 7pt)[$H_A$], anchor: "north")
      content((0.12, -0.05), text(size: 7pt)[$A$], anchor: "west")
      content((0.68, 0.25), text(size: 7pt)[$x$], anchor: "west")
      content((0.12, 1.75), text(size: 7pt, fill: red)[$N$], anchor: "west")
      content((0.45, 1.18), text(size: 7pt, fill: red)[$T$], anchor: "north")
      content((-0.32, 1.25), text(size: 7pt, fill: red)[$M_f$], anchor: "east")
      content((0.1, 1.05), text(size: 7pt, fill: red)[$S_1^+$], anchor: "west")
    })
    // FASE 3: VERIFICA
    // Arco M_f con start=110deg < stop=240deg e anchor: "origin". 7 etichette con text(size: 7pt).
  ],
  [
    Dall'equilibrio del tratto verticale inferiore $A S_1^+$ si ha:
    - $arrow.t) quad N = 0 "N"$
    - $arrow.r) quad T + H_A = 0 arrow.r.double T = -H_A = -1000 "N"$
    - $S_1^+) quad M_f + H_A x = 0 arrow.r.double M_f = -H_A x = cases(
        x = 0 : quad M_f = 0 "Nm" quad (A),
        x = L : quad M_f = -H_A L = -1000 "Nm" quad (B)
      )$
  ]
)
#v(0.5em)

*Sezione $S_2^+$ ($0 lt.eq x lt.eq L$):*

#grid(
  columns: (0.7fr, 1.3fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Schema di corpo libero per la sezione S_2^+ (ritto AB + tratto orizzontale di lunghezza x da B).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, A=(0,0), B=(0, 1.4), S_2^+=(1.2, 1.4).
    // 2. ELEMENTI: Ritto AB + tratto B-S_2^+, H_A in A, F in B, quota L, ascissa x, azioni N, T, M_f in rosso.
    // FASE 2: COSTRUZIONE
    #canvas(length: 2cm, {
      import draw: *

      line((0, 0), (0, 1.4), (1.2, 1.4), stroke: 1pt)
      circle((0, 0), radius: 0.05, fill: black)

      // H_A, F e ascissa x
      line((-0.5, 0), (-0.05, 0), stroke: 1pt, mark: (end: ">"))
      line((-0.55, 1.4), (-0.02, 1.4), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      line((0, 1.65), (0.35, 1.65), stroke: 0.6pt, mark: (end: ">"))
      line((-0.65, 0), (-0.65, 1.4), stroke: 0.6pt)

      // Azioni interne in S_2^+
      line((1.2, 1.4), (1.75, 1.4), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      line((1.2, 1.4), (1.2, 0.85), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      arc((1.2, 1.4), start: -30deg, stop: 90deg, radius: 0.3, anchor: "origin", stroke: (paint: red, thickness: 1pt), mark: (end: ">"))

      // Etichette
      content((-0.28, 0.12), text(size: 7pt)[$H_A$], anchor: "south")
      content((0.12, -0.05), text(size: 7pt)[$A$], anchor: "west")
      content((0.05, 1.48), text(size: 7pt)[$B$], anchor: "south")
      content((-0.35, 1.52), text(size: 7pt, fill: red)[$F$], anchor: "south")
      content((0.35, 1.78), text(size: 7pt)[$x$], anchor: "south")
      content((-0.75, 0.7), text(size: 7pt)[$L$], anchor: "east")
      content((1.7, 1.52), text(size: 7pt, fill: red)[$N$], anchor: "south")
      content((1.32, 0.9), text(size: 7pt, fill: red)[$T$], anchor: "west")
      content((1.45, 1.72), text(size: 7pt, fill: red)[$M_f$], anchor: "south")
      content((1.05, 1.25), text(size: 7pt, fill: red)[$S_2^+$], anchor: "north")
    })
    // FASE 3: VERIFICA
    // Arco M_f con start=-30deg < stop=90deg e anchor: "origin". 10 etichette con text(size: 7pt).
  ],
  [
    Dall'equilibrio del sottosistema a sinistra di $S_2^+$ otteniamo:
    - $arrow.r) quad N + F + H_A = 0 arrow.r.double N = -F - H_A = -2000 "N"$
    - $arrow.t) quad -T = 0 arrow.r.double T = 0 "N"$
    - $S_2^+) quad M_f + H_A L = 0 arrow.r.double M_f = -H_A L = -1000 "Nm"$
  ]
)
#v(0.5em)

*Sezione $S_3^-$ ($0 lt.eq x lt.eq L$):*

#grid(
  columns: (0.7fr, 1.3fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Schema di corpo libero per la sezione S_3^- (da F verso C, 0 <= x <= L).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, F=(0,0), S_3^-=(0, 1.2).
    // 2. ELEMENTI: Asta verticale, forza F in F, ascissa x verso l'alto, azioni N, T, M_f in rosso.
    // FASE 2: COSTRUZIONE
    #canvas(length: 2cm, {
      import draw: *

      line((0, 0), (0, 1.2), stroke: 1pt)

      // Forza F e ascissa x
      line((-0.55, 0), (-0.02, 0), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      line((0.35, 0), (0.55, 0), stroke: 0.6pt)
      line((0.45, 0), (0.45, 0.35), stroke: 0.6pt, mark: (end: ">"))

      // Azioni interne in S_3^-
      line((0, 1.2), (0, 1.75), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      line((0, 1.2), (0.55, 1.2), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      arc((0, 1.2), start: -30deg, stop: 90deg, radius: 0.3, anchor: "origin", stroke: (paint: red, thickness: 1pt), mark: (start: ">"))

      // Etichette
      content((-0.35, -0.15), text(size: 7pt, fill: red)[$F$], anchor: "north")
      content((0.12, -0.05), text(size: 7pt)[$F$], anchor: "west")
      content((0.58, 0.25), text(size: 7pt)[$x$], anchor: "west")
      content((0.12, 1.65), text(size: 7pt, fill: red)[$N$], anchor: "west")
      content((0.5, 1.08), text(size: 7pt, fill: red)[$T$], anchor: "north")
      content((0.32, 1.5), text(size: 7pt, fill: red)[$M_f$], anchor: "west")
      content((-0.12, 0.95), text(size: 7pt, fill: red)[$S_3^-$], anchor: "east")
    })
    // FASE 3: VERIFICA
    // Arco M_f con start=-30deg < stop=90deg e anchor: "origin". 7 etichette con text(size: 7pt).
  ],
  [
    Dall'equilibrio del tratto verticale inferiore $F S_3^-$ ricaviamo:
    - $arrow.t) quad N = 0 "N"$
    - $arrow.r) quad T + F = 0 arrow.r.double T = -F = -1000 "N"$
    - $S_3^-) quad -M_f + F x = 0 arrow.r.double M_f = F x = cases(
        M_f = 0 "Nm" quad (F),
        M_f = F L = 1000 "Nm" quad (C)
      )$
  ]
)
#v(0.5em)

*Sezione $S_4^-$ ($0 lt.eq x lt.eq L$):*

#grid(
  columns: (0.7fr, 1.3fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Schema di corpo libero per la sezione S_4^- (da D verso C, 0 <= x <= L).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, D=(1.2, 0), S_4^-=(0, 0).
    // 2. ELEMENTI: Asta orizzontale da (0,0) a (1.2,0), reazioni V_D e H_D in D, ascissa x da D verso sinistra, azioni interne N, T, M_f in S_4^-.
    // FASE 2: COSTRUZIONE
    #canvas(length: 2cm, {
      import draw: *

      line((0, 0), (1.2, 0), stroke: 1pt)
      circle((1.2, 0), radius: 0.05, fill: black)

      // Reazioni H_D e V_D e ascissa x
      line((1.2, 0), (1.75, 0), stroke: 1pt, mark: (end: ">"))
      line((1.2, -0.55), (1.2, -0.05), stroke: 1pt, mark: (end: ">"))
      line((1.15, 0.25), (1.15, 0.45), stroke: 0.6pt)
      line((1.15, 0.35), (0.8, 0.35), stroke: 0.6pt, mark: (end: ">"))

      // Azioni interne in S_4^-
      line((0, 0), (-0.55, 0), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      line((0, 0), (0, 0.55), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      arc((0, 0), start: 110deg, stop: 230deg, radius: 0.3, anchor: "origin", stroke: (paint: red, thickness: 1pt), mark: (start: ">"))

      // Etichette
      content((1.3, 0.12), text(size: 7pt)[$D$], anchor: "south")
      content((1.65, -0.15), text(size: 7pt)[$H_D$], anchor: "north")
      content((1.3, -0.4), text(size: 7pt)[$V_D$], anchor: "west")
      content((0.95, 0.48), text(size: 7pt)[$x$], anchor: "south")
      content((-0.5, 0.12), text(size: 7pt, fill: red)[$N$], anchor: "south")
      content((0.12, 0.45), text(size: 7pt, fill: red)[$T$], anchor: "west")
      content((-0.28, 0.35), text(size: 7pt, fill: red)[$M_f$], anchor: "south")
      content((0.05, -0.15), text(size: 7pt, fill: red)[$S_4^-$], anchor: "north")
    })
    // FASE 3: VERIFICA
    // Arco M_f con start=110deg < stop=230deg e anchor: "origin". 8 etichette con text(size: 7pt).
  ],
  [
    Dall'equilibrio del tratto orizzontale di destra $S_4^- D$ si ottiene:
    - $arrow.r) quad -N + H_D = 0 arrow.r.double N = H_D = -2000 "N"$
    - $arrow.t) quad T + V_D = 0 arrow.r.double T = -V_D = 1500 "N"$
    - $S_4^-) quad -M_f + V_D x = 0 arrow.r.double M_f = V_D x = cases(
        M_f = 0 "Nm" quad (D),
        M_f = V_D L = -1500 "Nm" quad (C)
      )$
  ]
)
#v(0.5em)

*Sezione $S_5^-$ ($0 lt.eq x lt.eq L$):*

#grid(
  columns: (0.7fr, 1.3fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Schema di corpo libero per la sezione S_5^- (da E verso C, 0 <= x <= L).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, E=(0, 1.3), S_5^-=(0, 0).
    // 2. ELEMENTI: Asta verticale, reazione V_E verso l'alto in E, carico distribuito q verso sinistra, ascissa x verso il basso, azioni N, T, M_f in S_5^-.
    // FASE 2: COSTRUZIONE
    #canvas(length: 2cm, {
      import draw: *

      line((0, 0), (0, 1.3), stroke: 1pt)
      circle((0, 1.3), radius: 0.05, fill: black)

      // Reazione V_E e ascissa x
      line((0, 1.3), (0, 1.85), stroke: 1pt, mark: (end: ">"))
      line((-0.45, 1.3), (-0.25, 1.3), stroke: 0.6pt)
      line((-0.35, 1.3), (-0.35, 0.95), stroke: 0.6pt, mark: (end: ">"))

      // Carico distribuito q
      line((0.42, 0), (0.42, 1.3), stroke: (paint: red, thickness: 0.6pt))
      line((0.42, 0), (0.02, 0), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((0.42, 0.43), (0.02, 0.43), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((0.42, 0.86), (0.02, 0.86), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((0.42, 1.3), (0.02, 1.3), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))

      // Azioni interne in S_5^-
      line((0, 0), (0, -0.55), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      line((0, 0), (-0.55, 0), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      arc((0, 0), start: 190deg, stop: 310deg, radius: 0.3, anchor: "origin", stroke: (paint: red, thickness: 1pt), mark: (start: ">"))

      // Etichette
      content((-0.12, 1.65), text(size: 7pt)[$V_E$], anchor: "east")
      content((0.12, 1.42), text(size: 7pt)[$E$], anchor: "west")
      content((-0.45, 1.1), text(size: 7pt)[$x$], anchor: "east")
      content((0.52, 0.65), text(size: 7pt, fill: red)[$q$], anchor: "west")
      content((0.12, -0.5), text(size: 7pt, fill: red)[$N$], anchor: "west")
      content((-0.5, 0.12), text(size: 7pt, fill: red)[$T$], anchor: "south")
      content((-0.32, -0.32), text(size: 7pt, fill: red)[$M_f$], anchor: "east")
      content((0.15, -0.15), text(size: 7pt, fill: red)[$S_5^-$], anchor: "west")
    })
    // FASE 3: VERIFICA
    // Arco M_f con start=190deg < stop=310deg e anchor: "origin". 8 etichette con text(size: 7pt).
  ],
  [
    Dall'equilibrio del tratto verticale superiore $E S_5^-$ otteniamo:
    - $arrow.t) quad -N + V_E = 0 arrow.r.double N = V_E = 1500 "N"$
    - $arrow.r) quad -T - q x = 0 arrow.r.double T = -q x = cases(
        T = 0 "N" quad (E),
        T = -q L = -1000 "N" quad (C)
      )$
    - $S_5^-) quad -M_f + (q x^2) / 2 = 0 arrow.r.double M_f = (q x^2) / 2 = cases(
        M_f = 0 "Nm" quad (E),
        M_f = (q L^2) / 2 = 500 "Nm" quad (C)
      )$
  ]
)
#v(1em)

=== 3) Diagrammi delle caratteristiche di sollecitazione ($N$, $T$, $M_f$)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Diagramma dello sforzo normale N (pagina 4 in basso):
    // - Tratto AB e FC: N = 0 (indicato con X).
    // - Tratto BC e CD: N = -2000 N (rettangoli inferiori con segno -).
    // - Tratto CE: N = +1500 N (rettangolo a sinistra con segno +).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, L = 1.4 cm. A=(0,0), B=(0,1.4), C=(1.4,1.4), D=(2.8,1.4), F=(1.4,0), E=(1.4,2.8).
    // 2. ELEMENTI: Struttura in nero, diagrammi N in rosso, segni + e -, etichette con text(size: 7pt).
    // FASE 2: COSTRUZIONE
    #canvas(length: 2cm, {
      import draw: *

      // Struttura
      line((0, 0), (0, 1.4), (1.31, 1.4), stroke: 1pt)
      line((1.4, 0), (1.4, 2.8), stroke: 1pt)
      line((1.4, 1.4), (2.8, 1.4), stroke: 1pt)
      arc((1.35, 1.4), start: 90deg, stop: 270deg, radius: 0.06, anchor: "origin", stroke: 1pt)

      // Segni X su AB e FC (N = 0)
      line((-0.08, 0.62), (0.08, 0.78), stroke: (paint: red, thickness: 0.6pt))
      line((-0.08, 0.78), (0.08, 0.62), stroke: (paint: red, thickness: 0.6pt))
      line((1.32, 0.62), (1.48, 0.78), stroke: (paint: red, thickness: 0.6pt))
      line((1.32, 0.78), (1.48, 0.62), stroke: (paint: red, thickness: 0.6pt))

      // Rettangoli N = -2000 N su BC e CD
      rect((0, 1.0), (1.4, 1.4), stroke: (paint: red, thickness: 0.6pt))
      rect((1.4, 1.0), (2.8, 1.4), stroke: (paint: red, thickness: 0.6pt))

      // Rettangolo N = +1500 N su CE
      rect((1.05, 1.4), (1.4, 2.8), stroke: (paint: red, thickness: 0.6pt))

      // Etichette (con text(size: 7pt))
      content((0.7, 0.92), text(size: 7pt, fill: red)[$-2000 "N"$], anchor: "north")
      content((2.1, 0.92), text(size: 7pt, fill: red)[$-2000 "N"$], anchor: "north")
      content((0.98, 2.1), text(size: 7pt, fill: red)[$+1500 "N"$], anchor: "east")
      content((0.7, 1.2), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((2.1, 1.2), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((1.22, 2.1), text(size: 7pt, fill: red)[$+$], anchor: "center")
      content((0.1, 0.05), text(size: 7pt)[$A$], anchor: "west")
      content((0, 1.5), text(size: 7pt)[$B$], anchor: "south")
      content((1.3, 1.28), text(size: 7pt)[$C$], anchor: "north")
      content((2.8, 1.5), text(size: 7pt)[$D$], anchor: "south")
      content((1.5, 2.8), text(size: 7pt)[$E$], anchor: "west")
      content((1.5, 0.05), text(size: 7pt)[$F$], anchor: "west")
      content((2.2, 2.2), text(size: 7pt, fill: red)[*SFORZO NORMALE (N)*], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 13 etichette tutte con text(size: 7pt).
  ],
  [
    // FASE 0: COMPRENSIONE
    // Diagramma dello sforzo di taglio T (pagina 5 in alto):
    // - Tratto AB: T = -1000 N (rettangolo a destra).
    // - Tratto BC: T = 0 (con segno X).
    // - Tratto FC: T = -1000 N (rettangolo a sinistra).
    // - Tratto CD: T = +1500 N (rettangolo superiore).
    // - Tratto CE: triangolo lineare da 0 in E a -1000 N in C.
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, stessa scala (L = 1.4 cm).
    // 2. ELEMENTI: Struttura in nero, diagrammi T in rosso, etichette con text(size: 7pt).
    // FASE 2: COSTRUZIONE
    #canvas(length: 2cm, {
      import draw: *

      // Struttura
      line((0, 0), (0, 1.4), (1.31, 1.4), stroke: 1pt)
      line((1.4, 0), (1.4, 2.8), stroke: 1pt)
      line((1.4, 1.4), (2.8, 1.4), stroke: 1pt)
      arc((1.35, 1.4), start: 90deg, stop: 270deg, radius: 0.06, anchor: "origin", stroke: 1pt)

      // Segno X su BC (T = 0)
      line((0.62, 1.32), (0.78, 1.48), stroke: (paint: red, thickness: 0.6pt))
      line((0.62, 1.48), (0.78, 1.32), stroke: (paint: red, thickness: 0.6pt))

      // Rettangolo T = -1000 N su AB
      rect((0, 0), (0.35, 1.4), stroke: (paint: red, thickness: 0.6pt))

      // Rettangolo T = -1000 N su FC
      rect((1.05, 0), (1.4, 1.4), stroke: (paint: red, thickness: 0.6pt))

      // Rettangolo T = +1500 N su CD
      rect((1.4, 1.4), (2.8, 1.88), stroke: (paint: red, thickness: 0.6pt))

      // Triangolo T su CE (da 0 in E a -1000 N in C)
      line((1.4, 2.8), (1.75, 1.4), (1.4, 1.4), stroke: (paint: red, thickness: 0.6pt))

      // Etichette (con text(size: 7pt))
      content((0.42, 0.7), text(size: 7pt, fill: red)[$-1000 "N"$], anchor: "west")
      content((1.0, 0.45), text(size: 7pt, fill: red)[$-1000 "N"$], anchor: "east")
      content((2.1, 1.95), text(size: 7pt, fill: red)[$+1500 "N"$], anchor: "south")
      content((1.65, 1.28), text(size: 7pt, fill: red)[$-1000 "N"$], anchor: "north")
      content((0.18, 0.7), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((1.22, 0.7), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((2.1, 1.64), text(size: 7pt, fill: red)[$+$], anchor: "center")
      content((1.52, 1.75), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((-0.1, 0), text(size: 7pt)[$A$], anchor: "east")
      content((0, 1.5), text(size: 7pt)[$B$], anchor: "south")
      content((1.3, 1.28), text(size: 7pt)[$C$], anchor: "north")
      content((2.85, 1.5), text(size: 7pt)[$D$], anchor: "west")
      content((1.5, 2.8), text(size: 7pt)[$E$], anchor: "west")
      content((1.5, 0.05), text(size: 7pt)[$F$], anchor: "west")
      content((2.2, 2.4), text(size: 7pt)[*TAGLIO (T)*], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 15 etichette tutte con text(size: 7pt).
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    *Diagramma del Momento Flettente ($M_f$):*
    - Sul ritto $A B$ il momento cresce linearmente da $0$ in $A$ fino a $-1000 "Nm"$ nel nodo rigido $B$ (fibre esterne di sinistra tese).
    - Sul tratto $B C$ il momento si mantiene costante pari a $-1000 "Nm"$ (fibre superiori tese) e si chiude sulla coppia concentrata $M = 1000 "Nm"$ applicata appena a sinistra della cerniera interna in $C$.
    - Sul tratto $F C$ il momento varia linearmente da $0$ in $F$ a $+1000 "Nm"$ in $C$.
    - Sul tratto $E C$ il momento varia parabolicamente da $0$ in $E$ a $+500 "Nm"$ in $C$.
    - Sul tratto $D C$ il momento cresce linearmente in modulo da $0$ nella cerniera $D$ fino a $-1500 "Nm"$ in $C$ (verificando l'equilibrio al nodo $C$: $1000 + 500 - 1500 = 0$).
  ],
  [
    // FASE 0: COMPRENSIONE
    // Diagramma del momento flettente M_f (pagina 5 al centro):
    // - Tratto AB: triangolo lineare da 0 in A a -1000 Nm in B.
    // - Tratto BC: rettangolo costante -1000 Nm sopra BC.
    // - Tratto FC: triangolo lineare da 0 in F a +1000 Nm in C.
    // - Tratto CE: parabola da 0 in E a +500 Nm in C.
    // - Tratto CD: triangolo lineare da 0 in D a -1500 Nm in C.
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, L = 1.4 cm.
    // 2. CLASSIFICAZIONE CURVE:
    //    - Parabola su CE da E=(1.4, 2.8) a (1.65, 1.4):
    //      // BEZIER NECESSARIO: cerchio e_max = 0.16, ellisse e_max = 0.14 (arco parabolico con tangente verticale in E).
    //      Usiamo 1 bezier da (1.4, 2.8) a (1.65, 1.4) con C1=(1.4, 2.2), C2=(1.5, 1.75).
    // FASE 2: COSTRUZIONE
    #canvas(length: 2.2cm, {
      import draw: *

      // Struttura
      line((0, 0), (0, 1.4), (1.31, 1.4), stroke: 1pt)
      line((1.4, 0), (1.4, 2.8), stroke: 1pt)
      line((1.4, 1.4), (2.8, 1.4), stroke: 1pt)
      arc((1.35, 1.4), start: 90deg, stop: 270deg, radius: 0.06, anchor: "origin", stroke: 1pt)

      // Triangolo M_f su AB (da 0 in A a -1000 Nm in B)
      line((0, 0), (-0.42, 1.4), (0, 1.4), stroke: (paint: red, thickness: 0.6pt))

      // Rettangolo M_f su BC (-1000 Nm)
      rect((0, 1.4), (1.35, 1.82), stroke: (paint: red, thickness: 0.6pt))

      // Triangolo M_f su FC (da 0 in F a +1000 Nm in C)
      line((1.4, 0), (0.98, 1.4), (1.4, 1.4), stroke: (paint: red, thickness: 0.6pt))

      // Parabola M_f su CE (da 0 in E a +500 Nm in C)
      bezier((1.4, 2.8), (1.65, 1.4), (1.4, 2.2), (1.5, 1.75), stroke: (paint: red, thickness: 0.6pt))
      line((1.4, 1.4), (1.65, 1.4), stroke: (paint: red, thickness: 0.6pt))

      // Triangolo M_f su CD (da -1500 Nm in C a 0 in D)
      line((1.4, 1.4), (1.4, 2.15), (2.8, 1.4), stroke: (paint: red, thickness: 0.6pt))

      // Etichette (con text(size: 7pt))
      content((-0.45, 1.25), text(size: 7pt, fill: red)[$-1000 "Nm"$], anchor: "east")
      content((0.65, 1.9), text(size: 7pt, fill: red)[$-1000 "Nm"$], anchor: "south")
      content((0.95, 0.85), text(size: 7pt, fill: red)[$+1000 "Nm"$], anchor: "east")
      content((1.8, 1.2), text(size: 7pt, fill: red)[$+500 "Nm"$], anchor: "north")
      content((1.65, 2.3), text(size: 7pt, fill: red)[$-1500 "Nm"$], anchor: "west")
      content((-0.18, 1.15), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((0.65, 1.6), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((1.22, 1.15), text(size: 7pt, fill: red)[$+$], anchor: "center")
      content((1.5, 1.55), text(size: 7pt, fill: red)[$+$], anchor: "center")
      content((1.8, 1.65), text(size: 7pt, fill: red)[$minus$], anchor: "center")
      content((0.1, 0.05), text(size: 7pt)[$A$], anchor: "west")
      content((-0.12, 1.5), text(size: 7pt)[$B$], anchor: "south")
      content((1.3, 1.25), text(size: 7pt)[$C$], anchor: "north")
      content((2.85, 1.5), text(size: 7pt)[$D$], anchor: "west")
      content((1.3, 2.8), text(size: 7pt)[$E$], anchor: "east")
      content((1.5, 0.05), text(size: 7pt)[$F$], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 1 bezier per il ramo parabolico su CE, 16 etichette tutte con text(size: 7pt).
  ]
)
#v(1em)

=== 4) Individuazione della sezione più sollecitata e verifica di sicurezza
Dall'esame congiunto dei diagrammi delle azioni interne, *la sezione $C$ relativamente al tratto $C D$ è la più sollecitata* dell'intera struttura, in quanto soggetta contemporaneamente al massimo momento flettente in modulo e al massimo sforzo normale di compressione (trascurando l'effetto secondario del taglio):
$ N = -2000 "N", wide M_f = -1500 "Nm" = -1,5 dot 10^6 "N" dot "mm" $

#grid(
  columns: (0.9fr, 1.1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    Sovrapponendo il contributo di compressione uniforme dovuto allo sforzo normale $N$ e il diagramma lineare a farfalla dovuto al momento flettente $M_f$ (che tende le fibre superiori a $y > 0$ e comprime le fibre inferiori a $y < 0$), il *punto più sollecitato $P$* si trova al lembo inferiore della sezione circolare ($y = -D / 2$), dove le due tensioni normali di compressione si sommano:
   
  ],
  [
    
    #canvas(length: 2cm, {
      import draw: *

      // Sezione circolare piena
      circle((0, 0), radius: 0.85, stroke: 1pt)

      // Assi baricentrici y, z, x (in rosso come nell'originale)
      line((0, 0), (0, 0.55), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      line((0, 0), (-0.55, 0), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      circle((0, 0), radius: 0.04, fill: red, stroke: red)

      // Quota diametro D
      line((-1.05, -0.6), (-0.72, -0.45), stroke: 0.6pt, mark: (end: ">"))
      line((1.05, 0.6), (0.72, 0.45), stroke: 0.6pt, mark: (end: ">"))

      // Punto più sollecitato P al lembo inferiore (0, -0.85)
      circle((0, -0.85), radius: 0.07, fill: black)

      // Diagramma sigma^N = N/A (compressione uniforme)
      line((1.65, -0.85), (1.65, 0.85), stroke: 1pt)
      line((1.25, -0.85), (1.25, 0.85), stroke: 1pt)
      line((1.65, 0.85), (1.25, 0.85), stroke: 0.6pt, mark: (end: ">"))
      line((1.65, 0.3), (1.25, 0.3), stroke: 0.6pt, mark: (end: ">"))
      line((1.65, -0.3), (1.25, -0.3), stroke: 0.6pt, mark: (end: ">"))
      line((1.65, -0.85), (1.25, -0.85), stroke: 0.6pt, mark: (end: ">"))

      // Diagramma a farfalla sigma^F = -M_f / I_z * y
      line((2.9, -0.85), (2.9, 0.85), stroke: 1pt)
      line((2.3, -0.85), (3.5, 0.85), stroke: 1pt)
      line((2.9, 0.85), (3.5, 0.85), stroke: 0.6pt, mark: (end: ">"))
      line((2.9, 0.45), (3.22, 0.45), stroke: 0.6pt, mark: (end: ">"))
      line((2.9, -0.45), (2.58, -0.45), stroke: 0.6pt, mark: (end: ">"))
      line((2.9, -0.85), (2.3, -0.85), stroke: 0.6pt, mark: (end: ">"))

      // Etichette (con text(size: 7pt))
      content((0.1, 0.45), text(size: 7pt, fill: red)[$y$], anchor: "west")
      content((-0.45, -0.15), text(size: 7pt, fill: red)[$z$], anchor: "north")
      content((0.1, -0.05), text(size: 7pt, fill: red)[$x$], anchor: "west")
      content((0.95, 0.72), text(size: 7pt)[$D$], anchor: "south")
      content((0, -1.0), text(size: 7pt)[PUNTO + SOLL.], anchor: "north")
      content((1.98, 0), text(size: 7pt)[$+$], anchor: "center")
      content((1.45, -1.05), text(size: 7pt)[$sigma^N = N / A$], anchor: "north")
      content((2.95, -1.05), text(size: 7pt)[$sigma^F = - M_f / I_z dot y$], anchor: "north")
    })
    // FASE 3: VERIFICA
    // Cerchio r = 0.85, punto P r = 0.07, 8 etichette tutte con text(size: 7pt).
  ]
)
#v(0.5em)
 $ sigma^N = N / A = (4 N) / (pi D^2) = (4 dot (-2000)) / (pi dot 45^2) = -1 "MPa" $
    $ sigma^F (y = -D / 2) = (M_f dot D / 2) / ((pi D^4) / 64) = (32 M_f) / (pi D^3) = -168 "MPa" $

Sommando i due contributi nel punto più sollecitato $P$, otteniamo la tensione normale complessiva $sigma_(x x)$ e la tensione equivalente $sigma_("eq")$:
$ sigma_(x x) = sigma^N + sigma^F = -1 - 168 = -169 "MPa" $
$ sigma_("eq") = abs(sigma_(x x)) = 169 "MPa" $

Il coefficiente di sicurezza statico a snervamento $C S$ risulta infine:
$ C S = sigma_S / sigma_("eq") = 300 / 169 = 1,77 $

#pagebreak()

= Fondamenti di Meccanica Strutturale - Testo d'Esame (08/06/2026)

== Esercizio 1
Si consideri una trave rettilinea con asse longitudinale $x$ avente una sezione trasversale sottile aperta composta da due profili a C affacciati e simmetrici rispetto al baricentro complessivo $G$, come mostrato in figura. Ciascun profilo a C ha altezza totale $H = 180 "mm"$, ali orizzontali di larghezza $B = 69 "mm"$ e spessore costante $s = 3 "mm"$; l'ingombro complessivo orizzontale della sezione composta è $L = 600 "mm"$.
*Dati geometrici e di sollecitazione:*
    - Altezza dei profili a C: $H = 180 "mm"$
    - Larghezza delle ali: $B = 69 "mm"$
    - Larghezza totale della sezione: $L = 600 "mm"$
    - Spessore di parete: $s = 3 "mm"$
    - Momento flettente attorno all'asse $z$: $M_z = 30000 "Nm"$
    - Momento torcente attorno all'asse $x$: $M_x = 450 "Nm"$

    *Quesiti:*
    + *Caso 1 (Solo momento flettente $M_z$):* Calcolare il momento d'inerzia baricentrico $J_z$ dell'intera sezione composta, determinare la tensione normale massima $sigma_(x x)^("MAX")$ indicando la quota $y$ in cui si verifica, scrivere il tensore degli sforzi $[sigma]$, rappresentare i cerchi di Mohr e calcolare la tensione ideale secondo il criterio di Tresca $sigma_("ID,TR")$.
    + *Caso 2 (Momento flettente $M_z$ + Momento torcente $M_x$):* Calcolare il fattore di rigidezza torsionale $I_t$ della sezione aperta sottile e la tensione tangenziale massima $tau_("MAX")$. Scrivere quindi il tensore degli sforzi $[sigma]$ nel punto più sollecitato ($y = plus.minus H / 2$), tracciare i relativi cerchi di Mohr e calcolare la nuova tensione ideale di Tresca $sigma_("ID,TR")$.
#v(1em)
#align(center)[#canvas(length: 1.8cm, {
      import draw: *

      // Profilo a C di sinistra
      line((-2.2, -1.5), (-0.8, -1.5), (-0.8, -1.28), (-1.98, -1.28), (-1.98, 1.28), (-0.8, 1.28), (-0.8, 1.5), (-2.2, 1.5), close: true, stroke: 1pt)

      // Profilo a C di destra
      line((2.2, -1.5), (0.8, -1.5), (0.8, -1.28), (1.98, -1.28), (1.98, 1.28), (0.8, 1.28), (0.8, 1.5), (2.2, 1.5), close: true, stroke: 1pt)

      // Crocette baricentriche sulle anime verticali
      line((-2.13, 0), (-2.05, 0), stroke: 0.6pt)
      line((-2.09, -0.05), (-2.09, 0.05), stroke: 0.6pt)
      line((2.05, 0), (2.13, 0), stroke: 0.6pt)
      line((2.09, -0.05), (2.09, 0.05), stroke: 0.6pt)

      // Baricentro G e assi y, z
      line((-0.08, 0), (0.08, 0), stroke: 1pt)
      line((0, -0.08), (0, 0.08), stroke: 1pt)
      line((0, 0), (0, 0.8), stroke: 1pt, mark: (end: ">"))
      line((0, 0), (-0.75, 0), stroke: 1pt, mark: (end: ">"))

      // Vettore momento flettente M_z (in verde con doppia punta)
      line((-0.75, 0), (-1.45, 0), stroke: (paint: green.darken(20%), thickness: 1pt), mark: (end: ">"))
      line((-0.75, 0), (-1.28, 0), stroke: (paint: green.darken(20%), thickness: 1pt), mark: (end: ">"))

      // Coppia torcente M_x (in rosso)
      arc((0, 0), start: -40deg, stop: 40deg, radius: 0.52, anchor: "origin", stroke: (paint: red, thickness: 1pt), mark: (end: ">"))

      // Quota verticale H
      line((-2.5, -1.5), (-2.5, 1.5), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((-2.6, -1.5), (-2.25, -1.5), stroke: 0.6pt)
      line((-2.6, 1.5), (-2.25, 1.5), stroke: 0.6pt)

      // Quota spessore s
      line((-0.62, 1.28), (-0.62, 1.5), stroke: 0.6pt, mark: (start: ">", end: ">"))

      // Quota larghezza ala B
      line((-2.2, -1.85), (-0.8, -1.85), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((-2.2, -1.55), (-2.2, -2.35), stroke: 0.6pt)
      line((-0.8, -1.55), (-0.8, -1.92), stroke: 0.6pt)

      // Quota larghezza totale L
      line((-2.2, -2.3), (2.2, -2.3), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((2.2, -1.55), (2.2, -2.35), stroke: 0.6pt)

      // Etichette (tutte con text(size: 7pt))
      content((-2.65, 0), text(size: 7pt)[$H$], anchor: "east")
      content((-0.52, 1.39), text(size: 7pt)[$s$], anchor: "west")
      content((-1.5, -1.78), text(size: 7pt)[$B$], anchor: "south")
      content((0, -2.22), text(size: 7pt)[$L$], anchor: "south")
      content((0.12, 0.65), text(size: 7pt)[$y$], anchor: "west")
      content((-0.45, -0.15), text(size: 7pt)[$z$], anchor: "north")
      content((0.12, -0.18), text(size: 7pt)[$G$], anchor: "west")
      content((-1.15, 0.15), text(size: 7pt, fill: green.darken(20%))[$M_z$], anchor: "south")
      content((0.6, 0), text(size: 7pt, fill: red)[$M_x$], anchor: "west")
    })]


#pagebreak()

// ==========================================
// PARTE 2: SOLUZIONI E PROCEDIMENTO COMPLETO
// ==========================================


==========================================
// PARTE 1: TESTO DELL'ESAME (SOLO TRACCE)
// ==========================================

== Esercizio n. 2 (max 13 punti)
Data la struttura in acciaio S275 ($R_("p0.2") = 275 "MPa"$, $R_m = 320 "MPa"$, $E = 200000 "MPa"$) illustrata in figura e con:
- $L = 2 "m"$, sezione a doppio T spessa con $H = 70 "mm"$, $h = 60 "mm"$, $B = 70 "mm"$, $b = 10 "mm"$
- momento d'inerzia $I_z = 920833 "mm"^4$, momento statico $S_z = 15875 "mm"^3$
- $q_1 = 3000 "N/m"$ carico distribuito da $A$ a $B$, $q_2 = 1500 "N/m"$ carico distribuito da $B$ a $C$

#grid(
  columns: (1.1fr, 0.9fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Schema statico iniziale della trave continua con sbalzo A-B-C: cerniera fissa a terra in A, carrello a terra in B, estremo libero in C. Campate AB = L e BC = L. Carico distribuito verticale verso il basso q_1 su AB e q_2 (altezza dimezzata) su BC. Sistema di riferimento (x verso destra, y verso il basso).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello per la trave. Origine O=(0,0) in A. Lunghezza L = 2.4 cm (totale 2L = 4.8 cm).
    // 2. FIGURE IN PROSPETTIVA: Piano 2D (x, y).
    // 3. ELEMENTI:
    // - Asse trave AC: da (0, 0) a (4.8, 0), spessore 1.2pt. Asse x fino a (5.4, 0) con freccia.
    // - Cerniera in A: triangolo da (0,0) a (-0.18, -0.3) a (0.18, -0.3) e tratteggio a terra.
    // - Carrello in B=(2.4, 0): triangolo, due cerchietti (r = 0.06) e linea di terra con tratteggio.
    // - Carico q_1 su AB: linea superiore a y = 1.1, 5 frecce verticali verso il basso da y = 1.1 a y = 0.03.
    // - Carico q_2 su BC: linea superiore a y = 0.6, 5 frecce verticali verso il basso da y = 0.6 a y = 0.03.
    // - Quote L e L in basso a y = -1.1. Asse y verso il basso da (0, -0.5) a (0, -0.95).
    // - Etichette tutte con text(size: 7pt).
    // 4. CLASSIFICAZIONE CURVE: Solo segmenti rettilinei e 2 cerchietti di raggio 0.06 per il carrello in B.
    // FASE 2: COSTRUZIONE
    #canvas(length: 1.8cm, {
      import draw: *

      // Trave principale A-B-C e asse x
      line((0, 0), (4.8, 0), stroke: 1.2pt)
      line((4.8, 0), (5.4, 0), stroke: 0.6pt, mark: (end: ">"))

      // Cerniera fissa in A
      line((0, 0), (-0.16, -0.28), (0.16, -0.28), close: true, stroke: 0.6pt)
      line((-0.25, -0.28), (0.25, -0.28), stroke: 0.6pt)
      line((-0.22, -0.4), (-0.1, -0.28), stroke: 0.6pt)
      line((-0.1, -0.4), (0.02, -0.28), stroke: 0.6pt)
      line((0.02, -0.4), (0.14, -0.28), stroke: 0.6pt)
      line((0.14, -0.4), (0.25, -0.28), stroke: 0.6pt)

      // Carrello in B (x = 2.4)
      line((2.4, 0), (2.26, -0.24), (2.54, -0.24), close: true, stroke: 0.6pt)
      circle((2.32, -0.3), radius: 0.06, stroke: 0.6pt)
      circle((2.48, -0.3), radius: 0.06, stroke: 0.6pt)
      line((2.15, -0.36), (2.65, -0.36), stroke: 0.6pt)
      line((2.18, -0.48), (2.3, -0.36), stroke: 0.6pt)
      line((2.3, -0.48), (2.42, -0.36), stroke: 0.6pt)
      line((2.42, -0.48), (2.54, -0.36), stroke: 0.6pt)
      line((2.54, -0.48), (2.65, -0.36), stroke: 0.6pt)

      // Carico distribuito q1 su AB
      line((0, 1.1), (2.4, 1.1), stroke: 0.6pt)
      line((0, 1.1), (0, 0.04), stroke: 1pt, mark: (end: ">"))
      line((0.6, 1.1), (0.6, 0.04), stroke: 1pt, mark: (end: ">"))
      line((1.2, 1.1), (1.2, 0.04), stroke: 1pt, mark: (end: ">"))
      line((1.8, 1.1), (1.8, 0.04), stroke: 1pt, mark: (end: ">"))
      line((2.4, 1.1), (2.4, 0.04), stroke: 1pt, mark: (end: ">"))

      // Carico distribuito q2 su BC
      line((2.4, 0.6), (4.8, 0.6), stroke: 0.6pt)
      line((2.88, 0.6), (2.88, 0.04), stroke: 1pt, mark: (end: ">"))
      line((3.36, 0.6), (3.36, 0.04), stroke: 1pt, mark: (end: ">"))
      line((3.84, 0.6), (3.84, 0.04), stroke: 1pt, mark: (end: ">"))
      line((4.32, 0.6), (4.32, 0.04), stroke: 1pt, mark: (end: ">"))
      line((4.8, 0.6), (4.8, 0.04), stroke: 1pt, mark: (end: ">"))

      // Asse y e quote L, L
      line((0, -0.45), (0, -0.9), stroke: 0.6pt, mark: (end: ">"))
      line((0, -1.1), (2.4, -1.1), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((2.4, -1.1), (4.8, -1.1), stroke: 0.6pt, mark: (start: ">", end: ">"))

      // Etichette (con text(size: 7pt))
      content((1.2, 1.2), text(size: 7pt)[$q_1$], anchor: "south")
      content((3.84, 0.7), text(size: 7pt)[$q_2$], anchor: "south")
      content((-0.22, -0.08), text(size: 7pt)[$A$], anchor: "east")
      content((2.18, -0.12), text(size: 7pt)[$B$], anchor: "east")
      content((4.8, -0.18), text(size: 7pt)[$C$], anchor: "north")
      content((5.3, -0.15), text(size: 7pt)[$x$], anchor: "north")
      content((0.12, -0.82), text(size: 7pt)[$y$], anchor: "west")
      content((1.2, -1.05), text(size: 7pt)[$L$], anchor: "south")
      content((3.6, -1.05), text(size: 7pt)[$L$], anchor: "south")
    })
    // FASE 3: VERIFICA
    // 2 cerchietti r = 0.06, 9 etichette tutte con text(size: 7pt).
  ],
  [
    // FASE 0: COMPRENSIONE
    // Sezione trasversale a doppio T spessa con larghezza ali B, spessore anima b, altezza totale H, altezza interna anima h, assi baricentrici z (orizzontale verso sinistra) e y (verticale verso il basso).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, origine nel baricentro G=(0,0). B = 2.4 cm (da -1.2 a 1.2), H = 2.0 cm (da -1.0 a 1.0), h = 1.4 cm (da -0.7 a 0.7), b = 0.36 cm (da -0.18 a 0.18).
    // 2. ELEMENTI: Poligono chiuso a doppio T, assi z e y, quote h, H, b, B. Tutte le etichette con text(size: 7pt).
    // 3. CLASSIFICAZIONE CURVE: Solo segmenti rettilinei.
    // FASE 2: COSTRUZIONE
    #canvas(length: 1.7cm, {
      import draw: *

      // Contorno sezione a doppio T
      line((-1.2, -1.0), (1.2, -1.0), (1.2, -0.7), (0.18, -0.7), (0.18, 0.7), (1.2, 0.7), (1.2, 1.0), (-1.2, 1.0), (-1.2, 0.7), (-0.18, 0.7), (-0.18, -0.7), (-1.2, -0.7), close: true, stroke: 1.2pt)

      // Assi baricentrici z e y
      line((1.5, 0), (-1.25, 0), stroke: 0.6pt, mark: (end: ">"))
      line((0, 1.25), (0, -1.25), stroke: 0.6pt, mark: (end: ">"))

      // Quote h e H a destra
      line((1.65, -0.7), (1.65, 0.7), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((2.05, -1.0), (2.05, 1.0), stroke: 0.6pt, mark: (start: ">", end: ">"))

      // Quote b e B in basso
      line((-0.18, -1.55), (0.18, -1.55), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((-1.2, -1.95), (1.2, -1.95), stroke: 0.6pt, mark: (start: ">", end: ">"))

      // Etichette (con text(size: 7pt))
      content((-1.2, -0.15), text(size: 7pt)[$z$], anchor: "north")
      content((-0.12, 0.85), text(size: 7pt)[$y$], anchor: "east")
      content((1.75, 0.15), text(size: 7pt)[$h$], anchor: "west")
      content((2.15, 0.05), text(size: 7pt)[$H$], anchor: "west")
      content((0, -1.5), text(size: 7pt)[$b$], anchor: "south")
      content((0, -1.9), text(size: 7pt)[$B$], anchor: "south")
    })
    // FASE 3: VERIFICA
    // Poligono chiuso a 12 vertici, 6 etichette tutte con text(size: 7pt).
  ]
)
#v(0.5em)

*Quesiti:*
- *2.1* Determinare le reazioni vincolari (indicandone modulo, direzione e verso);
- *2.2* Tracciare le caratteristiche di sollecitazione (indicando i valori numerici sui diagrammi);
- *2.3* Individuare la sezione più sollecitata e su di essa disegnare l'andamento delle tensioni normali $sigma$ e tangenziali $tau$;
- *2.4* Calcolare i valori massimi delle tensioni nel punto più sollecitato della sezione;
- *2.5* Scrivere il tensore delle tensioni nel punto più sollecitato, calcolare le tensioni principali secondo l'ipotesi di cedimento più idonea e tracciare i cerchi di Mohr;
- *2.6* Calcolare il coefficiente di sicurezza;
- *2.7* Calcolare lo spostamento verticale del punto $C$, con sovrapposizione degli effetti e facendo riferimento alla tabella dei casi notevoli della linea elastica.

*_N.B. Al fine della valutazione, i punti 2.2, 2.3 e successivi sono subordinati al corretto svolgimento del precedente punto 2.1 dello stesso esercizio._*

#pagebreak()

= Soluzione dell'Esame

== Primo esercizio) Soluzione

=== 1) Caso 1: Solo momento flettente $M_z$
Quando sulla sezione agisce esclusivamente il momento flettente $M_z = 30000 "Nm" = 30 dot 10^6 "N" dot "mm"$, la distribuzione delle tensioni normali $sigma_(x x)$ lungo l'altezza della sezione è data dalla formula di Navier:
$ sigma_(x x) = - (M_z dot y) / J_z arrow.r.double sigma_(x x)^("MAX") = (M_z dot H) / (2 J_z) = 296 "MPa" quad ("in " y = - H / 2) $

*Calcolo del momento d'inerzia baricentrico $J_z$:*
La sezione trasversale può essere scomposta in $4$ rettangoli orizzontali (le quattro ali di larghezza $B = 69 "mm"$ e spessore $s = 3 "mm"$, il cui baricentro locale dista $H / 2 - s / 2$ dall'asse baricentrico $z$) e $2$ rettangoli verticali (le due anime di spessore $s = 3 "mm"$ e altezza netta $H - 2 s = 174 "mm"$, già baricentriche rispetto all'asse $z$). Applicando il teorema di Huygens-Steiner otteniamo:
$ J_z = 4 dot [ (B s^3) / 12 + B s ( H / 2 - s / 2 )^2 ] + 2 dot [ (s (H - 2 s)^3) / 12 ] = 9,12 dot 10^6 "mm"^4 $

Sostituendo il valore di $J_z$ nell'espressione della tensione normale massima in $y = -H / 2$:
$ sigma_(x x)^("MAX") = (M_z dot H) / (2 J_z) = (30000 dot 10^3 dot 180) / (2 dot 9,12 dot 10^6) = 296 "MPa" $

#grid(
  columns: (0.9fr, 1.1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    *Tensore degli sforzi $[sigma]$ e tensione ideale:*
    Nel punto più sollecitato a trazione ($y = -H / 2$), lo stato tensionale è monoassiale e il tensore degli sforzi vale:
    $ [sigma] = mat(delim: "[",
      sigma_(x x)^("MAX"), 0, 0;
      0, 0, 0;
      0, 0, 0
    ) $
    Le tre tensioni principali sono pertanto $sigma_1 = sigma_(x x)^("MAX") = 296 "MPa"$ e $sigma_2 = sigma_3 = 0 "MPa"$ (con due cerchi di Mohr degeneri coincidenti nell'origine).
    La tensione ideale secondo il criterio di Tresca risulta immediatamente:
    $ sigma_("ID,TR") = abs(sigma_(x x)^("MAX")) = 296 "MPa" $
  ],
  [
    // FASE 0: COMPRENSIONE
    // Rappresentazione del semicerchio superiore di Mohr nel piano (sigma, tau) per lo stato di tensione monoassiale del Caso 1: origine in sigma_2 = sigma_3 = 0 (con indicazione "2 CERCHI COINCIDENTI IN UN PUNTO") e diametro fino a sigma_xx = sigma_1 = 296 MPa.
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, origine O=(0,0) in (sigma=0, tau=0). Diametro del cerchio da (0,0) a (2.6, 0), centro in (1.3, 0), raggio r = 1.3 cm.
    // 2. ELEMENTI: Asse orizzontale sigma da (-0.3, 0) a (3.8, 0), asse verticale tau da (0, -0.2) a (0, 2.2), semicerchio superiore centrato in (1.3, 0) da start: 0deg a stop: 180deg con raggio 1.3, freccia indicatrice sull'origine. Etichette tutte con text(size: 7pt).
    // 3. CLASSIFICAZIONE CURVE: Arco di cerchio esatto (start: 0deg, stop: 180deg, radius: 1.3, anchor: "origin").
    // FASE 2: COSTRUZIONE
    #canvas(length: 1cm, {
      import draw: *

      // Assi sigma e tau
      line((-0.3, 0), (3.8, 0), stroke: 0.6pt, mark: (end: ">"))
      line((0, -0.2), (0, 2.2), stroke: 0.6pt, mark: (end: ">"))

      // Semicerchio di Mohr tra sigma_2 = sigma_3 = 0 e sigma_1 = sigma_xx
      arc((1.3, 0), start: 0deg, stop: 180deg, radius: 1.3, anchor: "origin", stroke: 1pt)
      circle((0, 0), radius: 0.05, fill: black)

      // Freccia indicatrice "2 cerchi coincidenti in un punto"
      line((-0.65, 0.35), (-0.1, 0.08), stroke: 0.6pt, mark: (end: ">"))

      // Etichette (con text(size: 7pt))
      content((3.75, -0.15), text(size: 7pt)[$sigma$], anchor: "north")
      content((-0.15, 2.1), text(size: 7pt)[$tau$], anchor: "east")
      content((0, -0.18), text(size: 7pt)[$sigma_2 = sigma_3$], anchor: "north")
      content((2.6, -0.18), text(size: 7pt)[$sigma_(x x) = sigma_1$], anchor: "north")
      content((-0.7, 0.35), text(size: 7pt)[2 CERCHI COINCIDENTI IN UN PUNTO], anchor: "east")
    })
    // FASE 3: VERIFICA
    // 1 arco circolare con start=0deg < stop=180deg e anchor: "origin". 5 etichette tutte con text(size: 7pt).
  ]
)
#v(1em)

=== 2) Caso 2: Momento flettente $M_z$ + Momento torcente $M_x$
Nel caso di sezione aperta sottile soggetta anche al momento torcente $M_x = 450 "Nm" = 450 dot 10^3 "N" dot "mm"$, la tensione tangenziale massima prodotta dalla torsione alla Saint-Venant vale:
$ tau_("MAX") = M_x / I_t dot s $

#grid(
  columns: (1.05fr, 0.95fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    *Calcolo del fattore di rigidezza torsionale $I_t$ della sezione:*
    Suddividendo ciascuno dei due profili a C nei tre rettangoli elementari $1$ (ala superiore di lunghezza $B$), $2$ (anima verticale di lunghezza $H - 2 s$) e $3$ (ala inferiore di lunghezza $B$), per simmetria il fattore di rigidezza torsionale complessivo è pari a:
    $ I_t = (I_(t_1) + I_(t_2) + I_(t_3)) dot 2 $
    dove per ciascun rettangolo sottile:
    $ I_(t_1) = I_(t_3) = 1 / 3 B s^3 $
    $ I_(t_2) = ((H - 2 s) s^3) / 3 $
    Sommando i contributi di tutti e $6$ i rettangoli otteniamo:
    $ I_t = 4 dot (B s^3) / 3 + 2 ((H - 2 s) s^3) / 3 = 5616 "mm"^4 $
  ],
  [
    // FASE 0: COMPRENSIONE
    // Schema di scomposizione dei due profili a C nei 6 tratti rettangolari sottili (numerati 1, 2, 3 a sinistra e 1, 2, 3 a destra) con campitura tratteggiata e quote H, B, s (pagina 2 in alto).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, centro G=(0,0), stessa proporzione dello schema iniziale ridotta del 15% (x da -1.8 a +1.8, y da -1.25 a +1.25, spessore 0.22).
    // 2. ELEMENTI: 2 profili a C suddivisi nelle 3 regioni rettangolari 1 (ala sup.), 2 (anima), 3 (ala inf.), tratteggio obliquo interno, quote H, B, s e numeri 1, 2, 3. Etichette tutte con text(size: 7pt).
    // 3. CLASSIFICAZIONE CURVE: Solo segmenti rettilinei.
    // FASE 2: COSTRUZIONE
    #canvas(length: 1.8cm, {
      import draw: *

      // Profilo a C sinistro con suddivisione 1, 2, 3
      line((-1.8, -1.25), (-0.65, -1.25), (-0.65, -1.03), (-1.58, -1.03), (-1.58, 1.03), (-0.65, 1.03), (-0.65, 1.25), (-1.8, 1.25), close: true, stroke: 1pt)
      line((-1.8, 1.03), (-1.58, 1.03), stroke: 0.6pt)
      line((-1.8, -1.03), (-1.58, -1.03), stroke: 0.6pt)

      // Tratteggio profilo sinistro
      line((-1.6, 1.05), (-1.4, 1.23), stroke: 0.6pt)
      line((-1.25, 1.05), (-1.05, 1.23), stroke: 0.6pt)
      line((-0.9, 1.05), (-0.7, 1.23), stroke: 0.6pt)
      line((-1.78, 0.5), (-1.6, 0.7), stroke: 0.6pt)
      line((-1.78, 0.0), (-1.6, 0.2), stroke: 0.6pt)
      line((-1.78, -0.5), (-1.6, -0.3), stroke: 0.6pt)
      line((-1.6, -1.23), (-1.4, -1.05), stroke: 0.6pt)
      line((-1.25, -1.23), (-1.05, -1.05), stroke: 0.6pt)
      line((-0.9, -1.23), (-0.7, -1.05), stroke: 0.6pt)

      // Profilo a C destro con suddivisione 1, 2, 3
      line((1.8, -1.25), (0.65, -1.25), (0.65, -1.03), (1.58, -1.03), (1.58, 1.03), (0.65, 1.03), (0.65, 1.25), (1.8, 1.25), close: true, stroke: 1pt)
      line((1.58, 1.03), (1.8, 1.03), stroke: 0.6pt)
      line((1.58, -1.03), (1.8, -1.03), stroke: 0.6pt)

      // Tratteggio profilo destro
      line((0.7, 1.05), (0.9, 1.23), stroke: 0.6pt)
      line((1.05, 1.05), (1.25, 1.23), stroke: 0.6pt)
      line((1.4, 1.05), (1.6, 1.23), stroke: 0.6pt)
      line((1.6, 0.5), (1.78, 0.7), stroke: 0.6pt)
      line((1.6, 0.0), (1.78, 0.2), stroke: 0.6pt)
      line((1.6, -0.5), (1.78, -0.3), stroke: 0.6pt)
      line((0.7, -1.23), (0.9, -1.05), stroke: 0.6pt)
      line((1.05, -1.23), (1.25, -1.05), stroke: 0.6pt)
      line((1.4, -1.23), (1.6, -1.05), stroke: 0.6pt)

      // Baricentro G
      line((-0.07, 0), (0.07, 0), stroke: 0.6pt)
      line((0, -0.07), (0, 0.07), stroke: 0.6pt)

      // Quote H, B, s
      line((-2.1, -1.25), (-2.1, 1.25), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((-1.8, -1.55), (-0.65, -1.55), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((-0.48, -1.25), (-0.48, -1.03), stroke: 0.6pt, mark: (start: ">", end: ">"))

      // Etichette (con text(size: 7pt))
      content((-2.22, 0), text(size: 7pt)[$H$], anchor: "east")
      content((-1.22, -1.65), text(size: 7pt)[$B$], anchor: "north")
      content((-0.38, -1.14), text(size: 7pt)[$s$], anchor: "west")
      content((0.1, -0.15), text(size: 7pt)[$G$], anchor: "west")
      content((-0.35, 1.2), text(size: 7pt)[$1$], anchor: "west")
      content((-1.25, 0.2), text(size: 7pt)[$2$], anchor: "west")
      content((-0.95, -0.82), text(size: 7pt)[$3$], anchor: "south")
      content((1.95, 1.2), text(size: 7pt)[$1$], anchor: "west")
      content((1.95, 0.2), text(size: 7pt)[$2$], anchor: "west")
      content((1.85, -1.35), text(size: 7pt)[$3$], anchor: "north")
    })
    // FASE 3: VERIFICA
    // 10 etichette tutte con text(size: 7pt).
  ]
)
#v(0.5em)

Poiché i $6$ tratti che compongono la sezione hanno tutti lo stesso spessore $s = 3 "mm"$, la tensione tangenziale massima è uguale in tutti e $6$ i tratti e vale:
$ tau_("MAX") = M_x / I_t s = (450 dot 10^3) / 5616 dot 3 = 240 "MPa" $

#grid(
  columns: (0.95fr, 1.05fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    *Tensore degli sforzi $[sigma]$ nel punto più sollecitato ($y = plus.minus H / 2$):*
    Nei punti estremi delle ali superiori e inferiori ($y = plus.minus H / 2$) coesistono la tensione normale massima di flessione $sigma_(x x)^("MAX") = 296 "MPa"$ e la tensione tangenziale massima di torsione $tau_("MAX") = 240 "MPa"$, dando luogo a uno stato piano di flesso-torsione:
    $ [sigma] = mat(delim: "[",
      sigma_(x x)^("MAX"), 0, tau_("MAX");
      0, 0, 0;
      tau_("MAX"), 0, 0
    ) $

    *Calcolo della tensione ideale nel caso di flesso-torsione:*
    Applicando il criterio di resistenza di Tresca per uno stato di flesso-torsione, la tensione ideale equivalente vale:
    $ sigma_("ID,TR") = sqrt((sigma_(x x)^("MAX"))^2 + 4 (tau_("MAX"))^2) = sqrt(296^2 + 4 dot 240^2) = 564 "MPa" $
    *(Nota: nell'ultima riga del foglio manoscritto compare per una svista grafica il pedice $sigma_(z z)^("MAX")$ al posto di $sigma_(x x)^("MAX") = 296 "MPa"$).*
  ],
  [
    
    #canvas(length: 1.5cm, {
      import draw: *

      // Assi sigma e tau
      line((-1.4, 0), (3.6, 0), stroke: 0.6pt, mark: (end: ">"))
      line((0, -1.85), (0, 2.25), stroke: 0.6pt, mark: (end: ">"))

      // Linee di costruzione dei poli (0, -tau_MAX) e (sigma_xx^MAX, +tau_MAX)
      line((0, 1.62), (2.0, 1.62), stroke: (dash: "dashed", thickness: 0.6pt))
      line((2.0, 0), (2.0, 1.62), stroke: (dash: "dashed", thickness: 0.6pt))
      line((0, -1.62), (2.0, 1.62), stroke: 0.6pt)
      line((0, 1.62), (2.0, -1.62), stroke: 0.6pt)

      // Tre semicerchi superiori di Mohr (blu, verde, rosso come nell'originale)
      arc((1.0, 0), start: 0deg, stop: 180deg, radius: 1.90, anchor: "origin", stroke: (paint: blue.darken(20%), thickness: 1pt))
      arc((1.45, 0), start: 0deg, stop: 180deg, radius: 1.45, anchor: "origin", stroke: (paint: green.darken(30%), thickness: 0.8pt))
      arc((-0.45, 0), start: 0deg, stop: 180deg, radius: 0.45, anchor: "origin", stroke: (paint: red.darken(10%), thickness: 0.8pt))

      // Punti notevoli
      circle((1.0, 0), radius: 0.05, fill: black)
      circle((2.0, 1.62), radius: 0.05, fill: black)
      circle((2.0, -1.62), radius: 0.05, fill: black)
      circle((-0.90, 0), radius: 0.05, fill: black)
      circle((0, 0), radius: 0.05, fill: black)
      circle((2.90, 0), radius: 0.05, fill: black)

      // Etichette (con text(size: 7pt))
      content((3.55, -0.15), text(size: 7pt)[$sigma$], anchor: "north")
      content((-0.15, 2.15), text(size: 7pt)[$tau$], anchor: "east")
      content((-0.12, 1.62), text(size: 7pt)[$tau_("MAX")$], anchor: "east")
      content((-0.12, -1.62), text(size: 7pt)[$-tau_("MAX")$], anchor: "east")
      content((-0.90, -0.15), text(size: 7pt)[$sigma_3$], anchor: "north")
      content((0.18, -0.15), text(size: 7pt)[$sigma_2$], anchor: "north")
      content((2.05, -0.15), text(size: 7pt)[$sigma_(x x)^("MAX")$], anchor: "north")
      content((2.95, -0.15), text(size: 7pt)[$sigma_1$], anchor: "north")
    })
    
  ]
)


== Esercizio n. 2) Svolgimento

=== 2.1) Reazioni vincolari
Sostituiamo ai vincoli in $A$ (cerniera fissa) e in $B$ (carrello) le rispettive reazioni vincolari $V_A$, $H_A$ e $V_B$ come indicato nello schema di corpo libero seguente.

#grid(
  columns: (1.05fr, 0.95fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    Imponiamo gli equilibri alla traslazione orizzontale, alla rotazione intorno ad $A$ e alla traslazione verticale:
    
  ],
  [
    // FASE 0: COMPRENSIONE
    // Schema di corpo libero della trave A-B-C con i carichi distribuiti q_1 e q_2 e le reazioni vincolari V_A, H_A (in A) e V_B (in B) rappresentate in verde.
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, origine in A=(0,0), L = 2.0 cm (totale 2L = 4.0 cm).
    // 2. ELEMENTI: Trave AC, carichi q_1 e q_2, frecce verdi per V_A, H_A, V_B, quote L e L. Etichette tutte con text(size: 7pt).
    // FASE 2: COSTRUZIONE
    #canvas(length: 1.8cm, {
      import draw: *

      // Trave principale e assi
      line((0, 0), (4.0, 0), stroke: 1.2pt)
      line((4.0, 0), (4.6, 0), stroke: 0.6pt, mark: (end: ">"))
      line((0, 0), (0, -1.1), stroke: 0.6pt, mark: (end: ">"))

      // Carico q1 su AB
      line((0, 0.95), (2.0, 0.95), stroke: 0.6pt)
      line((0, 0.95), (0, 0.04), stroke: 1pt, mark: (end: ">"))
      line((0.5, 0.95), (0.5, 0.04), stroke: 1pt, mark: (end: ">"))
      line((1.0, 0.95), (1.0, 0.04), stroke: 1pt, mark: (end: ">"))
      line((1.5, 0.95), (1.5, 0.04), stroke: 1pt, mark: (end: ">"))
      line((2.0, 0.95), (2.0, 0.04), stroke: 1pt, mark: (end: ">"))

      // Carico q2 su BC
      line((2.0, 0.5), (4.0, 0.5), stroke: 0.6pt)
      line((2.4, 0.5), (2.4, 0.04), stroke: 1pt, mark: (end: ">"))
      line((2.8, 0.5), (2.8, 0.04), stroke: 1pt, mark: (end: ">"))
      line((3.2, 0.5), (3.2, 0.04), stroke: 1pt, mark: (end: ">"))
      line((3.6, 0.5), (3.6, 0.04), stroke: 1pt, mark: (end: ">"))
      line((4.0, 0.5), (4.0, 0.04), stroke: 1pt, mark: (end: ">"))

      // Reazioni vincolari V_A, H_A, V_B (in verde)
      line((0, -0.6), (0, -0.05), stroke: (paint: green.darken(30%), thickness: 1pt), mark: (end: ">"))
      line((0, -0.6), (0.65, -0.6), stroke: (paint: green.darken(30%), thickness: 1pt), mark: (end: ">"))
      line((2.0, -0.6), (2.0, -0.05), stroke: (paint: green.darken(30%), thickness: 1pt), mark: (end: ">"))

      // Quote L, L
      line((0, -0.9), (2.0, -0.9), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((2.0, -0.9), (4.0, -0.9), stroke: 0.6pt, mark: (start: ">", end: ">"))

      // Etichette (con text(size: 7pt))
      content((1.0, 1.05), text(size: 7pt)[$q_1$], anchor: "south")
      content((3.2, 0.6), text(size: 7pt)[$q_2$], anchor: "south")
      content((-0.15, -0.1), text(size: 7pt)[$A$], anchor: "east")
      content((1.85, -0.12), text(size: 7pt)[$B$], anchor: "east")
      content((4.0, -0.18), text(size: 7pt)[$C$], anchor: "north")
      content((4.5, -0.15), text(size: 7pt)[$x$], anchor: "north")
      content((0.12, -1.05), text(size: 7pt)[$y$], anchor: "west")
      content((0.1, -0.3), text(size: 7pt, fill: green.darken(30%))[$V_A$], anchor: "west")
      content((0.55, -0.48), text(size: 7pt, fill: green.darken(30%))[$H_A$], anchor: "south")
      content((2.1, -0.35), text(size: 7pt, fill: green.darken(30%))[$V_B$], anchor: "west")
      content((1.0, -0.85), text(size: 7pt)[$L$], anchor: "south")
      content((3.0, -0.85), text(size: 7pt)[$L$], anchor: "south")
    })
    // FASE 3: VERIFICA
    // 12 etichette tutte con text(size: 7pt).
  ]
)

$ cases(
      arrow.r : quad &H_A = 0,
      A^("orario") : quad &q_1 L dot L / 2 - V_B L + q_2 L (L + L / 2) = 0 
      &arrow.r.double V_B = L / 2 (q_1 + 3 q_2) = 7500 "N",
      arrow.t : quad &V_A + V_B - q_1 L - q_2 L = 0 
      &arrow.r.double V_A = -V_B + q_1 L + q_2 L = 1500 "N"
    ) $
#v(1em)

=== 2.2) Caratteristiche di sollecitazione

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    Adottiamo le convenzioni di segno per il concio elementare di trave riportate nella figura a lato (sforzo normale $N$ positivo di trazione, taglio $T$ positivo se fa ruotare il concio in senso orario, momento flettente $M$ positivo se tende le fibre inferiori).

    *Sforzo normale $N$:*
    Dato che l'unica reazione assiale è nulla ($H_A = 0$), il diagramma di sforzo normale è identicamente nullo lungo tutta la trave.
  ],
  [
    // FASE 0: COMPRENSIONE
    // Convenzione di segno sul concio elementare [- +] con vettori N, T, M in blu, seguita sotto dallo schema della trave A-B-C con due croci blu indicanti N = 0.
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 2 piccoli schemi sovrapposti nello stesso canvas:
    //    - Concio in alto centrato in (0, 1.0), larghezza 1.4 cm, altezza 0.6 cm.
    //    - Trave A-B-C in basso da (-2.0, -0.6) a (2.0, -0.6).
    // 2. CLASSIFICAZIONE CURVE: 2 archi circolari per M a sinistra (start: 120deg, stop: 240deg) e a destra (start: -60deg, stop: 60deg) con anchor: "origin".
    // FASE 2: COSTRUZIONE
    #canvas(length: 1cm, {
      import draw: *

      // Concio elementare [- +]
      rect((-0.7, 0.7), (0.7, 1.3), fill: luma(220), stroke: 0.6pt)

      // Vettori N, T, M a sinistra e a destra (in blu)
      line((-0.7, 0.8), (-1.4, 0.8), stroke: (paint: blue.darken(20%), thickness: 0.8pt), mark: (end: ">"))
      line((0.7, 0.8), (1.4, 0.8), stroke: (paint: blue.darken(20%), thickness: 0.8pt), mark: (end: ">"))
      line((-0.7, 0.7), (-0.7, 1.55), stroke: (paint: blue.darken(20%), thickness: 0.8pt), mark: (end: ">"))
      line((0.7, 1.3), (0.7, 0.45), stroke: (paint: blue.darken(20%), thickness: 0.8pt), mark: (end: ">"))
      arc((-0.5, 1.0), start: 120deg, stop: 240deg, radius: 0.55, anchor: "origin", stroke: (paint: blue.darken(20%), thickness: 0.8pt), mark: (start: ">"))
      arc((0.5, 1.0), start: -60deg, stop: 60deg, radius: 0.55, anchor: "origin", stroke: (paint: blue.darken(20%), thickness: 0.8pt), mark: (end: ">"))

      // Diagramma sforzo normale nullo in basso
      line((-2.0, -0.5), (2.0, -0.5), stroke: 1.2pt)
      line((-1.15, -0.62), (-0.85, -0.38), stroke: (paint: blue.darken(20%), thickness: 1.2pt))
      line((-1.15, -0.38), (-0.85, -0.62), stroke: (paint: blue.darken(20%), thickness: 1.2pt))
      line((0.85, -0.62), (1.15, -0.38), stroke: (paint: blue.darken(20%), thickness: 1.2pt))
      line((0.85, -0.38), (1.15, -0.62), stroke: (paint: blue.darken(20%), thickness: 1.2pt))

      // Etichette (con text(size: 7pt))
      content((-0.52, 0.85), text(size: 7pt)[$-$], anchor: "west")
      content((0.52, 0.85), text(size: 7pt)[$+$], anchor: "east")
      content((-1.45, 0.88), text(size: 7pt, fill: blue.darken(20%))[$N$], anchor: "south")
      content((1.45, 0.72), text(size: 7pt, fill: blue.darken(20%))[$N$], anchor: "north")
      content((-0.58, 1.55), text(size: 7pt, fill: blue.darken(20%))[$T$], anchor: "west")
      content((0.82, 0.5), text(size: 7pt, fill: blue.darken(20%))[$T$], anchor: "west")
      content((-1.15, 1.48), text(size: 7pt, fill: blue.darken(20%))[$M$], anchor: "east")
      content((1.15, 1.48), text(size: 7pt, fill: blue.darken(20%))[$M$], anchor: "west")
      content((-2.0, -0.65), text(size: 7pt)[$A$], anchor: "north")
      content((0, -0.65), text(size: 7pt)[$B$], anchor: "north")
      content((2.0, -0.65), text(size: 7pt)[$C$], anchor: "north")
    })
    // FASE 3: VERIFICA
    // 2 archi con start < stop e anchor: "origin", 11 etichette tutte con text(size: 7pt).
  ]
)
#v(0.5em)

*Taglio $T$:*
Dato che i carichi applicati alla struttura sono uniformemente distribuiti, il taglio ha andamento lineare a tratti:
- *Tratto $A B$ ($0 lt.eq x lt.eq L$ con origine in $A$):*
  $ arrow.b : quad -V_A + q_1 x + T = 0 arrow.r T = V_A - q_1 x $
  - in $A$ ($x = 0$): $T = V_A = 1500 "N"$
  - in $B$ ($x = L$): $T = V_A - q_1 L = -4500 "N"$
  - $T = 0$ per $x = V_A / q_1 = 0,5 "m"$
- *Tratto $B C$ ($0 lt.eq x lt.eq L$ con origine in $C$):*
  $ arrow.t : quad T - q_2 x = 0 arrow.r T = q_2 x $
  - in $C$ ($x = 0$): $T = 0$
  - in $B$ ($x = L$): $T = q_2 L = 3000 "N"$

*Momento flettente $M$:*
Dato che il taglio ha andamento lineare a tratti, il momento flettente ha andamento quadratico (parabolico) a tratti:
- *Tratto $A B$ ($0 lt.eq x lt.eq L$ con origine in $A$):*
  $ S^+ : quad -V_A x + q_1 x dot x / 2 + M = 0 arrow.r.double M = V_A x - q_1 x^2 / 2 $
  - in $A$ ($x = 0$): $M = 0 "Nm"$
  - in $B$ ($x = L$): $M = -3000 "Nm"$
  - in $x = 0,5 "m"$ dove $T = 0$, $M$ raggiunge un punto di massimo: $M = 375 "Nm"$
  - $M = 0$ per $x = (2 V_A) / q_1 = 1 "m"$
- *Tratto $B C$ ($0 lt.eq x lt.eq L$ con origine in $C$):*
  $ S^- : quad M + q_2 x dot x / 2 = 0 arrow.r M = -q_2 x^2 / 2 $
  - in $C$ ($x = 0$): $M = 0$
  - in $B$ ($x = L$): $M = -q_2 L^2 / 2 = -3000 "Nm"$

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Diagramma del taglio T (pagina 3 in alto):
    // - Tratto AB: lineare da +1500 N in A, zero a x = 0.5 m (un quarto di AB), fino a -4500 N a sinistra di B.
    // - Tratto BC: lineare da +3000 N a destra di B fino a 0 in C.
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, A=(0,0), B=(2.2, 0), C=(4.4, 0). Altezza +1500 N -> +0.45 cm; -4500 N -> -1.35 cm; +3000 N -> +0.90 cm.
    // 2. ELEMENTI: Asse trave AC, spezzata blu del diagramma T, segni + e -, quote 1500 N, -4500 N, 3000 N. Etichette tutte con text(size: 7pt).
    // FASE 2: COSTRUZIONE
    #canvas(length: 1.5cm, {
      import draw: *

      // Asse trave A-B-C
      line((0, 0), (4.4, 0), stroke: 1.2pt)

      // Diagramma del taglio T (in blu)
      line((0, 0), (0, 0.48), (2.2, -1.35), (2.2, 0.92), (4.4, 0), stroke: (paint: blue.darken(20%), thickness: 1pt))

      // Etichette (con text(size: 7pt))
      content((0, 0.58), text(size: 7pt, fill: blue.darken(20%))[$1500 "N"$], anchor: "south")
      content((2.3, -1.35), text(size: 7pt, fill: blue.darken(20%))[$-4500 "N"$], anchor: "west")
      content((2.2, 1.02), text(size: 7pt, fill: blue.darken(20%))[$3000 "N"$], anchor: "south")
      content((0.2, 0.2), text(size: 7pt, fill: blue.darken(20%))[$+$], anchor: "center")
      content((1.75, -0.55), text(size: 7pt, fill: blue.darken(20%))[$-$], anchor: "center")
      content((2.65, 0.35), text(size: 7pt, fill: blue.darken(20%))[$+$], anchor: "center")
      content((0, -0.15), text(size: 7pt)[$A$], anchor: "north")
      content((2.35, -0.15), text(size: 7pt)[$B$], anchor: "north")
      content((4.4, -0.15), text(size: 7pt)[$C$], anchor: "north")
    })
    // FASE 3: VERIFICA
    // Solo segmenti rettilinei, 9 etichette tutte con text(size: 7pt).
  ],
  [
    // FASE 0: COMPRENSIONE
    // Diagramma del momento flettente M (pagina 3 in basso):
    // - Tratto AB: parabola che scende sotto l'asse fino a +375 Nm in x = 0.5 m (x = 0.55 cm), ripassa per zero in x = 1 m (x = 1.1 cm) e sale fino al cuspide superiore di -3000 Nm in B (x = 2.2 cm, y = +1.15 cm).
    // - Tratto BC: parabola da -3000 Nm in B (2.2, 1.15) tangente in C=(4.4, 0).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, A=(0,0), B=(2.2, 0), C=(4.4, 0).
    // 2. CLASSIFICAZIONE CURVE:
    //    - Parabola su AB da (0,0) a (1.1, 0) con minimo in (0.55, -0.38) e prosecuzione fino a (2.2, 1.15):
    //      // BEZIER NECESSARIO: cerchio e_max = 0.22, ellisse e_max = 0.18 (arco parabolico di momento flettente).
    //      Usiamo 2 bezier sul tratto AB (divisi nel punto di nullo (1.1, 0) per avere massima fedeltà) e 1 bezier sul tratto BC da (2.2, 1.15) a (4.4, 0).
    // FASE 2: COSTRUZIONE
    #canvas(length: 1.5cm, {
      import draw: *

      // Asse trave A-B-C
      line((0, 0), (4.4, 0), stroke: 1.2pt)

      // Diagramma parabolico del momento M (in blu)
      bezier((0, 0), (1.1, 0), (0.35, -0.5), (0.75, -0.5), stroke: (paint: blue.darken(20%), thickness: 1pt))
      bezier((1.1, 0), (2.2, 1.15), (1.5, 0.35), (1.9, 0.78), stroke: (paint: blue.darken(20%), thickness: 1pt))
      bezier((2.2, 1.15), (4.4, 0), (2.8, 0.45), (3.5, 0.05), stroke: (paint: blue.darken(20%), thickness: 1pt))
      line((2.2, 0), (2.2, 1.15), stroke: 0.6pt)

      // Etichette (con text(size: 7pt))
      content((0.55, -0.45), text(size: 7pt, fill: blue.darken(20%))[$375 "Nm"$], anchor: "north")
      content((2.2, 1.25), text(size: 7pt, fill: blue.darken(20%))[$-3000 "Nm"$], anchor: "south")
      content((0.55, -0.18), text(size: 7pt, fill: blue.darken(20%))[$+$], anchor: "center")
      content((1.9, 0.4), text(size: 7pt, fill: blue.darken(20%))[$-$], anchor: "center")
      content((2.45, 0.4), text(size: 7pt, fill: blue.darken(20%))[$-$], anchor: "center")
      content((0, -0.15), text(size: 7pt)[$A$], anchor: "north")
      content((2.2, -0.15), text(size: 7pt)[$B$], anchor: "north")
      content((4.4, -0.15), text(size: 7pt)[$C$], anchor: "north")
    })
    // FASE 3: VERIFICA
    // 3 bezier per i rami parabolici di M, 8 etichette tutte con text(size: 7pt).
  ]
)
#v(1em)

=== 2.3) Sezione più sollecitata e andamento delle tensioni
Dai diagrammi delle caratteristiche di sollecitazione si osserva che la sezione più sollecitata è quella corrispondente al punto $B$ (immediatamente a sinistra del vincolo), dove $T = -4500 "N"$ e $M = -3000 "Nm"$.

Dal testo è noto che la sezione a doppio T è da considerarsi spessa e quindi sollecitata soltanto dalla tensione normale $sigma_x$ dovuta al momento flettente e dalla tensione tangenziale $tau_(y z)$ (o $tau_(x y)$) dovuta al taglio, con gli andamenti riportati nella figura seguente:

// FASE 0: COMPRENSIONE
// Sezione a doppio T affiancata dal diagramma lineare a farfalla delle tensioni normali di flessione sigma_x (in rosso) e dal diagramma parabolico a gradini delle tensioni tangenziali di taglio tau_yz alla Jourawski (in rosso, pagina 4 in alto).
// FASE 1: ANALISI
// 1. PANNELLI E SCALA: 3 elementi allineati orizzontalmente nello stesso canvas (altezza sezione H = 2.0 cm da y = -1.0 a y = +1.0):
//    - Sezione a doppio T centrata in (0, 0) tra x = -1.2 e x = 1.2.
//    - Diagramma sigma_x con asse verticale in x = 3.2, farfalla da (2.6, -1.0) a (3.8, +1.0).
//    - Diagramma tau_yz con asse verticale in x = 5.0, parabole sulle ali (x da 5.0 a 5.55), brusco salto all'innesto con l'anima (y = +-0.7) da x = 5.55 a x = 6.3, e parabola sull'anima con massimo in y = 0 (x = 6.45).
// 2. CLASSIFICAZIONE CURVE:
//    - Archi parabolici per tau_yz sull'ala superiore, sull'anima e sull'ala inferiore:
//      // BEZIER NECESSARIO: cerchio e_max = 0.14, ellisse e_max = 0.11 (profilo parabolico di Jourawski).
//      Usiamo 3 bezier per i tre tratti parabolici (ala superiore, anima centrale, ala inferiore).
// FASE 2: COSTRUZIONE
#align(center)[
  #canvas(length: 2cm, {
    import draw: *

    // Linee di costruzione orizzontali tratteggiate grigie
    line((1.2, 1.0), (6.7, 1.0), stroke: (paint: luma(200), thickness: 0.6pt))
    line((1.2, 0.7), (6.7, 0.7), stroke: (paint: luma(200), thickness: 0.6pt))
    line((1.2, 0), (6.7, 0), stroke: (paint: luma(200), thickness: 0.6pt))
    line((1.2, -0.7), (6.7, -0.7), stroke: (paint: luma(200), thickness: 0.6pt))
    line((1.2, -1.0), (6.7, -1.0), stroke: (paint: luma(200), thickness: 0.6pt))

    // Sezione a doppio T
    line((-1.2, -1.0), (1.2, -1.0), (1.2, -0.7), (0.18, -0.7), (0.18, 0.7), (1.2, 0.7), (1.2, 1.0), (-1.2, 1.0), (-1.2, 0.7), (-0.18, 0.7), (-0.18, -0.7), (-1.2, -0.7), close: true, stroke: 1.2pt)

    // Assi z, y e quote B, b, h, H
    line((-1.2, 0), (1.45, 0), stroke: 0.6pt, mark: (end: ">"))
    line((0, 1.25), (0, -1.35), stroke: 0.6pt, mark: (end: ">"))
    line((-0.18, 0.25), (0.18, 0.25), stroke: 0.6pt, mark: (start: ">", end: ">"))
    line((1.6, -0.7), (1.6, 0.7), stroke: 0.6pt, mark: (start: ">", end: ">"))
    line((1.95, -1.0), (1.95, 1.0), stroke: 0.6pt, mark: (start: ">", end: ">"))
    line((-1.2, -1.65), (1.2, -1.65), stroke: 0.6pt, mark: (start: ">", end: ">"))

    // Diagramma lineare a farfalla sigma_x (in rosso)
    line((3.2, -1.0), (3.2, 1.0), stroke: (paint: red, thickness: 0.8pt))
    line((2.55, -1.0), (3.85, 1.0), stroke: (paint: red, thickness: 0.8pt))
    line((3.2, 1.0), (3.85, 1.0), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
    line((3.2, 0.65), (3.62, 0.65), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
    line((3.2, 0.35), (3.42, 0.35), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
    line((3.2, -0.35), (2.98, -0.35), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
    line((3.2, -0.65), (2.78, -0.65), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
    line((3.2, -1.0), (2.55, -1.0), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))

    // Diagramma parabolico a gradini tau_yz (in rosso)
    line((5.0, -1.0), (5.0, 1.0), stroke: (paint: red, thickness: 0.8pt))
    bezier((5.0, 1.0), (5.6, 0.7), (5.3, 0.92), (5.5, 0.8), stroke: (paint: red, thickness: 0.8pt))
    line((5.6, 0.7), (6.3, 0.7), stroke: (paint: red, thickness: 0.8pt))
    bezier((6.3, 0.7), (6.3, -0.7), (6.52, 0.25), (6.52, -0.25), stroke: (paint: red, thickness: 0.8pt))
    line((6.3, -0.7), (5.6, -0.7), stroke: (paint: red, thickness: 0.8pt))
    bezier((5.6, -0.7), (5.0, -1.0), (5.5, -0.8), (5.3, -0.92), stroke: (paint: red, thickness: 0.8pt))

    // Frecce interne del diagramma tau_yz
    line((5.0, 0.82), (5.42, 0.82), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
    line((5.0, 0.52), (6.38, 0.52), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
    line((5.0, 0.18), (6.46, 0.18), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
    line((5.0, -0.18), (6.46, -0.18), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
    line((5.0, -0.52), (6.38, -0.52), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
    line((5.0, -0.82), (5.42, -0.82), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))

    // Etichette (con text(size: 7pt))
    content((-0.05, 0.4), text(size: 7pt)[$b$], anchor: "south")
    content((1.38, -0.12), text(size: 7pt)[$z$], anchor: "north")
    content((0.12, -1.25), text(size: 7pt)[$y$], anchor: "west")
    content((1.7, 0.1), text(size: 7pt)[$h$], anchor: "west")
    content((2.05, 0.05), text(size: 7pt)[$H$], anchor: "west")
    content((0, -1.6), text(size: 7pt)[$B$], anchor: "south")
    content((3.45, 1.15), text(size: 7pt, fill: red)[$sigma_x$], anchor: "south")
    content((5.5, 1.15), text(size: 7pt, fill: red)[$tau_(y z)$], anchor: "south")
  })
]
// FASE 3: VERIFICA
// 3 bezier per i tre rami parabolici del taglio alla Jourawski, 8 etichette tutte con text(size: 7pt).
#v(0.5em)

=== 2.4) Valori massimi delle tensioni nel punto più sollecitato della sezione
Dal testo sono note le proprietà inerziali $I_z = 920833 "mm"^4$ (momento d'inerzia) e $S_z = 15875 "mm"^3$ (momento statico) della sezione a doppio T.

#grid(
  columns: (1.1fr, 0.9fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    I valori massimi della tensione normale di flessione sono posizionati alla sommità delle ali ($y = plus.minus H / 2$):
    $ sigma_("x,max") = M / I_z dot H / 2 = (3000 dot 10^3) / 920833 dot 70 / 2 = 114 "MPa" $

    Il valore massimo della tensione tangenziale di taglio è invece posizionato in corrispondenza dell'asse baricentrico $z$ ($y = 0$), dove la tensione normale di flessione è nulla:
    $ tau_("xy,max") = (T S_z) / (I_z b) = (4500 dot 15875) / (920833 dot 10) = 7,8 "MPa" $

    Dato che la tensione dovuta al momento flettente è di gran lunga superiore a quella dovuta al taglio, il punto più sollecitato $P$ della sezione più sollecitata è quello più lontano dall'asse $z$ baricentrico (indicato dal pallino rosso in figura, dove $sigma_x = 114 "MPa"$ e $tau = 0$).
  ],
  [
    
    #canvas(length: 2cm, {
      import draw: *

      // Sezione a doppio T
      line((-1.2, -1.0), (1.2, -1.0), (1.2, -0.7), (0.18, -0.7), (0.18, 0.7), (1.2, 0.7), (1.2, 1.0), (-1.2, 1.0), (-1.2, 0.7), (-0.18, 0.7), (-0.18, -0.7), (-1.2, -0.7), close: true, stroke: 1.2pt)

      // Assi z, y e quote
      line((1.4, 0), (-1.25, 0), stroke: 0.6pt, mark: (end: ">"))
      line((0, -1.25), (0, 1.25), stroke: 0.6pt, mark: (end: ">"))
      line((-0.18, 0.25), (0.18, 0.25), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((1.55, -0.7), (1.55, 0.7), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((1.9, -1.0), (1.9, 1.0), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((-1.2, -1.6), (1.2, -1.6), stroke: 0.6pt, mark: (start: ">", end: ">"))

      // Punto più sollecitato P (in rosso)
      circle((0, 1.0), radius: 0.08, fill: red, stroke: red)

      // Etichette (con text(size: 7pt))
      content((0.12, 1.12), text(size: 7pt, fill: red)[*P*], anchor: "west")
      content((-0.12, 1.2), text(size: 7pt)[$y$], anchor: "east")
      content((-1.2, -0.15), text(size: 7pt)[$z$], anchor: "north")
      content((-0.05, 0.38), text(size: 7pt)[$b$], anchor: "south")
      content((1.65, 0.1), text(size: 7pt)[$h$], anchor: "west")
      content((2.0, 0.05), text(size: 7pt)[$H$], anchor: "west")
      content((0, -1.55), text(size: 7pt)[$B$], anchor: "south")
    })
    // FASE 3: VERIFICA
    // 1 cerchietto rosso r = 0.08 per P, 7 etichette tutte con text(size: 7pt).
  ]
)
#v(1em)

=== 2.5) Tensore delle tensioni nel punto più sollecitato, tensioni principali e cerchi di Mohr

#grid(
  columns: (1.05fr, 0.95fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    Nel punto più sollecitato $P$ lo stato di tensione è monoassiale di pura trazione:
    $ mat(delim: "[",
      114, 0, 0;
      0, 0, 0;
      0, 0, 0
    ) "MPa" $
    Le tre tensioni principali valgono pertanto:
    $ sigma_1 = sigma_("x,max") = 114 "MPa", wide sigma_2 = 0, wide sigma_3 = 0 $

    === 2.6) Coefficiente di sicurezza
    Dato che lo stato di tensione nel punto più sollecitato è monoassiale, entrambe le ipotesi di cedimento di Tresca e di von Mises portano allo stesso risultato in termini di tensione ideale:
    $ sigma_("id") = sigma_1 = 114 "MPa" $
    Il coefficiente di sicurezza a snervamento vale quindi:
    $ s = R_("p0.2") / sigma_("id") = 275 / 114 = 2,4 $
  ],
  [
    
    #canvas(length: 1.5cm, {
      import draw: *

      // Assi sigma e tau
      line((-0.4, 0), (3.4, 0), stroke: 0.6pt, mark: (end: ">"))
      line((0, -0.3), (0, 1.9), stroke: 0.6pt, mark: (end: ">"))

      // Semicerchio di Mohr (in rosso)
      arc((1.3, 0), start: 0deg, stop: 180deg, radius: 1.3, anchor: "origin", stroke: (paint: red, thickness: 1pt))

      // Etichette (con text(size: 7pt))
      content((3.3, -0.15), text(size: 7pt)[$sigma$], anchor: "north")
      content((0.15, 1.8), text(size: 7pt)[$tau$], anchor: "west")
      content((2.6, -0.15), text(size: 7pt)[$sigma_1$], anchor: "north")
    })
    // FASE 3: VERIFICA
    // 1 arco circolare con start=0deg < stop=180deg e anchor: "origin", 3 etichette tutte con text(size: 7pt).
  ]
)
#v(1em)

=== 2.7) Spostamento verticale del punto $C$, con sovrapposizione degli effetti
Scomponiamo il calcolo dello spostamento verticale $v_C$ dell'estremo a sbalzo $C$ nella somma di tre contributi elementari ricavati dalla tabella dei casi notevoli della linea elastica.

*1. Contributo del carico distribuito $q_1$ sul tratto $A B$:*
Consideriamo prima soltanto il carico distribuito $q_1$, ottenendo il caso di una trave appoggiata in $A$ e $B$ caricata dal carico distribuito $q_1$, mentre il tratto scarico $B C$ ruota rigidamente verso l'alto dell'angolo $theta_B$:

#grid(
  columns: (0.95fr, 1.05fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    $ cases(
      theta_B = (q_1 L^3) / (24 E I_z),
      v_("C,1") = theta_B L = (q_1 L^4) / (24 E I_z) = 10,86 "mm" arrow.t
    ) $
  ],
  [
    
    #canvas(length: 1.5cm, {
      import draw: *

      // Trave e vincoli in A e B
      line((0, 0), (4.0, 0), stroke: 1.2pt)
      line((0, 0), (-0.14, -0.24), (0.14, -0.24), close: true, stroke: 0.6pt)
      line((2.0, 0), (1.86, -0.22), (2.14, -0.22), close: true, stroke: 0.6pt)
      circle((1.93, -0.27), radius: 0.05, stroke: 0.6pt)
      circle((2.07, -0.27), radius: 0.05, stroke: 0.6pt)

      // Carico q1 su AB
      line((0, 0.8), (2.0, 0.8), stroke: 0.6pt)
      line((0, 0.8), (0, 0.04), stroke: 1pt, mark: (end: ">"))
      line((0.5, 0.8), (0.5, 0.04), stroke: 1pt, mark: (end: ">"))
      line((1.0, 0.8), (1.0, 0.04), stroke: 1pt, mark: (end: ">"))
      line((1.5, 0.8), (1.5, 0.04), stroke: 1pt, mark: (end: ">"))
      line((2.0, 0.8), (2.0, 0.04), stroke: 1pt, mark: (end: ">"))

      // Linea elastica 1 (in rosso) e spostamento v_{C,1}
      bezier((0, 0), (2.0, 0), (0.65, -0.3), (1.35, -0.3), stroke: (paint: red, thickness: 1pt))
      line((2.0, 0), (4.0, 0.9), stroke: (paint: red, thickness: 1pt))
      line((4.0, 0), (4.0, 0.9), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      arc((2.0, 0), start: 0deg, stop: 24deg, radius: 0.45, anchor: "origin", stroke: (paint: red, thickness: 0.6pt))

      // Etichette (con text(size: 7pt))
      content((1.0, 0.9), text(size: 7pt)[$q_1$], anchor: "south")
      content((-0.18, -0.1), text(size: 7pt)[$A$], anchor: "east")
      content((1.82, -0.15), text(size: 7pt)[$B$], anchor: "east")
      content((4.0, -0.15), text(size: 7pt)[$C$], anchor: "north")
      content((2.55, 0.12), text(size: 7pt, fill: red)[$theta_B$], anchor: "west")
      content((4.1, 0.45), text(size: 7pt, fill: red)[$v_("C,1")$], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 1 bezier per la deformata su AB, 1 arco per theta_B (start=0deg < stop=24deg, anchor: "origin"), 6 etichette con text(size: 7pt).
  ]
)
#v(0.5em)

*2. Contributo della rotazione in $B$ prodotta dal carico $q_2$ agente sullo sbalzo $B C$:*
Per valutare l'influenza sul tratto $A B$ del carico distribuito $q_2$ agente sul tratto $B C$, consideriamo ora una coppia concentrata equivalente applicata in $B$ pari a $M = q_2 L^2 / 2$:

#grid(
  columns: (0.95fr, 1.05fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    $ cases(
      theta_B = (M L) / (3 E I_z) = (q_2 L^3) / (6 E I_z),
      v_("C,2") = theta_B L = (q_2 L^4) / (6 E I_z) = 21,72 "mm" arrow.b
    ) $
  ],
  [
    // FASE 0: COMPRENSIONE
    // Schema deformata elastica 2 (pagina 5 in basso): trave ABC con coppia concentrata M = q_2 L^2 / 2 in B; linea elastica rossa inarcata verso l'alto su AB e rettilinea inclinata verso il basso di theta_B su BC, con freccia v_{C,2} verso il basso.
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, A=(0,0), B=(2.0, 0), C=(4.0, 0).
    // 2. CLASSIFICAZIONE CURVE:
    //    - Deformata su AB da (0,0) a (2.0, 0):
    //      // BEZIER NECESSARIO: cerchio e_max = 0.15, ellisse e_max = 0.12 (linea elastica cubica per coppia di estremità).
    //      Usiamo 1 bezier da (0,0) a (2.0, 0) con C1=(0.7, 0.35), C2=(1.4, 0.3) seguito dal segmento rettilineo da (2.0, 0) a (4.0, -0.9).
    // FASE 2: COSTRUZIONE
    #canvas(length: 1.5cm, {
      import draw: *

      // Trave e vincoli in A e B
      line((0, 0), (4.0, 0), stroke: 1.2pt)
      line((0, 0), (-0.14, -0.24), (0.14, -0.24), close: true, stroke: 0.6pt)
      line((2.0, 0), (1.86, -0.22), (2.14, -0.22), close: true, stroke: 0.6pt)
      circle((1.93, -0.27), radius: 0.05, stroke: 0.6pt)
      circle((2.07, -0.27), radius: 0.05, stroke: 0.6pt)

      // Coppia concentrata M = q_2 L^2 / 2 in B
      arc((2.0, 0), start: 10deg, stop: 160deg, radius: 0.3, anchor: "origin", stroke: 1pt, mark: (start: ">"))

      // Linea elastica 2 (in rosso) e spostamento v_{C,2}
      bezier((0, 0), (2.0, 0), (0.7, 0.35), (1.4, 0.3), stroke: (paint: red, thickness: 1pt))
      line((2.0, 0), (4.0, -0.9), stroke: (paint: red, thickness: 1pt))
      line((4.0, 0), (4.0, -0.9), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))
      arc((2.0, 0), start: -24deg, stop: 0deg, radius: 0.45, anchor: "origin", stroke: (paint: red, thickness: 0.6pt))

      // Etichette (con text(size: 7pt))
      content((2.2, 0.32), text(size: 7pt)[$M = q_2 L^2 / 2$], anchor: "west")
      content((-0.18, -0.1), text(size: 7pt)[$A$], anchor: "east")
      content((1.82, -0.15), text(size: 7pt)[$B$], anchor: "east")
      content((4.0, 0.15), text(size: 7pt)[$C$], anchor: "south")
      content((2.55, -0.12), text(size: 7pt, fill: red)[$theta_B$], anchor: "west")
      content((4.1, -0.45), text(size: 7pt, fill: red)[$v_("C,2")$], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 1 bezier per la deformata su AB, 2 archi con start < stop e anchor: "origin", 6 etichette con text(size: 7pt).
  ]
)
#v(0.5em)

*3. Contributo della deformabilità flessionale propria dello sbalzo $B C$ sotto il carico $q_2$:*
Consideriamo infine il contributo del carico distribuito $q_2$ sul tratto $B C$, come se il tratto $B C$ fosse una mensola incastrata in $B$:

#grid(
  columns: (0.95fr, 1.05fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    $ v_("C,3") = (q_2 L^4) / (8 E I_z) = 16,29 "mm" arrow.b $

    *Spostamento verticale complessivo di $C$:*
    Sommando algebricamente i tre contributi (assumendo positivi gli spostamenti verso il basso) otteniamo:
    $ v_C = -v_("C,1") + v_("C,2") + v_("C,3") = -10,86 + 21,72 + 16,29 = 27,15 "mm" $
    calcolato positivo e quindi diretto verso il basso $arrow.b$.
  ],
  [
    #canvas(length: 2cm, {
      import draw: *

      // Mensola BC e incastro in B
      line((0, 0), (2.2, 0), stroke: 1.2pt)
      line((0, -0.3), (0, 0.3), stroke: 0.8pt)
      line((-0.18, -0.3), (0, -0.15), stroke: 0.6pt)
      line((-0.18, -0.15), (0, 0), stroke: 0.6pt)
      line((-0.18, 0), (0, 0.15), stroke: 0.6pt)
      line((-0.18, 0.15), (0, 0.3), stroke: 0.6pt)

      // Carico distribuito q2 su BC
      line((0, 0.55), (2.2, 0.55), stroke: 0.6pt)
      line((0.2, 0.55), (0.2, 0.04), stroke: 1pt, mark: (end: ">"))
      line((0.7, 0.55), (0.7, 0.04), stroke: 1pt, mark: (end: ">"))
      line((1.2, 0.55), (1.2, 0.04), stroke: 1pt, mark: (end: ">"))
      line((1.7, 0.55), (1.7, 0.04), stroke: 1pt, mark: (end: ">"))
      line((2.2, 0.55), (2.2, 0.04), stroke: 1pt, mark: (end: ">"))

      // Linea elastica 3 (in rosso) e spostamento v_{C,3}
      bezier((0, 0), (2.2, -0.65), (0.8, 0), (1.5, -0.28), stroke: (paint: red, thickness: 1pt))
      line((2.2, 0), (2.2, -0.65), stroke: (paint: red, thickness: 0.6pt), mark: (end: ">"))

      // Etichette (con text(size: 7pt))
      content((1.2, 0.65), text(size: 7pt)[$q_2$], anchor: "south")
      content((-0.22, -0.15), text(size: 7pt)[$B$], anchor: "east")
      content((2.3, -0.1), text(size: 7pt)[$C$], anchor: "west")
      content((2.3, -0.5), text(size: 7pt, fill: red)[$v_("C,3")$], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 1 bezier per la deformata della mensola BC, 4 etichette tutte con text(size: 7pt).
  ]
)
#pagebreak()
// ==========================================
// PARTE 1: TESTO DELL'ESAME (SOLO TRACCE)
// ==========================================
= Fondamenti di Meccanica Strutturale - Testo d'Esame(10/09/2026)

== Esercizio 1
Si consideri una trave rettilinea a parete sottile aperta avente sezione trasversale a doppio T simmetrica, come illustrato in figura. Le dimensioni geometriche della sezione sono: larghezza delle ali $b = 60 "mm"$, altezza complessiva $h = 100 "mm"$ e spessore costante di parete $p = 5 "mm"$.
La sezione, il cui baricentro è indicato con $G$, è sottoposta contemporaneamente a un momento flettente $M_z = 3000 "Nm"$ (diretto lungo l'asse baricentrico $z$) e a un momento torcente $M_x = 300 "Nm"$ (attorno all'asse longitudinale $x$). Il materiale costituente la trave presenta un allungamento percentuale a rottura del $3 %$ e una tensione limite di rottura $sigma_("limit") = 400 "MPa"$.
*Dati geometrici, di carico e del materiale:*
    - Larghezza delle ali: $b = 60 "mm"$
    - Altezza totale della sezione: $h = 100 "mm"$
    - Spessore di parete: $p = 5 "mm"$
    - Baricentro: $G$
    - Momento flettente: $M_z = 3000 "Nm"$
    - Momento torcente: $M_x = 300 "Nm"$
    - Allungamento percentuale a rottura: $A_% = 3 %$
    - Tensione limite di rottura: $sigma_("limit") = 400 "MPa"$

    *Quesiti:*
    + *1.1* Rappresentare qualitativamente lo stato tensionale della sezione, tracciando i diagrammi delle tensioni normali $sigma_(x x)$ dovute a flessione e delle tensioni tangenziali $tau_x$ dovute a torsione.
    + *1.2* Individuare il punto maggiormente sollecitato della sezione e calcolare il relativo tensore delle tensioni $[sigma]$.
    + *1.3* Determinare analiticamente le tensioni principali $sigma_1$, $sigma_2$, $sigma_3$ e tracciare i corrispondenti cerchi di Mohr.
    + *1.4* Scelta l'ipotesi di cedimento più idonea per il materiale in esame, calcolare il coefficiente di sicurezza $C S$.

#align(center)[ #canvas(length: 2cm, {
      import draw: *

      // Contorno della sezione a doppio T
      line((-1.2, -1.6), (1.2, -1.6), (1.2, -1.36), (0.12, -1.36), (0.12, 1.36), (1.2, 1.36), (1.2, 1.6), (-1.2, 1.6), (-1.2, 1.36), (-0.12, 1.36), (-0.12, -1.36), (-1.2, -1.36), close: true, stroke: 1pt)

      // Baricentro G e terna baricentrica (y, z, x)
      circle((0, 0), radius: 0.04, fill: black)
      line((0, 0), (0, 1.8), stroke: 0.6pt, mark: (end: ">"))
      line((0, 0), (-1.0, 0), stroke: 0.6pt, mark: (end: ">"))
      line((-1.45, 0), (-2.1, 0), stroke: 0.8pt, mark: (end: ">"))
      line((-1.45, 0), (-1.92, 0), stroke: 0.8pt, mark: (end: ">"))

      // Quota superiore b
      line((-1.2, 1.65), (-1.2, 2.05), stroke: 0.6pt)
      line((1.2, 1.65), (1.2, 2.05), stroke: 0.6pt)
      line((-1.2, 1.95), (1.2, 1.95), stroke: 0.6pt, mark: (start: ">", end: ">"))

      // Quota spessore p
      line((1.25, 1.36), (1.65, 1.36), stroke: 0.6pt)
      line((1.25, 1.6), (1.65, 1.6), stroke: 0.6pt)
      line((1.5, 1.36), (1.5, 1.6), stroke: 0.6pt, mark: (start: ">", end: ">"))

      // Quota laterale h
      line((1.25, -1.6), (2.25, -1.6), stroke: 0.6pt)
      line((1.65, 1.6), (2.25, 1.6), stroke: 0.6pt)
      line((2.1, -1.6), (2.1, 1.6), stroke: 0.6pt, mark: (start: ">", end: ">"))

      // Etichette (tutte con text(size: 7pt))
      content((0, 2.05), text(size: 7pt)[$b$], anchor: "south")
      content((1.62, 1.48), text(size: 7pt)[$p$], anchor: "west")
      content((2.22, 0), text(size: 7pt)[$h$], anchor: "west")
      content((-0.12, 1.72), text(size: 7pt)[$y$], anchor: "east")
      content((-1.15, 0), text(size: 7pt)[$z$], anchor: "east")
      content((-0.1, 0.15), text(size: 7pt)[$G$], anchor: "east")
      content((0.05, -0.18), text(size: 7pt)[$x$], anchor: "north")
      content((-1.8, 0.15), text(size: 7pt)[$M_z$], anchor: "south")
    })]

#pagebreak()



== Esercizio 2
Si consideri il telaio piano isostatico $A B C D E$ illustrato in figura, realizzato in acciaio S275 ($R_("p0,2") = 275 "MPa"$, $R_m = 320 "MPa"$, $E = 200000 "MPa"$) e costituito da travi a sezione circolare piena di diametro $D$.
La struttura è vincolata a terra mediante due cerniere fisse poste alle estremità $A$ ed $E$, ed è dotata di una cerniera interna in $B$. Il ritto verticale di sinistra è composto dal tratto inferiore $A B$ di lunghezza $L$ e dal tratto superiore $B C$ di lunghezza $L / 2$; il traverso orizzontale $C D$ e il ritto verticale di destra $D E$ hanno entrambi lunghezza $L$.
Lungo l'intero ritto verticale di sinistra $A C$ agisce un carico uniformemente distribuito orizzontale $q$ diretto verso destra, mentre in corrispondenza del nodo $D$ è applicata una forza concentrata verticale $F$ diretta verso l'alto.

*Dati del problema:*
    - Materiale: Acciaio S275
      - $R_("p0,2") = 275 "MPa"$
      - $R_m = 320 "MPa"$
      - $E = 200000 "MPa"$
    - Luce di riferimento: $L = 2 "m"$
    - Carico distribuito orizzontale: $q = 3000 "N/m"$
    - Forza concentrata verticale: $F = 5000 "N"$
    - Coefficiente di sicurezza richiesto: $C S = 2$
    - Sezione circolare piena di diametro $D$

    *Quesiti:*
    + *2.1* Calcolare le reazioni vincolari esterne nelle cerniere fisse $A$ ed $E$ (indicandone modulo, direzione e verso).
    + *2.2* Determinare analiticamente le caratteristiche di sollecitazione ($N$, $T$, $M$) in tutti i tratti del telaio e tracciarne i relativi diagrammi quotati.
    + *2.3* Individuare la sezione maggiormente sollecitata della struttura.
    + *2.4* Calcolare il diametro minimo $D_("min")$ della sezione più sollecitata affinché sia rispettato il coefficiente di sicurezza $C S = 2$.
#align(center)[#canvas(length: 2cm, {
      import draw: *

      // Struttura principale A-B-C-D-E
      line((0, 0), (0, 3.0), (2.0, 3.0), (2.0, 1.0), stroke: 1pt)

      // Cerniera interna in B (0, 2.0)
      circle((0, 2.0), radius: 0.07, fill: white, stroke: 1pt)

      // Cerniera fissa in A (0, 0)
      line((0, 0), (-0.14, -0.22), (0.14, -0.22), close: true, stroke: 0.6pt)
      line((-0.22, -0.22), (0.22, -0.22), stroke: 0.6pt)

      // Cerniera fissa in E (2.0, 1.0)
      line((2.0, 1.0), (1.86, 0.78), (2.14, 0.78), close: true, stroke: 0.6pt)
      line((1.78, 0.78), (2.22, 0.78), stroke: 0.6pt)
      line((1.8, 0.68), (1.88, 0.78), stroke: 0.6pt)
      line((1.9, 0.68), (1.98, 0.78), stroke: 0.6pt)
      line((2.0, 0.68), (2.08, 0.78), stroke: 0.6pt)
      line((2.1, 0.68), (2.18, 0.78), stroke: 0.6pt)

      // Carico distribuito q su AC
      line((-0.45, 0), (-0.45, 3.0), stroke: 0.6pt)
      line((-0.45, 0), (-0.02, 0), stroke: 0.6pt, mark: (end: ">"))
      line((-0.45, 0.375), (-0.02, 0.375), stroke: 0.6pt, mark: (end: ">"))
      line((-0.45, 0.75), (-0.02, 0.75), stroke: 0.6pt, mark: (end: ">"))
      line((-0.45, 1.125), (-0.02, 1.125), stroke: 0.6pt, mark: (end: ">"))
      line((-0.45, 1.5), (-0.02, 1.5), stroke: 0.6pt, mark: (end: ">"))
      line((-0.45, 1.875), (-0.02, 1.875), stroke: 0.6pt, mark: (end: ">"))
      line((-0.45, 2.25), (-0.02, 2.25), stroke: 0.6pt, mark: (end: ">"))
      line((-0.45, 2.625), (-0.02, 2.625), stroke: 0.6pt, mark: (end: ">"))
      line((-0.45, 3.0), (-0.02, 3.0), stroke: 0.6pt, mark: (end: ">"))

      // Forza concentrata F in D
      line((2.0, 3.0), (2.0, 3.65), stroke: 1pt, mark: (end: ">"))

      // Quote geometriche
      line((0.32, 0), (0.32, 2.0), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((0.32, 2.0), (0.32, 3.0), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((0, 2.0), (0.4, 2.0), stroke: 0.6pt)

      line((0, -0.55), (2.0, -0.55), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((0, -0.25), (0, -0.65), stroke: 0.6pt)
      line((2.0, 0.65), (2.0, -0.65), stroke: 0.6pt)

      line((2.85, 1.0), (2.85, 3.0), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((2.0, 1.0), (2.95, 1.0), stroke: 0.6pt)
      line((2.0, 3.0), (2.95, 3.0), stroke: 0.6pt)

      // Etichette (tutte con text(size: 7pt))
      content((0.15, -0.1), text(size: 7pt)[$A$], anchor: "west")
      content((0.1, 2.15), text(size: 7pt)[$B$], anchor: "west")
      content((0, 3.12), text(size: 7pt)[$C$], anchor: "south")
      content((2.12, 3.12), text(size: 7pt)[$D$], anchor: "west")
      content((1.88, 1.08), text(size: 7pt)[$E$], anchor: "east")
      content((2.12, 3.55), text(size: 7pt)[$F$], anchor: "west")
      content((-0.58, 1.5), text(size: 7pt)[$q$], anchor: "east")
      content((0.42, 1.0), text(size: 7pt)[$L$], anchor: "west")
      content((0.42, 2.65), text(size: 7pt)[$L / 2$], anchor: "west")
      content((1.0, -0.48), text(size: 7pt)[$L$], anchor: "south")
      content((2.98, 2.0), text(size: 7pt)[$L$], anchor: "west")
    })]
#grid(
  columns: (0.95fr, 1.05fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    
  ],
  [
    // FASE 0: COMPRENSIONE
    // Schema strutturale iniziale del telaio A-B-C-D-E con cerniere fisse a terra in A (quota 0) ed E (quota L/2), cerniera interna in B (quota L), traverso CD a quota 3/2 L di larghezza L, carico distribuito orizzontale q lungo AC, forza concentrata verticale F verso l'alto in D e quote geometriche L, L/2, L, L.
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 singolo pannello. Origine O=(0,0) in A. Scala: L = 2.0 cm (quindi L/2 = 1.0 cm, altezza AC = 3.0 cm, larghezza CD = 2.0 cm, E in (2.0, 1.0)).
    // 2. FIGURE IN PROSPETTIVA: Piano 2D (x, y).
    // 3. ELEMENTI:
    // - Ritto sinistro AC: da (0, 0) a (0, 3.0).
    // - Traverso CD: da (0, 3.0) a (2.0, 3.0).
    // - Ritto destro DE: da (2.0, 3.0) a (2.0, 1.0).
    // - Cerniera interna B: cerchietto centrato in (0, 2.0) di raggio r = 0.07.
    // - Cerniera fissa a terra in A=(0, 0) e in E=(2.0, 1.0).
    // - Carico distribuito q a sinistra di AC: linea verticale a x = -0.45 da y = 0 a y = 3.0 con frecce orizzontali verso destra.
    // - Forza F in D=(2.0, 3.0): freccia verticale verso l'alto fino a (2.0, 3.65).
    // - Quote: L e L/2 a destra del ritto AC (x = 0.35), L in basso tra x = 0 e x = 2.0 (y = -0.55), L a destra del ritto DE (x = 2.85).
    // - Etichette tutte con text(size: 7pt).
    // 4. CLASSIFICAZIONE CURVE: Solo segmenti rettilinei e 1 cerchietto per la cerniera B (r = 0.07).
    // FASE 2: COSTRUZIONE
    
    // FASE 3: VERIFICA
    // 1 cerchietto r = 0.07 per B, 11 etichette tutte con text(size: 7pt).
  ]
)

#pagebreak()
// ==========================================
// PARTE 2: SOLUZIONI E PROCEDIMENTO COMPLETO
// ==========================================
= Soluzione dell'Esame

== Primo esercizio) Soluzione

=== 1.1) Lo stato tensionale della sezione
Sotto l'azione combinata del momento flettente $M_z$ e del momento torcente $M_x$, sulla sezione trasversale nascono:
- una distribuzione lineare a farfalla di tensioni normali $sigma_(x x)$ (nulle sull'asse neutro baricentrico $z$, di compressione nella metà superiore $y > 0$ e di trazione nella metà inferiore $y < 0$);
- una distribuzione di tensioni tangenziali $tau_x$ alla Saint-Venant che, trattandosi di una sezione sottile aperta composta da tre rettangoli allungati (le due ali e l'anima), fluiscono con andamento lineare lungo lo spessore di ciascun rettangolo, annullandosi sulla linea media e raggiungendo il valore massimo lungo i bordi longitudinali.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    #canvas(length: 1.5cm, {
      import draw: *

      // Assi di riferimento del diagramma
      line((0, -1.5), (0, 1.75), stroke: 0.8pt, mark: (end: ">"))
      line((-0.8, 0), (1.35, 0), stroke: 0.6pt, mark: (end: ">"))

      // Contorno diagramma a farfalla sigma_xx
      line((0, 1.4), (-0.95, 1.4), (0.95, -1.4), (0, -1.4), stroke: 0.8pt)

      // Frecce interne (compressione in alto, trazione in basso)
      line((0, 1.15), (-0.78, 1.15), stroke: 0.6pt, mark: (end: ">"))
      line((0, 0.85), (-0.58, 0.85), stroke: 0.6pt, mark: (end: ">"))
      line((0, 0.55), (-0.37, 0.55), stroke: 0.6pt, mark: (end: ">"))
      line((0, 0.25), (-0.17, 0.25), stroke: 0.6pt, mark: (end: ">"))
      line((0, -0.25), (0.17, -0.25), stroke: 0.6pt, mark: (end: ">"))
      line((0, -0.55), (0.37, -0.55), stroke: 0.6pt, mark: (end: ">"))
      line((0, -0.85), (0.58, -0.85), stroke: 0.6pt, mark: (end: ">"))
      line((0, -1.15), (0.78, -1.15), stroke: 0.6pt, mark: (end: ">"))

      // Etichette (con text(size: 7pt))
      content((-0.15, 1.7), text(size: 7pt)[$y$], anchor: "east")
      content((1.35, -0.12), text(size: 7pt)[$x$], anchor: "north")
      content((0, -1.85), text(size: 7pt)[$sigma_(x x)$], anchor: "north")
    })
    
  ],
  [
    
    #canvas(length: 1.5cm, {
      import draw: *

      // Contorno della sezione a doppio T
      line((-1.15, -1.45), (1.15, -1.45), (1.15, -1.17), (0.14, -1.17), (0.14, 1.17), (1.15, 1.17), (1.15, 1.45), (-1.15, 1.45), (-1.15, 1.17), (-0.14, 1.17), (-0.14, -1.17), (-1.15, -1.17), close: true, stroke: 1pt)

      // Linee medie tratteggiate nei 3 rettangoli
      line((-1.05, 1.31), (1.05, 1.31), stroke: (dash: "dashed", thickness: 0.6pt))
      line((0, -1.15), (0, 1.15), stroke: (dash: "dashed", thickness: 0.6pt))
      line((-1.05, -1.31), (1.05, -1.31), stroke: (dash: "dashed", thickness: 0.6pt))

      // Frecce del flusso tangenziale nell'ala superiore
      line((0.8, 1.39), (0.2, 1.39), stroke: 0.6pt, mark: (end: ">"))
      line((-0.2, 1.39), (-0.8, 1.39), stroke: 0.6pt, mark: (end: ">"))
      line((-0.8, 1.23), (-0.2, 1.23), stroke: 0.6pt, mark: (end: ">"))
      line((0.2, 1.23), (0.8, 1.23), stroke: 0.6pt, mark: (end: ">"))

      // Frecce del flusso tangenziale nell'anima verticale
      line((-0.07, 0.8), (-0.07, 0.2), stroke: 0.6pt, mark: (end: ">"))
      line((-0.07, -0.2), (-0.07, -0.8), stroke: 0.6pt, mark: (end: ">"))
      line((0.07, -0.8), (0.07, -0.2), stroke: 0.6pt, mark: (end: ">"))
      line((0.07, 0.2), (0.07, 0.8), stroke: 0.6pt, mark: (end: ">"))

      // Frecce del flusso tangenziale nell'ala inferiore
      line((0.8, -1.23), (0.2, -1.23), stroke: 0.6pt, mark: (end: ">"))
      line((-0.2, -1.23), (-0.8, -1.23), stroke: 0.6pt, mark: (end: ">"))
      line((-0.8, -1.39), (-0.2, -1.39), stroke: 0.6pt, mark: (end: ">"))
      line((0.2, -1.39), (0.8, -1.39), stroke: 0.6pt, mark: (end: ">"))

      // Indicazione di M_x al centro
      arc((0, 0), start: 140deg, stop: 240deg, radius: 0.45, anchor: "origin", stroke: 0.8pt, mark: (end: ">"))

      // Etichette (con text(size: 7pt))
      content((-0.52, 0), text(size: 7pt)[$M_x$], anchor: "east")
      content((0, -1.85), text(size: 7pt)[$tau_x$], anchor: "north")
    })
    // FASE 3: VERIFICA
    // 1 arco circolare con start=140deg < stop=240deg e anchor: "origin", 2 etichette con text(size: 7pt).
  ]
)
#v(1em)

=== 1.2) Il punto maggiormente sollecitato e il calcolo del tensore delle tensioni

#grid(
  columns: (0.75fr, 1.25fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  [
   
    #canvas(length: 1.8cm, {
      import draw: *

      // Contorno della sezione a doppio T
      line((-1.1, -1.45), (1.1, -1.45), (1.1, -1.21), (0.12, -1.21), (0.12, 1.21), (1.1, 1.21), (1.1, 1.45), (-1.1, 1.45), (-1.1, 1.21), (-0.12, 1.21), (-0.12, -1.21), (-1.1, -1.21), close: true, stroke: 1pt)

      // Etichetta quota lembo inferiore
      content((1.25, 1.35), text(size: 7pt)[$y = - h / 2$], anchor: "west")
    })
    // FASE 3: VERIFICA
    // 1 etichetta con text(size: 7pt).
  ],
  [
    I punti maggiormente sollecitati a trazione per effetto del momento flettente $M_z$ si trovano sul bordo esterno dell'ala inferiore, in corrispondenza della quota:
    $ y = - h / 2 = -50 "mm" $

    *Calcolo della tensione normale di flessione:*
    La tensione normale varia secondo la legge di Navier:
    $ sigma_x (y) = - (M_z y) / I_z $
    Scomponendo la sezione nelle due ali di dimensioni $b times p$ (il cui baricentro dista $(h - p) / 2$ dall'asse $z$) e nell'anima verticale di dimensioni $p times (h - 2 p)$, il momento d'inerzia baricentrico $I_z$ vale:
    $ I_z &= 2 [ (b p^3) / 12 + b p ( (h - p) / 2 )^2 ] + (p (h - 2 p)^3) / 12 \
          &= 1,65875 times 10^6 "mm"^4 $
  ]
)
#v(0.5em)

Sostituendo nella formula di Navier per $y = -h / 2 = -50 "mm"$ (utilizzando a denominatore il valore $1,65885 dot 10^6 "mm"^4$ come riportato nel foglio manoscritto), otteniamo la tensione normale massima di trazione:
$ sigma_("x,max") = - (M_z (- h / 2)) / I_z = (3 times 10^6 "N" dot "mm" dot 50) / (1,65885 dot 10^6 "mm"^4) = 90,43 "MPa" $

*Calcolo della tensione tangenziale di torsione:*
Per una trave a sezione aperta sottile, la tensione tangenziale massima nel generico rettangolo $i$-esimo di spessore $b_i$ è data da:
$ tau_("max,i") = M_x / I_t b_i $
Poiché tutti i rettangoli che compongono la sezione hanno il medesimo spessore $b_i = p = 5 "mm"$, calcoliamo il fattore di rigidezza torsionale $I_t$ sommando il contributo delle due ali di lunghezza $b$ e dell'anima di lunghezza $(h - p)$:
$ I_t = 2 dot (b p^3) / 3 + ((h - p) p^3) / 3 = 2 dot (60 dot 5^3) / 3 + ((100 - 5) dot 5^3) / 3 = 8958,33 "mm"^4 $
La tensione tangenziale massima sul bordo dell'ala inferiore vale quindi:
$ arrow.r.double tau_("max") = (300000 dot (5)) / 8958,33 = 167 "MPa" $

*Il tensore delle tensioni:*
Nel punto maggiormente sollecitato (situato sul bordo inferiore dell'ala inferiore, dove la tensione tangenziale è diretta lungo l'asse $z$), il tensore delle tensioni $[sigma]$ nel sistema di riferimento $(x, y, z)$ risulta:
$ [sigma] = mat(delim: "[",
  90,43, 0, 167;
  0, 0, 0;
  167, 0, 0
) "MPa" $

=== 1.3) Le tensioni principali e i cerchi di Mohr

#grid(
  columns: (1.05fr, 0.95fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    Individuiamo i punti rappresentativi delle tre giaciture coordinate sul piano di Mohr $(sigma, tau)$:
    - Giacitura di normale $y$: $(0, 0)$
    - Giacitura di normale $x$: $(90,4, 167)$
    - Giacitura di normale $z$: $(0, -167)$

    Il cerchio di Mohr nel piano $(x, z)$ ha centro di ascissa $sigma_C$ e raggio $R$ pari a:
    $ sigma_C = (90,4) / 2 = 45,2 "MPa" $
    $ R = sqrt(167^2 + 45.2^2) = 173 "MPa" $

    Le tre tensioni principali ordinate sono pertanto:
    $ sigma_1 = sigma_C + R = 45,2 + 173 = 218,2 "MPa" $
    $ sigma_2 = 0 "MPa" $
    $ sigma_3 = sigma_C - R = 45,2 - 173 = -127,8 "MPa" $
  ],
  [
    
    #canvas(length: 1.8cm, {
      import draw: *

      // Assi sigma e tau
      line((-1.7, 0), (2.75, 0), stroke: 0.6pt, mark: (end: ">"))
      line((0, -2.0), (0, 2.0), stroke: 0.6pt, mark: (end: ">"))

      // Tre cerchi di Mohr
      circle((0.45, 0), radius: 1.73, stroke: 1pt)
      circle((-0.64, 0), radius: 0.64, stroke: 0.6pt)
      circle((1.09, 0), radius: 1.09, stroke: 0.6pt)

      // Diametro coniugato tra (0, -1.67) e (0.90, 1.67) passante per (0.45, 0)
      line((0, -1.67), (0.90, 1.67), stroke: 0.6pt)
      line((0.90, 0), (0.90, 1.67), stroke: (dash: "dashed", thickness: 0.6pt))

      // Punti notevoli
      circle((0.90, 1.67), radius: 0.05, fill: black)
      circle((0, -1.67), radius: 0.05, fill: black)
      circle((0.45, 0), radius: 0.04, fill: black)

      // Etichette (con text(size: 7pt))
      content((2.7, -0.15), text(size: 7pt)[$sigma$], anchor: "north")
      content((-0.15, 1.9), text(size: 7pt)[$tau$], anchor: "east")
      content((0.55, 1.05), text(size: 7pt)[$R$], anchor: "east")
      content((-1.32, -0.15), text(size: 7pt)[$sigma_3$], anchor: "north")
      content((-0.15, -0.15), text(size: 7pt)[$sigma_2$], anchor: "north")
      content((0.45, -0.15), text(size: 7pt)[$sigma_C$], anchor: "north")
      content((2.22, -0.15), text(size: 7pt)[$sigma_1$], anchor: "north")
    })
    // FASE 3: VERIFICA
    // 1. Verifica geometrica sul cerchio grande: il punto (0.90, 1.67) dista dal centro (0.45, 0) esattamente sqrt((0.90-0.45)^2 + 1.67^2) = sqrt(0.2025 + 2.7889) = 1.7296 cm (scarto da R = 1.73 pari a 0.0004 < 0.02).
    // 2. Tutte le 7 etichette usano text(size: 7pt).
  ]
)
#v(1em)

=== 1.4) Il coefficiente di sicurezza
Dal momento che il materiale presenta un allungamento percentuale a rottura del $3 % < 5 %$, siamo in presenza di un *materiale fragile*:
$ A_% = 3 % < 5 % arrow.r.double "materiale fragile" $
Adottiamo pertanto l'*ipotesi di cedimento di Rankine (o di Galileo)* della massima tensione normale principale:
$ arrow.r.double "Ipotesi di Rankine (massima tensione normale)" $
Confrontando la tensione principale massima di trazione $sigma_1 = 218,2 "MPa"$ con la tensione limite di rottura $sigma_("limit") = 400 "MPa"$, otteniamo il coefficiente di sicurezza statico:
$ arrow.r.double C S = sigma_("limit") / sigma_1 = 400 / 218,2 = 1,83 $


== Secondo esercizio Soluzione

=== 2.1) Le reazioni vincolari
Svincoliamo la struttura a terra sostituendo alle cerniere fisse in $A$ ed $E$ le componenti di reazione orizzontali e verticali $H_A$, $V_A$ e $H_E$, $V_E$, ed esponiamo le risultanti parziali del carico distribuito sul tratto inferiore $A B$ (pari a $q L$, applicata a quota $L / 2$ da $A$) e sul tratto superiore $B C$ (pari a $q L / 2$, applicata a metà di $B C$).

#align(center)[
    
    #canvas(length: 2.1cm, {
      import draw: *

      // Telaio A-B-C-D-E
      line((0, 0), (0, 2.7), (1.8, 2.7), (1.8, 0.9), stroke: 1pt)
      circle((0, 1.8), radius: 0.06, fill: white, stroke: 1pt)

      // Risultanti qL e qL/2 e forza F
      line((-0.55, 0.9), (-0.02, 0.9), stroke: 0.8pt, mark: (end: ">"))
      line((-0.55, 2.25), (-0.02, 2.25), stroke: 0.8pt, mark: (end: ">"))
      line((1.8, 2.7), (1.8, 3.25), stroke: 0.8pt, mark: (end: ">"))

      // Reazioni vincolari H_A, V_A, H_E, V_E
      line((-0.45, 0), (-0.04, 0), stroke: 0.8pt, mark: (end: ">"))
      line((0, -0.45), (0, -0.04), stroke: 0.8pt, mark: (end: ">"))
      line((1.35, 0.9), (1.76, 0.9), stroke: 0.8pt, mark: (end: ">"))
      line((1.8, 0.45), (1.8, 0.86), stroke: 0.8pt, mark: (end: ">"))

      // Quote interne L/2 e L
      line((0, 0.9), (1.8, 0.9), stroke: (dash: "dashed", thickness: 0.6pt))
      line((0.25, 0), (0.25, 0.9), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((0.95, 0.9), (0.95, 2.7), stroke: 0.6pt, mark: (start: ">", end: ">"))

      // Terna convenzione segni in basso a sinistra
      line((-0.8, -0.8), (-0.3, -0.8), stroke: 0.6pt, mark: (end: ">"))
      line((-0.8, -0.8), (-0.8, -0.3), stroke: 0.6pt, mark: (end: ">"))
      arc((-0.8, -0.8), start: 10deg, stop: 80deg, radius: 0.3, anchor: "origin", stroke: 0.6pt, mark: (end: ">"))

      // Etichette (con text(size: 7pt))
      content((-0.6, 0.9), text(size: 7pt)[$q L$], anchor: "east")
      content((-0.6, 2.25), text(size: 7pt)[$q L / 2$], anchor: "east")
      content((-0.12, 1.8), text(size: 7pt)[$B$], anchor: "east")
      content((0, 2.82), text(size: 7pt)[$C$], anchor: "south")
      content((1.9, 2.78), text(size: 7pt)[$D$], anchor: "west")
      content((1.9, 3.2), text(size: 7pt)[$F$], anchor: "west")
      content((1.9, 0.9), text(size: 7pt)[$E$], anchor: "west")
      content((-0.3, -0.15), text(size: 7pt)[$H_A$], anchor: "north")
      content((0.1, -0.35), text(size: 7pt)[$V_A$], anchor: "west")
      content((1.45, 0.78), text(size: 7pt)[$H_E$], anchor: "north")
      content((1.9, 0.55), text(size: 7pt)[$V_E$], anchor: "west")
      content((0.35, 0.45), text(size: 7pt)[$L / 2$], anchor: "west")
      content((0.85, 1.8), text(size: 7pt)[$L$], anchor: "east")
      content((-0.25, -0.9), text(size: 7pt)[$x$], anchor: "north")
      content((-0.92, -0.35), text(size: 7pt)[$y$], anchor: "east")
      content((-0.6, -0.6), text(size: 7pt)[$+$], anchor: "south")
    })
    // FASE 3: VERIFICA
    // 1 arco con start=10deg < stop=80deg e anchor: "origin", 16 etichette tutte con text(size: 7pt).
  ]
Scriviamo le tre equazioni cardinali della statica e l'equazione ausiliaria alla cerniera interna $B$ (per il tratto inferiore $A B$):
    $ cases(
      arrow.r quad &H_A + H_E + (3 q L) / 2 = 0 quad &(1),
      arrow.t quad &V_A + F + V_E = 0 quad &(2),
      E^("antiorario") quad &- (q L) / 2 dot (3 L) / 4 + H_A L / 2 - V_A L = 0 quad &(3),
      B^("antiorario") quad &H_A L + q L dot L / 2 = 0 arrow.r.double H_A = - (q L) / 2 
      &arrow.r.double H_A = -3 "kN" quad &(4)
    ) $

#v(0.5em)
Risolviamo il sistema sostituendo i valori numerici ($q = 3 "kN/m"$, $L = 2 "m"$, $F = 5 "kN"$):
    - *Da $(1), (4)$:*
      $ H_E = -H_A - (3 q L) / 2 = 3 - 3 dot 3 = -6 "kN" $
    - *Da $(3), (4)$:*
      $ V_A &= H_A / 2 - (3 q L) / 8 = -1,5 - 3 / 8 dot 3 dot 2 \
            &= -1,5 - 2,25 = -3,75 "kN" quad (5) $
    - *Da $(2), (5)$:*
      $ V_E = -V_A - F = 3,75 - 5 = -1,25 "kN" $
*Riepilogo dei moduli e dei versi effettivi delle reazioni vincolari:*
$ cases(
  abs(H_A) = 3000 "N" quad arrow.l,
  abs(H_E) = 6000 "N" quad arrow.l,
  abs(V_A) = 3750 "N" quad arrow.b,
  abs(V_E) = 1250 "N" quad arrow.b
) $

=== 2.2) Le caratteristiche di sollecitazione

*Tratto $A B$ ($0 < x < L$):*
Percorriamo il tratto inferiore del ritto sinistro da $A$ ($x = 0$) a $B$ ($x = L$).

#grid(
  columns: (0.75fr, 1.25fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Schema di corpo libero per il Tratto AB (0 < x < L da A verso B, pagina 2 al centro).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, A=(0,0), sezione x in (0, 1.3).
    // 2. ELEMENTI: Asta verticale di lunghezza x, carico q da sinistra verso destra, reazioni H_A e V_A in A, azioni interne N, T, M in cima allo spezzone. Etichette con text(size: 7pt).
    // FASE 2: COSTRUZIONE
    #canvas(length: 2cm, {
      import draw: *

      // Spezzone verticale Tratto AB
      line((0, 0), (0, 1.3), stroke: 1pt)

      // Carico distribuito q su x
      line((-0.4, 0), (-0.4, 1.3), stroke: 0.6pt)
      line((-0.4, 0.2), (-0.02, 0.2), stroke: 0.6pt, mark: (end: ">"))
      line((-0.4, 0.65), (-0.02, 0.65), stroke: 0.6pt, mark: (end: ">"))
      line((-0.4, 1.1), (-0.02, 1.1), stroke: 0.6pt, mark: (end: ">"))

      // Reazioni H_A e V_A
      line((-0.55, -0.15), (-0.05, -0.15), stroke: 0.8pt, mark: (end: ">"))
      line((0, -0.55), (0, -0.05), stroke: 0.8pt, mark: (end: ">"))

      // Ascissa x
      line((-0.6, 0.2), (-0.6, 0.9), stroke: 0.6pt, mark: (end: ">"))

      // Azioni interne N, T, M
      line((-0.15, 1.3), (0.15, 1.3), stroke: 0.6pt)
      line((0, 1.3), (0, 1.85), stroke: 0.8pt, mark: (end: ">"))
      line((0, 1.3), (0.55, 1.3), stroke: 0.8pt, mark: (end: ">"))
      arc((0, 1.3), start: 110deg, stop: 230deg, radius: 0.3, anchor: "origin", stroke: 0.8pt, mark: (start: ">"))

      // Etichette (con text(size: 7pt))
      content((0.12, -0.05), text(size: 7pt)[$A$], anchor: "west")
      content((-0.35, -0.25), text(size: 7pt)[$H_A$], anchor: "north")
      content((0.12, -0.4), text(size: 7pt)[$V_A$], anchor: "west")
      content((-0.7, 0.55), text(size: 7pt)[$x$], anchor: "east")
      content((0, 1.92), text(size: 7pt)[$N$], anchor: "south")
      content((0.62, 1.3), text(size: 7pt)[$T$], anchor: "west")
      content((-0.35, 1.45), text(size: 7pt)[$M$], anchor: "east")
    })
    // FASE 3: VERIFICA
    // Arco M con start=110deg < stop=230deg e anchor: "origin", 7 etichette con text(size: 7pt).
  ],
  [
    Dall'equilibrio del tronco inferiore di lunghezza $x$ ricaviamo:
    - $arrow.r) quad T + H_A + q x = 0 arrow.r.double T = -H_A - q x = +3 - 3 x "kN"$
    - $arrow.t) quad N + V_A = 0 arrow.r.double N = -V_A = 3,75 "kN"$
    - $x^("orario")) quad M + H_A x + (q x^2) / 2 = 0 \
      arrow.r.double M = -H_A x - (q x^2) / 2 = +3 x - 3 / 2 x^2$

    Valori nei punti notevoli:
    - in $A$ ($x = 0$): $N = 3,75 "kN"$, $T = +3 "kN"$, $M = 0$
    - in $B$ ($x = L$): $N = 3,75 "kN"$, $T = -3 "kN"$, $M = 0$
    - in mezzeria ($x = L / 2 = 1 "m"$): $M = 1,5 "kNm"$
  ]
)
#v(0.5em)

*Tratto $E D$ ($0 < x < L$):*
Percorriamo il ritto di destra partendo dalla cerniera inferiore $E$ ($x = 0$) verso il nodo $D$ ($x = L$).

#grid(
  columns: (0.75fr, 1.25fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Schema di corpo libero per il Tratto ED (0 < x < L da E verso D, pagina 2 in basso).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, E=(0,0), sezione x in (0, 1.2).
    // 2. ELEMENTI: Asta verticale, reazioni H_E e V_E in E, ascissa x, azioni interne N, T, M. Etichette con text(size: 7pt).
    // FASE 2: COSTRUZIONE
    #canvas(length: 2cm, {
      import draw: *

      line((0, 0), (0, 1.2), stroke: 1pt)

      // Reazioni H_E e V_E e ascissa x
      line((-0.55, -0.15), (-0.05, -0.15), stroke: 0.8pt, mark: (end: ">"))
      line((0, -0.55), (0, -0.05), stroke: 0.8pt, mark: (end: ">"))
      line((-0.25, 0.2), (-0.25, 0.75), stroke: 0.6pt, mark: (end: ">"))

      // Azioni interne N, T, M
      line((-0.15, 1.2), (0.15, 1.2), stroke: 0.6pt)
      line((0, 1.2), (0, 1.75), stroke: 0.8pt, mark: (end: ">"))
      line((0, 1.2), (0.55, 1.2), stroke: 0.8pt, mark: (end: ">"))
      arc((0, 1.2), start: -30deg, stop: 90deg, radius: 0.3, anchor: "origin", stroke: 0.8pt, mark: (start: ">"))

      // Etichette (con text(size: 7pt))
      content((0.12, -0.05), text(size: 7pt)[$E$], anchor: "west")
      content((-0.35, -0.25), text(size: 7pt)[$H_E$], anchor: "north")
      content((0.12, -0.4), text(size: 7pt)[$V_E$], anchor: "west")
      content((-0.35, 0.5), text(size: 7pt)[$x$], anchor: "east")
      content((0.1, 1.75), text(size: 7pt)[$N$], anchor: "west")
      content((0.55, 1.32), text(size: 7pt)[$T$], anchor: "south")
      content((0.35, 1.05), text(size: 7pt)[$M$], anchor: "west")
    })
    // FASE 3: VERIFICA
    // Arco M con start=-30deg < stop=90deg e anchor: "origin", 7 etichette con text(size: 7pt).
  ],
  [
    Dall'equilibrio del tronco inferiore $E x$ otteniamo:
    - $arrow.t) quad N + V_E = 0 arrow.r.double N = -V_E = +1,25 "kN"$
    - $arrow.r) quad T + H_E = 0 arrow.r.double T = -H_E = +6 "kN"$
    - $x^("antiorario")) quad -M + H_E x = 0 arrow.r.double M = H_E x = -6 x$

    Valori agli estremi:
    - in $E$ ($x = 0$): $N = 1,25 "kN"$, $T = +6 "kN"$, $M = 0$
    - in $D$ ($x = L$): $N = 1,25 "kN"$, $T = +6 "kN"$, $M = -12 "kNm"$
  ]
)
#v(0.5em)

*Tratto $D C$ ($0 < x < L$):*
Percorriamo il traverso orizzontale da destra verso sinistra partendo da $D$ ($x = 0$) verso $C$ ($x = L$).

#grid(
  columns: (0.75fr, 1.25fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Schema di corpo libero per il Tratto DC (ritto ED + spezzone orizzontale di lunghezza x da D verso C, pagina 3 in alto).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, E=(1.2, 0), D=(1.2, 1.4), sezione x in (0, 1.4).
    // 2. ELEMENTI: Ritto ED + tratto orizzontale D-x, reazioni H_E, V_E in E, forza F in D, quota L, ascissa x, azioni interne N, T, M. Etichette con text(size: 7pt).
    // FASE 2: COSTRUZIONE
    #canvas(length: 2cm, {
      import draw: *

      line((0, 1.4), (1.2, 1.4), (1.2, 0), stroke: 1pt)

      // Reazioni H_E, V_E e forza F
      line((0.65, 0), (1.16, 0), stroke: 0.8pt, mark: (end: ">"))
      line((1.2, -0.5), (1.2, -0.04), stroke: 0.8pt, mark: (end: ">"))
      line((1.2, 1.4), (1.2, 1.95), stroke: 0.8pt, mark: (end: ">"))

      // Quota L e ascissa x
      line((1.55, 0), (1.55, 1.4), stroke: 0.6pt, mark: (start: ">", end: ">"))
      line((1.1, 1.7), (0.6, 1.7), stroke: 0.6pt, mark: (end: ">"))

      // Azioni interne N, T, M
      line((0, 1.2), (0, 1.6), stroke: 0.6pt)
      line((0, 1.4), (-0.55, 1.4), stroke: 0.8pt, mark: (end: ">"))
      line((0, 1.4), (0, 1.9), stroke: 0.8pt, mark: (end: ">"))
      arc((0, 1.4), start: 120deg, stop: 240deg, radius: 0.3, anchor: "origin", stroke: 0.8pt, mark: (start: ">"))

      // Etichette (con text(size: 7pt))
      content((1.3, 0.05), text(size: 7pt)[$E$], anchor: "west")
      content((0.8, -0.15), text(size: 7pt)[$H_E$], anchor: "north")
      content((1.05, -0.35), text(size: 7pt)[$V_E$], anchor: "east")
      content((1.3, 1.85), text(size: 7pt)[$F$], anchor: "west")
      content((1.65, 0.7), text(size: 7pt)[$L$], anchor: "west")
      content((0.85, 1.8), text(size: 7pt)[$x$], anchor: "south")
      content((-0.5, 1.28), text(size: 7pt)[$N$], anchor: "north")
      content((0.12, 1.75), text(size: 7pt)[$T$], anchor: "west")
      content((-0.3, 1.75), text(size: 7pt)[$M$], anchor: "south")
    })
    // FASE 3: VERIFICA
    // Arco M con start=120deg < stop=240deg e anchor: "origin", 9 etichette con text(size: 7pt).
  ],
  [
    Dall'equilibrio del sottosistema di destra ricaviamo:
    - $arrow.r) quad -N + H_E = 0 arrow.r.double N = H_E = -6 "kN"$
    - $arrow.t) quad T + V_E + F = 0 arrow.r.double T = -F - V_E = -5 + 1,25 = -3,75 "kN"$
    - $x^("antiorario")) quad -M + F x + H_E L + V_E x = 0 \
      arrow.r.double M = (F + V_E) x + H_E L = -12 "kNm" + 3,75 x$

    Valori agli estremi:
    - $(D) quad x = 0 : quad N = -6 "kN", quad T = -3,75 "kN", quad M = -12 "kNm"$
    - $(C) quad x = L : quad N = -6 "kN", quad T = -3,75 "kN", quad M = -4,5 "kNm"$
  ]
)
#v(0.5em)

*Tratto $C B$ ($0 < x < L / 2$):*
Percorriamo infine il tratto verticale superiore del ritto di sinistra scendendo da $C$ ($x = 0$) verso la cerniera interna $B$ ($x = L / 2$).

#grid(
  columns: (0.75fr, 1.25fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  [
    // FASE 0: COMPRENSIONE
    // Schema di corpo libero per il Tratto CB (0 < x < L/2 da C verso B, pagina 3 in basso).
    // FASE 1: ANALISI
    // 1. PANNELLI E SCALA: 1 pannello, E=(1.2, 0), D=(1.2, 1.4), C=(0, 1.4), sezione x in (0, 0.9).
    // 2. ELEMENTI: Ritto ED + traverso DC + tratto verticale C-x con carico q, reazioni H_E, V_E in E, forza F in D, ascissa x verso il basso da C, azioni interne N, T, M. Etichette con text(size: 7pt).
    // FASE 2: COSTRUZIONE
    #canvas(length: 2.2cm, {
      import draw: *

      line((0, 0.9), (0, 1.4), (1.2, 1.4), (1.2, 0), stroke: 1pt)

      // Carico q sul tratto C-x
      line((-0.35, 0.9), (-0.35, 1.4), stroke: 0.6pt)
      line((-0.35, 1.0), (-0.02, 1.0), stroke: 0.6pt, mark: (end: ">"))
      line((-0.35, 1.2), (-0.02, 1.2), stroke: 0.6pt, mark: (end: ">"))
      line((-0.35, 1.4), (-0.02, 1.4), stroke: 0.6pt, mark: (end: ">"))

      // Reazioni H_E, V_E, forza F e ascissa x
      line((0.65, 0), (1.16, 0), stroke: 0.8pt, mark: (end: ">"))
      line((1.2, -0.5), (1.2, -0.04), stroke: 0.8pt, mark: (end: ">"))
      line((1.2, 1.4), (1.2, 1.95), stroke: 0.8pt, mark: (end: ">"))
      line((0.2, 1.38), (0.2, 1.05), stroke: 0.6pt, mark: (end: ">"))

      // Azioni interne N, T, M in (0, 0.9)
      line((-0.15, 0.9), (0.15, 0.9), stroke: 0.6pt)
      line((0, 0.9), (0, 0.4), stroke: 0.8pt, mark: (end: ">"))
      line((0, 0.9), (-0.5, 0.9), stroke: 0.8pt, mark: (end: ">"))
      arc((0, 0.9), start: 210deg, stop: 330deg, radius: 0.28, anchor: "origin", stroke: 0.8pt, mark: (start: ">"))

      // Etichette (con text(size: 7pt))
      content((0.8, -0.15), text(size: 7pt)[$H_E$], anchor: "north")
      content((1.05, -0.35), text(size: 7pt)[$V_E$], anchor: "east")
      content((1.3, 1.85), text(size: 7pt)[$F$], anchor: "west")
      content((0.3, 1.15), text(size: 7pt)[$x$], anchor: "west")
      content((0, 0.35), text(size: 7pt)[$N$], anchor: "north")
      content((-0.45, 0.78), text(size: 7pt)[$T$], anchor: "north")
      content((0.32, 0.78), text(size: 7pt)[$M$], anchor: "west")
    })
    // FASE 3: VERIFICA
    // Arco M con start=210deg < stop=330deg e anchor: "origin", 7 etichette con text(size: 7pt).
  ],
  [
    Imponendo l'equilibrio della sottostruttura superiore-destra:
    - $arrow.r) quad -T + q x + H_E = 0 arrow.r.double T = q x + H_E = -6 + 3 x$
    - $arrow.t) quad -N + V_E + F = 0 arrow.r.double N = V_E + F = -1,25 + 5 = 3,75 "kN"$
    - $x^("antiorario")) quad -M + (q x^2) / 2 + H_E (L - x) + F L + V_E L = 0$
      $ arrow.r.double M &= (F + V_E) L + H_E (L - x) - (q x^2) / 2 \
                         &= 7,5 - 6 (L - x) - 3 / 2 x^2 $

    Valori agli estremi:
    - in $C$ ($x = 0$): $N = 3,75 "kN"$, $T = -6 "kN"$, $M = -4,5 "kNm"$
    - in $B$ ($x = L / 2 = 1 "m"$, verifica): $M = 7,5 - 6(1) - 3 / 2 = 0$, $T = -3 "kN"$
  ]
)
#v(1em)

*Diagrammi delle caratteristiche di sollecitazione ($N$, $T$, $M$):*

// FASE 0: COMPRENSIONE
// I tre diagrammi affiancati dello sforzo normale (N), del taglio (T) e del momento flettente (M) sul telaio A-B-C-D-E (pagina 4 in alto).
// FASE 1: ANALISI
// 1. PANNELLI E SCALA: 3 pannelli affiancati nello stesso canvas con la stessa scala (L = 1.6 cm, L/2 = 0.8 cm, altezza ritto sinistro = 2.4 cm, larghezza traverso = 1.6 cm):
//    - Pannello 1 (N): origine A1 = (0, 0).
//    - Pannello 2 (T): origine A2 = (4.2, 0).
//    - Pannello 3 (M): origine A3 = (8.4, 0).
// 2. CLASSIFICAZIONE CURVE:
//    - Nel Pannello 3 (M), il diagramma sul ritto sinistro AB (da y=0 a y=1.6, con massimo 1.5 kNm a y=0.8) e sul tratto BC (da y=1.6 a y=2.4, fino a -4.5 kNm in C) è parabolico:
//      // BEZIER NECESSARIO: cerchio e_max = 0.18, ellisse e_max = 0.15 (archi parabolici di momento flettente).
//      Usiamo 1 bezier per la parabola su AB e 1 bezier per la parabola su BC.
// FASE 2: COSTRUZIONE
#align(center)[
  #canvas(length: 1.65cm, {
    import draw: *

    // ==========================================
    // PANNELLO 1: SFORZO NORMALE (N)
    // ==========================================
    line((0, 0), (0, 2.4), (1.6, 2.4), (1.6, 0.8), stroke: 1pt)
    circle((0, 1.6), radius: 0.05, fill: white, stroke: 0.8pt)

    // N = +3.75 kN su AB e BC (a sinistra)
    rect((-0.38, 0), (0, 1.6), stroke: 0.6pt)
    rect((-0.38, 1.6), (0, 2.4), stroke: 0.6pt)
    line((-0.38, 0.4), (0, 0.4), stroke: 0.6pt)
    line((-0.38, 0.8), (0, 0.8), stroke: 0.6pt)
    line((-0.38, 1.2), (0, 1.2), stroke: 0.6pt)
    line((-0.38, 2.0), (0, 2.0), stroke: 0.6pt)

    // N = -6 kN su CD (sotto il traverso)
    rect((0, 2.05), (1.6, 2.4), stroke: 0.6pt)
    line((0.4, 2.05), (0.4, 2.4), stroke: 0.6pt)
    line((0.8, 2.05), (0.8, 2.4), stroke: 0.6pt)
    line((1.2, 2.05), (1.2, 2.4), stroke: 0.6pt)

    // N = +1.25 kN su DE (a destra)
    rect((1.6, 0.8), (1.88, 2.4), stroke: 0.6pt)
    line((1.6, 1.2), (1.88, 1.2), stroke: 0.6pt)
    line((1.6, 1.6), (1.88, 1.6), stroke: 0.6pt)
    line((1.6, 2.0), (1.88, 2.0), stroke: 0.6pt)

    // Etichette Pannello 1
    content((0.5, 3.0), text(size: 7pt)[*(N)*], anchor: "south")
    content((-0.42, 2.0), text(size: 7pt)[$3,75 "kN"$], anchor: "east")
    content((0, -0.15), text(size: 7pt)[$3,75 "kN"$], anchor: "north")
    content((0.8, 1.95), text(size: 7pt)[$-6 "kN"$], anchor: "north")
    content((1.75, 0.68), text(size: 7pt)[$1,25 "kN"$], anchor: "north")
    content((-0.19, 0.6), text(size: 7pt)[$+$], anchor: "center")
    content((-0.19, 1.8), text(size: 7pt)[$+$], anchor: "center")
    content((0.8, 2.22), text(size: 7pt)[$-$], anchor: "center")
    content((1.74, 1.5), text(size: 7pt)[$+$], anchor: "center")

    // ==========================================
    // PANNELLO 2: TAGLIO (T)
    // ==========================================
    line((4.2, 0), (4.2, 2.4), (5.8, 2.4), (5.8, 0.8), stroke: 1pt)
    circle((4.2, 1.6), radius: 0.05, fill: white, stroke: 0.8pt)

    // T su AB (da +3 kN in A a -3 kN in B) e su BC (da -3 kN in B a -6 kN in C)
    line((4.2, 0), (3.85, 0), (4.55, 1.6), (4.85, 2.4), (4.2, 2.4), stroke: 0.6pt)
    line((4.2, 1.6), (4.55, 1.6), stroke: 0.6pt)

    // T = -3.75 kN su CD
    rect((4.2, 2.08), (5.8, 2.4), stroke: 0.6pt)

    // T = +6 kN su DE
    rect((5.8, 0.8), (6.25, 2.4), stroke: 0.6pt)

    // Etichette Pannello 2
    content((4.7, 3.0), text(size: 7pt)[*(T)*], anchor: "south")
    content((4.1, -0.15), text(size: 7pt)[$3 "kN"$], anchor: "north")
    content((4.62, 1.55), text(size: 7pt)[$-3 "kN"$], anchor: "west")
    content((4.5, 2.52), text(size: 7pt)[$-6 "kN"$], anchor: "south")
    content((5.2, 1.98), text(size: 7pt)[$-3,75 "kN"$], anchor: "north")
    content((6.05, 0.68), text(size: 7pt)[$6 "kN"$], anchor: "north")
    content((4.08, 0.3), text(size: 7pt)[$+$], anchor: "center")
    content((4.38, 1.35), text(size: 7pt)[$-$], anchor: "center")
    content((4.42, 1.95), text(size: 7pt)[$-$], anchor: "center")
    content((5.0, 2.24), text(size: 7pt)[$-$], anchor: "center")
    content((6.02, 1.6), text(size: 7pt)[$+$], anchor: "center")

    // ==========================================
    // PANNELLO 3: MOMENTO FLETTENTE (M)
    // ==========================================
    line((8.4, 0), (8.4, 2.4), (10.0, 2.4), (10.0, 0.8), stroke: 1pt)
    circle((8.4, 1.6), radius: 0.05, fill: white, stroke: 0.8pt)

    // Parabola su AB (max 1.5 kNm in mezzeria) e su BC (fino a -4.5 kNm in C)
    bezier((8.4, 0), (8.4, 1.6), (8.68, 0.5), (8.68, 1.1), stroke: 0.6pt)
    bezier((8.4, 1.6), (7.95, 2.4), (8.28, 1.85), (8.12, 2.15), stroke: 0.6pt)
    line((7.95, 2.4), (8.4, 2.4), stroke: 0.6pt)

    // Trapezio su CD (da -4.5 kNm in C a -12 kNm in D)
    line((8.4, 2.4), (8.4, 2.75), (10.0, 3.15), (10.0, 2.4), stroke: 0.6pt)
    line((8.8, 2.4), (8.8, 2.85), stroke: 0.6pt)
    line((9.2, 2.4), (9.2, 2.95), stroke: 0.6pt)
    line((9.6, 2.4), (9.6, 3.05), stroke: 0.6pt)

    // Triangolo su DE (da 0 in E a -12 kNm in D)
    line((10.0, 0.8), (10.65, 2.4), (10.0, 2.4), stroke: 0.6pt)
    line((10.0, 1.2), (10.16, 1.2), stroke: 0.6pt)
    line((10.0, 1.6), (10.32, 1.6), stroke: 0.6pt)
    line((10.0, 2.0), (10.48, 2.0), stroke: 0.6pt)

    // Etichette Pannello 3
    content((8.9, 3.15), text(size: 7pt)[*(M)*], anchor: "south")
    content((8.65, 0.8), text(size: 7pt)[$1,5$], anchor: "west")
    content((7.9, 2.4), text(size: 7pt)[$-4,5$], anchor: "east")
    content((8.35, 2.82), text(size: 7pt)[$-4,5$], anchor: "south")
    content((10.0, 3.22), text(size: 7pt)[$-12$], anchor: "south")
    content((10.7, 2.45), text(size: 7pt)[$-12$], anchor: "west")
    content((9.35, 2.65), text(size: 7pt)[$-$], anchor: "center")
  })
]
// FASE 3: VERIFICA
// 2 bezier nel Pannello 3 per le parabole del momento, 27 etichette tutte con text(size: 7pt).
#v(0.5em)

=== 2.3) La sezione maggiormente sollecitata
Dall'analisi dei diagrammi delle caratteristiche di sollecitazione, la sezione maggiormente sollecitata dell'intera struttura risulta essere *la sezione $D$ sul tratto $C D$*, in corrispondenza della quale si raggiungono contemporaneamente il massimo momento flettente in modulo ($abs(M) = 12 "kNm"$) e il massimo sforzo normale ($abs(N) = 6 "kN"$).

=== 2.4) Il diametro minimo della sezione più sollecitata che rispetti il coefficiente di sicurezza
Per l'acciaio S275 con coefficiente di sicurezza richiesto $C S = 2$, la tensione normale ammissibile vale:
$ sigma_("amiss") = R_("p0,2") / (C S) = 275 / 2 = 137,5 "MPa" $

Nella sezione critica $D$ (sul tratto $C D$) agiscono:
    $ M_z = 12 "kNm" = 12 dot 10^6 "N" dot "mm", wide N = 6 "kN" = 6000 "N" $

    Per una sezione circolare piena di diametro $D$, il momento d'inerzia baricentrico $J$ e l'area $A$ valgono:
    $ J = (pi D^4) / 64, wide A = (pi D^2) / 4 $

    Sommando in valore assoluto il contributo tensionale massimo dovuto alla flessione e quello dovuto allo sforzo normale otteniamo:
    $ sigma_(x,m) = abs((M dot D / 2) / J) + abs(N / A) = M / ((pi D^3) / 32) + N / ((pi D^2) / 4) < 137,5 "MPa" $

#v(0.5em)

Risolvendo la disequazione rispetto al diametro $D$, si ricava il diametro minimo necessario:
$ arrow.r.double D_("min") = 97 "mm" $


#pagebreak()





= *Domande di teoria* comparse davvero

== Teoria 1
- Descrivere le caratteristiche della trave di De Saint-Venant.
- Descrivere il metodo inverso di De Saint-Venant.
- Usare il metodo inverso per spiegare $sigma_(x x) = N / A$.
- Come mai è possibile solo nella sezione centrale? Motiva la risposta.

== Teoria 2
- Definire l'instabilità elastica.
- Ricavare attraverso l'equazione differenziale la freccia per una trave inflessa (con opportuno disegno).
- Ricavare attraverso l'equazione differenziale la freccia per una trave sottile (con opportuno disegno).
- Per il punto precedente, ricavare l'angolo di rotazione se viene applicato un momento $M_t$.

= *Domande di teoria* degli esempi d'esame 

== Teoria A (Flessione e presso-flessione)

- Definire la flessione retta e la flessione deviata.
- Considerando una sezione a piacere, calcolare analiticamente l'asse neutro nel caso di flessione retta e nel caso di flessione deviata.
- Cosa accade all'asse neutro se si aggiunge anche uno sforzo di compressione? Accompagnare la spiegazione con un disegno opportuno.

== Teoria B (Grado dei polinomi della linea elastica)

- Nel caso di una trave soggetta a carichi concentrati, di quale grado sono i polinomi che descrivono la linea elastica nei diversi tratti tra i carichi e/o i vincoli?
- Dimostrare la risposta precedente mediante un esempio.
- Quale tra i carichi visti nell'insegnamento è quello che produce il polinomio che descrive la linea elastica avente massimo grado? Motiva la risposta.

== Teoria C (Flesso-torsione e criterio di Tresca)

- Sia data una trave a sezione circolare piena soggetta a momento flettente e momento torcente: individuare lo stato di tensione nella sezione maggiormente sollecitata (con opportuno disegno).
- Ricavare le tensioni principali nella sezione maggiormente sollecitata.
- Dimostrare analiticamente che la tensione ideale secondo il criterio di cedimento di Tresca è direttamente proporzionale alla radice della somma dei quadrati del momento flettente e torcente.

== Teoria D (Snellezza e instabilità)

- Definire il fenomeno dell'instabilità elastica e definire la snellezza di una trave.
- Ricavare analiticamente la snellezza limite in funzione dei parametri del materiale (con opportuno disegno).

== Teoria E (Torsione in sezioni chiuse a parete sottile)

- Si consideri una trave con sezione di forma generica chiusa a parete sottile soggetta a momento torcente: indicare sulla base di quali ipotesi si studia la distribuzione delle tensioni nella sezione.
- Ricavare analiticamente la relazione per il calcolo dello stato di tensione in funzione del momento torcente (con opportuno disegno).

== Teoria F (Equazioni di congruenza)

- Definire le componenti speciali di deformazione e di spostamento nel continuo.
- Nel caso di piccoli spostamenti e piccole rotazioni, ricavare analiticamente le equazioni differenziali di congruenza accompagnando la dimostrazione con adeguati schemi grafici a supporto.

== Teoria G (Von Mises e confronto con Tresca)

- Descrivere l'ipotesi di partenza che porta alla determinazione della tensione ideale secondo il criterio di cedimento di Von Mises.
- Descrivere il procedimento analitico con cui si dimostra la tensione ideale di Von Mises.
- Nel caso di uno stato di tensione piano, dimostrare (anche con opportuno disegno) quale sia il criterio di cedimento statico più conservativo tra il criterio di Tresca e il criterio di Von Mises

= *Domande di teoria* tipo


== Teoria 1

- Definire il concetto di tensore e fornire opportuni esempi.
- Descrivere il vettore tensione e dimostrare a grandi linee perché non è sufficiente per delineare lo stato di tensione in un punto.
- Introdurre il tensore degli sforzi e scrivere le equazioni indefinite di equilibrio (con opportuno disegno).
- Spiegare il significato delle relazioni di reciprocità (Teorema di Cauchy) e definire le giaciture principali delle tensioni.

== Teoria 2

- Descrivere il problema elastico in modo generale.
- Scrivere le relazioni geometriche tra le componenti speciali di deformazione e le componenti di spostamento, definendo anche le giaciture principali delle deformazioni.
- Spiegare il significato fisico e matematico delle relazioni di congruenza.
- Descrivere lo stato di deformazione piano: quando si verifica? Motiva la risposta.

== Teoria 3

- Spiegare quali grandezze legano le leggi costitutive.
- Introdurre la matrice dei coefficienti elastici del materiale, i coefficienti di deformabilità e scrivere la legge di Hooke.
- Descrivere brevemente una prova di trazione (con opportuno disegno del provino e del grafico tensione-deformazione).
- Come si ricavano i parametri elastici del materiale dalla prova precedente? Motiva la risposta.

== Teoria 4

- Geomeccanica delle sezioni: definire analiticamente i momenti statici e i momenti del secondo ordine.
- Geomeccanica delle sezioni: definire gli assi baricentrici, gli assi principali e gli assi centrali d'inerzia.
- Spiegare la differenza tra modelli strutturali 1D e 2D.
- Descrivere le ipotesi dell'elemento strutturale "asta" e ricavarne lo stato di tensione e di deformazione.

== Teoria 5

- Descrivere le ipotesi del modello della trave di Eulero-Bernoulli e dare le definizioni delle caratteristiche di sollecitazione.
- Ricavare le equazioni indefinite di equilibrio al taglio e al momento flettente per l'elemento trave (con opportuno disegno).
- Considerando l'equazione di Navier per le tensioni $sigma$, ricavare l'equazione differenziale della linea elastica.
- Indipendentemente dai vincoli, dimostrare qual è il grado del polinomio che descrive la linea elastica di una trave caricata con un carico distribuito.

== Teoria 6

- Enunciare il Principio dei Lavori Virtuali (PLV) applicato ai sistemi di travi.
- Fare un esempio sull'uso del PLV impiegato come condizione di equilibrio (con opportuno disegno).
- Fare un esempio sull'uso del PLV impiegato come condizione di congruenza (con opportuno disegno).
- Per il punto precedente, descrivere la procedura per il calcolo di una reazione vincolare iperstatica tramite il PLV.

== Teoria 7

- Descrivere le ipotesi nel solido di De Saint Venant.
- Mostrare come si semplificano le equazioni indefinite di equilibrio e le leggi costitutive nel solido di De Saint Venant.
- Discutere l'andamento delle tensioni longitudinali ($sigma_(z z)$) e delle tensioni di taglio ($tau_(x z)$ e $tau_(y z)$) nel solido.
- Come mai le soluzioni di De Saint Venant sono valide solo lontano dalle basi (zone di applicazione dei carichi)? Motiva la risposta.

== Teoria 8

- Richiamare il problema della flessione nel solido di De Saint Venant e definire l'asse neutro.
- Mediante rappresentazione grafica (con opportuno disegno), supportata dallo sviluppo letterale delle equazioni coinvolte, illustrare il caso di flessione retta.
- Allo stesso modo, illustrare e sviluppare le equazioni per il caso di flessione deviata.
- Nella flessione deviata, dimostrare in quali casi l'asse neutro è perpendicolare all'asse di sollecitazione. Motiva la risposta.

== Teoria 9

- Definire il problema della torsione nel solido di De Saint Venant e definire il fattore di rigidezza torsionale $I_t$.
- Descrivere e ricavare il campo di tensione all'interno della sezione circolare soggetta a torsione pura (con opportuno disegno).
- Introdurre il solido di De Saint Venant soggetto a taglio (trattazione di Jourawski).
- Descrivere a grandi linee l'andamento delle tensioni tangenziali all'interno della sezione soggetta a taglio (con opportuno disegno).

== Teoria 10

- Descrivere l'andamento del flusso di taglio all'interno delle sezioni sottili soggette a torsione (con opportuno disegno).
- Quali sono le ipotesi per poter calcolare lo stato di tensione dovuto alla sollecitazione semplice di torsione nelle sezioni chiuse a parete sottile?
- Dimostrare la relazione per il calcolo dello stato di tensione tangenziale dovuto a torsione nelle sezioni chiuse a parete sottile (I formula di Bredt, con opportuno disegno).
- Per il punto precedente, ricavare l'angolo unitario di rotazione torsionale e definire la II formula di Bredt.

== Teoria 11

- Definire il concetto di criterio di resistenza statico e introdurre la definizione di energia di deformazione e di distorsione.
- Descrivere le ipotesi alla base del criterio di cedimento di Von Mises.
- Dimostrare la relazione matematica che permette il calcolo della tensione ideale del criterio di Von Mises partendo dalla definizione di energia di distorsione.
- Come mai la componente idrostatica della tensione non contribuisce al cedimento nei materiali duttili? Motiva la risposta.

== Teoria 12

- Enunciare le ipotesi del criterio di resistenza di Tresca e di quello di Von Mises.
- Scrivere le formulazioni matematiche dei due criteri ridotte al caso di uno stato di tensione piano.
- Nel caso di uno stato di tensione piano, dimostrare analiticamente e graficamente (con opportuno disegno nel piano delle tensioni principali) quale sia il criterio di cedimento statico più conservativo tra Tresca e Von Mises.
- Per quali stati di tensione i due criteri forniscono esattamente lo stesso risultato? Motiva la risposta.

== Teoria 13

- Sia data una trave a sezione circolare piena soggetta a momento flettente e momento torcente: individuare la sezione e i punti maggiormente sollecitati (con opportuno disegno).
- Scrivere le componenti di tensione presenti nel punto più sollecitato in funzione dei momenti applicati.
- Calcolare l'espressione delle tensioni principali nel punto maggiormente sollecitato.
- Dimostrare analiticamente che la differenza massima tra le tensioni principali è direttamente proporzionale alla radice della somma dei quadrati del momento flettente e torcente.

== Teoria 14

- Definire il fenomeno dell'instabilità elastica (carico di punta) e scrivere l'equazione del carico critico euleriano (con opportuno disegno).
- Definire dal punto di vista geometrico e fisico la snellezza di una trave.
- Ricavare analiticamente la snellezza limite in funzione dei parametri del materiale.
- Tracciare il grafico della tensione critica in funzione della snellezza (iperbole di Eulero): cosa succede se una trave ha una snellezza inferiore a quella limite? Motiva la risposta.

