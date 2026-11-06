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
= *Ruote Dentate e Trasmissioni ad Ingranaggi*

La trasmissione del moto tramite ingranaggi avviene per *ingranamento* tra i denti a *profilo coniugato* di due ruote. Si tratta quindi di una trasmissione per contatto diretto tra superfici, attraverso il quale viene trasferita la coppia dalla ruota che impone il moto (detta *conduttrice*, *motrice* o *pignone*) alla ruota che viene trascinata in rotazione, detta *condotta*.

A seconda delle condizioni di carico e della disposizione geometrica degli alberi tra i quali si trasmette il moto, le ruote dentate si dividono in diverse famiglie (cilindriche, coniche, a vite senza fine) e possono essere dotate di *denti diritti* oppure *elicoidali*.

== Classificazione geometrica 

/ Ruote cilindriche a denti diritti (_spur gears_): impiegate per collegare alberi ad *assi paralleli* in applicazioni caratterizzate da velocità e potenze non eccessivamente elevate. Lo sviluppo longitudinale del dente risulta parallelo all'asse di rotazione della ruota.
/ Ruote cilindriche a denti elicoidali: impiegate anch'esse per *assi paralleli*; in questo caso i denti si sviluppano lungo la larghezza di fascia seguendo un tratto di elica, risultando quindi obliqui rispetto all'asse della ruota.
/ Ruote coniche (o troncoconiche): utilizzate per trasmettere il moto tra alberi con *assi incidenti* (tipicamente ortogonali a $90^degree$). La parte solida della ruota è costituita da un tronco di cono sulla cui superficie laterale sono ricavati i denti, i quali possono avere sviluppo sia diritto sia elicoidale.
/ Vite senza fine e ruota elicoidale coniugata: impiegate per alberi con *assi sghembi* (solitamente ruotati nello spazio di $90^degree$). La vite presenta una dentatura elicoidale continua del tutto analoga a una filettatura: ruotando attorno al proprio asse senza traslare, essa produce l'effetto apparente di un avanzamento continuo (_"senza fine"_) che ingrana e trascina in rotazione la ruota dentata coniugata.

#v(1em)

=== Confronto tra dentatura diritta ed elicoidale

La scelta tra uno sviluppo del dente diritto o elicoidale comporta importanti differenze nel comportamento dinamico, acustico e nello stato di sollecitazione degli alberi:

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  block[
    *Azioni assiali* \
    Nei *denti diritti* la forza scambiata tra i fianchi è interamente contenuta nel piano di rotazione. Al contrario, nei *denti elicoidali*, poiché il fianco del dente è obliquo rispetto all'asse, la risultante della pressione di contatto genera anche una *componente assiale* lungo l'asse dell'albero. Tale spinta deve essere opportunamente sopportata dai cuscinetti, oppure può essere sfruttata progettualmente per contrastare altre spinte assiali presenti nel sistema.
  ],
  block[
    *Gradualità del contatto e rumorosità* \
    Nelle ruote cilindriche a *denti diritti* l'accoppiamento avviene in modo brusco e simultaneo lungo un'intera retta di contatto su tutta la larghezza del fianco. Nelle ruote a *denti elicoidali* in presa, invece, le due eliche (di verso opposto) si accoppiano in modo *graduale*, interessando progressivamente una porzione crescente del dente: questo ingranamento progressivo *riduce la rumorosità* e aumenta la precisione e la fluidità della trasmissione.
  ]
)

#v(1em)

#nota[
*Ruolo delle ruote cilindriche a denti diritti*: lo studio geometrico e progettuale si concentra prevalentemente sulle ruote cilindriche a denti diritti poiché, in letteratura, esse costituiscono il modello di riferimento per tutte le altre tipologie. Per qualunque altra geometria (elicoidale, conica, ecc.) è infatti sempre possibile definire un *piano ausiliario* nel quale la dentatura appare e si comporta esattamente come quella di una ruota cilindrica a denti diritti virtuale: il proporzionamento viene eseguito in tale piano e i parametri risultanti (numero di denti, passo, modulo) vengono poi riportati, tramite relazioni geometriche, ai dati costruttivi effettivi della ruota reale.
]

#v(1em)

=== Azione coniugata tra i profili

L'azione tra due profili a contatto si definisce *coniugata* se garantisce un *rapporto delle velocità angolari costante* nel tempo. Tale condizione geometrica è indispensabile per assicurare la continuità del contatto e della trasmissione di potenza durante la rotazione: profili non coniugati (o discontinui) causerebbero infatti perdite di contatto e saltellamenti dinamici inaccettabili nei sistemi meccanici. Per lo stesso motivo, l'ingranamento viene progettato affinché una coppia di denti non lasci mai il contatto prima che la coppia successiva sia già entrata in presa.

Durante la rotazione relativa dei due corpi, la posizione del *punto di contatto istantaneo* $C$ non rimane fissa nello spazio, ma si sposta progressivamente (_"cammina"_) lungo la superficie dei profili coniugati. In ogni istante, nel punto $C$ le due superfici risultano tangenti tra loro e le azioni dinamiche (in assenza di attrito) si sviluppano interamente lungo la direzione normale comune ai profili, individuata dalla retta $a$-$b$.

#v(0.5em)

#grid(
  columns: (1.3fr, 1fr),
  column-gutter: 2em,
  align: (left + horizon, center + horizon),
  [
==== Nomenclatura geometrica
    
    / Punto di contatto ($C$): punto di tangenza istantaneo tra i due profili coniugati dei corpi $A$ e $B$.
    / Retta d'azione o di pressione ($a$-$b$): retta normale comune ai due profili nel punto di contatto $C$, lungo la quale si sviluppano le forze scambiate.
    / Interasse ($O O'$): segmento congiungente i centri di istantanea rotazione $O$ e $O'$ dei due corpi, che rappresenta fisicamente la distanza tra gli assi degli alberi.
    / Centro di istantanea rotazione relativa ($P$): detto anche *punto primitivo*, è l'intersezione tra la retta d'azione $a$-$b$ e la linea dei centri $O O'$.
    / Circonferenze primitive ($r_A, r_B$): circonferenze ideali tracciate dai rispettivi centri di rotazione $O$ e $O'$ e passanti per il punto di tangenza comune $P$.
  ],
  move(dx : 10pt)[

#canvas(length: 1.25cm, {

import draw: *

// 1. RIEMPIMENTI GRIGI DEI CORPI A e B (stroke: none, i contorni esatti sono disegnati al passo 2)
// Riempimento corpo B
line(
  (0.67, 0.09), (-0.01, 5.24), (-0.08, 5.48), (-0.24, 5.66), (-0.46, 5.76),
  (-0.70, 5.76), (-0.94, 5.65), (-1.12, 5.45), (-1.21, 5.22), (-1.23, 5.06),
  (-0.67, -0.09), (-0.60, -0.35), (-0.42, -0.55), (-0.18, -0.66), (0.08, -0.67),
  (0.34, -0.58), (0.54, -0.39), (0.65, -0.15),
  close: true, fill: luma(220), stroke: none
)

// Riempimento corpo A
line(
  (-0.07, 7.35), (0.28, 7.30), (0.58, 7.12), (0.78, 6.84), (0.85, 6.50),
  (0.78, 6.16), (0.58, 5.88), (0.28, 5.70), (0.00, 5.65), (-0.30, 5.70),
  (-0.48, 5.82), (-0.65, 6.02), (-0.78, 6.15), (-0.92, 6.18), (-1.06, 6.12),
  (-1.16, 5.95), (-1.21, 5.65), (-1.22, 5.05), (-1.30, 4.72), (-1.45, 4.44),
  (-1.68, 4.25), (-1.95, 4.17), (-2.22, 4.20), (-2.48, 4.36), (-2.68, 4.62),
  (-2.81, 4.98), (-2.86, 5.40), (-2.82, 5.82), (-2.66, 6.25), (-2.38, 6.62),
  (-1.96, 6.94), (-1.42, 7.17), (-0.78, 7.31),
  close: true, fill: luma(220), stroke: none
)

// 2. CONTORNI DEI CORPI E FORI DEI PERNI
// Contorno Corpo B
arc((0, 0), start: 188deg, stop: 368deg, radius: 0.68, anchor: "origin", stroke: 0.8pt)
line((0.67, 0.09), (-0.01, 5.24), stroke: 0.8pt)
arc((-0.62, 5.15), start: 8deg, stop: 188deg, radius: 0.62, anchor: "origin", stroke: 0.8pt)
line((-1.23, 5.06), (-0.67, -0.09), stroke: 0.8pt)
circle((0, 0), radius: 0.32, stroke: 0.8pt)

// Contorno Corpo A
// Testa circolare attorno a O_A
arc((0, 6.50), start: 235deg, stop: 455deg, radius: 0.85, anchor: "origin", stroke: 0.8pt)
// Gola interna (da sotto O_A fino alla sommità della gola)
bezier((-0.49, 5.80), (-0.92, 6.18), (-0.65, 5.95), (-0.78, 6.18), stroke: 0.8pt)
// Parete interna della gola fino al punto di contatto C(-1.22, 5.05)
bezier((-0.92, 6.18), (-1.22, 5.05), (-1.18, 6.18), (-1.22, 5.65), stroke: 0.8pt)
// Dal punto C(-1.22, 5.05) al fondo del lobo inferiore (-2.05, 4.18)
bezier((-1.22, 5.05), (-2.05, 4.18), (-1.26, 4.60), (-1.62, 4.18), stroke: 0.8pt)
// Dal fondo del lobo (-2.05, 4.18) al fianco estremo sinistro (-2.86, 5.40)
bezier((-2.05, 4.18), (-2.86, 5.40), (-2.52, 4.18), (-2.86, 4.75), stroke: 0.8pt)
// Dal fianco sinistro (-2.86, 5.40) alla sommità della testa (-0.07, 7.35)
bezier((-2.86, 5.40), (-0.07, 7.35), (-2.86, 6.65), (-1.45, 7.35), stroke: 0.8pt)
// Foro del perno O_A
circle((0, 6.50), radius: 0.32, stroke: 0.8pt)

// 3. ASSI, CIRCONFERENZE PRIMITIVE E RETTA D'AZIONE
// Asse verticale dei centri O_A - O_B
line((0, -0.95), (0, 7.60), stroke: 0.6pt)

// Crocini orizzontali sui perni O_A e O_B (tratteggiati lunghi)
line((-0.80, 6.50), (-0.18, 6.50), stroke: 0.6pt)
line((-0.10, 6.50), (0.10, 6.50), stroke: 0.6pt)
line((0.18, 6.50), (0.80, 6.50), stroke: 0.6pt)

line((-0.80, 0), (-0.18, 0), stroke: 0.6pt)
line((-0.10, 0), (0.10, 0), stroke: 0.6pt)
line((0.18, 0), (0.80, 0), stroke: 0.6pt)

// Circonferenza primitiva A (centro (0, 6.50), raggio 1.80, punto-tratto)
arc((0, 6.50), start: 184deg, stop: 326deg, radius: 1.80, anchor: "origin", stroke: (dash: "dash-dotted", thickness: 0.7pt))

// Circonferenza primitiva B (centro (0, 0), raggio 4.70, punto-tratto)
arc((0, 0), start: 46deg, stop: 122deg, radius: 4.70, anchor: "origin", stroke: (dash: "dash-dotted", thickness: 0.7pt))

// Retta d'azione a - b (passante per C(-1.22, 5.05) e P(0, 4.70), punto-tratto)
line((-3.30, 5.65), (1.12, 4.38), stroke: (dash: "dash-dotted", thickness: 0.7pt))
line((1.42, 4.29), (2.75, 3.91), stroke: (dash: "dash-dotted", thickness: 0.7pt))

// 4. VETTORI RAGGIO, FRECCE DI ROTAZIONE E PUNTI C, P
// Raggio r_A da (0, 6.50) a (1.42, 5.39)
line((0, 6.50), (0.68, 5.97), stroke: 0.7pt)
line((1.02, 5.70), (1.42, 5.39), mark: (end: "stealth", fill: black, scale: 0.8), stroke: 0.7pt)

// Raggio r_B da (0, 0) a (3.02, 3.60)
line((0, 0), (1.28, 1.53), stroke: 0.7pt)
line((1.62, 1.93), (3.02, 3.60), mark: (end: "stealth", fill: black, scale: 0.8), stroke: 0.7pt)

// Freccia di rotazione superiore (antioraria)
arc((0, 6.50), start: 22deg, stop: 68deg, radius: 1.12, anchor: "origin", mark: (end: "stealth", fill: black, scale: 0.9), stroke: 0.7pt)

// Freccia di rotazione inferiore (oraria)
arc((0, 0), start: 210deg, stop: 252deg, radius: 0.98, anchor: "origin", mark: (start: "stealth", fill: black, scale: 0.9), stroke: 0.7pt)

// Punti C e P
circle((-1.22, 5.05), radius: 0.07, fill: black, stroke: none)
circle((0, 4.70), radius: 0.07, fill: black, stroke: none)

// 5. ETICHETTE
content((-0.60, 6.92), [A])
content((0.35, 6.92), [O])
content((0.86, 5.86), [r_A])

content((-3.28, 6), [a])
content((-1.42, 4.88), [C])
content((-0.20, 4.46), [P])
content((1.27, 4.35), [b])

content((1.45, 1.72), [r_B])
content((-0.42, 0.48), [B])
content((0.40, -0.35), [O])
})

  ]
)

#v(1em)
*Condizione di coniugazione (Punto fisso $P$)* \
    Affinché il *rapporto di trasmissione rimanga costante*, tutte le rette d'azione $a$-$b$ devono intersecare l'interasse $O O'$ sempre nel medesimo *punto fisso $P$*. Questa proprietà fondamentale deve valere in ogni istante del moto, indipendentemente dalla posizione assunta dal punto di contatto istantaneo $C$ e indipendentemente dal fatto che la retta d'azione rimanga fissa nello spazio oppure cambi inclinazione al variare del contatto.\
    Le circonferenze primitive di raggio $r_A$ e $r_B$ non corrispondono a uno spigolo o a un bordo fisico solido della ruota. Esse rappresentano invece la sezione di *due cilindri ideali* posti a contatto esterno nel punto di tangenza $P$: ruotando in versi opposti per puro rotolamento (*senza strisciare*), tali cilindri realizzerebbero esattamente lo stesso rapporto di trasmissione dei due corpi dentati reali.

#v(1em)

== Il profilo ad evolvente di cerchio

Tra le infinite curve matematiche che soddisfano la condizione di coniugazione, il *profilo ad evolvente di cerchio* è quello universalmente adottato nelle costruzioni meccaniche poiché consente di ottenere un'*unica retta d'azione fissa nello spazio*, lungo la quale si trovano tutti i punti di contatto istantaneo tra le due ruote.

*Limiti di un profilo coniugato generico* \
    Mentre denti a forma di semplice parallelepipedo non garantirebbero nemmeno l'azione coniugata, un profilo coniugato generico assicura che la retta d'azione passi sempre per il punto primitivo $P$, ma non impedisce che essa possa *basculare* (oscillando attorno a $P$ come una cerniera) al variare del punto di contatto. Una direzione della forza variabile nel tempo genererebbe notevoli difficoltà sia nella predizione del comportamento dinamico del sistema, sia nel dimensionamento strutturale degli organi.

*Vantaggi dell'evolvente di cerchio* \
    Con l'evolvente di cerchio la retta d'azione (che interseca sempre in $P$ la congiungente dei centri $O$ e $O'$) resta *fissa ed invariabile nel tempo*, coincidendo con la tangente comune ai due cerchi di base: il punto di contatto si muove semplicemente avanti e indietro lungo tale segmento mentre scorre sul fianco del dente. La forza scambiata mantiene così una *direzione costante*, rendendo ben determinate le componenti tangenziali, radiali ed assiali. Inoltre, l'evolvente è descritta da una funzione matematica semplice e analiticamente nota, che agevola i calcoli e il tracciamento geometrico.


== Generazione geometrica e cinematica dell'evolvente

 il profilo ad evolvente può essere interpretato fisicamente come la traccia lasciata su un'ala cartacea $B$ (solidale al contorno di un cilindro di base ideale $A$) quando il cilindro ruota, da una punta scrivente mantenuta in posizione $b$ a distanza fissa dal punto di tangenza $e$ (come se appartenesse a un tratto rigido che si svolge dal cilindro).

#grid(
  columns: (1.2fr, 1fr),
  column-gutter: 1.5em,
  align: (left + horizon, center + horizon),
  [
==== Elementi del tracciamento
    
    / Cilindro (o cerchio) di base ($A$): disco ideale di centro $O$ attorno al quale si avvolge il filo generatore.
    / Piano solidale ($B$): settore anulare solidale al disco $A$ su cui viene tracciata la curva del fianco del dente.
    / Filo inestensibile ($f$-$e$-$d$): avvolto sul disco nel tratto $f$-$e$ e mantenuto perfettamente teso, rettilineo e tangente al cerchio di base nel punto $e$.
    / Evolvente di cerchio ($a$-$b$-$c$): curva analitica generata dall'estremità della matita (inizialmente in $a$ sul cerchio di base e passante per la posizione generica $b$) durante lo svolgimento del filo.
  ],
  [
#canvas(length: 1cm, {
import draw: *

// 1. RIEMPIMENTO E CONTORNO SOTTILE DEL DISCO A
circle((0, 0), radius: 2.50, fill: luma(220), stroke: 0.7pt)

// 2. SETTORE ANULARE B
line((-0.85, 2.35), (-1.44, 3.95), stroke: 0.7pt)
line((-2.21, 1.17), (-3.71, 1.97), stroke: 0.7pt)
arc((0, 0), start: 110deg, stop: 152deg, radius: 4.20, anchor: "origin", stroke: 0.7pt)

// 3. ASSI DI CENTRO CON CROCINO IN O
line((-2.85, 0), (-0.16, 0), stroke: 0.6pt)
line((-0.07, 0), (0.07, 0), stroke: 0.6pt)
line((0.16, 0), (2.85, 0), stroke: 0.6pt)

line((0, -2.85), (0, -0.16), stroke: 0.6pt)
line((0, -0.07), (0, 0.07), stroke: 0.6pt)
line((0, 0.16), (0, 2.85), stroke: 0.6pt)

// 4. CURVE IN GRASSETTO (FILO f-e-d ED EVOLVENTE a-b-c)
// Filo avvolto sul disco da f(-125deg) a e(86deg)
arc((0, 0), start: -125deg, stop: 86deg, radius: 2.50, anchor: "origin", stroke: 1.6pt)

// Filo teso rettilineo da e(0.17, 2.49) a d(-4.07, 2.79)
line((0.17, 2.49), (-4.07, 2.79), stroke: 1.6pt)

// Evolvente a - b - c
bezier((-2.02, 1.47), (-2.35, 2.67), (-2.28, 1.82), (-2.38, 2.25), stroke: 1.6pt)
bezier((-2.35, 2.67), (-2.11, 3.63), (-2.32, 3.00), (-2.22, 3.32), stroke: 1.6pt)

// 5. PUNTI NOTEVOLI (b, e, f)
circle((-2.35, 2.67), radius: 0.07, fill: black, stroke: none)
circle((0.17, 2.49), radius: 0.07, fill: black, stroke: none)
circle((-1.43, -2.05), radius: 0.07, fill: black, stroke: none)

// 6. ETICHETTE
content((0.26, 0.25), [O])
content((1.00, -1.05), [A])
content((-3.95, 1.80), [B])

content((-1.88, 1.32), [a])
content((-2.12, 2.92), [b])
content((-2.16, 3.88), [c])
content((-4.32, 2.80), [d])
content((0.20, 2.78), [e])
content((-1.55, -2.35), [f])
})
  ]
)

In termini cinematici, man mano che il cilindro $A$ ruota, il filo si svolge mantenendosi sempre teso e tangente al cerchio di base nel punto $e$, tracciando sul piano $B$ la curva $a$-$b$-$c$. Nell'accoppiamento reale tra due ruote dentate, i due cerchi di base lavorano quindi idealmente come *due pulegge collegate da una cinghia incrociata tesa*, la cui direzione coincide esattamente con la retta d'azione. 

Si noti che l'evolvente di cerchio così generata *non è un arco di circonferenza* (ha raggio di curvatura variabile), bensì una curva geometrica specifica dotata di una propria formulazione analitica esatta, *che non è necessario memorizzare* ma che traduce rigorosamente il modello fisico del filo che si svolge dal cilindro di base.



  *Proprietà fondamentali in esercizio* \
  Ipotizzando che i denti ad evolvente di cerchio siano perfettamente realizzati dal punto di vista geometrico e sufficientemente rigidi sotto carico, tale profilo assicura due vantaggi determinanti:
  #set enum(numbering: "a)")
  + Un *contatto continuo e regolare* nel tempo, privo di urti o saltellamenti.
  + Un *rapporto di trasmissione rigorosamente costante* tra le velocità angolari delle due ruote, che si mantiene tale *anche in presenza di piccole variazioni dell'interasse* (distanza tra i centri $O$ e $O'$) dovute a tolleranze di montaggio o inflessioni degli alberi.

=== Accoppiamento cinematico tra due ruote ad evolvente

Nel caso dell'ingranamento tra due ruote dentate, la geometria che governa la cinematica della trasmissione si fonda sull'interazione di tre elementi geometrici fondamentali:

/ Circonferenze primitive (tratteggiate): rappresentano il comportamento di due cilindri ideali premuti l'uno contro l'altro con un punto di contatto permanente in $P$. Ruotando senza strisciamento, essi esprimono in $P$ una velocità periferica comune puramente tangenziale (priva di componenti radiali); il rapporto tra i loro raggi determina il *rapporto delle velocità angolari* tra le due ruote.
/ Circonferenze di base (a tratto continuo): equivalgono alle due *pulegge ideali* che descriverebbero la trasmissione del moto se la retta d'azione fosse una fune inestensibile tesa che si avvolge e si svolge continuamente attorno ad esse.
/ Retta d'azione ($a$-$P$-$b$): è la tangente comune per definizione alle due circonferenze di base, passante per il punto primitivo $P$ e sempre normale alla superficie dei denti. Grazie alla scelta dei profili coniugati ad evolvente di cerchio, essa mantiene una *direzione fissa nel tempo* mentre il punto di contatto trasla lungo di essa.

#v(0.5em)

#grid(
  columns: (1.1fr, 1fr),
  column-gutter: 1.5em,
  align: (left + horizon, center + horizon),
  [
    === Nomenclatura dell'ingranamento
    
    / Centri di rotazione ($O_1, O_2$): assi delle due ruote coniugate (Ruota $1$ e Ruota $2$).
    / Punto primitivo ($P$): centro di istantanea rotazione relativa, punto di tangenza delle circonferenze primitive sull'interasse $O_1 O_2$.
    / Retta generatrice ($a$-$b$): segmento della retta d'azione tangente alle circonferenze di base nei punti estremi $a$ e $b$, assimilabile a una fune tesa avvolta sui due cerchi di base.
    / Punto generatore ($g$): punto di contatto istantaneo che, muovendosi lungo la generatrice $a$-$b$, traccia idealmente e simultaneamente i due profili coniugati ad evolvente $c$-$d$ (sulla Ruota $1$) ed $e$-$f$ (sulla Ruota $2$).
  ],
  [
// FASE 2 - COSTRUZIONE
#canvas(length: 1cm, {
import draw: *

// --- ASSI E LINEE DI CENTRO ---
// Asse verticale passante per O1, P, O2 (con piccoli spazi attorno alle croci dei centri)
line((0.00, 3.85), (0.00, 1.92), stroke: 0.7pt + black)
line((0.00, 1.68), (0.00, -3.18), stroke: 0.7pt + black)
line((0.00, -3.42), (0.00, -4.15), stroke: 0.7pt + black)

// Crocetta centro O1 (0, 1.80) e linea orizzontale
line((-0.07, 1.80), (0.07, 1.80), stroke: 0.7pt + black)
line((0.00, 1.73), (0.00, 1.87), stroke: 0.7pt + black)
line((-2.10, 1.80), (-0.15, 1.80), stroke: 0.7pt + black)
line((0.15, 1.80), (2.10, 1.80), stroke: 0.7pt + black)

// Crocetta centro O2 (0, -3.30) e linea orizzontale
line((-0.07, -3.30), (0.07, -3.30), stroke: 0.7pt + black)
line((0.00, -3.37), (0.00, -3.23), stroke: 0.7pt + black)
line((-3.50, -3.30), (-0.15, -3.30), stroke: 0.7pt + black)
line((0.15, -3.30), (3.55, -3.30), stroke: 0.7pt + black)

// Piccola tacca di riferimento sul margine sinistro presente nell'immagine
line((-4.95, -1.55), (-4.68, -1.55), stroke: 0.7pt + black)

// --- RUOTA 1 (SUPERIORE) ---
// Circonferenza di base 1 (continua, r = 1.56)
circle((0.00, 1.80), radius: 1.56, stroke: 0.8pt + black)

// Circonferenza primitiva 1 (tratteggiata a tratti lunghi, r = 1.80)
circle((0.00, 1.80), radius: 1.80, stroke: (dash: (12pt, 4pt), thickness: 0.8pt, paint: black))

// --- RUOTA 2 (INFERIORE) ---
// Circonferenza di base 2 (arco continuo, r = 2.86, tagliato in basso come nell'immagine)
arc((0.00, -3.30), start: -7.6deg, stop: 187.6deg, radius: 2.86, anchor: "origin", stroke: 0.8pt + black)

// Circonferenza primitiva 2 (arco tratteggiato a tratti lunghi, r = 3.30)
arc((0.00, -3.30), start: -6.6deg, stop: 186.6deg, radius: 3.30, anchor: "origin", stroke: (dash: (12pt, 4pt), thickness: 0.8pt, paint: black))

// --- RETTA D'AZIONE E RAGGI AI PUNTI DI TANGENZA ---
// Raggio O1 -> a
line((0.04, 1.73), (0.78, 0.45), stroke: 0.7pt + black)
// Raggio O2 -> b
line((-0.04, -3.23), (-1.43, -0.82), stroke: 0.7pt + black)
// Segmento retta d'azione a -> b passante per P(0,0) e g(-0.66, -0.38)
line((0.78, 0.45), (-1.43, -0.82), stroke: 0.7pt + black)

// Pallini neri nei punti di tangenza a e b
circle((0.78, 0.45), radius: 0.06, fill: black, stroke: none)
circle((-1.43, -0.82), radius: 0.06, fill: black, stroke: none)

// --- PROFILI CONIUGATI DEI DENTI (c-d ed e-f, tratto spesso) ---
// Curva c-d (passante per g)
arc((0.28, -0.04), start: 156.6deg, stop: 226.4deg, radius: 0.98, anchor: "origin", stroke: 1.6pt + black)
// Curva e-f (tangente a c-d in g)
arc((-1.96, -1.13), start: 22.0deg, stop: 82.0deg, radius: 1.50, anchor: "origin", stroke: 1.6pt + black)

// --- FRECCE DI ROTAZIONE E DI INDICAZIONE ---
// Freccia di rotazione Ruota 1 (oraria)
arc((0.00, 1.80), start: 8.0deg, stop: 48.0deg, radius: 2.35, anchor: "origin", mark: (start: ">"), stroke: 0.7pt + black)
// Freccia di rotazione Ruota 2 (antioraria)
arc((0.00, -3.30), start: 28.0deg, stop: 52.0deg, radius: 3.90, anchor: "origin", mark: (end: ">"), stroke: 0.7pt + black)

// Frecce etichette Ruota 1
line((-1.55, 3.65), (-0.88, 3.12), mark: (end: ">"), stroke: 0.7pt + black)
line((-1.78, 3.10), (-1.44, 2.86), mark: (end: ">"), stroke: 0.7pt + black)

// Frecce etichette Ruota 2
line((-3.02, -0.62), (-2.64, -1.24), mark: (end: ">"), stroke: 0.7pt + black)
line((-1.80, -2.02), (-2.26, -1.62), mark: (end: ">"), stroke: 0.7pt + black)

// --- ETICHETTE ---
// Etichette Ruota 1
content((-1.65, 3.70), [Circonferenza di base], anchor: "east")
content((-1.90, 3.18), [Circonferenza], anchor: "east")
content((-1.80, 2.82), [primitiva], anchor: "east")
content((-0.65, 2.45), [Ruota 1])
content((0.30, 2.08), [O_1])

// Etichette Ruota 2
content((-3.10, -0.15), [Circonferenza], anchor: "east")
content((-3.00, -0.52), [primitiva], anchor: "east")
content((-0.95, -2.22), [Circonferenza], anchor: "east")
content((-0.65, -2.58), [di base], anchor: "east")
content((1.18, -2.62), [Ruota 2])
content((0.32, -3.58), [O_2])

// Etichette punti a, b, c, d, e, f, g, P
content((0.84, 0.70), [a])
content((-1.48, -1.12), [b])
content((-0.56, 0.52), [c])
content((-0.18, -0.76), [d])
content((-0.65, -0.70), [e])
content((-1.92, 0.32), [f])
content((-0.88, -0.35), [g])
content((0.20, -0.22), [P])

// Didascalia in basso a sinistra

})
  ]
)

