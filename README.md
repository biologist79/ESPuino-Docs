# ESPuino Handbook

Source of the ESPuino handbook, built with [MkDocs](https://www.mkdocs.org/) +
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/). The goal is to gather the
scattered forum documentation in one place. It focuses on the **Complete** board, with the
**mini4L** covered only as a delta.

**📖 Read it online: <https://biologist79.github.io/ESPuino-Docs/>**

## Build locally

```bash
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate
pip install -r requirements.txt
mkdocs serve                     # http://127.0.0.1:8000
```

`mkdocs build --strict` builds the static site into `site/` (this is how CI builds it).

## Publishing

The workflow [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml) builds on every push
to `main` and deploys to GitHub Pages. After the first push, go to **Settings → Pages** in the
repository settings and set the source to **GitHub Actions**.

Self-hosting: `site/` is plain static HTML and can be served by any web server.

## Structure

The navigation is defined in `mkdocs.yml` (9 parts, 17 chapters). Each chapter is a Markdown file
under `docs/`. The reference tables (play modes, modification cards, MQTT topics, `settings.h`
migration) in the [appendix](docs/referenz/anhang.md) are derived from the firmware code and should
be kept in sync when it changes.
