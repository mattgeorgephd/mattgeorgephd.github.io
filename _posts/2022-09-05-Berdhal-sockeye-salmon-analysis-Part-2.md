---
layout: post
title: Mon. Sep. 5, 2022
subtitle: Berdahl-sockeye-salmon analysis - Part 2
tags: Berdahl-sockeye-salmon
comments: true
---

Project name: [Berdahl-sockeye-salmon](https://github.com/mattgeorgephd/Berdahl-sockeye-salmon) <br />
Funding source: [unknown]() <br />
Species: *Oncorhynchus nerka* <br />
variable: behavior: territorial, social <br />

[<< previous notebook entry <<](https://mattgeorgephd.github.io/Berdhal-sockeye-salmon-analysis-Part-1/)

### Background
1. 30 sockeye salmon sampled; 1-15: territorial, 16-30: social
2. brain, liver, and gonad saved in RNAlater - frozen at -80C
3. RNA extracted - see github issues: [1](https://github.com/RobertsLab/resources/issues/1307) and [2](https://github.com/RobertsLab/resources/issues/1410)
4. RNA submitted to UT Austin GSAF on 5/24 for Tag-seq. Received gonad samples on 7/25. See [github issue](https://github.com/RobertsLab/resources/issues/1501).
5. Gave go ahead to GSAF to complete rest of tagseq on 8/12.
6. Completed tagseq processing in last notebook entry.

## Tag-seq analysis - Gonad Samples

Raw sequences were processed using the this [R script](https://github.com/mattgeorgephd/Berdahl-sockeye-salmon/blob/2d11b440bdbbf1a4dbf2da5cb30e66d45890ce7e/tag-seq/code/1_process-tagseq-data-salmon.Rmd). The resulting Gene count matrix was the used to run DEG analysis using DESEQ2, as outlined in this [R script](https://github.com/mattgeorgephd/Berdahl-sockeye-salmon/blob/2d11b440bdbbf1a4dbf2da5cb30e66d45890ce7e/tag-seq/code/2_DESeq2_analysis-salmon.Rmd).

Using this [treatment conditions datasheet](https://github.com/mattgeorgephd/Berdahl-sockeye-salmon/blob/2d11b440bdbbf1a4dbf2da5cb30e66d45890ce7e/tag-seq/data/treatments.csv), and this [genome feature table](https://gannet.fish.washington.edu/panopea/berdahl-sockeye-salmon/genome/Onerka_LOCID_gene_table.txt), I ran DESeq2 using this [gene count matrix](https://github.com/mattgeorgephd/Berdahl-sockeye-salmon/blob/2d11b440bdbbf1a4dbf2da5cb30e66d45890ce7e/tag-seq/data/onerka_gene_count_matrix.csv).

```
# Filter data
coldata_trt <- coldata # %>% filter(group == "A" | group == "B")
cts_trt     <- subset(cts, select=row.names(coldata_trt))
# Calculate DESeq object
dds <- DESeqDataSetFromMatrix(countData = cts_trt,
                              colData = coldata_trt,
                              design = ~ trt)
dds <- DESeq(dds)
resultsNames(dds) # lists the coefficients
```

I filtered out genes with cumulative counts less than 10 across all samples:

```
# https://support.bioconductor.org/p/110307/
dds <- dds[rowSums(DESeq2::counts(dds)) >= 10,]
```

I then looked at the pheatmaps and multiqc report, I removed two low quality samples (one from each treatment, major outliers in PCA and ~88% overlap with rest of samples):

```
# Remove bad samples: C05, C17
coldata <- coldata[!(row.names(coldata) %in% c('C05', 'C17')),]
cts <- as.matrix(subset(cts, select=-c(C05, C17)))
coldata %>% dplyr::count(trt)
all(colnames(cts) %in% rownames(coldata))
```

Using the good samples, I compared territorial vs. social salmon and generated the following [DEG list](https://github.com/mattgeorgephd/Berdahl-sockeye-salmon/blob/2d11b440bdbbf1a4dbf2da5cb30e66d45890ce7e/tag-seq/DESEQ_output/gonad/GONAD-ALL-DEG.csv). From this list I made the following volcano plot, PCA (+ pairs plot), and pheat map comparing the impact of treatment: </br>

|   |   |
|---|---|
| ![](https://github.com/mattgeorgephd/Berdahl-sockeye-salmon/blob/2d11b440bdbbf1a4dbf2da5cb30e66d45890ce7e/tag-seq/DESEQ_output/gonad/GONAD-PCA.png?raw=true)  |  ![](https://github.com/mattgeorgephd/Berdahl-sockeye-salmon/blob/2d11b440bdbbf1a4dbf2da5cb30e66d45890ce7e/tag-seq/DESEQ_output/gonad/GONAD-PAIRS.png?raw=true) |   |
|  ![](https://github.com/mattgeorgephd/Berdahl-sockeye-salmon/blob/2d11b440bdbbf1a4dbf2da5cb30e66d45890ce7e/tag-seq/DESEQ_output/gonad/GONAD-pheatmap.png?raw=true) | ![](https://github.com/mattgeorgephd/Berdahl-sockeye-salmon/blob/2d11b440bdbbf1a4dbf2da5cb30e66d45890ce7e/tag-seq/DESEQ_output/gonad/Volcano_all_genes.png?raw=true)  |

I also tested the impact of different shrinkage estimators (normal, apeglm, or ashr). The makers of DESeq2 suggest that the apeglm is the best.

![](https://github.com/mattgeorgephd/Berdahl-sockeye-salmon/blob/2d11b440bdbbf1a4dbf2da5cb30e66d45890ce7e/tag-seq/DESEQ_output/gonad/MA_plots.png?raw=true)

After running all estimators on the DEG list and filtering by a log2fold change cutoff of 1.5 and a p value cutoff of 0.05 I got the following results:

```
"genes_before_filtering" 37942
"genes_after_filtering" 33153
"genes_dropped" 4789
"DEGs_all-genes" 33153
"DEGs_all-genes-normal" 33153
"DEGs_all-genes-apeglm" 33153
"DEGs_all-genes-ashr" 33153
"DEG_unshrunken-p0.05_lfc1.5" 146
"DEG_normal-lfc1.5" 13
"DEG_apeglm-s0.005_lfc1.5" 106
"DEG_ashr-p0.05_lfc1.5" 12
```

Using the apeglm shrinkage estimator and significance cutoffs, I generated the following volcano plot:

![](https://github.com/mattgeorgephd/Berdahl-sockeye-salmon/blob/2d11b440bdbbf1a4dbf2da5cb30e66d45890ce7e/tag-seq/DESEQ_output/gonad/Volcano_sig_genes_apeglm.png?raw=true)

Here is the [full significant apeglm-DEG list](https://github.com/mattgeorgephd/Berdahl-sockeye-salmon/blob/2d11b440bdbbf1a4dbf2da5cb30e66d45890ce7e/tag-seq/DESEQ_output/gonad/GONAD-SIG-DEG-apeglm.csv).

I threw this list into [DAVID](https://davidbioinformatics.nih.gov/) and used the O.nerka genome as a background. This resulted in 53 GO terms, 13 of which were associated with KEGG pathways.

### GO terms:

| OFFICIAL_GENE_SYMBOL | Name                                                                     | Species            |
|----------------------|--------------------------------------------------------------------------|--------------------|
| 115103583            | dynein light chain 4, axonemal-like(LOC115103583)                        | Oncorhynchus nerka |
| 115113817            | uncharacterized LOC115113817(LOC115113817)                               | Oncorhynchus nerka |
| 115137242            | TNFAIP3-interacting protein 2-like(LOC115137242)                         | Oncorhynchus nerka |
| 115141078            | C-type lectin domain family 12 member B-like(LOC115141078)               | Oncorhynchus nerka |
| 115107536            | complement C1q-like protein 2(LOC115107536)                              | Oncorhynchus nerka |
| 115114450            | protein canopy-1-like(LOC115114450)                                      | Oncorhynchus nerka |
| 115141572            | cytochrome c oxidase subunit 7A2, mitochondrial-like(LOC115141572)       | Oncorhynchus nerka |
| 115141189            | free fatty acid receptor 2-like(LOC115141189)                            | Oncorhynchus nerka |
| 115141190            | free fatty acid receptor 2-like(LOC115141190)                            | Oncorhynchus nerka |
| 115137856            | equistatin-like(LOC115137856)                                            | Oncorhynchus nerka |
| 115137857            | ladderlectin-like(LOC115137857)                                          | Oncorhynchus nerka |
| 115115202            | uncharacterized protein CFAP97D2-like(LOC115115202)                      | Oncorhynchus nerka |
| 115137858            | equistatin-like(LOC115137858)                                            | Oncorhynchus nerka |
| 115137859            | saxiphilin-like(LOC115137859)                                            | Oncorhynchus nerka |
| 115132668            | receptor-transporting protein 3-like(LOC115132668)                       | Oncorhynchus nerka |
| 115122036            | intraflagellar transport protein 56(LOC115122036)                        | Oncorhynchus nerka |
| 115130098            | la-related protein 4B-like(LOC115130098)                                 | Oncorhynchus nerka |
| 115112946            | ADP-ribosylation factor 4-like(LOC115112946)                             | Oncorhynchus nerka |
| 115141356            | C-type lectin domain family 4 member E-like(LOC115141356)                | Oncorhynchus nerka |
| 115108974            | RIB43A-like with coiled-coils protein 2(LOC115108974)                    | Oncorhynchus nerka |
| 115123433            | dentin sialophosphoprotein-like(LOC115123433)                            | Oncorhynchus nerka |
| 115101161            | paired box protein Pax-8-like(LOC115101161)                              | Oncorhynchus nerka |
| 115112426            | serum amyloid A-5 protein-like(LOC115112426)                             | Oncorhynchus nerka |
| 115112427            | serum amyloid A-5 protein-like(LOC115112427)                             | Oncorhynchus nerka |
| 115105764            | neurofibromin-like(LOC115105764)                                         | Oncorhynchus nerka |
| 115107045            | uncharacterized LOC115107045(LOC115107045)                               | Oncorhynchus nerka |
| 115141350            | CD209 antigen-like protein E(LOC115141350)                               | Oncorhynchus nerka |
| 115108322            | transmembrane protein 59-like(LOC115108322)                              | Oncorhynchus nerka |
| 115107483            | adhesion G protein-coupled receptor F5-like(LOC115107483)                | Oncorhynchus nerka |
| 115131920            | testis-expressed protein 49-like(LOC115131920)                           | Oncorhynchus nerka |
| 115139472            | enoyl-[acyl-carrier-protein] reductase, mitochondrial-like(LOC115139472) | Oncorhynchus nerka |
| 115110674            | forkhead box protein J1-A-like(LOC115110674)                             | Oncorhynchus nerka |
| 115101837            | ubiquitin-conjugating enzyme E2 U-like(LOC115101837)                     | Oncorhynchus nerka |
| 115139209            | sterile alpha motif domain-containing protein 15-like(LOC115139209)      | Oncorhynchus nerka |
| 115122569            | paired box protein Pax-8-like(LOC115122569)                              | Oncorhynchus nerka |
| 115120516            | patched domain-containing protein 3-like(LOC115120516)                   | Oncorhynchus nerka |
| 115143556            | E3 ubiquitin-protein ligase NEURL1-like(LOC115143556)                    | Oncorhynchus nerka |
| 115138053            | cytochrome b5 domain-containing protein 1(LOC115138053)                  | Oncorhynchus nerka |
| 115103238            | homer protein homolog 3-like(LOC115103238)                               | Oncorhynchus nerka |
| 115146113            | gamma-aminobutyric acid receptor subunit beta-1-like(LOC115146113)       | Oncorhynchus nerka |
| 115128579            | anterior gradient protein 2 homolog(LOC115128579)                        | Oncorhynchus nerka |
| 115132860            | homeobox protein Hox-C9-like(LOC115132860)                               | Oncorhynchus nerka |
| 115105983            | MORN repeat-containing protein 5-like(LOC115105983)                      | Oncorhynchus nerka |
| 115104313            | forkhead box protein J1-A-like(LOC115104313)                             | Oncorhynchus nerka |
| 115137594            | somatolactin(LOC115137594)                                               | Oncorhynchus nerka |
| 115120950            | uncharacterized LOC115120950(LOC115120950)                               | Oncorhynchus nerka |
| 115145526            | protein FAM183A-like(LOC115145526)                                       | Oncorhynchus nerka |
| 115141814            | 14-3-3 protein gamma-2-like(LOC115141814)                                | Oncorhynchus nerka |
| 115146679            | dynein light chain Tctex-type 1-like(LOC115146679)                       | Oncorhynchus nerka |
| 115117106            | cyclin-dependent kinase inhibitor 1B-like(LOC115117106)                  | Oncorhynchus nerka |
| 115138857            | ladderlectin-like(LOC115138857)                                          | Oncorhynchus nerka |
| 115138859            | ladderlectin-like(LOC115138859)                                          | Oncorhynchus nerka |
| 115125542            | calcyphosin-like protein(LOC115125542)                                   | Oncorhynchus nerka |


### KEGG Pathways:

| ID        | Gene Name                                                                | Species            | KEGG_PATHWAY                                                                                                                |
|-----------|--------------------------------------------------------------------------|--------------------|-----------------------------------------------------------------------------------------------------------------------------|
| 115141814 | 14-3-3 protein gamma-2-like(LOC115141814)                                | Oncorhynchus nerka | one04110:Cell cycle,one04114:Oocyte meiosis,                                                                                |
| 115112946 | ADP-ribosylation factor 4-like(LOC115112946)                             | Oncorhynchus nerka | one04144:Endocytosis,                                                                                                       |
| 115141356 | C-type lectin domain family 4 member E-like(LOC115141356)                | Oncorhynchus nerka | one04625:C-type lectin receptor signaling pathway,                                                                          |
| 115117106 | cyclin-dependent kinase inhibitor 1B-like(LOC115117106)                  | Oncorhynchus nerka | one04110:Cell cycle,                                                                                                        |
| 115141572 | cytochrome c oxidase subunit 7A2, mitochondrial-like(LOC115141572)       | Oncorhynchus nerka | one00190:Oxidative phosphorylation,one01100:Metabolic pathways,one04260:Cardiac muscle contraction,                         |
| 115146679 | dynein light chain Tctex-type 1-like(LOC115146679)                       | Oncorhynchus nerka | one05132:Salmonella infection,                                                                                              |
| 115139472 | enoyl-[acyl-carrier-protein] reductase, mitochondrial-like(LOC115139472) | Oncorhynchus nerka | one00061:Fatty acid biosynthesis,one00062:Fatty acid elongation,one01100:Metabolic pathways,one01212:Fatty acid metabolism, |
| 115146113 | gamma-aminobutyric acid receptor subunit beta-1-like(LOC115146113)       | Oncorhynchus nerka | one04080:Neuroactive ligand-receptor interaction,                                                                           |
| 115103238 | homer protein homolog 3-like(LOC115103238)                               | Oncorhynchus nerka | one04068:FoxO signaling pathway,                                                                                            |
| 115105764 | neurofibromin-like(LOC115105764)                                         | Oncorhynchus nerka | one04010:MAPK signaling pathway,                                                                                            |
| 115137594 | somatolactin(LOC115137594)                                               | Oncorhynchus nerka | one04060:Cytokine-cytokine receptor interaction,one04080:Neuroactive ligand-receptor interaction,                           |
| 115101837 | ubiquitin-conjugating enzyme E2 U-like(LOC115101837)                     | Oncorhynchus nerka | one04120:Ubiquitin mediated proteolysis,                                                                                    |
| 115120950 | uncharacterized LOC115120950(LOC115120950)                               | Oncorhynchus nerka | one00910:Nitrogen metabolism,one01100:Metabolic pathways,                                                                   |
