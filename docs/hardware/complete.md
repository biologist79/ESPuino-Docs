# 3 · Die Complete-Platine

!!! note "Status dieser Seite"
    Teilweise befüllt – Foto, aktuelle Revision und Pinout-Details ergänzen.

## Featureübersicht

Die Complete ist die **Evolution der mini4L**: funktional weitgehend gleich, aber alles auf
**einer** Platine (außer der Kopfhörerplatine). Das senkt die Kosten und reduziert den Aufbau.

Bereits bestückt sind u. a. ESP32-WROVER, Verstärker, Laderegler, Spannungsüberwachung,
Port-Expander und SD-Slot.

## Stromversorgung

Die Complete nutzt einen **Buck/Boost-Schaltregler** und liefert dadurch **stabile 3,3 V** –
unabhängig davon, ob per **USB**, **LiPo** oder **LFP** betrieben wird und unabhängig vom
Ladezustand. Zusätzlich gibt es eine **Unterspannungs-Abschaltung**.

!!! info "Warum das wichtig ist (Delta zur mini4L)"
    Die mini4L versorgte über einen **Linearregler (LDO)**. Der hat einen Dropout: war der Akku
    fast leer (~3,3 V), kamen hinten nur noch ~3,1 V an – eigentlich zu wenig für den ESP32 (lief
    aber). LFP liegt ohnehin nur bei ~3,2–3,3 V, deshalb wurde LFP dort **am LDO vorbei**
    durchgeschleust. Der Buck/Boost der Complete löst das grundsätzlich.

## Versionen & Lieferumfang

*TODO: aktuelle Revision und Lieferumfang; gegen den aktuellen Stand prüfen.*

## Anschlüsse, Bedienelemente, Pinout

*TODO: Pinout-Tabelle (aus dem Board-Header `settings-complete.h`); siehe auch
[Anhang → Pinout](../referenz/anhang.md).*

## Komponentenwahl

- **RFID-Reader** – RC522 oder PN5180 (siehe Hinweis unten).
- **SD-Karte** – FAT32 (nicht exFAT).
- **Akku** – LiPo oder LFP (Lötbrücken entsprechend, siehe [Kapitel 4](aufbau.md)).
- **Lautsprecher**.
- **Kopfhörer** – optional über die **Kopfhörerplatine** (MS6324,
  [Forum #1099](https://forum.espuino.de/t/kopfhoererplatine-basierend-auf-ms6324-und-tda1308-bzw-lm4808m/1099)).

!!! info "RFID-Reader-Typ: Auto-Detect"
    Seit Mai 2026 ist der Reader-Typ **nicht mehr per Firmware festgelegt** – RC522 und PN5180
    werden automatisch erkannt. Die Reader-Wahl ist damit eine reine Hardware-Entscheidung.

## Bestell-Optionen & Add-ons

Optional mitbestellbar sind u. a. Kopfhörerplatine und der Drehencoder-Bausatz. Aktuelles Angebot
und Preise: [Preisliste im Forum #3344](https://forum.espuino.de/t/preisliste/3344).
