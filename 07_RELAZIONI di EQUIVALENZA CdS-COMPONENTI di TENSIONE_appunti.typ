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



// === Blocco_01_Slide_01-18 ===

= Relazioni di equivalenza tra caratteristiche di sollecitazione e componenti di tensione

== Ipotesi di lavoro ed equilibrio dei corpi

Lo studio della meccanica strutturale e della teoria dell'elasticità si fonda su quattro ipotesi fondamentali relative alla natura del materiale e del corpo solido in esame:

- *Continuità*: il corpo riempie in modo continuo tutto il volume a esso attribuito, trascurando la struttura discreta o corpuscolare della materia. Poiché la teoria dell'elasticità è una teoria macroscopica, questa ipotesi consente di applicare gli strumenti dell'analisi infinitesimale.
- *Perfetta elasticità*: al cessare dell'azione delle forze esterne, i corpi riassumono esattamente la loro forma iniziale senza deformazioni residue.
- *Omogeneità*: le proprietà meccaniche del materiale sono costanti in ogni punto e non dipendono dalle dimensioni dell'elemento di volume preso in esame.
- *Isotropia*: le proprietà del materiale sono identiche in tutte le direzioni dello spazio attorno al punto considerato.

Consideriamo un corpo solido in equilibrio statico sotto l'azione di un sistema di forze esterne qualsiasi. Sezionando idealmente il corpo con un piano arbitrario di traccia $S$, esso viene diviso in due parti distinte $A$ e $B$. Ciascuna delle due porzioni deve trovarsi singolarmente in equilibrio sotto l'azione combinata di due sistemi di forze:
1. Le *forze generalizzate esterne* (costituite dai carichi applicati e dalle reazioni vincolari) che agiscono direttamente sulla parte in esame.
2. Le *forze generalizzate interne* (dette *caratteristiche di sollecitazione*), pensate distribuite con continuità sulla sezione trasversale $S$, che rappresentano l'azione mutua esercitata dall'altra parte di corpo su quella in esame.

#canvas(length: 1cm, {
  import draw: *
  // Parte inferiore A
  arc((0, 0), start: 0deg, stop: 180deg, radius: (1.4, 0.45), anchor: "origin", stroke: 0.8pt)
  arc((0, 0), start: 180deg, stop: 360deg, radius: (1.4, 0.45), anchor: "origin", stroke: 0.8pt)
  bezier((-1.4, 0.0), (1.4, 0.0), (-1.4, -2.5), (1.4, -2.5), stroke: 0.9pt)
  content((0.0, -1.3), text(size: 7pt)[*A*])

  // Frecce esterne su A (punta vuota)
  line((-2.2, -1.4), (-1.15, -0.95), mark: (end: ">", fill: white), stroke: 0.7pt)
  line((-0.5, -2.6), (-0.25, -1.8), mark: (end: ">", fill: white), stroke: 0.7pt)
  line((0.9, -2.3), (0.55, -1.65), mark: (end: ">", fill: white), stroke: 0.7pt)

  // Frecce interne su S di A
  line((-0.8, 0.1), (-0.9, 1.0), mark: (end: ">", fill: black), stroke: 0.7pt)
  line((-0.4, -0.15), (-0.4, 0.75), mark: (end: ">", fill: black), stroke: 0.7pt)
  line((0.0, 0.0), (0.15, 0.9), mark: (end: ">", fill: black), stroke: 0.7pt)
  line((0.4, -0.2), (0.55, 0.65), mark: (end: ">", fill: black), stroke: 0.7pt)
  line((0.9, -0.1), (1.2, 0.6), mark: (end: ">", fill: black), stroke: 0.7pt)

  // Indicatore sezione S inferiore
  line((-1.8, 0.45), (-0.95, 0.15), stroke: 0.6pt)
  circle((-0.95, 0.15), radius: 0.04, fill: black)
  content((-2.0, 0.5), text(size: 7pt)[*S*], anchor: "east")

  // Parte superiore B
  arc((1.0, 2.3), start: 0deg, stop: 180deg, radius: (1.4, 0.45), anchor: "origin", stroke: 0.8pt)
  arc((1.0, 2.3), start: 180deg, stop: 360deg, radius: (1.4, 0.45), anchor: "origin", stroke: 0.8pt)
  bezier((-0.4, 2.3), (2.4, 2.3), (-0.1, 4.8), (2.5, 4.8), stroke: 0.9pt)
  content((1.25, 3.5), text(size: 7pt)[*B*])

  // Frecce esterne su B (punta vuota)
  line((0.2, 4.7), (0.5, 3.9), mark: (end: ">", fill: white), stroke: 0.7pt)
  line((2.5, 4.5), (1.95, 3.85), mark: (end: ">", fill: white), stroke: 0.7pt)

  // Frecce interne su S di B
  line((0.0, 2.4), (-0.35, 1.6), mark: (end: ">", fill: black), stroke: 0.7pt)
  line((0.5, 2.35), (0.3, 1.45), mark: (end: ">", fill: black), stroke: 0.7pt)
  line((0.95, 2.2), (0.75, 1.35), mark: (end: ">", fill: black), stroke: 0.7pt)
  line((1.4, 2.25), (1.35, 1.35), mark: (end: ">", fill: black), stroke: 0.7pt)
  line((1.8, 2.05), (1.9, 1.15), mark: (end: ">", fill: black), stroke: 0.7pt)

  // Indicatore sezione S superiore
  line((-0.8, 2.75), (-0.05, 2.45), stroke: 0.6pt)
  circle((-0.05, 2.45), radius: 0.04, fill: black)
  content((-1.0, 2.8), text(size: 7pt)[*S*], anchor: "east")
})

Il sistema di forze esterne applicate provoca in ogni punto del corpo una *condizione di sollecitazione* che, se eccessiva, può portare al cedimento strutturale. La condizione di equilibrio statico globale impone che il corpo risulti *equilibrato in ogni sua sezione trasversale*. Di conseguenza, sulla generica sezione trasversale di normale coincidente con l'asse $x$, le azioni interne — sintetizzate nelle caratteristiche di sollecitazione: sforzo normale $N_x$, sforzi di taglio $T_y$ e $T_z$, momenti flettenti $M_y$ e $M_z$, e momento torcente $M_x$ — devono mantenere in equilibrio la sezione stessa.

