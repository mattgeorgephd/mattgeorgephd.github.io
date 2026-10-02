---
layout: post
title: Thu. Apr. 1, 2021
subtitle: Bisulfite sequencing analysis - Part 2
project: WGBS-gigas-ploidy-desiccation
tags: WGBS-gigas-ploidy-desiccation
comments: true
---

### Background:
This is continuation of the WGBS analysis I've been running on Ronit's data. The previous post can be found [here](https://mattgeorgephd.github.io/gigas-WGBS-ploidy-desiccation-analysis-Part-1/). I'll be following Yaamini's [walkthrough](https://yaaminiv.github.io/Hawaii-Gigas-Methylation-Analysis-Part5/) in this post to look at the results of bismark.

### List of the progress so far:
1. Completed bismark on mox. The output was then transferred to gannet by running the rsync command as outlined in the previous post. The output is available [here](https://gannet.fish.washington.edu/panopea/030521-ronrosM/).
2. The MultiQC report can be found [here](https://gannet.fish.washington.edu/panopea/030521-ronrosM/multiqc_report.html.

### Goals for today:
1. Look at MultiQC report.
2. Determine effect of ploidy of %mCpG

### Step 1: Look at MultiQC report

Looking over the MultiQC report, alignment was amazingly consistent across samples (~61%).

![MultiQC summary statistics table for the Bismark alignments](/post_images/040121/summary_statistics.png)

As the samples are from diploid and triploid oysters, a possible issue could differences in genome size across samples. However, the number of reads across all the samples look fairly consistent (68-80 million), with the exception of maybe sample 8 which had almost 90 million.

![Bismark alignment scores: uniquely aligned, ambiguously aligned, and unaligned reads per sample](/post_images/040121/bismark_alignment_scores.png)

The deduplication percentages were pretty consistent across samples, with the highest being in sample 8 at 20.6%. At first glance there doesn't seem to be a treatment level effect.

### Step 2: Determine effect of ploidy of %mCpG

Previously, Ronit and Shelly used the [MethylFlashGlobalDNA Elisa kit](https://www.epigentek.com/catalog/methylflash-global-dna-methylation-mc-elisa-easy-kit-colorimetric-p-5370.html) to analyze 5-methylcytosine (5-mC) levels in the diploid and triploid cgigas after desiccation stress. Their data and analyses can be found [here](https://github.com/mattgeorgephd/WGBS-gigas-ploidy-desiccation/tree/master/bisulfide_analysis/ELISA). After playing around with their [R script](https://github.com/mattgeorgephd/WGBS-gigas-ploidy-desiccation/blob/master/bisulfide_analysis/ELISA/GlobalDNAMeth_Polyploids.R), it looks like they found significant differences between % 5-mC levels across ploidy (p=0.033), desiccation (p=0.001), as well as an significant ploidy:desiccation interaction (p=0.036). <br />

![Percent 5-mC (ELISA) in diploid and triploid oysters under control and desiccation stress](/post_images/040121/5mC_figure.png)

Following up on this result, I analyzed the results of bismark run on 5 oysters from each ploidy exposed to desiccation at 27C for 24 hours. The dataset is further complicated by the fact that two out of each set of 5 animals were further subjected to a 45C shock for 1 hour following desiccation. <br />

The github repo with the WGBS data and analyses can be found [here](https://github.com/mattgeorgephd/WGBS-gigas-ploidy-desiccation/tree/master/bisulfide_analysis/WGBS). I ran this [R script](https://github.com/mattgeorgephd/WGBS-gigas-ploidy-desiccation/blob/ef55b3b12245c2a8e6e3e0ebe7f0c984b2a8fa18/bisulfide_analysis/WGBS/WGBS%20analysis.R) to analyze the resulting % methylation within CpG islands as reported by MultiQC. <br />

![Percent methylated CpG by ploidy after desiccation and desiccation plus heat shock](/post_images/040121/mCpG_figure.png)

One limitation of this dataset is I don't have any unstressed animals for comparison. However, it appears ploidy was a significant factor that impacted %mCpG after desiccation (p=0.0175), while their was no measurable effect of subsequent heat shock (p=0.9119). With this result, I lumped together the two groups to generate the second figure, comparing %mCpG expression after desiccation stress (p=0.0108; n=5 per group).

### Pathway forward:
1. Continue analysis with [MethylKit](https://bioconductor.org/packages/release/bioc/vignettes/methylKit/inst/doc/methylKit.html) to identify differentially methylated loci (DMLs).
