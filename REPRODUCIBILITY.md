# Reproducibility Notes

This repository is a compact research-methods and code index for microbiome, shotgun metagenomics, transcriptomics, and proteomics workflows. It is designed to be safe for GitHub sharing and to point future analyses toward reproducible public pipelines.

## Intended Reproduction Level

This repository supports:

1. Reuse of lightweight local scripts and notes.
2. Rebuilding project-specific methods sections from documented workflow choices.
3. Starting new reproducible analyses using official public pipelines and starter commands.

It is not a raw-data repository.

## What Was Included

- Local microbiome code and QIIME2/PICRUSt2 notes.
- Public-facing insect omics planning notes and lightweight code.
- Inventory of GC Shotgun small files rather than raw data copy.
- Official resource list for shotgun metagenomics, transcriptomics, and proteomics.
- Starter commands for common reproducible workflows.

## What Was Excluded

- Raw omics data.
- Private sample-level information.
- Patient-level or personally identifying data.
- Vendor report bundles and large generated HTML folders.
- PDF papers, PowerPoint decks, and Word drafts.
- Tokens and credential-like notes.

## Recommended Reproducible Workflow Families

### Shotgun metagenomics

Use these when the goal is taxonomic and functional profiling of shotgun microbiome data:

- `nf-core/taxprofiler` for QC, host removal, taxonomic classification, and standardized outputs.
- HUMAnN for microbial pathway and gene-family functional profiling.
- `nf-core/mag` when assembly, binning, and MAG annotation are central.

### 16S microbiome

Use QIIME2 as the primary reproducible workflow:

1. Import FASTQ and metadata.
2. Denoise with DADA2.
3. Build feature table and representative sequences.
4. Assign taxonomy.
5. Export BIOM/TSV tables for R/Python downstream analysis.
6. Use PICRUSt2 only as predicted functional inference, not direct metagenomic measurement.

### RNA-seq / transcriptomics

Use `nf-core/rnaseq` where possible for a clean future rerun:

1. Prepare samplesheet.
2. Use a fixed reference genome and annotation release.
3. Run QC, trimming, alignment/pseudoalignment, quantification, and MultiQC.
4. Analyze counts with DESeq2, edgeR, or limma-voom depending on design.
5. Archive sample sheet, parameters, software versions, and count matrix.

### Proteomics

For LC-MS/MS:

1. Use FragPipe/MSFragger or MaxQuant for identification and quantification.
2. Use MSstats for statistical comparison of peptide/protein abundances.
3. Archive raw files separately in PRIDE or another proteomics repository when publishing.

For Olink:

1. Use OlinkAnalyze for NPX import, QC, statistics, and visualization.
2. Keep NPX export, sample manifest, bridge/normalization settings, and QC status under controlled access if private.

## Minimum Metadata To Preserve

For each project, preserve:

- Sample IDs and treatment groups.
- Batch, plate, run, lane, or extraction metadata where relevant.
- Reference database versions.
- Pipeline version and command-line parameters.
- Software/package versions.
- Raw-data archive accession or controlled-access location.
- Final derived tables used for figures and statistical claims.

