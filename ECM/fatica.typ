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
#let varepsilon = $epsilon$
#set page(
  numbering: "1",
  number-align: bottom + right,
)


#set heading(numbering: "1.")
= *Resistenza a Fatica dei Materiali e dei Componenti*

== Introduzione al cedimento a fatica <introduzione-al-cedimento-a-fatica>

Il cedimento a fatica si verifica in modo silente, senza macro-deformazioni plastiche premonitrici che possano fungere da allarme. Questo porta a un *collasso prematuro* e improvviso. Progettare componenti soggetti a carichi variabili nel tempo utilizzando esclusivamente i limiti di resistenza statica (come il limite di snervamento o il carico di rottura) sottovaluta gravemente il problema, poiché la rottura a fatica avviene a livelli tensionali nettamente inferiori.


il danneggiamento a fatica progredisce all'interno del materiale senza manifestazioni esterne visibili fino al collasso finale, che risulta repentino, irreversibile e spesso catastrofico per l'intero sistema (come storicamente evidenziato da gravi incidenti in ambito ferroviario e aeronautico).

// [DA SLIDE]
Nello specifico, l'applicazione di *carichi non costanti nel tempo*  e in particolare di sollecitazioni aventi un andamento temporale *ciclico* (o più in generale variabile)  può condurre alla rottura del componente anche quando la tensione massima raggiunta $sigma_"max"$ rimane sensibilmente inferiore:
- al *carico unitario di snervamento* del materiale, nel caso di comportamento *duttile*;
- al *carico unitario di rottura* del materiale, nel caso di comportamento *fragile*.

// [DA AUDIO]
Per un materiale metallico *duttile*, il fenomeno della fatica introduce dunque una duplice anomalia rispetto al comportamento statico:
1. *Abbassamento della soglia di cedimento:* la rottura si verifica per ampiezze di sollecitazione che interessano la regione iniziale *lineare elastica* del diagramma tensione-deformazione ($sigma$-$epsilon$), ben al di sotto della tensione di snervamento statico ($sigma_"max" < sigma_s$).
2. *Inversione del comportamento meccanico a rottura:* pur essendo il materiale intrinsecamente duttile, sotto carichi affaticanti esso non sviluppa una riserva di plasticizzazione macroscopica e manifesta una *frattura di carattere fragile*.

Si parla pertanto di *cedimento per fatica* nel materiale (termine introdotto per analogia con l'affaticamento fisico umano) e, conseguentemente, di *carichi e condizioni affaticanti*.


// [DA AUDIO]
=== Classificazione temporale dei carichi affaticanti

Dal punto di vista della storia temporale della sollecitazione, i carichi dinamici responsabili della fatica possono essere suddivisi in tre categorie:
1. *Carichi periodici ad ampiezza costante (fatica periodica semplice):* il segnale tensionale presenta una ripetitività regolare con un periodo temporale $T$ ben definito ed è caratterizzato da un'unica frequenza e da un'unica ampiezza di oscillazione. È il caso più semplice, descrivibile analiticamente mediante un'unica funzione armonica (seno o coseno), e costituisce il paradigma di riferimento per i calcoli di resistenza a fatica.
2. *Carichi periodici ad ampiezza variabile (fatica periodica complessa):* il segnale presenta localmente fluttuazioni irregolari con picchi di ampiezza differente, ma l'intero blocco di sollecitazioni si ripete ciclicamente nel tempo con un periodo caratteristico individuabile. In questo caso è possibile scomporre la storia di carico nella sovrapposizione di più segnali elementari ad ampiezza costante, estendendo i risultati del modello armonico di base (mediante ipotesi di danneggiamento cumulativo).
3. *Carichi aleatori o caotici :* la sollecitazione varia nel tempo in modo totalmente irregolare e non periodico (la storia tensionale non ripercorre mai il medesimo andamento). La caratterizzazione di tali carichi non può avvalersi di funzioni deterministiche, ma richiede necessariamente metodi statistici e probabilistici.

// [DA SLIDE]
=== Condizioni di innesco ed esempio classico della flessione rotante

Per comprendere correttamente quando un organo meccanico è soggetto a fatica, è fondamentale osservare lo stato di sollecitazione dal punto di vista *locale del singolo elemento di materiale* e non soltanto dal punto di vista del sistema di riferimento fisso esterno. Le condizioni che determinano l'instaurarsi della fatica sono infatti due:
1. l'applicazione di un *carico variabile nel tempo* (su una struttura ferma o in movimento);
2. l'applicazione di un *carico costante nel tempo (statico)* rispetto al quale la struttura compie un *moto ciclico*, come la rotazione.


Il caso studiato da *August Wöhler*  è quello degli *assali ferroviari* (o, più in generale, di un *albero in rotazione* soggetto a carichi trasversali):
- Le forze trasmesse dalle sospensioni del vagone alle estremità dell'assale sono sostanzialmente *statiche* (costanti nel tempo e dirette verticalmente verso il basso), ma la sezione resistente dell'albero ruota continuamente sotto di esse.
- Osservando la sezione trasversale nello spazio fisso, il momento flettente costante $M_f$ genera il classico diagramma lineare di tensione normale $sigma$ previsto dalla teoria della flessione: le fibre da un lato dell'asse neutro sono sollecitate a trazione ($sigma > 0$), quelle sull'asse neutro sono scariche ($sigma = 0$) e quelle sul lato opposto sono sollecitate a compressione ($sigma < 0$)
  Localmente, dunque, il materiale subisce una tensione variabile nel tempo con legge sinusoidale:
$ sigma(t) = sigma_"max" sin(omega t) $



// [DA SLIDE]
#figure(
  canvas(length: 1cm, {
    import draw: *

    // --- Sezione circolare dell'albero in rotazione ---
    let cx = 2.2
    let cy = 3.0
    let r = 1.5
    circle((cx, cy), radius: r, stroke: 1pt)
    // Assi di simmetria della sezione (asse neutro tratteggiato)
    line((cx - 1.9, cy), (cx + 1.9, cy), stroke: (dash: "dashed", thickness: 0.6pt))
    line((cx, cy - 1.8), (cx, cy + 1.8), stroke: (dash: "dashed", thickness: 0.6pt))
    content((cx, cy + 2.1), text(size: 8.5pt, weight: "bold")[Albero in rotazione])

    // Freccia interna del verso di rotazione
    arc((cx + 0.55, cy), start: 0deg, stop: 240deg, radius: 0.55, mark: (end: ">"), stroke: (paint: red, thickness: 0.9pt))
    content((cx + 0.1, cy - 0.1), text(red, size: 8pt)[$omega$])

    // Posizioni successive dello stesso punto materiale sulla periferia
    circle((cx + r, cy), radius: 0.12, fill: blue, stroke: none)
    circle((cx, cy + r), radius: 0.12, fill: blue, stroke: none)
    circle((cx - r, cy), radius: 0.12, fill: blue, stroke: none)
    circle((cx, cy - r), radius: 0.12, fill: blue, stroke: none)

    // --- Diagramma lineare della tensione di flessione sulla sezione ---
    let bx = 5.2
    line((bx, cy - 1.8), (bx, cy + 1.8), stroke: 1pt)
    line((bx - 1.1, cy - r), (bx + 1.1, cy + r), stroke: (paint: blue, thickness: 1pt))
    line((bx, cy + r), (bx + 1.1, cy + r), mark: (end: ">"), stroke: (paint: blue, thickness: 0.8pt))
    line((bx, cy - r), (bx - 1.1, cy - r), mark: (end: ">"), stroke: (paint: blue, thickness: 0.8pt))
    line((bx, cy + 0.75), (bx + 0.55, cy + 0.75), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))
    line((bx, cy - 0.75), (bx - 0.55, cy - 0.75), mark: (end: ">"), stroke: (paint: blue, thickness: 0.6pt))
    content((bx + 1.35, cy + r), text(blue, size: 8.5pt)[$+sigma_"max"$])
    content((bx - 1.4, cy - r), text(blue, size: 8.5pt)[$-sigma_"min"$])

    // Linee di proiezione dalla sezione al diagramma di flessione
    line((cx, cy + r), (bx, cy + r), stroke: (dash: "dotted", thickness: 0.6pt))
    line((cx, cy - r), (bx, cy - r), stroke: (dash: "dotted", thickness: 0.6pt))

    // --- Grafico temporale sigma(t) esplorato dal punto ---
    let gx = 7.6
    line((gx, cy - 2.0), (gx, cy + 2.2), mark: (end: ">"), stroke: 1pt)
    content((gx - 0.35, cy + 2.0), text(size: 9pt)[$sigma$])
    line((gx - 0.2, cy), (gx + 5.4, cy), mark: (end: ">"), stroke: 1pt)
    content((gx + 5.55, cy - 0.25), text(size: 9pt)[$t$])

    // Linee guida dei valori massimi e minimi
    line((gx, cy + r), (gx + 4.8, cy + r), stroke: (dash: "dotted", thickness: 0.6pt))
    line((gx, cy - r), (gx + 4.8, cy - r), stroke: (dash: "dotted", thickness: 0.6pt))

    // Onda sinusoidale (2 cicli completi)
    bezier((gx, cy), (gx + 1.2, cy), (gx + 0.4, cy + 2.0), (gx + 0.8, cy + 2.0), stroke: (paint: blue, thickness: 1.1pt))
    bezier((gx + 1.2, cy), (gx + 2.4, cy), (gx + 1.6, cy - 2.0), (gx + 2.0, cy - 2.0), stroke: (paint: blue, thickness: 1.1pt))
    bezier((gx + 2.4, cy), (gx + 3.6, cy), (gx + 2.8, cy + 2.0), (gx + 3.2, cy + 2.0), stroke: (paint: blue, thickness: 1.1pt))
    bezier((gx + 3.6, cy), (gx + 4.8, cy), (gx + 4.0, cy - 2.0), (gx + 4.4, cy - 2.0), stroke: (paint: blue, thickness: 1.1pt))
  }),
)

La condizione di sollecitazione dell'assale di Wöhler viene riprodotta in laboratorio mediante la *macchina di prova a flessione rotante* (schema di flessione a quattro punti): un provino cilindrico metallico viene posto in rotazione attorno al proprio asse e vincolato tramite quattro supporti (due interni e due esterni posti a quote differenti) che imprimono una curvatura costante, generando un *momento flettente costante* nel tratto centrale calibrato del campione. L'osservazione sperimentale di tale prova mette in luce due aspetti fondamentali:

 *Influenza della frequenza di carico e fatica termomeccanica:* in condizioni di prova corrette, la rottura a fatica di un provino in acciaio richiede tipicamente milioni di cicli (corrispondenti a molte ore di funzionamento) senza che si osservino vibrazioni o alterazioni macroscopiche fino all'istante del cedimento. Se tuttavia la velocità angolare di rotazione viene incrementata eccessivamente (frequenza di applicazione del carico troppo elevata), lo *smorzamento strutturale interno* del materiale genera una dissipazione energetica accelerata che non riesce a essere smaltita verso l'esterno. Ciò produce un forte riscaldamento localizzato nel tratto centrale del provino (fino all'incandescenza visibile), instaurando un forte gradiente termico nel tempo: alla fatica meccanica si sovrappone così un fenomeno di *fatica termica*, che degrada drasticamente le proprietà del materiale e conduce al collasso in pochi secondi.

// [DA SLIDE]
  *Influenza degli intagli:* Nella progettazione a fatica è fondamentale considerare che la presenza di variazioni di sezione molto brusche nel componente — denominate *intagli* (quali spallamenti a raggio ridotto, fori, gole o cave) — genera severi picchi locali di tensione e influenza fortemente (riducendola in misura drastica) la resistenza a fatica dei componenti.
 la fatica è per sua natura un fenomeno di innesco *localizzato*, la concentrazione locale delle tensioni prodotta dalla discontinuità geometrica agisce esattamente nella regione superficiale in cui tende a nucleare il danno, accelerandone drasticamente la formazione e la successiva propagazione.


== Ciclo di sollecitazione e parametrizzazione <ciclo-di-sollecitazione-e-parametrizzazione>


// [DA AUDIO]
Sotto l'ipotesi di sollecitazione periodica, si definisce *ciclo di fatica* il minimo intervallo temporale completo durante il quale la tensione aumenta, diminuisce e ritorna al valore e alla tendenza di partenza. La durata di vita del componente viene espressa tramite il *numero di cicli* $N$ sopportati fino a rottura.

Per quanto riguarda il parametro di sollecitazione, nella maggior parte delle applicazioni ingegneristiche la caratterizzazione avviene *in termini di tensione* ($sigma$). Tuttavia, nei problemi di *fatica a basso numero di cicli* (o fatica oligociclica), in cui i carichi applicati sono così elevati da indurre la rottura dopo pochi cicli coinvolgendo direttamente il campo  plastico del materiale, è necessario ricorrere a una parametrizzazione *in termini di deformazione* ($varepsilon$).
#v(1em)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Per definire compiutamente un ciclo di fatica periodico, abbiamo bisogno di tre grandezze fondamentali: un parametro relativo al tempo (il numero di cicli) e due parametri relativi alla tensione (o deformazione). Come mostrato nella figura a fianco, un ciclo generico oscilla tra due valori estremi.
    
    I parametri operativi di base che definiscono gli estremi del ciclo sono:
    - $N$: Numero di cicli (parametro temporale).
    - $sigma_"max"$: Tensione massima raggiunta nel ciclo.
    - $sigma_"min"$: Tensione minima raggiunta nel ciclo.
  ],
  [
    #canvas(length: 1.2cm, {
  import draw: *

  // Linee di riferimento orizzontali e verticali
  line((0.3, 2.0), (4.5, 2.0), stroke: 0.5pt)
  line((1.2, 3.0), (6.3, 3.0), stroke: 0.5pt)
  line((2.4, 1.0), (5.7, 1.0), stroke: 0.5pt)
  line((0.6, 2.0), (0.6, 3.7), stroke: 0.5pt)
  line((3.0, 2.0), (3.0, 3.7), stroke: 0.5pt)

  // Curva sinusoidale (3 semionde, 1 bezier per ciascuna concavità)
  bezier((0.6, 2.0), (1.8, 2.0), (1.11, 3.33), (1.29, 3.33), stroke: 1.2pt)
  bezier((1.8, 2.0), (3.0, 2.0), (2.31, 0.67), (2.49, 0.67), stroke: 1.2pt)
  bezier((3.0, 2.0), (4.2, 2.0), (3.51, 3.33), (3.69, 3.33), stroke: 1.2pt)

  // Assi cartesiani
  line((0, 0), (0, 4.0), mark: (end: "triangle", fill: white, scale: 0.8), stroke: 0.8pt)
  line((0, 0), (7.2, 0), mark: (end: "triangle", fill: white, scale: 0.8), stroke: 0.8pt)

  // Quote (frecce doppie)
  line((0.6, 3.5), (3.0, 3.5), mark: (start: "triangle", end: "triangle", fill: white, scale: 0.7), stroke: 0.5pt)
  line((0.9, 0.0), (0.9, 2.0), mark: (start: "triangle", end: "triangle", fill: white, scale: 0.7), stroke: 0.5pt)
  line((2.1, 2.0), (2.1, 3.0), mark: (start: "triangle", end: "triangle", fill: white, scale: 0.7), stroke: 0.5pt)
  line((4.8, 0.0), (4.8, 1.0), mark: (start: "triangle", end: "triangle", fill: white, scale: 0.7), stroke: 0.5pt)
  line((5.4, 1.0), (5.4, 3.0), mark: (start: "triangle", end: "triangle", fill: white, scale: 0.7), stroke: 0.5pt)
  line((6.0, 0.0), (6.0, 3.0), mark: (start: "triangle", end: "triangle", fill: white, scale: 0.7), stroke: 0.5pt)

  // Etichette (tutte in blu come nell'immagine e con text(size: 7pt))
  content((-0.22, 3.45), text(size: 9pt, fill: rgb("#1f77b4"))[Tensione], angle: 90deg)
  content((6.85, -0.22), text(size: 9pt, fill: rgb("#1f77b4"))[Tempo])
  content((1.8, 3.68), text(size: 9pt, fill: rgb("#1f77b4"))[Ciclo di tensione])
  content((0.72, 1.0), text(size: 9pt, fill: rgb("#1f77b4"))[$sigma_m$], angle: 90deg)
  content((1.92, 2.5), text(size: 9pt, fill: rgb("#1f77b4"))[$sigma_a$], angle: 90deg)
  content((4.62, 0.5), text(size: 9pt, fill: rgb("#1f77b4"))[$sigma_"min"$], angle: 90deg)
  content((5.18, 2.0), text(size: 9pt, fill: rgb("#1f77b4"))[$Delta sigma = sigma_"max" - sigma_"min"$], angle: 90deg)
  content((6.22, 1.5), text(size: 9pt, fill: rgb("#1f77b4"))[$sigma_"max"$], angle: 90deg)
})
  ]
)
#v(1em)

A partire da questi valori estremi, la normativa definisce due parametri derivati, molto più utili per i calcoli di resistenza. Il primo inquadra il comportamento "statico" del sistema, il secondo l'ampiezza della fluttuazione dinamica:

     $ sigma_m : "Tensione media." quad quad quad sigma_m = (sigma_"max" + sigma_"min") / 2 $
     $ sigma_a: "Tensione alternata" quad quad quad sigma_a = (sigma_"max" - sigma_"min") / 2 $

Possiamo inoltre definire l'escursione tensionale totale (o campo di tensione) come la distanza tra il picco massimo e il minimo:
$ Delta sigma = sigma_"max" - sigma_"min" = 2 sigma_a $

// [DA AUDIO]
 nella letteratura moderna e nelle normative tecniche vigenti si preferisce tuttavia esprimere i calcoli e i diagrammi di resistenza direttamente in funzione della tensione alternata $sigma_a$ (pari alla semiampiezza picco-picco dell'onda armonica) e della tensione media $sigma_m$ (che rappresenta la componente statica o *bias* del segnale).

Un parametro adimensionale fondamentale per classificare la severità del ciclo è il rapporto di tensione $R$, definito come:
$ R = sigma_"min" / sigma_"max" $

// [DA SLIDE]
Accanto al rapporto di tensione $R$, si definisce anche il *rapporto di ampiezza* $R_a$, dato dal rapporto tra la tensione alternata e la tensione media:
$ R_a = sigma_a / sigma_m $

I due rapporti adimensionali $R$ e $R_a$ non sono indipendenti, ma sono legati biunivocamente tra loro. Sostituendo infatti le definizioni di $sigma_a$ e $sigma_m$ nell'espressione di $R_a$ e dividendo numeratore e denominatore per $sigma_"max"$, si ricava:
$ R_a = frac(sigma_a, sigma_m) = frac(frac(sigma_"max" - sigma_"min", 2), frac(sigma_"max" + sigma_"min", 2)) = frac(sigma_"max" - sigma_"min", sigma_"max" + sigma_"min") = frac(1 - frac(sigma_"min", sigma_"max"), 1 + frac(sigma_"min", sigma_"max")) = frac(1 - R, 1 + R) $

Analogamente, esprimendo $sigma_"min" = sigma_m - sigma_a$ e $sigma_"max" = sigma_m + sigma_a$ nella definizione di $R$ e dividendo numeratore e denominatore per $sigma_m$, si ottiene la relazione inversa:
$ R = frac(sigma_"min", sigma_"max") = frac(sigma_m - sigma_a, sigma_m + sigma_a) = frac(1 - frac(sigma_a, sigma_m), 1 + frac(sigma_a, sigma_m)) = frac(1 - R_a, 1 + R_a) $
#pagebreak()
// [DA AUDIO]
== Classificazione dei cicli di sollecitazione notevoli

In funzione della posizione del ciclo di tensione rispetto all'asse temporale (e dunque dei valori assunti da $sigma_m$, $sigma_"min"$, $sigma_"max"$ e dal rapporto di ciclo $R$), la letteratura tecnica identifica alcune configurazioni notevoli di frequente impiego progettuale e sperimentazione:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [1. *Ciclo alternato simmetrico (o ciclo di inversione):* è il ciclo impiegato da Wöhler nelle prove di flessione rotante. La componente statica è nulla e la tensione oscilla simmetricamente tra un massimo di trazione e un minimo di compressione di uguale modulo:
],[#figure(
  canvas(length: 0.95cm, {
    import draw: *

    // --- 1. Ciclo di inversione (R = -1) ---
    let x1 = 0.0
    let y0 = 2.0
    line((x1, y0 - 1.8), (x1, y0 + 2.0), mark: (end: ">"), stroke: 0.8pt)
    line((x1 - 0.2, y0), (x1 + 3.4, y0), mark: (end: ">"), stroke: 0.8pt)
    content((x1 - 0.25, y0 + 1.9), text(size: 8pt)[$sigma$])
    content((x1 + 3.55, y0 - 0.2), text(size: 8pt)[$t$])
    content((x1 + 1.6, y0 + 2.3), text(size: 8pt, weight: "bold")[Inversione ($R = -1$)])
    line((x1, y0 + 1.0), (x1 + 3.0, y0 + 1.0), stroke: (dash: "dotted", thickness: 0.5pt))
    line((x1, y0 - 1.0), (x1 + 3.0, y0 - 1.0), stroke: (dash: "dotted", thickness: 0.5pt))
    content((x1 - 0.5, y0 + 1.0), text(size: 7pt, fill: blue)[$+sigma_"max"$])
    content((x1 - 0.5, y0 - 1.0), text(size: 7pt, fill: blue)[$-sigma_"min"$])
    bezier((x1, y0), (x1 + 1.5, y0), (x1 + 0.5, y0 + 1.33), (x1 + 1.0, y0 + 1.33), stroke: (paint: blue, thickness: 1pt))
    bezier((x1 + 1.5, y0), (x1 + 3.0, y0), (x1 + 2.0, y0 - 1.33), (x1 + 2.5, y0 - 1.33), stroke: (paint: blue, thickness: 1pt))}))])
$ sigma_m = 0, quad sigma_"max" = -sigma_"min" = sigma_a, quad R = frac(sigma_"min", sigma_"max") = -1, quad R_a = oo $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [2. *Ciclo ripetuto dall'origine di trazione (o ciclo all'origine di trazione):* il ciclo si sviluppa interamente nel semipiano positivo (trazione) annullandosi periodicamente sull'asse temporale:
],[#figure(
  canvas(length: 0.95cm, {
    import draw: *
    let x1 = 0.0
    let y0 = 2.0
    let x2 = 4.5
    line((x2, y0 - 1.8), (x2, y0 + 2.0), mark: (end: ">"), stroke: 0.8pt)
    line((x2 - 0.2, y0), (x2 + 3.4, y0), mark: (end: ">"), stroke: 0.8pt)
    content((x2 - 0.25, y0 + 1.9), text(size: 8pt)[$sigma$])
    content((x2 + 3.55, y0 - 0.2), text(size: 8pt)[$t$])
    content((x2 + 1.6, y0 + 2.3), text(size: 8pt, weight: "bold")[Origine traz. ($R = 0$)])
    line((x2, y0 + 0.8), (x2 + 3.0, y0 + 0.8), stroke: (dash: "dashed", thickness: 0.5pt))
    line((x2, y0 + 1.6), (x2 + 3.0, y0 + 1.6), stroke: (dash: "dotted", thickness: 0.5pt))
    content((x2 - 0.45, y0 + 0.8), text(size: 7pt)[$sigma_m$])
    content((x2 - 0.5, y0 + 1.6), text(size: 7pt, fill: blue)[$sigma_"max"$])
    bezier((x2, y0 + 0.8), (x2 + 1.5, y0 + 0.8), (x2 + 0.5, y0 + 1.87), (x2 + 1.0, y0 + 1.87), stroke: (paint: blue, thickness: 1pt))
    bezier((x2 + 1.5, y0 + 0.8), (x2 + 3.0, y0 + 0.8), (x2 + 2.0, y0 - 0.27), (x2 + 2.5, y0 - 0.27), stroke: (paint: blue, thickness: 1pt))
  }))])
$ sigma_"min" = 0, quad sigma_"max" = 2 sigma_a = 2 sigma_m > 0, quad R = frac(0, sigma_"max") = 0, quad R_a = 1 $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [*Ciclo ripetuto dall'origine di compressione (o ciclo all'origine di compressione):* situazione duale alla precedente, in cui il ciclo si sviluppa nel semipiano negativo (compressione) con valore massimo nullo e valore minimo negativo di modulo pari al doppio dell'ampiezza alternata:
],[#figure(
  canvas(length: 0.95cm, {
    import draw: *
    let x1 = 0.0
    let y0 = 2.0
    let x2 = 4.5
    let x3 = 9.0
    line((x3, y0 - 1.8), (x3, y0 + 2.0), mark: (end: ">"), stroke: 0.8pt)
    line((x3 - 0.2, y0), (x3 + 3.4, y0), mark: (end: ">"), stroke: 0.8pt)
    content((x3 - 0.25, y0 + 1.9), text(size: 8pt)[$sigma$])
    content((x3 + 3.55, y0 - 0.2), text(size: 8pt)[$t$])
    content((x3 + 1.6, y0 + 2.3), text(size: 8pt, weight: "bold")[Origine compr. ($R = -oo$)])
    line((x3, y0 - 0.8), (x3 + 3.0, y0 - 0.8), stroke: (dash: "dashed", thickness: 0.5pt))
    line((x3, y0 - 1.6), (x3 + 3.0, y0 - 1.6), stroke: (dash: "dotted", thickness: 0.5pt))
    content((x3 - 0.45, y0 - 0.8), text(size: 7pt)[$sigma_m$])
    content((x3 - 0.5, y0 - 1.6), text(size: 7pt, fill: blue)[$sigma_"min"$])
    bezier((x3, y0 - 0.8), (x3 + 1.5, y0 - 0.8), (x3 + 0.5, y0 + 0.27), (x3 + 1.0, y0 + 0.27), stroke: (paint: blue, thickness: 1pt))
    bezier((x3 + 1.5, y0 - 0.8), (x3 + 3.0, y0 - 0.8), (x3 + 2.0, y0 - 1.87), (x3 + 2.5, y0 - 1.87), stroke: (paint: blue, thickness: 1pt))
  }))])
