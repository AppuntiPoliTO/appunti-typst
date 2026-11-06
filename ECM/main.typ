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
// --- INTESTAZIONE ---
#align(center)[
  #v(0.5cm)
  #line(length: 100%, stroke: 1.5pt)
  #v(0.4cm, weak: true)
  #text(size: 20pt, weight: "bold", fill: black )[Appunti di Elementi di Costruzione di Macchine  ] \
  #v(0.4cm, weak: true)
  #text(size: 12pt, style: "italic")[Corso del Prof. Eugenio Brusa] \
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
      #text(size: 9pt)[Anno Accademico 2026/2027]
    ]
  )
  #v(1cm)
]

// --- INDICE ---
#outline(indent: auto, depth: 2)
#pagebreak()
#include "fatica.typ"
#include "alberi.typ"
#include "ruote dentate.typ"
#include "hertz.typ"
#include "solidi.typ"
#include "calettamenti.typ"
#include "accoppiamenti.typ"
#include "cuscinetti.typ"
#include "molle.typ"