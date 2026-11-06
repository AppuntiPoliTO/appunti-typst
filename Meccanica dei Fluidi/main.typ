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

#show outline.entry.where(level: 1): it => {
  v(1.2em, weak: true) // Aggiunge spazio vuoto sopra ogni nuovo capitolo
  strong(it)           // Rende in grassetto titolo, puntini e numero di pagina
}


#set heading(numbering: "1.")


// --- INTESTAZIONE ---
#align(center)[
  #v(0.5cm)
  #line(length: 100%, stroke: 1.5pt)
  #v(0.4cm, weak: true)
  #text(size: 20pt, weight: "bold", fill: black )[Apppunti di Meccanica dei Fluidi ] \
  #v(0.4cm, weak: true)
  #text(size: 12pt, style: "italic")[Corso del Prof. Pietro Stefano Salizzoni] \
  #v(0.2cm, weak: true)
  #line(length: 100%, stroke: 0.5pt)
  #v(0.4cm, weak: true)
  
  // Equivalente delle due minipage affiancate
  #grid(
    columns: (1fr, 1fr),
    align(left)[
      *Autori:* \
      Marco Vicari \
      Federico Toro
    ],
    align(right)[
      *Istituzione:* \
      Politecnico di Torino \
      #text(size: 9pt)[Anno Accademico 2025/2026]
    ]
  )
  #v(1cm)
]

// --- INDICE ---
#outline(indent: auto)

#pagebreak()


= Fondamenti, Proprietà dei Fluidi e Strumenti Matematici

== Fenomenologia e Forze Aerodinamiche
Consideriamo l'interazione tra un fluido in movimento e un corpo solido immerso in esso. Questo fenomeno genera una forza aerodinamica risultante, che convenzionalmente scomponiamo in due componenti: la _portanza_ (lift), perpendicolare alla direzione del moto indisturbato, e la _resistenza_ (drag), parallela ad essa. 

A velocità elevate, e in particolare nell'ambito dell'aeroacustica, si osserva che l'intensità del rumore irradiato cresce molto rapidamente con la velocità del flusso. Più precisamente, la potenza acustica irradiata $P_"acustica"$ scala con la settima potenza della velocità caratteristica $U$:
$ P_"acustica" prop U^7 $
Questa dipendenza evidenzia come anche piccoli incrementi di velocità possano comportare un aumento drammatico del rumore aerodinamico.

Inoltre, quando un fluido scorre attorno a corpi non aerodinamici (o "corpi tozzi"), si verifica un fenomeno noto come distacco dello strato limite. Invece di seguire il profilo del corpo, il fluido si "scolla" prematuramente dalla superficie. Tale separazione genera un'estesa scia turbolenta a valle dell'ostacolo. All'interno di questa scia si verifica una drastica riduzione della pressione rispetto alla parte frontale del corpo; questa differenza di pressione induce una forza frenante di risucchio, che costituisce gran parte della resistenza aerodinamica complessiva.

=== Interazione Fluido-Struttura
L'interazione tra strutture tozze e flussi non genera solo resistenza, ma può innescare complessi fenomeni dinamici. In particolare, nella scia si osserva spesso un rilascio alternato e periodico di vortici, noto come _vortex shedding_ (o scia di von Kármán). 
Tale rilascio asimmetrico induce oscillazioni trasversali del campo di pressione attorno al corpo. Se la frequenza di queste oscillazioni di pressione si avvicina alla frequenza naturale di vibrazione della struttura, si può innescare un fenomeno di risonanza, capace di causare cedimenti strutturali catastrofici.

Un altro fenomeno critico, tipico dei liquidi ad alta velocità, è legato alle variazioni di pressione dinamica. Secondo l'equazione di Bernoulli, un aumento locale della velocità del fluido $U$ comporta una proporzionale caduta della pressione statica locale $Delta P$, quantificabile come:
$ Delta P prop rho U^2 $
dove $rho$ è la densità del liquido. Se in un punto del flusso la pressione statica scende al di sotto della tensione di vapore del liquido a quella temperatura, si verifica un passaggio di stato locale e si formano bolle di vapore. Questo fenomeno prende il nome di _cavitazione_. Quando queste bolle vengono trasportate in zone a pressione più elevata, implodono violentemente. Le micro-onde d'urto generate dall'implosione causano instabilità nel flusso e una severa erosione meccanica delle superfici solide adiacenti.

=== Proprietà dei Fluidi
Nella modellazione fluidodinamica, un fluido può essere trattato come _incomprimibile_ qualora le variazioni relative della sua densità risultino fisicamente trascurabili ai fini del moto. Mentre per i liquidi questa è quasi sempre un'ottima approssimazione, per i gas la validità dell'ipotesi di incomprimibilità dipende dalla velocità. Essa è considerata valida a patto che la velocità del flusso sia sufficientemente bassa rispetto alla velocità del suono locale. Questa condizione si verifica matematicamente valutando il Numero di Mach ($"Ma"$):
$ "Ma" < 0.3 $

Per quanto riguarda il comportamento reologico, consideriamo i _fluidi newtoniani_. In questi fluidi, lo sforzo di taglio $tau$ applicato per far scorrere strati di fluido adiacenti è direttamente proporzionale al gradiente spaziale della velocità nella direzione perpendicolare al moto. La costante di proporzionalità è la _viscosità dinamica_ $mu$. 
Per semplificare le equazioni (e in particolare per quantificare la diffusione della quantità di moto rispetto all'inerzia del fluido), si introduce la _viscosità cinematica_ $nu$, definita come il rapporto tra la viscosità dinamica e la densità:
$ nu = mu/rho $
Un'osservazione interessante riguarda il confronto tra aria e acqua: sebbene l'aria sia circa mille volte meno densa dell'acqua (il che la rende "più leggera"), la sua viscosità cinematica risulta significativamente maggiore. Questo significa che l'aria, in proporzione alla sua massa, diffonde la quantità di moto molto più rapidamente dell'acqua.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Rappresentazione del profilo di velocità lineare in un fluido confinato tra una parete fissa e una piastra mobile (flusso di Couette). La piastra è trascinata a velocità costante $u$ da una forza $F$. Come previsto dalla _Legge di Newton della viscosità_, se il profilo di velocità è lineare ($(partial u) / (partial y) = "costante"$), lo sforzo di taglio $tau$ è costante su tutta la sezione trasversale ed è pari a:
    $ tau = mu (partial u)/(partial y) $
  ],
  [
    #canvas({
      import draw: *
      // Parete fissa
      line((0,0), (4,0), stroke: 1pt)
      content((2,-0.4), [Parete fissa])
      
      // Piastra mobile
      line((0,2.5), (4,2.5), stroke: 1pt)
      content((2,2.9), [Piastra mobile])
      
      // Forza F
      line((4,2.5), (5,2.5), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
      content((5.2,2.5), $F$, anchor: "west")
      
      // Asse y
      line((0,0), (0,3), mark: (end: ">"))
      content((0,3.3), $y$)
      
      // Asse u(y)
      line((0,0), (4.5,0), mark: (end: ">"))
      content((4.8,0), $u(y)$)
      
      // Frecce del profilo di velocità
      for y in (0.5, 1.0, 1.5, 2.0, 2.5) {
        line((0,y), (y * 1.6, y), stroke: (paint: blue, thickness: 1pt), mark: (end: ">"))
      }
      
      // Linea tratteggiata
      line((0,0), (4,2.5), stroke: (dash: "dashed"))
    })
  ]
)
#v(1em)

== Cinematica Euleriana e Notazione Indiciale
Per descrivere il moto del fluido, è essenziale definire una notazione rigorosa. Utilizzeremo la _notazione indiciale_ con la convenzione di Einstein (la somma è sottintesa sugli indici ripetuti).
Definiamo il vettore posizione $bold(x)$ e il vettore velocità $bold(u)$:
$
bold(x) &= (x, y, z) quad & x_i &= (x_1, x_2, x_3) \
bold(u) &= (u, v, w) quad & u_i &= (u_1, u_2, u_3) = (u_x, u_y, u_z)
$

Consideriamo innanzitutto un campo scalare $f(x, y, z)$. Il suo _gradiente_ è un vettore contenente le derivate parziali rispetto alle direzioni spaziali:
$
& nabla f = [ (partial f)/(partial x), (partial f)/(partial y), (partial f)/(partial z) ] \
& (partial f)/(partial x_i) = [ (partial f)/(partial x_1), (partial f)/(partial x_2), (partial f)/(partial x_3) ]
$

Passando a un campo vettoriale $bold(u)(bold(x))$, la derivata di ogni componente della velocità rispetto a ogni coordinata spaziale definisce il _gradiente di velocità_. Essendo costituito da due indici liberi ($i$ e $j$), esso è un tensore del secondo ordine, rappresentabile con una matrice $3 times 3$ di nove derivate spaziali:
$ (partial u_i)/(partial x_j) = mat(delim: "[",
(partial u_1)/(partial x_1), (partial u_1)/(partial x_2), (partial u_1)/(partial x_3);
(partial u_2)/(partial x_1), (partial u_2)/(partial x_2), (partial u_2)/(partial x_3);
(partial u_3)/(partial x_1), (partial u_3)/(partial x_2), (partial u_3)/(partial x_3)
) $
Si noti la potenza della notazione compatta: scrivendo semplicemente $(partial u_i) / (partial x_j)$ abbiamo descritto interamente il tensore.

La _divergenza_ di un vettore rappresenta fisicamente la variazione volumetrica locale del fluido. Matematicamente, essa corrisponde alla traccia del tensore gradiente di velocità, ovvero alla somma degli elementi sulla diagonale principale:
$
nabla dot bold(u) & = (partial u)/(partial x) + (partial v)/(partial y) + (partial w)/(partial z) \
& = (partial u_1)/(partial x_1) + (partial u_2)/(partial x_2) + (partial u_3)/(partial x_3) = (partial u_i)/(partial x_i)
$
Per la convenzione di Einstein, l'indice $i$ ripetuto indica una sommatoria: $(partial u_i)/(partial x_i) = sum_(i=1)^3 (partial u_i)/(partial x_i)$. La "saturazione" dell'indice riduce il rango del tensore originale da due a zero, producendo in output una grandezza puramente scalare.

Questo meccanismo di contrazione si applica anche al comune prodotto scalare tra due vettori $bold(a)$ e $bold(b)$:
$ bold(a) dot bold(b) = a_1 b_1 + a_2 b_2 + a_3 b_3 = sum_(i=1)^3 a_i b_i = a_i b_i $

=== Laplaciano
Il _Laplaciano_ di un campo vettoriale (che compare nei termini viscosi delle equazioni di Navier-Stokes) è definito come la divergenza del gradiente della velocità spaziale.
In notazione indiciale, sfruttando il fatto che l'operatore di derivazione si applica due volte rispetto alle stesse coordinate spaziali, si scrive come:
$ (partial^2 u_j)/(partial x_i partial x_i) $
L'indice ripetuto $i$ satura la sommatoria spaziale, lasciando unicamente l'indice libero $j$. Pertanto, il risultato del Laplaciano applicato a un vettore restituisce coerentemente un vettore.

Per manipolare questi tensori, introduciamo il _Simbolo di Kronecker_ (o tensore identità isotropo), definito come:
$ delta_(i j) = mat(delim: "[", 1, 0, 0; 0, 1, 0; 0, 0, 1) = bold(I) $
La proprietà fondamentale di $delta_(i j)$ è la "sostituzione degli indici". Moltiplicando un vettore $a_j$ per $delta_(i j)$, isoliamo solo la componente in cui $j=i$:
$
delta_(i j) a_j &= delta_(i 1) a_1 + delta_(i 2) a_2 + delta_(i 3) a_3 \
&==> mat(delim: "[",
delta_11 a_1 + delta_12 a_2 + delta_13 a_3;
delta_21 a_1 + delta_22 a_2 + delta_23 a_3;
delta_31 a_1 + delta_32 a_2 + delta_33 a_3
) = mat(delim: "(", a_1; a_2; a_3) = a_i
$
Analogamente, saturando entrambi gli indici di due tensori identità, ne estraiamo la traccia:
$
delta_(i j) delta_(i j) &= sum_(i=1)^3 sum_(j=1)^3 delta_(i j) delta_(i j) \
&= sum_(i=1)^3 (delta_(i 1) delta_(i 1) + delta_(i 2) delta_(i 2) + delta_(i 3) delta_(i 3)) \
&= delta_11 delta_11 + delta_22 delta_22 + delta_33 delta_33 \
&= 1 + 1 + 1 = 3
$

=== Rotore
Il _rotore_ di un campo di velocità è una grandezza vettoriale fondamentale chiamata _vorticità_ ($bold(omega)$). Essa descrive la tendenza locale del fluido a ruotare su sé stesso. Si calcola formalmente come il determinante formale:
$ nabla times bold(u) = op("det") mat(delim: "|",
hat(i), hat(j), hat(k);
partial/(partial x), partial/(partial y), partial/(partial z);
u, v, w
) = mat(delim: "[",
(partial w)/(partial y) - (partial v)/(partial z);
- ((partial w)/(partial x) - (partial u)/(partial z));
(partial u)/(partial y) - (partial v)/(partial x)
) $
Se $op("rot") bold(u) = 0$, significa che le particelle fluide traslano e si deformano, ma non ruotano. In questo caso il campo $bold(u)$ è detto _irrotazionale_ e, per le proprietà degli operatori differenziali, ammette un _potenziale_ scalare $Phi$ tale che $bold(u) = nabla Phi$.
In notazione indiciale, il rotore è espresso tramite il tensore alternante di Levi-Civita $epsilon_(i j k)$:
$ nabla times bold(u) ==> epsilon_(i j k) partial/(partial x_j) u_k ; quad c_i = epsilon_(i j k) a_j b_k ==> bold(c) = bold(a) times bold(b) $

=== Tensore degli Sforzi e Invarianti
Consideriamo un tensore del secondo ordine generico, come può essere il tensore degli sforzi $bold(sigma)$:
$ sigma_(i j) = mat(delim: "(",
sigma_11, sigma_12, sigma_13;
sigma_21, sigma_22, sigma_23;
sigma_31, sigma_32, sigma_33
) $
Questo tensore possiede tre _invarianti principali_, ovvero grandezze scalari il cui valore non cambia se ruotiamo il sistema di riferimento. Essi sono:
+ $I_1$, la traccia, ovvero la somma degli elementi diagonali: $sigma_11 + sigma_22 + sigma_33$. Nel caso degli sforzi, è legata alla pressione idrostatica media.
+ $I_2$, la somma dei determinanti dei minori principali $2 times 2$: $sigma_11 sigma_22 - sigma_12 sigma_21 + sigma_22 sigma_33 - sigma_23 sigma_32 + dots.h$
+ $I_3$, il determinante dell'intera matrice $3 times 3$: $op("det")(sigma_(i j))$.

Studiamo ora il tensore degli sforzi idrostatico causato dalla pressione in un fluido in quiete. La pressione $p$ è una grandezza scalare isotropa, il che significa che agisce con la stessa intensità su qualsiasi superficie orientata nello spazio. Fisicamente, essa si manifesta come uno sforzo unicamente normale e di compressione. Matematicamente, questo comportamento è modellato moltiplicando lo scalare $p$ per il delta di Kronecker, popolando così unicamente la diagonale principale del tensore:
$ p delta_(i j) = mat(delim: "[", p, 0, 0; 0, p, 0; 0, 0, p) $
Calcoliamo la divergenza di questo tensore di pressione per determinare la forza netta di volume che essa genera. Applicando la regola della derivazione indiciale, la presenza di $delta_(i j)$ sposta l'indice di derivazione:
$ partial/(partial x_j) (p delta_(i j)) = nabla p dot bold(I) $
Svolgendo i calcoli esplicitamente per le tre componenti spaziali, otteniamo:
$ sum_(j=1)^3 partial/(partial x_j) (p delta_(i j)) = mat(delim: "[",
partial/(partial x_1) (p delta_11) + partial/(partial x_2) (p delta_12) + partial/(partial x_3) (p delta_13);
partial/(partial x_1) (p delta_21) + partial/(partial x_2) (p delta_22) + partial/(partial x_3) (p delta_23);
partial/(partial x_1) (p delta_31) + partial/(partial x_2) (p delta_32) + partial/(partial x_3) (p delta_33)
) = mat(delim: "[", (partial p)/(partial x_1); (partial p)/(partial x_2); (partial p)/(partial x_3)) = nabla p $
Si nota un risultato fondamentale: la divergenza del tensore isotropo della pressione coincide con il gradiente scalare della pressione stessa.

== Teorema di Gauss
Il Teorema di Gauss (o della Divergenza) ci permette di convertire integrali di volume in integrali di superficie, ed è il pilastro matematico per derivare le equazioni di conservazione. Per un campo vettoriale $bold(u)$, stabilisce che l'integrale della divergenza sul volume $V$ equivale al flusso uscente attraverso la superficie chiusa $A$ di normale esterna $hat(n)$:
$ integral.triple_V nabla dot bold(u) dif V = integral.surf_A bold(u) dot hat(n) dif A $
In notazione indiciale, e generalizzato a un campo tensoriale $sigma_(i j)$, assume la forma:
$ integral.triple_V partial/(partial x_j) sigma_(i j) dif V = integral.surf_A sigma_(i j) n_j dif A $

=== Sforzi nei sistemi continui
Ai fini dell'ingegneria e della fluidodinamica macroscopica, il fluido non viene analizzato molecola per molecola, ma è trattato mediante l'_Ipotesi del Continuo_. Il fluido è descritto come un mezzo ininterrotto, privo di discontinuità spaziali (buchi o vuoti). 
Questo salto di scala è concettualmente cruciale: a livello microscopico, le particelle possiedono un moto di agitazione puramente caotico. Gli urti innumerevoli tra queste molecole trasferiscono quantità di moto, che a livello macroscopico noi percepiamo collettivamente come una distribuzione continua di sforzi e pressioni superficiali.
L'ipotesi di continuo risulta matematicamente fondata in virtù della netta separazione delle scale: il cammino libero medio delle molecole (l'ordine di grandezza del percorso tra due collisioni, $ 10^(-9) "m"$) è infinitesimalmente trascurabile rispetto alle lunghezze caratteristiche del dominio fluido studiato.

In questo mezzo continuo, agiscono due classi principali di forze:
- *Forze di volume:* Agiscono uniformemente sulla massa distribuita all'interno del volume. Esse derivano dall'esposizione del fluido a campi vettoriali esterni e agiscono a distanza. L'esempio più comune è il campo gravitazionale (forza peso), o in presenza di ioni/fluidi conduttori, i campi elettromagnetici (Forza di Lorentz).
- *Forze di superficie:* Agiscono sui bordi di separazione del volume fluido e rappresentano le interazioni dirette di contatto con il fluido adiacente o con pareti solide. 
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $->$ Forze di superficie. \
    $->$ Considero l'elemento.
  ],
  [#canvas(length: 0.8cm, {
  import draw: *

  // Contorno chiuso del volume V
  bezier((2.00, 4.35), (7.68, 2.78), (3.40, 5.00), (7.68, 3.80), stroke: 1.2pt)
  bezier((7.68, 2.78), (6.72, 0.72), (7.68, 2.00), (7.04, 1.12), stroke: 1.2pt)
  bezier((6.72, 0.72), (3.54, 0.00), (6.40, 0.32), (4.50, 0.00), stroke: 1.2pt)
  bezier((3.54, 0.00), (2.78, 0.90), (2.95, 0.00), (3.00, 0.50), stroke: 1.2pt)
  bezier((2.78, 0.90), (0.00, 2.38), (2.45, 1.50), (0.08, 1.50), stroke: 1.2pt)
  bezier((0.00, 2.38), (2.00, 4.35), (-0.12, 3.70), (1.00, 3.885), stroke: 1.2pt)

  // Etichetta del volume
  content((4.76, 3.55), text(size: 20pt)[$V$], anchor: "center")
})]
)
#v(1em)

Per quantificare queste interazioni, consideriamo una generica giacitura di superficie $d Omega$ caratterizzata da una normale orientata $hat(n)$. Definiamo il _vettore sforzo_ $bold(sigma)_n$ (forza per unità di superficie) come il limite:
$ bold(sigma)_n = lim_(d Omega -> 0) (d bold(F))/(dif Omega) $

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (horizon, center + horizon),
  [
    Il vettore sforzo $bold(sigma)_n$ _dipende fortemente_ dalla giacitura $d Omega$ scelta per analizzarlo. \
    È fondamentale sottolineare che, in generale, $bold(sigma)_n$ *non è* parallelo a $hat(n)$! Possiede sia componenti normali (pressioni o trazioni) sia componenti tangenziali (sforzi di taglio). \
    Per calcolare la forza risultante su una superficie macroscopica, dobbiamo integrare il vettore sforzo su tutta l'area:
    $ d bold(F) = bold(sigma)_n dif Omega ==> bold(F) = integral.double_Omega bold(sigma)_n dif Omega $
  ],
  [
    #canvas(length: 0.8cm, {
  import draw: *

  // Superficie di sezione Omega (ellisse in prospettiva)
  circle((3.58, 1.925), radius: (0.50, 1.925), stroke: 1.1pt)

  // Contorno della porzione sinistra del volume (chiuso esattamente sui vertici della sezione)
  bezier((3.58, 3.85), (0.00, 2.13), (2.75, 4.30), (0.00, 2.95), stroke: 1.1pt)
  bezier((0.00, 2.13), (2.29, 0.20), (0.00, 1.45), (1.95, 1.15), stroke: 1.1pt)
  bezier((2.29, 0.20), (3.58, 0.00), (2.42, -0.02), (3.10, -0.05), stroke: 1.1pt)

  // Punto P_0 sulla sezione
  circle((3.85, 2.08), radius: 0.09, fill: black, stroke: none)

  // Freccia che indica il punto P_0
  line((5.23, 4.72), (3.96, 2.25), mark: (end: ">"), stroke: 1pt)

  // Versore normale n
  line((3.85, 2.08), (5.01, 2.08), mark: (end: ">"), stroke: 1pt)

  // Vettore forza/flusso F (tratto più leggero come nell'immagine)
  line((3.98, 2.18), (5.80, 3.29), mark: (end: ">"), stroke: 0.6pt)

  // Freccia curva che indica la superficie di sezione Omega
  bezier((4.24, -0.45), (3.60, 0.80), (3.85, -0.10), (3.85, 0.45), mark: (end: ">"), stroke: 1pt)

  // Etichette
  content((5.55, 5.15), text(size: 16pt)[$P_0$], anchor: "center")
  content((6.70, 3.65), text(size: 20pt)[$arrow(F)$], anchor: "center")
  content((5.48, 1.95), text(size: 16pt)[$arrow(n)$], anchor: "center")
  content((4.65, -0.95), text(size: 20pt)[$Omega$], anchor: "center")
})
  ]
)
#v(1em)

per conoscere $bold(sigma)_n$ su un'area generica, visto che il suo modulo e la sua direzione cambiano al variare della giacitura $hat(n)$ usiamo l'analisi dell'equilibrio di un volume infinitesimo a forma di tetraedro.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Tetraedro di Cauchy* \
    Scegliamo un tetraedro i cui tre cateti giacciono sui piani del sistema di riferimento cartesiano, formando tre facce ortogonali di area $d Omega_x, d Omega_y, d Omega_z$. La faccia obliqua rimanente, di area $d Omega$, è caratterizzata dal versore normale $hat(n) = (n_x, n_y, n_z)$. 
    
    Su ciascuna delle tre facce cartesiane agirà un vettore sforzo specifico, rispettivamente $bold(sigma)_x, bold(sigma)_y, bold(sigma)_z$ (anch'essi, in generale, non perpendicolari alle proprie facce).
    - c) Per motivi geometrici di proiezione ortogonale, le aree delle facce cartesiane sono proporzionali all'area della faccia obliqua $d Omega$ attraverso i coseni direttori di $hat(n)$:
      $ (dif Omega_x)/(dif Omega) = n_x ; quad (dif Omega_y)/(dif Omega) = n_y ; quad (dif Omega_z)/(dif Omega) = n_z $
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  // Tratteggio blu sulla faccia obliqua
  line((0.02, 1.52), (1.15, 0.35), stroke: (paint: blue, thickness: 0.5pt))
  line((0.02, 1.05), (0.85, 0.20), stroke: (paint: blue, thickness: 0.5pt))
  line((0.02, 0.55), (0.45, 0.10), stroke: (paint: blue, thickness: 0.5pt))
  line((0.75, 1.25), (1.55, 0.42), stroke: (paint: blue, thickness: 0.5pt))
  line((1.45, 0.85), (1.95, 0.32), stroke: (paint: blue, thickness: 0.5pt))

  // Assi coordinati (neri)
  line((0.00, 0.00), (0.00, 3.25), mark: (end: ">"), stroke: 1pt)
  line((0.00, 0.00), (4.05, 0.42), mark: (end: ">"), stroke: 1pt)
  line((0.00, 0.00), (-2.12, -2.52), mark: (end: ">"), stroke: 1pt)

  // Spigoli della faccia obliqua del tetraedro (neri)
  line((0.00, 2.00), (2.70, 0.28), (-1.62, -1.93), close: true, stroke: 1.1pt)

  // Punto P_0 nell'origine e punto di applicazione sulla faccia obliqua
  circle((0.00, 0.00), radius: 0.08, fill: black, stroke: none)
  circle((0.48, 0.18), radius: 0.05, fill: blue, stroke: none)

  // Vettori blu (tensioni e normale)
  // Versore n
  line((0.48, 0.18), (1.75, 0.08), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
  // Vettore T_n
  line((0.48, 0.18), (3.00, 0.96), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
  // Vettore T_-z
  line((1.10, 0.85), (1.10, 2.15), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
  line((1.10, 0.85), (1.35, 1.38), stroke: (paint: blue, dash: "dashed", thickness: 0.7pt))
  // Vettore T_-x
  line((-0.88, -0.45), (-1.98, -1.00), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))
  // Vettore T_-y
  line((0.33, -0.80), (-0.52, -2.28), mark: (end: ">"), stroke: (paint: blue, thickness: 0.9pt))

  // Linee di richiamo nere (curve a S)
  // Richiamo P_0
  bezier((-1.35, 1.05), (-0.08, 0.15), (-1.10, 1.45), (-0.55, 0.25), mark: (end: ">"), stroke: 1pt)
  // Richiamo d Omega_x
  bezier((-1.40, 0.42), (-0.58, 0.00), (-1.15, 0.55), (-0.95, -0.10), mark: (end: ">"), stroke: 1pt)
  // Richiamo d Omega_z
  bezier((2.50, 1.88), (1.62, 0.85), (2.30, 1.88), (2.15, 1.15), stroke: 1pt)
  // Richiamo d Omega_y
  bezier((0.95, -0.58), (2.18, -1.25), (1.45, -0.45), (1.15, -1.55), mark: (end: ">"), stroke: 1pt)

  // Etichette nere
  content((0.40, 3.30), text(size: 16pt)[$y$], anchor: "center")
  content((-1.95, -3.10), text(size: 16pt)[$z$], anchor: "center")
  content((-1.60, 1.80), text(size: 18pt)[$P_0$], anchor: "center")
  content((-2.05, 0.75), text(size: 15pt)[$dif Omega_x$], anchor: "center")
  content((3., 2.), text(size: 15pt)[$dif Omega_z$], anchor: "center")
  content((2.8, -1.25), text(size: 15pt)[$dif Omega_y$], anchor: "center")

  // Etichette blu
  content((1, -0.2), text(fill: blue, size: 15pt)[$arrow(n)$], anchor: "center")
  content((3.70, 1.25), text(fill: blue, size: 16pt)[$arrow(sigma)_n$], anchor: "center")
  content((1.60, 2.50), text(fill: blue, size: 16pt)[$arrow(sigma)_(-z)$], anchor: "center")
  content((-2.25, -0.30), text(fill: blue, size: 16pt)[$arrow(sigma)_(-x)$], anchor: "center")
  content((0.35, -2.35), text(fill: blue, size: 16pt)[$arrow(sigma)_(-y)$], anchor: "center")
})

  ]
)
#v(1em)

- d) Applichiamo ora il principio di equilibrio alla traslazione (Seconda legge della Dinamica) all'elemento infinitesimo:
  $ sum(bold(F)_"sup" + bold(F)_"vol") = 0 $
  Sostituendo le definizioni di forza tramite gli sforzi:
  $ bold(sigma)_n dif Omega + bold(sigma)_(-x) dif Omega_x + bold(sigma)_(-y) dif Omega_y + bold(sigma)_(-z) dif Omega_z + bold(F)_"vol" = 0 $
  Tuttavia, quando le dimensioni del tetraedro tendono a zero ($L -> 0$), le forze di volume scalano con il volume infinitesimo ($L^3$), mentre le forze di superficie scalano con le aree ($L^2$). Ne consegue che, nel limite puntuale, le forze di volume decadono a zero molto più rapidamente e divengono infinitesimi di ordine superiore rispetto alle forze di superficie. Trascurandole:
  $ bold(sigma)_n dif Omega + bold(sigma)_(-x) dif Omega_x + bold(sigma)_(-y) dif Omega_y + bold(sigma)_(-z) dif Omega_z = 0 $
  
