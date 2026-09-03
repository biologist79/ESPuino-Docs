# 11 · Firmware aktualisieren

Die Firmware ist die Software, die auf deinem ESPuino läuft. Sie wird laufend weiterentwickelt –
Fehler werden behoben, neue Funktionen kommen dazu. Von Zeit zu Zeit lohnt sich deshalb ein Update.
Dieses Kapitel zeigt dir die Wege dorthin, von „ganz bequem" bis „volle Kontrolle".

Es gibt im Wesentlichen drei Routen, und für die allermeisten sind die ersten beiden gemeint: das
**Firmware-Tool im Browser** (über ein USB-Kabel) und das **Update über das Webinterface** (über
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

!!! danger "Die richtige Plattform ist entscheidend"
    Wähle unbedingt exakt die Plattform, die zu deinem Board passt. Die **falsche Plattform** kann im
    schlimmsten Fall die Hardware beschädigen.

## Der Weg über WLAN: Update im Webinterface

Läuft dein ESPuino bereits und ist im WLAN, geht ein Update auch ganz ohne Kabel – direkt im
Webinterface, im **Tab Updates** ([Kapitel 6](../bedienung/webinterface.md#tab-updates)).

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
Option setzen, die nur zur Compile-Zeit verfügbar ist (siehe [Kapitel 12](compile-zeit.md)). Dann
baust du dir die Firmware selbst. Dafür brauchst du **VS Code** mit der **pioarduino**-Erweiterung,
klonst das ESPuino-Repository und hältst es mit Git aktuell.

!!! warning "Nur zwei Boards werden unterstützt"
    Fertige Firmware wird **ausschließlich** für die Targets **`complete`** und
    **`lolin_d32_pro_sdmmc_pe`** (mini4L) automatisch gebaut. Weitere Einträge in der `platformio.ini`
    sind alt bzw. Legacy. Der **ESP32-S3 wird nicht unterstützt**, weil er kein klassisches Bluetooth
    beherrscht. Baust du also etwas Eigenes, führt kein Weg an dieser Route vorbei – fertige Firmware
    zum bloßen Aufspielen gibt es dafür nicht.
