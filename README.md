# Omics Research Kit

Curated local notes, scripts, and public resource links for microbiome, shotgun metagenomics, transcriptomics, and proteomics work.

This is a GitHub-ready research index. It intentionally excludes private raw data, patient/sample-level raw files, PDFs, PowerPoint decks, Word drafts, databases, and large binary outputs.

## Who Can Reuse This Repository?

This repository is intended for:

- researchers starting microbiome, shotgun metagenomics, transcriptomics, or proteomics projects
- students comparing common omics file formats, tools, and workflow stages
- analysts who need a public checklist before turning local notebooks into reproducible code
- maintainers building small research-automation templates for multi-omics studies
- collaborators who need source links and starter commands without private datasets

The repository is a workflow kit, not a data dump. It provides reusable notes,
official resource links, and lightweight code patterns that can be adapted to
new studies after private data has been stored elsewhere.

## Open Research Value

This project frames scattered omics notes as a public reproducibility toolkit.
It emphasizes:

- clear separation between private raw data and public workflow documentation
- reusable starting points for microbiome, shotgun, transcriptome, and proteome analysis
- links to official documentation instead of copied vendor or course materials
- lightweight examples that help a new project become GitHub-ready sooner

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

## Installation And Reproducibility

Clone the repository:

```powershell
git clone https://github.com/yzyzero0098/omics-research-kit.git
cd omics-research-kit
```

There is no single required runtime because this repository is an index of
workflows. Recommended tools depend on the section:

- microbiome: QIIME2, R, Python, and ecological-statistics packages
- shotgun metagenomics: quality-control tools, taxonomic profilers, and pathway profilers
- transcriptomics: FASTQ QC, aligner or pseudoaligner, count summarization, and R
- proteomics: vendor export tools, tabular normalization scripts, and R or Python

Suggested reuse pattern:

1. Choose the closest workflow area under `local/` or `external/`.
2. Read the linked official documentation before running commands.
3. Copy only the relevant notes into a private project workspace.
4. Replace synthetic placeholders with private local paths.
5. Publish only scripts, environment notes, and non-sensitive derived summaries.

## Citation

If this kit helps structure your study or teaching material, cite the repository
using `CITATION.cff` or the GitHub citation button.

## Contributing

Issues and pull requests are welcome for broken links, clearer workflow notes,
and additional public resources. See `CONTRIBUTING.md`.
