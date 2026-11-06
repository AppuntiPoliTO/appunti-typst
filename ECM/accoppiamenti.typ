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
= *Accoppiamenti*
=== Introduzione ai collegamenti mozzo-albero
La naturale estensione dell'analisi dei collegamenti albero-mozzo prevede lo studio di geometrie di forzamento diverse da quella puramente cilindrica, oppure l'impiego di corpi aggiuntivi interposti tra le parti. I collegamenti possono essere suddivisi in tre macro-categorie principali:
- #strong[Collegamenti ad attrito:] la trasmissione del momento torcente è affidata all'attrito generato da una pressione di contatto. Vi rientrano l'accoppiamento conico, il serraggio tramite bulloni e l'utilizzo di chiavette.
- #strong[Collegamenti di forma] la trasmissione avviene per ostacolo cinematico (interferenza geometrica) nel movimento relativo tra albero e mozzo. Vi rientrano le linguette, i profili scanalati e le spine.
- #strong[Calettatori industriali:] dispositivi specifici che permettono un calettamento automatico e standardizzato.

== Collegamenti per accoppiamento conico
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[In questa configurazione, la geometria troncoconica del codolo dell'albero (la parte terminale) permette di calibrare la pressione di forzamento in base alla forza di trazione assiale esercitata durante l'inserimento nel mozzo.È necessario adottare una conicità sufficientemente elevata da permettere l'accoppiamento, ma non eccessiva, per evitare che costituisca un ostacolo al bloccaggio. Il corpo si impegna lungo una superficie troncoconica caratterizzata da un diametro minore $d_1$ e un diametro maggiore $d_2$. Si definisce un diametro medio $D_m$ e un angolo caratteristico di conicità $alpha$:
$ D_m = frac(d_1 + d_2, 2) $
$ tan alpha = frac(d_1 - d_2, 2 L) $
dove $L$ è la lunghezza dell'accoppiamento nella direzione assiale.],[
#image("accoppiamento conico.png",width:80%)]
)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[La determinazione della pressione di contatto $p$ in funzione della forza assiale $F_a$ impressa al sistema si fonda sull'equilibrio vettoriale. In direzione normale alla superficie agisce una forza di forzamento $F_N$, data dal prodotto tra la pressione e l'area della superficie laterale troncoconica:
$ F_N = p dot.op A_l = p pi D_m L $
L'azione di pressione genera una forza di attrito in direzione tangenziale (lungo la generatrice del cono). La forza totale risultante $F$ è legata alla forza normale tramite l'angolo di attrito $phi$, dove il coefficiente di attrito $f$ è pari a $tan phi$:
$ F = frac(F_N, cos phi) $
],[
#image("forze mozzo.png")
])

Questa forza totale $F$ può essere scomposta in un sistema di riferimento globale solidale all'asse dell'albero, ottenendo una componente radiale $F_r$ e una componente assiale $F_a$. Le due componenti derivano dalla proiezione tramite l'angolo totale $(alpha + phi)$, che somma l'inclinazione geometrica e l'effetto dell'attrito:
$ F_a = F sin(alpha + phi) $
$ F_r = F cos(alpha + phi) $
Sostituendo $F_N$ all'interno delle equazioni, si ottiene la relazione esatta che lega la pressione alla forza assiale:
$ p = frac(F_a cos phi, pi D_m L sin(alpha + phi)) $
Per angoli piccoli, è possibile approssimare la formula assumendo che la differenza tra seno e tangente sia trascurabile, ottenendo un'espressione di uso pratico nella manualistica:
$ p tilde.eq frac(F_a, pi D_m L tan(alpha + phi)) $

Il momento torcente $M_t$ trasmissibile è proporzionale alla superficie laterale, alla pressione, al coefficiente di attrito e al braccio, che mediamente corrisponde al raggio medio $D_m/2$. Si dimostra che il momento trasmesso è equivalente a quello di un accoppiamento cilindrico di diametro $D_m$:
$ M_t = (pi dot.op D_m dot.op L) dot.op mu dot.op p dot.op frac(D_m, 2) $
Affinché il collegamento sia sicuro, la pressione esercitata non deve superare la pressione ammissibile $p_("amm")$ dei materiali a contatto (es. 50÷90 MPa per acciaio su acciaio, 30÷50 MPa per ghisa grigia su acciaio). Pertanto, il momento massimo trasmissibile è:
$ M_t lt.eq (pi dot.op D_m dot.op L) dot.op mu dot.op p_("amm") dot.op frac(D_m, 2) $

