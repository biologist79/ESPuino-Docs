# 6 · Le boîtier

Où placer la carte une fois entièrement câblée ? La plupart des ESPuinos logent dans un **boîtier
imprimé en 3D** – la taille, la couleur et la forme sont entièrement à ta discrétion. Ce chapitre te
donne un point de départ ; il ne faut pas plus qu'un modèle de référence et quelques conseils pour
cela.

!!! tip "Laisse-toi inspirer par la galerie"
    La diversité des ESPuinos – de l'impression 3D au bois, jusqu'aux objets de récupération
    transformés – est illustrée par la galerie
    [« Zeigt her eure ESPuinos » (#554)](https://forum.espuino.de/t/zeigt-her-eure-espuinos/554)
    (forum en allemand). Une belle source d'inspiration pour ton propre boîtier.

## Le modèle de référence : la BioBox { #referenz-design-biobox }

La **[BioBox 3D](https://forum.espuino.de/t/biobox-3d/3130)** (forum en allemand) sert de **modèle
de référence** : un boîtier imprimable en 3D pour la Complete ou la mini4L. Elle donne une bonne
idée de ce à quoi peut ressembler un ESPuino terminé : un cube d'environ 12 cm de côté, une grille
en nid d'abeille à l'avant pour le haut-parleur avec un renfoncement pour l'anneau Neopixel, trois
boutons et la molette rotative sur le dessus, l'USB-C et la prise casque à l'arrière, une trappe de
révision et un support de batterie en dessous (pour cellules 18650, 26650 ou 32700). Les fichiers
d'impression sont disponibles au format STL et en fichier Fusion 360 ; les réglages recommandés sont
le PETG, cinq couches de paroi et 35 % de remplissage (environ 17 heures d'impression sur une Bambu
Lab P1S).

## Pas obligatoirement de l'impression 3D : le bois et autres solutions

L'impression 3D est l'approche la plus répandue, mais loin d'être la seule. Certains prennent un
**boîtier en bois tout fait** (par exemple une boîte en bois du rayon loisirs créatifs) et y
pratiquent eux-mêmes les découpes nécessaires ; d'autres **construisent leur boîtier entièrement en
bois**. La **[BioBox v2 (#1654)](https://forum.espuino.de/t/biobox-v2/1654)** (forum en allemand) en
est un bel exemple – la prédécesseure en bois de l'actuelle BioBox 3D.

## Ce à quoi penser pour le boîtier

Qu'il s'agisse de la BioBox ou d'une création personnelle – chaque boîtier devrait prévoir quelques
découpes, accès et surfaces libres :

- **Lecteur RFID** – c'est le seul composant qui n'a besoin d'*aucune* ouverture, mais d'une
  **surface libre** : il lit à travers la paroi du boîtier. Prévois donc un endroit où le lecteur se
  trouve et où l'on pose les cartes – sans métal entre les deux et avec une paroi pas trop épaisse.
- **Haut-parleur** – une grille ou des trous devant la membrane, pour que rien ne puisse
  s'enfoncer.
- **Neopixel** – une ouverture ou une fenêtre translucide pour l'anneau. Les LED nues ne sont pas
  particulièrement esthétiques en elles-mêmes ; un **anneau diffuseur** les masque et rend la
  lumière à la fois plus douce et plus homogène.
- **Boutons et molette rotative** – des découpes aux endroits appropriés.
- **USB-C** – facilement accessible pour la charge et le flashage. Les **connecteurs USB
  magnétiques** ont fait leurs preuves ici : le petit adaptateur reste en permanence dans la prise,
  tandis que le câble s'y fixe magnétiquement depuis l'extérieur. Surtout, rien ne peut être arraché
  accidentellement : si quelqu'un trébuche sur le câble ou tire dessus, la connexion magnétique se
  détache simplement au lieu d'endommager la prise ou la carte. En prime, on vise aussi plus
  facilement l'ouverture du boîtier avec ce système.
- **Prise casque** – si tu installes la carte casque. Contrairement à l'USB, tu ne peux **pas**
  utiliser ici un adaptateur qui reste branché en permanence ou une rallonge : dès qu'une fiche
  casque est insérée, ESPuino le détecte comme « casque connecté » et le haut-parleur reste muet. La
  prise elle-même doit donc être accessible depuis l'extérieur. Pour que la petite carte ne se
  retrouve pas à traîner librement dans le boîtier, il existe un **support imprimable en 3D** pour
  elle : [support pour la carte casque (#3792)](https://forum.espuino.de/t/traeger-fuer-kopfhoererplatine/3792)
  (forum en allemand).
- **Carte SD** – le logement *peut* rester accessible, par exemple via une trappe de révision, pour
  pouvoir retirer la carte et y charger du contenu. Ce n'est toutefois pas obligatoire : le contenu
  peut tout aussi bien être transféré par Wi-Fi ([chapitre 10](../inhalte/verwalten.md)). Pense
  aussi au revers de la médaille – ce qui est accessible l'est aussi pour les enfants, et les cartes
  SD sont fragiles.
- **Batterie** – un support adapté à la taille de tes cellules.

## Pas d'imprimante 3D ?

Pas d'imprimante à la maison ? Aucun problème : tu peux faire réaliser les fichiers d'impression par
un **service d'impression**, ou demander à quelqu'un de la **communauté** – le
[forum](https://forum.espuino.de) compte souvent quelqu'un prêt à donner un coup de main.
