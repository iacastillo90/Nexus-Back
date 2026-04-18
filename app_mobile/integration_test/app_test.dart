import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nexus_mobile/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('verify login flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify Splash Screen -> Onboarding -> Login
      // This depends on initial state. Assuming fresh install starts at Onboarding.
      
      // Skip Onboarding
      final skipButton = find.text('Skip');
      if (tester.any(skipButton)) {
        await tester.tap(skipButton);
        await tester.pumpAndSettle();
      }

      // Verify we are on Login Screen
      expect(find.text('Welcome Back'), findsOneWidget);

      // Enter email
      final emailField = find.widgetWithText(TextField, 'Email');
      await tester.enterText(emailField, 'test@example.com');
      await tester.pumpAndSettle();

      // Enter password
      final passwordField = find.widgetWithText(TextField, 'Password');
      await tester.enterText(passwordField, 'password123');
      await tester.pumpAndSettle();

      // Tap Login
      final loginButton = find.text('Login');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Verify navigation to Home (Feed)
      // Expect to find 'Nexus Feed' or similar
      expect(find.text('Nexus Feed'), findsOneWidget);
    });
  });
}
