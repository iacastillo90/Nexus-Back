import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nexus_mobile/core/errors/failures.dart';
import 'package:nexus_mobile/features/feed/data/datasources/feed_remote_datasource.dart';
import 'package:nexus_mobile/features/feed/data/models/post_model.dart';
import 'package:nexus_mobile/features/feed/data/repositories/feed_repository_impl.dart';
import 'package:nexus_mobile/features/feed/domain/entities/post_entity.dart';

import '../../../../helpers/test_helper.dart';

void main() {
  late FeedRepositoryImpl repository;
  late MockFeedRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockFeedRemoteDataSource();
    repository = FeedRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('getFeed', () {
    final tPostModelList = [
      PostModel(
        id: '1',
        userId: 'user1',
        username: 'User 1',
        userAvatar: 'avatar1',
        content: 'Test content',
        createdAt: DateTime.now(),
        likes: 10,
        comments: 5,
        isLiked: false,
        isBookmarked: false,
      ),
    ];
    final List<PostEntity> tPostList = tPostModelList;

    test('should return list of posts when remote call is successful', () async {
      // Arrange
      when(() => mockRemoteDataSource.getFeed(page: 1))
          .thenAnswer((_) async => tPostModelList);

      // Act
      final result = await repository.getFeed(page: 1);

      // Assert
      verify(() => mockRemoteDataSource.getFeed(page: 1));
      expect(result, equals(Right(tPostList)));
    });

    test('should return ServerFailure when remote call fails', () async {
      // Arrange
      when(() => mockRemoteDataSource.getFeed(page: 1))
          .thenThrow(Exception());

      // Act
      final result = await repository.getFeed(page: 1);

      // Assert
      verify(() => mockRemoteDataSource.getFeed(page: 1));
      expect(result, isA<Left<Failure, List<PostEntity>>>());
    });
  });

  group('likePost', () {
    const tPostId = '1';

    test('should return void when remote call is successful', () async {
      // Arrange
      when(() => mockRemoteDataSource.likePost(tPostId))
          .thenAnswer((_) async => {});

      // Act
      final result = await repository.likePost(tPostId);

      // Assert
      verify(() => mockRemoteDataSource.likePost(tPostId));
      expect(result, equals(const Right(null)));
    });

    test('should return ServerFailure when remote call fails', () async {
      // Arrange
      when(() => mockRemoteDataSource.likePost(tPostId))
          .thenThrow(Exception());

      // Act
      final result = await repository.likePost(tPostId);

      // Assert
      verify(() => mockRemoteDataSource.likePost(tPostId));
      expect(result, isA<Left<Failure, void>>());
    });
  });
}
