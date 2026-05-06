#set par(justify: true)
*Data Source and Retrieval Methodology*

The main data source for this project is the UniProt peptide database. UniProt provides peptide sequences, functional annotations, sequence identifiers, and references to scientific publications. However, some peptide sequences contain unknown amino acids marked as X, and some functional annotations are incomplete. Therefore, additional peptide information will be collected from external peptide databases such as DBAASP, APD3, DRAMP, and UniRef clusters to improve data quality. These resources provide validated peptide sequences and biological activity labels such as antimicrobial, anticancer, antiviral, and antifungal activities.

Scientific literature information will also be collected from PubMed using FTP downloads. PubMed XML files (xml.gz) will be processed using stream processing methods so that large datasets can be handled efficiently without high memory usage.

Data retrieval will be performed using: UniProt REST API, UniProt bulk downloads, PubMed FTP XML files, and External peptide database downloads.

The retrieval pipeline will be implemented using Python scripts to automatically collect and organize peptide data.


*Retrieval Protocols, File Types, and Pipeline Design*

Data retrieval will follow an automated pipeline that downloads raw peptide data and converts it into structured tables.

The main file types used in the pipeline include: XML (xml.gz) files from PubMed FTP, FASTA files from UniProt, JSON files from REST API responses,and
TSV tables from peptide databases.

The system will follow these steps:

#underline[Step 1:] Download peptide sequence data from UniProt using REST API \
#underline[Step 2:] Download supporting literature metadata from PubMed FTP \
#underline[Step 3:] Retrieve functional annotations from external peptide databases \
#underline[Step 4:] Parse all files into structured tables \
#underline[Step 5:] Store processed data in parquet format for efficient analysis

Stream processing will be used for PubMed XML files. This allows the system to read one record at a time instead of loading the entire file into memory.

*Structure of Raw Data*

The raw dataset will contain peptide information collected from multiple databases. The raw data fields include: UniProt accession ID, Amino Acid Sequence, Sequence Length, Functional Annotations, Literature References,
UniRef Cluster ID, Ambiguity Flag (presence of X residues).

Raw data formats include: XML, FASTA, JSON, TSV.

These formats come directly from the original databases without modification.

*Structure of Processed Data*

After preprocessing, the dataset will be stored in structured relational tables using parquet format. This format is a column-based file storage format that stores structured table data efficiently with smaller file size and faster reading speed. 

#underline[Peptide Table Schema:]  \
CREATE TABLE Peptide ( \
  UniProt ID TEXT PRIMARY KEY, \
  Sequence TEXT, \
  Sequenve Length INTEGER, \
  UniRef cluster ID TEXT, \
  Ambiguity flag BOOLEAN
);

#align(center)[
#table(
  columns: 2,
  [*Field*], [*Description*],
  [UniProt ID], [Unique Peptide Identifier],
  [Sequence], [Amino Acid Sequence],
  [Sequenve Length], [Number of residues],
  [UniRef cluster ID], [Sequence similarity cluster],
  [Ambiguity flag], [Presence of unknown residues],
)
*Table 1: Peptide Table.*
]
#underline[Annotation Table Schema:]  \
CREATE TABLE Annotation ( \
  UniProt ID TEXT, \
  Antimicrobial BOOLEAN, \
  Anticancer BOOLEAN, \
  Antiviral BOOLEAN, \
  Antifungal BOOLEAN,
  Toxicity BOOLEAN, \
  PRIMARY KEY (uniprot_id), FOREIGN KEY (uniprot_id) REFERENCES peptide(uniprot_id)
);

#align(center)[
#table(
  columns: 2,
  [*Field*], [*Description*],
  [UniProt ID], [Unique Peptide Identifier],
  [Antimicrobial], [Binary label],
  [Anticancer], [Binary label],
  [Antiviral], [Binary label],
  [Antifungal], [Binary label],
  [Toxicity], [Binary label],
)
*Table 2: Annotation Table.*
]
#underline[Literature Table Schema:]  \
CREATE TABLE Literature ( \
  pmid TEXT PRIMARY KEY, \
  UniProt ID TEXT, \
  Title TEXT, \
  Abstract TEXT, \
  Year INTEGER, \
  journal TEXT, \
  FOREIGN KEY (uniprot_id) REFERENCES peptide(uniprot_id)
);

#align(center)[
#table(
  columns: 2,
  [*Field*], [*Description*],
  [pmid], [40024691],
  [Title], [Colistin Resistance in Acinetobacter baumannii: Basic and Clinical Insights],
  [Abstract], [Relationship between 2 colistin resistance mechanisms in terms of the frequency and fitness of genetic mutations based on the insights from basic studies and clinical settings],
  [Year], [2025],
)
*Table 2: Literature Table.*
]

This structure allows fast querying and easy integration with machine learning pipelines.

*Processing and Parsing Methods*

The processing pipeline will clean and organize peptide sequences after retrieval.

First, all peptide sequences will be scanned to detect unknown amino acids marked as X. The position of each unknown residue will be recorded in the dataset.

Second, ambiguous residues will be resolved using: sequence similarity search using BLASTP, literature verification using PubMed references, and
consensus residues from UniRef clusters. 

Third, functional annotations will be expanded by combining information from: UniProt, DBAASP, APD3, DRAMP, and scientific publications. 

Each peptide may have multiple biological activity labels. These labels will be stored separately in the annotation table. For literature data processing, stream processing will be used to read PubMed XML files from FTP servers. XML records will be parsed using the lxml Python library, and extracted metadata will be converted into structured parquet tables.

*Tools and Packages Used for Data Processing*

The database construction pipeline will use the following tools:

#underline[Programming Language:] Python

#underline[Data Retrieval:] requests (API access), UniProt REST API, PubMed FTP download

#underline[Sequence Processing:] Biopython

#underline[Parsing and Processing:] pandas, lxml (XML parsing), BLASTP (sequence similarity search)

#underline[Storage Format:] parquet tables

#underline[Machine Learning Preparation:] scikit-learn, PyTorch

These tools allow automated data retrieval, cleaning, parsing, validation, and structured storage of peptide sequences.

*Stream Processing for Memory Efficiency*

PubMed XML files can be very large. Therefore, the pipeline will use stream processing to read data step by step instead of loading the entire file at once.

The workflow is:

Step 1: Download PubMed XML files from FTP server \
Step 2: Decompress xml.gz files \
Step 3: Parse XML records using lxml \
Step 4: Extract article metadata \
Step 5: Convert records into parquet tables

This approach improves memory efficiency and allows processing of large-scale literature datasets.