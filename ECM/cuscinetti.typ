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

= *Cuscinetti a corpi volventi *

== Introduzione e Funzione dei Cuscinetti
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Un elemento fondamentale nella trasmissione di potenza e nel supporto degli alberi di trasmissione è il cuscinetto a corpi volventi. A differenza di altri organi di macchine che vengono progettati ad hoc per specifiche applicazioni, i cuscinetti sono prodotti commerciali standardizzati. Vengono realizzati dai costruttori in diverse taglie e architetture, e il progettista li seleziona direttamente da catalogo in base ai parametri di progetto, ai calcoli di durata e alle prestazioni richieste.

],[
#image("Albero e cuscinetti.png",width:80%)
])
Lo scopo principale del cuscinetto è quello di permettere la rotazione relativa di un componente (generalmente un albero, ovvero il rotore) rispetto ad un altro (l'alloggiamento o statore), evitando l'attrito di strisciamento. Nelle bronzine, ad esempio, l'interposizione di un materiale soggetto a frizione genera una notevole dissipazione di energia e un'usura rapida. Nei cuscinetti volventi, invece, il moto relativo avviene tramite il libero rotolamento di appositi corpi volventi all'interno di piste dedicate. Questa condizione offre una resistenza alla rotazione nettamente inferiore, paragonabile concettualmente all'attrito di puro rotolamento che si instaura tra lo pneumatico di un autoveicolo e il manto stradale.
=== Componenti e Geometria
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, right + horizon),[Un cuscinetto a corpi volventi è un sistema composto da elementi ben precisi:
- #strong[Anello interno:] è solitamente solidale alla parte in rotazione (l'albero). La superficie rivolta verso l'esterno funge da pista di rotolamento.
- #strong[Anello esterno:] è generalmente solidale alla parte fissa (l'alloggiamento o statore). La sua superficie interna costituisce la pista esterna.
- #strong[Corpi volventi:] possono essere sfere, rulli o rullini. Costituiscono una o più corone e hanno il compito di trasmettere le sollecitazioni meccaniche (forze e momenti) rotolando sulle piste.
],[
#image("sezione cuscinetto.png")
])
- #strong[Gabbia rotante:] è una struttura che ha la funzione fondamentale di mantenere i corpi volventi equidistanziati lungo la direzione circonferenziale. Evita che i corpi volventi entrino in contatto reciproco sfregando tra loro e garantisce che il carico si distribuisca uniformemente, impedendo l'addensamento degli elementi in una singola porzione della circonferenza. La gabbia è solidale al set di corpi volventi e ruota con essi.
- #strong[Schermi e Guarnizioni:] elementi laterali che servono a trattenere il lubrificante (olio o, più frequentemente, grasso) nella regione di contatto e a proteggere i meccanismi interni dalla contaminazione di sporco e detriti provenienti dall'ambiente di lavoro.
Le superfici di contatto tra piste e corpi volventi possiedono curvature specifiche. La curvatura della pista avvolge il corpo volvente (soprattutto nel caso delle sfere) ma presenta un raggio leggermente superiore rispetto a quello del corpo volvente stesso. Le superfici non aderiscono completamente in tutti i punti, sebbene la differenza tra i raggi di curvatura sia contenuta.

=== Fasi di Assemblaggio
Il processo di assemblaggio di un classico cuscinetto radiale a sfere sfrutta la deformabilità elastica dei materiali. Inizialmente, l'anello interno viene posizionato concentricamente all'interno dell'anello esterno. I corpi volventi vengono inseriti uno ad uno nello spazio compreso tra le due piste e raggruppati da un solo lato della circonferenza. 
Per inserire le ultime sfere e chiudere il sistema, si applica una forza che deforma e ovalizza moderatamente l'anello esterno, senza oltrepassare il limite elastico del materiale. Questa deformazione crea il gioco necessario per permettere all'anello interno di sfilare leggermente e accogliere i corpi restanti. Successivamente, le sfere vengono distribuite in modo uniforme lungo l'intera circonferenza. Infine, le due semiparti della gabbia vengono accostate dai lati opposti e vincolate tra loro (ad esempio tramite rivettatura), imprigionando le sfere e fissandone la distanza relativa.

== Criteri di Scelta e Tipologie di Carico
La scelta del tipo di cuscinetto è dettata da fattori spaziali, dalle velocità massime di rotazione e, soprattutto, dalla direzione del carico applicato. I carichi si dividono in:
- #strong[Radiale:] forza diretta perpendicolarmente all'asse di rotazione.
- #strong[Assiale:] forza diretta parallelamente all'asse di rotazione.
- #strong[Combinato:] azione simultanea di forze radiali e assiali.
- #strong[Momenti flettenti:] sollecitazioni che tendono a far ruotare e disassare l'anello interno rispetto a quello esterno (ribaltamento).

=== Cuscinetti per Carichi Radiali
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Il cuscinetto radiale a sfere è simmetrico rispetto al piano diametrale e nasce per sopportare spinte radiali. Tuttavia, grazie alla curvatura avvolgente delle piste, è in grado di gestire carichi assiali moderati. Se, ad esempio, l'albero subisce una dilatazione termica, si genera una spinta laterale. La sfera viene premuta contro un lato della pista interna e trasferisce la pressione sul lato opposto della pista esterna, creando una reazione inclinata senza smontare il sistema, purché il carico resti moderato.

],[

#image("radiale.png")
])
Per carichi radiali molto elevati, si utilizzano i #strong[cuscinetti a rulli cilindrici]. In questo caso il contatto è di tipo lineare (lungo una generatrice del cilindro), permettendo di distribuire pressioni molto superiori rispetto al contatto puntuale della sfera. Il comportamento assiale di questi cuscinetti dipende dai bordini degli anelli:
- Se l'anello esterno possiede i bordini e l'anello interno ne è privo, il cuscinetto permette lo scorrimento assiale relativo. Questo è utilissimo per assecondare le dilatazioni termiche dell'albero senza generare tensioni assiali parassite.
- Se entrambi gli anelli presentano bordini, il rullo è vincolato e il cuscinetto non consente spostamenti assiali liberi.

I #strong[cuscinetti a rullini] impiegano corpi volventi cilindrici di piccolo diametro ma notevole lunghezza. Si utilizzano quando lo spazio radiale a disposizione è estremamente ridotto (alberi di grande diametro in alloggiamenti stretti) o quando si opera a velocità tali da rendere problematica la forza centrifuga delle masse volventi; il rullino, essendo di massa ridotta, mitiga questo fenomeno.

I #strong[cuscinetti a rulli orientabili a botte] presentano rulli con un profilo leggermente bombato e una pista dell'anello esterno sferica. Questa geometria garantisce un'elevata capacità di carico radiale (grazie all'estesa linea di contatto) e permette un autoadattamento in presenza di momenti flettenti o errori di allineamento dell'albero, consentendo all'anello interno di basculare senza sovraccaricare i bordi dei rulli.
#pagebreak()
=== Cuscinetti per Carichi Assiali
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Quando l'azione è unicamente assiale, l'architettura deve essere disposta perpendicolarmente all'asse del rotore. I due anelli sono montati in sequenza lungo la linea d'asse, con i corpi volventi interposti.
Se si posiziona un anello solidale al rotore e l'altro solidale allo statore, il sistema è in grado di sviluppare una reazione vincolare in un'unica direzione. ],[#image("assiale.png")])
Per gestire carichi assiali bidirezionali si ricorre a un sistema multiplo a tre anelli: un anello centrale collegato forzatamente all'albero e due anelli laterali (superiore e inferiore) vincolati allo statore. In base al verso di applicazione del carico, l'anello centrale andrà a comprimere la corona di sfere superiore o quella inferiore.

=== Cuscinetti per Carichi Combinati (Obliqui)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Per sopportare carichi cospicui che presentano simultaneamente componenti assiali e radiali, si usano i cuscinetti obliqui. Le piste sono sagomate in modo asimmetrico: su un lato presentano uno spallamento pronunciato, mentre sull'altro risultano più libere. La retta d'azione della forza di contatto tra sfere e piste risulta perciò inclinata rispetto al piano radiale.],[
#image("obliqui.png")
])
Data la loro geometria, questi cuscinetti reagiscono al carico assiale in un solo verso; un carico opposto comporterebbe lo sfilamento dell'anello privo di bordino di ritegno.
Per ottenere una reazione bidirezionale e bloccare eventuali momenti di ribaltamento, si ricorre a soluzioni a doppia corona di sfere (integrate nello stesso anello) oppure al montaggio in coppia di due cuscinetti obliqui singoli (configurazioni a "O" o ad "X").
=== Montaggio e Precarico
I cuscinetti obliqui lavorano al meglio quando sottoposti a un precarico assiale. Questo precarico forza gli anelli a chiudersi sui corpi volventi, annullando i giochi interni, distribuendo uniformemente le tensioni sulle superfici di contatto e garantendo la massima precisione meccanica della retta di azione inclinata.
Durante l'accoppiamento dei cuscinetti, il calibramento del precarico viene effettuato serrando oppurtunatamente delle ghiere filettate, le quali spingono in direzione assiale. 
Esiste una regola aurea nel montaggio (e smontaggio) dei cuscinetti: la forza di piantaggio (tramite martello e distanziali o presse) deve essere applicata esclusivamente sull'anello che va accoppiato con interferenza. Ad esempio, se si monta il cuscinetto nell'alloggiamento, si batte sull'anello esterno; se si pianta sull'albero, si batte sull'anello interno. Scaricare la forza di montaggio passando attraverso i corpi volventi genera la punzonatura delle piste, innescando precocemente fenomeni di fatica e rottura.