#v(0.5em)

#block[
  *Limiti teorici e Segmento di ingranamento reale* \
  Da un punto di vista puramente teorico, il tratto della retta d'azione lungo il quale può muoversi il punto di contatto $g$ corrisponde all'intero segmento $a$-$b$, compreso tra il punto di tangenza $a$ (sulla circonferenza di base della Ruota $1$) e il punto di tangenza $b$ (sulla circonferenza di base della Ruota $2$). \
  Nella realtà costruttiva, tuttavia, i punti estremi $a$ e $b$ non vengono mai raggiunti poiché i denti devono essere necessariamente *troncati* ad una certa altezza per non provocare fenomeni di interferenza geometrica: la porzione attiva utile lungo il segmento $a$-$b$ (detta *segmento di ingranamento*) si riduce quindi a un tratto centrale più corto, delimitato dai punti di intersezione della retta d'azione con le circonferenze di testa (di _addendum_) delle due ruote.
]

#v(1em)

==== Relazioni cinematiche e geometriche fondamentali

Dallo studio dell'accoppiamento ad evolvente di cerchio discendono tre proprietà analitiche fondamentali:

#set enum(numbering: "a)")
+ *Uguaglianza delle velocità periferiche*: nel punto di tangenza $P$, in assenza di strisciamento, la velocità tangenziale delle due circonferenze primitive è identica:
  $ V = r_1 omega_1 = r_2 omega_2 $
+ *Rapporto di trasmissione*: dall'uguaglianza delle velocità tangenziali in $P$ segue immediatamente che il rapporto delle velocità angolari è pari all'inverso del rapporto dei raggi primitivi (o, indifferentemente, dei diametri primitivi $D_1$ e $D_2$):
  $ frac(omega_1, omega_2) = frac(r_2, r_1) = frac(D_2, D_1) $
+ *Legame tra raggio di base e raggio primitivo*: indicato con $Phi$ (oppure $alpha$) l'*angolo di pressione*, ovvero l'angolo di inclinazione della retta d'azione rispetto alla tangente comune alle circonferenze primitive, il raggio del cerchio di base $r_b$ è legato al raggio primitivo $r$ dalla relazione:
  $ r_b = r cos Phi $

#v(0.5em)

#grid(
  columns: (1fr, 1.1fr),
  column-gutter: 1.5em,
  align: (left + horizon, center + horizon),
  [
==== Parametri geometrici
    
    / Centro di rotazione ($O$): asse fisso della ruota dentata.
    / Punto primitivo ($P$): punto di tangenza sulla circonferenza primitiva, per il quale passano sia la tangente orizzontale sia la linea di pressione.
    / Raggio primitivo ($r$): raggio della circonferenza primitiva (tratteggiata).
    / Raggio di base ($r_B$ o $r_b$): raggio della circonferenza di base (a tratto continuo), sempre perpendicolare alla linea di pressione nel punto di tangenza.
    / Angolo di pressione ($Phi$ o $alpha$): angolo formato dalla linea di pressione con la tangente orizzontale in $P$ (uguale, per lati mutuamente perpendicolari, all'angolo al centro compreso tra $O P$ e $r_B$).
  ],
  move(dx: 0.4cm)[

// FASE 2 - COSTRUZIONE
#canvas(length: 1cm, {
import draw: *

// --- RIEMPIMENTI (Supporto cerniera in O) ---
rect((-0.35, -0.36), (0.35, -0.22), fill: luma(200), stroke: none)

// --- CIRCONFERENZE (BASE E PRIMITIVA) ---
// Circonferenza di base (continua, r_B = 2.90)
arc((0.00, 0.00), start: -6.9deg, stop: 186.9deg, radius: 2.90, anchor: "origin", stroke: 0.8pt + black)

// Circonferenza primitiva (tratteggiata a tratti lunghi, r = 3.20)
arc((0.00, 0.00), start: -6.3deg, stop: 186.3deg, radius: 3.20, anchor: "origin", stroke: (dash: (14pt, 4pt), thickness: 0.8pt, paint: black))

// --- ASSI DI SIMMETRIA (con tratto-punto come nell'immagine) ---
// Asse orizzontale per O
line((-3.80, 0.00), (-1.40, 0.00), stroke: 0.7pt + black)
line((-1.30, 0.00), (-1.18, 0.00), stroke: 0.7pt + black)
line((-1.08, 0.00), ( 1.25, 0.00), stroke: 0.7pt + black)
line(( 1.35, 0.00), ( 1.47, 0.00), stroke: 0.7pt + black)
line(( 1.57, 0.00), ( 3.75, 0.00), stroke: 0.7pt + black)

// Asse verticale per O e P
line((0.00, -0.62), (0.00, 1.18), stroke: 0.7pt + black)
line((0.00, 1.28), (0.00, 1.40), stroke: 0.7pt + black)
line((0.00, 1.50), (0.00, 3.88), stroke: 0.7pt + black)

// --- SUPPORTO CERNIERA IN O ---
line((-0.35, -0.22), (0.35, -0.22), stroke: 1.4pt + black)
line((-0.16, -0.22), (-0.16, 0.00), stroke: 1.2pt + black)
line(( 0.16, -0.22), ( 0.16, 0.00), stroke: 1.2pt + black)
arc((0.00, 0.00), start: 0.0deg, stop: 180.0deg, radius: 0.16, anchor: "origin", stroke: 1.2pt + black)
circle((0.00, 0.00), radius: 0.08, stroke: 1.2pt + black)

// --- TANGENTE ORIZZONTALE E LINEA DI PRESSIONE ---
// Retta orizzontale tangente in P(0, 3.20)
line((-3.45, 3.20), (3.45, 3.20), stroke: 0.8pt + black)

// Linea di pressione passante per P(0, 3.20) e tangente in T(1.23, 2.63)
line((-1.77, 4.02), (3.76, 1.45), stroke: 0.8pt + black)

// --- RAGGI r E r_B E QUOTE ANGOLARI ---
// Raggio r (con interruzione per la lettera r)
line((0.00, 0.00), (-0.98, 0.77), stroke: 0.7pt + black)
line((-1.32, 1.03), (-2.52, 1.97), mark: (end: ">"), stroke: 0.7pt + black)

// Raggio r_B (da O a T=(1.23, 2.63), perpendicolare alla linea di pressione, con interruzione per r_B)
line((0.00, 0.00), (0.64, 1.37), stroke: 0.7pt + black)
line((0.86, 1.84), (1.23, 2.63), stroke: 0.7pt + black)

// Arco angolo phi in alto a sinistra (centro P=(0, 3.20), raggio 1.75)
arc((0.00, 3.20), start: 155.0deg, stop: 180.0deg, radius: 1.75, anchor: "origin", mark: (start: ">", end: ">"), stroke: 0.7pt + black)

// Frecce di indicazione per le etichette di destra
// Freccia "Circonferenza primitiva"
line((2.65, 2.75), (2.06, 2.45), mark: (end: ">"), stroke: 0.7pt + black)
// Freccia "Linea di pressione"
line((3.35, 2.15), (2.90, 1.85), mark: (end: ">"), stroke: 0.7pt + black)
// Freccia "Circonferenza di base"
line((2.38, 0.42), (2.87, 0.42), mark: (end: ">"), stroke: 0.7pt + black)

// --- ETICHETTE ---
content((-1.95, 3.62), [$phi$])
content(( 0.14, 1.), [$phi$])
content(( 0.16, 3.42), [P])
content((-0.52, -0.25), [O])
content((-1.15, 0.90), [r])
content(( 0.76, 1.58), [r_B])

content((2.75, 2.82), [Circonferenza primitiva], anchor: "west")
content((3.45, 2.22), [Linea di pressione], anchor: "west")
content((2.30, 0.44), text(size: 9pt)[Circonferenza \ di base], anchor: "east")
})

  ]
)

#v(1em)
*Dimostrazione geometrica di $r_b = r cos Phi$* \
    Osservando lo schema geometrico, si consideri il *triangolo rettangolo* individuato dal centro della ruota $O$, dal punto primitivo $P$ (intersezione della linea di pressione con la circonferenza primitiva, dove le due primitive sono tangenti) e dal punto di tangenza tra la linea di pressione e il cerchio di base. \
    In tale triangolo, l'ipotenusa $O P$ coincide con il raggio primitivo $r$, mentre il cateto adiacente all'angolo al centro $Phi$ coincide con il raggio di base $r_B$ (che è perpendicolare alla linea di pressione nel punto di tangenza), da cui segue immediatamente:
    $ r_b = r cos Phi $

    *Scelta progettuale dell'angolo di pressione $Phi$* \
    Un'inclinazione $Phi > 0$ (o $alpha$) è indispensabile affinché il sistema possa lavorare secondo lo schema equivalente della coppia di pulegge di base collegate dalla retta d'azione, ma nelle applicazioni comuni è mantenuta *compresa tra $20^degree$ e $25^degree$*. \
    Un angolo $Phi$ troppo elevato genererebbe infatti una componente della forza di contatto dominante in *direzione radiale* (verticale, che sollecita inutilmente alberi e cuscinetti) e una componente molto ridotta in *direzione tangenziale* (orizzontale), penalizzando fortemente la coppia utile trasmessa sull'albero.


//da qui revisiona

== Geometria e proprietà delle ruote dentate

Durante l'ingranamento, ciascun dente di una ruota si inserisce ciclicamente nel vano compreso tra due denti consecutivi della ruota coniugata. È quindi indispensabile attribuire al dente un'*estensione radiale finita e calibrata* affinché il punto di contatto possa scorrere liberamente sul fianco per tutta la durata dell'angolo di rotazione previsto, il quale risulta suddiviso in *angolo di accesso* (prima del centro di istantanea rotazione $P$) e *angolo di recesso* (dopo $P$). Tale proporzionamento deve evitare sia condizioni di *interferenza o incastro* geometrico, sia condizioni eccessivamente lasche che impedirebbero di mantenere la continuità del contatto lungo il *segmento di ingranamento* $a$-$b$.

#v(0.5em)

#grid(
  columns: (1.1fr, 0.9fr),
  column-gutter: 1.5em,
  align: (center + horizon, left + horizon),
  [
// FASE 2 - COSTRUZIONE
#canvas(length: 1cm, {
  import draw: *

  // --- 1. DENTI DEL PIGNONE (GRIGIO CHIARO) ---
  // Dente 1: Pignone in alto a sinistra (isolato)
  line(
    (-1.69, 1.44), (-1.95, 1.38), (-2.25, 1.38), (-2.55, 1.48), (-2.77, 1.62),
    (-2.65, 1.95), (-2.38, 2.06), (-2.10, 2.18), (-1.92, 2.34),
    (-1.65, 2.00), (-1.58, 1.72),
    close: true, fill: rgb(215, 215, 215), stroke: none
  )
  bezier((-1.69, 1.44), (-1.95, 1.38), (-1.80, 1.36), (-1.88, 1.36), stroke: 0.8pt)
  bezier((-1.95, 1.38), (-2.77, 1.62), (-2.30, 1.38), (-2.58, 1.48), stroke: 0.8pt)
  bezier((-2.77, 1.62), (-2.65, 1.95), (-2.74, 1.75), (-2.70, 1.85), stroke: 0.8pt)
  bezier((-2.65, 1.95), (-1.98, 2.25), (-2.42, 2.05), (-2.15, 2.15), stroke: 0.8pt)
  bezier((-1.98, 2.25), (-1.92, 2.34), (-1.92, 2.28), (-1.90, 2.31), stroke: 0.8pt)

  // Dente 2: Pignone in contatto in 'a' (-0.98, 0.36)
  line(
    (-0.56, 0.58), (-0.75, 0.48), (-0.98, 0.36), (-1.27, 0.14),
    (-1.58, 0.29), (-1.45, 0.56), (-1.28, 0.78), (-1.19, 0.90),
    (-0.85, 0.95), (-0.65, 0.78),
    close: true, fill: rgb(215, 215, 215), stroke: none
  )
  bezier((-0.56, 0.58), (-1.27, 0.14), (-0.75, 0.50), (-1.05, 0.32), stroke: 0.8pt)
  bezier((-1.27, 0.14), (-1.58, 0.29), (-1.38, 0.19), (-1.48, 0.24), stroke: 0.8pt)
  bezier((-1.58, 0.29), (-1.19, 0.90), (-1.45, 0.55), (-1.30, 0.78), stroke: 0.8pt)

  // Dente 3: Pignone in contatto in 'b' (0.82, -0.30)
  line(
    (0.38, 0.54), (0.48, 0.25), (0.65, -0.05), (0.82, -0.30),
    (1.13, -0.19), (1.08, 0.15), (0.98, 0.45), (0.91, 0.72),
    (0.65, 0.78), (0.45, 0.68),
    close: true, fill: rgb(215, 215, 215), stroke: none
  )
  bezier((0.38, 0.54), (0.82, -0.30), (0.48, 0.25), (0.65, -0.05), stroke: 0.8pt)
  bezier((0.82, -0.30), (1.13, -0.19), (0.92, -0.27), (1.03, -0.23), stroke: 0.8pt)
  bezier((1.13, -0.19), (0.91, 0.72), (1.08, 0.15), (0.98, 0.48), stroke: 0.8pt)

  // --- 2. CIRCONFERENZE DEL PIGNONE (centro O1 = (0, 2.5)) ---
  arc((0, 2.5), start: 148deg, stop: 392deg, radius: 2.00, anchor: "origin", stroke: (dash: "dashed", thickness: 0.7pt))
  arc((0, 2.5), start: 152deg, stop: 388deg, radius: 2.35, anchor: "origin", stroke: 0.7pt)
  arc((0, 2.5), start: 155deg, stop: 385deg, radius: 2.50, anchor: "origin", stroke: (dash: "dash-dotted", thickness: 0.7pt))
  arc((0, 2.5), start: 158deg, stop: 382deg, radius: 2.92, anchor: "origin", stroke: (dash: "dashed", thickness: 0.7pt))

  // --- 3. ASSI, LINEE E RAGGI ---
  // Asse verticale per O1 e P
  line((0, 3.3), (0, -1.0), stroke: (dash: "dash-dotted", thickness: 0.7pt))
  // Retta orizzontale per O1
  line((-3.2, 2.5), (3.2, 2.5), stroke: 0.6pt)
  // Retta orizzontale tangente in P
  line((-3.8, 0), (3.8, 0), stroke: 0.6pt)
  // Linea di pressione passante per a, P, b
  line((-4.5, 1.64), (4.5, -1.64), stroke: 0.8pt)
  // Raggi da O1 per gli estremi di contatto a e b
  line((0, 2.5), (-1.18, -0.09), stroke: 0.6pt)
  line((0, 2.5), (0.82, -0.30), stroke: 0.6pt)

  // --- 4. ARCHI DI QUOTA E FRECCE ---
  arc((0, 2.5), start: 245.5deg, stop: 270deg, radius: 1.40, anchor: "origin", mark: (start: ">", end: ">"), stroke: 0.6pt)
  arc((0, 2.5), start: 270deg, stop: 286.3deg, radius: 1.40, anchor: "origin", mark: (start: ">", end: ">"), stroke: 0.6pt)
  line((-0.25, 1.35), (-0.50, 1.80), stroke: 0.5pt)
  line((0.20, 1.35), (0.45, 1.80), stroke: 0.5pt)
  // Freccia di rotazione del Pignone
  arc((0, 2.5), start: 102deg, stop: 142deg, radius: 1.65, anchor: "origin", mark: (end: ">"), stroke: 0.6pt)

  // Richiami circonferenze Pignone
  line((3.15, 4.25), (1.68, 3.59), mark: (end: ">"), stroke: 0.6pt)
  line((3.15, 3.85), (2.13, 3.49), mark: (end: ">"), stroke: 0.6pt)
  line((3.15, 3.45), (2.40, 3.19), mark: (end: ">"), stroke: 0.6pt)
  line((3.15, 3.05), (2.89, 2.91), mark: (end: ">"), stroke: 0.6pt)
  // Richiamo Linea di pressione
  line((-3.95, 0.90), (-3.68, 1.34), mark: (end: ">"), stroke: 0.6pt)

  // --- 5. PUNTI NOTEVOLI ED ETICHETTE ---
  circle((0, 2.5), radius: 0.05, fill: black, stroke: none)
  circle((0, 0), radius: 0.07, fill: black, stroke: none)
  circle((-0.98, 0.36), radius: 0.07, fill: black, stroke: none)
  circle((0.82, -0.30), radius: 0.07, fill: black, stroke: none)

  content((-0.30, 4.15), text(size: 7pt)[*Pignone*], anchor: "west")
  content((-0.30, 3.80), text(size: 7pt)[(conduttore)], anchor: "west")
  content((3.25, 4.25), text(size: 7pt)[Circonferenza di piede], anchor: "west")
  content((3.25, 3.85), text(size: 7pt)[Circonferenza di base], anchor: "west")
  content((3.25, 3.45), text(size: 7pt)[Circonferenza primitiva], anchor: "west")
  content((3.25, 3.05), text(size: 7pt)[Circonferenza di testa], anchor: "west")
  content((0.10, 2.80), [$O_1$], anchor: "west")
  content((-0.85, 2.28), text(size: 7pt)[Angolo di], anchor: "center")
  content((-0.90, 1.95), text(size: 7pt)[accesso], anchor: "center")
  content((0.95, 2.22), text(size: 7pt)[Angolo], anchor: "center")
  content((1.05, 1.90), text(size: 7pt)[di recesso], anchor: "center")
  content((-4.35, 0.72), text(size: 7pt)[Linea di pressione], anchor: "center")
  content((-0.8, 0.22), [$a$], anchor: "east")
  content((-0.08, -0.25), [$P$], anchor: "east")
  content((0.95, -0.55), [$b$], anchor: "west")
})

\


#canvas(length: 1cm, {
  import draw: *

  // --- 1. DENTI DELLA RUOTA (GRIGIO CHIARO) ---
  // Dente 4: Ruota in basso a sinistra (isolato)
  line(
    (-3.26, -1.90), (-3.45, -1.78), (-3.68, -1.55), (-3.85, -1.32),
    (-3.63, -1.10), (-3.32, -1.30), (-3.05, -1.48), (-2.84, -1.47),
    (-2.72, -1.75), (-2.95, -2.02),
    close: true, fill: rgb(215, 215, 215), stroke: none
  )
  bezier((-3.26, -1.90), (-3.42, -1.78), (-3.35, -1.86), (-3.38, -1.82), stroke: 0.8pt)
  bezier((-3.42, -1.78), (-3.85, -1.32), (-3.62, -1.62), (-3.75, -1.46), stroke: 0.8pt)
  bezier((-3.85, -1.32), (-3.63, -1.10), (-3.78, -1.24), (-3.70, -1.17), stroke: 0.8pt)
  bezier((-3.63, -1.10), (-2.98, -1.48), (-3.42, -1.26), (-3.18, -1.40), stroke: 0.8pt)
  bezier((-2.98, -1.48), (-2.84, -1.47), (-2.92, -1.50), (-2.88, -1.49), stroke: 0.8pt)

  // Dente 5: Ruota in contatto in 'a' (-0.98, 0.36)
  line(
    (-1.31, -0.70), (-1.22, -0.35), (-1.12, 0.02), (-0.98, 0.36),
    (-0.74, 0.40), (-0.68, 0.05), (-0.68, -0.30), (-0.72, -0.55),
    (-0.95, -0.78), (-1.18, -0.82),
    close: true, fill: rgb(215, 215, 215), stroke: none
  )
  bezier((-1.31, -0.70), (-0.98, 0.36), (-1.22, -0.35), (-1.12, 0.02), stroke: 0.8pt)
  bezier((-0.98, 0.36), (-0.74, 0.40), (-0.90, 0.38), (-0.82, 0.39), stroke: 0.8pt)
  bezier((-0.74, 0.40), (-0.72, -0.55), (-0.68, 0.05), (-0.68, -0.28), stroke: 0.8pt)

  // Dente 6: Ruota in contatto in 'b' (0.82, -0.30)
  line(
    (0.55, -0.53), (0.65, -0.42), (0.82, -0.30), (1.13, 0.33),
    (1.37, 0.27), (1.28, -0.10), (1.18, -0.42), (1.11, -0.64),
    (0.88, -0.72), (0.68, -0.66),
    close: true, fill: rgb(215, 215, 215), stroke: none
  )
  bezier((0.55, -0.53), (1.13, 0.33), (0.72, -0.42), (0.98, -0.02), stroke: 0.8pt)
  bezier((1.13, 0.33), (1.37, 0.27), (1.21, 0.31), (1.29, 0.29), stroke: 0.8pt)
  bezier((1.37, 0.27), (1.11, -0.64), (1.30, -0.05), (1.20, -0.38), stroke: 0.8pt)

  // --- 2. CIRCONFERENZE DELLA RUOTA (centro O2 = (0, -5.0)) ---
  arc((0, -5.0), start: 22deg, stop: 158deg, radius: 4.50, anchor: "origin", stroke: (dash: "dashed", thickness: 0.7pt))
  arc((0, -5.0), start: 20deg, stop: 160deg, radius: 4.70, anchor: "origin", stroke: 0.7pt)
  arc((0, -5.0), start: 18deg, stop: 162deg, radius: 5.00, anchor: "origin", stroke: (dash: "dash-dotted", thickness: 0.7pt))
  arc((0, -5.0), start: 16deg, stop: 164deg, radius: 5.45, anchor: "origin", stroke: (dash: "dashed", thickness: 0.7pt))

  // --- 3. ASSI, LINEE E RAGGI ---
  // Asse verticale per P e O2
  line((0, 1.0), (0, -5.5), stroke: (dash: "dash-dotted", thickness: 0.7pt))
  // Retta orizzontale tangente in P
  line((-3.8, 0), (3.8, 0), stroke: 0.6pt)
  // Retta orizzontale per O2
  line((-0.8, -5.0), (0.8, -5.0), stroke: 0.6pt)
  // Linea di pressione passante per a, P, b
  line((-4.5, 1.64), (5.2, -1.89), stroke: 0.8pt)
  // Raggi da O2 per gli estremi di contatto a e b
  line((0, -5.0), (-0.98, 0.36), stroke: 0.6pt)
  line((0, -5.0), (0.88, -0.05), stroke: 0.6pt)

  // --- 4. ARCHI DI QUOTA E FRECCE ---
  arc((0, -5.0), start: 90deg, stop: 100.4deg, radius: 3.65, anchor: "origin", mark: (start: ">", end: ">"), stroke: 0.6pt)
  arc((0, -5.0), start: 80.3deg, stop: 90deg, radius: 3.65, anchor: "origin", mark: (start: ">", end: ">"), stroke: 0.6pt)
  line((-0.35, -1.55), (-1.15, -1.95), stroke: 0.5pt)
  line((0.35, -1.55), (1.10, -1.95), stroke: 0.5pt)
  // Freccia di rotazione della Ruota
  arc((0, -5.0), start: 132deg, stop: 148deg, radius: 3.90, anchor: "origin", mark: (start: ">"), stroke: 0.6pt)

  // Richiami circonferenze Ruota
  line((3.25, -2.40), (4.29, -1.64), mark: (end: ">"), stroke: 0.6pt)
  line((3.25, -2.80), (4.10, -2.13), mark: (end: ">"), stroke: 0.6pt)
  line((3.25, -3.20), (3.99, -2.51), mark: (end: ">"), stroke: 0.6pt)
  line((3.25, -3.60), (3.97, -2.89), mark: (end: ">"), stroke: 0.6pt)
  // Richiamo Linea di pressione
  line((-3.95, 0.90), (-3.68, 1.34), mark: (end: ">"), stroke: 0.6pt)
  // Frecce per Segmento di ingranamento
  line((-2.40, -4.50), (-1.05, 0.15), mark: (end: ">"), stroke: 0.8pt)
  line((-2.40, -4.50), (0.68, -0.45), mark: (end: ">"), stroke: 0.8pt)

  // --- 5. PUNTI NOTEVOLI ED ETICHETTE ---
  circle((0, 0), radius: 0.07, fill: black, stroke: none)
  circle((-0.98, 0.36), radius: 0.07, fill: black, stroke: none)
  circle((0.82, -0.30), radius: 0.07, fill: black, stroke: none)
  circle((0, -5.0), radius: 0.07, fill: black, stroke: none)

  content((-4.35, 0.72), text(size: 7pt)[Linea di pressione], anchor: "center")
  content((-1, 0.62), [$a$], anchor: "east")
  content((-0.08, -0.25), [$P$], anchor: "east")
  content((0.95, -0.15), [$b$], anchor: "west")
  content((-1.80, -1.95), text(size: 7pt)[Angolo di], anchor: "center")
  content((-1.90, -2.28), text(size: 7pt)[accesso], anchor: "center")
  content((1.60, -1.65), text(size: 7pt)[Angolo], anchor: "center")
  content((1.75, -1.98), text(size: 7pt)[di recesso], anchor: "center")
  content((-3.75, -3.65), text(size: 7pt)[*Ruota*], anchor: "center")
  content((-3.75, -4.00), text(size: 7pt)[(condotta)], anchor: "center")
  content((3.18, -2.40), text(size: 7pt)[Circonferenza di testa], anchor: "east")
  content((3.18, -2.80), text(size: 7pt)[Circonferenza primitiva], anchor: "east")
  content((3.18, -3.20), text(size: 7pt)[Circonferenza di base], anchor: "east")
  content((3.18, -3.60), text(size: 7pt)[Circonferenza di piede], anchor: "east")
  content((-2.90, -5.00), text(size: 7pt)[Segmento di ingranamento], anchor: "center")
  content((0.10, -5.25), [$O_2$], anchor: "west")
})
  ],
  [
    \
=== Le quattro circonferenze caratteristiche
    Procedendo dall'interno verso l'esterno della ruota dentata, la geometria radiale del dente è scandita da quattro circonferenze fondamentali:

    #v(0.5em)

    / Circonferenza di piede (o di fondo): è la circonferenza più interna (generalmente di raggio inferiore al cerchio di base), in corrispondenza della quale la base del dente si raccorda con la *corona circolare* (corpo principale) della ruota dentata.
    
    / Circonferenza di base: è la circonferenza costruttiva che definisce il *sistema cinematico equivalente* cinghia-puleggia da cui si genera geometricamente il *profilo ad evolvente*.
    
    / Circonferenza primitiva: è la circonferenza cinematica di riferimento che rappresenta i due *rulli cilindrici ideali* premuti a contatto tra loro nel punto primitivo $P$.
    
    / Circonferenza di testa: è la circonferenza più esterna, che delimita superiormente il dente definendone il *troncamento* dal lato alto.

    #v(1em)

  ]
)

