# 9 · Bedienung am Gerät

Das Webinterface ist zum Einrichten da – im Alltag bedienst du deinen ESPuino aber am Gerät selbst:
mit Karten, Tasten, dem Drehregler und mit einem Blick auf den LED-Ring. Dieses Kapitel erklärt, wie
diese Bedienelemente zusammenspielen und wie du die vielen Zustände deuten kannst, die dir der ESPuino
über die Neopixel mitteilt.

## Betriebsmodi { #betriebsmodi }

ESPuino kennt drei grundsätzliche Betriebsmodi. Im **Normalmodus** spielt er wie gewohnt Inhalte von
der SD-Karte. Im Modus **Bluetooth-Quelle** sendet er den Ton an ein Bluetooth-Gerät, etwa an einen
Kopfhörer. Und als **Bluetooth-Senke** wird ESPuino selbst zum Lautsprecher, auf den du zum Beispiel
vom Handy streamst. Zwischen den Modi wechselst du über Modifikationskarten oder das Webinterface.

!!! note "Bluetooth und WLAN"
    Bluetooth und WLAN laufen bei ESPuino **parallel**. Sei dir aber bewusst, dass der Speicher dabei
    knapp wird und dieser Parallelbetrieb wenig getestet ist.

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

## Modifikationskarten { #modifikationskarten }

