# 2 · Démarrage rapide : du carton au premier son

Ce chapitre est le raccourci pour les impatients. Il te montre, en quelques étapes, tout le chemin
entre le déballage et le premier son – sans aucune explication entre les deux. Si tu préfères
comprendre exactement *pourquoi* telle chose se produit à telle étape, passe ce chapitre et lis
directement le [chapitre 7 · Premier démarrage](../inbetriebnahme/erststart.md), où chaque étape
est expliquée en détail et sans se presser.

!!! tip "Prérequis"
    Sur la [**Complete**](../hardware/complete.md), le firmware est déjà installé en usine – tu
    n'as donc rien à flasher. (Les montages maison avec du matériel différent doivent d'abord
    compiler leur propre firmware, voir [chapitre 13](../firmware/aktualisieren.md).)

Voici comment obtenir le premier son :

1. **Allumer l'appareil.** Au premier démarrage, ESPuino ouvre son propre réseau Wi-Fi nommé
   `ESPuino` ; quatre LED vertes signalent ce mode de configuration.
2. **Se connecter à ce réseau Wi-Fi** et ouvrir `http://192.168.4.1` dans le navigateur. Sur la
   page de configuration, saisis ton propre réseau Wi-Fi avec son mot de passe et choisis un nom
   d'hôte.
3. **Après le redémarrage**, l'interface web est accessible via `http://espuino.local` (ou l'adresse
   IP). Quatre LED blanches tournantes indiquent que la connexion est établie.
4. **Copier du contenu sur la carte SD** (histoires, livres audio, musique) – pour commencer, le
   plus rapide est de le faire directement depuis ton ordinateur (la carte doit être formatée en
   FAT32). Détails au [chapitre 10](../inhalte/verwalten.md).
5. **Apprendre la première carte :** dans l'onglet RFID, pose une carte pas encore connue (son
   numéro apparaît automatiquement), choisis un dossier ou un fichier dans l'explorateur de
   fichiers, définis le mode de lecture, puis enregistre.
6. **Pose la carte – la musique démarre.** 🎉

Voilà pour la version express. À partir d'ici, il vaut la peine de consulter ensuite le
[chapitre 8 · L'interface web](../bedienung/webinterface.md), le cœur de la configuration.
