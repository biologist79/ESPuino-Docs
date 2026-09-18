# 15 · Troubleshooting

Things don't always run smoothly right away – that's normal for a DIY project and no reason to
despair. This chapter goes through the most common pitfalls and explains, for each, what's usually
behind it and what helps. And one more thing up front: **you don't have to solve every problem
yourself.** Sometimes it's not your build at all, but, say, a file or a library being used –
we'll sort those out together. So if you don't find what you need here, the
[**forum**](https://forum.espuino.de) is always the right place to go – ideally along with the log
(see just below) and a few details about your device.

## First: look at the log

Before guessing for a long time, it's almost always worth looking at the log – it often tells you
directly what's wrong. There are several ways to get to it: conveniently **in the browser** via the
stack menu at the top right of the web interface, entry **log** – though this requires ESPuino to
be **running and reachable on Wi-Fi**, which in problem cases is, experience shows, often exactly
not the case. Otherwise, the route is **serial**, over USB at 115200 baud. For the serial console,
you don't need a development environment – the
[ESPuino Firmware Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/) brings such a console
right into the browser (more on that below, under "When nothing works anymore"). How verbose
ESPuino's logging is controlled by the `SERIAL_LOGLEVEL` setting
([chapter 14](../firmware/compile-zeit.md)).

!!! warning "A USB cable with data wires is needed"
    Serial access requires a USB cable with **data wires**. Pure **charging cables** don't carry
    data – in that case, usually **no connection at all** is established to the Complete (the
    device often doesn't even show up as a port). This is a common issue especially with
    **extension cables or adapter plugs**; when in doubt, try a different cable.

## The RFID card isn't detected reliably

If cards are sometimes detected and sometimes not, distance or sensitivity is usually involved.
Move the card a bit closer to the reader, and with an MFRC522, try adjusting the **sensitivity**
(the **MFRC522 gain** setting, 0–7). It's already set fairly high by default – so it can well be
worth trying it not just higher, but also **lower**. If you're using a PN5180 and ESPuino falsely
reports a stationary card as "removed", increasing the **PN5180 debounce** (default 500 ms) can
help – the corresponding settings are in the General tab → RFID reader.

One particularly common case deserves its own mention: if playback runs with the **"pause when the
card is removed"** option and then stops sporadically on its own, the card is briefly going
undetected in between and ESPuino mistakes that for the card being taken off. This is a well-known
recurring issue. Reduce the distance between card and reader, increase the debounce on the PN5180,
or simply turn the option off if it causes you more trouble than it's worth. (The option exists for
both RC522 and PN5180; only the debounce setting is PN5180-specific.) (On LPCD, see the clear
warning in [chapter 12](../vertiefung/erweiterte-themen.md#lpcd).)

!!! tip "Browsing the forum is worthwhile"
    Around card detection, the [forum](https://forum.espuino.de) already has numerous discussions
    with practical tips (German-language). A quick search there often gets you to the answer faster
    than a long trial-and-error session – it's worth taking a look.

## The SD card isn't detected

By far the most common reason is the file system: ESPuino needs **FAT32**, but many cards ship
**exFAT-formatted** from the factory. Reformat the card as FAT32 on a computer – for cards over
32 GB, this is almost always necessary. If the LEDs blink **red** permanently during boot, that's
exactly the signal for "SD unreadable"; ESPuino then stays in that state until a usable card is
inserted (or falls asleep if `SHUTDOWN_IF_SD_BOOT_FAILS` is active). If reformatting doesn't help,
try a different card as a test – especially very cheap or very old cards don't always run reliably.

!!! tip "No web interface without an SD card – use the serial console"
    Without a readable SD card, **ESPuino doesn't fully start up**, and you can't reach the web
    interface in the first place – so the browser log route is out. Instead, take a look at the
    **serial console**, for instance the one in the
    [ESPuino Firmware Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/) (see below under
    "When nothing works anymore"). It usually states directly why the card is being rejected.

If a card can't be read – or none is inserted at all – the log message typically looks like this:

```text
E (7918) sdmmc_common: sdmmc_init_ocr: send_op_cond (1) returned 0x107
E (7918) vfs_fat_sdmmc: sdmmc_card_init failed (0x107).
E [7928] SD card could not be mounted.
```

## No sound, or distorted sound

If there's no sound at all, first check the obvious: the volume and its maximum values in the web
interface (General tab → Playback). If it sounds distorted, the **gain** may be set too high – on
the [Complete](../hardware/complete.md), a solder bridge sets the base gain – no bridge gives
+9 dB, JP2 gives +3 dB, JP3 gives +15 dB (only ever set one). And for headphones, the wired
[headphone board](../bedienung/am-geraet.md#kopfhorer-detection-lautstarke-profile) is the reliable
option.

## Individual titles don't play or stutter (MP3) { #einzelne-titel-machen-probleme-mp3 }

Sometimes the device isn't at fault, but a single file. With MP3s especially, **embedded cover
art** is often the cause, or an unusual encoding. In such cases, a clean re-encode can help, for
example with [ffmpeg](https://ffmpeg.org/):

```bash
ffmpeg -i problem.mp3 -vn -c:a libmp3lame -q:a 2 clean.mp3
```

The `-vn` removes the embedded cover (which technically travels along as a "video" track), `-q:a 2`
ensures good quality. If it affects a whole folder, wrap the command in a small file loop in your
shell.

!!! note "Sometimes it's the audio library"
    ESPuino uses the [ESP32-audioI2S](https://github.com/schreibfaul1/ESP32-audioI2S/) library for
    playback. Every now and then, a playback problem turns out not to be about your file or your
    device at all, but a **bug in this library**. We report such cases to the developer, and they
    get fixed. In short: not every problem is yours to solve (or fix). Just report it on the
    [forum](https://forum.espuino.de) – we'll look into it together and figure out what's going on.

## Wi-Fi problems { #wlan-probleme }

Two things are easy to overlook. First: the ESP32 only transmits on **2.4 GHz** – a pure 5 GHz
network is invisible to it. Second: the address must always be opened with **`http://`**, ESPuino
doesn't support `https` (the background is covered in
[chapter 7](../inbetriebnahme/erststart.md#das-webinterface-offnen)). Otherwise, the usual suspects
apply: too much distance to the router, a typo in the credentials. If the LEDs stay **green**
instead of white in idle mode, there's no connection – try restarting, moving closer to the router,
or re-entering the credentials.

Especially in areas with **many nearby Wi-Fi networks**, it can also help to **fix the Wi-Fi channel
on the router** instead of letting it choose automatically.

## Boot loops and brownouts

If ESPuino keeps restarting, or shuts off in the middle of operation, there's almost always a
**power supply problem** behind it. A source that's too weak – a thin USB cable, an underpowered
power supply, a nearly empty battery – briefly sags under the current demand at power-on or at
volume peaks and triggers a brownout reset. A stronger source and a better cable fix this. As a
reminder: the Complete delivers a stable 3.3 V through its buck/boost regulator and shuts down
cleanly at undervoltage. *(We'll add further special cases from the forum over time.)*

## Accidentally stuck in Bluetooth mode

If you're stuck in Bluetooth mode and can't get any further: just place an **unknown RFID card** –
that brings ESPuino back to normal mode. Alternatively, this also works via the **Off** button of
the mode switch in the Bluetooth tab.

## When nothing works anymore: resetting the device

If your ESPuino doesn't respond at all anymore, hangs during boot, or the web interface simply can't
be reached, the **[ESPuino Firmware Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/)**
is the lifeline. It runs entirely **in the browser** – you just need a USB connection, no
development environment. What's needed is a browser with **WebSerial** support (Chrome, Edge,
Firefox from version 151 onward, Opera, Brave, or Vivaldi); pick a baud rate of **at most 460,800**,
higher values lead to dropouts.

!!! warning "Use a USB cable with data wires"
    Some USB cables are meant **only for charging** and carry **no data wires**. Neither the serial
    console nor flashing works with those – ESPuino is then often not even offered as a port in the
    tool. This is a common issue especially with **extension cables or adapter plugs**. So make
    sure your cable **carries data** (try a different one if in doubt).

Depending on the situation, one of these levels helps – from harmless to drastic:

- **Watch the console.** The built-in serial console shows boot and log output in real time – often
  it directly states what's wrong.
- **Reflash just the app.** If the device still partially works, but the web interface is
  unreachable, **"app update"** reflashes just the firmware on its own. Your **settings and card
  assignments are preserved** in the process.
- **Last resort: erase completely and reflash.** If nothing else helps, you erase the **entire
  flash** (explicitly labeled "emergency use only" in the tool) and use **"complete flash /
  recovery"** to flash everything fresh.

!!! danger "A complete erase also erases your data"
    A complete flash erase also resets the **NVS** – **card assignments, Wi-Fi credentials, and all
    other settings are then gone**. Of these, only the **card assignments** can be restored: they
    live in `backup.txt`
    ([chapter 10 → backup & restore](../inhalte/verwalten.md#backup-restore-deine-kartenzuordnungen-sichern))
    and can be imported again afterward. **Wi-Fi credentials and the remaining settings currently
    can't be backed up** – you'll need to re-enter those by hand after a complete erase.

!!! warning "Choose the right platform and branch"
    When flashing, you need to select the **matching platform** (e.g. Complete) and the **branch**.
    Choosing the wrong one can, in the worst case, **damage the hardware**.

How flashing works in detail is covered in
[chapter 13 · Updating the firmware](../firmware/aktualisieren.md).

!!! tip "Still having a problem?"
    Then ask on the [forum](https://forum.espuino.de). It helps to include the log right away (see
    above) and to mention which board and which firmware version you're using and exactly what
    happens.
