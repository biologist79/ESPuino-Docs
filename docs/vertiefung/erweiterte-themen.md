# 10 · Erweiterte Themen

Themen für alle, die mehr aus dem Gerät holen wollen.

## MQTT in Home Assistant einbinden

Alles, was per RFID/Taster steuerbar ist, lässt sich auch über **MQTT** steuern; umgekehrt meldet
ESPuino jede Aktion und jeden Zustandswechsel per MQTT zurück (Lautstärke, Titel, Playmode …). So
bindest du ihn in eine Hausautomatisierung ein.

- MQTT im Webinterface aktivieren/konfigurieren: [Kapitel 6 → Tab MQTT](../bedienung/webinterface.md#tab-mqtt).
- Vollständige Topic-Referenz: [Anhang → MQTT-Topics](../referenz/anhang.md#mqtt-topics).
- **Home Assistant:** [Integration im Forum](https://forum.espuino.de/t/home-assistant-integration/3763).
- **openHAB:** Beispiel-Konfiguration im [openHAB-Verzeichnis des Repos](https://github.com/biologist79/ESPuino/tree/master/openHAB).

## Energiesparen, Deep-Sleep, Sleep-Timer, Batterielaufzeit

- **Automatischer Deep-Sleep:** Nach einer einstellbaren Inaktivitätszeit (`maxInactivityTime`,
  Standard 10 min) legt sich ESPuino schlafen. Der Timer läuft **nicht**, solange Musik spielt oder
  ein FTP-Client verbunden ist; jede Tasteneingabe setzt ihn zurück.
- **Sleep-Timer:** per Modifikationskarte oder MQTT (nach Minuten, Track-Ende, Playlist-Ende oder
  5 Titel). Der Timer-Status ist per MQTT live abfragbar
  (`sleep_timer_state`, JSON mit `mode`/`remainingMinutes`/`remainingTracks`).
- **Batterie:** Warnschwellen, Anzeige und optionale Abschaltung im Webinterface (Tab Allgemein →
  Energie).

## Virtual RFID Cards

Zehn **virtuelle Karten** mit den IDs `900000000001` … `900000000010`. Sie funktionieren wie echte
Karten, werden aber per Kommando ausgelöst (z. B. über einen Taster, eine Multi-Taster-Kombination
oder MQTT) – nützlich, um eine Aktion ohne physische Karte auszulösen. Details:
[Forum #3218](https://forum.espuino.de/t/virtual-rfid-cards/3218).

## LPCD

LPCD (Low Power Card Detection) weckt den ESPuino durch **Auflegen einer Karte** aus dem
Deep-Sleep (statt per Tastendruck). Nur mit **PN5180**; braucht PN5180-Firmware ≥ 4.1, gesetzte
Lötbrücken und einen RTC-fähigen GPIO für den IRQ.

!!! warning "Zurückhaltend – eher nicht empfohlen"
    LPCD wird aktuell **nicht aktiv gepflegt**, wurde von Nutzern als **unzuverlässig** gemeldet
    und **zieht mehr Strom** (der Reader bleibt im Deep-Sleep aktiv). Ein Ausbau wird erwogen. Wer
    es nicht zwingend braucht, sollte es weglassen.

## Port-Expander PCA9555

Wenn die nativen GPIOs knapp werden (der ESP32 hat nur begrenzt freie Pins, einige nur als Input),
erweitert ein **PCA9555** über I²C um **16 Kanäle** – zwei Ports mit je acht. Auf der **Complete ist
er bereits an Bord**.

- **Nummerierung:** `100`–`115` (Port 0 = 100–107, Port 1 = 108–115) – daher tauchen im
  [Pinout](../referenz/anhang.md#pinout-referenz-complete) Werte ≥ 100 auf.
- **Aktivierung:** `PORT_EXPANDER_ENABLE`; I²C-Adresse `expanderI2cAddress` (Standard `0x20`, über
  `A0`/`A1`/`A2` änderbar). Die I²C-GPIOs (`ext_IIC_CLK`/`ext_IIC_DATA`) und optional der
  `PE_INTERRUPT_PIN` stehen im Board-Header.
- **Typische Nutzung:** Eingänge (Taster, Kopfhörer-Erkennung, Encoder-Taster); Ausgänge nur in
  Sonderfällen (Verstärker-Enable `GPIO_PA_EN`/`GPIO_HP_EN`).

!!! note "Interrupt"
    Jede Änderung an einem Expander-Eingang löst einen Interrupt aus (und weckt den ESP32) – das
    lässt sich nicht auf einzelne Pins begrenzen.

Mehr: [Forum #306](https://forum.espuino.de/t/einsatz-des-port-expanders-pca9555/306).

## Headless-/Dauerbetrieb

*Optional – kann später ergänzt werden.*
