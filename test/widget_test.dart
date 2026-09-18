// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:ringfinder_1/main.dart';

void main() {
  testWidgets('affiche et valide la page de connexion', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Bienvenue sur RigFinder'), findsOneWidget);
    expect(find.text('Se connecter'), findsOneWidget);

    await tester.tap(find.text('Se connecter'));
    await tester.pump();

    expect(find.text('Saisissez votre adresse e-mail'), findsOneWidget);
    expect(find.text('Utilisez au moins 6 caractères'), findsOneWidget);
  });
}
