#!/usr/bin/env python3

import os
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import umap

from sklearn.feature_extraction.text import CountVectorizer


INPUT_CSV = "output/uniprot_x_analysis_dataframe.csv"
FIG_DIR = "output/figures"

FIG_BOXPLOT = os.path.join(FIG_DIR, "fig_x_fraction_by_group.png")
FIG_SCATTER = os.path.join(FIG_DIR, "fig_length_vs_x_count.png")
FIG_UMAP = os.path.join(FIG_DIR, "fig_umap_sequence_projection.png")


def main():
    if not os.path.exists(INPUT_CSV):
        raise FileNotFoundError(f"Dataframe not found: {INPUT_CSV}")

    os.makedirs(FIG_DIR, exist_ok=True)

    df = pd.read_csv(INPUT_CSV)

    sns.set_theme(style="whitegrid", context="talk")

    # --------------------------------------------------
    # Figure 1: X residue fraction by sequence group
    # --------------------------------------------------
    
    # plt.figure(figsize=(9, 6))

    # sns.boxplot(
    #     data=df,
    #     x="x_group",
    #     y="x_fraction"
    # )

    # sns.stripplot(
    #     data=df,
    #     x="x_group",
    #     y="x_fraction",
    #     color="black",
    #     alpha=0.45,
    #     size=5
    # )

    # plt.title("Unknown Residue Fraction by Sequence Group")
    # plt.xlabel("Sequence Group")
    # plt.ylabel("Fraction of Unknown Residues (X)")
    # plt.tight_layout()
    # plt.savefig(FIG_BOXPLOT, dpi=1200, bbox_inches="tight")
    # plt.close()

    plt.figure(figsize=(9, 6))

    sns.violinplot(
        data=df,
        x="x_group",
        y="x_fraction",
        inner="box",
        cut=0
    )

    plt.yscale("log")
    plt.title("Distribution of Unknown Residue Fraction")
    plt.xlabel("Sequence Group")
    plt.ylabel("Fraction of Unknown Residues (log scale)")
    plt.tight_layout()
    plt.savefig(FIG_BOXPLOT, dpi=1200, bbox_inches="tight")
    plt.close()

    # --------------------------------------------------
    # Figure 2: Sequence length vs X count
    # --------------------------------------------------
    plt.figure(figsize=(9, 6))

    sns.scatterplot(
        data=df,
        x="length",
        y="x_count",
        hue="x_group",
        s=80,
        alpha=0.8
    )

    plt.title("Sequence Length vs Unknown Residue Count")
    plt.xlabel("Protein Sequence Length")
    plt.ylabel("Number of Unknown Residues (X)")
    plt.legend(title="Sequence Group")
    plt.tight_layout()
    plt.savefig(FIG_SCATTER, dpi=1200, bbox_inches="tight")
    plt.close()

    # --------------------------------------------------
    # Figure 3: UMAP projection of protein sequences
    # --------------------------------------------------
    # Convert protein sequences into character n-gram features.
    # This allows UMAP to project sequence-level similarity into 2D.
    vectorizer = CountVectorizer(
        analyzer="char",
        ngram_range=(1, 2)
    )

    X = vectorizer.fit_transform(df["sequence"].astype(str))

    reducer = umap.UMAP(
        n_neighbors=10,
        min_dist=0.2,
        metric="cosine",
        random_state=42
    )

    embedding = reducer.fit_transform(X)

    df["UMAP_0"] = embedding[:, 0]
    df["UMAP_1"] = embedding[:, 1]

    plt.figure(figsize=(9, 7))

    sns.scatterplot(
        data=df,
        x="UMAP_0",
        y="UMAP_1",
        hue="x_group",
        size="x_count",
        sizes=(40, 180),
        alpha=0.8
    )

    plt.title("UMAP Projection of UniProt Protein Sequences Highlighting Distribution of Unknown Residues (X)")
    plt.xlabel("UMAP Dimension 1")
    plt.ylabel("UMAP Dimension 2")
    plt.legend(title="Sequence Group / X Count", bbox_to_anchor=(1.05, 1), loc="upper left")
    plt.tight_layout()
    plt.savefig(FIG_UMAP, dpi=1200, bbox_inches="tight")
    plt.close()

    print("[Saved] Preliminary figures:")
    print(f" - {FIG_BOXPLOT}")
    print(f" - {FIG_SCATTER}")
    print(f" - {FIG_UMAP}")


if __name__ == "__main__":
    main()
