import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:shortmyurl/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Url Testing', () {
    testWidgets('Submit wrong info to TextField',
            (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();
          await tester.enterText(find.byType(TextField), 'Google');
          print('Wrong url submitted');
          final urlErrorFinder = find.text('Wrong URL, please check this value');
          await tester.pump(const Duration(seconds: 3));
          print('Test passed with wrong url');
          expect(urlErrorFinder, findsOneWidget);
          await tester.pump(const Duration(seconds: 3));
          print('Let\'s submit correct url!');
          await tester.enterText(find.byType(TextField), 'www.google.com.mx');
          await tester.pump(const Duration(seconds: 3));
          await tester.tap(find.byType(ElevatedButton));
          await tester.pump(const Duration(seconds: 3));
          print('All done ;)');
        });
  });
}
