# 4 · Der Akku

ESPuino läuft problemlos dauerhaft am USB-Netzteil – für den mobilen Betrieb brauchst du aber einen
Akku. Weil beim Thema Lithium-Akku echte Sicherheit auf dem Spiel steht, bekommt es hier ein eigenes
Kapitel. Bitte lies es, bevor du einen Akku anschließt.

!!! danger "Nur Lithium-Akkus **mit BMS** verwenden – sonst Brandgefahr!"
    Verwende **niemals** einen Lithium-Akku **ohne Schutzschaltung (BMS, Battery Management System)**.
    Ein ungeschützter Akku kann überladen oder tiefentladen werden und **Feuer fangen**. Kauf deshalb
    ein **fertiges Akkupack mit integriertem BMS** – hier gibt es keine Kompromisse.

## LFP oder LiPo?

Hast du das beherzigt, geht es um die Wahl des Typs. Beide sind im [Glossar](../einstieg/was-ist-espuino.md)
kurz erklärt; fürs Entscheiden reicht diese Gegenüberstellung:

| | **LFP (LiFePO₄)** | **LiPo** |
| --- | --- | --- |
| Sicherheit | sehr sicher | deutlich gefährlicher |
| Auswahl fertiger Packs | wenig (im Grunde nur das unten genannte) | groß |
| Energiedichte / Laufzeit | geringer | höher |

Kurz gesagt: LFP ist das gutmütigere, sicherere Kind, LiPo das kompaktere mit mehr Auswahl – aber
auch dem größeren Respekt-Faktor.

## Empfehlung: fertige Packs

Am einfachsten und sichersten sind fertige Packs von **[Eremit](https://www.eremit.de/)** – sie haben
den Schutz schon integriert und den passenden **JST-PH-Stecker**:

- **LiPo:** aus dem [3,7-V-LiPo-Sortiment](https://www.eremit.de/c/3-7v-lipo-akkus); empfehlenswert
  sind etwa **2500 mAh**.
- **LFP:** das [3,2-V-6000-mAh-Pack mit Schutz](https://www.eremit.de/p/3-2v-6000mah-pack-mit-schutz-arduino-aio-jst-ph-2-0-stecker)
  – hier gibt es nur diese eine Größe.

!!! tip "Für Selbstbauer"
    Wer einen LFP-Pack mit Schutzschaltung lieber selbst zusammenbaut, findet dazu eine Anleitung im
    Forum: [Ein kleiner LiFePO4-Akkupack mit BMS im Selbstbau (#1592)](https://forum.espuino.de/t/ein-kleiner-lifepo4-akkupack-mit-schutzschaltung-bms-im-selbstbau/1592).
    Auch hier gilt kompromisslos: **niemals ohne BMS.**

## Anschließen

Der Akkutyp wird auf der Platine über Lötbrücken eingestellt – ab Werk je nach Bestellung, später
änderbar. Details dazu stehen bei den [Lötbrücken in Kapitel 5](aufbau.md#die-lotbrucken).

!!! warning "Immer die Polarität des Steckers prüfen!"
    Verlass dich nie blind auf den Stecker – gleiche die **Polarität** vor dem Anstecken mit dem
    Platinenaufdruck ab. Es gab schon Packs mit vertauschter Belegung, und eine falsche Polung kann
    die Platine zerstören. Hinweise dazu auch beim
    [Eremit-Pack](https://www.eremit.de/p/3-2v-6000mah-pack-mit-schutz-arduino-aio-jst-ph-2-0-stecker).
