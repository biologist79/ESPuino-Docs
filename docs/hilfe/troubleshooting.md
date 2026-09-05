# 14 · Troubleshooting

Nicht immer läuft alles auf Anhieb rund – das ist bei einem Selbstbauprojekt normal und kein Grund zur
Verzweiflung. Dieses Kapitel geht die häufigsten Stolperfallen durch und erklärt jeweils, woran es
meist liegt und was hilft. Wenn du das Problem hier nicht findest, ist das Forum die richtige nächste
Anlaufstelle – am besten mit dem Log (siehe gleich) und ein paar Angaben zu deinem Gerät.

## Zuerst: das Log ansehen

Bevor du lange rätst, lohnt sich fast immer ein Blick ins Log – es verrät dir oft direkt, woran es
hakt. Du kommst auf mehreren Wegen dran: bequem **im Browser** über das Stapel-Menü oben rechts im
Webinterface, Eintrag **Log**; oder **seriell** über USB mit 115200 Baud. Für die serielle Konsole
brauchst du keine Entwicklungsumgebung – das
[ESPuino-Firmware-Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/) bringt eine solche
Konsole direkt im Browser mit (mehr dazu unten unter „Wenn nichts mehr geht"). Wie ausführlich
ESPuino protokolliert, steuert die Einstellung `SERIAL_LOGLEVEL`
([Kapitel 13](../firmware/compile-zeit.md)).

## Die RFID-Karte wird nicht zuverlässig erkannt

Wenn Karten mal erkannt werden und mal nicht, ist meistens der Abstand oder die Empfindlichkeit im
Spiel. Leg die Karte etwas näher an den Leser, und dreh bei einem MFRC522 notfalls die
Empfindlichkeit hoch (Einstellung **MFRC522 Gain**, 0–7). Nutzt du einen PN5180 und meldet ESPuino
eine ruhende Karte fälschlich als „entfernt", hilft es, den **PN5180 Debounce** zu erhöhen (Standard
500 ms) – die entsprechenden Einstellungen findest du im Tab Allgemein → RFID-Reader.

