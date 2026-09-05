# 8 · Bedienung am Gerät

Das Webinterface ist zum Einrichten da – im Alltag bedienst du deinen ESPuino aber am Gerät selbst:
mit Karten, Tasten, dem Drehregler und mit einem Blick auf den LED-Ring. Dieses Kapitel erklärt, wie
diese Bedienelemente zusammenspielen und wie du die vielen Zustände deuten kannst, die dir der ESPuino
über die Neopixel mitteilt.

## Betriebsmodi

ESPuino kennt drei grundsätzliche Betriebsmodi. Im **Normalmodus** spielt er wie gewohnt Inhalte von
der SD-Karte. Im Modus **Bluetooth-Quelle** sendet er den Ton an ein Bluetooth-Gerät, etwa an einen
Kopfhörer. Und als **Bluetooth-Senke** wird ESPuino selbst zum Lautsprecher, auf den du zum Beispiel
vom Handy streamst. Zwischen den Modi wechselst du über Modifikationskarten oder das Webinterface.

!!! note "Bluetooth und WLAN"
    Bluetooth und WLAN laufen bei ESPuino **parallel**. Sei dir aber bewusst, dass der Speicher dabei
    knapp wird und dieser Parallelbetrieb ungetestet ist – im Zweifel nutzt du nur eines von beiden.

## Abspielmodi

