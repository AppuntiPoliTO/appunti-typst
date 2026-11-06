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

== Conclusione esercizio di cinematica: verifica di incomprimibilità
Per completare il calcolo della divergenza del campo di velocità in coordinate polari/cartesiane, esplicitiamo le derivate della coordinata radiale $r = (x^2 + y^2)^(1/2)$ rispetto a $x$ e $y$:
$ (partial r) / (partial x) = 1/2 (x^2 + y^2)^(-1/2) dot.op 2 x = x / r , quad (partial r) / (partial y) = 1/2 (x^2 + y^2)^(-1/2) dot.op 2 y = y / r $
Sostituendo $(partial r)/(partial x) = x/r$ e $(partial r)/(partial y) = y/r$ nei termini dello sviluppo della divergenza:
$ -y / r (partial r) / (partial x) (partial u) / (partial r) - 1 / r^2 (partial r) / (partial x) u + dots.h = - (x y) / r^2 (partial u) / (partial r) - (x y) / r^3 u + (x y) / r^2 (partial u) / (partial r) + (x y) / r^3 u = 0 $
I termini misti in $(x y)/r^2 (partial u)/(partial r)$ e $(x y)/r^3 u$ risultano uguali e di segno opposto e si elidono a coppie, confermando che:
$ nabla dot.op bold(u) = 0 $
Il campo di velocità assegnato è dunque fisicamente consistente con il moto di un fluido incomprimibile (a densità costante). In generale, quando viene fornita una soluzione per il campo di velocità, verificare che soddisfi la condizione di divergenza nulla rappresenta il primo controllo di coerenza fisica da effettuare.

#v(1em)

// [RIORDINATO DA AUDIO]
Riscrivo dunque il Th. di Reynolds:

$ d/(d t) integral_D rho x dif V &= integral_D rho (D x)/(D t) dif V - integral_D nabla dot (rho x arrow(u)) dif V + integral_S rho x arrow(u)_s dot arrow(n) dif S \
&= integral_D rho (D x)/(D t) dif V + integral_S rho x [arrow(u)_s - arrow(u)] dot arrow(n) dif S $

Se $arrow(u)_s = arrow(u)$:

$ d/(d t) integral_(D(t)) rho x dif V = integral_D rho (D x)/(D t) dif V $

Se $x = arrow(u)$:

$ d/(d t) integral_D rho arrow(u) dif V = integral_D rho (D arrow(u))/(D t) dif V $

Variazione della quantità di moto del volume MATERIALE di fluido.
Per $V -> 0$, considero particella fluida:
// [DA AUDIO]
Nella formulazione differenziale, la derivata materiale $(D arrow(u))/(D t)$ rappresenta l'accelerazione della particella fluida e $rho$ è la massa per unità di volume: integrando il termine $rho (D arrow(u))/(D t)$ su un volume materiale $D$, si ottiene l'equivalente del termine $m arrow(a)$ del secondo principio della dinamica.

$ rho (D arrow(u))/(D t) &= arrow(F)_V + arrow(F)_S \
&= integral_D rho arrow(g) dif V + integral_S bold(sigma) dot arrow(n) dif S $

- $sigma_(i j)$ - tensore simmetrico implica due contributi:

$ sigma_(i j) = underbrace((sigma_(i j))_"eq", "statico o" arrow(u) "uniforme") + underbrace((sigma_(i j))_"din", "i.e." arrow(u)(arrow(x))) $

$ (sigma_(i j))_"eq" = mat(-p, 0, 0; 0, -p, 0; 0, 0, -p) = -p delta_(i j) $

$ integral_D rho (D arrow(u))/(D t) dif V &= integral_D rho arrow(g) dif V + integral_S bold(sigma) dot arrow(n) dif S \
&= integral_D rho arrow(g) dif V + integral_D nabla dot bold(sigma) dif V $
// [DA AUDIO]
Il primo termine a secondo membro rappresenta la risultante delle forze di volume $arrow(F)_V$, mentre il secondo termine rappresenta la risultante delle forze di superficie $arrow(F)_S$, riscritta come integrale di volume della divergenza del tensore degli sforzi $nabla dot.op bold(sigma)$ grazie al teorema della divergenza di Gauss.

$ rho (D u_i)/(D t) &= rho g_i + (partial)/(partial x_j) sigma_(i j) \
&= rho g_i - (partial)/(partial x_j) (p delta_(i j)) ==> $

$ rho (D u_i)/(D t) = rho g_i - (partial p)/(partial x_i) $

Eq. di Eulero.
// [DA AUDIO]
Nel ricavare l'equazione di Eulero abbiamo assunto che, anche quando il fluido è in movimento, il tensore degli sforzi mantenga la stessa forma isotropa del caso statico, ovvero $sigma_(i j) = -p delta_(i j)$, trascurando il contributo dinamico viscoso $(sigma_(i j))_"din"$.

Perché $-p delta_(i j) = sigma_(i j)$?

$ T_i = sigma_(i j) n_j &= mat(-p, 0, 0; 0, -p, 0; 0, 0, -p) mat(0; 0; 1) \
&= (0, 0, -p) $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Sforzo esercitato dal fluido sulla parete.
  ],
  [
    
  ]
)
#v(1em)

// [RIORDINATO DA AUDIO]
Se considero un fluido a densità costante $rho = "cost."$:

$ cases(
  (partial u_j)/(partial x_j) = 0,
  (D u_i)/(D t) = -1/rho (partial p)/(partial x_i) + g_i
) $

$ cases(
  nabla dot arrow(u) = 0,
  (D arrow(u))/(D t) = -1/rho nabla p + arrow(g)
) $

4 equazioni $<==>$ 4 incognite:

$ (arrow(u), p) $

Il sistema va completato con delle condizioni al bordo. In caso di parete solida, si impone la condizione di impermeabilità:

$ arrow(u) dot arrow(n) = 0 $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $arrow(u)$ non deve avere una componente perpendicolare alla parete.
  ],
  [
    
  ]
)
#v(1em)
// [DA AUDIO]
Adottando il modello di fluido ideale (Eulero), in cui sono assenti i termini viscosi del tensore degli sforzi, sulla parete solida è possibile imporre unicamente la condizione di impermeabilità $arrow(u) dot.op arrow(n) = 0$, mentre non è possibile imporre la condizione di aderenza (_no-slip_, ossia velocità tangenziale nulla a parete). Questo costituisce un vantaggio dal punto di vista della semplificazione analitica, ma rappresenta un forte limite fisico che conduce a paradossi (come il paradosso di D'Alembert).

= Conservazione dell'Energia Cinetica e Teorema di Bernoulli

// [DA AUDIO]
Passiamo ora dal bilancio della quantità di moto alle sue implicazioni dal punto di vista energetico. Poiché stiamo considerando un fluido a densità costante ($rho = "cost."$), ci limitiamo allo studio della sola energia di tipo meccanico, senza introdurre il primo principio della termodinamica (che includerebbe anche gli scambi di energia interna e termica).

=== 1. Definizione dell'energia cinetica
Consideriamo il campo di velocità $bold(u) = mat(u_1; u_2; u_3)$ e moltiplichiamolo scalarmente per se stesso:
$ bold(u) dot.op bold(u) = u_i u_i = u_1 u_1 + u_2 u_2 + u_3 u_3 = u_1^2 + u_2^2 + u_3^2 = u^2 $
Moltiplicando il modulo quadro della velocità $u^2$ per $1/2$ e per la densità $rho$, otteniamo l'*energia cinetica per unità di volume*:
$ E_c = 1/2 rho u^2 $
(mentre $1/2 u^2$ rappresenta l'energia cinetica per unità di massa).

=== 2. Prodotto scalare dell'Equazione di Eulero per la velocità
Partiamo dall'equazione di Eulero in forma indiciale e moltiplichiamo entrambi i membri per la componente di velocità $u_i$ (sommando sull'indice ripetuto $i$):
$ u_i dot.op lr(( rho (D u_i) / (D t) = -(partial p) / (partial x_i) + rho g_i )) ==> underbrace(rho u_i (D u_i) / (D t), "1° membro") = underbrace(-u_i (partial p) / (partial x_i) + rho u_i g_i, "2° membro") $

=== 3. Manipolazione del 1° membro (termine inerziale)
- *Regola di derivazione*: per una generica funzione $A(bold(x), t)$, dalla regola di derivazione di una potenza vale:
$ (D) / (D t) lr(( A^2 / 2 )) = 1/2 dot.op 2 A (D A) / (D t) = A (D A) / (D t) $
Applicando questa identità a ciascuna componente di velocità ($A = u_i$), otteniamo:
$ u_i (D u_i) / (D t) = (D) / (D t) lr(( u_i u_i / 2 )) = (D) / (D t) lr(( u^2 / 2 )) $
- *1ª Ipotesi ($rho = "cost."$)*: assumendo che la densità sia costante, $rho$ può essere portata dentro l'operatore di derivata materiale:
$ rho u_i (D u_i) / (D t) = rho (D) / (D t) lr(( u^2 / 2 )) = (D) / (D t) lr(( rho u^2 / 2 )) $

=== 4. Manipolazione del 2° membro (pressione e potenziale gravitazionale)
A secondo membro il primo addendo $-u_i (partial p)/(partial x_i)$ contiene già il gradiente di pressione. Vogliamo ora riscrivere anche il termine gravitazionale $rho u_i g_i$ sotto forma di gradiente:
- Poiché il campo gravitazionale $bold(g)$ è *irrotazionale* ($nabla times bold(g) = 0$), esso è *conservativo* e ammette quindi una funzione potenziale gravitazionale $psi$ tale che:
$ bold(g) = -nabla psi <==> g_i = -(partial psi) / (partial x_i) $
- Scegliendo un sistema di riferimento con l'asse verticale $x_3$ diretto verso l'alto, il vettore accelerazione di gravità e il vettore posizione sono:
$ bold(g) = mat(g_1; g_2; g_3) = mat(0; 0; -g) , quad bold(x) = mat(x_1; x_2; x_3) $
L'espressione esplicita del potenziale gravitazionale $psi$ è pertanto:
$ psi = -g_i x_i = -(g_1 x_1 + g_2 x_2 + g_3 x_3) = - lr(( 0 dot.op x_1 + 0 dot.op x_2 + (-g) dot.op x_3 )) = g x_3 $
(Infatti, verificando la derivata: $-(partial psi)/(partial x_3) = -(partial (g x_3))/(partial x_3) = -g = g_3$).
- *Sostituzione nel termine gravitazionale*: sostituendo $g_i = -(partial psi)/(partial x_i)$ e sfruttando nuovamente l'ipotesi $rho = "cost."$ per portare $rho$ dentro la derivata spaziale, si ha:
$ rho u_i g_i = rho u_i lr(( -(partial psi) / (partial x_i) )) = -u_i (partial (rho psi)) / (partial x_i) = -u_i (partial (rho g x_3)) / (partial x_i) $

=== 5. Sostituzione nell'equazione di bilancio dell'energia meccanica
Sostituendo i risultati ottenuti per il 1° e il 2° membro nell'equazione di partenza:

#grid(
  columns: (10cm, 1fr, 13cm),
  column-gutter: -15em,
  align: (center + horizon, center + horizon, center + horizon),
  [
    sostituendo:
    $ rho u_i (D u_i) / (D t) = (D) / (D t) lr(( rho u^2 / 2 )) $
    $ rho u_i g_i = -u_i (partial (rho psi)) / (partial x_i) $
  ],
  [
    $quad quad quad ==>$
  ],
  [
    $ quad quad quad quad (D) / (D t) lr(( rho u^2 / 2 )) = -u_i (partial p) / (partial x_i) - u_i (partial (rho psi)) / (partial x_i) $
  ]
)
#v(1em)

Ricordando che la derivata materiale si sviluppa come $(D)/(D t) = (partial)/(partial t) + u_i (partial)/(partial x_i)$, esplicitiamo il primo membro:
$ underbrace((partial) / (partial t) lr(( rho u^2 / 2 )), "variazione locale a punto fisso") + underbrace(u_i (partial) / (partial x_i) lr(( rho u^2 / 2 )), "flusso convettivo di en. cinetica") = underbrace(-u_i (partial p) / (partial x_i) - u_i (partial (rho psi)) / (partial x_i), "flussi di energia di pressione e potenziale") $
Portando tutti i termini a primo membro, l'equazione assume la forma:
$ (partial) / (partial t) lr(( rho u^2 / 2 )) + u_i (partial) / (partial x_i) lr(( rho u^2 / 2 )) + u_i (partial p) / (partial x_i) + u_i (partial (rho psi)) / (partial x_i) = 0 $
i cui singoli termini hanno il seguente significato fisico:
- $(partial)/(partial t) (rho u^2/2)$ è la variazione locale nel tempo dell'energia cinetica in un punto fisso dello spazio;
- $u_i (partial)/(partial x_i) (rho u^2/2)$ è il trasporto convettivo (flusso) di energia cinetica;
- i termini di pressione e gravità rappresentano i flussi di energia meccanica associati al lavoro delle forze di pressione e delle forze gravitazionali.

