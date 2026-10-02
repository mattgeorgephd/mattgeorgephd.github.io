---
layout: page
title: In the News
subtitle: Media coverage, commentary, and popular writing
share-description: Media coverage of Matthew N. George's research on triploid oysters, marine heatwaves, and mussel attachment in Hakai Magazine, Popular Science, The Atlantic, Scientific American, and more.
---

<ul class="dated-list">
{%- for m in site.data.media %}
  <li>
    <span class="when">{{ m.date }}</span>
    <span>
      {% if m.url %}<a href="{{ m.url }}">{{ m.title }}</a>{% else %}{{ m.title }}{% endif %}
      <span class="what-sub"><em>{{ m.outlet }}</em>{% if m.note %}. {{ m.note }}{% endif %}</span>
      {%- if m.also %}
      <span class="what-sub">Also in:
        {%- for a in m.also %}
          {% if a.url %}<a href="{{ a.url }}"><em>{{ a.outlet }}</em></a>{% else %}<em>{{ a.outlet }}</em>{% endif %}{% if a.title %} ("{{ a.title }}"){% endif %}{% unless forloop.last %};{% endunless %}
        {%- endfor %}
      </span>
      {%- endif %}
    </span>
  </li>
{%- endfor %}
</ul>