== Collegamenti per serraggio con bulloni


#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[#strong[Mozzo realizzato in due metà (Semigusci)] \ Un'alternativa al forzamento diretto consiste nell'utilizzare elementi filettati (viti o bulloni) per generare la pressione di contatto necessaria. Questa soluzione è ampiamente utilizzata per la sua facilità di smontaggio, fondamentale per le operazioni di manutenzione. Un esempio classico è il collegamento della testa di biella nei motori a combustione interna. Il mozzo è diviso in due semigusci che vengono serrati attorno all'albero tramite bulloni.],[#image("accoppiamento semigusci.png", width:50%)])

Supponendo una distribuzione uniforme della pressione, il momento torcente trasmissibile corrisponde all'integrale delle forze di attrito tangenziali lungo la circonferenza dell'interfaccia:
$ M_t = integral_0^(2 pi) d T dot.op r = 2 pi dot.op r^2 dot.op L dot.op f dot.op p arrow.double p = frac(pi dot.op D_c^2 dot.op L dot.op f dot.op p, 2) $
La pressione di contatto è generata dalla forza totale di serraggio $F_("tot viti")$ esercitata dall'insieme dei bulloni. La relazione tra la forza dei bulloni e la pressione è:
$ F_("tot viti") = p dot.op D_c dot.op L gt.eq frac(2 dot.op M_t, pi dot.op D_c dot.op f) $
Per garantire la trasmissione senza superare i limiti del materiale, il momento deve rispettare la condizione:
$ M_t lt.eq 2 pi dot.op r^2 dot.op L dot.op f dot.op p_("amm") $
La forza totale di serraggio necessaria per raggiungere la pressione ammissibile è quindi:
$ F = F_("tot viti") = p_("amm") dot.op D_c dot.op L $
La forza specifica da applicare al singolo bullone si otterrà dividendo $F_("tot viti")$ per il numero di elementi di collegamento presenti.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[#strong[Mozzo con fessura diametrale]\ 
Per elementi semplici e non soggetti a dinamiche inerziali gravose, si utilizza un mozzo dotato di una fessura diametrale, che lo rende simile a un morsetto elastico. Le due estremità flessibili vengono avvicinate tramite una o più viti. L'equilibrio del sistema si valuta calcolando i momenti rispetto all'apice della fessura. Il momento generato dalla forza totale delle viti $F_("tot viti")$ con braccio $a$ deve equilibrare il momento generato dalla forza di reazione $F$ (dovuta alla pressione sull'albero) con braccio $b$: $ F_("tot viti") dot.op a = F dot.op b $ La forza $F$ genera una pressione tra mozzo e albero pari a:
$ p = frac(F, D_c dot.op L) $],[
#image("mozzo fessura diametrale.png")
])




Sostituendo l'equilibrio dei momenti, occorre verificare che la pressione generata non superi quella ammissibile:
$ p = frac(F_("tot viti") dot.op a, D_c dot.op b dot.op L) lt.eq p_("amm") $
Calibrando la forza di serraggio delle viti, si garantisce una pressione sufficiente per la trasmissione del momento torcente, mantenendosi entro i limiti di resistenza.

