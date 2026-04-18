# Makefile -- Build logic for UniProt database project
# Runs inside the container (podman compose run builder make <target>)
# or directly if python3 and required packages are installed locally.

# Makefile -- Build logic for UniProt database project

PYTHON     := python3
SCRIPT     := scripts/build_uniprot_db.py
ANALYSIS_SCRIPT := scripts/analyze_uniprot_x.py

OUTPUT_DIR := output

DB_ALL     := $(OUTPUT_DIR)/uniprot_all_sequences.db
DB_X       := $(OUTPUT_DIR)/uniprot_sequences_with_X.db

ANALYSIS_DF    := $(OUTPUT_DIR)/uniprot_x_analysis_dataframe.csv
ANALYSIS_STATS := $(OUTPUT_DIR)/uniprot_x_analysis_stats.txt


# ── Targets ──────────────────────────────────────────

.PHONY: all run analysis clean

all: run

run: $(DB_ALL) $(DB_X) $(ANALYSIS_DF) $(ANALYSIS_STATS)
analysis: $(ANALYSIS_DF) $(ANALYSIS_STATS)


# ── Rules ────────────────────────────────────────────

$(DB_ALL) $(DB_X): $(SCRIPT) | $(OUTPUT_DIR)
	$(PYTHON) $(SCRIPT)


$(ANALYSIS_DF) $(ANALYSIS_STATS): $(ANALYSIS_SCRIPT) $(DB_X)
	$(PYTHON) $(ANALYSIS_SCRIPT)


$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)


clean:
	rm -rf $(OUTPUT_DIR)