== Cuscinetti a Corpi Volventi - Danneggiamento
Per effettuare il calcolo di durata dei cuscinetti a corpi volventi è fondamentale analizzare le forme di cedimento e danneggiamento a cui vanno incontro durante l'esercizio. Comprendere queste fenomenologie permette di calcolare la durata in funzione dei carichi dinamici e di verificare il coefficiente di sicurezza statico.
=== Cedimento per fatica
Il cedimento principale e più tipico nei cuscinetti è il cedimento per fatica (Rolling Contact Fatigue). I corpi volventi e le piste, durante il funzionamento, sono soggetti a tensioni di contatto fortemente variabili nel tempo, poiché i punti di contatto cambiano costantemente al variare della posizione degli elementi.

Queste tensioni di contatto sono particolarmente attive nella zona subsuperficiale. L'affaticamento si manifesta con i seguenti passaggi:
- Si formano micro-cricche nel "sottopelle" delle piste (subsuperficie).
- Tali cricche propagano gradualmente verso l'esterno fino ad affiorare, causando il distacco e l'asportazione di piccole zolle di materiale dalla superficie. Questo fenomeno prende il nome di sfaldamento o #emph[flaking].
- Una volta che la regolarità della superficie è compromessa, il passaggio del corpo volvente sulla zona danneggiata provoca urti e sussulti. Ciò induce un'apprezzabile e anomala rumorosità del cuscinetto, sintomo di un incremento notevole delle vibrazioni.
- Il lubrificante, trovandosi in pressione durante il rotolamento, si insinua all'interno di queste cricche, agendo da cuneo idraulico e facilitando la rimozione di ulteriore materiale, originando il fenomeno dei crateri (#emph[pitting]).
- I detriti metallici asportati possono inserirsi nella zona di contatto tra corpi volventi e piste, portando a danni severi fino a provocare il grippaggio dei materiali.

La durata del cuscinetto, in definite condizioni di funzionamento, è definita e valutata proprio in termini di numero di giri al quale compaiono le prime cricche che affiorano in superficie. Quando la durata a fatica viene raggiunta o superata e si presentano questi sintomi, l'unico rimedio è sostituire l'intero cuscinetto, eventualmente installandone uno con una capacità di carico maggiore.

=== Cedimento per sovraccarico statico
#grid(
  columns: (1.2fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + top),[Un'altra forma di danneggiamento deriva da carichi eccessivi che agiscono quando il cuscinetto è fermo o in condizioni di bassissima velocità. Un sovraccarico statico elevato può essere dovuto a urti in esercizio, inceppamenti della linea di trasmissione, impuntamenti, carichi eccessivi allo spunto o semplicemente al peso eccessivo dell'albero in fase di montaggio. L'effetto principale di questo sovraccarico è un'indentazione o improntatura: i corpi volventi vengono premuti contro il materiale della pista causando deformazioni permanenti (plastiche), localizzate o distribuite.],[#canvas(length: 0.75cm, {
  import draw: *

  // =========================================================================
  // PANNELLO 1 (SUPERIORE)
  // =========================================================================

  // Piastra rettangolare grigia
  rect((0.00, 0.00), (6.50, 1.32), fill: luma(175), stroke: 0.8pt)

  // Sfera con effetto sfumatura radiale (cerchi concentrici)
  circle((0.64, 1.98), radius: 0.64, fill: luma(115), stroke: none)
  circle((0.63, 1.99), radius: 0.54, fill: luma(145), stroke: none)
  circle((0.62, 2.00), radius: 0.44, fill: luma(175), stroke: none)
  circle((0.61, 2.01), radius: 0.34, fill: luma(205), stroke: none)
  circle((0.60, 2.02), radius: 0.24, fill: luma(230), stroke: none)
  circle((0.59, 2.03), radius: 0.14, fill: white, stroke: none)
  // Contorno nero della sfera
  circle((0.64, 1.98), radius: 0.64, stroke: 0.8pt)

  // Due frecce rosse curve di rotazione oraria
  arc((0.64, 1.98), start: 15deg, stop: 88deg, radius: 0.45, anchor: "origin", mark: (start: ">", size: 0.16), stroke: (paint: red, thickness: 1.8pt))
  arc((0.64, 1.98), start: 195deg, stop: 268deg, radius: 0.45, anchor: "origin", mark: (start: ">", size: 0.16), stroke: (paint: red, thickness: 1.8pt))

  // Freccia nera spessa del carico verticale
  line((0.64, 3.36), (0.64, 2.75), mark: (end: ">", size: 0.22), stroke: (paint: black, thickness: 2.2pt))


  // Fascia sfumata verde/turchese dentro la sfera inferiore (disegnata prima del contorno)
  line((2.58, -2.22), (3.72, -2.22), (3.72, -1.70), (2.58, -1.70), close: true, fill: rgb(0, 180, 130).transparentize(75%), stroke: none)
  line((2.56, -2.14), (3.74, -2.14), (3.74, -1.78), (2.56, -1.78), close: true, fill: rgb(0, 180, 130).transparentize(55%), stroke: none)
  line((2.55, -2.06), (3.75, -2.06), (3.75, -1.86), (2.55, -1.86), close: true, fill: rgb(0, 180, 130).transparentize(30%), stroke: none)

  // Maschere bianche esterne per pulire il rettangolo verde fuori dal cerchio della sfera
  // (il profilo esatto della sfera è l'arco di raggio 0.60 centrato in (3.15, -1.96) + corda inferiore)
  arc((3.15, -1.96), start: -60deg, stop: 240deg, radius: 0.60, anchor: "origin", stroke: 0.8pt)
  line((2.85, -2.48), (3.45, -2.48), stroke: 0.8pt)

  // Contorno della piastra inferiore con impronta concava centrale
  // Tratto sinistro del bordo superiore, parete sinistra, base, parete destra, tratto destro del bordo superiore
  line((2.98, -2.86), (0.00, -2.86), (0.00, -4.18), (6.50, -4.18), (6.50, -2.86), (3.32, -2.86), stroke: 0.8pt)
  // Arco concavo dell'impronta al centro della pista
  arc((3.15, -2.814), start: 219.6deg, stop: 320.4deg, radius: 0.176, anchor: "origin", stroke: 0.8pt)

  // Tratteggio obliquo di sezione della piastra inferiore
  line((0.00, -3.52), (0.28, -2.86), stroke: 0.6pt)
  line((0.00, -4.18), (0.56, -2.86), stroke: 0.6pt)
  line((0.48, -4.18), (1.04, -2.86), stroke: 0.6pt)
  line((0.96, -4.18), (1.52, -2.86), stroke: 0.6pt)
  line((1.44, -4.18), (2.00, -2.86), stroke: 0.6pt)
  line((1.92, -4.18), (2.48, -2.86), stroke: 0.6pt)
  line((2.40, -4.18), (2.96, -2.86), stroke: 0.6pt)
  line((2.88, -4.18), (3.44, -2.86), stroke: 0.6pt)
  line((3.36, -4.18), (3.92, -2.86), stroke: 0.6pt)
  line((3.84, -4.18), (4.40, -2.86), stroke: 0.6pt)
  line((4.32, -4.18), (4.88, -2.86), stroke: 0.6pt)
  line((4.80, -4.18), (5.36, -2.86), stroke: 0.6pt)
  line((5.28, -4.18), (5.84, -2.86), stroke: 0.6pt)
  line((5.76, -4.18), (6.32, -2.86), stroke: 0.6pt)
  line((6.24, -4.18), (6.50, -3.57), stroke: 0.6pt)

  // Quota rossa superiore del diametro Dw
  line((2.55, -1.96), (2.55, -0.82), stroke: (paint: red, thickness: 0.7pt))
  line((3.75, -1.96), (3.75, -0.82), stroke: (paint: red, thickness: 0.7pt))
  line((2.55, -1.02), (3.75, -1.02), mark: (start: ">", end: ">", size: 0.10), stroke: (paint: red, thickness: 0.6pt))

  // Quote rosse a destra per la deformazione plastica permanente
  line((3.55, -2.48), (6.18, -2.48), stroke: (paint: red, thickness: 0.7pt))
  line((3.50, -3.00), (4.92, -3.00), stroke: (paint: red, thickness: 0.7pt))
  // Asta verticale di quota in x = 5.12
  line((5.12, -1.92), (5.12, -2.48), stroke: (paint: red, thickness: 0.5pt))
  line((5.12, -2.86), (5.12, -2.48), mark: (end: ">", size: 0.09), stroke: (paint: red, thickness: 0.5pt))
  line((5.12, -3.38), (5.12, -2.86), mark: (end: ">", size: 0.09), stroke: (paint: red, thickness: 0.5pt))

  // Etichette (tutte interne all'immagine -> ridotte con text(size: 7pt))
  content((3.15, -0.88), text(size: 7pt)[Dw], anchor: "south")
  content((5.75, -1.95), text(size: 7pt)[$D_w / 10000$], anchor: "center")
})
])

 Tali deformazioni alterano la regolarità della geometria di rotolamento, provocando vibrazioni, rumorosità, maggiore attrito e una sensibile diminuzione della durata utile del componente.

Un minimo livello di deformazione è fisicamente inevitabile quando elementi elastici sono premuti tra loro, pertanto esiste una soglia di tolleranza. La deformazione plastica ammissibile è fissata a circa $1/10000$ della dimensione del corpo volvente. A titolo di esempio, per una sfera con diametro $D_w = 10 quad [m m]$, la deformazione plastica massima tollerata equivale a $1 quad [mu m]$.

