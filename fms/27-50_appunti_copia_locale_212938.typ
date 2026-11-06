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



// === Blocco_01_Slide_01-13 ===

= Legge tensione-deformazione unitarie

Per la maggior parte dei materiali strutturali, nel regime dei piccoli allungamenti si riscontra sperimentalmente una proporzionalità diretta tra la tensione unitaria e la deformazione unitaria. Tale relazione costitutiva prende il nome di *legge di Hooke*:

$ sigma_(x x) = E epsilon_(x x) $

Il coefficiente di proporzionalità $E$ è denominato *modulo di elasticità normale* (o *modulo di Young*). Esso rappresenta una costante fisica intrinseca del materiale, determinata per via sperimentale; poiché la deformazione unitaria $epsilon_(x x)$ è una grandezza adimensionale, il modulo $E$ possiede le medesime dimensioni fisiche della tensione unitaria ($"N"/"mm"^2 = "MPa"$).

Sostituendo all'interno della legge di Hooke le definizioni di tensione normale $sigma_(x x) = P / A$ e di deformazione longitudinale $epsilon_(x x) = (Delta l) / l$, si ottiene la relazione che lega direttamente la forza assiale applicata $P$ alla variazione di lunghezza della trave:

$ sigma_(x x) = E epsilon_(x x) quad arrow.r.double quad frac(P, A) = E frac(Delta l, l) $

Da tale espressione è possibile esplicitare sia la forza assiale $P$ in funzione dell'allungamento assoluto $Delta l$, sia l'allungamento stesso in funzione del carico:

$ P = frac(E A, l) Delta l , quad Delta l = frac(P l, E A) $

#nota[
Si definisce *rigidezza assiale* della trave il rapporto $frac(E A, l)$, il quale esprime la resistenza offerta dall'elemento strutturale alla deformazione assiale.
]

== Contrazione trasversale e coefficiente di Poisson

L'evidenza sperimentale mostra che, contemporaneamente all'allungamento longitudinale $Delta l$ indotto da uno stato di trazione monoassiale, il materiale subisce una contrazione trasversale $Delta a$ direttamente proporzionale all'allungamento stesso.

