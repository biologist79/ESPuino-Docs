# 3 · La carte Complete

## Ce qui rend la Complete particulière

La Complete est la carte ESPuino actuelle et le point de référence de ce manuel. Son grand
avantage se résume en un mot : **l'intégration**. Là où les versions précédentes nécessitaient
d'assembler et de câbler plusieurs modules, la Complete réunit presque tout sur **une seule carte**
– ESP32-WROVER, amplificateur, régulateur de charge, surveillance de tension, l'extenseur de ports
pour les connexions supplémentaires et le lecteur de carte SD. Sur le plan fonctionnel, elle offre
donc essentiellement la même chose que l'ancienne mini4L, mais elle est moins chère et bien plus
rapide à assembler. Seule la carte casque reste un complément séparé et optionnel.

Concrètement, cela signifie : tu reçois la carte **entièrement assemblée**. La soudure CMS – c'est-à-dire
la soudure fine des minuscules composants – est déjà faite en usine. Ce qu'il reste à faire, c'est
souder quelques fils et connecteurs, ce qui est décrit au [chapitre 5](aufbau.md).

## Caractéristiques techniques

Avant d'entrer dans le détail, les faits en un coup d'œil :

| Caractéristique | Valeur |
| --- | --- |
| Dimensions | 72,2 × 70,6 mm, quatre trous de fixation (⌀ 3,2 mm) |
| Construction | carte quatre couches, entièrement assemblée en CMS |
| Contrôleur | ESP32-WROVER, 16 Mo de flash, 8 Mo de PSRAM |
| Alimentation | régulateur à découpage buck/boost (TPS63000), 3,3 V constants |
| Entrées | USB-C et/ou batterie (LiPo ou LFP), toutes deux protégées contre l'inversion de polarité |
| Régulateur de charge | courant de charge maximal fixe de 1 A, LED d'état embarquée |
| Amplificateur | MAX98357A, une sortie haut-parleur (les deux canaux mixés), ~1 W sur 4 Ω |
| Stockage audio | microSD (SD-MMC, 1 bit), FAT32 |
| Extension | extenseur de ports PCA9555 pour entrées/sorties supplémentaires |
| Connecteurs | connecteurs JST-PH pour le lecteur RFID, le haut-parleur, la molette rotative, les Neopixels, jusqu'à 5 boutons, la carte casque, la LED de charge, l'interrupteur d'extinction et la batterie ; plus l'USB-C et le connecteur d'extension Ext.Conn1. Le connecteur I²C reste non peuplé en usine ([détails](#die-anschlusse-im-uberblick)). |

