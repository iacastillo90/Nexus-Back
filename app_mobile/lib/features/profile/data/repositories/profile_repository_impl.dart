import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/karma_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_datasource.dart';

/// Implementation of ProfileRepository
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource profileDataSource;

  ProfileRepositoryImpl({
    required this.profileDataSource,
  });

  @override
  Future<Either<Failure, ProfileEntity>> getProfile(String userId) async {
    try {
      final profile = await profileDataSource.getProfile(userId);
      return Right(profile.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> getCurrentProfile() async {
    try {
      final profile = await profileDataSource.getCurrentProfile();
      return Right(profile.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    String? bio,
    String? location,
    String? website,
    String? avatarPath,
    String? coverImagePath,
  }) async {
    try {
      // TODO: Upload images to Cloudinary if paths provided
      // For now, just update with URLs
      final profile = await profileDataSource.updateProfile(
        bio: bio,
        location: location,
        website: website,
        avatarUrl: avatarPath,
        coverImageUrl: coverImagePath,
      );
      return Right(profile.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> followUser(String userId) async {
    try {
      await profileDataSource.followUser(userId);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> unfollowUser(String userId) async {
    try {
      await profileDataSource.unfollowUser(userId);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, KarmaEntity>> getKarmaDetails(String userId) async {
    try {
      final karma = await profileDataSource.getKarmaDetails(userId);
      return Right(karma.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