#canvas(length: 1cm, {
  import draw: *
  // Rettangolo deformato (tratteggiato)
  rect((0.8, 2.05), (7.2, 3.55), stroke: (dash: "dashed", thickness: 0.8pt))
  // Rettangolo indeformato (continuo)
  rect((1.4, 1.8), (6.6, 3.8), stroke: 1.2pt)

  // Frecce tensione sigma_xx a sinistra
  line((1.4, 3.8), (0.5, 3.8), mark: (end: ">"), stroke: 0.7pt)
  line((1.4, 3.47), (0.5, 3.47), mark: (end: ">"), stroke: 0.7pt)
  line((1.4, 3.13), (0.5, 3.13), mark: (end: ">"), stroke: 0.7pt)
  line((1.4, 2.8), (0.5, 2.8), mark: (end: ">"), stroke: 0.7pt)
  line((1.4, 2.47), (0.5, 2.47), mark: (end: ">"), stroke: 0.7pt)
  line((1.4, 2.13), (0.5, 2.13), mark: (end: ">"), stroke: 0.7pt)
  line((1.4, 1.8), (0.5, 1.8), mark: (end: ">"), stroke: 0.7pt)
  content((0.6, 4.15), text(size: 7pt)[$sigma_(x x)$])

  // Frecce tensione sigma_xx a destra
  line((6.6, 3.8), (7.5, 3.8), mark: (end: ">"), stroke: 0.7pt)
  line((6.6, 3.47), (7.5, 3.47), mark: (end: ">"), stroke: 0.7pt)
  line((6.6, 3.13), (7.5, 3.13), mark: (end: ">"), stroke: 0.7pt)
  line((6.6, 2.8), (7.5, 2.8), mark: (end: ">"), stroke: 0.7pt)
  line((6.6, 2.47), (7.5, 2.47), mark: (end: ">"), stroke: 0.7pt)
  line((6.6, 2.13), (7.5, 2.13), mark: (end: ">"), stroke: 0.7pt)
  line((6.6, 1.8), (7.5, 1.8), mark: (end: ">"), stroke: 0.7pt)
  content((7.4, 4.15), text(size: 7pt)[$sigma_(x x)$])

  // Quote verticali interne (a e a - Delta a)
  line((3.5, 1.8), (3.5, 3.8), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((3.35, 2.8), text(size: 7pt)[$a$], anchor: "east")

  line((4.7, 2.05), (4.7, 3.55), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((4.55, 2.8), text(size: 7pt)[$a - Delta a$], anchor: "east")

  // Linee di estensione e quote orizzontali (l e l + Delta l)
  line((1.4, 1.8), (1.4, 0.8), stroke: 0.5pt)
  line((6.6, 1.8), (6.6, 0.8), stroke: 0.5pt)
  line((1.4, 1.0), (6.6, 1.0), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((4.0, 1.2), text(size: 7pt)[$l$], anchor: "south")

  line((0.8, 2.05), (0.8, 0.1), stroke: 0.5pt)
  line((7.2, 2.05), (7.2, 0.1), stroke: 0.5pt)
  line((0.8, 0.3), (7.2, 0.3), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((4.0, 0.5), text(size: 7pt)[$l + Delta l$], anchor: "south")
})

La corrispondente deformazione unitaria trasversale $epsilon_(y y)$ è legata alla deformazione longitudinale $epsilon_(x x)$ dalla relazione:

$ epsilon_(y y) = - frac(Delta a, a) = - nu frac(Delta l, l) = - nu epsilon_(x x) = - nu frac(sigma_(x x), E) $

Il coefficiente di proporzionalità adimensionale $nu$ prende il nome di *coefficiente di Poisson*; esso viene determinato sperimentalmente e, per la maggior parte dei materiali metallici, assume valori compresi nell'intervallo $0.25 <= nu <= 0.35$.

= Lavoro di deformazione

Si supponga che la forza esterna $P$, che sollecita a trazione la trave, cresca dal valore nullo iniziale fino al valore finale in modo sufficientemente lento da non innescare azioni dinamiche, realizzando così un *processo di carico statico*.

#canvas(length: 1.3cm, {
  import draw: *
  // PANNELLO 1: Trave soggetta a trazione
  rect((0.8, 2.0), (3.3, 2.4), stroke: 1.1pt)
  line((3.3, 2.4), (3.8, 2.4), stroke: (dash: "dashed", thickness: 0.9pt))
  line((3.8, 2.4), (3.8, 2.0), stroke: (dash: "dashed", thickness: 0.9pt))
  line((3.8, 2.0), (3.3, 2.0), stroke: (dash: "dashed", thickness: 0.9pt))
  // Asse baricentrico e asse x
  line((0.5, 2.2), (4.0, 2.2), stroke: (dash: "dash-dotted", thickness: 0.6pt))
  line((4.7, 2.2), (5.4, 2.2), mark: (end: ">"), stroke: 0.7pt)
  content((5.3, 1.9), text(size: 7pt)[$x$])
  // Forze P
  line((0.8, 2.2), (0.1, 2.2), mark: (end: ">"), stroke: 1.1pt)
  content((0.2, 2.55), text(size: 7pt)[$P$])
  line((3.9, 2.2), (4.6, 2.2), mark: (end: ">"), stroke: 1.1pt)
  content((3.9, 2.55), text(size: 7pt)[$P$])

  // PANNELLO 2: Diagramma P - Delta l
  // Area elementare tratteggiata
  line((7.6, 0.8), (7.6, 2.2), (7.9, 2.45), (7.9, 0.8), close: true, fill: luma(220), stroke: 0.6pt)
  line((7.6, 1.0), (7.9, 1.25), stroke: 0.5pt)
  line((7.6, 1.3), (7.9, 1.55), stroke: 0.5pt)
  line((7.6, 1.6), (7.9, 1.85), stroke: 0.5pt)
  line((7.6, 1.9), (7.9, 2.15), stroke: 0.5pt)

  // Assi cartesiani
  line((6.2, 0.2), (6.2, 4.3), mark: (end: ">"), stroke: 0.8pt)
  line((6.2, 0.8), (10.2, 0.8), mark: (end: ">"), stroke: 0.8pt)
  content((5.9, 4.2), text(size: 7pt)[$P$])
  content((10.1, 0.5), text(size: 7pt)[$Delta l$])
  content((5.95, 0.55), text(size: 7pt)[$O$])

  // Retta di carico OC
  line((6.2, 0.8), (9.5, 3.89), stroke: 1.2pt)

  // Proiezioni punto C e generico P
  line((6.1, 3.52), (9.1, 3.52), stroke: 0.6pt)
  line((9.1, 3.52), (9.1, 0.2), stroke: 0.6pt)
  content((5.9, 3.52), text(size: 7pt)[$P$])
  content((9.35, 3.52), text(size: 7pt)[$C$])
  content((9.3, 1.05), text(size: 7pt)[$B$])

  line((6.1, 2.32), (7.75, 2.32), stroke: 0.6pt)
  content((5.9, 2.32), text(size: 7pt)[$P$])

  // Quote d(Delta l) e Delta l
  line((7.6, 0.8), (7.6, 0.35), stroke: 0.5pt)
  line((7.9, 0.8), (7.9, 0.35), stroke: 0.5pt)
  line((7.2, 0.45), (7.6, 0.45), mark: (end: ">"), stroke: 0.6pt)
  line((8.3, 0.45), (7.9, 0.45), mark: (end: ">"), stroke: 0.6pt)
  line((7.6, 0.45), (7.9, 0.45), stroke: 0.6pt)
  content((8.45, 0.58), text(size: 7pt)[$d(Delta l)$])

  line((6.2, 0.25), (9.1, 0.25), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((7.65, 0.0), text(size: 7pt)[$Delta l$])
})

Il lavoro elementare $d L$ compiuto dalla forza $P$ per uno spostamento infinitesimo $d(Delta l)$ vale:

$ d L = P d(Delta l) $

Integrando tale contributo lungo l'intero processo di carico, il lavoro complessivo $L$ corrispondente allo spostamento finale $Delta l$ coincide geometricamente con l'area del triangolo $O B C$ sotteso dalla retta di carico:

$ L = frac(1, 2) P Delta l $

Sostituendo le relazioni costitutive della rigidezza assiale ricavate in precedenza, il lavoro di deformazione può essere espresso alternativamente in funzione del solo allungamento o della sola forza applicata:

$ L = frac(1, 2) P Delta l = frac(1, 2) frac(E A, l) Delta l^2 = frac(1, 2) frac(P^2 l, E A) $

Indicando con $V = A l$ il volume complessivo della trave e ricordando che $sigma_(x x) = P / A$ e $sigma_(x x) = E epsilon_(x x)$, il lavoro di deformazione si esprime in funzione dello stato tensionale e deformativo come:

$ L = frac(1, 2) sigma_(x x) epsilon_(x x) V = frac(1, 2) frac(sigma_(x x)^2, E) V = frac(1, 2) epsilon_(x x)^2 E V $

Dividendo per il volume $V$, si ottiene il corrispondente *lavoro di deformazione per unità di volume* (o densità di energia di deformazione elastica) $L_V$:

$ L_V = frac(1, 2) sigma_(x x) epsilon_(x x) = frac(1, 2) frac(sigma_(x x)^2, E) = frac(1, 2) epsilon_(x x)^2 E $

= Deformazioni termiche assiali

Finora si è assunto che i sistemi strutturali soggetti a carichi meccanici permanessero a una temperatura ambiente $T_"amb"$ costante. Se tuttavia una trave libera (non vincolata) è immersa in un campo termico uniforme caratterizzato da una variazione di temperatura $Delta T$ rispetto a $T_"amb"$, essa subisce una variazione di lunghezza $Delta l_T$ direttamente proporzionale al salto termico $Delta T$ e alla lunghezza iniziale $l$:

$ Delta l_T = alpha l Delta T $

Il parametro $alpha$ è denominato *coefficiente di dilatazione termica lineare*; esso costituisce una proprietà fisica caratteristica del materiale, ha dimensioni $[circ"C"^(-1)]$ e assume i valori tipici riportati nella tabella seguente.

#table(
  columns: 2,
  align: (left, right),
  table.header([*Materiale*], [*$alpha$ $[circ"C"^(-1)]$*]),
  table.hline(),
  [Acciai], [$11.7 dot 10^(-6)$],
  [Leghe di Alluminio], [$23.5 dot 10^(-6)$],
  [Leghe di Titanio], [$9.0 dot 10^(-6)$],
  [Leghe di Rame], [$16.9 dot 10^(-6)$],
  [Poliestere], [$166 dot 10^(-6)$],
)

