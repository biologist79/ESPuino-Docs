# 14 · Configuration à la compilation

Ne restent ici que les sujets que l'interface web **ne couvre pas**. Un grand nombre de réglages
sont désormais configurables à l'exécution via l'interface web (voir le tableau de migration à la
fin de cette page).

!!! note "État de cette page"
    Tableaux dérivés du code du firmware (état actuel de `dev`). À maintenir à jour lors des
    changements de code.

## Ai-je vraiment besoin de mes propres flags ?

En général, pas du tout – le firmware prêt à l'emploi (niveau 1) convient à la plupart des gens. Des
flags personnalisés ne valent le coup que pour un matériel différent ou les quelques valeurs
réellement propres à la compilation ci-dessous.

## Mécanisme de surcharge

Les réglages personnalisés se placent dans un fichier `settings-override.h` (ou, pour une carte
personnelle via `HAL 99`, un `settings-custom.h`), afin qu'une mise à jour ne les écrase pas.

## Flags de fonctionnalités restants (réellement liés à la compilation)

| Flag | Objectif |
| --- | --- |
| `HAL` | Sélection de la carte (voir ci-dessous) |
| `LANGUAGE` | Langue de la sortie **série** (≠ langue de l'interface web) |
| `SERIAL_LOGLEVEL` | Niveau de journalisation de la console série |
| `CHIPSET` / `COLOR_ORDER` | Type de Neopixel (modèle FastLED, pas à l'exécution) |
| `MDNS_ENABLE` | `ESPuino.local` accessible |
| `MQTT_ENABLE` | Intégration MQTT |
| `FTP_ENABLE` | Serveur FTP |
| `NEOPIXEL_ENABLE` | LED Neopixel |
| `BLUETOOTH_ENABLE` | Bluetooth (→ firmware « noBT » si désactivé) |
| `MEASURE_BATTERY_VOLTAGE` | Mesure de la batterie |
| `USEROTARY_ENABLE` | Molette rotative |
| `HEADPHONE_ADJUST_ENABLE` | Détection du casque/stéréo pour la carte casque |
| `SHUTDOWN_IF_SD_BOOT_FAILS` | Veille profonde en cas d'échec de démarrage SD |
| `PORT_EXPANDER_ENABLE` | Extenseur de ports PCA9555 |
| `SD_MMC_1BIT_MODE` | SD en mode SD-MMC 1 bit |
| `I2C_2_ENABLE` | second bus I²C |
| `INCLUDE_ROTARY_IN_CONTROLS_LOCK` | Verrouiller aussi l'encodeur |
| `INVERT_POWER` / `DETECT_HP_ON_HIGH` | Logique de carte (alimentation / détection casque) |
| Télécommande IR (`RC_*`, `IR_DEBOUNCE`) | Codes infrarouges |

## Définitions des broches

Spécifiques à chaque carte, dans les en-têtes (`settings-complete.h`,
`settings-lolin_d32_pro_sdmmc_pe.h`). Voir aussi l'[annexe → brochage](../referenz/anhang.md).

## Valeurs uniquement via `settings.h` (pas d'interface web)

| Valeur | Emplacement | Objectif |
| --- | --- | --- |
| `deepsleepTimeAfterBootFails = 20` | `settings.h` | Redémarrage automatique après un échec de démarrage SD (secondes) |
| `rdiv1`, `rdiv2`, `inputAttenuation` | `settings-complete.h` | Calibration de la batterie (pont diviseur/ADC) |
| `RC_*`, `IR_DEBOUNCE` | `settings-complete.h` | Codes de la télécommande IR |
| Définitions des broches | En-tête de la carte | voir ci-dessus |

!!! info "`offsetVoltage` désormais dans l'interface web"
    La **valeur de correction** de batterie `offsetVoltage` est réglable dans l'interface web
    (réglages de batterie) **depuis septembre 2026** et n'est donc plus listée ici.

!!! info "Distances de saut désormais dans l'interface web"
    Les deux **distances de saut pour le défilement** sont également réglables dans l'interface web
    **depuis septembre 2026** ([chapitre 8 → distances de saut](../bedienung/webinterface.md#sprungweiten))
    et ne figurent donc plus dans ce tableau : celle par **pression sur un bouton** (auparavant
    `jumpOffset`) et celle par **cran de la molette rotative** (auparavant `JUMP_OFFSET_ROTARY`).
    Les deux constantes ont disparu de `settings.h` et ne subsistent plus que comme valeurs par
    défaut internes (`SEEK_STEP_BUTTON_DEFAULT` / `SEEK_STEP_ROTARY_DEFAULT`) dans `values.h`.
    **Important pour les montages maison :** un `settings-override.h` qui les définit encore n'a
    plus aucun effet.

## Règle de priorité

**Interface web > `settings.h`.** Une valeur définie dans l'interface web (NVS) prévaut sur la
valeur par défaut de compilation. Un `settings-override.h` qui définit encore une option depuis
longtemps passée dans l'interface web n'a simplement plus aucun effet.

## Tableau de migration « autrefois `settings.h` → aujourd'hui interface web »

Ces éléments étaient autrefois des macros à la compilation et se trouvent aujourd'hui dans
l'interface web :

| Autrefois (`settings.h`) | Aujourd'hui dans l'interface web |
| --- | --- |
| `STATIC_IP_ENABLE` | IP statique (par réseau) |
| `PLAY_LAST_RFID_AFTER_REBOOT` | « Reprendre la dernière carte après redémarrage » |
| `PAUSE_WHEN_RFID_REMOVED` | « Pause au retrait de la carte » |
| `DONT_ACCEPT_SAME_RFID_TWICE` | « Ne pas réaccepter la même carte » |
| `RESUME_ON_SAME_RFID` | « Reprendre avec la même carte » |
| `NEOPIXEL_REVERSE_ROTATION` | Sens de rotation des Neopixels |
| `SHUTDOWN_ON_BAT_CRITICAL` | « Éteindre à tension critique » |
| `PLAY_MONO_SPEAKER` | Mono/stéréo |
| `RFID_SCAN_INTERVAL` | Intervalle de balayage du MFRC522 |
| Valeurs LED par défaut (`NUM_*_LEDS`, `*_HUE_*`, `ATMO_*`, `DIMMABLE_STATES`, `LED_OFFSET`) | Luminosité / dégradé / disposition des Neopixels |
| Seuils de batterie (`s_warning*`, `s_voltageIndicator*`, `s_batteryCheckInterval`) | Réglages de batterie |
| Volumes (initial / min / max, haut-parleur + casque) | Réglages de volume |
| `maxInactivityTime` | Inactivité avant veille profonde |
| Disposition des boutons | Disposition dynamique des boutons |
| Gain du RC522 | Réglages RFID |
| `savePos*` (extinction / changement de carte / intervalle) | Réglages du livre audio |
| Profondeur de récursion | Tri/récursion |
