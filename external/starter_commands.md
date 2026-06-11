# Starter Commands

These commands are templates only. Fill in sample sheets, database paths, and container profile before running.

## nf-core/taxprofiler

```bash
nextflow run nf-core/taxprofiler \
  --input samplesheet.csv \
  --databases database.csv \
  --outdir results_taxprofiler \
  --run_kraken2 --run_bracken --run_metaphlan \
  -profile docker
```

## HUMAnN

```bash
humann \
  --input sample_R1_R2_merged.fastq.gz \
  --output humann_out \
  --threads 8
```

## nf-core/mag

```bash
nextflow run nf-core/mag \
  --input samplesheet.csv \
  --outdir results_mag \
  -profile docker
```

## nf-core/rnaseq

```bash
nextflow run nf-core/rnaseq \
  --input samplesheet.csv \
  --outdir results_rnaseq \
  --genome GRCg7b \
  -profile docker
```

## OlinkAnalyze

```r
install.packages("OlinkAnalyze")
library(OlinkAnalyze)

npx <- read_NPX("olink_npx_export.csv")
qc_plot <- olink_qc_plot(npx)
```

## MSstats

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("MSstats")
library(MSstats)
```

