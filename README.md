# EMA6096_Reproducible_Workflow

This course-based project demonstrates the concept of reproducibility by automatically generating SQLite databases from UniProt protein sequence data using an Ubuntu-based containerized workflow.

>'''
Ubuntu Version: 24.04.3 LTS
>'''

> [!TIP]
> Check your ubuntu version:  **cat /etc/os-release**


-----------------------

## How to Access This Database for Reproducibility
**No worries 😊 Here are the setup instructions:**

> [!Note]
> Write the below steps from your terminal command. You have to change some command or installation file according to your operating system. 

**Step 1: Clone the repository** \
git clone https://github.com/MalishaIslam/EMA6096_Reproducible_Workflow 

**Step 2: Enter project directory** \
cd EMA6096_Reproducible_Workflow 

**Step 3: Build container image** \
podman compose build           [first time we need this to build the container image]

> [!Note]
> For Step 3, if require, install "sudo apt install podman-compose" 

**Step 4: Run workflow** \
just \
This command rebuilds the database from scratch using UniProt API.


**Database Creation Process**

- downloads UniProt records 
- processes approximately 115 pages
- scans ~57,442 sequences
- extracts sequences containing unknown amino acid X/x
- creates SQLite databases
>'''
Estimated Runtime: 4-5 minutes
>'''

**Database Summary**

<img width="975" height="233" alt="image" src="https://github.com/user-attachments/assets/7ea2f09b-2d68-419d-a6c1-0e80658b84dd" />

> [!TIP]
> To check the contents of a directory: use 'ls' command
> ls output/

**Viewing Database**

> [!TIP]
> To view the database, install 'sudo apt install sqlitebrowser' \
> sqlitebrowser output/uniprot_sequences_with_X.db

<img width="975" height="573" alt="image" src="https://github.com/user-attachments/assets/3648f5d5-aaa2-455f-b409-2cd68d4ba48e" />

