import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nexus_mobile/core/network/dio_provider.dart';
import '../../data/datasources/dreams_datasource.dart';
import '../../data/repositories/dreams_repository_impl.dart';
import '../../domain/repositories/dreams_repository.dart';
import '../../domain/entities/dream_entity.dart';
import '../../domain/entities/dream_contribution_entity.dart';

part 'dreams_providers.g.dart';

/// Dreams datasource provider
@riverpod
DreamsDataSource dreamsDataSource(DreamsDataSourceRef ref) {
  return DreamsDataSource(ref.watch(networkDioProvider));
}

/// Dreams repository provider
@riverpod
DreamsRepository dreamsRepository(DreamsRepositoryRef ref) {
  return DreamsRepositoryImpl(
    dataSource: ref.watch(dreamsDataSourceProvider),
  );
}

/// Dreams list provider
@riverpod
class DreamsList extends _$DreamsList {
  @override
  Future<List<DreamEntity>> build({DreamStatus? status}) async {
    return _loadDreams(status);
  }

  Future<List<DreamEntity>> _loadDreams(DreamStatus? status) async {
    final result = await ref.read(dreamsRepositoryProvider).getDreams(
          status: status,
          offset: 0,
          limit: 50,
        );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (dreams) => dreams,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

/// Dream detail provider
@riverpod
class DreamDetail extends _$DreamDetail {
  @override
  Future<DreamEntity> build(String dreamId) async {
    final result = await ref.read(dreamsRepositoryProvider).getDream(dreamId);

    return result.fold(
      (failure) => throw Exception(failure.message),
      (dream) => dream,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }

  Future<void> likeDream() async {
    final dreamId = state.value?.id;
    if (dreamId == null) return;

    await ref.read(dreamsRepositoryProvider).likeDream(dreamId);
    refresh();
  }
}

/// Dream contributions provider
@riverpod
class DreamContributions extends _$DreamContributions {
  @override
  Future<List<DreamContributionEntity>> build(String dreamId) async {
    final result =
        await ref.read(dreamsRepositoryProvider).getDreamContributions(dreamId);

    return result.fold(
      (failure) => throw Exception(failure.message),
      (contributions) => contributions,
    );
  }

  Future<void> addContribution(String content) async {
    final dreamId = state.value?.first.dreamId;
    if (dreamId == null) return;

    final result = await ref.read(dreamsRepositoryProvider).addContribution(
          dreamId: dreamId,
          content: content,
        );

    result.fold(
      (failure) => throw Exception(failure.message),
      (contribution) {
        // Refresh contributions and dream detail
        ref.invalidateSelf();
        ref.read(dreamDetailProvider(dreamId).notifier).refresh();
      },
    );
  }

  Future<void> likeContribution(String contributionId) async {
    await ref.read(dreamsRepositoryProvider).likeContribution(contributionId);

    // Update local state
    state.whenData((contributions) {
      final updated = contributions.map((c) {
        if (c.id == contributionId) {
          return c.copyWith(
            isLiked: !c.isLiked,
            likeCount: c.isLiked ? c.likeCount - 1 : c.likeCount + 1,
          );
        }
        return c;
      }).toList();

      state = AsyncData(updated);
    });
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
