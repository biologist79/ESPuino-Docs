# 5 · Erststart

Diese Anleitung führt vom ersten Einschalten bis zum ersten Ton. Annahme: die Firmware ist bereits
installiert (bei der Complete ab Werk).

## Access-Point-Modus

Beim allerersten Start kennt ESPuino noch keine WLAN-Zugangsdaten und spannt deshalb ein **eigenes
WLAN** auf (Standard-Name **`ESPuino`**).

1. Verbinde deinen Computer mit diesem WLAN. ESPuino weist dir eine IP-Adresse zu.
2. Öffne im Browser **`http://192.168.4.1`** – die Einrichtungsseite erscheint.

!!! tip "Am Handy?"
    Manche Smartphones wollen die Seite nicht öffnen, weil sie merken, dass über dieses WLAN kein
    Internet erreichbar ist. Dann am einfachsten einen Computer verwenden oder die
    „trotzdem verbinden"-Meldung des Handys bestätigen.

## WLAN einrichten

Auf der Einrichtungsseite:

1. **WLAN-Namen** aus der Liste wählen.
2. **Passwort** eintragen.
3. **Hostname** vergeben (z. B. `espuino`) – darüber ist ESPuino später bequem erreichbar.
4. Speichern. Nach einem Neustart verbindet sich ESPuino mit deinem WLAN.

### Statusanzeige über die Neopixel

- **Vier zirkulierende weiße LEDs** → WLAN-Verbindung steht, Gerät ist bereit.
- **Grüne LEDs** → Verbindungsfehler. Neustarten, näher an den Router gehen oder die Zugangsdaten
  erneut eingeben.

!!! note "Erster Start dauert etwas"
    Beim ersten Start werden diverse Werte initialisiert. In der seriellen Konsole können dabei
    scheinbare Fehler auftauchen, die beim zweiten Start verschwunden sind – kein Grund zur Sorge.

## Webinterface erreichen

Danach erreichst du das Webinterface über die **IP-Adresse** oder – bei aktivem mDNS (Standard) –
über den **Hostnamen**:

- **`http://espuino.local`** (bzw. dein Hostname)
- FritzBox-Nutzer zusätzlich: **`http://espuino.fritz.box`**

!!! warning "Immer http, nie https"
    `https` wird **nicht** unterstützt – die Adresse muss mit `http://` beginnen.

### Statische IP (optional)

Wer eine feste IP will, kann Adresse, Netzmaske, Gateway und DNS pro Netzwerk hinterlegen (Tab
WLAN).

!!! warning
    Passt die Konfiguration nicht zum Netz, ist ESPuino per WLAN unter Umständen **nicht mehr
    erreichbar**. Nur nutzen, wenn du weißt, was du tust.

## Musik auf die SD-Karte

Die SD-Karte muss **FAT32**-formatiert sein (nicht exFAT). Dateien und Ordner lassen sich direkt im
Webinterface hochladen (Tab RFID → Dateien), die Geschwindigkeit ist aber begrenzt:

- SD-MMC-Modus: bis zu ~650 kiB/s
- SPI-Modus: entsprechend weniger

!!! tip "Grundfüllung am Computer"
    Für die erste, größere Menge Musik lohnt es sich, die SD-Karte direkt am Computer zu befüllen.
    Für Nachschub unterwegs ist der Web-Upload (oder FTP) bequem. Mehr:
    [Inhalte verwalten](../inhalte/verwalten.md).

## Erste RFID-Karte zuweisen

1. Eine (noch unbekannte) Karte auf den Leser legen.
2. Die Neopixel quittieren mit kurzem **roten** Aufleuchten.
3. Die 12-stellige RFID-ID wird automatisch ins Eingabefeld übernommen.
4. Im Dateibrowser eine **Datei oder einen Ordner** auswählen.
5. **Abspielmodus** wählen (siehe [Playmodi](../bedienung/webinterface.md#abspielmodi)).
6. **Zuweisung speichern** – die Karte ist einsatzbereit. 🎉

!!! tip "Ohne Karte testen"
    Über einen Rechtsklick (bzw. langes Drücken) im Dateibrowser lässt sich eine Datei oder ein
    Ordner auch direkt abspielen, ohne eine Karte aufzulegen.

## Nützlich für den Anfang

- **Lautstärke begrenzen:** Im Tab Allgemein lassen sich Maximal-Lautstärken (0–21) getrennt für
  Lautsprecher und Kopfhörer festlegen – praktisch, damit es nie zu laut wird.
- **FTP bei Bedarf:** Der FTP-Dienst muss nach jedem Neustart erst aktiviert werden (am Gerät
  **Pause/Play + Nächster Titel** gleichzeitig, kurzes grünes Aufleuchten – oder im Tab FTP). Das
  spart RAM, wenn FTP nicht gebraucht wird (u. a. gut fürs Webradio).

Alle Bereiche im Detail: [Kapitel 6 · Das Webinterface](../bedienung/webinterface.md).
