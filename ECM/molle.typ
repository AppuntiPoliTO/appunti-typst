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

= Molle - Generalità e Barra di Torsione
== Funzioni e Applicazioni delle Molle
Le molle sono elementi di macchine caratterizzati da un'elevata capacità di deformarsi elasticamente sotto l'azione di un carico e di riassumere la loro conformazione originaria al cessare dell'applicazione del carico stesso. Questa caratteristica fondamentale permette il collegamento tra le parti di un sistema garantendo una sospensione elastica e adattativa. 

Affinché la molla possa svolgere correttamente il proprio ruolo, è imperativo che operi esclusivamente in campo elastico: le tensioni applicate non devono mai generare condizioni di plasticizzazione, le quali comprometterebbero la funzionalità del componente e la sua capacità di ritornare all'estensione iniziale in modo ripetitivo.

Le molle sono in grado di immagazzinare energia sotto forma di energia potenziale elastica, per poi restituirla. Grazie a queste proprietà, esse trovano svariati campi di applicazione:
- #strong[Sospensioni automobilistiche e motociclistiche:] conferiscono rigidezza al sistema, filtrano le vibrazioni e contengono gli scuotimenti e i movimenti di rollio del veicolo, garantendo comfort e stabilità.
- #strong[Macchine industriali:] isolano le parti sospese dagli impulsi provenienti dal terreno o da effetti sismici.
- #strong[Attuatori e sistemi di automazione:] contengono lo spostamento degli elementi o forniscono una forza di richiamo elastico (es. ritorno di un pistone).
- #strong[Trasduttori e strumenti di misura:] nei dinamometri, l'estensione della molla sotto l'azione di una forza permette di misurare l'intensità della forza stessa, sfruttando le caratteristiche note dell'elemento elastico.

== Caratteristica della Molla ed Energia Immagazzinata
Il comportamento di una molla è descritto dalla sua curva caratteristica, che rappresenta la relazione tra l'azione applicata (forza o momento) e la deformazione prodotta (spostamento o rotazione). 

Nella maggior parte delle applicazioni industriali si ricerca un comportamento lineare. In questo caso, il parametro fondamentale è la costante elastica o rigidezza $k$, che definisce il fattore di proporzionalità della relazione:
- Per una molla di traslazione: $F = k dot.op f$
- Per una molla di rotazione: $M = k dot.op theta$

dove $F$ e $M$ sono rispettivamente la forza in Newton e il momento in Newton-metro; $f$ e $theta$ sono lo spostamento (o freccia) in metri e la rotazione in radianti; $k$ è la rigidezza, espressa in N/m o Nm/rad.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[L'energia complessiva immagazzinata dalla molla corrisponde all'area sottesa alla curva caratteristica. Nel caso di una caratteristica lineare, tale area è un triangolo, pertanto l'energia potenziale elastica $W$ vale:

$ W = frac(F f, 2) $ A seconda della legge di variazione della rigidezza, la caratteristica può deviare dal comportamento lineare, presentando due tipologie di non linearità:],[
#image("grafico molla 1.png", width:90%)
])


- #strong[Softening:] all'aumentare della forza applicata, la rigidezza della molla diminuisce. La molla diventa più cedevole e, a parità di forza, si ottiene una deformazione maggiore rispetto al caso lineare.
- #strong[Hardening:] all'aumentare della forza, la rigidezza aumenta. Il sistema subisce un irrigidimento progressivo nei confronti delle azioni applicate.

== Il Paradigma della Barra di Torsione
#grid(
  columns: (1.2fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[La forma di molla più vicina alla teoria classica della trave, utilizzata come paradigma per lo studio strutturale di molle più complesse (come quelle ad elica cilindrica), è la barra di torsione. Essa è costituita da un cilindro solido (una trave a sezione circolare) incastrato a un'estremità e libero all'altra. All'estremità libera è tipicamente collegato un braccio rigido (piattello o leva) a cui viene applicata una forza $F$. Il comportamento della barra è dominato dal momento torcente $M_t = F dot.op r$, dove $r$ è il braccio rigido. La tensione tangenziale massima $tau_(m a x)$ si calcola dividendo il momento torcente per il modulo di resistenza a torsione $w_t$:],[
#image("barra di torsione.png",width:90%)
])
$ tau_(m a x) = frac(M_t, w_t) = frac(F r, pi d^3 / 16) $

