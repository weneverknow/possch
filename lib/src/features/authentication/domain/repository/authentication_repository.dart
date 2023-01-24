import 'package:dartz/dartz.dart';

import 'package:possch/src/core/failure/failure.dart';
import 'package:possch/src/features/authentication/domain/entities/authentication.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Authentication?>> loginWithEmail(
      String email, String password);
  Future<Either<Failure, Authentication?>> loginFromStorage();
  Future<void> logout();
}
