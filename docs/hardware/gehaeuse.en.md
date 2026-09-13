# 6 · The enclosure

Where does the fully wired board go? Most ESPuinos live in a **3D-printed enclosure** – how big,
how colorful, and what shape is entirely up to you. This chapter gives you a starting point; beyond
one reference design and a few pointers, not much more is needed.

!!! tip "Get inspired by the gallery"
    Just how varied ESPuinos can look – from 3D printing to wood to repurposed found objects – is
    shown by the gallery
    [„Zeigt her eure ESPuinos" (#554)](https://forum.espuino.de/t/zeigt-her-eure-espuinos/554)
    (German-language forum). A great source of ideas for your own enclosure.

## The reference design: the BioBox { #referenz-design-biobox }

The **[BioBox 3D](https://forum.espuino.de/t/biobox-3d/3130)** (German-language forum) serves as
the **reference design**, a 3D-printable enclosure for the Complete or mini4L. It gives a good
sense of what a finished ESPuino can look like: a cube roughly 12 cm on each side, a honeycomb
grille at the front for the speaker with a recess for the Neopixel ring, three buttons and the
rotary encoder on top, USB-C and the headphone jack at the back, and an access hatch plus a battery
holder on the bottom (for 18650, 26650, or 32700 cells). The print files are available as STL and
as a Fusion 360 file; recommended settings are PETG, five wall layers, and 35% infill (roughly 17
hours of printing on a Bambu Lab P1S).

![The BioBox 3D: a light blue and white, cube-shaped ESPuino with a honeycomb speaker grille, three buttons, and a rotary encoder](../assets/Biobox3d.jpg)
*The BioBox 3D – the reference design for a 3D-printed ESPuino enclosure.*

## It doesn't have to be 3D printing: wood and more

3D printing is the most common approach, but far from the only one. Some people use a **ready-made
wooden box** (say, one from a craft supply store) and cut the necessary openings into it themselves;
others **build their enclosure entirely out of wood**. A nice example is the
**[BioBox v2 (#1654)](https://forum.espuino.de/t/biobox-v2/1654)** (German-language forum) – the
wooden predecessor of today's BioBox 3D.

## What to keep in mind for the enclosure

Whether BioBox or your own design – every enclosure should provide a few cutouts, access points,
and open surfaces:

- **RFID reader** – this is the one component that needs *no* opening at all, but rather an
  **open surface**: it reads through the enclosure wall. So plan an area where the reader sits and
  where cards get placed – with no metal in between and a wall that isn't too thick.
- **Speaker** – a grille or holes in front of the membrane, so nothing can get pressed in.
- **Neopixel** – an opening or a light-permeable window for the ring. The bare LEDs aren't
  particularly attractive on their own; a **diffuser ring** conceals them and makes the light both
  softer and more even.
- **Buttons and rotary encoder** – cutouts at the appropriate spots.
- **USB-C** – easily reachable for charging and flashing. **Magnetic USB connectors** have proven
  useful here: the small adapter stays permanently in the socket, while the cable attaches
  magnetically from outside. Above all, this means nothing can get accidentally torn off – if
  someone trips over the cable or pulls on it, the magnetic connection simply releases instead of
  damaging the socket or the board. As a bonus, it's also easier to hit the enclosure opening with
  it.
- **Headphone jack** – if you install the headphone board. Unlike with USB, you **can't** work
  with a permanently plugged-in adapter or an extension cable here: as soon as a headphone plug
  sits in the jack, ESPuino detects that as "headphones connected" and the speaker stays silent.
  The jack itself therefore needs to be reachable from outside. So the small board doesn't end up
  loose inside the enclosure, there's a **3D-printable holder** for it:
  [holder for the headphone board (#3792)](https://forum.espuino.de/t/traeger-fuer-kopfhoererplatine/3792)
  (German-language forum).
- **SD card** – the slot *can* stay accessible, say via an access hatch, so you can take the card
  out to load it with content. That's not required, though: content can just as easily be loaded
  over Wi-Fi ([chapter 10](../inhalte/verwalten.md)). Also consider the flip side – what's
  accessible is just as reachable for children, and SD cards are fragile.
- **Battery** – a holder matching your cell size.

## No 3D printer?

No printer at home? No problem: you can have the print files made by a **print service**, or ask
someone in the **community** – the [forum](https://forum.espuino.de) usually has someone happy to
help out.
