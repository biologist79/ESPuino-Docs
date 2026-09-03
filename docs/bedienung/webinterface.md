# 6 · Das Webinterface

Über das Webinterface konfigurierst und steuerst du praktisch alles – vom Zuweisen der
RFID-Karten über WLAN bis zum Firmware-Update.

Du erreichst es im Browser über die IP-Adresse des ESPuino oder – bei aktivem mDNS (Standard) –
über `http://espuino.local` bzw. den vergebenen Hostnamen. Ist noch kein WLAN konfiguriert, öffnet
ESPuino einen Access-Point (Standard-Name `ESPuino`) mit einer Einrichtungsseite (siehe
[Erststart](../inbetriebnahme/erststart.md)).

## Überall gültig

- **Herz-Symbol** oben rechts: Verbindungsanzeige. Grün (pulsierend) = Verbindung steht, rot =
  unterbrochen, wird automatisch neu verbunden.
- **Fragezeichen** neben Feldern: kurzer Hilfetext zur jeweiligen Einstellung.
- **Stapel-Symbol** oben rechts: Menü mit Sprachauswahl (DE/EN/FR), **Dunkelmodus**,
  **Information** (Firmware-Stand, Speicher, Batterie), **Log** (Konsole im Browser), **Neustart**
  und **Ausschalten**.
- Gespeichert wird **pro Bereich** über den jeweiligen Button; die Beschriftung sagt, was
  gespeichert wird.

## Tab Steuerung

Die Fernbedienung im Browser:

- Cover und Titelinfo (sofern vorhanden), Transport-Buttons (erster/voriger/Play-Pause/nächster/letzter).
- **Lautstärke-Slider** (wirkt sofort) und **Equalizer** (Bass/Mitten/Höhen).
- **Fortschrittsbalken** – anklickbar, springt zur angeklickten Position.
- **Modifikation ausführen** – jede Modifikation direkt auslösen, ohne Karte (gleicher Katalog wie
  die [Modifikationskarten](#modifikationskarten-alle-optionen)).

## Tab RFID

<!-- Screenshot: RFID-Tab -->

Das Herzstück: hier verknüpfst du Karten mit Inhalten. Zwei Bereiche.

### Dateien

Dateibrowser der SD-Karte: **Suchfeld**, **Upload** einzelner Dateien oder ganzer Verzeichnisse
(inkl. Unterordner, mit Fortschritt), sowie ein Kontextmenü (Rechtsklick / langes Drücken): Ordner
anlegen, abspielen, aktualisieren, umbenennen, löschen, herunterladen.

### RFID-Zuweisung

1. **RFID-Chip-Nummer** – wird beim Auflegen automatisch gefüllt; alternativ 12-stellig von Hand
   oder als [virtuelle Karte](https://forum.espuino.de/t/virtual-rfid-cards).
2. Reiter **Musik** – Datei/Ordner im Browser wählen und **Abspielmodus** festlegen (siehe
   Tabelle). Komfort: bei *Webradio* wird das Pfad-Feld mit `http://` vorbelegt.
3. Reiter **Modifikation** – statt Musik eine Aktion zuweisen (siehe unten).
4. **Zuweisung speichern**.

#### Abspielmodi

In Dropdown-Reihenfolge. (Technische IDs/Konstanten: [Anhang → Playmodi](../referenz/anhang.md#playmodi).)

| Modus | Bedeutung |
| --- | --- |
| 🎵 Einzelner Titel | Genau eine Datei, einmal. |
| 🎵🔁 Einzelner Titel (Endlosschleife) | Eine Datei dauerhaft wiederholen. |
| 🎲💤 Zufälliger Titel eines Ordners, danach schlafen | Ein zufälliger Titel, danach Deep Sleep – ideale Einschlaf-Karte. |
| 📖 Hörbuch | Titel eines Ordners sortiert; **letzte Position wird gemerkt**. |
| 📚 Hörbuch rekursiv | Wie Hörbuch, inkl. Unterordner; Position wird gemerkt. |
| 📖🔁 Hörbuch (Endlosschleife) | Hörbuch, beginnt nach dem letzten Titel neu. |
| 📁 Alle Titel (sortiert) | Ordner sortiert, **ohne** Positionsspeicherung. |
| 🌳 Alle Titel + Unterordner (rekursiv, sortiert) | Wie oben inkl. Unterordner, ohne Positionsspeicherung. |
| 📁🔀 Alle Titel (zufällig) | Ordner in zufälliger Reihenfolge. |
| 🌳🔀 Alle Titel + Unterordner (rekursiv, zufällig) | Zufällig über Ordner und Unterordner. |
| 📁🔁 Alle Titel (sortiert, Endlosschleife) | Sortiert, endlos. |
| 📁🔀🔁 Alle Titel (zufällig, Endlosschleife) | Zufällig, endlos. |
| 🎲📁 Zufälliger Unterordner (sortiert) | Ein zufälliger Unterordner, sortiert. |
| 🎲📁🔀 Zufälliger Unterordner (zufällig) | Ein zufälliger Unterordner, zufällig. |
| 📻 Webradio | Stream-URL statt Datei (Pfad-Feld mit `http://` vorbelegt). |
| 📃 Liste (.m3u) | Einträge einer lokalen `.m3u` – Dateien und Webstreams gemischt. |

### Modifikationskarten — alle Optionen

Statt Musik lässt sich einer Karte eine Aktion zuordnen (oder im Tab Steuerung direkt auslösen).
Technische IDs: [Anhang → Modifikationskarten](../referenz/anhang.md#modifikationskarten).

**Sperren & Schlafen:** 🔒 Tastensperre · 💤 Schlafe sofort · 💤 Schlafen nach 15 min / 30 min /
1 h / 2 h (LEDs gedimmt) · 💤 Schlafen nach Ende des Titels · 💤 Schlafen nach Ende der Playlist.

**Wiederholung:** 🔁 Playlist endlos · 🔂 Titel endlos.

**Licht, Funk & Dienste:** 🌙 LEDs dimmen (Nachtmodus) · 📶 WLAN an/aus · 💡 Ambient Light ·
📁 FTP aktivieren · 🔊 BT-Lautsprecher · 🎧 BT-Kopfhörer · 🔀 Modus wechseln *(BT nur bei
Firmware mit Bluetooth)*.

**Ansagen:** 🌐 IP-Adresse ansagen · 🕒 Uhrzeit ansagen.

**Wiedergabesteuerung als Karte:** ⏯ Play/Pause · ⏮/⏭ Titel zurück/vor · ⏪/⏩ erster/letzter Titel ·
📁 Ordner vor/zurück (nur rekursive Modi) · »/« Sekunden vor/zurück (`jumpOffset`).

**Virtuelle Karten & Sonstiges:** 🏷 Virtuelle Karte 01–10 · 🗑 Zuordnung löschen (weist du *das*
einer Karte zu, wird ihre Zuordnung gelöscht).

## Tab WLAN

<!-- Screenshot: WLAN-Tab -->

- **WLAN-Einstellungen** – „Start mit bestem WLAN" (stärkstes von mehreren), **Hostname**, sowie
  Name/Passwort/Timeout des **Access-Points**.
- **Netzwerke** – mehrere WLANs speicherbar (praktisch für unterwegs); optional pro Netzwerk eine
  **statische IP**.
- **Gespeicherte Netzwerke** – Liste, das verbundene ist hervorgehoben; löschen per Mülleimer.

!!! warning "Vorsicht"
    Access-Point-Timeout **0** = schließt nie automatisch (Sicherheitsrisiko). Statische IP nur
    nutzen, wenn du weißt was du tust – sonst ist ESPuino evtl. nicht mehr erreichbar.

## Tab MQTT

*Nur bei Firmware mit MQTT.* <!-- Screenshot: MQTT-Tab -->

Anbindung an den MQTT-Broker (z. B. Home Assistant): aktivieren, ClientId, Basis-Topic (optional),
Geräte-ID, Server, Benutzer/Passwort (optional), Port. In ClientId und Geräte-ID ersetzt der
Platzhalter `<MAC>` automatisch die MAC-Adresse. Darunter eine **Live-Vorschau der Topics**.
Topic-Referenz: [Anhang → MQTT](../referenz/anhang.md#mqtt-topics).

!!! warning "Neustart nötig"
    Änderungen an den MQTT-Einstellungen greifen erst nach Neustart (wird nach dem Speichern
    angeboten).

## Tab FTP

*Nur bei Firmware mit FTP.* <!-- Screenshot: FTP-Tab -->

Benutzer/Passwort für FTP. Der Server läuft aus Speichergründen nicht permanent: bei Bedarf über
**FTP-Server starten** (oder am Gerät Pause + Next) aktivieren; nach dem nächsten Neustart wieder
aus.

!!! tip
    Für größere Datenmengen ist FTP schneller als der Web-Upload. Zeichenkodierung **CP437**
    einstellen, damit Umlaute korrekt ankommen.

## Tab Bluetooth

*Nur bei Firmware mit Bluetooth.* <!-- Screenshot: Bluetooth-Tab -->

- **Bluetooth-Kopfhörer** (ESPuino sendet): Kopfhörer-Namen eintragen oder **Geräte suchen** und
  aus der Liste übernehmen; optionales PIN-Feld. Dann **Kopfhörer-Modus starten**.
- **Bluetooth-Lautsprecher** (ESPuino empfängt): ESPuino wird zur BT-Box.

Im BT-Modus zeigt der Tab einen Button zurück in den Normal-Modus (alternativ eine unbekannte
RFID-Karte auflegen).

!!! note "BT und WLAN"
    Bluetooth und WLAN laufen **parallel**. Der Parallelbetrieb ist allerdings speicherknapp und
    ungetestet – siehe [Kapitel 7 → Betriebsmodi](am-geraet.md#betriebsmodi).

## Tab Allgemein

<!-- Screenshot: Allgemein-Tab -->

Fünf Unterkladden, **jede mit eigenen Speichern/Reset-Buttons**.

### Wiedergabe

- **Lautstärke** – Start- und Maximal-Lautstärke, getrennt für Lautsprecher und Kopfhörer (plus
  Minimal-Lautstärke).
- **Optionen** (je mit Hilfetext): Position beim Ausschalten/Kartenwechsel merken · letzte Karte
  nach Neustart abspielen · Pause bei entfernter Karte (nur PN5180) · gleiche Karte nicht erneut
  akzeptieren (optional: Pause→Play beim erneuten Auflegen) · Pause bei minimaler Lautstärke ·
  letzte Lautstärke wiederherstellen · Mono-Wiedergabe · Lautstärkekurve (linear/logarithmisch).
- **Wiedergabeliste** – Sortiermodus und maximale Rekursionstiefe.

### RFID-Reader

<!-- Screenshot: RFID-Reader -->

- **PN5180 LPCD aktivieren** – Aufwecken durch Kartenauflegen (nur PN5180, Lötbrücken; bei MFRC522
  ausgegraut). Einordnung/Einschränkungen: [Kapitel 10 → LPCD](../vertiefung/erweiterte-themen.md#lpcd).
- **Reader-Typ** – *Auto-detect* (Standard), MFRC522 (SPI), MFRC522 (I²C) oder PN5180. Erkennung
  zur Laufzeit, ohne Firmware-Neubau.
- **MFRC522 Gain** – Empfindlichkeit (0–7, Standard 7).
- **PN5180 Debounce** – wie lange eine Karte ununterbrochen *nicht* erkannt sein muss, bevor sie
  als entfernt gilt (Standard 500 ms).

!!! warning "Neustart nötig"
    Änderungen in dieser Unterkladde greifen erst nach Neustart.

### Drehencoder & Taster

<!-- Screenshot: Drehencoder & Taster -->

Legt fest, was die Bedienelemente tun. Alles hier landet im NVS und **überschreibt die
Firmware-Standardbelegung** – die komplette Belegung ist also ohne Firmware-Neubau anpassbar
(Standardbelegung: siehe [Kapitel 7 → Buttons](am-geraet.md#buttons-tastenkombinationen)).

- **Drehimpulsgeber** – steuert die Lautstärke; einzige Option: **Drehrichtung umkehren**.
- **Taster-Zuordnungen** – Tabelle mit je einer Zeile pro Taster (Btn0–Btn5) und Spalten für
  **kurzen**/**langen** Druck; `--` = keine Aktion. Btn0 = Next, Btn1 = Prev, Btn2 = Play/Pause,
  Btn3 = Drehencoder-Taster, Btn4/5 = frei. Nicht vorhandene Taster einfach auf `--` lassen.
- **Multi-Taster** – Aktionen auf gleichzeitig gedrückte Paare (`0+1` … `4+5`), je **eine** Aktion.
- **Auswahl** – im Wesentlichen der Modifikationskarten-Katalog, plus nur-für-Taster-Aktionen:
  🔊 Lauter / 🔉 Leiser / 🔈 Initiale Lautstärke · 🔋 Batteriespannung · ⏹ Stop · 🔄 Neustart ·
  💤 Schlafen nach fünf Titeln · 📊 Taskauslastung (Debug). Die Karten-Aktion „🗑 Zuordnung löschen"
  fehlt hier (ergibt nur beim Beschreiben einer Karte Sinn).

### LED

<!-- Screenshot: LED -->

- **Helligkeit** – nach dem Einschalten, im Nachtmodus, im Ambient-Light-Modus.
- **LED-Einstellungen** – Anzahl Anzeige-/Kontroll-LEDs (Kontroll-LEDs mit Farbe pro LED), Punkte
  im Leerlauf, Fortschritts-Farbverlauf (Farbton Start/Ende), Atmolight-Farbton/-Sättigung,
  dimmbare Zwischenstufen, Start-LED-Offset, Pause-Zentrierung, Laufrichtung.

!!! warning
    Eine geänderte LED-Anzahl übernimmt ESPuino per automatischem Neustart.

### Energie

<!-- Screenshot: Energie -->

- **Deep Sleep** – Inaktivitätszeit bis zum Schlafen.
- **Batterie** *(nur bei aktiver Batteriemessung)* – Warnspannung, Spannungen für 0 %/100 %,
  optional kritische Abschaltspannung, Messintervall.

## Tab Updates

<!-- Screenshot: Updates -->

- **Firmware-Update (Datei)** – `firmware.bin` wählen, **Firmware hochladen**, danach automatischer
  Neustart.
- **Firmware von GitHub laden** – holt fertige Builds direkt aus dem
  [ESPuino-Firmware-Repo](https://github.com/biologist79/ESPuino-Firmware): Branch (**dev**/**master**)
  wählen, **Nach Updates suchen**, letzte 10 Builds mit Datum/Commit-ID, **Installieren** – Board-
  Variante und Sprache werden automatisch gewählt, Fortschritt am LED-Ring. Siehe
  [Kapitel 11](../firmware/aktualisieren.md).

*(Der GitHub-Bereich erscheint nur bei OTA-fähiger Firmware.)*

## Tab Tools

<!-- Screenshot: Tools -->

Rund um die gespeicherten RFID-Zuweisungen (liegen im **NVS**, nicht auf der SD-Karte):

- **Zuweisungen anzeigen** – scrollbares Fenster, Einträge einzeln löschbar.
- **Zuweisungen exportieren** – lädt `backup.txt` (wird zusätzlich bei jeder Zuweisung automatisch
  auf die SD-Karte geschrieben). Regelmäßig machen!
- **Zuweisungen importieren** – spielt ein Backup ein; ergänzt/überschreibt nur, löscht nichts.
- **Alle Zuweisungen löschen** ⚠️ – entfernt sämtliche Zuweisungen aus dem NVS (mit Rückfrage).

## Tab Hilfe

<!-- Screenshot: Hilfe -->

Verweise auf das [Forum](https://forum.espuino.de) und die REST-API-Dokumentation (Swagger) – zum
Skripten oder Einbinden in die Hausautomatisierung.