Dividendo l'allungamento termico per la lunghezza iniziale $l$, si definisce la *deformazione unitaria termica*:

$ epsilon_T = alpha Delta T $

Qualora una barra sollecitata a trazione sia contemporaneamente soggetta a un incremento uniforme di temperatura $Delta T$ rispetto alla temperatura di montaggio, la deformazione termica si sovrappone linearmente alla deformazione meccanica $epsilon_"mec"$ prodotta dal carico assiale. La deformazione unitaria complessiva $epsilon$ e l'allungamento totale $Delta l$ valgono pertanto:

$ epsilon = epsilon_"mec" + epsilon_T = frac(sigma, E) + alpha Delta T $

$ Delta l = Delta l_"mec" + Delta l_T = frac(P l, E A) + alpha l Delta T $

= Comportamento meccanico dei materiali metallici

I materiali metallici impiegati nelle costruzioni meccaniche presentano due proprietà strutturali fondamentali:
- *Omogeneità*: il materiale possiede le medesime proprietà fisiche e meccaniche in tutti i suoi punti.
- *Isotropia*: il materiale presenta le stesse proprietà meccaniche lungo tutte le direzioni dello spazio.

Tra le famiglie di materiali metallici di più frequente impiego nella progettazione industriale di sistemi meccanici figurano:
- Acciai e ghise (leghe Ferro-Carbonio);
- Leghe di alluminio;
- Leghe di titanio;
- Leghe rame-stagno (bronzi);
- Leghe di magnesio.

Il comportamento tensionale-deformativo a trazione di diverse leghe metalliche di interesse ingegneristico è illustrato nel diagramma comparativo seguente.

