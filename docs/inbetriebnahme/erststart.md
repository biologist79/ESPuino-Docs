# 5 · Erststart

!!! note "Status dieser Seite"
    Gerüst – aus dem Forum zu migrieren, mit Screenshots.

## Einschalten & Access-Point-Modus

Beim ersten Start (noch kein WLAN hinterlegt) öffnet ESPuino einen eigenen WLAN-Access-Point.

## WLAN konfigurieren

Mit dem AP verbinden, eigenes WLAN eintragen. Die Zugangsdaten werden vor dem Übernehmen **live
getestet** – kein „speichern → neustarten → hoffen" mehr.

## Webinterface erreichen, Hostname setzen

Nach dem Verbinden ist ESPuino unter `http://ESPuino.local` (bzw. der IP) erreichbar. Hostname im
Webinterface anpassen.

## RFID-Reader: Auto-Erkennung & Statusprüfung

RC522/PN5180 werden automatisch erkannt. *TODO: wo der erkannte Reader im Webinterface angezeigt
wird / Statusprüfung.*

## Erste RFID-Karte zuweisen, erster Sound

Im Tab RFID eine Karte auflegen, Ordner/Datei + [Playmode](../referenz/anhang.md#playmodi) wählen,
speichern – fertig.
