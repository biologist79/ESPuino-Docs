# 17 · Development & contributing

ESPuino is an open project, and contributions are welcome. This chapter is for anyone who wants to
work on the code themselves, support their own hardware, or contribute improvements back. It gives
you a first orientation; even more detail is in the
[ESPuino repo's README](https://github.com/biologist79/ESPuino).

!!! note "You can help without programming too: test it!"
    An honest word up front: unfortunately, only a few people still take part in **testing** these
    days – yet that's exactly what the project depends on. And for that, you don't need to write a
    single line of code: flash new **`dev` builds**, use them in everyday life, and report back on
    the [forum](https://forum.espuino.de) what works well and what doesn't. Every bit of feedback
    helps catch bugs early and keep ESPuino stable.

## How the code is structured

The firmware code lives under `src/` and is organized by responsibility. If you're reading through
it for the first time, this rough map helps:

- **Core and flow:** `main` contains `setup()` and the `loop()`, `System` handles operating mode,
  deep sleep, and restart, and `Cmd` dispatches the commands coming from cards, buttons, or MQTT.
- **Audio:** `AudioPlayer` controls the playlist, playback modes, and playback itself, `SdCard`
  handles card access.
- **RFID:** `RfidCommon`, `RfidConfig`, `RfidRuntime` (the auto-detection), plus the
  reader-specific `RfidMfrc522` and `RfidPn5180`.
- **Input:** `Button`, `RotaryEncoder`, `IrReceiver`, and `HallEffectSensor`.
- **Display:** `Led` with all the Neopixel animations.
- **Network:** `Wlan`, `Web` (web interface and REST API), `Mqtt`, and `Ftp`.
- **Other:** `Bluetooth`, `Battery` / `BatteryMeasureVoltage`, `Port` (GPIOs and port expander),
  `Power`, and `MediaHub`.
- **Infrastructure:** `Log` and the `LogMessages_*` (translations), plus `Queues`, `MemX`, and
  `Common`.

## Supporting your own boards

If you want to run ESPuino on different hardware, the intended route is the `HAL 99` board, which
includes the `settings-custom.h` file. There – just as in the other `settings-<board>.h` files –
you assign the pins and set the feature flags. As a reminder on the number ranges: native ESP32
GPIOs are `0`–`39`, the port expander's channels are `100`–`115`. More on that in the
[compile-time configuration](../firmware/compile-zeit.md).

## Conventions, pull requests, and CI

To keep everything consistent, a few ground rules:

- **Formatting:** the code is formatted with `clang-format` (the rules are in `.clang-format` in
  the repo). Best to apply it before every commit.
- **Branches:** new features branch off from `dev`, and pull requests **always target `dev` –
  never `master`**. The `master` branch only gets release merges at longer intervals.
- **Announce larger features beforehand:** if you're planning a more substantial change, please
  announce the feature **on the [forum](https://forum.espuino.de) beforehand**, so its merits can
  be discussed together. That way you avoid putting a lot of work into a direction that ultimately
  doesn't serve the project as a whole.
- **CI:** GitHub Actions builds the firmware automatically – a look at `.github/workflows/` shows
  what happens there.
