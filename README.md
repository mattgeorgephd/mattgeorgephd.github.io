# mattgeorgephd.github.io

Personal website and open lab notebook of Matthew N. George, Ph.D., published with GitHub Pages at <https://mattgeorgephd.github.io>.

Built with Jekyll and the [Beautiful Jekyll](https://beautifuljekyll.com) theme (v5.0.0, vendored in this repository; MIT license, see `LICENSE`).

## Where things live

| What | File |
|------|------|
| Navigation, footer links, colors | `_config.yml` |
| Home page | `index.html` |
| About, Research, Code & Data, CV, Teaching, Service & Outreach, In the News | `aboutme.md`, `research.md`, `code.md`, `cv.md`, `Teaching.md`, `outreach.md`, `media.md` |
| Publications (used by Publications and CV pages) | `_data/publications.yml` |
| Presentations (Presentations and CV pages) | `_data/presentations.yml` |
| Grants, fellowships, awards (Research and CV pages) | `_data/grants.yml` |
| Media coverage (In the News and CV pages) | `_data/media.yml` |
| Featured GitHub repositories (Code & Data page) | `_data/repos.yml` |
| Service and mentoring list (Service & Outreach and CV pages) | `_includes/service-list.html` |
| Site-specific styles | `assets/css/custom.css` |
| Lab notebook entries | `_posts/` (images in `post_images/`); template in `_templates/notebook-entry.md` |
| Lab notebook projects (cards on the notebook page, project box on each entry) | `_data/notebook_projects.yml` |
| Teaching evaluation PDFs | `assets/teaching-evals/` |

To add a paper, talk, grant, or news item, edit the matching file in `_data/`; the Publications, Presentations, Research, CV, and In the News pages update together.

## Lab notebook

Each entry sets `project:` to a key in `_data/notebook_projects.yml`. The notebook page groups entries by project, and each entry shows a project box and previous/next links within its project, so entries should not repeat project details or navigation links in their text. Guides use the `tutorials` tag and monthly updates the `monthly-goals` tag. Step-by-step instructions for adding an entry are in `.claude/skills/notebook-entry/SKILL.md`.

## Checks

`.github/workflows/site-checks.yml` builds the site with the same `github-pages` gem that GitHub Pages uses, fails on broken internal links, images, or anchors, and posts an external-link report to the run summary. It runs on pull requests, on pushes to `master`, and weekly. Hosts that block automated checks or need a login are listed in `.lycheeignore`.

To build locally:

```bash
BUNDLE_GEMFILE=.github/ci/Gemfile bundle install
BUNDLE_GEMFILE=.github/ci/Gemfile bundle exec jekyll serve
```
