# 14 · Bestandsgeräte: mini4L

Nur die **Unterschiede** zur Complete – kein vollständiger Doppel-Aufbau.

## Status

Direkter Vorgänger der Complete ([Forum #1661](https://forum.espuino.de/t/espuino-mini-4layer/1661)):
eine Trägerplatine, in die ein selbst entwickeltes **D32-Pro-Develboard**
([Forum #1109](https://forum.espuino.de/t/esp32-develboard-d32-pro-lifepo4/1109)) eingesteckt wird.
HAL/Build-Target **`lolin_d32_pro_sdmmc_pe`**. Nicht mehr im Verkauf, aber weiterhin unterstützt.

## Pinout & SD-MMC-Besonderheiten

*TODO: Pinout aus `settings-lolin_d32_pro_sdmmc_pe.h`; SD-MMC-1-Bit-Verkabelung.*

## Stromversorgung (Delta)

Die mini4L versorgt über einen **Linearregler (LDO)** statt Buck/Boost: nur USB/LiPo, mit
Dropout-Verlust (bei fast leerem Akku kam am ESP32 zu wenig an). LFP wurde am LDO **vorbei**
durchgeschleust. Hintergrund und Vergleich: [Kapitel 3 → Stromversorgung](../hardware/complete.md#stromversorgung).

## Firmware-Build

Build-Target `lolin_d32_pro_sdmmc_pe`. Sonst identisch zur Complete (siehe
[Kapitel 11](../firmware/aktualisieren.md)).

## Wo sich Aufbau & Bedienung unterscheiden

*TODO: die wenigen Abweichungen (eingestecktes Develboard, Verkabelung); Bedienung ist identisch.*