#v(1em)

*Nomenclatura cinematica nel disegno:*
      / Centri di rotazione ($O_1, O_2$): assi fissi del *pignone* (conduttore) e della *ruota* (condotta).
      / Punto primitivo ($P$): punto di tangenza tra le circonferenze primitive.
      / Estremi di contatto ($a, b$): punti di inizio ($a$) e fine ($b$) dell'ingranamento lungo la *linea di pressione*

=== Parametri di proporzionamento: Passo e Modulo

Indicato con $z$ (oppure $N$) il *numero di denti* complessivo della ruota e con $D = 2 r$ il *diametro primitivo*, si definiscono due grandezze fondamentali per la progettazione e l'unificazione degli ingranaggi:

#v(0.5em)
==== Passo primitivo ($p$)
    In una schiera circolare di denti, è la *distanza curvilinea* misurata lungo la circonferenza primitiva di riferimento tra due punti omologhi appartenenti a due denti consecutivi. 
    
    Dividendo lo sviluppo totale della circonferenza primitiva ($2 pi r = pi D$) per il numero totale di denti $z$ che equipaggia la corona, si ottiene la porzione di circonferenza destinata a ciascun dente (_pieno_ + _vano_):
    $ p = frac(2 pi r, z) = frac(pi D, z) $
=== Modulo ($m$)
    Poiché il passo $p$ contiene il numero irrazionale $pi$, per disporre di un *parametro razionale* comodo nei calcoli e nelle tabelle di unificazione si definisce il *modulo* $m$ come il rapporto tra il passo primitivo $p$ e $pi$. 
    
    Esso risulta quindi pari al rapporto diretto tra il diametro primitivo $D$ e il numero dei denti $z$:
    $ m = frac(p, pi) = frac(D, z) $
#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  [
    
  ],
  block[
    
  ]
)

#v(1em)

#block[
  *Sintesi progettuale:* Il *modulo* $m$, il *passo primitivo* $p$, il *numero di denti* $z$, i raggi/diametri delle *quattro circonferenze caratteristiche* e l'*angolo di pressione* $Phi$ (che fissa la giacitura della retta d'azione lungo cui agisce la forza scambiata) descrivono  la geometria utile per la progettazione delle ruote dentate. 
  
  _Nota bene:_ Definire il modulo dei denti corrisponde a fissare simultaneamente sia la dimensione globale della ruota in termini di circonferenza primitiva ($D = m z$), sia la dimensione locale del singolo dente in termini di altezza radiale.
]


== Caratteristiche secondo il proporzionamento modulare

Per mantenere la scala del dente proporzionata alla dimensione della ruota, la *normativa tecnica* stabilisce requisiti geometrici standardizzati relativi sia allo *sviluppo radiale* (altezza complessiva del dente) sia allo *sviluppo circonferenziale* misurato lungo la circonferenza primitiva (passo, spessore e vano).

#v(0.5em)


#align(center)[#canvas(length: 1cm, {
  import draw: *

  // 1. CIRCONFERENZE DI RIFERIMENTO (archi sottili, centro (0, -18.0))
  // Circonferenza di testa (R_a = 20.04)
  arc((0, -18.0), start: 81.1deg, stop: 103.6deg, radius: 20.04, anchor: "origin", stroke: 0.4pt)

  // Circonferenza primitiva (R_p = 19.15)
  arc((0, -18.0), start: 80.7deg, stop: 104.3deg, radius: 19.15, anchor: "origin", stroke: 0.4pt)

  // Circonferenza di piede (R_f = 18.00)
  arc((0, -18.0), start: 80.7deg, stop: 105.2deg, radius: 18.00, anchor: "origin", stroke: 0.4pt)

  // 2. PROFILO INGRASSATO DEI DUE DENTI (stroke: 1.2pt)
  // Dente 1 (sinistra): raccordo sinistro -> fianco sinistro -> smusso -> testa -> smusso -> fianco destro
  bezier((-4.36, -0.54), (-3.85, -0.05), (-4.10, -0.45), (-3.92, -0.30), stroke: 1.2pt)
  bezier((-3.85, -0.05), (-3.55, 1.60), (-3.80, 0.50), (-3.72, 1.10), stroke: 1.2pt)
  line((-3.55, 1.60), (-3.46, 1.74), (-2.81, 1.84), (-2.70, 1.72), stroke: 1.2pt)
  bezier((-2.70, 1.72), (-1.92, 0.25), (-2.42, 1.32), (-2.12, 0.78), stroke: 1.2pt)

  // Vano centrale (raccordo sul fondo a R_f = 18.00)
  bezier((-1.92, 0.25), (-1.02, 0.32), (-1.75, -0.15), (-1.18, -0.12), stroke: 1.2pt)

  // Dente 2 (destra): fianco sinistro -> smusso -> testa -> smusso -> fianco destro -> raccordo destro
  bezier((-1.02, 0.32), (-0.43, 1.92), (-0.88, 0.85), (-0.68, 1.45), stroke: 1.2pt)
  line((-0.43, 1.92), (-0.33, 2.04), (0.33, 2.04), (0.43, 1.92), stroke: 1.2pt)
  bezier((0.43, 1.92), (1.02, 0.32), (0.68, 1.45), (0.88, 0.85), stroke: 1.2pt)
  bezier((1.02, 0.32), (1.60, -0.07), (1.14, 0.02), (1.35, -0.05), stroke: 1.2pt)

  // 3. QUOTE E FRECCE (stroke: 0.5pt)
  // Frecce per la quota "e" (larghezza del vano lungo la circonferenza primitiva)
  line((-1.95, 1.057), (-2.251, 1.017), mark: (end: ">", fill: black), stroke: 0.5pt)
  line((-1.05, 1.116), (-0.752, 1.135), mark: (end: ">", fill: black), stroke: 0.5pt)

  // Frecce per la quota "s" (spessore del dente lungo la circonferenza primitiva)
  line((-0.45, 1.146), (-0.752, 1.135), mark: (end: ">", fill: black), stroke: 0.5pt)
  line((0.45, 1.146), (0.752, 1.135), mark: (end: ">", fill: black), stroke: 0.5pt)

  // Linee di estensione verticali e arco per la quota "p" (passo circolare)
  line((-2.251, 1.017), (-2.251, 0.22), stroke: 0.5pt)
  line((0.752, 1.135), (0.752, 0.32), stroke: 0.5pt)
  arc((0, -18.0), start: 87.67deg, stop: 96.98deg, radius: 18.50, anchor: "origin", stroke: 0.5pt)
  line((-1.95, 0.40), (-2.251, 0.363), mark: (end: ">", fill: black), stroke: 0.5pt)
  line((0.45, 0.495), (0.752, 0.485), mark: (end: ">", fill: black), stroke: 0.5pt)

  // Quota "a" (addendum, lungo il raggio a 83.5deg)
  line((2.168, 1.027), (2.268, 1.911), mark: (start: ">", end: ">", fill: black), stroke: 0.5pt)

  // Quota "d" (dedendum, lungo il raggio a 83.5deg)
  line((2.037, -0.116), (2.168, 1.027), mark: (start: ">", end: ">", fill: black), stroke: 0.5pt)

  // 4. ETICHETTE (tutte con text(size: 7pt))
  content((-1.50, 1.38), text(size: 7pt)[e], anchor: "center")
  content((0.00, 1.38), text(size: 7pt)[s], anchor: "center")
  content((-0.15, 0.25), text(size: 7pt)[p], anchor: "center")
  content((2.58, 1.50), text(size: 7pt)[a], anchor: "center")
  content((2.48, 0.50), text(size: 7pt)[d], anchor: "center")
})]

=== Grandezze del dente normale
    / Addendum ($a = m$): distanza radiale fra la circonferenza di testa e la circonferenza primitiva.
    / Dedendum ($d = 1.25 m$): distanza radiale fra la circonferenza primitiva e quella di fondo (di piede).
    / Altezza totale ($h = a + d = 2.25 m$): sviluppo radiale complessivo del dente.
    / Larghezza di fascia ($b$): spessore assiale della ruota dentata.
    / Spessore ($s = p / 2$): ampiezza curvilinea del pieno del dente sulla primitiva.
    / Vano ($e = p / 2$): ampiezza curvilinea dello spazio libero sulla primitiva.
    / Passo ($p = s + e$): distanza curvilinea tra due denti omologhi consecutivi.
#v(0.5em)

=== Significato fisico e giustificazione normativa

Il sistema prende il nome di *proporzionamento modulare* proprio perché i coefficienti moltiplicativi applicati al modulo $m$ per ricavare le quote radiali sono predefiniti dalla normativa tecnica ($1$ per l'addendum e $1.25$ per il dedendum), determinando univocamente l'altezza totale $h = a + d = 2.25 m$. Nel dettaglio:

#v(0.5em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  [
    *Sviluppo radiale: Addendum ($a$) e Dedendum ($d$)*
    
    - *Addendum ($a = m$)*: dal latino _"ciò che si deve aggiungere"_ al raggio della circonferenza primitiva per ottenere il raggio esterno di testa ($R_a = R + a$). Poiché $a = m$ e il modulo è direttamente proporzionale al diametro primitivo ($D = m z$)
    - *Dedendum ($d = 1.25 m$)*: dal latino _"ciò che si deve sottrarre"_ al raggio primitivo per arrivare alla corona di fondo ($R_f = R - d$). Il dedendum deve essere necessariamente *maggiore dell'addendum* poiché per una prima quota ($1 m$) è bilanciato dalla penetrazione dell'addendum del dente coniugato, ma deve includere anche uno *spazio radiale aggiuntivo* ($0.25 m$) indispensabile per alloggiare la regione di raccordo al piede ed evitare strisciamenti sul fondo.
  ],
  [
    *Sviluppo circonferenziale: Spessore ($s$) e Vano ($e$)*
    
    Lo *spessore del dente* $s$ (distanza curvilinea da un fianco all'altro dello stesso dente) e l'ampiezza del *vano* $e$ sono misurati rigorosamente lungo la *circonferenza primitiva* di riferimento.
    
    La condizione teorica di uguaglianza $s = e = p / 2$, unita alla relazione fondamentale di partizione:
    $ p = s + e $
    assicura che gli spessori dei denti coniugati che ingranano da un lato e dall'altro rimangano esattamente contenuti all'interno del passo disponibile, evitando condizioni di *interferenza o incastro circonferenziale* reciproco tra i corpi dei denti durante la rotazione.
  ]
)



