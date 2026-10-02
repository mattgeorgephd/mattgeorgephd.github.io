---
layout: page
title: Publications
subtitle: 20 peer-reviewed articles in marine science and biomedicine
share-description: Peer-reviewed publications of Matthew N. George on ocean acidification, marine heatwaves, oyster triploidy, mussel attachment, and biomaterials, with DOIs and links to data and code.
---

Also on [Google Scholar](https://scholar.google.com/citations?user=UwQnG2IAAAAJ), [ORCID](https://orcid.org/0000-0003-1264-8667), and [ResearchGate](https://www.researchgate.net/profile/Matthew-George).

<p class="pub-legend"><strong>George MN</strong> = me &middot; <sup>*</sup> student co-author &middot; <i class="fab fa-github" aria-hidden="true"></i> data &amp; code links go to the public GitHub repository for the project.</p>

**Jump to:** [Marine science](#marine-science) &middot; [Biomedicine](#biomedical) &middot; [Reviews](#reviews) &middot; [In preparation](#in-preparation)

## Marine science {#marine-science}

{% include pub-list.html items=site.data.publications.marine start=1 %}

## Biomedicine {#biomedical}

{% assign n = site.data.publications.marine.size | plus: 1 %}
{% include pub-list.html items=site.data.publications.biomedical start=n %}

## Reviews {#reviews}

{% assign n = n | plus: site.data.publications.biomedical.size %}
{% include pub-list.html items=site.data.publications.reviews start=n %}

## In preparation {#in-preparation}

{% include pub-list.html items=site.data.publications.in_prep start=1 %}