Tout le reste – quel fil va où, ce que fait chaque pont de soudure – est couvert dans les sections
suivantes, notamment dans la [référence de brochage](#pinout-referenz-complete).

## L'alimentation { #die-stromversorgung-und-warum-sie-so-wichtig-ist }

ESPuino est censé fonctionner à partir de sources très différentes – une alimentation USB, une
batterie LiPo ou une batterie LiFePO4 (LFP). Et quelle que soit la source active à un instant donné,
et quel que soit l'état de charge de la batterie : il faut que **3,3 volts** stables sortent côté
ESP32.

C'était justement là le point sensible autrefois. La mini4L alimentait le contrôleur via ce qu'on
appelle un régulateur linéaire (LDO). Un tel régulateur « brûle » la tension excédentaire, mais a
lui-même besoin d'une petite marge : quand la batterie était presque vide et ne fournissait plus
qu'environ 3,3 V, il n'en restait plus qu'environ 3,1 V en sortie – déjà trop peu pour l'ESP32 à
proprement parler (en pratique, ça fonctionnait quand même le plus souvent, mais ce n'est pas très
propre). Cela devient particulièrement délicat avec les batteries LFP, qui ne fournissent de base
qu'environ 3,2–3,3 V ; il fallait donc carrément contourner le régulateur dans ce cas.

La Complete résout ce problème à la racine grâce à un **régulateur à découpage buck/boost**. Celui-ci
peut aussi bien abaisser une tension trop élevée qu'élever une tension trop basse, et fournit ainsi
3,3 V constants, indépendamment de la source et de l'état de charge. S'ajoute à cela une **coupure
en cas de sous-tension**, qui protège l'appareil avant que la batterie ne soit déchargée trop
profondément. Il faut néanmoins préciser d'emblée que cette protection ne remplace jamais la
fonction de coupure d'un [BMS](akku.md), qui doit impérativement être intégré à la batterie
utilisée.

Les deux entrées – USB-C et batterie – sont en outre **protégées contre l'inversion de polarité**.
Le **régulateur de charge** intégré charge la batterie avec un courant fixe de **1 A maximum**. Pour
que ce courant de charge ne soit pas excessif pour la batterie (règle empirique : pas plus de la
moitié de la capacité par heure, « 0,5 C »), la batterie devrait avoir **au moins 2000 mAh**. La
coupure en cas de sous-tension intervient à des seuils différents selon le type de batterie :
environ **2,75 V pour le LFP**, environ **3,15 V pour le LiPo**. Ces valeurs se situent
volontairement avec une certaine marge au-dessus de la limite absolue de décharge – cela préserve
la batterie et évite que de brefs pics de courant (un son fort, par exemple) n'éteignent
immédiatement l'appareil.

## Charge & LED de charge { #laden-lade-led }

Une petite **LED d'état** sur la carte affiche directement l'état de charge :

| LED | Signification |
| --- | --- |
| Clignotement rapide | USB connecté, mais aucune batterie détectée |
| Allumée en continu | USB et batterie connectés – la batterie est en charge |
| Éteinte | Batterie pleine (avec USB + batterie) ou fonctionnement sur batterie seule |

Si tu souhaites ramener cet indicateur vers l'extérieur du boîtier, il existe un **connecteur
2 broches dédié pour une LED de charge externe**. La résistance série nécessaire est déjà présente
sur la carte, tu peux donc connecter la LED directement – veille juste à respecter la **polarité**
imprimée.

Un point à comprendre : **pendant la charge**, la tension de batterie mesurée n'est pas
significative, car le processus de charge la relève artificiellement. Un affichage fiable du niveau
de charge n'existe donc que lorsque l'appareil fonctionne uniquement sur batterie (plus de détails
au [chapitre 4](akku.md)).

## Allumer et éteindre

En temps normal, c'est le **bouton intégré à la molette rotative** qui « éteint » et « allume »
l'ESPuino – en réalité, il passe en **veille profonde** économe en énergie et se réveille
immédiatement à la pression d'un bouton (voir le [glossaire](../einstieg/was-ist-espuino.md) et le
[chapitre 9](../bedienung/am-geraet.md)). Pour la plupart des usages, c'est tout à fait suffisant.

Si tu veux réduire encore davantage la consommation au repos, tu peux prévoir un **véritable
interrupteur**. La Complete dispose pour cela d'un **connecteur d'extinction 2 broches** : un
interrupteur qui y est connecté coupe totalement l'alimentation centrale de 3,3 V en **désactivant
le côté sortie du régulateur à découpage** – l'ESP32 est alors vraiment éteint, pas seulement
endormi. **La charge par USB continue de fonctionner** même quand l'interrupteur est sur « off ».

!!! note "Interrupteur d'extinction : les inconvénients"
    - Le démarrage qui suit est **un peu plus long** (démarrage à froid complet plutôt que réveil
      depuis la veille profonde).
    - Un interrupteur d'extinction matériel **ne peut pas être combiné** avec le **réveil LPCD** du
      PN5180 – les deux s'excluent mutuellement.

## Consommation & alimentation

En fonctionnement, un ESPuino consomme grossièrement **entre 140 et 350 mA**, selon le volume et
la luminosité des Neopixels. Si l'on ajoute la **charge**, cela peut aller jusqu'à **1 A**
supplémentaire. Pour que ton alimentation ne soit jamais juste – lecture forte et charge
simultanées –, utilise une **alimentation USB d'au moins 1,5 A**.

## L'amplificateur et le son

Le son est assuré par un **MAX98357A**, un petit amplificateur classe D avec convertisseur
numérique-analogique intégré. À 3,3 V, il délivre **environ 1 watt dans un haut-parleur de 4 ohms**
– suffisant pour une boîte à histoires compacte à volume domestique. De petits haut-parleurs large
bande comme le **Visaton FR 7** (4 Ω) ont fait leurs preuves.

Une différence avec la mini4L : la Complete n'a **qu'un seul amplificateur**, donc **une seule
sortie haut-parleur**. « Mono » au sens de *un canal est perdu* n'est pas tout à fait exact ici –
la sortie porte **les deux canaux stéréo mixés ensemble** (la somme de la gauche et de la droite),
rien n'est donc perdu. C'est donc une sortie monocanal – exactement ce qu'il faut pour une boîte à
histoires compacte. À la **sortie casque** (via la carte casque séparée), la stéréo est disponible.

