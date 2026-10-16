# 11 · Gérer plusieurs ESPuinos de façon centralisée : MediaHub

![Capture d'écran de l'interface web MediaHub : page d'aperçu avec des tuiles pour ESPuinos, cartes et attributions, nouvelles cartes, médias et réglages](../assets/Mediahub.png)
*La page d'aperçu de MediaHub : appareils, cartes et attributions, nouvelles cartes et médias en un
coup d'œil. L'interface est aussi disponible en anglais et en français (à basculer en haut à
droite) ; cette capture montre la version allemande.*

## Quel problème MediaHub résout

Tant que tu n'exploites qu'un seul ESPuino, tout est simple : tu configures tes attributions de
cartes dans l'interface web, et elles se trouvent dans la mémoire de cet unique appareil. Mais dès
que plusieurs ESPuinos se trouvent dans le foyer – un dans la chambre d'enfant, un dans le salon, un
pour la route –, la maintenance devient fastidieuse. Il faudrait apprendre chaque nouvelle carte
individuellement sur chaque appareil, et remplir chaque carte SD séparément.

C'est exactement ce problème que résout **MediaHub**. MediaHub est un composant additionnel
**optionnel** qui te permet de gérer les attributions de cartes **de façon centralisée** en un seul
endroit, au lieu de le faire séparément sur chaque appareil. Si tu n'as qu'un seul ESPuino, MediaHub
ne t'apportera sans doute pas grand-chose. En revanche, si tu en possèdes plusieurs, ou si tu
envisages d'en acquérir un autre, cela peut considérablement simplifier la gestion.
La fonction ne s'appelle volontairement pas « cloud » : MediaHub fonctionne **localement sur ton
propre réseau**, tes fichiers médias restent chez toi.

!!! info "Où trouver le guide complet"
    Ce chapitre couvre la configuration et l'utilisation en détail. Pour les détails du code source
    lui-même – par exemple si tu souhaites contribuer au développement de MediaHub – le
    [dépôt MediaHub](https://github.com/biologist79/ESPuino-Mediahub) reste la référence ; la
    discussion approfondie se déroule dans le
    [fil de discussion du forum #4607](https://forum.espuino.de/t/espuino-mediahub/4607) (en
    allemand).

## Comment ça fonctionne

MediaHub est un petit **service serveur auto-hébergé**, qui tourne sous forme de conteneur Docker
sur ton propre réseau (un Raspberry Pi suffit amplement). Il détient les attributions de cartes
centralisées et connaît tes fichiers médias – qui restent exactement là où ils se trouvent déjà dans
ta propre structure de dossiers ; MediaHub ne les copie ni ne les gère lui-même, il les monte
uniquement en **lecture seule**.

Le processus se compose de six étapes :

1. **Enregistrer le serveur MediaHub.** Dans l'interface web de l'ESPuino, saisis l'adresse de ton
   serveur MediaHub dans l'[onglet MediaHub](../bedienung/webinterface.md#tab-mediahub). Tu peux
   enregistrer plusieurs serveurs et les supprimer à nouveau sans que cela n'affecte les cartes déjà
   apprises.
2. **Apprendre une carte en mode « MediaHub ».** Dans l'[onglet RFID](../bedienung/webinterface.md#tab-rfid),
   apprends une nouvelle carte – comme mode de lecture, choisis **MediaHub**, puis en dessous, le
   serveur de médias souhaité dans la liste des serveurs enregistrés. Tu n'indiques pas de chemin
   ici ; l'ESPuino sait seulement quel serveur contacter. Tu peux t'épargner cette étape si tu as
   activé l'option
   [« Interroger directement le MediaHub sur les cartes inconnues, sans apprentissage préalable »](../bedienung/webinterface.md#mediahub-optionen)
   – la simple pose suffit alors.
3. **Première pose : enregistrement.** La première fois que tu poses la carte, l'ESPuino envoie une
   requête à MediaHub. La carte y apparaît alors comme « en attente » – avec l'ID de la carte et
   l'identifiant de l'ESPuino demandeur, mais sans contenu pour l'instant.
4. **Attribution sur MediaHub.** Dans l'interface web de MediaHub, tu associes la carte en attente à
   un contenu – un fichier, un dossier ou un flux de radio web – et définis le mode de lecture,
   exactement comme tu le ferais sinon dans l'interface web de l'ESPuino. Si tu as plusieurs
   appareils, tu peux les servir tous dans la même étape (voir plus bas).
5. **Deuxième pose : téléchargement.** La prochaine fois que la carte est posée, l'ESPuino
   redemande et reçoit cette fois un **manifeste** – la liste de tous les fichiers nécessaires. Il
   les télécharge et les stocke dans un répertoire caché sur sa propre carte SD. La lecture est
   verrouillée pendant le téléchargement ; l'anneau Neopixel affiche la progression en bleu.
6. **Lecture.** Une fois le téléchargement terminé, la lecture démarre – désormais **localement
   depuis sa propre carte SD**, indépendamment de MediaHub. Si tu modifies l'attribution plus tard
   sur MediaHub, l'ESPuino s'en aperçoit de lui-même : à la pose suivante, il joue encore l'ancienne
   version, mais compare les versions en arrière-plan et retient qu'une plus récente attend. La pose
   d'après la télécharge sans encore la jouer ; seule la suivante joue le nouveau contenu.

!!! note "Ce qui est centralisé – et ce qui ne l'est pas"
    MediaHub ne te dispense pas de **poser les cartes** : tu dois toujours poser chaque carte **une
    fois par appareil** – soit pour la faire pointer vers MediaHub à cette occasion, comme à
    l'étape 2, soit, si tu as activé l'option
    [« Interroger directement le MediaHub sur les cartes inconnues, sans apprentissage préalable »](../bedienung/webinterface.md#mediahub-optionen),
    par la simple pose. La raison : sinon, MediaHub lui-même aurait besoin de son propre lecteur RFID juste pour connaître
    l'ID de la carte. Ce qui est centralisé, c'est uniquement le **lien réel vers le contenu** –
    c'est-à-dire quels fichiers ou quel flux, et quel mode de lecture, correspondent à une carte. Tu
    maintiens cette association une seule fois sur MediaHub, et chaque appareil la récupère à partir
    de là.

## Configurer le serveur MediaHub

Pour le serveur, il te faut une machine avec **Docker** et le **plugin Compose** – un Raspberry Pi
suffit amplement.

!!! tip "Pas encore de serveur – ou jamais travaillé avec Linux ?"
    Les commandes de cette section supposent que Docker tourne déjà sur ton serveur et que tu sais
    à peu près ce qu'elles font. Si ce n'est pas le cas, commence plutôt par la section
    [Installer le serveur – depuis zéro](#server-einrichten) : elle part d'une machine vide,
    explique chaque étape et aboutit au même endroit.

MediaHub est publié sous forme d'**image prête à l'emploi**, pour `amd64`, `arm64` et `arm/v7` – ce
qui couvre aussi bien un Raspberry Pi 2 qu'un Pi 5 ou un NAS Intel. Il n'y a donc rien à compiler, et
tu n'as même pas besoin d'une copie du projet : deux fichiers suffisent.

```bash
mkdir ESPuino-Mediahub && cd ESPuino-Mediahub
curl -O https://raw.githubusercontent.com/biologist79/ESPuino-Mediahub/main/docker-compose.yml
curl -o .env https://raw.githubusercontent.com/biologist79/ESPuino-Mediahub/main/env-example
docker compose up -d
```

Du dossier pour la base de données, tu n'as pas à t'occuper : le conteneur le crée au premier
démarrage et le confie à son propre compte de service avant d'abandonner ses privilèges.

L'astuce : tes réglages personnels se trouvent dans le fichier `.env`, pas dans le
`docker-compose.yml`. Ne modifie que le `.env` – tu peux alors remplacer le `docker-compose.yml` par
une version plus récente à tout moment sans perdre tes réglages.

### Le fichier `.env` { #die-env-datei }

| Variable | Par défaut | Signification |
| --- | --- | --- |
| `MEDIAHUB_TAG` | `latest` | Quelle version de l'image tourne. `latest` suit l'état de développement ; une valeur comme `sha-4a86674` fixe un état précis et constitue le chemin du retour si une modification pose problème. |
| `MEDIAHUB_PORT` | `8080` | Port sur lequel MediaHub est accessible. Choisis-en un autre s'il est déjà utilisé. |
| `MEDIAHUB_DATA` | `./data` | Emplacement de stockage de la base de données MediaHub (`db.json`). Le dossier a besoin d'un accès en écriture. |
| `MEDIAHUB_MEDIA` | `./media` | Chemin vers ta collection de médias existante. Montée en **lecture seule** – MediaHub n'y crée ni n'y modifie jamais rien. |
| `MEDIAHUB_NAME` | `espuino-mediahub` | Nom du conteneur, par exemple pour `docker logs <nom>`. Utile seulement si tu veux faire tourner plusieurs MediaHubs sur la même machine. |
| `MEDIAHUB_UID` / `MEDIAHUB_GID` | `33` / `33` | ID utilisateur/groupe avec lequel le service s'exécute (par défaut : `www-data`). Règle-les sur l'ID qui possède ta collection et tout ajustement des droits de fichiers devient inutile. |
| `TZ` | `Europe/Berlin` | Fuseau horaire du conteneur, utilisé par exemple pour des horodatages comme « vu pour la dernière fois ». |

!!! tip "Fichiers visibles mais pas lisibles ?"
    Le listage d'un répertoire et la lecture d'un fichier sont deux droits Unix distincts : un titre
    peut apparaître dans l'arborescence des fichiers, mais échouer quand même avec « permission
    denied » lors de l'attribution, si le fichier lui-même n'est pas lisible par l'UID de MediaHub.
    Soit `chmod -R o+rX /chemin/vers/ta/bibliotheque` corrige cela, soit tu règles
    `MEDIAHUB_UID`/`MEDIAHUB_GID` dans `.env` sur l'UID/GID qui possède déjà ta bibliothèque
    (`id -u` / `id -g`).

Après le démarrage, vérifie avec `docker compose ps` si le conteneur fonctionne, et ouvre MediaHub
dans ton navigateur à l'adresse `http://<ton-ip>:8080`.

!!! warning "Le HTTPS n'est pas recommandé"
    Si tu as vraiment besoin de chiffrement, place un reverse proxy devant (Traefik, par exemple).
    Pour la connexion **entre l'ESPuino et MediaHub**, en revanche, le HTTPS est une mauvaise idée :
    cela coûte de la mémoire déjà limitée sur l'ESP32 et réduit sensiblement le débit – en clair, tu
    obtiens environ 650–700 Ko/s, chiffré nettement moins.

## Installer le serveur – depuis zéro { #server-einrichten }

La section ci-dessus suppose que Docker tourne déjà sur ton serveur et que la ligne de commande te
soit familière. Si ce n'est pas le cas, cette section te prend en charge bien plus tôt. Elle va d'un
Raspberry Pi tout neuf et encore vide jusqu'à un MediaHub en service, en expliquant au passage les
notions qui comptent – et si tu as un NAS Synology ou QNAP, ou si Docker tourne déjà ailleurs chez
toi, la section suivante te dit quelles étapes tu peux t'épargner. Aucune connaissance préalable de
Linux n'est nécessaire ; ce n'est pas non plus un cours complet sur Linux. Ce qui est expliqué, c'est
ce que tu dois comprendre pour cet usage précis.

Compte une demi-heure à une heure, dont une bonne part en attente : la carte s'écrit, le système se
met à jour et l'image du conteneur se télécharge. Si tu restes bloqué en route, l'[aperçu des
commandes](#docker-befehle) à la fin de la section t'aidera.

### Le matériel que tu as peut-être déjà suffit

Avant d'acheter quoi que ce soit : un Raspberry Pi qui ne fait tourner **que** MediaHub est largement
sous-employé. Le service se résume à un seul conteneur qui, la plupart du temps, ne fait rien du
tout – il ne se réveille que lorsqu'un ESPuino signale une carte ou que tu modifies quelque chose
dans le navigateur.

C'est exactement à cela que sert Docker : une même machine peut faire tourner autant de conteneurs
côte à côte que la mémoire et la puissance de calcul le permettent – chacun avec ses propres
dépendances et sans se disputer avec les autres. Un
[Pi-hole](https://pi-hole.net/){ target="_blank" rel="noopener" },
[Home Assistant](https://www.home-assistant.io/){ target="_blank" rel="noopener" }, un
[Paperless-ngx](https://github.com/paperless-ngx/paperless-ngx){ target="_blank" rel="noopener" },
une station météo, et MediaHub avec eux. La mémoire est la limite que tu atteindras en premier – sur
un Pi doté d'1 Go, c'est plus vite fini que sur un modèle à 8 Go. MediaHub lui-même fait partie des
colocataires sobres : un processus Python à deux ouvriers, qui ne calcule rien en arrière-plan. Et
chaque service a besoin de son propre port (pour MediaHub, via `MEDIAHUB_PORT` dans le `.env`).

À l'inverse, cela signifie : **si Docker tourne déjà quelque part chez toi** – sur un Pi, sur un
petit serveur, dans une machine virtuelle –, tu n'as besoin que des étapes 5 à 7 de ce guide.

**Et ce n'est pas forcément un Raspberry Pi.** Qui possède un NAS a déjà le matériel qu'il faut à la
maison : une machine qui tourne de toute façon 24 heures sur 24 et sur laquelle la collection est le
plus souvent déjà stockée. Sur les modèles du commerce, Docker est un paquet que tu installes depuis
l'interface web – Synology l'appelle « Container Manager », QNAP « Container Station », et les autres
constructeurs de façon comparable. Si ton NAS repose sur un montage maison, par exemple
[OpenMediaVault](https://www.openmediavault.org/){ target="_blank" rel="noopener" },
[Unraid](https://unraid.net/){ target="_blank" rel="noopener" } ou
[TrueNAS](https://www.truenas.com/){ target="_blank" rel="noopener" }, Docker est soit déjà présent,
soit ajouté en quelques clics. Dans tous ces cas, les étapes 1 à 4 disparaissent entièrement :
système d'exploitation, accès SSH et installation de Docker sont déjà réglés.

Quatre remarques à ce sujet :

- MediaHub est publié sous forme d'image prête à l'emploi : il n'y a donc rien à compiler.
  L'interface du NAS suffit alors : tu y crées un « projet », tu y colles le `docker-compose.yml` du
  projet et tu le démarres. L'image est récupérée automatiquement au premier démarrage.
- Les réglages de ton `.env` (nous y venons) peuvent en général être saisis directement comme
  variables d'environnement dans ces interfaces, au lieu d'entretenir un fichier. Les deux se
  valent.
- La question des droits de fichiers de l'étape 6 ne t'est pas épargnée sur un NAS non plus. Là-bas,
  c'est l'identifiant d'utilisateur et de groupe du partage qui décide de ce que le conteneur a le
  droit de lire.
- Si l'interface du NAS ne s'accommode pas du fichier Compose, passe par SSH : Docker sur un NAS,
  c'est le même Docker, et les commandes des étapes 5 à 7 s'appliquent sans changement.

### Ce qu'il te faut

Si tu optes pour un Raspberry Pi, voici ce que cela demande :

| Élément | Remarque |
| --- | --- |
| **Raspberry Pi 2 ou plus récent** | MediaHub est si peu exigeant que même un vieux Pi 2 suffit. Attention simplement : les systèmes 64 bits ne sont proposés qu'à partir du Pi 3 – sur un Pi 2, tu prendras la variante 32 bits à l'étape 1, que l'image MediaHub couvre également. |
| **Alimentation d'origine** | La cause la plus fréquente de Raspberry Pi apparemment défectueux, ce sont les chargeurs de téléphone trop faibles. |
| **Carte microSD, 16 Go** | Le système et l'image du conteneur ne demandent ensemble que quelques gigaoctets. Si tu laisses le Pi allumé en permanence, un SSD sur le port USB durera plus longtemps – les cartes SD finissent par mourir des nombreuses écritures. Si ce doit malgré tout être une carte, prends un modèle conçu pour l'écriture continue : vendus sous les mentions « High Endurance » ou « Pro Endurance », destinés en principe aux dashcams et aux caméras de surveillance, ils encaissent plusieurs fois plus. |
| **Réseau** | Par câble réseau ou en Wi-Fi. Pour un serveur qui distribue des fichiers audio, la première option est, dans le doute, le choix le plus stable. |
| **Un ordinateur** | Il te sert à écrire la carte, puis à piloter le Pi à distance. |

Écran, clavier et souris ne sont **pas nécessaires sur le Pi**. Il se pilote par le réseau dès le
premier instant – ce qui est de toute façon la norme pour un serveur destiné à finir dans un coin.

### Ce qu'est Docker, au fond

MediaHub est un programme Python et a besoin de plusieurs briques dans des versions précises : Python
lui-même, le framework web Flask, un serveur web et quelques bibliothèques de plus. Mettre tout cela
en place à la main sur un Pi est possible, mais fastidieux – et il faut tout reprendre à chaque mise
à jour.

C'est précisément à cela que sert Docker. L'idée : ce n'est pas toi qui prépares l'environnement,
c'est un fichier texte du projet (le `Dockerfile`) qui le décrit – « prends Python 3.12, installe ces
paquets, démarre ce programme ». Cette description est exécutée une fois, et le résultat est une
**image** : un modèle fini et immuable. Pour MediaHub, cela ne se passe pas sur ta machine mais
automatiquement chez GitHub, après chaque modification du projet. Le résultat est déposé dans un
**registre** – un entrepôt d'images, ici celui de GitHub lui-même. Il ne te reste qu'à le
télécharger.

Quand tu démarres une image, il en naît un **conteneur** – en gros un petit ordinateur cloisonné qui
contient exactement ce seul programme et rien d'autre. Contrairement à une machine virtuelle, il
n'embarque toutefois pas son propre système d'exploitation : il utilise le noyau du Pi. C'est
pourquoi il consomme très peu de ressources et démarre en quelques secondes.

Pour toi, trois points comptent là-dedans :

- **Le conteneur est jetable.** Tu peux le supprimer et le recréer à tout moment, et c'est exactement
  ce qui se produit à chaque mise à jour. Rien n'est perdu au passage, tant que les données se
  trouvent à l'extérieur – voir le point suivant.
- **Ce qui doit survivre réside dans un volume.** Un volume est un dossier du Pi passé à l'intérieur
  du conteneur. MediaHub en utilise deux : `data` (la base de données, en écriture) et `media` (ta
  collection, passée en lecture seule). Tout le reste, dans le conteneur, est éphémère.
- **Le conteneur ne voit que ce que tu lui passes.** C'est un gain de sécurité, mais c'est aussi le
  piège le plus fréquent de tous : un chemin que tu n'as pas déclaré comme volume n'existe pas pour
  MediaHub – même s'il est parfaitement présent sur le Pi.

Reste **Compose**. Un conteneur a besoin d'un bon nombre d'indications au démarrage : quelle image,
quel port, quels volumes, sous quel utilisateur, ce qui doit se passer après un redémarrage. Plutôt
que de t'imposer tout cela sous forme de ligne de commande interminable, MediaHub le consigne dans le
fichier `docker-compose.yml`. La commande `docker compose` le lit et applique ce qui y est écrit. Tu
ne tapes donc jamais que des commandes courtes, et la configuration reste consultable dans un
fichier.

!!! note "`docker compose` ou `docker-compose` ?"
    Compose était autrefois un programme distinct, appelé avec un trait d'union
    (`docker-compose up`). Aujourd'hui c'est un **plugin**, donc une sous-commande de Docker
    lui-même, sans trait d'union (`docker compose up`). Des guides plus anciens sur le Web utilisent
    encore l'ancienne orthographe. Si tu emploies les commandes indiquées ici, tu es du bon côté.

### Étape 1 · Écrire le système d'exploitation sur la carte

Télécharge le [Raspberry Pi Imager](https://www.raspberrypi.com/software/) – il existe pour Windows,
macOS et Linux. Il télécharge le système d'exploitation et l'écrit sur la carte SD.

Le détail du déroulement est mieux montré par la
[documentation](https://www.raspberrypi.com/documentation/computers/getting-started.html) officielle
et par d'innombrables vidéos qu'un chapitre de manuel ne saurait le faire. Seules deux décisions nous
importent ici :

**Le bon système d'exploitation.** Sous « Raspberry Pi OS (other) », choisis la variante **Raspberry
Pi OS Lite (64-bit)**. « Lite » signifie : sans interface graphique. Ce n'est pas une privation,
c'est souhaitable pour un serveur – ce qui n'est pas installé ne consomme pas de mémoire et ne
demande pas de mises à jour. Le Pi se pilote de toute façon en ligne de commande. Sur un Pi 2 ou un
modèle encore plus ancien, choisis plutôt **Raspberry Pi OS Lite (32-bit)** : les images 64 bits ne
sont proposées qu'à partir du Pi 3, et Docker fonctionne tout aussi bien sur la variante 32 bits.

**Les préréglages avant l'écriture.** L'Imager demande s'il doit personnaliser l'installation. Dis
oui et renseigne :

- **Nom d'hôte** – par exemple `mediahub`. Le Pi est alors le plus souvent joignable sur le réseau
  domestique sous `mediahub.local`, et tu n'as pas d'adresse IP à retenir.
- **Nom d'utilisateur et mot de passe** – au choix. Un utilisateur prédéfini `pi` avec le mot de
  passe `raspberry` n'existe plus depuis quelques années ; sans cette saisie, le Pi ne démarrerait
  même pas la première fois.
- **Wi-Fi** avec le pays, si tu n'utilises pas de câble réseau.
- **Activer SSH**, avec authentification par mot de passe.

Ces indications sont écrites directement sur la carte. Le Pi se raccroche ainsi lui-même au réseau
dès son tout premier démarrage et se pilote immédiatement à distance – sans la case SSH, il
resterait muet et il te faudrait finalement un écran.

Ensuite : la carte dans le Pi, le câble réseau branché, l'alimentation branchée. Le premier démarrage
prend une à deux minutes, le temps que le système de fichiers soit étendu à la taille de la carte.

!!! tip "Réserver une adresse fixe dans la box"
    Chaque ESPuino mémorise ensuite l'**adresse** de son MediaHub. Si le Pi reçoit de la box une
    autre adresse IP lors d'un redémarrage, tes appareils ne le trouvent plus. Réserve-lui donc une
    adresse IP fixe dans les réglages de la box (généralement « réservation DHCP » ou « toujours
    attribuer la même adresse IPv4 »). Ce sont cinq minutes de travail qui t'épargnent plus tard une
    recherche de panne déroutante.

### Étape 2 · La première connexion en SSH

**SSH** est une télécommande chiffrée pour la ligne de commande : tu tapes sur ton ordinateur, et
tout est exécuté sur le Pi. Ouvre pour cela un terminal – sous macOS l'application « Terminal », sous
Windows PowerShell ou Windows Terminal, sous Linux ton terminal habituel – puis saisis (avec ton nom
d'utilisateur et ton nom d'hôte) :

```bash
ssh utilisateur@mediahub.local
```

À la toute première connexion, SSH demande si tu fais confiance à la machine et affiche une
« empreinte ». Confirme par `yes`. Le mot de passe t'est ensuite demandé. Que **rien** ne s'affiche
pendant la saisie – pas même des astérisques – est normal et n'est pas une erreur : continue
simplement à taper, puis appuie sur Entrée.

Si une ligne du genre `utilisateur@mediahub:~ $` t'accueille, tu es entré. Le `~` est l'abréviation
de ton répertoire personnel, soit `/home/utilisateur` en entier – le répertoire dans lequel tu as le
droit d'écrire en tant qu'utilisateur ordinaire, et celui où nous installerons MediaHub tout à
l'heure. L'abréviation vaut partout, pas seulement dans la ligne d'accueil : `cd ~` t'y ramène à tout
moment, et `~/ESPuino-Mediahub` désigne le même dossier que
`/home/utilisateur/ESPuino-Mediahub`. Avec `exit`, tu peux terminer la session à tout moment.

!!! tip "`mediahub.local` ne fonctionne pas ?"
    La résolution des noms en `.local` ne fonctionne pas de façon fiable sur tous les réseaux ni sur
    tous les ordinateurs. Dans ce cas, regarde dans la liste des appareils de ta box quelle adresse
    IP le Pi a reçue, et connecte-toi à celle-ci : `ssh utilisateur@192.168.1.50`.

Un terme qui va revenir sans cesse à partir de maintenant : **`sudo`**. En tant qu'utilisateur
ordinaire, tu n'as délibérément pas le droit de modifier le système. On place `sudo`
(« superuser do ») devant une commande isolée pour l'exécuter avec les droits d'administrateur ; de
temps à autre, ton mot de passe est demandé au passage. L'administrateur, soit dit en passant,
s'appelle **`root`** sous Linux et porte l'identifiant utilisateur 0 – tout lui est permis, et c'est
précisément pour cela qu'on ne travaille pas en permanence sous son identité. Tout ce qui modifie le
système lui-même – installer des paquets, changer le propriétaire de dossiers – nécessite `sudo`.
Tout le reste fonctionne volontairement sans.

### Étape 3 · Mettre le système à jour

Raspberry Pi OS gère ses logiciels avec **apt** – une sorte de magasin d'applications pour la ligne
de commande, qui installe les programmes depuis des sources vérifiées et les maintient à jour.
Commence par :

```bash
sudo apt update
sudo apt full-upgrade -y
```

La première commande ne récupère que les listes de paquets à jour (« qu'y a-t-il de neuf ? »), la
seconde installe effectivement les mises à jour. Le `-y` répond oui par avance aux questions. Tu
n'as rien d'autre à installer ici : MediaHub lui-même arrive sous forme d'image prête à l'emploi, et
l'outil pour la télécharger (`curl`) est déjà inclus dans l'image Lite.

Si la mise à jour comportait un nouveau noyau, redémarre le Pi une fois, puis reconnecte-toi en SSH :

```bash
sudo reboot
```

### Étape 4 · Installer Docker

Docker met à disposition, pour l'installation, un script officiel qui configure la source de paquets
et installe tous les éléments nécessaires :

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

La première ligne télécharge le script (`curl` est un outil de téléchargement en ligne de commande),
la seconde l'exécute. Ensuite, Docker lui-même, son outil en ligne de commande, le service en
arrière-plan et les plugins **buildx** et **compose** sont installés – `docker compose` est donc
disponible sans installation supplémentaire.

!!! note "Pourquoi pas simplement `apt install docker.io` ?"
    Parce que ce paquet n'apporte pas le plugin Compose, alors que c'est précisément avec Compose
    que MediaHub est démarré. Et oui : le script ci-dessus télécharge un fichier depuis Internet et
    l'exécute avec les droits d'administrateur. C'est le script officiel de Docker, et pour un
    serveur domestique c'est la voie habituelle. Qui veut être plus rigoureux configure la source de
    paquets à la main en suivant la
    [documentation Docker](https://docs.docker.com/engine/install/debian/) – le résultat est le même.

Pour ne pas avoir à faire précéder chaque commande Docker d'un `sudo`, ajoute-toi au groupe
`docker` :

```bash
sudo usermod -aG docker $USER
```

Qui appartient à ce groupe peut piloter Docker – et donc, de fait, tout faire sur la machine. Pour un
serveur domestique, c'est l'usage courant ; sur une machine à plusieurs utilisateurs, tu y
regarderais de plus près. L'appartenance au groupe ne prend par ailleurs effet qu'à une **nouvelle
connexion**. Termine donc la session avec `exit` et reconnecte-toi en SSH. Vérifie ensuite que tout
est en place :

```bash
docker --version
docker compose version
```

Les deux commandes doivent afficher un numéro de version. Si c'est le cas, les fondations sont
posées.

### Étape 5 · Télécharger et configurer MediaHub

Le programme lui-même, tu n'as pas à le télécharger – il se trouve dans l'image prête à l'emploi que
Docker va chercher tout seul à l'étape suivante. Ce qu'il te faut, ce sont seulement deux petits
fichiers texte : la description du service et tes propres réglages. Crée un dossier pour cela :

```bash
mkdir ~/ESPuino-Mediahub
cd ~/ESPuino-Mediahub
curl -O https://raw.githubusercontent.com/biologist79/ESPuino-Mediahub/main/docker-compose.yml
curl -o .env https://raw.githubusercontent.com/biologist79/ESPuino-Mediahub/main/env-example
```

`mkdir` crée le dossier, `cd` (« change directory ») y entre, et `curl` télécharge les deux fichiers
depuis le projet – le second directement sous son nouveau nom `.env` (le point initial en fait un
fichier caché sous Linux ; `ls -a` l'affiche quand même). **Toutes les commandes qui suivent
appartiennent à ce dossier**, car `docker compose` cherche toujours le `docker-compose.yml` dans le
répertoire courant. Si tu ne sais plus où tu en es : `pwd` te le dit, et `cd ~/ESPuino-Mediahub` t'y
ramène.

À présent tes réglages :

```bash
nano .env
```

`nano` est un éditeur de texte simple pour le terminal : les touches fléchées déplacent le curseur,
**Ctrl+O** puis Entrée enregistre, **Ctrl+X** quitte l'éditeur.

Les valeurs à y mettre figurent dans le [tableau plus haut](#die-env-datei). Deux suffisent le plus
souvent pour commencer : faire pointer `MEDIAHUB_MEDIA` vers ta collection et, si le port 8080 est
déjà occupé sur le Pi, indiquer un autre `MEDIAHUB_PORT`.

!!! warning "Ne modifier que le `.env`"
    Il est tentant de changer les valeurs directement dans `docker-compose.yml` – ne le fais pas. Ce
    fichier appartient au projet : il est écrasé à chaque mise à jour, ou provoque des conflits. Le
    `.env`, lui, est le tien et reste intact.

### Étape 6 · Monter la collection et régler les droits de fichiers

Jusqu'ici, chaque étape était la même pour tout le monde. À partir d'ici, cela devient individuel :
où se trouvent tes fictions audio, tes livres audio et ta musique, sur quel support et quel système
de fichiers, et à qui appartiennent les fichiers – cela diffère d'un foyer à l'autre. Il n'y a donc
pas, pour cette étape, de recette à recopier, et c'est en même temps l'endroit où les nouveaux venus
sous Linux restent le plus souvent bloqués. C'est pourquoi elle a droit à une étape à part et à un
peu plus d'explications que les autres.

Il n'y a en réalité que deux questions à trancher, et elles restent les mêmes quelle que soit ton
installation : **le Pi voit-il ta collection comme un dossier ?** Et : **l'utilisateur sous lequel
MediaHub tourne a-t-il le droit de lire ces fichiers ?** Les paragraphes suivants passent en revue
les cas les plus fréquents. Si le tien n'y figure pas exactement, ne te laisse pas démonter – les
deux questions restent les bonnes, seul le chemin vers la réponse change.

!!! note "Pour qui vient de Windows : pas de lettres de lecteur"
    Sous Linux, il n'y a pas de `C:` ni de `D:`. Il existe exactement **une** arborescence de
    répertoires, qui commence à `/`, et tout le reste s'y accroche quelque part. Un support USB ne
    reçoit donc pas de lettre : il est monté à un endroit de cette arborescence – habituellement
    sous `/mnt` ou `/media`. `/mnt/mediatheque` n'est donc pas un lecteur mais un dossier tout à fait
    ordinaire, qui montre le contenu du support tant que celui-ci est monté. Deux petites choses
    encore qui diffèrent de Windows : les chemins se séparent par la barre oblique `/` et non par la
    barre inversée, et la casse compte – `Livres` et `livres` sont deux dossiers différents.

**D'abord : où se trouve ta collection ?** MediaHub ne peut lire que ce qui est présent sur le Pi
sous forme de dossier. Si elle se trouve sur un support USB branché au Pi, celui-ci doit être monté
de façon permanente – Raspberry Pi OS Lite ne le fait pas tout seul en l'absence de bureau.
`lsblk -f` te montre les supports connectés avec leur UUID ; avec cet UUID, tu inscris le support
dans `/etc/fstab` afin qu'il apparaisse automatiquement au même endroit à chaque démarrage.

Un mot sur ce fichier, car le reste de l'étape en dépend : `/etc/fstab` (« file systems table ») est
la liste des supports que le système doit monter au démarrage. Une ligne par support, et chacune
indique quatre choses – ce qui est monté (ici par l'UUID, car des noms de périphériques comme
`/dev/sda1` peuvent se décaler au démarrage suivant), où dans l'arborescence, avec quel système de
fichiers et avec quelles options.

Monter fonctionne aussi sans ce fichier : un `sudo mount /dev/sda1 /mnt/mediatheque` agit
immédiatement. Mais après le prochain redémarrage, c'est reparti – et MediaHub affiche alors une
médiathèque vide sans que rien ne soit cassé. Ce qui doit valoir durablement a donc sa place dans le
`fstab` :

```bash
sudo mkdir -p /mnt/mediatheque
sudo nano /etc/fstab
```

Une ligne comme celle-ci à la fin du fichier suffit (en adaptant bien sûr l'UUID et le système de
fichiers à ton support) :

```
UUID=1234-ABCD  /mnt/mediatheque  exfat  defaults,nofail,ro,uid=33,gid=33,umask=022  0  0
```

Le `nofail` est important : sans cette option, le Pi se bloque au démarrage dès que le support n'est
pas branché. Les options `uid`, `gid` et `umask` déterminent à qui doivent appartenir les fichiers de
ce support – ce qui se cache derrière, le paragraphe sur les droits de fichiers l'explique juste
après. Elles n'agissent que sur les systèmes de fichiers sans gestion de droits propre, à savoir
exFAT, FAT32, NTFS et les partages réseau. Si ton support est formaté en **ext4**, omets-les (sinon
la commande refuse de coopérer) ; là, ce sont les droits enregistrés dans le système de fichiers
lui-même qui s'appliquent – voir deux paragraphes plus bas.

Pour que la nouvelle ligne prenne effet tout de suite, pas besoin de redémarrer : `sudo mount -a`
traite le `fstab` sur-le-champ et monte tout ce qui y figure et n'est pas encore monté – exactement
comme au démarrage. Cela fait aussi de cette commande le meilleur test : si elle passe sans broncher,
cela fonctionnera aussi au prochain démarrage ; si elle s'arrête sur ta ligne, tu l'apprends
maintenant et non au redémarrage suivant. S'il ne s'agit que de cette seule entrée,
`sudo mount /mnt/mediatheque` suffit. `ls /mnt/mediatheque` te montre si cela a marché. Ensuite,
indique `MEDIAHUB_MEDIA=/mnt/mediatheque` dans le `.env`.

Si la collection se trouve sur un **NAS** ou un partage réseau, la démarche est la même, avec
`cifs-utils` (`sudo apt install -y cifs-utils`) et une ligne `//serveur/partage` dans le `fstab`.
Note-le bien : pour les partages réseau, ce sont les **options de montage** qui décident des droits,
et non les droits sur le NAS – `uid=33,gid=33` dans la ligne du fstab t'épargne tout le paragraphe
suivant.

**Et maintenant les droits de fichiers.** Pour cela, un bref coup d'œil sur la manière dont Linux
distingue les utilisateurs vaut la peine – c'est l'une de ces choses qu'il faut avoir comprises une
fois, parce que beaucoup d'autres s'éclairent ensuite.

Linux ne connaît en effet pas ses utilisateurs par leur nom, mais par un **numéro** : l'identifiant
d'utilisateur, **uid** en abrégé. Il en va de même pour les groupes, où on parle d'identifiant de
groupe ou **gid**. Des noms comme `pi` ou `www-data` ne sont que des étiquettes que le système va
chercher dans une table ; ce qui est enregistré et vérifié, c'est toujours le nombre. Quelques-uns
sont attribués d'office : `0` est `root`, les numéros inférieurs à 1000 appartiennent aux comptes de
service – `33` est `www-data`, le compte sous lequel tournent habituellement les services web – et le
premier utilisateur que tu as créé à l'installation porte en général le `1000`. Tes propres numéros,
c'est `id` qui les révèle, séparément `id -u` et `id -g`.

Chaque fichier et chaque dossier porte alors exactement deux de ces numéros, à savoir l'uid du
propriétaire et le gid du groupe. S'y ajoutent les droits d'accès, attribués en trois exemplaires :
pour le propriétaire, pour le groupe et pour tous les autres, chaque fois séparément en lecture,
écriture et exécution. `ls -l` te le montre – avec les noms ; `ls -ln` affiche les numéros à la
place, ce qui est parfois plus parlant.

Le point décisif maintenant : le service MediaHub ne tourne **pas** en administrateur mais, par
défaut, sous l'identifiant `33`. C'est voulu – un service exposé au réseau ne doit pas avoir plus de
droits qu'il ne lui en faut. Qu'il soit question du numéro et non d'un nom d'utilisateur tient à la
même raison que plus haut : dans le conteneur, le 33 s'appelle `www-data`, sur ton Pi peut-être rien
du tout ou quelque chose de tout autre – ce qui est comparé, c'est le nombre. Pour toi, cela
signifie : ce ne sont pas tes droits qui décident de ce que MediaHub peut lire, mais ceux de
l'identifiant 33.

De son propre dossier de données, le conteneur se charge lui-même : il démarre brièvement avec les
droits d'administrateur, réécrit le propriétaire de `data`, puis abandonne ces droits. Cette étape ne
t'incombe donc pas.

Ta collection, en revanche, il n'y touche pas – elle doit être **lisible** pour l'identifiant 33, et
c'est là que se cache le véritable piège : lister un dossier et lire un fichier sont deux droits
distincts sous Linux. Il peut donc arriver qu'un titre apparaisse sagement dans l'explorateur de
fichiers de MediaHub, mais que l'attribution échoue avec « permission denied ». L'une de ces deux
solutions aide alors :

```bash
chmod -R o+rX /mnt/mediatheque
```

… ce qui permet à tous les autres (« **o**thers ») de lire les fichiers (`r`) et d'entrer dans les
dossiers. Le `X` majuscule n'est pas une faute de frappe mais l'astuce : il ne met le droit
d'exécution que sur les répertoires et ne transforme pas chaque fichier MP3 en programme. Tu peux
sinon faire tourner le conteneur sous l'identifiant à qui ta collection appartient de toute façon –
`id -u` et `id -g` affichent le tien, que tu indiques alors comme `MEDIAHUB_UID` et `MEDIAHUB_GID`
dans le `.env`. Les deux se valent ; prends le chemin qui te demande le moins de travail.

**Et comment le dossier arrive-t-il maintenant dans le conteneur ?** C'est le rôle de la ligne
`MEDIAHUB_MEDIA` de ton `.env`. Elle indique le chemin **sur le Pi** – d'après l'exemple ci-dessus,
donc `/mnt/mediatheque`. Docker passe ce dossier dans le conteneur au démarrage, et il y aboutit
toujours au même endroit : sous `/media`, et en lecture seule. À l'intérieur du conteneur, ta
collection s'appelle donc `/media`, peu importe où elle se trouve sur le Pi. C'est la seconde moitié
de l'idée de volume vue plus haut – ton chemin à l'extérieur, un chemin fixe à l'intérieur.

Il en va de même pour le dossier de données : `MEDIAHUB_DATA` indique l'endroit sur le Pi, dans le
conteneur c'est toujours `/data`. Deux conséquences pour le quotidien :

- Les chemins que tu verras plus tard dans l'interface web de MediaHub sont **relatifs à cette
  racine**. Si tu déplaces un jour ta collection ailleurs, tu ne changes que `MEDIAHUB_MEDIA` et les
  cartes déjà attribuées continuent de fonctionner – la base de données ne contient aucun chemin
  absolu.
- Après une modification du `.env`, un `docker compose restart` ne suffit **pas**. Un volume modifié
  n'est repris que lorsque le conteneur est recréé. `docker compose up -d` détecte la configuration
  modifiée et le remplace – ton dossier `data` reste intact au passage.

**Et si les fichiers se trouvent à plusieurs endroits ?** C'est le cas normal dès qu'un deuxième
disque arrive, ou qu'une partie de la collection est sur le NAS et une autre sur le Pi. Mais MediaHub
ne connaît qu'**une seule** racine. La solution n'est donc pas d'en déclarer une deuxième, mais de
faire de toutes les sources des sous-dossiers de la même racine.

Pour cela, tu crées un dossier parent et tu y montes les sources. Tous les chemins et noms des
exemples qui suivent sont libres – `/srv/mediahub` avec `usb`, `nas` et `livres-audio` en dessous
n'est qu'une possibilité ; la seule chose qui compte, c'est que toutes les sources se retrouvent sous
**un** même dossier – dans l'exemple qui suit, donc sous `/srv/mediahub` :

```bash
sudo mkdir -p /srv/mediahub/usb /srv/mediahub/nas /srv/mediahub/livres-audio
```

Cet unique appel crée trois dossiers d'un coup – et, grâce à `-p`, le dossier parent
`/srv/mediahub` par-dessus le marché, s'il n'existe pas encore. Trois n'a rien de magique : tu
écris simplement autant de chemins à la suite que tu as de sources – deux, dix, ou autant qu'il en
faudra.

Dans le `fstab`, les entrées pointent alors sur ces sous-dossiers – le support USB sur
`/srv/mediahub/usb`, le partage réseau sur `/srv/mediahub/nas`. Et pour un dossier qui se trouve déjà
quelque part sur le disque système et n'est pas un support à part, il y a la ligne « **bind** ».
Elle agit comme une seconde porte vers la même pièce : le dossier reste là où il est, mais devient
en plus accessible sous le nouveau chemin. Les deux chemins mènent alors aux mêmes fichiers – rien
n'est copié, il n'existe pas de seconde version, et ce que tu modifies à un endroit est déjà modifié
à l'autre, puisqu'il s'agit du même dossier :

```
/home/utilisateur/livres-audio  /srv/mediahub/livres-audio  none  bind,ro  0  0
```

À gauche se trouve le dossier qui existe déjà, à droite l'endroit où il doit apparaître en plus. Le
`ro` signifie que cette seconde porte est en lecture seule – le chemin d'origine n'en est pas
affecté, et lire est de toute façon tout ce dont MediaHub a besoin.

Ensuite, le `.env` n'a plus besoin que de `MEDIAHUB_MEDIA=/srv/mediahub`, et l'interface web affiche
`usb`, `nas` et `livres-audio` comme trois dossiers d'une seule médiathèque.

Pour que cela ne reste pas abstrait, voici l'ensemble en image. Voilà à quoi ressemble
l'arborescence **sur le Pi** si tu as suivi l'exemple :

```text
/
├── etc/
│   └── fstab                     c'est ici que figurent les entrées de montage
├── home/
│   └── utilisateur/
│       ├── ESPuino-Mediahub/     ton dossier de travail
│       │   ├── docker-compose.yml
│       │   ├── .env              contenant : MEDIAHUB_MEDIA=/srv/mediahub
│       │   └── data/             la base de données (db.json)
│       └── livres-audio/         se trouve simplement sur le disque système
└── srv/
    └── mediahub/                 la racine de ta médiathèque
        ├── usb/                  disque USB, monté via le fstab
        ├── nas/                  partage réseau, monté via le fstab
        └── livres-audio/         seconde porte vers ~/livres-audio (bind)
```

Et voici l'arborescence que **MediaHub voit dans le conteneur** – deux de ces dossiers viennent de
l'extérieur, le reste se trouve dans l'image :

```text
/
├── app/                          le programme, issu de l'image
├── data/     ◄── ~/ESPuino-Mediahub/data      en écriture
└── media/    ◄── /srv/mediahub                en lecture seule
    ├── usb/
    ├── nas/
    └── livres-audio/
```

MediaHub ne sait donc rien de ton Pi – hormis ces deux dossiers. Et à l'intérieur, ils s'appellent
toujours `/data` et `/media`, quels que soient les chemins à l'extérieur.

!!! warning "Choisir la racine large dès le départ"
    Les cartes attribuées enregistrent leurs chemins **par rapport à la racine**. Si tu remontes la
    racine d'un niveau plus tard – par exemple de `/mnt/mediatheque` vers `/srv/mediahub`, parce
    qu'une deuxième source arrive –, tous les chemins enregistrés changent du même coup et les
    attributions existantes pointent dans le vide. Si tu prévois d'avoir plus d'une source, crée donc
    le dossier parent **tout de suite**, même si une seule source y est montée au début. Cela te
    coûte un dossier maintenant et t'épargne de réattribuer toutes les cartes plus tard.

Ce qui ne fonctionne **pas**, ce sont les liens symboliques qui sortent de la médiathèque. MediaHub
résout chaque chemin et refuse tout ce qui mène hors de la racine – c'est voulu, car un lien
permettrait sinon de servir l'intégralité du contenu du conteneur. Un lien vers
`/home/utilisateur/livres-audio` placé dans `/srv/mediahub` est donc rejeté ; la ligne « bind »
ci-dessus en est précisément le remplacement qui marche.

### Étape 7 · Démarrer et vérifier

Voici le grand moment :

```bash
docker compose up -d
```

Deux choses se produisent ici : `up` télécharge l'image la première fois – environ 55 Mo, donc selon
ta connexion l'affaire de quelques secondes à quelques minutes – et en démarre le conteneur. Le `-d`
l'envoie en arrière-plan, et c'est important : MediaHub continue ainsi de tourner même quand tu
termines la session SSH et que ton ordinateur s'éteint.

S'il tourne, c'est ceci qui te le dit :

```bash
docker compose ps
```

Si un état comme `Up` ou `running` y figure, ouvre MediaHub dans le navigateur – à l'adresse
`http://mediahub.local:8080` ou à l'adresse IP du Pi avec le port de ton `.env`. La suite dans
l'interface web de MediaHub est décrite dans la section
[L'interface web de MediaHub](#das-mediahub-webinterface).

Du redémarrage automatique après une coupure de courant, tu n'as d'ailleurs pas à te soucier : le
`docker-compose.yml` indique `restart: unless-stopped`. Docker relance donc le conteneur de lui-même
après un redémarrage du Pi – sauf si tu l'as expressément arrêté toi-même.

### Les commandes les plus utiles au quotidien { #docker-befehle }

Toutes ces commandes s'exécutent dans le dossier où se trouve ton `docker-compose.yml` – selon ce
guide, donc dans `~/ESPuino-Mediahub` :

| Commande | Effet |
| --- | --- |
| `docker compose ps` | Le conteneur tourne-t-il ? Affiche l'état et le port. |
| `docker compose logs -f` | Suit le journal – le premier endroit où regarder quand quelque chose ne fonctionne pas. **Ctrl+C** arrête le suivi, pas le conteneur. |
| `docker compose restart` | Redémarrer le conteneur. |
| `docker compose stop` / `docker compose start` | Arrêter puis relancer, par exemple pour une sauvegarde. |
| `docker compose pull` puis `docker compose up -d` | La mise à jour : récupérer la nouvelle image, remplacer le conteneur par celle-ci. |
| `docker compose down` | Supprimer le conteneur. Tes données du dossier `data` sont conservées. |
| `docker images` | Liste les images présentes avec leur tag et leur taille – tu vois ainsi quelles versions `sha-` traînent encore. |
| `docker image rm <nom:tag>` | Supprime une image précise, par exemple celle de l'avant-dernière semaine. Si un conteneur l'utilise encore, Docker refuse – lance alors `docker compose down` d'abord. |
| `docker system prune -f` | Fait le ménage parmi les anciennes images inutilisées – après plusieurs mises à jour, cela libère une place sensible sur une petite carte SD. Concerne tous les conteneurs du Pi, pas seulement MediaHub. |

!!! tip "Premiers secours quand ça ne marche pas"
    Si le conteneur ne démarre pas, ou si la page reste blanche dans le navigateur,
    `docker compose logs` fournit presque toujours la réponse en clair. Cas typiques : un port déjà
    occupé (indique alors un autre `MEDIAHUB_PORT` dans le `.env`), un chemin `MEDIAHUB_MEDIA` qui
    n'existe pas du tout sur le Pi – MediaHub démarre alors, mais affiche une médiathèque vide – ou
    un message indiquant que le dossier de données n'est pas accessible en écriture. Ce dernier
    mentionne directement la commande qui corrige le problème ; il n'apparaît que si le dossier se
    trouve sur un partage dont les droits ne peuvent pas être modifiés de l'intérieur non plus. Si
    tu n'avances plus, pose la question sur le [forum ESPuino](https://forum.espuino.de) en y
    joignant la sortie de `docker compose logs`.

## Mettre à jour

```bash
docker compose pull
docker compose up -d
```

`pull` récupère l'image actuelle, `up -d` remplace le conteneur en cours par celle-ci – c'est toute
la mise à jour. Ton dossier `data` et ton `.env` restent intacts : il n'y a rien à sauvegarder ni à
reprendre.

Quelle version tu obtiens, c'est `MEDIAHUB_TAG` dans ton `.env` qui en décide. La valeur par défaut
est `latest`, et `latest` pointe toujours sur l'état de développement actuel – donc la même chose que
ce que `git pull` te donnait auparavant. Si une modification te pose problème, indique à la place un
des tags `sha-…` de la
[page du paquet](https://github.com/biologist79/ESPuino-Mediahub/pkgs/container/espuino-mediahub) et
un nouveau `pull` te ramène à l'état précédent. C'est la partie la plus confortable du passage aux
images prêtes à l'emploi : revenir en arrière, c'est changer une ligne.

Deux choses méritent un regard après une mise à jour : les nouvelles options apparaissent d'abord
dans `env-example` et doivent être reprises à la main dans ton `.env`, et le `docker-compose.yml`
lui-même change de temps à autre – télécharge-le alors de nouveau avec la même commande `curl` que
lors de l'installation.

!!! note "Ne pas modifier docker-compose.yml directement"
    Si tu as besoin d'extensions qui ne peuvent pas passer par `.env`, place ton propre
    `docker-compose.override.yml` à côté. Compose le lit automatiquement, et tes adaptations
    survivent à chaque remplacement du `docker-compose.yml`.

!!! tip "Tu préfères compiler toi-même ?"
    Si tu veux construire l'image depuis les sources – pour développer, pour essayer une
    modification à toi, ou pour une plateforme que l'image publiée ne couvre pas – clone le projet
    et ajoute le fichier supplémentaire fourni :
    `docker compose -f docker-compose.yml -f docker-compose.build.yml up -d --build`.

Selon ce qui a changé dans l'interaction avec l'ESPuino, une
[mise à jour du firmware](../firmware/aktualisieren.md) sur les appareils eux-mêmes peut aussi être
utile.

## Sauvegarde

Le conteneur Docker lui-même est un objet jetable – il peut être reconstruit à tout moment. Ce qui
compte, c'est uniquement le dossier `data` : sans son contenu (le fichier de base de données
`db.json`), toute la configuration de MediaHub, les ESPuinos enregistrés et les attributions de
cartes sont perdus. Sauvegarde donc ce dossier régulièrement, idéalement en dehors du serveur
lui-même.

!!! warning "Ne pas modifier la base de données à la main"
    Le fichier `db.json` ne devrait pas être édité manuellement. Si tu dois malgré tout y travailler
    directement, arrête d'abord le conteneur avec `docker compose stop`.

## MediaHub dans l'interface web de l'ESPuino

Sur l'ESPuino lui-même, MediaHub te concerne à deux endroits : l'
[onglet MediaHub](../bedienung/webinterface.md#tab-mediahub), pour enregistrer des serveurs, et l'
[onglet RFID](../bedienung/webinterface.md#tab-rfid), pour attribuer réellement une carte à un
serveur. Quelles cartes de cet appareil pointent déjà vers un serveur média, et à quel point leur
copie locale est à jour, c'est la
[liste des attributions enregistrées](../bedienung/webinterface.md#zuweisungsliste) de l'onglet
Outils qui te le montre.

![Attribution de carte dans l'interface web de l'ESPuino avec le mode de lecture « MediaHub » et la sélection du serveur de médias ; le chemin est composé automatiquement à partir de l'adresse et du protocole du serveur](../assets/MediahubRfidZuweisung.png)

Lorsque tu choisis le mode de lecture **MediaHub** en apprenant une carte, un autre menu déroulant
apparaît en dessous : **serveur de médias**, listant tous les serveurs enregistrés. Le champ
« fichier, répertoire ou URL » se remplit alors automatiquement – comme une combinaison du préfixe
`mediahub://` et de l'adresse du serveur, par exemple `mediahub://http://nas2:8090`. Tu ne saisis
pas cela toi-même, c'est une comptabilité purement interne : ainsi, l'ESPuino sait quel serveur
contacter la prochaine fois que la carte est posée.

!!! tip "L'apprentissage aussi peut être évité"
    Active dans l'onglet MediaHub l'option
    [« Interroger directement le MediaHub sur les cartes inconnues, sans apprentissage préalable »](../bedienung/webinterface.md#mediahub-optionen)
    et cette étape disparaît complètement : pose une carte que l'ESPuino ne connaît pas et il
    interroge de lui-même les serveurs enregistrés, puis reprend automatiquement une attribution qui
    y est déposée. Cela vaut surtout avec plusieurs appareils – sinon, chaque carte doit être
    apprise séparément sur chacun d'eux.

## L'interface web de MediaHub { #das-mediahub-webinterface }

L'interface web du serveur MediaHub lui-même est organisée en cinq sections : **ESPuinos**,
**cartes et attributions**, **nouvelles cartes** (un filtre sur les cartes pas encore attribuées),
**médias** et **réglages** – toutes accessibles via la navigation en haut.

### Appareils

![L'aperçu des appareils dans MediaHub : ESPuinos enregistrés avec ID d'appareil, alias modifiable, adresse IP, horodatages et dernière carte](../assets/MediahubGeraete.png)

MediaHub liste ici tous les ESPuinos qui l'ont déjà contacté – reconnus grâce à l'ID d'appareil
provenant de la requête de manifeste. Pour chaque appareil, tu vois son adresse IP, la date de
dernière et de première détection, quelle carte a été posée le plus récemment, et combien de cartes
sont déjà attribuées à cet appareil. Le nom d'affichage par défaut est l'ID technique de l'appareil ;
le champ de texte à côté te permet d'attribuer à la place un **alias**, comme « Enfant1 », qui
s'affiche ensuite partout ailleurs dans l'interface.

### Cartes et attributions

![La page des cartes et attributions dans MediaHub avec une carte en attente, pas encore attribuée](../assets/MediahubKartenWartend.png)

Cette page liste toutes les cartes connues de MediaHub – les cartes attribuées jouent à la
prochaine pose, celles en attente pas encore. Les filtres en haut te permettent de restreindre à un
appareil ESPuino précis, d'afficher les cartes non attribuées avec **« Uniquement en attente »**, ou
de déclencher un nouveau téléchargement pour toutes les cartes à la fois avec **« Force Refresh
(toutes) »**. Si tu connais déjà l'ID de carte à douze chiffres (disponible dans l'interface web de
l'ESPuino lui-même dès que tu y poses la carte), tu peux aussi ajouter une carte manuellement sans
la poser au préalable.

Des cartes en attente apparaissent d'ailleurs aussi lorsqu'un ESPuino, avec l'option ci-dessus,
s'enquiert d'une carte qu'il ne connaît pas et qu'aucun serveur ne la connaît non plus. Poser une
nouvelle carte la signale donc ici avant même qu'elle ne soit assignée où que ce soit.

La liste se tient elle-même à jour : pose une carte alors que cette page est ouverte et elle
apparaît d'elle-même au bout de quelques secondes – aucun rechargement nécessaire. Si tu es
justement en train de saisir un ID de carte ou qu'une fenêtre de dialogue est ouverte, la page ne
t'est pas retirée des mains ; un bandeau apparaît alors en haut avec le bouton **« Actualiser
maintenant »**.

![La liste des cartes et attributions dans MediaHub avec une carte déjà attribuée et les actions Modifier, Force Refresh, Manifeste, Dupliquer et Supprimer](../assets/MediahubKartenListe.png)

Une fois une carte attribuée, cinq actions sont disponibles par ligne :

| Action | Effet |
| --- | --- |
| **Modifier** | Change l'attribution après coup. Si les données ont déjà été transférées sur l'ESPuino, il récupère la nouvelle version de lui-même – au fil des poses suivantes, comme décrit à l'étape 6 ci-dessus. |
| **Force Refresh** | Force un nouveau téléchargement bien que rien n'ait changé au contenu – prévu pour le cas où la copie locale sur l'ESPuino est endommagée ou manquante. |
| **Manifeste** | Affiche le fichier de téléchargement que l'ESPuino reçoit pour cette carte. |
| **Dupliquer** | Copie après coup une attribution terminée vers un autre appareil – par exemple lorsqu'un ESPuino arrive plus tard. Lors de la création et de la modification, tu passes plutôt directement par les cases des appareils dans le formulaire (voir ci-dessous). |
| **Supprimer** | Supprime l'attribution (attention au réglage de suppression, voir ci-dessous). |

!!! warning "Fichier remplacé ? Enregistre à nouveau l'attribution"
    Si tu remplaces un fichier de ta bibliothèque par une nouvelle version sans réenregistrer
    l'attribution dans le formulaire, un « Force Refresh » n'aide pas non plus : l'ESPuino vérifie
    chaque fichier téléchargé par rapport à la taille et à la somme de contrôle du manifeste, et
    MediaHub les connaît encore dans leur ancien état. Le téléchargement échoue à cette vérification
    et l'ancienne copie reste en place. Dans ce cas, ouvre l'attribution une fois et enregistre-la de
    nouveau – MediaHub relit alors la taille et la somme de contrôle, et l'ESPuino récupère la
    nouvelle version tout seul.

#### Le formulaire d'attribution

![Le formulaire d'attribution dans MediaHub : nom, type de contenu, mode de lecture, une arborescence de la bibliothèque de médias montée et les cases des appareils cibles](../assets/MediahubZuweisungsformular.png)

Lors de l'attribution, tu remplis les champs suivants :

- **Nom** – pour ton propre repère uniquement, apparaît dans la liste et dans les journaux, mais n'a
  aucune fonction pour la lecture.
- **Type de contenu** – soit des **fichiers audio** de ta bibliothèque, soit un flux de **radio
  web** (MediaHub ne prend pas en charge une liste `.m3u` locale).
- **Mode de lecture** – la même liste que dans l'interface web de l'ESPuino (voir
  [chapitre 8 → modes de lecture](../bedienung/webinterface.md#abspielmodi)).
- **Bibliothèque de médias** – une arborescence de ta collection montée via `MEDIAHUB_MEDIA`.
  « Utiliser le dossier » adopte un dossier entier pour des modes comme « tous les titres d'un
  dossier ».
- **Écrire sur ces ESPuinos** – tous les autres appareils connus sous forme de cases à cocher. Chaque
  appareil coché reçoit la même attribution, de sorte qu'une carte se retrouve sur plusieurs
  ESPuinos en un seul enregistrement. Ce bloc n'apparaît que si un deuxième appareil est connu.

!!! tip "Aussi des fichiers individuels au lieu d'un dossier entier"
    Pour les modes basés sur un dossier comme « tous les titres d'un dossier (triés) », tu n'es pas
    obligé d'adopter le dossier entier : tu peux aussi **cocher des fichiers individuels** dans
    l'arborescence – seuls ceux-ci seront alors transférés, pas le reste du dossier. Pratique quand
    une carte ne doit couvrir qu'une sélection au sein d'une collection plus large.

![Plusieurs fichiers cochés individuellement au sein d'un dossier dans le formulaire d'attribution de MediaHub](../assets/MediahubMehrereDateien.png)

!!! note "Plusieurs appareils, plusieurs entrées"
    Chaque appareil coché reçoit sa **propre** attribution avec le même contenu, et non une entrée
    commune à tous. C'est voulu : chaque ESPuino conserve ainsi sa propre position de lecture pour
    les livres audio et son propre cache de téléchargement. Un appareil qui porte déjà la carte est
    coché d'emblée – ainsi une modification ultérieure du contenu n'atteint pas un seul appareil, ce
    qui ferait diverger les entrées. L'appareil dont tu modifies la carte est toujours coché et ne
    peut pas être décoché.

    **Décocher ne supprime rien.** Une case vide signifie « ne pas toucher à cet appareil », pas
    « retirer l'attribution là-bas » – pour supprimer, utilise **« Supprimer »** dans la liste des
    cartes. La raison : selon le réglage, la suppression peut contacter l'ESPuino lui-même, et cela
    ne doit pas se produire comme effet secondaire d'un bouton d'enregistrement.

![Le bloc « Écrire sur ces ESPuinos » dans le formulaire d'attribution : l'appareil modifié coché et figé, un autre appareil sélectionné en plus](../assets/MediahubGeraeteHaekchen.png)

### Médias

![L'aperçu des médias dans MediaHub avec l'utilisation du stockage par carte](../assets/MediahubMedien.png)

Cette page indique combien de fichiers et combien d'espace de stockage sont associés à chaque
carte. Il n'y a volontairement pas de zone d'upload dédiée – le téléversement ne se fait pas sur
cette page, mais directement lors de l'attribution de carte, en choisissant des fichiers dans ta
bibliothèque existante.

### Réglages

![La page des réglages dans MediaHub : comportement de suppression (lazy/secure delete), profondeur de récursion, appareils présélectionnés lors de l'attribution et mot de passe optionnel du hub](../assets/MediahubEinstellungen.png)

Tu définis ici comment MediaHub se comporte lors de la suppression d'une attribution de carte,
jusqu'à quelle profondeur il explore les sous-dossiers pour les modes de lecture récursifs, et pour
quels appareils une nouvelle attribution est présélectionnée :

- **Comportement de suppression** – **Lazy Delete** (par défaut) ne supprime que l'entrée sur
  MediaHub ; la carte continue de jouer sans changement sur l'ESPuino depuis le cache local, même
  hors ligne, et n'y est pas supprimée. **Secure Delete**, en revanche, appelle d'abord la fonction
  de suppression sur l'ESPuino lui-même et ne supprime l'entrée sur MediaHub qu'une fois que
  l'appareil a confirmé la suppression – pour cela, l'ESPuino doit être joignable à ce moment-là.
- **Profondeur de récursion** (par défaut : 3) – définit combien de niveaux de sous-dossiers les
  modes de lecture récursifs comme « livre audio récursif » ou « tous les titres récursif »
  incluent lors du téléchargement. Les modes non récursifs n'utilisent toujours que le dossier
  choisi lui-même, indépendamment de ce réglage. Ne règle pas cette valeur inutilement haute –
  sinon une seule attribution peut entraîner involontairement beaucoup de données.
- **Appareils présélectionnés lors de l'attribution** – détermine uniquement les cases que le
  formulaire d'attribution apporte au départ. **Uniquement l'appareil modifié** (par défaut) se
  comporte comme avant ; **Tous les ESPuinos connus** coche d'emblée chaque appareil, de sorte qu'un
  seul enregistrement couvre toute la maison. Dans les deux cas, seul ce qui est effectivement coché
  au moment de l'enregistrement est écrit.
- **Mot de passe du hub** (optionnel) – protège uniquement l'**interface web** de MediaHub
  elle-même. L'API à laquelle s'adressent les ESPuinos reste accessible sans restriction, car les
  appareils ne peuvent pas se connecter.

## Pour aller plus loin

- [ESPuino-Mediahub sur GitHub](https://github.com/biologist79/ESPuino-Mediahub) – code source et
  spécification technique.
- [Fil de discussion du forum #4607](https://forum.espuino.de/t/espuino-mediahub/4607) – présentation
  et discussion (en allemand).