#canvas(length: 1cm, {
  import draw: *
  // Assi e riquadro del grafico (x: 0..8 -> eps 0..0.24, y: 0..5.4 -> sigma 0..1800)
  rect((1.0, 0.6), (9.0, 6.0), stroke: 0.8pt)

  // Tacche asse x (Deformazione)
  line((2.33, 0.6), (2.33, 0.72), stroke: 0.6pt)
  line((3.67, 0.6), (3.67, 0.72), stroke: 0.6pt)
  line((5.0, 0.6), (5.0, 0.72), stroke: 0.6pt)
  line((6.33, 0.6), (6.33, 0.72), stroke: 0.6pt)
  line((7.67, 0.6), (7.67, 0.72), stroke: 0.6pt)
  content((1.0, 0.35), text(size: 7pt)[$0$])
  content((2.33, 0.35), text(size: 7pt)[$0.04$])
  content((3.67, 0.35), text(size: 7pt)[$0.08$])
  content((5.0, 0.35), text(size: 7pt)[$0.12$])
  content((6.33, 0.35), text(size: 7pt)[$0.16$])
  content((7.67, 0.35), text(size: 7pt)[$0.20$])
  content((9.0, 0.35), text(size: 7pt)[$0.24$])
  content((5.0, 0.0), text(size: 7pt)[$"Deformazione" epsilon, "mm"/"mm"$])

  // Tacche asse y (Sforzo MPa)
  line((1.0, 1.2), (1.12, 1.2), stroke: 0.6pt)
  line((1.0, 1.8), (1.12, 1.8), stroke: 0.6pt)
  line((1.0, 2.4), (1.12, 2.4), stroke: 0.6pt)
  line((1.0, 3.0), (1.12, 3.0), stroke: 0.6pt)
  line((1.0, 3.6), (1.12, 3.6), stroke: 0.6pt)
  line((1.0, 4.2), (1.12, 4.2), stroke: 0.6pt)
  line((1.0, 4.8), (1.12, 4.8), stroke: 0.6pt)
  line((1.0, 5.4), (1.12, 5.4), stroke: 0.6pt)
  content((0.9, 0.6), text(size: 7pt)[$0$], anchor: "east")
  content((0.9, 1.2), text(size: 7pt)[$200$], anchor: "east")
  content((0.9, 1.8), text(size: 7pt)[$400$], anchor: "east")
  content((0.9, 2.4), text(size: 7pt)[$600$], anchor: "east")
  content((0.9, 3.0), text(size: 7pt)[$800$], anchor: "east")
  content((0.9, 3.6), text(size: 7pt)[$1000$], anchor: "east")
  content((0.9, 4.2), text(size: 7pt)[$1200$], anchor: "east")
  content((0.9, 4.8), text(size: 7pt)[$1400$], anchor: "east")
  content((0.9, 5.4), text(size: 7pt)[$1600$], anchor: "east")
  content((0.9, 6.0), text(size: 7pt)[$1800$], anchor: "east")
  content((0.3, 6.25), text(size: 7pt)[$"Sforzo, MPa"$], anchor: "west")

  // 1. Acciaio SAE 1340 temprato e rinvenuto a 370 °C
  line((1.0, 0.6), (1.2, 5.1), stroke: 1.1pt)
  bezier((1.2, 5.1), (6.0, 5.3), (1.4, 5.55), (4.0, 5.45), stroke: 1.1pt)
  content((6.1, 5.3), text(size: 7pt)[Acciaio SAE 1340 temprato e rinvenuto a $370 circ"C"$], anchor: "west")

  // 2. Acciaio legato al nichel (alta resistenza)
  line((1.0, 0.6), (1.3, 3.6), stroke: 0.6pt)
  bezier((1.3, 3.6), (3.1, 4.8), (2.2, 5.8), (2.7, 5.5), stroke: 0.6pt)
  content((3.0, 5.1), text(size: 7pt)[Acciaio legato al nichel], anchor: "west")

  // 3. Acciaio inossidabile 17-7PH
  line((1.0, 0.6), (1.3, 4.6), stroke: 0.8pt)
  bezier((1.3, 4.6), (2.7, 4.2), (1.6, 4.95), (2.3, 4.7), stroke: 0.8pt)
  line((2.7, 4.2), (3.7, 2.7), stroke: (dash: "dashed", thickness: 0.8pt))
  content((2.7, 4.45), text(size: 7pt)[Acciaio inossidabile 17-7PH], anchor: "west")

  // 4. Acciaio inossidabile (18-8)
  line((1.0, 0.6), (1.3, 3.0), stroke: 1.1pt)
  bezier((1.3, 3.0), (5.0, 3.7), (2.5, 4.5), (4.0, 4.4), stroke: 1.1pt)
  content((4.5, 4.15), text(size: 7pt)[Acciaio inossidabile (18-8)], anchor: "west")

  // 5. Lega di titanio solubilizzato (Ti-6Al-4V)
  line((1.0, 0.6), (1.4, 3.1), stroke: 0.8pt)
  bezier((1.4, 3.1), (4.5, 3.1), (2.2, 3.65), (3.8, 3.65), stroke: 0.8pt)
  line((4.5, 3.1), (5.0, 1.9), stroke: (dash: "dashed", thickness: 0.8pt))
  content((5.1, 3.7), text(size: 7pt)[Lega di titanio solubilizzato (Ti-6Al-4V)], anchor: "west")
  line((5.05, 3.65), (4.4, 3.3), mark: (end: ">"), stroke: 0.5pt)

  // 6. Acciaio legato al nichel (media resistenza)
  line((1.0, 0.6), (1.25, 2.4), stroke: 0.6pt)
  bezier((1.25, 2.4), (5.5, 2.6), (2.8, 3.2), (4.2, 3.1), stroke: 0.6pt)
  content((5.0, 3.3), text(size: 7pt)[Acciaio legato al nichel], anchor: "west")
  line((4.95, 3.25), (4.3, 2.95), mark: (end: ">"), stroke: 0.5pt)

  // 7. Lega N-155 solubilizzata
  line((1.0, 0.6), (1.3, 2.1), stroke: 1.1pt)
  bezier((1.3, 2.1), (8.4, 2.75), (2.5, 3.05), (5.5, 3.0), stroke: 1.1pt)
  content((6.0, 3.0), text(size: 7pt)[Lega N-155 solubilizzata], anchor: "west")

  // 8. Lega di alluminio (2024-T81)
  line((1.0, 0.6), (1.25, 1.8), stroke: 0.7pt)
  bezier((1.25, 1.8), (3.0, 1.8), (1.6, 2.15), (2.4, 2.0), stroke: 0.7pt)
  line((3.0, 1.8), (3.5, 1.55), stroke: (dash: "dashed", thickness: 0.7pt))
  content((5.1, 2.45), text(size: 7pt)[Lega di alluminio (2024-T81)], anchor: "west")
  line((5.05, 2.45), (2.6, 1.95), mark: (end: ">"), stroke: 0.5pt)

  // 9. Alcoa 27ST
  line((1.0, 0.6), (1.2, 1.65), stroke: 0.8pt)
  bezier((1.2, 1.65), (4.8, 1.88), (2.2, 1.65), (3.5, 1.88), stroke: 0.8pt)
  content((3.6, 2.02), text(size: 7pt)[Alcoa 27ST], anchor: "west")

  // 10. Acciaio strutturale
  line((1.0, 0.6), (1.15, 1.38), stroke: 1.1pt)
  bezier((1.15, 1.38), (8.5, 1.36), (3.5, 1.68), (6.0, 1.55), stroke: 1.1pt)
  content((7.1, 1.6), text(size: 7pt)[Acciaio strutturale], anchor: "west")

  // 11. Magnesio
  line((1.0, 0.6), (1.15, 1.0), stroke: 0.6pt)
  bezier((1.15, 1.0), (4.7, 1.18), (2.3, 1.35), (3.6, 1.32), stroke: 0.6pt)
  content((4.75, 1.15), text(size: 7pt)[Magnesio], anchor: "west")
})

== Classificazione e proprietà degli acciai

L'*acciaio* è una lega binaria Ferro-Carbonio (Fe-C) caratterizzata da un tenore massico di carbonio inferiore al $2\%$ (più precisamente $C < 2.1\%$, oltre il quale si entra nel campo delle ghise). Gli acciai vengono classificati principalmente in funzione della percentuale di carbonio e della destinazione d'impiego. Sulla base del tenore di carbonio si distinguono:
- *Acciai dolci*: $0.15\% < C < 0.25\%$;
- *Acciai semiduri*: $0.25\% < C < 0.50\%$;
- *Acciai duri*: $0.50\% < C < 0.75\%$.

