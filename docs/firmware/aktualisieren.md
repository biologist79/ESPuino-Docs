# 11 · Firmware aktualisieren

Es gibt zwei Wege ohne Kompilieren – das **Firmware-Tool im Browser** (per USB) und das **Update
über das Webinterface** (per WLAN/OTA) – sowie das **eigene Kompilieren** für Fortgeschrittene.

## Wann lohnt sich ein Update überhaupt?

*TODO: Bugfixes/neue Features vs. „läuft doch"; Blick in den [Changelog](../referenz/anhang.md#changelog).*

## Firmware-Tool im Browser (Flashen & Löschen)

Der komfortabelste Weg für den **Erst-Flash** oder eine **Wiederherstellung** (wenn das
Webinterface nicht mehr erreichbar ist): das browserbasierte
**[ESPuino Firmware Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/)** – keine
Software-Installation nötig.

<!-- Screenshot: Firmware-Tool im Browser -->

Es kann Firmware flashen (App oder komplett), den **Flash löschen** (kompletter Reset), eine
**serielle Konsole** anzeigen und eigene Firmware hochladen.

**Voraussetzung:** ein Browser mit **Web-Serial**-Unterstützung (z. B. Chrome, Edge, Opera, Brave,
Vivaldi) und eine USB-Verbindung zum ESPuino.

**Ablauf:**

1. ESPuino per **USB** anschließen.
2. Sprache und **Branch** (master/dev) wählen.
3. **Plattform** wählen (Complete, mini4L …).
4. Firmware-Build wählen und USB-Geschwindigkeit setzen (max. 460 800 Baud).
5. Aktion starten (Flashen / Löschen), bei der Abfrage den **seriellen Port** wählen.
6. Fortschritt und serielle Ausgabe beobachten.

!!! danger "Richtige Plattform wählen!"
    Die Auswahl der **falschen Plattform** kann die Hardware beschädigen. Wähle exakt dein Board.

## Update über das Webinterface (OTA)

Läuft der ESPuino und ist im WLAN, geht ein Update auch ganz ohne USB – über **Tab Updates** im
Webinterface ([Kapitel 6](../bedienung/webinterface.md#tab-updates)):

<!-- Screenshot: Tab Updates / GitHub-Update -->

- **Firmware von GitHub laden** ([Forum #4582](https://forum.espuino.de/t/firmware-update-direkt-von-github/4582)) –
  Branch (master/dev) wählen, „Nach Updates suchen", aus den letzten ~10 Builds (Datum + Commit-ID,
  Hover zeigt die Commit-Message) einen **Installieren**. **Board-Variante und Sprache** werden
  automatisch gewählt. Den Download übernimmt der **Browser** (per JavaScript), nicht der ESP32 –
  der Flash-Fortschritt läuft am Neopixel blau. Nur für Plattformen mit automatischen Builds.
- **Firmware-Update per Datei** – eine `firmware.bin` hochladen.

!!! info "Auto-Detect"
    Die **RFID-Variante** im Dateinamen spielt seit Mai 2026 **keine Rolle mehr** – RC522/PN5180
    werden automatisch erkannt.

## Selbst kompilieren

Nur nötig, wenn die vorgefertigte Firmware nicht reicht (eigene Compile-Zeit-Optionen, siehe
[Kapitel 12](compile-zeit.md)):

- Voraussetzungen: **VS Code + PlatformIO**
- Repo klonen und mit Git aktuell halten
- Build-Targets: **`complete`** und **`lolin_d32_pro_sdmmc_pe`** (mini4L)

!!! warning "Nur diese Targets werden unterstützt"
    Aktiv unterstützt sind ausschließlich **`complete`** und **`lolin_d32_pro_sdmmc_pe`** (mini4L).
    Weitere Environments in `platformio.ini` sind alt/Legacy. Der **ESP32-S3 wird nicht
    unterstützt** (kann kein klassisches Bluetooth).
