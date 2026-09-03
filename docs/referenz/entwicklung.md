# 15 · Entwicklung & Beitrag

ESPuino ist ein offenes Projekt, und Beiträge sind willkommen. Dieses Kapitel richtet sich an alle,
die selbst am Code arbeiten, eigene Hardware unterstützen oder Verbesserungen zurückgeben möchten. Es
gibt dir eine erste Orientierung; noch ausführlicher ist die
[README des ESPuino-Repos](https://github.com/biologist79/ESPuino).

## Wie der Code aufgebaut ist

Der Firmware-Code liegt unter `src/` und ist nach Zuständigkeiten aufgeteilt. Wenn du dich das erste
Mal hineinliest, hilft diese grobe Landkarte:

- **Kern und Ablauf:** `main` enthält `setup()` und die `loop()`, `System` kümmert sich um
  Betriebsmodus, Deep-Sleep und Neustart, und `Cmd` verteilt die Kommandos, die von Karten, Tasten
  oder MQTT kommen.
- **Audio:** `AudioPlayer` steuert Playlist, Abspielmodi und Wiedergabe, `SdCard` den Kartenzugriff.
- **RFID:** `RfidCommon`, `RfidConfig`, `RfidRuntime` (die Auto-Erkennung) sowie die readerspezifischen
  `RfidMfrc522` und `RfidPn5180`.
- **Eingabe:** `Button`, `RotaryEncoder`, `IrReceiver` und `HallEffectSensor`.
- **Anzeige:** `Led` mit allen Neopixel-Animationen.
- **Netzwerk:** `Wlan`, `Web` (Webinterface und REST-Schnittstelle), `Mqtt` und `Ftp`.
- **Weiteres:** `Bluetooth`, `Battery` / `BatteryMeasureVoltage`, `Port` (GPIOs und Port-Expander),
  `Power` und `MediaHub`.
- **Infrastruktur:** `Log` und die `LogMessages_*` (Übersetzungen), dazu `Queues`, `MemX` und
  `Common`.

## Eigene Boards unterstützen

Möchtest du ESPuino auf abweichender Hardware betreiben, ist der vorgesehene Weg das Board `HAL 99`,
das die Datei `settings-custom.h` einbindet. Dort vergibst du – wie in den anderen `settings-<board>.h`
– die Pins und setzt die Feature-Flags. Zur Erinnerung an die Nummernbereiche: native ESP32-GPIOs
liegen bei `0`–`39`, die Kanäle des Port-Expanders bei `100`–`115`. Mehr dazu in der
[Compile-Zeit-Konfiguration](../firmware/compile-zeit.md).

## Konventionen, Pull Requests und CI

Damit alles zusammenpasst, ein paar Spielregeln:

- **Formatierung:** Der Code wird mit `clang-format` formatiert (die Regeln stehen in `.clang-format`
  im Repo). Am besten vor jedem Commit anwenden.
- **Branches:** Neue Features branchen von `dev` ab, und Pull Requests gehen ebenfalls gegen `dev`.
  Der `master`-Branch bekommt in größeren Abständen die Release-Merges.
- **CI:** GitHub Actions baut die Firmware automatisch – ein Blick nach `.github/workflows/` zeigt,
  was dort passiert.