- e) _Lemma di Cauchy_: La tensione che agisce su una faccia orientata con normale $hat(n)$ è uguale e contraria a quella che agisce sulla faccia con normale opposta $-hat(n)$. Applichiamo questo lemma alle tre facce cartesiane per riportare i segni alle direzioni positive degli assi:
  $ bold(sigma)_(-x) = -bold(sigma)_x ; quad bold(sigma)_(-y) = -bold(sigma)_y ; quad bold(sigma)_(-z) = -bold(sigma)_z $

Otteniamo dunque la relazione di base per lo sforzo sulla giacitura obliqua:
- f) Sostituendo il lemma di Cauchy e dividendo per l'area totale $d Omega$:
  $
  & bold(sigma)_n dif Omega - bold(sigma)_x dif Omega_x - bold(sigma)_y dif Omega_y - bold(sigma)_z dif Omega_z = 0 \
  & bold(sigma)_n (dif Omega)/(dif Omega) - bold(sigma)_x (dif Omega_x)/(dif Omega) - bold(sigma)_y (dif Omega_y)/(dif Omega) - bold(sigma)_z (dif Omega_z)/(dif Omega) = 0
  $
  Inserendo le identità geometriche definite al punto c):
  $ bold(sigma)_n - bold(sigma)_x n_x - bold(sigma)_y n_y - bold(sigma)_z n_z = 0 $
  Esplicitando le componenti di ciascun vettore sforzo cartesiano nelle direzioni degli assi $x, y, z$:
  $
  bold(sigma)_x & = (sigma_(x x), sigma_(x y), sigma_(x z)) \
  bold(sigma)_y & = (sigma_(y x), sigma_(y y), sigma_(y z)) \
  bold(sigma)_z & = (sigma_(z x), sigma_(z y), sigma_(z z))
  $
  Possiamo riscrivere l'equilibrio vettoriale scomposto nelle tre direzioni spaziali:
  $ cases(
  sigma_(n x) = sigma_(x x) n_x + sigma_(y x) n_y + sigma_(z x) n_z,
  sigma_(n y) = sigma_(x y) n_x + sigma_(y y) n_y + sigma_(z y) n_z,
  sigma_(n z) = sigma_(x z) n_x + sigma_(y z) n_y + sigma_(z z) n_z
  ) $
  Questo sistema lineare esprime in forma matriciale il Teorema di Cauchy, che afferma che il vettore sforzo su _qualsiasi_ giacitura dipende linearmente dal tensore degli sforzi e dalla normale alla giacitura stessa:
  $ mat(delim: "[",
  sigma_(n x);
  sigma_(n y);
  sigma_(n z)
  ) = mat(delim: "[",
  sigma_(x x), sigma_(y x), sigma_(z x);
  sigma_(x y), sigma_(y y), sigma_(z y);
  sigma_(x z), sigma_(y z), sigma_(z z)
  ) mat(delim: "[",
  n_x;
  n_y;
  n_z
  ) ==> bold(sigma)_n = bold(sigma) dot hat(n) $
  In notazione indiciale, si scrive in modo compatto come $sigma_(n i) = sigma_(j i) n_j$.

- g) La simmetria del tensore degli sforzi è una diretta conseguenza dell'equilibrio alla rotazione dell'elemento infinitesimo. Se consideriamo i momenti generati dalle sole tensioni tangenziali attorno agli assi passanti per il baricentro del volume, affinché non si generino accelerazioni angolari infinite per volume nullo, gli sforzi sulle facce adiacenti che tendono a far ruotare l'elemento devono bilanciarsi. Matematicamente, questo impone:
  $ sigma_(y x) = sigma_(x y) ; quad sigma_(x z) = sigma_(z x) ; quad sigma_(y z) = sigma_(z y) $
  Ne consegue che il tensore degli sforzi è simmetrico e possiede solo 6 componenti indipendenti invece di 9.

=== Sforzi in un fluido in quiete

Vediamo cosa succede alle equazioni precedenti nel caso particolare in cui il fluido è fermo rispetto al sistema di riferimento inerziale. 
Se il campo di velocità è nullo ($arrow(u) = 0$), di conseguenza sono nulli anche i suoi gradienti spaziali ($nabla arrow(u) = 0$).
Fisicamente, l'assenza di scorrimento relativo tra strati adiacenti implica che il moto di agitazione molecolare del fluido mantenga un carattere perfettamente isotropo. La mancanza di direzioni preferenziali di trasporto di quantità di moto garantisce il completo annullamento degli sforzi tangenziali ($sigma_(x y), sigma_(x z), dots.h = 0$) e impone la rigorosa uniformità degli sforzi normali su qualunque giacitura.

La matrice del tensore degli sforzi si riduce dunque a contenere i soli termini sulla diagonale principale:
$ bold(sigma) = mat(
  sigma_(x x), 0, 0;
  0, sigma_(y y), 0;
  0, 0, sigma_(z z)
) $
Se applichiamo l'equazione di Cauchy $sigma_(i j) n_j = (sigma_n)_i$ per determinare lo sforzo su una generica giacitura di normale $hat(n)$:
$ mat(
  sigma_11, 0, 0;
  0, sigma_22, 0;
  0, 0, sigma_33
)
mat(
  n_1;
  n_2;
  n_3
) =
mat(
  sigma_11 n_1;
  sigma_22 n_2;
  sigma_33 n_3
) $
Affinché il fluido resti in perfetto equilibrio e lo sforzo sia sempre e solo normale su qualsiasi superficie (come richiede l'assenza di tensioni tangenziali statiche nei fluidi newtoniani), le tre componenti normali diagonali devono necessariamente essere uguali. Tale valore viene identificato con la pressione termodinamica cambiata di segno:
$ sigma_11 = sigma_22 = sigma_33 = -p $
Concludiamo che per un fluido in quiete, lo stato di tensione in un punto perde la sua natura tensoriale completa e viene interamente descritto dal solo scalare pressione $p$. A livello microscopico, questa grandezza scalare è il risultato statistico degli infiniti urti caotici delle molecole contro la parete ideale. L'adozione convenzionale del segno meno indica che nei fluidi la pressione agisce sempre fisicamente come uno sforzo normale di _compressione_, ossia con un verso che "spinge" contro la superficie e punta verso l'interno del volume analizzato.

= Statica dei Fluidi (Idrostatica)

== Equazioni indefinite della statica dei fluidi

L'equazione indefinita della statica dei fluidi rappresenta il caso degenere dell'Equazione di Cauchy (che governa la dinamica) quando si impone che la velocità del fluido sia identicamente nulla ($arrow(u) = 0$). Poiché il fluido è in quiete rispetto al sistema di riferimento, non vi sono scorrimenti tra strati adiacenti, e di conseguenza le componenti tangenziali del tensore degli sforzi sono nulle ($sigma_(i j) = 0$ per $i eq.not j$). Lo stato di tensione in un punto non è più definito da un tensore completo, ma dal solo sforzo normale di compressione, ovvero la pressione termodinamica $p$.

=== Derivazione su un elemento di volume infinitesimo
Per ricavare le equazioni di equilibrio, consideriamo inizialmente l'approccio didattico basato sulle componenti cartesiane. Isoliamo un elemento di volume fluido infinitesimo (un volumetto) di dimensioni $dif x, dif y, dif z$. 
    Affinché questo volumetto sia in equilibrio, la risultante delle forze di volume e delle forze di superficie deve essere nulla.

    Le forze di volume sono proporzionali alla massa dell'elemento. Considerando la sola accelerazione di gravità $arrow(g)$, la forza di volume è:
    $ arrow(F)_"vol" = rho arrow(g) dif x dif y dif z = arrow(g) dif m $
    
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    
    

    Le forze di superficie agiscono sulle facce del volumetto. Lungo la direzione $x$, la forza netta è data dalla differenza tra la spinta della pressione sulla faccia posteriore e quella sulla faccia anteriore (situata a distanza $dif x$ e avente pressione incrementata secondo lo sviluppo di Taylor). La forza superficiale netta lungo $x$ è un vettore:
    
  ],
  [
    #canvas(length: 3cm, {
  import draw: *
      // Funzione di proiezione per simulare il 3D
      let p(x, y, z) = (x - 0.4*z, y - 0.4*z)
      
      // Assi
      line(p(0,0,0), p(1.5,0,0), mark: (end: ">"), name: "y")
      content("y.end", [$y$], anchor: "west", padding: 0.1)
      line(p(0,0,0), p(0,1.5,0), mark: (end: ">"), name: "z")
      content("z.end", [$z$], anchor: "south", padding: 0.1)
      line(p(0,0,0), p(0,0,1.5), mark: (end: ">"), name: "x")
      content("x.end", [$x$], anchor: "north-east", padding: 0.1)
      
      // Cubetto
      line(p(0.5,0.5,0.5), p(1,0.5,0.5), p(1,1,0.5), p(0.5,1,0.5), close: true)
      line(p(0.5,0.5,1), p(1,0.5,1), p(1,1,1), p(0.5,1,1), close: true)
      line(p(0.5,0.5,0.5), p(0.5,0.5,1))
      line(p(1,0.5,0.5), p(1,0.5,1))
      line(p(1,1,0.5), p(1,1,1))
      line(p(0.5,1,0.5), p(0.5,1,1))
      
      // Forze di pressione (solo lungo x per chiarezza)
      line(p(0.2,0.75,0.75), p(0.5,0.75,0.75), mark: (end: ">"), stroke: (thickness: 1pt, paint: blue))
      content(p(0.06,0.75,0.75), [$p dif y dif z$], anchor: "south", padding: 0.1)
      
      line(p(1.4,0.75,0.75), p(1,0.75,0.75), mark: (end: ">"), stroke: (thickness: 1pt, paint: blue))
      content(p(1.6,0.75,0.75), [$(p + (partial p)/(partial x) dif x) dif y dif z$], anchor: "south", padding: 0.1)
      
      // Gravità
      line(p(0.75,0.5,0.75), p(0.75,0.1,0.75), mark: (end: ">"), stroke: (thickness: 1pt, paint: red))
      content(p(0.75,0.3,0.55), [$rho arrow(g) dif cal(V)$], anchor: "west", padding: 0.1)
    })
    // Nota: Schizzo semplificato basato sulla Fig. 1.6 del Kundu
  ]
)
#v(1em)

$ arrow(F)_("sup", x) = p dif y dif z thin hat(dotless.i) - (p + (partial p)/(partial x) dif x) dif y dif z thin hat(dotless.i) = -(partial p)/(partial x) dif x dif y dif z thin hat(dotless.i) $
    Ripetendo il medesimo ragionamento per le altre due direzioni spaziali, si ottengono i vettori forza:
    $ arrow(F)_("sup", y) = -(partial p)/(partial y) dif x dif y dif z thin hat(dotless.j) quad "e" quad arrow(F)_("sup", z) = -(partial p)/(partial z) dif x dif y dif z thin hat(k) $
    
Imponendo l'equilibrio globale $sum arrow(F) = 0$ e sommando i vettori forza superficiali per formare il gradiente di pressione, otteniamo:
$ rho arrow(g) dif x dif y dif z + (-(partial p)/(partial x) hat(dotless.i) - (partial p)/(partial y) hat(dotless.j) - (partial p)/(partial z) hat(k)) dif x dif y dif z = 0 $
Semplificando il volume infinitesimo, giungiamo alla forma vettoriale compatta dell'equazione dell'idrostatica:
$ rho arrow(g) = nabla p $

Se poniamo il sistema di riferimento con l'asse $z$ rivolto verso l'alto (in direzione opposta alla gravità), il vettore accelerazione di gravità si scrive come $arrow(g) = (0, 0, -g)^T$. Le condizioni di equilibrio esplicitate diventano quindi:
$ cases(
  (partial p)/(partial x) = 0,
  (partial p)/(partial y) = 0,
  (partial p)/(partial z) = -rho g
) $
Questa forma ci mostra che in un fluido in quiete la pressione varia unicamente nella direzione verticale $z$.

=== Derivazione tensoriale e integrale
#v(1em)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    In modo più generale, possiamo dedurre l'equazione di equilibrio considerando un volume di fluido macroscopico qualsiasi $cal(V)$ racchiuso da una superficie $S$.
    Essendo le tensioni tangenziali nulle, il tensore degli sforzi $bold(sigma)$ ha forma diagonale e isotropa, ed è rappresentato dal solo sforzo normale $-p$:
    
  ],
  [
    #canvas(length: 1.3cm,{
      import draw: *
      
      // Patata
      catmull((0,0), (0.5, 1), (1.5,1.5), (2.5, 1), (3,0.5), (2.5, -0.5), (2,-1), (1, -0.5), close: true, fill: blue.transparentize(90%), stroke: 1pt)
      content((1.5, 0.2), [$cal(V)$])
      
      // Elemento di superficie e normale
      line((2.6,0.7), (2.8,0.8), (2.9,0.5), (2.7,0.4), close: true, fill: blue.transparentize(70%), stroke: 1pt)
      content((2.5, 1.2), [$S$])
      content((3.2, 0.4), [$dif Omega$])
      
      // Vettore gravità
      line((2.8,0.6), (3.6,0.9), mark: (end: ">"), stroke: 1pt)
      content((3.6,0.9), [$hat(n)$], anchor: "west", padding: 0.1)
      
      line((1,-0.2), (1,-1), mark: (end: ">"), stroke: (thickness: 1pt, paint: red))
      content((1,-1), [$arrow(g)$], anchor: "west", padding: 0.1)
    })
    // Nota: Schizzo semplificato basato sulla Fig. 2.10 del Kundu
  ]
)
#v(1em)

$ bold(sigma) = 
    mat(
      -p, 0, 0;
      0, -p, 0;
      0, 0, -p
    )
    = -p bold(I) quad ==> quad sigma_(i j) = -p delta_(i j) $
    L'equazione di bilancio integrale delle forze per il volume $cal(V)$ afferma che la somma delle forze di volume e delle forze di superficie uscenti deve essere nulla:
    $ integral.triple_cal(V) rho arrow(g) dif cal(V) + integral.surf_S bold(sigma) dot hat(n) dif Omega = 0 $
    Per poter sommare i due termini, applichiamo il Teorema della Divergenza (Gauss) per trasformare l'integrale di superficie in un integrale di volume. Usando la notazione indiciale, il termine superficiale diventa:
    $ integral.surf_S sigma_(i j) n_j dif Omega = integral.triple_cal(V) (partial sigma_(i j))/(partial x_j) dif cal(V) $
Sostituendo il tensore idrostatico $sigma_(i j) = -p delta_(i j)$, la derivata satura l'indice $j$:
$ (partial)/(partial x_j) (-p delta_(i j)) = -(partial p)/(partial x_j) delta_(i j) = -(partial p)/(partial x_i) $
Il bilancio integrale diventa perciò:
$ integral.triple_cal(V) ( rho g_i - (partial p)/(partial x_i) ) dif cal(V) = 0 $
Affinché questo integrale sia nullo per _qualsiasi_ volume arbitrario $cal(V)$, l'integranda deve essere nulla in ogni punto, da cui ritroviamo l'equazione vettoriale $rho arrow(g) = nabla p$. Si noti come la saturazione degli indici tramite la delta di Kronecker renda rigorosamente coerente l'identità dimensionale dell'equazione.
#pagebreak()
== Legge di Stevino

Consideriamo un fluido in quiete e incomprimibile (ovvero con densità $rho = "costante"$). In queste condizioni, l'equazione fondamentale dell'idrostatica assume la forma $rho arrow(g) = nabla p$.

Esprimiamo il vettore accelerazione di gravità $arrow(g)$ tramite un potenziale gravitazionale scalare $psi$. Orientando l'asse verticale $z$ verso l'alto, il potenziale è definito come $psi = -arrow(g) dot arrow(x) = g z$. Ne consegue che:
$ arrow(g) = -nabla psi = -nabla(g z) $
Sostituendo questa espressione nell'equazione dell'idrostatica, otteniamo:
$ -rho nabla psi - nabla p = 0 $
Sfruttando l'ipotesi di incomprimibilità, è lecito portare la densità $rho$ (che è costante) all'interno dell'operatore gradiente:
$ nabla(rho psi + p) = 0 quad ==> quad nabla(rho g z + p) = 0 $
Definendo il peso specifico del fluido $gamma = rho g$ ("N/m"^3), la relazione implica che la quantità in parentesi sia costante in tutta la massa fluida:
$ gamma z + p = "costante" $
Dividendo l'intera espressione per il peso specifico $gamma$, si ricava la *Legge di Stevino* espressa in termini di altezze:
$ h = z + p/gamma = "costante" $
La quantità $h$ ha le dimensioni di una lunghezza ed è detta _quota piezometrica_ (o carico piezometrico). La sua costanza implica che, nel fluido in quiete, una superficie a pressione costante (isobara) coincide inevitabilmente con una superficie a quota $z$ costante (piano orizzontale). L'avere una superficie libera a contatto con l'atmosfera è quindi equivalente ad avere un piano isobaro.

Presi due punti $A$ e $B$ qualsiasi all'interno del medesimo fluido, l'invarianza del carico piezometrico si scrive:
$ z_A + p_A/gamma = z_B + p_B/gamma quad ==> quad p_B = p_A + gamma(z_A - z_B) $
Questa equazione dimostra che, nota la pressione in un punto, è possibile calcolarla in tutti gli altri punti. 
Nelle applicazioni ingegneristiche si fa sovente riferimento alla _pressione relativa_, che rappresenta lo scarto rispetto alla pressione atmosferica locale:
$ p_"rel" = p_"ass" - p_"atm" $
Si definisce *Piano dei Carichi Idrostatici (PCI)* il luogo geometrico dei punti (reali o virtuali) in cui la pressione relativa del fluido è nulla ($p_"rel" = 0$, ovvero $p_"ass" = p_"atm"$).

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Calcolo della pressione a un dato affondamento $Delta h$ rispetto a un punto $A$ (es. la superficie libera).\
    Essendo $z_A - z = Delta h$ (profondità misurata verso il basso), si ha:
    $ p(z) = p_A + gamma underbrace((z_A - z), Delta h) $
    Se $A$ giace sul PCI, $p_A = 0$ (pressione relativa), da cui:
    $ p(z) = gamma Delta h $
  ],
  [   
#canvas(length: 0.8cm, {
  import draw: *

  // --- DISEGNO SINISTRO (Serbatoio) ---

  // Asse z e linea di base
  line((1, 1), (1, 4.5), mark: (end: ">"), stroke: 1pt)
  content((1, 4.8), [$z$])
  line((0.8, 1), (5, 1), mark: (end: ">"), stroke: 1pt)

  // Serbatoio
  line((2.5, 4), (2.5, 1), stroke: 1pt) // Parete sinistra
  line((4.5, 4), (4.5, 1), stroke: 1pt) // Parete destra

  // Pelo libero del fluido
  line((2.5, 3.5), (4.5, 3.5), stroke: (paint: blue, thickness: 1pt))

  // Simbolo di pelo libero
  line((2.8, 3.8), (3.2, 3.8), (3, 3.5), close: true, stroke: (paint: blue, thickness: 0.8pt))
  line((2.9, 3.4), (3.1, 3.4), stroke: (paint: blue, thickness: 0.8pt))
  line((2.95, 3.3), (3.05, 3.3), stroke: (paint: blue, thickness: 0.8pt))
  line((2.98, 3.2), (3.02, 3.2), stroke: (paint: blue, thickness: 0.8pt))

  // Punto A
  circle((4.2, 3.5), radius: 0.06, stroke: blue, fill: white)
  content((4.4, 3.8), text(blue)[$A$])

  // Indicatore di profondità (h)
  line((1.8, 2.1), (1.8, 1), mark: (end: ">"), stroke: (paint: blue, thickness: 0.8pt))
  line((1.8, 2.4), (1.8, 3.5), mark: (end: ">"), stroke: (paint: blue, thickness: 0.8pt))
  content((1.8, 2.25), text(blue)[$h$])


  // --- DISEGNO DESTRO (Diagramma delle pressioni) ---

  // Assi z e p
  line((7, 0.7), (7, 4.5), mark: (end: ">"), stroke: 1pt)
  content((7, 4.8), [$z$])
  line((6., 1), (10, 1), mark: (end: ">"), stroke: 1pt)
  content((10.3, 1), [$p$])

  

  // Punto sul pelo libero (vertice del triangolo)
  circle((7, 3.5), radius: 0.06, fill: black)

  // Triangolo delle pressioni
  line((7, 3.5), (9.5, 1), (7, 1), close: true, stroke: 1pt)

  circle((7,1), radius: 0.05, fill: black)
  content((6.4,0.3), $p_"atm"$, anchor: "south-west", padding: 0.1)
  // Tratteggio orizzontale interno al triangolo
  line((7, 1.4), (9.1, 1.4), stroke: 0.6pt)
  line((7, 1.8), (8.7, 1.8), stroke: 0.6pt)
  line((7, 2.2), (8.3, 2.2), stroke: 0.6pt)
  line((7, 2.6), (7.9, 2.6), stroke: 0.6pt)
  line((7, 3.0), (7.5, 3.0), stroke: 0.6pt)
})
  ]
)
#v(1em)

== Misura della pressione
#v(1em)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Piezometri semplici*\
    Strumenti elementari costituiti da tubi aperti verso l'atmosfera.
    - Impiegati esclusivamente per i liquidi.
    - Misurano fisicamente l'altezza del carico piezometrico $h = p/gamma$.
    - Il loro impiego è limitato a pressioni modeste, per evitare colonne liquide di altezza impraticabile.
    
    #v(0.5em)
  ],
  [
#canvas(length: 0.8cm, {
  import draw: *
  
  // Riempimento del liquido (serbatoio e tubo)
  line((0,3), (3,3), (3,1), (3.5,1), (3.5,3), (4,3), (4,0.5), (3,0.5), (3,0), (0,0), close: true, fill: blue.transparentize(80%), stroke: none)
  
  // Linee di pelo libero nel serbatoio e nel tubo
  line((0, 3), (3, 3), stroke: blue)
  line((3.5, 3), (4, 3), stroke: blue)
  
  // Simbolo di pelo libero (triangolo rovesciato)
  line((1.5, 3), (1.3, 3.3), (1.7, 3.3), close: true, stroke: blue)
  
  // Linea del piano dei carichi idrostatici (p.c.i.)
  line((4.2, 3), (5.5, 3), stroke: (paint: blue, dash: "dashed", thickness: 0.6pt))
  content((5.7, 3), text(blue)[p.c.i.], anchor: "west")
  
  // Pareti esterne continue (sinistra serbatoio, fondo, fondo tubo, destra tubo)
  line((0, 4), (0, 0), (3, 0), (3, 0.5), (4, 0.5), (4, 4), stroke: 1pt)
  
  // Pareti interne continue (destra serbatoio, sopra tubo, sinistra tubo)
  line((3, 4), (3, 1), (3.5, 1), (3.5, 4), stroke: 1pt)
})
  ]
)
#v(1em)
\
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Manometri*\
    I manometri superano i limiti costruttivi dei piezometri e permettono la misurazione di pressioni molto elevate (o la misurazione di pressioni nei gas). Sfruttano il bilancio idrostatico di fluidi manometrici dotati di un peso specifico $gamma_m$ notevolmente superiore a quello del fluido in esame $gamma$.
  ],
  [
#canvas(length: 1cm, {
  import draw: *

  // Serbatoio: 0..2.7 (x), 0..2.4 (y). Pelo libero a y=1.65
  // Tubo a U: bordo interno x=3.6, bordo esterno x=4.0, altezza fino a y=2.6
  // Livelli tratteggiati: y=2.2 (P>0), y=0.6 (P<0)

  // Serbatoio con uscita in basso a destra
  line((2.7, 0.6), (2.7, 2.4), (0, 2.4), (0, 0), (2.7, 0))

  // Tubo a U
  line((2.7, 0.6), (3.6, 0.6), (3.6, 2.6))
  line((2.7, 0), (4.0, 0), (4.0, 2.6))

  // Scritta GAS
  content((1.35, 2.05), text(size: 9pt, style: "italic")[GAS])

  // Pelo libero (blu) con simbolo del livello
  line((0, 1.65), (2.7, 1.65), stroke: blue)
  line((0.7, 1.9), (0.9, 1.9), (0.8, 1.65), close: true, stroke: blue)

  // Livelli tratteggiati
  line((3.6, 2.2), (5, 2.2), stroke: (paint: blue.transparentize(30%), dash: "dashed", thickness: 0.6pt,))
  line((3, 0.6), (5, 0.6), stroke: (paint: blue.transparentize(30%), dash: "dashed", thickness: 0.6pt))

  // Didascalie
  content((5.2, 2.2), [se $P_"GAS" > 0$], anchor: "west")
  content((5.2, 0.6), [se $P_"GAS" < 0$], anchor: "west")
})
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Manometro semplice (a U)*\
    Uguagliamo le pressioni sul piano orizzontale passante per il menisco più basso (punto $M$). Il ramo aperto ($B'$) è a pressione atmosferica.
    $ cases(
      p_(N') = 0 quad "(pressione relativa)",
      p_M = p_(N') + gamma_m Delta = gamma_m Delta,
      p_M = gamma a
    ) $
    Uguagliando le espressioni per $p_A$ si ottiene l'affondamento misurato in colonna di fluido di lavoro:
    $ h = gamma_m/gamma Delta $
    
    // TODO: Idraulica Fig. 2.4 (pag. stampata 39, pag. PDF 51)
  ],
  [
    //#image("image6new.png", width: 70%)
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Vacuometro*\
    L'utilizzo di un liquido ad alto peso specifico (es. mercurio, $gamma_m gt.double gamma$) permette di leggere pressioni per $h$ grandi tramite dislivelli $Delta$ piccoli e compatti. 
    Se il sistema lavora in depressione rispetto all'ambiente ($p < 0$), il fluido manometrico viene richiamato verso il serbatoio. Lo strumento prende il nome di vacuometro. Il dislivello $Delta$ si inverte rispetto al caso precedente, fornendo una pressione relativa negativa:
    $ p_A = -gamma_m Delta $
  ],
  [  
#canvas(length: 0.7cm, {
  import draw: *

  // Liquido manometrico (riempimento chiaro)
  line(
    (5.5, 1.7), (5.5, 1.0),
    (5.6608, 0.4), (6.1, -0.0392), (6.7, -0.2), (7.3, -0.0392), (7.7392, 0.4),
    (7.9, 1.0), (7.9, 1.2), (7.1, 1.2), (7.1, 1.0),
    (7.0464, 0.8), (6.9, 0.6536), (6.7, 0.6), (6.5, 0.6536), (6.3536, 0.8),
    (6.3, 1.0), (6.3, 1.7),
    close: true, fill: blue.transparentize(80%), stroke: none
  )

  // Superfici libere del liquido (A a sinistra, B a destra)
  line((5.5, 1.7), (6.3, 1.7), stroke: (paint: blue, thickness: 1pt))
  line((7.1, 1.2), (7.9, 1.2), stroke: (paint: blue, thickness: 1pt))

  // Serbatoio (con apertura per il raccordo tra y=2.0 e y=2.8)
  line((4.0, 2.8), (4.0, 5.5), (0, 5.5), (0, 0), (4.0, 0), (4.0, 2.0), stroke: 1pt)

  // Parete esterna: raccordo inferiore, ramo sinistro, curva esterna, ramo destro
  line((4.0, 2.0), (5.5, 2.0), (5.5, 1.0), stroke: 1pt)
  arc((6.7, 1.0), start: 180deg, stop: 360deg, radius: 1.2, anchor: "origin", stroke: 1pt)
  line((7.9, 1.0), (7.9, 5.5), stroke: 1pt)

  // Parete interna: raccordo superiore, ramo sinistro, curva interna, ramo destro
  line((4.0, 2.8), (6.3, 2.8), (6.3, 1.0), stroke: 1pt)
  arc((6.7, 1.0), start: 180deg, stop: 360deg, radius: 0.4, anchor: "origin", stroke: 1pt)
  line((7.1, 1.0), (7.1, 5.5), stroke: 1pt)

  // Linee di riferimento dai livelli A e B verso la quota
  line((5.5, 1.7), (9.4, 1.7), stroke: (paint: blue, thickness: 0.6pt))
  line((7.1, 1.2), (9.4, 1.2), stroke: (paint: blue, thickness: 0.6pt))

  // Quota del dislivello
  line((8.9, 1.7), (8.9, 1.2), mark: (start: ">", end: ">"), stroke: (paint: blue, thickness: 0.6pt))

  // Etichette
  content((2.0, 2.75), text(blue)[$gamma$])
  content((5.4, 1.7), text(blue)[$A$], anchor: "east")
  content((8.0, 1.0), text(blue)[$B$], anchor: "north-west")
  content((9.0, 1.45), text(blue)[$gamma$], anchor: "west")
})
  ]
)
#v(1em)
#pagebreak()
== Manometri differenziali
#v(1em)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Questi strumenti misurano la *differenza di quota piezometrica* $delta$ (ovvero il dislivello tra i Piani dei Carichi Idrostatici, PCI) tra due serbatoi contenenti lo stesso fluido $gamma$, sfruttando un tubo a U riempito con fluido manometrico $gamma_m > gamma$.