#canvas(length: 1.4cm, {
  import draw: *
  // Assi di riferimento
  line((0, 0), (8.2, 0), mark: (end: ">"), stroke: 0.7pt)
  content((8.1, 0.25), text(size: 7pt)[$x$])
  line((0, 0), (0, 2.6), mark: (end: ">"), stroke: 0.7pt)
  content((0.25, 2.5), text(size: 7pt)[$y$])
  line((0, 0), (-0.85, -0.7), mark: (end: ">"), stroke: 0.7pt)
  content((-0.6, -0.85), text(size: 7pt)[$z$])

  // Tronco sinistro: faccia sinistra (x=0)
  bezier((0.5, 1.25), (-0.4, 0.3), (-0.1, 1.2), (-0.45, 0.8), stroke: 1.2pt)
  bezier((-0.4, 0.3), (-0.25, -0.5), (-0.35, -0.1), (-0.1, -0.2), stroke: 1.2pt)
  bezier((-0.25, -0.5), (0.2, -1.25), (-0.4, -0.8), (-0.2, -1.2), stroke: 1.2pt)
  bezier((0.5, 1.25), (0.5, 0.1), (1.0, 0.9), (0.2, 0.5), stroke: (dash: "dashed", thickness: 0.7pt))
  bezier((0.5, 0.1), (0.2, -1.25), (0.9, -0.3), (0.8, -1.0), stroke: (dash: "dashed", thickness: 0.7pt))

  // Linee longitudinali tronco sinistro
  line((0.5, 1.25), (2.9, 1.25), stroke: 1.2pt)
  line((0.2, -1.25), (2.6, -1.25), stroke: 1.2pt)

  // Tronco sinistro: faccia destra (sezione a x=2.65)
  bezier((2.9, 1.25), (2.0, 0.3), (2.3, 1.2), (1.95, 0.8), stroke: 1.2pt)
  bezier((2.0, 0.3), (2.15, -0.5), (2.05, -0.1), (2.3, -0.2), stroke: 1.2pt)
  bezier((2.15, -0.5), (2.6, -1.25), (2.0, -0.8), (2.2, -1.2), stroke: 1.2pt)
  bezier((2.9, 1.25), (2.9, 0.1), (3.4, 0.9), (2.6, 0.5), stroke: 1.2pt)
  bezier((2.9, 0.1), (2.6, -1.25), (3.3, -0.3), (3.2, -1.0), stroke: 1.2pt)

  // Caratteristiche di sollecitazione sulla sezione (origine locale in (2.65, 0))
  // Ty e My (verde)
  line((2.65, 0), (2.65, 2.05), mark: (end: ">"), stroke: (paint: rgb("#008000"), thickness: 1.6pt))
  content((2.25, 2.0), text(size: 7pt, fill: rgb("#008000"))[$T_y$])
  arc((2.65, 0.75), start: 195deg, stop: 345deg, radius: (0.32, 0.14), anchor: "origin", mark: (end: ">"), stroke: (paint: rgb("#008000"), thickness: 1.4pt))
  content((3.05, 0.9), text(size: 7pt, fill: rgb("#008000"))[$M_y$])

  // Nx e Mx (rosso)
  line((2.65, 0), (3.9, 0), mark: (end: ">"), stroke: (paint: rgb("#e60000"), thickness: 1.6pt))
  content((3.95, 0.3), text(size: 7pt, fill: rgb("#e60000"))[$N_x$])
  arc((3.4, 0.05), start: -110deg, stop: 160deg, radius: (0.14, 0.65), anchor: "origin", mark: (end: ">"), stroke: (paint: rgb("#e60000"), thickness: 1.4pt))
  content((3.6, -0.9), text(size: 7pt, fill: rgb("#e60000"))[$M_x$])

  // Tz e Mz (blu)
  line((2.65, 0), (1.05, -1.1), mark: (end: ">"), stroke: (paint: rgb("#0072bd"), thickness: 1.6pt))
  content((1.3, -0.4), text(size: 7pt, fill: rgb("#0072bd"))[$T_z$])
  arc((1.7, -0.45), start: -55deg, stop: 65deg, radius: (0.28, 0.52), anchor: "origin", mark: (end: ">"), stroke: (paint: rgb("#0072bd"), thickness: 1.4pt))
  content((2.05, -1.05), text(size: 7pt, fill: rgb("#0072bd"))[$M_z$])

  // Tronco destro (traslato a x=4.6)
  bezier((5.1, 1.25), (4.2, 0.3), (4.5, 1.2), (4.15, 0.8), stroke: 1.2pt)
  bezier((4.2, 0.3), (4.35, -0.5), (4.25, -0.1), (4.5, -0.2), stroke: 1.2pt)
  bezier((4.35, -0.5), (4.8, -1.25), (4.2, -0.8), (4.4, -1.2), stroke: 1.2pt)
  bezier((5.1, 1.25), (5.1, 0.1), (5.6, 0.9), (4.8, 0.5), stroke: (dash: "dashed", thickness: 0.7pt))
  bezier((5.1, 0.1), (4.8, -1.25), (5.5, -0.3), (5.4, -1.0), stroke: (dash: "dashed", thickness: 0.7pt))

  line((5.1, 1.25), (7.5, 1.25), stroke: 1.2pt)
  line((4.8, -1.25), (7.2, -1.25), stroke: 1.2pt)

  bezier((7.5, 1.25), (6.6, 0.3), (6.9, 1.2), (6.55, 0.8), stroke: 1.2pt)
  bezier((6.6, 0.3), (6.75, -0.5), (6.65, -0.1), (6.9, -0.2), stroke: 1.2pt)
  bezier((6.75, -0.5), (7.2, -1.25), (6.6, -0.8), (6.8, -1.2), stroke: 1.2pt)
  bezier((7.5, 1.25), (7.5, 0.1), (8.0, 0.9), (7.2, 0.5), stroke: 1.2pt)
  bezier((7.5, 0.1), (7.2, -1.25), (7.9, -0.3), (7.8, -1.0), stroke: 1.2pt)
})

