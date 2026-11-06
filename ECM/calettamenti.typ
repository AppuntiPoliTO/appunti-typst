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
= *Calettamenti e Collegamenti Mozzo-Albero*

== Calettamento Mozzo-Albero
#align(image("tensioni albero mozzo.png", width:70%), center)
Un'applicazione fondamentale della teoria dei solidi assialsimmetrici è il collegamento *albero-mozzo*, comunemente noto come *calettamento*. L'obiettivo primario di questa soluzione costruttiva è il fissaggio
solidale di accessori su un albero rotante, come ad esempio anelli interni di cuscinetti, ruote dentate, volani o dischi di turbina. Il metodo si basa sul *forzamento* per pressione tra la superficie interna
del mozzo e la superficie esterna dell'albero, realizzando un contatto che impedisca lo *scorrimento relativo* e permetta ai due corpi di comportarsi come un'entità unica durante la rotazione. Per realizzare il calettamento, i due elementi vengono forzati l'uno
dentro l'altro partendo da una condizione geometrica precisa: il diametro interno del mozzo *$D_(m i)$* è strettamente inferiore al diametro esterno dell'albero *$D_(a e)$*. A seguito del forzamento, i due
corpi raggiungono un equilibrio elastico e i due diametri divengono uguali e coincidenti con un diametro intermedio, definito *diametro di calettamento nominale* *$D_c$*. In questa condizione di equilibrio, i due elementi si scambiano una pressione di forzamento *$p$*, che corrisponde a una pressione interna per il mozzo e a una pressione esterna per l'albero. Di conseguenza, l'albero risulta assoggettato a uno stato di compressione (cerchiamento), mentre il mozzo risulta sottoposto a uno stato di trazione (dilatazione).
Dal punto di vista funzionale e della sicurezza, la pressione di
forzamento deve garantire la totale trasmissione del momento torcente
senza alcuno *slittamento* tra le superfici, ma al contempo non deve
causare tensioni pericolose che potrebbero portare a *snervamento o
rottura per fatica* dei due elementi. Il calettamento viene effettuato industrialmente con presse idrauliche. $#upper("è")$ conveniente sfruttare la *temperatura* per semplificare l'operazione di calettamento raffreddando l'albero con l'azoto liquido e riscaldando il cuscinetto sfruttando la dilatazione termica.