- Fissiamo il piano orizzontale passante per il menisco più basso $A$ (ramo a destra).
- Sia $B$ il menisco più alto (nel ramo a sinistra), posto a una distanza verticale $Delta$ sopra $A$.
- Sia $b$ l'affondamento del menisco $B$ sotto il Piano dei Carichi Idrostatici (PCI) del rispettivo serbatoio. 

  ],
  [
#canvas(length: 0.65cm, {
  import draw: *
  
  // Riempimento fluido manometrico
  line(
    (2.5, 2.0),
    (2.5, 0.5),
    (2.634, 0.0),
    (3.0, -0.366),
    (3.5, -0.5),
    (8.0, -0.5),
    (8.5, -0.366),
    (8.866, 0.0),
    (9.0, 0.5),
    (9.0, 1.0),
    (8.5, 1.0),
    (8.5, 0.5),
    (8.433, 0.25),
    (8.25, 0.067),
    (8.0, 0.0),
    (3.5, 0.0),
    (3.25, 0.067),
    (3.067, 0.25),
    (3.0, 0.5),
    (3.0, 2.0),
    close: true, fill: blue.transparentize(80%), stroke: none
  )
  
  // Contorno serbatoio sinistro
  line((1.0, 3.0), (1.0, 5.0), stroke: 1pt)
  line((1.5, 5.5), (4.0, 5.5), stroke: 1pt)
  line((4.5, 5.0), (4.5, 3.0), stroke: 1pt)
  line((4.0, 2.5), (3.0, 2.5), stroke: 1pt)
  line((2.5, 2.5), (1.5, 2.5), stroke: 1pt)
  arc((1.5, 3.0), start: 180deg, stop: 270deg, radius: 0.5, anchor: "origin", stroke: 1pt)
  arc((1.5, 5.0), start: 90deg, stop: 180deg, radius: 0.5, anchor: "origin", stroke: 1pt)
  arc((4.0, 5.0), start: 0deg, stop: 90deg, radius: 0.5, anchor: "origin", stroke: 1pt)
  arc((4.0, 3.0), start: 270deg, stop: 360deg, radius: 0.5, anchor: "origin", stroke: 1pt)
  
  // Contorno serbatoio destro
  line((7.0, 3.0), (7.0, 5.0), stroke: 1pt)
  line((7.5, 5.5), (10.0, 5.5), stroke: 1pt)
  line((10.5, 5.0), (10.5, 3.0), stroke: 1pt)
  line((10.0, 2.5), (9.0, 2.5), stroke: 1pt)
  line((8.5, 2.5), (7.5, 2.5), stroke: 1pt)
  arc((7.5, 3.0), start: 180deg, stop: 270deg, radius: 0.5, anchor: "origin", stroke: 1pt)
  arc((7.5, 5.0), start: 90deg, stop: 180deg, radius: 0.5, anchor: "origin", stroke: 1pt)
  arc((10.0, 5.0), start: 0deg, stop: 90deg, radius: 0.5, anchor: "origin", stroke: 1pt)
  arc((10.0, 3.0), start: 270deg, stop: 360deg, radius: 0.5, anchor: "origin", stroke: 1pt)
  
  // Contorno tubo a U
  line((2.5, 2.5), (2.5, 0.5), stroke: 1pt)
  line((3.0, 2.5), (3.0, 0.5), stroke: 1pt)
  line((3.5, -0.5), (8.0, -0.5), stroke: 1pt)
  line((3.5, 0.0), (8.0, 0.0), stroke: 1pt)
  line((9.0, 2.5), (9.0, 0.5), stroke: 1pt)
  line((8.5, 2.5), (8.5, 0.5), stroke: 1pt)
  arc((3.5, 0.5), start: 180deg, stop: 270deg, radius: 1.0, anchor: "origin", stroke: 1pt)
  arc((8.0, 0.5), start: 270deg, stop: 360deg, radius: 1.0, anchor: "origin", stroke: 1pt)
  arc((3.5, 0.5), start: 180deg, stop: 270deg, radius: 0.5, anchor: "origin", stroke: 1pt)
  arc((8.0, 0.5), start: 270deg, stop: 360deg, radius: 0.5, anchor: "origin", stroke: 1pt)
  
  // Superfici menischi
  line((2.5, 2.0), (3.0, 2.0), stroke: (paint: blue, thickness: 1pt))
  line((8.5, 1.0), (9.0, 1.0), stroke: (paint: blue, thickness: 1pt))
  
  // Linee di riferimento orizzontali per A e B
  line((5.0, 1.0), (8.5, 1.0), stroke: (thickness: 0.6pt))
  line((3.0, 2.0), (5.5, 2.0), stroke: (thickness: 0.6pt))
  
  // Linee dei Piani dei Carichi Idrostatici (PCI)
  line((0.5, 6.5), (7.0, 6.5), stroke: (paint: blue, dash: "dashed", thickness: 0.6pt))
  line((6.0, 7.5), (11.0, 7.5), stroke: (paint: blue, thickness: 0.6pt))
  
  // Frecce e quote
  line((4.8, 2.0), (4.8, 6.5), mark: (start: ">", end: ">"), stroke: (thickness: 0.6pt))
  line((5.3, 1.0), (5.3, 2.0), mark: (start: ">", end: ">"), stroke: (thickness: 0.6pt))
  line((6.5, 6.5), (6.5, 7.5), mark: (start: ">", end: ">"), stroke: (thickness: 0.6pt))
  
  // Testi e formule
  content((2.75, 4.0), text(blue)[$gamma$])
  content((8.75, 4.0), text(blue)[$gamma$])
  
  content((2.2, 2.0), text(blue)[$B$], anchor: "east")
  content((9.3, 1.0), text(blue)[$A$], anchor: "west")
  
  content((5.1, 4.25), text(blue)[$b$])
  content((5.6, 1.5), text(blue)[$Delta$])
  content((6.8, 7.0), text(blue)[$delta$])
  
  content((0.4, 6.5), text(blue)[$"pci"_1$], anchor: "east")
  content((11.1, 7.5), text(blue)[$"pci"_2$], anchor: "west")
})
  ]
)
#v(1.5em)


Calcoliamo le pressioni procedendo per affondamenti. Ragionando inizialmente nella regione con il fluido di peso specifico $gamma$, la pressione nel punto $B$, situato a una profondità $b$, è pari a:

$ p_B = b gamma $

Per il punto $A$, il cui affondamento complessivo nello stesso fluido è dato dalla somma dei termini $(Delta + b + delta)$, si ha:

$ p_A = (Delta + b + delta) gamma $

Dobbiamo ora valutare il legame tra le due pressioni passando per il tubo a U. Ragionando questa volta nella regione con il fluido manometrico $gamma_m$, la pressione in $A$ può essere espressa a partire da $B$ aggiungendo il carico dovuto unicamente al dislivello manometrico $Delta$. Ne consegue l'equazione:

$ p_A = p_B + Delta gamma_m $

Sostituendo le espressioni di $p_A$ e $p_B$ trovate in precedenza (equazioni 1) in quest'ultima relazione (equazione 2), otteniamo il bilancio completo:

$ (Delta + b + delta) gamma - b gamma = Delta gamma_m $

Svolgendo i calcoli ed elidendo i termini opposti ($b gamma$):

$ delta gamma + Delta gamma = Delta gamma_m $
$ delta gamma = Delta(gamma_m - gamma) quad ==> quad delta = Delta (gamma_m - gamma)/gamma $

Si noti che il dislivello incognito $delta$ è deducibile dalla sola lettura manometrica $Delta$ e dal rapporto dei pesi specifici, risultando del tutto indipendente dalla quota assoluta dello strumento e dai carichi idrostatici di partenza (il termine $b$ si cancella).

Per misurazioni di pressioni notevoli nell'industria, i classici manometri a liquido vengono oggi largamente sostituiti dai *manometri metallici* (a deformazione meccanica, come il tubo di Bourdon) e dai *trasduttori di pressione*, che misurano la pressione usando elementi sensibili elettronici.
#pagebreak()
== Spinta idrostatica su superfici piane

Per calcolare la spinta esercitata da un fluido in quiete su una superficie piana inclinata di un angolo $alpha$, definiamo un opportuno sistema di riferimento cartesiano. Posizioniamo l'asse $y$ sulla _retta di sponda_, definita come l'intersezione tra il prolungamento del piano della superficie e il Piano dei Carichi Idrostatici (PCI). L'asse $x$ giace sul piano della superficie ed è orientato verso il basso lungo la linea di massima pendenza.

Consideriamo un'area infinitesima $dif A$. In un fluido in quiete gli sforzi tangenziali sono nulli; l'unica forza è la pressione normale alla superficie. Il vettore forza elementare è:
$ dif arrow(S) = -p hat(n) dif A = -gamma h hat(n) dif A $
Integrando sull'intera area $A$, poiché il versore normale $hat(n)$ e il peso specifico $gamma$ sono costanti, si ha:
$ arrow(S) = -gamma hat(n) integral_A h dif A $
Dal sistema di riferimento adottato, l'affondamento $h$ vale geometricamente $h = x sin alpha$:
    $ arrow(S) = -hat(n) gamma sin alpha integral_A x dif A $
#align(center)[
  #image("image9new.png", width: 60%)
]
L'integrale $integral_A x dif A$ rappresenta il Momento statico di primo ordine dell'area rispetto all'asse di sponda $y$, indicato con $M_y = x_G A$, dove $x_G$ è la coordinata del baricentro. Sostituendo:
$ arrow(S) = -hat(n) gamma underbrace(sin alpha thin x_G, h_G) A = - underbrace(gamma h_G, p_G) A thin hat(n) $
Si dimostra così che *la spinta idrostatica $arrow(S)$ ha modulo pari al prodotto tra la pressione valutata nel baricentro $p_G$ e l'area totale $A$*, ed è ortogonale alla superficie.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    *Centro di spinta*\
    Il punto di applicazione della risultante $arrow(S)$ è detto Centro di spinta $C$, il quale in generale _non_ coincide con il baricentro $G$. Per calcolarne la coordinata $x_c$, uguagliamo il momento della risultante rispetto all'asse $y$ all'integrale dei momenti elementari. 
    
    Vettorialmente, il modulo del momento della spinta è $|arrow(S)| |arrow(x)_c| sin phi$, con $phi = pi/2$ (angolo tra $arrow(S)$ e l'asse $x$).
    
    Ricordando che la pressione è $p = gamma h$, con affondamento $h = x sin alpha$, si ottiene:
    
  ],
  [
#canvas(length: 0.8cm, {
  import draw: *
  
  // Linee di riferimento orizzontali (tratteggiate)
  line((0, 6), (9.6, 6), stroke: (dash: "dashed", thickness: 0.6pt)) // Pelo libero
  line((6, 4), (9.6, 4), stroke: (dash: "dashed", thickness: 0.6pt)) // Quota superiore piastra
  line((0, 1), (3, 1), stroke: (dash: "dashed", thickness: 0.6pt)) // Quota inferiore piastra
  
  // Superficie inclinata principale
  line((1, -1), (8.5, 6.5), stroke: 1pt)
  
  // Tratteggio della distribuzione di pressione (linee grigie perpendicolari)
  line((3.3, 1.3), (1.42, 3.18), stroke: gray)
  line((3.6, 1.6), (1.84, 3.36), stroke: gray)
  line((3.9, 1.9), (2.26, 3.54), stroke: gray)
  line((4.2, 2.2), (2.68, 3.72), stroke: gray)
  line((4.5, 2.5), (3.10, 3.90), stroke: gray)
  line((4.8, 2.8), (3.52, 4.08), stroke: gray)
  line((5.1, 3.1), (3.94, 4.26), stroke: gray)
  line((5.4, 3.4), (4.36, 4.44), stroke: gray)
  line((5.7, 3.7), (4.78, 4.62), stroke: gray)
  
  // Contorno del trapezio delle pressioni
  line((3, 1), (1.0, 3.0), stroke: 1pt) // Base inferiore
  line((6, 4), (5.2, 4.8), stroke: 1pt) // Base superiore
  line((1.0, 3.0), (5.2, 4.8), stroke: (dash: "dashed", thickness: 1pt)) // Lato esterno
  
  // Punti notevoli
  circle((8, 6), radius: 0.06, fill: black) // Origine
  circle((4.5, 2.5), radius: 0.06, fill: black) // G
  circle((4.0, 2.0), radius: 0.06, fill: blue) // C
  
  // Vettore Spinta S (blu)
  line((2.5, 3.5), (4.0, 2.0), mark: (end: ">"), stroke: (paint: blue, thickness: 1.5pt))
  
  // Linee di quota verticali (h1, h2)
  line((9.4, 6), (9.4, 4), mark: (start: ">", end: ">"), stroke: 0.6pt)
  line((0.5, 6), (0.5, 1), mark: (start: ">", end: ">"), stroke: 0.6pt)
  
  // Linee di riferimento perpendicolari per xG e xC
  line((8, 6), (9.2, 4.8), stroke: 0.6pt)
  line((4.5, 2.5), (5.18, 1.82), stroke: 0.6pt)
  line((4.0, 2.0), (5.28, 0.72), stroke: 0.6pt)
  
  // Linee di quota parallele (xG, xC)
  line((8.6, 5.4), (5.1, 1.9), mark: (start: ">", end: ">"), stroke: 0.6pt)
  line((9.2, 4.8), (5.2, 0.8), mark: (start: ">", end: ">"), stroke: 0.6pt)
  
  // Angolo alpha
  arc((8, 6), start: 180deg, stop: 225deg, radius: 1.2, anchor: "origin", stroke: 0.6pt)
  
  // Etichette di testo
  content((9.7, 5.0), [$h_1$])
  content((0.9, 3.9), [$h_2$])
  content((6.0, 4.7), [$h_1 gamma$]) 
  content((1.6, 1.8), [$h_2 gamma$])
  content((4.2, 2.8), [$G$])
  content((3.5, 1.9), text(blue)[$C$])
  content((3.0, 2.5), text(blue)[$arrow(S)$])
  content((6.1, 3.4), [$x_G$])
  content((7.2, 3.2), [$x_C$])
  content((6.5, 5.5), [$alpha$])
})
  ]
)
#v(1em)

$ S x_c = integral_A p x dif A = integral_A (gamma x sin alpha) x dif A  quad quad ==> quad quad S x_c = gamma sin alpha integral_A x^2 dif A = gamma sin alpha I_y $
$ S x_c = gamma sin alpha integral_A x^2 dif A = gamma sin alpha I_y $
Sostituendo il modulo della spinta $S = gamma sin alpha M_y$:
$ x_c = (gamma sin alpha I_y)/(gamma sin alpha M_y) = I_y / M_y = (integral_A p x dif A)/(integral_A x dif A) $
La coordinata $x_c$ è pari al rapporto tra il Momento d'inerzia di secondo ordine ($I_y$) e il Momento statico ($M_y$), entrambi calcolati rispetto alla retta di sponda.
Procedendo analogamente per il calcolo della coordinata $y_c$ tramite l'equilibrio dei momenti rispetto all'asse $x$, si ottiene l'integrale del prodotto d'inerzia $I_(x y)$:
$ S y_c = integral_A p y dif A = gamma sin alpha integral_A x y dif A = gamma sin alpha I_(x y) quad ==> quad y_c = I_(x y) / M_y $

*Proprietà e procedimenti pratici di calcolo:*
- Se la figura piana ammette un asse di simmetria parallelo all'asse $x$ (linea di massima pendenza), il prodotto d'inerzia si annulla ($I_(x y) = 0$), da cui risulta $y_c = y_G$. Se si fa coincidere l'origine del sistema di riferimento con tale asse di simmetria, allora $y_G = 0$ e di conseguenza $y_c = 0$.
- Il calcolo di $I_y$ si effettua agevolmente ricorrendo al _teorema di Huygens-Steiner_:
  $ I_y = I_(G y) + A x_G^2 $
  Dove $I_(G y)$ è il momento d'inerzia baricentrico della figura. Essendo il termine di traslazione $A x_G^2$ sempre positivo, risulta evidente che $x_c > x_G$: il centro di spinta si trova sempre a un affondamento maggiore (o al limite uguale, per piastre orizzontali) rispetto al baricentro.
- Operativamente: bisogna sempre fissare prima e con precisione la retta di sponda (asse $y$), altrimenti le coordinate $x_G, x_c, M_y$ e $I_y$ perdono di validità.

== Spinte su superfici piane
#v(1em)

Consideriamo un fluido incomprimibile in quiete. Se consideriamo le pressioni relative, il piano in cui la pressione è nulla prende il nome di piano dei carichi idrostatici. Per calcolare la spinta su una superficie piana immersa, è fondamentale definire un sistema di riferimento. Orientiamo l'asse $y$ lungo il piano inclinato che contiene la superficie. L'intersezione di questo piano con il piano dei carichi idrostatici è detta _retta di sponda_: tutte le coordinate saranno misurate a partire da essa.


Per individuare il punto di applicazione della spinta (detto _centro di spinta_ e indicato con $y_C$), utilizziamo l'equilibrio dei momenti. Sfruttando il Teorema di Huygens-Steiner rispetto all'asse passante per il baricentro, sappiamo che il momento d'inerzia totale rispetto alla retta di sponda è $I_0 = I_G + y_G^2 A$.
Il momento statico rispetto alla retta di sponda è $M = y_G A$. Di conseguenza, la coordinata del centro di spinta si calcola come:
$ y_C &= I_0 / M \
  y_C &= (I_G + y_G^2 A) / (y_G A) \
  y_C &= I_G / (y_G A) + y_G $

Si definisce _eccentricità_ la distanza tra il centro di spinta e il baricentro della figura:
$ e = y_C - y_G = I_G / (y_G A) $
Poiché il momento d'inerzia baricentrico $I_G$, l'area $A$ e l'affondamento $y_G$ sono quantità intrinsecamente positive per superfici immerse, l'eccentricità è sempre strettamente positiva ($e > 0$).
- Il centro di spinta è sempre in posizione inferiore rispetto al baricentro (più in profondità).
- Questa formulazione è estremamente utile poiché $I_G$ dipende unicamente dalla forma geometrica dell'area $A$, indipendentemente dalla sua profondità.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Calcolo del momento d'inerzia baricentrico $I_G$ per un rettangolo di base orizzontale $a$ e altezza $b$ (lungo il piano inclinato):
    $ I_G &= integral_(-a/2)^(a/2) dif x integral_(-b/2)^(b/2) y^2 dif y \
          &= a lr([ y^3 / 3 ])_(-b/2)^(b/2) \
          &= a (b^3 / 24 - (-b^3 / 24)) \
          &= 1/12 a b^3 $
  ],
  [
    #align(center)[
      #canvas({
        import draw: *
        // Assi
        line((-2.5, 0), (2.5, 0), mark: (end: ">"), stroke: gray)
        content((2.5, 0), $x$, anchor: "west", padding: 0.1)
        line((0, -2.5), (0, 2.5), mark: (end: ">"), stroke: gray)
        content((0, 2.5), $y$, anchor: "south", padding: 0.1)
        // Rettangolo
        rect((-1.5, -2), (1.5, 2), stroke: (paint: blue, thickness: 1pt))
        // Quote
        line((-1.5, -2.3), (0, -2.3), mark: (start: ">", end: ">"))
        content((-0.75, -2.3), $a/2$, anchor: "north", padding: 0.1)
        line((0, -2.3), (1.5, -2.3), mark: (start: ">", end: ">"))
        content((0.75, -2.3), $a/2$, anchor: "north", padding: 0.1)
        line((-1.8, -2), (-1.8, 0), mark: (start: ">", end: ">"))
        content((-1.8, -0.9), $b/2$, anchor: "east", padding: 0.1)
        line((-1.8, 0), (-1.8, 2), mark: (start: ">", end: ">"))
        content((-1.8, 0.9), $b/2$, anchor: "east", padding: 0.1)
        // Baricentro
        circle((0,0), radius: 0.05, fill: black)
        content((0,0), $G$, anchor: "south-west", padding: 0.1)
      })
      #v(0.5em)
      #text(size: 0.9em, style: "italic")[Schizzo semplificato.]
    ]
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Momento d'inerzia baricentrico per una sezione circolare di diametro $d$ (o raggio $r$):
    $ I_G &= pi/64 d^4 \
          &= pi/64 (2r)^4 = pi/4 r^4 $
  ],
  [
    #align(center)[
      #canvas({
        import draw: *
        // Assi
        line((-2.5, 0), (2.5, 0), mark: (end: ">"), stroke: gray)
        content((2.5, 0), $x$, anchor: "west", padding: 0.1)
        line((0, -2.5), (0, 2.5), mark: (end: ">"), stroke: gray)
        content((0, 2.5), $y$, anchor: "south", padding: 0.1)
        // Cerchio
        circle((0,0), radius: 2, stroke: (paint: blue, thickness: 1pt))
        // Quote
        line((0,0), (1.414, 1.414), mark: (end: ">"))
        content((0.707, 0.707), $r$, anchor: "south-east", padding: 0.1)
        // Baricentro
        circle((0,0), radius: 0.05, fill: black)
        content((0,0), $G$, anchor: "north-west", padding: 0.1)
      })
      #v(0.5em)
      #text(size: 0.9em, style: "italic")[Schizzo semplificato.]
    ]
  ]
)
#v(1em)


=== Esempio: Spinta su parete verticale
#v(1em)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Consideriamo una parete rettangolare verticale. Assumiamo una larghezza trasversale unitaria, quindi l'area considerata è $A = h dot 1$. La spinta totale $S$ equivale al volume del solido delle pressioni:
    $ S = p_G A = (gamma h/2) h = gamma h^2/2 $
    
  ],
  [
    // commenti: sistema fisico (spinta idrostatica su parete verticale), elementi (parete, pelo libero del fluido, diagramma delle pressioni, punti G e C, vettore spinta S), relazioni (G a metà altezza, C a un terzo dal fondo), elementi ignorati (tratti a mano libera e tremolii, il diagramma è reso regolare).
#canvas(length: 0.8cm, {
  import draw: *
  
  // Terreno e tratteggio
  line((0.5, 0), (10, 0), stroke: 1pt)
  line((0.5, 0), (0.2, -0.3), stroke: 0.6pt)
  line((1.0, 0), (0.7, -0.3), stroke: 0.6pt)
  line((1.5, 0), (1.2, -0.3), stroke: 0.6pt)
  line((2.0, 0), (1.7, -0.3), stroke: 0.6pt)
  line((2.5, 0), (2.2, -0.3), stroke: 0.6pt)
  line((3.0, 0), (2.7, -0.3), stroke: 0.6pt)
  line((3.5, 0), (3.2, -0.3), stroke: 0.6pt)
  line((4.0, 0), (3.7, -0.3), stroke: 0.6pt)
  line((4.5, 0), (4.2, -0.3), stroke: 0.6pt)
  line((5.0, 0), (4.7, -0.3), stroke: 0.6pt)
  line((5.5, 0), (5.2, -0.3), stroke: 0.6pt)
  line((6.0, 0), (5.7, -0.3), stroke: 0.6pt)
  line((6.5, 0), (6.2, -0.3), stroke: 0.6pt)
  line((7.0, 0), (6.7, -0.3), stroke: 0.6pt)
  line((7.5, 0), (7.2, -0.3), stroke: 0.6pt)
  line((8.0, 0), (7.7, -0.3), stroke: 0.6pt)
  line((8.5, 0), (8.2, -0.3), stroke: 0.6pt)
  line((9.0, 0), (8.7, -0.3), stroke: 0.6pt)
  line((9.5, 0), (9.2, -0.3), stroke: 0.6pt)
  line((10.0, 0), (9.7, -0.3), stroke: 0.6pt)

  // Parete verticale
  rect((7, 0), (7.15, 4), stroke: 1pt, fill: white)

  // Livello del fluido
  line((0.5, 3), (7, 3), stroke: 0.6pt)
  
  // Quota h
  line((1, 1.8), (1, 3.0), stroke: 0.6pt, mark: (end: ">"))
  line((1, 1.2), (1, 0.0), stroke: 0.6pt, mark: (end: ">"))
  content((1, 1.5), $h$)

  // Fluido
  content((3.5, 1.5), $gamma$)

  // Punti G e C sulla parete
  circle((7, 1.6), radius: 0.05, fill: black, stroke: none)
  content((6.6, 1.6), $G$)
  circle((7, 1.0), radius: 0.05, fill: black, stroke: none)
  content((6.6, 1.0), $C$)

  // Spinta S
  line((5.2, 1.0), (6, 1.0), stroke: 1pt, mark: (end: ">"))
  content((5.2, 1.4), $arrow(S)$)

  // Diagramma delle pressioni
  line((7.15, 3), (7.8, 3), stroke: (thickness: 0.6pt, dash: "dashed"))
  content((8.4, 3), [p.c.i.])
  line((7.15, 3), (9, 0), stroke: (thickness: 0.6pt, dash: "dashed"))
  
  // Vettori pressione interni al diagramma
  line((7.15, 2.5), (7.46, 2.5), stroke: 0.6pt)
  line((7.15, 2.0), (7.77, 2.0), stroke: 0.6pt)
  line((7.15, 1.5), (8.08, 1.5), stroke: 0.6pt)
  line((7.15, 1.0), (8.38, 1.0), stroke: 0.6pt)
  line((7.15, 0.5), (8.69, 0.5), stroke: 0.6pt)
})
  ]
)
Che equivale rigorosamente all'integrale di superficie:
    $ S = integral_A p dif A $
    La posizione del centro di spinta si ottiene aggiungendo l'eccentricità al baricentro:
    $ y_C &= y_G + I_G / (A y_G) \
      y_C &= h/2 + (1/12 thin h^3) / (h dot (h/2)) = 2/3 h $
    La formula integrale generale per il centro di spinta è:
    $ y_C = (integral_A y p dif A) / (integral_A p dif A) $
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Se consideriamo invece una superficie posta orizzontalmente a profondità $h$, scegliendo la medesima area $A = h dot 1$, la pressione è uniforme su tutta l'estensione. In questo caso:
    $ S = p_G A = (gamma h) dot h = gamma h^2 $
    
  ],
  [
    // commenti: sistema fisico (spinta idrostatica su piastra orizzontale), elementi (fondo del serbatoio, piastra, pelo libero, diagramma delle pressioni, vettore spinta, quote), relazioni (G e C coincidenti al centro della piastra, spinta concentrata in mezzeria, andamento lineare della pressione laterale con la profondità), elementi ignorati (tratteggio a mano libera della piastra sostituito da un riempimento regolare, irregolarità e deviazioni dalle rette ideali corrette).
#canvas(length: 0.8cm, {
  import draw: *

  // Fondo orizzontale
  line((1, 0), (10.5, 0), stroke: 1pt)

  // Piastra orizzontale (riempimento e contorno separati)
  rect((3, 0), (6, 0.2), fill: gray.transparentize(80%), stroke: none)
  rect((3, 0), (6, 0.2), stroke: 1pt)

  // Pelo libero (p.c.i.)
  line((1, 3), (2.5, 3), stroke: (thickness: 0.6pt, dash: "dashed"))
  line((2.5, 3), (8.5, 3), stroke: 0.6pt)
  content((0.4, 3), [p.c.i.])

  // Quota profondità h
  line((1.5, 1.8), (1.5, 3), stroke: 0.6pt, mark: (end: ">"))
  line((1.5, 1.2), (1.5, 0), stroke: 0.6pt, mark: (end: ">"))
  content((1.5, 1.5), $h$)

  // Quota larghezza piastra h
  line((4.2, -0.4), (3, -0.4), stroke: 0.6pt, mark: (end: ">"))
  line((4.8, -0.4), (6, -0.4), stroke: 0.6pt, mark: (end: ">"))
  content((4.5, -0.4), $h$)

  // Posizione dei centri G e C
  content((4.5, -1.0), $G equiv C$)

  // Vettore spinta S concentrato
  line((4.5, 1.8), (4.5, 0.2), stroke: 1pt, mark: (end: ">"))
  content((4.9, 1.2), $arrow(S)$)

  // Peso specifico del fluido
  content((7.5, 1.5), $gamma$)

  // Diagramma delle pressioni p(z)
  line((8.5, 3), (8.5, 0), stroke: 1pt)
  line((8.5, 3), (10.5, 0), stroke: 1pt)
  line((8.5, 0), (10.5, 0), stroke: 1pt)

  // Vettori di pressione interni al diagramma
  line((8.5, 2.5), (8.83, 2.5), stroke: 0.6pt)
  line((8.5, 2.0), (9.17, 2.0), stroke: 0.6pt)
  line((8.5, 1.5), (9.50, 1.5), stroke: 0.6pt)
  line((8.5, 1.0), (9.83, 1.0), stroke: 0.6pt)
  line((8.5, 0.5), (10.17, 0.5), stroke: 0.6pt)

  // Etichetta p(z)
  content((10.3, 1.5), $p(z)$)
})
  ]
)
#v(1em)