== Il vettore tensione e lo stato tensionale puntuale

A partire dalle equazioni cardinali della statica, su una generica sezione di area $A$ (o su una sua porzione elementare d'intorno $d A$ centrata nel punto $P$, avente versore normale esterno $arrow(n)$) è possibile determinare la forza risultante $arrow(R)$ e il momento risultante $arrow(M)$ associati alla distribuzione continua delle forze interne.

Per descrivere rigorosamente lo *stato di sollecitazione* nel *generico punto* $P$ del corpo è necessario passare da grandezze integrali a *grandezze puntuali*. Facendo tendere a zero l'area $d A$ nell'intorno di $P$ (operazione lecita grazie all'ipotesi di mezzo continuo, senza risentire della natura corpuscolare della materia) e assumendo che per l'elemento infinitesimo il momento specifico si annulli al limite:

$ lim_(d A -> 0) (Delta arrow(M)) / (d A) = 0 $ // INCERTO: dedotto dal contesto

si definisce il *vettore tensione* $arrow(t)$ nel generico punto $P$ relativo all'area infinitesima $d A$ come:

$ arrow(t) = lim_(d A -> 0) (Delta arrow(R)) / (d A) = (d arrow(R)) / (d A) $ // INCERTO: dedotto dal contesto

In generale, il vettore tensione $arrow(t)$ non risulta parallelo alla normale $arrow(n)$ alla superficie infinitesima, ed è funzione sia della posizione del punto $P$ sia dell'orientazione della superficie stessa individuata dal versore normale $arrow(n)$:

$ arrow(t) = arrow(t)(P, arrow(n)) $

Su ogni superficie elementare $d A$ passante per $P$, il vettore tensione $arrow(t)$ può essere scomposto secondo tre direzioni mutue ortogonali:
- Una componente parallela alla normale $arrow(n)$ in $P$ alla superficie, denominata *tensione normale* $sigma$.
- Due componenti appartenenti al piano tangente alla superficie (e dunque perpendicolari alla normale $arrow(n)$), denominate *tensioni tangenziali* $tau$.

#canvas(length: 1.4cm, {
  import draw: *
  // Pannello 1: Solido sezionato con area A e dA
  circle((1.5, 1.5), radius: (1.1, 1.65), stroke: 0.9pt)
  arc((1.5, 1.5), start: 185deg, stop: 355deg, radius: (1.1, 0.45), anchor: "origin", stroke: 0.8pt)
  arc((1.5, 1.5), start: 5deg, stop: 175deg, radius: (1.1, 0.45), anchor: "origin", stroke: (dash: "dashed", thickness: 0.6pt))
  content((0.75, 1.7), text(size: 7pt)[$A$])

  // Elementino dA sul solido
  circle((1.55, 1.4), radius: 0.4, stroke: (dash: "dashed", thickness: 0.5pt))
  line((1.35, 1.4), (1.55, 1.55), (1.75, 1.4), (1.55, 1.25), close: true, stroke: 0.8pt)
  line((2.05, 1.85), (1.62, 1.45), mark: (end: ">"), stroke: 0.6pt)
  content((2.2, 1.95), text(size: 7pt)[$d A$])

  // Forze e momenti esterni sul solido
  line((0.5, 0.2), (0.05, -0.2), mark: (end: ">"), stroke: 0.8pt)
  content((0.0, -0.4), text(size: 7pt)[$arrow(F)_a$])
  arc((0.25, 0.45), start: 60deg, stop: 200deg, radius: 0.35, anchor: "origin", mark: (end: ">"), stroke: 0.8pt)
  content((0.0, 0.95), text(size: 7pt)[$arrow(M)_a$])

  line((2.4, 2.4), (2.95, 2.7), mark: (end: ">"), stroke: 0.8pt)
  content((2.65, 2.85), text(size: 7pt)[$arrow(F)_b$])
  arc((2.1, 3.0), start: 30deg, stop: 150deg, radius: 0.35, anchor: "origin", mark: (start: ">"), stroke: 0.8pt)
  content((1.95, 3.55), text(size: 7pt)[$arrow(M)_b$])

  // Freccia tratteggiata di collegamento all'ingrandimento
  bezier((1.75, 1.15), (4.45, 1.65), (2.7, 0.6), (3.5, 2.4), mark: (end: ">"), stroke: (dash: "dashed", thickness: 0.6pt))

  // Pannello 2: Ingrandimento di dA con R, M e scomposizione di t in sigma e tau
  line((3.6, 1.3), (4.5, 2.05), (5.4, 1.3), (4.5, 0.55), close: true, stroke: 0.9pt)
  circle((4.5, 1.3), radius: 0.38, stroke: (dash: "dashed", thickness: 0.6pt))
  circle((4.5, 1.3), radius: 0.05, fill: black)
  content((4.5, 1.05), text(size: 7pt)[$P$])
  content((3.95, 1.35), text(size: 7pt)[$d A$])

  // Normale n e tensione normale sigma
  line((4.5, 1.3), (5.2, 2.2), mark: (end: ">"), stroke: 1.0pt)
  content((4.85, 2.05), text(size: 7pt)[$arrow(n)$])
  line((4.5, 1.3), (5.65, 2.78), mark: (end: ">"), stroke: (paint: rgb("#e60000"), thickness: 1.1pt))
  content((5.35, 2.8), text(size: 7pt, fill: rgb("#e60000"))[$sigma$])

  // Vettore tensione t e risultanti R, M
  line((4.5, 1.3), (6.5, 2.1), mark: (end: ">"), stroke: 1.0pt)
  content((6.15, 2.25), text(size: 7pt)[$arrow(t)$])
  arc((5.35, 1.55), start: 100deg, stop: 260deg, radius: 0.25, anchor: "origin", mark: (start: ">"), stroke: 0.8pt)
  content((5.35, 2.0), text(size: 7pt)[$arrow(M)$])
  content((6.85, 2.1), text(size: 7pt)[$(arrow(R))$])

  // Componenti tangenziali tau nel piano di dA
  line((4.5, 1.3), (3.85, 0.95), mark: (end: ">"), stroke: (paint: rgb("#e60000"), thickness: 1.0pt))
  content((3.95, 0.7), text(size: 7pt, fill: rgb("#e60000"))[$tau$])
  line((4.5, 1.3), (5.05, 0.75), mark: (end: ">"), stroke: (paint: rgb("#e60000"), thickness: 1.0pt))
  content((5.25, 0.75), text(size: 7pt, fill: rgb("#e60000"))[$tau$])
})

