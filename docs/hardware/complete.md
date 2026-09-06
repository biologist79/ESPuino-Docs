# 3 · Die Complete-Platine

## Was die Complete besonders macht

Die Complete ist die aktuelle ESPuino-Platine und der Bezugspunkt dieses Handbuchs. Ihr großer
Vorzug lässt sich in einem Wort zusammenfassen: **Integration**. Wo bei den Vorgängern noch mehrere
Baugruppen zusammengesteckt und verdrahtet werden mussten, sitzt bei der Complete fast alles auf
einer einzigen Platine – ESP32-WROVER, Verstärker, Laderegler, Spannungsüberwachung, der
Port-Expander für zusätzliche Anschlüsse und der SD-Kartenslot. Funktional bietet sie damit im Kern
das Gleiche wie die frühere mini4L, ist aber günstiger und deutlich schneller aufgebaut. Einzig die
Kopfhörerplatine bleibt eine separate, optionale Ergänzung.

Für dich heißt das konkret: Du bekommst die Platine **fertig bestückt**. SMD-Löten – also das feine
Löten winziger Bauteile – ist bereits ab Werk erledigt. Was noch zu tun bleibt, ist das Anlöten
einiger Drähte und Stecker, und das ist in [Kapitel 5](aufbau.md) beschrieben.

## Technische Eckdaten

Bevor wir ins Detail gehen, die harten Fakten auf einen Blick:

| Merkmal | Wert |
| --- | --- |
| Abmessungen | 72,2 × 70,6 mm, vier Befestigungslöcher (⌀ 3,2 mm) |
| Aufbau | vierlagige Platine, fertig SMD-bestückt |
| Controller | ESP32-WROVER, 16 MB Flash, 8 MB PSRAM |
| Stromversorgung | Buck/Boost-Schaltregler (TPS63000), konstant 3,3 V |
| Eingänge | USB-C und/oder Akku (LiPo oder LFP), beide verpolgeschützt |
| Laderegler | fest max. 1 A Ladestrom, Status-LED an Bord |
| Verstärker | MAX98357A, Mono, ~1 W an 4 Ω |
| Audiospeicher | microSD (SD-MMC, 1-Bit), FAT32 |
| Erweiterung | PCA9555-Port-Expander für zusätzliche Ein-/Ausgänge |