== Spinte su superfici curve

// MODIFICA: Mantenuta la prosa originale, ma adattata la formula e la notazione (segno meno e vettore n invece del versore) come da appunti
- La forza elementare che il fluido esercita su una porzione infinitesima di superficie è sempre normale alla superficie stessa. Si esprime vettorialmente come:
  $ dif arrow(S) = -p arrow(n) dif A $
  dove $arrow(n)$ è il vettore normale rivolto verso la superficie (uscente dal fluido).
A differenza delle superfici piane, su una superficie curva il vettore normale $arrow(n)$ cambia continuamente direzione da punto a punto, per cui $arrow(n) = arrow(n)(arrow(x))$. Questo impedisce di calcolare la spinta totale con un semplice integrale scalare di superficie.
Per determinare la spinta totale, isoliamo un volume di controllo di fluido $V$ racchiuso dalla superficie curva $Omega$ e dalle sue proiezioni piane. Utilizziamo l'equazione globale dell'idrostatica (equilibrio delle forze):

// MODIFICA: Modificato l'integrale per usare rho, g e la notazione esatta degli appunti
$ integral rho arrow(g) dif V - integral p arrow(n) dif Omega = 0 $

Che si sintetizza nell'equilibrio vettoriale:

$ arrow(G) + arrow(Pi) = 0 $

// MODIFICA: Adattata la prosa per riflettere le nuove variabili introdotte nell'integrale
dove $arrow(G) = integral rho arrow(g) dif V$ è la forza peso del volume fluido e $arrow(Pi) = -integral p arrow(n) dif Omega$ è la risultante delle reazioni che le superfici di contorno esercitano _sul_ fluido. La spinta del fluido sulla parete è l'opposta, $arrow(S) = -arrow(Pi)$.

#v(1em)

=== Esempio 1: Calcolo delle componenti

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Isoliamo un volume di fluido limitato dalla superficie curva di larghezza orizzontale $b$ e altezza verticale $a$, con il fluido fino alla quota $h$ sopra il fondo. Indichiamo con $arrow(S)_0$ la spinta cercata sulla curva (la reazione esercitata dalla superficie è $arrow(Pi)_0 = -arrow(S)_0$).
  ],
  [
    #canvas(length: 0.8cm, {
  import draw: *

  // Tratteggio del terreno sotto il fondo
  line((0.4, 0), (0.1, -0.3), stroke: (paint: gray, thickness: 0.5pt))
  line((0.8, 0), (0.5, -0.3), stroke: (paint: gray, thickness: 0.5pt))
  line((1.2, 0), (0.9, -0.3), stroke: (paint: gray, thickness: 0.5pt))
  line((1.6, 0), (1.3, -0.3), stroke: (paint: gray, thickness: 0.5pt))
  line((2.0, 0), (1.7, -0.3), stroke: (paint: gray, thickness: 0.5pt))
  line((2.4, 0), (2.1, -0.3), stroke: (paint: gray, thickness: 0.5pt))
  line((2.8, 0), (2.5, -0.3), stroke: (paint: gray, thickness: 0.5pt))

  // Tratteggio del terreno a destra della parete
  line((6.4, 2.6), (6.7, 2.9), stroke: (paint: gray, thickness: 0.5pt))
  line((6.4, 3.0), (6.7, 3.3), stroke: (paint: gray, thickness: 0.5pt))
  line((6.4, 3.4), (6.7, 3.7), stroke: (paint: gray, thickness: 0.5pt))
  line((6.4, 3.8), (6.7, 4.1), stroke: (paint: gray, thickness: 0.5pt))
  line((6.4, 4.2), (6.7, 4.5), stroke: (paint: gray, thickness: 0.5pt))
  line((6.4, 4.6), (6.6, 4.8), stroke: (paint: gray, thickness: 0.5pt))

  // Superficie libera
  line((0, 4.8), (6.4, 4.8), stroke: 1pt)

  // Simbolo del livello libero
  line((1.5, 5.1), (1.9, 5.1), (1.7, 4.8), close: true, stroke: 0.6pt)
  line((1.7, 4.65), (1.7, 4.3), stroke: (dash: "dotted", thickness: 0.6pt))

  // Fondo piano
  line((0, 0), (3.2, 0), stroke: 1pt)

  // Profilo curvo a S
  bezier((3.2, 0), (4.5, 1.35), (3.9, 0), (3.9, 1.2), stroke: 1pt)
  bezier((4.5, 1.35), (6.4, 2.5), (5.1, 1.5), (6.4, 1.6), stroke: 1pt)

  // Parete verticale
  line((6.4, 2.5), (6.4, 4.8), stroke: 1pt)

  // Linee di riferimento verticali (tratto-punto)
  line((3.2, 4.4), (3.2, -0.9), stroke: (dash: "dash-dotted", thickness: 0.6pt))
  line((6.4, 2.4), (6.4, -0.9), stroke: (dash: "dash-dotted", thickness: 0.6pt))

  // Linee di riferimento orizzontali (tratteggiate)
  line((3.2, 2.5), (8.0, 2.5), stroke: (dash: "dashed", thickness: 0.6pt))
  line((3.4, 0), (8.0, 0), stroke: (dash: "dashed", thickness: 0.6pt))
  line((3.2, 1.25), (6.4, 1.25), stroke: (dash: "dashed", thickness: 0.6pt))

  // Quota h (doppia freccia con etichetta al centro)
  line((0.2, 1.8), (0.2, 4.8), mark: (end: ">"), stroke: 0.6pt)
  line((0.2, 1.2), (0.2, 0), mark: (end: ">"), stroke: 0.6pt)
  content((0.2, 1.5), [$h$])

  // Quota h - a/2 (profondità del baricentro)
  line((3.0, 4.8), (3.0, 1.25), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((3.4, 3.4), [$h - a/2$], anchor: "west")

  // Quota b
  line((4.45, -0.7), (3.2, -0.7), mark: (end: ">"), stroke: 0.6pt)
  line((5.15, -0.7), (6.4, -0.7), mark: (end: ">"), stroke: 0.6pt)
  content((4.8, -0.7), [$b$])

  // Quota a
  line((8.0, 1.55), (8.0, 2.5), mark: (end: ">"), stroke: 0.6pt)
  line((8.0, 0.95), (8.0, 0), mark: (end: ">"), stroke: 0.6pt)
  content((8.0, 1.25), [$a$])
    })
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    Imponiamo l'equilibrio alla traslazione del volume di controllo, in cui agiscono
    le spinte $arrow(Pi)_2$ (parete verticale a sinistra, altezza $a$),
    $arrow(Pi)_1$ (tetto a quota $a$, larghezza $b$), la reazione $arrow(Pi)_0$
    della curva e il peso $arrow(G)$.
    - lungo x (Equilibrio orizzontale): la spinta laterale del fluido adiacente è equilibrata dalla reazione orizzontale della curva. La parete fittizia ha altezza $a$ e il suo baricentro è a profondità $h - a/2$:
      
// MODIFICA: Inserite le formule esatte per Pi_2 e Pi_0,x, rimuovendo il riferimento a S_x come da appunti
$ Pi_2 = (h - a/2) gamma dot a quad ==> quad Pi_(0,x) = - (h - a/2) gamma a $

      Questo equivale a calcolare la spinta su una parete piana rettangolare verticale equivalente (proiezione verticale della curva), avente la stessa altezza $a$.

    - lungo z (Equilibrio verticale verso il basso): la reazione verticale della superficie curva deve sostenere il peso di tutto il fluido soprastante.
  ],
  [
#canvas(length: 1.4cm, {
  import draw: *
  
  // Contorno del volume di controllo
  line((2.8, 2.5), (2.8, 0), (3.2, 0), stroke: 1pt)
  bezier((3.2, 0), (4.5, 1.35), (3.9, 0), (3.9, 1.2), stroke: 1pt)
  bezier((4.5, 1.35), (5.8, 2.5), (5.1, 1.5), (5.8, 1.6), stroke: 1pt)
  line((5.8, 2.5), (2.8, 2.5), stroke: 1pt)
  
  // Forza di pressione Pi_2 sulla parete sinistra (orizzontale verso destra)
  line((2, 1.25), (2.8, 1.25), mark: (end: ">"), stroke: 1pt)
  content((1.9, 1.65), [$arrow(Pi)_2$])
  
  // Forza di pressione Pi_1 sul tetto (verticale verso il basso)
  line((3.5, 3.7), (3.5, 2.5), mark: (end: ">"), stroke: 1pt)
  content((4.1, 3.1), [$arrow(Pi)_1$])
  
  // Forza di pressione Pi_0 sulla parete curva (obliqua, puntata verso il flesso)
  line((5.4, 0.45), (4.5, 1.35), mark: (end: ">"), stroke: 1pt)
  content((6.0, 0.7), [$arrow(Pi)_0$])
  
  // Forza peso G (interna, verticale verso il basso)
  line((3.8, 1.8), (3.8, 0.8), mark: (end: ">"), stroke: 1pt)
  content((3.4, 1.3), [$arrow(G)$])
})
  ]
)
#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    Il tetto fittizio, a profondità $h - a$ sotto il PCI, sostiene la colonna di fluido sovrastante di volume $V_1$; il volume racchiuso tra il tetto e la curva è $V_2$:
    
// MODIFICA: Sostituite le formule con l'equilibrio e la convenzione dei segni scritta negli appunti (-gamma V_2)
  $ Pi_1 = (h - a) gamma b = gamma V_1 $ 

  $ G = -gamma V_2 $

  $ Pi_1 + G = -Pi_(0,z) $

  $ -> Pi_(0,z) = + gamma (V_1 + V_2) $
    
  ],
  [
#canvas(length: 0.8cm, {
  import draw: *
  
  // CONTORNO PRINCIPALE CONTINUO
  // Parete sinistra
  line((0, 7), (0, 0), stroke: 1pt)
  // Curva a S (metà inferiore, parte orizzontale)
  bezier((0, 0), (2.5, 1.75), (1.3, 0), (1.5, 0.8), stroke: 1pt)
  // Curva a S (metà superiore, arriva verticale alla parete)
  bezier((2.5, 1.75), (5, 3.5), (3.5, 2.7), (5, 2.5), stroke: 1pt)
  // Parete destra superiore
  line((5, 3.5), (5, 7), stroke: 1pt)
  
  // ELEMENTI INTERNI E SUPERFICIE
  // Pelo libero / PCI (linea tratteggiata superiore)
  line((0, 7), (5, 7), stroke: (dash: "dashed", thickness: 0.6pt))
  // Linea di separazione tra volume V1 e V2
  line((0, 3.5), (5, 3.5), stroke: (dash: "dashed", thickness: 0.6pt))
  // Trattino verticale al centro della linea di separazione
  line((2.5, 3.4), (2.5, 3.6), stroke: 1pt)
  
  // SIMBOLO DEL PELO LIBERO
  line((2.3, 7.3), (2.7, 7.3), (2.5, 7.0), close: true, stroke: 0.6pt)
  
  // ETICHETTE VOLUMI
  content((3.0, 5.25), [$V_1$])
  content((1.5, 2.0), [$V_2$])
  
  // QUOTE E RIFERIMENTI
  // Quota b (larghezza base)
  line((0, 0), (0, -1.2), stroke: (dash: "dashed", thickness: 0.6pt))
  line((5, 1.5), (5, -1.2), stroke: (dash: "dashed", thickness: 0.6pt)) // Estensione dal profilo destro
  line((0, -0.8), (2.2, -0.8), mark: (start: ">"), stroke: 0.6pt)
  line((2.8, -0.8), (5, -0.8), mark: (end: ">"), stroke: 0.6pt)
  content((2.5, -0.8), [$b$])
  
  // Quota a (altezza inferiore, lato sinistro)
  content((-0.4, 1.75), [$a$])
  
  // Quota (h-a) (altezza superiore, lato sinistro)
  content((-1.2, 5.25), [$(h-a)$])
  line((-1.2, 5.7), (-1.2, 6.8), mark: (end: ">"), stroke: 0.6pt)
  line((-1.2, 4.8), (-1.2, 3.7), mark: (end: ">"), stroke: 0.6pt)
  
  // Quota h (altezza totale, lato destro)
  line((6, 0), (6, 7), mark: (start: ">", end: ">"), stroke: 0.6pt)
  content((6.4, 3.5), [$h$])
})
  ]
)
#pagebreak()
*Regola generale:* la componente verticale della spinta su una superficie curva è pari al peso del volume di fluido (reale o virtuale) compreso tra la superficie e il piano dei carichi idrostatici. È diretta verso il basso se il fluido sta sopra la superficie, verso l'alto se è sotto.
#v(1em)

// MODIFICA: Adattata la prosa e le formule sostituendo le dipendenze da S_x, S_z con le componenti di Pi usate negli appunti
Una volta note le componenti $Pi_(0,x)$ e $Pi_(0,z)$, il modulo della reazione totale è calcolabile con il teorema di Pitagora, e la sua direttrice tramite il rapporto delle componenti:

$ Pi_0 = sqrt(Pi_(0,x)^2 + Pi_(0,z)^2) quad &"modulo" $
$ op("tg") alpha = Pi_(0,z) / Pi_(0,x) quad &"direzione" $

con $alpha$ l'angolo della spinta rispetto all'orizzontale. La spinta del fluido è $arrow(S) = -arrow(Pi)_0$. 
Il punto d'applicazione? $==>$ Eq. momenti (vedi più avanti).

=== Esempio 1: Punto di applicazione

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + horizon, center + horizon),
  [
    // MODIFICA: Introdotto il polo x_a e la nota sulla rimozione delle forze peso, mantenendo il resto della prosa coerente
    Per trovare la retta d'azione, calcoliamo l'equilibrio alla rotazione dell'intero volume di controllo rispetto a un polo opportuno $arrow(x)_a$ 
    ( in tal modo elimino dal bilancio il momento indotto dalle forze peso).
    
    Uguagliando i momenti orari e antiorari:
    $ underbrace(Pi_0 b_0 + Pi_1 b_1, "momenti orari")
      = underbrace(Pi_2 b_2, "momenti anti-orari") $
    dove $b_0$, $b_1$, $b_2$ sono i bracci delle rispettive forze rispetto al polo.
  ],
  [
#canvas(length: 1cm, {
  import draw: *
  
  // Superfici fittizie (tratteggiate)
  line((1.5, 1), (1.5, 6.5), stroke: (dash: "dashed", thickness: 1pt))
  line((1.5, 6.5), (7, 6.5), stroke: (dash: "dashed", thickness: 1pt))
  
  // Superfici reali (continue)
  // Fondo orizzontale
  line((1.5, 1), (2.5, 1), stroke: 1pt)
  // Curva inferiore
  bezier((2.5, 1), (4.5, 3), (3.5, 1), (4, 2.5), stroke: 1pt)
  // Curva superiore
  bezier((4.5, 3), (7, 6.5), (5, 3.5), (7, 4.5), stroke: 1pt)
  
  // Polo dei momenti (baricentro del volume di controllo)
  circle((4, 4.5), radius: 0.07, fill: black)
  
  
  // --- FORZE E BRACCI ---
  
  // Forza Pi_1 (spinta superiore)
  line((5.5, 7.5), (5.5, 6.5), mark: (end: ">"), stroke: 1pt)
  content((5.9, 7.5), [$arrow(Pi)_1$])
  // Linea di azione e braccio b_1 (rosso)
  line((5.5, 6.5), (5.5, 4.5), stroke: (paint: red, dash: "dashed", thickness: 0.6pt))
  line((4, 4.5), (5.5, 4.5), stroke: (paint: red, thickness: 0.6pt))
  content((4.8, 4.8), text(fill: red)[$b_1$])
  
  // Forza Pi_2 (spinta sinistra)
  line((0.3, 2.0), (1.5, 2.0), mark: (end: ">"), stroke: 1pt)
  content((0.5, 2.5), [$arrow(Pi)_2$])
  // Linea di azione e braccio b_2 (verde)
  line((1.5, 2.0), (4, 2.0), stroke: (paint: green, dash: "dashed", thickness: 0.6pt))
  line((4, 4.5), (4, 2.0), stroke: (paint: green, thickness: 0.6pt))
  content((3.6, 3.0), text(fill: green)[$b_2$])
  content((3.6, 4.7), text(fill: blue)[$b_0$])
  // Forza Pi_0 (reazione parete) applicata sul flesso (4.5, 3)
  line((6.0, 1.5), (4.5, 3.0), mark: (end: ">"), stroke: 1pt)
  content((6.2, 1.2), [$arrow(Pi)_0$])
  line((4.5, 3.0), (3, 4.5), stroke: (paint: blue, dash: "dashed", thickness: 0.8pt))
  line((3, 4.5), (3, 5.5), mark: (end: ">"), stroke: (paint: blue, thickness: 0.8pt))
  line((3.0, 4.5),(4, 4.5), stroke: (paint: blue, thickness: 0.8pt))
  // Forza peso G: passa per il polo, braccio nullo
  line((4, 4.5), (4, 3.5), mark: (end: ">"), stroke: 1pt)
  content((4.4, 4), [$arrow(G)$])
})
  ]
)
#v(1em)

Scegliendo astutamente il polo di rotazione (ad esempio nel centro di curvatura se la superficie è circolare), è possibile semplificare drasticamente l'equazione, eliminando dal bilancio i momenti indotti dalle forze peso o da spinte la cui direttrice passa per il polo stesso (braccio nullo).

Risolvendo per il braccio di $arrow(Pi)_0$:

$ b_0 = (Pi_2 b_2 - Pi_1 b_1) / Pi_0 $

La retta d'azione di $arrow(S)_0$ coincide con quella di $arrow(Pi)_0$ (stessa direzione, verso opposto) e dista $b_0$ dal polo.

// MODIFICA: Aggiunta la sezione sui Corpi Immersi derivata dalla terza pagina degli appunti originali
#v(1em)
#v(1em)
//caca
== Spinta di galleggiamento (Archimede) e Stabilità

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Se immergiamo un corpo in un fluido, le forze di pressione agiscono su tutta la sua superficie chiusa $Omega$. Integrando queste pressioni, la forza netta esercitata dal fluido sul corpo è data da:
    
    $ arrow(S)_"gall" = arrow(F)_"sotto" - arrow(F)_"sopra" $
    (applicata al baricentro)
    
    // MODIFICA: Sostituito il versore hat(n) con il vettore normale arrow(n) usato nella tua notazione
    dove $arrow(n)$ è la normale alla superficie, uscente dal corpo. La componente orizzontale netta dell'integrale si annulla, mentre emerge una forza verticale netta diretta verso l'alto, detta spinta di galleggiamento.
    
    // MODIFICA: Sostituita la formula vettoriale con hat(k) inserendo invece le relazioni scalari esatte presenti negli appunti
    $ F_"sopra" = gamma V_1 $
    $ S_"gall" = gamma V $
    
  ],
  [
    // FASE 0 - COMPRENSIONE
// Il disegno illustra la dimostrazione del principio di Archimede (spinta idrostatica su un corpo immerso).
// Sono presenti: il piano dei carichi idrostatici (p.c.i.) con il simbolo del pelo libero, un corpo immerso di forma generica (campito a righe nere), le proiezioni verticali (in rosso) che delimitano il cilindro fluido sovrastante, il volume V1 sovrastante la superficie superiore (campito a righe rosse), il volume complessivo V2 fino alla superficie inferiore (campito a righe verdi), le piccole frecce della distribuzione di pressione lungo tutto il contorno e le risultanti verticali F_sopra (verso il basso) e F_sotto (verso l'alto).

// FASE 1 - ANALISI
// 1. PANNELLI E SCALA
// Un solo pannello. Dimensioni immagine circa 600 x 560 px.
// Scelgo origine O = (0, 0) in basso a sinistra, N = 75 px/cm -> larghezza circa 8.0 cm, altezza circa 7.2 cm.
// Piano dei carichi idrostatici (p.c.i.): retta orizzontale a quota y = 6.2.

// 2. ELEMENTI E CLASSIFICAZIONE DEL CONTORNO DEL CORPO
// Il corpo immerso ha una forma chiusa generica (patata idrostatica) con concavità variabili e flessi lungo il fianco sinistro e destro.
// Punti estremi di tangenza verticale (che definiscono i limiti del cilindro di proiezione):
// Estremo sinistro: P_L = (0.8, 3.7), tangente verticale T = (0, -1).
// Estremo destro:   P_R = (5.8, 2.2), tangente verticale T = (0, -1).
// Estremo superiore piatto/colmo: P_T = (3.4, 4.5), tangente orizzontale T = (1, 0).
// Estremo inferiore (fondo):      P_B = (3.6, 1.3), tangente orizzontale T = (1, 0).
//
// Campioni del contorno chiuso (in senso orario a partire da P_L):
// i |   x   |   y   | note
// 0 | 0.80  | 3.70  | estremo sinistro P_L (tangente verticale)
// 1 | 1.30  | 4.35  | spalla superiore sinistra
// 2 | 2.30  | 4.48  | tratto superiore quasi piatto
// 3 | 3.40  | 4.50  | colmo superiore P_T (tangente orizzontale)
// 4 | 4.65  | 4.25  | spalla superiore destra
// 5 | 5.15  | 3.55  | flesso fianco destro P_FR
// 6 | 5.45  | 2.90  | rientranza destra
// 7 | 5.80  | 2.20  | estremo destro P_R (tangente verticale)
// 8 | 5.20  | 1.55  | pancia inferiore destra
// 9 | 3.60  | 1.30  | fondo P_B (tangente orizzontale)
// 10| 2.15  | 1.75  | pancia inferiore sinistra
// 11| 1.75  | 2.65  | flesso fianco sinistro P_FL
// 12| 1.15  | 3.20  | rientranza sinistra
//
// Test del cerchio sul contorno: raggio medio circa 2.1, ma scarto massimo e_max = 0.34 > 0.08 -> fallito.
// Test dell'ellisse con assi paralleli: cx = 3.3, cy = 2.9, a = 2.5, b = 1.6 -> sul campione 5 e 11 e_max = 0.28 > 0.08 -> fallito.
// Inoltre sono presenti 2 flessi evidenti (uno sul fianco sinistro in P_FL=(1.65, 2.75) e uno sul fianco destro in P_FR=(5.25, 3.40)).
// // BEZIER NECESSARIO: cerchio e_max = 0.34, ellisse e_max = 0.28, presenza di flessi sui fianchi.
// Suddivido il contorno in 6 tratti di Bezier cubici con giunzioni C1 (stesse coordinate e stessa tangente unitaria nei punti di raccordo):
// Tratto 1 (P_L -> P_T): da (0.80, 3.70) con T0=(0, 1) a (3.40, 4.50) con T3=(1, 0).
//   Controlli: C1 = (0.80, 4.45), C2 = (2.00, 4.50).
// Tratto 2 (P_T -> P_FR): da (3.40, 4.50) con T0=(1, 0) a (5.25, 3.40) con T3=(0.24, -0.97).
//   Controlli: C1 = (4.60, 4.50), C2 = (5.10, 4.00).
// Tratto 3 (P_FR -> P_R): da (5.25, 3.40) con T0=(0.24, -0.97) a (5.80, 2.20) con T3=(0, -1).
//   Controlli: C1 = (5.40, 2.80), C2 = (5.80, 2.65).
// Tratto 4 (P_R -> P_B): da (5.80, 2.20) con T0=(0, -1) a (3.60, 1.30) con T3=(-1, 0).
//   Controlli: C1 = (5.80, 1.50), C2 = (4.80, 1.30).
// Tratto 5 (P_B -> P_FL): da (3.60, 1.30) con T0=(-1, 0) a (1.65, 2.75) con T3=(-0.60, 0.80).
//   Controlli: C1 = (2.30, 1.30), C2 = (2.05, 2.20).
// Tratto 6 (P_FL -> P_L): da (1.65, 2.75) con T0=(-0.60, 0.80) a (0.80, 3.70) con T3=(0, 1).
//   Controlli: C1 = (1.25, 3.30), C2 = (0.80, 3.25).

// 3. LINEE DI PROIEZIONE, TRATTEGGI E VETTORI
// - Retta p.c.i.: da (0.1, 6.2) a (7.4, 6.2).
// - Simbolo pelo libero: triangolo a (1.5, 6.2) - (1.3, 6.5) - (1.7, 6.5), più segmenti sottostanti.
// - Linee verticali rosse di proiezione:
//   Sinistra: da (0.80, 3.70) a (0.80, 6.20) (tratteggiata a tratti lunghi nella parte alta come nello schizzo, realizzata con segmenti rossi).
//   Destra: da (5.80, 2.20) a (5.80, 6.20) (linea continua rossa).
// - Campitura rossa (V1, sopra il corpo): linee parallele inclinate da basso-sinistra ad alto-destra.
// - Campitura verde (V2, da p.c.i. fino al fondo del corpo): linee parallele inclinate da alto-sinistra a basso-destra.
// - Campitura nera (corpo): 4 segmenti paralleli inclinati da basso-sinistra ad alto-destra interni al corpo.
// - Frecce di pressione: 17 piccole frecce nere lungo tutto il perimetro con punta sul contorno.
// - Forze risultanti:
//   F_sopra: freccia doppia verticale da (3.60, 5.55) a (3.60, 4.50).
//   F_sotto: freccia doppia verticale da (3.20, 0.25) a (3.20, 1.32).

// FASE 2 - COSTRUZIONE
#canvas(length: 1cm, {
  import draw: *


  line((0.80, 3.70), (0.80, 6.20), stroke: (paint: rgb(205, 65, 85), thickness: 0.9pt))
  // Proiezione destra (continua)
  line((5.80, 2.20), (5.80, 6.20), stroke: (paint: rgb(205, 65, 85), thickness: 0.9pt))

  // 3. CONTORNO DEL CORPO IMMERSO (6 BEZIER C1-CONTINUI)
  bezier((0.80, 3.70), (3.40, 4.50), (0.80, 4.45), (2.00, 4.50), stroke: 1.1pt)
  bezier((3.40, 4.50), (5.25, 3.40), (4.60, 4.50), (5.10, 4.00), stroke: 1.1pt)
  bezier((5.25, 3.40), (5.80, 2.20), (5.40, 2.80), (5.80, 2.65), stroke: 1.1pt)
  bezier((5.80, 2.20), (3.60, 1.30), (5.80, 1.50), (4.80, 1.30), stroke: 1.1pt)
  bezier((3.60, 1.30), (1.65, 2.75), (2.30, 1.30), (2.05, 2.20), stroke: 1.1pt)
  bezier((1.65, 2.75), (0.80, 3.70), (1.25, 3.30), (0.80, 3.25), stroke: 1.1pt)

  // 4. PIANO DEI CARICHI IDROSTATICI (p.c.i.) E SIMBOLO PELO LIBERO
  line((0.10, 6.20), (7.40, 6.20), stroke: 1pt)
  // Triangolo pelo libero
  line((1.50, 6.20), (1.30, 6.45), (1.70, 6.45), close: true, stroke: 1.1pt)
  // Lineette sotto il pelo libero
  line((1.32, 5.98), (1.62, 5.98), stroke: 1.1pt)
  line((1.42, 5.86), (1.55, 5.86), stroke: 1.1pt)

  // 5. DISTRIBUZIONE DI PRESSIONE (FRECCE NERE SUL CONTORNO)
  // Parte superiore (verso il basso)
  line((0.60, 4.45), (0.96, 4.18), mark: (end: ">"), stroke: 0.9pt)
  line((1.40, 4.88), (1.45, 4.42), mark: (end: ">"), stroke: 0.9pt)
  line((2.15, 5.02), (2.18, 4.50), mark: (end: ">"), stroke: 0.9pt)
  line((3.15, 5.02), (3.18, 4.52), mark: (end: ">"), stroke: 0.9pt)
  line((4.45, 4.90), (4.30, 4.38), mark: (end: ">"), stroke: 0.9pt)

  // Fianco destro (verso sinistra / basso-sinistra)
  line((5.85, 4.10), (5.12, 3.82), mark: (end: ">"), stroke: 0.9pt)
  line((5.78, 3.45), (5.35, 3.22), mark: (end: ">"), stroke: 0.9pt)
  line((6.15, 2.80), (5.70, 2.62), mark: (end: ">"), stroke: 0.9pt)

  // Parte inferiore (verso l'alto / alto-sinistra)
  line((6.20, 1.75), (5.68, 1.85), mark: (end: ">"), stroke: 0.9pt)
  line((5.22, 1.10), (5.10, 1.52), mark: (end: ">"), stroke: 0.9pt)
  line((4.42, 0.90), (4.45, 1.34), mark: (end: ">"), stroke: 0.9pt)
  line((3.50, 0.80), (3.52, 1.28), mark: (end: ">"), stroke: 0.9pt)
  line((2.60, 0.85), (2.68, 1.40), mark: (end: ">"), stroke: 0.9pt)
  line((1.72, 1.25), (2.15, 1.58), mark: (end: ">"), stroke: 0.9pt)

  // Fianco sinistro (verso alto-destra / destra)
  line((1.38, 1.80), (1.92, 2.18), mark: (end: ">"), stroke: 0.9pt)
  line((1.18, 2.38), (1.60, 2.68), mark: (end: ">"), stroke: 0.9pt)
  line((0.62, 2.88), (1.08, 3.15), mark: (end: ">"), stroke: 0.9pt)
  line((0.25, 3.60), (0.75, 3.62), mark: (end: ">"), stroke: 0.9pt)

  // 6. VETTORI RISULTANTI (DOPPIA LINEA COME NELLO SCHIZZO)
  // F_sopra (verso il basso)
  line((3.57, 5.55), (3.55, 4.58),mark: (end: ">"), stroke: 1.5pt)
  

  // F_sotto (verso l'alto)
  line((3.16, 0.25), (3.19, 1.22),mark: (end: ">"), stroke: 1.5pt)
  

  // 7. FRECCE INDICATRICI DEI VOLUMI ED ETICHETTE
  // Indicatore rosso per V1
  bezier((6.35, 5.35), (5.40, 4.90), (6.00, 5.20), (5.70, 5.08), stroke: (paint: rgb(205, 65, 85), thickness: 0.8pt), mark: (end: ">"))
  content((6.20, 5.65), text(fill: rgb(205, 65, 85), size: 14pt)[$V_1$], anchor: "west")

  // Indicatore verde per V2
  bezier((1.00, 1.60), (2.20, 2.45), (1.35, 2.00), (1.80, 2.30), stroke: (paint: rgb(90, 165, 115), thickness: 0.8pt), mark: (end: ">"))
  content((0.35, 1.60), text(fill: rgb(90, 165, 115), size: 14pt)[$V_2$], anchor: "west")

  // Etichetta p.c.i.
  content((6.00, 6.55), text(size: 14pt)[p.c.i], anchor: "west")

  // Etichetta F_sopra
  content((3.95, 5.45), text(size: 14pt)[$arrow(F)_"sopra"$], anchor: "west")

  // Etichetta F_sotto
  content((3.35, 0.28), text(size: 14pt)[$arrow(F)_"sotto"$], anchor: "west")
})

  ]
)
#v(1em)
*Principio di Archimede:* un corpo immerso riceve una spinta verticale verso l'alto di modulo pari al peso del volume di fluido spostato ($S_"gall" = gamma V$).
    
    Il peso proprio del corpo è $arrow(P) = gamma_s V hat(k)$. Il comportamento cinematico dipenderà dalla densità del solido rispetto a quella del fluido:
    - $gamma_s > gamma ==>$ il corpo *affonda*.
    - $gamma_s = gamma ==>$ equilibrio *indifferente* (resta sospeso).
    - $gamma_s < gamma ==>$ il corpo *galleggia* (risale fino a spostare un volume di fluido inferiore, in modo che il peso di questo fluido eguagli il peso totale del corpo).
    
    La grandezza vettoriale $arrow(P) + arrow(S)_"gall" = (gamma_s - gamma) V hat(k)$ rappresenta il cosiddetto "peso apparente" del corpo in acqua.