=== Chiavette
Le chiavette prevedono l'interposizione di un terzo corpo tra l'albero e il mozzo per generare un forzamento in direzione radiale. Vengono ricavate delle sedi (cave) in entrambi i corpi. La chiavetta lavora esclusivamente sulle superfici superiore e inferiore (esercitando pressione radiale) e non interagisce con i fianchi del mozzo. Le chiavette presentano una leggera pendenza longitudinale (tipicamente 1:100) che permette di forzarle in sede. Esistono diverse geometrie standardizzate: a sezione rettangolare, con estremità arrotondate (per mitigare l'effetto di intaglio), con nasello (per facilitare l'inserimento a battuta e l'estrazione) o tangenziali (che agiscono in direzione circonferenziale per trasmettere momenti maggiori). 
I principali vantaggi di questo collegamento sono l'economicità, la facilità di montaggio in officina e la capacità di bloccare assialmente il mozzo. Tuttavia, presentano gravi difetti:
- Le cave indeboliscono significativamente l'albero, introducendo un severo effetto di intaglio che intensifica le tensioni locali.
- L'inserimento di una massa eccentrica rispetto all'asse di rotazione sposta il baricentro del sistema. Questo introduce forti squilibri dinamici che si traducono in forze centrifughe periodiche, reazioni anomale sui supporti, vibrazioni e orbite di rotazione che possono eccitare le velocità critiche del rotore, portando il sistema in risonanza.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Per questi motivi, l'uso delle chiavette è oggi limitato ad applicazioni particolari, con basse velocità di rotazione e momenti torcenti modesti (tali da generare tensioni tangenziali $tau$ nell'albero di circa 20÷30 MPa). La determinazione analitica del momento trasmissibile è complessa. A causa del forzamento radiale introdotto da un corpo discreto, la pressione non è assialsimmetrica. Si verifica un effetto di bordo laterale con incrementi locali di pressione alle estremità della chiavetta, mentre la parte opposta dell'albero viene spinta contro il mozzo. Sotto l'azione del momento torcente, la chiavetta tende a ruotare nella sua sede, modificando ulteriormente la distribuzione del carico.
],[#image("distribuzione chiavette.png")])
Poiché non si conosce a priori la distribuzione esatta delle forze di attrito, ci si affida a formule empiriche fornite dalla letteratura tecnica e confermate da analisi FEM. Il momento trasmissibile è dato da:
$ M_T tilde.eq 0.04 dot.op (2.28 dot.op d + h) dot.op b dot.op L dot.op p_("amm") $
dove $d$ è il diametro dell'albero, $h$ e $b$ sono le dimensioni unificate della chiavetta e $L$ è la sua lunghezza.
=== Linguette
A differenza delle chiavette, le linguette lavorano esclusivamente sui fianchi. Esse interpongono un ostacolo cinematico che impedisce la rotazione relativa tra albero e mozzo, rendendoli solidali nella trasmissione della coppia, ma lasciando libero lo spostamento assiale del mozzo (collegamenti scorrevoli).
Le linguette sono unificate in base al diametro dell'albero, che stabilisce le dimensioni trasversali $b times h$. La lunghezza $L$ viene invece calibrata dal progettista in base alle esigenze di trasmissione. Anche le cave per linguette indeboliscono l'albero producendo un effetto di intaglio. In questo caso specifico, i coefficienti di intaglio a fatica $K_f$ non vengono calcolati tramite la sensibilità all'intaglio, ma sono direttamente suggeriti dalla letteratura: $K_f = 1.6 div 2$ per la flessione e $K_f = 1.3 div 1.6$ per la torsione.
Le linguette a disco (o a mezzaluna) permettono un leggero basculamento per adattarsi alla sede, ma richiedono una cava molto profonda nell'albero. Questo genera un effetto di intaglio estremamente severo, motivo per cui vengono utilizzate solo per trasmettere piccole potenze su alberi abbondantemente sovradimensionati.
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Il dimensionamento della linguetta consiste nel calcolo della lunghezza utile $L$. La forza $F$ trasmessa sulla superficie laterale (il fianco) è data dal momento torcente diviso per il raggio dell'albero:
$ F = frac(2 dot.op M_T, d) $
La pressione si esercita sulle superfici di contatto laterali di altezza $t_1$ (nell'albero) e $t_2$ (nel mozzo). Generalmente, la sede nell'albero è più profonda per garantire un buon alloggiamento, rendendo $t_2 < t_1$. Poiché la forza $F$ è la medesima, la pressione risulta massima e critica sulla superficie più piccola, ovvero sul fianco del mozzo di altezza $t_2$.],[
#image("calcolo dimensionamento linguetta.png")
])
La pressione sui fianchi è pari a:
$ p = frac(F, t_2 dot.op L) $
Il calcolo della lunghezza viene svolto imponendo che tale pressione non superi la pressione ammissibile $p_("amm")$ dei materiali a contatto (es. 45÷65 MPa per acciaio-ghisa, 75÷115 MPa per acciaio-acciaio):
$ p = frac(2 dot.op M_T, t_2 dot.op L dot.op d) lt.eq p_("amm") $
Da cui si ricava la lunghezza minima necessaria per evitare lo schiacciamento dei fianchi:
$ L gt.eq frac(2 dot.op M_T, d dot.op t_2 dot.op p_("amm")) $

