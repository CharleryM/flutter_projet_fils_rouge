# RigFinder

RigFinder est une application Flutter qui a pour objectif d'aider à construire un PC de jeu pièce par pièce, en fonction des jeux auxquels on souhaite jouer. L'utilisateur pourra comparer les composants qu'il possède déjà ou qu'il a ajoutés à son panier avec la configuration minimale nécessaire pour lancer ses jeux.

> **État actuel :** le projet fournit la connexion Firebase et un catalogue permettant de rechercher des jeux dans la boutique Steam. Le panier, l'inventaire des composants et la comparaison avec les configurations minimales restent à développer.

## Fonctionnement actuel

1. Au démarrage, Flutter initialise Firebase.
2. Si l'utilisateur n'est pas connecté, l'application affiche la page de connexion.
3. La connexion est proposée avec Google ou Apple via Firebase Authentication.
4. Après connexion, l'utilisateur accède au catalogue Steam. Il peut rechercher un jeu, consulter les résultats et sélectionner les titres auxquels il veut jouer.

La sélection des jeux est pour l'instant conservée en mémoire pendant l'utilisation de la page. Elle n'est pas enregistrée dans Firebase.

## Recherche Steam

La recherche utilise le point d'accès de recherche de la boutique Steam (`store.steampowered.com/api/storesearch/`). Elle envoie le texte saisi et récupère des résultats avec leur identifiant Steam, leur nom, leur vignette et, si disponible, les plateformes compatibles. Il faut saisir au moins deux caractères; la requête part après une pause de 350 ms. L'application affiche un indicateur de chargement pendant la requête et un message si Steam ne répond pas correctement.

Cet endpoint renvoie des résultats de recherche, pas un export exhaustif de tout le catalogue Steam. Il ne fournit pas non plus de spécifications PC minimales vérifiées. Ces données devront venir d'une autre source ou d'un référentiel maintenu par le projet pour permettre la comparaison matérielle envisagée.

L'application appelle Steam directement sur les plateformes natives. La politique CORS de Steam empêche l'appel direct depuis un navigateur : une API intermédiaire côté serveur sera nécessaire pour activer la recherche dans Flutter Web.

## Connexion et configuration Firebase

Le projet utilise Firebase Core pour l'initialisation et Firebase Authentication pour la gestion de session. Google Sign-In utilise le package `google_sign_in`. Apple utilise le fournisseur Apple de Firebase, avec une fenêtre OAuth sur le Web et le flux natif sur les plateformes prises en charge par Firebase Auth.

Avant d'utiliser les boutons de connexion :

- Activer Google et Apple comme fournisseurs dans Firebase Authentication.
- Vérifier que chaque plateforme de l'application est enregistrée dans le projet Firebase et que ses fichiers et options Firebase correspondent à cette configuration.
- Pour Google sur Android, configurer les empreintes SHA requises dans Firebase et Google Cloud.
- Pour Apple, configurer l'identifiant d'application et Sign in with Apple dans Apple Developer, puis renseigner les paramètres Apple demandés par le fournisseur Firebase.
- Sur iOS, signer l'application avec la capacité Sign in with Apple. Le projet déclare cette capacité dans `ios/Runner/Runner.entitlements`.

Le code d'initialisation Firebase se trouve dans `lib/main.dart` et les options par plateforme dans `lib/firebase_options.dart`.

## Technologies et organisation

- **Flutter et Dart** : interface multiplateforme.
- **Firebase Core et Firebase Authentication** : initialisation et authentification.
- **google_sign_in** : authentification Google.
- **http** : appels au Steam Store.

Fichiers principaux :

- `lib/main.dart` initialise Firebase et démarre l'application.
- `lib/src/app.dart` choisit la page de connexion ou le catalogue selon l'état d'authentification.
- `lib/src/views/login.dart` contient les boutons et les flux de connexion Google et Apple.
- `lib/src/views/game_selection.dart` gère la recherche Steam, l'affichage des résultats et la sélection des jeux.
- `lib/src/services/steam_store_service.dart` interroge et convertit les résultats du Steam Store.
- `lib/src/models/game.dart` définit le modèle de jeu utilisé par le catalogue.
- `lib/src/widgets/` contient les éléments d'interface réutilisés.

## Prérequis

- Flutter installé, avec un SDK Dart compatible avec la contrainte `^3.10.4` du projet.
- Un appareil ou un émulateur compatible, configuré et visible par Flutter.
- Un projet Firebase configuré avec les fournisseurs de connexion que l'on souhaite utiliser.

## Lancer l'application

Dans PowerShell, depuis la racine du projet :

```powershell
flutter doctor
flutter pub get
flutter devices
flutter run
```

Pour lancer sur un appareil précis :

```powershell
flutter run -d <identifiant_appareil>
```

Les options Firebase présentes couvrent Android, iOS, macOS, Windows et le Web. Linux n'est pas configuré dans `firebase_options.dart`. Pour Flutter Web, la connexion Apple peut fonctionner si le domaine est autorisé dans Firebase et dans la configuration Apple; la recherche Steam directe reste bloquée par CORS.
