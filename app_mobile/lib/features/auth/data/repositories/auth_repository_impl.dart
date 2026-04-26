import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/auth_response_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import 'package:local_auth/local_auth.dart';

/// 🛡️ **Implementación del Repositorio de Autenticación**
///
/// Orquesta el flujo de datos entre la API remota y el almacenamiento local.
/// Maneja la lógica de "Source of Truth" para la sesión del usuario.
///
/// **Responsabilidades:**
/// - Coordinar Login/Registro Remoto + Guardado Local de Tokens.
/// - Gestionar Biometría (Huella/FaceID) usando [LocalAuthentication].
/// - Convertir Excepciones en [Failure] (Either).
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final LocalAuthentication localAuth;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.localAuth,
  });

  /// 🔑 **Login**
  ///
  /// 1. Llama a API Remota.
  /// 2. Si es exitoso, guarda tokens en SecureStorage.
  /// 3. Retorna Entidad de Dominio.
  @override
  Future<Either<Failure, AuthResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final authResponse = await remoteDataSource.login(
        email: email,
        password: password,
      );

      // Save token locally
      if (authResponse.token != null) {
        await localDataSource.saveToken(authResponse.token!);
      }
      
      if (authResponse.refreshToken != null) {
        await localDataSource.saveRefreshToken(authResponse.refreshToken!);
      }

      return Right(authResponse.toEntity());
    } on Exception catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  /// 📝 **Registro**
  ///
  /// Similar al login, pero crea cuenta nueva.
  @override
  Future<Either<Failure, AuthResponseEntity>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final authResponse = await remoteDataSource.register(
        username: username,
        email: email,
        password: password,
      );

      // Save token locally if present
      if (authResponse.token != null) {
        await localDataSource.saveToken(authResponse.token!);
      }
      
      if (authResponse.refreshToken != null) {
        await localDataSource.saveRefreshToken(authResponse.refreshToken!);
      }

      return Right(authResponse.toEntity());
    } on Exception catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  /// 🚪 **Logout**
  ///
  /// 1. Notifica al backend.
  /// 2. Limpia almacenamiento local.
  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearAuthData();
      return const Right(unit);
    } on Exception catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  /// 👤 **Usuario Actual**
  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Right(user.toEntity());
    } on Exception catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  /// 👆 **Verificar Biometría**
  ///
  /// Solicita al SO que autentique al usuario (Huella/Cara).
  @override
  Future<Either<Failure, bool>> verifyBiometric() async {
    try {
      final isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Please authenticate to access Nexus',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      return Right(isAuthenticated);
    } on Exception catch (e) {
      return Left(PermissionFailure(message: e.toString()));
    }
  }

  /// 📱 **Disponibilidad Biométrica**
  @override
  Future<Either<Failure, bool>> isBiometricAvailable() async {
    try {
      final canCheckBiometrics = await localAuth.canCheckBiometrics;
      final isDeviceSupported = await localAuth.isDeviceSupported();
      return Right(canCheckBiometrics && isDeviceSupported);
    } on Exception catch (e) {
      return Left(PermissionFailure(message: e.toString()));
    }
  }
}
