import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/registration_account_validation.dart';

class AccountValidationCubit extends Cubit<RegistrationAccountValidation?> {
  AccountValidationCubit() : super(null);

  validate(String email, String password) {
    emit(RegistrationAccountValidation(email, password));
  }
}