L'*equilibrio* globale deve essere *garantito anche in termini di tensioni* agenti sulla generica sezione trasversale di area $A$ del solido. Integrando il vettore tensione sull'intera area della sezione trasversale, devono essere soddisfatte le equazioni di equivalenza statica con la forza risultante $arrow(R)$ e il momento risultante $arrow(M)$ (calcolato rispetto al polo considerato tramite il vettore posizione $arrow(r)$):

$ cases(
  integral_A arrow(t) d A = arrow(R),
  integral_A arrow(r) times arrow(t) d A = arrow(M)
) $ // INCERTO: dedotto dal contesto

=== Componenti speciali di tensione: il cubetto elementare

In generale, lo *stato di tensione* nel generico *punto* $P$ è completamente *noto quando* si conoscono le componenti del vettore tensione agenti su 3 superfici infinitesime mutue ortogonali passanti per $P$.

Con queste tre superfici infinitesime ortogonali agli assi coordinati $x, y, z$, immaginiamo di isolare un *cubetto elementare* centrato nell'intorno del generico punto $P$. Su ciascuna delle facce del cubetto elementare agiscono una *tensione normale* $sigma$ e due *tensioni tangenziali* $tau$, ciascuna identificata univocamente da *due pedici*:
- Il *primo pedice* indica la faccia su cui agisce la componente di tensione, individuata tramite la direzione della normale uscente alla faccia stessa ($x, y, z$).
- Il *secondo pedice* indica la direzione dell'asse coordinato lungo cui è diretta la componente di tensione in esame ($x, y, z$).

#canvas(length: 1.4cm, {
  import draw: *
  // Terna di riferimento a sinistra
  line((-2.2, 0.4), (-2.2, 1.5), mark: (end: ">"), stroke: 0.7pt)
  content((-2.0, 1.45), text(size: 7pt)[$z$])
  line((-2.2, 0.4), (-1.1, 0.4), mark: (end: ">"), stroke: 0.7pt)
  content((-1.15, 0.65), text(size: 7pt)[$y$])
  line((-2.2, 0.4), (-2.75, -0.15), mark: (end: ">"), stroke: 0.7pt)
  content((-2.45, -0.2), text(size: 7pt)[$x$])

  // Cubetto elementare: faccia frontale (normale x): [0, 2.4] x [0, 2.2]
  rect((0, 0), (2.4, 2.2), stroke: 1.0pt)
  // Faccia superiore (normale z) e faccia destra (normale y)
  line((0, 2.2), (0.9, 2.95), (3.3, 2.95), (2.4, 2.2), stroke: 1.0pt)
  line((3.3, 2.95), (3.3, 0.75), (2.4, 0), stroke: 1.0pt)

  // Diagonali tratteggiate interne passanti per il centro P(1.65, 1.475)
  line((0, 2.2), (3.3, 0.75), stroke: (dash: "dashed", thickness: 0.6pt))
  line((2.4, 2.2), (0.9, 0.75), stroke: (dash: "dashed", thickness: 0.6pt))
  line((0, 0), (3.3, 2.95), stroke: (dash: "dashed", thickness: 0.6pt))
  line((1.2, 2.95), (2.1, 0), stroke: (dash: "dashed", thickness: 0.6pt))
  circle((1.65, 1.475), radius: 0.08, fill: black)
  content((1.38, 1.48), text(size: 7pt)[$P$])

  // Componenti sulla faccia x (centro (0.75, 0.65))
  line((0.75, 0.65), (0.15, 0.05), mark: (end: ">"), stroke: 0.9pt)
  content((-0.15, -0.05), text(size: 7pt)[$sigma_(x x)$])
  line((0.75, 0.65), (1.55, 0.65), mark: (end: ">"), stroke: 0.9pt)
  content((1.4, 0.35), text(size: 7pt)[$tau_(x y)$])
  line((0.75, 0.65), (0.75, 1.45), mark: (end: ">"), stroke: 0.9pt)
  content((0.45, 1.25), text(size: 7pt)[$tau_(x z)$])

  // Componenti sulla faccia y (centro (2.85, 1.35))
  line((2.85, 1.35), (3.65, 1.35), mark: (end: ">"), stroke: 0.9pt)
  content((3.7, 1.05), text(size: 7pt)[$sigma_(y y)$])
  line((2.85, 1.35), (2.25, 0.75), mark: (end: ">"), stroke: 0.9pt)
  content((2.6, 0.65), text(size: 7pt)[$tau_(y x)$])
  line((2.85, 1.35), (2.85, 2.15), mark: (end: ">"), stroke: 0.9pt)
  content((2.65, 2.1), text(size: 7pt)[$tau_(y z)$])

  // Componenti sulla faccia z (centro (1.65, 2.58))
  line((1.65, 2.58), (1.65, 3.38), mark: (end: ">"), stroke: 0.9pt)
  content((1.3, 3.25), text(size: 7pt)[$sigma_(z z)$])
  line((1.65, 2.58), (2.45, 2.58), mark: (end: ">"), stroke: 0.9pt)
  content((2.25, 2.35), text(size: 7pt)[$tau_(z y)$])
  line((1.65, 2.58), (1.05, 1.98), mark: (end: ">"), stroke: 0.9pt)
  content((1.4, 1.95), text(size: 7pt)[$tau_(z x)$])
})

== Il solido di de Saint Venant

