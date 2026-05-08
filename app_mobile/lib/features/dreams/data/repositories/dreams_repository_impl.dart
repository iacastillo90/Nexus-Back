import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/dream_entity.dart';
import '../../domain/entities/dream_contribution_entity.dart';
import '../../domain/repositories/dreams_repository.dart';
import '../datasources/dreams_datasource.dart';

/// Implementation of DreamsRepository
class DreamsRepositoryImpl implements DreamsRepository {
  final DreamsDataSource dataSource;

  DreamsRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<DreamEntity>>> getDreams({
    DreamStatus? status,
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final statusString = status != null ? _statusToString(status) : null;

      final models = await dataSource.getDreams(
        status: statusString,
        offset: offset,
        limit: limit,
      );

      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DreamEntity>> getDream(String dreamId) async {
    try {
      final model = await dataSource.getDream(dreamId);
      return Right(model.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DreamContributionEntity>>> getDreamContributions(
    String dreamId,
  ) async {
    try {
      final models = await dataSource.getDreamContributions(dreamId);
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DreamEntity>> createDream({
    required String title,
    required String description,
    required int maxContributions,
    List<String>? tags,
  }) async {
    try {
      final model = await dataSource.createDream(
        title: title,
        description: description,
        maxContributions: maxContributions,
        tags: tags,
      );

      return Right(model.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DreamContributionEntity>> addContribution({
    required String dreamId,
    required String content,
  }) async {
    try {
      final model = await dataSource.addContribution(
        dreamId: dreamId,
        content: content,
      );

      return Right(model.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> likeDream(String dreamId) async {
    try {
      await dataSource.likeDream(dreamId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> likeContribution(String contributionId) async {
    try {
      await dataSource.likeContribution(contributionId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  String _statusToString(DreamStatus status) {
    switch (status) {
      case DreamStatus.active:
        return 'active';
      case DreamStatus.completed:
        return 'completed';
      case DreamStatus.archived:
        return 'archived';
    }
  }
}
