---
layout: page
title: Presentations
subtitle: Conference talks and invited presentations
share-description: Scientific presentations by Matthew N. George on razor clams, Dungeness crab, oyster heatwave mortality, and mussel attachment.
---

{% assign years = site.data.presentations | group_by: "year" %}
{% for y in years %}
<h2 id="y{{ y.name }}">{{ y.name }}</h2>
<ul class="dated-list">
{%- for t in y.items %}
  {% include talk-item.html talk=t %}
{%- endfor %}
</ul>
{% endfor %}
