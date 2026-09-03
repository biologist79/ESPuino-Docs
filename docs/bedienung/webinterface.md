# 6 · Das Webinterface

Das Webinterface ist die Schaltzentrale deines ESPuino. Praktisch alles, was sich einstellen lässt,
stellst du hier ein – von den Kartenzuweisungen über das WLAN bis zum Firmware-Update –, und ebenso
steuerst du hier die laufende Wiedergabe. Dieses Kapitel führt dich einmal durch alle Bereiche. Du
musst nicht alles auf einmal verstehen; sieh es als Nachschlagewerk, in dem du gezielt den Tab
findest, den du gerade brauchst.

Erreichbar ist das Webinterface im Browser – am bequemsten über den Hostnamen (`http://espuino.local`
bei aktivem mDNS), sonst über die IP-Adresse. Wie du das erste Mal dorthin kommst, ist in
[Kapitel 5 · Erststart](../inbetriebnahme/erststart.md) beschrieben.

## Was überall gilt

Ein paar Elemente begegnen dir auf jeder Seite, deshalb vorab:

- Oben rechts pulsiert ein **Herz-Symbol** – die Verbindungsanzeige, im Forum „Heartbeat" genannt
  ([#4583](https://forum.espuino.de/t/heartbeat/4583)). Es überwacht die Verbindung zwischen deinem
  **Webbrowser** und dem **ESPuino**: Die geöffnete Seite schickt alle drei Sekunden eine kleine
  Anfrage an das Gerät; kommt eine Antwort zurück, pulsiert das Herz grün, bleibt sie aus, wird es
  rot. So siehst du jederzeit, ob die Seite noch mit deinem ESPuino in Kontakt steht.
- Neben vielen Eingabefeldern sitzt ein **Fragezeichen**. Ein Klick darauf öffnet einen kurzen
  Hilfetext – wenn du also mal nicht weißt, was eine Einstellung bewirkt, ist die Antwort meist nur
  einen Klick entfernt.
- Über das **Stapel-Symbol** ganz oben rechts erreichst du ein Menü mit Sprachauswahl (Deutsch,
  Englisch, Französisch), dem **Dunkelmodus**, den **Informationen** (Firmware-Stand, Speicher,
  Batterie), dem **Log** (die Konsolenausgabe direkt im Browser) sowie **Neustart** und
  **Ausschalten**.
- Gespeichert wird immer **pro Bereich**, über den jeweiligen Button. Die Beschriftung sagt dir dabei
  genau, was gespeichert wird.

## Tab Steuerung

Der Tab Steuerung ist die Fernbedienung im Browser. Hier siehst du – sofern der Titel oder Webstream
eines mitliefert – das Cover und die Infos zum laufenden Titel und bedienst die Wiedergabe mit den
gewohnten Transport-Tasten (erster Titel, voriger, Play/Pause, nächster, letzter). Der **Lautstärke-Slider** wirkt sofort, und über das
Equalizer-Symbol öffnest du drei Regler für Bass, Mitten und Höhen.

Zwei Kleinigkeiten sind besonders nützlich: Der **Fortschrittsbalken** ist anklickbar – ein Klick
springt direkt an die gewählte Stelle im Titel. Und über **Modifikation ausführen** löst du jede
Modifikation (Schlaftimer, Wiederholung, Tastensperre …) direkt aus, ganz ohne eine Karte aufzulegen.

## Tab RFID

<!-- Screenshot: RFID-Tab -->

Dieser Tab ist das Herzstück, denn hier verknüpfst du Karten mit Inhalten. Er besteht aus zwei
untereinander angeordneten Bereichen: dem Dateibrowser und der eigentlichen Zuweisung.

### Der Dateibrowser

Der Dateibrowser zeigt den Inhalt der SD-Karte. Über das **Suchfeld** filterst du, per **Upload**
bringst du
einzelne Dateien oder ganze Verzeichnisse (samt Unterordnern) auf den ESPuino, und ein **Rechtsklick**
(am Handy: langes Antippen) auf einen Eintrag öffnet ein Kontextmenü zum Anlegen, Abspielen,
Aktualisieren, Umbenennen, Löschen und Herunterladen.

### Eine Karte zuweisen

Im Bereich darunter weist du einer Karte einen Inhalt zu, in vier Schritten:

1. **RFID-Chip-Nummer:** Legst du eine Karte auf, wird die Nummer automatisch eingetragen. Du kannst
   sie auch von Hand eingeben oder eine [virtuelle Karte](https://forum.espuino.de/t/virtual-rfid-cards)
   verwenden.
2. Im Reiter **Musik** wählst du im Dateibrowser eine Datei oder einen Ordner und legst den
   **Abspielmodus** fest (siehe Tabelle). Wählst du *Webradio*, wird das Pfad-Feld bequem mit `http://`
   vorbelegt.
3. Im Reiter **Modifikation** weist du der Karte stattdessen eine Aktion zu.
4. **Speichern** – fertig.

#### Die Abspielmodi { #abspielmodi }

Die folgende Tabelle listet die Modi in der Reihenfolge, in der sie im Dropdown erscheinen. Die
technischen IDs dazu stehen im [Anhang](../referenz/anhang.md#playmodi).

| Modus | Bedeutung |
| --- | --- |
| 🎵 Einzelner Titel | Genau eine Datei, einmal. |
| 🎵🔁 Einzelner Titel (Endlosschleife) | Eine Datei dauerhaft wiederholen. |
| 🎲💤 Zufälliger Titel eines Ordners, danach schlafen | Ein zufälliger Titel, danach Deep Sleep – die ideale Einschlaf-Karte. |
| 📖 Hörbuch | Titel eines Ordners sortiert; **die letzte Position wird gemerkt**. |
| 📚 Hörbuch rekursiv | Wie Hörbuch, inklusive Unterordner; Position wird gemerkt. |
| 📖🔁 Hörbuch (Endlosschleife) | Hörbuch, beginnt nach dem letzten Titel wieder von vorn. |
| 📁 Alle Titel (sortiert) | Ordner sortiert, **ohne** Positionsspeicherung. |
| 🌳 Alle Titel + Unterordner (rekursiv, sortiert) | Wie oben, inklusive Unterordner, ohne Positionsspeicherung. |
| 📁🔀 Alle Titel (zufällig) | Ordner in zufälliger Reihenfolge. |
| 🌳🔀 Alle Titel + Unterordner (rekursiv, zufällig) | Zufällig über Ordner und Unterordner. |
| 📁🔁 Alle Titel (sortiert, Endlosschleife) | Sortiert, endlos. |
| 📁🔀🔁 Alle Titel (zufällig, Endlosschleife) | Zufällig, endlos. |
| 🎲📁 Zufälliger Unterordner (sortiert) | Ein zufälliger Unterordner, sortiert. |
| 🎲📁🔀 Zufälliger Unterordner (zufällig) | Ein zufälliger Unterordner, zufällig. |
| 📻 Webradio | Eine Stream-URL statt einer Datei. |
| 📃 Liste (.m3u) | Die Einträge einer lokalen `.m3u` – Dateien und Webstreams gemischt. |
| 🌐 MediaHub | Inhalt **und** Abspielmodus kommen vom gewählten [MediaHub-Server](../inhalte/mediahub.md). |

#### Modifikationskarten – alle Optionen

Statt Musik lässt sich einer Karte eine Aktion zuordnen. Denselben Katalog findest du übrigens im Tab
Steuerung unter „Modifikation ausführen", wo du die Aktion direkt und ohne Karte auslöst. Die
technischen IDs stehen im [Anhang](../referenz/anhang.md#modifikationskarten).

**Sperren & Schlafen:** 🔒 Tastensperre · 💤 Schlafe sofort · 💤 Schlafen nach 15 min / 30 min /
1 h / 2 h (LEDs gedimmt) · 💤 Schlafen nach Ende des Titels · 💤 Schlafen nach Ende der Playlist.

**Wiederholung:** 🔁 Playlist endlos · 🔂 Titel endlos.

**Licht, Funk & Dienste:** 🌙 LEDs dimmen (Nachtmodus) · 📶 WLAN an/aus · 💡 Ambient Light ·
📁 FTP aktivieren · 🔊 BT-Lautsprecher · 🎧 BT-Kopfhörer · 🔀 Modus wechseln *(die
Bluetooth-Aktionen nur bei Firmware mit Bluetooth)*.

**Ansagen:** 🌐 IP-Adresse ansagen · 🕒 Uhrzeit ansagen.

**Wiedergabesteuerung als Karte:** ⏯ Play/Pause · ⏮/⏭ Titel zurück/vor · ⏪/⏩ erster/letzter Titel ·
📁 Ordner vor/zurück (nur in rekursiven Modi) · »/« Sekunden vor/zurück.

**Virtuelle Karten & Sonstiges:** 🏷 Virtuelle Karte 01–10 · 🗑 Zuordnung löschen (weist du *das*
einer Karte zu, wird ihre bestehende Zuordnung entfernt).

## Tab WLAN

<!-- Screenshot: WLAN-Tab -->

Hier verwaltest du alles rund um die Netzwerkverbindung. Unter **WLAN-Einstellungen** legst du fest,
ob ESPuino beim Start das **stärkste** von mehreren bekannten Netzen wählt, wie der **Hostname**
lautet und – für den Einrichtungsfall – wie der **Access-Point** heißt, ob er ein Passwort hat und
wann er sich automatisch schließt. Unter **Netzwerke** hinterlegst du deine WLANs; es lassen sich
mehrere speichern, was praktisch ist, wenn ESPuino auch mal mit zu den Großeltern reist. Optional
kannst du pro Netzwerk eine **statische IP** setzen. Die **gespeicherten Netzwerke** schließlich
listet alle hinterlegten WLANs auf; das gerade verbundene ist hervorgehoben, und über das
Mülleimer-Symbol löschst du Einträge.

!!! warning "Access-Point-Timeout: bitte nicht auf 0 lassen"
    Kurz zum Hintergrund: Den Einrichtungs-Access-Point spannt ESPuino nur dann auf, wenn er sich in
    kein bekanntes WLAN einloggen konnte – er ist also ein Notnagel für die Ersteinrichtung. Dieser
    AP ist standardmäßig ungeschützt, und solange er offen ist, kann sich **jeder** damit verbinden
    und im Webinterface beliebige Dinge anstellen. Ist er nur kurz offen, ist das vertretbar. Ein
    Timeout von **0** bedeutet aber, dass ESPuino den AP **nie** von selbst schließt – und damit hast
    du ein dauerhaftes Sicherheitsproblem. Lass den Wert deshalb nicht auf 0 stehen (oder vergib
    zumindest ein AP-Passwort).

!!! warning "Statische IP nur mit Bedacht"
    Eine **statische IP** solltest du nur setzen, wenn du weißt, was du tust. Passt die Konfiguration
    nicht zu deinem Netz, ist ESPuino unter Umständen nicht mehr erreichbar.

## Tab MQTT

*MQTT-Unterstützung ist standardmäßig einkompiliert, dieser Tab also normalerweise vorhanden – er
fehlt nur, wenn die Firmware bewusst ohne MQTT gebaut wurde.*

<!-- Screenshot: MQTT-Tab -->

Hier bindest du ESPuino an deinen MQTT-Broker an, etwa für Home Assistant oder ioBroker. Du
aktivierst MQTT und trägst ClientId, ein optionales Basis-Topic, die Geräte-ID, den Server, optional
Benutzername und Passwort sowie den Port ein. In ClientId und Geräte-ID darfst du den Platzhalter
`<MAC>` verwenden – er wird automatisch durch die MAC-Adresse ersetzt, was bei mehreren ESPuinos
Gold wert ist. Praktischerweise siehst du unterhalb der Felder eine **Live-Vorschau der Topics**, die
sich aus deinen Eingaben ergeben. Welche Topics es gibt, steht im
[Anhang](../referenz/anhang.md#mqtt-topics).

!!! warning "Neustart nötig"
    Änderungen an den MQTT-Einstellungen greifen erst nach einem Neustart – das Interface bietet ihn
    nach dem Speichern gleich an.

## Tab FTP

*FTP-Unterstützung ist standardmäßig einkompiliert, dieser Tab also normalerweise vorhanden – er
fehlt nur, wenn die Firmware bewusst ohne FTP gebaut wurde.*

<!-- Screenshot: FTP-Tab -->

Hier legst du Benutzernamen und Passwort für den FTP-Zugang fest. Aus Speichergründen läuft der
FTP-Server nicht dauerhaft mit: Du startest ihn bei Bedarf über den Button **FTP-Server starten**
(oder am Gerät über die Tastenkombination Pause/Play + Nächster Titel), und nach dem nächsten Neustart
ist er wieder aus.

!!! tip "Für große Datenmengen"
    FTP ist deutlich schneller als der Web-Upload und damit die bessere Wahl, wenn du viel auf einmal
    überträgst. Stell im FTP-Programm die Zeichenkodierung **CP437** ein, damit Umlaute korrekt
    ankommen.

## Tab Bluetooth

*Nur sichtbar, wenn die Firmware mit Bluetooth-Unterstützung gebaut wurde.*

<!-- Screenshot: Bluetooth-Tab -->

ESPuino kann Bluetooth in zwei Richtungen. Im Modus **Bluetooth-Kopfhörer** sendet ESPuino den Ton an
ein Bluetooth-Gerät – du trägst den Namen deines Kopfhörers ein oder, noch einfacher, klickst auf
**Geräte suchen** und übernimmst dein Gerät aus der Trefferliste (bei Bedarf gibt es ein Feld für den
PIN-Code). Im Modus **Bluetooth-Lautsprecher** wird ESPuino umgekehrt selbst zur Box, auf die du vom
Handy streamst. Im Bluetooth-Modus zeigt der Tab einen Button, um wieder in den Normal-Modus zu
wechseln; alternativ genügt es, eine unbekannte RFID-Karte aufzulegen.

!!! note "Bluetooth und WLAN"
    Bluetooth und WLAN laufen **parallel**. Der Parallelbetrieb ist allerdings speicherknapp und
    ungetestet – mehr dazu in [Kapitel 7 → Betriebsmodi](am-geraet.md#betriebsmodi).

## Tab Allgemein

<!-- Screenshot: Allgemein-Tab -->

Die allgemeinen Einstellungen sind optisch in fünf Unterkladden aufgeteilt (Wiedergabe, RFID-Reader,
Drehencoder & Taster, LED, Energie). Jede hat zwar ihren eigenen Speichern- und Reset-Button, aber
lass dich davon nicht täuschen: Alle fünf gehören zu **einem** gemeinsamen Formular. Ein Klick auf
Speichern sichert deshalb **alle** allgemeinen Einstellungen auf einmal – nicht nur die gerade
sichtbare Unterkladde. Du musst also nicht in jeder Unterkladde einzeln speichern.

### Wiedergabe

Hier stellst du das grundlegende Abspielverhalten ein. Unter **Lautstärke** legst du die
Startlautstärke und die Maximalwerte getrennt für Lautsprecher und Kopfhörer fest, dazu eine
Minimal-Lautstärke, damit sich die Box nie ganz stummschalten lässt. Unter **Wiedergabeliste** wählst
du den Sortiermodus und die maximale Rekursionstiefe.

Ein Wort zur **Positionsspeicherung** vorab, weil mehrere der Optionen daran hängen: ESPuino merkt
sich die zuletzt gehörte Stelle **nur im Hörbuch-Modus**, und standardmäßig nur an den natürlichen
Punkten – beim **Pausieren** und beim **Titelwechsel**. Die beiden folgenden „…merken"-Optionen
erweitern das um zusätzliche Speicherzeitpunkte.

Der Bereich **Optionen** ist eine Sammlung von Verhaltensschaltern – zu jedem gibt es zusätzlich einen
Hilfetext am Fragezeichen:

| Option | Wirkung |
| --- | --- |
| Position beim Ausschalten merken | Sichert die Hörbuch-Position **zusätzlich** beim Ausschalten. |
| Position bei Kartenwechsel merken | Sichert die Position **zusätzlich** beim Wechsel auf eine andere Karte. |
| Letzte Karte nach Neustart abspielen | Setzt nach einem Neustart automatisch die zuletzt gespielte Karte fort. |
| Pause bei entfernter Karte | Pausiert, wenn die Karte vom Leser genommen wird (RC522 und PN5180 – siehe Warnung unten). |
| Gleiche Karte nicht erneut akzeptieren | Ignoriert erneutes Auflegen derselben Karte; optional Pause↔Play statt Neustart. |
| Pause bei minimaler Lautstärke | Pausiert, sobald die Lautstärke das Minimum erreicht. |
| Letzte Lautstärke wiederherstellen | Stellt nach einem Neustart die zuletzt genutzte Lautstärke wieder her. |
| Mono-Wiedergabe | Für Aufbauten mit nur einem Lautsprecher. |
| Lautstärkekurve | Linear oder logarithmisch. |

Zusätzlich gibt es ein **Speicherintervall**, mit dem ESPuino die Position im Hörbuch-Modus
**zyklisch** (alle n Sekunden) sichert – gedacht für lange Kapitel, damit ein plötzlicher Stromausfall
nicht den Fortschritt einer ganzen Stunde kostet. Standardmäßig ist es aus (0).

!!! warning "Zyklisches Speichern belastet den Flash-Speicher"
    Jedes Speichern schreibt in den Flash-Speicher, und der nutzt sich mit jedem Schreibvorgang ein
    kleines Stück ab. Wähle das Intervall deshalb nicht unnötig kurz und setze die Funktion nur dort
    ein, wo sie wirklich lohnt (lange Hörbücher). Bei kurzen Titeln, die ohnehin an jeder Titelgrenze
    speichern, bringt sie nichts.

!!! warning "Die Option „Pause bei entfernter Karte" kann Ärger machen"
    Sie ist beliebt (Karte liegt auf, Abnehmen pausiert), aber heikel: Wird die Karte zwischendurch
    kurz nicht erkannt, pausiert die Wiedergabe ungewollt – einer der häufigsten Gründe für sporadische
    Aussetzer. Läuft es bei dir unzuverlässig, verkleinere den Abstand Karte↔Leser, erhöhe – falls du
    einen PN5180 nutzt – dessen Debounce, oder schalte die Option ab. (Die Option selbst funktioniert
    mit RC522 und PN5180; nur die Debounce-Einstellung ist dem PN5180 vorbehalten.)

### RFID-Reader

<!-- Screenshot: RFID-Reader -->

In dieser Unterkladde geht es um den Kartenleser:

| Einstellung | Bedeutung |
| --- | --- |
| **PN5180 LPCD** | Aufwecken aus dem Deep-Sleep durch Kartenauflegen. Nur mit PN5180 und gesetzten Lötbrücken (bei MFRC522 ausgegraut). Einschränkungen: [Kapitel 10](../vertiefung/erweiterte-themen.md#lpcd). |
| **Reader-Typ** | *Auto-detect* (Standard), MFRC522 (SPI oder I²C) oder PN5180. |
| **MFRC522 Gain** | Empfindlichkeit des MFRC522 (0–7, Standard 7). |
| **PN5180 Debounce** | Wie lange eine Karte ununterbrochen *nicht* erkannt sein muss, bevor sie als entfernt gilt (Standard 500 ms). |

!!! warning "Neustart nötig"
    Änderungen in dieser Unterkladde greifen erst nach einem Neustart.

### Drehencoder & Taster

<!-- Screenshot: Drehencoder & Taster -->

Hier legst du fest, was die Bedienelemente tun. Wichtig zu verstehen: Alles, was du hier einstellst,
landet im internen Speicher (NVS) und **überschreibt die in der Firmware hinterlegte
Standardbelegung** – du kannst die komplette Belegung also anpassen, ohne die Firmware neu zu bauen.

Für den **Drehregler** gibt es nur eine Einstellung: die **Drehrichtung umkehren**, falls bei dir
Rechtsdrehen leiser statt lauter macht. Darunter ordnest du in einer Tabelle jedem der sechs
**Taster** (Btn0–Btn5) je eine Aktion für kurzen und langen Druck zu; `--` bedeutet „keine Aktion".
Zusätzlich lassen sich Aktionen auf **gleichzeitig gedrückte Tasterpaare** legen (alle 15
Kombinationen von 0+1 bis 4+5, jeweils eine Aktion) – praktisch für selten gebrauchte Funktionen wie
Neustart oder FTP-Start, ohne dafür einen eigenen Taster zu opfern.

Die zur Auswahl stehenden Aktionen entsprechen im Wesentlichen dem Modifikationskarten-Katalog, plus
einiger Aktionen, die nur als Taster Sinn ergeben: Lauter/Leiser/Initiale Lautstärke,
Batteriespannung anzeigen, Stop und Neustart, Schlafen nach fünf Titeln sowie eine Debug-Anzeige der
Taskauslastung. Die Standardbelegung, mit der ESPuino ausgeliefert wird, findest du in
[Kapitel 7 → Tasten](am-geraet.md#tasten-und-tastenkombinationen).

### LED

<!-- Screenshot: LED -->

Hier stellst du die Neopixel ein. Die **Helligkeit** lässt sich getrennt für den Normalbetrieb, den
Nachtmodus und das Ambient-Light festlegen. Unter **LED-Einstellungen** kommen die Details dazu:

| Einstellung | Bedeutung |
| --- | --- |
| Anzahl Anzeige-LEDs | Wie viele LEDs Status und Fortschritt anzeigen. |
| Anzahl Kontroll-LEDs | Zusätzliche LEDs, jede mit frei wählbarer Farbe. |
| Punkte im Leerlauf | Anzahl der Punkte in der Leerlauf-Animation. |
| Fortschritts-Farbverlauf | Farbton für Beginn und Ende der Fortschrittsanzeige. |
| Atmolight | Farbton und Sättigung des Ambient-Lights. |
| Dimmbare Zwischenstufen | Feinheit der Helligkeitsabstufung. |
| Start-LED-Offset | Ab welcher physischen LED die Anzeige beginnt (siehe Tipp). |
| Pause-Zentrierung | Zentriert die Pause-Anzeige. |
| Laufrichtung | Kehrt die Drehrichtung der Effekte um. |

!!! tip "Das erste Pixel positionieren"
    Sitzt der Ring im Gehäuse „verdreht", legst du mit dem **Start-LED-Offset** fest, an welcher
    physischen LED die Anzeige beginnt – so richtest du den Nullpunkt des Rings an deiner Einbaulage
    aus, ohne umzulöten ([Forum #4670](https://forum.espuino.de/t/neopixel-erstes-pixel-positionieren-geht-das/4670)).

Eine geänderte LED-**Anzahl** übernimmt ESPuino übrigens per automatischem Neustart.

### Energie

<!-- Screenshot: Energie -->

Unter **Deep Sleep** legst du fest, nach wie vielen Minuten Inaktivität sich ESPuino schlafen legt.
Ist die Batteriemessung aktiv, kommen unter **Batterie** diese Werte hinzu:

| Einstellung | Bedeutung |
| --- | --- |
| Warnspannung | Ab dieser Spannung warnt der Neopixel vor niedrigem Akku. |
| Spannung für 0 % / 100 % | Legt die Grenzen der Ladezustands-Anzeige fest (abhängig vom Akkutyp). |
| Kritische Abschaltspannung | Optional: ESPuino schaltet unterhalb automatisch ab. |
| Messintervall | Wie oft die Batteriespannung gemessen wird. |

## Tab Updates

<!-- Screenshot: Updates -->

An dieser Stelle findest du alles rund ums Firmware-Update. Du kannst entweder eine `firmware.bin` von
Hand hochladen, oder – deutlich bequemer – über **Firmware von GitHub laden** direkt einen fertigen
Build aus dem Repository holen. Ausführlich ist das in
[Kapitel 11 · Firmware aktualisieren](../firmware/aktualisieren.md) beschrieben. Der GitHub-Bereich
erscheint nur bei OTA-fähiger Firmware.

## Tab Tools

<!-- Screenshot: Tools -->

Dieser Tab dreht sich um die gespeicherten RFID-Zuweisungen, die – daran sei erinnert – nicht auf der
SD-Karte liegen, sondern im internen Speicher (NVS). Du kannst dir alle **Zuweisungen anzeigen** (und
einzelne direkt löschen), sie als `backup.txt` **exportieren** und wieder **importieren** (der Import
ergänzt und überschreibt nur, löscht nie), oder mit dem roten Button **alle Zuweisungen löschen** (mit
Sicherheitsabfrage). Wie du diese Funktionen zum Sichern und Übertragen nutzt, steht in
[Kapitel 8 → Backup & Restore](../inhalte/verwalten.md#backup-restore-deine-kartenzuordnungen-sichern).

## Tab Hilfe

<!-- Screenshot: Hilfe -->

Der Tab Hilfe verweist auf das [Forum](https://forum.espuino.de) und auf die REST-API-Dokumentation
(Swagger) – Letzteres für alle, die ESPuino skripten oder in ihre Hausautomatisierung einbinden wollen.