Per integrare questa equazione in un risultato algebrico esatto, il Teorema di Bernoulli richiede quattro ipotesi fondamentali:
1. Flusso inviscido (già utilizzato nell'Eq. di Eulero).
2. Flusso stazionario ($partial / partial t = 0$, da cui la derivata materiale si riduce a $bold(u) dot nabla$).
// [DA AUDIO]
Occorre fare attenzione al fatto che l'ipotesi di stazionarietà annulla esclusivamente la derivata parziale locale nel tempo $(partial)/(partial t) = 0$, ma non annulla l'intera derivata materiale $(D)/(D t)$, di cui rimane attivo il contributo convettivo $u_i (partial)/(partial x_i)$.
3. Flusso incomprimibile ($rho = "cost."$, il che permette di portare $rho$ dentro gli operatori differenziali).
4. Forze conservative (l'esistenza del potenziale $Psi$).

Sotto queste assunzioni, riorganizziamo i termini:
$ u_j (partial) / (partial x_j) underbrace(lr([ rho u^2 / 2 + p + rho psi ]), H) = 0 $ 
Definendo il trinomio di Bernoulli come densità di energia meccanica $cal(H) = p + rho Psi + rho u^2/2$, l'equazione implica:
// [DA AUDIO]
Il simbolo $H$ (o $cal(H)$) deriva dal termine inglese _head_ ("testa"), tradotto nella letteratura idraulica italiana come _carico_ (o carico totale):
$ H = rho u^2 / 2 + p + rho g x_3 $
Nella definizione qui adottata, ciascun addendo di $H$ ha le dimensioni di una pressione ($"Pa" = "N"/"m"^2 = "J"/"m"^3$): questa formulazione è tipica dell'aerodinamica, dove si misurano direttamente differenze di pressione.
In ambito idraulico (ad esempio nell'idraulica fluviale) si preferisce invece dividere l'intera espressione per il peso specifico $rho g$, definendo il carico idraulico:
$ H_"idr" = H / (rho g) = u^2 / (2 g) + p / (rho g) + x_3 $
che ha le dimensioni di una lunghezza ($"m"$), in quanto il carico viene misurato direttamente come altezza di colonna d'acqua.


=== 6. Interpretazione geometrica e Teorema di Bernoulli
Passando dalla notazione indiciale a quella vettoriale, l'equazione per il carico totale $cal(H) = 1/2 rho u^2 + p + rho g x_3$ si scrive come un prodotto scalare:
$ u_i (partial cal(H)) / (partial x_i) = bold(u) dot.op nabla cal(H) = 0 $

1. *Condizione di ortogonalità*: il prodotto scalare tra due vettori non nulli è zero se e solo se i due vettori sono tra loro perpendicolari:
$ bold(u) dot.op nabla cal(H) = 0 <==> nabla cal(H) perp bold(u) $
2. *Legame con le linee di corrente*: per definizione, una linea di corrente è una curva che in ogni suo punto è tangente al vettore velocità locale $bold(u)$. Indicato con $bold(t) = bold(u) / abs(bold(u))$ il versore tangente alla linea di corrente (e con $s$ l'ascissa curvilinea lungo di essa), il fatto che $nabla cal(H)$ sia perpendicolare a $bold(u)$ significa che *$nabla cal(H)$ è in ogni punto perpendicolare alla linea di corrente*.
3. *Derivata direzionale lungo la linea di corrente*: proiettando il gradiente $nabla cal(H)$ lungo la direzione tangente $bold(t)$ alla linea di corrente, otteniamo la derivata direzionale di $cal(H)$ lungo la linea di corrente stessa:
$ (partial cal(H)) / (partial s) = nabla cal(H) dot.op bold(t) = nabla cal(H) dot.op bold(u) / abs(bold(u)) = 0 $
Poiché la derivata di $cal(H)$ lungo l'ascissa curvilinea $s$ è identicamente nulla, ne consegue che il carico totale non varia muovendosi lungo la linea di corrente:
$ cal(H) = 1/2 rho u^2 + p + rho g x_3 = "cost." quad ("lungo una linea di corrente") $
Questo risultato fondamentale costituisce il *Teorema di Bernoulli* (esisterà poi una forma ancora più forte del teorema, valida per campi di moto irrotazionali, in cui $cal(H)$ risulta costante in tutto il campo di moto e non solo lungo la singola linea di corrente).

*Significato fisico e concetto di fluido ideale*: il Teorema di Bernoulli esprime la *conservazione dell'energia meccanica* lungo il moto. Il sistema non dissipa energia meccanica in calore perché nel modello di Eulero ($sigma_(i j) = -p delta_(i j)$) non è presente alcun termine viscoso capace di produrre dissipazione. Per questa ragione un fluido descritto dal modello di Eulero viene chiamato *fluido ideale* (in contrapposizione a un fluido reale): l'assenza di dissipazione permette la conservazione dell'energia meccanica, ma come ogni idealizzazione comporterà delle discrepanze fisiche rispetto al comportamento reale.

#v(1em)

== Applicazione: Genesi della portanza su un profilo alare
Una prima applicazione del Teorema di Bernoulli permette di spiegare, in prima approssimazione, la nascita della forza di *portanza* su un profilo alare investito da una corrente fluida.

#align(center)[
  #canvas(length: 1cm, {
    import draw: *

    // Profilo alare (Nero)
    bezier((0,0), (4,0), (0, 1.25), (2, 0.75), stroke: 1.5pt)
    bezier((0,0), (4,0), (0, -0.25), (2, 0.1), stroke: 1.5pt)

    // Linee di flusso superiori (Rosso)
    bezier((-2, -0.1), (5, -0.3), (-0.5, 1.6), (2.5, 1.1), stroke: red + 1pt, mark: (end: ">"))
    bezier((-2, 0.4), (5, 0.2), (-0.5, 2.3), (2.5, 1.8), stroke: red + 1pt, mark: (end: ">"))
    bezier((-2, 0.8), (5, 0.6), (-0.5, 2.9), (2.5, 2.4), stroke: red + 1pt, mark: (end: ">"))

    // Linee di flusso inferiori (Blu)
    bezier((-2, -0.4), (5, -0.4), (-0.5, -0.6), (2.5, -0.4), stroke: blue + 1pt, mark: (end: ">"))
    bezier((-2, -0.7), (5, -0.7), (-0.5, -1.0), (2.5, -0.7), stroke: blue + 1pt, mark: (end: ">"))
    bezier((-2, -1.0), (5, -1.0), (-0.5, -1.4), (2.5, -1.0), stroke: blue + 1pt, mark: (end: ">"))

    // Vettore Forza (Viola)
    line((1.5, -0.1), (1.5, 2.5), mark: (end: ">"), stroke: rgb("800080") + 1.2pt)
    content((1.1, 2.4), [#text(fill: rgb("800080"))[$F_i$]])

    // Annotazione superiore (Rosso)
    bezier((2.25, 2.0), (4.25, 2.5), (3.0, 2.25), (3.75, 2.5), mark: (end: ">"), stroke: red + 1pt)
    content((4.4, 2.5), [$u$ cresce, $p$ diminuisce], anchor: "west")

    // Annotazione inferiore (Blu)
    bezier((2.25, -0.5), (4.25, -1.25), (3.0, -0.75), (3.75, -1.25), mark: (end: ">"), stroke: blue + 1pt)
    content((4.4, -1.25), [$u$ diminuisce, $p$ aumenta], anchor: "west")
  })
]

=== 1. Legame tra velocità e pressione attorno al profilo
1. *Geometria delle linee di corrente*: la forma del profilo alare costringe il campo di moto ad avvilupparsi attorno ad esso producendo un *addensamento* delle linee di corrente nella parte superiore (*dorso*) e un *diradamento* nella parte inferiore (*ventre*).
2. *Variazione di velocità*: per la conservazione della massa tra linee di corrente adiacenti, laddove le linee si avvicinano (dorso) il fluido accelera e la velocità cresce ($u^+$), mentre laddove si allontanano (ventre) il fluido decelera e la velocità diminuisce ($u^-$).
3. *Variazione di pressione tramite Bernoulli*: poiché lo spessore verticale del profilo è piccolo, possiamo trascurare le variazioni della quota gravitazionale $x_3$ tra dorso e ventre ($rho g x_3 approx "cost."$). Il Teorema di Bernoulli lungo ciascuna linea di corrente si riduce allora a:
$ 1/2 rho u^2 + p = "cost." ==> p = "cost." - 1/2 rho u^2 $
Di conseguenza:
- sul *dorso*, dove la velocità aumenta ($u arrow.t$), la pressione deve diminuire ($p arrow.b$, zona di depressione $p^-$);
- sul *ventre*, dove la velocità diminuisce ($u arrow.b$), la pressione deve aumentare ($p arrow.t$, zona di sovrappressione $p^+$).

=== 2. Calcolo della forza aerodinamica risultante
Calcoliamo la forza complessiva $bold(F)$ esercitata dal fluido sulla superficie chiusa $S$ del profilo alare. Indicato con $bold(n)$ il versore normale uscente dalla superficie del profilo (diretto dal corpo verso il fluido), la forza di superficie è l'integrale del vettore sforzo $bold(t)_n = bold(sigma) dot.op bold(n)$:
$ F_i = integral_S sigma_(i j) n_j dif S $
Sostituendo il tensore degli sforzi di un fluido ideale $sigma_(i j) = -p delta_(i j)$ e sfruttando la proprietà della delta di Kronecker ($delta_(i j) n_j = n_i$):
$ F_i = integral_S (-p delta_(i j)) n_j dif S = - integral_S p n_i dif S <==> bold(F) = - integral_S p bold(n) dif S $
Il segno meno davanti all'integrale indica che la pressione $p$ agisce sempre spingendo *contro* la superficie del profilo (nella direzione di $-bold(n)$, cioè verso l'interno del corpo):
- Sul *ventre* (dove la normale uscente $bold(n)$ punta verso il basso, quindi $-bold(n)$ punta verso l'alto), la pressione relativa rispetto a quella atmosferica indisturbata è *positiva* ($p^+ > 0$) e spinge il profilo verso l'alto.
- Sul *dorso* (dove la normale uscente $bold(n)$ punta verso l'alto, quindi $-bold(n)$ punta verso il basso), la pressione relativa è *negativa* ($p^- < 0$, aspirazione) e, moltiplicata per $-bold(n)$, fornisce anch'essa un contributo diretto verso l'alto.

Sommando i contributi su tutta la superficie $S$, la risultante delle pressioni genera una forza netta $bold(F)$ diretta verticalmente verso l'alto (*portanza*), che sostiene il profilo alare.

// [DA AUDIO]
=== Esperimenti dimostrativi sull'effetto Bernoulli
Lo stesso principio fisico spiega diversi fenomeni aerodinamici e idrodinamici controintuitivi:
- *Attrazione tra due palline sospese*: se si appendono due palline leggere a due fili vicini e si soffia un getto d'aria nello spazio compreso tra di esse, le palline non si allontanano ma si avvicinano. Infatti, nella regione interna tra le due palline si ha un addensamento delle linee di corrente con conseguente aumento della velocità ($u^+$) e diminuzione della pressione ($p^-$), mentre sui lati esterni la velocità resta bassa ($u^-$) e la pressione è più alta ($p^+$), generando due forze risultanti che spingono le palline l'una verso l'altra.
- *Pallina in equilibrio in un getto*: per lo stesso meccanismo di depressione nella zona ad alta velocità, un getto d'aria può mantenere in equilibrio stabile una pallina leggera.

// [DA AUDIO]
#canvas(length: 1cm, {
  import draw: *

  // Fili di sospensione
  line((-1.5, 2.5), (-1.5, 0.7), stroke: 1pt + black)
  line((1.5, 2.5), (1.5, 0.7), stroke: 1pt + black)

  // Le due palline
  circle((-1.5, 0), radius: 0.7, stroke: 1.3pt + black, fill: luma(240))
  circle((1.5, 0), radius: 0.7, stroke: 1.3pt + black, fill: luma(240))

  // Linee di corrente centrali (addensate)
  line((0, -2.2), (0, 2.2), stroke: 1pt + red, mark: (end: ">"))
  bezier((-0.4, -2.2), (-0.4, 2.2), (-0.15, 0), (-0.15, 0), stroke: 1pt + red, mark: (end: ">"))
  bezier((0.4, -2.2), (0.4, 2.2), (0.15, 0), (0.15, 0), stroke: 1pt + red, mark: (end: ">"))

  // Frecce delle forze di attrazione
  line((-1.5, 0), (-0.5, 0), stroke: 1.4pt + blue, mark: (end: ">"))
  line((1.5, 0), (0.5, 0), stroke: 1.4pt + blue, mark: (end: ">"))

  // Etichette
  content((0, -2.6), [$u^+, p^-$ (addensamento)])
  content((-3.2, 0), [$u^-, p^+$])
  content((3.2, 0), [$u^-, p^+$])
})

== Applicazione: Tubo di Pitot-Statico
Un trasduttore di pressione misura la differenza tra la pressione di ristagno $p_0$ e la pressione statica $p_1$. Sulla linea di corrente che impatta frontalmente il tubo e si arresta ($u_0 = 0$), possiamo applicare il Teorema di Bernoulli:
#align(center)[
#canvas(length: 1cm, {
  import draw: *

  // Sezione di ingresso 1
  line((-1.65, -1.20), (-1.65, 1.15), stroke: 1.2pt + black)

  // Frecce del flusso in ingresso
  line((-2.05, 0.80), (-1.75, 0.80), mark: (end: ">"), stroke: 1pt + black)
  line((-2.05, 0.40), (-1.75, 0.40), mark: (end: ">"), stroke: 1pt + black)
  line((-2.05, -0.02), (-1.75, -0.02), mark: (end: ">"), stroke: 1pt + black)
  line((-2.05, -0.45), (-1.75, -0.45), mark: (end: ">"), stroke: 1pt + black)
  line((-2.05, -0.85), (-1.75, -0.85), mark: (end: ">"), stroke: 1pt + black)

  // Corpo del tubo di Pitot
  line(
    (0.00, 0.30),
    (0.00, 0.80),
    (4.50, 0.80),
    (4.50, 0.00),
    (5.00, 0.00),
    (5.00, 0.80),
    (6.00, 0.80),
    (6.00, -0.80),
    (0.00, -0.80),
    (0.00, -0.25),
    (3.50, -0.25),
    (3.50, 0.30),
    close: true,
    stroke: 1.2pt + black
  )

  // Dettaglio interno nella presa statica
  line((4.80, 0.80), (4.80, 0.30), (5.00, 0.30), stroke: 1.2pt + black)
  line((4.80, 0.80), (5.00, 0.75), stroke: 1.2pt + black)

  // Linea di corrente centrale (tratteggiata)
  line((-1.65, 0.00), (3.50, 0.00), stroke: (paint: black, thickness: 1.1pt, dash: "dashed"))

  // Linea di corrente superiore
  bezier((-1.65, 0.15), (0.00, 0.72), (-0.80, 0.15), (-0.40, 0.45), stroke: 1.2pt + black)
  bezier((0.00, 0.72), (1.80, 1.20), (0.40, 0.99), (1.00, 1.20), stroke: 1.2pt + black)
  line((1.80, 1.20), (6.80, 1.20), stroke: 1.2pt + black)

  // Linea di corrente inferiore
  bezier((-1.65, -0.15), (-0.50, -0.45), (-0.90, -0.15), (-0.65, -0.25), stroke: 1.2pt + black)
  bezier((-0.50, -0.45), (2.00, -1.18), (-0.35, -0.65), (0.60, -1.18), stroke: 1.2pt + black)
  line((2.00, -1.18), (7.80, -0.98), stroke: 1.2pt + black)

  // Punto di ristagno (azzurro)
  circle((0.05, 0.00), radius: 0.07, fill: rgb(0, 110, 255), stroke: none)

  // Etichetta "1" rossa con sottolineatura
  content((-1.50, 1.50), text(fill: red, size: 14pt, weight: "bold")[1])
  line((-1.65, 1.25), (-1.35, 1.25), stroke: 1.2pt + red)

  // Etichetta "0" azzurra
  content((0.15, -1.60), text(fill: rgb(0, 110, 255), size: 14pt, weight: "bold")[0])
})
]