#grid(
  columns: (0.9fr, 1.1fr),
  column-gutter: 1.5em,
  align: (left + horizon, center + horizon),
  [
    

    #block[
      *Proporzionamento assiale ($b$):* \
      Lo sviluppo in profondità del dente, dato dalla *larghezza di fascia* $b$, è generalmente di circa un ordine di grandezza superiore al singolo modulo $m$ (cioè alla dimensione dell'addendum, nell'intorno di $10 m$). L'intervallo tipico tollerato nella pratica costruttiva per il rapporto $b / m$ è compreso tra $9$ e $14$:
      $ frac(b, m) approx 9 / 14 quad (b approx 10 m) $
    ]
  ],
  [
#canvas(length: 1cm, {
  import draw: *

  // 1. RIEMPIMENTI (toni di grigio come nell'immagine)
  // Corpo frontale della ruota e dei due denti (grigio chiaro)
  line(
    (0.30, 0.45),
    (0.30, 3.30),
    (0.52, 3.95),
    (0.90, 4.58),
    (1.65, 4.55),
    (2.05, 3.85),
    (2.22, 3.16),
    (2.35, 1.60),
    (3.45, 1.40),
    (3.98, 2.84),
    (4.65, 4.10),
    (5.40, 3.92),
    (5.65, 2.95),
    (5.75, 1.00),
    (6.60, 0.72),
    (6.15, -0.05),
    (5.30, -0.35),
    (4.10, -0.20),
    (3.20, -0.30),
    (2.10, 0.15),
    (1.10, 0.25),
    close: true,
    fill: gray.transparentize(65%),
    stroke: none
  )

  // Superficie di testa dente 1 (molto chiara)
  line(
    (0.90, 4.58), (1.65, 4.55), (3.29, 6.19), (2.54, 6.22),
    close: true,
    fill: gray.transparentize(85%),
    stroke: none
  )

  // Fianco destro dente 1 (grigio medio)
  line(
    (1.65, 4.55), (2.05, 3.85), (2.22, 3.16), (2.35, 1.60),
    (3.99, 3.24), (3.86, 4.80), (3.69, 5.49), (3.29, 6.19),
    close: true,
    fill: gray.transparentize(50%),
    stroke: none
  )

  // Fondo vano 1 (grigio medio-chiaro)
  line(
    (2.35, 1.60), (3.45, 1.40), (5.09, 3.04), (3.99, 3.24),
    close: true,
    fill: gray.transparentize(60%),
    stroke: none
  )

  // Superficie di testa dente 2 (molto chiara)
  line(
    (4.65, 4.10), (5.40, 3.92), (7.04, 5.56), (6.29, 5.74),
    close: true,
    fill: gray.transparentize(85%),
    stroke: none
  )

  // Fianco destro dente 2 (grigio medio)
  line(
    (5.40, 3.92), (5.65, 2.95), (5.75, 1.00),
    (7.39, 2.64), (7.29, 4.59), (7.04, 5.56),
    close: true,
    fill: gray.transparentize(50%),
    stroke: none
  )

  line(
    (5.75, 1.00), (6.60, 0.72), (8.24, 2.36), (7.39, 2.64),
    close: true,
    fill: gray.transparentize(55%),
    stroke: none
  )

  // 2. CONTORNI DEI DENTI E DEL CORPO
  // Dente 1 - profilo frontale
  bezier((0.30, 3.10), (0.90, 4.58), (0.45, 3.75), (0.68, 4.25), stroke: 0.8pt)
  line((0.90, 4.58), (1.65, 4.55), stroke: 0.8pt)
  bezier((1.65, 4.55), (2.35, 1.60), (2.08, 3.85), (2.28, 2.40), stroke: 0.8pt + white)

  // Dente 1 - spigoli di profondita e profili posteriori
  line((0.90, 4.58), (2.54, 6.22), stroke: 0.8pt)
  line((1.65, 4.55), (3.29, 6.19), stroke: 0.6pt + gray)
  line((2.54, 6.22), (3.29, 6.19), stroke: 0.8pt)
  bezier((3.29, 6.19), (3.99, 3.24), (3.72, 5.49), (3.92, 4.04), stroke: 0.8pt)
  line((3.99, 3.24), (4.22, 3.19), stroke: 0.8pt)

  // Vano tra Dente 1 e Dente 2
  bezier((2.35, 1.60), (3.45, 1.40), (2.70, 1.52), (3.10, 1.46), stroke: 0.6pt + gray)

  // Dente 2 - profilo frontale
  bezier((3.45, 1.40), (4.65, 4.10), (3.72, 2.45), (4.20, 3.50), stroke: 0.8pt)
  line((4.65, 4.10), (5.40, 3.92), stroke: 0.8pt)
  bezier((5.40, 3.92), (5.75, 1.00), (5.68, 3.05), (5.74, 1.85), stroke: 0.8pt + white)

  // Dente 2 - spigoli di profondita e profili posteriori
  line((4.65, 4.10), (6.29, 5.74), stroke: 0.8pt)
  line((5.40, 3.92), (7.04, 5.56), stroke: 0.6pt + gray)
  line((6.29, 5.74), (7.04, 5.56), stroke: 0.8pt)
  bezier((7.04, 5.56), (7.39, 2.64), (7.32, 4.69), (7.38, 3.49), stroke: 0.8pt)
  line((7.39, 2.64), (8.24, 2.36), stroke: 0.8pt)

  // Tratteggio curvo dei raccordi al piede (Dente 1)
  arc((2.45, 1.72), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((2.57, 1.84), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((2.69, 1.96), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((2.81, 2.08), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((2.93, 2.20), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((3.05, 2.32), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((3.17, 2.44), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((3.29, 2.56), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((3.41, 2.68), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((3.53, 2.80), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((3.65, 2.92), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((3.77, 3.04), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((3.89, 3.16), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))

  // Tratteggio curvo dei raccordi al piede (Dente 2)
  arc((5.85, 1.12), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((5.97, 1.24), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((6.09, 1.36), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((6.21, 1.48), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((6.33, 1.60), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((6.45, 1.72), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((6.57, 1.84), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((6.69, 1.96), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((6.81, 2.08), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((6.93, 2.20), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((7.05, 2.32), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((7.17, 2.44), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))
  arc((7.29, 2.56), start: 200deg, stop: 310deg, radius: 0.14, anchor: "origin", stroke: 0.5pt + gray.darken(30%))

  // 3. ARCHI DELLE CIRCONFERENZE (tratto-punto / tratteggiati)
  // Circonferenza di testa (R = 18.6, centro (0.5, -14.0))
  arc((0.5, -14.0), start: 72.5deg, stop: 90.8deg, radius: 18.6, anchor: "origin", stroke: (dash: "loosely-dashed", thickness: 0.6pt))

  // Cerchio primitivo (R = 17.3, centro (0.5, -14.0))
  arc((0.5, -14.0), start: 69.5deg, stop: 90.8deg, radius: 17.3, anchor: "origin", stroke: (dash: "loosely-dashed", thickness: 0.6pt))

  // Circonferenza del gioco (R = 16.0, centro (0.5, -14.0))
  arc((0.5, -14.0), start: 70.0deg, stop: 90.8deg, radius: 16.0, anchor: "origin", stroke: (dash: "loosely-dashed", thickness: 0.6pt))

  // Circonferenza di piede (R = 15.7, centro (0.5, -14.0))
  arc((0.5, -14.0), start: 70.0deg, stop: 90.8deg, radius: 15.7, anchor: "origin", stroke: (dash: "loosely-dashed", thickness: 0.6pt))

  // Linee di costruzione sulla superficie primitiva dei fianchi (a 45 gradi)
  line((2.15, 3.10), (4.05, 5.00), stroke: (dash: "loosely-dashed", thickness: 0.6pt))
  line((5.60, 2.55), (7.60, 4.55), stroke: (dash: "loosely-dashed", thickness: 0.6pt))

  // 4. QUOTE E FRECCE DI RIFERIMENTO
  // Quota: Larghezza di dentatura
  line((0.90, 4.68), (0.90, 5.30), stroke: 0.6pt)
  line((2.54, 6.32), (2.54, 7.00), stroke: 0.6pt)
  line((0.90, 5.10), (1.35, 5.55), stroke: 0.6pt)
  line((2.05, 6.25), (2.54, 6.74), mark: (end: ">"), stroke: 0.6pt)

  // Freccia: Superficie di testa
  line((3.35, 6.65), (2.70, 5.95), mark: (end: ">"), stroke: 0.6pt)

  // Freccia: Circonferenza di testa
  line((4.50, 4.75), (4.30, 4.22), mark: (end: ">"), stroke: 0.6pt)

  // Freccia: Faccia
  line((7.65, 5.15), (6.85, 4.75), mark: (end: ">"), stroke: 0.6pt)

  // Freccia: Fianco
  line((7.65, 3.60), (6.85, 3.20), mark: (end: ">"), stroke: 0.6pt)

  // Linee di riferimento verticali/radiali per Passo circolare, Spessore del dente, Larghezza del vano
  line((0.40, 3.15), (0.40, 3.90), stroke: 0.6pt)
  line((0.40, 3.15), (0.40, 2.60), stroke: 0.6pt)
  line((2.18, 3.15), (2.18, 2.55), stroke: 0.6pt)
  line((3.98, 2.84), (3.98, 3.55), stroke: 0.6pt)
  line((3.98, 2.84), (3.98, 2.25), stroke: 0.6pt)

  // Frecce: Passo circolare
  line((1.00, 3.70), (0.40, 3.72), mark: (end: ">"), stroke: 0.6pt)
  bezier((1.95, 3.68), (3.98, 3.40), (2.65, 3.65), (3.30, 3.55), mark: (end: ">"), stroke: 0.6pt)

  // Frecce: Spessore del dente
  line((0.80, 2.75), (0.40, 2.75), mark: (end: ">"), stroke: 0.6pt)
  line((1.80, 2.75), (2.18, 2.75), mark: (end: ">"), stroke: 0.6pt)

  // Frecce: Larghezza del vano
  bezier((3.98, 2.48), (2.18, 2.72), (3.40, 2.58), (2.80, 2.66), mark: ( start: ">", end: ">"), stroke: 0.6pt)
  bezier((3.45, 2.60), (4.30, 2.45), (3.75, 2.95), (4.10, 2.80), stroke: 0.6pt)

  // Frecce: Gioco
  line((1.30, 2.35), (1.30, 2.02), mark: (end: ">"), stroke: 0.6pt)
  line((1.30, 1.35), (1.30, 1.68), mark: (end: ">"), stroke: 0.6pt)

  // Freccia: Raccordo al piede
  line((2.35, 1.25), (2.52, 1.68), mark: (end: ">"), stroke: 0.6pt)

  // Linea profilo vano centrale (indicazione fondo)
  bezier((4.05, 3.20), (3.35, 1.40), (3.75, 2.45), (3.65, 1.50), stroke: 0.6pt)

  // Freccia: Circonferenza di piede
  line((3.80, 0.85), (3.90, 1.38), mark: (end: ">"), stroke: 0.6pt)

  // Freccia: Circonferenza del gioco
  line((5.10, 0.85), (5.20, 1.40), mark: (end: ">"), stroke: 0.6pt)

  // 5. ETICHETTE (tutte con text(size: 7pt))
  content((1.75, 5.95), text(size: 7pt)[Larghezza di], anchor: "south")
  content((1.95, 5.60), text(size: 7pt)[dentatura], anchor: "south")

  content((2.70, 6.75), text(size: 7pt)[Superficie di testa], anchor: "west")

  content((4.25, 5.15), text(size: 7pt)[Circonferenza], anchor: "west")
  content((4.25, 4.85), text(size: 7pt)[di testa], anchor: "west")

  content((7.70, 5.20), text(size: 7pt)[Faccia], anchor: "west")
  content((7.70, 3.65), text(size: 7pt)[Fianco], anchor: "west")

  content((1.45, 3.85), text(size: 7pt)[Passo], anchor: "center")
  content((1.45, 3.55), text(size: 7pt)[circolare], anchor: "center")

  content((4.10, 3.05), text(size: 7pt)[Cerchio primitivo], anchor: "west")

  content((1.30, 2.85), text(size: 7pt)[Spessore], anchor: "center")
  content((1.30, 2.55), text(size: 7pt)[del dente], anchor: "center")

  content((4.20, 2.25), text(size: 7pt)[Larghezza del], anchor: "west")
  content((4.20, 1.95), text(size: 7pt)[vano], anchor: "west")

  content((1.20, 1.05), text(size: 7pt)[Gioco], anchor: "center")

  content((2.35, 1.05), text(size: 7pt)[Raccordo al], anchor: "center")
  content((2.15, 0.75), text(size: 7pt)[piede], anchor: "center")

  content((3.80, 0.65), text(size: 7pt)[Circonferenza], anchor: "center")
  content((3.55, 0.35), text(size: 7pt)[di piede], anchor: "center")

  content((5.25, 0.65), text(size: 7pt)[Circonferenza], anchor: "center")
  content((5.10, 0.35), text(size: 7pt)[del gioco], anchor: "center")

  content((6.95, 1.85), text(size: 7pt)[Superficie di], anchor: "center")
  content((7.15, 1.50), text(size: 7pt)[piede], anchor: "center")
})
  ]
)

#v(0.5em)

#block[
  *Nota bene:* Definire il *modulo* $m$ dei denti corrisponde a fissare simultaneamente sia la dimensione globale della ruota in termini di circonferenza primitiva ($D = m z$), sia la dimensione locale del singolo dente in termini di altezza radiale ($h = 2.25 m$) e sviluppo assiale ($b approx 10 m$).
]

#v(1em)

== Requisiti cinematici per la progettazione delle ruote dentate

Normalmente, nell'impostare il progetto dell'accoppiamento cinematico tra due ruote dentate, si fissano a priori due parametri fondamentali: l'*interasse* tra i centri delle due ruote (che per ruote esterne corrisponde alla semisomma dei diametri primitivi) e la legge di trasformazione delle velocità, espressa tramite il *rapporto di trasmissione* o il *rapporto d'ingranamento*.

#v(0.5em)
=== Rapporto di trasmissione ($tau$)
    In termini analitici, il *rapporto di trasmissione* $tau$ (il cui simbolo si sovrappone purtroppo nella letteratura a quello della tensione tangenziale in meccanica dei solidi) esprime il rapporto tra la velocità angolare $omega_("OUT")$ della *ruota condotta* (ricevente, che invia potenza verso l'utenza) e la velocità angolare $omega_("IN")$ della *ruota motrice* (che imprime il movimento, collegata alla sorgente di coppia). Esso risulta inversamente proporzionale al rapporto del numero dei denti:
    $ tau = plus.minus frac(omega_("OUT"), omega_("IN")) = plus.minus frac(z_("IN"), z_("OUT")) $
    
    Il *segno algebrico* traduce formalmente il significato fisico del verso di rotazione:
    - *Ruote esterne ($tau < 0$)*: il rapporto è convenzionalmente *negativo* perché le velocità angolari sono discordi in verso (se il pignone ruota in senso antiorario, la ruota deve necessariamente ruotare in senso orario per compatibilità cinematica nell'ingranamento).
    - *Ruote interne ($tau > 0$)*: il rapporto è *positivo* poiché le due ruote ruotano con verso concorde (stesso segno).
=== Rapporto d'ingranamento ($i$)
    Il cosiddetto *rapporto d'ingranamento*, indicato con la lettera minuscola $i$, mette in relazione le grandezze cinematiche e geometriche del *pignone* e della *ruota* indipendentemente da quale sia l'elemento motore o condotto:
    $ i = frac(omega_("pignone"), omega_("ruota")) = frac(z_("ruota"), z_("pignone")) >= 1 $
    
    Il parametro $i$ assume *sempre un valore maggiore o uguale all'unità* ($i >= 1$). Ciò deriva dal fatto che nella definizione di $i$ si identifica convenzionalmente come _"pignone"_ la ruota più piccola (dotata del minor numero di denti, $z_("pignone") <= z_("ruota")$), qualunque sia il suo ruolo cinematico nella trasmissione.
    
    Il *valore limite unitario* ($i = 1$) si ottiene esclusivamente nel caso particolare in cui le due ruote abbiano dimensioni identiche ($z_("ruota") = z_("pignone")$) e ruotino pertanto alla medesima velocità angolare in modulo.    


#align(center)[
  #image("4d741021-6053-41b2-a86d-c4ffa4912f8f-10_332_1197_904_433.jpg", width: 80%)
]
== Condizioni per il corretto ingranamento

I primi due requisiti progettuali (fissazione dell'interasse e del rapporto di trasmissione) chiariscono univocamente la relazione geometrica tra i *diametri primitivi* delle due ruote coniugate: fissato il diametro di una ruota, l'altro risulta automaticamente definito. Dal punto di vista costruttivo, il primo diametro viene scelto in funzione del *diametro dell'albero* sul quale dovrà essere calettata la ruota. 

Ricordando inoltre che il diametro primitivo è espresso dal prodotto tra il modulo e il numero dei denti ($D = m z$) e che il modulo stesso è strettamente correlato al passo primitivo tramite la relazione $m = p / pi$, emerge un vincolo cinematico e geometrico fondamentale per l'accoppiamento: per evitare fenomeni di interferenza tra i denti e consentire un corretto ingranamento, è necessario che il *passo primitivo* sia identico sulle due ruote, e pertanto che esse abbiano *lo stesso modulo*.

#v(0.5em)
=== Condizione di congruenza ($p_1 = p_2, m_1 = m_2$)
    Anche qualora le due ruote abbiano dimensioni globali differenti, l'uguaglianza del passo primitivo ($p_1 = p_2$) e conseguentemente del modulo ($m_1 = m_2$) è una condizione indispensabile per scongiurare due anomalie cinematiche opposte:
    - *Vano eccessivamente largo:* il dente si inserirebbe con lasco eccessivo, perdendo la *continuità di contatto* e la regolarità di funzionamento proprie dei profili coniugati.
    - *Vano eccessivamente stretto:* il dente andrebbe a *incastrarsi* geometricamente tra i fianchi di due denti successivi della ruota coniugata, impedendo la rotazione.
=== Gioco circonferenziale ($g$) e partizione del passo
    Misurando gli spessori curvilinei lungo la medesima circonferenza primitiva (ad esempio quella del pignone), la somma dello spessore del dente del pignone ($s_1$), dello spessore del dente della ruota ($s_2$, che si inserisce nel vano del pignone) e di un eventuale piccolissimo *gioco circonferenziale* ($g$) deve eguagliare esattamente il passo $p$ della dentatura:
    $ p = s_1 + s_2 + g $
    
    Mentre in via teorica tale gioco viene spesso omesso ($p = s + e$ con $e = s$, assumendo una semplice tolleranza minima), dal punto di vista tecnologico si preferisce imporre un piccolo gioco $g > 0$ per garantire che il contatto *non sia mai bilaterale*, ma avvenga esclusivamente lungo l'unico fianco sottoposto a pressione per trasmettere il moto.

#v(1em)

#align(center)[
  #image("4d741021-6053-41b2-a86d-c4ffa4912f8f-10_255_1195_2191_392.jpg", width: 80%)
]
=== Condizione geometrica di non interferenza

Poiché i denti del pignone e della ruota condotta sono troncati in testa in corrispondenza delle rispettive circonferenze di *addendum* (o di testa), le intersezioni $a$ e $b$ di tali circonferenze con la retta d'azione delimitano il *segmento effettivo di contatto* $a$-$b$, lungo il quale il punto di contatto si muove attraversando il punto primitivo $P$.

Affinché l'ingranamento avvenga regolarmente *senza interferenza*, il segmento effettivo di contatto $a$-$b$ deve essere interamente contenuto all'interno del *segmento teorico massimo* $T_1$-$T_2$. Analizzando la condizione sul lato del pignone $1$, occorre che il punto di inizio contatto $a$ non oltrepassi (e non coincida con) il punto limite di tangenza $T_1$, ovvero che la distanza $T_1 P$ sia strettamente maggiore di $a P$:

$ a P < T_1 P $

#grid(
  columns: (0.9fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
==== Punti notevoli sulla retta d'azione
    
    / Punti limite teorici ($T_1, T_2$): punti di tangenza dei due cerchi di base con la retta d'azione, nei quali i raggi di base risultano perpendicolari alla retta d'azione stessa.
    / Estremi del contatto reale ($a, b$): intersezioni delle circonferenze di addendum (della ruota condotta $2$ e del pignone $1$) con la retta di pressione.
    / Addendum: sporgenza radiale del dente oltre la circonferenza primitiva (tratteggiata) fino alla circonferenza di addendum (a tratto continuo).
  ],
  move(dx: 0.7cm)[
    #canvas(length: 0.8cm, {
  import draw: *
  
  // Evidenziatore giallo (sfondo titolo)
 
  
  // Circonferenze primitive (tratteggiate)
  arc((0, 4.0), start: 210deg, stop: 330deg, radius: 4.0, anchor: "origin", stroke: (dash: "dashed", thickness: 1pt))
  arc((0, -5.0), start: 30deg, stop: 150deg, radius: 5.0, anchor: "origin", stroke: (dash: "dashed", thickness: 1pt))
  
  // Circonferenze di addendum (continue)
  arc((0, 4.0), start: 210deg, stop: 330deg, radius: 4.5, anchor: "origin", stroke: 1pt)
  arc((0, -5.0), start: 30deg, stop: 150deg, radius: 5.5, anchor: "origin", stroke: 1pt)
  
  // Retta d'azione (da x=-2.5 a x=2.5)
  line((-2.5, 0.910), (2.5, -0.910), stroke: 1pt)
  
  // Rette perpendicolari dai punti di tangenza
  line((-1.285, 0.468), (-0.943, 1.408), stroke: 0.6pt)
  line((1.607, -0.585), (1.265, -1.525), stroke: 0.6pt)
  
  // Simboli di angolo retto
  line((-1.144, 0.417), (-1.093, 0.558), (-1.234, 0.609), stroke: 0.6pt)
  line((1.466, -0.534), (1.415, -0.675), (1.556, -0.726), stroke: 0.6pt)
  
  // Punti notevoli (P, a, b, T1, T2)
  circle((0, 0), radius: 0.04, fill: black, stroke: none)
  circle((-1.080, 0.393), radius: 0.06, fill: black, stroke: none)
  circle((1.040, -0.378), radius: 0.06, fill: black, stroke: none)
  circle((-1.285, 0.468), radius: 0.06, fill: black, stroke: none)
  circle((1.607, -0.585), radius: 0.06, fill: black, stroke: none)
  
  // Etichette dei punti
  content((0, -0.3), [$P$])
  content((-0.85, 0.45), [$a$])
  content((1.15, -0.55), [$b$])
  content((-1.55, 0.8), [$T_1$])
  content((1.8, -1), [$T_2$])
  
  // Quota verde ADDENDUM
  line((0, 0), (0, 0.5), mark: (start: ">", end: ">"), stroke: rgb("#008000") + 1pt)
  bezier((0.1, 0.25), (0.6, 0.8), (0.6, 0.25), stroke: rgb("#008000") + 1pt)
  content((-0.6, 1), [#text(fill: rgb("#008000"))[*ADDENDUM*]], anchor: "west")
  
  
  
  
  // Frecce di rotazione (omega 1 e omega 2)
  bezier((-0.8, 1.6), (1.5, 2.0), (-0.2, 1.2), (0.8, 1.3), mark: (end: ">"), stroke: 1pt)
  content((0.2, 1.8), [$omega_1$])
  
  bezier((1.8, -2.4), (-1.2, -2.2), (1.0, -1.8), (-0.5, -1.8), mark: (start: ">"), stroke: 1pt)
  content((0.1, -2.2), [$omega_2$])
  
  // Testo inferiore
  content((0, -3.2), [Ruota condotta])
})
  ]
)

#v(1em)



=== Caso limite (Pignone + Dentiera) e calcolo di $z_(1, "min")$

La condizione più gravosa per l'interferenza (ovvero quella che rende il segmento $a P$ il più grande possibile) si verifica quando il pignone $1$ ingrana con una ruota $2$ di raggio infinito ($r_2 arrow infinity$), cioè con una *dentiera* (cremagliera rettilinea che trasla con velocità $v_2$). In questo caso limite la circonferenza di addendum della ruota $2$ degenera in una retta orizzontale posta a quota pari all'addendum unificato $m$ rispetto alla tangente primitiva.

#grid(
  columns: (0.9fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
==== Relazioni trigonometriche
    
    Dallo schema geometrico pignone-dentiera si ricavano i segmenti $a P$ e $T_1 P$ in funzione dei parametri di progetto ($m, Phi, z_1$):
    
    / Segmento $a P$: ipotenusa del triangolo rettangolo avente come cateto verticale l'addendum della dentiera (segmento blu $a H = m$) e come angolo opposto $Phi$:
    $ a P = frac(m, sin Phi) $
    / Segmento $T_1 P$: cateto opposto all'angolo al centro $Phi$ nel triangolo rettangolo avente come ipotenusa il raggio primitivo del pignone $r_(p 1) = d_1 / 2 = (m z_1) / 2$:
    $ T_1 P = frac(d_1, 2) sin Phi = frac(m dot z_1, 2) sin Phi $
  ],
  move(dx: 0.7cm)[
    #canvas(length: 1cm, {
  import draw: *
  // Rette orizzontali di riferimento
  
  line((-4.5, 0), (4.5, 0), stroke: (dash: "dash-dotted", thickness: 0.8pt))
  line((-4.5, 0.8), (4.5, 0.8), stroke: 1.5pt)
  
  // Asse verticale
  line((0, -2.5), (0, 4.0), stroke: 0.8pt)
  
  // Archi pignone
  arc((0, 4.0), start: 215deg, stop: 325deg, radius: 4.0, anchor: "origin", stroke: (dash: "dashed", thickness: 1pt))
  arc((0, 4.0), start: 210deg, stop: 330deg, radius: 4.8, anchor: "origin", stroke: 1pt)
  
  
  // Retta d'azione
  line((-3.0, 1.4), (3.0, -1.4), stroke: 1pt)
  
  // Elementi geometrici (triangolo e proiezioni)
  line((0, 4.0), (-1.53, 0.72), stroke: 0.8pt)
  line((-1.71, 0.8), (-1.71, 0), stroke: rgb("#0000FF") + 1.5pt)
  line((0, 0), (-1.71, 0.8), stroke: rgb("#008000") + 1.5pt)
  
  
  
  // Vettori rp1 e velocità
  line((0, 2.5), (0, 0), mark: (end: ">"), stroke: rgb("#FFD700") + 1.5pt)
  line((-1.5, -2.0), (0.5, -2.0), mark: (end: ">"), stroke: 1.2pt)
  
  // Freccia omega_1 (Bezier)
  bezier((0.5, 1.8), (2.5, 2.5), (1.5, 1.5), (2.2, 2.0), mark: (end: ">"), stroke: 1pt)
  
  // Angoli phi (rosso) e marcatori
  line((-2.5, 0.8), (-1.71, 0.8), stroke: (dash: "dashed", thickness: 0.6pt))
  arc((0, 4.0), start: 245deg, stop: 270deg, radius: 1.2, anchor: "origin", stroke: rgb("#FF0000") + 1pt)
  arc((-1.71, 0.8), start: 335deg, stop: 360deg, radius: 0.4, anchor: "origin", stroke: rgb("#FF0000") + 1pt)
  arc((0, 0), start: 335deg, stop: 360deg, radius: 1.8, anchor: "origin", mark: (start: ">", end: ">"), stroke: 0.8pt)
  
  // Quota m
  line((2.8, 0), (2.8, 0.8), mark: (start: ">", end: ">"), stroke: 0.8pt)
  
  // Punti chiave
  circle((-1.53, 0.72), radius: 0.05, fill: rgb("#FFA500"), stroke: none)
  circle((-1.71, 0.8), radius: 0.05, fill: rgb("#008000"), stroke: none)
  circle((0, 0), radius: 0.05, fill: black, stroke: none)
  circle((1.32, -0.61), radius: 0.05, fill: black, stroke: none)
  
  // Etichette di testo
  content((-3.5, 4.5), [*Pignone + Dentiera*], anchor: "west")
  content((-1.7, 1.15), [$T_1$])
  content((-0.4, 2.6), [#text(fill: rgb("#FF0000"))[$Phi$]])
  content((-0.9, 0.7), [#text(fill: rgb("#FF0000"))[$phi$]])
  content((2.1, -0.5), [$phi$])
  content((0.6, 1.2), [#text(fill: rgb("#FFD700"))[$r($p1$)$]])
  content((-1.9, -0.2), [$H$])
  content((0.2, -0.3), [$P$])
  content((1.3, -0.9), [$b$])
  content((-0.5, -1.7), [$v_2$])
  content((1.2, 2.2), [$omega_1$])
  
  // Etichette modulo addendum
  content((4.5, 0.4), [m = addendum])


})
  ]
)

#v(1em)

Imponendo la disuguaglianza di non interferenza $a P < T_1 P$, si osserva che il modulo $m$ si semplifica da entrambi i membri, rendendo il *numero minimo di denti del pignone* dipendente esclusivamente dall'angolo di pressione $Phi$:

$ frac(m, sin Phi) < frac(m dot z_1, 2) sin Phi quad arrow.r.double quad z_1 > frac(2, sin^2 Phi) $

Per i valori tipici dell'angolo di pressione adottati dai costruttori ($Phi in [20^degree, 25^degree]$), assumendo lo standard $Phi = 20^degree$ la formula fornisce il limite classico:

$ z_1 > frac(2, sin^2 20^degree) approx 17.1 quad arrow.r.double quad z_(1, "min") = 17 $

#v(0.5em)

#block[
  *Determinazione dei denti della ruota condotta ($z_2$) e vincolo di interezza* \
  Una volta fissato il numero di denti sul pignone ($z_1 >= z_(1, "min")$), il numero di denti $z_2$ della ruota condotta viene dedotto a partire dal *rapporto di trasmissione* $tau = omega_2 / omega_1 = z_1 / z_2$ imposto dalle specifiche di progetto sulla variazione di velocità angolare richiesta tra i due alberi. \
  Poiché $z_(1, "min")$ costituisce una soglia inferiore invalicabile per evitare interferenza e sia $z_1$ sia $z_2$ devono essere necessariamente *numeri interi*, il progettista dovrà individuare una coppia di interi $(z_1, z_2)$ che approssimi al meglio il rapporto di velocità desiderato.
]

#v(1em)
== Modulo e numero di denti minimo

Per evitare condizioni di interferenza geometrica alla base del dente durante l'ingranamento di *ruote cilindriche a denti diritti*, il *numero di denti minimo* del pignone ($Z_("pignone")$) può essere determinato direttamente per mezzo di formule pratiche messe a punto nella letteratura tecnica (ad es. nel testo di _Giovannozzi_, di cui non è richiesta la memorizzazione ma la comprensione applicativa), oppure tramite appositi abachi grafici.

#v(0.5em)

=== Determinazione analitica e grafica
    La relazione analitica che fornisce il numero minimo di denti del pignone in assenza di interferenza è:
    $
      Z_("pignone") &= frac(2, (1 + 2 k) sin^2 alpha) (k + sqrt(k^2 + (1 + 2 k) sin^2 alpha)) \
      k = i&= frac(Z_("ruota"), Z_("pignone"))
    $
    / Angolo di pressione ($alpha = Phi$): angolo formato dalla linea d'azione con la tangente comune alle circonferenze primitive.
    / Rapporto d'ingranamento ($k = i$): rapporto tra il numero di denti della ruota e del pignone nel caso di accoppiamento con una ruota di raggio finito.
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [

    #v(0.5em)

    
      *Utilizzo dei diagrammi:* \
      In alternativa al calcolo analitico, posizionando direttamente il punto di lavoro sul diagramma a fianco in funzione del *rapporto di trasmissione* (o d'ingranamento) e dell'*angolo di pressione* scelto dal costruttore (anche per valori al di fuori dell'intervallo standard $20^degree / 25^degree$), è possibile leggere immediatamente in ordinata il *numero minimo di denti* del pignone.
    ]
  ,
  [
    #image("4d741021-6053-41b2-a86d-c4ffa4912f8f-11_578_680_1927_1008.jpg", width: 90%)
  ]
)

#v(1.5em)

=== Unificazione e standardizzazione dei moduli

I *moduli* $m$ sono definiti dalle normative tecniche internazionali come numeri razionali, tendenzialmente interi per le taglie medie e grandi. 

Benché in astratto si possa pensare di scegliere qualsiasi valore continuo per il modulo $m$ (e conseguentemente per il passo $p = pi m$, che devono essere identici sulle due ruote coniugate), le normative vincolano il progettista a selezionare in prima istanza i valori della serie *preferita* e, solo qualora questi non siano sufficienti a soddisfare i vincoli d'interasse, i valori della serie *di uso comune*. Tale limitazione risponde alla fondamentale esigenza industriale di evitare una proliferazione incontrollabile di forme, dimensioni e *utensili di taglio*, favorendo la standardizzazione dei componenti meccanici e consentendo ai costruttori di costituire magazzini per serie unificate di ruote dentate.



#figure(
      table(
        columns: (auto, 1fr),
        align: (left + horizon, left + horizon),
        [*Preferito*], [$1, 1.25, 1.5, 2, 2.5, 3, 4, 5, 6, 8, 10, 12, 16, 20, 25, 32, 40, 50$],
        [*Di uso comune*], [$1.125, 1.375, 1.75, 2.25, 2.75, 3.5, 4.5, 5.5, 7, 9, 11, 14, 18, 22, 28, 36, 45$],
      ),
      caption: [Moduli unificati $m$ [mm] secondo normativa],
      supplement: none,
    )


#v(0.5em)

Anche il rapporto adimensionale $lambda = b / m$ tra lo spessore assiale del dente $b$ (*larghezza di fascia*) e il modulo $m$ è oggetto di dimensionamento progettuale, sebbene la prassi costruttiva lo collochi tradizionalmente nell'intervallo:
$ lambda = frac(b, m) in [9, 14] quad ("tipicamente" b approx 10 m) $

#v(1em)

=== Modulo, numero di denti e larghezza di fascia: il calcolo a resistenza

I tre parametri fondamentali (*modulo* $m$, *larghezza di fascia* $b$ e *numero dei denti* $z$) possono essere fissati definitivamente, nel rispetto dei limiti cinematici e normativi precedenti, solo introducendo il *calcolo a resistenza strutturale del dente*. Tali verifiche richiedono lo studio preliminare della distribuzione dei carichi scambiati tra le ruote (in funzione del tipo di dentatura) per contrastare i due principali meccanismi di cedimento a cui è soggetto il dente:

#v(0.5em)
=== Flessione a fatica al piede del dente
    La forza scambiata lungo la retta d'azione durante l'ingranamento agisce ciclicamente sul fianco del dente, comportandosi come un carico impulsivo/periodico. 
    
    Ciò genera una *sollecitazione di flessione dinamica* (ciclo pulsante o alternato all'origine) nel piano frontale della ruota, che affatica criticamente la *sezione di incastro alla base del dente* (regione del raccordo di piede), potendo condurre alla rottura di schianto o per propagazione di cricca a fatica.

===  Usura per contatto superficiale (_pitting_)
    La pressione hertziana esercitata localmente sull'area di contatto tra i fianchi coniugati genera uno stato tensionale triassiale con *tensioni tangenziali massime sub-superficiali* (localizzate a una certa profondità al di sotto della superficie del pezzo). 
    
    La ripetizione ciclica del contatto innesca la nucleazione di cricche sub-superficiali fino al distacco di micro-porzioni di materiale, producendo il fenomeno del *pitting* (butteratura superficiale del fianco del dente, assimilabile alla formazione di micro-crateri).


#block[
  *Procedura progettuale di intervento (gerarchia di ridimensionamento):* \
  Qualora le verifiche strutturali a *fatica flessionale* o a *usura per contatto* (_pitting_) non risultino soddisfatte in sede di progetto, il progettista interviene modificando i parametri secondo una precisa sequenza gerarchica:
  + *Aumento della larghezza di fascia ($b$):* si incrementa innanzitutto $b$ (restando all'interno dell'intervallo consigliato per il fattore di scala $lambda = b / m in [9, 14]$, tipicamente $b approx 10 m$), così da aumentare direttamente la sezione resistente del dente e ridurre linearmente l'incidenza delle sollecitazioni per unità di lunghezza.
  + *Aumento del modulo ($m$):* se l'intervento su $b$ raggiunge il limite superiore ammissibile senza soddisfare la verifica, si passa al *modulo unificato superiore* (aumentando così la dimensione complessiva del dente).
  + *Miglioramento del materiale:* se anche l'aumento del modulo non è praticabile (ad esempio per stringenti vincoli d'ingombro o sul numero minimo di denti), si modifica il *materiale* o il *trattamento termico superficiale* (es. cementazione, nitrurazione), scegliendone uno con caratteristiche di resistenza limite a fatica flessionale e hertziana più elevate.
]

== Ruote coniche, con dentatura elicoidale e vite senza fine

=== Ruote coniche

Nelle trasmissioni tra assi incidenti, la forma dei denti di una ruota conica è assimilata a quella di una *ruota cilindrica a denti diritti equivalente*, avente raggio pari alla generatrice del *cono complementare* ($r_b$).

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (left + horizon, center + horizon),
  [
    / Angoli dei coni primitivi ($gamma, Gamma$):
      $
        tan gamma &= z_("pignone") / z_("ruota") \
        tan Gamma &= z_("ruota") / z_("pignone")
      $
    
    / Raggio equivalente ($r_b$): generatrice del cono complementare ricavata dalla geometria in figura:
      $ r_b = (D_G / 2) / (cos Gamma) $

    / Passo primitivo ($p$): passo misurato sulla parte più larga del dente, in corrispondenza del diametro $D_G$.

    / Numero di denti equivalente ($z'$): numero di denti _immaginario_ della ruota cilindrica virtuale:
      $ z' = (2 pi r_b) / p $
  ],
  [
    #figure(
      image("4d741021-6053-41b2-a86d-c4ffa4912f8f-13_644_676_527_416.jpg", width: 90%),
      caption: [[libro di testo]],
      supplement: none,
    )
  ]
)

#v(0.5em)

#block[
  *La ruota cilindrica a denti diritti * \
  Sebbene le ruote coniche (o tronco-coniche) presentino una geometria tridimensionale più complessa caratterizzata dagli angoli di semi-apertura dei coni primitivi $gamma$ (pignone) e $Gamma$ (ruota), nella regione di ingranamento il *comportamento locale dei denti* è del tutto assimilabile a quello di una ruota cilindrica a denti diritti equivalente di raggio $r_b$. Ciò consente di utilizzare il modello della ruota cilindrica a denti diritti come *paradigma di riferimento* per scegliere passo, modulo e caratteristiche locali della dentatura, trasferendo poi tali parametri alla geometria conica effettiva di costruzione mediante le formule di conversione fornite dalla manualistica di settore.
]

#v(1em)

=== Ruote cilindriche con dentatura elicoidale

Anche per le operazioni di dimensionamento delle *ruote cilindriche a dentatura elicoidale*, la geometria viene interpretata riconducendosi a quella di una *ruota a dentatura diritta equivalente*. A tal fine, noto l'*angolo dell'elica* $Psi$ (oppure $beta$), è necessario mettere in relazione le *grandezze normali* ($n$), misurabili nel piano normale all'elica, con quelle *trasversali* ($t$), giacenti nel piano frontale della ruota.

#grid(
  columns: (1fr, 1.1fr),
  column-gutter: 1.5em,
  align: (left + horizon, center + horizon),
  [
    / Passo normale e trasversale ($p_n, p_t$):
      $ p_n = p_t cos psi = p_t cos beta $

    / Modulo normale e trasversale ($m_n, m_t$):
      $ m_n = m_t cos psi = m_t cos beta $

    / Angolo di pressione ($phi_n, phi_t$ oppure $alpha_n, alpha_t$):
      $ 
        tg phi_n &= tg phi_t cos psi \
        tg alpha_n &= tg alpha_t cos beta 
      $

    / Riferimenti geometrici principali:
      - *Sezione $A$-$A$*: traccia del piano trasversale ($t$), a cui afferiscono il passo $p_t$ e l'angolo $phi_t$.
      - *Sezione $B$-$B$*: traccia del piano normale ($n$), su cui si misura il passo normale $p_n$ (segmento $a$-$e$).
      - *Passo assiale ($p_x$)*: distanza misurata lungo la direzione dell'asse di rotazione (segmento $a$-$d$).
  ],
  [
#canvas(length: 1cm, {
  import draw: *

  // 1. CONTORNO DELLA FASCIA DENTATA (bordo superiore, inferiore e fratture laterali)
  // Bordo superiore e inferiore (stroke: 1.2pt)
  line((-2.95, 1.48), (2.50, 1.48), stroke: 1.2pt)
  line((-2.95, 0.00), (2.50, 0.00), stroke: 1.2pt)

  // Frattura sinistra (x ~ -2.95, da y = 0 a y = 1.48)
  bezier((-2.95, 0.00), (-2.92, 0.50), (-3.02, 0.18), (-2.88, 0.35), stroke: 1.2pt)
  bezier((-2.92, 0.50), (-3.00, 1.00), (-2.96, 0.68), (-3.05, 0.85), stroke: 1.2pt)
  bezier((-3.00, 1.00), (-2.95, 1.48), (-2.92, 1.18), (-2.98, 1.32), stroke: 1.2pt)

  // Frattura destra (x ~ 2.50, da y = 0 a y = 1.48)
  bezier((2.50, 0.00), (2.42, 0.50), (2.52, 0.18), (2.38, 0.35), stroke: 1.2pt)
  bezier((2.42, 0.50), (2.48, 1.00), (2.46, 0.68), (2.52, 0.85), stroke: 1.2pt)
  bezier((2.48, 1.00), (2.50, 1.48), (2.42, 1.18), (2.52, 1.32), stroke: 1.2pt)

  // 2. TRACCE DEI DENTI ELICOIDALI (inclinate di 30deg rispetto alla verticale: dx = -0.854 su dy = 1.48)
  // Coppia 1 (estrema sinistra, parziale)
  line((-2.22, 0.00), (-2.96, 1.28), stroke: 0.5pt)
  line((-2.12, 0.00), (-2.97, 1.48), stroke: 0.5pt)

  // Coppia 2
  line((-1.48, 0.00), (-2.33, 1.48), stroke: 0.5pt)
  line((-1.38, 0.00), (-2.23, 1.48), stroke: 0.5pt)

  // Coppia 3
  line((-0.74, 0.00), (-1.59, 1.48), stroke: 0.5pt)
  line((-0.64, 0.00), (-1.49, 1.48), stroke: 0.5pt)

  // Coppia 4 (passante per a = (0, 0))
  line((0.00, 0.00), (-0.85, 1.48), stroke: 0.5pt)
  line((0.10, 0.00), (-0.75, 1.48), stroke: 0.5pt)

  // Coppia 5 (intermedia tra a e c)
  line((0.74, 0.00), (-0.11, 1.48), stroke: 0.5pt)
  line((0.84, 0.00), (-0.01, 1.48), stroke: 0.5pt)

  // Coppia 6 (passante per c = (1.48, 0))
  line((1.48, 0.00), (0.63, 1.48), stroke: 0.5pt)
  line((1.58, 0.00), (0.73, 1.48), stroke: 0.5pt)

  // Coppia 7
  line((2.22, 0.00), (1.37, 1.48), stroke: 0.5pt)
  line((2.32, 0.00), (1.47, 1.48), stroke: 0.5pt)

  // Coppia 8 (estrema destra, parziale)
  line((2.46, 0.87), (2.11, 1.48), stroke: 0.5pt)
  line((2.47, 1.03), (2.21, 1.48), stroke: 0.5pt)

  // 3. ASSI, SEZIONI A-A E B-B, E PROLUNGAMENTI DEL TRIANGOLO DEI PASSI
  // Linea di sezione orizzontale A (tratto-punto)
  line((-3.25, 0.68), (4.10, 0.68), stroke: (dash: "dash-dotted", thickness: 0.5pt))
  line((4.10, 0.68), (4.10, 1.15), mark: (end: ">", fill: black), stroke: 0.5pt)

  // Linea verticale per a - d (tratto-punto nella fascia, continua fuori)
  line((0.00, -1.05), (0.00, 0.00), stroke: 0.5pt)
  line((0.00, 0.00), (0.00, 1.48), stroke: (dash: "dash-dotted", thickness: 0.5pt))
  line((0.00, 1.48), (0.00, 2.95), stroke: 0.5pt)

  // Linea di sezione B-B (inclinata a 30deg rispetto all'orizzontale)
  line((-2.35, -1.36), (-0.60, -0.35), stroke: 0.5pt)
  line((-0.60, -0.35), (1.85, 1.07), stroke: (dash: "dash-dotted", thickness: 0.5pt))
  line((1.85, 1.07), (4.10, 2.37), stroke: 0.5pt)
  // Frecce alle estremita della sezione B-B
  line((-2.35, -1.36), (-2.12, -1.76), mark: (end: ">", fill: black), stroke: 0.5pt)
  line((4.10, 2.37), (4.33, 1.97), mark: (end: ">", fill: black), stroke: 0.5pt)

  // Prolungamento della traccia per "a" in alto a sinistra (per quota p_n, fino a b)
  line((-0.85, 1.48), (-1.62, 2.81), stroke: 0.5pt)

  // Prolungamento della traccia per "c" in alto a sinistra (passa per d = (0, 2.56)) e in basso a destra
  line((0.63, 1.48), (-0.52, 3.46), stroke: 0.5pt)
  line((1.48, 0.00), (1.68, -0.35), stroke: 0.5pt)

  // Segmento normale a-e (perpendicolare alle tracce dei denti, da (0,0) a (1.11, 0.64))
  line((0.00, 0.00), (1.11, 0.64), stroke: 0.5pt)

  // 4. QUOTE (p_n, p_t, p_x) E ARCHI DELL'ANGOLO D'ELICA (psi)
  // Quota p_n (in alto a sinistra, inclinata a 30deg tra le due tracce prolungate)
  line((-1.15, 2.68), (-1.53, 2.46), mark: (end: ">", fill: black), stroke: 0.5pt)
  line((-0.78, 2.90), (-0.42, 3.10), mark: (end: ">", fill: black), stroke: 0.5pt)

  // Quota p_t (in basso, tra x = 0 e x = 1.48)
  line((1.48, 0.25), (1.48, -1.05), stroke: 0.5pt)
  line((0.48, -0.82), (0.00, -0.82), mark: (end: ">", fill: black), stroke: 0.5pt)
  line((1.00, -0.82), (1.48, -0.82), mark: (end: ">", fill: black), stroke: 0.5pt)

  // Quota p_x (a destra, tra y = 0.00 e y = 2.56)
  line((-0.20, 2.56), (3.42, 2.56), stroke: 0.5pt)
  line((2.70, 0.00), (3.42, 0.00), stroke: 0.5pt)
  line((3.05, 1.55), (3.05, 2.56), mark: (end: ">", fill: black), stroke: 0.5pt)
  line((3.05, 1.00), (3.05, 0.00), mark: (end: ">", fill: black), stroke: 0.5pt)

  // Arco superiore per psi (centro d = (0, 2.56), R = 0.85, tra 270deg e 300deg)
  arc((0.00, 2.56), start: 248deg, stop: 270deg, radius: 0.85, anchor: "origin", mark: (end: ">", fill: black), stroke: 0.5pt)
  arc((0.00, 2.56), start: 300deg, stop: 325deg, radius: 0.85, anchor: "origin", mark: (start: ">", fill: black), stroke: 0.5pt)

  // Arco inferiore per psi (centro a = (0, 0), R = 1.00, tra 0deg e 30deg)
  arc((0.00, 0.00), start: -24deg, stop: 0deg, radius: 1.00, anchor: "origin", mark: (end: ">", fill: black), stroke: 0.5pt)
  arc((0.00, 0.00), start: 30deg, stop: 52deg, radius: 1.00, anchor: "origin", mark: (start: ">", fill: black), stroke: 0.5pt)

  // 5. ETICHETTE (tutte con text(size: 7pt))
  content((-1.68, 2.95), text(size: 7pt)[$b$], anchor: "center")
  content((-0.95, 2.80), text(size: 7pt)[$p_n$], anchor: "center")
  content((0.18, 2.90), text(size: 7pt)[$d$], anchor: "center")
  content((0.78, 2.28), text(size: 7pt)[$psi$], anchor: "center")

  content((-0.20, -0.18), text(size: 7pt)[$a$], anchor: "center")
  content((1.75, -0.18), text(size: 7pt)[$c$], anchor: "center")
  content((1.78, 0.72), text(size: 7pt)[$e$], anchor: "center")

  content((0.82, -0.45), text(size: 7pt)[$psi$], anchor: "center")
  content((0.74, -0.82), text(size: 7pt)[$p_t$], anchor: "center")

  content((3.08, 1.28), text(size: 7pt)[$p_x$], anchor: "center")
  content((4.10, 1.38), text(size: 7pt)[$A$], anchor: "center")
  content((4.48, 1.85), text(size: 7pt)[$B$], anchor: "center")
  content((-1.98, -1.85), text(size: 7pt)[$B$], anchor: "center")
})

#canvas(length: 1cm, {
  import draw: *

  // 1. CAMPITURA A LINEE VERTICALI NELLA SEZIONE (passo 0.22 cm, da x = -3.08 a x = 3.08)
  // Zona fondo sinistro
  line((-3.08, 0.00), (-3.08, 0.65), stroke: 0.45pt)
  line((-2.86, 0.00), (-2.86, 0.65), stroke: 0.45pt)

  // Dente 1 (tra -2.70 e -1.30)
  line((-2.64, 0.00), (-2.64, 0.82), stroke: 0.45pt)
  line((-2.42, 0.00), (-2.42, 1.43), stroke: 0.45pt)
  line((-2.20, 0.00), (-2.20, 1.65), stroke: 0.45pt)
  line((-1.98, 0.00), (-1.98, 1.65), stroke: 0.45pt)
  line((-1.76, 0.00), (-1.76, 1.65), stroke: 0.45pt)
  line((-1.54, 0.00), (-1.54, 1.32), stroke: 0.45pt)
  line((-1.32, 0.00), (-1.32, 0.71), stroke: 0.45pt)

  // Vano 1 (tra -1.30 e -0.70)
  line((-1.10, 0.00), (-1.10, 0.65), stroke: 0.45pt)
  line((-0.88, 0.00), (-0.88, 0.65), stroke: 0.45pt)

  // Dente 2 (tra -0.70 e 0.70)
  line((-0.66, 0.00), (-0.66, 0.76), stroke: 0.45pt)
  line((-0.44, 0.00), (-0.44, 1.37), stroke: 0.45pt)
  line((-0.22, 0.00), (-0.22, 1.65), stroke: 0.45pt)
  line((0.00, 0.00), (0.00, 1.65), stroke: 0.45pt)
  line((0.22, 0.00), (0.22, 1.65), stroke: 0.45pt)
  line((0.44, 0.00), (0.44, 1.37), stroke: 0.45pt)
  line((0.66, 0.00), (0.66, 0.76), stroke: 0.45pt)

  // Vano 2 (tra 0.70 e 1.30)
  line((0.88, 0.00), (0.88, 0.65), stroke: 0.45pt)
  line((1.10, 0.00), (1.10, 0.65), stroke: 0.45pt)

  // Dente 3 (tra 1.30 e 2.70)
  line((1.32, 0.00), (1.32, 0.71), stroke: 0.45pt)
  line((1.54, 0.00), (1.54, 1.32), stroke: 0.45pt)
  line((1.76, 0.00), (1.76, 1.65), stroke: 0.45pt)
  line((1.98, 0.00), (1.98, 1.65), stroke: 0.45pt)
  line((2.20, 0.00), (2.20, 1.65), stroke: 0.45pt)
  line((2.42, 0.00), (2.42, 1.43), stroke: 0.45pt)
  line((2.64, 0.00), (2.64, 0.82), stroke: 0.45pt)

  // Zona fondo destro
  line((2.86, 0.00), (2.86, 0.65), stroke: 0.45pt)
  line((3.08, 0.00), (3.08, 0.65), stroke: 0.45pt)

  // 2. CONTORNO SUPERIORE DEI TRE DENTI E BASE INFERIORE (stroke: 1.3pt)
  line(
    (-3.20, 0.65),
    (-2.70, 0.65), (-2.34, 1.65), (-1.66, 1.65), (-1.30, 0.65),
    (-0.70, 0.65), (-0.34, 1.65), (0.34, 1.65), (0.70, 0.65),
    (1.30, 0.65), (1.66, 1.65), (2.34, 1.65), (2.70, 0.65),
    (3.20, 0.65),
    stroke: 1.3pt
  )

  // Bordo inferiore spesso
  line((-3.20, 0.00), (3.20, 0.00), stroke: 1.5pt)

  // 3. LINEA PRIMITIVA ORIZZONTALE MOLTO SPESSA (tratto-punto a y = 1.15, stroke: 2.2pt)
  line((-3.20, 1.15), (-0.28, 1.15), stroke: 2.2pt)
  line((-0.14, 1.15), (0.14, 1.15), stroke: 2.2pt)
  line((0.28, 1.15), (3.20, 1.15), stroke: 2.2pt)

  // 4. QUOTA DELL'ANGOLO DI PRESSIONE TRASVERSALE phi_t
  // Linea verticale di riferimento (in x = -0.52)
  line((-0.52, 1.35), (-0.52, 3.25), stroke: 0.55pt)

  // Linea obliqua di riferimento (prolungamento del fianco sinistro del Dente 2, a 70deg)
  line((-0.30, 1.76), (0.20, 3.13), stroke: 0.55pt)

  // Archi con frecce (centro in (-0.52, 1.15), raggio R = 1.80)
  arc((-0.52, 1.15), start: 90deg, stop: 108deg, radius: 1.80, anchor: "origin", mark: (start: ">", fill: black), stroke: 0.55pt)
  arc((-0.52, 1.15), start: 52deg, stop: 70deg, radius: 1.80, anchor: "origin", mark: (end: ">", fill: black), stroke: 0.55pt)

  // 5. ETICHETTE (tutte con text(size: 7pt))
  content((-0.24, 2.82), text(size: 7pt)[$phi_t$], anchor: "center")
  content((0.00, -0.55), text(size: 7pt)[Sezione $A$-$A$], anchor: "center")
})
// FASE 3 - VERIFICA
// 1. Verifica allineamento del fianco sinistro del dente centrale e della linea di quota:
//    - Fianco: da (-0.70, 0.65) a (-0.34, 1.65) -> pendenza dy/dx = 1.00 / 0.36 = 2.778 (angolo 70.2deg, cioè phi_t = 19.8deg ~ 20deg).
//    - Intersezione con la linea primitiva y = 1.15: x = -0.70 + 0.50 * 0.36 = -0.52 -> P = (-0.52, 1.15).
//    - Prolungamento da (-0.30, 1.76) a (0.20, 3.13): per x = -0.30, y = 1.15 + 0.22 * 2.75 = 1.755; per x = 0.20, y = 1.15 + 0.72 * 2.75 = 3.13. Allineato esattamente col fianco e col centro degli archi P = (-0.52, 1.15). OK.
// 2. Tutte le 27 linee verticali di campitura terminano esattamente sul contorno superiore della cremagliera. OK.
// 3. Regole del codice: nessuna parola vietata, tutti gli arc hanno anchor: "origin" e start < stop, entrambe le etichette sono avvolte in text(size: 7pt)[...].
  ]
)

#v(0.5em)

Nelle ruote elicoidali i denti si sviluppano lungo la larghezza di fascia secondo una direzione inclinata dell'angolo d'elica $Psi$ (o $beta$) rispetto all'asse del rotore. Questa configurazione porta a distinguere operativamente due piani fondamentali:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  [
    
      *Piano Normale ($n$, sezione $B$-$B$)* \
      Sezionando la ruota con un piano ortogonale alla direzione di sviluppo del dente, la sezione appare *identica a quella di una ruota cilindrica a denti diritti*. In tale piano di progetto si applica quindi direttamente il paradigma di dimensionamento già visto per i denti diritti.
    ],
  [
    
      *Piano Trasversale ($t$, sezione $A$-$A$)* \
      Il costruttore necessita tuttavia delle dimensioni geometriche riferite alla faccia frontale della ruota (detto anche *piano frontale o tangenziale*, ortogonale all'asse di rotazione). Le tre formule di trasformazione sopra riportate (_da memorizzare_) permettono di convertire immediatamente passo, modulo e angolo di pressione tra il piano normale di progetto e quello trasversale di costruzione.
    ]
  
)

#v(0.8em)

Infine, si ricava un *numero di denti equivalente* (_virtuale_) $z'$ per una ruota cilindrica a denti diritti avente lo stesso passo della dentatura elicoidale (si noti che risulta sempre $z' > z_("vero")$). Come per le altre tipologie di ruote, anche in questo caso esistono formule specifiche per il calcolo del numero minimo dei denti (riportate sul testo di riferimento).

$ z' = z_("vero") / (cos^3 Psi) = z_("vero") / (cos^3 beta) $



#v(1em)

=== Cinematica dell'ingranamento e azioni di contatto
Anche per le dentature elicoidali il *profilo a evolvente* rimane ampiamente utilizzato, ma la geometria dell'elica impone condizioni cinematiche e statiche specifiche rispetto al caso dei denti diritti:
    
    / Condizione di ingranamento: si ottiene esclusivamente se pignone e ruota hanno *elica opposta* (destrorsa e sinistrorsa rispettivamente, o viceversa), *mai concorde*.
    / Modalità di contatto: l'ingranamento inizia in un *punto* e poi si estende *gradualmente lungo una linea* nello spessore del dente, prestandosi a una migliore distribuzione del carico.
    / Spinta assiale: a causa dell'inclinazione di $psi$, la forza di contatto tra i denti genera una *componente assiale* lungo l'asse del rotore, assente nelle ruote a denti diritti.


#v(0.8em)

=== Confronto con i denti diritti: rumorosità e pressione locale

A differenza delle ruote a denti diritti, nelle quali l'intera linea di contatto entra in presa simultaneamente, nelle ruote elicoidali i fianchi coniugati _si adagiano progressivamente_ l'uno sull'altro, interessando in ogni istante solo una porzione limitata della superficie del dente: \
      Poiché la forza viene scaricata su una regione istantanea di contatto più ristretta, si genera una *concentrazione locale di pressione e sollecitazione* di cui occorre tenere conto nel dimensionamento, unitamente alla presenza della *componente di spinta assiale* lungo l'asse del rotore.




=== Accoppiamento vite senza fine - ruota elicoidale

Nell'accoppiamento tra una *vite senza fine* e una *ruota elicoidale* (impiegato tipicamente per trasmettere il moto tra assi sghembi ortogonali), la *condizione di ingranamento* impone che l'angolo di avvolgimento dell'elica della vite sia *complementare* all'angolo d'elica della ruota. Questo meccanismo consente di realizzare un'*altissima riduzione di velocità* in un singolo stadio, con rapporti di trasmissione compresi tra $1/10$ e $1/500$:

$ tau = f / N $

dove $f$ rappresenta il *numero di filetti* (o principi) della vite e $N$ il numero di denti della ruota elicoidale.

#grid(
  columns: (1fr, 1.15fr),
  column-gutter: 1.5em,
  align: (left + horizon, center + horizon),
  [
    / Diametri primitivi ($d_w, d_G$): diametri dei cilindri primitivi della vite senza fine ($d_w$) e della ruota elicoidale ($d_G$).
    
    / Passo assiale ($p_x$) e Passo dell'elica ($L$): il passo assiale $p_x$ è la distanza tra due creste consecutive; il passo dell'elica $L$ rappresenta l'avanzamento assiale completo di un filetto in un giro.
    
    / Angoli caratteristici della vite ($lambda, psi_W$): l'*angolo di passo* $lambda$ (inclinazione del filetto rispetto al piano trasversale) e l'*angolo d'elica* $psi_W$ (riferito all'asse della vite) sono tra loro complementari ($lambda + psi_W = 90^circle$).

    #v(0.5em)
    
  ],
  [
#canvas(length: 1cm, {
  import draw: *

  line(
    (-3.48, 0.56), (-3.48, 0.80), (-3.36, 0.80), (-3.30, 0.56),
    (-3.08, 0.56), (-3.02, 0.80), (-2.90, 0.80), (-2.84, 0.56),
    (-2.64, 0.56), (-2.58, 0.80), (-2.46, 0.80), (-2.40, 0.56),
    (-2.20, 0.56), (-2.14, 0.80), (-2.02, 0.80), (-1.96, 0.56),
    (-1.76, 0.56), (-1.70, 0.80), (-1.58, 0.80), (-1.52, 0.56),
    (-1.42, 0.56), (-1.42, -0.56),
    (-1.54, -0.56), (-1.60, -0.80), (-1.72, -0.80), (-1.78, -0.56),
    (-1.98, -0.56), (-2.04, -0.80), (-2.16, -0.80), (-2.22, -0.56),
    (-2.42, -0.56), (-2.48, -0.80), (-2.60, -0.80), (-2.66, -0.56),
    (-2.86, -0.56), (-2.92, -0.80), (-3.04, -0.80), (-3.10, -0.56),
    (-3.30, -0.56), (-3.36, -0.80), (-3.44, -0.80), (-3.48, -0.62),
    close: true,
    fill: gray.transparentize(65%),
    stroke: 0.6pt
  )

  // Linee delle creste e dei fondi dei filetti inclinati (da alto-sinistra a basso-destra)
  // Filetto 1
  line((-3.48, 0.72), (-3.36, -0.80), stroke: 0.5pt)
  line((-3.36, 0.80), (-3.10, -0.56), stroke: 0.5pt)
  line((-3.30, 0.56), (-3.04, -0.80), stroke: 0.5pt)
  // Filetto 2
  line((-3.08, 0.56), (-2.92, -0.80), stroke: 0.5pt)
  line((-3.02, 0.80), (-2.80, -0.80), stroke: 0.5pt)
  line((-2.90, 0.80), (-2.66, -0.56), stroke: 0.5pt)
  line((-2.84, 0.56), (-2.60, -0.80), stroke: 0.5pt)
  // Filetto 3
  line((-2.64, 0.56), (-2.48, -0.80), stroke: 0.5pt)
  line((-2.58, 0.80), (-2.36, -0.80), stroke: 0.5pt)
  line((-2.46, 0.80), (-2.22, -0.56), stroke: 0.5pt)
  line((-2.40, 0.56), (-2.16, -0.80), stroke: 0.5pt)
  // Filetto 4
  line((-2.20, 0.56), (-2.04, -0.80), stroke: 0.5pt)
  line((-2.14, 0.80), (-1.92, -0.80), stroke: 0.5pt)
  line((-2.02, 0.80), (-1.78, -0.56), stroke: 0.5pt)
  line((-1.96, 0.56), (-1.72, -0.80), stroke: 0.5pt)
  // Filetto 5
  line((-1.76, 0.56), (-1.60, -0.80), stroke: 0.5pt)
  line((-1.70, 0.80), (-1.48, -0.80), stroke: 0.5pt)
  line((-1.58, 0.80), (-1.42, -0.20), stroke: 0.5pt)
  line((-1.52, 0.56), (-1.42, -0.05), stroke: 0.5pt)

  // Generatrici primitive sulla vista laterale (tratteggiate a y = +0.70 e y = -0.70)
  line((-3.58, 0.70), (-1.32, 0.70), stroke: (dash: "dashed", thickness: 0.5pt))
  line((-3.58, -0.70), (-1.32, -0.70), stroke: (dash: "dashed", thickness: 0.5pt))

  // =========================================================================
  // 2. VISTA CENTRALE: VITE ASSIALE E RUOTA ELICOIDALE SEZIONATA
  // =========================================================================
  // Riempimento grigio della Ruota elicoidale (sezione verticale tra x = -0.42 e x = 0.42)
  // Meta superiore della corona ruota
  line(
    (-0.42, -0.73), (-0.28, -0.79), (-0.14, -0.83), (0.00, -0.84),
    (0.14, -0.83), (0.28, -0.79), (0.42, -0.73),
    (0.42, -2.35), (-0.42, -2.35),
    close: true,
    fill: gray.transparentize(55%),
    stroke: 0.6pt
  )

  // Meta inferiore della corona ruota (con gola inferiore concava verso il basso)
  line(
    (-0.42, -3.45), (0.42, -3.45),
    (0.42, -5.07), (0.28, -5.24), (0.28, -5.31), (0.14, -5.25), (0.00, -5.24),
    (-0.14, -5.25), (-0.28, -5.31), (-0.28, -5.24), (-0.42, -5.07),
    close: true,
    fill: gray.transparentize(55%),
    stroke: 0.6pt
  )

  // Bordi verticali del foro centrale della ruota (tra y = -2.35 e y = -3.45)
  line((-0.42, -2.35), (-0.42, -3.45), stroke: 0.6pt)
  line((0.42, -2.35), (0.42, -3.45), stroke: 0.6pt)

  // Vite senza fine in vista assiale (cerchi concentrici in O = (0, 0))
  // Cerchio esterno (di testa, R = 0.80)
  circle((0, 0), radius: 0.80, fill: gray.transparentize(65%), stroke: 0.6pt)
  // Cerchio interno (di fondo, R = 0.56)
  circle((0, 0), radius: 0.56, fill: none, stroke: 0.6pt)
  // Cerchio primitivo (R_w = 0.70, tratto-punto)
  circle((0, 0), radius: 0.70, fill: none, stroke: (dash: "dash-dotted", thickness: 0.5pt))
  // Foro centrale (R = 0.30, bianco) con cava per linguetta
  circle((0, 0), radius: 0.30, fill: white, stroke: 0.6pt)
  line((-0.06, -0.29), (-0.06, -0.37), (0.06, -0.37), (0.06, -0.29), fill: white, stroke: 0.6pt)

  // Dettagli delle gole superiore e inferiore della ruota elicoidale
  // Gola superiore (centro (0, 0)):
  arc((0, 0), start: 240deg, stop: 300deg, radius: 0.84, anchor: "origin", stroke: 0.6pt)
  line((0, 0), (-0.42, -0.73), stroke: (dash: "dashed", thickness: 0.45pt))
  line((0, 0), (0.42, -0.73), stroke: (dash: "dashed", thickness: 0.45pt))

  // Gola inferiore (centro O_inf = (0, -5.80)):
  arc((0, -5.80), start: 60deg, stop: 120deg, radius: 0.84, anchor: "origin", stroke: 0.6pt)
  arc((0, -5.80), start: 48deg, stop: 132deg, radius: 0.70, anchor: "origin", stroke: (dash: "dash-dotted", thickness: 0.5pt))
  arc((0, -5.80), start: 60deg, stop: 120deg, radius: 0.56, anchor: "origin", stroke: 0.6pt)
  line((0, -5.80), (-0.42, -5.07), stroke: (dash: "dashed", thickness: 0.45pt))
  line((0, -5.80), (0.42, -5.07), stroke: (dash: "dashed", thickness: 0.45pt))
  line((-0.15, -5.80), (0.15, -5.80), stroke: 0.5pt)

  // =========================================================================
  // 3. VISTA DESTRA: CILINDRO PRIMITIVO ED ELICA
  // =========================================================================
  // Contorno del cilindro primitivo (a tratto-punto, tra x = 1.15 e x = 3.25, y = +-0.70)
  line((1.15, 0.70), (3.25, 0.70), stroke: (dash: "dash-dotted", thickness: 0.6pt))
  line((1.15, -0.70), (3.25, -0.70), stroke: (dash: "dash-dotted", thickness: 0.6pt))
  line((1.15, -0.70), (1.15, 0.70), stroke: (dash: "dash-dotted", thickness: 0.6pt))
  line((3.25, -0.70), (3.25, 0.70), stroke: (dash: "dash-dotted", thickness: 0.6pt))

  // Spira dell'elica sul cilindro primitivo
  // Tratti anteriori (continui spessi)
  line((1.85, 0.00), (1.96, -0.70), stroke: 1.2pt)
  line((2.16, 0.70), (2.27, 0.00), stroke: 1.2pt)
  // Tratto posteriore (tratteggiato)
  line((1.96, -0.70), (2.16, 0.70), stroke: (dash: "dashed", thickness: 0.5pt))

  // =========================================================================
  // 4. ASSI DI SIMMETRIA COMUNI
  // =========================================================================
  // Asse orizzontale superiore (attraversa tutte e tre le viste)
  line((-3.68, 0.00), (3.95, 0.00), stroke: (dash: "dash-dotted", thickness: 0.5pt))

  // Asse verticale centrale (attraversa la vite assiale e la ruota elicoidale fino a O_inf)
  line((0.00, 0.92), (0.00, -5.95), stroke: (dash: "dash-dotted", thickness: 0.5pt))

  // Asse orizzontale della ruota elicoidale (in y = -2.90)
  line((-0.68, -2.90), (0.68, -2.90), stroke: (dash: "dash-dotted", thickness: 0.5pt))

  // =========================================================================
  // 5. QUOTE E FRECCE DI INDICAZIONE
  // =========================================================================
  // Quota: Diametro interno (tra y = -0.56 e y = +0.56, a x = -1.12)
  line((-1.38, 0.56), (-0.98, 0.56), stroke: 0.5pt)
  line((-1.38, -0.56), (-0.98, -0.56), stroke: 0.5pt)
  line((-1.12, -0.56), (-1.12, 0.56), mark: (start: ">", end: ">", fill: black), stroke: 0.5pt)
  line((-1.12, 0.56), (-1.12, 1.32), (-1.38, 1.32), stroke: 0.5pt)

  // Quota: Diametro primitivo d_w (tra x = -0.70 e x = +0.70, in alto a y = 1.32)
  line((-0.70, 0.25), (-0.70, 1.48), stroke: 0.5pt)
  line((0.70, 0.25), (0.70, 1.48), stroke: 0.5pt)
  line((-0.70, 1.32), (0.70, 1.32), mark: (start: ">", end: ">", fill: black), stroke: 0.5pt)
  line((0.00, 1.32), (-0.12, 1.85), (-0.38, 1.85), stroke: 0.5pt)

  // Freccia: Vite senza fine
  line((-3.12, -1.35), (-3.12, -0.82), mark: (end: ">", fill: black), stroke: 0.5pt)

  // Quota: Passo assiale p_x (tra due creste inferiori a x = -2.66 e x = -2.28)
  line((-2.66, -0.85), (-2.66, -1.25), stroke: 0.5pt)
  line((-2.28, -0.85), (-2.28, -1.25), stroke: 0.5pt)
  line((-2.98, -1.12), (-2.66, -1.12), mark: (end: ">", fill: black), stroke: 0.5pt)
  line((-1.96, -1.12), (-2.28, -1.12), mark: (end: ">", fill: black), stroke: 0.5pt)
  line((-2.66, -1.12), (-2.28, -1.12), stroke: 0.5pt)
  line((-2.47, -1.12), (-2.36, -1.62), (-2.22, -1.62), stroke: 0.5pt)

  // Freccia: Cilindro primitivo
  line((1.50, 1.05), (1.35, 0.72), mark: (end: ">", fill: black), stroke: 0.5pt)

  // Freccia: Elica
  line((2.98, 0.95), (2.82, 0.95), (2.22, 0.42), mark: (end: ">", fill: black), stroke: 0.5pt)

  // Quota: Passo L (tra x = 1.85 e x = 2.27)
  line((1.85, -0.08), (1.85, -1.48), stroke: 0.5pt)
  line((2.27, -0.08), (2.27, -1.48), stroke: 0.5pt)
  line((2.06, -1.35), (2.06, -1.85), (2.20, -1.85), stroke: 0.5pt)

  // Angoli lambda (Angolo di passo) e psi_W (Angolo d'elica), centro (2.27, 0.00), R = 1.45
  // Prolungamento dell'elica a 279deg
  line((2.27, 0.00), (2.52, -1.58), stroke: 0.5pt)
  // Arco per psi_W (da 279deg a 360deg)
  arc((2.27, 0.00), start: 279deg, stop: 360deg, radius: 1.45, anchor: "origin", mark: (start: ">", end: ">", fill: black), stroke: 0.5pt)
  // Arco e linea di richiamo per lambda (tra 270deg e 279deg)
  arc((2.27, 0.00), start: 252deg, stop: 270deg, radius: 1.45, anchor: "origin", mark: (end: ">", fill: black), stroke: 0.5pt)
  line((2.38, -1.44), (2.58, -1.62), (2.75, -1.62), stroke: 0.5pt)

  // Quota: Diametro primitivo d_G (tra y = -0.70 e y = -5.10, a x = 0.88)
  line((0.20, -0.70), (1.05, -0.70), stroke: 0.5pt)
  line((0.20, -5.10), (1.05, -5.10), stroke: 0.5pt)
  line((0.88, -2.05), (0.88, -0.70), mark: (end: ">", fill: black), stroke: 0.5pt)
  line((0.88, -4.15), (0.88, -5.10), mark: (end: ">", fill: black), stroke: 0.5pt)

  // Freccia: Ruota elicoidale
  line((-0.85, -4.35), (-0.44, -4.45), mark: (end: ">", fill: black), stroke: 0.5pt)

  // =========================================================================
  // 6. ETICHETTE (tutte con text(size: 7pt))
  // =========================================================================
  content((-1.42, 1.32), text(size: 7pt)[Diametro interno], anchor: "east")

  content((-0.90, 1.95), text(size: 7pt)[Diametro], anchor: "center")
  content((-0.90, 1.68), text(size: 7pt)[primitivo $d_w$], anchor: "center")

  content((1.55, 1.45), text(size: 7pt)[Cilindro], anchor: "center")
  content((1.55, 1.18), text(size: 7pt)[primitivo], anchor: "center")

  content((3.05, 0.95), text(size: 7pt)[Elica], anchor: "west")

  content((-3.12, -1.55), text(size: 7pt)[Vite senza], anchor: "center")
  content((-3.12, -1.82), text(size: 7pt)[fine], anchor: "center")

  content((-2.15, -1.55), text(size: 7pt)[Passo], anchor: "west")
  content((-2.32, -1.82), text(size: 7pt)[assiale $p_x$], anchor: "west")

  content((3.72, -0.82), text(size: 7pt)[$psi_W$, Angolo d'elica], anchor: "center")
  content((2.80, -1.62), text(size: 7pt)[Angolo di passo $lambda$], anchor: "west")
  content((2.25, -1.85), text(size: 7pt)[Passo $L$], anchor: "west")

  content(
  (0.88, -3.10), 
  text(size: 7pt)[Diametro primitivo $d_G$], 
  anchor: "center", 
  angle: -90deg
)

  content((-1.32, -4.25), text(size: 7pt)[Ruota], anchor: "center")
  content((-1.32, -4.52), text(size: 7pt)[elicoidale], anchor: "center")
})
  ]
)
*Criteri pratici di dimensionamento della vite:*
    1. Il *diametro primitivo* $d_w$ può essere scelto arbitrariamente, purché opportunamente correlato al valore dell'*interasse* tramite le formule empiriche della manualistica;
    2. Il *passo* viene determinato in funzione del numero dei denti della ruota;
    3. L'*angolo d'elica* $psi_W$ (o di passo $lambda$) si ricava di conseguenza in funzione del diametro $d_w$ scelto.

#v(0.5em)


  *Riconduzione al paradigma della dentatura diritta* \
  Anche nel caso dell'accoppiamento tra vite senza fine (caratterizzata dall'angolo di avvolgimento del filetto) e ruota elicoidale, l'approccio progettuale mantiene come *paradigma di riferimento la dentatura diritta delle ruote cilindriche*, alla quale si riconducono i calcoli di verifica e dimensionamento mediante opportune trasformazioni e correzioni geometriche specifiche per l'ingranamento vite-ruota.


#v(1.2em)

== Generalità e classificazione delle trasmissioni mediante ingranaggi

Gli *alberi di trasmissione* consentono di trasferire potenza e moto rotatorio mediante l'applicazione di una coppia e di una velocità angolare. Quando è necessario trasmettere il moto tra alberi diversi (con assi *paralleli*, *incidenti* oppure *sghembi*) garantendo un preciso rapporto di trasmissione, si ricorre agli *ingranaggi*, ovvero dispositivi accessori costituiti da coppie di ruote dentate coniugate che ingranano tra loro.

=== Peculiarità degli ingranaggi rispetto alle trasmissioni flessibili

La trasmissione di potenza e coppia mediante ruote dentate presenta vantaggi strutturali e cinematici fondamentali rispetto ad altri sistemi di collegamento, come le trasmissioni flessibili *cinghia-puleggia*:

#grid(
  columns: (1fr, 1fr),
  gutter: 1.2em,
  [
    *Precisione e costanza dell'interasse* \
    Viene garantito il mantenimento di una misura precisa e costante dell'interasse tra gli alberi, condizione non assicurata nelle trasmissioni a cinghia a causa dell'*elasticità della cinghia* stessa e dell'*inflessione degli alberi* sotto carico.
  ],
  [
    *Coppie e potenze molto elevate* \
    Il sistema è in grado di trasmettere carichi gravosi grazie all'*elevata rigidezza e resistenza* meccanica del materiale metallico costituente il corpo della ruota.
  ],
  [
    *Precisione cinematica e costanza di $tau$* \
    La lavorazione di precisione delle superfici laterali (*fianchi*) dei denti assicura un'elevata regolarità nel trasferimento del moto e la *costanza nel tempo del rapporto di trasmissione* $tau$.
  ],
  [
    *Regimi di rotazione e varianti speciali* \
    Consentono di operare a *velocità di rotazione elevate*. Inoltre, oltre al tradizionale contatto meccanico tra i fianchi, per applicazioni particolari l'accoppiamento può essere realizzato _senza contatto_ tramite forze magnetiche permanenti (*ingranaggi magnetici*).
  ]
)

#v(1em)

=== Classificazione geometrica in base alla disposizione degli assi

La geometria delle ruote dentate viene classificata in primo luogo in funzione della posizione reciproca nello spazio degli assi degli alberi da connettere:

/ Alberi ad assi paralleli: si impiegano *ruote a corpo cilindrico* con *denti diritti* oppure con *denti elicoidali*. Rientrano in questa categoria due configurazioni particolari: il *sistema rocchetto-dentiera*, caso limite di accoppiamento ad assi paralleli in cui una ruota cilindrica ingrana con un elemento rettilineo dentato (*dentiera*, corrispondente a una ruota di _raggio infinito_), e i *rotismi epicicloidali* (o *planetari*), impiegati quando è necessario mantenere il medesimo verso di rotazione o realizzare elevati rapporti di riduzione tra due alberi *coassiali allineati*.

/ Alberi ad assi incidenti: si impiegano *ruote coniche* (o più propriamente *troncoconiche*, poiché il corpo solido della ruota occupa fisicamente un tronco di cono), con assi tipicamente disposti a $90^circ$, largamente utilizzate ad esempio nei *meccanismi differenziali*.

/ Alberi ad assi sghembi: gli assi non sono paralleli e non si intersecano nello spazio, ma sono posti a una certa distanza minima (*interasse*) e ruotati tra loro, tipicamente di $90^circ$. Per realizzare la trasmissione si ricorre all'accoppiamento *vite senza fine - ruota elicoidale* oppure alle *ruote ipoidi*.

#v(1em)

== Determinazione dei carichi agenti sulle ruote dentate e sugli alberi

Per analizzare le azioni mutue scambiate tra gli elementi della trasmissione, si adotta la seguente convenzione di nomenclatura (valida anche permutando i pedici per indicare le reazioni uguali e contrarie):
/ Forza tra ruote ($F_(i j)$): forza che dalla ruota $i$ agisce sulla ruota $j$ (con $i, j = 1, 2, 3, dots.h$).
/ Forza albero-ruota ($F_(x j)$): forza che dall'albero $x$ (con $x = a, b, c, dots.h$) agisce sulla ruota $j$.

=== Ruote cilindriche a denti diritti

Nelle ruote cilindriche a denti diritti, l'azione di contatto nel punto di ingranamento si scompone in due componenti principali sul piano trasversale:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: horizon,
  [
    / Geometria e cinematica ($2$, $a$, $d_2$, $n_2$): la ruota $2$, di diametro primitivo $d_2$, è calettata sull'albero $a$ e ruota con regime di rotazione $n_2$.
    / Azione di ingranamento ($F_(32)$): forza trasmessa dalla ruota coniugata $3$ alla ruota $2$, scomposta nella *componente tangenziale* $F_(32)^t$ e nella *componente radiale* $F_(32)^r$.
    / Reazioni dell'albero ($F_(a 2)$, $T_(a 2)$): per garantire l'equilibrio statico e dinamico della ruota $2$, l'albero $a$ esercita sul mozzo una *coppia motrice* (o resistente) $T_(a 2)$ e una *forza di reazione* $F_(a 2)$, a sua volta articolata nelle componenti tangenziale $F_(a 2)^t$ e radiale $F_(a 2)^r$.
  ],
  align(center)[
#canvas(length: 1cm, {
  import draw: *

  // Assi di centro
  line((-3.40, 0.00), (2.85, 0.00), stroke: 0.6pt)
  line((0.00, -2.95), (0.00, 2.50), stroke: 0.6pt)

  // Circonferenza primitiva (tratto-punto)
  circle((0.00, 0.00), radius: 2.40, stroke: (dash: "dash-dotted", thickness: 0.8pt))

  // Linee tratteggiate di scomposizione delle forze
  line((0.00, 3.55), (2.96, 3.55), (2.96, 2.40), stroke: (dash: "dashed", thickness: 0.7pt))
  line((-2.96, 0.00), (-2.96, -1.15), (0.00, -1.15), stroke: (dash: "dashed", thickness: 0.7pt))

  // Forze nel punto di ingranamento superiore (0, 2.40)
  line((2.96, 3.55), (0.00, 2.40), stroke: 0.7pt, mark: (end: ">", fill: black, length: 0.22, width: 0.12))
  line((0.00, 3.55), (0.00, 2.40), stroke: 2.2pt, mark: (end: ">", fill: black, length: 0.28, width: 0.18))
  line((2.96, 2.40), (0.00, 2.40), stroke: 2.2pt, mark: (end: ">", fill: black, length: 0.28, width: 0.18))

  // Forze sull'albero nel centro (0, 0)
  line((-2.96, -1.15), (0.00, 0.00), stroke: 0.7pt, mark: (end: ">", fill: black, length: 0.22, width: 0.12))
  line((-2.96, 0.00), (0.00, 0.00), stroke: 2.2pt, mark: (end: ">", fill: black, length: 0.28, width: 0.18))
  line((0.00, -1.15), (0.00, 0.00), stroke: 2.2pt, mark: (end: ">", fill: black, length: 0.28, width: 0.18))

  // Arco verso di rotazione n_2 e arco coppia T_a2
  arc((0.00, 0.00), start: 126deg, stop: 160deg, radius: 2.90, anchor: "origin", stroke: 0.7pt, mark: (start: ">", fill: black, length: 0.20, width: 0.12))
  arc((0.00, 0.00), start: 24deg, stop: 68deg, radius: 1.40, anchor: "origin", stroke: 1.8pt, mark: (start: ">", fill: black, length: 0.26, width: 0.16))

  // Linee di estensione e quota diametro d_2
  line((1.70, 1.70), (4.05, -0.65), stroke: 0.6pt)
  line((-1.70, -1.70), (0.65, -4.05), stroke: 0.6pt)
  line((2.40, -1.90), (3.85, -0.45), stroke: 0.6pt, mark: (end: ">", fill: black, length: 0.20, width: 0.11))
  line((1.90, -2.40), (0.45, -3.85), stroke: 0.6pt, mark: (end: ">", fill: black, length: 0.20, width: 0.11))

  // Etichette
  content((-0.18, 3.15), text(size: 9pt)[$F_(32)^r$], anchor: "east")
  content((3.08, 3.55), text(size: 9pt)[$F_(32)$], anchor: "west")
  content((2.65, 2.02), text(size: 9pt)[$F_(32)^t$], anchor: "center")
  content((-2.45, 1.95), text(size: 9pt)[$n_2$], anchor: "east")
  content((0.92, 1.25), text(size: 9pt)[$T_(a 2)$], anchor: "west")
  content((0.20, 0.22), text(size: 9pt)[$a$], anchor: "south-west")
  content((-1.60, 0.35), text(size: 9pt)[$F_(a 2)^t$], anchor: "center")
  content((-3.05, -1.45), text(size: 9pt)[$F_(a 2)$], anchor: "center")
  content((0.15, -0.70), text(size: 9pt)[$F_(a 2)^r$], anchor: "west")
  content((2.42, -0.80), text(size: 9pt)[$2$], anchor: "west")
  content((2.15, -2.15), text(size: 9pt)[$d_2$], anchor: "center")
})
  ]
)

#v(0.5em)


  *Effetti strutturali e stato di sollecitazione sull'albero:* \
  Si apprezzano due componenti di forza: la *componente tangenziale* $F^t$ è percepita dall'albero come effetto di *torsione*, ma anche di *flessione* in un piano, mentre nel piano a questo ortogonale si sviluppa la *flessione* indotta dalla *forza radiale* $F^r$. In un caso generico si avrebbe *flessione deviata*; tuttavia, nel caso dell'*albero a sezione circolare*, i momenti di area trasversali lungo gli assi $x$ e $y$ sono uguali, pertanto in ogni piano diametrale la flessione si presenta *retta* e agisce secondo *direzioni principali di inerzia*.


#v(1em)

=== Ruote coniche

Le *ruote coniche* vengono adottate quando gli assi degli alberi sono *incidenti* (comunemente disposti a $90^circ$). Poiché le superfici primitive di riferimento possiedono una *geometria troncoconica* convergente nel punto di intersezione degli assi, la dentatura (realizzabile a *denti diritti* oppure a *denti elicoidali/spirali*) si scambia un'azione di contatto distribuita lungo la generatrice del tronco di cono. A causa dell'inclinazione di tale superficie rispetto all'asse di rotazione, oltre alle componenti tangenziali e radiali *si aggiunge un carico assiale sull'albero*, generando così uno stato di sollecitazione composto che include anche sforzo normale di trazione o compressione.
=== Ruote cilindriche a denti elicoidali e trasmissioni per assi sghembi

La presenza di una *componente assiale* di carico sull'albero si manifesta analogamente nelle dentature elicoidali di ruote cilindriche (impiegate per collegare alberi ad *assi paralleli*) e nell'ingranamento vite senza fine - ruota.

Nelle *ruote cilindriche a denti elicoidali*, i denti si sviluppano lungo la larghezza di fascia della ruota seguendo un tratto di elica, risultando quindi obliqui rispetto all'asse di rotazione $z$. Poiché il fianco del dente è inclinato, la risultante $W$ della forza normale scambiata per pressione nel contatto presenta un'inclinazione spaziale tridimensionale diversa rispetto al caso a denti diritti:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: horizon,
  [
    / Riferimento e geometria ($x$, $y$, $z$, $psi$): sul *cilindro primitivo* (coassiale all'asse longitudinale $z$ dell'albero), la generatrice dell'*elemento del dente* risulta inclinata dell'*angolo d'elica* $psi$ rispetto alla direzione assiale.
    / Forze di contatto ($W$, $W_t$, $W_r$, $W_a$): la forza risultante totale $W$ agente sul fianco si scompone lungo la terna cartesiana nella *componente tangenziale* $W_t$ (diretta lungo $x$), nella *componente radiale* $W_r$ (diretta lungo $y$) e nella *componente assiale* $W_a$ (diretta lungo $z$).
    / Angoli caratteristici ($phi_n$, $phi_t$, $psi$): l'orientamento spaziale del parallelepipedo delle forze è governato dall'angolo d'elica $psi$, dall'*angolo di pressione normale* $phi_n$ (misurato nel piano normale al dente) e dall'*angolo di pressione trasversale* $phi_t$ (misurato nel piano di rotazione $x$-$y$).
  ],
  align(center)[
// FASE 2 - COSTRUZIONE
#canvas(length: 1cm, {
  import draw: *

  // 1. RIEMPIMENTI GRIGI DEI DENTI ELICOIDALI
  // Ombreggiatura di base sotto i denti
  line((0.12, 1.25), (0.35, 1.48), (1.72, 2.25), (2.58, 1.52), (2.52, 1.12), (1.45, 0.50), (0.85, 0.68), (0.35, 1.02), close: true, fill: gray.transparentize(55%), stroke: none)

  // Dente 1 (superiore-sinistro)
  line((0.32, 1.28), (0.44, 1.52), (1.66, 2.28), (1.82, 2.24), (1.84, 2.04), (0.64, 1.24), (0.45, 1.22), close: true, fill: gray.transparentize(40%), stroke: none)
  // Dente 2 (centrale)
  line((0.78, 1.02), (0.92, 1.26), (2.14, 2.02), (2.28, 1.98), (2.30, 1.78), (1.10, 0.98), (0.92, 0.96), close: true, fill: gray.transparentize(40%), stroke: none)
  // Dente 3 (inferiore-destro)
  line((1.22, 0.68), (1.36, 0.92), (2.56, 1.68), (2.66, 1.62), (2.64, 1.44), (1.46, 0.64), (1.32, 0.62), close: true, fill: gray.transparentize(40%), stroke: none)

  // 2. CILINDRO PRIMITIVO E ASSI CARTESIANI
  // Cerchio anteriore (tratto-punto)
  circle((0.00, 0.00), radius: 1.68, stroke: (dash: "dash-dotted", thickness: 0.65pt))
  // Arco posteriore (tratto-punto)
  arc((0.93, 0.93), start: -45deg, stop: 48deg, radius: 1.68, anchor: "origin", stroke: (dash: "dash-dotted", thickness: 0.65pt))
  arc((0.93, 0.93), start: 82deg, stop: 135deg, radius: 1.68, anchor: "origin", stroke: (dash: "dash-dotted", thickness: 0.65pt))
  // Generatrici esterne del cilindro
  line((-1.19, 1.19), (-0.26, 2.12), stroke: (dash: "dash-dotted", thickness: 0.65pt))
  line((1.19, -1.19), (2.12, -0.26), stroke: (dash: "dash-dotted", thickness: 0.65pt))

  // Assi x, y, z al centro del cilindro
  line((-2.02, 0.00), (-0.22, 0.00), stroke: 0.65pt)
  line((-0.12, 0.00), (0.12, 0.00), stroke: 0.65pt)
  line((0.22, 0.00), (1.95, 0.00), stroke: 0.65pt)

  line((0.00, -1.98), (0.00, -0.22), stroke: 0.65pt)
  line((0.00, -0.12), (0.00, 0.12), stroke: 0.65pt)
  line((0.00, 0.22), (0.00, 1.42), stroke: 0.65pt)

  line((-0.08, -0.08), (-0.82, -0.82), stroke: 0.65pt)

  // 3. CONTORNI DEI DENTI ELICOIDALI
  // Dente 1: profilo frontale, cresta e fianco
  line((0.32, 1.28), (0.44, 1.52), (0.55, 1.48), (0.64, 1.24), (0.78, 1.02), stroke: 0.75pt)
  line((0.44, 1.52), (1.66, 2.28), (1.82, 2.24), (1.84, 2.04), stroke: 0.75pt)
  line((0.55, 1.48), (1.82, 2.24), stroke: 0.65pt)
  line((0.64, 1.24), (1.84, 2.04), stroke: 0.75pt)

  // Dente 2: profilo frontale, cresta e fianco
  line((0.78, 1.02), (0.92, 1.26), (1.02, 1.22), (1.10, 0.98), (1.22, 0.68), stroke: 0.75pt)
  line((0.92, 1.26), (2.14, 2.02), (2.28, 1.98), (2.30, 1.78), stroke: 0.75pt)
  line((1.02, 1.22), (2.28, 1.98), stroke: 0.65pt)
  line((1.10, 0.98), (2.30, 1.78), stroke: 0.75pt)

  // Dente 3: profilo frontale, cresta e fianco
  line((1.22, 0.68), (1.36, 0.92), (1.46, 0.86), (1.46, 0.64), (1.46, 0.45), stroke: 0.75pt)
  line((1.36, 0.92), (2.56, 1.68), (2.66, 1.62), (2.64, 1.44), stroke: 0.75pt)
  line((1.46, 0.86), (2.66, 1.62), stroke: 0.65pt)
  line((1.46, 0.64), (2.64, 1.44), stroke: 0.75pt)

  // 4. ELEMENTO DEL DENTE E ANGOLO D'ELICA SUL CILINDRO
  // Generatrice assiale passante per P (0.45, 1.62) a -135deg e linea dell'elemento del dente
  line((0.45, 1.62), (-0.45, 0.72), stroke: (dash: "dashed", thickness: 0.65pt))
  line((0.45, 1.62), (-0.82, 0.90), stroke: 0.65pt)
  line((0.45, 1.62), (1.15, 2.02), stroke: 0.65pt)
  line((-0.88, 1.02), (-0.70, 0.84), stroke: 0.6pt)

  // Frecce per l'angolo psi sull'elemento del dente
  arc((0.45, 1.62), start: 204deg, stop: 210deg, radius: 1.35, anchor: "origin", stroke: 0.6pt, mark: (start: ">", fill: black, length: 0.16, width: 0.09))
  arc((0.45, 1.62), start: 225deg, stop: 242deg, radius: 1.15, anchor: "origin", stroke: 0.6pt, mark: (start: ">", fill: black, length: 0.16, width: 0.09))

  // 5. PARALLELEPIPEDO DELLE FORZE
  // Spigoli continui (faccia anteriore, superiore e laterale destra)
  line((-4.85, 1.62), (-4.85, 3.10), (0.45, 3.10), stroke: 0.65pt)
  line((-4.85, 3.10), (-3.18, 4.77), (2.12, 4.77), (0.45, 3.10), stroke: 0.65pt)
  line((2.12, 4.77), (2.12, 3.29), stroke: 0.65pt)

  // Spigoli tratteggiati (nascosti)
  line((-3.18, 3.29), (-3.18, 4.77), stroke: (dash: "dashed", thickness: 0.65pt))
  line((-3.18, 3.29), (-4.85, 1.62), stroke: (dash: "dashed", thickness: 0.65pt))
  line((-3.18, 3.29), (2.12, 3.29), stroke: (dash: "dashed", thickness: 0.65pt))

  // Diagonali delle facce (tratti lunghi)
  line((-4.85, 3.10), (0.45, 1.62), stroke: (dash: "dashed", thickness: 0.65pt))
  line((-3.18, 3.29), (0.45, 1.62), stroke: (dash: "dashed", thickness: 0.65pt))

  // 6. VETTORI FORZA (spessi, convergenti in P = (0.45, 1.62))
  // W_t (tangenziale)
  line((-4.85, 1.62), (0.45, 1.62), stroke: 2.2pt, mark: (end: ">", fill: black, length: 0.26, width: 0.16))
  // W_r (radiale)
  line((0.45, 3.10), (0.45, 1.62), stroke: 2.2pt, mark: (end: ">", fill: black, length: 0.26, width: 0.16))
  // W_a (assiale)
  line((2.12, 3.29), (0.45, 1.62), stroke: 2.2pt, mark: (end: ">", fill: black, length: 0.26, width: 0.16))
  // W (risultante totale)
  line((-3.18, 4.77), (0.45, 1.62), stroke: 2.2pt, mark: (end: ">", fill: black, length: 0.28, width: 0.17))

  // 7. ARCHI DEGLI ANGOLI (phi_t, psi, phi_n) E FRECCE DI RICHIAMO
  // Angolo phi_t (centro P = (0.45, 1.62), r = 3.98, tra 164.4deg e 180deg)
  arc((0.45, 1.62), start: 164.4deg, stop: 168.5deg, radius: 3.98, anchor: "origin", stroke: 0.6pt, mark: (start: ">", fill: black, length: 0.18, width: 0.10))
  arc((0.45, 1.62), start: 174.5deg, stop: 180.0deg, radius: 3.98, anchor: "origin", stroke: 0.6pt, mark: (end: ">", fill: black, length: 0.18, width: 0.10))

  // Angolo psi (centro P = (0.45, 1.62), r = 2.50, tra 155.3deg e 180deg)
  arc((0.45, 1.62), start: 155.3deg, stop: 162.5deg, radius: 2.50, anchor: "origin", stroke: 0.6pt, mark: (start: ">", fill: black, length: 0.18, width: 0.10))
  arc((0.45, 1.62), start: 171.5deg, stop: 180.0deg, radius: 2.50, anchor: "origin", stroke: 0.6pt, mark: (end: ">", fill: black, length: 0.18, width: 0.10))

  // Angolo phi_n (centro P = (0.45, 1.62), r = 2.95, tra 139.0deg e 155.3deg)
  arc((0.45, 1.62), start: 139.0deg, stop: 144.2deg, radius: 2.95, anchor: "origin", stroke: 0.6pt, mark: (start: ">", fill: black, length: 0.18, width: 0.10))
  arc((0.45, 1.62), start: 150.2deg, stop: 155.3deg, radius: 2.95, anchor: "origin", stroke: 0.6pt, mark: (end: ">", fill: black, length: 0.18, width: 0.10))

  // Freccia di richiamo "Elemento del dente"
  line((-0.98, 1.45), (0.02, 1.45), stroke: 0.6pt, mark: (end: ">", fill: black, length: 0.18, width: 0.10))

  // Freccia di richiamo "Cilindro primitivo"
  line((2.08, -0.70), (1.76, -0.18), stroke: 0.6pt, mark: (end: ">", fill: black, length: 0.18, width: 0.10))

  // 8. ETICHETTE
  content((-2.02, 3.85), text(size: 7pt)[$W$], anchor: "south-west")
  content((-2.18, 2.75), text(size: 7pt)[$phi_n$], anchor: "center")
  content((-3.45, 1.98), text(size: 7pt)[$phi_t$], anchor: "center")
  content((-2.08, 1.88), text(size: 7pt)[$psi$], anchor: "center")
  content((-4.18, 1.35), text(size: 7pt)[$W_t$], anchor: "center")
  content((0.72, 2.52), text(size: 7pt)[$W_r$], anchor: "west")
  content((1.98, 2.40), text(size: 7pt)[$W_a$], anchor: "west")
  content((-1.05, 1.45), text(size: 7pt)[Elemento del dente], anchor: "east")
  content((-0.62, 1.02), text(size: 7pt)[$psi$], anchor: "center")
  content((0.20, 1.02), text(size: 7pt)[$y$], anchor: "west")
  content((2.02, 0.00), text(size: 7pt)[$x$], anchor: "west")
  content((-0.95, -0.95), text(size: 7pt)[$z$], anchor: "north-east")
  content((2.18, -0.88), text(size: 7pt)[Cilindro], anchor: "west")
  content((2.18, -1.22), text(size: 7pt)[primitivo], anchor: "west")
})
  ]
)

