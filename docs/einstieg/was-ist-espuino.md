# 1 · Was ist ESPuino?

## Die Idee in einem Satz

ESPuino ist ein selbstgebauter, RFID-gesteuerter Audio-Player: Du legst eine Karte auf, und ein
Hörspiel, ein Hörbuch oder eine Playlist beginnt zu spielen. Nimmst du die Karte wieder ab oder
legst eine andere auf, wechselt der Inhalt. Das ist ein Bedienkonzept, das schon die Kleinsten
sofort verstehen – und genau dafür ist ESPuino in erster Linie gedacht: als robuste, kindgerechte
Hörbox, die ohne Bildschirm, ohne Konto und ohne Cloud auskommt.

Der Name verrät die Herkunft: Im Herzen steckt ein Mikrocontroller der **ESP32**-Familie. Um diesen
Kern herum ist über die Jahre ein erstaunlich vollständiges Gerät gewachsen – mit Verstärker,
Akkuladung, LED-Anzeige, Tasten und Drehregler. Trotzdem bleibt ESPuino ein offenes Bastel- und
Selbstbauprojekt: Der Quellcode ist frei, die Hardware dokumentiert, und du entscheidest selbst, wie
groß, wie laut und wie bunt deine Box wird – wie vielfältig das ausfällt, zeigt die Galerie
[„Zeigt her eure ESPuinos"](https://forum.espuino.de/t/zeigt-her-eure-espuinos/554).

Ein Punkt ist wichtig zu verstehen, weil er später manches erklärt: **Auf die Karten selbst wird
nichts geschrieben.** ESPuino liest lediglich die eindeutige Nummer (die ID) einer Karte
und merkt sich intern, welcher Inhalt dazu gehört. Du kannst also handelsübliche RFID-Karten, Chips
oder Aufkleber verwenden – konkret die Standards **ISO-14443** und (nur mit dem PN5180-Reader)
**ISO-15693** – und dieselbe Karte später jederzeit neu belegen.

## Woraus besteht ein ESPuino?

Das ist die Frage, die am häufigsten gestellt wird – deshalb gleich zu Beginn eine Übersicht. Die
folgende Liste beschreibt einen typischen ESPuino auf Basis der **Complete**-Platine, um die es in
diesem Handbuch geht. Vieles davon steckt bei der Complete schon fertig auf der Platine; du ergänzt
nur noch die Teile, die von deinen Wünschen abhängen (welcher Lautsprecher, welcher Akku, welches
Gehäuse).

| Baustein | Wozu, und was du wissen solltest |
| --- | --- |
| **Complete-Platine** | Das Fundament. Sie bringt ESP32-WROVER, Verstärker, Laderegler, Spannungsüberwachung, Port-Expander und SD-Slot schon mit. |
| **RFID-Reader** | Liest die Karten. Zur Wahl stehen der günstige RC522 oder der leistungsfähigere PN5180. |
| **SD-Karte** | Speichert deine Inhalte. Muss **FAT32** formatiert sein; 32 bis 64 GB sind im Normalfall ausreichend. |
| **Neopixel** | Adressierbare LED(s) für Status und Fortschritt – am häufigsten ein Ring, es geht aber auch eine Reihe oder eine einzelne LED. Formal optional, in der Praxis aber **kaum verzichtbar**: Sie sind das zentrale Rückmelde-Instrument (Verbindung, Fortschritt, Batterie, Fehler …). **Dringend empfohlen.** |
| **Lautsprecher** | Für den Ton. Kopfhörer sind optional über eine separate Kopfhörerplatine möglich. |
| **Drehencoder + bis zu 5 Tasten** | Die Bedienung am Gerät; beides ist optional. Das Standardlayout sieht drei Tasten und den Drehencoder vor. |
| **Akku** | Für den mobilen Betrieb (LiFePO4 oder LiPo, jeweils **mit Schutzschaltung**). Ebenfalls optional – ESPuino läuft auch einfach am USB-Netzteil. Details in [Kapitel 4 · Der Akku](../hardware/akku.md). |
| **Gehäuse** | Meist 3D-gedruckt. Ein fertiges Referenzdesign findest du in [Kapitel 5](../hardware/aufbau.md#einbau-ins-gehause). |

Ausführlicher ist das auch in der [FAQ im Forum](https://forum.espuino.de/t/oft-gestellte-fragen-faq/24)
beschrieben.

## Das ESPuino-Ökosystem

ESPuino ist mehr als ein einzelnes Repository, und es hilft, die Teile einmal einzuordnen – dann
weißt du später, wo du was findest:

- **[ESPuino](https://github.com/biologist79/ESPuino)** ist die **Firmware**, also die Software, die
  auf dem Gerät läuft. Sie ist der Gegenstand dieses Handbuchs.
- **[ESPuino-Firmware](https://github.com/biologist79/ESPuino-Firmware)** stellt **fertig gebaute Firmware-Versionen** bereit, die du ohne eigenes
  Kompilieren aufspielen kannst.
- **[MediaHub](https://github.com/biologist79/ESPuino-Mediahub)** ist eine optionale Zusatzkomponente,
  um die Kartenzuweisungen mehrerer ESPuinos **zentral** zu verwalten (siehe
  [Kapitel 10](../inhalte/mediahub.md)).
- Das **[Forum](https://forum.espuino.de)** ist der Ort für Fragen, Ankündigungen und Austausch mit
  anderen. Dieses Handbuch bündelt das Wissen; die Diskussion lebt weiter im Forum.

## Ein Blick zurück: die Entwicklungslinie

ESPuino ist über mehrere Jahre gewachsen, und es lohnt sich, das kurz einzuordnen – schon weil dir
im Forum noch ältere Aufbauten begegnen. Am Anfang standen echte Eigenbauten, bei denen einzelne
Module zusammengesteckt und verdrahtet wurden. Daraus wurden Aufbauten auf Streifenrasterplatinen,
später Carrier-Platinen, die fertige Entwicklerboards aufnahmen. Der direkte Vorgänger der heutigen
Complete ist die **mini4L**, in die ein eigens entwickeltes ESP32-Board gesteckt wurde.

Die **Complete** ist die konsequente Weiterentwicklung dieser Linie: Sie bietet funktional im Kern
das Gleiche wie die mini4L, vereint aber alles (bis auf die Kopfhörerplatine) auf einer einzigen
Platine. Das senkt die Kosten und vereinfacht den Aufbau erheblich. Genau deshalb dreht sich dieses
Handbuch um die Complete; die mini4L kommt als jüngster Vorgänger noch vor, aber nur dort, wo sie
sich von der Complete unterscheidet ([Kapitel 15](../referenz/mini4l.md)). Ältere Stufen behandeln
wir nicht.

## Kleines Glossar

Ein paar Begriffe tauchen im Handbuch immer wieder auf. Du musst sie nicht auswendig lernen – schlag
im Zweifel einfach hier nach:

| Begriff | Bedeutung |
| --- | --- |
| RFID | Kontaktlose Karte oder Tag, mit der ein Inhalt gestartet wird. ESPuino liest nur die ID, es schreibt nichts auf die Karte. |
| NVS | „Non-Volatile Storage" – der interne Speicher des ESP32, in dem Einstellungen und Kartenzuordnungen liegen. Ein normales Firmware-Update überschreibt ihn **nicht**; deine Einstellungen bleiben also erhalten. |
| HAL | „Hardware Abstraction Layer" – wählt beim Kompilieren, für welches Board (mit welchen Pins) die Firmware gebaut wird; oft auch **Plattform** genannt (z. B. `complete`, `lolin_d32_pro_sdmmc_pe`, `lolin_d32_pro`). |
| Neopixel | Adressierbare LED(s) zur Status- und Fortschrittsanzeige. Oft als Ring angeordnet; idealerweise ist die LED-Anzahl **durch vier teilbar**, weil mehrere Animationen darauf ausgelegt sind. |
| Deep-Sleep | Der stromsparende Tiefschlaf, in den sich ESPuino nach Inaktivität legt. |
| Playmode | Der Abspielmodus einer Karte (Einzeltitel, Hörbuch, ganzer Ordner …). Alle Modi im Detail: [Kapitel 7 → Abspielmodi](../bedienung/webinterface.md#abspielmodi). |
| Modifikationskarte | Eine Karte, die keine Inhalte startet, sondern eine Funktion auslöst – etwa einen Schlaftimer. Alle Aktionen im Detail: [Kapitel 7 → Modifikationskarten](../bedienung/webinterface.md#modifikationskarten-alle-optionen). |
| LiPo | Lithium-Polymer-Akku. Nennspannung ~3,7 V, Ladeschluss 4,2 V. Hohe Energiedichte (viel Kapazität pro Größe/Gewicht), dafür empfindlicher und weniger langlebig. |
| LFP | Lithium-Eisenphosphat-Akku (LiFePO₄). Nennspannung ~3,2–3,3 V, Ladeschluss ~3,6 V. Sehr sicher und langlebig, dafür geringere Energiedichte (weniger Kapazität) und niedrigere Spannung. |
