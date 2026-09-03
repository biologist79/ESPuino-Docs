# 8 · Inhalte verwalten

Ein ESPuino ist nur so gut wie das, was auf seiner SD-Karte liegt. Dieses Kapitel dreht sich deshalb
darum, wie du deine Musik und Hörbücher auf das Gerät bekommst und – mindestens genauso wichtig – wie
du sie so organisierst, dass die Abspielmodi später genau das tun, was du erwartest. Ein bisschen
Ordnung am Anfang erspart dir später viel Sucherei.

## Welche Formate und Quellen funktionieren

ESPuino spielt die gängigen Audioformate direkt von der SD-Karte ab. Konkret sind das **MP3**,
**AAC** (also `.m4a`), **FLAC**, **OPUS**, **OGG/Vorbis** und **WAV**. Für die allermeisten
Sammlungen ist damit alles abgedeckt; MP3 ist der Klassiker, verlustfreie Formate wie FLAC gehen
ebenso.

Neben lokalen Dateien kennt ESPuino noch zwei weitere Quellen. Zum einen **Webradio**: Hier gibst du
statt einer Datei eine Stream-Adresse (`http://…`) an, und ESPuino spielt den Sender ab, solange er
im WLAN ist. Zum anderen **lokale `.m3u`-Listen** – einfache Textdateien, die eine Reihe von Titeln
auflisten. Praktisch daran: Eine solche Liste darf Dateien von der SD-Karte und Webstreams **bunt
mischen**.

## Eine sinnvolle Ordnerstruktur

Der wichtigste Gedanke bei der Ablage: Die meisten Abspielmodi arbeiten **ordnerweise**. Ein Ordner
ist also die natürliche Einheit für ein Hörbuch, ein Hörspiel oder ein Album. Es lohnt sich deshalb,
gleich von Anfang an sauber pro Titel bzw. pro Werk einen eigenen Ordner anzulegen. Eine bewährte
Struktur sieht zum Beispiel so aus:

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

Warum diese Sorgfalt? Weil die Ordnerstruktur direkt bestimmt, was eine Karte abspielen kann. Im
**Hörbuch-Modus** ist der Ordner die Einheit, für die sich ESPuino die zuletzt gehörte Position
merkt. Die **rekursiven Modi** beziehen zusätzlich alle Unterordner mit ein – ideal für verschachtelte
Sammlungen. Und es gibt sogar Modi, die einen **zufälligen Unterordner** auswählen, sodass eine
einzige Karte für „irgendein Hörspiel aus der Sammlung" stehen kann.

!!! tip "Dateinamen mit führender Nummer"
    ESPuino sortiert **natürlich** – das heißt, `1, 2, 10` landen in genau dieser Reihenfolge und
    nicht als `1, 10, 2`. Nummerierst du deine Titel am Anfang des Dateinamens (`01 - …`, `02 - …`),
    stimmt die Reihenfolge zuverlässig. Den Sortiermodus selbst kannst du im Webinterface anpassen
    (Tab Allgemein → Wiedergabe).

## Wie ESPuino sich bei Hörbüchern die Position merkt

Der Hörbuch-Modus ist der Grund, warum viele überhaupt zu ESPuino greifen, deshalb ein eigener
Absatz dazu. In diesem Modus speichert ESPuino die zuletzt gehörte Stelle, sodass beim nächsten
Auflegen der Karte genau dort weitergeht, wo zuletzt Schluss war. Gespeichert wird an den sinnvollen
Momenten – beim Wechsel des Titels, beim Pausieren, am Ende eines Titels oder der Playlist.

Zwei Fälle sind standardmäßig **abgeschaltet**, lassen sich aber im Webinterface einschalten: das
Speichern beim **Wechsel auf eine andere Karte** und das Speichern beim **Ausschalten**. Und für
sehr lange Kapitel gibt es zusätzlich einen optionalen Checkpoint, der die Position in Abständen
sichert – als Schutz davor, bei einem plötzlichen Stromausfall den Fortschritt einer ganzen Stunde
zu verlieren.

## Cover und Metadaten

Bringt ein Titel (oder ein Webstream) ein eingebettetes **Cover** mit, zeigt das Webinterface es im
Tab Steuerung an. Für die Wiedergabe selbst spielt das keine Rolle – es ist reine Kosmetik auf dem
Bildschirm.

!!! tip "Wenn Coverart Ärger macht"
    Ausgerechnet eingebettetes Coverart ist gelegentlich die Ursache, wenn eine einzelne MP3 nicht
    sauber spielt oder stottert. Falls dir so eine Datei begegnet, hilft meist ein sauberes
    Neu-Kodieren ohne Cover – wie das mit ffmpeg geht, steht in
    [Kapitel 13 → MP3](../hilfe/troubleshooting.md#einzelne-titel-machen-probleme-mp3).

## Webradio

Einen Radiosender richtest du ein, indem du einer Karte den Modus **📻 Webradio** zuweist und die
Stream-Adresse einträgst (das Feld ist praktischerweise schon mit `http://` vorbelegt). Möchtest du
mehrere Sender oder eine gemischte Liste auf einer Karte bündeln, nimmst du dafür eine **`.m3u`-Datei**.

## Backup & Restore: deine Kartenzuordnungen sichern

Ein Punkt, den man leicht übersieht, bis es zu spät ist: Die Zuordnungen zwischen Karten und Inhalten
liegen **nicht** auf der SD-Karte, sondern im internen Speicher (NVS) des ESP32. Geht die Platine
einmal kaputt, wäre diese oft mühsam aufgebaute Zuordnungsliste verloren – wenn du sie nicht
gesichert hast.

Zum Glück nimmt ESPuino dir das weitgehend ab. Im Hauptverzeichnis der SD-Karte hält er automatisch
eine Datei **`backup.txt`** aktuell und schreibt sie bei **jeder** neuen Zuweisung fort (der Dateiname
lässt sich über `backupFile` in der `settings.h` ändern). Über den **Tab Tools** kannst du diese
Zuordnungen außerdem jederzeit von Hand **exportieren** und wieder **importieren**. Der Import ist
dabei bewusst gutmütig: Er **ergänzt und überschreibt nur, löscht aber nie** – du kannst ein Backup
also gefahrlos einspielen und sogar von einem ESPuino auf einen anderen übertragen.

!!! tip "Einen exakt definierten Stand herstellen"
    Sollen am Ende *genau* die Einträge aus deinem Backup vorhanden sein und sonst keine, gehst du in
    zwei Schritten vor: erst im Tab Tools **alle Zuweisungen löschen**, dann das Backup importieren.
    Andere Einstellungen bleiben davon unberührt. Hintergrund:
    [Forum #508](https://forum.espuino.de/t/die-backupfunktion-des-espuino/508).

Der wichtigste Rat zum Schluss: Exportiere hin und wieder ein Backup und bewahre es **außerhalb der
SD-Karte** auf – dann bist du auch dann abgesichert, wenn die Karte selbst einmal den Geist aufgibt.
