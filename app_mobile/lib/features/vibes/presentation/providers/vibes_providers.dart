import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nexus_mobile/core/network/dio_provider.dart';
import '../../data/datasources/vibes_remote_datasource.dart';
import '../../data/repositories/vibes_repository_impl.dart';
import '../../domain/repositories/vibes_repository.dart';
import '../../domain/entities/vibes_entity.dart';

part 'vibes_providers.g.dart';

/// Vibes remote datasource provider
@riverpod
VibesRemoteDataSource vibesRemoteDataSource(VibesRemoteDataSourceRef ref) {
  return VibesRemoteDataSource(ref.watch(networkDioProvider));
}

/// Vibes repository provider
@riverpod
VibesRepository vibesRepository(VibesRepositoryRef ref) {
  return VibesRepositoryImpl(
    remoteDataSource: ref.watch(vibesRemoteDataSourceProvider),
  );
}

/// User vibes provider
@riverpod
class UserVibes extends _$UserVibes {
  @override
  Future<VibesEntity> build(String userId) async {
    final result = await ref.read(vibesRepositoryProvider).getUserVibes(userId);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (vibes) => vibes,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

/// Community pulse provider
@riverpod
class CommunityPulse extends _$CommunityPulse {
  @override
  Future<Map<String, double>> build() async {
    final result = await ref.read(vibesRepositoryProvider).getCommunityPulse();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (pulse) => pulse,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
