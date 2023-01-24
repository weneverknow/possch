import 'package:possch/src/features/authentication/domain/repository/authentication_repository.dart';

class LogoutUseCase {
  final AuthenticationRepository repository;
  LogoutUseCase(this.repository);

  Future<void> logout() async {
    return await repository.logout();
  }
}
