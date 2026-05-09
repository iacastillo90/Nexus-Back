import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/dream_entity.dart';
import '../entities/dream_contribution_entity.dart';

/// Dreams repository interface
abstract class DreamsRepository {
  /// Get dreams list
  Future<Either<Failure, List<DreamEntity>>> getDreams({
    DreamStatus? status,
    int offset = 0,
    int limit = 20,
  });

  /// Get dream by ID
  Future<Either<Failure, DreamEntity>> getDream(String dreamId);

  /// Get dream contributions
  Future<Either<Failure, List<DreamContributionEntity>>> getDreamContributions(
    String dreamId,
  );

  /// Create dream
  Future<Either<Failure, DreamEntity>> createDream({
    required String title,
    required String description,
    required int maxContributions,
    List<String>? tags,
  });

  /// Add contribution to dream
  Future<Either<Failure, DreamContributionEntity>> addContribution({
    required String dreamId,
    required String content,
  });

  /// Like dream
  Future<Either<Failure, void>> likeDream(String dreamId);

  /// Like contribution
  Future<Either<Failure, void>> likeContribution(String contributionId);
}
