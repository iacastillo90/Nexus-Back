import 'package:mocktail/mocktail.dart';
import 'package:nexus_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:nexus_mobile/features/auth/domain/entities/auth_response_entity.dart';

import 'package:nexus_mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:nexus_mobile/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:local_auth/local_auth.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}
class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}
class MockLocalAuthentication extends Mock implements LocalAuthentication {}

class MockUserEntity extends Mock implements UserEntity {}
class MockAuthResponseEntity extends Mock implements AuthResponseEntity {}

void registerFallbackValues() {
  registerFallbackValue(MockUserEntity());
  registerFallbackValue(MockAuthResponseEntity());
}
