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
= *Alberi di Trasmissione*

== Alberi: dimensionamento e verifica
<alberi-dimensionamento-e-verifica>

Lo studio degli elementi costruttivi delle macchine si apre con l'*albero di trasmissione* per una duplice motivazione metodologica:
1. *Applicazione diretta del calcolo a fatica:* l'albero rotante costituisce il caso archetipico di implementazione dei criteri di resistenza a fatica e dei fattori di concentrazione delle tensioni studiati nella meccanica del danneggiamento.
2. *Continuità con la teoria elementare della trave:* essendo un corpo snello (*traviforme*), ad esso si applicano direttamente i modelli di calcolo delle caratteristiche di sollecitazione e delle deformazioni della meccanica strutturale.

Un passaggio fondamentale nel dimensionamento è la distinzione formale tra assi e alberi:
- *Asse (Axle):* Elemento rotante o fisso adibito a sostenere elementi ruotanti; soggetto unicamente a flessione, non trasmette momento torcente significativo (es. asse ferroviario).
- *Albero (Shaft):* Elemento rotante di trasmissione che eroga potenza; subisce flessione (rotante) ed è specificamente soggetto a momento torcente.

Assi e alberi sono gli organi di macchina più prossimi al modello strutturale di *trave* (l'applicabilità del modello di De Saint-Venant è garantita da dimensioni della sezione trasversale sensibilmente inferiori allo sviluppo longitudinale), dal quale si distinguono perché destinati a *ruotare o oscillare attorno al proprio asse geometrico*. Oltre a flessione e (negli alberi) torsione, entrambi possono sopportare *carichi assiali* originati da spinte di dentature elicoidali o coniche, *precarico assiale* di montaggio dei cuscinetti, o *peso proprio* dell'albero e degli organi calettati nelle configurazioni ad *asse verticale*.

L'adozione della *sezione circolare (assialsimmetrica)* risponde a due esigenze:
- *Regolarità dinamica di rotazione:* mantiene costante il momento d'inerzia rispetto a qualunque asse baricentrico durante la rotazione, evitando fluttuazioni inerziali e irregolarità di moto tipiche delle sezioni prismatiche (es. quadrate o rettangolari).
- *Sicurezza antinfortunistica:* l'assenza di spigoli vivi in rotazione riduce drasticamente il rischio di aggancio o ferimento grave per contatto accidentale dell'operatore con l'organo in movimento.

Dal punto di vista costruttivo e morfologico, lungo lo sviluppo assiale la sezione dell'albero varia in modo articolato per consentire infilaggio, bloccaggio assiale (tramite spallamenti) e calettamento dei vari organi, nonostante i severi *effetti di intaglio* (concentrazione locale delle tensioni) introdotti da tali discontinuità geometriche. Si distinguono tre tipologie di tratti cilindrici o conici:
- *Fusto:* tratto intermedio che raccorda e distanzia le zone di calettamento, trasmettendo le azioni interne da una sezione all'altra;
- *Sedi:* tratti specificamente lavorati (spesso con cave per linguette o scanalature) destinati ad alloggiare gli organi che scambiano potenza (ruote dentate, pulegge, giunti);
- *Perni (di estremità o intermedi):* porzioni cilindriche corte, rettificate e con ristrette tolleranze dimensionali e geometriche, destinate ad alloggiare e sopportare i cuscinetti di supporto.

#align(center)[

#canvas(length: 1cm, {
  import draw: *
  
  // Assi di riferimento (tratto-punto)
  line((-0.5, 0), (14.5, 0), stroke: (dash: "dash-dotted", thickness: 0.6pt))
  line((1.0, -1.3), (1.0, 1.3), stroke: (dash: "dash-dotted", thickness: 0.6pt))
  line((6.8, -0.7), (6.8, 0.7), stroke: (dash: "dash-dotted", thickness: 0.6pt))
  line((7.7, -0.7), (7.7, 0.7), stroke: (dash: "dash-dotted", thickness: 0.6pt))

  // ----------------------------------------------------
  // SEZIONE 1: Sede sinistra (x: 0 -> 2.5)
  // ----------------------------------------------------
  // Faccia sinistra e smussi
  line((0, 0.8), (0, -0.8), stroke: 1pt)
  line((0, 0.8), (0.1, 1.0), stroke: 1pt)
  line((0, -0.8), (0.1, -1.0), stroke: 1pt)
  // Profilo esterno
  line((0.1, 1.0), (2.5, 1.0), stroke: 1pt)
  line((0.1, -1.0), (2.5, -1.0), stroke: 1pt)
  // Scanalatura superiore (cava per linguetta)
  line((0, 0.6), (1.4, 0.6), stroke: 1pt)
  arc((1.4, 1.0), start: -90deg, stop: 0deg, radius: 0.4, anchor: "origin", stroke: 1pt)
  // Foro cieco interno (tratteggiato)
  line((0, 0.35), (1.5, 0.35), stroke: (dash: "dashed", thickness: 0.8pt))
  line((1.5, 0.35), (1.8, 0), stroke: (dash: "dashed", thickness: 0.8pt))
  line((1.8, 0), (1.5, -0.35), stroke: (dash: "dashed", thickness: 0.8pt))
  line((1.5, -0.35), (0, -0.35), stroke: (dash: "dashed", thickness: 0.8pt))
  // Proiezione larghezza scanalatura (tratteggiata)
  line((0, 0.8), (1.4, 0.8), stroke: (dash: "dashed", thickness: 0.8pt))
  // Parete di cambio sezione
  line((2.5, 1.0), (2.5, -1.0), stroke: 1pt)

  // ----------------------------------------------------
  // SEZIONE 2: Perno intermedio (x: 2.5 -> 4.0)
  // ----------------------------------------------------
  line((2.5, 0.5), (4.0, 0.5), stroke: 1pt)
  line((2.5, -0.5), (4.0, -0.5), stroke: 1pt)
  line((4.0, 1.1), (4.0, -1.1), stroke: 1pt)

  // ----------------------------------------------------
  // SEZIONE 3: Fusto (x: 4.0 -> 6.5)
  // ----------------------------------------------------
  line((4.0, 1.1), (6.5, 1.1), stroke: 1pt)
  line((4.0, -1.1), (6.5, -1.1), stroke: 1pt)
  line((6.5, 1.1), (6.5, -1.1), stroke: 1pt)

  // ----------------------------------------------------
  // SEZIONE 4: Sede centrale con asola (x: 6.5 -> 8.0)
  // ----------------------------------------------------
  line((6.5, 1.1), (8.0, 1.1), stroke: 1pt)
  line((6.5, -1.1), (8.0, -1.1), stroke: 1pt)
  line((8.0, 1.1), (8.0, -1.1), stroke: 1pt)
  // Asola
  line((6.8, 0.3), (7.7, 0.3), stroke: 1pt)
  line((6.8, -0.3), (7.7, -0.3), stroke: 1pt)
  arc((6.8, 0), start: 90deg, stop: 270deg, radius: 0.3, anchor: "origin", stroke: 1pt)
  arc((7.7, 0), start: -90deg, stop: 90deg, radius: 0.3, anchor: "origin", stroke: 1pt)

  // ----------------------------------------------------
  // SEZIONE 5: Fusto rastremato (x: 8.0 -> 11.5)
  // ----------------------------------------------------
  line((8.0, 1.1), (11.5, 0.9), stroke: 1pt)
  line((8.0, -1.1), (11.5, -0.9), stroke: 1pt)
  line((11.5, 0.9), (11.5, -0.9), stroke: 1pt)

  // ----------------------------------------------------
  // SEZIONE 6: Perno estremità (x: 11.5 -> 13.8)
  // ----------------------------------------------------
  // Primo gradino
  line((11.5, 0.75), (12.5, 0.75), stroke: 1pt)
  line((11.5, -0.75), (12.5, -0.75), stroke: 1pt)
  line((12.5, 0.75), (12.5, -0.75), stroke: 1pt)
  // Secondo gradino (parte filettata esterna)
  line((12.5, 0.55), (13.6, 0.55), stroke: 1pt)
  line((12.5, -0.55), (13.6, -0.55), stroke: 1pt)
  // Linee di filettatura interne (sottili)
  line((12.5, 0.45), (13.8, 0.45), stroke: 0.6pt)
  line((12.5, -0.45), (13.8, -0.45), stroke: 0.6pt)
  // Smusso finale e faccia destra
  line((13.6, 0.55), (13.8, 0.45), stroke: 1pt)
  line((13.6, -0.55), (13.8, -0.45), stroke: 1pt)
  line((13.8, 0.45), (13.8, -0.45), stroke: 1pt)

  // ----------------------------------------------------
  // ANNOTAZIONI (Frecce e Testi)
  // ----------------------------------------------------
  // Sede sx
  line((1.8, -1.9), (1.4, -1.1), mark: (end: ">"), stroke: red)
  content((1.8, -2.1), [Sede], anchor: "north")
  
  // Perno intermedio
  line((3.5, -1.9), (3.1, -0.6), mark: (end: ">"), stroke: red)
  content((3.5, -2.1), [Perno\ intermedio], anchor: "north")
  
  // Fusto sx
  line((5.3, -1.9), (4.9, -1.2), mark: (end: ">"), stroke: red)
  content((5.3, -2.1), [Fusto], anchor: "north")
  
  // Sede centrale
  line((7.5, -1.9), (7.1, -1.2), mark: (end: ">"), stroke: red)
  content((7.5, -2.1), [Sede], anchor: "north")
  
  // Fusto dx rastremato
  line((9.8, -1.9), (9.4, -1.0), mark: (end: ">"), stroke: red)
  content((9.8, -2.1), [Fusto], anchor: "north")
  
  // Perno estremità dx
  line((12.8, -1.9), (12.3, -0.8), mark: (end: ">"), stroke: red)
  content((12.8, -2.1), [Perno\ estremità], anchor: "north")


})

]
#v(1em)

