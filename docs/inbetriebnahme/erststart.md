# 6 · Erststart

Dein ESPuino ist zusammengebaut, mit Strom versorgt – per USB-Netzteil oder, falls verbaut, per
Akku – und die SD-Karte steckt. Jetzt soll zum ersten Mal Musik aus dem Lautsprecher kommen. Dieses Kapitel begleitet dich durch genau diesen
ersten Start: vom Einschalten über das Einrichten des WLANs bis zu dem Moment, in dem du die erste
Karte auflegst und ein Titel losspielt. Wir gehen die Schritte einzeln durch und erklären jeweils
auch, *warum* etwas passiert – dann kannst du im Zweifel selbst einschätzen, ob alles seine
Richtigkeit hat.

Eine Annahme vorweg: Auf deinem ESPuino ist bereits eine Firmware installiert. Bei der [**Complete**](../hardware/complete.md)
ist das ab Werk der Fall – du musst also nichts flashen und kannst direkt loslegen.

Hast du deinen ESPuino dagegen **selbst gebaut**, kommt zuerst die Firmware. Hier gibt es eine
Einschränkung, die du kennen solltest: Fertige, vorgebaute Firmware wird nur für die wenigen
Plattformen automatisch erzeugt, für die es fertige Builds gibt (Complete, mini4L und das ältere
`lolin_d32_pro`). Für abweichende Eigenbauten gibt es also **nichts zum bloßen Aufspielen** – du
musst dir mit **VS Code und pioarduino** selbst eine passende Firmware kompilieren. Wie das geht, steht in
[Kapitel 12 · Firmware aktualisieren](../firmware/aktualisieren.md); komm danach hierher zurück.

!!! note "Der allererste Start dauert einen Moment"
    Beim ersten Einschalten legt ESPuino intern eine Reihe von Grundeinstellungen an. In der
    seriellen Konsole können dabei Meldungen auftauchen, die wie Fehler aussehen – etwa dass ein
    Wert noch nicht gefunden wurde. Das ist normal: Diese Werte werden gerade erst erzeugt, und beim
    zweiten Start sind die Meldungen verschwunden. Lass dich davon also nicht beirren.

    Eine serielle Konsole hat allerdings nicht jeder – normalerweise bräuchtest du dafür eine
    Entwicklungsumgebung. Falls du trotzdem einmal mitlesen möchtest: Das
    [ESPuino-Firmware-Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/) bringt eine solche
    Konsole direkt im Browser mit.

## Der Access-Point-Modus: warum ESPuino zuerst ein eigenes WLAN aufspannt

Damit ESPuino dir Musik über das Netzwerk zugänglich machen und sich bequem konfigurieren lassen
kann, braucht er Zugang zu deinem WLAN. Beim allerersten Start kennt er dein WLAN aber noch gar
nicht. Aus diesem Henne-Ei-Problem hilft
sich ESPuino, indem er **selbst ein WLAN aufspannt**, in das du dich einklinken kannst, um ihm dann
dein „richtiges" WLAN mitzuteilen.

