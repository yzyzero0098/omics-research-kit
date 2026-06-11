###############################################################################
# 16S microbiome pipeline (QIIME2 export version)
# Style matched with shotgun pipeline
###############################################################################

# ------------------------------
# 0) Working directory
# ------------------------------

setwd("C:/Users/Desktop/Desktop/지영/glycine/qiime2/function")

feature_fp  <- "feature-table.tsv"
taxonomy_fp <- "taxonomy.tsv"
meta_fp     <- "sample-metadata.txt"

out_dir <- paste0("results_16S_", format(Sys.Date(), "%Y%m%d"))
fig_dir <- file.path(out_dir,"figures")
tab_dir <- file.path(out_dir,"tables")

dir.create(out_dir,showWarnings=FALSE)
dir.create(fig_dir,showWarnings=FALSE)
dir.create(tab_dir,showWarnings=FALSE)

set.seed(1234)

# ------------------------------
# 1) Packages
# ------------------------------
# ------------------------------
# Install packages if missing
# ------------------------------

install_if_missing_cran <- function(pkgs){
  for(p in pkgs){
    if(!requireNamespace(p, quietly = TRUE)){
      install.packages(p, dependencies = TRUE)
    }
  }
}

install_if_missing_bioc <- function(pkgs){
  if(!requireNamespace("BiocManager", quietly = TRUE)){
    install.packages("BiocManager")
  }
  
  for(p in pkgs){
    if(!requireNamespace(p, quietly = TRUE)){
      BiocManager::install(p, ask = FALSE, update = FALSE)
    }
  }
}

# CRAN packages
cran_pkgs <- c(
  "tidyverse",
  "vegan",
  "ggpubr",
  "pheatmap"
)

# Bioconductor packages
bioc_pkgs <- c(
  "phyloseq",
  "Maaslin2",
  "ANCOMBC",
  "ALDEx2",
  "microbiomeMarker"
)

install_if_missing_cran(cran_pkgs)
install_if_missing_bioc(bioc_pkgs)

install.packages("BiocManager")
BiocManager::install("ANCOMBC", ask = FALSE, update = FALSE)

BiocManager::install("microbiomeMarker", ask = FALSE, update = FALSE)

# load packages
library(tidyverse)
library(phyloseq)
library(vegan)
library(ggpubr)
library(pheatmap)
library(Maaslin2)
library(ANCOMBC)
library(ALDEx2)
library(microbiomeMarker)

# ------------------------------
# 2) Plot theme
# ------------------------------

base_family <- ifelse(Sys.info()[["sysname"]] == "Windows","Arial","Helvetica")

group_colors <- c(
  "NC"="#1976D2",
  "PC"="#388E3C",
  "G25"="#F57C00",
  "G50"="#D32F2F"
)

theme_set(
  theme_bw(base_family=base_family)+
    theme(
      plot.title=element_text(face="bold",hjust=0.5),
      axis.title=element_text(face="bold"),
      legend.title=element_text(face="bold")
    )
)

# ------------------------------
# 3) Load metadata
# ------------------------------

meta <- read.delim(meta_fp,sep="\t")

meta$SampleID <- meta$SampleID
meta$Group <- factor(meta$Treat,
                     levels=c("NC","PC","G25","G50"))

meta_model <- meta %>%
  select(SampleID,Group)

# ------------------------------
# 4) Load feature table
# ------------------------------

feature <- read.delim(feature_fp,
                      skip=1,row.names=1)

feature <- feature[,-1]

feature_mat <- as.matrix(feature)

# ------------------------------
# 5) Load taxonomy
# ------------------------------

tax <- read.delim(taxonomy_fp)

tax_split <- str_split_fixed(tax$Taxon,";",7)

colnames(tax_split) <- c(
  "Kingdom","Phylum","Class","Order",
  "Family","Genus","Species")

tax_mat <- as.matrix(tax_split)

rownames(tax_mat) <- tax$Feature.ID

# ------------------------------
# 6) Match samples
# ------------------------------

common_samples <- intersect(
  colnames(feature_mat),
  meta_model$SampleID
)

feature_mat <- feature_mat[,common_samples]

meta_use <- meta_model %>%
  filter(SampleID %in% common_samples) %>%
  column_to_rownames("SampleID")

# ------------------------------
# 7) phyloseq object
# ------------------------------

OTU <- otu_table(feature_mat,taxa_are_rows=TRUE)
TAX <- tax_table(tax_mat)
META <- sample_data(meta_use)

ps <- phyloseq(OTU,TAX,META)

# relative abundance

ps_rel <- transform_sample_counts(
  ps,
  function(x)x/sum(x)
)

