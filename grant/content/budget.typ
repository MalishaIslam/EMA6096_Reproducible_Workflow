// NIH PHS 398 Budget Justification – Typst Source
// Principal Investigator: Dr. Kausik Mukhopadhyay

#set page(
  paper: "us-letter",
  margin: (top: 1in, bottom: 1in, left: 1in, right: 1in),
)

#set text(font: "Libertinus Serif", size: 10pt)
#set par(leading: 0.65em)

// ─── Helper: thin ruled table ───────────────────────────────────────────────
#let ruled-table(columns: (), rows) = table(
  columns: columns,
  stroke: 0.5pt,
  inset: 4pt,
  ..rows
)
= Budget

// ─── Title block ────────────────────────────────────────────────────────────
#align(center)[
  #text(weight: "bold", size: 11pt)[4. BUDGET JUSTIFICATIONS and Sample Calculations for the Initial Budget Period:]
]
#v(4pt)
#align(center)[
  #text(size: 10pt)[Sample completed PHS 398 Form for NIH Grants:]
]
#v(6pt)

*Principal Investigator/Program Director (Last, first, middle):* Dr. Kausik Mukhopadhyay

#v(4pt)

// ─── Main budget table header ────────────────────────────────────────────────
#block(
  width: 100%,
  stroke: 0.5pt,
  inset: 4pt,
)[
  #grid(
    columns: (1fr, 1fr, 1fr),
    [*DETAILED BUDGET FOR INITIAL BUDGET PERIOD*\ *DIRECT COSTS ONLY*],
    align(center)[*FROM*\ 07/01/26],
    align(center)[*THROUGH*\ 06/30/26],
  )
]

// ─── Personnel section ───────────────────────────────────────────────────────
#v(4pt)
#text(weight: "bold")[PERSONNEL (Applicant organization only)]

#v(2pt)
#table(
  columns: (1.6fr, 1.1fr, 0.55fr, 0.6fr, 1fr, 0.85fr, 0.85fr, 0.8fr),
  stroke: 0.5pt,
  inset: 3pt,
  align: center,
  // Header row 1
  table.cell(rowspan: 2)[*NAME*],
  table.cell(rowspan: 2)[*ROLE ON\ PROJECT*],
  table.cell(rowspan: 2)[*TYPE\ APPT.\ (months)*],
  table.cell(rowspan: 2)[*%\ EFFORT\ ON\ PROJ.*],
  table.cell(rowspan: 2)[*INST.\ BASE\ SALARY*],
  table.cell(colspan: 3)[*DOLLAR AMOUNT REQUESTED (omit cents)*],
  // Header row 2 (colspan children)
  [*SALARY\ REQUESTED*], [*FRINGE\ BENEFITS*], [*TOTALS*],

  // Data rows
  [Dr. Kausik Mukhopadhyay], [Principal Investigator], [9],  [15%], [\$123,456], [\$18,518], [\$3,537],  [\$22,055],
  [Dr. Kausik Mukhopadhyay], [PI],                    [3],  [30%], [\$41,152],  [\$12,346], [\$2,358],  [\$14,704],
  [Person X],               [Postdoctoral Fellow],    [12], [40%], [\$65,315],  [\$26,126], [\$3,919],  [\$30,045],
  [Malisha Islam Tapotee],  [Res. Asst.],             [12], [100%],[\$30,000],  [\$30,000], [\$1,500],  [\$31,500],
  [Person Y],               [Res. Asst.],             [12], [100%],[\$30,000],  [\$30,000], [\$1,500],  [\$31,500],
  [Person Z],               [Software Engineer],      [12], [100%],[\$70,000],  [\$70,000], [\$10,500], [\$80,500],
  // Subtotal from x-personnel sheet
  table.cell(colspan: 5, align: left)[Subtotal from x-personnel sheet], [0], [0], [0],
  // SUBTOTALS
  table.cell(colspan: 5, align: left)[*SUBTOTALS*], [], [\$186,990], [\$23,314], [\$210,304],
)

// ─── Consultant Costs ────────────────────────────────────────────────────────
#v(4pt)
#table(
  columns: (1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  [*CONSULTANT COSTS*\ Bioinformatics Consultant (5 days \@ \$250 per day; also \$1,500 for travel, accommodations, and per diem)\ See Detailed Budget Justification],
  [\$2,750],
)

// ─── Equipment ───────────────────────────────────────────────────────────────
#v(4pt)
#table(
  columns: (1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  [*EQUIPMENT (Itemize)*\ Dell Precision 7865 Tower AMD Threadripper PRO 5975WX 256GB 2TB M.2 RTX A4000\ See Detailed Budget Justification],
  [\$6,500],
)

