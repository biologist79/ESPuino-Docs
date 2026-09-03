# 1 · Was ist ESPuino?

!!! note "Status dieser Seite"
    Gerüst – Inhalt aus dem Forum zu migrieren bzw. neu zu schreiben.

## Überblick & Einsatzzweck

ESPuino ist ein RFID-gesteuerter Audio-Player: Karte auflegen → Musik/Hörbuch startet. Gedacht
vor allem als robuste Audiobox für Kinder, aber ebenso für alle, die eine einfache, offline
funktionierende Musikbox wollen.

*TODO: Kurzbeschreibung, ein Foto der Complete.*

## Das ESPuino-Ökosystem

- **[ESPuino](https://github.com/biologist79/ESPuino)** – die Firmware (dieses Handbuch beschreibt sie).
- **ESPuino-Firmware** – vorgefertigte Firmware-Builds zum Flashen über das Webinterface.
- **[MediaHub](https://github.com/biologist79/ESPuino-Mediahub)** – optionale zentrale Kartenverwaltung (siehe [Kapitel 9](../inhalte/mediahub.md)).
- **[Forum](https://forum.espuino.de)** – Diskussion, Ankündigungen, Support.

## Die Entwicklungslinie

Frühe Eigenbauten → Streifenrasterplatinen → Carrier-PCBs → **mini4L** → **Complete**. Funktional
bietet die Complete gegenüber der mini4L nichts grundsätzlich Neues, integriert aber alles (außer
der Kopfhörerplatine) auf einer Platine: günstiger und weniger Aufbau.

## Glossar

| Begriff | Bedeutung |
| --- | --- |
| RFID | Kontaktlose Karte/Tag, mit der Inhalte gestartet werden |
| NVS | Non-Volatile Storage – der Einstellungs-/Zuweisungsspeicher im ESP32 |
| HAL | Hardware-Abstraction-Layer – wählt das Board (Pins etc.) beim Kompilieren |
| Neopixel | Adressierbarer LED-Ring zur Status-/Fortschrittsanzeige |
| Deep-Sleep | Stromsparender Ruhezustand des ESP32 |
| Playmode | Abspielmodus einer Karte (Einzeltrack, Hörbuch, Ordner …) |
| Modifikationskarte | RFID-Karte, die eine Funktion auslöst statt Musik (z. B. Sleep-Timer) |
