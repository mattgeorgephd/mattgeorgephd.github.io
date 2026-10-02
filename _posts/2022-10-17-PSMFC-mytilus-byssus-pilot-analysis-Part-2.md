---
layout: post
title: Mon. Oct. 17, 2022
subtitle: PSMFC-mytilus-byssus-pilot Analysis Part 2
project: PSMFC-mytilus-byssus-pilot
tags: PSMFC-mytilus-byssus-pilot
comments: true
---

------------------------------------------------------------------------------------------------------
### RNA-seq for de novo transcriptome assembly

We are submitting pooled samples from foot and gill tissue for whole transcriptome sequencing

The mytilus trossulus genome has a c-value of 1.51 according to [genomesizes.com](https://www.genomesize.com/result_species.php?id=4779)

Convert to bp:
```
1.51 * 0.978 * 10^9 = 1,476,780,000 bp or 1,476 Mbp
```  
Given that approximately 5% of the genome is expressed at any given times in the human genome, I estimate that the transcriptome size is approximately:

```
1,476,780,000 * 0.05 = 73,839,000 or ~ 74 Mbp
```

Samples will be submitted to the [UT Austin GSAF](https://wikis.utexas.edu/display/GSAF/Sequencing+Prices+and+Descriptions) and run on individual lanes on the NovaSeq S1 PE150, which generates 7*10^8 reads per lane. This yield the following coverage:

```
700,000,000 bp / 74,000,000 bp = ~10x coverage
```

Samples for [submission](https://docs.google.com/spreadsheets/d/1zZ6L05j-SyYJbzzQI_kBafFaReE4Ysp_9bORdbBu_r8/edit?usp=sharing). 71 foot samples (from 59 mussels) and 60 gill samples (from 60 mussels) were pooled. The resulting RNA concentrations were 65 ng/ul (Foot - MTF) and 73 ng/ul (Gill - MTG) using the Qubit.

Here are the nanodrop results. Both have a 260/280 ratio of ~2 and the tails are clean, which indicates pure RNA. The Qubit concentrations are more accurate.

![NanoDrop absorbance spectrum for the MTF RNA sample](/post_images/20221017/MTF.jpg)

![NanoDrop absorbance spectrum for the MTG RNA sample](/post_images/20221017/MTG.jpg)

100 ul of each sample were submitted to the GSAF on 10/18/2022.