#canvas(length: 1cm, {
  import draw: *
  // Radice: Leghe Ferrose
  content((5.2, 5.5), text(size: 7pt)[*Leghe Ferrose*])
  line((5.2, 5.3), (5.2, 4.7), stroke: (paint: blue, thickness: 1.8pt))

  // Diramazione principale Acciai vs Ghise
  line((3.0, 4.7), (5.2, 4.7), stroke: (paint: red, thickness: 1.5pt))
  line((3.0, 4.7), (3.0, 4.2), stroke: (paint: red, thickness: 1.5pt))
  content((4.1, 4.95), text(size: 7pt)[$C < 2.1\%$])
  content((3.0, 3.95), text(size: 7pt)[*Acciai*])

  line((5.2, 4.7), (7.5, 4.7), stroke: (paint: rgb(0, 150, 60), thickness: 1.5pt))
  line((7.5, 4.7), (7.5, 4.2), stroke: (paint: rgb(0, 150, 60), thickness: 1.5pt))
  content((6.35, 4.95), text(size: 7pt)[$2.1\% < C < 4.6\%$])
  content((7.5, 3.95), text(size: 7pt)[*Ghise*])

  // Sotto-albero Ghise
  line((7.5, 3.75), (7.5, 3.3), stroke: (paint: rgb(0, 150, 60), thickness: 1.5pt))
  line((5.7, 3.3), (9.3, 3.3), stroke: (paint: rgb(0, 150, 60), thickness: 1.5pt))
  line((5.7, 3.3), (5.7, 2.8), stroke: (paint: rgb(0, 150, 60), thickness: 1.5pt))
  line((6.8, 3.3), (6.8, 2.8), stroke: (paint: rgb(0, 150, 60), thickness: 1.5pt))
  line((8.0, 3.3), (8.0, 2.8), stroke: (paint: rgb(0, 150, 60), thickness: 1.5pt))
  line((9.3, 3.3), (9.3, 2.8), stroke: (paint: rgb(0, 150, 60), thickness: 1.5pt))
  content((5.7, 2.55), text(size: 7pt)[Grigie])
  content((6.8, 2.55), text(size: 7pt)[Sferoidali])
  content((8.0, 2.55), text(size: 7pt)[Bianche])
  content((9.3, 2.55), text(size: 7pt)[Malleabili])

  // Sotto-albero Acciai: Basso-legati e Alto-legati
  line((3.0, 3.75), (3.0, 3.3), stroke: (paint: red, thickness: 1.5pt))
  line((1.8, 3.3), (4.8, 3.3), stroke: (paint: red, thickness: 1.5pt))
  line((1.8, 3.3), (1.8, 2.85), stroke: (paint: red, thickness: 1.5pt))
  line((4.8, 3.3), (4.8, 1.95), stroke: (paint: red, thickness: 1.5pt))
  content((1.8, 2.6), text(size: 7pt)[*Basso-legati*])
  content((4.8, 1.7), text(size: 7pt)[*Alto-legati*])

  // Diramazioni Basso-legati (Basso, Medio, Alto carbonio)
  line((1.8, 2.4), (1.8, 2.0), stroke: (paint: red, thickness: 1.5pt))
  line((0.5, 2.0), (3.6, 2.0), stroke: (paint: red, thickness: 1.5pt))
  line((0.5, 2.0), (0.5, 1.55), stroke: (paint: red, thickness: 1.5pt))
  line((2.0, 2.0), (2.0, 1.55), stroke: (paint: red, thickness: 1.5pt))
  line((3.6, 2.0), (3.6, 1.55), stroke: (paint: red, thickness: 1.5pt))
  content((0.5, 1.3), text(size: 7pt)[Basso carbonio])
  content((2.0, 1.3), text(size: 7pt)[Medio carbonio])
  content((3.6, 1.3), text(size: 7pt)[Alto carbonio])

  // Foglie Basso carbonio
  line((0.5, 1.1), (0.5, 0.75), stroke: (paint: red, thickness: 1.5pt))
  line((0.0, 0.75), (1.1, 0.75), stroke: (paint: red, thickness: 1.5pt))
  line((0.0, 0.75), (0.0, 0.4), stroke: (paint: red, thickness: 1.5pt))
  line((1.1, 0.75), (1.1, 0.4), stroke: (paint: red, thickness: 1.5pt))
  content((0.0, 0.1), text(size: 7pt)[Comuni al\ carbonio])
  content((1.1, 0.1), text(size: 7pt)[Basso-legati,\ alta resistenza])

  // Foglie Medio carbonio
  line((2.0, 1.1), (2.0, 0.75), stroke: (paint: red, thickness: 1.5pt))
  line((1.85, 0.75), (2.8, 0.75), stroke: (paint: red, thickness: 1.5pt))
  line((1.85, 0.75), (1.85, 0.4), stroke: (paint: red, thickness: 1.5pt))
  line((2.8, 0.75), (2.8, 0.4), stroke: (paint: red, thickness: 1.5pt))
  content((2.0, 0.1), text(size: 7pt)[Comuni al\ carbonio])
  content((2.85, 0.1), text(size: 7pt)[Trattabili\ a caldo])

  // Foglie Alto carbonio e Alto-legati
  line((3.6, 1.1), (3.6, 0.75), stroke: (paint: red, thickness: 1.5pt))
  line((3.5, 0.75), (4.4, 0.75), stroke: (paint: red, thickness: 1.5pt))
  line((3.5, 0.75), (3.5, 0.4), stroke: (paint: red, thickness: 1.5pt))
  line((4.4, 0.75), (4.4, 0.4), stroke: (paint: red, thickness: 1.5pt))

  line((4.8, 1.5), (4.8, 0.75), stroke: (paint: red, thickness: 1.5pt))
  line((4.55, 0.75), (5.4, 0.75), stroke: (paint: red, thickness: 1.5pt))
  line((4.55, 0.75), (4.55, 0.4), stroke: (paint: red, thickness: 1.5pt))
  line((5.4, 0.75), (5.4, 0.4), stroke: (paint: red, thickness: 1.5pt))

  content((3.65, 0.1), text(size: 7pt)[Comuni al\ carbonio])
  content((4.5, 0.15), text(size: 7pt)[Utensili])
  content((5.45, 0.15), text(size: 7pt)[Inossidabili])
})

Le principali grandezze meccaniche che caratterizzano il comportamento degli acciai sono:
- *Resistenza*: attitudine a sopportare i carichi applicati, determinata sperimentalmente mediante la prova di trazione.
- *Durezza*: resistenza locale che il materiale oppone alla penetrazione; viene misurata tramite prove sperimentali eseguite con una macchina di prova denominata *durometro*.
- *Duttilità o tenacità*: misura dell'energia di deformazione che il materiale è in grado di assorbire prima di giungere a rottura; un'indicazione quantitativa della tenacità è fornita dall'area complessiva sottesa dalla curva tensione-deformazione ($sigma$-$epsilon$) ricavata dalla prova di trazione.

=== Designazione normativa (UNI EN 10027)

