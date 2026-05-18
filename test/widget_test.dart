import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:orukam/providers/competition_provider.dart';
import 'package:orukam/screens/competition_screen.dart';
import 'package:orukam/models.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    // Initialize sqflite for tests
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  Widget createTestWidget() {
    return ChangeNotifierProvider(
      create: (context) => CompetitionProvider(),
      child: const MaterialApp(
        home: CompetitionScreen(),
      ),
    );
  }

  testWidgets('CompetitionScreen initial state test', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Check if the default competition name is visible
    // Note: Since it's dynamic from DB, we check for part of the UI
    expect(find.text('Resp. Arbitre'), findsOneWidget);
    expect(find.text('Resp. Commissaire'), findsOneWidget);
    expect(find.text('Aucun tapis ajouté'), findsOneWidget);
  });

  testWidgets('Add Tapis dialog appears', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Find and tap the FloatingActionButton
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Verify dialog is shown
    expect(find.text('Nouveau Tapis'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
