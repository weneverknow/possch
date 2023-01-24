import 'package:firebase_core/firebase_core.dart';

class FirebaseOption {
  final bool isAndroid;
  FirebaseOption(this.isAndroid);

  FirebaseOptions? get firebaseOptions => isAndroid
      ? const FirebaseOptions(
          apiKey: "AIzaSyBb2ZvXO6wDutNEzf0l2a4aNoyJUyI276o",
          appId: "1:370174639470:android:2ebf165915f77cce32157f",
          messagingSenderId: "370174639470",
          projectId: "fir-app-afcbe")
      : const FirebaseOptions(
          apiKey: "AIzaSyBb2ZvXO6wDutNEzf0l2a4aNoyJUyI276o",
          appId: "1:370174639470:ios:cbd812213a6d89a132157f",
          messagingSenderId: "370174639470",
          projectId: "fir-app-afcbe");
}
