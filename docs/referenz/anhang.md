# 17 · Anhang

Nachschlage-Referenz. Die Tabellen sind aus dem Firmware-Code abgeleitet – bei Code-Änderungen
mitziehen.

## Pinout-Referenz Complete

Aus `settings-complete.h`. **Wichtig:** Werte **≥ 100** sind **Port-Expander-Kanäle** (PCA9555,
Kanal = Wert − 100), keine direkten ESP32-GPIOs. `99` = ungenutzt/Dummy.

| Funktion | Signal | Pin |
| --- | --- | --- |
| **Audio (I²S)** | DOUT / BCLK / LRC | GPIO 25 / 27 / 26 |
| **RFID (SPI)** | CS / SCK / MOSI / MISO | GPIO 21 / 18 / 23 / 19 |
| RFID (nur PN5180) | RST / BUSY / IRQ | GPIO 22 / 33 / 32 |
| **SD-Karte** | SD-MMC 1-Bit: CLK / CMD / D0 | GPIO 14 / 15 / 2 |
| **Drehencoder** | CLK / DT | GPIO 34 / 39 |
| Drehencoder | Taster | PE 105 |
| **Buttons** | Previous / Pause-Play / Next | PE 100 / 101 / 102 |
| Buttons | Button 4 / Button 5 | PE 103 / 104 |
| **Neopixel** | LED-Signal | GPIO 12 |
| **Power** | Peripherie-Abschaltung (`POWER`) | PE 114 |
| Power | Verstärker (`GPIO_PA_EN`) | PE 113 |
| **Batterie** | Spannungsmessung (ADC) | GPIO 35 |
| **Kopfhörer** | Buchsen-Erkennung (`HP_DETECT`) | PE 108 |
| **Wakeup / PE-Interrupt** | Aufwecken aus Deep-Sleep | GPIO 36 |
| **IR (optional)** | IR-Empfänger | GPIO 5 |

## Playmodi

| Kategorie | ID | Konstante |
| --- | --- | --- |
| Einzeltrack | 1 / 2 / 12 | `SINGLE_TRACK` / `_LOOP` / `_OF_DIR_RANDOM` |
| Hörbuch (Position speicherbar) | 3 / 4 / 16 | `AUDIOBOOK` / `_LOOP` / `_RECURSIVE` |
| Ordner sortiert | 5 / 7 / 15 | `ALL_TRACKS_OF_DIR_SORTED` / `_LOOP` / `_RECURSIVE` |
| Ordner zufällig | 6 / 9 / 17 | `ALL_TRACKS_OF_DIR_RANDOM` / `_LOOP` / `_RECURSIVE` |
| Zufalls-Unterordner | 13 / 14 | `RANDOM_SUBDIRECTORY_…` (sortiert / zufällig) |
| Webradio | 8 | `WEBSTREAM` |
| Lokale m3u | 11 | `LOCAL_M3U` |
| MediaHub | 18 | `MEDIAHUB` |
| intern | 0 / 10 | `NO_PLAYLIST` / `BUSY` |

## Modifikationskarten

Karten, die eine Funktion auslösen statt Musik.

| ID | Wirkung |
| --- | --- |
| 100 | Tasten + Encoder sperren |
| 101 / 102 / 103 / 104 | Sleep nach 15 / 30 / 60 / 120 min (+ LED-Dimm) |
| 105 | Sleep nach Ende des Tracks |
| 106 | Sleep nach Ende der Playlist |
| 107 | Sleep nach 5 Tracks |
| 110 / 111 | Endlosschleife Playlist / Track |
| 120 | LED-Nachtmodus (Helligkeit) |
| 130 | WLAN an/aus |
| 140 / 141 / 142 | BT-Senke / BT-Quelle / Modus durchschalten |
| 150 | FTP-Server aktivieren |
| 151 / 152 | IP-Adresse / Uhrzeit ansagen |
| 153 | Ambient-Light umschalten |
| 154 / 155 | LED-Helligkeit + / − |

## Steuer-Kommandos (Buttons / Rotary / MQTT)

