import 'package:possch/src/features/registration/domain/repository/registration_repository.dart';

class CreateStoreProfileUseCase {
  final RegistrationRepository repository;
  CreateStoreProfileUseCase(this.repository);

  Future<void> create(Map<String, dynamic> body) async {
    return await repository.createStoreProfile(body);
  }
}
