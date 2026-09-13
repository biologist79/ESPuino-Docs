# 14 · Compile-time configuration

Only the topics the web interface **doesn't** cover are left here. A great many things are by now
configurable at runtime via the web interface (see the migration table at the end of this page).

!!! note "Status of this page"
    Tables derived from the firmware code (current `dev` state). Keep in sync with code changes.

## Do I even need my own flags?

Usually not at all – the pre-built firmware (tier 1) fits most people. Custom flags are only worth
it for different hardware or the few genuine compile-time values below.

## Override mechanism

Custom settings belong in a `settings-override.h` (or, for your own board via `HAL 99`, a
`settings-custom.h`), so an update doesn't overwrite them.

## Remaining feature flags (genuinely compile-time)

| Flag | Purpose |
| --- | --- |
| `HAL` | Board selection (see below) |
| `LANGUAGE` | Language of the **serial** output (≠ web interface language) |
| `SERIAL_LOGLEVEL` | Log level of the serial console |
| `CHIPSET` / `COLOR_ORDER` | Neopixel type (FastLED template, not at runtime) |
| `MDNS_ENABLE` | `ESPuino.local` reachable |
| `MQTT_ENABLE` | MQTT integration |
| `FTP_ENABLE` | FTP server |
| `NEOPIXEL_ENABLE` | Neopixel LEDs |
| `BLUETOOTH_ENABLE` | Bluetooth (→ "noBT" firmware when off) |
| `MEASURE_BATTERY_VOLTAGE` | Battery measurement |
| `USEROTARY_ENABLE` | Rotary encoder |
| `HEADPHONE_ADJUST_ENABLE` | Headphone detection/stereo for the headphone board |
| `SHUTDOWN_IF_SD_BOOT_FAILS` | Deep sleep on SD boot failure |
| `PORT_EXPANDER_ENABLE` | PCA9555 port expander |
| `SD_MMC_1BIT_MODE` | SD in SD-MMC 1-bit mode |
| `I2C_2_ENABLE` | second I²C bus |
| `INCLUDE_ROTARY_IN_CONTROLS_LOCK` | Lock the encoder along with the buttons |
| `INVERT_POWER` / `DETECT_HP_ON_HIGH` | Board logic (power / headphone detection) |
| IR remote (`RC_*`, `IR_DEBOUNCE`) | Infrared codes |

## Pin definitions

Board-specific in the headers (`settings-complete.h`, `settings-lolin_d32_pro_sdmmc_pe.h`). See also
[appendix → pinout](../referenz/anhang.md).

## Values only via `settings.h` (no web interface)

| Value | Location | Purpose |
| --- | --- | --- |
| `deepsleepTimeAfterBootFails = 20` | `settings.h` | Auto-restart after an SD boot failure (seconds) |
| `rdiv1`, `rdiv2`, `inputAttenuation` | `settings-complete.h` | Battery calibration (voltage divider/ADC) |
| `RC_*`, `IR_DEBOUNCE` | `settings-complete.h` | IR remote codes |
| Pin definitions | Board header | see above |

!!! info "`offsetVoltage` is now in the web interface"
    The battery **correction value** `offsetVoltage` has been settable in the web interface
    (battery settings) **since September 2026** and is therefore no longer listed here.

!!! info "Seek step sizes are now in the web interface"
    The two **seek step sizes** are also settable in the web interface **since September 2026**
    ([chapter 8 → seek step sizes](../bedienung/webinterface.md#sprungweiten)) and are therefore no
    longer in this table: the one per **button press** (formerly `jumpOffset`) and the one per
    **rotary encoder detent** (formerly `JUMP_OFFSET_ROTARY`). Both constants have disappeared from
    `settings.h` and now only live on as internal default values (`SEEK_STEP_BUTTON_DEFAULT` /
    `SEEK_STEP_ROTARY_DEFAULT`) in `values.h`. **Important for self-builds:** a
    `settings-override.h` that still defines them no longer has any effect.

## Precedence rule

**Web interface > `settings.h`.** A value set in the web interface (NVS) wins over the compile-time
default. A `settings-override.h` that still defines an option that has long since moved to the web
interface simply has no effect anymore.

## Migration table: "formerly `settings.h` → now the web interface"

These used to be compile-time macros and are now in the web interface:

| Formerly (`settings.h`) | Now in the web interface |
| --- | --- |
| `STATIC_IP_ENABLE` | Static IP (per network) |
| `PLAY_LAST_RFID_AFTER_REBOOT` | "Resume last card after restart" |
| `PAUSE_WHEN_RFID_REMOVED` | "Pause when card is removed" |
| `DONT_ACCEPT_SAME_RFID_TWICE` | "Don't re-accept the same card" |
| `RESUME_ON_SAME_RFID` | "Resume on the same card" |
| `NEOPIXEL_REVERSE_ROTATION` | Neopixel rotation direction |
| `SHUTDOWN_ON_BAT_CRITICAL` | "Shut down at critical voltage" |
| `PLAY_MONO_SPEAKER` | Mono/stereo |
| `RFID_SCAN_INTERVAL` | MFRC522 scan interval |
| LED defaults (`NUM_*_LEDS`, `*_HUE_*`, `ATMO_*`, `DIMMABLE_STATES`, `LED_OFFSET`) | Neopixel brightness / gradient / layout |
| Battery thresholds (`s_warning*`, `s_voltageIndicator*`, `s_batteryCheckInterval`) | Battery settings |
| Volumes (initial / min / max, speaker + headphones) | Volume settings |
| `maxInactivityTime` | Deep sleep inactivity |
| Button mapping | Dynamic button layout |
| RC522 gain | RFID settings |
| `savePos*` (shutdown / card change / interval) | Audiobook settings |
| Recursion depth | Sorting/recursion |
