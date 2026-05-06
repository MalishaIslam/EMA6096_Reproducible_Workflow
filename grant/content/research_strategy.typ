= Research Strategy 

#figure(
  // The content of the figure (e.g., an image file or shape)
  image("../Figures/Graphical Abstract.svg", width: 100%),

  // The caption text
  caption: [*Graphical Abstract of Proposed Aims.*],
)

== Approach
_#underline[*_Preliminary Data_*]_

#set par(justify: true)
We developed a reproducible analysis pipeline using reviewed UniProt protein sequences that contain unknown amino acid residues (X). The pipeline automatically builds a SQLite database, extracts sequence features, performs statistical analysis, and generates figures through a containerized workflow. Figure 2(a) shows the relationship between protein sequence length and the number of unknown residues. Most proteins contain only a small number of unknown residues, while a few proteins contain much larger uncertainty levels. This plot helps identify how sequence ambiguity changes across proteins of different lengths. Figure 2(b) shows a UMAP projection of the protein sequences based on sequence-level similarity. The colors represent proteins with single or multiple unknown residues, and point size represents the number of unknown residues. This visualization helps explore whether proteins with higher uncertainty form similar sequence-level patterns or clusters in the dataset.

#figure(
  grid(
    columns: (40%, 60%),
    column-gutter: 1.5em,
    [#image("../Figures/fig_length_vs_x_count.png")
     #align(center)[(a)]],
    [#image("../Figures/fig_umap_sequence_projection.png")
     #align(center)[(b)]],
  ),
  caption: [
    (a) Protein sequence length versus unknown residue count (X) in UniProt proteins.
    (b) UMAP projection of UniProt protein sequences containing unknown residues (X).
  ]
) <fig-overview>


=== Specific Aim 1: Resolve unknown amino acids and expand functional annotations

#set par(justify: true)
_#underline[*_Rationale:_*]_ Peptide sequence databases are widely used in biological and biomedical research. Among them, UniProt @uniprot2019uniprot is one of the most comprehensive resources for protein and peptide data. It provides sequence information, functional annotations, and references to supporting literature. However, many peptide entries contain incomplete information. In particular, some peptide sequences include unknown amino acids represented by the *symbol X*, which indicates that the identity of the residue is not known. In addition, functional annotations are often incomplete and frequently limited to a single reported activity, even though many peptides exhibit multiple biological functions.

These issues reduce the reliability of peptide databases and limit their usefulness for computational studies. Machine learning models depend on accurate sequence information and reliable labels. When peptide sequences contain unknown residues or incomplete annotations, feature extraction becomes unreliable and prediction accuracy decreases. As a result, ambiguous data can negatively affect computational models that attempt to predict peptide functions.

The objective of this aim is to create a structured and curated peptide dataset by resolving unknown amino acids and expanding functional annotations. 

*Overall Study Design: * This study will develop a structured peptide database by resolving unknown amino acids and expanding incomplete functional annotations in UniProt peptide sequences using external databases, literature verification, and UniRef cluster information. The curated dataset will then be used to create multiple versions of peptide datasets with different levels of sequence ambiguity and annotation completeness. The results will help establish a reliable computational framework for peptide function prediction using high-quality sequence data.

*1.1 Data Extraction and Preprocessing.* Peptide sequence data will be extracted from the UniProt database using automated Python workflows. Data will be retrieved through the UniProt REST API and bulk downloads. The extraction pipeline will be implemented using the Python programming language with libraries such as Biopython, pandas, and requests. Each peptide entry will include information such as the UniProt accession identifier, amino acid sequence, sequence length, functional annotations, literature references, and UniRef cluster identifiers. The extracted dataset will be stored in a structured relational format to allow efficient querying and data management. Table 1 summarizes the key data fields that will be stored in the database.
#align(center)[
#table(
  columns: 2,
  [*Field*], [*Description*],
  [UniProt ID], [Unique peptide identifier],
  [Sequence], [Amino acid sequence],
  [Length], [Number of residues],
  [Functional annotations], [Biological activities],
  [Literature references], [Supporting publications],
  [UniRef cluster ID], [Sequence similarity cluster],
  [Ambiguity flag], [Presence of unknown residues],
)
*Table 1: UniProt Database Key data fields Description.*
]
*1.2 Identification of Ambiguous Peptide Sequences.* After the initial dataset is extracted, peptide sequences will be analyzed to identify unknown amino acids. In UniProt records, unknown residues are represented by the symbol X. Each peptide sequence will therefore be scanned to detect the presence and positions of these ambiguous residues. Sequences will be separated into two groups: those with fully defined amino acids and those containing one or more unknown residues. For ambiguous sequences, the positions of the unknown residues will be recorded in the database. Preliminary analysis of peptide databases suggests that approximately 30–40% of peptide sequences contain at least one ambiguous residue. Identifying these sequences is an important first step because unknown residues interfere with feature extraction and downstream modeling. Once identified, these ambiguous sequences will undergo a resolution procedure described below.

