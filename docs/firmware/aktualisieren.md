# 12 · Firmware aktualisieren

Die Firmware ist die Software, die auf deinem ESPuino läuft. Sie wird laufend weiterentwickelt –
Fehler werden behoben, neue Funktionen kommen dazu. Von Zeit zu Zeit lohnt sich deshalb ein Update.
Dieses Kapitel zeigt dir die Wege dorthin, von „ganz bequem" bis „volle Kontrolle".

Es gibt im Wesentlichen drei Routen, und für die allermeisten sind die ersten beiden gemeint: das
**Firmware-Tool im Browser** (über eine USB-Leitung) und das **Update über das Webinterface** (über
WLAN). Nur wer eigene, abweichende Hardware betreibt oder besondere Compile-Zeit-Optionen braucht,
muss die dritte Route gehen und die Firmware **selbst kompilieren**.

## Wann sich ein Update überhaupt lohnt

Ein pauschales „immer aktualisieren" gibt es nicht. Läuft dein ESPuino zufrieden, gibt es keinen
Zwang. Ein Update lohnt sich, wenn dich ein konkreter Fehler stört, der behoben wurde, oder wenn
eine neue Funktion dazugekommen ist, die du haben möchtest. Was sich zwischen den Versionen getan
hat, hältst du am besten über den [Changelog](../referenz/anhang.md#changelog) nach.

## Der bequemste Weg: das Firmware-Tool im Browser

Für den **allerersten Flash** oder für eine **Wiederherstellung** – etwa, wenn das Webinterface
einmal nicht mehr erreichbar ist – ist das browserbasierte
**[ESPuino Firmware Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/)** die komfortabelste
Lösung. Du brauchst dafür keine Software zu installieren; alles läuft direkt im Browser.

<!-- Screenshot: Firmware-Tool im Browser -->

Das Tool kann Firmware flashen (nur die App oder komplett), den **Flash-Speicher löschen** (also das
Gerät auf einen sauberen Stand zurücksetzen), eine serielle Konsole zur Fehlersuche anzeigen und auch
eigene Firmware hochladen. Voraussetzung ist ein Browser mit Unterstützung für **Web Serial** (etwa
Chrome, Edge, Opera, Brave oder Vivaldi) und eine USB-Verbindung zum ESPuino.

Der Ablauf ist geradlinig: ESPuino per **USB** anschließen, im Tool Sprache und **Branch**
(master oder dev) wählen, die **Plattform** deines Boards auswählen, den gewünschten Firmware-Build
festlegen und die USB-Geschwindigkeit setzen (höchstens 460 800 Baud). Dann die passende Aktion
starten, bei der Nachfrage den seriellen Port auswählen und den Fortschritt beobachten.

!!! tip "Welchen Branch nehmen: master oder dev?"
    - **master** ist der stabile Zweig – gründlicher getestet, dafür manchmal etwas älter.
    - **dev** ist der Entwicklungszweig – immer am Puls der Zeit, aber weniger getestet.

    In der Praxis läuft `dev` erstaunlich rund; im Forum fiel augenzwinkernd schon der Satz „der dev
    ist der bessere master". Wenn du auf Nummer sicher gehen willst, nimm **master**; magst du die
    neuesten Funktionen und Fixes, ist **dev** einen Versuch wert. 🙂

!!! danger "Die richtige Plattform ist entscheidend"
    Wähle unbedingt exakt die Plattform, die zu deinem Board passt. Die **falsche Plattform** kann im
    schlimmsten Fall die Hardware beschädigen.

## Der Weg über WLAN: Update im Webinterface

Läuft dein ESPuino bereits und ist im WLAN, geht ein Update auch ganz ohne USB – direkt im
Webinterface, im **Tab Updates** ([Kapitel 7](../bedienung/webinterface.md#tab-updates)).

<!-- Screenshot: Tab Updates / GitHub-Update -->

Am elegantesten ist die Variante **Firmware von GitHub laden**
([Forum #4582](https://forum.espuino.de/t/firmware-update-direkt-von-github/4582)): Du wählst den
Branch (master oder dev), klickst auf „Nach Updates suchen" und bekommst die letzten Builds
aufgelistet, jeweils mit Datum und Commit-ID (fährst du mit der Maus über die ID, siehst du die
zugehörige Änderungsbeschreibung). Ein Klick auf „Installieren" genügt – die passende **Board-Variante
und Sprache werden automatisch gewählt**. Interessantes Detail am Rande: Der eigentliche Download
läuft im **Browser** (per JavaScript), nicht auf dem ESP32 selbst – auch das wieder eine Frage des
knappen Speichers. Den Flash-Fortschritt zeigt dir währenddessen der Neopixel-Ring in Blau.

Alternativ kannst du im selben Tab auch eine **Firmware-Datei** (`firmware.bin`) von Hand hochladen.

!!! info "Auto-Detect macht die Dateiwahl einfacher"
    Früher musstest du beim Update auf die RFID-Variante im Dateinamen achten. Seit Mai 2026 erkennt
    ESPuino den Reader (RC522 oder PN5180) automatisch – dieser Stolperstein ist also weggefallen.

## Der Weg für Fortgeschrittene: selbst kompilieren

Manchmal reicht die vorgefertigte Firmware nicht: Du betreibst eigene Hardware, oder du willst eine
Option setzen, die nur zur Compile-Zeit verfügbar ist (siehe [Kapitel 13](compile-zeit.md)). Dann
baust du dir die Firmware selbst. Der folgende Ablauf orientiert sich am
[Forum-Leitfaden #891](https://forum.espuino.de/t/espuino-in-platformio-anlegen-und-mit-git-aktuell-halten/891).

!!! info "pioarduino statt PlatformIO"
    Der Forum-Leitfaden spricht noch von **PlatformIO**. Inzwischen ist **pioarduino** die bessere
    Wahl: Zwischen Espressif (dem Hersteller des ESP32) und den Machern von PlatformIO gibt es einen
    Streit, weshalb pioarduino – ein Community-Fork – die Espressif-Toolchains aktueller unterstützt.
    ESPuinos `platformio.ini` ist bereits darauf ausgelegt. Überall, wo unten „pioarduino" steht,
    meint der Leitfaden also das, was früher PlatformIO war.

### Vorbereiten

Du brauchst drei Dinge: **Visual Studio Code**, die **pioarduino-Erweiterung** (installierst du in
VS Code über den Extensions-Marktplatz) und **Git**. Damit Git deine späteren Commits zuordnen kann,
hinterlegst du einmalig deine Identität:

```bash
git config --global user.name "Dein Name"
git config --global user.email "deine@mail.de"
```

### Repository holen und öffnen

Klone das ESPuino-Repository und öffne den Ordner in VS Code:

```bash
git clone https://github.com/biologist79/ESPuino
```

In VS Code geht das auch bequem über `Strg`+`Umschalt`+`P` → „Git: Clone". Anschließend wählst du
unten in der Statusleiste das **Environment** passend zu deinem Board – also `env:complete` oder
`env:lolin_d32_pro_sdmmc_pe` (mini4L).

### Eigene Einstellungen

Möchtest du Compile-Zeit-Optionen ändern, tust du das nicht direkt in den mitgelieferten Dateien,
sondern in einer eigenen `settings-override.h` (siehe [Kapitel 13](compile-zeit.md)). So überschreibt
ein späteres Update deine Anpassungen nicht.

### Bauen und flashen

In der pioarduino-Seitenleiste wählst du **„Upload and Monitor"** – das kompiliert die Firmware,
spielt sie über USB auf und öffnet gleich die serielle Konsole.

### Mit Git aktuell halten

Damit du Updates einspielen kannst, ohne dir deine eigenen Anpassungen zu zerschießen, arbeitest du
am besten auf einem **eigenen Branch** statt direkt auf `dev` oder `master`. Einmalig einrichten:

```bash
git checkout dev
git pull
git branch MeinGeraet
git checkout MeinGeraet
```

Deine Änderungen machst du nun auf `MeinGeraet`. Zum Aktualisieren holst du den neuen Stand von `dev`
und setzt deinen Branch per Rebase obendrauf:

```bash
git checkout dev
git pull
git checkout MeinGeraet
git rebase dev
```

Hast du nur kleine, unwichtige lokale Änderungen, tut es auch der einfachere Weg über `git stash`:

```bash
git stash      # eigene Änderungen zur Seite legen
git pull       # Update holen
git stash pop  # eigene Änderungen wieder anwenden
```

!!! tip "Nicht direkt auf dev oder master committen"
    Halte deine Anpassungen immer auf einem eigenen Branch. Committest du direkt auf `dev` oder
    `master`, gibt es beim nächsten `git pull` fast zwangsläufig Konflikte.

!!! info "Wofür es fertige Firmware gibt"
    Fertige Firmware wird automatisch für **drei** Targets gebaut – **`complete`**,
    **`lolin_d32_pro_sdmmc_pe`** (mini4L) und **`lolin_d32_pro`** –, jeweils für die Branches **dev**
    und **master** und in **drei Sprachen** (DE/EN/FR). Die aktuellen Produkte sind [Complete](../hardware/complete.md) und
    mini4L; der `lolin_d32_pro` ist ein älteres Board, für das es aber weiterhin Builds gibt. Für
    abweichende **Eigenbauten** gibt es dagegen nichts zum bloßen Aufspielen – die musst du selbst
    kompilieren. Und der **ESP32-S3 wird nicht unterstützt**, weil er kein klassisches Bluetooth
    beherrscht.