// [DA AUDIO]
Dal punto di vista costruttivo, il tubo di Pitot è un cilindro di piccole dimensioni disposto longitudinalmente nella direzione del flusso. Presenta un canalino interno assiale aperto sulla punta (presa totale o di arresto, punto $0$) e un secondo canalino collegato a una presa laterale sulla parete del cilindro (presa statica). All'interno dei canalini il fluido è in quiete, ma trasmette pressoché istantaneamente le pressioni alle due facce di un trasduttore differenziale di pressione.

Il funzionamento si basa sulle seguenti considerazioni fisiche:
- *Misura di velocità relativa e allineamento*: in aeronautica il tubo di Pitot misura la velocità relativa tra l'aereo e l'atmosfera circostante (che coincide con la velocità rispetto al suolo solo in assenza di vento, ma ne differisce sensibilmente in presenza di correnti in quota come le correnti a getto). Lo strumento deve essere allineato alla direzione del flusso; quando la direzione della corrente non è nota a priori, si impiegano sonde direzionali (come la _sonda a tre fori_), orientandole finché i due fori laterali simmetrici registrano la stessa pressione.
- *Flusso uniforme a monte*: poiché le dimensioni trasversali del tubo di Pitot sono molto piccole rispetto alle scale spaziali su cui varia il campo di moto esterno, alla scala dello strumento il flusso indisturbato a monte (sezione $1$) può essere considerato uniforme ($u_1$, $p_1$ e $cal(H)$ costanti). Inoltre, poiché la perturbazione indotta dal corpo cilindrico sul flusso tangenziale è minima, la pressione rilevata sulla presa laterale coincide con la pressione statica indisturbata $p_1$.
- *Punto di arresto (o di ristagno)*: tracciando le linee di corrente che investono un corpo (o, nel caso limite, un getto che impatta perpendicolarmente una parete piana), il fluido si divide passando in parte sopra/a destra e in parte sotto/a sinistra. Per simmetria, esiste sempre una linea di corrente centrale che termina sul corpo nel cosiddetto *punto di arresto* $0$: si tratta di un'astrazione matematica che individua la piccola regione frontale in cui la velocità del fluido si annulla ($u_0 = 0$) e, per il Teorema di Bernoulli, la pressione raggiunge il suo valore massimo $p_0$.

$ p_1 + 1/2 rho u_1^2 = p_0 + 1/2 rho u_0^2 $
Sostituendo $u_0 = 0$ per il punto di ristagno:
$ 1/2 rho u_1^2 = (p_0 - p_1) $
Risolvendo per la velocità del flusso in arrivo $u_1$:
$ u_1 = root(2, (2(p_0 - p_1))/rho) $
Il termine $1/2 rho u_1^2$ è noto come _pressione dinamica_.


#v(1em)


// [DA AUDIO]
== Applicazione: Velocità di efflusso da un serbatoio (Formula di Torricelli) e tempo di svuotamento
Consideriamo un serbatoio contenente acqua fino a un'altezza $h$, dotato di un foro sul fondo o sulla parete inferiore da cui fuoriesce un getto d'acqua. Tracciamo una linea di corrente che parte da un punto $A$ sul pelo libero (a quota $z_A$) e arriva in un punto $B$ all'uscita del foro (a quota $z_B$, appena a valle della sezione contratta dove le linee di corrente del getto tornano parallele).
Applicando il Teorema di Bernoulli lungo la linea di corrente tra $A$ e $B$:
$ 1/2 rho u_A^2 + p_A + rho g z_A = 1/2 rho u_B^2 + p_B + rho g z_B $
Valutiamo i singoli termini:
- Sul pelo libero $A$ (assumendo la sezione del serbatoio molto più grande di quella del foro) il fluido è pressoché fermo, quindi $u_A approx 0$.
- Sia il pelo libero in $A$ sia il getto libero in $B$ sono a diretto contatto con l'atmosfera. A rigore, tra la quota $z_A$ e la quota $z_B$ sussiste una variazione idrostatica della pressione atmosferica pari a:
$ p_B - p_A = rho_"aria" g (z_A - z_B) $
Tuttavia, poiché la densità dell'aria ($rho_"aria" approx 1 "kg"/"m"^3$) è circa un millesimo della densità dell'acqua ($rho_"acqua" approx 1000 "kg"/"m"^3$), il termine $rho_"aria" g (z_A - z_B)$ è del tutto trascurabile rispetto a $rho g (z_A - z_B)$ e possiamo porre in prima approssimazione $p_A approx p_B = p_"atm"$.

Semplificando le pressioni e dividendo per $rho$, otteniamo la velocità di efflusso (formula di Torricelli):
$ 1/2 u_B^2 = g (z_A - z_B) ==> u_B = sqrt(2 g (z_A - z_B)) = sqrt(2 g h) $
dove $h = z_A - z_B$ è il battente idrostatico sopra il foro.

// [DA AUDIO]
#canvas(length: 1cm, {
  import draw: *

  // Pareti del serbatoio con foro laterale in basso
  line((0, 3.5), (0, 0), (3.0, 0), (3.0, 0.4), stroke: 1.5pt + black)
  line((3.0, 0.8), (3.0, 3.5), stroke: 1.5pt + black)

  // Pelo libero A
  line((0, 2.8), (3.0, 2.8), stroke: 1.2pt + blue)
  content((1.5, 3.1), [Pelo libero $A$ ($p_A = p_"atm", u_A approx 0$)])

  // Linea di corrente da A a B e getto uscente
  bezier((1.5, 2.8), (3.6, 0.6), (1.5, 0.6), (2.5, 0.6), stroke: (paint: red, thickness: 1.1pt, dash: "dashed"), mark: (end: ">"))
  content((4.8, 0.6), [Getto $B$ ($p_B = p_"atm", u_B = sqrt(2 g h)$)])

  // Quota h(t) e sezione S
  line((-0.5, 0.6), (-0.5, 2.8), stroke: 0.8pt + black, mark: (start: ">", end: ">"))
  content((-1.1, 1.7), [$h(t)$])
  content((1.5, 1.8), [Sezione $S$])
  content((3.3, 0.15), [Foro $A$])
})

// [DA AUDIO]
=== Calcolo del tempo di svuotamento del serbatoio
Vogliamo ora calcolare il tempo $tau$ necessario a svuotare completamente un serbatoio di sezione trasversale costante $S$, partendo da un'altezza iniziale $h(0) = h_0$, attraverso un foro sul fondo di area $A << S$.
Poiché il foro è molto piccolo rispetto alla sezione del serbatoio ($A << S$), lo svuotamento avviene lentamente e in ogni istante la velocità di efflusso è data da $u(t) = sqrt(2 g h(t))$, la quale diminuisce nel tempo man mano che il livello $h(t)$ si abbassa.

Applichiamo il principio di conservazione della massa (che per un fluido a densità costante $rho = "cost."$ equivale alla conservazione del volume):
1. La massa d'acqua $G(t)$ contenuta nel serbatoio all'istante $t$ è pari al prodotto tra densità e volume:
$ G(t) = rho S h(t) $
2. La variazione nel tempo della massa contenuta nel serbatoio deve eguagliare l'opposto del flusso di massa uscente dal foro:
$ (d G) / (d t) = -rho Q $
dove il segno meno indica che la massa nel serbatoio diminuisce nel tempo e $Q$ è la portata volumetrica (flusso di volume) uscente dal foro di sezione $A$:
$ Q = A u(t) = A sqrt(2 g h(t)) $
3. Sostituendo l'espressione di $G(t)$ e di $Q$ nell'equazione di bilancio della massa:
$ (d) / (d t) (rho S h) = -rho A sqrt(2 g h) $
Essendo la densità $rho$ e la sezione $S$ costanti, semplificando $rho$ otteniamo il bilancio di volume:
$ S (d h) / (d t) = -A sqrt(2 g) h^(1/2) ==> (d h) / (d t) = - A / S sqrt(2 g) h^(1/2) $
4. Separiamo le variabili e integriamo tra l'istante iniziale $t = 0$ (in cui $h = h_0$) e l'istante di completo svuotamento $t = tau$ (in cui $h = 0$):
$ integral_(h_0)^0 h^(-1/2) dif h = - A / S sqrt(2 g) integral_0^tau dif t $
$ lr([ 2 h^(1/2) ])_(h_0)^0 = - A / S sqrt(2 g) tau ==> -2 h_0^(1/2) = - A / S sqrt(2 g) tau $
Ricavando $tau$, si ottiene la formula per il tempo di svuotamento del serbatoio:
$ tau = (2 h_0^(1/2) S) / (A sqrt(2 g)) = S / A sqrt((2 h_0) / g) $

// dal 5 


= Fluidi viscosi - Newtoniani

// [DA AUDIO]
Nei fluidi ideali la dinamica del campo di moto è descritta dalle equazioni di Eulero e dal teorema di Bernoulli (che riduce un sistema di quattro equazioni differenziali accoppiate a una singola equazione scalare).

Il modello di fluido ideale cessa tuttavia di essere valido quando le scale geometriche diventano piccole (ad esempio in un canale radiale stretto): in queste condizioni si generano forti differenze di velocità concentrate su distanze molto ridotte, ovvero elevati gradienti di velocità, che rendono non più trascurabili gli effetti della viscosità.

// [DA AUDIO]
Tra i fluidi viscosi esistono numerosi comportamenti reologici complessi; nel seguito si analizza unicamente la categoria dei *fluidi newtoniani*.

$
T_(i j) &= -p delta_(i j) + tau_(i j) \
overline(overline(T)) &= -p overline(overline(I)) + overline(overline(tau))
$

// [DA AUDIO]
Il tensore degli sforzi $T_(i j)$ (indicato anche con $sigma_(i j)$) è composto da due contributi distinti:
- il contributo della pressione idrodinamica $-p delta_(i j)$;
- il tensore degli sforzi viscosi $tau_(i j)$.

// [DA AUDIO]
Il contributo di pressione $-p delta_(i j)$:
- agisce sempre e solo in direzione normale alla superficie (in forma matriciale presenta termini $-p$ sulla diagonale principale e zeri fuori diagonale):
$ -p delta_(i j) = mat(-p, 0, 0; 0, -p, 0; 0, 0, -p) $
- è ineliminabile ed è non nullo anche nel caso statico (fluido in quiete) o in moto con velocità uniforme (che equivale alla quiete per un cambio di sistema di riferimento inerziale), ovvero esiste anche quando i gradienti di velocità sono nulli:
$ (partial u_i)/(partial x_j) = 0 arrow.r.double -p delta_(i j) != 0 $

Da cosa dipendono gli sforzi viscosi? \
Dai gradienti di velocità:

$ tau_(i j) = f((partial u_i)/(partial x_j)) $

// [DA AUDIO]
Il contributo viscoso $tau_(i j)$ esiste solo se i gradienti di velocità sono diversi da zero ($(partial u_i)/(partial x_j) != 0$). Nel modello di fluido ideale questo contributo viene posto identicamente nullo ($tau_(i j) = 0$) per scelta modellistica.

// [DA AUDIO]
Il tensore degli sforzi viscosi $tau_(i j)$ è un tensore del secondo ordine simmetrico ($tau_(i j) = tau_(j i)$):

$ overline(overline(tau)) = mat(tau_(1 1), tau_(1 2), tau_(1 3); tau_(2 1), tau_(2 2), tau_(2 3); tau_(3 1), tau_(3 2), tau_(3 3)) "con" cases(tau_(1 2) = tau_(2 1), tau_(1 3) = tau_(3 1), tau_(2 3) = tau_(3 2)) $