=== Trasmissione di un Momento Torcente
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[La relazione tra il momento torcente trasmissibile e la pressione di forzamento si ricava analizzando le forze all'interfaccia. Sulla superficie di contatto agisce una forza normale di forzamento radiale. Considerando un elemento infinitesimo di superficie avente lunghezza pari a un arco $r dot.op d theta$ e profondità assiale $b$ (lunghezza dell'accoppiamento forzato), la forza normale è: $ d N = p dot.op b dot.op r dot.op d theta $ 
],[#image("tr mom torc.png", width:70%)])
Questa forza normale genera un'azione di attrito di direzione
tangenziale se $f$ è il coefficiente di attrito tra i materiali la forza è definita come: 
$ d T = f dot.op d N = f dot.op p dot.op b dot.op r dot.op d theta $  \
Il momento torcente totale si ottiene integrando questa forza elementare d'attrito per il rispettivo braccio (il raggio di calettamento $r = D_c\/2$) sull'intera
circonferenza:

$ M_t = integral_0^(2 pi) d T dot.op r = 2 pi dot.op r^2 dot.op b dot.op f dot.op p $

Esplicitando la pressione $p$ in funzione del diametro di calettamento,
si ottiene la pressione minima necessaria per garantire la trasmissione
del momento richiesto:

$ p = frac(2 dot.op M_t, pi dot.op D_c^2 dot.op b dot.op f) $

=== Tensioni e Spostamenti Radiali
Il calcolo delle tensioni si basa sul modello dei solidi
assialsimmetrici. L'albero si comporta come un cilindro soggetto a pressione esterna $p_i = 0$ e $p_e = p$, mentre il mozzo è
modellabile come un cilindro soggetto a pressione interna $p_i = p$e $p_e = 0$. Per l'albero, le tensioni radiale ($sigma_r$) e circonferenziale ($sigma_c$) valutate a un raggio generico $D\/2$ sono:
$ sigma_r = - p frac(1 - (D_(a i) / D)^2, 1 - (D_(a i) / D_(a e))^2) quad sigma_c = - p frac(1 + (D_(a i) / D)^2, 1 - (D_(a i) / D_(a e))^2) $
Lo spostamento radiale per un* albero cavo* valutato al bordo *esterno* risulta:
$ u_(a) = - p frac(D, 2 E) frac(\(1 - nu\)+ (D_(a i) / D)^2\(1 + nu\), 1 - (D_(a i) / D_(a e))^2) $

Per il *mozzo*, analogamente, le tensioni valutate al raggio generico
$D\/2$ sono:
$ sigma_r = - p frac((D_(m i) / D)^2 - (D_(m i) / D_(m e))^2, 1 - (D_(m i) / D_(m e))^2) quad sigma_c = p frac((D_(m i) / D)^2 + (D_(m i) / D_(m e))^2, 1 - (D_(m i) / D_(m e))^2) $
E lo *spostamento radiale* valutato al *bordo interno* risulta:
$ u_(m) = p frac(D, 2 E) frac(\(1 + nu\)(D_(m i) / D)^2 +\(1 - nu\) (D_(m i) / D_(m e))^2, 1 - (D_(m i) / D_(m e))^2) $

Per semplificare la trattazione formale, l'intera parte dell'equazione
che dipende dalle proprietà elastiche ($E\,nu$) e dalla geometria viene
racchiusa all'interno di un parametro definito "deformabilità". Si
definisce quindi la deformabilità del mozzo $delta_m$:
$ delta_m = 1 / E frac(\(1 + nu\)+ (D_(m i) / D_(m e))^2\(1 - nu\), 1 - (D_(m i) / D_(m e))^2) $
E la deformabilità dell'albero $delta_a$ (nel caso di albero cavo):
$ delta_a = 1 / E frac(\(1 - nu\)+ (D_(a i) / D_(a e))^2\(1 + nu\), 1 - (D_(a i) / D_(a e))^2) $
#grid(
  columns: (0.7fr, 1fr),
  column-gutter: -3cm,
  align: (left + horizon, right + horizon),[Con l'introduzione di questi parametri, gli spostamenti radiali ai bordi
in contatto possono essere scritti in forma estremamente compatta:],[$ u_(m i) = p D_(m i) / 2 delta_m $
$ u_(a e) = - p D_(a e) / 2 delta_a $]) Si può anche usare il parametro $beta = (D i) / (D e)$  
=== Interferenza diametrale e pressione di forzamento
Gli spostamenti radiali del bordo esterno dell'albero (compresso verso
l'interno, negativo) e del bordo interno del mozzo (teso verso
l'esterno, positivo) definiscono geometricamente l'interferenza
diametrale. Quest'ultima rappresenta di fatto la "sovrapposizione"
teorica dei due materiali prima del forzamento, ed è misurata come:
$ i = 2\(\|u_(a e)\|+\|u_(m i)\|\)  = i = p dot.op (D_(a e) dot.op delta_a + D_(m i) dot.op delta_m) $ 
Si ricava la pressione generata
per una data interferenza: $ p = frac(i, (D_(a e) dot.op delta_a + D_(m i) dot.op delta_m)) $
Poiché alla condizione di equilibrio
$D_(a e) tilde.eq D_(m i) tilde.eq D_c$, si ricava la pressione generata
per una data interferenza: $ p = frac(i, D_c\(delta_a + delta_m\)) $
 Se l'interferenza è fornita in
micrometri, per allinearla dimensionalmente ai millimetri dei diametri,
si introduce il fattore di correzione:
$ p = frac(i, D_c\(delta_a + delta_m\)dot.op 10^3) $

