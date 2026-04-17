#!/usr/bin/env python3

import os
import sqlite3
import numpy as np
import pandas as pd
from scipy.stats import ttest_ind

INPUT_DB = "/content/uniprot_sequences_with_X.db"
TABLE_NAME = "sequences_with_x"

OUTPUT_DIR = "output"
OUTPUT_DF_CSV = os.path.join(OUTPUT_DIR, "uniprot_x_analysis_dataframe.csv")
OUTPUT_STATS_TXT = os.path.join(OUTPUT_DIR, "uniprot_x_analysis_stats.txt")


def count_x(seq: str) -> int:
    if not isinstance(seq, str):
        return 0
    return seq.upper().count("X")


def main() -> None:
    if not os.path.exists(INPUT_DB):
        raise FileNotFoundError(f"Database not found: {INPUT_DB}")

    with sqlite3.connect(INPUT_DB) as conn:
        df = pd.read_sql_query(f"SELECT * FROM {TABLE_NAME}", conn)

    # Feature engineering: dataframe ready to plot
    df["x_count"] = df["sequence"].apply(count_x)
    df["x_fraction"] = df["x_count"] / df["length"]
    df["activity_text_len"] = df["functional_activity"].fillna("").str.len()
    df["has_activity_text"] = (df["activity_text_len"] > 0).astype(int)
    df["log_length"] = np.log10(df["length"])
    df["x_group"] = np.where(df["x_count"] == 1, "single_X", "multiple_X")

    plot_df = df[
        [
            "Entry",
            "sequence_name",
            "length",
            "log_length",
            "x_count",
            "x_fraction",
            "activity_text_len",
            "has_activity_text",
            "x_group",
        ]
    ].copy()

    # Statistical tests
    single_len = plot_df.loc[plot_df["x_group"] == "single_X", "length"]
    multi_len = plot_df.loc[plot_df["x_group"] == "multiple_X", "length"]

    single_frac = plot_df.loc[plot_df["x_group"] == "single_X", "x_fraction"]
    multi_frac = plot_df.loc[plot_df["x_group"] == "multiple_X", "x_fraction"]

    t_len, p_len = ttest_ind(single_len, multi_len, equal_var=False, nan_policy="omit")
    t_frac, p_frac = ttest_ind(single_frac, multi_frac, equal_var=False, nan_policy="omit")

    # Save outputs
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    plot_df.to_csv(OUTPUT_DF_CSV, index=False)

    with open(OUTPUT_STATS_TXT, "w", encoding="utf-8") as f:
        f.write("UniProt X-sequence statistical analysis\n")
        f.write("=====================================\n\n")
        f.write(f"Total rows analyzed: {len(plot_df)}\n")
        f.write(f"Single-X rows: {(plot_df['x_group'] == 'single_X').sum()}\n")
        f.write(f"Multiple-X rows: {(plot_df['x_group'] == 'multiple_X').sum()}\n\n")

        f.write("Welch t-test: sequence length by x_group\n")
        f.write(f"t-statistic = {t_len:.4f}\n")
        f.write(f"p-value     = {p_len:.4e}\n\n")

        f.write("Welch t-test: x_fraction by x_group\n")
        f.write(f"t-statistic = {t_frac:.4f}\n")
        f.write(f"p-value     = {p_frac:.4e}\n")

    # Print for grading
    print("Statistical test results")
    print("========================")
    print(f"Length comparison (single_X vs multiple_X): t={t_len:.4f}, p={p_len:.4e}")
    print(f"X-fraction comparison (single_X vs multiple_X): t={t_frac:.4f}, p={p_frac:.4e}")

    print("\nDataframe ready to plot:")
    print(plot_df.head(20).to_string(index=False))

    print(f"\n[Saved] Dataframe CSV -> {OUTPUT_DF_CSV}")
    print(f"[Saved] Stats text    -> {OUTPUT_STATS_TXT}")


if __name__ == "__main__":
    main()