Dieses Einrichtungs-WLAN heißt standardmäßig **`ESPuino`** und ist zunächst offen, also ohne Passwort.
Es ist nur der Notnagel für die Ersteinrichtung und verschwindet wieder, sobald ESPuino in deinem
WLAN angemeldet ist. (Umbenennen und mit einem Passwort absichern kannst du es später im
[Tab WLAN](../bedienung/webinterface.md#tab-wlan) – dort steht auch, warum du diesen offenen
Access-Point nicht dauerhaft aktiv lassen solltest.) Geh also an deinem Computer oder Smartphone in
die WLAN-Auswahl und verbinde dich mit dem Netzwerk `ESPuino`.
Sobald die Verbindung steht, weist ESPuino deinem Gerät automatisch eine Adresse zu, und du kannst
die Einrichtungsseite im Browser aufrufen. Sie liegt unter der festen Adresse **`http://192.168.4.1`**.
Bei vielen Geräten öffnet sich diese Seite sogar von selbst (als sogenanntes „Captive Portal", das
du vielleicht von Hotel- oder Café-WLANs kennst); passiert das nicht, tippst du die Adresse einfach
von Hand in die Adresszeile.

!!! tip "Wenn das Smartphone zickt"
    Manche Smartphones merken, dass über dieses WLAN kein Internet erreichbar ist, und weigern sich
    stillschweigend, die Seite zu laden – oder wechseln sogar heimlich zurück ins Mobilfunknetz. In
    aller Regel erscheint dann eine kleine Rückfrage im Stil von „Dieses WLAN hat keinen
    Internetzugang – trotzdem verbunden bleiben?". Bestätige diese, dann klappt es. Am unkompliziertesten
    ist die Ersteinrichtung aber ohnehin an einem normalen Computer.

## WLAN einrichten

Auf der Einrichtungsseite hinterlegst du jetzt dein eigenes WLAN. Das sind drei kleine Schritte:

1. **Wähle deinen WLAN-Namen** aus der Liste der gefundenen Netzwerke aus. ESPuino zeigt dir an, was
   in Reichweite ist, damit du dich nicht vertippst.
2. **Trage das WLAN-Passwort ein.** Es wird auf dem ESPuino gespeichert, damit er sich künftig von
   allein verbindet.
3. **Vergib einen Hostnamen**, zum Beispiel `espuino`. Der Hostname ist der Name, unter dem dein
   ESPuino später im Netzwerk auftaucht – und, wie gleich noch wichtig wird, die bequemste Art, das
   Webinterface wiederzufinden. Hast du mehrere ESPuinos, gib jedem einen eigenen, sprechenden Namen
   (etwa `espuino-kinderzimmer`).

Sobald du speicherst, musst du nicht mehr auf gut Glück neu starten und hoffen. ESPuino probiert die
Zugangsdaten **gleich aus**, während die Einrichtungsseite geöffnet bleibt, und zeigt dir direkt
dort, wie es läuft – ob er sich gerade verbindet, ob es fehlgeschlagen ist oder ob die Verbindung
steht. Klappt es nicht, korrigierst du einfach die Eingabe, ohne von vorn beginnen zu müssen. Und sobald
ESPuino im WLAN ist, meldet dir auch der LED-Ring den Verbindungsstatus – wie du ihn liest, zeigt
der nächste Abschnitt.

### Die Neopixel als Statusanzeige lesen

Der LED-Ring (die „Neopixel") ist nicht nur Dekoration, sondern ESPuinos wichtigstes
Rückmelde-Instrument. Gerade jetzt beim Verbinden lohnt sich ein Blick darauf:

- **Vier langsam kreisende weiße LEDs** bedeuten: Die WLAN-Verbindung steht und ESPuino ist bereit.
  Das ist das Signal, auf das du wartest.
- **Grüne LEDs** heißen dagegen: Es besteht (noch) keine WLAN-Verbindung. Das ist beim Verbinden
  kurz normal; bleibt es aber dauerhaft grün, ist entweder die Verbindung nicht zustande gekommen
  oder es sind noch gar keine Zugangsdaten hinterlegt.

Wenn es bei Grün bleibt, ist das kein Grund zur Sorge – meist steckt eine der drei üblichen Ursachen
dahinter: ein Tippfehler im Passwort, zu große Entfernung zum Router, oder schlicht ein noch nicht
abgeschlossener Verbindungsversuch. Starte ESPuino testweise neu, geh näher an den Router, und gib
notfalls die Zugangsdaten noch einmal in Ruhe ein. Eine ausführlichere Fehlersuche zum Thema WLAN
findest du in [Kapitel 14 · Troubleshooting](../hilfe/troubleshooting.md#wlan-probleme).

## Das Webinterface öffnen

Sobald ESPuino im WLAN ist, verwaltest du ihn über das **Webinterface** – die Bedien- und
Konfigurationsoberfläche, die du einfach im Browser aufrufst. Es gibt zwei Wege dorthin.

Der komfortable Weg führt über den **Hostnamen**, den du eben vergeben hast. Ist die
mDNS-Funktion aktiv (das ist die Voreinstellung), erreichst du deinen ESPuino unter
**`http://espuino.local`** – beziehungsweise unter dem Namen, den du gewählt hast. Du musst dir also
keine IP-Adresse merken. Wer eine FritzBox betreibt, kann zusätzlich `http://espuino.fritz.box`
verwenden. Der zweite Weg ist die direkte Eingabe der **IP-Adresse**, die ESPuino von deinem Router
bekommen hat; die findest du zum Beispiel in der Geräteliste deines Routers.

!!! warning "Immer `http://`, niemals `https://`"
    ESPuino spricht bewusst nur unverschlüsseltes **HTTP**. Das hat einen handfesten Grund:
    Verschlüsselung (HTTPS/TLS) kostet einiges an Arbeitsspeicher, und davon hat der ESP32 ohnehin
    nicht viel im Überfluss – für ein Gerät im eigenen Heimnetz ist unverschlüsseltes HTTP daher der
    pragmatische Weg. Ruf die Adresse deshalb immer mit `http://` auf. Manche Browser ergänzen von
    sich aus ein `https://`; dann lädt die Seite nicht, und du musst das `http://` von Hand
    voranstellen.

### Kurzer Einschub: statische IP-Adresse

Standardmäßig bekommt ESPuino seine Adresse automatisch vom Router zugewiesen (per DHCP), und für
die allermeisten reicht das vollkommen. Wenn du möchtest, kannst du ihm stattdessen eine feste
IP-Adresse geben – die Einstellungen dafür findest du später im Tab WLAN. Das ist aber nichts, was
du für den Erststart brauchst.

!!! warning "Feste IP nur mit Bedacht"
    Eine falsch gesetzte statische IP-Konfiguration (Adresse, Netzmaske, Gateway, DNS, die nicht zu
    deinem Netz passen) kann dazu führen, dass ESPuino über WLAN gar nicht mehr erreichbar ist.
    Nutze diese Option nur, wenn du weißt, was du tust – im Zweifel bleib bei der automatischen
    Vergabe.

## Inhalte auf die SD-Karte bringen

ESPuino spielt seine Inhalte – ob Hörspiele, Hörbücher oder Musik – von der SD-Karte. Damit er sie
lesen kann, muss die Karte im Dateisystem **FAT32** formatiert sein – nicht exFAT. Karten über 32 GB
kommen ab Werk fast immer als exFAT, du musst sie also mit ziemlicher Sicherheit erst am Computer neu
als FAT32 formatieren. (Windows bietet FAT32 für so große Karten im Standard-Dialog oft gar nicht an;
dann hilft ein kleines Formatier-Tool.)

Um Dateien auf die Karte zu bekommen, hast du mehrere Möglichkeiten – und für den Einstieg ist die
Reihenfolge ziemlich klar:

- **Am Computer vorbefüllen.** Nimm die SD-Karte einmal heraus und bespiele sie direkt am Rechner.
  Das ist mit Abstand am schnellsten und für die erste, größere Grundausstattung auf jeden Fall der
  sinnvollste Weg.
- **Web-Upload.** Der bequeme Standardweg: Du lädst einzelne Dateien oder ganze Ordner direkt im
  Webinterface hoch (Tab RFID, Bereich Dateien). Der Web-Upload wurde optimiert und ist inzwischen
  **auch für größere Mengen der schnellste Weg** – bis zu etwa **650 kiB/s** (im SPI-Modus
  entsprechend weniger, den Complete und mini4L jedoch nicht verwenden).
- **FTP.** Eine Alternative über das Netzwerk – sie wird aber nur von wenigen genutzt und ist nicht
  auf Tempo optimiert; der Web-Upload ist heute in aller Regel schneller. Der Dienst muss zudem erst
  aktiviert werden (siehe unten sowie [Kapitel 7](../bedienung/webinterface.md#tab-ftp)). Sinnvoll
  vor allem, wenn du ohnehin mit einem FTP-Programm arbeitest.
- **MediaHub.** Betreibst du mehrere ESPuinos, verteilt MediaHub die Inhalte zentral über das
  Netzwerk (siehe [Kapitel 10](../inhalte/mediahub.md)).

Wie du deine Inhalte anschließend sinnvoll in Ordner strukturierst, damit die Abspielmodi später
genau das tun, was du erwartest, liest du in [Kapitel 9 · Inhalte verwalten](../inhalte/verwalten.md).

## Die erste Karte anlernen

Jetzt kommt der schönste Moment: Wir verknüpfen eine RFID-Karte mit Musik. „Anlernen" heißt das
deshalb, weil ESPuino sich merkt, *welche* Karte *welchen* Inhalt starten soll. Wichtig zu wissen –
und für manche überraschend: Auf die Karte selbst wird dabei **nichts** geschrieben. ESPuino liest
nur die eindeutige Nummer (die ID) der Karte und legt die Zuordnung in seinem internen Speicher ab –
dem sogenannten NVS. Du kannst also handelsübliche RFID-Karten, Chips oder Aufkleber verwenden –
konkret die Standards **ISO-14443** und (nur mit dem PN5180-Reader) **ISO-15693**. Ganz „beliebig"
ist es also nicht, aber die allermeisten gängigen Tags passen.

So gehst du vor:

1. **Leg eine noch unbenutzte Karte auf den Leser.** Sofern der RFID-Reader diese Karte lesen kann,
   erkennt ESPuino sofort, dass er diese Karte noch nicht kennt.
2. **Achte auf die Neopixel:** Sie quittieren das Auflegen mit einem kurzen **roten** Aufleuchten.
   Das ist keine Fehlermeldung, sondern schlicht das Zeichen „unbekannte Karte erkannt".
3. **Die Kartennummer erscheint automatisch** im Webinterface im passenden Eingabefeld – eine
   zwölfstellige Zahl. Du musst sie also nicht abtippen; das Auflegen genügt.
4. **Wähle im Dateibrowser aus, was gespielt werden soll** – eine einzelne Datei oder einen ganzen
   Ordner. Der Pfad wird übernommen.
5. **Lege den Abspielmodus fest.** Er entscheidet, *wie* der Inhalt läuft: ein einzelner Titel, ein
   ganzer Ordner sortiert oder zufällig, ein Hörbuch mit gemerkter Position, und so weiter. Welcher
   Modus wofür gedacht ist, erklärt die Übersicht im
   [Webinterface-Kapitel](../bedienung/webinterface.md#abspielmodi).
6. **Speichere die Zuweisung.** Fertig – ab jetzt startet diese Karte den gewählten Inhalt, sobald
   du sie auflegst. 🎉

!!! tip "Schnell testen, ohne eine Karte zu opfern"
    Du möchtest nur kurz hören, ob eine Datei sauber läuft? Im Dateibrowser kannst du per Rechtsklick
    (am Smartphone: langes Antippen) eine Datei oder einen Ordner **direkt abspielen** – ganz ohne
    eine Karte anzulernen.

## Ein paar sinnvolle erste Einstellungen

Bevor der ESPuino in Kinderhände wandert, lohnen sich zwei kleine Handgriffe, die dir später Ärger
ersparen.

Der erste betrifft die **Lautstärke**. Im Tab Allgemein kannst du eine Maximal-Lautstärke festlegen
(auf einer Skala von 0 bis 21), und zwar getrennt für Lautsprecher und Kopfhörer. So kann die Box
gar nicht erst unangenehm laut werden – gerade bei Kindern eine dankbare Einstellung.

Der zweite betrifft **FTP**, falls du es später einmal nutzen möchtest – die meisten brauchen es
nicht, denn der Web-Upload ist schneller und bequemer. FTP läuft aus gutem Grund nicht ständig mit:
Es würde dauerhaft Arbeitsspeicher belegen, den ESPuino zum Beispiel fürs Webradio besser gebrauchen
kann. Deshalb aktivierst du den FTP-Dienst nur bei Bedarf – entweder im Tab FTP oder über eine
**Tastenkombination am Gerät** (die Neopixel bestätigen das mit einem kurzen grünen Aufleuchten). Nach
dem nächsten Neustart ist FTP wieder aus.

## Wie es weitergeht

Damit läuft dein ESPuino. Alles, was du hier angerissen hast, ist an anderer Stelle ausführlich
beschrieben: die komplette Bedienoberfläche in [Kapitel 7 · Das Webinterface](../bedienung/webinterface.md),
die Bedienung am Gerät mit allen Tasten und Anzeigen in [Kapitel 8](../bedienung/am-geraet.md), und
das Organisieren deiner Musik in [Kapitel 9](../inhalte/verwalten.md). Viel Freude beim Hören.