*Stabilità dell'equilibrio:*\
    Oltre alla traslazione, è fondamentale valutare la stabilità alla rotazione. La spinta di galleggiamento è sempre applicata nel baricentro del volume di fluido spostato, chiamato _centro di galleggiamento_ $C$, mentre la forza peso è applicata nel baricentro geometrico del corpo $G$.\
    Un corpo completamente immerso è in equilibrio stabile alle rotazioni solo se il suo baricentro $G$ si trova fisicamente al di sotto del centro di galleggiamento $C$. In caso contrario, ogni minima perturbazione genererà un momento ribaltante.

#pagebreak()
= Cinematica dei Fluidi e Bilancio di Massa

== Cinematica dei Fluidi

Per poter studiare un fluido continuo trascurandone la natura corpuscolare, introduciamo il concetto di *scala macroscopica* $L$. Affinché l'ipotesi di continuo sia valida, il cammino libero medio delle molecole $l$ deve essere trascurabile rispetto a $L$. Definiamo quindi il numero di Knudsen:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $l$: cammino libero medio 
    $ cases(
      "aria" = 6 dot 10^(-8) "m",
      "acqua" = 3 dot 10^(-10) "m"
    ) $
    Numero di Knudsen:
    $ "Kn" = l/L lt.double 1 $
    
    $L$: scala macroscopica del problema.
    Sotto questa ipotesi, ha senso definire le grandezze macroscopiche del fluido.
  ],
  [
    #canvas(length: 1cm, {
      import draw: *

      // Assi cartesiani
      line((1, 1), (11, 1), mark: (end: ">"), stroke: 1pt)
      line((1, 1), (1, 5), mark: (end: ">"), stroke: 1pt)

      // Etichette degli assi
      content((0.4, 4.5), [$n/r^3$])
      content((11, 0.5), [$r$])
      // Ticks ed etichette asse X
      line((2.5, 0.9), (2.5, 1.1), stroke: 0.6pt)
      content((2.5, 0.4), [$10^{-10}$])

      line((4.5, 0.9), (4.5, 1.1), stroke: 0.6pt)
      content((4.5, 0.4), [$10^{-3}$])

      line((7.0, 0.9), (7.0, 1.1), stroke: 0.6pt)
      content((7.0, 0.4), [$10^{-6}$])

      line((9.5, 0.9), (9.5, 1.1), stroke: 0.6pt)
      content((9.5, 0.4), [$10^{-4}$])

      // Testi in basso
      content((6.0, -0.3), [$1 mu "m"$])
      content((6.0, -1.0), [particella fluida])

      // Linee di riferimento verticali per le scale mesoscopiche
      line((4.0, 1.0), (4.0, 4.0), stroke: (paint: blue, dash: "dashed", thickness: 0.6pt))
      content((3.8, 4.3), text(blue)[$l$])

      line((4.8, 1.0), (4.8, 4.0), stroke: (paint: black, dash: "dashed", thickness: 0.6pt))
      content((5.2, 4.3), text(blue)[$d$])

      // Curva di densità: fluttuazioni microscopiche seguite da plateau macroscopico
      bezier((1.2, 1.0), (1.8, 4.5), (1.5, 1.0), (1.6, 4.5), stroke: 1pt)
      bezier((1.8, 4.5), (2.2, 2.5), (2.0, 4.5), (2.0, 2.5), stroke: 1pt)
      bezier((2.2, 2.5), (2.8, 3.6), (2.5, 2.5), (2.5, 3.6), stroke: 1pt)
      bezier((2.8, 3.6), (3.3, 2.5), (3.0, 3.6), (3.0, 2.5), stroke: 1pt)
      bezier((3.3, 2.5), (3.8, 3.3), (3.5, 2.5), (3.5, 3.3), stroke: 1pt)
      bezier((3.8, 3.3), (4.2, 2.8), (4.0, 3.3), (4.0, 2.8), stroke: 1pt)
      bezier((4.2, 2.8), (4.5, 3.1), (4.35, 2.8), (4.35, 3.1), stroke: 1pt)
      bezier((4.5, 3.1), (4.8, 2.95), (4.65, 3.1), (4.65, 2.95), stroke: 1pt)
      bezier((4.8, 2.95), (5.1, 3.05), (4.95, 2.95), (4.95, 3.05), stroke: 1pt)
      bezier((5.1, 3.05), (5.5, 3.0), (5.3, 3.05), (5.3, 3.0), stroke: 1pt)
      line((5.5, 3.0), (10.5, 3.0), stroke: 1pt)
      
      // Punto finale
      circle((10.5, 3.0), radius: 0.05, fill: black, stroke: none)
    })
  ]
)
#v(1em)

Definiamo le grandezze macroscopiche, come la densità e la velocità, mediando le proprietà microscopiche su un volumetto di controllo:
$ rho = m/cal(V) quad "dove" quad m = sum_alpha m_alpha $
$ bold(u) = (sum_alpha m_alpha bold(u)_alpha) / m quad prop ("quantità di moto delle molecole") / ("massa totale") $

== Equilibrio Locale e Approcci Descrittivi
Definiamo la _particella fluida_ come un dominio di dimensione $d$ tale che $ d L$. Questa può essere vista come un "punto materiale" macroscopico, che si muove nel dominio con la velocità locale del fluido definita come $bold(u) equiv (dif bold(x)) / (dif t)$.

Per rappresentare l'evoluzione dei campi fisici nel tempo, possiamo adottare due approcci complementari: quello Lagrangiano e quello Euleriano.

=== Approccio Lagrangiano
Seguiamo le singole particelle lungo le loro traiettorie. La posizione di una particella è identificata dalla sua posizione iniziale $bold(a)$ al tempo $t_0$:
$ bold(x) = bold(x)(bold(a), t) $
La velocità e l'accelerazione sono calcolate seguendo la particella:
$ u_i = ( (partial x_i) / (partial t) )_bold(a) quad , quad a_i = ( (partial^2 x_i) / (partial t^2) )_bold(a) $
Questo metodo traccia le particelle dal loro punto di iniezione. È molto intuitivo e utile per lo studio del trasporto di inquinanti, ma risulta matematicamente complesso da gestire per un intero campo fluido tridimensionale.

// TODO: inserire figura della slide 22, "Streamlines and pathlines (cont.)"
// didascalia suggerita: Traiettoria Lagrangiana di una particella fluida a partire dalla posizione iniziale a.
// #image("placeholder_fig_22.png", width: 70%)

=== Approccio Euleriano
Osserviamo ciò che accade in punti fissi dello spazio al variare del tempo. Le grandezze, come la velocità, sono funzioni della posizione spaziale $bold(x)$ e del tempo $t$:
$ bold(u) = bold(u)(bold(x), t) $
I due punti di vista sono legati dalla definizione cinematica della traiettoria:
$ (dif bold(x)) / (dif t) = bold(u)(bold(x), t) quad ("velocità euleriana locale") $
Integrando il campo di velocità euleriano, è possibile ricostruire le traiettorie delle particelle.

Il campo Euleriano può essere descritto "visivamente" tramite le _linee di corrente_ (streamlines). Queste sono curve che, in un dato istante di tempo $t$, sono tangenti in ogni punto al vettore velocità $bold(u)$. Matematicamente, si ottengono imponendo che il vettore spostamento elementare $dif bold(x)$ sia parallelo alla velocità:
$ bold(u) times dif bold(x) = bold(0) $
Espandendo il prodotto vettoriale (o equivalentemente annullando il determinante formato dai due vettori):
$ op("det") mat(delim: "|", hat(e)_1, hat(e)_2, hat(e)_3; u, v, w; dif x, dif y, dif z) &= mat(delim: "|", v dif z - w dif y; -u dif z + w dif x; u dif y - v dif x) = mat(delim: "|", 0; 0; 0) $

== Derivata Materiale (o Sostanziale)
Per una particella in moto, la definizione di accelerazione differisce tra i due approcci:
- In ambito *Lagrangiano*, l'accelerazione è semplicemente la derivata temporale della velocità della singola particella: $a_i = (dif u_i / dif t)_bold(a)$.
- In ambito *Euleriano*, le derivate parziali rispetto al tempo indicano la variazione in un punto *fisso* dello spazio, senza seguire il fluido.

Se vogliamo valutare come cambia una proprietà generica $phi = phi(bold(x), t)$ seguendo il moto della particella fluida nel campo euleriano, dobbiamo usare il differenziale totale:
$ dif phi = (partial phi)/(partial t) dif t + (partial phi)/(partial x_i) dif x_i = (partial phi)/(partial t) dif t + dif bold(x) dot nabla phi $
Dividendo per l'intervallo di tempo $dif t$, e ricordando che per una particella in moto $(dif x_i)/(dif t) = u_i$, otteniamo la _derivata materiale_ (o covettiva), indicata con $D/D_t$:
$ (D phi)/(D t) equiv (partial phi)/(partial t) + u_i (partial phi)/(partial x_i) = (partial phi)/(partial t) + bold(u) dot nabla phi $

Il primo termine, $(partial phi)/(partial t)$, è il tasso locale di variazione, mentre il secondo termine, $bold(u) dot nabla phi$, è il tasso convettivo indotto dal moto del fluido attraverso i gradienti spaziali.
A seconda del comportamento del campo di velocità euleriano, definiamo il moto:
- *Moto vario (instazionario)*: $bold(u) = bold(u)(bold(x), t)$.
- *Moto permanente (stazionario)*: $bold(u) = bold(u)(bold(x))$, le derivate parziali temporali sono nulle.
- *Moto uniforme*: $bold(u) = "costante"$, i gradienti spaziali sono nulli.

#pagebreak()

== Bilancio di Massa
Per studiare i bilanci macroscopici, consideriamo un dominio $cal(D)$ e la sua superficie di contorno $cal(S)$. Distinguiamo:
- *Volume di controllo*: un dominio fisso nello spazio, in cui la velocità della superficie è $bold(u)_S(bold(x), t) = bold(0)$.
- *Dominio materiale*: un volume che si muove e si deforma seguendo esattamente le particelle fluide, quindi la velocità della superficie coincide con quella del fluido, $bold(u)_S(bold(x), t) = bold(u)(bold(x), t)$.

Data una grandezza integrale $Phi(t) = integral_{cal(D)} phi(bold(x), t) dif cal(V)$, il Teorema del Trasporto di Reynolds esprime la sua derivata temporale:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    $ (dif Phi)/(dif t) = integral_(cal(D)(t)) (partial phi)/(partial t) dif cal(V) + integral_(cal(S)(t)) phi bold(u)_S dot hat(n) dif cal(S) $
    Questo teorema generalizza la regola di Leibniz per volumi a confini variabili nello spazio tridimensionale.
  ],
  [
    
#canvas(length: 1cm, {
  import draw: *

  // Contorno chiuso del dominio D(t) / V_s(t)
  bezier((2.00, 4.10), (3.85, 4.80), (1.75, 4.60), (3.20, 5.20), stroke: 1.2pt)
  bezier((3.85, 4.80), (5.20, 1.80), (4.50, 4.40), (5.85, 2.90), stroke: 1.2pt)
  bezier((5.20, 1.80), (3.45, 2.30), (4.65, 0.90), (3.45, 1.50), stroke: 1.2pt)
  bezier((3.45, 2.30), (2.00, 4.10), (3.45, 3.20), (2.25, 3.60), stroke: 1.2pt)

  // Linee di corrente (archi di cerchio)
  arc((6.93, -3.55), start: 112.1deg, stop: 141.5deg, radius: 8.85, anchor: "origin", stroke: 1.1pt)
  arc((7.80, -3.50), start: 109.5deg, stop: 148.5deg, radius: 8.45, anchor: "origin", stroke: 1.1pt)
  arc((9.50, -4.20), start: 113.0deg, stop: 149.8deg, radius: 8.35, anchor: "origin", stroke: 1.1pt)

  // Frecce di direzione lungo la linea di corrente S1
  line((0.94, 2.96), (1.01, 3.03), mark: (end: ">", size: 0.25), stroke: 1.1pt)
  line((2.69, 4.21), (2.78, 4.26), mark: (end: ">", size: 0.25), stroke: 1.1pt)

  // Frecce di direzione lungo la linea di corrente S2
  line((1.65, 2.30), (1.72, 2.37), mark: (end: ">", size: 0.25), stroke: 1.1pt)
  line((3.49, 3.77), (3.58, 3.82), mark: (end: ">", size: 0.25), stroke: 1.1pt)

  // Frecce di direzione lungo la linea di corrente S3
  line((3.22, 1.32), (3.29, 1.39), mark: (end: ">", size: 0.25), stroke: 1.1pt)
  line((4.99, 2.83), (5.08, 2.88), mark: (end: ">", size: 0.25), stroke: 1.1pt)

  // Vettore normale uscente n (in grigio come nell'immagine)
  line((4.67, 4.04), (5.22, 4.48), mark: (end: ">", size: 0.22), stroke: (paint: gray.darken(20%), thickness: 1.1pt))

  // Vettore velocità della superficie u_s
  line((5.26, 2.82), (6.05, 3.12), mark: (end: ">", size: 0.22), stroke: 1.1pt)

  // Etichette
  content((1.95, 4.65), [$cal(D)(t)$], anchor: "east")
  content((5.38, 4.25), [#text(fill: gray.darken(25%))[$arrow(n)$]], anchor: "west")
  content((6.3, 3.45), [$arrow(u)_s (arrow(x), t)$], anchor: "west")
  content((5.15, 1.10), [$cal(V)_s (t)$], anchor: "west")
})
    
    
  ]
)
#v(1em)

== Bilancio di Massa ed Equazione di Continuità
// [DA AUDIO]
== Cinematica: Shear Flow
I campi di velocità in cui si verifica una forte variazione del moto in direzione ortogonale rispetto alla direzione principale del flusso sono definiti *modi di taglio* (in inglese, *shear flow*). Questa configurazione cinematica è caratterizzata da un elevato gradiente di velocità perpendicolare allo spostamento macroscopico.

  
#align(center)[
#canvas(length: 1.9cm, {
  import draw: *

  // --- PARTE SINISTRA: PROFILO DI VELOCITÀ u(z) ---
  // Parete inferiore e linea superiore
  line((-1.28, 0.00), (1.72, 0.00), stroke: 1.2pt + black)
  line((-1.40, 2.02), (1.88, 2.02), stroke: 1.2pt + black)

  // Tratteggio parete inferiore
  line((-0.90, -0.05), (-1.10, -0.35), stroke: 1.1pt + black)
  line((-0.62, -0.05), (-0.78, -0.30), stroke: 1.1pt + black)
  line((-0.28, -0.05), (-0.47, -0.32), stroke: 1.1pt + black)
  line(( 0.08, -0.05), (-0.11, -0.32), stroke: 1.1pt + black)
  line(( 0.45, -0.05), ( 0.25, -0.32), stroke: 1.1pt + black)
  line(( 0.84, -0.05), ( 0.65, -0.25), stroke: 1.1pt + black)
  line(( 1.25, -0.06), ( 1.03, -0.28), stroke: 1.1pt + black)
  line(( 1.56, -0.10), ( 1.38, -0.26), stroke: 1.1pt + black)

  // Asse verticale z
  line((0.00, 0.00), (0.00, 2.12), mark: (end: ">"), stroke: 1.2pt + black)

  // Profilo lineare u(z)
  line((0.00, 0.00), (1.36, 2.02), stroke: 1.2pt + black)

  // Linee orizzontali interne al profilo di velocità
  line((0.04, 0.42), (0.24, 0.42), stroke: 1.1pt + black)
  line((0.04, 0.87), (0.58, 0.87), stroke: 1.1pt + black)
  line((0.05, 1.39), (0.93, 1.39), stroke: 1.1pt + black)
  line((0.04, 1.77), (1.15, 1.77), stroke: 1.1pt + black)

  // Etichette
  content((-0.25, 2.30), [$z$])
  content((1.58, 1.22), [$u(z)$])

  // --- PARTE DESTRA: TRE VOLUMI IN DEFORMAZIONE (GRIGIO) ---
  // Volume 1 (sinistra)
  bezier((2.51, 0.25), (2.52, 0.78), (2.50, 0.45), (2.50, 0.62), stroke: 1.2pt + luma(150))
  bezier((2.52, 0.78), (2.85, 1.48), (2.54, 1.02), (2.72, 1.38), stroke: 1.2pt + luma(150))
  bezier((2.85, 1.48), (3.42, 1.66), (3.02, 1.60), (3.28, 1.68), stroke: 1.2pt + luma(150))
  bezier((3.42, 1.66), (3.69, 1.05), (3.52, 1.64), (3.75, 1.35), stroke: 1.2pt + luma(150))
  bezier((3.69, 1.05), (3.12, 0.06), (3.63, 0.65), (3.28, 0.22), stroke: 1.2pt + luma(150))
  bezier((3.12, 0.06), (2.55, 0.33), (2.92, -0.14), (2.42, 0.08), stroke: 1.2pt + luma(150))

  // Volume 2 (centro)
  bezier((3.70, 0.22), (3.95, 0.86), (3.78, 0.42), (3.85, 0.68), stroke: 1.2pt + luma(150))
  bezier((3.95, 0.86), (5.02, 1.48), (4.12, 1.18), (4.65, 1.48), stroke: 1.2pt + luma(150))
  bezier((5.02, 1.48), (5.16, 0.92), (5.20, 1.48), (5.21, 1.12), stroke: 1.2pt + luma(150))
  bezier((5.16, 0.92), (4.72, 0.31), (5.08, 0.72), (4.85, 0.45), stroke: 1.2pt + luma(150))
  bezier((4.72, 0.31), (3.70, 0.22), (4.35, 0.12), (3.60, 0.05), stroke: 1.2pt + luma(150))

  // Volume 3 (destra)
  bezier((5.21, 0.25), (5.82, 0.62), (5.35, 0.42), (5.65, 0.52), stroke: 1.2pt + luma(150))
  bezier((5.82, 0.62), (6.68, 1.32), (6.02, 0.74), (6.32, 1.20), stroke: 1.2pt + luma(150))
  bezier((6.68, 1.32), (7.55, 1.18), (7.05, 1.44), (7.42, 1.35), stroke: 1.2pt + luma(150))
  bezier((7.55, 1.18), (7.45, 0.45), (7.62, 1.00), (7.75, 0.62), stroke: 1.2pt + luma(150))
  bezier((7.45, 0.45), (6.80, 0.12), (7.25, 0.35), (7.02, 0.22), stroke: 1.2pt + luma(150))
  bezier((6.80, 0.12), (5.21, 0.25), (6.25, -0.15), (5.12, 0.05), stroke: 1.2pt + luma(150))
})]



Applichiamo il Teorema di Reynolds alla conservazione della massa per un dominio materiale. Impostiamo $phi = rho$ (densità), la cui grandezza integrale è la massa $M$. Poiché il dominio contiene sempre le stesse particelle fluide (essendo dominio materiale), $bold(u)_S = bold(u)$ e la derivata materiale della massa è nulla:
$ (dif M) / (dif t) = integral_(cal(D)(t)) (partial rho) / (partial t) dif cal(V) + integral_(cal(S)(t)) rho bold(u) dot hat(n) dif cal(S) = 0 $

Applicando il Teorema della Divergenza (di Gauss) all'integrale di superficie, lo trasformiamo in un integrale di volume:
$ integral_cal(D) (partial rho) / (partial t) dif cal(V) + integral_cal(D) nabla dot (rho bold(u)) dif cal(V) = 0 $
Poiché questa relazione deve valere per qualsiasi volume arbitrario $cal(D)$, l'integrando deve essere nullo ovunque. Otteniamo l'equazione locale di continuità:

$ (partial rho) / (partial t) + nabla dot (rho bold(u)) = 0 quad ==> quad (partial rho) / (partial t) + (partial (rho u_j)) / (partial x_j) = 0 $

Possiamo espandere la divergenza per riscrivere l'equazione:
$ underbrace((partial rho) / (partial t) + u_j (partial rho) / (partial x_j) ,1/rho (D rho) / (D t))+ rho (partial u_j) / (partial x_j) = 0 $

Riconoscendo la derivata materiale $(D rho) / (D t)$, dividiamo per $rho$:
#grid(
  columns: (1fr, 1fr),
  column-gutter: 3em,
  align: (center + horizon, center + horizon),
  [
    $ 1/rho (D rho) / (D t) = - (partial u_j) / (partial x_j) = - nabla dot bold(u) $
  ],
  [
    se $rho$ aumenta ==> si contrae \
    se $rho$ diminuisce ==> si espande
  ]
)


Questa forma ci fornisce l'interpretazione fisica della divergenza della velocità

// [DA AUDIO]
#box(stroke: 0.5pt + black, inset: 1em, radius: 2pt)[
  *Trasporto macroscopico (Convettivo) vs Trasporto microscopico (Diffusivo)* \
  Il dominio materiale "imbriglia" idealmente le particelle fluide, ma non le singole molecole, che continuano ad entrare ed uscire dal volume di controllo. Tuttavia, questo scambio non altera il bilancio di massa globale: a livello microscopico, il moto molecolare in un fluido è caotico e isotropo. Questo significa che i flussi di particelle in direzioni opposte si elidono statisticamente, restituendo un flusso netto nullo. \
  Si distinguono quindi due regimi di trasporto:
  - *Diffusivo*: avviene alla scala microscopica/molecolare (es. una goccia di inchiostro che si spande in acqua ferma per l'agitazione termica);
  - *Convettivo*: avviene alla scala macroscopica ed è associato al movimento in blocco (il *bulk*) delle particelle fluide (dal latino, "portare appresso").
]

Se il fluido è incomprimibile, la densità della particella si conserva lungo il moto ($D rho / D t = 0$), il che porta alla condizione di incomprimibilità:
$ nabla dot bold(u) = 0 $
// [DA AUDIO]
*Nota bene*: Avere divergenza nulla non implica necessariamente che la densità sia costante in tutto lo spazio ($rho = "costante"$). È un'equazione compatibile con campi di moto in cui la densità varia spazialmente (es. fluidi stratificati per salinità o temperatura), a patto che le singole particelle fluide non subiscano espansioni o contrazioni volumetriche lungo le proprie traiettorie.

Si può dimostrare che l'approssimazione di incomprimibilità è fisicamente accettabile quando il numero di Mach del flusso è piccolo, tipicamente $"Ma" equiv u/c <= 0.3$.
// [DA AUDIO]
A questi regimi, la velocità di propagazione delle onde acustiche (che viaggiano a $c approx 330 "m/s"$) è infinitamente più grande rispetto alla velocità di trascinamento del fluido. Poiché le variazioni di densità sono indotte proprio dalla compressione associata alle onde di pressione (acustiche), l'enorme divario di velocità disaccoppia il fenomeno acustico da quello macroscopico-convettivo, permettendo di considerare il fluido localmente incomprimibile.

=== Applicazione: Conservazione della massa in un condotto 1D
Un celebre risultato si ottiene applicando il bilancio di massa a un condotto a geometria variabile in regime stazionario. Scegliamo un volume fisso delimitato da due sezioni d'ingresso e d'uscita ($S_1, S_2$) e dalle pareti laterali ($S_w$). L'integrale chiuso di superficie si scompone:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 4em,
  align: (center + horizon, center + horizon),
  [
    $ integral_cal(D)nabla dot arrow(u) dif cal(V)=0 ==> integral_cal(S) bold(u) dot hat(n) dif cal(S) = 0 \
    integral_(S_1) bold(u) dot hat(n)_1 dif S_1 + integral_(S_2) bold(u) dot hat(n)_2 dif S_2 + integral_(S_w) bold(u) dot hat(n)_w dif S_w = 0 $
    
    Poiché le pareti sono impermeabili, il flusso normale attraverso $S_w$ è nullo ($bold(u) dot hat(n)_w = 0$). Sulle sezioni di ingresso e uscita assumiamo velocità uniformi e allineate con la normale. Scegliendo $hat(n)$ uscente dal volume:
  ],
  [
    #image("condotto.png", width:110% )
  ]
)
#v(1em)

Per le condizioni di impermeabilità:
$arrow(u) dot arrow(n)=0$ perciò:

$integral_cal(S_1) arrow(u) dot arrow(n_1) d cal(S_1)= -arrow(u_1) dot S_1$

dove:
$ u_1= (integral_cal(S_1) arrow(u) dot arrow(n_1) d cal(S_1))/S_1 $

è la velocità media sulla sezione del condotto.

che moltiplicandola per la superficie otteniamo la *portata volumetrica* $Q_v$
$ -u_1 S_1 + u_2 S_2 = 0 quad ==> quad u_1 S_1 = u_2 S_2 = Q_v [m^3 / s] $
// [DA AUDIO]
Moltiplicando tale risultato per la densità costante $rho$, si definisce la *portata in massa* $dot(m)$:
$ dot(m) = rho u_1 S_1 = rho u_2 S_2 = rho Q_v quad ["kg" / "s"] $

$arrow(u)=Q_v/S$ La portata volumetrica $Q_v = integral bold(u) dot hat(n) dif cal(S)$ è costante in ogni sezione del condotto. \

#pagebreak()

= Dinamica dei Fluidi Ideali (Eulero e Bernoulli)

== Bilancio della Quantità di Moto

Possiamo riformulare il Teorema del trasporto di Reynolds per includere esplicitamente l'equazione di conservazione della massa. A tale scopo, applichiamo il teorema a una grandezza specifica scalare arbitraria $chi$ moltiplicata per la densità ($phi = rho chi$), scegliendo uno scalare anziché direttamente il vettore velocità $bold(u)$ per semplificare i passaggi algebrici:
$ d/(dif t) integral_(cal(D)(t)) rho chi dif cal(V) = integral_(cal(D)(t)) underbrace((partial(rho chi))/(partial t), "termine locale") dif cal(V) + integral_(cal(S)(t)) underbrace(rho chi (bold(u)_S dot.op hat(n)), "flusso al contorno") dif cal(S) $

