# Makefile -- Build logic for UniProt database project
# Runs inside the container (podman compose run builder make <target>)
# or directly if python3 and required packages are installed locally.

# Makefile -- Build logic for UniProt database project

PYTHON     := python3
SCRIPT     := scripts/build_uniprot_db.py
ANALYSIS_SCRIPT := scripts/analyze_uniprot_x.py
FIG_SCRIPT := scripts/preliminary_figures.py
REPORT_SRC := report/graphical_abstract.typ


OUTPUT_DIR := output
FIG_DIR := $(OUTPUT_DIR)/figures

DB_ALL     := $(OUTPUT_DIR)/uniprot_all_sequences.db
DB_X       := $(OUTPUT_DIR)/uniprot_sequences_with_X.db

ANALYSIS_DF    := $(OUTPUT_DIR)/uniprot_x_analysis_dataframe.csv
ANALYSIS_STATS := $(OUTPUT_DIR)/uniprot_x_analysis_stats.txt

FIG_1 := $(FIG_DIR)/fig_x_fraction_by_group.png
FIG_2 := $(FIG_DIR)/fig_length_vs_x_count.png
FIG_3 := $(FIG_DIR)/fig_umap_sequence_projection.png

grph_abs_PDF := $(OUTPUT_DIR)/graphical_abstract.pdf

# ── Targets ──────────────────────────────────────────

.PHONY: all run db_prep analysis figures graph_abstract clean

all: run

run: $(DB_ALL) $(DB_X) $(ANALYSIS_DF) $(ANALYSIS_STATS) $(FIG_1) $(FIG_2) $(FIG_3) $(grph_abs_PDF)
db_prep: $(DB_ALL) $(DB_X)
analysis: $(ANALYSIS_DF) $(ANALYSIS_STATS)
figures: $(FIG_1) $(FIG_2) $(FIG_3)
graph_abstract: $(grph_abs_PDF)

# ── Rules ────────────────────────────────────────────

$(DB_ALL) $(DB_X): $(SCRIPT) | $(OUTPUT_DIR)
	$(PYTHON) $(SCRIPT)

$(ANALYSIS_DF) $(ANALYSIS_STATS): $(ANALYSIS_SCRIPT) $(DB_X)
	$(PYTHON) $(ANALYSIS_SCRIPT)

$(FIG_1) $(FIG_2) $(FIG_3): $(FIG_SCRIPT) $(ANALYSIS_DF)
	$(PYTHON) $(FIG_SCRIPT)

$(grph_abs_PDF): $(REPORT_SRC) | $(OUTPUT_DIR)
	typst compile $(REPORT_SRC) $(grph_abs_PDF)


$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)


clean:
	rm -rf $(OUTPUT_DIR)