Der Abspielmodus einer Karte entscheidet, *wie* ihr Inhalt läuft: ob ein einzelner Titel, ein ganzer
Ordner sortiert oder zufällig, ein Hörbuch mit gemerkter Position und so weiter. Weil die Modi eng mit
der Kartenzuweisung zusammenhängen, sind sie dort ausführlich mit Symbol und Beschreibung aufgelistet:
[Webinterface → Abspielmodi](webinterface.md#abspielmodi). Die technischen IDs stehen im
[Anhang](../referenz/anhang.md#playmodi).

### Rekursive Modi und das Springen zwischen Ordnern

Eine besondere Erwähnung verdienen die **rekursiven** Abspielmodi. Sie beziehen nicht nur den
gewählten Ordner ein, sondern auch dessen **Unterordner** – sortiert, zufällig oder als Hörbuch mit
Positionsspeicherung. Wie tief ESPuino dabei in die Ordnerstruktur hineinschaut, bestimmt die
**Rekursionstiefe** (0 bis 4, Standard 2; einstellbar im Tab Allgemein → Wiedergabe).

Nur in diesen rekursiven Modi funktioniert außerdem das **Ordnerspringen**: Die Aktion „nächster
Ordner" springt zum ersten Titel des nächsten Ordners, „voriger Ordner" entsprechend zurück – jeweils
entlang der alphabetischen Reihenfolge. Beide Aktionen kannst du im Webinterface auf Taster legen.

!!! warning "Beim rekursiven Hörbuch aufpassen"
    Im rekursiven Hörbuch-Modus wird die Playlist bei jedem Laden neu erzeugt. Kommen nachträglich
    neue Ordner hinzu, kann sich die gemerkte Position dadurch verschieben.

## Modifikationskarten

Nicht jede Karte muss Inhalte starten – eine Karte kann auch eine **Funktion** auslösen, etwa einen
Schlaftimer setzen, die Tasten sperren oder das Licht umschalten. Diese „Modifikationskarten" sind ein
mächtiges Werkzeug, gerade für den Alltag mit Kindern. Den vollständigen Katalog findest du beim
Kartenanlernen im [Webinterface](webinterface.md#modifikationskarten-alle-optionen); die technischen
IDs listet der [Anhang](../referenz/anhang.md#modifikationskarten).

## Tasten und Tastenkombinationen

Die folgende Belegung ist der **Auslieferungszustand** – im Webinterface (Stichwort „dynamisches
Button-Layout") kannst du sie komplett anpassen. Auf der [Complete](../hardware/complete.md) sind die Tasten physisch so
zugeordnet: Button 0 ist Next, Button 1 ist Previous, Button 2 ist Play/Pause, Button 3 der Taster im
Drehencoder, und Button 4 und 5 sind optionale, frei belegbare Tasten.

Ein **kurzer** und ein **langer** Druck lösen jeweils unterschiedliche Aktionen aus:

| Taste | Kurzer Druck | Langer Druck |
| --- | --- | --- |
| 0 · Next | Nächster Titel | Letzter Titel |
| 1 · Previous | Voriger Titel | Erster Titel |
| 2 · Play/Pause | Play/Pause | Play/Pause |
| 3 · Encoder-Taster | Batteriespannung messen | Deep-Sleep |
| 4 (optional) | Seek zurück | Lautstärke + |
| 5 (optional) | Seek vor | Lautstärke − |

Dazu kommt eine besonders praktische Geste: **einen Button halten und gleichzeitig am Drehregler
drehen.** Solange du die Taste hältst, führt das Drehen deren Sonderaktion aus. Standardmäßig steuert
das Halten von Next ein Vor- und Zurückspulen im Titel, das Halten von Play/Pause die LED-Helligkeit.

Und schließlich lassen sich Aktionen auf **gleichzeitig gedrückte Tastenpaare** legen. Ab Werk starten
Next und Play/Pause zusammen den FTP-Server, Previous und Play/Pause lassen die IP-Adresse ansagen.

!!! note "WLAN-Umschalten ist bewusst deaktiviert"
    Die Kombination Next + Previous würde WLAN umschalten – sie ist ab Werk aber **abgeschaltet**,
    damit Kinder das WLAN nicht versehentlich lahmlegen.

## Der Drehencoder

Der Drehregler steuert im Normalfall die Lautstärke: nach rechts lauter, nach links leiser. Ist das
bei dir vertauscht, musst du nichts umlöten – du kehrst die Drehrichtung einfach im Webinterface um.
Neben dem reinen Drehen kann der Encoder aber mehr: die schon erwähnte „halten und drehen"-Geste sowie
eine **Seek-Vorschau**. Bei letzterer zeigt dir das Drehen zunächst die Zielposition per LED-Cursor an
und springt erst dann dorthin, wenn du loslässt oder kurz wartest – so triffst du eine Stelle genauer,
ohne blind hin- und herzuspulen.

## Die Neopixel als Anzeige lesen

Der LED-Ring ist ESPuinos Sprache – er teilt dir mit einem Blick mit, was gerade passiert. Die Anzahl
der LEDs, der Farbverlauf und die Laufrichtung lassen sich im Webinterface einstellen; die folgenden
Farben sind die Standardwerte.

**Beim Booten** zirkuliert die Hälfte der LEDs in **Orange**. Danach geht es entweder in den Leerlauf
über – oder es blinkt bei einem SD-Problem rot.

**Im Status/Leerlauf** verraten dir vier langsam kreisende LEDs den Verbindungszustand: **weiß** heißt
WLAN verbunden, **grün** keine Verbindung, **orange** WLAN wird gerade gesucht. Ist Bluetooth aktiv,
kreisen sie **blau**. Wird gerade eine Playlist erstellt, drehen sich vier LEDs schnell in **violett**.
Eine akzeptierte Aktion quittiert ESPuino mit einem kurzen **grünen** Aufblinken aller LEDs, eine
abgelehnte mit einem kurzen **roten**. Beim Ausschalten wächst ein **roter** Kreis, solange du die
Taste hältst, und sind die Tasten gesperrt, färben sich die Fortschritts-LEDs rot.

**Während der Wiedergabe** zeigt ein Farbverlauf (standardmäßig grün→rot) als LED-Anzahl den
**Titelfortschritt**; kurz zu Beginn jedes Titels fächern **blaue** LEDs den Playlist-Fortschritt auf.
Ein Webstream läuft als zwei sehr langsam kreisende LEDs in wechselnden Regenbogenfarben, eine Pause
als vier **orange** LEDs. Eine Lautstärkeänderung erscheint als grün→roter Balken, eine IP-Ansage als
rotierende **gelbe** LEDs.

**Bei aktivierter Batteriemessung** blinkt ESPuino bei Unterspannung dreimal kurz **rot**; ein kurzer
Druck auf den Encoder-Taster zeigt dir den Ladezustand als LED-Balken. Und wenn Daten übertragen
werden – ein MediaHub-Download oder ein Firmware-Update –, läuft der Fortschritt in **Blau**.

Die vollständige Aufstellung pflegt der Entwickler im
[Forum #86](https://forum.espuino.de/t/was-zeigt-der-neopixel-des-espuino-alles-an/86).

## Kopfhörer und Lautstärke-Profile { #kopfhorer-detection-lautstarke-profile }

ESPuino kann erkennen, ob ein Kopfhörer eingesteckt ist, und dafür ein eigenes Lautstärke-Maximum
verwenden – praktisch, weil Kopfhörer bei gleicher Einstellung deutlich lauter wirken als ein
Lautsprecher.

!!! tip "Empfehlung für Kopfhörer"
    Für den Kopfhörerbetrieb ist die kabelgebundene **Kopfhörerplatine** der zuverlässige Weg und im
    Zweifel die Empfehlung. Bluetooth-Kopfhörer (über den Modus Bluetooth-Quelle) funktionieren zwar,
    sind aber weniger zuverlässig – es wurden vereinzelt Fehler berichtet.