Per limitare pesi e ingombri, la linea di trasmissione opera ad elevata velocità angolare: essendo la potenza il prodotto tra coppia e velocità angolare, l'alta velocità abbatte la coppia torcente trasmessa, consentendo alberi più snelli e leggeri. Tale esigenza è stringente nei veicoli terrestri, navali e aeronautici, dove una linea pesante richiederebbe ulteriore potenza solo per essere trasportata. L'architettura di trasmissione può quindi prevedere una prima trasformazione cinematica già *a monte* dell'albero (dal motore verso la linea) per *innalzare la velocità angolare* e ridurre la coppia sull'albero lungo, e una seconda *a valle* (in prossimità dell'utenza finale, come il differenziale automobilistico o il riduttore finale) per *abbattere la velocità e moltiplicare la coppia* erogata alle ruote o all'elica: l'albero di trasmissione può così ruotare a una velocità angolare diversa sia da quella del motore sia da quella dell'utenza. Lungo la linea si inseriscono anche giunti e innesti a frizione con funzione di "elemento fusibile", che in caso di sovraccarico grave cedono preservando l'integrità del motore.

== Il concetto di sistema meccanico e la linea di trasmissione
A differenza dell'elemento strutturale isolato (la semplice *trave* della meccanica strutturale), nella costruzione di macchine si analizza un *sistema meccanico*: un insieme di sottosistemi e componenti collegati e assemblabili costruttivamente per svolgere una precisa funzione, tipicamente la *trasmissione e il controllo del moto e della potenza* da una sorgente a un utilizzatore.

#align(center)[
  #canvas(length: 1cm, {
    import draw: *
    // Linea d'asse / albero
    line((0.8, 0), (11.2, 0), stroke: 1.4pt)
    
    // Motore M
    rect((0, -0.45), (0.9, 0.45), stroke: 1pt, fill: luma(245))
    arc((0.9, 0.45), start: 90deg, stop: -90deg, radius: 0.45, stroke: 1pt, fill: luma(245))
    content((0.55, 0), [*M*])
    content((0.55, -0.9), [Motore], anchor: "north")

    // Utilizzatore U
    rect((11.1, -0.45), (12.0, 0.45), stroke: 1pt, fill: luma(245))
    arc((11.1, -0.45), start: -90deg, stop: -270deg, radius: 0.45, stroke: 1pt, fill: luma(245))
    content((11.45, 0), [*U*])
    content((11.45, -0.9), [Utilizzatore], anchor: "north")

    // Giunto 1 (sinistra)
    line((2.4, -0.45), (2.4, 0.45), stroke: 1pt)
    line((2.6, -0.45), (2.6, 0.45), stroke: 1pt)
    line((2.2, 0.25), (2.8, 0.25), stroke: 0.8pt)
    line((2.2, -0.25), (2.8, -0.25), stroke: 0.8pt)
    circle((2.5, 1.1), radius: 0.3, stroke: 0.8pt)
    content((2.5, 1.1), [1])
    line((2.5, 0.8), (2.5, 0.45), stroke: 0.6pt)
    content((2.5, -0.9), [Giunto], anchor: "north")

    // Supporto 2 (sinistra - carrello)
    line((4.2, -0.2), (4.8, 0.2), stroke: 1pt)
    circle((4.5, 1.1), radius: 0.3, stroke: 0.8pt)
    content((4.5, 1.1), [2])
    line((4.5, 0.8), (4.5, 0.15), stroke: 0.6pt)

    // Supporto 3 (centro-destra - cerniera/cuscinetto reggispinta)
    line((6.7, -0.2), (7.3, 0.2), stroke: 1pt)
    line((7.0, 0), (7.0, -0.55), stroke: 0.8pt)
    circle((6.8, -0.4), radius: 0.12, stroke: 0.7pt)
    line((6.6, -0.55), (7.4, -0.55), stroke: 0.8pt)
    circle((7.0, 1.1), radius: 0.3, stroke: 0.8pt)
    content((7.0, 1.1), [3])
    line((7.0, 0.8), (7.0, 0.15), stroke: 0.6pt)
    content((5.75, -0.9), [Supporti], anchor: "north")

    // Giunto 1 (destra)
    line((9.4, -0.45), (9.4, 0.45), stroke: 1pt)
    line((9.6, -0.45), (9.6, 0.45), stroke: 1pt)
    line((9.2, 0.25), (9.8, 0.25), stroke: 0.8pt)
    line((9.2, -0.25), (9.8, -0.25), stroke: 0.8pt)
    circle((9.5, 1.1), radius: 0.3, stroke: 0.8pt)
    content((9.5, 1.1), [1])
    line((9.5, 0.8), (9.5, 0.45), stroke: 0.6pt)
    content((9.5, -0.9), [Giunto], anchor: "north")
  })
]

