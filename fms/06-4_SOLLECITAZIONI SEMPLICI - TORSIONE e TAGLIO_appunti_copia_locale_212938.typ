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
#let varepsilon = $epsilon$
#let vartheta = $theta$


#set heading(numbering: "1.")


// ============================================================================
// CODICE TYPST GENERATO DA GEMINI
// ============================================================================



// === Blocco_01_Slide_01-15 ===

= Sollecitazioni semplici: Torsione

== Torsione in travi a sezione circolare

La soluzione analitica esatta per il problema della torsione si ricava esclusivamente per la trave a sezione circolare soggetta a due momenti torcenti uguali e contrari $M_x = M_t$ applicati in corrispondenza delle sue sezioni trasversali di estremità.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    In tale configurazione geometrica vale l'ipotesi fondamentale di conservazione delle sezioni piane:
    - per effetto dell'azione del momento torcente $M_t$, ciascuna sezione trasversale ruota rigidamente nel proprio piano senza subire ingobbamenti fuori piano;
    - sulla generica sezione trasversale $S$, che divide idealmente il solido nei tronchi $1$ e $2$, agisce unicamente la componente di tensione tangenziale $tau$.
  ],
  [
    #canvas(length: 1cm, {
      import draw: *
      // Cilindro principale: x da 0 a 5.6, raggio y = 1.0, raggio x = 0.35
      line((0, 1.0), (5.6, 1.0), stroke: 1.2pt)
      line((0, -1.0), (5.6, -1.0), stroke: 1.2pt)
      
      // Asse longitudinale e assi verticali/trasversali alle estremita' e sezione S
      line((-0.5, 0), (6.1, 0), stroke: (dash: "dash-dotted", thickness: 0.6pt))
      line((0, -1.35), (0, 1.35), stroke: (dash: "dash-dotted", thickness: 0.6pt))
      line((3.5, -1.35), (3.5, 1.35), stroke: (dash: "dash-dotted", thickness: 0.6pt))
      line((5.6, -1.35), (5.6, 1.35), stroke: (dash: "dash-dotted", thickness: 0.6pt))
      
      // Assi prospettici z inclinati
      line((-0.6, -0.6), (0.6, 0.6), stroke: (dash: "dash-dotted", thickness: 0.5pt))
      line((2.9, -0.6), (4.1, 0.6), stroke: (dash: "dash-dotted", thickness: 0.5pt))
      line((5.0, -0.6), (6.2, 0.6), stroke: (dash: "dash-dotted", thickness: 0.5pt))

      // Ellisse sezione S (x = 3.5) con campitura grigia
      circle((3.5, 0), radius: (0.35, 1.0), fill: luma(220), stroke: (dash: "dashed", thickness: 0.8pt))
      line((3.5, -1.0), (3.5, 1.0), stroke: (dash: "dashed", thickness: 0.6pt))

      // Ellissi di estremita'
      circle((0, 0), radius: (0.35, 1.0), stroke: 1.2pt)
      circle((5.6, 0), radius: (0.35, 1.0), stroke: 1.2pt)

      // Frecce momento torcente Mt
      arc((0, 0), start: 135deg, stop: 225deg, radius: (0.22, 0.7), anchor: "origin", stroke: (dash: "dashed", thickness: 0.8pt), mark: (start: ">"))
      arc((5.6, 0), start: 135deg, stop: 225deg, radius: (0.22, 0.7), anchor: "origin", stroke: 0.8pt, mark: (end: ">"))

      // Etichette Mt
      content((-0.45, 0.15), text(size: 7pt)[$M_t$], anchor: "east")
      content((5.45, 0.15), text(size: 7pt)[$M_t$], anchor: "west")

      // Numeri tronchi 1, 2 e indicazione S
      circle((2.4, 1.75), radius: 0.25, stroke: 0.6pt)
      content((2.4, 1.75), text(size: 7pt)[1])
      line((2.3, 1.51), (2.0, 0.7), mark: (end: ">"), stroke: 0.6pt)

      circle((4.9, 1.75), radius: 0.25, stroke: 0.6pt)
      content((4.9, 1.75), text(size: 7pt)[2])
      line((4.8, 1.51), (4.5, 0.7), mark: (end: ">"), stroke: 0.6pt)

      line((3.6, 1.3), (3.95, 1.3), stroke: 0.6pt)
      line((3.95, 1.3), (3.6, 0.65), mark: (end: ">"), stroke: 0.6pt)
      content((3.77, 1.35), text(size: 7pt)[$S$], anchor: "south")
    })
  ]
)
#v(1em)

=== Scorrimento, angolo di torsione ed equazione di equivalenza

Isoliamo il tronco $1$ di lunghezza $l$. Poiché ogni sezione trasversale ruota rigidamente rispetto alla precedente, la generica fibra longitudinale $A_0 B_0$, inizialmente parallela all'asse $x$ della trave (in rosso), in seguito alla deformazione si dispone secondo un tratto di elica cilindrica $A_0 B$ (in blu), assumendo un'inclinazione pari all'angolo di scorrimento $gamma_1$.

Nell'ipotesi di piccoli spostamenti, lo scorrimento $gamma_1$ si approssima con la sua tangente trigonometrica:

$ gamma_1 approx tan gamma_1 = (B_0 B) / l $

Osservando la vista frontale della sezione trasversale nel piano $y z$, la lunghezza dell'arco $B_0 B$ sotteso dall'angolo di rotazione torsionale $theta$ a distanza radiale $r_1$ dal centro $O'$ vale:

$ B_0 B = r_1 theta $

Sostituendo l'espressione dell'arco nella relazione cinematica precedente, si ottiene il legame fondamentale tra lo scorrimento angolare $gamma_1$ e l'angolo di torsione $theta$:

$ gamma_1 = (r_1 theta) / l = theta / l r_1 $

Per un materiale elastico lineare, la tensione tangenziale $tau$ è legata da proporzionalità diretta allo scorrimento angolare $gamma$ mediante la legge di Hooke per le tensioni tangenziali:

$ tau = G gamma => tau = G theta / l r $

dove $G$ rappresenta il modulo di elasticità tangenziale (o modulo di taglio). Nel caso di materiali omogenei e isotropi, il modulo $G$ si esprime in funzione del modulo di elasticità normale $E$ (modulo di Young) e del coefficiente di contrazione trasversale di Poisson $nu$:

$ G = E / (2 (1 + nu)) $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Per effetto del momento torcente applicato, nel punto generico $B$ a distanza $r_1$ dal centro agisce la tensione tangenziale $tau_1$: sull'area elementare $d A_1$ si genera pertanto la forza infinitesima $d F_1 = tau_1 d A_1$. Analogamente, sull'area elementare $d A_2$ posta a distanza $r_2$ agisce la forza $d F_2 = tau_2 d A_2$. Su ciascun elemento infinitesimo della sezione trasversale agisce quindi la forza:

    $ d F_i = tau_i d A_i $
  ],
  [
    #canvas(length: 0.82cm, {
      import draw: *
      // --- PANNELLO SINISTRO: Tronco 1 ---
      line((0, 1.1), (3.4, 1.1), stroke: 1.2pt)
      line((0, -1.1), (3.4, -1.1), stroke: 1.2pt)
      circle((0, 0), radius: (0.35, 1.1), stroke: 1pt)
      circle((3.4, 0), radius: (0.35, 1.1), stroke: 1pt)

      // Assi
      line((-0.4, 0), (4.5, 0), mark: (end: ">"), stroke: (dash: "dash-dotted", thickness: 0.6pt))
      content((4.5, -0.15), text(size: 7pt)[$x$], anchor: "north")
      line((0, -1.4), (0, 1.4), stroke: (dash: "dash-dotted", thickness: 0.6pt))
      line((3.4, -1.4), (3.4, 1.4), stroke: (dash: "dash-dotted", thickness: 0.6pt))

      // Raggi O-A0, O'-B0, O'-B
      line((0, 0), (-0.22, -0.35), stroke: 0.6pt)
      line((3.4, 0), (3.18, -0.35), stroke: 0.6pt)
      line((3.4, 0), (3.25, -0.65), stroke: 0.6pt)

      // Fibra indeformata A0-B0 (rossa) e deformata A0-B (blu)
      line((-0.22, -0.35), (3.18, -0.35), stroke: (paint: red, thickness: 1.4pt))
      line((-0.22, -0.35), (3.25, -0.65), stroke: (paint: blue, thickness: 1.4pt))

      // Punti A0, B0, B
      circle((-0.22, -0.35), radius: 0.08, fill: black, stroke: none)
      circle((3.18, -0.35), radius: 0.08, fill: red, stroke: none)
      circle((3.25, -0.65), radius: 0.08, fill: blue, stroke: none)

      // Etichette punti e angoli sul cilindro
      content((0.05, 0.18), text(size: 7pt)[$O$], anchor: "west")
      content((3.45, 0.18), text(size: 7pt)[$O'$], anchor: "west")
      content((-0.22, -0.48), text(size: 7pt)[$A_0$], anchor: "north")
      content((3.15, -0.22), text(size: 7pt)[$B_0$], anchor: "east")
      content((3.35, -0.72), text(size: 7pt)[$B$], anchor: "west")
      content((2.3, 0.15), text(size: 7pt)[$l$], anchor: "south")
      content((3.42, -0.45), text(size: 7pt)[$theta$], anchor: "west")

      // Indicazione angolo gamma_1
      arc((-0.22, -0.35), start: -15deg, stop: 5deg, radius: 1.1, anchor: "origin", stroke: 0.5pt)
      content((1.05, -0.65), text(size: 7pt)[$gamma_1$], anchor: "north")

      // Momento Mt a sinistra
      arc((0, 0), start: 145deg, stop: 215deg, radius: (0.48, 1.1), anchor: "origin", stroke: 0.7pt, mark: (start: ">"))
      content((-0.5, 0.45), text(size: 7pt)[$M_t$], anchor: "east")

      // Indicatore tronco 1
      circle((1.9, 1.75), radius: 0.22, stroke: 0.6pt)
      content((1.9, 1.75), text(size: 7pt)[1])
      line((1.82, 1.54), (1.6, 0.85), mark: (end: ">"), stroke: 0.6pt)

      // --- PANNELLO DESTRO: Sezione trasversale (centro (6.8, 0), R = 1.25) ---
      circle((6.8, 0), radius: 1.25, stroke: 0.9pt)
      // Assi z (sinistra) e y (alto)
      line((8.2, 0), (5.0, 0), mark: (end: ">"), stroke: (dash: "dash-dotted", thickness: 0.6pt))
      content((5.0, -0.15), text(size: 7pt)[$z$], anchor: "north")
      line((6.8, -1.45), (6.8, 1.75), mark: (end: ">"), stroke: (dash: "dash-dotted", thickness: 0.6pt))
      content((6.95, 1.7), text(size: 7pt)[$y$], anchor: "west")

      // Raggi verso B0 (205 deg) e B (235 deg)
      line((6.8, 0), (5.67, -0.53), stroke: 0.6pt)
      line((6.8, 0), (6.08, -1.02), stroke: 0.6pt)
      arc((6.8, 0), start: 205deg, stop: 235deg, radius: 0.65, anchor: "origin", stroke: 0.5pt)
      content((6.45, 0.22), text(size: 7pt)[$theta$], anchor: "south")

      // Punto B0 (rosso) e area dA1 intorno a B (blu)
      circle((5.98, -0.38), radius: 0.08, fill: red, stroke: none)
      content((5.88, -0.25), text(size: 7pt)[$B_0$], anchor: "south")

      // Elemento dA1 e forza dF1
      line((6.05, -0.78), (6.22, -0.66), (6.34, -0.83), (6.17, -0.95), close: true, stroke: 0.6pt)
      circle((6.20, -0.80), radius: 0.07, fill: blue, stroke: none)
      line((6.20, -0.80), (6.65, -1.12), mark: (end: ">"), stroke: 0.8pt)
      content((5.98, -0.82), text(size: 7pt)[$B$], anchor: "east")
      content((6.32, -0.52), text(size: 7pt)[$r_1$], anchor: "east")
      content((6.42, -0.75), text(size: 7pt)[$d A_1$], anchor: "west")
      content((6.68, -1.22), text(size: 7pt)[$d F_1$], anchor: "north")

      // Secondo elemento dA2 (verde) nel quarto quadrante
      line((6.8, 0), (7.65, -0.25), stroke: 0.6pt)
      line((7.55, -0.15), (7.75, -0.21), (7.69, -0.41), (7.49, -0.35), close: true, stroke: 0.6pt)
      circle((7.62, -0.28), radius: 0.07, fill: rgb("#1b8a3d"), stroke: none)
      line((7.62, -0.28), (7.78, 0.28), mark: (end: ">"), stroke: 0.8pt)
      content((7.25, -0.05), text(size: 7pt)[$r_2$], anchor: "south")
      content((7.65, -0.50), text(size: 7pt)[$d A_2$], anchor: "north")
      content((7.65, 0.42), text(size: 7pt)[$d F_2$], anchor: "south")
    })
  ]
)
#v(1em)

Imponendo l'equilibrio alla rotazione intorno all'asse longitudinale $x$ del tronco di trave, la somma dei momenti statici elementari generati dalle forze tangenziali interne deve eguagliare il momento torcente esterno $M_t$:

$ M_t = tau_1 d A_1 r_1 + tau_2 d A_2 r_2 + dots = sum_(i = 1)^n tau_i d A_i r_i = integral_A tau r d A $

Sostituendo la distribuzione elastica lineare $tau = G (theta / l) r$ all'interno dell'integrale d'area e portando fuori i termini costanti rispetto alla geometria della sezione, si ricava l'equazione di equivalenza per la torsione:

$ M_t = integral_A tau r d A = integral_A G theta / l r dot r d A = G theta / l integral_A r^2 d A = G theta / l I_P $

dove $I_P = integral_A r^2 d A$ è il momento d'inerzia polare della sezione trasversale.

=== Rigidezza torsionale, distribuzione tensionale e modulo di resistenza

Dall'equazione di equivalenza si esplicitano direttamente il momento torcente e l'angolo di rotazione torsionale:

$ M_t = G I_P theta / l quad <=> quad theta = (M_t l) / (G I_P) $

#nota[
  Il termine $(G I_P) / l$ prende il nome di *rigidezza torsionale* della trave. Considerando un tronco di trave di lunghezza unitaria ($l = 1$), si definisce *angolo unitario di torsione* $theta_u$ il rapporto:
  $ theta_u = theta / l = M_t / (G I_P) $
]

Sostituendo l'espressione dell'angolo unitario di torsione $theta / l = M_t / (G I_P)$ all'interno della legge di Hooke $tau = G (theta / l) r$, si ottiene la formula fondamentale per il calcolo della tensione tangenziale di torsione:

$ tau = M_t / I_P r $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    La tensione tangenziale di torsione presenta quindi una distribuzione lineare lungo il raggio della sezione trasversale circolare: è nulla in corrispondenza del baricentro ($r = 0$) e raggiunge il valore massimo sul contorno esterno, per $r = D / 2$ (con $D$ diametro esterno della sezione):

    $ tau_"max" = (M_t D) / (2 I_P) $

    Definendo il *modulo di resistenza torsionale* $W_t$ come:

    $ W_t = I_P / (D / 2) = (2 I_P) / D $

    la tensione tangenziale massima di torsione assume la forma compatta:

    $ tau_"max" = M_t / (I_P / (D / 2)) = M_t / W_t $
  ],
  [
    #canvas(length: 1cm, {
      import draw: *
      // Cerchio sezione (centro (0,0), R = 1.6)
      circle((0, 0), radius: 1.6, stroke: 1.4pt)

      // Assi z (sinistra) e y (alto)
      line((2.0, 0), (-2.2, 0), mark: (end: ">"), stroke: 0.7pt)
      content((-2.1, -0.25), text(size: 7pt)[$z$], anchor: "north")
      line((0, -2.0), (0, 2.2), mark: (end: ">"), stroke: 0.7pt)
      content((0.2, 2.1), text(size: 7pt)[$y$], anchor: "west")

      // 4 triangoli di distribuzione farfalla (quota massima h = 0.85)
      // 1. Asse +y (da (0,0) a (0, 1.6), estensione a sinistra x = -0.85)
      line((0, 0), (0, 1.6), (-0.85, 1.6), close: true, stroke: 0.7pt)
      line((-0.11, 0.2), (0, 0.2), stroke: 0.5pt)
      line((-0.21, 0.4), (0, 0.4), stroke: 0.5pt)
      line((-0.32, 0.6), (0, 0.6), stroke: 0.5pt)
      line((-0.43, 0.8), (0, 0.8), stroke: 0.5pt)
      line((-0.53, 1.0), (0, 1.0), stroke: 0.5pt)
      line((-0.64, 1.2), (0, 1.2), stroke: 0.5pt)
      line((-0.74, 1.4), (0, 1.4), stroke: 0.5pt)

      // 2. Asse -y (da (0,0) a (0, -1.6), estensione a destra x = +0.85)
      line((0, 0), (0, -1.6), (0.85, -1.6), close: true, stroke: 0.7pt)
      line((0, -0.2), (0.11, -0.2), stroke: 0.5pt)
      line((0, -0.4), (0.21, -0.4), stroke: 0.5pt)
      line((0, -0.6), (0.32, -0.6), stroke: 0.5pt)
      line((0, -0.8), (0.43, -0.8), stroke: 0.5pt)
      line((0, -1.0), (0.53, -1.0), stroke: 0.5pt)
      line((0, -1.2), (0.64, -1.2), stroke: 0.5pt)
      line((0, -1.4), (0.74, -1.4), stroke: 0.5pt)

      // 3. Asse +z (sinistra, x = -1.6, estensione in basso y = -0.85)
      line((0, 0), (-1.6, 0), (-1.6, -0.85), close: true, stroke: 0.7pt)
      line((-1.6, -0.15), (-0.28, -0.15), stroke: 0.5pt)
      line((-1.6, -0.30), (-0.56, -0.30), stroke: 0.5pt)
      line((-1.6, -0.45), (-0.85, -0.45), stroke: 0.5pt)
      line((-1.6, -0.60), (-1.13, -0.60), stroke: 0.5pt)
      line((-1.6, -0.75), (-1.41, -0.75), stroke: 0.5pt)

      // 4. Asse -z (destra, x = +1.6, estensione in alto y = +0.85)
      line((0, 0), (1.6, 0), (1.6, 0.85), close: true, stroke: 0.7pt)
      line((0.28, 0.15), (1.6, 0.15), stroke: 0.5pt)
      line((0.56, 0.30), (1.6, 0.30), stroke: 0.5pt)
      line((0.85, 0.45), (1.6, 0.45), stroke: 0.5pt)
      line((1.13, 0.60), (1.6, 0.60), stroke: 0.5pt)
      line((1.41, 0.75), (1.6, 0.75), stroke: 0.5pt)

      // Etichette tau_max
      content((-0.45, 1.7), text(size: 7pt)[$tau_"max"$], anchor: "south")
      content((0.45, -1.75), text(size: 7pt)[$tau_"max"$], anchor: "north")
    })
  ]
)
#v(1em)

Si riportano le espressioni esplicite del modulo di resistenza a torsione $W_t$ per i due casi di interesse applicativo:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    - *Sezione circolare piena* di diametro $D$:
      $ W_t = I_P / (D / 2) = ((pi D^4) / 32) / (D / 2) = (pi D^3) / 16 $

    - *Sezione circolare cava* (anulare) di diametro esterno $D$ e diametro interno $d$:
      $ W_t = I_P / (D / 2) = (pi (D^4 - d^4) / 32) / (D / 2) = (pi (D^4 - d^4)) / (16 D) $
      Introducendo il rapporto tra i diametri $m = d / D$, la relazione si può riscrivere come:
      $ W_t = (pi D^3) / 16 (1 - m^4) $
  ],
  [
    #canvas(length: 0.78cm, {
      import draw: *
      // --- PANNELLO 1: Sezione piena (centro (0,0), R = 1.15) ---
      circle((0, 0), radius: 1.15, fill: luma(230), stroke: 1pt)
      line((-1.4, 0), (1.4, 0), stroke: (dash: "dash-dotted", thickness: 0.5pt))
      line((0, -1.4), (0, 1.4), stroke: (dash: "dash-dotted", thickness: 0.5pt))

      // Quota D
      line((-1.15, 0), (-1.15, -1.85), stroke: 0.5pt)
      line((1.15, 0), (1.15, -1.85), stroke: 0.5pt)
      line((-1.15, -1.7), (1.15, -1.7), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((0, -1.65), text(size: 7pt)[$D$], anchor: "south")

      // Diagramma a farfalla sezione piena (x = 2.0)
      line((2.0, -1.15), (2.0, 1.15), stroke: 0.7pt)
      line((2.0, 0), (1.25, 1.15), (2.0, 1.15), close: true, fill: luma(235), stroke: 0.7pt)
      line((2.0, 0), (2.75, -1.15), (2.0, -1.15), close: true, fill: luma(235), stroke: 0.7pt)
      line((1.45, 0.85), (2.0, 0.85), stroke: 0.4pt)
      line((1.65, 0.55), (2.0, 0.55), stroke: 0.4pt)
      line((1.84, 0.25), (2.0, 0.25), stroke: 0.4pt)
      line((2.0, -0.25), (2.16, -0.25), stroke: 0.4pt)
      line((2.0, -0.55), (2.35, -0.55), stroke: 0.4pt)
      line((2.0, -0.85), (2.55, -0.85), stroke: 0.4pt)
      content((2.45, -1.25), text(size: 7pt)[$tau_"max"$], anchor: "north")

      // --- PANNELLO 2: Sezione cava (centro (4.6,0), R = 1.15, r = 0.62) ---
      circle((4.6, 0), radius: 1.15, fill: luma(230), stroke: 1pt)
      circle((4.6, 0), radius: 0.62, fill: white, stroke: 1pt)
      line((3.2, 0), (6.0, 0), stroke: (dash: "dash-dotted", thickness: 0.5pt))
      line((4.6, -1.4), (4.6, 1.4), stroke: (dash: "dash-dotted", thickness: 0.5pt))

      // Quote d e D
      line((3.98, 0), (3.98, -1.55), stroke: 0.5pt)
      line((5.22, 0), (5.22, -1.55), stroke: 0.5pt)
      line((3.98, -1.42), (5.22, -1.42), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((4.6, -1.38), text(size: 7pt)[$d$], anchor: "south")

      line((3.45, 0), (3.45, -2.05), stroke: 0.5pt)
      line((5.75, 0), (5.75, -2.05), stroke: 0.5pt)
      line((3.45, -1.9), (5.75, -1.9), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((4.6, -1.85), text(size: 7pt)[$D$], anchor: "south")

      // Proiezioni verso diagramma cavo (x = 6.6)
      line((4.6, 1.15), (6.6, 1.15), stroke: 0.4pt)
      line((4.6, 0.62), (6.6, 0.62), stroke: 0.4pt)

      // Diagramma trapezio sezione cava
      line((6.6, -1.15), (6.6, 1.15), stroke: (dash: "dashed", thickness: 0.6pt))
      line((5.85, 1.15), (7.35, -1.15), stroke: (dash: "dashed", thickness: 0.6pt))
      line((6.20, 0.62), (5.85, 1.15), (6.6, 1.15), (6.6, 0.62), close: true, fill: luma(235), stroke: 0.7pt)
      line((6.6, -0.62), (7.00, -0.62), (7.35, -1.15), (6.6, -1.15), close: true, fill: luma(235), stroke: 0.7pt)
      line((6.02, 0.88), (6.6, 0.88), stroke: 0.4pt)
      line((6.6, -0.88), (7.18, -0.88), stroke: 0.4pt)
    })
  ]
)
#v(1em)

== Torsione in travi a sezione rettangolare

