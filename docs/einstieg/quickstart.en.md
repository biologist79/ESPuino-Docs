# 2 · Quickstart: from box to first sound

This chapter is the shortcut for the impatient. It shows you, in a handful of steps, the whole way
from unboxing to the first sound – with no explanation in between. If you'd rather understand
exactly *why* something happens at each step, skip this chapter and read the detailed
[chapter 7 · First start](../inbetriebnahme/erststart.md) instead, where every step is explained at
a relaxed pace.

!!! tip "Prerequisite"
    On the [**Complete**](../hardware/complete.md), the firmware is already installed from the
    factory – so there's nothing to flash. (Self-built devices with different hardware need to
    compile their own firmware first, see [chapter 13](../firmware/aktualisieren.md).)

Here's how you get to the first sound:

1. **Switch it on.** On first boot, ESPuino opens its own Wi-Fi network called `ESPuino`; four
   green LEDs signal this setup mode.
2. **Connect to that Wi-Fi network** and open `http://192.168.4.1` in your browser. On the setup
   page, enter your own Wi-Fi network and password, and choose a hostname.
3. **After the restart**, you can reach the web interface at `http://espuino.local` (or the IP
   address). Four circling white LEDs indicate the connection is up.
4. **Copy content onto the SD card** (audio dramas, audiobooks, music) – to start, the fastest way
   is directly on your computer (the card must be formatted as FAT32). Details in
   [chapter 10](../inhalte/verwalten.md).
5. **Teach the first card:** in the RFID tab, place a card that's not yet known (its number
   appears automatically), pick a folder or file in the file browser, set the playback mode, and
   save.
6. **Place the card – music plays.** 🎉

That was the fast version. From here, it's worth taking a look at
[chapter 8 · The web interface](../bedienung/webinterface.md) next, the heart of configuration.