*1. Sviluppo del termine temporale locale* \
Analizziamo separatamente la derivata parziale $(partial (rho chi))/(partial t)$ dentro il primo integrale:
Applichiamo la regola di derivazione del prodotto:
  $ (partial (rho chi)) / (partial t) = rho (partial chi) / (partial t) + chi (partial rho) / (partial t) $
Sostituiamo a $(partial rho)/(partial t)$ l'equazione di continuità in notazione indiciale, $(partial rho)/(partial t) = - (partial (rho u_j))/(partial x_j)$:
  $ (partial (rho chi)) / (partial t) = rho (partial chi) / (partial t) - chi (partial (rho u_j)) / (partial x_j) $
Riscriviamo l'ultimo termine usando la regola del prodotto "all'indietro", ovvero $(partial (a b))/(partial x_j) = a (partial b)/(partial x_j) + b (partial a)/(partial x_j) arrow.r.double b (partial a)/(partial x_j) = (partial (a b))/(partial x_j) - a (partial b)/(partial x_j)$ (con $a = rho u_j$ e $b = chi$):
  $ (partial (rho chi)) / (partial t) = rho (partial chi) / (partial t) - lr([ (partial (chi rho u_j)) / (partial x_j) - rho u_j (partial chi) / (partial x_j) ]) $
 Raccogliamo $rho$ tra il primo e l'ultimo termine, riconoscendo la definizione di *derivata lagrangiana (o materiale)* $(D chi)/(D t)$:
  $ (partial (rho chi)) / (partial t) = rho underbrace(lr([ (partial chi) / (partial t) + u_j (partial chi) / (partial x_j) ]), (D chi) / (D t) " (derivata lagrangiana)") - (partial (rho chi u_j)) / (partial x_j) = rho (D chi) / (D t) - (partial (rho chi u_j)) / (partial x_j) $

*2. Sostituzione negli integrali e applicazione del Teorema di Gauss* \
Consideriamo ora un *dominio materiale*, la cui frontiera si muove alla stessa velocità del fluido ($bold(u)_S = bold(u)$, ovvero $bold(u)_S dot.op hat(n) = u_j n_j$). 
Trasformiamo l'integrale di superficie del Teorema di Reynolds in un integrale di volume mediante il Teorema della Divergenza (di Gauss):
$ integral_(cal(S)(t)) rho chi u_j n_j dif cal(S) = integral_(cal(D)(t)) (partial (rho chi u_j))/(partial x_j) dif cal(V) $

Sostituendo nel Teorema di Reynolds sia lo sviluppo del termine locale sia l'integrale di superficie appena trasformato, otteniamo:
$ d /(dif t) integral_(cal(D)(t)) rho chi dif cal(V) = underbrace(integral_(cal(D)(t)) rho (D chi)/(D t) dif cal(V) - integral_(cal(D)(t)) (partial (rho chi u_j))/(partial x_j) dif cal(V), "dal termine temporale locale") + underbrace(integral_(cal(D)(t)) (partial (rho chi u_j))/(partial x_j) dif cal(V), "dall'integrale di superficie") $



I due integrali di volume contenenti la divergenza di $rho chi bold(u)$ sono identici ma di segno opposto e si elidono, dimostrando che l'operatore di derivata totale esterna entra sotto il segno di integrale trasformandosi in derivata lagrangiana moltiplicata per $rho$:
$ partial /(partial t) integral_(cal(D)(t)) rho chi dif cal(V) = integral_(cal(D)(t)) rho (D chi)/(D t) dif cal(V) $

_Nota: nel caso più generale di un volume di controllo arbitrario con $bold(u)_S eq.not bold(u)$, resta anche il flusso relativo al contorno: $d/(dif t) integral_(cal(D)) rho chi dif cal(V) = integral_(cal(D)) rho (D chi)/(D t) dif cal(V) + integral_(cal(S)) rho chi (bold(u)_S - bold(u)) dot.op hat(n) dif cal(S)$)._


Tale identità è del tutto generale e prescinde da qualsiasi ipotesi di costanza della densità $rho$.
$ partial /(partial t) integral_cal(D) rho chi dif cal(V) = integral_cal(D) rho (D chi)/(D t) dif cal(V) + integral_cal(S) rho chi (bold(u)_S - bold(u)) dot hat(n) dif cal(S) $

Per il Secondo Principio della Dinamica applicato alla particella fluida ($cal(V) arrow.r 0$), la derivata materiale della quantità di moto uguaglia la somma delle forze di volume $F_(V,i)$ e di superficie $F_(S,i)$:
$ rho v (D bold(u)) / (D t) = bold(F)_v + bold(F)_s = integral_(cal(D)) rho bold(g) dif V + integral_(cal(S)) bold(bold(sigma)) dot.op bold(n) dif S $


Le forze agenti sul dominio materiale si distinguono in due categorie:
- *Forze di volume* $bold(F)_V$: agiscono all'interno dell'intero volume di fluido (tipicamente la forza di gravità) e si esprimono come:
$ bold(F)_V = integral_(cal(D)(t)) rho bold(g) dif cal(V) quad ("in notazione indiciale:" quad F_(V,i) = integral_(cal(D)(t)) rho g_i dif cal(V)) $
- *Forze di superficie* $bold(F)_S$: agiscono esclusivamente sulla superficie di frontiera $cal(S)(t)$ del volume e, tramite il teorema (tetraedro) di Cauchy, si esprimono attraverso il tensore degli sforzi del secondo ordine $bold(sigma)$ (con sforzo o forza per unità di superficie $bold(T) = bold(sigma) dot.op hat(n)$, ovvero $T_i = sigma_(i j) n_j$):
$ bold(F)_S = integral_(cal(S)(t)) bold(sigma) dot.op hat(n) dif cal(S) quad ("in notazione indiciale:" quad F_(S,i) = integral_(cal(S)(t)) sigma_(i j) n_j dif cal(S)) $
Anche in questa formulazione non viene posta alcuna restrizione sulla densità $rho$, che può essere costante o variabile.

$ sigma_(i j) = "tensore simmetrico" arrow.r.double.long "implica due contributi" $

$ sigma_(i j) = underbrace((sigma_(i j))_"eq", "statico") + underbrace((tau_(i j))_"dis", "i.e." bold(u)(bold(x))) $

1. *Contributo statico (o di equilibrio)* $(sigma_(i j))_"eq"$: esiste indipendentemente dal fatto che il fluido sia in moto o in quiete. Poiché a scala microscopica il moto molecolare è caotico e isotropo (gli urti molecolari hanno uguale intensità in tutte le direzioni spaziali), questo tensore possiede solo le tre componenti normali sulla diagonale principale, tutte identiche e pari a $-p$

2. *Contributo dissipativo (o viscoso)* $(tau_(i j))_"dis"$: in un fluido in movimento con velocità non uniforme $bold(u)(bold(x))$, per descrivere la trasmissione di quantità di moto dovuta allo scorrimento relativo (attrito interno) tra strati di fluido, al termine statico $-p delta_(i j)$ occorre affiancare il *tensore degli sforzi viscosi* $tau_(i j)$, il quale contiene le informazioni sulle variazioni spaziali (gradienti) del campo di velocità.

Trasformando l'integrale di superficie delle forze di superficie in un integrale di volume mediante il Teorema della Divergenza di Gauss:
$ integral_(cal(D)) rho (D bold(u)) / (D t) dif cal(V) = integral_(cal(D)) rho bold(g) dif cal(V) + integral_(cal(S)) bold(sigma) dot.op hat(n) dif cal(S) = integral_(cal(D)) rho bold(g) dif cal(V) + integral_(cal(D)) nabla dot.op bold(sigma) dif cal(V) $
possiamo raccogliere tutti i termini del bilancio di quantità di moto sotto un unico integrale sul volume materiale $cal(D)(t)$:
$ integral_(cal(D)(t)) lr([ rho (D u_i)/(D t) - rho g_i - (partial sigma_(i j))/(partial x_j) ]) dif cal(V) = 0 $
Data l'arbitrarietà della forma e della dimensione del volume $cal(D)(t)$, l'integrando deve annullarsi puntualmente, fornendo l'equazione differenziale (indefinita) del moto di Cauchy:
$ rho (D u_i)/(D t) = rho g_i + (partial sigma_(i j))/(partial x_j) $

Se trascuriamo gli effetti viscosi ($tau_(i j) = 0$), il tensore degli sforzi si riduce alla sola pressione idrostatica $sigma_(i j) = -p delta_(i j)$.
Sostituendo questa espressione nell'equazione della quantità di moto e calcolandone la divergenza $(partial)/(partial x_j) (-p delta_(i j)) = - (partial p)/(partial x_i)$, otteniamo l'Equazione di Eulero:
$ rho (D u_i)/(D t) = rho g_i - (partial p)/(partial x_i) quad ==> quad rho (D bold(u))/(D t) = rho bold(g) - nabla p $


// [DA AUDIO]
Nel caso statico, poiché il moto molecolare è caotico e isotropo (gli urti molecolari hanno uguale intensità in tutte le direzioni spaziali), il tensore degli sforzi possiede solo le tre componenti normali sulla diagonale principale, tutte identiche e pari a $-p$: $sigma_(i j) = -p delta_(i j)$.
Moltiplicando tale tensore per un generico versore normale $hat(n) = (n_x, n_y, n_z)^T$, si ottiene la forza per unità di superficie:

$ T_i = sigma_(i j) n_j = mat(-p, 0, 0; 0, -p, 0; 0, 0, -p) mat(n_x; n_y; n_z) = mat(-p n_x; -p n_y; -p n_z) = -p n_i quad <==> quad bold(T) = -p hat(n) $

Se trascuriamo gli effetti viscosi ($tau_(i j) = 0$), il tensore degli sforzi si riduce alla sola pressione idrostatica $sigma_(i j) = -p delta_(i j)$.

$ (sigma_(i j))_"eq" = mat(-p, 0, 0; 0, -p, 0; 0, 0, -p) = -p delta_(i j) $

Sostituendo questa 
espressione nell'equazione della quantità di moto e calcolandone la divergenza $(partial)/(partial x_j) (-p delta_(i j)) = - (partial p)/(partial x_i)$, otteniamo:
$ rho (D u_i) / (D t) = rho g_i + (partial) / (partial x_j) sigma_(i j) = rho g_i - (partial) / (partial x_j) (p delta_(i j)) = rho g_i - (partial p) / (partial x_i) $
ovvero l'*Equazione di Eulero*:
$ rho (D u_i)/(D t) = rho g_i - (partial p)/(partial x_i) quad ==> quad rho (D bold(u))/(D t) = rho bold(g) - nabla p $

L'Equazione di Eulero governa la dinamica dei *fluidi non viscosi* (detti anche *fluidi ideali*), nei quali si trascura completamente l'attrito interno ovvero la viscosità ($tau_(i j) = 0$), mantenendo per il tensore degli sforzi la medesima struttura isotropa di un fluido statico.





=== Modello Inviscido: Equazione di Eulero
==== Chiusura del Sistema e Condizioni al Contorno (Impermeabilità)
Nel caso di fluido incomprimibile a densità costante ($rho = "cost"$), l'equazione vettoriale di Eulero (3 equazioni scalari) accoppiata all'equazione di continuità forma un *sistema chiuso* di 4 equazioni differenziali nelle 4 incognite scalari $u_1, u_2, u_3, p$:
$ cases(
  nabla dot.op bold(u) = 0,
  rho (D bold(u))/(D t) = rho bold(g) - nabla p
) $
Per risolvere il problema in un dominio assegnato (ad esempio il flusso all'interno di un condotto convergente), è necessario imporre opportune condizioni iniziali e condizioni al contorno (distribuzione di velocità e pressione nella sezione di ingresso e condizioni sulle pareti solide).

Dal punto di vista fisico, l'assenza di viscosità ($tau_(i j) = 0$) ha un impatto diretto sulle condizioni al contorno applicabili a una parete solida:
- In un *fluido reale (viscoso)* che scorre su una parete fissa, le molecole a contatto con la parete urtano contro di essa cedendo quantità di moto; ciò genera uno sforzo tangenziale (attrito a parete) che impone l'annullamento del vettore velocità sulla parete stessa ($bold(u) = bold(0)$ a parete).
- In un *fluido ideale (non viscoso)*, il tensore degli sforzi $sigma_(i j) = -p delta_(i j)$ è in grado di trasmettere esclusivamente sforzi normali alla parete e nessuno sforzo tangenziale. Il modello matematico di Eulero non contempla l'attrito tangenziale e non può quindi impedire lo scorrimento del fluido lungo la parete.
#v(1em)
#grid(
  columns: (1fr,1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon, center +horizon),
  [L'unico vincolo fisico imponibile su una parete solida ferma per un fluido non viscoso è che il fluido non compenetri la parete (assenza di flusso attraverso la superficie solida). Tale vincolo prende il nome di *condizione di impermeabilità* e impone l'annullamento della sola componente di velocità normale alla parete:
$ bold(u) dot.op hat(n) = 0 quad "sulla parete" $
],
[
#canvas(length: 0.8cm, {
  import draw: *

  // Asse centrale tratteggiato
  line((-1.5, 0), (9, 0), stroke: (dash: "dashed", thickness: 1pt))

  // Sezioni trasversali (ellissi)
  circle((0, 0), radius: (1.2, 3), stroke: 1pt)
  circle((8, 0), radius: (0.48, 1.2), stroke: 1pt)

  // Pareti convergenti del condotto (archi circolari)
  arc((10.27, 29.96), start: 249.15deg, stop: 265.48deg, radius: 28.85, anchor: "origin", stroke: 1pt)
  arc((10.27, -29.96), start: 94.52deg, stop: 110.85deg, radius: 28.85, anchor: "origin", stroke: 1pt)

  // Vettori locali n e u
  line((3.5, -1.8), (3.5, -0.6), mark: (end: ">"), stroke: 1pt)
  line((3.5, -1.8), (4.9, -1.5), mark: (end: ">"),  stroke: 1pt)

  // Etichette dei vettori
  content((3.0, -0.9), [$arrow(n)$])
  content((4.4, -1.1), [$arrow(u)$])
})
]
)


// [DA AUDIO]
==== Forma Estesa per Componenti delle Equazioni di Eulero
Esplicitiamo le tre componenti scalari dell'Equazione di Eulero per $i = 1, 2, 3$ in un sistema di riferimento cartesiano $(x_1, x_2, x_3)$ (o $(x, y, z)$) con componenti di velocità $(u_1, u_2, u_3)$ (o $(u, v, w)$) e accelerazione di gravità diretta lungo l'asse verticale $bold(g) = (0, 0, -g)^T$.

Ricordando la convenzione di Einstein sulla somma rispetto all'indice ripetuto $j = 1, 2, 3$ nella derivata materiale:
$ (D u_i)/(D t) = (partial u_i)/(partial t) + u_j (partial u_i)/(partial x_j) = (partial u_i)/(partial t) + u_1 (partial u_i)/(partial x_1) + u_2 (partial u_i)/(partial x_2) + u_3 (partial u_i)/(partial x_3) $
il sistema delle equazioni di Eulero sviluppato per esteso assume la forma:
$ cases(
  rho lr([ (partial u_1)/(partial t) + u_1 (partial u_1)/(partial x_1) + u_2 (partial u_1)/(partial x_2) + u_3 (partial u_1)/(partial x_3) ]) = rho g_1 - (partial p)/(partial x_1),
  rho lr([ (partial u_2)/(partial t) + u_1 (partial u_2)/(partial x_1) + u_2 (partial u_2)/(partial x_2) + u_3 (partial u_2)/(partial x_3) ]) = rho g_2 - (partial p)/(partial x_2),
  rho lr([ (partial u_3)/(partial t) + u_1 (partial u_3)/(partial x_1) + u_2 (partial u_3)/(partial x_2) + u_3 (partial u_3)/(partial x_3) ]) = rho g_3 - (partial p)/(partial x_3)
) $
(dove, con l'orientamento standard dell'asse $x_3$ verticale verso l'alto, si ha $g_1 = 0$, $g_2 = 0$, $g_3 = -g$).
La forma estesa mette in evidenza l'accoppiamento non lineare del trasporto convettivo: in ciascuna equazione, ogni componente della velocità interagisce con i gradienti spaziali di tutte le componenti di velocità.

#pagebreak()
== Conservazione dell'Energia Cinetica e Teorema di Bernoulli

// [DA AUDIO]
Passiamo ora dal bilancio della quantità di moto alle sue implicazioni dal punto di vista energetico. Poiché stiamo considerando un fluido a densità costante ($rho = "cost."$), ci limitiamo allo studio della sola energia di tipo meccanico, senza introdurre il primo principio della termodinamica (che includerebbe anche gli scambi di energia interna e termica).

=== Definizione dell'energia cinetica
Consideriamo il campo di velocità $bold(u) = mat(u_1; u_2; u_3)$ e moltiplichiamolo scalarmente per se stesso:
$ bold(u) dot.op bold(u) = u_i u_i = u_1 u_1 + u_2 u_2 + u_3 u_3 = u_1^2 + u_2^2 + u_3^2 = u^2 $
Moltiplicando il modulo quadro della velocità $u^2$ per $1/2$ e per la densità $rho$, otteniamo l'*energia cinetica per unità di volume*:
$ E_c = 1/2 rho u^2 $
(mentre $1/2 u^2$ rappresenta l'energia cinetica per unità di massa).

=== Prodotto scalare dell'Equazione di Eulero per la velocità
Partiamo dall'equazione di Eulero in forma indiciale e moltiplichiamo entrambi i membri per la componente di velocità $u_i$ (sommando sull'indice ripetuto $i$):
$ u_i dot.op lr(( rho (D u_i) / (D t) = -(partial p) / (partial x_i) + rho g_i )) ==> underbrace(rho u_i (D u_i) / (D t), "1° membro") = underbrace(-u_i (partial p) / (partial x_i) + rho u_i g_i, "2° membro") $

=== Manipolazione del 1° membro (termine inerziale)
- *Regola di derivazione*: per una generica funzione $A(bold(x), t)$, dalla regola di derivazione di una potenza vale:
$ (D) / (D t) lr(( A^2 / 2 )) = 1/2 dot.op 2 A (D A) / (D t) = A (D A) / (D t) $
Applicando questa identità a ciascuna componente di velocità ($A = u_i$), otteniamo:
$ u_i (D u_i) / (D t) = (D) / (D t) lr(( u_i u_i / 2 )) = (D) / (D t) lr(( u^2 / 2 )) $
- *1ª Ipotesi ($rho = "cost."$)*: assumendo che la densità sia costante, $rho$ può essere portata dentro l'operatore di derivata materiale:
$ rho u_i (D u_i) / (D t) = rho (D) / (D t) lr(( u^2 / 2 )) = (D) / (D t) lr(( rho u^2 / 2 )) $

=== Manipolazione del 2° membro (pressione e potenziale gravitazionale)
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

=== Sostituzione nell'equazione di bilancio dell'energia meccanica
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
#pagebreak()
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


=== Interpretazione geometrica e Teorema di Bernoulli
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

=== Applicazione: Genesi della portanza su un profilo alare
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

=== Legame tra velocità e pressione attorno al profilo
1. *Geometria delle linee di corrente*: la forma del profilo alare costringe il campo di moto ad avvilupparsi attorno ad esso producendo un *addensamento* delle linee di corrente nella parte superiore (*dorso*) e un *diradamento* nella parte inferiore (*ventre*).
2. *Variazione di velocità*: per la conservazione della massa tra linee di corrente adiacenti, laddove le linee si avvicinano (dorso) il fluido accelera e la velocità cresce ($u^+$), mentre laddove si allontanano (ventre) il fluido decelera e la velocità diminuisce ($u^-$).
3. *Variazione di pressione tramite Bernoulli*: poiché lo spessore verticale del profilo è piccolo, possiamo trascurare le variazioni della quota gravitazionale $x_3$ tra dorso e ventre ($rho g x_3 approx "cost."$). Il Teorema di Bernoulli lungo ciascuna linea di corrente si riduce allora a:
$ 1/2 rho u^2 + p = "cost." ==> p = "cost." - 1/2 rho u^2 $
Di conseguenza:
- sul *dorso*, dove la velocità aumenta ($u arrow.t$), la pressione deve diminuire ($p arrow.b$, zona di depressione $p^-$);
- sul *ventre*, dove la velocità diminuisce ($u arrow.b$), la pressione deve aumentare ($p arrow.t$, zona di sovrappressione $p^+$).

=== Calcolo della forza aerodinamica risultante
Calcoliamo la forza complessiva $bold(F)$ esercitata dal fluido sulla superficie chiusa $S$ del profilo alare. Indicato con $bold(n)$ il versore normale uscente dalla superficie del profilo (diretto dal corpo verso il fluido), la forza di superficie è l'integrale del vettore sforzo $bold(t)_n = bold(sigma) dot.op bold(n)$:
$ F_i = integral_S sigma_(i j) n_j dif S $
Sostituendo il tensore degli sforzi di un fluido ideale $sigma_(i j) = -p delta_(i j)$ e sfruttando la proprietà della delta di Kronecker ($delta_(i j) n_j = n_i$):
$ F_i = integral_S (-p delta_(i j)) n_j dif S = - integral_S p n_i dif S <==> bold(F) = - integral_S p bold(n) dif S $
Il segno meno davanti all'integrale indica che la pressione $p$ agisce sempre spingendo *contro* la superficie del profilo (nella direzione di $-bold(n)$, cioè verso l'interno del corpo):
- Sul *ventre* (dove la normale uscente $bold(n)$ punta verso il basso, quindi $-bold(n)$ punta verso l'alto), la pressione relativa rispetto a quella atmosferica indisturbata è *positiva* ($p^+ > 0$) e spinge il profilo verso l'alto.
- Sul *dorso* (dove la normale uscente $bold(n)$ punta verso l'alto, quindi $-bold(n)$ punta verso il basso), la pressione relativa è *negativa* ($p^- < 0$, aspirazione) e, moltiplicata per $-bold(n)$, fornisce anch'essa un contributo diretto verso l'alto.

Sommando i contributi su tutta la superficie $S$, la risultante delle pressioni genera una forza netta $bold(F)$ diretta verticalmente verso l'alto (*portanza*), che sostiene il profilo alare.

=== Applicazione: Tubo di Pitot-Statico
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


== Fluido ideale


#align(center)[#canvas(length: 1cm, {
  import draw: *

  // Piastra piana inferiore (tratto spesso nero)
  line((-3.45, 0.00), (5.20, 0.00), stroke: 2.2pt)

  // Parete sinistra (profilo interno, profilo esterno e chiusure)
  line((-2.25, 0.50), (-0.55, 0.50), (-0.55, 3.40), stroke: 1pt)
  line((-2.25, 0.50), (-2.25, 0.62), (-0.67, 0.62), (-0.67, 3.40), stroke: 0.8pt)

  // Tratteggio di sezione parete sinistra
  line((-2.10, 0.50), (-1.95, 0.62), stroke: 0.6pt)
  line((-1.75, 0.50), (-1.60, 0.62), stroke: 0.6pt)
  line((-1.40, 0.50), (-1.25, 0.62), stroke: 0.6pt)
  line((-1.05, 0.50), (-0.90, 0.62), stroke: 0.6pt)
  line((-0.70, 0.50), (-0.55, 0.62), stroke: 0.6pt)
  line((-0.67, 0.85), (-0.55, 0.97), stroke: 0.6pt)
  line((-0.67, 1.25), (-0.55, 1.37), stroke: 0.6pt)
  line((-0.67, 1.65), (-0.55, 1.77), stroke: 0.6pt)
  line((-0.67, 2.05), (-0.55, 2.17), stroke: 0.6pt)
  line((-0.67, 2.45), (-0.55, 2.57), stroke: 0.6pt)
  line((-0.67, 2.85), (-0.55, 2.97), stroke: 0.6pt)
  line((-0.67, 3.20), (-0.55, 3.32), stroke: 0.6pt)

  // Parete destra (profilo interno, profilo esterno e chiusure)
  line((0.55, 3.35), (0.55, 0.50), (2.25, 0.50), stroke: 1pt)
  line((0.67, 3.35), (0.67, 0.62), (2.25, 0.62), (2.25, 0.50), stroke: 0.8pt)

  // Tratteggio di sezione parete destra
  line((0.55, 3.05), (0.67, 3.17), stroke: 0.6pt)
  line((0.55, 2.65), (0.67, 2.77), stroke: 0.6pt)
  line((0.55, 2.25), (0.67, 2.37), stroke: 0.6pt)
  line((0.55, 1.85), (0.67, 1.97), stroke: 0.6pt)
  line((0.55, 1.45), (0.67, 1.57), stroke: 0.6pt)
  line((0.55, 1.05), (0.67, 1.17), stroke: 0.6pt)
  line((0.55, 0.50), (0.72, 0.62), stroke: 0.6pt)
  line((0.90, 0.50), (1.05, 0.62), stroke: 0.6pt)
  line((1.25, 0.50), (1.40, 0.62), stroke: 0.6pt)
  line((1.60, 0.50), (1.75, 0.62), stroke: 0.6pt)
  line((1.95, 0.50), (2.10, 0.62), stroke: 0.6pt)

  // Asse di simmetria verticale (tratto-punto)
  line((0.00, 4.10), (0.00, 3.85), stroke: 0.8pt)
  line((0.00, 3.60), (0.00, 3.50), stroke: 0.8pt)
  line((0.00, 3.20), (0.00, 2.15), stroke: 0.8pt)
  line((0.00, 1.85), (0.00, 1.78), stroke: 0.8pt)
  line((0.00, 1.40), (0.00, 0.60), stroke: 0.8pt)
  line((0.00, 0.35), (0.00, 0.30), stroke: 0.8pt)
  line((0.00, 0.08), (0.00, -1.45), stroke: 0.8pt)

  // Piccola freccia in alto accanto all'asse
  line((0.06, 3.95), (0.48, 3.95), mark: (end: ">"), stroke: 0.8pt)

  // Quota r_2 e linea di riferimento verticale tratteggiata
  line((0.00, 2.45), (2.25, 2.45), mark: (end: ">"), stroke: 0.8pt)
  line((2.25, 2.55), (2.25, 2.25), stroke: 0.8pt)
  line((2.25, 1.85), (2.25, 1.65), stroke: 0.8pt)
  line((2.25, 1.30), (2.25, 0.90), stroke: 0.8pt)

  // Quota h (intercapedine) con trattini obliqui
  line((1.90, -0.10), (1.90, 0.80), stroke: 0.8pt)
  line((1.78, -0.15), (2.02, 0.15), stroke: 0.8pt)
  line((1.78, 0.35), (2.02, 0.65), stroke: 0.8pt)

  // Elementi blu: Sezione A (profilo di velocità in ingresso)
  line((-0.44, 3.55), (-0.44, 2.90), mark: (end: ">"), stroke: (paint: blue, thickness: 0.7pt))
  line((-0.22, 3.55), (-0.22, 2.90), mark: (end: ">"), stroke: (paint: blue, thickness: 0.7pt))
  line((0.00, 3.55), (0.00, 2.90), mark: (end: ">"), stroke: (paint: blue, thickness: 0.7pt))
  line((0.22, 3.55), (0.22, 2.90), mark: (end: ">"), stroke: (paint: blue, thickness: 0.7pt))
  line((0.44, 3.55), (0.44, 2.90), mark: (end: ">"), stroke: (paint: blue, thickness: 0.7pt))
  line((-0.52, 2.82), (0.52, 2.82), mark: (start: ">", end: ">"), stroke: (paint: blue, thickness: 0.7pt))

  // Elementi blu: Svolta della corrente in B
  arc((-0.65, 0.75), start: 270deg, stop: 360deg, radius: (0.47, 0.60), anchor: "origin", mark: (start: ">"), stroke: (paint: blue, thickness: 0.8pt))
  arc((0.72, 0.75), start: 180deg, stop: 270deg, radius: 0.54, anchor: "origin", mark: (end: ">"), stroke: (paint: blue, thickness: 0.8pt))

  // Frecce di richiamo per B, C, D (blu)
  line((0.40, -0.42), (0.58, 0.12), mark: (end: ">"), stroke: (paint: blue, thickness: 0.7pt))
  line((1.75, 1.05), (1.45, 0.22), mark: (end: ">"), stroke: (paint: blue, thickness: 0.7pt))
  line((3.55, -0.60), (3.25, 0.20), mark: (end: ">"), stroke: (paint: blue, thickness: 0.7pt))

  // Efflusso esterno sinistro (frecce e limite tratteggiato del getto in blu)
  line((-3.00, 0.40), (-3.65, 0.40), mark: (end: ">"), stroke: (paint: blue, thickness: 0.7pt))
  line((-3.00, 0.24), (-3.85, 0.24), mark: (end: ">"), stroke: (paint: blue, thickness: 0.7pt))
  line((-3.00, 0.08), (-3.75, 0.08), mark: (end: ">"), stroke: (paint: blue, thickness: 0.7pt))
  line((-2.80, 0.55), (-4.05, 0.92), stroke: (paint: blue, thickness: 0.8pt, dash: "dashed"))

  // Efflusso esterno destro (frecce e limite tratteggiato del getto in blu)
  line((3.55, 0.62), (3.95, 0.62), mark: (end: ">"), stroke: (paint: blue, thickness: 0.7pt))
  line((3.50, 0.44), (4.25, 0.44), mark: (end: ">"), stroke: (paint: blue, thickness: 0.7pt))
  line((3.50, 0.26), (4.55, 0.23), mark: (end: ">"), stroke: (paint: blue, thickness: 0.7pt))
  line((3.65, 0.08), (4.20, 0.08), mark: (end: ">"), stroke: (paint: blue, thickness: 0.7pt))
  line((2.40, 0.50), (4.15, 1.05), stroke: (paint: blue, thickness: 0.8pt, dash: "dashed"))

  // Etichette interne all'immagine (tutte con text(size: 7pt))
  content((0.18, 2.22), text(size: 7pt, fill: blue)[$A$], anchor: "center")
  content((0.35, -0.68), text(size: 7pt, fill: blue)[$B$], anchor: "center")
  content((2.05, 1.32), text(size: 7pt, fill: blue)[$C$], anchor: "center")
  content((3.80, -0.82), text(size: 7pt, fill: blue)[$D$], anchor: "center")
  content((1.35, 2.68), text(size: 7pt)[$r_2$], anchor: "center")
  content((2.15, 0.25), text(size: 7pt)[$h$], anchor: "west")
})]
// [DA AUDIO]
Studio del sistema bobina-disco di carta: si soffia aria in un condotto verticale sopra un disco di carta di superficie $S$.
La carta rimane sospesa in equilibrio se la forza peso è bilanciata dalla forza aerodinamica verticale verso l'alto.

