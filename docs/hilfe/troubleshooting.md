# 13 · Troubleshooting

Die häufigsten Stolperfallen und was dagegen hilft.

## Serial-Monitor & Log im Browser

Für fast jede Diagnose ist das Log der schnellste Weg:

- **Im Browser:** Stapel-Menü oben rechts → **Log** zeigt die Konsolenausgabe direkt an.
- **Seriell:** über USB mit **115200 Baud**. Die Ausführlichkeit steuert `SERIAL_LOGLEVEL`
  ([Kapitel 12](../firmware/compile-zeit.md)).

## RFID liest nicht zuverlässig

- **Abstand** Karte ↔ Leser zu groß? Näher auflegen.
- **PN5180 Debounce** erhöhen, wenn eine ruhende Karte fälschlich als „entfernt" gilt
  (Tab Allgemein → RFID-Reader, Standard 500 ms).
- **MFRC522 Gain** (0–7) höher stellen für mehr Empfindlichkeit.
- **LPCD** ist als unzuverlässig bekannt – siehe [Kapitel 10 → LPCD](../vertiefung/erweiterte-themen.md#lpcd).

## SD-Karte wird nicht erkannt

- Karte muss **FAT32** sein (nicht exFAT). Große Karten ggf. am Computer neu als FAT32
  formatieren.
- Beim Booten **rot blinkende LEDs** = SD nicht einlesbar. ESPuino bleibt in diesem Zustand, bis
  eine Karte verfügbar ist (bzw. schläft bei aktivem `SHUTDOWN_IF_SD_BOOT_FAILS`).
- Karte testweise tauschen – nicht jede (v. a. sehr billige/alte) läuft zuverlässig.

## Kein / verzerrter Sound

- **Zu leise/zu laut:** Maximal-Lautstärken im Webinterface prüfen (Tab Allgemein → Wiedergabe).
- **Verstärkung:** Auf der Complete stellt die Lötbrücke **JP2/JP3** die Verstärkung (+3 dB oder
  +15 dB) ein – nur **eine** davon setzen.
- **Mono/Stereo:** Bei nur einem Lautsprecher Mono-Wiedergabe aktivieren.
- Für Kopfhörer die **Kopfhörerplatine** verwenden (siehe [Kapitel 7](../bedienung/am-geraet.md#kopfhorer-detection-lautstarke-profile)).

## WLAN-Probleme

- ESP32 kann **nur 2,4 GHz** – ein reines 5-GHz-Netz funktioniert nicht.
- Adresse immer mit **`http://`** aufrufen (`https` wird nicht unterstützt).
- Erreichbar über IP oder – bei mDNS – `http://espuino.local` bzw. `.fritz.box`.
- Bleiben die LEDs im Leerlauf **grün** statt weiß, besteht keine WLAN-Verbindung: näher an den
  Router, neu starten oder Zugangsdaten erneut eingeben ([Erststart](../inbetriebnahme/erststart.md)).

## Bootloops & Brownouts

Meist ein **Stromversorgungsproblem**: eine zu schwache Quelle (dünnes USB-Kabel, schwaches
Netzteil, fast leerer Akku) kann beim Einschalt-/Lautstärkespitzenstrom einen Brownout-Reset
auslösen. Kräftigere Quelle / besseres Kabel probieren. Die Complete liefert über den Buck/Boost
stabile 3,3 V und schaltet bei Unterspannung ab. *(Weitere Spezialfälle: TODO aus dem Forum.)*

## Bluetooth-Modus versehentlich aktiv

Kommst du im Bluetooth-Modus nicht mehr weiter, legst du einfach eine **unbekannte RFID-Karte** auf
– das schaltet zurück in den Normal-Modus (alternativ der Button im Tab Bluetooth).

!!! tip "Noch ein Problem?"
    Frag im [Forum](https://forum.espuino.de) – am besten mit dem Log (siehe oben) und Angaben zu
    Board, Firmware-Version und was genau passiert.
