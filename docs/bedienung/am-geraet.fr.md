# 9 · Utilisation sur l'appareil

L'interface web sert à la configuration – mais au quotidien, tu utilises ton ESPuino directement
sur l'appareil : avec des cartes, des boutons, la molette rotative et un coup d'œil à l'anneau LED.
Ce chapitre explique comment ces éléments de commande fonctionnent ensemble et comment interpréter
les nombreux états qu'ESPuino te communique via les Neopixels.

## Modes de fonctionnement { #betriebsmodi }

ESPuino connaît trois modes de fonctionnement de base. En **mode normal**, il joue le contenu de la
carte SD comme d'habitude. En mode **source Bluetooth**, il envoie le son vers un appareil
Bluetooth, par exemple un casque. Et en tant que **récepteur Bluetooth**, ESPuino devient lui-même
le haut-parleur, sur lequel tu peux par exemple diffuser depuis ton téléphone. Tu changes de mode
via des cartes de modification ou l'interface web.

!!! note "Bluetooth et Wi-Fi"
    Le Bluetooth et le Wi-Fi fonctionnent **en parallèle** sur ESPuino. Sache simplement que cela
    consomme de la mémoire et que ce fonctionnement en parallèle n'a été que peu testé.

## Modes de lecture

Le mode de lecture d'une carte détermine *comment* son contenu est joué : un titre unique, un
dossier entier trié ou aléatoire, un livre audio avec position mémorisée, etc. Comme les modes sont
étroitement liés à l'attribution des cartes, ils y sont listés en détail, avec icône et
description : [interface web → modes de lecture](webinterface.md#abspielmodi). Les identifiants
techniques figurent dans l'[annexe](../referenz/anhang.md#playmodi).

### Modes récursifs et saut entre dossiers

Les modes de lecture **récursifs** méritent une mention particulière. Ils incluent non seulement le
dossier choisi, mais aussi ses **sous-dossiers** – triés, aléatoires, ou en mode livre audio avec
mémorisation de la position. La profondeur à laquelle ESPuino explore la structure de dossiers est
définie par la **profondeur de récursion** (0 à 4, valeur par défaut 2 ; réglable dans l'onglet
Général → Lecture).

C'est uniquement dans ces modes récursifs que fonctionne aussi le **saut de dossier** : l'action
« dossier suivant » saute au premier titre du dossier suivant, et « dossier précédent » revient en
arrière de la même façon – dans les deux cas selon l'ordre alphabétique. Les deux actions peuvent
être assignées à des boutons dans l'interface web.

!!! warning "Prudence avec le mode livre audio récursif"
    En mode livre audio récursif, la playlist est régénérée à chaque chargement. Si de nouveaux
    dossiers sont ajoutés par la suite, la position mémorisée peut s'en trouver décalée.

## Cartes de modification { #modifikationskarten }

Toutes les cartes n'ont pas à démarrer un contenu – une carte peut aussi déclencher une
**fonction**, par exemple activer une minuterie de sommeil, verrouiller les boutons ou changer la
lumière. Ces « cartes de modification » sont un outil puissant, notamment au quotidien avec des
enfants. Tu trouveras le catalogue complet lors de l'apprentissage d'une carte dans l'
[interface web](webinterface.md#modifikationskarten-alle-optionen) ; les identifiants techniques
sont listés dans l'[annexe](../referenz/anhang.md#modifikationskarten).

## Boutons et combinaisons de boutons { #tasten-und-tastenkombinationen }

La disposition suivante est celle de **sortie d'usine** – dans l'interface web (voir « disposition
dynamique des boutons »), tu peux entièrement l'adapter. Sur la [Complete](../hardware/complete.md),
les boutons sont physiquement attribués ainsi : le bouton 0 est Next, le bouton 1 est Previous, le
bouton 2 est Play/Pause, le bouton 3 est le bouton intégré à la molette rotative, et les boutons 4
et 5 sont des boutons optionnels librement assignables. Ces numéros sont fixes et ne peuvent pas
être modifiés ; mais ils n'ont d'importance que pour les développeurs, de toute façon.

Une **pression courte** et une **pression longue** déclenchent chacune des actions différentes :

| Bouton | Pression courte | Pression longue |
| --- | --- | --- |
| 0 · Next | Titre suivant | Dernier titre |
| 1 · Previous | Titre précédent | Premier titre |
| 2 · Play/Pause | Play/Pause | Play/Pause |
| 3 · Bouton de l'encodeur | Mesurer la tension de la batterie | Veille profonde |
| 4 (optionnel) | Retour rapide (n secondes) | Volume + |
| 5 (optionnel) | Avance rapide (n secondes) | Volume − |

La distance de saut des deux boutons de saut est à définir toi-même : **30 secondes** par pression
par défaut, modifiable dans l'interface web
([chapitre 8 → Molette rotative & boutons](webinterface.md#drehencoder-taster)).

S'ajoute à cela un geste particulièrement pratique : **maintenir un bouton enfoncé tout en tournant
simultanément la molette rotative.** Tant que tu maintiens le bouton, la rotation exécute l'action
spéciale de ce bouton. Par défaut, maintenir Next permet d'avancer et de reculer dans le titre en
cours, et maintenir Play/Pause règle la luminosité des LED.

Pour le défilement via la molette rotative, il existe **deux variantes** entre lesquelles choisir –
à assigner dans l'interface web
([chapitre 8 → Molette rotative & boutons](webinterface.md#drehencoder-taster)) :

| Variante | Ce qui se passe | Réglage d'usine |
| --- | --- | --- |
| **Défilement direct** | Chaque cran saute **immédiatement** en avant ou en arrière d'une durée fixe – sans affichage, sans attente. | ✔ assigné à Next |
| **Prévisualisation de position** | La lecture continue pour l'instant, seul un curseur se déplace vers la cible ; le saut ne s'effectue qu'à la fin. | – à assigner toi-même |

La **prévisualisation de position** est la plus confortable des deux, mais tu dois l'assigner
délibérément. Lorsqu'elle est active, l'anneau LED devient **jaune** dès que tu maintiens le bouton
enfoncé – avant même de commencer à tourner. En tournant, un repère **bleu** (le curseur) se déplace
alors vers la position où aboutirait le saut (si tu n'as qu'une seule LED, elle s'allume simplement
en bleu pendant ce temps). Ce n'est qu'en relâchant le bouton, ou en arrêtant de tourner pendant un
moment – environ deux secondes par défaut –, que la lecture saute réellement à cet endroit. Tu peux
ainsi viser précisément un point, plutôt que d'avancer et reculer à l'aveugle.

Avec le **défilement direct**, rien de tout cela ne se produit : les LED continuent d'afficher la
progression normale, et chaque cran saute immédiatement. C'est plus grossier – une rotation rapide
représente de nombreux crans à la fois – mais cela fonctionne aussi sur un ESPuino totalement
dépourvu de Neopixels, où une prévisualisation n'aurait rien à afficher.

Enfin, des actions peuvent être assignées à des **paires de boutons pressés simultanément**. Par
défaut, Next et Play/Pause ensemble démarrent le serveur FTP, et Previous et Play/Pause font
annoncer l'adresse IP.

!!! note "La commutation Wi-Fi est désactivée volontairement"
    La combinaison Next + Previous permettrait d'activer/désactiver le Wi-Fi – mais elle est
    **désactivée** par défaut, afin que les enfants ne coupent pas accidentellement le Wi-Fi.

## La molette rotative

En temps normal, la molette rotative règle le volume : vers la droite pour augmenter, vers la
gauche pour diminuer. Si c'est inversé chez toi, pas besoin de ressouder quoi que ce soit – il
suffit d'inverser le sens de rotation dans l'interface web. Au-delà de la simple rotation,
l'encodeur peut faire plus : le geste « maintenir et tourner » déjà mentionné, qui permet entre
autres de naviguer dans le titre en cours – soit directement, soit via la prévisualisation de
position décrite ci-dessus.

## Lire les Neopixels comme un affichage

L'anneau LED est le langage d'ESPuino – il t'indique en un coup d'œil ce qui se passe. Le nombre de
LED, le dégradé de couleurs et le sens de rotation peuvent être réglés dans l'interface web ; les
couleurs suivantes sont les valeurs par défaut.

**Au démarrage**

| Situation | Affichage LED |
| --- | --- |
| Démarrage | La moitié des LED tourne en **orange**. Suivi du mode veille – ou d'un clignotement rouge en cas de problème de carte SD. |

**En état / veille**

| Situation | Affichage LED |
| --- | --- |
| Wi-Fi connecté | Quatre LED tournant lentement en **blanc**. |
| Aucune connexion | Quatre LED tournant lentement en **vert**. |
| Recherche du Wi-Fi | Quatre LED tournant lentement en **orange**. |
| Bluetooth actif | Quatre LED tournantes en **bleu**. |
| Création de la playlist | Quatre LED tournent rapidement en **violet**. |
| Action acceptée | Bref éclat **vert** de toutes les LED. |
| Action refusée | Bref éclat **rouge** de toutes les LED. |
| Extinction (bouton maintenu) | Un cercle **rouge** grossit tant que le bouton est maintenu. |
| Boutons verrouillés | Les LED de progression deviennent **rouges**. |

*Tu ne vois les LED de connexion tournantes (blanc/vert/orange/bleu) qu'en **veille**, c'est-à-dire
quand ESPuino ne joue rien pour l'instant. Dès que la lecture démarre, l'anneau affiche à la place
la progression du titre (voir ci-dessous).*

**Pendant la lecture**

| Situation | Affichage LED |
| --- | --- |
| Progression du titre | Dégradé de couleurs (vert→rouge par défaut) sous forme de nombre de LED allumées. |
| Progression de la playlist | Des LED bleues s'éventent brièvement au début d'un titre. |
| Radio web | Deux LED tournant très lentement dans des couleurs arc-en-ciel changeantes. |
| Pause | Quatre LED **orange**. |
| Changement de volume | Barre allant du vert au rouge. |
| Annonce IP | LED **jaunes** rotatives. |

**Lors de la mesure de batterie & du transfert de données**

| Situation | Affichage LED |
| --- | --- |
| Sous-tension | Trois brefs clignotements **rouges**. |
| Consulter le niveau de charge | Une pression courte sur le bouton de l'encodeur l'affiche sous forme de barre LED. |
| Téléchargement / mise à jour du firmware | La progression défile en **bleu**. |

Plus de détails dans le
[forum #86](https://forum.espuino.de/t/was-zeigt-der-neopixel-des-espuino-alles-an/86) (en
allemand).

## Casque et profils de volume { #kopfhorer-detection-lautstarke-profile }

ESPuino peut détecter si un casque est branché et utiliser dans ce cas un volume maximal distinct –
pratique, car un casque paraît nettement plus fort qu'un haut-parleur pour un même réglage.

!!! tip "Recommandation pour le casque"
    Pour une utilisation avec casque, la **carte casque** filaire est la solution fiable et, en cas
    de doute, la recommandation à privilégier. Les casques Bluetooth (via le mode source Bluetooth)
    fonctionnent, mais sont moins fiables – quelques problèmes isolés ont été signalés.