#grid(
  columns: (1.2fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[L'analisi visiva delle piste permette di diagnosticare l'origine del sovraccarico:
- Se il sovraccarico è fortemente radiale e insistente in una specifica direzione, l'improntatura sull'anello statorico sarà più ampia e severa nella regione direttamente soggetta alla forza, disperdendosi gradualmente ai lati.
- Se si applicano carichi eccessivi e opposti lungo un diametro, il cuscinetto patisce un'ovalizzazione. I segni di cedimento e le impronte si concentreranno specularmente sui due lati opposti dello stesso diametro.],[#canvas(length: 1cm, {
  import draw: *

  // =========================================================================
  // PANNELLO 1 (ALTO SINISTRA): Cuscinetto con carico distribuito sull'interno
  // Centro O1 = (0, 0)
  // =========================================================================

  // 12 sfere (disegnate per prime; le calotte vengono coperte dagli anelli)
  circle(( 0.900,  0.000), radius: 0.16, stroke: 0.5pt)
  circle(( 0.779,  0.450), radius: 0.16, stroke: 0.5pt)
  circle(( 0.450,  0.779), radius: 0.16, stroke: 0.5pt)
  circle(( 0.000,  0.900), radius: 0.16, stroke: 0.5pt)
  circle((-0.450,  0.779), radius: 0.16, stroke: 0.5pt)
  circle((-0.779,  0.450), radius: 0.16, stroke: 0.5pt)
  circle((-0.900,  0.000), radius: 0.16, stroke: 0.5pt)
  circle((-0.779, -0.450), radius: 0.16, stroke: 0.5pt)
  circle((-0.450, -0.779), radius: 0.16, stroke: 0.5pt)
  circle(( 0.000, -0.900), radius: 0.16, stroke: 0.5pt)
  circle(( 0.450, -0.779), radius: 0.16, stroke: 0.5pt)
  circle(( 0.779, -0.450), radius: 0.16, stroke: 0.5pt)

  // Maschere bianche per gli anelli (anello esterno tra r=1.04 e r=1.25; anello interno tra r=0.56 e r=0.76)
  circle((0, 0), radius: 1.145, stroke: (paint: white, thickness: 5.5pt))
  circle((0, 0), radius: 0.660, fill: white, stroke: (paint: white, thickness: 5.2pt))

  // Circonferenze degli anelli
  circle((0, 0), radius: 1.25, stroke: 0.6pt)
  circle((0, 0), radius: 1.04, stroke: 0.6pt)
  circle((0, 0), radius: 0.76, stroke: 0.6pt)
  circle((0, 0), radius: 0.56, stroke: 0.6pt)

  // Freccia curva di rotazione sull'anello interno
  arc((0, 0), start: 62deg, stop: 118deg, radius: 0.66, anchor: "origin", mark: (start: ">", size: 0.08), stroke: 0.5pt)

  // Freccia azzurra grande centrale
  line((0, 0.22), (0, -0.54), mark: (end: ">", size: 0.18), stroke: (paint: rgb(0, 150, 215), thickness: 2.4pt))

  // Piccole frecce azzurre radiali interne (da r = 0.38 a r = 0.54)
  for i in range(16) {
    if i != 12 {
      let angle = i * 22.5deg
      line(
        (angle, 0.38),
        (angle, 0.54),
        mark: (end: ">", length: 0.065, width: 0.05),
        stroke: (paint: rgb(0, 150, 215), thickness: 0.65pt)
      )
    }
  }

  // 5 frecce azzurre esterne nella zona di carico inferiore
  line(( 0.00, -1.92), ( 0.00, -1.27), mark: (end: ">", size: 0.12), stroke: (paint: rgb(0, 150, 215), thickness: 1.0pt))
  line((-1.05, -1.42), (-0.74, -1.03), mark: (end: ">", size: 0.10), stroke: (paint: rgb(0, 150, 215), thickness: 0.9pt))
  line(( 1.05, -1.42), ( 0.74, -1.03), mark: (end: ">", size: 0.10), stroke: (paint: rgb(0, 150, 215), thickness: 0.9pt))
  line((-1.48, -0.42), (-1.22, -0.34), mark: (end: ">", size: 0.09), stroke: (paint: rgb(0, 150, 215), thickness: 0.8pt))
  line(( 1.48, -0.42), ( 1.22, -0.34), mark: (end: ">", size: 0.09), stroke: (paint: rgb(0, 150, 215), thickness: 0.8pt))


  // =========================================================================
  // PANNELLO 2 (ALTO DESTRA): Anello interno cerchiato in rosso + esterno
  // =========================================================================

  // Anello interno in prospettiva (centro faccia destra in (3.62, -0.02))
  // Bordo sinistro (spalla posteriore)
  arc((3.04, -0.02), start: 90deg, stop: 270deg, radius: (0.28, 0.94), anchor: "origin", stroke: 0.5pt)
  arc((3.18, -0.02), start: 90deg, stop: 270deg, radius: (0.28, 0.94), anchor: "origin", stroke: 0.5pt)
  line((3.04,  0.92), (3.18,  0.92), stroke: 0.5pt)
  line((3.04, -0.96), (3.18, -0.96), stroke: 0.5pt)

  // Gola centrale con traccia di usura (tratteggiata/punteggiata)
  arc((3.27, -0.02), start: 95deg, stop: 265deg, radius: (0.24, 0.84), anchor: "origin", stroke: (dash: "densely-dotted", thickness: 1.8pt, paint: luma(140)))
  arc((3.32, -0.02), start: 95deg, stop: 265deg, radius: (0.24, 0.84), anchor: "origin", stroke: (dash: "dotted", thickness: 1.0pt, paint: luma(90)))
  // Raccordi della gola in alto e in basso
  arc((3.26,  0.92), start: 180deg, stop: 360deg, radius: (0.08, 0.10), anchor: "origin", stroke: 0.5pt)
  arc((3.26, -0.96), start: 0deg, stop: 180deg, radius: (0.08, 0.10), anchor: "origin", stroke: 0.5pt)

  // Spalla destra e faccia anteriore dell'anello interno
  arc((3.34, -0.02), start: 90deg, stop: 270deg, radius: (0.28, 0.94), anchor: "origin", stroke: 0.5pt)
  line((3.34,  0.92), (3.52,  0.92), stroke: 0.5pt)
  line((3.34, -0.96), (3.52, -0.96), stroke: 0.5pt)
  circle((3.52, -0.02), radius: (0.28, 0.94), fill: white, stroke: 0.5pt)
  circle((3.52, -0.02), radius: (0.18, 0.64), stroke: 0.5pt)
  arc((3.58, -0.02), start: 115deg, stop: 245deg, radius: (0.18, 0.64), anchor: "origin", stroke: 0.5pt)

  // Metà anello esterno sezionato (a destra, centro (4.65, 0.00))
  // Archi principali dalla cima al fondo (start: -90deg, stop: 90deg)
  arc((4.38, 0.00), start: -90deg, stop: 90deg, radius: (0.36, 1.14), anchor: "origin", stroke: 0.5pt)
  arc((4.48, 0.00), start: -90deg, stop: 90deg, radius: (0.38, 1.20), anchor: "origin", stroke: 0.5pt)
  // Fascia di usura sulla pista concava interna
  arc((4.58, 0.00), start: -80deg, stop: 80deg, radius: (0.40, 1.22), anchor: "origin", stroke: (dash: "densely-dotted", thickness: 2.2pt, paint: luma(140)))
  arc((4.63, 0.00), start: -85deg, stop: 85deg, radius: (0.40, 1.22), anchor: "origin", stroke: (dash: "dotted", thickness: 1.2pt, paint: luma(80)))
  // Bordo esterno anteriore e posteriore
  arc((4.78, 0.00), start: -90deg, stop: 90deg, radius: (0.44, 1.38), anchor: "origin", stroke: 0.5pt)
  arc((4.88, 0.00), start: -90deg, stop: 90deg, radius: (0.44, 1.38), anchor: "origin", stroke: 0.5pt)
  // Chiusure delle sezioni in alto e in basso
  line((4.38,  1.14), (4.26,  1.20), (4.26,  1.38), (4.88,  1.38), stroke: 0.5pt)
  line((4.38,  1.14), (4.48,  1.20), (4.68,  1.20), (4.78,  1.14), (4.78,  1.38), stroke: 0.5pt)
  line((4.38, -1.14), (4.26, -1.20), (4.26, -1.38), (4.88, -1.38), stroke: 0.5pt)
  line((4.38, -1.14), (4.48, -1.20), (4.68, -1.20), (4.78, -1.14), (4.78, -1.38), stroke: 0.5pt)

  // Cerchio/ellisse rossa attorno all'anello interno
  circle((3.28, -0.02), radius: (1.16, 1.28), stroke: (paint: red, thickness: 1.0pt))


  // =========================================================================
  // PANNELLO 3 (BASSO SINISTRA): Cuscinetto con carico fisso verticale
  // Centro O3 = (0, -3.55)
  // =========================================================================

  // 12 sfere
  circle(( 0.900, -3.550), radius: 0.16, stroke: 0.5pt)
  circle(( 0.779, -3.100), radius: 0.16, stroke: 0.5pt)
  circle(( 0.450, -2.771), radius: 0.16, stroke: 0.5pt)
  circle(( 0.000, -2.650), radius: 0.16, stroke: 0.5pt)
  circle((-0.450, -2.771), radius: 0.16, stroke: 0.5pt)
  circle((-0.779, -3.100), radius: 0.16, stroke: 0.5pt)
  circle((-0.900, -3.550), radius: 0.16, stroke: 0.5pt)
  circle((-0.779, -4.000), radius: 0.16, stroke: 0.5pt)
  circle((-0.450, -4.329), radius: 0.16, stroke: 0.5pt)
  circle(( 0.000, -4.450), radius: 0.16, stroke: 0.5pt)
  circle(( 0.450, -4.329), radius: 0.16, stroke: 0.5pt)
  circle(( 0.779, -4.000), radius: 0.16, stroke: 0.5pt)

  // Maschere bianche per gli anelli
  circle((0, -3.55), radius: 1.145, stroke: (paint: white, thickness: 5.5pt))
  circle((0, -3.55), radius: 0.660, fill: white, stroke: (paint: white, thickness: 5.2pt))

  // Circonferenze degli anelli
  circle((0, -3.55), radius: 1.25, stroke: 0.6pt)
  circle((0, -3.55), radius: 1.04, stroke: 0.6pt)
  circle((0, -3.55), radius: 0.76, stroke: 0.6pt)
  circle((0, -3.55), radius: 0.56, stroke: 0.6pt)

  // Freccia curva di rotazione sull'anello interno
  arc((0, -3.55), start: 62deg, stop: 118deg, radius: 0.66, anchor: "origin", mark: (start: ">", size: 0.08), stroke: 0.5pt)

  // Due frecce azzurre spesse contrapposte (alto e basso)
  line((0, -1.78), (0, -2.28), mark: (end: ">", size: 0.18), stroke: (paint: rgb(0, 150, 215), thickness: 2.6pt))
  line((0, -5.32), (0, -4.82), mark: (end: ">", size: 0.18), stroke: (paint: rgb(0, 150, 215), thickness: 2.6pt))


  // =========================================================================
  // PANNELLO 4 (BASSO DESTRA): Anello esterno cerchiato in rosso
  // =========================================================================

  // Anello interno in prospettiva (centro faccia destra in (3.78, -3.55))
  arc((3.20, -3.55), start: 90deg, stop: 270deg, radius: (0.28, 0.94), anchor: "origin", stroke: 0.5pt)
  arc((3.34, -3.55), start: 90deg, stop: 270deg, radius: (0.28, 0.94), anchor: "origin", stroke: 0.5pt)
  line((3.20, -2.61), (3.34, -2.61), stroke: 0.5pt)
  line((3.20, -4.49), (3.34, -4.49), stroke: 0.5pt)

  // Gola centrale con traccia di usura
  arc((3.43, -3.55), start: 95deg, stop: 265deg, radius: (0.24, 0.84), anchor: "origin", stroke: (dash: "densely-dotted", thickness: 1.5pt, paint: luma(140)))
  arc((3.48, -3.55), start: 95deg, stop: 265deg, radius: (0.24, 0.84), anchor: "origin", stroke: (dash: "dotted", thickness: 0.9pt, paint: luma(90)))
  arc((3.42, -2.61), start: 180deg, stop: 360deg, radius: (0.08, 0.10), anchor: "origin", stroke: 0.5pt)
  arc((3.42, -4.49), start: 0deg, stop: 180deg, radius: (0.08, 0.10), anchor: "origin", stroke: 0.5pt)

  // Spalla destra e faccia anteriore dell'anello interno
  arc((3.50, -3.55), start: 90deg, stop: 270deg, radius: (0.28, 0.94), anchor: "origin", stroke: 0.5pt)
  line((3.50, -2.61), (3.68, -2.61), stroke: 0.5pt)
  line((3.50, -4.49), (3.68, -4.49), stroke: 0.5pt)
  circle((3.68, -3.55), radius: (0.28, 0.94), fill: white, stroke: 0.5pt)
  circle((3.68, -3.55), radius: (0.18, 0.64), stroke: 0.5pt)
  arc((3.74, -3.55), start: 115deg, stop: 245deg, radius: (0.18, 0.64), anchor: "origin", stroke: 0.5pt)

  // Metà anello esterno sezionato (a destra, centro (4.85, -3.55))
  arc((4.58, -3.55), start: -90deg, stop: 90deg, radius: (0.36, 1.14), anchor: "origin", stroke: 0.5pt)
  arc((4.68, -3.55), start: -90deg, stop: 90deg, radius: (0.38, 1.20), anchor: "origin", stroke: 0.5pt)
  // Traccia di usura localizzata in alto e in basso sulla pista esterna
  arc((4.78, -3.55), start: 40deg, stop: 82deg, radius: (0.40, 1.22), anchor: "origin", stroke: (dash: "densely-dotted", thickness: 2.0pt, paint: luma(130)))
  arc((4.78, -3.55), start: -82deg, stop: -40deg, radius: (0.40, 1.22), anchor: "origin", stroke: (dash: "densely-dotted", thickness: 2.0pt, paint: luma(130)))
  arc((4.83, -3.55), start: -88deg, stop: 88deg, radius: (0.40, 1.22), anchor: "origin", stroke: 0.4pt)
  // Bordo esterno anteriore e posteriore
  arc((4.98, -3.55), start: -90deg, stop: 90deg, radius: (0.44, 1.38), anchor: "origin", stroke: 0.5pt)
  arc((5.08, -3.55), start: -90deg, stop: 90deg, radius: (0.44, 1.38), anchor: "origin", stroke: 0.5pt)
  // Chiusure delle sezioni in alto e in basso
  line((4.58, -2.41), (4.46, -2.35), (4.46, -2.17), (5.08, -2.17), stroke: 0.5pt)
  line((4.58, -2.41), (4.68, -2.35), (4.88, -2.35), (4.98, -2.41), (4.98, -2.17), stroke: 0.5pt)
  line((4.58, -4.69), (4.46, -4.75), (4.46, -4.93), (5.08, -4.93), stroke: 0.5pt)
  line((4.58, -4.69), (4.68, -4.75), (4.88, -4.75), (4.98, -4.69), (4.98, -4.93), stroke: 0.5pt)

  // Ellisse rossa attorno alla metà dell'anello esterno
  circle((4.95, -3.55), radius: (0.72, 1.88), stroke: (paint: red, thickness: 1.0pt))
})
])

