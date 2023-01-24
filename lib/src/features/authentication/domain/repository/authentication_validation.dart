import 'package:possch/src/core/validator/string_validator.dart';

class AuthenticationValidation {
  final String email;
  final String password;
  AuthenticationValidation(this.email, this.password);

  StringValidator emailValidator = NonEmptyStrinValidation();
  StringValidator passwordValidator = NonEmptyStrinValidation();
  StringValidator emailFormatValidator = EmailFormatValidation();

  bool get isEmailValid => emailValidator.isValid(email);
  bool get isEmailFormatValid => emailFormatValidator.isValid(email);
  bool get isPasswordValid => passwordValidator.isValid(password);
}
