# 13 · Troubleshooting

Nicht immer läuft alles auf Anhieb rund – das ist bei einem Selbstbauprojekt normal und kein Grund zur
Verzweiflung. Dieses Kapitel geht die häufigsten Stolperfallen durch und erklärt jeweils, woran es
meist liegt und was hilft. Wenn du das Problem hier nicht findest, ist das Forum die richtige nächste
Anlaufstelle – am besten mit dem Log (siehe gleich) und ein paar Angaben zu deinem Gerät.

## Zuerst: das Log ansehen

Bevor du lange rätst, lohnt sich fast immer ein Blick ins Log – es verrät dir oft direkt, woran es
hakt. Du kommst auf zwei Wegen dran: bequem **im Browser** über das Stapel-Menü oben rechts im
Webinterface, Eintrag **Log**; oder klassisch **seriell** über USB mit 115200 Baud. Wie ausführlich
ESPuino protokolliert, steuert die Einstellung `SERIAL_LOGLEVEL`
([Kapitel 12](../firmware/compile-zeit.md)).

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
Warnung in [Kapitel 10](../vertiefung/erweiterte-themen.md#lpcd).)

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
gewählt sein – auf der Complete stellt die Lötbrücke JP2/JP3 zwischen +3 dB und +15 dB um (es darf
immer nur eine gesetzt sein). Hast du nur einen Lautsprecher, aktiviere die **Mono-Wiedergabe**. Und
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
`https` beherrscht ESPuino nicht (der Hintergrund steht in [Kapitel 5](../inbetriebnahme/erststart.md#das-webinterface-offnen)).
Ansonsten gelten die üblichen Verdächtigen: zu große Entfernung zum Router, ein Tippfehler in den
Zugangsdaten. Bleiben die LEDs im Leerlauf **grün** statt weiß, besteht keine Verbindung – dann neu
starten, näher an den Router gehen oder die Zugangsdaten erneut eingeben.

## Bootschleifen und Brownouts

Startet ESPuino immer wieder neu oder geht mitten im Betrieb aus, steckt fast immer ein
**Stromversorgungsproblem** dahinter. Eine zu schwache Quelle – ein dünnes USB-Kabel, ein schwaches
Netzteil, ein fast leerer Akku – bricht beim Stromhunger im Einschaltmoment oder bei Lautstärkespitzen
kurz ein und löst einen Brownout-Reset aus. Abhilfe schafft eine kräftigere Quelle und ein besseres
Kabel. Zur Erinnerung: Die Complete liefert über ihren Buck/Boost-Regler stabile 3,3 V und schaltet
bei Unterspannung sauber ab. *(Weitere Spezialfälle ergänzen wir aus dem Forum.)*

## Aus Versehen im Bluetooth-Modus gelandet

Falls du im Bluetooth-Modus feststeckst und nicht mehr weiterkommst: Leg einfach eine **unbekannte
RFID-Karte** auf – das bringt ESPuino zurück in den Normal-Modus. Alternativ geht das auch über den
entsprechenden Button im Tab Bluetooth.

!!! tip "Immer noch ein Problem?"
    Dann frag im [Forum](https://forum.espuino.de) nach. Hilfreich ist, gleich das Log mitzuschicken
    (siehe oben) und dazuzuschreiben, welches Board und welche Firmware-Version du verwendest und was
    genau passiert.
