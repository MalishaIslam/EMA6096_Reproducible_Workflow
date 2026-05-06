// ─────────────────────────────────────────────────────────────────────────────
// Curating Peptide Databases & Quantifying Ambiguity Impacts on AI-Based
// Function Prediction — research overview diagram
// Compile with: typst compile peptide_diagram.typ
// ─────────────────────────────────────────────────────────────────────────────

#set page(
  width:  490mm,
  height: 230mm,
  margin: (x: 7mm, y: 6mm),
)
#set text(font: "Libertinus Sans", size: 14pt, lang: "en")

// ── Palette ──────────────────────────────────────────────────────────────────
#let c-title-bg    = rgb("#1c2b3a")
#let c-orange-bg   = rgb("#fff8ee")
#let c-orange      = rgb("#e07b10")
#let c-blue-bg     = rgb("#eaf4fb")
#let c-blue        = rgb("#1f78b4")
#let c-blue-btn    = rgb("#1f6090")
#let c-green-bg    = rgb("#eaf7ef")
#let c-green       = rgb("#1a7d3c")
#let c-green-btn   = rgb("#155e2d")
#let c-purple-bg   = rgb("#f7f0fb")
#let c-purple      = rgb("#7b3fa0")
#let c-purple-btn  = rgb("#5c2d7a")
#let c-text-muted  = rgb("#555555")
#let c-red         = rgb("#d32f2f")

// ── Helpers ───────────────────────────────────────────────────────────────────

// A rounded card used inside AIM columns
#let aim-card(title, body, border-color: c-blue) = rect(
  stroke:  border-color + 0.8pt,
  radius:  5pt,
  inset:   (x: 7pt, y: 6pt),
  width:   100%,
)[
  #text(weight: "bold", fill: border-color)[#title]
  #v(2pt)
  #body
]

// A plain rounded box used in OUTCOMES
#let outcome-card(body, border-color: c-purple) = rect(
  stroke:  border-color + 0.6pt,
  radius:  4pt,
  inset:   (x: 6pt, y: 5pt),
  width:   100%,
)[
  #align(center)[#body]
]

// Dark filled button-style box
#let bottom-btn(body, fill-color) = rect(
  fill:   fill-color,
  radius: 5pt,
  inset:  (x: 8pt, y: 7pt),
  width:  100%,
)[
  #align(center)[
    #text(fill: white, weight: "bold")[#body]
  ]
]

// ── Title bar ─────────────────────────────────────────────────────────────────
#rect(
  fill:   c-title-bg,
  radius: 6pt,
  inset:  (x: 12pt, y: 9pt),
  width:  100%,
)[
  #align(center)[
    #text(fill: white, size: 26pt, weight: "bold")[
      Curating Peptide Databases & Quantifying Ambiguity Impacts on AI-Based Function Prediction
    ]
  ]
]

#v(4pt)

// ── Arrow between columns ─────────────────────────────────────────────────────
#let col-arrow = align(center + horizon)[
  #text(size: 15pt, fill: rgb("#444444"), weight: "bold")[→]
]

