import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/verification_result_entity.dart';
import '../../domain/repositories/verify_repository.dart';
import '../datasources/verify_datasource.dart';

/// Implementation of VerifyRepository
class VerifyRepositoryImpl implements VerifyRepository {
  final VerifyDataSource dataSource;

  VerifyRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, VerificationResultEntity>> verifyByQR(
    String qrData,
  ) async {
    try {
      final model = await dataSource.verifyByQR(qrData);
      return Right(model.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, VerificationResultEntity>> verifyById(
    String contentId,
  ) async {
    try {
      final model = await dataSource.verifyById(contentId);
      return Right(model.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getContentDNA(String contentId) async {
    try {
      final dna = await dataSource.getContentDNA(contentId);
      return Right(dna);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