I primi studi sistematici sull'elasticità dei corpi risalgono alla scuola francese di fine Settecento, i cui risultati più rilevanti furono conseguiti da *Barré de Saint Venant* (spesso abbreviato in *de St Venant*), le cui ipotesi resero possibile la formulazione della moderna *teoria tecnica delle travi*.

L'approccio seguito da de Saint Venant consistette nell'introdurre alcune *ipotesi semplificative* sul problema elastico tridimensionale che rendessero la soluzione analiticamente trattabile ma al contempo fisicamente valida per le applicazioni ingegneristiche. Lo studio sviluppato consentì di determinare le *relazioni* esatte tra le *caratteristiche di sollecitazione* e le componenti dello *stato di tensione* agenti nei punti della generica sezione trasversale di un corpo prismatico, detto appunto *solido di de Saint Venant*.

#nota[
*Ipotesi fondamentali del solido di de Saint Venant (teoria delle travi):*
1. Materiale *lineare elastico, omogeneo e isotropo*.
2. *Geometria cilindrica* (prismatica), avente le dimensioni trasversali della sezione molto minori rispetto alla lunghezza assiale del cilindro.
3. Ciascuna sezione normale all'asse longitudinale del cilindro è *retta e identica* alla sezione generatrice.
4. Solido libero nello spazio e in *equilibrio statico* sotto l'azione del sistema di forze esterne applicate (carichi e reazioni).
5. *Forze di volume nulle* e forze di superficie applicate *esclusivamente sulle basi* di estremità del cilindro (la superficie laterale o mantello del solido di de Saint Venant è completamente *scarica*).
]

=== Componenti di tensione nel solido di de Saint Venant

Consideriamo il solido cilindrico di de Saint Venant disponendo l'asse longitudinale del cilindro allineato con l'asse coordinato $x$, mentre gli assi $y$ e $z$ giacciono nel piano della sezione trasversale.

Poiché per ipotesi la superficie laterale cilindrica del solido è scarica e le forze di volume sono nulle, de Saint Venant ipotizzò che le componenti di tensione normali agli assi trasversali e le tensioni tangenziali agenti nei piani paralleli all'asse $x$ siano identicamente nulle in tutto il solido:

$ sigma_(z z) = 0, quad sigma_(y y) = 0, quad tau_(z y) = tau_(y z) = 0 $

Di conseguenza, le *uniche componenti di tensione* non nulle presenti sulla generica sezione trasversale di normale $x$ sono la tensione normale assiale $sigma_(x x)$ e le due componenti di tensione tangenziale $tau_(x y)$ e $tau_(x z)$.

#canvas(length: 1cm, {
  import draw: *
  // Assi
  line((0, 0), (7.6, 0), mark: (end: ">"), stroke: 0.7pt)
  content((7.45, 0.25), text(size: 7pt)[$x$])
  line((0, 0), (0, 2.3), mark: (end: ">"), stroke: 0.7pt)
  content((-0.25, 2.15), text(size: 7pt)[$y$])
  line((0, 0), (-0.85, -0.7), mark: (end: ">"), stroke: 0.7pt)
  content((-0.6, -0.8), text(size: 7pt)[$z$])

  // Base sinistra (x=0.4)
  bezier((0.45, 1.25), (-0.35, 0.3), (-0.05, 1.2), (-0.4, 0.8), stroke: 1.2pt)
  bezier((-0.35, 0.3), (-0.2, -0.5), (-0.3, -0.1), (-0.05, -0.2), stroke: 1.2pt)
  bezier((-0.2, -0.5), (0.15, -1.25), (-0.35, -0.8), (-0.15, -1.2), stroke: 1.2pt)
  bezier((0.45, 1.25), (0.45, 0.1), (0.95, 0.9), (0.15, 0.5), stroke: (dash: "dashed", thickness: 0.7pt))
  bezier((0.45, 0.1), (0.15, -1.25), (0.85, -0.3), (0.75, -1.0), stroke: (dash: "dashed", thickness: 0.7pt))

  // Linee longitudinali cilindro completo
  line((0.45, 1.25), (6.55, 1.25), stroke: 1.2pt)
  line((0.15, -1.25), (6.25, -1.25), stroke: 1.2pt)

  // Sezione intermedia (x=3.3)
  bezier((3.45, 1.25), (2.65, 0.3), (2.95, 1.2), (2.6, 0.8), stroke: 1.2pt)
  bezier((2.65, 0.3), (2.8, -0.5), (2.7, -0.1), (2.95, -0.2), stroke: 1.2pt)
  bezier((2.8, -0.5), (3.15, -1.25), (2.65, -0.8), (2.85, -1.2), stroke: 1.2pt)
  bezier((3.45, 1.25), (3.45, 0.1), (3.95, 0.9), (3.15, 0.5), stroke: (dash: "dashed", thickness: 0.7pt))
  bezier((3.45, 0.1), (3.15, -1.25), (3.85, -0.3), (3.75, -1.0), stroke: (dash: "dashed", thickness: 0.7pt))

  // Base destra (x=6.4)
  bezier((6.55, 1.25), (5.75, 0.3), (6.05, 1.2), (5.7, 0.8), stroke: 1.2pt)
  bezier((5.75, 0.3), (5.9, -0.5), (5.8, -0.1), (6.05, -0.2), stroke: 1.2pt)
  bezier((5.9, -0.5), (6.25, -1.25), (5.75, -0.8), (5.95, -1.2), stroke: 1.2pt)
  bezier((6.55, 1.25), (6.55, 0.1), (7.05, 0.9), (6.25, 0.5), stroke: 1.2pt)
  bezier((6.55, 0.1), (6.25, -1.25), (6.95, -0.3), (6.85, -1.0), stroke: 1.2pt)

  // Componenti di tensione in blu sulla sezione intermedia (origine locale (3.3, 0))
  line((3.3, 0), (4.25, 0), mark: (end: ">"), stroke: (paint: blue, thickness: 1.2pt))
  content((4.55, -0.25), text(size: 7pt)[$sigma_(x x)$])
  line((3.3, 0), (3.3, 0.85), mark: (end: ">"), stroke: (paint: blue, thickness: 1.2pt))
  content((2.95, 0.5), text(size: 7pt)[$tau_(x y)$])
  line((3.3, 0), (2.2, -0.7), mark: (end: ">"), stroke: (paint: blue, thickness: 1.2pt))
  content((2.2, -0.25), text(size: 7pt)[$tau_(x z)$])
})