La normativa *UNI EN 10027* stabilisce i criteri di classificazione e le sigle di designazione alfanumerica dei diversi tipi di acciaio. La designazione dipende dalla destinazione d'impiego, dalle caratteristiche meccaniche minime garantite e dalla composizione chimica (percentuale di carbonio e di elementi leganti):
- *Acciai non legati*: designati in base al tenore medio di carbonio (ad esempio `C40`, avente circa lo $0.40\%$ di carbonio);
- *Acciai da costruzione*: designati in base all'impiego strutturale e al carico unitario di snervamento minimo in $"MPa"$ (ad esempio `S355`);
- *Acciai legati da bonifica*: designati indicando il tenore di carbonio e i principali elementi di lega con i rispettivi fattori moltiplicativi (ad esempio `34CrMo4`).


// === Blocco_02_Slide_14-24 ===

== Acciai Inossidabili e Leghe Non Ferrose

=== Acciai Inossidabili

Fra gli acciai legati rivestono particolare importanza gli acciai inossidabili (comunemente detti _inox_, basati su leghe al Cromo-Molibdeno, $"CrMo"$). L'elemento fondamentale per la resistenza agli agenti atmosferici e chimici è il Cromo ($"Cr"$), il quale favorisce la protezione contro la corrosione attraverso il fenomeno della *passivazione*: a contatto con l'ossigeno atmosferico ($"O"_2$), il cromo forma un sottilissimo film superficiale di ossido di cromo, continuo e impermeabile all'ossigeno stesso, che impedisce l'ulteriore ossidazione del substrato metallico sottostante.

Anche il Molibdeno ($"Mo"$) contribuisce a ridurre la corrosione, ma il tenore che se ne aggiunge in lega rimane modesto per due ragioni principali: si tratta di un metallo costoso e la sua presenza rende la lega molto dura e, di conseguenza, difficile da lavorare alle macchine utensili.

#canvas(length: 1cm, {
  import draw: *
  
  // Substrato acciaio inossidabile
  rect((0, 0), (4.6, 0.65), fill: rgb(0, 180, 245), stroke: 0.7pt + black)
  content((2.3, 0.325), text(size: 7pt, fill: white, weight: "bold")[Acciaio inossidabile])
  
  // Film passivante di ossido di Cr
  rect((0, 0.65), (4.6, 0.92), fill: luma(130), stroke: 0.7pt + black)
  
  // Frecce ondulate di O2 incidenti dall'alto
  // Freccia 1 (x = 0.7)
  bezier((0.7, 2.0), (0.7, 1.75), (0.85, 1.92), (0.55, 1.83), stroke: 0.8pt + rgb(210, 50, 30))
  bezier((0.7, 1.75), (0.7, 1.5), (0.85, 1.67), (0.55, 1.58), stroke: 0.8pt + rgb(210, 50, 30))
  line((0.7, 1.5), (0.7, 1.05), stroke: 0.8pt + rgb(210, 50, 30), mark: (end: ">", size: 0.14))
  content((0.55, 1.6), text(size: 7pt, fill: rgb(210, 50, 30))[$"O"_2$], anchor: "east")
  
  // Freccia 2 (x = 2.3)
  bezier((2.3, 2.0), (2.3, 1.75), (2.45, 1.92), (2.15, 1.83), stroke: 0.8pt + rgb(210, 50, 30))
  bezier((2.3, 1.75), (2.3, 1.5), (2.45, 1.67), (2.15, 1.58), stroke: 0.8pt + rgb(210, 50, 30))
  line((2.3, 1.5), (2.3, 1.05), stroke: 0.8pt + rgb(210, 50, 30), mark: (end: ">", size: 0.14))
  content((2.15, 1.6), text(size: 7pt, fill: rgb(210, 50, 30))[$"O"_2$], anchor: "east")
  
  // Freccia 3 (x = 3.9)
  bezier((3.9, 2.0), (3.9, 1.75), (4.05, 1.92), (3.75, 1.83), stroke: 0.8pt + rgb(210, 50, 30))
  bezier((3.9, 1.75), (3.9, 1.5), (4.05, 1.67), (3.75, 1.58), stroke: 0.8pt + rgb(210, 50, 30))
  line((3.9, 1.5), (3.9, 1.05), stroke: 0.8pt + rgb(210, 50, 30), mark: (end: ">", size: 0.14))
  content((3.75, 1.6), text(size: 7pt, fill: rgb(210, 50, 30))[$"O"_2$], anchor: "east")
  
  // Freccia arancione verso etichetta strato passivante
  line((4.7, 0.82), (4.98, 0.82), (4.98, 0.88), (5.12, 0.785), (4.98, 0.69), (4.98, 0.75), (4.7, 0.75), close: true, fill: rgb(240, 100, 20), stroke: 0.5pt + rgb(160, 50, 0))
  
  // Testo descrittivo a destra
  content((5.25, 0.82), text(size: 7pt, weight: "bold")[Film di ossido di $"Cr"$ impermeabile all'$"O"_2$], anchor: "west")
  content((6.1, 0.48), text(size: 7pt, fill: rgb(30, 40, 160), weight: "bold")[(strato passivante)], anchor: "west")
})

In base alla loro microstruttura cristallina, gli acciai inossidabili si suddividono principalmente in due famiglie:
- *Acciai inossidabili austenitici*, caratterizzati da una superiore resistenza alla corrosione;
- *Acciai inossidabili martensitici*, che presentano caratteristiche più alto-resistenziali dal punto di vista meccanico.

=== Leghe di Alluminio

Le leghe di alluminio di impiego strutturale si suddividono principalmente in due categorie in funzione dell'elemento di lega principale:
- *Leghe Alluminio-Rame* ($"Cu" 3 div 5 %$): presentano una buona resistenza meccanica dopo il trattamento termico di bonifica, raggiungendo una tensione di rottura $R_m = 400 div 500 "MPa"$. Sono note con i nomi commerciali di _Avional_, _Duralluminio_ e _Recidal_, e trovano largo impiego nell'industria aeronautica e automobilistica (costruzione di veicoli).
- *Leghe Alluminio-Zinco* ($"Zn" 5 div 8 %$): la presenza dello zinco incrementa notevolmente la resistenza meccanica dopo bonifica, portando il carico di rottura a valori di $R_m = 500 div 700 "MPa"$, unitamente a una buona resistenza alla corrosione. Il nome commerciale di riferimento per questa classe è _Ergal_.

