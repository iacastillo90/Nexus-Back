import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/vibes_entity.dart';
import '../../domain/repositories/vibes_repository.dart';
import '../datasources/vibes_remote_datasource.dart';

/// Implementation of VibesRepository
class VibesRepositoryImpl implements VibesRepository {
  final VibesRemoteDataSource remoteDataSource;

  VibesRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, VibesEntity>> getUserVibes(String userId) async {
    try {
      final model = await remoteDataSource.getUserVibes(userId);
      return Right(model.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, double>>> getCommunityPulse() async {
    try {
      final pulse = await remoteDataSource.getCommunityPulse();
      return Right(pulse);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
