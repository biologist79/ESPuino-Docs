# 12 · Advanced topics

You now know the basic functions. This chapter collects topics for anyone who wants to get more
out of their ESPuino – from integrating it into home automation to extending the hardware. You
don't have to use any of it; think of it as a toolbox you pick from as it suits you.

## Integrating ESPuino into home automation (MQTT)

Everything that can be controlled via a card or button can also be controlled through **MQTT** –
and conversely, ESPuino reports every action and state change back over MQTT: the current volume,
the title playing, the playback mode, and much more. That lets you integrate it cleanly into home
automation, say to turn it down automatically in the evening or show what's currently playing on a
dashboard.

You set this up in the web interface itself
([chapter 8 → MQTT tab](../bedienung/webinterface.md#tab-mqtt)); which topics exist and what they
mean is listed in full in the [appendix → MQTT topics](../referenz/anhang.md#mqtt-topics). For
specific systems, ready-made guides exist: for **Home Assistant**, an
[integration in the forum](https://forum.espuino.de/t/home-assistant-integration/3763)
(German-language), and for **openHAB**, an example configuration in the
[repo's openHAB directory](https://github.com/biologist79/ESPuino/tree/master/openHAB).

## Saving power, deep sleep, and battery runtime

ESPuino is designed to go easy on the battery. The centerpiece is **automatic deep sleep**: after
an adjustable period of inactivity, the device goes into deep sleep and then draws almost nothing.
By default, that's ten minutes (`maxInactivityTime`). The counter runs carefully, though: as long as
music is playing or an FTP client is connected, ESPuino doesn't fall asleep, and every button press
resets the clock.

You can also set a **sleep timer** – via a modification card or over MQTT – that falls asleep after
a fixed time, after the current title, at the end of the playlist, or after five titles. You can
even query the current timer status live via MQTT (topic `sleep_timer_state`, as JSON with mode and
remaining time). And if you run ESPuino on battery, you'll find the warning thresholds, the
display, and the optional automatic shutdown at too-low voltage in the web interface (General tab
→ Power).

## Virtual RFID cards { #virtuelle-rfid-karten }

Not every action needs a physical card. ESPuino has ten **virtual cards** with the IDs
`900000000001` through `900000000010`. You assign them content or modifications in the web
interface – exactly the way you would with a real card (you just enter the chip number by hand).
They're then triggered via a **button**, a **button combination**, or over **MQTT**.

The benefit: you can put frequent actions on a single button press, without having to keep a
special card on hand every time – say, "start favorite playlist" on a button combination. More on
this in [forum #3218](https://forum.espuino.de/t/virtual-rfid-cards/3218) (German-language).

## LPCD: waking up by placing a card { #lpcd }

LPCD (Low Power Card Detection) is a feature that wakes ESPuino from deep sleep as soon as you
place a card – instead of you having to press a button first. For a kids' box especially, that's an
appealing idea: place the card, music plays, with no need to press a button first.

Here's what's technically behind it. Normally, the RFID reader gets shut down along with everything
else when ESPuino enters deep sleep – after all, the goal is to draw as little current as possible.
With LPCD enabled, it instead stays powered and periodically checks on its own whether a card is
nearby. If it finds one, it pulls its **IRQ line** to GND. This line leads to an **RTC-capable
GPIO** on the ESP32, i.e. a pin that's still monitored even during deep sleep – and it's exactly
that level change that wakes the processor. From the ESP32's point of view, this is the same
mechanism as a button press.

What happens immediately afterward is interesting. The ESP32 does boot up – but before it brings up
the rest of the hardware, it inserts a targeted check first: it loads only the settings needed for
LPCD, powers up the reader, looks first for an ISO-14443 card, then for an ISO-15693 card, and looks
up the ID it found in its internal memory. Only if a **known** card is stored there does it fully
boot up and start playing. If it was a false alarm, on the other hand – or a card was placed that
hasn't been assigned any content yet – it goes right back to sleep, before the Neopixels or the rest
of the peripherals are even activated. So under normal circumstances you never notice a false
detection; it only costs a small amount of power.

For LPCD to work, though, several prerequisites need to come together:

| Prerequisite | What applies |
| --- | --- |
| **Reader** | Only the **PN5180**. LPCD isn't possible with an RC522; in that case, the option can't be selected in the web interface. |
| **PN5180 firmware** | At least **version 4.0**. Which version your reader has is reported by ESPuino in the log at startup. Updating the reader's firmware is doable, but a noticeable amount of work. |
| **Solder bridges** | On the [Complete](../hardware/complete.md), **JP8** and **JP1** each need to be set to **1+2** (see [chapter 5 → The solder bridges](../hardware/aufbau.md#die-lotbrucken)). The standard wiring is set at the factory, not the LPCD variant. |
| **IRQ connection** | The IRQ line needs an RTC-capable GPIO. On the Complete, that's **GPIO 32**, which is then unavailable for anything else (it occupies Ext connector 1). On the [mini4L](../referenz/mini4l.md), `RFID_IRQ` is set to `99` at the factory, i.e. off, and would first need to be changed to 32. |
| **Activation** | A checkbox in the web interface under [General → RFID](../bedienung/webinterface.md#tab-allgemein): **"Enable PN5180 LPCD"**. |

If you build your own board, the choice of IRQ pin is limited: on this ESP32, the RTC-capable GPIOs
are **0, 4, 12, 13, 14, 15, 25, 26, 27, 32, 33, 34, 35, 36, and 39** – only one of them is
appropriate for the wake signal.

!!! note "No longer via settings.h"
    In older guides – including the
    [forum thread #1664](https://forum.espuino.de/t/was-ist-lpcd-und-wie-funktioniert-es/1664)
    (German-language), which otherwise explains the feature nicely – LPCD is enabled via a
    `PN5180_ENABLE_LPCD` in `settings.h`. That's no longer accurate: the feature is by now purely a
    runtime setting and is set exclusively in the web interface. A corresponding entry in your own
    `settings-override.h` has no effect anymore.

It's also worth keeping in mind that LPCD and a **hard power-off switch** are mutually exclusive –
the two can't be combined (see [chapter 3](../hardware/complete.md)).

!!! warning "What you should know beforehand"
    As appealing as the idea is – LPCD currently isn't **actively maintained**, users repeatedly
    report **reliability issues**, and it **uses more power**, because the reader stays active
    during deep sleep.

## The PCA9555 port expander

The ESP32 has only a limited number of free pins (GPIOs), and some of them can only be used as
inputs. When things get tight, a **PCA9555** port expander helps out: it connects via I²C and
provides **16 additional channels** (two ports of eight each). On the [Complete](../hardware/complete.md),
it's already on board – so you benefit from it automatically.

In the ESPuino configuration, these channels are addressed with the numbers **`100` to `115`**
(port 0 is 100–107, port 1 is 108–115). That's why values of 100 and above show up in the
[pinout table](../hardware/complete.md#pinout-referenz-complete). Typically, inputs hang off it
(buttons, headphone detection, the encoder button); outputs only in special cases like the
amplifier enable line.

!!! note "Good to know"
    Every change on an expander input triggers an interrupt and wakes the ESP32. It's possible to
    restrict this to individual pins, but it's a fairly involved hack you have to program yourself:
    a pin configured as an **output** no longer raises an interrupt. Setting pins to output isn't
    entirely without risk, though – how to do it and what to watch out for is covered in
    [forum #2613](https://forum.espuino.de/t/aufwecken-nur-ueber-drehencoder/2613)
    (German-language). For the port expander in general, see
    [forum #306](https://forum.espuino.de/t/einsatz-des-port-expanders-pca9555/306)
    (German-language).

## Headless and continuous operation

Not every ESPuino is a mobile kids' box. Some run permanently on a power supply – say, as an
internet radio in the kitchen – or entirely without the usual controls. Both are entirely possible.

For **continuous operation**, it's important to know: as long as something is playing – a file or a
web stream – ESPuino does **not** go into deep sleep. So a radio station keeps running
indefinitely. Automatic sleep only kicks in when nothing is playing and no input has come in for a
while; if you don't want that at all, set the inactivity time in the web interface (General tab →
Power) high enough. On a permanent power supply, battery topics don't matter anyway.

For **headless operation**, this applies: buttons, rotary encoder, and even the Neopixels are all
optional. An ESPuino can be controlled entirely via the web interface and, if desired, via MQTT, and
the RFID cards work independently of that. Thanks to
[modification cards](../bedienung/webinterface.md#modifikationskarten-alle-optionen), it can even be
operated **entirely by card** – with no buttons and no display at all. That way you can build a
deliberately stripped-down box, or integrate ESPuino seamlessly into home automation. In theory,
almost anything is possible with this – whether it makes sense in practice is for you to decide.
