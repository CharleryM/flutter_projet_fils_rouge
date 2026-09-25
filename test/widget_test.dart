// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ringfinder_1/main.dart';
import 'package:ringfinder_1/src/views/game_selection.dart';
import 'package:ringfinder_1/src/widgets/game_card.dart';

void main() {
  testWidgets('affiche la page de connexion actuelle', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Connexion'), findsOneWidget);
    expect(find.text('Connectez-vous à votre espace RigFinder.'), findsOneWidget);
    expect(find.text('Continuer avec Google'), findsOneWidget);
    expect(find.text('Continuer avec Apple'), findsOneWidget);
  });

  testWidgets('affiche la page de sélection de jeux sans erreur de rendu', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GameSelectionPage()));

    expect(find.text('Quels sont tes jeux favoris ?'), findsOneWidget);
    expect(find.text('Cyberpunk 2077'), findsOneWidget);
  });

  testWidgets('permet de sélectionner et rechercher un jeu', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GameSelectionPage()));

    await tester.tap(find.byType(GameCard).first);
    await tester.pump();
    expect(find.text('1 jeu sélectionné'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Valorant');
    await tester.pump();
    expect(find.text('CS2 / Valorant'), findsOneWidget);
    expect(find.text('Cyberpunk 2077'), findsNothing);
  });
}
