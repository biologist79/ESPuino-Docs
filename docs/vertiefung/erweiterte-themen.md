# 12 · Erweiterte Themen

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
([Kapitel 8 → Tab MQTT](../bedienung/webinterface.md#tab-mqtt)); welche Themen (Topics) es gibt und
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
du eine Karte auflegst – statt dass du erst eine Taste drücken musst. Gerade für eine Kinderbox ist
das ein reizvoller Gedanke: Karte drauf, Musik läuft, ganz ohne den Umweg über einen Knopf.

Technisch steckt Folgendes dahinter. Normalerweise wird der RFID-Leser zusammen mit allem anderen
abgeschaltet, wenn ESPuino in den Tiefschlaf geht – es soll ja gerade möglichst wenig Strom fließen. Bei
aktiviertem LPCD bleibt er stattdessen versorgt und tastet in kurzen Abständen selbstständig danach,
ob eine Karte in seiner Nähe liegt. Wird er fündig, zieht er seine **IRQ-Leitung** auf GND. Diese
Leitung führt zu einem **RTC-fähigen GPIO** des ESP32, also zu einem Anschluss, der auch im Tiefschlaf
noch überwacht wird – und genau dieser Pegelwechsel weckt den Prozessor. Aus Sicht des ESP32 ist das
derselbe Mechanismus wie ein Tastendruck.

Interessant ist, was unmittelbar danach geschieht. Der ESP32 startet dabei durchaus – aber bevor er
die übrige Hardware in Betrieb nimmt, schiebt er eine gezielte Prüfung dazwischen: Er lädt nur die
für LPCD nötigen Einstellungen, fährt den Leser hoch, sucht zuerst nach einer ISO-14443-Karte, dann
nach einer ISO-15693-Karte, und schlägt die gefundene Kennung in seinem internen Speicher nach. Erst
wenn dort eine **bekannte** Karte hinterlegt ist, fährt er vollständig hoch und beginnt zu spielen.
War es dagegen ein Fehlalarm – oder lag eine Karte auf, der noch gar kein Inhalt zugewiesen ist –,
legt er sich sofort wieder schlafen, noch bevor Neopixel und übrige Peripherie überhaupt aktiv
werden. Von einer fehlerhaften Erkennung bekommst du deshalb im Normalfall nichts mit; sie kostet
lediglich ein wenig Strom.

Damit LPCD funktioniert, müssen allerdings mehrere Voraussetzungen zusammenkommen:

| Voraussetzung | Was gilt |
| --- | --- |
| **Reader** | Nur der **PN5180**. Mit einem RC522 ist LPCD nicht möglich; im Webinterface lässt sich die Option dann nicht auswählen. |
| **PN5180-Firmware** | Mindestens **Version 4.0**. Welche Version dein Leser mitbringt, meldet ESPuino beim Start im Log. Ein Firmware-Update des Readers ist machbar, aber ein spürbares Stück Arbeit. |
| **Lötbrücken** | Bei der [Complete](../hardware/complete.md) müssen **JP8** und **JP1** jeweils auf **1+2** stehen (siehe [Kapitel 5 → Die Lötbrücken](../hardware/aufbau.md#die-lotbrucken)). Ab Werk ist die Standard-Beschaltung gesetzt, nicht die LPCD-Variante. |
| **IRQ-Anschluss** | Die IRQ-Leitung braucht einen RTC-fähigen GPIO. Bei der Complete ist das **GPIO 32**, der dann für anderes nicht mehr zur Verfügung steht (er belegt den Ext-Connector 1). Bei der [mini4L](../referenz/mini4l.md) steht `RFID_IRQ` ab Werk auf `99`, ist also aus, und müsste erst auf 32 geändert werden. |
| **Aktivierung** | Ein Häkchen im Webinterface unter [Allgemein → RFID](../bedienung/webinterface.md#tab-allgemein): **„PN5180 LPCD aktivieren"**. |

Baust du dir ein eigenes Board, ist die Auswahl beim IRQ-Pin begrenzt: RTC-fähig sind bei diesem ESP32
die GPIOs **0, 4, 12, 13, 14, 15, 25, 26, 27, 32, 33, 34, 35, 36 und 39** – nur einer davon kommt für
das Wecksignal in Frage.

!!! note "Nicht mehr über die settings.h"
    In älteren Anleitungen – auch im
    [Forum-Thread #1664](https://forum.espuino.de/t/was-ist-lpcd-und-wie-funktioniert-es/1664), der die
    Funktion ansonsten schön erklärt – wird LPCD über ein `PN5180_ENABLE_LPCD` in der `settings.h`
    eingeschaltet. Das trifft nicht mehr zu: Die Funktion ist inzwischen eine reine
    Laufzeit-Einstellung und wird ausschließlich im Webinterface gesetzt. Ein entsprechender Eintrag
    in einer eigenen `settings-override.h` bleibt wirkungslos.

Zu bedenken ist außerdem, dass sich LPCD und ein **harter Ausschalter** gegenseitig ausschließen –
beides zusammen geht nicht (siehe [Kapitel 3](../hardware/complete.md)).

!!! warning "Was du vorher wissen solltest"
    So schön die Idee ist – LPCD wird derzeit **nicht aktiv gepflegt**, immer wieder berichten Nutzer
    von **Zuverlässigkeitsproblemen**, und es **verbraucht mehr Strom**, weil der Leser im Deep-Sleep
    aktiv bleibt.

## Der Port-Expander PCA9555

Der ESP32 hat nur begrenzt freie Anschlüsse (GPIOs), und einige davon lassen sich ausschließlich als
Eingang nutzen. Wird es eng, schafft ein **PCA9555**-Port-Expander Abhilfe: Er wird über I²C
angebunden und stellt **16 zusätzliche Kanäle** bereit (zwei Ports zu je acht). Auf der [Complete](../hardware/complete.md) ist
er bereits an Bord – du profitierst also automatisch davon.

In der ESPuino-Konfiguration werden diese Kanäle mit den Nummern **`100` bis `115`** angesprochen
(Port 0 sind 100–107, Port 1 sind 108–115). Deshalb tauchen in der
[Pinout-Tabelle](../hardware/complete.md#pinout-referenz-complete) Werte ab 100 auf. Typischerweise
hängen Eingänge daran (Taster, Kopfhörer-Erkennung, der Encoder-Taster); Ausgänge nur in Sonderfällen
wie dem Verstärker-Enable.

!!! note "Gut zu wissen"
    Jede Änderung an einem Expander-Eingang löst einen Interrupt aus und weckt den ESP32. Sich auf
    einzelne Pins zu beschränken ist zwar möglich, aber ein ziemlicher Hack, den man selbst
    einprogrammieren muss: Ein als **Ausgang** konfigurierter Pin wirft keinen Interrupt mehr. Pins auf
    Ausgang zu setzen ist allerdings nicht ungefährlich – wie das geht und worauf man achten muss,
    steht in [Forum #2613](https://forum.espuino.de/t/aufwecken-nur-ueber-drehencoder/2613). Zum
    Port-Expander allgemein siehe [Forum #306](https://forum.espuino.de/t/einsatz-des-port-expanders-pca9555/306).

## Headless- und Dauerbetrieb

Nicht jeder ESPuino ist eine mobile Kinderbox. Manche laufen dauerhaft am Netzteil – etwa als
Internetradio in der Küche – oder ganz ohne die üblichen Bedienelemente. Beides ist problemlos
möglich.

Für den **Dauerbetrieb** ist wichtig zu wissen: Solange etwas abgespielt wird – eine Datei oder ein
Webstream –, geht ESPuino **nicht** in den Deep-Sleep. Ein Radiosender läuft also endlos weiter. Der
automatische Schlaf greift nur, wenn nichts läuft und eine Weile keine Eingabe kommt; wer das gar
nicht möchte, stellt die Inaktivitätszeit im Webinterface (Tab Allgemein → Energie) entsprechend hoch.
Am Dauer-Netzteil spielen Akku-Themen ohnehin keine Rolle.

Für den **Headless-Betrieb** gilt: Tasten, Drehencoder und sogar die Neopixel sind allesamt optional.
Ein ESPuino lässt sich vollständig über das Webinterface und – falls gewünscht – über MQTT steuern,
und die RFID-Karten funktionieren davon unabhängig. Dank der [Modifikationskarten](../bedienung/webinterface.md#modifikationskarten-alle-optionen)
lässt er sich sogar **vollständig per Karte** bedienen – ganz ohne Tasten und Bildschirm. So kannst du
eine bewusst reduzierte Box bauen oder ESPuino nahtlos in eine Hausautomatisierung einbinden.
Theoretisch ist damit fast alles machbar – ob es in der Praxis Sinn ergibt, musst du selbst entscheiden.
