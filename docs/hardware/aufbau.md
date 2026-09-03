# 4 · Anschließen & Einbau

!!! success "Kein SMD-Löten nötig"
    Die Complete kommt **fertig bestückt**. Die Lötbrücken sind ab Werk je nach Bestellung
    gesetzt. Du lötest nur noch ein paar Drähte an und steckst den Encoder.

Quellen: [Aufbau-Tutorial #3863](https://forum.espuino.de/t/tutorial-aufbau-complete-platine-samt-inbetriebnahme-und-tipps/3863)
· [Complete #3817](https://forum.espuino.de/t/espuino-complete/3817)
· [Encoder-Bausatz #2414](https://forum.espuino.de/t/drehencoder-by-espuino/2414).

!!! danger "Zwei Dinge, die das Board zerstören können"
    - **Akku-Polung prüfen!** Bei LFP-Akkus (u. a. von Eremit) gab es zwischenzeitlich eine
      **vertauschte Polarität**. Prüfe **unbedingt** vor dem Anschließen, ob die Polung deines
      Akkus zum Platinenaufdruck passt.
    - **Nie auf die Kabelfarben verlassen** – immer den **Platinenaufdruck** prüfen. Besonders beim
      **Neopixel**: vertauschte Polarität führt zu einem Kurzschluss, der im schlimmsten Fall das
      Board zerstört.

## Was du bekommst

Fertig bestückte Platine (ESP32-WROVER, Verstärker, Laderegler, Spannungsüberwachung,
Port-Expander, SD-Slot …). Optionale Steckverbinder (I²C, Ext. conn2) sind bewusst unbestückt.

## Lötbrücken (Rückseite)

Ab Werk je Bestellung gesetzt – normalerweise musst du hier nichts ändern:

| Brücke | Zweck |
| --- | --- |
| JP2 / JP3 | Lautsprecher-Verstärkung (+3 dB / +15 dB) – nur **eine** setzen |
| JP5 / JP6 | Akku-Typ (LiPo / LFP) |
| JP8 | RFID-Stromversorgung – **muss** gesetzt sein (1+2 oder 2+3) |
| JP1 | nur für **PN5180 mit LPCD** |

## Drähte anlöten

Verbindungen, die der Käufer selbst lötet (JST-Stecker) – **immer nach Platinenaufdruck**, nicht
nach Kabelfarbe:

- **RFID-Reader** – **RC522** braucht nicht alle Adern (ungenutzte isolieren); **PN5180** braucht
  alle.
- **Lautsprecher** – 2-polig.
- **Neopixel** (Ring, Reihe oder einzelne LED) – 3-polig (GND, 5 V, Daten). ⚠️ Polung beachten!
- **Buttons** – je 2-polig.
- **Kopfhörerplatine** (optional) – in den 6-poligen Anschluss stecken.

## Drehencoder

Der Encoder wird **gesteckt** (5-poliger JST-PH), kein Löten – sofern der
[ESPuino-Encoder-Bausatz](https://forum.espuino.de/t/drehencoder-by-espuino/2414) verwendet wird.
Die Drehrichtung lässt sich später im Webinterface umkehren.

## Einbau ins Gehäuse

*TODO: Gehäuse-Varianten, Kabelführung.* SD-Karte einsetzen: **FAT32** (Karten > 32 GB sind ab
Werk oft exFAT und müssen neu als FAT32 formatiert werden).

## Nach dem Zusammenbau: Feinjustierung

Beim ersten Start ([Kapitel 5](../inbetriebnahme/erststart.md)) im Webinterface an die Hardware
anpassen:

- **Batterie-Spannungsschwellen** je Akkutyp (Tab Allgemein → Energie), z. B.:

    | Akku | Warnung | 1 LED | alle LEDs |
    | --- | --- | --- | --- |
    | **LFP** | 3,0 V | 2,9 V | 3,25 V |
    | **LiPo** | 3,2 V | 3,1 V | 4,2 V |

- **Spannungsmessung kalibrieren:** meldet der ESPuino bei vollem Akku „nicht voll", die
  gemessene Spannung mit einem Multimeter vergleichen und die Differenz über `offsetVoltage` in
  `settings-complete.h` korrigieren (siehe [Kapitel 12](../firmware/compile-zeit.md#werte-nur-per-settingsh-kein-webinterface)).
- **Neopixel-Drehrichtung**, **Drehencoder-Richtung**, **Button-Funktionen** und **RFID-Karten**
  nach Bedarf einstellen.
