# 7 · Bedienung am Gerät

!!! note "Status dieser Seite"
    Gerüst – Referenztabellen stehen im [Anhang](../referenz/anhang.md).

## Betriebsmodi

Normal, Bluetooth-Quelle (an BT-Kopfhörer/-Box senden), Bluetooth-Senke (ESPuino als BT-Lautsprecher).

!!! note "Bluetooth + WLAN"
    Bluetooth und WLAN laufen **parallel**. Der Parallelbetrieb ist allerdings **speicherknapp**
    und **ungetestet** – im Zweifel nur eines von beidem nutzen.

## Playmodi

Vollständige Liste mit Symbolen und Beschreibung:
[Webinterface → Abspielmodi](webinterface.md#abspielmodi); technische IDs:
[Anhang → Playmodi](../referenz/anhang.md#playmodi).

### Rekursive Modi & Ordnerspringen

Die **rekursiven** Abspielmodi beziehen auch **Unterordner** ein – sortiert, zufällig oder als
Hörbuch (mit Positionsspeicherung). Wie tief gesucht wird, steuert die **Rekursionstiefe** (0–4,
Standard 2; Tab Allgemein → Wiedergabe).

Nur in rekursiven Modi funktioniert das **Ordnerspringen**: „nächster Ordner" springt zum ersten
Titel des nächsten Ordners, „voriger Ordner" entsprechend zurück – anhand der alphabetischen
Ordnerreihenfolge der generierten Playlist. Beide Aktionen lassen sich im Webinterface (erweiterte
Einstellungen) auf Taster legen.

!!! warning "Hörbuch rekursiv"
    Im rekursiven Hörbuch-Modus wird die Playlist bei jedem Laden neu erzeugt. Kommen neue Ordner
    hinzu, kann sich die gemerkte Position verschieben.

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

Die Neopixel zeigen sehr viel Zustand an. Anzahl, Farbverlauf und Ausrichtung sind im Webinterface
einstellbar – die Farben unten sind die Standardwerte.

**Beim Booten**

- Hochfahren: die Hälfte der LEDs zirkuliert **orange**. Danach → Leerlauf, oder rotes Blinken bei
  SD-Fehler.

**Status / Leerlauf**

- **Leerlauf:** vier LEDs (90°-Versatz) zirkulieren – **weiß** = WLAN verbunden, **grün** = keine
  Verbindung, **orange** = WLAN wird gesucht.
- **Bluetooth aktiv:** vier LEDs (90°) zirkulieren **blau**.
- **Playlist wird erstellt (Busy):** vier LEDs (90°) **violett**, schnell rotierend.
- **OK:** alle LEDs kurz **grün** (Aktion akzeptiert). · **Fehler:** alle LEDs kurz **rot**
  (Aktion abgelehnt).
- **Ausschalten:** ein **roter** Kreis wächst, während die Encoder-Taste gehalten wird.
- **Tasten gesperrt:** Fortschritts-LEDs **rot**.

**Wiedergabe**

- **Titel-Fortschritt:** je weiter, desto mehr LEDs; Farbverlauf (Standard grün→rot, konfigurierbar).
- **Playlist-Fortschritt:** **blaue** LEDs fächern kurz zu Titelbeginn auf/zu.
- **Webstream:** zwei sehr langsam (180° versetzt) rotierende LEDs in wechselnden Regenbogenfarben.
- **Pause:** vier LEDs (90°) **orange**.
- **Lautstärke:** prozentuale Anzeige, Verlauf **grün → rot**.
- **IP-Ansage:** rotierende **gelbe** LEDs (zwei im Webradio-Modus, sonst vier).
- **Endlosschleife (Rewind):** am Playlist-Ende klappen die Fortschritts-LEDs vor dem Neustart ein.

**Batterie** *(optional)*

- **Unterspannung:** alle LEDs blinken **3× kurz rot**.
- Kurzer Druck auf den Encoder-Taster zeigt die Batteriespannung als LED-Balken.

**Übertragung**

- **MediaHub-Download** und **Firmware-Update (OTA):** **blaue** LEDs zeigen den Fortschritt (siehe
  [Kapitel 11](../firmware/aktualisieren.md)).

Vollständige Quelle: [Forum #86](https://forum.espuino.de/t/was-zeigt-der-neopixel-des-espuino-alles-an/86).

## Kopfhörer-Detection, Lautstärke-Profile

!!! tip "Empfehlung für Kopfhörer"
    Für Kopfhörer ist die kabelgebundene **Kopfhörerplatine** der zuverlässige Weg und im Zweifel
    die Empfehlung. BT-Kopfhörer (BT-Quelle) funktionieren, sind aber weniger zuverlässig – es
    wurden vereinzelt Fehler berichtet.
