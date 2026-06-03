import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_mobile/features/feed/domain/entities/post_entity.dart';
import 'package:nexus_mobile/features/feed/presentation/widgets/post_card.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  group('PostCard', () {
    final tPost = PostEntity(
      id: '1',
      userId: 'user1',
      username: 'Test User',
      userAvatar: 'https://example.com/avatar.jpg',
      content: 'Test Content',
      createdAt: DateTime.now(),
      likes: 10,
      comments: 5,
      isLiked: false,
      isBookmarked: false,
      media: [],
    );

    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(
        PostCard(
          post: tPost,
          onLike: () {},
          onComment: () {},
          onShare: () {},
          onBookmark: () {},
          onTap: () {},
        ),
      );

      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);
      expect(find.text('10'), findsOneWidget); // Likes
      expect(find.text('5'), findsOneWidget); // Comments
    });

    testWidgets('calls callbacks on tap', (tester) async {
      bool likeCalled = false;
      bool commentCalled = false;

      await tester.pumpApp(
        PostCard(
          post: tPost,
          onLike: () => likeCalled = true,
          onComment: () => commentCalled = true,
          onShare: () {},
          onBookmark: () {},
          onTap: () {},
        ),
      );

      // Tap like button (assuming it's an icon button with favorite_border)
      await tester.tap(find.byIcon(Icons.favorite_border));
      expect(likeCalled, isTrue);

      // Tap comment button
      await tester.tap(find.byIcon(Icons.chat_bubble_outline));
      expect(commentCalled, isTrue);
    });
  });
}