// [DA AUDIO]
Uno *sforzo* (in inglese *stress*) è definito come una forza per unità di superficie. Fisicamente, gli sforzi rappresentano dei *flussi (trasferimenti) di quantità di moto* all'interno del fluido:
- *Descrizione macroscopica (mezzo continuo)*: nel moto laminare il fluido può essere visualizzato come un insieme di piani o "filetti fluidi" (lamelle) che scorrono l'uno sull'altro; lo scorrimento relativo genera uno sforzo tangenziale che trasferisce quantità di moto da uno strato a quello adiacente, trascinandolo.
- *Descrizione microscopica (molecolare)*: occorre distinguere la scala macroscopica delle particelle fluide (il cui moto organizzato dà luogo alla *convezione*) dalla scala microscopica delle singole molecole (il cui moto termico erratico e disordinato dà luogo alla *diffusione*).
Le molecole, muovendosi erraticamente, urtano continuamente tra loro scambiandosi quantità di moto:
- gli urti frontali ("spinte" dirette) generano gli *sforzi normali*;
- il passaggio trasversale di molecole tra strati a diversa velocità genera gli *sforzi tangenziali* (in analogia a persone che escono trasversalmente da un'aula immettendosi in un corridoio: avendo velocità longitudinale nulla, urtano chi cammina lungo il corridoio frenandone il moto).

Poiché hanno origine dal moto erratico molecolare, gli sforzi viscosi $tau_(i j)$ sono *flussi diffusivi di quantità di moto*. Essendo la grandezza trasportata (la quantità di moto) un vettore, per definire la direzione del trasporto e le componenti della grandezza trasportata occorrono $3 times 3 = 9$ componenti: il flusso diffusivo di quantità di moto è pertanto un tensore del secondo ordine.

// [DA AUDIO]
La struttura matematica di $tau_(i j)$ è analoga alle leggi classiche dei flussi diffusivi per grandezze scalari:
1. *Legge di Fourier* (diffusione/conduzione del calore, ovvero di energia termica):
$ arrow(q) = -lambda nabla T $
dove $lambda$ è la conducibilità termica (coefficiente di diffusione del calore) e $T$ la temperatura.
2. *Legge di Fick* (diffusione di massa di una specie chimica, ad esempio una goccia d'inchiostro che si diluisce in acqua in quiete a causa degli urti molecolari):
$ arrow(j) = -D nabla c $
dove $D$ è il coefficiente di diffusione massica e $c$ la concentrazione.

In entrambe le leggi:
- il *segno meno* indica che il flusso avviene in verso opposto al gradiente (da zone a temperatura o concentrazione maggiore verso zone a valore minore), tendendo a omogeneizzare spazialmente la grandezza fino a raggiungere la configurazione di equilibrio più probabile, in accordo con il secondo principio della termodinamica;
- l'operatore *gradiente* (variazione su distanze infinitesime) compare perché le scale spaziali del libero cammino medio su cui avvengono gli urti molecolari sono molto più piccole della dimensione del "punto" matematico su scala macroscopica; i fenomeni microscopici devono quindi essere rappresentati nel continuo come funzioni locali di punto tramite derivate spaziali.

// [DA AUDIO]
In analogia con le leggi di Fourier e di Fick, gli sforzi viscosi sono proporzionali ai gradienti di velocità:

$ tau_(i j) prop (partial u_i)/(partial x_j) $

Il coefficiente di proporzionalità è la *viscosità dinamica* $mu$, che fisicamente rappresenta il *coefficiente di diffusione della quantità di moto*.
A differenza delle leggi di Fourier e di Fick, nell'espressione di $tau_(i j)$ non si introduce il segno meno per pura convenzione sulla definizione del verso positivo degli sforzi nel tensore $sigma_(i j)$.

Il gradiente $(partial u_i)/(partial x_j)$ può essere scomposto in una parte simmetrica ed una anti-simmetrica:

$ (partial u_i)/(partial x_j) = underbrace(1/2 ((partial u_i)/(partial x_j) + (partial u_j)/(partial x_i)), "simmetrica" \ D_(i j)) + underbrace(1/2 ((partial u_i)/(partial x_j) - (partial u_j)/(partial x_i)), "anti-simmetrica" \ Omega_(i j)) $

// [DA AUDIO]
La scomposizione si ottiene algebricamente scrivendo il gradiente come somma di due metà identiche e sommando e sottraendo il termine trasposto $1/2 (partial u_j)/(partial x_i)$:

$ (partial u_i)/(partial x_j) = 1/2 (partial u_i)/(partial x_j) + 1/2 (partial u_i)/(partial x_j) + 1/2 (partial u_j)/(partial x_i) - 1/2 (partial u_j)/(partial x_i) $

// [DA AUDIO]
Sviluppando esplicitamente le componenti in tre dimensioni, il tensore $D_(i j)$ risulta:

$ D_(i j) = mat(
  1/2 ((partial u_1)/(partial x_1) + (partial u_1)/(partial x_1)), 1/2 ((partial u_1)/(partial x_2) + (partial u_2)/(partial x_1)), 1/2 ((partial u_1)/(partial x_3) + (partial u_3)/(partial x_1));
  1/2 ((partial u_2)/(partial x_1) + (partial u_1)/(partial x_2)), 1/2 ((partial u_2)/(partial x_2) + (partial u_2)/(partial x_2)), 1/2 ((partial u_2)/(partial x_3) + (partial u_3)/(partial x_2));
  1/2 ((partial u_3)/(partial x_1) + (partial u_1)/(partial x_3)), 1/2 ((partial u_3)/(partial x_2) + (partial u_2)/(partial x_3)), 1/2 ((partial u_3)/(partial x_3) + (partial u_3)/(partial x_3))
) $

da cui si verifica che è un tensore simmetrico ($D_(i j) = D_(j i)$):
$ D_(1 2) = D_(2 1), quad D_(1 3) = D_(3 1), quad D_(2 3) = D_(3 2) $

Analogamente, sviluppando il tensore $Omega_(i j)$ si ha:

$ Omega_(i j) = mat(
  1/2 ((partial u_1)/(partial x_1) - (partial u_1)/(partial x_1)), 1/2 ((partial u_1)/(partial x_2) - (partial u_2)/(partial x_1)), 1/2 ((partial u_1)/(partial x_3) - (partial u_3)/(partial x_1));
  1/2 ((partial u_2)/(partial x_1) - (partial u_1)/(partial x_2)), 1/2 ((partial u_2)/(partial x_2) - (partial u_2)/(partial x_2)), 1/2 ((partial u_2)/(partial x_3) - (partial u_3)/(partial x_2));
  1/2 ((partial u_3)/(partial x_1) - (partial u_1)/(partial x_3)), 1/2 ((partial u_3)/(partial x_2) - (partial u_2)/(partial x_3)), 1/2 ((partial u_3)/(partial x_3) - (partial u_3)/(partial x_3))
) $

I termini sulla diagonale principale sono identicamente nulli ($Omega_(1 1) = Omega_(2 2) = Omega_(3 3) = 0$), mentre i termini extradiagonali sono opposti ($Omega_(i j) = -Omega_(j i)$):
$ Omega_(1 2) = -Omega_(2 1), quad Omega_(1 3) = -Omega_(3 1), quad Omega_(2 3) = -Omega_(3 2) $
pertanto $Omega_(i j)$ è un tensore antisimmetrico.

- $D_(i j)$: tensore delle deformazioni
- $Omega_(i j)$: tensore di vorticità

// [DA AUDIO]
Fisicamente, una particella fluida (volume infinitesimo) sottoposta a un gradiente di velocità subisce due atti di moto indipendenti:
- $D_(i j)$ descrive la *deformazione*, ovvero la variazione di forma del volume fluido;
- $Omega_(i j)$ descrive la *rotazione rigida* (come corpo solido) della particella fluida attorno ai tre assi coordinati.

Si può dimostrare che $tau_(i j)$ deve dipendere unicamente da $D_(i j)$:

// [DA AUDIO]
Il tensore di vorticità $Omega_(i j)$ non contribuisce al tensore degli sforzi viscosi $tau_(i j)$ per due argomenti fondamentali:
1. *Argomento fisico*: in un atto di pura rotazione rigida, a ogni trasporto di quantità di moto in un verso ne corrisponde uno simmetrico e opposto dal lato opposto; il flusso netto di quantità di moto trasferito per rotazione rigida è quindi nullo.
2. *Argomento teorico (invarianza del sistema di riferimento)*: le leggi costitutive della fisica devono essere oggettive, ovvero indipendenti da atti di moto rigido (sia di traslazione a velocità costante, sia di rotazione a velocità angolare costante) del sistema di riferimento. Se $tau_(i j)$ dipendesse da $Omega_(i j)$, gli sforzi dipenderebbero da un'eventuale rotazione del sistema di riferimento scelto.

$
tau_(i j) &= 2 mu D_(i j) \
overline(overline(tau)) &= 2 mu overline(overline(D))
$

// [DA AUDIO]
Esplicitando i gradienti di velocità, la relazione si scrive:

$ tau_(i j) = mu ((partial u_i)/(partial x_j) + (partial u_j)/(partial x_i)) = 2 mu underbrace(1/2 ((partial u_i)/(partial x_j) + (partial u_j)/(partial x_i)), D_(i j)) = 2 mu D_(i j) $

dove il fattore $2$ viene introdotto per compensare il coefficiente $1/2$ presente nella definizione di $D_(i j)$.

Equazione costitutiva dei fluidi newtoniani:

$
T_(i j) &= -p delta_(i j) + 2 mu D_(i j) \
overline(overline(sigma)) &= -p overline(overline(I)) + 2 mu overline(overline(D))
$

// [DA AUDIO]
Tale equazione costitutiva vale in senso stretto per fluidi incomprimibili (a densità costante, $rho = "cost"$); nel caso comprimibile comparirebbe un ulteriore termine legato alle variazioni di volume.

In forma matriciale estesa, il tensore degli sforzi completo è:

$ overline(overline(sigma)) = mat(
  -p + 2 mu D_(1 1), 2 mu D_(1 2), 2 mu D_(1 3);
  2 mu D_(2 1), -p + 2 mu D_(2 2), 2 mu D_(2 3);
  2 mu D_(3 1), 2 mu D_(3 2), -p + 2 mu D_(3 3)
) $

Si osserva che la pressione $p$ contribuisce esclusivamente agli sforzi normali (sulla diagonale principale), mentre il termine viscoso $2 mu D_(i j)$ contribuisce sia agli sforzi normali (diagonali) sia agli sforzi tangenziali (fuori diagonale).


= Calcolo il vettore vorticità

$
overline(overline(Omega)) &= mat(
  0, -Omega_3, Omega_2;
  Omega_3, 0, -Omega_1;
  -Omega_2, Omega_1, 0
) \
Omega_3 &= -1/2 ((partial u_1)/(partial x_2) - (partial u_2)/(partial x_1)) \
Omega_2 &= 1/2 ((partial u_1)/(partial x_3) - (partial u_3)/(partial x_1)) quad arrow.r.double quad arrow(Omega) = mat(Omega_1; Omega_2; Omega_3) \
Omega_1 &= -1/2 ((partial u_2)/(partial x_3) - (partial u_3)/(partial x_2))
$

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Nel caso specifico, l'unica componente non nulla è $Omega_3 = -U_e / (2 h)$. \
    Le particelle fluide hanno vorticità negativa, ruotano in senso orario.
  ],
  [
    #image("1753a06c-3b5c-4cb4-8343-a662a538e037-09_167_134_835_971.jpg", width: 70%)
  ]
)
#v(1em)

== Influenza della gravità sulla dinamica del moto nei fluidi a $rho = "cost"$

Possiamo sempre scrivere che:

$ p = p_(h s) + p^* $

- distribuzione "idrostatica" della pressione:

$ nabla p_(h s) = rho(z) arrow(g) $

- non necessariamente costante (!), ma può dipendere unicamente da $z$.

Pertanto $nabla p = nabla p_(h s) + nabla p^*$. \
Il termine $p^*(arrow(x))$ dipende invece dalle tre coordinate (e in principio anche dal tempo). \
Riprendo Navier-Stokes (N-S):

$
(D arrow(u))/(D t) &= -1/rho nabla p + arrow(g) + nu Delta arrow(u) \
-1/rho nabla (p_(h s) + p^*) + arrow(g) &= -1/rho nabla p_(h s) - 1/rho nabla p^* + arrow(g) = \
&= -1/rho (rho arrow(g)) - 1/rho nabla p^* + arrow(g) = -1/rho nabla p^* quad ("poiché" nabla p_(h s) = rho arrow(g))
$

Posso riscrivere N-S:

$ (D arrow(u))/(D t) = -1/rho nabla p^* + nu Delta arrow(u) $

1) scompare $arrow(g)$
2) la pressione cambia significato

== Esempio: Teoria della lubrificazione

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    1. Scrivere le equazioni di bilancio di quantità di moto e le condizioni al limite:
    - cercare una soluzione $arrow(u) = mat(u(y); 0; 0)$ e $p = p(x)$
    - mostrare che $G = (dif p)/(dif x) = "cost"$.
  ],
  [
    #image("1753a06c-3b5c-4cb4-8343-a662a538e037-11_717_1742_183_213.jpg", width: 70%)
  ]
)
#v(1em)

$
cases(
  rho ((partial arrow(u))/(partial t) + arrow(u) dot nabla arrow(u)) = -nabla p + mu Delta arrow(u),
  nabla dot arrow(u) = 0
)
$

Condizioni al contorno: $arrow(u) = (-U, 0, 0)$ per $y = 0$; $arrow(u) = 0$ per $y = e$. \
Cerchiamo una soluzione della forma $arrow(u) = mat(u(y); 0; 0)$ sapendo che $(partial arrow(u))/(partial t) = 0$:

$
arrow(u) dot nabla arrow(u) &= u_j (partial u_i)/(partial x_j) = (u_x partial/(partial x) + u_y partial/(partial y) + u_z partial/(partial z)) arrow(u) = \
&= 0 !
$

$
mu Delta arrow(u) &= mu ((partial^2 u)/(partial x^2) + (partial^2 u)/(partial y^2) + (partial^2 u)/(partial z^2), 0, 0) = mu ((dif^2 u)/(dif y^2), 0, 0) \
(partial p)/(partial y) &= (partial p)/(partial z) = 0 quad arrow.r.double quad p = p(x) \
(dif^2 u)/(dif y^2) &= (G(x))/mu \
f(y) &= f(x) = "cost" ! \
(dif^2 u)/(dif y^2) &= G/mu quad arrow.r.double quad (dif u)/(dif y) = G/(2 mu) y + A \
u &= G/(2 mu) y^2 + A y + B \
u(0) &= -U quad arrow.r.double quad B = -U \
u(e) &= 0 quad arrow.r.double quad 0 = G/(2 mu) e^2 + A e - U \
A &= U/e - (G e)/(2 mu) \
u(y) &= G/(2 mu) y^2 + (U/e - (G e)/(2 mu)) y - U \
u(y) &= U/e (y - e) + G/(2 mu) y (y - e)
$

Calcolo della portata $Q$:

$
Q &= integral_0^e u dif y = integral_0^e [U/e (y - e) + G/(2 mu) (y^2 - e y)] dif y = \
&= lr([U/e y^2/2 - U y]|)_0^e + lr([G/(6 mu) y^3 - (G e)/(4 mu) y^2]|)_0^e = \
&= (U e)/2 - U e + (G e^3)/(6 mu) - (G e^3)/(4 mu) = \
&= -1/2 U e - 1/12 (G e^3)/mu
$

Calcolo del tensore degli sforzi:

$
sigma_(i j) = -p delta_(i j) + tau_(i j) &= -p delta_(i j) + 2 mu D_(i j) = \
&= -p delta_(i j) + mu ((partial u_i)/(partial x_j) + (partial u_j)/(partial x_i))
$

Essendo $arrow(u) = (u(y), 0, 0)$:

$
sigma_(i j) &= mat(delim: "[",
  -p, tau, 0;
  tau, -p, 0;
  0, 0, -p
) \
tau &= mu (dif u)/(dif y) = mu U/e + G (y - 1/2 e)
$

$arrow.t$ Calcolo per gli studenti:

$ u(y) = underbrace(1/2 G/mu (y^2 - e y), "parabolica") + underbrace(U/e (y - e), "lineare") $

- a) $G = 0$:
  $ u(y) = U/e (y - e) $

- b) $G eq.not 0$:
  $
  u(y) &= 1/2 G/mu y^2 - 1/2 G/mu y e + (U y)/e - U = \
  &= 1/2 G/mu y^2 + y (U/e - 1/2 G/mu e) - U
  $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    - Caso $G = (dif p)/(dif x) < 0$: \
      si oppone al moto.
  ],
  [
    #image("1753a06c-3b5c-4cb4-8343-a662a538e037-14_541_1126_1597_770.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    - Caso $G = (dif p)/(dif x) > 0$: \
      sostiene il moto.
  ],
  [
    #image("1753a06c-3b5c-4cb4-8343-a662a538e037-14_522_968_2233_855.jpg", width: 70%)
  ]
)
#v(1em)

Forza per unità di superficie sulla parete inferiore ($y = 0$):

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ T_i = sigma_(i j) n_j $

    $
    mat(delim: "[",
      -p, tau_0, 0;
      tau_0, -p, 0;
      0, 0, -p
    ) mat(delim: "[", 0; 1; 0) &= mat(delim: "[", tau_0; -p; 0) \
    tau_0 = tau(y = 0) &= (mu U)/e - (G e)/2
    $
  ],
  [
    #image("1753a06c-3b5c-4cb4-8343-a662a538e037-15_252_646_343_1185.jpg", width: 70%)
  ]
)
#v(1em)

Sulla parete superiore ($y = e$):

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
    y &= e \
    F_i &= mat(delim: "[", -tau_e; p; 0)
    $

    con $tau_e = tau(y = e) = (mu U)/e + (G e)/2$.
  ],
  [
    #image("1753a06c-3b5c-4cb4-8343-a662a538e037-15_187_683_1579_1340.jpg", width: 70%)
    #v(0.5em)
    #image("1753a06c-3b5c-4cb4-8343-a662a538e037-15_329_460_2073_920.jpg", width: 70%)
  ]
)
#v(1em)

Analizziamo il rapporto tra le due componenti $p$ e $tau$; in termini di ordini di grandezza abbiamo:

$ tau = (mu U)/e + (G e)/2 tilde.op G e $

Valutiamo delle variazioni di pressione su una lunghezza $L >> e$:

$
(dif p)/(dif x) &tilde.op G tilde.op (Delta p)/L arrow.r Delta p tilde.op G L \
tau/p &tilde.op (G e)/(G L) tilde.op e/L tilde.op F_x / F_y
$

che rappresenta l'ordine di grandezza del coefficiente di attrito.

//pdf 6


= Energia meccanica nei fluidi viscosi

Il bilancio di energia cinetica si ottiene moltiplicando scalarmente l'equazione di Navier-Stokes per $u_i$:

$ u_i dot (rho (D u_i)/(D t)) = u_i dot (partial/(partial x_j) sigma_(i j) + rho g_i) $

Sviluppo a sinistra e includo $psi$, potenziale gravitazionale $g_i = -nabla psi = -partial/(partial x_i) psi$, essendo $psi = -g_i x_i = g x_3$:

$
  (D)/(D t) (frac(rho u^2, 2)) &= u_i dot (partial/(partial x_j) sigma_(i j) - rho (partial psi)/(partial x_i)) \
  partial/(partial t) (frac(rho u^2, 2)) &= -u_j partial/(partial x_j) (frac(rho u^2, 2)) - u_i rho (partial psi)/(partial x_i) + u_i (partial sigma_(i j))/(partial x_j)
$ <eq:bilancio_ec>

essendo $u^2 = u_1 u_1 + u_2 u_2 + u_3 u_3 = u_i dot u_i$.

Per un fluido ideale, non viscoso:

$ sigma_(i j) = -p delta_(i j) $

cosicché $u_i (partial sigma_(i j))/(partial x_j) = -u_i partial/(partial x_j) (p delta_(i j)) = -u_i (partial p)/(partial x_i)$.
Il bilancio di energia cinetica diviene:

$ partial/(partial t) (rho u^2 / 2) = -u_j partial/(partial x_j) [underbrace(rho u^2 / 2 + rho psi + p, cal(H): "carico")] $

Per un fluido viscoso (newtoniano) ho invece:

$ sigma_(i j) = -p delta_(i j) + tau_(i j) $

Cosa diviene il termine $u_i (partial sigma_(i j))/(partial x_j)$? (scritto in notazione vettoriale $arrow(u) dot (nabla dot bold(sigma))$)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Riscrivendo:
    $ u_i (partial sigma_(i j))/(partial x_j) = underbrace(partial/(partial x_j) (u_i sigma_(i j)), (A)) - underbrace(sigma_(i j) (partial u_i)/(partial x_j), (B)) $
    - *(A)* Operatore di divergenza $arrow.r$ termine di flusso!
    - *(B)* Termine di pozzo o sorgente.
  ],
  [
    #image("3cb734d7-9607-49d0-8970-a51574b61853-03_488_1612_259_222.jpg", width: 70%)
  ]
)
#v(1em)

Iniziamo a trattare *(B)* ricordando che $sigma_(i j) = -p delta_(i j) + 2 mu D_(i j)$. Attenzione (!), il passaggio non è immediato:

$ -sigma_(i j) (partial u_i)/(partial x_j) = p (partial u_j)/(partial x_j) - 2 mu D_(i j) D_(i j) $

Ricordiamo che:

$ (partial u_j)/(partial x_j) = -1/rho (D rho)/(D t) $

Il termine $2 mu D_(i j) D_(i j)$ è sempre positivo! (è un quadrato).

*(A)*

$
  partial/(partial x_j) (u_i sigma_(i j)) &= -partial/(partial x_j) (u_j p) + partial/(partial x_j) (u_i tau_(i j)) = \
  &= -p (partial u_j)/(partial x_j) - u_j (partial p)/(partial x_j) + partial/(partial x_j) (u_i tau_(i j))
$

Metto tutto insieme:

$
  u_i (partial sigma_(i j))/(partial x_j) &= underbrace(-p (partial u_j)/(partial x_j) - u_j (partial p)/(partial x_j) + partial/(partial x_j) (u_i tau_(i j)), (A)) + underbrace(p (partial u_j)/(partial x_j) - 2 mu D_(i j) D_(i j), (B)) = \
  &= -u_j (partial p)/(partial x_j) + partial/(partial x_j) (u_i tau_(i j)) - 2 mu D_(i j) D_(i j)
$

Il primo termine $-u_j (partial p)/(partial x_j)$ è il termine che avevamo anche prima, nel caso di fluido non viscoso, i.e. $sigma_(i j) = -p delta_(i j)$.

Gli altri due sono i termini aggiuntivi che si hanno a causa della viscosità.

Riscrivo l'eq:bilancio_ec:

$ partial/(partial t) (rho u^2 / 2) = -u_j partial/(partial x_j) [underbrace(rho u^2 / 2 + p + rho psi, cal(H))] - D + partial/(partial x_j) (u_i tau_(i j)) $

laddove:

$ D = 2 mu D_(i j) D_(i j) arrow.r.long "dissipazione viscosa (locale)" $

Faccio l'integrale su un volume di controllo $V$:

$ dif/(dif t) integral_V (rho u^2 / 2) dif V = -integral_V u_j (partial cal(H))/(partial x_j) dif V - underbrace(integral_V D dif V, D_v) + integral_V partial/(partial x_j) (u_i tau_(i j)) dif V $

Trasformo il $1 degree$ e $3 degree$ termine a destra in integrali di superficie:

$
  integral_V u_j (partial cal(H))/(partial x_j) dif V &= integral_V [partial/(partial x_j) (cal(H) u_j) - cal(H) underbrace((partial u_j)/(partial x_j), = 0 "se" rho = "cost"!)] dif V = \
  &= integral_V partial/(partial x_j) (cal(H) u_j) dif V = integral_S cal(H) u_j n_j dif S
$

Flusso di $cal(H)$ attraverso la superficie di controllo:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ integral_V partial/(partial x_j) (u_i tau_(i j)) dif V = integral_S u_i tau_(i j) n_j dif S = P_m $
    Questo termine rappresenta il lavoro fornito alla superficie $S$, in presenza di forti gradienti di velocità! Il bilancio di energia cinetica diviene dunque:
    $ dif/(dif t) integral_V rho u^2 / 2 dif V = -integral_S u_j cal(H) n_j dif S - D_v + P_m $
  ],
  [
    #image("3cb734d7-9607-49d0-8970-a51574b61853-06_630_1735_97_84.jpg", width: 70%)
  ]
)
#v(1em)

== Applicazione: moto in condotta in presenza di una macchina a fluido (turbina, pompa)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
      -integral_S arrow(u) cal(H) dot arrow(n) dif S &= -integral_(S_1) arrow(u) cal(H) dot arrow(n) dif S_1 - integral_(S_2) arrow(u) cal(H) dot arrow(n) dif S_2 + \
      &quad - integral_(S_m) arrow(u) cal(H) dot arrow(n) dif S_m = \
      &= Q_v cal(H)_1 - Q_v cal(H)_2
    $
    laddove $Q_v cal(H) = integral_S cal(H) arrow(u) dot arrow(n) dif S$ e il flusso di volume $Q_v = integral_S arrow(u) dot arrow(n) dif S$.
  ],
  [
    #image("3cb734d7-9607-49d0-8970-a51574b61853-07_584_1521_566_307.jpg", width: 70%)
  ]
)
#v(1em)

Considerando $dif/(dif t) = 0$:

$
  P_m - D_v &= integral_S arrow(u) cal(H) dot arrow(n) dif S = \
  &= Q_v [cal(H)_2 - cal(H)_1]
$

$cal(H)_1 - cal(H)_2 = Delta cal(H) arrow.r$ perdite di carico:

$ Delta cal(H) Q_v = D_v - P_m $

Nel caso in cui non ci sia potenza fornita $arrow.r P_m = 0$:

$ Delta cal(H) = D_v / Q_v $

dimostra la natura fisica delle perdite di carico $arrow.r.double$ dissipazione viscosa!

= Moto, dissipazione e perdite di carico in una condotta circolare: moto di Poiseuille

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Coordinate cilindriche $(r, theta, z)$.
    Cerchiamo una soluzione nella forma:
    $ arrow(u) = (0; 0; u(r)) $
    il che comporta che l'equazione di quantità di moto si riduce a:
    $
      cases(
        0 = -(partial p)/(partial r) = -1/r (partial p)/(partial theta),
        0 = -(partial p)/(partial z) + mu 1/r dif/(dif r) (r (dif u)/(dif r))
      )
    $
  ],
  [
    #image("3cb734d7-9607-49d0-8970-a51574b61853-09_366_1262_679_212.jpg", width: 70%)
    #image("3cb734d7-9607-49d0-8970-a51574b61853-09_451_793_1072_242.jpg", width: 70%)
    #image("3cb734d7-9607-49d0-8970-a51574b61853-09_333_811_1288_1204.jpg", width: 70%)
  ]
)
#v(1em)

Riguardo l'ultima equazione:

$ (dif p)/(dif z) = mu 1/r dif/(dif r) (r (dif u)/(dif r)) = G $

$G$ deve essere una costante.

$
  integral_0^r dif/(dif r) (r (dif u)/(dif r)) dif r &= integral_0^r G/mu r dif r \
  r (dif u)/(dif r) &= (G r^2)/(2 mu) + C
$

Per $r = 0$ (condizione sull'asse):

$ r (dif u)/(dif r) = (G r^2)/(2 mu) = 0 $

dunque $C = 0$.

$
  integral dif u &= G/(2 mu) integral r dif r \
  u &= (G r^2)/(4 mu) + B
$

Per $r = R$ (condizione di aderenza):

$
  u(r = R) = 0 &= (G R^2)/(4 mu) + B \
  B &= -(G R^2)/(4 mu) \
  u(r) &= G/mu (r^2 / 4 - R^2 / 4) = -(G R^2)/(4 mu) (1 - (r/R)^2) \
  u_0 = u(r = 0) &= -(G R^2)/(4 mu)
$

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Il profilo di velocità è parabolico con $u$ massima sull'asse della condotta.
    'Bulk' $arrow.r$ velocità media:
    $ u_d = 1/S underbrace(integral_S arrow(u) dot arrow(n) dif S, Q_v = "flusso in volume") = 1/(pi R^2) integral_0^R u(r) 2 pi r dif r $
  ],
  [
    #image("3cb734d7-9607-49d0-8970-a51574b61853-11_765_1089_1487_272.jpg", width: 70%)
  ]
)
#v(1em)

$
  Q_v &= 2 pi integral_0^R u(r) r dif r = 2 pi integral_0^R (G R^2)/(4 mu) [r^2 / R^2 - 1] r dif r = \
  &= (pi G R^2)/(2 mu) [r^4 / (4 R^2) - r^2 / 2]_0^R = (pi G R^2)/(2 mu) [R^2 / 4 - R^2 / 2] = \
  &= -(pi G R^2)/(2 mu) dot 1/4 R^2 = -pi/(8 mu) G R^4 \
  u_d &= Q_v / (pi R^2) = -(G R^2)/(8 mu) arrow.r.double u_d = u_0 / 2
$

da cui valuto il gradiente di pressione:

$ (dif p)/(dif z) = G = -(8 mu u_d)/R^2 $

Fissato $G$ ottengo $Q_v$ (e dunque $u_d$) e viceversa!

= Tensore degli sforzi viscosi

$ sigma_(i j) = -p delta_(i j) + tau_(i j) $

Nel caso specifico gli sforzi viscosi sono:

$
  tau_(i j) &= mat(0, tau_(r x), 0; tau_(x r), 0, 0; 0, 0, 0) wide & tau_(i j) &= 2 mu D_(i j) \
  tau_(r x) &= 2 mu 1/2 ((partial u_x)/(partial r) + (partial u_r)/(partial x)) wide & D_(i j) &= 1/2 ((partial u_i)/(partial x_j) + (partial u_j)/(partial x_i))
$