Lo schema funzionale di una linea di trasmissione tipo comprende:
- *Motore (M):* sorgente che genera la potenza meccanica $P$, erogandola all'albero di uscita con coppia motrice $C_m$ e velocità angolare $omega_m$ ($P = C_m omega_m$, oppure $P = F v$ se sorgente o utilizzatore operano con moto traslatorio anziché rotatorio, con $F$ forza sviluppata e $v$ velocità lineare).
- *Utilizzatore (U):* organo operatore (dotato di propria inerzia) che richiede coppia per funzionare, può subire urti o danni in esercizio ripercuotendoli a ritroso lungo la linea, e riceve la potenza del motore (a meno delle perdite per attrito) generalmente con coppia $C_u$ e velocità angolare $omega_u$ *diverse* da quelle motrici, restando invariato (nel caso ideale) il prodotto:
  $ P = C_m omega_m = C_u omega_u $
  L'elevata inerzia dell'utilizzatore (es. *elica navale*, con massa cospicua distribuita a grande distanza radiale dall'asse e conseguente elevato momento d'inerzia polare) giustifica l'erogazione di una coppia $C_u$ altissima a bassa velocità $omega_u$. In ambito navale ciò è realizzabile collegando l'albero motore a un secondo albero porta-elica tramite trasmissione multipla a cinghie e pulegge in parallelo: in tale schema occorre controllare rigorosamente la *freccia flessionale* dell'albero snello, poiché un'inflessione eccessiva comprometterebbe il lavoro delle cinghie portando le pulegge rotanti a strisciare o urtare contro la cassa statorica fissa.
- *Albero di trasmissione e Giunti (1):* l'albero rotante trasferisce la potenza da M a U attraversando la macchina, e deve risultare leggero (data l'estensione assiale), poco ingombrante e facilmente accessibile per la manutenzione. I *giunti* (1) lo collegano a motore e utilizzatore assolvendo quattro possibili funzioni progettuali:
  1. compensare eventuali *errori di allineamento* (assiali, radiali o angolari) tra gli assi collegati;
  2. fungere da *elemento sacrificabile ("fusibile" meccanico)* per guasto o sovraccarico improvviso, interrompendo la trasmissione a salvaguardia di motore o utilizzatore;
  3. contenere e smorzare le *vibrazioni* della linea (lato motore e utilizzatore);
  4. contribuire a *regolarizzare la velocità di rotazione*.
- *Supporti (2 e 3):* cuscinetti che collegano l'albero al telaio fisso (suolo/statore), consentendone la libera rotazione attorno al proprio asse ma posizionandolo nello spazio e agendo da vincoli strutturali su cui scaricare forze e reazioni vincolari.

La sintesi progettuale del sistema richiede di:
1. determinare la *configurazione di massima* e gli elementi costitutivi;
2. attribuire a ciascun componente la propria *funzione* specifica;
3. *dimensionare* ogni elemento a resistenza statica, durata a fatica e deformabilità;
4. prevenire *problemi di funzionamento* (interferenze, vibrazioni, usura, surriscaldamento);
5. curare la *compatibilità geometrica e funzionale* e garantire la *reale possibilità di assemblaggio e smontaggio* delle parti.

=== Modalità di trasmissione del moto e architettura costruttiva
Il trasferimento di potenza tra componenti avviene secondo due modalità cinematiche, con precisi compromessi progettuali tra rigidezza, precisione cinematica e costo:
- *Trasmissione del moto (rotatorio $arrow.r$ rotatorio):* dipende dalla disposizione degli assi e dalle esigenze di compattezza e variazione di velocità:
  - *Alberi coassiali (mediante giunti):* i *giunti articolati (es. cardanici)*, a differenza di quelli rigidi, trasmettono la coppia consentendo un *moto relativo controllato* (angolare o assiale) tra gli alberi.
  - *Alberi paralleli vicini o ad assi incidenti/sghembi (mediante ingranaggi):* le ruote dentate cilindriche o coniche (che permettono più cambi di direzione e velocità riducendo gli ingombri) realizzano un contatto diretto tra corpi rigidi; garantiscono un *interasse rigorosamente fisso e stabile* (specifica di progetto), rapporto di velocità costante ed esatto e vibrazioni contenute, ma comportano costi elevati per lavorazioni di precisione, lubrificazione, fatica superficiale e usura dei denti.
  - *Alberi paralleli distanti (trasmissioni flessibili a cinghie e pulegge o a catena):* l'elemento intermedio flessibile ed elastico (cinghia) abbatte i costi costruttivi e offre estrema versatilità geometrica, ma non garantisce il mantenimento rigoroso della posizione relativa (fasatura) tra gli alberi ed espone maggiormente a vibrazioni se gli alberi sono molto deformabili.
- *Trasformazione del moto (rotatorio $arrow.l.r$ lineare):* converte una rotazione in traslazione rettilinea o viceversa (es. sistemi pignone-cremagliera, viti a ricircolo di sfere accoppiate a guide lineari).

