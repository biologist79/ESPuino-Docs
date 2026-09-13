# 11 · Gérer plusieurs ESPuinos de façon centralisée : MediaHub

## Quel problème MediaHub résout

Tant que tu n'exploites qu'un seul ESPuino, tout est simple : tu configures tes attributions de
cartes dans l'interface web, et elles se trouvent dans la mémoire de cet unique appareil. Mais dès
que plusieurs ESPuinos se trouvent dans le foyer – un dans la chambre d'enfant, un dans le salon, un
pour la route –, la maintenance devient fastidieuse. Il faudrait apprendre chaque nouvelle carte
individuellement sur chaque appareil, et remplir chaque carte SD séparément.

C'est exactement ce problème que résout **MediaHub**. MediaHub est un composant additionnel
**optionnel** qui te permet de gérer les attributions de cartes **de façon centralisée** en un seul
endroit, au lieu de le faire séparément sur chaque appareil. Si tu n'as qu'un seul ESPuino, tu n'as
pas besoin de MediaHub – pour tous les autres cas, cela peut considérablement simplifier la gestion.

!!! info "Où trouver le guide complet"
    Ce chapitre te donne le concept et une entrée en matière. La documentation détaillée sur la
    configuration et l'exploitation est tenue à jour directement dans le
    [dépôt MediaHub](https://github.com/biologist79/ESPuino-Mediahub), et la discussion approfondie
    se déroule dans le
    [fil de discussion du forum #4607](https://forum.espuino.de/t/espuino-mediahub/4607) (en
    allemand).

## Comment ça fonctionne

MediaHub est un petit **service serveur auto-hébergé**, qui tourne sous forme de conteneur Docker
sur ton propre réseau – les données restent donc chez toi, rien ne part vers un cloud tiers. Ce
service serveur détient les attributions de cartes centralisées.

Sur l'ESPuino lui-même, tu indiques ensuite dans l'interface web quel(s) serveur(s) MediaHub
existent. Quand tu poses une carte configurée pour MediaHub, l'ESPuino demande au serveur ce qui
correspond à cette carte, et télécharge les fichiers nécessaires sur sa carte SD la première fois.
Ensuite, il joue localement depuis sa propre carte.

Si tu changes quelque chose de façon centralisée, la mise à jour **ne se fait pas automatiquement** :
tu la déclenches sur MediaHub avec **« Force Refresh »**. L'ESPuino remarque alors la nouvelle
version à la prochaine pose de la carte, télécharge les fichiers modifiés, puis joue la version
actuelle. Les flux de radio web peuvent aussi être attribués de cette façon.

!!! note "Ce qui est centralisé – et ce qui ne l'est pas"
    MediaHub ne te dispense pas de **poser les cartes** : tu dois toujours poser chaque carte **une
    fois par appareil** et la faire pointer vers MediaHub à cet endroit. La raison : sinon, MediaHub
    lui-même aurait besoin de son propre lecteur RFID juste pour connaître l'ID de la carte. Ce qui
    est centralisé, c'est uniquement le **lien réel vers le contenu** – c'est-à-dire quels fichiers
    ou quel flux, et quel mode de lecture, correspondent à une carte. Tu maintiens cette association
    une seule fois sur MediaHub, et chaque appareil la récupère à partir de là.

## Configurer le serveur MediaHub

Le serveur se démarre comme conteneur Docker. La version courte se présente ainsi (les détails
complets se trouvent dans le dépôt MediaHub) :

```bash
cp env-example .env       # tes propres réglages vont dans .env
mkdir -p data
chown -R 33:33 data
docker compose up -d --build
```

L'astuce : tes réglages personnels se trouvent dans le fichier `.env`, pas dans les fichiers
fournis. Cela a une raison pratique – cela permet à une mise à jour ultérieure de rester sans
conflit :

```bash
git pull
docker compose up -d --build
```

## Attribuer des cartes de façon centralisée

Dans l'onglet RFID de l'ESPuino, tu enregistres ton serveur MediaHub (ou plusieurs). Une carte à
laquelle tu attribues le mode MediaHub récupère son « manifeste » auprès du serveur lorsqu'elle est
posée – c'est-à-dire l'information sur ce qu'elle doit jouer –, télécharge les fichiers la première
fois, puis les maintient à jour ensuite via une somme de contrôle.

## Pour aller plus loin

- [ESPuino-Mediahub sur GitHub](https://github.com/biologist79/ESPuino-Mediahub) – la documentation
  complète.
- [Fil de discussion du forum #4607](https://forum.espuino.de/t/espuino-mediahub/4607) – présentation
  et discussion (en allemand).