Nel caso generale di travi aventi sezione trasversale non circolare, l'ipotesi cinematica di conservazione delle sezioni piane a seguito dell'applicazione del momento torcente cessa di essere valida.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Le sezioni trasversali della trave subiscono un *ingobbamento* (deformazione fuori dal proprio piano) e la distribuzione della tensione tangenziale di torsione sulla generica sezione non può essere dedotta mediante il procedimento elementare adottato per le travi a sezione circolare.

    Per determinare lo stato tensionale si ricorre pertanto a metodi indiretti, sfruttando le analogie matematiche che il problema della torsione alla Saint-Venant presenta con altri problemi fisici già risolti; in particolare si fa uso dell'*analogia idrodinamica*.
  ],
  [
    #canvas(length: 1cm, {
      import draw: *
      // Vista laterale trave a sezione rettangolare ingobbata e ruotata
      // Faccia principale anteriore (griglia distorta)
      line((0.1, 1.25), (5.8, 0.75), stroke: 0.9pt)
      line((0.0, -0.85), (5.7, -1.35), stroke: 0.9pt)
      line((0.1, 1.25), (0.0, -0.85), stroke: 0.9pt)
      line((5.8, 0.75), (5.7, -1.35), stroke: 0.9pt)

      // Linee longitudinali della griglia anteriore
      line((0.08, 0.83), (5.78, 0.33), stroke: 0.5pt)
      line((0.06, 0.41), (5.76, -0.09), stroke: 0.5pt)
      line((0.04, -0.01), (5.74, -0.51), stroke: 0.5pt)
      line((0.02, -0.43), (5.72, -0.93), stroke: 0.5pt)

      // Linee trasversali ingobbate (leggermente inclinate)
      line((0.67, 1.20), (0.57, -0.90), stroke: 0.5pt)
      line((1.24, 1.15), (1.14, -0.95), stroke: 0.5pt)
      line((1.81, 1.10), (1.71, -1.00), stroke: 0.5pt)
      line((2.38, 1.05), (2.28, -1.05), stroke: 0.5pt)
      line((2.95, 1.00), (2.85, -1.10), stroke: 0.5pt)
      line((3.52, 0.95), (3.42, -1.15), stroke: 0.5pt)
      line((4.09, 0.90), (3.99, -1.20), stroke: 0.5pt)
      line((4.66, 0.85), (4.56, -1.25), stroke: 0.5pt)
      line((5.23, 0.80), (5.13, -1.30), stroke: 0.5pt)

      // Lembo superiore destro visibile per torsione (da x = 2.95 a 5.8)
      line((2.95, 1.00), (5.85, 1.15), stroke: 0.8pt)
      line((5.85, 1.15), (5.8, 0.75), stroke: 0.8pt)
      line((3.52, 0.95), (5.83, 1.05), stroke: 0.4pt)
      line((4.09, 0.90), (5.82, 0.95), stroke: 0.4pt)
      line((4.66, 0.85), (5.81, 0.85), stroke: 0.4pt)

      // Lembo inferiore sinistro visibile per torsione (da x = 0 a 2.85)
      line((0.0, -0.85), (0.05, -1.25), stroke: 0.8pt)
      line((0.05, -1.25), (2.85, -1.10), stroke: 0.8pt)
      line((0.02, -0.98), (2.28, -1.05), stroke: 0.4pt)
      line((0.04, -1.12), (1.71, -1.00), stroke: 0.4pt)
    })
  ]
)
#v(1em)

=== Analogia idrodinamica e distribuzione delle tensioni tangenziali

Immaginiamo un recipiente a fondo orizzontale avente contorno rettangolare identico alla sezione trasversale della trave di lati $a$ (lato lungo) e $b$ (lato corto) soggetta a torsione, all'interno del quale sia posto un liquido in rotazione.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    L'analogia idrodinamica stabilisce che:
    - tra la velocità $v$ del liquido in un generico punto del recipiente e la tensione tangenziale di torsione $tau$ nel corrispondente punto della sezione della trave sussiste una relazione di proporzionalità diretta;
    - l'andamento delle linee di flusso della velocità del liquido ricalca esattamente la direzione delle tensioni tangenziali $tau$ sulla sezione.

    Poiché la velocità del fluido si annulla nei quattro vertici del recipiente ed è massima nei punti medi dei lati lunghi, in modo del tutto analogo la tensione tangenziale $tau$ è nulla negli spigoli della sezione rettangolare e raggiunge il valore massimo nei punti medi $A$ dei lati lunghi di dimensione $a$ ($tau_A = tau_"max" > tau_B$, dove $B$ indica i punti medi dei lati corti $b$).
  ],
  [
    #canvas(length: 0.82cm, {
      import draw: *
      // --- PANNELLO SINISTRO: Recipiente con fluido in rotazione ---
      rect((0, -1.6), (2.1, 1.6), stroke: 1.2pt)
      line((0, 1.6), (-0.45, 2.05), stroke: 0.4pt)
      line((2.1, 1.6), (1.65, 2.05), stroke: 0.4pt)
      line((0, -1.6), (-0.45, -1.15), stroke: 0.4pt)

      // Linea di flusso chiusa (rettangolo raccordato)
      arc((0.55, 1.0), start: 90deg, stop: 180deg, radius: 0.4, anchor: "origin", stroke: 0.6pt)
      arc((1.55, 1.0), start: 0deg, stop: 90deg, radius: 0.4, anchor: "origin", stroke: 0.6pt)
      arc((1.55, -1.0), start: 270deg, stop: 360deg, radius: 0.4, anchor: "origin", stroke: 0.6pt)
      arc((0.55, -1.0), start: 180deg, stop: 270deg, radius: 0.4, anchor: "origin", stroke: 0.6pt)
      line((0.55, 1.4), (1.55, 1.4), stroke: 0.6pt)
      line((0.55, -1.4), (1.55, -1.4), stroke: 0.6pt)
      line((0.15, -1.0), (0.15, 1.0), stroke: 0.6pt)
      line((1.95, -1.0), (1.95, 1.0), stroke: 0.6pt)

      // Vettore velocita' v
      line((1.82, -0.1), (1.82, 0.65), mark: (end: ">"), stroke: 1pt)
      content((1.72, 0.25), text(size: 7pt)[$v$], anchor: "east")

      // --- PANNELLO DESTRO: Sezione rettangolare con tensioni (x da 3.5 a 5.6) ---
      rect((3.5, -1.6), (5.6, 1.6), stroke: 1.2pt)

      // Assi di simmetria tratteggiati
      line((3.1, 0), (6.4, 0), stroke: (dash: "dash-dotted", thickness: 0.5pt))
      line((4.55, -2.0), (4.55, 2.2), stroke: (dash: "dash-dotted", thickness: 0.5pt))

      // Frecce di flusso tangenziale lungo il perimetro interno
      line((5.45, -1.1), (5.45, -0.4), mark: (end: ">"), stroke: 0.6pt)
      line((5.45, 0.4), (5.45, 1.1), mark: (end: ">"), stroke: 0.6pt)
      line((3.65, 1.1), (3.65, 0.4), mark: (end: ">"), stroke: 0.6pt)
      line((3.65, -0.4), (3.65, -1.1), mark: (end: ">"), stroke: 0.6pt)
      line((5.2, 1.45), (4.7, 1.45), mark: (end: ">"), stroke: 0.6pt)
      line((4.4, 1.45), (3.9, 1.45), mark: (end: ">"), stroke: 0.6pt)
      line((3.9, -1.45), (4.4, -1.45), mark: (end: ">"), stroke: 0.6pt)
      line((4.7, -1.45), (5.2, -1.45), mark: (end: ">"), stroke: 0.6pt)

      // Profili interni non lineari lungo gli assi (curve a S per flesso in (4.55, 0))
      bezier((3.5, -0.55), (4.55, 0), (3.9, -0.15), (4.3, 0), stroke: 0.6pt)
      bezier((4.55, 0), (5.6, 0.55), (4.8, 0), (5.2, 0.15), stroke: 0.6pt)
      bezier((4.25, 1.6), (4.55, 0), (4.45, 1.1), (4.55, 0.4), stroke: 0.6pt)
      bezier((4.55, 0), (4.85, -1.6), (4.55, -0.4), (4.65, -1.1), stroke: 0.6pt)

      // Diagramma esterno sul lato lungo destro (tau_A = tau_max)
      arc((4.55, 0), start: -52deg, stop: 52deg, radius: (1.65, 2.03), anchor: "origin", stroke: 0.7pt)
      line((5.6, 1.2), (5.92, 1.2), stroke: 0.4pt)
      line((5.6, 0.8), (6.08, 0.8), stroke: 0.4pt)
      line((5.6, 0.4), (6.17, 0.4), stroke: 0.4pt)
      line((5.6, 0.0), (6.20, 0.0), stroke: 0.4pt)
      line((5.6, -0.4), (6.17, -0.4), stroke: 0.4pt)
      line((5.6, -0.8), (6.08, -0.8), stroke: 0.4pt)
      line((5.6, -1.2), (5.92, -1.2), stroke: 0.4pt)

      // Diagramma esterno sul lato corto superiore (tau_B)
      arc((4.55, 0.9), start: 33deg, stop: 147deg, radius: (1.25, 1.28), anchor: "origin", stroke: 0.7pt)
      line((3.9, 1.6), (3.9, 1.98), stroke: 0.4pt)
      line((4.2, 1.6), (4.2, 2.12), stroke: 0.4pt)
      line((4.55, 1.6), (4.55, 2.18), stroke: 0.4pt)
      line((4.9, 1.6), (4.9, 2.12), stroke: 0.4pt)
      line((5.2, 1.6), (5.2, 1.98), stroke: 0.4pt)

      // Punti notevoli A e B
      circle((3.5, 0), radius: 0.07, fill: white, stroke: 0.8pt)
      circle((5.6, 0), radius: 0.07, fill: white, stroke: 0.8pt)
      circle((4.55, 1.6), radius: 0.07, fill: white, stroke: 0.8pt)
      circle((4.55, -1.6), radius: 0.07, fill: white, stroke: 0.8pt)

      content((3.7, 0.2), text(size: 7pt)[$A$], anchor: "west")
      content((5.35, -0.25), text(size: 7pt)[$A$], anchor: "east")
      content((4.65, 1.25), text(size: 7pt)[$B$], anchor: "west")
      content((4.65, -1.85), text(size: 7pt)[$B$], anchor: "west")

      // Etichette tau_A e tau_B
      line((5.85, 0), (6.35, 0.2), stroke: 0.5pt)
      content((6.4, 0.25), text(size: 7pt)[$tau_A = tau_"max"$], anchor: "west")
      line((4.55, 1.9), (5.25, 2.3), stroke: 0.5pt)
      content((5.3, 2.35), text(size: 7pt)[$tau_B$], anchor: "west")

      // Quote a e b
      line((3.5, 1.6), (2.8, 1.6), stroke: 0.5pt)
      line((3.5, -1.6), (2.8, -1.6), stroke: 0.5pt)
      line((2.95, -1.6), (2.95, 1.6), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((2.85, 0), text(size: 7pt)[$a$], anchor: "east")

      line((3.5, -1.6), (3.5, -2.35), stroke: 0.5pt)
      line((5.6, -1.6), (5.6, -2.35), stroke: 0.5pt)
      line((3.5, -2.2), (5.6, -2.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((4.55, -2.25), text(size: 7pt)[$b$], anchor: "north")
    })
  ]
)
#v(1em)

=== Calcolo della tensione massima e fattore di rigidezza torsionale

Il valore massimo della tensione tangenziale di torsione si manifesta nei punti $A$ (punti medi dei lati lunghi di dimensione $a$) ed è espresso dalla relazione:

$ tau_"max" = tau_A = (alpha M_t) / (a b^2) = M_t / W_t $

dove il modulo di resistenza a torsione della sezione rettangolare vale $W_t = (a b^2) / alpha$. Il coefficiente adimensionale $alpha$ dipende esclusivamente dal rapporto geometrico $a / b$ tra il lato lungo e il lato corto della sezione e si ricava sperimentalmente o analiticamente mediante la seguente tabella:

#align(center)[
  #table(
    columns: 7,
    align: center + horizon,
    table.header([$a / b$], [$1$], [$1.5$], [$2$], [$3$], [$10$], [$infinity$]),
    table.hline(),
    [$alpha$], [$4.80$], [$4.33$], [$4.06$], [$3.74$], [$3.20$], [$3$],
  )
]

Per caratterizzare la deformabilità torsionale delle sezioni non circolari si introduce il *fattore di rigidezza torsionale* $I_t$ (che sostituisce il momento d'inerzia polare $I_P$ delle sezioni circolari), definito per la sezione rettangolare in funzione dei lati $a, b$ come:

$ I_t = (a b^3) / alpha $

In funzione del fattore di rigidezza torsionale $I_t$, la tensione tangenziale massima e l'angolo unitario di torsione $theta_u$ si riscrivono nella forma generale:

$ tau_"max" = M_t / W_t = M_t / I_t b, quad theta_u = M_t / (G I_t) $


// === Blocco_02_Slide_16-30 ===

== Torsione in travi a sezione aperta sottile

I risultati ricavati per le travi a sezione rettangolare, ipotizzando che il rettangolo diventi molto allungato e sottile ($a gt.double b$), consentono di studiare il comportamento torsionale delle sezioni sottili aperte tipiche dei profilati strutturali a $C$, $T$, $Z$, $I$, $H$ ed $L$.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Nel caso di sezioni in parete sottile aperta, le linee di flusso delle tensioni tangenziali $tau$ di torsione non possono chiudersi attorno a una cavità interna, ma sono costrette a percorrere in andata e ritorno i lati lunghi di ciascun singolo tratto rettangolare elementare che compone la sezione stessa.
  ],
  [
    #canvas(length: 0.78cm, {
      import draw: *
      // Griglia 3x2 di profilati aperti sottili (C, T, Z in alto; I, H, L in basso)
      // 1. Profilo a C (x: 0..1.2, y: 1.5..3.1)
      line((0, 1.5), (1.1, 1.5), (1.1, 1.72), (0.22, 1.72), (0.22, 2.88), (1.1, 2.88), (1.1, 3.1), (0, 3.1), close: true, fill: luma(210), stroke: 0.8pt)
      content((0.55, 1.15), text(size: 7pt)[Profilo a C])

      // 2. Profilo a T rovesciata (x: 2.3..3.7, y: 1.5..3.1)
      line((2.3, 1.5), (3.7, 1.5), (3.7, 1.72), (3.11, 1.72), (3.11, 3.1), (2.89, 3.1), (2.89, 1.72), (2.3, 1.72), close: true, fill: luma(210), stroke: 0.8pt)
      content((3.0, 1.15), text(size: 7pt)[Profilo a T])

      // 3. Profilo a Z (x: 4.8..6.2, y: 1.5..3.1)
      line((4.8, 2.88), (5.4, 2.88), (5.4, 1.5), (6.2, 1.5), (6.2, 1.72), (5.62, 1.72), (5.62, 3.1), (4.8, 3.1), close: true, fill: luma(210), stroke: 0.8pt)
      content((5.5, 1.15), text(size: 7pt)[Profilo a Z])

      // 4. Profilo a I (x: 0..1.1, y: -1.1..0.5)
      line((0.05, -1.1), (1.05, -1.1), (1.05, -0.88), (0.66, -0.88), (0.66, 0.28), (1.05, 0.28), (1.05, 0.5), (0.05, 0.5), (0.05, 0.28), (0.44, 0.28), (0.44, -0.88), (0.05, -0.88), close: true, fill: luma(210), stroke: 0.8pt)
      content((0.55, -1.45), text(size: 7pt)[Profilo a I])

      // 5. Profilo ad H / ali larghe (x: 2.3..3.7, y: -1.1..0.5)
      line((2.3, -1.1), (3.7, -1.1), (3.7, -0.88), (3.11, -0.88), (3.11, 0.28), (3.7, 0.28), (3.7, 0.5), (2.3, 0.5), (2.3, 0.28), (2.89, 0.28), (2.89, -0.88), (2.3, -0.88), close: true, fill: luma(210), stroke: 0.8pt)
      content((3.0, -1.45), text(size: 7pt)[Profilo ad H])

      // 6. Profilo ad L (x: 4.9..6.1, y: -1.1..0.5)
      line((4.9, -1.1), (6.1, -1.1), (6.1, -0.88), (5.12, -0.88), (5.12, 0.5), (4.9, 0.5), close: true, fill: luma(210), stroke: 0.8pt)
      content((5.5, -1.45), text(size: 7pt)[Profilo ad L])
    })
  ]
)
#v(1em)

=== Scomposizione in tratti rettilinei, rigidezza e tensione massima

Suddividendo la sezione aperta sottile in $n$ tratti rettilinei elementari (ciascuno assimilabile a un rettangolo allungato di lunghezza $a_i$ e spessore $b_i$), per il generico tratto $i$-esimo valgono le relazioni della sezione rettangolare:

$ tau_("max", i) = M_(t, i) / I_(t, i) b_i, quad theta_(u, i) = M_(t, i) / (G I_(t, i)) $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Per garantire la congruenza cinematica e la continuità strutturale della sezione, l'intera sezione trasversale deve ruotare della medesima quantità di cui ruotano i singoli elementi che la compongono. Gli angoli unitari di torsione dei singoli tratti $theta_(u, i)$ devono quindi eguagliare l'angolo unitario di torsione complessivo $theta_u$ dell'intera sezione:

    $ theta_(u, i) = M_(t, i) / (G I_(t, i)) = theta_u = M_t / (G I_t) => M_(t, i) = I_(t, i) / I_t M_t = I_(t, i) / (sum_(i = 1)^n I_(t, i)) M_t $
  ],
  [
    #canvas(length: 0.85cm, {
      import draw: *
      // Profilo aperto a 3 tratti (orizzontale inferiore a3x b3, verticale centrale a2 x b2, inclinato superiore a1 x b1)
      line((0, 0), (3.4, 0), (3.4, 2.2), (5.9, 2.95), (5.65, 3.65), (2.95, 2.84), (2.95, 0.18), (0, 0.18), close: true, fill: luma(240), stroke: 1pt)

      // Quota a3
      line((0, -0.25), (3.3, -0.25), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((1.65, -0.35), text(size: 7pt)[$a_3$], anchor: "north")

      // Etichetta b3
      content((-0.15, 0.09), text(size: 7pt)[$b_3$], anchor: "east")

      // Quota a2
      line((2.55, 0.22), (2.55, 2.55), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((2.45, 1.4), text(size: 7pt)[$a_2$], anchor: "east")

      // Quota b2
      line((2.95, 1.05), (3.4, 1.05), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((3.17, 0.95), text(size: 7pt)[$b_2$], anchor: "north")

      // Quota a1 (parallela al tratto inclinato)
      line((3.5, 1.95), (6.0, 2.70), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((4.85, 2.15), text(size: 7pt)[$a_1$], anchor: "north")

      // Quota b1 (perpendicolare al tratto inclinato)
      line((4.45, 3.29), (4.70, 2.59), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((4.68, 2.98), text(size: 7pt)[$b_1$], anchor: "west")
    })
  ]
)
#v(1em)

Sostituendo l'espressione del momento torcente parziale $M_(t, i)$ nella relazione della tensione tangenziale massima del singolo tratto $i$-esimo, si ottiene:

$ tau_("max", i) = M_(t, i) / I_(t, i) b_i = M_t / I_t b_i = M_t / (sum_(i = 1)^n I_(t, i)) b_i $

#nota[
  Dalla relazione $tau_("max", i) = (M_t / I_t) b_i$ si deduce che, in una trave a sezione aperta sottile, la massima tensione tangenziale di torsione assoluta si localizza sempre nel tratto caratterizzato dallo spessore $b_i$ maggiore.
]

Il fattore di rigidezza torsionale complessivo $I_t$ della sezione aperta sottile è dato dalla somma dei fattori di rigidezza torsionale $I_(t, i)$ dei singoli tratti rettilinei:

$ I_t = sum_(i = 1)^n I_(t, i) = sum_(i = 1)^n (a_i b_i^3) / alpha_i $

Poiché per una parete sottile la lunghezza di ciascun tratto è molto maggiore del relativo spessore ($a_i gt.double b_i$), dalla tabella dei coefficienti per la sezione rettangolare si assume il valore limite $alpha_i = 3$, ottenendo:

$ I_t = 1 / 3 sum_(i = 1)^n a_i b_i^3 $

dove $a_i$ indica la lunghezza della linea media dell'$i$-esimo tratto rettilineo della sezione e $b_i$ il corrispondente spessore.

== Torsione in travi a sezione chiusa sottile

Le travi dotate di sezione trasversale chiusa (cava) in parete sottile — ovvero caratterizzata da uno spessore $s$, costante o variabile lungo il perimetro, piccolo rispetto alle dimensioni globali della sezione — si prestano a una trattazione analitica agevole (teoria di Bredt), indipendentemente dalla forma geometrica del contorno.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    In virtù dell'ipotesi di piccolo spessore, è lecito trascurare la variazione della tensione lungo lo spessore della parete, assumendo la tensione tangenziale $tau$ uniforme nello spessore $s$ e pari al valore medio $tau_m$ valutato in corrispondenza della linea mediana (tratteggiata) compresa tra il bordo interno e il bordo esterno della parete:

    $ tau = tau_m $

    Consideriamo una porzione di parete di lunghezza infinitesima $d l$ lungo la linea mediana: su tale elemento di area $d A = s d l$ agisce la forza tangenziale infinitesima:

    $ d F = tau d A = tau s d l $
  ],
  [
    #canvas(length: 0.82cm, {
      import draw: *
      // --- PANNELLO SINISTRO: Sezione chiusa generica ---
      // Contorno esterno
      bezier((-2.2, 0), (0, 1.55), (-2.2, 1.1), (-1.1, 1.55), stroke: 1.2pt)
      bezier((0, 1.55), (2.2, 0), (1.1, 1.55), (2.2, 1.1), stroke: 1.2pt)
      bezier((2.2, 0), (0, -1.55), (2.2, -1.1), (1.1, -1.55), stroke: 1.2pt)
      bezier((0, -1.55), (-2.2, 0), (-1.1, -1.55), (-2.2, -1.1), stroke: 1.2pt)

      // Linea mediana tratteggiata
      bezier((-2.02, 0), (0, 1.38), (-2.02, 0.98), (-0.98, 1.38), stroke: (dash: "dashed", thickness: 0.6pt))
      bezier((0, 1.38), (2.02, 0), (0.98, 1.38), (2.02, 0.98), stroke: (dash: "dashed", thickness: 0.6pt))
      bezier((2.02, 0), (0, -1.38), (2.02, -0.98), (0.98, -1.38), stroke: (dash: "dashed", thickness: 0.6pt))
      bezier((0, -1.38), (-2.02, 0), (-0.98, -1.38), (-2.02, -0.98), stroke: (dash: "dashed", thickness: 0.6pt))

      // Contorno interno
      bezier((-1.85, 0), (0, 1.22), (-1.85, 0.85), (-0.85, 1.22), stroke: 1.2pt)
      bezier((0, 1.22), (1.85, 0), (0.85, 1.22), (1.85, 0.85), stroke: 1.2pt)
      bezier((1.85, 0), (0, -1.22), (1.85, -0.85), (0.85, -1.22), stroke: 1.2pt)
      bezier((0, -1.22), (-1.85, 0), (-0.85, -1.22), (-1.85, -0.85), stroke: 1.2pt)

      // Tratteggio obliquo per indicare l'area Omega racchiusa dalla linea mediana
      line((-1.4, -0.8), (0.8, 1.2), stroke: 0.35pt)
      line((-1.7, -0.4), (0.3, 1.3), stroke: 0.35pt)
      line((-1.8, 0.1), (-0.3, 1.3), stroke: 0.35pt)
      line((-0.9, -1.1), (1.3, 0.9), stroke: 0.35pt)
      line((-0.4, -1.3), (1.6, 0.5), stroke: 0.35pt)
      line((0.2, -1.3), (1.8, 0.1), stroke: 0.35pt)

      // Etichetta Omega su sfondo bianco
      rect((-0.3, -0.3), (0.3, 0.3), fill: white, stroke: none)
      content((0, 0), text(size: 7pt)[$Omega$])

      // Quota spessore s a sinistra
      line((-2.65, -0.25), (-2.2, -0.25), mark: (end: ">"), stroke: 0.6pt)
      line((-1.4, -0.25), (-1.85, -0.25), mark: (end: ">"), stroke: 0.6pt)
      content((-2.35, -0.15), text(size: 7pt)[$s$], anchor: "south")

      // Vettore tau = tau_m
      line((-2.02, 0.25), (-2.02, -0.45), mark: (end: ">"), stroke: 0.9pt)
      content((-1.95, 0.55), text(size: 7pt)[$tau = tau_m$], anchor: "east")

      // Elemento dl in alto a destra
      line((0.55, 1.15), (0.72, 1.85), stroke: 0.5pt)
      line((1.05, 1.02), (1.22, 1.72), stroke: 0.5pt)
      line((0.25, 1.80), (0.69, 1.69), mark: (end: ">"), stroke: 0.6pt)
      line((1.62, 1.46), (1.18, 1.57), mark: (end: ">"), stroke: 0.6pt)
      content((0.98, 1.78), text(size: 7pt)[$d l$], anchor: "south")

      // --- PANNELLO DESTRO: Dettaglio settore d Omega (x da 3.2 a 6.4) ---
      // Triangolo grigio d Omega con vertice nel polo/baricentro (6.3, -0.7)
      line((6.3, -0.7), (3.85, 0.45), (3.45, -0.35), close: true, fill: luma(215), stroke: 0.6pt)
      content((4.75, -0.25), text(size: 7pt)[$d Omega$])

      // Elemento di parete di spessore s e lunghezza dl
      line((3.72, 0.52), (3.98, 0.38), (3.58, -0.42), (3.32, -0.28), close: true, stroke: 0.8pt)

      // Retta d'azione tangente alla linea mediana e forza dF
      line((4.35, 1.25), (3.05, -1.35), stroke: 0.5pt)
      line((3.65, 0.05), (3.15, -0.95), mark: (end: ">"), stroke: 1.2pt)
      content((3.35, -0.95), text(size: 7pt)[$d F$], anchor: "west")

      // Braccio delta perpendicolare alla tangente
      line((6.3, -0.7), (4.15, 0.85), stroke: (dash: "dashed", thickness: 0.8pt))
      content((5.25, 0.25), text(size: 7pt)[$delta$], anchor: "south")

      // Quote dl e s sul dettaglio
      line((3.12, -0.18), (3.52, 0.62), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((3.22, 0.32), text(size: 7pt)[$d l$], anchor: "east")

      line((3.55, 0.92), (3.82, 0.48), mark: (end: ">"), stroke: 0.6pt)
      line((4.22, -0.18), (3.92, 0.28), mark: (end: ">"), stroke: 0.6pt)
      content((3.95, 0.72), text(size: 7pt)[$s$], anchor: "south")
    })
  ]
)
#v(1em)

