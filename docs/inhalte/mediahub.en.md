# 11 · Managing multiple ESPuinos centrally: MediaHub

## What problem MediaHub solves

As long as you run a single ESPuino, everything is simple: you set up your card assignments in the
web interface, and they live in that one device's memory. But once several ESPuinos live in the
household – one in the kids' room, one in the living room, one for the road – maintenance gets
tedious. You'd have to teach every new card individually on every device, and load each SD card
separately.

That's exactly the problem **MediaHub** addresses. MediaHub is an **optional** add-on component
that lets you manage card assignments **centrally** in one place, instead of on every device
separately. If you only have one ESPuino, you don't need MediaHub – for everyone else, it can make
management considerably easier.

!!! info "Where the full guide lives"
    This chapter gives you the concept and a way in. The detailed documentation on setup and
    operation is maintained directly in the
    [MediaHub repository](https://github.com/biologist79/ESPuino-Mediahub), and the in-depth
    discussion happens in
    [forum thread #4607](https://forum.espuino.de/t/espuino-mediahub/4607) (German-language).

## How it works

MediaHub is a small, **self-hosted server service** that runs as a Docker container on your own
network – so the data stays at home with you, nothing goes off to a third-party cloud. This server
holds the central card assignments.

On the ESPuino itself, you then enter in the web interface which MediaHub server(s) exist. When you
place a card that's configured for MediaHub, the ESPuino asks the server what belongs to that card,
and downloads the needed files to its SD card the first time. After that, it plays locally from its
own card.

If you change something centrally, the update **doesn't happen automatically**: you trigger it on
MediaHub with **"Force Refresh"**. The ESPuino then notices the new version the next time the card
is placed, downloads the changed files, and then plays the current version. Web radio streams can
be assigned this way too.

!!! note "What's centralized – and what isn't"
    MediaHub doesn't take **placing the cards** off your hands: you still need to place each card
    **once per device** and point it at MediaHub there. The reason: otherwise MediaHub itself would
    need its own RFID reader just to know the card's ID at all. What's centralized is only the
    **actual link to the content** – i.e. which files or stream and which playback mode belong to a
    card. You maintain that assignment once on MediaHub, and every device pulls it from there.

## Setting up the MediaHub server

The server is started as a Docker container. The short version looks like this (full details are
in the MediaHub repository):

```bash
cp env-example .env       # your own settings go into .env
mkdir -p data
chown -R 33:33 data
docker compose up -d --build
```

The trick here: your personal settings live in the `.env` file, not in the shipped files. That has
a practical reason – it keeps a later update conflict-free:

```bash
git pull
docker compose up -d --build
```

## Assigning cards centrally

In the ESPuino's RFID tab, you register your MediaHub server (or several of them). A card you
assign the MediaHub mode fetches its "manifest" from the server when placed – i.e. the information
on what it should play – downloads the files the first time, and keeps them up to date afterward
via checksum.

## Further reading

- [ESPuino-Mediahub on GitHub](https://github.com/biologist79/ESPuino-Mediahub) – the full
  documentation.
- [Forum thread #4607](https://forum.espuino.de/t/espuino-mediahub/4607) – introduction and
  discussion (German-language).