== Profili Scanalati: Caratteristiche e Produzione
#grid(
  columns: (1.7fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Un'alternativa all'impiego delle tradizionali chiavette o linguette consiste nel realizzare i risalti per il collegamento di forma direttamente sulla superficie laterale dell'albero. Questa soluzione, distribuendo gli elementi di accoppiamento sull'intera superficie laterale, mitiga l'effetto di squilibrio dinamico che caratterizza le linguette singole, migliorando sensibilmente il comportamento in rotazione del sistema. Dal punto di vista produttivo, la geometria dello scanalato viene realizzata tramite lavorazioni meccaniche che asportano materiale creando sedi e risalti che permettono l'accoppiamento tra albero e mozzo. Sebbene la forma possa ricordare quella delle ruote dentate, il principio di funzionamento è opposto: non vi è una rotazione relativa imposta dalla trasmissione del moto tra due profili coniugati, bensì i due corpi vengono resi mutuamente solidali per ruotare congiuntamente. I profili scanalati presentano caratteristiche geometriche ben definite: un diametro interno $d$, un diametro esterno massimo $D$ corrispondente al risalto, e una larghezza del risalto $b$. I risalti presentano inoltre dettagli costruttivi essenziali come le gole di scarico alla base e degli smussi nella parte alta per facilitare l'inserimento tra le parti.],[ #image("centraggio.png")])


=== Classificazione e Tipi di Centraggio
Gli accoppiamenti scanalati si classificano in base al tipo di centraggio che si realizza tra albero e mozzo. Dal momento che queste geometrie costituiscono degli elementi di intaglio, generano un'intensificazione locale delle tensioni riconducibile a un fattore di forma a fatica $K_f$ compreso tra $2.5$ e $3.5$ (particolarmente per superfici cementate e temprate). Il parametro geometrico $lambda$ che concorre alla classificazione è definito come:
$ lambda = frac((D - d) dot.op z, 2 dot.op d) $

I due principali tipi di centraggio sono:
1. #strong[Centraggio interno:] È il sistema più preciso. Lo scanalato si inserisce nella sede prodotta nel mozzo e il posizionamento relativo è dettato dal contatto tra il diametro interno dell'albero e il diametro interno del mozzo. 
2. #strong[Centraggio sui fianchi:] In questo caso, le superfici cilindriche interne ed esterne non sono necessariamente a contatto. Il posizionamento e la trasmissione del carico dipendono unicamente dalla battuta tra i fianchi dei risalti.
  

La superficie di contatto utile $S$ di un singolo risalto è proporzionale alla lunghezza assiale dell'accoppiamento $L$ e all'altezza efficace del risalto stesso, al netto degli smussi $c$ presenti sia sul profilo dell'albero che del mozzo:
$ S = L dot.op (h - 2 dot.op c) quad "con" quad h = frac(D - d, 2) $
Questa definizione permette di quantificare l'area resistente una volta definita la geometria normata dello scanalato.

=== Calcolo del Momento Trasmissibile
A causa di errori tecnologici e inevitabili deformazioni elastiche locali, le forze dovute al momento torcente non si ripartiscono in modo perfettamente uniforme su tutti gli $z$ risalti. Per tenere conto di questo fenomeno, si introduce un coefficiente di utilizzazione $Phi < 1$. 

Assumendo una pressione uniforme $p$ sulle facce degli $z$ risalti, la forza tangenziale totale è data dalla pressione sull'area utile. Il momento trasmesso $M_t$ si ottiene moltiplicando questa forza per il braccio, pari al raggio medio $d_m/2$:
$ M_t = z dot.op P_("amm") dot.op Phi dot.op S dot.op frac(d_m, 2) quad "con" quad d_m = frac(D + d, 2) $

Parallelamente, il momento torcente massimo ammissibile che il corpo dell'albero può sopportare (considerando la teoria della trave e la riduzione per fatica legata a $K_f$) è proporzionale al modulo di resistenza a torsione:
$ M_(T "albero") = frac(pi dot.op d^3, 16) dot.op tau_("amm") $

Eguagliando le due espressioni, si ottiene la relazione di equilibrio tra la funzionalità geometrica e la resistenza del materiale:
$ z dot.op P_("amm") dot.op Phi dot.op S dot.op frac(d_m, 2) = frac(pi dot.op d^3, 16) dot.op tau_("amm") $
Da questa si ricava una relazione geometrica in funzione del rapporto $L/d$:
$ frac(L, d) = frac("funzione della geometria", k) quad "con" quad k = frac(p_("amm"), tau_("amm")) = 0.2 div 1.25 $
Il coefficiente $k$ risulta basso per gli accoppiamenti scorrevoli sotto carico e alto per gli accoppiamenti fissi sotto carico o scorrevoli non sotto carico.

Nella pratica ingegneristica, l'accoppiamento viene spesso dimensionato sfruttando apposite tabelle fornite dalla normativa o dai costruttori. Queste tabelle forniscono un "momento trasmissibile per unità di lunghezza" ($M T'$ espresso in $N m m \/ m m$). Il confronto tra il momento di progetto $M_T$ e il valore tabulato $M T'$ restituisce la lunghezza minima richiesta per l'accoppiamento. La logica impone che lo scanalato debba sempre poter lavorare su tutta la superficie disponibile, onde evitare concentrazioni anomale di pressione se vi fossero scorrimenti assiali. Le lunghezze minime sono modulate dal rischio di scorrimento:
- #strong[Accoppiamenti fissi:] Nessun rischio di scorrimento. Si adotta $L = frac(M_T, M T')$ con il vincolo geometrico $L > d$.
- #strong[Accoppiamenti scorrevoli non sotto carico:] Vi è un leggero rischio di scorrimento per azioni di disturbo. Si sovradimensiona la lunghezza introducendo un fattore al denominatore: $L = frac(M_T, 0.85 dot.op M T')$ con il vincolo $L > 1.5 dot.op d$.
- #strong[Accoppiamenti scorrevoli sotto carico:] L'accoppiamento è esplicitamente sollecitato a scorrere sotto l'azione dei carichi. La lunghezza viene maggiorata notevolmente moltiplicando di fatto per quattro: $L = frac(M_T, 0.25 dot.op M T')$ con il vincolo stringente $L gt.eq 3 dot.op d$.

