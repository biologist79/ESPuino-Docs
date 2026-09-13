# 17 · Développement et contribution

ESPuino est un projet ouvert, et les contributions sont les bienvenues. Ce chapitre s'adresse à
toutes celles et ceux qui souhaitent travailler eux-mêmes sur le code, prendre en charge leur propre
matériel, ou reverser des améliorations au projet. Il te donne une première orientation ; le
[README du dépôt ESPuino](https://github.com/biologist79/ESPuino) va encore plus loin dans le
détail.

!!! note "Aider sans programmer, c'est possible : teste !"
    Un mot honnête pour commencer : malheureusement, seules quelques personnes participent encore
    aux **tests** – alors que c'est justement ce dont le projet vit. Et pour cela, tu n'as pas besoin
    d'écrire une seule ligne de code : flashe les nouveaux **builds `dev`**, utilise-les au
    quotidien, et fais un retour sur le [forum](https://forum.espuino.de) sur ce qui fonctionne bien
    et ce qui ne fonctionne pas. Chaque retour aide à détecter les bugs tôt et à garder ESPuino
    stable.

## Comment le code est structuré

Le code du firmware se trouve sous `src/` et est organisé par domaine de responsabilité. Si tu le
parcours pour la première fois, cette carte grossière t'aidera :

- **Cœur et déroulement :** `main` contient `setup()` et la `loop()`, `System` gère le mode de
  fonctionnement, la veille profonde et le redémarrage, et `Cmd` distribue les commandes provenant
  des cartes, des boutons ou de MQTT.
- **Audio :** `AudioPlayer` contrôle la playlist, les modes de lecture et la lecture elle-même,
  `SdCard` gère l'accès à la carte.
- **RFID :** `RfidCommon`, `RfidConfig`, `RfidRuntime` (la détection automatique), ainsi que les
  modules spécifiques aux lecteurs `RfidMfrc522` et `RfidPn5180`.
- **Entrées :** `Button`, `RotaryEncoder`, `IrReceiver` et `HallEffectSensor`.
- **Affichage :** `Led`, avec toutes les animations Neopixel.
- **Réseau :** `Wlan`, `Web` (interface web et API REST), `Mqtt` et `Ftp`.
- **Autres :** `Bluetooth`, `Battery` / `BatteryMeasureVoltage`, `Port` (GPIO et extenseur de
  ports), `Power` et `MediaHub`.
- **Infrastructure :** `Log` et les `LogMessages_*` (traductions), ainsi que `Queues`, `MemX` et
  `Common`.

## Prendre en charge ses propres cartes

Si tu veux faire fonctionner ESPuino sur un matériel différent, la voie prévue est la carte
`HAL 99`, qui inclut le fichier `settings-custom.h`. Là – comme dans les autres
`settings-<carte>.h` – tu attribues les broches et définis les flags de fonctionnalités. Pour
rappel des plages de numéros : les GPIO natifs de l'ESP32 vont de `0` à `39`, les canaux de
l'extenseur de ports de `100` à `115`. Plus de détails dans la
[configuration à la compilation](../firmware/compile-zeit.md).

## Conventions, pull requests et CI

Pour que tout reste cohérent, quelques règles du jeu :

- **Formatage :** le code est formaté avec `clang-format` (les règles se trouvent dans
  `.clang-format` dans le dépôt). Le mieux est de l'appliquer avant chaque commit.
- **Branches :** les nouvelles fonctionnalités partent de `dev`, et les pull requests visent
  **toujours `dev` – jamais `master`**. La branche `master` ne reçoit les fusions de version qu'à
  intervalles plus longs.
- **Annoncer les fonctionnalités importantes au préalable :** si tu prévois un changement conséquent,
  merci d'annoncer la fonctionnalité **au préalable sur le [forum](https://forum.espuino.de)**, afin
  que sa pertinence puisse être discutée ensemble. Tu éviteras ainsi d'investir beaucoup de travail
  dans une direction qui, en fin de compte, ne sert pas le projet dans son ensemble.
- **CI :** GitHub Actions compile automatiquement le firmware – un coup d'œil dans
  `.github/workflows/` montre ce qui s'y passe.