$ sigma_"max" = 0, quad sigma_"min" = -2 sigma_a = 2 sigma_m < 0, quad R = lim_(sigma_"max" -> 0^-) frac(sigma_"min", sigma_"max") = -oo, quad R_a = -1 $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [4. *Cicli pulsanti (di trazione o di compressione):* cicli nei quali la tensione non cambia mai segno né si annulla, rimanendo confinata nello stesso semipiano rispetto all'asse temporale:
   - #text(fill:blue.transparentize(0%), weight: "bold")[*Ciclo pulsante di trazione:*]  $sigma_"min" > 0$ e $sigma_"max" > 0$ (con $0 < R < 1$).
   - #text(fill:red.transparentize(10%), weight: "bold")[*Ciclo pulsante di compressione:*] $sigma_"min" < 0$ e $sigma_"max" < 0$ (con $1 < R < +oo$).],[#figure(
  canvas(length: 0.95cm, {
    import draw: *
    let x1 = 0.0
    let y0 = 2.0
    let x2 = 4.5
    let x4 = 13.5
    line((x4, y0 - 1.8), (x4, y0 + 2.0), mark: (end: ">"), stroke: 0.8pt)
    line((x4 - 0.2, y0), (x4 + 3.4, y0), mark: (end: ">"), stroke: 0.8pt)
    content((x4 - 0.25, y0 + 1.9), text(size: 8pt)[$sigma$])
    content((x4 + 3.55, y0 - 0.2), text(size: 8pt)[$t$])
    content((x4 + 1.6, y0 + 2.3), text(size: 8pt, weight: "bold")[Pulsanti ($R > 0$)])
    // Pulsante trazione (sopra)
    line((x4, y0 + 1.1), (x4 + 3.0, y0 + 1.1), stroke: (dash: "dashed", thickness: 0.5pt))
    bezier((x4, y0 + 1.1), (x4 + 1.5, y0 + 1.1), (x4 + 0.5, y0 + 1.75), (x4 + 1.0, y0 + 1.75), stroke: (paint: blue, thickness: 1pt))
    bezier((x4 + 1.5, y0 + 1.1), (x4 + 3.0, y0 + 1.1), (x4 + 2.0, y0 + 0.45), (x4 + 2.5, y0 + 0.45), stroke: (paint: blue, thickness: 1pt))
    // Pulsante compressione (sotto)
    line((x4, y0 - 1.1), (x4 + 3.0, y0 - 1.1), stroke: (dash: "dashed", thickness: 0.5pt))
    bezier((x4, y0 - 1.1), (x4 + 1.5, y0 - 1.1), (x4 + 0.5, y0 - 0.45), (x4 + 1.0, y0 - 0.45), stroke: (paint: red, thickness: 1pt))
    bezier((x4 + 1.5, y0 - 1.1), (x4 + 3.0, y0 - 1.1), (x4 + 2.0, y0 - 1.75), (x4 + 2.5, y0 - 1.75), stroke: (paint: red, thickness: 1pt))
    content((x4 + 1.6, y0 + 1.8), text(size: 7pt, fill:blue.transparentize(20%), weight: "bold")[trazione])
    content((x4 + 1.6, y0 - 1.8), text(size: 7pt, fill:red.transparentize(20%), weight: "bold")[compressione])
  }))])




#pagebreak()


== Analisi delle Rotture per Fatica <analisi-delle-rotture-per-fatica>

*Caratteristiche Generali:* Il cedimento a fatica è un fenomeno intrinsecamente *permanente* (non esiste recupero del danno), *progressivo* (basato sull'accumulo del danno ciclo dopo ciclo) e fortemente *localizzato*. Il processo si divide rigorosamente in tre fasi temporali distinte:

 *Fase 1: Nucleazione (o Innesco)* \
  Si innesca sempre a livello superficiale. L'azione dei carichi dinamici produce scorrimenti microscopici che generano ondulazioni, intrusioni ed estrusioni. Queste alterano la regolarità microscopica agendo come micro-intagli, che concentrano le tensioni e fessurano il materiale.

  // [DA SLIDE]
  _Meccanismo microstrutturale e paradosso elastico-plastico:_ Sotto l'azione di una sollecitazione ciclica $Delta F$, anche quando la tensione nominale è ampiamente inferiore al limite di snervamento del materiale, alcuni *grani cristallini superficiali favorevolmente orientati* reagiscono generando e muovendo *dislocazioni*. 
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
  Poiché il moto delle dislocazioni lungo i piani cristallini non è perfettamente reversibile tra la fase di carico e quella di scarico, l'accumulo dei cicli produce bande di scorrimento persistenti (*persistent slip bands*) che emergono in superficie sotto forma di *estrusioni* (*slipband extrusions*) e *intrusioni* (*ridges and grooves*), creando gradini e ondulazioni dell'ordine di $ mu"m"$. 
  
  Si tratta quindi di fenomeni di *natura plastica, ma strettamente localizzati* a livello microscopico, tanto che il comportamento globale (macroscopico) del componente rimane *ancora pienamente elastico*. Queste micro-irregolarità geometriche agiscono come severi innalzatori di tensione superficiali, rendendo la superficie incline alla fessurazione (innesco della micro-cricca).
],[#figure(
    canvas(length: 1cm, {
  import draw: *

  // Superficie metallica piana a sinistra
  line((1.10, 2.00), (3.30, 2.00), stroke: 1.3pt)

  // Primo blocco di piani di scorrimento (inclinati a 45 gradi, pendenza 1:1)
  line((1.90, 0.60), (3.50, 2.20), stroke: 1.2pt)
  line((2.28, 0.80), (3.88, 2.40), stroke: 1.2pt)
  line((2.66, 1.00), (3.88, 2.22), stroke: 1.2pt)
  line((3.04, 1.20), (4.44, 2.60), stroke: 1.2pt)
  line((3.42, 1.40), (4.62, 2.60), stroke: 1.2pt)
  line((3.75, 1.55), (4.95, 2.75), stroke: 1.2pt)
  line((4.10, 1.72), (5.13, 2.75), stroke: 1.2pt)
  line((4.35, 1.78), (5.60, 3.04), stroke: 1.2pt)
  line((4.35, 1.61), (5.78, 3.04), stroke: 1.2pt)
  line((4.35, 1.43), (5.78, 2.86), stroke: 1.2pt)
  line((4.45, 1.35), (5.88, 2.78), stroke: 1.2pt)
  line((4.45, 1.17), (5.88, 2.60), stroke: 1.2pt)
  line((4.45, 0.99), (5.98, 2.52), stroke: 1.2pt)
  line((4.55, 0.91), (6.08, 2.44), stroke: 1.2pt)
  line((4.55, 0.73), (6.08, 2.26), stroke: 1.2pt)
  line((4.60, 0.60), (6.08, 2.08), stroke: 1.2pt)
  line((4.65, 0.47), (6.13, 1.95), stroke: 1.2pt)
  line((4.68, 0.32), (6.16, 1.80), stroke: 1.2pt)
  line((4.68, 0.14), (6.16, 1.62), stroke: 1.2pt)

  // Gradini orizzontali del primo blocco (superiori e laterali destri)
  line((3.50, 2.20), (3.68, 2.20), stroke: 1.3pt)
  line((4.62, 2.60), (4.80, 2.60), stroke: 1.3pt)
  line((4.95, 2.75), (5.13, 2.75), stroke: 1.3pt)
  line((5.60, 3.04), (5.78, 3.04), stroke: 1.3pt)
  line((5.60, 2.86), (5.78, 2.86), stroke: 1.3pt)
  line((5.80, 2.34), (5.98, 2.34), stroke: 1.3pt)
  line((5.90, 2.26), (6.08, 2.26), stroke: 1.3pt)
  line((5.90, 2.08), (6.08, 2.08), stroke: 1.3pt)
  line((5.90, 1.90), (6.08, 1.90), stroke: 1.3pt)
  line((5.95, 1.77), (6.13, 1.77), stroke: 1.3pt)
  line((5.98, 1.62), (6.16, 1.62), stroke: 1.3pt)

  // Secondo blocco di piani di scorrimento (destra)
  line((5.15, 0.00), (6.68, 1.53), stroke: 1.2pt)
  line((5.60, 0.27), (6.76, 1.43), stroke: 1.2pt)
  line((5.95, 0.44), (7.10, 1.59), stroke: 1.2pt)
  line((6.30, 0.61), (7.55, 1.86), stroke: 1.2pt)
  line((6.60, 0.73), (7.73, 1.86), stroke: 1.2pt)
  line((6.80, 0.75), (8.25, 2.20), stroke: 1.2pt)
  line((6.80, 0.57), (8.35, 2.12), stroke: 1.2pt)
  line((6.85, 0.44), (8.38, 1.97), stroke: 1.2pt)
  line((6.95, 0.36), (8.40, 1.81), stroke: 1.2pt)
  line((7.05, 0.28), (8.45, 1.68), stroke: 1.2pt)

  // Gradini orizzontali del secondo blocco
  line((6.30, 1.45), (6.50, 1.45), stroke: 1.3pt)
  line((6.58, 1.53), (6.76, 1.53), stroke: 1.3pt)
  line((7.37, 1.86), (7.55, 1.86), stroke: 1.3pt)
  line((8.07, 2.20), (8.25, 2.20), stroke: 1.3pt)
  line((8.17, 2.02), (8.35, 2.02), stroke: 1.3pt)
  line((8.20, 1.84), (8.38, 1.84), stroke: 1.3pt)
  line((8.22, 1.66), (8.40, 1.66), stroke: 1.3pt)
  line((8.35, 1.50), (8.55, 1.50), stroke: 1.3pt)

  // Quota dello spessore della banda di scorrimento (circa 0.1 micrometri)
  line((5.95, 3.04), (7.00, 3.04), stroke: 0.6pt)
  line((5.95, 2.86), (7.00, 2.86), stroke: 0.6pt)
  line((6.52, 3.50), (6.52, 3.04), mark: (end: ">", fill: black), stroke: 0.7pt)

  // Freccia indicatrice della superficie metallica (arancione)
  line((1.55, 2.62), (2.68, 2.15), mark: (end: ">", fill: orange), stroke: (paint: orange, thickness: 1.3pt))

  // Freccia doppia del carico ciclico Delta F (rossa)
  line((0.00, 0.10), (1.85, 0.10), mark: (start: ">", end: ">", fill: red), stroke: (paint: red, thickness: 1.5pt))

  // Etichette
  content((2.05, 3.45), text(size: 16pt)[Superficie])
  content((2.05, 2.90), text(size: 16pt)[metallica])
  content((7.40, 3.85), text(size: 15pt)[$approx 0.1 thin mu"m"$])
  content((0.92, 0.65), text(fill: red, size: 17pt)[$Delta "F"$])
}))])
  // [DA AUDIO]
  Tale disordine microstrutturale si genera anche qualora la superficie metallica di partenza sia *perfettamente liscia e lappata a specchio* (priva di rugosità o difetti iniziali). Inoltre, l'effetto di concentrazione tensionale non è uniforme lungo il profilo ondulato: mentre sugli *apici* delle estrusioni sporgenti l'innalzamento tensionale è poco sensibile, sul fondo delle *gole* (intrusioni e rientranze a spigolo vivo) si crea un vero e proprio *intaglio occulto* fortemente localizzato, nel quale l'intensificazione delle tensioni supera localmente la resistenza del materiale provocando la micro-fessurazione iniziale.

  

- *Fase 2: Propagazione Stabile* \
  Consiste nel progressivo avanzamento della microfrattura all'interno del materiale. La superficie risultante è tipicamente caratterizzata da due elementi:
  - Presenza di _"linee di spiaggia"_ (beachmarks), segni fisici permanenti che mappano le pause o le variazioni macroscopiche del fronte di scorrimento.
  - Una morfologia liscia, dovuta al continuo "martellamento" tra i lembi della cricca che si aprono e si chiudono durante le inversioni del carico, appiattendo le asperità.
    // [DA AUDIO]
    L'avanzamento e l'avvicinamento ripetuto dei due lembi della frattura produce un *gradiente di levigatezza e lucentezza* lungo la superficie di propagazione: la regione immediatamente adiacente all'innesco, essendosi fessurata per prima, subisce il maggior numero complessivo di cicli di martellamento e appare quindi *estremamente vellutata al tatto e molto lucente*.
  All'apice della cricca si sviluppano altissime tensioni che incrudiscono localmente il materiale (blunting). I cicli successivi devono accumulare maggiore energia per lacerare questa "bolla" resistente, causando continui aggiustamenti nella direzione di propagazione, facendo ruotare localmente la direzione delle tensioni tangenti all'apice, producendo arrotondamenti dell'apice stesso e deviazioni microscopiche del percorso di taglio.

  
  
  

