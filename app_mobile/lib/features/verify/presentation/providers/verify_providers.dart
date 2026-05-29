import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nexus_mobile/core/network/dio_provider.dart';
import '../../data/datasources/verify_datasource.dart';
import '../../data/repositories/verify_repository_impl.dart';
import '../../domain/repositories/verify_repository.dart';
import '../../domain/entities/verification_result_entity.dart';

part 'verify_providers.g.dart';

/// Verify datasource provider
@riverpod
VerifyDataSource verifyDataSource(VerifyDataSourceRef ref) {
  return VerifyDataSource(ref.watch(networkDioProvider));
}

/// Verify repository provider
@riverpod
VerifyRepository verifyRepository(VerifyRepositoryRef ref) {
  return VerifyRepositoryImpl(
    dataSource: ref.watch(verifyDataSourceProvider),
  );
}

/// Verification result provider
@riverpod
class VerificationResult extends _$VerificationResult {
  @override
  Future<VerificationResultEntity?> build() async {
    return null;
  }

  Future<void> verifyByQR(String qrData) async {
    state = const AsyncLoading();

    final result = await ref.read(verifyRepositoryProvider).verifyByQR(qrData);

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (verification) => AsyncData(verification),
    );
  }

  Future<void> verifyById(String contentId) async {
    state = const AsyncLoading();

    final result =
        await ref.read(verifyRepositoryProvider).verifyById(contentId);

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (verification) => AsyncData(verification),
    );
  }

  void clear() {
    state = const AsyncData(null);
  }
}

/// Content DNA provider
@riverpod
class ContentDNA extends _$ContentDNA {
  @override
  Future<String?> build(String contentId) async {
    final result =
        await ref.read(verifyRepositoryProvider).getContentDNA(contentId);

    return result.fold(
      (failure) => null,
      (dna) => dna,
    );
  }
}