=== Formula di Bredt e angolo unitario di torsione

Per l'ipotesi di piccolo spessore, la forza elementare $d F$ risulta tangente alla linea mediana della parete. Indicando con $delta$ il braccio di tale forza rispetto al baricentro della sezione (ossia la distanza ortogonale tra il baricentro e la retta tangente alla linea mediana nel punto di applicazione di $d F$), il momento torcente elementare $d M_t$ rispetto all'asse longitudinale $x$ della trave vale:

$ d M_t = delta d F = delta tau s d l = 2 tau s d Omega $

avendo osservato geometricamente che il prodotto $delta d l = 2 d Omega$ rappresenta il doppio dell'area $d Omega$ del triangolo infinitesimo avente per base l'arco $d l$ e per altezza il braccio $delta$. Integrando tale contributo lungo l'intera linea mediana chiusa della sezione trasversale e ricordando che il flusso tangenziale $tau s$ deve mantenersi costante per equilibrio longitudinale, si ottiene il momento torcente totale:

$ M_t = integral d M_t = integral_Omega 2 tau s d Omega = 2 tau s Omega $

dove $Omega$ è l'area complessiva racchiusa dalla linea mediana della parete (comprensiva della cavità interna). Esplicitando la tensione tangenziale si giunge alla *prima formula di Bredt*:

$ tau = tau_m = M_t / (2 Omega s) $

#nota[
  L'angolo unitario di torsione $theta_u$ per una trave a sezione chiusa sottile è espresso dalla *seconda formula di Bredt*:
  $ theta_u = M_t / (4 G Omega^2) integral.cont (d l) / s $
  Nel caso frequente in cui la sezione sia costituita da $n$ tratti di lunghezza $l_i$ ciascuno a spessore costante $s_i$, le espressioni della tensione tangenziale nel tratto $i$-esimo e dell'angolo unitario di torsione si particolarizzano in:
  $ tau_i = M_t / (2 Omega s_i), quad theta_u = M_t / (4 G Omega^2) sum_(i = 1)^n l_i / s_i $
]

=== Esempio applicativo: sezione scatolare a spessori differenziati

Si consideri una trave a sezione chiusa sottile di forma rettangolare (scatolare), avente dimensioni esterne $l_1$ e $l_2$ e pareti di spessore costante a tratti $s_1, s_2, s_3, s_4$.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    - *Area $Omega$ racchiusa dalla linea mediana*:
      $ Omega = (l_1 - s_2 / 2 - s_4 / 2) (l_2 - s_1 / 2 - s_3 / 2) $

    - *Tensioni tangenziali di torsione nei quattro tratti*:
      $ tau_1 = M_t / (2 Omega s_1), quad tau_2 = M_t / (2 Omega s_2) $
      $ tau_3 = M_t / (2 Omega s_3), quad tau_4 = M_t / (2 Omega s_4) $

    - *Angolo unitario di torsione*:
      $ theta_u = M_t / (4 G Omega^2) (l_1 / s_1 + l_2 / s_2 + l_1 / s_3 + l_2 / s_4) $
  ],
  [
    #canvas(length: 0.85cm, {
      import draw: *
      // Contorno esterno scatolare (x: -1.8..1.8, y: -1.8..1.8)
      rect((-1.8, -1.8), (1.8, 1.8), stroke: 1.2pt)

      // Linea mediana tratteggiata (x: -1.6..1.6, y: -1.6..1.6)
      rect((-1.6, -1.6), (1.6, 1.6), stroke: (dash: "dashed", thickness: 0.7pt))

      // Contorno interno (x: -1.4..1.4, y: -1.4..1.4)
      rect((-1.4, -1.4), (1.4, 1.4), stroke: 1.2pt)

      // Tratteggio area Omega (entro la linea mediana)
      line((-1.6, -1.0), (1.0, 1.6), stroke: 0.35pt)
      line((-1.6, -0.4), (0.4, 1.6), stroke: 0.35pt)
      line((-1.6, 0.2), (-0.2, 1.6), stroke: 0.35pt)
      line((-1.6, 0.8), (-0.8, 1.6), stroke: 0.35pt)
      line((-1.2, -1.6), (1.6, 1.2), stroke: 0.35pt)
      line((-0.6, -1.6), (1.6, 0.6), stroke: 0.35pt)
      line((0.0, -1.6), (1.6, 0.0), stroke: 0.35pt)
      line((0.6, -1.6), (1.6, -0.6), stroke: 0.35pt)
      line((1.2, -1.6), (1.6, -1.2), stroke: 0.35pt)

      rect((-0.3, -0.3), (0.3, 0.3), fill: white, stroke: none)
      content((0, 0), text(size: 7pt)[$Omega$])

      // Quote esterne l1 e l2
      line((-1.8, -1.8), (-1.8, -2.5), stroke: 0.5pt)
      line((1.8, -1.8), (1.8, -2.5), stroke: 0.5pt)
      line((-1.8, -2.35), (1.8, -2.35), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((0, -2.3), text(size: 7pt)[$l_1$], anchor: "south")

      line((1.8, -1.8), (2.7, -1.8), stroke: 0.5pt)
      line((1.8, 1.8), (2.7, 1.8), stroke: 0.5pt)
      line((2.55, -1.8), (2.55, 1.8), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((2.48, 0), text(size: 7pt)[$l_2$], anchor: "east")

      // Quote spessori s1, s2, s3, s4
      // s1 (in basso)
      line((0.2, -2.15), (0.2, -1.8), mark: (end: ">"), stroke: 0.5pt)
      line((0.2, -1.05), (0.2, -1.4), mark: (end: ">"), stroke: 0.5pt)
      content((0.1, -2.0), text(size: 7pt)[$s_1$], anchor: "east")

      // s2 (a destra)
      line((2.15, 0.4), (1.8, 0.4), mark: (end: ">"), stroke: 0.5pt)
      line((1.05, 0.4), (1.4, 0.4), mark: (end: ">"), stroke: 0.5pt)
      content((2.1, 0.5), text(size: 7pt)[$s_2$], anchor: "south")

      // s3 (in alto)
      line((0.2, 2.15), (0.2, 1.8), mark: (end: ">"), stroke: 0.5pt)
      line((0.2, 1.05), (0.2, 1.4), mark: (end: ">"), stroke: 0.5pt)
      content((0.1, 2.0), text(size: 7pt)[$s_3$], anchor: "east")

      // s4 (a sinistra)
      line((-2.15, -0.2), (-1.8, -0.2), mark: (end: ">"), stroke: 0.5pt)
      line((-1.05, -0.2), (-1.4, -0.2), mark: (end: ">"), stroke: 0.5pt)
      content((-2.1, -0.1), text(size: 7pt)[$s_4$], anchor: "south")

      // Numeri cerchiati 1, 2, 3, 4
      circle((1.15, -2.05), radius: 0.22, stroke: 0.5pt)
      content((1.15, -2.05), text(size: 7pt)[1])
      line((1.05, -1.85), (0.9, -1.5), stroke: 0.5pt)

      circle((2.15, -0.9), radius: 0.22, stroke: 0.5pt)
      content((2.15, -0.9), text(size: 7pt)[2])
      line((1.95, -0.8), (1.6, -0.65), stroke: 0.5pt)

      circle((1.35, 2.15), radius: 0.22, stroke: 0.5pt)
      content((1.35, 2.15), text(size: 7pt)[3])
      line((1.28, 1.94), (1.15, 1.6), stroke: 0.5pt)

      circle((-2.2, -0.95), radius: 0.22, stroke: 0.5pt)
      content((-2.2, -0.95), text(size: 7pt)[4])
      line((-1.99, -0.88), (-1.6, -0.7), stroke: 0.5pt)
    })
  ]
)
#v(1em)

= Sollecitazioni semplici: Taglio

== Caratteristiche generali del taglio nelle travi

Dalla relazione differenziale di equilibrio delle travi rettilinee $T(x) = (d M(x)) / (d x)$ discende che la presenza di uno sforzo di taglio $T$ si accompagna quasi sempre a una variazione del momento flettente $M(x)$ lungo l'asse della trave.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Si realizza pertanto una condizione ideale di *taglio puro* esclusivamente nelle singole sezioni trasversali (come la sezione $S^+$ nello schema) in cui il diagramma del momento flettente $M(x)$ si annulla o passa per lo zero.

    Inoltre, affinché sulla sezione si manifesti esclusivamente taglio senza torsione secondaria, la retta d'azione della forza di taglio $T$ deve necessariamente passare per un punto caratteristico denominato *centro di taglio* (o centro di taglio-torsione), il quale non sempre coincide con il baricentro geometrico $G$ della sezione; in caso contrario nasce anche un momento torcente aggiuntivo.
  ],
  [
    #canvas(length: 0.8cm, {
      import draw: *
      // --- PANNELLO SINISTRO: Diagrammi M(x) e Ty ---
      // Diagramma M(x) in alto (y_base = 1.0)
      line((0, 1.0), (1.8, 1.0), stroke: 1.8pt)
      line((1.8, 1.0), (3.4, 1.0), mark: (end: ">"), stroke: 0.6pt)
      content((3.4, 0.85), text(size: 7pt)[$x$], anchor: "north")

      // Parte negativa a sinistra di S+ (x = 1.8)
      line((0, 1.0), (0, 2.2), (1.8, 1.0), close: true, stroke: 0.7pt)
      line((0.36, 1.0), (0.36, 1.96), stroke: 0.4pt)
      line((0.72, 1.0), (0.72, 1.72), stroke: 0.4pt)
      line((1.08, 1.0), (1.08, 1.48), stroke: 0.4pt)
      line((1.44, 1.0), (1.44, 1.24), stroke: 0.4pt)
      circle((0.45, 1.4), radius: 0.2, fill: white, stroke: 0.6pt)
      content((0.45, 1.4), text(size: 7pt)[$-$])

      // Parte positiva sfumata a destra di S+
      line((1.8, 1.0), (2.9, 0.25), (2.9, 1.0), close: true, stroke: (paint: luma(170), thickness: 0.6pt))
      circle((2.65, 0.65), radius: 0.2, fill: white, stroke: (paint: luma(170), thickness: 0.6pt))
      content((2.65, 0.65), text(size: 7pt, fill: luma(150))[$+$])
      content((-0.15, 1.6), text(size: 7pt)[$M(x)$], anchor: "east")

      // Diagramma Ty in basso (y_base = -0.9)
      line((0, -0.9), (1.8, -0.9), stroke: 1.4pt)
      line((1.8, -0.9), (2.9, -0.9), stroke: (paint: luma(170), thickness: 1.2pt))
      rect((0, -0.9), (1.8, -0.1), stroke: 0.7pt)
      rect((1.8, -0.9), (2.9, -0.1), stroke: (paint: luma(170), thickness: 0.6pt))
      line((0.36, -0.9), (0.36, -0.1), stroke: 0.4pt)
      line((0.72, -0.9), (0.72, -0.1), stroke: 0.4pt)
      line((1.08, -0.9), (1.08, -0.1), stroke: 0.4pt)
      line((1.44, -0.9), (1.44, -0.1), stroke: 0.4pt)
      circle((1.45, -0.5), radius: 0.2, fill: white, stroke: 0.6pt)
      content((1.45, -0.5), text(size: 7pt)[$+$])
      content((-0.15, -0.5), text(size: 7pt)[$T_y$], anchor: "east")

      // Linea di sezione S+
      line((1.8, -1.1), (1.8, 1.45), stroke: (paint: rgb("#2b6cb0"), thickness: 0.7pt))
      content((1.65, 1.55), text(size: 7pt)[$S^+$], anchor: "south")

      // Freccia curva di collegamento verso la sezione
      bezier((1.8, 1.45), (4.6, 1.75), (2.4, 2.2), (3.8, 2.2), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.6pt))
      content((4.85, 1.75), text(size: 7pt)[$S^+$])

      // --- PANNELLO DESTRO: Sezione trasversale (centro G in (5.7, 0.2)) ---
      rect((5.1, -0.8), (6.3, 1.2), stroke: 1.2pt)
      line((6.7, 0.2), (4.3, 0.2), mark: (end: ">"), stroke: 0.6pt)
      content((4.3, 0.05), text(size: 7pt)[$z$], anchor: "north")
      line((5.7, -1.2), (5.7, 1.9), mark: (end: ">"), stroke: 0.6pt)
      content((5.85, 1.85), text(size: 7pt)[$y$], anchor: "west")

      circle((5.7, 0.2), radius: 0.08, fill: white, stroke: 0.6pt)
      circle((5.7, 0.2), radius: 0.02, fill: black, stroke: none)
      content((5.58, 0.35), text(size: 7pt)[$G$], anchor: "east")
      content((5.82, 0.32), text(size: 7pt)[$x$], anchor: "west")
      content((6.1, 0.95), text(size: 7pt)[$A$])

      // Forza di taglio Ty
      line((5.7, 0.05), (5.7, -0.72), mark: (end: ">"), stroke: 1.8pt)
      content((5.82, -0.4), text(size: 7pt)[$T_y$], anchor: "west")
      content((6.45, 0.15), text(size: 7pt)[taglio puro], anchor: "west")
    })
  ]
)
#v(1em)

=== Linee di flusso, equazioni di equivalenza e confronto con la flessione

Analogamente a quanto osservato per la torsione, le tensioni tangenziali $tau$ generate dallo sforzo di taglio (ad esempio $T_y$) si distribuiscono sulla sezione trasversale disponendosi secondo linee di flusso governate da un'analogia idrodinamica (canalizzazione del flusso tangenziale entro i contorni della sezione).

Lo sforzo di taglio $T_y$ produce pertanto non solo componenti di tensione tangenziale parallele alla direzione della forza tagliante ($tau_(x y)$), ma anche componenti ortogonali ad essa ($tau_(x z)$), necessarie affinché il vettore tensione tangenziale risulti sempre tangente al contorno libero della sezione.

