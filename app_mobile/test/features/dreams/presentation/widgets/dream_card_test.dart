import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_mobile/features/dreams/domain/entities/dream_entity.dart';
import 'package:nexus_mobile/features/dreams/presentation/widgets/dream_card.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  group('DreamCard', () {
    final tDream = DreamEntity(
      id: '1',
      title: 'Test Dream',
      description: 'Test Description',
      imageUrl: 'https://example.com/dream.jpg',
      progress: 0.5,
      participantsCount: 10,
      status: DreamStatus.active,
      createdAt: DateTime.now(),
      contributions: [],
    );

    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(
        DreamCard(
          dream: tDream,
          onTap: () {},
        ),
      );

      expect(find.text('Test Dream'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      // Progress indicator might be hard to test by text, but we can check for LinearProgressIndicator
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('calls onTap callback', (tester) async {
      bool tapped = false;

      await tester.pumpApp(
        DreamCard(
          dream: tDream,
          onTap: () => tapped = true,
        ),
      );

      await tester.tap(find.byType(DreamCard));
      expect(tapped, isTrue);
    });
  });
}
