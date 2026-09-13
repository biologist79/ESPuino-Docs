# 7 · Premier démarrage

Ton ESPuino est assemblé, alimenté – via une alimentation USB ou, s'il en est équipé, une batterie
– et la carte SD est insérée. C'est maintenant que la musique doit sortir du haut-parleur pour la
première fois. Ce chapitre t'accompagne pas à pas dans ce premier démarrage : de la mise sous
tension à la configuration du Wi-Fi, jusqu'au moment où tu poses la première carte et où un titre
démarre. Nous allons parcourir les étapes une par une et expliquer chaque fois *pourquoi* telle
chose se produit – ainsi, en cas de doute, tu pourras juger toi-même si tout est normal.

Une hypothèse de départ : un firmware est déjà installé sur ton ESPuino. Sur la
[**Complete**](../hardware/complete.md), c'est le cas dès la sortie d'usine – tu n'as donc rien à
flasher et tu peux démarrer directement.

Si en revanche tu as **construit ton ESPuino toi-même**, le firmware vient d'abord. Il y a une
limite à connaître ici : les firmwares prêts à l'emploi ne sont générés automatiquement que pour
les rares plateformes disposant de builds tout faits (Complete, mini4L et l'ancien
`lolin_d32_pro`). Pour un montage maison différent, il n'y a donc **rien à simplement flasher** – tu
devras compiler toi-même un firmware adapté avec **VS Code et pioarduino**. La procédure est décrite
au [chapitre 13 · Mettre à jour le firmware](../firmware/aktualisieren.md) ; reviens ici ensuite.

!!! note "Le tout premier démarrage prend un moment"
    À la première mise sous tension, ESPuino crée en interne une série de réglages par défaut. Des
    messages qui ressemblent à des erreurs peuvent alors apparaître dans la console série – par
    exemple qu'une valeur n'a pas encore été trouvée. C'est normal : ces valeurs sont justement en
    train d'être créées, et au deuxième démarrage, les messages ont disparu. Ne t'en inquiète donc
    pas.

    Tout le monde n'a cependant pas accès à une console série – il te faudrait normalement un
    environnement de développement pour cela. Si tu veux malgré tout suivre en direct : l'
    [outil ESPuino Firmware Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/) apporte une
    telle console directement dans le navigateur.

## Le mode point d'accès : pourquoi ESPuino ouvre d'abord son propre Wi-Fi

Pour qu'ESPuino puisse te rendre la musique accessible sur le réseau et se laisser configurer
confortablement, il a besoin d'accéder à ton Wi-Fi. Mais au tout premier démarrage, il ne connaît
pas encore ton réseau. Pour résoudre ce problème de l'œuf et de la poule, ESPuino **ouvre son propre
réseau Wi-Fi**, auquel tu peux te connecter pour lui communiquer ensuite ton « vrai » réseau Wi-Fi.