#align(center)[
  #canvas(length: 1.45cm, {
    import draw: *
    // 1. Sezione rettangolare (centro (-4.5, 0))
    rect((-5.2, -1.2), (-3.8, 1.2), stroke: 1.2pt)
    line((-3.5, 0), (-5.6, 0), mark: (end: ">"), stroke: (paint: luma(140), thickness: 0.6pt))
    line((-4.5, -1.4), (-4.5, 1.6), mark: (end: ">"), stroke: (paint: luma(140), thickness: 0.6pt))
    content((-5.6, -0.15), text(size: 7pt)[$z$], anchor: "north")
    content((-4.35, 1.55), text(size: 7pt)[$y$], anchor: "west")
    // Frecce verticali tau_xy su 3 fasce
    line((-5.2, 0.95), (-3.8, 0.95), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((-5.2, 0.65), (-3.8, 0.65), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((-5.0, 0.95), (-5.0, 0.65), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((-4.5, 0.95), (-4.5, 0.65), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((-4.0, 0.95), (-4.0, 0.65), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))

    line((-5.2, 0.25), (-3.8, 0.25), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((-5.2, -0.25), (-3.8, -0.25), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((-5.0, 0.25), (-5.0, -0.25), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((-4.5, 0.25), (-4.5, -0.25), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((-4.0, 0.25), (-4.0, -0.25), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))

    line((-4.5, -0.55), (-4.5, -1.55), mark: (end: ">"), stroke: 1.8pt)
    content((-4.35, -1.55), text(size: 7pt)[$T_y$], anchor: "west")

    // 2. Sezione a T rovesciata (centro (-1.5, 0))
    line((-2.5, -1.2), (-0.5, -1.2), (-0.5, -0.4), (-1.2, -0.4), (-1.2, 1.2), (-1.8, 1.2), (-1.8, -0.4), (-2.5, -0.4), close: true, stroke: 1.2pt)
    line((-0.2, -0.55), (-2.8, -0.55), mark: (end: ">"), stroke: (paint: luma(140), thickness: 0.6pt))
    line((-1.5, -1.4), (-1.5, 1.6), mark: (end: ">"), stroke: (paint: luma(140), thickness: 0.6pt))
    content((-2.8, -0.7), text(size: 7pt)[$z$], anchor: "north")
    content((-1.35, 1.55), text(size: 7pt)[$y$], anchor: "west")
    // Frecce deviate nelle ali
    line((-1.7, 0.9), (-1.7, 0.6), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((-1.3, 0.9), (-1.3, 0.6), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((-1.6, -0.35), (-2.1, -0.55), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((-1.4, -0.35), (-0.9, -0.55), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((-2.2, -0.7), (-2.2, -1.0), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((-0.8, -0.7), (-0.8, -1.0), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((-1.5, -0.55), (-1.5, -1.55), mark: (end: ">"), stroke: 1.8pt)
    content((-1.35, -1.55), text(size: 7pt)[$T_y$], anchor: "west")

    // 3. Sezione scatolare cava (centro (1.6, 0))
    rect((0.6, -1.2), (2.6, 1.2), stroke: 1.2pt)
    rect((1.3, -0.6), (1.9, 0.6), stroke: 1.2pt)
    line((2.9, 0), (0.3, 0), mark: (end: ">"), stroke: (paint: luma(140), thickness: 0.6pt))
    line((1.6, -1.4), (1.6, 1.6), mark: (end: ">"), stroke: (paint: luma(140), thickness: 0.6pt))
    content((0.3, -0.15), text(size: 7pt)[$z$], anchor: "north")
    content((1.75, 1.55), text(size: 7pt)[$y$], anchor: "west")
    // Frecce deviate attorno al foro
    line((1.4, 0.8), (1.0, 0.65), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((1.8, 0.8), (2.2, 0.65), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((0.95, 0.4), (0.95, -0.1), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((2.25, 0.4), (2.25, -0.1), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((1.0, -0.65), (1.4, -0.8), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((2.2, -0.65), (1.8, -0.8), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((1.6, -0.6), (1.6, -1.55), mark: (end: ">"), stroke: 1.8pt)
    content((1.75, -1.55), text(size: 7pt)[$T_y$], anchor: "west")

    // 4. Sezione sagomata a campana (centro (4.6, 0))
    bezier((4.6, 1.2), (3.8, -0.4), (4.1, 1.2), (4.1, 0.1), stroke: 1.2pt)
    bezier((3.8, -0.4), (4.6, -1.2), (3.5, -0.9), (3.8, -1.2), stroke: 1.2pt)
    bezier((4.6, -1.2), (5.4, -0.4), (5.4, -1.2), (5.7, -0.9), stroke: 1.2pt)
    bezier((5.4, -0.4), (4.6, 1.2), (5.1, 0.1), (5.1, 1.2), stroke: 1.2pt)
    line((5.9, -0.35), (3.3, -0.35), mark: (end: ">"), stroke: (paint: luma(140), thickness: 0.6pt))
    line((4.6, -1.4), (4.6, 1.6), mark: (end: ">"), stroke: (paint: luma(140), thickness: 0.6pt))
    content((3.3, -0.5), text(size: 7pt)[$z$], anchor: "north")
    content((4.75, 1.55), text(size: 7pt)[$y$], anchor: "west")
    // Frecce inclinate tangenti al profilo
    line((4.2, -0.05), (4.0, -0.45), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((4.6, -0.05), (4.6, -0.45), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((5.0, -0.05), (5.2, -0.45), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
    line((4.6, -0.55), (4.6, -1.55), mark: (end: ">"), stroke: 1.8pt)
    content((4.75, -1.55), text(size: 7pt)[$T_y$], anchor: "west")
  })
]
#v(0.5em)

Considerando la sola presenza dello sforzo di taglio verticale $T_y$ ($T_z = 0$), le equazioni di equivalenza statica sulla sezione trasversale di area $A$ impongono che:

$ integral_A tau_(x y) d A = T_y, quad integral_A tau_(x z) d A = T_z = 0 $

Le tensioni tangenziali $tau$ dovute al taglio presentano una distribuzione non uniforme sulla sezione, il cui valor medio della componente lungo la direzione del taglio è dato da:

$ tau_m = T / A $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Nelle travi snelle, e in particolar modo per le sezioni piene, le tensioni tangenziali $tau$ indotte dal taglio risultano solitamente molto più piccole rispetto alle tensioni normali $sigma$ dovute al momento flettente.

    *Esempio numerico (mensola a sezione quadrata)*:
    Si consideri una trave incastrata in $B$ e caricata all'estremità libera $A$ da una forza concentrata $P = 1000 "N"$, con lunghezza $L = 1 "m"$ e sezione quadrata di lati $b = 0.1 "m"$ e $h = 0.1 "m"$. Svolgendo i calcoli nella sezione d'incastro $B$ ($T = P$, $M = P L$), si ottiene:
    $ sigma_"max" = M / W_f = (6 P L) / (b h^2) = 60 "daN"/"cm"^2 = 6 "MPa" $
    $ tau_m = T / A = P / (b h) = 1 "daN"/"cm"^2 = 0.1 "MPa" $
  ],
  [
    #canvas(length: 0.85cm, {
      import draw: *
      // --- PANNELLO SINISTRO: Mensola AB ---
      line((0, 0), (0, 2.2), mark: (end: ">"), stroke: 0.6pt)
      content((0.15, 2.15), text(size: 7pt)[$y$], anchor: "west")
      line((0, 0), (3.8, 0), mark: (end: ">"), stroke: 0.6pt)
      content((3.75, -0.15), text(size: 7pt)[$x$], anchor: "north")

      // Asse trave
      line((0, 0), (3.0, 0), stroke: 1.5pt)
      content((-0.15, 0.35), text(size: 7pt)[$A$], anchor: "east")
      content((2.85, 0.35), text(size: 7pt)[$B$], anchor: "east")

      // Forza concentrata P in A
      line((0, 1.5), (0, 0.05), mark: (end: ">"), stroke: 1.5pt)
      content((0.12, 1.25), text(size: 7pt)[$P$], anchor: "west")

      // Incastro in B (blocco tratteggiato)
      rect((3.0, -0.65), (3.35, 0.65), fill: luma(230), stroke: 0.6pt)
      line((3.0, -0.45), (3.35, -0.1), stroke: 0.6pt)
      line((3.0, -0.15), (3.35, 0.2), stroke: 0.6pt)
      line((3.0, 0.15), (3.35, 0.5), stroke: 0.6pt)

      // Reazioni T e M in rosso
      line((3.15, -0.55), (3.15, 1.55), mark: (end: ">"), stroke: (paint: red, thickness: 1.3pt))
      content((3.0, 1.3), text(size: 7pt, fill: red)[$T$], anchor: "east")
      arc((3.3, 0), start: -65deg, stop: 65deg, radius: 0.5, anchor: "origin", mark: (start: ">"), stroke: (paint: red, thickness: 1.3pt))
      content((3.7, 0.65), text(size: 7pt, fill: red)[$M$], anchor: "west")

      // Quota L
      line((0, 0), (0, -1.15), stroke: 0.5pt)
      line((3.0, -0.65), (3.0, -1.15), stroke: 0.5pt)
      line((0, -1.0), (3.0, -1.0), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((1.5, -0.95), text(size: 7pt)[$L$], anchor: "south")

      // --- PANNELLO DESTRO: Sezione quadrata b x h (centro (5.2, 0)) ---
      rect((4.6, -0.6), (5.8, 0.6), fill: luma(220), stroke: 0.8pt)
      line((6.0, 0), (4.2, 0), mark: (end: ">"), stroke: 0.6pt)
      content((4.25, -0.15), text(size: 7pt)[$z$], anchor: "north")
      line((5.2, -0.85), (5.2, 1.25), mark: (end: ">"), stroke: 0.6pt)
      content((5.35, 1.25), text(size: 7pt)[$y$], anchor: "west")
      content((6.0, 0), text(size: 7pt)[$h$], anchor: "west")
      content((5.2, -1.05), text(size: 7pt)[$b$], anchor: "north")
    })
  ]
)
#v(1em)

Il comportamento meccanico della trave soggetta a forze di taglio non può essere descritto in modo esatto con un modello cinematico elementare come avviene per i casi estensionale, flessionale e torsionale. Nella pratica ingegneristica (teoria approssimata di Jourawski):
- l'effetto del taglio si studia separatamente nei due piani coordinati principali d'inerzia $x y$ e $x z$;
- il caso generale di taglio deviato (compresenza di $T_y$ e $T_z$) si risolve applicando il principio di sovrapposizione degli effetti.

== Studio dello sforzo di taglio $T_y$

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Isoliamo un tronco elementare di trave di lunghezza infinitesima $d x$. In assenza di carichi trasversali distribuiti lungo il concio $d x$, per garantire l'equilibrio alla traslazione verticale gli sforzi di taglio devono risultare uguali (e opposti in verso sulle facce contrapposte) in corrispondenza delle due sezioni distanti tra loro $d x$.

    Sulla faccia di ascissa $x$ agiscono il taglio $T_y$ e il momento flettente $M_z$, mentre sulla faccia di ascissa $x + d x$ agiscono il taglio $T_y$ e il momento incrementato $M_z + d M_z$. Dall'equilibrio alla rotazione del concio attorno all'asse $z$ si ritrova la relazione fondamentale secondo cui il taglio è la derivata del momento flettente:

    $ T_y = (d M_z) / (d x) $
  ],
  [
    #canvas(length: 0.9cm, {
      import draw: *
      // Concio di trave di larghezza dx (x: -0.9..0.9, y: -1.6..1.6)
      rect((-0.9, -1.6), (0.9, 1.6), stroke: 0.8pt)

      // Sistema di riferimento al centro (0, -0.1)
      line((0, -0.1), (0.7, -0.1), stroke: 0.5pt)
      line((0, -0.1), (0, 0.65), stroke: 0.5pt)
      circle((0, -0.1), radius: 0.2, stroke: 0.5pt)
      circle((0, -0.1), radius: 0.05, fill: black, stroke: none)
      content((0.55, -0.25), text(size: 7pt)[$x$], anchor: "north")
      content((-0.12, 0.55), text(size: 7pt)[$y$], anchor: "east")
      content((-0.25, -0.35), text(size: 7pt)[$z$], anchor: "north")

      // Quota dx in alto
      line((-0.9, 1.75), (-0.9, 2.25), stroke: 0.5pt)
      line((0.9, 1.75), (0.9, 2.25), stroke: 0.5pt)
      line((-0.35, 2.05), (-0.9, 2.05), mark: (end: ">"), stroke: 0.6pt)
      line((0.35, 2.05), (0.9, 2.05), mark: (end: ">"), stroke: 0.6pt)
      content((0, 2.05), text(size: 7pt)[$d x$])

      // Sollecitazioni a sinistra: Ty verso l'alto, Mz orario
      line((-1.15, -0.2), (-1.15, 1.35), mark: (end: ">"), stroke: 1pt)
      content((-1.3, 1.3), text(size: 7pt)[$T_y$], anchor: "east")

      arc((-1.55, 0), start: 105deg, stop: 255deg, radius: (0.45, 0.8), anchor: "origin", mark: (start: ">"), stroke: 1pt)
      content((-2.05, 0.45), text(size: 7pt)[$M_z$], anchor: "east")

      // Sollecitazioni a destra: Ty verso il basso, Mz + dMz antiorario
      line((1.15, -0.15), (1.15, -1.6), mark: (end: ">"), stroke: 1pt)
      content((1.3, -1.3), text(size: 7pt)[$T_y$], anchor: "west")

      arc((1.55, 0), start: -75deg, stop: 75deg, radius: (0.45, 0.8), anchor: "origin", mark: (end: ">"), stroke: 1pt)
      content((1.95, 0.65), text(size: 7pt)[$M_z + d M_z$], anchor: "west")
    })
  ]
)
#v(1em)


// === Blocco_03_Slide_31-45 ===

=== Flusso delle tensioni tangenziali e formula di Jourawski

Si consideri sulla sezione trasversale della trave una generica porzione di area $A^*$ delimitata dal contorno esterno libero e da una corda rettilinea di larghezza $b$ tracciata parallelamente all'asse neutro $z$. Si definisce *flusso della tensione tangenziale* $tau_(x y)$ attraverso la corda $b$ l'integrale di linea:

$ t_(x y) = integral_b tau_(x y) d z $

Per il teorema di reciprocità delle tensioni tangenziali di Cauchy ($tau_(x y) = tau_(y x)$), le tensioni $tau_(x y)$ agenti sul piano della sezione trasversale coincidono puntualmente con le tensioni tangenziali longitudinali $tau_(y x)$ che agiscono sul piano orizzontale longitudinale perpendicolare alla sezione e passante per la corda $b$. Il flusso longitudinale per unità di lunghezza vale pertanto:

$ t_(y x) = integral_b tau_(y x) d z = t_(x y) $

#align(center)[
  #canvas(length: 1.3cm, {
    import draw: *
    // --- PANNELLO 1: Tronco 3D con area A* e flusso t_xy (centro (-4.5, 0)) ---
    circle((-4.5, 0), radius: 1.45, stroke: 0.7pt)
    arc((-3.2, 0.35), start: -70deg, stop: 105deg, radius: 1.45, anchor: "origin", stroke: 0.7pt)
    line((-4.85, 1.41), (-3.55, 1.76), stroke: 0.7pt)
    line((-4.0, -1.36), (-2.7, -1.01), stroke: 0.7pt)

    // Corda b tratteggiata rossa a quota y = 0.65 (da x = -5.80 a -3.20) e arco superiore A*
    line((-5.80, 0.65), (-3.20, 0.65), stroke: (paint: red, dash: "dashed", thickness: 1.4pt))
    arc((-4.5, 0), start: 26.6deg, stop: 153.4deg, radius: 1.45, anchor: "origin", stroke: (paint: red, thickness: 1.4pt))
    line((-3.20, 0.65), (-1.90, 1.00), stroke: (paint: red, dash: "densely-dotted", thickness: 0.8pt))

    content((-5.1, 1.05), text(size: 7pt)[$A^*$])
    content((-5.1, 0.35), text(size: 7pt, fill: red)[$bold(b)$])

    // Vettore flusso t_xy
    line((-4.5, 0.35), (-4.5, 1.25), mark: (end: ">"), stroke: 1.1pt)
    content((-4.3, 0.35), text(size: 7pt)[$t_(x y)$], anchor: "west")

    // terna centrale
    line((-4.5, -0.35), (-5.2, -0.35), stroke: 0.5pt)
    line((-4.5, -0.35), (-4.5, 0.2), stroke: 0.5pt)
    circle((-4.5, -0.35), radius: 0.18, fill: white, stroke: 0.5pt)
    circle((-4.5, -0.35), radius: 0.05, fill: black, stroke: none)
    content((-4.65, 0.05), text(size: 7pt)[$y$], anchor: "east")
    content((-5.1, -0.5), text(size: 7pt)[$z$], anchor: "north")
    content((-4.2, -0.35), text(size: 7pt)[$x$], anchor: "west")

    // --- PANNELLO 2: Tronco sezionato lungo il piano della corda b (centro (0, 0)) ---
    arc((0, 0), start: 153.4deg, stop: 386.6deg, radius: 1.45, anchor: "origin", stroke: 0.7pt)
    arc((1.3, 0.35), start: -70deg, stop: 26.6deg, radius: 1.45, anchor: "origin", stroke: 0.7pt)
    line((0.5, -1.36), (1.8, -1.01), stroke: 0.7pt)

    // Piano orizzontale di taglio sulla corda b
    line((-1.30, 0.65), (1.30, 0.65), stroke: (paint: red, dash: "dashed", thickness: 1.4pt))
    line((-1.30, 0.65), (0.0, 1.00), stroke: 0.7pt)
    line((1.30, 0.65), (2.60, 1.00), stroke: 0.7pt)
    line((0.0, 1.00), (2.60, 1.00), stroke: 0.7pt)

    content((-0.6, 0.35), text(size: 7pt, fill: red)[$bold(b)$])

    // Vettori t_xy e t_yx concorrenti sulla corda b
    line((0, 0.1), (0, 0.65), mark: (end: ">"), stroke: 1.1pt)
    content((0.15, 0.32), text(size: 7pt)[$t_(x y)$], anchor: "west")
    line((0.9, 0.90), (0.1, 0.68), mark: (end: ">"), stroke: 1.1pt)
    content((1.0, 0.95), text(size: 7pt)[$t_(y x)$], anchor: "west")

    // terna centrale
    line((0, -0.35), (-0.7, -0.35), stroke: 0.5pt)
    line((0, -0.35), (0, 0.05), stroke: 0.5pt)
    circle((0, -0.35), radius: 0.18, fill: white, stroke: 0.5pt)
    circle((0, -0.35), radius: 0.05, fill: black, stroke: none)
    content((-0.15, -0.02), text(size: 7pt)[$y$], anchor: "east")
    content((-0.6, -0.5), text(size: 7pt)[$z$], anchor: "north")
    content((0.3, -0.35), text(size: 7pt)[$x$], anchor: "west")

    // --- PANNELLO 3: Equilibrio concio dx in vista laterale (centro (5.0, 0)) ---
    rect((4.3, -1.45), (5.7, 1.45), stroke: 0.7pt)
    line((4.3, 0.65), (5.7, 0.65), stroke: (paint: red, dash: "dashed", thickness: 1.4pt))

    // Quota dx
    line((4.3, 1.6), (4.3, 2.0), stroke: 0.5pt)
    line((5.7, 1.6), (5.7, 2.0), stroke: 0.5pt)
    line((4.7, 1.8), (4.3, 1.8), mark: (end: ">"), stroke: 0.6pt)
    line((5.3, 1.8), (5.7, 1.8), mark: (end: ">"), stroke: 0.6pt)
    content((5.0, 1.8), text(size: 7pt)[$d x$])

    // Forze normali su A* e forza tangenziale t_xy dx
    line((4.2, 1.05), (3.1, 1.05), mark: (end: ">"), stroke: 1pt)
    content((3.65, 1.15), text(size: 7pt)[$integral_(A^*) sigma_(x x) d A$], anchor: "south")

    line((5.8, 1.05), (6.9, 1.05), mark: (end: ">"), stroke: 1pt)
    content((6.45, 1.15), text(size: 7pt)[$integral_(A^*) (sigma_(x x) + (d sigma_(x x)) / (d x) d x) d A$], anchor: "south")

    line((5.45, 0.50), (4.55, 0.50), mark: (end: ">"), stroke: 1pt)
    content((5.15, 0.25), text(size: 7pt)[$t_(x y) d x$])

    // terna centrale
    line((5.0, -0.35), (5.55, -0.35), stroke: 0.5pt)
    line((5.0, -0.35), (5.0, 0.25), stroke: 0.5pt)
    circle((5.0, -0.35), radius: 0.18, fill: white, stroke: 0.5pt)
    circle((5.0, -0.35), radius: 0.05, fill: black, stroke: none)
    content((4.88, 0.15), text(size: 7pt)[$y$], anchor: "east")
    content((4.8, -0.55), text(size: 7pt)[$z$], anchor: "north")
    content((5.5, -0.5), text(size: 7pt)[$x$], anchor: "north")
  })
]
#v(0.5em)

Isolando l'elemento tridimensionale di lunghezza infinitesima $d x$ compreso tra le due porzioni di area $A^*$ delle sezioni trasversali poste a distanza $d x$, l'equazione di equilibrio alla traslazione lungo l'asse longitudinale $x$ impone che lo squilibrio delle tensioni normali di flessione $sigma_(x x)$ sia bilanciato dalla forza tangenziale longitudinale $t_(y x) d x = t_(x y) d x$:

$ t_(x y) d x + integral_(A^*) sigma_(x x) d A - integral_(A^*) (sigma_(x x) + (d sigma_(x x)) / (d x) d x) d A = 0 $ // INCERTO: dedotto dal contesto (nelle slide compare un refuso dx dentro gli integrali d'area che poi si semplifica nel passaggio successivo)

Semplificando i termini opposti e dividendo per $d x$, si ricava:

$ t_(x y) = integral_(A^*) (d sigma_(x x)) / (d x) d A $

Sostituendo la formula di Navier per la flessione retta $sigma_(x x) = -(M_z / I_z) y$ (a meno del segno convenzionale, considerando il modulo dello scorrimento) e ricordando la relazione differenziale $T_y = (d M_z) / (d x)$, si ottiene:

$ t_(x y) = integral_(A^*) (d / (d x) (M_z / I_z y)) d A = integral_(A^*) 1 / I_z (d M_z) / (d x) y d A = T_y / I_z integral_(A^*) y d A = (T_y S_z^(A^*)) / I_z $

dove $S_z^(A^*) = integral_(A^*) y d A$ rappresenta il momento statico della porzione di sezione $A^*$ calcolato rispetto all'asse baricentrico $z$ dell'intera sezione. Esplicitando infine l'espressione del flusso medio lungo la corda $t_(x y) = integral_b tau_(x y) d z = tau_(x y) b$, si perviene alla *formula di Jourawski* per lo sforzo di taglio $T_y$:

$ integral_b tau_(x y) d z = (T_y S_z^(A^*)) / I_z => tau_(x y) b = (T_y S_z^(A^*)) / I_z => tau_(x y) = (T_y S_z^(A^*)) / (I_z b) $

=== Estensione allo sforzo di taglio $T_z$ e osservazioni generali

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Con procedimento del tutto duale, considerando uno sforzo di taglio orizzontale $T_z = (d M_y) / (d x)$ agente lungo l'asse $z$ e una corda $b$ parallela all'asse $y$ che isola la porzione di area $A^*$, la formula di Jourawski fornisce la tensione tangenziale media $tau_(x z)$:

    $ integral_b tau_(x z) d y = (T_z S_y^(A^*)) / I_y => tau_(x z) b = (T_z S_y^(A^*)) / I_y $

    $ tau_(x z) = (T_z S_y^(A^*)) / (I_y b) $
  ],
  [
    #canvas(length: 0.8cm, {
      import draw: *
      // --- PANNELLO SINISTRO: Concio dx soggetto a Tz e My ---
      rect((0, -1.4), (1.4, 1.4), stroke: 0.7pt)
      line((0, 1.55), (0, 1.95), stroke: 0.5pt)
      line((1.4, 1.55), (1.4, 1.95), stroke: 0.5pt)
      line((0.4, 1.75), (0, 1.75), mark: (end: ">"), stroke: 0.6pt)
      line((1.0, 1.75), (1.4, 1.75), mark: (end: ">"), stroke: 0.6pt)
      content((0.7, 1.75), text(size: 7pt)[$d x$])

      // Terna al centro (0.7, -0.1) con y entrante (croce)
      line((0.7, -0.1), (1.3, -0.1), stroke: 0.5pt)
      line((0.7, -0.1), (0.7, 0.55), stroke: 0.5pt)
      circle((0.7, -0.1), radius: 0.18, fill: white, stroke: 0.5pt)
      line((0.57, -0.23), (0.83, 0.03), stroke: 0.5pt)
      line((0.57, 0.03), (0.83, -0.23), stroke: 0.5pt)
      content((0.85, 0.45), text(size: 7pt)[$z$], anchor: "west")
      content((0.42, -0.15), text(size: 7pt)[$y$], anchor: "east")
      content((1.2, -0.25), text(size: 7pt)[$x$], anchor: "north")

      // Tz e My a sinistra e a destra
      line((-0.25, 0.1), (-0.25, -1.25), mark: (end: ">"), stroke: 1pt)
      content((-0.38, -1.2), text(size: 7pt)[$T_z$], anchor: "east")
      arc((-0.6, 0), start: 105deg, stop: 255deg, radius: (0.4, 0.75), anchor: "origin", mark: (start: ">"), stroke: 1pt)
      content((-1.05, 0.1), text(size: 7pt)[$M_y$], anchor: "east")

      line((1.65, -0.1), (1.65, 1.25), mark: (end: ">"), stroke: 1pt)
      content((1.8, 1.2), text(size: 7pt)[$T_z$], anchor: "west")
      arc((2.0, 0), start: -75deg, stop: 75deg, radius: (0.4, 0.75), anchor: "origin", mark: (end: ">"), stroke: 1pt)
      content((2.45, 0.1), text(size: 7pt)[$M_y + d M_y$], anchor: "west")

      // --- PANNELLO DESTRO: Tronco cilindrico con corda verticale b e flusso t_xz (centro (5.0, 0)) ---
      circle((5.0, 0), radius: 1.45, stroke: 0.7pt)
      arc((6.1, 0.3), start: -68deg, stop: 105deg, radius: 1.45, anchor: "origin", stroke: 0.7pt)
      line((4.65, 1.41), (5.75, 1.71), stroke: 0.7pt)
      line((5.5, -1.36), (6.6, -1.06), stroke: 0.7pt)

      // Corda verticale b a x = 5.45 (da y = -1.38 a +1.38) e arco destro A*
      line((5.45, -1.38), (5.45, 1.38), stroke: (paint: red, dash: "dashed", thickness: 1.4pt))
      arc((5.0, 0), start: -71.9deg, stop: 71.9deg, radius: 1.45, anchor: "origin", stroke: (paint: red, thickness: 1.4pt))
      line((5.45, 1.38), (6.55, 1.68), stroke: (paint: red, dash: "densely-dotted", thickness: 0.8pt))

      content((5.25, 0.85), text(size: 7pt, fill: red)[$bold(b)$])
      content((5.8, 0.55), text(size: 7pt)[$A^*$])

      // Vettore t_xz
      line((5.05, -0.2), (5.85, -0.2), mark: (end: ">"), stroke: 1.1pt)
      content((5.3, -0.5), text(size: 7pt)[$t_(x z)$])

      // Terna
      line((4.8, -0.2), (4.1, -0.2), stroke: 0.5pt)
      line((4.8, -0.2), (4.8, 0.45), stroke: 0.5pt)
      circle((4.8, -0.2), radius: 0.18, fill: white, stroke: 0.5pt)
      circle((4.8, -0.2), radius: 0.05, fill: black, stroke: none)
      content((4.65, 0.35), text(size: 7pt)[$y$], anchor: "east")
      content((4.2, -0.35), text(size: 7pt)[$z$], anchor: "north")
      content((5.05, 0.05), text(size: 7pt)[$x$], anchor: "west")
    })
  ]
)
#v(1em)

#nota[
  *Osservazioni fondamentali sullo stato tensionale nella trave di de Saint-Venant*:
  - Sulla superficie esterna libera della trave i flussi delle tensioni tangenziali di taglio si annullano ($A^* = 0 => S_z = 0$): le tensioni tangenziali di taglio sono pertanto *nulle sul contorno superiore e inferiore della trave*, esattamente dove risultano invece massime le componenti di tensione dovute alle altre caratteristiche di sollecitazione (trazione/compressione, flessione, torsione).
  - Le tensioni tangenziali di taglio raggiungono il valore *massimo al centro del solido* (in corrispondenza dell'asse neutro baricentrico), là dove si annullano invece le tensioni normali di flessione e le tensioni tangenziali di torsione.
  - Di conseguenza, il punto critico di verifica o di progetto in una trave snella di de Saint-Venant (a sezione compatta) si colloca quasi sempre sulla superficie esterna, dove agiscono contemporaneamente le tensioni massime di trazione, flessione e torsione.
]

== Distribuzione della tensione $tau_(x y)$ nelle sezioni spesse e sottili

In base alla formula di Jourawski, il valore puntuale (medio sulla corda) della componente di tensione tangenziale parallela allo sforzo di taglio $T_y$ alla generica ordinata $y$ della sezione trasversale è espresso da:

$ tau_(x y)(y) = (T_y S_z(y)) / (I_z b(y)) $

dove i termini hanno il seguente significato fisico e geometrico:
- $tau_(x y)(y)$ è la tensione tangenziale di taglio in corrispondenza della coordinata $y$;
- $S_z(y) = A^* y_0$ è il momento statico della porzione di sezione $A^*$ delimitata dalla coordinata $y$ (ed esterna ad essa), valutato rispetto all'asse baricentrico $z$ dell'intera sezione ($y_0$ è l'ordinata del baricentro $G_0$ dell'area $A^*$);
- $I_z$ è il momento d'inerzia di area dell'intera sezione trasversale rispetto all'asse baricentrico $z$;
- $b(y)$ è la larghezza della corda della sezione alla quota $y$, ortogonale alle tensioni $tau_(x y)$.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Dall'esame della formula di Jourawski emerge un fenomeno strutturale di primaria importanza: le tensioni tangenziali $tau_(x y)$ aumentano bruscamente laddove la larghezza della corda $b(y)$ subisce una repentina riduzione (come avviene nel passaggio dall'ala di larghezza $b$ all'anima di larghezza $b'$ nelle sezioni a $I$ o a $T$).

    Infatti, poiché il momento statico $S_z(y)$ è una funzione integrale continua che non subisce discontinuità per variazioni infinitesime della coordinata $y$ a cavallo della variazione di sezione, il flusso tangenziale complessivo $tau_(x y)(y) b(y) = (T_y S_z(y)) / I_z$ deve rimanere costante, determinando una discontinuità a salto della tensione puntuale ($tau'_(x y) = tau_(x y) b / b' > tau_(x y)$).
  ],
  [
    #canvas(length: 0.85cm, {
      import draw: *
      // Sezione a doppio T spessa per evidenziare il salto di corda b -> b'
      line((-1.8, -1.6), (1.8, -1.6), (1.8, -0.9), (0.6, -0.9), (0.6, 0.9), (1.8, 0.9), (1.8, 1.6), (-1.8, 1.6), (-1.8, 0.9), (-0.6, 0.9), (-0.6, -0.9), (-1.8, -0.9), close: true, stroke: 1.4pt)

      // Assi z e y baricentrici
      line((1.2, 0), (-1.8, 0), mark: (end: ">"), stroke: 0.6pt)
      content((-1.75, -0.18), text(size: 7pt)[$z$], anchor: "north")
      line((0, -1.9), (0, 2.1), mark: (end: ">"), stroke: 0.6pt)
      content((0.15, 2.05), text(size: 7pt)[$y$], anchor: "west")
      content((-0.2, 0.2), text(size: 7pt)[$G$])
      content((1.4, 1.3), text(size: 7pt)[$A$])

      // Corde rosse tratteggiate in alto (b nell'ala, b' nell'anima)
      line((-1.75, 0.98), (1.75, 0.98), stroke: (paint: red, dash: "dashed", thickness: 1.4pt))
      line((-0.58, 0.82), (0.58, 0.82), stroke: (paint: red, dash: "dashed", thickness: 1.4pt))
      content((-0.2, 1.25), text(size: 7pt)[$b$])
      content((0.2, 0.55), text(size: 7pt)[$b'$])
      content((-2.15, 1.2), text(size: 7pt)[$tau_(x y)$])
      content((-0.95, 0.45), text(size: 7pt)[$tau'_(x y)$])

      // Corde rosse e frecce di tensione in basso (confronto ampiezza frecce)
      line((-0.58, -0.82), (0.58, -0.82), stroke: (paint: red, dash: "dashed", thickness: 1.4pt))
      line((-1.75, -0.98), (1.75, -0.98), stroke: (paint: red, dash: "dashed", thickness: 1.4pt))

      // Fascia frecce lunghe nell'anima (tau'_xy)
      line((-0.6, -0.25), (0.6, -0.25), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((-0.6, -0.75), (0.6, -0.75), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((-0.45, -0.25), (-0.45, -0.75), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((-0.15, -0.25), (-0.15, -0.75), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((0.15, -0.25), (0.15, -0.75), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((0.45, -0.25), (0.45, -0.75), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      content((-0.95, -0.45), text(size: 7pt)[$tau'_(x y)$])

      // Fascia frecce corte nell'ala inferiore (tau_xy)
      line((-1.8, -1.02), (1.8, -1.02), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((-1.8, -1.22), (1.8, -1.22), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((-1.5, -1.02), (-1.5, -1.22), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((-1.0, -1.02), (-1.0, -1.22), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((-0.5, -1.02), (-0.5, -1.22), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((0.0, -1.02), (0.0, -1.22), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((0.5, -1.02), (0.5, -1.22), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((1.0, -1.02), (1.0, -1.22), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((1.5, -1.02), (1.5, -1.22), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      content((-2.15, -1.15), text(size: 7pt)[$tau_(x y)$])
    })
  ]
)
#v(1em)

Occorre inoltre distinguere il comportamento strutturale tra sezioni spesse e sezioni sottili:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    - *Sezione spessa*: le componenti di tensione tangenziale non parallele allo sforzo di taglio ($tau_(x z)$) risultano trascurabili rispetto alle componenti parallele al taglio ($tau_(x y)$).
    - *Sezione sottile*: le componenti di tensione tangenziale non parallele allo sforzo di taglio ($tau_(x z)$ nelle ali) assumono valori confrontabili con le componenti parallele al taglio ($tau_(x y)$ nell'anima); non sono pertanto trascurabili e devono essere esplicitamente calcolate.
  ],
  [
    #canvas(length: 0.78cm, {
      import draw: *
      // --- PANNELLO SINISTRO: Sezione spessa (centro (-2.2, 0)) ---
      line((-3.6, -1.5), (-0.8, -1.5), (-0.8, -0.8), (-1.7, -0.8), (-1.7, 0.8), (-0.8, 0.8), (-0.8, 1.5), (-3.6, 1.5), (-3.6, 0.8), (-2.7, 0.8), (-2.7, -0.8), (-3.6, -0.8), close: true, stroke: 1.2pt)
      line((-1.2, 0), (-3.6, 0), mark: (end: ">"), stroke: 0.5pt)
      line((-2.2, -1.6), (-2.2, 1.9), mark: (end: ">"), stroke: 0.5pt)
      content((-3.55, -0.18), text(size: 7pt)[$z$], anchor: "north")
      content((-2.05, 1.85), text(size: 7pt)[$y$], anchor: "west")
      content((-2.35, 0.18), text(size: 7pt)[$G$])

      // Fasce tau_xy in ala sup, anima e ala inf
      line((-3.6, 1.25), (-0.8, 1.25), stroke: (paint: rgb("#2b6cb0"), thickness: 0.4pt))
      line((-3.6, 1.00), (-0.8, 1.00), stroke: (paint: rgb("#2b6cb0"), thickness: 0.4pt))
      line((-3.2, 1.25), (-3.2, 1.00), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.4pt))
      line((-2.2, 1.25), (-2.2, 1.00), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.4pt))
      line((-1.2, 1.25), (-1.2, 1.00), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.4pt))
      content((-3.9, 1.15), text(size: 7pt)[$tau_(x y)$])

      line((-2.7, -0.15), (-1.7, -0.15), stroke: (paint: rgb("#2b6cb0"), thickness: 0.4pt))
      line((-2.7, -0.60), (-1.7, -0.60), stroke: (paint: rgb("#2b6cb0"), thickness: 0.4pt))
      line((-2.45, -0.15), (-2.45, -0.60), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.4pt))
      line((-1.95, -0.15), (-1.95, -0.60), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.4pt))
      content((-3.0, -0.35), text(size: 7pt)[$tau_(x y)$])

      line((-3.6, -1.00), (-0.8, -1.00), stroke: (paint: rgb("#2b6cb0"), thickness: 0.4pt))
      line((-3.6, -1.25), (-0.8, -1.25), stroke: (paint: rgb("#2b6cb0"), thickness: 0.4pt))
      line((-3.2, -1.00), (-3.2, -1.25), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.4pt))
      line((-2.2, -1.00), (-2.2, -1.25), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.4pt))
      line((-1.2, -1.00), (-1.2, -1.25), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.4pt))
      content((-3.9, -1.15), text(size: 7pt)[$tau_(x y)$])

      line((-2.2, -1.55), (-2.2, -2.25), mark: (end: ">"), stroke: 1.6pt)
      content((-2.0, -2.1), text(size: 7pt)[$T_y$], anchor: "west")

      // --- PANNELLO DESTRO: Sezione sottile (centro (2.0, 0)) ---
      line((0.6, -1.5), (3.4, -1.5), (3.4, -1.28), (2.11, -1.28), (2.11, 1.28), (3.4, 1.28), (3.4, 1.5), (0.6, 1.5), (0.6, 1.28), (1.89, 1.28), (1.89, -1.28), (0.6, -1.28), close: true, stroke: 1.2pt)
      line((3.0, 0), (0.6, 0), mark: (end: ">"), stroke: 0.5pt)
      line((2.0, -1.6), (2.0, 1.9), mark: (end: ">"), stroke: 0.5pt)
      content((0.65, -0.18), text(size: 7pt)[$z$], anchor: "north")
      content((2.15, 1.85), text(size: 7pt)[$y$], anchor: "west")
      content((2.25, 0.18), text(size: 7pt)[$G$])

      // Frecce orizzontali tau_xz nelle ali e verticali tau_xy nell'anima
      line((0.8, 1.39), (1.6, 1.39), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.6pt))
      line((3.2, 1.39), (2.4, 1.39), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.6pt))
      content((1.1, 1.05), text(size: 7pt)[$tau_(x z)$])
      content((2.9, 1.05), text(size: 7pt)[$tau_(x z)$])

      line((1.95, -0.25), (1.95, -0.85), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((2.05, -0.25), (2.05, -0.85), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      content((1.55, -0.55), text(size: 7pt)[$tau_(x y)$])

      line((1.6, -1.39), (0.8, -1.39), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.6pt))
      line((2.4, -1.39), (3.2, -1.39), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.6pt))
      content((1.1, -1.05), text(size: 7pt)[$tau_(x z)$])
      content((2.9, -1.05), text(size: 7pt)[$tau_(x z)$])

      line((2.0, -1.55), (2.0, -2.25), mark: (end: ">"), stroke: 1.6pt)
      content((2.2, -2.1), text(size: 7pt)[$T_y$], anchor: "west")
    })
  ]
)
#v(1em)

=== Trave a sezione rettangolare

In una trave a sezione rettangolare piena di base $b$ e altezza $h$, la larghezza della corda $b(y) = b$ si mantiene costante lungo tutta l'altezza della sezione:

$ tau_(x y)(y) = (T_y S_z(y)) / (I_z b) $

Il momento statico $S_z(y)$ della porzione rettangolare superiore (campita a tratteggio) compresa tra l'ordinata generica $y$ e il bordo superiore $h / 2$, valutato rispetto all'asse baricentrico $z$, è pari al prodotto dell'area $A^* = (h / 2 - y) b$ per la distanza $y_0$ del suo baricentro $G_0$ dall'asse $z$:

$ S_z(y) = A^* d_G = (h / 2 - y) b y_0 = (h / 2 - y) b (y + (h / 2 - y) / 2) = (h / 2 - y) b (h / 2 + y) / 2 = b / 2 (h^2 / 4 - y^2) $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Sostituendo l'espressione del momento statico $S_z(y)$ e il momento d'inerzia della sezione rettangolare $I_z = (b h^3) / 12$ nella formula di Jourawski, si ottiene:

    $ tau_(x y)(y) = (T_y b / 2 (h^2 / 4 - y^2)) / ((b h^3) / 12 b) = (6 T_y) / (b h^3) (h^2 / 4 - y^2) $

    La tensione tangenziale $tau_(x y)(y)$ segue pertanto una *distribuzione parabolica* lungo l'altezza della sezione: si annulla ai lembi estremi ($y = plus.minus h / 2$) e raggiunge il valore massimo sull'asse neutro baricentrico $z$ ($y = 0$), pari al $50 %$ in più rispetto al valor medio $tau_m$:

    $ tau_(x y, "max") = (6 T_y) / (b h^3) h^2 / 4 = 3 / 2 T_y / (b h) = 3 / 2 tau_m $
  ],
  [
    #canvas(length: 0.85cm, {
      import draw: *
      // Sezione rettangolare b x h (x: -0.9..0.9, y: -1.6..1.6)
      rect((-0.9, -1.6), (0.9, 1.6), stroke: 1.2pt)

      // Porzione superiore tratteggiata Sz(y) (da y = 0.55 a 1.6)
      rect((-0.9, 0.55), (0.9, 1.6), fill: luma(230), stroke: 0.8pt)
      line((-0.9, 0.8), (-0.1, 1.6), stroke: 0.4pt)
      line((-0.9, 1.2), (-0.5, 1.6), stroke: 0.4pt)
      line((-0.6, 0.55), (0.45, 1.6), stroke: 0.4pt)
      line((-0.1, 0.55), (0.9, 1.55), stroke: 0.4pt)
      line((0.4, 0.55), (0.9, 1.05), stroke: 0.4pt)

      // Baricentro G0 a quota y0 = 1.075
      circle((0, 1.08), radius: 0.06, fill: white, stroke: 0.8pt)
      content((0.12, 1.08), text(size: 7pt)[$G_0$], anchor: "west")

      // Indicazione Sz(y)
      line((-0.3, 1.35), (-0.55, 1.95), stroke: 0.5pt)
      content((-0.6, 1.95), text(size: 7pt)[$S_z(y)$], anchor: "east")

      // Assi z e y
      line((2.2, 0), (-1.8, 0), mark: (end: ">"), stroke: (dash: "dash-dotted", thickness: 0.6pt))
      content((-1.8, -0.15), text(size: 7pt)[$z$], anchor: "north")
      line((0, -1.9), (0, 2.05), mark: (end: ">"), stroke: (dash: "dash-dotted", thickness: 0.6pt))
      content((-0.15, 2.0), text(size: 7pt)[$y$], anchor: "east")

      // Fascia frecce tau_xy sotto y = 0.55
      line((-0.9, 0.25), (0.9, 0.25), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((-0.7, 0.55), (-0.7, 0.25), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((-0.35, 0.55), (-0.35, 0.25), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((0.0, 0.55), (0.0, 0.25), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((0.35, 0.55), (0.35, 0.25), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((0.7, 0.55), (0.7, 0.25), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      content((1.0, 0.4), text(size: 7pt)[$tau_(x y)$], anchor: "west")

      // Forza Ty
      line((0, -0.05), (0, -0.95), mark: (end: ">"), stroke: 1.8pt)
      content((0.15, -0.95), text(size: 7pt)[$T_y$], anchor: "west")

      // Quote h, y0, y, b
      line((-0.9, 1.6), (-2.6, 1.6), stroke: 0.4pt)
      line((-0.9, -1.6), (-2.6, -1.6), stroke: 0.4pt)
      line((-2.45, -1.6), (-2.45, 1.6), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((-2.55, 0), text(size: 7pt)[$h$], anchor: "east")

      line((0, 1.08), (-1.95, 1.08), stroke: 0.4pt)
      line((-1.8, 0), (-1.8, 1.08), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((-1.9, 0.54), text(size: 7pt)[$y_0$], anchor: "east")

      line((-0.9, 0.55), (-1.35, 0.55), stroke: 0.4pt)
      line((-1.2, 0), (-1.2, 0.55), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((-1.3, 0.28), text(size: 7pt)[$y$], anchor: "east")

      line((-0.9, -1.6), (-0.9, -2.2), stroke: 0.4pt)
      line((0.9, -1.6), (0.9, -2.2), stroke: 0.4pt)
      line((-0.9, -2.05), (0.9, -2.05), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((0, -2.0), text(size: 7pt)[$b$], anchor: "south")

      // Diagramma parabolico laterale (base a x = 2.2, vertice a x = 3.5)
      line((0.9, 1.6), (2.2, 1.6), stroke: 0.4pt)
      line((0.9, -1.6), (2.2, -1.6), stroke: 0.4pt)
      line((2.2, -1.6), (2.2, 1.6), stroke: 0.6pt)
      bezier((2.2, 1.6), (3.5, 0), (2.85, 1.2), (3.5, 0.55), stroke: 0.8pt)
      bezier((3.5, 0), (2.2, -1.6), (3.5, -0.55), (2.85, -1.2), stroke: 0.8pt)

      // Linee campitura orizzontali nel diagramma parabolico e vettori
      line((2.2, 1.2), (2.77, 1.2), stroke: 0.4pt)
      line((2.2, 0.85), (3.12, 0.85), stroke: 0.4pt)
      line((2.2, 0.55), (3.34, 0.55), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 1.2pt))
      content((2.75, 0.62), text(size: 7pt)[$tau_(x y)$], anchor: "south")

      line((2.2, 0), (3.5, 0), mark: (end: ">"), stroke: (paint: red, thickness: 1.4pt))
      content((2.85, 0.08), text(size: 7pt, fill: red)[$tau_(x y, "max")$], anchor: "south")

      line((2.2, -0.55), (3.34, -0.55), stroke: 0.4pt)
      line((2.2, -0.85), (3.12, -0.85), stroke: 0.4pt)
      line((2.2, -1.2), (2.77, -1.2), stroke: 0.4pt)
    })
  ]
)
#v(1em)

=== Trave a sezione circolare

Nel caso di una trave a sezione circolare piena di raggio $R$, la larghezza della corda $b(y) = 2 sqrt(R^2 - y^2)$ non è costante ma varia in funzione dell'ordinata $y$:

$ tau_(x y)(y) = (T_y S_z(y)) / (I_z b(y)) $

Per la sezione circolare di raggio $R$, il momento d'inerzia polare $I_P$ si calcola integrando su corone circolari infinitesime di raggio $r$ e spessore $d r$ ($d A = 2 pi r d r$):

$ I_P = integral_A r^2 d A = integral_0^R r^2 2 pi r d r = (pi R^4) / 2 $

In virtù dell'assialsimmetria della sezione ($I_P = I_z + I_y$ con $I_z = I_y$), i momenti d'inerzia assiali baricentrici valgono:

$ I_z = I_y = I_P / 2 = (pi R^4) / 4 $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Passando in coordinate polari ($y = r sin vartheta$, $d A = r d vartheta d r$), il momento statico rispetto all'asse $z$ si esprime come:

    $ S_z(y) = integral_(A^*) y d A = integral_r integral_vartheta r sin vartheta (r d vartheta d r) $

    Il momento statico raggiunge il valore massimo $S_(z, "max")$ in corrispondenza del semicerchio superiore delimitato dall'asse diametrale $z$ ($y = 0$, ossia per $r in [0, R]$ e $vartheta in [0, pi]$):

    $ S_(z, "max") = integral_0^R integral_0^pi r^2 sin vartheta d vartheta d r = [-cos vartheta]_0^pi integral_0^R r^2 d r = 2 R^3 / 3 $

    Sostituendo $S_(z, "max")$, $I_z = (pi R^4) / 4$ e la larghezza diametrale $b(0) = 2 R$ nella formula di Jourawski, si ricava la tensione tangenziale massima sull'asse neutro $z$:

    $ tau_(x y, "max") = (T_y 2 / 3 R^3) / ((pi R^4) / 4 2 R) = 4 / 3 T_y / (pi R^2) = 4 / 3 tau_m $
  ],
  [
    #canvas(length: 0.85cm, {
      import draw: *
      // --- PANNELLO SINISTRO: Sezione circolare intera (centro (-1.8, 0), R = 1.35) ---
      circle((-1.8, 0), radius: 1.35, stroke: 1.1pt)
      circle((-1.8, 0), radius: 0.65, stroke: 0.6pt)
      circle((-1.8, 0), radius: 0.48, stroke: 0.6pt)

      line((-3.5, 0), (-0.1, 0), stroke: 0.6pt)
      line((-1.8, -1.65), (-1.8, 1.85), stroke: 0.6pt)
      content((-3.55, 0), text(size: 7pt)[$z$], anchor: "east")
      content((-1.65, 1.8), text(size: 7pt)[$y$], anchor: "west")
      content((-1.68, -0.22), text(size: 7pt)[$O$])

      // Raggio r e spessore dr
      line((-1.8, 0), (-1.46, 0.34), mark: (end: ">"), stroke: 0.8pt)
      content((-1.72, 0.22), text(size: 7pt)[$r$])
      line((-0.7, 1.1), (-1.34, 0.46), mark: (end: ">"), stroke: 0.8pt)
      content((-1.42, 0.68), text(size: 7pt)[$d r$])

      // --- PANNELLO DESTRO: Semicerchio superiore per S_z,max (centro (1.8, -0.35), R = 1.35) ---
      arc((1.8, -0.35), start: 0deg, stop: 180deg, radius: 1.35, anchor: "origin", stroke: 1.1pt)
      arc((1.8, -0.35), start: 0deg, stop: 180deg, radius: 0.65, anchor: "origin", stroke: 0.6pt)
      arc((1.8, -0.35), start: 0deg, stop: 180deg, radius: 0.48, anchor: "origin", stroke: 0.6pt)

      line((0.2, -0.35), (3.4, -0.35), stroke: 0.6pt)
      line((1.8, -0.55), (1.8, 1.55), stroke: 0.6pt)
      content((1.95, 1.5), text(size: 7pt)[$y$], anchor: "west")

      line((1.8, -0.35), (2.14, -0.01), mark: (end: ">"), stroke: 0.8pt)
      content((1.88, -0.12), text(size: 7pt)[$r$])
      line((2.9, 0.75), (2.26, 0.11), mark: (end: ">"), stroke: 0.8pt)
      content((2.18, 0.33), text(size: 7pt)[$d r$])
    })
  ]
)
#v(1em)

== Taglio in travi a sezione sottile

=== Sezione a doppio T: canalizzazione del flusso tangenziale

Un caso applicativo di fondamentale rilevanza ingegneristica è rappresentato dalla trave a sezione sottile a doppio $T$ (o a $I$), avente larghezza delle ali $b$ e spessore di parete $s$ molto minore di $b$ ($s lt.double b$).

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    In virtù dell'analogia idrodinamica, il flusso delle tensioni tangenziali $tau$ di taglio può essere assimilato a una corrente fluida incompressibile canalizzata entro le pareti sottili del profilato, la cui portata deve mantenersi continua anche in presenza di brusche variazioni geometriche o deviazioni ad angolo retto della parete.

    Poiché la sezione è in parete sottile ($s lt.double b$), nelle quattro mezze ali orizzontali le componenti verticali $tau_(x y)$ risultano trascurabili (avendo corda orizzontale $b$ molto ampia e spessore verticale $s$ esiguo), mentre nascono rilevanti tensioni tangenziali orizzontali $tau_(x z)$ dirette lungo l'asse mediano delle ali, le quali confluiscono dall'ala superiore verso l'anima verticale (dove agiscono le $tau_(x y)$) e si ridistribuiscono simmetricamente nelle due semiali inferiori.
  ],
  [
    #canvas(length: 0.82cm, {
      import draw: *
      // Sezione a doppio T sottile (centro (-1.2, 0))
      line((-3.0, -1.6), (0.6, -1.6), (0.6, -1.35), (-1.08, -1.35), (-1.08, 1.35), (0.6, 1.35), (0.6, 1.6), (-3.0, 1.6), (-3.0, 1.35), (-1.32, 1.35), (-1.32, -1.35), (-3.0, -1.35), close: true, stroke: 1.3pt)

      // Assi
      line((0.1, 0), (-2.9, 0), mark: (end: ">"), stroke: 0.6pt)
      content((-2.85, -0.18), text(size: 7pt)[$z$], anchor: "north")
      line((-1.2, -1.7), (-1.2, 2.05), mark: (end: ">"), stroke: 0.6pt)
      content((-1.05, 1.95), text(size: 7pt)[$y$], anchor: "west")
      content((-0.95, 0.18), text(size: 7pt)[$G$])

      // Quote b e s
      line((-3.0, 1.6), (-3.0, 2.35), stroke: 0.4pt)
      line((0.6, 1.6), (0.6, 2.35), stroke: 0.4pt)
      line((-3.0, 2.2), (0.6, 2.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((-1.2, 2.25), text(size: 7pt)[$b$], anchor: "south")

      line((0.6, 1.6), (1.0, 1.6), stroke: 0.4pt)
      line((0.6, 1.35), (1.0, 1.35), stroke: 0.4pt)
      line((0.8, 1.35), (0.8, 1.6), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((0.95, 1.48), text(size: 7pt)[$s$], anchor: "west")

      line((-1.32, 0.85), (-1.08, 0.85), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((-0.98, 0.85), text(size: 7pt)[$s$], anchor: "west")

      // Frecce flussi nelle ali (tau_xz) e nell'anima (tau_xy)
      line((-2.7, 1.48), (-1.6, 1.48), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.6pt))
      line((0.3, 1.48), (-0.8, 1.48), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.6pt))
      content((-2.3, 1.05), text(size: 7pt)[$tau_(x z)$])
      content((-0.1, 1.05), text(size: 7pt)[$tau_(x z)$])

      line((-1.25, -0.3), (-1.25, -0.95), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      line((-1.15, -0.3), (-1.15, -0.95), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.5pt))
      content((-1.65, -0.65), text(size: 7pt)[$tau_(x y)$])

      line((-1.6, -1.48), (-2.7, -1.48), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.6pt))
      line((-0.8, -1.48), (0.3, -1.48), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.6pt))
      content((-2.3, -1.1), text(size: 7pt)[$tau_(x z)$])
      content((-0.1, -1.1), text(size: 7pt)[$tau_(x z)$])

      line((-1.2, -1.65), (-1.2, -2.35), mark: (end: ">"), stroke: 1.8pt)
      content((-1.0, -2.2), text(size: 7pt)[$T_y$], anchor: "west")

      // Ellisse rossa tratteggiata sulla semiala inferiore destra e ingrandimento a destra
      circle((-0.1, -1.48), radius: (0.85, 0.35), stroke: (paint: red, dash: "dashed", thickness: 0.7pt))
      line((0.65, -1.3), (1.15, -0.75), mark: (end: ">"), stroke: (paint: red, thickness: 0.6pt))

      // Ingrandimento nodo ala-anima inferiore destra
      line((1.0, 0.65), (1.0, -0.15), (2.7, -0.15), (2.7, -0.55), stroke: 1.2pt)
      circle((2.0, -0.35), radius: (1.25, 0.55), stroke: (paint: red, dash: "dashed", thickness: 0.7pt))

      line((0.85, 0.8), (0.85, -0.1), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 1.3pt))
      content((1.08, 0.55), text(size: 7pt)[$tau_(x y)$], anchor: "west")

      line((1.1, -0.3), (2.4, -0.3), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 1.2pt))
      content((1.8, -0.65), text(size: 7pt)[$tau_(x z)$])

      line((2.55, -0.25), (2.55, -0.55), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.6pt))
      content((2.8, -0.45), text(size: 7pt)[$tau_(x y)$], anchor: "west")
    })
  ]
)
#v(1em)


// === Blocco_04_Slide_46-60 ===

=== Conservazione del flusso delle tensioni tangenziali nei nodi

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Affinché sia garantita la conservazione del flusso delle tensioni tangenziali di taglio in corrispondenza del nodo strutturale in cui convergono i tre elementi sottili di spessore $b_1, b_2, b_3$, deve essere soddisfatta l'equazione di bilancio tra flussi entranti e flussi uscenti:

    $ sum (tau dot b)_"in" = sum (tau dot b)_"out" $

    Poiché la tensione $tau_2$ agente nell'anima verticale è concorde con il verso dello sforzo di taglio esterno $T_y$, il flusso associato $tau_2 b_2$ risulta uscente dal nodo; per simmetria e continuità, gli altri due flussi provenienti dalle semiali ($tau_1 b_1$ e $tau_3 b_3$) devono essere entranti nel nodo.

    Assumendo per convenzione positivi i flussi uscenti dal nodo e negativi quelli entranti, la condizione di conservazione al nodo si scrive:

    $ -tau_1 b_1 + tau_2 b_2 - tau_3 b_3 = 0 $
  ],
  [
    #canvas(length: 0.85cm, {
      import draw: *
      // Nodo tridimensionale a T con spessori b1, b2, b3
      // Ala superiore inclinata in assonometria
      line((-2.0, -0.3), (1.8, 1.6), stroke: 0.9pt)
      line((-1.8, -1.0), (-0.3, -0.25), stroke: 0.9pt)
      line((0.3, 0.05), (1.9, 0.85), stroke: 0.9pt)

      // Spigoli di profondita' assonometrica
      line((-2.0, -0.3), (-2.7, 0.15), stroke: 0.6pt)
      line((-1.8, -1.0), (-2.5, -0.55), stroke: 0.6pt)
      line((1.8, 1.6), (1.1, 2.05), stroke: 0.6pt)
      line((-0.3, -2.5), (-0.95, -2.1), stroke: 0.6pt)

      // Anima verticale di spessore b2
      line((-0.3, -0.25), (-0.3, -2.5), stroke: 0.9pt)
      line((0.3, 0.05), (0.3, -2.25), stroke: 0.9pt)

      // Linee di frattura sui tre rami
      bezier((-2.0, -0.3), (-1.8, -1.0), (-2.1, -0.55), (-1.7, -0.75), stroke: 0.7pt)
      bezier((1.8, 1.6), (1.9, 0.85), (1.65, 1.35), (2.0, 1.1), stroke: 0.7pt)
      bezier((-0.3, -2.5), (0.3, -2.25), (-0.1, -2.55), (0.1, -2.2), stroke: 0.7pt)

      // Cerchio rosso sul nodo di convergenza
      circle((0, 0.35), radius: 0.78, stroke: (paint: red, thickness: 1.4pt))

      // Frecce blu tau_1 (entranti da sinistra)
      line((-2.0, -0.45), (-1.45, -0.18), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 1.2pt))
      line((-1.93, -0.65), (-1.38, -0.38), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 1.2pt))
      line((-1.86, -0.85), (-1.31, -0.58), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 1.2pt))
      content((-2.15, -0.55), text(size: 7pt)[$b_1$], anchor: "east")
      content((-1.15, -0.25), text(size: 7pt)[$tau_1$])

      // Frecce blu tau_3 (entranti da destra)
      line((1.85, 1.45), (1.3, 1.18), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 1.2pt))
      line((1.90, 1.22), (1.35, 0.95), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 1.2pt))
      line((1.95, 0.98), (1.4, 0.71), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 1.2pt))
      content((2.15, 1.25), text(size: 7pt)[$b_3$], anchor: "west")
      content((1.05, 0.85), text(size: 7pt)[$tau_3$])

      // Frecce blu tau_2 (uscenti in basso) e vettore Ty
      line((0.05, -0.55), (0.05, -1.65), mark: (end: ">"), stroke: 1.8pt)
      content((0.25, -1.25), text(size: 7pt)[$T_y$], anchor: "west")
      content((0.0, -2.05), text(size: 7pt)[$b_2$])

      line((-0.22, -2.48), (-0.22, -3.05), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 1.2pt))
      line((0.0, -2.40), (0.0, -2.97), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 1.2pt))
      line((0.22, -2.30), (0.22, -2.87), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 1.2pt))
      content((0.45, -2.65), text(size: 7pt)[$tau_2$], anchor: "west")
    })
  ]
)
#v(1em)

