import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/profile_entity.dart';
import '../entities/karma_entity.dart';

/// 👤 **Repositorio de Perfil (Contrato)**
///
/// Define las operaciones relacionadas con perfiles de usuario, seguimiento y reputación.
///
/// **Responsabilidades:**
/// - Ver perfiles (Propio y de otros).
/// - Editar perfil.
/// - Sistema de Follow/Unfollow.
/// - Consultar Karma y Logros.
///
/// **Implementación:**
/// - Ver `lib/features/profile/data/repositories/profile_repository_impl.dart`
abstract class ProfileRepository {
  /// 🔍 **Obtener Perfil por ID**
  Future<Either<Failure, ProfileEntity>> getProfile(String userId);

  /// 🏠 **Obtener Mi Perfil**
  Future<Either<Failure, ProfileEntity>> getCurrentProfile();

  /// ✏️ **Actualizar Perfil**
  ///
  /// Permite modificar campos individuales.
  Future<Either<Failure, ProfileEntity>> updateProfile({
    String? bio,
    String? location,
    String? website,
    String? avatarPath,
    String? coverImagePath,
  });

  /// ➕ **Seguir Usuario**
  Future<Either<Failure, Unit>> followUser(String userId);

  /// ➖ **Dejar de Seguir**
  Future<Either<Failure, Unit>> unfollowUser(String userId);

  /// ⭐ **Obtener Detalles de Karma**
  ///
  /// Recupera el desglose de puntos, nivel y medallas.
  Future<Either<Failure, KarmaEntity>> getKarmaDetails(String userId);
}
