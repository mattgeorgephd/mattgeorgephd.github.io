---
layout: page
title: In the News
subtitle: Media coverage, commentary, and popular writing
share-description: Media coverage of Matthew N. George's work on Washington's coastal shellfish fisheries, triploid oysters, marine heatwaves, and mussel attachment, in The Atlantic, Hakai Magazine, Scientific American, The News Tribune, and more.
---

<p class="nb-jump"><strong>Jump to:</strong> <a href="#management">Fisheries management</a> &middot; <a href="#research">Research features</a></p>

<h2 id="management">Fisheries management</h2>
<p class="nb-note">Coverage of Washington's coastal shellfish fisheries and the work of the WDFW Coastal Shellfish Unit.</p>
<ul class="dated-list">
{%- for m in site.data.media %}{% if m.section == "management" %}
{% include media-item.html item=m %}
{%- endif %}{% endfor %}
</ul>

<h2 id="research">Research features</h2>
<ul class="dated-list">
{%- for m in site.data.media %}{% unless m.section == "management" %}
{% include media-item.html item=m %}
{%- endunless %}{% endfor %}
</ul>