== Confronto applicativo: sezione spessa vs sezione sottile (profilo HEB 200)

Si consideri una trave con sezione a doppio $T$ unificata *HEB 200* (altezza totale $h = 200 "mm"$, larghezza delle ali $b = 200 "mm"$, spessore delle ali $s = 15 "mm"$, spessore dell'anima $b' = 9 "mm"$, altezza netta dell'anima $170 "mm"$), soggetta a uno sforzo di taglio verticale $T_y = 100 "kN" = 100 thin 000 "N"$. Si vuole analizzare come varia la distribuzione delle tensioni tangenziali di taglio sulla sezione adottando l'ipotesi di sezione spessa oppure l'ipotesi di sezione sottile.

I parametri geometrici complessivi della sezione trasversale valgono:
- area totale della sezione: $A = 2 dot (200 dot 15) + 170 dot 9 = 7530 "mm"^2$;
- momento d'inerzia baricentrico rispetto all'asse $z$ (somma dei contributi dell'anima centrale e delle due ali superiore e inferiore): $I_z = 55 thin 134 thin 750 "mm"^4$.

=== Ipotesi 1: Modello di sezione spessa

Assumendo la sezione come spessa, si considerano unicamente le tensioni tangenziali verticali $tau_(x y)(y)$ sia nell'anima centrale sia nelle ali, trascurando le componenti orizzontali $tau_(x z)$:

$ tau_(x y)(y) = (T_y S_z(y)) / (I_z b(y)) $

dove la larghezza della corda orizzontale $b(y)$ varia con l'ordinata $y$ come una funzione costante a tratti ($b = 200 "mm"$ nelle ali, $b' = 9 "mm"$ nell'anima).

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    1. *Bordo inferiore dell'ala superiore (corda rossa $a$, $b = 200 "mm"$)*:
       Il momento statico dell'intera ala superiore rispetto all'asse baricentrico $z$ (con baricentro dell'ala a quota $d_"ala" = 100 - 15 / 2 = 92.5 "mm"$) vale:
       $ S_z = A_"ala" d_"ala" = (200 dot 15) dot 92.5 = 277 thin 500 "mm"^3 $
       La tensione tangenziale sulla corda $a$ dell'ala superiore risulta:
       $ tau_(x y, a) = (100 thin 000 dot 277 thin 500) / (55 thin 134 thin 750 dot 200) = 2.5 "MPa" $

    2. *Attacco superiore dell'anima verticale (corda arancione $b$, $b' = 9 "mm"$)*:
       A parità di momento statico $S_z = 277 thin 500 "mm"^3$, il restringimento della corda da $200 "mm"$ a $9 "mm"$ innalza la tensione a:
       $ tau_(x y, b) = (100 thin 000 dot 277 thin 500) / (55 thin 134 thin 750 dot 9) = 55.9 "MPa" $

    3. *Baricentro della sezione (corda blu $c$ sull'asse $z$, $b' = 9 "mm"$)*:
       Scendendo fino a $y = 0$, si somma il momento statico della semianima superiore di altezza $170 / 2 = 85 "mm"$:
       $ S_(z, "max") = 277 thin 500 + (85 dot 9) dot 85 / 2 = 277 thin 500 + 36 thin 125 = 313 thin 625 "mm"^3 $
       La tensione tangenziale massima al centro dell'anima vale:
       $ tau_(x y, c) = (100 thin 000 dot 313 thin 625) / (55 thin 134 thin 750 dot 9) = 62.5 "MPa" $
  ],
  [
    #canvas(length: 0.76cm, {
      import draw: *
      // --- PANNELLO SINISTRO: Sezione HEB 200 con corde a, b, c (centro (-1.5, 0)) ---
      line((-3.0, -1.6), (0.0, -1.6), (0.0, -1.35), (-1.42, -1.35), (-1.42, 1.35), (0.0, 1.35), (0.0, 1.6), (-3.0, 1.6), (-3.0, 1.35), (-1.58, 1.35), (-1.58, -1.35), (-3.0, -1.35), close: true, stroke: 1.1pt)

      // Tratteggio ala superiore e semianima superiore
      line((-2.8, 1.35), (-2.6, 1.6), stroke: 0.4pt)
      line((-2.3, 1.35), (-2.1, 1.6), stroke: 0.4pt)
      line((-1.8, 1.35), (-1.6, 1.6), stroke: 0.4pt)
      line((-1.3, 1.35), (-1.1, 1.6), stroke: 0.4pt)
      line((-0.8, 1.35), (-0.6, 1.6), stroke: 0.4pt)
      line((-0.3, 1.35), (-0.1, 1.6), stroke: 0.4pt)
      line((-1.58, 0.25), (-1.42, 0.45), stroke: 0.4pt)
      line((-1.58, 0.65), (-1.42, 0.85), stroke: 0.4pt)
      line((-1.58, 1.05), (-1.42, 1.25), stroke: 0.4pt)

      // Corde: rossa (a), arancione (b), blu (c)
      line((-3.0, 1.35), (0.0, 1.35), stroke: (paint: red, thickness: 1.5pt))
      line((-1.58, 1.30), (-1.42, 1.30), stroke: (paint: orange, thickness: 1.6pt))
      line((-1.58, 0), (-1.42, 0), stroke: (paint: blue, thickness: 1.6pt))

      content((0.1, 1.15), text(size: 7pt)[$tau_(x y, a)$], anchor: "west")
      content((-1.32, 0.95), text(size: 7pt)[$tau_(x y, b)$], anchor: "west")
      content((-1.32, -0.35), text(size: 7pt)[$tau_(x y, c)$], anchor: "west")

      // Assi e quote
      line((-1.5, 0), (-2.8, 0), mark: (end: ">"), stroke: 0.6pt)
      content((-2.75, -0.2), text(size: 7pt)[$z$], anchor: "north")
      line((-1.5, 0), (-1.5, 2.05), mark: (end: ">"), stroke: 0.6pt)
      content((-1.35, 2.0), text(size: 7pt)[$y$], anchor: "west")

      // Quote 200, 170, 9, 15, 200
      line((-3.0, 1.6), (-3.85, 1.6), stroke: 0.4pt)
      line((-3.0, -1.6), (-3.85, -1.6), stroke: 0.4pt)
      line((-3.7, -1.6), (-3.7, 1.6), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((-3.75, 0.25), text(size: 7pt)[200], anchor: "east")

      line((-3.25, -1.35), (-3.25, 1.35), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((-3.3, -0.35), text(size: 7pt)[170], anchor: "east")

      line((-1.85, 0), (-1.58, 0), mark: (end: ">"), stroke: 0.5pt)
      line((-1.15, 0), (-1.42, 0), mark: (end: ">"), stroke: 0.5pt)
      content((-1.1, 0), text(size: 7pt)[9], anchor: "west")

      line((0.0, -1.6), (0.55, -1.6), stroke: 0.4pt)
      line((0.0, -1.35), (0.55, -1.35), stroke: 0.4pt)
      line((0.4, -1.6), (0.4, -1.35), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((0.5, -1.48), text(size: 7pt)[15], anchor: "west")

      line((-3.0, -1.6), (-3.0, -2.05), stroke: 0.4pt)
      line((0.0, -1.6), (0.0, -2.05), stroke: 0.4pt)
      line((-3.0, -1.9), (0.0, -1.9), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((-1.5, -1.88), text(size: 7pt)[200], anchor: "south")

      line((-1.5, -2.15), (-1.5, -2.85), mark: (end: ">"), stroke: 1.6pt)
      content((-1.3, -2.65), text(size: 7pt)[$T_y$], anchor: "west")

      // --- PANNELLO DESTRO: Diagramma parabolico a salto (base a x = 1.4) ---
      line((0.0, 1.6), (1.4, 1.6), stroke: (dash: "dashed", thickness: 0.4pt))
      line((0.0, 1.35), (1.4, 1.35), stroke: (dash: "dashed", thickness: 0.4pt))
      line((-1.5, 0), (3.5, 0), stroke: (dash: "dashed", thickness: 0.4pt))
      line((0.0, -1.35), (1.4, -1.35), stroke: (dash: "dashed", thickness: 0.4pt))
      line((0.0, -1.6), (1.4, -1.6), stroke: (dash: "dashed", thickness: 0.4pt))

      // Piccoli lobi sulle ali (da 0 a 2.5 MPa -> x da 1.4 a 1.48)
      line((1.4, 1.6), (1.48, 1.35), (1.4, 1.35), close: true, fill: luma(195), stroke: 0.6pt)
      line((1.4, -1.35), (1.48, -1.35), (1.4, -1.6), close: true, fill: luma(195), stroke: 0.6pt)

      // Diagramma nell'anima (da 55.9 MPa a x = 3.05 fino a 62.5 MPa a x = 3.25)
      line((1.4, 1.35), (3.05, 1.35), stroke: 0.7pt)
      line((1.4, -1.35), (3.05, -1.35), stroke: 0.7pt)
      line((1.4, -1.35), (1.4, 1.35), stroke: 0.7pt)
      bezier((3.05, 1.35), (3.25, 0), (3.18, 0.9), (3.25, 0.45), stroke: 0.8pt)
      bezier((3.25, 0), (3.05, -1.35), (3.25, -0.45), (3.18, -0.9), stroke: 0.8pt)

      // Tratteggio orizzontale interno al diagramma
      line((1.4, 1.0), (3.13, 1.0), stroke: 0.4pt)
      line((1.4, 0.65), (3.20, 0.65), stroke: 0.4pt)
      line((1.4, 0.32), (3.24, 0.32), stroke: 0.4pt)
      line((1.4, 0.0), (3.25, 0.0), stroke: 0.4pt)
      line((1.4, -0.32), (3.24, -0.32), stroke: 0.4pt)
      line((1.4, -0.65), (3.20, -0.65), stroke: 0.4pt)
      line((1.4, -1.0), (3.13, -1.0), stroke: 0.4pt)

      // Etichette valori numerici
      line((1.48, 1.35), (1.85, 1.65), mark: (end: ">"), stroke: 0.5pt)
      content((1.9, 1.7), text(size: 7pt)[$tau_(x y, a) = 2.5 "MPa"$], anchor: "west")

      line((3.05, 1.35), (3.4, 1.65), mark: (end: ">"), stroke: 0.5pt)
      content((3.45, 1.7), text(size: 7pt)[$tau_(x y, b) = 55.9 "MPa"$], anchor: "west")

      line((3.25, 0), (3.6, -0.3), mark: (end: ">"), stroke: 0.5pt)
      content((3.65, -0.35), text(size: 7pt)[$tau_(x y, c) = 62.5 "MPa"$], anchor: "west")
    })
  ]
)
#v(1em)

=== Ipotesi 2: Modello di sezione sottile

Considerando ora il profilato HEB 200 come una sezione in parete sottile, le tensioni tangenziali orizzontali $tau_(x z)$ lungo le ali non sono più trascurabili.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Introducendo l'ascissa locale $xi$ misurata a partire dal bordo libero esterno della semiala superiore ($0 <= xi <= 100 "mm"$), l'area isolata dalla corda verticale rossa di spessore $s = 15 "mm"$ vale $A^*(xi) = xi s$. Poiché il baricentro di tale porzione cade sempre sulla linea media dell'ala, posta a distanza costante $h / 2 - s / 2 = 100 - 7.5 = 92.5 "mm"$ dall'asse neutro $z$, il momento statico $S_z(xi)$ varia linearmente con $xi$:

    $ S_z(xi) = xi s (h / 2 - s / 2) $

    Di conseguenza, anche la tensione tangenziale $tau_(x z)(xi)$ presenta un andamento lineare lungo ciascuna semiala:

    $ tau_(x z)(xi) = (T_y S_z(xi)) / (I_z s) = (T_y xi) / I_z (h / 2 - s / 2) $

    Per un'intera semiala superiore ($xi = 100 "mm"$), il momento statico rispetto all'asse $z$ vale:

    $ S_z = (100 dot 15) dot 92.5 = 1500 dot 92.5 = 138 thin 750 "mm"^3 $

    e la tensione tangenziale massima nell'ala (in prossimità dell'innesto con l'anima) raggiunge il valore:

    $ tau_(x z, "max") = (100 thin 000 dot 138 thin 750) / (55 thin 134 thin 750 dot 15) = 16.8 "MPa" $
  ],
  [
    #canvas(length: 0.85cm, {
      import draw: *
      // Sezione HEB 200 per calcolo sottile con coordinata xi (centro (0, 0))
      line((-1.6, -1.6), (1.6, -1.6), (1.6, -1.35), (0.08, -1.35), (0.08, 1.35), (1.6, 1.35), (1.6, 1.6), (-1.6, 1.6), (-1.6, 1.35), (-0.08, 1.35), (-0.08, -1.35), (-1.6, -1.35), close: true, stroke: 1.1pt)

      // Porzione di semiala tratteggiata di lunghezza xi (da x = -1.6 a -0.45) e corda verticale rossa
      line((-1.4, 1.35), (-1.2, 1.6), stroke: 0.4pt)
      line((-1.0, 1.35), (-0.8, 1.6), stroke: 0.4pt)
      line((-0.6, 1.35), (-0.45, 1.55), stroke: 0.4pt)
      line((-0.45, 1.35), (-0.45, 1.6), stroke: (paint: red, thickness: 1.6pt))

      // Frecce flusso tau_xz nell'ala superiore sinistra
      line((-1.45, 1.48), (-1.15, 1.48), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.6pt))
      line((-0.95, 1.48), (-0.65, 1.48), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.6pt))
      line((-0.35, 1.48), (-0.05, 1.48), mark: (end: ">"), stroke: (paint: rgb("#2b6cb0"), thickness: 0.6pt))
      content((-0.45, 1.25), text(size: 7pt)[$tau_(x z)$], anchor: "north")

      // Quota xi
      line((-1.6, 1.6), (-1.6, 2.05), stroke: 0.4pt)
      line((-0.45, 1.6), (-0.45, 2.05), stroke: 0.4pt)
      line((-1.6, 1.9), (-0.45, 1.9), mark: (end: ">"), stroke: 0.6pt)
      content((-1.02, 1.95), text(size: 7pt)[$xi$], anchor: "south")

      // Quota spessore s a sinistra
      line((-1.6, 1.6), (-2.55, 1.6), stroke: 0.4pt)
      line((-1.6, 1.35), (-2.55, 1.35), stroke: 0.4pt)
      line((-2.4, 1.85), (-2.4, 1.6), mark: (end: ">"), stroke: 0.5pt)
      line((-2.4, 1.1), (-2.4, 1.35), mark: (end: ">"), stroke: 0.5pt)
      content((-2.5, 1.48), text(size: 7pt)[$s$], anchor: "east")

      // Quota braccio h/2 - s/2 = 92.5 mm a destra
      line((0, 1.48), (2.25, 1.48), stroke: 0.4pt)
      line((0, 0), (2.25, 0), stroke: 0.4pt)
      line((2.1, 0), (2.1, 1.48), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((2.0, 0.74), text(size: 7pt)[$h / 2 - s / 2 = 92.5$], anchor: "east")

      // Assi e quote principali
      line((0, 0), (-1.35, 0), mark: (end: ">"), stroke: 0.6pt)
      content((-1.3, -0.18), text(size: 7pt)[$z$], anchor: "north")
      line((0, 0), (0, 2.05), mark: (end: ">"), stroke: 0.6pt)
      content((0.15, 2.0), text(size: 7pt)[$y$], anchor: "west")

      line((-1.6, -1.6), (-2.1, -1.6), stroke: 0.4pt)
      line((-1.95, -1.6), (-1.95, 1.6), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((-2.0, 0), text(size: 7pt)[200], anchor: "east")

      line((-1.6, -1.9), (1.6, -1.9), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((0, -1.88), text(size: 7pt)[200], anchor: "south")

      line((0, -2.15), (0, -2.85), mark: (end: ">"), stroke: 1.6pt)
      content((0.2, -2.65), text(size: 7pt)[$T_y$], anchor: "west")
    })
  ]
)
#v(1em)