#v(0.5em)

#block[
  *Comportamento dinamico e vantaggi delle dentature elicoidali:* \
  La *componente di forza assiale* $W_a$ generata lungo l'asse dell'albero può essere sfruttata progettualmente anche per contrastare o controllare eventuali azioni assiali esterne. Inoltre, poiché le due ruote accoppiate presentano *eliche di verso opposto*, il contatto non avviene simultaneamente su tutta una retta generatrice, ma impegna *gradualmente* una porzione limitata del fianco del dente: ciò riduce sensibilmente la *rumorosità* e gli *urti d'ingranamento*, aumentando la regolarità e la precisione della trasmissione.
]

#v(1em)

Per quanto riguarda le trasmissioni tra *alberi ad assi sghembi* (tipicamente ortogonali tra loro), la generazione di spinte assiali e radiali combinate caratterizza due soluzioni costruttive principali:

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  align: horizon,
  [
    / Accoppiamento vite senza fine - ruota: uno dei due elementi ha la forma di una *vite cilindrica* dotata di un filetto elicoidale continuo (analogo a quello di un bullone) che ingrana con i denti della ruota coniugata. La rotazione della vite attorno al proprio asse produce un effetto di _avanzamento apparente_ continuo dei filetti che trascina in rotazione la ruota.
    
    / Ruote ipoidi: soluzione alternativa a geometria *toroidale/iperboloidica* con denti curvi. Esse consentono un ingranamento molto graduale e silenzioso, riducendo sensibilmente le dimensioni del pignone e l'*ingombro complessivo* della trasmissione, ma richiedono una modellazione matematica complessa che esula da questa trattazione.
  ],
  align(center)[
    #image("cb5ee1bc-b806-48b7-aed4-c871d2df87c7-03_372_626_790_993.jpg", width: 95%)
  ]
)

