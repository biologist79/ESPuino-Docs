# 15 · Troubleshooting

Nicht immer läuft alles auf Anhieb rund – das ist bei einem Selbstbauprojekt normal und kein Grund zur
Verzweiflung. Dieses Kapitel geht die häufigsten Stolperfallen durch und erklärt jeweils, woran es
meist liegt und was hilft. Und noch etwas vorweg: **Nicht jedes Problem musst du selbst lösen.**
Manches liegt gar nicht an deinem Aufbau, sondern etwa an einer Datei oder einer verwendeten
Bibliothek – solche Dinge klären wir gemeinsam. Wenn du also hier nicht fündig wirst, ist das
[**Forum**](https://forum.espuino.de) jederzeit die richtige Anlaufstelle – am besten mit dem Log
(siehe gleich) und ein paar Angaben zu deinem Gerät.

## Zuerst: das Log ansehen

Bevor du lange rätst, lohnt sich fast immer ein Blick ins Log – es verrät dir oft direkt, woran es
hakt. Du kommst auf mehreren Wegen dran: bequem **im Browser** über das Stapel-Menü oben rechts im
Webinterface, Eintrag **Log** – das setzt allerdings voraus, dass ESPuino **läuft und im WLAN
erreichbar** ist, was bei Problemfällen erfahrungsgemäß oft gerade nicht so ist. Dann führt der Weg
**seriell** über USB mit 115200 Baud. Für die serielle Konsole
brauchst du keine Entwicklungsumgebung – das
[ESPuino-Firmware-Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/) bringt eine solche
Konsole direkt im Browser mit (mehr dazu unten unter „Wenn nichts mehr geht"). Wie ausführlich
ESPuino protokolliert, steuert die Einstellung `SERIAL_LOGLEVEL`
([Kapitel 14](../firmware/compile-zeit.md)).

!!! warning "USB-Leitung mit Datenadern nötig"
    Für den seriellen Zugriff braucht die USB-Leitung **Datenadern**. Reine **Ladeleitungen** übertragen
    keine Daten – dann kommt in aller Regel **gar keine Verbindung** zur Complete zustande (das Gerät
    taucht oft nicht einmal als Port auf). Besonders bei **Verlängerungen oder Adaptersteckern** ist das
    ein Thema; im Zweifel eine andere Leitung probieren.

## Die RFID-Karte wird nicht zuverlässig erkannt

Wenn Karten mal erkannt werden und mal nicht, ist meistens der Abstand oder die Empfindlichkeit im
Spiel. Leg die Karte etwas näher an den Leser, und probiere bei einem MFRC522 die **Empfindlichkeit**
aus (Einstellung **MFRC522 Gain**, 0–7). Sie steht ab Werk schon recht hoch – es kann also durchaus
helfen, sie nicht nur höher, sondern auch einmal **niedriger** zu stellen. Nutzt du einen PN5180 und meldet ESPuino
eine ruhende Karte fälschlich als „entfernt", kann es helfen, den **PN5180 Debounce** zu erhöhen (Standard
500 ms) – die entsprechenden Einstellungen findest du im Tab Allgemein → RFID-Reader.

Ein besonders häufiger Fall verdient eigene Erwähnung: Läuft die Wiedergabe mit der Option **„Pause,
wenn die Karte entfernt wird"** und stoppt dann von selbst sporadisch, dann wird die Karte
zwischendurch kurz nicht erkannt und ESPuino hält das für ein Abnehmen. Das ist ein bekannter
Dauerbrenner. Verkleinere den Abstand zwischen Karte und Leser, erhöhe – beim PN5180 – dessen
Debounce, oder schalte die Option einfach ab, wenn sie bei dir mehr Ärger als Nutzen bringt. (Die
Option gibt es für RC522 und PN5180; nur der Debounce ist PN5180-spezifisch.) (Zu LPCD siehe die deutliche
Warnung in [Kapitel 12](../vertiefung/erweiterte-themen.md#lpcd).)

!!! tip "Im Forum stöbern lohnt sich"
    Rund um die Kartenerkennung gibt es im [Forum](https://forum.espuino.de) schon zahlreiche
    Diskussionen mit Tipps aus der Praxis. Eine kurze Suche dort führt oft schneller zum Ziel als
    langes Probieren – schau ruhig mal rein.

## Die SD-Karte wird nicht erkannt

Der mit Abstand häufigste Grund ist das Dateisystem: ESPuino braucht **FAT32**, viele Karten werden
aber ab Werk **exFAT-formatiert** ausgeliefert. Formatiere die Karte am Computer neu als FAT32 – bei Karten über 32 GB ist das fast
immer nötig. Blinken die LEDs beim Booten dauerhaft **rot**, ist genau das das Signal „SD nicht
lesbar"; ESPuino verharrt dann in diesem Zustand, bis eine brauchbare Karte steckt (beziehungsweise
schläft ein, wenn `SHUTDOWN_IF_SD_BOOT_FAILS` aktiv ist). Hilft das Umformatieren nicht, probiere
testweise eine andere Karte – gerade sehr billige oder sehr alte Karten laufen nicht immer zuverlässig.

!!! tip "Ohne SD kein Webinterface – nutze die serielle Konsole"
    Ohne lesbare SD-Karte **startet ESPuino nicht vollständig**, und du kommst gar nicht erst ins
    Webinterface – der Log-Weg über den Browser fällt hier also aus. Wirf stattdessen einen Blick in
    die **serielle Konsole**, etwa die im
    [ESPuino-Firmware-Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/) (siehe unten unter
    „Wenn nichts mehr geht"). Dort steht meist direkt, warum die Karte abgelehnt wird.

Kann eine Karte nicht gelesen werden – oder steckt gar keine –, sieht die Meldung im Log typischerweise
so aus:

```text
E (7918) sdmmc_common: sdmmc_init_ocr: send_op_cond (1) returned 0x107
E (7918) vfs_fat_sdmmc: sdmmc_card_init failed (0x107).
E [7928] SD-Karte konnte nicht gemountet werden.
```

## Kein oder verzerrter Ton

Kommt gar kein Ton, prüf zuerst das Naheliegende: die Lautstärke und deren Maximalwerte im
Webinterface (Tab Allgemein → Wiedergabe). Klingt es verzerrt, kann die **Verstärkung** zu hoch
gewählt sein – auf der [Complete](../hardware/complete.md) stellt eine Lötbrücke die Grundverstärkung – ohne Brücke
+9 dB, mit JP2 +3 dB, mit JP3 +15 dB (immer nur eine setzen). Und
für Kopfhörer ist die kabelgebundene [Kopfhörerplatine](../bedienung/am-geraet.md#kopfhorer-detection-lautstarke-profile)
der zuverlässige Weg.

## Einzelne Titel spielen nicht oder stottern (MP3) { #einzelne-titel-machen-probleme-mp3 }

Manchmal ist nicht das Gerät schuld, sondern eine einzelne Datei. Gerade bei MP3s ist häufig
**eingebettetes Coverart** die Ursache, oder eine ungewöhnliche Kodierung. In solchen Fällen kann
ein sauberes Neu-Kodieren helfen, zum Beispiel mit [ffmpeg](https://ffmpeg.org/):

```bash
ffmpeg -i problem.mp3 -vn -c:a libmp3lame -q:a 2 clean.mp3
```

Das `-vn` entfernt das eingebettete Cover (das technisch als „Video"-Spur mitläuft), `-q:a 2` sorgt
für gute Qualität. Betrifft es einen ganzen Ordner, wickelst du den Befehl in eine kleine
Datei-Schleife deiner Shell.

!!! note "Manchmal liegt es an der Audio-Bibliothek"
    Zum Abspielen nutzt ESPuino die Bibliothek
    [ESP32-audioI2S](https://github.com/schreibfaul1/ESP32-audioI2S/). Es kommt hier und da mal vor,
    dass ein Abspielproblem gar nicht an deiner Datei oder deinem Gerät liegt, sondern ein **Fehler in
    dieser Bibliothek** ist. Solche Fälle melden wir dem Entwickler, und sie werden dann behoben. Kurz: Nicht
    jedes Problem musst (oder kannst) du selbst lösen. Melde es einfach im
    [Forum](https://forum.espuino.de) – dort schauen wir es uns gemeinsam an und finden heraus, woran
    es liegt.

## WLAN-Probleme

Zwei Dinge übersieht man leicht. Erstens: Der ESP32 funkt **nur auf 2,4 GHz** – ein reines
5-GHz-Netz sieht er gar nicht. Zweitens: Die Adresse muss immer mit **`http://`** aufgerufen werden,
`https` beherrscht ESPuino nicht (der Hintergrund steht in [Kapitel 7](../inbetriebnahme/erststart.md#das-webinterface-offnen)).
Ansonsten gelten die üblichen Verdächtigen: zu große Entfernung zum Router, ein Tippfehler in den
Zugangsdaten. Bleiben die LEDs im Leerlauf **grün** statt weiß, besteht keine Verbindung – dann neu
starten, näher an den Router gehen oder die Zugangsdaten erneut eingeben.

Vor allem in Gegenden mit **vielen WLANs in der Nähe** kann es außerdem helfen, den **WLAN-Kanal im
Router fest einzustellen**, statt ihn automatisch wählen zu lassen.

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

!!! warning "USB-Leitung mit Datenadern verwenden"
    Manche USB-Leitungen sind **nur zum Laden** gedacht und führen **keine Datenadern**. Damit
    funktioniert weder die serielle Konsole noch das Flashen – der ESPuino wird dann im Tool oft gar
    nicht als Port angeboten. Besonders bei **Verlängerungen oder Adaptersteckern** ist das ein Thema.
    Stell also sicher, dass deine Leitung **Daten überträgt** (im Zweifel eine andere probieren).

Je nach Lage hilft eine dieser Stufen – von harmlos nach drastisch:

- **Konsole mitlesen.** Die integrierte serielle Konsole zeigt Boot- und Log-Ausgaben in Echtzeit;
  oft steht dort direkt, woran es hakt.
- **Nur die App neu aufspielen.** Läuft das Gerät noch teilweise, ist aber das Webinterface nicht
  erreichbar, spielt **„App-Update"** allein die Firmware neu auf. Deine **Einstellungen und
  Kartenzuweisungen bleiben dabei erhalten**.
- **Letzte Rettung: komplett löschen und neu aufspielen.** Hilft nichts mehr, löschst du das
  **gesamte Flash** (im Tool ausdrücklich „nur im Notfall") und spielst mit **„Complete-Flash /
  Recovery"** alles frisch auf.

!!! danger "Vollständiges Löschen löscht auch deine Daten"
    Ein komplettes Flash-Löschen setzt auch das **NVS** zurück – **Kartenzuweisungen,
    WLAN-Zugangsdaten und alle weiteren Einstellungen sind dann weg**. Wiederherstellen lassen sich
    davon nur die **Kartenzuweisungen**: Sie liegen in der `backup.txt`
    ([Kapitel 10 → Backup & Restore](../inhalte/verwalten.md#backup-restore-deine-kartenzuordnungen-sichern))
    und lassen sich anschließend wieder importieren. **WLAN-Zugangsdaten und die übrigen Einstellungen
    lassen sich derzeit nicht sichern** – die musst du nach einem vollständigen Löschen von Hand neu
    eingeben.

!!! warning "Richtige Plattform und Branch wählen"
    Beim Flashen musst du die **passende Plattform** (z. B. Complete) und den **Branch** wählen. Eine
    falsche Auswahl kann im schlimmsten Fall die **Hardware beschädigen**.

Wie das Flashen im Detail abläuft, steht in
[Kapitel 13 · Firmware aktualisieren](../firmware/aktualisieren.md).

!!! tip "Immer noch ein Problem?"
    Dann frag im [Forum](https://forum.espuino.de) nach. Hilfreich ist, gleich das Log mitzuschicken
    (siehe oben) und dazuzuschreiben, welches Board und welche Firmware-Version du verwendest und was
    genau passiert.