=== Cedimento per disallineamento e Cuscinetti Orientabili


#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[È molto frequente, specialmente su rotori lunghi (come nelle turbine idroelettriche), che i piani di appoggio dei supporti non siano perfettamente allineati e orizzontali. In altri casi, la snellezza dell'albero può comportare una linea elastica molto flessa. Questo genera errori di posizionamento, come il disassamento dei supporti o la flessione dell'albero stesso. Sotto l'azione di questi carichi, la rotazione (a flessione) relativa fra l'anello interno e l'anello esterno può superare il limite previsto dalla geometria del cuscinetto. La condizione di contatto si altera drasticamente: l'usura diventa asimmetrica e diagonale rispetto alle piste, si innescano rumorosità, sollecitazioni eccessive e si può arrivare allo "sgabbiamento", situazione in cui il cuscinetto perde spontaneamente la configurazione di assemblaggio.],[
#image("disassamento e flessione.png")
])

Per prevenire questo collasso, si impone una rigorosa verifica della rotazione flessionale degli alberi e, come rimedio costruttivo, l'utilizzo di cuscinetti orientabili, capaci di auto-adattarsi.

Le soluzioni geometriche per permettere l'orientamento compensano il momento di ribaltamento senza generare reazioni vincolari concentrate anomale. Esempi tipici includono:
- #strong[Cuscinetti a rulli a botte:] Hanno la superficie laterale bombata e operano in anelli con piste a superficie sferica. L'anello interno può ruotare rispetto a quello esterno, adattandosi alla deformata dell'albero pur garantendo un rotolamento corretto.
- #strong[Cuscinetti orientabili a doppia corona (sfere o rulli):] Simili ai precedenti, offrono un adattamento sferico complessivo.
- #strong[Cuscinetti assiali con piastra di orientabilità:] Utilizzano piste tradizionali e rullini che sfruttano direttamente la superficie dell'albero, ma appoggiano su anelli di contenimento o piastre di supporto sagomate sfericamente. Questo permette all'intero gruppo di ruotare e allinearsi alle condizioni di carico.


