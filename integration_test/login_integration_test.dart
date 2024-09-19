import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:unit_testing_app/home.dart';
import 'package:unit_testing_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("login test", () {
    testWidgets("login success case", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(0), "email");
      await tester.enterText(find.byType(TextField).at(1), "password");
      await tester.tap(find.byType(ElevatedButton));

      await tester.pumpAndSettle();

      expect(const Home(), findsOneWidget);
    });

    testWidgets("login failed case", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(0), "email12");
      await tester.enterText(find.byType(TextField).at(1), "password");
      await tester.tap(find.byType(ElevatedButton));

      await tester.pumpAndSettle();

      expect(find.text("Login Failed"), findsOneWidget);
    });
  });
}