== Relazioni di equivalenza statica sulla sezione

Analizziamo ora singolarmente il legame integrale che intercorre tra ciascuna delle sei caratteristiche di sollecitazione interne e le tre componenti di tensione non nulle ($sigma_(x x), tau_(x y), tau_(x z)$) agenti sull'area elementare $d A$ della sezione trasversale di area complessiva $A$.

=== Sollecitazioni associate alla tensione normale $sigma_(x x)$: $N_x$, $M_z$, $M_y$

1. *Sforzo normale $N_x$*: considerando l'azione del solo sforzo normale $N_x$, l'unica componente di tensione in grado di generarlo per traslazione lungo l'asse del cilindro è la tensione normale $sigma_(x x)$, che agisce perpendicolarmente alla sezione trasversale nella medesima direzione $x$. La forza elementare su $d A$ vale $sigma_(x x) d A$, da cui si ottiene la prima *Relazione di Equivalenza*:

$ integral_A sigma_(x x) d A = N_x $

2. *Momento flettente $M_z$*: considerando l'azione del solo momento flettente $M_z$ (vettore momento diretto lungo l'asse $z$), l'unica componente di tensione che può generarlo è ancora la tensione normale $sigma_(x x)$, poiché è l'unica forza diretta lungo $x$ che sulla sezione trasversale possiede braccio $y$ rispetto all'asse $z$. Tenendo conto della regola della mano destra (un'area $d A$ a ordinata $y > 0$ soggetta a $sigma_(x x) > 0$ produce un momento orario opposto al verso positivo di $z$), la *Relazione di Equivalenza* risulta:

$ integral_A -sigma_(x x) y d A = M_z $

