# 4 · Anschließen & Einbau

Die gute Nachricht zuerst: Der Aufbau der Complete ist überschaubar. Die Platine kommt **fertig
bestückt** zu dir – das gesamte SMD-Löten der winzigen Bauteile ist bereits erledigt, und auch die
Lötbrücken, die dein Gerät konfigurieren, sind ab Werk passend zu deiner Bestellung gesetzt. Was
bleibt, ist übersichtlich: ein paar Drähte anlöten, den Drehencoder einstecken, alles ins Gehäuse
bringen. Kein SMD, keine Spezialkenntnisse.

Als Begleitung beim Aufbau eignet sich das ausführliche
[Aufbau-Tutorial im Forum (#3863)](https://forum.espuino.de/t/tutorial-aufbau-complete-platine-samt-inbetriebnahme-und-tipps/3863),
ergänzend die Threads zur [Complete (#3817)](https://forum.espuino.de/t/espuino-complete/3817) und
zum [Encoder-Bausatz (#2414)](https://forum.espuino.de/t/drehencoder-by-espuino/2414).

!!! danger "Zwei Dinge können dein Board zerstören – bitte ernst nehmen"
    - **Prüfe die Polung des Akkus.** Bei LFP-Akkus (unter anderem von Eremit) gab es zwischenzeitlich
      Exemplare mit **vertauschter Polarität**. Verlass dich niemals blind darauf, dass Plus und Minus
      dort liegen, wo du sie erwartest – gleiche die Anschlüsse vor dem ersten Anstecken **unbedingt**
      mit dem Aufdruck auf der Platine ab.
    - **Verlass dich nie auf die Kabelfarben.** Farben von Anschlussleitungen sind nicht genormt;
      maßgeblich ist immer der Aufdruck auf der Platine. Besonders kritisch ist das beim **Neopixel**:
      Vertauschst du hier die Polarität, entsteht ein Kurzschluss, der im schlimmsten Fall die ganze
      Platine zerstört.

## Was du bekommst

Bereits bestückt sind unter anderem der ESP32-WROVER, der Verstärker, der Laderegler, die
Spannungsüberwachung, der Port-Expander und der SD-Slot. Ein paar optionale Steckverbinder (etwa für
I²C) bleiben bewusst unbestückt, damit die Platine übersichtlich bleibt – die brauchst du nur, wenn
du weißt, dass du sie brauchst.

## Die Lötbrücken

Auf der Rückseite sitzen einige Lötbrücken, über die grundlegende Eigenschaften eingestellt werden.
Die gute Nachricht: Sie sind bei deiner Complete bereits **werkseitig passend zu deiner Bestellung**
gesetzt, du musst hier im Normalfall gar nichts tun. Zur Orientierung – und falls du später doch
einmal etwas ändern willst – hier ihre Bedeutung:

| Brücke | Wofür |
| --- | --- |
| JP2 / JP3 | Lautsprecher-Verstärkung (+3 dB oder +15 dB) – es wird immer nur **eine** von beiden gesetzt. |
| JP5 / JP6 | Wahl des Akkutyps (LiPo oder LFP). |
| JP8 | Stromversorgung des RFID-Readers – **muss** gesetzt sein (1+2 oder 2+3). |
| JP1 | nur nötig für den **PN5180 mit LPCD**. |

## Die Drähte anlöten

Jetzt kommen die Verbindungen, die du selbst herstellst. Sie laufen über JST-Steckverbinder, und du
orientierst dich – siehe Warnung oben – **immer am Platinenaufdruck**, nie an der Kabelfarbe.
Anzuschließen sind:

- der **RFID-Reader**: Der RC522 braucht nicht alle Adern; ungenutzte wickelst du zur Sicherheit mit
  Isolierband ab. Der PN5180 nutzt dagegen alle Anschlüsse.
- der **Lautsprecher** (zweipolig).
- der **Neopixel** – ob Ring, Reihe oder einzelne LED – über drei Leitungen (GND, 5 V, Daten). Hier
  gilt noch einmal besonders: auf die Polung achten.
- die **Tasten** (jeweils zweipolig).
- optional die **Kopfhörerplatine**, die du in den sechspoligen Anschluss steckst.

## Der Drehencoder

Der Drehencoder muss nicht gelötet werden – er wird einfach über einen fünfpoligen JST-PH-Stecker
**eingesteckt**, sofern du den [ESPuino-Encoder-Bausatz](https://forum.espuino.de/t/drehencoder-by-espuino/2414)
verwendest. Falls sich später herausstellt, dass „lauter" und „leiser" vertauscht sind, ist das kein
Grund zum Umlöten: Die Drehrichtung lässt sich im Webinterface umkehren.

## Der Einbau ins Gehäuse

Als **Referenz-Design** dient die **[BioBox 3D](https://forum.espuino.de/t/biobox-3d/3130)**, ein
3D-druckbares Gehäuse für Complete oder mini4L. Sie gibt eine gute Vorstellung davon, wie ein
fertiger ESPuino aussehen kann: ein Würfel mit rund 12 cm Kantenlänge, vorn ein Wabengitter für den
Lautsprecher mit einer Vertiefung für den Neopixelring, oben drei Tasten und der Drehencoder, hinten
USB-C und Kopfhörerbuchse, unten eine Revisionsöffnung und eine Akkuhalterung (für 18650-, 26650-
oder 32700-Zellen). Die Druckdateien gibt es als STL und als Fusion-360-Datei; empfohlen werden PETG,
fünf Wandschichten und 35 % Infill (etwa 17 Stunden Druckzeit).

Beim Einsetzen der SD-Karte noch einmal der Hinweis auf das Dateisystem: Sie muss **FAT32** sein.
Karten über 32 GB sind ab Werk oft exFAT-formatiert und müssen dann erst neu als FAT32 formatiert
werden.

!!! tip "Weitere Inspiration"
    Wie vielfältig ESPuinos aussehen können, zeigt die Galerie
    [„Zeigt her eure ESPuinos" (#554)](https://forum.espuino.de/t/zeigt-her-eure-espuinos/554) – eine
    schöne Fundgrube für eigene Gehäuse-Ideen.

## Nach dem Zusammenbau: die Feinjustierung

Ist alles verbaut, folgt der [erste Start](../inbetriebnahme/erststart.md). Ein paar Einstellungen
solltest du dabei einmalig an deine konkrete Hardware anpassen – am bequemsten gleich im Webinterface.

Am wichtigsten sind die **Batterie-Spannungsschwellen**, denn sie hängen vom Akkutyp ab. ESPuino
kann sonst einen vollen LFP-Akku für halb leer halten oder umgekehrt. Als Anhaltspunkt:

| Akku | Warnung ab | erste LED ab | alle LEDs ab |
| --- | --- | --- | --- |
| **LFP** | 3,0 V | 2,9 V | 3,25 V |
| **LiPo** | 3,2 V | 3,1 V | 4,2 V |

Sollte die angezeigte Spannung trotzdem nicht zur Realität passen – etwa wenn ein frisch geladener
Akku als „nicht ganz voll" gemeldet wird –, lässt sich die Messung **kalibrieren**: Vergleiche die
ESPuino-Anzeige mit einer Messung per Multimeter und trage die Differenz über den Parameter
`offsetVoltage` in der `settings-complete.h` ein (siehe
[Kapitel 12](../firmware/compile-zeit.md#werte-nur-per-settingsh-kein-webinterface)).

Ansonsten ist jetzt der richtige Moment, um bei Bedarf die **Neopixel-Drehrichtung** und die
**Drehencoder-Richtung** zu korrigieren, die **Tastenbelegung** anzupassen und die ersten
**RFID-Karten** anzulernen.