#figure(
  // The content of the figure (e.g., an image file or shape)
  image("../Figures/Aim_1.png", width: 100%),

  // The caption text
  caption: [*Workflow for peptide sequence curation and annotation expansion.*],
)

*1.3 Resolution of Unknown Amino acids.* Unknown amino acids will be resolved using a combination of sequence comparison, literature verification, and cluster-based inference. *The overall workflow of this process is illustrated in Figure 3.*
First, each ambiguous peptide sequence will be compared with entries in external peptide databases. Databases such as DBAASP @pirtskhalava2021dbaasp, APD3 @wang2016apd3, and DRAMP @shi2022dramp contain curated antimicrobial and bioactive peptide sequences. Sequence similarity searches will be performed using BLASTP. If a sequence match is found with high similarity and the corresponding residue is known, the unknown amino acid will be replaced. Sequence identity thresholds of approximately 95% or greater will be used to ensure reliable residue replacement.

Second, peptide sequences with associated publications will be verified through literature searches. UniProt records often include PubMed references that describe the peptide sequence. When a sequence is reported in the literature with a clearly defined amino acid at the ambiguous position, the residue will be updated accordingly. All such updates will include a reference to the supporting publication.

Third, UniRef cluster information will be used to infer residues when direct evidence is not available. UniRef clusters group similar sequences based on sequence identity. If a peptide belongs to a cluster in which most sequences share the same residue at the ambiguous position, the consensus amino acid can be inferred. Residue replacement will be performed when the cluster consensus exceeds approximately 80% agreement.

This multi-step resolution strategy allows ambiguous residues to be resolved using complementary sources of evidence.

*1.4 Functional Annotation Expansion.* Functional annotations in UniProt often include only a single reported activity, even though many peptides exhibit multiple biological functions. To address this limitation, functional labels will be expanded by integrating information from multiple databases and literature sources.
Each peptide will be assigned binary labels for different functional activities. Examples include antimicrobial, anticancer, antiviral, antifungal, immunomodulatory, hemolytic, and toxic activities. These annotations will be recorded as independent fields in the database so that peptides can be associated with multiple biological functions simultaneously. Functional labels will be collected from UniProt records, external peptide databases, and literature reports. When a functional activity is assigned to a peptide, the supporting reference will be stored in the database to ensure traceability. This approach allows the database to capture the multi-functional nature of many peptides.

*1.5 Database Structure and Query System.* A structured relational database will be constructed to organize the curated peptide data. The database will include several interconnected tables, including peptide sequences, functional annotations, literature references, and UniRef cluster information. This design will allow users to query the database using multiple criteria. For example, users will be able to search for peptides by sequence similarity, biological activity, or cluster membership. A simple search interface will be developed to allow researchers to input a peptide sequence and retrieve similar sequences and associated annotations.
The database will also support clustering-based queries. Because UniRef cluster identifiers will be retained for each peptide, researchers will be able to retrieve peptides belonging to the same cluster and examine their functional properties.

*1.6 Sample Size and Statistical Considerations.* *The curated dataset is expected to include approximately 50,000 to 100,000 peptide sequences collected from UniProt and related resources.* The success of the residue resolution pipeline will be evaluated by measuring the proportion of ambiguous residues that can be confidently resolved. Agreement between different resolution methods will also be assessed. Bootstrap sampling methods will be used to estimate confidence intervals for resolution accuracy and annotation consistency.

*Controls and Validation:* Positive control sequences with well-defined residues reported in literature will be used to verify that the pipeline correctly identifies and resolves ambiguous residues. In addition, negative control sequences containing artificially inserted unknown residues will be used to test whether the algorithm incorrectly assigns amino acids. Cross-database comparisons will also be performed to verify that resolved sequences match entries in external peptide databases. These validation steps will ensure that the curated dataset maintains high data integrity. 

*Expected Outcomes:* The expected outcome of this aim is a curated peptide dataset with improved sequence accuracy and expanded functional annotations. Some peptide sequences may remain unresolved if sufficient evidence is not available. In such cases, ambiguous residues will be retained but marked as uncertain. This information will be preserved so that machine learning models can incorporate uncertainty during training. If literature evidence is insufficient to resolve certain residues, additional sequence databases and mass spectrometry repositories will be explored. Expanding the search across multiple data sources will increase the likelihood of resolving ambiguous residues. Specifically, Aim 2 will evaluate how sequence ambiguity and incomplete annotations affect peptide function prediction. Machine learning models will be trained on both the original UniProt dataset and the curated dataset produced in Aim 1. Comparing these models will allow us to quantify how improved data quality affects prediction accuracy and confidence. 

