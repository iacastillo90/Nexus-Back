import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/auth_response_entity.dart';
import '../entities/user_entity.dart';

/// 🔐 **Repositorio de Autenticación (Contrato)**
///
/// Define las operaciones disponibles para gestionar la identidad del usuario.
/// Abstrae la fuente de datos (Remota/Local) de la lógica de negocio.
///
/// **Responsabilidades:**
/// - Definir métodos para Login, Registro y Logout.
/// - Gestionar la sesión del usuario actual.
/// - Especificar contratos para autenticación biométrica.
///
/// **Implementación:**
/// - Ver `lib/features/auth/data/repositories/auth_repository_impl.dart`
abstract class AuthRepository {
  /// 🔑 **Iniciar Sesión**
  ///
  /// Autentica al usuario con credenciales básicas.
  ///
  /// **Parámetros:**
  /// - [email]: Correo electrónico.
  /// - [password]: Contraseña.
  ///
  /// **Retorno:**
  /// - [Right]: [AuthResponseEntity] con tokens y usuario.
  /// - [Left]: [Failure] (ServerFailure, AuthFailure).
  Future<Either<Failure, AuthResponseEntity>> login({
    required String email,
    required String password,
  });

  /// 📝 **Registrar Usuario**
  ///
  /// Crea una nueva cuenta y devuelve la sesión iniciada.
  Future<Either<Failure, AuthResponseEntity>> register({
    required String username,
    required String email,
    required String password,
  });

  /// 🚪 **Cerrar Sesión**
  ///
  /// Termina la sesión actual y limpia datos locales.
  Future<Either<Failure, Unit>> logout();

  /// 👤 **Obtener Usuario Actual**
  ///
  /// Recupera los datos del usuario logueado (desde caché o red).
  Future<Either<Failure, UserEntity>> getCurrentUser();

  /// 👆 **Verificar Biometría**
  ///
  /// Solicita autenticación por huella/rostro al sistema operativo.
  Future<Either<Failure, bool>> verifyBiometric();

  /// 📱 **Disponibilidad Biométrica**
  ///
  /// Verifica si el dispositivo soporta y tiene configurada la biometría.
  Future<Either<Failure, bool>> isBiometricAvailable();
}