=== Titanio e Leghe di Titanio

L'impiego strutturale del titanio e delle sue leghe offre molteplici vantaggi ingegneristici:
- *Leggerezza*: presenta una massa inferiore del $40 %$ rispetto all'acciaio, con una densità pari a $4,5 "g/cm"^3$ contro i $7,9 "g/cm"^3$ dell'acciaio;
- *Eccellenti proprietà meccaniche* (elevata resistenza specifica);
- *Scarsa tossicità e ottima biocompatibilità*, che lo rendono ideale per applicazioni biomedicali e protesiche;
- *Assenza di proprietà magnetiche* (materiale amagnetico);
- *Buona resistenza agli acidi* e agli ambienti chimicamente aggressivi;
- *Buona trasmissione del calore*, sebbene con una conducibilità termica inferiore rispetto a quella degli acciai.

=== Magnesio e Leghe di Magnesio

Il magnesio e le leghe di magnesio si distinguono per i seguenti vantaggi applicativi:
- *Densità minima*: possiedono la minore densità ($1,8 "g/cm"^3$) rispetto a qualsiasi altro materiale metallico di impiego strutturale. In termini relativi, la loro densità è pari a circa $2 / 3$ di quella delle leghe di alluminio, $2 / 5$ di quella delle leghe di titanio e appena $1 / 5$ di quella dell'acciaio;
- *Elevata resistenza specifica* e *buona lavorabilità in getti* (fonderia);
- *Buona saldabilità* e *buona resistenza a corrosione*;
- *Migliore resistenza all'invecchiamento* rispetto ai materiali compositi a matrice polimerica.

=== Tabelle Riepilogative delle Proprietà dei Materiali Metallici

Di seguito si riportano i valori tipici del modulo di elasticità longitudinale $E$, del coefficiente di Poisson $nu$, della densità $rho$, della tensione di rottura $R_m$ e della tensione di snervamento (o limite di proporzionalità) $R_p$ per i principali acciai, ghise e leghe non ferrose.

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto),
    align: (left, center, center, center, center, center),
    table.header(
      [*Materiale*], [$E ["MPa"]$], [$nu$], [$rho ["kg/m"^3]$], [$R_m ["MPa"]$], [$R_p ["MPa"]$]
    ),
    table.hline(),
    [Acciai da costruzione], [$2,1 dot 10^5$], [$0,3$], [$7800$], [$360 - 510$], [$235 - 350$],
    [Acciai non legati per getti], [$2,1 dot 10^5$], [$0,3$], [$7800$], [$300 - 500$], [$200 - 350$],
    [Acciai per getti], [$2,1 dot 10^5$], [$0,3$], [$7800$], [$400 - 600$], [$250 - 400$],
    [Acciai da bonifica], [$2,1 dot 10^5$], [$0,3$], [$7800$], [$500 - 1100$], [$350 - 750$],
    [Acciai da cementazione], [$2,1 dot 10^5$], [$0,3$], [$7800$], [$500 - 1500$], [$350 - 1000$],
    [Acciai speciali per molle], [$2,1 dot 10^5$], [$0,3$], [$7800$], [$1200 - 1800$], [$900 - 1300$],
    [Acciai inossidabili], [$2,1 dot 10^5$], [$0,3$], [$7800$], [$600 - 1200$], [$400 - 900$],
    [Ghise], [$1,6 dot 10^5$], [$0,3$], [$7000$], [$350 - 500$], [---],
  ),
  caption: [Proprietà fisiche e meccaniche di acciai e ghise.]
)

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto),
    align: (left, center, center, center, center, center),
    table.header(
      [*Lega*], [$E ["MPa"]$], [$nu$], [$rho ["kg/m"^3]$], [$R_m ["MPa"]$], [$R_p ["MPa"]$]
    ),
    table.hline(),
    [Al-Cu (Dural)], [$7,2 dot 10^4$], [$0,34$], [$2500$], [$400 - 500$], [$250 - 350$],
    [Al-Zn (Ergal)], [$7,2 dot 10^4$], [$0,34$], [$2500$], [$500 - 700$], [$450 - 500$],
    [Mg], [$4,6 dot 10^4$], [$0,34$], [$1700$], [$200 - 300$], [$160 - 250$],
    [Cu-St], [$1,1 dot 10^5$], [$0,3$], [$8000$], [$150 - 200$], [$300 - 400$],
    [Ti], [$1,1 dot 10^5$], [$0,34$], [$4500$], [$600 - 1200$], [$400 - 800$],
  ),
  caption: [Proprietà fisiche e meccaniche delle principali leghe non ferrose.]
)

= Comportamento Meccanico dei Materiali Compositi

== Definizione e Classificazione

Si definisce *materiale composito* la combinazione di due o più micro o macro-costituenti che differiscono nella forma e nella composizione chimica e che risultano reciprocamente insolubili. All'interno del sistema, uno dei costituenti prende il nome di *matrice* (fase continua), mentre gli altri costituiscono le *cariche* di rinforzo (fase dispersa); nella maggior parte delle applicazioni strutturali, tali cariche sono rappresentate da *fibre*.

I materiali compositi si distinguono in primo luogo in base alla natura chimico-fisica della matrice:
- *Compositi a matrice polimerica (PMC)*: caratterizzati da elevate proprietà meccaniche specifiche (rapporto resistenza/peso e rigidezza/peso);
- *Compositi a matrice metallica (MMC)*: progettati per offrire una resistenza meccanica migliorata alle alte temperature rispetto ai polimeri;
- *Compositi a matrice ceramica (CMC)*: sviluppati principalmente per ottenere una tenacità a frattura migliorata rispetto ai ceramici monolitici tradizionali.

