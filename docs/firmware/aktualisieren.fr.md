# 13 · Mettre à jour le firmware

Le firmware est le logiciel qui tourne sur ton ESPuino. Il est développé en continu – des bugs sont
corrigés, de nouvelles fonctions sont ajoutées. Une mise à jour de temps en temps est donc utile. Ce
chapitre te présente les différentes voies pour y arriver, du « tout confort » au « contrôle
total ».

Il existe essentiellement trois voies, et pour la grande majorité des cas, ce sont les deux
premières qui comptent : l'**outil de firmware dans le navigateur** (via un câble USB) et la
**mise à jour via l'interface web** (via le Wi-Fi). Seuls ceux qui utilisent leur propre matériel
différent, ou qui ont besoin d'options spéciales à la compilation, doivent prendre la troisième
voie et **compiler le firmware eux-mêmes**.

## Quand une mise à jour vaut-elle vraiment le coup

Il n'y a pas de règle absolue du type « toujours mettre à jour ». Si ton ESPuino fonctionne à ta
satisfaction, rien ne t'y oblige. Une mise à jour vaut le coup si un bug précis qui te gêne a été
corrigé, ou si une nouvelle fonction que tu souhaites a été ajoutée. Le meilleur moyen de suivre ce
qui a changé entre les versions est le [changelog](../referenz/anhang.md#changelog).

## La méthode la plus pratique : l'outil de firmware dans le navigateur

Pour le **tout premier flashage**, ou pour une **restauration** – par exemple si l'interface web
n'est plus accessible –, l'outil basé sur le navigateur
**[ESPuino Firmware Tool](https://biologist79.github.io/ESPuino-Firmware-Tool/)** est la solution la
plus pratique. Tu n'as besoin d'installer aucun logiciel pour cela ; tout se passe directement dans
le navigateur.

<!-- Screenshot: outil de firmware dans le navigateur -->

L'outil peut flasher le firmware (juste l'application, ou complètement), **effacer la mémoire
flash** (donc remettre l'appareil dans un état propre), afficher une console série pour le dépannage
et aussi téléverser ton propre firmware. Il faut pour cela un navigateur prenant en charge le **Web
Serial** (par exemple Chrome, Edge, Opera, Brave ou Vivaldi) et une connexion USB à l'ESPuino.

La procédure est simple : connecter l'ESPuino en **USB**, choisir la langue et la **branche**
(master ou dev) dans l'outil, sélectionner la **plateforme** de ta carte, choisir le build de
firmware souhaité et régler la vitesse USB (au maximum 460 800 bauds). Lance ensuite l'action
souhaitée, choisis le port série quand demandé, et observe la progression.

!!! tip "Quelle branche choisir : master ou dev ?"
    - **master** est la branche stable – testée plus rigoureusement, mais parfois un peu plus
      ancienne.
    - **dev** est la branche de développement – toujours à la pointe, mais moins testée.

    En pratique, `dev` fonctionne étonnamment bien ; sur le forum, on a déjà entendu avec un clin
    d'œil que « dev est le meilleur master ». Si tu veux jouer la sécurité, prends **master** ; si tu
    aimes les dernières fonctionnalités et corrections, **dev** vaut la peine d'être essayé. 🙂

!!! danger "La bonne plateforme est essentielle"
    Choisis absolument la plateforme exacte correspondant à ta carte. La **plateforme incorrecte**
    peut, dans le pire des cas, endommager le matériel.

## La voie via le Wi-Fi : mise à jour dans l'interface web

Si ton ESPuino fonctionne déjà et est connecté au Wi-Fi, une mise à jour est aussi possible sans
aucun USB – directement dans l'interface web, dans l'**onglet Mises à jour**
([chapitre 8](../bedienung/webinterface.md#tab-updates)).

<!-- Screenshot: onglet Mises à jour / mise à jour GitHub -->

La variante la plus élégante est **charger le firmware depuis GitHub**
([forum #4582](https://forum.espuino.de/t/firmware-update-direkt-von-github/4582), en allemand) : tu
choisis la branche (master ou dev), cliques sur « rechercher des mises à jour » et obtiens la liste
des derniers builds, chacun avec sa date et son identifiant de commit (survole l'identifiant avec la
souris pour voir la description du changement correspondant). Un clic sur « installer » suffit – la
**variante de carte et la langue appropriées sont choisies automatiquement**. Détail intéressant au
passage : le téléchargement proprement dit se déroule dans le **navigateur** (en JavaScript), pas
sur l'ESP32 lui-même – là encore, une question de mémoire limitée. Pendant ce temps, l'anneau
Neopixel affiche la progression du flashage en bleu.

Tu peux aussi, dans le même onglet, téléverser manuellement un **fichier de firmware**
(`firmware.bin`).

!!! info "La détection automatique simplifie le choix du fichier"
    Auparavant, il fallait faire attention à la variante RFID dans le nom du fichier lors de la mise
    à jour. Depuis mai 2026, ESPuino détecte automatiquement le lecteur (RC522 ou PN5180) – cet écueil
    a donc disparu.

## La voie pour les utilisateurs avancés : compiler soi-même

Il arrive que le firmware prêt à l'emploi ne suffise pas : tu utilises ton propre matériel, ou tu
veux définir une option disponible uniquement à la compilation (voir [chapitre 14](compile-zeit.md)).
Dans ce cas, tu construis toi-même le firmware. La procédure suivante s'appuie sur le
[guide du forum #891](https://forum.espuino.de/t/espuino-in-platformio-anlegen-und-mit-git-aktuell-halten/891)
(en allemand).

!!! info "pioarduino plutôt que PlatformIO"
    Le guide du forum parle encore de **PlatformIO**. Depuis, **pioarduino** est devenu le meilleur
    choix : un différend existe entre Espressif (le fabricant de l'ESP32) et les développeurs de
    PlatformIO, ce qui fait que pioarduino – un fork communautaire – prend en charge les chaînes
    d'outils Espressif de façon plus à jour. Le fichier `platformio.ini` d'ESPuino est déjà conçu
    pour cela. Partout où « pioarduino » apparaît ci-dessous, le guide désigne donc ce qui était
    auparavant PlatformIO.

### Préparation

Il te faut trois choses : **Visual Studio Code**, l'**extension pioarduino** (à installer dans
VS Code via la marketplace des extensions) et **Git**. Pour que Git puisse attribuer tes futurs
commits, configure ton identité une fois pour toutes :

```bash
git config --global user.name "Ton Nom"
git config --global user.email "toi@mail.fr"
```

### Récupérer et ouvrir le dépôt

Clone le dépôt ESPuino et ouvre le dossier dans VS Code :

```bash
git clone https://github.com/biologist79/ESPuino
```

Dans VS Code, cela fonctionne aussi de façon pratique via `Ctrl`+`Maj`+`P` → « Git : Clone ».
Sélectionne ensuite, dans la barre d'état en bas, l'**environnement** correspondant à ta carte –
donc `env:complete` ou `env:lolin_d32_pro_sdmmc_pe` (mini4L).

### Réglages personnels

Si tu veux modifier des options à la compilation, ne le fais pas directement dans les fichiers
fournis, mais dans ton propre fichier `settings-override.h` (voir [chapitre 14](compile-zeit.md)).
Ainsi, une mise à jour ultérieure n'écrasera pas tes personnalisations.

### Compiler et flasher

Dans la barre latérale de pioarduino, choisis **« Upload and Monitor »** – cela compile le firmware,
le téléverse via USB et ouvre directement la console série.

### Rester à jour avec Git

Pour pouvoir intégrer des mises à jour sans casser tes propres personnalisations, il est préférable
de travailler sur ta **propre branche** plutôt que directement sur `dev` ou `master`. À configurer
une fois pour toutes :

```bash
git checkout dev
git pull
git branch MonAppareil
git checkout MonAppareil
```

Tu effectues désormais tes modifications sur `MonAppareil`. Pour te mettre à jour, récupère le
dernier état de `dev` et rebase ta branche par-dessus :

```bash
git checkout dev
git pull
git checkout MonAppareil
git rebase dev
```

Si tu n'as que de petites modifications locales sans grande importance, la méthode plus simple avec
`git stash` fonctionne aussi :

```bash
git stash      # mettre tes modifications de côté
git pull       # récupérer la mise à jour
git stash pop  # réappliquer tes modifications
```

!!! tip "Ne pas commiter directement sur dev ou master"
    Garde toujours tes personnalisations sur ta propre branche. Si tu commites directement sur
    `dev` ou `master`, le prochain `git pull` provoquera presque inévitablement des conflits.

!!! info "Pour quoi existe-t-il un firmware prêt à l'emploi"
    Le firmware prêt à l'emploi est construit automatiquement pour **trois** cibles –
    **`complete`**, **`lolin_d32_pro_sdmmc_pe`** (mini4L) et **`lolin_d32_pro`** –, chacune pour les
    branches **dev** et **master** et en **trois langues** (DE/EN/FR). Les produits actuels sont la
    [Complete](../hardware/complete.md) et la mini4L ; le `lolin_d32_pro` est une carte plus
    ancienne, pour laquelle des builds continuent néanmoins d'être fournis. Pour des **montages
    maison** différents, en revanche, il n'y a rien à simplement flasher – il faut les compiler
    soi-même. Et l'**ESP32-S3 n'est pas pris en charge**, car il ne dispose pas du Bluetooth
    classique.
