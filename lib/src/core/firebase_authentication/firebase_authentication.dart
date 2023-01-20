import 'package:firebase_auth/firebase_auth.dart';
import 'package:possch/src/core/exceptions/exceptions.dart';

abstract class FirebaseAuthentication {
  User? get currentUser;
  Future<void> signOut();
  Future<User?> signInWithEmail({
    required String email,
    required String password,
  });
  Stream<User?> authStateChange();
  Future<User?> createAccountWithEmail({
    required String email,
    required String password,
  });
}

class FirebaseAuthenticationImpl implements FirebaseAuthentication {
  FirebaseAuth firebaseAuth;
  FirebaseAuthenticationImpl(this.firebaseAuth);
  @override
  Stream<User?> authStateChange() {
    return firebaseAuth.authStateChanges();
  }

  @override
  Future<User?> createAccountWithEmail(
      {required String email, required String password}) async {
    final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  @override
  // TODO: implement currentUser
  User? get currentUser => firebaseAuth.currentUser;

  @override
  Future<User?> signInWithEmail(
      {required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationException(e.message ?? "user not found");
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