=== Profili Scanalati ad Evolvente e a Trapezio
Oltre ai classici profili a denti diritti, esistono geometrie alternative con profili sagomati che mitigano l'effetto di intaglio. In questi casi, il fattore $K_f$ scende a valori compresi tra $1.5$ e $2$, comparabili a quelli delle sedi per chiavette.
1. #strong[Innesti dentati CUNA (NC 008-01):] Presentano un profilo ad evolvente di cerchio, estremamente simile a quello delle ruote dentate. La formula per il dimensionamento della lunghezza caratteristica $l$ è:
$ l = frac(2 dot.op M_T, 0.75 dot.op h dot.op d dot.op z dot.op p_("amm")) $
Dove $z$ è il numero di denti, $h$ è l'altezza radiale della zona di contatto e $p_("amm") = 75 div 115$ MPa.

2. #strong[Innesti con profilo a trapezio:] L'espressione di calcolo assume una forma leggermente diversa nel coefficiente al denominatore:
$ l = frac(2 dot.op M_T, 0.5 dot.op h dot.op d dot.op z dot.op p_("amm")) $
Con $p_("amm") = 75 div 115$ MPa.

=== Collegamenti Tramite Spine
#grid(
  columns: (1.5fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Le spine costituiscono una tipologia di collegamento estremamente semplice ed economica. Consistono in un corpo cilindrico inserito in un foro passante che attraversa diametralmente sia il mozzo che l'albero. Svolgono la funzione di ostacolo meccanico, rendendo solidali le due parti in rotazione. Oltre alla pura trasmissione del moto in sistemi a bassa dinamica (es. bracci meccanici o attrezzature manuali), le spine sono largamente impiegate come #emph[elementi fusibili di protezione]. Il loro dimensionamento è calibrato affinché, in presenza di un momento torcente anomalo ed eccessivo, la spina si tranci di netto. Questa rottura programmata disconnette l'utenza dall'albero motore, salvaguardando i componenti più costosi dell'impianto. Il sistema deve tuttavia essere impiegato in contesti protetti, in quanto la rottura può provocare la proiezione radiale di frammenti metallici.],[#image("spine.png",width:70%)])




Il principio meccanico si basa sull'equilibrio a taglio. La forza scambiata tra le superfici di interfaccia crea un momento torcente pari al taglio $T$ moltiplicato per il braccio (il diametro esterno dell'albero $D$):
$ M_T = T dot.op D $
La spina essendo passante, è sollecitata su due sezioni resistenti, ma considerando la tensione tangenziale media $tau = T/A$, si ha:
$ tau = frac(T, A) = frac(M_T, D) dot.op frac(4, pi dot.op d^2) $
Da cui il momento massimo trasmissibile, o momento di tranciatura, risulta proporzionale al diametro $d$ della spina, al diametro $D$ dell'albero e alla tensione ammissibile a taglio del materiale della spina:
$ M_(T, m a x) = tau_("amm") dot.op frac(pi dot.op d^2 dot.op D, 4) $