In secondo luogo, i materiali compositi si classificano in base alla geometria e alla disposizione delle cariche di rinforzo, che determinano il grado di simmetria elastica del materiale:
- *Cariche sferiche*: generano materiali compositi con proprietà macroscopicamente *isotrope*;
- *Cariche irregolari*: danno luogo a compositi con proprietà *non isotrope* (anisotrope);
- *Cariche a piattello (lamellari)*: conferiscono proprietà *isotrope nel piano* di giacitura dei piattelli;
- *Fibre corte o lunghe*: utilizzate per realizzare compositi unidirezionali oppure laminati (anche sotto forma di tessuti bidimensionali 2D), i quali esibiscono proprietà *ortotrope*.

#nota[_[Figura nelle slide: fotografie a confronto tra fasci di fibre lunghe sciolte e nastri/tessuti bidimensionali (2D) di fibre lunghe intrecciate affiancati a un righello millimetrato]_]

== Tipologie di Fibre e Matrici Polimeriche

=== Fibre di Rinforzo

Le tipologie di fibre più diffuse nelle applicazioni strutturali sono tre:
1. *Fibre di vetro*: presentano un'ottima resistenza meccanica ($2 - 5 "GPa"$), un basso costo di produzione e una buona tenacità, ma sono penalizzate da un basso modulo elastico ($70 - 80 "GPa"$) e da una media densità ($2,5 - 2,8 "g/cm"^3$).
2. *Fibre di carbonio*: offrono un'ottima resistenza meccanica ($3,1 - 4,5 "GPa"$), un elevatissimo modulo elastico ($220 - 800 "GPa"$) e una bassa densità ($1,7 - 2,1 "g/cm"^3$), a fronte tuttavia di un alto costo e di una bassa tenacità (comportamento fragile agli urti).
3. *Fibre aramidiche* (note con i nomi commerciali _Kevlar_ e _Nomex_): coniugano un'ottima resistenza meccanica ($3,0 - 4,5 "GPa"$) con un'alta tenacità, un costo medio, un medio modulo elastico ($130 - 150 "GPa"$) e una densità molto bassa ($< 1,5 "g/cm"^3$).

=== Matrici Polimeriche

Le matrici polimeriche si suddividono in due grandi categorie:
- *Matrici termoindurenti*: tra le più utilizzate figurano le *resine epossidiche*, caratterizzate da buone proprietà meccaniche, ottima adesione chimico-fisica alle fibre e minore ritiro volumetrico durante la reticolazione, sebbene abbiano un costo elevato. Vengono impiegate prevalentemente in combinazione con fibre di carbonio e fibre aramidiche per la realizzazione di compositi pregiati (ad esempio nel settore aeronautico).
- *Matrici termoplastiche*: si utilizza ampiamente il *Nylon* (poliammidi $"PA6"$ o $"PA66"$) e trovano crescente diffusione i tecnopolimeri ad alte prestazioni, quali $"PEEK"$, $"PEI"$ e $"PPS"$.

== Risposta Meccanica del Manufatto Composito

Dal punto di vista costitutivo, la fibra considerata singolarmente esibisce un comportamento generalmente *fragile* (elastico lineare fino a rottura), mentre la matrice può presentare un comportamento sia *fragile* sia *duttile* a seconda della sua formulazione.

#nota[
Un manufatto realizzato in materiale composito presenta proprietà elastiche e resistenziali fortemente variabili in funzione della percentuale in volume (frazione volumetrica) di matrice e di fibra, nonché della direzione di applicazione del carico rispetto all'orientamento delle fibre. Al crescere della percentuale volumetrica di matrice, le proprietà meccaniche globali del manufatto decrescono notevolmente.
]

#canvas(length: 1cm, {
  import draw: *
  
  // Laminato composito a fibre lunghe orizzontali (alternanza matrice grigio-blu e fibre bianche)
  // Strati di matrice (6 strati grigio-blu) e 5 fibre bianche intermedie
  rect((-2.5, -0.78), (2.5, 0.78), fill: rgb(95, 115, 140), stroke: 0.7pt + black)
  
  // Fibre orizzontali bianche
  rect((-2.5, 0.48), (2.5, 0.64), fill: white, stroke: 0.5pt + black)
  rect((-2.5, 0.21), (2.5, 0.37), fill: white, stroke: 0.5pt + black)
  rect((-2.5, -0.08), (2.5, 0.08), fill: white, stroke: 0.5pt + black)
  rect((-2.5, -0.37), (2.5, -0.21), fill: white, stroke: 0.5pt + black)
  rect((-2.5, -0.64), (2.5, -0.48), fill: white, stroke: 0.5pt + black)
  
  // Contorno esterno del provino
  rect((-2.5, -0.78), (2.5, 0.78), fill: none, stroke: 0.8pt + black)
  
  // Frecce rosse longitudinali (direzione delle fibre - alta resistenza)
  // Freccia destra
  line((2.7, 0.16), (3.15, 0.16), (3.15, 0.42), (3.55, 0.0), (3.15, -0.42), (3.15, -0.16), (2.7, -0.16), close: true, fill: rgb(245, 35, 10), stroke: 0.6pt + black)
  
  // Freccia sinistra
  line((-2.7, 0.16), (-3.15, 0.16), (-3.15, 0.42), (-3.55, 0.0), (-3.15, -0.42), (-3.15, -0.16), (-2.7, -0.16), close: true, fill: rgb(245, 35, 10), stroke: 0.6pt + black)
  
  // Frecce rosse trasversali (direzione ortogonale alle fibre - governata dalla matrice)
  // Freccia superiore
  line((-0.13, 0.92), (-0.13, 1.22), (-0.38, 1.22), (0.0, 1.48), (0.38, 1.22), (0.13, 1.22), (0.13, 0.92), close: true, fill: rgb(245, 35, 10), stroke: 0.6pt + black)
  
  // Freccia inferiore
  line((-0.13, -0.92), (-0.13, -1.22), (-0.38, -1.22), (0.0, -1.48), (0.38, -1.22), (0.13, -1.22), (0.13, -0.92), close: true, fill: rgb(245, 35, 10), stroke: 0.6pt + black)
})