// ── Four-column layout ────────────────────────────────────────────────────────
#grid(
  columns: (1fr, 16pt, 1fr, 16pt, 1fr, 16pt, 1fr),

  // ════════════════════════════════════════════════════════════════════════════
  // COLUMN 1 — PROBLEM
  // ════════════════════════════════════════════════════════════════════════════
  rect(
    fill:   c-orange-bg,
    stroke: c-orange + 2pt,
    radius: 8pt,
    inset:  (x: 9pt, y: 9pt),
  )[
    #align(center)[
      #text(fill: c-orange, weight: "bold", size: 18pt)[⚠ PROBLEM]
    ]
    #v(7pt)
    #text(style: "italic")[UniProt peptide entries contain:]
    #v(5pt)
    #list(
      marker: [•],
      indent: 4pt,
      spacing: 4pt,
      [Unknown residues (X symbols)],
      [Single / incomplete functional labels],
    )
    #v(7pt)
    // Sequence example
    #rect(
      stroke: c-orange + 0.8pt,
      radius: 3pt,
      inset:  (x: 8pt, y: 5pt),
      width:  100%,
    )[
      #align(center)[
        AL#h(4pt)#text(fill: c-red, weight: "bold")[X]#h(4pt)DKAL#h(4pt)#text(fill: c-red, weight: "bold")[X]#h(4pt)LG
      ]
    ]
    #v(8pt)
    #align(center)[
      #text(style: "italic")[~30–40 % of sequences\
      contain ≥ 1 ambiguous residue]
    ]
    #v(6pt)
    #text(fill: c-red)[→ Feature extraction fails]\
    #text(fill: c-red)[→ Prediction accuracy drops]
    #v(8pt)
    #align(center)[
      50 k – 100 k peptide\
      sequences in scope
    ]
    #v(8pt)
    #rect(
      stroke: c-orange + 0.8pt,
      radius: 3pt,
      inset:  (x: 8pt, y: 5pt),
      width:  100%,
    )[
      #align(center)[
        #text(style: "italic")[Source: UniProt database]
      ]
    ]
  ],

  col-arrow,

  // ════════════════════════════════════════════════════════════════════════════
  // COLUMN 2 — AIM 1: Database Curation
  // ════════════════════════════════════════════════════════════════════════════
  rect(
    fill:   c-blue-bg,
    stroke: c-blue + 2pt,
    radius: 8pt,
    inset:  (x: 9pt, y: 9pt),
  )[
    #align(center)[
      #text(fill: c-blue, weight: "bold", size: 18pt)[AIM 1 — Database Curation]
    ]
    #v(7pt)
    #aim-card(
      [*[1]* BLASTP Search],
      [
        DBAASP · APD3 · DRAMP\
        ≥ 95 % sequence identity
      ],
      border-color: c-blue,
    )
    #v(5pt)
    #aim-card(
      [*[2]* Literature Verification],
      [
        PubMed-linked records\
        Manual residue confirmation
      ],
      border-color: c-blue,
    )
    #v(5pt)
    #aim-card(
      [*[3]* UniRef Cluster Consensus],
      [
        Group sequences by identity\
        ≥ 80 % residue agreement\
        → Resolved Sequences
      ],
      border-color: c-blue,
    )
    #v(5pt)
    #aim-card(
      [Multi-label Annotation Expansion],
      [
        Antimicrobial · Anticancer · Antiviral\
        Antifungal · Immunomodulatory · Hemolytic
      ],
      border-color: c-blue,
    )
    #v(8pt)
    #bottom-btn([Curated Peptide Database], c-blue-btn)
  ],

  col-arrow,

  // ════════════════════════════════════════════════════════════════════════════
  // COLUMN 3 — AIM 2: Impact Modelling
  // ════════════════════════════════════════════════════════════════════════════
  rect(
    fill:   c-green-bg,
    stroke: c-green + 2pt,
    radius: 8pt,
    inset:  (x: 9pt, y: 9pt),
  )[
    #align(center)[
      #text(fill: c-green, weight: "bold", size: 18pt)[AIM 2 — Impact Modelling]
    ]
    #v(7pt)
    #aim-card(
      [Controlled Dataset Conditions (A – I)],
      [
        Sequence masking: 0 % , 5 % , 10 % , 20 % X residues\
        Label masking: 0 % , 10 % , 25 % , 50 % annotations
      ],
      border-color: c-green,
    )
    #v(5pt)
    #aim-card(
      [Feature Encoding],
      [
        One-hot · Physicochemical descriptors\
        Protein language model embeddings
      ],
      border-color: c-green,
    )
    #v(5pt)
    #aim-card(
      [ML Model Training],
      [
        RF · SVM · Gradient Boosting\
        MLP · CNN · Transformer (PyTorch)
      ],
      border-color: c-green,
    )
    #v(5pt)
    #aim-card(
      [Uncertainty-aware Inference],
      [
        MC-Dropout · Ensemble networks\
        Temperature scaling (calibration)
      ],
      border-color: c-green,
    )
    #v(8pt)
    // Evaluation Metrics — dark green filled
    #rect(
      fill:   c-green-btn,
      radius: 5pt,
      inset:  (x: 8pt, y: 7pt),
      width:  100%,
    )[
      #align(center)[
        #text(fill: white, weight: "bold")[Evaluation Metrics]\
        #v(2pt)
        #text(fill: white)[
          AUROC · F1 · Accuracy\
          Calibration Error · Prediction Entropy
        ]
      ]
    ]
  ],

  col-arrow,

  // ════════════════════════════════════════════════════════════════════════════
  // COLUMN 4 — OUTCOMES
  // ════════════════════════════════════════════════════════════════════════════
  rect(
    fill:   c-purple-bg,
    stroke: c-purple + 2pt,
    radius: 8pt,
    inset:  (x: 9pt, y: 9pt),
  )[
    #align(center)[
      #text(fill: c-purple, weight: "bold", size: 18pt)[✓ OUTCOMES]
    ]
    #v(7pt)
    #outcome-card([
      Curated peptide DB\
      (50 k–100 k entries)
    ])
    #v(4pt)
    #outcome-card([
      Resolved X residues\
      with evidence trail
    ])
    #v(4pt)
    #outcome-card([
      Multi-label functional\
      annotations
    ])
    #v(4pt)
    #outcome-card([
      Quantified ambiguity\
      impact on ML models
    ])
    #v(4pt)
    #outcome-card([
      Higher AUROC &\
      lower uncertainty
    ])
    #v(4pt)
    #outcome-card([
      Reliable AI-based\
      function prediction
    ])
    #v(8pt)
    #bottom-btn([Improved Peptide\ Function Prediction], c-purple-btn)
  ],
)

// ── Footer ────────────────────────────────────────────────────────────────────
#v(28pt)
#align(left)[
  #text(size: 15pt, fill: black)[
    Data sources: UniProt · DBAASP · APD3 · DRAMP · UniRef
    | Encodings: one-hot, physicochemical, transformer embeddings
    | Validation: bootstrap CIs, 5-fold CV, paired t-tests
  ]
]