=== Calettatori Commerciali e Industriali
Qualora sia necessario accoppiare un albero e un mozzo cilindrici senza eseguire lavorazioni interne di cave o scanalature, si ricorre ai calettatori commerciali ad attrito. Questi dispositivi interposti si deformano o si posizionano in modo da generare una forte pressione radiale tra le parti, rendendole solidali.

#grid(
  columns: (1.5fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[#strong[1. Sistema a dischi a stella (Ringspann)]
Costituito da elementi a forma di molla elastica troncoconica cedevole, sagomata con un profilo a greca sulla circonferenza. Applicando una forza assiale, il disco si inflette e tende ad appiattirsi; diminuendo il diametro interno e aumentando quello esterno, si produce un'azione di impuntamento (forzamento radiale) contro l'albero e il mozzo. L'effetto si moltiplica impacchettando in serie più dischi (fino a un massimo di 16).],[
#image("Ringspann.png", width:50%)
])

#grid(
  columns: (1.5fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[#strong[2. Anelli compensatori (Star)]
Anelli ondulati per stampaggio realizzati in nastro di acciaio temprato per molle, visivamente simili alla forma di un "blister" per medicinali svuotato. Inserendo questo anello in una cava di forzamento tra albero e mozzo, le bugne in rilievo subiscono uno schiacciamento radiale. La rigidezza strutturale dei rilievi genera la pressione di contatto per attrito necessaria alla trasmissione.],[
#image("star.png", width:50%)
])

#grid(
  columns: (1.3fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[#strong[3. Accoppiamento con anelli conici]
Si basa su una serie di anelli dalla superficie troncoconica divisi in due metà (superiore e inferiore). Un coperchio flangiato esterno, serrato tramite bulloni lungo l'asse, spinge questi elementi sul loro piano inclinato. L'avanzamento assiale si converte in spinta radiale e pressione di forzamento. Il vantaggio risiede nel perfetto controllo del precarico applicando una chiave dinamometrica alle viti. Lo svantaggio principale è che, lungo l'asse, gli anelli più distanti dalle viti di serraggio subiscono una forza assiale progressivamente inferiore, portando a una distribuzione della pressione radiale non uniforme sull'albero.],[
#image("accoppiamenti conici industriali.png")
])

