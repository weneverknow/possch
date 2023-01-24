import 'package:firebase_auth/firebase_auth.dart';
import 'package:possch/src/core/exceptions/exceptions.dart';
import 'package:possch/src/core/firebase_authentication/firebase_authentication.dart';
import 'package:possch/src/core/firestore/firestore_service.dart';

abstract class RegistrationDatasource {
  Future<User?> createAccount(Map<String, dynamic> body);
  Future<void> createStoreProfile(Map<String, dynamic> body, String docId);
}

class RegistrationDatasourceImpl implements RegistrationDatasource {
  final FirebaseAuthentication firebaseAuthentication;
  final FirestoreService firestoreService;
  RegistrationDatasourceImpl(
      this.firebaseAuthentication, this.firestoreService);

  @override
  Future<User?> createAccount(Map<String, dynamic> body) async {
    try {
      final user = await firebaseAuthentication.createAccountWithEmail(
          email: body['email'], password: body['password']);
      if (user != null) {
        body.removeWhere((key, value) => key == "password");

        await createStoreProfile(body, user.uid);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationException(
          e.message ?? "User not created successfully.");
    }
  }

  @override
  Future<void> createStoreProfile(
      Map<String, dynamic> body, String docId) async {
    return await firestoreService.setData(path: '/store/$docId', body: body);
  }
}