L'inserimento costruttivo dell'albero nella macchina (es. in un riduttore a ingranaggi) richiede di integrare e dimensionare organi accessori sulla parte rotante e su quella fissa:
- *Collegamenti mozzo-albero:* gli organi che scambiano coppia (ruote dentate, pulegge, volani, semi-giunti) sono resi solidali alla rotazione tramite *accoppiamento di forma* (*chiavette, linguette, profili scanalati*) o per attrito/interferenza, e posizionati assialmente con *spallamenti* sull'albero o *distanziali* interposti (il distanziale è superfluo se è già presente uno spallamento con la medesima funzione di battuta assiale).
- *Interfaccia con i supporti (cuscinetti volventi vs bronzine):* il vincolo rotazionale albero-telaio usa cuscinetti a strisciamento (*bronzine*) o *cuscinetti volventi* (composti da *anello interno* rotante solidale all'albero, *anello esterno* fisso nella cassa statorica e *corpi volventi* interposti), scelti in base a velocità di rotazione, entità dei carichi e durata richiesta.
- *Parte statorica (cassa e tenute):* l'involucro fisso è progettato in moduli connessi da *collegamenti smontabili filettati* (viti e bulloni) per consentire il montaggio degli alberi, includendo *coperchi* ed elementi di tenuta per delimitare la regione di lavoro (trattenere i lubrificanti ed evitare contaminazioni esterne).

=== Schematizzazione dei vincoli
Ai fini della statica elementare, gli alberi sono schematizzati come travi e i cuscinetti come vincoli ideali per gestire reazioni, dilatazione termica e grado di vincolo angolare:
- *Scorrimento assiale (Cerniera vs Carrello):* la distinzione non dipende necessariamente dal tipo di cuscinetto (che può essere il medesimo cuscinetto radiale a una corona di sfere in entrambi i supporti $A$ e $B$), ma da *come sono vincolati assialmente gli anelli interno ed esterno* nel montaggio:
  - *Cerniera (supporto $A$):* un cuscinetto è bloccato assialmente per fornire rigidezza e scaricare le spinte. L'anello interno è bloccato assialmente sul rotore da ambo i lati (es. tra distanziale ed elemento di chiusura o spallamento), e l'anello esterno è bloccato nella sede statorica (tra uno spallamento della cassa e un coperchio imbullonato). Avendo le piste dei cuscinetti radiali a sfere profilo toroidale (semicircolare), il contatto sfera-pista sviluppa una modesta reazione assiale in ambo i versi pur consentendo una lieve rotazione angolare relativa nel piano di flessione: impedisce traslazioni radiale e assiale lasciando libera la rotazione.
  - *Carrello (supporto $B$):* il cuscinetto opposto è libero di scorrere assialmente per assorbire la dilatazione termica. L'anello interno resta bloccato sull'albero (tra distanziale e spallamento del fusto), mentre l'*anello esterno è alloggiato nella sede cilindrica della cassa senza battute assiali laterali*. Con una *dilatazione termica* differenziale tra albero e cassa in esercizio, l'anello esterno trasla leggermente rilassando l'allungamento termico ed evitando severe forze di compressione assiale parassite che sovraccaricherebbero albero e cuscinetti se entrambi i supporti fossero bloccati.
- *Grado di vincolo angolare (flessionale):*
  - *Appoggio semplice (cerniera o carrello ideali):* un singolo cuscinetto che consente piccole rotazioni relative dell'asse nel piano di flessione impone abbassamento trasversale nullo ma rotazione angolare della linea elastica libera ($phi_A, phi_B != 0$).
  - *Incastro:* un supporto molto esteso assialmente (bronzina lunga) o una coppia di cuscinetti opportunamente distanziati che contrastano l'inclinazione dell'asse reagiscono anche con una coppia flettente, approssimando un *incastro* (rotazione impedita, $phi = 0$) che irrigidisce notevolmente la struttura e modifica i diagrammi del momento flettente.

#figure(canvas(length: 1.25cm, {
  import draw: *

  // ==========================================
  // PANNELLO 1 (SINISTRA)
  // ==========================================

  // --- Linee di proiezione verticali ---
  line((0.6, 5.8), (0.6, 1.45), stroke: 0.5pt)
  line((2.5, 7.45), (2.5, 0.85), stroke: 0.6pt)
  line((4.8, 7.55), (4.8, 0.0), stroke: 0.6pt)
  line((5.85, 5.8), (5.85, 0.85), stroke: 0.6pt)

  // --- Asse dell'albero (tratteggiato) ---
  line((-0.4, 5.8), (6.7, 5.8), stroke: (dash: "dashed", thickness: 0.6pt))

  // --- Punti neri sull'asse dell'albero ---
  circle((2.5, 5.8), radius: 0.08, fill: black)
  circle((4.8, 5.8), radius: 0.08, fill: black)

  // --- Freccia cava Mt a sinistra ---
  line((-0.27, 5.8), (-0.27, 5.45), (-0.11, 5.45), (-0.11, 5.8), stroke: 0.8pt)
  arc((0.05, 5.8), start: 0deg, stop: 180deg, radius: (0.32, 0.85), anchor: "origin", stroke: 0.8pt)
  arc((0.05, 5.8), start: 0deg, stop: 180deg, radius: (0.16, 0.68), anchor: "origin", stroke: 0.8pt)
  line((0.37, 5.8), (0.37, 5.65), (0.46, 5.65), (0.29, 5.3), (0.12, 5.65), (0.21, 5.65), (0.21, 5.8), stroke: 0.8pt)
  content((0.05, 6.9), text(size: 7pt)[$M_t$], anchor: "south")

  // --- Albero a gradini (metà superiore in vista/sezione) ---
  // Tratto 1 (estremo sinistro)
  line((0.6, 5.8), (0.6, 6.35), (1.35, 6.35), (1.35, 5.8), stroke: 1pt)
  line((0.68, 5.8), (0.68, 6.35), stroke: 0.6pt)
  line((0.6, 6.3), (1.35, 6.3), stroke: 0.6pt)

  // Tratto 2 (filettatura / ghiera)
  line((1.35, 6.35), (1.42, 6.45), (1.75, 6.45), (1.75, 5.8), stroke: 1pt)
  // Guarnizione a labbro (in 1.42..1.70, y=6.45..7.1)
  line((1.42, 6.45), (1.42, 7.1), (1.75, 7.1), (1.75, 6.45), stroke: 0.8pt)
  circle((1.56, 6.62), radius: 0.08, stroke: 0.6pt)
  circle((1.56, 6.62), radius: 0.04, stroke: 0.5pt)
  line((1.47, 6.45), (1.47, 6.78), (1.68, 6.78), (1.68, 7.1), stroke: 0.6pt)

  // Ghiera / distanziale prima del cuscinetto A
  line((1.75, 6.62), (2.22, 6.62), (2.22, 5.8), stroke: 1pt)
  line((1.95, 5.8), (1.95, 6.82), (2.22, 6.82), stroke: 0.8pt)
  line((1.75, 6.55), (1.95, 6.55), stroke: 0.6pt)
  // Tratteggio distanziale
  line((1.98, 6.62), (2.15, 6.79), stroke: 0.5pt)
  line((2.08, 6.62), (2.22, 6.76), stroke: 0.5pt)

  // Cuscinetto A (centro x = 2.5, y = 7.02)
  // Anello interno
  line((2.22, 6.65), (2.78, 6.65), (2.78, 6.88), (2.22, 6.88), close: true, stroke: 0.8pt)
  line((2.22, 6.65), (2.22, 5.8), stroke: 0.8pt)
  line((2.78, 6.65), (2.78, 5.8), stroke: 0.8pt)
  // Tratteggio anello interno A
  line((2.25, 6.65), (2.48, 6.88), stroke: 0.5pt)
  line((2.40, 6.65), (2.63, 6.88), stroke: 0.5pt)
  line((2.55, 6.65), (2.78, 6.88), stroke: 0.5pt)
  // Sfera A
  circle((2.5, 7.02), radius: 0.22, fill: white, stroke: 0.8pt)
  line((2.22, 7.02), (2.78, 7.02), stroke: (dash: "dashed", thickness: 0.5pt))
  line((2.5, 6.75), (2.5, 7.30), stroke: (dash: "dashed", thickness: 0.5pt))
  // Anello esterno A
  line((2.22, 7.16), (2.78, 7.16), (2.78, 7.36), (2.22, 7.36), close: true, stroke: 0.8pt)
  line((2.25, 7.16), (2.45, 7.36), stroke: 0.5pt)
  line((2.42, 7.16), (2.62, 7.36), stroke: 0.5pt)
  line((2.58, 7.16), (2.78, 7.36), stroke: 0.5pt)

  // Tratto centrale dell'albero tra A e B (x = 2.78 .. 4.50)
  line((2.78, 6.65), (4.50, 6.65), stroke: 1pt)
  line((2.78, 6.80), (3.12, 6.80), (3.12, 6.65), stroke: 0.8pt)
  line((3.12, 6.82), (4.20, 6.82), (4.20, 6.65), stroke: 0.8pt)
  line((4.20, 6.80), (4.50, 6.80), stroke: 0.8pt)
  line((3.12, 6.65), (3.12, 5.8), stroke: 0.6pt)
  line((4.20, 6.65), (4.20, 5.8), stroke: 0.6pt)
  // Tratteggio boccole/spallamenti tra A e B
  line((2.82, 6.65), (2.97, 6.80), stroke: 0.5pt)
  line((2.96, 6.65), (3.11, 6.80), stroke: 0.5pt)
  line((3.20, 6.65), (3.37, 6.82), stroke: 0.5pt)
  line((3.40, 6.65), (3.57, 6.82), stroke: 0.5pt)
  line((3.60, 6.65), (3.77, 6.82), stroke: 0.5pt)
  line((3.80, 6.65), (3.97, 6.82), stroke: 0.5pt)
  line((4.00, 6.65), (4.17, 6.82), stroke: 0.5pt)
  line((4.25, 6.65), (4.40, 6.80), stroke: 0.5pt)

  // Cuscinetto B (centro x = 4.8, y = 7.12)
  // Anello interno B
  line((4.50, 6.72), (5.08, 6.72), (5.08, 6.96), (4.50, 6.96), close: true, stroke: 0.8pt)
  line((4.50, 6.72), (4.50, 5.8), stroke: 0.8pt)
  line((5.08, 6.72), (5.08, 5.8), stroke: 0.8pt)
  line((4.55, 6.72), (4.79, 6.96), stroke: 0.5pt)
  line((4.72, 6.72), (4.96, 6.96), stroke: 0.5pt)
  line((4.88, 6.72), (5.08, 6.92), stroke: 0.5pt)
  // Sfera B
  circle((4.8, 7.12), radius: 0.22, fill: white, stroke: 0.8pt)
  line((4.50, 7.12), (5.08, 7.12), stroke: (dash: "dashed", thickness: 0.5pt))
  line((4.8, 6.85), (4.8, 7.40), stroke: (dash: "dashed", thickness: 0.5pt))
  // Anello esterno B
  line((4.50, 7.26), (5.08, 7.26), (5.08, 7.46), (4.50, 7.46), close: true, stroke: 0.8pt)
  line((4.55, 7.26), (4.75, 7.46), stroke: 0.5pt)
  line((4.72, 7.26), (4.92, 7.46), stroke: 0.5pt)
  line((4.88, 7.26), (5.08, 7.46), stroke: 0.5pt)

  // Coperchio sinistro della cassa
  line((1.42, 7.1), (1.62, 7.1), (1.62, 8.2), (1.80, 8.2), (1.80, 7.36), (2.22, 7.36), (2.22, 7.22), (1.95, 7.22), (1.95, 7.1), close: true, stroke: 0.8pt)
  line((1.35, 7.82), (2.15, 7.82), stroke: (dash: "dashed", thickness: 0.6pt))
  // Tratteggio coperchio
  line((1.42, 7.25), (1.80, 7.63), stroke: 0.5pt)
  line((1.42, 7.50), (1.80, 7.88), stroke: 0.5pt)
  line((1.62, 7.95), (1.80, 8.13), stroke: 0.5pt)
  line((1.80, 7.38), (2.05, 7.63), stroke: 0.5pt)

  // Corpo principale della cassa (sezione tratteggiata a 45°)
  line((1.80, 8.2), (1.80, 8.95), (2.35, 8.98), (3.10, 8.85), (3.85, 8.92), (4.65, 9.08), (5.05, 9.15), (5.18, 9.15), (5.18, 7.46), (4.50, 7.46), (4.50, 7.92), (3.15, 7.92), (3.15, 7.36), (2.22, 7.36), (2.22, 7.52), (1.80, 7.52), close: true, stroke: 0.9pt)

  // Tratteggio a 45° della cassa
  line((1.80, 8.60), (2.15, 8.95), stroke: 0.5pt)
  line((1.80, 8.25), (2.50, 8.95), stroke: 0.5pt)
  line((1.80, 7.90), (2.82, 8.92), stroke: 0.5pt)
  line((1.80, 7.55), (3.12, 8.87), stroke: 0.5pt)
  line((2.15, 7.52), (3.48, 8.88), stroke: 0.5pt)
  line((2.35, 7.36), (3.85, 8.86), stroke: 0.5pt)
  line((2.70, 7.36), (4.25, 8.91), stroke: 0.5pt)
  line((3.05, 7.36), (3.15, 7.46), stroke: 0.5pt)
  line((3.60, 7.92), (4.72, 9.04), stroke: 0.5pt)
  line((3.95, 7.92), (5.15, 9.12), stroke: 0.5pt)
  line((4.30, 7.92), (5.18, 8.80), stroke: 0.5pt)
  line((4.50, 7.77), (5.18, 8.45), stroke: 0.5pt)
  line((4.55, 7.46), (5.18, 8.09), stroke: 0.5pt)
  line((4.90, 7.46), (5.18, 7.74), stroke: 0.5pt)

  // Elemento C a sbalzo a destra
  line((5.08, 6.92), (5.40, 6.92), (5.40, 8.02), (6.30, 8.02), (6.30, 5.8), stroke: 1pt)
  line((5.40, 6.92), (5.40, 5.8), stroke: 0.8pt)
  line((5.22, 6.92), (5.22, 7.82), (5.40, 7.82), stroke: 0.8pt)
  line((5.40, 7.95), (6.30, 7.95), stroke: 0.6pt)
  line((5.15, 7.90), (6.60, 7.90), stroke: (dash: "dashed", thickness: 0.6pt))

  // Etichette A, B, C sull'albero (con linee di richiamo per A e B)
  content((2.5, 7.80), text(size: 7pt)[$A$], anchor: "south")
  content((4.75, 7.88), text(size: 7pt)[$B$], anchor: "south")
  content((5.85, 7.05), text(size: 7pt)[$C$], anchor: "center")

  // --- Schema statico (trave) ---
  line((0.6, 4.2), (5.85, 4.2), stroke: 1.2pt)

  // Appoggio A (carrello / cerniera)
  circle((2.5, 4.13), radius: 0.07, fill: white, stroke: 0.8pt)
  line((2.5, 4.06), (2.36, 3.82), (2.64, 3.82), close: true, stroke: 0.8pt)
  line((2.28, 3.75), (2.72, 3.75), stroke: 0.8pt)

  // Appoggio B (cerniera)
  circle((4.8, 4.13), radius: 0.07, fill: white, stroke: 0.8pt)
  line((4.8, 4.06), (4.66, 3.82), (4.94, 3.82), close: true, stroke: 0.8pt)
  line((4.58, 3.75), (5.02, 3.75), stroke: 0.8pt)

  // Forza F in C
  line((5.85, 5.3), (5.85, 4.2), mark: (end: ">", fill: black), stroke: 1pt)
  content((6.0, 4.9), text(size: 7pt)[$F$], anchor: "west")

  // Etichette A, B, C sullo schema trave
  content((2.25, 4.55), text(size: 7pt)[$A$], anchor: "center")
  content((5.0, 4.55), text(size: 7pt)[$B$], anchor: "center")
  content((6.02, 3.98), text(size: 7pt)[$C$], anchor: "center")

  // --- Quote L e a ---
  line((2.5, 3.15), (4.8, 3.15), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((3.65, 3.25), text(size: 7pt)[$L$], anchor: "south")

  line((4.8, 3.15), (5.85, 3.15), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((5.32, 3.25), text(size: 7pt)[$a$], anchor: "south")

  // --- Diagramma del momento torcente Mt ---
  rect((0.6, 1.45), (5.85, 2.1), stroke: 1pt)
  // Tratteggio verticale interno
  line((0.75, 1.45), (0.75, 2.1), stroke: 0.5pt)
  line((0.90, 1.45), (0.90, 2.1), stroke: 0.5pt)
  line((1.05, 1.45), (1.05, 2.1), stroke: 0.5pt)
  line((1.20, 1.45), (1.20, 2.1), stroke: 0.5pt)
  line((1.35, 1.45), (1.35, 2.1), stroke: 0.5pt)
  line((1.50, 1.45), (1.50, 2.1), stroke: 0.5pt)
  line((1.65, 1.45), (1.65, 2.1), stroke: 0.5pt)
  line((1.80, 1.45), (1.80, 2.1), stroke: 0.5pt)
  line((1.95, 1.45), (1.95, 2.1), stroke: 0.5pt)
  line((2.10, 1.45), (2.10, 2.1), stroke: 0.5pt)
  line((2.25, 1.45), (2.25, 2.1), stroke: 0.5pt)
  line((2.40, 1.45), (2.40, 2.1), stroke: 0.5pt)
  line((2.50, 1.45), (2.50, 2.1), stroke: 0.5pt)
  line((2.65, 1.45), (2.65, 2.1), stroke: 0.5pt)
  line((2.80, 1.45), (2.80, 2.1), stroke: 0.5pt)
  line((2.95, 1.45), (2.95, 2.1), stroke: 0.5pt)
  line((3.10, 1.45), (3.10, 2.1), stroke: 0.5pt)
  line((3.25, 1.45), (3.25, 2.1), stroke: 0.5pt)
  line((3.40, 1.45), (3.40, 2.1), stroke: 0.5pt)
  line((3.55, 1.45), (3.55, 2.1), stroke: 0.5pt)
  line((3.70, 1.45), (3.70, 2.1), stroke: 0.5pt)
  line((3.85, 1.45), (3.85, 2.1), stroke: 0.5pt)
  line((4.00, 1.45), (4.00, 2.1), stroke: 0.5pt)
  line((4.15, 1.45), (4.15, 2.1), stroke: 0.5pt)
  line((4.30, 1.45), (4.30, 2.1), stroke: 0.5pt)
  line((4.45, 1.45), (4.45, 2.1), stroke: 0.5pt)
  line((4.60, 1.45), (4.60, 2.1), stroke: 0.5pt)
  line((4.75, 1.45), (4.75, 2.1), stroke: 0.5pt)
  line((4.90, 1.45), (4.90, 2.1), stroke: 0.5pt)
  line((5.05, 1.45), (5.05, 2.1), stroke: 0.5pt)
  line((5.20, 1.45), (5.20, 2.1), stroke: 0.5pt)
  line((5.35, 1.45), (5.35, 2.1), stroke: 0.5pt)
  line((5.50, 1.45), (5.50, 2.1), stroke: 0.5pt)
  line((5.65, 1.45), (5.65, 2.1), stroke: 0.5pt)
  line((5.75, 1.45), (5.75, 2.1), stroke: 0.5pt)
  content((6.0, 1.77), text(size: 7pt)[$M_t$], anchor: "west")

  // --- Diagramma del momento flettente Mf ---
  line((0.6, 0.85), (5.85, 0.85), stroke: 1pt)
  line((2.5, 0.85), (4.8, 0.0), (5.85, 0.85), stroke: 1pt)
  // Tratteggio verticale interno Mf
  line((2.65, 0.85), (2.65, 0.79), stroke: 0.5pt)
  line((2.80, 0.85), (2.80, 0.74), stroke: 0.5pt)
  line((2.95, 0.85), (2.95, 0.68), stroke: 0.5pt)
  line((3.10, 0.85), (3.10, 0.63), stroke: 0.5pt)
  line((3.25, 0.85), (3.25, 0.57), stroke: 0.5pt)
  line((3.40, 0.85), (3.40, 0.52), stroke: 0.5pt)
  line((3.55, 0.85), (3.55, 0.46), stroke: 0.5pt)
  line((3.70, 0.85), (3.70, 0.41), stroke: 0.5pt)
  line((3.85, 0.85), (3.85, 0.35), stroke: 0.5pt)
  line((4.00, 0.85), (4.00, 0.30), stroke: 0.5pt)
  line((4.15, 0.85), (4.15, 0.24), stroke: 0.5pt)
  line((4.30, 0.85), (4.30, 0.18), stroke: 0.5pt)
  line((4.45, 0.85), (4.45, 0.13), stroke: 0.5pt)
  line((4.60, 0.85), (4.60, 0.07), stroke: 0.5pt)
  line((4.70, 0.85), (4.70, 0.04), stroke: 0.5pt)
  line((4.80, 0.85), (4.80, 0.00), stroke: 0.5pt)
  line((4.90, 0.85), (4.90, 0.08), stroke: 0.5pt)
  line((5.02, 0.85), (5.02, 0.18), stroke: 0.5pt)
  line((5.15, 0.85), (5.15, 0.28), stroke: 0.5pt)
  line((5.28, 0.85), (5.28, 0.39), stroke: 0.5pt)
  line((5.40, 0.85), (5.40, 0.49), stroke: 0.5pt)
  line((5.52, 0.85), (5.52, 0.58), stroke: 0.5pt)
  line((5.65, 0.85), (5.65, 0.69), stroke: 0.5pt)
  line((5.75, 0.85), (5.75, 0.77), stroke: 0.5pt)
  content((6.0, 0.55), text(size: 7pt)[$M_f$], anchor: "west")


  // ==========================================
  // PANNELLO 2 (DESTRA)
  // ==========================================

  // --- Linee di proiezione verticali ---
  line((8.1, 7.6), (8.1, 1.0), stroke: 0.6pt)
  line((12.5, 7.6), (12.5, 0.48), stroke: 0.6pt)
  line((14.2, 7.6), (14.2, 1.0), stroke: 0.6pt)

  // --- Asse dell'albero (tratteggiato) ---
  line((7.4, 7.0), (15.1, 7.0), stroke: (dash: "dashed", thickness: 0.6pt))

  // --- Punti neri sull'asse dell'albero ---
  circle((8.1, 7.0), radius: 0.08, fill: black)
  circle((14.2, 7.0), radius: 0.08, fill: black)
  content((7.75, 6.7), text(size: 7pt)[$A$], anchor: "center")
  content((14.45, 6.75), text(size: 7pt)[$B$], anchor: "center")

  // --- Albero e componenti (metà superiore) ---
  // Estremo sinistro e cuscinetto A (con simbolo X)
  line((7.6, 7.0), (7.6, 7.52), (7.83, 7.52), (7.83, 7.0), stroke: 1pt)
  line((7.66, 7.0), (7.66, 7.52), stroke: 0.8pt)
  line((7.72, 7.0), (7.72, 7.62), (7.83, 7.62), stroke: 0.8pt)
  line((7.83, 7.60), (8.37, 7.60), stroke: 1pt)
  // Cuscinetto A (rettangolo con croce di Sant'Andrea)
  rect((7.83, 7.60), (8.37, 8.28), stroke: 0.8pt)
  line((7.83, 7.60), (8.37, 8.28), stroke: 0.6pt)
  line((7.83, 8.28), (8.37, 7.60), stroke: 0.6pt)

  // Corpo centrale dell'albero tra A e C
  line((8.37, 7.0), (8.37, 7.60), (12.10, 7.60), (12.10, 7.0), stroke: 1pt)

  // Tratto sotto l'elemento C e fino a B
  line((12.10, 7.68), (13.93, 7.68), (13.93, 7.0), stroke: 1pt)
  line((12.10, 7.60), (12.10, 7.72), (12.90, 7.72), (12.90, 7.68), stroke: 0.8pt)

  // Mozzo / puleggia in C (x = 12.10 .. 12.90)
  rect((12.10, 7.72), (12.90, 8.60), stroke: 0.8pt)
  line((12.10, 8.38), (12.90, 8.38), stroke: 0.6pt)
  line((12.10, 8.50), (12.90, 8.50), stroke: 0.6pt)
  // Tratteggio a 45° sul mozzo C (tra y=7.72 e y=8.38)
  line((12.10, 8.15), (12.33, 8.38), stroke: 0.5pt)
  line((12.10, 7.92), (12.56, 8.38), stroke: 0.5pt)
  line((12.12, 7.72), (12.78, 8.38), stroke: 0.5pt)
  line((12.35, 7.72), (12.90, 8.27), stroke: 0.5pt)
  line((12.58, 7.72), (12.90, 8.04), stroke: 0.5pt)
  line((12.80, 7.72), (12.90, 7.82), stroke: 0.5pt)

  // Cuscinetto B (rettangolo con croce di Sant'Andrea, x = 13.93 .. 14.47)
  line((13.93, 7.60), (14.47, 7.60), stroke: 1pt)
  rect((13.93, 7.60), (14.47, 8.35), stroke: 0.8pt)
  line((13.93, 7.60), (14.47, 8.35), stroke: 0.6pt)
  line((13.93, 8.35), (14.47, 7.60), stroke: 0.6pt)

  // Estremo destro dopo B (ghiera e spallamento)
  line((14.47, 7.0), (14.47, 7.68), (14.92, 7.68), (14.92, 7.0), stroke: 1pt)
  rect((14.47, 7.68), (14.78, 7.95), stroke: 0.7pt)
  line((14.47, 7.82), (14.78, 7.82), stroke: 0.6pt)
  line((14.55, 7.68), (14.68, 7.82), stroke: 0.5pt)

  // --- Schema statico (trave appoggiata) ---
  line((8.1, 4.6), (14.2, 4.6), stroke: 1.2pt)

  // Appoggio A
  circle((8.1, 4.6), radius: 0.10, fill: white, stroke: 0.9pt)
  line((8.1, 4.50), (7.94, 4.22), (8.26, 4.22), close: true, stroke: 0.9pt)
  line((7.86, 4.18), (8.34, 4.18), stroke: 1.2pt)
  content((7.75, 4.6), text(size: 7pt)[$A$], anchor: "center")

  // Appoggio B
  circle((14.2, 4.6), radius: 0.10, fill: white, stroke: 0.9pt)
  line((14.2, 4.50), (14.04, 4.22), (14.36, 4.22), close: true, stroke: 0.9pt)
  line((13.96, 4.18), (14.44, 4.18), stroke: 1.2pt)
  content((14.52, 4.65), text(size: 7pt)[$B$], anchor: "center")

  // Forza F in C
  line((12.5, 5.8), (12.5, 4.6), mark: (end: ">", fill: black), stroke: 1pt)
  content((12.62, 5.35), text(size: 7pt)[$F$], anchor: "west")
  content((12.65, 4.38), text(size: 7pt)[$C$], anchor: "center")

  // --- Asse x e Quote a, b, L ---
  line((8.1, 3.92), (9.6, 3.92), mark: (end: ">"), stroke: 0.7pt)
  content((9.1, 4.02), text(size: 7pt)[$x$], anchor: "south")

  line((8.1, 3.52), (12.5, 3.52), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((10.3, 3.60), text(size: 7pt)[$a$], anchor: "south")

  line((12.5, 3.52), (14.2, 3.52), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((13.35, 3.60), text(size: 7pt)[$b$], anchor: "south")

  line((8.1, 3.00), (14.2, 3.00), mark: (start: ">", end: ">"), stroke: 0.7pt)
  content((11.15, 3.08), text(size: 7pt)[$L$], anchor: "south")

  // --- Linea elastica (deformata) ---
  // Linea orizzontale indeformata
  line((8.1, 1.0), (14.2, 1.0), stroke: 0.7pt)

  // Arco di cerchio della linea elastica
  arc((11.15, 7.83), start: 245.94deg, stop: 294.06deg, radius: 7.48, anchor: "origin", stroke: 1.2pt)

  // Tangenti agli estremi e angoli phi_A, phi_B
  line((8.1, 1.0), (9.2, 0.51), stroke: 0.6pt)
  arc((8.1, 1.0), start: 336deg, stop: 360deg, radius: 0.65, anchor: "origin", mark: (end: ">"), stroke: 0.6pt)
  content((8.32, 0.68), text(size: 7pt)[$phi_A$], anchor: "center")

  line((14.2, 1.0), (13.1, 0.51), stroke: 0.6pt)
  arc((14.2, 1.0), start: 180deg, stop: 204deg, radius: 0.65, anchor: "origin", mark: (start: ">"), stroke: 0.6pt)
  content((14.12, 0.68), text(size: 7pt)[$phi_B$], anchor: "center")

  // Freccia delta_C in corrispondenza di x = 12.5
  content((12.55, 1.40), text(size: 7pt)[$delta_C$], anchor: "center")
}))

== Dimensionamento preliminare e processo iterativo
Con riferimento allo schema statico con organo (es. ingranaggio) calettato all'estremità a sbalzo $C$, la forza trasversale $F$ scambiata tra i denti genera un diagramma del momento flettente $M_f$ lineare (triangolare) con massimo sul supporto intermedio $B$. Contemporaneamente, la coppia torcente $M_t$ introdotta in $C$ percorre l'albero fino all'estremità opposta $A$ collegata all'utenza (o al motore), generando un diagramma di momento torcente costante su tutta la lunghezza attiva tra ingresso e uscita di potenza.

Delineato lo schema delle forze, si calcolano i momenti flettenti nei due piani ortogonali ottenendo il momento flettente totale risultante $M_f = sqrt(M_x^2 + M_y^2)$. Per alberi in acciaio duttile, il predimensionamento adotta il criterio di Tresca (massima tensione tangenziale):
$ sigma_(i d) = sqrt(sigma^2 + 4 tau^2) = sqrt((M_f / W_f)^2 + 4 (M_t / W_t)^2) $

Per una sezione circolare piena di diametro $D$, il momento d'inerzia polare $I_p = (pi D^4) / 32$ è doppio rispetto a quello assiale $I = (pi D^4) / 64$; dividendo per il raggio esterno $R = D / 2$, il modulo di resistenza a torsione risulta doppio di quello a flessione ($W_t = (pi D^3) / 16 = 2 W_f$, con $W_f = (pi D^3) / 32$), semplificando la tensione ideale in:
$ sigma_(i d) = 1 / W_f sqrt(M_f^2 + M_t^2) $

Imponendo la condizione limite $sigma_(i d) <= sigma_"amm"$, si ricava il modulo di resistenza a flessione minimo necessario e il diametro minimo teorico:
$ W_f = 1 / sigma_"amm" sqrt(M_f^2 + M_t^2) = (pi D^3) / 32 quad arrow.r.double quad D_"min" = (32 / (pi sigma_"amm") sqrt(M_f^2 + M_t^2))^(1/3) $

Aspetti normativi e metodologici del progetto diretto:
- *Indipendenza delle sollecitazioni dalla geometria trasversale:* in uno schema isostatico (trascurando in prima approssimazione il peso proprio dell'albero rispetto alle forze esterne degli organi), i diagrammi di $M_f$ e $M_t$ dipendono solo dai carichi esterni e dalle distanze assiali tra supporti e organi, risultando *indipendenti dal diametro $D$* e tracciabili prima di definire la sezione.
- *Confronto Tresca vs Von Mises:* Von Mises presenta un coefficiente $3$ anziché $4$ sulla tensione tangenziale ($sigma_(i d, "VM") = sqrt(sigma^2 + 3 tau^2)$). Sebbene la scelta dipenda dalla normativa di riferimento, Tresca è preferito nel predimensionamento poiché fornisce una stima leggermente superiore (più cautelativa) della tensione ideale, garantendo una sezione preliminare più robusta.
- *Giustificazione del coefficiente di sicurezza $C S = 10$:* mentre una verifica puramente statica usa coefficienti modesti ($C S approx 1.5 - 2$ per la contenuta incertezza su carichi e materiale), il predimensionamento dell'albero usa una procedura formalmente statica con margine volutamente esasperato ($C S = 10$ o valore normativo analogo) per compensare preventivamente il severo abbattimento di resistenza dovuto a *fatica* e *intagli*. Partire da una sezione sovradimensionata rispetto alla statica fa convergere il progetto in sole $2 - 3$ iterazioni.
- *Tensione limite vs tensione ammissibile ($sigma_"amm"$):* la *tensione limite* è la proprietà intrinseca del materiale (es. $R_m$ o $R_(p 0.2)$), mentre la *tensione ammissibile* ($sigma_"amm" = sigma_"lim" / (C S)$, es. $R_m / (C S)$) include già il coefficiente di sicurezza. Se una norma o tabella fornisce direttamente $sigma_"amm"$, non si deve dividere ulteriormente per $C S$, ma solo imporre $sigma_(i d) <= sigma_"amm"$.
- *Applicazione per tratti ed effetto degli intagli:* la formula di $D_"min"$ si applica alla sezione più sollecitata di ciascun tratto a diametro costante. Poiché l'alloggiamento degli accessori impone variazioni di sezione (spallamenti a raggio stretto, cave per chiavette/linguette, filettature) che agiscono da intagli, i fattori di concentrazione delle tensioni ($K_t$, $K_f$) possono spostare la sezione critica: una sezione intagliata, pur soggetta a momenti nominali $M_f$ e $M_t$ *inferiori* rispetto al picco dei diagrammi, può sviluppare tensioni locali amplificate molto più gravose, governando il dimensionamento. La riverifica a fatica va quindi estesa sistematicamente a tutte le discontinuità geometriche.

=== Disegno della struttura e calcoli di verifica per il dimensionamento finale
Stimati i diametri preliminari $D_"min"$, si esegue il *disegno costruttivo dell'albero* definendo variazioni di sezione, *raggi di raccordo* e *finiture superficiali*, intrecciando il progetto con i componenti accessori:
- *Vincoli da catalogo cuscinetti:* condizionano il *diametro dei perni* (coincidente coi diametri interni normalizzati a catalogo, es. multipli di $5 "mm"$) e l'altezza e il *raggio di raccordo degli spallamenti* (il raggio sul fondo dello spallamento deve essere inferiore allo smusso dell'anello interno a catalogo per garantire il corretto appoggio assiale contro la parete verticale).
- *Compatibilità con gli organi di trasmissione:* le geometrie dei mozzi di ruote dentate, pulegge e volani sono definite in compatibilità con le sedi dell'albero.

Definita la geometria completa, il processo iterativo si chiude con i *calcoli di verifica finale* lungo quattro direttrici:
1. *Verifiche statiche:* controllo del non superamento dei limiti statici (rottura e, per materiali duttili, *snervamento*) nelle sezioni più sollecitate sotto i carichi massimi o di picco.
2. *Verifiche a rigidezza (deformabilità stazionaria):* controllo tramite l'equazione della linea elastica che frecce flessionali $delta$ e rotazioni angolari $phi$ rientrino nei limiti ammissibili per i cuscinetti, per il corretto ingranamento delle ruote dentate e per scongiurare il contatto fisico rotore-statore.
   - *Nota progettuale:* se un albero in acciaio non supera la verifica a rigidezza, *è inutile sostituire il materiale con un acciaio più pregiato o ad alta resistenza*. Tutti gli acciai appartengono alla stessa classe elastica con identico modulo di Young ($E approx 210 "GPa"$): dipendendo la rigidezza flessionale da $E I$, per ridurre frecce e rotazioni è indispensabile *modificare la geometria* (aumentare i diametri per incrementare $I = (pi D^4) / 64$, o ridurre la distanza tra i supporti).
3. *Verifiche a fatica:* valutazione della resistenza a durata (vita infinita o a termine) nelle sezioni critiche a flessione rotante e torsione.
   - *Nota progettuale:* risultano determinanti la *forma locale degli intagli* (raggi di raccordo agli spallamenti, cave per linguette, gole di scarico), la *finitura superficiale* (rugosità da lavorazione) e i *trattamenti superficiali* (pallinatura, nitrurazione, cementazione, tempra superficiale), che incidono talora *quasi più del materiale base selezionato*.
4. *Verifiche di risposta dinamica:* controllo dell'assenza di risonanze (velocità critiche) nel campo operativo e del margine rispetto alla soglia di instabilità dinamica, in cui sono cruciali lo *smorzamento interno del materiale* e la rigidezza/smorzamento dei *supporti*.

Solo il superamento congiunto di tutte le verifiche determina univocamente forma, dimensioni, materiale e trattamenti termici/superficiali dell'albero.