L'angolo di torsione $theta$ subito dalla sezione libera rispetto all'incastro si ottiene integrando la deformazione lungo la lunghezza $l$ della barra, in funzione del modulo di elasticità tangenziale $G$ e del momento d'inerzia polare $I_p$:

$ theta = frac(M_t l, G I_p) = frac(F r l, G pi d^4 / 32) $

Lo spostamento verticale (freccia $f$) del punto di applicazione della forza $F$ è dato dall'arco di circonferenza descritto dal braccio $r$ che ruota di un angolo $theta$:

$ f = theta r = frac(32 F r^2 l, pi d^4 G) $

Dalla relazione lineare tra forza e freccia, si ricava la rigidezza $k$ della barra di torsione:

$ k = frac(F, f) = frac(pi G d^4, 32 r^2 l) $

Si ricorda che il modulo di elasticità tangenziale $G$ è legato al modulo di Young $E$ e al coefficiente di Poisson $nu$ dalla relazione:

$ G = frac(E, 2(1+nu)) $

== Dettagli Costruttivi e Applicazioni della Barra di Torsione
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Nella realizzazione pratica di una barra di torsione, le estremità destinate al vincolo richiedono particolari accorgimenti. Il collegamento viene spesso realizzato tramite un profilo scanalato. Questa soluzione permette di trasmettere efficacemente il momento torcente e le reazioni vincolari, consentendo al contempo un minimo grado di libertà in direzione assiale per compensare eventuali elongazioni termiche o disturbi assiali.],[
#image("dettaglio barra di torsione.png", width:75%)
])

Nel passaggio dal diametro maggiore della porzione scanalata al diametro minore della parte centrale attiva della barra, è fondamentale inserire un ampio raggio di raccordo. Questo dettaglio costruttivo è necessario per mitigare l'effetto di concentrazione delle tensioni (intaglio) causato dalla variazione di sezione. Esistono anche soluzioni alternative per le estremità, come teste a profilo esagonale o poligonale, che offrono facce di riscontro adeguate per la trasmissione del momento pur consentendo lievi adattamenti assiali.

Un'applicazione classica della barra di torsione è la barra stabilizzatrice (o barra anti-rollio) nelle sospensioni automobilistiche. Durante la percorrenza di una curva, il veicolo è soggetto a forze inerziali centrifughe che causano un trasferimento di carico e una diversa aderenza tra le ruote interne ed esterne alla curva, innescando il fenomeno del rollio.

La barra di torsione viene montata trasversalmente per collegare i due bracci della sospensione. Quando le ruote subiscono spostamenti verticali asimmetrici (una si comprime, l'altra si estende), la barra subisce una torsione. La rigidezza torsionale della barra si oppone a questa differenza di escursione, moderando lo sbilanciamento dei carichi, riducendo l'angolo di rollio e migliorando sensibilmente la stabilità e la sicurezza del veicolo in curva, fungendo anche da elemento di smorzamento per eventuali vibrazioni innescate dalla manovra.
 = Molle ad elica cilindrica
== Geometria e comportamento meccanico
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Le molle a elica cilindrica sono assimilabili a delle barre di torsione avvolte a elica attorno a un cilindro ideale. La geometria macroscopica della molla è determinata dal diametro del cilindro, indicato con $D = 2r$, dove $r$ rappresenta la distanza tra l'asse del cilindro (su cui si intende applicata la forza risultante) e il centro della sezione trasversale del filo. Il filo stesso, di sezione circolare, è caratterizzato da un diametro $d$. L'inclinazione dell'elica è misurata dall'angolo $alpha$, e la molla a riposo, scarica da azioni esterne, possiede una lunghezza libera indicata con $L_0$.],[
#image("schema molla elica cilindrica.png", width:50%)
])

