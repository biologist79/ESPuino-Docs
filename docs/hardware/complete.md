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
Löten winziger Bauteile – ist bereits ab Werk erledigt. Was noch zu tun bleibt, sind ein paar Drähte
und Stecker, und das ist in [Kapitel 4](aufbau.md) beschrieben.

## Die Stromversorgung – und warum sie so wichtig ist

Ein Detail verdient besondere Aufmerksamkeit, weil es die Complete spürbar zuverlässiger macht als
ihre Vorgänger: die Stromversorgung. ESPuino soll an ganz unterschiedlichen Quellen laufen – am
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
schützt, bevor der Akku zu tief entladen wird. Kurz gesagt: stabile Versorgung ohne Kompromisse.

## Versionen & Lieferumfang

Die aktuelle Revision der Complete ist **5.1**.

Beim Kauf hast du drei Varianten – welche für dich passt, hängt davon ab, wie viel du selbst
beisteuern möchtest (Details und Preise stehen in der
[Preisliste #3344](https://forum.espuino.de/t/preisliste/3344)):

- **Nur die Platine** – die fertig bestückte Complete allein, ohne weiteres Zubehör.
- **Set 1** – die Platine samt der nötigen **Anschlussleitungen**.
- **Set 2** – wie Set 1, zusätzlich mit der **Kopfhörerplatine**.

!!! note "Akkutyp bei der Bestellung angeben"
    Bei der Bestellung musst du angeben, ob du die **LiPo-** oder die **LFP-Version** möchtest. Der
    passende Akkutyp wird ab Werk über die Lötbrücken auf der Platine vorkonfiguriert – du musst
    daran also nichts selbst einstellen (mehr dazu bei den Lötbrücken in
    [Kapitel 4](aufbau.md#die-lotbrucken)).

## Anschlüsse, Bedienelemente, Pinout

Welche Funktion auf welchem Anschluss liegt, ist vollständig im
[Anhang → Pinout-Referenz Complete](../referenz/anhang.md#pinout-referenz-complete) tabelliert – dort
schlägst du im Zweifel beim Verkabeln nach.

## Die Komponenten auswählen

Ein Teil der Bauteile hängt von deinen Vorlieben ab. Hier die Entscheidungen, die anstehen:

- **RFID-Reader:** Zur Wahl stehen der **RC522** (günstig, für die meisten völlig ausreichend) und
  der **PN5180** (empfindlicher, größere Reichweite, und Voraussetzung für das optionale
  LPCD-Aufwecken). Dank Auto-Erkennung (siehe unten) legst du dich nicht per Firmware fest.
- **SD-Karte:** Eine ganz normale Karte, **FAT32** formatiert. Sehr große oder sehr billige Karten
  laufen erfahrungsgemäß nicht immer zuverlässig.
- **Akku:** LiPo oder LFP – je nach Wahl werden am Board die passenden Lötbrücken gesetzt (siehe
  [Kapitel 4](aufbau.md)). Oder du lässt den Akku ganz weg und betreibst ESPuino am USB-Netzteil.
- **Lautsprecher:** nach Geschmack und Gehäusegröße.
- **Kopfhörer:** optional über die separate **Kopfhörerplatine** (mit dem MS6324-Chip,
  [Forum #1099](https://forum.espuino.de/t/kopfhoererplatine-basierend-auf-ms6324-und-tda1308-bzw-lm4808m/1099)).

!!! info "Der RFID-Reader-Typ ist keine Firmware-Frage mehr"
    Früher musste man beim Flashen die passende Firmware-Variante für RC522 oder PN5180 wählen. Seit
    Mai 2026 **erkennt ESPuino den Reader automatisch** zur Laufzeit. Die Reader-Wahl ist damit eine
    reine Hardware-Entscheidung, um die du dich beim Firmware-Update nicht mehr kümmern musst.

## Bestellen & Zubehör

Die Complete und optionales Zubehör – etwa die Kopfhörerplatine oder der Drehencoder-Bausatz –
kannst du beim Entwickler beziehen. Was es gibt und was es kostet, steht in der
[Preisliste im Forum (#3344)](https://forum.espuino.de/t/preisliste/3344).
