import 'package:possch/src/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:possch/src/core/usecase/usecase.dart';
import 'package:possch/src/features/authentication/domain/entities/authentication.dart';
import 'package:possch/src/features/authentication/domain/repository/authentication_repository.dart';

class LoginParam {
  final String email;
  final String password;
  LoginParam(this.email, this.password);
}

class LoginWithEmailUseCase implements UseCase<Authentication?, LoginParam> {
  final AuthenticationRepository repository;
  LoginWithEmailUseCase(this.repository);
  @override
  Future<Either<Failure, Authentication?>> call(LoginParam param) async {
    return await repository.loginWithEmail(param.email, param.password);
  }
}
