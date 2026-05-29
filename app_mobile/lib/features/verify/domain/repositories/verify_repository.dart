import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/verification_result_entity.dart';

/// Verify repository interface
abstract class VerifyRepository {
  /// Verify content by QR code data
  Future<Either<Failure, VerificationResultEntity>> verifyByQR(String qrData);

  /// Verify content by ID
  Future<Either<Failure, VerificationResultEntity>> verifyById(String contentId);

  /// Get content DNA
  Future<Either<Failure, String>> getContentDNA(String contentId);
}
