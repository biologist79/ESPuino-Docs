# 9 · Operation at the device

The web interface is there for setup – but day to day, you operate your ESPuino at the device
itself: with cards, buttons, the rotary knob, and a glance at the LED ring. This chapter explains
how these controls work together and how to read the many states ESPuino communicates to you via
the Neopixels.

## Operating modes { #betriebsmodi }

ESPuino has three basic operating modes. In **normal mode**, it plays content from the SD card as
usual. In **Bluetooth source** mode, it sends audio to a Bluetooth device, such as headphones. And
as a **Bluetooth sink**, ESPuino itself becomes the speaker, which you can stream to from your
phone, for instance. You switch between modes via modification cards or the web interface.

!!! note "Bluetooth and Wi-Fi"
    Bluetooth and Wi-Fi run **in parallel** on ESPuino. Just be aware that this uses up memory, and
    that this parallel operation hasn't been tested very extensively.

## Playback modes

A card's playback mode decides *how* its content plays: whether a single title, a whole folder
sorted or shuffled, an audiobook with a remembered position, and so on. Because the modes are
closely tied to card assignment, they're listed there in full detail, with icon and description:
[web interface → playback modes](webinterface.md#abspielmodi). The technical IDs are in the
[appendix](../referenz/anhang.md#playmodi).

### Recursive modes and jumping between folders

The **recursive** playback modes deserve a special mention. They include not just the selected
folder, but also its **subfolders** – sorted, shuffled, or as an audiobook with position memory.
How deep ESPuino looks into the folder structure is set by the **recursion depth** (0 to 4, default
2; adjustable in the General tab → Playback).

Only in these recursive modes does **folder jumping** also work: the "next folder" action jumps to
the first title of the next folder, and "previous folder" jumps back accordingly – each following
alphabetical order. You can assign both actions to buttons in the web interface.

!!! warning "Watch out with the recursive audiobook mode"
    In recursive audiobook mode, the playlist is rebuilt every time it's loaded. If new folders are
    added afterward, the remembered position can shift as a result.

## Modification cards { #modifikationskarten }

Not every card has to start content – a card can also trigger a **function** instead, such as
setting a sleep timer, locking the buttons, or switching the light. These "modification cards" are
a powerful tool, especially for everyday life with children. You'll find the full catalog when
teaching a card in the [web interface](webinterface.md#modifikationskarten-alle-optionen); the
technical IDs are listed in the [appendix](../referenz/anhang.md#modifikationskarten).

## Buttons and button combinations { #tasten-und-tastenkombinationen }

The following layout is the **factory default** – in the web interface (look for "dynamic button
layout"), you can fully customize it. On the [Complete](../hardware/complete.md), the buttons are
physically assigned as follows: button 0 is Next, button 1 is Previous, button 2 is Play/Pause,
button 3 is the button inside the rotary encoder, and buttons 4 and 5 are optional, freely
assignable buttons. These numbers are fixed and can't be changed; but they only really matter to
programmers anyway.

A **short** press and a **long** press each trigger different actions:

| Button | Short press | Long press |
| --- | --- | --- |
| 0 · Next | Next title | Last title |
| 1 · Previous | Previous title | First title |
| 2 · Play/Pause | Play/Pause | Play/Pause |
| 3 · Encoder button | Measure battery voltage | Deep sleep |
| 4 (optional) | Seek backward (n seconds) | Volume + |
| 5 (optional) | Seek forward (n seconds) | Volume − |

How far the two seek buttons jump is up to you: **30 seconds** per button press by default,
changeable in the web interface
([chapter 8 → Rotary encoder & buttons](webinterface.md#drehencoder-taster)).

On top of that, there's a particularly handy gesture: **hold a button while turning the rotary
knob at the same time.** As long as you hold the button, turning it performs that button's special
action. By default, holding Next controls seeking forward and backward within the title, and
holding Play/Pause controls the LED brightness.

For seeking via the rotary knob, there are **two variants** to choose between – assigned in the web
interface ([chapter 8 → Rotary encoder & buttons](webinterface.md#drehencoder-taster)):

| Variant | What happens | Factory default |
| --- | --- | --- |
| **Direct seeking** | Every detent jumps **immediately** forward or backward by a fixed amount of time – no display, no waiting. | ✔ assigned to Next |
| **Position preview** | Playback keeps running for now, only a cursor moves toward the target; the jump only happens at the end. | – you assign this yourself |

**Position preview** is the more comfortable of the two, but you have to assign it deliberately.
When it's active, the LED ring turns **yellow** as soon as you hold the button down – even before
you start turning. As you turn, a **blue** marker (the cursor) then moves to the position the jump
would land on (if you only have a single LED, it simply lights up blue during this). Only once you
release the button, or stop turning for a while – around two seconds by default – does playback
actually jump there. That way you can hit a spot precisely, instead of feeling your way forward and
backward blindly.

With **direct seeking**, none of that happens: the LEDs keep showing the normal progress, and every
detent jumps immediately. That's coarser – a quick spin covers many detents at once – but it also
works on an ESPuino with no Neopixels at all, where a preview would have nothing to display.

And finally, actions can be assigned to **simultaneously pressed pairs of buttons**. By default,
Next and Play/Pause together start the FTP server, and Previous and Play/Pause announce the IP
address.

!!! note "Wi-Fi toggling is deliberately disabled"
    The Next + Previous combination would toggle Wi-Fi on and off – but it's **disabled** by
    default, so children don't accidentally knock out the Wi-Fi.

## The rotary encoder

Normally, the rotary knob controls the volume: turn right for louder, left for quieter. If that's
reversed on your device, you don't need to resolder anything – you simply reverse the rotation
direction in the web interface. Besides plain turning, the encoder can do more: the
already-mentioned "hold and turn" gesture, which among other things lets you seek within the
current title – either directly or via the position preview described above.

## Reading the Neopixels as a display

The LED ring is ESPuino's language – it tells you at a glance what's currently happening. The
number of LEDs, the color gradient, and the direction of travel can be set in the web interface;
the following colors are the default values.

**During boot**

| Situation | LED display |
| --- | --- |
| Booting | Half the LEDs circle in **orange**. This is followed by idle mode – or red blinking if there's an SD card problem. |

**In status / idle mode**

| Situation | LED display |
| --- | --- |
| Wi-Fi connected | Four slowly circling LEDs in **white**. |
| No connection | Four slowly circling LEDs in **green**. |
| Searching for Wi-Fi | Four slowly circling LEDs in **orange**. |
| Bluetooth active | Four circling LEDs in **blue**. |
| Building playlist | Four LEDs spin quickly in **purple**. |
| Action accepted | Brief **green** flash of all LEDs. |
| Action rejected | Brief **red** flash of all LEDs. |
| Powering off (holding button) | A **red** circle grows for as long as you hold the button. |
| Buttons locked | The progress LEDs turn **red**. |

*You only see the circling connection LEDs (white/green/orange/blue) during **idle mode**, i.e.
when ESPuino isn't currently playing anything. Once playback starts, the ring shows the track
progress instead (see below).*

**During playback**

| Situation | LED display |
| --- | --- |
| Track progress | Color gradient (green→red by default) as a number of lit LEDs. |
| Playlist progress | Blue LEDs briefly fan out at the start of a title. |
| Web stream | Two very slowly circling LEDs in shifting rainbow colors. |
| Pause | Four **orange** LEDs. |
| Changing volume | Green-to-red bar. |
| IP announcement | Rotating **yellow** LEDs. |

**During battery measurement & data transfer**

| Situation | LED display |
| --- | --- |
| Undervoltage | Three brief **red** flashes. |
| Checking charge level | A short press on the encoder button shows it as an LED bar. |
| Download / firmware update | Progress runs in **blue**. |

More on this in
[forum #86](https://forum.espuino.de/t/was-zeigt-der-neopixel-des-espuino-alles-an/86)
(German-language).

## Headphones and volume profiles { #kopfhorer-detection-lautstarke-profile }

ESPuino can detect whether headphones are plugged in and use a separate volume maximum for that
case – useful, since headphones tend to sound noticeably louder than a speaker at the same setting.

!!! tip "Recommendation for headphones"
    For headphone use, the wired **headphone board** is the reliable option and, when in doubt, the
    recommended one. Bluetooth headphones (via Bluetooth source mode) do work, but are less
    reliable – a few isolated issues have been reported.
