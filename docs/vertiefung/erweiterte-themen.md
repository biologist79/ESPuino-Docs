# 10 · Erweiterte Themen

Die Grundfunktionen kennst du jetzt. Dieses Kapitel sammelt Themen für alle, die mehr aus ihrem
ESPuino herausholen wollen – von der Einbindung in die Hausautomatisierung bis zur
Hardware-Erweiterung. Du musst nichts davon nutzen; sieh es als Baukasten, aus dem du dir das
herauspickst, was zu dir passt.

## ESPuino in die Hausautomatisierung einbinden (MQTT)

Alles, was sich per Karte oder Taste steuern lässt, kann ESPuino auch über **MQTT** entgegennehmen –
und umgekehrt meldet er über MQTT jede Aktion und jeden Zustandswechsel zurück: die aktuelle
Lautstärke, den laufenden Titel, den Abspielmodus und vieles mehr. Damit lässt er sich sauber in eine
Hausautomatisierung einbinden, etwa um ihn abends automatisch leiser zu stellen oder in einer
Übersicht anzuzeigen, was gerade läuft.

Die Einrichtung selbst nimmst du im Webinterface vor
([Kapitel 6 → Tab MQTT](../bedienung/webinterface.md#tab-mqtt)); welche Themen (Topics) es gibt und
was sie bedeuten, steht vollständig im [Anhang → MQTT-Topics](../referenz/anhang.md#mqtt-topics). Für
konkrete Systeme gibt es fertige Hilfestellungen: für **Home Assistant** eine
[Integration im Forum](https://forum.espuino.de/t/home-assistant-integration/3763), und für **openHAB**
eine Beispiel-Konfiguration im [openHAB-Verzeichnis des Repos](https://github.com/biologist79/ESPuino/tree/master/openHAB).

## Energiesparen, Deep-Sleep und Batterielaufzeit

ESPuino ist darauf ausgelegt, sparsam mit dem Akku umzugehen. Kernstück ist der **automatische
Deep-Sleep**: Nach einer einstellbaren Zeit ohne Aktivität legt sich das Gerät in den Tiefschlaf und
verbraucht dann fast nichts mehr. Standardmäßig sind das zehn Minuten (`maxInactivityTime`). Der Zähler
läuft allerdings mit Bedacht: Solange Musik spielt oder ein FTP-Client verbunden ist, schläft ESPuino
nicht ein, und jede Tasteneingabe setzt die Uhr zurück.

Zusätzlich kannst du einen **Sleep-Timer** setzen – per Modifikationskarte oder über MQTT –, der nach
einer festen Zeit, nach dem aktuellen Titel, am Ende der Playlist oder nach fünf Titeln einschläft.
Den aktuellen Timer-Status kannst du sogar per MQTT live abfragen (Topic `sleep_timer_state`, als
JSON mit Modus und Restzeit). Und wenn du ESPuino im Akkubetrieb nutzt, findest du im Webinterface
(Tab Allgemein → Energie) die Warnschwellen, die Anzeige und die optionale automatische Abschaltung
bei zu niedriger Spannung.

## Virtuelle RFID-Karten

Nicht jede Aktion braucht eine physische Karte. ESPuino kennt zehn **virtuelle Karten** mit den IDs
`900000000001` bis `900000000010`. Du weist ihnen im Webinterface Inhalte oder Modifikationen zu –
ganz genauso, wie du es mit einer echten Karte tätest (du trägst die Chip-Nummer einfach von Hand
ein). Ausgelöst werden sie dann per **Taster**, per **Tastenkombination** oder über **MQTT**.

Der Nutzen: Du kannst häufige Aktionen auf einen Knopfdruck legen, ohne dafür jedes Mal eine spezielle
Karte bereitzuhalten – etwa „Lieblings-Playlist starten" auf eine Tastenkombination. Mehr dazu im
[Forum #3218](https://forum.espuino.de/t/virtual-rfid-cards/3218).

## LPCD: Aufwecken durch Kartenauflegen { #lpcd }

LPCD (Low Power Card Detection) ist eine Funktion, mit der ESPuino aus dem Deep-Sleep erwacht, sobald
du eine Karte auflegst – statt dass du erst eine Taste drücken musst. Das klingt verlockend, hat aber
technische Voraussetzungen: Es funktioniert nur mit dem **PN5180**, benötigt dessen Firmware in
Version 4.1 oder neuer, gesetzte Lötbrücken und einen RTC-fähigen GPIO für das Wecksignal.

!!! warning "Ehrliche Einschätzung: eher nicht empfehlenswert"
    So schön die Idee ist – LPCD wird derzeit **nicht aktiv gepflegt**, immer wieder berichten Nutzer
    von **Zuverlässigkeitsproblemen**, und es **verbraucht mehr Strom**, weil der Leser im Deep-Sleep
    aktiv bleibt. Ein Rückbau der Funktion wird sogar erwogen. Wenn du sie nicht zwingend brauchst,
    lässt du sie besser weg.

## Der Port-Expander PCA9555

Der ESP32 hat nur begrenzt freie Anschlüsse (GPIOs), und einige davon lassen sich ausschließlich als
Eingang nutzen. Wird es eng, schafft ein **PCA9555**-Port-Expander Abhilfe: Er wird über I²C
angebunden und stellt **16 zusätzliche Kanäle** bereit (zwei Ports zu je acht). Auf der Complete ist
er bereits an Bord – du profitierst also automatisch davon.

In der ESPuino-Konfiguration werden diese Kanäle mit den Nummern **`100` bis `115`** angesprochen
(Port 0 sind 100–107, Port 1 sind 108–115). Deshalb tauchen in der
[Pinout-Tabelle](../referenz/anhang.md#pinout-referenz-complete) Werte ab 100 auf. Typischerweise
hängen Eingänge daran (Taster, Kopfhörer-Erkennung, der Encoder-Taster); Ausgänge nur in Sonderfällen
wie dem Verstärker-Enable.

!!! note "Gut zu wissen"
    Jede Änderung an einem Expander-Eingang löst einen Interrupt aus und weckt den ESP32 – das lässt
    sich technisch nicht auf einzelne Pins begrenzen. Details:
    [Forum #306](https://forum.espuino.de/t/einsatz-des-port-expanders-pca9555/306).

## Headless- und Dauerbetrieb

*Dieser Abschnitt ist optional und wird bei Bedarf ergänzt.*
