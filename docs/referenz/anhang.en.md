# 18 · Appendix

Reference material. The tables are derived from the firmware code – keep in sync with code changes.

## Playback modes { #playmodi }

What the individual modes mean in everyday use – with icon and description – is covered in
[chapter 8 → playback modes](../bedienung/webinterface.md#abspielmodi). Here you'll only find the
technical IDs, as they appear in MQTT messages, in the REST API, and in `backup.txt`.

| Category | ID | Constant |
| --- | --- | --- |
| Single track | 1 / 2 / 12 | `SINGLE_TRACK` / `_LOOP` / `_OF_DIR_RANDOM` |
| Audiobook (position saved) | 3 / 4 / 16 | `AUDIOBOOK` / `_LOOP` / `_RECURSIVE` |
| Folder, sorted | 5 / 7 / 15 | `ALL_TRACKS_OF_DIR_SORTED` / `_LOOP` / `_RECURSIVE` |
| Folder, random | 6 / 9 / 17 | `ALL_TRACKS_OF_DIR_RANDOM` / `_LOOP` / `_RECURSIVE` |
| Random subfolder | 13 / 14 | `RANDOM_SUBDIRECTORY_…` (sorted / random) |
| Web radio | 8 | `WEBSTREAM` |
| Local m3u | 11 | `LOCAL_M3U` |
| MediaHub | 18 | `MEDIAHUB` |
| Internal | 0 / 10 | `NO_PLAYLIST` / `BUSY` |

## Modification cards { #modifikationskarten }

Cards that trigger a function instead of music. The full catalog in plain language – sorted by
topic – is in
[chapter 8 → modification cards](../bedienung/webinterface.md#modifikationskarten-alle-optionen).

| ID | Effect |
| --- | --- |
| 100 | Lock buttons + encoder |
| 101 / 102 / 103 / 104 | Sleep after 15 / 30 / 60 / 120 min (+ LED dimming) |
| 105 | Sleep at end of track |
| 106 | Sleep at end of playlist |
| 107 | Sleep after 5 tracks |
| 110 / 111 | Loop playlist / track |
| 120 | LED night mode (brightness) |
| 130 | Wi-Fi on/off |
| 140 / 141 / 142 | BT sink / BT source / cycle mode |
| 150 | Enable FTP server |
| 151 / 152 | Announce IP address / time |
| 153 | Toggle ambient light |
| 154 / 155 | LED brightness + / − |

## Control commands (buttons / rotary / MQTT)

What each button does by default is listed in
[chapter 9 → buttons and button combinations](../bedienung/am-geraet.md#tasten-und-tastenkombinationen);
commands are assigned in
[chapter 8 → rotary encoder & buttons](../bedienung/webinterface.md#drehencoder-taster).

| ID | Command |
| --- | --- |
| 170 | Play/Pause |
| 171 / 172 | Previous / next track |
| 173 / 174 | First / last track |
| 175 / 176 / 177 | Volume: init / + / − |
| 178 | Measure battery voltage |
| 179 | Deep sleep (immediately) |
| 180 / 181 | Seek forward / backward (step size configurable in the web interface) |
| 182 / 183 | Stop / restart |
| 184 / 185 | Next / previous folder (recursive modes) |
| 186 | Position preview (rotary encoder gesture only) |

## Virtual RFID cards { #virtuelle-rfid-karten }

What they're good for and how to trigger them is explained in
[chapter 12 → virtual RFID cards](../vertiefung/erweiterte-themen.md#virtuelle-rfid-karten).

IDs `241`–`250` correspond to cards `900000000001` … `900000000010`.

## MQTT topics { #mqtt-topics }

Pattern: `[<base_topic>/]device_id/topic[/<setter_token>]`. Commands use the setter token (default
`set`), status topics are published without it. All topics are **non-retained**.

| Topic | Direction / value range | Meaning |
| --- | --- | --- |
| `sleep` | Cmnd `0`/`OFF`; State `ON`/`OFF` | Power off / power state |
| `rfid` | 12 digits | Emulate a card / current card |
| `trackcontrol` | 1–9 | Stop/Play/Pause/Next/Prev/First/Last/folder± |
| `loudness` | 0…max | Set/report volume |
| `sleep_timer` | `EOP`/`EOT`/`EO5T`/minutes/`0` | Set/report sleep timer |
| `sleep_timer_state` | JSON (state) | `{mode,remainingMinutes,remainingTracks}`; mode = OFF/MINUTES/EOT/EOP/EO5T |
| `lock_controls` | `ON`/`OFF` | Lock controls |
| `repeatmode` | 0–3 | none / track / playlist / both |
| `led_brightness` | 0–255 | Neopixel brightness |
| `ambient_light` | `ON`/`OFF` | Ambient light |
| `track` | State | Current track |
| `cover_changed` | State | Cover art may have changed |
| `state` | `Online`/`Offline` | Operating state |
| `ipv4` | State | IP address |
| `pauseplay` | `idle`/`play`/`pause` | Playback status |
| `playmode` | State | Numeric playback mode |
| `wifi_rssi` | State | Wi-Fi signal (dBm) |
| `software_revision` | State | Firmware revision |
| `battery_voltage` / `battery_soc` | State | Voltage / charge % (if battery measurement is active) |

### Example: `sleep_timer_state`

The `sleep_timer_state` topic reports the sleep timer as a JSON object. Depending on the mode,
either `remainingMinutes` or `remainingTracks` is set (the other field is `0`):

```json
{"mode":"OFF","remainingMinutes":0,"remainingTracks":0}
{"mode":"MINUTES","remainingMinutes":29,"remainingTracks":0}
{"mode":"EOT","remainingMinutes":0,"remainingTracks":1}
{"mode":"EO5T","remainingMinutes":0,"remainingTracks":3}
{"mode":"EOP","remainingMinutes":0,"remainingTracks":7}
```

`mode` is one of **OFF** (no timer), **MINUTES** (minutes remaining), **EOT** (end of title),
**EO5T** (after five titles), and **EOP** (end of playlist). For `EO5T`/`EOP`, `remainingTracks`
counts the remaining titles.

## REST API

The complete REST API is maintained as an OpenAPI specification directly in the firmware repo:
[REST-API.yaml](https://github.com/biologist79/ESPuino/blob/master/REST-API.yaml). That keeps it in
sync with the code. *(Possible future addition: embed it in the handbook as an interactive Swagger
page.)*

## Links to forum threads

- [Complete #3817](https://forum.espuino.de/t/espuino-complete/3817)
- [mini4L #1661](https://forum.espuino.de/t/espuino-mini-4layer/1661) · [D32 Pro developer board #1109](https://forum.espuino.de/t/esp32-develboard-d32-pro-lifepo4/1109)
- [Headphone board #1099](https://forum.espuino.de/t/kopfhoererplatine-basierend-auf-ms6324-und-tda1308-bzw-lm4808m/1099) · [holder for it #3792](https://forum.espuino.de/t/traeger-fuer-kopfhoererplatine/3792)
- [Rotary encoder kit #2414](https://forum.espuino.de/t/drehencoder-by-espuino/2414)
- [MediaHub #4607](https://forum.espuino.de/t/espuino-mediahub/4607)
- [LPCD #1664](https://forum.espuino.de/t/was-ist-lpcd-und-wie-funktioniert-es/1664)
- [Price list #3344](https://forum.espuino.de/t/preisliste/3344)

*(All forum links above are German-language.)*

## Changelog { #changelog }

The current changelog is maintained in the firmware repo and updated continuously there:
[changelog.md on the `dev` branch](https://github.com/biologist79/ESPuino/blob/dev/changelog.md) –
matching the state this handbook describes. The version on the
[`master` branch](https://github.com/biologist79/ESPuino/blob/master/changelog.md) only contains
what has already been published as a release.