=== Usura sede/anello: Fretting Corrosion
L'usura delle superfici di contatto tra il cuscinetto e le sue sedi di montaggio (interfaccia albero-anello o sede-anello) rappresenta un difetto catastrofico. Questo fenomeno nasce quando il forzamento (interferenza) delle parti non è in grado di garantire un vincolamento stabile. Anche in presenza di interferenza nominale, l'azione di carichi elevati, forze centrifughe o variazioni di temperatura tra materiali dissimili può generare microscorrimenti relativi tra le superfici accoppiate. Questo continuo strisciamento microscopico, se combinato con la rugosità superficiale, provoca una vera e propria abrasione del materiale (#emph[fretting]). Se l'ambiente presenta agenti aggressivi, l'abrasione si aggrava dando origine a ruggine di contatto e degradazione chimico-meccanica estrema, portando al fenomeno completo noto come #emph[fretting corrosion]. Il danneggiamento si presenta sotto forma di superfici gravemente degradate, ampie usure scure e cricche diffuse sull'anello.


Per prevenire la #emph[fretting corrosion] è essenziale stabilire quale tra gli anelli debba avere l'interferenza più stretta (forzamento maggiore), analizzando la cinematica dei carichi:

1. #strong[Carico Rotante:] Si verifica quando il carico è fisso nello spazio ma l'anello ruota, oppure quando l'anello è fisso ma la direzione del carico ruota nel tempo. In questo scenario, tutti i punti dell'anello si trovano, a turno, sottoposti all'intensità massima del carico nel corso di una rotazione completa. Questa condizione sollecita fortemente lo scorrimento relativo dell'anello sulla sua sede. L'anello soggetto a carico rotante tende a ruotare sulla propria sede e necessita inderogabilmente di un'opportuna e garantita interferenza forte.
2. #strong[Carico Fisso:] Si verifica quando l'anello e il carico ruotano alla stessa velocità angolare o sono entrambi del tutto stazionari. Questa condizione non innesca particolari moti relativi all'interfaccia e risulta meno critica.
3. #strong[Direzione indeterminata:] Si presenta in configurazioni cinematiche incerte, ove il carico ha oscillazioni deboli ma prive di una rotazione completa; richiede cautela ingegneristica nella tolleranza dell'accoppiamento.

#strong[Esempi schematici di applicazione:]
- #emph[Assale fisso e ruota rotante:] (es. la ruota non motrice di un veicolo). Il peso del veicolo è un carico fisso verso il basso. L'anello interno è stazionario assieme all'assale, mentre l'anello esterno ruota solidale alla ruota. L'anello interno subisce il carico sempre nello stesso punto inferiore (carico fisso). L'anello esterno, ruotando sotto una forza stazionaria verticale, vede il carico spostarsi lungo tutta la sua circonferenza: è quindi l'anello esterno a essere soggetto a carico rotante e a necessitare dell'interferenza critica rispetto alla ruota.
- #emph[Assale rotante e supporto fisso:] (es. un albero di trasmissione supportato al telaio). Il carico (es. peso) è fisso verticalmente. L'anello esterno è bloccato nella sede statorica e sente il carico sempre nello stesso punto (carico fisso). L'anello interno gira con l'albero attraversando ciclicamente la zona di massima reazione del peso: è l'anello interno a subire il carico rotante e a dover essere forzato rigidamente sull'albero per evitare la #emph[fretting corrosion].

Il concetto per limitare questo danno si estende a tutta la meccanica (es. sistemi di connettori in microelettronica): qualora sia presente un'azione vibratoria o dinamica all'interfaccia, è necessario rendere sufficientemente flessibile l'elemento di vincolo in sé, affinché il sistema deformato segua le traslazioni o rotazioni senza originare scorrimento (attrito radente locale) all'interfaccia di contatto vera e propria.

== Cuscinetti a Corpi Volventi - Calcoli e prestazioni in esercizio
=== Calcolo della durata dei cuscinetti: Formula base (ISO)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[L'analisi del comportamento del cuscinetto comporta l'utilizzo di curve di durata che correlano il carico applicato a un certo numero di cicli, espresso in milioni di cicli (indicato con $L$). Tali curve $S-N-P$ possono essere interpretate in analogia alla curva di Wöhler per lo studio a fatica. Assumendo che tali curve siano rette in una rappresentazione logaritmica (log-log) con inclinazione $p$, la curva presa in considerazione è solitamente la $B_10$, la quale garantisce un livello di affidabilità del 90%.],[
#canvas(length: 0.8cm, {
  import draw: *

  // Assi cartesiani
  line((0, 6.0), (0, 0), (7.05, 0), stroke: (paint: black, thickness: 1.2pt))

  // Quadratini dei campioni sperimentali (riempimento grigio chiaro, bordo blu/grigio)
  rect((0.89, 5.39), (1.01, 5.51), fill: luma(200), stroke: (paint: blue.darken(20%), thickness: 0.5pt))
  rect((1.47, 4.94), (1.59, 5.06), fill: luma(200), stroke: (paint: blue.darken(20%), thickness: 0.5pt))
  rect((2.07, 4.39), (2.19, 4.51), fill: luma(200), stroke: (paint: blue.darken(20%), thickness: 0.5pt))
  rect((2.59, 3.97), (2.71, 4.09), fill: luma(200), stroke: (paint: blue.darken(20%), thickness: 0.5pt))
  rect((3.29, 3.49), (3.41, 3.61), fill: luma(200), stroke: (paint: blue.darken(20%), thickness: 0.5pt))
  rect((4.19, 3.04), (4.31, 3.16), fill: luma(200), stroke: (paint: blue.darken(20%), thickness: 0.5pt))
  rect((5.32, 2.62), (5.44, 2.74), fill: luma(200), stroke: (paint: blue.darken(20%), thickness: 0.5pt))
  rect((5.47, 2.24), (5.59, 2.36), fill: luma(200), stroke: (paint: blue.darken(20%), thickness: 0.5pt))

  // Curva principale blu (arco di cerchio)
  arc((8.223, 12.081), start: 222.36deg, stop: 259.62deg, radius: 9.842, anchor: "origin", stroke: (paint: blue, thickness: 1.5pt))

  // Etichette
  content((-0.35, 5.65), text(size: 7pt)[*P*], anchor: "east")
  content((6.55, -0.35), text(size: 7pt)[*L*], anchor: "north")
})
])

La relazione teorica è definita dalla Formula base (ISO), che impone la costanza del prodotto tra il numero di cicli e il carico elevato a potenza:
$ P^p dot.op N = "cost" = C^p dot.op 10^6 $

Da cui si ricava la durata in milioni di cicli $L_10$:
$ L_10 = frac(N, 10^6) = ( frac(C, P) )^p $

Dove:
- $P$ è il carico dinamico equivalente.
- $C$ è il coefficiente di carico dinamico, ovvero il carico tollerato per $10^6$ cicli, fornito dai cataloghi.
- $p$ è un esponente legato alla tipologia di corpo volvente: vale $3$ per i cuscinetti a sfere e $10/3$ per i cuscinetti a rulli.

Se la velocità di rotazione $n$ (espressa in giri/min o rpm) è costante, la durata può essere espressa in ore di funzionamento $L_(10 h)$:
$ L_(10 h) = frac(10^6, 60 dot.op n) ( frac(C, P) )^p $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[In applicazioni in cui il cuscinetto non compie rotazioni complete ma oscilla di un angolo $plus.minus gamma$ (in gradi), la durata viene determinata valutando le singole oscillazioni:
$ L_(10 "osc") = frac(180, 2 gamma) ( frac(C, P) )^p $],[#canvas(length: 0.8cm, {
  import draw: *

  // Circonferenza principale
  circle((0, 0), radius: 2.52, stroke: 1pt)

  // Assi di simmetria (tratto-punto)
  line((-3.50, 0), (3.90, 0), stroke: (dash: "dash-dotted", thickness: 0.6pt))
  line((0, -3.15), (0, 3.10), stroke: (dash: "dash-dotted", thickness: 0.6pt))

  // Semirette che delimitano l'angolo 2gamma
  line((0, 0), (-2.38, -4.12), stroke: 1pt)
  line((0, 0), (2.38, -4.12), stroke: 1pt)

  // Arco di quota con frecce agli estremi
  arc((0, 0), start: 240deg, stop: 300deg, radius: 4.10, anchor: "origin", mark: (start: ">", end: ">"), stroke: 1pt)

  // Etichetta dell'angolo
  content((0, -3.65), text(size: 12pt)[$2 gamma$], anchor: "center")
})])

=== Durata di base corretta
La formula teorica di base non tiene conto delle reali condizioni operative del cuscinetto. Vengono pertanto introdotti dei fattori correttivi per calcolare la durata corretta $L_(n m)$:
$ L_(n m) = a_1 a_(x y z) ( frac(C, P) )^p $

Il fattore $a_1$ è il coefficiente correttivo per i livelli di affidabilità richiesti superiori al 90%. All'aumentare dell'affidabilità richiesta (es. 95%, 99%), la resistenza stimata per una popolazione di campioni diminuisce, riducendo di conseguenza la durata calcolata.

Il fattore $a_(x y z)$ (denominato $a_("SKF")$ o con altre sigle ISO a seconda del costruttore) tiene conto degli aspetti pratici del contatto tra corpi volventi e piste. Esso è funzione del limite di fatica del materiale ($P_u$), del rapporto di viscosità $k$ e del livello di contaminazione e pulizia dell'ambiente in cui opera il lubrificante ($eta_c$):
$ a_("SKF") = f( eta_c frac(P_u, P) ; k ) $