#v(1em)

=== Grandezze fondamentali per la verifica e il dimensionamento

In ognuno dei casi esaminati, lo scopo della verifica strutturale e del dimensionamento delle ruote e degli alberi è quello di valutare gli effetti globali della trasmissione in termini di tre grandezze fisiche fondamentali:

/ Trasmissione del moto ($tau = omega_("OUT") / omega_("IN")$): in ogni ingranamento esiste un preciso *rapporto di trasmissione* $tau$ tra le velocità angolari di uscita e di ingresso. La velocità angolare di ciascuna ruota è *inversamente correlata* alla sua dimensione radiale: se le due ruote hanno uguali dimensioni, ruotano alla medesima velocità angolare ($tau = 1$); se hanno dimensioni diverse, a parità di velocità periferica nella zona di contatto, la ruota di diametro minore (*pignone*), avendo una circonferenza più corta, compie più giri nell'unità di tempo rispetto alla ruota di diametro maggiore, consentendo così di *ridurre o moltiplicare* la velocità angolare tra i due alberi.

/ Trasmissione di coppia ($M = F_t D / 2$, ovvero $T = W_t D / 2$): a fronte della forza risultante $F$ (indicata con $W$ nelle figure del testo) applicata in ogni contatto, è la sola *componente tangenziale* $F_t$ (o $W_t$) che, moltiplicata per il *raggio primitivo* $R = D / 2$, fornisce la coppia torcente $M$ (o $T$) effettivamente trasmessa.

