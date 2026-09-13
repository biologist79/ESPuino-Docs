# 16 · Appareils existants : mini4L

La **mini4L** est le prédécesseur direct de la [Complete](../hardware/complete.md). Elle n'est plus
vendue, mais reste entièrement prise en charge – donc si tu en possèdes une, tu es au bon endroit.
Pour éviter que ce manuel n'explique tout deux fois, ce chapitre se limite volontairement aux
**différences** avec la Complete. Tout ce qui n'est pas mentionné ici – et c'est de loin la plus
grande partie, de l'utilisation à l'interface web – fonctionne sur la mini4L exactement comme décrit
dans les autres chapitres.

## Ce qui caractérise la mini4L

![La carte support de la mini4L avec les emplacements pour la carte de développement D32 Pro, le lecteur SD, l'amplificateur MAX98357A, l'extenseur de ports PCA9555, ainsi que les connecteurs étiquetés pour les boutons, le casque, le lecteur RFID, l'I²C, le connecteur Ext, le reset et le haut-parleur](../assets/Mini4l.jpeg)

Contrairement à la Complete, qui réunit tout sur une seule carte, la mini4L se compose de deux
parties : une carte support et une **carte de développement enfichée** au-dessus (une carte
D32 Pro spécialement développée, voir le
[forum #1109](https://forum.espuino.de/t/esp32-develboard-d32-pro-lifepo4/1109), en allemand). La
cible de compilation du firmware s'appelle en conséquence **`lolin_d32_pro_sdmmc_pe`**. Elle est
présentée et discutée dans le [forum #1661](https://forum.espuino.de/t/espuino-mini-4layer/1661)
(en allemand).

## Brochage et SD-MMC

En pratique, les GPIO ESP32 réels sont **en grande partie identiques à ceux de la Complete** : I²S
sur 25/27/26, les lignes SPI du RFID sur 21/18/23/19, RFID_BUSY sur 33 et RST sur 22, l'encodeur sur
CLK 34 / DT 39, la LED sur 12, le réveil et l'interruption de l'extenseur de ports sur 36, la mesure
de batterie sur 35 et le récepteur IR sur 5. La carte SD fonctionne en **mode SD-MMC (1 bit)** via
CLK 14, CMD 15 et D0 2. Les boutons Next, Prev et Play/Pause se trouvent également sur les canaux
102, 100 et 101 de l'extenseur de ports, comme sur la Complete.

Les différences se limitent à quelques **canaux de l'extenseur de ports** :

| Signal | mini4L | Complete |
| --- | --- | --- |
| Activation de l'amplificateur (`GPIO_PA_EN`) | PE 108 | PE 113 |
| Bouton de l'encodeur | PE 103 | PE 105 |
| Bouton 4 / 5 | PE 104 / 105 | PE 103 / 104 |
| Détection du casque (`HP_DETECT`) | PE 107 | PE 108 |
| Alimentation (coupure des périphériques) | PE 115 | PE 114 |

Sur la mini4L, l'IRQ du PN5180 est désactivée par défaut (valeur `99`) ; pour le LPCD, il faudrait la
régler sur GPIO 32.

## Firmware et utilisation

Tu compiles le firmware avec la cible `lolin_d32_pro_sdmmc_pe` – sinon, le
[chapitre 13](../firmware/aktualisieren.md) s'applique sans changement. Dans l'usage quotidien, la
différence la plus importante se résume finalement à un détail matériel : sur la mini4L,
l'alimentation passe par un régulateur linéaire (LDO) au lieu du régulateur buck/boost de la
Complete. Ce que cela implique est expliqué en détail au
[chapitre 3 → alimentation](../hardware/complete.md#die-stromversorgung-und-warum-sie-so-wichtig-ist).
**L'utilisation et l'interface web sont entièrement identiques** à celles de la Complete.
