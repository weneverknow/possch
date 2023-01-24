import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:possch/src/core/failure/failure.dart';

abstract class RegistrationRepository {
  Future<Either<Failure, User?>> createAccount(Map<String, dynamic> body);
  Future<void> createStoreProfile(Map<String, dynamic> body);
}
