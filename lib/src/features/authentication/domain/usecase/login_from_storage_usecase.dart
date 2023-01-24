import 'package:possch/src/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:possch/src/core/usecase/usecase.dart';
import 'package:possch/src/features/authentication/domain/entities/authentication.dart';
import 'package:possch/src/features/authentication/domain/repository/authentication_repository.dart';

class LoginFromStorageUseCase implements UseCase<Authentication?, NoParam> {
  final AuthenticationRepository repository;
  LoginFromStorageUseCase(this.repository);
  @override
  Future<Either<Failure, Authentication?>> call(NoParam param) async {
    return await repository.loginFromStorage();
  }
}
