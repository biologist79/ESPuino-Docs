# 9 · Mehrere ESPuinos zentral verwalten: MediaHub

MediaHub ist eine **optionale** Möglichkeit, die RFID-Kartenzuweisungen **zentral** zu verwalten –
statt jedes Gerät einzeln über SD-Karte und NVS zu konfigurieren.

!!! info "Detail-Dokumentation"
    Die vollständige Doku (Setup, Betrieb) lebt im
    [MediaHub-Repo](https://github.com/biologist79/ESPuino-Mediahub). Ausführliche Diskussion:
    [Forum #4607](https://forum.espuino.de/t/espuino-mediahub/4607). Dieses Kapitel gibt nur
    Konzept und Einstieg.

## Konzept & wann es sich lohnt

MediaHub ist ein kleiner, selbst gehosteter Server (Docker-Container im eigenen Netz), der die
Zuweisungen hält. Sinnvoll, sobald **mehrere ESPuinos** im Haushalt betrieben werden und man
Karten nicht auf jedem Gerät separat pflegen möchte.

## MediaHub-Server aufsetzen

Kurz gefasst (Details im MediaHub-Repo):

```bash
cp env-example .env       # eigene Einstellungen in .env, nicht in der compose-Datei
mkdir -p data
chown -R 33:33 data
docker compose up -d --build
```

Aktualisieren bleibt konfliktfrei, weil die eigenen Einstellungen in `.env` liegen:

```bash
git pull
docker compose up -d --build
```

## Karten zentral zuweisen

Am ESPuino wird im Tab RFID der/die MediaHub-Server registriert. Eine Karte mit Playmode
**MediaHub** holt beim Auflegen ihr Manifest vom Server, lädt die referenzierten Dateien beim
ersten Mal auf die SD-Karte und hält sie danach synchron (Force-Refresh, Prüfsummen). Auch
Webradio/Webstreams sind möglich.

## Verweis

- [ESPuino-Mediahub (GitHub)](https://github.com/biologist79/ESPuino-Mediahub)
- [Forum-Thread #4607](https://forum.espuino.de/t/espuino-mediahub/4607)
