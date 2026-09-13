# 1 · What is ESPuino?

## The idea in one sentence

ESPuino is a self-built, RFID-controlled audio player: you place a card on it, and an audio drama,
an audiobook, or a playlist starts playing. Take the card off, or place a different one on, and the
content changes. It's an interaction concept even the youngest children grasp immediately – and
that's exactly what ESPuino was designed for in the first place: a robust, child-friendly audio box
that needs no screen, no account, and no cloud.

The name gives away its origins: at its heart sits a microcontroller from the **ESP32** family.
Around that core, an astonishingly complete device has grown over the years – with an amplifier,
battery charging, an LED display, buttons, and a rotary knob. Even so, ESPuino remains an open
DIY and self-build project: the source code is free, the hardware is documented, and you decide
for yourself how big, how loud, and how colorful your box turns out – just how varied that can be
is shown by the gallery
[„Zeigt her eure ESPuinos"](https://forum.espuino.de/t/zeigt-her-eure-espuinos/554) (German-language
forum).

One point is important to understand, because it explains a few things later on: **nothing is ever
written to the RFID cards themselves.** ESPuino only reads a card's unique number (its ID) and
keeps track internally of which content belongs to it. So you can use ordinary, off-the-shelf RFID
cards, chips, or stickers – specifically the **ISO-14443** standard, and (only with the PN5180
reader) **ISO-15693** – and reassign the very same card to different content at any time.

## What does an ESPuino consist of?

This is the question asked most often – so here's an overview right at the start. The following
list describes a typical ESPuino based on the
[**Complete** board](../hardware/complete.md), which is what this handbook focuses on. Much of
this already comes pre-assembled on the Complete board; you only need to add the parts that
depend on your own preferences (which speaker, which battery, which enclosure).

| Component | What it's for, and what you should know |
| --- | --- |
| **Complete board** | The foundation. It already integrates an ESP32-WROVER, amplifier, charge controller, voltage monitoring, port expander, and SD slot. |
| **RFID reader** | Reads the cards. You can choose between the affordable RC522 or the more capable PN5180. |
| **microSD card** | Stores your content. Must be formatted as **FAT32**; 32 to 64 GB is usually plenty. |
| **Neopixels** | Addressable LED(s) for status and progress – most commonly a ring, though a strip or even a single LED works too. Formally optional, but in practice **hard to do without**: they're the central feedback channel (connectivity, progress, battery, errors …). **Strongly recommended.** |
| **Speaker** | For sound output. Headphones are optionally possible via a separate headphone board. |
| **Rotary encoder + up to 5 buttons** | Controls at the device itself; both are optional. The default layout provides for three buttons plus the rotary encoder. |
| **Battery** | For mobile operation (LiFePO4 or LiPo, each **with a protection circuit**). Also optional – ESPuino runs fine on a USB power supply alone. Details in [chapter 4 · The battery](../hardware/akku.md). |
| **Enclosure** | Usually 3D-printed. You'll find a ready-made reference design in [chapter 6 · The enclosure](../hardware/gehaeuse.md). |

A more detailed version of this is also available in the
[forum FAQ](https://forum.espuino.de/t/oft-gestellte-fragen-faq/24) (German-language).

## The ESPuino ecosystem

ESPuino is more than a single repository, and it helps to know how the pieces fit together – that
way you'll know later where to find what:

- **[ESPuino](https://github.com/biologist79/ESPuino)** is the **firmware**, i.e. the software that
  runs on the device. It's the subject of this handbook.
- **[ESPuino-Firmware](https://github.com/biologist79/ESPuino-Firmware)** provides **ready-built
  firmware releases** that you can flash without compiling anything yourself.
- **[MediaHub](https://github.com/biologist79/ESPuino-Mediahub)** is an optional add-on component
  for managing the card assignments of several ESPuinos **centrally** (see
  [chapter 11](../inhalte/mediahub.md)).
- The **[forum](https://forum.espuino.de)** is the place for questions, announcements, and exchange
  with others. This handbook consolidates the knowledge; the discussion lives on in the forum.

## A look back: the development lineage

ESPuino has grown over several years, and it's worth placing that briefly in context – not least
because you'll still run into older builds in the [forum](https://forum.espuino.de). It started
with genuine DIY builds, where individual modules were plugged together and wired by hand. From
there came stripboard builds, and later carrier boards that housed ready-made developer boards.
The direct predecessor of today's Complete is the [**mini4L**](../referenz/mini4l.md), which used
a purpose-built ESP32 board plugged into it.

The **Complete** is the logical continuation of that line: functionally, it offers essentially the
same as the mini4L, but combines everything (apart from the headphone board) onto a single board.
That lowers cost and considerably simplifies assembly. That's exactly why this handbook centers on
the Complete; the mini4L still appears as its most recent predecessor, but only where it differs
from the Complete ([chapter 16](../referenz/mini4l.md)). We don't cover older stages.

## Small glossary

A handful of terms keep coming up throughout the handbook. You don't need to memorize them – just
look them up here whenever you're unsure:

| Term | Meaning |
| --- | --- |
| RFID | A contactless card or tag used to start a piece of content. ESPuino only reads the ID; it never writes anything to the card. |
| NVS | "Non-Volatile Storage" – the ESP32's internal memory, where settings and card assignments live. A regular firmware update does **not** overwrite it, so your settings survive. |
| HAL | "Hardware Abstraction Layer" – selects, at compile time, which board (with which pins) the firmware is built for; often also called the **platform** (e.g. `complete`, `lolin_d32_pro_sdmmc_pe`, `lolin_d32_pro`). |
| Neopixel | Addressable LED(s) used for status and progress display. Often arranged as a ring; ideally the LED count is **divisible by four**, since several animations are designed around that. |
| Deep sleep | The power-saving deep sleep that ESPuino enters after a period of inactivity – or when you "switch it off". A true, complete shutdown (power fully removed) isn't provided for by default but is possible; it comes with a somewhat longer boot time on the next power-up. |
| Playmode | The playback mode of a card (single title, audiobook, whole folder …). All modes in detail: [chapter 8 → Playback modes](../bedienung/webinterface.md#abspielmodi). |
| Modification card | A card that doesn't start any content but triggers a function instead – a sleep timer, for example. All actions in detail: [chapter 8 → Modification cards](../bedienung/webinterface.md#modifikationskarten-alle-optionen). |
| LiPo | Lithium-polymer battery. Nominal voltage ~3.7 V, charge cutoff 4.2 V. High energy density (lots of capacity per size/weight), but more sensitive and less durable. |
| LFP | Lithium iron phosphate battery (LiFePO₄). Nominal voltage ~3.2–3.3 V, charge cutoff ~3.6 V. Very safe and durable, but lower energy density (less capacity) and lower voltage. |