Ce réseau de configuration s'appelle par défaut **`ESPuino`** et est d'abord ouvert, donc sans mot
de passe. Ce n'est qu'un pis-aller pour la configuration initiale, et il disparaît dès qu'ESPuino a
rejoint ton réseau Wi-Fi. (Tu pourras le renommer et le protéger par un mot de passe plus tard dans
l'[onglet Wi-Fi](../bedienung/webinterface.md#tab-wlan) – qui explique aussi pourquoi tu ne devrais
pas laisser ce point d'accès ouvert actif en permanence.) Va donc dans la sélection Wi-Fi de ton
ordinateur ou de ton smartphone et connecte-toi au réseau `ESPuino`. Une fois la connexion établie,
ESPuino attribue automatiquement une adresse à ton appareil, et tu peux ouvrir la page de
configuration dans le navigateur. Elle se trouve à l'adresse fixe **`http://192.168.4.1`**. Sur de
nombreux appareils, cette page s'ouvre même toute seule (ce qu'on appelle un « portail captif », que
tu connais peut-être des Wi-Fi d'hôtels ou de cafés) ; si ce n'est pas le cas, tape simplement
l'adresse à la main dans la barre d'adresse.

!!! tip "Si le smartphone fait des siennes"
    Certains smartphones remarquent qu'aucun internet n'est accessible via ce Wi-Fi et refusent
    silencieusement de charger la page – ou basculent même en cachette vers le réseau mobile. En
    général, une petite question apparaît alors, du style « Ce réseau Wi-Fi n'a pas d'accès internet
    – rester connecté quand même ? ». Confirme, et cela fonctionnera. Dans tous les cas, la
    configuration initiale est plus simple sur un ordinateur classique.

## Configurer le Wi-Fi

Sur la page de configuration, tu renseignes maintenant ton propre réseau Wi-Fi. Trois petites
étapes :

1. **Choisis le nom de ton réseau Wi-Fi** dans la liste des réseaux détectés. ESPuino t'indique ce
   qui est à portée, pour éviter une erreur de frappe.
2. **Saisis le mot de passe Wi-Fi.** Il est enregistré sur l'ESPuino, afin qu'il puisse se connecter
   seul par la suite.
3. **Attribue un nom d'hôte**, par exemple `espuino`. Le nom d'hôte est le nom sous lequel ton
   ESPuino apparaîtra plus tard sur le réseau – et, comme cela deviendra important dans un instant,
   le moyen le plus pratique de retrouver l'interface web. Si tu as plusieurs ESPuinos, donne à
   chacun un nom qui lui est propre et parlant (par exemple `espuino-chambre-enfant`).

Une fois enregistré, tu n'as plus besoin de redémarrer à l'aveugle en espérant que ça marche.
ESPuino teste les identifiants **immédiatement**, pendant que la page de configuration reste
ouverte, et t'affiche directement là si la connexion s'établit, si elle a échoué, ou si elle est
établie. Si cela ne fonctionne pas, corrige simplement la saisie sans devoir tout reprendre depuis
le début. Et dès qu'ESPuino est sur le Wi-Fi, l'anneau LED t'indique aussi l'état de la connexion –
la section suivante explique comment le lire.

### Lire les Neopixels comme indicateur d'état

L'anneau LED (les « Neopixels ») n'est pas qu'une décoration : c'est le canal de retour le plus
important d'ESPuino. Justement en ce moment, pendant la connexion, cela vaut le coup d'y jeter un
œil :

- **Quatre LED blanches qui tournent lentement** signifient : la connexion Wi-Fi est établie et
  ESPuino est prêt. C'est le signal que tu attends.
- **Des LED vertes**, en revanche, signifient : il n'y a (encore) aucune connexion Wi-Fi. C'est
  normal brièvement pendant la connexion ; mais si ça reste vert durablement, soit la connexion n'a
  pas abouti, soit aucun identifiant n'a encore été saisi du tout.

Si ça reste vert, ce n'est pas une raison de s'inquiéter – c'est généralement l'une des trois causes
habituelles : une faute de frappe dans le mot de passe, une trop grande distance par rapport au
routeur, ou simplement une tentative de connexion pas encore terminée. Essaie de redémarrer
l'ESPuino, rapproche-le du routeur, et si besoin, ressaisis calmement les identifiants. Un dépannage
Wi-Fi plus détaillé se trouve au [chapitre 15 · Dépannage](../hilfe/troubleshooting.md#wlan-probleme).

## Ouvrir l'interface web { #das-webinterface-offnen }

Dès qu'ESPuino est sur le Wi-Fi, tu le gères via l'**interface web** – l'écran de pilotage et de
configuration que tu ouvres simplement dans ton navigateur. Il y a deux façons d'y arriver.

La méthode pratique passe par le **nom d'hôte** que tu viens d'attribuer. Si le mDNS est actif (ce
qui est le réglage par défaut), tu accèdes à ton ESPuino via **`http://espuino.local`** – ou sous le
nom que tu as choisi. Tu n'as donc pas besoin de retenir une adresse IP. Si tu utilises une FritzBox,
tu peux aussi utiliser `http://espuino.fritz.box`. La seconde méthode consiste à saisir directement
l'**adresse IP** obtenue par ESPuino auprès de ton routeur ; tu la trouves par exemple dans la liste
des appareils de ton routeur.

!!! warning "Toujours `http://`, jamais `https://`"
    ESPuino ne parle volontairement que le **HTTP** non chiffré. Il y a une raison concrète à cela :
    le chiffrement (HTTPS/TLS) coûte pas mal de mémoire, et l'ESP32 n'en a de toute façon pas
    beaucoup en réserve – pour un appareil sur ton propre réseau domestique, le HTTP non chiffré est
    donc le choix pragmatique. Ouvre donc toujours l'adresse avec `http://`. Certains navigateurs
    ajoutent d'eux-mêmes un `https://` ; la page ne se charge alors pas, et tu dois ajouter le
    `http://` à la main.

### Petite parenthèse : adresse IP statique

Par défaut, ESPuino obtient son adresse automatiquement auprès du routeur (via DHCP), et cela
suffit amplement pour la grande majorité des usages. Si tu le souhaites, tu peux lui attribuer à la
place une adresse IP fixe – les réglages correspondants se trouvent plus tard dans l'onglet Wi-Fi.
Ce n'est cependant pas quelque chose dont tu as besoin pour le premier démarrage.

!!! warning "IP fixe : à utiliser avec précaution"
    Une configuration IP statique mal réglée (adresse, masque de sous-réseau, passerelle, DNS ne
    correspondant pas à ton réseau) peut rendre ESPuino complètement inaccessible via le Wi-Fi.
    N'utilise cette option que si tu sais ce que tu fais – en cas de doute, reste sur l'attribution
    automatique.

## Copier du contenu sur la carte SD

ESPuino joue son contenu – histoires, livres audio ou musique – depuis la carte SD. Pour qu'il
puisse la lire, la carte doit être formatée avec le système de fichiers **FAT32** – pas exFAT. Les
cartes de plus de 32 Go arrivent presque toujours en exFAT de l'usine, tu devras donc quasi
certainement les reformater d'abord en FAT32 sur un ordinateur. (Windows ne propose souvent même pas
le FAT32 pour des cartes aussi grandes dans sa boîte de dialogue standard ; un petit outil de
formatage aide alors.)

Il existe plusieurs façons de transférer des fichiers sur la carte – et pour débuter, l'ordre est
assez clair :

- **Pré-remplir sur l'ordinateur.** Retire la carte SD une fois et charge-la directement depuis ton
  ordinateur. C'est de loin le plus rapide et, pour le premier gros lot de contenu, clairement la
  méthode la plus sensée.
- **Upload web.** La méthode par défaut, pratique : tu télécharges des fichiers individuels ou des
  dossiers entiers directement dans l'interface web (onglet RFID, section Fichiers). L'upload web a
  été optimisé et est désormais **la méthode la plus rapide, même pour de grandes quantités de
  données** – jusqu'à environ **650 Kio/s** (un peu moins en mode SPI, que la Complete et la mini4L
  n'utilisent cependant pas).
- **FTP.** Une alternative par le réseau – mais peu de gens l'utilisent, et elle n'est pas optimisée
  pour la vitesse ; l'upload web est aujourd'hui généralement plus rapide. Le service doit en outre
  être activé au préalable (voir plus bas, ainsi que le
  [chapitre 8](../bedienung/webinterface.md#tab-ftp)). Utile surtout si tu travailles déjà avec un
  client FTP.
- **MediaHub.** Si tu exploites plusieurs ESPuinos, MediaHub distribue le contenu de façon
  centralisée sur le réseau (voir [chapitre 11](../inhalte/mediahub.md)).

La façon de structurer ensuite ton contenu en dossiers, afin que les modes de lecture fassent
exactement ce que tu attends, est décrite au
[chapitre 10 · Gérer les contenus](../inhalte/verwalten.md).

## Apprendre la première carte

Vient maintenant le plus beau moment : associer une carte RFID à de la musique. On parle
d'« apprentissage » parce qu'ESPuino retient *quelle* carte doit démarrer *quel* contenu. Un point
important à savoir – et surprenant pour certains : **rien** n'est écrit sur la carte elle-même.
ESPuino se contente de lire le numéro unique (l'ID) de la carte et enregistre l'association dans sa
mémoire interne – ce qu'on appelle le NVS. Tu peux donc utiliser des cartes, puces ou autocollants
RFID tout à fait courants – concrètement les normes **ISO-14443**, et (uniquement avec le lecteur
PN5180) **ISO-15693**. Ce n'est donc pas totalement « n'importe quoi », mais la grande majorité des
tags courants convient.

Voici comment procéder :

1. **Pose une carte pas encore utilisée sur le lecteur.** Dès que le lecteur RFID peut lire cette
   carte, ESPuino reconnaît immédiatement qu'il ne la connaît pas encore.
2. **Observe les Neopixels :** ils confirment la pose de la carte par un bref éclat **rouge**. Ce
   n'est pas un message d'erreur, simplement le signe « carte inconnue détectée ».
3. **Le numéro de la carte apparaît automatiquement** dans le champ correspondant de l'interface web
   – un nombre à douze chiffres. Tu n'as donc pas besoin de le saisir toi-même ; poser la carte
   suffit.
4. **Choisis dans l'explorateur de fichiers ce qui doit être joué** – un fichier unique ou un
   dossier entier. Le chemin est repris automatiquement.
5. **Définis le mode de lecture.** Il détermine *comment* le contenu est joué : un titre unique, un
   dossier entier trié ou aléatoire, un livre audio avec position mémorisée, etc. Quel mode
   correspond à quel usage est expliqué dans l'aperçu du
   [chapitre sur l'interface web](../bedienung/webinterface.md#abspielmodi).
6. **Enregistre l'association.** C'est fait – désormais, cette carte démarre le contenu choisi
   chaque fois que tu la poses. 🎉

!!! tip "Tester rapidement sans sacrifier une carte"
    Tu veux juste vérifier brièvement qu'un fichier se joue correctement ? Dans l'explorateur de
    fichiers, un clic droit (sur smartphone : appui long) sur un fichier ou un dossier permet de le
    **jouer directement** – sans avoir à apprendre de carte.

## Quelques premiers réglages utiles

Avant que l'ESPuino ne passe entre les mains d'enfants, deux petits ajustements valent la peine et
t'épargneront des soucis plus tard.

Le premier concerne le **volume**. Dans l'onglet Général, tu peux définir un volume maximal (sur une
échelle de 0 à 21), séparément pour le haut-parleur et le casque. Ainsi, la boîte ne peut pas
devenir désagréablement forte dès le départ – un réglage bienvenu, surtout avec des enfants.

Le second concerne le **FTP**, si tu envisages de l'utiliser un jour – la plupart des gens n'en ont
pas besoin, car l'upload web est plus rapide et plus pratique. Le FTP ne fonctionne pas en
permanence, et pour une bonne raison : il occuperait durablement de la mémoire qu'ESPuino peut
mieux utiliser, par exemple pour la radio web. Tu n'actives donc le service FTP qu'en cas de besoin
– soit dans l'onglet FTP, soit via une **combinaison de boutons sur l'appareil** (les Neopixels le
confirment par un bref éclat vert). Après le prochain redémarrage, le FTP est de nouveau désactivé.

## Et ensuite ?

Ton ESPuino fonctionne maintenant. Tout ce qui a été abordé ici est décrit en détail ailleurs :
l'interface utilisateur complète au [chapitre 8 · L'interface web](../bedienung/webinterface.md),
l'utilisation sur l'appareil avec tous les boutons et affichages au
[chapitre 9](../bedienung/am-geraet.md), et l'organisation de ta musique au
[chapitre 10](../inhalte/verwalten.md). Profite bien de l'écoute.