#grid(
  columns: (1.4fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[#strong[4. Sistema con bussola conica (Taper-lock)]
Comprende un mozzo e una bussola con un unico piano inclinato conico (generalmente con semi-angolo ampio, es. 55°). Stringendo delle viti laterali (o grani) all'interno di sedi filettate per metà sul mozzo e per metà sulla bussola, si costringe la bussola ad avanzare assialmente chiudendo un intaglio (taglio) longitudinale. Questo movimento genera la stretta radiale.],[#canvas(length: 0.8cm, {
  import draw: *


  // Circonferenza esterna adattatore (r = 2.80)
  arc((0, 0), start: -88.57deg, stop: 26.79deg, radius: 2.80, anchor: "origin", stroke: 1.0pt)
  arc((0, 0), start: 43.21deg, stop: 268.57deg, radius: 2.80, anchor: "origin", stroke: 1.0pt)

  // Cava per linguetta esterna (a 35° dall'orizzontale / 55° dalla verticale)
  line((2.041, 1.917), (1.737, 1.705), (2.195, 1.049), (2.500, 1.262), stroke: 1.0pt)

  // Circonferenza intermedia bussola (r = 1.96, interrotta dai 3 fori e dal taglio inferiore)
  arc((0, 0), start: 11.13deg, stop: 78.87deg, radius: 1.96, anchor: "origin", stroke: 1.0pt)
  arc((0, 0), start: 101.13deg, stop: 168.87deg, radius: 1.96, anchor: "origin", stroke: 1.0pt)
  arc((0, 0), start: 191.13deg, stop: 267.95deg, radius: 1.96, anchor: "origin", stroke: 1.0pt)
  arc((0, 0), start: -87.95deg, stop: -11.13deg, radius: 1.96, anchor: "origin", stroke: 1.0pt)

  // Foro interno della bussola (r = 1.30)
  arc((0, 0), start: -86.91deg, stop: 22.56deg, radius: 1.30, anchor: "origin", stroke: 1.0pt)
  arc((0, 0), start: 47.44deg, stop: 266.91deg, radius: 1.30, anchor: "origin", stroke: 1.0pt)

  // Cava per linguetta interna (a 35° dall'orizzontale)
  line((0.879, 0.958), (1.051, 1.078), (1.373, 0.620), (1.200, 0.499), stroke: 1.0pt)

  // Taglio radiale inferiore (a ore 6, da r = 1.30 a r = 2.80)
  line((-0.07, -1.30), (-0.07, -2.80), stroke: 1.0pt)
  line(( 0.07, -1.30), ( 0.07, -2.80), stroke: 1.0pt)


  // Vite sinistra in (-1.96, 0)
  circle((-1.96, 0), radius: 0.38, stroke: 0.9pt)
  circle((-1.96, 0), radius: 0.30, stroke: 0.9pt)
  line((-1.96, 0.22), (-1.77, 0.11), (-1.77, -0.11), (-1.96, -0.22), (-2.15, -0.11), (-2.15, 0.11), close: true, stroke: 0.9pt)
  line((-1.96, -0.52), (-1.96, 0.52), stroke: (dash: "dash-dotted", thickness: 0.6pt))

  // Vite destra in (1.96, 0)
  circle((1.96, 0), radius: 0.38, stroke: 0.9pt)
  circle((1.96, 0), radius: 0.30, stroke: 0.9pt)
  line((1.96, 0.22), (2.15, 0.11), (2.15, -0.11), (1.96, -0.22), (1.77, -0.11), (1.77, 0.11), close: true, stroke: 0.9pt)
  line((1.96, -0.52), (1.96, 0.52), stroke: (dash: "dash-dotted", thickness: 0.6pt))

  // Foro superiore in (0, 1.96)
  circle((0, 1.96), radius: 0.38, stroke: (dash: "dashed", thickness: 0.8pt))
  circle((0, 1.96), radius: 0.30, stroke: 0.9pt)
  // Linea interna di raccordo/smusso nel foro superiore
  bezier((-0.30, 2.02), (0.30, 2.02), (-0.10, 1.98), (0.10, 2.18), stroke: 0.9pt)
  line((-0.55, 1.96), (0.55, 1.96), stroke: (dash: "dash-dotted", thickness: 0.6pt))


  // =========================================================================
  // 3. ASSI DI SIMMETRIA PRINCIPALI
  // =========================================================================

  // Asse orizzontale
  line((-3.30, 0), (3.80, 0), stroke: (dash: "dash-dotted", thickness: 0.6pt))
  // Asse verticale
  line((0, -3.35), (0, 2.95), stroke: (dash: "dash-dotted", thickness: 0.6pt))
  // Prolungamento superiore dell'asse verticale per la quota di 55°
  line((0, 2.95), (0, 3.88), stroke: 0.6pt)

  // Asse inclinato a 35° (55° dalla verticale)
  line((0, 0), (2.335, 1.635), stroke: (dash: "dash-dotted", thickness: 0.6pt))
  // Prolungamento esterno per la quota di 55°
  line((2.85, 2), (3.24, 2.27), stroke: 0.6pt)


  // =========================================================================
  // 4. QUOTE E LINEE DI RICHIAMO
  // =========================================================================

  // Quota angolare 55° (raggio R_a = 3.70)
  arc((0, 0), start: 35deg, stop: 54deg, radius: 3.70, anchor: "origin", mark: (start: ">", size: 0.16), stroke: 0.6pt)
  arc((0, 0), start: 68deg, stop: 90deg, radius: 3.70, anchor: "origin", mark: (end: ">", size: 0.16), stroke: 0.6pt)

  // Quota larghezza cava "b"
  line((2.041, 1.917), (2.614, 2.319), stroke: 0.6pt)
  line((2.500, 1.262), (3.073, 1.664), stroke: 0.6pt)
  line((2.233, 2.515), (2.451, 2.204), mark: (end: ">", size: 0.15), stroke: 0.6pt)
  line((3.128, 1.238), (2.910, 1.549), mark: (end: ">", size: 0.15), stroke: 0.6pt)

  // Quota profondità cava "t_2"
  line((2.195, 1.049), (3.027, -0.139), stroke: 0.6pt)
  line((2.500, 1.262), (3.620, -0.337), stroke: 0.6pt)
  // Frecce per t_2 (freccia superiore verso il basso-sx sulla linea esterna, freccia inferiore tra le due linee)
  line((3.98, 0.70), (3.2, 0.18), mark: (end: ">", size: 0.15), stroke: 0.6pt)

  // Linea di richiamo "adattatore" (con pallino sul pezzo)
  circle((-1.68, 1.90), radius: 0.04, fill: black, stroke: none)
  line((-1.68, 1.90), (-2.75, 4.95), (-2.30, 4.95), stroke: 0.8pt)

  // Linea di richiamo "bussola Taper-Lock" (con pallino sul pezzo)
  circle((-0.38, -1.62), radius: 0.04, fill: black, stroke: none)
  line((-0.38, -1.62), (-1.45, -3.72), (-1.10, -3.72), stroke: 0.8pt)


  // =========================================================================
  // 5. ETICHETTE DI TESTO (tutte con text(size: 7pt))
  // =========================================================================

  content((-2.05, 4.95), text(size: 7pt)[adattatore], anchor: "west")
  content((-0.88, -3.72), text(size: 7pt)[bussola Taper-Lock], anchor: "west")
  content((1.82, 3.28), text(size: 7pt)[$55 degree$], anchor: "center")
  content((2.64, 1.88), text(size: 7pt)[b], anchor: "center")
  content((3.35, 0.62), text(size: 7pt)[$"t"_2$], anchor: "center")
})
])

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[#strong[5. Calettatori per attrito autocentranti (Tollok)]
Questi sistemi compatti e sofisticati racchiudono le superfici coniche di serraggio all'interno del dispositivo stesso. Nessuna conicità deve essere lavorata sull'albero o sul mozzo (che rimangono perfettamente cilindrici). Il Tollok si compone di due o più anelli conici contrapposti uniti da una serie di viti assiali di serraggio. 
Avvicinando i corpi sul loro piano inclinato interno tramite l'avvitatura, il dispositivo si espande diametralmente vincolando mozzo e albero. In caso di velocità elevate o mozzi lunghi, la testa del calettatore può essere incassata in battuta sul fondo di una sede a campana, in modo tale che, in caso di rottura di una vite, la flangia limiti la proiezione radiale dei detriti tutelando gli operatori.],[#image("Tollok.png", width:70%)])
La procedura di installazione richiede l'inserimento in configurazione "scarica". Il serraggio delle viti deve avvenire rigorosamente lavorando per diametri opposti (fase di accostamento a croce), al fine di portare i corpi in battuta uniformemente senza farli basculare o incastrare obliquamente; solo successivamente si effettua il serraggio in sequenza circonferenziale continua per la calibrazione finale della pressione.

Per il dimensionamento del mozzo al di sopra del Tollok, assimilato a un cilindro cavo di grosso spessore, si verifica che il diametro minimo esterno del mozzo $D M$ rispetti la proporzione:
$ D M gt.eq D dot.op K $
Dove $D$ è il diametro di contatto esterno del calettatore e $K$ è un coefficiente fornito dalle tabelle del catalogo del costruttore. Il fattore $K$ dipende dalla tensione di snervamento $R_(p 0.2)$ del materiale del mozzo e dalla geometria/pressione sviluppata.