# 18 · Anhang

Nachschlage-Referenz. Die Tabellen sind aus dem Firmware-Code abgeleitet – bei Code-Änderungen
mitziehen.

## Playmodi { #playmodi }

Was die einzelnen Modi im Alltag bedeuten – mit Symbol und Beschreibung – steht in
[Kapitel 8 → Die Abspielmodi](../bedienung/webinterface.md#abspielmodi). Hier stehen nur die
technischen IDs, wie sie in MQTT-Nachrichten, in der REST-API und in `backup.txt` auftauchen.

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
| intern | 0 / 10 | `NO_PLAYLIST` / `PLAYLIST_BUSY` |

## Modifikationskarten { #modifikationskarten }

Karten, die eine Funktion auslösen statt Musik. Den vollständigen Katalog in Alltagssprache –
sortiert nach Themen – findest du in
[Kapitel 8 → Modifikationskarten](../bedienung/webinterface.md#modifikationskarten-alle-optionen).

| ID | Wirkung |
| --- | --- |
| 0 | Zuordnung dieser Karte löschen |
| 100 | Tasten + Encoder sperren |
| 101 / 102 / 103 / 104 | Sleep nach 15 / 30 / 60 / 120 min (+ LED-Dimm) |
| 105 | Sleep nach Ende des Tracks |
| 106 | Sleep nach Ende der Playlist |
| 107 | Sleep nach 5 Tracks |
| 110 / 111 | Endlosschleife Playlist / Track |
| 120 | Nachtmodus (LED-Helligkeit, optional Lautstärkegrenze) |
| 130 | WLAN an/aus |
| 140 / 141 / 142 | BT-Senke / BT-Quelle / Modus durchschalten |
| 150 | FTP-Server aktivieren |
| 151 / 152 | IP-Adresse / Uhrzeit ansagen |
| 153 | Ambient-Light umschalten |
| 154 / 155 | LED-Helligkeit + / − |

Die Aufteilung auf zwei Tabellen folgt der Art des Kommandos, nicht der Zuweisbarkeit: Fast alle
Steuer-Kommandos unten lassen sich ebenso auf eine Karte legen. Welche Aktion **nur** als Karte oder
**nur** als Taste zur Verfügung steht, steht in
[Kapitel 8 → Drehencoder & Taster](../bedienung/webinterface.md#drehencoder-taster).

## Steuer-Kommandos (Buttons / Rotary / MQTT)

Welche Taste ab Werk was tut, steht in
[Kapitel 9 → Tasten und Tastenkombinationen](../bedienung/am-geraet.md#tasten-und-tastenkombinationen);
zugewiesen werden die Kommandos in
[Kapitel 8 → Drehencoder & Taster](../bedienung/webinterface.md#drehencoder-taster).

| ID | Kommando |
| --- | --- |
| 170 | Play/Pause |
| 171 / 172 | Vorheriger / Nächster Track |
| 173 / 174 | Erster / Letzter Track |
| 175 / 176 / 177 | Lautstärke: init / + / − |
| 178 | Batteriespannung messen |
| 179 | Deep-Sleep (sofort) |
| 180 / 181 | Sprung vor / zurück (Sprungweite im Webinterface einstellbar) |
| 182 / 183 | Stop / Neustart |
| 184 / 185 | Nächster / Voriger Ordner (rekursive Modi) |
| 186 | Sprung-Vorschau (nur Drehencoder-Geste) |

## Virtuelle RFID-Karten { #virtuelle-rfid-karten }

Wozu sie gut sind und wie man sie auslöst, erklärt
[Kapitel 12 → Virtuelle RFID-Karten](../vertiefung/erweiterte-themen.md#virtuelle-rfid-karten).

IDs `241`–`250` entsprechen den Karten `900000000001` … `900000000010`.

## REST-API

Die vollständige REST-API ist als OpenAPI-Spezifikation direkt im Firmware-Repo gepflegt:
[REST-API.yaml](https://github.com/biologist79/ESPuino/blob/master/REST-API.yaml). So bleibt sie
mit dem Code synchron. *(Optional später: als interaktive Swagger-Seite ins Handbuch einbetten.)*

## Verweise auf Forum-Threads

- [Complete #3817](https://forum.espuino.de/t/espuino-complete/3817)
- [mini4L #1661](https://forum.espuino.de/t/espuino-mini-4layer/1661) · [D32-Pro-Develboard #1109](https://forum.espuino.de/t/esp32-develboard-d32-pro-lifepo4/1109)
- [Kopfhörerplatine #1099](https://forum.espuino.de/t/kopfhoererplatine-basierend-auf-ms6324-und-tda1308-bzw-lm4808m/1099) · [Träger dafür #3792](https://forum.espuino.de/t/traeger-fuer-kopfhoererplatine/3792)
- [Drehencoder-Bausatz #2414](https://forum.espuino.de/t/drehencoder-by-espuino/2414)
- [MediaHub #4607](https://forum.espuino.de/t/espuino-mediahub/4607)
- [LPCD #1664](https://forum.espuino.de/t/was-ist-lpcd-und-wie-funktioniert-es/1664)
- [Preisliste #3344](https://forum.espuino.de/t/preisliste/3344)

## Changelog { #changelog }

Der aktuelle Changelog wird im Firmware-Repo gepflegt und dort fortlaufend ergänzt:
[changelog.md im `dev`-Branch](https://github.com/biologist79/ESPuino/blob/dev/changelog.md) – passend
zu dem Stand, den dieses Handbuch beschreibt. Die Fassung im
[`master`-Branch](https://github.com/biologist79/ESPuino/blob/master/changelog.md) enthält nur das,
was bereits als Release veröffentlicht wurde.
