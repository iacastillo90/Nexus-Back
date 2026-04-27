import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';

/// Use case for user registration
class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, AuthResponseEntity>> call({
    required String username,
    required String email,
    required String password,
  }) async {
    return await repository.register(
      username: username,
      email: email,
      password: password,
    );
  }
}
