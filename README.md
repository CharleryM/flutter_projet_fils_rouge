# RigFinder

RigFinder est une application Flutter qui a pour objectif d'aider à construire un PC de jeu pièce par pièce. L'utilisateur choisit les jeux auxquels il souhaite jouer, ajoute des composants à sa configuration et peut comparer le matériel déjà acheté ou placé dans son panier avec les composants minimaux nécessaires pour faire tourner ces jeux.

> **État actuel :** le projet est un prototype en cours de développement. L'écran de connexion Google et un catalogue de jeux filtrable sont présents. Le panier, la sélection des composants et la comparaison avec des configurations minimales ne sont pas encore implémentés.

## Fonctionnement prévu

1. Choisir un ou plusieurs jeux dans le catalogue.
2. Consulter les composants minimaux requis pour chaque jeu.
3. Composer un PC progressivement en ajoutant des composants au panier et en indiquant ceux déjà achetés.
4. Comparer la configuration et le panier aux besoins des jeux sélectionnés afin de repérer les composants manquants ou insuffisants.

Les recommandations devront s'appuyer sur des exigences matérielles associées aux jeux et sur les caractéristiques des composants. Cette logique et les données correspondantes restent à développer.

## Fonctionnement actuel

- Au démarrage, l'application initialise Firebase puis affiche la page correspondant à l'état de connexion.
- L'écran de connexion propose Google Sign-In avec Firebase Authentication. Le bouton Apple est uniquement un emplacement d'interface : Apple Sign-In n'est pas configuré.
- Après connexion, le catalogue affiche quatre jeux définis directement dans le code. Il est possible de rechercher par titre, genre ou mot-clé, de filtrer par genre et de sélectionner plusieurs jeux.
- La sélection est conservée uniquement en mémoire pendant l'utilisation de l'écran. Elle n'est pas enregistrée dans un compte ou une base de données.
- Les jeux affichent des indications générales sur le matériel à privilégier; ce ne sont pas des listes de composants minimaux vérifiées et il n'y a pas encore de calcul de compatibilité.

## Technologies et organisation

- **Flutter et Dart** pour l'application et son interface multiplateforme.
- **Firebase Core** pour initialiser Firebase et **Firebase Authentication** pour la connexion Google.
- **google_sign_in** pour le parcours de connexion Google.
- Les données des jeux sont pour l'instant codées en dur; aucune API de jeux ou de composants n'est connectée.

Principaux fichiers :

- `lib/main.dart` initialise Firebase et Google Sign-In, puis démarre l'application.
- `lib/src/app.dart` choisit entre la connexion et le catalogue selon l'état d'authentification.
- `lib/src/views/login.dart` contient l'écran de connexion.
- `lib/src/views/game_selection.dart` contient les jeux de démonstration, la recherche, les filtres et la sélection.
- `lib/src/models/game.dart` définit le modèle d'un jeu; `lib/src/widgets/` contient les éléments d'interface réutilisés.
- `lib/firebase_options.dart` contient les options Firebase générées pour les plateformes configurées.

## Prérequis

- Flutter installé, avec un SDK Dart compatible avec la contrainte du projet (`^3.10.4`).
- Un appareil ou un émulateur pris en charge, configuré et visible par Flutter.
- Pour tester la connexion Google, un projet Firebase configuré avec Google activé comme fournisseur d'authentification. Les identifiants et empreintes requis pour la plateforme de test doivent également être configurés dans Firebase et Google Cloud.

## Lancer l'application

Dans PowerShell, depuis le dossier du projet :

```powershell
flutter doctor
flutter pub get
flutter devices
flutter run
```

Si plusieurs appareils sont disponibles, préciser celui à utiliser :

```powershell
flutter run -d <identifiant_appareil>
```

La configuration Firebase du dépôt est fournie pour Android, iOS, macOS, Windows et le Web. Linux n'est pas configuré dans `firebase_options.dart`. La connexion Google peut nécessiter une configuration supplémentaire selon la plateforme et le projet Firebase utilisé.

## Vérifications

```powershell
flutter analyze
flutter test
```

Les tests widget couvrent l'affichage de la connexion, le rendu du catalogue ainsi que la recherche et la sélection d'un jeu.