- *Fase 3: Rottura Finale Instabile (Schianto)* \
  Rappresenta il collasso istantaneo. La progressione ciclica erode la sezione resistente fino a renderla troppo esigua per sopportare le sollecitazioni. Superato il limite di tenacità, la propagazione diventa subitanea. Questa superficie si presenta *ruvida, scabrosa e fragile*, poiché distaccandosi istantaneamente non subisce il martellamento tipico della fase precedente.

  // [DA AUDIO]
  Poiché in quest'ultima fase la sezione residua è ormai insufficiente e la tensione locale supera il limite di resistenza statica oltre che la tenacità a frattura, i due lembi si separano in un unico istante senza alcuna possibilità di richiudersi: ne consegue che la *linea di frontiera* (demarcazione) tra la regione martellata e la regione scabrosa di rottura finale risulta sempre *estremamente netta*.

  // [DA SLIDE]
  Sebbene la rottura finale presenti tipicamente un *aspetto fragile* anche nei materiali duttili (a causa della severa triassialità delle tensioni all'apice della cricca e della rapidità del cedimento che impedisce la strizione globale), in prossimità dei bordi liberi esterni della zona di schianto possono formarsi dei *bordi di scorrimento a taglio* (*shear lips*, inclinati a $45^circ$) o porzioni di rottura finale duttile (per coalescenza di microvuoti) qualora lo stato di tensione piana locale consenta uno scorrimento plastico finale prima del distacco.

*Anatomia completa di una superficie di frattura a fatica:* Osservando macroscopicamente la sezione di un componente ceduto a fatica (ad esempio soggetto a trazione-compressione o flessione), si individuano sei regioni caratteristiche:
1. *Zona di nucleazione (innesco):* Punto o area perimetrale da cui si origina la cricca (spesso in corrispondenza di difetti superficiali, spallamenti o tracce di usura).
2. *Linee di arresto e di "spiaggia" (beachmarks):* Bande concentriche attorno all'innesco che segnano le posizioni successive del fronte di cricca in corrispondenza di arresti della macchina o variazioni dell'ampiezza del carico in esercizio che si progagano radialmente dalla zona di nucleazione.
3. *Zone con diversa granulosità:* Variazioni di rugosità nella regione di propagazione legate alla velocità di avanzamento della cricca (più fine e liscia vicino all'innesco dove la crescita è lenta, più grossolana man mano che ci si avvicina allo schianto).
4. *"Bordi radiali" (ratchet marks):* Gradini longitudinali quasi radiali che si formano quando più cricche si innescano in punti vicini su piani leggermente sfalsati; avanzando, i fronti di cricca si uniscono tramite un *cambiamento del piano di propagazione*, lasciando uno scalino visibile.
   // [DA AUDIO]
   Mentre le linee di spiaggia si propagano come onde concentriche, nelle sezioni circolari questi solchi si irradiano dal punto di nucleazione *come i raggi di un sole*.
5. *Zona di rottura finale (schianto):* Area ruvida e scabrosa di collasso statico istantaneo della sezione residua.
6. *Bordi di scorrimento a taglio (shear lips):* Smussi plastici localizzati sul contorno finale di distacco.
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
#figure(
  canvas(length: 1.3cm, {
  import draw: *

  // 1. RIEMPIMENTI (zona di rottura finale campita in grigio chiaro per rendere il retino denso)
  line(
    (-1.82, 0.15), (-1.75, 0.45), (-1.52, 0.72), (-1.15, 0.96), (-0.65, 1.12),
    (-0.10, 1.18), (0.45, 1.12), (0.92, 0.96), (1.12, 0.72),
    (0.75, 0.82), (0.25, 0.80), (-0.30, 0.65), (-0.82, 0.38), (-1.22, 0.02),
    (-1.42, -0.35), (-1.28, -0.69), (-1.56, -0.30),
    close: true,
    fill: black.transparentize(75%),
    stroke: none
  )

  // 2. ZONE CON DIVERSA GRANULOSITÀ E LINEE DI SPIAGGIA (archi punteggiati concentrici alla nucleazione)
  // Fascia 1 (interna)
  arc((1.02, -0.84), start: 62deg, stop: 188deg, radius: (0.46, 0.38), anchor: "origin", stroke: (dash: "dotted", thickness: 0.7pt))
  arc((1.02, -0.84), start: 62deg, stop: 188deg, radius: (0.52, 0.43), anchor: "origin", stroke: (dash: "dotted", thickness: 0.7pt))
  arc((1.02, -0.84), start: 62deg, stop: 188deg, radius: (0.58, 0.48), anchor: "origin", stroke: (dash: "dotted", thickness: 0.7pt))

  // Fascia 2 (intermedia)
  arc((1.02, -0.84), start: 68deg, stop: 192deg, radius: (0.96, 0.82), anchor: "origin", stroke: (dash: "dotted", thickness: 0.7pt))
  arc((1.02, -0.84), start: 68deg, stop: 192deg, radius: (1.03, 0.88), anchor: "origin", stroke: (dash: "dotted", thickness: 0.7pt))
  arc((1.02, -0.84), start: 68deg, stop: 192deg, radius: (1.10, 0.94), anchor: "origin", stroke: (dash: "dotted", thickness: 0.7pt))
  arc((1.02, -0.84), start: 68deg, stop: 192deg, radius: (1.17, 1.00), anchor: "origin", stroke: (dash: "dotted", thickness: 0.7pt))
  arc((1.02, -0.84), start: 68deg, stop: 192deg, radius: (1.24, 1.06), anchor: "origin", stroke: (dash: "dotted", thickness: 0.7pt))

  // Fascia 3 (esterna, più ampia)
  arc((1.02, -0.84), start: 70deg, stop: 187deg, radius: (1.58, 1.30), anchor: "origin", stroke: (dash: "dotted", thickness: 0.7pt))
  arc((1.02, -0.84), start: 77deg, stop: 187deg, radius: (1.65, 1.35), anchor: "origin", stroke: (dash: "dotted", thickness: 0.7pt))
  arc((1.02, -0.84), start: 78deg, stop: 187deg, radius: (1.72, 1.40), anchor: "origin", stroke: (dash: "dotted", thickness: 0.7pt))
  arc((1.02, -0.84), start: 79deg, stop: 187deg, radius: (1.79, 1.45), anchor: "origin", stroke: (dash: "dotted", thickness: 0.7pt))
  arc((1.02, -0.84), start: 80deg, stop: 184deg, radius: (1.86, 1.50), anchor: "origin", stroke: (dash: "dotted", thickness: 0.7pt))
  arc((1.02, -0.84), start: 82deg, stop: 183deg, radius: (1.93, 1.55), anchor: "origin", stroke: (dash: "dotted", thickness: 0.7pt))
  arc((1.02, -0.84), start: 84deg, stop: 182deg, radius: (2.00, 1.60), anchor: "origin", stroke: (dash: "dotted", thickness: 0.7pt))

  // 3. BORDI RADIALI (5 nervature sottili che partono dalla zona di nucleazione)
  // Bordo radiale 1 (in basso)
  bezier((0.80, -0.86), (-0.42, -0.90), (0.35, -0.82), (-0.05, -0.84), stroke: 0.6pt)
  bezier((0.80, -0.86), (-0.42, -0.90), (0.35, -0.89), (-0.05, -0.91), stroke: 0.6pt)

  // Bordo radiale 2 (medio-basso, indicato dalla freccia)
  bezier((0.82, -0.80), (-1.35, -0.25), (0.15, -0.52), (-0.65, -0.32), stroke: 0.6pt)
  bezier((0.82, -0.80), (-1.35, -0.25), (0.12, -0.60), (-0.68, -0.40), stroke: 0.6pt)

  // Bordo radiale 3 (centrale)
  bezier((0.90, -0.72), (-0.50, 0.50), (0.35, -0.28), (-0.22, 0.12), stroke: 0.6pt)
  bezier((0.90, -0.72), (-0.50, 0.50), (0.28, -0.34), (-0.28, 0.06), stroke: 0.6pt)

  // Bordo radiale 4 (medio-alto)
  bezier((1.00, -0.68), (0.76, 0.68), (0.68, -0.18), (0.62, 0.28), stroke: 0.6pt)
  bezier((1.00, -0.68), (0.76, 0.68), (0.60, -0.20), (0.54, 0.26), stroke: 0.6pt)

  // Bordo radiale 5 (destro)
  bezier((1.10, -0.66), (1.45, 0.02), (1.12, -0.36), (1.26, -0.14), stroke: 0.6pt)
  bezier((1.10, -0.66), (1.45, 0.02), (1.18, -0.40), (1.32, -0.18), stroke: 0.6pt)

  // 4. ZONA DI NUCLEAZIONE
  arc((1.02, -0.84), start: 38deg, stop: 196deg, radius: (0.22, 0.16), anchor: "origin", stroke: 0.8pt)

  // 5. CONTORNI PRINCIPALI DEL CILINDRO E DELLA SUPERFICIE DI FRATTURA
  // Parte anteriore-destra dell'ellisse di frattura (da 202deg a 402deg = 42deg)
  arc((0, 0), start: 220deg, stop: 402deg, radius: (1.70, 1.05), anchor: "origin", stroke: 1.2pt)

  // Arco esterno superiore della zona di rottura finale (rialzata)
  arc((-0.10, 0.13), start: 48deg, stop: 186deg, radius: (1.72, 1.05), anchor: "origin", stroke: 1.2pt)

  // Confine interno della zona di rottura finale (bordo di scorrimento a taglio interno)
  bezier((-1.28, -0.69), (-1.38, -0.22), (-1.38, -0.52), (-1.42, -0.35), stroke: 1.2pt)
  bezier((-1.38, -0.22), (0.82, 0.82), (-1.15, 0.55), (0.15, 0.98), stroke: 1.2pt)
  bezier((0.82, 0.82), (1.26, 0.70), (0.98, 0.80), (1.15, 0.76), stroke: 1.2pt)

  // Raccordi laterali del bordo di scorrimento a taglio (sinistro e destro)
  line((-1.82, 0.15), (-1.28, -0.69), stroke: 1.2pt)
  line((1.05, 0.91), (1.26, 0.70), stroke: 1.2pt)

  // Pareti verticali e fondo del cilindro
  line((-1.82, 0.15), (-1.82, -1.05), stroke: 1.2pt)
  line((1.70, 0.00), (1.70, -1.05), stroke: 1.2pt)
  arc((-0.06, -1.05), start: 180deg, stop: 360deg, radius: (1.76, 1.05), anchor: "origin", stroke: 1.2pt)

  // 6. FRECCE DI RICHIAMO
  // Zona di rottura finale
  line((-1.45, 1.25), (-0.96, 0.70), mark: (end: ">"), stroke: 0.6pt)

  // Bordi di scorrimento a taglio
  line((1.58, 1.15), (1.10, 0.82), mark: (end: ">"), stroke: 0.6pt)

  // Zone con diversa granulosità (4 frecce dallo stesso vertice)
  line((1.88, 0.86), (1.06, 0.66), mark: (end: ">"), stroke: 0.6pt)
  line((1.88, 0.86), (1.22, 0.40), mark: (end: ">"), stroke: 0.6pt)
  line((1.88, 0.86), (1.40, 0.20), mark: (end: ">"), stroke: 0.6pt)
  line((1.88, 0.86), (1.56, 0.05), mark: (end: ">"), stroke: 0.6pt)

  // Zona di nucleazione
  line((2.08, -1.12), (1.18, -0.82), mark: (end: ">"), stroke: 0.6pt)

  // Linee di arresto e di "spiaggia"
  line((-3.20, -1.62), (-0.45, -0.68), mark: (end: ">"), stroke: 0.6pt)

  // 'Bordi radiali'
  line((-2.65, 0.32), (-0.52, -0.40), mark: (end: ">"), stroke: 0.6pt)

  // 7. ETICHETTE (tutte interne all'immagine -> text(size: 7pt))
  content((-1.05, 1.42), text(size: 7pt)[Zona di rottura finale], anchor: "center")

  content((1.62, 1.48), text(size: 7pt)[Bordi di scorrimento], anchor: "west")
  content((1.62, 1.16), text(size: 7pt)[a taglio], anchor: "west")

  content((2.02, 0.82), text(size: 7pt)[Zone con diversa], anchor: "west")
  content((2.02, 0.50), text(size: 7pt)[granulosità], anchor: "west")

  content((2.08, -0.86), text(size: 7pt)[Zona di nucleazione], anchor: "west")

  content((-4.55, 0.48), text(size: 7pt)[‘Bordi radiali’], anchor: "west")
  content((-4.55, 0.16), text(size: 7pt)[(cambiamento], anchor: "west")
  content((-4.55, -0.16), text(size: 7pt)[del piano], anchor: "west")
  content((-4.55, -0.48), text(size: 7pt)[di propagazione)], anchor: "west")

  content((-3.30, -1.92), text(size: 7pt)[Linee di arresto e di], anchor: "center")
  content((-3.30, -2.24), text(size: 7pt)[“spiaggia”], anchor: "center")
  content((-3.30, -2.56), text(size: 7pt)[(beachmarks)], anchor: "center")
})
)],[#image("linee_di_spiaggia.jpg", width: 80%)])


*Esempi reali di innesco su organi di macchine:* Nella pratica ingegneristica l'innesco è spesso innescato dalla sinergia tra geometria e condizioni superficiali:
- *Alberi con spallamento:* La brusca variazione di diametro crea una concentrazione di tensione alla radice dello spallamento da cui parte la zona liscia e rilucente di propagazione, seguita dalla zona scabrosa di schianto.
  // [DA AUDIO]
  Una situazione ancora più severa si verifica quando in corrispondenza dello spallamento viene praticato un *foro di lubrificazione*: la sovrapposizione dell'intaglio dovuto alla brusca riduzione di diametro e dell'intaglio dovuto al foro genera un picco tensionale localizzato che innesca una zona di propagazione liscia a forma pressoché conica.
  
- *Perno di biella (interazione usura-fatica):* Sulla superficie del perno, il contatto strisciante genera *striature dovute ad usura* e *linee di passaggio di portata* che degradano la finitura superficiale che agiscono da innesco per la cricca di fatica.

*Deduzioni Diagnostiche dall'Analisi Frattografica:* Leggere l'aspetto morfologico del pezzo collassato fornisce parametri inestimabili sulle effettive condizioni di utilizzo:

- *Morfologia dell'innesco:* La presenza di *inneschi multipli* (punti sorgente allineati lungo il perimetro) è un forte indicatore di severi effetti di intaglio, tipicamente imputabili a variazioni brusche di sezione o errori di progettazione (es. spigoli vivi non raccordati).


// [DA SLIDE]
 *Influenza combinata del tipo di sollecitazione e dell'effetto d'intaglio (Atlante Frattografico):* Incrociando la modalità di carico, il livello di tensione nominale (alta vs bassa) e la severità dell'intaglio (assente, debole o elevato) su sezioni circolari e rettangolari, la superficie di frattura assume configurazioni diagnostiche ben precise: la regione di rottura fragile finale (schianto) risulta *sempre più estesa nel pezzo intagliato* rispetto a quello liscio.
- *Sezioni quadrate e rettangolari:* Quando la sezione trasversale passa da circolare a quadrata o rettangolare, valgono i medesimi criteri interpretativi ma con l'*aggravante degli spigoli vivi* del profilo prismatico, i quali agiscono come ulteriori concentratori di tensione modificando localmente il contorno della zona martellata rispetto alla zona di schianto finale.
 #grid(
  columns: (0.7fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [*Carichi assiali (Trazione-Compressione):* Poiché la tensione nominale è uniforme su tutta la sezione, in un *provino liscio* (o con debole intaglio) la cricca si innesca in un singolo punto debole del perimetro e avanza con fronte convesso verso il bordo opposto. In presenza di un *forte effetto d'intaglio*, invece, l'innalzamento tensionale perimetrale fa nucleare la cricca simultaneamente lungo tutto il contorno, spostando la zona di rottura finale al centro della sezione.],[



#canvas(length: 0.9cm, {
  import draw: *

  // ==================== GRIGLIA DELLA TABELLA UNIFICATA ====================
  // Linee orizzontali
  line((0.0, 4.2), (11.6, 4.2), stroke: 1pt)
  line((0.0, 2.1), (11.6, 2.1), stroke: (dash: "dashed", thickness: 0.9pt))
  line((0.0, 0.0), (11.6, 0.0), stroke: 1pt)

  // Linee orizzontali nell'intestazione
  line((3.7, 4.85), (7.5, 4.85), stroke: 0.8pt)
  line((7.7, 4.85), (11.5, 4.85), stroke: 0.8pt)

  // Linee verticali continue dall'alto al basso
  line((3.6, 0.0), (3.6, 5.4), stroke: 1pt)
  line((5.6, 0.0), (5.6, 4.85), stroke: 0.8pt)
  line((7.6, 0.0), (7.6, 5.4), stroke: 1pt)
  line((9.6, 0.0), (9.6, 4.85), stroke: 0.8pt)
  line((11.6, 0.0), (11.6, 5.4), stroke: 1pt)

  // ==================== INTESTAZIONI (IN ITALIANO) ====================
  content((1.8, 4.75), text(size: 7pt)[MODALITÀ DI CARICO])
  content((9.6, 5.12), text(size: 7pt)[effetto d'intaglio elevato])

  content((4.6, 4.63), text(size: 7pt)[sforzo])
  content((4.6, 4.37), text(size: 7pt)[elevato])
  content((6.6, 4.63), text(size: 7pt)[sforzo])
  content((6.6, 4.37), text(size: 7pt)[basso])
  content((8.6, 4.63), text(size: 7pt)[sforzo])
  content((8.6, 4.37), text(size: 7pt)[elevato])
  content((10.6, 4.63), text(size: 7pt)[sforzo])
  content((10.6, 4.37), text(size: 7pt)[basso])


  // =========================================================================
  // RIGA 1: SEZIONE CIRCOLARE (y: 2.1 .. 4.2, y_c = 3.15)
  // =========================================================================

  // Colonna 0 Riga 1: trazione compressione
  content((0.2, 3.85), text(size: 7pt)[trazione compressione], anchor: "west")
  rect((0.95, 2.78), (2.85, 3.10), stroke: 0.9pt)
  line((0.85, 2.94), (0.35, 2.94), mark: (end: ">"), stroke: 0.9pt)
  line((2.95, 2.94), (3.45, 2.94), mark: (end: ">"), stroke: 0.9pt)

  // --- Riga 1, Col 1: (4.6, 3.15) Provino liscio, sforzo elevato ---
  line((3.97, 3.40), (4.3, 3.35), (4.6, 3.33), (4.9, 3.35), (5.23, 3.40), (5.28, 3.15), (5.18, 2.80), (4.95, 2.55), (4.6, 2.47), (4.25, 2.55), (4.02, 2.80), (3.92, 3.15), close: true, fill: black.transparentize(72%), stroke: none)
  circle((4.6, 3.15), radius: 0.68, stroke: 1pt)
  arc((4.6, 3.83), start: 210deg, stop: 330deg, radius: 0.22, anchor: "origin", stroke: 0.65pt)
  arc((4.6, 3.83), start: 204deg, stop: 336deg, radius: 0.38, anchor: "origin", stroke: 0.65pt)
  arc((4.6, 4.00), start: 222deg, stop: 318deg, radius: 0.67, anchor: "origin", stroke: 0.8pt)
  line((4.6, 3.83), (4.6, 3.35), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.6, 3.83), (4.32, 3.38), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.6, 3.83), (4.88, 3.38), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.6, 3.83), (4.12, 3.51), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.6, 3.83), (5.08, 3.51), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))

  // --- Riga 1, Col 2: (6.6, 3.15) Provino liscio, sforzo basso ---
  line((6.06, 2.73), (6.35, 2.68), (6.6, 2.66), (6.85, 2.68), (7.14, 2.73), (6.95, 2.53), (6.6, 2.47), (6.25, 2.53), close: true, fill: black.transparentize(72%), stroke: none)
  circle((6.6, 3.15), radius: 0.68, stroke: 1pt)
  arc((6.6, 3.83), start: 205deg, stop: 335deg, radius: 0.30, anchor: "origin", stroke: 0.65pt)
  arc((6.6, 3.83), start: 212deg, stop: 328deg, radius: 0.55, anchor: "origin", stroke: 0.65pt)
  arc((6.6, 3.83), start: 222deg, stop: 318deg, radius: 0.80, anchor: "origin", stroke: 0.65pt)
  arc((6.6, 3.83), start: 234deg, stop: 306deg, radius: 1.02, anchor: "origin", stroke: 0.65pt)
  arc((6.6, 3.83), start: 242deg, stop: 298deg, radius: 1.16, anchor: "origin", stroke: 0.8pt)
  line((6.6, 3.83), (6.6, 2.70), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.54, 3.82), (6.30, 2.73), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.66, 3.82), (6.90, 2.73), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.46, 3.80), (6.05, 2.97), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.74, 3.80), (7.15, 2.97), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))

  // --- Riga 1, Col 3: (8.6, 3.15) Intaglio elevato, sforzo elevato ---
  line((8.06, 2.97), (8.35, 3.03), (8.6, 3.05), (8.85, 3.03), (9.14, 2.97), (9.05, 2.73), (8.85, 2.59), (8.6, 2.55), (8.35, 2.59), (8.15, 2.73), close: true, fill: black.transparentize(72%), stroke: none)
  circle((8.6, 3.15), radius: 0.68, stroke: 1pt)
  circle((8.6, 3.15), radius: 0.60, stroke: 0.8pt)
  arc((8.6, 3.75), start: 215deg, stop: 325deg, radius: 0.22, anchor: "origin", stroke: 0.65pt)
  arc((8.20, 3.60), start: 245deg, stop: 350deg, radius: 0.24, anchor: "origin", stroke: 0.65pt)
  arc((9.00, 3.60), start: 190deg, stop: 295deg, radius: 0.24, anchor: "origin", stroke: 0.65pt)
  arc((8.04, 3.35), start: 275deg, stop: 375deg, radius: 0.22, anchor: "origin", stroke: 0.65pt)
  arc((9.16, 3.35), start: 165deg, stop: 265deg, radius: 0.22, anchor: "origin", stroke: 0.65pt)
  bezier((8.02, 3.23), (9.18, 3.23), (8.4, 3.35), (8.8, 3.35), stroke: 0.65pt)
  bezier((8.06, 2.97), (9.14, 2.97), (8.4, 3.07), (8.8, 3.07), stroke: 0.8pt)
  line((8.6, 3.75), (8.6, 3.33), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.35, 3.69), (8.45, 3.30), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.85, 3.69), (8.75, 3.30), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.12, 3.51), (8.28, 3.05), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((9.08, 3.51), (8.92, 3.05), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.02, 3.27), (8.18, 3.00), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((9.18, 3.27), (9.02, 3.00), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))

  // --- Riga 1, Col 4: (10.6, 3.15) Intaglio elevato, sforzo basso ---
  line((10.22, 2.83), (10.45, 2.87), (10.75, 2.87), (10.98, 2.83), (10.92, 2.63), (10.6, 2.55), (10.28, 2.63), close: true, fill: black.transparentize(72%), stroke: none)
  circle((10.6, 3.15), radius: 0.68, stroke: 1pt)
  circle((10.6, 3.15), radius: 0.60, stroke: 0.8pt)
  arc((10.6, 3.75), start: 205deg, stop: 335deg, radius: 0.25, anchor: "origin", stroke: 0.65pt)
  arc((10.6, 3.75), start: 212deg, stop: 328deg, radius: 0.46, anchor: "origin", stroke: 0.65pt)
  arc((10.6, 3.75), start: 222deg, stop: 318deg, radius: 0.68, anchor: "origin", stroke: 0.65pt)
  bezier((10.04, 3.01), (11.16, 3.01), (10.4, 3.09), (10.8, 3.09), stroke: 0.65pt)
  line((10.22, 2.83), (10.45, 2.87), (10.75, 2.87), (10.98, 2.83), stroke: 0.8pt)
  line((10.6, 3.75), (10.6, 2.89), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.35, 3.69), (10.35, 2.89), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.85, 3.69), (10.85, 2.89), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.12, 3.50), (10.20, 2.97), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((11.08, 3.50), (11.00, 2.97), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))


  // =========================================================================
  // RIGA 2: SEZIONE RETTANGOLARE (y: 0.0 .. 2.1, y_c = 1.05)
  // =========================================================================

  // Colonna 0 Riga 2: trazione-compressione / trazione-trazione con trave 3D incastrata
  content((0.2, 1.80), text(size: 7pt)[trazione - compressione], anchor: "west")
  content((0.5, 1.40), text(size: 7pt)[trazione - trazione], anchor: "west")

  // Parete curva d'incastro a sinistra
  bezier((1.15, 1.15), (0.85, 0.85), (1.02, 1.12), (0.88, 0.98), stroke: 0.8pt)
  bezier((0.85, 0.85), (0.85, 0.35), (0.80, 0.65), (0.80, 0.50), stroke: 0.8pt)
  bezier((0.85, 0.35), (1.25, 0.28), (0.95, 0.22), (1.15, 0.22), stroke: 0.8pt)
  line((1.25, 0.28), (1.35, 0.42), stroke: 0.8pt)
  line((1.15, 1.15), (1.32, 0.88), stroke: 0.8pt)
  // Tratteggio d'incastro
  line((1.10, 1.13), (1.00, 1.21), stroke: 0.6pt)
  line((0.98, 1.04), (0.88, 1.12), stroke: 0.6pt)
  line((0.89, 0.92), (0.79, 1.00), stroke: 0.6pt)
  line((0.84, 0.78), (0.74, 0.86), stroke: 0.6pt)
  line((0.82, 0.64), (0.72, 0.72), stroke: 0.6pt)
  line((0.82, 0.50), (0.72, 0.58), stroke: 0.6pt)
  line((0.85, 0.36), (0.75, 0.44), stroke: 0.6pt)
  // Parallelepipedo (trave a sezione rettangolare in prospettiva)
  rect((1.05, 0.42), (2.45, 0.76), stroke: 0.9pt)
  line((1.05, 0.76), (1.28, 0.88), (2.68, 0.88), (2.45, 0.76), stroke: 0.9pt)
  line((2.68, 0.88), (2.68, 0.54), (2.45, 0.42), stroke: 0.9pt)
  // Doppia freccia a destra
  line((2.80, 0.65), (3.42, 0.65), mark: (start: ">", end: ">"), stroke: 0.9pt)

  // --- Riga 2, Col 1: (4.6, 1.05) Provino liscio, sforzo elevato ---
  // Rettangolo: x in [3.88, 5.32], y in [0.49, 1.61]
  line((4.15, 1.61), (4.06, 1.38), (4.18, 1.22), (4.55, 1.08), (4.98, 1.00), (5.32, 1.05), (5.32, 0.49), (3.88, 0.49), (3.88, 1.61), close: true, fill: black.transparentize(72%), stroke: none)
  rect((3.88, 0.49), (5.32, 1.61), stroke: 1pt)
  bezier((4.15, 1.61), (4.55, 1.08), (4.02, 1.32), (4.25, 1.15), stroke: 0.8pt)
  bezier((4.55, 1.08), (5.32, 1.05), (4.85, 1.00), (5.15, 1.00), stroke: 0.8pt)
  arc((4.80, 1.61), start: 195deg, stop: 345deg, radius: (0.28, 0.18), anchor: "origin", stroke: 0.65pt)
  bezier((4.32, 1.61), (5.32, 1.24), (4.30, 1.25), (4.95, 1.18), stroke: 0.65pt)
  line((4.65, 1.56), (4.36, 1.22), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.82, 1.54), (4.94, 1.05), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.98, 1.56), (5.25, 1.32), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.52, 1.58), (4.18, 1.42), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))

  // --- Riga 2, Col 2: (6.6, 1.05) Provino liscio, sforzo basso ---
  // Rettangolo: x in [5.88, 7.32], y in [0.49, 1.61]
  line((6.06, 1.61), (6.08, 1.25), (6.25, 0.92), (6.65, 0.72), (7.05, 0.72), (7.32, 0.78), (7.32, 0.49), (5.88, 0.49), (5.88, 1.61), close: true, fill: black.transparentize(72%), stroke: none)
  rect((5.88, 0.49), (7.32, 1.61), stroke: 1pt)
  bezier((6.06, 1.61), (6.45, 0.80), (6.05, 1.15), (6.20, 0.90), stroke: 0.8pt)
  bezier((6.45, 0.80), (7.32, 0.78), (6.75, 0.68), (7.10, 0.72), stroke: 0.8pt)
  arc((6.82, 1.61), start: 195deg, stop: 345deg, radius: (0.24, 0.16), anchor: "origin", stroke: 0.65pt)
  bezier((6.42, 1.61), (7.32, 1.32), (6.45, 1.30), (7.00, 1.26), stroke: 0.65pt)
  bezier((6.24, 1.61), (7.32, 1.12), (6.25, 1.12), (7.90 - 1.0, 1.05), stroke: 0.65pt)
  bezier((6.14, 1.61), (7.32, 0.94), (6.15, 0.95), (6.80, 0.88), stroke: 0.65pt)
  line((6.68, 1.56), (6.32, 1.05), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.85, 1.54), (7.05, 0.82), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((7.00, 1.56), (7.26, 1.25), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.55, 1.58), (6.15, 1.35), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))

  // --- Riga 2, Col 3: (8.6, 1.05) Intaglio elevato, sforzo elevato ---
  // Rettangolo esterno: [7.88, 9.32] x [0.49, 1.61], interno: [7.96, 9.24] x [0.57, 1.53]
  line((8.22, 1.20), (8.45, 1.16), (8.60, 1.15), (8.75, 1.16), (8.98, 1.20), (9.02, 1.05), (8.98, 0.88), (8.75, 0.93), (8.60, 0.94), (8.45, 0.93), (8.22, 0.88), (8.18, 1.05), close: true, fill: black.transparentize(72%), stroke: 0.8pt)
  rect((7.88, 0.49), (9.32, 1.61), stroke: 1pt)
  rect((7.96, 0.57), (9.24, 1.53), stroke: 0.8pt)
  arc((8.60, 1.53), start: 205deg, stop: 335deg, radius: (0.28, 0.16), anchor: "origin", stroke: 0.65pt)
  bezier((7.96, 1.18), (8.28, 1.53), (8.18, 1.22), (8.25, 1.38), stroke: 0.65pt)
  bezier((8.92, 1.53), (9.24, 1.18), (8.95, 1.38), (9.02, 1.22), stroke: 0.65pt)
  bezier((8.10, 1.32), (9.10, 1.32), (8.45, 1.24), (8.75, 1.24), stroke: 0.65pt)
  arc((8.60, 0.57), start: 25deg, stop: 155deg, radius: (0.28, 0.16), anchor: "origin", stroke: 0.65pt)
  bezier((7.96, 0.88), (8.25, 0.57), (8.12, 0.85), (8.20, 0.70), stroke: 0.65pt)
  bezier((8.95, 0.57), (9.24, 0.88), (9.00, 0.70), (9.08, 0.85), stroke: 0.65pt)
  line((8.55, 1.53), (8.48, 1.22), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.75, 1.53), (8.82, 1.22), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.04, 1.42), (8.22, 1.24), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((7.96, 1.28), (8.18, 1.15), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((9.16, 1.42), (8.98, 1.24), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.50, 0.57), (8.42, 0.86), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.70, 0.57), (8.78, 0.86), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))

  // --- Riga 2, Col 4: (10.6, 1.05) Intaglio elevato, sforzo basso ---
  // Rettangolo esterno: [9.88, 11.32] x [0.49, 1.61], interno: [9.96, 11.24] x [0.57, 1.53]
  circle((10.60, 1.05), radius: (0.22, 0.08), fill: black.transparentize(72%), stroke: 0.8pt)
  rect((9.88, 0.49), (11.32, 1.61), stroke: 1pt)
  rect((9.96, 0.57), (11.24, 1.53), stroke: 0.8pt)
  line((10.26, 1.20), (10.60, 1.18), (10.94, 1.20), (10.96, 1.05), (10.94, 0.90), (10.60, 0.92), (10.26, 0.90), (10.24, 1.05), close: true, stroke: 0.65pt)
  arc((10.60, 1.53), start: 200deg, stop: 340deg, radius: (0.28, 0.14), anchor: "origin", stroke: 0.65pt)
  bezier((10.12, 1.53), (11.08, 1.53), (10.35, 1.28), (10.85, 1.28), stroke: 0.65pt)
  arc((10.60, 0.57), start: 20deg, stop: 160deg, radius: (0.28, 0.14), anchor: "origin", stroke: 0.65pt)
  bezier((10.12, 0.57), (11.08, 0.57), (10.35, 0.82), (10.85, 0.82), stroke: 0.65pt)
  arc((9.96, 1.05), start: -65deg, stop: 65deg, radius: (0.14, 0.24), anchor: "origin", stroke: 0.65pt)
  bezier((9.96, 1.38), (9.96, 0.72), (10.18, 1.20), (10.18, 0.90), stroke: 0.65pt)
  arc((11.24, 1.05), start: 115deg, stop: 245deg, radius: (0.14, 0.24), anchor: "origin", stroke: 0.65pt)
  bezier((11.24, 1.38), (11.24, 0.72), (11.02, 1.20), (11.02, 0.90), stroke: 0.65pt)
  line((10.60, 1.53), (10.60, 1.22), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.60, 0.57), (10.60, 0.88), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((9.96, 1.05), (10.20, 1.05), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((11.24, 1.05), (11.00, 1.05), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.32, 1.53), (10.42, 1.22), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.88, 1.53), (10.78, 1.22), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.32, 0.57), (10.42, 0.88), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.88, 0.57), (10.78, 0.88), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
})])
#v(1em)
  #grid(
  columns: (0.7fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [*Flessione piana unidirezionale (ripetuta o pulsante):* Solo un lembo della sezione (quello teso) è soggetto a trazione ciclica. La cricca nuclea esclusivamente sul lato teso e avanza verso la fibra compressa opposta. Se l'effetto d'intaglio è assente, le linee di spiaggia sono convesse verso l'interno; se l'effetto d'intaglio è elevato, la cricca corre più velocemente lungo i bordi esterni (dove la concentrazione tensionale è massima), incurvando il fronte di avanzamento fino a renderlo concavo.],[
#canvas(length: 0.9cm, {
  import draw: *

  // ==================== GRIGLIA DELLA TABELLA UNIFICATA ====================
  // Linee orizzontali
  line((0.0, 4.2), (11.6, 4.2), stroke: 1pt)
  line((0.0, 2.1), (11.6, 2.1), stroke: (dash: "dashed", thickness: 0.9pt))
  line((0.0, 0.0), (11.6, 0.0), stroke: 1pt)

  // Linee orizzontali nell'intestazione
  line((3.7, 4.85), (7.5, 4.85), stroke: 0.8pt)
  line((7.7, 4.85), (11.5, 4.85), stroke: 0.8pt)

  // Linee verticali continue dall'alto al basso
  line((3.6, 0.0), (3.6, 5.4), stroke: 1pt)
  line((5.6, 0.0), (5.6, 4.85), stroke: 0.8pt)
  line((7.6, 0.0), (7.6, 5.4), stroke: 1pt)
  line((9.6, 0.0), (9.6, 4.85), stroke: 0.8pt)
  line((11.6, 0.0), (11.6, 5.4), stroke: 1pt)

  // ==================== INTESTAZIONI (IN ITALIANO) ====================
  content((1.8, 4.75), text(size: 7pt)[MODALITÀ DI CARICO])
  content((9.6, 5.12), text(size: 7pt)[con effetto d'intaglio])

  content((4.6, 4.63), text(size: 7pt)[sforzo])
  content((4.6, 4.37), text(size: 7pt)[elevato])
  content((6.6, 4.63), text(size: 7pt)[sforzo])
  content((6.6, 4.37), text(size: 7pt)[basso])
  content((8.6, 4.63), text(size: 7pt)[sforzo])
  content((8.6, 4.37), text(size: 7pt)[elevato])
  content((10.6, 4.63), text(size: 7pt)[sforzo])
  content((10.6, 4.37), text(size: 7pt)[basso])


  // =========================================================================
  // RIGA 1: SEZIONE CIRCOLARE - FLESSIONE SEMPLICE (y: 2.1 .. 4.2, y_c = 3.15)
  // =========================================================================

  // Colonna 0 Riga 1: flessione semplice (barra 2D incastrata)
  content((0.2, 3.85), text(size: 7pt)[flessione semplice], anchor: "west")
  line((0.9, 2.45), (0.9, 3.30), stroke: 0.9pt)
  line((0.9, 2.50), (0.72, 2.38), stroke: 0.7pt)
  line((0.9, 2.63), (0.72, 2.51), stroke: 0.7pt)
  line((0.9, 2.76), (0.72, 2.64), stroke: 0.7pt)
  line((0.9, 2.89), (0.72, 2.77), stroke: 0.7pt)
  line((0.9, 3.02), (0.72, 2.90), stroke: 0.7pt)
  line((0.9, 3.15), (0.72, 3.03), stroke: 0.7pt)
  line((0.9, 3.28), (0.72, 3.16), stroke: 0.7pt)
  rect((0.9, 2.70), (2.8, 3.05), stroke: 0.9pt)
  arc((1.8, 3.20), start: -35deg, stop: -8deg, radius: 1.3, anchor: "origin", mark: (start: ">"), stroke: 0.9pt)

  // --- Riga 1, Col 1: (4.6, 3.15) Provino liscio, sforzo elevato ---
  line((3.97, 3.40), (4.3, 3.35), (4.6, 3.33), (4.9, 3.35), (5.23, 3.40), (5.28, 3.15), (5.18, 2.80), (4.95, 2.55), (4.6, 2.47), (4.25, 2.55), (4.02, 2.80), (3.92, 3.15), close: true, fill: black.transparentize(72%), stroke: none)
  circle((4.6, 3.15), radius: 0.68, stroke: 1pt)
  arc((4.6, 3.83), start: 210deg, stop: 330deg, radius: 0.22, anchor: "origin", stroke: 0.65pt)
  arc((4.6, 3.83), start: 202deg, stop: 338deg, radius: 0.38, anchor: "origin", stroke: 0.65pt)
  arc((4.6, 4.00), start: 222deg, stop: 318deg, radius: 0.67, anchor: "origin", stroke: 0.8pt)
  line((4.6, 3.83), (4.6, 3.35), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.6, 3.83), (4.32, 3.38), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.6, 3.83), (4.88, 3.38), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.6, 3.83), (4.12, 3.51), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.6, 3.83), (5.08, 3.51), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))

  // --- Riga 1, Col 2: (6.6, 3.15) Provino liscio, sforzo basso ---
  line((5.98, 2.87), (6.3, 2.83), (6.6, 2.81), (6.9, 2.83), (7.22, 2.87), (7.05, 2.60), (6.6, 2.47), (6.15, 2.60), close: true, fill: black.transparentize(72%), stroke: none)
  circle((6.6, 3.15), radius: 0.68, stroke: 1pt)
  arc((6.6, 3.83), start: 205deg, stop: 335deg, radius: 0.30, anchor: "origin", stroke: 0.65pt)
  arc((6.6, 3.83), start: 215deg, stop: 325deg, radius: 0.55, anchor: "origin", stroke: 0.65pt)
  arc((6.6, 3.83), start: 225deg, stop: 315deg, radius: 0.80, anchor: "origin", stroke: 0.65pt)
  line((5.98, 2.87), (6.3, 2.83), (6.6, 2.81), (6.9, 2.83), (7.22, 2.87), stroke: 0.8pt)
  line((6.6, 3.83), (6.6, 2.85), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.50, 3.81), (6.28, 2.87), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.70, 3.81), (6.92, 2.87), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.40, 3.77), (6.04, 3.03), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.80, 3.77), (7.16, 3.03), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))

  // --- Riga 1, Col 3: (8.6, 3.15) Intaglio elevato, sforzo elevato ---
  line((8.03, 3.33), (8.25, 3.37), (8.6, 3.27), (8.95, 3.37), (9.17, 3.33), (9.20, 3.10), (9.10, 2.80), (8.88, 2.60), (8.6, 2.55), (8.32, 2.60), (8.10, 2.80), (8.00, 3.10), close: true, fill: black.transparentize(72%), stroke: none)
  circle((8.6, 3.15), radius: 0.68, stroke: 1pt)
  circle((8.6, 3.15), radius: 0.60, stroke: 0.8pt)
  arc((8.6, 3.75), start: 210deg, stop: 330deg, radius: 0.24, anchor: "origin", stroke: 0.65pt)
  arc((8.25, 3.65), start: 235deg, stop: 345deg, radius: 0.20, anchor: "origin", stroke: 0.65pt)
  arc((8.95, 3.65), start: 195deg, stop: 305deg, radius: 0.20, anchor: "origin", stroke: 0.65pt)
  line((8.08, 3.45), (9.12, 3.45), stroke: 0.65pt)
  bezier((8.03, 3.33), (9.17, 3.33), (8.4, 3.20), (8.8, 3.20), stroke: 0.8pt)
  line((8.6, 3.75), (8.6, 3.30), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.35, 3.69), (8.40, 3.33), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.85, 3.69), (8.80, 3.33), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.15, 3.53), (8.22, 3.35), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((9.05, 3.53), (8.98, 3.35), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))

  // --- Riga 1, Col 4: (10.6, 3.15) Intaglio elevato, sforzo basso ---
  line((10.20, 2.83), (10.45, 2.89), (10.75, 2.89), (11.00, 2.83), (10.88, 2.61), (10.6, 2.55), (10.32, 2.61), close: true, fill: black.transparentize(72%), stroke: none)
  circle((10.6, 3.15), radius: 0.68, stroke: 1pt)
  circle((10.6, 3.15), radius: 0.60, stroke: 0.8pt)
  arc((10.6, 3.75), start: 205deg, stop: 335deg, radius: 0.26, anchor: "origin", stroke: 0.65pt)
  arc((10.6, 3.75), start: 215deg, stop: 325deg, radius: 0.50, anchor: "origin", stroke: 0.65pt)
  bezier((10.02, 3.03), (11.18, 3.03), (10.4, 3.13), (10.8, 3.13), stroke: 0.65pt)
  line((10.20, 2.83), (10.45, 2.89), (10.75, 2.89), (11.00, 2.83), stroke: 0.8pt)
  line((10.6, 3.75), (10.6, 2.93), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.32, 3.67), (10.30, 2.90), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.88, 3.67), (10.90, 2.90), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.10, 3.49), (10.15, 3.00), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((11.10, 3.49), (11.05, 3.00), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))


  // =========================================================================
  // RIGA 2: SEZIONE RETTANGOLARE - FLESSIONE SEMPLICE (y: 0.0 .. 2.1, y_c = 1.05)
  // =========================================================================

  // Colonna 0 Riga 2: flessione semplice con trave 3D incastrata e freccia curva
  content((0.2, 1.75), text(size: 7pt)[flessione semplice], anchor: "west")

  // Parete curva d'incastro a sinistra
  bezier((1.15, 1.25), (0.85, 0.95), (1.02, 1.22), (0.88, 1.08), stroke: 0.8pt)
  bezier((0.85, 0.95), (0.85, 0.35), (0.80, 0.72), (0.80, 0.52), stroke: 0.8pt)
  bezier((0.85, 0.35), (1.25, 0.28), (0.95, 0.22), (1.15, 0.22), stroke: 0.8pt)
  line((1.25, 0.28), (1.35, 0.45), stroke: 0.8pt)
  line((1.15, 1.25), (1.32, 0.95), stroke: 0.8pt)
  // Tratteggio d'incastro
  line((1.10, 1.23), (1.00, 1.31), stroke: 0.6pt)
  line((0.98, 1.14), (0.88, 1.22), stroke: 0.6pt)
  line((0.89, 1.00), (0.79, 1.08), stroke: 0.6pt)
  line((0.84, 0.84), (0.74, 0.92), stroke: 0.6pt)
  line((0.82, 0.68), (0.72, 0.76), stroke: 0.6pt)
  line((0.82, 0.52), (0.72, 0.60), stroke: 0.6pt)
  line((0.85, 0.36), (0.75, 0.44), stroke: 0.6pt)
  // Parallelepipedo (trave a sezione rettangolare in prospettiva)
  rect((1.05, 0.45), (2.45, 0.82), stroke: 0.9pt)
  line((1.05, 0.82), (1.28, 0.95), (2.68, 0.95), (2.45, 0.82), stroke: 0.9pt)
  line((2.68, 0.95), (2.68, 0.58), (2.45, 0.45), stroke: 0.9pt)
  // Freccia curva di flessione a destra
  arc((1.85, 1.02), start: -35deg, stop: -8deg, radius: 1.3, anchor: "origin", mark: (start: ">"), stroke: 0.9pt)

  // --- Riga 2, Col 1: (4.6, 1.05) Provino liscio, sforzo elevato ---
  // Rettangolo verticale: x in [4.06, 5.14], y in [0.39, 1.71]
  // Zona di rottura finale nei ~3/5 inferiori con bordo superiore concavo
  line((4.06, 1.32), (4.22, 1.15), (4.48, 1.08), (4.85, 1.06), (5.14, 1.18), (5.14, 0.39), (4.06, 0.39), close: true, fill: black.transparentize(72%), stroke: none)
  rect((4.06, 0.39), (5.14, 1.71), stroke: 1pt)
  bezier((4.06, 1.32), (5.14, 1.18), (4.35, 1.02), (4.85, 1.02), stroke: 0.8pt)
  // Fronti di propagazione dall'innesco in (4.55, 1.71)
  arc((4.55, 1.71), start: 195deg, stop: 345deg, radius: (0.24, 0.16), anchor: "origin", stroke: 0.65pt)
  bezier((4.15, 1.71), (5.14, 1.44), (4.25, 1.22), (4.75, 1.20), stroke: 0.65pt)
  // Frecce radiali (con leggera trasparenza)
  line((4.52, 1.65), (4.35, 1.22), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.64, 1.65), (4.78, 1.18), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.38, 1.68), (4.16, 1.38), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.76, 1.68), (5.05, 1.48), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))

  // --- Riga 2, Col 2: (6.6, 1.05) Provino liscio, sforzo basso ---
  // Rettangolo verticale: x in [6.06, 7.14], y in [0.39, 1.71]
  // Zona di rottura finale nel terzo inferiore
  line((6.06, 0.96), (6.35, 0.82), (6.68, 0.72), (6.95, 0.75), (7.14, 0.88), (7.14, 0.39), (6.06, 0.39), close: true, fill: black.transparentize(72%), stroke: none)
  rect((6.06, 0.39), (7.14, 1.71), stroke: 1pt)
  bezier((6.06, 0.96), (7.14, 0.88), (6.50, 0.68), (6.90, 0.68), stroke: 0.8pt)
  // Fronti di propagazione dall'innesco in (6.66, 1.71)
  arc((6.66, 1.71), start: 195deg, stop: 345deg, radius: (0.24, 0.15), anchor: "origin", stroke: 0.65pt)
  bezier((6.28, 1.71), (7.14, 1.38), (6.32, 1.32), (6.85, 1.25), stroke: 0.65pt)
  bezier((6.06, 1.35), (7.14, 1.08), (6.35, 1.00), (6.85, 0.95), stroke: 0.65pt)
  // Frecce radiali (con leggera trasparenza)
  line((6.60, 1.65), (6.42, 0.90), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.72, 1.65), (6.92, 0.85), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.48, 1.68), (6.15, 1.20), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.85, 1.68), (7.08, 1.25), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))

  // --- Riga 2, Col 3: (8.6, 1.05) Intaglio elevato, sforzo elevato ---
  // Rettangolo esterno: [8.06, 9.14] x [0.39, 1.71], interno: [8.14, 9.06] x [0.47, 1.63]
  // Zona di rottura finale nei ~3/5 inferiori con bordo ondulato
  line((8.14, 1.12), (8.35, 1.18), (8.60, 1.12), (8.88, 1.20), (9.06, 1.16), (9.06, 0.47), (8.14, 0.47), close: true, fill: black.transparentize(72%), stroke: none)
  rect((8.06, 0.39), (9.14, 1.71), stroke: 1pt)
  rect((8.14, 0.47), (9.06, 1.63), stroke: 0.8pt)
  bezier((8.14, 1.12), (8.60, 1.12), (8.28, 1.20), (8.45, 1.18), stroke: 0.8pt)
  bezier((8.60, 1.12), (9.06, 1.16), (8.75, 1.10), (8.92, 1.22), stroke: 0.8pt)
  // Inneschi multipli negli angoli superiori e sul bordo superiore interno
  arc((8.14, 1.63), start: 270deg, stop: 360deg, radius: 0.22, anchor: "origin", stroke: 0.65pt)
  arc((9.06, 1.63), start: 180deg, stop: 270deg, radius: 0.22, anchor: "origin", stroke: 0.65pt)
  bezier((8.14, 1.42), (9.06, 1.42), (8.45, 1.50), (8.75, 1.50), stroke: 0.65pt)
  bezier((8.14, 1.28), (9.06, 1.30), (8.45, 1.34), (8.75, 1.34), stroke: 0.65pt)
  // Frecce radiali dai bordi superiori/laterali (con leggera trasparenza)
  line((8.25, 1.63), (8.32, 1.24), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.14, 1.52), (8.26, 1.42), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.82, 1.63), (8.74, 1.24), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.95, 1.63), (8.86, 1.42), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((9.06, 1.52), (8.94, 1.42), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.55, 1.63), (8.56, 1.32), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))

  // --- Riga 2, Col 4: (10.6, 1.05) Intaglio elevato, sforzo basso ---
  // Rettangolo esterno: [10.06, 11.14] x [0.39, 1.71], interno: [10.14, 11.06] x [0.47, 1.63]
  // Zona di rottura finale nel terzo inferiore con bordo superiore convesso a cupola
  line((10.14, 0.82), (10.38, 0.94), (10.60, 0.96), (10.82, 0.94), (11.06, 0.82), (11.06, 0.47), (10.14, 0.47), close: true, fill: black.transparentize(72%), stroke: none)
  rect((10.06, 0.39), (11.14, 1.71), stroke: 1pt)
  rect((10.14, 0.47), (11.06, 1.63), stroke: 0.8pt)
  bezier((10.14, 0.82), (11.06, 0.82), (10.42, 1.00), (10.78, 1.00), stroke: 0.8pt)
  // Fronti di propagazione dall'alto che si invertono da concavi a convessi scendendo
  arc((10.60, 1.63), start: 200deg, stop: 340deg, radius: (0.20, 0.14), anchor: "origin", stroke: 0.65pt)
  arc((10.60, 1.63), start: 205deg, stop: 335deg, radius: (0.38, 0.28), anchor: "origin", stroke: 0.65pt)
  bezier((10.14, 1.24), (11.06, 1.24), (10.42, 1.12), (10.78, 1.12), stroke: 0.65pt)
  bezier((10.14, 1.02), (11.06, 1.02), (10.42, 1.06), (10.78, 1.06), stroke: 0.65pt)
  // Frecce radiali (con leggera trasparenza)
  line((10.60, 1.63), (10.60, 1.02), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.48, 1.60), (10.30, 1.00), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.72, 1.60), (10.90, 1.00), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.34, 1.56), (10.18, 1.20), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.86, 1.56), (11.02, 1.20), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
})])
#v(1em)  
  #grid(
  columns: (0.7fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [*Flessione piana alternata ($R = -1$ senza rotazione):* Entrambe le fibre estreme opposte passano ciclicamente in trazione. Si sviluppano quindi *due zone di innesco diametralmente opposte* (sui due lembi più sollecitati) che propagano simmetricamente verso il centro. La zona di schianto finale rimane confinata in una fascia centrale lungo l'asse neutro della sezione.
     ],[

#canvas(length: 0.9cm, {
  import draw: *

  // ==================== GRIGLIA DELLA TABELLA UNIFICATA ====================
  // Linee orizzontali
  line((0.0, 4.2), (11.6, 4.2), stroke: 1pt)
  line((0.0, 2.1), (11.6, 2.1), stroke: 0.5pt)
  line((0.0, 0.0), (11.6, 0.0), stroke: 1pt)

  // Linee orizzontali nell'intestazione
  line((3.7, 4.85), (7.5, 4.85), stroke: 0.8pt)
  line((7.7, 4.85), (11.5, 4.85), stroke: 0.8pt)

  // Linee verticali continue dall'alto al basso
  line((3.6, 0.0), (3.6, 5.4), stroke: 1pt)
  line((5.6, 0.0), (5.6, 4.85), stroke: 0.8pt)
  line((7.6, 0.0), (7.6, 5.4), stroke: 1pt)
  line((9.6, 0.0), (9.6, 4.85), stroke: 0.8pt)
  line((11.6, 0.0), (11.6, 5.4), stroke: 1pt)

  // ==================== INTESTAZIONI (IN ITALIANO) ====================
  content((1.8, 4.75), text(size: 7pt)[MODALITÀ DI CARICO])
  content((9.6, 5.12), text(size: 7pt)[effetto d'intaglio elevato])

  content((4.6, 4.63), text(size: 7pt)[sforzo])
  content((4.6, 4.37), text(size: 7pt)[elevato])
  content((6.6, 4.63), text(size: 7pt)[sforzo])
  content((6.6, 4.37), text(size: 7pt)[basso])
  content((8.6, 4.63), text(size: 7pt)[sforzo])
  content((8.6, 4.37), text(size: 7pt)[elevato])
  content((10.6, 4.63), text(size: 7pt)[sforzo])
  content((10.6, 4.37), text(size: 7pt)[basso])


  // =========================================================================
  // RIGA 1: SEZIONE CIRCOLARE - FLESSIONE ALTERNATA (y: 2.1 .. 4.2, y_c = 3.15)
  // =========================================================================

  // Colonna 0 Riga 1: flessione alternata (barra 2D incastrata + doppia freccia curva)
  content((0.2, 3.85), text(size: 7pt)[flessione alternata], anchor: "west")
  line((0.9, 2.45), (0.9, 3.30), stroke: 0.9pt)
  line((0.9, 2.50), (0.72, 2.38), stroke: 0.7pt)
  line((0.9, 2.63), (0.72, 2.51), stroke: 0.7pt)
  line((0.9, 2.76), (0.72, 2.64), stroke: 0.7pt)
  line((0.9, 2.89), (0.72, 2.77), stroke: 0.7pt)
  line((0.9, 3.02), (0.72, 2.90), stroke: 0.7pt)
  line((0.9, 3.15), (0.72, 3.03), stroke: 0.7pt)
  line((0.9, 3.28), (0.72, 3.16), stroke: 0.7pt)
  rect((0.9, 2.70), (2.8, 3.05), stroke: 0.9pt)
  arc((1.8, 2.875), start: -24deg, stop: 24deg, radius: 1.25, anchor: "origin", mark: (start: ">", end: ">"), stroke: 0.9pt)

  // --- Riga 1, Col 1: (4.6, 3.15) Provino liscio, sforzo elevato ---
  line((3.97, 3.41), (4.3, 3.35), (4.6, 3.33), (4.9, 3.35), (5.23, 3.41), (5.28, 3.15), (5.23, 2.89), (4.9, 2.95), (4.6, 2.97), (4.3, 2.95), (3.97, 2.89), (3.92, 3.15), close: true, fill: black.transparentize(72%), stroke: none)
  circle((4.6, 3.15), radius: 0.68, stroke: 1pt)
  // Alto
  arc((4.6, 3.83), start: 210deg, stop: 330deg, radius: 0.24, anchor: "origin", stroke: 0.65pt)
  arc((4.6, 3.83), start: 205deg, stop: 335deg, radius: 0.48, anchor: "origin", stroke: 0.8pt)
  line((4.6, 3.83), (4.6, 3.35), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.45, 3.81), (4.35, 3.37), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.75, 3.81), (4.85, 3.37), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.30, 3.75), (4.12, 3.41), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.90, 3.75), (5.08, 3.41), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  // Basso
  arc((4.6, 2.47), start: 30deg, stop: 150deg, radius: 0.24, anchor: "origin", stroke: 0.65pt)
  arc((4.6, 2.47), start: 25deg, stop: 155deg, radius: 0.48, anchor: "origin", stroke: 0.8pt)
  line((4.6, 2.47), (4.6, 2.95), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.45, 2.49), (4.35, 2.93), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.75, 2.49), (4.85, 2.93), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.30, 2.55), (4.12, 2.89), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.90, 2.55), (5.08, 2.89), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))

  // --- Riga 1, Col 2: (6.6, 3.15) Provino liscio, sforzo basso ---
  line((5.94, 3.29), (6.3, 3.23), (6.6, 3.21), (6.9, 3.23), (7.26, 3.29), (7.28, 3.15), (7.26, 3.01), (6.9, 3.07), (6.6, 3.09), (6.3, 3.07), (5.94, 3.01), (5.92, 3.15), close: true, fill: black.transparentize(72%), stroke: none)
  circle((6.6, 3.15), radius: 0.68, stroke: 1pt)
  // Alto
  arc((6.6, 3.83), start: 210deg, stop: 330deg, radius: 0.24, anchor: "origin", stroke: 0.65pt)
  arc((6.6, 3.83), start: 205deg, stop: 335deg, radius: 0.42, anchor: "origin", stroke: 0.65pt)
  arc((6.6, 3.83), start: 212deg, stop: 328deg, radius: 0.62, anchor: "origin", stroke: 0.8pt)
  line((6.6, 3.83), (6.6, 3.23), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.45, 3.81), (6.32, 3.25), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.75, 3.81), (6.88, 3.25), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.30, 3.75), (6.08, 3.29), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.90, 3.75), (7.12, 3.29), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  // Basso
  arc((6.6, 2.47), start: 30deg, stop: 150deg, radius: 0.24, anchor: "origin", stroke: 0.65pt)
  arc((6.6, 2.47), start: 25deg, stop: 155deg, radius: 0.42, anchor: "origin", stroke: 0.65pt)
  arc((6.6, 2.47), start: 32deg, stop: 148deg, radius: 0.62, anchor: "origin", stroke: 0.8pt)
  line((6.6, 2.47), (6.6, 3.07), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.45, 2.49), (6.32, 3.05), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.75, 2.49), (6.88, 3.05), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.30, 2.55), (6.08, 3.01), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.90, 2.55), (7.12, 3.01), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))

  // --- Riga 1, Col 3: (8.6, 3.15) Intaglio elevato, sforzo elevato ---
  line((8.02, 3.29), (8.35, 3.37), (8.85, 3.37), (9.18, 3.29), (9.20, 3.15), (9.18, 3.01), (8.85, 2.93), (8.35, 2.93), (8.02, 3.01), (8.00, 3.15), close: true, fill: black.transparentize(72%), stroke: none)
  circle((8.6, 3.15), radius: 0.68, stroke: 1pt)
  circle((8.6, 3.15), radius: 0.60, stroke: 0.8pt)
  bezier((8.02, 3.29), (9.18, 3.29), (8.4, 3.40), (8.8, 3.40), stroke: 0.8pt)
  bezier((8.02, 3.01), (9.18, 3.01), (8.4, 2.90), (8.8, 2.90), stroke: 0.8pt)
  arc((8.6, 3.75), start: 215deg, stop: 325deg, radius: 0.22, anchor: "origin", stroke: 0.65pt)
  arc((8.6, 2.55), start: 35deg, stop: 145deg, radius: 0.22, anchor: "origin", stroke: 0.65pt)
  line((8.6, 3.75), (8.6, 3.38), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.35, 3.69), (8.38, 3.36), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.85, 3.69), (8.82, 3.36), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.15, 3.55), (8.18, 3.32), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((9.05, 3.55), (9.02, 3.32), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.6, 2.55), (8.6, 2.92), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.35, 2.61), (8.38, 2.94), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.85, 2.61), (8.82, 2.94), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.15, 2.75), (8.18, 2.98), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((9.05, 2.75), (9.02, 2.98), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))

  // --- Riga 1, Col 4: (10.6, 3.15) Intaglio elevato, sforzo basso ---
  line((10.02, 3.23), (10.35, 3.29), (10.85, 3.29), (11.18, 3.23), (11.20, 3.15), (11.18, 3.07), (10.85, 3.01), (10.35, 3.01), (10.02, 3.07), (10.00, 3.15), close: true, fill: black.transparentize(72%), stroke: none)
  circle((10.6, 3.15), radius: 0.68, stroke: 1pt)
  circle((10.6, 3.15), radius: 0.60, stroke: 0.8pt)
  bezier((10.02, 3.23), (11.18, 3.23), (10.4, 3.31), (10.8, 3.31), stroke: 0.8pt)
  bezier((10.02, 3.07), (11.18, 3.07), (10.4, 2.99), (10.8, 2.99), stroke: 0.8pt)
  arc((10.6, 3.75), start: 210deg, stop: 330deg, radius: 0.24, anchor: "origin", stroke: 0.65pt)
  arc((10.6, 3.75), start: 205deg, stop: 335deg, radius: 0.40, anchor: "origin", stroke: 0.65pt)
  arc((10.6, 2.55), start: 30deg, stop: 150deg, radius: 0.24, anchor: "origin", stroke: 0.65pt)
  arc((10.6, 2.55), start: 25deg, stop: 155deg, radius: 0.40, anchor: "origin", stroke: 0.65pt)
  line((10.6, 3.75), (10.6, 3.30), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.35, 3.69), (10.35, 3.28), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.85, 3.69), (10.85, 3.28), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.15, 3.55), (10.15, 3.25), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((11.05, 3.55), (11.05, 3.25), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.6, 2.55), (10.6, 3.00), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.35, 2.61), (10.35, 3.02), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.85, 2.61), (10.85, 3.02), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.15, 2.75), (10.15, 3.05), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((11.05, 2.75), (11.05, 3.05), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))


  // =========================================================================
  // RIGA 2: SEZIONE RETTANGOLARE - FLESSIONE ALTERNATA (y: 0.0 .. 2.1, y_c = 1.05)
  // =========================================================================

  // Colonna 0 Riga 2: flessione alternata con trave 3D incastrata e doppia freccia curva
  content((0.2, 1.75), text(size: 7pt)[flessione alternata], anchor: "west")

  // Parete curva d'incastro a sinistra
  bezier((1.15, 1.25), (0.85, 0.95), (1.02, 1.22), (0.88, 1.08), stroke: 0.8pt)
  bezier((0.85, 0.95), (0.85, 0.35), (0.80, 0.72), (0.80, 0.52), stroke: 0.8pt)
  bezier((0.85, 0.35), (1.25, 0.28), (0.95, 0.22), (1.15, 0.22), stroke: 0.8pt)
  line((1.25, 0.28), (1.35, 0.45), stroke: 0.8pt)
  line((1.15, 1.25), (1.32, 0.95), stroke: 0.8pt)
  // Tratteggio d'incastro
  line((1.10, 1.23), (1.00, 1.31), stroke: 0.6pt)
  line((0.98, 1.14), (0.88, 1.22), stroke: 0.6pt)
  line((0.89, 1.00), (0.79, 1.08), stroke: 0.6pt)
  line((0.84, 0.84), (0.74, 0.92), stroke: 0.6pt)
  line((0.82, 0.68), (0.72, 0.76), stroke: 0.6pt)
  line((0.82, 0.52), (0.72, 0.60), stroke: 0.6pt)
  line((0.85, 0.36), (0.75, 0.44), stroke: 0.6pt)
  // Parallelepipedo (trave a sezione rettangolare in prospettiva)
  rect((1.05, 0.45), (2.45, 0.82), stroke: 0.9pt)
  line((1.05, 0.82), (1.28, 0.95), (2.68, 0.95), (2.45, 0.82), stroke: 0.9pt)
  line((2.68, 0.95), (2.68, 0.58), (2.45, 0.45), stroke: 0.9pt)
  // Doppia freccia curva di flessione alternata a destra
  arc((1.85, 0.72), start: -24deg, stop: 24deg, radius: 1.25, anchor: "origin", mark: (start: ">", end: ">"), stroke: 0.9pt)


  // --- Riga 2, Col 1: (4.6, 1.05) Provino liscio, sforzo elevato ---
  // Rettangolo verticale: x in [4.06, 5.14], y in [0.39, 1.71]
  // Ampia zona di rottura finale centrale tra il fronte superiore concavo e il fronte inferiore convesso
  line((4.25, 1.71), (4.42, 1.48), (4.62, 1.42), (4.88, 1.46), (5.14, 1.62), (5.14, 0.72), (4.85, 0.76), (4.55, 0.80), (4.28, 0.78), (4.06, 0.70), (4.06, 1.71), close: true, fill: black.transparentize(72%), stroke: none)
  rect((4.06, 0.39), (5.14, 1.71), stroke: 1pt)
  // Fronte superiore (innesco da 4.65, 1.71)
  bezier((4.25, 1.71), (5.14, 1.62), (4.48, 1.36), (4.85, 1.38), stroke: 0.8pt)
  arc((4.65, 1.71), start: 195deg, stop: 345deg, radius: (0.20, 0.13), anchor: "origin", stroke: 0.65pt)
  // Fronte inferiore (inneschi multipli dal bordo inferiore y=0.39)
  bezier((4.06, 0.70), (5.14, 0.72), (4.35, 0.82), (4.80, 0.80), stroke: 0.8pt)
  bezier((4.06, 0.56), (5.14, 0.55), (4.40, 0.65), (4.80, 0.64), stroke: 0.65pt)
  arc((4.25, 0.39), start: 15deg, stop: 165deg, radius: (0.15, 0.10), anchor: "origin", stroke: 0.65pt)
  arc((4.78, 0.39), start: 15deg, stop: 165deg, radius: (0.18, 0.11), anchor: "origin", stroke: 0.65pt)
  // Frecce radiali (con leggera trasparenza)
  line((4.58, 1.68), (4.45, 1.48), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.72, 1.68), (4.84, 1.48), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.22, 0.39), (4.12, 0.68), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.42, 0.39), (4.52, 0.74), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.82, 0.39), (4.72, 0.72), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.98, 0.39), (5.08, 0.68), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))


  // --- Riga 2, Col 2: (6.6, 1.05) Provino liscio, sforzo basso ---
  // Rettangolo verticale: x in [6.06, 7.14], y in [0.39, 1.71]
  // Fascia di rottura finale centrale più stretta
  line((6.06, 1.26), (6.38, 1.20), (6.72, 1.18), (7.14, 1.22), (7.14, 0.94), (6.80, 0.92), (6.42, 0.85), (6.06, 0.74), close: true, fill: black.transparentize(72%), stroke: none)
  rect((6.06, 0.39), (7.14, 1.71), stroke: 1pt)
  // Fronti superiori (innesco centrale in 6.60, 1.71)
  bezier((6.06, 1.26), (7.14, 1.22), (6.45, 1.16), (6.85, 1.16), stroke: 0.8pt)
  bezier((6.06, 1.44), (7.14, 1.40), (6.45, 1.30), (6.85, 1.30), stroke: 0.65pt)
  arc((6.60, 1.71), start: 195deg, stop: 345deg, radius: (0.22, 0.14), anchor: "origin", stroke: 0.65pt)
  arc((6.60, 1.71), start: 200deg, stop: 340deg, radius: (0.38, 0.25), anchor: "origin", stroke: 0.65pt)
  // Fronti inferiori (innesco asimmetrico in basso a destra 6.95, 0.39 che sale verso sinistra)
  bezier((6.06, 0.74), (7.14, 0.94), (6.45, 0.88), (6.85, 0.94), stroke: 0.8pt)
  bezier((6.06, 0.56), (7.14, 0.80), (6.48, 0.72), (6.88, 0.80), stroke: 0.65pt)
  bezier((6.35, 0.39), (7.14, 0.66), (6.58, 0.56), (6.92, 0.64), stroke: 0.65pt)
  arc((6.95, 0.39), start: 100deg, stop: 175deg, radius: (0.28, 0.18), anchor: "origin", stroke: 0.65pt)
  // Frecce radiali (con leggera trasparenza)
  line((6.60, 1.71), (6.60, 1.20), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.48, 1.68), (6.26, 1.24), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.72, 1.68), (6.90, 1.22), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.95, 0.39), (6.22, 0.72), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((7.00, 0.42), (6.55, 0.84), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((7.06, 0.45), (6.88, 0.90), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))


  // --- Riga 2, Col 3: (8.6, 1.05) Intaglio elevato, sforzo elevato ---
  // Rettangolo esterno: [8.06, 9.14] x [0.39, 1.71], interno: [8.14, 9.06] x [0.47, 1.63]
  // Ampia fascia centrale di rottura finale con contorni ondulati
  line((8.14, 1.26), (8.38, 1.34), (8.62, 1.28), (8.88, 1.33), (9.06, 1.25), (9.06, 0.84), (8.85, 0.78), (8.60, 0.83), (8.36, 0.76), (8.14, 0.82), close: true, fill: black.transparentize(72%), stroke: none)
  rect((8.06, 0.39), (9.14, 1.71), stroke: 1pt)
  rect((8.14, 0.47), (9.06, 1.63), stroke: 0.8pt)
  // Contorni ondulati della fascia centrale
  bezier((8.14, 1.26), (8.62, 1.28), (8.30, 1.36), (8.48, 1.34), stroke: 0.8pt)
  bezier((8.62, 1.28), (9.06, 1.25), (8.78, 1.34), (8.94, 1.32), stroke: 0.8pt)
  bezier((8.14, 0.82), (8.60, 0.83), (8.28, 0.74), (8.46, 0.76), stroke: 0.8pt)
  bezier((8.60, 0.83), (9.06, 0.84), (8.75, 0.76), (8.92, 0.76), stroke: 0.8pt)
  // Inneschi multipli a festoni sul lato superiore interno (y=1.63) e inferiore interno (y=0.47)
  arc((8.28, 1.63), start: 195deg, stop: 345deg, radius: (0.14, 0.08), anchor: "origin", stroke: 0.65pt)
  arc((8.60, 1.63), start: 195deg, stop: 345deg, radius: (0.15, 0.08), anchor: "origin", stroke: 0.65pt)
  arc((8.92, 1.63), start: 195deg, stop: 345deg, radius: (0.14, 0.08), anchor: "origin", stroke: 0.65pt)
  bezier((8.14, 1.46), (9.06, 1.46), (8.45, 1.42), (8.75, 1.42), stroke: 0.65pt)
  arc((8.28, 0.47), start: 15deg, stop: 165deg, radius: (0.14, 0.08), anchor: "origin", stroke: 0.65pt)
  arc((8.60, 0.47), start: 15deg, stop: 165deg, radius: (0.15, 0.08), anchor: "origin", stroke: 0.65pt)
  arc((8.92, 0.47), start: 15deg, stop: 165deg, radius: (0.14, 0.08), anchor: "origin", stroke: 0.65pt)
  bezier((8.14, 0.64), (9.06, 0.64), (8.45, 0.68), (8.75, 0.68), stroke: 0.65pt)
  // Frecce radiali (con leggera trasparenza)
  line((8.32, 1.63), (8.32, 1.36), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.60, 1.63), (8.60, 1.32), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.88, 1.63), (8.88, 1.36), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.32, 0.47), (8.32, 0.74), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.60, 0.47), (8.60, 0.78), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.88, 0.47), (8.88, 0.74), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))


  // --- Riga 2, Col 4: (10.6, 1.05) Intaglio elevato, sforzo basso ---
  // Rettangolo esterno: [10.06, 11.14] x [0.39, 1.71], interno: [10.14, 11.06] x [0.47, 1.63]
  // Fascia centrale più stretta con contorni ondulati a doppia gobba
  line((10.14, 1.15), (10.36, 1.20), (10.60, 1.14), (10.84, 1.20), (11.06, 1.15), (11.06, 0.94), (10.84, 0.89), (10.60, 0.95), (10.36, 0.89), (10.14, 0.94), close: true, fill: black.transparentize(72%), stroke: none)
  rect((10.06, 0.39), (11.14, 1.71), stroke: 1pt)
  rect((10.14, 0.47), (11.06, 1.63), stroke: 0.8pt)
  // Contorni ondulati della fascia centrale
  bezier((10.14, 1.15), (10.60, 1.14), (10.28, 1.22), (10.46, 1.20), stroke: 0.8pt)
  bezier((10.60, 1.14), (11.06, 1.15), (10.74, 1.20), (10.92, 1.22), stroke: 0.8pt)
  bezier((10.14, 0.94), (10.60, 0.95), (10.28, 0.87), (10.46, 0.89), stroke: 0.8pt)
  bezier((10.60, 0.95), (11.06, 0.94), (10.74, 0.89), (10.92, 0.87), stroke: 0.8pt)
  // Fronti superiori (innesco nell'angolo superiore destro 11.00, 1.63)
  arc((10.92, 1.63), start: 185deg, stop: 295deg, radius: (0.20, 0.12), anchor: "origin", stroke: 0.65pt)
  bezier((10.42, 1.63), (11.06, 1.42), (10.55, 1.46), (10.88, 1.44), stroke: 0.65pt)
  bezier((10.14, 1.45), (11.06, 1.30), (10.45, 1.34), (10.82, 1.32), stroke: 0.65pt)
  // Fronti inferiori (innesco sul bordo inferiore 10.60, 0.47)
  arc((10.60, 0.47), start: 15deg, stop: 165deg, radius: (0.22, 0.12), anchor: "origin", stroke: 0.65pt)
  bezier((10.14, 0.62), (11.06, 0.62), (10.45, 0.72), (10.75, 0.72), stroke: 0.65pt)
  bezier((10.14, 0.78), (11.06, 0.78), (10.45, 0.84), (10.75, 0.84), stroke: 0.65pt)
  // Frecce radiali (con leggera trasparenza)
  line((10.92, 1.60), (10.35, 1.24), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.98, 1.56), (10.82, 1.24), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.52, 0.47), (10.35, 0.86), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.68, 0.47), (10.78, 0.86), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
})])
  Nella *flessione piana alternata*  la presenza delle due fratture concorrenti verso il centro è inequivocabilmente diagnosticata dalla *curvatura contrapposta delle linee di spiaggia (beachmarks)* provenienti dai due bordi opposti; la fascia centrale di rottura finale risulta tanto più ampia quanto più elevate sono la tensione nominale e la concentrazione di tensione.
  *Flessione rotante:* Poiché l'albero ruota sotto carico flettente, ogni fibra perimetrale sperimenta il picco di trazione a ogni giro.
    - Se il pezzo è *liscio o debolmente intagliato*, l'innesco parte da un punto singolo ma il fronte di propagazione si sviluppa in modo *asimmetrico*, apparendo ruotato (sfalsato angolarmente) in senso opposto al verso di rotazione dell'albero, con una serie di bordi radiali pronunciati.
    - Se il pezzo presenta un *forte intaglio circonferenziale* (o tensioni nominali molto elevate), l'innesco è multiplo lungo tutta la circonferenza; il fronte di fatica converge radialmente da tutti i lati e racchiude la zona di rottura finale in un'*isola interna* (quasi centrale, ma leggermente eccentrica per effetto del gradiente flessionale e della rotazione).
