# 10 · Erweiterte Themen

!!! note "Status dieser Seite"
    Gerüst – einzelne Themen ausformulieren bzw. aus dem Forum migrieren.

## MQTT in Home Assistant einbinden

*TODO.* Topic-Referenz: [Anhang → MQTT](../referenz/anhang.md#mqtt-topics).

## Energiesparen, Deep-Sleep, Sleep-Timer, Batterielaufzeit

Deep-Sleep nach Inaktivität, Sleep-Timer per Modifikationskarte oder MQTT. Der Timer-Status ist
per MQTT live abfragbar (`sleep_timer_state`, JSON mit `mode`/`remainingMinutes`/`remainingTracks`).

## Virtual RFID Cards

Karten-IDs `900000000001`…`900000000010`, die per Kommando statt echter Karte ausgelöst werden.

## LPCD

LPCD (Low Power Card Detection) weckt den ESPuino durch **Auflegen einer Karte** aus dem
Deep-Sleep (statt per Tastendruck). Nur mit **PN5180**; braucht PN5180-Firmware ≥ 4.1, gesetzte
Lötbrücken und einen RTC-fähigen GPIO für den IRQ.

!!! warning "Zurückhaltend – eher nicht empfohlen"
    LPCD wird aktuell **nicht aktiv gepflegt**, wurde von Nutzern als **unzuverlässig** gemeldet
    und **zieht mehr Strom** (der Reader bleibt im Deep-Sleep aktiv). Ein Ausbau wird erwogen. Wer
    es nicht zwingend braucht, sollte es weglassen.

## Port-Expander PCA9555

Hardware-Erweiterung für zusätzliche GPIOs (auf der Complete bereits an Bord). *TODO.*

## Headless-/Dauerbetrieb

*Optional – kann später ergänzt werden.*
