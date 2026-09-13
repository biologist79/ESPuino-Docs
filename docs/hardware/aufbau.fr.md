# 5 · Câblage

D'abord la bonne nouvelle : le montage de la [Complete](complete.md) reste simple. La carte arrive
**entièrement assemblée** – toute la soudure CMS des minuscules composants est déjà faite, et les
ponts de soudure qui configurent ton appareil sont déjà réglés en usine selon ta commande. Ce qu'il
reste à faire est réduit : souder quelques fils, connecter la molette rotative, tout mettre dans le
boîtier. Pas de CMS, pas de compétences particulières nécessaires.

Pour t'accompagner dans le montage, le
[tutoriel de montage détaillé sur le forum (#3863)](https://forum.espuino.de/t/tutorial-aufbau-complete-platine-samt-inbetriebnahme-und-tipps/3863)
(en allemand) est une bonne référence, tout comme les fils de discussion sur la
[Complete (#3817)](https://forum.espuino.de/t/espuino-complete/3817) et sur le
[kit d'encodeur (#2414)](https://forum.espuino.de/t/drehencoder-by-espuino/2414).

!!! danger "Deux choses peuvent détruire ta carte – à prendre au sérieux"
    - **Vérifie la polarité de la batterie.** Certaines batteries LFP (notamment chez Eremit) ont
      parfois été livrées avec une **polarité inversée**. Ne fais jamais confiance aveuglément au
      fait que le plus et le moins soient là où tu les attends – avant le premier branchement,
      compare **impérativement** le connecteur avec le marquage imprimé sur la carte.
    - **Ne te fie jamais à la couleur des fils.** Les couleurs des câbles de connexion ne sont pas
      normalisées ; ce qui compte, c'est toujours le marquage imprimé sur la carte. C'est
      particulièrement critique pour le **Neopixel** : inverser la polarité ici crée un
      court-circuit qui peut, dans le pire des cas, détruire toute la carte.

## Ce que tu reçois

Sont déjà assemblés, entre autres, l'ESP32-WROVER, l'amplificateur, le régulateur de charge, la
surveillance de tension, l'extenseur de ports et le lecteur de carte SD. Quelques connecteurs
optionnels restent en revanche volontairement non peuplés – en particulier celui pour l'**I²C**.
Deux raisons à cela : d'une part, l'I²C n'est simplement pas encore utilisé. D'autre part, le
connecteur I²C possède le même nombre de broches (**cinq**) que celui de la molette rotative, ce
qui pourrait les faire confondre. En laissant le connecteur I²C non peuplé, cette confusion est
exclue d'emblée.

## Les ponts de soudure { #die-lotbrucken }

Plusieurs ponts de soudure (jumpers) au dos de la carte définissent des propriétés fondamentales de
celle-ci – notamment le type de batterie, le gain et l'alimentation du lecteur RFID. La bonne
nouvelle d'abord : sur ta Complete, ils sont déjà réglés **en usine selon ta commande**
(typiquement : JP2 sur +3 dB, JP4 automatique, JP5 et JP6 selon le type de batterie, JP8 par
défaut). En temps normal, tu n'as donc rien à toucher ici. Si tu veux changer quelque chose plus
tard – par exemple changer de type de batterie –, voici ce que signifie chaque jumper. Mais d'abord,
l'essentiel :

!!! danger "À lire avant de souder"
    - **Ne pose JP5 que pour du LiPo – jamais pour du LFP !** JP5 règle la tension de fin de charge :
      posé = **4,2 V** (LiPo), ouvert = **3,6 V** (LFP). Si tu poses JP5 alors qu'une **batterie
      LFP** est connectée, celle-ci sera surchargée – **risque d'incendie !**
    - **JP6 doit correspondre au type de batterie.** JP6 sélectionne le seuil de sous-tension :
      **LFP (~2,75 V)** ou **LiPo (~3,15 V)**. Si JP6 est réglé sur **LFP** alors qu'une batterie
      **LiPo** est connectée, la coupure n'intervient qu'à 2,75 V – la LiPo est alors **déchargée
      trop profondément** et peut être endommagée. Le seuil doit donc toujours correspondre à la
      chimie de la batterie utilisée.
    - **La surveillance de sous-tension (JP6) et l'alimentation RFID (JP8) doivent être posées** –
      sinon la Complete, ou le lecteur de carte, ne fonctionne pas du tout.

| Jumper | Fonction | Positions |
| --- | --- | --- |
| **JP2 / JP3** | Gain de base de l'amplificateur audio | **Jamais les deux à la fois !**<br>JP2 = +3 dB<br>JP3 = +15 dB<br>aucun = +9 dB<br>**Posé en usine : JP2 (+3 dB)** – assez fort, et gradation du volume plus fine côté logiciel. |
| **JP4** | LED de charge interne | Ferme le circuit de la **LED embarquée** qui indique la charge (clignote/allumée/éteinte – voir [chapitre 3 → Charge & LED de charge](complete.md#laden-lade-led)). Fermé en usine à partir de la rév. 5.1 (pas de soudure nécessaire) ; avant cela, à activer avec 1+2. |
| **JP5** | Tension de fin de charge | posé = 4,2 V (**LiPo**), ouvert = 3,6 V (**LFP**) – ⚠️ voir l'avertissement ci-dessus. |
| **JP6** | Surveillance de sous-tension | 1+2 = **LFP** (~2,75 V), 2+3 = **LiPo** (~3,15 V). Un des deux **doit** être posé et **correspondre au type de batterie** – ⚠️ voir l'avertissement ci-dessus. |
| **JP8** | Alimentation RFID / LPCD | 2+3 = standard (recommandé), 1+2 = mode LPCD. **Doit** être posé. |
| **JP1** | LPCD pour le PN5180 | 1+2 = LPCD actif (IRQ sur GPIO 32, occupe alors le connecteur Ext 1), ouvert = pas de LPCD. Utile uniquement avec JP8 (1+2). |

!!! note "Changer de type de batterie plus tard"
    Le type de batterie se trouve dans **JP5** (tension de charge) et **JP6** (surveillance de
    sous-tension) – ce sont les un ou deux ponts à déplacer pour passer de LiPo à LFP (ou
    inversement) après coup. N'oublie pas ensuite d'ajuster aussi les seuils de tension de la
    batterie dans l'interface web (voir [réglage fin](#nach-dem-zusammenbau-die-feinjustierung)),
    afin que le niveau de charge soit correctement signalé par l'**anneau LED**.

## Souder les fils

Viennent maintenant les connexions que tu réalises toi-même. Elles passent par des connecteurs
JST-PH (2 mm), et – comme indiqué dans l'avertissement ci-dessus – tu te bases **toujours** sur le
**marquage imprimé sur la carte**, jamais sur la couleur des fils. À connecter :

- le **lecteur RFID** : le RC522 n'a pas besoin de tous les fils ; isole les fils inutilisés avec du
  ruban isolant par sécurité. Le PN5180, en revanche, utilise toutes les connexions. Quel fil va où
  est détaillé dans le [brochage ci-dessous](#rfid-steckerbelegung).
- le **haut-parleur** (deux broches).
- le **Neopixel** – qu'il s'agisse d'un anneau, d'une rangée ou d'une seule LED – via trois fils
  (GND, 5 V, données). Sur les anneaux, la ligne de données est généralement marquée **DI** (Data
  In) et **DO** (Data Out) ; on connecte sur **DI**. Là encore, la polarité compte particulièrement :
  **une inversion de polarité sur des LED est particulièrement risquée**, car elle se comporte
  comme un **court-circuit**.
- les **boutons** (deux broches chacun).
- la **molette rotative** : se branche dans le connecteur cinq broches. Avec le kit d'encodeur
  ESPuino, elle se **branche simplement** ; avec un autre encodeur, tu soudes toi-même les fils
  (plus de détails juste en dessous).
- éventuellement la **carte casque**, qui se branche dans le connecteur six broches.

### Brochage du connecteur RFID { #rfid-steckerbelegung }

Le connecteur RFID de la [Complete](complete.md) est un **connecteur 10 broches**. Le brochage
s'appuie sur le PN5180, qui utilise toutes les lignes ; le RC522 se contente de moins. **Le
firmware détecte automatiquement** quel lecteur est branché – le brochage relève purement du
matériel. Dans le tableau suivant, « – » indique ce dont le RC522 n'a pas besoin.

| Connecteur (Complete) | PN5180 | RC522 | Signification |
| --- | --- | --- | --- |
| **5 V** | +5 V | – | Ne fournit que 3,3 V, mais alimente quand même le PN5180 |
| **3,3 V** | +3,3 V | 3,3 V | Alimentation |
| **RST** | RST | – | Reset (PN5180 uniquement) |
| **CS** | NSS | SDA | SPI : sélection du maître/esclave |
| **MOSI** | MOSI | MOSI | SPI : maître vers esclave |
| **MISO** | MISO | MISO | SPI : esclave vers maître |
| **SCK** | SCK | SCK | SPI : horloge |
| **BUSY** | BUSY | – | Occupé (PN5180 uniquement) |
| **IRQ** | IRQ | – | Interruption (PN5180 uniquement) |
| **GND** | GND | GND | Masse |

Pour le **RC522**, seules les lignes SPI (CS/MOSI/MISO/SCK) plus **3,3 V** et **GND** sont
nécessaires ; RST, BUSY et IRQ sont laissés non connectées (elles n'ont aucun effet dans ce cas).
Source : [forum → ESPuino Complete (#3817)](https://forum.espuino.de/t/espuino-complete/3817) (en
allemand).

## La molette rotative

La carte ESPuino dispose d'un **connecteur JST-PH cinq broches, protégé contre l'inversion de
polarité**, pour la molette rotative. La façon dont l'encodeur s'y raccorde dépend de ton choix :

- Avec le **[kit d'encodeur ESPuino](https://forum.espuino.de/t/drehencoder-by-espuino/2414)**,
  **rien n'est à souder côté câblage** : il est livré avec un câble tout fait, muni de
  **connecteurs aux deux extrémités** – un côté se branche sur la carte ESPuino, l'autre sur la
  carte adaptatrice de l'encodeur. Seul le kit lui-même nécessite de la soudure, voir juste en
  dessous.
- Si tu prends **un autre encodeur rotatif quelconque**, tu ne reçois qu'un **câble de connexion
  JST-PH** cinq broches : son connecteur se branche sur la carte ESPuino, et tu **soudes toi-même
  les fils nus à l'autre extrémité** sur ton encodeur.

!!! warning "Encodeur personnel : ne pas oublier les résistances de tirage (pull-up)"
    Si tu utilises ton propre encodeur rotatif, vérifie que sa carte comporte bien des
    **résistances de tirage (pull-up)**. C'est normalement le cas sur les modules d'encodeur tout
    faits, mais un petit contrôle reste utile : si elles manquent, des **« faux contacts »**
    apparaissent, ESPuino enregistrant alors des rotations qui n'ont jamais eu lieu. Sur le kit
    d'encodeur ESPuino, elles sont déjà présentes, tu n'as donc pas à t'en soucier dans ce cas.

Le kit se compose :

- de la **molette rotative** elle-même,
- d'une petite **carte adaptatrice** (avec trois résistances pull-up déjà présentes),
- d'une **prise JST-PH** cinq broches, et
- du **câble de connexion** correspondant.

Tu dois cependant l'assembler toi-même par soudure : la molette rotative et la prise JST se
placent sur la carte adaptatrice, chacune sur un **côté opposé**.

!!! danger "Kit uniquement : souder sur le bon côté !"
    La **molette rotative** s'insère du côté où le **rectangle est imprimé** ; la **prise JST**
    se place sur **l'autre côté**. Pour vérifier : le marquage imprimé (le rectangle ou le numéro)
    doit finir **recouvert** par le composant correspondant. Si tu soudes à l'envers, l'assemblage
    ne s'ajustera pas correctement et l'encodeur ne fonctionnera pas. Les illustrations précises se
    trouvent dans le [fil de discussion sur l'encodeur (#2414)](https://forum.espuino.de/t/drehencoder-by-espuino/2414)
    (en allemand).

S'il s'avère plus tard que « plus fort » et « moins fort » sont inversés, ce n'est pas une raison
pour ressouder : le sens de rotation peut être inversé dans l'interface web
([chapitre 8 → Molette rotative & boutons](../bedienung/webinterface.md#drehencoder-taster)).

Une fois tout connecté, la suite se trouve au [montage dans le boîtier](gehaeuse.md) et au réglage
fin ci-dessous.

## Après le montage : le réglage fin { #nach-dem-zusammenbau-die-feinjustierung }

Une fois tout assemblé, vient le [premier démarrage](../inbetriebnahme/erststart.md). Il y a
quelques réglages à adapter une fois pour toutes à ton matériel spécifique – le plus simple étant de
le faire directement dans l'interface web.

Les plus importants sont les **seuils de tension de la batterie**, car ils dépendent du type de
batterie. Important à comprendre : **ESPuino ne sait absolument pas si une batterie LFP ou LiPo est
connectée** – le firmware ne peut pas le détecter. C'est précisément pour cela que tu dois régler
toi-même les seuils de tension appropriés, sinon ESPuino risque de prendre une batterie LFP pleine
pour à moitié vide, ou inversement. **Les seuils pour le LFP sont réglés par défaut** – si tu
utilises une LiPo, ajuste-les en conséquence. À titre indicatif :

| Batterie | Avertissement à partir de | première LED à partir de | toutes les LED à partir de |
| --- | --- | --- | --- |
| **LFP** (par défaut) | 3,0 V | 2,9 V | 3,25 V |
| **LiPo** | 3,2 V | 3,1 V | 4,2 V |

L'ESP32 mesure la tension de la batterie via son **ADC** intégré (convertisseur analogique-numérique)
– le composant qui traduit une tension analogique en une valeur numérique que le firmware peut
utiliser. Cet ADC n'est cependant **pas un instrument de précision** : l'affichage n'est pas exact
au dernier millivolt, mais en pratique il reste tout de même **assez bon**.

Si la tension affichée ne correspond quand même pas à la réalité – par exemple si une batterie
juste chargée est signalée comme « pas tout à fait pleine » –, la mesure peut être **calibrée** :
compare l'affichage d'ESPuino avec une mesure au multimètre et saisis la différence comme **valeur
de correction** dans les réglages de batterie de l'interface web. La valeur est prise en compte
immédiatement après l'enregistrement.

!!! info "Disponible dans l'interface web depuis septembre 2026"
    Cette valeur de correction (`offsetVoltage`) peut être réglée **directement dans l'interface
    web depuis septembre 2026**. Dans les firmwares plus anciens, cela ne se faisait que via
    `offsetVoltage` dans `settings-complete.h`.

Sinon, c'est maintenant le bon moment pour corriger si besoin le **sens de rotation des Neopixels**
et le **sens de la molette rotative**, ajuster l'**attribution des boutons** et apprendre les
premières **cartes RFID**.
