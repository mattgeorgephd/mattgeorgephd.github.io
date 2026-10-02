---
layout: post
title: Fri. Feb. 18, 2022
subtitle: NOPP-gigas-ploidy-temp analysis - Part 1
project: NOPP-gigas-ploidy-temp
tags: NOPP-gigas-ploidy-temp
comments: true
---

| >>

### Background

We sent 72 samples for RNA sequencing (TagSeq) to the [Genomic Sequencing and Analysis Facility](https://wikis.utexas.edu/display/GSAF/Home+Page) at the University of Texas at Austin. Here is a list of the samples:

The sample list, with RNA results, can be found [here](https://docs.google.com/spreadsheets/d/1KY6P25HEmrDeszph56OY7tI1vAOd2rXxQ8wfZtCM7g0/edit?usp=sharing).

The zipped fastq files are available on gannet [here](https://gannet.fish.washington.edu/panopea/NOPP-gigas-ploidy-temp/20220203-tagseq)

Here is the [multiQC report](https://gsafjobs.icmb.utexas.edu/qc/JA21499/SA22026/multiqc/multiqc_report.html) that GSAF provided.

For analysis I will be leaning on notebook entries by:

1. [Laura Spencer](https://nbviewer.org/github/laurahspencer/O.lurida_QuantSeq-2020/blob/master/notebooks/2020-QuantSeq-Processing_Raw-to-Counts.ipynb);
2. [Ariana Huffmyer](https://github.com/AHuffmyer/EarlyLifeHistory_Energetics/blob/595b94c9a82233aed4526811b516f37af1c1ee42/Mcap2020/Scripts/TagSeq/TagSeq_BioInf_genomeV2.md); and
3. [Sam Gurr](https://github.com/samgurr/samgurr.github.io/blob/ca9c83b582fa0f72bddc2f0d52d62489358a94ba/_posts/2022-02-18-Oyster-TagSeq-Pipeline.md) (oyster TagSeq pipeline; the original notebook URL moved, so this links the archived source)