=== Diagramma di Interferenza
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[L'equilibrio geometrico e pressorio del sistema si studia visivamente
mediante il diagramma di interferenza. Riportando lo spostamento radiale
$u$ in ascissa e la pressione $p$ in ordinata, è possibile tracciare le
rette che definiscono il comportamento elastico del mozzo e dell'albero.
La retta del mozzo (caratteristica a trazione) parte dall'origine. La
retta dell'albero (caratteristica a compressione) giace nel semipiano
negativo. Assegnare un'interferenza geometrica equivale a traslare
rigidamente la caratteristica dell'albero verso destra di una quantità
proporzionale a $i\/2$. Il punto di intersezione tra la caratteristica
traslata dell'albero e quella fissa del mozzo definisce l'esatto punto
di equilibrio elastico del sistema. La proiezione di questo punto
sull'asse delle ordinate fornisce la pressione effettiva di forzamento
$p$. La coordinata associata all'intersezione permette inoltre di
determinare il diametro di calettamento esatto:
$ D_c = frac(D_(a e) dot.op D_(m i) dot.op\(delta_a + delta_m\), delta_a dot.op D_(a e) + delta_m dot.op D_(m i)) $],[#image("diagramma di interferenza.png", width:100%)])

=== Sistema di Tolleranze e Condizioni Estreme
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[A livello pratico, la geometria delle parti viene definita tramite il
sistema di tolleranze ISO. Una descrizione completa si ottiene
associando alla dimensione nominale una lettera (che indica lo
scostamento) e un numero (che indica la qualità IT, ovvero l'ampiezza
del campo di tolleranza). Solitamente si adotta un sistema foro-base,
dove le lettere maiuscole si riferiscono ai fori (es. H) e quelle
minuscole agli alberi. Spesso si utilizza un grado di qualità per
l'albero pari a quello del foro meno uno (es. 16 H8/f7). Poiché la lavorazione produce quote che possono variare all'interno del
campo di tolleranza, in fase di progetto è indispensabile valutare le
due condizioni estreme dell'accoppiamento:],[#image("diagramma incertezze.png")])




 1. #strong[Interferenza
massima ($i_(m a x)$):] Si ottiene sottraendo il diametro minimo del
foro (mozzo) dal diametro massimo dell'albero. Questa condizione
garantisce la massima trasmissione del momento torcente ma genera le
pressioni più elevate, le quali andranno utilizzate per la verifica
tensionale strutturale contro i rischi di plasticizzazione o rottura. \ 2.
#strong[Interferenza minima ($i_(m i n)$):] Si ottiene calcolando la
differenza tra il diametro minimo dell'albero e il diametro massimo del
foro. Tale valore determina la pressione di contatto più bassa possibile
e deve essere utilizzato per condurre la verifica funzionale,
assicurandosi che, pur nel caso peggiore di lavorazione, l'attrito
generato sia sufficiente a trasmettere il momento torcente di progetto
senza slittamenti. Le due condizioni devono necessariamente coesistere e
risultare compatibili con le specifiche tecniche.
== Variazioni dell'Interferenza in Esercizio
L'interferenza definita geometricamente (nominale o di processo) non
coincide con quella che i due elementi percepiranno in effettiva
condizione di esercizio. Intervengono infatti fenomeni parassiti e
condizioni operative che ne causano una variazione. L'interferenza
effettiva è espressa come:
$ i_(e f f e t t i v a) = i - Delta i^R - Delta i^T - Delta i^omega $
Tale espressione indica che l'interferenza utile viene decurtata dei
seguenti fattori:

- #strong[Effetto della rugosità superficiale ($Delta i^R$):] 
Il processo
stesso di calettamento causa uno schiacciamento locale delle creste del
profilo di rugosità delle superfici a contatto. Questo appiattimento,
valutabile tipicamente in una perdita del 40% dell'altezza delle creste,
si traduce in una perdita permanente di interferenza valutata sui
diametri:
$ Delta i^R = 2 dot.op 0.4 dot.op\(R_a^(a l b e r o) + R_a^(m o z z o)\) $
Il calcolo viene svolto in micrometri ed è fondamentale che la rugosità
superficiale prescritta sia coerente con la classe di tolleranza IT
scelta.

- #strong[Effetto delle variazioni di temperatura ($Delta i^T$):] 
Se la temperatura di esercizio è diversa da quella in cui è avvenuto il
montaggio (convenzionalmente 20°C), subentra la dilatazione termica
differenziale. Nel caso in cui i due materiali differiscano per
coefficiente di dilatazione termica lineare ($alpha_m$ per il mozzo,
$alpha_a$ per l'albero), un salto termico $Delta T$ modificherà i
diametri operativi secondo la relazione:
$ i_(e f f e t t i v a) =\(D_(a e) + D_(a e) alpha_a Delta T\)-\(D_(m i) + D_(m i) alpha_m Delta T\) $
Raccogliendo rispetto al diametro di calettamento nominale
$D_c tilde.eq D_(a e) tilde.eq D_(m i)$, si estrapola la perdita
termica:
$ Delta i^T = D_c\(alpha_m - alpha_a\)Delta T dot.op 10^3 quad\[mu m\] $
Se i materiali sono identici, il termine $Delta i^T$ si annulla poiché
sia l'albero che il mozzo si dilatano di pari passo. Se sono differenti,
il segno del salto termico e la combinazione dei coefficienti possono
far risultare il termine positivo o negativo.

- #strong[Effetto della centrifugazione ($Delta i^omega$):] 
In esercizio, un albero rotante sottopone a forza centrifuga le proprie masse e quelle
del mozzo. Poiché la massa dell'albero è concentrata vicino all'asse di
rotazione, essa possiede un'inerzia radiale limitata. Al contrario,
accessori come corone dentate o volani apportano masse collocate a un
raggio molto maggiore, subendo una dilatazione radiale ben superiore a
quella dell'albero. Questo fenomeno determina uno scostamento
differenziale radiale:
$ Delta i^omega = 2 dot.op\(u_(m i)^omega - u_(a e)^omega\) $ A favore
di sicurezza, trascurando la debole dilatazione dell'albero
($u_(a e) = 0$) e trattando il mozzo come un anello sottile, lo
scostamento è dato da:
$ u_(m i)^omega = frac(D_i rho omega^2 D_e^2, 8 E) arrow.r.double Delta i^omega = frac(D_i rho omega^2 D_e^2, 4 E) $
Questo effetto giustifica un potenziale "scalettamento", ovvero
l'annullamento della pressione di contatto a velocità di rotazione
critiche.
== Modalità di Montaggio e Effetto d'Intaglio
<modalità-di-montaggio-e-effetto-dintaglio>
Il posizionamento del mozzo sull'albero avviene affrontando
l'interferenza geometrica per via termica o meccanica. Nel
#strong[montaggio a caldo / a freddo], si interviene riscaldando il
mozzo e/o raffreddando l'albero per dilatare il foro o restringere il
perno, producendo un gioco momentaneo.


Per l'acciaio il limite superiore di riscaldamento è di circa 350°C,
influenzato pesantemente anche dalle specifiche dei fluidi lubrificanti
se presenti (es. cuscinetti). Per il raffreddamento si usano ghiaccio
secco (-72°C) o aria/azoto liquido (-190°C). Il salto termico totale
$Delta T$ richiesto agli operatori in officina per ottenere sia
l'assorbimento dell'interferenza massima tollerata ($i_(m a x)$) sia un
franco di gioco aggiuntivo ($s$, compreso solitamente tra 30 e 100
$mu m$) per permettere l'ingresso senza impuntamenti è:
$ Delta T = frac(i_(m a x) + s, alpha dot.op D_c dot.op 10^3) $

Il #strong[montaggio alla pressa] forza meccanicamente l'albero nel
mozzo. Tale operazione, facilitata applicando uno smusso d'invito di 5°
lungo almeno 2-5 mm sull'albero e utilizzando lubrificante (che verrà in
parte raschiato non inficiando gravemente l'interferenza finale),
richiede una forza assiale di calettamento pari a:
$ F = p dot.op A_(l a t e r a l e) dot.op f_e $ dove $f_e$ è il
coefficiente di attrito per scorrimento assiale (diverso da quello
torsionale per rotazione $f$).

A livello strutturale, la brusca variazione di diametro ai bordi della
regione del forzamento, tipica delle sedi dei cuscinetti, induce un
rilevante #strong[effetto di intaglio]. Le pressioni di contatto
perturbano le linee di flusso degli sforzi assiali/flessionali
dell'albero. Per mitigare tale intensificazione e salvaguardare la
resistenza a fatica, si prevede una "mazzetta" (o risalto), ovvero un
incremento locale del diametro nella sola zona cerchiata dal mozzo.
L'esperienza suggerisce la proporzione:
$ D_(n o m i n a l e) tilde.eq 1.3 nothing_(a l b e r o) $ Lo
schiacciamento radiale di questo collare da parte del mozzo lo riporterà
circa al diametro nominale del corpo dell'albero, rendendo il flusso
delle tensioni più uniforme.
#pagebreak()
=== Procedura di Calcolo
<procedura-di-calcolo-1>
La progettazione per materiali metallici prevede tipicamente
l'esplorazione di due percorsi operativi: 
1. #strong[Fissando geometria
e materiali (Approccio dimensionale):] 
- Si impostano il diametro $D_c$, la lunghezza di accoppiamento $b$ e si selezionano i materiali (da cui $delta_a$, $delta_m$, $f$). 
- Si calcola la pressione $p$ necessaria a trasmettere il momento $M_t$ $arrow.double p = (2 dot M_t)/(pi dot D_c^2 dot b dot f)$. 
- Si verifica lo stato di tensione ($sigma_r$, $sigma_c$) in funzione della pressione trovata. Se i limiti elastici vengono superati, si torna allo step 1 modificando le geometrie o i materiali. 
2. #strong[Fissando la resistenza del materiale
(Approccio strutturale):] 
- Si fissa la pressione massima ammissibile dai materiali del mozzo $p_(a m m) = sigma_(a m m) frac(1 - beta_m^2, sqrt(3 + beta_m^4))$. 
- In funzione del momento $M_t$ voluto, si ricava la lunghezza di accoppiamento $b$ necessaria $arrow.double b= (2 dot M_t)/(pi dot D_c^2 dot p_("amm") dot f)$
- Se tale $b$ è incompatibile con gli ingombri assiali disponibili sulla macchina, occorre iterare l'ottimizzazione.

Una volta accertata la coerenza di pressioni, materiali e geometrie per
trasmettere il moto, il progettista deve definire l'accoppiamento in
officina. Si calcola l'interferenza effettiva $i_(n e c)$ strettamente
necessaria per avere la pressione $p$ di progetto:
$ i_(n e c) = p dot.op D_c\(delta_a + delta_m\)dot.op 10^3 quad\[mu m\] $
A questo valore minimo vitale, occorre addizionare algebricamente tutte
le perdite per determinare l'interferenza minima di montaggio $i_0$ che
gli operatori dovranno garantire a banco:
$ i_0 = i_(n e c) + Delta i^R + Delta i^T + Delta i^omega $ La scelta
sul manuale ISO ricadrà su un accoppiamento che possegga una
$i_(m i n) gt.eq i_0$. Parallelamente, la $i_(m a x)$ fornita
dall'accoppiamento scelto determinerà la $p_(m a x)$, che verrà
impiegata per effettuare le riverifiche ultime di resistenza per
scongiurare rotture o snervamento sotto le pressioni di punta della
tolleranza peggiore.