# 4 · La batterie

ESPuino fonctionne sans problème durablement sur alimentation USB – mais pour un usage mobile, il te
faut une batterie. Comme la vraie sécurité est en jeu avec les batteries au lithium, le sujet
mérite son propre chapitre. Merci de le lire avant de connecter une batterie.

!!! danger "N'utilise que des batteries lithium **avec BMS** – sinon risque d'incendie !"
    N'utilise **jamais** une batterie lithium **sans circuit de protection (BMS, Battery Management
    System)**. Une batterie non protégée peut être surchargée ou trop déchargée et **prendre feu**.
    Achète donc un **pack de batterie tout fait avec BMS intégré** – il n'y a aucun compromis
    possible sur ce point.

## LFP ou LiPo ?

Cela étant acquis, il reste à choisir le type. Les deux sont brièvement expliqués dans le
[glossaire](../einstieg/was-ist-espuino.md) ; pour décider, cette comparaison suffit :

| | **LFP (LiFePO₄)** | **LiPo** |
| --- | --- | --- |
| Sécurité | très sûre | nettement plus dangereuse |
| Choix de packs tout faits | limité (en pratique, seulement celui mentionné ci-dessous) | large |
| Densité énergétique / autonomie | plus faible | plus élevée |

En résumé : le LFP est l'enfant sage et sûr, le LiPo le plus compact avec plus de choix – mais aussi
celui qui exige le plus de prudence.

## Recommandation : packs tout faits

La solution la plus simple et la plus sûre consiste à prendre un pack tout fait chez
**[Eremit](https://www.eremit.de/)** (revendeur allemand) – la protection y est déjà intégrée, avec
le **connecteur JST-PH** adapté :

- **LiPo :** dans la [gamme LiPo 3,7 V](https://www.eremit.de/c/3-7v-lipo-akkus) ; environ
  **2500 mAh** est une bonne recommandation.
- **LFP :** le [pack 3,2 V 6000 mAh avec protection](https://www.eremit.de/p/3-2v-6000mah-pack-mit-schutz-arduino-aio-jst-ph-2-0-stecker)
  – c'est la seule taille disponible ici.

!!! tip "Pour les bricoleurs"
    Si tu préfères assembler toi-même un pack LFP avec circuit de protection, un guide est
    disponible sur le forum : [Un petit pack LiFePO4 fait maison avec BMS (#1592)](https://forum.espuino.de/t/ein-kleiner-lifepo4-akkupack-mit-schutzschaltung-bms-im-selbstbau/1592)
    (en allemand). Là aussi, sans exception : **jamais sans BMS.**

## Connexion

Le type de batterie se règle sur la carte via des ponts de soudure – préréglés en usine selon ta
commande, modifiables par la suite. Les détails se trouvent dans les
[ponts de soudure au chapitre 5](aufbau.md#die-lotbrucken).

!!! warning "Toujours vérifier la polarité du connecteur !"
    Ne fais jamais confiance aveuglément au connecteur – vérifie la **polarité** en la comparant au
    marquage imprimé sur la carte avant de brancher. Il y a déjà eu des packs avec un câblage
    inversé, et une polarité incorrecte peut détruire la carte. Des remarques à ce sujet figurent
    aussi sur la fiche du
    [pack Eremit](https://www.eremit.de/p/3-2v-6000mah-pack-mit-schutz-arduino-aio-jst-ph-2-0-stecker).

## Quel est le niveau de charge de la batterie ?

ESPuino affiche le niveau de charge via les Neopixels et dans l'interface web. Pour bien comprendre
cet affichage, il faut savoir **comment** il est calculé : ESPuino mesure la **tension de la
batterie** et en déduit le niveau de charge. Cela ne nécessite aucun matériel supplémentaire, mais
présente une faiblesse de principe – en particulier avec le **LFP**. Sa tension reste quasiment
constante sur une grande partie de la décharge (environ 3,2 V sur une large plage de charge), ce
qui ne permet qu'une lecture approximative du niveau réel de la batterie. Avec le **LiPo**, la
courbe de décharge est plus marquée, et l'estimation est donc plus précise.

Un affichage vraiment exact nécessiterait un **compteur coulombmétrique**, qui compterait la charge
réellement prélevée. Un tel composant n'est actuellement **pas** intégré à la Complete – l'affichage
de charge reste donc une estimation basée sur la tension, avec l'imprécision mentionnée pour le LFP.

!!! note "Pendant la charge"
    Si une charge est en cours via USB, la tension mesurée est artificiellement relevée et donc non
    significative. Un affichage fiable du niveau de charge n'existe donc que lorsque l'appareil
    fonctionne **uniquement sur batterie**.
