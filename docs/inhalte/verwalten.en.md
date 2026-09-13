# 10 · Managing content

An ESPuino is only as good as what's on its SD card. This chapter is therefore all about how to
get your audio dramas, audiobooks, and music onto the device – and, just as important, how to
organize them so that the playback modes later do exactly what you expect. A bit of structure at
the start saves you a lot of hunting around later.

## Which formats and sources work

ESPuino plays common audio formats directly from the SD card. Specifically, that's **MP3**, **AAC**
(i.e. `.m4a`), **FLAC**, **OPUS**, **OGG/Vorbis**, and **WAV**. That covers the vast majority of
collections; MP3 is the classic, and lossless formats like FLAC work just as well.

Besides local files, ESPuino knows two more sources. First, **web radio**: instead of a file, you
give it a stream address (`http://…`), and ESPuino plays the station for as long as it's on
Wi-Fi. Second, **local `.m3u` lists** – simple text files listing a series of titles. The useful
part: such a list can **freely mix** files from the SD card with web streams.

## A sensible folder structure

The most important idea for organizing content: most playback modes work **on a per-folder basis**.
A folder is therefore the natural unit for an audiobook, an audio drama, or an album. It's worth
setting up a dedicated folder per title or work right from the start, cleanly. A proven structure
looks something like this:

```text
/AudioDramas/
  The Famous Five/
    Episode 001/
      01 - Chapter 1.mp3
      02 - Chapter 2.mp3
    Episode 002/
  Bedtime Stories/
/Music/
  Favorite Songs/
```

Why this care? Because the folder structure directly determines what a card can play. In
**audiobook mode**, the folder is the unit for which ESPuino remembers the last-heard position. The
**recursive modes** additionally include all subfolders – ideal for nested collections. And there
are even modes that pick a **random subfolder**, so a single card can stand for "some audio drama
from the collection".

!!! tip "File names with a leading number"
    ESPuino sorts **naturally** – meaning `1, 2, 10` end up in exactly that order, not as
    `1, 10, 2`. If you number your titles at the start of the file name (`01 - …`, `02 - …`), the
    order comes out reliably right. You can adjust the sort mode itself in the web interface
    (General tab → Playback).

## How ESPuino remembers the position in audiobooks

Audiobook mode is the reason many people reach for ESPuino in the first place, so it gets its own
section. In this mode, ESPuino saves the last-heard position, so the next time the card is placed,
playback continues right where it left off. It saves at the sensible moments – when changing
titles, when pausing, at the end of a title, or at the end of the playlist.

Two cases are **off** by default, but can be turned on in the web interface: saving when
**switching to a different card**, and saving when **powering off**. And for very long chapters,
there's also an optional checkpoint that saves the position at intervals – as protection against
losing an entire hour of progress in a sudden power outage. Where to find and adjust these options
is covered in
[chapter 8 → General tab · Playback](../bedienung/webinterface.md#wiedergabe).

## Cover art and metadata

If a title (or a web stream) comes with embedded **cover art**, the web interface shows it in the
Control tab. It plays no role in playback itself – it's purely cosmetic on screen.

!!! tip "When cover art causes trouble"
    Of all things, embedded cover art is occasionally the culprit when a single MP3 doesn't play
    cleanly or stutters. If you run into a file like that, cleanly re-encoding it without a cover
    usually helps – how to do that with ffmpeg is covered in
    [chapter 15 → MP3](../hilfe/troubleshooting.md#einzelne-titel-machen-probleme-mp3).

## Web radio

You set up a radio station by assigning a card the **📻 web radio** mode and entering the stream
address (the field is conveniently pre-filled with `http://`). If you want to bundle several
stations or a mixed list onto one card, use an **`.m3u` file** for that.

Prefer **`http://` over `https://`** where possible – HTTPS costs noticeably more memory on the
ESP32.

!!! tip "HTTPS stream? Try `http` first"
    If you only have a `https://` address, just try whether the same station also works over
    `http://` – that saves memory, and in practice it often works.

## Backup & restore: securing your card assignments { #backup-restore-deine-kartenzuordnungen-sichern }

One point that's easy to overlook until it's too late: the assignments between cards and content
**don't** live on the SD card, but in the ESP32's internal memory (NVS). If the board ever breaks,
that often painstakingly built assignment list would be lost – unless you've backed it up.

Fortunately, ESPuino takes most of that off your hands. In the SD card's root directory, it
automatically keeps a file called **`backup.txt`** up to date, rewriting it on **every** new
assignment (the file name can be changed via `backupFile` in `settings.h`). Via the **Tools tab**,
you can also **export** and **import** these assignments by hand at any time. Import is
deliberately forgiving: it **only adds and overwrites, never deletes** – so you can restore a
backup without risk, or even transfer it from one ESPuino to another.

!!! tip "Restoring an exact, defined state"
    If you want *exactly* the entries from your backup to exist afterward, and nothing else, proceed
    in two steps: first **delete all assignments** in the Tools tab, then import the backup. Other
    settings are unaffected by this. Background:
    [forum #508](https://forum.espuino.de/t/die-backupfunktion-des-espuino/508) (German-language).

The most important piece of advice to close with: export a backup every now and then and keep it
**outside the SD card** – that way you're covered even if the card itself eventually gives up.
