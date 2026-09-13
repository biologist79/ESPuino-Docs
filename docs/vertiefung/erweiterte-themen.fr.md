# 12 · Sujets avancés

Tu connais maintenant les fonctions de base. Ce chapitre réunit des sujets pour celles et ceux qui
veulent tirer davantage de leur ESPuino – de l'intégration dans la domotique à l'extension
matérielle. Tu n'es pas obligé d'utiliser tout cela ; considère-le comme une boîte à outils dans
laquelle tu piocheras ce qui te convient.

## Intégrer ESPuino à la domotique (MQTT)

Tout ce qui peut être contrôlé par carte ou par bouton peut aussi être contrôlé via **MQTT** – et
inversement, ESPuino rapporte chaque action et chaque changement d'état via MQTT : le volume actuel,
le titre en cours, le mode de lecture et bien plus encore. Cela permet de l'intégrer proprement dans
une domotique, par exemple pour baisser automatiquement le volume le soir ou afficher ce qui joue
sur un tableau de bord.

La configuration se fait dans l'interface web elle-même
([chapitre 8 → Onglet MQTT](../bedienung/webinterface.md#tab-mqtt)) ; la liste complète des topics
disponibles et leur signification se trouve dans l'[annexe → Topics MQTT](../referenz/anhang.md#mqtt-topics).
Pour des systèmes concrets, des guides tout faits existent : pour **Home Assistant**, une
[intégration sur le forum](https://forum.espuino.de/t/home-assistant-integration/3763) (en
allemand), et pour **openHAB**, une configuration d'exemple dans le
[répertoire openHAB du dépôt](https://github.com/biologist79/ESPuino/tree/master/openHAB).

## Économiser l'énergie, veille profonde et autonomie de la batterie

ESPuino est conçu pour ménager la batterie. L'élément central en est la **veille profonde
automatique** : après une durée d'inactivité réglable, l'appareil passe en veille profonde et ne
consomme alors presque plus rien. Par défaut, c'est dix minutes (`maxInactivityTime`). Le compteur
fonctionne toutefois avec discernement : tant que de la musique joue ou qu'un client FTP est
connecté, ESPuino ne s'endort pas, et chaque pression sur un bouton remet la pendule à zéro.

Tu peux en outre définir une **minuterie de sommeil** – via une carte de modification ou via MQTT –
qui s'endort après une durée fixe, après le titre en cours, à la fin de la playlist ou après cinq
titres. Tu peux même consulter en direct l'état actuel de la minuterie via MQTT (topic
`sleep_timer_state`, sous forme de JSON avec mode et temps restant). Et si tu utilises ESPuino sur
batterie, tu trouveras dans l'interface web (onglet Général → Énergie) les seuils d'avertissement,
l'affichage et l'extinction automatique optionnelle en cas de tension trop basse.

## Cartes RFID virtuelles { #virtuelle-rfid-karten }

Toutes les actions n'ont pas besoin d'une carte physique. ESPuino dispose de dix **cartes
virtuelles**, avec les identifiants `900000000001` à `900000000010`. Tu leur attribues des contenus
ou des modifications dans l'interface web – exactement comme tu le ferais avec une vraie carte (tu
saisis simplement le numéro de puce à la main). Elles se déclenchent alors via un **bouton**, une
**combinaison de boutons**, ou via **MQTT**.

L'intérêt : tu peux associer des actions fréquentes à une simple pression de bouton, sans devoir
garder une carte spéciale à portée de main chaque fois – par exemple « démarrer la playlist
préférée » sur une combinaison de boutons. Plus de détails dans le
[forum #3218](https://forum.espuino.de/t/virtual-rfid-cards/3218) (en allemand).

## LPCD : réveil en posant une carte { #lpcd }

Le LPCD (Low Power Card Detection) est une fonction qui réveille ESPuino de la veille profonde dès
que tu poses une carte – plutôt que de devoir d'abord appuyer sur un bouton. Pour une boîte destinée
aux enfants en particulier, c'est une idée séduisante : poser la carte, la musique démarre, sans
détour par un bouton.

Voici ce qui se passe techniquement. En temps normal, le lecteur RFID est coupé avec tout le reste
quand ESPuino entre en veille profonde – l'objectif étant justement de consommer le moins de courant
possible. Avec le LPCD activé, il reste au contraire alimenté et vérifie de lui-même, à intervalles
courts, si une carte se trouve à proximité. S'il en trouve une, il tire sa **ligne IRQ** au niveau
GND. Cette ligne aboutit à un **GPIO compatible RTC** de l'ESP32, c'est-à-dire une broche encore
surveillée même en veille profonde – et c'est précisément ce changement de niveau qui réveille le
processeur. Du point de vue de l'ESP32, c'est le même mécanisme qu'une pression de bouton.

Ce qui se passe immédiatement après est intéressant. L'ESP32 démarre bel et bien – mais avant de
mettre en route le reste du matériel, il insère une vérification ciblée : il ne charge que les
réglages nécessaires au LPCD, met le lecteur sous tension, recherche d'abord une carte ISO-14443,
puis une carte ISO-15693, et vérifie l'identifiant trouvé dans sa mémoire interne. Ce n'est que si
une carte **connue** y est enregistrée qu'il démarre complètement et commence à jouer. Si c'était en
revanche une fausse alerte – ou qu'une carte sans contenu attribué a été posée –, il se rendort
immédiatement, avant même que les Neopixels ou le reste des périphériques ne soient activés. Tu ne
remarques donc normalement rien d'une détection erronée ; elle ne coûte qu'un peu d'énergie.

Pour que le LPCD fonctionne, plusieurs conditions doivent toutefois être réunies :

| Condition | Ce qui s'applique |
| --- | --- |
| **Lecteur** | Uniquement le **PN5180**. Le LPCD n'est pas possible avec un RC522 ; l'option ne peut alors pas être sélectionnée dans l'interface web. |
| **Firmware du PN5180** | Au moins la **version 4.0**. La version présente sur ton lecteur est indiquée par ESPuino dans le journal au démarrage. Une mise à jour du firmware du lecteur est possible, mais représente un travail non négligeable. |
| **Ponts de soudure** | Sur la [Complete](../hardware/complete.md), **JP8** et **JP1** doivent chacun être réglés sur **1+2** (voir [chapitre 5 → Les ponts de soudure](../hardware/aufbau.md#die-lotbrucken)). Le câblage standard est posé en usine, pas la variante LPCD. |
| **Connexion IRQ** | La ligne IRQ nécessite un GPIO compatible RTC. Sur la Complete, il s'agit du **GPIO 32**, qui n'est alors plus disponible pour autre chose (il occupe le connecteur Ext 1). Sur la [mini4L](../referenz/mini4l.md), `RFID_IRQ` est réglé sur `99` en usine, donc désactivé, et devrait d'abord être changé en 32. |
| **Activation** | Une case à cocher dans l'interface web sous [Général → RFID](../bedienung/webinterface.md#tab-allgemein) : **« Activer le LPCD PN5180 »**. |

Si tu construis ta propre carte, le choix de la broche IRQ est limité : sur cet ESP32, les GPIO
compatibles RTC sont **0, 4, 12, 13, 14, 15, 25, 26, 27, 32, 33, 34, 35, 36 et 39** – un seul d'entre
eux convient pour le signal de réveil.

!!! note "Plus via settings.h"
    Dans d'anciens guides – y compris le
    [fil de discussion du forum #1664](https://forum.espuino.de/t/was-ist-lpcd-und-wie-funktioniert-es/1664)
    (en allemand), qui explique par ailleurs bien la fonction – le LPCD s'active via un
    `PN5180_ENABLE_LPCD` dans `settings.h`. Ce n'est plus le cas : la fonction est désormais un
    réglage purement au moment de l'exécution, défini exclusivement dans l'interface web. Une entrée
    correspondante dans un `settings-override.h` personnel n'a plus aucun effet.

Il faut aussi garder à l'esprit que le LPCD et un **interrupteur d'extinction matériel** s'excluent
mutuellement – les deux combinés ne fonctionnent pas (voir [chapitre 3](../hardware/complete.md)).

!!! warning "Ce qu'il faut savoir avant de se lancer"
    Aussi séduisante que soit l'idée – le LPCD n'est actuellement **pas activement maintenu**, des
    utilisateurs signalent régulièrement des **problèmes de fiabilité**, et la fonction **consomme
    davantage d'énergie**, car le lecteur reste actif pendant la veille profonde.

## L'extenseur de ports PCA9555

L'ESP32 ne dispose que d'un nombre limité de broches libres (GPIO), et certaines d'entre elles ne
peuvent être utilisées qu'en entrée. Quand la place se fait rare, un extenseur de ports **PCA9555**
vient à la rescousse : il se connecte via I²C et fournit **16 canaux supplémentaires** (deux ports de
huit chacun). Sur la [Complete](../hardware/complete.md), il est déjà présent – tu en profites donc
automatiquement.

Dans la configuration ESPuino, ces canaux sont adressés avec les numéros **`100` à `115`** (le
port 0 correspond à 100–107, le port 1 à 108–115). C'est pourquoi des valeurs à partir de 100
apparaissent dans le [tableau de brochage](../hardware/complete.md#pinout-referenz-complete).
Typiquement, des entrées y sont rattachées (boutons, détection du casque, bouton de l'encodeur) ;
des sorties seulement dans des cas particuliers comme l'activation de l'amplificateur.

!!! note "Bon à savoir"
    Chaque changement sur une entrée de l'extenseur déclenche une interruption et réveille l'ESP32.
    Il est possible de se limiter à certaines broches, mais c'est un bricolage assez poussé qu'il
    faut programmer soi-même : une broche configurée en **sortie** ne déclenche plus d'interruption.
    Configurer des broches en sortie n'est cependant pas sans risque – la méthode et les précautions
    à prendre sont décrites dans le
    [forum #2613](https://forum.espuino.de/t/aufwecken-nur-ueber-drehencoder/2613) (en allemand).
    Pour l'extenseur de ports en général, voir le
    [forum #306](https://forum.espuino.de/t/einsatz-des-port-expanders-pca9555/306) (en allemand).

## Fonctionnement sans interface et en continu

Tous les ESPuinos ne sont pas des boîtes mobiles pour enfants. Certains tournent en permanence sur
une alimentation – par exemple comme radio internet dans la cuisine – ou complètement sans les
éléments de commande habituels. Les deux sont tout à fait possibles.

Pour un **fonctionnement en continu**, il faut savoir que : tant que quelque chose est en cours de
lecture – un fichier ou un flux web –, ESPuino **ne** passe **pas** en veille profonde. Une station
de radio continue donc de tourner indéfiniment. La mise en veille automatique n'intervient que
lorsque rien ne joue et qu'aucune commande n'arrive pendant un moment ; si tu ne veux pas cela du
tout, augmente en conséquence le temps d'inactivité dans l'interface web (onglet Général → Énergie).
Sur une alimentation permanente, les questions de batterie n'ont de toute façon aucune importance.

Pour un **fonctionnement sans interface physique (headless)** : boutons, molette rotative et même
les Neopixels sont tous optionnels. Un ESPuino peut être entièrement piloté via l'interface web et,
si tu le souhaites, via MQTT, et les cartes RFID fonctionnent indépendamment de cela. Grâce aux
[cartes de modification](../bedienung/webinterface.md#modifikationskarten-alle-optionen), il peut
même être piloté **entièrement par carte** – sans aucun bouton ni écran. Tu peux ainsi construire une
boîte volontairement épurée, ou intégrer ESPuino de façon transparente dans une domotique. En
théorie, presque tout est réalisable ainsi – reste à toi de décider si cela a du sens en pratique.