// ─── Supplies ────────────────────────────────────────────────────────────────
#v(4pt)
#table(
  columns: (1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  [*SUPPLIES (Itemize by category)*\ Secure Cloud Storage & Backup: \$4,000\ Office and Printing Supplies: \$1,500\ API Access & Database Subscription Fees: \$3,000\ Data Archival & DOI Registration Fees: \$2,000\ Software Licenses (Bioinformatics tools): \$2,000\ See Detailed Budget Justification],
  [\$12,500],
)

// ─── Travel ──────────────────────────────────────────────────────────────────
#v(4pt)
#table(
  columns: (1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  [*TRAVEL*\ Local in-state travel: \$2,000 #h(1em) Out-of-state travel: \$5,500 #h(1em) See Detailed Budget Justification.],
  [\$7,500],
)

// ─── Patient Care ────────────────────────────────────────────────────────────
#v(4pt)
#table(
  columns: (1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  [*PATIENT CARE COSTS*],  [],
  [INPATIENT],  [0],
  [OUTPATIENT], [0],
)

// ─── Alterations ─────────────────────────────────────────────────────────────
#v(4pt)
#table(
  columns: (1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  [*ALTERATIONS AND RENOVATIONS (Itemize by category)*], [0],
)

// ─── Other Expenses ──────────────────────────────────────────────────────────
#v(4pt)
#table(
  columns: (1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  [*OTHER EXPENSES (Itemize by category)*\ Open Access Publication Fees: \$4,000 #h(1em) Website Maintenance & Security: \$1,500\ Web Hosting and Database Deployment: \$2,500 #h(1em) See Detailed Budget Justification],
  [\$8,000],
)

// ─── Subtotal Direct Costs ───────────────────────────────────────────────────
#v(4pt)
#table(
  columns: (1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  [*SUBTOTAL DIRECT COSTS FOR INITIAL BUDGET PERIOD*], [*\$ 247,554*],
)

// ─── Consortium ──────────────────────────────────────────────────────────────
#v(4pt)
#table(
  columns: (1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  table.cell(rowspan: 2)[*CONSORTIUM/CONTRACTUAL COSTS*],
  [],
  [DIRECT COSTS],  [\$15,000],
  [INDIRECT COSTS],[\$3,750],
)

// ─── Total Direct Costs ──────────────────────────────────────────────────────
#v(4pt)
#table(
  columns: (1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  [*TOTAL DIRECT COSTS FOR INITIAL BUDGET PERIOD (Item 7a, Face Page)*], [*\$ 266,304*],
)

#v(6pt)
#text(size: 9pt)[PHS 398 (Rev.05/01) #h(1fr) Page \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ Form Page 4]

// ════════════════════════════════════════════════════════════════════════════
// PAGE 2 – Budget Justifications
// ════════════════════════════════════════════════════════════════════════════
//#pagebreak()

// ─── a. PERSONNEL ────────────────────────────────────────────────────────────
*a. #underline[PERSONNEL]*

#v(4pt)
*i. #underline[Salary]* for faculty member with 9-month academic appointment:

#v(4pt)
#table(
  columns: (1.5fr, 0.9fr, 0.5fr, 0.55fr, 1fr, 0.85fr, 0.85fr, 0.75fr),
  stroke: 0.5pt,
  inset: 3pt,
  align: center,
  table.cell(rowspan: 2, colspan: 2)[*PERSONNEL\ (Applicant organization only)*],
  [],[], [],
  table.cell(colspan: 3)[*DOLLAR AMOUNT REQUESTED\ (Omit cents)*],
  [Type\ Appt], [% Effort\ on\ Project], [Institutional\ Base Salary],
  [Salary\ Requested], [Fringe\ Benefits], [TOTALS],

  [Dr. Kausik\ Mukhopadhyay], [PI], [9], [15%], [\$123,456], [\$18,518], [\$3,537], [\$22,055],
  [Dr. Kausik\ Mukhopadhyay], [PI], [3], [30%], [\$41,152],  [\$12,346], [\$2,358], [\$14,704],
)

#v(6pt)
- *9-mo Salary Requested:*
  - \$123,456 × 15% = 18,518

- *Summer Salary Requested:*
  - [(\$123,456 / 9 mo) × 3 mo] × 30% = [41,152] × 30% = 12,346

#v(4pt)
*ii. #underline[Fringe Benefits]* for faculty member with 9-month academic appointment:

- 9-mo Academic Year: (A+B+C+D) × Salary\ 19.10%) × 18,518 = 3,537

- Summer: (A+B+C+D) × Salary = (19.10%) × 12,346 = 2,358

#v(4pt)
#underline[Justification:]

*Dr. Kausik Mukhopadhyay – Principal Investigator.* Dr. Mukhopadhyay will provide overall scientific leadership for the project, oversee UniProt data extraction and ambiguous amino acid resolution strategies, supervise machine learning model development, and guide database architecture and dissemination. Effort is 15% during the academic year and 30% during summer months, consistent with institutional policies.

// ─── b. CONSULTANT COSTS ─────────────────────────────────────────────────────
#v(8pt)
*b. #underline[CONSULTANT COSTS]*

