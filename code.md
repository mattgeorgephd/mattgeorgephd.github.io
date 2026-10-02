---
layout: page
title: Code & Data
subtitle: Open analysis pipelines, datasets, and how-to guides
share-description: Public GitHub repositories by Matthew N. George for fisheries assessment, shellfish genomics, and physiology, plus R guides and an open lab notebook.
---

I keep analyses public so that results can be checked, reused, and built on. Everything below is on [GitHub](https://github.com/mattgeorgephd); each repository's README explains its layout and how to reproduce the results.

## Fisheries assessment

Washington Department of Fish and Wildlife projects on coastal shellfish fisheries.

{% include repo-cards.html items=site.data.repos.fisheries %}

## Shellfish and salmon physiology and genomics

University of Washington and NOAA projects, 2020-2023. Day-by-day methods for these and related projects are documented in the [lab notebook]({{ '/notebook/' | relative_url }}).

{% include repo-cards.html items=site.data.repos.shellfish %}

## Guides

- [ANOVA in R: assumptions, transformations, model selection, and post hoc tests]({{ '/ANOVA-guide/' | relative_url }}), with the [dataset and R Markdown source](https://github.com/mattgeorgephd/mattgeorgephd.github.io/tree/master/guides/2022-12-18-ANOVA)
- [Using gptstudio to write and improve R code in RStudio]({{ '/gptstudio-guide/' | relative_url }})
- [Useful R code chunks]({{ '/R-code-chunks/' | relative_url }})
- [Setting up a Neptune Apex aquarium controller]({{ '/Apex-setup-procedure/' | relative_url }}) and [a Honeywell UDA2182 pH/DO analyzer]({{ '/Honeywell-UDA2182-setup/' | relative_url }})

## Lab notebook

My [open lab notebook]({{ '/notebook/' | relative_url }}) records experiments and analyses by project. You can also browse [all entries by date]({{ '/monthview/' | relative_url }}).
