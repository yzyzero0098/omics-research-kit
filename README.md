# Omics Research Kit

Curated local notes, scripts, and public resource links for microbiome, shotgun metagenomics, transcriptomics, and proteomics work.

This is a GitHub-ready research index. It intentionally excludes private raw data, patient/sample-level raw files, PDFs, PowerPoint decks, Word drafts, databases, and large binary outputs.

## What Is Included

```text
local/microbiome/
  Reusable local microbiome scripts and pipeline notes from __code/microbiome.

local/insect_omics/
  Public-facing markdown notes and lightweight code from the insect omics planning folder.

local/gc_shotgun/
  Inventory of small Shotgun/Olink/GC-related files found locally. Data files are not copied here by default.

external/
  Curated official resources for shotgun metagenomics, RNA-seq, proteomics, and Olink analysis.
```

## Local Sources Scanned

- `C:\Users\Desktop\Desktop\yzyzero\__code\microbiome`
- `C:\Users\Desktop\Desktop\yzyzero\__Project\곤충`
- `C:\Users\Desktop\Desktop\yzyzero\__Study\01_microbiome`
- `C:\Users\Desktop\Desktop\yzyzero\__Study\03_transcriptome`
- `C:\Users\Desktop\Desktop\yzyzero\__Study\04_proteome`
- `C:\Users\Desktop\Desktop\yzyzero\__Personal\GC\Shotgun`
- `C:\Users\Desktop\Desktop\yzyzero\__Personal\GC\Olink`

## Excluded From GitHub Copy

- Raw sequencing files: FASTQ, BAM, BAI, SAM, CRAM
- QIIME2 and metagenome binary outputs: QZA, QZV, BIOM, databases
- Proteomics raw/vendor files: RAW, mzML, mzXML, vendor folders
- Private sample information and patient-level data
- PDF papers, PPTX decks, DOCX drafts
- Large HTML report folders and JS visualization bundles copied from analysis vendors

## Best Next GitHub Repos

Suggested split:

1. `thermo-glycine-analysis`: already prepared separately for glycine 16S/RNA-seq/integration code.
2. `omics-research-kit`: this folder, for cross-omics study notes, pipeline links, and reusable scripts.
3. `shotgun-metagenomics-notes`: optional later repo if the GC Shotgun work is cleaned into non-private analysis notes.
4. `proteomics-analysis-notes`: optional later repo for Olink/SomaScan/LC-MS-MS comparison notes after removing private data.