#v(4pt)
#table(
  columns: (1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  [*CONSULTANT COSTS*\ Bioinformatics Consultant (5 days \@ \$250 per day; also \$1,500 for travel, accommodations, and per diem)],
  [2,750],
)

#v(4pt)
Sample Calculation: [5 days × \$250/day + \$1,500] = 2,750

#v(4pt)
#underline[Justification:]

*Consultants –* A bioinformatics consultant will assist with resolving ambiguous amino acids (X residues) and validating annotation mapping methods.

// ─── c. EQUIPMENT ────────────────────────────────────────────────────────────
#v(8pt)
*c. #underline[EQUIPMENT]*

#v(4pt)
#table(
  columns: (1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  [*EQUIPMENT*\ Dell Precision 7865 Tower AMD Threadripper PRO 5975WX 256GB 2TB M.2 RTX A4000],
  [6,500],
)

#underline[Justification:]

*EQUIPMENT* – The budget includes a Dell Precision 7865 Tower workstation for local computational development. The estimated cost is \$6,500. This system will include 128 GB RAM, multi-core processor, large SSD storage, and a GPU. It will be used for preprocessing UniProt data, feature computation, and machine learning prototyping before scaling to UCF's ARCC cluster. Since ARCC is used for large-scale training, only one modest workstation is requested.

// ─── d. SUPPLIES ─────────────────────────────────────────────────────────────
#v(8pt)
*d. #underline[SUPPLIES]*

#v(4pt)
#table(
  columns: (1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  [*SUPPLIES*\ Secure Cloud Storage & Backup: \$4,000; Office and Printing Supplies: \$1,500; API Access & Database Subscription Fees: \$3,000; Data Archival & DOI Registration Fees: \$2,000;\ Software Licenses (Bioinformatics tools): \$2,000 #h(1em) See detailed budget justification.],
  [12,500],
)

#underline[Justification:]

Supplies include computational and operational costs.

*Secure cloud storage and backup* are budgeted at \$4,000 to maintain secure copies of UniProt datasets and derived feature tables.

*API access and database subscription fees* are budgeted at \$3,000 to allow automated data retrieval and cross-database validation.

*Data archival and DOI registration fees* are budgeted at \$2,000 to ensure the curated peptide database is publicly archived.

*Software licenses for bioinformatics tools* are budgeted at \$2,000.

*Office and printing supplies* are budgeted at \$1,500.

// ─── e. TRAVEL ───────────────────────────────────────────────────────────────
#v(8pt)
*e. #underline[TRAVEL]*

#v(4pt)
#table(
  columns: (1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  [*TRAVEL*\ Local in-state travel: \$2,000; Out-of-state travel: \$5,500. See detailed budget justification.],
  [7,500],
)

#underline[Justification:]

#h(2em)*Local in-state travel* is budgeted at \$2,000 for collaborative meetings and institutional coordination.

#h(2em)*Out-of-state travel* is budgeted at \$5,500 for conference dissemination. This includes airfare (~\$800), hotel (~\$900), registration (~\$900), and per diem (~\$300) per person, multiplied appropriately for key project personnel.

// ─── f. OTHER EXPENSES ───────────────────────────────────────────────────────
#v(8pt)
*f. #underline[OTHER EXPENSES]*

#v(4pt)
#table(
  columns: (1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  [*OTHER EXPENSES*\ Bulk printing: \$2,721; General Other: \$3,500; School Incentives: \$12,000; Participant Costs: \$1,100],
  [\$19,321],
)

#underline[Justification:]

#h(2em)*Open-access publication fees* are budgeted at \$4,000 to ensure public access to results.

#h(2em)*Web hosting and database deployment* are budgeted at \$2,500.

#h(2em)*Website maintenance and security* are budgeted at \$1,500.

// ─── g. CONSORTIUM/SUBCONTRACT COSTS ─────────────────────────────────────────
#v(8pt)
*g. #underline[CONSORTIUM/SUBCONTRACT COSTS]*

#v(4pt)
NIH PHS 398 Example:

#v(4pt)
#table(
  columns: (auto, 1fr, auto),
  stroke: 0.5pt,
  inset: 4pt,
  table.cell(rowspan: 2)[Consortium/\ Subcontract Costs],
  [Direct Costs],                       [\$ 15,000],
  [Facilities and Administrative Costs\*], [\$ 3,750],
)

#v(4pt)
\*The approved F&A cost rate at subcontractor institution is only 25% in this example. The University's (i.e., UCF) F&A rate will be applied to both the consortium/subcontractor Direct Costs and F&A Costs.

#underline[Justification]

#h(2em)An external collaborating institution will provide statistical validation support. The consortium includes \$15,000 in direct costs, with indirect costs calculated at 25% (\$15,000 × 0.25 = \$3,750), resulting in a total consortium cost of \$18,750.
