# 18 · Annexe

Ouvrage de référence. Les tableaux sont dérivés du code du firmware – à maintenir à jour lors des
changements de code.

## Modes de lecture { #playmodi }

Ce que signifient les différents modes au quotidien – avec icône et description – est décrit au
[chapitre 8 → les modes de lecture](../bedienung/webinterface.md#abspielmodi). On ne trouve ici que
les identifiants techniques, tels qu'ils apparaissent dans les messages MQTT, dans l'API REST et
dans `backup.txt`.

| Catégorie | ID | Constante |
| --- | --- | --- |
| Titre unique | 1 / 2 / 12 | `SINGLE_TRACK` / `_LOOP` / `_OF_DIR_RANDOM` |
| Livre audio (position mémorisable) | 3 / 4 / 16 | `AUDIOBOOK` / `_LOOP` / `_RECURSIVE` |
| Dossier trié | 5 / 7 / 15 | `ALL_TRACKS_OF_DIR_SORTED` / `_LOOP` / `_RECURSIVE` |
| Dossier aléatoire | 6 / 9 / 17 | `ALL_TRACKS_OF_DIR_RANDOM` / `_LOOP` / `_RECURSIVE` |
| Sous-dossier aléatoire | 13 / 14 | `RANDOM_SUBDIRECTORY_…` (trié / aléatoire) |
| Radio web | 8 | `WEBSTREAM` |
| m3u local | 11 | `LOCAL_M3U` |
| MediaHub | 18 | `MEDIAHUB` |
| Interne | 0 / 10 | `NO_PLAYLIST` / `PLAYLIST_BUSY` |

## Cartes de modification { #modifikationskarten }

Cartes qui déclenchent une fonction plutôt que de la musique. Le catalogue complet en langage
courant – classé par thème – se trouve au
[chapitre 8 → cartes de modification](../bedienung/webinterface.md#modifikationskarten-alle-optionen).

| ID | Effet |
| --- | --- |
| 0 | Supprimer l'affectation de cette carte |
| 100 | Verrouiller boutons + encodeur |
| 101 / 102 / 103 / 104 | Sommeil après 15 / 30 / 60 / 120 min (+ atténuation LED) |
| 105 | Sommeil à la fin du titre |
| 106 | Sommeil à la fin de la playlist |
| 107 | Sommeil après 5 titres |
| 110 / 111 | Boucle playlist / titre |
| 120 | Mode nuit (luminosité des LED, limite de volume en option) |
| 130 | Wi-Fi activer/désactiver |
| 140 / 141 / 142 | Récepteur BT / source BT / changer de mode |
| 150 | Activer le serveur FTP |
| 151 / 152 | Annoncer l'adresse IP / l'heure |
| 153 | Basculer l'éclairage d'ambiance |
| 154 / 155 | Luminosité LED + / − |

La répartition en deux tableaux suit la nature de la commande, pas ce à quoi elle peut être affectée :
presque toutes les commandes de contrôle ci-dessous peuvent tout aussi bien être placées sur une carte.
Les actions disponibles **uniquement** en carte ou **uniquement** en bouton sont listées au
[chapitre 8 → Molette rotative & boutons](../bedienung/webinterface.md#drehencoder-taster).

## Commandes de contrôle (boutons / molette / MQTT)

Ce que fait chaque bouton par défaut est listé au
[chapitre 9 → boutons et combinaisons de boutons](../bedienung/am-geraet.md#tasten-und-tastenkombinationen) ;
les commandes s'attribuent au
[chapitre 8 → molette rotative & boutons](../bedienung/webinterface.md#drehencoder-taster).

| ID | Commande |
| --- | --- |
| 170 | Play/Pause |
| 171 / 172 | Titre précédent / suivant |
| 173 / 174 | Premier / dernier titre |
| 175 / 176 / 177 | Volume : initial / + / − |
| 178 | Mesurer la tension de la batterie |
| 179 | Veille profonde (immédiate) |
| 180 / 181 | Avancer / reculer (distance de saut réglable dans l'interface web) |
| 182 / 183 | Arrêt / redémarrage |
| 184 / 185 | Dossier suivant / précédent (modes récursifs) |
| 186 | Prévisualisation de position (geste de la molette rotative uniquement) |

## Cartes RFID virtuelles { #virtuelle-rfid-karten }

Leur utilité et la façon de les déclencher sont expliquées au
[chapitre 12 → cartes RFID virtuelles](../vertiefung/erweiterte-themen.md#virtuelle-rfid-karten).

Les identifiants `241`–`250` correspondent aux cartes `900000000001` … `900000000010`.

## API REST

L'API REST complète est maintenue sous forme de spécification OpenAPI directement dans le dépôt du
firmware : [REST-API.yaml](https://github.com/biologist79/ESPuino/blob/master/REST-API.yaml). Elle
reste ainsi synchronisée avec le code. *(Ajout possible plus tard : l'intégrer au manuel sous forme
de page Swagger interactive.)*

## Liens vers les fils de discussion du forum

- [Complete #3817](https://forum.espuino.de/t/espuino-complete/3817)
- [mini4L #1661](https://forum.espuino.de/t/espuino-mini-4layer/1661) · [Carte de développement D32 Pro #1109](https://forum.espuino.de/t/esp32-develboard-d32-pro-lifepo4/1109)
- [Carte casque #1099](https://forum.espuino.de/t/kopfhoererplatine-basierend-auf-ms6324-und-tda1308-bzw-lm4808m/1099) · [support correspondant #3792](https://forum.espuino.de/t/traeger-fuer-kopfhoererplatine/3792)
- [Kit de molette rotative #2414](https://forum.espuino.de/t/drehencoder-by-espuino/2414)
- [MediaHub #4607](https://forum.espuino.de/t/espuino-mediahub/4607)
- [LPCD #1664](https://forum.espuino.de/t/was-ist-lpcd-und-wie-funktioniert-es/1664)
- [Liste de prix #3344](https://forum.espuino.de/t/preisliste/3344)

*(Tous les liens du forum ci-dessus sont en allemand.)*

## Changelog { #changelog }

Le changelog actuel est maintenu dans le dépôt du firmware et complété en continu à cet endroit :
[changelog.md sur la branche `dev`](https://github.com/biologist79/ESPuino/blob/dev/changelog.md) –
correspondant à l'état décrit par ce manuel. La version sur la
[branche `master`](https://github.com/biologist79/ESPuino/blob/master/changelog.md) ne contient que
ce qui a déjà été publié sous forme de version stable.
