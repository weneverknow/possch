import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:possch/src/core/firebase_authentication/firebase_authentication.dart';
import 'package:possch/src/core/firestore/firestore_service.dart';

final GetIt sl = GetIt.instance;

setupServiceLocator() {
  sl.registerFactory<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerFactory<FirebaseFirestore>(() => FirebaseFirestore.instance);

  sl.registerLazySingleton<FirebaseAuthentication>(
      () => FirebaseAuthenticationImpl(sl<FirebaseAuth>()));

  sl.registerLazySingleton<FirestoreService>(
      () => FirestoreServiceImpl(sl<FirebaseFirestore>()));
}
