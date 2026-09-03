# 14 · Bestandsgeräte: mini4L

Nur die **Unterschiede** zur Complete – kein vollständiger Doppel-Aufbau.

## Status

Direkter Vorgänger der Complete ([Forum #1661](https://forum.espuino.de/t/espuino-mini-4layer/1661)):
eine Trägerplatine, in die ein selbst entwickeltes **D32-Pro-Develboard**
([Forum #1109](https://forum.espuino.de/t/esp32-develboard-d32-pro-lifepo4/1109)) eingesteckt wird.
HAL/Build-Target **`lolin_d32_pro_sdmmc_pe`**. Nicht mehr im Verkauf, aber weiterhin unterstützt.

## Pinout & SD-MMC-Besonderheiten

Die realen ESP32-GPIOs sind weitgehend **identisch zur Complete**: I²S 25/27/26, RFID-SPI
21/18/23/19, RFID_BUSY 33 / RST 22, Encoder CLK 34 / DT 39, LED 12, Wakeup/PE-Interrupt 36,
Batterie-ADC 35, IR 5. Die SD-Karte läuft über **SD-MMC (1-Bit)**: CLK 14, CMD 15, D0 2. Buttons
Next/Prev/Play-Pause liegen wie bei der Complete auf PE 102/100/101.

Abweichend sind einige **Port-Expander-Kanäle** (PCA9555):

| Signal | mini4L | Complete |
| --- | --- | --- |
| Verstärker-Enable (`GPIO_PA_EN`) | PE 108 | PE 113 |
| Encoder-Taster | PE 103 | PE 105 |
| Button 4 / 5 | PE 104 / 105 | PE 103 / 104 |
| Kopfhörer-Erkennung (`HP_DETECT`) | PE 107 | PE 108 |
| Power (Peripherie-Abschaltung) | PE 115 | PE 114 |

Der PN5180-IRQ ist standardmäßig deaktiviert (`99`); für LPCD auf GPIO 32 setzen.

## Stromversorgung (Delta)

Die mini4L versorgt über einen **Linearregler (LDO)** statt Buck/Boost: nur USB/LiPo, mit
Dropout-Verlust (bei fast leerem Akku kam am ESP32 zu wenig an). LFP wurde am LDO **vorbei**
durchgeschleust. Hintergrund und Vergleich: [Kapitel 3 → Stromversorgung](../hardware/complete.md#stromversorgung).

## Firmware-Build

Build-Target `lolin_d32_pro_sdmmc_pe`. Sonst identisch zur Complete (siehe
[Kapitel 11](../firmware/aktualisieren.md)).

## Wo sich Aufbau & Bedienung unterscheiden

Der Hauptunterschied ist die **Bauform**: bei der mini4L wird ein separates D32-Pro-Develboard auf
die Trägerplatine gesteckt (die Complete integriert alles auf einer Platine). Die Verkabelung der
Peripherie und die abweichenden Port-Expander-Kanäle (siehe oben) sind zu beachten; die
Stromversorgung läuft über einen LDO statt Buck/Boost (siehe Delta oben). **Bedienung und
Webinterface sind identisch** zur Complete.
