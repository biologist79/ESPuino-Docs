# ESPuino-Handbuch

Quelltext des ESPuino-Handbuchs, gebaut mit [MkDocs](https://www.mkdocs.org/) +
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/). Ziel: die verstreute
Forum-Dokumentation an einem Ort bündeln. Fokus auf die **Complete**-Platine, die **mini4L**
nur als Delta.

## Lokal bauen

```bash
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate
pip install -r requirements.txt
mkdocs serve                     # http://127.0.0.1:8000
```

`mkdocs build --strict` erzeugt die statische Site nach `site/` (im CI so gebaut).

## Veröffentlichen

Der Workflow [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml) baut bei jedem Push
auf `main` und deployt nach GitHub Pages. Nach dem ersten Push in den Repo-Einstellungen unter
**Settings → Pages** die Quelle auf **GitHub Actions** stellen.

Selbst-Hosting: `site/` ist reines statisches HTML und kann von jedem Webserver ausgeliefert werden.

## Struktur

Die Navigation ist in `mkdocs.yml` definiert (9 Teile, 16 Kapitel). Jedes Kapitel liegt als
Markdown-Datei unter `docs/`. Referenz-Tabellen (Playmodi, Modifikationskarten, MQTT-Topics,
`settings.h`-Migration) im [Anhang](docs/referenz/anhang.md) sind aus dem Firmware-Code abgeleitet
und sollten bei Änderungen dort mitgezogen werden.
