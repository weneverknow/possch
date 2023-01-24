import 'package:possch/src/core/exceptions/exceptions.dart';
import 'package:possch/src/core/failure/failure.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:dartz/dartz.dart';
import 'package:possch/src/features/registration/data/datasource/registration_datasource.dart';

import '/src/features/registration/domain/repository/registration_repository.dart';

class RegistrationRepositoryImpl implements RegistrationRepository {
  final RegistrationDatasource datasource;
  RegistrationRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, User?>> createAccount(
      Map<String, dynamic> body) async {
    try {
      final result = await datasource.createAccount(body);
      if (result == null) {
        return left(FetchFailure("Create user failed"));
      }
      return right(result);
    } on FirebaseAuthenticationException catch (e) {
      return left(FetchFailure(e.message));
    }
  }

  @override
  Future<void> createStoreProfile(Map<String, dynamic> body) async {
    try {
      return await datasource.createStoreProfile(body, "");
    } catch (e) {
      throw FirestoreException("Store profile not created.");
    }
  }
}
