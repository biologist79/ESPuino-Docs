# 8 · L'interface web

L'interface web est le centre de contrôle de ton ESPuino. Pratiquement tout ce qui peut être
configuré se règle ici – des attributions de cartes au Wi-Fi, jusqu'aux mises à jour du firmware –
et c'est aussi de là que tu contrôles la lecture en cours. Ce chapitre te fait parcourir une fois
chaque section. Pas besoin de tout retenir d'un coup ; considère-le comme un ouvrage de référence où
tu retrouves précisément l'onglet dont tu as besoin sur le moment.

L'interface web est accessible dans le navigateur – le plus simple étant via le nom d'hôte
(`http://espuino.local` avec mDNS actif), sinon via l'adresse IP. La façon d'y accéder pour la
première fois est décrite au [chapitre 7 · Premier démarrage](../inbetriebnahme/erststart.md).

## Ce qui s'applique partout

Quelques éléments apparaissent sur chaque page, d'où cette mise au point préalable :

- Une **icône en forme de cœur** pulse en haut à droite – l'indicateur de connexion, appelé
  « heartbeat » sur le forum ([#4583](https://forum.espuino.de/t/heartbeat/4583), en allemand). Il
  surveille la connexion entre ton **navigateur web** et l'**ESPuino** : la page ouverte envoie une
  petite requête à l'appareil toutes les trois secondes ; si une réponse revient, le cœur pulse en
  vert, sinon il devient rouge. Tu sais ainsi à tout moment si la page est toujours en contact avec
  ton ESPuino.
- Un **point d'interrogation** se trouve près de nombreux champs de saisie. Un clic dessus ouvre un
  court texte d'aide – donc si tu ne sais pas ce que fait un réglage, la réponse n'est généralement
  qu'à un clic.
- L'**icône en pile** tout en haut à droite donne accès à un menu avec sélection de la langue
  (allemand, anglais, français), le **mode sombre**, les **informations** (version du firmware,
  mémoire, batterie), le **journal** (la sortie console directement dans le navigateur), ainsi que
  **redémarrer** et **éteindre**.
- L'enregistrement se fait toujours **par section**, via le bouton de la section concernée. Son
  libellé t'indique précisément ce qui sera enregistré.

## Onglet Contrôle

L'onglet Contrôle est la télécommande dans le navigateur. Tu y vois – tant que le titre ou le flux
web en fournit une – la pochette et les informations sur le titre en cours, et tu pilotes la lecture
avec les boutons de transport habituels (premier titre, précédent, play/pause, suivant, dernier). Le
**curseur de volume** agit immédiatement, et l'icône d'égaliseur ouvre trois curseurs pour les
basses, médiums et aigus.

Deux petits détails sont particulièrement pratiques : la **barre de progression** est cliquable – un
clic saute directement à l'endroit choisi dans le titre. Et via **exécuter une modification**, tu
déclenches directement n'importe quelle modification (minuterie de sommeil, répétition, verrouillage
des boutons…), sans poser aucune carte.

## Onglet RFID

<!-- Screenshot: onglet RFID -->

Cet onglet est le cœur de l'interface, car c'est là que tu associes des cartes à des contenus. Il se
compose de deux zones superposées : l'explorateur de fichiers et l'attribution proprement dite.

### L'explorateur de fichiers

L'explorateur de fichiers affiche le contenu de la carte SD. Le **champ de recherche** permet de
filtrer, l'**upload** amène des fichiers individuels ou des répertoires entiers (avec leurs
sous-dossiers) sur l'ESPuino, et un **clic droit** (sur téléphone : appui long) sur une entrée ouvre
un menu contextuel pour créer, jouer, actualiser, renommer, supprimer et télécharger.

### Attribuer une carte

Dans la section en dessous, tu attribues un contenu à une carte, en quatre étapes :

