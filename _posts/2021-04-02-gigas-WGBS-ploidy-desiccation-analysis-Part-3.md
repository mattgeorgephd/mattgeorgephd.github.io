---
layout: post
title: Thu. Apr. 2, 2021
subtitle: Bisulfide sequencing analysis - Part 3
gh-repo: mattgeorgephd/mattgeorgephd.github.io
gh-badge: [star, fork, follow]
tags: gigas-WGBS-ploidy-desiccation
comments: true
---

Project name: [gigas-WGBS-ploidy-desiccation](https://github.com/mattgeorgephd/WGBS-gigas-ploidy-desiccation) <br />
Funding source: [unknown]() <br />
Species: *Crassostrea gigas* <br />
variable: ploidy, desiccation, high temperature <br />

[previous notebook entry](https://mattgeorgephd.github.io/gigas-WGBS-ploidy-desiccation-analysis-Part-2/)

[next notebook entry](https://mattgeorgephd.github.io/gigas-WGBS-ploidy-desiccation-analysis-Part-4/)


### Background:
This is continuation of the WGBS analysis I've been running on Ronit's data. The previous post can be found [here](https://mattgeorgephd.github.io/gigas-WGBS-ploidy-desiccation-analysis-Part-2/). Last time I looked at the MultiQC report and quantified differences in %mCpG between diploid and triploid cgigas after desiccation at 27C for 24hrs.

### List of the progress so far:
1. Completed bismark on mox. The output was then transferred to gannet by running the rsync command as outlined in the previous post. The output is available [here](https://gannet.fish.washington.edu/panopea/030521-ronrosM/).
2. The MultiQC report can be found [here](https://gannet.fish.washington.edu/panopea/030521-ronrosM/multiqc_report.html).
3. Moved

### Goal for today:
Use [MethylKit](https://bioconductor.org/packages/release/bioc/vignettes/methylKit/inst/doc/methylKit.html) to identify differentially methylated loci (DMLs) between diploid and triploid cgigas after desiccation stress. I'll be following Yaamini's [walkthrough](https://yaaminiv.github.io/DML-Analysis-Part13/) in this post to process *.deduplicated.sorted.bam files, running an modified version of this [R markdown file](https://github.com/RobertsLab/project-virginica-oa/blob/master/analyses/2018-10-11-MethylKit-Parameter-Testing/2018-10-11-MethylKit-Parameter-Testing.Rmd) that produces results using 1x, 3x, and 5x coverage.

### Step 1: Get MethylKit installed
My R file can be found [here](https://github.com/mattgeorgephd/WGBS-gigas-ploidy-desiccation/blob/99dd32b71c4c8de6c08dad796de0bc4379c9c3c2/bisulfide_analysis/WGBS/code/2_WGBS_Methylkit.R). After some version compatibility issues, I was able to get "devtools" and "methylkit" installed and up-to-date by running R Studio as an administrator and running the following code chunk, opting to update all:

```{r}
install.packages("devtools") #Install the devtools package
library(devtools) #Load devtools

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.12")

BiocManager::install(c("GenomicFeatures", "AnnotationDbi","methylKit"))

library(methylKit) #Load methylkit

browseVignettes("methylKit") #methylKit manual
```
The important part seemed to be to install [BiocManager](https://bioconductor.org/packages/release/bioc/html/methylKit.html) version 3.12, as it is compatible with R version 4.0.4.

### Step 2: Set paths to *.deduplicated.sorted.bam files

The next step was to generate a list of files (and their locations) to be analyzed. Since my files were on gannet in this [folder](https://gannet.fish.washington.edu/panopea/030521-ronrosM/) and I plan on running the R script locally for the time being, I downloaded the files on my spare local data drive (E:/). From there, I mapped the location as follows:

```{r}
analysisFiles <- list("E:/bam_files/zr3534_1_R1.fastp-trim.20201202_bismark_bt2_pe.deduplicated.sorted.bam",
                       "E:/bam_files/zr3534_2_R1.fastp-trim.20201202_bismark_bt2_pe.deduplicated.sorted.bam",
                       "E:/bam_files/zr3534_3_R1.fastp-trim.20201202_bismark_bt2_pe.deduplicated.sorted.bam",
                       "E:/bam_files/zr3534_4_R1.fastp-trim.20201202_bismark_bt2_pe.deduplicated.sorted.bam",
                       "E:/bam_files/zr3534_5_R1.fastp-trim.20201202_bismark_bt2_pe.deduplicated.sorted.bam",
                       "E:/bam_files/zr3534_6_R1.fastp-trim.20201202_bismark_bt2_pe.deduplicated.sorted.bam",
                       "E:/bam_files/zr3534_7_R1.fastp-trim.20201202_bismark_bt2_pe.deduplicated.sorted.bam",
                       "E:/bam_files/zr3534_8_R1.fastp-trim.20201202_bismark_bt2_pe.deduplicated.sorted.bam",
                       "E:/bam_files/zr3534_9_R1.fastp-trim.20201202_bismark_bt2_pe.deduplicated.sorted.bam",
                       "E:/bam_files/zr3534_10_R1.fastp-trim.20201202_bismark_bt2_pe.deduplicated.sorted.bam")

```

This approach isn't really ideal - I should figure out a way to import directly from gannet in the future.

### Step 3: Create sampleID list and treatment variable

Next I used this quick and dirty script to generate names (just numbers 1-10 for now), and treatmentSpecifications (0=diploid,1=triploid)

```{r}
sample.IDs <- list("1", "2", "3", "4", "5", "6", "7", "8", "9", "10") #Create list of sample IDs
treatmentSpecification <- c(rep(0, times = 5), rep(1, times = 5)) # Specify which treatment the samples were from. All animals were subjected to desiccation. 0 = diploid, 1 = triploid
```

### Step 4: Run processBismarkAln

Next I will run processBismarkAln to set different coverage metrics (1x, 3x, and 5x) in the 'mincov' argument, using the folloiwng code.

```{r}
processedFilesCov1 <- processBismarkAln(location = analysisFiles, sample.id = sample.IDs, assembly = "v3", read.context = "CpG", mincov = 1, treatment = treatmentSpecification) #Process files for CpG methylation using 1x coverage. First 5 files were diploid, and the second 5 are triploid.
```
This chunk was run with mincov = 1, 3, or 5. This step took a long time! On my desktop machine (Intel(R) Core(TM) i7-8700K CPU @ 3.70GHz), it averaged 1 sample every 30 mins.

I know that Yaamini is working on a mox script for this step. I'll link it [here]() when/if she finishes it.
