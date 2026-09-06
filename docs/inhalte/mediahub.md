# 11 · Mehrere ESPuinos zentral verwalten: MediaHub

## Welches Problem MediaHub löst

Solange du einen einzigen ESPuino betreibst, ist alles einfach: Du legst deine Kartenzuordnungen im
Webinterface an, und sie liegen im Speicher genau dieses Geräts. Sobald aber mehrere ESPuinos im
Haushalt stehen – im Kinderzimmer, im Wohnzimmer, eines für unterwegs –, wird die Pflege mühsam. Jede
neue Karte müsstest du auf jedem Gerät einzeln anlernen, und die SD-Karten getrennt bestücken.

Genau hier setzt **MediaHub** an. MediaHub ist eine **optionale** Zusatzkomponente, mit der du die
Kartenzuordnungen **zentral** an einer Stelle verwaltest, statt auf jedem Gerät für sich. Wer nur
einen ESPuino hat, braucht MediaHub nicht – für alle anderen kann es die Verwaltung deutlich
entspannen.

!!! info "Wo die vollständige Anleitung liegt"
    Dieses Kapitel gibt dir das Konzept und den Einstieg. Die ausführliche Dokumentation zu Einrichtung
    und Betrieb wird direkt im [MediaHub-Repository](https://github.com/biologist79/ESPuino-Mediahub)
    gepflegt, und die ausführliche Diskussion läuft im
    [Forum-Thread #4607](https://forum.espuino.de/t/espuino-mediahub/4607).

## Wie es funktioniert

MediaHub ist ein kleiner, **selbst gehosteter Serverdienst**, der als Docker-Container in deinem
eigenen Netzwerk läuft – die Daten bleiben also bei dir zu Hause, nichts wandert in eine fremde Cloud.
Dieser Serverdienst hält die zentralen Kartenzuordnungen.

Am ESPuino selbst hinterlegst du dann im Webinterface, welche MediaHub-Server es gibt. Legst du eine
Karte auf, die für MediaHub konfiguriert ist, fragt der ESPuino beim Server nach, was zu dieser Karte
gehört, und lädt die benötigten Dateien beim ersten Mal auf seine SD-Karte herunter. Danach spielt er
lokal von der eigenen Karte.

Änderst du zentral etwas, geschieht die Aktualisierung **nicht von selbst**: Du stößt sie am MediaHub
mit **„Force Refresh"** an. Der ESPuino bemerkt die neue Fassung dann beim nächsten Auflegen, lädt die
geänderten Dateien nach und spielt anschließend den aktuellen Stand. Auch Webradio-Streams lassen sich
auf diesem Weg zuweisen.

!!! note "Was zentral ist – und was nicht"
    MediaHub nimmt dir das **Auflegen der Karten nicht** ab: Jede Karte musst du weiterhin **einmal pro
    Gerät** auflegen und dort auf MediaHub verweisen. Der Grund: Sonst bräuchtest du am MediaHub selbst
    einen eigenen RFID-Reader, um die ID der Karte überhaupt zu kennen. Zentral ist nur die
    **eigentliche Verknüpfung zum Inhalt** – also welche Dateien bzw. welcher Stream und welcher
    Abspielmodus zu einer Karte gehören. Diese Zuordnung pflegst du einmal am MediaHub, und alle Geräte
    ziehen sie von dort.

## Den MediaHub-Server einrichten

Der Server wird als Docker-Container gestartet. Die Kurzfassung sieht so aus (die vollständigen
Details stehen im MediaHub-Repository):

```bash
cp env-example .env       # eigene Einstellungen kommen in die .env
mkdir -p data
chown -R 33:33 data
docker compose up -d --build
```

Der Kniff dabei: Deine persönlichen Einstellungen liegen in der Datei `.env`, nicht in den
mitgelieferten Dateien. Das hat einen praktischen Grund – ein späteres Update bleibt dadurch
konfliktfrei:

```bash
git pull
docker compose up -d --build
```

## Karten zentral zuweisen

Im Tab RFID des ESPuino registrierst du deinen MediaHub-Server (oder mehrere davon). Eine Karte, die
du dem Modus MediaHub zuordnest, holt sich beim Auflegen ihr „Manifest" vom Server – also die
Information, was sie abspielen soll –, lädt die Dateien beim ersten Mal herunter und hält sie danach
per Prüfsumme aktuell.

## Weiterführend

- [ESPuino-Mediahub auf GitHub](https://github.com/biologist79/ESPuino-Mediahub) – die vollständige
  Dokumentation.
- [Forum-Thread #4607](https://forum.espuino.de/t/espuino-mediahub/4607) – Vorstellung und Diskussion.