Per un fluido ideale il tensore degli sforzi si riduce al solo termine di pressione isotropa:
$ bold(sigma) = -p bold(I) quad arrow.r quad sigma_(i j) = -p delta_(i j) $

La forza aerodinamica dipende quindi unicamente dalla distribuzione di pressione sulle facce superiore e inferiore della carta:
$ arrow(F) = integral_S bold(sigma) dot arrow(n) dif S = - integral_S p arrow(n) dif S $
- a) Fluido incompressibile, $arrow(g) = 0$
      // [DA AUDIO]
      La velocità del soffio è di pochi $"m/s"$, molto inferiore alla velocità del suono ($M << 1$), quindi la densità dell'aria è costante ($rho = text("cost.")$). Si trascurano inoltre le variazioni di quota gravitazionali.
    - b) $partial / (partial t) = 0$, assialsimmetrico $u_r (r, z); u_z (r, z)$
      // [DA AUDIO]
      Il moto è stazionario perché la carta resta in posizione fissa durante il soffio continuo. Si adotta una coordinata radiale $r$ dal centro del condotto assumendo invarianza rispetto all'angolo azimutale $theta$.
    - c) $r_1 \gg h; (r_2 - r_1) \gg h$ \
    Separazione di scale! \
    // [DA AUDIO]
    dove $r_1$ è il raggio del condotto verticale di ingresso, $r_2$ è il raggio esterno della bobina/carta e $h$ è lo spessore dell'intercapedine tra bobina e carta.
    Si ha separazione di scale quando le dimensioni caratteristiche radiali superano $h$ di uno o più ordini di grandezza: vista da lontano la carta appare incollata, ma il getto d'aria defluisce radialmente attraverso l'intercapedine.
    
    Calcolo il flusso nel canale A:
    // [DA AUDIO]
    Si suddivide il dominio in tre regioni:
    - zona A: condotto cilindrico verticale di ingresso (sezione $pi r_1^2$, velocità media $U_A$);
    - zona B: regione di svolta in cui le linee di corrente si incurvano radialmente (sezione cilindrica d'ingresso $2 pi r_1 h$, velocità media $U_B$);
    - zona C: canale radiale sottile tra $r_1$ e $r_2$ di spessore $h$.

    Per la conservazione della portata volumetrica $q$ tra la zona A e l'ingresso del canale radiale B:
$
q = pi r_1^2 U_A = 2 pi r_1 h U_B \
(U_A) / (U_B) = (2 h) / r_1 << 1 \
U_A << U_B
$
// [DA AUDIO]
$ U_B = r_1 / (2 h) U_A >> U_A $
Il vincolo geometrico $r_1 / (2 h) >> 1$ amplifica la velocità nel canale radiale di 10--100 volte rispetto alla velocità $U_A$ imposta nel condotto verticale.

#v(1em)


=== Valuto la distribuzione delle pressioni
$
nabla p &= - rho arrow(u) dot nabla arrow(u) \
rho arrow(u) dot nabla arrow(u) &= O(rho (U_A^2) / r_1) quad "Nel canale di ingresso A" \
Delta p_A &tilde.op rho U_A^2
$
// [DA AUDIO]
Analisi degli ordini di grandezza (stima spannometrica) nella zona A: approssimando le derivate spaziali con rapporti incrementali sulla scala caratteristica $r_1$, le variazioni di pressione nel condotto verticale risultano dell'ordine di $rho U_A^2$.

poiché $U_A tilde.op U h / r_1 -> U_A << U$ \
dunque $Delta p_A << rho U_B^2$

=== Bernoulli tra (A) e (C)
// [DA AUDIO]
Applicando il teorema di Bernoulli lungo una linea di corrente dal condotto verticale A a un generico raggio $r$ nel canale radiale C (trascurando il termine gravitazionale per le piccole variazioni di quota $z$):

$
p_C + 1/2 rho U_C^2 = p_A + 1/2 rho U_A^2
$

- $->$ il termine $1/2 rho U_A^2 << 1/2 rho U_B^2$, posso trascurarlo
- $->$ $Delta p_A << rho U_B^2 ->$ dunque posso assumere che $p_A = "cost."$

$
p_A = p_C + 1/2 rho U_C^2
$
 == Calcolo delle forze
  #align(center)[
    #canvas(length: 1.2cm, {
  import draw: *

  // Contorni delle pareti superiori (condotto verticale e flangia)
  line((-3.20, 0.45), (-0.75, 0.45), (-0.75, 2.00), stroke: 1pt)
  line((0.75, 2.00), (0.75, 0.45), (3.20, 0.45), stroke: 1pt)

  // Piastra piana inferiore (doppia linea ravvicinata come nello schizzo)
  line((-3.20, 0.00), (3.20, 0.00), stroke: 1pt)
  line((-3.20, -0.05), (3.20, -0.05), stroke: 1pt)

  // Tacche verticali in corrispondenza di r_1 sulla piastra inferiore
  line((-0.75, -0.12), (-0.75, 0.12), stroke: 0.8pt)
  line((0.75, -0.12), (0.75, 0.12), stroke: 0.8pt)

  // Asse di simmetria verticale (tratteggiato)
  line((0.00, 1.65), (0.00, 1.20), stroke: 0.8pt)
  line((0.00, 0.75), (0.00, 0.30), stroke: 0.8pt)
  line((0.00, 0.00), (0.00, -0.55), stroke: 0.8pt)

  // Linee di flusso (blu)
  // Svolta a sinistra
  arc((-1.25, 0.88), start: 270deg, stop: 360deg, radius: 0.70, anchor: "origin", mark: (start: ">"), stroke: (paint: blue, thickness: 0.8pt))
  // Svolta a destra (spezzata intorno all'etichetta P_A = cost)
  arc((0.50, 0.75), start: 180deg, stop: 270deg, radius: (0.25, 0.30), anchor: "origin", stroke: (paint: blue, thickness: 0.8pt))
  line((0.75, 0.26), (1.18, 0.18), mark: (end: ">"), stroke: (paint: blue, thickness: 0.8pt))

  // Frecce di efflusso a sinistra (blu)
  line((-2.70, 0.32), (-3.50, 0.36), mark: (end: ">"), stroke: (paint: blue, thickness: 0.8pt))
  line((-2.65, 0.16), (-3.75, 0.20), mark: (end: ">"), stroke: (paint: blue, thickness: 0.8pt))

  // Frecce di efflusso a destra (blu)
  line((3.00, 0.30), (3.65, 0.36), mark: (end: ">"), stroke: (paint: blue, thickness: 0.8pt))
  line((3.00, 0.14), (3.95, 0.18), mark: (end: ">"), stroke: (paint: blue, thickness: 0.8pt))

  // Freccia dell'asse radiale r
  line((3.65, -0.02), (4.70, -0.02), mark: (end: ">"), stroke: 0.8pt)

  // Frecce di quota per i raggi r_1 e r_2
  line((0.05, -0.32), (0.75, -0.32), mark: (end: ">"), stroke: 0.8pt)
  line((0.05, -0.55), (3.20, -0.55), mark: (end: ">"), stroke: 0.8pt)

  // Etichette (tutte interne all'immagine -> text(size: 7pt))
  content((0.10, 0.32), text(size: 7pt)[$P_A = "cost"$], anchor: "center")
  content((2.00, 0.20), text(size: 7pt)[$P_c (r)$], anchor: "center")
  content((1.15, -0.85), text(size: 7pt)[$P_0$], anchor: "center")
  content((0.40, -0.18), text(size: 7pt)[$r_1$], anchor: "center")
  content((2.25, -0.80), text(size: 7pt)[$r_2$], anchor: "center")
  content((4.90, -0.02), text(size: 7pt)[$r$], anchor: "west")
})
  ]


    La forza totale ci è data da due contributi:
    
    $
    F = integral_(S_1) (p_0 - p_A) dif S_1 + integral_(S_2) [p_0 - p_C (r)] dif S_2
    $
    // [DA AUDIO]
    Sulla faccia inferiore della carta agisce uniformemente la pressione atmosferica $p_0$ (spinta verso l'alto $p_0 S$).
    Sulla faccia superiore si distinguono due regioni:
    - $S_1$: cerchio centrale di raggio $r_1$ (zona di impatto del getto verticale, a pressione $p_A$);
    - $S_2$: corona circolare tra $r_1$ e $r_2$ (canale radiale, a pressione $p_C (r)$).
#v(1em)

Per calcolare queste differenze di pressione uso Bernoulli:

$
p_A = 1/2 rho U_C^2 (r) + p_C (r)
$
$
U_C (r) = q / (2 pi r h) quad arrow.l text("per la continuità")
$

$
p_C (r) = p_A - 1/2 rho U_C^2 (r) = p_A - 1/8 (rho q^2) / (pi^2 h^2 r^2)
$
// [DA AUDIO]
All'aumentare del raggio $r$ cresce la sezione di passaggio $2 pi r h$: per conservare la portata $q$, la velocità $U_C (r)$ diminuisce come $1/r$ e, per Bernoulli, la pressione $p_C (r)$ aumenta progressivamente verso l'uscita.

Per $r = r_2$, là dove $p_C(r_2) = p_0$:
// [DA AUDIO]
All'estremità del canale radiale ($r = r_2$) il getto sbocca in atmosfera; per continuità della pressione deve raccordarsi con la pressione atmosferica $p_0$.

$
p_C (r_2) = p_A - 1/8 (rho q^2) / (pi^2 h^2 r_2^2) = p_0
$

- Posso quindi calcolare $(p_0 - p_A)$:
$
(p_0 - p_A) = - (rho q^2) / (8 pi^2 h^2 r_2^2)
$
// [DA AUDIO]
Il contributo è sempre negativo ($p_A > p_0$): nella regione centrale $S_1$ l'impatto del getto esercita una sovrapressione che spinge la carta verso il basso.

- Calcolo anche $(p_0 - p_C (r))$ sostituendo l'espressione di $p_C (r)$ trovata con Bernoulli e quella di $(p_0 - p_A)$:

$
p_0 - p_C (r) &= (p_0 - p_A) + 1/8 (rho q^2) / (pi^2 h^2 r^2) \
p_0 - p_C (r) &= - (rho q^2) / (8 pi^2 h^2 r_2^2) + (rho q^2) / (8 pi^2 h^2 r^2) \
p_0 - p_C (r) &= (rho q^2) / (8 pi^2 h^2) (1/r^2 - 1/r_2^2)
$

Per $r_1 < r < r_2$ risulta $1/r^2 > 1/r_2^2$, quindi $p_0 - p_C (r) > 0$ (ovvero $p_C (r) < p_0$): l'alta velocità nel canale radiale genera una depressione (effetto *suction*) che aspira la carta verso l'alto nella regione anulare $S_2$.

Ho dunque tutti gli elementi per calcolare la forza verticale complessiva $F$ (positiva verso l'alto):

$
F = integral_(S_1) (p_0 - p_A) dif S_1 + integral_(S_2) (p_0 - p_C (r)) dif S_2
$

Valuto separatamente i due integrali:
- Nella zona centrale $S_1$, poiché $p_A$ è costante, moltiplico semplicemente per l'area del cerchio $pi r_1^2$:
  $
  integral_(S_1) (p_0 - p_A) dif S_1 = (p_0 - p_A) pi r_1^2
  $

- Nella corona circolare $S_2$, poiché la pressione dipende solo da $r$, integro per anelli infinitesimi di area $dif S_2 = 2 pi r dif r$:
  $
  integral_(S_2) (p_0 - p_C (r)) dif S_2 = integral_(r_1)^(r_2) (p_0 - p_C (r)) 2 pi r dif r
  $

Sostituisco le espressioni delle pressioni e svolgo i passaggi algebrici:

$
F &= underbrace((p_0 - p_A) pi r_1^2, text("spinta verso il basso in ") S_1) + underbrace(integral_(r_1)^(r_2) [p_0 - p_C (r)] 2 pi r dif r, text("aspirazione verso l'alto in ") S_2) = \
  &= - (rho q^2) / (8 pi^2 h^2 r_2^2) pi r_1^2 + 2 pi (rho q^2) / (8 pi^2 h^2) integral_(r_1)^(r_2) (1/r^2 - 1/r_2^2) r dif r = &quad text("(sostituisco le pressioni)") \
  &= (rho q^2) / (4 pi h^2) { - 1/2 (r_1/r_2)^2 + integral_(r_1)^(r_2) (1/r^2 - 1/r_2^2) r dif r } = &quad text("(raccolgo ") (rho q^2) / (4 pi h^2) text(")") \
  &= (rho q^2) / (4 pi h^2) { - 1/2 (r_1/r_2)^2 + integral_(r_1)^(r_2) 1/r dif r - integral_(r_1)^(r_2) r / r_2^2 dif r } = &quad text("(distribuisco ") r text(" e separo)") \
  &= (rho q^2) / (4 pi h^2) { - 1/2 (r_1/r_2)^2 + ln (r_2/r_1) - [ r^2 / (2 r_2^2) ]_(r_1)^(r_2) } = &quad text("(risolvo gli integrali)") \
  &= (rho q^2) / (4 pi h^2) { cancel(- 1/2 (r_1/r_2)^2) + ln (r_2/r_1) - 1/2 + cancel(1/2 (r_1/r_2)^2) } &quad text("(valuto gli estremi e semplifico)")
$

I termini contenenti $(r_1/r_2)^2$ si elidono. Definendo il fattore di forma geometrico $Lambda = r_2 / r_1$, si ottiene il risultato finale:

$
F &= (rho q^2) / (4 pi h^2) { ln Lambda - 1/2 } \
Lambda &= r_2 / r_1 quad text("(fattore di forma)")
$

Affinché prevalga l'effetto di aspirazione verso l'alto ($F > 0$), deve essere $ln Lambda > 1/2$, ovvero $r_2 > sqrt(e) r_1 approx 1.65 r_1$.
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    La forza è positiva se $ln Lambda - 1/2 > 0$. \
    // [DA AUDIO]
    $ ln Lambda > 1/2 quad arrow.r quad Lambda = r_2 / r_1 > e^(1/2) approx 1.65 $
    Affinché la forza risultante sia diretta verso l'alto, la superficie anulare $S_2$ in depressione deve essere sufficientemente estesa da superare la spinta verso il basso del getto centrale su $S_1$.

    L'equilibrio è instabile. \
    // [DA AUDIO]
    Poiché $F prop 1/h^2$ mentre il peso $P$ è indipendente da $h$:
    - se una perturbazione abbassa la carta ($h > h_"eq"$), la forza aerodinamica diminuisce ($F < P$) e la carta cade;
    - se una perturbazione avvicina la carta alla bobina ($h < h_"eq"$), la forza aumenta ($F > P$) spingendo la carta a chiudere il canale.

    // [DA AUDIO]
    
  ],
  [
    
    // [DA AUDIO]
    #canvas(length: 0.8cm, {
      import draw: *
      line((0, 0), (5.5, 0), mark: (end: ">"), name: "h-axis")
      content("h-axis.end", $h$, anchor: "west", padding: 0.1)
      line((0, 0), (0, 4.5), mark: (end: ">"), name: "F-axis")
      content("F-axis.end", $F$, anchor: "south", padding: 0.1)
      line((0, 1.5), (5.2, 1.5), stroke: (dash: "dashed"))
      content((5.2, 1.5), $P = m g$, anchor: "west", padding: 0.1)
      bezier((0.7, 4.0), (2.0, 1.5), (0.9, 2.5), (1.4, 1.8))
      bezier((2.0, 1.5), (5.0, 0.3), (2.8, 1.0), (3.8, 0.5))
      content((1.1, 3.6), $F(h) prop 1 / h^2$, anchor: "west")
      line((2.0, 0), (2.0, 1.5), stroke: (dash: "dotted"))
      circle((2.0, 1.5), radius: 0.08, fill: black)
      content((2.0, -0.35), $h_"eq"$)
      line((1.8, 0.3), (1.0, 0.3), mark: (end: ">"))
      line((2.2, 0.3), (3.0, 0.3), mark: (end: ">"))
    })
  ]
)
#v(1em)

// [RIORDINATO DA SLIDE]
Limite del modello di fluido ideale: per $h arrow.r 0$ la formula prevede una forza divergente ($F arrow.r infinity$), comportamento non fisico dovuto all'aver trascurato gli effetti viscosi, che diventano dominanti per spessori $h$ molto piccoli.


$
    arrow(U) = 0 \
    bold(sigma) = -p bold(I)
    $
// [DA SLIDE]
==== Caso statico: distribuzione idrostatica di pressione (Legge di Stevino)

Ci chiediamo ora quali siano le forze esercitate da un fluido in quiete ($arrow(U) = 0$) su un corpo generico immerso al suo interno. In assenza di moto, anche per un fluido reale gli sforzi viscosi sono identicamente nulli e il tensore degli sforzi si riduce alla sola componente isotropa di pressione: $bold(sigma) = -p bold(I)$.



Fissiamo un sistema di riferimento con l'asse verticale $x_3$ orientato verso l'alto e poniamo la quota $x_3 = 0$ in corrispondenza della superficie libera (dove agisce la pressione ambiente $p = p_0$). Il vettore accelerazione di gravità è dunque diretto lungo il verso negativo di $x_3$:
$
arrow(g) = vec(0, 0, -g)
$
L'equazione di bilancio della quantità di moto in condizioni statiche ($nabla p = rho arrow(g)$), proiettata lungo la direzione verticale $x_3$, fornisce l'equazione fondamentale dell'idrostatica:
$
- (partial p) / (partial x_3) = rho g
$
Se il fluido è omogeneo e incompressibile ($rho = rho_0 = text("cost.")$), possiamo integrare per separazione di variabili tra la superficie libera ($x_3 = 0$, $p = p_0$) e una generica quota $x_3$:
$
- integral_(p_0)^p dif p = integral_0^(x_3) rho_0 g dif x_3 quad arrow.r quad p_0 - p = rho_0 g x_3
$
da cui si ottiene la *legge di Stevino*:
$
p(x_3) = p_0 - rho_0 g x_3
$
*Nota sul segno di $x_3$:* poiché l'asse $x_3$ è rivolto verso l'alto, per tutti i punti all'interno del fluido (sotto la superficie libera) la coordinata $x_3$ è *negativa* ($x_3 < 0$). Di conseguenza il termine $-rho_0 g x_3$ è positivo e la pressione cresce linearmente con la profondità $h = -x_3$.

*Esempio numerico (acqua, $"H"_2"O"$):* \
Considerando la densità dell'acqua $rho_0 = 10^3 "kg/m"^3$ e $g approx 10 "m/s"^2$, una variazione di profondità $|Delta x_3| = 10 "m"$ comporta un incremento di pressione pari a:
$
rho_0 g |Delta x_3| approx 10^3 dot 10 dot 10 = 10^5 "Pa" = 1 "atm"
$
In acqua la pressione idrostatica aumenta quindi di circa $1 "atm"$ ogni $10 "m"$ di profondità.
    
   

=== Forze esercitate dal fluido
\

$
dif arrow(F)_A = arrow(T) dif S &= bold(sigma) dot arrow(n) dif S = \
       &= -p bold(I) dot arrow(n) dif S
$

$
T_i dif S = sigma_(i j) n_j = -p delta_(i j) n_j dif S
$

$
(F_A)_i &= - integral_S p delta_(i j) n_j dif S = - integral_V partial / (partial x_j) (p delta_(i j)) dif V = \
        &= integral_V - (partial p) / (partial x_i) dif V = integral_V - rho g_i dif V = \
        &= - g_i integral_V rho dif V = - g_i M_f
$

// [DA SLIDE]
dove i passaggi della derivazione si giustificano come segue:
+ *Forza elementare di superficie:* indicando con $arrow(n)$ il versore normale uscente dalla superficie chiusa $S$ del corpo (e quindi rivolto verso il fluido), la forza di pressione esercitata dal fluido sul corpo agisce lungo $-arrow(n)$, da cui la componente $i$-esima $dif (F_A)_i = sigma_(i j) n_j dif S = -p delta_(i j) n_j dif S$.
+ *Teorema della divergenza (Gauss):* l'integrale esteso alla superficie chiusa $S$ viene trasformato in un integrale esteso al volume $V$ occupato dal corpo, sfruttando la proprietà della delta di Kronecker $(partial (p delta_(i j))) / (partial x_j) = (partial p) / (partial x_i)$.
+ *Equazione dell'idrostatica:* poiché il fluido circostante è in equilibrio statico, il gradiente di pressione soddisfa $nabla p = rho arrow(g)$ (in componenti $(partial p) / (partial x_i) = rho g_i$).
+ *Campo di gravità uniforme:* assumendo $arrow(g)$ costante sul volume del corpo, $g_i$ può essere portato fuori dall'integrale di volume.

Definendo la *massa di fluido spostato* $M_f$ come la massa di fluido che occuperebbe il volume $V$ del corpo:
$
M_f = integral_V rho dif V
$
si ottiene in forma vettoriale il *Principio di Archimede*:
$
arrow(F)_A = - M_f arrow(g)
$
La forza risultante $arrow(F)_A$ esercitata dal fluido su un corpo immerso di forma arbitraria è dunque *opposta a $arrow(g)$* (diretta verticalmente verso l'alto) e ha intensità pari al peso del fluido spostato dal corpo.
#pagebreak()
= Dinamica dei Fluidi Viscosi (Navier-Stokes)

== Fluidi viscosi - Newtoniani

// [DA AUDIO]
Nei fluidi ideali la dinamica del campo di moto è descritta dalle equazioni di Eulero e dal teorema di Bernoulli (che riduce un sistema di quattro equazioni differenziali accoppiate a una singola equazione scalare).

Il modello di fluido ideale cessa tuttavia di essere valido quando le scale geometriche diventano piccole (ad esempio in un canale radiale stretto): in queste condizioni si generano forti differenze di velocità concentrate su distanze molto ridotte, ovvero elevati gradienti di velocità, che rendono non più trascurabili gli effetti della viscosità.

// [DA AUDIO]
Tra i fluidi viscosi esistono numerosi comportamenti reologici complessi; nel seguito si analizza unicamente la categoria dei *fluidi newtoniani*.

$
sigma_(i j) &= -p delta_(i j) + tau_(i j) \
overline(overline(sigma)) &= -p overline(overline(I)) + overline(overline(tau))
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
sigma_(i j) &= -p delta_(i j) + 2 mu D_(i j) \
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

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    Si considera un volume $V$ materiale (che si muove con velocità $arrow(u)$) di superficie $S$:

    $ dif/(dif t) integral_(D(t)) rho u_i dif V = integral_(D(t)) rho (D u_i)/(D t) dif V = $

    Per il teorema di Reynolds:

    $ = integral_(D(t)) rho f_i dif V + integral_S sigma_(i j) n_j dif S $

    // [DA AUDIO]
    
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  // Contorno della superficie S (volume V)
  bezier((1.92, 2.95), (1.92, 1.15), (2.38, 2.35), (2.38, 1.75), stroke: 1pt)
  bezier((1.92, 1.15), (4.45, 1.50), (1.60, 0.45), (4.10, 0.75), stroke: 1pt)
  bezier((4.45, 1.50), (4.35, 3.30), (4.65, 1.95), (4.55, 2.85), stroke: 1pt)
  bezier((4.35, 3.30), (1.92, 2.95), (4.10, 4.25), (2.30, 4.10), stroke: 1pt)

  // Linea di corrente 1 (in alto a sinistra) + frecce di direzione
  bezier((0.0, 3.38), (3.65, 4.45), (1.2, 3.80), (2.5, 4.18), stroke: 0.8pt)
  line((0.75, 3.64), (0.90, 3.69), mark: (end: ">"), stroke: 0.8pt)
  line((1.80, 3.96), (1.95, 4.01), mark: (end: ">"), stroke: 0.8pt)
  line((2.98, 4.28), (3.13, 4.32), mark: (end: ">"), stroke: 0.8pt)

  // Linea di corrente 2 (medio-alta) + frecce di direzione
  bezier((0.28, 2.32), (4.52, 3.58), (1.6, 2.82), (3.1, 3.25), stroke: 0.8pt)
  line((1.12, 2.62), (1.27, 2.68), mark: (end: ">"), stroke: 0.8pt)
  line((2.20, 2.98), (2.35, 3.03), mark: (end: ">"), stroke: 0.8pt)
  line((3.45, 3.32), (3.60, 3.36), mark: (end: ">"), stroke: 0.8pt)

  // Linea di corrente 3 (medio-bassa) + frecce di direzione
  bezier((0.68, 1.28), (6.55, 2.86), (2.5, 1.95), (4.7, 2.55), stroke: 0.8pt)
  line((2.00, 1.74), (2.15, 1.79), mark: (end: ">"), stroke: 0.8pt)
  line((2.98, 2.04), (3.13, 2.09), mark: (end: ">"), stroke: 0.8pt)
  line((4.22, 2.38), (4.37, 2.42), mark: (end: ">"), stroke: 0.8pt)
  line((5.62, 2.68), (5.77, 2.72), mark: (end: ">"), stroke: 0.8pt)

  // Linea di corrente 4 (bassa) + frecce di direzione
  bezier((1.02, 0.35), (7.40, 1.62), (3.0, 0.82), (5.4, 1.32), stroke: 0.8pt)
  line((1.55, 0.47), (1.70, 0.51), mark: (end: ">"), stroke: 0.8pt)
  line((3.45, 0.89), (3.60, 0.93), mark: (end: ">"), stroke: 0.8pt)
  line((5.55, 1.31), (5.70, 1.34), mark: (end: ">"), stroke: 0.8pt)

  // Indicatore ed etichetta S
  line((1.08, 2.08), (2.18, 2.40), mark: (end: ">"), stroke: 1pt)
  content((0.55, 1.85), [$S$], anchor: "east")

  // Indicatore ed etichetta V (in alto)
  bezier((4.78, 4.30), (3.88, 3.02), (4.35, 4.10), (4.05, 3.55), mark: (end: ">"), stroke: 1pt)
  content((4.90, 4.50), [$V$], anchor: "west")

  // Vettore normale n
  line((4.39, 3.12), (4.90, 3.35), mark: (end: ">"), stroke: 1pt)
  content((4.95, 3.52), [$arrow(n)$], anchor: "west")

  // Vettore velocità locale u
  line((4.48, 1.82), (5.05, 1.94), mark: (end: ">"), stroke: 1pt)
  content((5.25, 2.05), [$arrow(u)$], anchor: "west")

  // Campo di velocità u(x; t)
  content((6.60, 3.80), [$arrow(u)(arrow(x) ; t)$], anchor: "west")

  // Indicatore ed etichetta "Volume V" (in basso)
  bezier((4.15, 0.12), (3.45, 0.52), (3.75, 0.15), (3.55, 0.30), mark: (end: ">"), stroke: 1pt)
  content((4.65, 0.35), [Volume $V$], anchor: "west")
})
  ]
)
#v(1em)
Data una superficie (ad esempio una parete solida) individuata dal versore normale $n_j$, la quantità integranda $T_i = sigma_(i j) n_j$ rappresenta la forza per unità di superficie (vettore sforzo o tensione) esercitata dal fluido sulla parete:

    $ T_i = sigma_(i j) n_j = -p delta_(i j) n_j + 2 mu D_(i j) n_j $

    Tale forza per unità di superficie:
    - dipende dall'orientazione locale della parete tramite il versore normale $n_j$;
    - si compone di un contributo puramente normale dovuto alla pressione ($-p delta_(i j) n_j$) e di un contributo sia normale che tangenziale dovuto agli sforzi viscosi ($2 mu D_(i j) n_j$), entrambi valutati tramite il valore della pressione e dei gradienti di velocità alla parete;
    - integrata su una superficie finita $S$, restituisce la forza totale esercitata dal fluido sulla superficie stessa.
