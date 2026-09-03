# 11 · Firmware aktualisieren

!!! note "Status dieser Seite"
    Gerüst – die zwei Stufen ausformulieren.

## Wann lohnt sich ein Update überhaupt?

*TODO: Bugfixes/Features vs. „läuft doch".*

## Stufe 1 — Vorgefertigte Firmware flashen

Der einfachste Weg: über **Tools → Firmware-Update** im Webinterface eine vorgefertigte Firmware
aus dem ESPuino-Firmware-Repo einspielen. Bei der Dateiwahl auf **HAL** (Board) und **BT / noBT**
achten.

!!! info "Auto-Detect"
    Die **RFID-Variante** im Dateinamen spielt seit Mai 2026 **keine Rolle mehr** – RC522/PN5180
    werden automatisch erkannt.

## Stufe 2 — Selbst kompilieren

Nur nötig, wenn Stufe 1 nicht reicht (z. B. eigene Compile-Zeit-Optionen, siehe
[Kapitel 12](compile-zeit.md)).

- Voraussetzungen: **VS Code + PlatformIO**
- Repo klonen und mit Git aktuell halten
- Build-Targets: **`complete`** und **`lolin_d32_pro_sdmmc_pe`** (mini4L)

!!! warning "Nur diese Targets werden unterstützt"
    Aktiv unterstützt sind ausschließlich **`complete`** und **`lolin_d32_pro_sdmmc_pe`** (mini4L).
    Weitere Environments in `platformio.ini` sind alt/Legacy. Der **ESP32-S3 wird nicht
    unterstützt** (kann kein klassisches Bluetooth).
