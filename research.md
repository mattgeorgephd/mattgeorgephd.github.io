---
layout: page
title: Research
subtitle: How climate change affects shellfish, and what that means for the fisheries and farms that depend on them
share-description: Research projects of Matthew N. George on coastal shellfish fisheries, oyster climate resilience, mussel attachment, and salmon behavior genomics, with links to code, data, and lab notebook entries.
---

My research asks how marine organisms respond to environmental change, from the molecular level up to the fishery, and how that knowledge can inform management and aquaculture. Projects are listed with their funding, collaborators, and links to open code and [lab notebook]({{ '/notebook/' | relative_url }}) entries. For papers, see [Publications]({{ '/publications/' | relative_url }}); for repositories, see [Code & Data]({{ '/code/' | relative_url }}).

**Jump to:** [Coastal shellfish fisheries](#coastal-shellfish-fisheries) &middot; [Oyster climate resilience](#oyster-resilience) &middot; [Mussel attachment](#mussel-attachment) &middot; [Salmon behavior genomics](#salmon-behavior) &middot; [Earlier work](#earlier-work) &middot; [Funding](#funding)

## Coastal shellfish fisheries {#coastal-shellfish-fisheries}

*Washington Department of Fish and Wildlife, 2023-present*

As lead of WDFW's Coastal Shellfish Unit, I direct research and monitoring on how climate change affects commercial shellfish fisheries worth more than $120M a year, and I designed monitoring programs for eight recreational fisheries. The unit works with federal, state, and tribal partners and advisory groups to build harvest and management plans aimed at long-term sustainability and climate resilience.

<div class="project" markdown="1">

### Climate-driven recruitment of Pacific razor clams

<p class="project-meta">Washington coastal recreational razor clam fishery, 1997-2025</p>

How ocean conditions drive year-to-year recruitment in the razor clam (*Siliqua patula*) populations that support one of Washington's most popular recreational fisheries.

<p class="project-links">
<a href="https://github.com/mattgeorgephd/razor-clam-recruitment-analysis"><i class="fab fa-github" aria-hidden="true"></i> recruitment analysis</a>
<a href="{{ '/presentations/' | relative_url }}"><i class="fas fa-chalkboard-teacher" aria-hidden="true"></i> talks (2024, 2026)</a>
</p>
</div>

<div class="project" markdown="1">

### Coastal Dungeness crab in a changing ocean

<p class="project-meta">Washington coastal commercial and recreational Dungeness crab fisheries</p>

Estimating recreational crab harvest at Westport and Grays Harbor with Bayesian state-space models that fill gaps between sampled days and carry uncertainty through to the final estimate, and monitoring Dungeness crab larvae with light traps on the outer coast.

<p class="project-links">
<a href="https://github.com/mattgeorgephd/Coastal-Rec-Crab-BSS"><i class="fab fa-github" aria-hidden="true"></i> recreational harvest estimation</a>
</p>
</div>

<div class="project" markdown="1">

### Burrowing shrimp and on-bottom bivalve aquaculture

<p class="project-meta">Willapa Bay, Washington</p>

Assessing burrowing shrimp as a threat to on-bottom bivalve aquaculture, presented to the Integrated Pest Management Working Group (2024).

</div>

## Oyster climate resilience {#oyster-resilience}

*University of Washington School of Aquatic and Fishery Sciences and NOAA Northwest Fisheries Science Center, 2020-2023*

<div class="project" markdown="1">

### Triploidy and marine heatwaves in Pacific oysters

<p class="project-meta">NOAA National Oceanographic Partnership Program (NOPP; $233,135) &middot; with Steven Roberts (UW) and Mackenzie Gavery (NOAA)</p>

Many farmed Pacific oysters are triploid: an extra chromosome set makes them functionally sterile, so energy that would go to reproduction goes to growth instead. Using hatchery experiments that simulated marine heatwaves and low-tide desiccation, we found that triploid oysters had dysregulated stress responses and higher mortality than diploids, which helps explain the "triploid mortality" events growers see in hot summers. The results were published in [*Global Change Biology*](https://doi.org/10.1111/gcb.16880) (2023), with an [invited commentary](https://doi.org/10.1111/gcb.16980) in the same journal, and [covered]({{ '/media/' | relative_url }}) by Hakai Magazine, *Popular Science*, and *The Atlantic*. A companion whole-genome bisulfite sequencing study examines how DNA methylation differs between diploid and triploid oysters after thermal stress (manuscript in preparation).

<p class="project-links">
<a href="https://github.com/mattgeorgephd/NOPP-gigas-ploidy-temp"><i class="fab fa-github" aria-hidden="true"></i> heatwave data &amp; code</a>
<a href="{{ '/Pt-Whitney-Tank-Build-1/' | relative_url }}"><i class="fas fa-book" aria-hidden="true"></i> hatchery tank build</a>
<a href="{{ '/NOPP-gigas-ploidy-temp-analysis-Part-1/' | relative_url }}"><i class="fas fa-book" aria-hidden="true"></i> Tag-seq analysis</a>
<a href="{{ '/gigas-WGBS-ploidy-desiccation-analysis-Part-1/' | relative_url }}"><i class="fas fa-book" aria-hidden="true"></i> WGBS analysis</a>
</p>
</div>

<div class="project" markdown="1">

### Hatchery conditioning for climate-resilient oyster seed

<p class="project-meta">USDA NIFA Special Research Grants for Aquaculture Research (SRGARP; $325,611) &middot; co-PI with Steven Roberts</p>

Poor summer survival limits U.S. oyster production. Working with Taylor Shellfish, Nisbet Oyster Co., Pacific Hybreed, and the Jamestown S'Klallam Tribe, we tested broodstock and early-life conditioning (heat and mechanical stress priming, and immune priming with poly(I:C)) as a way to use transgenerational and developmental plasticity to make seed more resilient, without the cost or loss of genetic diversity that comes with selective breeding.

<p class="project-links">
<a href="{{ '/USDA-SRGARP-gigas-carryover-pilot-1/' | relative_url }}"><i class="fas fa-book" aria-hidden="true"></i> notebook entries</a>
</p>
</div>

<div class="project" markdown="1">

### Ribosomal DNA copy number as a predictor of phenotype

<p class="project-meta">USDA NRSP-8 National Animal Genome Research Program ($10,000) &middot; with Steven Roberts</p>

Ribosomal DNA drives ribosome production and is tied to growth, development, and metabolism, yet its copy number is rarely studied in shellfish. We used whole-genome sequencing of diploid and triploid oyster families to measure rDNA and mitochondrial copy-number variation as candidate genomic predictors of stress tolerance and growth.

<p class="project-links">
<a href="{{ '/USDA-NRSP-8-gigas-rDNA-analysis-1/' | relative_url }}"><i class="fas fa-book" aria-hidden="true"></i> notebook entries</a>
</p>
</div>

## Mussel attachment under ocean change {#mussel-attachment}

<div class="project" markdown="1">

### Genomic markers for resilient mussel attachment

<p class="project-meta">Pacific States Marine Fisheries Commission (PSMFC; $124,980) &middot; co-PI with Emily Carrington &middot; industry partner Penn Cove Shellfish</p>

Mussels hold onto farm lines with byssal threads, protein fibers whose strength drops under acidification, warming, and hypoxia. We exposed *Mytilus trossulus* to these stressors, measured thread strength, and sequenced foot and gill gene expression to find genetic markers that could guide broodstock selection for strong attachment in future oceans.

<p class="project-links">
<a href="https://github.com/mattgeorgephd/PSMFC-mytilus-byssus-pilot"><i class="fab fa-github" aria-hidden="true"></i> project repository</a>
<a href="{{ '/PSMFC-mytilus-byssus-pilot-Part-0/' | relative_url }}"><i class="fas fa-book" aria-hidden="true"></i> notebook entries</a>
</p>
</div>

<div class="project" markdown="1">

### The ecomechanics of mussel attachment (Ph.D. research)

<p class="project-meta">University of Washington &middot; NSF Graduate Research Fellowship &middot; advisor Emily Carrington</p>

My dissertation showed that ocean acidification weakens mussel attachment ([*Nature Climate Change*](https://doi.org/10.1038/nclimate1846), 2013), that hypoxia interrupts the DOPA cross-linking that cures the adhesive ([*J. R. Soc. Interface*](https://doi.org/10.1098/rsif.2018.0489), 2018), that seawater conditions after secretion change adhesive strength ([*Biofouling*](https://doi.org/10.1080/08927014.2018.1453927), 2018), and that pH and oxygen fluctuate at small scales inside mussel aggregations, with consequences for raft aquaculture ([*J. Shellfish Res.*](https://doi.org/10.2983/035.038.0329), 2019).

</div>

## Salmon behavior genomics {#salmon-behavior}

<div class="project" markdown="1">

### Gene expression and territoriality in sockeye salmon

<p class="project-meta">University of Washington &middot; with S. Smith, M. Gavery, and S. Roberts</p>

Tag-seq of brain, liver, and gonad tissue from territorial and social sockeye salmon, used to identify differentially expressed genes and co-expression networks associated with behavior (manuscript in preparation). The analysis has since been rebuilt as a fully reproducible Quarto project.

<p class="project-links">
<a href="https://github.com/mattgeorgephd/Berdahl-sockeye-salmon"><i class="fab fa-github" aria-hidden="true"></i> project repository</a>
<a href="{{ '/Berdhal-sockeye-salmon-analysis-Part-1/' | relative_url }}"><i class="fas fa-book" aria-hidden="true"></i> notebook entries</a>
</p>
</div>

## Earlier work {#earlier-work}

- **Biomedical engineering and stem cell biology (2018-2020).** At the Mayo Clinic and Children's Hospital of Philadelphia I developed injectable, mussel-inspired adhesive hydrogels for bone tissue engineering, contributed to work on conductive and 3D-printed scaffolds, studied human endoderm development in pluripotent stem cells, and reviewed genome-editing approaches for modeling beta-cell disease. See [biomedical publications]({{ '/publications/#biomedical' | relative_url }}).
- **Functional morphology.** Undergraduate and early graduate work on the mechanics of fiddler crab claws ([*BMC Evol. Biol.*](https://doi.org/10.1186/1471-2148-13-137), 2013) and drift-particle capture by sea urchin spines ([*JEMBE*](https://doi.org/10.1016/j.jembe.2014.08.001), 2014).

## Funding {#funding}

<ul class="dated-list">
{%- for g in site.data.grants.grants %}
  <li><span class="when">{{ g.years }}</span><span>{{ g.title }}<span class="what-sub">{{ g.funder }} &middot; {{ g.amount }} &middot; {{ g.role }}</span></span></li>
{%- endfor %}
</ul>

Fellowships and awards are listed in the [CV]({{ '/cv/#fellowships' | relative_url }}).
