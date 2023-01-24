import 'package:possch/src/core/exceptions/exceptions.dart';
import 'package:possch/src/core/failure/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:possch/src/features/authentication/data/datasource/authentication_datasource.dart';
import 'package:possch/src/features/authentication/domain/entities/authentication.dart';

import '/src/features/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDatasource datasource;
  AuthenticationRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, Authentication?>> loginWithEmail(
      String email, String password) async {
    try {
      final result = await datasource.loginWithEmail(email, password);

      if (result == null) {
        return left(FetchFailure("login user failed"));
      }
      return right(Authentication(
        email: result.email,
        documentId: result.uid,
        loggedinTime: DateTime.now(),
      ));
    } on FirebaseAuthenticationException catch (e) {
      return left(FetchFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Authentication?>> loginFromStorage() async {
    try {
      final result = await datasource.loginFromStorage();
      if (result == null) {
        return left(FetchFailure("login user failed"));
      }
      return right(Authentication(
        email: result.email,
        documentId: result.uid,
        loggedinTime: DateTime.now(),
      ));
    } on FirebaseAuthenticationException catch (e) {
      return left(FetchFailure(e.message));
    }
  }

  @override
  Future<void> logout() async {
    await datasource.logout();
  }
}