=== Viscosità e lubrificazione
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Il corretto comportamento del cuscinetto è fortemente vincolato alla lubrificazione. Si definisce in primo luogo una viscosità cinematica necessaria $nu_1$ (in $m m^2 / s$), dipendente dalla dimensione caratteristica del cuscinetto e dalla sua velocità di rotazione. Nei cuscinetti veloci si limita la viscosità per non generare un eccessivo sviluppo di calore a causa della resistenza viscosa, mentre nei cuscinetti lenti e maggiormente caricati si cerca una viscosità più alta per sostenere i carichi ed evitare la rottura del meato di lubrificante.],[#image("grafico viscosità necessaria.png", width:70%)])

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[
Si introduce poi la viscosità cinematica effettiva $nu$ (in $m m^2 / s$) dell'olio nelle reali condizioni di funzionamento, fortemente dipendente dalla temperatura di esercizio. Il rapporto tra la viscosità operativa e quella necessaria definisce il parametro $k$:
$ k = frac(nu, nu_1) $

Di norma si seleziona un lubrificante tale per cui si abbia $1 < k < 4$. Il valore di $k$ definisce fisicamente la natura del contatto nel meato:
- #strong[$k = 0.1$:] Condizione di meato esiguo in cui le asperità superficiali del corpo volvente e della pista entrano diffusamente in contatto solido. Si garantisce un'ottima stabilità e aderenza, ma la dissipazione energetica e l'usura superficiale risultano elevate.
- #strong[$k = 1$:] Condizione mista in cui le asperità entrano in contatto locale, ma la maggior parte della regione è riempita dal lubrificante che inizia ad esercitare un'azione di sostentamento in pressione.
- #strong[$k = 4$:] Condizione in cui le asperità sembrano non toccarsi e la pressione è trasferita esclusivamente dal meato fluido (il corpo volvente "flotta" sul letto del lubrificante). Questo riduce drasticamente l'usura e favorisce lo smaltimento del calore, ma introduce componenti non lineari di smorzamento fluido che possono rendere meno prevedibile la dinamica del sistema. In presenza di valori troppo elevati di $k$ si ha separazione completa, eccessivo attrito interno al fluido e forte sviluppo di calore.],[#image("altro grafico viscosità.png", width:80%)])



=== Contaminazione e determinazione di $a_("SKF")$ 
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[L'influenza dell'ambiente e della pulizia del lubrificante è riassunta dal fattore $eta_c$. Per una condizione di massima pulizia (es. laboratorio), questo valore è unitario. Degradando le condizioni ambientali verso contaminazioni più pesanti, il fattore decresce; l'impatto è proporzionalmente più gravoso nei cuscinetti di dimensioni inferiori, dove lo spazio ristretto rende l'azione abrasiva del contaminante più severa. Il calcolo finale del coefficiente $a_("SKF")$ avviene tramite un apposito diagramma in cui le ascisse sono costituite dal parametro $eta_c frac(P_u, P)$, combinando l'effetto della pulizia e del carico rispetto al limite di fatica.],[#image("grafico aSKF.png",width:80%)])



=== Tipologie di lubrificante
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Per garantire affidabilità e continuità di esercizio, il cuscinetto necessita di una minima quantità di lubrificante; un quantitativo eccessivo altererebbe il meccanismo di contatto e ostacolerebbe la regolarità operativa. Il lubrificante, soggetto a usura, va periodicamente ripristinato (nel caso dei grassi) o filtrato (per gli oli), tranne nei casi di cuscinetti dotati di protezioni incorporate (schermati) pre-lubrificati a vita.

- #strong[Lubrificazione a grasso:] Particolarmente indicata per mantenere il sistema confinato. Trattiene gli agenti contaminanti e protegge da umidità e acqua. Ha uno spettro di temperature operative limitato tra una minima (LTL, oltre la quale vi è difficoltà di avviamento) e una massima (HTL, oltre la quale perde consistenza). Un eccesso di velocità produce un aumento termico severo del grasso.
- #strong[Lubrificazione a olio:] Indicata dove le alte velocità o l'ambiente precludono l'uso del grasso, oppure quando le parti adiacenti del carter (es. ingranaggi) richiedono già una lubrificazione ad olio. Si distingue in #emph[bagno d'olio] (immersione parziale dei corpi volventi nella coppa) o #emph[a ricircolo] (pompe e iniettori con filtrazione costante, ideali per asportare calore ad alte velocità per prevenire l'invecchiamento del fluido).],[
#image("lubrificazione.png")
])

=== Carico dinamico equivalente (costante nel tempo)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Quando il cuscinetto è sottoposto a carichi combinati (forza radiale $F_r$ e forza assiale $F_a$), si fa riferimento a un carico dinamico equivalente $P$, tale per cui la risultante sia considerabile costante nel tempo:
$ P = X dot.op F_r + Y dot.op F_a $
I coefficienti $X$ e $Y$ sono tabulati a catalogo in funzione del parametro $f_0 dot.op frac(F_a, C_0)$ e del gioco del cuscinetto (dove $C_0$ è il coefficiente di carico statico e $f_0$ è a sua volta un fattore tabulato). 
Qualora il carico assiale sia trascurabile o al di sotto di un limite definito empiricamente ($F_a / F_r lt.eq e$, con $e = f(f_0 dot.op F_a / C_0)$), il termine assiale viene omesso e si pone direttamente $P = F_r$.],[#image("cuscinetti con forze.png", width:60%)])

=== Condizioni di lavoro variabili (Regola di Miner)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Poiché in molti contesti reali il carico di esercizio varia durante la missione operativa del componente, la durata viene valutata tramite un calcolo di accumulo del danno equivalente alla regola di Palmgren-Miner.
Data una scomposizione del funzionamento utile in intervalli caratterizzati ciascuno da un carico $P_1, P_2, dots.h$ e da una frazione temporale $U_1, U_2, dots.h$, la condizione di cedimento è posta come:
$ sum frac(U_i, L_(10 m i)) = 1 $
],[#canvas(length: 1.1cm, {
  import draw: *

  // Gradini orizzontali di riferimento (continui sottili)
  line((0.00, 3.93), (0.44, 3.93), stroke: 0.5pt)
  line((0.44, 2.42), (2.36, 2.42), stroke: 0.5pt)
  line((2.36, 1.29), (5.04, 1.29), stroke: 0.5pt)
  line((5.04, 0.36), (6.89, 0.36), stroke: 0.5pt)

  // Linee verticali tratteggiate dei gradini
  line((0.44, 3.93), (0.44, 0.00), stroke: (dash: "dashed", thickness: 0.5pt))
  line((2.36, 2.42), (2.36, 0.00), stroke: (dash: "dashed", thickness: 0.5pt))
  line((5.04, 1.29), (5.04, 0.00), stroke: (dash: "dashed", thickness: 0.5pt))
  line((6.89, 0.42), (6.89, 0.06), stroke: 0.5pt)

  // Linea di richiamo "intervallo di lavoro utile"
  line((1.58, 3.53), (1.20, 2.22), stroke: 0.5pt)

  // Curva blu continua (raccordi di Bezier nei flessi + tratti rettilinei sui plateau)
  bezier((0.00, 3.95), (0.44, 3.25), (0.44, 3.95), (0.44, 3.65), stroke: (paint: blue.darken(20%), thickness: 1.5pt))
  bezier((0.44, 3.25), (1.25, 2.42), (0.44, 2.55), (0.75, 2.46), stroke: (paint: blue.darken(20%), thickness: 1.5pt))
  bezier((1.25, 2.42), (2.36, 1.90), (2.15, 2.35), (2.32, 2.25), stroke: (paint: blue.darken(20%), thickness: 1.5pt))
  bezier((2.36, 1.90), (3.15, 1.31), (2.40, 1.35), (2.65, 1.31), stroke: (paint: blue.darken(20%), thickness: 1.5pt))
  line((3.15, 1.31), (4.35, 1.29), stroke: (paint: blue.darken(20%), thickness: 1.5pt))
  bezier((4.35, 1.29), (4.98, 0.82), (4.78, 1.29), (4.90, 1.08), stroke: (paint: blue.darken(20%), thickness: 1.5pt))
  bezier((4.98, 0.82), (5.65, 0.36), (5.06, 0.56), (5.20, 0.38), stroke: (paint: blue.darken(20%), thickness: 1.5pt))
  line((5.65, 0.36), (6.89, 0.29), stroke: (paint: blue.darken(20%), thickness: 1.5pt))

  // Assi cartesiani principali
  line((0.00, 4.42), (0.00, 0.00), (7.38, 0.00), stroke: 1.2pt)

  // Freccia verticale a sinistra dell'asse P
  line((-0.29, 3.60), (-0.29, 4.40), mark: (end: ">"), stroke: 0.6pt)

  // Etichette (tutte con text(size: 7pt))
  content((-0.42, 3.98), text(size: 7pt)[P], anchor: "east")
  content((0.40, 4.22), text(size: 7pt)[$"P"_1$], anchor: "center")
  content((2.22, 2.75), text(size: 7pt)[$"P"_2$], anchor: "center")
  content((4.82, 1.62), text(size: 7pt)[$"P"_3$], anchor: "center")
  content((6.68, 0.68), text(size: 7pt)[$"P"_4$], anchor: "center")
  content((1.55, 3.70), text(size: 7pt)[intervallo di lavoro utile], anchor: "west")
})])
La durata in milioni di cicli totale risulta quindi pari al reciproco della sommatoria:
$ L_(10 m) = frac(1, sum frac(U_i, L_(10 m i))) $
Dove $L_(10 m i)$ sono le durate SKF (corrette tramite i vari fattori) calcolate per ogni singola condizione di carico $P_i$.

=== Calcolo statico ed equivalente statico
Il dimensionamento in base al coefficiente di carico statico $C_0$ è obbligatorio quando il cuscinetto:
- Non ruota ($omega = 0$).
- Compie movimenti lenti di allineamento o di oscillazione.
- Raggiunge velocità limitate richiedendo una durata modesta.
- Opera in condizioni di carico stazionario ma con severi urti/sovraccarichi transitori.

Si procede determinando un carico statico equivalente $P_0$:
$ P_0 = X_0 dot.op F_r + Y_0 dot.op F_a $
La verifica statica esige che il rapporto tra il coefficiente statico a catalogo e il carico effettivo risulti superiore a un fattore di sicurezza $s_0$:
$ frac(C_0, P_0) gt.eq s_0 $
ovvero $C_0 gt.eq s_0 dot.op P_0$. 
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Il parametro $s_0$ tiene conto dell'accettabilità di piccole deformazioni permanenti sulle piste e del grado di certezza sul calcolo delle sollecitazioni gravitazionali e inerziali. In scenari in cui la deformazione è tollerata e la certezza di carico è elevata, $s_0$ può assumere valori persino inferiori a 1 (es. $0.4$).],[#image("tabella valori statico.png")])

