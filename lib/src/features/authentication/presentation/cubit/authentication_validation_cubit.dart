import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possch/src/features/authentication/domain/repository/authentication_validation.dart';

class AuthenticationValidationCubit extends Cubit<AuthenticationValidation?> {
  AuthenticationValidationCubit() : super(null);

  validate(String email, String password) {
    emit(AuthenticationValidation(email, password));
  }
}
