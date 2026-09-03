# 4 · Anschließen & Einbau

!!! success "Kein SMD-Löten nötig"
    Die Complete kommt **fertig bestückt**. Die Lötbrücken sind ab Werk je nach Bestellung
    gesetzt. Du lötest nur noch ein paar Drähte an und steckst den Encoder.

Quellen: [Forum #3817 (Complete)](https://forum.espuino.de/t/espuino-complete/3817) ·
[Forum #2414 (Encoder-Bausatz)](https://forum.espuino.de/t/drehencoder-by-espuino/2414).

## Was du bekommst

Fertig bestückte Platine (ESP32-WROVER, Verstärker, Laderegler, Port-Expander, SD-Slot …).
Optionale Steckverbinder (I²C, Ext. conn2) sind bewusst unbestückt.

## Lötbrücken (Unterseite)

Ab Werk je Bestellung gesetzt – normalerweise musst du hier nichts ändern:

| Brücke | Zweck |
| --- | --- |
| JP2 / JP3 | Verstärkung (+3 dB oder +15 dB) – **nur eine** setzen |
| JP5 | nur bei LiPo (4,2 V Ladeschluss) |
| JP6 | Spannungsüberwachung (LFP vs. LiPo) |
| JP8 | Normalbetrieb RFID |

## Drähte anlöten

Verbindungen, die der Käufer selbst lötet (JST-Stecker):

- **RFID-Reader** – 10-polig
- **Lautsprecher** – 2-polig
- **Neopixel-Ring** – 3-polig
- **Buttons** – je 2-polig (bis zu fünf)

## Drehencoder

Der Encoder wird **gesteckt** (5-poliger JST-PH), kein Löten – sofern der
[ESPuino-Encoder-Bausatz](https://forum.espuino.de/t/drehencoder-by-espuino/2414) verwendet wird.

## Einbau ins Gehäuse

*TODO: Gehäuse-Varianten, Kabelführung.* SD-Karte einsetzen (**FAT32**, nicht exFAT).
