import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/vibes_entity.dart';

/// Vibes repository interface
abstract class VibesRepository {
  /// Get user vibes (sentiment analysis)
  Future<Either<Failure, VibesEntity>> getUserVibes(String userId);

  /// Get community pulse (aggregated vibes)
  Future<Either<Failure, Map<String, double>>> getCommunityPulse();
}