*Summary of Specific Aim 1:* In Aim 1, we will create a curated peptide database by resolving unknown amino acids (X residues) and expanding incomplete functional annotations in UniProt peptide sequences. We will use external peptide databases, literature verification, and UniRef cluster consensus to identify the correct amino acids and confirm peptide functions. Multiple biological activities will be recorded for each peptide with supporting references to improve data reliability.


=== Specific Aim 2: Quantify and model the impact of missing and ambiguous peptide information on function prediction

_#underline[*_Rationale:_*]_ Artificial intelligence models depend on accurate sequence information and complete functional annotations. However, *peptide databases often contain unknown amino acids marked as X* and *incomplete activity labels*. These issues reduce prediction accuracy and reduce model confidence. The effect of these problems has not been measured carefully. In Specific Aim 1, we will create a structured peptide database with resolved amino acids and expanded functional annotations.* In Specific Aim 2, we will measure how ambiguity affects prediction performance and develop computational strategies that improve prediction reliability when information is incomplete.* Our hypothesis is that resolving ambiguous amino acids and expanding annotations will improve prediction accuracy, calibration, and stability of peptide function prediction models.

_#underline[*_Overall Study Design and Workflow:_*]_ In this aim, we will construct peptide datasets with different levels of sequence ambiguity and annotation completeness. We will train machine learning models on these datasets and compare prediction performance across conditions. We will also test uncertainty-aware prediction methods to improve reliability when sequence information is incomplete.

A schematic overview of the workflow is shown in Figure 4. The diagram illustrates how peptide sequences are collected, processed into datasets with controlled ambiguity levels, encoded into machine learning features, and evaluated using multiple prediction models and uncertainty analysis methods. This workflow allows us to directly measure how sequence ambiguity affects prediction accuracy and confidence.

#figure(
  // The content of the figure (e.g., an image file or shape)
  image("../Figures/Aim_2.png", width: 100%),

  // The caption text
  caption: [*Experimental workflow for evaluating the impact of ambiguous amino acids and incomplete annotations on peptide function prediction.*],
)

The workflow shows dataset preparation from UniProt and external peptide resources, construction of datasets with controlled ambiguity levels, feature encoding, machine learning training, uncertainty estimation, and performance comparison across datasets.

*2.1 Dataset Construction and Ambiguity Modeling.* We will construct several peptide datasets that represent different levels of sequence completeness and annotation quality. These datasets will be derived from UniProt peptide entries and from external peptide databases such as DBAASP and UniRef clusters. Dataset A will contain original peptide sequences from UniProt with unknown amino acids and incomplete annotations. Dataset B will contain partially resolved sequences in which some ambiguous amino acids are replaced using literature-supported evidence. Dataset C will contain curated peptide sequences generated using the resolution workflow developed in Aim 1 and supplemented with additional peptide sequences from external validated resources to ensure that modeling experiments remain feasible independent of Aim 1 outcomes.

In addition to datasets derived from UniProt and curated peptide resources, we will generate simulated ambiguity datasets to measure how increasing levels of missing sequence information affect prediction performance. In these datasets, five percent, ten percent, and twenty percent of amino acids will be randomly replaced with X to create controlled sequence ambiguity conditions. These datasets correspond to Dataset D, Dataset E, and Dataset F described in Table 1. Similarly, we will simulate incomplete annotation conditions by masking ten percent, twenty-five percent, and fifty percent of functional labels. These datasets correspond to Dataset G, Dataset H, and Dataset I. These controlled datasets allow us to systematically evaluate how missing sequence information and missing annotations influence prediction accuracy and model confidence. Datasets D through I are generated by introducing controlled levels of sequence ambiguity and annotation masking into Dataset C, which serves as the high-quality reference dataset. These simulated datasets allow systematic evaluation of how prediction performance changes as information completeness decreases.

The dataset conditions used in this aim are summarized in Table 1, which defines the sequence status, annotation completeness level, and experimental purpose for each dataset configuration used in performance evaluation.

#align(center)[
   *Table 2: Dataset configurations used to evaluate the impact of sequence ambiguity and annotation completeness on prediction performance*
