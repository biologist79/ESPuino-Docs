# 8 · Inhalte verwalten

Wie Musik und Hörbücher auf den ESPuino kommen und wie man sie sinnvoll organisiert.

## Unterstützte Formate & Quellen

**Audioformate** (lokale Dateien auf der SD-Karte):

- **MP3**
- **AAC** (`.m4a`)
- **FLAC**
- **OPUS**
- **OGG / Vorbis**
- **WAV**

**Quellen:**

- Lokale Dateien von der **SD-Karte** (FAT32-formatiert).
- **Webradio** – eine Stream-URL (`http://…`).
- **Lokale `.m3u`-Listen** – dürfen Dateien von der SD-Karte und Webstreams beliebig mischen.

## Empfohlene Ordnerstruktur

Die meisten Abspielmodi arbeiten **ordnerweise**, deshalb lohnt eine saubere Struktur – typischerweise
**ein Ordner pro Hörbuch bzw. Album**:

```text
/Hörspiele/
  Die drei ???/
    Folge 001/
      01 - Kapitel 1.mp3
      02 - Kapitel 2.mp3
    Folge 002/
  Bibi Blocksberg/
/Musik/
  Lieblingslieder/
```

- Für den **Hörbuch-Modus** ist der Ordner die Einheit, deren **Position gemerkt** wird.
- **Rekursive Modi** beziehen Unterordner mit ein – praktisch für verschachtelte Sammlungen.
- **Zufalls-Unterordner-Modi** wählen einen zufälligen Unterordner (z. B. „irgendein Hörspiel").

!!! tip "Dateinamen für die richtige Reihenfolge"
    ESPuino sortiert **natürlich** (`01`, `02`, … `10` statt `1, 10, 2`). Nummeriere Titel am
    Anfang des Dateinamens, dann stimmt die Reihenfolge. Der Sortiermodus ist im Webinterface
    einstellbar (Tab Allgemein → Wiedergabe).

## Position bei Hörbüchern

Im **Hörbuch-Modus** wird die letzte Abspielposition gespeichert – beim nächsten Auflegen geht es
dort weiter. Gespeichert wird u. a. bei Track-Wechsel, Pause, Track-/Playlist-Ende. Ob auch bei
**Kartenwechsel** und beim **Ausschalten** gespeichert wird, ist im Webinterface einstellbar
(standardmäßig aus). Für lange Kapitel gibt es zusätzlich einen optionalen periodischen
Checkpoint gegen Stromausfall.

## Tags, Cover, Metadaten

Liefert ein Titel (oder ein Webstream) ein **Cover** mit, zeigt das Webinterface es im Tab
Steuerung an.

!!! tip "Coverart kann Ärger machen"
    Eingebettetes Coverart ist gelegentlich die Ursache, wenn eine MP3 nicht sauber spielt. Notfalls
    die Datei ohne Cover neu kodieren – siehe
    [Troubleshooting → MP3](../hilfe/troubleshooting.md#einzelne-titel-machen-probleme-mp3).

## Webradio

Für einen Sender legst du eine Karte im Modus **📻 Webradio** an und trägst die Stream-URL ein (das
Feld ist mit `http://` vorbelegt). Mehrere Sender/Titel lassen sich über eine **`.m3u`-Liste**
bündeln.

## Backup & Restore

Die Zuordnungen zwischen Karten und Inhalten liegen im **NVS** des ESP32 (nicht auf der SD-Karte).
Damit bei einem Defekt nichts verloren geht:

- Im SD-Hauptverzeichnis hält ESPuino automatisch eine **`backup.txt`** aktuell – bei **jeder**
  neuen Zuweisung. Der Dateiname ist über `backupFile` in der `settings.h` änderbar.
- Über **Tab Tools** lassen sich die Zuweisungen **exportieren** und wieder **importieren**. Der
  Import **ergänzt/überschreibt nur, löscht nichts** – so überträgst du ein Backup auch von einem
  ESPuino auf einen anderen. Details: [Kapitel 6 → Tab Tools](../bedienung/webinterface.md#tab-tools).

!!! tip "Exakt definierten Stand herstellen"
    Sollen am Ende *genau* die Einträge des Backups vorhanden sein: erst **Alle Zuweisungen
    löschen** (Tab Tools), dann importieren. Andere Einstellungen bleiben erhalten.

Exportiere regelmäßig ein Backup und bewahre es außerhalb der SD-Karte auf. Mehr:
[Forum #508](https://forum.espuino.de/t/die-backupfunktion-des-espuino/508).
