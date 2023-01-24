import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possch/src/core/cubit/button_pressed_cubit.dart';
import 'package:possch/src/routes.dart';
import 'src/firebase_option.dart';
import 'src/service_locator.dart' as service;

Future<void> main() async {
  service.setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOption(Platform.isAndroid).firebaseOptions);

  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({this.initialLink, super.key});
  final String? initialLink;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ButtonPressedCubit()),
      ],
      child: MaterialApp.router(
        title: 'PosSch',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xfff4f3f4),
            ),
            scaffoldBackgroundColor: const Color(0xff060507)),
        routerConfig: routes(initialLink: initialLink),
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    print("bloc ${bloc.runtimeType} $change");
    super.onChange(bloc, change);
  }
}