#figure(
  canvas(length: 1cm, {
  import draw: *

  // ==================== GRIGLIA DELLA TABELLA ====================
  // Linee orizzontali principali
  line((0.0, 2.1), (11.6, 2.1), stroke: 1pt)
  line((0.0, 0.0), (11.6, 0.0), stroke: 1pt)

  // Linee orizzontali nell'intestazione
  line((3.7, 2.75), (7.5, 2.75), stroke: 0.8pt)
  line((7.7, 2.75), (11.5, 2.75), stroke: 0.8pt)

  // Linee verticali
  line((3.6, 0.0), (3.6, 3.3), stroke: 1pt)
  line((5.6, 0.0), (5.6, 2.75), stroke: 0.8pt)
  line((7.6, 0.0), (7.6, 3.3), stroke: 1pt)
  line((9.6, 0.0), (9.6, 2.75), stroke: 0.8pt)
  line((11.6, 0.0), (11.6, 3.3), stroke: 1pt)

  // ==================== INTESTAZIONI (IN ITALIANO) ====================
  content((1.8, 2.65), text(size: 7pt)[MODALITÀ DI CARICO])
  content((9.6, 3.02), text(size: 7pt)[effetto d'intaglio elevato])

  content((4.6, 2.53), text(size: 7pt)[sforzo])
  content((4.6, 2.27), text(size: 7pt)[elevato])
  content((6.6, 2.53), text(size: 7pt)[sforzo])
  content((6.6, 2.27), text(size: 7pt)[basso])
  content((8.6, 2.53), text(size: 7pt)[sforzo])
  content((8.6, 2.27), text(size: 7pt)[elevato])
  content((10.6, 2.53), text(size: 7pt)[sforzo])
  content((10.6, 2.27), text(size: 7pt)[basso])


  // Colonna 0: flessione rotante
  content((0.2, 1.72), text(size: 7pt)[flessione rotante], anchor: "west")
  // Cuscinetti a sinistra
  rect((0.6, 0.92), (0.85, 1.17), stroke: 0.8pt)
  line((0.6, 0.92), (0.85, 1.17), stroke: 0.6pt)
  line((0.6, 1.17), (0.85, 0.92), stroke: 0.6pt)
  rect((0.6, 0.32), (0.85, 0.57), stroke: 0.8pt)
  line((0.6, 0.32), (0.85, 0.57), stroke: 0.6pt)
  line((0.6, 0.57), (0.85, 0.32), stroke: 0.6pt)
  line((0.6, 0.57), (0.6, 0.92), stroke: 0.8pt)
  // Barra
  rect((0.6, 0.57), (2.8, 0.92), stroke: 0.9pt)
  // Freccia di rotazione attorno alla barra
  arc((1.35, 0.745), start: 60deg, stop: 300deg, radius: (0.22, 0.36), anchor: "origin", mark: (start: ">"), stroke: 0.8pt)
  // Freccia di flessione a destra
  arc((1.8, 1.05), start: -35deg, stop: -8deg, radius: 1.3, anchor: "origin", mark: (start: ">"), stroke: 0.9pt)


  // --- Col 1: (4.6, 1.0) Provino liscio, sforzo elevato ---
  // Zona di rottura finale grande spostata in basso a destra
  line((3.96, 0.78), (4.35, 0.92), (4.72, 1.15), (5.05, 1.50), (5.24, 1.22), (5.28, 0.95), (5.15, 0.60), (4.88, 0.38), (4.55, 0.32), (4.22, 0.42), (4.02, 0.60), close: true, fill: black.transparentize(72%), stroke: none)
  circle((4.6, 1.0), radius: 0.68, stroke: 1pt)
  // Fronte limite della zona di rottura finale
  bezier((3.96, 0.78), (5.05, 1.50), (4.40, 0.88), (4.75, 1.15), stroke: 0.8pt)
  // Fronti di propagazione dall'innesco superiore
  arc((4.60, 1.68), start: 195deg, stop: 335deg, radius: (0.22, 0.14), anchor: "origin", stroke: 0.65pt)
  bezier((4.08, 1.44), (4.88, 1.62), (4.35, 1.28), (4.68, 1.38), stroke: 0.65pt)
  bezier((3.93, 1.12), (4.98, 1.56), (4.35, 1.05), (4.72, 1.25), stroke: 0.65pt)
  // Frecce radiali (con leggera trasparenza)
  line((4.55, 1.65), (4.42, 1.24), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.65, 1.65), (4.68, 1.28), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.42, 1.66), (4.18, 1.38), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((4.75, 1.66), (4.88, 1.44), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  // Assi tratteggiati (verticale e inclinato)
  line((4.6, 1.78), (4.6, 0.22), stroke: (dash: "dashed", thickness: 0.6pt))
  line((4.30, 1.74), (4.90, 0.26), stroke: (dash: "dashed", thickness: 0.6pt))
  // Freccia rotazione esterna
  arc((4.6, 1.0), start: 122deg, stop: 152deg, radius: 0.82, anchor: "origin", mark: (start: ">"), stroke: 0.9pt)


  // --- Col 2: (6.6, 1.0) Provino liscio, sforzo basso ---
  // Zona di rottura finale piccola in basso a destra
  line((6.35, 0.37), (6.58, 0.52), (6.88, 0.62), (7.18, 0.65), (7.02, 0.45), (6.75, 0.34), (6.50, 0.33), close: true, fill: black.transparentize(72%), stroke: none)
  circle((6.6, 1.0), radius: 0.68, stroke: 1pt)
  // Fronte limite convesso verso l'alto/sinistra della zona ruvida
  bezier((6.35, 0.37), (7.18, 0.65), (6.55, 0.55), (6.90, 0.64), stroke: 0.8pt)
  // Fronti di propagazione dall'alto (6.6, 1.68)
  arc((6.60, 1.68), start: 195deg, stop: 345deg, radius: (0.20, 0.12), anchor: "origin", stroke: 0.65pt)
  bezier((5.96, 1.24), (7.18, 1.36), (6.35, 1.12), (6.85, 1.18), stroke: 0.65pt)
  bezier((5.93, 0.88), (7.27, 1.05), (6.40, 0.85), (6.90, 0.92), stroke: 0.65pt)
  bezier((6.06, 0.58), (7.24, 0.80), (6.45, 0.66), (6.95, 0.74), stroke: 0.65pt)
  // Frecce radiali lunghe (con leggera trasparenza)
  line((6.48, 1.66), (6.15, 0.72), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.56, 1.64), (6.42, 0.66), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.68, 1.64), (6.82, 0.74), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((6.78, 1.66), (7.08, 0.80), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  // Assi tratteggiati
  line((6.6, 1.78), (6.6, 0.22), stroke: (dash: "dashed", thickness: 0.6pt))
  line((6.30, 1.74), (6.90, 0.26), stroke: (dash: "dashed", thickness: 0.6pt))
  // Freccia rotazione esterna
  arc((6.6, 1.0), start: 122deg, stop: 152deg, radius: 0.82, anchor: "origin", mark: (start: ">"), stroke: 0.9pt)


  // --- Col 3: (8.6, 1.0) Intaglio elevato, sforzo elevato ---
  // Rottura finale interna (isola centrale leggermente eccentrica)
  circle((8.65, 0.95), radius: (0.23, 0.17), fill: black.transparentize(72%), stroke: 0.8pt)
  circle((8.6, 1.0), radius: 0.68, stroke: 1pt)
  circle((8.6, 1.0), radius: 0.60, stroke: 0.8pt)
  // Fronti concentrici anulari dalla periferia verso il centro
  circle((8.62, 0.98), radius: (0.48, 0.44), stroke: 0.65pt)
  circle((8.64, 0.96), radius: (0.35, 0.30), stroke: 0.65pt)
  // Frecce radiali da tutti i bordi verso l'interno (con leggera trasparenza)
  line((8.60, 1.60), (8.63, 1.15), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.60, 0.40), (8.64, 0.76), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.00, 1.00), (8.40, 0.96), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((9.20, 1.00), (8.90, 0.96), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.18, 1.42), (8.46, 1.09), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((9.02, 1.42), (8.82, 1.09), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((8.18, 0.58), (8.46, 0.82), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((9.02, 0.58), (8.82, 0.82), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  // Assi tratteggiati
  line((8.6, 1.78), (8.6, 0.22), stroke: (dash: "dashed", thickness: 0.6pt))
  line((8.35, 1.74), (8.85, 0.26), stroke: (dash: "dashed", thickness: 0.6pt))
  // Freccia rotazione esterna
  arc((8.6, 1.0), start: 122deg, stop: 152deg, radius: 0.82, anchor: "origin", mark: (start: ">"), stroke: 0.9pt)


  // --- Col 4: (10.6, 1.0) Intaglio elevato, sforzo basso ---
  // Isola piccola spostata in basso a destra
  circle((10.72, 0.78), radius: (0.16, 0.13), fill: black.transparentize(72%), stroke: 0.8pt)
  circle((10.6, 1.0), radius: 0.68, stroke: 1pt)
  circle((10.6, 1.0), radius: 0.60, stroke: 0.8pt)
  // Fronti eccentrici che convergono verso (10.72, 0.78)
  circle((10.65, 0.90), radius: (0.45, 0.42), stroke: 0.65pt)
  circle((10.69, 0.84), radius: (0.30, 0.26), stroke: 0.65pt)
  arc((10.45, 1.58), start: 225deg, stop: 345deg, radius: 0.28, anchor: "origin", stroke: 0.65pt)
  // Frecce radiali dai bordi (con leggera trasparenza)
  line((10.50, 1.58), (10.68, 0.93), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.15, 1.38), (10.55, 0.85), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.85, 1.54), (10.80, 0.93), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.02, 0.95), (10.54, 0.78), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((11.18, 0.95), (10.90, 0.80), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.35, 0.45), (10.62, 0.68), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  line((10.95, 0.50), (10.82, 0.68), mark: (end: ">", scale: 0.5), stroke: (paint: black.transparentize(45%), thickness: 0.55pt))
  // Assi tratteggiati
  line((10.6, 1.78), (10.6, 0.22), stroke: (dash: "dashed", thickness: 0.6pt))
  line((10.35, 1.74), (10.85, 0.26), stroke: (dash: "dashed", thickness: 0.6pt))
  // Freccia rotazione esterna
  arc((10.6, 1.0), start: 122deg, stop: 152deg, radius: 0.82, anchor: "origin", mark: (start: ">"), stroke: 0.9pt)
})
)

#pagebreak()
== Confronto Trazione Torsione Statica e Fatica :
  - *Caso Statico ($F$ costante):* Superato il carico di snervamento su tutta la sezione, il materiale duttile subisce una forte deformazione plastica macroscopica (strizione) e cede per scorrimento lungo i piani di massima tensione tangenziale ($tau_"max" = sigma / 2$), inclinati di *$45^circ$* rispetto all'asse del carico .
  - *Caso a Fatica ($F'(t)$ ciclico):* La tensione nominale resta in campo elastico; la cricca nuclea localmente e si propaga in direzione normale alla tensione principale massima $sigma_"max"$, producendo una *decoesione frontale netta a $90^circ$* rispetto all'asse del carico, *priva di strizione* e con aspetto macroscopico da *rottura fragile*.

- *Sollecitazione di Torsione (Sezioni circolari lisce e intagliate):* Nello stato di pura torsione, i piani trasversali ($90^circ$) e longitudinali ($0^circ$) sono soggetti alla tensione tangenziale massima $tau_"max"$, mentre le tensioni principali di trazione e compressione ($sigma_1 = +tau_"max"$, $sigma_3 = -tau_"max"$) agiscono su piani inclinati a *$plus.minus 45^circ$* rispetto all'asse dell'albero:
  - *Caso Statico:* Un albero duttile cede per scorrimento plastico torsionale lungo il piano dove agisce direttamente $tau_"max"$, producendo una *recisione piana netta a $90^circ$* (ortogonale all'asse).
  - *Caso a Fatica (Sezione circolare liscia):* Dopo il micro-innesco, la cricca si propaga ortogonalmente alla massima tensione normale di trazione $sigma_"max"$, sviluppandosi lungo un'elica inclinata a *$45^circ$* (rottura *"a becco di flauto"*). Se la torsione è *alternata*, si attivano entrambe le direzioni principali coniugate a $plus.minus 45^circ$, generando caratteristiche ramificazioni simmetriche a *"X"* sulla superficie cilindrica.
  

#figure(

canvas(length: 1.5cm, {
  import draw: *

  // ==========================================
  // GRIGLIA E INTESTAZIONI DEI PANNELLI
  // ==========================================
  // Divisori verticali tra le 3 colonne
  line((3.80, 0.10), (3.80, 8.10), stroke: (dash: "dashed", thickness: 0.7pt))
  line((7.60, 0.10), (7.60, 8.10), stroke: (dash: "dashed", thickness: 0.7pt))
  // Divisore orizzontale tra Statico (sopra) e Fatica (sotto)
  line((0.10, 3.85), (11.30, 3.85), stroke: (dash: "dashed", thickness: 0.6pt))

  // Titoli delle 3 colonne
  content((1.90, 7.95), text(size: 7pt)[*TRAZIONE*], anchor: "center")
  content((1.90, 7.65), text(size: 7pt)[(Provino liscio)], anchor: "center")

  content((5.70, 7.95), text(size: 7pt)[*TORSIONE*], anchor: "center")
  content((5.70, 7.65), text(size: 7pt)[(Sezione circolare liscia)], anchor: "center")

  content((9.50, 7.95), text(size: 7pt)[*TORSIONE CON INTAGLIO*], anchor: "center")
  content((9.50, 7.65), text(size: 7pt)[(Sezione intagliata)], anchor: "center")


  // ==========================================
  // PANNELLO 1: TRAZIONE (x_c = 1.90)
  // ==========================================

  // --- 1A. Caso Statico (in alto) ---
  content((0.20, 7.25), text(size: 7pt)[*Caso Statico* ($F$ cost.)], anchor: "west")

  // Frecce F
  line((1.90, 6.62), (1.90, 7.12), mark: (end: ">"), stroke: 0.9pt)
  content((2.02, 6.92), text(size: 7pt)[$F$], anchor: "west")

  line((1.90, 4.78), (1.90, 4.28), mark: (end: ">"), stroke: 0.9pt)
  content((2.02, 4.48), text(size: 7pt)[$F$], anchor: "west")

  // Metà superiore provino con strizione
  circle((1.90, 6.62), radius: (0.45, 0.11), stroke: 1pt)
  line((1.45, 6.62), (1.45, 6.20), stroke: 1pt)
  line((2.35, 6.62), (2.35, 6.20), stroke: 1pt)
  // Collo di strizione superiore
  bezier((1.45, 6.20), (1.62, 5.86), (1.45, 6.02), (1.58, 5.95), stroke: 1pt)
  bezier((2.35, 6.20), (2.18, 5.62), (2.35, 5.95), (2.22, 5.76), stroke: 1pt)
  // Cono/labbro a 45° superiore
  line((1.62, 5.86), (2.18, 5.62), stroke: 1pt)
  bezier((1.62, 5.86), (2.18, 5.62), (1.80, 5.82), (2.02, 5.75), stroke: (dash: "dashed", thickness: 0.7pt))

  // Metà inferiore provino con strizione ("coppa e cono" / 45°)
  line((1.62, 5.52), (1.90, 5.44), (2.18, 5.28), (1.90, 5.34), close: true, fill: black.transparentize(70%), stroke: none)
  line((1.62, 5.52), (2.18, 5.28), stroke: 1pt)
  bezier((1.62, 5.52), (2.18, 5.28), (1.80, 5.48), (2.02, 5.40), stroke: 0.8pt)
  bezier((1.62, 5.52), (2.18, 5.28), (1.78, 5.36), (2.00, 5.28), stroke: 0.8pt)
  // Collo di strizione inferiore
  bezier((1.62, 5.52), (1.45, 5.12), (1.58, 5.36), (1.45, 5.28), stroke: 1pt)
  bezier((2.18, 5.28), (2.35, 5.12), (2.22, 5.20), (2.35, 5.20), stroke: 1pt)
  line((1.45, 5.12), (1.45, 4.78), stroke: 1pt)
  line((2.35, 5.12), (2.35, 4.78), stroke: 1pt)
  arc((1.90, 4.78), start: 180deg, stop: 360deg, radius: (0.45, 0.11), anchor: "origin", stroke: 1pt)

  // Indicazione Strizione e 45°
  line((1.20, 5.72), (1.56, 5.72), mark: (end: ">"), stroke: 0.6pt)
  content((1.16, 5.72), text(size: 7pt)[Strizione], anchor: "east")
  content((2.42, 5.45), text(size: 7pt)[$45^circ$ ($tau_"max"$)], anchor: "west")

  // Didascalia 1A
  content((1.90, 4.05), text(size: 7pt)[*Scorrimento a $45^circ$ (coppa-cono)*], anchor: "center")


  // --- 1B. Caso a Fatica (in basso) ---
  content((0.20, 3.55), text(size: 7pt)[*Caso a Fatica* ($F'(t)$)], anchor: "west")

  // Frecce F'(t)
  line((1.90, 2.92), (1.90, 3.42), mark: (end: ">"), stroke: 0.9pt)
  content((2.02, 3.22), text(size: 7pt)[$F'(t)$], anchor: "west")

  line((1.90, 1.15), (1.90, 0.65), mark: (end: ">"), stroke: 0.9pt)
  content((2.02, 0.85), text(size: 7pt)[$F'(t)$], anchor: "west")

  // Metà superiore provino (nessuna strizione, taglio a 90°)
  circle((1.90, 2.92), radius: (0.45, 0.11), stroke: 1pt)
  line((1.45, 2.92), (1.45, 2.22), stroke: 1pt)
  line((2.35, 2.92), (2.35, 2.22), stroke: 1pt)
  arc((1.90, 2.22), start: 180deg, stop: 360deg, radius: (0.45, 0.11), anchor: "origin", stroke: 1pt)
  arc((1.90, 2.22), start: 0deg, stop: 180deg, radius: (0.45, 0.11), anchor: "origin", stroke: (dash: "dashed", thickness: 0.7pt))

  // Metà inferiore provino (superficie piana a 90° con linee di spiaggia e zona di schianto)
  circle((1.90, 1.85), radius: (0.45, 0.11), fill: black.transparentize(82%), stroke: 1pt)
  // Zona di rottura finale di schianto (più scura)
  line((1.46, 1.85), (1.65, 1.94), (2.15, 1.76), (1.75, 1.74), close: true, fill: black.transparentize(45%), stroke: none)
  line((1.55, 1.88), (2.20, 1.80), stroke: 0.6pt)
  line((1.65, 1.92), (2.28, 1.84), stroke: 0.6pt)
  line((1.45, 1.85), (1.45, 1.15), stroke: 1pt)
  line((2.35, 1.85), (2.35, 1.15), stroke: 1pt)
  arc((1.90, 1.15), start: 180deg, stop: 360deg, radius: (0.45, 0.11), anchor: "origin", stroke: 1pt)

  // Indicazioni 90° e assenza di strizione
  content((2.45, 2.02), text(size: 7pt)[$90^circ$ ($sigma_"max"$)], anchor: "west")
  content((1.38, 2.02), text(size: 7pt)[No strizione], anchor: "east")

  // Didascalia 1B
  content((1.90, 0.35), text(size: 7pt)[*Decoesione netta a $90^circ$ (fragile)*], anchor: "center")


  // ==========================================
  // PANNELLO 2: TORSIONE SEZIONE LISCIA (x_c = 5.70)
  // ==========================================

  // --- 2A. Caso Statico (in alto) ---
  content((4.00, 7.25), text(size: 7pt)[*Caso Statico* ($M_t$ cost.)], anchor: "west")

  // Asse tratteggiato e frecce di torsione
  line((5.70, 7.10), (5.70, 4.35), stroke: (dash: "dashed", thickness: 0.6pt))
  arc((5.70, 6.88), start: 100deg, stop: 390deg, radius: (0.32, 0.09), anchor: "origin", mark: (start: ">"), stroke: 0.8pt)
  arc((5.70, 4.52), start: 0deg, stop: 220deg, radius: (0.32, 0.09), anchor: "origin", mark: (start: ">"), stroke: 0.8pt)

  // Metà superiore provino
  circle((5.70, 6.62), radius: (0.45, 0.11), stroke: 1pt)
  line((5.25, 6.62), (5.25, 5.88), stroke: 1pt)
  line((6.15, 6.62), (6.15, 5.88), stroke: 1pt)
  arc((5.70, 5.88), start: 180deg, stop: 360deg, radius: (0.45, 0.11), anchor: "origin", stroke: 1pt)
  arc((5.70, 5.88), start: 0deg, stop: 180deg, radius: (0.45, 0.11), anchor: "origin", stroke: (dash: "dashed", thickness: 0.7pt))

  // Metà inferiore provino (recisione piana a 90° con tracce plastiche circolari)
  circle((5.70, 5.48), radius: (0.45, 0.11), fill: black.transparentize(82%), stroke: 1pt)
  circle((5.70, 5.48), radius: (0.28, 0.07), stroke: 0.5pt)
  circle((5.70, 5.48), radius: (0.10, 0.03), fill: black, stroke: 0.5pt)
  line((5.25, 5.48), (5.25, 4.78), stroke: 1pt)
  line((6.15, 5.48), (6.15, 4.78), stroke: 1pt)
  arc((5.70, 4.78), start: 180deg, stop: 360deg, radius: (0.45, 0.11), anchor: "origin", stroke: 1pt)

  content((6.25, 5.68), text(size: 7pt)[$90^circ$ ($tau_"max"$)], anchor: "west")

  // Didascalia 2A
  content((5.70, 4.05), text(size: 7pt)[*Recisione piana netta a $90^circ$*], anchor: "center")


  // --- 2B. Caso a Fatica (in basso) - MIGLIORATO ("BECCO DI FLAUTO" / "X") ---
  content((4.00, 3.55), text(size: 7pt)[*Caso a Fatica* ($M_t (t)$)], anchor: "west")

  // Asse tratteggiato e frecce di torsione alternata (doppia punta)
  line((5.70, 3.42), (5.70, 0.65), stroke: (dash: "dashed", thickness: 0.6pt))
  arc((5.70, 3.20), start: 110deg, stop: 420deg, radius: (0.32, 0.09), anchor: "origin", mark: (start: ">"), stroke: 0.8pt)
  arc((5.70, 0.85), start: 140deg, stop: 430deg, radius: (0.32, 0.09), anchor: "origin", mark: (end: ">"), stroke: 0.8pt)

  // --- Troncone Superiore (mostra il lembo a 45° e l'incrocio a "X") ---
  circle((5.70, 2.95), radius: (0.45, 0.11), stroke: 1pt)
  // Parete sinistra (corta, fino all'innesco dell'elica a y = 2.52)
  line((5.25, 2.95), (5.25, 2.52), stroke: 1pt)
  // Parete destra (lunga, scende fino alla punta del becco di flauto a y = 1.82)
  line((6.15, 2.95), (6.15, 1.82), stroke: 1pt)
  // Taglio elicoidale frontale a -45° (da alto-sx a basso-dx)
  bezier((5.25, 2.52), (6.15, 1.82), (5.50, 2.38), (5.92, 1.95), stroke: 1.2pt)
  // Bordo posteriore dell'elica (tratteggiato dietro il cilindro)
  bezier((5.25, 2.52), (6.15, 1.82), (5.55, 2.15), (5.90, 1.85), stroke: (dash: "dashed", thickness: 0.7pt))
  // Ramo coniugato a +45° sulla superficie cilindrica (forma la ramificazione a "X")
  bezier((5.38, 1.98), (6.08, 2.52), (5.58, 2.12), (5.88, 2.38), stroke: (dash: "densely-dotted", thickness: 1.2pt))

  // --- Troncone Inferiore (separato sotto, mostra la superficie a "becco di flauto") ---
  // Superficie elicoidale inclinata a 45° (campita in grigio per dare tridimensionalità)
  line((5.25, 2.12), (5.65, 1.95), (6.15, 1.42), (5.65, 1.68), close: true, fill: black.transparentize(72%), stroke: none)
  // Bordo anteriore del taglio a 45°
  bezier((5.25, 2.12), (6.15, 1.42), (5.50, 1.90), (5.92, 1.52), stroke: 1.1pt)
  // Bordo posteriore della sezione a becco di flauto (curva ad arco che chiude il becco)
  bezier((5.25, 2.12), (6.15, 1.42), (5.65, 2.02), (6.00, 1.68), stroke: 1pt)
  // Striature di propagazione sulla faccia inclinata a 45°
  line((5.42, 1.98), (5.62, 2.00), stroke: 0.5pt)
  line((5.58, 1.84), (5.80, 1.86), stroke: 0.5pt)
  line((5.76, 1.70), (5.96, 1.72), stroke: 0.5pt)
  // Pareti verticali e base del troncone inferiore
  line((5.25, 2.12), (5.25, 1.15), stroke: 1pt)
  line((6.15, 1.42), (6.15, 1.15), stroke: 1pt)
  arc((5.70, 1.15), start: 180deg, stop: 360deg, radius: (0.45, 0.11), anchor: "origin", stroke: 1pt)

  // Richiami esplicativi chiari per "X" e "Becco di flauto a 45°"
  line((4.95, 2.35), (5.62, 2.22), mark: (end: ">"), stroke: 0.6pt)
  content((4.92, 2.38), text(size: 7pt)[Cricca a "X"], anchor: "east")
  content((4.92, 2.12), text(size: 7pt)[($plus.minus 45^circ$)], anchor: "east")

  line((6.42, 1.75), (5.88, 1.75), mark: (end: ">"), stroke: 0.6pt)
  content((6.45, 1.85), text(size: 7pt)[Superficie a $45^circ$], anchor: "west")
  content((6.45, 1.60), text(size: 7pt)[($sigma_"max" = tau_"max"$)], anchor: "west")

  // Didascalia 2B
  content((5.70, 0.35), text(size: 7pt)[*Elica a $45^circ$ ("becco di flauto" / "X")*], anchor: "center")


  // ==========================================
  // PANNELLO 3: TORSIONE CON INTAGLIO (x_c = 9.50)
  // ==========================================

  // --- 3A. Caso Statico (in alto) ---
  content((7.80, 7.25), text(size: 7pt)[*Caso Statico* ($M_t$ cost.)], anchor: "west")

  // Asse tratteggiato e frecce di torsione
  line((9.50, 7.10), (9.50, 4.35), stroke: (dash: "dashed", thickness: 0.6pt))
  arc((9.50, 6.88), start: 140deg, stop: 440deg, radius: (0.32, 0.09), anchor: "origin", mark: (end: ">"), stroke: 0.8pt)
  arc((9.50, 4.52), start: 30deg, stop: 250deg, radius: (0.32, 0.09), anchor: "origin", mark: (end: ">"), stroke: 0.8pt)

  // Metà superiore provino intagliato
  circle((9.50, 6.62), radius: (0.45, 0.11), stroke: 1pt)
  line((9.05, 6.62), (9.05, 6.02), stroke: 1pt)
  line((9.95, 6.62), (9.95, 6.02), stroke: 1pt)
  arc((9.50, 6.02), start: 180deg, stop: 360deg, radius: (0.45, 0.11), anchor: "origin", stroke: 1pt)
  // Gola dell'intaglio superiore
  bezier((9.05, 6.02), (9.20, 5.86), (9.07, 5.93), (9.15, 5.88), stroke: 1pt)
  bezier((9.95, 6.02), (9.80, 5.86), (9.93, 5.93), (9.85, 5.88), stroke: 1pt)
  arc((9.50, 5.86), start: 180deg, stop: 360deg, radius: (0.30, 0.08), anchor: "origin", stroke: 1pt)

  // Metà inferiore provino intagliato (rottura piana nella gola)
  circle((9.50, 5.42), radius: (0.45, 0.11), stroke: 1pt)
  line((9.20, 5.42), (9.20, 5.54), stroke: 1pt)
  line((9.80, 5.42), (9.80, 5.54), stroke: 1pt)
  arc((9.50, 5.42), start: 180deg, stop: 360deg, radius: (0.30, 0.08), anchor: "origin", stroke: 0.8pt)
  circle((9.50, 5.54), radius: (0.30, 0.08), fill: black.transparentize(55%), stroke: 1pt)
  line((9.05, 5.42), (9.05, 4.78), stroke: 1pt)
  line((9.95, 5.42), (9.95, 4.78), stroke: 1pt)
  arc((9.50, 4.78), start: 180deg, stop: 360deg, radius: (0.45, 0.11), anchor: "origin", stroke: 1pt)

  content((10.02, 5.65), text(size: 7pt)[Gola a $90^circ$], anchor: "west")

  // Didascalia 3A
  content((9.50, 4.05), text(size: 7pt)[*Recisione piana a $90^circ$ nella gola*], anchor: "center")


  // --- 3B. Caso a Fatica (in basso) ---
  content((7.80, 3.55), text(size: 7pt)[*Caso a Fatica* ($M_t (t)$)], anchor: "west")

  // Asse tratteggiato e frecce di torsione alternata
  line((9.50, 3.42), (9.50, 0.65), stroke: (dash: "dashed", thickness: 0.6pt))
  arc((9.50, 3.20), start: 100deg, stop: 440deg, radius: (0.32, 0.09), anchor: "origin", mark: (start: ">"), stroke: 0.8pt)
  arc((9.50, 0.85), start: 100deg, stop: 440deg, radius: (0.32, 0.09), anchor: "origin", mark: ( end: ">"), stroke: 0.8pt)

  // Metà superiore provino intagliato a fatica
  circle((9.50, 2.92), radius: (0.45, 0.11), stroke: 1pt)
  line((9.05, 2.92), (9.05, 2.32), stroke: 1pt)
  line((9.95, 2.92), (9.95, 2.32), stroke: 1pt)
  arc((9.50, 2.32), start: 180deg, stop: 360deg, radius: (0.45, 0.11), anchor: "origin", stroke: 1pt)
  // Gola intaglio con creste multiple a denti di sega (micro-piani a 45° confinati nell'intaglio)
  bezier((9.05, 2.32), (9.20, 2.15), (9.07, 2.22), (9.15, 2.17), stroke: 1pt)
  bezier((9.95, 2.32), (9.80, 2.15), (9.93, 2.22), (9.85, 2.17), stroke: 1pt)
  line((9.20, 2.15), (9.32, 2.07), (9.45, 2.16), (9.58, 2.07), (9.70, 2.16), (9.80, 2.12), stroke: 0.9pt)

  // Metà inferiore provino intagliato a fatica
  circle((9.50, 1.72), radius: (0.45, 0.11), stroke: 1pt)
  line((9.20, 1.72), (9.20, 1.84), stroke: 1pt)
  line((9.80, 1.72), (9.80, 1.84), stroke: 1pt)
  arc((9.50, 1.72), start: 180deg, stop: 360deg, radius: (0.30, 0.08), anchor: "origin", stroke: 0.8pt)
  // Superficie di rottura nella gola con cricche radiali/lamellari ("aspetto a raggiera")
  circle((9.50, 1.84), radius: (0.30, 0.08), fill: black.transparentize(80%), stroke: 1pt)
  line((9.20, 1.84), (9.50, 1.92), (9.55, 1.76), (9.30, 1.78), close: true, fill: black.transparentize(40%), stroke: none)
  line((9.50, 1.84), (9.75, 1.88), stroke: 0.6pt)
  line((9.50, 1.84), (9.78, 1.82), stroke: 0.6pt)
  line((9.50, 1.84), (9.68, 1.78), stroke: 0.6pt)
  line((9.05, 1.72), (9.05, 1.15), stroke: 1pt)
  line((9.95, 1.72), (9.95, 1.15), stroke: 1pt)
  arc((9.50, 1.15), start: 180deg, stop: 360deg, radius: (0.45, 0.11), anchor: "origin", stroke: 1pt)

  content((10.02, 1.95), text(size: 7pt)[Creste a $45^circ$], anchor: "west")

  // Didascalia 3B
  content((9.50, 0.35), text(size: 7pt)[*Frattura frastagliata nella gola*], anchor: "center")
})

)





#v(1em)


== Caratterizzazione a Fatica: La Flessione Rotante <caratterizzazione-a-fatica-la-flessione-rotante>

I dati fondamentali per la caratterizzazione a fatica dei materiali derivano storicamente da prove di *flessione rotante* con sollecitazione nominale ciclica ad ampiezza costante.

*La Macchina di Wöhler (Flessione rotante a quattro appoggi):* Come visibile nello schema a fianco, la provetta è supportata alle estremità ed è soggetta a forze concentrate nelle zone mediane. Questo genera un diagramma del momento flettente a trapezio, garantendo un momento flettente $M_f$ perfettamente costante nella zona centrale calibrata. La tensione massima ($sigma_"max"$) sulle fibre esterne della sezione segue la formula di Navier: 
$ sigma_"max" = M_f / W_f $ 
dove $W_f$ è il modulo di resistenza a flessione.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    A causa della rapida rotazione, un singolo volumetto di materiale sulla superficie esterna esplora l'intero gradiente di tensioni in un giro completo.

    *Risultato fondamentale:* Il provino subisce localmente un carico ciclico nel tempo rigorosamente *alterno simmetrico* ($sigma_m = 0$, $R = -1$).
  ],
  [
    #image("image2.png", width: 90%)
  ]
)
#v(1em)

*Condizioni standard del provino:* Per caratterizzare il materiale puro, le normative impongono l'utilizzo di provette con diametro di circa $10 "mm"$ e una superficie rigorosamente lucidata a specchio (per evitare che la finitura grezza funga da intaglio). Non vi è dipendenza significativa dalla frequenza nel range compreso tra $1$ e $100 "Hz"$.

*Nota bene (Effetti della Frequenza e della Temperatura):* Limitare la frequenza impedisce un eccessivo smorzamento strutturale interno. A frequenze superiori, l'energia dissipata si trasforma in calore, surriscaldando il provino e accoppiando impropriamente la fatica meccanica a quella termica, falsando i risultati.

*Diagrammi di Wöhler (Curve S-N):* Rappresentano i dati sperimentali riportando in ascissa il logaritmo del numero di cicli ($N$) e in ordinata l'ampiezza di sollecitazione alternata ($sigma_a$). Si individuano tre regioni principali:

- *Fatica oligociclica (LCF - Low Cycle Fatigue, fino a $approx 10^3$ cicli):* Parte dal comportamento statico. I livelli di tensione sono altissimi, entrando in un regime spiccatamente elasto-plastico. Spesso viene analizzata a parte tramite la deformazione.
- *Resistenza a termine (HCF - High Cycle Fatigue):* Vi è una stretta dipendenza tra l'abbattimento della resistenza e l'aumento dei cicli; la curva cade progressivamente.
- *Resistenza a vita infinita:* Inizia dopo un punto di transizione detto "ginocchio". La curva tende ad un asintoto orizzontale definito *limite di fatica* ($sigma_D$). Al di sotto di tale limite, il materiale non subisce apparentemente diminuzioni di resistenza ciclica.

*Metodo Staircase (Per la determinazione del limite di fatica):* Poiché la fatica è un fenomeno intrinsecamente disperso, si usano metodi statistici. Il metodo Staircase varia l'ampiezza di carico a salti costanti ($d$) alzandola o abbassandola in base all'esito della prova precedente (rotta o non rotta) su un traguardo di cicli prefissato (es. $2 dot 10^6$). Il risultato fornisce la curva mediana usata in progettazione, corrispondente a una probabilità di rottura del 50% (valore $B_50$). Occorrono almeno 15 provini utili per determinare validamente un singolo punto asintotico.

*Stima di prima approssimazione del limite di fatica:* Dato l'enorme sforzo sperimentale richiesto, storicamente si tenta di correlare la resistenza a fatica al carico unitario di rottura statico ($R_m$):

*Criterio di Bach:*
$ sigma_"D-1" &= 0.5 dot R_m quad &("Cicli puramente alternati, " R = -1) \
  sigma_"D0" &= 0.3 dot R_m quad &("Cicli all'origine, " R = 0) $

*Criterio di Fuchs (Specifico per acciai legati):*
$ sigma_"D-1" &= 0.5 dot R_m quad &"per " R_m < 1400 " MPa" \
  sigma_"D-1" &= 700 " MPa" quad &"per " R_m >= 1400 " MPa" $
Questi criteri empirici sono tollerabili esclusivamente per stime preliminari, ma inaccettabili per la progettazione esecutiva dove i dati sperimentali esatti sono mandatori.

== Costruzione della Curva S-N ed Equazione di Basquin <costruzione-della-curva-s-n-ed-equazione-di-basquin>

La costruzione approssimata numerica del diagramma S-N rettifica la curva nella regione di resistenza a termine utilizzando una rappresentazione in *scala log-log*. I due poli di ancoraggio per tracciare questo segmento rettilineo sono mostrati nella figura a fianco.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    - *Punto F (Inizio pendenza):* Esclude la fatica oligociclica innescando da $N_F = 10^3$ cicli. La tensione corrispondente si stima come $sigma_F = 0.9(R_m - sigma_m)$.
    - *Punto G (Ginocchio):* Fissato al numero di cicli $N_G$ (tipicamente $2 dot 10^6$ per gli acciai e $10^7$ per l'alluminio) in corrispondenza del limite di fatica $sigma_D$.
  ],
  [
    // commenti: sistema fisico (curva di Wöhler), elementi (assi, scala logaritmica compressa sull'asse x, curva spezzata), relazioni (ginocchio a vita infinita, pendenza), elementi ignorati (curvatura a mano)
#canvas(length: 1cm, {
  import draw: *

  // Assi
  line((-0.5, 0), (6.5, 0), mark: (end: ">"), stroke: 1pt)
  line((0, -0.5), (0, 4), mark: (end: ">"), stroke: 1pt)
  content((6.5, -0.4), text(blue)[$N$], anchor: "north")
  content((-0.3, 3.8), text(blue)[$sigma_a$], anchor: "east")

  // Tacche asse x (logaritmico, compresso verso l'asse y con passo 0.8)
  line((0.8, -0.15), (0.8, 0.15), stroke: 1pt)
  content((0.8, -0.5), text(blue)[$10$])
  
  line((1.6, -0.15), (1.6, 0.15), stroke: 1pt)
  content((1.6, -0.5), text(blue)[$10^2$])
  
  line((2.4, -0.15), (2.4, 0.15), stroke: 1pt)
  content((2.4, -0.5), text(blue)[$10^3$])
  
  line((3.2, -0.15), (3.2, 0.15), stroke: 1pt)
  content((3.2, -0.5), text(blue)[$10^4$])
  
  line((4.0, -0.15), (4.0, 0.15), stroke: 1pt)
  content((4.0, -0.5), text(blue)[$10^5$])
  
  line((4.8, -0.15), (4.8, 0.15), stroke: 1pt)
  content((4.8, -0.5), text(blue)[$10^6$])

  // Valori asse y
  content((-0.2, 1), text(blue)[$sigma_D$], anchor: "east")
  content((-0.2, 3), text(blue)[$sigma_F$], anchor: "east")

  // Linee di riferimento (tratteggiate)
  line((0, 3), (2.4, 3), stroke: (dash: "dashed", thickness: 0.6pt))
  line((2.4, 0), (2.4, 3), stroke: (dash: "dashed", thickness: 0.6pt))
  
  line((0, 1), (4.8, 1), stroke: (dash: "dashed", thickness: 0.6pt))
  line((4.8, 0), (4.8, 1), stroke: (dash: "dashed", thickness: 0.6pt))

  // Curva di fatica idealizzata
  line((2.4, 3), (4.8, 1), stroke: 1.5pt)
  line((4.8, 1), (6.0, 1), stroke: 1.5pt)

  // Punti F e G
  circle((2.4, 3), radius: 0.07, fill: black)
  circle((4.8, 1), radius: 0.07, fill: black)
  
  // Etichette F e G
  content((2.1, 3.2), text(blue)[$F$])
  content((5.1, 0.8), text(blue)[$G$])
})
  ]
)
#v(1em)

Nei diagrammi log-log, il tratto inclinato è rigorosamente rettilineo ed è normato dall'*Equazione di Basquin*:
$ N sigma_a^k = B ==> log(N) = log(B) - k log(sigma_a) $
I parametri costanti $B$ (intercetta spaziale) e $k$ (pendenza) si determinano analiticamente imponendo il passaggio della retta per i due punti noti $F$ e $G$.

Impostiamo il sistema di equazioni logaritmiche per i punti $F$ e $G$:
$ cases(
  log(N_F) = log(B) - k log(sigma_F),
  log(N_G) = log(B) - k log(sigma_D)
) $

Sottraendo la prima equazione dalla seconda per eliminare l'incognita $log(B)$, isoliamo la pendenza $k$:
$ log(N_G) - log(N_F) = - k log(sigma_D) + k log(sigma_F) = k [log(sigma_F) - log(sigma_D)] $
$ bold(k = (log(N_G) - log(N_F)) / (log(sigma_F) - log(sigma_D))) $

Una volta nota la pendenza $k$, la costante $B$ si ricava immediatamente sostituendo le coordinate del ginocchio (o del punto F) nell'equazione originaria: 
$ bold(B = N_G dot sigma_D^k) $

Nota l'equazione completa, è possibile calcolare la durata attesa $N$ per una qualsiasi ampiezza di sollecitazione $sigma_a$ compresa nel tratto a termine, semplicemente invertendo la formula:
$ bold(N = B / sigma_a^k) $

== Effetto della Tensione Media ($sigma_m$) <effetto-della-tensione-media-sigma_m>

Le prove dimostrano che la resistenza a fatica precipita se la tensione media di trazione sale. È fondamentale distinguere tra le condizioni di laboratorio e quelle reali di esercizio:

- Le *prove a fatica standard* (curva di Wöhler) operano a tensione media fissa, tipicamente nulla (*$sigma_m = 0$*, ciclo alterno simmetrico).
- Nella *pratica applicativa reale*, i componenti meccanici sono quasi sempre soggetti a carichi che includono una componente statica (*$sigma_m != 0$*).

All'aumentare del valore della tensione media $sigma_m$, la durata a fatica del componente *diminuisce*. Questo effetto è particolarmente critico quando la tensione media è di trazione (*$sigma_m > 0$*); in tal caso, l'ampiezza di sollecitazione alternata ($sigma_a$) tollerabile *decresce in modo molto rapido*, in quanto la trazione media favorisce l'apertura e la propagazione delle cricche. Al contrario, una tensione media di compressione ($sigma_m < 0$) può moderatamente accrescere la resistenza, ostacolando l'apertura dei difetti.

== Diagramma di Haigh e Margini di Sicurezza <diagramma-di-haigh-e-margini-di-sicurezza>

Per analizzare l'effetto combinato della tensione alternata e media a parità di numero di cicli (generalmente in area di sicurezza per vita illimitata), si introduce il *Diagramma di Haigh*. Esso riporta in ascissa la tensione media $sigma_m$ e in ordinata la tensione alternata $sigma_a$.

Per semplificare in ottica cautelativa per il progetto, si utilizza la *Retta di Goodman*, che congiunge il limite di fatica puro $sigma_"D-1"$ (sull'asse delle ordinate) con il carico di rottura statica $R_m$ (sull'asse delle ascisse). L'equazione della retta è:
$ sigma_D / sigma_"D-1" + sigma_m / R_m = 1 ==> sigma_D = sigma_"D-1" - sigma_"D-1" / R_m sigma_m $
Tale formulazione definisce il "tetto" per non avere cedimenti da fatica.

Oltre alla fatica, si deve evitare lo snervamento statico. Si introducono nel diagramma rette a $-45^circ$ (e $+45^circ$ a sinistra) partendo dai limiti di snervamento plastico $R_"eH"$. L'area reale di sicurezza è il poligono marcato dall'incrocio tra l'area sotto la retta di Goodman e le rette di plasticizzazione.

#figure(
  table(
    columns: 2,
    align: (center, left),
    table.header([*Tratto*], [*Dominio di validità della tensione media ($sigma_m$)*]),
    [*a*], [Da snervamento a compressione al vertice sinistro del diagramma di fatica: \ $- R_"eH" <= sigma_m <= sigma_"D-1" - R_"eH"$],
    [*b*], [Ramo ascendente per compressione decrescente (nessuna penalizzazione a fatica): \ $sigma_"D-1" - R_"eH" <= sigma_m <= 0$],
    [*c*], [Ramo discendente principale di fatica in trazione (Retta di Goodman): \ $0 <= sigma_m <= (R_"eH" - sigma_"D-1") / (1 - sigma_"D-1"/R_m)$],
    [*d*], [Troncamento per snervamento statico in trazione (il collasso avviene prima per plasticizzazione che per fatica): \ $(R_"eH" - sigma_"D-1") / (1 - sigma_"D-1"/R_m) <= sigma_m <= R_"eH"$],
  ),
  caption: [*Analisi del Poligono di Haigh: Definizione dei Tratti Limite per $sigma_m$*]
)

#grid(
  columns: (0.8fr, 1.5fr),
  column-gutter: 1.9em,
  align: (left + horizon, center + horizon),
  [
    Il *Poligono di Sicurezza Completo* (visibile a fianco, noto anche come diagramma di Goodman-Smith se tracciato con le tensioni estreme) impone che le pendenze a fatica siano troncate dai segmenti lineari dello snervamento statico. Questo garantisce la protezione dei materiali duttili sia contro il cedimento progressivo, sia contro deformazioni plastiche macroscopiche.
  ],
  [
    #canvas(length: 0.85cm, {
  import draw: *

  // Area di sicurezza (Poligono verde scuro/chiaro)
  line((-4, 0), (-1, 3), (0, 3), (2.5, 1.5), (4, 0), close: true, fill: rgb(220, 245, 220), stroke: none)

  // Assi
  line((-6, 0), (6, 0), mark: (end: ">"), stroke: 1pt)
  line((0, -2), (0, 6), mark: (end: ">"), stroke: 1pt)
  content((6, -0.4), text(blue)[$sigma_m$], anchor: "north")
  content((-0.4, 6), text(blue)[$sigma_a$], anchor: "east")

  // Linee di limite (Rottura statica R_m)
  line((-5, 0), (0, 5), stroke: 1pt)
  line((0, 5), (5, 0), stroke: 1pt)
  
  // Linee di limite (Snervamento R_eS)
  line((-4, 0), (0, 4), stroke: 1pt)
  line((0, 4), (4, 0), stroke: 1pt)

  // Linea di Fatica (Goodman)
  line((0, 3), (5, 0), stroke: 1pt)

  // Contorno esplicito del poligono per risalto
  line((-4, 0), (-1, 3), stroke: 2pt)
  line((-1, 3), (0, 3), stroke: 2pt)
  line((0, 3), (2.5, 1.5), stroke: 2pt)
  line((2.5, 1.5), (4, 0), stroke: 2pt)

  // Etichette assi
  content((-5, -0.4), text(blue)[$-R_m$], anchor: "north")
  content((-4.1, -0.4), text(blue)[$-R_"eH"$], anchor: "north")
  content((4.1, -0.4), text(blue)[$R_"eH"$], anchor: "north")
  content((5, -0.4), text(blue)[$R_m$], anchor: "north")
  
  content((-0.2, 2.8), text(blue)[$sigma_"D-1"$], anchor: "east")
  content((-0.2, 4), text(blue)[$R_"eH"$], anchor: "east")
  content((-0.2, 5), text(blue)[$R_m$], anchor: "east")

  // Linee tratteggiate di proiezione per cambi di pendenza
  line((-1, 0), (-1, 3), stroke: (dash: "dashed", thickness: 0.6pt))
  line((2.5, 0), (2.5, 1.5), stroke: (dash: "dashed", thickness: 0.6pt))
  
  content((-1.2, -0.4), text(blue)[$sigma_"ab"$], anchor: "north")
  content((2.5, -0.4), text(blue)[$sigma_"cd"$], anchor: "north")

  // Riquadri equazioni e frecce di puntamento
  // 1. Snervamento in compressione
  line((-5.2, 1.55), (-2.44, 1.55), stroke: (paint: blue, thickness: 0.6pt))
  content((-5.5, 1.5), box(stroke: 0.6pt + blue, fill: white, inset: 4pt)[#text(blue)[$sigma_a - sigma_m = R_"eH"$]])

  // 2. Limite di fatica per tensioni medie di compressione
  bezier((-1.5, 4), (-0.5, 3.0), (-1.0, 3.2), (-0.8, 3.1), stroke: (paint: blue, thickness: 0.6pt))
  content((-2.4, 4.2), box(stroke: 0.6pt + blue, fill: white, inset: 4pt)[#text(blue)[$sigma_a = sigma_"D-1"$]])

  // 3. Rottura in trazione
  line((2.5, 3.5), (0.5, 3.5), stroke: (paint: blue, thickness: 0.6pt))
  content((3.6, 3.5), box(stroke: 0.6pt + blue, fill: white, inset: 4pt)[#text(blue)[$sigma_a + sigma_m = R_m$]])

  // 4. Linea di Goodman (fatica a vita infinita)
  line((4, 1.6), (1.7, 2), stroke: (paint: blue, thickness: 0.6pt))
  content((5.5, 1.5), box(stroke: 0.6pt + blue, fill: white, inset: 6pt)[#text(blue)[$sigma_a / sigma_"D-1" + sigma_m / R_m = 1$]])

  // Intervalli orizzontali a, b, c, d
  line((-4, -1.0), (-4, -1.4), stroke: 1pt)
  line((-1, -1.0), (-1, -1.4), stroke: 1pt)
  line((0, -1.0), (0, -1.4), stroke: 1pt)
  line((2.5, -1.0), (2.5, -1.4), stroke: 1pt)
  line((4, -1.0), (4, -1.4), stroke: 1pt)

  line((-4, -1.2), (-1, -1.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((-2.5, -0.9), text(blue)[$a$])

  line((-1, -1.2), (0, -1.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((-0.5, -0.9), text(blue)[$b$])

  line((0, -1.2), (2.5, -1.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((1.25, -0.9), text(blue)[$c$])

  line((2.5, -1.2), (4, -1.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((3.25, -0.9), text(blue)[$d$])
})
  ]
)

#v(1em)

*Valutazione del Coefficiente di Sicurezza ($C S$):* Se un punto di lavoro $P(sigma_m, sigma_a)$ è all'interno del contorno, è in condizioni di sicurezza. Quantificare il margine richiede di misurare una distanza dal contorno lungo una direzione che descriva l'evoluzione fisica del carico (il "ciclo di esplosione").

#grid(
  columns: (0.6fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    Se assumiamo che entrambe le fluttuazioni crescano mantenendo inalterato il loro rapporto (proporzionalmente), la progressione verso la rottura descrive un segmento radiale passante per l'origine. Il $C S$ si calcola come rapporto tra le ampiezze limite e quelle operative:
    $ C S = sigma_a^"lim" / sigma_a^P = sigma_m^"lim" / sigma_m^P $
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  // Assi
  line((-5, 0), (6, 0), mark: (end: ">"), stroke: 1pt)
  line((0, -1), (0, 5), mark: (end: ">"), stroke: 1pt)
  content((6, -0.4), text(blue)[$sigma_m$], anchor: "north")
  content((-0.4, 5), text(blue)[$sigma_a$], anchor: "east")

  
  // Linee di limite (Snervamento R_eH)
  line((-4, 0), (0, 4), stroke: 1pt)
  line((0, 4), (4, 0), stroke: 1pt)

  // Linea di Fatica (Goodman)
  line((0, 3), (5, 0), stroke: 1pt)

  // Contorno esplicito del poligono di sicurezza
  line((-4, 0), (-1, 3), stroke: 1.5pt)
  line((-1, 3), (0, 3), stroke: 1.5pt)
  line((0, 3), (2.5, 1.5), stroke: 1.5pt)
  line((2.5, 1.5), (4, 0), stroke: 1.5pt)

  // Etichette assi estremità
  
  content((-4.1, -0.4), text(blue)[$-R_"eH"$], anchor: "north")
  content((4.1, -0.4), text(blue)[$R_"eH"$], anchor: "north")
  content((5, -0.4), text(blue)[$R_m$], anchor: "north")
  
  content((-0.2, 2.8), text(blue)[$sigma_"D-1"$], anchor: "east")
  content((-0.2, 4), text(blue)[$R_"eH"$], anchor: "east")
  

  // Linee tratteggiate di proiezione per cambi di pendenza
  line((-1, 0), (-1, 3), stroke: (dash: "dashed", thickness: 0.6pt))
  line((2.5, 0), (2.5, 1.5), stroke: (dash: "dashed", thickness: 0.6pt))
  
  content((-1.2, -0.4), text(blue)[$sigma_"ab"$], anchor: "north")
  content((2.6, -0.4), text(blue)[$sigma_"CD"$], anchor: "north")

  // --- RETTA DI CARICO E PUNTI NOTEVOLI ---
  // Retta di carico dall'origine
  line((0, 0), (1.8, 1.92), stroke: 1.2pt)

  // Punto di lavoro P e relative proiezioni (calcolato a metà del segmento)
  circle((0.9, 0.96), radius: 0.07, fill: red, stroke: none)
  content((1.1, 0.7), text(blue)[$P$])
  
  line((0.9, 0.96), (0, 0.96), stroke: (dash: "dashed", thickness: 0.6pt))
  line((0.9, 0.96), (0.9, 0), stroke: (dash: "dashed", thickness: 0.6pt))
  content((-0.05, 0.96), text(blue)[$sigma_"a, lav"$], anchor: "east")
  content((0.7, 0), text(blue)[$sigma_"m, lav"$], anchor: "north")

  // Punto limite (intersezione con la linea di Goodman) e relative proiezioni
  circle((1.8, 1.92), radius: 0.07, fill: red, stroke: none)
  
  line((1.8, 1.92), (0, 1.92), stroke: (dash: "dashed", thickness: 0.6pt))
  line((1.8, 1.92), (1.8, 0), stroke: (dash: "dashed", thickness: 0.6pt))
  content((-0.05, 1.92), text(blue)[$sigma_"a, lim"$], anchor: "east")
  content((1.8, 0), text(blue)[$sigma_"m, lim"$], anchor: "north")

  // --- INTERVALLI ORIZZONTALI ---
  line((-4, -1.0), (-4, -1.4), stroke: 1pt)
  line((-1, -1.0), (-1, -1.4), stroke: 1pt)
  line((0, -1.0), (0, -1.4), stroke: 1pt)
  line((2.5, -1.0), (2.5, -1.4), stroke: 1pt)
  line((4, -1.0), (4, -1.4), stroke: 1pt)

  line((-4, -1.2), (-1, -1.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((-2.5, -0.9), text(blue)[$a$])

  line((-1, -1.2), (0, -1.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((-0.5, -0.9), text(blue)[$b$])

  line((0, -1.2), (2.5, -1.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((1.25, -0.9), text(blue)[$c$])

  line((2.5, -1.2), (4, -1.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((3.25, -0.9), text(blue)[$d$])
})
  ]
)
#v(1em)






Analisi delle traiettorie alternative del punto di lavoro $P$ verso il limite:

- Se $sigma_m = "costante"$ (es. recipiente a pressione durante un sisma): La traiettoria è verticale e va a intersecare il limite superiore per l'ascissa $sigma_m^P$. Il $C S$ è il rapporto delle sole ampiezze alternate.
- Se $sigma_a = "costante"$ (es. innalzamento progressivo della pressione di fondo con vibrazioni costanti): La traiettoria è orizzontale e interseca il confine di sicurezza sul limite destro. Il $C S$ si basa sulle sole ascisse.
- Se è presente un precarico fisso iniziale (tensioni residue): Il punto di lavoro risulta traslato di una quantità pari alla tensione residua ($sigma_"res"$), riducendo o aumentando il margine a seconda che sia di trazione o compressione.

== Calcolo a Vita Limitata e Fattori Modificanti
<calcolo-a-vita-limitata-e-fattori-modificanti>

In contesti ingegneristici in cui non è richiesta una vita infinita del componente, il diagramma limite di Haigh non viene tracciato utilizzando il limite di fatica asintotico $sigma_D$, bensì ricorrendo alle *ampiezze di sollecitazione tollerabili $sigma_N$*. Questi valori limite, che risultano rigorosamente maggiori di $sigma_D$, vengono estratti direttamente dalle curve S-N di Wöhler per il numero di cicli $N$ target di progetto e valutati per differenti livelli di tensione media.

Basandosi sull'equazione di Basquin per i diagrammi logaritmici (log-log), possiamo correlare il numero di cicli a rottura con l'ampiezza di tensione. Se $N_L$ è la vita a rottura per una tensione operativa $sigma_a$, e $N_0$ è la vita di progetto associata alla tensione limite $sigma_(N 0)$, vale la relazione:

$ N_L dot sigma_a^k = N_0 dot sigma_(N 0)^k quad ==> quad N_L / N_0 = (sigma_(N 0) / sigma_a)^k $

Definendo il coefficiente di sicurezza a vita limitata come $"CS"_N = N_L / N_0$ e il coefficiente di sicurezza sulle tensioni come $"CS"_sigma = sigma_(N 0) / sigma_a$, otteniamo la relazione fondamentale:

$ "CS"_N = "CS"_sigma^k $

dove $k$ è l'esponente derivato dalla pendenza della curva di Wöhler nel tratto a termine.

=== Dal Provino di Laboratorio al Componente Reale

I dati di fatica grezzi provengono da provini ideali, di piccole dimensioni e con superfici lucidate a specchio. Per stimare la reale resistenza a fatica di un componente industriale, è indispensabile declassare il limite teorico $sigma_(D-1)$ tramite l'applicazione di una serie di fattori riduttivi (o _modificanti_). Il limite di fatica corretto del componente, $sigma_(D-1)^C$, si esprime come:

$ sigma_(D-1)^C = sigma_(D-1) dot product C_i quad ==> quad sigma_(D-1)^C = C_L dot C_S dot C_F dot sigma_(D-1) $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    *Fattore $C_S$ (Effetto Dimensionale e di Scala):* \
    Questo parametro corregge il limite di fatica tenendo conto delle reali dimensioni del componente in presenza di gradienti di tensione (flessione o torsione). All'aumentare del diametro, il gradiente di tensione dalla superficie verso il cuore diviene meno "ripido". Di conseguenza, un volume molto maggiore di materiale si trova sottoposto a livelli tensionali critici. Statisticamente, ciò incrementa la probabilità di intercettare difetti reticolari, riducendo la resistenza. Si noti che per diametri molto grandi, il gradiente si appiattisce convergendo asintoticamente al caso della trazione pura, assestandosi su un valore limite $C_S approx 0.7$.
  ],
  [#canvas(length: 0.7cm, {
  import draw: *

  // Riempimenti base dei componenti (grigio chiaro)
  circle((0, 6), radius: 1.2, fill: rgb("c0c0c0"), stroke: none)
  circle((0, 0), radius: 3.6, fill: rgb("c0c0c0"), stroke: none)

  // Aree di materiale ad alta tensione (> 80% sigma_a) in rosso trasparente
  // Poligono superiore (R = 1.2, y_base = 6.96)
  line((-0.72, 6.96), (0.72, 6.96), (0.41, 7.127), (0, 7.2), (-0.41, 7.127), close: true, fill: red.transparentize(50%), stroke: none)
  
  // Poligono inferiore (R = 3.6, y_base = 2.88)
  line((-2.16, 2.88), (2.16, 2.88), (1.52, 3.26), (0.93, 3.47), (0, 3.6), (-0.93, 3.47), (-1.52, 3.26), close: true, fill: red.transparentize(50%), stroke: none)

  // Contorni netti dei componenti (disegnati sopra i riempimenti)
  circle((0, 6), radius: 1.2, stroke: 1.2pt)
  circle((0, 0), radius: 3.6, stroke: 1.2pt)

  // Linea di proiezione verticale (allinea le intersezioni dell'80% di tensione, x = 2.8)
  line((2.8, 6.96), (2.8, 2.9), stroke: (paint: gray, thickness: 0.6pt))

  // --- DIAGRAMMA SUPERIORE ---
  // Assi e linee di tensione massima
  line((0, 4.8), (0, 7.2), stroke: (paint: red, thickness: 1.2pt))
  line((0, 7.2), (3.5, 7.2), stroke: (paint: red, thickness: 1pt))
  line((0, 4.8), (-3.5, 4.8), stroke: (paint: red, thickness: 1pt))
  
  // Gradiente di tensione
  line((-3.5, 4.8), (3.5, 7.2), stroke: (paint: green.darken(20%), thickness: 1pt))
  
  // Linea 80% tensione
  line((-0.71, 6.96), (2.81, 6.96), stroke: (paint: blue, thickness: 1.2pt))

  // Etichette superiore
  content((3.6, 7.2), [$sigma_a$], anchor: "south-west")
  content((3.1, 6.96), [$80% sigma_a$], anchor: "north-west")


  // --- DIAGRAMMA INFERIORE ---
  // Assi e linee di tensione massima
  line((0, -3.6), (0, 3.6), stroke: (paint: red, thickness: 1.2pt))
  line((0, 3.6), (3.5, 3.6), stroke: (paint: red, thickness: 1pt))
  line((0, -3.6), (-3.5, -3.6), stroke: (paint: red, thickness: 1pt))
  
  // Gradiente di tensione
  line((-3.5, -3.6), (3.5, 3.6), stroke: (paint: purple, thickness: 1pt))
  
  // Linea 80% tensione
  line((-2.15, 2.88), (2.81, 2.88), stroke: (paint: blue, thickness: 1.2pt))

  // Etichette inferiore
  content((3.6, 3.6), [$sigma_a$], anchor: "south-west")
  content((3.1, 2.88), [$80% sigma_a$], anchor: "north-west")
})
  ]
)

#v(1em)

*Fattore $C_F$ (Finitura Superficiale e Trattamenti)*

Lo stato superficiale incide drammaticamente sulla vita utile, poiché le cricche di fatica nucleano quasi esclusivamente all'esterno. È fondamentale notare che l'effetto della finitura superficiale dipende dal carico di rottura $R_m$ del materiale: materiali alto-resistenziali (con elevato $R_m$) sono intrinsecamente più fragili e, di conseguenza, subiscono un declassamento molto più severo in presenza di finiture non ottimali o asperità.

L'introduzione controllata di uno *stato di tensione residua di compressione* sulla superficie genera un effetto altamente benefico. Trattamenti idonei allo scopo includono la pallinatura (shot peening), la rullatura a freddo, la cementazione e la nitrurazione.

Il meccanismo fisico protettivo si basa sull'applicazione di un carico locale molto intenso che porta a snervamento plastico (in compressione) lo strato più esterno. Il nucleo sottostante, rimanendo in campo elastico, si oppone all'espansione laterale dello strato deformato. Il risultato pratico è la generazione di un guscio costantemente sollecitato a compressione autobilanciata, che ostacola attivamente l'apertura e la propagazione delle micro-cricche.

_Attenzione alle criticità:_ L'effetto benefico può perdersi o ribaltarsi. Operazioni miste come la formatura a freddo hanno risultati variabili. Processi di formatura e rullatura _a caldo_ generano quasi invariabilmente un effetto negativo, introducendo tensioni residue superficiali di _trazione_ a causa della decarburazione. Al contrario, trattamenti termici come la *tempra* (specialmente a induzione) risultano benefici, poiché la trasformazione martensitica superficiale induce un'espansione volumetrica che genera tensioni residue di compressione. Ulteriori trattamenti chimico-galvanici che declassano la fatica sono la cromatura spessa, la nichelatura e l'anodizzazione.

*Fattore di Carico ($C_L$): Flessione vs. Trazione pura*

L'esperienza sperimentale dimostra che a scatenare la rottura per fatica non è il mero raggiungimento puntuale della tensione $sigma_max$ in superficie, ma lo sforzo gravante su un *volume efficace* di materiale situato in uno strato sottocutaneo critico.

- *Sollecitazione Flessionale:* È caratterizzata da un gradiente di sforzo molto ripido. La "zona di processo" critica interna sopporta una tensione mediata notevolmente inferiore al picco massimo superficiale.

- *Sollecitazione di Trazione pura:* A parità teorica di tensione massima superficiale, la trazione pura impone uno sforzo elevato e omogeneo su un volume di materiale immensamente maggiore rispetto alla flessione.

Questo stato tensionale omogeneo su ampi volumi agevola drammaticamente l'innesco di difetti statistici. Il valore empirico di sicurezza standard adottato per compensare questo effetto in caso di trazione è un coefficiente correttivo $C_L approx 0.7 div 0.85$. Da qui deriva la relazione operativa per calcolare il limite in trazione-compressione ($sigma_(D-1)^(t c)$) partendo da quello noto per flessione ($sigma_(D-1)^b$):

$ sigma_(D-1)^(t c) = alpha dot sigma_(D-1)^b $ 

dove $alpha$ coincide numericamente con $C_L$.

*Scala di Declassamento dei Carichi (Rispetto alla base di flessione rotante = 100%):*

- Flessione rotante pura: *100%* (Condizione ideale base).
- Flessione alternata piana (su un solo piano di sollecitazione): *$95 div 99 %$*.
- Trazione alternata pura (Carico assiale): Severa riduzione a *$70 div 85 %$*.
- Torsione alternata pura trasversale: *58%*.

== Effetti Geometrici di Intaglio (Concentrazione delle Tensioni)
<effetti-geometrici-di-intaglio-concentrazione-delle-tensioni>

Un intaglio geometrico (fori, gole, variazioni di sezione, raccordi) provoca un innalzamento locale e asintotico dello stato tensionale rispetto al valore nominale di progetto. Tale incremento è definito dalla relazione:

$ sigma_"locale" = K_t dot sigma_n quad "dove" quad K_t = sigma_max / sigma_n $

dove $K_t$ è il Fattore teorico di Concentrazione delle Tensioni.

Dal punto di vista della meccanica dei solidi, le repentine variazioni di sezione costringono le linee primarie di flusso tensionale a deviare bruscamente dalla loro traiettoria rettilinea e ad "affollarsi" attorno al difetto geometrico. Questa deformazione del campo genera una formidabile amplificazione locale dello stress, fungendo da innesco primario per il cedimento strutturale. Qualora la geometria presenti intagli multipli ravvicinati, nella progettazione convenzionale è ammissibile ricorrere all'applicazione lineare del Principio di Sovrapposizione degli Effetti.

=== Cedimento Statico Unidimensionale (1D)
<cedimento-statico-unidimensionale-1d>

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *1D - Materiali Fragili (es. ghise, ceramici):* \
    L'approccio è estremamente severo. Essendo incapaci di ridistribuire lo sforzo per scorrimento plastico, si assume che il collasso avvenga non appena in un qualsiasi singolo punto della sezione minima resistente il picco locale oltrepassi il limite critico.
    $ sigma_"nom" = P / (h dot b) $
    $ sigma_max = K_t dot sigma_"nom" < R_m $
  ],
  [
    #canvas(length: 0.8cm, {
  import draw: *

  // Contorno del provino
  line((-3, 2), (-0.7, 2), stroke: 1pt)
  arc((0, 2), start: 180deg, stop: 360deg, radius: 0.7, anchor: "origin", stroke: 1pt)
  line((0.7, 2), (3, 2), stroke: 1pt)
  line((3, 2), (3, -2), stroke: 1pt)
  line((3, -2), (0.7, -2), stroke: 1pt)
  arc((0, -2), start: 0deg, stop: 180deg, radius: 0.7, anchor: "origin", stroke: 1pt)
  line((-0.7, -2), (-3, -2), stroke: 1pt)
  line((-3, -2), (-3, 2), stroke: 1pt)

  // Carico P a sinistra
  line((-3, 0), (-4.5, 0), mark: (end: ">"), stroke: 1pt)
  content((-3.75, 0.4), text(blue)[$P$])

  // Carico P a destra
  line((3, 0), (4.5, 0), mark: (end: ">"), stroke: 1pt)
  content((3.75, 0.4), text(blue)[$P$])

  // Quota H (Altezza totale)
  line((3, 2), (5.5, 2), stroke: 0.6pt)
  line((3, -2), (5.5, -2), stroke: 0.6pt)
  line((5, -2), (5, 2), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((5.3, 0), text(blue)[$H$])

  // Quota h (Altezza sezione minima)
  line((0, 1.3), (1.5, 1.3), stroke: 0.6pt)
  line((0, -1.3), (1.5, -1.3), stroke: 0.6pt)
  line((1.1, -1.3), (1.1, 1.3), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((1.4, 0), text(blue)[$h$])
})
  ]
)
#v(1em)

*1D - Materiali Duttili (es. acciai da costruzione, allumini):* \
La presenza di un'ampia zona plastica permette di differenziare più modalità di cedimento:

- *Criterio di primo snervamento (Condizione progettuale restrittiva ed elastica):* Si impedisce che anche il singolo punto più sollecitato sul bordo dell'intaglio entri in plasticità.
  $ sigma_max = K_t dot sigma_"nom" < R_(e H) $

- *Condizione di completa plasticizzazione della sezione resistente:* Si accetta che il picco di tensione iniziale raggiunga lo snervamento e si "ridistribuisca" verso il cuore del pezzo. Il collasso avviene solo quando l'intera sezione è plastificata. A questo punto, si neutralizza l'effetto geometrico ponendo convenzionalmente $K_t = 1$.
  $ sigma_"nom" < R_(e H) $

- *Criterio di rottura duttile ultima:* Poco prima del collasso catastrofico, il componente intagliato si comporta meccanicamente come se fosse costituito da un pezzo integro dotato di sezione retta costante pari a quella minima, assumendo ancora $K_t = 1$.
  $ sigma_"nom" < R_m $

=== Cedimento Statico Tridimensionale (3D)
<cedimento-statico-tridimensionale-3d>

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *3D - Materiali Fragili (Criterio di Rankine):* \
    In uno stato di sforzo tridimensionale, si applica rigorosamente l'ipotesi di cedimento basata sulla tensione normale massima principale. È obbligatorio esaltare separatamente ciascuna singola componente di tensione applicando il rispettivo fattore geometrico $K_t$.
    $ sigma_max &= K_(t b) dot sigma^b + K_(t t c) dot sigma^(t c) \
      tau_max &= K_(t tau) dot tau $
    Si calcola quindi la tensione normale principale massima equivalente:
    $ sigma_("id", max) = sigma_max / 2 + sqrt((sigma_max / 2)^2 + tau_max^2) <= R_m $
  ],
  [
    #image("image9.png", width: 70%)
  ]
)
#v(1em)
*3D - Materiali Duttili:* \
Poiché la ridistribuzione plastica attorno a geometrie intagliate 3D è ingovernabile analiticamente, la normativa progettuale prevede di procedere per vie convenzionali:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *1. Verifica convenzionale a primo snervamento 3D:* \
    Si utilizza il criterio dell'energia di distorsione (Von Mises) per calcolare la tensione ideale, avendo cura di amplificare preliminarmente le tensioni nominali di base con i rispettivi fattori geometrici $K_t$ prima di inserirle sotto radice.
    $ sigma_max^b &= K_(t b) dot sigma_"nom"^b \
      sigma_max^(t c) &= K_(t t c) dot sigma_"nom"^(t c) \
      tau_max &= K_(t tau) dot tau_"nom" $
    $ sigma_("id", max) = sqrt((sigma_max^b + sigma_max^(t c))^2 + 3 tau_max^2) < R_(e H) $
  ],
  [
    #image("image9.png", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *2. Verifica convenzionale a completa plasticizzazione 3D:* \
    Esaurita la ridistribuzione plastica sulla sezione critica, si impone brutalmente $K_t = 1$ per tutte le direzioni. Si procede calcolando la tensione ideale (con Von Mises) basandosi esclusivamente sulle macroscopiche tensioni nominali teoriche di de Saint-Venant.
    $ sigma_("id", "nom") = sqrt((sigma_"nom"^b + sigma_"nom"^(t c))^2 + 3 tau_"nom"^2) < R_(e H) $
  ],
  [
    #image("image9.png", width: 70%)
  ]
)
#v(1em)

*3. Verifica convenzionale a rottura duttile estrema 3D:* \
Seguendo la stessa procedura del punto precedente, si utilizza Von Mises ponendo di base $K_t = 1$ e lavorando in tensione nominale per verificare la sopravvivenza rispetto alla resistenza ultima:

$ sigma_("id", "nom") = sqrt((sigma_"nom"^b + sigma_"nom"^(t c))^2 + 3 tau_"nom"^2) < R_m $

=== L'Intaglio in Regime di Fatica Ciclica
<lintaglio-in-regime-di-fatica-ciclica>

A differenza del caso statico, sotto l'azione continua di carichi ciclici, la quantificazione dell'effetto deleterio dell'intaglio introduce una dipendenza fondamentale dal tipo di materiale impiegato. Si definisce il *fattore di intaglio a fatica* $K_f$, che dipende intrinsecamente dal coefficiente di sensibilità $q$.

*Fattore di Sensibilità all'Intaglio ($q$):* È un indice prestazionale specifico della lega metallica, funzionalmente legato al raggio geometrico al fondo dell'intaglio ($r$). Esso esprime "quanto" il materiale soffre la presenza di quello specifico difetto in regime ciclico. Analogamente alla finitura superficiale, la sensibilità all'intaglio $q$ cresce all'aumentare del carico di rottura $R_m$: materiali più resistenti sono più fragili e "sentono" maggiormente l'effetto dell'intaglio.

$ q = (K_f - 1) / (K_t - 1) quad "con campo di esistenza: " quad 0 <= q <= 1 $

L'analisi dei limiti operativi rivela:

- Se $q = 0 ==> K_f = 1$ (Il materiale è insensibile: ignora la presenza dell'intaglio in fatica).
- Se $q = 1 ==> K_f = K_t$ (Il materiale è totalmente sensibile: il danno è massimo e coincide con la concentrazione statica teorica).

Nella pratica progettuale, $q$ può essere calcolato tramite la relazione empirica di Neuber:

$ q = 1 / (1 + sqrt(rho / r)) $

dove $rho$ è una costante intrinseca specifica del materiale e $r$ è il raggio geometrico in millimetri alla radice del difetto. Risolvendo l'equazione della sensibilità si ottiene la relazione finale per il dimensionamento a durata infinita:

$ K_f = 1 + q (K_t - 1) $

_Nota importante:_ L'impiego del fattore riduttivo $K_f$ è rigorosamente valido unicamente per calcoli strutturali riferiti ad alti numeri di cicli (regime HCF e stime per vita a fatica infinita).

#grid(
  columns: (1fr, 1.5fr),
  column-gutter: 4em,
  align: (left + horizon, center + horizon),
  [
    *Applicazione di $K_f$ sul punto di lavoro $P (sigma_m, sigma_a)$:* \
    Nell'analisi a fatica, le tensioni nominali di esercizio (sia l'ampiezza alternata che la componente media statica) devono essere amplificate in presenza dell'intaglio prima di verificare la sicurezza:
    $ sigma_m = K_f dot sigma_(m, "nom") quad quad sigma_a = K_f dot sigma_(a, "nom") $
    Considerata l'estrema variabilità dei fenomeni micro-strutturali, la normativa generale raccomanda l'impiego di un Coefficiente di Sicurezza minimo a fatica mai inferiore a 3:
    $ "CS" = sigma_a^"lim" / sigma_a^P >= 3 $
  ],
  [
    // commenti: sistema fisico (Poligono di Sicurezza di Goodman con limite di fatica modificato/ridotto), elementi (assi, linee limiti di rottura, snervamento, fatica originale, nuova retta di fatica rossa orientata verso Rm, poligono area di sicurezza verde ridotto), relazioni (la retta rossa tronca il dominio intersecando le rette di snervamento e mira esattamente a Rm sull'asse orizzontale), elementi ignorati (niente)
#canvas(length: 1cm, {
  import draw: *

  // Area di sicurezza ridotta (Poligono verde sotto la linea rossa)
  // Calcolato su intersezione y = -0.4x + 2 (che passa per 0,2 e 5,0) con y = x + 4 e y = -x + 4
  line((-4, 0), (-1, 3), (0, 3),(2.5,1.5),(4,0), close: true, fill: rgb(220, 245, 220), stroke: none)

  // Assi
  line((-6, 0), (6, 0), mark: (end: ">"), stroke: 1pt)
  line((0, -2), (0, 6), mark: (end: ">"), stroke: 1pt)
  content((6, -0.4), text(blue)[$sigma_m$], anchor: "north")
  content((-0.4, 6), text(blue)[$sigma_a$], anchor: "east")

  // Linee di limite originali (Rottura statica R_m)
  line((-5, 0), (0, 5), stroke: 1pt)
  line((0, 5), (5, 0), stroke: 1pt)
  
  // Linee di limite originali (Snervamento R_eH)
  line((-4, 0), (0, 4), stroke: 1pt)
  line((0, 4), (4, 0), stroke: 1pt)

  // Linea di Fatica originale (Goodman)
  line((-4, 0), (-1, 3), stroke: 1pt)
  line((-1, 3), (0, 3), stroke: 1pt)
  line((0, 3), (5, 0), stroke: 1pt)

  // Etichette assi estremità
  content((-5, -0.4), text(blue)[$-R_m$], anchor: "north")
  content((-4.1, -0.4), text(blue)[$-R_"eH"$], anchor: "north")
  content((4.1, -0.4), text(blue)[$R_"eH"$], anchor: "north")
  content((5, -0.4), text(blue)[$R_m$], anchor: "north")
  
  content((-0.2, 2.8), text(blue)[$sigma_"D-1"$], anchor: "east")
  content((-0.2, 4), text(blue)[$R_"eH"$], anchor: "east")
  content((-0.2, 5), text(blue)[$R_m$], anchor: "east")

  // --- NUOVA CONDIZIONE LIMITE (Linea Rossa orientata verso R_m) ---
  // Tratto sovrapposto allo snervamento in compressione
  line((-4, 0), (-1.429, 2.571), stroke: (paint: red, thickness: 1.5pt))
  
  // Tratto limite di fatica modificato (punta dritto verso R_m a x=5)
  line((-1.429, 2.571), (3.333, 0.667), stroke: (paint: red, thickness: 1.5pt))
  
  // Tratto sovrapposto allo snervamento in trazione
  line((3.333, 0.667), (4, 0), stroke: (paint: red, thickness: 1.5pt))
  
  // Prolungamento tratteggiato che arriva esattamente a R_m (5, 0)
  line((3.333, 0.667), (5, 0), stroke: (paint: red, dash: "dashed", thickness: 1.2pt))

  // Punto e etichetta del nuovo limite a fatica
  circle((0, 2), radius: 0.07, fill: red, stroke: none)
  content((0.2, 2.1), text(red)[$sigma_"D-1"^C$], anchor: "west")

  // --- RIFERIMENTI E INTERVALLI ORIGINALI ---
  // Linee tratteggiate di proiezione verticali dai vecchi raccordi
  line((-1, 0), (-1, 3), stroke: (dash: "dashed", thickness: 0.6pt))
  line((2.5, 0), (2.5, 1.5), stroke: (dash: "dashed", thickness: 0.6pt))

  // Intervalli orizzontali a, b, c, d
  line((-4, -1.0), (-4, -1.4), stroke: 1pt)
  line((-1, -1.0), (-1, -1.4), stroke: 1pt)
  line((0, -1.0), (0, -1.4), stroke: 1pt)
  line((2.5, -1.0), (2.5, -1.4), stroke: 1pt) 
  line((4, -1.0), (4, -1.4), stroke: 1pt)

  line((-4, -1.2), (-1, -1.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((-2.5, -0.9), text(blue)[$a$])

  line((-1, -1.2), (0, -1.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((-0.5, -0.9), text(blue)[$b$])

  line((0, -1.2), (2.5, -1.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((1.25, -0.9), text(blue)[$c$])

  line((2.5, -1.2), (4, -1.2), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((3.25, -0.9), text(blue)[$d$])
})
  ]
)
#v(1em)



== Fatica Multiassiale: Gough e Pollard
<fatica-multiassiale-gough-e-pollard>

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    I primi modelli interpretativi per determinare l'effetto combinato dei carichi in presenza di sollecitazioni multiassiali semplici derivano dalle campagne di Gough e Pollard. Per i materiali duttili, i punti di rottura si distribuiscono secondo una curva ellittica:
    $ (sigma_a / sigma_(D-1))^2 + (tau_a / tau_(D-1))^2 <= 1 $
  ],
  [
    
#canvas(length: 0.8cm, {
  import draw: *
  
  // Assi
  line((0, 0), (7, 0), mark: (end: ">"), stroke: 1pt)
  line((0, 0), (0, 5), mark: (end: ">"), stroke: 1pt)
  
  // Curva (ellisse)
  arc((0, 0), start: 0deg, stop: 90deg, radius: (4.8, 2.8), anchor: "origin", stroke: 1pt)
  
  // Punti sperimentali
  circle((0.5, 2.5), radius: 0.03, fill: black, stroke: none)
  circle((0.8, 3.0), radius: 0.03, fill: black, stroke: none)
  circle((1.4, 2.5), radius: 0.03, fill: black, stroke: none)
  circle((2.2, 2.9), radius: 0.03, fill: black, stroke: none)
  circle((3.4, 1.7), radius: 0.03, fill: black, stroke: none)
  circle((3.8, 1.9), radius: 0.03, fill: black, stroke: none)
  circle((4.2, 0.8), radius: 0.03, fill: black, stroke: none)
  circle((4.7, 0.7), radius: 0.03, fill: black, stroke: none)
  
  // Etichette
  content((7.2, -0.3), [$sigma_a$], anchor: "north-west")
  content((-0.3, 4.8), [$tau_a$], anchor: "east")
})
// FASE 3 - VERIFICA
// 1. Curva: ellisse centrata in (0,0) con semiassi a=4.8, b=2.8.
//    L'arco a 0deg si trova a (4.8, 0), cadendo esattamente sull'asse x.
//    L'arco a 90deg si trova a (0, 2.8), cadendo esattamente sull'asse y.
// 2. Intersezioni: I punti estremi dell'arco si raccordano perfettamente agli assi.
// 3. Etichette e assi formattati correttamente con la sintassi math e coerenti con la disposizione originale.
// 4. Punti: le coordinate ricadono tutte nei dintorni della curva descritta dall'equazione (x/4.8)^2 + (y/2.8)^2 = 1, come nel disegno.
  ]
)

Ricordando che sperimentalmente il limite torsionale è circa il 60% di quello flessionale ($tau_(D-1) approx sigma_(D-1)/sqrt(3)$), sostituendo e moltiplicando si ottiene:
    $ sigma_a^2 + 3 tau_a^2 <= sigma_(D-1)^2 $
    Estraendo la radice, si giunge alla tensione alternata equivalente:
    $ sqrt(sigma_a^2 + 3 tau_a^2) <= sigma_(D-1) $
  
#v(1em)

== Tensione Equivalente
<tensione-equivalente>

Sulla base del criterio di Gough e Pollard e del criterio di Von Mises, definiamo le tensioni equivalenti per il ciclo di fatica:

$ sigma_(a, "eq") &= sqrt(sigma_a^2 + 3 tau_a^2) && quad " (Tensione alternata equivalente, valida se " sigma_a " è solo flessionale)" \
  sigma_(m, "eq") &= sqrt(sigma_m^2 + 3 tau_m^2) && quad " (Tensione media equivalente da Von Mises)" $

Se fosse presente anche una componente alternata di trazione ($sigma_a^(t c)$), è necessario omogeneizzarla rispetto al limite flessionale dividendo per il fattore di carico $C_L approx 0.85$. La componente tangenziale non viene corretta perché il coefficiente 3 assolve già a questa funzione:

$ sigma_(a, "eq") &= sqrt((sigma_a^b + sigma_a^(t c) / 0.85)^2 + 3 tau_a^2) \
  sigma_(m, "eq") &= sqrt((sigma_m^b + sigma_m^(t c))^2 + 3 tau_m^2) $ 

In presenza di intagli, applicando i rispettivi fattori $K_f$ alle singole componenti operative (come suggerito dalla normativa FKM), otteniamo:

$ sigma_(a, "eq")^"FKM" &= sqrt((K_f^b dot sigma_a^b + (K_f^(t c) dot sigma_a^(t c)) / 0.85)^2 + 3 (K_f^tau dot tau_a)^2) \
  sigma_(m, "eq")^"FKM" &= sqrt((K_f^b dot sigma_m^b + K_f^(t c) dot sigma_m^(t c))^2 + 3 (K_f^tau dot tau_m)^2) $

Con le coordinate $P (sigma_(m, "eq"), sigma_(a, "eq"))$ è possibile posizionare il punto di lavoro sul diagramma di Haigh. Si noti che nel diagramma di Haigh multiassiale non si disegnano più le rette a $45^circ$ per la verifica statica, poiché la tensione massima equivalente 

$ sigma_("eq", max) = sqrt((sigma_max^b + sigma_max^(t c))^2 + 3 tau_max^2) < R_(e H) $

non descrive più una retta a $45^circ$.

== Fatica multiassiale: criterio di Sines
<fatica-multiassiale-criterio-di-sines>

Il Criterio di Sines valuta l'influenza delle sole tensioni medie normali tramite l'invariante dello sforzo, postulando che la tensione media tangenziale sia ininfluente ai fini della fatica. La condizione di cedimento per sollecitazioni in fase si esprime in termini di tensioni principali:
$ 1 / sqrt(2) sqrt((sigma_(a 1) - sigma_(a 2))^2 + (sigma_(a 1) - sigma_(a 3))^2 + (sigma_(a 2) - sigma_(a 3))^2) + m (sigma_(m 1) + sigma_(m 2) + sigma_(m 3)) <= sigma_(D - 1) $
Per un caso di flesso-torsione con un'unica tensione normale media $sigma_m$, l'equazione si semplifica in:
$ sqrt(sigma_a^2 + 3 tau_a^2) + m dot sigma_m <= sigma_(D - 1) $

== Calcolo della durata
<calcolo-della-durata-1>

Per valutare il danneggiamento associato a diversi cicli, si definisce il danno specifico $D_i = n_i / N_i$ provocato da $n_i$ cicli di funzionamento con tensione alternata $sigma_(a i)$ e tensione media costante. Secondo la Legge di Palmgren-Miner, i danni sono cumulativi e la rottura avviene quando la somma eguaglia l'unità:
$ D = sum D_i = sum n_i / N_i = 1 $
Si noti che, per approssimazione ingegneristica, se $sigma_(a i) < sigma_D$ tali tensioni non vengono considerate nel calcolo del danno.

Spesso in fase di progettazione si esprime il numero di cicli $n_i$ in funzione della durata totale $N_"TOT"$ tramite un coefficiente percentuale $alpha_i$ (con $alpha_i < 1$):
$ n_i = alpha_i N_"TOT" $
Sostituendo nella legge di Miner, possiamo esplicitare la durata totale prevista:
$ sum (alpha_i N_"TOT") / N_i = 1 quad ==> quad N_"TOT" sum alpha_i / N_i = 1 quad ==> quad N_"TOT" = 1 / (sum alpha_i / N_i) $
Operando nel campo della fatica ad alto numero di cicli, l'equazione di Basquin regola la porzione inclinata della curva di Wöhler. Possiamo definire una costante $B = sigma_D^k dot N_G$ (dove $N_G$ è il numero di cicli al ginocchio). Per ogni livello di tensione vale:
$ sigma_(a i)^k N_i = B quad -> quad N_i = B / sigma_(a i)^k $
Sostituendo $N_i$ nell'equazione della durata totale, otteniamo:
$ N_"TOT" = B / (sum alpha_i sigma_(a i)^k) quad ==> quad N_"TOT" dot sum alpha_i sigma_(a i)^k = B $
Definendo una tensione alternata equivalente $sigma_(a "eq")$ tale che $sigma_(a "eq")^k dot N_"TOT" = B$, possiamo ricavare:
$ sigma_(a "eq") = root(k, sum alpha_i sigma_(a i)^k) quad "e conseguentemente" quad N_"TOT" = B / sigma_(a "eq")^k $
Nel caso generale in cui sia $sigma_m$ che $sigma_a$ siano variabili, la procedura normativa prevede:

+ Per ogni livello $i$, ricavare il limite di fatica corretto $sigma_(D i)$ dal diagramma di Haigh in funzione della specifica $sigma_(m i)$.
+ Per ogni $sigma_(m i)$, ricostruire una distinta curva di Wöhler calcolando le relative costanti $B$ e $k$.
+ Calcolare i cicli a rottura $N_i$ sulla rispettiva curva.
+ Applicare la sommatoria della legge di Miner.

=== Metodo di conteggio Rainflow
<metodo-di-conteggio-rainflow-2>

#grid(
  columns: (0.7fr, 1fr),
  column-gutter: 2em,
  align: (center + horizon, center + horizon),
  [
    Spettri di carico casuali richiedono il Metodo Rainflow ("versione del serbatoio"). La sua funzione è estrarre il numero esatto di semicicli e cicli completi ($Delta sigma$, $sigma_a$, $sigma_m$) da sequenze irregolari di valli e picchi. L'obiettivo è permettere l'applicazione della legge di Miner tramite l'isolamento dei salti di tensione secondo precise regole di "caduta dell'acqua" lungo il profilo del segnale ruotato.
  ],
  [
    // FASE 1 - ANALISI
// 1. PANNELLI E SCALA: Il disegno è un grafico singolo (storia di carico fatica con conteggio cicli). Scegliamo un fattore di scala canvas opportuno (length: 0.8cm) per evitare overflow in orizzontale.
//    L'asse y mappa direttamente il valore di tensione: y = valore / 50. Quindi y va da -4 (-200 MPa) a 6 (300 MPa).
//    L'asse x rappresenta il tempo t, suddiviso da linee di griglia verticali equispaziate. 
//    Ci sono 56 linee verticali (da indice 0 a 55). Impostiamo una distanza dx = 0.3 tra di esse. La larghezza totale della griglia sarà 55 * 0.3 = 16.5.
// 2. FIGURE IN PROSPETTIVA: Nessuna. È un grafico 2D.
// 3. ELEMENTI:
//    - Sfondo: grigio chiaro.
//    - Griglia orizzontale: 11 linee verdi a y intere da -4 a 6.
//    - Griglia verticale: 56 linee verdi equispaziate da x=0 a x=16.5.
//    - Segnale: una singola polilinea nera continua che unisce i picchi e le valli esatti misurati dalla griglia.
//    - Etichette asse sx: valori della tensione (300, 250, 200... fino a -200). Nota: il segno meno nei valori -100, -150, -200 risulta tagliato fuori dall'immagine originale, ma lo inseriamo per correttezza fisica.
//    - Etichette asse dx: valori di un istogramma o conteggio (1, 4, 9, 14, 21, 23, 21, 14, 9, 4, 1), simmetrici rispetto a 50 MPa.
//    - Testi: "$sigma$ (MPa)" in alto a sinistra, "$t$" in basso a destra.
// 4. CLASSIFICAZIONE DI OGNI CURVA:
//    - Il segnale è una sequenza di segmenti rettilinei, realizzabile con un'unica primitiva `line` passante per i 56 punti misurati. Nessun bezier necessario.

// FASE 2 - COSTRUZIONE
// Valori calcolati:
// Griglia orizzontale (11 linee): y in (-4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6)
// Griglia verticale (56 linee): x = i * 0.3, per i da 0 a 55.
// Coordinate del segnale (x=i*0.3, y=val/50):
// 0:300(6), 1:0(0), 2:200(4), 3:-50(-1), 4:100(2), 5:-100(-2), 6:50(1), 7:-50(-1), 8:100(2), 9:-150(-3),
// 10:50(1), 11:-100(-2), 12:100(2), 13:-50(-1), 14:0(0), 15:-150(-3), 16:50(1), 17:-50(-1), 18:200(4), 19:0(0),
// 20:100(2), 21:-100(-2), 22:50(1), 23:-100(-2), 24:100(2), 25:0(0), 26:-150(-3), 27:0(0), 28:-200(-4), 29:100(2),
// 30:-100(-2), 31:150(3), 32:0(0), 33:200(4), 34:50(1), 35:150(3), 36:100(2), 37:250(5), 38:50(1), 39:200(4),
// 40:-50(-1), 41:150(3), 42:-50(-1), 43:250(5), 44:0(0), 45:150(3), 46:-100(-2), 47:100(2), 48:0(0), 49:200(4),
// 50:50(1), 51:150(3), 52:0(0), 53:250(5), 54:100(2), 55:300(6).
#canvas(length: 0.6cm, {
  import draw: *
  
  // Sfondo grigio
  rect((-1.5, -4.5), (17.5, 6.5), fill: rgb("F3F3F3"), stroke: none)
  
  // Griglia orizzontale
  line((0, -4), (16.5, -4), stroke: 0.5pt + rgb("00FF00"))
  line((0, -3), (16.5, -3), stroke: 0.5pt + rgb("00FF00"))
  line((0, -2), (16.5, -2), stroke: 0.5pt + rgb("00FF00"))
  line((0, -1), (16.5, -1), stroke: 0.5pt + rgb("00FF00"))
  line((0, 0), (16.5, 0), stroke: 0.5pt + rgb("00FF00"))
  line((0, 1), (16.5, 1), stroke: 0.5pt + rgb("00FF00"))
  line((0, 2), (16.5, 2), stroke: 0.5pt + rgb("00FF00"))
  line((0, 3), (16.5, 3), stroke: 0.5pt + rgb("00FF00"))
  line((0, 4), (16.5, 4), stroke: 0.5pt + rgb("00FF00"))
  line((0, 5), (16.5, 5), stroke: 0.5pt + rgb("00FF00"))
  line((0, 6), (16.5, 6), stroke: 0.5pt + rgb("00FF00"))
  
  // Griglia verticale (scritta estesa per rispettare le regole)
  line((0.0, -4), (0.0, 6), stroke: 0.5pt + rgb("00FF00")); line((0.3, -4), (0.3, 6), stroke: 0.5pt + rgb("00FF00"))
  line((0.6, -4), (0.6, 6), stroke: 0.5pt + rgb("00FF00")); line((0.9, -4), (0.9, 6), stroke: 0.5pt + rgb("00FF00"))
  line((1.2, -4), (1.2, 6), stroke: 0.5pt + rgb("00FF00")); line((1.5, -4), (1.5, 6), stroke: 0.5pt + rgb("00FF00"))
  line((1.8, -4), (1.8, 6), stroke: 0.5pt + rgb("00FF00")); line((2.1, -4), (2.1, 6), stroke: 0.5pt + rgb("00FF00"))
  line((2.4, -4), (2.4, 6), stroke: 0.5pt + rgb("00FF00")); line((2.7, -4), (2.7, 6), stroke: 0.5pt + rgb("00FF00"))
  line((3.0, -4), (3.0, 6), stroke: 0.5pt + rgb("00FF00")); line((3.3, -4), (3.3, 6), stroke: 0.5pt + rgb("00FF00"))
  line((3.6, -4), (3.6, 6), stroke: 0.5pt + rgb("00FF00")); line((3.9, -4), (3.9, 6), stroke: 0.5pt + rgb("00FF00"))
  line((4.2, -4), (4.2, 6), stroke: 0.5pt + rgb("00FF00")); line((4.5, -4), (4.5, 6), stroke: 0.5pt + rgb("00FF00"))
  line((4.8, -4), (4.8, 6), stroke: 0.5pt + rgb("00FF00")); line((5.1, -4), (5.1, 6), stroke: 0.5pt + rgb("00FF00"))
  line((5.4, -4), (5.4, 6), stroke: 0.5pt + rgb("00FF00")); line((5.7, -4), (5.7, 6), stroke: 0.5pt + rgb("00FF00"))
  line((6.0, -4), (6.0, 6), stroke: 0.5pt + rgb("00FF00")); line((6.3, -4), (6.3, 6), stroke: 0.5pt + rgb("00FF00"))
  line((6.6, -4), (6.6, 6), stroke: 0.5pt + rgb("00FF00")); line((6.9, -4), (6.9, 6), stroke: 0.5pt + rgb("00FF00"))
  line((7.2, -4), (7.2, 6), stroke: 0.5pt + rgb("00FF00")); line((7.5, -4), (7.5, 6), stroke: 0.5pt + rgb("00FF00"))
  line((7.8, -4), (7.8, 6), stroke: 0.5pt + rgb("00FF00")); line((8.1, -4), (8.1, 6), stroke: 0.5pt + rgb("00FF00"))
  line((8.4, -4), (8.4, 6), stroke: 0.5pt + rgb("00FF00")); line((8.7, -4), (8.7, 6), stroke: 0.5pt + rgb("00FF00"))
  line((9.0, -4), (9.0, 6), stroke: 0.5pt + rgb("00FF00")); line((9.3, -4), (9.3, 6), stroke: 0.5pt + rgb("00FF00"))
  line((9.6, -4), (9.6, 6), stroke: 0.5pt + rgb("00FF00")); line((9.9, -4), (9.9, 6), stroke: 0.5pt + rgb("00FF00"))
  line((10.2, -4), (10.2, 6), stroke: 0.5pt + rgb("00FF00")); line((10.5, -4), (10.5, 6), stroke: 0.5pt + rgb("00FF00"))
  line((10.8, -4), (10.8, 6), stroke: 0.5pt + rgb("00FF00")); line((11.1, -4), (11.1, 6), stroke: 0.5pt + rgb("00FF00"))
  line((11.4, -4), (11.4, 6), stroke: 0.5pt + rgb("00FF00")); line((11.7, -4), (11.7, 6), stroke: 0.5pt + rgb("00FF00"))
  line((12.0, -4), (12.0, 6), stroke: 0.5pt + rgb("00FF00")); line((12.3, -4), (12.3, 6), stroke: 0.5pt + rgb("00FF00"))
  line((12.6, -4), (12.6, 6), stroke: 0.5pt + rgb("00FF00")); line((12.9, -4), (12.9, 6), stroke: 0.5pt + rgb("00FF00"))
  line((13.2, -4), (13.2, 6), stroke: 0.5pt + rgb("00FF00")); line((13.5, -4), (13.5, 6), stroke: 0.5pt + rgb("00FF00"))
  line((13.8, -4), (13.8, 6), stroke: 0.5pt + rgb("00FF00")); line((14.1, -4), (14.1, 6), stroke: 0.5pt + rgb("00FF00"))
  line((14.4, -4), (14.4, 6), stroke: 0.5pt + rgb("00FF00")); line((14.7, -4), (14.7, 6), stroke: 0.5pt + rgb("00FF00"))
  line((15.0, -4), (15.0, 6), stroke: 0.5pt + rgb("00FF00")); line((15.3, -4), (15.3, 6), stroke: 0.5pt + rgb("00FF00"))
  line((15.6, -4), (15.6, 6), stroke: 0.5pt + rgb("00FF00")); line((15.9, -4), (15.9, 6), stroke: 0.5pt + rgb("00FF00"))
  line((16.2, -4), (16.2, 6), stroke: 0.5pt + rgb("00FF00")); line((16.5, -4), (16.5, 6), stroke: 0.5pt + rgb("00FF00"))
  
  // Segnale di carico
  line((0.0,6), (0.3,0), (0.6,4), (0.9,-1), (1.2,2), (1.5,-2), (1.8,1), (2.1,-1), (2.4,2), (2.7,-3), (3.0,1), (3.3,-2), (3.6,2), (3.9,-1), (4.2,0), (4.5,-3), (4.8,1), (5.1,-1), (5.4,4), (5.7,0), (6.0,2), (6.3,-2), (6.6,1), (6.9,-2), (7.2,2), (7.5,0), (7.8,-3), (8.1,0), (8.4,-4), (8.7,2), (9.0,-2), (9.3,3), (9.6,0), (9.9,4), (10.2,1), (10.5,3), (10.8,2), (11.1,5), (11.4,1), (11.7,4), (12.0,-1), (12.3,3), (12.6,-1), (12.9,5), (13.2,0), (13.5,3), (13.8,-2), (14.1,2), (14.4,0), (14.7,4), (15.0,1), (15.3,3), (15.6,0), (15.9,5), (16.2,2), (16.5,6), stroke: 1.5pt)
  
  // Testi interni
  content((0.4, 5.5), [$sigma$ (MPa)], anchor: "west")
  content((15.5, -3.5), [$t$], anchor: "east")
  
  // Etichette asse sinistro
  content((-0.2, 6), [300], anchor: "east")
  content((-0.2, 5), [250], anchor: "east")
  content((-0.2, 4), [200], anchor: "east")
  content((-0.2, 3), [150], anchor: "east")
  content((-0.2, 2), [100], anchor: "east")
  content((-0.2, 1), [50], anchor: "east")
  content((-0.2, 0), [0], anchor: "east")
  content((-0.2, -1), [-50], anchor: "east")
  content((-0.2, -2), [-100], anchor: "east")
  content((-0.2, -3), [-150], anchor: "east")
  content((-0.2, -4), [-200], anchor: "east")
  
  // Etichette asse destro
  content((16.7, 6), [1], anchor: "west")
  content((16.7, 5), [4], anchor: "west")
  content((16.7, 4), [9], anchor: "west")
  content((16.7, 3), [14], anchor: "west")
  content((16.7, 2), [21], anchor: "west")
  content((16.7, 1), [23], anchor: "west")
  content((16.7, 0), [21], anchor: "west")
  content((16.7, -1), [14], anchor: "west")
  content((16.7, -2), [9], anchor: "west")
  content((16.7, -3), [4], anchor: "west")
  content((16.7, -4), [1], anchor: "west")
})
// FASE 3 - VERIFICA
// 1. Griglia: Le linee orizzontali e verticali sono scritte riga per riga per ottemperare al divieto di loop. Le intersezioni mappano fedelmente la griglia del disegno originale.
// 2. Segnale: Un'unica linea spezzata composta da 56 punti, inizia in (0,6) (equivalente a 300 MPa) e termina in (16.5,6) (equivalente a 300 MPa). 
//    Punto di minimo calcolato e controllato: (8.4, -4) corrispondente a -200 MPa al centro del grafico.
// 3. Etichette: Le etichette di destra descrivono una distribuzione simmetrica centrata su y=1 (50 MPa), perfettamente coerente all'originale. Sulla sinistra i valori -100, -150 e -200 hanno il segno meno esplicito come richiesto dal significato fisico (benché marginalmente tagliati nel crop).
// 4. Stile e colori: Rispetto dei tratti, sfondi, assenza di costrutti Typst vietati. Nessuna primitiva bezier necessaria, tutte linee rette esatte.
  ]
)
#v(1em)
