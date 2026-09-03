# 15 · Entwicklung & Beitrag

!!! note "Status dieser Seite"
    Gerüst – Teile existieren in der README des ESPuino-Repos.

## Projektstruktur
*TODO: grober Überblick der `src/`-Module.*

## Eigene Boards definieren
`HAL 99` → `settings-custom.h`; Pins und Feature-Flags dort setzen. *TODO.*

## Coding-Konventionen, PRs, CI
- Formatierung mit `clang-format` (`.clang-format` im Repo).
- Features branchen von `dev`, PRs gegen `dev`; `master` bekommt periodische Release-Merges.
- CI baut die Firmware; siehe `.github/workflows/`.

*TODO: aus der Repo-README übernehmen/verlinken.*
