# 11 · Managing multiple ESPuinos centrally: MediaHub

![Screenshot of the MediaHub web interface: overview page with tiles for ESPuinos, cards & assignments, new cards, media, and settings](../assets/Mediahub.png)
*The MediaHub overview page: devices, cards & assignments, new cards, and media at a glance. The
interface is also available in English and French (switchable at the top right); this screenshot
shows the German version.*

## What problem MediaHub solves

As long as you run a single ESPuino, everything is simple: you set up your card assignments in the
web interface, and they live in that one device's memory. But once several ESPuinos live in the
household – one in the kids' room, one in the living room, one for the road – maintenance gets
tedious. You'd have to teach every new card individually on every device, and load each SD card
separately.

That's exactly the problem **MediaHub** addresses. MediaHub is an **optional** add-on component
that lets you manage card assignments **centrally** in one place, instead of on every device
separately. If you only have one ESPuino, you don't need MediaHub – for everyone else, it can make
management considerably easier. The feature is deliberately not called "cloud": MediaHub runs
**locally on your own network**, and your media files stay at home with you.

!!! info "Where the full guide lives"
    This chapter covers setup and operation in detail. For details on the source code itself – say,
    if you want to contribute to MediaHub's development – the
    [MediaHub repository](https://github.com/biologist79/ESPuino-Mediahub) remains the source of
    truth; the in-depth forum discussion happens in
    [forum thread #4607](https://forum.espuino.de/t/espuino-mediahub/4607) (German-language).

## How it works

MediaHub is a small, **self-hosted server service** that runs as a Docker container on your own
network (a Raspberry Pi is entirely sufficient for this). It holds the central card assignments and
knows about your media files – which stay exactly where they already are in your own folder
structure; MediaHub doesn't copy or manage them itself, it only mounts them **read-only**.

The process consists of six steps:

1. **Register the MediaHub server.** In the ESPuino web interface, enter your MediaHub server's
   address in the [MediaHub tab](../bedienung/webinterface.md#tab-mediahub). You can register
   several servers and remove them again without affecting cards that are already taught.
2. **Teach a card as "MediaHub".** In the [RFID tab](../bedienung/webinterface.md#tab-rfid), teach a
   new card – as the playback mode, choose **MediaHub**, and below that, pick the desired media
   server from the list of registered servers. You don't specify a path here; ESPuino only knows
   which server to contact.
3. **First tap: registration.** The first time you place the card, ESPuino sends a request to
   MediaHub. There, the card now shows up as "pending" – with the card ID and the identifier of the
   requesting ESPuino, but no content yet.
4. **Assignment on MediaHub.** In the MediaHub web interface, you link the pending card to some
   content – a file, a folder, or a web radio stream – and set the playback mode, exactly as you
   would otherwise do in the ESPuino web interface.
5. **Second tap: download.** The next time the card is placed, ESPuino asks again and this time gets
   back a **manifest** – the list of all the files it needs. It downloads them and stores them in a
   hidden directory on its own SD card. Playback is locked during the download; the Neopixel ring
   shows the progress in blue.
6. **Playback.** Once the download finishes, playback starts – from then on **locally from its own
   SD card**, independent of MediaHub. If you later change the assignment on MediaHub, ESPuino
   doesn't automatically notice on its own the next time the card is placed; you trigger that
   deliberately with **"Force Refresh"** (more on that below).

!!! note "What's centralized – and what isn't"
    MediaHub doesn't take **placing the cards** off your hands: you still need to place each card
    **once per device** and point it at MediaHub there (step 2 above). The reason: otherwise
    MediaHub itself would need its own RFID reader just to know the card's ID at all. What's
    centralized is only the **actual link to the content** – i.e. which files or stream and which
    playback mode belong to a card. You maintain that assignment once on MediaHub, and every device
    pulls it from there.

## Setting up the MediaHub server

For the server, you need a machine with **Docker** and the **Compose plugin** – a Raspberry Pi is
entirely sufficient.

```bash
git clone https://github.com/biologist79/ESPuino-Mediahub
cd ESPuino-Mediahub
cp env-example .env       # your own settings go into .env
mkdir -p data
chown -R 33:33 data
docker compose up -d --build
```

The trick here: your personal settings live in the `.env` file, not in the shipped files like
`docker-compose.yml`. Edit only the `.env` – that has a practical reason: a later update via
`git pull` stays **conflict-free** that way.

### The `.env` file

| Variable | Default | Meaning |
| --- | --- | --- |
| `MEDIAHUB_PORT` | `8080` | Port MediaHub is reachable on. Pick a different one if it's already taken. |
| `MEDIAHUB_DATA` | `./data` | Storage location for the MediaHub database (`db.json`). The folder needs write access. |
| `MEDIAHUB_MEDIA` | `./media` | Path to your existing media collection. Mounted **read-only** – MediaHub never creates or changes anything in it. |
| `MEDIAHUB_UID` / `MEDIAHUB_GID` | `33` / `33` | User/group ID the container runs as (default: `www-data`). If you change these, adjust the `chown` commands accordingly. |
| `TZ` | `Europe/Berlin` | The container's timezone, used for timestamps such as "last seen". |

!!! tip "Files visible but not readable?"
    Directory listing and file reading are two separate Unix permissions: a track can show up in
    the file tree, yet still fail with "permission denied" when assigned, if the file itself isn't
    readable by the MediaHub UID. Either `chmod -R o+rX /path/to/your/library` fixes this, or set
    `MEDIAHUB_UID`/`MEDIAHUB_GID` in `.env` to the UID/GID that already owns your library
    (`id -u` / `id -g`).

After starting it, check with `docker compose ps` whether the container is running, and open
MediaHub in your browser at `http://<your-ip>:8080`.

!!! warning "HTTPS isn't recommended"
    If you really need encryption, put a reverse proxy in front (Traefik, for instance). For the
    connection **between ESPuino and MediaHub**, though, HTTPS is a bad idea: it costs the ESP32's
    already-tight memory and noticeably lowers throughput – unencrypted gets you roughly
    650–700 KB/s, encrypted considerably less.

## Updating

```bash
git pull
docker compose up -d --build
```

`git pull` stays conflict-free because your settings live in `.env` (which Git ignores), not in the
tracked files. The `data` folder – and with it all your configuration – stays untouched. After an
update, still take a look at `env-example`: new options show up there first and need to be copied
into your own `.env` manually if you want them. `--build` isn't optional here – without it, Compose
keeps using the existing image and simply restarts the old version.

!!! note "Don't edit docker-compose.yml directly"
    Custom changes to `docker-compose.yml` will cause conflicts on every `git pull`. If you need
    extensions that can't be expressed via `.env`, create your own
    `docker-compose.override.yml` instead.

Depending on what changed about the interplay with ESPuino, a
[firmware update](../firmware/aktualisieren.md) on the devices themselves may also make sense.

## Backing up

The Docker container itself is disposable – it can be rebuilt at any time. What matters is only the
`data` folder: without its contents (the `db.json` database file), all MediaHub configuration,
registered ESPuinos, and card assignments are lost. So back up this folder regularly, ideally
somewhere outside the server itself.

!!! warning "Don't edit the database by hand"
    `db.json` shouldn't be edited manually. If you still need to work on it directly, stop the
    container first with `docker compose stop`.

## MediaHub in the ESPuino web interface

On the ESPuino itself, MediaHub concerns you in two places: the
[MediaHub tab](../bedienung/webinterface.md#tab-mediahub), for registering servers, and the
[RFID tab](../bedienung/webinterface.md#tab-rfid), for actually assigning a card to a server.

![Card assignment in the ESPuino web interface with the "MediaHub" playback mode and media server selection; the path is composed automatically from the server's address and protocol](../assets/MediahubRfidZuweisung.png)

When you choose the **MediaHub** playback mode while teaching a card, another dropdown appears below
it: **media server**, listing all registered servers. The "file, directory, or URL" field fills in
automatically – as a combination of the `mediahub://` prefix and the server address, e.g.
`mediahub://http://nas2:8090`. You don't enter this yourself; it's purely internal bookkeeping, so
ESPuino knows which server to contact the next time the card is placed.

## The MediaHub web interface

The MediaHub server's own web interface is organized into five areas: **ESPuinos**, **cards &
assignments**, **new cards** (a filter for still-unassigned cards), **media**, and **settings** –
all reachable via the navigation at the top.

### Devices

![The devices overview in MediaHub: registered ESPuinos with device ID, editable alias, IP address, timestamps, and last card](../assets/MediahubGeraete.png)

Here MediaHub lists all the ESPuinos that have already contacted it – recognized by the device ID
from the manifest request. For each device, you see its IP address, when it was last and first
seen, which card was placed most recently, and how many cards are already assigned to this device.
The default display name is the technical device ID; the text field next to it lets you assign an
**alias** instead, like "Kid1", which then shows up everywhere else in the interface.

### Cards & assignments

![The cards & assignments page in MediaHub with a pending, not-yet-assigned card](../assets/MediahubKartenWartend.png)

This page lists every card known to MediaHub – assigned ones play on the next tap, pending ones
don't yet. The filters at the top let you narrow things down to a specific ESPuino device, show
unassigned cards with **"pending only"**, or trigger a fresh download for every card at once with
**"Force Refresh (all)"**. If you already know the twelve-digit card ID (found in the ESPuino web
interface itself once you place the card there), you can also add a card manually without placing
it first.

![The cards & assignments list in MediaHub with an already-assigned card and the actions Edit, Force Refresh, Manifest, Duplicate, and Delete](../assets/MediahubKartenListe.png)

Once a card is assigned, five actions are available per row:

| Action | Effect |
| --- | --- |
| **Edit** | Changes the assignment afterward. If the data has already been transferred to the ESPuino, a "Force Refresh" is needed afterward so the change actually arrives. |
| **Force Refresh** | Forces a fresh download even though the ESPuino has already loaded the data once – the usual way to roll out a change. |
| **Manifest** | Shows the download file the ESPuino gets for this card. |
| **Duplicate** | Copies the assignment, handy when several ESPuinos should teach the same card with the same content. |
| **Delete** | Removes the assignment (mind the delete setting, see below). |

#### The assignment form

![The assignment form in MediaHub: name, content type, playback mode, and a folder tree of the mounted media library](../assets/MediahubZuweisungsformular.png)

When assigning, you fill in the following fields:

- **Name** – for your own orientation only, shows up in the list and in logs, but has no function
  for playback.
- **Content type** – either **audio files** from your library, or a **web radio** stream (MediaHub
  doesn't support a local `.m3u` list).
- **Playback mode** – the same list as in the ESPuino web interface (see
  [chapter 8 → playback modes](../bedienung/webinterface.md#abspielmodi)).
- **Media library** – a folder tree of your collection mounted via `MEDIAHUB_MEDIA`. "Use folder"
  adopts an entire folder for modes like "all titles of a folder".

!!! tip "Individual files instead of a whole folder, too"
    For folder-based modes such as "all titles of a folder (sorted)", you don't have to adopt the
    entire folder: you can also **check individual files** in the tree – only those get transferred,
    not the rest of the folder. Handy when a card should only cover a selection from a larger
    collection.

    ![Several individually checked files within a folder in MediaHub's assignment form](../assets/MediahubMehrereDateien.png)

### Media

![The media overview in MediaHub with storage usage per card](../assets/MediahubMedien.png)

This page shows how many files and how much storage belong to each card. There's deliberately no
dedicated upload area – uploading doesn't happen on this page, but directly during card assignment,
by picking files from your existing library.

### Settings

![The settings page in MediaHub: delete behavior (lazy/secure delete), recursion depth, and an optional hub password](../assets/MediahubEinstellungen.png)

Here you set how MediaHub behaves when deleting a card assignment, and how deep it looks into
subfolders for recursive playback modes:

- **Delete behavior** – **lazy delete** (default) only removes the entry on MediaHub; the card keeps
  playing unchanged on the ESPuino from its local cache, even offline, and isn't removed there.
  **Secure delete**, on the other hand, first calls the delete function on the ESPuino itself and
  only removes the MediaHub entry once the device has confirmed the deletion – for that, the
  ESPuino needs to be reachable at that moment.
- **Recursion depth** (default: 3) – sets how many subfolder levels recursive playback modes like
  "audiobook, recursive" or "all titles, recursive" include when downloading. Non-recursive modes
  always use only the chosen folder itself, regardless of this setting. Don't set the value
  unnecessarily high – otherwise a single assignment can unintentionally pull in a lot of data.
- **Hub password** (optional) – protects only MediaHub's own **web interface**. The API that the
  ESPuinos talk to stays reachable regardless, since devices can't log in.

## Further reading

- [ESPuino-Mediahub on GitHub](https://github.com/biologist79/ESPuino-Mediahub) – source code and
  technical specification.
- [Forum thread #4607](https://forum.espuino.de/t/espuino-mediahub/4607) – introduction and
  discussion (German-language).