Ein besonders häufiger Fall verdient eigene Erwähnung: Läuft die Wiedergabe mit der Option **„Pause,
wenn die Karte entfernt wird"** und stoppt dann von selbst sporadisch, dann wird die Karte
zwischendurch kurz nicht erkannt und ESPuino hält das für ein Abnehmen. Das ist ein bekannter
Dauerbrenner. Verkleinere den Abstand zwischen Karte und Leser, erhöhe – beim PN5180 – dessen
Debounce, oder schalte die Option einfach ab, wenn sie bei dir mehr Ärger als Nutzen bringt. (Die
Option gibt es für RC522 und PN5180; nur der Debounce ist PN5180-spezifisch.) (Zu LPCD siehe die deutliche
Warnung in [Kapitel 11](../vertiefung/erweiterte-themen.md#lpcd).)

## Die SD-Karte wird nicht erkannt

Der mit Abstand häufigste Grund ist das Dateisystem: ESPuino braucht **FAT32**, viele Karten kommen
aber als exFAT. Formatiere die Karte am Computer neu als FAT32 – bei Karten über 32 GB ist das fast
immer nötig. Blinken die LEDs beim Booten dauerhaft **rot**, ist genau das das Signal „SD nicht
lesbar"; ESPuino verharrt dann in diesem Zustand, bis eine brauchbare Karte steckt (beziehungsweise
schläft ein, wenn `SHUTDOWN_IF_SD_BOOT_FAILS` aktiv ist). Hilft das Umformatieren nicht, probiere
testweise eine andere Karte – gerade sehr billige oder sehr alte Karten laufen nicht immer zuverlässig.

## Kein oder verzerrter Ton

Kommt gar kein Ton, prüf zuerst das Naheliegende: die Lautstärke und deren Maximalwerte im
Webinterface (Tab Allgemein → Wiedergabe). Klingt es verzerrt, kann die **Verstärkung** zu hoch
gewählt sein – auf der [Complete](../hardware/complete.md) stellt eine Lötbrücke die Grundverstärkung – ohne Brücke
+9 dB, mit JP2 +3 dB, mit JP3 +15 dB (immer nur eine setzen). Hast du nur einen Lautsprecher, aktiviere die **Mono-Wiedergabe**. Und
für Kopfhörer ist die kabelgebundene [Kopfhörerplatine](../bedienung/am-geraet.md#kopfhorer-detection-lautstarke-profile)
der zuverlässige Weg.

## Einzelne Titel spielen nicht oder stottern (MP3) { #einzelne-titel-machen-probleme-mp3 }

Manchmal ist nicht das Gerät schuld, sondern eine einzelne Datei. Gerade bei MP3s ist häufig
**eingebettetes Coverart** die Ursache, oder eine ungewöhnliche Kodierung. In solchen Fällen hilft
ein sauberes Neu-Kodieren, zum Beispiel mit [ffmpeg](https://ffmpeg.org/):

```bash
ffmpeg -i problem.mp3 -vn -c:a libmp3lame -q:a 2 clean.mp3
```

Das `-vn` entfernt das eingebettete Cover (das technisch als „Video"-Spur mitläuft), `-q:a 2` sorgt
für gute Qualität. Betrifft es einen ganzen Ordner, wickelst du den Befehl in eine kleine
Datei-Schleife deiner Shell.

## WLAN-Probleme

Zwei Dinge übersieht man leicht. Erstens: Der ESP32 funkt **nur auf 2,4 GHz** – ein reines
5-GHz-Netz sieht er gar nicht. Zweitens: Die Adresse muss immer mit **`http://`** aufgerufen werden,
`https` beherrscht ESPuino nicht (der Hintergrund steht in [Kapitel 6](../inbetriebnahme/erststart.md#das-webinterface-offnen)).
Ansonsten gelten die üblichen Verdächtigen: zu große Entfernung zum Router, ein Tippfehler in den
Zugangsdaten. Bleiben die LEDs im Leerlauf **grün** statt weiß, besteht keine Verbindung – dann neu
starten, näher an den Router gehen oder die Zugangsdaten erneut eingeben.

## Bootschleifen und Brownouts

Startet ESPuino immer wieder neu oder geht mitten im Betrieb aus, steckt fast immer ein
**Stromversorgungsproblem** dahinter. Eine zu schwache Quelle – eine dünne USB-Leitung, ein schwaches
Netzteil, ein fast leerer Akku – bricht beim Stromhunger im Einschaltmoment oder bei Lautstärkespitzen
kurz ein und löst einen Brownout-Reset aus. Abhilfe schafft eine kräftigere Quelle und eine bessere
Leitung. Zur Erinnerung: Die Complete liefert über ihren Buck/Boost-Regler stabile 3,3 V und schaltet
bei Unterspannung sauber ab. *(Weitere Spezialfälle ergänzen wir aus dem Forum.)*

## Aus Versehen im Bluetooth-Modus gelandet

Falls du im Bluetooth-Modus feststeckst und nicht mehr weiterkommst: Leg einfach eine **unbekannte
RFID-Karte** auf – das bringt ESPuino zurück in den Normal-Modus. Alternativ geht das auch über den
entsprechenden Button im Tab Bluetooth.

## Wenn nichts mehr geht: Gerät zurücksetzen

Reagiert dein ESPuino gar nicht mehr, hängt beim Booten oder ist das Webinterface partout nicht
erreichbar, ist das **[ESPuino-Firmware-Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/)**
der Rettungsanker. Es läuft komplett **im Browser** – du brauchst nur eine USB-Verbindung und keine
Entwicklungsumgebung. Voraussetzung ist ein Browser mit **WebSerial** (Chrome, Edge, Firefox ab
Version 151, Opera, Brave oder Vivaldi); wähle eine Baudrate von **höchstens 460 800**, höhere Werte
führen zu Abbrüchen.

Je nach Lage hilft eine dieser Stufen – von harmlos nach drastisch:

- **Konsole mitlesen.** Die integrierte serielle Konsole zeigt Boot- und Log-Ausgaben in Echtzeit;
  oft steht dort direkt, woran es hakt.
- **Nur die App neu aufspielen.** Läuft das Gerät noch teilweise, ist aber das Webinterface nicht
  erreichbar, spielt **„App-Update"** allein die Firmware neu auf. Deine **Einstellungen und
  Kartenzuweisungen bleiben dabei erhalten**.
- **Letzte Rettung: komplett löschen und neu aufspielen.** Hilft nichts mehr, löschst du das
  **gesamte Flash** (im Tool ausdrücklich „nur im Notfall") und spielst mit **„Complete-Flash /
  Recovery"** alles frisch auf.

!!! danger "Vollständiges Löschen wischt deine Daten"
    Ein komplettes Flash-Löschen setzt auch das **NVS** zurück – **Kartenzuweisungen,
    WLAN-Zugangsdaten und alle Einstellungen sind dann weg**. Sichere sie vorher über die
    **Backup-Funktion** ([Kapitel 9 → Backup & Restore](../inhalte/verwalten.md#backup-restore-deine-kartenzuordnungen-sichern));
    die Kartenzuweisungen lassen sich damit anschließend wiederherstellen.

!!! warning "Richtige Plattform und Branch wählen"
    Beim Flashen musst du die **passende Plattform** (z. B. Complete) und den **Branch** wählen. Eine
    falsche Auswahl kann im schlimmsten Fall die **Hardware beschädigen**.

Wie das Flashen im Detail abläuft, steht in
[Kapitel 12 · Firmware aktualisieren](../firmware/aktualisieren.md).

!!! tip "Immer noch ein Problem?"
    Dann frag im [Forum](https://forum.espuino.de) nach. Hilfreich ist, gleich das Log mitzuschicken
    (siehe oben) und dazuzuschreiben, welches Board und welche Firmware-Version du verwendest und was
    genau passiert.
