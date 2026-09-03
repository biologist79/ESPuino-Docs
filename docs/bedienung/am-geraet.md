# 7 · Bedienung am Gerät

!!! note "Status dieser Seite"
    Gerüst – Referenztabellen stehen im [Anhang](../referenz/anhang.md).

## Betriebsmodi

Normal, Bluetooth-Quelle (an BT-Kopfhörer/-Box senden), Bluetooth-Senke (ESPuino als BT-Lautsprecher).

!!! note "Bluetooth + WLAN"
    Bluetooth und WLAN laufen **parallel**. Der Parallelbetrieb ist allerdings **speicherknapp**
    und **ungetestet** – im Zweifel nur eines von beidem nutzen.

## Playmodi

Vollständige Liste inkl. rekursiver Modi: [Anhang → Playmodi](../referenz/anhang.md#playmodi).

## Modifikationskarten

Karten, die eine Funktion auslösen statt Musik: [Anhang → Modifikationskarten](../referenz/anhang.md#modifikationskarten).

## Buttons & Tastenkombinationen

Die folgende Belegung ist der **Auslieferungs-Standard** – im Webinterface (dynamisches
Button-Layout) frei änderbar. Physische Zuordnung auf der Complete: **Button 0 = Next**,
**1 = Previous**, **2 = Play/Pause**, **3 = Drehencoder-Taster**, **4/5 = optionale Buttons**.

### Kurzer / langer Druck

| Button | Kurz | Lang |
| --- | --- | --- |
| 0 · Next | Nächster Track | Letzter Track |
| 1 · Previous | Voriger Track | Erster Track |
| 2 · Play/Pause | Play/Pause | Play/Pause |
| 3 · Encoder-Taster | Batteriespannung messen | Deep-Sleep |
| 4 (optional) | Seek zurück | Lautstärke + |
| 5 (optional) | Seek vor | Lautstärke − |

### Halten + drehen (Drehencoder-Geste)

| gehaltener Button | Drehen |
| --- | --- |
| 0 · Next | Seek vor / zurück im Track |
| 2 · Play/Pause | LED-Helligkeit + / − |

(Übrige Buttons: standardmäßig keine Halten-Aktion.)

### Tastenkombinationen (gleichzeitig drücken)

| Kombination | Aktion |
| --- | --- |
| Next + Play/Pause | FTP-Server aktivieren |
| Previous + Play/Pause | IP-Adresse ansagen |

!!! note "WLAN-Toggle bewusst deaktiviert"
    Die Kombination Next + Previous würde WLAN umschalten, ist per Default aber **aus** – damit
    Kinder das WLAN nicht versehentlich abschalten.

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
