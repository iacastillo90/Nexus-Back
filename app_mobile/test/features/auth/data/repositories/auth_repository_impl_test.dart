import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nexus_mobile/core/errors/failures.dart';
import 'package:nexus_mobile/features/auth/data/models/auth_response_model.dart';
import 'package:nexus_mobile/features/auth/data/models/user_model.dart';
import 'package:nexus_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nexus_mobile/features/auth/domain/entities/auth_response_entity.dart';

import '../../../../helpers/test_helper.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;
  late MockLocalAuthentication mockLocalAuth;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    mockLocalAuth = MockLocalAuthentication();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      localAuth: mockLocalAuth,
    );
  });

  group('login', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    final tAuthResponseModel = AuthResponseModel(
      token: 'token',
      refreshToken: 'refreshToken',
      user: UserModel(
        id: '1',
        username: 'testuser',
        email: 'test@example.com',
        isActive: true,
        isVerified: true,
        echoEnabled: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    final tAuthResponseEntity = tAuthResponseModel.toEntity();

    test(
      'should return AuthResponseEntity when remote call is successful',
      () async {
        // Arrange
        when(() => mockRemoteDataSource.login(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => tAuthResponseModel);
        when(() => mockLocalDataSource.saveToken(any()))
            .thenAnswer((_) async => {});
        when(() => mockLocalDataSource.saveRefreshToken(any()))
            .thenAnswer((_) async => {});

        // Act
        final result = await repository.login(email: tEmail, password: tPassword);

        // Assert
        verify(() => mockRemoteDataSource.login(email: tEmail, password: tPassword));
        verify(() => mockLocalDataSource.saveToken(tAuthResponseModel.token));
        expect(result, Right(tAuthResponseEntity));
      },
    );

    test(
      'should return AuthFailure when remote call fails',
      () async {
        // Arrange
        when(() => mockRemoteDataSource.login(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenThrow(Exception('Server error'));

        // Act
        final result = await repository.login(email: tEmail, password: tPassword);

        // Assert
        verify(() => mockRemoteDataSource.login(email: tEmail, password: tPassword));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, isA<Left<Failure, AuthResponseEntity>>());
      },
    );
  });
}
