# 10 · Gérer les contenus

Un ESPuino n'est jamais meilleur que ce qui se trouve sur sa carte SD. Ce chapitre porte donc sur la
façon de transférer tes histoires, livres audio et musique sur l'appareil – et, tout aussi
important, de les organiser pour que les modes de lecture fassent ensuite exactement ce que tu
attends. Un peu d'ordre au départ t'évite bien des recherches plus tard.

## Quels formats et sources fonctionnent

ESPuino joue les formats audio courants directement depuis la carte SD. Concrètement : **MP3**,
**AAC** (donc `.m4a`), **FLAC**, **OPUS**, **OGG/Vorbis** et **WAV**. Cela couvre la grande majorité
des collections ; le MP3 est le classique, et les formats sans perte comme le FLAC fonctionnent
tout aussi bien.

Outre les fichiers locaux, ESPuino connaît deux autres sources. D'abord la **radio web** : au lieu
d'un fichier, tu indiques une adresse de flux (`http://…`), et ESPuino joue la station tant qu'il
est sur le Wi-Fi. Ensuite les **listes `.m3u` locales** – de simples fichiers texte listant une
série de titres. L'avantage : une telle liste peut **mélanger librement** des fichiers de la carte
SD et des flux web.

## Une structure de dossiers sensée

L'idée la plus importante pour le classement : la plupart des modes de lecture fonctionnent **par
dossier**. Un dossier est donc l'unité naturelle pour un livre audio, une histoire ou un album. Il
vaut donc la peine de créer, dès le départ, un dossier propre par titre ou par œuvre. Une structure
qui a fait ses preuves ressemble par exemple à ceci :

```text
/Histoires/
  Le Club des Cinq/
    Épisode 001/
      01 - Chapitre 1.mp3
      02 - Chapitre 2.mp3
    Épisode 002/
  Histoires du soir/
/Musique/
  Chansons préférées/
```

Pourquoi cette rigueur ? Parce que la structure des dossiers détermine directement ce qu'une carte
peut jouer. En **mode livre audio**, le dossier est l'unité pour laquelle ESPuino mémorise la
dernière position écoutée. Les **modes récursifs** intègrent en plus tous les sous-dossiers – idéal
pour des collections imbriquées. Et il existe même des modes qui choisissent un **sous-dossier
aléatoire**, de sorte qu'une seule carte peut représenter « une histoire quelconque de la
collection ».

!!! tip "Noms de fichiers avec un numéro en tête"
    ESPuino trie de façon **naturelle** – c'est-à-dire que `1, 2, 10` se retrouvent exactement dans
    cet ordre, et non comme `1, 10, 2`. Si tu numérotes tes titres au début du nom de fichier
    (`01 - …`, `02 - …`), l'ordre est fiable. Le mode de tri lui-même peut être ajusté dans
    l'interface web (onglet Général → Lecture).

## Comment ESPuino mémorise la position pour les livres audio

Le mode livre audio est la raison pour laquelle beaucoup se tournent vers ESPuino, d'où un
paragraphe qui lui est dédié. Dans ce mode, ESPuino enregistre la dernière position écoutée, de
sorte que la prochaine fois que la carte est posée, la lecture reprend exactement là où elle s'était
arrêtée. La sauvegarde a lieu aux moments logiques – lors du changement de titre, de la mise en
pause, à la fin d'un titre ou de la playlist.

Deux cas sont **désactivés** par défaut, mais peuvent être activés dans l'interface web : la
sauvegarde lors du **changement de carte** et la sauvegarde à l'**extinction**. Et pour les
chapitres très longs, il existe en plus un point de contrôle optionnel qui sauvegarde la position à
intervalles réguliers – une protection contre la perte d'une heure entière de progression en cas de
coupure de courant soudaine. L'endroit où trouver et régler ces options est indiqué au
[chapitre 8 → Onglet Général · Lecture](../bedienung/webinterface.md#wiedergabe).

## Pochette et métadonnées

Si un titre (ou un flux web) comporte une **pochette** intégrée, l'interface web l'affiche dans
l'onglet Contrôle. Cela n'a aucune incidence sur la lecture elle-même – c'est purement cosmétique à
l'écran.

!!! tip "Quand la pochette pose problème"
    C'est justement la pochette intégrée qui est parfois à l'origine d'un MP3 qui ne joue pas
    correctement ou qui saccade. Si tu rencontres un tel fichier, un ré-encodage propre sans
    pochette aide généralement – la méthode avec ffmpeg est décrite au
    [chapitre 15 → MP3](../hilfe/troubleshooting.md#einzelne-titel-machen-probleme-mp3).

## Radio web

Tu configures une station de radio en attribuant à une carte le mode **📻 radio web** et en
saisissant l'adresse du flux (le champ est pratiquement pré-rempli avec `http://`). Si tu souhaites
regrouper plusieurs stations ou une liste mixte sur une seule carte, utilise pour cela un **fichier
`.m3u`**.

Privilégie si possible **`http://` plutôt que `https://`** – le HTTPS coûte nettement plus de
mémoire sur l'ESP32.

!!! tip "Un flux en HTTPS ? Essaie d'abord `http`"
    Si tu n'as qu'une adresse en `https://`, essaie simplement si la même station fonctionne aussi
    en `http://` – cela économise de la mémoire et fonctionne souvent en pratique.

## Sauvegarde et restauration : sécuriser tes attributions de cartes { #backup-restore-deine-kartenzuordnungen-sichern }

Un point facile à oublier, jusqu'à ce qu'il soit trop tard : les associations entre cartes et
contenus ne se trouvent **pas** sur la carte SD, mais dans la mémoire interne (NVS) de l'ESP32. Si
la carte électronique tombe un jour en panne, cette liste d'associations, souvent laborieusement
constituée, serait perdue – à moins que tu ne l'aies sauvegardée.

Heureusement, ESPuino s'en occupe largement à ta place. Dans le répertoire racine de la carte SD, il
tient automatiquement à jour un fichier **`backup.txt`**, qu'il réécrit à **chaque** nouvelle
attribution (le nom du fichier peut être modifié via `backupFile` dans `settings.h`). Via l'**onglet
Outils**, tu peux aussi **exporter** et **réimporter** ces attributions manuellement à tout moment.
L'importation est volontairement conciliante : elle **ajoute et remplace seulement, mais ne
supprime jamais** – tu peux donc restaurer une sauvegarde sans risque, voire la transférer d'un
ESPuino à un autre.

!!! tip "Rétablir un état exactement défini"
    Si tu veux qu'à la fin, *exactement* les entrées de ta sauvegarde soient présentes et rien
    d'autre, procède en deux étapes : d'abord **supprimer toutes les attributions** dans l'onglet
    Outils, puis importer la sauvegarde. Les autres réglages ne sont pas affectés par cette
    opération. Contexte :
    [forum #508](https://forum.espuino.de/t/die-backupfunktion-des-espuino/508) (en allemand).

Le conseil le plus important pour finir : exporte une sauvegarde de temps en temps et conserve-la
**hors de la carte SD** – tu seras ainsi protégé même si la carte elle-même finit par rendre l'âme.
