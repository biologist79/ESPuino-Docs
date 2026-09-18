# 15 · Dépannage

Tout ne fonctionne pas toujours du premier coup – c'est normal pour un projet à monter soi-même et
ce n'est pas une raison de désespérer. Ce chapitre passe en revue les pièges les plus fréquents et
explique, pour chacun, ce qui en est généralement la cause et ce qui aide. Encore une chose au
préalable : **tu n'as pas à résoudre chaque problème toi-même.** Parfois, la cause n'est même pas
ton montage, mais par exemple un fichier ou une bibliothèque utilisée – ce genre de choses, nous les
réglons ensemble. Donc si tu ne trouves pas ce qu'il te faut ici, le
[**forum**](https://forum.espuino.de) est toujours le bon endroit – idéalement avec le journal (voir
juste en dessous) et quelques informations sur ton appareil.

## D'abord : consulter le journal

Avant de tâtonner longtemps, il vaut presque toujours la peine de regarder le journal – il indique
souvent directement ce qui ne va pas. Tu peux y accéder de plusieurs façons : de façon pratique
**dans le navigateur** via le menu en pile en haut à droite de l'interface web, entrée **journal** –
cela suppose toutefois qu'ESPuino soit **en fonctionnement et accessible sur le Wi-Fi**, ce qui,
dans les cas problématiques, n'est justement souvent pas le cas, l'expérience le montre. Sinon, la
voie passe par le **port série**, via USB à 115200 bauds. Pour la console série, tu n'as pas besoin
d'environnement de développement – l'
[outil ESPuino Firmware Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/) apporte une
telle console directement dans le navigateur (plus de détails ci-dessous sous « Quand plus rien ne
fonctionne »). Le niveau de détail de la journalisation d'ESPuino est contrôlé par le réglage
`SERIAL_LOGLEVEL` ([chapitre 14](../firmware/compile-zeit.md)).

!!! warning "Un câble USB avec fils de données est nécessaire"
    L'accès série nécessite un câble USB avec des **fils de données**. Les câbles **de charge**
    purs ne transmettent pas de données – dans ce cas, en général, **aucune connexion** ne s'établit
    du tout avec la Complete (l'appareil n'apparaît souvent même pas comme un port). C'est un
    problème fréquent notamment avec les **rallonges ou les adaptateurs** ; en cas de doute, essaie
    un autre câble.

## La carte RFID n'est pas détectée de façon fiable

Si les cartes sont parfois détectées et parfois non, c'est généralement une question de distance ou
de sensibilité. Rapproche un peu la carte du lecteur, et avec un MFRC522, essaie d'ajuster la
**sensibilité** (réglage **gain MFRC522**, 0–7). Elle est déjà réglée assez haut par défaut – cela
peut donc valoir le coup de ne pas seulement l'augmenter, mais aussi de la **réduire**. Si tu
utilises un PN5180 et qu'ESPuino signale à tort une carte immobile comme « retirée », augmenter le
**délai de rebond (debounce) du PN5180** (500 ms par défaut) peut aider – les réglages
correspondants se trouvent dans l'onglet Général → Lecteur RFID.

