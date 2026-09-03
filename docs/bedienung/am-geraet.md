# 7 · Bedienung am Gerät

!!! note "Status dieser Seite"
    Gerüst – Referenztabellen stehen im [Anhang](../referenz/anhang.md).

## Betriebsmodi

Normal, Bluetooth-Quelle (an BT-Kopfhörer/-Box senden), Bluetooth-Senke (ESPuino als BT-Lautsprecher).

!!! warning "Bluetooth + WLAN"
    BT und WLAN lassen sich **parallel** betreiben, es wird aber **speichertechnisch eng** und der
    Betrieb ist **ungetestet, ohne Gewähr**. Als „möglich, aber nicht empfohlen" behandeln – nicht
    als Standardfall.

## Playmodi

Vollständige Liste inkl. rekursiver Modi: [Anhang → Playmodi](../referenz/anhang.md#playmodi).

## Modifikationskarten

Karten, die eine Funktion auslösen statt Musik: [Anhang → Modifikationskarten](../referenz/anhang.md#modifikationskarten).

## Buttons & Tastenkombinationen

*TODO: Standardbelegung + Mehrfach-Kombinationen; Belegung ist im Webinterface anpassbar.*

## Drehencoder

Neben Drehen (Lautstärke) und Drücken gibt es **„Button halten + Drehen"**: Solange ein Button
gehalten wird, führt Drehen dessen zugewiesene Aktion aus (z. B. Seek oder LED-Helligkeit).
Zusätzlich die **Seek-Preview-Geste** – Drehen zeigt die Zielposition per LED-Cursor an und springt
erst beim Loslassen/Stillstand.

## Neopixel-Anzeigen

Status, Wiedergabefortschritt, Batterie u. a. Farb-Referenz z. B.: MediaHub-Download = Himmelblau,
Firmware-Update (OTA) = Blau.

## Kopfhörer-Detection, Lautstärke-Profile

!!! tip "Empfehlung für Kopfhörer"
    Für Kopfhörer ist die kabelgebundene **Kopfhörerplatine** der zuverlässige Weg und im Zweifel
    die Empfehlung. BT-Kopfhörer (BT-Quelle) funktionieren, sind aber weniger zuverlässig – es
    wurden vereinzelt Fehler berichtet.
