= Specific Aims
#set par(justify: true)
Protein sequence databases are essential for biological and biomedical research.
*UniProt* is one of the most widely used resources for protein and peptide data.
It provides sequences, limited functional annotations, and references to literature.
*However, many peptide sequences contain unknown amino acids marked as X.* The identity of these amino acids is often not specified. Functional annotations are frequently incomplete or listed as a single activity. Supporting literature sources are not always clearly linked. These issues reduce data reliability. They limit the use of UniProt in machine learning and deep learning studies. *There is a critical need for a structured and enriched peptide database with resolved amino acids and comprehensive functional annotations.*

#set par(justify: true)
Our long term goal of this work is to enable reliable peptide function prediction using artificial intelligence. 
The objective of this proposal is to resolve ambiguous amino acids and incomplete functional annotations in peptide sequences. *Proteins are composed of 20 standard amino acids. In UniProt, non standard or modified amino acids are frequently represented as X.* This obscures the true sequence composition. Functional annotations are often incomplete or limited to a single activity. Links to supporting literature are inconsistently provided. The rationale for this project is that data ambiguity reduces the accuracy of computational models. *The central hypothesis is that resolving unknown amino acids and expanding functional labels will improve prediction performance.* The expected outcome is a curated peptide resource optimized for machine learning. The payoff is improved peptide discovery and functional screening.

*#underline[Specific Aim 1:]* *Resolve unknown amino acids and expand functional annotations* \
Peptide sequences with unknown amino acids can be resolved using external resources and learned patterns. \
We will implement Python workflows to extract peptide level data from UniProt. Sequences containing X will be identified and separated. We will cross check sequences with external databases and literature. Resolved amino acids will be added when evidence exists. Multiple functional activities will be recorded as separate fields. Each annotation will include a reference source. Sequences will retain their UniRef cluster identifiers.
We will design the database to support queries by cluster membership. Functional annotations will be linked to each cluster. This will enable access to peptide sequences by both cluster and activity. We will develop a search engine for peptide sequence input.\
A structured table with resolved amino acids and multi activity annotations.

// *#underline[Specific Aim 2:]* *Compute peptide features and predict functionality* \
// Structured features enable accurate prediction of peptide function. \
// We will derive physicochemical properties not explicitly provided in UniProt.
// These will include hydrophobicity, aromaticity, aliphatic index, net charge, and additional sequence derived properties.
// Sequence length and molecular weight from UniProt will be retained.
// All features will be stored in structured CSV or Excel formats.
// We will train machine learning models using curated UniProt peptide data.
// Models will include random forest, support vector machines, and neural networks.
// We will develop a search engine for peptide sequence input.
// New peptide sequences will be evaluated using trained models.Predicted functions will include anticancer, antiviral, toxic activities, and other biologically relevant activities.
// Confidence scores will be reported for each prediction.\
// A searchable feature rich peptide database with prediction capability.

*#underline[Specific Aim 2:]* *Quantify and model the impact of missing and ambiguous peptide information on function prediction*\
/*Missing or ambiguous information in peptide databases creates uncertainty in computational analysis. However, its effect on prediction performance is not well understood.*/In this aim, we will study how incomplete sequence information and missing functional annotations affect peptide function prediction.\
We will create datasets with different levels of ambiguity, including sequences with unknown amino acids (X), incomplete annotations, and missing metadata. We will train and evaluate machine learning models on these datasets to measure how ambiguity affects prediction accuracy and confidence. We will also develop methods to handle uncertainty, such as ambiguity-aware feature encoding and confidence-based scoring. Model performance will be compared across datasets with different levels of ambiguity. Improvement will be measured by improved stability, calibration, and accuracy under ambiguous conditions.\ 
This aim will provide a clear understanding of how missing peptide information affects AI predictions and will produce a computational framework that improves prediction reliability when data are incomplete.

This project will produce a curated and structured peptide database. It will improve data usability for AI models. The approach integrates data curation with machine learning. The resource will reduce the need to search multiple databases. The database will be extensible as new data become available.

