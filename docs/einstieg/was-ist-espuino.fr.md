# 1 · Qu'est-ce qu'ESPuino ?

## L'idée de base

ESPuino est un lecteur audio piloté par RFID, à construire soi-même : tu poses une carte, et une
histoire, un livre audio ou une playlist se met à jouer. Tu retires la carte ou en poses une autre,
et le contenu change. C'est un principe d'utilisation que même les plus petits comprennent
immédiatement – et c'est justement pour cela qu'ESPuino a été conçu en premier lieu : une boîte à
histoires robuste et adaptée aux enfants, qui se passe d'écran, de compte et de cloud.

Le nom trahit son origine : au cœur du projet se trouve un microcontrôleur de la famille **ESP32**.
Autour de ce cœur s'est développé, au fil des années, un appareil étonnamment complet – avec
amplificateur, charge de batterie, affichage LED, boutons et molette rotative. ESPuino reste
malgré tout un projet ouvert, à bricoler et à construire soi-même : le code source est libre, le
matériel est documenté, et c'est toi qui décides de la taille, du volume et des couleurs de ta
boîte – la diversité possible est illustrée par la galerie
[« Zeigt her eure ESPuinos »](https://forum.espuino.de/t/zeigt-her-eure-espuinos/554) (en
allemand).

Un point est important à comprendre, car il explique bien des choses par la suite : **rien n'est
jamais écrit sur les cartes RFID elles-mêmes.** ESPuino se contente de lire le numéro unique (l'ID)
d'une carte et retient en interne quel contenu lui correspond. Tu peux donc utiliser des cartes,
puces ou autocollants RFID tout à fait courants – concrètement les normes **ISO-14443**, et
(uniquement avec le lecteur PN5180) **ISO-15693** – et réattribuer la même carte à un autre contenu
à tout moment.

## De quoi se compose un ESPuino ?

C'est la question la plus fréquemment posée – d'où un aperçu dès le départ. La liste suivante
décrit un ESPuino typique basé sur la carte
[**Complete**](../hardware/complete.md), celle sur laquelle porte ce manuel. Une grande partie de
tout cela est déjà intégrée sur la carte Complete ; tu n'as plus qu'à ajouter les éléments qui
dépendent de tes propres préférences (quel haut-parleur, quelle batterie, quel boîtier).

| Composant | À quoi ça sert, et ce qu'il faut savoir |
| --- | --- |
| **Carte Complete** | La base. Elle intègre déjà l'ESP32-WROVER, l'amplificateur, le régulateur de charge, la surveillance de tension, l'extenseur de ports et le lecteur de carte SD. |
| **Lecteur RFID** | Lit les cartes. Au choix : le RC522, abordable, ou le PN5180, plus performant. |
| **Carte microSD** | Stocke ton contenu. Doit être formatée en **FAT32** ; 32 à 64 Go suffisent généralement. |
| **Neopixels** | LED(s) adressables pour l'état et la progression – le plus souvent un anneau, mais une rangée ou même une seule LED fonctionnent aussi. Formellement optionnelles, mais en pratique **difficiles à éviter** : elles constituent le canal de retour central (connexion, progression, batterie, erreurs …). **Fortement recommandées.** |
| **Haut-parleur** | Pour le son. Un casque est possible en option via une carte casque séparée. |
| **Molette rotative + jusqu'à 5 boutons** | Le pilotage sur l'appareil lui-même ; les deux sont optionnels. La disposition par défaut prévoit trois boutons et la molette rotative. |
| **Batterie** | Pour un fonctionnement mobile (LiFePO4 ou LiPo, chacune **avec circuit de protection**). Également optionnelle – ESPuino fonctionne aussi très bien sur une simple alimentation USB. Détails au [chapitre 4 · La batterie](../hardware/akku.md). |
| **Boîtier** | Le plus souvent imprimé en 3D. Tu trouveras un modèle de référence prêt à l'emploi au [chapitre 6 · Le boîtier](../hardware/gehaeuse.md). |

Une version plus détaillée se trouve aussi dans la
[FAQ du forum](https://forum.espuino.de/t/oft-gestellte-fragen-faq/24) (en allemand).

## L'écosystème ESPuino

ESPuino, c'est plus qu'un simple dépôt de code, et il est utile de situer les différentes pièces –
tu sauras ainsi plus tard où trouver quoi :

- **[ESPuino](https://github.com/biologist79/ESPuino)** est le **firmware**, c'est-à-dire le
  logiciel qui tourne sur l'appareil. C'est le sujet de ce manuel.
- **[ESPuino-Firmware](https://github.com/biologist79/ESPuino-Firmware)** met à disposition des
  **versions de firmware prêtes à l'emploi**, que tu peux flasher sans rien compiler toi-même.
- **[MediaHub](https://github.com/biologist79/ESPuino-Mediahub)** est un composant additionnel
  optionnel permettant de gérer **de façon centralisée** les attributions de cartes de plusieurs
  ESPuinos (voir [chapitre 11](../inhalte/mediahub.md)).
- Le **[forum](https://forum.espuino.de)** est l'endroit pour poser des questions, suivre les
  annonces et échanger avec les autres. Ce manuel réunit les connaissances ; la discussion continue
  de vivre sur le forum.

## Un regard en arrière : la lignée de développement

ESPuino s'est développé sur plusieurs années, et il vaut la peine de resituer brièvement cette
évolution – d'autant que tu croiseras encore d'anciens montages sur le [forum](https://forum.espuino.de).
Au départ, il y avait de véritables montages artisanaux, où des modules individuels étaient
assemblés et câblés à la main. En sont nés des montages sur platines à bandes, puis des cartes
carrier accueillant des cartes de développement toutes faites. Le prédécesseur direct de l'actuelle
Complete est la [**mini4L**](../referenz/mini4l.md), dans laquelle était enfichée une carte ESP32
spécialement développée.

La **Complete** est le prolongement logique de cette lignée : sur le plan fonctionnel, elle offre
essentiellement la même chose que la mini4L, mais réunit tout (à l'exception de la carte casque)
sur une seule carte. Cela réduit les coûts et simplifie considérablement le montage. C'est
précisément pour cette raison que ce manuel se concentre sur la Complete ; la mini4L, en tant que
prédécesseur le plus récent, y apparaît encore, mais uniquement là où elle diffère de la Complete
([chapitre 16](../referenz/mini4l.md)). Les étapes plus anciennes ne sont pas traitées.

## Petit glossaire

Quelques termes reviennent constamment dans le manuel. Pas besoin de les apprendre par cœur –
consulte simplement cette liste en cas de doute :

| Terme | Signification |
| --- | --- |
| RFID | Carte ou tag sans contact utilisé pour démarrer un contenu. ESPuino se contente de lire l'ID ; il n'écrit jamais rien sur la carte. |
| NVS | « Non-Volatile Storage » – la mémoire interne de l'ESP32, où sont stockés les réglages et les attributions de cartes. Une mise à jour normale du firmware ne l'écrase **pas** ; tes réglages sont donc conservés. |
| HAL | « Hardware Abstraction Layer » – détermine, à la compilation, pour quelle carte (avec quelles broches) le firmware est construit ; souvent aussi appelée la **plateforme** (par ex. `complete`, `lolin_d32_pro_sdmmc_pe`, `lolin_d32_pro`). |
| Neopixel | LED(s) adressables pour l'affichage d'état et de progression. Souvent disposées en anneau ; idéalement, le nombre de LED est **divisible par quatre**, car plusieurs animations sont conçues pour cela. |
| Deep sleep | Le mode veille profonde et économe en énergie dans lequel ESPuino passe après un certain temps d'inactivité – ou quand on l'« éteint ». Une extinction réelle et complète (coupure totale de l'alimentation) n'est pas prévue par défaut, mais reste possible ; elle s'accompagne d'un temps de démarrage un peu plus long à la prochaine mise sous tension. |
| Playmode | Le mode de lecture d'une carte (titre unique, livre audio, dossier entier …). Tous les modes en détail : [chapitre 8 → Modes de lecture](../bedienung/webinterface.md#abspielmodi). |
| Carte de modification | Une carte qui ne démarre aucun contenu, mais déclenche une fonction – une minuterie de sommeil, par exemple. Toutes les actions en détail : [chapitre 8 → Cartes de modification](../bedienung/webinterface.md#modifikationskarten-alle-optionen). |
| LiPo | Batterie lithium-polymère. Tension nominale ~3,7 V, tension de fin de charge 4,2 V. Densité énergétique élevée (beaucoup de capacité pour la taille/le poids), mais plus sensible et moins durable. |
| LFP | Batterie au lithium-fer-phosphate (LiFePO₄). Tension nominale ~3,2–3,3 V, tension de fin de charge ~3,6 V. Très sûre et durable, mais densité énergétique plus faible (moins de capacité) et tension plus basse. |