# ------------------------------
# 8) Alpha diversity
# ------------------------------

alpha_df <- estimate_richness(
  ps_rel,
  measures=c("Shannon","Simpson")
)

alpha_df$SampleID <- rownames(alpha_df)

alpha_df <- left_join(
  alpha_df,
  meta_model,
  by="SampleID"
)

alpha_long <- pivot_longer(
  alpha_df,
  cols=c("Shannon","Simpson"),
  names_to="Metric",
  values_to="Value"
)

p_alpha <- ggplot(alpha_long,
                  aes(Group,Value,fill=Group))+
  geom_boxplot()+
  geom_jitter(width=0.1)+
  facet_wrap(~Metric,scales="free_y")+
  scale_fill_manual(values=group_colors)+
  stat_compare_means()

ggsave(
  file.path(fig_dir,"AlphaDiversity.png"),
  p_alpha,width=8,height=5,dpi=300)

# ------------------------------
# 9) Beta diversity
# ------------------------------

dist_bray <- phyloseq::distance(
  ps_rel,
  method="bray"
)

ord <- ordinate(
  ps_rel,
  method="PCoA",
  distance=dist_bray
)

p_beta <- plot_ordination(
  ps_rel,
  ord,
  color="Group"
)+
  geom_point(size=3)+
  scale_color_manual(values=group_colors)

ggsave(
  file.path(fig_dir,"BetaDiversity_PCoA.png"),
  p_beta,width=7,height=6,dpi=300)

# PERMANOVA

meta_beta <- data.frame(sample_data(ps_rel))

adon <- adonis2(
  dist_bray ~ Group,
  data=meta_beta
)

write.csv(
  adon,
  file.path(tab_dir,"PERMANOVA.csv")
)

# ------------------------------
# 10) Taxonomy composition
# ------------------------------

ps_genus <- tax_glom(ps_rel,"Genus")

df <- psmelt(ps_genus)

top_taxa <- df %>%
  group_by(Genus)%>%
  summarise(total=sum(Abundance))%>%
  arrange(desc(total))%>%
  slice_head(n=10)%>%
  pull(Genus)

df$Genus2 <- ifelse(
  df$Genus %in% top_taxa,
  df$Genus,
  "Others"
)

p_tax <- ggplot(df,
                aes(Sample,Abundance,fill=Genus2))+
  geom_bar(stat="identity")+
  facet_grid(~Group,scales="free_x",space="free")+
  theme(
    axis.text.x=element_text(angle=90,size=6)
  )

ggsave(
  file.path(fig_dir,"Taxonomy_Composition.png"),
  p_tax,width=14,height=6,dpi=300)

# ------------------------------
# 11) Differential abundance
# ------------------------------

# ANCOMBC2

ps_counts <- transform_sample_counts(
  ps,
  function(x)round(x/sum(x)*1e6)
)

ancom_out <- ancombc2(
  data=ps_counts,
  fix_formula="Group",
  group="Group",
  p_adj_method="BH"
)

ancom_tbl <- as.data.frame(ancom_out$res)

write.csv(
  ancom_tbl,
  file.path(tab_dir,"DA_ANCOMBC2.csv")
)

# ------------------------------
# 12) MaAsLin2
# ------------------------------

feat <- as.data.frame(
  t(otu_table(ps_rel))
)

meta_maas <- data.frame(
  sample_data(ps_rel)
)

fit <- Maaslin2(
  feat,
  meta_maas,
  output="maaslin2_out",
  fixed_effects=c("Group"),
  normalization="NONE",
  transform="LOG"
)

# ------------------------------
# 13) ALDEx2
# ------------------------------

counts <- as.matrix(otu_table(ps_counts))

conds <- meta_maas$Group

clr <- aldex.clr(
  counts,
  conds,
  mc.samples=128
)

tt <- aldex.ttest(clr)
ef <- aldex.effect(clr)

aldex_tbl <- data.frame(tt,ef)

write.csv(
  aldex_tbl,
  file.path(tab_dir,"DA_ALDEx2.csv")
)

# ------------------------------
# 14) LEfSe
# ------------------------------

lefse_res <- run_lefse(
  ps_rel,
  group="Group",
  taxa_rank="Genus"
)

lefse_tbl <- marker_table(lefse_res)

write.csv(
  lefse_tbl,
  file.path(tab_dir,"DA_LEfSe.csv")
)

# ------------------------------
# 15) Save session
# ------------------------------

sink(file.path(out_dir,"sessionInfo.txt"))
print(sessionInfo())
sink()

cat("\nAnalysis complete\n")