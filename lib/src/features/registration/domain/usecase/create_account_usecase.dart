import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:possch/src/core/failure/failure.dart';
import 'package:possch/src/core/usecase/usecase.dart';
import 'package:possch/src/features/product_type/domain/entities/product_type.dart';
import 'package:possch/src/features/registration/domain/repository/registration_repository.dart';

class CreateAccountParam {
  final String email;
  final String password;
  final String storeName;
  final ProductType storeType;

  CreateAccountParam(this.email, this.password, this.storeName, this.storeType);

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "store_name": storeName,
        "product_type": storeType.toJson(),
      };
}

class CreateAccountUseCase implements UseCase<User?, CreateAccountParam> {
  final RegistrationRepository repository;
  CreateAccountUseCase(this.repository);
  @override
  Future<Either<Failure, User?>> call(CreateAccountParam param) async {
    return await repository.createAccount(param.toJson());
  }
}