=== Limitazioni operative: carico minimo, velocità massima e momento di attrito
Durante la rotazione del cuscinetto deve essere garantita la presenza di un #strong[carico minimo] che vincoli il sistema; la mancanza di carico sufficiente permetterebbe alle forze di inerzia dei corpi volventi e della gabbia di innescare scorrimenti dannosi (strisciamento tra sfere e piste). Empiricamente questo limite è fissato a:
- $P_("min") = 0.01 dot.op C$ (per i cuscinetti a sfere)
- $P_("min") = 0.02 dot.op C$ (per i cuscinetti a rulli)
La richiesta è superiore nei rulli in quanto l'estensione dell'area di contatto richiede pressioni minime maggiori per superare la dissipazione.

La #strong[velocità di rotazione massima] è invece imposta dalle temperature operative del lubrificante e dal calore prodotto dall'attrito. Superato questo limite, la temperatura compromette sia il materiale dell'anello che la struttura chimica del fluido. I cataloghi permettono di dedurre tale asintoto cinematico in funzione delle proprietà di scambio termico della geometria installata.

In fase di dimensionamento dell'attuazione motrice, è indispensabile stimare la resistenza all'avviamento. Utilizzando come approssimazione il caso di carico modesto ($P < 0.1 C$), si calcola il #strong[momento di attrito]:
$ M_("attrito") = 0.5 mu F d $
Dove $mu$ varia tra $0.0015$ e $0.0050$ in base alla geometria del componente, $F$ è il carico dinamico equivalente e $d$ è il diametro del foro interno. Tale momento, sommato a quello dissipato da eventuali guarnizioni striscianti, si somma alla coppia inerziale che l'utenza e la motrice devono superare per avviare l'albero dallo stato di quiete.
== Lezione 08: Cuscinetti a Corpi Volventi - Criteri di Montaggio

=== Teoria

==== Regole Essenziali e Gradi di Libertà
Un aspetto fondamentale relativo alla teoria dei cuscinetti a corpi volventi riguarda i criteri di montaggio, ovvero le regole utilizzate per la selezione e il posizionamento di cuscinetti e corpi volventi all'interno di un sistema meccanico. Durante il funzionamento, l'albero può essere sollecitato in direzione assiale; pertanto, il vincolamento del cuscinetto (le condizioni con cui esso collega l'albero alla parte statorica) deve essere attentamente valutato. 

Le scelte progettuali si dividono tipicamente in due direzioni: vincolare in maniera molto precisa e stretta l'albero per garantire elevata precisione e rigidezza, oppure lasciare dei gradi di libertà per evitare che sui cuscinetti gravino forze eccessive che degraderebbero la durata del componente, permettendo ad esempio l'adattamento alle dilatazioni termiche. I gradi di libertà vincolati o lasciati liberi soddisfano l'esigenza di creare una configurazione adattabile oppure una situazione di vincolamento solido.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Le regole essenziali per il montaggio di due cuscinetti radiali prevedono che:
- Un cuscinetto deve essere fissato assialmente per sopportare i carichi assiali e definire la posizione dell'albero.
- Un cuscinetto deve permettere gli spostamenti assiali dell'albero (dovuti a dilatazioni termiche o tolleranze). 
- Per alberi corti è possibile prevedere un montaggio in opposizione, dove ciascun cuscinetto provvede alla guida assiale in una sola direzione.
- Gli anelli soggetti a carico rotante devono essere montati con interferenza.
- I cuscinetti soggetti a carichi con direzione indeterminata devono avere entrambi gli anelli montati con interferenza.],[
#image("movimento.png")
])

La scelta tra locazione fissa o mobile dipende dall'interfaccia e determina come avviene lo spostamento assiale. Nel caso di movimento interno al cuscinetto, si utilizza ad esempio un cuscinetto a rulli cilindrici in cui l'anello interno è privo di bordini laterali; la variazione geometrica del sistema permette lo scorrimento assiale dei rulli direttamente sulla pista dell'anello. Nel caso di movimento esterno, i corpi volventi (sfere o rulli) sono vincolati tra le piste di entrambi gli anelli, opponendosi a moti relativi interni; l'adattamento è quindi garantito lasciando l'anello esterno libero di scorrere assialmente all'interno della sede statorica (accoppiamento libero).

==== Configurazioni di Montaggio: Vincolo e Adattamento
L'articolazione dei supporti richiede lo studio di combinazioni specifiche per gestire spinte assiali, carichi radiali e momenti di ribaltamento. Analizzando le configurazioni nel dettaglio, si possono incontrare diverse architetture: 
#grid(
  columns: (1fr, 1fr),
  rows: (8),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[In una prima configurazione classica, l'albero è supportato da un cuscinetto radiale a sfere da un lato e da uno a rulli cilindrici dall'altro. Il cuscinetto a sfere è totalmente bloccato: l'anello esterno è fissato da un coperchio e da un anello elastico, mentre l'interno è bloccato da uno spallamento e da una ghiera filettata. Le sfere si impegnano nelle piste a sezione semicircolare impedendo moti relativi assiali, rendendo il sistema perfettamente vincolato. Il grado di libertà termico è fornito dal cuscinetto a rulli opposto, il cui anello interno è privo di bordini, permettendo lo scorrimento.],[
#image("prima configurazione.png")
],[In una configurazione più complessa a tre cuscinetti, il contenimento della spinta assiale può essere affidato a un cuscinetto a sfere a quattro punti di contatto, affiancato a un cuscinetto a rulli. Il cuscinetto a quattro punti ha l'anello interno diviso in due parti e funge da cuscinetto obliquo compatto reversibile. Per evitare che collabori all'azione radiale (che deve essere sostenuta interamente dal rullo adiacente), viene lasciato un gioco in direzione radiale. Anche in questo caso, il grado di libertà per la dilatazione dell'intero albero è demandato al cuscinetto a rulli posto all'estremità opposta.],[
#image("seconda configurazione.png")
],[Un'altra opzione prevede l'utilizzo di una coppia di cuscinetti obliqui a sfere montati in configurazione a "X" (con le rette d'azione convergenti verso l'asse). Questa soluzione sostituisce la funzione del cuscinetto a quattro punti in forma compatta, garantendo reazioni radiali e assiali in entrambi i versi, mantenendo sempre il grado di libertà assiale sul cuscinetto a rulli opposto.],[
#image("3 configurazione.png")
],[Infine, se è necessario permettere all'albero di inflettersi liberamente (ad esempio per non usurare ingranaggi sensibili ai disallineamenti), si utilizza un cuscinetto orientabile a rulli. I rulli a botte scorrono sull'arco di circonferenza della pista esterna sferica, permettendo la rotazione della sezione trasversale. Dal lato opposto, viene montato un cuscinetto toroidale (tipo CARB), la cui pista leggermente curva asseconda la rotazione e, non avendo bordini di contenimento, permette un moderato adattamento assiale.],[
#image("4 configurazione.png")
],[],[
#image("esterno 1.png")
],[],[
#image("esterno 2.png")
],[Nelle configurazioni in opposizione (utilizzate ad esempio per ingranaggi lunghi e massivi che richiedono precisione e orizzontalità), due cuscinetti obliqui a sfere o a rulli conici vengono montati alle estremità dell'albero. Le piste avvolgono i corpi volventi in modo asimmetrico, creando rette d'azione inclinate che si oppongono a spinte assiali opposte, garantendo reazioni al momento di ribaltamento. Il sistema viene precaricato per annullare i giochi.],[
#image("opposizione.png", width:100%)
],[Nelle configurazioni flottanti, invece, si lascia un grado di libertà a entrambi i cuscinetti per permettere un adattamento bidirezionale senza sovraccaricare la struttura. Questo si ottiene lasciando un certo gioco assiale agli anelli esterni rispetto alla sede statorica, oppure, nel caso dei rulli, utilizzando anelli interni con un bordino solo da un lato. In questo modo si rende reversibile il grado di libertà assiale, suddividendolo tra i due cuscinetti della coppia.],[
#image("flottanti.png", width:100%)
])



//fede marco manca la parte sui vincoli per spostamento esterno




==== Bloccaggio Assiale e Radiale
#grid(
  columns: (1.1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Il bloccaggio assiale degli anelli sfrutta soluzioni costruttive simili al collegamento albero-mozzo. Tra le soluzioni costruttive si annoverano l'anello filettato (ghiera) che spinge sull'anello interno, piastre terminali fissate con viti in testa all'albero, coperchi terminali avvitati allo statore, anelli di ancoraggio (elastici) inseriti in apposite cave, collari di spallamento o bussole distanziali.],[
#image("bloccaggio 2.png",width:80%)
])

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[È cruciale che il bloccaggio assiale tenga conto dei raggi di raccordo. La superficie dell'anello non deve mai interferire con il raccordo dello spallamento dell'albero: ci deve essere sempre un vuoto (passaggio d'aria) per evitare incollamenti e garantire che l'anello vada in battuta perfetta sulla superficie verticale. Se il raccordo dell'albero è troppo ampio rispetto allo smusso del cuscinetto, si interpone un collare distanziale sagomato per fornire una superficie di riscontro piana compatibile.],[
#image("dettaglio raccordo.png",width:75%)
])



