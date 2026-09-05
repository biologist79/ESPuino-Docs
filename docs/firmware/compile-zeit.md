# 13 · Compile-Zeit-Konfiguration

Nur noch die Themen, die das Webinterface **nicht** abdeckt. Sehr vieles ist inzwischen zur
Laufzeit über das Webinterface einstellbar (siehe Migrationstabelle am Ende dieser Seite).

!!! note "Status dieser Seite"
    Tabellen aus dem Firmware-Code abgeleitet (Stand aktuelle `dev`). Bei Code-Änderungen mitziehen.

## Wann brauche ich überhaupt eigene Flags?

In der Regel gar nicht – die vorgefertigte Firmware (Stufe 1) passt für die meisten. Eigene Flags
lohnen nur für abweichende Hardware oder die wenigen reinen Compile-Zeit-Werte unten.

## Override-Mechanismus

Eigene Einstellungen gehören in eine `settings-override.h` (bzw. ein eigenes Board über `HAL 99`
→ `settings-custom.h`), damit sie ein Update nicht überschreibt.

## Verbleibende Feature-Flags (echt compile-time)

| Flag | Zweck |
| --- | --- |
| `HAL` | Board-Auswahl (siehe unten) |
| `LANGUAGE` | Sprache der **seriellen** Ausgabe (≠ Webinterface-Sprache) |
| `SERIAL_LOGLEVEL` | Loglevel der seriellen Konsole |
| `CHIPSET` / `COLOR_ORDER` | Neopixel-Typ (FastLED-Template, nicht zur Laufzeit) |
| `MDNS_ENABLE` | `ESPuino.local` erreichbar |
| `MQTT_ENABLE` | MQTT-Anbindung |
| `FTP_ENABLE` | FTP-Server |
| `NEOPIXEL_ENABLE` | Neopixel-LEDs |
| `BLUETOOTH_ENABLE` | Bluetooth (→ „noBT"-Firmware, wenn aus) |
| `MEASURE_BATTERY_VOLTAGE` | Batteriemessung |
| `USEROTARY_ENABLE` | Drehencoder |
| `HEADPHONE_ADJUST_ENABLE` | Kopfhörer-Erkennung/Stereo für Kopfhörerplatine |
| `SHUTDOWN_IF_SD_BOOT_FAILS` | Deep-Sleep bei SD-Bootfehler |
| `PORT_EXPANDER_ENABLE` | Port-Expander PCA9555 |
| `SD_MMC_1BIT_MODE` | SD im SD-MMC-1-Bit-Modus |
| `I2C_2_ENABLE` | zweiter I²C-Bus |
| `INCLUDE_ROTARY_IN_CONTROLS_LOCK` | Encoder mit sperren |
| `INVERT_POWER` / `DETECT_HP_ON_HIGH` | Board-Logik (Power / Kopfhörer-Erkennung) |
| IR-Fernbedienung (`RC_*`, `IR_DEBOUNCE`) | Infrarot-Codes |

## Pin-Definitionen

Board-spezifisch in den Headern (`settings-complete.h`, `settings-lolin_d32_pro_sdmmc_pe.h`). Siehe
auch [Anhang → Pinout](../referenz/anhang.md).

## Werte nur per `settings.h` (kein Webinterface)

| Wert | Ort | Zweck |
| --- | --- | --- |
| `jumpOffset = 30` | `settings.h` | Sprung-Sekunden beim **Button**-Seek (kein NVS-Override) |
| `deepsleepTimeAfterBootFails = 20` | `settings.h` | Auto-Neustart nach SD-Bootfehler (Sekunden) |
| `rdiv1`, `rdiv2`, `inputAttenuation` | `settings-complete.h` | Batterie-Kalibrierung (Spannungsteiler/ADC) |
| `RC_*`, `IR_DEBOUNCE` | `settings-complete.h` | IR-Fernbedienungscodes |
| Pin-Definitionen | Board-Header | s. o. |

!!! info "`offsetVoltage` jetzt im Webinterface"
    Der Batterie-**Korrekturwert** `offsetVoltage` ist **seit September 2026** im Webinterface
    einstellbar (Batterie-Einstellungen) und daher hier nicht mehr aufgeführt.

!!! tip "Nuance Seek-Schritt"
    Der **Rotary**-Seek-Schritt ist dagegen im Webinterface einstellbar (`rotSeekStep`, Default
    `JUMP_OFFSET_ROTARY = 10`). Nur der **Button**-Seek `jumpOffset` bleibt fest.

## Vorrangregel

**Webinterface > `settings.h`.** Ein im Webinterface (NVS) gesetzter Wert gewinnt gegenüber dem
Compile-Zeit-Default. Ein `settings-override.h`, das eine längst ins Webinterface gewanderte Option
noch definiert, hat schlicht keine Wirkung mehr.

## Migrationstabelle „früher `settings.h` → heute Webinterface"

Diese Dinge waren früher Compile-Zeit-Makros und sind heute im Webinterface:

| früher (`settings.h`) | heute im Webinterface |
| --- | --- |
| `STATIC_IP_ENABLE` | Statische IP (pro Netzwerk) |
| `PLAY_LAST_RFID_AFTER_REBOOT` | „Letzte Karte nach Neustart abspielen" |
| `PAUSE_WHEN_RFID_REMOVED` | „Pause, wenn Karte entfernt" |
| `DONT_ACCEPT_SAME_RFID_TWICE` | „Gleiche Karte nicht doppelt akzeptieren" |
| `RESUME_ON_SAME_RFID` | „Bei gleicher Karte fortsetzen" |
| `NEOPIXEL_REVERSE_ROTATION` | Neopixel-Drehrichtung |
| `SHUTDOWN_ON_BAT_CRITICAL` | „Bei kritischer Spannung abschalten" |
| `PLAY_MONO_SPEAKER` | Mono/Stereo |
| `RFID_SCAN_INTERVAL` | MFRC522-Scan-Intervall |
| LED-Defaults (`NUM_*_LEDS`, `*_HUE_*`, `ATMO_*`, `DIMMABLE_STATES`, `LED_OFFSET`) | Neopixel-Helligkeit / Gradient / Layout |
| Batterie-Schwellen (`s_warning*`, `s_voltageIndicator*`, `s_batteryCheckInterval`) | Batterie-Einstellungen |
| Lautstärken (init / min / max Speaker + Kopfhörer) | Lautstärke-Einstellungen |
| `maxInactivityTime` | Deep-Sleep-Inaktivität |
| Button-Belegung | Dynamisches Button-Layout |
| RC522-Gain | RFID-Einstellungen |
| `savePos*` (Shutdown / RFID-Wechsel / Intervall) | Hörbuch-Einstellungen |
| Rekursionstiefe | Sortierung/Rekursion |