#table(
  columns: 4,
  [*Dataset Name*], [*Sequence Status*], [*Annotation Status*], [*Experimental Role*],
  [Dataset A], [Original UniProt sequences], [Incomplete annotations], [Baseline comparison],
    [Dataset B], [Partially resolved sequences], [Expanded annotations where available], [Intermediate ambiguity level],
    [Dataset C], [Curated sequences from Aim 1 and external peptide resources], [Multi-label structured annotations], [Primary evaluation dataset],
    [Dataset D], [5% simulated X substitutions], [Complete annotations], [Sensitivity analysis],
    [Dataset E], [10% simulated X substitutions], [Complete annotations], [Moderate ambiguity test],
    [Dataset F], [20% simulated X substitutions], [Complete annotations], [High ambiguity test],
    [Dataset G], [Resolved sequences], [10% masked annotations], [Annotation loss simulation],
    [Dataset H], [Resolved sequences], [25% masked annotations], [Moderate annotation loss test],
    [Dataset I], [Resolved sequences], [50% masked annotations], [Severe annotation loss test],
)
]
*2.2 Feature Extraction and Sequence Encoding.* Each peptide sequence will be converted into numerical features before model training. We will use one-hot encoding to represent amino acid identity at each sequence position. We will also compute physicochemical descriptors such as hydrophobicity, charge, polarity, and molecular weight. In addition, we will extract contextual embeddings using pretrained protein language models. These complementary feature representations will allow us to evaluate how sequence ambiguity affects both simple and advanced encoding strategies.

Ambiguous amino acids marked as X will be handled using multiple encoding strategies. In some experiments, these positions will be ignored. In other experiments, they will be replaced with averaged amino acid representations. In additional experiments, they will be represented using learned embeddings that capture uncertainty information. This comparison will help determine which encoding strategy produces the most reliable predictions under ambiguous conditions.

*2.3 Machine learning Model Development.* We will train several machine learning models for peptide function prediction. Classical machine learning models will include Random Forest, Support Vector Machine, and Gradient Boosting classifiers. Deep learning models will include multilayer perceptron networks, convolutional neural networks for sequence data, and transformer-based classifiers using pretrained embeddings. These models will be implemented using Python libraries including PyTorch and scikit-learn.

All models will be trained using identical preprocessing pipelines and identical dataset splits to ensure fair comparison across datasets with different ambiguity levels.

*2.4 Training Procedure and Sample Size Justification.* We expect to analyze approximately three thousand to five thousand peptide sequences collected from UniProt and external peptide databases. *Approximately 1000-3000 sequences* will include resolved amino acids generated using the workflow developed in Aim 1 and complementary external resources.

Each dataset will be divided into training, validation, and testing subsets using stratified sampling. *70% of the data will be used for training, 15% for validation, and 15% for testing. We will also perform 5 folds cross-validation using fixed random seeds to ensure reproducibility.*

*2.5 Uncertainty-aware Prediction Framework.* Prediction confidence is important when sequence information is incomplete. To address this issue, we will implement uncertainty-aware prediction methods that estimate confidence during model inference. Monte Carlo dropout sampling will be used to estimate prediction variance across multiple forward passes. Ensemble neural networks will also be trained using independent model initializations. Temperature scaling will be applied to improve calibration of prediction probabilities.

These approaches will allow us to determine whether curated peptide sequences produce more reliable predictions compared with ambiguous sequences.

*2.6 Statistical Analysis and Evaluation Metrics.* Model performance will be evaluated using several complementary metrics including *AUROC (Area Under the Receiver Operating Characteristic curve), Accuracy, Precision, Recall, and F1 score*. Prediction confidence will be evaluated using calibration error and entropy-based uncertainty measurements. 

Statistical comparisons between datasets will be performed using paired t-tests and bootstrap confidence interval estimation with one thousand resampling iterations. These analyses will determine whether improvements in prediction performance after sequence resolution are statistically significant.

*Controls and Reproducibility Strategy:* To ensure valid comparisons, all experiments will use identical training pipelines and identical dataset splits across ambiguity conditions. The original UniProt dataset will serve as a baseline reference condition. Simulated ambiguity datasets will serve as controlled experimental benchmarks for evaluating the effect of missing amino acids and missing annotations. Random seed initialization will remain fixed across all experiments to ensure reproducibility of model training results.

*Expected outcomes:* If our hypothesis is correct, models trained on curated peptide sequences will show higher AUROC values, improved calibration reliability, and lower prediction uncertainty compared with models trained on ambiguous datasets. These improvements will confirm that resolving unknown amino acids and expanding annotations increases prediction reliability.

If prediction performance does not improve significantly after ambiguity resolution, this outcome would suggest that additional biological features such as structural descriptors or evolutionary conservation information may be required for reliable peptide function prediction. This result would still provide important insight into the limitations of sequence-only prediction models.

*Summary of Aim 2:* In Specific Aim 2, we will study how missing amino acids and incomplete functional annotations affect peptide function prediction using machine learning models. We will create datasets with different levels of sequence ambiguity and annotation completeness and compare prediction performance across these conditions. We will also apply uncertainty-aware prediction methods to measure how confidence changes when information is incomplete. This aim will show how improving sequence quality and annotation completeness increases the accuracy and reliability of AI-based peptide function prediction.



