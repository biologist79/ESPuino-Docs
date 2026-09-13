# 7 · First start

Your ESPuino is assembled, powered – via a USB power supply or, if fitted, a battery – and the SD
card is inserted. Now it's time for the first sound to come out of the speaker. This chapter walks
you through exactly that first start: from switching it on, through setting up Wi-Fi, to the moment
you place the first card and a track starts playing. We'll go through the steps one by one and
explain *why* something happens at each point – so if in doubt, you can judge for yourself whether
everything looks right.

One assumption up front: firmware is already installed on your ESPuino. On the
[**Complete**](../hardware/complete.md), that's the case from the factory – so there's nothing to
flash and you can dive right in.

If you **built your ESPuino yourself**, on the other hand, the firmware comes first. There's a
limitation worth knowing here: ready-built firmware is only produced automatically for the few
platforms that have ready-made builds (Complete, mini4L, and the older `lolin_d32_pro`). For
different self-built hardware, there's therefore **nothing you can simply flash** – you'll need to
compile a matching firmware yourself using **VS Code and pioarduino**. How to do that is covered in
[chapter 13 · Updating the firmware](../firmware/aktualisieren.md); come back here afterward.

!!! note "The very first start takes a moment"
    On first power-up, ESPuino internally creates a number of default settings. Messages that look
    like errors can show up in the serial console during this – for instance, that a value hasn't
    been found yet. That's normal: these values are just being created, and by the second start the
    messages are gone. So don't let that worry you.

    Not everyone has access to a serial console, though – normally you'd need a development
    environment for that. If you still want to follow along: the
    [ESPuino Firmware Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/) brings such a
    console right into your browser.

## Access point mode: why ESPuino opens its own Wi-Fi network first

For ESPuino to make music available to you over the network and let itself be configured
conveniently, it needs access to your Wi-Fi. On the very first start, though, it doesn't know your
Wi-Fi at all yet. ESPuino solves this chicken-and-egg problem by **opening its own Wi-Fi network**
that you can join, so you can then tell it about your "real" Wi-Fi network.