Usando il teorema di Gauss:

$ integral_(D(t)) rho (D u_i)/(D t) dif V = integral_(D(t)) rho f_i dif V + integral_(D(t)) partial/(partial x_j) sigma_(i j) dif V $

$
rho (D u_i)/(D t) &= rho f_i + (partial sigma_(i j))/(partial x_j) \
rho (D arrow(u))/(D t) &= rho arrow(f) + nabla dot overline(overline(sigma))
$

Sviluppiamo ora la componente $i$-esima della divergenza del tensore degli sforzi, $(nabla dot overline(overline(sigma)))_i = partial/(partial x_j) sigma_(i j)$,:

$
&(nabla dot overline(overline(sigma)))_i = partial/(partial x_j) sigma_(i j) = partial/(partial x_j) (-p delta_(i j) + tau_(i j)) = && "(scompongo "sigma_(i j)" in parte idorstatica e viscosa)" \
&= -partial/(partial x_j) (p delta_(i j)) + partial/(partial x_j) (2 mu D_(i j)) = && quad "(linearità e legge costitutiva " tau_(i j) = 2 mu D_(i j) ")" \
&= -delta_(i j) (partial p)/(partial x_j) + partial/(partial x_j) [2 mu dot 1/2 ((partial u_i)/(partial x_j) + (partial u_j)/(partial x_i))] = && quad "(costanza di " delta_(i j) " e definizione di " D_(i j) ")" \
&= -(partial p)/(partial x_i) + partial/(partial x_j) [mu ((partial u_i)/(partial x_j) + (partial u_j)/(partial x_i))] && quad "(contrazione dell'indice " j " e semplificazione)"
$

In particolare, nei passaggi precedenti si è fatto uso delle seguenti proprietà:
- *Proprietà di sostituzione della delta di Kronecker*: poiché le componenti di $delta_(i j)$ sono costanti ($1$ se $i=j$, $0$ se $i != j$), il tensore esce dall'operatore di derivazione spaziale; la successiva somma sull'indice muto $j$ seleziona unicamente il termine con $j = i$, trasformando $-delta_(i j) (partial p)/(partial x_j)$ nella componente $i$-esima del gradiente di pressione, $-(partial p)/(partial x_i)$.
- *Definizione cinematica di $D_(i j)$*: si è sostituito il tensore velocità di deformazione con la parte simmetrica del gradiente di velocità, $D_(i j) = 1/2 ((partial u_i)/(partial x_j) + (partial u_j)/(partial x_i))$, semplificando il fattore $2$ con la frazione $1/2$.
- *Dipendenza spaziale della viscosità*: nel caso generale la viscosità dinamica $mu$ può variare punto per punto (ad esempio a causa di gradienti termici, $mu = mu(T(arrow(x)))$) e pertanto, in questo stadio della derivazione, deve rimanere all'interno dell'operatore di derivazione $partial/(partial x_j)$.

In notazione vettoriale compatta, lo sviluppo della divergenza del tensore degli sforzi si riassume come:

$ nabla dot overline(overline(sigma)) = -nabla p + nabla dot (2 mu overline(overline(D))) $

Sostituendo l'espressione per componenti appena ricavata nell'equazione di bilancio della quantità di moto (equazione di Cauchy), si ottiene:

$ rho (D u_i)/(D t) = -(partial p)/(partial x_i) + rho f_i + partial/(partial x_j) [mu ((partial u_i)/(partial x_j) + (partial u_j)/(partial x_i))] $

Sviluppo ora il termine viscoso nel caso in cui $mu = "cost"$ e $rho = "cost"$:

// [DA AUDIO]
L'ipotesi di viscosità dinamica costante ($mu = "cost"$) è fisicamente solida in assenza di forti gradienti di temperatura. Sebbene nei fluidi reali (come acqua e aria) la viscosità dipenda dalla temperatura, in problemi isotermi o in cui gli effetti termici sono trascurabili tale dipendenza può essere omessa, permettendo di portare $mu$ fuori dall'operatore di derivazione spaziale.

$
partial/(partial x_j) [mu ((partial u_i)/(partial x_j) + (partial u_j)/(partial x_i))] &= mu (partial^2 u_i)/(partial x_j partial x_j) + mu partial/(partial x_j) (partial u_j)/(partial x_i) = mu (partial^2 u_i)/(partial x_j^2) + mu partial/(partial x_i) underbrace((partial u_j)/(partial x_j), "Th. di" \ "Schwartz")
$

// [DA AUDIO]
Interpretazione operatoriale dei due contributi viscosi:
- Il primo termine, $(partial^2 u_i)/(partial x_j^2) = partial/(partial x_j) ((partial u_i)/(partial x_j))$, rappresenta la divergenza del gradiente di $u_i$, ovvero l'operatore Laplaciano applicato al campo di velocità: $mu nabla^2 u_i = mu Delta u_i$.
- Nel secondo termine, invertendo l'ordine di derivazione grazie al teorema di Schwarz, l'operatore interno $(partial u_j)/(partial x_j)$ (con indice $j$ ripetuto e saturato) è uno scalare pari alla divergenza del campo di velocità ($nabla dot arrow(u)$), a cui viene applicato l'operatore gradiente $partial/(partial x_i)$ (con indice libero $i$), restituendo il vettore $mu nabla (nabla dot arrow(u))$.

Per la conservazione della massa con $rho = "cost"$, si ha $(partial u_j)/(partial x_j) = 0$, ovvero $nabla dot arrow(u) = 0$.

Ottengo dunque che:

$
rho (D u_i)/(D t) &= -(partial p)/(partial x_i) + rho f_i + mu (partial^2 u_i)/(partial x_j^2) \
rho (D arrow(u))/(D t) &= -nabla p + rho arrow(f) + mu Delta arrow(u)
$

// [DA AUDIO]
Dividendo l'equazione per la densità $rho$, ponendo la forza di massa pari all'accelerazione di gravità ($arrow(f) = arrow(g)$) ed esplicitando la derivata materiale, si ottiene la forma vettoriale dell'equazione di Navier-Stokes per un fluido incomprimibile:

$ (partial arrow(u))/(partial t) + (arrow(u) dot nabla) arrow(u) = -1/rho nabla p + arrow(g) + nu Delta arrow(u) $

dove $nu = mu / rho$ è la viscosità cinematica del fluido, avente dimensioni fisiche $[nu] = "m"^2 / "s"$.

Ciascun termine dell'equazione possiede uno specifico significato fisico e matematico:
- $(partial arrow(u))/(partial t)$: termine instazionario (variazione locale nel tempo);
- $(arrow(u) dot nabla) arrow(u)$: termine convettivo (prodotto interno tra il vettore velocità e l'operatore gradiente applicato a $arrow(u)$);
- $-1/rho nabla p$: termine dovuto al gradiente di pressione;
- $arrow(g)$: termine di forza di volume (gravità);
- $nu Delta arrow(u)$: termine viscoso o diffusivo.

Il termine convettivo $(arrow(u) dot nabla) arrow(u)$ (in componenti $u_j (partial u_i)/(partial x_j)$) costituisce il termine non lineare dell'equazione di Navier-Stokes ed è la principale fonte della sua complessità matematica: esso descrive l'interazione del campo di velocità con se stesso e, nello spazio tridimensionale, si sviluppa in $9$ termini scalari in cui ogni componente di velocità si accoppia con i gradienti spaziali di tutte le componenti.

// [DA AUDIO]
=== Fenomeni fisici nell'equazione di Navier-Stokes

L'equazione di Navier-Stokes racchiude tre meccanismi fisici fondamentali:
1. *Convezione* (termine convettivo): trasporto coerente di fluido e di quantità di moto su scala macroscopica.
2. *Diffusione* (termine viscoso): scambio di quantità di moto tra strati (lamelle) adiacenti di fluido dovuto al moto di agitazione caotica delle molecole su scala microscopica.
3. *Propagazione di onde di pressione o acustiche*: fenomeno legato alla comprimibilità del fluido, in cui l'addensamento locale delle particelle fluide genera spinte normali sulle particelle adiacenti seguito da rilassamento.

Confrontando le scale caratteristiche di velocità dei tre fenomeni:
- La propagazione delle onde di pressione avviene alla velocità del suono $c$ (dell'ordine di $300 "m/s"$ nell'aria e circa $10$ volte superiore nell'acqua, poiché meno comprimibile), risultando estremamente più rapida sia rispetto ai fenomeni diffusivi (molto lenti, caratterizzati da tempi scala dell'ordine delle ore o dei giorni), sia rispetto alle tipiche velocità convettive in regime subsonico.
- Al diminuire della comprimibilità del fluido, la velocità del suono aumenta. Nel modello limite di fluido perfettamente incomprimibile ($rho = "cost"$), la velocità di propagazione delle onde di pressione tende a infinito ($c arrow.r infinity$).
- Fisicamente, ciò implica che nel modello incomprimibile questo terzo fenomeno è banalizzato: qualsiasi perturbazione di pressione si propaga istantaneamente in tutto il dominio, facendo sì che il campo di pressione raggiunga all'istante una configurazione di equilibrio determinata dal bilanciamento tra i termini convettivi e i termini diffusivi.

// [DA AUDIO]
=== Ruolo della gravità e scomposizione della pressione

In ogni punto del fluido la pressione $p$ può essere scomposta nella somma di due contributi:

$ p = p_("HS") + p^* $

dove:
- $p_("HS")$ è il contributo idrostatico, ovvero la distribuzione di pressione che si avrebbe se il fluido fosse in quiete;
- $p^*$ è il contributo dinamico (non idrostatico), che rappresenta la variazione locale di pressione rispetto alla condizione statica indotta esclusivamente dal movimento del fluido.

Per la legge dell'idrostatica, il gradiente della pressione idrostatica bilancia la forza peso per unità di volume:

$ nabla p_("HS") = rho arrow(g) $

Esprimendo il gradiente di pressione totale come somma dei due gradienti:

$ nabla p = nabla p_("HS") + nabla p^* = rho arrow(g) + nabla p^* $

e sostituendo tale relazione nei termini di pressione e gravità dell'equazione di Navier-Stokes (con $rho = "cost"$), si ottiene:

$ -1/rho nabla p + arrow(g) = -1/rho (rho arrow(g) + nabla p^*) + arrow(g) = -arrow(g) - 1/rho nabla p^* + arrow(g) = -1/rho nabla p^* $

L'equazione di Navier-Stokes può quindi essere riscritta eliminando esplicitamente l'accelerazione di gravità:

$ (partial arrow(u))/(partial t) + (arrow(u) dot nabla) arrow(u) = -1/rho nabla p^* + nu Delta arrow(u) $

Da questo risultato discendono importanti conseguenze fisiche:
- *Indipendenza della dinamica dalla gravità*: per un fluido a densità costante ($rho = "cost"$), la gravità non ha alcuna influenza sulla dinamica del fluido; il campo di velocità $arrow(u)$ e il campo di pressione dinamica $p^*$ dipendono unicamente dall'interazione tra effetti convettivi e viscosi.
- *Calcolo della pressione totale*: una volta determinato $p^*$ tramite l'equazione del moto (ad esempio attorno a un corpo investito da una corrente, dove $p^* > 0$ nella zona di impatto a monte e $p^* < 0$ a valle), la pressione effettiva $p$ si ottiene sommando a posteriori il contributo idrostatico $p_("HS")$ calcolato separatamente tramite la statica dei fluidi ($nabla p_("HS") = rho arrow(g)$) a partire da una pressione di riferimento.
- *Limiti di validità*: l'indipendenza del campo di moto dalla gravità cessa di valere non appena la densità non è più uniforme ($rho != "cost"$), come avviene in presenza di forti gradienti di temperatura (convezione naturale) o in flussi multifase a superficie libera (ad esempio acqua che scorre in aria, dove il salto di densità di un fattore circa $10^3$ tra i due fluidi rende il termine gravitazionale determinante).

=== Esempio di flusso viscoso

$arrow.r$ Moto di Couette $equiv$ Piano

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    La normale è entrante; significa che calcolo la forza della placca sul fluido.

    Il campo evolve linearmente con $x_2$:

    $ (partial u_1)/(partial x_2) = U_e / h $
  ],
  [
    #canvas(length: 1cm, {
  import draw: *

  // 1. Parete inferiore e tratteggio (nero)
  line((0, 0), (7.7, 0), mark: (end: ">", size: 0.15), stroke: 1pt + black)
  line((0.25, 0), (0.05, -0.22), stroke: 0.8pt + black)
  line((0.90, 0), (0.70, -0.22), stroke: 0.8pt + black)
  line((1.55, 0), (1.35, -0.22), stroke: 0.8pt + black)
  line((2.20, 0), (2.00, -0.22), stroke: 0.8pt + black)
  line((2.85, 0), (2.65, -0.22), stroke: 0.8pt + black)
  line((3.50, 0), (3.30, -0.22), stroke: 0.8pt + black)
  line((4.15, 0), (3.95, -0.22), stroke: 0.8pt + black)
  line((4.80, 0), (4.60, -0.22), stroke: 0.8pt + black)
  line((5.95, 0), (5.75, -0.22), stroke: 0.8pt + black)
  line((6.70, 0), (6.50, -0.22), stroke: 0.8pt + black)

  // 2. Lastra superiore (nero)
  line((7.1, 2.5), (0.2, 2.5), (0.2, 2.2), (7.1, 2.2), stroke: 1pt + black)
  bezier((7.1, 2.5), (7.1, 2.35), (7.02, 2.45), (7.02, 2.40), stroke: 1pt + black)
  bezier((7.1, 2.35), (7.1, 2.2), (7.18, 2.30), (7.18, 2.25), stroke: 1pt + black)

  // 3. Profilo di velocità (rosso-marrone)
  line((2.3, 0), (2.3, 2.2), stroke: 0.9pt + rgb("#8c3824"))
  line((2.3, 0), (4.7, 2.2), stroke: 0.9pt + rgb("#8c3824"))

  line((2.3, 0.35), (2.68, 0.35), mark: (end: ">", size: 0.12), stroke: 0.8pt + rgb("#8c3824"))
  line((2.3, 0.72), (3.09, 0.72), mark: (end: ">", size: 0.14), stroke: 0.8pt + rgb("#8c3824"))
  line((2.3, 1.10), (3.50, 1.10), mark: (end: ">", size: 0.15), stroke: 0.8pt + rgb("#8c3824"))
  line((2.3, 1.47), (3.90, 1.47), mark: (end: ">", size: 0.15), stroke: 0.8pt + rgb("#8c3824"))
  line((2.3, 1.85), (4.32, 1.85), mark: (end: ">", size: 0.15), stroke: 0.8pt + rgb("#8c3824"))
  

  // 4. Versore normale n e velocità U
  line((5.44, 2.2), (5.44, 1.8),mark: (end: ">", size: 0.16), stroke: 0.8pt + rgb("#8c3824"))
  content((5.60, 1.8), text(size: 8pt, fill: rgb("#8c3824"))[$arrow(n)=(0,-1,0)$], anchor: "west")
  line((5.44, 0), (5.44, 0.4),mark: (end: ">", size: 0.16), stroke: 0.8pt + rgb("#8c3824"))
  content((5.60, 0.28), text(size: 8pt, fill: rgb("#8c3824"))[$arrow(n)=(0,1,0)$], anchor: "west")
  line((6.8, 2.35), (8.0, 2.35), mark: (end: ">", size: 0.16), stroke: 0.9pt + rgb("#8c3824"))

  // 5. Quota h e assi x_2, x_3 (nero)
  line((0.85, 0.05), (0.85, 2.15), mark: (start: ">", end: ">", size: 0.15), stroke: 0.8pt + black)


  // 6. Etichette (tutte con text(size: 7pt))
  content((0.70, 1.1), text(size: 7pt, fill: black)[$h$], anchor: "east")

  
  content((7.45, 2.72), text(size: 7pt, fill: rgb("#8c3824"))[$arrow(U)_e$], anchor: "south")


  content((7.65, -0.22), text(size: 7pt, fill: black)[$x_1$], anchor: "west")

})
  ]
)
#v(1em)

// [DA AUDIO]
Si considera un fluido viscoso compreso tra due piastre piane parallele indefinite, poste a distanza $h$ (unica dimensione geometrica caratteristica del problema). La piastra inferiore ($x_2 = 0$) è ferma, mentre la piastra superiore ($x_2 = h$) trasla nel proprio piano con velocità costante $U_e$ lungo la direzione $x_1$.

A differenza di un fluido ideale (che trasmette solo sforzi normali e rispetta unicamente la condizione di impermeabilità, potendo scorrere senza attrito lungo la parete), un fluido reale viscoso è in grado di trasmettere sforzi tangenziali. Pertanto, vale la *condizione di aderenza* (*no-slip condition*): il fluido a contatto con una parete solida ha velocità relativa nulla rispetto ad essa, assumendone la medesima velocità:

$ cases(
  u_1 (x_2 = 0) = 0,
  u_1 (x_2 = h) = U_e
) $

Si formulano le seguenti ipotesi sul campo di moto:
- regime stazionario: $partial / (partial t) = 0$;
- moto piano e unidirezionale lungo $x_1$: $arrow(u) = (u_1, u_2, u_3) = (u_1, 0, 0)$, con $u_2 = 0$ e $u_3 = 0$ identicamente nulli;
- invarianza lungo $x_1$ e $x_3$ per l'indefinitezza delle piastre: tutte le derivate spaziali rispetto a $x_1$ e $x_3$ sono nulle ($partial / (partial x_1) = 0$, $partial / (partial x_3) = 0$), per cui $u_1 = u_1 (x_2)$.

Integrando il gradiente costante $(partial u_1)/(partial x_2) = U_e / h$ con le condizioni di aderenza, il profilo di velocità risulta lineare:

$ u_1 (x_2) = U_e x_2 / h $

Devo calcolare il tensore degli sforzi in prossimità della parete mobile $x_2 = h$:

$ lr(sigma_(i j)|)_(x_2 = h) = mat(delim: "[",
  -p + mu ((partial u_1)/(partial x_1) + (partial u_1)/(partial x_1)), mu ((partial u_1)/(partial x_2) + (partial u_2)/(partial x_1)), mu ((partial u_1)/(partial x_3) + (partial u_3)/(partial x_1));
  mu ((partial u_1)/(partial x_2) + (partial u_2)/(partial x_1)), -p + mu ((partial u_2)/(partial x_2) + (partial u_2)/(partial x_2)), mu ((partial u_2)/(partial x_3) + (partial u_3)/(partial x_2));
  mu ((partial u_1)/(partial x_3) + (partial u_3)/(partial x_1)), mu ((partial u_2)/(partial x_3) + (partial u_3)/(partial x_2)), -p + mu ((partial u_3)/(partial x_3) + (partial u_3)/(partial x_3))
)_(x_2 = h) $

Nel caso specifico ho che:

$
lr(sigma_(i j)|)_(x_2 = h) &= mat(delim: "[",
  -p, lr(mu (partial u_1)/(partial x_2)|)_(x_2 = h), 0;
  lr(mu (partial u_1)/(partial x_2)|)_(x_2 = h), -p, 0;
  0, 0, -p
)
= mat(delim: "[",
  -p, mu U_e / h, 0;
  mu U_e / h, -p, 0;
  0, 0, -p
)
$

// [DA AUDIO]
I singoli contributi viscosi $tau_(i j) = 2 mu D_(i j) = mu ((partial u_i)/(partial x_j) + (partial u_j)/(partial x_i))$ si semplificano come segue:
- Componenti normali viscose (diagonali):

$ tau_(1 1) = 2 mu (partial u_1)/(partial x_1) = 0 quad ("poiché" u_1 "non dipende da" x_1) $

$ tau_(2 2) = 2 mu (partial u_2)/(partial x_2) = 0, quad tau_(3 3) = 2 mu (partial u_3)/(partial x_3) = 0 quad ("poiché" u_2 = u_3 = 0) $

  Sulla diagonale principale sopravvive dunque il solo contributo isotropo della pressione $-p$.
- Componenti tangenziali nel piano $(x_1, x_2)$:

$ tau_(1 2) = mu ((partial u_1)/(partial x_2) + (partial u_2)/(partial x_1)) = mu (U_e / h + 0) = mu U_e / h $

  Per la simmetria del tensore degli sforzi si ha $tau_(2 1) = tau_(1 2) = mu U_e / h$. Poiché il gradiente di velocità è uniforme, tale sforzo tangenziale è costante in ogni punto del dominio fluido (sia in $x_2 = 0$ che in $x_2 = h$).
- Componenti tangenziali fuori piano:

$ tau_(1 3) = tau_(3 1) = mu ((partial u_1)/(partial x_3) + (partial u_3)/(partial x_1)) = 0, quad tau_(2 3) = tau_(3 2) = mu ((partial u_2)/(partial x_3) + (partial u_3)/(partial x_2)) = 0 $

  poiché $u_2 = u_3 = 0$ e nessuna grandezza varia lungo $x_3$.

Posso ora calcolare la forza per unità di superficie $T_i = T_(i j) n_j$ ($arrow(T) = overline(overline(sigma)) dot arrow(n)$) esercitata dalla piastra sul fluido:

$
sigma_i &= sigma_(i j) n_j 
&= mat(
  -p, mu U_e / h, 0;
  mu U_e / h, -p, 0;
  0, 0, -p
) mat(0; 1; 0) 
&= (mu U_e / h, -p, 0)
$

$tau_w$: sforzo a parete.

// [DA AUDIO]
Poiché le piastre hanno estensione infinita lungo $x_1$ e $x_3$, la forza totale risulterebbe infinita; ha quindi senso calcolare unicamente la *forza per unità di superficie* (vettore tensione $arrow(t)$ di componenti $t_i = sigma_(i j) n_j$).

Considerando la parete inferiore ($x_2 = 0$), l'orientazione del versore normale $arrow(n)$ distingue l'azione del fluido sulla parete dalla reazione della parete sul fluido:
1. *Forza per unità di superficie esercitata dal fluido sulla parete inferiore*: si utilizza il versore normale uscente dalla parete $arrow(n) = (0, 1, 0)^T$, ottenendo:

$ arrow(t)_("fluido" arrow.r "parete") = (mu U_e / h, -p, 0) $

   Il fluido esercita sulla parete inferiore una componente tangenziale positiva $+mu U_e / h$ lungo $x_1$ (tende a trascinare la parete nel verso del moto) e una componente normale negativa $-p$ lungo $x_2$ (schiaccia la parete verso il basso).
2. *Forza per unità di superficie esercitata dalla parete inferiore sul fluido*: per il principio di azione e reazione, si utilizza il versore normale opposto $arrow(n) = (0, -1, 0)^T$ (oppure questo stesso versore come normale uscente dal fluido sulla parete superiore in $x_2 = h$), ottenendo:

$ arrow(t)_("parete" arrow.r "fluido") = mat(
  -p, mu U_e / h, 0;
  mu U_e / h, -p, 0;
  0, 0, -p
) mat(0; -1; 0) = (-mu U_e / h, p, 0) $

   La parete inferiore reagisce sostenendo il fluido con una pressione normale $+p$ diretta lungo $+x_2$ ed esercitando uno sforzo tangenziale $-mu U_e / h$ diretto lungo $-x_1$, ovvero opposto al moto, che tende a frenare il fluido.

// [DA AUDIO]
#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon),
  [
    #canvas(length: 1cm, {
      import draw: *

      // Titolo schema 1
      content((3.0, 2.3), text(size: 8pt, weight: "bold")[Fluido $arrow.r$ Parete ($arrow(n) = (0, 1, 0)$)], anchor: "center")

      // Parete inferiore e tratteggio
      line((0.5, 1.0), (5.5, 1.0), mark: (end: ">", size: 0.15), stroke: 1pt + black)
      content((5.6, 1.0), text(size: 7pt)[$x_1$], anchor: "west")
      line((0.8, 1.0), (0.6, 0.78), stroke: 0.8pt + black)
      line((1.4, 1.0), (1.2, 0.78), stroke: 0.8pt + black)
      line((2.0, 1.0), (1.8, 0.78), stroke: 0.8pt + black)
      line((2.6, 1.0), (2.4, 0.78), stroke: 0.8pt + black)
      line((3.2, 1.0), (3.0, 0.78), stroke: 0.8pt + black)
      line((3.8, 1.0), (3.6, 0.78), stroke: 0.8pt + black)
      line((4.4, 1.0), (4.2, 0.78), stroke: 0.8pt + black)
      line((5.0, 1.0), (4.8, 0.78), stroke: 0.8pt + black)

      // Versore normale n uscente dalla parete (verso l'alto)
      line((1.5, 1.0), (1.5, 1.8), mark: (end: ">", size: 0.14), stroke: 0.8pt + rgb("#555555"))
      content((1.4, 1.6), text(size: 7pt, fill: rgb("#555555"))[$arrow(n)$], anchor: "east")

      // Componente tangenziale +mu Ue / h
      line((2.8, 1.0), (4.6, 1.0), mark: (end: ">", size: 0.15), stroke: 1pt + rgb("#8c3824"))
      content((3.7, 1.25), text(size: 7pt, fill: rgb("#8c3824"))[$mu U_e / h$], anchor: "south")

      // Componente normale -p
      line((2.8, 1.0), (2.8, -0.4), mark: (end: ">", size: 0.15), stroke: 1pt + rgb("#8c3824"))
      content((2.65, 0.3), text(size: 7pt, fill: rgb("#8c3824"))[$-p$], anchor: "east")

      // Linee di proiezione tratteggiate
      line((4.6, 1.0), (4.6, -0.4), stroke: (paint: rgb("#555555"), thickness: 0.6pt, dash: "dashed"))
      line((2.8, -0.4), (4.6, -0.4), stroke: (paint: rgb("#555555"), thickness: 0.6pt, dash: "dashed"))

      // Vettore risultante t
      line((2.8, 1.0), (4.6, -0.4), mark: (end: ">", size: 0.16), stroke: 1.2pt + black)
      content((4.7, -0.45), text(size: 7pt, fill: black)[$arrow(t)_("fluido" arrow.r "parete")$], anchor: "west")
    })
  ],
  [
    #canvas(length: 1cm, {
      import draw: *

      // Titolo schema 2
      content((3.0, 2.6), text(size: 8pt, weight: "bold")[Parete $arrow.r$ Fluido ($arrow(n) = (0, -1, 0)$)], anchor: "center")

      // Parete inferiore e tratteggio
      line((0.5, 0.2), (5.5, 0.2), mark: (end: ">", size: 0.15), stroke: 1pt + black)
      content((5.6, 0.2), text(size: 7pt)[$x_1$], anchor: "west")
      line((0.8, 0.2), (0.6, -0.02), stroke: 0.8pt + black)
      line((1.4, 0.2), (1.2, -0.02), stroke: 0.8pt + black)
      line((2.0, 0.2), (1.8, -0.02), stroke: 0.8pt + black)
      line((2.6, 0.2), (2.4, -0.02), stroke: 0.8pt + black)
      line((3.2, 0.2), (3.0, -0.02), stroke: 0.8pt + black)
      line((3.8, 0.2), (3.6, -0.02), stroke: 0.8pt + black)
      line((4.4, 0.2), (4.2, -0.02), stroke: 0.8pt + black)
      line((5.0, 0.2), (4.8, -0.02), stroke: 0.8pt + black)

      // Versore normale n entrante nella parete (verso il basso)
      line((4.8, 0.2), (4.8, -0.6), mark: (end: ">", size: 0.14), stroke: 0.8pt + rgb("#555555"))
      content((4.9, -0.3), text(size: 7pt, fill: rgb("#555555"))[$arrow(n)$], anchor: "west")

      // Componente tangenziale -mu Ue / h (opposta al moto)
      line((3.4, 0.2), (1.6, 0.2), mark: (end: ">", size: 0.15), stroke: 1pt + rgb("#8c3824"))
      content((2.5, -0.05), text(size: 7pt, fill: rgb("#8c3824"))[$-mu U_e / h$], anchor: "north")

      // Componente normale +p (verso l'alto)
      line((3.4, 0.2), (3.4, 1.6), mark: (end: ">", size: 0.15), stroke: 1pt + rgb("#8c3824"))
      content((3.55, 0.9), text(size: 7pt, fill: rgb("#8c3824"))[$+p$], anchor: "west")

      // Linee di proiezione tratteggiate
      line((1.6, 0.2), (1.6, 1.6), stroke: (paint: rgb("#555555"), thickness: 0.6pt, dash: "dashed"))
      line((3.4, 1.6), (1.6, 1.6), stroke: (paint: rgb("#555555"), thickness: 0.6pt, dash: "dashed"))

      // Vettore risultante t
      line((3.4, 0.2), (1.6, 1.6), mark: (end: ">", size: 0.16), stroke: 1.2pt + black)
      content((1.5, 1.75), text(size: 7pt, fill: black)[$arrow(t)_("parete" arrow.r "fluido")$], anchor: "east")
    })
  ]
)