1. **Numéro de la puce RFID :** si tu poses une carte, son numéro est renseigné automatiquement. Tu
   peux aussi le saisir à la main ou utiliser une
   [carte virtuelle](https://forum.espuino.de/t/virtual-rfid-cards) (forum en allemand).
2. Dans l'onglet **Musique**, choisis un fichier ou un dossier dans l'explorateur de fichiers et
   définis le **mode de lecture** (voir le tableau). En choisissant *radio web*, le champ du chemin
   est pré-rempli avec `http://` par commodité.
3. Dans l'onglet **Modification**, tu attribues plutôt une action à la carte.
4. **Enregistrer** – terminé.

#### Modes de lecture { #abspielmodi }

Le tableau suivant liste les modes dans l'ordre où ils apparaissent dans le menu déroulant. Les
identifiants techniques correspondants figurent dans l'[annexe](../referenz/anhang.md#playmodi).

| Mode | Signification |
| --- | --- |
| 🎵 Titre unique | Exactement un fichier, une fois. |
| 🎵🔁 Titre unique (boucle) | Répète un fichier indéfiniment. |
| 🎲💤 Titre aléatoire d'un dossier, puis sommeil | Un titre aléatoire, puis veille profonde – la carte idéale pour le coucher. |
| 📖 Livre audio | Titres d'un dossier, triés – ou même un seul fichier ; **la dernière position est mémorisée**. |
| 📚 Livre audio récursif | Comme livre audio, y compris les sous-dossiers ; la position est mémorisée. |
| 📖🔁 Livre audio (boucle) | Livre audio, redémarre depuis le début après le dernier titre. |
| 📁 Tous les titres (triés) | Dossier trié, **sans** mémorisation de position. |
| 🌳 Tous les titres + sous-dossiers (récursif, trié) | Comme ci-dessus, avec sous-dossiers, sans mémorisation de position. |
| 📁🔀 Tous les titres (aléatoire) | Dossier dans un ordre aléatoire. |
| 🌳🔀 Tous les titres + sous-dossiers (récursif, aléatoire) | Aléatoire sur le dossier et ses sous-dossiers. |
| 📁🔁 Tous les titres (triés, boucle) | Trié, en continu. |
| 📁🔀🔁 Tous les titres (aléatoire, boucle) | Aléatoire, en continu. |
| 🎲📁 Sous-dossier aléatoire (trié) | Un sous-dossier aléatoire, trié. |
| 🎲📁🔀 Sous-dossier aléatoire (aléatoire) | Un sous-dossier aléatoire, aléatoire. |
| 📻 Radio web | Une URL de flux au lieu d'un fichier. |
| 📃 Liste (.m3u) | Les entrées d'un fichier `.m3u` local – fichiers et flux web mélangés. |
| 🌐 MediaHub | Le contenu **et** le mode de lecture viennent du [serveur MediaHub](../inhalte/mediahub.md) choisi. |

#### Cartes de modification – toutes les options { #modifikationskarten-alle-optionen }

Au lieu de musique, une action peut être associée à une carte. Tu retrouves d'ailleurs le même
catalogue dans l'onglet Contrôle, sous « exécuter une modification », où tu déclenches l'action
directement sans carte. Les identifiants techniques figurent dans l'[annexe](../referenz/anhang.md#modifikationskarten).

**Verrouillage & sommeil**

| Action | Effet |
| --- | --- |
| 🔒 Verrouillage des boutons | Verrouille les boutons et la molette rotative sur l'appareil, pour qu'une pression accidentelle ne déclenche rien. |
| 💤 Dormir immédiatement | Met immédiatement l'ESPuino en veille profonde. |
| 💤 Dormir après 15 min / 30 min / 1 h / 2 h | Démarre une minuterie de sommeil ; ESPuino s'éteint après le délai choisi. |
| 💤 Dormir à la fin du titre | ESPuino s'endort dès que le titre en cours se termine. |
| 💤 Dormir à la fin de la playlist | ESPuino s'endort une fois la playlist actuelle terminée. |

*Pour tous les modes de sommeil, ESPuino atténue les LED – tu vois ainsi en un coup d'œil qu'une
minuterie de sommeil est active.*

**Répétition**

| Action | Effet |
| --- | --- |
| 🔁 Répéter la playlist | Répète l'ensemble de la playlist indéfiniment. |
| 🔂 Répéter le titre | Répète le titre en cours indéfiniment. |

**Lumière, radio & services**

| Action | Effet |
| --- | --- |
| 🌙 Atténuer les LED (mode nuit) | Atténue durablement les Neopixels – agréable par exemple dans une chambre d'enfant obscurcie. |
| 📶 Wi-Fi activer/désactiver | Active ou désactive le Wi-Fi (désactivé économise l'énergie et permet un fonctionnement purement hors ligne). |
| 💡 Éclairage d'ambiance | Bascule un éclairage d'ambiance permanent des LED. |
| 📁 Activer le FTP | Démarre le service FTP (jusqu'au prochain redémarrage). |
| 🔊 Haut-parleur BT | Bascule ESPuino en **mode haut-parleur Bluetooth** (récepteur BT) : il reçoit l'audio d'un appareil appairé, par exemple le téléphone, et le restitue. |
| 🎧 Casque BT | Bascule ESPuino en **mode casque Bluetooth** (source BT) : il envoie son audio vers un casque ou un haut-parleur Bluetooth appairé. |
| 🔀 Changer de mode | Fait défiler les modes de fonctionnement dans l'ordre (normal ↔ Bluetooth). |

*Les trois actions Bluetooth ne sont disponibles qu'avec un firmware compilé avec le support
Bluetooth.*

!!! warning "« Wi-Fi activer/désactiver » peut te bloquer l'accès"
    Désactiver le Wi-Fi emporte aussi l'**interface web** avec lui – et c'est justement là que tu le
    réactiverais normalement. Le seul moyen de revenir en arrière est alors d'utiliser le même canal
    que celui utilisé pour l'éteindre : la **carte de modification** (ou une combinaison de boutons
    ou un bouton auquel tu as attribué cette action). Range donc bien cette carte avant de
    désactiver le Wi-Fi.

**Annonces**

| Action | Effet |
| --- | --- |
| 🌐 Annoncer l'adresse IP | Annonce l'adresse IP actuelle par synthèse vocale – pratique pour retrouver l'adresse de l'interface web. |
| 🕒 Annoncer l'heure | Annonce l'heure actuelle. |

**Contrôle de lecture en carte**

| Action | Effet |
| --- | --- |
| ⏯ Play/Pause | Met en pause la lecture ou la reprend. |
| ⏮ / ⏭ Titre précédent / suivant | Passe au titre précédent ou suivant. |
| ⏪ / ⏩ Premier / dernier titre | Passe au premier ou au dernier titre de la playlist. |
| 📁 Dossier suivant / précédent | Passe un dossier en avant ou en arrière (modes récursifs uniquement). |
| » / « Avance / retour de quelques secondes | Avance ou recule de quelques secondes. |

**Cartes virtuelles & divers**

| Action | Effet |
| --- | --- |
| 🏷 Carte virtuelle 01–10 | Renvoie à l'une des dix **cartes virtuelles** – des associations qu'on peut déclencher sans carte physique (par exemple via une combinaison de boutons ou MQTT). |
| 🗑 Supprimer l'association | Si tu attribues *cette* action à une carte, la prochaine fois qu'elle est posée, son association existante est supprimée. |

## Onglet Wi-Fi { #tab-wlan }

<!-- Screenshot: onglet Wi-Fi -->

Ici, tu gères tout ce qui concerne la connexion réseau. Sous **réglages Wi-Fi**, tu définis si
ESPuino choisit le réseau **le plus puissant** parmi plusieurs réseaux connus au démarrage, quel est
le **nom d'hôte**, et – pour le cas de la configuration – quel est le nom du **point d'accès**,
s'il a un mot de passe et quand il se ferme automatiquement. Sous **réseaux**, tu enregistres tes
réseaux Wi-Fi ; plusieurs peuvent être mémorisés, ce qui est pratique si l'ESPuino voyage
parfois chez les grands-parents. Tu peux aussi définir en option une **IP statique** par réseau.
Enfin, **réseaux enregistrés** liste tous les réseaux Wi-Fi mémorisés ; celui actuellement connecté
est mis en évidence, et l'icône de corbeille supprime les entrées.

!!! warning "Délai du point d'accès : merci de ne pas le laisser à 0"
    Un peu de contexte : ESPuino n'ouvre le point d'accès de configuration que s'il n'a pas pu se
    connecter à un réseau Wi-Fi connu – c'est un pis-aller pour la configuration initiale. Ce point
    d'accès est non protégé par défaut, et tant qu'il est ouvert, **n'importe qui** peut s'y
    connecter et faire ce qu'il veut dans l'interface web. S'il n'est ouvert que brièvement, c'est
    acceptable. Un délai de **0**, en revanche, signifie qu'ESPuino ne ferme **jamais** le point
    d'accès de lui-même – ce qui constitue une faille de sécurité permanente. Ne laisse donc pas
    cette valeur à 0 (ou définis au moins un mot de passe pour le point d'accès).

!!! warning "IP statique : à utiliser avec précaution"
    Ne définis une **IP statique** que si tu sais ce que tu fais. Si la configuration ne correspond
    pas à ton réseau, ESPuino peut devenir inaccessible.

## Onglet MQTT { #tab-mqtt }

*Le support MQTT est compilé par défaut, cet onglet est donc normalement présent – il ne manque que
si le firmware a été volontairement compilé sans MQTT.*

<!-- Screenshot: onglet MQTT -->

Ici, tu connectes ESPuino à ton broker MQTT, par exemple pour [Home Assistant](https://www.home-assistant.io/),
[ioBroker](https://www.iobroker.net/) ou [openHAB](https://www.openhab.org/). Tu actives le MQTT et
saisis un ClientId, un topic de base optionnel, l'identifiant de l'appareil, le serveur, en option
un nom d'utilisateur et un mot de passe, ainsi que le port. Dans le ClientId et l'identifiant de
l'appareil, tu peux utiliser le paramètre `<MAC>` – il est automatiquement remplacé par l'adresse
MAC, ce qui est précieux avec plusieurs ESPuinos. Astuce pratique : sous les champs, tu vois un
**aperçu en direct des topics** résultant de tes saisies. La liste des topics disponibles se trouve
dans l'[annexe](../referenz/anhang.md#mqtt-topics).

!!! warning "Redémarrage nécessaire"
    Les modifications des réglages MQTT ne prennent effet qu'après un redémarrage – l'interface le
    propose directement après l'enregistrement.

## Onglet FTP { #tab-ftp }

*Le support FTP est compilé par défaut, cet onglet est donc normalement présent – il ne manque que
si le firmware a été volontairement compilé sans FTP.*

<!-- Screenshot: onglet FTP -->

Ici, tu définis le nom d'utilisateur et le mot de passe pour l'accès FTP. Pour des raisons de
mémoire, le serveur FTP ne fonctionne pas en permanence : tu le démarres en cas de besoin via le
bouton **démarrer le serveur FTP** (ou sur l'appareil via une combinaison de boutons), et après le
prochain redémarrage, il est de nouveau désactivé.

!!! tip "Pour de grandes quantités de données"
    Pour de grandes quantités de données, l'**upload web est désormais le meilleur choix** – il a
    été optimisé et est aujourd'hui plus rapide que le FTP (que presque plus personne n'utilise).

## Onglet Bluetooth

*Visible uniquement si le firmware a été compilé avec le support Bluetooth.*

<!-- Screenshot: onglet Bluetooth -->

ESPuino gère le Bluetooth dans les deux sens. En mode **casque Bluetooth**, ESPuino envoie le son
vers un appareil Bluetooth – tu saisis le nom de ton casque ou, plus simple encore, tu cliques sur
**rechercher des appareils** et sélectionnes le tien dans la liste des résultats (un champ pour le
code PIN est disponible si besoin). En mode **haut-parleur Bluetooth**, ESPuino devient au contraire
lui-même l'enceinte sur laquelle tu diffuses depuis ton téléphone. En mode Bluetooth, l'onglet
affiche un bouton pour revenir au mode normal ; il suffit sinon de poser une carte RFID inconnue.

!!! note "Bluetooth et Wi-Fi"
    Le Bluetooth et le Wi-Fi fonctionnent **en parallèle**. Ce fonctionnement en parallèle est
    toutefois gourmand en mémoire et peu testé – plus de détails au
    [chapitre 9 → Modes de fonctionnement](am-geraet.md#betriebsmodi).

## Onglet Général { #tab-allgemein }

<!-- Screenshot: onglet Général -->

Les réglages généraux sont répartis visuellement en cinq sous-groupes (lecture, lecteur RFID,
molette rotative & boutons, LED, énergie). Chacun a son propre bouton d'enregistrement et de
réinitialisation, mais ne t'y trompe pas : les cinq appartiennent à **un seul** formulaire commun.
Un clic sur enregistrer sauvegarde donc **tous** les réglages généraux en une fois – pas seulement
le sous-groupe actuellement visible. Tu n'as donc pas besoin d'enregistrer chaque sous-groupe
séparément.

### Lecture { #wiedergabe }

Ici, tu règles le comportement de lecture de base. Sous **volume**, tu définis le volume de démarrage
et les valeurs maximales séparément pour le haut-parleur et le casque, ainsi qu'un volume minimal
pour que la boîte ne puisse jamais être totalement coupée. Sous **playlist**, tu choisis le mode de
tri et la profondeur de récursion maximale.

Un mot sur la **mémorisation de position** au préalable, car plusieurs options en dépendent :
ESPuino ne mémorise la dernière position écoutée qu'en **mode livre audio**, et par défaut
uniquement aux points naturels – lors de la **mise en pause** et du **changement de titre**. Les
deux options « mémoriser… » suivantes ajoutent des points de sauvegarde supplémentaires.

La section **options** est un ensemble de commutateurs de comportement – chacun dispose en plus d'un
texte d'aide accessible via le point d'interrogation :

| Option | Effet |
| --- | --- |
| Mémoriser la position à l'extinction | Sauvegarde **en plus** la position du livre audio à l'extinction. |
| Mémoriser la position au changement de carte | Sauvegarde **en plus** la position lors du passage à une autre carte. |
| Reprendre la dernière carte après redémarrage | Reprend automatiquement la dernière carte jouée après un redémarrage. |
| Pause au retrait de la carte | Met en pause quand la carte est retirée du lecteur (RC522 et PN5180 – voir l'avertissement ci-dessous). |
| Ne pas réaccepter la même carte | Ignore le fait de reposer la même carte ; option pause↔lecture au lieu d'un redémarrage. |
| Pause au volume minimal | Met en pause dès que le volume atteint le minimum. |
| Restaurer le dernier volume | Restaure le dernier volume utilisé après un redémarrage. |
| Lecture mono | Pour les montages avec un seul haut-parleur. |
| Courbe de volume | Linéaire ou logarithmique. |

Il existe en outre l'option **« Sauvegarder automatiquement la position de lecture des livres audio
longs toutes les _n_ secondes »**, qui permet à ESPuino de sauvegarder la position en mode livre
audio de façon **périodique** – pensée pour les longs chapitres (fichiers de 5 minutes ou plus),
afin qu'une coupure de courant soudaine ne coûte pas une heure entière de progression. Elle est
désactivée par défaut ; 30 à 60 secondes sont recommandées.

!!! warning "La sauvegarde périodique sollicite la mémoire flash"
    Chaque sauvegarde écrit dans la mémoire flash, qui s'use un peu à chaque écriture. Ne choisis
    donc pas un intervalle inutilement court, et n'utilise cette fonction que là où elle apporte
    vraiment quelque chose (longs livres audio). Pour des titres courts qui sauvegardent déjà à
    chaque changement de titre, elle n'apporte rien.

!!! warning "L'option « Pause au retrait de la carte » peut poser problème"
    Elle est appréciée (la carte est posée, la retirer met en pause), mais délicate : si la carte
    n'est momentanément pas détectée, la lecture se met en pause involontairement – une des causes
    les plus fréquentes de coupures sporadiques. Si cela se produit de façon peu fiable chez toi,
    réduis la distance carte-lecteur, augmente – si tu utilises un PN5180 – son délai de
    rebond (debounce), ou désactive l'option. (L'option elle-même fonctionne avec le RC522 et le
    PN5180 ; seul le réglage de rebond est réservé au PN5180.)

### Lecteur RFID

<!-- Screenshot: lecteur RFID -->

Ce sous-groupe concerne le lecteur de carte :

| Réglage | Signification |
| --- | --- |
| **LPCD PN5180** | Réveil depuis la veille profonde en posant une carte. Uniquement avec le PN5180 et les ponts de soudure correctement réglés – sur la Complete, il faut adapter les ponts **JP1/JP8** pour cela ([chapitre 5](../hardware/aufbau.md#die-lotbrucken)) ; avec le MFRC522, cette option est grisée. Limitations : [chapitre 12](../vertiefung/erweiterte-themen.md#lpcd). |
| **Type de lecteur** | *Détection automatique* (par défaut), MFRC522 (SPI ou I²C) ou PN5180. |
| **Gain MFRC522** | Sensibilité du MFRC522 (0–7, valeur par défaut 7). |
| **Délai de rebond PN5180** | Combien de temps une carte doit rester *non détectée* en continu avant d'être considérée comme retirée (valeur par défaut 500 ms). |

!!! warning "Redémarrage nécessaire"
    Les modifications de ce sous-groupe ne prennent effet qu'après un redémarrage.

### Molette rotative & boutons { #drehencoder-taster }

<!-- Screenshot: molette rotative & boutons -->

Ici, tu définis ce que font les éléments de commande. Important à comprendre : tout ce que tu
règles ici est stocké dans la mémoire interne (NVS) et **remplace la disposition par défaut inscrite
dans le firmware** – tu peux donc adapter l'ensemble de la disposition sans recompiler le firmware.

Pour la **molette rotative** elle-même, il y a l'option **inverser le sens de rotation**, si chez
toi tourner vers la droite diminue le volume au lieu de l'augmenter – ainsi que, plus bas, les
distances de saut pour le défilement. En dessous, un tableau permet d'attribuer à chacun des six
**boutons** (Btn0–Btn5) une action pour une pression courte et une pression longue ; `--` signifie
« aucune action ». Des actions peuvent en outre être attribuées à des **paires de boutons pressés
simultanément** (les 15 combinaisons possibles de 0+1 à 4+5, chacune avec une action) – pratique
pour des fonctions rarement utilisées comme le redémarrage ou le démarrage du FTP, sans sacrifier un
bouton dédié pour cela.

!!! tip "Moins, c'est souvent mieux"
    Techniquement, tu peux attribuer beaucoup de choses ici – mais personne ne retiendra une
    douzaine de combinaisons. Mieux vaut se limiter à une ou deux qui sont vraiment utiles. Pense
    aussi que les enfants, en particulier, appuient parfois joyeusement sur tous les boutons à la
    fois et déclenchent ainsi des actions à laquelle tu ne t'attends pas – ou que tu as depuis
    longtemps oubliées. Une disposition claire t'évitera bien des devinettes par la suite.

!!! danger "Piège du blocage : « désactiver le Wi-Fi » sur un bouton"
    L'une des actions sélectionnables **désactive le Wi-Fi**. Si tu l'attribues à un bouton ou à une
    combinaison de boutons et qu'elle se déclenche (peut-être accidentellement), tu te bloques
    l'accès à l'interface web – sans Wi-Fi, pas d'interface web, et sans interface web, plus aucun
    moyen de réactiver le Wi-Fi. La seule issue est alors d'**effacer la mémoire flash**, ce qui
    écrase le NVS et **fait disparaître tous les réglages**. C'est exactement pour cette raison que
    la combinaison de bascule Wi-Fi est désactivée par défaut. Si tu veux tout de même pouvoir
    basculer le Wi-Fi, mets plutôt cela sur une **carte de modification** – à condition de ne pas la
    perdre. 😄

Les actions disponibles correspondent globalement au catalogue des cartes de modification, plus
quelques actions qui n'ont de sens que comme boutons : volume plus fort/moins fort/volume initial,
afficher la tension de la batterie, arrêt et redémarrage, dormir après cinq titres, ainsi qu'un
affichage de débogage de la charge des tâches. La disposition par défaut avec laquelle ESPuino est
livré est listée au [chapitre 9 → Boutons](am-geraet.md#tasten-und-tastenkombinationen).

#### Distances de saut pour le défilement { #sprungweiten }

La distance que parcourt ESPuino en défilant dépend de *ce avec quoi* tu défiles – il y a donc deux
blocs distincts pour cela sur cette page.

**Défilement avec les boutons** concerne les boutons auxquels tu as attribué l'action « avancer » ou
« reculer ». Tu définis ici de combien de secondes une seule pression sur un bouton fait sauter la
lecture (1–120, valeur par défaut **30**).

**Défilement avec la molette rotative** concerne le geste « maintenir le bouton + tourner ». Il
existe pour cela deux variantes qui s'excluent mutuellement – celle qui s'applique se décide dans le
tableau des actions de rotation plus haut, en attribuant au geste soit « prévisualisation de
position », soit « avancer »/« reculer » :

| Variante | Réglages | Par défaut |
| --- | --- | --- |
| **Prévisualisation de position** (la plus confortable) | *Délai avant validation* – combien de temps ESPuino attend après la dernière rotation avant de sauter.<br>*Nombre de crans pour 0 à 100 %* – combien de crans couvrent l'intégralité du titre. | 2000 ms<br>40 |
| **Défilement direct** (actif par défaut) | *Distance de saut par cran* – de combien de secondes chaque cran individuel saute immédiatement. | 10 s (1–60) |

La différence entre les deux variantes en pratique est décrite au
[chapitre 9](am-geraet.md#tasten-und-tastenkombinationen). Toutes les valeurs prennent effet
**immédiatement après l'enregistrement** – aucun redémarrage n'est nécessaire pour cela.

### LED

<!-- Screenshot: LED -->

Ici, tu configures les Neopixels. La **luminosité** peut être réglée séparément pour le
fonctionnement normal, le mode nuit et l'éclairage d'ambiance. Sous **réglages LED** viennent les
détails :

| Réglage | Signification |
| --- | --- |
| Nombre de LED d'affichage | Combien de LED affichent l'état et la progression. |
| Nombre de LED de contrôle | LED supplémentaires, chacune avec une couleur librement choisie. |
| Points en veille | Nombre de points dans l'animation de veille. |
| Dégradé de progression | Teinte pour le début et la fin de l'affichage de progression. |
| Éclairage d'ambiance | Teinte et saturation de l'éclairage d'ambiance. |
| Paliers de gradation | Finesse de la gradation de luminosité. |
| Décalage de la première LED | À partir de quelle LED physique l'affichage commence (voir l'astuce). |
| Centrage en pause | Centre l'affichage de pause. |
| Sens de rotation | Inverse le sens de rotation des effets. |

!!! tip "Positionner le premier pixel"
    Si l'anneau est monté « décalé » dans le boîtier, le **décalage de la première LED** te permet
    de définir à partir de quelle LED physique l'affichage commence – tu alignes ainsi le point zéro
    de l'anneau sur ton montage, sans avoir à ressouder
    ([forum #4670](https://forum.espuino.de/t/neopixel-erstes-pixel-positionieren-geht-das/4670), en
    allemand).

Un **nombre** de LED modifié est, au passage, pris en compte par ESPuino via un redémarrage
automatique.

### Énergie

<!-- Screenshot: énergie -->

Sous **veille profonde**, tu définis après combien de minutes d'inactivité ESPuino s'endort. Si la
mesure de batterie est active, ces valeurs apparaissent sous **batterie** :

| Réglage | Signification |
| --- | --- |
| Tension d'avertissement | En dessous de cette tension, le Neopixel avertit d'une batterie faible. |
| Tension pour 0 % / 100 % | Définit les bornes de l'affichage du niveau de charge (dépend du type de batterie). |
| Tension de coupure critique | Optionnel : ESPuino s'éteint automatiquement en dessous. |
| Valeur de correction | Correction fine de la tension mesurée (± en centièmes de volt). Si l'affichage diverge d'une mesure au multimètre, saisis ici la différence. Détails au [chapitre 5 · Réglage fin](../hardware/aufbau.md#nach-dem-zusammenbau-die-feinjustierung). |
| Intervalle de mesure | À quelle fréquence la tension de la batterie est mesurée. |

## Onglet Mises à jour { #tab-updates }

<!-- Screenshot: mises à jour -->

Tu trouveras ici tout ce qui concerne la mise à jour du firmware. Tu peux soit envoyer manuellement
un fichier `firmware.bin`, soit – bien plus pratique – récupérer directement un build tout fait
depuis le dépôt via **charger le firmware depuis GitHub**. Cela est décrit en détail au
[chapitre 13 · Mettre à jour le firmware](../firmware/aktualisieren.md). La section GitHub
n'apparaît qu'avec un firmware compatible OTA.

## Onglet Outils

<!-- Screenshot: outils -->

Cet onglet concerne les attributions RFID enregistrées, qui – rappelons-le – ne se trouvent pas sur
la carte SD, mais dans la mémoire interne (NVS). Tu peux **afficher toutes les attributions** (et en
supprimer individuellement), les **exporter** en `backup.txt` et les **réimporter** (l'import
ajoute et remplace seulement, il ne supprime jamais), ou utiliser le bouton rouge pour **supprimer
toutes les attributions** (avec confirmation de sécurité). La façon d'utiliser ces fonctions pour
sauvegarder et transférer des données est décrite au
[chapitre 10 → Sauvegarde et restauration](../inhalte/verwalten.md#backup-restore-deine-kartenzuordnungen-sichern).

## Onglet Aide

<!-- Screenshot: aide -->

L'onglet Aide renvoie vers le [forum](https://forum.espuino.de) et vers la documentation de l'API
REST (Swagger) – cette dernière pour ceux qui souhaitent scripter ESPuino ou l'intégrer dans leur
domotique.