Lungo l'anima verticale, dove confluiscono i contributi di entrambe le semiali superiori ($2 dot 138 thin 750 = 277 thin 500 "mm"^3$), l'andamento della tensione tangenziale verticale $tau_(x y)$ rimane identico a quello calcolato per la sezione spessa, variando parabolicamente da $tau_(x y, b) = 55.9 "MPa"$ fino al picco baricentrico $tau_(x y, c) = 62.5 "MPa"$.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Si riassumono in tabella i valori caratteristici per il modello di sezione sottile:

    #align(center)[
      #table(
        columns: 2,
        align: center + horizon,
        table.header([*Componente di tensione*], [*Valore ($"MPa"$)*]),
        table.hline(),
        [$tau_(x z)$ (massima nell'ala)], [$16.8$],
        [$tau_(x y, b)$ (attacco anima)], [$55.9$],
        [$tau_(x y, c)$ (centro anima)], [$62.5$],
      )
    ]

    #nota[
      *Confronto tra i due modelli*:
      La differenza sostanziale tra i due approcci si manifesta nelle ali della sezione: la tensione tangenziale massima $tau_(x z) = 16.8 "MPa"$ calcolata con il modello a parete sottile è oltre sei volte superiore rispetto alla tensione verticale $tau_(x y, a) = 2.5 "MPa"$ fornita dal modello di sezione spessa. Il modello a *sezione sottile* risulta pertanto nettamente più realistico e cautelativo per la verifica delle ali (fermo restando che entrambi costituiscono modelli analitici di prima approssimazione e che un'analisi locale rigorosa dei raccordi ala-anima richiede metodi numerici agli elementi finiti, FEM).
    ]
  ],
  [
    #canvas(length: 0.78cm, {
      import draw: *
      // Sezione HEB 200 sottile con diagrammi completi sulle ali e sull'anima + frecce rosse di flusso
      line((-2.6, -1.5), (0.2, -1.5), (0.2, -1.25), (-1.12, -1.25), (-1.12, 1.25), (0.2, 1.25), (0.2, 1.5), (-2.6, 1.5), (-2.6, 1.25), (-1.28, 1.25), (-1.28, -1.25), (-2.6, -1.25), close: true, stroke: 1.2pt)

      // Frecce rosse spesse del flusso interno alle ali e all'anima
      line((-2.3, 1.38), (-1.45, 1.38), mark: (end: ">"), stroke: (paint: red, thickness: 1.5pt))
      line((-0.1, 1.38), (-0.95, 1.38), mark: (end: ">"), stroke: (paint: red, thickness: 1.5pt))
      line((-1.2, 0.85), (-1.2, 0.1), mark: (end: ">"), stroke: (paint: red, thickness: 1.5pt))
      line((-1.45, -1.38), (-2.3, -1.38), mark: (end: ">"), stroke: (paint: red, thickness: 1.5pt))
      line((-0.95, -1.38), (-0.1, -1.38), mark: (end: ">"), stroke: (paint: red, thickness: 1.5pt))

      // Doppio triangolo superiore per tau_xz sull'ala superiore
      line((-2.6, 1.75), (0.2, 1.75), (-1.2, 2.35), close: true, fill: luma(200), stroke: (paint: blue, thickness: 0.9pt))
      line((-2.1, 1.75), (-2.1, 1.96), stroke: 0.4pt)
      line((-1.65, 1.75), (-1.65, 2.15), stroke: 0.4pt)
      line((-1.2, 1.75), (-1.2, 2.35), stroke: 0.4pt)
      line((-0.75, 1.75), (-0.75, 2.15), stroke: 0.4pt)
      line((-0.3, 1.75), (-0.3, 1.96), stroke: 0.4pt)
      line((-1.2, 2.35), (-0.65, 2.35), mark: (end: ">"), stroke: 0.5pt)
      content((-0.6, 2.35), text(size: 7pt)[$tau_(x z) = 16.8 "MPa"$], anchor: "west")

      // Doppio triangolo inferiore per tau_xz sull'ala inferiore
      line((-2.6, -1.75), (0.2, -1.75), (-1.2, -2.35), close: true, fill: luma(200), stroke: (paint: blue, thickness: 0.9pt))
      line((-2.1, -1.75), (-2.1, -1.96), stroke: 0.4pt)
      line((-1.65, -1.75), (-1.65, -2.15), stroke: 0.4pt)
      line((-1.2, -1.75), (-1.2, -2.35), stroke: 0.4pt)
      line((-0.75, -1.75), (-0.75, -2.15), stroke: 0.4pt)
      line((-0.3, -1.75), (-0.3, -1.96), stroke: 0.4pt)

      // Diagramma parabolico laterale sull'anima (base a x = 1.0)
      line((0.2, 1.25), (1.0, 1.25), stroke: (dash: "dashed", thickness: 0.4pt))
      line((-1.2, 0), (3.1, 0), stroke: (dash: "dashed", thickness: 0.4pt))
      line((0.2, -1.25), (1.0, -1.25), stroke: (dash: "dashed", thickness: 0.4pt))

      line((1.0, -1.25), (1.0, 1.25), stroke: 0.7pt)
      line((1.0, 1.25), (2.55, 1.25), stroke: 0.7pt)
      line((1.0, -1.25), (2.55, -1.25), stroke: 0.7pt)
      bezier((2.55, 1.25), (2.78, 0), (2.70, 0.85), (2.78, 0.4), stroke: (paint: blue, thickness: 1.1pt))
      bezier((2.78, 0), (2.55, -1.25), (2.78, -0.4), (2.70, -0.85), stroke: (paint: blue, thickness: 1.1pt))

      line((1.0, 0.9), (2.64, 0.9), stroke: 0.4pt)
      line((1.0, 0.55), (2.72, 0.55), stroke: 0.4pt)
      line((1.0, 0.25), (2.76, 0.25), stroke: 0.4pt)
      line((1.0, 0.0), (2.78, 0.0), stroke: 0.4pt)
      line((1.0, -0.25), (2.76, -0.25), stroke: 0.4pt)
      line((1.0, -0.55), (2.72, -0.55), stroke: 0.4pt)
      line((1.0, -0.9), (2.64, -0.9), stroke: 0.4pt)

      line((2.55, 1.25), (2.9, 1.55), mark: (end: ">"), stroke: 0.5pt)
      content((2.95, 1.6), text(size: 7pt)[$tau_(x y, b) = 55.9 "MPa"$], anchor: "west")

      line((2.78, 0), (3.1, -0.3), mark: (end: ">"), stroke: 0.5pt)
      content((3.15, -0.35), text(size: 7pt)[$tau_(x y, c) = 62.5 "MPa"$], anchor: "west")
    })
  ]
)
#v(1em)