3. *Momento flettente $M_y$*: analogamente, per il momento flettente $M_y$ (diretto lungo l'asse $y$), l'unica componente di tensione capace di produrre momento attorno all'asse $y$ è la tensione normale $sigma_(x x)$ grazie al braccio $z$ rispetto all'asse $y$ stesso. Poiché una forza diretta lungo $+x$ con braccio $z > 0$ genera una rotazione concorde con l'asse $+y$, la *Relazione di Equivalenza* si scrive:

$ integral_A sigma_(x x) z d A = M_y $

#canvas(length: 2cm, {
  import draw: *
  // PANNELLO 1 (x da 0 a 2.6): Sforzo normale Nx
  line((0, 0), (2.7, 0), mark: (end: ">"), stroke: 0.6pt)
  content((2.65, 0.2), text(size: 7pt)[$x$])
  line((0, 0), (0, 1.5), mark: (end: ">"), stroke: 0.6pt)
  content((-0.2, 1.4), text(size: 7pt)[$y$])
  line((0, 0), (-0.5, -0.45), mark: (end: ">"), stroke: 0.6pt)
  content((-0.35, -0.55), text(size: 7pt)[$z$])

  arc((0.2, 0), start: 90deg, stop: 270deg, radius: (0.35, 0.85), anchor: "origin", stroke: 1.0pt)
  arc((0.2, 0), start: -90deg, stop: 90deg, radius: (0.35, 0.85), anchor: "origin", stroke: (dash: "dashed", thickness: 0.5pt))
  line((0.2, 0.85), (1.7, 0.85), stroke: 1.0pt)
  line((0.2, -0.85), (1.7, -0.85), stroke: 1.0pt)
  circle((1.7, 0), radius: (0.35, 0.85), stroke: 1.0pt)

  // dA, sigma_xx e Nx
  line((1.65, 0.35), (1.8, 0.45), (1.8, 0.65), (1.65, 0.55), close: true, stroke: 0.6pt)
  content((1.45, 0.35), text(size: 7pt)[$d A$])
  line((1.72, 0.5), (2.15, 0.5), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
  content((2.35, 0.75), text(size: 7pt)[$sigma_(x x)$])
  line((1.7, 0), (2.45, 0), mark: (end: ">"), stroke: (paint: rgb("#e60000"), thickness: 1.4pt))
  content((2.3, -0.35), text(size: 7pt, fill: rgb("#e60000"))[$N_x$])

  // PANNELLO 2 (traslato di +3.2 lungo x): Momento flettente Mz
  line((3.2, 0), (5.9, 0), mark: (end: ">"), stroke: 0.6pt)
  content((5.85, 0.2), text(size: 7pt)[$x$])
  line((3.2, 0), (3.2, 1.5), mark: (end: ">"), stroke: 0.6pt)
  content((3.0, 1.4), text(size: 7pt)[$y$])
  line((3.2, 0), (2.7, -0.45), mark: (end: ">"), stroke: 0.6pt)
  content((2.85, -0.55), text(size: 7pt)[$z$])

  arc((3.4, 0), start: 90deg, stop: 270deg, radius: (0.35, 0.85), anchor: "origin", stroke: 1.0pt)
  arc((3.4, 0), start: -90deg, stop: 90deg, radius: (0.35, 0.85), anchor: "origin", stroke: (dash: "dashed", thickness: 0.5pt))
  line((3.4, 0.85), (4.9, 0.85), stroke: 1.0pt)
  line((3.4, -0.85), (4.9, -0.85), stroke: 1.0pt)
  circle((4.9, 0), radius: (0.35, 0.85), stroke: 1.0pt)

  // dA, quota y, sigma_xx e Mz
  line((4.85, -0.45), (5.0, -0.35), (5.0, -0.2), (4.85, -0.3), close: true, stroke: 0.6pt)
  content((4.95, -0.65), text(size: 7pt)[$d A$])
  line((4.92, 0), (4.92, -0.32), mark: (start: ">", end: ">"), stroke: (dash: "dotted", thickness: 0.6pt))
  content((4.72, -0.18), text(size: 7pt)[$y$])
  line((4.92, -0.32), (5.35, -0.32), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
  content((5.55, -0.15), text(size: 7pt)[$sigma_(x x)$])
  arc((5.75, 0), start: -45deg, stop: 45deg, radius: 0.45, anchor: "origin", mark: (end: ">"), stroke: (paint: rgb("#0072bd"), thickness: 1.3pt))
  content((6.25, 0.0), text(size: 7pt, fill: rgb("#0072bd"))[$M_z$])

  // PANNELLO 3 (traslato di +6.5 lungo x): Momento flettente My
  line((6.5, 0), (9.1, 0), mark: (end: ">"), stroke: 0.6pt)
  content((9.05, 0.2), text(size: 7pt)[$x$])
  line((6.5, 0), (6.5, 1.5), mark: (end: ">"), stroke: 0.6pt)
  content((6.3, 1.4), text(size: 7pt)[$y$])
  line((6.5, 0), (6.0, -0.45), mark: (end: ">"), stroke: 0.6pt)
  content((6.15, -0.55), text(size: 7pt)[$z$])

  arc((6.7, 0), start: 90deg, stop: 270deg, radius: (0.35, 0.85), anchor: "origin", stroke: 1.0pt)
  arc((6.7, 0), start: -90deg, stop: 90deg, radius: (0.35, 0.85), anchor: "origin", stroke: (dash: "dashed", thickness: 0.5pt))
  line((6.7, 0.85), (8.2, 0.85), stroke: 1.0pt)
  line((6.7, -0.85), (8.2, -0.85), stroke: 1.0pt)
  circle((8.2, 0), radius: (0.35, 0.85), stroke: 1.0pt)

  // dA, quota z, sigma_xx e My
  line((8.35, -0.35), (8.5, -0.25), (8.5, -0.1), (8.35, -0.2), close: true, stroke: 0.6pt)
  content((8.45, -0.55), text(size: 7pt)[$d A$])
  line((8.2, -0.35), (8.42, -0.22), mark: (start: ">", end: ">"), stroke: (dash: "dotted", thickness: 0.6pt))
  content((8.15, -0.15), text(size: 7pt)[$z$])
  line((8.42, -0.22), (8.85, -0.22), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
  content((9.05, -0.25), text(size: 7pt)[$sigma_(x x)$])
  arc((8.2, 0.05), start: 195deg, stop: 345deg, radius: (0.28, 0.12), anchor: "origin", mark: (end: ">"), stroke: (paint: rgb("#008000"), thickness: 1.3pt))
  content((8.2, 0.3), text(size: 7pt, fill: rgb("#008000"))[$M_y$])
})

=== Sollecitazioni associate alle tensioni tangenziali $tau_(x z)$ e $tau_(x y)$: $T_z$, $T_y$, $M_x$

1. *Sforzo di taglio $T_z$*: considerando l'azione del solo sforzo di taglio $T_z$, l'unica componente di tensione che può generarlo è la tensione tangenziale $tau_(x z)$, in quanto agisce sul piano della sezione trasversale esattamente nella direzione e nel verso dell'asse $z$. Integrando sull'area della sezione si ottiene la *Relazione di Equivalenza*:

$ integral_A tau_(x z) d A = T_z $

2. *Sforzo di taglio $T_y$*: in modo del tutto duale, considerando l'azione del solo sforzo di taglio $T_y$, l'unica componente di tensione che agisce sulla sezione trasversale lungo la direzione verticale $y$ è la tensione tangenziale $tau_(x y)$. La corrispondente *Relazione di Equivalenza* è:

$ integral_A tau_(x y) d A = T_y $

3. *Momento torcente $M_x$*: consideriamo infine l'azione del solo momento torcente $M_x$ (diretto lungo l'asse longitudinale $x$ della trave). Le uniche componenti di tensione in grado di generarlo sono quelle che giacciono nel piano della sezione trasversale e risultano dotate di braccio rispetto al polo sull'asse $x$, ovvero entrambe le tensioni tangenziali $tau_(x y)$ e $tau_(x z)$. Sull'area elementare $d A$ di coordinate $(y, z)$:
  - la forza tangenziale verticale $tau_(x y) d A$ ha braccio $z$ rispetto all'asse $x$ e produce un momento negativo (orario rispetto a $+x$), pari a $-tau_(x y) z d A$;
  - la forza tangenziale orizzontale $tau_(x z) d A$ ha braccio $y$ rispetto all'asse $x$ e produce un momento positivo (antiorario rispetto a $+x$), pari a $+tau_(x z) y d A$.

Sommando i due contributi ed estendendo l'integrale a tutta la sezione $A$, si ottiene la *Relazione di Equivalenza* per la torsione:

$ integral_A (-tau_(x y) z + tau_(x z) y) d A = M_x $

#canvas(length: 2cm, {
  import draw: *
  // PANNELLO 1 (x da 0 a 2.6): Taglio Tz
  line((0, 0), (2.7, 0), mark: (end: ">"), stroke: 0.6pt)
  content((2.65, 0.2), text(size: 7pt)[$x$])
  line((0, 0), (0, 1.5), mark: (end: ">"), stroke: 0.6pt)
  content((-0.2, 1.4), text(size: 7pt)[$y$])
  line((0, 0), (-0.5, -0.45), mark: (end: ">"), stroke: 0.6pt)
  content((-0.35, -0.55), text(size: 7pt)[$z$])

  arc((0.2, 0), start: 90deg, stop: 270deg, radius: (0.35, 0.85), anchor: "origin", stroke: 1.0pt)
  arc((0.2, 0), start: -90deg, stop: 90deg, radius: (0.35, 0.85), anchor: "origin", stroke: (dash: "dashed", thickness: 0.5pt))
  line((0.2, 0.85), (1.7, 0.85), stroke: 1.0pt)
  line((0.2, -0.85), (1.7, -0.85), stroke: 1.0pt)
  circle((1.7, 0), radius: (0.35, 0.85), stroke: 1.0pt)

  // dA, tau_xz e Tz
  line((1.65, 0.4), (1.8, 0.5), (1.8, 0.68), (1.65, 0.58), close: true, stroke: 0.6pt)
  content((1.75, 0.9), text(size: 7pt)[$d A$])
  line((1.72, 0.54), (1.35, 0.25), mark: (end: ">"), stroke: (paint: rgb("#800040"), thickness: 0.9pt))
  content((1.65, 0.2), text(size: 7pt)[$tau_(x z)$])
  line((1.7, 0), (1.0, -0.6), mark: (end: ">"), stroke: (paint: rgb("#0072bd"), thickness: 1.4pt))
  content((0.9, -0.3), text(size: 7pt, fill: rgb("#0072bd"))[$T_z$])

  // PANNELLO 2 (traslato di +3.2 lungo x): Taglio Ty
  line((3.2, 0), (5.9, 0), mark: (end: ">"), stroke: 0.6pt)
  content((5.85, 0.2), text(size: 7pt)[$x$])
  line((3.2, 0), (3.2, 1.5), mark: (end: ">"), stroke: 0.6pt)
  content((3.0, 1.4), text(size: 7pt)[$y$])
  line((3.2, 0), (2.7, -0.45), mark: (end: ">"), stroke: 0.6pt)
  content((2.85, -0.55), text(size: 7pt)[$z$])

  arc((3.4, 0), start: 90deg, stop: 270deg, radius: (0.35, 0.85), anchor: "origin", stroke: 1.0pt)
  arc((3.4, 0), start: -90deg, stop: 90deg, radius: (0.35, 0.85), anchor: "origin", stroke: (dash: "dashed", thickness: 0.5pt))
  line((3.4, 0.85), (4.9, 0.85), stroke: 1.0pt)
  line((3.4, -0.85), (4.9, -0.85), stroke: 1.0pt)
  circle((4.9, 0), radius: (0.35, 0.85), stroke: 1.0pt)

  // dA, tau_xy e Ty
  line((4.9, -0.55), (5.05, -0.45), (5.05, -0.28), (4.9, -0.38), close: true, stroke: 0.6pt)
  content((4.85, -0.15), text(size: 7pt)[$d A$])
  line((4.98, -0.42), (4.98, -0.05), mark: (end: ">"), stroke: (paint: rgb("#800040"), thickness: 0.9pt))
  content((5.0, -0.7), text(size: 7pt)[$tau_(x y)$])
  line((4.9, 0), (4.9, 1.35), mark: (end: ">"), stroke: (paint: rgb("#008000"), thickness: 1.4pt))
  content((4.55, 1.25), text(size: 7pt, fill: rgb("#008000"))[$T_y$])

  // PANNELLO 3 (traslato di +6.4 lungo x): Momento torcente Mx
  line((6.4, 0), (9.3, 0), mark: (end: ">"), stroke: 0.6pt)
  content((9.2, -0.25), text(size: 7pt)[$x$])
  line((6.4, 0), (6.4, 1.5), mark: (end: ">"), stroke: 0.6pt)
  content((6.2, 1.4), text(size: 7pt)[$y$])
  line((6.4, 0), (5.9, -0.45), mark: (end: ">"), stroke: 0.6pt)
  content((6.05, -0.55), text(size: 7pt)[$z$])

  arc((6.6, 0), start: 90deg, stop: 270deg, radius: (0.35, 0.85), anchor: "origin", stroke: 1.0pt)
  arc((6.6, 0), start: -90deg, stop: 90deg, radius: (0.35, 0.85), anchor: "origin", stroke: (dash: "dashed", thickness: 0.5pt))
  line((6.6, 0.85), (8.1, 0.85), stroke: 1.0pt)
  line((6.6, -0.85), (8.1, -0.85), stroke: 1.0pt)
  circle((8.1, 0), radius: (0.35, 0.85), stroke: 1.0pt)

  // dA, bracci y e z, tau_xy, tau_xz e Mx
  line((8.15, -0.52), (8.3, -0.42), (8.3, -0.25), (8.15, -0.35), close: true, stroke: 0.6pt)
  content((8.0, 0.6), text(size: 7pt)[$d A$])
  line((7.8, -0.2), (7.8, -0.62), mark: (start: ">", end: ">"), stroke: (dash: "dotted", thickness: 0.6pt))
  content((7.62, -0.42), text(size: 7pt)[$y$])
  line((8.0, 0.25), (8.28, 0.45), mark: (start: ">", end: ">"), stroke: (dash: "dotted", thickness: 0.6pt))
  content((8.15, 0.2), text(size: 7pt)[$z$])

  line((8.22, -0.38), (8.22, 0.1), mark: (end: ">"), stroke: (paint: rgb("#800040"), thickness: 0.9pt))
  content((8.0, -0.15), text(size: 7pt)[$tau_(x y)$])
  line((8.22, -0.38), (7.85, -0.62), mark: (end: ">"), stroke: (paint: rgb("#800040"), thickness: 0.9pt))
  content((8.25, -0.7), text(size: 7pt)[$tau_(x z)$])

  arc((8.85, 0.0), start: -110deg, stop: 160deg, radius: (0.14, 0.55), anchor: "origin", mark: (end: ">"), stroke: (paint: rgb("#e60000"), thickness: 1.3pt))
  content((9.15, 0.65), text(size: 7pt, fill: rgb("#e60000"))[$M_x$])
})

#nota[
*Riepilogo delle 6 Relazioni di Equivalenza nel solido di de Saint Venant:*
$ cases(
  N_x = integral_A sigma_(x x) d A,
  M_z = integral_A -sigma_(x x) y d A,
  M_y = integral_A sigma_(x x) z d A
) quad "e" quad cases(
  T_z = integral_A tau_(x z) d A,
  T_y = integral_A tau_(x y) d A,
  M_x = integral_A (-tau_(x y) z + tau_(x z) y) d A
) $
Si osserva il completo disaccoppiamento statico: lo sforzo normale $N_x$ e i momenti flettenti $M_y, M_z$ dipendono esclusivamente dalla distribuzione della tensione normale $sigma_(x x)$, mentre gli sforzi di taglio $T_y, T_z$ e il momento torcente $M_x$ dipendono esclusivamente dalle tensioni tangenziali $tau_(x y), tau_(x z)$.
]