Per il bloccaggio radiale, si ricorre a un'interferenza, particolarmente importante in presenza di carichi rotanti. L'anello esterno si comporta come un albero forato, mentre il corpo statorico funge da mozzo.

La scelta delle tolleranze agisce sulle dimensioni degli anelli secondo lo schema foro base o albero base. L'interferenza non serve per bloccare assialmente i cuscinetti, ma per evitare che l'anello si distacchi o si allenti in esercizio per effetto della centrifugazione o della temperatura.
Le interferenze (o i giochi) che si ottengono con i vari accoppiamenti normalizzati sono riportate direttamente nei cataloghi dei costruttori. In particolare, nelle tabelle per ogni accoppiamento vengono forniti:
- gli *scostamenti* dimensionali (dell'anello e della relativa sede);
- il *campo di interferenza (o gioco) teorico*, calcolato combinando i casi limite estremi delle zone di tolleranza;
- il *campo di interferenza (o gioco) probabile (al $99\%$)*, valutato su base statistica tenendo conto della distribuzione reale delle dimensioni lavorate all'interno della fascia di tolleranza.

Inoltre, poiché gli anelli dei cuscinetti hanno piccolo spessore e tendono ad adattarsi alle deformazioni della sede su cui sono calettati, *le sedi dei cuscinetti* devono garantire anche adeguate *precisioni di forma* e *di posizione*: a disegno devono quindi essere indicate le relative tolleranze geometriche, unitamente alle *rugosità* superficiali consigliate.

Le condizioni di interferenza (o di accoppiamento libero) devono essere verificate in condizioni di esercizio. La perdita di calettamento tra cuscinetto e albero si calcola considerando l'anello come un anello sottile. L'interferenza effettiva è data da:

$ i_("effettivo") = i_("min") - Delta i^R - Delta i^T - Delta i^omega $

Dove $i_("min")$ è ricavata dalle tabelle. La perdita per rugosità è:

$ Delta i^R = 2 dot.op 0.4 dot.op (R_a^("albero") + R_a^("anello")) quad [mu m] $
// 0.4 deriva dall'assunzione che $R_a \approx 0.4 \mu m$ come indicato nell'OCR.

La perdita per dilatazione termica (se i materiali hanno coefficienti diversi, altrimenti per albero in acciaio $Delta i^T = 0$):

$ Delta i^T = D_c (alpha_m - alpha_a) Delta T $

La perdita per centrifugazione (considerando l'albero indeformabile):

$ Delta i^omega = frac(d dot.op rho dot.op omega^2 dot.op d_("e anello")^2, 4 dot.op E) $

La velocità limite di "scalettamento" (perdita totale di aderenza) si ottiene ponendo $i_("effettivo") = 0$:

$ omega^2 = frac(4 dot.op E dot.op (i_("min") - Delta i^R - Delta i^T), d dot.op rho dot.op d_("e anello")^2) $
// [DA SLIDE]
Per comprendere il significato fisico e le ipotesi alla base dei singoli termini della verifica in esercizio riportati nelle relazioni precedenti, si osserva quanto segue:

1. *Perdita per rugosità ($Delta i^R$)*: durante il calettamento, le creste delle asperità superficiali dell'albero e dell'anello vengono schiacciate plasticamente, riducendo l'interferenza geometrica iniziale. Nella formula della slide il fattore $2$ tiene conto che la perdita è valutata sul diametro (quindi su due lati opposti), mentre il primo coefficiente $0.4$ è un fattore adimensionale di spianamento delle creste. Per l'anello del cuscinetto si assume invece il valore specifico di rugosità superficiale indicato a catalogo:
   $ R_a^("anello") = 0.4\ mu"m" $
   mentre $R_a^("albero")$ dipende dal grado di finitura della lavorazione della sede sull'albero.

2. *Perdita per effetto termico ($Delta i^T$)*: nella relazione $Delta i^T = D_c (alpha_m - alpha_a) Delta T$, $D_c$ rappresenta il diametro di calettamento, $alpha_m$ è il coefficiente di dilatazione termica lineare del mozzo (ossia l'anello del cuscinetto, in acciaio), $alpha_a$ è quello dell'albero e $Delta T$ è la variazione di temperatura in esercizio rispetto al montaggio. Se anche l'albero è in acciaio ($alpha_m = alpha_a$), non vi è dilatazione differenziale e risulta:
   $ Delta i^T = 0 $

3. *Perdita per centrifugazione ($Delta i^omega$) e velocità di scalettamento*: assimilando ciascun anello del cuscinetto a un *anello sottile* (di diametro interno $d$, diametro esterno dell'anello interno $d_("e anello")$, densità $rho$ e modulo elastico $E$) e considerando l'albero indeformabile rispetto all'anello, l'espansione radiale dovuta alla forza centrifuga alla velocità angolare $omega$ riduce l'interferenza della quantità $Delta i^omega$. Quando la velocità angolare raggiunge il valore limite per cui $i_("effettivo") = 0$, si verifica la perdita della condizione di calettamento (*scalettamento*), con conseguente slittamento relativo tra anello e sede.

==== Esecuzione del Montaggio
Il montaggio può avvenire a freddo (eseguito alla pressa, calcolando la forza necessaria per vincere l'attrito) o a caldo. Per il montaggio a caldo, si calcola il salto termico necessario:

$ Delta T = frac(i_("max") + s, alpha dot.op d dot.op 10^3) $

Dove $i_("max")$ è l'interferenza massima in $mu m$ e $s$ è il gioco aggiuntivo per il montaggio (ulteriori $30 div 100  mu m$).
Esistono limiti stringenti per il riscaldamento, dettati dalle proprietà chimico-fisiche dei lubrificanti più che dai materiali strutturali: i cuscinetti non devono essere riscaldati oltre i 120°C e, se dotati di lubrificazione a vita, non oltre gli 80°C (indicativamente 70-80°C).

=== Disposizioni Particolari: Cuscinetti Obliqui e Precarico
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[I cuscinetti obliqui (a sfere o a rulli) sopportano carichi radiali e assiali. A causa della loro forma, un carico radiale genera una forza assiale interna che deve essere equilibrata da un'azione in senso opposto; per questo vengono montati in opposizione. I cuscinetti obliqui possono essere montati in tre disposizioni: in tandem (rette d'azione parallele, sopportano carichi assiali in un solo senso), a 'O' (rette d'azione divergenti verso l'asse di rotazione), o a 'X' (rette d'azione convergenti incrociandosi verso l'asse). La denominazione 'O' o 'X' si riferisce esclusivamente alla geometria delle rette d'azione (la risultante applicata dal corpo volvente sulle piste), mai agli assi geometrici dei corpi volventi.],[
#image("disposizioni tandem o x.png")
])

Le coppie di cuscinetti possono essere fornite con gioco o con precarico (inteso come gioco negativo). Per definire il gioco o il precarico assiale iniziale, si utilizzano spesso dei distanziali interposti tra gli anelli. Il precarico si ottiene portando a contatto gli anelli e sfruttando la conicità fino in fondo. 

Gli effetti di un opportuno precarico sono:
- Aumento di rigidezza (il sistema risulta compatto e vincolato).
- Riduzione della rumorosità (eliminando i giochi si evitano moti relativi sotto carichi dinamici).
- Maggior precisione di guida dell'albero.
- Compensazione di usure e assestamenti (limita l'usura da fretting).
- Distribuzione del carico: in presenza di forza assiale esterna, il cuscinetto precaricato che tenderebbe a scaricarsi mantiene una quota di reazione, aiutando il cuscinetto opposto.

Tuttavia, un precarico eccessivo produce maggiore attrito, temperature elevate e riduzione della durata. Un gioco eccessivo, d'altro canto, riduce la capacità di carico e genera non linearità dinamiche.

A causa dell'inclinazione delle rette d'azione, i centri di pressione del cuscinetto risultano spostati rispetto al centro geometrico. Il carico radiale agisce in questi centri di pressione. La forza assiale indotta internamente si somma alla forza assiale esterna e deve essere considerata nel calcolo del carico equivalente per la stima della durata (utilizzando le formule fornite dai cataloghi, es. SKF).
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[Se si desidera realizzare una cerniera pura (libertà di orientamento totale), si può ricorrere alla combinazione di un cuscinetto assiale (reggispinta) a sede sferica e un cuscinetto radiale orientabile a rulli, facendo coincidere i relativi centri di oscillazione delle due superfici sferiche. Questo permette all'intero assieme di ruotare, garantendo al contempo il supporto dei carichi assiali e radiali.],[
#image("combo reggispinta.png", width:40%)
])
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),[La risposta al momento di ribaltamento dipende fortemente dalla configurazione. Le rette d'azione intersecano l'asse del rotore in punti che fungono da "fuochi" per l'applicazione delle forze di reazione. 
Nella configurazione a 'O', le rette sono divergenti e la distanza tra i fuochi (braccio $h_2$) è notevole. A parità di momento esterno $M_f$, le forze di reazione $F$ richieste ai corpi volventi per generare la coppia equilibrante sono minori. La configurazione a 'O' resiste quindi molto meglio al momento flettente.
Nella configurazione a 'X', le rette sono convergenti, il braccio $h_1$ è ridotto ($h_2 > h_1$) e la capacità anti-ribaltamento è minore. Tuttavia, la soluzione risulta più compatta assialmente ed è preferibile se si vuole evitare di sovraccaricare il sistema opponendosi in modo troppo rigido alla flessione.],[#image("confronto x o .png", width:70%)])