A seconda della direzione del carico applicato lungo l'asse, macroscopicamente le molle vengono definite in modo improprio di trazione o di compressione, poiché permettono a un elemento ad esse collegato di compiere uno spostamento traslatorio. Tuttavia, il comportamento meccanico del materiale è diverso: la deformazione effettiva della molla è in gran parte dovuta alla torsione del filo avvolto a elica. Pertanto, l'elemento agisce a tutti gli effetti come un'estensione del paradigma della barra di torsione diritta. 

== Sollecitazioni agenti sul filo
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Applicando una forza assiale $F$ lungo l'asse centrale dell'elica, questa si pone a una distanza $r$ dal centro della sezione resistente del filo. Analizzando le reazioni interne in funzione dell'angolo caratteristico $alpha$, emergono quattro componenti:
- Un'azione normale: $N = F sin(alpha)$
- Un momento flettente: $M_f = F sin(alpha) dot.op r$
- Un'azione di taglio: $T = F cos(alpha)$
- Un momento torcente: $M_t = F cos(alpha) dot.op r$

Dato che l'angolo $alpha$ è tipicamente piccolo, si può approssimare $cos(alpha) tilde.eq 1$ e $sin(alpha) tilde.eq 0$. Di conseguenza, le componenti normale $N$ e flettente $M_f$ risultano pressoché nulle ($N tilde.eq 0$, $M_f tilde.eq 0$). Le uniche caratteristiche di sollecitazione dominanti che agiscono sulla sezione trasversale del filo sono il taglio e, soprattutto, il momento torcente:
$ T tilde.eq F $
$ M_t tilde.eq F dot.op r $],[#rect(width: 100%, inset: 8pt, stroke: 0.5pt + red)[*DA INSERIRE – IMMAGINE*: diagramma tridimensionale di una spira isolata tagliata trasversalmente. Mostra il raggio $r$, l'angolo $alpha$, la forza assiale $F$, e le reazioni nella sezione del filo: $N$, $T$, $M_f$ e $M_t$, con le rispettive componenti trigonometriche proiettate sugli assi locale e tangenziale.]])

Ai fini della progettazione geometrica, si definisce una lunghezza equivalente del filo $l_(e q)$, pari allo sviluppo della circonferenza moltiplicato per il numero di spire efficaci $i$, al netto dell'inclinazione:
$ l_(e q) = frac(2 pi r, cos(alpha)) i tilde.eq pi D i $

Viene inoltre definito un rapporto caratteristico della molla, indicato con $c$, che mette in relazione il diametro dell'elica con il diametro del filo:
$ c = frac(D, d) $
Il valore di $c$ viene normalmente mantenuto in un intervallo ottimale compreso tra $7$ e $12$. Se $c < 7$, la dimensione dell'elica è paragonabile a quella del filo, rendendo la molla molto rigida e altamente sollecitata; se $c > 12$, l'anello risulta molto ampio rispetto a un filo sottile, rendendo la molla molto flessibile, ma questa configurazione è poco utilizzata.

== Calcolo delle tensioni e Coefficiente di Wahl
Per determinare lo stato tensionale, si parte dalla teoria di De Saint-Venant per le barre di torsione diritte, dove la tensione tangenziale massima vale $tau = frac(M_t, W_t) = frac(16 F r, pi d^3)$. Tuttavia, la curvatura dell'elica altera la distribuzione delle tensioni: l'asse neutro della sezione non coincide più con la linea d'asse geometrica dell'elemento, ma si sposta verso l'interno del raggio di curvatura. Questo spostamento genera una distribuzione di tensioni non più lineare, provocando un sensibile incremento della sollecitazione verso le fibre interne del filo. 

Per tener conto sia di questo marcato effetto di curvatura, sia della presenza dell'azione tagliante aggiuntiva, si applica un fattore correttivo introdotto da Wahl. La formula corretta per la tensione tangenziale massima diventa:
$ tau_(m a x) = lambda frac(8 F D, pi d^3) = lambda frac(8 F c, pi d^2) $

Il coefficiente complessivo $lambda$ è la somma di due contributi: $lambda = lambda' + lambda''$. Il termine $lambda'$ modella l'effetto della curvatura e si esprime in funzione del rapporto caratteristico $c$:
$ lambda' = frac(4 c - 1, 4 c - 4) $
Il termine $lambda''$ tiene invece conto delle tensioni dovute al taglio:
$ lambda'' = frac(0.615, c) $

Disaggregando i due effetti sulla tensione, si ottiene:
- Tensione dovuta all'effetto curvatura: $tau_(m a x, t o r s) = frac(4 c - 1, 4 c - 4) frac(16 F r, pi d^3)$
- Tensione dovuta al taglio: $tau_(m a x, t a g l i o) = 1.23 frac(F, pi d^2 / 4) = frac(0.615, c) frac(16 F r, pi d^3)$

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[È essenziale distinguere l'effetto della curvatura dall'effetto di intaglio. Sebbene in entrambi i casi si assista a un incremento locale del gradiente di tensione con un picco massimo localizzato all'estremità della sezione, la curvatura modifica l'intera distribuzione a causa dello spostamento dell'asse neutro, estendendo l'area di picco su una porzione di superficie percentualmente molto ampia e dominante. Al contrario, l'effetto di intaglio altera la distribuzione in maniera severa ma in una zona estremamente localizzata e sottile. Di conseguenza, l'intensificazione dovuta alla curvatura è molto gravosa e va sempre introdotta nel calcolo delle molle.],[#rect(width: 100%, inset: 8pt, stroke: 0.5pt + red)[*DA INSERIRE – IMMAGINE*: confronto grafico tra l'effetto curvatura e l'effetto intaglio. A sinistra, la sezione trasversale di una molla soggetta a flessione/torsione mostra una distribuzione di tensione non lineare, con l'asse neutro spostato e un'ampia zona di picco ($Delta l_1$) sulla fibra interna. A destra, una trave rettilinea con un intaglio locale mostra una deviazione drastica ma estremamente concentrata della tensione ($K_t$) solo in prossimità della variazione di sezione.]])

== Spire efficaci, deformazione e rigidezza
La rigidezza $k$ della molla, ovvero il rapporto tra la forza applicata $F$ e lo spostamento o freccia $f$, si valuta analizzando la sola porzione di filo effettivamente libera di torcersi. Le estremità della molla sono infatti vincolate in base al tipo di appoggio e non contribuiscono alla deformabilità globale del sistema. Le spire in grado di immagazzinare energia elastica prendono il nome di spire efficaci ($i$). 

La freccia $f$ si ricava correggendo la formula canonica della rotazione della barra di torsione ($f = theta r = frac(32 F r^2 l_(e q), pi d^4 G)$) mediante il parametro $lambda''$:
$ f = lambda'' frac(8 F c^3 i, G d) = frac(F, k) $
Per l'intervallo geometrico ottimale $c = 7 div 12$, si approssima $lambda'' = 1$. Noto il modulo di elasticità trasversale $G$ e la rigidezza desiderata $k$, il numero di spire efficaci necessarie si calcola come:
$ i = frac(G d, 8 c^3 k) $

== Geometria delle estremità e lunghezze
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Il numero di spire efficaci $i$ differisce dal numero di spire totali $n$ a causa della geometria delle estremità (i terminali). Esistono quattro tipi principali di estremità, che alterano il vincolo e modificano la lunghezza a riposo ($L_0$) e la lunghezza completamente compressa ("a pacco", $L_b$):

1. #strong[Semplice:] Estremità lasciate libere, senza riduzioni di sezione. L'intera molla si deforma elasticamente, quindi $n = i$. 
  $ L_0 = i dot.op p + d $
  $ L_b = (i + 1) d $
2. #strong[Semplice e molata:] Le estremità sono lavorate per appiattirle, irrigidendo l'ultimo tratto. Risulta $n = i + 1$.
  $ L_0 = p(i + 1) $
  $ L_b = d(i + 1) $
3. #strong[Troncata:] Il filo viene ripiegato affinché le estremità vadano in battuta. Il forte irrigidimento blocca un'intera spira per lato, da cui $n = i + 2$.
  $ L_0 = i dot.op p + 3 d $
  $ L_b = (i + 3) d $
4. #strong[Troncata e molata:] Il filo viene sia piegato che appiattito all'estremità per creare una superficie di appoggio piana perfetta. Anche qui $n = i + 2$.
  $ L_0 = i dot.op p + 2 d $
  $ L_b = (i + 2) d $],[#rect(width: 100%, inset: 8pt, stroke: 0.5pt + red)[*DA INSERIRE – IMMAGINE*: illustrazione affiancata delle quattro configurazioni di estremità della molla. (1) Semplice, (2) Semplice e molata, (3) Troncata, (4) Troncata e molata. L'immagine evidenzia visivamente come la spira terminale viene appiattita e/o piegata per formare la base d'appoggio.]])

== Gioco residuo e condizione di fine corsa
L'azione elastica della molla deve essere garantita nell'intero intervallo di forze di progetto, da $F_(m i n)$ a $F_(m a x)$. È imperativo evitare che sotto il carico massimo $F_(m a x)$ la molla raggiunga la configurazione "a pacco" ($L_b$), condizione in cui le spire entrano in contatto fisico l'una con l'altra. Quando ciò accade, la molla cessa di funzionare per torsione elastica e diventa un blocco solido che trasmette gli sforzi per semplice compressione di contatto, perdendo le sue capacità elastiche e di ammortizzazione.

Per scongiurare il bloccaggio a pacco, in fase di progetto si impone che la lunghezza residua sotto carico massimo ($L_(F_(m a x))$) sia strettamente maggiore della lunghezza a pacco $L_b$, garantendo una distanza minima di sicurezza tra spira e spira. Questa distanza è il gioco residuo per singola spira, stimabile proporzionalmente al diametro del filo:
$ g_(r e s) tilde.eq frac(d, 4) $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[La disuguaglianza fondamentale per la progettazione del contorno risulta quindi:
$ L_(F_(m a x)) gt.eq L_b + g_(r e s) dot.op i $],[#rect(width: 100%, inset: 8pt, stroke: 0.5pt + red)[*DA INSERIRE – IMMAGINE*: schema comparativo della molla a fine corsa. A sinistra, la molla compressa con un gioco garantito in cui le spire sono separate e deformate elasticamente. A destra, la molla completamente "a pacco" in cui i fili sono a contatto solido reciproco e formano un blocco compatto.]])

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Il dimensionamento complessivo può essere riassunto in un diagramma a colonne in cui le altezze scalano progressivamente. Partendo dalla lunghezza libera $L_0$, l'applicazione di $F_(m i n)$ porta la molla alla lunghezza $L_(F_(m i n))$. Caricando ulteriormente fino a $F_(m a x)$, si scende a $L_(F_(m a x))$. Al di sotto di tale quota rimane lo spazio limite non oltrepassabile, pari alla lunghezza solida $L_b$ sommata al franco complessivo $i dot.op g_(r e s)$. Fissando a priori la freccia massima desiderata e il limite dimensionale $L_(F_(m a x))$, il calcolo fissa in cascata la lunghezza libera $L_0$ e, di conseguenza, il passo dell'elica.],[#rect(width: 100%, inset: 8pt, stroke: 0.5pt + red)[*DA INSERIRE – IMMAGINE*: diagramma a blocchi delle lunghezze caratteristiche della molla. Una colonna alta indica $L_0$. Accanto, una più bassa indica $L_(F_(m i n))$ sotto l'azione della forza $F_(m i n)$. Segue $L_(F_(m a x))$ con la forza $F_(m a x)$. Sull'ultimo blocco si vede la scomposizione della lunghezza minima consentita in due porzioni: il compattamento $L_b$ e il gioco totale $i dot.op g_(r e s)$ al di sopra di esso.]]) 
