---
name: notebook-entry
description: Write and publish a new lab notebook entry (or a new notebook project) on mattgeorgephd.github.io. Use when asked to add, post, publish, or draft a notebook entry, guide, or monthly update.
---

# Publishing a lab notebook entry

The site is a Jekyll site on GitHub Pages. Notebook entries are files in `_posts/`; the
notebook home page (`notebook/index.html`) groups them by project automatically.

## 1. Gather what you need from the author

- The content (notes, Markdown, R Markdown output, or a description of the work) and any figures.
- Which project it belongs to (a key in `_data/notebook_projects.yml`), or whether it is a
  guide (`tutorials`) or a monthly update (`monthly-goals`).
- The entry date (default: today in America/Los_Angeles).

Ask only for what is missing. Do not invent results, sample sizes, or conclusions.

## 2. Create the entry

- Copy `_templates/notebook-entry.md` to `_posts/YYYY-MM-DD-short-slug.md`.
  The slug becomes the URL (`/short-slug/`); keep it short, lowercase-with-hyphens, unique, and
  never rename a published post's file (that breaks its URL).
- Front matter:
  - `title`: the date as `Ddd. Mmm. D, YYYY` (e.g. `Thu. Oct. 2, 2026`), matching the filename date.
  - `subtitle`: the topic; this is what readers see as the heading.
  - `project`: the project key (omit for guides and monthly updates).
  - `tags`: the project key, or `tutorials` / `monthly-goals`.
- Do NOT add project name, funding, species, or previous/next links to the body: the layout renders
  the project box from `_data/notebook_projects.yml` and adds previous/next links within the project.
- Figures: save to `post_images/YYYYMMDD/` (lowercase names, no spaces), compress large photos
  (about 1600 px wide, JPEG quality 85), and reference them as `/post_images/YYYYMMDD/name.jpg` with
  meaningful alt text.
- Links to files in GitHub repos: link to a specific commit (permalink) when the file may move.
- Never include passwords, default device logins, API keys, private IP addresses, internal server
  paths that are not publicly served, or personal contact details.

## 3. New project?

Add an entry to `_data/notebook_projects.yml` (title, funding, species, variables, and `repo` only if
the author wants that repository linked from the site). Order in that file is the order of the cards
on the notebook page, so put active projects first.

## 4. Check locally

```bash
BUNDLE_GEMFILE=.github/ci/Gemfile bundle install
BUNDLE_GEMFILE=.github/ci/Gemfile bundle exec jekyll build
BUNDLE_GEMFILE=.github/ci/Gemfile bundle exec ruby .github/ci/check_internal_links.rb _site
```

Both must pass. Look at the rendered entry (`_site/<slug>/index.html`) and the notebook page.

## 5. Publish via pull request

The author reviews every entry before it goes live. Never push to `master` directly.

- Commit on a branch named `notebook/YYYY-MM-DD-short-slug`.
- Open a pull request titled `Notebook: <subtitle>` with a short summary of the entry and the
  figures added.
- Wait for the `Site checks` workflow to pass; fix anything it reports. The external-link report in
  the run summary is informational.
- The entry is live about a minute after the author merges.