$ tau_(r x) = mu (partial u_x)/(partial r) $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
      u_x &= 2 u_d [1 - r^2 / R^2] \
      u_d &= -(G R^2)/(8 mu) \
      u(r) &= (G R^2)/(4 mu) [r^2 / R^2 - 1] \
      (dif u)/(dif r) &= (G r)/(2 mu)
    $
    Andamento di $tau_(r x)$ ($G$ è negativo!):
    $ tau_(r x) = (G r)/2 $
  ],
  [
    #image("3cb734d7-9607-49d0-8970-a51574b61853-13_618_930_2017_67.jpg", width: 70%)
  ]
)
#v(1em)

= Dissipazione e perdite di carico

$
  D &= 2 mu D_(i j) D_(i j) = 2 mu (D_(r x)^2 + D_(x r)^2) \
  u(r) &= 2 u_d [1 - r^2 / R^2] \
  D_(r x) = D_(x r) &= 1/2 [(partial u_x)/(partial r) + (partial u_r)/(partial x)] = \
  &= 1/2 dot 2 u_d (-(2 r)/R^2) = -u_d (2 r)/R^2 \
  D &= 2 mu [2 (u_d^2 4 r^2)/R^4] = (16 mu u_d^2)/R^4 r^2
$

$
  D_v &= 2 pi L integral_0^R ((16 mu u_d^2)/R^4 r^2) r dif r = \
  &= 2 pi L (16 mu u_d^2)/R^4 [r^4 / 4]_0^R = \
  &= 2 pi L (16 mu u_d^2)/R^4 R^4 / 4 = 8 pi L mu u_d^2 \
  Q_v &= -(pi G R^4)/(8 mu) \
  Delta cal(H) &= D_v / Q_v = (8 pi L mu u_d^2)/(-pi R^4 G) 8 mu = ((8 mu u_d)/R^2)^2 L/(-G) = -G L \
  lambda &= (Delta cal(H) \/ L)/(1/2 rho u_d^2 \/ D) = (-G)/(1/2 rho u_d^2 \/ D) = (8 mu u_d)/R^2 dot D/(1/2 rho u_d^2) = \
  &= (8 mu)/(D^2 \/ 4) dot D/(1/2 rho u_d) = 64 mu/(rho D u_d) = 64 / "Re"_D \
  "Re"_D &= (rho u_d D)/mu
$

= Applicazione: rendimento di una installazione idroelettrica

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Con $k = 2$:
    + Perdite di carico nella condotta:
      $
        Delta cal(H)_c &= lambda("Re") dot 1/2 rho u_d^2 L/D \
        u_d &= Q/S_c = (20 "m"^3/"s")/(pi (2^2 / 4)) = 6,366 "m/s" \
        Delta cal(H)_c &= 1,82 times 10^5 "Pa" equiv 18,6 "m"_("H"_2"O")
      $
  ],
  [
    #image("3cb734d7-9607-49d0-8970-a51574b61853-16_1061_1933_456_109.jpg", width: 70%)
  ]
)
#v(1em)

2. Perdite di carico nella turbina:
$
  Delta cal(H)_"TOT" &= Delta cal(H)_c + Delta cal(H)_T + Delta cal(H)_A = \
  &= 1/2 rho u_R^2 + rho g z_R + p_R - (1/2 rho u_E^2 + rho g z_E + p_E) = \
  &= rho g (z_R - z_E) = 1000 times 9,8 times 300 approx \
  &approx 3 times 10^6 "Pa"
$
$
  Delta cal(H)_T &= Delta cal(H)_"TOT" - Delta cal(H)_c - Delta cal(H)_A \
  Delta cal(H)_A &= k rho u_E^2 / 2 wide u_E = Q/S_E = 20/20 = 1 "m/s"
$
Con $k = 2$ e $rho = 10^3 "kg/m"^3$ ottengo $Delta cal(H)_A = 10^3 "Pa"$:
$
  Delta cal(H)_T &= 3 dot 10^6 - 1,82 dot 10^5 - 10^3 approx \
  &approx 280 "m"_("H"_2"O")
$

3. Calcolare la potenza in Megawatt della turbina, assumendo un rendimento di $eta = 0,9$:
$
  P &= eta Q Delta cal(H)_T = 49,7 "MW" \
  &= eta Q (rho g h - underbrace(Delta cal(H)_c - Delta cal(H)_A, "perdite"))
$

4. Ottimizzazione del sistema $arrow.r$ $Q$ ottimale?

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
      P &= A Q - B Q^3 \
      A &= eta rho g h \
      B &= 1/2 rho eta (lambda L/D 1/S_c^2 + k/S_A^2)
    $
    Intersezioni $P = Q (A - B Q^2)$:
    $P = 0$ per $Q = 0$ e $Q = (A/B)^(1/2)$.
    Massimo $(dif P)/(dif Q) = A - 3 B Q^2 = 0$:
    $ arrow.r.long Q = (A/(3 B))^(1/2) = Q_"max" $
  ],
  [
    #image("3cb734d7-9607-49d0-8970-a51574b61853-18_711_1055_2122_369.jpg", width: 70%)
  ]
)
#v(1em)

$
  P_"max" &= 2/3 (A^3 / (3 B))^(1/2) \
  A &= 2,65 times 10^6 \
  B &= 413
$
$
  arrow.r.long cases(
    Q_"max" = 46,3 "m"^3/"s",
    P_"max" = 81,7 "MW"
  )
$

== Esempio: perdite di carico in condotta

Olio $arrow.r mu = 2 dot 10^(-2) "kg"/("m" dot "s")$, $rho = 900 "kg/m"^3$.
Diametro $d = 2 "cm"$; lunghezza $L = 20 "m"$.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
      lambda = cases(
        64 / "Re"_D & "laminare",
        0,3164 "Re"_D^(-1/4) & "turbolento (Blasius)"
      )
    $
    Calcolare $Delta p$ lungo $L$:
    $
      arrow.r.squiggly Delta p_1 &= 0,34 "bar" \
      arrow.r.squiggly Delta p_2 &= 54 "bar"
    $
  ],
  [
    #image("3cb734d7-9607-49d0-8970-a51574b61853-19_483_963_2207_26.jpg", width: 70%)
  ]
)

// pdf 7

= Equazione globale della meccanica dei fluidi

$
rho (D u_i) / (D t) &= rho g_i + partial / (partial x_j) T_(i j) \
T_(i j) &= -p delta_(i j) + tau_(i j)
$

$
tau_(i j) = 2 mu D_(i j) quad D_(i j) = 1/2 ( (partial u_i) / (partial x_j) + (partial u_j) / (partial x_i) )
$

$arrow.r$ se assumo che $(partial u_j) / (partial x_j) = 0$, cioè per l'equazione di continuità:

$
rho (D u_i) / (D t) &= rho (partial u_i) / (partial t) + rho u_j (partial u_i) / (partial x_j) = \
&= partial / (partial t) (rho u_i) - u_i (partial rho) / (partial t) + partial / (partial x_j) (rho u_i u_j) - u_i partial / (partial x_j) (rho u_j) = \
&quad - u_i underbrace(( (partial rho) / (partial t) + partial / (partial x_j) (rho u_j) ), = 0) \
&= partial / (partial t) (rho u_i) + partial / (partial x_j) (rho u_i u_j)
$

$
integral_V partial / (partial t) (rho u_i) dif V + integral_V partial / (partial x_j) (rho u_i u_j) dif V - integral_V partial / (partial x_j) T_(i j) dif V - integral_V rho g_i dif V = 0
$

Uso il teorema di Gauss: $integral_V partial / (partial x_j) F_(i j) dif V = integral_S F_(i j) n_j dif S$
e cambio segno:

$
underbrace(integral_V rho g_i dif V, arrow(G)) + underbrace(integral_S T_(i j) n_j dif S, arrow(Pi)) - underbrace(integral_S rho u_i u_j n_j dif S, arrow(M)) - underbrace(integral_V partial / (partial t) (rho u_i) dif V, arrow(I)) = 0 quad ==> quad arrow(G) + arrow(Pi) + arrow(M) + arrow(I) = 0
$

Analisi di $arrow(I)$:
- se $arrow(I) > 0 quad (partial arrow(u)) / (partial t) < 0 quad$ rallenta
- se $arrow(I) < 0 quad (partial arrow(u)) / (partial t) > 0 quad$ accelera

Analisi di $arrow(M)$:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
    arrow(M) = M_i &= -integral_S rho u_i u_j n_j dif S = \
    &= underbrace(integral_(S_1) rho u_i abs(u_j) dif S_1, arrow(M)_"in") - underbrace(integral_(S_2) rho u_i abs(u_j) dif S_2, arrow(M)_"out") + integral_(S_p) rho u_i underbrace(u_j n_j, = 0) dif S
    $
    ovunque alla parete.
  ],
  [
    #image("04e73b15-c902-4152-a68f-147f1a1b72b6-03_579_1742_269_200.jpg", width: 70%)
  ]
)
#v(1em)

$
arrow(n) quad arrow.l.r.double quad arrow(u) ==> M_i &= -integral_S rho u_i u_j n_j dif S \
&= integral_(S_1) rho u^2 dif S = M_(x, "in")
$

$
abs(arrow(M)_"in") = beta rho U_d^2 S quad "con" quad beta = (integral_S rho u^2 dif S) / (rho U_d^2 S) \
U_d = 1/S integral_S u dif S quad "velocità media" = Q/S
$

Analisi di $arrow(Pi)$:

$
arrow(Pi) = arrow(Pi)_1 + arrow(Pi)_2 + arrow(Pi)_p
$

$
(Pi_1)_i &= integral_(S_1) T_(i j) n_j dif S_1 quad T_(i j) = -p delta_(i j) + tau_(i j) \
tau_(i j) &prop (partial u_i) / (partial x_j) arrow.r 0 quad T_(i j) = -p delta_(i j) \
(Pi_1)_i &= integral_(S_1) -p delta_(i j) n_j dif S_1 = -integral_(S_1) p n_i dif S_1 \
Pi_(1, x) &= p_1 S_1 = Pi_"in" \
(Pi_2)_i &= -integral_(S_2) p n_i dif S_2 \
Pi_(2, x) &= -p_2 S_2 = -Pi_"out"
$

$arrow(Pi)_p ==> arrow(F)$ esercitata dalle pareti.

All'interno del "tubo" si ha dunque:

$
arrow(M) + arrow(Pi) = 0
$

$
M_"in" &= M_(x, 1) quad M_"out" = M_(x, 2) \
(M_(x, 1) - M_(x, 2)) &+ (Pi_(x, 1) - Pi_(x, 2)) + F_x = 0 \
F_x &= -[(M_(x, 1) - M_(x, 2)) + (Pi_(x, 1) - Pi_(x, 2))] = \
&= -[beta rho U_d^2 (S_1 - S_2) + (p_1 S_1 - p_2 S_2)]
$

Se la sezione non varia $S_1 = S_2 = S$:

$
F_x = -S (p_1 - p_2)
$

La forza è negativa, è la forza esercitata dalla parete sul fluido, ovvero la resistenza al deflusso del liquido (o gas).

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Questa forza $F_x$ è l'integrale degli sforzi viscosi $tau_w$ lungo la parete della condotta. In condizioni stazionarie:
    $
    p(x_1) S_1 - p(x_2) S_2 &= S_w tau_w \
    S [p(x_1) - p(x_1) - (partial p) / (partial x) Delta x] &= 2 pi R L tau_w \
    -pi R^2 (Delta p) / L dot L = 2 pi R L tau_w &==> tau_w = -(Delta p) / (2 L) R \
    F_x = -pi R^2 Delta p = tau_w 2 pi R L &==> tau_w = -(Delta p) / (2 L) R
    $
  ],
  [
    #image("04e73b15-c902-4152-a68f-147f1a1b72b6-06_384_1177_138_346.jpg", width: 70%)
  ]
)
#v(1em)

Posso anche esprimere $tau_w$ in funzione di un coefficiente d'attrito:

$
tau_w = -1/2 rho c_f U_d^2 <==> -(Delta p) / (2 L) R = tau_w
$

poiché $Delta p = Delta H$:

- e $psi = (Delta H / L) / (1/2 rho U_d^2 / D) quad ==> quad c_f = psi / 4$

Occhio alle normali!

== Esempio 1

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
    partial / (partial t) = 0 ==> arrow(I) = 0
    $
    Considero lungo $x$, dunque $arrow(G) = 0$:
    $
    M_"in" - M_"out" + Pi_"in" - Pi_"out" + F_x = 0
    $
    $
    rho beta U_1^2 S_1 - rho beta U_2^2 S_2 + p_1 S_1 - p_2 S_2 + F_x &= 0 \
    F_x = p_2 S_2 - p_1 S_1 + rho beta (S_2 U_2^2 - S_1 U_1^2) & \
    Q = S_1 U_1 = S_2 U_2 quad S_1 U_1^2 = Q U_1 = Q dot Q / S_1 &= Q^2 / S_1 \
    F_x = -[(p_1 S_1 - p_2 S_2) + rho beta Q^2 (1/S_1 - 1/S_2)] &
    $
  ],
  [
    #image("04e73b15-c902-4152-a68f-147f1a1b72b6-07_394_933_273_142.jpg", width: 70%)
  ]
)
#v(1em)

Il modulo della forza fluido-parete è uguale e opposto, si oppone al deflusso del fluido.

== Esempio 2

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
    G_x &= 0 ; quad M_("in", x) = rho Q U_1 = rho Q^2 / h_1 \
    M_("out", x) &= rho Q U_2 = rho Q^2 / h_2 \
    Pi_"in" &= 1/2 gamma h_1^2 quad Pi_"out" = 1/2 gamma h_2^2 \
    M_"in" &- M_"out" + Pi_"in" - Pi_"out" + F_p = 0 \
    F_p &= -[gamma / 2 (h_1^2 - h_2^2) + rho Q^2 (1/h_1 - 1/h_2)]
    $
  ],
  [
    #image("04e73b15-c902-4152-a68f-147f1a1b72b6-08_684_1331_206_36.jpg", width: 70%)
  ]
)
#v(1em)

== Esempio 3

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
    G_x &= 0 \
    I &= 0 \
    M_"in" &= rho Q U = rho Q^2 / A \
    M_"out" &= 0
    $
    $
    F_x = -rho Q^2 / A
    $
  ],
  [
    #image("04e73b15-c902-4152-a68f-147f1a1b72b6-09_818_1171_280_44.jpg", width: 70%)
  ]
)
#v(1em)