Nicht jede Karte muss Inhalte starten – eine Karte kann auch eine **Funktion** auslösen, etwa einen
Schlaftimer setzen, die Tasten sperren oder das Licht umschalten. Diese „Modifikationskarten" sind ein
mächtiges Werkzeug, gerade für den Alltag mit Kindern. Den vollständigen Katalog findest du beim
Kartenanlernen im [Webinterface](webinterface.md#modifikationskarten-alle-optionen); die technischen
IDs listet der [Anhang](../referenz/anhang.md#modifikationskarten).

## Tasten und Tastenkombinationen { #tasten-und-tastenkombinationen }

Die folgende Belegung ist der **Auslieferungszustand** – im Webinterface (Stichwort „dynamisches
Button-Layout") kannst du sie komplett anpassen. Auf der [Complete](../hardware/complete.md) sind die Tasten physisch so
zugeordnet: Button 0 ist Next, Button 1 ist Previous, Button 2 ist Play/Pause, Button 3 der Taster im
Drehencoder, und Button 4 und 5 sind optionale, frei belegbare Tasten. Diese Nummern sind fest und
lassen sich nicht ändern; sie spielen aber ohnehin nur für Programmierer eine Rolle.

Ein **kurzer** und ein **langer** Druck lösen jeweils unterschiedliche Aktionen aus:

| Taste | Kurzer Druck | Langer Druck |
| --- | --- | --- |
| 0 · Next | Nächster Titel | Letzter Titel |
| 1 · Previous | Voriger Titel | Erster Titel |
| 2 · Play/Pause | Play/Pause | Play/Pause |
| 3 · Encoder-Taster | Batteriespannung messen | Deep-Sleep |
| 4 (optional) | Sprung zurück (n Sekunden) | Lautstärke + |
| 5 (optional) | Sprung vor (n Sekunden) | Lautstärke − |

Wie weit die beiden Sprung-Tasten springen, legst du selbst fest: Ab Werk sind es **30 Sekunden** je
Tastendruck, änderbar im Webinterface
([Kapitel 8 → Drehencoder & Taster](webinterface.md#drehencoder-taster)).

Dazu kommt eine besonders praktische Geste: **einen Button halten und gleichzeitig am Drehregler
drehen.** Solange du die Taste hältst, führt das Drehen deren Sonderaktion aus. Standardmäßig steuert
das Halten von Next ein Vor- und Zurückspulen im Titel, das Halten von Play/Pause die LED-Helligkeit.

Fürs Spulen per Drehregler gibt es dabei **zwei Varianten**, zwischen denen du dich entscheidest –
zugewiesen wird das im Webinterface ([Kapitel 8 → Drehencoder & Taster](webinterface.md#drehencoder-taster)):

| Variante | Was passiert | Ab Werk |
| --- | --- | --- |
| **Direktes Spulen** | Jede Rasterung springt **sofort** um eine feste Zeit vor oder zurück – ohne Anzeige, ohne Wartezeit. | ✔ auf Next gelegt |
| **Positionsvorschau** | Die Wiedergabe läuft zunächst weiter, nur ein Cursor wandert zum Ziel; gesprungen wird erst am Ende. | – musst du selbst zuweisen |

Die **Positionsvorschau** ist die komfortablere der beiden, du musst sie aber bewusst zuweisen. Ist sie
aktiv, färbt sich der LED-Ring **gelb**, sobald du die Taste gedrückt hältst – noch bevor du überhaupt
drehst. Beim Drehen wandert dann eine **blaue** Markierung (der Cursor) an die Stelle, zu der gesprungen
würde (hast du nur eine einzelne LED, leuchtet sie währenddessen einfach blau). Erst wenn du die Taste
loslässt oder eine Weile nicht mehr drehst – standardmäßig rund zwei Sekunden –, springt die Wiedergabe
dorthin. So triffst du eine Stelle genau, statt dich blind vor- und zurückzutasten.

Beim **direkten Spulen** passiert nichts dergleichen: Die LEDs zeigen weiterhin nur den normalen
Fortschritt, und jede Rasterung springt unmittelbar. Das ist gröber – eine schnelle Drehung sind viele
Rasterungen auf einmal –, funktioniert dafür aber auch auf einem ESPuino ganz ohne Neopixel, wo eine
Vorschau nichts anzuzeigen hätte.

Und schließlich lassen sich Aktionen auf **gleichzeitig gedrückte Tastenpaare** legen. Ab Werk starten
Next und Play/Pause zusammen den FTP-Server, Previous und Play/Pause lassen die IP-Adresse ansagen.

!!! note "WLAN-Umschalten ist bewusst deaktiviert"
    Die Kombination Next + Previous würde WLAN umschalten – sie ist ab Werk aber **abgeschaltet**,
    damit Kinder das WLAN nicht versehentlich lahmlegen.

## Der Drehencoder

Der Drehregler steuert im Normalfall die Lautstärke: nach rechts lauter, nach links leiser. Ist das
bei dir vertauscht, musst du nichts umlöten – du kehrst die Drehrichtung einfach im Webinterface um.
Neben dem reinen Drehen kann der Encoder aber mehr: die schon erwähnte „halten und drehen"-Geste, mit
der sich unter anderem im laufenden Titel spulen lässt – wahlweise direkt oder über die oben
beschriebene Positionsvorschau.

## Die Neopixel als Anzeige lesen

Der LED-Ring ist ESPuinos Sprache – er teilt dir mit einem Blick mit, was gerade passiert. Die Anzahl
der LEDs, der Farbverlauf und die Laufrichtung lassen sich im Webinterface einstellen; die folgenden
Farben sind die Standardwerte.

**Beim Booten**

| Situation | LED-Anzeige |
| --- | --- |
| Bootvorgang | Die halbe LED-Zahl kreist in **Orange**. Danach folgt der Leerlauf – oder rotes Blinken bei einem SD-Problem. |

**Im Status / Leerlauf**

| Situation | LED-Anzeige |
| --- | --- |
| WLAN verbunden | Vier langsam kreisende LEDs in **Weiß**. |
| Keine Verbindung | Vier langsam kreisende LEDs in **Grün**. |
| WLAN wird gesucht | Vier langsam kreisende LEDs in **Orange**. |
| Bluetooth aktiv | Vier kreisende LEDs in **Blau**. |
| Playlist wird erstellt | Vier LEDs drehen schnell in **Violett**. |
| Aktion akzeptiert | Kurzes **grünes** Aufblinken aller LEDs. |
| Aktion abgelehnt | Kurzes **rotes** Aufblinken aller LEDs. |
| Ausschalten (Taste halten) | Ein **roter** Kreis wächst, solange du die Taste hältst. |
| Tasten gesperrt | Die Fortschritts-LEDs färben sich **rot**. |

*Die kreisenden Verbindungs-LEDs (weiß/grün/orange/blau) siehst du nur im **Leerlauf**, also wenn
ESPuino gerade nichts abspielt. Sobald Wiedergabe läuft, zeigt der Ring stattdessen den Titelfortschritt
(siehe unten).*

**Während der Wiedergabe**

| Situation | LED-Anzeige |
| --- | --- |
| Titelfortschritt | Farbverlauf (standardmäßig grün→rot) als Zahl leuchtender LEDs. |
| Playlist-Fortschritt | Kurz zu Titelbeginn fächern **blaue** LEDs auf. |
| Webstream | Zwei sehr langsam kreisende LEDs in wechselnden Regenbogenfarben. |
| Pause | Vier **orange** LEDs. |
| Lautstärke ändern | Grün→roter Balken. |
| IP-Ansage | Rotierende **gelbe** LEDs. |

**Bei Batteriemessung & Datenübertragung**

| Situation | LED-Anzeige |
| --- | --- |
| Unterspannung | Dreimal kurzes **rotes** Blinken. |
| Ladezustand abfragen | Kurzer Druck auf den Encoder-Taster zeigt ihn als LED-Balken. |
| Download / Firmware-Update | Der Fortschritt läuft in **Blau**. |

Mehr dazu im
[Forum #86](https://forum.espuino.de/t/was-zeigt-der-neopixel-des-espuino-alles-an/86).

## Kopfhörer und Lautstärke-Profile { #kopfhorer-detection-lautstarke-profile }

ESPuino kann erkennen, ob ein Kopfhörer eingesteckt ist, und dafür ein eigenes Lautstärke-Maximum
verwenden – praktisch, weil Kopfhörer bei gleicher Einstellung deutlich lauter wirken als ein
Lautsprecher.

!!! tip "Empfehlung für Kopfhörer"
    Für den Kopfhörerbetrieb ist die kabelgebundene **Kopfhörerplatine** der zuverlässige Weg und im
    Zweifel die Empfehlung. Bluetooth-Kopfhörer (über den Modus Bluetooth-Quelle) funktionieren zwar,
    sind aber weniger zuverlässig – es wurden vereinzelt Fehler berichtet.