| ID | Kommando |
| --- | --- |
| 170 | Play/Pause |
| 171 / 172 | Vorheriger / Nächster Track |
| 173 / 174 | Erster / Letzter Track |
| 175 / 176 / 177 | Lautstärke: init / + / − |
| 178 | Batteriespannung messen |
| 179 | Deep-Sleep (sofort) |
| 180 / 181 | Seek vor / zurück (`jumpOffset` s) |
| 182 / 183 | Stop / Neustart |
| 184 / 185 | Nächster / Voriger Ordner (rekursive Modi) |
| 186 | Seek-Preview (nur Rotary-Geste) |

## Virtuelle RFID-Karten

IDs `241`–`250` entsprechen den Karten `900000000001` … `900000000010`.

## MQTT-Topics

Muster: `[<base_topic>/]device_id/topic[/<setter_token>]`. Kommandos nutzen den Setter-Token
(Default `set`), Status-Topics werden ohne ihn veröffentlicht. Alle Topics **non-retained**.

| Topic | Richtung / Wertebereich | Bedeutung |
| --- | --- | --- |
| `sleep` | Cmnd `0`/`OFF`; State `ON`/`OFF` | Ausschalten / Power-State |
| `rfid` | 12 Ziffern | Karte emulieren / aktuelle Karte |
| `trackcontrol` | 1–9 | Stop/Play/Pause/Next/Prev/First/Last/Ordner± |
| `loudness` | 0…max | Lautstärke setzen/melden |
| `sleep_timer` | `EOP`/`EOT`/`EO5T`/Minuten/`0` | Sleep-Timer setzen/melden |
| `sleep_timer_state` | JSON (State) | `{mode,remainingMinutes,remainingTracks}`; mode = OFF/MINUTES/EOT/EOP/EO5T |
| `lock_controls` | `ON`/`OFF` | Bedienelemente sperren |
| `repeatmode` | 0–3 | kein / Track / Playlist / beide |
| `led_brightness` | 0–255 | Neopixel-Helligkeit |
| `ambient_light` | `ON`/`OFF` | Ambient-Light |
| `track` | State | aktueller Track |
| `cover_changed` | State | Cover evtl. geändert |
| `state` | `Online`/`Offline` | Betriebszustand |
| `ipv4` | State | IP-Adresse |
| `pauseplay` | `idle`/`play`/`pause` | Wiedergabestatus |
| `playmode` | State | numerischer Playmode |
| `wifi_rssi` | State | WLAN-Signal (dBm) |
| `software_revision` | State | Firmware-Revision |
| `battery_voltage` / `battery_soc` | State | Spannung / Ladung % (falls Batteriemessung) |

## REST-API

Die vollständige REST-API ist als OpenAPI-Spezifikation direkt im Firmware-Repo gepflegt:
[REST-API.yaml](https://github.com/biologist79/ESPuino/blob/master/REST-API.yaml). So bleibt sie
mit dem Code synchron. *(Optional später: als interaktive Swagger-Seite ins Handbuch einbetten.)*

## Verweise auf Forum-Threads

- [Complete #3817](https://forum.espuino.de/t/espuino-complete/3817)
- [mini4L #1661](https://forum.espuino.de/t/espuino-mini-4layer/1661) · [D32-Pro-Develboard #1109](https://forum.espuino.de/t/esp32-develboard-d32-pro-lifepo4/1109)
- [Kopfhörerplatine #1099](https://forum.espuino.de/t/kopfhoererplatine-basierend-auf-ms6324-und-tda1308-bzw-lm4808m/1099)
- [Drehencoder-Bausatz #2414](https://forum.espuino.de/t/drehencoder-by-espuino/2414)
- [MediaHub #4607](https://forum.espuino.de/t/espuino-mediahub/4607)
- [LPCD #1664](https://forum.espuino.de/t/was-ist-lpcd-und-wie-funktioniert-es/1664)
- [Preisliste #3344](https://forum.espuino.de/t/preisliste/3344)

## Changelog

Der aktuelle Changelog wird im Firmware-Repo gepflegt und dort fortlaufend ergänzt:
[changelog.md](https://github.com/biologist79/ESPuino/blob/master/changelog.md).
