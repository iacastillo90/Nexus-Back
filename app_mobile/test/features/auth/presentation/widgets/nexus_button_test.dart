import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_mobile/features/auth/presentation/widgets/nexus_button.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  group('NexusButton', () {
    testWidgets('renders text correctly', (tester) async {
      await tester.pumpApp(
        NexusButton(
          child: const Text('Test Button'),
          onPressed: () {},
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('shows loading indicator when isLoading is true', (tester) async {
      await tester.pumpApp(
        NexusButton(
          onPressed: () {},
          isLoading: true,
          child: const Text('Test Button'),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Test Button'), findsNothing);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var pressed = false;
      await tester.pumpApp(
        NexusButton(
          child: const Text('Test Button'),
          onPressed: () => pressed = true,
        ),
      );

      await tester.tap(find.byType(NexusButton));
      expect(pressed, isTrue);
    });
  });
}
