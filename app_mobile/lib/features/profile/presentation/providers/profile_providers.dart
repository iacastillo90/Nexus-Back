import 'package:nexus_mobile/core/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/profile_datasource.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/entities/profile_entity.dart';

part 'profile_providers.g.dart';

/// ☁️ **Proveedor de DataSource (Profile)**
@riverpod
ProfileDataSource profileDataSource(ProfileDataSourceRef ref) {
  return ProfileDataSource(ref.watch(networkDioProvider));
}

/// 🛡️ **Proveedor de Repositorio (Profile)**
@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  return ProfileRepositoryImpl(
    profileDataSource: ref.watch(profileDataSourceProvider),
  );
}

/// 👤 **Controlador del Perfil Actual**
///
/// Gestiona el estado del perfil del usuario logueado.
/// Permite editar datos y ver estadísticas propias.
@riverpod
class CurrentProfile extends _$CurrentProfile {
  /// 🏗️ **Carga Inicial**
  @override
  Future<ProfileEntity> build() async {
    return await _loadProfile();
  }

  /// 📥 **Cargar Perfil**
  Future<ProfileEntity> _loadProfile() async {
    final result = await ref.read(profileRepositoryProvider).getCurrentProfile();

    return result.fold(
      (failure) => throw Exception(failure.message),
      (profile) => profile,
    );
  }

  /// 🔄 **Refrescar**
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadProfile());
  }

  /// ✏️ **Actualizar Datos**
  Future<void> updateProfile({
    String? bio,
    String? location,
    String? website,
  }) async {
    final result = await ref.read(profileRepositoryProvider).updateProfile(
          bio: bio,
          location: location,
          website: website,
        );

    result.fold(
      (failure) {
        // Show error
      },
      (updatedProfile) {
        state = AsyncData(updatedProfile);
      },
    );
  }
}

/// 👥 **Controlador de Perfil de Usuario**
///
/// Gestiona la vista del perfil de OTRO usuario.
/// Permite seguir/dejar de seguir.
///
/// **Argumentos:**
/// - [userId]: ID del usuario a visualizar.
@riverpod
class UserProfile extends _$UserProfile {
  @override
  Future<ProfileEntity> build(String userId) async {
    return await _loadProfile();
  }

  Future<ProfileEntity> _loadProfile() async {
    final result = await ref.read(profileRepositoryProvider).getProfile(userId);

    return result.fold(
      (failure) => throw Exception(failure.message),
      (profile) => profile,
    );
  }

  /// ➕/➖ **Toggle Follow (Optimista)**
  Future<void> toggleFollow() async {
    final currentProfile = state.value;
    if (currentProfile == null) return;

    final isFollowing = currentProfile.isFollowing ?? false;

    // Optimistic update
    state = AsyncData(
      currentProfile.copyWith(
        isFollowing: !isFollowing,
        followersCount: isFollowing
            ? currentProfile.followersCount - 1
            : currentProfile.followersCount + 1,
      ),
    );

    // API call
    final result = isFollowing
        ? await ref.read(profileRepositoryProvider).unfollowUser(userId)
        : await ref.read(profileRepositoryProvider).followUser(userId);

    result.fold(
      (failure) {
        // Revert on error
        state = AsyncData(currentProfile);
      },
      (_) {
        // Success - keep optimistic update
      },
    );
  }

  /// 🔄 **Refrescar**
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadProfile());
  }
}
