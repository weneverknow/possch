import 'package:firebase_auth/firebase_auth.dart';
import 'package:possch/src/core/exceptions/exceptions.dart';
import 'package:possch/src/core/firebase_authentication/firebase_authentication.dart';
import 'package:possch/src/core/storage/shared_preferences_service.dart';

abstract class AuthenticationDatasource {
  Future<User?> loginWithEmail(String email, String password);
  Future<User?> loginFromStorage();
  Future<void> logout();
}

class AuthenticationDatasourceImpl implements AuthenticationDatasource {
  final FirebaseAuthentication firebaseAuthentication;
  final SharedPreferencesService sharedPreferencesService;
  AuthenticationDatasourceImpl(
      this.firebaseAuthentication, this.sharedPreferencesService);
  @override
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      final user = await firebaseAuthentication.signInWithEmail(
          email: email, password: password);
      if (user != null) {
        sharedPreferencesService.add("email", email);
        sharedPreferencesService.add("password", password);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationException(e.message ?? 'User not created');
    }
  }

  @override
  Future<User?> loginFromStorage() async {
    String email = await sharedPreferencesService.getString("email") ?? "";
    String password =
        await sharedPreferencesService.getString("password") ?? "";
    return await loginWithEmail(email, password);
  }

  @override
  Future<void> logout() async {
    await firebaseAuthentication.signOut();
    await sharedPreferencesService.remove("email");
    await sharedPreferencesService.remove("password");
  }
}
