---
layout: post
title: Thu. Feb. 16, 2023
subtitle: USDA-NRSP-8-gigas-rDNA Analysis Part 1
gh-repo: mattgeorgephd/mattgeorge.github.io
gh-badge: [star, fork, follow]
tags: USDA-NRSP-8-gigas-rDNA
comments: true
---

Project name: [USDA-NRSP-8-gigas-rDNA](https://github.com/mattgeorgephd/USDA-NRSP-8-gigas-rDNA) <br />
Funding source: [USDA-NRSP-8](https://www.nimss.org/projects/view/mrp/outline/18464) <br />
Species: *crassostrea gigas* <br />
variable: ploidy <br />

[>> next notebook entry >>](https://mattgeorgephd.github.io/USDA-NRSP-8-gigas-rDNA-analysis-2/)

------------------------------------------------------------------------------------------------------
**Power analysis**

Determine the sample size needed for whole genome sequencing given publicly available data about single copy gene variation within c.gigas across locations.

Mac was able to pull publicly available data; her analysis is [here](https://github.com/RobertsLab/resources/issues/1304). Here are her [results](https://github.com/mattgeorgephd/USDA-NRSP-8-gigas-rDNA/blob/main/ribo_mito_CNV_mean_by_sample_meta.xlsx).

From this analysis, we can see that the variation :

|  type | mean  | SD  |
|---|---|---|
| mito | 31 |  9 |
| ribo | 335 | 105 |

Looking across region, it wasn't much better:

|  type | country   | mean  | SD  |
|---|---|---|---|
|mito   |china   | 26.7   |7.6   |
|mito   |japan   |38.7   |8.4   |
|mito   |south africa   |32.4   |6.8   |
|ribo   |china   | 323.9   |129.7   |
|ribo   |japan   |361.1   |100.7   |
|ribo   |south africa   |331   |53.9   |

I used the PWR package to determine the number of samples that we need to sequence given the variation observed, where X is the variation:

```{r}
library(pwr)

# Set parameters
alpha   <- 0.05  # significance level
power   <- 0.80  # desired power
sigma   <- 8.4   # standard deviation of control group
delta   <- 20    # difference between trt and control group  
n       <- NULL  # sample size to be determined

# Perform power analysis
pwr.t.test(d = delta/sigma, sig.level = alpha, power = power, n = n)

```

Here are the results (best case scenario):
mito_copy nuumber <br />

| delta | SD | n required (each group)  |
|---|---|---|
| 20 | 6.8 | 3.13 |
| 10 | 6.8 | 8.3 |
| 5 | 6.8 | 30.02 |
| 20 | 8.4 | 4.0 |
| 10 | 8.4| 12.11 |
| 5 | 8.4 | 45.3 |