Alles Weitere – welche Leitung wohin gehört, welche Lötbrücke was bewirkt – steht in den folgenden
Abschnitten, unter anderem in der [Pinout-Referenz](#pinout-referenz-complete).

## Die Stromversorgung { #die-stromversorgung-und-warum-sie-so-wichtig-ist }

ESPuino soll an ganz unterschiedlichen Quellen laufen – am
USB-Netzteil, an einem LiPo-Akku oder an einem LiFePO4-Akku (LFP). Und egal, welche davon gerade
anliegt und wie voll der Akku ist: Hinten müssen stabile **3,3 Volt** für den ESP32 herauskommen.

Genau das war früher der wunde Punkt. Die mini4L versorgte den Controller über einen sogenannten
Linearregler (LDO). Ein solcher Regler „verheizt" die überschüssige Spannung, braucht aber selbst
einen kleinen Vorlauf: War der Akku fast leer und lieferte nur noch etwa 3,3 V, kamen hinten bloß
noch rund 3,1 V an – eigentlich schon zu wenig für den ESP32 (in der Praxis lief es meist trotzdem,
aber sauber ist anders). Besonders heikel wird das bei LFP-Akkus, die von Haus aus nur etwa 3,2–3,3 V
liefern; deshalb musste man dort den Regler kurzerhand umgehen.

Die Complete löst das grundsätzlich mit einem **Buck/Boost-Schaltregler**. Der kann eine zu hohe
Spannung heruntersetzen *und* eine zu niedrige hochsetzen und liefert dadurch konstant 3,3 V –
unabhängig von Quelle und Ladezustand. Dazu kommt eine **Unterspannungs-Abschaltung**, die das Gerät
schützt, bevor der Akku zu tief entladen wird. Dennoch sei an dieser Stelle vorweggenommen, dass
dieser Schutz niemals die Abschaltfunktion eines [BMS](akku.md) ersetzt, das zwingend im verwendeten
Akkupack eingebaut sein muss.

Beide Eingänge – USB-C und Akku – sind zudem **gegen Verpolung geschützt**. Der eingebaute
**Laderegler** lädt den Akku mit fest eingestellten **maximal 1 A**. Damit dieser Ladestrom einen
Akku nicht überfordert (Faustregel: höchstens die halbe Kapazität pro Stunde, „0,5 C"), sollte der
Akku **mindestens 2000 mAh** haben. Die Unterspannungs-Abschaltung greift je nach Akkutyp bei
unterschiedlichen Schwellen: bei **LFP etwa 2,75 V**, bei **LiPo etwa 3,15 V**. Diese Werte liegen
bewusst mit etwas Reserve über der absoluten Entladegrenze – das schont den Akku und verhindert, dass
kurze Stromspitzen (etwa bei lautem Ton) das Gerät gleich abschalten.

## Laden & Lade-LED

An Bord sitzt eine kleine **Status-LED**, die dir den Ladezustand direkt an der Platine anzeigt:

| LED | Bedeutung |
| --- | --- |
| schnelles Blinken | USB angeschlossen, aber kein Akku erkannt |
| Dauerleuchten | USB und Akku angeschlossen – der Akku wird geladen |
| aus | Akku voll (bei USB + Akku) oder Betrieb nur am Akku |

Möchtest du diese Anzeige nach außen ans Gehäuse führen, gibt es einen eigenen **2-poligen Anschluss
für eine externe Lade-LED**. Der nötige Vorwiderstand sitzt schon auf der Platine, du kannst die LED
also direkt anschließen – achte nur auf die aufgedruckte **Polarität**.

Ein Hinweis fürs Verständnis: **Während des Ladens** ist die gemessene Akkuspannung nicht
aussagekräftig, weil der Ladevorgang sie künstlich anhebt. Eine verlässliche Ladestandsanzeige gibt
es daher nur im reinen Akkubetrieb (mehr dazu in [Kapitel 4](akku.md)).

## Ein- und Ausschalten

Im Normalfall „schaltet" der **Taster im Drehencoder** den ESPuino ein und aus – tatsächlich geht er
dabei in den stromsparenden **Deep-Sleep** und wacht auf Tastendruck sofort wieder auf (siehe
[Glossar](../einstieg/was-ist-espuino.md) und [Kapitel 9](../bedienung/am-geraet.md)). Für die meisten
ist das völlig ausreichend.

Wer den Ruhestrom noch weiter senken möchte, kann einen **echten Ausschalter** vorsehen. Die Complete
hat dafür einen **2-poligen Power-Off-Anschluss**: Ein daran angeschlossener Schalter trennt die
zentrale 3,3-V-Versorgung vollständig – der ESP32 ist dann wirklich aus, nicht nur im Schlaf.

!!! note "Power-Off-Switch: die Kehrseiten"
    - Das **Laden über USB funktioniert weiter**, auch wenn per Schalter „aus".
    - Der Start dauert danach **etwas länger** (voller Kaltstart statt Aufwachen aus dem Deep-Sleep).
    - Mit dem PN5180-**LPCD-Aufwecken** ist der harte Ausschalter **nicht kombinierbar** – beides
      schließt sich gegenseitig aus.

## Stromverbrauch & Netzteil

Im Betrieb zieht ein ESPuino grob **140 bis 350 mA**, je nach Lautstärke und wie hell die Neopixel
leuchten. Kommt das **Laden** dazu, addieren sich **bis zu 1 A**. Damit dein Netzteil in keiner Lage
knapp wird – lauter Ton und gleichzeitiges Laden –, solltest du ein **USB-Netzteil mit mindestens
1,5 A** verwenden.

## Der Verstärker und der Ton

Für den Ton sorgt ein **MAX98357A**, ein kleiner Class-D-Verstärker mit integriertem
Digital-Analog-Wandler. Er liefert **rund 1 Watt an einem 4-Ohm-Lautsprecher** – genug für eine
kompakte Hörbox in Zimmerlautstärke. Bewährt haben sich kleine Breitbandlautsprecher wie der
**Visaton FR 7** (4 Ω).

Ein Unterschied zur mini4L: Die Complete hat **nur einen Verstärker** und damit **einen
Lautsprecherausgang**. „Mono" im Sinne von *ein Kanal fällt weg* trifft es dabei nicht – auf dem
Ausgang liegen **beide Stereokanäle zusammengemischt** (Summe aus links und rechts), es geht also
nichts verloren. Es ist damit ein einkanaliger Ausgang – für eine kompakte Hörbox genau das Richtige.
Am **Kopfhörerausgang** (über die separate Kopfhörerplatine) steht dir Stereo zur Verfügung.

Die **Grundverstärkung** stellst du per Lötbrücke ein: **ohne** Brücke sind es **+9 dB**, mit **JP2**
**+3 dB** und mit **JP3** **+15 dB** – es darf immer nur eine der beiden gesetzt sein. **Ab Werk ist
JP2 gesetzt** (+3 dB). Das ist für eine Hörbox erfahrungsgemäß laut genug und hat einen angenehmen
Nebeneffekt: Bei der niedrigeren Grundverstärkung liegen die **21 Lautstärkestufen der Software enger
beieinander**, sodass sich die Lautstärke **feiner regeln** lässt. Die Details zu diesen Lötbrücken
stehen bei den [Lötbrücken in Kapitel 5](aufbau.md#die-lotbrucken).

## Versionen & Lieferumfang

Die aktuelle Revision der Complete ist **5.1**. Sie vereint beide Akkuvarianten auf **einer Platine** –
ob LFP oder LiPo, legst du über die Lötbrücken **JP5/JP6** fest (siehe
[Kapitel 5](aufbau.md#die-lotbrucken)). Der **Reset-Taster** wird seit 09/2026 ab Werk bestückt.

Von den wenigen früheren Platinen (Rev. 5.0/5.0.1) sind nur eine Handvoll im Umlauf; falls du eine
solche besitzt, sind die kleinen Abweichungen bei den [Lötbrücken in Kapitel 5](aufbau.md#die-lotbrucken)
vermerkt.

Beim Kauf hast du die Auswahl zwischen drei Varianten – welche für dich passt, hängt davon ab, wie viel du selbst
beisteuern möchtest (Details und Preise stehen in der
[Preisliste #3344](https://forum.espuino.de/t/preisliste/3344)):

- **Nur die Platine** – die fertig bestückte Complete allein, ohne weiteres Zubehör.
- **Set 1** – die Platine samt der nötigen **Anschlussleitungen**.
- **Set 2** – wie Set 1, zusätzlich mit der **Kopfhörerplatine**.

!!! note "Akkutyp bei der Bestellung angeben"
    Bei der Bestellung musst du angeben, ob du die **LiPo-** oder die **LFP-Version** möchtest. Der
    passende Akkutyp wird ab Werk über die Lötbrücken auf der Platine vorkonfiguriert – du musst
    daran also nichts selbst einstellen. Möchtest du später doch auf den anderen Akkutyp wechseln,
    lässt sich das aber jederzeit nachträglich ändern, indem du ein bis zwei Lötbrücken umsetzt (mehr
    dazu bei den Lötbrücken in [Kapitel 5](aufbau.md#die-lotbrucken)).

## Anschlüsse, Bedienelemente, Pinout

Welche Funktion auf welchem Anschluss liegt, zeigt die folgende Pinout-Referenz – beim Verdrahten
schlägst du hier im Zweifel nach.

### Pinout-Referenz { #pinout-referenz-complete }

Aus `settings-complete.h`. **Wichtig:** Werte **≥ 100** sind **Port-Expander-Kanäle** (PCA9555,
Kanal = Wert − 100), keine direkten ESP32-GPIOs; `99` = ungenutzt/Dummy.

Der Unterschied ist praktisch relevant: Ein Port-Expander-Kanal lässt sich **nicht so universell**
einsetzen wie ein echter GPIO. Er taugt im Wesentlichen dazu, **auf einen Taster zu reagieren**
(Eingang) oder **etwas zu schalten** (Ausgang) – und selbst das muss für eigene Erweiterungen erst
**programmiert** werden. Mehr zum Port-Expander steht in [Kapitel 12](../vertiefung/erweiterte-themen.md).

| Funktion | Signal | Pin |
| --- | --- | --- |
| **Audio (I²S)** | DOUT / BCLK / LRC | GPIO 25 / 27 / 26 |
| **RFID (SPI)** | CS / SCK / MOSI / MISO | GPIO 21 / 18 / 23 / 19 |
| RFID (nur PN5180) | RST / BUSY / IRQ | GPIO 22 / 33 / 32 |
| **SD-Karte** | SD-MMC 1-Bit: CLK / CMD / D0 | GPIO 14 / 15 / 2 |
| **Drehencoder** | CLK / DT | GPIO 34 / 39 |
| Drehencoder | Taster | PE 105 |
| **Buttons** | Previous / Pause-Play / Next | PE 100 / 101 / 102 |
| Buttons | Button 4 / Button 5 | PE 103 / 104 |
| **Neopixel** | LED-Signal | GPIO 12 |
| **Power** | Peripherie-Abschaltung (`POWER`) | PE 114 |
| Power | Verstärker (`GPIO_PA_EN`) | PE 113 |
| **Batterie** | Spannungsmessung (ADC) | GPIO 35 |
| **Kopfhörer** | Buchsen-Erkennung (`HP_DETECT`) | PE 108 |
| **Wakeup / PE-Interrupt** | Aufwecken aus Deep-Sleep | GPIO 36 |
| **IR (optional)** | IR-Empfänger | GPIO 5 |

!!! note "Freie GPIOs"
    Am Erweiterungsanschluss Ext.Conn1 liegen die noch **freien GPIO 0, 5 und 32**. Zwei Dinge solltest
    du dabei wissen: **GPIO 0** wird vom ESP32 für interne Zwecke (Bootmodus) gebraucht und sollte nur
    im **Notfall** anderweitig verwendet werden. **GPIO 32** ist die **IRQ-Leitung des PN5180** und
    damit nur frei, solange du **kein LPCD** nutzt – im LPCD-Modus (JP1/JP8) belegt sie der Reader.
    **GPIO 5** schließlich ist der Eingang für den optionalen IR-Empfänger.

### Die Anschlüsse im Überblick

Fast alles wird über kleine **JST-PH-Steckverbinder** angeschlossen – jeder hat seine eigene Polzahl,
sodass man sie kaum verwechselt. Diese Übersicht zeigt, was wohin gehört:

| Anschluss | Stecker | Wofür |
| --- | --- | --- |
| RFID-Reader | 10-polig | RC522 oder PN5180 (Belegung siehe unten) |
| Lautsprecher | 2-polig | ein Mono-Lautsprecher |
| Drehencoder | 5-polig | Lautstärke + Taster (Ein/Aus) |
| Neopixel | 3-polig | Status- und Fortschritts-LEDs |
| Taster (bis zu 5) | je 2-polig | Previous, Play/Pause, Next, Button 4/5 |
| Kopfhörerplatine | 6-polig | optionaler Kopfhörerausgang |
| externe Lade-LED | 2-polig | optionale Lade-Anzeige am Gehäuse |
| Power-Off-Switch | 2-polig | optionaler echter Ausschalter |
| Akku | 2-polig | LiPo oder LFP mit BMS |

!!! warning "Nie auf die Litzenfarben verlassen"
    Steckerbelegungen richten sich nach der **Beschriftung auf der Platine**, nicht nach der Farbe der
    Litzen an einer fertigen Leitung. Gleiche vor dem Anstecken immer Signal für Signal mit dem
    Platinenaufdruck ab.

### RFID-Steckerbelegung { #rfid-steckerbelegung }

Der RFID-Anschluss der Complete ist ein **10-poliger Stecker**. Die Belegung orientiert sich am
PN5180, der alle Leitungen nutzt; der RC522 kommt mit weniger aus. Welcher Reader steckt, **erkennt
die Firmware automatisch** – die Belegung ist reine Hardware. In der folgenden Tabelle steht „–" für
das, was der RC522 nicht benötigt.

| Anschluss (Complete) | PN5180 | RC522 | Bedeutung |
| --- | --- | --- | --- |
| **5 V** | +5 V | – | Liefert nur 3,3 V, versorgt den PN5180 aber dennoch |
| **3,3 V** | +3,3 V | 3,3 V | Spannungsversorgung |
| **RST** | RST | – | Reset (nur PN5180) |
| **CS** | NSS | SDA | SPI: Chip-/Slave-Select |
| **MOSI** | MOSI | MOSI | SPI: Master Out, Slave In |
| **MISO** | MISO | MISO | SPI: Master In, Slave Out |
| **SCK** | SCK | SCK | SPI: Takt |
| **BUSY** | BUSY | – | Busy (nur PN5180) |
| **IRQ** | IRQ | – | Interrupt (nur PN5180) |
| **GND** | GND | GND | Masse |

Für den **RC522** sind also nur die SPI-Leitungen (CS/MOSI/MISO/SCK) plus **3,3 V** und **GND**
nötig; RST, BUSY und IRQ lässt man weg (sie bewirken dort nichts). Quelle:
[Forum → ESPuino Complete (#3817)](https://forum.espuino.de/t/espuino-complete/3817).

## Die Komponenten auswählen

Ein Teil der Bauteile hängt von deinen Vorlieben ab. Hier die Entscheidungen, die anstehen:

- **RFID-Reader:** Zur Wahl stehen der **RC522** (günstig, für die meisten völlig ausreichend) und
  der **PN5180** (empfindlicher, größere Reichweite, und Voraussetzung für das optionale
  LPCD-Aufwecken). Dank Auto-Erkennung (siehe unten) legst du dich nicht per Firmware fest.
- **microSD-Karte:** Eine ganz normale microSD-Karte, **FAT32** formatiert. Karten ab 64 GB sind ab Werk normalerweise
  exFAT-formatiert und müssen erst umformatiert werden (siehe Hinweis). Sehr große oder sehr billige Karten
  laufen zudem nicht immer zuverlässig. Solltest du auf Probleme stoßen, probiere es im Zweifel mit
  einer anderen (kleineren) Karte.
- **Akku:** optional – ESPuino läuft auch dauerhaft am USB-Netzteil. Für den mobilen Betrieb ist die
  Wahl zwischen **LFP** und **LiPo** wichtig genug für ein eigenes Kapitel: siehe
  [Kapitel 4 · Der Akku](akku.md).
- **Lautsprecher:** nach Geschmack und Gehäusegröße; ein 4-Ohm-Breitbänder wie der Visaton FR 7 passt
  gut. Der Verstärker leistet maximal **1 W** – ein übermäßig großer Lautsprecher bringt hier also
  nichts.
- **Kopfhörer:** optional über die separate **Kopfhörerplatine** (mit dem MS6324-Chip,
  [Forum #1099](https://forum.espuino.de/t/kopfhoererplatine-basierend-auf-ms6324-und-tda1308-bzw-lm4808m/1099)).

!!! info "Der RFID-Reader-Typ ist keine Firmware-Frage mehr"
    Früher musste man beim Flashen die passende Firmware-Variante für RC522 oder PN5180 wählen. Seit
    Mai 2026 **erkennt ESPuino den Reader automatisch** zur Laufzeit. Die Reader-Wahl ist damit eine
    reine Hardware-Entscheidung, um die du dich beim Firmware-Update nicht mehr kümmern musst.

!!! tip "Große Karten auf FAT32 formatieren"
    Karten ab 64 GB (SDXC) sind ab Werk als exFAT formatiert. Windows bietet FAT32 für so große
    Karten im Standard-Dialog nicht an – hier hilft ein Tool wie „FAT32 Format" (guiformat). Den
    offiziellen [SD Card Formatter](https://www.sdcard.org/downloads/formatter/) kannst du gut nutzen,
    um eine Karte sauber zurückzusetzen; er formatiert große Karten aber nach SD-Norm als exFAT – für
    FAT32 brauchst du also zusätzlich das genannte Tool.

## Grenzen der Platine

Damit du weißt, was die Complete bewusst *nicht* kann:

- **Nur ein Verstärker** – kein echter Stereobetrieb mit zwei getrennt angesteuerten Lautsprechern.
- **Keine 5-V-Logik** – intern arbeitet alles mit 3,3 V.
- **Kein Coulomb-Zähler** – der Ladestand wird aus der **Akkuspannung** geschätzt, nicht exakt
  mitgezählt. Gerade bei LFP ist die Spannung über weite Teile der Entladung sehr flach, die Anzeige
  entsprechend grob (mehr dazu in [Kapitel 4](akku.md)).

## Schaltpläne, 3D-Modell & Dokumente

Wer tiefer einsteigen oder ein Gehäuse konstruieren möchte, findet im
[Complete-Thread (#3817)](https://forum.espuino.de/t/espuino-complete/3817) die vollständigen
Unterlagen – **Schaltpläne** (rev 5.0.1 und rev 5.1 als PDF) sowie ein **3D-Modell** der Platine
(STEP-Datei). Die Befestigungslöcher sitzen in den vier Ecken (⌀ 3,2 mm); die genauen Abstände
entnimmst du am besten dem 3D-Modell.

## Für Fortgeschrittene: weitere Anschlüsse

??? info "Ext.Conn1, Ext.Conn2, Ext.USB und der Port-Expander"
    Diese Anschlüsse brauchst du für einen normalen Aufbau **nicht** – sie sind für Sonderfälle
    gedacht und teils ab Werk unbestückt (auf Wunsch bestückbar).

    - **Ext.Conn1** führt zusätzliche Signale heraus: **3,3 V geschaltet** (nur im Betrieb aktiv, im
      Deep-Sleep aus), **3,3 V dauerhaft**, **Batterie +**, die noch freien **GPIO 0, 5 und 32** (mit
      den Einschränkungen aus dem Hinweis „Freie GPIOs" oben) und die Port-Expander-Kanäle
      **PE109/PE112**.
    - **Ext.Conn2** bietet **GND** und zwei Spannungen: **OOut** (~4,6 V bei USB, sonst Akkuspannung;
      USB hat Vorrang) und **Vin** (wie OOut, lässt sich aber vom Power-Off-Switch abschalten).
    - **Ext.USB** ist ein alternativer 5-V-Eingang (VUSB, GND, CC1, CC2); die nötigen
      5,1-kΩ-Widerstände sind schon bestückt. **Achtung:** Dieser Eingang ist **nicht verpolgeschützt**
      – nur für Erfahrene.
    - Der **PCA9555-Port-Expander** stellt zusätzliche Ein-/Ausgänge bereit; er bedient intern unter
      anderem die Taster und einige Steuerleitungen und ist auch in
      [Kapitel 12](../vertiefung/erweiterte-themen.md) Thema.

## Bestellen & Zubehör

Die Complete und optionales Zubehör – etwa die Kopfhörerplatine oder der Drehencoder-Bausatz –
kannst du beim Entwickler beziehen. Was es gibt und was es kostet, steht in der
[Preisliste im Forum (#3344)](https://forum.espuino.de/t/preisliste/3344).