Un cas particulièrement fréquent mérite une mention à part : si la lecture, avec l'option « **pause
au retrait de la carte** » activée, s'arrête ensuite sporadiquement toute seule, c'est que la carte
n'est momentanément pas détectée entre-temps, et qu'ESPuino confond cela avec un retrait. C'est un
problème récurrent bien connu. Réduis la distance entre la carte et le lecteur, augmente – pour le
PN5180 – son délai de rebond, ou désactive simplement l'option si elle t'apporte plus d'ennuis que
d'avantages. (L'option existe pour le RC522 et le PN5180 ; seul le délai de rebond est spécifique au
PN5180.) (Pour le LPCD, voir l'avertissement explicite au [chapitre 12](../vertiefung/erweiterte-themen.md#lpcd).)

!!! tip "Fouiller le forum en vaut la peine"
    Autour de la détection des cartes, le [forum](https://forum.espuino.de) contient déjà de
    nombreuses discussions avec des astuces pratiques (en allemand). Une recherche rapide y mène
    souvent plus vite au but qu'un long tâtonnement – n'hésite pas à y jeter un œil.

## La carte SD n'est pas détectée

La raison la plus fréquente, de loin, est le système de fichiers : ESPuino a besoin du **FAT32**,
mais de nombreuses cartes sont livrées **formatées en exFAT** de l'usine. Reformate la carte en
FAT32 sur un ordinateur – pour les cartes de plus de 32 Go, c'est presque toujours nécessaire. Si
les LED clignotent en **rouge** en permanence au démarrage, c'est exactement le signal « SD illisible » ;
ESPuino reste alors dans cet état jusqu'à ce qu'une carte utilisable soit insérée (ou s'endort si
`SHUTDOWN_IF_SD_BOOT_FAILS` est actif). Si le reformatage n'aide pas, essaie une autre carte à titre
de test – les cartes très bon marché ou très anciennes en particulier ne fonctionnent pas toujours
de façon fiable.

!!! tip "Pas d'interface web sans carte SD – utilise la console série"
    Sans carte SD lisible, **ESPuino ne démarre pas complètement**, et tu n'accèdes même pas à
    l'interface web – la voie du journal via le navigateur est donc exclue. Regarde plutôt la
    **console série**, par exemple celle de l'
    [outil ESPuino Firmware Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/) (voir
    ci-dessous sous « Quand plus rien ne fonctionne »). Elle indique généralement directement
    pourquoi la carte est refusée.

Si une carte ne peut pas être lue – ou qu'aucune n'est insérée –, le message dans le journal ressemble
généralement à ceci :

```text
E (7918) sdmmc_common: sdmmc_init_ocr: send_op_cond (1) returned 0x107
E (7918) vfs_fat_sdmmc: sdmmc_card_init failed (0x107).
E [7928] La carte SD n'a pas pu être montée.
```

## Pas de son, ou son déformé

Si aucun son ne sort, vérifie d'abord l'évident : le volume et ses valeurs maximales dans
l'interface web (onglet Général → Lecture). Si le son est déformé, le **gain** est peut-être réglé
trop haut – sur la [Complete](../hardware/complete.md), un pont de soudure règle le gain de base :
sans pont, +9 dB, avec JP2, +3 dB, avec JP3, +15 dB (n'en poser toujours qu'un seul). Et pour le
casque, la [carte casque](../bedienung/am-geraet.md#kopfhorer-detection-lautstarke-profile) filaire
est la solution fiable.

## Certains titres ne se jouent pas ou saccadent (MP3) { #einzelne-titel-machen-probleme-mp3 }

Parfois, ce n'est pas l'appareil qui est en cause, mais un fichier isolé. Avec les MP3 en
particulier, la **pochette intégrée** est souvent la cause, ou un encodage inhabituel. Dans ce cas,
un ré-encodage propre peut aider, par exemple avec [ffmpeg](https://ffmpeg.org/) :

```bash
ffmpeg -i probleme.mp3 -vn -c:a libmp3lame -q:a 2 propre.mp3
```

Le `-vn` supprime la pochette intégrée (qui techniquement circule comme une piste « vidéo »), `-q:a 2`
assure une bonne qualité. Si cela concerne un dossier entier, place la commande dans une petite
boucle de fichiers de ton shell.

!!! note "Parfois, c'est la bibliothèque audio qui est en cause"
    Pour la lecture, ESPuino utilise la bibliothèque
    [ESP32-audioI2S](https://github.com/schreibfaul1/ESP32-audioI2S/). Il arrive parfois qu'un
    problème de lecture ne vienne pas de ton fichier ni de ton appareil, mais soit un **bug dans
    cette bibliothèque**. Nous signalons ces cas au développeur, et ils sont ensuite corrigés. En
    bref : ce n'est pas à toi de résoudre (ou de pouvoir résoudre) chaque problème. Signale-le
    simplement sur le [forum](https://forum.espuino.de) – nous l'examinerons ensemble et
    découvrirons ce qui se passe.

## Problèmes de Wi-Fi { #wlan-probleme }

Deux choses sont faciles à négliger. Premièrement : l'ESP32 n'émet **qu'en 2,4 GHz** – un réseau
purement en 5 GHz lui est invisible. Deuxièmement : l'adresse doit toujours être ouverte avec
**`http://`**, ESPuino ne prend pas en charge le `https` (le contexte est expliqué au
[chapitre 7](../inbetriebnahme/erststart.md#das-webinterface-offnen)). Sinon, les suspects habituels
s'appliquent : trop de distance par rapport au routeur, une faute de frappe dans les identifiants.
Si les LED restent **vertes** au lieu de blanches en veille, il n'y a pas de connexion – essaie alors
de redémarrer, de te rapprocher du routeur, ou de ressaisir les identifiants.

Surtout dans les zones avec **de nombreux réseaux Wi-Fi à proximité**, il peut aussi aider de
**fixer le canal Wi-Fi sur le routeur** plutôt que de le laisser se choisir automatiquement.

## Boucles de démarrage et brownouts

Si ESPuino redémarre sans cesse, ou s'éteint en plein fonctionnement, il y a presque toujours un
**problème d'alimentation électrique** derrière. Une source trop faible – un câble USB trop fin, une
alimentation sous-dimensionnée, une batterie presque vide – s'affaisse brièvement face à l'appel de
courant au moment de la mise sous tension ou lors de pics de volume, et déclenche une réinitialisation
par brownout. Une source plus puissante et un meilleur câble résolvent cela. Pour rappel : la
Complete fournit une tension stable de 3,3 V via son régulateur buck/boost et s'éteint proprement en
cas de sous-tension. *(D'autres cas particuliers seront ajoutés à partir du forum.)*

## Coincé par erreur en mode Bluetooth

Si tu es coincé en mode Bluetooth et que tu ne peux plus avancer : pose simplement une **carte RFID
inconnue** – cela ramène ESPuino en mode normal. Cela fonctionne aussi via le bouton **Arrêt** du
sélecteur de mode dans l'onglet Bluetooth.

## Quand plus rien ne fonctionne : réinitialiser l'appareil

Si ton ESPuino ne répond plus du tout, se bloque au démarrage, ou si l'interface web reste
définitivement inaccessible, l'**[outil ESPuino Firmware Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/)**
est la bouée de sauvetage. Il fonctionne entièrement **dans le navigateur** – il te faut juste une
connexion USB, aucun environnement de développement. Il faut pour cela un navigateur prenant en
charge le **WebSerial** (Chrome, Edge, Firefox à partir de la version 151, Opera, Brave ou Vivaldi) ;
choisis un débit d'au plus **460 800 bauds**, des valeurs plus élevées entraînent des coupures.

!!! warning "Utiliser un câble USB avec fils de données"
    Certains câbles USB sont conçus **uniquement pour la charge** et ne comportent **aucun fil de
    données**. Ni la console série ni le flashage ne fonctionnent alors – l'ESPuino n'est souvent
    même pas proposé comme port dans l'outil. C'est un problème fréquent notamment avec les
    **rallonges ou les adaptateurs**. Assure-toi donc que ton câble **transmet des données** (essaie
    un autre câble en cas de doute).

Selon la situation, l'un de ces niveaux aide – du plus anodin au plus radical :

- **Suivre la console.** La console série intégrée affiche en temps réel les sorties de démarrage et
  de journal – souvent, elle indique directement ce qui ne va pas.
- **Reflasher uniquement l'application.** Si l'appareil fonctionne encore partiellement, mais que
  l'interface web est inaccessible, **« mise à jour de l'application »** reflashe uniquement le
  firmware. Tes **réglages et attributions de cartes sont conservés** dans ce cas.
- **Dernier recours : effacer complètement et reflasher.** Si rien d'autre n'aide, tu effaces
  l'**ensemble de la mémoire flash** (explicitement marqué « urgence uniquement » dans l'outil) et
  reflashes tout à neuf avec **« Complete-Flash / Recovery »**.

!!! danger "Un effacement complet supprime aussi tes données"
    Un effacement complet de la mémoire flash réinitialise aussi le **NVS** – **les attributions de
    cartes, les identifiants Wi-Fi et tous les autres réglages disparaissent alors**. Seules les
    **attributions de cartes** peuvent être restaurées : elles se trouvent dans `backup.txt`
    ([chapitre 10 → Sauvegarde et restauration](../inhalte/verwalten.md#backup-restore-deine-kartenzuordnungen-sichern))
    et peuvent être réimportées ensuite. **Les identifiants Wi-Fi et les autres réglages ne peuvent
    actuellement pas être sauvegardés** – tu devras les ressaisir à la main après un effacement
    complet.

!!! warning "Choisir la bonne plateforme et la bonne branche"
    Lors du flashage, tu dois sélectionner la **plateforme correspondante** (par ex. Complete) et la
    **branche**. Un mauvais choix peut, dans le pire des cas, **endommager le matériel**.

Le déroulement détaillé du flashage est décrit au
[chapitre 13 · Mettre à jour le firmware](../firmware/aktualisieren.md).

!!! tip "Le problème persiste ?"
    Alors pose ta question sur le [forum](https://forum.espuino.de). Il est utile de joindre
    directement le journal (voir plus haut) et d'indiquer quelle carte et quelle version de firmware
    tu utilises, ainsi que ce qui se passe exactement.