#block[
  *Significato fisico e cinematico delle circonferenze primitive:* \
  Le *circonferenze primitive* sono le due circonferenze ideali (non corrispondenti a bordi fisici massivi delle ruote) aventi centro nei rispettivi assi di rotazione $A$ e $B$ e passanti per il punto $P$, nel quale risultano tangenti tra loro. Esse consentono di schematizzare cinematicamente la trasmissione del moto tra i due corpi dentati come il *puro rotolamento senza strisciamento* di due cilindri lisci ideali a contatto nel punto $P$, aventi raggi pari ai *raggi primitivi* $R_A$ e $R_B$ (con diametro primitivo $D = 2 R$).
]

/ Trasmissione di potenza ($P = M omega = F_t v$, ovvero $H = T omega$): il prodotto della coppia $M$ (o $T$) per la velocità angolare $omega$, o equivalentemente il prodotto della forza tangenziale $F_t$ per la velocità tangenziale periferica $v$, esprime la *potenza meccanica* $P$ (indicata con $H$ nel testo) sviluppata dal sistema.

#v(1em)

== Cinematica dell'ingranamento e azione coniugata dei profili

Affinché la trasmissione del moto tra due ruote dentate avvenga correttamente, è indispensabile garantire la *continuità del contatto* durante l'intera rotazione relativa, evitando istanti di perdita di presa (stasi o _"blackout"_ nella trasmissione di potenza) e discontinuità cinematiche che produrrebbero urti e saltellamenti. Durante la rotazione, il punto di contatto scorre lungo il fianco dei denti in presa e non deve abbandonare una coppia di denti finché la coppia di denti successiva non sia già entrata in contatto.

Questa condizione si realizza se i fianchi dei denti (che non possono avere semplice forma rettilinea o a parallelepipedo) sono disegnati secondo *profili coniugati*. Due profili in rotazione relativa attorno ai rispettivi centri fissi $A$ e $B$ si dicono coniugati se soddisfano le seguenti proprietà geometriche e cinematiche:

/ Costanza del rapporto di trasmissione ($tau$): il rapporto tra le velocità angolari dei due corpi si mantiene rigorosamente costante nel tempo:
  $ tau = omega_B / omega_A = "cost" $
/ Tangenza geometrica in $C$: in ogni istante, nel punto geometrico di contatto $C$ le superfici dei due profili ammettono un *piano di tangenza comune*.
/ Direzione di scambio delle forze (Retta d'azione): trascurando l'attrito, la forza risultante dalla pressione di contatto che i due profili si scambiano agisce lungo la direzione *normale* (ortogonale) al piano di tangenza comune nel punto $C$, denominata *retta d'azione* (o *linea d'azione*).

#block[
  *Legge fondamentale dell'ingranamento:* \
  Comunque si sposti il punto di contatto $C$ lungo i profili durante la rotazione relativa dei due corpi, la *retta d'azione* interseca il segmento congiungente i centri di rotazione $A$ e $B$ (*linea dei centri* o *interasse*) sempre nel medesimo punto fisso $P$, detto *centro di istantanea rotazione relativo* (o *punto di contatto primitivo*).
]


== Progettazione di ingranaggi cilindrici a denti diritti
// [DA AUDIO]
Nelle ruote cilindriche a denti diritti la linea longitudinale di sviluppo del profilo del dente è parallela all'asse di rotazione della ruota e dell'albero. Questa configurazione è impiegata per velocità periferiche e potenze non eccessivamente elevate. Durante l'ingranamento, il contatto tra due denti affacciati avviene simultaneamente lungo un'intera retta di contatto parallela agli assi, poiché tutta la larghezza del fianco si interfaccia istantaneamente con il fianco coniugato.

Dal punto di vista progettuale, le ruote cilindriche a denti diritti costituiscono il paradigma di riferimento in letteratura: per tutte le altre geometrie (elicoidali, coniche, ecc.) è sempre possibile individuare un piano virtuale nel quale la dentatura appare equivalente a quella di una ruota cilindrica a denti diritti. Il proporzionamento statico e a fatica viene eseguito in tale piano virtuale, riportando successivamente i parametri geometrici e costruttivi (quali il numero di denti $z$, il passo della dentatura $p$ e il modulo $m$) alla geometria reale della ruota.
Il problema dell'analisi delle tensioni nel dente è tutt'altro che banale perché:

    1) La geometria del dente è solo apparentemente simile a quella di una trave (piuttosto tozza e a sezione variabile)
    2) Esiste un intaglio severo al piede del dente che intensifica le tensioni
    3) Il carico è applicato in punti diversi del profilo, in direzione a questo normale.

#v(1em)

// [DA AUDIO]
=== Produzione per generazione mediante utensile creatore
Le ruote dentate cilindriche vengono comunemente realizzate per asportazione di truciolo a partire da un corpo cilindrico grezzo pieno (privo di denti) mediante un utensile denominato *creatore* (in inglese *rack*). Il creatore ha la forma di una dentiera rettilinea dotata di profili taglienti coniugati a quelli dei denti da ottenere. L'utensile compie un moto di lavoro rettilineo alternativo di taglio lungo la direzione assiale della lunghezza del dente; contemporaneamente, il cilindro grezzo ruota e trasla gradualmente rispetto al creatore in modo da esporre porzioni successive della superficie laterale e tagliare in successione tutti i vani tra i denti.
#v(1em)

== L'interpretazione approssimativa della teoria della trave

Il più classico approccio che introduce il problema del calcolo a flessione dei denti delle ruote dentate, riportato da molti testi, è quello sviluppato da *W. Lewis* _(NB: rispetto al libro di testo, per una più intuitiva comprensione sono stati adattati alcuni simboli)_. In primissima battuta, Lewis schematizza il dente come una *trave a mensola incastrata* alla circonferenza di fondo della ruota, di lunghezza $l$, introducendo tre ipotesi cautelative fondamentali (*caso peggiore*):
1. il carico è applicato nel *punto di contatto più lontano* dalla radice del dente (in corrispondenza della testa);
2. la sollecitazione di flessione nel piano della figura è determinata unicamente dalla *componente tangenziale* $F_t$ della forza di spinta;
3. l'intero carico è sopportato da *una sola coppia di denti* in presa.

Secondo la teoria elementare della trave studiata in _Fondamenti di Meccanica Strutturale_ e il sistema di riferimento allora utilizzato, la *tensione normale massima* che si sviluppa per flessione del dente nella direzione del suo asse di simmetria frontale vale, nella sezione critica indicata con $a$:

$ sigma_(z z, max) = (M_x y_(max)) / I_(x x) = (F_t dot l dot t / 2) / I_(x x) quad arrow.r.double quad sigma_(z z, max) = (6 F_t dot l) / (b t^2) $

essendo il momento d'inerzia della sezione rettangolare di base pari a $I_(x x) = (b dot t^3) / 12$, con $b$ larghezza di fascia del dente e $t$ spessore della sezione di base.

#v(0.5em)

=== Individuazione della sezione critica mediante la parabola di uniforme resistenza

Compreso a grandi linee l'approccio, più nel dettaglio Lewis individua nell'*intersezione della retta d'azione con l'asse di simmetria* del dente il punto di riferimento per l'applicazione della forza tangenziale $F_t$. Successivamente, cerca la sezione trasversale del dente maggiormente caricata per definire la posizione critica denominata $a$ in figura, confrontando la reale geometria del dente con quella di una *trave di uniforme resistenza*, ovvero un solido in cui la sezione varia dall'incastro all'estremo libero in modo tale che in ogni sezione la tensione di flessione massima risulti costante.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: horizon,
  [
    / Scomposizione della forza ($F$, $F_t$, $F_r$): la forza normale risultante $F$, trasportata lungo la retta d'azione fino all'intersezione con l'asse di simmetria, si scompone nella componente tangenziale flettente $F_t$ e nella componente radiale di compressione $F_r$ (trascurata da Lewis).
    / Geometria della sezione critica ($a$, $t$, $l$, $x$, $r_f$): la parabola inscritta risulta tangente ai raccordi di piede del dente (di raggio $r_f$) nei punti indicati con $a$, individuando la sezione critica di spessore $t$ posta a distanza $l$ dal punto di applicazione del carico (con sottotangente geometrica $x$).
  ],
  align(center)[
#canvas(length: 1cm, {
  import draw: *

  // 1. RIEMPIMENTO DEL DENTE (poligono chiuso con contorno inferiore ondulato come nell'immagine)
  line(
    (-0.46, 4.27), (0.46, 4.27),
    (0.96, 3.68), (1.35, 2.98), (1.61, 2.20), (1.72, 1.40), (1.66, 0.54),
    (1.65, 0.28), (1.73, 0.00), (1.92, -0.26), (2.18, -0.44), (2.49, -0.52),
    (2.38, -0.88), (2.05, -1.16), (1.42, -1.35), (0.72, -1.38), (0.00, -1.30),
    (-0.68, -1.46), (-1.28, -1.42), (-1.92, -1.20), (-2.35, -0.88), (-2.49, -0.52),
    (-2.18, -0.44), (-1.92, -0.26), (-1.73, 0.00), (-1.65, 0.28), (-1.66, 0.54),
    (-1.72, 1.40), (-1.61, 2.20), (-1.35, 2.98), (-0.96, 3.68),
    close: true,
    fill: black.transparentize(82%),
    stroke: none
  )

  // 2. CONTORNO DEL DENTE (linea e archi di cerchio raccordati con continuità C1)
  // Cresta superiore
  line((-0.46, 4.27), (0.46, 4.27), stroke: 1.3pt)
  // Fianco destro e fianco sinistro
  arc((-2.48, 1.27), start: -10deg, stop: 45.5deg, radius: 4.20, anchor: "origin", stroke: 1.3pt)
  arc((2.48, 1.27), start: 134.5deg, stop: 190deg, radius: 4.20, anchor: "origin", stroke: 1.3pt)
  // Raccordo di piede destro e sinistro (r_f)
  arc((2.55, 0.38), start: 170deg, stop: 266deg, radius: 0.90, anchor: "origin", stroke: 1.3pt)
  arc((-2.55, 0.38), start: 274deg, stop: 370deg, radius: 0.90, anchor: "origin", stroke: 1.3pt)

  // 3. ASSE DI SIMMETRIA E CIRCONFERENZA PRIMITIVA
  line((0.00, -1.85), (0.00, 4.45), stroke: (dash: "dash-dotted", thickness: 0.7pt))
  arc((0.00, -8.34), start: 74.4deg, stop: 107.8deg, radius: 10.22, anchor: "origin", stroke: (dash: "dash-dotted", thickness: 0.7pt))

  // 4. LINEE DI COSTRUZIONE DEL TRIANGOLO DI LEWIS
  line((0.00, 4.00), (-1.95, -0.63), stroke: 0.6pt)
  line((0.00, 4.00), (1.95, -0.64), stroke: 0.6pt)
  line((1.68, 0.00), (0.00, -0.71), stroke: 0.6pt)

  // 5. RETTANGOLO TRATTEGGIATO E VETTORI DELLE FORZE
  line((0.00, 5.25), (3.12, 5.25), stroke: (dash: "dashed", thickness: 0.6pt))
  line((3.12, 5.25), (3.12, 4.00), stroke: (dash: "dashed", thickness: 0.6pt))
  line((0.00, 5.25), (0.00, 4.18), mark: (end: ">"), stroke: 1.6pt)
  line((3.12, 4.00), (0.18, 4.00), mark: (end: ">"), stroke: 1.6pt)
  line((3.12, 5.25), (0.16, 4.07), mark: (end: ">"), stroke: 1.6pt)

  // 6. QUOTE E LINEE DI RIFERIMENTO
  // Linee orizzontali di riferimento per le quote l e x
  line((-0.75, 0.00), (0.30, 0.00), stroke: 0.6pt)
  line((0.45, 0.00), (2.70, 0.00), stroke: 0.6pt)
  line((-0.75, -0.71), (-0.08, -0.71), stroke: 0.6pt)

  // Quota verticale l
  line((2.34, 2.25), (2.34, 4.00), mark: (end: ">"), stroke: 0.6pt)
  line((2.34, 1.75), (2.34, 0.00), mark: (end: ">"), stroke: 0.6pt)

  // Quota verticale x
  line((-0.60, 0.45), (-0.60, 0.00), mark: (end: ">"), stroke: 0.6pt)
  line((-0.60, -1.16), (-0.60, -0.71), mark: (end: ">"), stroke: 0.6pt)

  // Linee verticali di riferimento e frecce per la quota t
  line((-1.72, 0.00), (-1.72, -1.45), stroke: 0.6pt)
  line((1.68, 0.00), (1.68, -1.45), stroke: 0.6pt)
  line((0.32, -1.25), (-1.72, -1.25), mark: (end: ">"), stroke: 0.6pt)
  line((0.64, -1.25), (1.68, -1.25), mark: (end: ">"), stroke: 0.6pt)

  // Freccia del raggio di raccordo r_f
  line((-2.90, 0.72), (-1.84, -0.15), mark: (end: ">"), stroke: 0.6pt)

  // 7. PUNTI DI TANGENZA E DI APPLICAZIONE (cerchi verdi con bordo nero)
  circle((0.00, 4.00), radius: 0.17, fill: green.transparentize(25%), stroke: 0.8pt)
  circle((-1.62, 0.12), radius: 0.17, fill: green.transparentize(25%), stroke: 0.8pt)
  circle((1.68, 0.02), radius: 0.17, fill: green.transparentize(25%), stroke: 0.8pt)

  // 8. ETICHETTE (tutte dentro l'immagine -> ridotte con text(size: 7pt))
  content((-0.42, 4.95), text(size: 7pt)[$"F"_"r"$], anchor: "east")
  content((3.35, 5.25), text(size: 7pt)[$"F"$], anchor: "west")
  content((1.75, 3.55), text(size: 7pt)[$"F"_"t"$], anchor: "north")
  content((2.34, 2.00), text(size: 7pt)[$l$], anchor: "center")
  content((1.86, 0.22), text(size: 7pt)[$a$], anchor: "south")
  content((-2.95, 0.78), text(size: 7pt)[$r_f$], anchor: "east")
  content((-0.60, -0.35), text(size: 7pt)[$x$], anchor: "center")
  content((0.48, -1.25), text(size: 7pt)[$t$], anchor: "center")
})
  ]
)