== Centro di taglio-torsione (CTT)

È noto dalla teoria dello sforzo normale che la sollecitazione assiale risulta pura (assenza di flessione) esclusivamente quando la retta d'azione della forza normale $N_x$ passa per il baricentro geometrico $G$ della sezione trasversale; in caso contrario, l'eccentricità del carico genera anche un momento flettente.

Un accoppiamento del tutto analogo sussiste tra sforzo di taglio e momento torcente:
- affinché sulla sezione si abbia *taglio puro* (in assenza di torsione), la retta d'azione della forza di taglio deve necessariamente passare per il *centro di taglio-torsione (CTT)*;
- il CTT di una generica sezione trasversale è pertanto definito come il punto geometrico che disaccoppia l'effetto flesso-tagliante dall'effetto del momento torcente.

#align(center)[
  #canvas(length: 1.52cm, {
    import draw: *
    // --- PANNELLO 1: Sforzo normale baricentrico Nx (x da -5.5 a -2.5) ---
    line((-5.2, -0.4), (-5.2, 1.5), mark: (end: ">"), stroke: 0.6pt)
    content((-5.35, 1.45), text(size: 7pt)[$y$], anchor: "east")
    line((-5.2, -0.4), (-5.85, -0.95), mark: (end: ">"), stroke: 0.6pt)
    content((-5.7, -1.05), text(size: 7pt)[$z$])
    line((-5.2, -0.4), (-1.9, -0.4), mark: (end: ">"), stroke: 0.6pt)
    content((-1.95, -0.15), text(size: 7pt)[$x$])

    // Solido cilindrico generico
    line((-4.85, 0.8), (-2.85, 0.8), stroke: 1.1pt)
    line((-4.85, -1.1), (-2.85, -1.1), stroke: 1.1pt)
    bezier((-4.85, 0.8), (-4.85, -1.1), (-5.5, 0.4), (-5.3, -0.7), stroke: 1.1pt)
    bezier((-2.85, 0.8), (-2.85, -1.1), (-3.5, 0.4), (-3.3, -0.7), stroke: 1.1pt)
    bezier((-2.85, 0.8), (-2.85, -1.1), (-2.2, 0.5), (-2.4, -0.6), stroke: 1.1pt)

    // Elemento dA con sigma_xx e forza Nx in G
    line((-3.05, 0.35), (-2.85, 0.45), (-2.85, 0.65), (-3.05, 0.55), close: true, stroke: 0.5pt)
    line((-2.95, 0.5), (-2.45, 0.5), mark: (end: ">"), stroke: (paint: blue, thickness: 0.8pt))
    content((-2.35, 0.65), text(size: 7pt)[$sigma_(x x)$], anchor: "west")
    content((-3.05, 0.15), text(size: 7pt)[$"d"A$])

    line((-3.05, -0.4), (-2.15, -0.4), mark: (end: ">"), stroke: (paint: red, thickness: 1.6pt))
    content((-3.0, -0.65), text(size: 7pt)[$G$])
    content((-2.15, -0.75), text(size: 7pt, fill: red)[$N_x$])

    // --- PANNELLO 2: Taglio centrato in G = C.T. (centro (0.5, 0)) ---
    rect((-0.4, -1.3), (1.4, 1.3), stroke: 1.2pt)
    line((1.7, 0), (-1.1, 0), mark: (end: ">"), stroke: 0.6pt)
    content((-1.05, -0.2), text(size: 7pt)[$z$], anchor: "north")
    line((0.5, -1.5), (0.5, 1.75), mark: (end: ">"), stroke: 0.6pt)
    content((0.65, 1.7), text(size: 7pt)[$y$], anchor: "west")

    content((0.5, 0.2), text(size: 7pt)[$G = "C.T."$])
    line((0.5, 0), (0.5, -1.15), mark: (end: ">"), stroke: (paint: red, thickness: 1.8pt))
    content((0.35, -0.65), text(size: 7pt, fill: red)[$T_y$], anchor: "east")

    // --- PANNELLO 3: Taglio eccentrico di braccio L e trasporto in G = C.T. (centro (4.2, 0)) ---
    rect((3.3, -1.3), (5.1, 1.3), stroke: 1.2pt)
    line((5.4, 0), (2.6, 0), mark: (end: ">"), stroke: 0.6pt)
    content((2.65, -0.2), text(size: 7pt)[$z$], anchor: "north")
    line((4.2, -1.5), (4.2, 1.75), mark: (end: ">"), stroke: 0.6pt)
    content((4.35, 1.7), text(size: 7pt)[$y$], anchor: "west")

    content((4.2, 0.18), text(size: 7pt)[$G = "C.T."$])

    // Forza Ty eccentrica (rossa) a x = 4.85 e linea d'azione tratteggiata
    line((4.85, 0), (4.85, 1.15), stroke: (paint: red, dash: "dashed", thickness: 0.6pt))
    line((4.85, 0), (4.85, -1.15), mark: (end: ">"), stroke: (paint: red, thickness: 1.8pt))
    content((4.75, -0.85), text(size: 7pt, fill: red)[$T_y$], anchor: "east")

    // Forza Ty trasportata sul C.T. (azzurra)
    line((4.2, 0), (4.2, -1.15), mark: (end: ">"), stroke: (paint: rgb("#3182ce"), thickness: 1.8pt))
    content((4.05, -0.85), text(size: 7pt, fill: rgb("#3182ce"))[$T_y$], anchor: "east")

    // Quota eccentricita' L
    line((4.2, -0.45), (4.85, -0.45), mark: (start: ">", end: ">"), stroke: 0.6pt)
    content((4.52, -0.4), text(size: 7pt)[$L$], anchor: "south")

    // Momento di trasporto Mx = Ty L (arco verde orario)
    arc((4.2, 0.25), start: 35deg, stop: 170deg, radius: 0.48, anchor: "origin", mark: (start: ">"), stroke: (paint: rgb("#1b8a3d"), thickness: 1.8pt))
    content((4.2, 0.98), text(size: 7pt, fill: rgb("#1b8a3d"))[$M_x = T_y L$])
  })
]
#v(0.5em)

Qualora la retta d'azione dello sforzo di taglio $T_y$ non passi per il CTT ma presenti un'eccentricità $L$ rispetto ad esso, il calcolo dello stato tensionale si effettua riducendo il sistema di forze al CTT, ovvero:
1. trasportando la forza di taglio $T_y$ direttamente sul CTT;
2. aggiungendo il *momento torcente di trasporto* $M_x = T_y L$.

Sulla sezione nasceranno pertanto sia tensioni tangenziali $tau$ dovute al taglio centrato $T_y$, sia tensioni tangenziali $tau$ dovute al momento torcente $M_x$, da sommare algebricamente per sovrapposizione degli effetti.

Il centro di taglio-torsione *coincide con il baricentro* $G$ nelle sezioni dotate di due assi di simmetria o di simmetria polare (ad esempio sezioni rettangolari, circolari e a doppio $T$ o a $I$), mentre *non coincide con il baricentro* nelle sezioni prive di doppia simmetria (ad esempio sezioni sottili aperte a $C$ o a $T$).

=== Caso della sezione sottile aperta a C

Un classico esempio strutturale in cui il centro di taglio-torsione non coincide con il baricentro geometrico $G$ (trovandosi all'esterno del profilo stesso, dal lato opposto rispetto alla cavità della $C$) è rappresentato dalla trave a sezione sottile aperta a $C$.

#nota[
  _[Figura nelle slide: dimostrazione sperimentale su tre mensole uguali a sezione sottile a $C$, sollecitate all'estremità libera dallo stesso carico verticale di taglio $T$ applicato in tre posizioni trasversali differenti mediante un braccio rigido collegato all'anima del profilato.]_

  A seconda della posizione della retta d'azione del carico di taglio $T$ rispetto al baricentro $G$ e al centro di taglio-torsione $"CTT"$, si osservano sperimentalmente tre regimi deformativi distinti:
  - *Taglio $T$ applicato lungo il baricentro $G$* (freccia rossa): poiché il carico passa a destra del $"CTT"$, oltre all'inflessione verticale nasce una *torsione oraria* della sezione.
  - *Taglio $T$ applicato lungo il $"CTT"$* (freccia azzurra): la sezione è soggetta a *taglio puro senza alcuna rotazione torsionale* (è visibile unicamente la flessione verticale associata al taglio).
  - *Taglio $T$ applicato oltre il $"CTT"$* (freccia nera, a sinistra del $"CTT"$): l'eccentricità si inverte e nasce una *torsione antioraria* della sezione.
]


// === Blocco_05_Slide_61-71 ===

=== Regole pratiche per l'individuazione del CTT

L'individuazione geometrica immediata della posizione del centro di taglio-torsione $"CTT"$ è agevolata da tre proprietà fondamentali:
1. *Un asse di simmetria*: se la sezione possiede un asse di simmetria (es. sezione a $C$ o a $T$), il $"CTT"$ giace necessariamente su tale asse di simmetria.
2. *Due assi di simmetria*: se la sezione possiede due assi di simmetria (es. sezione a doppio $T$), il $"CTT"$ si trova all'intersezione dei due assi e coincide pertanto con il baricentro geometrico ($text{"CTT"} = G$).
3. *Tratti sottili convergenti in un punto*: se una sezione aperta sottile è costituita da più tratti rettilinei le cui linee medie convergono in un unico nodo (es. sezione a $T$, a $L$ o a croce), il $"CTT"$ coincide con il punto di intersezione delle linee medie dei tratti sottili (poiché i flussi tangenziali interni hanno tutti braccio nullo rispetto a tale polo).

#align(center)[
  #canvas(length: 1.42cm, {
    import draw: *
    // 1. Sezione a C (centro G in (-4.2, 0))
    line((-3.2, -1.2), (-5.2, -1.2), (-5.2, 1.2), (-3.2, 1.2), (-3.2, 1.0), (-5.0, 1.0), (-5.0, -1.0), (-3.2, -1.0), close: true, stroke: 1.2pt)
    line((-3.0, 0), (-5.8, 0), mark: (end: ">"), stroke: 0.6pt)
    line((-5.8, 0), (-6.5, 0), stroke: (dash: "dashed", thickness: 0.6pt))
    line((-4.4, -1.5), (-4.4, 1.7), mark: (end: ">"), stroke: 0.6pt)
    content((-5.75, -0.2), text(size: 7pt)[$z$], anchor: "north")
    content((-4.25, 1.65), text(size: 7pt)[$y$], anchor: "west")
    content((-4.58, 0.2), text(size: 7pt)[$G$])
    circle((-6.15, 0), radius: 0.09, fill: rgb("#2b6cb0"), stroke: none)
    content((-6.15, 0.25), text(size: 7pt)[*CTT*])

    // 2. Sezione a doppio T (centro G in (0, 0))
    line((-1.4, -1.4), (1.4, -1.4), (1.4, -1.18), (0.11, -1.18), (0.11, 1.18), (1.4, 1.18), (1.4, 1.4), (-1.4, 1.4), (-1.4, 1.18), (-0.11, 1.18), (-0.11, -1.18), (-1.4, -1.18), close: true, stroke: 1.2pt)
    line((0.8, 0), (-1.4, 0), mark: (end: ">"), stroke: 0.6pt)
    line((0, -1.6), (0, 1.85), mark: (end: ">"), stroke: 0.6pt)
    content((-1.35, 0.2), text(size: 7pt)[$z$])
    content((0.15, 1.8), text(size: 7pt)[$y$], anchor: "west")
    circle((0, 0), radius: 0.09, fill: rgb("#2b6cb0"), stroke: none)
    content((0.15, 0.2), text(size: 7pt)[*CTT=G*], anchor: "west")

    // 3. Sezione a T rovesciata (centro G in (4.5, -0.75))
    line((3.1, -1.2), (5.9, -1.2), (5.9, -0.98), (4.61, -0.98), (4.61, 1.35), (4.39, 1.35), (4.39, -0.98), (3.1, -0.98), close: true, stroke: 1.2pt)
    line((3.1, -1.09), (5.9, -1.09), stroke: (dash: "dashed", thickness: 0.5pt))
    line((5.5, -0.75), (3.25, -0.75), mark: (end: ">"), stroke: 0.6pt)
    line((4.5, -1.5), (4.5, 1.85), mark: (end: ">"), stroke: 0.6pt)
    content((3.2, -0.55), text(size: 7pt)[$z$])
    content((4.65, 1.8), text(size: 7pt)[$y$], anchor: "west")
    content((4.75, -0.55), text(size: 7pt)[$G$])
    circle((4.5, -1.09), radius: 0.09, fill: rgb("#2b6cb0"), stroke: none)
    content((4.5, -1.38), text(size: 7pt)[*CTT*])
  })
]
#v(0.5em)

=== Determinazione analitica della posizione del CTT

Per determinare analiticamente la posizione del $"CTT"$ (ovvero la sua distanza $d$ dal baricentro $G$) occorre calcolare le forze risultanti delle tensioni tangenziali di taglio agenti nei singoli tratti sottili della sezione e imporre che il momento risultante rispetto a un polo (ad esempio il baricentro $G$) equivalga al momento della forza di taglio esterna $T_y$ applicata direttamente nel $"CTT"$ (condizione di assenza di momento di trasporto).

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Con riferimento a una sezione aperta sottile a $C$ soggetta a taglio verticale $T_y$:
    - sulle due ali orizzontali (superiore e inferiore, poste a distanza $h$ tra le rispettive linee medie) le tensioni tangenziali $tau_(x z)$ hanno verso opposto e generano due forze orizzontali uguali e contrarie di modulo:
      $ T_z = integral_(A_"ala") tau_(x z) d A $
    - sull'anima verticale (la cui linea media dista $d_G$ dal baricentro $G$) le tensioni tangenziali $tau_(x y)$ ammettono come risultante l'intero sforzo di taglio verticale:
      $ T_y = integral_(A_"anima") tau_(x y) d A $

    Scrivendo l'equazione di equivalenza alla rotazione nel piano della sezione rispetto al baricentro $G$, il momento della forza $T_y$ applicata nel $"CTT"$ a distanza $d$ da $G$ deve eguagliare la somma del momento della coppia $T_z h$ generata dalle ali e del momento $T_y d_G$ generato dall'anima:

    $ T_y d = T_z h + T_y d_G => d = T_z / T_y h + d_G $
  ],
  [
    #canvas(length: 0.78cm, {
      import draw: *
      // --- PANNELLO SINISTRO: Tensioni tau_xz e tau_xy sulla C (G in (-1.6, 0)) ---
      line((-0.5, -1.1), (-2.3, -1.1), (-2.3, 1.1), (-0.5, 1.1), (-0.5, 0.92), (-2.12, 0.92), (-2.12, -0.92), (-0.5, -0.92), close: true, stroke: 1.2pt)
      line((-0.6, 0), (-3.6, 0), mark: (end: ">"), stroke: 0.6pt)
      line((-1.6, -1.5), (-1.6, 1.75), mark: (end: ">"), stroke: 0.6pt)
      content((-3.55, -0.2), text(size: 7pt)[$z$], anchor: "north")
      content((-1.75, 1.7), text(size: 7pt)[$y$], anchor: "east")
      content((-1.42, 0.18), text(size: 7pt)[$G$])

      circle((-3.3, 0), radius: 0.08, fill: black, stroke: none)
      content((-3.3, 0.22), text(size: 7pt)[CTT])

      // Forza Ty in G e quota dG
      line((-1.6, 0), (-1.6, -1.25), mark: (end: ">"), stroke: (paint: red, thickness: 1.6pt))
      content((-1.38, -0.25), text(size: 7pt, fill: red)[$T_y$], anchor: "west")
      line((-2.21, -0.6), (-1.6, -0.6), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((-1.9, -0.55), text(size: 7pt)[$d_G$], anchor: "south")

      // Diagrammi triangolari viola tau_xz sulle ali
      line((-0.5, 1.01), (-2.21, 1.65), (-2.21, 1.01), close: true, stroke: (paint: rgb("#6b46c1"), thickness: 0.7pt))
      line((-1.8, 1.01), (-1.8, 1.50), stroke: (paint: rgb("#6b46c1"), thickness: 0.4pt))
      line((-1.35, 1.01), (-1.35, 1.33), stroke: (paint: rgb("#6b46c1"), thickness: 0.4pt))
      line((-0.9, 1.01), (-0.9, 1.16), stroke: (paint: rgb("#6b46c1"), thickness: 0.4pt))
      content((-0.9, 1.45), text(size: 7pt, fill: rgb("#6b46c1"))[$tau_(x z)$])

      line((-0.5, -1.01), (-2.21, -1.65), (-2.21, -1.01), close: true, stroke: (paint: rgb("#6b46c1"), thickness: 0.7pt))
      line((-1.8, -1.01), (-1.8, -1.50), stroke: (paint: rgb("#6b46c1"), thickness: 0.4pt))
      line((-1.35, -1.01), (-1.35, -1.33), stroke: (paint: rgb("#6b46c1"), thickness: 0.4pt))
      line((-0.9, -1.01), (-0.9, -1.16), stroke: (paint: rgb("#6b46c1"), thickness: 0.4pt))
      content((-0.9, -1.45), text(size: 7pt, fill: rgb("#6b46c1"))[$tau_(x z)$])

      // Diagramma parabolico blu tau_xy sull'anima (a sinistra di x = -2.3)
      line((-2.3, 0.92), (-2.85, 0.92), stroke: (paint: blue, thickness: 0.7pt))
      line((-2.3, -0.92), (-2.85, -0.92), stroke: (paint: blue, thickness: 0.7pt))
      bezier((-2.85, 0.92), (-3.05, 0), (-2.98, 0.6), (-3.05, 0.3), stroke: (paint: blue, thickness: 0.8pt))
      bezier((-3.05, 0), (-2.85, -0.92), (-3.05, -0.3), (-2.98, -0.6), stroke: (paint: blue, thickness: 0.8pt))
      line((-2.3, 0.5), (-2.99, 0.5), stroke: (paint: blue, thickness: 0.4pt))
      line((-2.3, 0.0), (-3.05, 0.0), stroke: (paint: blue, thickness: 0.4pt))
      line((-2.3, -0.5), (-2.99, -0.5), stroke: (paint: blue, thickness: 0.4pt))
      content((-3.15, 0.75), text(size: 7pt, fill: blue)[$tau_(x y)$])

      // --- PANNELLO DESTRO: Risultanti Tz, Ty e calcolo di d (G in (2.4, 0)) ---
      line((3.5, -1.1), (1.7, -1.1), (1.7, 1.1), (3.5, 1.1), (3.5, 0.92), (1.88, 0.92), (1.88, -0.92), (3.5, -0.92), close: true, stroke: 1.2pt)
      line((3.4, 0), (0.3, 0), mark: (end: ">"), stroke: 0.6pt)
      line((2.4, -1.75), (2.4, 1.65), mark: (end: ">"), stroke: 0.6pt)
      content((0.35, -0.2), text(size: 7pt)[$z$], anchor: "north")
      content((2.25, 1.6), text(size: 7pt)[$y$], anchor: "east")
      content((2.55, 0.18), text(size: 7pt)[$G$])

      // Punto CTT e forza Ty azzurra applicata nel CTT
      circle((0.65, 0), radius: 0.08, fill: black, stroke: none)
      content((0.65, 0.22), text(size: 7pt)[CTT])
      line((0.65, 0), (0.65, -1.45), mark: (end: ">"), stroke: (paint: rgb("#3182ce"), thickness: 1.8pt))
      content((0.5, -0.75), text(size: 7pt, fill: rgb("#3182ce"))[$T_y$], anchor: "east")

      // Risultante Ty rossa nell'anima e risultanti Tz viola nelle ali
      line((1.79, 0.55), (1.79, -0.65), mark: (end: ">"), stroke: (paint: red, thickness: 1.6pt))
      content((1.65, -0.25), text(size: 7pt, fill: red)[$T_y$], anchor: "east")

      line((3.15, 1.01), (2.05, 1.01), mark: (end: ">"), stroke: (paint: rgb("#6b46c1"), thickness: 1.6pt))
      content((2.7, 1.35), text(size: 7pt, fill: rgb("#6b46c1"))[$T_z$])

      line((2.05, -1.01), (3.15, -1.01), mark: (end: ">"), stroke: (paint: rgb("#6b46c1"), thickness: 1.6pt))
      content((2.7, -1.4), text(size: 7pt, fill: rgb("#6b46c1"))[$T_z$])

      // Quote dG, h e d?
      line((1.79, -0.6), (2.4, -0.6), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((2.1, -0.55), text(size: 7pt)[$d_G$], anchor: "south")

      line((3.5, 1.01), (3.85, 1.01), stroke: (dash: "dashed", thickness: 0.5pt))
      line((3.5, -1.01), (3.85, -1.01), stroke: (dash: "dashed", thickness: 0.5pt))
      line((3.75, -1.01), (3.75, 1.01), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((3.85, 0), text(size: 7pt)[$h$], anchor: "west")

      line((0.65, -1.55), (2.4, -1.55), mark: (start: ">", end: ">"), stroke: 0.6pt)
      content((1.52, -1.50), text(size: 7pt)[$bold(d ?)$], anchor: "south")
    })
  ]
)
#v(1em)

=== Sollecitazione composta di taglio e torsione

Qualora la retta d'azione della forza di taglio $T$ presenti un braccio $L$ non nullo rispetto al centro di taglio-torsione $"CTT"$, la riduzione del carico al $"CTT"$ genera un momento torcente di trasporto $M = T L$. Lo stato tensionale complessivo sulla sezione aperta sottile è pertanto dato dalla sovrapposizione di due regimi distinti:
1. le tensioni tangenziali di *taglio puro* (in blu), costanti lungo lo spessore $s$ della parete e dirette lungo la linea media;
2. le tensioni tangenziali di *torsione* alla Saint-Venant per sezioni sottili aperte (in verde), le quali variano linearmente lungo lo spessore $s$ annullandosi sulla linea media e invertendo il proprio verso tra lembo interno e lembo esterno di ciascun tratto rettangolare.

