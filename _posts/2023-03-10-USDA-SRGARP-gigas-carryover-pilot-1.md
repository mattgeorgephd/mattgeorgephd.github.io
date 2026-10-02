---
layout: post
title: Fri. Mar. 10, 2023
subtitle: USDA-SRGARP-gigas-carryover pilot Part 1
gh-repo: mattgeorgephd/mattgeorgephd.github.io
gh-badge: [star, fork, follow]
tags: USDA-SRGARP-gigas-carryover
comments: true
---

Project name: [USDA-SRGARP-gigas-carryover](https://github.com/mattgeorgephd/USDA-SRGARP-gigas-carryover) <br />
Funding source: [USDA-SRGARP](https://www.nifa.usda.gov/sites/default/files/2022-04/FY22-SRGARP-RFA-508.pdf) <br />
Species: *crassostrea gigas* <br />
variable: heat-shock, mechanical stress, poly(I:C) <br />

[>> next notebook entry >>](https://mattgeorgephd.github.io/USDA-SRGARP-gigas-carryover-pilot-2/)

------------------------------------------------------------------------------------------------------
## Immune priming injection vs. emersion pilot (w/ ploidy thrown in)

**Step 1: power analysis**

Determine the sample size needed to detect an immune response in c.gigas after poly(I:C) injection.

[Lafont et al. (2020)](https://doi.org/10.1128/mBio.02777-19) found a 3-fold increase in viveprin expression following injection of poly(I·C) high molecular weight (HMW) (InVivogen; catalog code tlrl-pic) in juvenile oysters (19 μg · g−1 of oyster).  

<br>

![](https://journals.asm.org/doi/10.1128/mBio.02777-19#fig7)

<br />

Given the results, it looks like a 3-fold increase in SACSIN, IRF2, and Viperin would be good assays. I ran a power analysis w/ this Rmd code to determine how many oysters to assign to each group, assuming a worst case variance of 1.5 fold in the control:

```{r}
library(pwr)

# Set parameters
alpha   <- 0.05  # significance level
power   <- 0.80  # desired power
sigma   <- 1.5   # standard deviation of control group
delta   <- 3     # difference between trt and control group  
n       <- NULL  # sample size to be determined

# Perform power analysis
pwr.t.test(d = delta/sigma, sig.level = alpha, power = power, n = n)
```
This suggested 5 per group

```
     Two-sample t test power calculation

              n = 5.089995
              d = 2
      sig.level = 0.05
          power = 0.8
    alternative = two.sided

NOTE: n is number in *each* group
```
So the treatment breakdown will be:

|treatment   | ploidy  | number  |
|---|---|---|
|control   | 2n  | 5  |
|control   | 3n  | 5  |
|poly(I:C) injection   | 2n  | 5  |
|poly(I:C) injection   | 3n  | 5  |
|poly(I:C) immersion   | 2n  | 5  |
|poly(I:C) immersion   | 3n  | 5  |

**STEP 2: order primers**

|gene   | genbank  | forward  | reverse |
|---|---|---|---|
|SACSIN   | CGI_10019897  | ACTCTGGCACCATCCAGTTATC  | CTCCTGAGAAGGCCTTTAGACA |
|IRF-2 (2)  | CGI_10021170  | CGAAACGCAGAAACTGTTC  | ATTTGCCTTCCATCTTTTGG |
|DICER  | CGI_10020752  | ACGTCGGTAGCAGAGGAAGG  | CTTCCTCCATCTTCTCACTGC |
|viperin   | CGI_10018396  | TAAATGCGGCTTCTGTTTCC  |CAGCTGAAGGTCCTCTTTGC |
|cGAS   | CGI_10023476  | TTCAAAGATGGTGCAGGAGGAG  | AGGGTCTTTCACAAGGTTCCTC |

**STEP 3: determine immersion bath treatment conditions**

No data is publicly available for emersion w/ poly(I:C), although [Tim Green at U Vic](https://www.researchgate.net/profile/Timothy-Green) mentioned that Caroline Montagnani at the Institut Universitaire Européen de la Mer (cmontagn@ifremer.fr) might know. I'll email her.

**STEP 4: test anathesia experiment**

Eric Essington prepped and measured the oysters today. I'd prefer not to knotch the shell and inject, so it seems like anathesia is the way to go. The Lafont et al. (2020) anesthetized in hexahydrate MgCl2 (ACROS; catalog number 197530250, 50 g liter−1, 100 oysters liter−1) according to the method of [Suquet et al. (2009)](https://doi.org/10.1051/alr/2009006) for 8 h.

According to these methods, here are a few notes about the protocol:
1. 5 L container w/ 50 g L−1 MgCl in water
2. Water is a dilution medium: 3 L freshwater and 2 L seawater to maintain salinity at 35–38%.
3. 100 oysters liter−1 concentration; oysters were 3.5 months; shell length, 20.6 ± 0.1 mm; total weight, 1.62 ± 0.1 g; means ± standard errors [SE])
4. 8 hr exposure
5. Oysters were considered as anaesthetised when, after three successive gentle pressures on valves, shell closure was not observed
6. Oysters were then returned to clean seawater. The oysters were judged to have recovered when they closed their valves by themselves.
7. Suquet et al 2009 found no mortality at 50 g L-1 1 week after.
8. Exposure to magnesium chloride did not have long term effects (more than 48-96 hours) on immunological parameters in Sydney rock oysters [Butt et al. 2008](https://doi.org/10.1016/j.aquaculture.2007.12.004). This might affect when we sample?
