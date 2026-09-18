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

## Onglet RFID { #tab-rfid }

![L'onglet RFID dans l'interface web ESPuino : explorateur de fichiers avec indicateur d'espace et champ de recherche en haut, attribution RFID avec numéro de puce, onglets Musique/Modification et mode de lecture en dessous](../assets/WebinterfaceRfid.png)

Cet onglet est le cœur de l'interface, car c'est là que tu associes des cartes à des contenus. Il se
compose de deux zones superposées : l'explorateur de fichiers et l'attribution proprement dite.

### L'explorateur de fichiers { #dateibrowser }

L'explorateur de fichiers affiche le contenu de la carte SD. Le **champ de recherche** permet de
filtrer, l'**upload** amène des fichiers individuels ou des répertoires entiers (avec leurs
sous-dossiers) sur l'ESPuino, et un **clic droit** (sur téléphone : appui long) sur une entrée ouvre
un menu contextuel pour créer, jouer, actualiser, renommer, supprimer et télécharger. Pour les
fichiers audio s'y ajoute **Définir comme alerte batterie** – le raccourci vers
l'[annonce de batterie faible](#akku-ansage).

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
| 💤 Dormir après cinq titres | ESPuino s'endort une fois cinq titres supplémentaires joués. |

*Pour tous les modes de sommeil, ESPuino atténue les LED – tu vois ainsi en un coup d'œil qu'une
minuterie de sommeil est active. À proprement parler, ils activent le **mode nuit**, qui limite en
option également le volume – voir [onglet Général](#wiedergabe).*

**Répétition**

| Action | Effet |
| --- | --- |
| 🔁 Répéter la playlist | Répète l'ensemble de la playlist indéfiniment. |
| 🔂 Répéter le titre | Répète le titre en cours indéfiniment. |

**Lumière, radio & services**

| Action | Effet |
| --- | --- |
| 🌙 Atténuer les LED (mode nuit) | Atténue durablement les Neopixels – agréable par exemple dans une chambre d'enfant obscurcie. En option, le mode nuit limite en plus le volume (voir [onglet Général](#wiedergabe)). |
| 📶 Wi-Fi activer/désactiver | Active ou désactive le Wi-Fi (désactivé économise l'énergie et permet un fonctionnement purement hors ligne). |
| 💡 Éclairage d'ambiance | Bascule un éclairage d'ambiance permanent des LED. |
| 🔆 / 🔅 Luminosité des LED plus / moins | Modifie la luminosité des Neopixels d'un cran. |
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
| 🔊 / 🔉 Plus fort / moins fort | Modifie le volume d'un cran. |

**Cartes virtuelles & divers**

| Action | Effet |
| --- | --- |
| 🏷 Carte virtuelle 01–10 | Renvoie à l'une des dix **cartes virtuelles** – des associations qu'on peut déclencher sans carte physique (par exemple via une combinaison de boutons ou MQTT). |
| 🗑 Supprimer l'association | Si tu attribues *cette* action à une carte, la prochaine fois qu'elle est posée, son association existante est supprimée. |

## Onglet Wi-Fi { #tab-wlan }

![L'onglet Wi-Fi dans l'interface web ESPuino : réglages Wi-Fi avec nom d'hôte et configuration du point d'accès, puis la gestion des réseaux en dessous](../assets/WebinterfaceWlan.png)

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

![L'onglet MQTT dans l'interface web ESPuino : champs pour ClientId, topic de base, identifiant de l'appareil, serveur, identifiants et port, puis l'aperçu en direct de tous les topics complets](../assets/WebinterfaceMqtt.jpeg)

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

![L'onglet FTP dans l'interface web ESPuino : nom d'utilisateur et mot de passe FTP, ainsi que le bouton « démarrer le serveur FTP »](../assets/WebinterfaceFtp.png)

Ici, tu définis le nom d'utilisateur et le mot de passe pour l'accès FTP. Pour des raisons de
mémoire, le serveur FTP ne fonctionne pas en permanence : tu le démarres en cas de besoin via le
bouton **démarrer le serveur FTP** (ou sur l'appareil via une combinaison de boutons), et après le
prochain redémarrage, il est de nouveau désactivé.

!!! tip "Pour de grandes quantités de données"
    Pour de grandes quantités de données, l'**upload web est désormais le meilleur choix** – il a
    été optimisé et est aujourd'hui plus rapide que le FTP (que presque plus personne n'utilise).

## Onglet Bluetooth

*Visible uniquement si le firmware a été compilé avec le support Bluetooth.*

![L'onglet Bluetooth dans l'interface web ESPuino en fonctionnement normal : uniquement le sélecteur de mode avec ses trois boutons Arrêt, Casque et Haut-parleur, Arrêt étant celui qui est rempli, et en dessous la note sur le redémarrage](../assets/WebinterfaceBluetoothAus.png)

ESPuino gère le Bluetooth dans les deux sens : il peut **envoyer** son son vers un casque, et il peut
à l'inverse devenir lui-même l'enceinte sur laquelle tu **diffuses** depuis ton téléphone. Les deux
se pilotent depuis cet onglet, via un sélecteur de mode commun placé tout en haut.

### Changer de mode

Les trois boutons **Arrêt**, **Casque** et **Haut-parleur** sont côte à côte ; celui qui est rempli
indique le mode dans lequel ESPuino fonctionne actuellement. « Arrêt » n'est pas ici un état
Bluetooth à part entière, mais simplement le fonctionnement normal depuis la carte SD.

Cliquer sur un autre mode **redémarre l'ESPuino** – la note sous les boutons le précise également.
C'est inévitable : le mode choisi est enregistré durablement et n'est évalué qu'au démarrage. Après
le basculement, il faut donc quelques secondes avant que l'interface web soit de nouveau joignable –
et ESPuino redémarrera dans ce même mode à la prochaine mise en marche, tant que tu ne le remets pas
en arrière.

### Mode casque : ESPuino émet

![L'onglet Bluetooth en mode casque : sous le sélecteur apparaissent les réglages du casque Bluetooth, avec l'indicateur de connexion affichant « Non connecté », le champ du nom de l'appareil et son bouton de recherche, le champ du code PIN d'appairage et le bouton d'enregistrement](../assets/WebinterfaceBluetoothKopfhoerer.png)

Ce n'est que dans ce mode que l'onglet affiche les réglages situés sous le sélecteur – en
fonctionnement normal et en mode haut-parleur, ils n'auraient rien à faire et restent donc masqués.

Tout en haut se trouve l'**indicateur de connexion** : une pastille colorée et, à côté, soit « Non
connecté », soit « Connecté à : … » avec le nom de l'appareil. Il est interrogé directement auprès de
l'ESPuino au chargement de la page, et non déduit d'événements que le navigateur aurait par hasard
captés. Une interface web fraîchement chargée affiche donc le bon état, même si la connexion a été
établie bien avant l'ouverture de la page.

En dessous, tu saisis le **nom de ton casque**. Le bouton **Rechercher** juste à côté est plus
commode : ESPuino explore alors les environs pendant une bonne treizaine de secondes et liste tout ce
qui se manifeste ; un clic sur la bonne entrée reprend l'appareil dans le champ du nom. La recherche
ne fonctionne qu'en mode casque – si tu l'essaies dans un autre, un message te le signale. Si ton
casque réclame un **code PIN**, saisis-le dans le champ en dessous. Et ensuite, n'oublie pas
d'**enregistrer**.

Une fois un appareil enregistré, ESPuino s'y connecte tout seul au démarrage. Si tu en choisis un
dans la liste des résultats, il réessaie **jusqu'à trois fois** à une seconde et demie d'intervalle
avant d'abandonner – les casques Bluetooth ne répondent souvent qu'à la deuxième tentative après leur
réveil.

!!! tip "Le volume se règle toujours sur l'ESPuino"
    La molette rotative, les boutons et l'interface web fonctionnent aussi en mode casque : ESPuino
    transmet le volume réglé au casque via Bluetooth. Le son, lui, sort en revanche sans traitement –
    l'égaliseur et la commutation mono ne valent que pour le haut-parleur intégré.

### Mode haut-parleur : ESPuino reçoit

![L'onglet Bluetooth en mode haut-parleur : uniquement le sélecteur avec le bouton Haut-parleur rempli, et aucun autre réglage en dessous](../assets/WebinterfaceBluetoothLautsprecher.png)

Il n'y a rien à régler ici. ESPuino s'annonce comme haut-parleur Bluetooth et tu l'appaires
normalement depuis ton téléphone ou ta tablette ; tout ce qui y est joué sort ensuite de son
haut-parleur.

Note toutefois que l'interface web **ne peut pas piloter la lecture** dans ce mode – la source est le
téléphone, pas la carte SD. Si tu essaies quand même, ESPuino te propose dans une boîte de dialogue
de revenir au mode normal.

### Revenir au mode normal

Il y a trois chemins pour cela. Le plus évident est le bouton **Arrêt** de cet onglet. Une **carte
RFID inconnue** fait tout aussi bien l'affaire : si tu poses, dans l'un des deux modes Bluetooth, une
carte qu'ESPuino ne connaît pas, il revient au mode normal. C'est la porte de sortie lorsque tu n'as
pas d'interface web sous la main. En **mode haut-parleur**, une carte musicale ordinaire suffit même :
elle met fin au fonctionnement Bluetooth et lance son contenu. Le mode casque se comporte
délibérément autrement – une carte connue y est simplement jouée dans le casque, ce qui est
précisément la raison d'être de ce mode.

!!! warning "Le Bluetooth a besoin de mémoire"
    La pile Bluetooth occupe une part considérable de la mémoire vive interne – et sur l'ESP32,
    c'est elle, et non la PSRAM, qui constitue la ressource vraiment rare. ESPuino déporte donc ce
    qui peut l'être : le tampon de 256 Ko du mode casque, par exemple, n'est alloué qu'au besoin, et
    en PSRAM. Cela peut malgré tout devenir juste, et juste signifie ici : des connexions qui
    n'aboutissent pas, ou un ESPuino qui redémarre sans prévenir. À cela s'ajoute que le Bluetooth
    et le Wi-Fi fonctionnent **en parallèle** – c'est commode, mais cela n'arrange rien et reste peu
    testé. Plus de détails au
    [chapitre 9 → Modes de fonctionnement](am-geraet.md#betriebsmodi).

## Onglet Général { #tab-allgemein }

![L'onglet Général dans l'interface web ESPuino avec ses cinq sous-groupes Lecture, Lecteur RFID, Molette rotative & boutons, LED et Énergie ; ici le sous-groupe Lecture avec les sections volume et options](../assets/WebinterfaceAllgemein.png)

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
| Limiter le volume en mode nuit | Plafonne le volume tant que le mode nuit est actif – expliqué en détail juste sous ce tableau. |
| Restaurer le dernier volume | Restaure le dernier volume utilisé après un redémarrage. |
| Lecture mono | Pour les montages avec un seul haut-parleur. |
| Paliers plus fins à faible volume | Bascule sur un calcul de volume logarithmique – utile si les paliers te semblent trop grossiers dans le bas de la plage de volume. |

L'option **« Limiter le volume en mode nuit »** mérite une explication à part. Elle est pensée pour
le cas où la boîte est emportée au lit et où le haut-parleur se retrouve juste contre l'oreille.
Lorsque tu actives le mode nuit, ESPuino retient le volume réglé à **cet instant précis** et en fait
une limite supérieure temporaire – avec un cran de marge en plus, pour qu'un livre audio un peu trop
discret puisse encore être monté légèrement. Au-delà, ce n'est plus possible, que ce soit via la
molette rotative, les boutons, l'interface web, MQTT ou le Bluetooth. Dès que tu quittes le mode
nuit, la limite est levée.

L'avantage par rapport à un maximum fixe tient au fait que les livres audio n'ont pas tous le même
niveau sonore : une valeur fixe devrait être réglée si bas qu'elle gênerait en permanence avec les
enregistrements discrets. Une limite qui suit le volume s'adapte au contraire d'elle-même à ce qui
est en cours de lecture.

!!! info "Quand le mode nuit est actif"
    Pas seulement via la carte de modification 🌙 ou un bouton configuré en ce sens : **chaque
    minuterie de sommeil** l'active également, tout comme le mode de lecture
    [🎲💤 Titre aléatoire d'un dossier, puis sommeil](#abspielmodi). La limite s'applique donc aussi,
    par exemple, quand tu poses « sommeil après 30 min ». L'option prend effet à la **prochaine**
    activation du mode nuit – un mode nuit déjà en cours conserve la limite avec laquelle il a
    démarré.

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

![Le sous-groupe Lecteur RFID dans l'onglet Général : type de lecteur, réglages MFRC522 et réglages PN5180 avec LPCD et le mot de passe de confidentialité ICODE-SLIX2](../assets/WebinterfaceRfidReader.png)

Ce sous-groupe concerne le lecteur de carte :

| Réglage | Signification |
| --- | --- |
| **LPCD PN5180** | Réveil depuis la veille profonde en posant une carte. Uniquement avec le PN5180 et les ponts de soudure correctement réglés – sur la Complete, il faut adapter les ponts **JP1/JP8** pour cela ([chapitre 5](../hardware/aufbau.md#die-lotbrucken)) ; avec le MFRC522, cette option est grisée. Limitations : [chapitre 12](../vertiefung/erweiterte-themen.md#lpcd). |
| **Type de lecteur** | *Détection automatique* (par défaut), MFRC522 (SPI ou I²C) ou PN5180. |
| **Gain MFRC522** | Sensibilité du MFRC522 (0–7, valeur par défaut 7). |
| **Intervalle de balayage MFRC522** | Temps entre deux interrogations du MFRC522, en millisecondes (valeur par défaut 100 ms). |
| **Délai de rebond PN5180** | Combien de temps une carte doit rester *non détectée* en continu avant d'être considérée comme retirée (valeur par défaut 500 ms). |
| **Mot de passe de confidentialité ICODE-SLIX2** | Mot de passe de quatre octets (valeurs hexadécimales 00–FF uniquement) pour désactiver le mode confidentialité des tags ICODE-SLIX2 protégés. |

!!! warning "Redémarrage nécessaire"
    Les modifications de ce sous-groupe ne prennent effet qu'après un redémarrage.

### Molette rotative & boutons { #drehencoder-taster }

![Le sous-groupe Molette rotative & boutons dans l'onglet Général : distances de saut pour les boutons et la molette rotative, disposition des boutons, « maintenir le bouton + tourner » et les combinaisons multi-boutons](../assets/WebinterfaceDrehencoder.png)

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

Les actions disponibles correspondent largement au catalogue des cartes de modification – les deux
listes ne diffèrent qu'à la marge. **Uniquement en bouton** : volume initial, afficher la tension de
la batterie, arrêt, redémarrage et un affichage de débogage de la charge des tâches. À l'inverse,
**uniquement en carte** : la suppression d'une affectation. Tout le reste – y compris plus fort /
moins fort et dormir après cinq titres – peut être placé au choix sur un bouton ou sur une carte. La
disposition par défaut avec laquelle ESPuino est livré est listée au
[chapitre 9 → Boutons](am-geraet.md#tasten-und-tastenkombinationen).

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

![Le sous-groupe LED dans l'onglet Général : luminosité pour le fonctionnement normal, le mode nuit et l'éclairage d'ambiance, réglages LED avec les nombres, le décalage et les trois commutateurs de comportement, et les teintes pour la progression et l'éclairage d'ambiance](../assets/WebinterfaceLed.png)

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
| Bref clignotement de toutes les LED à la reconnaissance d'une carte | Accuse réception d'une carte acceptée par un bref clignotement vert – voir ci-dessous. |

Cette dernière option mérite une phrase de plus, car elle laisse volontairement deux cas de côté.
Quand elle est active, l'anneau clignote brièvement en vert pour chaque carte **acceptée** – une
confirmation visible que seules les cartes de modification donnaient auparavant. Une carte
**inconnue** reste signalée en rouge ; ensemble, les deux donnent donc une réponse sans ambiguïté à
chaque carte posée. En revanche, une carte refusée par « Ne pas réaccepter la même carte » ne
déclenche rien – il ne s'est de toute façon rien passé.

!!! info "Pas de scintillement avec une carte laissée en place"
    Si tu utilises « Pause au retrait de la carte » et que la carte reste posée en permanence sur le
    lecteur, de mauvaises conditions radio peuvent la faire redétecter de temps à autre. C'est
    pourquoi le clignotement n'est pas lié à la détection par le lecteur, mais à une carte réellement
    acceptée – ces ratés restent ainsi invisibles.

!!! tip "Positionner le premier pixel"
    Si l'anneau est monté « décalé » dans le boîtier, le **décalage de la première LED** te permet
    de définir à partir de quelle LED physique l'affichage commence – tu alignes ainsi le point zéro
    de l'anneau sur ton montage, sans avoir à ressouder
    ([forum #4670](https://forum.espuino.de/t/neopixel-erstes-pixel-positionieren-geht-das/4670), en
    allemand).

Un **nombre** de LED modifié est, au passage, pris en compte par ESPuino via un redémarrage
automatique.

### Énergie

![Le sous-groupe Énergie dans l'onglet Général : inactivité avant veille profonde, et les réglages de batterie avec tension d'avertissement, seuils de LED de charge, valeur de correction et l'option d'extinction automatique en cas de tension critique](../assets/WebinterfaceEnergie.png)

Sous **veille profonde**, tu définis après combien de minutes d'inactivité ESPuino s'endort. Si la
mesure de batterie est active, ces valeurs apparaissent sous **batterie** :

| Réglage | Signification |
| --- | --- |
| Tension d'avertissement | En dessous de cette tension, le Neopixel avertit d'une batterie faible. |
| Tension pour 0 % / 100 % | Définit les bornes de l'affichage du niveau de charge (dépend du type de batterie). |
| Tension de coupure critique | Optionnel : ESPuino s'éteint automatiquement en dessous. |
| Valeur de correction | Correction fine de la tension mesurée (± en centièmes de volt). Si l'affichage diverge d'une mesure au multimètre, saisis ici la différence. Détails au [chapitre 5 · Réglage fin](../hardware/aufbau.md#nach-dem-zusammenbau-die-feinjustierung). |
| Intervalle de mesure | À quelle fréquence la tension de la batterie est mesurée. |

#### Annonce de batterie faible { #akku-ansage }

L'anneau Neopixel prévient bien d'une batterie vide, mais cela n'aide que si quelqu'un regarde – et
en plein milieu d'une histoire, personne ne regarde, les enfants moins que quiconque. ESPuino peut
donc aussi **annoncer** l'avertissement : il interrompt brièvement la lecture, joue un fichier audio
de ton choix, puis reprend exactement là où il s'était arrêté.

![L'explorateur de fichiers avec le menu contextuel ouvert sur un fichier MP3 ; on y voit l'entrée « Définir comme alerte batterie », entre « Jouer » et « Actualiser »](../assets/WebinterfaceAkkuWarnungFestlegen.png)

La fonction est **désactivée** d'origine. Pour l'activer, coche ici **Annoncer une batterie faible**
et saisis en dessous le chemin du fichier audio. L'[explorateur de fichiers](#dateibrowser) est plus
commode : un clic droit sur le fichier, puis **Définir comme alerte batterie** – cela renseigne le
chemin, coche la case et t'amène directement ici.

Des annonces toutes prêtes en allemand, en anglais et en français se trouvent dans le dépôt du
firmware, dans le dossier `announcements/` ; il suffit de les téléverser sur la carte SD. Les deux
commandes qui ont servi à les produire y sont également documentées – si la voix de synthèse ne te
plaît pas, tu peux donc tout aussi bien enregistrer l'annonce toi-même.

**N'annoncer qu'une fois** détermine l'insistance de l'avertissement. Sans cette option, il revient à
**chaque** mesure tant que la batterie reste sous le seuil d'alerte – donc au rythme de l'intervalle
de mesure. Avec l'option, il ne survient qu'une fois, puis de nouveau seulement lorsque la tension
est entre-temps repassée au-dessus du seuil avant de retomber en dessous. Il n'y a délibérément pas
d'option « une fois par charge » : ESPuino ne peut pas du tout détecter s'il est en charge – une
tension qui remonte peut tout aussi bien être une batterie qui se rétablit sous une charge plus
légère.

!!! info "Vue de l'extérieur, l'interruption reste invisible"
    Pendant l'annonce, le titre, la position et la progression restent figés, et la playlist, le
    numéro de piste et le mode de lecture ne sont même pas touchés. Ni l'interface web ni MQTT ne
    remarquent donc que quelque chose d'autre a été joué entre-temps.

!!! warning "Uniquement pendant une lecture en cours"
    L'annonce n'a lieu que si quelque chose est effectivement en train de jouer. Si ESPuino est
    posé sur une étagère sans être utilisé, ou s'il est en pause, rien ne se passe – il n'y aurait
    d'ailleurs aucun point de reprise. Et si le fichier indiqué est introuvable, la lecture se
    poursuit sans être dérangée ; il ne reste qu'une entrée dans le journal d'erreurs.

Avec la **webradio**, le retour fonctionne aussi, mais autrement : un flux en direct n'a pas de
position, ESPuino se reconnecte donc après l'annonce. Cela prend un court instant – sa durée dépend
de la station.

## Onglet Mises à jour { #tab-updates }

![L'onglet Mises à jour dans l'interface web ESPuino : téléversement manuel d'un firmware.bin, ainsi que « charger le firmware depuis GitHub » avec sélection de la branche](../assets/WebinterfaceUpdates.png)

Tu trouveras ici tout ce qui concerne la mise à jour du firmware. Tu peux soit envoyer manuellement
un fichier `firmware.bin`, soit – bien plus pratique – récupérer directement un build tout fait
depuis le dépôt via **charger le firmware depuis GitHub**. Cela est décrit en détail au
[chapitre 13 · Mettre à jour le firmware](../firmware/aktualisieren.md). La section GitHub
n'apparaît qu'avec un firmware compatible OTA.

## Onglet Outils

![L'onglet Outils dans l'interface web ESPuino : afficher, exporter et importer les attributions, ainsi que le bouton « supprimer toutes les attributions »](../assets/WebinterfaceTools.png)

Cet onglet concerne les attributions RFID enregistrées, qui – rappelons-le – ne se trouvent pas sur
la carte SD, mais dans la mémoire interne (NVS). Tu peux **afficher toutes les attributions** (et en
supprimer individuellement), les **exporter** en `backup.txt` et les **réimporter** (l'import
ajoute et remplace seulement, il ne supprime jamais), ou utiliser le bouton rouge pour **supprimer
toutes les attributions** (avec confirmation de sécurité). La façon d'utiliser ces fonctions pour
sauvegarder et transférer des données est décrite au
[chapitre 10 → Sauvegarde et restauration](../inhalte/verwalten.md#backup-restore-deine-kartenzuordnungen-sichern).

## Onglet MediaHub { #tab-mediahub }

![L'onglet MediaHub dans l'interface web ESPuino : ajouter un serveur de médias (nom d'affichage, adresse) et la liste des serveurs de médias enregistrés](../assets/MediahubEspuinoTab.png)

Cet onglet sert uniquement à **gérer les adresses de serveurs** – l'attribution de carte proprement
dite se fait toujours dans l'[onglet RFID](#tab-rfid). Sans serveur MediaHub en fonctionnement,
cette page ne sert à rien ; ce qu'est MediaHub et comment configurer le serveur est décrit au
[chapitre 11 · MediaHub](../inhalte/mediahub.md).

Sous **ajouter un serveur de médias**, tu attribues un **nom d'affichage** librement choisi (il
apparaîtra plus tard dans le menu déroulant lors de l'apprentissage d'une carte) ainsi que l'
**adresse** – protocole (`http://` ou `https://`) via un menu déroulant, suivi de l'hôte ou de l'IP
et du port, par exemple `192.168.1.50:8080`. Un clic sur **« enregistrer le serveur de médias »**
l'ajoute à la liste **serveurs de médias enregistrés**. Tu peux ensuite l'ouvrir directement dans sa
propre interface web via l'icône, ou le supprimer via l'icône de corbeille – les cartes déjà
apprises ne sont pas affectées et continuent de pointer vers le serveur précédent.

## Onglet Aide

![L'onglet Aide dans l'interface web ESPuino avec les liens vers le forum et la documentation Swagger de l'API REST](../assets/WebinterfaceHilfe.png)

L'onglet Aide renvoie vers le [forum](https://forum.espuino.de) et vers la documentation de l'API
REST (Swagger) – cette dernière pour ceux qui souhaitent scripter ESPuino ou l'intégrer dans leur
domotique.