== Esempio 4

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
    G_x &= 0 \
    I_x &= 0 \
    M_("in", x) &= rho Q u_1 \
    M_("out", x) &= -2 rho Q / 2 u_2
    $
    $
    rho Q u_1 - (-2 rho Q / 2 u_2) + F_x = 0
    $
    $
    abs(F_x) &= rho Q u_1 + 2 rho Q / 2 u_2 \
    arrow(F)_x &= -abs(F_x) arrow(e)_x
    $
  ],
  [
    #image("04e73b15-c902-4152-a68f-147f1a1b72b6-09_654_916_1451_79.jpg", width: 70%)
  ]
)
#v(1em)

Questo stesso metodo si può usare per valutare la forza esercitata sul fluido da un corpo tozzo in una corrente esterna $u_infinity$:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
    F_x = -[(M_(x, 1) - M_(x, 2)) + (Pi_(x, 1) - Pi_(x, 2))]
    $
    Entrambi i termini possono essere misurati con un tubo di Pitot, evitando complicate misure sulla parete del corpo tozzo.
  ],
  [
    #image("04e73b15-c902-4152-a68f-147f1a1b72b6-10_738_1950_761_25.jpg", width: 70%)
  ]
)
#v(1em)

$
arrow(F) = integral_S bold(T) dot arrow(n) dif S = integral_S (-p delta_(i j) n_j + tau_(i j) n_j) dif S
$

//pdf 8

= Analisi dimensionale

== Teorema $pi$ o di Buckingham

- Considero una grandezza che dipende da $n$ parametri di controllo (indipendenti!)
- Questi $n$ parametri dipendono da $r$ dimensioni (indipendenti)
$
  a = f_1 (a_1, a_2, dots.h, a_n ; d_1, d_2, dots.h, d_r)
$
- Posso riscrivere questa relazione in termini adimensionali, in funzione di $(n-r)$ parametri.
$
  pi = f_2 (pi_1, pi_2, dots.h, pi_(n-r))
$

- Ho ridotto il numero di grandezze, da $n$ a $(n-r)$
- $pi_i arrow.r$ parametri adimensionali con significato fisico
- Mi affranco dalle unità di misura, del tutto arbitrarie
- Attenzione: non so nulla a priori della relazione funzionale $f_2 arrow.r$ prove sperimentali.

== Esempio di Taylor

$
  cases(
    delim: "}",
    r_f = f(E, rho_0, t),
    [E] = M L / T^2 L = M L^2 T^(-2) \; quad [rho_0] = M L^(-3) \; quad [t] = T,
    n = 3,
    r = 3
  ) quad n - r = 0 quad arrow.r quad pi = "cost."
$

$
  (r_f) / (E^alpha rho_0^beta t^gamma) = "costante" <==> "Raggio adimensionato", R^* .
$

$
  & r_f prop E^alpha rho_0^beta t^gamma \
  & [L] tilde.op M^alpha L^(2 alpha) / T^(2 alpha) M^beta / L^(3 beta) T^gamma \
  & cases(
      alpha + beta = 0,
      2 alpha - 3 beta = 1,
      gamma - 2 alpha = 0
    ) arrow.r cases(
      alpha = -beta,
      -2 beta - 3 beta = 1,
      gamma = 2 alpha
    ) arrow.r cases(
      beta = -1/5,
      alpha = 1/5,
      gamma = 2/5
    ) \
  & r_f = R^* ((E t^2) / rho_0)^(1/5) arrow.r (r_f (t_2)) / ((E t_2^2) / rho_0)^(1/5) = dots.h = (r_f (t_1)) / ((E t_1^2) / rho_0)^(1/5)
$

Conoscendo l'evoluzione della "palla di fuoco" $r_f (t)$ con le foto, Taylor ha stimato la potenza della bomba.

== Coefficiente di resistenza aerodinamica

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
      rho, mu quad F_D = arrow(F) dot hat(i)
    $

    $
      F_D = f underbrace((U_infinity, rho, mu , D), n = 4)
    $

    $
      & [U_infinity] = L / T quad [mu] = M / (L T) quad [rho] = M / L^3 quad [D] = L \
      & r = 3 \
      & (n - 3) = 1 ==> "Re" = (rho U_infinity D) / mu \
      & (F_D) / (1/2 rho U_infinity^2 D^2) = C_D = C_D ("Re") \
      & (F_D) / (mu U_infinity D) = k = k("Re")
    $
  ],
  [
    #image("8f76413d-40a2-4d00-94f5-9372a6e5c576-04_511_178_405_170.jpg", width: 70%)
    #v(0.5em)
    #image("8f76413d-40a2-4d00-94f5-9372a6e5c576-04_266_736_503_1265.jpg", width: 70%)
  ]
)
#v(1em)

=== Interpretazione fisica del numero di Reynolds

$
  rho (partial arrow(u)) / (partial t) + underbrace(rho arrow(u) dot nabla arrow(u), rho_0 U_infinity^2 / D \ "Convezione di q.tà di moto (inerzia)") = -nabla p + underbrace(mu Delta arrow(u), mu U_infinity / D^2 \ "Diffusione")
$

$
  "Re" & = "convezione" / "diffusione" = (rho_0 U_infinity^2 / D) / (mu U_infinity / D^2) = \
       & = U_infinity / (nu / D) = "velocità convettiva" / "velocità diffusiva"
$

== Studio dei regimi di moto al variare di Re

- Voglio dare una rappresentazione adimensionata delle equazioni di Navier-Stokes
- Devo identificare delle scale caratteristiche del problema:
  - scala delle velocità: $U_infinity$
  - scala delle lunghezze: $a$
  - scala dei tempi:
    $
      a / U_infinity & - "convettiva" \
      a^2 / nu & - "diffusiva"
    $
  - scala delle pressioni:
    $
      rho U_infinity^2 & - "convettiva" \
      (mu U_infinity) / a & - "diffusiva"
    $

=== Regimi di moto a basso Re

$arrow.r$ Scale di tempo e pressione imposte dai fenomeni diffusivi:
$
  cases(
    u_i = U_infinity tilde(u)_i \; quad x_i = a tilde(x)_i,
    t = a^2 / nu tilde(t) \; quad p = (mu U_infinity) / a tilde(p)
  )
$
$tilde(u)_i, tilde(x)_i, tilde(t), tilde(p)$ sono grandezze adimensionate.
$
  (partial u_i) / (partial t) + u_j (partial u_i) / (partial x_j) = - 1 / rho (partial p) / (partial x_i) + nu (partial^2 u_i) / (partial x_j^2)
$
Sostituendo e dividendo tutto per $(U_infinity nu) / a^2$ ottengo che:
$
  & (partial tilde(u)_i) / (partial tilde(t)) + "Re" tilde(u)_j (partial tilde(u)_i) / (partial tilde(x)_j) = - (partial tilde(p)) / (partial tilde(x)_i) + (partial^2 tilde(u)_i) / (partial tilde(x)_j^2) \
  & "Re" = (U_infinity a) / nu
$

Posso fare la stessa cosa per l'equazione di continuità:
$
  (partial u_i) / (partial x_i) = 0 ==> U_infinity / a (partial tilde(u)_i) / (partial tilde(x)_i) = 0 ==> (partial tilde(u)_i) / (partial tilde(x)_i) = 0
$
che rimane formalmente identica.

- Nel caso in cui $"Re" arrow.r 0$:
$
  cases(
    (partial tilde(u)_i) / (partial tilde(x)_i) = 0,
    (partial tilde(u)_i) / (partial tilde(t)) = - (partial tilde(p)) / (partial tilde(x)_i) + (partial^2 tilde(u)_i) / (partial tilde(x)_j^2)
  )
$
Problema di Stokes: il campo di moto diviene indipendente dal numero di Reynolds.

- Mi concentro ora sulla forza esercitata dal fluido sul corpo:
$
  F_i & = integral_S (-p delta_(i j) + tau_(i j)) n_j dif S = \
      & = integral_S (-p n_i + tau_(i j) n_j) dif S
$

La riscrivo usando le variabili adimensionate:
$
  F_i & = a^2 pi integral_(tilde(S)) (- (mu U_infinity) / a tilde(p) n_i + (mu U_infinity) / a tilde(tau)_(i j) n_j) dif tilde(S) = \
      & = mu U_infinity a underbrace(lr({ pi integral_(tilde(S)) -tilde(p) n_i dif tilde(S) + pi integral_(tilde(S)) tilde(tau)_(i j) n_j dif tilde(S) }), k)
$

Per $"Re" arrow.r 0$, il primo termine vale $2 pi hat(i)$ e il secondo $4 pi hat(i)$:
$
  F_i = mu U_infinity a 6 pi hat(i)
$

Più in generale, per $"Re" tilde.op 1$:
$
  F_i = mu U_infinity a underbrace(k("Re"), "integrale tra parentesi graffe") hat(i)
$

=== Regimi ad alti numeri di Reynolds ($"Re" >> 1$)

$
  u_i = U_infinity tilde(u)_i \; quad x_i = a tilde(x)_i \; quad t = a / U_infinity tilde(t) \; quad p = rho U_infinity^2 tilde(p)
$

Sostituisco nell'equazione di N-S e ottengo che:
$
  cases(
    (partial tilde(u)_i) / (partial tilde(t)) + tilde(u)_j (partial tilde(u)_i) / (partial tilde(x)_j) = - (partial tilde(p)) / (partial tilde(x)_i) + 1 / "Re" (partial^2 tilde(u)_i) / (partial tilde(x)_j^2),
    (partial tilde(u)_i) / (partial tilde(x)_i) = 0
  )
$

Per $"Re" arrow.r infinity$ il problema (la formulazione dell'equazione) diventa simile a quello di un fluido non-viscoso!

Valuto nuovamente la forza:
$
  F_i & = pi a^2 integral_(tilde(S)) -rho U_infinity^2 tilde(p) n_i dif tilde(S) + pi a^2 integral_(tilde(S)) (mu U_infinity) / a tilde(tau)_(i j) n_j dif tilde(S) = \
      & = rho a^2 U_infinity^2 pi underbrace(integral_(tilde(S)) (-tilde(p) n_i + 1 / "Re" tilde(tau)_(i j) n_j) dif tilde(S), 1/2 C_D hat(i))
$

$
  F_i = (1/2 pi rho a^2 U_infinity^2 C_D, 0, 0)
$

Il valore dell'integrale è detto $C_D$ "coefficiente di resistenza" e dipende dal numero di Reynolds (entrambi i termini!).

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
      F_D = mu a U_infinity k = 6 pi mu a U_infinity & quad "Re" < 1 \
      F_D = 1/2 rho a^2 pi C_D U_infinity^2 & quad "Re" >> 1
    $

    Nel regime intermedio in cui valgono entrambe:
    $
      1/2 rho a^2 pi C_D U_infinity^2 = 6 pi mu a U_infinity \
      C_D = 24 / "Re" arrow.l "regime per bassi numeri di Reynolds"
    $
  ],
  [
    #image("8f76413d-40a2-4d00-94f5-9372a6e5c576-11_604_1518_2160_53.jpg", width: 70%)
  ]
)
#v(1em)

= Strato limite

Forma approssimata delle equazioni di N-S.

Definizione: regione prossima ad una parete dove sono concentrati i gradienti di velocità (e, eventualmente, temperatura).

Consideriamo $partial / (partial t) = 0 arrow.r$ moto stazionario:
$
  arrow(u) dot nabla arrow(u) = - 1 / rho nabla p + nu Delta arrow(u)
$

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Campo di moto uniforme incidente.

    Il bordo superiore dello strato limite, $delta(x_1)$, aumenta con la coordinata longitudinale. Si ha in ogni caso che $delta(x_1) << L ==> $ separazione di scale.
  ],
  [
    #image("8f76413d-40a2-4d00-94f5-9372a6e5c576-12_582_408_1450_464.jpg", width: 70%)
    #v(0.5em)
    #image("8f76413d-40a2-4d00-94f5-9372a6e5c576-12_773_1164_1305_877.jpg", width: 70%)
  ]
)
#v(1em)

Vediamo cosa implica la separazione di scale sulle equazioni:

+ Equazione di continuità:
$
  & (partial u_1) / (partial x_1) + (partial u_2) / (partial x_2) = 0 \
  & U_e / L tilde.op u_2 / delta ==> u_2 tilde.op U_e delta / L
$
$==>$ La velocità verticale è molto inferiore alla velocità longitudinale.

+ Equazione di N-S:
$==>$ Componente lungo $x_1$:
$
  & u_1 (partial u_1) / (partial x_1) + u_2 (partial u_1) / (partial x_2) = - 1 / rho (partial P) / (partial x_1) + nu ((partial^2 u_1) / (partial x_1^2) + (partial^2 u_1) / (partial x_2^2)) \
  & underbrace(U_e^2 / L + U_e delta / L U_e / delta, U_e^2 / L) tilde.op pi_x / (rho L) + underbrace(nu U_e / L^2 << nu U_e / delta^2, "termini viscosi")
$

Si noti la differenza di entità tra i due termini viscosi: il secondo è molto più grande del primo, che è perciò trascurabile.

$
  u_1 (partial u_1) / (partial x_1) + u_2 (partial u_1) / (partial x_2) & = - 1 / rho (partial P) / (partial x_1) + nu (partial^2 u_1) / (partial x_2^2) \
  U_e^2 / L & tilde.op pi_x / (rho L) tilde.op nu U_e / delta^2
$

Se questi termini hanno lo stesso ordine di grandezza $==>$ allora ho che:

a) $U_e^2 / L tilde.op nu U_e / delta^2 ==> nu / (U_e L) tilde.op (delta / L)^2$
$
  delta / L tilde.op ("Re"_L)^(-1/2) quad "con" quad "Re"_L = (U_e L) / nu
$
ovvero, lo spessore dello strato limite diminuisce all'aumentare del parametro $"Re"$, il numero di Reynolds.

