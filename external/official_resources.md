# Official Omics Resources Collected

Collected on 2026-06-11. Links are mostly official project, lab, CRAN, or nf-core pages.

## Shotgun Metagenomics / Microbiome

### Taxonomic profiling

- nf-core/taxprofiler  
  https://nf-co.re/taxprofiler  
  Use for shotgun metagenomic taxonomic classification/profiling with multiple tools and standardized output tables.

- MetaPhlAn / bioBakery ecosystem  
  https://github.com/biobakery/MetaPhlAn  
  Marker-gene species-level profiling commonly paired with HUMAnN.

- Kraken2  
  https://ccb.jhu.edu/software/kraken2/  
  Fast k-mer taxonomic classification. Often paired with Bracken for abundance estimation.

- Bracken  
  https://ccb.jhu.edu/software/bracken/  
  Abundance re-estimation from Kraken classification output.

### Functional profiling

- HUMAnN  
  https://huttenhower.sph.harvard.edu/humann/  
  Functional profiling of microbial pathways and molecular functions from metagenomic or metatranscriptomic sequencing data.

- HUMAnN GitHub  
  https://github.com/biobakery/humann  
  Source code, user manual, and tutorial links.

### Assembly / MAG workflow

- nf-core/mag  
  https://nf-co.re/mag  
  Assembly, binning, and annotation of metagenomes.

## Transcriptomics

- nf-core/rnaseq  
  https://nf-co.re/rnaseq  
  Bulk RNA-seq workflow using STAR, RSEM, HISAT2, or Salmon, producing count/expression matrices and QC reports.

- DESeq2  
  https://bioconductor.org/packages/DESeq2/  
  Differential expression analysis for count data.

- edgeR  
  https://bioconductor.org/packages/edgeR/  
  Differential expression analysis for replicated count data.

- limma / voom  
  https://bioconductor.org/packages/limma/  
  Linear modeling framework often used for RNA-seq after voom transformation.

## Proteomics

### LC-MS/MS and shotgun proteomics

- FragPipe  
  https://fragpipe.nesvilab.org/  
  Complete computational platform for mass spectrometry-based proteomics with MSFragger.

- MSFragger  
  https://msfragger.nesvilab.org/  
  Peptide identification search engine used inside FragPipe.

- MaxQuant  
  https://maxquant.org/  
  Quantitative proteomics package for large high-resolution mass spectrometry datasets.

- quantms  
  https://quantms.org/  
  Open-source ecosystem for large-scale quantitative proteomics.

- nf-core/quantms  
  https://nf-co.re/quantms  
  Nextflow quantitative mass spectrometry workflow. Note: nf-core page currently marks the pipeline as archived, so prefer checking quantms.org and current GitHub status before new work.

### Olink / affinity proteomics

- OlinkAnalyze on CRAN  
  https://cran.r-project.org/package=OlinkAnalyze  
  R package for Olink NPX data import, QC, statistics, and visualization.

- OlinkAnalyze GitHub  
  https://github.com/Olink-Proteomics/OlinkRPackage

### Downstream statistics

- MSstats  
  https://msstats.org/  
  R/Bioconductor family for statistical relative quantification of peptides and proteins.

- Vitek Lab software overview  
  https://olga-vitek-lab.khoury.northeastern.edu/software/

## Suggested Workflow Choices

For shotgun microbiome:

1. Start with `nf-core/taxprofiler` for standardized QC, host removal, and taxonomic profiles.
2. Add `HUMAnN` for pathway and gene-family functional profiling.
3. Use `nf-core/mag` when assembly, binning, and MAG annotation are central goals.

For transcriptome:

1. Use `nf-core/rnaseq` for reproducible upstream processing.
2. Use DESeq2 / edgeR / limma-voom for downstream contrasts depending on design and sample size.

For proteome:

1. Use FragPipe/MSFragger or MaxQuant for raw LC-MS/MS identification and quantification.
2. Use MSstats for statistical modeling and group comparisons.
3. Use OlinkAnalyze for Olink NPX workflows.

