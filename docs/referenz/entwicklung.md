# 15 · Entwicklung & Beitrag

Für alle, die selbst am Code arbeiten oder beitragen wollen. Ausführlicheres steht in der
[README des ESPuino-Repos](https://github.com/biologist79/ESPuino).

## Projektstruktur

Der Firmware-Code liegt unter `src/`, grob nach Zuständigkeit:

- **Kern/Ablauf:** `main` (setup/loop), `System` (Betriebsmodus, Deep-Sleep, Neustart), `Cmd`
  (Kommando-Dispatch für Karten/Taster/MQTT).
- **Audio:** `AudioPlayer` (Playlist/Playmodi, Wiedergabe), `SdCard`.
- **RFID:** `RfidCommon`, `RfidConfig`, `RfidRuntime` (Auto-Detect), `RfidMfrc522`, `RfidPn5180`.
- **Eingabe:** `Button`, `RotaryEncoder`, `IrReceiver`, `HallEffectSensor`.
- **Anzeige:** `Led` (Neopixel-Animationen).
- **Netzwerk:** `Wlan`, `Web` (Webinterface/REST), `Mqtt`, `Ftp`.
- **Sonstiges:** `Bluetooth`, `Battery`/`BatteryMeasureVoltage`, `Port` (GPIO + Port-Expander),
  `Power`, `MediaHub`.
- **Infrastruktur:** `Log`, `LogMessages_DE/EN/FR`, `Queues`, `MemX`, `Common`.

## Eigene Boards definieren

Für abweichende Hardware `HAL 99` setzen → `settings-custom.h`. Dort werden – wie in den anderen
`settings-<board>.h` – Pins und Feature-Flags vergeben (native GPIOs `0`–`39`, Port-Expander-Kanäle
`100`–`115`). Siehe auch [Compile-Zeit-Konfiguration](../firmware/compile-zeit.md).

## Coding-Konventionen, PRs, CI

- **Formatierung:** `clang-format` (Konfiguration `.clang-format` im Repo) – vor dem Commit
  anwenden.
- **Branches:** Features branchen von `dev`, Pull Requests gehen gegen `dev`; `master` bekommt
  periodische Release-Merges.
- **CI:** GitHub Actions baut die Firmware (siehe `.github/workflows/`).