#v(1em)

Adottando ora la notazione classica in cui l'asse longitudinale della mensola è indicato con $x$ (con origine nel vertice di applicazione del carico) e lo spessore trasversale corrente con $y$, il ragionamento analitico seguito da Lewis si articola nei seguenti passaggi:

1. *Andamento del momento flettente:* in una trave a mensola caricata all'estremità libera da una forza concentrata $F$, il momento flettente $M(x) = F dot x$ varia linearmente dall'estremo libero ($x = 0$) fino alla sezione d'incastro, dove raggiunge il valore massimo.
2. *Espressione della tensione massima:* in una generica sezione posta a distanza $x$ dal carico e avente spessore $y$, la tensione normale massima vale:
   $ sigma_(x x, max) = (6 dot F dot x) / (b dot y^2) $
3. *Condizione di uniforme resistenza (profilo parabolico):* affinché la tensione massima $sigma_(x x, max)$ si mantenga costante lungo tutta la trave (a parità di forza $F$ e larghezza di fascia $b$), lo spessore $y$ della sezione trasversale deve variare in modo quadratico rispetto a $x$, descrivendo una *parabola* con vertice nel punto di applicazione del carico:
   $ y^2 = (6 dot F) / (b dot sigma_(x x, max)) dot x quad "cioè" quad y^2 = k dot x $
4. *Tangenza nella sezione critica $a$-$a$:* inscrivendo tale parabola all'interno del dente, essa risulta tangente al profilo dei raccordi di piede proprio in corrispondenza della sezione più sollecitata $a$-$a$, dove la distanza tra la fibra esterna del dente e la parabola (ovvero il margine di materiale resistente) è minima (nulla).
5. *Calcolo della tensione in $a$-$a$:* nella sezione critica $a$-$a$, posta a distanza $x = l_0$ dal vertice del carico e avente spessore $y = h$, la tensione massima raggiunge il valore:
   $ sigma_(x x, max) = (6 dot F dot l_0) / (b dot h^2) $

#v(0.5em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: horizon,
  align(center)[
#canvas(length: 1cm, {
  import draw: *

  // 1. RIEMPIMENTI E CONTORNI DELLA PARETE E DELLA TRAVE
  // Parete verticale d'incastro a sinistra
  rect((-0.58, -2.12), (0.00, 1.58))

  // Trave orizzontale a mensola
  rect((-0., -0.76), (7.14, 0.00))

  // 2. CARICO DISTRIBUITO TRIANGOLARE
  // Profilo lineare superiore del carico
  line((0.00, 1.46), (7.00, 0.16), stroke: 0.9pt)

  // Segmenti verticali del carico distribuito
  line((0.40, 0.00), (0.40, 1.39), stroke: 0.8pt)
  line((0.85, 0.00), (0.85, 1.30), stroke: 0.8pt)
  line((1.30, 0.00), (1.30, 1.22), stroke: 0.8pt)
  line((1.75, 0.00), (1.75, 1.14), stroke: 0.8pt)
  line((2.20, 0.00), (2.20, 1.05), stroke: 0.8pt)
  line((2.65, 0.00), (2.65, 0.97), stroke: 0.8pt)
  line((3.10, 0.00), (3.10, 0.88), stroke: 0.8pt)
  line((3.55, 0.00), (3.55, 0.80), stroke: 0.8pt)
  line((4.00, 0.00), (4.00, 0.72), stroke: 0.8pt)
  line((4.45, 0.00), (4.45, 0.63), stroke: 0.8pt)
  line((4.90, 0.00), (4.90, 0.55), stroke: 0.8pt)
  line((5.35, 0.00), (5.35, 0.47), stroke: 0.8pt)
  line((5.80, 0.00), (5.80, 0.38), stroke: 0.8pt)

  // 3. VETTORI E ASSI
  // Forza concentrata blu all'estremità destra
  line((7.02, 1.90), (7.02, 0.12), mark: (end: ">"), stroke: (paint: blue, thickness: 2.4pt))

  // Freccia dell'ascissa x sotto la trave
  line((7.08, -1.22), (4.08, -1.22), mark: (end: ">"), stroke: 0.8pt)

  // 4. ETICHETTE (dentro l'immagine -> text(size: 7pt))
  content((5.24, -1.52), text(size: 7pt)[$x$], anchor: "north")
})
  ],
  align(center)[
#canvas(length: 1cm, {
  import draw: *

  // 1. ASSE DI SIMMETRIA E LINEE DI COSTRUZIONE DELLE FORZE
  // Asse orizzontale tratteggio-punto
  line((-0.95, 0.00), (4.65, 0.00), stroke: (dash: "dash-dotted", thickness: 0.6pt))

  // Rettangolo tratteggiato di scomposizione della forza P
  line((1.21, 0.00), (1.21, 3.20), stroke: (dash: "dashed", thickness: 0.6pt))
  line((1.21, 3.20), (3.00, 3.20), stroke: (dash: "dashed", thickness: 0.6pt))

  // Linea d'azione interna di P tra il punto di contatto e l'asse
  line((3.48, -0.86), (3.00, 0.00), stroke: 0.6pt)

  // 2. COMPONENTI GRIGIE F E S
  line((3.00, 0.00), (3.00, 3.18), mark: (end: ">"), stroke: (paint: gray, thickness: 2.0pt))
  line((3.00, 0.00), (1.23, 0.00), mark: (end: ">"), stroke: (paint: gray, thickness: 2.0pt))

  // 3. CONTORNO DEL DENTE E SEZIONE CRITICA a-a
  // Profilo sinistro del corpo ruota e raccordi di piede
  line((-0.66, 3.32), (-0.45, 1.62), stroke: 1.1pt)
  arc((-0.16, 1.72), start: 198deg, stop: 301deg, radius: 0.31, anchor: "origin", stroke: 1.1pt)
  line((-0.66, -3.32), (-0.45, -1.62), stroke: 1.1pt)
  arc((-0.16, -1.72), start: 59deg, stop: 162deg, radius: 0.31, anchor: "origin", stroke: 1.1pt)

  // Fianchi superiore e inferiore e cresta destra del dente
  arc((1.00, -3.13), start: 58.1deg, stop: 102.3deg, radius: 4.69, anchor: "origin", stroke: 1.1pt)
  arc((1.00, 3.13), start: -102.3deg, stop: -58.1deg, radius: 4.69, anchor: "origin", stroke: 1.1pt)
  arc((-3.50, 0.00), start: -7.0deg, stop: 7.0deg, radius: 7.03, anchor: "origin", stroke: 1.1pt)

  // Segmento verticale della sezione critica a-a
  line((0.00, -1.45), (0.00, 1.45), stroke: 1.0pt)

  // 4. PARABOLA DI UNIFORME RESISTENZA INSCRITTA (arco ellittico tratteggiato rosso)
  arc((0.00, 0.00), start: -90deg, stop: 90deg, radius: (3.00, 1.45), anchor: "origin", stroke: (paint: red, dash: "dashed", thickness: 1.5pt))

  // Punto di applicazione V sull'asse
  circle((3.00, 0.00), radius: 0.06, fill: black, stroke: none)

  // 5. VETTORI FORZA P (neri spessi)
  line((3.00, 0.00), (1.21, 3.20), mark: (end: ">"), stroke: 1.8pt)
  line((4.69, -3.03), (3.48, -0.86), mark: (end: ">"), stroke: 1.8pt)

  // 6. QUOTE LINEARI E ANGOLARI
  // Quota h = K_1 * m a sinistra
  line((-0.05, 1.45), (-1.95, 1.45), stroke: 0.5pt)
  line((-0.05, -1.45), (-1.95, -1.45), stroke: 0.5pt)
  line((-1.78, 0.25), (-1.78, 1.45), mark: (end: ">"), stroke: 0.6pt)
  line((-1.78, -0.25), (-1.78, -1.45), mark: (end: ">"), stroke: 0.6pt)

  // Freccia doppia dell'ordinata y
  line((0.48, -1.40), (0.48, 1.40), mark: (start: ">", end: ">"), stroke: 0.7pt)

  // Quota l_0 = K_2 * m e freccia dell'ascissa x in basso
  line((0.00, -1.45), (0.00, -2.55), stroke: 0.5pt)
  line((3.00, 0.00), (3.00, -3.15), stroke: 0.7pt)
  line((0.55, -2.42), (0.00, -2.42), mark: (end: ">"), stroke: 0.6pt)
  line((2.45, -2.42), (3.00, -2.42), mark: (end: ">"), stroke: 0.6pt)
  line((3.00, -3.12), (0.55, -3.12), mark: (end: ">"), stroke: 0.8pt)

  // Arco dell'angolo theta superiore
  arc((3.00, 0.00), start: 90deg, stop: 100deg, radius: 1.95, anchor: "origin", mark: (start: ">"), stroke: 0.6pt)
  arc((3.00, 0.00), start: 109deg, stop: 119.2deg, radius: 1.95, anchor: "origin", mark: (end: ">"), stroke: 0.6pt)

  // Riferimento verticale e arco dell'angolo theta inferiore
  line((3.48, -0.86), (3.48, -2.75), stroke: 0.5pt)
  arc((3.48, -0.86), start: -90deg, stop: -80deg, radius: 1.65, anchor: "origin", mark: (start: ">"), stroke: 0.6pt)
  arc((3.48, -0.86), start: -71deg, stop: -60.8deg, radius: 1.65, anchor: "origin", mark: (end: ">"), stroke: 0.6pt)

  // 7. ETICHETTE (tutte dentro l'immagine -> ridotte con text(size: 7pt))
  content((-0.08, 1.50), text(size: 7pt)[$bold(a)$], anchor: "south")
  content((-0.08, -1.40), text(size: 7pt)[$bold(a)$], anchor: "south")
  content((-1.78, 0.00), text(size: 7pt)[$h = K_1 dot m$], anchor: "center")
  content((0.55, 0.00), text(size: 7pt)[$bold(y)$], anchor: "west")
  content((1.55, 2.88), text(size: 7pt)[$P$], anchor: "west")
  content((3.15, 2.45), text(size: 7pt)[$F$], anchor: "west")
  content((1.55, 0.22), text(size: 7pt)[$S$], anchor: "south")
  content((2.48, 1.88), text(size: 7pt)[$theta$], anchor: "center")
  content((3.90, -2.42), text(size: 7pt)[$theta$], anchor: "center")
  content((4.62, -2.65), text(size: 7pt)[$P$], anchor: "west")
  content((1.50, -2.42), text(size: 7pt)[$l_0 = K_2 dot m$], anchor: "center")
  content((2.05, -3.02), text(size: 7pt)[$x$], anchor: "south")
})
  ]
)

#v(0.5em)

=== Parametrizzazione rispetto al modulo e fattore di forma di Lewis

6. Poiché le dimensioni lineari del dente sono direttamente proporzionali al modulo (ovvero $h = K_1 dot m$ e $l_0 = K_2 dot m$), esplicitando nella formula della tensione massima il *modulo normale* $m_n$ si ottiene:

$ sigma_(x x, max) = (6 dot F dot l_0) / (b dot h^2) = (6 dot F dot l_0 / m_n^2) / (b dot (h / m_n)^2) = F / (b dot m_n) dot y_(L w) = F / (b dot m_n dot Y) $

La tensione massima viene così correlata direttamente al modulo del dente $m_n$ e a un parametro adimensionale puramente geometrico (dipendente dal numero di denti $z$ e dall'angolo di pressione $alpha_n$), che Lewis indicò come *fattore di forma*. Nelle tabelle tecniche sono riportati sia il coefficiente $y_("Lewis")$ (indicato anche con $y_(L w)$) sia il suo reciproco $Y = 1 / y_(L w)$:

#v(0.5em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    #align(center)[
      #table(
        columns: 4,
        align: (left, left, left, left),
        [*Numero di denti*], [$bold(Y)$], [*Numero di denti*], [$bold(Y)$],
        [12], [0.245], [28], [0.353],
        [13], [0.261], [30], [0.359],
        [14], [0.277], [34], [0.371],
        [15], [0.290], [38], [0.384],
        [16], [0.296], [43], [0.397],
        [17], [0.303], [50], [0.409],
        [18], [0.309], [60], [0.422],
        [19], [0.314], [75], [0.435],
        [20], [0.322], [100], [0.447],
        [21], [0.328], [150], [0.460],
        [22], [0.331], [300], [0.472],
        [24], [0.337], [400], [0.480],
        [26], [0.346], [Dentiera], [0.485],
      )
    ]
  ],
  [
    #align(center)[
      #table(
        columns: 6,
        align: (left, left, left, left, left, left),
        table.cell(rowspan: 2)[*$z, z'$*], table.cell(colspan: 2, align: center)[$bold(alpha_n = 20^circle)$], table.cell(rowspan: 2)[*$z, z'$*], table.cell(colspan: 2, align: right)[$bold(alpha_n = 20^circle)$],
        [$bold(Y)$], [$bold(y_(L w))$], [$bold(Y)$], [$bold(y_(L w))$],
        [12], [0,245], [4,08], [28], [0,352], [2,84],
        [13], [0,261], [3,83], [30], [0,358], [2,79],
        [14], [0,276], [3,62], [34], [0,371], [2,70],
        [15], [0,289], [3,46], [38], [0,383], [2,61],
        [16], [0,295], [3,39], [43], [0,396], [2,53],
        [17], [0,302], [3,31], [50], [0,408], [2,45],
        [18], [0,308], [3,25], [60], [0,421], [2,38],
        [19], [0,314], [3,18], [75], [0,434], [2,30],
        [20], [0,32], [3,13], [100], [0,446], [2,24],
        [21], [0,327], [3,06], [150], [0,459], [2,18],
        [22], [0,33], [3,03], [300], [0,471], [2,12],
        [24], [0,336], [2,98], [$infinity$], [0,484], [2,07],
        [25], [0,346], [2,89], [], [], [],
      )
    ]
  ]
)

/ Numero di denti virtuale ($z'$): nelle *ruote cilindriche a denti elicoidali*, per entrare in tabella si utilizza il numero di denti equivalente (o virtuale) $z'$ valutato nella sezione normale all'elica, in luogo del numero di denti reale $z$.



#block[
  *Commento sulla formulazione semplificata della teoria della trave:* \
  Le varie assunzioni semplificative che stanno alla base dell'approccio di Lewis rendono questa stima della tensione nel dente del tutto *convenzionale* e per nulla realistica, specie se si considerano fenomeni cruciali trascurati dal modello elementare:
  - l'*effetto d'intaglio* (concentrazione delle tensioni) al raccordo di piede del dente;
  - i *sovraccarichi dinamici* interni ed esterni generati durante l'ingranamento;
  - la *geometria reale* e tridimensionale delle dentature (e la ripartizione del carico tra più coppie di denti) in tutte le tipologie di ruote utilizzate.
  Le moderne normative assumono pertanto la formula di Lewis come *tensione nominale convenzionale* di partenza, per poi apportare varie correzioni moltiplicative tramite coefficienti tabulati o diagrammati e avvicinarsi così alla situazione fisica reale.
]

#v(1em)

== Approccio normativo al calcolo delle ruote dentate

Le normative tecniche internazionali e nazionali — come l'*AGMA* (_American Gear Manufacturers Association_), l'*ISO* e l'*UNI* — prediligono un calcolo unificato di verifica e dimensionamento delle ruote dentate basato su due criteri di cedimento distinti _(unità di misura nel Sistema S.I., con lunghezze espresse in $"mm"$)_.

Confrontando le tensioni massime di lavoro con le rispettive resistenze a fatica del materiale, è possibile ricavare in fase di progetto valori compatibili del *modulo trasversale* $m_t$ (o normale $m$) e del *diametro primitivo del pignone* $d_1$:

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  [
    *1. Verifica a fatica per flessione al piede del dente* \
    Valuta il rischio di rottura a fatica alla radice del dente per flessione ripetuta:
    $ sigma_(max, "FATICA") = F_t K_0 K_v K_s K_H K_B 1 / (b m_t Y_J) $
    Tale tensione affaticante di lavoro viene confrontata con la *tensione ammissibile a fatica per flessione* del materiale:
    $ sigma_("amm,FATICA") = sigma_(F P) / S_F (Y_N) / (Y_theta Y_Z) $
  ],
  [
    *2. Verifica a usura da contatto superficiale (Pitting)* \
    A parità degli altri simboli, valuta il danneggiamento superficiale dei fianchi dovuto a *contatto hertziano ripetuto* (_pitting_):
    $ sigma_(max, "USURA") = Z_E sqrt(F_t K_0 K_v K_s K_H Z_R 1 / (b d_1 Z_I)) $
    Tale tensione hertziana viene confrontata con la *tensione ammissibile di contatto* del materiale:
    $ sigma_("amm,CONTATTO") = sigma_(H P) / S_H (Z_N Z_W) / (Y_theta Y_Z) $
  ]
)

== Descrizione dei coefficienti correttivi

I coefficienti introdotti nelle formulazioni normative consentono di affinare il modello teorico ideale tenendo conto delle reali condizioni operative, geometriche, metallurgiche e statistiche della trasmissione. Per una più chiara lettura fisica e progettuale, essi possono essere suddivisi in base alla loro funzione specifica.

=== Fattori correttivi della sollecitazione di lavoro e geometrici

/ Fattore di sovraccarico ($K_0$): considera l'esistenza di condizioni di *sovraccarico esterno* legate alla potenza trasmessa, picchi di coppia, condizioni limite di esercizio e fattori di servizio della macchina motrice e operatrice, oltre all'esigenza di tener conto dell'intero carico effettivamente trasmesso.
/ Fattore dinamico ($K_v$): tiene conto del fatto che l'effetto del carico sul dente varia in funzione della *velocità periferica*, dell'insorgere di *vibrazioni*, squilibri dinamici, errori di lavorazione o usura del profilo e fenomeni di attrito interno.
/ Fattore dimensionale ($K_s$): analogamente all'*effetto scala* nella verifica a fatica classica, valuta le dimensioni assolute del dente e dell'ingranaggio per considerare la maggiore probabilità statistica di trovare difettosità intrinseche nel materiale all'aumentare del volume sollecitato.
/ Fattore di distribuzione del carico ($K_H$): considera la *distribuzione reale (non uniforme) del carico* lungo la larghezza di fascia sul fianco del dente, tenendo conto anche della rigidezza degli alberi, dei disallineamenti e della posizione relativa della ruota rispetto ai supporti.
/ Fattore di spessore della corona ($K_B$): quantifica il *peggioramento dello stato di sollecitazione* a flessione nel caso in cui la ruota non sia massiccia ma presenti uno spessore radiale della corona (sotto il piede del dente) modesto rispetto alla dimensione del dente stesso.
/ Fattore geometrico per la flessione ($Y_J$): definito analiticamente come $Y / (K_f m)$, modifica il fattore di forma di Lewis $Y$ per tenere conto sia della *concentrazione delle tensioni* (effetto d'intaglio $K_f$) al raccordo di piede, sia dell'eventuale *ripartizione del carico* tra più coppie di denti simultaneamente in presa.

#v(0.5em)

=== Fattori legati al contatto hertziano e alla resistenza ammissibile

*Parametri della verifica a usura (Pitting)* \
    _(Nota: gli aspetti contrassegnati con $*$ sono oggetto di un ciclo di lezioni dedicato alla teoria del contatto)._
    
    / Coefficiente elastico ($Z_E$): introduce nelle formule i *moduli di elasticità* e i coefficienti di Poisson dei materiali del pignone e della ruota, secondo la teoria del contatto hertziano$*$.
    / Fattore di stato superficiale ($Z_R$): come già visto nella fatica classica, tiene conto della *rugosità*, dello stato di finitura superficiale del fianco e di eventuali tensioni residue.
    / Fattore geometrico di contatto ($Z_I$): esprime le *relazioni geometriche di curvatura* dei profili coniugati necessarie per determinare l'estensione dell'*impronta di contatto* secondo la teoria hertziana$*$.

*Fattori correttivi delle tensioni ammissibili* \
    
    / Fattori di durata ($Y_N$, $Z_N$): introducono due aspetti congiunti, ovvero la *durezza superficiale* del materiale associata al comportamento della resistenza a fatica (a flessione per $Y_N$, a _pitting_ per $Z_N$) variabile con il *numero di cicli* di carico (secondo le curve di Wöhler).
    / Fattore di rapporto di durezza ($Z_W$): per prevenire le conseguenze del maggior numero di cicli subiti da ogni dente del pignone, si tratta termicamente il *pignone affinché sia più duro della ruota*; tale coefficiente corregge l'effetto del divario di durezza ed elasticità superficiale dei materiali a contatto.
    / Fattore di temperatura ($Y_theta$): benché si supponga che il lubrificante non superi di norma i $120^circle"C"$, in casi di moderato scambio termico tiene conto del degrado delle proprietà meccaniche dovuto all'*effetto della temperatura*.
    / Fattore di affidabilità ($Y_Z$): tiene conto della *dispersione statistica* delle rotture a fatica del materiale e associa uno specifico *livello di affidabilità* probabilistica al calcolo.


#v(0.5em)
_Per i dettagli operativi sulla determinazione numerica dei singoli coefficienti si rimanda al libro di testo nonché all'attività di Relazione tecnica._

#v(1em)

== Schema di progettazione di una coppia di ingranaggi

#block[
  *Dati di ingresso (Specifiche di progetto):* \
  Dalle specifiche progettuali sono noti: la *potenza* $P$ e la *velocità angolare* $omega_1$ imposte al pignone, il *rapporto di trasmissione* $tau$ che si deve assicurare alla ruota condotta, l'*interasse* di riferimento e una *scelta preliminare dei materiali* (da cui dipendono le tensioni ammissibili $sigma_(F P)$ e $sigma_(H P)$).
]

#v(0.5em)

Il flusso logico-iterativo per il dimensionamento e la verifica della coppia di ruote dentate si articola nelle seguenti fasi sequenziali:

*1. Dimensionamento cinematico di massima e calcolo delle forze* \
A partire dall'albero di trasmissione — a sua volta preliminarmente dimensionato a torsione — si fissa un *diametro primitivo indicativo del pignone* $d_1$, sufficientemente più ampio rispetto al diametro dell'albero stesso per consentire il calettamento o la lavorazione integrale. Noto il rapporto di trasmissione $tau$, resta preliminarmente definito anche il *diametro primitivo della ruota* $d_2$, verificando immediatamente la compatibilità geometrica della coppia con l'*interasse da specifica*. Dalle grandezze cinematiche e dinamiche note (potenza $P$ e velocità angolare $omega_1$) si ricava quindi la coppia motrice $M_1 = P / omega_1$ e, dividendo per il raggio primitivo $d_1 / 2$, si determinano le *azioni scambiate sul dente* (a partire dalla forza tangenziale $F_t$).

*2. Scelta del numero di denti e modulo di primo tentativo* \
Consultando i diagrammi disponibili in letteratura per un dato *angolo di pressione* (noto a progetto, tipicamente $alpha = 20^circle$), si individua il *numero di denti minimo* $z_1$ del pignone (ad esempio per evitare il fenomeno dell'interferenza al piede). Dal rapporto tra il diametro primitivo preliminare $d_1$ e il numero di denti $z_1$ si determina quindi un *valore di primo tentativo del modulo* $m = d_1 / z_1$ (da ricondurre ai valori unificati da normativa).

*3. Dimensionamento iterativo a flessione e verifica finale a Pitting* \
Si imposta la disuguaglianza di sicurezza tra la *tensione massima di fatica a flessione* e la *tensione ammissibile a flessione* ($sigma_(max, "FATICA") <= sigma_("amm,FATICA")$). Inserendo il valore di primo tentativo del modulo $m$ e vincolando la *larghezza di fascia* $b$ in modo che il rapporto caratteristico $b / m$ resti compreso nell'intervallo ottimale:
$ 9 <= b / m <= 14 $
si procede per *successive iterazioni* assestando i valori di $b$ e $m$ fino al pieno soddisfacimento della disuguaglianza _(ricordando che, ad ogni tentativo di modifica del modulo $m$, varia proporzionalmente anche l'altezza complessiva del dente, data dalla somma di addendum e dedendum)_. 

Consolidati infine i parametri geometrici definitivi della dentatura — larghezza di fascia $b$, modulo $m$, numero di denti $z$ e diametro primitivo $d_p$ (o $D$) — si procede alla necessaria *verifica ad usura superficiale (pitting)* controllando che risulti soddisfatta anche la condizione $sigma_(max, "USURA") <= sigma_("amm,CONTATTO")$.
#pagebreak()