Le son ne doit pas obligatoirement passer par l'amplificateur intégré : ESPuino maîtrise aussi le
**Bluetooth** – en tant que **source**, pour envoyer le son vers une enceinte ou un casque
Bluetooth, et en tant que **récepteur**, où ESPuino devient lui-même le haut-parleur et où tu peux
par exemple diffuser depuis ton téléphone. Les deux modes, et les points à surveiller, sont couverts
au [chapitre 9](../bedienung/am-geraet.md).

Le **gain de base** se règle via un pont de soudure :

| Pont de soudure | Gain de base |
| --- | --- |
| **JP2** – posé en usine | **+3 dB** |
| aucun pont | +9 dB |
| **JP3** | +15 dB |

!!! warning "Jamais JP2 et JP3 en même temps"
    Les deux ponts s'excluent mutuellement : un seul des deux peut être posé à la fois – ou aucun,
    et on reste alors à +9 dB.

Le réglage d'usine JP2 (+3 dB) s'avère généralement assez fort pour une boîte à histoires, et il a
un effet secondaire agréable : avec le gain de base plus faible, les **21 niveaux de volume du
logiciel sont plus rapprochés**, ce qui permet de **régler le volume plus finement**. Les détails
sur ces ponts de soudure se trouvent dans les [ponts de soudure au chapitre 5](aufbau.md#die-lotbrucken).

## Versions & contenu de livraison

La révision actuelle de la Complete est la **5.1**. Elle réunit les deux variantes de batterie sur
**une seule carte** – LFP ou LiPo se choisit via les ponts de soudure **JP5/JP6** (voir
[chapitre 5](aufbau.md#die-lotbrucken)). Le **bouton de réinitialisation** est posé en usine depuis
09/2026.

Seule une poignée des cartes précédentes (rév. 5.0/5.0.1) sont encore en circulation ; si tu en
possèdes une, les petites différences sont indiquées dans les [ponts de soudure au chapitre 5](aufbau.md#die-lotbrucken).

À l'achat, tu as le choix entre trois variantes – celle qui te convient dépend de ce que tu
souhaites apporter toi-même (détails et prix dans la
[liste de prix #3344](https://forum.espuino.de/t/preisliste/3344), forum en allemand) :

- **La carte seule** – la Complete entièrement assemblée, sans autre accessoire.
- **Set 1** – la carte avec les **câbles de connexion** nécessaires.
- **Set 2** – comme le Set 1, avec en plus la **carte casque**.

!!! note "Indiquer le type de batterie à la commande"
    À la commande, tu dois indiquer si tu souhaites la version **LiPo** ou la version **LFP**. Le
    type de batterie correspondant est préconfiguré en usine via les ponts de soudure sur la carte
    – tu n'as donc rien à régler toi-même. Si tu souhaites plus tard passer à l'autre type de
    batterie, cela reste modifiable par la suite en déplaçant un ou deux ponts de soudure (plus de
    détails dans les ponts de soudure au [chapitre 5](aufbau.md#die-lotbrucken)).

## Connecteurs, éléments de commande, brochage

La référence de brochage suivante montre quelle fonction se trouve sur quel connecteur – lors du
câblage, c'est ici qu'il faut vérifier en cas de doute.

### Référence de brochage { #pinout-referenz-complete }

Extrait de `settings-complete.h`. **Important :** les valeurs **≥ 100** sont des **canaux de
l'extenseur de ports** (PCA9555, canal = valeur − 100), et non des GPIO ESP32 directs ; `99` =
inutilisé/factice.

Cette différence a une importance pratique : un canal de l'extenseur de ports ne peut pas être
utilisé **de manière aussi universelle** qu'un vrai GPIO. Il sert essentiellement à **réagir à un
bouton** (entrée) ou à **commuter quelque chose** (sortie) – et même cela doit d'abord être
**programmé** pour tes propres extensions. Plus d'informations sur l'extenseur de ports au
[chapitre 12](../vertiefung/erweiterte-themen.md).

| Fonction | Signal | Broche |
| --- | --- | --- |
| **Audio (I²S)** | DOUT / BCLK / LRC | GPIO 25 / 27 / 26 |
| **RFID (SPI)** | CS / SCK / MOSI / MISO | GPIO 21 / 18 / 23 / 19 |
| RFID (PN5180 uniquement) | RST / BUSY / IRQ | GPIO 22 / 33 / 32 |
| **Carte SD** | SD-MMC 1 bit : CLK / CMD / D0 | GPIO 14 / 15 / 2 |
| **Molette rotative** | CLK / DT | GPIO 34 / 39 |
| Molette rotative | bouton | PE 105 |
| **Boutons** | Previous / Pause-Play / Next | PE 100 / 101 / 102 |
| Boutons | bouton 4 / bouton 5 | PE 103 / 104 |
| **Neopixel** | signal LED | GPIO 12 |
| **Alimentation** | coupure des périphériques (`POWER`) | PE 114 |
| Alimentation | amplificateur (`GPIO_PA_EN`) | PE 113 |
| **Batterie** | mesure de tension (ADC) | GPIO 35 |
| **Casque** | détection de la prise (`HP_DETECT`) | PE 108 |
| **Réveil / interruption PE** | réveil depuis la veille profonde | GPIO 36 |
| **IR (optionnel)** | récepteur IR | GPIO 5 |

!!! note "GPIO libres"
    Sur le connecteur d'extension Ext.Conn1 se trouvent les **GPIO 0, 5 et 32** encore libres. Deux
    choses à savoir : le **GPIO 0** est utilisé par l'ESP32 en interne (mode de démarrage) et ne
    devrait être utilisé à d'autres fins qu'en cas **d'urgence**. Le **GPIO 32** est la **ligne IRQ
    du PN5180**, et n'est donc libre que tant que tu **n'utilises pas le LPCD** – en mode LPCD
    (JP1/JP8), le lecteur l'occupe. Le **GPIO 5**, enfin, est l'entrée du récepteur IR optionnel.

### Les connecteurs en un coup d'œil { #die-anschlusse-im-uberblick }

Presque tout se branche via de petits **connecteurs JST-PH** – chacun a son propre nombre de
broches, ce qui évite de les confondre. Cet aperçu montre ce qui va où :

| Connecteur | Type | Pour |
| --- | --- | --- |
| Lecteur RFID | 10 broches | RC522 ou PN5180 (brochage ci-dessous) |
| Haut-parleur | 2 broches | un haut-parleur mono |
| Molette rotative | 5 broches | volume + bouton (marche/arrêt) |
| Neopixel | 3 broches | LED d'état et de progression |
| Boutons (jusqu'à 5) | 2 broches chacun | Previous, Play/Pause, Next, bouton 4/5 |
| Carte casque | 6 broches | sortie casque optionnelle |
| LED de charge externe | 2 broches | indicateur de charge optionnel sur le boîtier |
| Interrupteur d'extinction | 2 broches | véritable interrupteur optionnel |
| Batterie | 2 broches | LiPo ou LFP avec BMS |

!!! warning "Ne jamais se fier à la couleur des fils"
    Le brochage des connecteurs se base sur le **marquage imprimé sur la carte**, pas sur la couleur
    des fils d'un câble tout fait. Avant de brancher quoi que ce soit, vérifie toujours signal par
    signal en te référant au marquage de la carte.

Le brochage exact du **connecteur RFID** – 10 broches, avec les différences entre PN5180 et RC522 –
se trouve là où tu en as besoin : au
[chapitre 5 → Brochage du connecteur RFID](aufbau.md#rfid-steckerbelegung).

## Choisir les composants

Certains composants dépendent de tes propres préférences. Voici les décisions à prendre :

- **Lecteur RFID :** au choix entre le **RC522** (abordable, largement suffisant pour la plupart
  des usages) et le **PN5180** (plus sensible, portée plus grande, et prérequis pour le réveil LPCD
  optionnel). Grâce à la détection automatique (voir ci-dessous), tu ne t'engages pas via le
  firmware.
- **Carte microSD :** une carte microSD tout à fait ordinaire, formatée en **FAT32**. Les cartes à
  partir de 64 Go sont généralement formatées en exFAT en usine et doivent d'abord être reformatées
  (voir la remarque). Les cartes très grandes ou très bon marché ne fonctionnent en outre pas
  toujours de façon fiable. En cas de problème, essaie plutôt une carte différente (plus petite).
- **Batterie :** optionnelle – ESPuino fonctionne aussi durablement sur alimentation USB. Pour un
  usage mobile, le choix entre **LFP** et **LiPo** est suffisamment important pour avoir son propre
  chapitre : voir [chapitre 4 · La batterie](akku.md).
- **Haut-parleur :** selon tes goûts et la taille du boîtier ; un haut-parleur large bande de 4 ohms
  comme le Visaton FR 7 convient bien. L'amplificateur délivre au maximum **1 W** – un haut-parleur
  surdimensionné n'apporte donc rien ici.
- **Casque :** optionnel via la **carte casque** séparée (basée sur la puce MS6324,
  [forum #1099](https://forum.espuino.de/t/kopfhoererplatine-basierend-auf-ms6324-und-tda1308-bzw-lm4808m/1099),
  en allemand).

!!! info "Le type de lecteur RFID n'est plus une question de firmware"
    Auparavant, il fallait choisir la bonne variante de firmware pour RC522 ou PN5180 lors du
    flashage. Depuis mai 2026, **ESPuino détecte le lecteur automatiquement** à l'exécution. Le
    choix du lecteur est donc devenu une décision purement matérielle, dont tu n'as plus à te
    soucier lors de la mise à jour du firmware.

!!! tip "Formater les grandes cartes en FAT32"
    Les cartes à partir de 64 Go (SDXC) sont formatées en exFAT en usine. Windows ne propose pas le
    FAT32 pour des cartes aussi grandes dans sa boîte de dialogue standard – un outil comme
    « FAT32 Format » (guiformat) permet de le faire. Le [SD Card Formatter](https://www.sdcard.org/downloads/formatter/)
    officiel est pratique pour réinitialiser une carte proprement, mais il formate les grandes
    cartes en exFAT conformément à la norme SD – pour du FAT32, tu auras donc besoin en plus de
    l'outil mentionné.

## Limites de la carte

Pour que tu saches ce que la Complete ne fait volontairement *pas* :

- **Un seul amplificateur** – pas de véritable fonctionnement stéréo avec deux haut-parleurs pilotés
  séparément.
- **Pas de logique 5 V** – en interne, tout fonctionne en 3,3 V.
- **Pas de compteur coulombmétrique** – le niveau de charge est **estimé à partir de la tension de
  la batterie**, pas compté précisément. Avec le LFP en particulier, la tension reste très plate sur
  une grande partie de la décharge, ce qui rend l'affichage d'autant plus approximatif (plus de
  détails au [chapitre 4](akku.md)).

## Schémas, modèle 3D & documents

Pour aller plus loin ou concevoir un boîtier, le
[fil de discussion Complete (#3817)](https://forum.espuino.de/t/espuino-complete/3817) (forum en
allemand) contient la documentation complète – les **schémas** (rév. 5.0.1 et rév. 5.1 en PDF)
ainsi qu'un **modèle 3D** de la carte (fichier STEP). Les trous de fixation se trouvent dans les
quatre coins (⌀ 3,2 mm) ; pour les espacements exacts, le modèle 3D est la meilleure source.

## Pour les utilisateurs avancés : autres connecteurs

???+ info "Ext.Conn1, Ext.Conn2, Ext.USB et l'extenseur de ports"
    Ces connecteurs ne sont **pas nécessaires** pour un montage classique – ils sont destinés à des
    cas particuliers et certains sont laissés non peuplés en usine (peuplables sur demande).

    - **Ext.Conn1** sort des signaux supplémentaires : **3,3 V commutés** (actifs uniquement en
      fonctionnement, coupés en veille profonde), **3,3 V permanents**, **Batterie +**, les
      **GPIO 0, 5 et 32** encore libres (avec les restrictions de la remarque « GPIO libres »
      ci-dessus) et les canaux d'extenseur de ports **PE109/PE112**.
    - **Ext.Conn2** fournit **GND** et deux tensions : **OOut** (~4,6 V sous USB, sinon tension de
      la batterie ; l'USB est prioritaire) et **Vin** (identique à OOut, mais peut être coupée par
      l'interrupteur d'extinction).
    - **Ext.USB** est une entrée 5 V alternative (VUSB, GND, CC1, CC2) ; les résistances de 5,1 kΩ
      nécessaires sont déjà en place. **Attention :** cette entrée n'est **pas protégée contre
      l'inversion de polarité** – réservée aux utilisateurs expérimentés.
    - L'**extenseur de ports PCA9555** fournit des entrées/sorties supplémentaires ; il gère en
      interne, entre autres, les boutons et quelques lignes de commande, et est également abordé au
      [chapitre 12](../vertiefung/erweiterte-themen.md).

## Commander & accessoires

Tu peux te procurer la Complete et des accessoires optionnels – comme la carte casque ou le kit de
molette rotative – auprès du développeur. Ce qui est disponible et son coût figurent dans la
[liste de prix du forum (#3344)](https://forum.espuino.de/t/preisliste/3344) (en allemand).