This setup network is called **`ESPuino`** by default and is initially open, i.e. without a
password. It's only a stopgap for initial setup and disappears again once ESPuino has joined your
Wi-Fi network. (You can rename it and secure it with a password later in the
[Wi-Fi tab](../bedienung/webinterface.md#tab-wlan) – which also explains why you shouldn't leave
this open access point active permanently.) So go to the Wi-Fi selection on your computer or
smartphone and connect to the `ESPuino` network. Once the connection is up, ESPuino automatically
assigns your device an address, and you can open the setup page in your browser. It lives at the
fixed address **`http://192.168.4.1`**. On many devices, this page even opens by itself (a
so-called "captive portal", which you may know from hotel or café Wi-Fi); if it doesn't, just type
the address into the address bar by hand.

!!! tip "If your smartphone is being difficult"
    Some smartphones notice that no internet is reachable over this Wi-Fi network and quietly
    refuse to load the page – or even secretly switch back to mobile data. Usually a small prompt
    appears along the lines of "This Wi-Fi network has no internet access – stay connected
    anyway?". Confirm that, and it'll work. Either way, initial setup is easiest on a regular
    computer.

## Setting up Wi-Fi

On the setup page, you now enter your own Wi-Fi network. That's three small steps:

1. **Choose your Wi-Fi network name** from the list of networks found. ESPuino shows you what's in
   range, so you don't have to type it and risk a typo.
2. **Enter the Wi-Fi password.** It's stored on the ESPuino, so it can connect on its own from now
   on.
3. **Give it a hostname**, for example `espuino`. The hostname is the name your ESPuino will later
   show up under on the network – and, as will matter shortly, the most convenient way to find the
   web interface again. If you have several ESPuinos, give each one its own descriptive name (say,
   `espuino-kidsroom`).

Once you save, you don't have to restart on faith and hope for the best. ESPuino tries out the
credentials **right away**, while the setup page stays open, and shows you directly there how it's
going – whether it's connecting, whether it failed, or whether the connection is up. If it doesn't
work, just correct your input without starting over. And once ESPuino is on the Wi-Fi network, the
LED ring also reports the connection status – the next section shows you how to read it.

### Reading the Neopixels as a status display

The LED ring (the "Neopixels") isn't just decoration – it's ESPuino's most important feedback
channel. Right now, while connecting, it's worth a look:

- **Four slowly circling white LEDs** mean: the Wi-Fi connection is up and ESPuino is ready. That's
  the signal you're waiting for.
- **Green LEDs**, on the other hand, mean: there's (still) no Wi-Fi connection. That's normal
  briefly while connecting; but if it stays green permanently, either the connection didn't
  succeed, or no credentials have been entered at all yet.

If it stays green, that's no reason to worry – usually one of three common causes is behind it: a
typo in the password, too much distance to the router, or simply a connection attempt that hasn't
finished yet. Try restarting ESPuino, move closer to the router, and if needed, re-enter the
credentials carefully. A more detailed Wi-Fi troubleshooting guide is in
[chapter 15 · Troubleshooting](../hilfe/troubleshooting.md#wlan-probleme).

## Opening the web interface { #das-webinterface-offnen }

Once ESPuino is on the Wi-Fi network, you manage it through the **web interface** – the operating
and configuration screen you simply open in your browser. There are two ways to get there.

The convenient way is via the **hostname** you just assigned. If mDNS is active (which is the
default), you can reach your ESPuino at **`http://espuino.local`** – or under whatever name you
chose. So you don't have to remember an IP address. If you run a FritzBox router, you can also use
`http://espuino.fritz.box`. The second way is to enter the **IP address** directly that ESPuino got
from your router; you can find that, for instance, in your router's device list.

!!! warning "Always `http://`, never `https://`"
    ESPuino deliberately speaks only unencrypted **HTTP**. There's a solid reason for that:
    encryption (HTTPS/TLS) costs a fair amount of memory, and the ESP32 doesn't have much to spare
    in the first place – for a device on your own home network, unencrypted HTTP is therefore the
    pragmatic choice. So always open the address with `http://`. Some browsers add a `https://` on
    their own; then the page won't load, and you'll need to add the `http://` by hand.

### A quick aside: static IP address

By default, ESPuino gets its address automatically from the router (via DHCP), and that's plenty
for the vast majority of people. If you want, you can give it a fixed IP address instead – the
settings for that are found later in the Wi-Fi tab. That's not something you need for the first
start, though.

!!! warning "Use a fixed IP with care"
    An incorrectly set static IP configuration (address, subnet mask, gateway, DNS that don't match
    your network) can result in ESPuino becoming completely unreachable over Wi-Fi. Only use this
    option if you know what you're doing – when in doubt, stick with automatic assignment.

## Copying content onto the SD card

ESPuino plays its content – audio dramas, audiobooks, or music – from the SD card. For it to be
able to read the card, it must be formatted with the **FAT32** file system – not exFAT. Cards over
32 GB almost always come as exFAT from the factory, so you'll almost certainly need to reformat
them as FAT32 on a computer first. (Windows often doesn't even offer FAT32 for cards that large in
its standard dialog; a small formatting tool helps there.)

There are several ways to get files onto the card – and for getting started, the order is fairly
clear:

- **Pre-load it on your computer.** Take the SD card out once and load it directly on your
  computer. This is by far the fastest option and, for the first, larger batch of content, clearly
  the most sensible way.
- **Web upload.** The convenient default: you upload individual files or entire folders directly in
  the web interface (RFID tab, Files section). The web upload has been optimized and is by now
  **the fastest option even for larger amounts of data** – up to roughly **650 KiB/s** (somewhat
  less in SPI mode, which the Complete and mini4L don't use, though).
- **FTP.** An alternative over the network – but only a few people use it, and it's not optimized
  for speed; the web upload is nowadays usually faster. The service also needs to be enabled first
  (see below, and [chapter 8](../bedienung/webinterface.md#tab-ftp)). Mainly useful if you already
  work with an FTP client anyway.
- **MediaHub.** If you run several ESPuinos, MediaHub distributes content centrally over the
  network (see [chapter 11](../inhalte/mediahub.md)).

How to structure your content into folders afterward, so the playback modes later do exactly what
you expect, is covered in [chapter 10 · Managing content](../inhalte/verwalten.md).

## Teaching the first card

Now comes the best part: linking an RFID card to some music. It's called "teaching" because ESPuino
remembers *which* card should start *which* content. Important to know – and surprising to some:
**nothing** is written to the card itself in the process. ESPuino only reads the card's unique
number (its ID) and stores the assignment in its internal memory – the so-called NVS. So you can
use ordinary, off-the-shelf RFID cards, chips, or stickers – specifically the **ISO-14443**
standard, and (only with the PN5180 reader) **ISO-15693**. So it's not entirely "anything goes",
but the vast majority of common tags will work.

Here's how you do it:

1. **Place a not-yet-used card on the reader.** As long as the RFID reader can read this card,
   ESPuino immediately recognizes that it doesn't know this card yet.
2. **Watch the Neopixels:** they acknowledge placing the card with a brief **red** flash. That's
   not an error message, simply the sign for "unknown card detected".
3. **The card number appears automatically** in the matching input field in the web interface – a
   twelve-digit number. So you don't need to type it in yourself; placing the card is enough.
4. **Pick what should play in the file browser** – a single file or an entire folder. The path is
   filled in automatically.
5. **Set the playback mode.** It decides *how* the content plays: a single title, a whole folder
   sorted or shuffled, an audiobook with a remembered position, and so on. Which mode is meant for
   what is explained in the overview in the
   [web interface chapter](../bedienung/webinterface.md#abspielmodi).
6. **Save the assignment.** Done – from now on, this card starts the chosen content whenever you
   place it. 🎉

!!! tip "Quick test without sacrificing a card"
    Just want to hear briefly whether a file plays cleanly? In the file browser, right-click (on a
    smartphone: long-press) a file or folder to **play it directly** – without teaching a card at
    all.

## A few sensible first settings

Before the ESPuino ends up in children's hands, two small adjustments are worth making now to save
you trouble later.

The first concerns **volume**. In the General tab, you can set a maximum volume (on a scale from 0
to 21), separately for speaker and headphones. That way the box can't get uncomfortably loud in the
first place – a welcome setting especially around children.

The second concerns **FTP**, in case you'd like to use it at some point – most people don't need
it, since the web upload is faster and more convenient. FTP doesn't run all the time for good
reason: it would permanently occupy memory that ESPuino could put to better use, for web radio, for
instance. So you only enable the FTP service when needed – either in the FTP tab or via a **button
combination on the device** (the Neopixels confirm this with a brief green flash). After the next
restart, FTP is off again.

## What's next

With that, your ESPuino is up and running. Everything touched on here is described in full detail
elsewhere: the complete user interface in
[chapter 8 · The web interface](../bedienung/webinterface.md), operation at the device with all
buttons and displays in [chapter 9](../bedienung/am-geraet.md), and organizing your music in
[chapter 10](../inhalte/verwalten.md). Enjoy listening.
