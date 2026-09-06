# 16 · Bestandsgeräte: mini4L

Die **mini4L** ist der direkte Vorgänger der [Complete](../hardware/complete.md). Sie wird nicht mehr verkauft, ist aber
weiterhin voll unterstützt – wenn du also eine besitzt, bist du hier richtig. Damit dieses Handbuch
nicht alles doppelt erklärt, beschränkt sich dieses Kapitel bewusst auf die **Unterschiede** zur
Complete. Alles, was hier nicht erwähnt wird – und das ist der weitaus größte Teil, von der Bedienung
bis zum Webinterface –, funktioniert bei der mini4L genau wie in den übrigen Kapiteln beschrieben.

## Was die mini4L ausmacht

Anders als die Complete, die alles auf einer Platine vereint, besteht die mini4L aus zwei Teilen: einer
Trägerplatine und einem darauf **eingesteckten Entwicklerboard** (einem eigens entwickelten D32-Pro-Board,
siehe [Forum #1109](https://forum.espuino.de/t/esp32-develboard-d32-pro-lifepo4/1109)). Das
Build-Target für die Firmware heißt entsprechend **`lolin_d32_pro_sdmmc_pe`**. Vorgestellt und
diskutiert wird sie im [Forum #1661](https://forum.espuino.de/t/espuino-mini-4layer/1661).

## Pinout und SD-MMC

In der Praxis sind die realen ESP32-GPIOs **weitgehend identisch zur Complete**: I²S auf 25/27/26,
die RFID-SPI-Leitungen auf 21/18/23/19, RFID_BUSY 33 und RST 22, der Encoder auf CLK 34 / DT 39, die
LED auf 12, Wakeup und Port-Expander-Interrupt auf 36, die Batteriemessung auf 35 und der IR-Empfänger
auf 5. Die SD-Karte läuft im **SD-MMC-Modus (1-Bit)** über CLK 14, CMD 15 und D0 2. Auch die Tasten
Next, Prev und Play/Pause liegen wie bei der Complete auf den Port-Expander-Kanälen 102, 100 und 101.

Die Unterschiede beschränken sich auf einige **Port-Expander-Kanäle**:

| Signal | mini4L | Complete |
| --- | --- | --- |
| Verstärker-Enable (`GPIO_PA_EN`) | PE 108 | PE 113 |
| Encoder-Taster | PE 103 | PE 105 |
| Button 4 / 5 | PE 104 / 105 | PE 103 / 104 |
| Kopfhörer-Erkennung (`HP_DETECT`) | PE 107 | PE 108 |
| Power (Peripherie-Abschaltung) | PE 115 | PE 114 |

Der PN5180-IRQ ist bei der mini4L standardmäßig deaktiviert (Wert `99`); für LPCD würde man ihn auf
GPIO 32 setzen.

## Firmware und Bedienung

Die Firmware baust du mit dem Target `lolin_d32_pro_sdmmc_pe` – ansonsten gilt
[Kapitel 13](../firmware/aktualisieren.md) unverändert. Der wichtigste Unterschied im Alltag ist
letztlich ein Hardware-Detail: Bei der mini4L läuft die Stromversorgung über einen Linearregler (LDO)
statt über den Buck/Boost-Regler der Complete. Was das bedeutet, ist in
[Kapitel 3 → Stromversorgung](../hardware/complete.md#die-stromversorgung-und-warum-sie-so-wichtig-ist)
ausführlich erklärt. **Bedienung und Webinterface sind vollständig identisch** zur Complete.