b) $pi_x / (rho L) tilde.op U_e^2 / L ==> pi_x tilde.op rho U_e^2$
Ordine di grandezza delle variazioni di pressione lungo $x_1$.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $==>$ Componente lungo $x_2$:

    Valuto l'entità del termine di pressione:
    $
      pi_y / (rho delta) tilde.op U_e^2 delta / L^2 ==> pi_y tilde.op rho U_e^2 delta^2 / L^2 << pi_x
    $
    Le variazioni di pressione lungo $x_2$ sono trascurabili: la seconda equazione si riduce a $(partial P) / (partial x_2) = 0$.
  ],
  [
    #image("8f76413d-40a2-4d00-94f5-9372a6e5c576-15_945_1839_1140_165.jpg", width: 70%)
  ]
)
#v(1em)

= Moto di caduta in regime laminare - Stokes

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
      cases(
        arrow(u) dot nabla arrow(u) = - 1 / rho nabla p + nu Delta arrow(u),
        nabla dot arrow(u) = 0,
        arrow(u) = 0 quad & abs(arrow(x)) = a,
        arrow(u) arrow.r U_infinity quad & abs(arrow(x)) arrow.r infinity,
        p arrow.r p_infinity quad & abs(arrow(x)) arrow.r infinity
      )
    $

    $
      arrow(F) = integral_S (-p arrow(n) + 2 mu bold(D) dot arrow(n)) dif S
    $
  ],
  [
    #image("8f76413d-40a2-4d00-94f5-9372a6e5c576-16_791_767_406_1217.jpg", width: 70%)
  ]
)
#v(1em)

Considero la forza di resistenza:
$
  F_D = arrow(F) dot hat(i)_x quad hat(i)_x = (1, 0, 0)
$
Sappiamo che, per bassi Reynolds:
$
  F_D = mu U_infinity a k("Re")
$

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    In regime stazionario ($partial / (partial t) = 0$):
    $
      P & = 4/3 pi rho_s a^3 g \
      F_A & = 4/3 pi rho a^3 g quad arrow.t "Archimede"
    $

    $
      & F_A + F_D = P \
      & F_D = P - F_A = 4/3 pi a^3 g (rho_s - rho) \
      & mu U_infinity a k("Re") = 4/3 pi a^3 g (rho_s - rho) \
      & U_infinity = 4/3 pi (a^2 g (rho_s - rho)) / (mu k("Re"))
    $

    Per $"Re" arrow.r 0$, $k = 6 pi$:
    $
      U_infinity = (2 a^2 g (rho_s - rho)) / (9 mu)
    $
  ],
  [
    #image("8f76413d-40a2-4d00-94f5-9372a6e5c576-17_599_356_299_1516.jpg", width: 70%)
  ]
)
#v(1em)

// pdf 9
= Campi irrotazionali

Densità costante $rho = "cost"$.

Si assume che la vorticità del campo fluido vale $arrow.r arrow(omega) = nabla times arrow(u) = 0$. Il campo di moto è dunque irrotazionale ed ha la proprietà tale per cui

$ arrow(u) = nabla Phi(arrow(x), t) $

$Phi arrow.r$ funzione scalare nello spazio e tempo.

Vediamo come si semplifica l'equazione di Navier-Stokes:

$ (partial arrow(u)) / (partial t) + arrow(u) dot nabla arrow(u) = - 1 / rho nabla p + arrow(g) + nu Delta arrow(u) $

Assumo che

$ arrow(g) = - nabla chi quad ; quad chi = - arrow(g) dot arrow(x) $

potenziale gravitazionale.

- Il termine non-lineare si può esprimere come
  $ arrow(u) dot nabla arrow(u) = nabla (1 / 2 u^2) + arrow(omega) times arrow(u) $
  è un'identità vettoriale.
  Poiché $arrow(omega) = 0$, $arrow(u) dot nabla arrow(u) = nabla (u^2 / 2)$.

- Termine viscoso:
  $
    nu Delta arrow(u) &= nu Delta (nabla Phi) = nu nabla (Delta Phi) \
    "Ma" quad Delta Phi &= nabla dot nabla Phi = nabla dot (arrow(u)) = 0
  $
  $arrow.r$ Il termine viscoso è identicamente nullo! (divergenza nulla poiché $rho = "cost"$).

- Assumendo $partial / (partial t) = 0$ ottengo che N-S si riduce a
  $
    arrow(u) dot nabla arrow(u) &= - 1 / rho nabla p + arrow(g) + nu Delta arrow(u) \
    nabla (1 / 2 u^2) &= - 1 / rho nabla p - nabla chi
  $
  ovvero che
  $ nabla (underbrace(1 / 2 rho u^2 + p + rho chi, H)) = 0 ==> "in tutto il campo!" $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Campo di moto attorno ad una sfera
  ],
  [
    #image("dd564104-7c88-49b3-8aa7-fc7d01e14c7c-03_325_1555_188_202.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $"Re" tilde.op 1 div 20$

    $ 1 / 2 rho u^2 + p = "cost" $
  ],
  [
    #image("dd564104-7c88-49b3-8aa7-fc7d01e14c7c-03_342_1090_650_775.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Distacco.
  ],
  [
    #image("dd564104-7c88-49b3-8aa7-fc7d01e14c7c-03_838_1067_1086_285.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $"Re" tilde.op 40 div 50$
  ],
  [
    #image("dd564104-7c88-49b3-8aa7-fc7d01e14c7c-03_633_486_1701_1482.jpg", width: 70%)
    #image("dd564104-7c88-49b3-8aa7-fc7d01e14c7c-03_414_1761_2259_68.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ x(t) = A sin(omega t + phi) $

    $ f tilde.op 1 / tau quad ==> quad "St" = (f D) / u_e = 0.2 $

    $ A(omega) = integral_(-infinity)^(+infinity) x(t) e^(-i omega t) dif t $
  ],
  [
    #image("dd564104-7c88-49b3-8aa7-fc7d01e14c7c-04_436_1042_29_308.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $arrow.t$ parte reale $A(omega)$

    per $"Re" > 200$
  ],
  [
    #image("dd564104-7c88-49b3-8aa7-fc7d01e14c7c-04_339_503_1015_1489.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ u(t) = 1 / (2 pi) integral_(-infinity)^(+infinity) A(omega) e^(i omega t) dif omega $
  ],
  [
    #image("dd564104-7c88-49b3-8aa7-fc7d01e14c7c-04_709_1690_1534_270.jpg", width: 70%)
  ]
)
#v(1em)

= Turbolenza

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
      i &arrow.r f(u_i ; x_i, t) \
      p(u') &= 1 / (sqrt(2 pi) sigma) exp(- xi^2 / (2 sigma^2))
    $

    $ integral_(-infinity)^(+infinity) p(u') dif u' = 1 $

    $ overline(u'^n) = integral_(-infinity)^(+infinity) xi^n p(u') dif u' $
  ],
  [
    #image("dd564104-7c88-49b3-8aa7-fc7d01e14c7c-05_480_687_226_1322.jpg", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: center + horizon,
  [
    $
      lr(< u(x_i, t) >) &= lim_(N -> oo) 1/N sum_(i=1)^N u^((i))(x_i, t) \
      overline(u)(x_i, t) &= lim_(T -> oo) 1/T integral_(t_0)^(t_0 + T) f(x_i, t') dif t'
    $
  ],
  [
    #image("dd564104-7c88-49b3-8aa7-fc7d01e14c7c-05_539_1303_2012_288.jpg", width: 70%)
  ]
)
#v(1em)

Per qualsiasi variabile, possiamo scrivere:

$
  f = overline(F) + f' \
  overline(overline(F)) = overline(F) quad overline(f') = 0 quad overline((partial F) / (partial x)) = (partial overline(F)) / (partial x)
$

$
  (f dot g) &= (overline(F) + f')(overline(G) + g') = overline(F) thin overline(G) + overline(F) g' + f' overline(G) + f' g' \
  overline(f g) &= overline(F) thin overline(G) + overline(f' g') \
  overline((partial (overline(u_i) + u'_i)) / (partial x_i)) &= 0 quad ==> (partial overline(u_i)) / (partial x_i) = 0 quad ; quad (partial u'_i) / (partial x_i) = 0
$

$
  (partial (rho u_i)) / (partial t) + partial / (partial x_j) (rho u_i u_j) &= - (partial p) / (partial x_i) + (partial tau_(i j)) / (partial x_j) , quad tau_(i j) = 2 mu D_(i j) \
  u_i = overline(u)_i + u'_i quad &; quad p = overline(P) + p' quad ; quad tau_(i j) = overline(tau_(i j)) + tau'_(i j) \
  (partial (rho overline(u)_i)) / (partial t) + partial / (partial x_j) (rho overline(u)_i overline(u)_j) &= - (partial overline(P)) / (partial x_i) + partial / (partial x_j) (overline(tau)_(i j) - rho overline(u'_i u'_j)) \
  partial / (partial x_j) overline(tau)_(i j) &= mu partial / (partial x_j) ((partial overline(u)_i) / (partial x_j) + (partial overline(u)_j) / (partial x_i)) = mu (partial^2 overline(u)_i) / (partial x_j^2)
$

$
  - rho overline(u'_i u'_j) &= 2 mu_t overline(D_(i j)) - 2 / 3 rho k_t delta_(i j) \
  &= mu_t ((partial overline(u_i)) / (partial x_j) + (partial overline(u_j)) / (partial x_i)) - 2 / 3 rho k_t delta_(i j) \
  - rho overline(u'_i u'_i) &= mu_t ((partial overline(u)_i) / (partial x_i) + (partial overline(u_i)) / (partial x_i)) - 2 / 3 rho k_t delta_(i i) = \
  &= - 2 / 3 rho (3 k_t) = - 2 rho k_t \
  k_t &= 1 / 2 overline(u'_i u'_i)
$

Energia Cinetica Turbolenta. Interpretazione di $overline(u'_i u'_j)$:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
      cases(u'_2 > 0, u'_1 < 0) quad overline(u'_1 u'_2) < 0 \
      cases(u'_2 < 0, u'_1 > 0) quad overline(u'_1 u'_2) < 0
    $
  ],
  [
    #image("dd564104-7c88-49b3-8aa7-fc7d01e14c7c-07_462_833_1830_140.jpg", width: 70%)
  ]
)
#v(1em)

Energia:

$
  overline(u)_i (rho (D overline(u_i)) / (D t)) &= overline(u)_i (- (partial overline(P)) / (partial x_i) + (partial overline(tau_(i j))) / (partial x_j) - partial / (partial x_j) (rho overline(u'_i u'_j))) \
  rho D / (D t) (overline(u)_i^2 / 2) &= - partial / (partial x_i) (overline(u)_i overline(P)) + overline(u)_i mu (partial^2 overline(u_i)) / (partial x_j^2) - overline(u)_i partial / (partial x_j) (rho overline(u'_i u'_j)) = \
  &= - partial / (partial x_i) (overline(u)_i overline(P)) + overline(u)_i mu partial / (partial x_j) (partial overline(u)_i) / (partial x_j) - partial / (partial x_j) (rho overline(u_i) thin overline(u'_i u'_j)) + rho overline(u'_i u'_j) (partial overline(u_i)) / (partial x_j) = \
  &= - partial / (partial x_i) (overline(u_i) overline(P)) - partial / (partial x_j) (rho overline(u_i) thin overline(u'_i u'_j)) + mu partial / (partial x_j) (overline(u_i) (partial overline(u_i)) / (partial x_j)) - mu (partial overline(u_i)) / (partial x_j) (partial overline(u_i)) / (partial x_j) + \
  &quad + rho overline(u'_i u'_j) (partial overline(u)_i) / (partial x_j) = \
  &= - partial / (partial x_j) (overline(u)_j overline(P) + rho overline(u_i) thin overline(u'_i u'_j)) + mu (partial^2) / (partial x_j^2) (overline(u)_i^2 / 2) - overline(D) - P \
  overline(D) &= mu ((partial overline(u_i)) / (partial x_j))^2 \
  P &= - rho overline(u'_i u'_j) (partial overline(u)_i) / (partial x_j)
$

$
  partial / (partial t) (rho k_t) + partial / (partial x_j) (rho k_t overline(u)_j) &= - rho overline(u'_i u'_j) (partial overline(u)_i) / (partial x_j) - rho epsilon.alt \
  &quad + partial / (partial x_k) (- 1 / 2 rho overline(u'_i u'_i u'_k) - overline(p' u'_k) + overline(u'_i tau'_(i k)))
$

Interpretazione fisica di $P$ (flusso):

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $
      cases(u'_2 > 0, u'_1 < 0) quad overline(u'_1 u'_2) < 0 \
      cases(u'_2 < 0, u'_1 > 0) quad overline(u'_1 u'_2) < 0
    $

    $ P = - rho overline(u'_1 u'_2) (partial overline(u_1)) / (partial x_2) > 0 $

    $P$ rappresenta il trasferimento di energia cinetica dal flusso medio.
  ],
  [
    #image("dd564104-7c88-49b3-8aa7-fc7d01e14c7c-09_547_611_1055_236.jpg", width: 70%)
  ]
)
#v(1em)

$ partial / (partial t) (rho u^2 / 2) + u_j partial / (partial x_j) (rho u^2 / 2) = - partial / (partial x_j) (p u_j - u_i tau_(i j)) - D $

equazione vista precedentemente (!)

$ D = 2 mu D_(i j) D_(i j) $

$
  - rho overline(u'_i u'_j) &= 2 mu_t overline(D_(i j)) - 2 / 3 rho k_t delta_(i j) = \
  &= mu_t ((partial overline(u_i)) / (partial x_j) + (partial overline(u_j)) / (partial x_i)) - 2 / 3 rho k_t delta_(i j) \
  - rho overline(u'_i u'_i) &= - 2 / 3 rho k_t delta_(i i) quad "poiché" quad (partial overline(u_i)) / (partial x_i) = 0
$

Come modellare $nu_t$?
velocità $times$ lunghezza

$ nu_t tilde.op k_t^(1 / 2) times k_t^(3 / 2) / epsilon.alt arrow.l.long "energia cinetica turbolenta" $

$epsilon.alt arrow.r$ dissipazione dell'energia cinetica turbolenta.

$
  (partial u_i) / (partial t) + u_j (partial u_i) / (partial x_j) &= dots.h \
  (partial overline(u)_i) / (partial t) + overline(u)_j (partial overline(u)_i) / (partial x_j) &= dots.h \
  underbrace(u'_i ((partial u'_i) / (partial t)), partial / (partial t) (1 / 2 u'_i u'_i)) + dots.h &= dots.h
$