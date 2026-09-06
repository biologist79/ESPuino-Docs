# 2 · Quickstart: vom Karton zum ersten Sound

Dieses Kapitel ist die Abkürzung für Ungeduldige. Es zeigt dir in wenigen Schritten den ganzen Weg
vom ausgepackten Gerät bis zum ersten Ton – ohne jede Erklärung dazwischen. Wenn du lieber genau
verstehen möchtest, *warum* an welcher Stelle was passiert, überspring dieses Kapitel und lies gleich
das ausführliche [Kapitel 7 · Erststart](../inbetriebnahme/erststart.md); dort ist jeder Schritt in
Ruhe erklärt.

!!! tip "Voraussetzung"
    Bei der [**Complete**](../hardware/complete.md) ist die Firmware ab Werk installiert – du musst also nichts flashen.
    (Selbstbauten mit abweichender Hardware müssen ihre Firmware zuerst selbst kompilieren, siehe
    [Kapitel 13](../firmware/aktualisieren.md).)

So kommst du zum ersten Sound:

1. **Einschalten.** Beim ersten Start spannt ESPuino ein eigenes WLAN namens `ESPuino` auf; vier
   grüne LEDs signalisieren diesen Einrichtungsmodus.
2. **Mit diesem WLAN verbinden** und im Browser `http://192.168.4.1` öffnen. Auf der Einrichtungsseite
   trägst du dein eigenes WLAN samt Passwort ein und vergibst einen Hostnamen.
3. **Nach dem Neustart** erreichst du das Webinterface unter `http://espuino.local` (oder der
   IP-Adresse). Vier kreisende weiße LEDs zeigen: Verbindung steht.
4. **Inhalte auf die SD-Karte bringen** (Hörspiele, Hörbücher, Musik) – für den Anfang am schnellsten
   direkt am Computer (die Karte muss FAT32 sein). Details in [Kapitel 10](../inhalte/verwalten.md).
5. **Erste Karte anlernen:** im Tab RFID eine noch unbekannte Karte auflegen (ihre Nummer erscheint
   automatisch), im Dateibrowser Ordner oder Datei wählen, Abspielmodus festlegen und speichern.
6. **Karte auflegen – Musik läuft.** 🎉

Das war der Schnelldurchlauf. Von hier aus lohnt sich als Nächstes ein Blick in
[Kapitel 8 · Das Webinterface](../bedienung/webinterface.md), das Herzstück der Konfiguration.
