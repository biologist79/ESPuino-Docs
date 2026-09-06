# 6 · Das Gehäuse

Wohin mit der fertig verdrahteten Platine? Die meisten ESPuinos stecken in einem **3D-gedruckten
Gehäuse** – wie groß, wie bunt und in welcher Form, entscheidest du selbst. Dieses Kapitel gibt dir
einen Startpunkt; mehr als ein Referenzdesign und ein paar Hinweise braucht es dafür nicht.

## Das Referenz-Design: die BioBox { #referenz-design-biobox }

Als **Referenz-Design** dient die **[BioBox 3D](https://forum.espuino.de/t/biobox-3d/3130)**, ein
3D-druckbares Gehäuse für Complete oder mini4L. Sie gibt eine gute Vorstellung davon, wie ein
fertiger ESPuino aussehen kann: ein Würfel mit rund 12 cm Kantenlänge, vorn ein Wabengitter für den
Lautsprecher mit einer Vertiefung für den Neopixelring, oben drei Tasten und der Drehencoder, hinten
USB-C und Kopfhörerbuchse, unten eine Revisionsöffnung und eine Akkuhalterung (für 18650-, 26650-
oder 32700-Zellen). Die Druckdateien gibt es als STL und als Fusion-360-Datei; empfohlen werden PETG,
fünf Wandschichten und 35 % Infill (etwa 17 Stunden Druckzeit).

## Woran du beim Gehäuse denken solltest

Egal ob BioBox oder Eigenentwurf – ein paar Aussparungen und Zugänge sollte jedes Gehäuse vorsehen:

- **Lautsprecher** – ein Gitter oder Löcher vor der Membran.
- **Neopixel** – eine Öffnung oder ein lichtdurchlässiges Fenster für den Ring.
- **Tasten und Drehencoder** – Durchbrüche an den passenden Stellen.
- **USB-C** – zum Laden und Flashen gut erreichbar.
- **Kopfhörerbuchse** – falls du die Kopfhörerplatine verbaust.
- **SD-Karte** – der Slot sollte zugänglich bleiben (etwa über eine Revisionsöffnung), damit du die
  Karte zum Bespielen herausnehmen kannst.
- **Akku** – eine Halterung passend zu deiner Zellengröße.

## Kein 3D-Drucker?

Kein Drucker im Haus? Kein Problem: Du kannst die Druckdateien bei einem **Druckservice** in Auftrag
geben oder jemanden aus der **Community** fragen – im [Forum](https://forum.espuino.de) findet sich
oft jemand, der gerne aushilft.

## Es muss kein 3D-Druck sein: Holz & Co.

3D-Druck ist der verbreitetste, aber längst nicht der einzige Weg. Manche nehmen ein **fertiges
Holzgehäuse** (etwa eine Holzbox aus dem Bastelbedarf) und arbeiten die nötigen Aussparungen selbst
hinein; andere **bauen ihr Gehäuse komplett aus Holz**. Ein schönes Beispiel ist die
**[BioBox v2 (#1654)](https://forum.espuino.de/t/biobox-v2/1654)** – der hölzerne Vorgänger der
heutigen BioBox 3D.

!!! tip "Lass dich in der Galerie inspirieren"
    Wie vielfältig ESPuinos aussehen können – von 3D-Druck über Holz bis zu umgebauten Fundstücken –,
    zeigt die Galerie [„Zeigt her eure ESPuinos" (#554)](https://forum.espuino.de/t/zeigt-her-eure-espuinos/554).
    Eine schöne Fundgrube für eigene Gehäuse-Ideen.