#align(center)[
  #canvas(length: 1.78cm, {
    import draw: *
    // 1. Riduzione del carico T al CTT a sinistra (x da -5.8 a -4.2)
    line((-5.8, 0), (-3.2, 0), stroke: (dash: "dashed", thickness: 0.5pt))
    circle((-4.6, 0), radius: 0.08, fill: black, stroke: none)
    content((-4.6, 0.22), text(size: 7pt)[CTT])

    // Forza T rossa eccentrica e forza T azzurra sul CTT
    line((-5.5, 0), (-5.5, -1.2), mark: (end: ">"), stroke: (paint: red, thickness: 1.6pt))
    content((-5.35, -0.65), text(size: 7pt, fill: red)[$T$], anchor: "west")
    line((-4.6, 0), (-4.6, -1.2), mark: (end: ">"), stroke: (paint: rgb("#3182ce"), thickness: 1.6pt))
    content((-4.45, -0.65), text(size: 7pt, fill: rgb("#3182ce"))[$T$], anchor: "west")

    line((-5.5, -1.35), (-4.6, -1.35), mark: (start: ">", end: ">"), stroke: 0.5pt)
    content((-5.05, -1.3), text(size: 7pt)[$L$], anchor: "south")

    // Momento M = T L (arco verde antiorario)
    arc((-4.6, 0.05), start: -30deg, stop: 165deg, radius: 0.42, anchor: "origin", mark: (end: ">"), stroke: (paint: rgb("#1b8a3d"), thickness: 1.6pt))
    content((-4.6, 0.72), text(size: 7pt, fill: rgb("#1b8a3d"))[$M = T L$])

    // 2. Sezione a C con flussi di taglio (centro G in (-2.0, 0))
    line((-0.8, -1.05), (-2.8, -1.05), (-2.8, 1.05), (-0.8, 1.05), (-0.8, 0.85), (-2.6, 0.85), (-2.6, -0.85), (-0.8, -0.85), close: true, stroke: 1.1pt)
    line((-0.6, 0), (-3.4, 0), mark: (end: ">"), stroke: 0.5pt)
    line((-2.0, -1.5), (-2.0, 1.6), mark: (end: ">"), stroke: 0.5pt)
    content((-3.35, -0.2), text(size: 7pt)[$z$], anchor: "north")
    content((-1.85, 1.55), text(size: 7pt)[$y$], anchor: "west")
    content((-2.15, 0.18), text(size: 7pt)[$G$])

    // Frecce blu del flusso di taglio
    line((-1.0, 0.95), (-1.6, 0.95), mark: (end: ">"), stroke: (paint: rgb("#3182ce"), thickness: 0.6pt))
    line((-1.8, 0.95), (-2.4, 0.95), mark: (end: ">"), stroke: (paint: rgb("#3182ce"), thickness: 0.6pt))
    line((-2.7, 0.6), (-2.7, 0.1), mark: (end: ">"), stroke: (paint: rgb("#3182ce"), thickness: 0.6pt))
    line((-2.7, -0.1), (-2.7, -0.6), mark: (end: ">"), stroke: (paint: rgb("#3182ce"), thickness: 0.6pt))
    line((-2.4, -0.95), (-1.8, -0.95), mark: (end: ">"), stroke: (paint: rgb("#3182ce"), thickness: 0.6pt))
    line((-1.6, -0.95), (-1.0, -0.95), mark: (end: ">"), stroke: (paint: rgb("#3182ce"), thickness: 0.6pt))
    content((-3.1, 0.25), text(size: 7pt)[$tau_(x y)$])
    content((-1.15, 0.65), text(size: 7pt)[$tau_(x z)$])
    content((-1.15, -0.65), text(size: 7pt)[$tau_(x z)$])

    // Segno +
    content((-0.15, 0), text(size: 7pt)[$bold(+)$])

    // 3. Sezione a C con flussi di torsione (centro G in (1.7, 0))
    line((2.9, -1.05), (0.9, -1.05), (0.9, 1.05), (2.9, 1.05), (2.9, 0.85), (1.1, 0.85), (1.1, -0.85), (2.9, -0.85), close: true, stroke: 1.1pt)
    line((3.1, 0), (0.3, 0), mark: (end: ">"), stroke: 0.5pt)
    line((1.7, -1.5), (1.7, 1.6), mark: (end: ">"), stroke: 0.5pt)
    content((0.35, -0.2), text(size: 7pt)[$z$], anchor: "north")
    content((1.85, 1.55), text(size: 7pt)[$y$], anchor: "west")
    content((1.55, 0.18), text(size: 7pt)[$G$])

    // Coppie di frecce verdi opposte nello spessore per la torsione
    line((2.3, 0.99), (1.9, 0.99), mark: (end: ">"), stroke: (paint: rgb("#1b8a3d"), thickness: 0.6pt))
    line((1.9, 0.90), (2.3, 0.90), mark: (end: ">"), stroke: (paint: rgb("#1b8a3d"), thickness: 0.6pt))
    line((0.96, 0.5), (0.96, 0.15), mark: (end: ">"), stroke: (paint: rgb("#1b8a3d"), thickness: 0.6pt))
    line((1.04, 0.15), (1.04, 0.5), mark: (end: ">"), stroke: (paint: rgb("#1b8a3d"), thickness: 0.6pt))
    line((2.3, -0.90), (1.9, -0.90), mark: (end: ">"), stroke: (paint: rgb("#1b8a3d"), thickness: 0.6pt))
    line((1.9, -0.99), (2.3, -0.99), mark: (end: ">"), stroke: (paint: rgb("#1b8a3d"), thickness: 0.6pt))
    content((0.6, 0.25), text(size: 7pt)[$tau_(x y)$])
    content((2.55, 0.65), text(size: 7pt)[$tau_(x z)$])
    content((2.55, -0.65), text(size: 7pt)[$tau_(x z)$])

    // Ingrandimento circolare della distribuzione di torsione nello spessore dell'ala inferiore (centro (4.3, -0.8))
    circle((4.3, -0.8), radius: 0.85, stroke: 0.7pt)
    line((2.2, -0.95), (3.65, -0.35), stroke: 0.5pt)
    line((2.1, -1.05), (3.48, -1.05), stroke: 0.5pt)
    line((3.55, -0.45), (5.05, -0.45), stroke: 0.6pt)
    line((3.55, -1.15), (5.05, -1.15), stroke: 0.6pt)
    line((4.3, -1.15), (4.3, -0.45), stroke: (dash: "dashed", thickness: 0.5pt))
    line((4.3, -0.45), (3.85, -0.45), mark: (end: ">"), stroke: (paint: rgb("#1b8a3d"), thickness: 0.7pt))
    line((4.3, -1.15), (4.75, -1.15), mark: (end: ">"), stroke: (paint: rgb("#1b8a3d"), thickness: 0.7pt))
    bezier((3.85, -0.45), (4.3, -0.8), (4.15, -0.5), (4.25, -0.65), stroke: (paint: rgb("#1b8a3d"), thickness: 0.7pt))
    bezier((4.3, -0.8), (4.75, -1.15), (4.35, -0.95), (4.45, -1.1), stroke: (paint: rgb("#1b8a3d"), thickness: 0.7pt))
    content((4.3, -0.32), text(size: 7pt)[$tau_(x z)$])
  })
]
#v(0.5em)

== Esempio completo: trave a sezione sottile a C caricata nel baricentro

Si consideri una trave a mensola avente sezione aperta sottile a $C$ (di dimensioni esterne $B, H$, dimensioni sulla linea media $b, h$, spessore di parete $s$ e distanza tra linea media dell'anima e baricentro pari a $d_G$), incastrata a un estremo e sollecitata all'estremo libero da una forza di taglio verticale $T_y$ la cui retta d'azione passa per il baricentro geometrico $G$ della sezione. Si vogliono determinare:
1. la posizione del centro di taglio-torsione $"CTT"$ (distanza $d$ da $G$);
2. la tensione tangenziale massima totale agente sulla sezione.

=== 1. Calcolo della posizione del CTT

Dalla relazione di equivalenza statica sappiamo che la distanza $d$ del $"CTT"$ dal baricentro $G$ vale:

$ d = d_G + T_z / T_y h $

Per calcolare la risultante orizzontale $T_z$ nelle ali partiamo dalla formula di Jourawski applicata all'ala superiore di spessore $s$:

$ tau_(x z)(xi) = (T_y S_z(xi)) / (I_z s) $

 Introducendo l'ascissa locale $xi$ ($0 <= xi <= b$) misurata a partire dall'estremità libera dell'ala superiore verso l'anima, il momento statico della porzione di ala tratteggiata di area $s xi$ (il cui baricentro dista $h / 2$ dall'asse neutro $z$) risulta:

    $ S_z(xi) = s xi h / 2 $

    Sostituendo $S_z(xi)$ nella formula di Jourawski si ricava la distribuzione lineare della tensione tangenziale $tau_(x z)$ lungo l'ala:

    $ tau_(x z)(xi) = (T_y s xi h / 2) / (I_z s) = (T_y h) / (2 I_z) xi $

    Integrando la tensione $tau_(x z)(xi)$ sull'intera area della linea media dell'ala ($d A = s d xi$, per $xi$ da $0$ a $b$), si ottiene la forza orizzontale risultante $T_z$:

    $ T_z = integral_0^b tau_(x z)(xi) s d xi = (T_y h s) / (2 I_z) integral_0^b xi d xi = (T_y h s b^2) / (4 I_z) $

    Sostituendo il valore numerico di $T_z$ nell'espressione di $d$, si determina la posizione del centro di taglio-torsione:

    $ d = d_G + T_z / T_y h = d_G + (h^2 s b^2) / (4 I_z) = 33.7 "mm" $
#align(center)[
    #canvas(length: 1.78cm, {
      import draw: *
      // --- PANNELLO SINISTRO: Geometria sezione a C con ascissa xi (G in (-1.6, 0)) ---
      line((-0.4, -1.15), (-2.3, -1.15), (-2.3, 1.15), (-0.4, 1.15), (-0.4, 0.95), (-2.1, 0.95), (-2.1, -0.95), (-0.4, -0.95), close: true, stroke: 1.2pt)
      // Linea media tratteggiata
      line((-0.4, 1.05), (-2.2, 1.05), (-2.2, -1.05), (-0.4, -1.05), stroke: (dash: "dashed", thickness: 0.5pt))

      // Porzione tratteggiata xi sull'estremita' destra dell'ala superiore
      rect((-0.95, 0.95), (-0.4, 1.15), fill: luma(225), stroke: 0.6pt)
      line((-0.4, 0.72), (-0.95, 0.72), mark: (end: ">"), stroke: 0.6pt)
      content((-0.68, 0.65), text(size: 7pt)[$xi$], anchor: "north")

      // Assi e Ty
      line((-0.9, 0), (-3.5, 0), mark: (end: ">"), stroke: 0.6pt)
      line((-1.6, -1.5), (-1.6, 1.85), mark: (end: ">"), stroke: 0.6pt)
      content((-3.45, -0.2), text(size: 7pt)[$z$], anchor: "north")
      content((-1.75, 1.8), text(size: 7pt)[$y$], anchor: "east")
      content((-1.42, 0.18), text(size: 7pt)[$G$])

      line((-1.6, 0), (-1.6, -1.35), mark: (end: ">"), stroke: (paint: red, thickness: 1.6pt))
      content((-1.4, -0.25), text(size: 7pt, fill: red)[$T_y$], anchor: "west")

      // Quote B, b, H, h, s, dG
      line((-2.3, 1.55), (-0.4, 1.55), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((-1.35, 1.6), text(size: 7pt)[$B$], anchor: "south")
      line((-2.2, 1.32), (-0.4, 1.32), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((-1.3, 1.35), text(size: 7pt)[$b$], anchor: "south")

      line((-2.65, -1.15), (-2.65, 1.15), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((-2.72, 0.25), text(size: 7pt)[$H$], anchor: "east")

      line((0.0, -1.05), (0.0, 1.05), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((0.1, 0), text(size: 7pt)[$h$], anchor: "west")

      line((-0.1, 0.95), (-0.1, 1.15), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((0.02, 1.05), text(size: 7pt)[$s$], anchor: "west")

      line((-2.2, -0.55), (-1.6, -0.55), mark: (start: ">", end: ">"), stroke: 0.5pt)
      content((-1.9, -0.5), text(size: 7pt)[$d_G$], anchor: "south")

      // --- PANNELLO DESTRO: Diagramma lineare tau_xz e risultanti Tz (G in (2.3, 0)) ---
      line((3.5, -1.15), (1.6, -1.15), (1.6, 1.15), (3.5, 1.15), (3.5, 0.95), (1.8, 0.95), (1.8, -0.95), (3.5, -0.95), close: true, stroke: 1.2pt)
      line((2.5, 0), (0.8, 0), mark: (end: ">"), stroke: 0.6pt)
      line((2.3, -1.5), (2.3, 1.85), mark: (end: ">"), stroke: 0.6pt)
      content((0.85, -0.2), text(size: 7pt)[$z$], anchor: "north")
      content((2.15, 1.8), text(size: 7pt)[$y$], anchor: "east")
      content((2.48, 0.18), text(size: 7pt)[$G$])

      // Triangoli viola tau_xz e vettori risultanti Tz
      line((3.5, 1.05), (1.7, 1.75), (1.7, 1.05), close: true, stroke: (paint: rgb("#6b46c1"), thickness: 0.7pt))
      line((2.15, 1.05), (2.15, 1.57), stroke: (paint: rgb("#6b46c1"), thickness: 0.4pt))
      line((2.6, 1.05), (2.6, 1.40), stroke: (paint: rgb("#6b46c1"), thickness: 0.4pt))
      line((3.05, 1.05), (3.05, 1.22), stroke: (paint: rgb("#6b46c1"), thickness: 0.4pt))
      line((3.3, 1.05), (2.0, 1.05), mark: (end: ">"), stroke: (paint: rgb("#6b46c1"), thickness: 1.5pt))
      content((3.05, 1.55), text(size: 7pt, fill: rgb("#6b46c1"))[$tau_(x z)$])
      content((2.7, 0.68), text(size: 7pt, fill: rgb("#6b46c1"))[$T_z$])

      line((3.5, -1.05), (1.7, -1.75), (1.7, -1.05), close: true, stroke: (paint: rgb("#6b46c1"), thickness: 0.7pt))
      line((2.15, -1.05), (2.15, -1.57), stroke: (paint: rgb("#6b46c1"), thickness: 0.4pt))
      line((2.6, -1.05), (2.6, -1.40), stroke: (paint: rgb("#6b46c1"), thickness: 0.4pt))
      line((3.05, -1.05), (3.05, -1.22), stroke: (paint: rgb("#6b46c1"), thickness: 0.4pt))
      line((2.0, -1.05), (3.3, -1.05), mark: (end: ">"), stroke: (paint: rgb("#6b46c1"), thickness: 1.5pt))
      content((3.05, -1.55), text(size: 7pt, fill: rgb("#6b46c1"))[$tau_(x z)$])
      content((2.7, -0.68), text(size: 7pt, fill: rgb("#6b46c1"))[$T_z$])
    })
  ]
#v(1em)

=== 2. Calcolo della tensione tangenziale massima totale

Poiché la forza di taglio esterna $T_y$ è applicata nel baricentro $G$, essa presenta un braccio pari a $d = 33.7 "mm"$ rispetto al centro di taglio-torsione $"CTT"$. Riducendo la sollecitazione al $"CTT"$, la sezione risulta soggetta contemporaneamente a:
- uno sforzo di taglio centrato $T_y$;
- un momento torcente di trasporto $M_t = T_y d$.

Per valutare la tensione tangenziale massima totale occorre determinare separatamente le tensioni tangenziali verticali $tau_(x y)$ massime nell'anima dovute al taglio e alla torsione:

1. *Contributo dovuto al taglio $T_y$*:
   La distribuzione di tensione tangenziale $tau_(x y)$ nell'anima verticale di spessore $s$ si calcola mediante la formula di Jourawski:
   $ tau_(x y)(y) = (T_y S_z(y)) / (I_z s) $
   dove il momento statico $S_z(y)$ della porzione superiore alla generica ordinata $y$ nell'anima (somma del contributo dell'ala superiore e del tratto di anima compreso tra $y$ e $h / 2$) vale:
   $ S_z(y) = (b + s / 2) s h / 2 + s (h / 2 - s / 2 - y) (h / 2 - s / 2 + y) / 2 $
   Il valore massimo si raggiunge sull'asse neutro baricentrico $z$, per $y = 0$:
   $ S_z(y = 0) = 11 thin 208 "mm"^3 => tau_(x y, "max")^"TAGLIO" = (T_y S_z(0)) / (I_z s) = 3.4 "MPa" $

2. *Contributo dovuto al momento torcente $M_t = T_y d$*:
   Trattandosi di una sezione aperta sottile composta da tre tratti rettilinei di spessore costante $s$ (un'anima di lunghezza $h$ e due ali di lunghezza $b$), il fattore di rigidezza torsionale complessivo $I_t$ vale:
   $ I_t = (h s^3) / 3 + 2 (b s^3) / 3 = 3840 "mm"^4 $
   La tensione tangenziale massima dovuta alla torsione (raggiunta sui bordi interno ed esterno della parete di spessore $s$) risulta:
   $ tau_(x y, "max")^"TORSIONE" = M_t / I_t s = (T_y d) / I_t s = 35.1 "MPa" $

#align(center)[
  #canvas(length: 1.82cm, {
    import draw: *
    // --- PANNELLO SINISTRO: Contributo di Taglio con punto P (G in (-2.0, 0)) ---
    line((-0.8, -1.15), (-2.7, -1.15), (-2.7, 1.15), (-0.8, 1.15), (-0.8, 0.95), (-2.5, 0.95), (-2.5, -0.95), (-0.8, -0.95), close: true, stroke: 1.2pt)
    line((-0.8, 1.05), (-2.6, 1.05), stroke: (dash: "dashed", thickness: 0.5pt))
    line((-0.8, -1.05), (-2.6, -1.05), stroke: (dash: "dashed", thickness: 0.5pt))

    line((-1.8, 0), (-4.0, 0), mark: (end: ">"), stroke: 0.6pt)
    line((-2.0, -0.3), (-2.0, 1.55), mark: (end: ">"), stroke: 0.6pt)
    content((-3.95, -0.2), text(size: 7pt)[$z$], anchor: "north")
    content((-2.15, 1.5), text(size: 7pt)[$y$], anchor: "east")
    content((-1.82, 0.18), text(size: 7pt)[$G$])

    // Quote b, h, s
    line((-2.6, 1.75), (-0.8, 1.75), mark: (start: ">", end: ">"), stroke: 0.5pt)
    content((-1.7, 1.8), text(size: 7pt)[$b$], anchor: "south")
    line((-0.3, -1.05), (-0.3, 1.05), mark: (start: ">", end: ">"), stroke: 0.5pt)
    content((-0.2, 0), text(size: 7pt)[$h$], anchor: "west")
    line((-0.45, 0.95), (-0.45, 1.15), mark: (start: ">", end: ">"), stroke: 0.5pt)
    content((-0.32, 1.05), text(size: 7pt)[$s$], anchor: "west")

    // Diagramma parabolico blu tau_xy da taglio sull'anima
    line((-2.7, 0.95), (-3.35, 0.95), stroke: (paint: blue, thickness: 0.7pt))
    line((-2.7, -0.95), (-3.35, -0.95), stroke: (paint: blue, thickness: 0.7pt))
    bezier((-3.35, 0.95), (-3.6, 0), (-3.5, 0.6), (-3.6, 0.3), stroke: (paint: blue, thickness: 0.9pt))
    bezier((-3.6, 0), (-3.35, -0.95), (-3.6, -0.3), (-3.5, -0.6), stroke: (paint: blue, thickness: 0.9pt))
    line((-2.7, 0.6), (-3.48, 0.6), stroke: (paint: blue, thickness: 0.4pt))
    line((-2.7, 0.3), (-3.56, 0.3), stroke: (paint: blue, thickness: 0.4pt))
    line((-2.7, 0.0), (-3.60, 0.0), stroke: (paint: blue, thickness: 0.4pt))
    line((-2.7, -0.3), (-3.56, -0.3), stroke: (paint: blue, thickness: 0.4pt))
    line((-2.7, -0.6), (-3.48, -0.6), stroke: (paint: blue, thickness: 0.4pt))
    content((-3.85, 0.25), text(size: 7pt, fill: blue)[$tau_(x y)$])

    // Punto P sul bordo interno dell'anima (x = -2.5, y = 0)
    circle((-2.5, 0), radius: 0.08, fill: red, stroke: none)
    content((-2.38, 0.2), text(size: 7pt, fill: red)[$P$])

    // Segno + centrale
    content((0.5, 0), text(size: 7pt)[$bold(+)$])

    // --- PANNELLO DESTRO: Contributo di Torsione Mt = Ty d con punto P (G in (3.2, 0)) ---
    line((4.4, -1.15), (2.5, -1.15), (2.5, 1.15), (4.4, 1.15), (4.4, 0.95), (2.7, 0.95), (2.7, -0.95), (4.4, -0.95), close: true, stroke: 1.2pt)
    line((4.4, 1.05), (2.6, 1.05), stroke: (dash: "dashed", thickness: 0.5pt))
    line((4.4, -1.05), (2.6, -1.05), stroke: (dash: "dashed", thickness: 0.5pt))

    line((3.4, 0), (1.3, 0), mark: (end: ">"), stroke: 0.6pt)
    line((3.2, -0.3), (3.2, 1.55), mark: (end: ">"), stroke: 0.6pt)
    content((1.35, -0.2), text(size: 7pt)[$z$], anchor: "north")
    content((3.05, 1.5), text(size: 7pt)[$y$], anchor: "east")
    content((3.35, 0.18), text(size: 7pt)[$G$])

    // Quote b, h, s
    line((2.6, 1.75), (4.4, 1.75), mark: (start: ">", end: ">"), stroke: 0.5pt)
    content((3.5, 1.8), text(size: 7pt)[$b$], anchor: "south")
    line((4.9, -1.05), (4.9, 1.05), mark: (start: ">", end: ">"), stroke: 0.5pt)
    content((5.0, 0), text(size: 7pt)[$h$], anchor: "west")
    line((4.75, 0.95), (4.75, 1.15), mark: (start: ">", end: ">"), stroke: 0.5pt)
    content((4.88, 1.05), text(size: 7pt)[$s$], anchor: "west")

    // Diagrammi a farfalla verdi nello spessore per la torsione
    line((2.5, -0.55), (2.7, 0.55), stroke: (paint: rgb("#1b8a3d"), thickness: 0.8pt))
    line((3.0, 1.15), (4.0, 0.95), stroke: (paint: rgb("#1b8a3d"), thickness: 0.8pt))
    line((3.0, -0.95), (4.0, -1.15), stroke: (paint: rgb("#1b8a3d"), thickness: 0.8pt))
    content((2.15, 0.25), text(size: 7pt, fill: rgb("#1b8a3d"))[$tau_(x y)$])
    content((3.7, 1.38), text(size: 7pt, fill: rgb("#1b8a3d"))[$tau_(x z)$])
    content((3.7, -1.38), text(size: 7pt, fill: rgb("#1b8a3d"))[$tau_(x z)$])

    // Arco momento torcente Mt = Ty d
    arc((3.3, 0.05), start: -15deg, stop: 195deg, radius: 0.42, anchor: "origin", mark: (start: ">"), stroke: (paint: rgb("#1b8a3d"), thickness: 1.5pt))
    content((3.35, -0.55), text(size: 7pt, fill: rgb("#1b8a3d"))[$M_t = T_y d$])

    // Punto P sul bordo interno dell'anima (x = 2.7, y = 0)
    circle((2.7, 0), radius: 0.08, fill: red, stroke: none)
    content((2.82, 0.2), text(size: 7pt, fill: red)[$P$])
  })
]
#v(0.5em)

#nota[
  *Sovrapposizione degli effetti nel punto più sollecitato $P$*:
  La tensione tangenziale massima totale si localizza nel punto $P$, situato sul bordo interno dell'anima verticale in corrispondenza dell'asse neutro baricentrico $z$ ($y = 0$), dove le tensioni tangenziali massime di taglio e di torsione risultano concordi (entrambe dirette verso il basso) e si sommano algebricamente:
  $ tau_(x y, "max") = tau_(x y, "max")^"TAGLIO" + tau_(x y, "max")^"TORSIONE" = 3.4 + 35.1 = 38.5 "MPa" $
]
